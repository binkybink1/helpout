# TASKS.md — Find Help LA
*Updated: April 1, 2026 (session 2)*

Keep this file current. When a task is done, move it to Completed with a date.
When a new task is identified, add it to the right section.

---

## 🔴 Alison — Action Required
*Things only Alison can do. Claude is blocked until these are done.*

- [ ] **Create Supabase account** — supabase.com, sign up with GitHub. Then run `database/schema.sql` and `database/seed.sql` in the SQL Editor. Get the Project URL and anon key. (See SETUP-GUIDE.md Steps 2–4)
- [ ] **Create Vercel account** — vercel.com, sign up with GitHub. (See SETUP-GUIDE.md Step 6)
- [ ] **Create GitHub repository** — name it `helpout`, upload `find-help-la.html` renamed as `index.html`. (See SETUP-GUIDE.md Step 1)
- [ ] **Send 211 API application email** — template ready in `211-API-Application.md`. Send to info@211la.org. Takes 5 minutes.
- [ ] **Buy domain** — findhelpla.org recommended. ~$15/year at namecheap.com. (See SETUP-GUIDE.md Step 7)
- [ ] **Update HTML with Supabase keys** — after Supabase is set up, add Project URL and anon key to `find-help-la.html` (see SETUP-GUIDE.md Step 5)
- [ ] **Set up Coinbase Commerce account** — for crypto donations. coinbase.com/commerce

---

## 🟡 Claude — Build Queue
*Ordered by priority. Work top-to-bottom unless Alison redirects.*

### Now

### Next
- [ ] **Donation page** — `donate.html` + `design/pages/donate.html` — Stripe embed, CashApp/PayPal/Venmo links, Coinbase Commerce link. Copy to run through `stop-slop`.
- [ ] **Admin review dashboard** — `admin.html` — password-protected, shows pending submissions, approve/reject buttons, connects to Supabase
- [ ] **Submission email notifications** — Supabase Edge Function + Resend integration. Triggers when a submission is received.
- [ ] **Geocoding on submission** — Vercel Function that converts submitted address to lat/lng via Nominatim on insert

### Later (requires Supabase to be live)
- [ ] **Connect HTML to live Supabase** — update index.html with real keys after Alison sets up Supabase
- [ ] **Resend account setup instructions** — guide for Alison to set up email notifications
- [ ] **Google Sheets bulk import template** — pre-formatted sheet for Alison to use for data research

### V2 (after 211 API approved)
- [ ] **211 API proxy** — Vercel Function that proxies 211 API calls, handles auth and rate limiting
- [ ] **Supabase cache table** — schema addition for caching 211 API responses by zip code
- [ ] **Location search** — replace static LA map with zip code / geolocation search for any US location
- [ ] **SAMHSA API integration** — mental health and substance use services (free API, no approval needed)

---

## 🟢 Completed

- [x] **Prototype HTML** — `find-help-la.html` — 23 real LA services, Leaflet map, filters, search, submission form (April 1, 2026)
- [x] **Supabase integration in HTML** — live fetch with hardcoded fallback (April 1, 2026)
- [x] **PRD** — `docs/PRD-FindHelpLA.md` (April 1, 2026)
- [x] **Tech Design & Architecture** — `docs/TechDesign-FindHelpLA.md` (April 1, 2026)
- [x] **Setup Guide** — `SETUP-GUIDE.md` (April 1, 2026)
- [x] **SQL schema** — `database/schema.sql` (April 1, 2026)
- [x] **SQL seed data** — `database/seed.sql` — 23 services (April 1, 2026)
- [x] **211 API application draft** — `211-API-Application.md` (April 1, 2026)
- [x] **CLAUDE.md** — project instructions (April 1, 2026)
- [x] **TASKS.md** — this file (April 1, 2026)
- [x] **Design system v2** — `design/system.html` — DM Sans, dark sidebar tokens, new popup/list panel components (April 1, 2026)
- [x] **find-help-la.html v2 redesign** — updated to v2 design system: DM Sans, new tokens, list panel with status dots, v2 popup format, loading/empty states (April 1, 2026)
- [x] **Light/dark mode** — Daybreak Sanctuary (light) + Midnight Refuge (dark) themes applied; toggle button in topbar; dark map tiles; preference persisted to localStorage (April 1, 2026)
- [x] **Repo renamed to helpout** — all docs updated to reflect GitHub repo name `helpout` (April 1, 2026)
- [x] **Home page design expression** — `design/pages/home.html` — desktop + mobile layouts with annotations (April 1, 2026)

---

## 💬 Open Questions
*Decisions still needed. These should shrink over time.*

1. **Site name for nationwide expansion** — "Find Help LA" doesn't scale nationally. Does it become "Find Help" with city subdomains? Or a different name entirely?
2. **Who reviews submissions?** Only Alison for now? Will there be community moderators?
3. **Spanish language** — when does this happen? LA's hardest-hit communities are heavily Spanish-speaking. This is a real gap.
4. **Analytics** — Vercel has built-in analytics (free). Simple Plausible or Fathom for privacy-respecting tracking? Needs a decision before launch so it's set up from day one.
5. **About page / founder story** — Alison's story is the reason this site exists and will build trust with users and donors. Worth a page. Alison needs to decide if she wants to share it.

---

## 📋 Running Notes

**Data quality reminder:** Never publish a listing without a verified address and phone number. A wrong address sends someone in crisis to the wrong place. That's worse than no listing.

**211 API timeline:** Application sent [date TBD]. Follow up after 2 weeks if no response.

**Domain DNS propagation:** After buying domain and connecting to Vercel, allow 10–30 minutes before the site is accessible at the new URL.
