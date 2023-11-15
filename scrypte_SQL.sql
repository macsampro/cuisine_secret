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
DROP TYPE IF EXISTS INGREDIENT_TYPE_ENUM;
DROP TYPE IF EXISTS RecipeType_ENUM;


-- Création des types énumérés (types personnalisés)
CREATE TYPE Difficulty_ENUM AS ENUM ('facile', 'intermédiaire', 'difficile');
CREATE TYPE unit_enum AS ENUM ('l', 'ml', 'cl', 'dl', 'cuillère à soupe', 'cuillère à café', 'tasse', 'g', 'kg', 'mg', 'pincé');
CREATE TYPE INGREDIENT_TYPE_ENUM AS ENUM (
    'Épice',
    'Huile',
    'Légume',
    'Viande',
    'Poisson',
    'Fruit',
    'Céréale',
    'Produit laitier',
    'Protéine',
    'Sucre',
    'Boisson',
    'Condiment',
    'Noix et graines',
    'Herbes',
    'Champignon',
    'Pâtisserie',
    'Produit de la mer',
    'Légumineuse'
);

CREATE TYPE RecipeType_ENUM AS ENUM (
    'Italienne',
    'Française',
    'Marocaine',
    'Asiatique',
    'Américaine',
    'Mexicaine',
    'Indienne',
    'Méditerranéenne',
    'Végétarienne',
    'Végétalienne',
    'Sans gluten',
    'Rapide',
    'Dessert',
    'Petit-déjeuner',
    'Boisson'
);

-- Création de la table des utilisateurs
CREATE TABLE users (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR (255) unique NOT NULL,
    password_hash CHAR (60) NOT NULL,
    email VARCHAR (255) UNIQUE NOT NULL
);

-- Création de la table des recettes
CREATE TABLE recipes(
    id_recipe SERIAL PRIMARY KEY,
    title VARCHAR (255) NOT NULL,
    recipe_type RecipeType_ENUM not NULL,
    description VARCHAR (255) NOT NULL,
    time_preparation TIME NOT NULL,
    difficulty Difficulty_ENUM NOT NULL,
    creation_date DATE NOT NULL,
    id_user INT REFERENCES users(id_user) not NULL
);

-- Création de la table des photos associées aux recettes
CREATE TABLE photos(
    id_photo SERIAL PRIMARY KEY,
    name VARCHAR (255) NOT NULL,
    description VARCHAR (255) NOT NULL,
    size INT NOT NULL,
    mimetype VARCHAR (255) NOT NULL,
    id_recipe INT REFERENCES recipes(id_recipe)
);

-- Création de la table des ingrédients
CREATE TABLE ingredients (
    id_ingredient SERIAL PRIMARY KEY,
    ingredient_name VARCHAR(255) NOT NULL,
    ingredient_type INGREDIENT_TYPE_ENUM NOT NULL
);

-- Création de la table pour les quantités des ingrédients associées à une recette
CREATE TABLE quantity_ingredients(
        id_recipe INT REFERENCES recipes(id_recipe),
    id_ingredient INT REFERENCES ingredients(id_ingredient),
   PRIMARY key (id_recipe, id_ingredient)
);

-- Création de la table pour les étapes de préparation des recettes
CREATE TABLE preparation_steps (
    id_preparation_step SERIAL PRIMARY KEY,
    description VARCHAR (255) NOT NULL,
    order_step INT NOT NULL,
    id_recipe INT REFERENCES recipes(id_recipe)
);

-- Création de la table pour les favoris (liaison entre utilisateurs et recettes)
CREATE TABLE favoris (
    id_user INT REFERENCES users(id_user),
    id_recipe INT REFERENCES recipes(id_recipe),
    PRIMARY KEY (id_user, id_recipe)
);

