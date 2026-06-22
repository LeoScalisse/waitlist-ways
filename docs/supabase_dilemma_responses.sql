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
