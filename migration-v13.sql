-- Mise à jour en direct du site client (à exécuter une fois dans Supabase > SQL Editor)
do $$ begin
  begin alter publication supabase_realtime add table products; exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table services; exception when duplicate_object then null; end;
  begin alter publication supabase_realtime add table settings; exception when duplicate_object then null; end;
end $$;
