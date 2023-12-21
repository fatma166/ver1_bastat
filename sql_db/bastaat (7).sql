-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2023 at 02:05 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bastaat`
--

-- --------------------------------------------------------

--
-- Table structure for table `account_transactions`
--

CREATE TABLE `account_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `from_type` varchar(255) NOT NULL,
  `from_id` bigint(20) NOT NULL,
  `current_balance` decimal(24,2) NOT NULL,
  `amount` decimal(24,2) NOT NULL,
  `method` varchar(255) NOT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `add_ons`
--

CREATE TABLE `add_ons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `price` decimal(24,2) NOT NULL DEFAULT 0.00,
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(100) DEFAULT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `zone_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `f_name`, `l_name`, `phone`, `email`, `image`, `password`, `remember_token`, `created_at`, `updated_at`, `role_id`, `zone_id`) VALUES
(1, 'admin', 'admin', '010234676470', 'admin@admin.com', NULL, '$2y$10$FH7pwqLVcvu.mZnETmAHGebZxi1iebYmEv4fi8FDIbUAgfqaydbR2', NULL, NULL, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_roles`
--

CREATE TABLE `admin_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `modules` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admin_roles`
--

INSERT INTO `admin_roles` (`id`, `name`, `modules`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', '[\"account\",\"account\",\"addon\",\"attribute\",\"banner\",\"campaign\",\"category\",\"coupon\",\"custom_role\",\"customerList\",\"deliveryman\",\"provide_dm_earning\",\"employee\",\"food\",\"notification\",\"order\",\"restaurant\",\"report\",\"settings\",\"withdraw_list\",\"pos\",\"zone\"]', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `admin_wallets`
--

CREATE TABLE `admin_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `total_commission_earning` decimal(24,2) NOT NULL DEFAULT 0.00,
  `digital_received` decimal(24,2) NOT NULL DEFAULT 0.00,
  `manual_received` decimal(24,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_charge` decimal(8,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'restaurant_wise',
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `data` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `compilation_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `title`, `type`, `image`, `status`, `data`, `created_at`, `updated_at`, `zone_id`, `compilation_id`, `place_id`) VALUES
(1, 'مطاعم الطيبات', 'restaurant_wise', 'images/banner/1698222373.png', 1, 'l\'hul ;edvi', NULL, '2023-10-25 05:48:10', 1, 1, 3),
(2, 'اعلان 2', 'restaurant_wise', 'images/banner/1698226814.png', 1, NULL, '2023-10-25 06:40:14', '2023-11-11 12:52:16', 1, 1, 2),
(3, 'اعلان كاتشب السبع', 'restaurant_wise', 'images/banner/1699724943.png', 1, NULL, '2023-11-11 17:49:03', '2023-11-11 17:49:03', 1, 1, 9);

-- --------------------------------------------------------

--
-- Table structure for table `business_settings`
--

CREATE TABLE `business_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'def.png',
  `parent_id` int(11) NOT NULL,
  `position` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `priority` int(11) NOT NULL DEFAULT 0,
  `compilation_id` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `image`, `parent_id`, `position`, `status`, `created_at`, `updated_at`, `priority`, `compilation_id`) VALUES
(1, 'لحوم', 'def.png', 0, 0, 1, NULL, NULL, 0, 1),
(2, 'اسماك', 'def.png', 0, 0, 1, NULL, NULL, 0, 1),
(3, 'استيك', 'def.png', 1, 0, 1, NULL, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `compilations`
--

CREATE TABLE `compilations` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `image` mediumtext NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `position` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(2) NOT NULL DEFAULT 1,
  `priority` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime NOT NULL,
  `description` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `compilations`
--

INSERT INTO `compilations` (`id`, `title`, `image`, `parent_id`, `position`, `status`, `priority`, `created_at`, `updated_at`, `description`) VALUES
(1, 'مطاعم', 'images/compilation/1698234401.jpg', 0, 0, 1, 0, '2023-10-25 11:46:41', '2023-10-25 11:46:41', ''),
(2, 'كافيهات', 'images/compilation/1698234312.jpg', 0, 0, 1, 0, '2023-10-25 11:45:12', '2023-10-25 11:45:12', ''),
(3, 'ملابس', 'images/compilation/1698234288.png', 0, 0, 1, 0, '2023-10-25 11:44:48', '2023-10-25 11:44:48', ''),
(4, 'هايبر', 'images/compilation/1698234255.png', 0, 0, 1, 0, '2023-10-25 11:44:15', '2023-10-25 11:44:15', NULL),
(5, 'بسطات', 'images/compilation/1699724095.jpg', 0, 0, 1, 0, '2023-11-11 17:34:55', '2023-11-11 17:34:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `conversations`
--

CREATE TABLE `conversations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sender_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `sender_type` varchar(255) NOT NULL,
  `receiver_id` bigint(20) UNSIGNED NOT NULL,
  `receiver_type` varchar(255) NOT NULL,
  `last_message_id` bigint(20) UNSIGNED DEFAULT NULL,
  `last_message_time` timestamp NULL DEFAULT NULL,
  `unread_message_count` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `code` varchar(15) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `expire_date` date DEFAULT NULL,
  `min_purchase` decimal(24,2) NOT NULL DEFAULT 0.00,
  `max_discount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(15) NOT NULL DEFAULT 'percentage',
  `coupon_type` varchar(255) NOT NULL DEFAULT 'default',
  `limit` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `compilation_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  `total_uses` bigint(20) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `title`, `code`, `start_date`, `expire_date`, `min_purchase`, `max_discount`, `discount`, `discount_type`, `coupon_type`, `limit`, `status`, `restaurant_id`, `compilation_id`, `created_at`, `updated_at`, `data`, `total_uses`) VALUES
