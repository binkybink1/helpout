# Setup Guide — Find Help LA
## From Prototype to Live Production Site

This guide walks you through every step. You already have GitHub — that's the starting point. Estimated time: **1–2 hours** if you follow it straight through.

---

## What You're Building

By the end of this guide you will have:
- A real database (Supabase) holding all 23 LA service listings
- A live website (Vercel) deployed from your GitHub repository
- A custom domain pointed at that site (optional but recommended)
- The 211 LA API application submitted

---

## Step 1 — Create a GitHub Repository

1. Go to **github.com** and log in
2. Click the **+** icon in the top right → **New repository**
3. Name it: `helpout`
4. Set it to **Public** (required for Vercel free tier)
5. Check **Add a README file**
6. Click **Create repository**

Now upload your files. The easiest way is to use the terminal (see below), but you can also drag-and-drop in the GitHub browser UI:

**Option A — Terminal (recommended):**
You can run this in your terminal: `git clone https://github.com/Binkybink1/helpout && cp -r Kindness/. helpout/ && cd helpout && mv find-help-la.html index.html && git add . && git commit -m "Initial commit" && git push`

**Option B — Browser upload:**
1. Click **Add file** → **Upload files**
2. Upload all files from your Kindness folder
3. Rename `find-help-la.html` to `index.html` (Vercel looks for index.html)
4. Click **Commit changes**

---

## Step 2 — Create a Supabase Account and Project

1. Go to **supabase.com** → click **Start your project**
2. Sign up with your GitHub account (easiest — one click)
3. Click **New project**
4. Fill in:
   - **Organization:** Create one with your name or "Find Help LA"
   - **Project name:** `helpout`
   - **Database password:** Create a strong password — **save this somewhere safe**
   - **Region:** `West US (North California)` — closest to LA
5. Click **Create new project** — takes about 2 minutes to spin up

---

## Step 3 — Create the Database Tables

Once your project is ready:

1. In the left sidebar, click **SQL Editor**
2. Click **New query**
3. Copy the entire contents of `database/schema.sql` (provided separately) and paste it in
4. Click **Run** (the green play button)
5. You should see: `Success. No rows returned`

Now load the data:
1. Click **New query** again
2. Copy the entire contents of `database/seed.sql` and paste it in
3. Click **Run**
4. You should see: `Success. 23 rows affected` (or similar)

To verify it worked:
1. Click **Table Editor** in the left sidebar
2. You should see a `services` table with 23 rows

---

## Step 4 — Get Your Supabase API Keys

1. In the left sidebar, click **Project Settings** (gear icon at bottom)
2. Click **API**
3. You need two things — copy them both somewhere:
   - **Project URL** — looks like `https://abcdefgh.supabase.co`
   - **anon public** key — a long string starting with `eyJ...`

The anon key is safe to put in your website code — it's read-only by default and that's exactly what you want.

---

## Step 5 — Update the Site With Your Supabase Keys

1. Open `index.html` in a text editor (Notepad, TextEdit, VS Code — anything works)
2. Near the top of the `<script>` section, find these two lines:
   ```
   const SUPABASE_URL  = 'YOUR_SUPABASE_URL';
   const SUPABASE_KEY  = 'YOUR_SUPABASE_ANON_KEY';
   ```
3. Replace `YOUR_SUPABASE_URL` with your Project URL
4. Replace `YOUR_SUPABASE_ANON_KEY` with your anon key
5. Save the file

---

## Step 6 — Deploy to Vercel

1. Go to **vercel.com** → click **Sign Up**
2. Choose **Continue with GitHub** — log in with your GitHub account
3. Click **Add New Project**
4. Find your `helpout` repository in the list and click **Import**
5. Leave all settings as default — Vercel will detect it's a static site
6. Click **Deploy**

Vercel will build and deploy in about 30 seconds. You'll get a URL like:
`https://helpout.vercel.app`

That's your live site. Every time you push a change to GitHub, Vercel automatically redeploys.

---

## Step 7 — Add a Custom Domain (Optional but Recommended)

A domain like `findhelpla.org` builds trust. People in crisis are more likely to trust a real domain.

**Buy a domain:**
- Go to **namecheap.com** (recommended — cheapest, no upsells)
- Search for `findhelpla.org` — `.org` signals nonprofit/public good
- Cost: ~$12–15/year

**Connect it to Vercel:**
1. In your Vercel project, go to **Settings → Domains**
2. Type in your domain and click **Add**
3. Vercel will show you DNS records to add
4. Go back to Namecheap → **Domain List** → **Manage** → **Advanced DNS**
5. Add the records Vercel showed you
6. Wait 10–30 minutes for DNS to propagate

---

## Step 8 — Set Up the Submission Email Notifications (Resend)

This is what sends you an email when someone submits a new place.

1. Go to **resend.com** → Sign up (free)
2. Click **Add Domain** → verify your domain (follow their steps)
3. Go to **API Keys** → create a new key → copy it
4. In Supabase, go to **Edge Functions** → **New Function** → name it `notify-admin`
5. Paste in the function code from `database/notify-function.js` (provided separately)
6. Add the environment variable: `RESEND_API_KEY` = your key
7. Deploy the function

This step can wait until after your site is live — it's not required for launch.

---

## Ongoing: Adding New Services

You have two options:

**Option A — Supabase Dashboard (easiest):**
1. Go to supabase.com → your project → **Table Editor**
2. Click **services** → **Insert row**
3. Fill in the fields and save
4. It appears on the map immediately

**Option B — Google Sheets bulk import:**
1. Fill in your Google Sheet (template format in the Tech Design doc)
2. Export as CSV
3. In Supabase Table Editor → **Import data from CSV**
4. Map columns → import

---

## Troubleshooting

**Map loads but no pins appear:**
Your Supabase keys are probably wrong. Double-check there are no spaces around the key values in your HTML file.

**Site shows old hardcoded data:**
The fetch to Supabase failed silently and fell back to local data. Check your browser console (F12 → Console) for error messages.

**Vercel deployment failed:**
Check the Vercel deployment logs — usually a typo in the HTML. The HTML validates before deploying.

**Supabase table is empty after running seed.sql:**
The SQL ran but maybe had an error partway through. Go to Table Editor and check how many rows are there. Re-run just the INSERT portion of seed.sql.

---

## What's Next After This

Once the site is live:
1. Submit the 211 LA API application (see `211-API-Application.md`)
2. Start building the admin review dashboard for submissions
3. Add the donation page
4. Begin expanding the service database using the Google Sheets bulk import method
