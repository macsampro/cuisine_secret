-- Suppression des tables en commençant par celles sans dépendances
DROP TABLE IF EXISTS photos;
DROP TABLE IF EXISTS preparation_steps;
DROP TABLE IF EXISTS quantity_ingredients;
DROP TABLE IF EXISTS favoris;
-- Suppression des tables avec dépendances (CASCADE permet la suppression en cascade)
DROP TABLE IF EXISTS recipes CASCADE;
DROP TABLE IF EXISTS ingredients CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Suppression des types personnalisés
DROP TYPE IF EXISTS Difficulty_ENUM;
DROP TYPE IF EXISTS unit_enum;

-- Création des types énumérés (types personnalisés)
CREATE TYPE Difficulty_ENUM AS ENUM ('facile', 'intermédiaire', 'difficile');
CREATE TYPE unit_enum AS ENUM ('l', 'ml', 'cl', 'dl', 'cuillère à soupe', 'cuillère à café', 'tasse', 'g', 'kg', 'mg', 'pincé');

-- Création de la table des utilisateurs
CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR (255) NOT NULL,
    password_hash CHAR (255) NOT NULL,
    email VARCHAR (255) UNIQUE NOT NULL
);

-- Création de la table des recettes
CREATE TABLE recipes(
    id_recipe SERIAL PRIMARY KEY,
    title VARCHAR (255) NOT NULL,
    description VARCHAR (255) NOT NULL,
    time_preparation TIME NOT NULL,
    Difficulty Difficulty_ENUM NOT NULL,
    creation_date DATE NOT NULL,
    id_user INT REFERENCES users(id_user)  -- Clé étrangère vers la table users
);

-- Création de la table des photos associées aux recettes
CREATE TABLE photos(
    id_photo SERIAL PRIMARY KEY,
    name VARCHAR (255) NOT NULL,
    description VARCHAR (255) NOT NULL,
    size INT NOT NULL,
    mimetype VARCHAR (255) NOT NULL,
    id_recipe INT REFERENCES recipes(id_recipe)  -- Clé étrangère vers la table recipes
);

-- Création de la table des ingrédients
CREATE TABLE ingredients(
    id_ingredient SERIAL PRIMARY KEY,
    name_ingredient VARCHAR (255) NOT NULL
);

-- Création de la table pour les quantités des ingrédients associées à une recette
CREATE TABLE quantity_ingredients(
    id_quantity_ingredients SERIAL PRIMARY KEY,
    quantity INT NOT NULL,
    unit unit_enum NOT NULL,  -- Utilisation du type énuméré pour les unités
    id_recipe INT REFERENCES recipes(id_recipe),      -- Clé étrangère vers la table recipes
    id_Ingredient INT REFERENCES ingredients(id_ingredient)  -- Clé étrangère vers la table ingredients
);

-- Création de la table pour les étapes de préparation des recettes
CREATE TABLE preparation_steps (
    id_preparation_step SERIAL PRIMARY KEY,
    description VARCHAR (255) NOT NULL,
    order_step INT NOT NULL,
    id_recipe INT REFERENCES recipes(id_recipe)  -- Clé étrangère vers la table recipes
);

-- Création de la table pour les favoris (liaison entre utilisateurs et recettes)
CREATE TABLE favoris (
    id_user INT REFERENCES users(id_user),      -- Clé étrangère vers la table users
    id_recipe INT REFERENCES recipes(id_recipe),  -- Clé étrangère vers la table recipes
    PRIMARY KEY (id_user, id_recipe)  -- Combinaison de clés pour éviter les doublons
);
