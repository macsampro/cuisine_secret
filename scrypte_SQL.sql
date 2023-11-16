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

-- Italienne
('Lasagne à la Bolognaise', 'Italienne', 'Lasagne traditionnelle avec une riche sauce à la viande et béchamel.', '01:30:00', 'intermédiaire', '2023-10-12', 1),
('Risotto aux champignons', 'Italienne', 'Risotto crémeux aux champignons porcini et parmesan.', '00:50:00', 'intermédiaire', '2023-10-12', 1),
('Pesto Genovese', 'Italienne', 'Sauce traditionnelle au basilic, pignons de pin et fromage Parmigiano-Reggiano.', '00:20:00', 'facile', '2023-10-12', 1),
('Minestrone', 'Italienne', 'Soupe épaisse aux légumes, haricots et pâtes.', '01:10:00', 'facile', '2023-10-12', 1),
('Tiramisu', 'Italienne', 'Dessert classique au café et mascarpone.', '00:40:00', 'intermédiaire', '2023-10-12', 1),
('Gnocchi à la pomme de terre', 'Italienne', 'Gnocchi maison servis avec une sauce tomate et basilic.', '02:00:00', 'difficile', '2023-10-12', 1),
('Osso buco', 'Italienne', 'Jarrets de veau braisés avec des légumes et du vin blanc.', '02:30:00', 'difficile', '2023-10-12', 1),
('Focaccia', 'Italienne', 'Pain plat italien aromatisé à huile olive et au romarin.', '01:20:00', 'intermédiaire', '2023-10-12', 1),
('Saltimbocca', 'Italienne', 'Escalopes de veau avec jambon de Parme et sauge.', '00:30:00', 'facile', '2023-10-12', 1),
('Caprese', 'Italienne', 'Salade simple de tomates, mozzarella et basilic.', '00:15:00', 'facile', '2023-10-12', 1),

-- Française (Exemples)
('Bœuf Bourguignon', 'Française', 'Ragoût de bœuf lentement mijoté au vin rouge avec des légumes.', '03:00:00', 'difficile', '2023-10-12', 1),
('Soupe à l oignon', 'Française', 'Soupe riche à base de oignons caramélisés, servie avec du fromage gratiné.', '01:20:00', 'intermédiaire', '2023-10-12', 1),
('Coq au vin', 'Française', 'Poulet braisé au vin rouge avec champignons, lardons et oignons.', '02:00:00', 'difficile', '2023-10-12', 1),
('Ratatouille', 'Française', 'Un mélange de légumes cuits à la provençale.', '01:15:00', 'intermédiaire', '2023-10-12', 1),
('Quiche Lorraine', 'Française', 'Tarte salée à base de crème, d’œufs et de lardons.', '01:10:00', 'intermédiaire', '2023-10-12', 1),
-- Marocaine
('Tajine de poulet', 'Marocaine', 'Un plat marocain épicé avec du poulet et des légumes.', '01:30:00', 'intermédiaire', '2023-10-12', 1),
('Couscous royal', 'Marocaine', 'Un plat nord-africain à base de semoule, de légumes et de viandes variées.', '02:00:00', 'difficile', '2023-10-12', 1),
('Harira', 'Marocaine', 'Soupe traditionnelle riche en tomates, lentilles et pois chiches.', '02:00:00', 'intermédiaire', '2023-10-12', 1),
('Pastilla au poulet', 'Marocaine', 'Tourte feuilletée farcie au poulet et aux amandes, parfumée à la cannelle.', '02:30:00', 'difficile', '2023-10-12', 1),
('Kefta Tagine', 'Marocaine', 'Boulettes de viande hachée aux épices cuites dans une sauce tomate.', '01:20:00', 'intermédiaire', '2023-10-12', 1),
('Briouats', 'Marocaine', 'Petits triangles feuilletés farcis à la viande ou aux légumes.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Poulet au citron confit', 'Marocaine', 'Poulet braisé aux citrons confits et olives.', '01:50:00', 'intermédiaire', '2023-10-12', 1),
('Méchoui', 'Marocaine', 'Agneau rôti lentement sur un feu de bois.', '04:00:00', 'difficile', '2023-10-12', 1),
('Salade marocaine', 'Marocaine', 'Salade fraîche de tomates, concombres, oignons et herbes.', '00:20:00', 'facile', '2023-10-12', 1),
('Zaalouk', 'Marocaine', 'Caviar de aubergines épicé.', '00:45:00', 'facile', '2023-10-12', 1),

