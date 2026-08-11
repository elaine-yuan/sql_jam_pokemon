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
-- NAME A STEP WITH
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-cte-strong
-- Difficulty: Medium
-- Challenge: Using a CTE named `strong` holding every Pokémon with `total_stats` of at least 500, return the `name` and `total_stats` of the ones that are above the average `total_stats` *of that group*.
-- My Solution:
WITH strong AS 
  (SELECT name, total_stats
  FROM pokemon
  WHERE total_stats>=500
  GROUP BY NAME, total_stats)
SELECT name, total_stats FROM strong
GROUP BY name, total_stats
HAVING total_stats > (SELECT AVG(total_stats) FROM strong);


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-cte-type-avg
-- Difficulty: Hard
-- Challenge: Build a CTE of each `primary_type` and its average `total_stats`, then return the `primary_type` and that average (rounded to 1 decimal, as `avg_total`) for types averaging above 450.
-- My Solution:
WITH avg_stats AS
  (SELECT primary_type, ROUND(AVG(total_stats),1) AS avg_total
  FROM pokemon
  GROUP BY primary_type)
SELECT primary_type, avg_total
FROM avg_stats
WHERE avg_total>450;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-cte-beats-legendary-bar
-- Difficulty: Hard
-- Challenge: Which ordinary Pokémon out-muscle the Legendaries of their own generation? Build a first CTE holding each `generation` and the average `total_stats` of that generation's Legendary Pokémon. Then a second CTE that reads the first one, joining it to `pokemon` to keep the non-Legendary Pokémon whose `total_stats` beat their generation's Legendary average. Return `generation`, `name` and `total_stats`, sorted by `generation`, then `total_stats` highest first, then `name`.
-- My Solution:
WITH leg_stats AS 
  (SELECT generation, AVG(total_stats) AS leg_stats
  FROM pokemon
  WHERE is_legendary=TRUE
  GROUP BY generation)
, stronger AS 
  (SELECT p.generation, p.name, p.total_stats
  FROM pokemon p 
  JOIN leg_stats ls 
  ON p.generation=ls.generation
  WHERE is_legendary=FALSE AND total_stats>leg_stats)
SELECT generation, name, total_stats
FROM stronger 
ORDER BY generation, total_stats DESC, name;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-cte-share-of-gen
-- Difficulty: Hard
-- Challenge: Each Legendary is one slice of its generation's Legendary firepower. Build a CTE of each `generation` and the SUM of `total_stats` across its Legendary Pokémon, then join it back to the individual Legendaries. Return `name`, `generation`, and that Pokémon's share of its generation's Legendary total as a percentage rounded to 1 decimal, as `pct_of_gen` — Legendaries from generations 1 to 3 only. Sort by `generation`, then `pct_of_gen` highest first, then `name`.
-- My Solution:
WITH leg_stats AS
(SELECT generation, SUM(total_stats) AS sum_stats
  FROM pokemon
  WHERE is_legendary=TRUE
  GROUP BY generation)
SELECT p.name, p.generation, ROUND((total_stats/sum_stats)*100,1) AS pct_of_gen
FROM pokemon p
JOIN leg_stats ls
ON p.generation=ls.generation
WHERE is_legendary=TRUE AND p.generation<=3
GROUP BY p.generation, p.name, total_stats, sum_stats
ORDER BY p.generation, pct_of_gen DESC, p.name;