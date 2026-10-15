create extension if not exists pgcrypto;
create table if not exists public.admin_users(user_id uuid primary key references auth.users(id) on delete cascade,created_at timestamptz not null default now());
create table if not exists public.jobs(
 id uuid primary key default gen_random_uuid(),title text not null,slug text not null unique,company text not null,location text not null,category text not null,
 employment_type text not null default 'Full-time',experience_level text not null default 'Entry level',salary text,description text not null,
 requirements text,responsibilities text,application_url text not null,deadline date,posted_at timestamptz not null default now(),
 status text not null default 'draft' check(status in ('draft','published')),featured boolean not null default false,
 created_at timestamptz not null default now(),updated_at timestamptz not null default now()
);
create index if not exists jobs_status_posted_idx on public.jobs(status,posted_at desc);
create or replace function public.is_careerconnect_admin() returns boolean language sql stable security definer set search_path=public as $$
 select exists(select 1 from public.admin_users where user_id=(select auth.uid()));
$$;
alter table public.jobs enable row level security;
alter table public.admin_users enable row level security;
drop policy if exists "Public read published jobs" on public.jobs;
create policy "Public read published jobs" on public.jobs for select to anon,authenticated using(status='published');
drop policy if exists "Admins read all jobs" on public.jobs;
create policy "Admins read all jobs" on public.jobs for select to authenticated using(public.is_careerconnect_admin());
drop policy if exists "Admins insert jobs" on public.jobs;
create policy "Admins insert jobs" on public.jobs for insert to authenticated with check(public.is_careerconnect_admin());
drop policy if exists "Admins update jobs" on public.jobs;
create policy "Admins update jobs" on public.jobs for update to authenticated using(public.is_careerconnect_admin()) with check(public.is_careerconnect_admin());
drop policy if exists "Admins delete jobs" on public.jobs;
create policy "Admins delete jobs" on public.jobs for delete to authenticated using(public.is_careerconnect_admin());
drop policy if exists "Admins read own admin row" on public.admin_users;
create policy "Admins read own admin row" on public.admin_users for select to authenticated using(user_id=(select auth.uid()));
