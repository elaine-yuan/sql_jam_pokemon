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
-- MISSING VALUES
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-null-single-type
-- Difficulty: Easy
-- Challenge: Some Pokémon have only one type, so their `secondary_type` is blank. Return the `name` and `primary_type` of every Pokémon with no secondary type.
-- My Solution:
SELECT name, primary_type
FROM pokemon
WHERE secondary_type IS NULL';


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-null-dual-legendary
-- Difficulty: Medium
-- Challenge: Which Legendaries are dual-type? Return `name`, `primary_type` and `secondary_type` for Legendary Pokémon that DO have a secondary type.
-- My Solution:
SELECT name, primary_type, secondary_type
FROM pokemon
WHERE is_legendary=TRUE AND secondary_type IS NOT NULL;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-null-secondary-fallback
-- Difficulty: Medium
-- Challenge: Single-type Pokémon have no `secondary_type` at all — the column is simply empty for them. For every Generation 1 Pokémon, return the `name` and the `secondary_type`, showing the text 'none' where it has none.
-- My Solution:
SELECT name, IFNULL(secondary_type, 'none') AS secondary_type
FROM pokemon
WHERE generation=1;
