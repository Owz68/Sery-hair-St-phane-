-- Sery Hair v10 : répare les règles d'accès des favoris (à exécuter une fois dans Supabase > SQL Editor)
alter table favoris enable row level security;
alter table favoris alter column client_id set default auth.uid();
drop policy if exists fav_all on favoris;
create policy fav_all on favoris for all to authenticated using(client_id=auth.uid()) with check(client_id=auth.uid());
grant select,insert,update,delete on favoris to authenticated;
