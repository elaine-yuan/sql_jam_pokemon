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
-- SUM AND AVERAGE
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-agg-dex-summary
-- Difficulty: Easy
-- Challenge: Summarise the whole Pokédex in one row: how many Pokémon there are as `pokemon`, their average `total_stats` rounded to 1 decimal as `avg_stats`, and the single highest `attack` as `best_attack`.
-- My Solution:
SELECT COUNT(*) AS pokemon, ROUND(AVG(total_stats),1) AS avg_stats, MAX(attack) AS best_attack
FROM pokemon;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-agg-legendary-power
-- Difficulty: Medium
-- Challenge: How strong are Legendaries as a group? Return how many there are as `legendaries` and their average `total_stats` rounded to 1 decimal as `avg_stats`, for Legendary Pokémon only.
-- My Solution:
SELECT COUNT(*) AS legendaries, ROUND(AVG(total_stats),1) AS avg_stats
FROM pokemon
WHERE is_legendary=TRUE;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-agg-legendary-per-type
-- Difficulty: Hard
-- Challenge: For each `primary_type` with at least 40 Pokémon, return the type, how many Pokémon it has as `total`, and how many of those are Legendary as `legendary` — all in the same row.
-- My Solution:
SELECT COUNT(*) AS legendaries, ROUND(AVG(total_stats),1) AS avg_stats
FROM pokemon
WHERE is_legendary=TRUE;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-agg-physical-share
-- Difficulty: Hard
-- Challenge: Types spend their power differently: some punch with `attack`, some blast with `sp_attack`. For each `primary_type`, work out what share of its offence is physical — add up all the `attack` in the type, add up all the `sp_attack`, and divide the totals, as a percentage rounded to 1 decimal. Return `primary_type` and that number as `physical_share`, keeping only types whose Pokémon add up to at least 3000 `attack`. Sort by `physical_share` highest first, then `primary_type` A-Z. Divide the sums — not each Pokémon's own ratio.
-- My Solution:
SELECT primary_type, ROUND(SUM(attack)*100/(SUM(attack)+SUM(sp_attack)),1) AS physical_share
FROM pokemon
GROUP BY primary_type
HAVING SUM(attack)>=3000
ORDER BY physical_share DESC, primary_type ASC;

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-agg-type-variety
-- Difficulty: Hard
-- Challenge: How varied is each type? For every `primary_type`, return the type, how many Pokémon have it as `pokemon`, how many different `secondary_type` values pair with it as `partner_types`, how many different `classification` values it covers as `classifications`, and its average `total_stats` rounded to 1 decimal as `avg_stats`. Keep only types that pair with at least 10 different secondary types. Sort by `partner_types` highest first, then `primary_type` A-Z.
-- My Solution:
SELECT primary_type, COUNT(*) AS pokemon, COUNT(DISTINCT secondary_type) AS partner_types, COUNT(DISTINCT classification) AS classifications, ROUND(AVG(total_stats),1) AS avg_stats
FROM pokemon
GROUP BY primary_type
HAVING COUNT(DISTINCT secondary_type)>=10
ORDER BY partner_types DESC, primary_type ASC;