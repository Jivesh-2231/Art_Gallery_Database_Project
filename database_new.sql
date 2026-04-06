-- ===============================================
-- ART GALLERY DATABASE - COMPLETE SETUP
-- Properly configured with CASCADE deletes & indexes
-- ===============================================

-- Drop existing database if it exists
DROP DATABASE IF EXISTS art_gallery;

-- Create database with UTF-8 support
CREATE DATABASE art_gallery 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE art_gallery;

-- ===============================================
-- ARTIST TABLE
-- ===============================================
CREATE TABLE artist (
    artist_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    birthplace VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    style VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_style (style)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- ARTWORK TABLE
-- ===============================================
CREATE TABLE artwork (
    artwork_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    year INT NOT NULL,
    type VARCHAR(100) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    artist_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_artwork_artist 
        FOREIGN KEY (artist_id) REFERENCES artist(artist_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    INDEX idx_title (title),
    INDEX idx_year (year),
    INDEX idx_artist_id (artist_id),
    INDEX idx_price (price)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- CATEGORY TABLE
-- ===============================================
CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category_name (category_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- CUSTOMER TABLE
-- ===============================================
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    total_spent DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    liking VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_liking (liking),
    INDEX idx_total_spent (total_spent)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- PURCHASE TABLE
-- ===============================================
CREATE TABLE purchase (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    artwork_id INT NOT NULL,
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_purchase_customer 
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_purchase_artwork 
        FOREIGN KEY (artwork_id) REFERENCES artwork(artwork_id) 
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    INDEX idx_customer_id (customer_id),
    INDEX idx_artwork_id (artwork_id),
    INDEX idx_purchase_date (purchase_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ===============================================
-- SAMPLE DATA
-- ===============================================

-- ARTISTS (15 entries)
INSERT INTO artist (artist_id, name, birthplace, age, style) VALUES
(1, 'Leonardo da Vinci', 'Italy', 67, 'Renaissance'),
(2, 'Vincent van Gogh', 'Netherlands', 37, 'Post-Impressionism'),
(3, 'Pablo Picasso', 'Spain', 91, 'Cubism'),
(4, 'Claude Monet', 'France', 86, 'Impressionism'),
(5, 'Rembrandt', 'Netherlands', 63, 'Baroque'),
(6, 'Salvador Dali', 'Spain', 84, 'Surrealism'),
(7, 'Frida Kahlo', 'Mexico', 47, 'Modern Art'),
(8, 'Michelangelo', 'Italy', 88, 'Renaissance'),
(9, 'Andy Warhol', 'USA', 58, 'Pop Art'),
(10, 'Edvard Munch', 'Norway', 80, 'Expressionism'),
(11, 'Georgia O''Keeffe', 'USA', 98, 'Modernism'),
(12, 'Henri Matisse', 'France', 84, 'Fauvism'),
(13, 'Jackson Pollock', 'USA', 44, 'Abstract'),
(14, 'Paul Cezanne', 'France', 67, 'Post-Impressionism'),
(15, 'Gustav Klimt', 'Austria', 55, 'Symbolism');

-- ARTWORKS (20 entries)
INSERT INTO artwork (artwork_id, title, year, type, price, artist_id) VALUES
(1, 'Mona Lisa', 1503, 'Portrait', 1000000.00, 1),
(2, 'The Starry Night', 1889, 'Painting', 2000000.00, 2),
(3, 'Guernica', 1937, 'Painting', 1500000.00, 3),
(4, 'Water Lilies', 1906, 'Painting', 1200000.00, 4),
(5, 'The Night Watch', 1642, 'Painting', 1100000.00, 5),
(6, 'The Persistence of Memory', 1931, 'Painting', 1300000.00, 6),
(7, 'Self Portrait', 1940, 'Portrait', 900000.00, 7),
(8, 'David', 1504, 'Sculpture', 3000000.00, 8),
(9, 'Campbell Soup Cans', 1962, 'Modern Art', 800000.00, 9),
(10, 'The Scream', 1893, 'Painting', 1400000.00, 10),
(11, 'Red Canna', 1924, 'Painting', 700000.00, 11),
(12, 'The Dance', 1910, 'Painting', 950000.00, 12),
(13, 'No. 5', 1948, 'Abstract', 1600000.00, 13),
(14, 'Mont Sainte-Victoire', 1904, 'Landscape', 850000.00, 14),
(15, 'The Kiss', 1908, 'Symbolism', 1250000.00, 15),
(16, 'Vitruvian Man', 1490, 'Sketch', 600000.00, 1),
(17, 'Sunflowers', 1888, 'Still Life', 1000000.00, 2),
(18, 'Les Demoiselles', 1907, 'Painting', 1400000.00, 3),
(19, 'Impression Sunrise', 1872, 'Painting', 1200000.00, 4),
(20, 'Girl with a Pearl Earring', 1665, 'Portrait', 1100000.00, 5);

-- CATEGORIES (8 entries)
INSERT INTO category (category_id, category_name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Portrait'),
(4, 'Abstract'),
(5, 'Modern Art'),
(6, 'Landscape'),
(7, 'Still Life'),
(8, 'Symbolism');

-- CUSTOMERS (10 entries)
INSERT INTO customer (customer_id, name, address, total_spent, liking) VALUES
(1, 'John Doe', 'New York, USA', 5000000.00, 'Painting'),
(2, 'Alice Smith', 'London, UK', 3000000.00, 'Sculpture'),
(3, 'Rahul Sharma', 'Mumbai, India', 2000000.00, 'Modern Art'),
(4, 'Emma Brown', 'Toronto, Canada', 1500000.00, 'Portrait'),
(5, 'Liam Wilson', 'Sydney, Australia', 1200000.00, 'Abstract'),
(6, 'Olivia Taylor', 'Los Angeles, USA', 1800000.00, 'Landscape'),
(7, 'Noah Davis', 'Chicago, USA', 2200000.00, 'Still Life'),
(8, 'Ava Martinez', 'Barcelona, Spain', 2500000.00, 'Symbolism'),
(9, 'Ethan Clark', 'Paris, France', 1300000.00, 'Painting'),
(10, 'Sophia Lewis', 'Berlin, Germany', 1700000.00, 'Modern Art');

-- PURCHASES (10 entries)
INSERT INTO purchase (purchase_id, customer_id, artwork_id) VALUES
(1, 1, 1),
(2, 2, 8),
(3, 3, 9),
(4, 4, 7),
(5, 5, 13),
(6, 6, 14),
(7, 7, 17),
(8, 8, 15),
(9, 9, 3),
(10, 10, 6);

-- ===============================================
-- VERIFY SETUP
-- ===============================================
SHOW TABLES;
SELECT 'Setup Complete - Tables Created';
