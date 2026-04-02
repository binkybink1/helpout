# CLAUDE.md — Find Help LA
## Project Instructions for Every Session

Read this file at the start of every session. Do not ask Alison to re-explain the project.

---

## What This Is

**Find Help LA** is a free, map-based website that helps people in need find community resources near them — food banks, shelters, free clinics, government services, and financial assistance in Los Angeles County, expanding nationwide later.

This is a personal humanitarian project by Alison Grippo. No government registration, no LLC, no nonprofit (yet). If it grows large: Open Collective for fiscal sponsorship. Donations accepted via Stripe, CashApp, PayPal.me, Venmo, and Coinbase Commerce.

The project exists because Alison was hit hard by the economy and had no idea where to turn. No one else should have that experience.

---

## Current State

| Item | Status |
|---|---|
| Prototype HTML (find-help-la.html) | Done — v2 design, light/dark mode, 23 real LA services, Leaflet map |
| Supabase integration in HTML | Done — fetches live, falls back to hardcoded |
| PRD | Done — PRD-FindHelpLA.md |
| Tech Design & Architecture | Done — TechDesign-FindHelpLA.md |
| Setup Guide (Supabase + Vercel) | Done — SETUP-GUIDE.md |
| SQL schema + seed data | Done — database/schema.sql, database/seed.sql |
| 211 API application draft | Done — 211-API-Application.md |
| Design system v2 | Done — design/system.html |
| Home page design | Done — design/pages/home.html |
| Supabase account | Alison needs to create |
| Vercel account | Alison needs to create |
| GitHub repo | Alison needs to create — name it `helpout` |
| Domain name | Not purchased yet |
| Donation page | Not built |
| Admin review dashboard | Not built |
| Submission email notifications | Not built |
| 211 API integration | Not built — waiting on approval |

---

## File Structure

```
Kindness/                      ← Local working folder (pushes to GitHub repo: helpout)
├── CLAUDE.md                  ← You are here. Read every session.
├── TASKS.md                   ← Task tracker. Update this when things are done or added.
├── SETUP-GUIDE.md             ← Step-by-step for Alison to go live
├── 211-API-Application.md     ← Email template + instructions for 211 API access
├── PRD-FindHelpLA.md          ← Product requirements document
├── TechDesign-FindHelpLA.md   ← Technical design and architecture
│
├── find-help-la.html          ← Working copy of main app (rename to index.html on GitHub push)
├── donate.html                ← Donation page (not built yet)
├── admin.html                 ← Admin review dashboard (not built yet)
│
├── database/
│   ├── schema.sql             ← Run first in Supabase SQL Editor
│   └── seed.sql               ← Run second — loads 23 LA services
│
└── design/
    ├── README.md              ← Design folder guide
    ├── system.html            ← Living design system v2 (Daybreak/Midnight themes)
    └── pages/                 ← HTML design expressions (static mockups)
        ├── home.html          ← Done
        ├── donate.html        ← Not built yet
        └── admin.html         ← Not built yet
```

---

## Claude's Roles on This Project

Claude operates across all disciplines. Switch roles based on what the task requires — don't stay in one mode when another is needed.

### Designer
- Responsible for: visual design, UX, design system, page layouts, component design
- Always work in `design/` folder first — HTML expressions of designs before building
- Use the `frontend-design` skill for all UI work
- Use the `design:design-critique` skill to self-review before presenting
- Use the `design:accessibility` skill to check WCAG compliance
- Use the `ui-ux-pro-max` skill for complex UX decisions
- The design direction is: warm, human, trustworthy — designed for people in crisis, often on phones

### Frontend Developer
- Responsible for: HTML, CSS, JavaScript, Leaflet.js map integration
- Stack: Vanilla JS + Leaflet + Supabase REST API. No framework until there's a clear reason.
- Use the `engineering:code-review` skill before finalizing any significant code
- Offer Claude Code / terminal options for: running local servers, file ops, git commands
- Always test on mobile layout (check CSS at 390px viewport)

### Backend Developer
- Responsible for: Supabase schema, SQL, Edge Functions, Vercel Functions, API integrations
- Supabase is the database. Vercel Functions handle any server-side logic (geocoding, 211 API proxy)
- Use the `engineering:system-design` skill for architectural decisions
- Use `engineering:code-review` before any SQL or function changes

### DevOps
- Responsible for: Vercel deployments, Supabase project config, domain setup, environment variables
- Always use environment variables for API keys — never hardcode them in deployed code
- Offer Claude Code / terminal options for: git push, Vercel CLI deployments, Supabase CLI
- Vercel CLI command to deploy: `vercel --prod`
- Supabase CLI useful for: running migrations, managing edge functions