-- Insertion des ingrédients
-- Insertion des ingrédients avec leur type
INSERT INTO ingredients(ingredient_name, ingredient_type) VALUES
-- Épices et Herbes
('Sel', 'Épice'),
('Poivre', 'Épice'),
('Cumin', 'Épice'),
('Coriandre moulue', 'Épice'),
('Paprika', 'Épice'),
('Curcuma', 'Épice'),
('Cannelle', 'Épice'),
('Gingembre', 'Épice'),
('Anis étoilé', 'Épice'),
('Cardamome', 'Épice'),
('Thym', 'Herbes'),
('Romarin', 'Herbes'),
('Basilic', 'Herbes'),
('Menthe', 'Herbes'),
('Persil', 'Herbes'),
('Sauge', 'Herbes'),
-- Huiles
('Huile olive', 'Huile'),
('Huile de sésame', 'Huile'),
('Huile de tournesol', 'Huile'),
-- Légumes
('Ail', 'Légume'),
('Oignon', 'Légume'),
('Tomate', 'Légume'),
('Carotte', 'Légume'),
('Pomme de terre', 'Légume'),
('Courgette', 'Légume'),
('Aubergine', 'Légume'),
('Chou', 'Légume'),
('Épinard', 'Légume'),
('Poivron', 'Légume'),
('Haricot vert', 'Légume'),
-- Viandes et Poissons
('Poulet', 'Viande'),
('Boeuf', 'Viande'),
('Agneau', 'Viande'),
('Porc', 'Viande'),
('Canard', 'Viande'),
('Thon', 'Poisson'),
('Saumon', 'Poisson'),
('Sardine', 'Poisson'),
-- Céréales et Féculents
('Riz', 'Céréale'),
('Pâtes', 'Céréale'),
('Semoule', 'Céréale'),
('Couscous', 'Céréale'),
('Quinoa', 'Céréale'),
('Lentilles', 'Légumineuse'),
('Pois chiches', 'Légumineuse'),
('Haricots rouges', 'Légumineuse'),
-- Produits laitiers et Œufs
('Lait', 'Produit laitier'),
('Fromage', 'Produit laitier'),
('Beurre', 'Produit laitier'),
('Crème fraîche', 'Produit laitier'),
('Yaourt', 'Produit laitier'),
('Oeuf', 'Protéine'),
-- Autres
('Sucre', 'Sucre'),
('Miel', 'Sucre'),
('Vinaigre', 'Condiment'),
('Sauce soja', 'Condiment'),
('Citron', 'Fruit'),
('Orange', 'Fruit'),
('Raisins secs', 'Fruit'),
('Amandes', 'Noix et graines'),
('Noix de cajou', 'Noix et graines'),
('Sésame', 'Noix et graines');

insert into users (username, password_hash,email) values
('aaa', '$2b$10$sNxOsx9D/FloPqmP2.kQyu.aZRqHRxWoSWxbHN4E2nSbGkR3fvkn6','aaa01@aaa.aa'),
('bbb', '$2b$10$Pjh488Pg00RhQTMuMxJIK.FRT/.r5B7bjhmPAuC7b5iHLiyeKDF5e','bbb01@aaa.aa'),
('ccc', 'ccc','ccc01@aaa.aa');



