-- Script de migration 

-- Désactiver les contraintes de clés étrangères temporairement
SET FOREIGN_KEY_CHECKS=0;

-- Supprimer la colonne author de la table book car elle est gérée par la table book_author
ALTER TABLE `biblio_db`.`book` 
DROP COLUMN `author`;

-- Nettoyage des tables temporaires existantes
DROP TEMPORARY TABLE IF EXISTS temp_categories;
DROP TEMPORARY TABLE IF EXISTS temp_notices;
DROP TEMPORARY TABLE IF EXISTS temp_authors;
DROP TEMPORARY TABLE IF EXISTS temp_authorities;
DROP TEMPORARY TABLE IF EXISTS temp_authority_sources;
DROP TEMPORARY TABLE IF EXISTS temp_notice_authors;
DROP TEMPORARY TABLE IF EXISTS temp_unique_authors;

-- Créer une table temporaire pour stocker les catégories
CREATE TEMPORARY TABLE temp_categories AS
SELECT * FROM biblio_uiass.categories;

-- Créer une table temporaire pour stocker les notices (livres)
CREATE TEMPORARY TABLE temp_notices AS
SELECT * FROM biblio_uiass.notices;

-- Créer une table temporaire pour stocker les auteurs
CREATE TEMPORARY TABLE temp_authors AS
SELECT * FROM biblio_uiass.authors;

-- Créer une table temporaire pour stocker les autorités
CREATE TEMPORARY TABLE temp_authorities AS
SELECT * FROM biblio_uiass.authorities;

-- Créer une table temporaire pour stocker les sources d'autorités
CREATE TEMPORARY TABLE temp_authority_sources AS
SELECT * FROM biblio_uiass.authorities_sources;

-- 1. Migration des domaines
INSERT INTO biblio_db.domain (name)
SELECT DISTINCT libelle_categorie
FROM temp_categories
WHERE libelle_categorie IS NOT NULL AND libelle_categorie != '';

-- Log du nombre de domaines créés
SELECT CONCAT('Nombre de domaines créés : ', COUNT(*)) as info
FROM biblio_db.domain;

-- 2. Migration des sections
INSERT INTO biblio_db.section (domain_id, name)
SELECT d.id, c.libelle_categorie
FROM temp_categories c
JOIN biblio_db.domain d ON d.name = c.libelle_categorie
WHERE c.libelle_categorie IS NOT NULL AND c.libelle_categorie != '';

-- Log du nombre de sections créées
SELECT CONCAT('Nombre de sections créées : ', COUNT(*)) as info
FROM biblio_db.section;

-- 3. Migration des auteurs
-- D'abord, créons la table author si elle n'existe pas
CREATE TABLE IF NOT EXISTS `biblio_db`.`author` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Ensuite, créons une table temporaire pour stocker les auteurs uniques
CREATE TEMPORARY TABLE temp_unique_authors AS
SELECT DISTINCT author_id, author_name
FROM temp_authors
WHERE author_name IS NOT NULL AND author_name != '';

-- Maintenant, insérons les auteurs dans la nouvelle table
INSERT INTO biblio_db.author (name)
SELECT author_name
FROM temp_unique_authors;

-- Log du nombre d'auteurs créés
SELECT CONCAT('Nombre d\'auteurs créés : ', COUNT(*)) as info
FROM biblio_db.author;

-- 4. Migration des livres
-- D'abord, créons une table temporaire pour stocker les relations notices-auteurs
CREATE TEMPORARY TABLE temp_notice_authors AS
SELECT DISTINCT 
    n.notice_id,
    n.tit1,
    n.tit2,
    n.tit3,
    n.tit4,
    c.libelle_categorie,
    a.author_id,
    a.author_name
FROM temp_notices n
LEFT JOIN biblio_uiass.notices_categories nc ON n.notice_id = nc.notcateg_notice
LEFT JOIN temp_categories c ON nc.num_noeud = c.num_noeud
LEFT JOIN biblio_uiass.notices_authorities_sources nas ON n.notice_id = nas.num_notice
LEFT JOIN temp_authority_sources aus ON nas.num_authority_source = aus.id_authority_source
LEFT JOIN temp_authorities auth ON aus.num_authority = auth.id_authority
LEFT JOIN temp_authors a ON auth.num_object = a.author_id
WHERE (n.tit1 IS NOT NULL OR n.tit2 IS NOT NULL OR n.tit3 IS NOT NULL OR n.tit4 IS NOT NULL);

-- Log du nombre de relations notices-auteurs trouvées
SELECT CONCAT('Nombre de relations notices-auteurs trouvées : ', COUNT(*)) as info
FROM temp_notice_authors;

-- Maintenant, insérons les livres avec leurs sections
INSERT INTO biblio_db.book (section_id, title)
SELECT 
    s.id,
    COALESCE(na.tit1, na.tit2, na.tit3, na.tit4, 'Sans titre')
FROM temp_notice_authors na
JOIN biblio_db.section s ON s.name = na.libelle_categorie
WHERE na.libelle_categorie IS NOT NULL;

-- Log du nombre de livres créés
SELECT CONCAT('Nombre de livres créés : ', COUNT(*)) as info
FROM biblio_db.book;

-- Insérer les relations livres-auteurs
INSERT INTO biblio_db.book_author (book_id, author_id)
SELECT 
    b.id,
    a.id
FROM biblio_db.book b
JOIN temp_notice_authors na ON b.title = COALESCE(na.tit1, na.tit2, na.tit3, na.tit4, 'Sans titre')
JOIN biblio_db.author a ON a.name = na.author_name
WHERE na.author_name IS NOT NULL AND na.author_name != '';

-- Log du nombre de relations livres-auteurs créées
SELECT CONCAT('Nombre de relations livres-auteurs créées : ', COUNT(*)) as info
FROM biblio_db.book_author;

-- Nettoyage
DROP TEMPORARY TABLE IF EXISTS temp_categories;
DROP TEMPORARY TABLE IF EXISTS temp_notices;
DROP TEMPORARY TABLE IF EXISTS temp_authors;
DROP TEMPORARY TABLE IF EXISTS temp_authorities;
DROP TEMPORARY TABLE IF EXISTS temp_authority_sources;
DROP TEMPORARY TABLE IF EXISTS temp_notice_authors;
DROP TEMPORARY TABLE IF EXISTS temp_unique_authors;

-- 5. Migration des utilisateurs (si nécessaire)
-- Note: Cette partie dépend de la structure exacte de la table users dans l'ancienne base
-- INSERT INTO biblio_db.user (email, roles, password, firstname, lastname)
-- SELECT ...

-- 6. Ajout de nouvelles fonctionnalités

-- Ajout d'une table pour les réservations
CREATE TABLE IF NOT EXISTS `biblio_db`.`reservation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `user_id` int NOT NULL,
  `reservation_date` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_RESERVATION_BOOK` (`book_id`),
  KEY `IDX_RESERVATION_USER` (`user_id`),
  CONSTRAINT `FK_RESERVATION_BOOK` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  CONSTRAINT `FK_RESERVATION_USER` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Ajout d'une table pour les avis sur les livres
CREATE TABLE IF NOT EXISTS `biblio_db`.`book_review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` int NOT NULL,
  `user_id` int NOT NULL,
  `rating` int NOT NULL,
  `comment` text,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_REVIEW_BOOK` (`book_id`),
  KEY `IDX_REVIEW_USER` (`user_id`),
  CONSTRAINT `FK_REVIEW_BOOK` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  CONSTRAINT `FK_REVIEW_USER` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Réactiver les contraintes de clés étrangères
SET FOREIGN_KEY_CHECKS=1; 