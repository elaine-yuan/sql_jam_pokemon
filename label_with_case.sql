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
-- LABEL WITH CASE
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-case-stat-tier
-- Difficulty: Medium
-- Challenge: Rank the original 151 by raw power. For generation 1 Pokemon with `total_stats` of at least 400, return `name`, `total_stats` and `tier` — 'powerhouse' at 600 or more, 'solid' at 500 or more, otherwise 'modest'. Strongest first, ties broken by `name` A-Z.
-- My Solution:
SELECT name, total_stats, 
CASE 
  WHEN total_stats>=600 THEN 'powerhouse'
  WHEN total_stats>=500 THEN 'solid'
  ELSE 'modest' END AS 'tier'
FROM pokemon
WHERE generation=1 AND total_stats>=400
GROUP BY name, total_stats
ORDER BY total_stats DESC, name ASC;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-case-legendaries-per-type
-- Difficulty: Hard
-- Challenge: Which types hoard the Legendaries? For each `primary_type` with at least 40 Pokemon, return `primary_type`, how many Pokemon it has as `pokemon`, and how many of those are Legendary as `legendaries`. Most Legendaries first, ties broken by `primary_type` A-Z.
-- My Solution:
SELECT primary_type, COUNT(*) AS pokemon, SUM(CASE WHEN is_legendary=TRUE THEN 1 ELSE 0 END) AS legendaries
FROM pokemon
GROUP BY primary_type
HAVING COUNT(*)>=40
ORDER BY legendaries DESC, primary_type ASC;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-case-catch-difficulty
-- Difficulty: Medium
-- Challenge: How hard is each Legendary to catch? A higher `capture_rate` means an easier catch. For Legendary Pokemon, return `name`, `capture_rate` and `difficulty` — 'easy' at 100 or more, 'tough' at 30 or more, otherwise 'nightmare'. Easiest first, ties broken by `name` A-Z.
-- My Solution:
SELECT name, capture_rate, 
CASE WHEN capture_rate>=100 THEN 'easy'
WHEN capture_rate>=30 THEN 'tough'
ELSE 'nightmare' END AS difficulty
FROM pokemon
WHERE is_legendary=TRUE
GROUP BY name, capture_rate
ORDER BY capture_rate DESC, name ASC;