INSERT INTO recipes(title, recipe_type, description, time_preparation, difficulty, creation_date, id_user) VALUES
-- Italienne
('Spaghetti Bolognese', 'Italienne', 'Un classique italien avec une sauce à la viande riche.', '00:45:00', 'facile', '2023-10-12', 1),
('Pizza Margherita', 'Italienne', 'Une pizza simple avec de la tomate, du fromage et du basilic.', '01:00:00', 'facile', '2023-10-12', 1),
-- Française
('Ratatouille', 'Française', 'Un mélange de légumes cuits à la provençale.', '01:15:00', 'intermédiaire', '2023-10-12', 1),
('Quiche Lorraine', 'Française', 'Tarte salée à base de crème, d’œufs et de lardons.', '01:10:00', 'intermédiaire', '2023-10-12', 1),
-- Marocaine
('Tajine de poulet', 'Marocaine', 'Un plat marocain épicé avec du poulet et des légumes.', '01:30:00', 'intermédiaire', '2023-10-12', 1),
('Couscous royal', 'Marocaine', 'Un plat nord-africain à base de semoule, de légumes et de viandes variées.', '02:00:00', 'difficile', '2023-10-12', 1),
-- Asiatique
('Sushi maison', 'Asiatique', 'Des sushis frais faits maison avec du riz, du poisson et des légumes.', '02:00:00', 'difficile', '2023-10-12', 1),
('Pad Thaï', 'Asiatique', 'Un plat thaïlandais à base de nouilles de riz sautées.', '00:40:00', 'intermédiaire', '2023-10-12', 1),
-- Américaine
('Salade César', 'Américaine', 'Une salade simple avec du poulet grillé, de la laitue et des croûtons.', '00:30:00', 'facile', '2023-10-12', 1),
('Burger classique', 'Américaine', 'Un hamburger avec du bœuf, du fromage et des légumes.', '00:25:00', 'facile', '2023-10-12', 1),
-- Mexicaine
('Tacos', 'Mexicaine', 'Tortillas de maïs ou de blé remplies de viande et de légumes.', '00:35:00', 'facile', '2023-10-12', 1),
('Guacamole', 'Mexicaine', 'Une purée d’avocat épicée.', '00:15:00', 'facile', '2023-10-12', 1),
-- Indienne
('Poulet Tikka Masala', 'Indienne', 'Poulet mariné dans une sauce épicée et cuit au four.', '01:45:00', 'difficile', '2023-10-12', 1),
('Curry de légumes', 'Indienne', 'Un mélange de légumes dans une sauce au curry.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
-- Méditerranéenne
('Gazpacho', 'Méditerranéenne', 'Soupe froide à base de légumes crus.', '00:20:00', 'facile', '2023-10-12', 1),
('Paella', 'Méditerranéenne', 'Un plat espagnol à base de riz et de fruits de mer.', '01:40:00', 'intermédiaire', '2023-10-12', 1),
-- Végétarienne
('Salade grecque', 'Végétarienne', 'Salade à base de concombre, tomate, oignon et feta.', '00:15:00', 'facile', '2023-10-12', 1),
('Risotto aux champignons', 'Végétarienne', 'Risotto crémeux aux champignons.', '00:50:00', 'intermédiaire', '2023-10-12', 1),
-- Végétalienne
('Smoothie vert', 'Végétalienne', 'Smoothie à base de légumes verts et de fruits.', '00:10:00', 'facile', '2023-10-12', 1),
('Tofu sauté', 'Végétalienne', 'Tofu sauté avec des légumes.', '00:30:00', 'facile', '2023-10-12', 1),
-- Sans gluten
('Brownies sans gluten', 'Sans gluten', 'Brownies au chocolat sans farine.', '00:40:00', 'facile', '2023-10-12', 1),
('Pancakes sans gluten', 'Sans gluten', 'Pancakes à base de farine de riz.', '00:20:00', 'facile', '2023-10-12', 1),
-- Rapide
('Omelette', 'Rapide', 'Omelette aux herbes.', '00:10:00', 'facile', '2023-10-12', 1),
('Sandwich au jambon', 'Rapide', 'Sandwich simple au jambon et fromage.', '00:05:00', 'facile', '2023-10-12', 1),
-- Dessert
('Tiramisu', 'Dessert', 'Dessert italien à base de mascarpone.', '00:30:00', 'facile', '2023-10-12', 1),
('Mousse au chocolat', 'Dessert', 'Mousse légère au chocolat.', '00:20:00', 'facile', '2023-10-12', 1),
-- Petit-déjeuner
('Pancakes', 'Petit-déjeuner', 'Crêpes épaisses servies au petit-déjeuner.', '00:20:00', 'facile', '2023-10-12', 1),
('Smoothie aux fruits', 'Petit-déjeuner', 'Smoothie à base de fruits variés.', '00:10:00', 'facile', '2023-10-12', 1),
-- Boisson
('Mojito', 'Boisson', 'Cocktail à base de rhum, menthe et citron vert.', '00:10:00', 'facile', '2023-10-12', 1),
('Smoothie à la banane', 'Boisson', 'Smoothie à base de banane et de lait.', '00:05:00', 'facile', '2023-10-12', 1);



