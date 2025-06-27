-- Schema definition for public.profiles and related RLS policies

-- 1. user_role enum
create type user_role as enum ('client', 'coach', 'admin');

-- 2. profiles table linked to auth.users
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  avatar_url text,
  role user_role not null default 'client',
  bio text,
  credentials text,
  is_onboarded boolean not null default false,
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- 3. updated_at trigger
create or replace function public.update_updated_at_column()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger update_profiles_updated_at
before update on public.profiles
for each row execute function public.update_updated_at_column();

-- 4. Row level security configuration
alter table public.profiles enable row level security;

-- 5. RLS policies

-- Users can view their own profile
create policy "Users can view their own profile"
  on public.profiles
  for select
  using (auth.uid() = id);

-- Admins can view all profiles
create policy "Admins can view all profiles"
  on public.profiles
  for select
  using (
    exists (
      select 1 from public.profiles p
      where p.id = auth.uid() and p.role = 'admin'
    )
  );

-- Users can insert their own profile
create policy "Users can insert their own profile"
  on public.profiles
  for insert
  with check (auth.uid() = id);

-- Users can update their own profile
create policy "Users can update their own profile"
  on public.profiles
  for update
  using (auth.uid() = id);

-- Users can delete their own profile
create policy "Users can delete their own profile"
  on public.profiles
  for delete
  using (auth.uid() = id);

-- 6. grant permissions to authenticated users
grant select, insert, update, delete on public.profiles to authenticated;
