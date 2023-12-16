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

CREATE TYPE unit_enum AS ENUM (
    'l', 'ml', 'cl', 'dl', 
    'cuillère à soupe', 'cuillère à café', 'tasse', 
    'g', 'kg', 'mg', 'pincé'
);

CREATE TYPE INGREDIENT_TYPE_ENUM AS ENUM (
    'Épice', 'Huile', 'Légume', 'Viande', 'Poisson', 
    'Fruit', 'Céréale', 'Produit laitier', 'Protéine', 
    'Sucre', 'Boisson', 'Condiment', 'Noix et graines', 
    'Herbes', 'Champignon', 'Pâtisserie', 
    'Produit de la mer', 'Légumineuse', 'Autre'
);

CREATE TYPE RecipeType_ENUM AS ENUM (
    'Italienne', 'Française', 'Marocaine', 'Asiatique', 
    'Américaine', 'Mexicaine', 'Indienne', 'Méditerranéenne', 
    'Végétarienne', 'Végétalienne', 'Sans gluten', 
    'Rapide', 'Dessert', 'Petit-déjeuner', 'Boisson',
    'Africaine', 'Européenne', 'Américaine du Sud', 
    'Moyen-Orient', 'Fusion'
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

-- Insertion des ingrédients (combinant les vôtres et les nouveaux)
INSERT INTO ingredients (ingredient_name, ingredient_type) VALUES
-- Vos épices et herbes
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

-- Vos huiles
('Huile olive', 'Huile'),
('Huile de sésame', 'Huile'),
('Huile de tournesol', 'Huile'),

-- Vos légumes
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

-- Vos viandes et poissons
('Poulet', 'Viande'),
('Boeuf', 'Viande'),
('Agneau', 'Viande'),
('Porc', 'Viande'),
('Canard', 'Viande'),
('Thon', 'Poisson'),
('Saumon', 'Poisson'),
('Sardine', 'Poisson'),

-- Vos céréales et féculents
('Riz', 'Céréale'),
('Pâtes', 'Céréale'),
('Semoule', 'Céréale'),
('Couscous', 'Céréale'),
('Quinoa', 'Céréale'),
('Lentilles', 'Légumineuse'),
('Pois chiches', 'Légumineuse'),
('Haricots rouges', 'Légumineuse'),

-- Vos produits laitiers et œufs
('Lait', 'Produit laitier'),
('Fromage', 'Produit laitier'),
('Beurre', 'Produit laitier'),
('Crème fraîche', 'Produit laitier'),
('Yaourt', 'Produit laitier'),
('Oeuf', 'Protéine'),

-- Vos autres ingrédients
('Sucre', 'Sucre'),
('Miel', 'Sucre'),
('Vinaigre', 'Condiment'),
('Sauce soja', 'Condiment'),
('Citron', 'Fruit'),
('Orange', 'Fruit'),
('Raisins secs', 'Fruit'),
('Amandes', 'Noix et graines'),
('Noix de cajou', 'Noix et graines'),
('Sésame', 'Noix et graines'),

-- Nouveaux ingrédients ajoutés
('Saffran', 'Épice'),
('Curry', 'Épice'),
('Coriandre', 'Herbes'),

('Huile darachide', 'Huile'),
('Huile de colza', 'Huile'),

('Manioc', 'Légume'),
('Igname', 'Légume'),
('Gombo', 'Légume'),
('Piment', 'Légume'),
('Maïs', 'Légume'),
('Bambara', 'Légume'),
('Taro', 'Légume'),

('Chèvre', 'Viande'),
('Mouton', 'Viande'),
('Cabillaud', 'Poisson'),
('Tilapia', 'Poisson'),
('Mérou', 'Poisson'),

('Mangue', 'Fruit'),
('Papaye', 'Fruit'),
('Banane plantain', 'Fruit'),

('Fromage de chèvre', 'Produit laitier'),

('Riz Basmati', 'Céréale'),
('Lentilles vertes', 'Légumineuse'),
('Haricots noirs', 'Légumineuse'),
('Tofu', 'Protéine'),
('Lait de coco', 'Boisson'),
('Jus de tamarin', 'Boisson'),
('Lait fermenté', 'Boisson'),

('Millet', 'Céréale'),
('Sorgho', 'Céréale'),
('Teff', 'Céréale'),
('Fonio', 'Céréale');


insert into users (username, password_hash,email) values
('aaa', '$2b$10$sNxOsx9D/FloPqmP2.kQyu.aZRqHRxWoSWxbHN4E2nSbGkR3fvkn6','aaa01@aaa.aa'),
('bbb', '$2b$10$Pjh488Pg00RhQTMuMxJIK.FRT/.r5B7bjhmPAuC7b5iHLiyeKDF5e','bbb01@aaa.aa'),
('ccc', 'ccc','ccc01@aaa.aa');







INSERT INTO recipes(title, recipe_type, description, time_preparation, difficulty, creation_date, id_user) values
('Curry de Poulet aux Légumes', 'Indienne', 'Poulet tendre et légumes dans une sauce curry épicée.', '01:00:00', 'intermédiaire', '2023-12-14', 1);


INSERT INTO preparation_steps (description, order_step, id_recipe) VALUES
('Couper le poulet en morceaux et mariner avec du curcuma, du cumin, du sel et du poivre.', 1, 1),
('Faire revenir les oignons et l’ail dans l’huile de tournesol, puis ajouter le poulet.', 2, 1),
('Ajouter le curry, le gingembre, et les légumes coupés (carotte, pomme de terre, poivron).', 3, 1),
('Ajouter la tomate concassée et le lait de coco, puis laisser mijoter.', 4, 1),
('Cuire jusqu’à ce que le poulet soit bien cuit et les légumes tendres.', 5, 1),
('Garnir de coriandre fraîche avant de servir.', 6, 1);



INSERT INTO quantity_ingredients (id_recipe, id_ingredient) VALUES
(1, 31),  -- Poulet
(1, 6),   -- Curcuma
(1, 3),   -- Cumin
(1, 1),   -- Sel
(1, 2),   -- Poivre
(1, 21),  -- Oignon
(1, 20),  -- Ail
(1, 19),  -- Huile de tournesol
(1, 64),  -- Curry
(1, 8),   -- Gingembre
(1, 23),  -- Carotte
(1, 24),  -- Pomme de terre
(1, 29),  -- Poivron
(1, 22),  -- Tomate
(1, 88),  -- Lait de coco
(1, 65);  -- Coriandre

-- example de recette:
-- Ajout de la recette Paella Valenciana
INSERT INTO recipes(title, recipe_type, description, time_preparation, difficulty, creation_date, id_user) values
('Paella Valenciana', 'Méditerranéenne', 'Riz aromatique avec fruits de mer, poulet et légumes.', '01:45:00', 'intermédiaire', '2023-12-17', 1);


INSERT INTO preparation_steps (description, order_step, id_recipe) VALUES
('Faire dorer le poulet coupé en morceaux dans de l’huile d’olive.', 1, 10),
('Ajouter l’oignon, l’ail, les poivrons et faire revenir.', 2, 10),
('Incorporer le riz et le faire revenir jusqu’à ce qu’il soit légèrement doré.', 3, 10),
('Ajouter le safran, le paprika, les tomates, le bouillon de poulet et porter à ébullition.', 4, 10),
('Ajouter les fruits de mer et laisser mijoter jusqu’à ce que le riz soit cuit.', 5, 10),
('Garnir avec des petits pois et des tranches de citron avant de servir.', 6, 10);

-- Quantité des ingrédients pour la Paella Valenciana
INSERT INTO quantity_ingredients (id_recipe, id_ingredient) VALUES
(10, 31),  -- Poulet
(10, 17),  -- Huile d'olive
(10, 21),  -- Oignon
(10, 20),  -- Ail
(10, 29),  -- Poivron
(10, 39),  -- Riz
(10, 63),  -- Safran
(10, 5),   -- Paprika
(10, 22),  -- Tomate
(10, 57);  -- Citron





