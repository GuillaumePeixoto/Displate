-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 21 déc. 2021 à 15:09
-- Version du serveur : 10.4.21-MariaDB
-- Version de PHP : 8.0.12

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
(10, 'Design');

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
(1, 'moi', 'oulala', '2021-12-16 15:08:16', 1);

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
(3, 65, 'L', 41, 64);

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
(9, 'naruto-sasuke - 61c19da118694.jpg', 'Naruto et Sasuke à la vallée de la fin', 'Naruto et Sasuke à la vallée de la fin', 6),
(10, 'onepiece-luffy-kaido - 61c19dbcc3039.png', 'Luffy & Kaido', 'Luffy & Kaido Fan Art', 6);

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
(9, 3),
(9, 5),
(9, 7),
(10, 3),
(10, 6);

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
(9, 1),
(9, 3),
(10, 3);

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
(10, 'user1@gmail.com', '[]', '$2y$13$OvgRiVaNz8emSuVPbM0m5OUlIEhHWf5OVpYcD1AzXaV3iDiNrEgr2', 'User1', 'User1', 'User1', 'User1', 'User1', 78200, NULL, NULL, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_67F068BCF347EFB` (`produit_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `commentaire`
--
ALTER TABLE `commentaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `format`
--
ALTER TABLE `format`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `produit`
--
ALTER TABLE `produit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `FK_67F068BCF347EFB` FOREIGN KEY (`produit_id`) REFERENCES `produit` (`id`);

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