-- Asiatique
('Sushi maison', 'Asiatique', 'Des sushis frais faits maison avec du riz, du poisson et des légumes.', '02:00:00', 'difficile', '2023-10-12', 1),
('Pad Thaï', 'Asiatique', 'Un plat thaïlandais à base de nouilles de riz sautées.', '00:40:00', 'intermédiaire', '2023-10-12', 1),
('Curry rouge thaï', 'Asiatique', 'Curry épicé avec lait de coco, poulet et bambou.', '01:10:00', 'intermédiaire', '2023-10-12', 1),
('Pho', 'Asiatique', 'Soupe vietnamienne au bœuf avec nouilles de riz, herbes fraîches et bouillon parfumé.', '02:30:00', 'intermédiaire', '2023-10-12', 1),
('Bibimbap', 'Asiatique', 'Plat coréen avec riz, légumes variés, bœuf et œuf au plat.', '00:50:00', 'intermédiaire', '2023-10-12', 1),
('Dim Sum', 'Asiatique', 'Assortiment de bouchées vapeur chinoises.', '01:30:00', 'difficile', '2023-10-12', 1),
('Ramen', 'Asiatique', 'Soupe japonaise aux nouilles, avec bouillon de viande ou de poisson.', '02:00:00', 'intermédiaire', '2023-10-12', 1),
('Nasi Goreng', 'Asiatique', 'Riz frit indonésien avec œufs, poulet et légumes.', '00:30:00', 'facile', '2023-10-12', 1),
('Dumplings', 'Asiatique', 'Raviolis chinois farcis, cuits à la vapeur ou frits.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Poulet Tandoori', 'Asiatique', 'Poulet mariné aux épices et cuit dans un four Tandoori.', '01:20:00', 'intermédiaire', '2023-10-12', 1),
-- Américaine
('Burger classique', 'Américaine', 'Un hamburger avec du bœuf, du fromage et des légumes.', '00:25:00', 'facile', '2023-10-12', 1),
('Ribs barbecue', 'Américaine', 'Ribs de porc lentement grillés avec sauce barbecue.', '03:00:00', 'intermédiaire', '2023-10-12', 1),
('Poulet frit', 'Américaine', 'Poulet croustillant frit à la perfection, accompagné de sauce barbecue.', '01:00:00', 'facile', '2023-10-12', 1),
('Macaroni and cheese', 'Américaine', 'Plat de pâtes crémeux au fromage cheddar.', '00:40:00', 'facile', '2023-10-12', 1),
('Clam Chowder', 'Américaine', 'Soupe de palourdes épaisse et crémeuse typique de la Nouvelle-Angleterre.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Jambalaya', 'Américaine', 'Plat de Louisiane avec riz, crevettes, saucisse et poulet.', '01:20:00', 'intermédiaire', '2023-10-12', 1),
('Chili con carne', 'Américaine', 'Ragoût épicé de viande hachée, tomates et haricots.', '02:00:00', 'intermédiaire', '2023-10-12', 1),
('Key Lime Pie', 'Américaine', 'Tarte aux citrons verts et à la crème, sur une base de biscuit.', '01:10:00', 'intermédiaire', '2023-10-12', 1),
('Gumbo', 'Américaine', 'Ragoût épais de Louisiane avec poulet, saucisse et fruits de mer.', '02:30:00', 'difficile', '2023-10-12', 1),
('Cornbread', 'Américaine', 'Pain de maïs moelleux, souvent servi avec du chili ou en accompagnement.', '00:40:00', 'facile', '2023-10-12', 1),

