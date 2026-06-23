-- TranquiliWays waitlist dilemma responses
-- Run this in Supabase SQL Editor for the project that will receive the page data.

create extension if not exists pgcrypto;

create table if not exists public.dilemma_responses (
  id uuid primary key default gen_random_uuid(),
  dilemma_text text not null check (
    char_length(trim(dilemma_text)) between 8 and 600
  ),
  source text not null default 'waitlist',
  page_path text,
  referrer text,
  user_locale text,
  client_timezone text,
  created_at timestamptz not null default now()
);

alter table public.dilemma_responses enable row level security;

grant usage on schema public to anon;
grant insert on public.dilemma_responses to anon;

drop policy if exists "Allow anonymous waitlist inserts" on public.dilemma_responses;
create policy "Allow anonymous waitlist inserts"
on public.dilemma_responses
for insert
to anon
with check (
  source = 'waitlist'
  and char_length(trim(dilemma_text)) between 8 and 600
);

drop policy if exists "Block anonymous reads" on public.dilemma_responses;
create policy "Block anonymous reads"
on public.dilemma_responses
for select
to anon
using (false);

drop policy if exists "Block anonymous updates" on public.dilemma_responses;
create policy "Block anonymous updates"
on public.dilemma_responses
for update
to anon
using (false)
with check (false);

drop policy if exists "Block anonymous deletes" on public.dilemma_responses;
create policy "Block anonymous deletes"
on public.dilemma_responses
for delete
to anon
using (false);

create index if not exists dilemma_responses_created_at_idx
on public.dilemma_responses (created_at desc);

create table if not exists public.founder_applications (
  id uuid primary key default gen_random_uuid(),
  founder_name text not null check (
    char_length(trim(founder_name)) between 2 and 120
  ),
  whatsapp_number text not null check (
    char_length(trim(whatsapp_number)) between 8 and 40
  ),
  reason_text text not null check (
    char_length(trim(reason_text)) between 8 and 800
  ),
  dilemma_text text,
  source text not null default 'waitlist_founder',
  page_path text,
  referrer text,
  user_locale text,
  client_timezone text,
  created_at timestamptz not null default now()
);

alter table public.founder_applications enable row level security;

alter table public.founder_applications
add column if not exists dilemma_text text;

grant insert on public.founder_applications to anon;

drop policy if exists "Allow anonymous founder inserts" on public.founder_applications;
create policy "Allow anonymous founder inserts"
on public.founder_applications
for insert
to anon
with check (
  source = 'waitlist_founder'
  and char_length(trim(founder_name)) between 2 and 120
  and char_length(trim(whatsapp_number)) between 8 and 40
  and char_length(trim(reason_text)) between 8 and 800
);

drop policy if exists "Block anonymous founder reads" on public.founder_applications;
create policy "Block anonymous founder reads"
on public.founder_applications
for select
to anon
using (false);

drop policy if exists "Block anonymous founder updates" on public.founder_applications;
create policy "Block anonymous founder updates"
on public.founder_applications
for update
to anon
using (false)
with check (false);

drop policy if exists "Block anonymous founder deletes" on public.founder_applications;
create policy "Block anonymous founder deletes"
on public.founder_applications
for delete
to anon
using (false);

create index if not exists founder_applications_created_at_idx
on public.founder_applications (created_at desc);
