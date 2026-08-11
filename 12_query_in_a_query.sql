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
-- QUERY IN A QUERY
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-sub-legendary-types
-- Difficulty: Medium
-- Challenge: Some types have never produced a Mythical. Return the `name` and `primary_type` of every Pokémon whose `primary_type` is a type that **no** Mythical has. Use a subquery with NOT IN.
-- My Solution:
SELECT name, primary_type
FROM pokemon
WHERE primary_type NOT IN
  (SELECT primary_type 
  FROM pokemon 
  WHERE is_mythical=TRUE);


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-sub-above-avg
-- Difficulty: Hard
-- Challenge: Which Pokémon beat the average for their *own* type? Return `name`, `primary_type` and `total_stats` for every Pokémon whose `total_stats` is above the average `total_stats` of its own `primary_type`.
-- My Solution:
SELECT name, primary_type, total_stats 
FROM pokemon p1 
WHERE total_stats>
  (SELECT AVG(total_stats) 
  FROM pokemon p2
  WHERE p1.primary_type = p2.primary_type);


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-sub-signature-ability
-- Difficulty: Hard
-- Challenge: A signature ability belongs to exactly one Pokémon — nobody else in the game has it. Return the `name` and `ability` of every Legendary Pokémon's ability that no other Pokémon has. Abilities live in `pokemon_abilities`, one row per Pokémon per ability. Use NOT EXISTS. Sort by `name`, then `ability`.
-- My Solution:
SELECT name, ability 
FROM pokemon p 
LEFT JOIN pokemon_abilities pa
ON p.id=pa.pokemon_id
WHERE is_legendary=TRUE AND NOT EXISTS (
  SELECT ability FROM pokemon_abilities a 
  WHERE pa.ability = a.ability AND pa.pokemon_id<>a.pokemon_id  ) 
ORDER BY name, ability;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-sub-fastest-per-gen
-- Difficulty: Hard
-- Challenge: Who is the fastest Pokémon of each generation? Return `generation`, `name` and `speed` for every Pokémon whose `speed` equals the highest `speed` in its own generation — use a correlated subquery. If two Pokémon tie for their generation's top speed, both belong in the answer. Sort by `generation`, then `name` A-Z.
-- My Solution:
SELECT generation, name, speed
FROM pokemon p1
WHERE speed = (
  SELECT MAX(speed) 
  FROM pokemon p2 
  WHERE p1.generation=p2.generation)
ORDER BY generation, name;