-- Mexicaine
('Tacos', 'Mexicaine', 'Tortillas de maïs ou de blé remplies de viande et de légumes.', '00:35:00', 'facile', '2023-10-12', 1),
('Guacamole', 'Mexicaine', 'Une purée d’avocat épicée.', '00:15:00', 'facile', '2023-10-12', 1),
('Enchiladas', 'Mexicaine', 'Tortillas roulées farcies de viande et recouvertes de sauce épicée.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Quesadillas', 'Mexicaine', 'Tortillas grillées farcies de fromage et d’autres garnitures.', '00:20:00', 'facile', '2023-10-12', 1),
('Chiles Rellenos', 'Mexicaine', 'Piments farcis au fromage ou à la viande, puis frits.', '01:30:00', 'difficile', '2023-10-12', 1),
('Pozole', 'Mexicaine', 'Soupe traditionnelle à base de maïs, de viande et garnie de chou, radis et avocat.', '02:00:00', 'difficile', '2023-10-12', 1),
('Tamales', 'Mexicaine', 'Maïs farci cuit à la vapeur dans une feuille de maïs.', '03:00:00', 'difficile', '2023-10-12', 1),
('Mole Poblano', 'Mexicaine', 'Poulet dans une sauce riche à base de chocolat et de piments.', '04:00:00', 'difficile', '2023-10-12', 1),
('Sopa de Tortilla', 'Mexicaine', 'Soupe épicée avec des tortillas croustillantes, avocat, fromage et crème.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Ceviche', 'Mexicaine', 'Poisson cru mariné dans du jus de citron vert avec des oignons, des tomates et des piments.', '00:30:00', 'facile', '2023-10-12', 1),
-- Indienne
('Poulet Tikka Masala', 'Indienne', 'Poulet mariné dans une sauce épicée et cuit au four.', '01:45:00', 'difficile', '2023-10-12', 1),
('Curry de légumes', 'Indienne', 'Un mélange de légumes dans une sauce au curry.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Biryani', 'Indienne', 'Riz basmati parfumé cuit avec du poulet, des épices et du safran.', '01:30:00', 'difficile', '2023-10-12', 1),
('Palak Paneer', 'Indienne', 'Épinards crémeux avec du fromage paneer.', '00:50:00', 'intermédiaire', '2023-10-12', 1),
('Chana Masala', 'Indienne', 'Curry de pois chiches épicé.', '00:45:00', 'facile', '2023-10-12', 1),
('Butter Chicken', 'Indienne', 'Poulet cuit dans une sauce crémeuse au beurre et aux tomates.', '01:10:00', 'intermédiaire', '2023-10-12', 1),
('Naan', 'Indienne', 'Pain plat indien cuit dans un four tandoori.', '02:00:00', 'difficile', '2023-10-12', 1),
('Daal', 'Indienne', 'Lentilles épicées cuites jusqu à ce que elles soient tendres.', '00:40:00', 'facile', '2023-10-12', 1),
('Raita', 'Indienne', 'Yogourt frais mélangé avec des concombres, des épices et des herbes.', '00:15:00', 'facile', '2023-10-12', 1),
('Samosas', 'Indienne', 'Beignets farcis de pommes de terre, pois et épices.', '01:20:00', 'intermédiaire', '2023-10-12', 1),

-- Méditerranéenne
('Houmous', 'Méditerranéenne', 'Purée de pois chiches avec tahini, huile d’olive, citron et ail.', '00:30:00', 'facile', '2023-10-12', 1),
('Moussaka', 'Méditerranéenne', 'Plat d’aubergines gratinées avec de la viande hachée et béchamel.', '01:50:00', 'difficile', '2023-10-12', 1),
('Taboulé', 'Méditerranéenne', 'Salade de persil, tomates, menthe et boulgour.', '00:20:00', 'facile', '2023-10-12', 1),
('Gazpacho', 'Méditerranéenne', 'Soupe froide à base de légumes crus.', '00:20:00', 'facile', '2023-10-12', 1),
('Paella', 'Méditerranéenne', 'Plat espagnol à base de riz et de fruits de mer.', '01:40:00', 'intermédiaire', '2023-10-12', 1),
('Tzatziki', 'Méditerranéenne', 'Sauce ou dip grec à base de yaourt, concombre et ail.', '00:15:00', 'facile', '2023-10-12', 1),
('Ratatouille', 'Méditerranéenne', 'Ragoût de légumes provençal.', '01:10:00', 'intermédiaire', '2023-10-12', 1),
('Falafel', 'Méditerranéenne', 'Boulettes de pois chiches frites.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Souvlaki', 'Méditerranéenne', 'Brochettes de viande grillée, souvent servies avec du pain pita.', '00:45:00', 'facile', '2023-10-12', 1),
('Baklava', 'Méditerranéenne', 'Dessert feuilleté sucré avec noix et sirop.', '02:00:00', 'difficile', '2023-10-12', 1),

