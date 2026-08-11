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
-- KEEP UNMATCHED ROWS
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-left-dragon-levitate
-- Difficulty: Medium
-- Challenge: List every dragon-type Pokémon and, if it has one, its 'Levitate' ability — `name` and `ability`. Dragons without it should still appear, with NULL in the `ability` column.
-- My Solution:
SELECT p.name, pa.ability 
FROM pokemon p 
LEFT JOIN pokemon_abilities pa ON p.id = pa.pokemon_id AND pa.ability = 'Levitate'
WHERE p.primary_type = 'dragon';


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-left-legendary-no-pressure
-- Difficulty: Hard
-- Challenge: 'Pressure' is the classic Legendary ability — but plenty of Legendaries don't have it. Return the `name` of every Legendary Pokémon that does **not** have the ability 'Pressure'.
-- My Solution:
SELECT name--, ability
FROM pokemon p 
LEFT JOIN pokemon_abilities pa 
ON p.id=pa.pokemon_id AND ability='Pressure'
WHERE is_legendary AND pokemon_id IS NULL;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-left-forms-none
-- Difficulty: Hard
-- Challenge: Most Legendaries have exactly one form and no variants. Return the `name` of every Legendary Pokémon that has **no** row in `pokemon_forms` at all.
-- My Solution:
SELECT name--, form_name
FROM pokemon p LEFT JOIN pokemon_forms pf
ON p.id=pf.pokemon_id 
WHERE is_legendary=TRUE AND form_name IS NULL;