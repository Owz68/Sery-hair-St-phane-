-- Sery Hair v8 : favoris, suppression de compte, équipe d'administrateurs (à exécuter une fois dans Supabase > SQL Editor)
create table if not exists favoris(client_id uuid references clients(id) on delete cascade,name text,created_at timestamptz default now(),primary key(client_id,name));
alter table favoris enable row level security;
drop policy if exists fav_all on favoris;create policy fav_all on favoris for all using(client_id=auth.uid()) with check(client_id=auth.uid());
create or replace function is_super() returns boolean language sql security definer stable set search_path=public as $$ select exists(select 1 from profiles where id=auth.uid() and role='super') $$;
create or replace function delete_my_account() returns void language plpgsql security definer set search_path=public,auth as $$
begin
 if auth.uid() is null then raise exception 'Non connecté'; end if;
 if exists(select 1 from profiles where id=auth.uid()) then raise exception 'Un compte de gestion ne se supprime pas ici'; end if;
 delete from auth.users where id=auth.uid();
end $$;
create or replace function set_staff_role(target uuid) returns void language plpgsql security definer set search_path=public as $$
begin
 if not is_super() then raise exception 'Réservé au super administrateur'; end if;
 insert into profiles(id,role) values(target,'admin') on conflict (id) do update set role='admin' where profiles.role<>'super';
end $$;
create or replace function list_staff() returns table(id uuid,email text,role text) language plpgsql security definer set search_path=public,auth as $$
begin
 if not is_super() then raise exception 'Réservé au super administrateur'; end if;
 return query select p.id,u.email::text,p.role::text from profiles p join auth.users u on u.id=p.id order by p.role desc;
end $$;
create or replace function remove_staff(target uuid) returns void language plpgsql security definer set search_path=public,auth as $$
begin
 if not is_super() then raise exception 'Réservé au super administrateur'; end if;
 delete from profiles where id=target and role='admin';
 if found then delete from auth.users where id=target; end if;
end $$;
grant execute on function delete_my_account(),set_staff_role(uuid),list_staff(),remove_staff(uuid) to authenticated;
