-- Sery Hair v14 : liens Facebook, Instagram, TikTok (à exécuter une fois dans Supabase > SQL Editor)
alter table settings add column if not exists fb text default '';
alter table settings add column if not exists ig text default '';
alter table settings add column if not exists tk text default '';
