# Design Folder

This folder contains all visual design work for Find Help LA.

## Structure

```
design/
├── system.html          Living design system — colors, typography, components, patterns
│                        This is the source of truth for all visual decisions.
│                        Update it whenever the design system changes.
│
└── pages/               HTML expressions of each page
    ├── home.html        Map page — the main experience
    ├── donate.html      Donation page
    └── admin.html       Admin review dashboard
```

## Rules

**Design in this folder first.** Before building any new page or component into the real site, build an HTML expression of it here. This is where visual decisions get made. The real build follows the design — not the other way around.

**system.html is the source of truth.** Every color, typeface, spacing value, and component pattern used in the site should exist in system.html first. If something isn't in the design system, it shouldn't be in the site.

**Pages in `pages/` are explorations, not final code.** They can be rougher, use placeholder content, and try multiple directions. The goal is to make visual decisions, not to produce production code.

## Design Direction

Warm, human, trustworthy. Built for people in crisis, usually on phones.

Not: clinical, governmental, cold, cluttered, or generically "modern SaaS."

Primary reference: imagine a really good community bulletin board run by someone who deeply cares — translated to web.
