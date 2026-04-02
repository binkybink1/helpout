# PRD — Find Help LA (Community Resource Finder)
**Status:** Draft
**Author:** Alison Grippo | **Last updated:** April 1, 2026
**Version:** 0.1 — Prototype to V1

---

## Context

People experiencing financial hardship — job loss, eviction, medical crisis, food insecurity — often don't know what free community resources exist near them. The information is fragmented across government websites, nonprofit directories, and word of mouth. In a crisis moment, navigating that is too hard.

This product exists because no one should be in a bad situation and not know help is available. The founder experienced this directly.

---

## Problem Statement

**User:** Anyone in LA County experiencing economic hardship — job loss, food insecurity, housing instability, inability to access healthcare or benefits.

**The situation:** At or near a crisis point, searching for help.

**The pain:** Resources exist but are invisible. Government benefit sites are confusing. Nonprofit directories are fragmented. Search results are unreliable. There is no single, trustworthy, human-readable map of "what is free and near me."

**Current behavior:** People call 211 (if they know it exists), Google fragments of a query, ask on social media, or give up. Many don't know they qualify for programs like CalFresh or Medi-Cal.

**Cost of insolving:** People go without food, lose housing, delay healthcare, miss benefits they're entitled to. The gap between available help and people who reach it is large and measurable in human suffering.

**Success looks like:** A person in crisis opens the site on their phone, sees what's near them within 30 seconds, gets directions or a phone number in one tap.

---

## Goals

**User goal:** Find a relevant nearby resource — food, shelter, healthcare, government benefits, financial help — quickly and without confusion.

**Project goal:** Build and maintain the most complete, accurate, and accessible community resource map in LA (then nationwide). This is a personal humanitarian initiative — not a nonprofit, not a business. No government registration. The goal is to help people, sustain itself through voluntary community support, and grow on its own merits.

**Non-goals:**
- This is not a replacement for 211 — it complements it
- This is not a social network or community forum (V1)
- This does not verify service availability in real time (V1)

---

## Users

**Primary:** People actively in crisis or recently destabilized — job loss, eviction, food insecurity, medical emergency. Often on mobile. May have limited data. May be stressed and not thinking clearly. Design for the worst moment, not the best.

**Secondary:** Case workers, social workers, community organizers who refer clients to services. They need reliable, exportable data.

**Tertiary:** People who want to proactively know what's available before they need it.

---

## User Stories

**As someone who just lost my job,**
I want to find food banks near my zip code,
So that I can feed my family this week without knowing the system.

**As someone experiencing homelessness,**
I want to find shelter options near where I am right now,
So that I have a safe place to sleep tonight.

**As an uninsured person with a health problem,**
I want to find free clinics near me,
So that I can get care without going into debt.

**As someone who doesn't know what benefits I qualify for,**
I want to find the nearest DPSS office and understand what I can apply for,
So that I can access programs I'm entitled to.

**As a community organizer,**
I want to suggest a new resource to the map,
So that more people in my community can find it.

---

## Functional Requirements

### Map & Search
- [ ] Interactive map centered on user's location (zip entry or geolocation)
- [ ] Color-coded pins by service category
- [ ] Clicking a pin opens a detail popup: name, address, phone, hours, description, directions link
- [ ] Filter by category (Food, Shelter, Healthcare, Government, Financial)
- [ ] Text search across name, description, and address
- [ ] Mobile-responsive — must be fully functional on a phone with one thumb

### Service Listings
- [ ] Each listing includes: name, category, address, phone, hours, description, website link
- [ ] "Get Directions" opens native map app on mobile, Google Maps on desktop
- [ ] "Call" is a tap-to-call link on mobile
- [ ] Listings show when data was last verified (V2 — needed for trust)

### Community Submissions
- [ ] Any user can submit a new location via form (name, category, address, phone, hours, notes)
- [ ] Submissions enter a review queue — not published until approved
- [ ] Submitter gets confirmation that their suggestion was received

### Crisis Resources
- [ ] 211 and 988 hotlines permanently visible — not buried
- [ ] These are the first things someone sees, not just a footer item

### Accessibility
- [ ] WCAG 2.1 AA minimum
- [ ] Works on low-end Android phones
- [ ] Works on slow connections (no heavy assets blocking core functionality)
- [ ] Available in Spanish (V2)

