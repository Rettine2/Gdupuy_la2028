-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : lun. 14 sep. 2026 à 12:17
-- Version du serveur : 11.4.9-MariaDB
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `la2028`
--

-- --------------------------------------------------------

--
-- Structure de la table `athlete`
--

DROP TABLE IF EXISTS `athlete`;
CREATE TABLE IF NOT EXISTS `athlete` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(25) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `date_naissance` date NOT NULL,
  `pays_id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_ath_pays` (`pays_id`) USING BTREE,
  KEY `fk_ath_sport` (`sport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `athlete`
--

INSERT INTO `athlete` (`id`, `prenom`, `nom`, `date_naissance`, `pays_id`, `sport_id`) VALUES
(1, 'Teddy', 'Rinner', '1989-04-07', 1, 11),
(2, 'Simone', 'Biles', '1997-03-14', 2, 8);

-- --------------------------------------------------------

--
-- Structure de la table `epreuve`
--

DROP TABLE IF EXISTS `epreuve`;
CREATE TABLE IF NOT EXISTS `epreuve` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `athlete_id` int(11) NOT NULL,
  `sport_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_ath_athlete` (`athlete_id`),
  KEY `fk_ath_sport_epreuve` (`sport_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `epreuve`
--

INSERT INTO `epreuve` (`id`, `nom`, `athlete_id`, `sport_id`) VALUES
(1, '1 versus 1 ', 1, 11),
(2, 'showoff', 2, 8);

-- --------------------------------------------------------

--
-- Structure de la table `pays`
--

DROP TABLE IF EXISTS `pays`;
CREATE TABLE IF NOT EXISTS `pays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Code` varchar(3) NOT NULL,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `pays`
--

INSERT INTO `pays` (`id`, `Code`, `nom`) VALUES
(1, 'FRA', 'France'),
(2, 'USA', 'Etats-Unis'),
(3, 'ALB', 'Albania'),
(4, 'ALG', 'Algeria'),
(5, 'GER', 'Germany'),
(6, 'AND', 'Andorra'),
(7, 'ANG', 'Angola'),
(8, 'ANT', 'Antigua and Barbuda'),
(9, 'AHO', 'Netherlands Antilles'),
(10, 'KSA', 'Saudi Arabia'),
(11, 'ARG', 'Argentina'),
(12, 'ARM', 'Armenia'),
(13, 'ARU', 'Aruba'),
(14, 'AUS', 'Australia'),
(15, 'AUT', 'Austria'),
(16, 'AZE', 'Azerbaijan'),
(17, 'BAH', 'Bahamas'),
(18, 'BRN', 'Bahrain'),
(19, 'BAN', 'Bangladesh'),
(20, 'BAR', 'Barbados'),
(21, 'BLR', 'Belarus'),
(22, 'BEL', 'Belgium'),
(23, 'BIZ', 'Belize'),
(24, 'BEN', 'Benin'),
(25, 'BER', 'Bermuda'),
(26, 'BHU', 'Bhutan'),
(27, 'BOL', 'Bolivia'),
(28, 'BIH', 'Bosnia and Herzegovina'),
(29, 'BOT', 'Botswana'),
(30, 'BRA', 'Brazil'),
(31, 'BRU', 'Brunei Darussalam'),
(32, 'BUL', 'Bulgaria'),
(33, 'BUR', 'Burkina Faso'),
(34, 'BDI', 'Burundi'),
(35, 'CAY', 'Cayman Islands'),
(36, 'CAM', 'Cambodia'),
(37, 'CMR', 'Cameroon'),
(38, 'CAN', 'Canada'),
(39, 'CPV', 'Cape Verde'),
(40, 'CAF', 'Central African Republic'),
(41, 'CHI', 'Chile'),
(42, 'CHN', 'People\'s Republic of China'),
(43, 'CYP', 'Cyprus'),
(44, 'COL', 'Colombia'),
(45, 'COM', 'Comoros'),
(46, 'CGO', 'Congo'),
(47, 'COD', 'Democratic Republic of the Congo'),
(48, 'COK', 'Cook Islands'),
(49, 'KOR', 'Republic of Korea'),
(50, 'ANZ', 'Australasia (1908-1912)'),
(51, 'BOH', 'Bohemia (TCH since 1920)'),
(52, 'HBR', 'British Honduras'),
(53, 'BWI', 'British West Indies (BAR, JAM'),
(54, 'BIR', 'Burma (until 1989)'),
(55, 'CRC', 'Costa Rica'),
(56, 'TCH', 'Czechoslovakia'),
(57, 'YMD', 'Democratic Republic of Yemen'),
(58, 'FRG', 'Federal Republic of Germany (1950-1990, &quot;GER&'),
(59, 'GDR', 'German Democratic Republic (1955-1990, '),
(60, 'IOP', 'Independant Participant'),
(61, 'IOA', 'Independent Olympic Athlete'),
(62, 'MIX', 'Mixed NOCs'),
(63, 'ZZX', 'Mixed team'),
(64, 'ZZZ', 'Other countries'),
(65, 'RHO', 'Rhodesia (until 1968)'),
(66, 'RU1', 'Russia'),
(67, 'SER', 'Serbia - Yougoslavie YUG since'),
(68, 'SCG', 'Serbia and Montenegro'),
(69, 'EUN', 'Unified Team (ex USSR)'),
(70, 'EUA', 'United Team of Germany (1956,1960,1964)'),
(71, 'URS', 'USSR'),
(72, 'YUG', 'Yugoslavia'),
(73, 'ZAI', 'Zaire (1971-1997)'),
(74, 'CIV', 'C&#244;te d\'Ivoire'),
(75, 'CRO', 'Croatia'),
(76, 'CUB', 'Cuba'),
(77, 'DEN', 'Denmark'),
(78, 'DJI', 'Djibouti'),
(79, 'DOM', 'Dominican Republic'),
(80, 'DMA', 'Dominica'),
(81, 'EGY', 'Egypt'),
(82, 'ESA', 'El Salvador'),
(83, 'UAE', 'United Arab Emirates'),
(84, 'ECU', 'Ecuador'),
(85, 'ERI', 'Eritrea'),
(86, 'ESP', 'Spain'),
(87, 'EST', 'Estonia'),
(88, 'USA', 'United States of America'),
(89, 'ETH', 'Ethiopia'),
(90, 'MKD', 'The Former Yugoslav Republic of Macedonia'),
(91, 'FIJ', 'Fiji'),
(92, 'FIN', 'Finland'),
(93, 'FRA', 'France'),
(94, 'GAB', 'Gabon'),
(95, 'GAM', 'Gambia'),
(96, 'GEO', 'Georgia'),
(97, 'GHA', 'Ghana'),
(98, 'GBR', 'Great Britain'),
(99, 'GRE', 'Greece'),
(100, 'GRN', 'Grenada'),
(101, 'GUM', 'Guam'),
(102, 'GUA', 'Guatemala'),
(103, 'GUI', 'Guinea'),
(104, 'GBS', 'Guinea-Bissau'),
(105, 'GEQ', 'Equatorial Guinea'),
(106, 'GUY', 'Guyana'),
(107, 'HAI', 'Haiti'),
(108, 'HON', 'Honduras'),
(109, 'HKG', 'Hong Kong, China'),
(110, 'HUN', 'Hungary'),
(111, 'IND', 'India'),
(112, 'INA', 'Indonesia'),
(113, 'IRI', 'Islamic Republic of Iran'),
(114, 'IRQ', 'Iraq'),
(115, 'IRL', 'Ireland'),
(116, 'ISL', 'Iceland'),
(117, 'ISR', 'Israel'),
(118, 'ITA', 'Italy'),
(119, 'JAM', 'Jamaica'),
(120, 'JPN', 'Japan'),
(121, 'JOR', 'Jordan'),
(122, 'KAZ', 'Kazakhstan'),
(123, 'KEN', 'Kenya'),
(124, 'KGZ', 'Kyrgyzstan'),
(125, 'KIR', 'Kiribati'),
(126, 'KUW', 'Kuwait'),
(127, 'LAO', 'Lao People\'s Democratic Republic'),
(128, 'LES', 'Lesotho'),
(129, 'LAT', 'Latvia'),
(130, 'LIB', 'Lebanon'),
(131, 'LBR', 'Liberia'),
(132, 'LBA', 'Libya'),
(133, 'LIE', 'Liechtenstein'),
(134, 'LTU', 'Lithuania'),
(135, 'LUX', 'Luxembourg'),
(136, 'MAD', 'Madagascar'),
(137, 'MAS', 'Malaysia'),
(138, 'MAW', 'Malawi'),
(139, 'MDV', 'Maldives'),
(140, 'MLI', 'Mali'),
(141, 'MLT', 'Malta'),
(142, 'MAR', 'Morocco'),
(143, 'MHL', 'Marshall Islands'),
(144, 'MRI', 'Mauritius'),
(145, 'MTN', 'Mauritania'),
(146, 'MEX', 'Mexico'),
(147, 'FSM', 'Federated States of Micronesia'),
(148, 'MDA', 'Republic of Moldova'),
(149, 'MON', 'Monaco'),
(150, 'MGL', 'Mongolia'),
(151, 'MNE', 'Montenegro'),
(152, 'MOZ', 'Mozambique'),
(153, 'MYA', 'Myanmar (ex Burma until 1989)'),
(154, 'NAM', 'Namibia'),
(155, 'NRU', 'Nauru'),
(156, 'NEP', 'Nepal'),
(157, 'NCA', 'Nicaragua'),
(158, 'NIG', 'Niger'),
(159, 'NGR', 'Nigeria'),
(160, 'NOR', 'Norway'),
(161, 'NZL', 'New Zealand'),
(162, 'OMA', 'Oman'),
(163, 'UGA', 'Uganda'),
(164, 'UZB', 'Uzbekistan'),
(165, 'PAK', 'Pakistan'),
(166, 'PLW', 'Palau'),
(167, 'PLE', 'Palestine'),
(168, 'PAN', 'Panama'),
(169, 'PNG', 'Papua New Guinea'),
(170, 'PAR', 'Paraguay'),
(171, 'NED', 'Netherlands'),
(172, 'PER', 'Peru'),
(173, 'PHI', 'Philippines'),
(174, 'POL', 'Poland'),
(175, 'PUR', 'Puerto Rico'),
(176, 'POR', 'Portugal'),
(177, 'QAT', 'Qatar'),
(178, 'PRK', 'Democratic People\'s Republic of Korea'),
(179, 'ROU', 'Romania'),
(180, 'RUS', 'Russian Federation'),
(181, 'RWA', 'Rwanda'),
(182, 'SKN', 'Saint Kitts and Nevis'),
(183, 'LCA', 'Saint Lucia'),
(184, 'SMR', 'San Marino'),
(185, 'VIN', 'St Vincent and the Grenadines'),
(186, 'SOL', 'Solomon Islands'),
(187, 'SAM', 'Samoa (until 1996 Western Samoa)'),
(188, 'ASA', 'American Samoa'),
(189, 'STP', 'Sao Tome and Principe'),
(190, 'SEN', 'Senegal'),
(191, 'SRB', 'Serbia'),
(192, 'SEY', 'Seychelles'),
(193, 'SLE', 'Sierra Leone'),
(194, 'SIN', 'Singapore'),
(195, 'SVK', 'Slovakia'),
(196, 'SLO', 'Slovenia'),
(197, 'SOM', 'Somalia'),
(198, 'SUD', 'Sudan'),
(199, 'SRI', 'Sri Lanka'),
(200, 'SWE', 'Sweden'),
(201, 'SUI', 'Switzerland'),
(202, 'SUR', 'Suriname'),
(203, 'SWZ', 'Swaziland'),
(204, 'SYR', 'Syrian Arab Republic'),
(205, 'TJK', 'Tajikistan'),
(206, 'TPE', 'Chinese Taipei'),
(207, 'TAN', 'United Republic of Tanzania'),
(208, 'CHA', 'Chad'),
(209, 'CZE', 'Czech Republic'),
(210, 'THA', 'Thailand'),
(211, 'TLS', 'Democratic Republic of Timor-Leste'),
(212, 'TOG', 'Togo'),
(213, 'TGA', 'Tonga'),
(214, 'TTO', 'Trinidad and Tobago'),
(215, 'TUN', 'Tunisia'),
(216, 'TKM', 'Turkmenistan'),
(217, 'TUR', 'Turkey'),
(218, 'TUV', 'Tuvalu'),
(219, 'UKR', 'Ukraine'),
(220, 'URU', 'Uruguay'),
(221, 'VAN', 'Vanuatu'),
(222, 'VEN', 'Venezuela'),
(223, 'IVB', 'Virgin Islands, British'),
(224, 'ISV', 'Virgin Islands, US'),
(225, 'VIE', 'Vietnam'),
(226, 'YEM', 'Yemen'),
(227, 'ZAM', 'Zambia'),
(228, 'ZIM', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Structure de la table `sport`
--

DROP TABLE IF EXISTS `sport`;
CREATE TABLE IF NOT EXISTS `sport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sport`
--

INSERT INTO `sport` (`id`, `nom`) VALUES
(1, 'Athlétisme'),
(2, 'Badminton'),
(3, 'Boxe'),
(4, 'Cyclisme'),
(5, 'Équitation'),
(6, 'Escrime'),
(7, 'Golf'),
(8, 'Gymnastique artistique'),
(9, 'Gymnastique rythmique'),
(10, 'Gymnastique trampoline'),
(11, 'Judo'),
(12, 'Pentathlon moderne'),
(13, 'Plongeon'),
(14, 'Skateboard'),
(15, 'Escalade sportive'),
(16, 'Surf'),
(17, 'Squash'),
(18, 'Tennis'),
(19, 'Tennis de table'),
(20, 'Tir à l’arc'),
(21, 'Tir sportif'),
(22, 'Taekwondo'),
(23, 'Triathlon'),
(24, 'Natation'),
(25, 'Natation en eau libre'),
(26, 'Haltérophilie'),
(27, 'Lutte');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `athlete`
--
ALTER TABLE `athlete`
  ADD CONSTRAINT `fk_ath_pays` FOREIGN KEY (`pays_id`) REFERENCES `pays` (`id`),
  ADD CONSTRAINT `fk_ath_sport` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`id`);

--
-- Contraintes pour la table `epreuve`
--
ALTER TABLE `epreuve`
  ADD CONSTRAINT `fk_ath_athlete` FOREIGN KEY (`athlete_id`) REFERENCES `athlete` (`id`),
  ADD CONSTRAINT `fk_ath_sport_epreuve` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
