-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 15 يونيو 2026 الساعة 12:04
-- إصدار الخادم: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student_housing_db`
--

-- --------------------------------------------------------

--
-- بنية الجدول `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `property_id` bigint(20) UNSIGNED NOT NULL,
  `tenant_id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `bookings`
--

INSERT INTO `bookings` (`id`, `property_id`, `tenant_id`, `owner_id`, `status`, `note`, `created_at`, `updated_at`) VALUES
(1, 31, 4, 2, 'accepted', NULL, '2026-05-29 21:49:52', '2026-05-29 22:25:21'),
(2, 24, 4, 2, 'accepted', 'vvvv', '2026-05-29 22:20:34', '2026-05-29 22:25:18'),
(3, 32, 4, 2, 'accepted', NULL, '2026-06-01 17:59:02', '2026-06-01 17:59:50'),
(4, 32, 3, 2, 'accepted', 'vvvvv', '2026-06-10 18:30:33', '2026-06-10 18:31:03'),
(5, 33, 3, 5, 'accepted', NULL, '2026-06-10 19:37:18', '2026-06-10 19:38:06'),
(6, 35, 4, 2, 'pending', 'kdmcf', '2026-06-15 04:15:47', '2026-06-15 04:15:47'),
(7, 34, 4, 2, 'pending', NULL, '2026-06-15 04:16:01', '2026-06-15 04:16:01');

-- --------------------------------------------------------

--
-- بنية الجدول `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `contact_requests`
--

CREATE TABLE `contact_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `property_id` bigint(20) UNSIGNED NOT NULL,
  `tenant_id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `contact_requests`
--

INSERT INTO `contact_requests` (`id`, `property_id`, `tenant_id`, `owner_id`, `name`, `phone`, `message`, `is_read`, `created_at`, `updated_at`) VALUES
(2, 25, 3, 2, 'dado', '2323332', 'bbbbbbbbbb', 1, '2026-05-28 16:01:49', '2026-05-28 16:02:11'),
(3, 23, 3, 2, 'dado', '2323332', 'CCCCCC', 1, '2026-05-28 16:02:58', '2026-05-28 16:03:17'),
(4, 24, 3, 2, 'dado', '2323332', 'cccc', 1, '2026-05-28 16:57:19', '2026-05-28 18:12:27'),
(5, 18, 3, 1, 'dado', '2323332', 'بيبي', 0, '2026-05-28 21:20:32', '2026-05-28 21:20:32'),
(6, 21, 3, 1, 'dado', '2323332', 'ئءئء', 0, '2026-05-28 21:26:53', '2026-05-28 21:26:53'),
(7, 20, 4, 2, 'dede', '333333333333334', 'طلب تواصل بخصوص العقار: منزل مشترك', 1, '2026-05-29 22:26:19', '2026-05-29 22:26:36'),
(8, 32, 4, 2, 'dede', '333333333333334', 'طلب تواصل بخصوص العقار: daddad', 1, '2026-06-01 17:59:08', '2026-06-01 17:59:34'),
(9, 31, 4, 2, 'dede', '333333333333334', 'طلب تواصل بخصوص العقار: برييل', 1, '2026-06-02 07:18:50', '2026-06-02 07:19:23');

-- --------------------------------------------------------