-- Végétarienne
('Salade Caprese', 'Végétarienne', 'Salade italienne avec tomates, mozzarella et basilic.', '00:15:00', 'facile', '2023-10-12', 1),
('Quiche aux légumes', 'Végétarienne', 'Tarte salée aux œufs, crème et légumes variés.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Chili végétarien', 'Végétarienne', 'Chili sans viande avec haricots, tomates et épices.', '00:50:00', 'facile', '2023-10-12', 1),
('Ratatouille', 'Végétarienne', 'Ragoût de légumes provençal.', '01:10:00', 'intermédiaire', '2023-10-12', 1),
('Curry de légumes', 'Végétarienne', 'Curry indien riche en légumes variés.', '00:45:00', 'intermédiaire', '2023-10-12', 1),
('Soupe de lentilles', 'Végétarienne', 'Soupe nourrissante de lentilles avec légumes et herbes.', '00:40:00', 'facile', '2023-10-12', 1),
('Pasta primavera', 'Végétarienne', 'Pâtes avec une sauce légère et des légumes de printemps.', '00:30:00', 'facile', '2023-10-12', 1),
('Risotto aux asperges', 'Végétarienne', 'Risotto crémeux avec des asperges fraîches.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Salade grecque', 'Végétarienne', 'Salade à base de concombre, tomate, oignon, feta et olives.', '00:20:00', 'facile', '2023-10-12', 1),
('Tofu stir-fry', 'Végétarienne', 'Tofu sauté avec un assortiment de légumes et sauce soja.', '00:30:00', 'facile', '2023-10-12', 1),

-- Végétalienne
('Curry de pois chiches', 'Végétalienne', 'Curry épicé de pois chiches avec tomates et épices indiennes.', '00:45:00', 'facile', '2023-10-12', 1),
('Soupe de lentilles rouges', 'Végétalienne', 'Soupe riche et épicée à base de lentilles rouges et légumes.', '00:40:00', 'facile', '2023-10-12', 1),
('Salade de quinoa', 'Végétalienne', 'Salade fraîche de quinoa avec légumes et vinaigrette citronnée.', '00:30:00', 'facile', '2023-10-12', 1),
('Chili sin carne', 'Végétalienne', 'Version végétalienne du chili avec haricots, maïs et protéines de soja.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Buddha bowl', 'Végétalienne', 'Bol nutritif composé de légumes variés, légumineuses et graines.', '00:20:00', 'facile', '2023-10-12', 1),
('Falafel', 'Végétalienne', 'Boulettes de pois chiches frites, servies avec tahini.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Ratatouille', 'Végétalienne', 'Ragoût de légumes provençal.', '01:10:00', 'intermédiaire', '2023-10-12', 1),
('Spaghetti à l ail et huile de olive', 'Végétalienne', 'Pâtes simples avec ail, huile de olive et piments.', '00:25:00', 'facile', '2023-10-12', 1),
('Houmous', 'Végétalienne', 'Purée de pois chiches avec tahini, huile d’olive, citron et ail.', '00:30:00', 'facile', '2023-10-12', 1),
('Smoothie vert', 'Végétalienne', 'Smoothie à base de légumes verts et de fruits.', '00:10:00', 'facile', '2023-10-12', 1),

