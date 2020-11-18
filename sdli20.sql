-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.4.14-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dump della struttura del database vorp
CREATE DATABASE IF NOT EXISTS `vorp` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `vorp`;

-- Dump della struttura di tabella vorp.banks
CREATE TABLE IF NOT EXISTS `banks` (
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella vorp.banks: ~4 rows (circa)
/*!40000 ALTER TABLE `banks` DISABLE KEYS */;
INSERT INTO `banks` (`name`) VALUES
	('Blackwater'),
	('Rhodes'),
	('Saint Denis'),
	('Valentine');
/*!40000 ALTER TABLE `banks` ENABLE KEYS */;

-- Dump della struttura di tabella vorp.bank_users
CREATE TABLE IF NOT EXISTS `bank_users` (
  `name` varchar(50) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `money` double(22,2) DEFAULT 0.00,
  `gold` double(22,2) DEFAULT 0.00,
  KEY `name` (`name`),
  CONSTRAINT `bank` FOREIGN KEY (`name`) REFERENCES `banks` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Dump della struttura di tabella vorp.banneds
CREATE TABLE IF NOT EXISTS `banneds` (
  `b_id` int(11) NOT NULL AUTO_INCREMENT,
  `b_steam` varchar(100) NOT NULL,
  `b_license` varchar(255) DEFAULT NULL,
  `b_discord` varchar(100) DEFAULT NULL,
  `b_reason` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `b_banned` varchar(100) NOT NULL,
  `b_unban` varchar(100) NOT NULL,
  `b_permanent` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`b_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dump dei dati della tabella vorp.banneds: ~0 rows (circa)
/*!40000 ALTER TABLE `banneds` DISABLE KEYS */;
/*!40000 ALTER TABLE `banneds` ENABLE KEYS */;

-- Dump della struttura di tabella vorp.boates
CREATE TABLE IF NOT EXISTS `boates` (
  `identifier` varchar(40) NOT NULL,
  `charid` int(11) NOT NULL,
  `boat` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dump dei dati della tabella vorp.boates: ~12 rows (circa)
/*!40000 ALTER TABLE `boates` DISABLE KEYS */;

/*!40000 ALTER TABLE `boates` ENABLE KEYS */;

-- Dump della struttura di tabella vorp.casse
CREATE TABLE IF NOT EXISTS `casse` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `permission` varchar(40) DEFAULT NULL,
  `inventory` longtext NOT NULL DEFAULT '',
  `maxitems` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella vorp.casse: ~9 rows (circa)
/*!40000 ALTER TABLE `casse` DISABLE KEYS */;
INSERT INTO `casse` (`id`, `permission`, `inventory`, `maxitems`) VALUES
	(1, 'Sceriffo', '{"[117,WEAPON_REVOLVER_DOUBLEACTION]":0,"book":0,"[42,WEAPON_REPEATER_EVANS]":0,"[740,WEAPON_LASSO]":0,"[40,WEAPON_REPEATER_EVANS]":0,"licenzataglie":1,"[742,WEAPON_MELEE_KNIFE]":1,"[773,WEAPON_RIFLE_BOLTACTION]":1,"[32,WEAPON_PISTOL_MAUSER]":0,"licenzacaccia":1,"[41,WEAPON_REPEATER_EVANS]":0,"[35,WEAPON_PISTOL_MAUSER]":1,"[115,WEAPON_MELEE_KNIFE]":0,"[157,WEAPON_REVOLVER_NAVY]":0,"[768,WEAPON_REVOLVER_SCHOFIELD]":0,"[143,WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC]":1,"[759,WEAPON_REPEATER_WINCHESTER]":2,"fishbait":0,"[761,WEAPON_REPEATER_WINCHESTER]":0,"[47,WEAPON_LASSO]":0,"[39,WEAPON_REPEATER_EVANS]":0,"[46,WEAPON_LASSO]":0,"[34,WEAPON_PISTOL_MAUSER]":0,"[45,WEAPON_LASSO]":0,"[665,WEAPON_REPEATER_WINCHESTER]":1,"[37,WEAPON_PISTOL_MAUSER]":0,"[776,WEAPON_REVOLVER_DOUBLEACTION]":0,"[767,WEAPON_REVOLVER_SCHOFIELD]":0,"[43,WEAPON_REPEATER_EVANS]":0,"[27,WEAPON_REVOLVER_NAVY]":0,"pocket_watch":0,"[57,WEAPON_REVOLVER_DOUBLEACTION]":0,"[781,WEAPON_REPEATER_WINCHESTER]":1,"[49,WEAPON_LASSO]":0,"feather":0,"[762,WEAPON_REVOLVER_SCHOFIELD]":1,"[33,WEAPON_PISTOL_MAUSER]":1,"[217,WEAPON_FISHINGROD]":0,"[38,WEAPON_REPEATER_EVANS]":0,"[56,WEAPON_BOW]":1,"[44,WEAPON_LASSO]":0,"stufatodicarne":0,"[48,WEAPON_LASSO]":0,"[36,WEAPON_PISTOL_MAUSER]":1,"[72,WEAPON_REVOLVER_DOUBLEACTION]":1}', 2000),
	(2, 'Saloon', '{"goldnugget":0,"cornseed":0,"meat_cervo":70,"consumable_coffee":8,"cereali":0,"stufatodicarne":41,"p_belladonna":10,"mela":9,"cigarette":0,"a_c_fishrockbass_01_sm":72,"birra":21,"acqua":1,"caroteseed":64,"pomodori":86,"sugar":124,"consumable_kidneybeans_can":0,"consumable_acqua":0,"fungo_mazza":1,"barbaseed":10,"fan":0,"patateseed":42,"sidro":11,"stufatodipesce":12,"lockpick":0,"patate":79,"carote":84,"pomseed":58,"cerealiseed":40,"vodka":1,"consumable_pane":4,"rum":19,"goldpan":0,"[5,WEAPON_BOW]":0,"emptybottle":15,"daiquiri":0,"whisky":44}', 2000),
	(3, 'Armaiolo', '{"[731,WEAPON_REPEATER_HENRY]":0,"volcanicblueprint":0,"[299,WEAPON_PISTOL_MAUSER]":0,"listpino":0,"ferro":0,"ceppino":0,"[766,WEAPON_REVOLVER_SCHOFIELD]":0,"[767,WEAPON_REVOLVER_SCHOFIELD]":0,"[762,WEAPON_REVOLVER_SCHOFIELD]":0,"[302,WEAPON_BOW]":0,"[690,WEAPON_REVOLVER_LEMAT]":0,"calciopistolamigliorato":0,"[765,WEAPON_REPEATER_WINCHESTER]":0,"calciofucilemigliorato":0,"atto":1,"[759,WEAPON_REPEATER_WINCHESTER]":0,"corpofucile":0,"[764,WEAPON_REPEATER_WINCHESTER]":0,"henryblueprint":0,"[665,WEAPON_REPEATER_WINCHESTER]":0,"[734,WEAPON_REPEATER_HENRY]":0,"cleanshort":0,"[646,WEAPON_REVOLVER_LEMAT]":0,"caroteseed":15,"[303,WEAPON_MELEE_KNIFE]":0,"[781,WEAPON_REPEATER_WINCHESTER]":0,"[662,WEAPON_REPEATER_HENRY]":0,"[763,WEAPON_REPEATER_WINCHESTER]":0,"cannafucile":0,"schofieldblueprint":0,"cannapistola":0,"wateringcan":0,"calciofucilestandard":0,"cepabe":0,"calciopistolastandard":0,"[518,WEAPON_RIFLE_BOLTACTION]":0,"whisky":1,"broccoliseed":0,"[691,WEAPON_RIFLE_BOLTACTION]":0,"tonico_c2":0,"cepcedr":0,"[760,WEAPON_REVOLVER_SCHOFIELD]":0,"lematblueprint":0,"[733,WEAPON_REPEATER_HENRY]":0,"[644,WEAPON_REVOLVER_LEMAT]":0,"listabe":0,"[792,WEAPON_PISTOL_VOLCANIC]":0,"winchesterblueprint":0,"[932,WEAPON_REVOLVER_DOUBLEACTION]":0,"licenzataglie":0,"cattleblueprint":0,"corpopistola":0,"[636,WEAPON_REVOLVER_DOUBLEACTION]":0,"licenzacaccia":1,"[761,WEAPON_REPEATER_WINCHESTER]":0,"[768,WEAPON_REVOLVER_SCHOFIELD]":0,"boltblueprint":0,"fungo_mazza":0,"listcedr":0,"acciaio":0}', 2000),
	(4, 'Medico', '{"acqua":116,"tonico_s1":2,"fungo_mazza":104,"salvia":0,"tonico_c1":4,"ginseng_alaska":78,"vaniglia":155,"siringa":0,"[775,WEAPON_BOW]":0,"emptybottle":0,"snakepoison":2,"ribes":3,"tonico_c2":3,"consumable_pane":5,"veleno_s":0,"p_belladonna":56,"ginseng_americano":10,"consumable_acqua":0,"[479,WEAPON_MELEE_TORCH]":0}', 2000),
	(5, 'Banchiere', '{"goldnugget":982}', 2000),
	(6, 'blackjack', '{"atto":1,"fishbait":0,"meat_tacchino":-1,"indovinello":1,"ginseng_alaska":40,"birra":21,"a_c_fishbluegil_01_sm":0,"map1":1,"map4":1,"rum":10,"acqua":109,"[801,WEAPON_FISHINGROD]":0,"consumable_tacchino":116,"whisky":0,"[119,WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC]":0}', 2000),
	(7, 'Indiano', '{"acqua":110,"galletta":10,"stufatodicarne":5,"consumable_coffee":5,"p_oppio":128,"tonico_aug":8,"rum":1,"ferro":60,"[1020,WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC]":1,"emptybottle":60,"oppio":160,"cereali":165,"p_belladonna":330,"wateringcan":4,"ceppino":45,"cerealiseed":64,"meat_cervo":46,"feather":64,"a_c_fishrockbass_01_sm":5,"barbaseed":64,"ginseng_americano":150,"[1021,WEAPON_BOW_IMPROVED]":1,"broccoliseed":40,"[1023,WEAPON_REPEATER_WINCHESTER]":1,"snakepoison":50,"barbabietole":80,"meat_cinghiale":10,"consumable_tacchino":3,"patateseed":10,"pipe":1,"sugar":0}', 5000),
	(8, 'Bordello', '{"birra":1,"consumable_peach":5,"whisky":3,"pipe":1,"[26,WEAPON_MELEE_KNIFE]":0,"daiquiri":3,"rum":10,"torta":1,"vodka":0,"sugar":28,"emptybottle":10,"carote":1}', 2000),
	(9, 'Staff', '{"[308,WEAPON_BOW]":0,"[262,WEAPON_MELEE_KNIFE]":0,"[481,WEAPON_REPEATER_WINCHESTER]":1,"[522,WEAPON_THROWN_TOMAHAWK]":1,"[484,WEAPON_REVOLVER_CATTLEMAN]":0,"[469,WEAPON_MELEE_KNIFE]":0,"[305,WEAPON_LASSO]":0,"[65,WEAPON_BOW]":0,"[544,WEAPON_BOW]":1,"[421,WEAPON_LASSO]":1,"[554,WEAPON_MELEE_MACHETE]":1,"[413,WEAPON_REVOLVER_DOUBLEACTION_GAMBLER]":0,"[7,WEAPON_LASSO]":1,"[68,WEAPON_REVOLVER_DOUBLEACTION]":0,"[52,WEAPON_MELEE_KNIFE]":0,"[533,WEAPON_MELEE_HATCHET_HUNTER]":0,"[468,WEAPON_MELEE_KNIFE]":1,"[273,WEAPON_REVOLVER_DOUBLEACTION]":1,"[364,WEAPON_REPEATER_EVANS]":0,"[268,WEAPON_REVOLVER_CATTLEMAN_MEXICAN]":1}', 5000);
/*!40000 ALTER TABLE `casse` ENABLE KEYS */;

-- Dump della struttura di tabella vorp.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `charidentifier` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(10) COLLATE utf8mb4_bin DEFAULT 'user',
  `money` double(11,2) DEFAULT 0.00,
  `gold` double(11,2) DEFAULT 0.00,
  `rol` double(11,2) NOT NULL DEFAULT 0.00,
  `xp` int(11) DEFAULT 0,
  `inventory` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(50) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `status` varchar(140) COLLATE utf8mb4_bin DEFAULT '{}',
  `firstname` varchar(50) COLLATE utf8mb4_bin DEFAULT ' ',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT ' ',
  `skinPlayer` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `compPlayer` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `jobgrade` int(11) DEFAULT 0,
  `coords` varchar(75) COLLATE utf8mb4_bin DEFAULT '{}',
  `isdead` tinyint(1) DEFAULT 0,
  `jail` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `jailtime` int(11) DEFAULT -1,
  `stress` double DEFAULT 0,
  UNIQUE KEY `identifier_charidentifier` (`identifier`,`charidentifier`) USING BTREE,
  KEY `charidentifier` (`charidentifier`) USING BTREE,
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`identifier`) REFERENCES `users` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dump della struttura di tabella vorp.horse_complements
CREATE TABLE IF NOT EXISTS `horse_complements` (
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `complements` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


/*!40000 ALTER TABLE `horse_complements` ENABLE KEYS */;

-- Dump della struttura di tabella vorp.housing
CREATE TABLE IF NOT EXISTS `housing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `charidentifier` int(11) NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `furniture` longtext DEFAULT NULL,
  `open` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=72707 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


-- Dump della struttura di tabella vorp.items
CREATE TABLE IF NOT EXISTS `items` (
  `item` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT 1,
  `can_remove` tinyint(1) NOT NULL DEFAULT 1,
  `type` varchar(50) DEFAULT NULL,
  `usable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`item`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- Dump dei dati della tabella vorp.items: ~159 rows (circa)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`) VALUES
	('acciaio', 'Barre d\'Acciaio', 20, 1, 'item_standard', 0),
	('acqua', 'Acqua Pulita', 8, 1, 'item_standard', 1),
	('atto', 'Atto di Proprietà', 5, 1, 'item_standard', 0),
	('a_c_fishbluegil_01_ms', 'Bluegill Medio', 3, 1, 'item_standard', 0),
	('a_c_fishbluegil_01_sm', 'Bluegill Piccolo', 5, 1, 'item_standard', 0),
	('a_c_fishbullheadcat_01_ms', 'Pesce gatto Medio', 3, 1, 'item_standard', 0),
	('a_c_fishbullheadcat_01_sm', 'Pesce gatto Piccolo', 5, 1, 'item_standard', 0),
	('a_c_fishchainpickerel_01_ms', 'Luccio Medio', 3, 1, 'item_standard', 0),
	('a_c_fishchainpickerel_01_sm', 'Luccio Piccolo', 5, 1, 'item_standard', 0),
	('a_c_fishlargemouthbass_01_ms', 'Persico trota', 3, 1, 'item_standard', 0),
	('a_c_fishperch_01_ms', 'Persico Medio', 3, 1, 'item_standard', 0),
	('a_c_fishperch_01_sm', 'Persico Piccolo', 5, 1, 'item_standard', 0),
	('a_c_fishrainbowtrout_01_ms', 'Trota', 3, 1, 'item_standard', 0),
	('a_c_fishredfinpickerel_01_ms', 'Redfin Pike', 3, 1, 'item_standard', 0),
	('a_c_fishredfinpickerel_01_sm', 'Luccio rosso Piccolo', 5, 1, 'item_standard', 0),
	('a_c_fishrockbass_01_ms', 'Rock Bass Medio', 3, 1, 'item_standard', 0),
	('a_c_fishrockbass_01_sm', 'Rock Bass Piccolo', 5, 1, 'item_standard', 0),
	('a_c_fishsalmonsockeye_01_ms', 'Salmone Sockeye', 3, 1, 'item_standard', 0),
	('a_c_fishsmallmouthbass_01_ms', 'Smallmouth Bass Piccolo', 3, 1, 'item_standard', 0),
	('barbabietole', 'Barbabietole', 20, 1, 'item_standard', 0),
	('barbaseed', 'Semi di Barbabietola', 64, 1, 'item_standard', 1),
	('birra', 'Birra', 5, 1, 'item_standard', 1),
	('boltblueprint', 'Progetto e Componenti Bolt Action', 1, 1, 'item_standard', 0),
	('book', 'Tutti pazzi per Josephine', 1, 1, 'item_standard', 1),
	('braccio', 'Braccio del tuo corpo', 50, 1, 'item_standard', 1),
	('broccoli', 'Broccoli', 20, 1, 'item_standard', 0),
	('broccoliseed', 'Semi di Broccoli', 64, 1, 'item_standard', 1),
	('calciofucilemigliorato', 'Calcio Fucile Migliorato', 5, 1, 'item_standard', 0),
	('calciofucilestandard', 'Calcio Fucile Standard ', 5, 1, 'item_standard', 0),
	('calciopistolamigliorato', 'Calcio Pistola Migliorato', 5, 1, 'item_standard', 0),
	('calciopistolastandard', 'Calcio Pistola Standard', 5, 1, 'item_standard', 0),
	('calumet', 'Calumet della Pace', 1, 1, 'item_standard', 0),
	('cannafucile', 'Canna Fucile', 5, 1, 'item_standard', 0),
	('cannapistola', 'Canna Pistola', 5, 1, 'item_standard', 0),
	('carabineblueprint', 'Progetto e Componenti Carabina Ripetizione', 1, 1, 'item_standard', 0),
	('carbone', 'Carbone', 40, 1, 'item_standard', 0),
	('carote', 'Carote', 20, 1, 'item_standard', 0),
	('caroteseed', 'Seme di Carota', 64, 1, 'item_standard', 1),
	('cattleblueprint', 'Progetto e Componenti Revolver Cattleman', 1, 1, 'item_standard', 0),
	('cepabe', 'Ceppo di Abete', 20, 1, 'item_standard', 0),
	('cepcedr', 'Ceppo di Cedro', 20, 1, 'item_standard', 0),
	('ceppino', 'Ceppo di Pino', 20, 1, 'item_standard', 0),
	('cereali', 'Cereali', 20, 1, 'item_standard', 0),
	('cerealiseed', 'Semi di Cereali', 64, 1, 'item_standard', 1),
	('cheweingtobacco', 'Tabacco da masticare', 5, 1, 'item_standard', 1),
	('chiave', 'Chiave dentro il tuo stomaco', 2, 1, 'item_standard', 0),
	('cigar', 'Sigaro', 5, 1, 'item_standard', 1),
	('cigarette', 'Sigaretta', 10, 1, 'item_standard', 1),
	('cleanshort', 'Olio per Armi', 5, 1, 'item_standard', 1),
	('consumable_acqua', 'Acqua', 5, 1, 'item_standard', 1),
	('consumable_alce', 'Carne di Alce Cotta', 5, 1, 'item_standard', 1),
	('consumable_bluegill', 'Bluegill Grigliato', 5, 1, 'item_standard', 1),
	('consumable_cinghiale', 'Bistecca di Cinghiale', 5, 1, 'item_standard', 1),
	('consumable_coffee', 'Caffe', 5, 1, 'item_standard', 1),
	('consumable_kidneybeans_can', 'Fagioli in Scatola', 5, 1, 'item_standard', 1),
	('consumable_pane', 'Pane', 5, 1, 'item_standard', 1),
	('consumable_peach', 'Pesca', 5, 1, 'item_standard', 1),
	('consumable_salmon_can', 'Salmone in Scatola', 5, 1, 'item_standard', 1),
	('consumable_tacchino', 'Tacchino Cucinato', 5, 1, 'item_standard', 1),
	('corn', 'Mais', 20, 1, 'item_standard', 0),
	('cornseed', 'Semi di Mais', 64, 1, 'item_standard', 1),
	('corpofucile', 'Corpo Fucile', 6, 1, 'item_standard', 0),
	('corpopistola', 'Corpo Pistola', 6, 1, 'item_standard', 0),
	('daiquiri', 'Daiquiri', 5, 1, 'item_standard', 1),
	('dirtywater', 'Acqua Sporca', 15, 1, 'item_standard', 0),
	('dita', 'Dita del tuo corpo', 50, 1, 'item_standard', 1),
	('doublebarrelblueprint', 'Progetto e Componenti Doppietta', 1, 1, 'item_standard', 0),
	('emptybottle', 'Bottiglie Vuote', 15, 1, 'item_standard', 0),
	('fan', 'Ventaglio', 1, 1, 'item_standard', 1),
	('feather', 'Piume', 32, 1, 'item_standard', 0),
	('ferro', 'Lingotti di Ferro', 20, 1, 'item_standard', 0),
	('fiche', 'Fiches', 100, 1, 'item_standard', 0),
	('fishbait', 'Esca', 10, 1, 'item_standard', 1),
	('fungo_mazza', 'Fungo Mazza di Tamburo', 15, 1, 'item_standard', 0),
	('galletta', 'Galletta di riso', 5, 1, 'item_standard', 1),
	('gamba', 'Gamba del tuo corpo', 50, 1, 'item_standard', 1),
	('ginseng_alaska', 'Ginseng dell\'Alaska', 15, 1, 'item_standard', 0),
	('ginseng_americano', 'Ginseng Americano', 15, 1, 'item_standard', 0),
	('goldnugget', 'Pepita d\'Oro', 64, 1, 'item_standard', 0),
	('goldpan', 'Setaccio', 1, 1, 'item_standard', 1),
	('grafite', 'Grafite', 20, 1, 'item_standard', 0),
	('hairpomade', 'Pomata per capelli', 4, 1, 'item_standard', 1),
	('henryblueprint', 'Progetto e Componenti Ripetitore Henry', 1, 1, 'item_standard', 0),
	('indovinello', 'Lettera', 1, 1, 'item_standard', 1),
	('lematblueprint', 'Progetto e Componenti Revolver Lemat', 1, 1, 'item_standard', 0),
	('licenzacaccia', 'Licenza da Cacciatore', 1, 1, 'item_standard', 0),
	('licenzataglie', 'Licenza Cacciatore di Taglie', 1, 1, 'item_standard', 0),
	('licenza_ct', 'Licenza Cacciatore di Taglie', 1, 1, 'item_standard', 0),
	('lingotti', 'Lingotti ', 20, 1, 'item_standard', 0),
	('lingottom', 'Lingotto Marchiato', 35, 1, 'item_standard', 0),
	('listabe', 'Listello di Abete', 40, 1, 'item_standard', 0),
	('listcedr', 'Listello di Cedro', 40, 1, 'item_standard', 0),
	('listpino', 'Listello di Pino', 40, 1, 'item_standard', 0),
	('lockpick', 'Grimaldello', 5, 1, 'item_standard', 1),
	('m1899blueprint', 'Progetto e Componenti Pistola M1988', 1, 1, 'item_standard', 0),
	('magnetite', 'Magnetite', 20, 1, 'item_standard', 0),
	('map1', 'Frammento di mappa', 1, 1, 'item_standard', 1),
	('map2', 'Frammento di mappa', 1, 1, 'item_standard', 1),
	('map3', 'Frammento di mappa', 1, 1, 'item_standard', 1),
	('map4', 'Frammento di mappa', 1, 1, 'item_standard', 1),
	('map5', 'Frammento di mappa', 1, 1, 'item_standard', 1),
	('map6', 'Frammento di mappa', 1, 1, 'item_standard', 1),
	('map7', 'Frammento di mappa', 1, 1, 'item_standard', 1),
	('map8', 'Frammento di mappa', 1, 1, 'item_standard', 1),
	('mappa', 'Mappa Intera', 1, 1, 'item_standard', 1),
	('maschera', 'Maschera d\'Oro', 1, 1, 'item_standard', 0),
	('meat_alce', 'Carne cruda di Alce', 10, 1, 'item_standard', 0),
	('meat_cervo', 'Carne cruda di Cervo', 10, 1, 'item_standard', 0),
	('meat_cinghiale', 'Carne cruda di Cinghiale', 10, 1, 'item_standard', 0),
	('meat_tacchino', 'Carne cruda di Tacchino', 10, 1, 'item_standard', 0),
	('mela', 'Mela', 5, 1, 'item_standard', 1),
	('mojito', 'Mojito', 5, 1, 'item_standard', 1),
	('moonshine_blueflame', 'Moonshine Blue Flame', 10, 1, 'item_standard', 1),
	('moonshine_original', 'Moonshine Original', 10, 1, 'item_standard', 1),
	('moonshine_red', 'Moonshine Red', 10, 1, 'item_standard', 1),
	('newspaper', 'Giornale', 5, 1, 'item_standard', 1),
	('obbligazioni', 'Obbligazioni', 50, 1, 'item_standard', 0),
	('oldfashioned', 'Old Fashioned', 5, 1, 'item_standard', 1),
	('oppio', 'Oppio', 20, 1, 'item_standard', 0),
	('orologio', 'Orologio d\'Oro', 2, 1, 'item_standard', 1),
	('patate', 'Patate', 20, 1, 'item_standard', 1),
	('patateseed', 'Germogli di Patate', 32, 1, 'item_standard', 1),
	('pipe', 'Pipa', 1, 1, 'item_standard', 1),
	('planterspunch', 'Planter\'s Punch', 5, 1, 'item_standard', 1),
	('pocket_watch', 'Orologio da tasca', 1, 1, 'item_standard', 1),
	('pomodori', 'Pomodori', 20, 1, 'item_standard', 0),
	('pomseed', 'Seme di Pomodoro', 64, 1, 'item_standard', 1),
	('p_belladonna', 'Belladonna', 15, 1, 'item_standard', 0),
	('p_oppio', 'Semi di Oppio', 64, 1, 'item_standard', 1),
	('ribes', 'Ribes Dorato', 15, 1, 'item_standard', 0),
	('rocks', 'Pietra Sedimentaria', 20, 1, 'item_standard', 0),
	('rum', 'Rum', 5, 1, 'item_standard', 1),
	('salvia', 'Salvia Coccinea', 15, 1, 'item_standard', 0),
	('schofieldblueprint', 'Progetto e Componenti Revolver Schofield', 1, 1, 'item_standard', 0),
	('semiautoblueprint', 'Progetto e Componenti Pistola Semi-auto', 1, 1, 'item_standard', 0),
	('sidro', 'Sidro di Mele', 5, 1, 'item_standard', 1),
	('siringa', 'Siringa', 10, 1, 'item_standard', 1),
	('snakepoison', 'Veleno di Serpente', 10, 1, 'item_standard', 0),
	('stufatodicarne', 'Stufato di Carne', 5, 1, 'item_standard', 1),
	('stufatodipesce', 'Stufato di Pesce', 5, 1, 'item_standard', 1),
	('sugar', 'Zucchero', 20, 1, 'item_standard', 1),
	('tabacco', 'Old Tabacco da Masticare', 1, 1, 'item_standard', 1),
	('tabacco2', 'Mild Tabacco da Masticare', 1, 1, 'item_standard', 1),
	('tabacco3', 'Gold Tabacco da Masticare', 1, 1, 'item_standard', 1),
	('tiara', 'Tiara', 1, 1, 'item_standard', 0),
	('tonico_aug', 'Estratto della Terra', 2, 1, 'item_standard', 1),
	('tonico_c1', 'Tonico Vita', 5, 1, 'item_standard', 1),
	('tonico_c2', 'Tonico Vita+', 2, 1, 'item_standard', 1),
	('tonico_s1', 'Elysir Energia', 5, 1, 'item_standard', 1),
	('tonico_s2', 'Elysir Energia+', 2, 1, 'item_standard', 1),
	('torta', 'Fetta di Torta', 5, 1, 'item_standard', 1),
	('vaniglia', 'Fiore di Vaniglia', 15, 1, 'item_standard', 0),
	('veleno_s', 'Estratto di Veleno', 2, 1, 'item_standard', 1),
	('vodka', 'Vodka', 5, 1, 'item_standard', 1),
	('vodkamartini', 'Vodka Martini', 5, 1, 'item_standard', 1),
	('volcanicblueprint', 'Progetto e Componenti Pistola Volcanic', 1, 1, 'item_standard', 0),
	('wateringcan', 'Annaffiatoio', 1, 1, 'item_standard', 1),
	('whisky', 'Whiskey', 5, 1, 'item_standard', 1),
	('winchesterblueprint', 'Progetto e Componenti Winchester', 1, 1, 'item_standard', 0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dump della struttura di tabella vorp.loadout
CREATE TABLE IF NOT EXISTS `loadout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `ammo` varchar(255) NOT NULL DEFAULT '{}',
  `components` varchar(255) NOT NULL DEFAULT '[]',
  `dirtlevel` double DEFAULT 0,
  `mudlevel` double DEFAULT 0,
  `conditionlevel` double DEFAULT 0,
  `rustlevel` double DEFAULT 0,
  `used` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1059 DEFAULT CHARSET=utf8mb4;

-- Dump della struttura di tabella vorp.newspaper
CREATE TABLE IF NOT EXISTS `newspaper` (
  `id` text DEFAULT '0',
  `title` text DEFAULT '0',
  `author` text DEFAULT '0',
  `body` text DEFAULT '0',
  `date` text DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella vorp.newspaper: ~0 rows (circa)
/*!40000 ALTER TABLE `newspaper` DISABLE KEYS */;
/*!40000 ALTER TABLE `newspaper` ENABLE KEYS */;

-- Dump della struttura di tabella vorp.outfits
CREATE TABLE IF NOT EXISTS `outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(45) NOT NULL,
  `charidentifier` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `comps` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=420 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


-- Dump della struttura di tabella vorp.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `interiorId` int(11) NOT NULL,
  `inventory` longtext DEFAULT NULL,
  `identifier` varchar(60) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Dump della struttura di tabella vorp.stables
CREATE TABLE IF NOT EXISTS `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `modelname` varchar(70) NOT NULL,
  `type` varchar(11) NOT NULL,
  `status` longtext DEFAULT NULL,
  `xp` int(11) DEFAULT 0,
  `injured` int(11) DEFAULT 0,
  `gear` longtext DEFAULT NULL,
  `isDefault` int(11) NOT NULL DEFAULT 0,
  `inventory` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;


-- Dump della struttura di tabella vorp.telegrams
CREATE TABLE IF NOT EXISTS `telegrams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(50) NOT NULL DEFAULT '0',
  `recipient` varchar(50) NOT NULL,
  `recipientid` varchar(30) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=422 DEFAULT CHARSET=utf8mb4;


-- Dump della struttura di tabella vorp.transactions
CREATE TABLE IF NOT EXISTS `transactions` (
  `bank` varchar(50) DEFAULT NULL,
  `fromIdentifier` varchar(50) DEFAULT NULL,
  `fromcharid` int(11) DEFAULT NULL,
  `toIdentifier` varchar(50) DEFAULT NULL,
  `tocharid` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `money` double(22,2) DEFAULT 0.00,
  `gold` double(22,2) DEFAULT 0.00,
  `reason` varchar(100) DEFAULT NULL,
  `bankto` varchar(50) DEFAULT NULL,
  KEY `FK_transactions_banks` (`bank`),
  KEY `FK_transactions_banks_2` (`bankto`),
  CONSTRAINT `FK_transactions_banks` FOREIGN KEY (`bank`) REFERENCES `banks` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_transactions_banks_2` FOREIGN KEY (`bankto`) REFERENCES `banks` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump della struttura di tabella vorp.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `group` varchar(50) DEFAULT 'user',
  `warnings` int(11) DEFAULT 0,
  `banned` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- Dump della struttura di tabella vorp.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;



/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
