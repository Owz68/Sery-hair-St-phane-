-- Sery Hair v7 : bannières promo / stock épuisé (à exécuter une fois dans Supabase > SQL Editor)
alter table products add column if not exists badge text default '';
alter table products add column if not exists promo integer default 0;
alter table settings add column if not exists promo_all integer default 0;