---

## Edge Cases

- User is on a phone with location services off → zip code fallback always works
- Service has closed or moved → submission form enables corrections; last-verified date shows data age
- User searches and gets zero results → graceful empty state with 211 number prominently shown
- Address has no geocoordinates → listing appears in list only, not on map, with note
- Submission is spam or invalid → review queue catches it before publishing

---

## Out of Scope (V1)

- User accounts or saved searches
- Real-time availability (beds tonight, pantry open now)
- Ratings or reviews
- Automated data sync from 211 API (this is V2 and changes architecture significantly)
- Languages other than English
- Coverage outside LA County

---

## Success Metrics

**Primary:**
- Directions clicked per session (proxy for "found something useful")
- Phone number tapped per session
- Return visitors (someone coming back suggests the site is trusted)

**Secondary:**
- Time to first interaction (how fast do people engage with a pin or card)
- Session length (too short = didn't find anything, too long = confused)
- Community submissions received per month

**Guardrail:**
- Bounce rate — if people are leaving immediately, the page isn't serving crisis moments

**Not a metric (V1):** We can't track outcomes (did they get food, did they get housed). That's a V3 problem.

---

## Donations

This project accepts voluntary community support to cover hosting and operating costs. It is not a registered nonprofit. Donations are not tax-deductible. The site should say this plainly — no misleading language.

### Donation Channels

**On the website (credit/debit card):**
Stripe — 2.9% + $0.30 per transaction. No monthly fee. Simple embed on a donation page. Donors don't need an account.

**Peer-to-peer (no integration needed):**
- CashApp — publish the $cashtag. Zero fees on personal transfers.
- PayPal.me — publish the personal link. Free for sender-pays transfers.
- Venmo — same as PayPal, different audience. Worth including.

**Crypto (zero platform fees):**
- Publish a Bitcoin wallet address and an Ethereum wallet address directly on the site
- Donors send to the address; only network gas fees apply (paid by sender)
- For a slightly cleaner experience: Coinbase Commerce (1% fee, multi-coin support, hosted page)
- Crypto holders looking to give tend to be generous when they believe in a cause

### What to Say on the Donation Page

Be direct: "This is a personal project run by one person. Donations go toward hosting costs and keeping the data current. They are not tax-deductible. If you've found this useful, anything helps."

That's more trustworthy than vague nonprofit language, and honesty builds more loyalty than polish.

### Tax Note

Once total donations exceed $600 in a year across these platforms, expect a 1099 form. That money is taxable personal income. Track it.

**If the project grows large:** Open Collective is the path forward. They act as a fiscal sponsor — the project lives under their nonprofit umbrella, donors get tax deductibility, and there is zero government registration required. Their fee is 8% of donations received. This is the decided route if scale demands it.

---

## Open Questions

1. **What's the governance model for approving submissions?** Who reviews them and how quickly? This needs an owner before launch.
2. **What's the plan for keeping data current?** Stale listings erode trust faster than missing listings. This is the hardest operational problem.
3. **Should the site have a name/brand beyond "Find Help LA"?** If this goes national, the name needs to work nationally.
4. **What's the path to Spanish?** LA's hardest-hit communities are heavily Spanish-speaking. This is a V1 gap worth acknowledging explicitly.
~~**Which crypto wallets to publish?**~~ **Decided: Coinbase Commerce. 1% fee, multi-coin, hosted page.**

~~**Legal/funding structure if the project grows large?**~~ **Decided: Open Collective fiscal sponsorship.**

---

## Appendix

**Prototype:** find-help-la.html (single-file HTML, Leaflet.js, 23 hardcoded LA services)

**Key data sources for V2 (nationwide):**
- 211 API (United Way) — primary, nationwide, requires application for access
- Findhelp.org (Aunt Bertha) — commercial, comprehensive
- SAMHSA Behavioral Health Treatment Locator — mental health/substance use
- USDA Food & Nutrition Service — food programs
- HUD Exchange — homeless services

**Comparable products:**
- findhelp.org — most comprehensive but clinical/institutional feel
- foodoasis.la — LA-specific, well-executed, food only
- 211.org — the phone call standard, web presence is weak
- none of these are designed for the crisis moment
