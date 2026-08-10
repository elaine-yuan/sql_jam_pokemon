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
-- MATCH AND RANGES
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-match-saur
-- Difficulty: Easy
-- Challenge: Three Pokémon have 'saur' in their name. Return their `name` and `primary_type`.
-- My Solution:
SELECT name, primary_type
FROM pokemon
WHERE LOWER(name) LIKE '%saur%';


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-match-starter-legendaries
-- Difficulty: Medium
-- Challenge: Which Legendaries share a type with the classic starters, without being overwhelming? Return `name`, `primary_type` and `total_stats` for Legendary Pokémon whose `primary_type` is fire, water or grass and whose `total_stats` is between 500 and 600 inclusive.
-- My Solution:
SELECT name, primary_type, total_stats
FROM pokemon
WHERE is_legendary=TRUE AND primary_type IN('fire', 'water', 'grass') AND (total_stats>=500 AND total_stats<=600);