--
-- بنية الجدول `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_04_07_194800_add_fields_to_users_table', 1),
(5, '2026_04_07_200622_create_properties_table', 1),
(6, '2026_04_07_202728_create_property_images_table', 1),
(7, '2026_04_07_203044_create_contact_requests_table', 1),
(8, '2026_04_07_215746_add_foreign_keys_to_property_images_table', 1),
(9, '2026_04_07_220927_add_foreign_keys_to_contact_requests_table', 1),
(10, '2026_04_08_223538_create_universities_table', 1),
(11, '2026_04_08_230244_add_univercities_fk_to_usrs_table', 1),
(12, '2026_04_09_190111_add_foreign_keys_to_properties_table', 1),
(13, '2026_04_13_195433_add_status_to_properties_table', 1),
(14, '2026_04_16_002112_add_is_read_to_contact_requests_table', 1),
(15, '2026_04_16_165654_create_personal_access_tokens_table', 1),
(16, '2026_04_17_165711_add_owner_notified_at_to_properties_table', 1),
(17, '2026_05_10_215935_add_extra_fields_to_properties_table', 1),
(18, '2026_05_24_215954_add_amenities_to_properties_table', 2),
(20, '2026_05_25_000945_add_division_to_properties_table', 3),
(21, '2026_05_27_201909_add_is_banned_to_users_table', 3),
(22, '2026_05_29_222510_bookings', 4),
(23, '2026_05_30_004050_bookings', 5);

-- --------------------------------------------------------

--
-- بنية الجدول `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'api-token', '3b6f456a1be57800aff8bd40ff6e3f1df0e59ece471259b12e1c71c6f7acb18d', '[\"*\"]', '2026-05-22 10:40:21', NULL, '2026-05-22 10:40:20', '2026-05-22 10:40:21'),
(2, 'App\\Models\\User', 2, 'api-token', '74d10f037b88d98e81455f3ce7367afbd233c3f6f29a505418f230c52233c49d', '[\"*\"]', '2026-05-22 11:08:52', NULL, '2026-05-22 10:59:59', '2026-05-22 11:08:52'),
(3, 'App\\Models\\User', 1, 'api-token', 'b916031810e77901c74f8a24ffa8ce4922d3471b725540271433f1ec3dc05d60', '[\"*\"]', '2026-05-22 11:22:20', NULL, '2026-05-22 11:09:23', '2026-05-22 11:22:20'),
(4, 'App\\Models\\User', 1, 'api-token', 'a8d686e46472bc6442ec20eace93f3af03a4d7ace29393a687ea35cee315ff14', '[\"*\"]', '2026-05-22 11:25:01', NULL, '2026-05-22 11:22:30', '2026-05-22 11:25:01'),
(5, 'App\\Models\\User', 1, 'api-token', 'ccd2e1b2044e8229fd15845eae50cdff6e062e0919d2f0f30fd318c1ff4767fb', '[\"*\"]', '2026-05-22 11:25:36', NULL, '2026-05-22 11:25:15', '2026-05-22 11:25:36'),
(6, 'App\\Models\\User', 2, 'api-token', '9b91a52162d2e0dec2a64abe55dc8b18c3d8294617a5cc6d1a629536eb86b7a0', '[\"*\"]', '2026-05-22 11:26:31', NULL, '2026-05-22 11:26:27', '2026-05-22 11:26:31'),
(7, 'App\\Models\\User', 2, 'api-token', '3bbaa960465cdcd9cc046b1a13a25d6f77c799d523374b52b5bde155e2b1cbf4', '[\"*\"]', '2026-05-22 21:54:23', NULL, '2026-05-22 20:52:37', '2026-05-22 21:54:23'),
(8, 'App\\Models\\User', 1, 'api-token', '6c9d256007299914b95ace780ed79b5c73b04f2b5e51e1ed7d2a75c8165846af', '[\"*\"]', '2026-05-22 22:04:53', NULL, '2026-05-22 22:00:36', '2026-05-22 22:04:53'),
(9, 'App\\Models\\User', 1, 'api-token', '8de7a9bc95d702646b2f6654afff5fc5f84bec0bd02d74c07c5d9639d21eda7a', '[\"*\"]', '2026-05-22 22:07:30', NULL, '2026-05-22 22:05:12', '2026-05-22 22:07:30'),
(10, 'App\\Models\\User', 1, 'api-token', '04ba3f3efd62a1f06ed40bc2c12f5467c001a1191639582cbf66982ba194852a', '[\"*\"]', '2026-05-22 22:09:44', NULL, '2026-05-22 22:07:44', '2026-05-22 22:09:44'),
(11, 'App\\Models\\User', 1, 'api-token', '0381ee74bc3c02231fd42f0c7b1728f244be6bb97214a9ae0a48cf84bc0f1a71', '[\"*\"]', '2026-05-22 22:11:27', NULL, '2026-05-22 22:10:15', '2026-05-22 22:11:27'),
(12, 'App\\Models\\User', 1, 'api-token', '495c043ea21880dac161b548a64bca4c993a154482f3437d26ddeb608b1e4de7', '[\"*\"]', '2026-05-22 22:15:21', NULL, '2026-05-22 22:11:47', '2026-05-22 22:15:21'),
(13, 'App\\Models\\User', 1, 'api-token', 'ecdd5e3703c697c02d7966e7ac6fe0371f40de0acc49f1f3884c3cb23a511788', '[\"*\"]', '2026-05-22 22:39:40', NULL, '2026-05-22 22:18:09', '2026-05-22 22:39:40'),
(14, 'App\\Models\\User', 2, 'api-token', 'f7d6e47d7b1949707c2bbcc630dc8e77d7c2653a5a016653f57676607cb63ac9', '[\"*\"]', '2026-05-22 23:19:24', NULL, '2026-05-22 23:18:41', '2026-05-22 23:19:24'),
(15, 'App\\Models\\User', 3, 'api-token', '24925f70c317e9a0b470a0b5a864a31e8e0b5e42dd42849bfff02b89c3ba26c7', '[\"*\"]', '2026-05-24 12:47:49', NULL, '2026-05-22 23:21:00', '2026-05-24 12:47:49'),
(16, 'App\\Models\\User', 2, 'api-token', '236af04a834e801d1d191ab3a64a392c7600d6396e38360685d79d9ea5890366', '[\"*\"]', '2026-05-24 12:49:32', NULL, '2026-05-23 09:05:58', '2026-05-24 12:49:32'),
(17, 'App\\Models\\User', 1, 'api-token', '2bb6f8e104a453605ac07707268e42aa94af4dd2fa8a864cab75e6b6a4f23d83', '[\"*\"]', '2026-05-23 17:46:29', NULL, '2026-05-23 17:43:15', '2026-05-23 17:46:29'),
(18, 'App\\Models\\User', 2, 'api-token', 'd0fe80b850cc662f34c44f3c790af857dd0b2fb284e477766eca25428ecc3a5a', '[\"*\"]', '2026-05-23 19:59:14', NULL, '2026-05-23 17:48:52', '2026-05-23 19:59:14'),
(19, 'App\\Models\\User', 1, 'api-token', '344b69b0c643bf10126b729b3fd63b6397b79ded16e786ca49024b28a46bcc3c', '[\"*\"]', '2026-05-27 17:38:21', NULL, '2026-05-23 20:17:53', '2026-05-27 17:38:21'),
(20, 'App\\Models\\User', 1, 'api-token', 'c4849fe360559ed3c133e96cb6a70040f52ef8b7ce6330f2e36675f71787d5fd', '[\"*\"]', '2026-05-24 13:24:35', NULL, '2026-05-24 12:49:59', '2026-05-24 13:24:35'),
(21, 'App\\Models\\User', 2, 'api-token', '1311c05f14c093e26625dff2a5998686369863c783c87240688ed2cb23fac200', '[\"*\"]', '2026-05-24 13:26:33', NULL, '2026-05-24 13:25:28', '2026-05-24 13:26:33'),
(22, 'App\\Models\\User', 1, 'api-token', '14137a2b9794bc6306cc0a2fae623efa244681c13e0b191d429ff47e2115e22e', '[\"*\"]', '2026-05-24 20:09:09', NULL, '2026-05-24 13:26:50', '2026-05-24 20:09:09'),
(23, 'App\\Models\\User', 2, 'api-token', '9591e2e2768a95dbe1c349f6599b0375be067f51ef2d2dea9733e89403ccc76f', '[\"*\"]', '2026-05-24 20:18:58', NULL, '2026-05-24 20:18:49', '2026-05-24 20:18:58'),
(24, 'App\\Models\\User', 2, 'api-token', '9279318b9ef32ac3fcaa2f26e93314bf28b425d8c99735bfff8ed90cd9c6b562', '[\"*\"]', '2026-05-24 20:39:19', NULL, '2026-05-24 20:31:16', '2026-05-24 20:39:19'),
(25, 'App\\Models\\User', 1, 'api-token', '848fcf6449feef38203082d563502a1238bed0445b411fed61af1971a546738d', '[\"*\"]', '2026-05-24 21:10:51', NULL, '2026-05-24 20:39:29', '2026-05-24 21:10:51'),
(26, 'App\\Models\\User', 2, 'api-token', '98a6e1af74e28671ff5bf453f5a7d882fd968f7afd26153c37838c6723aa97ba', '[\"*\"]', '2026-05-24 21:12:28', NULL, '2026-05-24 21:11:24', '2026-05-24 21:12:28'),
(27, 'App\\Models\\User', 1, 'api-token', '76148dba4f49bbbc94f629bf0c67db3640a8c072f6681832b1c1bf12599b6422', '[\"*\"]', '2026-05-24 22:40:20', NULL, '2026-05-24 21:12:47', '2026-05-24 22:40:20'),
(28, 'App\\Models\\User', 4, 'api-token', '469e1ac82e53f88be4b423d1311407ad6598f071615cd7dc9ade39b297ae3906', '[\"*\"]', '2026-05-27 17:47:14', NULL, '2026-05-27 17:39:06', '2026-05-27 17:47:14'),
(29, 'App\\Models\\User', 5, 'api-token', '19aca64259806c8061b522e8c7933502ab1d7b3c3106a0470810ec3939b1677e', '[\"*\"]', '2026-05-27 17:47:55', NULL, '2026-05-27 17:47:52', '2026-05-27 17:47:55'),
(30, 'App\\Models\\User', 1, 'api-token', '8de8fa43d60fab78a107eabd5f9eb0a76756ea5fd14e098cf5c2caa2598636f4', '[\"*\"]', '2026-05-27 18:03:51', NULL, '2026-05-27 17:52:10', '2026-05-27 18:03:51'),
(31, 'App\\Models\\User', 1, 'api-token', '642c57adb882afe370d0525cdd5b6391459c5e4f1f11258c1a5bb3a91c7bd37c', '[\"*\"]', '2026-05-27 18:09:22', NULL, '2026-05-27 18:06:33', '2026-05-27 18:09:22'),
(32, 'App\\Models\\User', 2, 'api-token', '0a2f31d966d33d80202f8c72a5d2c530dad6de802787e1c519e4eff125d84ae9', '[\"*\"]', '2026-05-27 18:31:34', NULL, '2026-05-27 18:14:36', '2026-05-27 18:31:34'),
(33, 'App\\Models\\User', 6, 'api-token', '3c255e860dad151751c9e409eb2d6acc29ad72150e3e4ceec204a52cc38f5b4d', '[\"*\"]', '2026-05-27 21:45:08', NULL, '2026-05-27 20:15:17', '2026-05-27 21:45:08'),
(34, 'App\\Models\\User', 4, 'api-token', '3d1538a9136c07afd9c0b4d93f43312bdc0dc5fc2299d108866b047b4f91a79c', '[\"*\"]', '2026-05-27 22:19:14', NULL, '2026-05-27 22:13:47', '2026-05-27 22:19:14'),
(35, 'App\\Models\\User', 3, 'api-token', 'f3055d165f18152b7613bd3ee1d63b951df2154ca870775ea6b83037cec5180e', '[\"*\"]', '2026-05-27 22:28:11', NULL, '2026-05-27 22:20:46', '2026-05-27 22:28:11'),
(36, 'App\\Models\\User', 2, 'api-token', '96ad07e969b4dba6223c7e53aeb0f69860b52c5a0898d0dbb031c20b94c0709a', '[\"*\"]', '2026-05-27 23:07:31', NULL, '2026-05-27 22:48:32', '2026-05-27 23:07:31'),
(37, 'App\\Models\\User', 2, 'api-token', '1574ee76f88af4bcf6db25cc11b48952d57f0d93e5a8779b86c179ca324ab4d6', '[\"*\"]', '2026-05-27 23:36:49', NULL, '2026-05-27 23:13:12', '2026-05-27 23:36:49'),
(38, 'App\\Models\\User', 1, 'api-token', '2069f332613a34fd7422dca88ca2c99a2ecb185df347db52366b71b98bfbac49', '[\"*\"]', '2026-05-28 00:21:58', NULL, '2026-05-27 23:58:31', '2026-05-28 00:21:58'),
(39, 'App\\Models\\User', 2, 'api-token', 'a24274feff0b83ec1dda44b21361a9f2e09ec626d43fda2415738f612bb31632', '[\"*\"]', '2026-05-28 00:25:22', NULL, '2026-05-28 00:23:03', '2026-05-28 00:25:22'),
(40, 'App\\Models\\User', 1, 'api-token', '1917793597e1558cbbf7b6e8b52a0811a850308b518e6f232a0b438003ab187a', '[\"*\"]', '2026-05-28 00:54:01', NULL, '2026-05-28 00:27:06', '2026-05-28 00:54:01'),
(41, 'App\\Models\\User', 2, 'api-token', '99569f520e003e967077104b8513e31df450369e00b7e2b37d3213462a681b30', '[\"*\"]', '2026-05-28 14:10:20', NULL, '2026-05-28 01:31:21', '2026-05-28 14:10:20'),
(42, 'App\\Models\\User', 1, 'api-token', '6ab5743f0fce15cce5061efde8c2ef8739104dfe0db22190932fc0475630aa5f', '[\"*\"]', '2026-05-28 15:43:25', NULL, '2026-05-28 14:10:36', '2026-05-28 15:43:25'),
(43, 'App\\Models\\User', 2, 'api-token', '32551b266cb86bc0ce409a4bffab42a2682dd72443b64705fc90ce01380ae25c', '[\"*\"]', '2026-05-28 15:44:04', NULL, '2026-05-28 15:43:57', '2026-05-28 15:44:04'),
(44, 'App\\Models\\User', 3, 'api-token', '0c31ab9551af5321a90fe4f30b004d9e2c7a0b1d992f52338e77f027267406c1', '[\"*\"]', '2026-05-28 15:45:07', NULL, '2026-05-28 15:44:52', '2026-05-28 15:45:07'),
(45, 'App\\Models\\User', 1, 'api-token', 'a8e5ebabe6112432b9b87d490020e56858cf5e153de2cd65d2252cc58cbe2dae', '[\"*\"]', '2026-05-28 16:00:10', NULL, '2026-05-28 15:45:26', '2026-05-28 16:00:10'),
(46, 'App\\Models\\User', 2, 'api-token', 'c8d860c2ddbbde721c74ede65cff3a13d1e1de59bb8726e39b14785d81e73997', '[\"*\"]', '2026-05-28 16:00:57', NULL, '2026-05-28 16:00:55', '2026-05-28 16:00:57'),
(47, 'App\\Models\\User', 3, 'api-token', '6022f2b1353a890d54d124a2016b9c1dcd6d523eef16762b1bb7f0670fa90aca', '[\"*\"]', '2026-05-28 16:01:49', NULL, '2026-05-28 16:01:19', '2026-05-28 16:01:49'),
(48, 'App\\Models\\User', 2, 'api-token', 'bf43a5ae5c32946ec180b5bc0a3f100ba953e82f6f52fae61a8ed86e528e2ca3', '[\"*\"]', '2026-05-28 16:02:11', NULL, '2026-05-28 16:02:10', '2026-05-28 16:02:11'),
(49, 'App\\Models\\User', 3, 'api-token', '8fa4a6f65e17cd40e8b1a0dda57a8b3d9aa28d5680c1609b5652839a3cc58d26', '[\"*\"]', '2026-05-28 16:02:58', NULL, '2026-05-28 16:02:30', '2026-05-28 16:02:58'),
(50, 'App\\Models\\User', 2, 'api-token', 'f0ee795710dd481ced4497b47241b1a0617125ac25583482e0ac09c77c8b845e', '[\"*\"]', '2026-05-28 16:03:17', NULL, '2026-05-28 16:03:16', '2026-05-28 16:03:17'),
(51, 'App\\Models\\User', 2, 'api-token', '2c6a0984fb60f98e34bcdf31f6cae7587e2a408f306cbc56dd85edeb57c62926', '[\"*\"]', '2026-05-28 16:12:03', NULL, '2026-05-28 16:08:23', '2026-05-28 16:12:03'),
(52, 'App\\Models\\User', 3, 'api-token', '194fd5e6d627f9c7a6b9491971fbc272101b8b49c95dec1f37c2109a0b00cd84', '[\"*\"]', '2026-05-28 17:05:14', NULL, '2026-05-28 16:18:48', '2026-05-28 17:05:14'),
(53, 'App\\Models\\User', 1, 'api-token', 'f39ba7e46f58a12101be731a6c7040242fecb8986e398d4d4c0f3c42cd38f500', '[\"*\"]', '2026-05-28 17:54:35', NULL, '2026-05-28 17:14:23', '2026-05-28 17:54:35'),
(54, 'App\\Models\\User', 3, 'api-token', '176f320904ca9cb23a36e2743f84857d4385fa8b396aaa9a07687eb7cf012308', '[\"*\"]', NULL, NULL, '2026-05-28 17:55:08', '2026-05-28 17:55:08'),
(55, 'App\\Models\\User', 2, 'api-token', 'f468e1abff4a3088f2fb8c785f660a85d3116a91e09302ccb210ed19e3632d27', '[\"*\"]', '2026-05-28 19:23:01', NULL, '2026-05-28 18:12:25', '2026-05-28 19:23:01'),
(56, 'App\\Models\\User', 1, 'api-token', '9474269996206f79c9ee741cf98b7ede22e0331b44bd9b1ad0c6f834acf29a09', '[\"*\"]', '2026-05-28 19:24:48', NULL, '2026-05-28 19:23:43', '2026-05-28 19:24:48'),
(57, 'App\\Models\\User', 2, 'api-token', 'b7caf459ad6fd3263422754c6d3ceec1b4a6b4e16a7b0e0beaea6354d206843a', '[\"*\"]', '2026-05-28 19:36:59', NULL, '2026-05-28 19:28:46', '2026-05-28 19:36:59'),
(58, 'App\\Models\\User', 3, 'api-token', 'bde7e983bb696154d41c6ac05151415037521de248e81bc56ea98c26ce3d7258', '[\"*\"]', NULL, NULL, '2026-05-28 19:38:00', '2026-05-28 19:38:00'),
(59, 'App\\Models\\User', 3, 'api-token', '2327be6b8bc0111c9b849f8a00e27b256adb0a1c460bf6c408fab39accd8b3d4', '[\"*\"]', NULL, NULL, '2026-05-28 19:51:03', '2026-05-28 19:51:03'),
(60, 'App\\Models\\User', 3, 'api-token', 'e7d8061007929b58773709ec6a6b30582f8a5e9acbad1bb78829d2e20f2b270f', '[\"*\"]', '2026-05-28 20:12:46', NULL, '2026-05-28 19:51:25', '2026-05-28 20:12:46'),
(61, 'App\\Models\\User', 3, 'api-token', 'bad99bbb7de49207e8c4c96cfea1b5494aa76947a8b14d7071a03cc540835b48', '[\"*\"]', '2026-05-28 20:47:37', NULL, '2026-05-28 20:35:41', '2026-05-28 20:47:37'),
(62, 'App\\Models\\User', 1, 'api-token', '82af56b87ede6e98d0d231b47c6038bf4a1786d1f2c4b4b57d31a4452ab75c87', '[\"*\"]', '2026-05-28 20:48:38', NULL, '2026-05-28 20:48:11', '2026-05-28 20:48:38'),
(63, 'App\\Models\\User', 3, 'api-token', '9ea4d017728ed79e217e72430c271754894271b2c5191e16379768aefc65e65b', '[\"*\"]', '2026-05-28 20:49:07', NULL, '2026-05-28 20:48:55', '2026-05-28 20:49:07'),
(64, 'App\\Models\\User', 3, 'api-token', 'cbfac5c2d653007533ec5a296d4c3732b0f2b1dd6d03eb07a4e94efe78c55ae9', '[\"*\"]', '2026-05-28 20:50:59', NULL, '2026-05-28 20:50:54', '2026-05-28 20:50:59'),
(65, 'App\\Models\\User', 3, 'api-token', '240fb73962732c269ff9d5ee0d5502291eb62c0a799f5243b8be9c4503b48a25', '[\"*\"]', '2026-05-28 21:02:23', NULL, '2026-05-28 20:53:02', '2026-05-28 21:02:23'),
(66, 'App\\Models\\User', 3, 'api-token', '021bfe2b049c0fab02a7f9e0b7b3258d02042750dccfed9953c875738f21e008', '[\"*\"]', '2026-05-28 21:02:43', NULL, '2026-05-28 21:02:42', '2026-05-28 21:02:43'),
(67, 'App\\Models\\User', 3, 'api-token', '04d1903a2666f60542ca025598a4ed71954ed67f6976c4f27665c7cd7644027e', '[\"*\"]', '2026-05-29 20:11:25', NULL, '2026-05-28 21:20:14', '2026-05-29 20:11:25'),
(68, 'App\\Models\\User', 3, 'api-token', '6144891181e0ed45a6424f3cb06611b77f6618f32a47dc1559f3dc1ccf4e55cb', '[\"*\"]', '2026-05-29 20:15:23', NULL, '2026-05-29 20:15:12', '2026-05-29 20:15:23'),
(69, 'App\\Models\\User', 4, 'api-token', '36b3bdb2f2cc4f368927c6a83db07afb503337ad69acb811ee17a749c8a04785', '[\"*\"]', NULL, NULL, '2026-05-29 20:16:53', '2026-05-29 20:16:53'),
(70, 'App\\Models\\User', 1, 'api-token', '7397b9d7fa100840e7d7e99daf81a69e3d3be77d2158186fcdad477e23e10c4e', '[\"*\"]', '2026-05-29 20:17:27', NULL, '2026-05-29 20:17:22', '2026-05-29 20:17:27'),
(71, 'App\\Models\\User', 2, 'api-token', 'a8d49721b1e3895b84e471ce3149d1efd458f1f041a6792aa52944a3b35d2ca0', '[\"*\"]', '2026-05-29 20:41:19', NULL, '2026-05-29 20:27:56', '2026-05-29 20:41:19'),
(72, 'App\\Models\\User', 4, 'api-token', 'c7de6813dab2ccae5d0ed62dfeed2e582421b1fbd5bd255f245867494dffe4e5', '[\"*\"]', '2026-05-29 22:19:25', NULL, '2026-05-29 20:42:56', '2026-05-29 22:19:25'),
(73, 'App\\Models\\User', 2, 'api-token', '9a2a5705c97225a8cc8c59ffa8d4c4f5da55e0e2ace378387dccf37708f2b971', '[\"*\"]', '2026-05-29 21:20:03', NULL, '2026-05-29 21:19:07', '2026-05-29 21:20:03'),
(74, 'App\\Models\\User', 1, 'api-token', '84b873356a9a47400150ba428fc00c9c4afef1f167343576d112785f88d78715', '[\"*\"]', '2026-05-29 21:21:13', NULL, '2026-05-29 21:20:37', '2026-05-29 21:21:13'),
(75, 'App\\Models\\User', 4, 'api-token', '913c1590a905150bbc223f81dc8d5d52c7430f4f834e5e9ba759edcc8ea587a8', '[\"*\"]', '2026-05-29 21:50:01', NULL, '2026-05-29 21:24:41', '2026-05-29 21:50:01'),
(76, 'App\\Models\\User', 2, 'api-token', '79775c2decca9e38e2ce79bdf0ef3f36612a047bd7c1c30b1e8b5625526a2b40', '[\"*\"]', '2026-05-29 22:18:12', NULL, '2026-05-29 21:50:36', '2026-05-29 22:18:12'),
(77, 'App\\Models\\User', 2, 'api-token', '5f4a57b763be7ccef96d51ca80263b04800a0a9d5f91d21ca058796459ffffe4', '[\"*\"]', '2026-05-29 22:19:50', NULL, '2026-05-29 22:19:48', '2026-05-29 22:19:50'),
(78, 'App\\Models\\User', 4, 'api-token', '7226eec6daf275a7e93ad3b1f5eaf69b23e7dd8a269de95460e3a89e9bd75386', '[\"*\"]', '2026-05-29 22:20:34', NULL, '2026-05-29 22:20:26', '2026-05-29 22:20:34'),
(79, 'App\\Models\\User', 2, 'api-token', '1fc9e421d6d04ba0f6ee4d760077f53cca9d685785af174f9e62ab8b0c6deb0a', '[\"*\"]', '2026-05-29 22:25:23', NULL, '2026-05-29 22:20:51', '2026-05-29 22:25:23'),
(80, 'App\\Models\\User', 4, 'api-token', '8a463d7e1da595bb2b4cb1fbdca4e1f10daf0de752cefd4adabc52af7b475b1d', '[\"*\"]', '2026-05-29 22:26:19', NULL, '2026-05-29 22:25:53', '2026-05-29 22:26:19'),
(81, 'App\\Models\\User', 2, 'api-token', '5d53b40aa2b9f572eb547c57eff3eb3bf8a71043739af267eec518d35ba99bfa', '[\"*\"]', '2026-05-29 22:26:44', NULL, '2026-05-29 22:26:35', '2026-05-29 22:26:44'),
(82, 'App\\Models\\User', 4, 'api-token', 'fdadeb4d5a5237f0d68797f4b3de59998ee59bacc819e92248bdead180d4d03b', '[\"*\"]', '2026-06-01 17:55:33', NULL, '2026-06-01 17:55:12', '2026-06-01 17:55:33'),
(83, 'App\\Models\\User', 2, 'api-token', '89eca3aae86d6f468577682be26573e1ef363ef9b31deb31ae25ad0adcbe1bae', '[\"*\"]', '2026-06-01 17:57:07', NULL, '2026-06-01 17:56:06', '2026-06-01 17:57:07'),
(84, 'App\\Models\\User', 1, 'api-token', '2aa0080caa52dfe3a445f70513971400ce8e07f66d9015efa14aa36a10481871', '[\"*\"]', '2026-06-01 17:57:46', NULL, '2026-06-01 17:57:30', '2026-06-01 17:57:46'),
(85, 'App\\Models\\User', 2, 'api-token', '6885f0df2f006d7ae6c887238d31ab64e5a066a5af9b86a95914d9d53a206e5a', '[\"*\"]', '2026-06-01 17:58:07', NULL, '2026-06-01 17:58:05', '2026-06-01 17:58:07'),
(86, 'App\\Models\\User', 4, 'api-token', 'c270f52081bb33022d015c1fab52df4a0932234f339beb1bd4b55b6152f1c556', '[\"*\"]', '2026-06-01 17:59:08', NULL, '2026-06-01 17:58:50', '2026-06-01 17:59:08'),
(87, 'App\\Models\\User', 2, 'api-token', '86d8171819543419d121cc2f16c7d5ae5644b1242139c18edc26e99b64a7139f', '[\"*\"]', '2026-06-01 17:59:54', NULL, '2026-06-01 17:59:32', '2026-06-01 17:59:54'),
(88, 'App\\Models\\User', 2, 'api-token', 'cf9c3d010dc4a542ae086b02e27b8afeaca9d176b2e0ce1fdb8ca9524fd81cd6', '[\"*\"]', '2026-06-01 18:13:15', NULL, '2026-06-01 18:13:06', '2026-06-01 18:13:15'),
(89, 'App\\Models\\User', 2, 'api-token', '3af265c23ab270552cf23771ebdc857fc3089e384bbc860e83046aaf56d4a9ac', '[\"*\"]', '2026-06-02 07:17:35', NULL, '2026-06-02 07:17:32', '2026-06-02 07:17:35'),
(90, 'App\\Models\\User', 4, 'api-token', '95ba7d2f2451adb2ef689c469428ea4fab7830966ffd6508e8d7873a448cc6e8', '[\"*\"]', '2026-06-02 07:18:50', NULL, '2026-06-02 07:18:26', '2026-06-02 07:18:50'),
(91, 'App\\Models\\User', 2, 'api-token', '1bdd65904873cc5849af3830866407440a4b2192831d7454257a16cf67ee24d7', '[\"*\"]', '2026-06-02 07:19:53', NULL, '2026-06-02 07:19:21', '2026-06-02 07:19:53'),
(92, 'App\\Models\\User', 2, 'api-token', 'b21175eadf8f5c7babd6bab8be388bfb7ee9c4d40e638ce5a602290cd2db55bb', '[\"*\"]', '2026-06-02 07:24:58', NULL, '2026-06-02 07:20:35', '2026-06-02 07:24:58'),
(93, 'App\\Models\\User', 1, 'api-token', 'b7e7fc7b7869c5a2e30e6da75c681bec188109f7116d3afa758349dc127fe79e', '[\"*\"]', '2026-06-02 07:27:58', NULL, '2026-06-02 07:27:45', '2026-06-02 07:27:58'),
(94, 'App\\Models\\User', 5, 'api-token', '3f66e4d539b3c6443bca801af2903ccd84f42aaefc7ec6f1f8d3d5e814f32fe9', '[\"*\"]', '2026-06-02 07:31:24', NULL, '2026-06-02 07:28:51', '2026-06-02 07:31:24'),
(95, 'App\\Models\\User', 1, 'api-token', 'afae9c0459895c3dbaa85dfe8eb31df7104fa238f9409af3a9684959a2cb6025', '[\"*\"]', '2026-06-02 07:43:01', NULL, '2026-06-02 07:32:04', '2026-06-02 07:43:01'),
(96, 'App\\Models\\User', 4, 'api-token', '349eca3741b58ba98203812d842a44260bf9260f9ba18f23d7e55a503f79e5ee', '[\"*\"]', '2026-06-10 18:25:50', NULL, '2026-06-10 18:25:41', '2026-06-10 18:25:50'),
(97, 'App\\Models\\User', 2, 'api-token', '88a6f8d5b50f19d326e0cb59e620f60b04022e9d1da3b900fcc445554af6049e', '[\"*\"]', '2026-06-10 18:28:21', NULL, '2026-06-10 18:26:31', '2026-06-10 18:28:21'),
(98, 'App\\Models\\User', 1, 'api-token', '907d2bde95c5ff2cb8f7a14a6fa1b79965d56594e4e0fd7e8b07999ca3a521c4', '[\"*\"]', '2026-06-10 18:29:25', NULL, '2026-06-10 18:29:11', '2026-06-10 18:29:25'),
(99, 'App\\Models\\User', 2, 'api-token', 'fac12b87f80fb69f97b0916942ad935e3e6b9606e1a2f2d138ca30b7d535c55c', '[\"*\"]', '2026-06-10 18:29:45', NULL, '2026-06-10 18:29:42', '2026-06-10 18:29:45'),
(100, 'App\\Models\\User', 3, 'api-token', 'e7e4e3646d564439ce7ab6b728b33bc60857f1f854e0dc2091d33e8d855f1d26', '[\"*\"]', '2026-06-10 18:30:39', NULL, '2026-06-10 18:30:15', '2026-06-10 18:30:39'),
(101, 'App\\Models\\User', 2, 'api-token', '4446ea11e5ae48fd1a33b0be6371ed806b862f036ef3e4a31ee2e2988c0729e2', '[\"*\"]', '2026-06-10 19:35:03', NULL, '2026-06-10 18:30:55', '2026-06-10 19:35:03'),
(102, 'App\\Models\\User', 4, 'api-token', 'fdb763f9d250217994894bbb3031eff37920fb9fad780f7f5738477bceeba827', '[\"*\"]', '2026-06-10 19:36:34', NULL, '2026-06-10 19:36:14', '2026-06-10 19:36:34'),
(103, 'App\\Models\\User', 3, 'api-token', 'bbc00cb87bf1153ac89aee521fc721cde964a2f5f6d25c156711d7dca4b1068c', '[\"*\"]', '2026-06-10 19:37:18', NULL, '2026-06-10 19:37:05', '2026-06-10 19:37:18'),
(104, 'App\\Models\\User', 5, 'api-token', '59611e0fba6c378c0481897348564306f1bfdb746a7c7707424e11032898911f', '[\"*\"]', '2026-06-10 19:38:45', NULL, '2026-06-10 19:37:59', '2026-06-10 19:38:45'),
(105, 'App\\Models\\User', 2, 'api-token', '99f49bf30d65672ea8f2b816603554560b1f8f3cf2ab1cf5deaf7ea6e0e48073', '[\"*\"]', '2026-06-10 19:42:22', NULL, '2026-06-10 19:39:47', '2026-06-10 19:42:22'),
(106, 'App\\Models\\User', 1, 'api-token', '499fe1d805df556994848551a7fb3e525250d4964e42bd7471549d2a40ea554b', '[\"*\"]', '2026-06-10 19:46:05', NULL, '2026-06-10 19:42:45', '2026-06-10 19:46:05'),
(107, 'App\\Models\\User', 5, 'api-token', '8b2e83303a144d97611fcdd6b3b1ac5292c0cbf8c5bfdfa81b5665dbbd965693', '[\"*\"]', '2026-06-10 20:01:31', NULL, '2026-06-10 20:00:58', '2026-06-10 20:01:31'),
(108, 'App\\Models\\User', 1, 'api-token', 'a680c86c402110836420510b2e7b30ce6e9df85432464a47d3fee817abb4fec6', '[\"*\"]', '2026-06-10 20:09:49', NULL, '2026-06-10 20:01:46', '2026-06-10 20:09:49'),
(109, 'App\\Models\\User', 2, 'api-token', '7699a5a6a78a197bab3124883f03666798a07a72352e3d1f96834a9ea98c0740', '[\"*\"]', '2026-06-10 20:11:01', NULL, '2026-06-10 20:10:07', '2026-06-10 20:11:01'),
(110, 'App\\Models\\User', 1, 'api-token', 'eb07ed11406ac2f5f3dffc3e7969660474645b2345215d4b4481d676468d7132', '[\"*\"]', '2026-06-10 20:26:13', NULL, '2026-06-10 20:11:14', '2026-06-10 20:26:13'),
(111, 'App\\Models\\User', 2, 'api-token', 'c735ddf4e33cd813a759c84173abd98100b4a3191194e74620d6bcfa9f87fd5d', '[\"*\"]', '2026-06-10 20:27:13', NULL, '2026-06-10 20:26:39', '2026-06-10 20:27:13'),
(112, 'App\\Models\\User', 1, 'api-token', '9401d0289e2942d96e1165627b1bb9e25bc4daafc428fc669f35095bde72ac78', '[\"*\"]', '2026-06-10 20:31:10', NULL, '2026-06-10 20:27:30', '2026-06-10 20:31:10'),
(113, 'App\\Models\\User', 4, 'api-token', '42fd7c1a815dbbcbc762ca5528a2065d0a2e120771235ea0d92e37d507d2ae88', '[\"*\"]', '2026-06-10 20:35:01', NULL, '2026-06-10 20:34:44', '2026-06-10 20:35:01'),
(114, 'App\\Models\\User', 2, 'api-token', 'e71543627808d95f1d8883bcd75f283d94ac90380b9414fdfa03d2a8e64587f0', '[\"*\"]', '2026-06-11 13:36:31', NULL, '2026-06-11 13:35:33', '2026-06-11 13:36:31'),
(115, 'App\\Models\\User', 1, 'api-token', '2fa93e4dac66ff1037caceb46f348c884a3ea407f1237c36ae80e4df9834af04', '[\"*\"]', '2026-06-11 13:37:32', NULL, '2026-06-11 13:37:04', '2026-06-11 13:37:32'),
(116, 'App\\Models\\User', 2, 'api-token', 'ce39b0898eb0ac8c92cbf872685fe0f927085b210e8ee8fdd01f10ef51eacac2', '[\"*\"]', '2026-06-11 14:04:27', NULL, '2026-06-11 14:03:38', '2026-06-11 14:04:27'),
(117, 'App\\Models\\User', 1, 'api-token', '5f846f0a0ba472574acde7da418531bb1e6ad2777486b39d4356dfb191befeac', '[\"*\"]', '2026-06-11 14:11:20', NULL, '2026-06-11 14:04:52', '2026-06-11 14:11:20'),
(118, 'App\\Models\\User', 2, 'api-token', '1890861edf7fa8193598074797a5d63f538c74644005e45c93251ef1986023fe', '[\"*\"]', '2026-06-11 14:12:17', NULL, '2026-06-11 14:11:50', '2026-06-11 14:12:17'),
(119, 'App\\Models\\User', 1, 'api-token', '23b126605abfff1b05dae73611756b5aec84fa89a8cb9bc3a1eea1c4d97c2d59', '[\"*\"]', '2026-06-11 14:12:56', NULL, '2026-06-11 14:12:44', '2026-06-11 14:12:56'),
(120, 'App\\Models\\User', 2, 'api-token', 'a7f240c8901652d8331d4e8452e14016f22783e04789f143653b9388b4457951', '[\"*\"]', '2026-06-11 14:18:26', NULL, '2026-06-11 14:17:56', '2026-06-11 14:18:26'),
(121, 'App\\Models\\User', 1, 'api-token', 'f97479811453b1c9e9aeebeae4554352a4922182a0877b64874b8b1dd80ed926', '[\"*\"]', '2026-06-11 14:19:00', NULL, '2026-06-11 14:18:43', '2026-06-11 14:19:00'),
(122, 'App\\Models\\User', 2, 'api-token', '7b3ef1aaf6ffca31f41efefa2e487f14db8634ec100d423279fb619d56dd11aa', '[\"*\"]', '2026-06-11 15:02:30', NULL, '2026-06-11 15:01:35', '2026-06-11 15:02:30'),
(123, 'App\\Models\\User', 1, 'api-token', 'db98e8bd826918237bab662ff9d157c756b986d4daac9bde3ddf2278d4ca1407', '[\"*\"]', '2026-06-11 15:03:26', NULL, '2026-06-11 15:03:12', '2026-06-11 15:03:26'),
(124, 'App\\Models\\User', 2, 'api-token', '661560ba812b75546124435d5e4961ad75c0d7f51990780e64d687b54842cc47', '[\"*\"]', '2026-06-11 15:04:23', NULL, '2026-06-11 15:03:59', '2026-06-11 15:04:23'),
(125, 'App\\Models\\User', 1, 'api-token', 'b20a656f61beb242ffe549816a4dede2f356b536c2648c167c6ec8503f3be3d7', '[\"*\"]', '2026-06-12 10:03:42', NULL, '2026-06-11 15:04:51', '2026-06-12 10:03:42'),
(126, 'App\\Models\\User', 2, 'api-token', 'cdf91888725a43c4301b86aa1d1ecdf8a71e5192f907dc48da8ba31fcbfc3fee', '[\"*\"]', '2026-06-12 10:06:33', NULL, '2026-06-12 10:05:55', '2026-06-12 10:06:33'),
(127, 'App\\Models\\User', 1, 'api-token', 'fd553f283c54643c3d19efe95a11c4f38bc7cbe150984052c257c319f9c5a9c9', '[\"*\"]', '2026-06-12 10:09:09', NULL, '2026-06-12 10:08:32', '2026-06-12 10:09:09'),
(128, 'App\\Models\\User', 2, 'api-token', '7ffe035af3827153e6ff61a33c1e64322e50996e05fa8984ccf5a34215d0e4d6', '[\"*\"]', '2026-06-12 10:09:45', NULL, '2026-06-12 10:09:19', '2026-06-12 10:09:45'),
(129, 'App\\Models\\User', 1, 'api-token', '5056eff82c05f29ef714ada3a20e276944481e1c236e471141d5bdea260530e9', '[\"*\"]', '2026-06-12 10:45:00', NULL, '2026-06-12 10:10:13', '2026-06-12 10:45:00'),
(130, 'App\\Models\\User', 2, 'api-token', 'c3c3db287895b5c6c713275a0d8134aa8c6156a6e2539feb71b9bbdc8fd22887', '[\"*\"]', '2026-06-12 11:09:09', NULL, '2026-06-12 10:45:09', '2026-06-12 11:09:09'),
(131, 'App\\Models\\User', 1, 'api-token', '0dfbba96ce279cc133d992a66c94497f50263ab177ba34a0eb1d0be56a9e9f60', '[\"*\"]', '2026-06-12 11:09:52', NULL, '2026-06-12 11:09:30', '2026-06-12 11:09:52'),
(132, 'App\\Models\\User', 2, 'api-token', '1c16d4d30ad4004b571501958cc3f29940b43f063d098b9baecf9f551a2f3415', '[\"*\"]', '2026-06-12 11:19:27', NULL, '2026-06-12 11:10:00', '2026-06-12 11:19:27'),
(133, 'App\\Models\\User', 1, 'api-token', '7ffbd51a447bb89ae546cb524ef3ed2d0a9eea026f589f149070a59cc97385ec', '[\"*\"]', '2026-06-12 11:20:08', NULL, '2026-06-12 11:19:47', '2026-06-12 11:20:08'),
(134, 'App\\Models\\User', 2, 'api-token', 'f250c7a67abfddef9cf21bd3c3a6f5a9e9c4accb5dcc674554b2f04ccd5e9032', '[\"*\"]', '2026-06-12 12:13:01', NULL, '2026-06-12 11:37:08', '2026-06-12 12:13:01'),
(135, 'App\\Models\\User', 1, 'api-token', 'a9646d0d549328e4125cb557e9f5eebb1fe1d236dd7b00afcca8d6caaec65285', '[\"*\"]', '2026-06-12 12:13:26', NULL, '2026-06-12 12:13:16', '2026-06-12 12:13:26'),
(136, 'App\\Models\\User', 2, 'api-token', '874bd568ddf4caeb1301bf717e0304876852c7fa0f68b51c60d39be42d43e874', '[\"*\"]', '2026-06-12 12:15:01', NULL, '2026-06-12 12:14:23', '2026-06-12 12:15:01'),
(137, 'App\\Models\\User', 1, 'api-token', '5f1bd4c5b01544c025af63ce40697d594617eb7f9cdba771bbc3f80d7b47a003', '[\"*\"]', '2026-06-12 12:15:38', NULL, '2026-06-12 12:15:21', '2026-06-12 12:15:38'),
(138, 'App\\Models\\User', 2, 'api-token', '39ff9c127a20b93afc5aa7b639a0f8fa1040e618067258af1e0524b1a0b5508c', '[\"*\"]', '2026-06-12 12:16:58', NULL, '2026-06-12 12:16:17', '2026-06-12 12:16:58'),
(139, 'App\\Models\\User', 1, 'api-token', 'c35c95607fb921c806a99ddfdc69eb2eb8b2ce936631a99b498411c4475df2e7', '[\"*\"]', '2026-06-12 12:17:22', NULL, '2026-06-12 12:17:11', '2026-06-12 12:17:22'),
(140, 'App\\Models\\User', 2, 'api-token', 'c8fae12d7d61816bb7ad95ee5464f58b75dd6aba3c66e3081548ec287a487f29', '[\"*\"]', '2026-06-15 04:14:28', NULL, '2026-06-15 04:14:25', '2026-06-15 04:14:28'),
(141, 'App\\Models\\User', 4, 'api-token', '0b04525fc1e10b271f371ebbed856cab932ed7e24086bca35897537f378a2963', '[\"*\"]', '2026-06-15 04:16:01', NULL, '2026-06-15 04:15:32', '2026-06-15 04:16:01');

