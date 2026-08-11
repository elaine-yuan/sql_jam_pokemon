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

-- ============================================================
-- FILTER WITH WHERE
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-where-water
-- Difficulty: Easy
-- Challenge: Return the `name` of every water-type Pokémon (primary_type = 'water').
-- My Solution:
SELECT name
FROM pokemon
WHERE primary_type='water';


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-where-legendary-gen4
-- Difficulty: Medium
-- Challenge: Return the `name` of every Legendary Pokémon from generation 4.
-- My Solution:
SELECT name
FROM pokemon
WHERE is_legendary=TRUE AND generation=4;
