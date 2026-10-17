-- Sery Hair v5 : stock des produits (à exécuter une fois dans Supabase > SQL Editor)
alter table products add column if not exists stock integer;
create or replace function orders_stock() returns trigger language plpgsql security definer set search_path=public as $$
declare it jsonb; q int;
begin
 if tg_op='INSERT' then
  for it in select value from jsonb_array_elements(coalesce(new.items::jsonb,'[]'::jsonb)) loop
   q:=coalesce((it->>'qty')::int,0);
   if exists(select 1 from products where name=it->>'name' and stock is not null and stock<q) then raise exception 'Stock insuffisant pour %',it->>'name'; end if;
   update products set stock=stock-q where name=it->>'name' and stock is not null;
  end loop;
 elsif tg_op='UPDATE' and new.status='annulee' and old.status is distinct from 'annulee' then
  for it in select value from jsonb_array_elements(coalesce(new.items::jsonb,'[]'::jsonb)) loop
   q:=coalesce((it->>'qty')::int,0);
   update products set stock=stock+q where name=it->>'name' and stock is not null;
  end loop;
 end if;
 return new;
end $$;
drop trigger if exists trg_orders_stock on orders;
create trigger trg_orders_stock after insert or update of status on orders for each row execute function orders_stock();
