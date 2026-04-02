# Tech Design & Architecture — Find Help LA
**Status:** Draft
**Author:** Alison Grippo | **Last updated:** April 1, 2026
**Version:** 0.1 — Covers V1 (LA) and V2 (Nationwide) architecture

---

## Summary

This document covers the technical architecture for Find Help LA from its current prototype state through a production V1 and a nationwide V2. The guiding constraint is that this is a social good project — the architecture should be low-cost, maintainable by a small team, and never go down when someone needs it most.

---

## Current State (Prototype)

A single HTML file. All data is hardcoded as a JavaScript array. No backend. No database. No server.

**What it can do:** Demo. Share. Validate the concept.
**What it cannot do:** Accept community submissions, stay current, scale to more cities, be maintained without editing code.

---

## Phase 1: Production V1 — LA County

### Goals
- Move data out of the HTML file into a real database
- Accept and review community submissions
- Host reliably
- Keep costs near zero

### Recommended Stack

#### Frontend
**Leaflet.js + Vanilla JS or lightweight framework**

Stay with Leaflet. It's free, has no API key requirement, and is more than capable. Avoid pulling in React or Vue for V1 — the added complexity isn't justified yet. The current HTML prototype is 90% of what V1 needs on the front end.

**Hosting:** Vercel (free tier is more than sufficient — static sites deploy in seconds, unlimited bandwidth on free tier, custom domain support)

#### Backend

**Recommendation: Supabase**

Supabase is an open-source Firebase alternative built on Postgres. Here's why it's the right call for this project:

- **Free tier is generous** — 500MB database, 2GB file storage, 50,000 monthly active users, no expiration
- **Gives you a database + REST API automatically** — create a table for services, get a fully functional REST API with no code written
- **Built-in Auth** — you'll need this for an admin review queue (you don't want just anyone publishing submissions)
- **Row-level security** — you can make service listings publicly readable but write-protected
- **Real-time subscriptions** — useful later if you want the map to update without refresh
- **You own your data** — unlike Firebase, you can export everything and self-host if needed

**What Supabase handles:**
- Storing all service listings (replaces the hardcoded JS array)
- Storing incoming submissions in a pending queue
- Admin login to approve/reject submissions

**Alternative if Supabase feels like too much:** Airtable with their API. Slower, less scalable, but you can manage data in a spreadsheet UI without touching code. Good for a first pass before building proper admin tools.

#### Submission Review Workflow

```
User submits form
    → POST to Supabase "submissions" table (status: "pending")
    → Email notification to admin (via Supabase Edge Function + Resend or Postmark)
Admin logs into review dashboard (simple password-protected page)
    → Approves: row moves to "services" table, appears on map
    → Rejects: row deleted or marked rejected
```

The review dashboard can be a very simple HTML page with Supabase auth. It does not need to be a full-blown admin panel on day one.

#### Email
**Resend** (free tier: 100 emails/day) — for submission notifications to admin and confirmation to submitters. Simple API, integrates with Supabase Edge Functions cleanly.

---

### Data Model (V1)

#### `services` table (published, live on map)

| Column | Type | Notes |
|---|---|---|
| id | uuid | primary key |
| name | text | required |
| category | enum | food, shelter, health, government, financial |
| address | text | required |
| lat | float | geocoded on insert |
| lng | float | geocoded on insert |
| phone | text | |
| hours | text | |
| description | text | |
| website | text | |
| verified_at | timestamp | when data was last confirmed current |
| created_at | timestamp | |
| source | text | 'manual', '211_api', 'community' |

#### `submissions` table (pending review)

| Column | Type | Notes |
|---|---|---|
| id | uuid | primary key |
| name | text | |
| category | text | |
| address | text | |
| phone | text | |
| hours | text | |
| website | text | |
| notes | text | submitter's free text |
| submitter_email | text | optional — for follow-up |
| status | enum | pending, approved, rejected |
| submitted_at | timestamp | |
| reviewed_at | timestamp | |

