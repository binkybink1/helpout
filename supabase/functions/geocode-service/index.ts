// ============================================================
// Find Help LA — Geocoding Edge Function
// Triggered by a Supabase database webhook on INSERT to services
// Calls Nominatim to get lat/lng for any record missing coordinates
// ============================================================

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const payload = await req.json()

    // Supabase database webhooks send: { type, table, schema, record, old_record }
    const record = payload.record

    if (!record) {
      return new Response(JSON.stringify({ error: 'No record in payload' }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // Skip if coordinates are already set
    if (record.lat !== null && record.lat !== undefined &&
        record.lng !== null && record.lng !== undefined) {
      return new Response(JSON.stringify({ message: 'Coordinates already present, skipping' }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    const address = record.address
    if (!address) {
      return new Response(JSON.stringify({ error: 'No address on record' }), {
        status: 422,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    // Nominatim geocoding — free, no API key required
    // Use the address as-is — research tool includes city/state so Nominatim can resolve any US location
    const query = encodeURIComponent(address)
    const nominatimUrl = `https://nominatim.openstreetmap.org/search?q=${query}&format=json&limit=1`

    const geocodeRes = await fetch(nominatimUrl, {
      headers: {
        // Nominatim requires a descriptive User-Agent — do not remove
        'User-Agent': 'FindHelpLA/1.0 (alison.grippo@gmail.com)',
      },
    })

    const geocodeData = await geocodeRes.json()

    if (!geocodeData || geocodeData.length === 0) {
      console.error(`Nominatim could not geocode: ${address}`)
      return new Response(JSON.stringify({ error: `Could not geocode address: ${address}` }), {
        status: 422,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      })
    }

    const lat = parseFloat(geocodeData[0].lat)
    const lng = parseFloat(geocodeData[0].lon)

    // Update the record with coordinates using the service role key
    // (bypasses RLS so the function can write even though the user is not authenticated)
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    )

    const { error: updateError } = await supabase
      .from('services')
      .update({ lat, lng })
      .eq('id', record.id)

    if (updateError) {
      throw updateError
    }

    console.log(`Geocoded "${address}" → ${lat}, ${lng}`)

    return new Response(JSON.stringify({ success: true, id: record.id, lat, lng }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })

  } catch (err) {
    console.error('Geocoding error:', err)
    return new Response(JSON.stringify({ error: err.message }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    })
  }
})