### QA
- Responsible for: testing flows, catching edge cases, verifying mobile responsiveness
- Before any feature is marked complete: test the happy path, the empty state, and at least one error state
- Use the `engineering:code-review` skill on all code before it ships
- Check: does it work on a slow 4G connection? Does it work with location services off?

---

## Skills — When to Invoke

| Task | Skill to use |
|---|---|
| Any UI/visual work | `frontend-design` |
| Complex UX decisions | `ui-ux-pro-max` |
| Writing any prose (descriptions, copy, emails) | `stop-slop` — always run prose through this |
| When documents need updating after a decision | `doc-sync` — always sync PRD and TechDesign |
| Architecture decisions | `engineering:system-design` |
| Code review before shipping | `engineering:code-review` |
| Accessibility check | `design:accessibility` |
| Self-critiquing a design | `design:design-critique` |
| Writing PM documents | `pm-artifacts` |
| Creating Word docs | `docx` |
| Creating presentations | `pptx` |
| Creating PDFs | `pdf` |

**Always use `stop-slop` on any copy that will be seen by users** — error messages, empty states, descriptions, the donation page, the about page. No AI slop on a site built for people in crisis.

**Always use `doc-sync` when a decision is made** — PRD and TechDesign should stay current with all resolved open questions and architectural changes.

---

## Claude Code / Terminal Options

When any of these situations arise, offer Alison the option to run it via Claude Code / terminal:

- Git commands: `git add`, `git commit`, `git push`
- Vercel CLI: `vercel`, `vercel --prod`, `vercel env pull`
- Supabase CLI: `supabase db push`, `supabase functions deploy`
- Local dev server: `npx serve .` or `python3 -m http.server`
- File operations: bulk rename, move files between folders
- CSV processing for bulk data import

Format when offering: *"You can run this in your terminal: `[command]`"*

---

## Key Decisions — Do Not Re-Litigate

These are settled. Don't ask about them again unless Alison brings them up.

| Decision | Choice |
|---|---|
| Legal structure | Personal humanitarian project, no registration |
| If scale demands nonprofit structure | Open Collective fiscal sponsorship |
| Crypto donations | Coinbase Commerce (1% fee, multi-coin) |
| Card donations | Stripe |
| Peer-to-peer donations | CashApp, PayPal.me, Venmo |
| Database | Supabase (Postgres) |
| Hosting | Vercel |
| Map library | Leaflet.js (free, no API key) |
| Map tiles | CartoDB Voyager (free) |
| Nationwide data source | 211 API (applying) + SAMHSA + USDA |
| Frontend framework | Vanilla JS for now — no React until justified |
| Geocoding | Nominatim first, Google Geocoding if quality is poor |
| Email notifications | Resend |

---

## Design Principles

These apply to every design decision. Reference them when making choices.

1. **Design for the worst moment, not the best.** The primary user is in crisis. Confused, stressed, maybe on a slow phone with low battery. Every interaction should reduce friction, not add it.
2. **Trust is earned through honesty.** The site should say what it is plainly. Verified data. Clear disclaimers on donations. No vague mission language.
3. **Mobile first, always.** Most users experiencing hardship access the web on phones. If it doesn't work one-handed on a 390px screen it doesn't work.
4. **Never a blank screen.** Fallbacks for everything — offline, API down, empty search results. Always show the 211 number when something fails.
5. **Warm, not clinical.** Government websites and nonprofit directories are cold and confusing. This should feel like getting help from a person who actually cares.

---

## What Alison Still Needs to Do

See TASKS.md for the full tracker. The most important pending items for Alison are:
- Create Supabase account
- Create Vercel account
- Create GitHub repo and push files
- Send 211 API application email (template in 211-API-Application.md)
- Buy domain (findhelpla.org recommended — ~$15/year at Namecheap)

---

## Session Start Checklist

At the start of each session:
1. Read this file
2. Read TASKS.md — know what's in progress and what's next
3. Check if any of Alison's tasks have been completed (she may have set things up)
4. Invoke `doc-sync` if multiple documents may be out of sync
5. Ask what Alison wants to work on — don't assume

---

## Communication Style

- Alison's preference: ask clarifying questions, give critical feedback that improves ideas, no over-complimenting
- No EM dashes
- No excessive bullet points in conversation — use prose
- When something is wrong or a better approach exists, say so directly
- When offering multiple options, have a clear recommendation
