-- Sery Hair v11 : photo de profil des clientes (à exécuter une fois dans Supabase > SQL Editor)
alter table clients add column if not exists photo text;