---

### Geocoding

When a new service is added (manually or via submission), the address needs lat/lng coordinates for the map.

**Option A: Nominatim (OpenStreetMap)** — Free, no API key, rate-limited to 1 request/second. Fine for manual additions and low-volume submissions. Use this first.

**Option B: Google Geocoding API** — More accurate, especially for partial or ambiguous US addresses. $5 per 1,000 requests. Bring this in if Nominatim quality is a problem.

Geocoding should happen server-side (in a Supabase Edge Function or Vercel Function) when a record is inserted — not in the browser.

---

### Architecture Diagram (V1)

```
                    ┌─────────────────────────┐
                    │     User's Browser       │
                    │  (HTML + Leaflet.js)      │
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │      Vercel CDN          │
                    │  (static files + fns)    │
                    └────────────┬────────────┘
                                 │
               ┌─────────────────┼─────────────────┐
               │                 │                 │
   ┌───────────▼──────┐  ┌──────▼────────┐  ┌────▼──────────────┐
   │   Supabase DB     │  │   Geocoding   │  │   Resend Email    │
   │ (services table   │  │   (Nominatim  │  │ (submission       │
   │  submissions      │  │   or Google)  │  │  notifications)   │
   │  table)           │  └───────────────┘  └───────────────────┘
   └───────────────────┘
```

---

## Phase 2: Nationwide (V2)

### What Changes

The core front end stays the same. The map, filters, cards, and submission form are all reusable. What changes is where the data comes from.

### 211 API Integration

The 211 network (United Way) is the authoritative nationwide database of social services. It covers all 50 states and is updated by local 211 operators.

**How to get access:**
1. Apply through United Way of America — they have a developer program
2. Identify which 211 network covers your target area (there are regional operators)
3. Most access for public-good projects is free or low-cost

**Key endpoints you'll use:**
- Search by lat/lng + radius → returns services within X miles
- Search by category → filter to food, shelter, etc.
- Get service detail → name, address, phone, hours, description

**Data standard:** Most 211 systems return data in **HSDS format** (Human Services Data Specification — an open standard). Your data model above is already HSDS-compatible.

**Alternative / supplemental sources:**
- Findhelp.org API — more comprehensive, commercial, used by hospitals and insurers
- SAMHSA Treatment Locator API — mental health and substance use, free
- USDA Food & Nutrition Service — food programs specifically
- HUD Exchange — HUD-funded homeless services

### Caching Strategy

You cannot call the 211 API on every map load. It's slow and has rate limits.

