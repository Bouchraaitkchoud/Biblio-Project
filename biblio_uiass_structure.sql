-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: biblio_uiass
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abo_liste_lecture`
--

DROP TABLE IF EXISTS `abo_liste_lecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abo_liste_lecture` (
  `num_empr` int unsigned NOT NULL DEFAULT '0',
  `num_liste` int unsigned NOT NULL DEFAULT '0',
  `etat` int unsigned NOT NULL DEFAULT '0',
  `commentaire` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`num_empr`,`num_liste`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abts_abts`
--

DROP TABLE IF EXISTS `abts_abts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abts_abts` (
  `abt_id` int unsigned NOT NULL AUTO_INCREMENT,
  `abt_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `abt_name_opac` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `base_modele_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `base_modele_id` int NOT NULL DEFAULT '0',
  `num_notice` int NOT NULL DEFAULT '0',
  `date_debut` date NOT NULL DEFAULT '1970-01-01',
  `date_fin` date NOT NULL DEFAULT '1970-01-01',
  `fournisseur` int NOT NULL DEFAULT '0',
  `destinataire` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `typdoc_id` int NOT NULL DEFAULT '0',
  `exemp_auto` int NOT NULL DEFAULT '0',
  `location_id` int NOT NULL DEFAULT '0',
  `section_id` int NOT NULL DEFAULT '0',
  `lender_id` int NOT NULL DEFAULT '0',
  `statut_id` int NOT NULL DEFAULT '0',
  `codestat_id` int NOT NULL DEFAULT '0',
  `type_antivol` int NOT NULL DEFAULT '0',
  `duree_abonnement` int NOT NULL DEFAULT '0',
  `abt_numeric` int NOT NULL DEFAULT '0',
  `prix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `abt_status` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`abt_id`) USING BTREE,
  KEY `index_num_notice` (`num_notice`) USING BTREE,
  KEY `i_date_fin` (`date_fin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abts_abts_modeles`
--

DROP TABLE IF EXISTS `abts_abts_modeles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abts_abts_modeles` (
  `modele_id` int NOT NULL DEFAULT '0',
  `abt_id` int NOT NULL DEFAULT '0',
  `num` int NOT NULL DEFAULT '0',
  `vol` int NOT NULL DEFAULT '0',
  `tome` int NOT NULL DEFAULT '0',
  `delais` int NOT NULL DEFAULT '0',
  `critique` int NOT NULL DEFAULT '0',
  `num_statut_general` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`modele_id`,`abt_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abts_grille_abt`
--

DROP TABLE IF EXISTS `abts_grille_abt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abts_grille_abt` (
  `id_bull` int NOT NULL AUTO_INCREMENT,
  `num_abt` int unsigned NOT NULL DEFAULT '0',
  `date_parution` date NOT NULL DEFAULT '1970-01-01',
  `modele_id` int NOT NULL DEFAULT '0',
  `type` int NOT NULL DEFAULT '0',
  `nombre` int NOT NULL DEFAULT '0',
  `numero` int NOT NULL DEFAULT '0',
  `ordre` int NOT NULL DEFAULT '0',
  `state` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_bull`) USING BTREE,
  KEY `num_abt` (`num_abt`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abts_grille_modele`
--

DROP TABLE IF EXISTS `abts_grille_modele`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abts_grille_modele` (
  `num_modele` int unsigned NOT NULL DEFAULT '0',
  `date_parution` date NOT NULL DEFAULT '1970-01-01',
  `type_serie` int NOT NULL DEFAULT '0',
  `numero` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `nombre_recu` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`num_modele`,`date_parution`,`type_serie`) USING BTREE,
  KEY `num_modele` (`num_modele`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abts_modeles`
--

DROP TABLE IF EXISTS `abts_modeles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abts_modeles` (
  `modele_id` int unsigned NOT NULL AUTO_INCREMENT,
  `modele_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_notice` int unsigned NOT NULL DEFAULT '0',
  `num_periodicite` int unsigned NOT NULL DEFAULT '0',
  `duree_abonnement` int NOT NULL DEFAULT '0',
  `date_debut` date NOT NULL DEFAULT '1970-01-01',
  `date_fin` date DEFAULT NULL,
  `days` varchar(7) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1111111',
  `day_month` varchar(31) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1111111111111111111111111111111',
  `week_month` varchar(6) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '111111',
  `week_year` varchar(54) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '111111111111111111111111111111111111111111111111111111',
  `month_year` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '111111111111',
  `num_cycle` int NOT NULL DEFAULT '0',
  `num_combien` int NOT NULL DEFAULT '0',
  `num_increment` int NOT NULL DEFAULT '0',
  `num_date_unite` int NOT NULL DEFAULT '0',
  `num_increment_date` int NOT NULL DEFAULT '0',
  `num_depart` int NOT NULL DEFAULT '0',
  `vol_actif` int NOT NULL DEFAULT '0',
  `vol_increment` int NOT NULL DEFAULT '0',
  `vol_date_unite` int NOT NULL DEFAULT '0',
  `vol_increment_numero` int NOT NULL DEFAULT '0',
  `vol_increment_date` int NOT NULL DEFAULT '0',
  `vol_cycle` int NOT NULL DEFAULT '0',
  `vol_combien` int NOT NULL DEFAULT '0',
  `vol_depart` int NOT NULL DEFAULT '0',
  `tom_actif` int NOT NULL DEFAULT '0',
  `tom_increment` int NOT NULL DEFAULT '0',
  `tom_date_unite` int NOT NULL DEFAULT '0',
  `tom_increment_numero` int NOT NULL DEFAULT '0',
  `tom_increment_date` int NOT NULL DEFAULT '0',
  `tom_cycle` int NOT NULL DEFAULT '0',
  `tom_combien` int NOT NULL DEFAULT '0',
  `tom_depart` int NOT NULL DEFAULT '0',
  `format_aff` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `format_periode` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`modele_id`) USING BTREE,
  KEY `num_notice` (`num_notice`) USING BTREE,
  KEY `num_periodicite` (`num_periodicite`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abts_periodicites`
--

DROP TABLE IF EXISTS `abts_periodicites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abts_periodicites` (
  `periodicite_id` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `duree` int NOT NULL DEFAULT '0',
  `unite` int NOT NULL DEFAULT '0',
  `retard_periodicite` int DEFAULT '0',
  `seuil_periodicite` int DEFAULT '0',
  `consultation_duration` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`periodicite_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `abts_status`
--

DROP TABLE IF EXISTS `abts_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abts_status` (
  `abts_status_id` int unsigned NOT NULL AUTO_INCREMENT,
  `abts_status_gestion_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `abts_status_opac_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `abts_status_class_html` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `abts_status_bulletinage_active` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`abts_status_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acces_profiles`
--

DROP TABLE IF EXISTS `acces_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acces_profiles` (
  `prf_id` int unsigned NOT NULL AUTO_INCREMENT,
  `prf_type` int unsigned NOT NULL DEFAULT '1',
  `prf_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `prf_rule` blob NOT NULL,
  `prf_hrule` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `prf_used` int unsigned NOT NULL DEFAULT '0',
  `dom_num` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`prf_id`) USING BTREE,
  KEY `prf_type` (`prf_type`) USING BTREE,
  KEY `prf_name` (`prf_name`) USING BTREE,
  KEY `dom_num` (`dom_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `acces_rights`
--

DROP TABLE IF EXISTS `acces_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acces_rights` (
  `dom_num` int unsigned NOT NULL DEFAULT '0',
  `usr_prf_num` int unsigned NOT NULL DEFAULT '0',
  `res_prf_num` int unsigned NOT NULL DEFAULT '0',
  `dom_rights` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`dom_num`,`usr_prf_num`,`res_prf_num`) USING BTREE,
  KEY `dom_num` (`dom_num`) USING BTREE,
  KEY `usr_prf_num` (`usr_prf_num`) USING BTREE,
  KEY `res_prf_num` (`res_prf_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `actes`
--

DROP TABLE IF EXISTS `actes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actes` (
  `id_acte` int unsigned NOT NULL AUTO_INCREMENT,
  `date_acte` date NOT NULL DEFAULT '1970-01-01',
  `numero` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `type_acte` int unsigned NOT NULL DEFAULT '0',
  `statut` int unsigned NOT NULL DEFAULT '0',
  `date_paiement` date NOT NULL DEFAULT '1970-01-01',
  `num_paiement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_entite` int unsigned NOT NULL DEFAULT '0',
  `num_fournisseur` int unsigned NOT NULL DEFAULT '0',
  `num_contact_livr` int unsigned NOT NULL DEFAULT '0',
  `num_contact_fact` int unsigned NOT NULL DEFAULT '0',
  `num_exercice` int unsigned NOT NULL DEFAULT '0',
  `commentaires` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `reference` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `index_acte` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `devise` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `commentaires_i` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `date_valid` date NOT NULL DEFAULT '1970-01-01',
  `date_ech` date NOT NULL DEFAULT '1970-01-01',
  `nom_acte` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_acte`) USING BTREE,
  KEY `num_fournisseur` (`num_fournisseur`) USING BTREE,
  KEY `date` (`date_acte`) USING BTREE,
  KEY `num_entite` (`num_entite`) USING BTREE,
  KEY `numero` (`numero`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_session`
--

DROP TABLE IF EXISTS `admin_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_session` (
  `userid` int unsigned NOT NULL DEFAULT '0',
  `session` mediumblob,
  PRIMARY KEY (`userid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `analysis`
--

DROP TABLE IF EXISTS `analysis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analysis` (
  `analysis_bulletin` int unsigned NOT NULL DEFAULT '0',
  `analysis_notice` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`analysis_bulletin`,`analysis_notice`) USING BTREE,
  KEY `analysis_notice` (`analysis_notice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `analytics_services`
--

DROP TABLE IF EXISTS `analytics_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics_services` (
  `id_analytics_service` int unsigned NOT NULL AUTO_INCREMENT,
  `analytics_service_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `analytics_service_active` int NOT NULL DEFAULT '0',
  `analytics_service_parameters` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `analytics_service_template` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `analytics_service_consent_template` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id_analytics_service`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_animation_categories`
--

DROP TABLE IF EXISTS `anim_animation_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_animation_categories` (
  `num_animation` int NOT NULL,
  `num_noeud` int NOT NULL,
  `ordre_categorie` int DEFAULT NULL,
  PRIMARY KEY (`num_animation`,`num_noeud`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_animation_custom`
--

DROP TABLE IF EXISTS `anim_animation_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_animation_custom` (
  `idchamp` int NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `filters` int NOT NULL DEFAULT '0',
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_animation_custom_dates`
--

DROP TABLE IF EXISTS `anim_animation_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_animation_custom_dates` (
  `anim_animation_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `anim_animation_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `anim_animation_custom_date_type` int DEFAULT NULL,
  `anim_animation_custom_date_start` int NOT NULL DEFAULT '0',
  `anim_animation_custom_date_end` int NOT NULL DEFAULT '0',
  `anim_animation_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`anim_animation_custom_champ`,`anim_animation_custom_origine`,`anim_animation_custom_order`) USING BTREE,
  KEY `anim_animation_custom_champ` (`anim_animation_custom_champ`) USING BTREE,
  KEY `anim_animation_custom_origine` (`anim_animation_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_animation_custom_lists`
--

DROP TABLE IF EXISTS `anim_animation_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_animation_custom_lists` (
  `anim_animation_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `anim_animation_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `anim_animation_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`anim_animation_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`anim_animation_custom_champ`,`anim_animation_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_animation_custom_values`
--

DROP TABLE IF EXISTS `anim_animation_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_animation_custom_values` (
  `anim_animation_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `anim_animation_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `anim_animation_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `anim_animation_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `anim_animation_custom_integer` int DEFAULT NULL,
  `anim_animation_custom_date` date DEFAULT NULL,
  `anim_animation_custom_float` float DEFAULT NULL,
  `anim_animation_custom_order` int NOT NULL DEFAULT '0',
  KEY `anim_animation_custom_champ` (`anim_animation_custom_champ`) USING BTREE,
  KEY `anim_animation_custom_origine` (`anim_animation_custom_origine`) USING BTREE,
  KEY `i_encv_st` (`anim_animation_custom_small_text`) USING BTREE,
  KEY `i_encv_t` (`anim_animation_custom_text`(255)) USING BTREE,
  KEY `i_encv_i` (`anim_animation_custom_integer`) USING BTREE,
  KEY `i_encv_d` (`anim_animation_custom_date`) USING BTREE,
  KEY `i_encv_f` (`anim_animation_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_animation_locations`
--

DROP TABLE IF EXISTS `anim_animation_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_animation_locations` (
  `num_animation` int NOT NULL,
  `num_location` int NOT NULL,
  PRIMARY KEY (`num_animation`,`num_location`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_animations`
--

DROP TABLE IF EXISTS `anim_animations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_animations` (
  `id_animation` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `global_quota` int DEFAULT NULL,
  `internet_quota` int DEFAULT NULL,
  `num_status` int DEFAULT NULL,
  `num_event` int DEFAULT NULL,
  `num_parent` int DEFAULT NULL,
  `expiration_delay` int DEFAULT NULL,
  `registration_required` tinyint(1) DEFAULT NULL,
  `auto_registration` tinyint(1) DEFAULT NULL,
  `allow_waiting_list` tinyint(1) DEFAULT NULL,
  `num_cart` int NOT NULL DEFAULT '0',
  `num_type` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_animation`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_events`
--

DROP TABLE IF EXISTS `anim_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_events` (
  `id_event` int NOT NULL AUTO_INCREMENT,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `num_config` int DEFAULT NULL,
  PRIMARY KEY (`id_event`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_mailing_list`
--

DROP TABLE IF EXISTS `anim_mailing_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_mailing_list` (
  `id_mailing_list` int NOT NULL AUTO_INCREMENT,
  `send_at` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `num_animation` int NOT NULL DEFAULT '0',
  `auto_send` int NOT NULL DEFAULT '0',
  `nb_success_mails` int NOT NULL DEFAULT '0',
  `nb_error_mails` int NOT NULL DEFAULT '0',
  `mailing_content` blob NOT NULL,
  `response_content` blob NOT NULL,
  `num_user` int NOT NULL DEFAULT '0',
  `num_campaign` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_mailing_list`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_mailing_types`
--

DROP TABLE IF EXISTS `anim_mailing_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_mailing_types` (
  `id_mailing_type` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `delay` int DEFAULT '0',
  `periodicity` int DEFAULT '0',
  `auto_send` int DEFAULT '0',
  `num_template` int NOT NULL DEFAULT '0',
  `campaign` int NOT NULL DEFAULT '0',
  `num_sender` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_mailing_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_mailings`
--

DROP TABLE IF EXISTS `anim_mailings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_mailings` (
  `id_mailing` int NOT NULL AUTO_INCREMENT,
  `num_animation` int NOT NULL DEFAULT '0',
  `num_mailing_type` int NOT NULL DEFAULT '0',
  `already_mail` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_mailing`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_price_type_categories`
--

DROP TABLE IF EXISTS `anim_price_type_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_price_type_categories` (
  `num_price_type` int NOT NULL,
  `num_noeud` int NOT NULL,
  `ordre_categorie` int DEFAULT NULL,
  PRIMARY KEY (`num_price_type`,`num_noeud`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_price_type_custom`
--

DROP TABLE IF EXISTS `anim_price_type_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_price_type_custom` (
  `idchamp` int NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `filters` int NOT NULL DEFAULT '0',
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_price_type_custom_dates`
--

DROP TABLE IF EXISTS `anim_price_type_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_price_type_custom_dates` (
  `anim_price_type_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `anim_price_type_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `anim_price_type_custom_date_type` int DEFAULT NULL,
  `anim_price_type_custom_date_start` int NOT NULL DEFAULT '0',
  `anim_price_type_custom_date_end` int NOT NULL DEFAULT '0',
  `anim_price_type_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`anim_price_type_custom_champ`,`anim_price_type_custom_origine`,`anim_price_type_custom_order`) USING BTREE,
  KEY `anim_price_type_custom_champ` (`anim_price_type_custom_champ`) USING BTREE,
  KEY `anim_price_type_custom_origine` (`anim_price_type_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_price_type_custom_lists`
--

DROP TABLE IF EXISTS `anim_price_type_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_price_type_custom_lists` (
  `anim_price_type_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `anim_price_type_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `anim_price_type_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`anim_price_type_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`anim_price_type_custom_champ`,`anim_price_type_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_price_type_custom_values`
--

DROP TABLE IF EXISTS `anim_price_type_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_price_type_custom_values` (
  `anim_price_type_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `anim_price_type_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `anim_price_type_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `anim_price_type_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `anim_price_type_custom_integer` int DEFAULT NULL,
  `anim_price_type_custom_date` date DEFAULT NULL,
  `anim_price_type_custom_float` float DEFAULT NULL,
  `anim_price_type_custom_order` int NOT NULL DEFAULT '0',
  KEY `anim_price_type_custom_champ` (`anim_price_type_custom_champ`) USING BTREE,
  KEY `anim_price_type_custom_origine` (`anim_price_type_custom_origine`) USING BTREE,
  KEY `i_encv_st` (`anim_price_type_custom_small_text`) USING BTREE,
  KEY `i_encv_t` (`anim_price_type_custom_text`(255)) USING BTREE,
  KEY `i_encv_i` (`anim_price_type_custom_integer`) USING BTREE,
  KEY `i_encv_d` (`anim_price_type_custom_date`) USING BTREE,
  KEY `i_encv_f` (`anim_price_type_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_price_types`
--

DROP TABLE IF EXISTS `anim_price_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_price_types` (
  `id_price_type` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `default_value` float(12,2) DEFAULT NULL,
  PRIMARY KEY (`id_price_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_prices`
--

DROP TABLE IF EXISTS `anim_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_prices` (
  `id_price` int NOT NULL AUTO_INCREMENT,
  `num_animation` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `value` float(12,2) DEFAULT NULL,
  `num_price_type` int DEFAULT NULL,
  PRIMARY KEY (`id_price`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_registration_origins`
--

DROP TABLE IF EXISTS `anim_registration_origins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_registration_origins` (
  `id_registration_origin` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_registration_origin`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_registration_status`
--

DROP TABLE IF EXISTS `anim_registration_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_registration_status` (
  `id_registration_status` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_registration_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_registrations`
--

DROP TABLE IF EXISTS `anim_registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_registrations` (
  `id_registration` int NOT NULL AUTO_INCREMENT,
  `nb_registered_persons` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `num_animation` int DEFAULT NULL,
  `num_registration_status` int DEFAULT NULL,
  `num_empr` int DEFAULT NULL,
  `num_origin` int DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  PRIMARY KEY (`id_registration`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_registred_persons`
--

DROP TABLE IF EXISTS `anim_registred_persons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_registred_persons` (
  `id_person` int NOT NULL AUTO_INCREMENT,
  `num_empr` int DEFAULT NULL,
  `num_price` int DEFAULT NULL,
  `num_registration` int DEFAULT NULL,
  `person_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_person`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_status`
--

DROP TABLE IF EXISTS `anim_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_status` (
  `id_status` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `color` varchar(7) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '#0D9B7A',
  PRIMARY KEY (`id_status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `anim_types`
--

DROP TABLE IF EXISTS `anim_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anim_types` (
  `id_type` int NOT NULL AUTO_INCREMENT,
  `label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_emplacement`
--

DROP TABLE IF EXISTS `arch_emplacement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arch_emplacement` (
  `archempla_id` int unsigned NOT NULL AUTO_INCREMENT,
  `archempla_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`archempla_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_statut`
--

DROP TABLE IF EXISTS `arch_statut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arch_statut` (
  `archstatut_id` int NOT NULL AUTO_INCREMENT,
  `archstatut_gestion_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `archstatut_opac_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `archstatut_visible_opac` tinyint unsigned NOT NULL DEFAULT '1',
  `archstatut_visible_opac_abon` tinyint unsigned NOT NULL DEFAULT '1',
  `archstatut_visible_gestion` tinyint unsigned NOT NULL DEFAULT '1',
  `archstatut_class_html` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`archstatut_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arch_type`
--

DROP TABLE IF EXISTS `arch_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arch_type` (
  `archtype_id` int unsigned NOT NULL AUTO_INCREMENT,
  `archtype_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`archtype_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audit`
--

DROP TABLE IF EXISTS `audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit` (
  `type_obj` int NOT NULL DEFAULT '0',
  `object_id` int unsigned NOT NULL DEFAULT '0',
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `user_name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `type_modif` int NOT NULL DEFAULT '1',
  `quand` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type_user` int unsigned NOT NULL DEFAULT '0',
  `info` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  KEY `type_obj` (`type_obj`) USING BTREE,
  KEY `object_id` (`object_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `type_modif` (`type_modif`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `aut_link`
--

DROP TABLE IF EXISTS `aut_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aut_link` (
  `id_aut_link` int unsigned NOT NULL AUTO_INCREMENT,
  `aut_link_from` int NOT NULL DEFAULT '0',
  `aut_link_from_num` int NOT NULL DEFAULT '0',
  `aut_link_to` int NOT NULL DEFAULT '0',
  `aut_link_to_num` int NOT NULL DEFAULT '0',
  `aut_link_type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `aut_link_comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `aut_link_string_start_date` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `aut_link_string_end_date` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `aut_link_start_date` date NOT NULL DEFAULT '1970-01-01',
  `aut_link_end_date` date NOT NULL DEFAULT '1970-01-01',
  `aut_link_rank` int NOT NULL DEFAULT '0',
  `aut_link_direction` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `aut_link_reverse_link_num` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_aut_link`) USING BTREE,
  KEY `i_from` (`aut_link_from`,`aut_link_from_num`) USING BTREE,
  KEY `i_to` (`aut_link_to`,`aut_link_to_num`) USING BTREE,
  KEY `aut_link_from` (`aut_link_from`,`aut_link_from_num`,`aut_link_to`,`aut_link_to_num`,`aut_link_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_custom`
--

DROP TABLE IF EXISTS `author_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_custom_dates`
--

DROP TABLE IF EXISTS `author_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author_custom_dates` (
  `author_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `author_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `author_custom_date_type` int DEFAULT NULL,
  `author_custom_date_start` int NOT NULL DEFAULT '0',
  `author_custom_date_end` int NOT NULL DEFAULT '0',
  `author_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`author_custom_champ`,`author_custom_origine`,`author_custom_order`) USING BTREE,
  KEY `author_custom_champ` (`author_custom_champ`) USING BTREE,
  KEY `author_custom_origine` (`author_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_custom_lists`
--

DROP TABLE IF EXISTS `author_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author_custom_lists` (
  `author_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `author_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `author_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`author_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`author_custom_champ`,`author_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `author_custom_values`
--

DROP TABLE IF EXISTS `author_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author_custom_values` (
  `author_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `author_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `author_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `author_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `author_custom_integer` int DEFAULT NULL,
  `author_custom_date` date DEFAULT NULL,
  `author_custom_float` float DEFAULT NULL,
  `author_custom_order` int NOT NULL DEFAULT '0',
  KEY `editorial_custom_champ` (`author_custom_champ`) USING BTREE,
  KEY `editorial_custom_origine` (`author_custom_origine`) USING BTREE,
  KEY `i_acv_st` (`author_custom_small_text`) USING BTREE,
  KEY `i_acv_t` (`author_custom_text`(255)) USING BTREE,
  KEY `i_acv_i` (`author_custom_integer`) USING BTREE,
  KEY `i_acv_d` (`author_custom_date`) USING BTREE,
  KEY `i_acv_f` (`author_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities` (
  `id_authority` int unsigned NOT NULL AUTO_INCREMENT,
  `num_object` int unsigned NOT NULL DEFAULT '0',
  `type_object` int unsigned NOT NULL DEFAULT '0',
  `num_statut` int unsigned NOT NULL DEFAULT '1',
  `thumbnail_url` mediumblob NOT NULL,
  PRIMARY KEY (`id_authority`) USING BTREE,
  UNIQUE KEY `i_a_num_object_type_object` (`num_object`,`type_object`) USING BTREE,
  KEY `i_a_num_statut` (`num_statut`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5077 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities_caddie`
--

DROP TABLE IF EXISTS `authorities_caddie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities_caddie` (
  `idcaddie` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `autorisations_all` int NOT NULL DEFAULT '0',
  `caddie_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `acces_rapide` int NOT NULL DEFAULT '0',
  `favorite_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `creation_user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `creation_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`idcaddie`) USING BTREE,
  KEY `caddie_type` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities_caddie_content`
--

DROP TABLE IF EXISTS `authorities_caddie_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities_caddie_content` (
  `caddie_id` int unsigned NOT NULL DEFAULT '0',
  `object_id` int unsigned NOT NULL DEFAULT '0',
  `flag` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`caddie_id`,`object_id`) USING BTREE,
  KEY `object_id` (`object_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities_caddie_procs`
--

DROP TABLE IF EXISTS `authorities_caddie_procs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities_caddie_procs` (
  `idproc` smallint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'SELECT',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `requete` blob NOT NULL,
  `comment` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `autorisations_all` int NOT NULL DEFAULT '0',
  `parameters` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`idproc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities_fields_global_index`
--

DROP TABLE IF EXISTS `authorities_fields_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities_fields_global_index` (
  `id_authority` int unsigned NOT NULL DEFAULT '0',
  `type` int unsigned NOT NULL DEFAULT '0',
  `code_champ` int NOT NULL DEFAULT '0',
  `code_ss_champ` int NOT NULL DEFAULT '0',
  `ordre` int NOT NULL DEFAULT '0',
  `value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pond` int NOT NULL DEFAULT '100',
  `lang` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `authority_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_authority`,`code_champ`,`code_ss_champ`,`ordre`,`lang`) USING BTREE,
  KEY `i_value` (`value`(300)) USING BTREE,
  KEY `i_id_value` (`id_authority`,`value`(300)) USING BTREE,
  KEY `i_code_champ_code_ss_champ` (`code_champ`,`code_ss_champ`) USING BTREE,
  KEY `i_id_authority` (`id_authority`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities_sources`
--

DROP TABLE IF EXISTS `authorities_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities_sources` (
  `id_authority_source` int unsigned NOT NULL AUTO_INCREMENT,
  `num_authority` int unsigned NOT NULL DEFAULT '0',
  `authority_number` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `authority_type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_origin_authority` int unsigned NOT NULL DEFAULT '0',
  `authority_favorite` int unsigned NOT NULL DEFAULT '0',
  `import_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `update_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id_authority_source`) USING BTREE,
  KEY `i_num_authority_authority_type` (`num_authority`,`authority_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities_statuts`
--

DROP TABLE IF EXISTS `authorities_statuts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities_statuts` (
  `id_authorities_statut` int unsigned NOT NULL AUTO_INCREMENT,
  `authorities_statut_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `authorities_statut_class_html` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `authorities_statut_available_for` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`id_authorities_statut`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authorities_words_global_index`
--

DROP TABLE IF EXISTS `authorities_words_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities_words_global_index` (
  `id_authority` int unsigned NOT NULL DEFAULT '0',
  `type` int unsigned NOT NULL DEFAULT '0',
  `code_champ` int unsigned NOT NULL DEFAULT '0',
  `code_ss_champ` int unsigned NOT NULL DEFAULT '0',
  `num_word` int unsigned NOT NULL DEFAULT '0',
  `pond` int unsigned NOT NULL DEFAULT '100',
  `position` int unsigned NOT NULL DEFAULT '1',
  `field_position` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_authority`,`code_champ`,`code_ss_champ`,`num_word`,`position`,`field_position`) USING BTREE,
  KEY `code_champ` (`code_champ`) USING BTREE,
  KEY `i_id_mot` (`num_word`,`id_authority`) USING BTREE,
  KEY `i_code_champ_code_ss_champ_num_word` (`code_champ`,`code_ss_champ`,`num_word`) USING BTREE,
  KEY `i_num_word` (`num_word`) USING BTREE,
  KEY `i_id_authority` (`id_authority`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `author_type` enum('70','71','72') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '70',
  `author_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `author_rejete` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `author_date` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `author_see` mediumint unsigned NOT NULL DEFAULT '0',
  `author_web` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `index_author` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `author_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `author_lieu` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `author_ville` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `author_pays` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `author_subdivision` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `author_numero` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `author_import_denied` int unsigned NOT NULL DEFAULT '0',
  `author_isni` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`author_id`) USING BTREE,
  KEY `author_see` (`author_see`) USING BTREE,
  KEY `author_name` (`author_name`) USING BTREE,
  KEY `author_rejete` (`author_rejete`) USING BTREE,
  KEY `i_author_type` (`author_type`) USING BTREE,
  KEY `i_index_author_author_type` (`index_author`(333),`author_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2149 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authperso`
--

DROP TABLE IF EXISTS `authperso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authperso` (
  `id_authperso` int unsigned NOT NULL AUTO_INCREMENT,
  `authperso_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `authperso_notice_onglet_num` int unsigned NOT NULL DEFAULT '0',
  `authperso_isbd_script` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `authperso_view_script` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `authperso_opac_search` int unsigned NOT NULL DEFAULT '0',
  `authperso_opac_multi_search` int unsigned NOT NULL DEFAULT '0',
  `authperso_gestion_search` int unsigned NOT NULL DEFAULT '0',
  `authperso_gestion_multi_search` int unsigned NOT NULL DEFAULT '0',
  `authperso_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `authperso_oeuvre_event` int unsigned NOT NULL DEFAULT '0',
  `authperso_responsability_authperso` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_authperso`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authperso_authorities`
--

DROP TABLE IF EXISTS `authperso_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authperso_authorities` (
  `id_authperso_authority` int unsigned NOT NULL AUTO_INCREMENT,
  `authperso_authority_authperso_num` int unsigned NOT NULL DEFAULT '0',
  `authperso_infos_global` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `authperso_index_infos_global` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_authperso_authority`) USING BTREE,
  KEY `i_authperso_authority_authperso_num` (`authperso_authority_authperso_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authperso_custom`
--

DROP TABLE IF EXISTS `authperso_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authperso_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `custom_prefixe` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authperso_custom_dates`
--

DROP TABLE IF EXISTS `authperso_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authperso_custom_dates` (
  `authperso_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `authperso_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `authperso_custom_date_type` int DEFAULT NULL,
  `authperso_custom_date_start` int NOT NULL DEFAULT '0',
  `authperso_custom_date_end` int NOT NULL DEFAULT '0',
  `authperso_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`authperso_custom_champ`,`authperso_custom_origine`,`authperso_custom_order`) USING BTREE,
  KEY `authperso_custom_champ` (`authperso_custom_champ`) USING BTREE,
  KEY `authperso_custom_origine` (`authperso_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authperso_custom_lists`
--

DROP TABLE IF EXISTS `authperso_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authperso_custom_lists` (
  `authperso_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `authperso_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `authperso_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`authperso_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`authperso_custom_champ`,`authperso_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `authperso_custom_values`
--

DROP TABLE IF EXISTS `authperso_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authperso_custom_values` (
  `authperso_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `authperso_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `authperso_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `authperso_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `authperso_custom_integer` int DEFAULT NULL,
  `authperso_custom_date` date DEFAULT NULL,
  `authperso_custom_float` float DEFAULT NULL,
  `authperso_custom_order` int NOT NULL DEFAULT '0',
  KEY `editorial_custom_champ` (`authperso_custom_champ`) USING BTREE,
  KEY `editorial_custom_origine` (`authperso_custom_origine`) USING BTREE,
  KEY `i_acv_st` (`authperso_custom_small_text`) USING BTREE,
  KEY `i_acv_t` (`authperso_custom_text`(255)) USING BTREE,
  KEY `i_acv_i` (`authperso_custom_integer`) USING BTREE,
  KEY `i_acv_d` (`authperso_custom_date`) USING BTREE,
  KEY `i_acv_f` (`authperso_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `avis`
--

DROP TABLE IF EXISTS `avis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avis` (
  `id_avis` mediumint NOT NULL AUTO_INCREMENT,
  `num_empr` mediumint NOT NULL DEFAULT '0',
  `num_notice` mediumint NOT NULL DEFAULT '0',
  `type_object` mediumint NOT NULL,
  `note` int DEFAULT NULL,
  `sujet` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `commentaire` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `dateajout` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `valide` int unsigned NOT NULL DEFAULT '0',
  `avis_rank` int unsigned NOT NULL DEFAULT '0',
  `avis_private` int unsigned NOT NULL DEFAULT '0',
  `avis_num_liste_lecture` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_avis`) USING BTREE,
  KEY `avis_num_notice` (`num_notice`) USING BTREE,
  KEY `avis_num_empr` (`num_empr`) USING BTREE,
  KEY `avis_note` (`note`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannette_abon`
--

DROP TABLE IF EXISTS `bannette_abon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannette_abon` (
  `num_bannette` int unsigned NOT NULL DEFAULT '0',
  `num_empr` int unsigned NOT NULL DEFAULT '0',
  `actif` int unsigned NOT NULL DEFAULT '0',
  `bannette_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`num_bannette`,`num_empr`) USING BTREE,
  KEY `i_num_empr` (`num_empr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannette_contenu`
--

DROP TABLE IF EXISTS `bannette_contenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannette_contenu` (
  `num_bannette` int unsigned NOT NULL DEFAULT '0',
  `num_notice` int unsigned NOT NULL DEFAULT '0',
  `date_ajout` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`num_bannette`,`num_notice`) USING BTREE,
  KEY `date_ajout` (`date_ajout`) USING BTREE,
  KEY `i_num_notice` (`num_notice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannette_empr_categs`
--

DROP TABLE IF EXISTS `bannette_empr_categs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannette_empr_categs` (
  `empr_categ_num_bannette` int unsigned NOT NULL DEFAULT '0',
  `empr_categ_num_categ` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`empr_categ_num_bannette`,`empr_categ_num_categ`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannette_empr_groupes`
--

DROP TABLE IF EXISTS `bannette_empr_groupes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannette_empr_groupes` (
  `empr_groupe_num_bannette` int unsigned NOT NULL DEFAULT '0',
  `empr_groupe_num_groupe` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`empr_groupe_num_bannette`,`empr_groupe_num_groupe`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannette_equation`
--

DROP TABLE IF EXISTS `bannette_equation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannette_equation` (
  `num_bannette` int unsigned NOT NULL DEFAULT '0',
  `num_equation` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_bannette`,`num_equation`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannette_exports`
--

DROP TABLE IF EXISTS `bannette_exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannette_exports` (
  `num_bannette` int unsigned NOT NULL DEFAULT '0',
  `export_format` int NOT NULL DEFAULT '0',
  `export_data` longblob NOT NULL,
  `export_nomfichier` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  PRIMARY KEY (`num_bannette`,`export_format`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannette_facettes`
--

DROP TABLE IF EXISTS `bannette_facettes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannette_facettes` (
  `num_ban_facette` int unsigned NOT NULL DEFAULT '0',
  `ban_facette_critere` int NOT NULL DEFAULT '0',
  `ban_facette_ss_critere` int NOT NULL DEFAULT '0',
  `ban_facette_order` int NOT NULL DEFAULT '0',
  `ban_facette_order_sort` int NOT NULL DEFAULT '0',
  `ban_facette_datatype_sort` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'alpha',
  KEY `bannette_facettes_key` (`num_ban_facette`,`ban_facette_critere`,`ban_facette_ss_critere`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannette_tpl`
--

DROP TABLE IF EXISTS `bannette_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannette_tpl` (
  `bannettetpl_id` int unsigned NOT NULL AUTO_INCREMENT,
  `bannettetpl_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `bannettetpl_comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `bannettetpl_tpl` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`bannettetpl_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannettes`
--

DROP TABLE IF EXISTS `bannettes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannettes` (
  `id_bannette` int unsigned NOT NULL AUTO_INCREMENT,
  `num_classement` int unsigned NOT NULL DEFAULT '1',
  `nom_bannette` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `comment_gestion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment_public` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `entete_mail` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `date_last_remplissage` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `date_last_envoi` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `proprio_bannette` int unsigned NOT NULL DEFAULT '0',
  `bannette_auto` int unsigned NOT NULL DEFAULT '0',
  `periodicite` int unsigned NOT NULL DEFAULT '7',
  `diffusion_email` int unsigned NOT NULL DEFAULT '0',
  `categorie_lecteurs` int unsigned NOT NULL DEFAULT '0',
  `nb_notices_diff` int unsigned NOT NULL DEFAULT '0',
  `num_panier` int unsigned NOT NULL DEFAULT '0',
  `limite_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `limite_nombre` int NOT NULL DEFAULT '0',
  `update_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'C',
  `typeexport` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `prefixe_fichier` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `param_export` blob NOT NULL,
  `piedpage_mail` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `notice_display_type` int unsigned NOT NULL DEFAULT '0',
  `notice_tpl` int unsigned NOT NULL DEFAULT '0',
  `django_directory` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `group_type` int unsigned NOT NULL DEFAULT '0',
  `group_pperso` int unsigned NOT NULL DEFAULT '0',
  `display_notice_in_every_group` int unsigned NOT NULL DEFAULT '0',
  `statut_not_account` int unsigned NOT NULL DEFAULT '0',
  `archive_number` int unsigned NOT NULL DEFAULT '0',
  `document_generate` int unsigned NOT NULL DEFAULT '0',
  `document_notice_display_type` int unsigned NOT NULL DEFAULT '0',
  `document_notice_tpl` int unsigned NOT NULL DEFAULT '0',
  `document_django_directory` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `document_insert_docnum` int unsigned NOT NULL DEFAULT '0',
  `document_group` int unsigned NOT NULL DEFAULT '0',
  `document_add_summary` int unsigned NOT NULL DEFAULT '0',
  `groupe_lecteurs` int unsigned NOT NULL DEFAULT '0',
  `bannette_opac_accueil` int unsigned NOT NULL DEFAULT '0',
  `bannette_tpl_num` int unsigned NOT NULL DEFAULT '0',
  `bannette_aff_notice_number` int unsigned NOT NULL DEFAULT '1',
  `associated_campaign` int unsigned NOT NULL DEFAULT '0',
  `bannette_num_sender` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_bannette`) USING BTREE,
  KEY `i_bannette_tpl_num` (`bannette_tpl_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bannettes_descriptors`
--

DROP TABLE IF EXISTS `bannettes_descriptors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bannettes_descriptors` (
  `num_bannette` int NOT NULL DEFAULT '0',
  `num_noeud` int NOT NULL DEFAULT '0',
  `bannette_descriptor_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_bannette`,`num_noeud`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `barcodes_sheets`
--

DROP TABLE IF EXISTS `barcodes_sheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `barcodes_sheets` (
  `id_barcodes_sheet` int unsigned NOT NULL AUTO_INCREMENT,
  `barcodes_sheet_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `barcodes_sheet_data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `barcodes_sheet_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_barcodes_sheet`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `budgets`
--

DROP TABLE IF EXISTS `budgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `budgets` (
  `id_budget` int unsigned NOT NULL AUTO_INCREMENT,
  `num_entite` int unsigned NOT NULL DEFAULT '0',
  `num_exercice` int unsigned NOT NULL DEFAULT '0',
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `commentaires` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `montant_global` double(12,2) unsigned NOT NULL DEFAULT '0.00',
  `seuil_alerte` int unsigned NOT NULL DEFAULT '100',
  `statut` int unsigned NOT NULL DEFAULT '0',
  `type_budget` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_budget`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bulletins`
--

DROP TABLE IF EXISTS `bulletins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bulletins` (
  `bulletin_id` int unsigned NOT NULL AUTO_INCREMENT,
  `bulletin_numero` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `bulletin_notice` int NOT NULL DEFAULT '0',
  `mention_date` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `date_date` date NOT NULL DEFAULT '1970-01-01',
  `bulletin_titre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `index_titre` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `bulletin_cb` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `num_notice` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bulletin_id`) USING BTREE,
  KEY `bulletin_numero` (`bulletin_numero`) USING BTREE,
  KEY `bulletin_notice` (`bulletin_notice`) USING BTREE,
  KEY `date_date` (`date_date`) USING BTREE,
  KEY `i_num_notice` (`num_notice`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cache_amendes`
--

DROP TABLE IF EXISTS `cache_amendes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_amendes` (
  `id_empr` int unsigned NOT NULL DEFAULT '0',
  `cache_date` date NOT NULL DEFAULT '1970-01-01',
  `data_amendes` blob NOT NULL,
  KEY `id_empr` (`id_empr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caddie`
--

DROP TABLE IF EXISTS `caddie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caddie` (
  `idcaddie` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'NOTI',
  `comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `autorisations_all` int NOT NULL DEFAULT '0',
  `caddie_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `acces_rapide` int NOT NULL DEFAULT '0',
  `favorite_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `creation_user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `creation_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`idcaddie`) USING BTREE,
  KEY `caddie_type` (`type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caddie_content`
--

DROP TABLE IF EXISTS `caddie_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caddie_content` (
  `caddie_id` int unsigned NOT NULL DEFAULT '0',
  `object_id` int unsigned NOT NULL DEFAULT '0',
  `content` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `blob_type` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `flag` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`caddie_id`,`object_id`,`content`) USING BTREE,
  KEY `object_id` (`object_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caddie_procs`
--

DROP TABLE IF EXISTS `caddie_procs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caddie_procs` (
  `idproc` smallint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'SELECT',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `requete` blob NOT NULL,
  `comment` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `autorisations_all` int NOT NULL DEFAULT '0',
  `parameters` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`idproc`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns` (
  `id_campaign` int unsigned NOT NULL AUTO_INCREMENT,
  `campaign_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `campaign_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `campaign_date` datetime DEFAULT NULL,
  `campaign_num_user` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_campaign`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaigns_descriptors`
--

DROP TABLE IF EXISTS `campaigns_descriptors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns_descriptors` (
  `num_campaign` int unsigned NOT NULL DEFAULT '0',
  `num_noeud` int unsigned NOT NULL DEFAULT '0',
  `campaign_descriptor_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_campaign`,`num_noeud`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaigns_logs`
--

DROP TABLE IF EXISTS `campaigns_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns_logs` (
  `campaign_log_num_campaign` int NOT NULL DEFAULT '0',
  `campaign_log_num_recipient` int NOT NULL DEFAULT '0',
  `campaign_log_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `campaign_log_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `campaign_log_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  KEY `i_campaign_log_num_campaign` (`campaign_log_num_campaign`) USING BTREE,
  KEY `i_campaign_log_num_recipient` (`campaign_log_num_recipient`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaigns_recipients`
--

DROP TABLE IF EXISTS `campaigns_recipients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns_recipients` (
  `id_campaign_recipient` int unsigned NOT NULL AUTO_INCREMENT,
  `campaign_recipient_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `campaign_recipient_num_campaign` int NOT NULL DEFAULT '0',
  `campaign_recipient_num_empr` int NOT NULL DEFAULT '0',
  `campaign_recipient_empr_cp` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `campaign_recipient_empr_ville` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `campaign_recipient_empr_prof` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `campaign_recipient_empr_year` int NOT NULL DEFAULT '0',
  `campaign_recipient_empr_categ` smallint unsigned DEFAULT '0',
  `campaign_recipient_empr_codestat` smallint unsigned DEFAULT '0',
  `campaign_recipient_empr_sexe` tinyint unsigned DEFAULT '0',
  `campaign_recipient_empr_statut` bigint unsigned DEFAULT '0',
  `campaign_recipient_empr_location` int unsigned DEFAULT '0',
  PRIMARY KEY (`id_campaign_recipient`) USING BTREE,
  KEY `i_campaign_recipient_num_campaign` (`campaign_recipient_num_campaign`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaigns_stats`
--

DROP TABLE IF EXISTS `campaigns_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns_stats` (
  `campaign_stat_num_campaign` int NOT NULL DEFAULT '0',
  `campaign_stat_data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `campaign_stat_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`campaign_stat_num_campaign`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `campaigns_tags`
--

DROP TABLE IF EXISTS `campaigns_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns_tags` (
  `num_campaign` int unsigned NOT NULL DEFAULT '0',
  `num_tag` int unsigned NOT NULL DEFAULT '0',
  `campaign_tag_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_campaign`,`num_tag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashdesk`
--

DROP TABLE IF EXISTS `cashdesk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashdesk` (
  `cashdesk_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cashdesk_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cashdesk_autorisations` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cashdesk_transactypes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cashdesk_cashbox` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cashdesk_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashdesk_locations`
--

DROP TABLE IF EXISTS `cashdesk_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashdesk_locations` (
  `cashdesk_loc_cashdesk_num` int unsigned NOT NULL DEFAULT '0',
  `cashdesk_loc_num` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cashdesk_loc_cashdesk_num`,`cashdesk_loc_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cashdesk_sections`
--

DROP TABLE IF EXISTS `cashdesk_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cashdesk_sections` (
  `cashdesk_section_cashdesk_num` int unsigned NOT NULL DEFAULT '0',
  `cashdesk_section_num` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cashdesk_section_cashdesk_num`,`cashdesk_section_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categ_custom`
--

DROP TABLE IF EXISTS `categ_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categ_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categ_custom_dates`
--

DROP TABLE IF EXISTS `categ_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categ_custom_dates` (
  `categ_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `categ_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `categ_custom_date_type` int DEFAULT NULL,
  `categ_custom_date_start` int NOT NULL DEFAULT '0',
  `categ_custom_date_end` int NOT NULL DEFAULT '0',
  `categ_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`categ_custom_champ`,`categ_custom_origine`,`categ_custom_order`) USING BTREE,
  KEY `categ_custom_champ` (`categ_custom_champ`) USING BTREE,
  KEY `categ_custom_origine` (`categ_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categ_custom_lists`
--

DROP TABLE IF EXISTS `categ_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categ_custom_lists` (
  `categ_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `categ_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `categ_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`categ_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`categ_custom_champ`,`categ_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categ_custom_values`
--

DROP TABLE IF EXISTS `categ_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categ_custom_values` (
  `categ_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `categ_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `categ_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `categ_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `categ_custom_integer` int DEFAULT NULL,
  `categ_custom_date` date DEFAULT NULL,
  `categ_custom_float` float DEFAULT NULL,
  `categ_custom_order` int NOT NULL DEFAULT '0',
  KEY `editorial_custom_champ` (`categ_custom_champ`) USING BTREE,
  KEY `editorial_custom_origine` (`categ_custom_origine`) USING BTREE,
  KEY `i_ccv_st` (`categ_custom_small_text`) USING BTREE,
  KEY `i_ccv_t` (`categ_custom_text`(255)) USING BTREE,
  KEY `i_ccv_i` (`categ_custom_integer`) USING BTREE,
  KEY `i_ccv_d` (`categ_custom_date`) USING BTREE,
  KEY `i_ccv_f` (`categ_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `num_thesaurus` int unsigned NOT NULL DEFAULT '1',
  `num_noeud` int unsigned NOT NULL DEFAULT '0',
  `langue` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'fr_FR',
  `libelle_categorie` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `note_application` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment_public` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment_voir` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `index_categorie` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `path_word_categ` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `index_path_word_categ` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`num_noeud`,`langue`) USING BTREE,
  KEY `categ_langue` (`langue`) USING BTREE,
  KEY `libelle_categorie` (`libelle_categorie`(5)) USING BTREE,
  KEY `i_num_thesaurus` (`num_thesaurus`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chat_groups`
--

DROP TABLE IF EXISTS `chat_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_groups` (
  `id_chat_group` int unsigned NOT NULL AUTO_INCREMENT,
  `chat_group_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `chat_group_author_user_type` int unsigned NOT NULL DEFAULT '0',
  `chat_group_author_user_num` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_chat_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chat_messages`
--

DROP TABLE IF EXISTS `chat_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_messages` (
  `id_chat_message` int unsigned NOT NULL AUTO_INCREMENT,
  `chat_message_from_user_type` int unsigned NOT NULL DEFAULT '0',
  `chat_message_from_user_num` int unsigned NOT NULL DEFAULT '0',
  `chat_message_to_user_type` int unsigned NOT NULL DEFAULT '0',
  `chat_message_to_user_num` int unsigned NOT NULL DEFAULT '0',
  `chat_message_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `chat_message_file` blob,
  `chat_message_read` int unsigned NOT NULL DEFAULT '0',
  `chat_message_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_chat_message`) USING BTREE,
  KEY `i_from_user_num` (`chat_message_from_user_num`,`chat_message_from_user_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chat_users_groups`
--

DROP TABLE IF EXISTS `chat_users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_users_groups` (
  `chat_user_group_num` int unsigned NOT NULL DEFAULT '0',
  `chat_user_group_user_type` int unsigned NOT NULL DEFAULT '0',
  `chat_user_group_user_num` int unsigned NOT NULL DEFAULT '0',
  `chat_user_group_unread_messages_number` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`chat_user_group_num`,`chat_user_group_user_type`,`chat_user_group_user_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `classements`
--

DROP TABLE IF EXISTS `classements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classements` (
  `id_classement` int unsigned NOT NULL AUTO_INCREMENT,
  `type_classement` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'BAN',
  `nom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `classement_opac_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `classement_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_classement`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms`
--

DROP TABLE IF EXISTS `cms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms` (
  `id_cms` int unsigned NOT NULL AUTO_INCREMENT,
  `cms_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cms_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cms_opac_default` int unsigned NOT NULL DEFAULT '0',
  `cms_opac_view_num` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cms`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_articles`
--

DROP TABLE IF EXISTS `cms_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_articles` (
  `id_article` int unsigned NOT NULL AUTO_INCREMENT,
  `article_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `article_resume` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `article_contenu` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `article_logo` mediumblob NOT NULL,
  `article_publication_state` int unsigned NOT NULL DEFAULT '0',
  `article_start_date` datetime DEFAULT NULL,
  `article_end_date` datetime DEFAULT NULL,
  `num_section` int NOT NULL DEFAULT '0',
  `article_num_type` int unsigned NOT NULL DEFAULT '0',
  `article_creation_date` datetime DEFAULT NULL,
  `article_order` int unsigned DEFAULT '0',
  `article_update_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_article`) USING BTREE,
  KEY `i_cms_article_title` (`article_title`) USING BTREE,
  KEY `i_cms_article_publication_state` (`article_publication_state`) USING BTREE,
  KEY `i_cms_article_num_parent` (`num_section`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_articles_descriptors`
--

DROP TABLE IF EXISTS `cms_articles_descriptors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_articles_descriptors` (
  `num_article` int NOT NULL DEFAULT '0',
  `num_noeud` int NOT NULL DEFAULT '0',
  `article_descriptor_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_article`,`num_noeud`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_build`
--

DROP TABLE IF EXISTS `cms_build`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_build` (
  `id_build` int unsigned NOT NULL AUTO_INCREMENT,
  `build_version_num` int NOT NULL DEFAULT '0',
  `build_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'cadre',
  `build_fixed` int NOT NULL DEFAULT '0',
  `build_obj` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `build_page` int NOT NULL DEFAULT '0',
  `build_parent` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `build_child_before` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `build_child_after` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `build_css` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `build_div` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_build`) USING BTREE,
  KEY `cms_build_index` (`build_version_num`,`build_obj`) USING BTREE,
  KEY `i_build_parent_build_version_num` (`build_parent`,`build_version_num`) USING BTREE,
  KEY `i_build_obj_build_version_num` (`build_obj`,`build_version_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69361 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_cache_cadres`
--

DROP TABLE IF EXISTS `cms_cache_cadres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_cache_cadres` (
  `cache_cadre_hash` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cache_cadre_type_content` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cache_cadre_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cache_cadre_content` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`cache_cadre_hash`,`cache_cadre_type_content`) USING BTREE,
  KEY `i_cache_cadre_create_date` (`cache_cadre_create_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_cadre_content`
--

DROP TABLE IF EXISTS `cms_cadre_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_cadre_content` (
  `id_cadre_content` int unsigned NOT NULL AUTO_INCREMENT,
  `cadre_content_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_content_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_content_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_content_num_cadre` int unsigned NOT NULL DEFAULT '0',
  `cadre_content_data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cadre_content_num_cadre_content` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cadre_content`) USING BTREE,
  KEY `i_cadre_content_num_cadre` (`cadre_content_num_cadre`) USING BTREE,
  KEY `i_cadre_content_num_cadre_content_cadre_content_type` (`cadre_content_num_cadre_content`,`cadre_content_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1061 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_cadres`
--

DROP TABLE IF EXISTS `cms_cadres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_cadres` (
  `id_cadre` int unsigned NOT NULL AUTO_INCREMENT,
  `cadre_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_fixed` int NOT NULL DEFAULT '0',
  `cadre_styles` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cadre_dom_parent` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_dom_after` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cadre_memo_url` int NOT NULL DEFAULT '0',
  `cadre_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_modcache` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'get_post_view',
  `cadre_css_class` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_cadre`) USING BTREE,
  KEY `i_cadre_memo_url` (`cadre_memo_url`) USING BTREE,
  KEY `i_cadre_object` (`cadre_object`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=190 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_collections`
--

DROP TABLE IF EXISTS `cms_collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_collections` (
  `id_collection` int unsigned NOT NULL AUTO_INCREMENT,
  `collection_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `collection_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `collection_num_parent` int NOT NULL DEFAULT '0',
  `collection_num_storage` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_collection`) USING BTREE,
  KEY `i_cms_collection_title` (`collection_title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_documents`
--

DROP TABLE IF EXISTS `cms_documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_documents` (
  `id_document` int unsigned NOT NULL AUTO_INCREMENT,
  `document_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `document_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `document_filename` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `document_mimetype` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `document_filesize` int NOT NULL DEFAULT '0',
  `document_vignette` mediumblob NOT NULL,
  `document_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `document_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `document_create_date` date NOT NULL DEFAULT '1970-01-01',
  `document_num_storage` int NOT NULL DEFAULT '0',
  `document_type_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `document_num_object` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_document`) USING BTREE,
  KEY `i_cms_document_title` (`document_title`) USING BTREE,
  KEY `i_document_num_object_document_type_object` (`document_num_object`,`document_type_object`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_documents_links`
--

DROP TABLE IF EXISTS `cms_documents_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_documents_links` (
  `document_link_type_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `document_link_num_object` int NOT NULL DEFAULT '0',
  `document_link_num_document` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`document_link_type_object`,`document_link_num_object`,`document_link_num_document`) USING BTREE,
  KEY `i_document_link_num_document` (`document_link_num_document`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_editorial_custom`
--

DROP TABLE IF EXISTS `cms_editorial_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_editorial_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE,
  KEY `i_num_type` (`num_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_editorial_custom_dates`
--

DROP TABLE IF EXISTS `cms_editorial_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_editorial_custom_dates` (
  `cms_editorial_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `cms_editorial_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `cms_editorial_custom_date_type` int DEFAULT NULL,
  `cms_editorial_custom_date_start` int NOT NULL DEFAULT '0',
  `cms_editorial_custom_date_end` int NOT NULL DEFAULT '0',
  `cms_editorial_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cms_editorial_custom_champ`,`cms_editorial_custom_origine`,`cms_editorial_custom_order`) USING BTREE,
  KEY `cms_editorial_custom_champ` (`cms_editorial_custom_champ`) USING BTREE,
  KEY `cms_editorial_custom_origine` (`cms_editorial_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_editorial_custom_lists`
--

DROP TABLE IF EXISTS `cms_editorial_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_editorial_custom_lists` (
  `cms_editorial_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `cms_editorial_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cms_editorial_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`cms_editorial_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`cms_editorial_custom_champ`,`cms_editorial_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_editorial_custom_values`
--

DROP TABLE IF EXISTS `cms_editorial_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_editorial_custom_values` (
  `cms_editorial_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `cms_editorial_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `cms_editorial_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cms_editorial_custom_text` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `cms_editorial_custom_integer` int DEFAULT NULL,
  `cms_editorial_custom_date` date DEFAULT NULL,
  `cms_editorial_custom_float` float DEFAULT NULL,
  `cms_editorial_custom_order` int NOT NULL DEFAULT '0',
  KEY `editorial_custom_champ` (`cms_editorial_custom_champ`) USING BTREE,
  KEY `editorial_custom_origine` (`cms_editorial_custom_origine`) USING BTREE,
  KEY `i_ccv_st` (`cms_editorial_custom_small_text`) USING BTREE,
  KEY `i_ccv_t` (`cms_editorial_custom_text`(255)) USING BTREE,
  KEY `i_ccv_i` (`cms_editorial_custom_integer`) USING BTREE,
  KEY `i_ccv_d` (`cms_editorial_custom_date`) USING BTREE,
  KEY `i_ccv_f` (`cms_editorial_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_editorial_fields_global_index`
--

DROP TABLE IF EXISTS `cms_editorial_fields_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_editorial_fields_global_index` (
  `num_obj` int unsigned NOT NULL DEFAULT '0',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `code_champ` int NOT NULL DEFAULT '0',
  `code_ss_champ` int NOT NULL DEFAULT '0',
  `ordre` int NOT NULL DEFAULT '0',
  `value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pond` int NOT NULL DEFAULT '100',
  `lang` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`num_obj`,`type`,`code_champ`,`code_ss_champ`,`ordre`,`lang`) USING BTREE,
  KEY `i_value` (`value`(300)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_editorial_publications_states`
--

DROP TABLE IF EXISTS `cms_editorial_publications_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_editorial_publications_states` (
  `id_publication_state` int unsigned NOT NULL AUTO_INCREMENT,
  `editorial_publication_state_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `editorial_publication_state_opac_show` int NOT NULL DEFAULT '0',
  `editorial_publication_state_auth_opac_show` int NOT NULL DEFAULT '0',
  `editorial_publication_state_class_html` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_publication_state`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_editorial_types`
--

DROP TABLE IF EXISTS `cms_editorial_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_editorial_types` (
  `id_editorial_type` int unsigned NOT NULL AUTO_INCREMENT,
  `editorial_type_element` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `editorial_type_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `editorial_type_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `editorial_type_extension` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `editorial_type_permalink_num_page` int NOT NULL DEFAULT '0',
  `editorial_type_permalink_var_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_editorial_type`) USING BTREE,
  KEY `i_editorial_type_element` (`editorial_type_element`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_editorial_words_global_index`
--

DROP TABLE IF EXISTS `cms_editorial_words_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_editorial_words_global_index` (
  `num_obj` int unsigned NOT NULL DEFAULT '0',
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `code_champ` int NOT NULL DEFAULT '0',
  `code_ss_champ` int NOT NULL DEFAULT '0',
  `num_word` int NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `position` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`num_obj`,`type`,`code_champ`,`code_ss_champ`,`num_word`,`position`) USING BTREE,
  KEY `i_num_word` (`num_word`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_hash`
--

DROP TABLE IF EXISTS `cms_hash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_hash` (
  `hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`hash`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_managed_modules`
--

DROP TABLE IF EXISTS `cms_managed_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_managed_modules` (
  `managed_module_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `managed_module_box` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`managed_module_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_modules_extensions_datas`
--

DROP TABLE IF EXISTS `cms_modules_extensions_datas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_modules_extensions_datas` (
  `id_extension_datas` int NOT NULL AUTO_INCREMENT,
  `extension_datas_module` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `extension_datas_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `extension_datas_type_element` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `extension_datas_num_element` int NOT NULL DEFAULT '0',
  `extension_datas_datas` blob,
  PRIMARY KEY (`id_extension_datas`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_pages`
--

DROP TABLE IF EXISTS `cms_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_pages` (
  `id_page` int unsigned NOT NULL AUTO_INCREMENT,
  `page_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `page_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `page_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_page`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_pages_env`
--

DROP TABLE IF EXISTS `cms_pages_env`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_pages_env` (
  `page_env_num_page` int unsigned NOT NULL AUTO_INCREMENT,
  `page_env_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_env_id_selector` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`page_env_num_page`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_sections`
--

DROP TABLE IF EXISTS `cms_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sections` (
  `id_section` int unsigned NOT NULL AUTO_INCREMENT,
  `section_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `section_resume` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `section_logo` mediumblob NOT NULL,
  `section_publication_state` int unsigned NOT NULL DEFAULT '0',
  `section_start_date` datetime DEFAULT NULL,
  `section_end_date` datetime DEFAULT NULL,
  `section_num_parent` int NOT NULL DEFAULT '0',
  `section_num_type` int unsigned NOT NULL DEFAULT '0',
  `section_creation_date` datetime DEFAULT NULL,
  `section_order` int unsigned DEFAULT '0',
  `section_update_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_section`) USING BTREE,
  KEY `i_cms_section_title` (`section_title`) USING BTREE,
  KEY `i_cms_section_publication_state` (`section_publication_state`) USING BTREE,
  KEY `i_cms_section_num_parent` (`section_num_parent`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_sections_descriptors`
--

DROP TABLE IF EXISTS `cms_sections_descriptors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_sections_descriptors` (
  `num_section` int NOT NULL DEFAULT '0',
  `num_noeud` int NOT NULL DEFAULT '0',
  `section_descriptor_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_section`,`num_noeud`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_toolkits`
--

DROP TABLE IF EXISTS `cms_toolkits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_toolkits` (
  `cms_toolkit_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cms_toolkit_active` int NOT NULL DEFAULT '0',
  `cms_toolkit_data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cms_toolkit_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cms_toolkit_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_vars`
--

DROP TABLE IF EXISTS `cms_vars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_vars` (
  `id_var` int unsigned NOT NULL AUTO_INCREMENT,
  `var_num_page` int unsigned NOT NULL DEFAULT '0',
  `var_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `var_comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_var`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cms_version`
--

DROP TABLE IF EXISTS `cms_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_version` (
  `id_version` int unsigned NOT NULL AUTO_INCREMENT,
  `version_cms_num` int unsigned NOT NULL DEFAULT '0',
  `version_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `version_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `version_public` int unsigned NOT NULL DEFAULT '0',
  `version_user` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_version`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=991 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_custom`
--

DROP TABLE IF EXISTS `collection_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collection_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_custom_dates`
--

DROP TABLE IF EXISTS `collection_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collection_custom_dates` (
  `collection_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `collection_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `collection_custom_date_type` int DEFAULT NULL,
  `collection_custom_date_start` int NOT NULL DEFAULT '0',
  `collection_custom_date_end` int NOT NULL DEFAULT '0',
  `collection_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`collection_custom_champ`,`collection_custom_origine`,`collection_custom_order`) USING BTREE,
  KEY `collection_custom_champ` (`collection_custom_champ`) USING BTREE,
  KEY `collection_custom_origine` (`collection_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_custom_lists`
--

DROP TABLE IF EXISTS `collection_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collection_custom_lists` (
  `collection_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `collection_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `collection_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`collection_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`collection_custom_champ`,`collection_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collection_custom_values`
--

DROP TABLE IF EXISTS `collection_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collection_custom_values` (
  `collection_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `collection_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `collection_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `collection_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `collection_custom_integer` int DEFAULT NULL,
  `collection_custom_date` date DEFAULT NULL,
  `collection_custom_float` float DEFAULT NULL,
  `collection_custom_order` int NOT NULL DEFAULT '0',
  KEY `editorial_custom_champ` (`collection_custom_champ`) USING BTREE,
  KEY `editorial_custom_origine` (`collection_custom_origine`) USING BTREE,
  KEY `i_ccv_st` (`collection_custom_small_text`) USING BTREE,
  KEY `i_ccv_t` (`collection_custom_text`(255)) USING BTREE,
  KEY `i_ccv_i` (`collection_custom_integer`) USING BTREE,
  KEY `i_ccv_d` (`collection_custom_date`) USING BTREE,
  KEY `i_ccv_f` (`collection_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections` (
  `collection_id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `collection_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `collection_parent` mediumint unsigned NOT NULL DEFAULT '0',
  `collection_issn` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `index_coll` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `collection_web` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `collection_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `authority_import_denied` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`collection_id`) USING BTREE,
  KEY `collection_name` (`collection_name`) USING BTREE,
  KEY `collection_parent` (`collection_parent`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=390 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collections_state`
--

DROP TABLE IF EXISTS `collections_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections_state` (
  `collstate_id` int NOT NULL AUTO_INCREMENT,
  `id_serial` mediumint unsigned NOT NULL DEFAULT '0',
  `location_id` smallint unsigned NOT NULL DEFAULT '0',
  `state_collections` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `collstate_emplacement` int unsigned NOT NULL DEFAULT '0',
  `collstate_type` int unsigned NOT NULL DEFAULT '0',
  `collstate_origine` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `collstate_cote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `collstate_archive` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `collstate_statut` int unsigned NOT NULL DEFAULT '0',
  `collstate_lacune` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `collstate_note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`collstate_id`) USING BTREE,
  KEY `i_colls_arc` (`collstate_archive`) USING BTREE,
  KEY `i_colls_empl` (`collstate_emplacement`) USING BTREE,
  KEY `i_colls_type` (`collstate_type`) USING BTREE,
  KEY `i_colls_orig` (`collstate_origine`) USING BTREE,
  KEY `i_colls_cote` (`collstate_cote`) USING BTREE,
  KEY `i_colls_stat` (`collstate_statut`) USING BTREE,
  KEY `i_colls_serial` (`id_serial`) USING BTREE,
  KEY `i_colls_loc` (`location_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collstate_bulletins`
--

DROP TABLE IF EXISTS `collstate_bulletins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collstate_bulletins` (
  `collstate_bulletins_num_collstate` int NOT NULL DEFAULT '0',
  `collstate_bulletins_num_bulletin` int NOT NULL DEFAULT '0',
  `collstate_bulletins_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`collstate_bulletins_num_collstate`,`collstate_bulletins_num_bulletin`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collstate_custom`
--

DROP TABLE IF EXISTS `collstate_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collstate_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int NOT NULL DEFAULT '0',
  `search` int NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collstate_custom_dates`
--

DROP TABLE IF EXISTS `collstate_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collstate_custom_dates` (
  `collstate_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `collstate_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `collstate_custom_date_type` int DEFAULT NULL,
  `collstate_custom_date_start` int NOT NULL DEFAULT '0',
  `collstate_custom_date_end` int NOT NULL DEFAULT '0',
  `collstate_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`collstate_custom_champ`,`collstate_custom_origine`,`collstate_custom_order`) USING BTREE,
  KEY `collstate_custom_champ` (`collstate_custom_champ`) USING BTREE,
  KEY `collstate_custom_origine` (`collstate_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collstate_custom_lists`
--

DROP TABLE IF EXISTS `collstate_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collstate_custom_lists` (
  `collstate_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `collstate_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `collstate_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ordre` int NOT NULL DEFAULT '0',
  KEY `collstate_custom_champ` (`collstate_custom_champ`) USING BTREE,
  KEY `i_ccl_lv` (`collstate_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collstate_custom_values`
--

DROP TABLE IF EXISTS `collstate_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collstate_custom_values` (
  `collstate_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `collstate_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `collstate_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `collstate_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `collstate_custom_integer` int DEFAULT NULL,
  `collstate_custom_date` date DEFAULT NULL,
  `collstate_custom_float` float DEFAULT NULL,
  `collstate_custom_order` int NOT NULL DEFAULT '0',
  KEY `collstate_custom_champ` (`collstate_custom_champ`) USING BTREE,
  KEY `collstate_custom_origine` (`collstate_custom_origine`) USING BTREE,
  KEY `i_ccv_st` (`collstate_custom_small_text`) USING BTREE,
  KEY `i_ccv_t` (`collstate_custom_text`(255)) USING BTREE,
  KEY `i_ccv_i` (`collstate_custom_integer`) USING BTREE,
  KEY `i_ccv_d` (`collstate_custom_date`) USING BTREE,
  KEY `i_ccv_f` (`collstate_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comptes`
--

DROP TABLE IF EXISTS `comptes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comptes` (
  `id_compte` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `type_compte_id` int unsigned NOT NULL DEFAULT '0',
  `solde` decimal(16,2) DEFAULT '0.00',
  `prepay_mnt` decimal(16,2) NOT NULL DEFAULT '0.00',
  `proprio_id` int unsigned NOT NULL DEFAULT '0',
  `droits` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_compte`) USING BTREE,
  KEY `i_cpt_proprio_id` (`proprio_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors`
--

DROP TABLE IF EXISTS `connectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors` (
  `connector_id` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `parameters` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `repository` int NOT NULL DEFAULT '0',
  `timeout` int NOT NULL DEFAULT '5',
  `retry` int NOT NULL DEFAULT '3',
  `ttl` int NOT NULL DEFAULT '1440',
  PRIMARY KEY (`connector_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_categ`
--

DROP TABLE IF EXISTS `connectors_categ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_categ` (
  `connectors_categ_id` smallint NOT NULL AUTO_INCREMENT,
  `connectors_categ_name` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `opac_expanded` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`connectors_categ_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_categ_sources`
--

DROP TABLE IF EXISTS `connectors_categ_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_categ_sources` (
  `num_categ` smallint NOT NULL DEFAULT '0',
  `num_source` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_categ`,`num_source`) USING BTREE,
  KEY `i_num_source` (`num_source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out`
--

DROP TABLE IF EXISTS `connectors_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out` (
  `connectors_out_id` int NOT NULL AUTO_INCREMENT,
  `connectors_out_config` longblob NOT NULL,
  PRIMARY KEY (`connectors_out_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_oai_deleted_records`
--

DROP TABLE IF EXISTS `connectors_out_oai_deleted_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_oai_deleted_records` (
  `num_set` int unsigned NOT NULL DEFAULT '0',
  `num_notice` int unsigned NOT NULL DEFAULT '0',
  `deletion_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`num_set`,`num_notice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_oai_tokens`
--

DROP TABLE IF EXISTS `connectors_out_oai_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_oai_tokens` (
  `connectors_out_oai_token_token` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `connectors_out_oai_token_environnement` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `connectors_out_oai_token_expirationdate` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`connectors_out_oai_token_token`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_setcache_values`
--

DROP TABLE IF EXISTS `connectors_out_setcache_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_setcache_values` (
  `connectors_out_setcache_values_cachenum` int NOT NULL DEFAULT '0',
  `connectors_out_setcache_values_value` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`connectors_out_setcache_values_cachenum`,`connectors_out_setcache_values_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_setcaches`
--

DROP TABLE IF EXISTS `connectors_out_setcaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_setcaches` (
  `connectors_out_setcache_id` int NOT NULL AUTO_INCREMENT,
  `connectors_out_setcache_setnum` int NOT NULL DEFAULT '0',
  `connectors_out_setcache_lifeduration` int NOT NULL DEFAULT '0',
  `connectors_out_setcache_lifeduration_unit` enum('seconds','minutes','hours','days','weeks','months') CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'seconds',
  `connectors_out_setcache_lastupdatedate` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`connectors_out_setcache_id`) USING BTREE,
  UNIQUE KEY `connectors_out_setcache_setnum` (`connectors_out_setcache_setnum`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_setcateg_sets`
--

DROP TABLE IF EXISTS `connectors_out_setcateg_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_setcateg_sets` (
  `connectors_out_setcategset_setnum` int NOT NULL,
  `connectors_out_setcategset_categnum` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`connectors_out_setcategset_setnum`,`connectors_out_setcategset_categnum`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_setcategs`
--

DROP TABLE IF EXISTS `connectors_out_setcategs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_setcategs` (
  `connectors_out_setcateg_id` int NOT NULL AUTO_INCREMENT,
  `connectors_out_setcateg_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`connectors_out_setcateg_id`) USING BTREE,
  UNIQUE KEY `connectors_out_setcateg_name` (`connectors_out_setcateg_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_sets`
--

DROP TABLE IF EXISTS `connectors_out_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_sets` (
  `connector_out_set_id` int NOT NULL AUTO_INCREMENT,
  `connector_out_set_caption` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `connector_out_set_type` int NOT NULL DEFAULT '0',
  `connector_out_set_config` longblob NOT NULL,
  `being_refreshed` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`connector_out_set_id`) USING BTREE,
  UNIQUE KEY `connector_out_set_caption` (`connector_out_set_caption`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_sources`
--

DROP TABLE IF EXISTS `connectors_out_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_sources` (
  `connectors_out_source_id` int NOT NULL AUTO_INCREMENT,
  `connectors_out_sources_connectornum` int NOT NULL DEFAULT '0',
  `connectors_out_source_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `connectors_out_source_comment` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `connectors_out_source_config` longblob NOT NULL,
  PRIMARY KEY (`connectors_out_source_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_out_sources_esgroups`
--

DROP TABLE IF EXISTS `connectors_out_sources_esgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_out_sources_esgroups` (
  `connectors_out_source_esgroup_sourcenum` int NOT NULL DEFAULT '0',
  `connectors_out_source_esgroup_esgroupnum` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`connectors_out_source_esgroup_sourcenum`,`connectors_out_source_esgroup_esgroupnum`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `connectors_sources`
--

DROP TABLE IF EXISTS `connectors_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connectors_sources` (
  `source_id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_connector` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `parameters` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `repository` int NOT NULL DEFAULT '0',
  `timeout` int NOT NULL DEFAULT '5',
  `retry` int NOT NULL DEFAULT '3',
  `ttl` int NOT NULL DEFAULT '1440',
  `opac_allowed` int unsigned NOT NULL DEFAULT '0',
  `rep_upload` int NOT NULL DEFAULT '0',
  `upload_doc_num` int NOT NULL DEFAULT '1',
  `enrichment` int NOT NULL DEFAULT '0',
  `opac_affiliate_search` int NOT NULL DEFAULT '0',
  `opac_selected` int unsigned NOT NULL DEFAULT '0',
  `gestion_selected` int unsigned NOT NULL DEFAULT '0',
  `type_enrichment_allowed` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ico_notice` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `last_sync_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `clean_html` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`source_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_form_objects`
--

DROP TABLE IF EXISTS `contact_form_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_form_objects` (
  `id_object` int unsigned NOT NULL AUTO_INCREMENT,
  `object_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `object_message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `num_contact_form` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_object`) USING BTREE,
  KEY `i_num_contact_form` (`num_contact_form`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contact_forms`
--

DROP TABLE IF EXISTS `contact_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact_forms` (
  `id_contact_form` int unsigned NOT NULL AUTO_INCREMENT,
  `contact_form_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `contact_form_desc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `contact_form_parameters` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `contact_form_recipients` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_contact_form`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_areas`
--

DROP TABLE IF EXISTS `contribution_area_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_areas` (
  `id_area` int unsigned NOT NULL AUTO_INCREMENT,
  `area_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `area_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `area_color` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `area_order` int NOT NULL DEFAULT '0',
  `area_status` int unsigned NOT NULL DEFAULT '1',
  `area_opac_visibility` int NOT NULL DEFAULT '1',
  `area_repo_template_authorities` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `area_repo_template_records` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `area_editing_entity` tinyint NOT NULL DEFAULT '0',
  `area_logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_area`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_clipboard`
--

DROP TABLE IF EXISTS `contribution_area_clipboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_clipboard` (
  `id_clipboard` int NOT NULL AUTO_INCREMENT,
  `datas` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id_clipboard`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_computed_fields`
--

DROP TABLE IF EXISTS `contribution_area_computed_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_computed_fields` (
  `id_computed_fields` int unsigned NOT NULL AUTO_INCREMENT,
  `computed_fields_area_num` int unsigned NOT NULL DEFAULT '0',
  `computed_fields_field_num` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `computed_fields_template` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`id_computed_fields`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_computed_fields_used`
--

DROP TABLE IF EXISTS `contribution_area_computed_fields_used`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_computed_fields_used` (
  `id_computed_fields_used` int unsigned NOT NULL AUTO_INCREMENT,
  `computed_fields_used_origine_field_num` int unsigned NOT NULL DEFAULT '0',
  `computed_fields_used_label` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `computed_fields_used_num` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `computed_fields_used_alias` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_computed_fields_used`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_datastore_g2t`
--

DROP TABLE IF EXISTS `contribution_area_datastore_g2t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_datastore_g2t` (
  `g` mediumint unsigned NOT NULL,
  `t` mediumint unsigned NOT NULL,
  UNIQUE KEY `gt` (`g`,`t`) USING BTREE,
  KEY `tg` (`t`,`g`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_datastore_id2val`
--

DROP TABLE IF EXISTS `contribution_area_datastore_id2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_datastore_id2val` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val_type` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`,`val_type`) USING BTREE,
  KEY `v` (`val`(64)) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_datastore_o2val`
--

DROP TABLE IF EXISTS `contribution_area_datastore_o2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_datastore_o2val` (
  `id` mediumint unsigned NOT NULL,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val_hash` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `vh` (`val_hash`) USING BTREE,
  KEY `v` (`val`(64)) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_datastore_s2val`
--

DROP TABLE IF EXISTS `contribution_area_datastore_s2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_datastore_s2val` (
  `id` mediumint unsigned NOT NULL,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val_hash` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `vh` (`val_hash`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_datastore_setting`
--

DROP TABLE IF EXISTS `contribution_area_datastore_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_datastore_setting` (
  `k` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `k` (`k`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_datastore_triple`
--

DROP TABLE IF EXISTS `contribution_area_datastore_triple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_datastore_triple` (
  `t` mediumint unsigned NOT NULL,
  `s` mediumint unsigned NOT NULL,
  `p` mediumint unsigned NOT NULL,
  `o` mediumint unsigned NOT NULL,
  `o_lang_dt` mediumint unsigned NOT NULL,
  `o_comp` char(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `s_type` tinyint(1) NOT NULL DEFAULT '0',
  `o_type` tinyint(1) NOT NULL DEFAULT '0',
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `t` (`t`) USING BTREE,
  KEY `sp` (`s`,`p`) USING BTREE,
  KEY `os` (`o`,`s`) USING BTREE,
  KEY `po` (`p`,`o`) USING BTREE,
  KEY `misc` (`misc`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_equations`
--

DROP TABLE IF EXISTS `contribution_area_equations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_equations` (
  `contribution_area_equation_id` int unsigned NOT NULL AUTO_INCREMENT,
  `contribution_area_equation_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `contribution_area_equation_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `contribution_area_equation_query` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `contribution_area_equation_human_query` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`contribution_area_equation_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_forms`
--

DROP TABLE IF EXISTS `contribution_area_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_forms` (
  `id_form` int unsigned NOT NULL AUTO_INCREMENT,
  `form_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `form_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `form_parameters` blob NOT NULL,
  `form_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_form`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `contribution_area_status`
--

DROP TABLE IF EXISTS `contribution_area_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution_area_status` (
  `contribution_area_status_id` int unsigned NOT NULL AUTO_INCREMENT,
  `contribution_area_status_gestion_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `contribution_area_status_opac_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `contribution_area_status_class_html` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `contribution_area_status_available_for` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`contribution_area_status_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `coordonnees`
--

DROP TABLE IF EXISTS `coordonnees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coordonnees` (
  `id_contact` int unsigned NOT NULL AUTO_INCREMENT,
  `type_coord` int unsigned NOT NULL DEFAULT '0',
  `num_entite` int unsigned NOT NULL DEFAULT '0',
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `contact` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `adr1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `adr2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cp` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ville` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `etat` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `pays` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `tel1` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `tel2` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `fax` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `commentaires` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`id_contact`) USING BTREE,
  KEY `i_num_entite` (`num_entite`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes`
--

DROP TABLE IF EXISTS `demandes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes` (
  `id_demande` int unsigned NOT NULL AUTO_INCREMENT,
  `num_demandeur` int unsigned NOT NULL DEFAULT '0',
  `theme_demande` int NOT NULL DEFAULT '0',
  `type_demande` int NOT NULL DEFAULT '0',
  `etat_demande` int NOT NULL DEFAULT '0',
  `date_demande` date NOT NULL DEFAULT '1970-01-01',
  `date_prevue` date NOT NULL DEFAULT '1970-01-01',
  `deadline_demande` date NOT NULL DEFAULT '1970-01-01',
  `titre_demande` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `sujet_demande` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `progression` mediumint NOT NULL DEFAULT '0',
  `num_user_cloture` mediumint NOT NULL DEFAULT '0',
  `num_notice` int NOT NULL DEFAULT '0',
  `dmde_read_gestion` int unsigned NOT NULL DEFAULT '0',
  `reponse_finale` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `dmde_read_opac` int unsigned NOT NULL DEFAULT '0',
  `demande_note_num` int unsigned NOT NULL DEFAULT '0',
  `num_linked_notice` mediumint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_demande`) USING BTREE,
  KEY `i_num_demandeur` (`num_demandeur`) USING BTREE,
  KEY `i_date_demande` (`date_demande`) USING BTREE,
  KEY `i_deadline_demande` (`deadline_demande`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_actions`
--

DROP TABLE IF EXISTS `demandes_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_actions` (
  `id_action` int unsigned NOT NULL AUTO_INCREMENT,
  `type_action` int NOT NULL DEFAULT '0',
  `statut_action` int NOT NULL DEFAULT '0',
  `sujet_action` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `detail_action` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `date_action` date NOT NULL DEFAULT '1970-01-01',
  `deadline_action` date NOT NULL DEFAULT '1970-01-01',
  `temps_passe` float DEFAULT NULL,
  `cout` mediumint NOT NULL DEFAULT '0',
  `progression_action` mediumint NOT NULL DEFAULT '0',
  `prive_action` int NOT NULL DEFAULT '0',
  `num_demande` int NOT NULL DEFAULT '0',
  `actions_num_user` int unsigned NOT NULL DEFAULT '0',
  `actions_type_user` tinyint unsigned NOT NULL DEFAULT '0',
  `actions_read_opac` int NOT NULL DEFAULT '0',
  `actions_read_gestion` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_action`) USING BTREE,
  KEY `i_date_action` (`date_action`) USING BTREE,
  KEY `i_deadline_action` (`deadline_action`) USING BTREE,
  KEY `i_num_demande` (`num_demande`) USING BTREE,
  KEY `i_actions_user` (`actions_num_user`,`actions_type_user`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_custom`
--

DROP TABLE IF EXISTS `demandes_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_custom_dates`
--

DROP TABLE IF EXISTS `demandes_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_custom_dates` (
  `demandes_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `demandes_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `demandes_custom_date_type` int DEFAULT NULL,
  `demandes_custom_date_start` int NOT NULL DEFAULT '0',
  `demandes_custom_date_end` int NOT NULL DEFAULT '0',
  `demandes_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`demandes_custom_champ`,`demandes_custom_origine`,`demandes_custom_order`) USING BTREE,
  KEY `demandes_custom_champ` (`demandes_custom_champ`) USING BTREE,
  KEY `demandes_custom_origine` (`demandes_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_custom_lists`
--

DROP TABLE IF EXISTS `demandes_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_custom_lists` (
  `demandes_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `demandes_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `demandes_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `i_demandes_custom_champ` (`demandes_custom_champ`) USING BTREE,
  KEY `i_demandes_champ_list_value` (`demandes_custom_champ`,`demandes_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_custom_values`
--

DROP TABLE IF EXISTS `demandes_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_custom_values` (
  `demandes_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `demandes_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `demandes_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `demandes_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `demandes_custom_integer` int DEFAULT NULL,
  `demandes_custom_date` date DEFAULT NULL,
  `demandes_custom_float` float DEFAULT NULL,
  `demandes_custom_order` int NOT NULL DEFAULT '0',
  KEY `i_demandes_custom_champ` (`demandes_custom_champ`) USING BTREE,
  KEY `i_demandes_custom_origine` (`demandes_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_notes`
--

DROP TABLE IF EXISTS `demandes_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_notes` (
  `id_note` int unsigned NOT NULL AUTO_INCREMENT,
  `prive` int NOT NULL DEFAULT '0',
  `rapport` int NOT NULL DEFAULT '0',
  `contenu` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `date_note` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `num_action` int NOT NULL DEFAULT '0',
  `num_note_parent` int NOT NULL DEFAULT '0',
  `notes_num_user` int unsigned NOT NULL DEFAULT '0',
  `notes_type_user` tinyint unsigned NOT NULL DEFAULT '0',
  `notes_read_gestion` int unsigned NOT NULL DEFAULT '0',
  `notes_read_opac` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_note`) USING BTREE,
  KEY `i_date_note` (`date_note`) USING BTREE,
  KEY `i_num_action` (`num_action`) USING BTREE,
  KEY `i_num_note_parent` (`num_note_parent`) USING BTREE,
  KEY `i_notes_user` (`notes_num_user`,`notes_type_user`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_theme`
--

DROP TABLE IF EXISTS `demandes_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_theme` (
  `id_theme` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_theme` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_theme`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_type`
--

DROP TABLE IF EXISTS `demandes_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_type` (
  `id_type` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `allowed_actions` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demandes_users`
--

DROP TABLE IF EXISTS `demandes_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `demandes_users` (
  `num_user` int NOT NULL DEFAULT '0',
  `num_demande` int NOT NULL DEFAULT '0',
  `date_creation` date NOT NULL DEFAULT '1970-01-01',
  `users_statut` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_user`,`num_demande`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docs_codestat`
--

DROP TABLE IF EXISTS `docs_codestat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docs_codestat` (
  `idcode` smallint unsigned NOT NULL AUTO_INCREMENT,
  `codestat_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `statisdoc_codage_import` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `statisdoc_owner` mediumint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idcode`) USING BTREE,
  KEY `statisdoc_owner` (`statisdoc_owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docs_location`
--

DROP TABLE IF EXISTS `docs_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docs_location` (
  `idlocation` smallint unsigned NOT NULL AUTO_INCREMENT,
  `location_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `locdoc_codage_import` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `locdoc_owner` mediumint unsigned NOT NULL DEFAULT '0',
  `location_pic` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `location_visible_opac` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `adr1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `adr2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cp` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `town` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `state` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `country` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `phone` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `website` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `commentaire` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `transfert_ordre` smallint unsigned NOT NULL DEFAULT '9999',
  `transfert_statut_defaut` smallint unsigned NOT NULL DEFAULT '0',
  `num_infopage` int unsigned NOT NULL DEFAULT '0',
  `css_style` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `surloc_num` int NOT NULL DEFAULT '0',
  `surloc_used` tinyint(1) NOT NULL DEFAULT '0',
  `show_a2z` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idlocation`) USING BTREE,
  KEY `locdoc_owner` (`locdoc_owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docs_section`
--

DROP TABLE IF EXISTS `docs_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docs_section` (
  `idsection` smallint unsigned NOT NULL AUTO_INCREMENT,
  `section_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `section_libelle_opac` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `sdoc_codage_import` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `sdoc_owner` mediumint unsigned NOT NULL DEFAULT '0',
  `section_pic` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `section_visible_opac` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idsection`) USING BTREE,
  KEY `sdoc_owner` (`sdoc_owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docs_statut`
--

DROP TABLE IF EXISTS `docs_statut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docs_statut` (
  `idstatut` smallint unsigned NOT NULL AUTO_INCREMENT,
  `statut_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `statut_libelle_opac` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `pret_flag` tinyint NOT NULL DEFAULT '1',
  `statusdoc_codage_import` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `statusdoc_owner` mediumint unsigned NOT NULL DEFAULT '0',
  `transfert_flag` tinyint unsigned NOT NULL DEFAULT '1',
  `statut_visible_opac` tinyint unsigned NOT NULL DEFAULT '1',
  `statut_allow_resa` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idstatut`) USING BTREE,
  KEY `statusdoc_owner` (`statusdoc_owner`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docs_type`
--

DROP TABLE IF EXISTS `docs_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docs_type` (
  `idtyp_doc` int unsigned NOT NULL AUTO_INCREMENT,
  `tdoc_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `duree_pret` smallint NOT NULL DEFAULT '31',
  `duree_resa` int unsigned NOT NULL DEFAULT '15',
  `tdoc_owner` mediumint unsigned NOT NULL DEFAULT '0',
  `tdoc_codage_import` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `tarif_pret` decimal(16,2) NOT NULL DEFAULT '0.00',
  `short_loan_duration` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`idtyp_doc`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docsloc_section`
--

DROP TABLE IF EXISTS `docsloc_section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docsloc_section` (
  `num_section` int unsigned NOT NULL DEFAULT '0',
  `num_location` int unsigned NOT NULL DEFAULT '0',
  `num_pclass` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_section`,`num_location`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_categories`
--

DROP TABLE IF EXISTS `docwatch_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_categories` (
  `id_category` int unsigned NOT NULL AUTO_INCREMENT,
  `category_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `category_num_parent` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_category`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_datasource_monitoring_website`
--

DROP TABLE IF EXISTS `docwatch_datasource_monitoring_website`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_datasource_monitoring_website` (
  `datasource_monitoring_website_num_datasource` int unsigned NOT NULL DEFAULT '0',
  `datasource_monitoring_website_upload_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `datasource_monitoring_website_content` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `datasource_monitoring_website_content_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`datasource_monitoring_website_num_datasource`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_datasources`
--

DROP TABLE IF EXISTS `docwatch_datasources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_datasources` (
  `id_datasource` int unsigned NOT NULL AUTO_INCREMENT,
  `datasource_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `datasource_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `datasource_ttl` int unsigned NOT NULL DEFAULT '0',
  `datasource_last_date` datetime DEFAULT NULL,
  `datasource_parameters` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `datasource_num_category` int unsigned NOT NULL DEFAULT '0',
  `datasource_default_interesting` int unsigned NOT NULL DEFAULT '0',
  `datasource_clean_html` int unsigned NOT NULL DEFAULT '1',
  `datasource_boolean_expression` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `datasource_num_watch` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_datasource`) USING BTREE,
  KEY `i_docwatch_datasource_title` (`datasource_title`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_items`
--

DROP TABLE IF EXISTS `docwatch_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_items` (
  `id_item` int unsigned NOT NULL AUTO_INCREMENT,
  `item_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `item_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `item_summary` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `item_content` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `item_added_date` datetime DEFAULT NULL,
  `item_publication_date` datetime DEFAULT NULL,
  `item_hash` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `item_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `item_logo_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `item_status` int unsigned NOT NULL DEFAULT '0',
  `item_interesting` int unsigned NOT NULL DEFAULT '0',
  `item_num_article` int unsigned NOT NULL DEFAULT '0',
  `item_num_section` int unsigned NOT NULL DEFAULT '0',
  `item_num_notice` int unsigned NOT NULL DEFAULT '0',
  `item_num_datasource` int unsigned NOT NULL DEFAULT '0',
  `item_num_watch` int unsigned NOT NULL DEFAULT '0',
  `item_index_sew` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `item_index_wew` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_item`) USING BTREE,
  KEY `i_docwatch_item_type` (`item_type`) USING BTREE,
  KEY `i_docwatch_item_title` (`item_title`) USING BTREE,
  KEY `i_docwatch_item_num_article` (`item_num_article`) USING BTREE,
  KEY `i_docwatch_item_num_section` (`item_num_section`) USING BTREE,
  KEY `i_docwatch_item_num_notice` (`item_num_notice`) USING BTREE,
  KEY `i_docwatch_item_num_watch` (`item_num_watch`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_items_descriptors`
--

DROP TABLE IF EXISTS `docwatch_items_descriptors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_items_descriptors` (
  `num_item` int unsigned NOT NULL DEFAULT '0',
  `num_noeud` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_item`,`num_noeud`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_items_tags`
--

DROP TABLE IF EXISTS `docwatch_items_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_items_tags` (
  `num_item` int unsigned NOT NULL DEFAULT '0',
  `num_tag` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_item`,`num_tag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_selectors`
--

DROP TABLE IF EXISTS `docwatch_selectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_selectors` (
  `id_selector` int unsigned NOT NULL AUTO_INCREMENT,
  `selector_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `selector_num_datasource` int unsigned NOT NULL DEFAULT '0',
  `selector_parameters` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_selector`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_tags`
--

DROP TABLE IF EXISTS `docwatch_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_tags` (
  `id_tag` int unsigned NOT NULL AUTO_INCREMENT,
  `tag_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_tag`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `docwatch_watches`
--

DROP TABLE IF EXISTS `docwatch_watches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `docwatch_watches` (
  `id_watch` int unsigned NOT NULL AUTO_INCREMENT,
  `watch_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `watch_owner` int unsigned NOT NULL DEFAULT '0',
  `watch_allowed_users` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `watch_num_category` int unsigned NOT NULL DEFAULT '0',
  `watch_last_date` datetime DEFAULT NULL,
  `watch_ttl` int unsigned NOT NULL DEFAULT '0',
  `watch_desc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `watch_logo` mediumblob NOT NULL,
  `watch_logo_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `watch_record_default_type` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'a',
  `watch_record_default_status` int unsigned NOT NULL DEFAULT '0',
  `watch_record_default_index_lang` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `watch_record_default_lang` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `watch_record_default_is_new` tinyint unsigned NOT NULL DEFAULT '0',
  `watch_article_default_parent` int unsigned NOT NULL DEFAULT '0',
  `watch_article_default_content_type` int unsigned NOT NULL DEFAULT '0',
  `watch_article_default_publication_status` int unsigned NOT NULL DEFAULT '0',
  `watch_section_default_parent` int unsigned NOT NULL DEFAULT '0',
  `watch_section_default_content_type` int unsigned NOT NULL DEFAULT '0',
  `watch_section_default_publication_status` int unsigned NOT NULL DEFAULT '0',
  `watch_rss_link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `watch_rss_lang` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `watch_rss_copyright` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `watch_rss_editor` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `watch_rss_webmaster` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `watch_rss_image_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `watch_rss_image_website` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `watch_boolean_expression` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_watch`) USING BTREE,
  KEY `i_docwatch_watch_title` (`watch_title`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dsi_archive`
--

DROP TABLE IF EXISTS `dsi_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dsi_archive` (
  `num_banette_arc` int unsigned NOT NULL DEFAULT '0',
  `num_notice_arc` int unsigned NOT NULL DEFAULT '0',
  `date_diff_arc` date NOT NULL DEFAULT '1970-01-01',
  PRIMARY KEY (`num_banette_arc`,`num_notice_arc`,`date_diff_arc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `editions_states`
--

DROP TABLE IF EXISTS `editions_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editions_states` (
  `id_editions_state` int unsigned NOT NULL AUTO_INCREMENT,
  `editions_state_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `editions_state_num_classement` int NOT NULL DEFAULT '0',
  `editions_state_used_datasource` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `editions_state_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `editions_state_fieldslist` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `editions_state_fieldsparams` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_editions_state`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr`
--

DROP TABLE IF EXISTS `empr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr` (
  `id_empr` int unsigned NOT NULL AUTO_INCREMENT,
  `empr_cb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `empr_nom` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_prenom` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_adr1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_adr2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_cp` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_ville` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_pays` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_tel1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_tel2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_prof` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_year` int unsigned NOT NULL DEFAULT '0',
  `empr_categ` smallint unsigned NOT NULL DEFAULT '0',
  `empr_codestat` smallint unsigned NOT NULL DEFAULT '0',
  `empr_creation` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `empr_modif` date NOT NULL DEFAULT '1970-01-01',
  `empr_sexe` tinyint unsigned NOT NULL DEFAULT '0',
  `empr_login` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_password_is_encrypted` int NOT NULL DEFAULT '0',
  `empr_digest` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_date_adhesion` date DEFAULT NULL,
  `empr_date_expiration` date DEFAULT NULL,
  `empr_msg` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `empr_lang` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'fr_FR',
  `empr_ldap` tinyint unsigned DEFAULT '0',
  `type_abt` int NOT NULL DEFAULT '0',
  `last_loan_date` date DEFAULT NULL,
  `empr_location` int unsigned NOT NULL DEFAULT '1',
  `date_fin_blocage` date NOT NULL DEFAULT '1970-01-01',
  `total_loans` bigint unsigned NOT NULL DEFAULT '0',
  `empr_statut` bigint unsigned NOT NULL DEFAULT '1',
  `cle_validation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_sms` int unsigned NOT NULL DEFAULT '0',
  `empr_subscription_action` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `empr_pnb_password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `empr_pnb_password_hint` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_empr`) USING BTREE,
  UNIQUE KEY `empr_cb` (`empr_cb`) USING BTREE,
  KEY `empr_nom` (`empr_nom`) USING BTREE,
  KEY `empr_date_adhesion` (`empr_date_adhesion`) USING BTREE,
  KEY `empr_date_expiration` (`empr_date_expiration`) USING BTREE,
  KEY `i_empr_categ` (`empr_categ`) USING BTREE,
  KEY `i_empr_codestat` (`empr_codestat`) USING BTREE,
  KEY `i_empr_location` (`empr_location`) USING BTREE,
  KEY `i_empr_statut` (`empr_statut`) USING BTREE,
  KEY `i_empr_typabt` (`type_abt`) USING BTREE,
  KEY `i_empr_login` (`empr_login`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4835 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_caddie`
--

DROP TABLE IF EXISTS `empr_caddie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_caddie` (
  `idemprcaddie` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `autorisations_all` int NOT NULL DEFAULT '0',
  `empr_caddie_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `acces_rapide` int NOT NULL DEFAULT '0',
  `favorite_color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `creation_user_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `creation_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`idemprcaddie`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_caddie_content`
--

DROP TABLE IF EXISTS `empr_caddie_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_caddie_content` (
  `empr_caddie_id` int unsigned NOT NULL DEFAULT '0',
  `object_id` int unsigned NOT NULL DEFAULT '0',
  `flag` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`empr_caddie_id`,`object_id`) USING BTREE,
  KEY `object_id` (`object_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_caddie_procs`
--

DROP TABLE IF EXISTS `empr_caddie_procs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_caddie_procs` (
  `idproc` smallint unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'SELECT',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `requete` blob NOT NULL,
  `comment` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `autorisations_all` int NOT NULL DEFAULT '0',
  `parameters` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`idproc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_categ`
--

DROP TABLE IF EXISTS `empr_categ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_categ` (
  `id_categ_empr` smallint unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `duree_adhesion` int unsigned DEFAULT '365',
  `tarif_abt` decimal(16,2) NOT NULL DEFAULT '0.00',
  `age_min` int unsigned NOT NULL DEFAULT '0',
  `age_max` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_categ_empr`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_codestat`
--

DROP TABLE IF EXISTS `empr_codestat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_codestat` (
  `idcode` smallint unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'DEFAULT',
  PRIMARY KEY (`idcode`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_custom`
--

DROP TABLE IF EXISTS `empr_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_custom_dates`
--

DROP TABLE IF EXISTS `empr_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_custom_dates` (
  `empr_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `empr_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `empr_custom_date_type` int DEFAULT NULL,
  `empr_custom_date_start` int NOT NULL DEFAULT '0',
  `empr_custom_date_end` int NOT NULL DEFAULT '0',
  `empr_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`empr_custom_champ`,`empr_custom_origine`,`empr_custom_order`) USING BTREE,
  KEY `empr_custom_champ` (`empr_custom_champ`) USING BTREE,
  KEY `empr_custom_origine` (`empr_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_custom_lists`
--

DROP TABLE IF EXISTS `empr_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_custom_lists` (
  `empr_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `empr_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `empr_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `empr_custom_champ` (`empr_custom_champ`) USING BTREE,
  KEY `i_ecl_lv` (`empr_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_custom_values`
--

DROP TABLE IF EXISTS `empr_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_custom_values` (
  `empr_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `empr_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `empr_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `empr_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `empr_custom_integer` int DEFAULT NULL,
  `empr_custom_date` date DEFAULT NULL,
  `empr_custom_float` float DEFAULT NULL,
  `empr_custom_order` int NOT NULL DEFAULT '0',
  KEY `empr_custom_champ` (`empr_custom_champ`) USING BTREE,
  KEY `empr_custom_origine` (`empr_custom_origine`) USING BTREE,
  KEY `i_ecv_st` (`empr_custom_small_text`) USING BTREE,
  KEY `i_ecv_t` (`empr_custom_text`(255)) USING BTREE,
  KEY `i_ecv_i` (`empr_custom_integer`) USING BTREE,
  KEY `i_ecv_d` (`empr_custom_date`) USING BTREE,
  KEY `i_ecv_f` (`empr_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_devices`
--

DROP TABLE IF EXISTS `empr_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_devices` (
  `empr_num` int unsigned NOT NULL DEFAULT '0',
  `device_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`empr_num`,`device_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_grilles`
--

DROP TABLE IF EXISTS `empr_grilles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_grilles` (
  `empr_grille_categ` int NOT NULL DEFAULT '0',
  `empr_grille_location` int NOT NULL DEFAULT '0',
  `empr_grille_format` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`empr_grille_categ`,`empr_grille_location`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_groupe`
--

DROP TABLE IF EXISTS `empr_groupe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_groupe` (
  `empr_id` int unsigned NOT NULL DEFAULT '0',
  `groupe_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`empr_id`,`groupe_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_renewal_form_fields`
--

DROP TABLE IF EXISTS `empr_renewal_form_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_renewal_form_fields` (
  `empr_renewal_form_field_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `empr_renewal_form_field_display` tinyint unsigned NOT NULL DEFAULT '1',
  `empr_renewal_form_field_mandatory` tinyint unsigned NOT NULL DEFAULT '0',
  `empr_renewal_form_field_alterable` tinyint unsigned NOT NULL DEFAULT '1',
  `empr_renewal_form_field_explanation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`empr_renewal_form_field_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_statut`
--

DROP TABLE IF EXISTS `empr_statut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_statut` (
  `idstatut` smallint unsigned NOT NULL AUTO_INCREMENT,
  `statut_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `allow_loan` tinyint NOT NULL DEFAULT '1',
  `allow_loan_hist` tinyint unsigned NOT NULL DEFAULT '0',
  `allow_book` tinyint NOT NULL DEFAULT '1',
  `allow_opac` tinyint NOT NULL DEFAULT '1',
  `allow_dsi` tinyint NOT NULL DEFAULT '1',
  `allow_dsi_priv` tinyint NOT NULL DEFAULT '1',
  `allow_sugg` tinyint NOT NULL DEFAULT '1',
  `allow_dema` tinyint unsigned NOT NULL DEFAULT '1',
  `allow_prol` tinyint NOT NULL DEFAULT '1',
  `allow_avis` tinyint unsigned NOT NULL DEFAULT '1',
  `allow_tag` tinyint unsigned NOT NULL DEFAULT '1',
  `allow_pwd` tinyint unsigned NOT NULL DEFAULT '1',
  `allow_liste_lecture` tinyint unsigned NOT NULL DEFAULT '0',
  `allow_self_checkout` tinyint unsigned NOT NULL DEFAULT '0',
  `allow_self_checkin` tinyint unsigned NOT NULL DEFAULT '0',
  `allow_serialcirc` int unsigned NOT NULL DEFAULT '0',
  `allow_scan_request` int unsigned NOT NULL DEFAULT '0',
  `allow_contribution` int unsigned NOT NULL DEFAULT '0',
  `allow_pnb` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`idstatut`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empr_temp`
--

DROP TABLE IF EXISTS `empr_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empr_temp` (
  `cb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `sess` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `cb` (`cb`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empty_words_calculs`
--

DROP TABLE IF EXISTS `empty_words_calculs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empty_words_calculs` (
  `id_calcul` int unsigned NOT NULL AUTO_INCREMENT,
  `date_calcul` date NOT NULL DEFAULT '1970-01-01',
  `php_empty_words` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `nb_notices_calcul` mediumint unsigned NOT NULL DEFAULT '0',
  `archive_calcul` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_calcul`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entites`
--

DROP TABLE IF EXISTS `entites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entites` (
  `id_entite` int unsigned NOT NULL AUTO_INCREMENT,
  `type_entite` int unsigned NOT NULL DEFAULT '0',
  `num_bibli` int unsigned NOT NULL DEFAULT '0',
  `raison_sociale` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `commentaires` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `siret` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `naf` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `rcs` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `tva` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_cp_client` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_cp_compta` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `site_web` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `logo` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `num_frais` int unsigned NOT NULL DEFAULT '0',
  `num_paiement` int unsigned NOT NULL DEFAULT '0',
  `index_entite` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_entite`) USING BTREE,
  KEY `raison_sociale` (`raison_sociale`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrepots_localisations`
--

DROP TABLE IF EXISTS `entrepots_localisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrepots_localisations` (
  `loc_id` int NOT NULL AUTO_INCREMENT,
  `loc_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `loc_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `loc_visible` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`loc_id`) USING BTREE,
  UNIQUE KEY `loc_code` (`loc_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equations`
--

DROP TABLE IF EXISTS `equations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equations` (
  `id_equation` int unsigned NOT NULL AUTO_INCREMENT,
  `num_classement` int unsigned NOT NULL DEFAULT '1',
  `nom_equation` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment_equation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `requete` blob NOT NULL,
  `proprio_equation` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_equation`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `error_log`
--

DROP TABLE IF EXISTS `error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `error_log` (
  `error_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `error_origin` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `error_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_cache`
--

DROP TABLE IF EXISTS `es_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_cache` (
  `escache_groupname` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `escache_unique_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `escache_value` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`escache_groupname`,`escache_unique_id`,`escache_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_cache_blob`
--

DROP TABLE IF EXISTS `es_cache_blob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_cache_blob` (
  `es_cache_objectref` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_cache_objecttype` int NOT NULL DEFAULT '0',
  `es_cache_objectformat` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_cache_owner` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_cache_creationdate` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `es_cache_expirationdate` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `es_cache_content` mediumblob NOT NULL,
  PRIMARY KEY (`es_cache_objectref`,`es_cache_objecttype`,`es_cache_objectformat`,`es_cache_owner`) USING BTREE,
  KEY `cache_index` (`es_cache_owner`,`es_cache_objectformat`,`es_cache_objecttype`) USING BTREE,
  KEY `i_es_cache_expirationdate` (`es_cache_expirationdate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_cache_int`
--

DROP TABLE IF EXISTS `es_cache_int`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_cache_int` (
  `es_cache_objectref` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_cache_objecttype` int NOT NULL DEFAULT '0',
  `es_cache_objectformat` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_cache_owner` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_cache_creationdate` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `es_cache_expirationdate` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `es_cache_content` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`es_cache_objectref`,`es_cache_objecttype`,`es_cache_objectformat`,`es_cache_owner`) USING BTREE,
  KEY `cache_index` (`es_cache_owner`,`es_cache_objectformat`,`es_cache_objecttype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_converted_cache`
--

DROP TABLE IF EXISTS `es_converted_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_converted_cache` (
  `es_converted_cache_objecttype` int NOT NULL DEFAULT '0',
  `es_converted_cache_objectref` int NOT NULL DEFAULT '0',
  `es_converted_cache_format` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_converted_cache_value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `es_converted_cache_bestbefore` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`es_converted_cache_objecttype`,`es_converted_cache_objectref`,`es_converted_cache_format`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_esgroup_esusers`
--

DROP TABLE IF EXISTS `es_esgroup_esusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_esgroup_esusers` (
  `esgroupuser_groupnum` int NOT NULL DEFAULT '0',
  `esgroupuser_usertype` int NOT NULL DEFAULT '0',
  `esgroupuser_usernum` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`esgroupuser_usernum`,`esgroupuser_groupnum`,`esgroupuser_usertype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_esgroups`
--

DROP TABLE IF EXISTS `es_esgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_esgroups` (
  `esgroup_id` int NOT NULL AUTO_INCREMENT,
  `esgroup_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `esgroup_fullname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `esgroup_pmbusernum` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`esgroup_id`) USING BTREE,
  UNIQUE KEY `esgroup_name` (`esgroup_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_esusers`
--

DROP TABLE IF EXISTS `es_esusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_esusers` (
  `esuser_id` int NOT NULL AUTO_INCREMENT,
  `esuser_username` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `esuser_password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `esuser_fullname` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `esuser_groupnum` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`esuser_id`) USING BTREE,
  UNIQUE KEY `esuser_username` (`esuser_username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_methods`
--

DROP TABLE IF EXISTS `es_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_methods` (
  `id_method` int unsigned NOT NULL AUTO_INCREMENT,
  `groupe` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `available` smallint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_method`) USING BTREE,
  KEY `i_groupe_method_available` (`groupe`(50),`method`(50),`available`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_methods_users`
--

DROP TABLE IF EXISTS `es_methods_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_methods_users` (
  `num_method` int unsigned NOT NULL DEFAULT '0',
  `num_user` int unsigned NOT NULL DEFAULT '0',
  `anonymous` smallint DEFAULT '0',
  PRIMARY KEY (`num_method`,`num_user`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_searchcache`
--

DROP TABLE IF EXISTS `es_searchcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_searchcache` (
  `es_searchcache_searchid` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_searchcache_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `es_searchcache_serializedsearch` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`es_searchcache_searchid`) USING BTREE,
  KEY `i_es_searchcache_date` (`es_searchcache_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `es_searchsessions`
--

DROP TABLE IF EXISTS `es_searchsessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `es_searchsessions` (
  `es_searchsession_id` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_searchsession_searchnum` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_searchsession_searchrealm` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `es_searchsession_pmbuserid` int NOT NULL DEFAULT '-1',
  `es_searchsession_opacemprid` int NOT NULL DEFAULT '-1',
  `es_searchsession_lastseendate` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`es_searchsession_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etagere`
--

DROP TABLE IF EXISTS `etagere`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etagere` (
  `idetagere` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `comment` blob NOT NULL,
  `validite` int unsigned NOT NULL DEFAULT '0',
  `validite_date_deb` date NOT NULL DEFAULT '1970-01-01',
  `validite_date_fin` date NOT NULL DEFAULT '1970-01-01',
  `visible_accueil` int unsigned NOT NULL DEFAULT '1',
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `id_tri` int NOT NULL,
  `thumbnail_url` mediumblob NOT NULL,
  `etagere_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `comment_gestion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`idetagere`) USING BTREE,
  KEY `i_id_tri` (`id_tri`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `etagere_caddie`
--

DROP TABLE IF EXISTS `etagere_caddie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `etagere_caddie` (
  `etagere_id` int unsigned NOT NULL DEFAULT '0',
  `caddie_id` int unsigned NOT NULL DEFAULT '0',
  `etagere_caddie_filters` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`etagere_id`,`caddie_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exemplaires`
--

DROP TABLE IF EXISTS `exemplaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exemplaires` (
  `expl_id` int unsigned NOT NULL AUTO_INCREMENT,
  `expl_cb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `expl_notice` int unsigned NOT NULL DEFAULT '0',
  `expl_bulletin` int unsigned NOT NULL DEFAULT '0',
  `expl_typdoc` int unsigned NOT NULL DEFAULT '0',
  `expl_cote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `expl_section` smallint unsigned NOT NULL DEFAULT '0',
  `expl_statut` smallint unsigned NOT NULL DEFAULT '0',
  `expl_location` smallint unsigned NOT NULL DEFAULT '0',
  `expl_codestat` smallint unsigned NOT NULL DEFAULT '0',
  `expl_date_depot` date NOT NULL DEFAULT '1970-01-01',
  `expl_date_retour` date NOT NULL DEFAULT '1970-01-01',
  `expl_note` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `expl_prix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `expl_owner` mediumint unsigned NOT NULL DEFAULT '0',
  `expl_lastempr` int unsigned NOT NULL DEFAULT '0',
  `last_loan_date` date DEFAULT NULL,
  `create_date` datetime NOT NULL DEFAULT '2005-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type_antivol` int unsigned NOT NULL DEFAULT '0',
  `transfert_location_origine` smallint unsigned NOT NULL DEFAULT '0',
  `transfert_statut_origine` smallint unsigned NOT NULL DEFAULT '0',
  `expl_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `expl_nbparts` int unsigned NOT NULL DEFAULT '1',
  `expl_retloc` smallint unsigned NOT NULL DEFAULT '0',
  `expl_abt_num` int unsigned NOT NULL DEFAULT '0',
  `transfert_section_origine` smallint NOT NULL DEFAULT '0',
  `expl_ref_num` int NOT NULL DEFAULT '0',
  `expl_pnb_flag` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`expl_id`) USING BTREE,
  UNIQUE KEY `expl_cb` (`expl_cb`) USING BTREE,
  KEY `expl_typdoc` (`expl_typdoc`) USING BTREE,
  KEY `expl_cote` (`expl_cote`) USING BTREE,
  KEY `expl_notice` (`expl_notice`) USING BTREE,
  KEY `expl_codestat` (`expl_codestat`) USING BTREE,
  KEY `expl_owner` (`expl_owner`) USING BTREE,
  KEY `expl_bulletin` (`expl_bulletin`) USING BTREE,
  KEY `i_expl_location` (`expl_location`) USING BTREE,
  KEY `i_expl_section` (`expl_section`) USING BTREE,
  KEY `i_expl_statut` (`expl_statut`) USING BTREE,
  KEY `i_expl_lastempr` (`expl_lastempr`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2648 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exemplaires_temp`
--

DROP TABLE IF EXISTS `exemplaires_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exemplaires_temp` (
  `cb` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `sess` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  UNIQUE KEY `cb` (`cb`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `exercices`
--

DROP TABLE IF EXISTS `exercices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exercices` (
  `id_exercice` int unsigned NOT NULL AUTO_INCREMENT,
  `num_entite` int unsigned NOT NULL DEFAULT '0',
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `date_debut` date NOT NULL DEFAULT '2006-01-01',
  `date_fin` date NOT NULL DEFAULT '2006-01-01',
  `statut` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_exercice`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expl_custom`
--

DROP TABLE IF EXISTS `expl_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expl_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expl_custom_dates`
--

DROP TABLE IF EXISTS `expl_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expl_custom_dates` (
  `expl_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `expl_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `expl_custom_date_type` int DEFAULT NULL,
  `expl_custom_date_start` int NOT NULL DEFAULT '0',
  `expl_custom_date_end` int NOT NULL DEFAULT '0',
  `expl_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`expl_custom_champ`,`expl_custom_origine`,`expl_custom_order`) USING BTREE,
  KEY `expl_custom_champ` (`expl_custom_champ`) USING BTREE,
  KEY `expl_custom_origine` (`expl_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expl_custom_lists`
--

DROP TABLE IF EXISTS `expl_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expl_custom_lists` (
  `expl_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `expl_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `expl_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `expl_custom_champ` (`expl_custom_champ`) USING BTREE,
  KEY `i_excl_lv` (`expl_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `expl_custom_values`
--

DROP TABLE IF EXISTS `expl_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expl_custom_values` (
  `expl_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `expl_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `expl_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `expl_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `expl_custom_integer` int DEFAULT NULL,
  `expl_custom_date` date DEFAULT NULL,
  `expl_custom_float` float DEFAULT NULL,
  `expl_custom_order` int NOT NULL DEFAULT '0',
  KEY `expl_custom_champ` (`expl_custom_champ`) USING BTREE,
  KEY `expl_custom_origine` (`expl_custom_origine`) USING BTREE,
  KEY `i_excv_st` (`expl_custom_small_text`) USING BTREE,
  KEY `i_excv_t` (`expl_custom_text`(255)) USING BTREE,
  KEY `i_excv_i` (`expl_custom_integer`) USING BTREE,
  KEY `i_excv_d` (`expl_custom_date`) USING BTREE,
  KEY `i_excv_f` (`expl_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum`
--

DROP TABLE IF EXISTS `explnum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum` (
  `explnum_id` int unsigned NOT NULL AUTO_INCREMENT,
  `explnum_notice` mediumint unsigned NOT NULL DEFAULT '0',
  `explnum_bulletin` int unsigned NOT NULL DEFAULT '0',
  `explnum_nom` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `explnum_mimetype` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `explnum_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `explnum_data` mediumblob,
  `explnum_vignette` mediumblob,
  `explnum_extfichier` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `explnum_nomfichier` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `explnum_statut` int unsigned NOT NULL DEFAULT '0',
  `explnum_index_sew` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `explnum_index_wew` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `explnum_repertoire` int NOT NULL DEFAULT '0',
  `explnum_path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `explnum_docnum_statut` smallint unsigned NOT NULL DEFAULT '1',
  `explnum_signature` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `explnum_create_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `explnum_update_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `explnum_file_size` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`explnum_id`) USING BTREE,
  KEY `explnum_notice` (`explnum_notice`) USING BTREE,
  KEY `explnum_bulletin` (`explnum_bulletin`) USING BTREE,
  KEY `explnum_repertoire` (`explnum_repertoire`) USING BTREE,
  KEY `i_explnum_nomfichier` (`explnum_nomfichier`(30)) USING BTREE,
  KEY `i_e_explnum_signature` (`explnum_signature`) USING BTREE,
  FULLTEXT KEY `i_f_explnumwew` (`explnum_index_wew`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_custom`
--

DROP TABLE IF EXISTS `explnum_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_custom_dates`
--

DROP TABLE IF EXISTS `explnum_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_custom_dates` (
  `explnum_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `explnum_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `explnum_custom_date_type` int DEFAULT NULL,
  `explnum_custom_date_start` int NOT NULL DEFAULT '0',
  `explnum_custom_date_end` int NOT NULL DEFAULT '0',
  `explnum_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`explnum_custom_champ`,`explnum_custom_origine`,`explnum_custom_order`) USING BTREE,
  KEY `explnum_custom_champ` (`explnum_custom_champ`) USING BTREE,
  KEY `explnum_custom_origine` (`explnum_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_custom_lists`
--

DROP TABLE IF EXISTS `explnum_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_custom_lists` (
  `explnum_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `explnum_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `explnum_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `explnum_custom_champ` (`explnum_custom_champ`) USING BTREE,
  KEY `explnum_champ_list_value` (`explnum_custom_champ`,`explnum_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_custom_values`
--

DROP TABLE IF EXISTS `explnum_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_custom_values` (
  `explnum_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `explnum_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `explnum_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `explnum_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `explnum_custom_integer` int DEFAULT NULL,
  `explnum_custom_date` date DEFAULT NULL,
  `explnum_custom_float` float DEFAULT NULL,
  `explnum_custom_order` int NOT NULL DEFAULT '0',
  KEY `explnum_custom_champ` (`explnum_custom_champ`) USING BTREE,
  KEY `i_encv_st` (`explnum_custom_small_text`) USING BTREE,
  KEY `i_encv_t` (`explnum_custom_text`(255)) USING BTREE,
  KEY `i_encv_i` (`explnum_custom_integer`) USING BTREE,
  KEY `i_encv_d` (`explnum_custom_date`) USING BTREE,
  KEY `i_encv_f` (`explnum_custom_float`) USING BTREE,
  KEY `explnum_custom_origine` (`explnum_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_doc`
--

DROP TABLE IF EXISTS `explnum_doc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_doc` (
  `id_explnum_doc` int unsigned NOT NULL AUTO_INCREMENT,
  `explnum_doc_nomfichier` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `explnum_doc_mimetype` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `explnum_doc_data` mediumblob NOT NULL,
  `explnum_doc_extfichier` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `explnum_doc_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_explnum_doc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_doc_actions`
--

DROP TABLE IF EXISTS `explnum_doc_actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_doc_actions` (
  `num_explnum_doc` int NOT NULL DEFAULT '0',
  `num_action` int NOT NULL DEFAULT '0',
  `prive` int NOT NULL DEFAULT '0',
  `rapport` int NOT NULL DEFAULT '0',
  `num_explnum` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_explnum_doc`,`num_action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_doc_sugg`
--

DROP TABLE IF EXISTS `explnum_doc_sugg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_doc_sugg` (
  `num_explnum_doc` int NOT NULL DEFAULT '0',
  `num_suggestion` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_explnum_doc`,`num_suggestion`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_lenders`
--

DROP TABLE IF EXISTS `explnum_lenders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_lenders` (
  `explnum_lender_num_explnum` int NOT NULL DEFAULT '0',
  `explnum_lender_num_lender` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`explnum_lender_num_explnum`,`explnum_lender_num_lender`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_licence`
--

DROP TABLE IF EXISTS `explnum_licence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_licence` (
  `id_explnum_licence` int unsigned NOT NULL AUTO_INCREMENT,
  `explnum_licence_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `explnum_licence_uri` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  PRIMARY KEY (`id_explnum_licence`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_licence_profile_explnums`
--

DROP TABLE IF EXISTS `explnum_licence_profile_explnums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_licence_profile_explnums` (
  `explnum_licence_profile_explnums_explnum_num` int unsigned NOT NULL DEFAULT '0',
  `explnum_licence_profile_explnums_profile_num` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`explnum_licence_profile_explnums_explnum_num`,`explnum_licence_profile_explnums_profile_num`) USING BTREE,
  KEY `i_elpe_explnum_profile_num` (`explnum_licence_profile_explnums_profile_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_licence_profile_rights`
--

DROP TABLE IF EXISTS `explnum_licence_profile_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_licence_profile_rights` (
  `explnum_licence_profile_num` int NOT NULL DEFAULT '0',
  `explnum_licence_right_num` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`explnum_licence_profile_num`,`explnum_licence_right_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_licence_profiles`
--

DROP TABLE IF EXISTS `explnum_licence_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_licence_profiles` (
  `id_explnum_licence_profile` int unsigned NOT NULL AUTO_INCREMENT,
  `explnum_licence_profile_explnum_licence_num` int unsigned NOT NULL DEFAULT '0',
  `explnum_licence_profile_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `explnum_licence_profile_uri` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `explnum_licence_profile_logo_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `explnum_licence_profile_explanation` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `explnum_licence_profile_quotation_rights` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`id_explnum_licence_profile`) USING BTREE,
  KEY `i_elp_explnum_licence_num` (`explnum_licence_profile_explnum_licence_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_licence_rights`
--

DROP TABLE IF EXISTS `explnum_licence_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_licence_rights` (
  `id_explnum_licence_right` int unsigned NOT NULL AUTO_INCREMENT,
  `explnum_licence_right_explnum_licence_num` int unsigned NOT NULL DEFAULT '0',
  `explnum_licence_right_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `explnum_licence_right_type` int DEFAULT '0',
  `explnum_licence_right_logo_url` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `explnum_licence_right_explanation` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`id_explnum_licence_right`) USING BTREE,
  KEY `i_elr_explnum_licence_num` (`explnum_licence_right_explnum_licence_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_location`
--

DROP TABLE IF EXISTS `explnum_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_location` (
  `num_explnum` int NOT NULL DEFAULT '0',
  `num_location` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_explnum`,`num_location`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_segments`
--

DROP TABLE IF EXISTS `explnum_segments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_segments` (
  `explnum_segment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `explnum_segment_explnum_num` int unsigned NOT NULL DEFAULT '0',
  `explnum_segment_speaker_num` int unsigned NOT NULL DEFAULT '0',
  `explnum_segment_start` double NOT NULL DEFAULT '0',
  `explnum_segment_duration` double NOT NULL DEFAULT '0',
  `explnum_segment_end` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`explnum_segment_id`) USING BTREE,
  KEY `i_ensg_explnum_num` (`explnum_segment_explnum_num`) USING BTREE,
  KEY `i_ensg_speaker` (`explnum_segment_speaker_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_speakers`
--

DROP TABLE IF EXISTS `explnum_speakers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_speakers` (
  `explnum_speaker_id` int unsigned NOT NULL AUTO_INCREMENT,
  `explnum_speaker_explnum_num` int unsigned NOT NULL DEFAULT '0',
  `explnum_speaker_speaker_num` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `explnum_speaker_gender` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `explnum_speaker_author` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`explnum_speaker_id`) USING BTREE,
  KEY `i_ensk_explnum_num` (`explnum_speaker_explnum_num`) USING BTREE,
  KEY `i_ensk_author` (`explnum_speaker_author`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `explnum_statut`
--

DROP TABLE IF EXISTS `explnum_statut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `explnum_statut` (
  `id_explnum_statut` smallint unsigned NOT NULL AUTO_INCREMENT,
  `gestion_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `opac_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `class_html` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `explnum_visible_opac` tinyint(1) NOT NULL DEFAULT '1',
  `explnum_visible_opac_abon` tinyint(1) NOT NULL DEFAULT '0',
  `explnum_consult_opac` tinyint(1) NOT NULL DEFAULT '1',
  `explnum_consult_opac_abon` tinyint(1) NOT NULL DEFAULT '0',
  `explnum_download_opac` tinyint(1) NOT NULL DEFAULT '1',
  `explnum_download_opac_abon` tinyint(1) NOT NULL DEFAULT '0',
  `explnum_thumbnail_visible_opac_override` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_explnum_statut`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `external_count`
--

DROP TABLE IF EXISTS `external_count`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `external_count` (
  `rid` bigint unsigned NOT NULL AUTO_INCREMENT,
  `recid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `source_id` int NOT NULL,
  PRIMARY KEY (`rid`) USING BTREE,
  KEY `recid` (`recid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facettes`
--

DROP TABLE IF EXISTS `facettes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facettes` (
  `id_facette` int unsigned NOT NULL AUTO_INCREMENT,
  `facette_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'notices',
  `facette_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `facette_critere` int NOT NULL DEFAULT '0',
  `facette_ss_critere` int NOT NULL DEFAULT '0',
  `facette_nb_result` int NOT NULL DEFAULT '0',
  `facette_visible_gestion` tinyint(1) NOT NULL DEFAULT '0',
  `facette_visible` tinyint(1) NOT NULL DEFAULT '0',
  `facette_type_sort` int NOT NULL DEFAULT '0',
  `facette_order_sort` int NOT NULL DEFAULT '0',
  `facette_datatype_sort` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'alpha',
  `facette_order` int NOT NULL DEFAULT '1',
  `facette_limit_plus` int NOT NULL DEFAULT '0',
  `facette_opac_views_num` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_facette`) USING BTREE,
  KEY `i_facette_visible` (`facette_visible`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facettes_external`
--

DROP TABLE IF EXISTS `facettes_external`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facettes_external` (
  `id_facette` int unsigned NOT NULL AUTO_INCREMENT,
  `facette_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'notices',
  `facette_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `facette_critere` int NOT NULL DEFAULT '0',
  `facette_ss_critere` int NOT NULL DEFAULT '0',
  `facette_nb_result` int NOT NULL DEFAULT '0',
  `facette_visible_gestion` tinyint(1) NOT NULL DEFAULT '0',
  `facette_visible` tinyint(1) NOT NULL DEFAULT '0',
  `facette_type_sort` int NOT NULL DEFAULT '0',
  `facette_order_sort` int NOT NULL DEFAULT '0',
  `facette_datatype_sort` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'alpha',
  `facette_order` int NOT NULL DEFAULT '1',
  `facette_limit_plus` int NOT NULL DEFAULT '0',
  `facette_opac_views_num` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_facette`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_questions`
--

DROP TABLE IF EXISTS `faq_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_questions` (
  `id_faq_question` int unsigned NOT NULL AUTO_INCREMENT,
  `faq_question_num_type` int unsigned NOT NULL DEFAULT '0',
  `faq_question_num_theme` int unsigned NOT NULL DEFAULT '0',
  `faq_question_num_demande` int unsigned NOT NULL DEFAULT '0',
  `faq_question_question` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `faq_question_question_userdate` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `faq_question_question_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `faq_question_answer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `faq_question_answer_userdate` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `faq_question_answer_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `faq_question_statut` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_faq_question`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_questions_categories`
--

DROP TABLE IF EXISTS `faq_questions_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_questions_categories` (
  `num_faq_question` int unsigned NOT NULL DEFAULT '0',
  `num_categ` int unsigned NOT NULL DEFAULT '0',
  `categ_order` int unsigned NOT NULL DEFAULT '0',
  KEY `i_faq_categ` (`num_faq_question`,`num_categ`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_questions_fields_global_index`
--

DROP TABLE IF EXISTS `faq_questions_fields_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_questions_fields_global_index` (
  `id_faq_question` int unsigned NOT NULL DEFAULT '0',
  `code_champ` int unsigned NOT NULL DEFAULT '0',
  `code_ss_champ` int unsigned NOT NULL DEFAULT '0',
  `ordre` int unsigned NOT NULL DEFAULT '0',
  `value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pond` int unsigned NOT NULL DEFAULT '100',
  `lang` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `authority_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_faq_question`,`code_champ`,`code_ss_champ`,`lang`,`ordre`) USING BTREE,
  KEY `i_value` (`value`(300)) USING BTREE,
  KEY `i_code_champ_code_ss_champ` (`code_champ`,`code_ss_champ`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_questions_words_global_index`
--

DROP TABLE IF EXISTS `faq_questions_words_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_questions_words_global_index` (
  `id_faq_question` int unsigned NOT NULL DEFAULT '0',
  `code_champ` int unsigned NOT NULL DEFAULT '0',
  `code_ss_champ` int unsigned NOT NULL DEFAULT '0',
  `num_word` int unsigned NOT NULL DEFAULT '0',
  `pond` int unsigned NOT NULL DEFAULT '100',
  `position` int unsigned NOT NULL DEFAULT '1',
  `field_position` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_faq_question`,`code_champ`,`code_ss_champ`,`num_word`,`position`,`field_position`) USING BTREE,
  KEY `code_champ` (`code_champ`) USING BTREE,
  KEY `i_id_mot` (`num_word`,`id_faq_question`) USING BTREE,
  KEY `i_code_champ_code_ss_champ_num_word` (`code_champ`,`code_ss_champ`,`num_word`) USING BTREE,
  KEY `i_num_word` (`num_word`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_themes`
--

DROP TABLE IF EXISTS `faq_themes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_themes` (
  `id_theme` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_theme` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_theme`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_types`
--

DROP TABLE IF EXISTS `faq_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faq_types` (
  `id_type` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fiche`
--

DROP TABLE IF EXISTS `fiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fiche` (
  `id_fiche` int unsigned NOT NULL AUTO_INCREMENT,
  `infos_global` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `index_infos_global` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_fiche`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frais`
--

DROP TABLE IF EXISTS `frais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frais` (
  `id_frais` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `condition_frais` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `montant` double(12,2) NOT NULL DEFAULT '0.00',
  `num_cp_compta` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_tva_achat` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  `index_libelle` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `add_to_new_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_frais`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_cadres`
--

DROP TABLE IF EXISTS `frbr_cadres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_cadres` (
  `id_cadre` int unsigned NOT NULL AUTO_INCREMENT,
  `cadre_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cadre_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_css_class` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_num_datanode` int unsigned NOT NULL DEFAULT '0',
  `cadre_num_page` int unsigned NOT NULL DEFAULT '0',
  `cadre_visible_in_graph` tinyint unsigned NOT NULL DEFAULT '0',
  `cadre_datanodes_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `cadre_display_empty_template` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_cadre`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_cadres_content`
--

DROP TABLE IF EXISTS `frbr_cadres_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_cadres_content` (
  `id_cadre_content` int unsigned NOT NULL AUTO_INCREMENT,
  `cadre_content_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_content_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cadre_content_num_cadre` int unsigned NOT NULL DEFAULT '0',
  `cadre_content_data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_cadre_content`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_cataloging_categories`
--

DROP TABLE IF EXISTS `frbr_cataloging_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_cataloging_categories` (
  `id_cataloging_category` int unsigned NOT NULL AUTO_INCREMENT,
  `cataloging_category_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cataloging_category_num_parent` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cataloging_category`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_cataloging_datanodes`
--

DROP TABLE IF EXISTS `frbr_cataloging_datanodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_cataloging_datanodes` (
  `id_cataloging_datanode` int unsigned NOT NULL AUTO_INCREMENT,
  `cataloging_datanode_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cataloging_datanode_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `cataloging_datanode_owner` int unsigned NOT NULL DEFAULT '0',
  `cataloging_datanode_allowed_users` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cataloging_datanode_num_category` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_cataloging_datanode`) USING BTREE,
  KEY `i_cataloging_datanode_title` (`cataloging_datanode_title`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_cataloging_items`
--

DROP TABLE IF EXISTS `frbr_cataloging_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_cataloging_items` (
  `num_cataloging_item` int unsigned NOT NULL,
  `type_cataloging_item` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `cataloging_item_num_user` int unsigned NOT NULL DEFAULT '0',
  `cataloging_item_added_date` datetime DEFAULT NULL,
  `cataloging_item_num_datanode` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_cataloging_item`,`type_cataloging_item`,`cataloging_item_num_datanode`) USING BTREE,
  KEY `i_cataloging_item_num_datanode` (`cataloging_item_num_datanode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_datanodes`
--

DROP TABLE IF EXISTS `frbr_datanodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_datanodes` (
  `id_datanode` int unsigned NOT NULL AUTO_INCREMENT,
  `datanode_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `datanode_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `datanode_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `datanode_num_page` int unsigned NOT NULL DEFAULT '0',
  `datanode_num_parent` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_datanode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_datanodes_content`
--

DROP TABLE IF EXISTS `frbr_datanodes_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_datanodes_content` (
  `id_datanode_content` int unsigned NOT NULL AUTO_INCREMENT,
  `datanode_content_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `datanode_content_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `datanode_content_num_datanode` int unsigned NOT NULL DEFAULT '0',
  `datanode_content_data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_datanode_content`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_managed_entities`
--

DROP TABLE IF EXISTS `frbr_managed_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_managed_entities` (
  `managed_entity_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `managed_entity_box` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`managed_entity_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_pages`
--

DROP TABLE IF EXISTS `frbr_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_pages` (
  `id_page` int unsigned NOT NULL AUTO_INCREMENT,
  `page_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `page_entity` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_parameters` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `page_opac_views` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_order` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_page`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_pages_content`
--

DROP TABLE IF EXISTS `frbr_pages_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_pages_content` (
  `id_page_content` int unsigned NOT NULL AUTO_INCREMENT,
  `page_content_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_content_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `page_content_num_page` int unsigned NOT NULL DEFAULT '0',
  `page_content_data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_page_content`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `frbr_place`
--

DROP TABLE IF EXISTS `frbr_place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frbr_place` (
  `place_num_page` int unsigned NOT NULL DEFAULT '0',
  `place_num_cadre` int unsigned NOT NULL DEFAULT '0',
  `place_cadre_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `place_visibility` int NOT NULL DEFAULT '0',
  `place_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`place_num_page`,`place_num_cadre`,`place_cadre_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gestfic0_custom`
--

DROP TABLE IF EXISTS `gestfic0_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestfic0_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gestfic0_custom_lists`
--

DROP TABLE IF EXISTS `gestfic0_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestfic0_custom_lists` (
  `gestfic0_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `gestfic0_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `gestfic0_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `gestfic0_custom_champ` (`gestfic0_custom_champ`) USING BTREE,
  KEY `gestfic0_champ_list_value` (`gestfic0_custom_champ`,`gestfic0_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gestfic0_custom_values`
--

DROP TABLE IF EXISTS `gestfic0_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gestfic0_custom_values` (
  `gestfic0_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `gestfic0_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `gestfic0_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `gestfic0_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `gestfic0_custom_integer` int DEFAULT NULL,
  `gestfic0_custom_date` date DEFAULT NULL,
  `gestfic0_custom_float` float DEFAULT NULL,
  `gestfic0_custom_order` int NOT NULL DEFAULT '0',
  KEY `gestfic0_custom_champ` (`gestfic0_custom_champ`) USING BTREE,
  KEY `gestfic0_custom_origine` (`gestfic0_custom_origine`) USING BTREE,
  KEY `i_gcv_st` (`gestfic0_custom_small_text`) USING BTREE,
  KEY `i_gcv_t` (`gestfic0_custom_text`(255)) USING BTREE,
  KEY `i_gcv_i` (`gestfic0_custom_integer`) USING BTREE,
  KEY `i_gcv_d` (`gestfic0_custom_date`) USING BTREE,
  KEY `i_gcv_f` (`gestfic0_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grids_generic`
--

DROP TABLE IF EXISTS `grids_generic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grids_generic` (
  `grid_generic_type` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `grid_generic_filter` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `grid_generic_data` mediumblob NOT NULL,
  PRIMARY KEY (`grid_generic_type`,`grid_generic_filter`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `grilles`
--

DROP TABLE IF EXISTS `grilles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grilles` (
  `grille_typdoc` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'a',
  `grille_niveau_biblio` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'm',
  `grille_localisation` mediumint NOT NULL DEFAULT '0',
  `descr_format` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`grille_typdoc`,`grille_niveau_biblio`,`grille_localisation`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupe`
--

DROP TABLE IF EXISTS `groupe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groupe` (
  `id_groupe` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle_groupe` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `resp_groupe` int unsigned DEFAULT '0',
  `lettre_rappel` int unsigned NOT NULL DEFAULT '0',
  `mail_rappel` int unsigned NOT NULL DEFAULT '0',
  `lettre_rappel_show_nomgroup` int unsigned NOT NULL DEFAULT '0',
  `comment_gestion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment_opac` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `lettre_resa` int unsigned NOT NULL DEFAULT '0',
  `mail_resa` int unsigned NOT NULL DEFAULT '0',
  `lettre_resa_show_nomgroup` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_groupe`) USING BTREE,
  UNIQUE KEY `libelle_groupe` (`libelle_groupe`) USING BTREE,
  KEY `i_resp_groupe` (`resp_groupe`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupexpl`
--

DROP TABLE IF EXISTS `groupexpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groupexpl` (
  `id_groupexpl` int unsigned NOT NULL AUTO_INCREMENT,
  `groupexpl_resp_expl_num` int unsigned NOT NULL DEFAULT '0',
  `groupexpl_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `groupexpl_comment` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `groupexpl_location` int unsigned NOT NULL DEFAULT '0',
  `groupexpl_statut_resp` int unsigned NOT NULL DEFAULT '0',
  `groupexpl_statut_others` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_groupexpl`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupexpl_expl`
--

DROP TABLE IF EXISTS `groupexpl_expl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groupexpl_expl` (
  `groupexpl_num` int unsigned NOT NULL DEFAULT '0',
  `groupexpl_expl_num` int unsigned NOT NULL DEFAULT '0',
  `groupexpl_checked` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupexpl_num`,`groupexpl_expl_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `harvest_field`
--

DROP TABLE IF EXISTS `harvest_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `harvest_field` (
  `id_harvest_field` int unsigned NOT NULL AUTO_INCREMENT,
  `num_harvest_profil` int unsigned NOT NULL DEFAULT '0',
  `harvest_field_xml_id` int unsigned NOT NULL DEFAULT '0',
  `harvest_field_first_flag` int unsigned NOT NULL DEFAULT '0',
  `harvest_field_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_harvest_field`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `harvest_profil`
--

DROP TABLE IF EXISTS `harvest_profil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `harvest_profil` (
  `id_harvest_profil` int unsigned NOT NULL AUTO_INCREMENT,
  `harvest_profil_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_harvest_profil`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `harvest_profil_import`
--

DROP TABLE IF EXISTS `harvest_profil_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `harvest_profil_import` (
  `id_harvest_profil_import` int unsigned NOT NULL AUTO_INCREMENT,
  `harvest_profil_import_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_harvest_profil_import`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `harvest_profil_import_field`
--

DROP TABLE IF EXISTS `harvest_profil_import_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `harvest_profil_import_field` (
  `num_harvest_profil_import` int unsigned NOT NULL DEFAULT '0',
  `harvest_profil_import_field_xml_id` int unsigned NOT NULL DEFAULT '0',
  `harvest_profil_import_field_flag` int unsigned NOT NULL DEFAULT '0',
  `harvest_profil_import_field_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_harvest_profil_import`,`harvest_profil_import_field_xml_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `harvest_search_field`
--

DROP TABLE IF EXISTS `harvest_search_field`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `harvest_search_field` (
  `num_harvest_profil` int unsigned NOT NULL DEFAULT '0',
  `num_source` int unsigned NOT NULL DEFAULT '0',
  `num_field` int unsigned NOT NULL DEFAULT '0',
  `num_ss_field` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_harvest_profil`,`num_source`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `harvest_src`
--

DROP TABLE IF EXISTS `harvest_src`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `harvest_src` (
  `id_harvest_src` int unsigned NOT NULL AUTO_INCREMENT,
  `num_harvest_field` int unsigned NOT NULL DEFAULT '0',
  `num_source` int unsigned NOT NULL DEFAULT '0',
  `harvest_src_unimacfield` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `harvest_src_unimacsubfield` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `harvest_src_pmb_unimacfield` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `harvest_src_pmb_unimacsubfield` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `harvest_src_prec_flag` int unsigned NOT NULL DEFAULT '0',
  `harvest_src_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_harvest_src`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `import_marc`
--

DROP TABLE IF EXISTS `import_marc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `import_marc` (
  `id_import` bigint unsigned NOT NULL AUTO_INCREMENT,
  `notice` longblob NOT NULL,
  `origine` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '',
  `no_notice` int unsigned DEFAULT '0',
  `encoding` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_import`) USING BTREE,
  KEY `i_nonot_orig` (`no_notice`,`origine`) USING BTREE,
  KEY `i_origine` (`origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `index_concept`
--

DROP TABLE IF EXISTS `index_concept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `index_concept` (
  `num_object` int unsigned NOT NULL,
  `type_object` int unsigned NOT NULL,
  `num_concept` int unsigned NOT NULL,
  `order_concept` int unsigned NOT NULL DEFAULT '0',
  `comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `comment_visible_opac` tinyint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_object`,`type_object`,`num_concept`) USING BTREE,
  KEY `i_num_concept_type_object` (`num_concept`,`type_object`) USING BTREE,
  KEY `i_type_object_num_object` (`type_object`,`num_object`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indexation_stack`
--

DROP TABLE IF EXISTS `indexation_stack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indexation_stack` (
  `indexation_stack_entity_id` int unsigned NOT NULL DEFAULT '0',
  `indexation_stack_entity_type` int unsigned NOT NULL DEFAULT '0',
  `indexation_stack_datatype` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `indexation_stack_timestamp` bigint NOT NULL DEFAULT '0',
  `indexation_stack_parent_id` int unsigned NOT NULL DEFAULT '0',
  `indexation_stack_parent_type` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexation_stack_entity_id`,`indexation_stack_entity_type`,`indexation_stack_datatype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indexint`
--

DROP TABLE IF EXISTS `indexint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indexint` (
  `indexint_id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `indexint_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `indexint_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `index_indexint` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `num_pclass` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`indexint_id`) USING BTREE,
  UNIQUE KEY `indexint_name` (`indexint_name`,`num_pclass`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=353 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indexint_custom`
--

DROP TABLE IF EXISTS `indexint_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indexint_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indexint_custom_dates`
--

DROP TABLE IF EXISTS `indexint_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indexint_custom_dates` (
  `indexint_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `indexint_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `indexint_custom_date_type` int DEFAULT NULL,
  `indexint_custom_date_start` int NOT NULL DEFAULT '0',
  `indexint_custom_date_end` int NOT NULL DEFAULT '0',
  `indexint_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`indexint_custom_champ`,`indexint_custom_origine`,`indexint_custom_order`) USING BTREE,
  KEY `indexint_custom_champ` (`indexint_custom_champ`) USING BTREE,
  KEY `indexint_custom_origine` (`indexint_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indexint_custom_lists`
--

DROP TABLE IF EXISTS `indexint_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indexint_custom_lists` (
  `indexint_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `indexint_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `indexint_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`indexint_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`indexint_custom_champ`,`indexint_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indexint_custom_values`
--

DROP TABLE IF EXISTS `indexint_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indexint_custom_values` (
  `indexint_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `indexint_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `indexint_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `indexint_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `indexint_custom_integer` int DEFAULT NULL,
  `indexint_custom_date` date DEFAULT NULL,
  `indexint_custom_float` float DEFAULT NULL,
  `indexint_custom_order` int NOT NULL DEFAULT '0',
  KEY `editorial_custom_champ` (`indexint_custom_champ`) USING BTREE,
  KEY `editorial_custom_origine` (`indexint_custom_origine`) USING BTREE,
  KEY `i_icv_st` (`indexint_custom_small_text`) USING BTREE,
  KEY `i_icv_t` (`indexint_custom_text`(255)) USING BTREE,
  KEY `i_icv_i` (`indexint_custom_integer`) USING BTREE,
  KEY `i_icv_d` (`indexint_custom_date`) USING BTREE,
  KEY `i_icv_f` (`indexint_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `infopages`
--

DROP TABLE IF EXISTS `infopages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `infopages` (
  `id_infopage` int unsigned NOT NULL AUTO_INCREMENT,
  `content_infopage` longblob NOT NULL,
  `title_infopage` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `valid_infopage` tinyint(1) NOT NULL DEFAULT '1',
  `restrict_infopage` int NOT NULL DEFAULT '0',
  `infopage_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_infopage`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lenders`
--

DROP TABLE IF EXISTS `lenders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lenders` (
  `idlender` smallint unsigned NOT NULL AUTO_INCREMENT,
  `lender_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idlender`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liens_actes`
--

DROP TABLE IF EXISTS `liens_actes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liens_actes` (
  `num_acte` int unsigned NOT NULL DEFAULT '0',
  `num_acte_lie` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_acte`,`num_acte_lie`) USING BTREE,
  KEY `i_num_acte` (`num_acte`) USING BTREE,
  KEY `i_num_acte_lie` (`num_acte_lie`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lignes_actes`
--

DROP TABLE IF EXISTS `lignes_actes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lignes_actes` (
  `id_ligne` int unsigned NOT NULL AUTO_INCREMENT,
  `type_ligne` int unsigned NOT NULL DEFAULT '0',
  `num_acte` int unsigned NOT NULL DEFAULT '0',
  `lig_ref` int unsigned NOT NULL DEFAULT '0',
  `num_acquisition` int unsigned NOT NULL DEFAULT '0',
  `num_rubrique` int unsigned NOT NULL DEFAULT '0',
  `num_produit` int unsigned NOT NULL DEFAULT '0',
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `libelle` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `prix` double(12,2) NOT NULL DEFAULT '0.00',
  `tva` float(8,2) unsigned NOT NULL DEFAULT '0.00',
  `nb` int unsigned NOT NULL DEFAULT '1',
  `date_ech` date NOT NULL DEFAULT '1970-01-01',
  `date_cre` date NOT NULL DEFAULT '1970-01-01',
  `statut` int unsigned NOT NULL DEFAULT '0',
  `remise` float(8,2) NOT NULL DEFAULT '0.00',
  `index_ligne` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ligne_ordre` smallint unsigned NOT NULL DEFAULT '0',
  `debit_tva` smallint unsigned NOT NULL DEFAULT '0',
  `commentaires_gestion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `commentaires_opac` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_ligne`) USING BTREE,
  KEY `num_acte` (`num_acte`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lignes_actes_applicants`
--

DROP TABLE IF EXISTS `lignes_actes_applicants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lignes_actes_applicants` (
  `ligne_acte_num` int NOT NULL DEFAULT '0',
  `empr_num` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ligne_acte_num`,`empr_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lignes_actes_relances`
--

DROP TABLE IF EXISTS `lignes_actes_relances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lignes_actes_relances` (
  `num_ligne` int unsigned NOT NULL,
  `date_relance` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `type_ligne` int unsigned NOT NULL DEFAULT '0',
  `num_acte` int unsigned NOT NULL DEFAULT '0',
  `lig_ref` int unsigned NOT NULL DEFAULT '0',
  `num_acquisition` int unsigned NOT NULL DEFAULT '0',
  `num_rubrique` int unsigned NOT NULL DEFAULT '0',
  `num_produit` int unsigned NOT NULL DEFAULT '0',
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `libelle` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `prix` float(8,2) NOT NULL DEFAULT '0.00',
  `tva` float(8,2) unsigned NOT NULL DEFAULT '0.00',
  `nb` int unsigned NOT NULL DEFAULT '1',
  `date_ech` date NOT NULL DEFAULT '1970-01-01',
  `date_cre` date NOT NULL DEFAULT '1970-01-01',
  `statut` int unsigned NOT NULL DEFAULT '1',
  `remise` float(8,2) NOT NULL DEFAULT '0.00',
  `index_ligne` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ligne_ordre` smallint unsigned NOT NULL DEFAULT '0',
  `debit_tva` smallint unsigned NOT NULL DEFAULT '0',
  `commentaires_gestion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `commentaires_opac` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`num_ligne`,`date_relance`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lignes_actes_statuts`
--

DROP TABLE IF EXISTS `lignes_actes_statuts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lignes_actes_statuts` (
  `id_statut` int NOT NULL AUTO_INCREMENT,
  `libelle` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `relance` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_statut`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `linked_mots`
--

DROP TABLE IF EXISTS `linked_mots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `linked_mots` (
  `num_mot` mediumint unsigned NOT NULL DEFAULT '0',
  `num_linked_mot` mediumint unsigned NOT NULL DEFAULT '0',
  `type_lien` tinyint(1) NOT NULL DEFAULT '1',
  `ponderation` float NOT NULL DEFAULT '1',
  PRIMARY KEY (`num_mot`,`num_linked_mot`,`type_lien`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lists`
--

DROP TABLE IF EXISTS `lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lists` (
  `id_list` int unsigned NOT NULL AUTO_INCREMENT,
  `list_num_user` int unsigned NOT NULL DEFAULT '0',
  `list_objects_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `list_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `list_selected_columns` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `list_filters` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `list_applied_group` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `list_applied_sort` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `list_pager` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `list_selected_filters` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `list_settings` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `list_autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `list_default_selected` int unsigned NOT NULL DEFAULT '0',
  `list_order` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_list`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locked_entities`
--

DROP TABLE IF EXISTS `locked_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locked_entities` (
  `id_entity` int unsigned NOT NULL,
  `type` int unsigned NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `parent_id` int unsigned NOT NULL DEFAULT '0',
  `parent_type` int unsigned NOT NULL DEFAULT '0',
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `empr_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_entity`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_expl_retard`
--

DROP TABLE IF EXISTS `log_expl_retard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_expl_retard` (
  `id_log` int unsigned NOT NULL AUTO_INCREMENT,
  `date_log` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `expl_id` int NOT NULL DEFAULT '0',
  `expl_cb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `date_pret` date NOT NULL DEFAULT '1970-01-01',
  `date_retour` date NOT NULL DEFAULT '1970-01-01',
  `amende` decimal(16,2) NOT NULL DEFAULT '0.00',
  `num_log_retard` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_log`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_retard`
--

DROP TABLE IF EXISTS `log_retard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_retard` (
  `id_log` int unsigned NOT NULL AUTO_INCREMENT,
  `date_log` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `niveau_reel` int NOT NULL DEFAULT '0',
  `niveau_suppose` int NOT NULL DEFAULT '0',
  `amende_totale` decimal(16,2) NOT NULL DEFAULT '0.00',
  `frais` decimal(16,2) NOT NULL DEFAULT '0.00',
  `idempr` int NOT NULL DEFAULT '0',
  `log_printed` int unsigned NOT NULL DEFAULT '0',
  `log_mail` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_log`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logopac`
--

DROP TABLE IF EXISTS `logopac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logopac` (
  `id_log` int unsigned NOT NULL AUTO_INCREMENT,
  `date_log` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `url_demandee` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `url_referente` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `get_log` blob NOT NULL,
  `post_log` blob NOT NULL,
  `num_session` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `server_log` blob NOT NULL,
  `empr_carac` blob NOT NULL,
  `empr_doc` blob NOT NULL,
  `empr_expl` mediumblob NOT NULL,
  `nb_result` blob NOT NULL,
  `gen_stat` blob NOT NULL,
  PRIMARY KEY (`id_log`) USING BTREE,
  KEY `lopac_date_log` (`date_log`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mails_waiting`
--

DROP TABLE IF EXISTS `mails_waiting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mails_waiting` (
  `id_mail` int unsigned NOT NULL AUTO_INCREMENT,
  `mail_waiting_to_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_to_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_content` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_waiting_from_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_from_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_headers` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_waiting_copy_cc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_copy_bcc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_do_nl2br` int unsigned NOT NULL DEFAULT '0',
  `mail_waiting_attachments` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mail_waiting_reply_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_reply_mail` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mail_waiting_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`id_mail`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mailtpl`
--

DROP TABLE IF EXISTS `mailtpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mailtpl` (
  `id_mailtpl` int unsigned NOT NULL AUTO_INCREMENT,
  `mailtpl_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mailtpl_objet` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `mailtpl_tpl` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `mailtpl_users` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_mailtpl`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_echelles`
--

DROP TABLE IF EXISTS `map_echelles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `map_echelles` (
  `map_echelle_id` int unsigned NOT NULL AUTO_INCREMENT,
  `map_echelle_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`map_echelle_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_emprises`
--

DROP TABLE IF EXISTS `map_emprises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `map_emprises` (
  `map_emprise_id` int unsigned NOT NULL AUTO_INCREMENT,
  `map_emprise_type` int unsigned NOT NULL DEFAULT '0',
  `map_emprise_obj_num` int unsigned NOT NULL DEFAULT '0',
  `map_emprise_data` geometry NOT NULL,
  `map_emprise_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`map_emprise_id`) USING BTREE,
  KEY `i_map_emprise_obj_num` (`map_emprise_obj_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_hold_areas`
--

DROP TABLE IF EXISTS `map_hold_areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `map_hold_areas` (
  `id_obj` int unsigned NOT NULL DEFAULT '0',
  `type_obj` int unsigned NOT NULL DEFAULT '0',
  `area` double DEFAULT NULL,
  `bbox_area` double DEFAULT NULL,
  `center` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  PRIMARY KEY (`id_obj`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_projections`
--

DROP TABLE IF EXISTS `map_projections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `map_projections` (
  `map_projection_id` int unsigned NOT NULL AUTO_INCREMENT,
  `map_projection_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`map_projection_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `map_refs`
--

DROP TABLE IF EXISTS `map_refs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `map_refs` (
  `map_ref_id` int unsigned NOT NULL AUTO_INCREMENT,
  `map_ref_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`map_ref_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `module_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  `module_destination_link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`module_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mots`
--

DROP TABLE IF EXISTS `mots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mots` (
  `id_mot` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `mot` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_mot`) USING BTREE,
  UNIQUE KEY `mot` (`mot`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `noeuds`
--

DROP TABLE IF EXISTS `noeuds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `noeuds` (
  `id_noeud` int unsigned NOT NULL AUTO_INCREMENT,
  `autorite` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_parent` int unsigned NOT NULL DEFAULT '0',
  `num_renvoi_voir` int unsigned NOT NULL DEFAULT '0',
  `visible` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '1',
  `num_thesaurus` int unsigned NOT NULL DEFAULT '0',
  `path` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `authority_import_denied` int unsigned NOT NULL DEFAULT '0',
  `not_use_in_indexation` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_noeud`) USING BTREE,
  KEY `num_parent` (`num_parent`) USING BTREE,
  KEY `num_thesaurus` (`num_thesaurus`) USING BTREE,
  KEY `autorite` (`autorite`) USING BTREE,
  KEY `key_path` (`path`(333)) USING BTREE,
  KEY `i_num_renvoi_voir` (`num_renvoi_voir`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_children_records`
--

DROP TABLE IF EXISTS `nomenclature_children_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_children_records` (
  `child_record_num_record` int unsigned NOT NULL DEFAULT '0',
  `child_record_num_formation` int unsigned NOT NULL DEFAULT '0',
  `child_record_num_type` int unsigned NOT NULL DEFAULT '0',
  `child_record_num_musicstand` int unsigned NOT NULL DEFAULT '0',
  `child_record_num_instrument` int unsigned NOT NULL DEFAULT '0',
  `child_record_effective` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  `child_record_order` int unsigned NOT NULL DEFAULT '0',
  `child_record_other` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `child_record_num_voice` int unsigned NOT NULL DEFAULT '0',
  `child_record_num_workshop` int unsigned NOT NULL DEFAULT '0',
  `child_record_num_nomenclature` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`child_record_num_record`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_exotic_instruments`
--

DROP TABLE IF EXISTS `nomenclature_exotic_instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_exotic_instruments` (
  `id_exotic_instrument` int unsigned NOT NULL AUTO_INCREMENT,
  `exotic_instrument_num_nomenclature` int unsigned NOT NULL DEFAULT '0',
  `exotic_instrument_num_instrument` int unsigned NOT NULL DEFAULT '0',
  `exotic_instrument_number` int unsigned NOT NULL DEFAULT '0',
  `exotic_instrument_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_exotic_instrument`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_exotic_other_instruments`
--

DROP TABLE IF EXISTS `nomenclature_exotic_other_instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_exotic_other_instruments` (
  `id_exotic_other_instrument` int unsigned NOT NULL AUTO_INCREMENT,
  `exotic_other_instrument_num_exotic_instrument` int unsigned NOT NULL DEFAULT '0',
  `exotic_other_instrument_num_instrument` int unsigned NOT NULL DEFAULT '0',
  `exotic_other_instrument_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_exotic_other_instrument`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_families`
--

DROP TABLE IF EXISTS `nomenclature_families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_families` (
  `id_family` int unsigned NOT NULL AUTO_INCREMENT,
  `family_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `family_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_family`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_formations`
--

DROP TABLE IF EXISTS `nomenclature_formations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_formations` (
  `id_formation` int unsigned NOT NULL AUTO_INCREMENT,
  `formation_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `formation_nature` int unsigned NOT NULL DEFAULT '0',
  `formation_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_formation`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_instruments`
--

DROP TABLE IF EXISTS `nomenclature_instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_instruments` (
  `id_instrument` int unsigned NOT NULL AUTO_INCREMENT,
  `instrument_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `instrument_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `instrument_musicstand_num` int unsigned NOT NULL DEFAULT '0',
  `instrument_standard` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_instrument`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_musicstands`
--

DROP TABLE IF EXISTS `nomenclature_musicstands`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_musicstands` (
  `id_musicstand` int unsigned NOT NULL AUTO_INCREMENT,
  `musicstand_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `musicstand_famille_num` int unsigned NOT NULL DEFAULT '0',
  `musicstand_division` int unsigned NOT NULL DEFAULT '0',
  `musicstand_order` int unsigned NOT NULL DEFAULT '0',
  `musicstand_workshop` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_musicstand`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_notices_nomenclatures`
--

DROP TABLE IF EXISTS `nomenclature_notices_nomenclatures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_notices_nomenclatures` (
  `id_notice_nomenclature` int unsigned NOT NULL AUTO_INCREMENT,
  `notice_nomenclature_num_notice` int unsigned NOT NULL DEFAULT '0',
  `notice_nomenclature_num_formation` int unsigned NOT NULL DEFAULT '0',
  `notice_nomenclature_num_type` int unsigned NOT NULL DEFAULT '0',
  `notice_nomenclature_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `notice_nomenclature_abbreviation` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `notice_nomenclature_notes` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `notice_nomenclature_families_notes` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `notice_nomenclature_exotic_instruments_note` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `notice_nomenclature_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_notice_nomenclature`) USING BTREE,
  KEY `i_notice_nomenclature_num_notice` (`notice_nomenclature_num_notice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_types`
--

DROP TABLE IF EXISTS `nomenclature_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_types` (
  `id_type` int unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `type_formation_num` int unsigned NOT NULL DEFAULT '0',
  `type_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_voices`
--

DROP TABLE IF EXISTS `nomenclature_voices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_voices` (
  `id_voice` int unsigned NOT NULL AUTO_INCREMENT,
  `voice_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `voice_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `voice_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_voice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_workshops`
--

DROP TABLE IF EXISTS `nomenclature_workshops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_workshops` (
  `id_workshop` int unsigned NOT NULL AUTO_INCREMENT,
  `workshop_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `workshop_num_nomenclature` int unsigned NOT NULL DEFAULT '0',
  `workshop_order` int unsigned NOT NULL DEFAULT '0',
  `workshop_defined` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_workshop`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nomenclature_workshops_instruments`
--

DROP TABLE IF EXISTS `nomenclature_workshops_instruments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nomenclature_workshops_instruments` (
  `id_workshop_instrument` int unsigned NOT NULL AUTO_INCREMENT,
  `workshop_instrument_num_workshop` int unsigned NOT NULL DEFAULT '0',
  `workshop_instrument_num_instrument` int unsigned NOT NULL DEFAULT '0',
  `workshop_instrument_number` int unsigned NOT NULL DEFAULT '0',
  `workshop_instrument_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_workshop_instrument`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice_onglet`
--

DROP TABLE IF EXISTS `notice_onglet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_onglet` (
  `id_onglet` int unsigned NOT NULL AUTO_INCREMENT,
  `onglet_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_onglet`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice_statut`
--

DROP TABLE IF EXISTS `notice_statut`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_statut` (
  `id_notice_statut` smallint unsigned NOT NULL AUTO_INCREMENT,
  `gestion_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `opac_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `notice_visible_opac` tinyint(1) NOT NULL DEFAULT '1',
  `notice_visible_gestion` tinyint(1) NOT NULL DEFAULT '1',
  `expl_visible_opac` tinyint(1) NOT NULL DEFAULT '1',
  `class_html` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `notice_visible_opac_abon` tinyint(1) NOT NULL DEFAULT '0',
  `expl_visible_opac_abon` int unsigned NOT NULL DEFAULT '0',
  `explnum_visible_opac` int unsigned NOT NULL DEFAULT '1',
  `explnum_visible_opac_abon` int unsigned NOT NULL DEFAULT '0',
  `notice_scan_request_opac` tinyint(1) NOT NULL DEFAULT '0',
  `notice_scan_request_opac_abon` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_notice_statut`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice_tpl`
--

DROP TABLE IF EXISTS `notice_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_tpl` (
  `notpl_id` int unsigned NOT NULL AUTO_INCREMENT,
  `notpl_name` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `notpl_code` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `notpl_comment` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `notpl_id_test` int unsigned NOT NULL DEFAULT '0',
  `notpl_show_opac` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`notpl_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice_tplcode`
--

DROP TABLE IF EXISTS `notice_tplcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_tplcode` (
  `num_notpl` int unsigned NOT NULL DEFAULT '0',
  `notplcode_localisation` mediumint NOT NULL DEFAULT '0',
  `notplcode_typdoc` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'a',
  `notplcode_niveau_biblio` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'm',
  `notplcode_niveau_hierar` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  `nottplcode_code` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`num_notpl`,`notplcode_localisation`,`notplcode_typdoc`,`notplcode_niveau_biblio`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice_usage`
--

DROP TABLE IF EXISTS `notice_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice_usage` (
  `id_usage` int unsigned NOT NULL AUTO_INCREMENT,
  `usage_libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_usage`) USING BTREE,
  KEY `usage_libelle` (`usage_libelle`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices`
--

DROP TABLE IF EXISTS `notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices` (
  `notice_id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `typdoc` char(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'a',
  `tit1` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `tit2` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `tit3` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `tit4` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `tparent_id` mediumint unsigned NOT NULL DEFAULT '0',
  `tnvol` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ed1_id` mediumint unsigned NOT NULL DEFAULT '0',
  `ed2_id` mediumint unsigned NOT NULL DEFAULT '0',
  `coll_id` mediumint unsigned NOT NULL DEFAULT '0',
  `subcoll_id` mediumint unsigned NOT NULL DEFAULT '0',
  `year` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `nocoll` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `mention_edition` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `code` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `npages` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ill` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `size` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `accomp` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `n_gen` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `n_contenu` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `n_resume` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `lien` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `eformat` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `index_l` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `indexint` int unsigned NOT NULL DEFAULT '0',
  `index_serie` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `index_matieres` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `niveau_biblio` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'm',
  `niveau_hierar` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  `origine_catalogage` int unsigned NOT NULL DEFAULT '1',
  `prix` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `index_n_gen` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `index_n_contenu` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `index_n_resume` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `index_sew` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `index_wew` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `statut` int NOT NULL DEFAULT '1',
  `commentaire_gestion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `create_date` datetime NOT NULL DEFAULT '2005-01-01 00:00:00',
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `signature` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `thumbnail_url` mediumblob NOT NULL,
  `date_parution` date NOT NULL DEFAULT '1970-01-01',
  `opac_visible_bulletinage` tinyint unsigned NOT NULL DEFAULT '1',
  `indexation_lang` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `map_echelle_num` int unsigned NOT NULL DEFAULT '0',
  `map_projection_num` int unsigned NOT NULL DEFAULT '0',
  `map_ref_num` int unsigned NOT NULL DEFAULT '0',
  `map_equinoxe` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `notice_is_new` int unsigned NOT NULL DEFAULT '0',
  `notice_date_is_new` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `opac_serialcirc_demande` tinyint unsigned NOT NULL DEFAULT '1',
  `num_notice_usage` int unsigned NOT NULL DEFAULT '0',
  `is_numeric` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`notice_id`) USING BTREE,
  KEY `typdoc` (`typdoc`) USING BTREE,
  KEY `tparent_id` (`tparent_id`) USING BTREE,
  KEY `ed1_id` (`ed1_id`) USING BTREE,
  KEY `ed2_id` (`ed2_id`) USING BTREE,
  KEY `coll_id` (`coll_id`) USING BTREE,
  KEY `subcoll_id` (`subcoll_id`) USING BTREE,
  KEY `cb` (`code`) USING BTREE,
  KEY `indexint` (`indexint`) USING BTREE,
  KEY `sig_index` (`signature`) USING BTREE,
  KEY `i_notice_n_biblio` (`niveau_biblio`) USING BTREE,
  KEY `i_notice_n_hierar` (`niveau_hierar`) USING BTREE,
  KEY `notice_eformat` (`eformat`) USING BTREE,
  KEY `i_date_parution` (`date_parution`) USING BTREE,
  KEY `i_not_statut` (`statut`) USING BTREE,
  KEY `i_map_echelle_num` (`map_echelle_num`) USING BTREE,
  KEY `i_map_projection_num` (`map_projection_num`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1417 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_authorities_sources`
--

DROP TABLE IF EXISTS `notices_authorities_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_authorities_sources` (
  `num_authority_source` int unsigned NOT NULL DEFAULT '0',
  `num_notice` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_authority_source`,`num_notice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_authperso`
--

DROP TABLE IF EXISTS `notices_authperso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_authperso` (
  `notice_authperso_notice_num` int unsigned NOT NULL DEFAULT '0',
  `notice_authperso_authority_num` int unsigned NOT NULL DEFAULT '0',
  `notice_authperso_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`notice_authperso_notice_num`,`notice_authperso_authority_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_categories`
--

DROP TABLE IF EXISTS `notices_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_categories` (
  `notcateg_notice` int unsigned NOT NULL DEFAULT '0',
  `num_noeud` int unsigned NOT NULL DEFAULT '0',
  `num_vedette` int unsigned NOT NULL DEFAULT '0',
  `ordre_vedette` int unsigned NOT NULL DEFAULT '1',
  `ordre_categorie` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`notcateg_notice`,`num_noeud`,`num_vedette`) USING BTREE,
  KEY `num_noeud` (`num_noeud`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_custom`
--

DROP TABLE IF EXISTS `notices_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '1',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_custom_dates`
--

DROP TABLE IF EXISTS `notices_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_custom_dates` (
  `notices_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `notices_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `notices_custom_date_type` int DEFAULT NULL,
  `notices_custom_date_start` int NOT NULL DEFAULT '0',
  `notices_custom_date_end` int NOT NULL DEFAULT '0',
  `notices_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`notices_custom_champ`,`notices_custom_origine`,`notices_custom_order`) USING BTREE,
  KEY `notices_custom_champ` (`notices_custom_champ`) USING BTREE,
  KEY `notices_custom_origine` (`notices_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_custom_lists`
--

DROP TABLE IF EXISTS `notices_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_custom_lists` (
  `notices_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `notices_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `notices_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `notices_custom_champ` (`notices_custom_champ`) USING BTREE,
  KEY `i_ncl_lv` (`notices_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_custom_values`
--

DROP TABLE IF EXISTS `notices_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_custom_values` (
  `notices_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `notices_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `notices_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `notices_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `notices_custom_integer` int DEFAULT NULL,
  `notices_custom_date` date DEFAULT NULL,
  `notices_custom_float` float DEFAULT NULL,
  `notices_custom_order` int NOT NULL DEFAULT '0',
  KEY `notices_custom_champ` (`notices_custom_champ`) USING BTREE,
  KEY `notices_custom_origine` (`notices_custom_origine`) USING BTREE,
  KEY `i_ncv_st` (`notices_custom_small_text`) USING BTREE,
  KEY `i_ncv_t` (`notices_custom_text`(255)) USING BTREE,
  KEY `i_ncv_i` (`notices_custom_integer`) USING BTREE,
  KEY `i_ncv_d` (`notices_custom_date`) USING BTREE,
  KEY `i_ncv_f` (`notices_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_externes`
--

DROP TABLE IF EXISTS `notices_externes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_externes` (
  `num_notice` int NOT NULL DEFAULT '0',
  `recid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`num_notice`) USING BTREE,
  KEY `i_recid` (`recid`) USING BTREE,
  KEY `i_notice_recid` (`num_notice`,`recid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_fields_global_index`
--

DROP TABLE IF EXISTS `notices_fields_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_fields_global_index` (
  `id_notice` mediumint NOT NULL DEFAULT '0',
  `code_champ` int NOT NULL DEFAULT '0',
  `code_ss_champ` int NOT NULL DEFAULT '0',
  `ordre` int NOT NULL DEFAULT '0',
  `value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `pond` int NOT NULL DEFAULT '100',
  `lang` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `authority_num` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_notice`,`code_champ`,`code_ss_champ`,`lang`,`ordre`) USING BTREE,
  KEY `i_value` (`value`(300)) USING BTREE,
  KEY `i_code_champ_code_ss_champ` (`code_champ`,`code_ss_champ`) USING BTREE,
  KEY `i_id_notice` (`id_notice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC
/*!50100 PARTITION BY KEY (code_champ,code_ss_champ)
(PARTITION p0 ENGINE = InnoDB,
 PARTITION p1 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_global_index`
--

DROP TABLE IF EXISTS `notices_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_global_index` (
  `num_notice` mediumint NOT NULL DEFAULT '0',
  `no_index` mediumint NOT NULL DEFAULT '0',
  `infos_global` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `index_infos_global` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`num_notice`,`no_index`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_langues`
--

DROP TABLE IF EXISTS `notices_langues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_langues` (
  `num_notice` int unsigned NOT NULL DEFAULT '0',
  `type_langue` int unsigned NOT NULL DEFAULT '0',
  `code_langue` char(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ordre_langue` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`num_notice`,`type_langue`,`code_langue`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_mots_global_index`
--

DROP TABLE IF EXISTS `notices_mots_global_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_mots_global_index` (
  `id_notice` mediumint NOT NULL DEFAULT '0',
  `code_champ` int NOT NULL DEFAULT '0',
  `code_ss_champ` int NOT NULL DEFAULT '0',
  `num_word` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `position` int NOT NULL DEFAULT '1',
  `field_position` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_notice`,`code_champ`,`code_ss_champ`,`num_word`,`position`,`field_position`) USING BTREE,
  KEY `code_champ` (`code_champ`) USING BTREE,
  KEY `i_id_mot` (`num_word`,`id_notice`) USING BTREE,
  KEY `i_code_champ_code_ss_champ_num_word` (`code_champ`,`code_ss_champ`,`num_word`) USING BTREE,
  KEY `i_num_word` (`num_word`) USING BTREE,
  KEY `i_id_notice` (`id_notice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC
/*!50100 PARTITION BY KEY (code_champ,code_ss_champ)
(PARTITION p0 ENGINE = InnoDB,
 PARTITION p1 ENGINE = InnoDB,
 PARTITION p10 ENGINE = InnoDB,
 PARTITION p11 ENGINE = InnoDB,
 PARTITION p12 ENGINE = InnoDB,
 PARTITION p13 ENGINE = InnoDB,
 PARTITION p14 ENGINE = InnoDB,
 PARTITION p15 ENGINE = InnoDB,
 PARTITION p16 ENGINE = InnoDB,
 PARTITION p17 ENGINE = InnoDB,
 PARTITION p18 ENGINE = InnoDB,
 PARTITION p19 ENGINE = InnoDB,
 PARTITION p2 ENGINE = InnoDB,
 PARTITION p20 ENGINE = InnoDB,
 PARTITION p21 ENGINE = InnoDB,
 PARTITION p22 ENGINE = InnoDB,
 PARTITION p23 ENGINE = InnoDB,
 PARTITION p24 ENGINE = InnoDB,
 PARTITION p25 ENGINE = InnoDB,
 PARTITION p26 ENGINE = InnoDB,
 PARTITION p27 ENGINE = InnoDB,
 PARTITION p28 ENGINE = InnoDB,
 PARTITION p29 ENGINE = InnoDB,
 PARTITION p3 ENGINE = InnoDB,
 PARTITION p30 ENGINE = InnoDB,
 PARTITION p31 ENGINE = InnoDB,
 PARTITION p32 ENGINE = InnoDB,
 PARTITION p33 ENGINE = InnoDB,
 PARTITION p34 ENGINE = InnoDB,
 PARTITION p35 ENGINE = InnoDB,
 PARTITION p36 ENGINE = InnoDB,
 PARTITION p37 ENGINE = InnoDB,
 PARTITION p38 ENGINE = InnoDB,
 PARTITION p39 ENGINE = InnoDB,
 PARTITION p4 ENGINE = InnoDB,
 PARTITION p40 ENGINE = InnoDB,
 PARTITION p41 ENGINE = InnoDB,
 PARTITION p42 ENGINE = InnoDB,
 PARTITION p43 ENGINE = InnoDB,
 PARTITION p44 ENGINE = InnoDB,
 PARTITION p45 ENGINE = InnoDB,
 PARTITION p46 ENGINE = InnoDB,
 PARTITION p47 ENGINE = InnoDB,
 PARTITION p48 ENGINE = InnoDB,
 PARTITION p49 ENGINE = InnoDB,
 PARTITION p5 ENGINE = InnoDB,
 PARTITION p6 ENGINE = InnoDB,
 PARTITION p7 ENGINE = InnoDB,
 PARTITION p8 ENGINE = InnoDB,
 PARTITION p9 ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_relations`
--

DROP TABLE IF EXISTS `notices_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_relations` (
  `id_notices_relations` int unsigned NOT NULL AUTO_INCREMENT,
  `num_notice` bigint unsigned NOT NULL DEFAULT '0',
  `linked_notice` bigint unsigned NOT NULL DEFAULT '0',
  `relation_type` char(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `rank` int NOT NULL DEFAULT '0',
  `direction` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_reverse_link` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_notices_relations`) USING BTREE,
  KEY `linked_notice` (`linked_notice`) USING BTREE,
  KEY `relation_type` (`relation_type`) USING BTREE,
  KEY `num_notice` (`num_notice`) USING BTREE,
  KEY `direction` (`direction`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notices_titres_uniformes`
--

DROP TABLE IF EXISTS `notices_titres_uniformes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notices_titres_uniformes` (
  `ntu_num_notice` int unsigned NOT NULL DEFAULT '0',
  `ntu_num_tu` int unsigned NOT NULL DEFAULT '0',
  `ntu_titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ntu_date` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ntu_sous_vedette` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ntu_langue` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ntu_version` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ntu_mention` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ntu_ordre` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ntu_num_notice`,`ntu_num_tu`) USING BTREE,
  KEY `i_ntu_ntu_num_tu` (`ntu_num_tu`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offres_remises`
--

DROP TABLE IF EXISTS `offres_remises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offres_remises` (
  `num_fournisseur` int unsigned NOT NULL DEFAULT '0',
  `num_produit` int unsigned NOT NULL DEFAULT '0',
  `remise` float(4,2) unsigned NOT NULL DEFAULT '0.00',
  `condition_remise` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  PRIMARY KEY (`num_fournisseur`,`num_produit`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onto_files`
--

DROP TABLE IF EXISTS `onto_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `onto_files` (
  `id_onto_file` int unsigned NOT NULL AUTO_INCREMENT,
  `onto_file_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `onto_file_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `onto_file_filename` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `onto_file_mimetype` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `onto_file_filesize` int NOT NULL DEFAULT '0',
  `onto_file_vignette` mediumblob NOT NULL,
  `onto_file_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `onto_file_path` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `onto_file_create_date` date NOT NULL DEFAULT '1970-01-01',
  `onto_file_num_storage` int NOT NULL DEFAULT '0',
  `onto_file_type_object` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `onto_file_num_object` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_onto_file`) USING BTREE,
  KEY `i_of_onto_file_title` (`onto_file_title`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `onto_uri`
--

DROP TABLE IF EXISTS `onto_uri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `onto_uri` (
  `uri_id` int unsigned NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`uri_id`) USING BTREE,
  UNIQUE KEY `uri` (`uri`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontodemo_g2t`
--

DROP TABLE IF EXISTS `ontodemo_g2t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ontodemo_g2t` (
  `g` mediumint unsigned NOT NULL,
  `t` mediumint unsigned NOT NULL,
  UNIQUE KEY `gt` (`g`,`t`) USING BTREE,
  KEY `tg` (`t`,`g`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontodemo_id2val`
--

DROP TABLE IF EXISTS `ontodemo_id2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ontodemo_id2val` (
  `id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val_type` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`,`val_type`) USING BTREE,
  KEY `v` (`val`(64)) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontodemo_o2val`
--

DROP TABLE IF EXISTS `ontodemo_o2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ontodemo_o2val` (
  `id` mediumint unsigned NOT NULL,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val_hash` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `vh` (`val_hash`) USING BTREE,
  KEY `v` (`val`(64)) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontodemo_s2val`
--

DROP TABLE IF EXISTS `ontodemo_s2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ontodemo_s2val` (
  `id` mediumint unsigned NOT NULL,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val_hash` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `vh` (`val_hash`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontodemo_setting`
--

DROP TABLE IF EXISTS `ontodemo_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ontodemo_setting` (
  `k` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `k` (`k`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontodemo_triple`
--

DROP TABLE IF EXISTS `ontodemo_triple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ontodemo_triple` (
  `t` mediumint unsigned NOT NULL,
  `s` mediumint unsigned NOT NULL,
  `p` mediumint unsigned NOT NULL,
  `o` mediumint unsigned NOT NULL,
  `o_lang_dt` mediumint unsigned NOT NULL,
  `o_comp` char(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `s_type` tinyint(1) NOT NULL DEFAULT '0',
  `o_type` tinyint(1) NOT NULL DEFAULT '0',
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `t` (`t`) USING BTREE,
  KEY `sp` (`s`,`p`) USING BTREE,
  KEY `os` (`o`,`s`) USING BTREE,
  KEY `po` (`p`,`o`) USING BTREE,
  KEY `misc` (`misc`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci DELAY_KEY_WRITE=1 ROW_FORMAT=FIXED;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontologies`
--

DROP TABLE IF EXISTS `ontologies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ontologies` (
  `id_ontology` int unsigned NOT NULL AUTO_INCREMENT,
  `ontology_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ontology_description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `ontology_creation_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `ontology_storage_id` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_ontology`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opac_filters`
--

DROP TABLE IF EXISTS `opac_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opac_filters` (
  `opac_filter_view_num` int unsigned NOT NULL DEFAULT '0',
  `opac_filter_path` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `opac_filter_param` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`opac_filter_view_num`,`opac_filter_path`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opac_liste_lecture`
--

DROP TABLE IF EXISTS `opac_liste_lecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opac_liste_lecture` (
  `id_liste` int unsigned NOT NULL AUTO_INCREMENT,
  `nom_liste` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `public` int NOT NULL DEFAULT '0',
  `num_empr` int unsigned NOT NULL DEFAULT '0',
  `read_only` int NOT NULL DEFAULT '0',
  `confidential` int NOT NULL DEFAULT '0',
  `tag` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `allow_add_records` int NOT NULL DEFAULT '0',
  `allow_remove_records` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_liste`) USING BTREE,
  KEY `i_num_empr` (`num_empr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opac_liste_lecture_notices`
--

DROP TABLE IF EXISTS `opac_liste_lecture_notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opac_liste_lecture_notices` (
  `opac_liste_lecture_num` int unsigned NOT NULL DEFAULT '0',
  `opac_liste_lecture_notice_num` int unsigned NOT NULL DEFAULT '0',
  `opac_liste_lecture_create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`opac_liste_lecture_num`,`opac_liste_lecture_notice_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opac_sessions`
--

DROP TABLE IF EXISTS `opac_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opac_sessions` (
  `empr_id` int unsigned NOT NULL DEFAULT '0',
  `session` mediumblob,
  `date_rec` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`empr_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opac_views`
--

DROP TABLE IF EXISTS `opac_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opac_views` (
  `opac_view_id` int unsigned NOT NULL AUTO_INCREMENT,
  `opac_view_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `opac_view_query` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `opac_view_human_query` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `opac_view_param` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `opac_view_visible` int unsigned NOT NULL DEFAULT '0',
  `opac_view_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `opac_view_last_gen` datetime DEFAULT NULL,
  `opac_view_ttl` int NOT NULL DEFAULT '86400',
  PRIMARY KEY (`opac_view_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opac_views_empr`
--

DROP TABLE IF EXISTS `opac_views_empr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opac_views_empr` (
  `emprview_view_num` int unsigned NOT NULL DEFAULT '0',
  `emprview_empr_num` int unsigned NOT NULL DEFAULT '0',
  `emprview_default` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`emprview_view_num`,`emprview_empr_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `origin_authorities`
--

DROP TABLE IF EXISTS `origin_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `origin_authorities` (
  `id_origin_authorities` int unsigned NOT NULL AUTO_INCREMENT,
  `origin_authorities_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `origin_authorities_country` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `origin_authorities_diffusible` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_origin_authorities`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `origine_notice`
--

DROP TABLE IF EXISTS `origine_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `origine_notice` (
  `orinot_id` int unsigned NOT NULL AUTO_INCREMENT,
  `orinot_nom` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `orinot_pays` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'FR',
  `orinot_diffusion` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`orinot_id`) USING BTREE,
  KEY `orinot_nom` (`orinot_nom`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ouvertures`
--

DROP TABLE IF EXISTS `ouvertures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ouvertures` (
  `date_ouverture` date NOT NULL DEFAULT '1970-01-01',
  `ouvert` int NOT NULL DEFAULT '1',
  `commentaire` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `num_location` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`date_ouverture`,`num_location`) USING BTREE,
  KEY `i_ouvert_num_location_date_ouverture` (`ouvert`,`num_location`,`date_ouverture`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paiements`
--

DROP TABLE IF EXISTS `paiements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paiements` (
  `id_paiement` int unsigned NOT NULL AUTO_INCREMENT,
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `commentaire` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_paiement`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `param_subst`
--

DROP TABLE IF EXISTS `param_subst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `param_subst` (
  `subst_module_param` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `subst_module_num` int unsigned NOT NULL DEFAULT '0',
  `subst_type_param` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `subst_sstype_param` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `subst_valeur_param` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `subst_comment_param` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`subst_module_param`,`subst_module_num`,`subst_type_param`,`subst_sstype_param`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parametres`
--

DROP TABLE IF EXISTS `parametres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametres` (
  `id_param` int unsigned NOT NULL AUTO_INCREMENT,
  `type_param` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `sstype_param` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `valeur_param` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `comment_param` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `section_param` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `gestion` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_param`) USING BTREE,
  UNIQUE KEY `typ_sstyp` (`type_param`,`sstype_param`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1193 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parametres_uncached`
--

DROP TABLE IF EXISTS `parametres_uncached`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parametres_uncached` (
  `id_param` int unsigned NOT NULL AUTO_INCREMENT,
  `type_param` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `sstype_param` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `valeur_param` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `comment_param` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `section_param` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `gestion` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_param`) USING BTREE,
  UNIQUE KEY `typ_sstyp` (`type_param`,`sstype_param`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pclassement`
--

DROP TABLE IF EXISTS `pclassement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pclassement` (
  `id_pclass` int unsigned NOT NULL AUTO_INCREMENT,
  `name_pclass` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `typedoc` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `locations` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_pclass`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `perio_relance`
--

DROP TABLE IF EXISTS `perio_relance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perio_relance` (
  `rel_id` int unsigned NOT NULL AUTO_INCREMENT,
  `rel_abt_num` int unsigned NOT NULL DEFAULT '0',
  `rel_date_parution` date NOT NULL DEFAULT '1970-01-01',
  `rel_libelle_numero` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `rel_comment_gestion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `rel_comment_opac` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `rel_nb` int unsigned NOT NULL DEFAULT '0',
  `rel_date` date NOT NULL DEFAULT '1970-01-01',
  PRIMARY KEY (`rel_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `planificateur`
--

DROP TABLE IF EXISTS `planificateur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planificateur` (
  `id_planificateur` int unsigned NOT NULL AUTO_INCREMENT,
  `num_type_tache` int NOT NULL,
  `libelle_tache` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `desc_tache` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `num_user` int NOT NULL,
  `param` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `statut` tinyint unsigned DEFAULT '0',
  `rep_upload` int DEFAULT NULL,
  `path_upload` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `perio_heure` varchar(28) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `perio_minute` varchar(28) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '01',
  `perio_jour_mois` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT '*',
  `perio_jour` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `perio_mois` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `calc_next_heure_deb` varchar(28) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `calc_next_date_deb` date DEFAULT NULL,
  PRIMARY KEY (`id_planificateur`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pnb_loans`
--

DROP TABLE IF EXISTS `pnb_loans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pnb_loans` (
  `id_pnb_loan` int unsigned NOT NULL AUTO_INCREMENT,
  `pnb_loan_order_line_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `pnb_loan_link` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `pnb_loan_request_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `pnb_loan_num_expl` int unsigned NOT NULL DEFAULT '0',
  `pnb_loan_num_loaner` int unsigned NOT NULL DEFAULT '0',
  `pnb_loan_drm` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `pnb_loan_loanid` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id_pnb_loan`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pnb_orders`
--

DROP TABLE IF EXISTS `pnb_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pnb_orders` (
  `id_pnb_order` int unsigned NOT NULL AUTO_INCREMENT,
  `pnb_order_id_order` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `pnb_order_line_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `pnb_order_num_notice` int unsigned NOT NULL DEFAULT '0',
  `pnb_order_loan_max_duration` int unsigned NOT NULL DEFAULT '0',
  `pnb_order_nb_loans` int unsigned NOT NULL DEFAULT '0',
  `pnb_order_nb_simultaneous_loans` int unsigned NOT NULL DEFAULT '0',
  `pnb_order_nb_consult_in_situ` int unsigned NOT NULL DEFAULT '0',
  `pnb_order_nb_consult_ex_situ` int unsigned NOT NULL DEFAULT '0',
  `pnb_order_offer_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `pnb_order_offer_date_end` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `pnb_order_offer_duration` int unsigned NOT NULL DEFAULT '0',
  `pnb_current_nta` int NOT NULL DEFAULT '0',
  `pnb_order_data` blob NOT NULL,
  PRIMARY KEY (`id_pnb_order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pnb_orders_expl`
--

DROP TABLE IF EXISTS `pnb_orders_expl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pnb_orders_expl` (
  `pnb_order_num` int unsigned NOT NULL DEFAULT '0',
  `pnb_order_expl_num` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pnb_order_num`,`pnb_order_expl_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pret`
--

DROP TABLE IF EXISTS `pret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pret` (
  `pret_idempr` int unsigned NOT NULL DEFAULT '0',
  `pret_idexpl` int unsigned NOT NULL DEFAULT '0',
  `pret_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `pret_retour` date DEFAULT NULL,
  `pret_arc_id` int unsigned NOT NULL DEFAULT '0',
  `niveau_relance` int NOT NULL DEFAULT '0',
  `date_relance` date DEFAULT '1970-01-01',
  `printed` int NOT NULL DEFAULT '0',
  `retour_initial` date DEFAULT '1970-01-01',
  `cpt_prolongation` int NOT NULL DEFAULT '0',
  `pret_temp` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `short_loan_flag` int NOT NULL DEFAULT '0',
  `pret_pnb_flag` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pret_idexpl`) USING BTREE,
  KEY `i_pret_idempr` (`pret_idempr`) USING BTREE,
  KEY `i_pret_arc_id` (`pret_arc_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pret_archive`
--

DROP TABLE IF EXISTS `pret_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pret_archive` (
  `arc_id` int unsigned NOT NULL AUTO_INCREMENT,
  `arc_debut` datetime DEFAULT '1970-01-01 00:00:00',
  `arc_fin` datetime DEFAULT NULL,
  `arc_id_empr` int unsigned NOT NULL DEFAULT '0',
  `arc_empr_cp` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `arc_empr_ville` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `arc_empr_prof` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `arc_empr_year` int unsigned DEFAULT '0',
  `arc_empr_categ` smallint unsigned DEFAULT '0',
  `arc_empr_codestat` smallint unsigned DEFAULT '0',
  `arc_empr_sexe` tinyint unsigned DEFAULT '0',
  `arc_empr_statut` int unsigned NOT NULL DEFAULT '1',
  `arc_empr_location` int unsigned NOT NULL DEFAULT '0',
  `arc_type_abt` int unsigned NOT NULL DEFAULT '0',
  `arc_expl_typdoc` int unsigned DEFAULT '0',
  `arc_expl_cote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `arc_expl_statut` smallint unsigned DEFAULT '0',
  `arc_expl_location` smallint unsigned DEFAULT '0',
  `arc_expl_location_origine` int unsigned NOT NULL DEFAULT '0',
  `arc_expl_location_retour` int unsigned NOT NULL DEFAULT '0',
  `arc_expl_codestat` smallint unsigned DEFAULT '0',
  `arc_expl_owner` mediumint unsigned DEFAULT '0',
  `arc_expl_section` int unsigned NOT NULL DEFAULT '0',
  `arc_expl_id` int unsigned NOT NULL DEFAULT '0',
  `arc_expl_notice` int unsigned NOT NULL DEFAULT '0',
  `arc_expl_bulletin` int unsigned NOT NULL DEFAULT '0',
  `arc_groupe` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `arc_niveau_relance` int unsigned DEFAULT '0',
  `arc_date_relance` date NOT NULL DEFAULT '1970-01-01',
  `arc_printed` int unsigned DEFAULT '0',
  `arc_cpt_prolongation` int unsigned DEFAULT '0',
  `arc_short_loan_flag` int NOT NULL DEFAULT '0',
  `arc_pnb_flag` int NOT NULL DEFAULT '0',
  `arc_pret_source_device` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `arc_retour_source_device` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`arc_id`) USING BTREE,
  KEY `i_pa_expl_id` (`arc_expl_id`) USING BTREE,
  KEY `i_pa_idempr` (`arc_id_empr`) USING BTREE,
  KEY `i_pa_expl_notice` (`arc_expl_notice`) USING BTREE,
  KEY `i_pa_expl_bulletin` (`arc_expl_bulletin`) USING BTREE,
  KEY `i_pa_arc_fin` (`arc_fin`) USING BTREE,
  KEY `i_pa_arc_empr_categ` (`arc_empr_categ`) USING BTREE,
  KEY `i_pa_arc_expl_location` (`arc_expl_location`) USING BTREE,
  KEY `i_pa_arc_expl_section` (`arc_expl_section`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pret_custom`
--

DROP TABLE IF EXISTS `pret_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pret_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pret_custom_dates`
--

DROP TABLE IF EXISTS `pret_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pret_custom_dates` (
  `pret_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `pret_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `pret_custom_date_type` int DEFAULT NULL,
  `pret_custom_date_start` int NOT NULL DEFAULT '0',
  `pret_custom_date_end` int NOT NULL DEFAULT '0',
  `pret_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`pret_custom_champ`,`pret_custom_origine`,`pret_custom_order`) USING BTREE,
  KEY `pret_custom_champ` (`pret_custom_champ`) USING BTREE,
  KEY `pret_custom_origine` (`pret_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pret_custom_lists`
--

DROP TABLE IF EXISTS `pret_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pret_custom_lists` (
  `pret_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `pret_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pret_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `i_pret_custom_champ` (`pret_custom_champ`) USING BTREE,
  KEY `i_pret_champ_list_value` (`pret_custom_champ`,`pret_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pret_custom_values`
--

DROP TABLE IF EXISTS `pret_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pret_custom_values` (
  `pret_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `pret_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `pret_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `pret_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `pret_custom_integer` int DEFAULT NULL,
  `pret_custom_date` date DEFAULT NULL,
  `pret_custom_float` float DEFAULT NULL,
  `pret_custom_order` int NOT NULL DEFAULT '0',
  KEY `i_pret_custom_champ` (`pret_custom_champ`) USING BTREE,
  KEY `i_pret_custom_origine` (`pret_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `print_cart_tpl`
--

DROP TABLE IF EXISTS `print_cart_tpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `print_cart_tpl` (
  `id_print_cart_tpl` int unsigned NOT NULL AUTO_INCREMENT,
  `print_cart_tpl_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `print_cart_tpl_header` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `print_cart_tpl_footer` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`id_print_cart_tpl`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procs`
--

DROP TABLE IF EXISTS `procs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procs` (
  `idproc` smallint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `requete` blob NOT NULL,
  `comment` tinytext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `autorisations` mediumtext CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `autorisations_all` int NOT NULL DEFAULT '0',
  `parameters` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `num_classement` int unsigned NOT NULL DEFAULT '0',
  `proc_notice_tpl` int unsigned NOT NULL DEFAULT '0',
  `proc_notice_tpl_field` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idproc`) USING BTREE,
  KEY `idproc` (`idproc`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `procs_classements`
--

DROP TABLE IF EXISTS `procs_classements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `procs_classements` (
  `idproc_classement` smallint unsigned NOT NULL AUTO_INCREMENT,
  `libproc_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idproc_classement`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_custom`
--

DROP TABLE IF EXISTS `publisher_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher_custom` (
  `idchamp` int unsigned NOT NULL AUTO_INCREMENT,
  `num_type` int unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `titre` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'text',
  `datatype` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `options` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `multiple` int NOT NULL DEFAULT '0',
  `obligatoire` int NOT NULL DEFAULT '0',
  `ordre` int DEFAULT NULL,
  `search` int unsigned NOT NULL DEFAULT '0',
  `export` int unsigned NOT NULL DEFAULT '0',
  `filters` int unsigned NOT NULL DEFAULT '0',
  `exclusion_obligatoire` int unsigned NOT NULL DEFAULT '0',
  `pond` int NOT NULL DEFAULT '100',
  `opac_sort` int NOT NULL DEFAULT '0',
  `comment` blob NOT NULL,
  `custom_classement` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`idchamp`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_custom_dates`
--

DROP TABLE IF EXISTS `publisher_custom_dates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher_custom_dates` (
  `publisher_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `publisher_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `publisher_custom_date_type` int DEFAULT NULL,
  `publisher_custom_date_start` int NOT NULL DEFAULT '0',
  `publisher_custom_date_end` int NOT NULL DEFAULT '0',
  `publisher_custom_order` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`publisher_custom_champ`,`publisher_custom_origine`,`publisher_custom_order`) USING BTREE,
  KEY `publisher_custom_champ` (`publisher_custom_champ`) USING BTREE,
  KEY `publisher_custom_origine` (`publisher_custom_origine`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_custom_lists`
--

DROP TABLE IF EXISTS `publisher_custom_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher_custom_lists` (
  `publisher_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `publisher_custom_list_value` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `publisher_custom_list_lib` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `ordre` int DEFAULT NULL,
  KEY `editorial_custom_champ` (`publisher_custom_champ`) USING BTREE,
  KEY `editorial_champ_list_value` (`publisher_custom_champ`,`publisher_custom_list_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publisher_custom_values`
--

DROP TABLE IF EXISTS `publisher_custom_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher_custom_values` (
  `publisher_custom_champ` int unsigned NOT NULL DEFAULT '0',
  `publisher_custom_origine` int unsigned NOT NULL DEFAULT '0',
  `publisher_custom_small_text` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `publisher_custom_text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `publisher_custom_integer` int DEFAULT NULL,
  `publisher_custom_date` date DEFAULT NULL,
  `publisher_custom_float` float DEFAULT NULL,
  `publisher_custom_order` int NOT NULL DEFAULT '0',
  KEY `editorial_custom_champ` (`publisher_custom_champ`) USING BTREE,
  KEY `editorial_custom_origine` (`publisher_custom_origine`) USING BTREE,
  KEY `i_pcv_st` (`publisher_custom_small_text`) USING BTREE,
  KEY `i_pcv_t` (`publisher_custom_text`(255)) USING BTREE,
  KEY `i_pcv_i` (`publisher_custom_integer`) USING BTREE,
  KEY `i_pcv_d` (`publisher_custom_date`) USING BTREE,
  KEY `i_pcv_f` (`publisher_custom_float`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishers` (
  `ed_id` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `ed_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ed_adr1` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ed_adr2` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ed_cp` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ed_ville` varchar(96) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ed_pays` varchar(96) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `ed_web` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `index_publisher` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `ed_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `ed_num_entite` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ed_id`) USING BTREE,
  KEY `ed_name` (`ed_name`) USING BTREE,
  KEY `ed_ville` (`ed_ville`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quotas`
--

DROP TABLE IF EXISTS `quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotas` (
  `quota_type` int unsigned NOT NULL DEFAULT '0',
  `constraint_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `elements` int unsigned NOT NULL DEFAULT '0',
  `value` float DEFAULT NULL,
  PRIMARY KEY (`quota_type`,`constraint_type`,`elements`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quotas_finance`
--

DROP TABLE IF EXISTS `quotas_finance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotas_finance` (
  `quota_type` int unsigned NOT NULL DEFAULT '0',
  `constraint_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `elements` int unsigned NOT NULL DEFAULT '0',
  `value` float DEFAULT NULL,
  PRIMARY KEY (`quota_type`,`constraint_type`,`elements`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quotas_opac_views`
--

DROP TABLE IF EXISTS `quotas_opac_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quotas_opac_views` (
  `quota_type` int unsigned NOT NULL DEFAULT '0',
  `constraint_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `elements` int unsigned NOT NULL DEFAULT '0',
  `value` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  PRIMARY KEY (`quota_type`,`constraint_type`,`elements`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rapport_demandes`
--

DROP TABLE IF EXISTS `rapport_demandes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rapport_demandes` (
  `id_item` int unsigned NOT NULL AUTO_INCREMENT,
  `contenu` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `num_note` int NOT NULL DEFAULT '0',
  `num_demande` int NOT NULL DEFAULT '0',
  `ordre` mediumint NOT NULL DEFAULT '0',
  `type` mediumint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_item`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdfstore_g2t`
--

DROP TABLE IF EXISTS `rdfstore_g2t`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rdfstore_g2t` (
  `g` mediumint unsigned NOT NULL,
  `t` mediumint unsigned NOT NULL,
  UNIQUE KEY `gt` (`g`,`t`) USING BTREE,
  KEY `tg` (`t`,`g`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdfstore_id2val`
--

DROP TABLE IF EXISTS `rdfstore_id2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rdfstore_id2val` (
  `id` mediumint unsigned NOT NULL,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val_type` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `id` (`id`,`val_type`) USING BTREE,
  KEY `v` (`val`(64)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdfstore_index`
--

DROP TABLE IF EXISTS `rdfstore_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rdfstore_index` (
  `num_triple` int unsigned NOT NULL DEFAULT '0',
  `subject_uri` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `subject_type` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `predicat_uri` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `num_object` int unsigned NOT NULL DEFAULT '0',
  `object_val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `object_index` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `object_lang` char(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`num_object`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdfstore_o2val`
--

DROP TABLE IF EXISTS `rdfstore_o2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rdfstore_o2val` (
  `id` mediumint unsigned NOT NULL,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val_hash` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `vh` (`val_hash`) USING BTREE,
  KEY `v` (`val`(64)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdfstore_s2val`
--

DROP TABLE IF EXISTS `rdfstore_s2val`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rdfstore_s2val` (
  `id` mediumint unsigned NOT NULL,
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  `val_hash` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `id` (`id`) USING BTREE,
  KEY `vh` (`val_hash`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdfstore_setting`
--

DROP TABLE IF EXISTS `rdfstore_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rdfstore_setting` (
  `k` char(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `val` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  UNIQUE KEY `k` (`k`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rdfstore_triple`
--

DROP TABLE IF EXISTS `rdfstore_triple`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rdfstore_triple` (
  `t` mediumint unsigned NOT NULL,
  `s` mediumint unsigned NOT NULL,
  `p` mediumint unsigned NOT NULL,
  `o` mediumint unsigned NOT NULL,
  `o_lang_dt` mediumint unsigned NOT NULL,
  `o_comp` char(35) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `s_type` tinyint(1) NOT NULL DEFAULT '0',
  `o_type` tinyint(1) NOT NULL DEFAULT '0',
  `misc` tinyint(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `t` (`t`) USING BTREE,
  KEY `sp` (`s`,`p`) USING BTREE,
  KEY `os` (`o`,`s`) USING BTREE,
  KEY `po` (`p`,`o`) USING BTREE,
  KEY `misc` (`misc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recouvrements`
--

DROP TABLE IF EXISTS `recouvrements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recouvrements` (
  `recouvr_id` int unsigned NOT NULL AUTO_INCREMENT,
  `empr_id` int unsigned NOT NULL DEFAULT '0',
  `id_expl` int unsigned NOT NULL DEFAULT '0',
  `date_rec` date NOT NULL DEFAULT '1970-01-01',
  `libelle` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci DEFAULT NULL,
  `montant` decimal(16,2) DEFAULT '0.00',
  `recouvr_type` int unsigned NOT NULL DEFAULT '0',
  `date_pret` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `date_relance1` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `date_relance2` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `date_relance3` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`recouvr_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rent_account_types_sections`
--

DROP TABLE IF EXISTS `rent_account_types_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent_account_types_sections` (
  `account_type_num_exercice` int unsigned NOT NULL DEFAULT '0',
  `account_type_num_section` int unsigned NOT NULL DEFAULT '0',
  `account_type_marclist` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`account_type_num_section`,`account_type_marclist`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rent_accounts`
--

DROP TABLE IF EXISTS `rent_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent_accounts` (
  `id_account` int unsigned NOT NULL AUTO_INCREMENT,
  `account_num_user` int unsigned NOT NULL DEFAULT '0',
  `account_num_exercice` int unsigned NOT NULL DEFAULT '0',
  `account_request_type` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `account_type` varchar(3) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `account_desc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `account_date` datetime DEFAULT NULL,
  `account_receipt_limit_date` datetime DEFAULT NULL,
  `account_receipt_effective_date` datetime DEFAULT NULL,
  `account_return_date` datetime DEFAULT NULL,
  `account_num_uniform_title` int unsigned NOT NULL DEFAULT '0',
  `account_title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `account_event_date` datetime DEFAULT NULL,
  `account_event_formation` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `account_event_orchestra` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `account_event_place` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `account_num_publisher` int unsigned NOT NULL DEFAULT '0',
  `account_num_supplier` int unsigned NOT NULL DEFAULT '0',
  `account_num_author` int unsigned NOT NULL DEFAULT '0',
  `account_num_pricing_system` int unsigned NOT NULL DEFAULT '0',
  `account_time` int unsigned NOT NULL DEFAULT '0',
  `account_percent` float(8,2) unsigned NOT NULL DEFAULT '0.00',
  `account_price` float(12,2) unsigned NOT NULL DEFAULT '0.00',
  `account_web` int unsigned NOT NULL DEFAULT '0',
  `account_web_percent` float(8,2) unsigned NOT NULL DEFAULT '0.00',
  `account_web_price` float(12,2) unsigned NOT NULL DEFAULT '0.00',
  `account_comment` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `account_request_status` int unsigned NOT NULL DEFAULT '1',
  `account_num_acte` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rent_accounts_invoices`
--

DROP TABLE IF EXISTS `rent_accounts_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent_accounts_invoices` (
  `account_invoice_num_account` int unsigned NOT NULL DEFAULT '0',
  `account_invoice_num_invoice` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`account_invoice_num_account`,`account_invoice_num_invoice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rent_invoices`
--

DROP TABLE IF EXISTS `rent_invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent_invoices` (
  `id_invoice` int unsigned NOT NULL AUTO_INCREMENT,
  `invoice_num_user` int unsigned NOT NULL DEFAULT '0',
  `invoice_date` datetime DEFAULT NULL,
  `invoice_status` int unsigned NOT NULL DEFAULT '1',
  `invoice_valid_date` datetime DEFAULT NULL,
  `invoice_destination` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `invoice_num_acte` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_invoice`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rent_pricing_system_grids`
--

DROP TABLE IF EXISTS `rent_pricing_system_grids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent_pricing_system_grids` (
  `id_pricing_system_grid` int unsigned NOT NULL AUTO_INCREMENT,
  `pricing_system_grid_num_system` int unsigned NOT NULL DEFAULT '0',
  `pricing_system_grid_time_start` int unsigned NOT NULL DEFAULT '0',
  `pricing_system_grid_time_end` int unsigned NOT NULL DEFAULT '0',
  `pricing_system_grid_price` float(12,2) unsigned NOT NULL DEFAULT '0.00',
  `pricing_system_grid_type` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pricing_system_grid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rent_pricing_systems`
--

DROP TABLE IF EXISTS `rent_pricing_systems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent_pricing_systems` (
  `id_pricing_system` int unsigned NOT NULL AUTO_INCREMENT,
  `pricing_system_label` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `pricing_system_desc` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `pricing_system_percents` text CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci,
  `pricing_system_num_exercice` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_pricing_system`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resa`
--

DROP TABLE IF EXISTS `resa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resa` (
  `id_resa` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `resa_idempr` int unsigned NOT NULL DEFAULT '0',
  `resa_idnotice` mediumint unsigned NOT NULL DEFAULT '0',
  `resa_idbulletin` int unsigned NOT NULL DEFAULT '0',
  `resa_date` datetime DEFAULT NULL,
  `resa_date_debut` date NOT NULL DEFAULT '1970-01-01',
  `resa_date_fin` date NOT NULL DEFAULT '1970-01-01',
  `resa_cb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resa_confirmee` int unsigned NOT NULL DEFAULT '0',
  `resa_loc_retrait` smallint unsigned NOT NULL DEFAULT '0',
  `resa_arc` int unsigned NOT NULL DEFAULT '0',
  `resa_planning_id_resa` int unsigned NOT NULL DEFAULT '0',
  `resa_pnb_flag` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_resa`) USING BTREE,
  KEY `resa_date_fin` (`resa_date_fin`) USING BTREE,
  KEY `resa_date` (`resa_date`) USING BTREE,
  KEY `resa_cb` (`resa_cb`) USING BTREE,
  KEY `i_idbulletin` (`resa_idbulletin`) USING BTREE,
  KEY `i_idnotice` (`resa_idnotice`) USING BTREE,
  KEY `i_resa_idempr` (`resa_idempr`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resa_archive`
--

DROP TABLE IF EXISTS `resa_archive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resa_archive` (
  `resarc_id` int unsigned NOT NULL AUTO_INCREMENT,
  `resarc_date` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `resarc_debut` date NOT NULL DEFAULT '1970-01-01',
  `resarc_fin` date NOT NULL DEFAULT '1970-01-01',
  `resarc_idnotice` int unsigned NOT NULL DEFAULT '0',
  `resarc_idbulletin` int unsigned NOT NULL DEFAULT '0',
  `resarc_confirmee` int unsigned DEFAULT '0',
  `resarc_cb` varchar(14) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resarc_loc_retrait` smallint unsigned DEFAULT '0',
  `resarc_from_opac` int unsigned DEFAULT '0',
  `resarc_anulee` int unsigned DEFAULT '0',
  `resarc_pretee` int unsigned DEFAULT '0',
  `resarc_arcpretid` int unsigned NOT NULL DEFAULT '0',
  `resarc_id_empr` int unsigned NOT NULL DEFAULT '0',
  `resarc_empr_cp` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resarc_empr_ville` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resarc_empr_prof` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resarc_empr_year` int unsigned DEFAULT '0',
  `resarc_empr_categ` smallint unsigned DEFAULT '0',
  `resarc_empr_codestat` smallint unsigned DEFAULT '0',
  `resarc_empr_sexe` tinyint unsigned DEFAULT '0',
  `resarc_empr_location` int unsigned NOT NULL DEFAULT '1',
  `resarc_expl_nb` int unsigned DEFAULT '0',
  `resarc_expl_typdoc` int unsigned DEFAULT '0',
  `resarc_expl_cote` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `resarc_expl_statut` smallint unsigned DEFAULT '0',
  `resarc_expl_location` smallint unsigned DEFAULT '0',
  `resarc_expl_codestat` smallint unsigned DEFAULT '0',
  `resarc_expl_owner` mediumint unsigned DEFAULT '0',
  `resarc_expl_section` int unsigned NOT NULL DEFAULT '0',
  `resarc_resa_planning_id_resa` int unsigned NOT NULL DEFAULT '0',
  `resarc_pnb_flag` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`resarc_id`) USING BTREE,
  KEY `i_pa_idempr` (`resarc_id_empr`) USING BTREE,
  KEY `i_pa_notice` (`resarc_idnotice`) USING BTREE,
  KEY `i_pa_bulletin` (`resarc_idbulletin`) USING BTREE,
  KEY `i_pa_resarc_date` (`resarc_date`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resa_loc`
--

DROP TABLE IF EXISTS `resa_loc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resa_loc` (
  `resa_loc` int unsigned NOT NULL DEFAULT '0',
  `resa_emprloc` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`resa_loc`,`resa_emprloc`) USING BTREE,
  KEY `i_resa_emprloc` (`resa_emprloc`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resa_planning`
--

DROP TABLE IF EXISTS `resa_planning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resa_planning` (
  `id_resa` mediumint unsigned NOT NULL AUTO_INCREMENT,
  `resa_idempr` mediumint unsigned NOT NULL DEFAULT '0',
  `resa_idnotice` mediumint unsigned NOT NULL DEFAULT '0',
  `resa_idbulletin` int unsigned NOT NULL DEFAULT '0',
  `resa_date` datetime DEFAULT NULL,
  `resa_date_debut` date NOT NULL DEFAULT '1970-01-01',
  `resa_date_fin` date NOT NULL DEFAULT '1970-01-01',
  `resa_validee` int unsigned NOT NULL DEFAULT '0',
  `resa_confirmee` int unsigned NOT NULL DEFAULT '0',
  `resa_loc_retrait` int unsigned NOT NULL DEFAULT '0',
  `resa_qty` int unsigned NOT NULL DEFAULT '1',
  `resa_remaining_qty` int unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id_resa`) USING BTREE,
  KEY `resa_date_fin` (`resa_date_fin`) USING BTREE,
  KEY `resa_date` (`resa_date`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `resa_ranger`
--

DROP TABLE IF EXISTS `resa_ranger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resa_ranger` (
  `resa_cb` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`resa_cb`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `responsability`
--

DROP TABLE IF EXISTS `responsability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsability` (
  `id_responsability` int unsigned NOT NULL AUTO_INCREMENT,
  `responsability_author` mediumint unsigned NOT NULL DEFAULT '0',
  `responsability_notice` mediumint unsigned NOT NULL DEFAULT '0',
  `responsability_fonction` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `responsability_type` mediumint unsigned NOT NULL DEFAULT '0',
  `responsability_ordre` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_responsability`,`responsability_author`,`responsability_notice`,`responsability_fonction`) USING BTREE,
  KEY `responsability_notice` (`responsability_notice`) USING BTREE,
  KEY `i_responsability_author` (`responsability_author`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5683 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `responsability_authperso`
--

DROP TABLE IF EXISTS `responsability_authperso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsability_authperso` (
  `id_responsability_authperso` int unsigned NOT NULL AUTO_INCREMENT,
  `responsability_authperso_author` mediumint unsigned NOT NULL DEFAULT '0',
  `responsability_authperso_num` mediumint unsigned NOT NULL DEFAULT '0',
  `responsability_authperso_fonction` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `responsability_authperso_type` mediumint unsigned NOT NULL DEFAULT '0',
  `responsability_authperso_ordre` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_responsability_authperso`,`responsability_authperso_author`,`responsability_authperso_num`,`responsability_authperso_fonction`) USING BTREE,
  KEY `responsability_authperso_num` (`responsability_authperso_num`) USING BTREE,
  KEY `responsability_authperso_author` (`responsability_authperso_author`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `responsability_tu`
--

DROP TABLE IF EXISTS `responsability_tu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `responsability_tu` (
  `id_responsability_tu` int unsigned NOT NULL AUTO_INCREMENT,
  `responsability_tu_author_num` int unsigned NOT NULL DEFAULT '0',
  `responsability_tu_num` int unsigned NOT NULL DEFAULT '0',
  `responsability_tu_fonction` char(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT '',
  `responsability_tu_type` int unsigned NOT NULL DEFAULT '0',
  `responsability_tu_ordre` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_responsability_tu`,`responsability_tu_author_num`,`responsability_tu_num`,`responsability_tu_fonction`) USING BTREE,
  KEY `responsability_tu_author` (`responsability_tu_author_num`) USING BTREE,
  KEY `responsability_tu_num` (`responsability_tu_num`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rss_content`
--

DROP TABLE IF EXISTS `rss_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rss_content` (
  `rss_id` int unsigned NOT NULL DEFAULT '0',
  `rss_content` longblob NOT NULL,
  `rss_content_parse` longblob NOT NULL,
  `rss_last` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rss_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-07 15:18:15
