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
-- JOIN TABLES
-- ============================================================

-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-join-levitate
-- Difficulty: Medium
-- Challenge: Which Pokémon float? Return the `name` and `primary_type` of every Pokémon with the ability 'Levitate'. Abilities live in `pokemon_abilities`.
-- My Solution:
SELECT name, primary_type
FROM pokemon p
LEFT JOIN pokemon_abilities pa
ON p.id=pa.pokemon_id
WHERE pa.ability='Levitate';


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-join-legendary-abilities
-- Difficulty: Hard
-- Challenge: Which abilities show up again and again on Legendaries? Return the `ability` and how many Legendary Pokémon have it as `legendaries`, for abilities held by at least 3 of them.
-- My Solution:
SELECT ability, COUNT(*) AS legendaries
FROM pokemon p
LEFT JOIN pokemon_abilities pa
ON p.id=pa.pokemon_id
WHERE is_legendary=TRUE 
GROUP BY ability
HAVING COUNT(*)>=3;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-join-forms-roster
-- Difficulty: Medium
-- Challenge: Some Pokémon have alternate forms — regional variants like Alolan Raichu, and battle formes like Darmanitan's Zen Mode. They live in their own table, `pokemon_forms`. Return the species `name` and the `form_name` of every alternate form in the game.
-- My Solution:
SELECT name, form_name
FROM pokemon p
LEFT JOIN pokemon_forms pa
ON p.id=pa.pokemon_id
WHERE form_name IS NOT NULL;


-- https://sqljam.dev/?skin=pokemon&challenge=pokemon-join-forms-retype
-- Difficulty: Hard
-- Challenge: A form can change a Pokémon's type entirely — Galarian Darmanitan is ice, not fire. Return the species `name`, its `primary_type` as `species_type`, the `form_name`, and the form's `primary_type` as `form_type`, for every form whose primary type differs from its species'.
-- My Solution:
SELECT p.name, p.primary_type AS species_type, pf.form_name, pf.primary_type AS form_type
FROM pokemon p
LEFT JOIN pokemon_forms pf
ON p.id=pf.pokemon_id
WHERE species_type<>form_type;