**Approach:**
1. When a user searches by location, query the 211 API once
2. Cache the results in your Supabase database with the zip code + timestamp as the key
3. On subsequent requests for the same zip, serve from cache
4. Cache TTL: 24 hours (social services data doesn't change daily)
5. Allow manual cache invalidation for known stale records

```
User enters zip → Check cache in Supabase
    → Cache hit (< 24h old): serve cached results
    → Cache miss: query 211 API → store in cache → serve results
```

### Architecture Diagram (V2)

```
                    ┌─────────────────────────┐
                    │     User's Browser       │
                    │  (HTML + Leaflet.js)      │
                    └────────────┬────────────┘
                                 │
                    ┌────────────▼────────────┐
                    │     Vercel Functions     │
                    │  (API proxy layer)       │
                    └────┬──────────────┬─────┘
                         │              │
            ┌────────────▼───┐   ┌──────▼──────────────┐
            │  Supabase DB   │   │   External APIs      │
            │  - cache table │   │   - 211 API          │
            │  - curated     │◄──│   - SAMHSA           │
            │    listings    │   │   - USDA             │
            │  - submissions │   └──────────────────────┘
            └────────────────┘
```

**Why a proxy layer?** You don't want to call 211 directly from the browser — it would expose your API key and you'd have no control over rate limiting. All external API calls go through a Vercel Function that handles auth, caching, and normalization.

---

## Non-Functional Requirements

### Performance
- Map should be interactive within 2 seconds on 4G
- Service list should render within 1 second of filter change
- Works on a 5-year-old Android phone on a slow connection

### Availability
- Vercel free tier has 99.99% uptime SLA on CDN-served content
- Supabase free tier has no uptime SLA — acceptable for V1, upgrade for V2
- If Supabase is down, the site should degrade gracefully (show cached data or a friendly error — never a blank screen)

### Cost
- V1 target: $0/month until meaningful scale
- V2 target: Under $50/month up to 100k monthly users
- The 211 API, Nominatim, Supabase free tier, and Vercel free tier get you very far before any cost kicks in

### Security
- Service data is public — no auth needed to read
- Write operations (submissions) are unauthenticated but gated by review queue
- Admin review dashboard requires Supabase Auth login
- No PII stored beyond optional submitter email

---

## Bulk Data Import

This is a first-class requirement, not an afterthought. The database will start sparse and needs a fast, repeatable way to add lots of places.

### The Workflow Problem

You'll be doing research — searching Google, visiting org websites, calling places to verify hours — and accumulating a list of services faster than you can add them one at a time through a web form. You need a bulk path.

### Recommended Approach: Google Sheets → Supabase

**Why Google Sheets as the staging layer:**
- You already know how to use it
- You can do research and data entry in the same tool
- Easy to share with anyone helping you catalog (volunteers, interns, community orgs)
- Columns map directly to your database schema
- Supabase can sync from a CSV export with one click — or you automate it

**The sheet schema** (mirrors the services table exactly):

| name | category | address | phone | hours | description | website | notes |
|---|---|---|---|---|---|---|---|
| World Harvest Food Bank | food | 3950 Valhalla Dr, Burbank... | (818) 556-2400 | Mon–Fri 9am–4pm | Grocery distributions... | worldharvestfoodbank.org | Verify hours |

**Import flow:**
1. Research and fill in the Google Sheet
2. Export as CSV
3. Import to Supabase via their dashboard (drag and drop, column mapping, done)
4. Supabase auto-geocodes addresses on insert (via Edge Function)
5. Rows appear on the map

**Automation option (later):** A Supabase Edge Function can watch a Google Sheet via the Sheets API and sync automatically on a schedule. You'd mark rows as "ready" in a status column and they'd appear on the map without a manual import step. This is worth building once the sheet has 50+ rows and you're updating it frequently.

### Bulk Import Template

The Google Sheet should have these columns and nothing else:

```
name | category | address | city | state | zip | phone | hours | description | website | status | notes
```

Where:
- `category` must be one of: food / shelter / health / government / financial
- `status` must be one of: draft / ready / published / needs_verification
- `notes` is for your own research notes — not shown publicly

You filter to `status = ready` before each import run.

### Data Research Process (Suggested)

1. Start with category-based searches ("food banks Los Angeles 2025")
2. Cross-reference with: findhelp.org, 211la.org, lapl.org/homeless-resources, and Google Maps
3. For each entry: verify the address exists, check that hours are current (call if needed)
4. Mark verified rows as "ready" — don't import unverified addresses, they damage trust
5. Import in batches by category or region

### Quality Standard

A listing should only go live if you have confirmed: name, address, phone, and at least a rough description. Hours are important but can be marked "Call to confirm" if you can't verify. A wrong address is worse than a missing one.

---

## Donation Stack

This project accepts voluntary community support. No nonprofit registration. No government paperwork. The technical lift is minimal.

### Payment Channels

| Channel | Fee | Integration | Best For |
|---|---|---|---|
| Stripe | 2.9% + $0.30 | Embed on donation page | Credit/debit card donors |
| CashApp | 0% (personal) | Just publish $cashtag | Mobile-first, quick givers |
| PayPal.me | 0% (personal) | Just publish link | Broad audience, international |
| Venmo | 0% (personal) | Just publish handle | Younger donors |
| Bitcoin wallet | 0% (gas paid by sender) | Publish address | Crypto holders |
| Ethereum wallet | 0% (gas paid by sender) | Publish address | Crypto holders |
| Coinbase Commerce | 1% | Hosted page, multi-coin | Cleaner crypto UX |

### What to Build

A simple `/donate` page (or section) with:

1. A short, honest paragraph — "This is a personal project. Donations cover hosting and data maintenance. Not tax-deductible."
2. Stripe payment element (handles cards, Apple Pay, Google Pay automatically)
3. CashApp $cashtag, PayPal.me link, Venmo handle — displayed as simple tappable buttons, no integration needed
4. Bitcoin and Ethereum wallet addresses with copy-to-clipboard — or a Coinbase Commerce link if you want a cleaner flow

That's the entire donation system. No backend work beyond the Stripe integration.

### Stripe Integration

Stripe has two approaches:

**Stripe Payment Links** — zero code. You create a payment link in the Stripe dashboard, embed a button on the page. Done in 10 minutes. Fine for V1.

**Stripe Elements** — a small amount of code, gives you a proper embedded payment form that feels native to the site. Better for V2 when design matters more.

Start with Payment Links. Upgrade to Elements when you redesign the site.

### Crypto Wallet Setup

**Decided: Coinbase Commerce.** 1% fee per transaction. Accepts Bitcoin, Ethereum, USDC, and other major coins. Provides a hosted donation page and handles wallet management. No need to manage raw wallet addresses manually.

Setup:
1. Create a Coinbase Commerce account (coinbase.com/commerce)
2. Connect a Coinbase wallet to receive funds
3. Generate a payment link or embed the payment button on the donate page
4. Funds land in the Coinbase wallet and can be converted to USD or held as crypto

QR codes are generated automatically by Coinbase Commerce — useful for mobile donors.

### Tax Note

At $600+ received in a year across Stripe, PayPal, and CashApp, expect 1099 forms. That income is taxable. Track it. Crypto received is also taxable income at the fair market value when received.

**If the project grows large:** Open Collective is the decided path. They provide fiscal sponsorship — donors get tax deductibility, the project gets a nonprofit umbrella, no government registration required. 8% platform fee. No other options need to be evaluated.

---

## Build Sequence

This is the order to build things in. Don't jump ahead.

**Step 1:** Move hardcoded data to Supabase. Replace the JS array with a fetch call to the Supabase REST API. Site works exactly the same but data lives in a real database. (1–2 days)

**Step 2:** Build submission handling. Form POSTs to Supabase submissions table. Email notification to admin. (1 day)

**Step 3:** Build admin review interface. Simple password-protected page. Approve/reject submissions. (1–2 days)

**Step 4:** Add geocoding on submission. When someone submits an address, auto-convert to lat/lng. (1 day)

**Step 5:** Add donation page. Stripe Payment Link, peer-to-peer handles, wallet addresses. (half a day)

**Step 6:** Add last-verified timestamps and display them on listings. Trust depends on knowing how fresh the data is. (1 day)

**Step 7 (V2):** Apply for 211 API access. Build the proxy layer. Add caching. Roll out to first additional city. (1–2 weeks)

---

## Open Technical Questions

1. **Who owns and manages the Supabase account?** Someone needs to be the technical admin. If this is a solo project, that's you.
2. **What's the geocoding fallback when an address can't be matched?** Need a defined behavior — probably: accept the submission but flag it for manual lat/lng entry.
3. **How do you handle the 211 API's data quality gaps?** The 211 database has known gaps — hours are often wrong, some listings are years stale. You'll want a mechanism to override or flag 211 data with manually-verified records.
4. **Do you want to self-host eventually?** The Supabase free tier has limits. If this scales significantly, you'll want to evaluate whether to move to a paid Supabase plan, self-host Supabase on a VPS, or migrate to something else.
5. **What's the mobile app strategy?** The site works fine as a mobile web app. A native iOS/Android app adds significant complexity. Recommend staying web-only until there's strong evidence users want an installed app.