-- --------------------------------------------------------

--
-- بنية الجدول `properties`
--

CREATE TABLE `properties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `owner_id` bigint(20) UNSIGNED NOT NULL,
  `university_id` bigint(20) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `property_type` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `region` varchar(255) NOT NULL,
  `district` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `area` decimal(10,2) DEFAULT NULL,
  `amenities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`amenities`)),
  `payment_method` varchar(255) DEFAULT NULL,
  `division_accept` varchar(255) NOT NULL DEFAULT 'no',
  `division_count` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `rooms_count` int(11) NOT NULL,
  `bathrooms_count` int(11) DEFAULT 0,
  `price` decimal(10,2) NOT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `is_student_friendly` tinyint(1) NOT NULL DEFAULT 0,
  `has_student_discount` tinyint(1) NOT NULL DEFAULT 0,
  `student_discount_percentage` decimal(5,2) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `approved_by` bigint(20) UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `owner_notified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `properties`
--

INSERT INTO `properties` (`id`, `owner_id`, `university_id`, `title`, `description`, `property_type`, `city`, `region`, `district`, `address`, `area`, `amenities`, `payment_method`, `division_accept`, `division_count`, `latitude`, `longitude`, `rooms_count`, `bathrooms_count`, `price`, `is_available`, `is_student_friendly`, `has_student_discount`, `student_discount_percentage`, `status`, `approved_by`, `approved_at`, `owner_notified_at`, `created_at`, `updated_at`) VALUES
(2, 2, NULL, 'zzzzzzzz', 'sssssssssss', 'apartment', 'damascus', 'fdddd', NULL, 'يشيسءيشسيشي', 2.00, NULL, NULL, 'no', NULL, NULL, NULL, 2, 0, 22.00, 1, 1, 1, 0.00, 'approved', 1, '2026-05-22 22:10:28', NULL, '2026-05-22 21:19:19', '2026-05-22 22:10:28'),
(3, 2, NULL, 'xxxxxx', 'lsslslllslsllsls', 'shop', 'damascus', 'kmdmmdmmd', NULL, 'sllslsllslslsls', 33.00, NULL, NULL, 'no', NULL, NULL, NULL, 3, 0, 3.00, 1, 0, 1, 0.00, 'approved', 1, '2026-05-22 22:10:22', NULL, '2026-05-22 21:20:46', '2026-05-22 22:10:22'),
(4, 1, NULL, 'vdcvdv', 'gtgggggrg', 'apartment', 'damascus', 'jfhfhf', NULL, 'يشيسءيشسيشي', 4.00, NULL, NULL, 'no', NULL, NULL, NULL, 4, 0, 4.00, 1, 0, 1, 0.00, 'approved', 1, '2026-05-23 17:44:29', NULL, '2026-05-22 22:22:08', '2026-05-23 17:44:29'),
(5, 2, NULL, 'fdgdfgdsf', 'dfgdgdffg', 'house', 'damascus', 'المالكي', NULL, '3ghfghg', 3.00, NULL, NULL, 'no', NULL, NULL, NULL, 3, 0, 3.00, 1, 0, 1, 0.00, 'approved', 1, '2026-05-23 17:44:26', NULL, '2026-05-23 09:06:35', '2026-05-23 17:44:26'),
(6, 2, NULL, 'جمشثق', 'سبيبقبر بقريق', 'apartment', 'damascus', 'المالكي', NULL, 'يلليبييي ببرل', 34.00, NULL, NULL, 'no', NULL, NULL, NULL, 3, 0, 34.00, 1, 0, 1, 0.00, 'approved', 1, '2026-05-23 17:44:22', NULL, '2026-05-23 09:07:24', '2026-05-23 17:44:22'),
(7, 1, NULL, 'wwew', 'retert', 'villa', 'damascus', 'الزاهرة', NULL, 'الزاهرة ,مقابل الفرن الالي', 23.00, NULL, NULL, 'no', NULL, NULL, NULL, 2, 0, 3223.00, 1, 1, 1, 5.00, 'approved', 1, '2026-05-23 17:45:57', NULL, '2026-05-23 17:45:46', '2026-05-23 17:45:57'),
(8, 2, NULL, 'يبليبليبلي', 'وصف العقار', 'apartment', 'damascus', 'الزاهرة', NULL, 'عنوان تفصيلي', 43.00, NULL, NULL, 'no', NULL, NULL, NULL, 43, 0, 32.00, 1, 0, 1, 0.00, 'approved', 1, '2026-05-24 14:29:13', NULL, '2026-05-23 19:57:36', '2026-05-24 14:29:13'),
(9, 2, NULL, 'عنوان', 'سشبسسبسب', 'house', 'damascus', 'المالكي', NULL, 'يبسيبس', 23.00, NULL, NULL, 'no', NULL, NULL, NULL, 2, 0, 23.00, 1, 0, 1, 0.00, 'approved', 1, '2026-05-24 14:29:10', NULL, '2026-05-23 19:58:53', '2026-05-24 14:29:10'),
(10, 1, NULL, 'منزل', 'ييييييييييي', 'house', 'damascus', 'الزاهرة', NULL, 'ثصثصثص', 21.00, NULL, NULL, 'no', NULL, NULL, NULL, 21, 0, 21.00, 1, 1, 1, 5.00, 'approved', 1, '2026-05-24 11:15:21', NULL, '2026-05-24 11:14:51', '2026-05-24 11:15:21'),
(11, 2, NULL, 'منزل', 'يييييييصصصصصصصصصصصصصصصص', 'apartment', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمن', 21.00, NULL, NULL, 'no', NULL, NULL, NULL, 2, 0, 34000.00, 1, 0, 1, 0.00, 'approved', 1, '2026-05-24 12:50:07', NULL, '2026-05-24 12:49:28', '2026-05-24 12:50:07'),
(12, 2, 2, 'منزل جديد بعد التعجيلات', 'ؤيؤؤؤؤؤؤؤؤؤؤ', 'house', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمنص', 67.00, NULL, NULL, 'no', NULL, NULL, NULL, 5, 0, 2300000.00, 1, 1, 1, 5.00, 'approved', 1, '2026-05-24 13:26:57', NULL, '2026-05-24 13:26:30', '2026-05-24 13:26:57'),
(13, 1, 2, 'lk,..slkkd', 'eeeeeeeeeee', 'house', 'damascus', 'المالكي', NULL, 'wfrwfrwrwfrwrw', 44.00, NULL, NULL, 'no', NULL, NULL, NULL, 4, 0, 44444.00, 1, 1, 1, 5.00, 'approved', 1, '2026-05-24 13:37:02', NULL, '2026-05-24 13:36:49', '2026-05-24 13:37:02'),
(14, 1, NULL, 'vdcvdvd', '44444444444444444444ttg', 'house', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمن', 44.00, NULL, NULL, 'no', NULL, NULL, NULL, 4, 0, 344444.00, 1, 0, 1, 0.00, 'approved', 1, '2026-05-24 14:01:29', NULL, '2026-05-24 14:01:22', '2026-05-24 14:01:29'),
(15, 1, NULL, 'cccccccccc', '4rrrrrrrrrrr', 'apartment', 'damascus', 'المالكي', NULL, 'wfrwfrwrwfrwrw', 43.00, NULL, NULL, 'no', NULL, NULL, NULL, 4, 0, 343.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-24 14:24:33', NULL, '2026-05-24 14:24:25', '2026-05-24 14:24:33'),
(16, 1, NULL, 'newwww', 'ييييييييييييييييييييي', 'house', 'damascus', 'شارع بغداد', NULL, 'شارع بغداد جنب جامع عباد الرحمن', 66.00, '[]', NULL, 'no', NULL, NULL, NULL, 3, 0, 330000.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-24 19:01:53', NULL, '2026-05-24 19:01:42', '2026-05-24 19:01:53'),
(17, 1, NULL, 'ver', 'ddddddddddddddddddd', 'house', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمن', 33.00, '[]', NULL, 'no', NULL, NULL, NULL, 3, 0, 233333.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-24 19:14:12', NULL, '2026-05-24 19:11:49', '2026-05-24 19:14:12'),
(18, 1, NULL, 'derer', 'cccccccccccccccccccccccccc', 'apartment', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمن', 9.00, '[\"elevator\",\"garden\",\"gym\",\"furnished\"]', NULL, 'no', NULL, NULL, NULL, 9, 0, 34999.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-24 19:15:36', NULL, '2026-05-24 19:15:04', '2026-05-24 19:15:36'),
(19, 1, 2, 'verer', 'ddddddddddddddddd', 'villa', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمن', 23.00, '[\"garden\",\"gym\",\"balcony\"]', NULL, 'no', NULL, NULL, NULL, 3, 0, 340000.00, 1, 1, 1, 5.00, 'approved', 1, '2026-05-24 19:17:41', NULL, '2026-05-24 19:17:33', '2026-05-24 19:17:41'),
(20, 2, 10, 'منزل مشترك', 'ثييييييييييييييي', 'shared', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمن', 32.00, '[\"parking\",\"elevator\",\"security\",\"garden\",\"pool\",\"gym\",\"balcony\",\"furnished\"]', NULL, 'no', NULL, NULL, NULL, 2, 0, 2100000.00, 1, 1, 1, 10.00, 'approved', 1, '2026-05-24 21:12:57', NULL, '2026-05-24 21:12:25', '2026-05-24 21:12:57'),
(21, 1, 9, 'fgdggd', 'rrrrrrrrrrrrrrrrrrrr', 'shared', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمن', 5.00, '[\"parking\",\"elevator\",\"security\",\"garden\",\"pool\",\"gym\"]', 'cash', 'yes', '2', NULL, NULL, 5, 0, 45555.00, 1, 1, 1, 5.00, 'approved', 1, '2026-05-24 21:57:30', NULL, '2026-05-24 21:57:23', '2026-05-24 21:57:30'),
(22, 2, NULL, 'منزل', 'واو', 'house', 'quneitra', 'بيت جن', NULL, 'الشارع العام', 89.00, '[\"balcony\"]', 'cash', 'no', NULL, NULL, NULL, 3, 0, 866786.00, 1, 0, 0, 0.00, 'rejected', 1, '2026-05-28 00:52:57', NULL, '2026-05-27 23:14:14', '2026-05-28 00:52:57'),
(23, 2, NULL, 'فيلا السعادة', 'واوووووو جدااا', 'villa', 'damascus', 'عين ترما', NULL, 'مقابل اسواق الخير الله يرحمها', 77.00, '[\"garden\",\"pool\",\"gym\"]', 'cash', 'no', NULL, NULL, NULL, 5, 0, 39685.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-27 23:59:46', NULL, '2026-05-27 23:35:41', '2026-05-27 23:59:46'),
(24, 2, 2, 'شقة فاخرة', 'فاخر عالااخر', 'house', 'damascus', 'المالكييييييي', NULL, 'الشارع العامم', 76.00, '[\"balcony\"]', 'cash', 'yes', '2', NULL, NULL, 4, 0, 90.00, 1, 1, 1, 29.00, 'approved', 1, '2026-05-29 21:21:05', NULL, '2026-05-28 00:25:01', '2026-05-29 21:21:05'),
(25, 2, NULL, 'rdfd', '3eeeeeee', 'house', 'damascus', 'المالكيe', NULL, 'لالالالالالالالالالالالالالالالالالالا', 33.00, '[\"parking\"]', 'bank_transfer', 'no', NULL, NULL, NULL, 3, 0, 43333.00, 1, 0, 0, NULL, 'approved', 1, '2026-06-10 19:46:03', NULL, '2026-05-28 14:10:16', '2026-06-10 19:46:03'),
(26, 1, NULL, 'ؤؤؤؤؤ', 'ققققققققققققققق', 'apartment', 'aleppo', 'الزاهرة', NULL, 'الزاهرة ,مقابل الفرن الالي', 4.00, '[\"elevator\"]', 'check', 'no', NULL, NULL, NULL, 4, 0, 3444.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-28 14:37:45', NULL, '2026-05-28 14:34:46', '2026-05-28 14:37:45'),
(28, 1, NULL, 'bdfdbdfb', 'rrrrrrrrrrrr', 'apartment', 'aleppo', 'المالكي', NULL, 'الزاهرة ,مقابل الفرن الاليr', 34.00, '[\"balcony\"]', 'installments', 'no', NULL, NULL, NULL, 3, 0, 434.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-29 21:20:56', NULL, '2026-05-28 15:02:08', '2026-05-29 21:20:56'),
(29, 3, NULL, 'dssf', 'rfr', 'house', 'deir_ezzor', 'المالكيييييي', NULL, 'rffr', 3.00, '[\"parking\"]', 'installments', 'no', NULL, NULL, NULL, 3, 0, 3434.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-28 20:48:31', NULL, '2026-05-28 20:47:37', '2026-05-28 20:48:31'),
(30, 2, NULL, 'ؤؤؤؤؤؤؤؤ', '233233', 'office', 'damascus', 'المالكيسس', NULL, 'الزاهرة ,مقابل الفرن الالي', 32.00, '[\"parking\"]', 'bank_transfer', 'no', NULL, NULL, NULL, 3, 0, 232323.00, 1, 0, 0, 0.00, 'approved', 1, '2026-05-29 21:20:53', NULL, '2026-05-29 20:41:20', '2026-05-29 21:20:53'),
(31, 2, 2, 'برييل', 'ققققققققققققققق', 'house', 'damascus', 'المالكي', NULL, 'شارع بغداد جنب جامع عباد الرحمن3', 34.00, '[\"parking\",\"security\",\"pool\"]', 'cash', 'yes', '3', NULL, NULL, 3, 0, 43434.00, 1, 1, 1, 1.00, 'approved', 1, '2026-05-29 21:20:49', NULL, '2026-05-29 21:19:57', '2026-05-29 21:20:49'),
(32, 2, 13, 'daddad', 'dddddddddd', 'villa', 'damascus', 'jfhfhf', NULL, 'يشيسءيشسيشي', 23.00, '[\"parking\"]', 'cash', 'yes', '2', NULL, NULL, 2, 0, 232323.00, 1, 1, 1, 2.00, 'approved', 1, '2026-06-12 11:20:06', NULL, '2026-06-01 17:57:07', '2026-06-12 11:20:06'),
(33, 5, NULL, 'jknkj', 'fgd', 'villa', 'damascus', 'نهررعيشة', NULL, 'vrttrtrtrt', 67.00, '[\"elevator\",\"security\",\"garden\"]', 'bank_transfer', 'no', NULL, NULL, NULL, 2, 0, 66767.00, 1, 0, 0, NULL, 'approved', 1, '2026-06-10 20:09:47', NULL, '2026-06-02 07:31:25', '2026-06-10 20:09:47'),
(34, 2, NULL, 'cdcdcdc', 'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee', 'warehouse', 'damascus', 'fdddd', NULL, 'يشيسءيشسيشي', 34.00, '[\"balcony\"]', 'cash', 'no', NULL, NULL, NULL, 2, 0, 3434343.00, 1, 0, 0, NULL, 'approved', 1, '2026-06-12 11:09:50', NULL, '2026-06-11 15:02:30', '2026-06-12 11:09:50'),
(35, 2, NULL, 'قليلبل', 'ييييييييييييييي', 'apartment', 'damascus', 'نهررعيشة', NULL, 'الزاهرة ,مقابل الفرن الالي', 34.00, '[\"parking\",\"security\"]', 'cash', 'no', NULL, NULL, NULL, 4, 0, 443.00, 1, 0, 0, NULL, 'approved', 1, '2026-06-12 12:17:21', NULL, '2026-06-12 12:12:48', '2026-06-12 12:17:21');

-- --------------------------------------------------------

--
-- بنية الجدول `property_images`
--

CREATE TABLE `property_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `property_id` bigint(20) UNSIGNED NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `property_images`
--

