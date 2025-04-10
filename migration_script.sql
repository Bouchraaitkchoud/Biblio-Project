-- Migration script for books and authors from biblio_uiass to biblio_db (SIMPLIFIED VERSION)

-- Disable foreign key checks temporarily
SET FOREIGN_KEY_CHECKS = 0;

-- First clear existing data
TRUNCATE TABLE `biblio_db`.`book_author`;
TRUNCATE TABLE `biblio_db`.`book`;
TRUNCATE TABLE `biblio_db`.`section`;
TRUNCATE TABLE `biblio_db`.`domain`;
TRUNCATE TABLE `biblio_db`.`author`;

-- Set BLOB type for cover image
ALTER TABLE `biblio_db`.`book` MODIFY COLUMN `cover_image` MEDIUMBLOB;

-- Create a temporary table to store the default black image BLOB
-- This is a 1x1 pixel black GIF encoded as a BLOB
DROP TEMPORARY TABLE IF EXISTS temp_default_cover;
CREATE TEMPORARY TABLE temp_default_cover (cover_blob MEDIUMBLOB);
INSERT INTO temp_default_cover (cover_blob) 
VALUES (UNHEX('47494638396101000100800000000000FFFFFF21F90401000000002C00000000010001000002024401003B'));

-- Clean up any existing temporary tables
DROP TEMPORARY TABLE IF EXISTS temp_books;
DROP TEMPORARY TABLE IF EXISTS temp_categories;
DROP TEMPORARY TABLE IF EXISTS temp_authors;
DROP TEMPORARY TABLE IF EXISTS temp_book_authors;

-- 1. Extract domain names
CREATE TEMPORARY TABLE temp_categories (
    num_noeud INT,
    name VARCHAR(255) 
);

INSERT INTO temp_categories
SELECT 
    num_noeud,
    libelle_categorie 
FROM biblio_uiass.categories
WHERE libelle_categorie IS NOT NULL AND libelle_categorie != '';

-- 2. Migrate domains
INSERT INTO biblio_db.domain (name)
SELECT DISTINCT name
FROM temp_categories;

-- 3. Migrate sections (reusing domains as sections for simplicity)
INSERT INTO biblio_db.section (domain_id, name)
SELECT 
    d.id, 
    c.name
FROM temp_categories c
JOIN biblio_db.domain d ON BINARY d.name = BINARY c.name
WHERE c.name IS NOT NULL AND c.name != '';

-- 4. Extract authors
CREATE TEMPORARY TABLE temp_authors (
    author_id INT,
    full_name VARCHAR(255)
);

INSERT INTO temp_authors
SELECT DISTINCT 
    author_id,
    TRIM(CONCAT(COALESCE(author_name, ''), ' ', COALESCE(author_rejete, '')))
FROM biblio_uiass.authors
WHERE author_name IS NOT NULL AND author_name != '';

-- 5. Migrate authors
INSERT INTO biblio_db.author (author_name)
SELECT DISTINCT full_name
FROM temp_authors
WHERE full_name != '';

-- 6. Extract books
CREATE TEMPORARY TABLE temp_books (
    notice_id INT,
    title VARCHAR(255),
    section_id INT,
    isbn VARCHAR(50),
    publication_year INT
);

INSERT INTO temp_books
SELECT 
    n.notice_id,
    COALESCE(n.tit1, n.tit2, n.tit3, n.tit4) as title,
    COALESCE(s.id, 1) as section_id,
    n.code as isbn,
    CASE 
        WHEN n.year REGEXP '^[0-9]+$' THEN CAST(n.year AS UNSIGNED)
        WHEN n.year REGEXP '[0-9]{4}' THEN CAST(REGEXP_SUBSTR(n.year, '[0-9]{4}') AS UNSIGNED)
        ELSE NULL
    END as publication_year
FROM biblio_uiass.notices n
LEFT JOIN biblio_uiass.notices_categories nc ON n.notice_id = nc.notcateg_notice
LEFT JOIN temp_categories cat ON nc.num_noeud = cat.num_noeud
LEFT JOIN biblio_db.section s ON BINARY s.name = BINARY cat.name
WHERE COALESCE(n.tit1, n.tit2, n.tit3, n.tit4) IS NOT NULL;

-- 7. Migrate books
INSERT INTO biblio_db.book (section_id, title, cover_image, isbn, publication_year)
SELECT 
    b.section_id,
    b.title,
    dc.cover_blob,
    b.isbn,
    b.publication_year
FROM temp_books b
CROSS JOIN temp_default_cover dc
WHERE b.title IS NOT NULL;

-- 8. Find book-author relationships (direct method)
CREATE TEMPORARY TABLE temp_book_authors (
    notice_id INT,
    book_title VARCHAR(255),
    author_name VARCHAR(255)
);

-- Insert author relationships from responsability table
INSERT INTO temp_book_authors
SELECT DISTINCT
    n.notice_id,
    b.title,
    a.full_name
FROM biblio_uiass.responsability r
JOIN temp_books b ON r.responsability_notice = b.notice_id
JOIN temp_authors a ON r.responsability_author = a.author_id
JOIN biblio_uiass.notices n ON b.notice_id = n.notice_id
WHERE b.title IS NOT NULL AND a.full_name IS NOT NULL AND a.full_name != '';

-- 9. Create book-author relationships
INSERT INTO biblio_db.book_author (book_id, author_id)
SELECT DISTINCT 
    b.id as book_id,
    a.id as author_id
FROM biblio_db.book b
JOIN temp_book_authors ba ON BINARY b.title = BINARY ba.book_title
JOIN biblio_db.author a ON BINARY a.author_name = BINARY ba.author_name;

-- Display summary of migration
SELECT 'Migration Summary:' as info;
SELECT CONCAT('Domains: ', COUNT(*)) as info FROM biblio_db.domain;
SELECT CONCAT('Sections: ', COUNT(*)) as info FROM biblio_db.section;
SELECT CONCAT('Authors: ', COUNT(*)) as info FROM biblio_db.author;
SELECT CONCAT('Books: ', COUNT(*)) as info FROM biblio_db.book;
SELECT CONCAT('Book-author relationships: ', COUNT(*)) as info FROM biblio_db.book_author;

-- Clean up temporary tables
DROP TEMPORARY TABLE IF EXISTS temp_books;
DROP TEMPORARY TABLE IF EXISTS temp_categories;
DROP TEMPORARY TABLE IF EXISTS temp_authors;
DROP TEMPORARY TABLE IF EXISTS temp_book_authors;
DROP TEMPORARY TABLE IF EXISTS temp_default_cover;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1; 