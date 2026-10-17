-- Sery Hair v6 : services séparés des prestations + stock en direct (à exécuter une fois dans Supabase > SQL Editor)
alter table services add column if not exists kind text default 'prestation';
update services set kind='prestation' where kind is null;
do $$ begin
  alter publication supabase_realtime add table products;
exception when duplicate_object then null; when others then null; end $$;
