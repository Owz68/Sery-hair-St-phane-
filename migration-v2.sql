-- Sery Hair v2 : à exécuter UNE FOIS dans Supabase > SQL Editor
alter table settings add column if not exists tel2 text default '';
alter table settings add column if not exists ban_txt text default '';
alter table settings add column if not exists ban_img text default '';
alter table settings add column if not exists ban_on boolean default true;
create table if not exists clients(id uuid primary key references auth.users(id) on delete cascade,name text,phone text,created_at timestamptz default now());
create table if not exists suivis(id bigserial primary key,client_id uuid references clients(id) on delete cascade,date date default current_date,titre text,details text,produits text,prochain date,created_at timestamptz default now());
create or replace function is_staff() returns boolean language sql security definer stable set search_path=public as $$ select exists(select 1 from profiles where id=auth.uid() and role in ('admin','super')) $$;
alter table clients enable row level security;alter table suivis enable row level security;
drop policy if exists cl_sel on clients;create policy cl_sel on clients for select using(id=auth.uid() or is_staff());
drop policy if exists cl_ins on clients;create policy cl_ins on clients for insert with check(id=auth.uid());
drop policy if exists cl_upd on clients;create policy cl_upd on clients for update using(id=auth.uid() or is_staff());
drop policy if exists su_sel on suivis;create policy su_sel on suivis for select using(client_id=auth.uid() or is_staff());
drop policy if exists su_all on suivis;create policy su_all on suivis for all using(is_staff()) with check(is_staff());
