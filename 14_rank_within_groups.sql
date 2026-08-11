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

-- Table: pokemon_abilities
--   pokemon_id: INTEGER
--   ability: VARCHAR

-- ============================================================
-- RANK WITHIN GROUPS
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-win-number-gen1-legendaries
-- Difficulty: Medium
-- Challenge: Number the five Generation 1 Legendaries from strongest to weakest. Return `name`, `total_stats`, and the row number as `rn` (order by `total_stats` descending, then `name`). Use ROW_NUMBER().
-- My Solution:
SELECT name, total_stats, ROW_NUMBER() OVER(ORDER BY total_stats DESC, name) AS 'rn'
FROM pokemon
WHERE generation=1 AND is_legendary=TRUE;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-win-rank-type
-- Difficulty: Hard
-- Challenge: Among the strong Pokémon (`total_stats` of at least 500), return `name`, `primary_type`, `total_stats`, and its rank by `total_stats` (highest first) within its `primary_type`, as `type_rank`. Use RANK().
-- My Solution:
SELECT name, primary_type, total_stats, RANK() OVER(PARTITION BY primary_type  ORDER BY total_stats DESC) AS type_rank
FROM pokemon
WHERE total_stats>=500;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-win-rownum-legendary
-- Difficulty: Hard
-- Challenge: Walking the Legendaries in Pokédex order, how does each compare with the one before? Return `name`, `total_stats`, and the previous Legendary's `total_stats` as `prev_stats`, ordered by `id`.
-- My Solution:
SELECT name, total_stats, LAG(total_stats,1) OVER(ORDER BY id) AS prev_stats
FROM pokemon
WHERE is_legendary=TRUE;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-win-dex-growth
-- Difficulty: Hard
-- Challenge: How big had the Pokédex got by the end of each generation? Start with a CTE counting how many Pokémon each `generation` added, then return `generation`, that count as `pokemon`, and the running total of every Pokémon up to and including that generation as `dex_size`. Use a window function — `SUM(...) OVER (ORDER BY ...)`. Sort by `generation`.
-- My Solution:
WITH gen_count AS
(SELECT generation, COUNT(*) AS pokemon
  FROM pokemon
  GROUP BY generation)
SELECT generation, pokemon, SUM(pokemon) OVER(ORDER BY generation) AS dex_size
FROM gen_count;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-win-rolling-gen-avg
-- Difficulty: Hard
-- Challenge: Are Pokémon getting stronger, or is it just noise? Build a CTE with each `generation` and the average `total_stats` of its non-Legendary Pokémon, rounded to 1 decimal as `avg_stats`. Then return `generation`, `avg_stats`, and a 3-generation rolling average of `avg_stats` — this generation plus the two before it — rounded to 1 decimal as `rolling3`. You'll need an explicit window frame. Sort by `generation`.
-- My Solution:
WITH avg_stats AS
(SELECT generation, ROUND(AVG(total_stats),1) AS avg_stats
  FROM pokemon
  WHERE is_legendary=FALSE
  GROUP BY generation)
SELECT generation, avg_stats, ROUND(AVG(avg_stats) OVER (ORDER BY generation ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),1) AS rolling3
FROM avg_stats
ORDER BY generation;