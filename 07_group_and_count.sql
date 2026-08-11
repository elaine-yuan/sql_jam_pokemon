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
-- GROUP AND COUNT
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-group-count-per-type
-- Difficulty: Easy
-- Challenge: For every `primary_type`, return the type and how many Pokémon have it. Name the count column `n`.
-- My Solution:
SELECT primary_type, COUNT(*) AS n
FROM pokemon
GROUP BY primary_type;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-agg-by-generation
-- Difficulty: Medium
-- Challenge: Has each generation got stronger? For every `generation`, return the generation, how many Pokémon it has as `pokemon`, and their average `total_stats` rounded to 1 decimal as `avg_stats`.
-- My Solution:
SELECT generation, COUNT(*) AS pokemon, ROUND(AVG(total_stats),1) AS avg_stats
FROM pokemon
GROUP BY generation;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-group-legendary-per-type
-- Difficulty: Medium
-- Challenge: For each `primary_type` with at least 40 Pokémon, return the type, how many Pokémon it has as `total`, and how many of those are Legendary as `legendary` — all in the same row.
-- My Solution:
SELECT primary_type, COUNT(*) AS legendaries
FROM pokemon
WHERE is_legendary=TRUE 
GROUP BY primary_type
ORDER BY legendaries DESC, primary_type ASC;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-group-stat-tiers
-- Difficulty: Hard
-- Challenge: Sort every Pokémon by its `total_stats`: 600 or more is 'pseudo-legendary', 500 to 599 is 'strong', 400 to 499 is 'middling', and anything else is 'weak'. Return the label as `tier` and how many Pokémon are in it as `n`.
-- My Solution:
SELECT CASE 
  WHEN total_stats>=600 THEN 'pseudo-legendary'
  WHEN total_stats>=500 AND total_stats<600 THEN 'strong'
  WHEN total_stats>=400 AND total_stats<500 THEN 'middling'
  ELSE 'weak' END AS tier, COUNT(*) AS n
FROM pokemon
GROUP BY tier;
