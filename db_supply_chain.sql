-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2024 at 01:51 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_supply_chain`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `session_id`, `product_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 4, 3, '2024-05-14 22:45:44', '2024-05-14 23:49:17'),
(2, 1, NULL, 8, 1, '2024-05-14 22:46:23', '2024-05-14 22:46:23'),
(4, 1, NULL, 18, 2, '2024-05-15 02:03:46', '2024-05-15 02:03:50');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Restaurant', NULL, NULL),
(2, 'Shoes', NULL, NULL),
(3, 'Bag', NULL, NULL),
(4, 'Apparel', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `consumers`
--

CREATE TABLE `consumers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `consumers`
--

INSERT INTO `consumers` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'test@test.com', 'testpassword', '2024-04-16 22:00:26', '2024-04-16 22:00:26'),
(2, 'Alexandrea Barrozo', 'alex@gmail.com', 'hello123', '2024-04-16 22:16:36', '2024-04-16 22:16:36'),
(4, 'Alex Barrozo', 'alexb@gmail.com', 'hello123', '2024-04-16 22:23:15', '2024-04-16 22:23:15'),
(5, 'Michael Tate', 'nfitzgerald@example.com', 'yyoZh2Lf', '2024-04-17 20:04:20', '2024-04-17 20:04:20'),
(6, 'Michael Roth', 'youngjuan@example.org', 'PEDMBfUz', '2024-04-17 20:04:51', '2024-04-17 20:04:51'),
(7, 'Barbara Gray', 'sbass@example.org', 'GW5wtfQb', '2024-04-17 20:05:20', '2024-04-17 20:05:20'),
(8, 'Katherine Powell', 'martin77@example.org', 'wCJM7OCM', '2024-04-17 20:05:36', '2024-04-17 20:05:36'),
(9, 'Brandon Howard', 'ricardoturner@example.org', 'qNlQZn3C', '2024-04-17 20:05:59', '2024-04-17 20:05:59'),
(10, 'Tasha Browning', 'richard86@example.com', 'VgXkzroP', '2024-04-17 20:06:15', '2024-04-17 20:06:15'),
(11, 'Kristina Davis', 'calvin45@example.org', 'MmNbHIhY', '2024-04-17 20:06:30', '2024-04-17 20:06:30'),
(12, 'Kayla Edwards', 'waguilar@example.com', '3eB7Gcof', '2024-04-17 20:06:47', '2024-04-17 20:06:47'),
(13, 'Frederick Mathews', 'kelly37@example.net', 'rPZSzN8C', '2024-04-17 20:07:13', '2024-04-17 20:07:13'),
(14, 'Scott Walker', 'angela17@example.net', 'ynqkhzSc', '2024-04-17 20:07:29', '2024-04-17 20:07:29'),
(15, 'Tonya Chan', 'lwagner@example.org', 'C4uxV568', '2024-04-17 20:07:45', '2024-04-17 20:07:45'),
(16, 'Chris George', 'veronicadunn@example.org', 'sbV12cqs', '2024-04-17 20:07:58', '2024-04-17 20:07:58'),
(17, 'Carrie Stevens', 'warekimberly@example.net', 'oOQNMDzy', '2024-04-17 20:08:12', '2024-04-17 20:08:12'),
(18, 'Jennifer Smith', 'allison50@example.org', 'U4hbtaDM', '2024-04-17 20:08:25', '2024-04-17 20:08:25'),
(19, 'Jacob Harris', 'cooperthomas@example.com', 'oOAJvAgK', '2024-04-17 20:08:37', '2024-04-17 20:08:37'),
(20, 'Anthony Webb', 'caseygreg@example.net', 'AKJ8UQ8k', '2024-04-17 20:08:52', '2024-04-17 20:08:52');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
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
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `store_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `product_id`, `store_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 50, NULL, NULL),
(2, 2, 1, 10, NULL, NULL),
(3, 3, 2, 30, NULL, NULL),
(4, 4, 2, 20, NULL, NULL),
(5, 5, 2, 15, NULL, NULL),
(6, 6, 3, 60, NULL, NULL),
(7, 7, 3, 40, NULL, NULL),
(8, 8, 3, 80, NULL, NULL),
(9, 9, 4, 20, NULL, NULL),
(10, 10, 4, 30, NULL, NULL),
(11, 11, 4, 25, NULL, NULL),
(13, 13, 5, 15, NULL, NULL),
(14, 14, 5, 21, NULL, NULL),
(15, 15, 5, 18, NULL, NULL),
(16, 16, 5, 31, NULL, NULL),
(17, 17, 5, 13, NULL, NULL),
(18, 18, 5, 43, NULL, NULL),
(19, 19, 5, 37, NULL, NULL),
(20, 20, 5, 36, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_04_02_070846_create_locations_table', 2),
(6, '2024_04_04_040826_create_stores_table', 3),
(7, '2024_04_04_040921_create_products_table', 3),
(8, '2024_04_04_041007_create_categories_table', 3),
(9, '2024_04_04_041058_create_product_category_table', 3),
(10, '2024_04_04_041157_create_inventory_table', 3),
(11, '2024_04_15_014211_create_reviews_table', 4),
(12, '2024_04_15_022638_create_store_reviews_table', 5),
(13, '2024_04_17_052414_create_consumers_table', 6),
(14, '2024_04_29_070325_create_carts_table', 7),
(15, '2024_05_06_051921_create_sessions_table', 8),
(16, '2024_05_12_024639_create_sellers_table', 9),
(18, '2024_05_12_024752_add_seller_id_to_stores_table', 10),
(19, '2024_05_15_062741_create_carts_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\Consumer', 2, 'auth_token', 'e6d4c36d1cf236348820c0b30e543bab91b6b4611d846833ac16058a6bbf62d3', '[\"*\"]', NULL, NULL, '2024-04-16 22:16:36', '2024-04-16 22:16:36'),
(3, 'App\\Models\\Consumer', 4, 'auth_token', 'f24d07418e494bff448e2b29a30cf70e3378c5e2125bfd1211b8298a137c08cd', '[\"*\"]', NULL, NULL, '2024-04-16 22:23:16', '2024-04-16 22:23:16'),
(4, 'App\\Models\\Consumer', 5, 'auth_token', 'b8ac5a64cf7d5b14e1933a0e20092dfb0953058cb5ca9fbdc0e9ac89b7739d64', '[\"*\"]', NULL, NULL, '2024-04-17 20:04:20', '2024-04-17 20:04:20'),
(5, 'App\\Models\\Consumer', 6, 'auth_token', 'c95473fe74e71166437b5d7122fca9f50e2c1168c83daff4d1f0403232a5226e', '[\"*\"]', NULL, NULL, '2024-04-17 20:04:51', '2024-04-17 20:04:51'),
(6, 'App\\Models\\Consumer', 7, 'auth_token', '23ac00ce85274089269e476f689aa304e319ed68b597adee299c379eb31be8a5', '[\"*\"]', NULL, NULL, '2024-04-17 20:05:20', '2024-04-17 20:05:20'),
(7, 'App\\Models\\Consumer', 8, 'auth_token', '0e6103fc8ea9a3064e53b152b9d46f5db8d854325dfcf0fbb32a3aa9727383de', '[\"*\"]', NULL, NULL, '2024-04-17 20:05:36', '2024-04-17 20:05:36'),
(8, 'App\\Models\\Consumer', 9, 'auth_token', '0c08862797c42b63e4494e55f21951568ddd0d2a21ee3e18b256cd0a144e2789', '[\"*\"]', NULL, NULL, '2024-04-17 20:05:59', '2024-04-17 20:05:59'),
(9, 'App\\Models\\Consumer', 10, 'auth_token', 'c2a401715955a3f9bb8436db2ad7804dc96d67f4757c29c66e4ece52ce414ec7', '[\"*\"]', NULL, NULL, '2024-04-17 20:06:15', '2024-04-17 20:06:15'),
(10, 'App\\Models\\Consumer', 11, 'auth_token', '4ce31b6e9746629942ee1c1a27f99f920507f571f3a96285a760f04d1c461dc9', '[\"*\"]', NULL, NULL, '2024-04-17 20:06:30', '2024-04-17 20:06:30'),
(11, 'App\\Models\\Consumer', 12, 'auth_token', 'e2c6d9dc9ef74284932450cf62ca798315258942d4dab06733ad510167ea2862', '[\"*\"]', NULL, NULL, '2024-04-17 20:06:47', '2024-04-17 20:06:47'),
(12, 'App\\Models\\Consumer', 13, 'auth_token', 'e15318f73f52b03e1b9ad3aa6e1b3eeeb5fc47fee80241ef1ededf96211445bc', '[\"*\"]', NULL, NULL, '2024-04-17 20:07:13', '2024-04-17 20:07:13'),
(13, 'App\\Models\\Consumer', 14, 'auth_token', '0c739daecd05772a94ee84258935c12b4afbf916b9ef8b78eb547f59a85cd582', '[\"*\"]', NULL, NULL, '2024-04-17 20:07:29', '2024-04-17 20:07:29'),
(14, 'App\\Models\\Consumer', 15, 'auth_token', 'a5dd6476f626188c99b2e74d3e396f485ad2db139afbf9e91e72d06abcbcc307', '[\"*\"]', NULL, NULL, '2024-04-17 20:07:45', '2024-04-17 20:07:45'),
(15, 'App\\Models\\Consumer', 16, 'auth_token', '8f5b0cae76ff017e7cbb844f4edb1b38529271160244017bd236580d2977cda0', '[\"*\"]', NULL, NULL, '2024-04-17 20:07:58', '2024-04-17 20:07:58'),
(16, 'App\\Models\\Consumer', 17, 'auth_token', '8b0f4542a9656588677f76d36b0ca8635b18887a21f442980704584855bc7b38', '[\"*\"]', NULL, NULL, '2024-04-17 20:08:12', '2024-04-17 20:08:12'),
(17, 'App\\Models\\Consumer', 18, 'auth_token', '241406b91af1e3348d9f08d289837a1c923ae396c3e11e60e2713bcecdfb04da', '[\"*\"]', NULL, NULL, '2024-04-17 20:08:25', '2024-04-17 20:08:25'),
(18, 'App\\Models\\Consumer', 19, 'auth_token', 'eedba2a38108ebe5614817c26221f2bc58cd9810120110a3c41e3f185e19f977', '[\"*\"]', NULL, NULL, '2024-04-17 20:08:37', '2024-04-17 20:08:37'),
(19, 'App\\Models\\Consumer', 20, 'auth_token', 'ef17251499c1ec89f572324d6c81dbec06ecc922659e8f15870c25905170afaf', '[\"*\"]', NULL, NULL, '2024-04-17 20:08:52', '2024-04-17 20:08:52'),
(20, 'App\\Models\\Seller', 2, 'seller_auth_token', '4c5956e87e62ad054efb8c926f2d38e5c60e6d60bd59582941b8d404c82eb014', '[\"*\"]', NULL, NULL, '2024-05-11 23:56:52', '2024-05-11 23:56:52'),
(21, 'App\\Models\\Seller', 2, 'seller_auth_token', '04e45f209e825db9d87173bc5b7fba7883e24e5fe3fe55ea9c5a7bc41d151c95', '[\"*\"]', NULL, NULL, '2024-05-12 02:56:39', '2024-05-12 02:56:39'),
(22, 'App\\Models\\Consumer', 1, 'seller_auth_token', '35b0808ef8b4604189072faf1372fb0b22b7fefe7be924fed62b316581bb2dca', '[\"*\"]', NULL, NULL, '2024-05-13 20:25:17', '2024-05-13 20:25:17'),
(23, 'App\\Models\\Consumer', 1, 'seller_auth_token', '7a3a6320b5d12bda9ff5f4c1d0fabf35d27b6e9ebb1c6d1abe7697312f519dfc', '[\"*\"]', NULL, NULL, '2024-05-13 20:25:42', '2024-05-13 20:25:42'),
(24, 'App\\Models\\Consumer', 1, 'seller_auth_token', '7a82e8482a65fab861c2b9526192800dd152936814d9e1b18cc8e2ef5ea1f568', '[\"*\"]', NULL, NULL, '2024-05-13 20:36:21', '2024-05-13 20:36:21'),
(25, 'App\\Models\\Consumer', 1, 'seller_auth_token', 'fdc7c3ffd6d84f598e50aab84531228ab1e4428e53ead6dc205b2702d9020d05', '[\"*\"]', NULL, NULL, '2024-05-13 21:04:14', '2024-05-13 21:04:14'),
(26, 'App\\Models\\Consumer', 1, 'seller_auth_token', 'f69e3db68cc241af586d94eb9d5a0dd7336fc0c50bfe29afa7fbe7a007f2d861', '[\"*\"]', NULL, NULL, '2024-05-13 21:14:27', '2024-05-13 21:14:27'),
(27, 'App\\Models\\Consumer', 1, 'seller_auth_token', '2f6c653d9db772713dfc70db47cf1718b37c2c687a918636db963705eddad980', '[\"*\"]', NULL, NULL, '2024-05-13 21:16:19', '2024-05-13 21:16:19'),
(28, 'App\\Models\\Seller', 1, 'test_token', '0cea4aae1628c3bc77702047d6f3ccf16b7b3563c321a9c088ccf6139f72e5df', '[\"*\"]', NULL, NULL, '2024-05-13 22:16:08', '2024-05-13 22:16:08'),
(29, 'App\\Models\\Seller', 1, 'seller_auth_token', 'b964989c5e775714f09fcceaf6840119542021c5fd18a6f018e9bbc93d5bb442', '[\"*\"]', NULL, NULL, '2024-05-13 23:26:24', '2024-05-13 23:26:24'),
(30, 'App\\Models\\Consumer', 1, 'consumer_auth_token', 'e5f42474d5e2828491c77b111d3f82a3ecdea765929d059f66f23834234aade1', '[\"*\"]', NULL, NULL, '2024-05-13 23:43:39', '2024-05-13 23:43:39'),
(31, 'App\\Models\\Consumer', 1, 'consumer_auth_token', '0f219cfa5293d14dc83f6c127161c242281536b4327d4e335bc772500a91b8ec', '[\"*\"]', NULL, NULL, '2024-05-14 00:04:35', '2024-05-14 00:04:35'),
(32, 'App\\Models\\Consumer', 1, 'consumer_auth_token', '00ade25ef5751a47f169a0045a6b9354b22b89412f41bd809c6dd5eaedfbfe65', '[\"*\"]', NULL, NULL, '2024-05-14 00:16:46', '2024-05-14 00:16:46'),
(33, 'App\\Models\\Consumer', 1, 'consumer_auth_token', '5cadacde002d878db8744c937a707e1cb87bfc540290cfed1804c019668ee914', '[\"*\"]', NULL, NULL, '2024-05-14 20:02:52', '2024-05-14 20:02:52'),
(34, 'App\\Models\\Consumer', 1, 'consumer_auth_token', '4d7ab92c9d151542a0a97e0a38b1b2935f975077d3fdae4937c96e448968d189', '[\"*\"]', '2024-05-14 20:50:27', NULL, '2024-05-14 20:32:39', '2024-05-14 20:50:27'),
(35, 'App\\Models\\Consumer', 1, 'consumer_auth_token', '77d66741101e709cad7d65814adf5acabfffe8025c57ebd637f64a07958e8063', '[\"*\"]', NULL, NULL, '2024-05-14 20:36:41', '2024-05-14 20:36:41'),
(49, 'App\\Models\\Consumer', 1, 'auth_token', '0c426f6ecfde95252ad532ceab50379652867e1ed8d527445322d6b7738d2f13', '[\"*\"]', NULL, NULL, '2024-05-15 03:40:40', '2024-05-15 03:40:40');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `store_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image_url`, `store_id`, `created_at`, `updated_at`) VALUES
(1, 'Weekday Buffet', 'Eat all you can during the weekdays.', 1038.00, 'https://images.squarespace-cdn.com/content/v1/5682b6f957eb8d0dbae2c4b2/1633353580076-NOEZIDA7SV5L6AGK8VYW/NA+DEL+PHOTO.jpg', 1, NULL, NULL),
(2, 'Weekend Buffet', 'Eat all you can during the weekends.', 1138.00, 'https://images.squarespace-cdn.com/content/v1/5682b6f957eb8d0dbae2c4b2/1633353580076-NOEZIDA7SV5L6AGK8VYW/NA+DEL+PHOTO.jpg', 1, NULL, NULL),
(3, 'Sizzling Sisig', 'Served with rice and egg', 85.00, 'https://cdn.sanity.io/images/f3knbc2s/production/1e0058379c6c2c9b60fa9ac91638d80d7a5135fd-1024x605.jpg', 2, NULL, NULL),
(4, 'Sizzling Pork Chop', 'Served with rice and gravy', 85.00, 'https://i.pinimg.com/originals/0b/02/a7/0b02a7f772b119614a5ad3766a154f59.jpg', 2, NULL, NULL),
(5, 'Garlic Pepper Beef', 'Served with rice and egg', 115.00, 'https://static8.depositphotos.com/1175884/1024/i/450/depositphotos_10243631-stock-photo-roast-beef-with-black-pepper.jpg', 2, NULL, NULL),
(6, 'Spanish Latte', 'Enjoy a delightful fusion of bold espresso and rich condensed milk', 180.00, 'https://images.deliveryhero.io/image/fd-ph/Products/25300581.jpg?width=%s', 3, NULL, NULL),
(7, 'Matcha Float', 'Green tea float', 230.00, 'https://images.deliveryhero.io/image/fd-ph/Products/21639819.jpg?width=%s', 3, NULL, NULL),
(8, 'Dark Chocolate Chip', 'Dark chocolate chip ice blended', 200.00, 'https://images.deliveryhero.io/image/fd-ph/Products/23845984.jpg?width=%s', 3, NULL, NULL),
(9, 'C Point Unisex Denmark Boots Black', 'MADE IN MARIKINA\r\nGENUINE LEATHER\r\nSOLE STITCHED\r\nLIFETIME SERVICE WARRANTY', 1699.00, 'https://down-ph.img.susercontent.com/file/17ef966c29422071179b7797c619594f', 4, NULL, NULL),
(10, 'C Point Men\'s Top Sider Brown Nubuck', 'Made in Marikina\r\nGenuine Leather\r\nSole Stitched\r\nStore lifetime free service warranty', 1299.00, 'https://down-ph.img.susercontent.com/file/ph-11134207-7qukz-lf3nue1yq5ckdf', 4, NULL, NULL),
(11, 'C Point Women\'s Top Sider L. Ariella', 'Made in Marikina\r\nGenuine Leather\r\nSole Stitched\r\nStore lifetime free service warranty', 1299.00, 'https://down-ph.img.susercontent.com/file/ph-11134207-7qul2-lf3o3yggktqs73', 4, NULL, NULL),
(13, 'Hanyuu Lace Up Sneaker', 'Side-Striped Lace up Sneakers Material: PU upper and PVC outsole', 1299.00, 'https://www.cln.com.ph/cdn/shop/files/Hanyuu_White-Beige_5_1024x1024.jpg?v=1701654321', 5, NULL, NULL),
(14, 'Harper Flat Slides', 'Flat adjustable two-band slides with buckle detail\r\nMaterial: EVA and Phylon, Light Weight\r\nPackaging:  drawstring polybag', 799.00, 'https://www.cln.com.ph/cdn/shop/files/Harper3_White_5_1024x1024.jpg?v=1710562873', 5, NULL, NULL),
(15, 'Nyler Handbag', 'Handbag with zip-top closure,\r\nInterior: slip pocket and zipper pocket\r\nIncludes optional (and adjustable) crossbody strap.\r\nNylon\r\nLength - 9.0\" Width - 4.90\" Height - 7.50\" Handle Drop - 4.0\" Strap Drop - 21.0\"', 1999.00, 'https://www.cln.com.ph/cdn/shop/files/Nyler_Black_1_1024x1024.jpg?v=1708332857', 5, NULL, NULL),
(16, 'Estifania Shoulder Bag', 'Shoulder bag with zip-top closure, 2 magnetic snap slip pockets, interior slip pocket, interior zipper pocket, optional (and adjustable) crossbody strap.\r\nPU Leather\r\nMeasurements (inches) : Length - 9.50\" Width - 3.20\" Height - 8.40\" Handle Drop - 8.0\" Strap Drop - 20.0\"', 2499.00, 'https://www.cln.com.ph/cdn/shop/files/Estifania_Black_1_1024x1024.jpg?v=1708582353', 5, NULL, NULL),
(17, 'Jazelle Handbag', 'Handbag with zip-top closure\r\nInterior: 1 zipper pocket, 1 slip pocket\r\nExterior: 1 magnetic slip pocket, 1 small slip pocket,\r\nIncludes optional (and adjustable) crossbody strap.\r\nFabric, PU Leather\r\nLength - 10.0\" Width - 4.0\" Height - 9.0\" Handle Drop - 5.0\" Strap Drop - 20.50\"', 2299.00, 'https://www.cln.com.ph/cdn/shop/files/Jazelle_Black_4_1024x1024.jpg?v=1712127255', 5, NULL, NULL),
(18, 'Nicotiana Set', '2-piece Set V-neck dropped shoulder blouse and drawstring shorts with front pocket detail; Material - Polyblend\r\n\r\nMeasurement in cm (TOP)\r\nM -   A (Chest) 48, B (Neck to Bottom) 35, C (Height) - 56, D (Width) -51\r\n\r\nL -   A (Chest) 50, B (Neck to Bottom) 36, C (Height) - 57, D (Width) -53', 899.00, 'https://www.cln.com.ph/cdn/shop/files/Nicotiana_Blue_1_1024x1024.jpg?v=1688107077', 5, NULL, NULL),
(19, 'Hydrangea Blouse', 'Knitted round-neck blouse \r\nMeasurement in cm:\r\n\r\nM -   A (Chest) 50, B (Neck to Bottom) 47,       C (Height) - 55, D (Width) -50\r\n\r\nL -   A (Chest) 53, B (Neck to Bottom) 51,       C (Height) - 59, D (Width) -53', 499.00, 'https://www.cln.com.ph/cdn/shop/files/0223T3Hydrangea_Khaki_4_1024x1024.jpg?v=1688027215', 5, NULL, NULL),
(20, 'Foxglove Blouse', 'Knitted round neck blouse with front buttons and detailed collar\r\n\r\nMeasurement in cm:\r\nM -   A (Chest) 58, B (Neck to Bottom) 46,       C (Height) - 54, D (Width) -58\r\n\r\nL -   A (Chest) 60, B (Neck to Bottom) 47,       C (Height) - 55, D (Width) -60', 499.00, 'https://www.cln.com.ph/cdn/shop/files/0223T3Foxglove_Blue_2_1024x1024.jpg?v=1688091994', 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_category`
--

CREATE TABLE `product_category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_category`
--

INSERT INTO `product_category` (`id`, `product_id`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL),
(2, 2, 1, NULL, NULL),
(3, 3, 1, NULL, NULL),
(4, 4, 1, NULL, NULL),
(5, 5, 1, NULL, NULL),
(6, 6, 1, NULL, NULL),
(7, 7, 1, NULL, NULL),
(8, 8, 1, NULL, NULL),
(9, 9, 2, NULL, NULL),
(10, 10, 2, NULL, NULL),
(11, 11, 2, NULL, NULL),
(13, 13, 2, NULL, NULL),
(14, 14, 2, NULL, NULL),
(15, 15, 3, NULL, NULL),
(16, 16, 3, NULL, NULL),
(17, 17, 3, NULL, NULL),
(18, 18, 4, NULL, NULL),
(19, 19, 4, NULL, NULL),
(20, 20, 4, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rating` double(8,2) NOT NULL,
  `review_text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `product_id`, `user_id`, `rating`, `review_text`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 4.50, 'I was with a couple of friends last night and we were saying that if you just came to Vikings to get drunk, 888++ isn\'t actually too expensive, and it\'s as though you have free food!  What great deal!', NULL, NULL),
(2, 2, 2, 4.20, 'I have dine with Vikings for few times already! I brought my parents twice to celebrate their birthday in this beautiful restaurant reminds me of dining in a luxurious hotel buffet with a much affordable price, speaking of being practical but with class!! I brought my balikbayan relative once who, as expected had really a good time and was impressed with the buffet spread!!', NULL, NULL),
(3, 3, 3, 4.98, 'solid ung sisig. legit masarap.', NULL, NULL),
(4, 4, 4, 4.40, 'Sarap Lods babalik balikan mo talaga', NULL, NULL),
(5, 5, 5, 4.60, 'Eto po talaga yung isa sa masasabi kong what you see is what you get. Kung gaano kasarap sa photos, mas masarap sa personal', NULL, NULL),
(6, 6, 6, 4.20, 'Yung spanish latte nila, cinnamon powder ata ung nilalagay nila. Kasi un naman ung kakaibang taste na nalalasahan ko. Hindi chocolate-y. Pero masarap sya.', NULL, NULL),
(7, 7, 7, 4.80, 'Creamy, vibrant matcha meets velvety vanilla ice cream in a blissful fusion of flavors, making this matcha float an irresistible treat that\'s almost too good to sip.', NULL, NULL),
(8, 8, 8, 3.80, 'Indulge in the rich decadence of dark chocolate chips mingled with creamy goodness, although a touch more sweetness would elevate the experience to perfection.', NULL, NULL),
(9, 9, 9, 4.30, 'The boots are a versatile addition to any wardrobe, offering a sleek and timeless design suitable for both casual outings and formal occasions. With their comfortable fit and durable construction, they effortlessly combine style with practicality. While they excel in most aspects, a minor adjustment to enhance arch support would elevate them to true footwear perfection.', NULL, NULL),
(10, 10, 10, 4.70, 'Slipping into these men\'s brown Top-Siders feels like stepping into a relaxed coastal lifestyle, whether you\'re strolling along the boardwalk or enjoying a laid-back barbecue with friends. Their timeless appeal and reliable construction make them a go-to choice for any casual outing.', NULL, NULL),
(11, 11, 11, 4.30, 'The women\'s Top-Siders offer a perfect blend of style and comfort, ideal for leisurely walks by the marina or afternoon picnics in the park. While their classic design and sturdy build ensure reliability, a slightly softer insole could enhance the overall comfort level.', NULL, NULL),
(13, 13, 13, 4.80, 'These lace-up sneakers redefine casual chic with their trendy design and unbeatable comfort, effortlessly elevating any outfit from gym attire to street style.', NULL, NULL),
(14, 14, 14, 4.30, 'Imagine sliding your feet into these unisex flat slippers after a long day – it\'s like a warm hug for your tired soles, whether you\'re padding around the house or stepping out for a quick coffee run.', NULL, NULL),
(15, 15, 15, 4.60, 'This black handbag is the epitome of sophistication and versatility, effortlessly complementing any outfit with its timeless design and ample storage space.', NULL, NULL),
(16, 16, 16, 4.70, 'Imagine this beige shoulder bag as your trusted companion, effortlessly completing your look with its timeless charm and versatile appeal. From brunch dates to evening soirées, it seamlessly transitions with you, holding all your essentials in style. ', NULL, NULL),
(17, 17, 17, 4.90, 'Carrying this handbag feels like holding a piece of refined art, its sleek lines and shimmering accents catching the eye of passersby. It\'s not just an accessory; it\'s a conversation starter, adding a touch of glamour to your every ensemble.', NULL, NULL),
(18, 18, 18, 4.20, 'This set exudes playful sophistication, perfect for a sunny day out or a casual evening gathering. While the ensemble boasts trendy style and comfortable wear, a touch more attention to fabric quality could elevate it to a higher rating.', NULL, NULL),
(19, 19, 19, 4.80, 'CLN\'s Hydrangea Blouse effortlessly blends style and comfort. The soft fabric drapes beautifully, providing a flattering fit. Its versatility shines, easily transitioning from professional to casual settings. The subtle hydrangea design adds a touch of elegance. Well-crafted and true to size, this blouse is now a staple in my wardrobe.', NULL, NULL),
(20, 20, 20, 4.80, 'Good style, quality and value', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE `sellers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sellers`
--

INSERT INTO `sellers` (`id`, `name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Julie Davis', 'millerdonna@example.org', 'e4kb3thy', NULL, NULL),
(2, 'Sandra Santos', 'robertpatel@example.net', 'LC3GYaYe', NULL, NULL),
(3, 'Jennifer Liu', 'donna50@example.net', 'JvtnIobw', NULL, NULL),
(4, 'Molly Anderson', 'scottaguirre@example.org', '3PPcxcsD', NULL, NULL),
(5, 'Jermaine Andrews', 'jgarcia@example.org', 'TR86fbhl', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `seller_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`id`, `name`, `address`, `latitude`, `longitude`, `created_at`, `updated_at`, `seller_id`) VALUES
(1, 'Vikings Luxury Buffet', 'Marikina-Infanta Hwy 2nd Floor, SM City Marikina, Marikina, Luzon 1820 Philippines', 14.62665553, 121.08372628, NULL, NULL, 1),
(2, 'Mang K\'s Sizzling House', '75 Lakandula, Parang, Marikina city, Metro Manila', 14.66105885, 121.11250936, NULL, NULL, 2),
(3, 'Drip Kofi', '26 T. Bugallon St, Marikina, 1807 Metro Manila', 14.65008564, 121.11089276, NULL, NULL, 3),
(4, 'C Point Shoes', 'C Point Marikina, 605 Shoe Ave, Conception Uno, Marikina City, 1800 Metro Manila', 14.65153336, 121.10334866, NULL, NULL, 4),
(5, 'CLN', 'CLN Alimall, Upper Ground Floor, Alimall, Araneta Center, Brgy, Cubao, Quezon City, 0810 Metro Manila', 14.62021241, 121.05655276, NULL, NULL, 5);

-- --------------------------------------------------------

--
-- Table structure for table `store_reviews`
--

CREATE TABLE `store_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `store_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `rating` double(8,2) NOT NULL,
  `review_text` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `store_reviews`
--

INSERT INTO `store_reviews` (`id`, `store_id`, `user_id`, `rating`, `review_text`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 3.80, 'It\'s a bit expensive, and you almost always need a reservation. To be accommodated, customers should get to the restaurant about an hour before it opens so that they can get on the waitlist.', NULL, NULL),
(2, 2, 2, 4.90, 'sulit at masarap ang pagkain', NULL, NULL),
(3, 3, 3, 3.20, 'You\'ve got to try this new place if you\'re near the area. What I like here is the staff are accommodating and friendly. The downside is the coffee is not worth its price. You can taste coffee in it but it lacks uniqueness in flavor vs Its competitors.', NULL, NULL),
(4, 4, 4, 4.40, 'good service.. aasikasuhin ka agad nila kahit maraming tao!\r\nhindi ka mag aanatay ng matagal!', NULL, NULL),
(5, 5, 5, 4.50, 'Great customer service, very commendable! I made an exchange transaction with my order because of the size. I had such a wonderful and smooth experience because they were so responsive and helpful. Thank you so much, CLN!', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carts_user_id_foreign` (`user_id`),
  ADD KEY `carts_product_id_foreign` (`product_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_name_unique` (`name`);

--
-- Indexes for table `consumers`
--
ALTER TABLE `consumers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `consumers_email_unique` (`email`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_product_id_foreign` (`product_id`),
  ADD KEY `inventory_store_id_foreign` (`store_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
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
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_store_id_foreign` (`store_id`);

--
-- Indexes for table `product_category`
--
ALTER TABLE `product_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_category_product_id_foreign` (`product_id`),
  ADD KEY `product_category_category_id_foreign` (`category_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_product_id_foreign` (`product_id`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sellers_email_unique` (`email`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stores_seller_id_foreign` (`seller_id`);

--
-- Indexes for table `store_reviews`
--
ALTER TABLE `store_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_reviews_store_id_foreign` (`store_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `consumers`
--
ALTER TABLE `consumers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `product_category`
--
ALTER TABLE `product_category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `stores`
--
ALTER TABLE `stores`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `store_reviews`
--
ALTER TABLE `store_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `consumers` (`id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `inventory_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

--
-- Constraints for table `product_category`
--
ALTER TABLE `product_category`
  ADD CONSTRAINT `product_category_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `product_category_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stores`
--
ALTER TABLE `stores`
  ADD CONSTRAINT `stores_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `sellers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `store_reviews`
--
ALTER TABLE `store_reviews`
  ADD CONSTRAINT `store_reviews_store_id_foreign` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
