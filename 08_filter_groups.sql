-- ============================================================
-- TABLE SCHEMA
-- ============================================================

-- Table: pokemon
--   id: INTEGER
--   name: VARCHAR
--   japanese_name: VARCHAR
--   classification: VARCHAR
--   generation: INTEGER
--   is_legendary: BOOLEAN
--   is_mythical: BOOLEAN
--   primary_type: VARCHAR
--   secondary_type: VARCHAR
--   hp: INTEGER
--   attack: INTEGER
--   defense: INTEGER
--   sp_attack: INTEGER
--   sp_defense: INTEGER
--   speed: INTEGER
--   total_stats: INTEGER
--   height_m: DOUBLE
--   weight_kg: DOUBLE
--   capture_rate: INTEGER
--   base_happiness: INTEGER
--   experience_growth: INTEGER
--   percentage_male: DOUBLE

-- Table: pokemon_forms
--   pokemon_id: INTEGER
--   form_name: VARCHAR
--   primary_type: VARCHAR
--   secondary_type: VARCHAR
--   hp: INTEGER
--   attack: INTEGER
--   defense: INTEGER
--   sp_attack: INTEGER
--   sp_defense: INTEGER
--   speed: INTEGER
--   total_stats: INTEGER
--   height_m: DOUBLE
--   weight_kg: DOUBLE

-- ============================================================
-- FILTER GROUPS
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-group-legendary-per-gen
-- Difficulty: Medium
-- Challenge: Count the Legendary Pokémon in each generation, then keep only the generations with at least 10 of them. Return `generation` and the count as `legendaries`.
-- My Solution:
SELECT generation, COUNT(*) AS legendaries
FROM pokemon
WHERE is_legendary=TRUE 
GROUP BY generation
HAVING COUNT(*)>=10;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-having-crowded-types
-- Difficulty: Medium
-- Challenge: Which types are crowded? Return the `primary_type` and how many Pokémon have it as `pokemon`, for types with at least 40 Pokémon.
-- My Solution:
SELECT generation, COUNT(*) AS pokemon, ROUND(AVG(total_stats),1) AS avg_stats
FROM pokemon
GROUP BY generation;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-having-forms-multiple
-- Difficulty: Hard
-- Challenge: A handful of Pokémon have more than one alternate form. Return the species `name` and how many forms it has as `forms`, for every Pokémon with more than one.
-- My Solution:
SELECT name, COUNT(DISTINCT form_name) AS forms
FROM pokemon p
LEFT JOIN pokemon_forms pf
ON p.id=pf.pokemon_id
GROUP BY name
HAVING COUNT(DISTINCT form_name)>1;
