-- ============================================================
-- Find Help LA — Seed Data (23 Real LA County Services)
-- Run this AFTER schema.sql
-- ============================================================

insert into public.services
    (name, category, address, lat, lng, phone, hours, description, website, source)
values

-- ── FOOD ─────────────────────────────────────────────────────

('Los Angeles Regional Food Bank',
 'food', '1734 E 41st St, Los Angeles, CA 90058',
 34.0125, -118.2343, '(323) 234-3030', 'Mon–Fri 8am–4pm',
 'One of the largest food banks in the US. Distributes food through 600+ partner agencies across LA County. Use their pantry locator at lafoodbank.org to find a pickup point near you.',
 'https://www.lafoodbank.org', 'manual'),

('Midnight Mission — Free Meals',
 'food', '601 S San Pedro St, Los Angeles, CA 90014',
 34.0437, -118.2390, '(213) 624-9258', '365 days/year — Breakfast, Lunch & Dinner',
 'Serves free hot meals to anyone in need, every single day of the year. No appointment, no ID required. Walk up and you will be fed.',
 'https://www.midnightmission.org', 'manual'),

('St. Francis Center',
 'food', '2610 Pasadena Ave, Los Angeles, CA 90031',
 34.0712, -118.2156, '(323) 223-4990', 'Mon–Fri 7am–3pm',
 'Free groceries, hot meals, hygiene supplies, and social services. No ID or documentation required. They also connect people to housing and healthcare.',
 'https://stfranciscenterla.org', 'manual'),

('SOVA Community Food & Resource Program',
 'food', '9000 W Pico Blvd, Los Angeles, CA 90035',
 34.0518, -118.3843, '(310) 859-8951', 'Mon, Wed, Thu 9am–1pm',
 'Provides nutritious groceries for individuals and families. Also offers job training, emergency financial assistance, and legal aid referrals.',
 'https://www.sovaprogram.org', 'manual'),

('Union Rescue Mission — Meals',
 'food', '545 S San Pedro St, Los Angeles, CA 90013',
 34.0440, -118.2388, '(213) 347-6300', 'Daily — multiple meal times',
 'Hot meals served daily to anyone in the Skid Row area. Largest private homeless shelter on the West Coast also provides food to all who come.',
 'https://urm.org', 'manual'),

-- ── SHELTER ──────────────────────────────────────────────────

('Union Rescue Mission — Emergency Shelter',
 'shelter', '545 S San Pedro St, Los Angeles, CA 90013',
 34.0441, -118.2387, '(213) 347-6300', 'Open 24/7 — call ahead for intake',
 'Emergency shelter for men, women, and families. Also offers transitional housing, addiction recovery programs, job training, and healthcare on site.',
 'https://urm.org', 'manual'),

('Los Angeles Mission',
 'shelter', '303 E 5th St, Los Angeles, CA 90013',
 34.0455, -118.2394, '(213) 629-1227', 'Open 24/7 — call ahead',
 'Emergency shelter with meals, case management, addiction recovery, and job training. Serves men, women, and children. No one turned away.',
 'https://www.lamission.org', 'manual'),

('Covenant House California — Youth Ages 18–24',
 'shelter', '1325 N Western Ave, Los Angeles, CA 90027',
 34.1010, -118.3080, '(323) 461-3131', 'Open 24/7',
 'Safe emergency shelter specifically for young adults 18–24. No questions asked. Provides meals, case management, mental health, and housing support.',
 'https://covenanthouseca.org', 'manual'),

('Salvation Army Bell Shelter',
 'shelter', '4900 S Alameda St, Bell, CA 90201',
 33.9831, -118.1620, '(323) 263-2151', 'Call for intake hours',
 'One of the largest shelters in LA County with 350+ beds for men. Provides meals, spiritual care, case management, and recovery services.',
 'https://salvationarmyla.org', 'manual'),

('PATH — Homeless Services & Outreach',
 'shelter', '340 N Madison Ave, Pasadena, CA 91101',
 34.1479, -118.1330, '(818) 564-7254', 'Mon–Fri 8am–5pm',
 'People Assisting The Homeless. Connects individuals and families to housing and services across LA County. Call 2-1-1 to reach their crisis outreach teams.',
 'https://epath.org', 'manual'),

-- ── HEALTHCARE ───────────────────────────────────────────────

('Venice Family Clinic',
 'health', '604 Rose Ave, Venice, CA 90291',
 33.9893, -118.4672, '(310) 392-8630', 'Mon–Fri 8am–5pm',
 'Free and low-cost medical, dental, and mental health care for uninsured and underinsured patients. Sliding scale fees. No one is turned away for inability to pay.',
 'https://venicefamilyclinic.org', 'manual'),

('Saban Community Clinic',
 'health', '8405 Beverly Blvd, Los Angeles, CA 90048',
 34.0737, -118.3819, '(323) 653-1990', 'Mon–Fri 8am–6pm',
 'Comprehensive primary care, dental, behavioral health, and HIV services. Serves patients regardless of ability to pay. Accepts Medi-Cal, Medicare, and uninsured.',
 'https://www.sabancommunityclinic.org', 'manual'),