-- Sans gluten
('Salade Niçoise', 'Sans gluten', 'Salade composée avec thon, œufs, haricots verts et olives.', '00:30:00', 'facile', '2023-10-12', 1),
('Poulet au curry et riz basmati', 'Sans gluten', 'Poulet en sauce curry accompagné de riz basmati.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Risotto aux fruits de mer', 'Sans gluten', 'Risotto crémeux avec un assortiment de fruits de mer.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Pavlova aux fruits', 'Sans gluten', 'Meringue croustillante garnie de crème fouettée et de fruits frais.', '01:30:00', 'difficile', '2023-10-12', 1),
('Frittata aux légumes', 'Sans gluten', 'Omelette épaisse italienne cuite au four avec légumes.', '00:45:00', 'facile', '2023-10-12', 1),
('Salade de quinoa aux légumes', 'Sans gluten', 'Salade de quinoa avec une variété de légumes frais.', '00:20:00', 'facile', '2023-10-12', 1),
('Soupe de poisson', 'Sans gluten', 'Soupe riche en poissons et fruits de mer avec des herbes.', '01:20:00', 'intermédiaire', '2023-10-12', 1),
('Chili sans gluten', 'Sans gluten', 'Chili traditionnel sans gluten.', '01:00:00', 'intermédiaire', '2023-10-12', 1),
('Steak grillé et légumes', 'Sans gluten', 'Steak parfaitement grillé servi avec des légumes rôtis.', '00:40:00', 'facile', '2023-10-12', 1),
('Gâteau aux amandes', 'Sans gluten', 'Gâteau moelleux à base de farine de amande.', '01:00:00', 'intermédiaire', '2023-10-12', 1),

-- Rapide
('Omelette', 'Rapide', 'Omelette aux herbes.', '00:10:00', 'facile', '2023-10-12', 1),
('Salade César', 'Rapide', 'Une salade simple avec du poulet grillé, de la laitue et des croûtons.', '00:30:00', 'facile', '2023-10-12', 1),
('Sandwich au jambon', 'Rapide', 'Sandwich simple au jambon et fromage.', '00:05:00', 'facile', '2023-10-12', 1),
('Pâtes à l ail et au parmesan', 'Rapide', 'Pâtes rapides avec de l ail, du parmesan et de l huile de olive.', '00:20:00', 'facile', '2023-10-12', 1),
('Quesadillas', 'Rapide', 'Tortillas grillées farcies de fromage et d’autres garnitures.', '00:15:00', 'facile', '2023-10-12', 1),
('Salade de thon', 'Rapide', 'Salade rapide de thon en conserve avec mayonnaise et légumes.', '00:10:00', 'facile', '2023-10-12', 1),
('Soupe de nouilles instantanée', 'Rapide', 'Nouilles instantanées avec bouillon et légumes.', '00:10:00', 'facile', '2023-10-12', 1),
('Wraps de poulet', 'Rapide', 'Tortillas roulées avec poulet, laitue et sauce.', '00:15:00', 'facile', '2023-10-12', 1),
('Pesto de roquette et pâtes', 'Rapide', 'Pâtes avec pesto maison rapide à base de roquette.', '00:20:00', 'facile', '2023-10-12', 1),
('Smoothie aux fruits', 'Rapide', 'Smoothie à base de fruits variés.', '00:10:00', 'facile', '2023-10-12', 1),
-- Dessert
('Tiramisu', 'Dessert', 'Dessert italien à base de mascarpone.', '00:30:00', 'facile', '2023-10-12', 1),
('Mousse au chocolat', 'Dessert', 'Mousse légère au chocolat.', '00:20:00', 'facile', '2023-10-12', 1),
('Cheesecake', 'Dessert', 'Gâteau au fromage crémeux sur une base de biscuit.', '02:00:00', 'intermédiaire', '2023-10-12', 1),
('Crème brûlée', 'Dessert', 'Crème douce sous une couche de sucre caramélisé.', '01:10:00', 'difficile', '2023-10-12', 1),
('Gâteau au fromage et fruits rouges', 'Dessert', 'Gâteau au fromage garni de fruits rouges frais.', '01:30:00', 'intermédiaire', '2023-10-12', 1),
('Fondant au chocolat', 'Dessert', 'Gâteau au cœur coulant de chocolat.', '00:25:00', 'intermédiaire', '2023-10-12', 1),
('Tarte aux pommes', 'Dessert', 'Tarte classique aux pommes et à la cannelle.', '01:20:00', 'intermédiaire', '2023-10-12', 1),
('Sorbet aux fruits', 'Dessert', 'Dessert glacé aux fruits frais et jus de citron.', '02:00:00', 'difficile', '2023-10-12', 1),
('Panna cotta', 'Dessert', 'Dessert italien à la crème, servi avec un coulis de fruits.', '03:00:00', 'difficile', '2023-10-12', 1),
('Eclairs au chocolat', 'Dessert', 'Pâtisserie française fourrée de crème au chocolat.', '01:40:00', 'difficile', '2023-10-12', 1),

