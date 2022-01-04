-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 03 jan. 2022 à 14:58
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `displate`
--

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categorie`
--

INSERT INTO `categorie` (`id`, `titre`) VALUES
(3, 'Anime'),
(5, 'Naruto'),
(6, 'Japon'),
(7, 'Combat'),
(8, 'Film'),
(9, 'Retro'),
(10, 'Design'),
(11, 'Nature'),
(12, 'Voiture'),
(13, 'Neon'),
(14, 'Jeu vidéo'),
(15, 'Réaliste'),
(16, 'Futur'),
(17, 'Espace'),
(18, 'Peinture'),
(19, 'cartoon'),
(20, 'Demon'),
(21, 'Divinité');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `montant` double NOT NULL,
  `date_commande` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commande`
--

INSERT INTO `commande` (`id`, `user_id`, `montant`, `date_commande`) VALUES
(7, 6, 130, '2021-12-27 12:35:50'),
(8, 6, 80, '2021-12-27 16:39:35'),
(9, 6, 105, '2021-12-27 16:52:07'),
(12, 6, 80, '2021-12-28 12:09:36'),
(13, 9, 105, '2021-12-28 12:13:01'),
(15, 6, 40, '2021-12-31 23:34:18'),
(16, 6, 40, '2022-01-01 15:19:29'),
(17, 11, 65, '2022-01-01 15:22:45'),
(18, 6, 65, '2022-01-03 09:05:29'),
(19, 15, 170, '2022-01-03 11:53:07');

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `id` int(11) NOT NULL,
  `auteur` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `commentaire` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` datetime NOT NULL,
  `produit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commentaire`
--

INSERT INTO `commentaire` (`id`, `auteur`, `commentaire`, `date`, `produit_id`) VALUES
(1, 'moi', 'oulala', '2021-12-16 15:08:16', 1),
(3, 'Vendeur3 Vendeur3', 'Je test', '2022-01-01 15:04:11', 1),
(4, 'Vendeur3 Vendeur3', 'Il est incroyable', '2022-01-01 15:23:13', 1);

-- --------------------------------------------------------

--
-- Structure de la table `details_commande`
--

CREATE TABLE `details_commande` (
  `id` int(11) NOT NULL,
  `produit_id` int(11) NOT NULL,
  `format_id` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  `prix` double NOT NULL,
  `commande_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `details_commande`
--

INSERT INTO `details_commande` (`id`, `produit_id`, `format_id`, `quantite`, `prix`, `commande_id`) VALUES
(3, 12, 3, 2, 130, 7),
(4, 2, 1, 1, 40, 8),
(5, 5, 1, 1, 40, 9),
(6, 5, 1, 1, 40, 12),
(7, 2, 1, 1, 40, 12),
(8, 13, 3, 1, 65, 13),
(9, 13, 1, 1, 40, 13),
(11, 5, 1, 1, 40, 15),
(12, 1, 1, 1, 40, 16),
(13, 1, 3, 1, 65, 17),
(14, 12, 3, 1, 65, 18),
(15, 1, 3, 2, 130, 19),
(16, 1, 1, 1, 40, 19);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20211215090441', '2021-12-15 10:54:14', 92);

-- --------------------------------------------------------

--
-- Structure de la table `format`
--