('JWCH Institute — Wesley Health Centers',
 'health', '1536 E Cesar E Chavez Ave, Los Angeles, CA 90033',
 34.0591, -118.2107, '(323) 267-5600', 'Mon–Fri 8am–5pm',
 'Free and low-cost primary care, dental, mental health, and substance use treatment. Multiple locations across LA County. Accepts uninsured patients.',
 'https://www.jwch.org', 'manual'),

('Northeast Valley Health Corp',
 'health', '8550 Laurel Canyon Blvd, Sun Valley, CA 91352',
 34.2328, -118.3972, '(818) 896-1811', 'Mon–Fri 7:30am–5pm',
 'Federally Qualified Health Center serving the San Fernando Valley. Primary care, dental, mental health, OB/GYN, and WIC on a sliding fee scale.',
 'https://www.nevhc.org', 'manual'),

('LA Christian Health Centers',
 'health', '2231 S Western Ave, Los Angeles, CA 90018',
 34.0225, -118.3079, '(323) 733-5428', 'Mon–Fri 8am–5pm',
 'Free and reduced-cost medical and dental care for uninsured patients. Also operates a mobile clinic serving neighborhoods across the city. No insurance required.',
 'https://lachc.com', 'manual'),

-- ── GOVERNMENT ───────────────────────────────────────────────

('DPSS East LA — CalFresh, Medi-Cal, CalWORKs',
 'government', '5445 Whittier Blvd, Los Angeles, CA 90022',
 34.0239, -118.1717, '(866) 613-3777', 'Mon–Fri 7:30am–5pm',
 'Apply for CalFresh (food stamps), Medi-Cal (health insurance), CalWORKs, and cash assistance. Bring photo ID, proof of address, and income info. Walk-ins welcome. Also apply online at BenefitsCal.com.',
 'https://dpss.lacounty.gov', 'manual'),

('DPSS Metro District Office',
 'government', '813 E 4th Pl, Los Angeles, CA 90013',
 34.0432, -118.2368, '(866) 613-3777', 'Mon–Fri 7:30am–5pm',
 'Downtown LA office for CalFresh, Medi-Cal, CalWORKs, and cash aid applications. Walk-ins welcome. You can also apply online at BenefitsCal.com or call the main DPSS line.',
 'https://dpss.lacounty.gov', 'manual'),

('DPSS Van Nuys District Office',
 'government', '7555 Van Nuys Blvd, Van Nuys, CA 91405',
 34.1897, -118.4503, '(866) 613-3777', 'Mon–Fri 7:30am–5pm',
 'San Fernando Valley location for CalFresh, Medi-Cal, CalWORKs, and emergency cash assistance. Walk-ins welcome. Apply online at BenefitsCal.com.',
 'https://dpss.lacounty.gov', 'manual'),

('Employment Development Dept (EDD) — Unemployment',
 'government', '3325 Wilshire Blvd, Los Angeles, CA 90010',
 34.0614, -118.3002, '(800) 300-5616', 'Mon–Fri 8am–5pm',
 'Apply for unemployment insurance, disability insurance (SDI), and Paid Family Leave. Job search and resume resources also available through WorkSource centers.',
 'https://edd.ca.gov', 'manual'),

('Social Security Administration — West LA',
 'government', '11000 Wilshire Blvd, Los Angeles, CA 90024',
 34.0514, -118.4465, '(800) 772-1213', 'Mon–Fri 9am–4pm',
 'Apply for SSI (Supplemental Security Income), SSDI (disability benefits), retirement benefits, and Medicare enrollment. Bring photo ID and medical documentation for disability claims.',
 'https://ssa.gov', 'manual'),

-- ── FINANCIAL ────────────────────────────────────────────────

('Chrysalis — Jobs & Emergency Assistance',
 'financial', '522 S Main St, Los Angeles, CA 90013',
 34.0411, -118.2520, '(213) 617-0755', 'Mon–Fri 8am–4:30pm',
 'Free job placement, job readiness training, and transitional employment for people facing homelessness or economic hardship. Also provides emergency financial assistance.',
 'https://www.changelives.org', 'manual'),

('Inner City Law Center',
 'financial', '1309 E 7th St, Los Angeles, CA 90021',
 34.0426, -118.2382, '(213) 891-2880', 'Mon–Fri 9am–5pm',
 'Free legal help to prevent eviction, fight illegal rent increases, fight wage theft, and resolve housing emergencies for low-income and homeless Angelenos.',
 'https://innercitylaw.org', 'manual'),

('United Way LA — 211 Helpline',
 'financial', 'Serves all of LA County — call or text 2-1-1',
 34.0550, -118.2650, '211', '24 hours a day, 7 days a week',
 'Free, confidential connection to rental assistance, utility assistance, emergency funds, food, healthcare, childcare, and hundreds more services. Available in multiple languages. Call or text 2-1-1 from anywhere in LA County.',
 'https://unitedwayla.org', 'manual');
