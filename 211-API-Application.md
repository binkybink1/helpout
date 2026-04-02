# 211 API Access — Application Guide

## Who to Contact

There are two paths. Start both at the same time.

---

### Path 1 — 211 LA (Local, Fastest)

211 LA operates the 211 system specifically for Los Angeles County. Getting access through them is faster than going through the national organization and gives you the most complete LA-specific data.

**Contact:**
- Website: https://211la.org
- Email: info@211la.org
- Phone: (800) 339-6993

**What to say:** Use the email template below.

---

### Path 2 — United Way (National API, Slower)

For the nationwide V2, you'll need access through the national 211 network. United Way coordinates developer access.

- Website: https://www.unitedway.org
- Developer/API inquiries: Use their contact form at unitedway.org/contact
- Also try: https://apiportal.211.org (some regions have a self-serve API portal)

---

## Email Template — Send to 211 LA First

**To:** info@211la.org
**Subject:** API Access Request — Community Resource Map for LA County

---

Hi,

My name is Alison Grippo. I'm a Los Angeles resident building a free, public web tool to help people in need find community resources across LA County — food banks, shelters, free clinics, government benefits, and financial assistance.

The project is called Find Help LA (findhelpla.org). It's a personal humanitarian initiative, not a for-profit company. The site is free to use with no ads. It was built in direct response to the current economic conditions in LA, and from personal experience — I went through a period of financial hardship and had no idea what resources were available to me. I don't want that to happen to anyone else.

I'm writing to request API access to the 211 LA database so that the resource listings on Find Help LA can stay current and comprehensive without requiring manual updates. Specifically, I'm hoping to:

- Query services by location (lat/lng + radius) to show resources near a user
- Filter by service category (food, shelter, health, government benefits, financial)
- Display name, address, phone number, hours, and description for each result

I'm happy to:
- Attribute 211 LA prominently on the site
- Link back to 211la.org and include the 211 hotline number
- Share traffic data and usage metrics if that's useful to you
- Abide by any terms of use or data sharing agreement you require

The current prototype is live and serving real users. I want to make sure the data it shows is as accurate and complete as possible, which is why I'm reaching out to you directly.

Would you be able to connect me with the right person on your team to discuss API access?

Thank you for the work you do,

Alison Grippo
alison.grippo@gmail.com
[findhelpla.org when live]

---

## What to Expect

**211 LA response time:** Usually 3–10 business days. If you don't hear back in two weeks, follow up once.

**What they'll likely ask for:**
- A description of your project and how the data will be used
- Confirmation that you won't resell the data
- Agreement to their terms of service
- Possibly a demo of the current site

**What you'll get:**
- An API endpoint (usually REST)
- An API key
- Documentation on available fields and rate limits

---

## While You Wait

The site works without the 211 API — it uses the 23 manually-curated services already in the database. Use this time to:

1. Expand the manual database using Google Sheets bulk import
2. Set up Supabase and Vercel (see SETUP-GUIDE.md)
3. Build the submission review dashboard
4. Add the donation page

The 211 API is a multiplier on top of a working foundation — you don't need it to launch.

---

## When You Get Access

Once 211 LA grants API access, the tech doc (TechDesign-FindHelpLA.md) covers exactly how to integrate it: the proxy layer in Vercel Functions, the caching strategy in Supabase, and the data normalization logic. Share that document with whoever helps you build the integration.