-- Petit-déjeuner
('Pancakes', 'Petit-déjeuner', 'Crêpes épaisses servies au petit-déjeuner.', '00:20:00', 'facile', '2023-10-12', 1),
('Omelette aux champignons', 'Petit-déjeuner', 'Omelette légère aux champignons et fines herbes.', '00:15:00', 'facile', '2023-10-12', 1),
('Granola maison', 'Petit-déjeuner', 'Mélange croustillant de flocons d’avoine, noix et miel.', '00:30:00', 'facile', '2023-10-12', 1),
('Porridge aux fruits', 'Petit-déjeuner', 'Bouillie d’avoine chaude servie avec des fruits frais.', '00:15:00', 'facile', '2023-10-12', 1),
('Smoothie bowl', 'Petit-déjeuner', 'Bol de smoothie aux fruits, garni de granola et de fruits frais.', '00:10:00', 'facile', '2023-10-12', 1),
('Avocado toast', 'Petit-déjeuner', 'Tranches de pain grillé avec avocat écrasé et œuf poché.', '00:20:00', 'facile', '2023-10-12', 1),
('Bagels au saumon', 'Petit-déjeuner', 'Bagels grillés avec fromage à la crème et saumon fumé.', '00:15:00', 'facile', '2023-10-12', 1),
('Yogourt grec et miel', 'Petit-déjeuner', 'Yogourt grec crémeux servi avec du miel et des noix.', '00:05:00', 'facile', '2023-10-12', 1),
('Croissants', 'Petit-déjeuner', 'Croissants beurrés, parfaits pour un petit-déjeuner français.', '00:30:00', 'intermédiaire', '2023-10-12', 1),
('Chia pudding', 'Petit-déjeuner', 'Pudding de graines de chia avec lait d’amande et fruits.', '08:00:00', 'facile', '2023-10-12', 1),

-- Boisson
('Mojito', 'Boisson', 'Cocktail à base de rhum, menthe et citron vert.', '00:10:00', 'facile', '2023-10-12', 1),
('Smoothie à la banane', 'Boisson', 'Smoothie à base de banane et de lait.', '00:05:00', 'facile', '2023-10-12', 1),
('Limonade maison', 'Boisson', 'Limonade rafraîchissante faite avec des citrons frais.', '00:20:00', 'facile', '2023-10-12', 1),
('Thé glacé', 'Boisson', 'Thé noir rafraîchissant servi avec des glaçons et du citron.', '01:00:00', 'facile', '2023-10-12', 1),
('Café frappé', 'Boisson', 'Café glacé fouetté, parfait pour les chaudes journées d’été.', '00:10:00', 'facile', '2023-10-12', 1),
('Margarita', 'Boisson', 'Cocktail mexicain à base de tequila, citron vert et Cointreau.', '00:15:00', 'facile', '2023-10-12', 1),
('Chocolat chaud', 'Boisson', 'Boisson réconfortante à base de chocolat et de lait.', '00:15:00', 'facile', '2023-10-12', 1),
('Lassi à la mangue', 'Boisson', 'Boisson indienne à base de yaourt et de mangue.', '00:10:00', 'facile', '2023-10-12', 1),
('Jus de fruits frais', 'Boisson', 'Jus pressé de fruits de saison.', '00:10:00', 'facile', '2023-10-12', 1),
('Green smoothie', 'Boisson', 'Smoothie nutritif à base de légumes verts et fruits.', '00:10:00', 'facile', '2023-10-12', 1);









