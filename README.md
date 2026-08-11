# SQL Jam: Pokemon SQL Challenges
This repository is a collection of 48 practice SQL queries using a Pokémon dataset on SQL Jam, a free, in-browser query playground. 

This is part of my ongoing SQL practice and explores Pokemon data through progressively more complex queries, including filtering, aggregation, joins, subqueries, and other SQL techniques.

The challenges can be completed directly in SQL Jam: [Start the Pokemon SQL Challenges](https://sqljam.dev/?skin=pokemon&challenge=pokemon-select-name-type)

## 📊 Dataset
The pokemon dataset contains information about Pokemon species, alternate forms, abilitites, stats, and other attributes. 

1. Table: pokemon
    * id: INTEGER
    * name: VARCHAR
    * japanese_name: VARCHAR
    * classification: VARCHAR
    * generation: INTEGER
    * is_legendary: BOOLEAN
    * is_mythical: BOOLEAN
    * primary_type: VARCHAR
    * secondary_type: VARCHAR
    * hp: INTEGER
    * attack: INTEGER
    * defense: INTEGER
    * sp_attack: INTEGER
    * sp_defense: INTEGER
    * speed: INTEGER
    * total_stats: INTEGER
    * height_m: DOUBLE
    * weight_kg: DOUBLE
    * capture_rate: INTEGER
    * base_happiness: INTEGER
    * experience_growth: INTEGER
    * percentage_male: DOUBLE

2. Table: pokemon_forms
    * pokemon_id: INTEGER
    * form_name: VARCHAR
    * primary_type: VARCHAR
    * secondary_type: VARCHAR
    * hp: INTEGER
    * attack: INTEGER
    * defense: INTEGER
    * sp_attack: INTEGER
    * sp_defense: INTEGER
    * speed: INTEGER
    * total_stats: INTEGER
    * height_m: DOUBLE
    * weight_kg: DOUBLE

3. Table: pokemon_abilities
    * pokemon_id: INTEGER
    * ability: VARCHAR
