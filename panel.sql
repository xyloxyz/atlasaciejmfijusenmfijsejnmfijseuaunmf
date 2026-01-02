-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 06. Jun 2025 um 11:04
-- Server-Version: 10.11.6-MariaDB-0+deb12u1
-- PHP-Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `panel`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `admin_username` varchar(255) DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `target` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `auths`
--

CREATE TABLE `auths` (
  `id` int(11) NOT NULL,
  `ip` varchar(200) NOT NULL,
  `key` varchar(200) NOT NULL,
  `status` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ban_searches`
--

CREATE TABLE `ban_searches` (
  `id` int(11) NOT NULL,
  `search_query` varchar(100) NOT NULL,
  `search_type` enum('steam','license','discord','xbl','live','ip','hwid','name') NOT NULL,
  `searcher_ip` varchar(45) DEFAULT NULL,
  `results_found` int(11) DEFAULT 0,
  `global_bans_found` int(11) DEFAULT 0,
  `server_bans_found` int(11) DEFAULT 0,
  `search_timestamp` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `serverbans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` varchar(50) NOT NULL,
  `user_id` varchar(50) NOT NULL,
  `reason` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `blacklist`
--

CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `key` int(11) NOT NULL,
  `reason` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `blacklisted_servers`
--

CREATE TABLE `blacklisted_servers` (
  `id` int(11) NOT NULL,
  `server_id` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `blacklisted_servers`
--

CREATE TABLE `blacklisted_servers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_id` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `server_id` (`server_id`),
  KEY `idx_server_id` (`server_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `changelogs`
--

CREATE TABLE `changelogs` (
  `id` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `version` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `changes` text NOT NULL,
  `release_date` date NOT NULL,
  `type` enum('major','minor','patch','hotfix') DEFAULT 'minor',
  `authorId` int(11) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `changelogs`
--

INSERT INTO `changelogs` (`id`, `productId`, `version`, `title`, `description`, `changes`, `release_date`, `type`, `authorId`, `createdAt`, `updatedAt`) VALUES
(1, 10, '1.0.1', 'New Update', 'A update for performance', '- Fixed Auth\r\n- Added logs \r\netc', '2025-05-29', 'patch', 155, '2025-05-29 12:30:43', '2025-05-29 12:30:43'),
(2, 10, '1.0.2', 'Update 2', 'New features', '- Added feature 1\r\n- Added feature 2\r\n- Added feature 3', '2025-05-29', 'hotfix', 155, '2025-05-29 12:31:59', '2025-05-29 12:31:59');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `counter`
--

CREATE TABLE `counter` (
  `auths` varchar(2000) DEFAULT NULL,
  `blacklist` varchar(2000) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `logins` varchar(2000) DEFAULT NULL,
  `request` varchar(200) DEFAULT '0',
  `joins` varchar(200) DEFAULT NULL,
  `screens` varchar(200) DEFAULT NULL,
  `bans` varchar(200) NOT NULL DEFAULT '0',
  `logs` varchar(200) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `counter`
--

INSERT INTO `counter` (`auths`, `blacklist`, `id`, `logins`, `request`, `joins`, `screens`, `bans`, `logs`) VALUES
('15', '0', 1, '135', '0', '9', '668', '1', '22');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `discord_memberships`
--

CREATE TABLE `discord_memberships` (
  `id` int(11) NOT NULL,
  `discord_id` varchar(50) NOT NULL,
  `server_id` varchar(50) NOT NULL,
  `membership_status` enum('joined','left') DEFAULT 'joined',
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`roles`)),
  `joined_date` datetime DEFAULT NULL,
  `left_date` datetime DEFAULT NULL,
  `detected_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `auto_detected` tinyint(1) DEFAULT 0,
  `last_seen` timestamp NULL DEFAULT current_timestamp(),
  `discord_username` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `discord_scraper_logs`
--

CREATE TABLE `discord_scraper_logs` (
  `id` int(11) NOT NULL,
  `server_id` varchar(50) NOT NULL,
  `server_name` varchar(100) DEFAULT NULL,
  `members_found` int(11) DEFAULT 0,
  `new_members` int(11) DEFAULT 0,
  `updated_members` int(11) DEFAULT 0,
  `scrape_duration` int(11) DEFAULT 0,
  `status` enum('success','error','partial') DEFAULT 'success',
  `error_message` text DEFAULT NULL,
  `scraped_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `discord_servers`
--

CREATE TABLE `discord_servers` (
  `id` int(11) NOT NULL,
  `server_id` varchar(50) NOT NULL,
  `server_name` varchar(100) DEFAULT NULL,
  `risk_level` enum('normal','potential','suspicious','verified') DEFAULT 'normal',
  `description` text DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `member_count` int(11) DEFAULT 0,
  `added_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `auto_scraped` tinyint(1) DEFAULT 0,
  `last_scraped` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dm_action_logs`
--

CREATE TABLE `dm_action_logs` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `target` varchar(100) NOT NULL,
  `server_id` varchar(20) DEFAULT NULL,
  `channel_id` varchar(20) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `details` longtext DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dm_bans`
--

CREATE TABLE `dm_bans` (
  `id` int(11) NOT NULL,
  `server_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `reason` text DEFAULT NULL,
  `evidence` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `banned_by` int(11) NOT NULL,
  `expire_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `unbanned_at` datetime DEFAULT NULL,
  `unban_reason` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dm_embed_templates`
--

CREATE TABLE `dm_embed_templates` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(7) DEFAULT '#5865F2',
  `thumbnail_url` varchar(512) DEFAULT NULL,
  `image_url` varchar(512) DEFAULT NULL,
  `footer_text` varchar(255) DEFAULT NULL,
  `footer_icon_url` varchar(512) DEFAULT NULL,
  `author_name` varchar(255) DEFAULT NULL,
  `author_url` varchar(512) DEFAULT NULL,
  `author_icon_url` varchar(512) DEFAULT NULL,
  `fields` longtext DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `dm_embed_templates`
--

INSERT INTO `dm_embed_templates` (`id`, `name`, `title`, `description`, `color`, `thumbnail_url`, `image_url`, `footer_text`, `footer_icon_url`, `author_name`, `author_url`, `author_icon_url`, `fields`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'Welcome', 'Welcome to the Server!', 'Thanks for joining our community. Please read the rules and have fun!', '#00FF00', NULL, NULL, 'Welcome Bot', NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-02 09:30:51', '2025-06-02 09:30:51'),
(2, 'Rules', 'Server Rules', '1. Be respectful\n2. No spam\n3. Follow Discord TOS\n4. Have fun!', '#FF0000', NULL, NULL, 'Rules Bot', NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-02 09:30:51', '2025-06-02 09:30:51'),
(3, 'Announcement', 'Important Announcement', 'This is a template for important announcements.', '#5865F2', NULL, NULL, 'Announcement Bot', NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-02 09:30:51', '2025-06-02 09:30:51'),
(4, 'Event', 'Server Event', 'Join us for our upcoming event! More details coming soon.', '#FFFF00', NULL, NULL, 'Event Bot', NULL, NULL, NULL, NULL, NULL, NULL, '2025-06-02 09:30:51', '2025-06-02 09:30:51');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dm_moderation_rules`
--

CREATE TABLE `dm_moderation_rules` (
  `id` int(11) NOT NULL,
  `server_id` varchar(20) NOT NULL,
  `rule_name` varchar(255) NOT NULL,
  `rule_type` enum('SPAM','LINKS','CAPS','WORDS','INVITE','MENTION') NOT NULL,
  `trigger_words` longtext DEFAULT NULL,
  `action` enum('DELETE','WARN','TIMEOUT','KICK','BAN') NOT NULL,
  `timeout_duration` int(11) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `whitelist_roles` longtext DEFAULT NULL,
  `whitelist_channels` longtext DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dm_servers`
--

CREATE TABLE `dm_servers` (
  `id` int(11) NOT NULL,
  `server_id` varchar(20) NOT NULL,
  `server_name` varchar(255) NOT NULL,
  `owner_id` varchar(20) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `member_count` int(11) DEFAULT 0,
  `status` enum('active','inactive') DEFAULT 'active',
  `added_by` int(11) DEFAULT NULL,
  `permissions` longtext DEFAULT NULL,
  `webhook_url` varchar(512) DEFAULT NULL,
  `log_channel_id` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `dm_servers`
--

INSERT INTO `dm_servers` (`id`, `server_id`, `server_name`, `owner_id`, `icon`, `member_count`, `status`, `added_by`, `permissions`, `webhook_url`, `log_channel_id`, `created_at`, `updated_at`) VALUES
(1, '1377298193221685318', 'Main Discord Server', NULL, NULL, 0, 'active', NULL, NULL, NULL, NULL, '2025-06-02 09:30:51', '2025-06-02 09:47:01');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dm_webhooks`
--

CREATE TABLE `dm_webhooks` (
  `id` int(11) NOT NULL,
  `webhook_id` varchar(20) NOT NULL,
  `webhook_token` varchar(255) NOT NULL,
  `channel_id` varchar(20) NOT NULL,
  `server_id` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `avatar` varchar(512) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `faqs`
--

CREATE TABLE `faqs` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `order_index` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `faqs`
--

INSERT INTO `faqs` (`id`, `category_id`, `question`, `answer`, `order_index`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'What is this service?', 'This is an anti-cheat service that helps protect your games from cheaters and hackers.', 1, 1, '2025-06-02 11:37:04', '2025-06-02 11:37:04'),
(2, 1, 'How does it work?', 'Our service uses advanced detection methods to identify and prevent cheating in real-time.', 2, 1, '2025-06-02 11:37:04', '2025-06-02 11:37:04'),
(3, 2, 'How do I reset my password?', 'You can reset your password by clicking the \"Forgot Password\" link on the login page and following the instructions sent to your email.', 1, 1, '2025-06-02 11:37:04', '2025-06-02 11:37:04'),
(4, 2, 'Can I change my username?', 'Username changes are currently not supported. Please contact support if you need to change your username.', 2, 1, '2025-06-02 11:37:04', '2025-06-02 11:37:04'),
(7, 4, 'What payment methods do you accept?', 'We accept credit cards, PayPal, and cryptocurrency payments.', 1, 1, '2025-06-02 11:37:04', '2025-06-02 11:37:04'),
(8, 4, 'How do I cancel my subscription?', 'You can cancel your subscription at any time from your account settings page.', 2, 1, '2025-06-02 11:37:04', '2025-06-02 11:37:04');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `faq_categories`
--

CREATE TABLE `faq_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `faq_categories`
--

INSERT INTO `faq_categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Anticheat', 'General questions about the service', '2025-06-02 11:37:04', '2025-06-02 11:58:55'),
(2, 'Panel', 'Questions about account management', '2025-06-02 11:37:04', '2025-06-02 11:58:57'),
(4, 'Billing', 'Questions about billing and payments', '2025-06-02 11:37:04', '2025-06-02 11:37:04');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `globalbanlist`
--

CREATE TABLE `globalbanlist` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `steam` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `xbl` varchar(50) DEFAULT NULL,
  `live` varchar(50) DEFAULT NULL,
  `discord` varchar(50) DEFAULT NULL,
  `playerip` varchar(50) DEFAULT NULL,
  `hwid` varchar(950) DEFAULT NULL,
  `reason` varchar(255) NOT NULL DEFAULT 'Banned by discord.gg/hszYY72PGv',
  `screen` text NOT NULL DEFAULT 'https://r2.e-z.host/95b6da2b-7f6b-488b-826a-4e09878259ec/ui06900b.png',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `keys`
--

CREATE TABLE `keys` (
  `id` int(11) NOT NULL,
  `key` varchar(255) NOT NULL DEFAULT '0',
  `productId` int(11) NOT NULL,
  `expiresAt` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `logins`
--

CREATE TABLE `logins` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `discordId` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `logs`
--

CREATE TABLE `logs` (
  `id` int(11) NOT NULL,
  `reason` varchar(2000) NOT NULL,
  `date` varchar(200) NOT NULL,
  `license` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `motd`
--

CREATE TABLE `motd` (
  `id` int(11) NOT NULL,
  `enabled` int(11) NOT NULL,
  `message` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `summary` text NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `created_by` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `news`
--

INSERT INTO `news` (`id`, `title`, `summary`, `content`, `created_at`, `updated_at`, `created_by`, `is_active`) VALUES
(1, 'Anticheat is now in Beta', 'The Anticheat is now in the beta phase! If you have any wishes or find bugs, please let us know', 'Our new anticheat system has entered the beta testing phase. We encourage all users to test it thoroughly and provide feedback. Any bugs or feature requests can be submitted through our support channels. This is a major milestone in our development process and we are excited to see how it performs in real-world scenarios.', '2025-05-28 15:46:41', '2025-05-28 15:47:45', 1, 1),
(2, 'System Maintenance Scheduled', 'Planned maintenance window on Sunday from 2:00 AM to 4:00 AM UTC', 'We will be performing routine system maintenance this Sunday from 2:00 AM to 4:00 AM UTC. During this time, some services may be temporarily unavailable. We apologize for any inconvenience and appreciate your patience.', '2025-05-28 15:46:41', '2025-05-28 15:47:48', 1, 1),
(3, 'New Features Released', 'Check out our latest updates including improved performance and new admin tools', 'We are excited to announce the release of several new features: Enhanced performance monitoring, improved admin dashboard, better user management tools, and upgraded security measures. Update your client to the latest version to take advantage of these improvements.', '2025-05-28 15:46:41', '2025-05-28 15:47:51', 1, 1);
-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `active` varchar(20) NOT NULL DEFAULT '0',
  `server_code` longtext DEFAULT NULL,
  `client_code` longtext DEFAULT NULL,
  `version` varchar(10) DEFAULT '1.0.0',
  `type` varchar(200) NOT NULL DEFAULT 'FiveM Script'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Daten für Tabelle `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `createdAt`, `active`, `server_code`, `client_code`, `version`, `type`) VALUES
(10, 'Anticheat', 1000, '2025-05-13 00:44:08', '0', NULL, NULL, '1.0.0', 'FiveM Script');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `shared_configs`
--

CREATE TABLE `shared_configs` (
  `id` int(11) NOT NULL,
  `shareCode` varchar(8) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `config` longtext NOT NULL,
  `userId` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `expiresAt` datetime DEFAULT NULL,
  `downloads` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `shared_configs`
--

INSERT INTO `shared_configs` (`id`, `shareCode`, `title`, `description`, `config`, `userId`, `username`, `createdAt`, `expiresAt`, `downloads`) VALUES
(1, 'CTFZJMQJ', 'Crimelife Config', 'A config for Crimelife Server', '{\"AdminMenu\":{\"Enable\":true,\"Key\":\"F11\"},\"BlacklistedKey\":{\"List\":\"121, 344, 10, 37\",\"Ban\":false},\"AceBypass\":{\"Ace\":\"ES.Bypass\",\"AdminMenu\":\"ES.Menu\"},\"AntiVPN\":{\"Enabled\":true},\"HeartbeatSystem\":{\"Enabled\":true},\"UseESXLegacy\":{\"Enabled\":true},\"EnableIPLogs\":{\"Enabled\":true},\"DiscordBypass\":{\"Ids\":\"\"},\"ShardObjectESX\":{\"Message\":\"esx:getSharedObject\"},\"Debug\":{\"Enabled\":false},\"AntiESX\":{\"Enabled\":false}}', 155, 'Test', '2025-05-29 18:03:55', NULL, 3),
(2, '68FEW3D6', 'RP Config', 'A Config for RP Servers', '{\"AdminMenu\":{\"Enable\":true,\"Key\":\"F11\"},\"BlacklistedKey\":{\"List\":\"121, 344, 10, 37\",\"Ban\":false},\"AceBypass\":{\"Ace\":\"ES.Bypass\",\"AdminMenu\":\"ES.Menu\"},\"AntiVPN\":{\"Enabled\":true},\"HeartbeatSystem\":{\"Enabled\":true},\"UseESXLegacy\":{\"Enabled\":true},\"EnableIPLogs\":{\"Enabled\":true},\"DiscordBypass\":{\"Ids\":\"\"},\"ShardObjectESX\":{\"Message\":\"esx:getSharedObject\"},\"Debug\":{\"Enabled\":false},\"AntiESX\":{\"Enabled\":false}}', 155, 'Test', '2025-05-29 18:24:59', NULL, 0),
(3, '3XUXL5W9', 'Gangwar Config', 'A Config for Gangwar Servers', '{\"AdminMenu\":{\"Enable\":true,\"Key\":\"F11\"},\"BlacklistedKey\":{\"List\":\"121, 344, 10, 37\",\"Ban\":false},\"AceBypass\":{\"Ace\":\"ES.Bypass\",\"AdminMenu\":\"ES.Menu\"},\"AntiVPN\":{\"Enabled\":true},\"HeartbeatSystem\":{\"Enabled\":true},\"UseESXLegacy\":{\"Enabled\":true},\"EnableIPLogs\":{\"Enabled\":true},\"DiscordBypass\":{\"Ids\":\"\"},\"ShardObjectESX\":{\"Message\":\"esx:getSharedObject\"},\"Debug\":{\"Enabled\":false},\"AntiESX\":{\"Enabled\":false}}', 155, 'Test', '2025-05-29 18:25:15', NULL, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sub_users`
--

CREATE TABLE `sub_users` (
  `id` int(11) NOT NULL,
  `main_user_id` int(11) NOT NULL COMMENT 'Hauptkunde (Produktbesitzer)',
  `sub_user_id` int(11) NOT NULL COMMENT 'Sub-User',
  `product_id` int(11) NOT NULL COMMENT 'Zugehöriges Produkt',
  `status` enum('active','inactive','pending') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sub_user_activity_logs`
--

CREATE TABLE `sub_user_activity_logs` (
  `id` int(11) NOT NULL,
  `sub_user_id` int(11) NOT NULL,
  `main_user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sub_user_invitations`
--

CREATE TABLE `sub_user_invitations` (
  `id` int(11) NOT NULL,
  `main_user_id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `product_id` int(11) NOT NULL,
  `invitation_token` varchar(64) NOT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Vorausgewählte Berechtigungen' CHECK (json_valid(`permissions`)),
  `status` enum('pending','accepted','declined','expired') NOT NULL DEFAULT 'pending',
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `accepted_at` datetime DEFAULT NULL,
  `invited_user_id` int(11) DEFAULT NULL COMMENT 'Falls der eingeladene User bereits existiert'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `sub_user_permissions`
--

CREATE TABLE `sub_user_permissions` (
  `id` int(11) NOT NULL,
  `sub_user_relation_id` int(11) NOT NULL,
  `permission_type` enum('config_view','config_edit','banlist_view','banlist_edit','banlist_delete','playerlist_view','playerlist_edit','logs_view','logs_export','analytics_view','keys_view','keys_create','keys_revoke','changelog_view','changelog_create','settings_view','settings_edit') NOT NULL,
  `granted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tickets`
--

CREATE TABLE `tickets` (
  `id` int(11) NOT NULL,
  `ticket_number` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` enum('open','in_progress','waiting_customer','waiting_admin','closed','resolved') DEFAULT 'open',
  `priority` enum('low','normal','high','urgent') DEFAULT 'normal',
  `assigned_admin_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `closed_at` datetime DEFAULT NULL,
  `last_activity` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ticket_activities`
--

CREATE TABLE `ticket_activities` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ticket_attachments`
--

CREATE TABLE `ticket_attachments` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `message_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `original_filename` varchar(255) NOT NULL,
  `file_path` varchar(500) NOT NULL,
  `file_size` bigint(20) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `is_image` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ticket_categories`
--

CREATE TABLE `ticket_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `color` varchar(7) DEFAULT '#007bff',
  `icon` varchar(50) DEFAULT 'fas fa-ticket-alt',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `ticket_categories`
--

INSERT INTO `ticket_categories` (`id`, `name`, `description`, `color`, `icon`, `is_active`, `created_at`) VALUES
(1, 'Pack v2', 'Allgemeine Anfragen und Fragen', '#007bff', 'fas fa-question-circle', 1, '2025-05-29 23:56:03'),
(2, 'Technischer Support', 'Technische Probleme und Fehler', '#dc3545', 'fas fa-wrench', 1, '2025-05-29 23:56:03'),
(3, 'Billing', 'Rechnungen und Zahlungsprobleme', '#28a745', 'fas fa-credit-card', 1, '2025-05-29 23:56:03'),
(4, 'Feature Request', 'Neue Feature-Anfragen', '#17a2b8', 'fas fa-lightbulb', 1, '2025-05-29 23:56:03'),
(5, 'Bug Report', 'Fehlerberichte', '#fd7e14', 'fas fa-bug', 1, '2025-05-29 23:56:03');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ticket_messages`
--

CREATE TABLE `ticket_messages` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  `is_internal` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ticket_settings`
--

CREATE TABLE `ticket_settings` (
  `id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `ticket_settings`
--

INSERT INTO `ticket_settings` (`id`, `setting_key`, `setting_value`, `description`, `updated_at`) VALUES
(1, 'auto_close_days', '7', 'Anzahl der Tage nach denen ein Ticket automatisch geschlossen wird', '2025-05-29 23:56:03'),
(2, 'max_attachments_per_ticket', '10', 'Maximale Anzahl von Anhängen pro Ticket', '2025-05-29 23:56:03'),
(3, 'max_file_size_mb', '10', 'Maximale Dateigröße in MB', '2025-05-29 23:56:03'),
(4, 'allowed_file_types', 'jpg,jpeg,png,gif,pdf,txt,doc,docx,zip,rar', 'Erlaubte Dateitypen', '2025-05-29 23:56:03'),
(5, 'notification_email', '1', 'E-Mail-Benachrichtigungen aktiviert', '2025-05-29 23:56:03'),
(6, 'notification_discord', '1', 'Discord-Benachrichtigungen aktiviert', '2025-05-29 23:56:03');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ticket_templates`
--

CREATE TABLE `ticket_templates` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL,
  `template_content` text NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_by` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `ticket_templates`
--

INSERT INTO `ticket_templates` (`id`, `name`, `category_id`, `template_content`, `is_active`, `created_by`, `created_at`) VALUES
(1, 'Allgemeine Anfrage', 1, 'Hallo,\n\nich habe eine Frage bezüglich:\n\n[Beschreibe dein Anliegen hier]\n\nVielen Dank für die Hilfe!', 1, 1, '2025-05-29 23:56:03'),
(2, 'Bug Report', 5, 'Bug-Beschreibung:\n[Beschreibe den Fehler]\n\nSchritte zur Reproduktion:\n1. \n2. \n3. \n\nErwartetes Verhalten:\n[Was sollte passieren]\n\nTatsächliches Verhalten:\n[Was passiert tatsächlich]\n\nBrowser/System:\n[z.B. Chrome 119, Windows 11]', 1, 1, '2025-05-29 23:56:03');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `id` int(30) NOT NULL,
  `username` varchar(255) NOT NULL DEFAULT '',
  `discordId` varchar(50) DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '0',
  `avatar` varchar(255) DEFAULT NULL,
  `locale` varchar(3) DEFAULT 'en',
  `isAdmin` tinyint(4) NOT NULL DEFAULT 0,
  `isOwner` tinyint(4) DEFAULT 0,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `last_ip` varchar(200) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'active',
  `isCustomer` tinyint(6) NOT NULL DEFAULT 0,
  `password` varchar(255) DEFAULT NULL,
  `can_be_sub_user` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Kann als Sub-User eingeladen werden',
  `sub_user_notifications` tinyint(1) NOT NULL DEFAULT 1 COMMENT 'Sub-User Benachrichtigungen aktiviert'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `users` (id, username, email, password, createdAt, status, isAdmin, isCustomer) 
VALUES (1, 'admin', 'admin@demonsolutions.com', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), 'active', 1, 1)
ON DUPLICATE KEY UPDATE 
    username = VALUES(username),
    email = VALUES(email),
    password = VALUES(password),
    status = VALUES(status),
    isAdmin = VALUES(isAdmin),
    isCustomer = VALUES(isCustomer);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_configs`
--

CREATE TABLE `user_configs` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `secret` varchar(128) NOT NULL,
  `config` text NOT NULL DEFAULT '{}',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_products`
--

CREATE TABLE `user_products` (
  `id` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `productId` int(11) NOT NULL DEFAULT 0,
  `ip` varchar(40) DEFAULT NULL,
  `devIp` varchar(40) DEFAULT NULL,
  `expiresAt` datetime NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT current_timestamp(),
  `status` varchar(200) NOT NULL DEFAULT 'active',
  `key` varchar(50) NOT NULL,
  `product` varchar(20) NOT NULL,
  `username` varchar(100) NOT NULL,
  `port` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admin_id` (`admin_id`),
  ADD KEY `idx_admin_id` (`admin_id`),
  ADD KEY `idx_timestamp` (`timestamp`);

--
-- Indizes für die Tabelle `auths`
--
ALTER TABLE `auths`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `ban_searches`
--
ALTER TABLE `ban_searches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_search_query` (`search_query`),
  ADD KEY `idx_search_timestamp` (`search_timestamp`),
  ADD KEY `idx_search_type` (`search_type`);

--
-- Indizes für die Tabelle `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `blacklisted_servers`
--
ALTER TABLE `blacklisted_servers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `server_id` (`server_id`),
  ADD KEY `idx_server_id` (`server_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indizes für die Tabelle `changelogs`
--
ALTER TABLE `changelogs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productId` (`productId`),
  ADD KEY `authorId` (`authorId`);

--
-- Indizes für die Tabelle `counter`
--
ALTER TABLE `counter`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `discord_memberships`
--
ALTER TABLE `discord_memberships`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_membership` (`discord_id`,`server_id`),
  ADD KEY `idx_discord_id` (`discord_id`),
  ADD KEY `idx_server_id` (`server_id`),
  ADD KEY `idx_membership_status` (`membership_status`),
  ADD KEY `idx_detected_at` (`detected_at`),
  ADD KEY `idx_auto_detected` (`auto_detected`),
  ADD KEY `idx_last_seen` (`last_seen`);

--
-- Indizes für die Tabelle `discord_scraper_logs`
--
ALTER TABLE `discord_scraper_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_server_id` (`server_id`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_scraped_at` (`scraped_at`);

--
-- Indizes für die Tabelle `discord_servers`
--
ALTER TABLE `discord_servers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `server_id` (`server_id`),
  ADD KEY `idx_server_id` (`server_id`),
  ADD KEY `idx_risk_level` (`risk_level`),
  ADD KEY `idx_auto_scraped` (`auto_scraped`);

--
-- Indizes für die Tabelle `dm_action_logs`
--
ALTER TABLE `dm_action_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dm_action_logs_admin` (`admin_id`),
  ADD KEY `idx_dm_action_logs_timestamp` (`timestamp`),
  ADD KEY `idx_dm_action_logs_server` (`server_id`),
  ADD KEY `idx_dm_action_logs_action` (`action`),
  ADD KEY `idx_action_type` (`action`),
  ADD KEY `idx_server_action` (`server_id`,`action`);

--
-- Indizes für die Tabelle `dm_bans`
--
ALTER TABLE `dm_bans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `banned_by` (`banned_by`),
  ADD KEY `idx_server_user` (`server_id`,`user_id`),
  ADD KEY `idx_expire_at` (`expire_at`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indizes für die Tabelle `dm_embed_templates`
--
ALTER TABLE `dm_embed_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dm_embed_templates_created_by` (`created_by`);

--
-- Indizes für die Tabelle `dm_moderation_rules`
--
ALTER TABLE `dm_moderation_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_dm_moderation_rules_created_by` (`created_by`),
  ADD KEY `idx_dm_moderation_rules_server` (`server_id`);

--
-- Indizes für die Tabelle `dm_servers`
--
ALTER TABLE `dm_servers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `server_id` (`server_id`),
  ADD KEY `fk_dm_servers_added_by` (`added_by`);

--
-- Indizes für die Tabelle `dm_webhooks`
--
ALTER TABLE `dm_webhooks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `webhook_id` (`webhook_id`),
  ADD KEY `fk_dm_webhooks_created_by` (`created_by`);

--
-- Indizes für die Tabelle `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indizes für die Tabelle `faq_categories`
--
ALTER TABLE `faq_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `globalbanlist`
--
ALTER TABLE `globalbanlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_steam` (`steam`),
  ADD KEY `idx_license` (`license`),
  ADD KEY `idx_discord` (`discord`),
  ADD KEY `idx_name` (`name`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indizes für die Tabelle `keys`
--
ALTER TABLE `keys`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `logins`
--
ALTER TABLE `logins`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `motd`
--
ALTER TABLE `motd`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `is_active` (`is_active`),
  ADD KEY `created_at` (`created_at`);

--
-- Indizes für die Tabelle `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indizes für die Tabelle `shared_configs`
--
ALTER TABLE `shared_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shareCode` (`shareCode`),
  ADD KEY `userId` (`userId`),
  ADD KEY `createdAt` (`createdAt`),
  ADD KEY `expiresAt` (`expiresAt`);

--
-- Indizes für die Tabelle `sub_users`
--
ALTER TABLE `sub_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_sub_user_product` (`main_user_id`,`sub_user_id`,`product_id`),
  ADD KEY `main_user_id` (`main_user_id`),
  ADD KEY `sub_user_id` (`sub_user_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `idx_sub_users_main_user_product` (`main_user_id`,`product_id`),
  ADD KEY `idx_sub_users_sub_user_product` (`sub_user_id`,`product_id`);

--
-- Indizes für die Tabelle `sub_user_activity_logs`
--
ALTER TABLE `sub_user_activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sub_user_id` (`sub_user_id`),
  ADD KEY `main_user_id` (`main_user_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `created_at` (`created_at`),
  ADD KEY `idx_activity_logs_date` (`created_at` DESC);

--
-- Indizes für die Tabelle `sub_user_invitations`
--
ALTER TABLE `sub_user_invitations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `invitation_token` (`invitation_token`),
  ADD KEY `main_user_id` (`main_user_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `email` (`email`),
  ADD KEY `status` (`status`),
  ADD KEY `idx_invitations_status_expires` (`status`,`expires_at`);

--
-- Indizes für die Tabelle `sub_user_permissions`
--
ALTER TABLE `sub_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_permission` (`sub_user_relation_id`,`permission_type`),
  ADD KEY `sub_user_relation_id` (`sub_user_relation_id`),
  ADD KEY `idx_permissions_type` (`permission_type`,`granted`);

--
-- Indizes für die Tabelle `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_number` (`ticket_number`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `assigned_admin_id` (`assigned_admin_id`),
  ADD KEY `status` (`status`),
  ADD KEY `priority` (`priority`);

--
-- Indizes für die Tabelle `ticket_activities`
--
ALTER TABLE `ticket_activities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `ticket_attachments`
--
ALTER TABLE `ticket_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `message_id` (`message_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `ticket_categories`
--
ALTER TABLE `ticket_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `ticket_messages`
--
ALTER TABLE `ticket_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indizes für die Tabelle `ticket_settings`
--
ALTER TABLE `ticket_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indizes für die Tabelle `ticket_templates`
--
ALTER TABLE `ticket_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discordId` (`discordId`);

--
-- Indizes für die Tabelle `user_configs`
--
ALTER TABLE `user_configs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userId` (`userId`),
  ADD UNIQUE KEY `secret` (`secret`),
  ADD KEY `userId_idx` (`userId`);

--
-- Indizes für die Tabelle `user_products`
--
ALTER TABLE `user_products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `auths`
--
ALTER TABLE `auths`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `ban_searches`
--
ALTER TABLE `ban_searches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `blacklisted_servers`
--
ALTER TABLE `blacklisted_servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `changelogs`
--
ALTER TABLE `changelogs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `counter`
--
ALTER TABLE `counter`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `discord_memberships`
--
ALTER TABLE `discord_memberships`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `discord_scraper_logs`
--
ALTER TABLE `discord_scraper_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `discord_servers`
--
ALTER TABLE `discord_servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `dm_action_logs`
--
ALTER TABLE `dm_action_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `dm_bans`
--
ALTER TABLE `dm_bans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `dm_embed_templates`
--
ALTER TABLE `dm_embed_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `dm_moderation_rules`
--
ALTER TABLE `dm_moderation_rules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `dm_servers`
--
ALTER TABLE `dm_servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `