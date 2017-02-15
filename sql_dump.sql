-- phpMyAdmin SQL Dump
--
-- Generation Time: Feb 15, 2017 at 07:39 PM

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `thesis`
--

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `creator_id` int(10) NOT NULL,
  `create_time` datetime NOT NULL,
  `text` text COLLATE utf8_bin NOT NULL,
  `priority` tinyint(1) NOT NULL DEFAULT '3',
  `is_public` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=841 ;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `creator_id`, `create_time`, `text`, `priority`, `is_public`) VALUES
  (839, 1, '2017-02-15 00:00:00', 'I did something great today!', 1, 1),
  (840, 11, '2017-02-15 00:00:00', 'Marvin told me that he did something great today...', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) COLLATE utf8_bin NOT NULL,
  `first_name` varchar(32) COLLATE utf8_bin NOT NULL,
  `last_name` varchar(32) COLLATE utf8_bin NOT NULL,
  `password` varchar(255) COLLATE utf8_bin NOT NULL,
  `avatar_name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=12 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `first_name`, `last_name`, `password`, `avatar_name`, `is_admin`) VALUES
  (1, 'Marvin', 'Marvin', 'Wyrich', '$2y$10$8WmuUCXzslGRcEm8nGG5HeAn58SxUCZ99shT79QSmBtqTR2X8xmpC', NULL, 1),
  (11, 'Ivan', 'Ivan', 'Bogicevic', '$2y$10$8WmuUCXzslGRcEm8nGG5HeAn58SxUCZ99shT79QSmBtqTR2X8xmpC', 'avatar_10.png', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
