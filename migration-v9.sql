-- Sery Hair v9 : le super administrateur peut supprimer un compte cliente (à exécuter une fois dans Supabase > SQL Editor)
create or replace function delete_client(target uuid) returns void language plpgsql security definer set search_path=public,auth as $$
begin
 if not is_super() then raise exception 'Réservé au super administrateur'; end if;
 if exists(select 1 from profiles where id=target) then raise exception 'Ce compte est un compte de gestion'; end if;
 delete from auth.users where id=target;
end $$;
grant execute on function delete_client(uuid) to authenticated;
