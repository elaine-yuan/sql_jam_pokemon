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
-- SORT AND LIMIT
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-order-top10-total
-- Difficulty: Easy
-- Challenge: Show the top 10 Pokémon by `total_stats`. Return `name` and `total_stats`, highest first — break ties by `name` A→Z.
-- My Solution:
SELECT name, total_stats
FROM pokemon
ORDER BY total_stats DESC, name ASC
LIMIT 10;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-order-slowest-fire
-- Difficulty: Medium
-- Challenge: Return the 5 slowest fire-type Pokémon — counting only those whose `primary_type` is `fire`, not ones that carry fire as a secondary type. Show `name` and `speed`, slowest first — break ties by `name` A→Z.
-- My Solution:
SELECT name, speed
FROM pokemon
WHERE primary_type='fire'
ORDER BY speed ASC, name ASC
LIMIT 5;
