-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.2.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for dir
CREATE DATABASE IF NOT EXISTS `dir` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `dir`;

-- Dumping structure for table dir.bonds
CREATE TABLE IF NOT EXISTS `bonds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `definitive_code` char(9) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table dir.definitives
CREATE TABLE IF NOT EXISTS `definitives` (
  `code` char(9) NOT NULL,
  `placer_id` int(11) unsigned NOT NULL,
  `place_date` datetime NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `vehicle_id` int(11) unsigned NOT NULL,
  `temporary_code` char(4) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `FK_definitives_users` (`placer_id`),
  KEY `FK_definitives_players` (`owner_id`),
  KEY `FK_definitives_vehicles` (`vehicle_id`),
  CONSTRAINT `FK_definitives_players` FOREIGN KEY (`owner_id`) REFERENCES `players` (`id`),
  CONSTRAINT `FK_definitives_users` FOREIGN KEY (`placer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_definitives_vehicles` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table dir.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` int(10) unsigned NOT NULL,
  `last_name` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table dir.pound
CREATE TABLE IF NOT EXISTS `pound` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `definitive_code` char(9) DEFAULT NULL,
  `temporary_code` char(4) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `vehicle_id` int(10) unsigned NOT NULL,
  `reason` text DEFAULT NULL,
  `place` text DEFAULT NULL,
  `comments` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pound_definitives` (`definitive_code`),
  KEY `FK_pound_temporaries` (`temporary_code`),
  KEY `FK_pound_vehicles` (`vehicle_id`),
  CONSTRAINT `FK_pound_definitives` FOREIGN KEY (`definitive_code`) REFERENCES `definitives` (`code`),
  CONSTRAINT `FK_pound_temporaries` FOREIGN KEY (`temporary_code`) REFERENCES `temporaries` (`code`),
  CONSTRAINT `FK_pound_vehicles` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table dir.sales
CREATE TABLE IF NOT EXISTS `sales` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `definitive_code` char(9) NOT NULL,
  `date` datetime DEFAULT NULL,
  `buyer_id` int(11) unsigned DEFAULT NULL,
  `price` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_sales_definitives` (`definitive_code`),
  KEY `FK_sales_players` (`buyer_id`),
  CONSTRAINT `FK_sales_definitives` FOREIGN KEY (`definitive_code`) REFERENCES `definitives` (`code`),
  CONSTRAINT `FK_sales_players` FOREIGN KEY (`buyer_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table dir.temporaries
CREATE TABLE IF NOT EXISTS `temporaries` (
  `code` char(4) NOT NULL,
  `placer_id` int(11) unsigned NOT NULL,
  `place_date` datetime NOT NULL,
  `owner_id` int(11) unsigned NOT NULL,
  `vehicle_id` int(11) unsigned NOT NULL,
  `duration` int(11) unsigned NOT NULL,
  `comment` text DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `FK_temporaries_users` (`placer_id`),
  KEY `FK_temporaries_players` (`owner_id`),
  KEY `FK_temporaries_vehicles` (`vehicle_id`),
  CONSTRAINT `FK_temporaries_players` FOREIGN KEY (`owner_id`) REFERENCES `players` (`id`),
  CONSTRAINT `FK_temporaries_users` FOREIGN KEY (`placer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_temporaries_vehicles` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table dir.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `player_id` int(11) unsigned NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_users_players` (`player_id`),
  CONSTRAINT `FK_users_players` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table dir.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vehicle_type_id` int(10) unsigned NOT NULL,
  `color` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_vehicles_vehicle_types` (`vehicle_type_id`),
  CONSTRAINT `FK_vehicles_vehicle_types` FOREIGN KEY (`vehicle_type_id`) REFERENCES `vehicle_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
-- Dumping structure for table dir.vehicle_types
CREATE TABLE IF NOT EXISTS `vehicle_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `brand` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `price` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