CREATE TABLE `format` (
  `id` int(11) NOT NULL,
  `prix` double NOT NULL,
  `format` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `largeur` double NOT NULL,
  `hauteur` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `format`
--

INSERT INTO `format` (`id`, `prix`, `format`, `largeur`, `hauteur`) VALUES
(1, 40, 'M', 32, 45),
(3, 65, 'L', 41, 64),
(10, 130, 'XL', 64, 90);

-- --------------------------------------------------------

--
-- Structure de la table `produit`
--

CREATE TABLE `produit` (
  `id` int(11) NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `titre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `produit`
--

INSERT INTO `produit` (`id`, `photo`, `titre`, `description`, `user_id`) VALUES
(1, 'vegeto-ssj-blue - 61b9ce5cf3861.jpg', 'Vegeto Super Sayan Blue', 'Fan Art de Vegeto SSJ Blue', 5),
(2, 'naruto-sasuke - 61b9f3922106a.jpg', 'Naruto et Sasuke', 'Fan Art de Naruto et Sasuke à la vallée de la fin', 5),
(5, 'Itachi - 61c0570107679.png', 'Itachi Uchiwa', 'Itachi Uchiwa', 6),
(6, 'itachi-peinture - 61c05718f3c81.png', 'Itachi Uchiwa (Peinture)', 'Itachi Uchiwa (Peinture)', 6),
(10, 'onepiece-luffy-kaido - 61c19dbcc3039.png', 'Luffy & Kaido', 'Luffy & Kaido Fan Art', 6),
(11, 'one-piece-ocean - 61c731ca0290f.png', 'Fusion Tableau One Piece', 'Fusion Tableau One Piece', 6),
(12, 'itachi-sasuke - 61c7364132d7d.png', 'Itachi et Sasuke', 'Itachi et Sasuke', 6),
(13, 'renard-3d - 61c7374bef51f.png', 'Renard Style 3D', 'Renard 3D', 6),
(15, 'skyline - 61d055020934a.png', 'Skyline GTR', 'Skyline GTR', 11),
(16, 'supra-rose - 61d055242ca89.png', 'Toyota Supra', 'Toyota Supra', 11),
(17, 'urahara - 61d05541131fe.png', 'Urahara Bleach', 'Urahara Bleach', 11),
(18, 'tanjiro-fanart - 61d05571c21b8.png', 'Tanjiro Kamado FanArt', 'Tanjiro Kamado FanArt de Demon Slayer', 11),
(19, 'itachi - 61d05599769e2.png', 'Fan Art Itachi Uchiwa', 'Fan Art Itachi Uchiwa / Symbole Uchiwa', 11),
(20, 'alexander-j-the-sentinel - 61d2b60e4f8b8.jpg', 'Base Spatiale', 'Base Spatiale ( style star wars )', 13),
(21, 'alexander-j-original-copia - 61d2b7653ab0e.jpg', 'The Origin ( peinture )', 'The Origin ( peinture )', 13),
(22, 'alexander-j-last-discussion - 61d2b81fc82ef.jpg', 'Base spatial futuriste', 'Base spatial futuriste ( style star wars )', 13),
(23, 'alexander-j-laciudadsinnombre5 - 61d2b85454fa7.jpg', 'La ciudad sin nombre', 'La ciudad sin nombre', 13),
(24, 'alexander-j-laciudadsinnombre4 - 61d2b8a453598.jpg', 'La ciudad sin nombre 2', 'La ciudad sin nombre 2', 13),
(25, 'alexander-j-laciudadsinnombre2 - 61d2b8b4e75fc.jpg', 'La ciudad sin nombre 3', 'La ciudad sin nombre 3', 13),
(26, 'alexander-j-laciudadsinnombre1 - 61d2b8c86c61a.jpg', 'La ciudad sin nombre 4', 'La ciudad sin nombre 4', 13),
(27, 'alexander-j-frozen-planet - 61d2b94ff1934.jpg', 'Planete gelée', 'Planete gelée', 13),
(28, 'alexander-j-alexander-j-la-ciudx-sin-nombre-0102 - 61d2b98208669.jpg', 'Space Cube', 'Space Cube', 13),
(29, 'alexander-j-alexander-j-la-ciudx-sin-nombre-0101 - 61d2b9a0d9de5.jpg', 'Space Orbe', 'Space Orb', 13),
(30, 'amir-zand-x-uplox - 61d2ba5d235bd.jpg', 'Uplox colony', 'Uplox colony', 14),
(31, 'amir-zand-x - 61d2bad98a774.jpg', 'Frozen earth', 'Frozen earth', 14),
(32, 'amir-zand-uplox - 61d2bf52c9641.jpg', 'Desertic planet', 'Desertic planet', 14),
(33, 'amir-zand-uplox-1 - 61d2c0aac6688.jpg', 'Prism Planet', 'Prism Planet', 14),
(34, 'amir-zand-still - 61d2c12d712b9.jpg', 'War Sanctuary', 'War Sanctuary', 14),
(35, 'amir-zand-rocksartstation - 61d2c16e725e6.jpg', 'RockSarStation', 'RockSarStation', 14),
(36, 'amir-zand-pinkish-artstation - 61d2c1df3ecaa.jpg', 'Pinkish Art Station', 'Pinkish Art Station', 14),
(37, 'amir-zand-passage280 - 61d2c52b4df27.jpg', 'Road River', 'Road River', 14),
(38, 'amir-zand-msd13up - 61d2c583c2b00.jpg', 'Cavalier Seul', 'Cavalier Seul', 14),
(39, 'amir-zand-msd8-2post - 61d2c63971097.jpg', 'Frozen Boat', 'Frozen Boat', 14),
(40, 'amir-zand-monumentuplox - 61d2cd6dc3094.jpg', 'Mystic cube', 'Mystic cube', 14),
(41, 'amir-zand-lonelyrock2 - 61d2cdb7dafc5.jpg', 'Lonely Rock', 'Lonely Rock', 14),
(42, 'amir-zand-lastsunset - 61d2cdda99770.jpg', 'Last Sunset', 'Last Sunset', 14),
(43, 'amir-zand-insta-2 - 61d2ce078b402.jpg', 'Levitation Rock', 'Levitation Rock', 14),
(44, 'amir-zand-insta01 - 61d2ce36e2859.jpg', '3 Memory Plates', '3 Memory Plates', 14),
(45, 'amir-zand-grimdarkup2 - 61d2cea4cf0bf.jpg', 'Lonely Castle', 'Lonely Castle', 14),
(46, 'amir-zand-artstation-1 - 61d2cef1625af.jpg', 'Final Dungeon', 'Final Dungeon', 14),
(47, 'amir-zand-07-masks - 61d2d14aa729a.jpg', 'New Neo Japan', 'New Neo Japan', 14),
(48, 'anato-finnstark-3 - 61d2d6f7efcd6.jpg', 'Lavasioth-rex', 'Lavasioth-rex', 15),
(49, 'anato-finnstark-3d11f1aa860072b5f79b7eafc33ce09a-god-59 - 61d2d794af4d2.jpg', 'White Whole', 'White Whole', 15),
(50, 'anato-finnstark-anato-finnstark-anato-finnstark-between-light-and-darkness-batman-by-anatofinnstark-dd05nkl-fullview - 61d2d7e18ea42.jpg', 'Batman Demon', 'Batman Demon Fan Art', 15),
(51, 'anato-finnstark-anato-finnstark-skiroooo - 61d2d8117971f.jpg', 'Winter Wood', 'Winter Wood', 15),
(52, 'anato-finnstark-anato-finnstark-the-tiger-s-gate-by-anatofinnstark-dcx21ul-fullview - 61d2d83b72c80.jpg', 'Oni Samurai', 'Oni Samurai', 15),
(53, 'anato-finnstark-anato-finnstark-web-petit - 61d2d8717ee09.jpg', 'Batman Archange', 'Batman Archange', 15),
(54, 'anato-finnstark-anato-finnstark-web-petit-3 - 61d2d89ab3f36.jpg', 'Demon Stag', 'Demon Stag', 15),
(55, 'anato-finnstark-anato-finnstark-web-petit-4 - 61d2d8ed3ff86.jpg', 'Gandalf Jedi', 'Gandalf Jedi', 15),
(56, 'anato-finnstark-anato-finnstark-web-petit-6 - 61d2d9cc200e7.jpg', 'Kayle Angel', 'Kayle Angel', 15),
(57, 'anato-finnstark-anato-finnstark-web-pti-bat - 61d2da098ca85.jpg', 'The Batman', 'The Batman', 15),
(58, 'anato-finnstark-anato-finnstark-yharnam-2-bloodborne-by-anatofinnstark-ddaeqh8-fullview - 61d2da3baf913.jpg', 'Demon Castle', 'Demon Castle', 15),
(59, 'anato-finnstark-berserk - 61d2da6b0808d.jpg', 'War Sanctuary', 'War Sanctuary', 15),
(60, 'anato-finnstark-cover-6 - 61d2dae9163c4.jpg', 'Geralt execution', 'Geralt execution', 15),
(61, 'anato-finnstark-dd6t2du-37e12969-f8bd-4765-b17c-a3a1f067df08 - 61d2db24f19d4.jpg', 'Sakura Dragon', 'Sakura Dragon', 15),
(62, 'anato-finnstark-berserk0123 - 61d2db4d750e2.jpg', 'Geralt Riv', 'Geralt Riv', 15),
(63, 'anato-finnstark-cover-3-final - 61d2dba79e774.jpg', 'Geralt Zombie', 'Geralt Zombie', 15),
(64, 'anato-finnstark-deer - 61d2e32958d17.jpg', 'Flame Stag', 'Flame Stag', 15),
(65, 'anato-finnstark-hatred - 61d2e35e13efc.jpg', 'Demon VS Samurai', 'Demon VS Samurai', 15),
(66, 'anato-finnstark-home-bnf - 61d2e3a7a023f.jpg', 'Dragon Giant', 'Dragon Giant', 15),
(67, 'anato-finnstark-howl - 61d2e40d349ac.jpg', 'Giant Owl Samurai', 'Giant Owl Samurai', 15),
(68, 'anato-finnstark-knight-petit-web - 61d2e45631800.jpg', 'Lonely cavalery', 'Lonely cavalery', 15),
(69, 'anato-finnstark-monk - 61d2e7c909946.jpg', 'Demon vs Samurai', 'Demon vs Samurai', 15),
(70, 'anato-finnstark-petit-web - 61d2e8426f517.jpg', 'Thresh absorbing soul', 'Thresh absorbing soul', 15),
(71, 'anato-finnstark-sekiro-dragon-s-blood-by-anatofinnstark-dd6ng9p-fullview - 61d2e86e00449.jpg', 'Dragon vs Samurai', 'Dragon vs Samurai', 15),
(72, 'anato-finnstark-snakefinnal-2 - 61d2e8cf3e099.jpg', 'Viper Giant', 'Viper Giant', 15),
(73, 'anato-finnstark-the-king-s-journey-the-great-celestials-by-anatofinnstark-dd3wzvs-fullview - 61d2e91084e80.jpg', 'Giant Swan', 'Giant Swan', 15),
(74, 'anato-finnstark-the-king-s-journey-the-remains-of-the-past-by-anatofinnstark-dcyyeke-fullview - 61d2e9587310c.jpg', 'Warriors Valley', 'Warriors Valley', 15),
(75, 'anato-finnstark-web-petit-1 - 61d2e9b649e74.jpg', 'Giant Stag', 'Giant Stag', 15),
(76, 'anato-finnstark-web-petit-14 - 61d2ea084402c.jpg', 'Dragon Rage', 'Dragon Rage', 15);

-- --------------------------------------------------------

--
-- Structure de la table `produit_categorie`
--

CREATE TABLE `produit_categorie` (
  `produit_id` int(11) NOT NULL,
  `categorie_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `produit_categorie`
--

INSERT INTO `produit_categorie` (`produit_id`, `categorie_id`) VALUES
(1, 3),
(1, 7),
(2, 3),
(2, 5),
(2, 6),
(2, 7),
(5, 3),
(5, 5),
(6, 3),
(6, 5),
(10, 3),
(10, 6),
(11, 3),
(11, 6),
(12, 3),
(12, 5),
(13, 10),
(15, 12),
(16, 12),
(17, 3),
(18, 3),
(18, 7),
(19, 3),
(19, 5),
(20, 8),
(20, 16),
(20, 17),
(21, 18),
(22, 8),
(22, 16),
(22, 17),
(23, 18),
(24, 18),
(25, 18),
(26, 18),
(27, 8),
(27, 17),
(28, 16),
(28, 17),
(29, 16),
(29, 17),
(30, 16),
(30, 17),
(30, 19),
(31, 17),
(31, 18),
(32, 16),
(32, 17),
(33, 16),
(33, 17),
(34, 7),
(34, 18),
(35, 18),
(36, 17),
(36, 19),
(37, 16),
(37, 17),
(37, 18),
(38, 14),
(38, 15),
(38, 18),
(39, 19),
(40, 16),
(40, 18),
(41, 15),
(41, 18),
(42, 16),
(42, 17),
(42, 19),
(43, 14),
(43, 17),
(43, 19),
(44, 15),
(44, 16),
(44, 17),
(45, 19),
(46, 16),
(46, 19),
(47, 6),
(47, 16),
(47, 19),
(48, 7),
(48, 14),
(48, 19),
(49, 6),
(49, 18),
(50, 8),
(50, 14),
(50, 19),
(51, 11),
(51, 18),
(52, 6),
(52, 7),
(52, 18),
(53, 8),
(53, 14),
(53, 19),
(54, 18),
(55, 8),
(55, 14),
(55, 20),
(56, 18),
(56, 21),
(57, 8),
(57, 14),
(58, 18),
(58, 20),
(59, 7),
(59, 18),
(60, 8),
(60, 14),
(60, 20),
(61, 6),
(61, 7),
(61, 18),
(62, 8),
(62, 14),
(63, 8),
(63, 14),
(63, 20),
(64, 18),
(64, 20),
(65, 7),
(65, 18),
(66, 11),
(66, 18),
(67, 6),
(67, 11),
(67, 18),
(68, 7),
(68, 18),
(69, 7),
(69, 18),
(69, 20),
(70, 14),
(70, 18),
(70, 20),
(71, 6),
(71, 7),
(71, 18),
(72, 6),
(72, 18),
(72, 21),
(73, 6),
(73, 11),
(73, 18),
(74, 11),
(74, 18),
(74, 21),
(75, 11),
(75, 18),
(75, 21),
(76, 7),
(76, 18);

-- --------------------------------------------------------

--
-- Structure de la table `produit_format`
--

CREATE TABLE `produit_format` (
  `produit_id` int(11) NOT NULL,
  `format_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `produit_format`
--

INSERT INTO `produit_format` (`produit_id`, `format_id`) VALUES
(1, 1),
(1, 3),
(2, 1),
(5, 1),
(5, 3),
(6, 3),
(10, 3),
(11, 1),
(12, 1),
(12, 3),
(12, 10),
(13, 1),
(13, 3),
(15, 3),
(15, 10),
(16, 10),
(17, 1),
(17, 3),
(17, 10),
(18, 1),
(18, 3),
(18, 10),
(19, 3),
(19, 10),
(20, 1),
(20, 3),
(20, 10),
(21, 1),
(21, 3),
(21, 10),
(22, 1),
(22, 10),
(23, 3),
(23, 10),
(24, 3),
(25, 10),
(26, 1),
(26, 10),
(27, 10),
(28, 1),
(28, 3),
(29, 1),
(29, 3),
(30, 1),
(30, 3),
(31, 1),
(31, 3),
(32, 1),
(32, 3),
(33, 1),
(33, 3),
(33, 10),
(34, 1),
(34, 3),
(34, 10),
(35, 3),
(36, 3),
(37, 3),
(37, 10),
(38, 1),
(38, 3),
(39, 3),
(39, 10),
(40, 3),
(40, 10),
(41, 1),
(41, 3),
(42, 3),
(42, 10),
(43, 10),
(44, 1),
(45, 1),
(46, 1),
(46, 3),
(47, 3),
(47, 10),
(48, 1),
(48, 3),
(49, 3),
(50, 1),
(50, 10),
(51, 1),
(51, 3),
(52, 3),
(52, 10),
(53, 3),
(54, 1),
(55, 10),
(56, 3),
(57, 1),
(57, 3),
(58, 3),
(59, 10),
(60, 10),
(61, 3),
(61, 10),
(62, 1),
(62, 3),
(63, 3),
(63, 10),
(64, 3),
(64, 10),
(65, 1),
(65, 3),
(66, 3),
(66, 10),
(67, 3),
(68, 1),
(69, 3),
(69, 10),
(70, 1),
(70, 3),
(71, 1),
(71, 10),
(72, 1),
(72, 3),
(73, 1),
(73, 3),
(74, 3),
(75, 3),
(76, 1);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pseudo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ville` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_postal` int(11) NOT NULL,
  `image_profil` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banniere_profil` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `prenom`, `nom`, `pseudo`, `adresse`, `ville`, `code_postal`, `image_profil`, `banniere_profil`, `description`) VALUES
(5, 'test@gmail.com', '[\"ROLE_USER\",\"ROLE_VENDEUR\",\"ROLE_ADMIN\"]', '$2y$13$fbrULJxIiSeDcVZeFtXC5.hcLo9r7KZbO97YJGS7wwDeWv6O9IRUa', 'test', 'test', 'test', 'test', 'test', 78200, NULL, NULL, NULL),
(6, 'admin@gmail.com', '[\"ROLE_USER\",\"ROLE_VENDEUR\",\"ROLE_ADMIN\"]', '$2y$13$2vysTUuiRBgbZCW5wF1pNeBE5NegDWxrHcTZ.3ve4ulosIGQzXpsq', 'Admin', 'Admin', 'Admin', 'Admin', 'Admin', 78200, 'profil-test - 61c1a8ace013f.png', 'banniere-admin - 61c1a8ace0909.png', 'Ceci est un test'),
(7, 'vendeur@gmail.com', '[\"ROLE_USER\",\"ROLE_VENDEUR\"]', '$2y$13$sQA78usBNNCp0mShgk5K4OpHF.q3CSbgnfXBIGJB06/nSAjMEXzQa', 'vendeur', 'vendeur', 'vendeur', 'vendeur', 'vendeur', 78200, 'profil-test - 61c0a6f9d703b.png', 'banniere-test - 61c09a37a2f5b.png', 'J\'aime bien testé'),
(8, 'fpadmin@gmail.com', '[\"ROLE_VENDEUR\"]', '$2y$13$bN5v4ASCUgAu7BO5951dwu.ERzEFU4Hjiu8IxZhuCTb2ipkKq9BBa', 'FPNumeroUno', 'FPNumeroUno', 'FPNumeroUno', 'FPNumeroUno', 'FPNumeroUno', 78200, NULL, NULL, NULL),
(9, 'vendeur2@gmail.com', '[\"ROLE_USER\",\"ROLE_VENDEUR\"]', '$2y$13$96Qd8jq6.oqOLA8PKLTvoeosBDmw/yN3rDOTxBHRWWHxHfuwwjHGm', 'vendeur2', 'vendeur2', 'vendeur2', 'vendeur2', 'vendeur2', 78200, 'kirua - 61c1a363bd98e.jpg', NULL, NULL),
(10, 'user1@gmail.com', '[]', '$2y$13$OvgRiVaNz8emSuVPbM0m5OUlIEhHWf5OVpYcD1AzXaV3iDiNrEgr2', 'User1', 'User1', 'User1', 'User1', 'User1', 78200, NULL, NULL, NULL),
(11, 'vendeur3@gmail.com', '[\"ROLE_USER\",\"ROLE_VENDEUR\"]', '$2y$13$KE3rexPIGdfO6v1pAQre7eoBy3Mz5zOBC0Iy8bCQVu7QyryOwF6Fa', 'Vendeur3', 'Vendeur3', 'Vendeur3', 'Vendeur3', 'Vendeur3', 78200, NULL, 'unohana - 61d0570b2885c.png', 'Vendeur3Vendeur3Vendeur3'),
(12, 'client1@gmail.com', '[]', '$2y$13$L6J/Zk568SLp7PDgGJGYHuwTR2VUehLmsiFNlBb3Gj63d.tzC3z1S', 'client1', 'client1', 'client1', 'client1', 'client1', 78200, NULL, NULL, NULL),
(13, 'alexander.junior@gmail.com', '[\"ROLE_USER\",\"ROLE_VENDEUR\"]', '$2y$13$1185LQTcOioZ0jie8t7Ju.LPE4XXyed0qFzwvS80hZxA9HxDxv.0q', 'Alexander', 'Junior', 'Alexander Jr', 'Alexander Jr', 'Alexander Jr', 92000, 'profil - 61d2b5be533e9.jpg', 'banniere - 61d2b5be53c58.png', NULL),
(14, 'amirzand@gmail.com', '[\"ROLE_USER\",\"ROLE_VENDEUR\"]', '$2y$13$3D0xFHyE4stoh1RP/VI7Me9rwpe4WUnpG8VDiK0rsPMRbCBX6.Ahu', 'Amir', 'Zand', 'AmirZand', 'amirzand', 'amirzand', 13000, 'profil - 61d2b9f45d00d.jpg', 'banniere - 61d2b9f45d8a9.png', NULL),
(15, 'anatofinnstark@gmail.com', '[\"ROLE_USER\",\"ROLE_VENDEUR\"]', '$2y$13$T4sdxpvPHw/mNn8zIwBilub.UqjzdnlZpNFc1cICymTX7qQH9SF5u', 'Anato', 'Finnstark', 'AnatoFinnstark', 'AnatoFinnstark', 'AnatoFinnstark', 75000, 'profil - 61d2d37701fb1.jpg', 'banniere - 61d2d3770286d.png', 'Fan of Japan Style');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6EEAA67DA76ED395` (`user_id`);

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_67F068BCF347EFB` (`produit_id`);

--
-- Index pour la table `details_commande`
--
ALTER TABLE `details_commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_4BCD5F682EA2E54` (`commande_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `format`
--
ALTER TABLE `format`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `produit`
--
ALTER TABLE `produit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_29A5EC27A76ED395` (`user_id`);

--
-- Index pour la table `produit_categorie`
--
ALTER TABLE `produit_categorie`
  ADD PRIMARY KEY (`produit_id`,`categorie_id`),
  ADD KEY `IDX_CDEA88D8F347EFB` (`produit_id`),
  ADD KEY `IDX_CDEA88D8BCF5E72D` (`categorie_id`);

--
-- Index pour la table `produit_format`
--
ALTER TABLE `produit_format`
  ADD PRIMARY KEY (`produit_id`,`format_id`),
  ADD KEY `IDX_29E8B9E5F347EFB` (`produit_id`),
  ADD KEY `IDX_29E8B9E5D629F605` (`format_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `commentaire`
--
ALTER TABLE `commentaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `details_commande`
--
ALTER TABLE `details_commande`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `format`
--
ALTER TABLE `format`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `FK_6EEAA67DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `FK_67F068BCF347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`);

--
-- Contraintes pour la table `details_commande`
--
ALTER TABLE `details_commande`
  ADD CONSTRAINT `FK_4BCD5F682EA2E54` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`);

--
-- Contraintes pour la table `produit`
--
ALTER TABLE `produit`
  ADD CONSTRAINT `FK_29A5EC27A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `produit_categorie`
--
ALTER TABLE `produit_categorie`
  ADD CONSTRAINT `FK_CDEA88D8BCF5E72D` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_CDEA88D8F347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `produit_format`
--
ALTER TABLE `produit_format`
  ADD CONSTRAINT `FK_29E8B9E5D629F605` FOREIGN KEY (`format_id`) REFERENCES `format` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_29E8B9E5F347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
