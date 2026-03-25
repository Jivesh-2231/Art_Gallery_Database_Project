CREATE DATABASE art_gallery;
USE art_gallery;

-- ARTIST TABLE
CREATE TABLE artist (
    artist_id INT PRIMARY KEY,
    name VARCHAR(100),
    birthplace VARCHAR(100),
    age INT,
    style VARCHAR(100)
);

-- ARTWORK TABLE
CREATE TABLE artwork (
    artwork_id INT PRIMARY KEY,
    title VARCHAR(100),
    year INT,
    type VARCHAR(100),
    price FLOAT,    mysql -u root -p < "c:\Users\Alenj\OneDrive\Desktop\Art-Gallery Project\database.sql"    mysql -u root -p < "c:\Users\Alenj\OneDrive\Desktop\Art-Gallery Project\database.sql"
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES artist(artist_id)
);

-- CATEGORY TABLE
CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- CUSTOMER TABLE
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(100),
    total_spent FLOAT,
    liking VARCHAR(100)
);

-- PURCHASE TABLE
CREATE TABLE purchase (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    artwork_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (artwork_id) REFERENCES artwork(artwork_id)
);

-- =========================
-- INSERT DATA
-- =========================

-- ARTISTS (15 entries)
INSERT INTO artist VALUES
(1,'Leonardo da Vinci','Italy',67,'Renaissance'),
(2,'Vincent van Gogh','Netherlands',37,'Post-Impressionism'),
(3,'Pablo Picasso','Spain',91,'Cubism'),
(4,'Claude Monet','France',86,'Impressionism'),
(5,'Rembrandt','Netherlands',63,'Baroque'),
(6,'Salvador Dali','Spain',84,'Surrealism'),
(7,'Frida Kahlo','Mexico',47,'Modern Art'),
(8,'Michelangelo','Italy',88,'Renaissance'),
(9,'Andy Warhol','USA',58,'Pop Art'),
(10,'Edvard Munch','Norway',80,'Expressionism'),
(11,'Georgia O’Keeffe','USA',98,'Modernism'),
(12,'Henri Matisse','France',84,'Fauvism'),
(13,'Jackson Pollock','USA',44,'Abstract'),
(14,'Paul Cezanne','France',67,'Post-Impressionism'),
(15,'Gustav Klimt','Austria',55,'Symbolism');

-- ARTWORKS (20 entries)
INSERT INTO artwork VALUES
(1,'Mona Lisa',1503,'Portrait',1000000,1),
(2,'The Starry Night',1889,'Painting',2000000,2),
(3,'Guernica',1937,'Painting',1500000,3),
(4,'Water Lilies',1906,'Painting',1200000,4),
(5,'The Night Watch',1642,'Painting',1100000,5),
(6,'The Persistence of Memory',1931,'Painting',1300000,6),
(7,'Self Portrait',1940,'Portrait',900000,7),
(8,'David',1504,'Sculpture',3000000,8),
(9,'Campbell Soup Cans',1962,'Modern Art',800000,9),
(10,'The Scream',1893,'Painting',1400000,10),
(11,'Red Canna',1924,'Painting',700000,11),
(12,'The Dance',1910,'Painting',950000,12),
(13,'No. 5',1948,'Abstract',1600000,13),
(14,'Mont Sainte-Victoire',1904,'Landscape',850000,14),
(15,'The Kiss',1908,'Symbolism',1250000,15),
(16,'Vitruvian Man',1490,'Sketch',600000,1),
(17,'Sunflowers',1888,'Still Life',1000000,2),
(18,'Les Demoiselles',1907,'Painting',1400000,3),
(19,'Impression Sunrise',1872,'Painting',1200000,4),
(20,'Girl with a Pearl Earring',1665,'Portrait',1100000,5);

-- CATEGORIES
INSERT INTO category VALUES
(1,'Painting'),
(2,'Sculpture'),
(3,'Portrait'),
(4,'Abstract'),
(5,'Modern Art'),
(6,'Landscape'),
(7,'Still Life'),
(8,'Symbolism');

-- CUSTOMERS (10 entries)
INSERT INTO customer VALUES
(1,'John Doe','USA',5000000,'Painting'),
(2,'Alice Smith','UK',3000000,'Sculpture'),
(3,'Rahul Sharma','India',2000000,'Modern Art'),
(4,'Emma Brown','Canada',1500000,'Portrait'),
(5,'Liam Wilson','Australia',1200000,'Abstract'),
(6,'Olivia Taylor','USA',1800000,'Landscape'),
(7,'Noah Davis','USA',2200000,'Still Life'),
(8,'Ava Martinez','Spain',2500000,'Symbolism'),
(9,'Ethan Clark','France',1300000,'Painting'),
(10,'Sophia Lewis','Germany',1700000,'Modern Art');

-- PURCHASES
INSERT INTO purchase VALUES
(1,1,1),
(2,2,8),
(3,3,9),
(4,4,7),
(5,5,13),
(6,6,14),
(7,7,17),
(8,8,15),
(9,9,3),
(10,10,6);