INSERT INTO `property_images` (`id`, `property_id`, `image_path`, `is_main`, `created_at`, `updated_at`) VALUES
(1, 23, 'properties/23/JZfPlC5yUzbWdQB17eQ7cdIibxYOW1EVbr7P10x9.jpg', 1, '2026-05-27 23:35:43', '2026-05-27 23:35:43'),
(2, 23, 'properties/23/VGlatUcM5QiulAhwHbhWaKKGdvUFOmIcUzqYC097.jpg', 0, '2026-05-27 23:35:43', '2026-05-27 23:35:43'),
(3, 23, 'properties/23/ElEoqag53PrbYiXeQEjMV3srWN50al5QNAq4k4Jp.jpg', 0, '2026-05-27 23:35:43', '2026-05-27 23:35:43'),
(4, 23, 'properties/23/fbTdHgKkIZfp1nwKMYktHEyJ7IlHek16OyWRMW6I.jpg', 0, '2026-05-27 23:35:43', '2026-05-27 23:35:43'),
(5, 24, 'properties/24/h1a62PLAaqd6HHJoXHI2WzMU174eAiYlYxrjN6rY.jpg', 1, '2026-05-28 00:25:02', '2026-05-28 00:25:02'),
(6, 24, 'properties/24/R2D4yA87PDVbgVnrLQEFSJGqSPJjqlw8sTVQ53CA.jpg', 0, '2026-05-28 00:25:02', '2026-05-28 00:25:02'),
(7, 25, 'properties/25/n4nTnL9Oz2kC0fxtVUY8s5cPzua5BvpLyyyEMQvN.jpg', 1, '2026-05-28 14:10:16', '2026-05-28 14:10:16'),
(8, 26, 'properties/26/zMg3nFa7ZnTxj3MEhTH9ONtOM2ke1duKRxkKUk1b.jpg', 1, '2026-05-28 14:34:46', '2026-05-28 14:34:46'),
(9, 26, 'properties/26/kgYgD0vla0sskQQvqzjzLqmUhc6PsnJTc4whq1gJ.jpg', 0, '2026-05-28 14:34:46', '2026-05-28 14:34:46'),
(11, 28, 'properties/28/Toy6enDvK0cKe7ALXcq7CDejZZs9N4hZAxVkjfhY.jpg', 1, '2026-05-28 15:02:08', '2026-05-28 15:02:08'),
(12, 29, 'properties/29/3fLcOAo0PcqfDWnRXeVnDbDmTXRDqegemvf3Wa1N.jpg', 1, '2026-05-28 20:47:37', '2026-05-28 20:47:37'),
(13, 30, 'properties/30/B4Yp7fvvjiC5wicDbORtCDpChxRvtiZzGri9jgCX.jpg', 1, '2026-05-29 20:41:20', '2026-05-29 20:41:20'),
(14, 31, 'properties/31/hUlfnhfw8BFkSimm7ayvbnPAlsRA5Gsk1VVT91Zu.jpg', 1, '2026-05-29 21:19:58', '2026-05-29 21:19:58'),
(15, 32, 'properties/32/CIaXxAgG2snxj5W98shrJyaJv00c1xbHwDICny3b.jpg', 1, '2026-06-01 17:57:07', '2026-06-01 17:57:07'),
(16, 33, 'properties/33/BukigTEW6KhVVB41a1hAWfuiuXxPmwC1MWLxRjTr.jpg', 1, '2026-06-02 07:31:25', '2026-06-02 07:31:25'),
(17, 34, 'properties/34/8uol3UUnZV5HPeTzbuofnpfaiqK62rzIvapjSXgt.jpg', 1, '2026-06-11 15:02:30', '2026-06-11 15:02:30'),
(20, 35, 'properties/35/kmhE5R0TzcTtPoZP5Ye7ZHE7NkvYggYM6XKKp7By.jpg', 1, '2026-06-12 12:16:36', '2026-06-12 12:16:36');