(1, 'كوبون1', '454465', '2023-11-13', '2023-11-15', 56.00, 0.00, 30.00, 'percentage', 'default', NULL, 1, 6, 2, '2023-11-13 05:47:41', '2023-11-13 05:47:41', NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `country` varchar(255) DEFAULT NULL,
  `currency_code` varchar(255) DEFAULT NULL,
  `currency_symbol` varchar(255) DEFAULT NULL,
  `exchange_rate` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customer_addresses`
--

CREATE TABLE `customer_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `contact_person_number` varchar(20) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `contact_person_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `floor` varchar(255) DEFAULT NULL,
  `road` varchar(255) DEFAULT NULL,
  `house` varchar(255) DEFAULT NULL,
  `zone_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_addresses`
--

INSERT INTO `customer_addresses` (`id`, `contact_person_number`, `address`, `latitude`, `longitude`, `user_id`, `contact_person_name`, `created_at`, `updated_at`, `floor`, `road`, `house`, `zone_id`) VALUES
(1, 'ahmed', 'tiyleklj', NULL, NULL, 2, 'contact_person_name', NULL, NULL, 'floor', NULL, 'house', 0),
(2, 'ahmed', 'tiyleklj', NULL, NULL, 2, 'contact_person_name', NULL, NULL, 'floor', NULL, 'house', 0),
(5, '8775645656', 'بركه السبع', NULL, NULL, 2, NULL, '2023-10-21 08:49:27', '2023-10-21 08:49:27', '2', 'طريق الحماديه', 'منزل رقم4', 1),
(6, 'ahmed', 'tiyleklj', NULL, NULL, 2, 'contact_person_name', NULL, NULL, 'floor', NULL, 'house', NULL),
(7, '8775645656', 'بركه السبع', NULL, NULL, 2, NULL, '2023-10-21 08:47:55', '2023-10-21 08:47:55', '2', 'طريق الحماديه', 'منزل رقم4', 1),
(8, 'ahmed', 'tiyleklj', NULL, NULL, 6, 'contact_person_name', NULL, NULL, 'floor', NULL, 'house', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `delivery_histories`
--

CREATE TABLE `delivery_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `delivery_man_id` bigint(20) UNSIGNED DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_man_wallets`
--

CREATE TABLE `delivery_man_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_man_id` bigint(20) UNSIGNED NOT NULL,
  `collected_cash` decimal(24,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_earning` decimal(24,2) NOT NULL DEFAULT 0.00,
  `total_withdrawn` decimal(24,2) NOT NULL DEFAULT 0.00,
  `pending_withdraw` decimal(24,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `delivery_men`
--

CREATE TABLE `delivery_men` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(100) DEFAULT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `identity_number` varchar(30) DEFAULT NULL,
  `identity_type` varchar(50) DEFAULT NULL,
  `identity_image` varchar(255) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `auth_token` varchar(255) DEFAULT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `zone_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `earning` tinyint(1) NOT NULL DEFAULT 1,
  `current_orders` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) NOT NULL DEFAULT 'zone_wise',
  `restaurant_id` bigint(20) DEFAULT NULL,
  `order_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `assigned_order_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `min_purchase` decimal(24,2) NOT NULL DEFAULT 0.00,
  `max_discount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(15) NOT NULL DEFAULT 'percentage',
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `d_m_reviews`
--

CREATE TABLE `d_m_reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_man_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `comment` mediumtext DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_verifications`
--

CREATE TABLE `email_verifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `employee_roles`
--

CREATE TABLE `employee_roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `modules` text DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `restaurant_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `summary` mediumtext DEFAULT NULL,
  `image` varchar(30) DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `category_ids` varchar(255) DEFAULT NULL,
  `variations` text DEFAULT NULL,
  `add_ons` varchar(255) DEFAULT NULL,
  `attributes` varchar(255) DEFAULT NULL,
  `choice_options` text DEFAULT NULL,
  `price` decimal(24,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(24,2) NOT NULL DEFAULT 0.00,
  `tax_type` varchar(20) NOT NULL DEFAULT 'percent',
  `discount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(20) NOT NULL DEFAULT 'percent',
  `available_time_starts` time DEFAULT NULL,
  `available_time_ends` time DEFAULT NULL,
  `veg` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `order_count` int(11) NOT NULL DEFAULT 0,
  `avg_rating` double(16,14) NOT NULL DEFAULT 0.00000000000000,
  `rating_count` int(11) NOT NULL DEFAULT 0,
  `rating` varchar(255) DEFAULT NULL,
  `product_quantity` int(11) NOT NULL,
  `in_stock` tinyint(1) NOT NULL DEFAULT 0,
  `favourite` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`id`, `name`, `description`, `summary`, `image`, `category_id`, `category_ids`, `variations`, `add_ons`, `attributes`, `choice_options`, `price`, `tax`, `tax_type`, `discount`, `discount_type`, `available_time_starts`, `available_time_ends`, `veg`, `status`, `restaurant_id`, `created_at`, `updated_at`, `order_count`, `avg_rating`, `rating_count`, `rating`, `product_quantity`, `in_stock`, `favourite`) VALUES
(1, 'sheesh Tawooq', 'demo product', NULL, '', 1, '[{\"id\":\"1\",\"position\":0}]', '[{\"type\":\"L\",\"price\":95},{\"type\":\"M\",\"price\":75}]', '[]', '[\"1\"]', '[{\"name\":\"choice_1\",\"title\":\"\\u0627\\u0644\\u062d\\u062c\\u0645\",\"options\":[\"L\",\"M\"]}]', 95.00, 0.00, 'percent', 0.00, 'percent', '10:00:00', '04:05:00', 1, 1, 3, '2022-12-02 17:37:30', '2023-06-07 11:52:04', 0, 0.00000000000000, 0, NULL, 0, 0, 0),
(2, 'Chiken Alagreek', 'demo product', NULL, '', 2, '[{\"id\":\"2\",\"position\":0}]', '[{\"type\":\"L\",\"price\":100},{\"type\":\"M\",\"price\":80}]', '[]', '[\"1\"]', '[{\"name\":\"choice_1\",\"title\":\"\\u0627\\u0644\\u062d\\u062c\\u0645\",\"options\":[\"L\",\"M\"]}]', 100.00, 0.00, 'percent', 0.00, 'percent', '10:00:00', '04:05:00', 0, 1, 3, '2022-12-02 17:37:30', '2023-06-07 11:55:36', 0, 0.00000000000000, 0, NULL, 0, 0, 0),
(3, 'Chekin Grill', '<p><br></p>', 'vcc', 'images/product/1701230601.jpg', 1, '[{\"id\":\"1\",\"position\":0}]', '[{\"type\":\"L\",\"price\":90},{\"type\":\"M\",\"price\":70}]', '[]', '[\"1\"]', '[{\"name\":\"choice_1\",\"title\":\"\\u0627\\u0644\\u062d\\u062c\\u0645\",\"options\":[\"L\",\"M\"]}]', 90.00, 0.00, 'percent', 0.00, 'percent', '10:00:00', '04:05:00', 0, 1, 3, '2022-12-02 17:37:30', '2023-11-29 17:44:44', 0, 0.00000000000000, 0, NULL, 0, 0, 0),
(6, 'retert', '<p>rtertre</p>', 'egerter', 'images/product/1701287673.jpg', 2, '[{\"id\":\"2\",\"position\":0}]', NULL, NULL, NULL, NULL, 45.00, 0.00, 'percent', 5.00, 'percent', NULL, NULL, 0, 1, 2, NULL, NULL, 0, 0.00000000000000, 0, NULL, 2, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `food_slider_images`
--

CREATE TABLE `food_slider_images` (
  `id` int(11) NOT NULL,
  `image_path` mediumtext NOT NULL,
  `food_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `food_slider_images`
--

INSERT INTO `food_slider_images` (`id`, `image_path`, `food_id`) VALUES
(6, 'images/product/1701285095.jpg', 3);

-- --------------------------------------------------------

--
-- Table structure for table `loyalty_point_transactions`
--

CREATE TABLE `loyalty_point_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_id` char(36) NOT NULL,
  `credit` decimal(24,3) NOT NULL DEFAULT 0.000,
  `debit` decimal(24,3) NOT NULL DEFAULT 0.000,
  `balance` decimal(24,3) NOT NULL DEFAULT 0.000,
  `reference` varchar(191) DEFAULT NULL,
  `transaction_type` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mail_configs`
--

CREATE TABLE `mail_configs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `driver` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `encryption` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `conversation_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sender_id` bigint(20) UNSIGNED DEFAULT NULL,
  `message` text DEFAULT NULL,
  `file` varchar(100) DEFAULT NULL,
  `is_seen` tinyint(1) NOT NULL DEFAULT 0,
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
(1, '2023_09_30_202912_create_account_transactions_table', 0),
(2, '2023_09_30_202912_create_add_ons_table', 0),
(3, '2023_09_30_202912_create_admin_roles_table', 0),
(4, '2023_09_30_202912_create_admin_wallets_table', 0),
(5, '2023_09_30_202912_create_admins_table', 0),
(6, '2023_09_30_202912_create_attributes_table', 0),
(7, '2023_09_30_202912_create_banners_table', 0),
(8, '2023_09_30_202912_create_business_settings_table', 0),
(9, '2023_09_30_202912_create_categories_table', 0),
(10, '2023_09_30_202912_create_conversations_table', 0),
(11, '2023_09_30_202912_create_coupons_table', 0),
(12, '2023_09_30_202912_create_currencies_table', 0),
(13, '2023_09_30_202912_create_customer_addresses_table', 0),
(14, '2023_09_30_202912_create_d_m_reviews_table', 0),
(15, '2023_09_30_202912_create_delivery_histories_table', 0),
(16, '2023_09_30_202912_create_delivery_man_wallets_table', 0),
(17, '2023_09_30_202912_create_delivery_men_table', 0),
(18, '2023_09_30_202912_create_discounts_table', 0),
(19, '2023_09_30_202912_create_email_verifications_table', 0),
(20, '2023_09_30_202912_create_employee_roles_table', 0),
(21, '2023_09_30_202912_create_failed_jobs_table', 0),
(22, '2023_09_30_202912_create_food_table', 0),
(23, '2023_09_30_202912_create_loyalty_point_transactions_table', 0),
(24, '2023_09_30_202912_create_mail_configs_table', 0),
(25, '2023_09_30_202912_create_messages_table', 0),
(26, '2023_09_30_202912_create_newsletters_table', 0),
(27, '2023_09_30_202912_create_notifications_table', 0),
(28, '2023_09_30_202912_create_oauth_access_tokens_table', 0),
(29, '2023_09_30_202912_create_oauth_auth_codes_table', 0),
(30, '2023_09_30_202912_create_oauth_clients_table', 0),
(31, '2023_09_30_202912_create_oauth_personal_access_clients_table', 0),
(32, '2023_09_30_202912_create_oauth_refresh_tokens_table', 0),
(33, '2023_09_30_202912_create_order_delivery_histories_table', 0),
(34, '2023_09_30_202912_create_order_details_table', 0),
(35, '2023_09_30_202912_create_order_transactions_table', 0),
(36, '2023_09_30_202912_create_orders_table', 0),
(37, '2023_09_30_202912_create_password_resets_table', 0),
(38, '2023_09_30_202912_create_phone_verifications_table', 0),
(39, '2023_09_30_202912_create_provide_d_m_earnings_table', 0),
(40, '2023_09_30_202912_create_restaurant_schedule_table', 0),
(41, '2023_09_30_202912_create_restaurant_wallets_table', 0),
(42, '2023_09_30_202912_create_restaurant_zone_table', 0),
(43, '2023_09_30_202912_create_restaurants_table', 0),
(44, '2023_09_30_202912_create_reviews_table', 0),
(45, '2023_09_30_202912_create_social_media_table', 0),
(46, '2023_09_30_202912_create_time_logs_table', 0),
(47, '2023_09_30_202912_create_track_deliverymen_table', 0),
(48, '2023_09_30_202912_create_translations_table', 0),
(49, '2023_09_30_202912_create_user_infos_table', 0),
(50, '2023_09_30_202912_create_user_notifications_table', 0),
(51, '2023_09_30_202912_create_users_table', 0),
(52, '2023_09_30_202912_create_vendor_employees_table', 0),
(53, '2023_09_30_202912_create_vendors_table', 0),
(54, '2023_09_30_202912_create_wallet_transactions_table', 0),
(55, '2023_09_30_202912_create_wishlists_table', 0),
(56, '2023_09_30_202912_create_withdraw_requests_table', 0),
(57, '2023_09_30_202912_create_zones_table', 0),
(58, '2023_09_30_212035_create_account_transactions_table', 0),
(59, '2023_09_30_212035_create_add_ons_table', 0),
(60, '2023_09_30_212035_create_admin_roles_table', 0),
(61, '2023_09_30_212035_create_admin_wallets_table', 0),
(62, '2023_09_30_212035_create_admins_table', 0),
(63, '2023_09_30_212035_create_attributes_table', 0),
(64, '2023_09_30_212035_create_banners_table', 0),
(65, '2023_09_30_212035_create_business_settings_table', 0),
(66, '2023_09_30_212035_create_categories_table', 0),
(67, '2023_09_30_212035_create_conversations_table', 0),
(68, '2023_09_30_212035_create_coupons_table', 0),
(69, '2023_09_30_212035_create_currencies_table', 0),
(70, '2023_09_30_212035_create_customer_addresses_table', 0),
(71, '2023_09_30_212035_create_d_m_reviews_table', 0),
(72, '2023_09_30_212035_create_delivery_histories_table', 0),
(73, '2023_09_30_212035_create_delivery_man_wallets_table', 0),
(74, '2023_09_30_212035_create_delivery_men_table', 0),
(75, '2023_09_30_212035_create_discounts_table', 0),
(76, '2023_09_30_212035_create_email_verifications_table', 0),
(77, '2023_09_30_212035_create_employee_roles_table', 0),
(78, '2023_09_30_212035_create_failed_jobs_table', 0),
(79, '2023_09_30_212035_create_food_table', 0),
(80, '2023_09_30_212035_create_loyalty_point_transactions_table', 0),
(81, '2023_09_30_212035_create_mail_configs_table', 0),
(82, '2023_09_30_212035_create_messages_table', 0),
(83, '2023_09_30_212035_create_newsletters_table', 0),
(84, '2023_09_30_212035_create_notifications_table', 0),
(85, '2023_09_30_212035_create_oauth_access_tokens_table', 0),
(86, '2023_09_30_212035_create_oauth_auth_codes_table', 0),
(87, '2023_09_30_212035_create_oauth_clients_table', 0),
(88, '2023_09_30_212035_create_oauth_personal_access_clients_table', 0),
(89, '2023_09_30_212035_create_oauth_refresh_tokens_table', 0),
(90, '2023_09_30_212035_create_order_delivery_histories_table', 0),
(91, '2023_09_30_212035_create_order_details_table', 0),
(92, '2023_09_30_212035_create_order_transactions_table', 0),
(93, '2023_09_30_212035_create_orders_table', 0),
(94, '2023_09_30_212035_create_password_resets_table', 0),
(95, '2023_09_30_212035_create_phone_verifications_table', 0),
(96, '2023_09_30_212035_create_provide_d_m_earnings_table', 0),
(97, '2023_09_30_212035_create_restaurant_schedule_table', 0),
(98, '2023_09_30_212035_create_restaurant_wallets_table', 0),
(99, '2023_09_30_212035_create_restaurant_zone_table', 0),
(100, '2023_09_30_212035_create_restaurants_table', 0),
(101, '2023_09_30_212035_create_reviews_table', 0),
(102, '2023_09_30_212035_create_social_media_table', 0),
(103, '2023_09_30_212035_create_time_logs_table', 0),
(104, '2023_09_30_212035_create_track_deliverymen_table', 0),
(105, '2023_09_30_212035_create_translations_table', 0),
(106, '2023_09_30_212035_create_user_infos_table', 0),
(107, '2023_09_30_212035_create_user_notifications_table', 0),
(108, '2023_09_30_212035_create_users_table', 0),
(109, '2023_09_30_212035_create_vendor_employees_table', 0),
(110, '2023_09_30_212035_create_vendors_table', 0),
(111, '2023_09_30_212035_create_wallet_transactions_table', 0),
(112, '2023_09_30_212035_create_wishlists_table', 0),
(113, '2023_09_30_212035_create_withdraw_requests_table', 0),
(114, '2023_09_30_212035_create_zones_table', 0);

-- --------------------------------------------------------

--
-- Table structure for table `newsletters`
--

CREATE TABLE `newsletters` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(191) NOT NULL COMMENT 'Subscribers email',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(50) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `tergat` varchar(255) DEFAULT NULL,
  `zone_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('0708c46fc7ef0aaf4d804c635d389e52eaeb24ad911df7c7bf34f61e725e9592fcb9db67daad6def', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 19:17:53', '2023-11-22 19:17:53', '2024-11-22 19:17:53'),
('0bfbc4bb9e534a02df1a2e08c0b9353363948cbeeab6651fcf39132dab0876ad1443883bf5d9df40', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:29:39', '2023-11-13 19:29:39', '2024-11-13 19:29:39'),
('0fb8e2a7336e8ea67e9c4c8ab29f4bbb02e66064790dabe7d1b23c16a1ed2dc015ba12c7be9cd80c', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:49:36', '2023-11-11 19:49:36', '2024-11-11 19:49:36'),
('1332869510d30f8eb982f57bbfdbf7b67885663032fc5be7b0ff4dcf1097c83f4f80c88aeea22dad', 2, 1, 'AuthToken', '[]', 0, '2023-11-20 18:57:25', '2023-11-20 18:57:25', '2024-11-20 18:57:25'),
('17102b536fd675ab75363c2f27c1f25217c116026f963e9c830fd4823e795f2869ea4735a501c013', 6, 1, 'AuthToken', '[]', 0, '2023-11-15 18:39:06', '2023-11-15 18:39:06', '2024-11-15 18:39:06'),
('1c94537b578dcb9c7bf2368855c74383518b316e532a207a5446e2f1c27443da3e330ffbfb7b5214', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 17:49:48', '2023-11-21 17:49:48', '2024-11-21 17:49:48'),
('1cc8a58b1ae335cab267f229e38151be45bf7615801c72bd4b9e93ecf4b18aa8021d49232d1d7a96', 6, 1, 'AuthToken', '[]', 0, '2023-11-12 19:49:51', '2023-11-12 19:49:51', '2024-11-12 19:49:51'),
('227324daf82bbb2a06656e1e6d50bf7cb73fa34e7081a98336ddc34e9317b0577ff2820ce8a9b616', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 18:30:20', '2023-11-22 18:30:20', '2024-11-22 18:30:20'),
('238acdf0913eab2016fa951b64bd2f495939f93a433ab7336d399ad9f802ce6410f919e417cbee94', 6, 1, 'AuthToken', '[]', 0, '2023-11-16 17:15:03', '2023-11-16 17:15:03', '2024-11-16 17:15:03'),
('23d736203e06a65c55abec9d82f415a716bb8fb3a41540b7c1d218d8c3a2786491c83a86b1523a36', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 17:01:32', '2023-11-21 17:01:32', '2024-11-21 17:01:32'),
('257e7db53ec1ceef1909674201fc3c8c917859985cef1d2b891c9e3c9fa5865bfbf61a38d55de2aa', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:47:42', '2023-11-19 19:47:42', '2024-11-19 19:47:42'),
('290089b740776503924e6361b2235ddfa2c20c8c49603b4277a5ad4fced5a29ed17a85793ce85a00', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:18:16', '2023-11-13 19:18:16', '2024-11-13 19:18:16'),
('29e49fb6cbfb2f5e7e784926297f88bf3dab39612f90ab83811a511e88e6f429b7252b8b3da37dfc', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 20:00:30', '2023-11-13 20:00:30', '2024-11-13 20:00:30'),
('2b4fae7c2fa7af81ed6517f756ad25374574292bee9469d571583f929d78df91e67e2217e538c0c8', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:55:02', '2023-11-19 19:55:02', '2024-11-19 19:55:02'),
('2f241c65788225ab1daa63783f854c95b898d497a8e5e264521b6a6c912285e52878ceaef2500854', 6, 1, 'AuthToken', '[]', 0, '2023-11-16 08:51:34', '2023-11-16 08:51:34', '2024-11-16 08:51:34'),
('30ece99fca5741eb9ac2bf39f1098ce38f6d5dda8ddcb5a9f91297583a47427a2727be81d981a185', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 16:53:23', '2023-11-21 16:53:23', '2024-11-21 16:53:23'),
('35f9872ce67faa42edc9f56859e8613aab9b6d6cf078968c950eb55c73f4704543054d4a93ee992a', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:41:58', '2023-11-11 19:41:58', '2024-11-11 19:41:58'),
('38a7ca4c508c3532f46f2695e70859ab44b684cf959cf401c6c958fc113406a0c774219bc6a85d8b', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 16:54:05', '2023-11-21 16:54:05', '2024-11-21 16:54:05'),
('38cfd3adb83ab5d11a15004d28fd4763090f89f4c7c06fa40720e9dc8b24cfe3f2d4d4703cc34060', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:42:57', '2023-11-11 19:42:57', '2024-11-11 19:42:57'),
('41cb21c1af4154f800c5c4fb3b6d8b9fed84d17bca8d83bdb746aca4493a6f39d8e25d3bfb548d48', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:12:12', '2023-11-13 19:12:12', '2024-11-13 19:12:12'),
('42eb4a5da1b2354259d0c1156879e7d488d4889b519257b65ae92e5c7ce1a8d2547cb30af26de6c3', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 21:07:04', '2023-11-19 21:07:04', '2024-11-19 21:07:04'),
('45b1f444d9652d180fc864a68619915d463791ea6b79a1fd808fa827797768eed74da493e0ac05d3', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 18:00:56', '2023-11-19 18:00:56', '2024-11-19 18:00:56'),
('492bae04c9c9c1c78222bad14b1cfc984357b14e11ba4f6efd91f465d3414a9175e9abee2357ba7f', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:16:46', '2023-11-13 19:16:46', '2024-11-13 19:16:46'),
('49efc35b6d76a8e0990d82809fba27ca0f205e10a8261c87f92cd853ec3f760111a64ffd6fa551c6', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:37:17', '2023-11-11 19:37:17', '2024-11-11 19:37:17'),
('4a884f9e26693fa15b62e39565751e0b6f2196eb519d306c2f9ac718585945e606232a8fa781f344', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 16:52:14', '2023-11-21 16:52:14', '2024-11-21 16:52:14'),
('4d9faae5689fced47cd381f2748cfe3b12a80a90ea5fde0dfc08743d1e57cec36db21a4f3b5e3192', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:09:43', '2023-11-19 19:09:43', '2024-11-19 19:09:43'),
('5184285dde8384a9620ef76113e21db317d28965b679d5b84ee39bd6d38690d35ab3c69b4b6cbca5', 2, 1, 'AuthToken', '[]', 0, '2023-11-17 12:30:35', '2023-11-17 12:30:35', '2024-11-17 12:30:35'),
('58507b43e358618d33a6e4370860569951b3b25a574afdf985365b94322957308b33bca6ca66214d', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 14:36:26', '2023-11-22 14:36:26', '2024-11-22 14:36:26'),
('620c6284b8046c8ad56a5bbda42dedfb86459a6dc6cecfcd4552bf1b16b21be63614548759f87272', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:45:51', '2023-11-13 19:45:51', '2024-11-13 19:45:51'),
('6ac56c1ac914356072a3bff16c26a310a350a0a65bba178d5d934497df865e2b84402b6008646167', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:38:23', '2023-11-19 19:38:23', '2024-11-19 19:38:23'),
('6c3cee939411e906950b00ba3692218c2767d74c43148dbafebc29b35d2dc040061132aa3dcc0b22', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:38:10', '2023-11-13 19:38:10', '2024-11-13 19:38:10'),
('6c4ef1e2081302e4d206f28b036b86c2c7f7a812858eba0e0d3428ded83d435235ae8d9d8cfbe347', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 13:44:43', '2023-11-21 13:44:43', '2024-11-21 13:44:43'),
('6d4958ca02dc3a000aa780db5788d862f15e80269bd836f004bc4724460669a4e508ed9f44e7a0f8', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:20:37', '2023-11-19 19:20:37', '2024-11-19 19:20:37'),
('6daffd9e9a35a5b5335740da0af820616a85b9f0c2cf2de7e4bf19057ba0a02467ad1e3037667c3a', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:10:32', '2023-11-19 19:10:32', '2024-11-19 19:10:32'),
('6e9b61561f5fe5bbaec7533318551207c2d704b795efc54b387ec276f163163aa62419572aaa72ad', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 19:29:04', '2023-11-22 19:29:04', '2024-11-22 19:29:04'),
('6f47cb0e3bb64e6599c144bb98ce6ea8389b9e2dc3148403e7208812d9f30a64243ff74213a3062a', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:07:02', '2023-11-19 19:07:02', '2024-11-19 19:07:02'),
('796c702bfaefafd2047c26e920d65676aff3e5d57b91279f4a851b1c7f8f0714d85e2ab4d2a84966', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 21:08:24', '2023-11-19 21:08:24', '2024-11-19 21:08:24'),
('7b08b22d66a7075d77c92df4fd8e012f44f220016ead46f314304eb440e0557dbd847c6c5513a123', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:43:59', '2023-11-19 19:43:59', '2024-11-19 19:43:59'),
('7b67be5823484dd2dfe91654dc765ffcd9395cfe856d9f0b5b2c9c8d065ce2de95973ca32c7e1434', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 09:28:51', '2023-11-21 09:28:51', '2024-11-21 09:28:51'),
('7e6b509341f23bc1a9f4e72e5a31d8627d8035eac223793fc1680f728b0169bbfad6c7c7d9de1ee2', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:35:15', '2023-11-11 19:35:15', '2024-11-11 19:35:15'),
('8304748306da8affaba7a020ad78f65046973c267715d3bc36d12e5ea10c0265efd5103b86fb863c', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 18:00:09', '2023-11-19 18:00:09', '2024-11-19 18:00:09'),
('8821774522057e3ff1629c65255f9e0de647f3ebb1c9734a6902a8a4ec10bdc6b23b0d506d9544e8', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:51:28', '2023-11-13 19:51:28', '2024-11-13 19:51:28'),
('883f9fdee8fcf4e3916c8f8b31d0e870350d4e630f67fd85ad9784d1367a988551a737209e5f7f43', 2, 1, 'AuthToken', '[]', 0, '2023-11-18 20:05:22', '2023-11-18 20:05:22', '2024-11-18 20:05:22'),
('8b7b1008799f70233e600558c96ce275bc57670d26634a7d33dfc6646b49fa612f2abb40c9c1d78d', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 18:45:43', '2023-11-19 18:45:43', '2024-11-19 18:45:43'),
('8ba3b9a842fd7693e80bec2e33b2f0d86e18bcecab04cbd82eba443331c60af4749f59fe15971f1c', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 18:49:03', '2023-11-19 18:49:03', '2024-11-19 18:49:03'),
('8d19ed403c813fa3147f2a140c26c2bc414e40bb8d1de41f12abd0e5c353350bed4ce8ed7219edc2', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:33:16', '2023-11-13 19:33:16', '2024-11-13 19:33:16'),
('8e52a5530eeb10c0641376eb293c8132bd986a03f8aacec1b545afed35bf0cfc9ab59b428418dfc5', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 18:42:18', '2023-11-19 18:42:18', '2024-11-19 18:42:18'),
('92df98097cba4182ca9a07fd35405f04bb9283f857c08b04aeda106667585b9c8b981b4767f4c87e', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 18:51:00', '2023-11-19 18:51:00', '2024-11-19 18:51:00'),
('943f6ea0ff1592b010a8b36ecdf035ebc21a308f75fa4a4b7c1b9b7e1fe69d80b11164f4712e7464', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 14:00:16', '2023-11-22 14:00:16', '2024-11-22 14:00:16'),
('94b625aa37dfe49bcf960ac7cbce46bd6d85c44870f5495aab74befaff26f25f51519cfd73cad421', 2, 1, 'AuthToken', '[]', 0, '2023-10-28 20:28:14', '2023-10-28 20:28:14', '2024-10-28 22:28:14'),
('97245844a9f69a9b42c2589e8ebd1fb2d1a7693f0568f3e0732dd385d636a9481a7ac0ed6633f8f3', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:46:09', '2023-11-11 19:46:09', '2024-11-11 19:46:09'),
('9b3d71e274f68bad11a4c93cb80fc6fd9b414acfe63c2cf8ccc36da5ea50f13be4050aebf32bd169', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:08:01', '2023-11-19 19:08:01', '2024-11-19 19:08:01'),
('9f7ce7caedf5c03b8d48321213960178b40b9356599c473d90cd2d31960914edf21ad60852d5c6d1', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:54:27', '2023-11-19 19:54:27', '2024-11-19 19:54:27'),
('a1d66aea394993153b09968a340b5df6153b00c53120fd4f6ebe36474fd3311ee8596df804d2e4c5', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:23:36', '2023-11-19 19:23:36', '2024-11-19 19:23:36'),
('a1d77e7c7dddef8e92368e46bf4cefbfea1977c2c2a118cd1e71bfbf6774b4fe1ee0be929355852f', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 14:43:59', '2023-11-22 14:43:59', '2024-11-22 14:43:59'),
('a2de1f45c8a3cfd30b12a5d9acb4c34965fba53e3aeafe8da5ee9e500c5a70aab60a46f0c74e8bb5', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 14:01:52', '2023-11-22 14:01:52', '2024-11-22 14:01:52'),
('acc0aa9ae27299ea3d68a86f3794f62e383395a39929c97d3006c1198d55715c680eb70e9ec6160c', 6, 1, 'AuthToken', '[]', 0, '2023-11-12 19:53:03', '2023-11-12 19:53:03', '2024-11-12 19:53:03'),
('aee616a589e731f84d7a5a70bdc77a0c88ef8e0b5abb624674a10f90936dd2cab9c2b8353d235529', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 17:17:15', '2023-11-21 17:17:15', '2024-11-21 17:17:15'),
('b3e88addd807febe8377199335b5241643bfd663478ba0d824cf4fc218997fbe341f39d70a38699f', 6, 1, 'AuthToken', '[]', 0, '2023-11-14 17:32:34', '2023-11-14 17:32:34', '2024-11-14 17:32:34'),
('b7702cbb252e76079a3f607f89e17db7b33613c803fa14187d9beb201b96e8277e9431a912e5b61f', 6, 1, 'AuthToken', '[]', 0, '2023-11-17 09:14:46', '2023-11-17 09:14:46', '2024-11-17 09:14:46'),
('b8440a2ab5a72248a47d7feb2c04638b2e539e3bc5abdd73312136b6490700dee0035d7104a8fbad', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 12:04:38', '2023-11-22 12:04:38', '2024-11-22 12:04:38'),
('b912d669cd210031634a1242f0aba9a545adc540a704469c2fdac9b25fbc93863c2bb3f63da8011a', 2, 1, 'AuthToken', '[]', 0, '2023-11-20 19:10:41', '2023-11-20 19:10:41', '2024-11-20 19:10:41'),
('ba726cd2c996ade99635d315ced7cafd3455b1b5b6472a22b560cd5b72dc4408e67d628aa2bddc51', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:42:38', '2023-11-11 19:42:38', '2024-11-11 19:42:38'),
('baa1e09c639cfc1092130c685942bcb4220c3487dfd29760762f81ecd357e626b46b8979909f1155', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 17:23:38', '2023-11-21 17:23:38', '2024-11-21 17:23:38'),
('bb68c69022aa68bd677982fc9163d0ebb919c2db32e7dca12e1a80b77891baca936b896e6b505e43', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 18:21:25', '2023-11-19 18:21:25', '2024-11-19 18:21:25'),
('bdf1f9e29176a12fe77555a63667e3f1f89c8a02f0b306c2da5d71dfffe2cf14e1b610bb43e2501b', 2, 1, 'AuthToken', '[]', 0, '2023-11-21 20:30:21', '2023-11-21 20:30:21', '2024-11-21 20:30:21'),
('c2960a452355327007b678d332db78df83e11c9c6d1f518cbe33389855ff89437e42f39f8a5c21d7', 2, 1, 'AuthToken', '[]', 0, '2023-11-18 09:14:21', '2023-11-18 09:14:21', '2024-11-18 09:14:21'),
('c32e52b4d6b882be59836c7c7bc4eaa0a4154ab45c78640e98bcb064d8d9c75f0be4bc64d723fdcf', 2, 1, 'Laravel Password Grant Client', '[]', 0, '2023-10-15 08:22:32', '2023-10-15 08:22:32', '2024-10-15 11:22:32'),
('c417012d4875188b0f8196752d373fe8d5b60e0c2df1db9db2f10c562b4d9f2d5c7fc5a9b4dcc9c6', 6, 1, 'AuthToken', '[]', 0, '2023-11-12 19:53:46', '2023-11-12 19:53:46', '2024-11-12 19:53:46'),
('c7f6246ed65f1461fbd62caedc0869838fb4f8fba5b9e8233103a077eabf81e67f8248ff12ab4bed', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:43:31', '2023-11-13 19:43:31', '2024-11-13 19:43:31'),
('cb9951ecbe8af3392caaedd930e4d571f399e8a1bce63f789b470d1fc8c892905f311fff34360b91', 6, 1, 'AuthToken', '[]', 0, '2023-11-12 19:49:49', '2023-11-12 19:49:49', '2024-11-12 19:49:49'),
('d069c460f0c7bd04370b03649e380015429a6b66a8799deafd81db72a6e6eec4a7e30697c38c93bf', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:50:52', '2023-11-19 19:50:52', '2024-11-19 19:50:52'),
('d771d7e7aa07f475aefaea09bf5d0e622e67c1f8b40e4ad681f295ae4ed63883a4de7cd1a9f1d8ac', 2, 1, 'Laravel Password Grant Client', '[]', 0, '2023-10-15 08:33:03', '2023-10-15 08:33:03', '2024-10-15 11:33:03'),
('dadcc5bb6ab821b1c84ec4b35a10e7c054147b6e0424d0de8e79da4cfbaca0e726f9379eae1fd476', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:43:27', '2023-11-11 19:43:27', '2024-11-11 19:43:27'),
('ddb3a57c6d3269577fc54b644bf19f520a6e030ba667dd2d0cb16eb7195b47d4dc796df70ac30012', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 13:53:27', '2023-11-22 13:53:27', '2024-11-22 13:53:27'),
('dfd318a898abe9dd4b96c12e3b0ce55769a6772354e3e06f3ff1d769bf7842e9d1095c1ead56898d', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 09:55:36', '2023-11-22 09:55:36', '2024-11-22 09:55:36'),
('e17d386e7dd3277f7b348bdaf99d74fc3ce767384f02ba3bdc20bbcefcab811dae88c7160ef16952', 6, 1, 'AuthToken', '[]', 0, '2023-11-17 09:33:08', '2023-11-17 09:33:08', '2024-11-17 09:33:08'),
('e314fc287fd6c1044cbfe70bfce76261705ddc179849309a1fce9d01e80984ab7fb5be56a9d137a6', 2, 1, 'AuthToken', '[]', 0, '2023-11-18 09:17:28', '2023-11-18 09:17:28', '2024-11-18 09:17:28'),
('e4381347a1e61e20e3986fec55602f31b4691c135679b6c320733ae0a93071e9b5ccb79daf263fbf', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:56:05', '2023-11-19 19:56:05', '2024-11-19 19:56:05'),
('e4ec2352947b8a2f0b08b27ec3541cfc00a2c49de22b8272c5e2d43a93b0a940830dc6fc5db93356', 2, 1, 'AuthToken', '[]', 0, '2023-11-20 18:14:48', '2023-11-20 18:14:48', '2024-11-20 18:14:48'),
('e54cff046e5d704ba6149a0a66546f0db6ef3f3ebb656690d5c040bf235f7de004aed7e03070dceb', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 15:16:29', '2023-11-22 15:16:29', '2024-11-22 15:16:29'),
('e57943b3fab3b3c6dd2cbb50f424d74895e22bcd9176832145bda0bc768155e5d6af1cabb73bcbbf', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:53:40', '2023-11-19 19:53:40', '2024-11-19 19:53:40'),
('e7e5efae44c10a2a9a5e61b53ae67d8b521710446d888ad1e2b1fe4132afbca3e1cf531e375b6fb5', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:39:27', '2023-11-19 19:39:27', '2024-11-19 19:39:27'),
('eae3d9c61de2ab116d976fb6550bb0673f796e5aee3f37d1cadcaaff2d722aa0e206024d6f88ddba', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:40:38', '2023-11-19 19:40:38', '2024-11-19 19:40:38'),
('ee02ab454a124c97b9345279a3e7cde847f9957d594a291ff6f7757602721e2befed7cde01201a11', 2, 1, 'AuthToken', '[]', 0, '2023-11-22 14:19:00', '2023-11-22 14:19:00', '2024-11-22 14:19:00'),
('ee06d12f2c5a17098b045dda71f816a83d6c82d667e51b2124a2f97573bf9a0893167639aa37e929', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:13:57', '2023-11-13 19:13:57', '2024-11-13 19:13:57'),
('efce58c3cc3c3b79b08cc576df8616d3a02f43556c2c955679ad46fdd87d733626aa0408f49a615e', 6, 1, 'AuthToken', '[]', 0, '2023-11-11 19:21:46', '2023-11-11 19:21:46', '2024-11-11 19:21:46'),
('f3c91f55d570d56ff0795d2315b8dcfb582a8ec44ba9d504368a62455fc8859d2a5ce51dc6750c1a', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:36:23', '2023-11-13 19:36:23', '2024-11-13 19:36:23'),
('f63b26388c9b57c68a2e4d893fc08e42336c0a83804ac93de3f8d7eb382b57136a9571d8fb1c2785', 9, 1, 'AuthToken', '[]', 0, '2023-11-22 18:30:36', '2023-11-22 18:30:36', '2024-11-22 18:30:36'),
('f6c01ffc2725a42ac9f6fbd00f09b694c38f6d3eb4f42016ca3ef819e9e8ebc23ea0dc46b9585427', 2, 1, 'AuthToken', '[]', 0, '2023-11-19 19:42:44', '2023-11-19 19:42:44', '2024-11-19 19:42:44'),
('f908bb1d60a0c8c93b2d26d992f831a40e3d0af56f9bfd52420bc586ea49e0021bdffaec35755353', 6, 1, 'AuthToken', '[]', 0, '2023-11-17 09:17:17', '2023-11-17 09:17:17', '2024-11-17 09:17:17'),
('fb799b50db20f48f6d30f6c31172a4f24380b6985653c4cc57584eaa070574277863ba51e0a228ce', 6, 1, 'AuthToken', '[]', 0, '2023-11-13 19:31:39', '2023-11-13 19:31:39', '2024-11-13 19:31:39'),
('fdd86835e3dd538302f3a7ed0d548eea04d4fa08c0e404da5d0889a390e2c18c56610b51d72a97b5', 2, 1, 'AuthToken', '[]', 0, '2023-11-20 18:15:55', '2023-11-20 18:15:55', '2024-11-20 18:15:55');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'Krk4K9RU6pvHFLmZs46HXRUWw6KT8HGj9gaaeor3', NULL, 'http://localhost', 1, 0, 0, '2023-10-04 16:35:25', '2023-10-04 16:35:25'),
(2, NULL, 'Laravel Password Grant Client', 'pmTX12FYxK9q445kVO70te0BUQDxYZCpOjEyEoC2', 'users', 'http://localhost', 0, 1, 0, '2023-10-04 16:35:25', '2023-10-04 16:35:25');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-10-04 16:35:25', '2023-10-04 16:35:25');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_amount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `coupon_discount_amount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `restaurant_discount_amount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `original_delivery_charge` decimal(24,2) NOT NULL DEFAULT 0.00,
  `coupon_discount_title` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) NOT NULL DEFAULT 'unpaid',
  `order_status` varchar(255) NOT NULL DEFAULT 'pending',
  `total_tax_amount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `payment_method` varchar(30) DEFAULT NULL,
  `transaction_reference` varchar(30) DEFAULT NULL,
  `delivery_address_id` bigint(20) DEFAULT NULL,
  `delivery_man_id` bigint(20) UNSIGNED DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `order_note` text DEFAULT NULL,
  `order_type` varchar(255) NOT NULL DEFAULT 'delivery',
  `checked` tinyint(1) NOT NULL DEFAULT 0,
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_charge` decimal(24,2) NOT NULL DEFAULT 0.00,
  `schedule_at` timestamp NULL DEFAULT NULL,
  `callback` varchar(255) DEFAULT NULL,
  `otp` varchar(255) DEFAULT NULL,
  `pending` timestamp NULL DEFAULT NULL,
  `accepted` timestamp NULL DEFAULT NULL,
  `confirmed` timestamp NULL DEFAULT NULL,
  `processing` timestamp NULL DEFAULT NULL,
  `handover` timestamp NULL DEFAULT NULL,
  `picked_up` timestamp NULL DEFAULT NULL,
  `delivered` timestamp NULL DEFAULT NULL,
  `canceled` timestamp NULL DEFAULT NULL,
  `refund_requested` timestamp NULL DEFAULT NULL,
  `refunded` timestamp NULL DEFAULT NULL,
  `delivery_address` text DEFAULT NULL,
  `scheduled` tinyint(1) NOT NULL DEFAULT 0,
  `failed` timestamp NULL DEFAULT NULL,
  `adjusment` decimal(24,2) NOT NULL DEFAULT 0.00,
  `edited` tinyint(1) NOT NULL DEFAULT 0,
  `zone_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dm_tips` double(24,2) NOT NULL DEFAULT 0.00,
  `processing_time` varchar(10) DEFAULT NULL,
  `free_delivery_by` varchar(255) DEFAULT NULL,
  `print_status` tinyint(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_amount`, `coupon_discount_amount`, `restaurant_discount_amount`, `original_delivery_charge`, `coupon_discount_title`, `payment_status`, `order_status`, `total_tax_amount`, `payment_method`, `transaction_reference`, `delivery_address_id`, `delivery_man_id`, `coupon_code`, `order_note`, `order_type`, `checked`, `restaurant_id`, `created_at`, `updated_at`, `delivery_charge`, `schedule_at`, `callback`, `otp`, `pending`, `accepted`, `confirmed`, `processing`, `handover`, `picked_up`, `delivered`, `canceled`, `refund_requested`, `refunded`, `delivery_address`, `scheduled`, `failed`, `adjusment`, `edited`, `zone_id`, `dm_tips`, `processing_time`, `free_delivery_by`, `print_status`) VALUES
(100001, 2, 56.70, 0.00, 6.00, 0.00, NULL, 'paid', 'delivered', 2.70, 'card', NULL, NULL, NULL, NULL, NULL, 'take_away', 1, 3, '2022-12-05 17:02:08', '2022-12-05 17:02:08', 0.00, '2022-12-05 17:02:08', NULL, '1241', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 56.70, 0, NULL, 0.00, NULL, NULL, 0),
(100002, 2, 56.70, 0.00, 6.00, 0.00, NULL, 'paid', 'delivered', 2.70, 'card', NULL, NULL, NULL, NULL, NULL, 'take_away', 1, 3, '2022-12-05 17:02:17', '2022-12-05 17:02:17', 0.00, '2022-12-05 17:02:17', NULL, '6647', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 56.70, 0, NULL, 0.00, NULL, NULL, 0),
(100003, 2, 56.70, 0.00, 6.00, 0.00, NULL, 'paid', 'delivered', 2.70, 'card', NULL, NULL, NULL, NULL, NULL, 'take_away', 1, 3, '2022-12-05 17:53:44', '2022-12-05 17:53:44', 0.00, '2022-12-05 17:53:44', NULL, '1328', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 56.70, 0, NULL, 0.00, NULL, NULL, 0),
(100004, 2, 56.70, 0.00, 6.00, 0.00, NULL, 'paid', 'delivered', 2.70, 'card', NULL, NULL, NULL, NULL, NULL, 'take_away', 1, 3, '2022-12-05 18:23:38', '2022-12-05 18:23:38', 0.00, '2022-12-05 18:23:38', NULL, '3420', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 56.70, 0, NULL, 0.00, NULL, NULL, 0),
(100005, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:06:54', '2023-10-17 05:06:54', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100006, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:09:05', '2023-10-17 05:09:05', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100007, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:12:06', '2023-10-17 05:12:06', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100008, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'canceled', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:15:51', '2023-10-18 09:06:10', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-18 09:06:10', NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100009, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'picked_up', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:20:02', '2023-11-29 23:02:21', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, '2023-11-29 22:57:22', NULL, '2023-11-29 23:02:21', NULL, '2023-10-21 06:17:27', NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100010, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'canceled', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:22:41', '2023-10-21 06:21:28', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-21 06:21:28', NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100011, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:26:45', '2023-10-17 05:26:45', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100012, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:29:00', '2023-10-17 05:29:00', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100013, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:30:55', '2023-10-17 05:30:55', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100014, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:32:52', '2023-10-17 05:32:52', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100015, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 05:43:30', '2023-10-17 05:43:30', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100018, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 06:07:59', '2023-10-17 06:07:59', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100019, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 06:10:39', '2023-10-17 06:10:39', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0),
(100020, 2, 360.00, 0.00, 0.00, 0.00, NULL, 'unpaid', 'pending', 0.00, NULL, NULL, 7, NULL, NULL, NULL, 'delivery', 0, 3, '2023-10-17 06:15:52', '2023-10-17 06:15:52', 0.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 0.00, 0, NULL, 0.00, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_delivery_histories`
--

CREATE TABLE `order_delivery_histories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `delivery_man_id` bigint(20) UNSIGNED DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `start_location` varchar(255) DEFAULT NULL,
  `end_location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `food_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `price` decimal(24,2) NOT NULL DEFAULT 0.00,
  `food_details` text DEFAULT NULL,
  `variation` varchar(255) DEFAULT NULL,
  `add_ons` text DEFAULT NULL,
  `discount_on_food` decimal(24,2) DEFAULT NULL,
  `discount_type` varchar(20) NOT NULL DEFAULT 'amount',
  `quantity` int(11) NOT NULL DEFAULT 1,
  `tax_amount` decimal(24,2) NOT NULL DEFAULT 1.00,
  `variant` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `total_add_on_price` decimal(24,2) NOT NULL DEFAULT 0.00,
  `item_campaign_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `food_id`, `order_id`, `price`, `food_details`, `variation`, `add_ons`, `discount_on_food`, `discount_type`, `quantity`, `tax_amount`, `variant`, `created_at`, `updated_at`, `total_add_on_price`, `item_campaign_id`) VALUES
(1, 22, 100013, 60.00, '{\"id\":22,\"name\":\"\\u0634\\u062a\\u064a\\u0643\\u0646 \\u0647\\u0648\\u062a\",\"description\":\"demo product \",\"image\":\"\",\"category_id\":9,\"category_ids\":[{\"id\":\"1\",\"position\":0},{\"id\":\"9\",\"position\":1}],\"variations\":[],\"add_ons\":[],\"attributes\":[],\"choice_options\":[],\"price\":60,\"tax\":5,\"tax_type\":\"percent\",\"discount\":10,\"discount_type\":\"percent\",\"available_time_starts\":\"10:00:00\",\"available_time_ends\":\"23:00:00\",\"veg\":1,\"status\":1,\"restaurant_id\":12,\"created_at\":\"2022-12-02T12:37:30.000000Z\",\"updated_at\":\"2022-12-02T12:37:30.000000Z\",\"order_count\":0,\"avg_rating\":0,\"rating_count\":0,\"restaurant_name\":\"Taibat City Shebin\",\"restaurant_discount\":0,\"restaurant_opening_time\":\"10:00\",\"restaurant_closing_time\":\"23:00\",\"schedule_order\":false}', '[]', '[]', 6.00, 'discount_on_product', 1, 3.00, '\"\"', '2022-12-05 18:58:36', '2022-12-05 18:58:36', 0.00, NULL),
(2, 24, 100013, 60.00, '{\"id\":24,\"name\":\"\\u0634\\u064a\\u0643\\u0646 \\u0645\\u0648\\u0632\\u0627\\u0631\\u064a\\u0644\\u0627\",\"description\":\"demo product \",\"image\":\"\",\"category_id\":9,\"category_ids\":[{\"id\":\"1\",\"position\":0},{\"id\":\"9\",\"position\":1}],\"variations\":[],\"add_ons\":[],\"attributes\":[],\"choice_options\":[],\"price\":60,\"tax\":5,\"tax_type\":\"percent\",\"discount\":10,\"discount_type\":\"percent\",\"available_time_starts\":\"10:00:00\",\"available_time_ends\":\"23:00:00\",\"veg\":1,\"status\":1,\"restaurant_id\":12,\"created_at\":\"2022-12-02T12:37:30.000000Z\",\"updated_at\":\"2022-12-02T12:37:30.000000Z\",\"order_count\":0,\"avg_rating\":0,\"rating_count\":0,\"restaurant_name\":\"Taibat City Shebin\",\"restaurant_discount\":0,\"restaurant_opening_time\":\"10:00\",\"restaurant_closing_time\":\"23:00\",\"schedule_order\":false}', '[]', '[]', 6.00, 'discount_on_product', 1, 3.00, '\"\"', '2022-12-05 18:58:36', '2022-12-05 18:58:36', 0.00, NULL),
(3, 22, 100014, 60.00, '{\"id\":22,\"name\":\"\\u0634\\u062a\\u064a\\u0643\\u0646 \\u0647\\u0648\\u062a\",\"description\":\"demo product \",\"image\":\"\",\"category_id\":9,\"category_ids\":[{\"id\":\"1\",\"position\":0},{\"id\":\"9\",\"position\":1}],\"variations\":[],\"add_ons\":[],\"attributes\":[],\"choice_options\":[],\"price\":60,\"tax\":5,\"tax_type\":\"percent\",\"discount\":10,\"discount_type\":\"percent\",\"available_time_starts\":\"10:00:00\",\"available_time_ends\":\"23:00:00\",\"veg\":1,\"status\":1,\"restaurant_id\":12,\"created_at\":\"2022-12-02T12:37:30.000000Z\",\"updated_at\":\"2022-12-02T12:37:30.000000Z\",\"order_count\":0,\"avg_rating\":0,\"rating_count\":0,\"restaurant_name\":\"Taibat City Shebin\",\"restaurant_discount\":0,\"restaurant_opening_time\":\"10:00\",\"restaurant_closing_time\":\"23:00\",\"schedule_order\":false}', '[]', '[]', 6.00, 'discount_on_product', 1, 3.00, '\"\"', '2022-12-05 18:59:47', '2022-12-05 18:59:47', 0.00, NULL),
(4, 24, 100014, 60.00, '{\"id\":24,\"name\":\"\\u0634\\u064a\\u0643\\u0646 \\u0645\\u0648\\u0632\\u0627\\u0631\\u064a\\u0644\\u0627\",\"description\":\"demo product \",\"image\":\"\",\"category_id\":9,\"category_ids\":[{\"id\":\"1\",\"position\":0},{\"id\":\"9\",\"position\":1}],\"variations\":[],\"add_ons\":[],\"attributes\":[],\"choice_options\":[],\"price\":60,\"tax\":5,\"tax_type\":\"percent\",\"discount\":10,\"discount_type\":\"percent\",\"available_time_starts\":\"10:00:00\",\"available_time_ends\":\"23:00:00\",\"veg\":1,\"status\":1,\"restaurant_id\":12,\"created_at\":\"2022-12-02T12:37:30.000000Z\",\"updated_at\":\"2022-12-02T12:37:30.000000Z\",\"order_count\":0,\"avg_rating\":0,\"rating_count\":0,\"restaurant_name\":\"Taibat City Shebin\",\"restaurant_discount\":0,\"restaurant_opening_time\":\"10:00\",\"restaurant_closing_time\":\"23:00\",\"schedule_order\":false}', '[]', '[]', 6.00, 'discount_on_product', 1, 3.00, '\"\"', '2022-12-05 18:59:47', '2022-12-05 18:59:47', 0.00, NULL),
(5, 22, 100015, 60.00, '{\"id\":22,\"name\":\"\\u0634\\u062a\\u064a\\u0643\\u0646 \\u0647\\u0648\\u062a\",\"description\":\"demo product \",\"image\":\"\",\"category_id\":9,\"category_ids\":[{\"id\":\"1\",\"position\":0},{\"id\":\"9\",\"position\":1}],\"variations\":[],\"add_ons\":[],\"attributes\":[],\"choice_options\":[],\"price\":60,\"tax\":5,\"tax_type\":\"percent\",\"discount\":10,\"discount_type\":\"percent\",\"available_time_starts\":\"10:00:00\",\"available_time_ends\":\"23:00:00\",\"veg\":1,\"status\":1,\"restaurant_id\":12,\"created_at\":\"2022-12-02T12:37:30.000000Z\",\"updated_at\":\"2022-12-02T12:37:30.000000Z\",\"order_count\":0,\"avg_rating\":0,\"rating_count\":0,\"restaurant_name\":\"Taibat City Shebin\",\"restaurant_discount\":0,\"restaurant_opening_time\":\"10:00\",\"restaurant_closing_time\":\"23:00\",\"schedule_order\":false}', '[]', '[]', 6.00, 'discount_on_product', 1, 3.00, '\"\"', '2022-12-05 19:00:10', '2022-12-05 19:00:10', 0.00, NULL),
(6, NULL, 100018, 80.00, '{\"id\":1,\"name\":\"sheesh Tawooq\",\"description\":\"demo product\",\"image\":\"\",\"category_id\":1,\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":0}]\",\"variations\":\"[{\\\"type\\\":\\\"L\\\",\\\"price\\\":95},{\\\"type\\\":\\\"M\\\",\\\"price\\\":75}]\",\"add_ons\":\"[]\",\"attributes\":\"[\\\"1\\\"]\",\"choice_options\":\"[{\\\"name\\\":\\\"choice_1\\\",\\\"title\\\":\\\"\\\\u0627\\\\u0644\\\\u062d\\\\u062c\\\\u0645\\\",\\\"options\\\":[\\\"L\\\",\\\"M\\\"]}]\",\"price\":95,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"available_time_starts\":\"2023-10-17T10:00:00.000000Z\",\"available_time_ends\":\"2023-10-17T04:05:00.000000Z\",\"veg\":true,\"status\":true,\"restaurant_id\":3,\"created_at\":\"2022-12-02T19:37:30.000000Z\",\"updated_at\":\"2023-06-07T14:52:04.000000Z\",\"order_count\":0,\"avg_rating\":0,\"rating_count\":0,\"rating\":null}', NULL, NULL, NULL, 'amount', 2, 1.00, NULL, '2023-10-17 06:07:59', '2023-10-17 06:07:59', 0.00, NULL),
(7, 1, 100019, 80.00, '{\"id\":1,\"name\":\"sheesh Tawooq\",\"description\":\"demo product\",\"image\":\"\",\"category_id\":1,\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":0}]\",\"variations\":\"[{\\\"type\\\":\\\"L\\\",\\\"price\\\":95},{\\\"type\\\":\\\"M\\\",\\\"price\\\":75}]\",\"add_ons\":\"[]\",\"attributes\":\"[\\\"1\\\"]\",\"choice_options\":\"[{\\\"name\\\":\\\"choice_1\\\",\\\"title\\\":\\\"\\\\u0627\\\\u0644\\\\u062d\\\\u062c\\\\u0645\\\",\\\"options\\\":[\\\"L\\\",\\\"M\\\"]}]\",\"price\":95,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"available_time_starts\":\"2023-10-17T10:00:00.000000Z\",\"available_time_ends\":\"2023-10-17T04:05:00.000000Z\",\"veg\":true,\"status\":true,\"restaurant_id\":3,\"created_at\":\"2022-12-02T19:37:30.000000Z\",\"updated_at\":\"2023-06-07T14:52:04.000000Z\",\"order_count\":0,\"avg_rating\":0,\"rating_count\":0,\"rating\":null}', NULL, NULL, NULL, 'amount', 2, 1.00, NULL, '2023-10-17 06:10:39', '2023-10-17 06:10:39', 0.00, NULL),
(8, 1, 100020, 80.00, '{\"id\":1,\"name\":\"sheesh Tawooq\",\"description\":\"demo product\",\"image\":\"\",\"category_id\":1,\"category_ids\":\"[{\\\"id\\\":\\\"1\\\",\\\"position\\\":0}]\",\"variations\":\"[{\\\"type\\\":\\\"L\\\",\\\"price\\\":95},{\\\"type\\\":\\\"M\\\",\\\"price\\\":75}]\",\"add_ons\":\"[]\",\"attributes\":\"[\\\"1\\\"]\",\"choice_options\":\"[{\\\"name\\\":\\\"choice_1\\\",\\\"title\\\":\\\"\\\\u0627\\\\u0644\\\\u062d\\\\u062c\\\\u0645\\\",\\\"options\\\":[\\\"L\\\",\\\"M\\\"]}]\",\"price\":95,\"tax\":0,\"tax_type\":\"percent\",\"discount\":0,\"discount_type\":\"percent\",\"available_time_starts\":\"2023-10-17T10:00:00.000000Z\",\"available_time_ends\":\"2023-10-17T04:05:00.000000Z\",\"veg\":true,\"status\":true,\"restaurant_id\":3,\"created_at\":\"2022-12-02T19:37:30.000000Z\",\"updated_at\":\"2023-06-07T14:52:04.000000Z\",\"order_count\":0,\"avg_rating\":0,\"rating_count\":0,\"rating\":null}', NULL, NULL, NULL, 'amount', 2, 1.00, NULL, '2023-10-17 06:15:52', '2023-10-17 06:15:52', 0.00, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_transactions`
--

CREATE TABLE `order_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `delivery_man_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `order_amount` decimal(24,2) NOT NULL,
  `restaurant_amount` decimal(24,2) NOT NULL,
  `admin_commission` decimal(24,2) NOT NULL,
  `received_by` varchar(255) NOT NULL,
  `original_delivery_charge` decimal(24,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(24,2) NOT NULL DEFAULT 0.00,
  `status` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_charge` decimal(24,2) NOT NULL DEFAULT 0.00,
  `zone_id` bigint(20) UNSIGNED DEFAULT NULL,
  `dm_tips` double(24,2) NOT NULL DEFAULT 0.00,
  `delivery_fee_comission` double(24,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `phone_verifications`
--

CREATE TABLE `phone_verifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `phone` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `provide_d_m_earnings`
--

CREATE TABLE `provide_d_m_earnings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_man_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `method` varchar(255) DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `restaurants`
--

CREATE TABLE `restaurants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `footer_text` text DEFAULT NULL,
  `minimum_order` decimal(24,2) NOT NULL DEFAULT 0.00,
  `comission` decimal(24,2) DEFAULT NULL,
  `opening_time` time DEFAULT '10:00:00',
  `closeing_time` time DEFAULT '23:00:00',
  `free_delivery` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `compilation_id` int(11) NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rating` varchar(255) DEFAULT NULL,
  `cover_photo` varchar(255) DEFAULT NULL,
  `delivery` tinyint(1) NOT NULL DEFAULT 1,
  `take_away` tinyint(1) NOT NULL DEFAULT 1,
  `schedule_order` tinyint(1) NOT NULL DEFAULT 0,
  `food_section` tinyint(1) NOT NULL DEFAULT 1,
  `tax` decimal(24,2) NOT NULL DEFAULT 0.00,
  `zone_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reviews_section` tinyint(1) NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `off_day` varchar(255) NOT NULL DEFAULT ' ',
  `gst` varchar(255) DEFAULT NULL,
  `self_delivery_system` tinyint(1) NOT NULL DEFAULT 0,
  `pos_system` tinyint(1) NOT NULL DEFAULT 0,
  `delivery_charge` decimal(24,2) NOT NULL DEFAULT 0.00,
  `delivery_time` varchar(10) DEFAULT '30-40',
  `delivery_time_unit` enum('hours','minutes') NOT NULL DEFAULT 'minutes',
  `veg` tinyint(1) NOT NULL DEFAULT 1,
  `non_veg` tinyint(1) NOT NULL DEFAULT 1,
  `order_count` int(11) NOT NULL DEFAULT 0,
  `minimum_shipping_charge` float NOT NULL DEFAULT 0,
  `shipping_coast` float NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `restaurants`
--

INSERT INTO `restaurants` (`id`, `name`, `phone`, `email`, `logo`, `latitude`, `longitude`, `address`, `footer_text`, `minimum_order`, `comission`, `opening_time`, `closeing_time`, `free_delivery`, `status`, `compilation_id`, `vendor_id`, `created_at`, `updated_at`, `rating`, `cover_photo`, `delivery`, `take_away`, `schedule_order`, `food_section`, `tax`, `zone_id`, `reviews_section`, `active`, `off_day`, `gst`, `self_delivery_system`, `pos_system`, `delivery_charge`, `delivery_time`, `delivery_time_unit`, `veg`, `non_veg`, `order_count`, `minimum_shipping_charge`, `shipping_coast`, `deleted_at`) VALUES
(1, 'المهندسين', '1605316053', 'mohandseen@taibat.com', '2023-05-31-647719e553772.png', '30.0670220059917', '31.20173273112938', 'المهندسين شارع شهاب', NULL, 0.00, NULL, '10:00:00', '23:00:00', 0, 1, 1, 10, '2023-05-31 12:56:53', '2023-05-31 12:56:53', NULL, '2023-05-31-647719e55787f.png', 1, 1, 0, 1, 5.00, 4, 1, 1, ' ', NULL, 0, 0, 0.00, '10-30', 'hours', 1, 1, 0, 0, 0, NULL),
(2, 'طنطا', '010050088703', 'tanta@eltaibat.com', '2023-05-31-647724b95cc09.png', '30.829638906807343', '31.005752129371107', 'طنطا', NULL, 0.00, NULL, '10:00:00', '23:00:00', 0, 1, 1, 8, '2023-05-31 13:43:05', '2023-05-31 13:43:05', NULL, '2023-05-31-647724b95dedd.png', 1, 1, 0, 1, 5.00, 5, 1, 1, ' ', NULL, 0, 0, 0.00, '10-30', 'hours', 1, 1, 0, 0, 0, NULL),
(3, 'شبين الكوم', '01113008870', 'shebin@altaibat.net', 'images/place/1700522694.png', '30.55038421667931', '31.019373256522183', 'monofya -shebin elkom p.o23511', 'مشويات ، مخبوزات', 0.00, NULL, '08:00:00', '00:00:00', 0, 0, 1, 1, '2023-05-31 13:44:58', '2023-11-20 23:24:54', '{\"1\":0,\"2\":0,\"3\":0,\"4\":0,\"5\":3}', 'images/place/1700522694.png', 1, 1, 0, 1, 5.00, 1, 1, 1, ' ', NULL, 0, 0, 34.00, '10-30', 'hours', 1, 1, 0, 0, 0, NULL),
(4, 'معاذ احمد نصر', NULL, NULL, 'images/place/1698994530.jpg', '30.5458982', '31.0126785', 'شبين', 'أغذيه-منظفات', 0.00, NULL, '07:48:00', '00:00:00', 0, 0, 4, 1, '2023-11-03 04:55:30', '2023-11-09 13:28:49', NULL, 'images/place/1698994530.png', 1, 1, 0, 1, 0.00, 1, 1, 1, ' ', NULL, 0, 0, 15.00, '30-50', 'hours', 1, 1, 0, 0, 0, NULL),
(5, 'kazyon', NULL, NULL, NULL, '30.5458982', '31.0126785', 'شبين', 'أغذيه-منظفات', 0.00, NULL, '07:48:00', '00:00:00', 0, 1, 4, 1, '2023-11-05 00:01:02', '2023-11-05 07:19:08', NULL, NULL, 1, 1, 0, 1, 0.00, 1, 1, 1, ' ', NULL, 0, 0, 15.00, '30-50', 'hours', 1, 1, 0, 0, 0, '2023-11-05 07:19:08'),
(6, 'مطعم كاتشب', NULL, NULL, 'images/place/1699537040.png', '54.053992238175006', '163.52345222327773', '10 Mohi El-Mahdi St', 'مطعم كاتشب بركة السبع', 0.00, NULL, '03:33:00', '00:00:00', 0, 1, 1, 1, '2023-11-09 13:37:20', '2023-11-11 13:42:25', NULL, 'images/place/1699537040.png', 1, 1, 0, 1, 0.00, 1, 1, 1, ' ', NULL, 0, 0, 37.00, '٢٠-٦٠', 'hours', 1, 1, 0, 0, 0, NULL),
(7, 'ss', NULL, NULL, 'images/place/1699688801.jpg', '4322342', '4234242', 'ss', 'ss', 0.00, NULL, '09:44:00', '11:44:00', 0, 0, 2, 1, '2023-11-11 07:46:41', '2023-11-11 20:17:40', NULL, 'images/place/1699688801.png', 1, 1, 0, 1, 0.00, 1, 1, 1, ' ', NULL, 0, 0, 34.00, '30-50', 'hours', 1, 1, 0, 0, 0, NULL),
(8, 'ytryr', NULL, NULL, 'images/place/1699691007.jpg', '7567', '57675675', 'rwtr', 'rrwrw', 0.00, NULL, '09:55:00', '00:00:00', 0, 1, 4, 12, '2023-11-11 08:23:27', '2023-11-11 08:36:44', NULL, 'images/place/1699691007.png', 1, 1, 0, 1, 0.00, 3, 1, 1, ' ', NULL, 0, 0, 44.00, '30-50', 'hours', 1, 1, 0, 0, 0, NULL),
(9, 'مطعم كاتشب السبع', NULL, NULL, 'images/place/1699710724.jpg', '30.5537199', '31.0421278', 'بركة السبع غرب', 'مشويات ، مخبوزات', 0.00, NULL, '16:50:00', '00:00:00', 0, 1, 1, 13, '2023-11-11 13:52:04', '2023-11-11 13:56:54', NULL, 'images/place/1699710724.jpg', 1, 1, 0, 1, 0.00, 1, 1, 1, ' ', NULL, 0, 0, 45.00, '49-56', 'hours', 1, 1, 0, 0, 0, NULL),
(10, '555', NULL, NULL, 'images/place/1699730343.png', '30.5458982', '31.0131169', 'retert', 'ttert', 0.00, NULL, '21:18:00', '23:18:00', 0, 1, 1, 17, '2023-11-11 19:19:03', '2023-11-21 09:59:41', NULL, 'images/place/1699730343.jpg', 1, 1, 0, 1, 0.00, 1, 1, 1, ' ', NULL, 0, 0, 34.00, '30-50', 'minutes', 1, 1, 0, 0, 0, NULL),
(11, 'حلويات عبد الفتاح', NULL, NULL, 'images/place/1699730614.png', '30.5537199', '31.0421278', 'بركة السبع', 'هايبر ، بقالة', 0.00, NULL, '21:24:00', '09:25:00', 0, 1, 4, 18, '2023-11-11 19:23:34', '2023-11-11 19:23:34', NULL, 'images/place/1699730614.png', 1, 1, 0, 1, 0.00, 1, 1, 1, ' ', NULL, 0, 0, 56.00, '23-45', 'minutes', 1, 1, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_schedule`
--

CREATE TABLE `restaurant_schedule` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `day` int(11) NOT NULL,
  `opening_time` time DEFAULT NULL,
  `closing_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `restaurant_schedule`
--

INSERT INTO `restaurant_schedule` (`id`, `restaurant_id`, `day`, `opening_time`, `closing_time`, `created_at`, `updated_at`) VALUES
(2, 12, 2, '08:26:00', '23:26:00', NULL, NULL),
(3, 12, 1, '08:26:00', '23:26:00', NULL, NULL),
(4, 12, 3, '08:26:00', '23:26:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_wallets`
--

CREATE TABLE `restaurant_wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `total_earning` decimal(24,2) NOT NULL DEFAULT 0.00,
  `total_withdrawn` decimal(24,2) NOT NULL DEFAULT 0.00,
  `pending_withdraw` decimal(24,2) NOT NULL DEFAULT 0.00,
  `collected_cash` decimal(24,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `restaurant_zone`
--

CREATE TABLE `restaurant_zone` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `restaurant_zone`
--

INSERT INTO `restaurant_zone` (`id`, `restaurant_id`, `zone_id`, `created_at`, `updated_at`) VALUES
(1, 13, 3, NULL, NULL),
(2, 3, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `food_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `comment` mediumtext DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT 0,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `food_id`, `user_id`, `comment`, `attachment`, `rating`, `order_id`, `created_at`, `updated_at`, `status`) VALUES
(1, 1, 2, 'bad', NULL, 1, 100019, NULL, NULL, 1),
(2, 1, 2, 'bad', NULL, 1, 100019, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `social_media`
--

CREATE TABLE `social_media` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `time_logs`
--

CREATE TABLE `time_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `online` time DEFAULT NULL,
  `offline` time DEFAULT NULL,
  `working_hour` double(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `track_deliverymen`
--

CREATE TABLE `track_deliverymen` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `delivery_man_id` bigint(20) UNSIGNED DEFAULT NULL,
  `longitude` varchar(20) DEFAULT NULL,
  `latitude` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `translationable_type` varchar(255) NOT NULL,
  `translationable_id` bigint(20) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `key` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(100) DEFAULT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `is_phone_verified` tinyint(1) NOT NULL DEFAULT 0,
  `active` tinyint(4) NOT NULL DEFAULT 0,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `email_verification_token` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `interest` varchar(255) DEFAULT NULL,
  `cm_firebase_token` varchar(255) DEFAULT NULL,
  `order_count` int(11) NOT NULL DEFAULT 0,
  `login_medium` varchar(191) DEFAULT NULL,
  `social_id` varchar(191) DEFAULT NULL,
  `zone_id` bigint(20) UNSIGNED DEFAULT NULL,
  `wallet_balance` decimal(24,3) NOT NULL DEFAULT 0.000,
  `loyalty_point` decimal(24,3) NOT NULL DEFAULT 0.000,
  `ref_code` varchar(10) DEFAULT NULL,
  `last_login` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `f_name`, `l_name`, `phone`, `email`, `image`, `is_phone_verified`, `active`, `email_verified_at`, `password`, `email_verification_token`, `remember_token`, `created_at`, `updated_at`, `interest`, `cm_firebase_token`, `order_count`, `login_medium`, `social_id`, `zone_id`, `wallet_balance`, `loyalty_point`, `ref_code`, `last_login`) VALUES
(2, 'fatmaapi', 'gh_7', '+2001022752344', 'fatmaghareeb@gmail.com', NULL, 1, 1, NULL, '$2y$10$85FSMihP9i90aNE/5UAtkODWaFrxviiKLossze3/TuxkvGG5a2vfy', NULL, NULL, '2023-11-11 11:42:38', '2023-11-22 19:16:19', NULL, NULL, 0, NULL, NULL, NULL, 0.000, 0.000, NULL, '2023-11-22 19:16:19'),
(5, 'fatmaapi0', 'gh_70', '+20010227523447', 'fatmagha4ree4b@gmail.com0', NULL, 0, 0, NULL, '$2y$10$rU3neGrXh/vJq5DBPhqjTuQKkeJ8U1EMK8mNJqMp1u8KdEijN5tTq', NULL, NULL, '2023-11-11 09:10:17', '2023-11-11 09:10:17', NULL, NULL, 0, NULL, NULL, NULL, 0.000, 0.000, NULL, '2023-11-11 09:10:17'),
(8, 'fatmaapio', 'gh_7', '+201092377558', 'fatmaghareebu@gmail.com', NULL, 1, 1, NULL, '$2y$10$zRY7EIjiMGIO2yqmrA/Yu.3YFbDkantkBwZPlV/Um9/Y5TUWPLioS', NULL, NULL, '2023-11-18 20:02:42', '2023-11-18 20:03:38', NULL, NULL, 0, NULL, NULL, NULL, 0.000, 0.000, NULL, '2023-11-18 20:02:42'),
(10, 'Amr', 'Khaled', '+2001025314161', 'amr@gmail.com', NULL, 1, 1, NULL, '$2y$10$mx4AjCxRCiUTqR0q/9zLpuG779b.8uaxZiRdLzOKOZD1K.aViN1NG', NULL, NULL, '2023-11-22 20:41:28', '2023-11-22 20:41:57', NULL, NULL, 0, NULL, NULL, NULL, 0.000, 0.000, NULL, '2023-11-22 20:41:28');

-- --------------------------------------------------------

--
-- Table structure for table `user_infos`
--

CREATE TABLE `user_infos` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(100) DEFAULT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `admin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `vendor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `deliveryman_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `data` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `vendor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `delivery_man_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(100) NOT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `admin_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `holder_name` varchar(255) DEFAULT NULL,
  `account_no` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `firebase_token` varchar(255) DEFAULT NULL,
  `auth_token` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `f_name`, `l_name`, `phone`, `email`, `email_verified_at`, `password`, `remember_token`, `admin_id`, `created_at`, `updated_at`, `bank_name`, `branch`, `holder_name`, `account_no`, `image`, `status`, `firebase_token`, `auth_token`, `deleted_at`) VALUES
(1, 'mohamed ba', 'ghareeb', '5435345247657', 'estbsher@gmail.com', '2022-09-01 06:17:03', '$2y$10$yK35EXhPMGzaTep88zmA3.hBayoYUWB5SFfB0dGU1c2ZoErPwyH9y', '3QaQA7hycud4e5Zz6RijrCD351tbtSVmqerJSNva6FxUfRoTBC3tyrk2rGJF', 1, NULL, '2023-11-20 23:25:55', 'ewrewrwe', 'wew', 'reewrwerw', '25345465765756', NULL, 1, NULL, NULL, NULL),
(8, 'محمد', 'كازيون', '01123467898', 'kazyon@gmail.com', NULL, '$2y$10$yK35EXhPMGzaTep88zmA3.hBayoYUWB5SFfB0dGU1c2ZoErPwyH9y', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(9, 'Muaz', 'Ahmed Nasr', '+201154285418', 'muathahmednasr@gmail.com', NULL, '$2y$10$tBLw/JJLmv1AX.IOOG591e2EiXj/CY3VF0s1TkpwiwawcsLP8vj7u', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(10, 'soha', 'hessien', '44334333', 'hessien@gmail.com', NULL, '$2y$10$aId.hFrkALkzgiWng/IP2OrCmEJLrlhvNgDD3fxS2.N0GYXdMqTfa', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(12, 'eeee', 'rrrr', '43456464', 'eeee@ee.com', NULL, '$2y$10$g4xvfabw4wERR..yDjH4vOKKmPbslj4nV34z5j20YomeYh474U9P6', NULL, NULL, NULL, '2023-11-11 08:51:45', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(13, 'Muaz', 'Nasr', '01154285418', 'firnasapp@gmail.com', NULL, '$2y$10$y3EtiqFO8ZjYDQQ47TKgoumV4yhOqLRbVkYpsu./KQ3jmuJHAZ0W6', NULL, NULL, NULL, '2023-11-11 18:06:03', NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(17, 'customer', 'shebin', '0112160753', 'faris@farisgrp.com', NULL, '$2y$10$twH8bDyB1xGX7JUslq2ImeCFG/7iLA7XU0lPNvoReCwJsGWzzkTtS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL),
(18, 'nasw', 'kao', '01154285419', 'muazcode22@gmail.com', NULL, '$2y$10$Tsxvk3XFXcr9LkhYg0GmA.p5oMj/B9AWGL278I6bYHQOMY4LfoScy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendor_employees`
--

CREATE TABLE `vendor_employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `f_name` varchar(100) DEFAULT NULL,
  `l_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `employee_role_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `restaurant_id` bigint(20) UNSIGNED NOT NULL,
  `password` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) DEFAULT NULL,
  `firebase_token` varchar(255) DEFAULT NULL,
  `auth_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `transaction_id` char(36) NOT NULL,
  `credit` decimal(24,3) NOT NULL DEFAULT 0.000,
  `debit` decimal(24,3) NOT NULL DEFAULT 0.000,
  `admin_bonus` decimal(24,3) NOT NULL DEFAULT 0.000,
  `balance` decimal(24,3) NOT NULL DEFAULT 0.000,
  `transaction_type` varchar(191) DEFAULT NULL,
  `reference` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `food_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `restaurant_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_requests`
--

CREATE TABLE `withdraw_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `transaction_note` varchar(255) NOT NULL,
  `amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `approved` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coordinates` polygon DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `restaurant_wise_topic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_wise_topic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deliveryman_wise_topic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minimum_shipping_charge` double(16,3) UNSIGNED DEFAULT NULL,
  `per_km_shipping_charge` double(16,3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`id`, `name`, `coordinates`, `status`, `created_at`, `updated_at`, `restaurant_wise_topic`, `customer_wise_topic`, `deliveryman_wise_topic`, `minimum_shipping_charge`, `per_km_shipping_charge`) VALUES
(1, 'شبين الكوم', 0x0000000001030000000100000005000000ee7f58e3a30b3f40f0ecaad3e4923e40357f586376133f40fe01505b21893e40ea7f582310f63e40c1dd77bc34893e40dd7f58e3a4fb3e40aadb48b621903e40ee7f58e3a30b3f40f0ecaad3e4923e40, 1, '2022-11-29 09:16:48', '2022-11-29 09:16:48', 'zone_2_restaurant', 'zone_2_customer', 'zone_2_delivery_man', 10.000, 10.000),
(3, 'Banha', 0x0000000001030000000100000004000000a3b3289f6e313f4001e1a6cc8f793e4017b3289f96273f403794635a9f753e4080b3289f30333f40bf538bed49723e40a3b3289f6e313f4001e1a6cc8f793e40, 1, '2022-12-01 12:30:08', '2022-12-01 12:30:08', 'zone_2_restaurant', 'zone_2_customer', 'zone_2_delivery_man', 10.000, 10.000),
(4, 'المهندسين', 0x00000000010300000001000000060000006100008092463f407dd12de226e13d406100008012b73f4004a064d2e0113e4061000080125d3f4071922fc50c733e406100008012a93e403d1d2de5a63d3e406100008072a33e4011e81b95e7ea3d406100008092463f407dd12de226e13d40, 1, '2023-05-31 12:44:34', '2023-05-31 12:44:34', 'zone_3_restaurant', 'zone_3_customer', 'zone_3_delivery_man', 10.000, 30.000),
(5, 'طنطا', 0x000000000103000000010000000500000088000040a4383f40e95b5cba41e03e4088000040b4ec3e40587cd6346aa13e408800004074873e40ce4cd99c85ca3e4088000040740e3f40760c6352d9063f4088000040a4383f40e95b5cba41e03e40, 1, '2023-05-31 12:45:24', '2023-05-31 12:45:24', 'zone_4_restaurant', 'zone_4_customer', 'zone_4_delivery_man', 10.000, 30.000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account_transactions`
--
ALTER TABLE `account_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `add_ons`
--
ALTER TABLE `add_ons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `admin_roles`
--
ALTER TABLE `admin_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_wallets`
--
ALTER TABLE `admin_wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_settings`
--
ALTER TABLE `business_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `compilations`
--
ALTER TABLE `compilations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `conversations`
--
ALTER TABLE `conversations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupons_code_unique` (`code`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customer_addresses`
--
ALTER TABLE `customer_addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_histories`
--
ALTER TABLE `delivery_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_man_wallets`
--
ALTER TABLE `delivery_man_wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery_men`
--
ALTER TABLE `delivery_men`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `delivery_men_phone_unique` (`phone`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `d_m_reviews`
--
ALTER TABLE `d_m_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_verifications`
--
ALTER TABLE `email_verifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employee_roles`
--
ALTER TABLE `employee_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `food_slider_images`
--
ALTER TABLE `food_slider_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loyalty_point_transactions`
--
ALTER TABLE `loyalty_point_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mail_configs`
--
ALTER TABLE `mail_configs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `newsletters`
--
ALTER TABLE `newsletters`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `newsletters_email_unique` (`email`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_delivery_histories`
--
ALTER TABLE `order_delivery_histories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_transactions`
--
ALTER TABLE `order_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_transactions_zone_id_index` (`zone_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `phone_verifications`
--
ALTER TABLE `phone_verifications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `phone_verifications_phone_unique` (`phone`);

--
-- Indexes for table `provide_d_m_earnings`
--
ALTER TABLE `provide_d_m_earnings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `restaurants`
--
ALTER TABLE `restaurants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `restaurants_phone_unique` (`phone`);

--
-- Indexes for table `restaurant_schedule`
--
ALTER TABLE `restaurant_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `restaurant_wallets`
--
ALTER TABLE `restaurant_wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `restaurant_zone`
--
ALTER TABLE `restaurant_zone`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `social_media`
--
ALTER TABLE `social_media`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `time_logs`
--
ALTER TABLE `time_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `track_deliverymen`
--
ALTER TABLE `track_deliverymen`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `translations_translationable_id_index` (`translationable_id`),
  ADD KEY `translations_locale_index` (`locale`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_ref_code_unique` (`ref_code`),
  ADD KEY `users_zone_id_index` (`zone_id`);

--
-- Indexes for table `user_infos`
--
ALTER TABLE `user_infos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendors_phone_unique` (`phone`),
  ADD UNIQUE KEY `vendors_email_unique` (`email`);

--
-- Indexes for table `vendor_employees`
--
ALTER TABLE `vendor_employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendor_employees_email_unique` (`email`);

--
-- Indexes for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `zones_name_unique` (`name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account_transactions`
--
ALTER TABLE `account_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `add_ons`
--
ALTER TABLE `add_ons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_roles`
--
ALTER TABLE `admin_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_wallets`
--
ALTER TABLE `admin_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `business_settings`
--
ALTER TABLE `business_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `compilations`
--
ALTER TABLE `compilations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `conversations`
--
ALTER TABLE `conversations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customer_addresses`
--
ALTER TABLE `customer_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `delivery_histories`
--
ALTER TABLE `delivery_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_man_wallets`
--
ALTER TABLE `delivery_man_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `delivery_men`
--
ALTER TABLE `delivery_men`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `d_m_reviews`
--
ALTER TABLE `d_m_reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_verifications`
--
ALTER TABLE `email_verifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_roles`
--
ALTER TABLE `employee_roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `food_slider_images`
--
ALTER TABLE `food_slider_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `loyalty_point_transactions`
--
ALTER TABLE `loyalty_point_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mail_configs`
--
ALTER TABLE `mail_configs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT for table `newsletters`
--
ALTER TABLE `newsletters`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100021;

--
-- AUTO_INCREMENT for table `order_delivery_histories`
--
ALTER TABLE `order_delivery_histories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `order_transactions`
--
ALTER TABLE `order_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_verifications`
--
ALTER TABLE `phone_verifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `provide_d_m_earnings`
--
ALTER TABLE `provide_d_m_earnings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `restaurants`
--
ALTER TABLE `restaurants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `restaurant_schedule`
--
ALTER TABLE `restaurant_schedule`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `restaurant_wallets`
--
ALTER TABLE `restaurant_wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `restaurant_zone`
--
ALTER TABLE `restaurant_zone`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `social_media`
--
ALTER TABLE `social_media`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `time_logs`
--
ALTER TABLE `time_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `track_deliverymen`
--
ALTER TABLE `track_deliverymen`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_infos`
--
ALTER TABLE `user_infos`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `vendor_employees`
--
ALTER TABLE `vendor_employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_requests`
--
ALTER TABLE `withdraw_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
