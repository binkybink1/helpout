-- ============================================================
-- Find Help LA — Database Schema
-- Run this in Supabase SQL Editor FIRST, before seed.sql
-- ============================================================

-- Enable UUID generation
create extension if not exists "pgcrypto";

-- ── SERVICES TABLE ────────────────────────────────────────────
-- Published, live listings that appear on the map

create table if not exists public.services (
    id           uuid primary key default gen_random_uuid(),
    name         text not null,
    category     text not null check (category in ('food','shelter','health','government','financial')),
    address      text not null,
    lat          double precision,
    lng          double precision,
    phone        text,
    hours        text,
    description  text,
    website      text,
    source       text default 'manual',   -- 'manual', '211_api', 'community'
    verified_at  timestamptz default now(),
    created_at   timestamptz default now()
);

-- ── SUBMISSIONS TABLE ─────────────────────────────────────────
-- Community-submitted listings waiting for review

create table if not exists public.submissions (
    id               uuid primary key default gen_random_uuid(),
    name             text,
    category         text,
    address          text,
    phone            text,
    hours            text,
    website          text,
    notes            text,
    submitter_email  text,
    status           text default 'pending' check (status in ('pending','approved','rejected')),
    submitted_at     timestamptz default now(),
    reviewed_at      timestamptz
);

-- ── ROW LEVEL SECURITY ────────────────────────────────────────
-- Services are publicly readable. Only authenticated users can write.

alter table public.services enable row level security;
alter table public.submissions enable row level security;

-- Anyone can read published services
create policy "Services are publicly readable"
    on public.services for select
    using (true);

-- Anyone can insert a submission (the review queue handles abuse)
create policy "Anyone can submit"
    on public.submissions for insert
    with check (true);

-- Only authenticated users (admin) can read submissions
create policy "Admin can read submissions"
    on public.submissions for select
    using (auth.role() = 'authenticated');

-- Only authenticated users (admin) can update services
create policy "Admin can insert services"
    on public.services for insert
    with check (auth.role() = 'authenticated');

create policy "Admin can update services"
    on public.services for update
    using (auth.role() = 'authenticated');

create policy "Admin can delete services"
    on public.services for delete
    using (auth.role() = 'authenticated');

-- Only authenticated users (admin) can update submissions
create policy "Admin can update submissions"
    on public.submissions for update
    using (auth.role() = 'authenticated');

-- ── INDEXES ──────────────────────────────────────────────────
-- Speed up common queries

create index if not exists services_category_idx on public.services(category);
create index if not exists services_verified_idx on public.services(verified_at);
create index if not exists submissions_status_idx on public.submissions(status);