-- --------------------------------------------------------

--
-- بنية الجدول `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `universities`
--

CREATE TABLE `universities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `universities`
--

INSERT INTO `universities` (`id`, `name`, `city`, `created_at`, `updated_at`) VALUES
(1, 'جامعة دمشق', 'damascus', '2026-05-23 20:35:51', '2026-05-23 20:35:51'),
(2, 'الهمك', 'damascus', '2026-05-23 20:35:51', '2026-05-23 20:35:51'),
(3, 'جامعة حلب', 'aleppo', '2026-05-23 20:35:51', '2026-05-23 20:35:51'),
(4, 'جامعة تشرين', 'latakia', '2026-05-23 20:35:51', '2026-05-23 20:35:51'),
(5, 'جامعة البعث', 'homs', '2026-05-23 20:35:51', '2026-05-23 20:35:51'),
(6, 'جامعة الفرات', 'deir_ezzor', '2026-05-23 20:35:51', '2026-05-23 20:35:51'),
(7, 'جامعة قاصدي مرباح', 'daraa', '2026-05-23 20:35:51', '2026-05-23 20:35:51'),
(8, 'جامعة دمشق', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16'),
(9, 'الهمك', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16'),
(10, 'الكلية التطبيقية', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16'),
(11, 'هندسة المعلوماتية', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16'),
(12, 'جامعة الأندلس', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16'),
(13, 'المعهد العالي للعلوم التطبيقية', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16'),
(14, 'كلية الآداب', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16'),
(15, 'الكلية المدنية', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16'),
(16, 'الكلية الهندسة المعمارية', 'damascus', '2026-05-23 20:43:16', '2026-05-23 20:43:16');

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'tenant',
  `is_banned` tinyint(1) NOT NULL DEFAULT 0,
  `tenant_type` varchar(255) DEFAULT NULL,
  `university_id` bigint(20) UNSIGNED DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `role`, `is_banned`, `tenant_type`, `university_id`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@eskan.com', NULL, 'admin', 0, NULL, NULL, NULL, '$2y$12$A6Jyo7DaBIumU1ytkmv1bO1tteWmknH29PvXu0tTdkfJdcIgzwFDa', NULL, '2026-05-22 10:38:21', '2026-05-22 10:38:21'),
(2, 'dosh aa', 'dema@gmail.com', '0999999999999', 'owner', 0, 'normal', NULL, NULL, '$2y$12$9yHgs.ZCNMOASuHb0eEN6uv7g7/OxWhyTw9Mgy5PHIAy00GQmdCwq', NULL, '2026-05-22 10:59:59', '2026-05-22 11:08:49'),
(3, 'dado', 'dadoo@gmail.com', '2323332', 'owner', 0, 'normal', NULL, NULL, '$2y$12$ytGa/ngKXSytXjKVskT1JOmTZF4Fwd97OIA0Iq4GjsB11RQm4Lswe', NULL, '2026-05-22 23:21:00', '2026-05-28 20:47:37'),
(4, 'dede', 'dedede@gmail.com', '333333333333334', 'tenant', 0, 'student', NULL, NULL, '$2y$12$zU.zTBO67xAVyX2qgwxv8eTIadGzcdNnMVBWGvuIDcVby64z4/bBG', NULL, '2026-05-27 17:39:06', '2026-05-27 17:39:06'),
(5, 'dddooooo', 'ddoodddd@gmail.com', '3333333333333', 'owner', 0, 'student', NULL, NULL, '$2y$12$4iRtZvcJdWUamEaOA5/qeush8FW2ZU45OtYSqL/Bx3CDPLlAqcrxa', NULL, '2026-05-27 17:47:52', '2026-06-02 07:31:24'),
(6, 'sara waked', 'sese@gmail.com', '0992469617', 'tenant', 0, 'normal', NULL, NULL, '$2y$12$XrAbUusHoVRfuQyO692YyuifgTaqYnZt8/bXrJJoTPj39E8rO3B0O', NULL, '2026-05-27 20:15:17', '2026-05-27 20:15:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bookings_property_id_foreign` (`property_id`),
  ADD KEY `bookings_tenant_id_foreign` (`tenant_id`),
  ADD KEY `bookings_owner_id_foreign` (`owner_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `contact_requests`
--
ALTER TABLE `contact_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `contact_requests_property_id_foreign` (`property_id`),
  ADD KEY `contact_requests_tenant_id_foreign` (`tenant_id`),
  ADD KEY `contact_requests_owner_id_foreign` (`owner_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`),
  ADD KEY `properties_owner_id_foreign` (`owner_id`),
  ADD KEY `properties_university_id_foreign` (`university_id`);

--
-- Indexes for table `property_images`
--
ALTER TABLE `property_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_images_property_id_foreign` (`property_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `universities`
--
ALTER TABLE `universities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_university_id_foreign` (`university_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `contact_requests`
--
ALTER TABLE `contact_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `property_images`
--
ALTER TABLE `property_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `universities`
--
ALTER TABLE `universities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- قيود الجداول المُلقاة.
--

--
-- قيود الجداول `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_tenant_id_foreign` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `contact_requests`
--
ALTER TABLE `contact_requests`
  ADD CONSTRAINT `contact_requests_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contact_requests_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `contact_requests_tenant_id_foreign` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `properties`
--
ALTER TABLE `properties`
  ADD CONSTRAINT `properties_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `properties_university_id_foreign` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE SET NULL;

--
-- قيود الجداول `property_images`
--
ALTER TABLE `property_images`
  ADD CONSTRAINT `property_images_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE;

--
-- قيود الجداول `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_university_id_foreign` FOREIGN KEY (`university_id`) REFERENCES `universities` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
