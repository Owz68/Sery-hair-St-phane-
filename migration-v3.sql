-- Sery Hair v3 : à exécuter dans Supabase > SQL Editor (sans danger si déjà fait en partie)
alter table settings add column if not exists tel2 text default '';
alter table settings add column if not exists ban_txt text default '';
alter table settings add column if not exists ban_img text default '';
alter table settings add column if not exists ban_on boolean default true;
alter table settings add column if not exists pub_txt text default '';
alter table settings add column if not exists pub_img text default '';
alter table settings add column if not exists pub_lnk text default '';
alter table settings add column if not exists pub_on boolean default true;
