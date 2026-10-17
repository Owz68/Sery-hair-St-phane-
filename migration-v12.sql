-- Sery Hair v12 : nouvelle fiche de suivi « Soins capillaires » (à exécuter une fois dans Supabase > SQL Editor)
alter table suivis add column if not exists type_cheveux text default '';
alter table suivis add column if not exists porosite text default '';
alter table suivis add column if not exists cuir_a text default '';
alter table suivis add column if not exists cuir_b text default '';
alter table suivis add column if not exists soins text default '';
alter table suivis add column if not exists reco text default '';
