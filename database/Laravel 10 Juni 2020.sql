-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 11, 2020 at 03:53 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravelrista`
--

-- --------------------------------------------------------

--
-- Table structure for table `downloadable`
--

CREATE TABLE `downloadable` (
  `id` varchar(150) NOT NULL,
  `file_modul` varchar(150) NOT NULL,
  `id_modul` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `exclusive`
--

CREATE TABLE `exclusive` (
  `id` varchar(255) NOT NULL,
  `file_modul` varchar(255) NOT NULL,
  `id_modul` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `exclusive`
--

INSERT INTO `exclusive` (`id`, `file_modul`, `id_modul`) VALUES
('0e468c90-ab02-11ea-90ef-4db6face22ce', 'ef2fed3208c1ca242435bc7075630727.pdf', 2),
('99fb7170-ab08-11ea-800f-a9a1638b064f', '2893d43e1700857cf43c5508c5f70bc6.pdf', 2);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image` varchar(150) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `image_paket`
--

CREATE TABLE `image_paket` (
  `id` varchar(10) NOT NULL,
  `image` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `image_produk`
--

CREATE TABLE `image_produk` (
  `id` int(11) NOT NULL,
  `image` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `image_triaining`
--

CREATE TABLE `image_triaining` (
  `image` varchar(150) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `modul`
--

CREATE TABLE `modul` (
  `id_modul` int(11) NOT NULL,
  `id_produk` varchar(20) NOT NULL,
  `nama_modul` varchar(30) NOT NULL,
  `file_modul` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `modul`
--

INSERT INTO `modul` (`id_modul`, `id_produk`, `nama_modul`, `file_modul`) VALUES
(2, '1', 'Modul X', 'file.pdf'),
(3, '1', 'Modul X', 'file.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `paket`
--

CREATE TABLE `paket` (
  `id` varchar(10) NOT NULL,
  `training_id` int(11) NOT NULL,
  `nama_paket` varchar(20) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `harga` int(11) NOT NULL,
  `zoom` tinyint(1) NOT NULL,
  `max_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `paket`
--

INSERT INTO `paket` (`id`, `training_id`, `nama_paket`, `deskripsi`, `harga`, `zoom`, `max_user`) VALUES
('1', 1, 'Paket 1.1', 'Ini adalah paket 1.1', 3000000, 0, 3);

-- --------------------------------------------------------

--
-- Table structure for table `paket_max`
--

CREATE TABLE `paket_max` (
  `paket_id` varchar(10) NOT NULL,
  `max` int(11) DEFAULT NULL,
  `harga` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `paket_topik`
--

CREATE TABLE `paket_topik` (
  `id` varchar(20) NOT NULL,
  `paket_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `id_pembelian` varchar(150) NOT NULL,
  `users_id` int(11) NOT NULL,
  `bukti_pembayaran` varchar(150) DEFAULT NULL,
  `status_pembayaran` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembelian`
--

INSERT INTO `pembelian` (`id_pembelian`, `users_id`, `bukti_pembayaran`, `status_pembayaran`) VALUES
('028bd2f0-aadf-11ea-a71c-d1333d4b2a44', 27, NULL, NULL),
('0709bf00-aae4-11ea-bffd-f55f6b16ff5a', 27, NULL, NULL),
('0b3ff070-aad7-11ea-a747-ed84b2ea3096', 27, NULL, NULL),
('10f09940-aadc-11ea-b2cf-374ace412595', 27, NULL, NULL),
('1334d3b0-aad8-11ea-a9f1-b5621f3b148b', 27, NULL, NULL),
('150c5d60-aade-11ea-8cbd-0d50fb30b09f', 27, NULL, NULL),
('1c00cf20-aadc-11ea-a11a-0d3f1c5da942', 27, NULL, NULL),
('24e93600-aadd-11ea-b939-41b15789591d', 27, NULL, NULL),
('2503e820-aad8-11ea-aaec-4b5f56f3cc7b', 27, NULL, NULL),
('3584f8e0-aade-11ea-89cb-d513c275bb9a', 27, NULL, NULL),
('382b1f50-aad8-11ea-b4a6-e97997d6c6ae', 27, NULL, NULL),
('573ce840-aae3-11ea-bc95-e92f1f584530', 27, NULL, NULL),
('6465fcf0-aadf-11ea-9360-91e4d4b65ee8', 27, NULL, NULL),
('7446f970-aadc-11ea-9ef5-53c8b35a1f2d', 27, NULL, NULL),
('7fd869d0-aadc-11ea-8313-6359f56e7b3d', 27, NULL, NULL),
('8649e0e0-aadf-11ea-8af6-3f6542b25aa5', 27, NULL, NULL),
('8cc9a8a0-ab80-11ea-b713-0d24b8954fd4', 27, '5c170f2380ad1c539ef38405776d0132.jpeg', 'Yes'),
('915d1400-aadf-11ea-8936-49b76636e3b1', 27, NULL, NULL),
('a5ad3080-aadc-11ea-b0cb-df37ea9b67cd', 27, NULL, NULL),
('c9341f30-aae3-11ea-81fb-17060034bafc', 27, NULL, NULL),
('ca940010-aadc-11ea-9e44-d92eff18037f', 27, NULL, NULL),
('d22d8000-aad7-11ea-9160-eda522696aa7', 27, NULL, NULL),
('db2326a0-aadd-11ea-bf87-4dc8a16082ed', 27, NULL, NULL),
('db7e7120-aad7-11ea-abd2-ad37940900b9', 27, NULL, NULL),
('e44e59c0-aadd-11ea-adfb-d1e8bdc7beef', 27, NULL, NULL),
('e4761a80-aadc-11ea-8aef-e72539bbadd0', 27, NULL, NULL),
('f10e5520-aadc-11ea-ab30-5f1e1bc141f4', 27, NULL, NULL),
('f496f840-aadb-11ea-9d84-038ac1ca6bab', 27, NULL, NULL),
('f5ae7910-aadd-11ea-b40b-258dbbac01f8', 27, NULL, NULL),
('fe906b00-aadc-11ea-8b5d-6101701dda25', 27, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_paket`
--

CREATE TABLE `pembelian_paket` (
  `id_pembelian` varchar(100) NOT NULL,
  `id` varchar(10) NOT NULL,
  `list_email` varchar(255) NOT NULL,
  `pembelian_id_pembelian` varchar(150) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembelian_paket`
--

INSERT INTO `pembelian_paket` (`id_pembelian`, `id`, `list_email`, `pembelian_id_pembelian`, `created_at`) VALUES
('028d10f0-aadf-11ea-8501-e9ba515be2f5', '1', 'email1@gmail.com,email2@gmail.com', '028bd2f0-aadf-11ea-a71c-d1333d4b2a44', '2020-06-09 22:55:38'),
('028d1420-aadf-11ea-bb6d-cb1d39fcd4dc', '1', 'email1@gmail.com,email3@gmail.com', '028bd2f0-aadf-11ea-a71c-d1333d4b2a44', '2020-06-09 22:55:38'),
('070ae050-aae4-11ea-bfc6-03352dc08025', '1', 'email1@gmail.com,email2@gmail.com', '0709bf00-aae4-11ea-bffd-f55f6b16ff5a', '2020-06-09 23:31:33'),
('070ae200-aae4-11ea-96e0-319b52375a6a', '1', 'email1@gmail.com,email3@gmail.com', '0709bf00-aae4-11ea-bffd-f55f6b16ff5a', '2020-06-09 23:31:33'),
('10f1e1d0-aadc-11ea-905b-4fdc6a97048f', '1', 'email1@gmail.com,email2@gmail.com', '10f09940-aadc-11ea-b2cf-374ace412595', '2020-06-09 22:34:34'),
('150d6cb0-aade-11ea-bc08-c5c1112a42d4', '1', 'email1@gmail.com,email2@gmail.com', '150c5d60-aade-11ea-8cbd-0d50fb30b09f', '2020-06-09 22:49:00'),
('150d6e50-aade-11ea-bb49-3d28e33b97c7', '1', 'email1@gmail.com,email3@gmail.com', '150c5d60-aade-11ea-8cbd-0d50fb30b09f', '2020-06-09 22:49:00'),
('1c0206f0-aadc-11ea-a635-430a6c689bf6', '1', 'email1@gmail.com,email2@gmail.com', '1c00cf20-aadc-11ea-a11a-0d3f1c5da942', '2020-06-09 22:34:52'),
('24ea6cf0-aadd-11ea-8c0f-bfa0ba651e60', '1', 'email1@gmail.com,email2@gmail.com', '24e93600-aadd-11ea-b939-41b15789591d', '2020-06-09 22:42:17'),
('35862960-aade-11ea-b3ec-33e39e909584', '1', 'email1@gmail.com,email2@gmail.com', '3584f8e0-aade-11ea-89cb-d513c275bb9a', '2020-06-09 22:49:54'),
('35862b20-aade-11ea-bd23-4189fb8b9dbe', '1', 'email1@gmail.com,email3@gmail.com', '3584f8e0-aade-11ea-89cb-d513c275bb9a', '2020-06-09 22:49:54'),
('382c6b00-aad8-11ea-a55f-29e058b999b9', '1', 'email1@gmail.com,email2@gmail.com', '382b1f50-aad8-11ea-b4a6-e97997d6c6ae', '2020-06-09 22:07:02'),
('573e9ae0-aae3-11ea-a3ec-5168c97b1903', '1', 'email1@gmail.com,email2@gmail.com', '573ce840-aae3-11ea-bc95-e92f1f584530', '2020-06-09 23:26:38'),
('573e9ca0-aae3-11ea-add0-fd72a1aeccbb', '1', 'email1@gmail.com,email3@gmail.com', '573ce840-aae3-11ea-bc95-e92f1f584530', '2020-06-09 23:26:38'),
('646752e0-aadf-11ea-a1b2-378aa5a1a63d', '1', 'email1@gmail.com,email2@gmail.com', '6465fcf0-aadf-11ea-9360-91e4d4b65ee8', '2020-06-09 22:58:22'),
('646754b0-aadf-11ea-a705-dda09b608651', '1', 'email1@gmail.com,email3@gmail.com,email1@gmail.com,email3@gmail.com', '6465fcf0-aadf-11ea-9360-91e4d4b65ee8', '2020-06-09 22:58:22'),
('74485490-aadc-11ea-bc6f-85e7a4b3aa9f', '1', 'email1@gmail.com,email2@gmail.com', '7446f970-aadc-11ea-9ef5-53c8b35a1f2d', '2020-06-09 22:37:20'),
('7fd9c0d0-aadc-11ea-868a-29a14dbc8c38', '1', 'email1@gmail.com,email2@gmail.com', '7fd869d0-aadc-11ea-8313-6359f56e7b3d', '2020-06-09 22:37:40'),
('864b8a40-aadf-11ea-9d3c-4117cd8ebbf7', '1', 'email1@gmail.com,email2@gmail.com', '8649e0e0-aadf-11ea-8af6-3f6542b25aa5', '2020-06-09 22:59:19'),
('864b8cd0-aadf-11ea-b2bd-b56db95bb5e7', '1', 'email1@gmail.com,email3@gmail.com,email1@gmail.com,email3@gmail.com', '8649e0e0-aadf-11ea-8af6-3f6542b25aa5', '2020-06-09 22:59:19'),
('8cd080e0-ab80-11ea-a1a1-e9b90dfb847f', '1', 'email1@gmail.com,email2@gmail.com', '8cc9a8a0-ab80-11ea-b713-0d24b8954fd4', '2020-06-10 18:11:59'),
('8cd08260-ab80-11ea-ade3-a56e5a6e13db', '1', 'email1@gmail.com,email3@gmail.com', '8cc9a8a0-ab80-11ea-b713-0d24b8954fd4', '2020-06-10 18:11:59'),
('915e56c0-aadf-11ea-bbfd-512d5df20a06', '1', 'email1@gmail.com,email2@gmail.com', '915d1400-aadf-11ea-8936-49b76636e3b1', '2020-06-09 22:59:38'),
('915e5890-aadf-11ea-9fe2-af9e7f7b00f1', '1', 'email1@gmail.com,email3@gmail.com', '915d1400-aadf-11ea-8936-49b76636e3b1', '2020-06-09 22:59:38'),
('a5ae9ca0-aadc-11ea-a62b-715d5e18381a', '1', 'email1@gmail.com,email2@gmail.com', 'a5ad3080-aadc-11ea-b0cb-df37ea9b67cd', '2020-06-09 22:38:43'),
('c9357380-aae3-11ea-8998-1b16635abffe', '1', 'email1@gmail.com,email2@gmail.com', 'c9341f30-aae3-11ea-81fb-17060034bafc', '2020-06-09 23:29:49'),
('c9357540-aae3-11ea-a82f-3d4a5b0e156e', '1', 'email1@gmail.com,email3@gmail.com', 'c9341f30-aae3-11ea-81fb-17060034bafc', '2020-06-09 23:29:49'),
('ca9578e0-aadc-11ea-a96a-87ab5f7d6e30', '1', 'email1@gmail.com,email2@gmail.com', 'ca940010-aadc-11ea-9e44-d92eff18037f', '2020-06-09 22:39:45'),
('db2420b0-aadd-11ea-818e-8b093af85dcd', '1', 'email1@gmail.com,email2@gmail.com', 'db2326a0-aadd-11ea-bf87-4dc8a16082ed', '2020-06-09 22:47:22'),
('e44f8a10-aadd-11ea-83ef-e588b9922ea1', '1', 'email1@gmail.com,email2@gmail.com', 'e44e59c0-aadd-11ea-adfb-d1e8bdc7beef', '2020-06-09 22:47:38'),
('e4775090-aadc-11ea-99f2-f3039a668354', '1', 'email1@gmail.com,email2@gmail.com', 'e4761a80-aadc-11ea-8aef-e72539bbadd0', '2020-06-09 22:40:29'),
('f10f8860-aadc-11ea-b097-0b4d5161e23d', '1', 'email1@gmail.com,email2@gmail.com', 'f10e5520-aadc-11ea-ab30-5f1e1bc141f4', '2020-06-09 22:40:50'),
('f4985950-aadb-11ea-8168-9b13c09be1f3', '1', 'email1@gmail.com,email2@gmail.com', 'f496f840-aadb-11ea-9d84-038ac1ca6bab', '2020-06-09 22:33:46'),
('f5afa330-aadd-11ea-9f43-0706dadf299c', '1', 'email1@gmail.com,email2@gmail.com', 'f5ae7910-aadd-11ea-b40b-258dbbac01f8', '2020-06-09 22:48:07'),
('fe91a6f0-aadc-11ea-87eb-8b30bb7f631e', '1', 'email1@gmail.com,email2@gmail.com', 'fe906b00-aadc-11ea-8b5d-6101701dda25', '2020-06-09 22:41:12');

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_produk`
--

CREATE TABLE `pembelian_produk` (
  `id_pembelian` varchar(100) NOT NULL,
  `id_produk` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `pembelian_id_pembelian` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembelian_produk`
--

INSERT INTO `pembelian_produk` (`id_pembelian`, `id_produk`, `created_at`, `pembelian_id_pembelian`) VALUES
('028bd660-aadf-11ea-8c05-355044ec82b2', '1', '2020-06-10 05:55:38', '028bd2f0-aadf-11ea-a71c-d1333d4b2a44'),
('028d0c30-aadf-11ea-a41d-9129a4e4c290', '1', '2020-06-10 05:55:38', '028bd2f0-aadf-11ea-a71c-d1333d4b2a44'),
('0709c300-aae4-11ea-a11b-0d2e4c38471a', '1', '2020-06-10 06:31:33', '0709bf00-aae4-11ea-bffd-f55f6b16ff5a'),
('070adda0-aae4-11ea-b193-b3c7f3fdefb3', '1', '2020-06-10 06:31:33', '0709bf00-aae4-11ea-bffd-f55f6b16ff5a'),
('10f09d30-aadc-11ea-97a6-6f2890ccab78', '1', '2020-06-10 05:34:34', '10f09940-aadc-11ea-b2cf-374ace412595'),
('10f1dd40-aadc-11ea-bb59-d1fe74c0d078', '1', '2020-06-10 05:34:34', '10f09940-aadc-11ea-b2cf-374ace412595'),
('1334d700-aad8-11ea-abe1-29b0e88ce4df', '1', '2020-06-10 05:06:00', '1334d3b0-aad8-11ea-a9f1-b5621f3b148b'),
('13362c10-aad8-11ea-bbdb-7f8a4b1a8e66', '1', '2020-06-10 05:06:00', '1334d3b0-aad8-11ea-a9f1-b5621f3b148b'),
('150c60c0-aade-11ea-9cdb-67b835d59d81', '1', '2020-06-10 05:49:00', '150c5d60-aade-11ea-8cbd-0d50fb30b09f'),
('150d6a40-aade-11ea-8687-8b72f120fa51', '1', '2020-06-10 05:49:00', '150c5d60-aade-11ea-8cbd-0d50fb30b09f'),
('1c00d4e0-aadc-11ea-98f9-837c27994f54', '1', '2020-06-10 05:34:52', '1c00cf20-aadc-11ea-a11a-0d3f1c5da942'),
('1c020380-aadc-11ea-9a94-a758d4ddaf36', '1', '2020-06-10 05:34:52', '1c00cf20-aadc-11ea-a11a-0d3f1c5da942'),
('24e93970-aadd-11ea-a43b-07593584d974', '1', '2020-06-10 05:42:17', '24e93600-aadd-11ea-b939-41b15789591d'),
('24ea69f0-aadd-11ea-bef5-6dfc8e0c08b3', '1', '2020-06-10 05:42:17', '24e93600-aadd-11ea-b939-41b15789591d'),
('2503eb00-aad8-11ea-b26e-c1701b127bbc', '1', '2020-06-10 05:06:29', '2503e820-aad8-11ea-aaec-4b5f56f3cc7b'),
('2504dfb0-aad8-11ea-befb-579cd8489e95', '1', '2020-06-10 05:06:29', '2503e820-aad8-11ea-aaec-4b5f56f3cc7b'),
('3584fc40-aade-11ea-85a4-1bd9d091a633', '1', '2020-06-10 05:49:54', '3584f8e0-aade-11ea-89cb-d513c275bb9a'),
('358626c0-aade-11ea-8e62-734c058ffe23', '1', '2020-06-10 05:49:54', '3584f8e0-aade-11ea-89cb-d513c275bb9a'),
('382b2430-aad8-11ea-b5f8-6994f3f4b3c9', '1', '2020-06-10 05:07:02', '382b1f50-aad8-11ea-b4a6-e97997d6c6ae'),
('382c67c0-aad8-11ea-8006-679d1d4d4f24', '1', '2020-06-10 05:07:02', '382b1f50-aad8-11ea-b4a6-e97997d6c6ae'),
('573cec10-aae3-11ea-a662-5f4a16dfb400', '1', '2020-06-10 06:26:38', '573ce840-aae3-11ea-bc95-e92f1f584530'),
('573e97c0-aae3-11ea-b445-d97977de005d', '1', '2020-06-10 06:26:38', '573ce840-aae3-11ea-bc95-e92f1f584530'),
('646601f0-aadf-11ea-9eab-0baaf4babb59', '1', '2020-06-10 05:58:22', '6465fcf0-aadf-11ea-9360-91e4d4b65ee8'),
('64674fd0-aadf-11ea-8747-f1275664b052', '1', '2020-06-10 05:58:22', '6465fcf0-aadf-11ea-9360-91e4d4b65ee8'),
('7446fda0-aadc-11ea-962a-cba2129fa82a', '1', '2020-06-10 05:37:20', '7446f970-aadc-11ea-9ef5-53c8b35a1f2d'),
('74484f60-aadc-11ea-a742-c1643d484072', '1', '2020-06-10 05:37:20', '7446f970-aadc-11ea-9ef5-53c8b35a1f2d'),
('7fd86e40-aadc-11ea-ae8a-59368751af07', '1', '2020-06-10 05:37:40', '7fd869d0-aadc-11ea-8313-6359f56e7b3d'),
('7fd9bdc0-aadc-11ea-8b0a-b5608e9c2781', '1', '2020-06-10 05:37:40', '7fd869d0-aadc-11ea-8313-6359f56e7b3d'),
('8649e4a0-aadf-11ea-9151-5f4012a31477', '1', '2020-06-10 05:59:19', '8649e0e0-aadf-11ea-8af6-3f6542b25aa5'),
('864b8540-aadf-11ea-a3e2-b323cc0ad125', '1', '2020-06-10 05:59:19', '8649e0e0-aadf-11ea-8af6-3f6542b25aa5'),
('8ccf3d80-ab80-11ea-93bc-5ddf491a530a', '1', '2020-06-11 01:11:59', '8cc9a8a0-ab80-11ea-b713-0d24b8954fd4'),
('8cd07c70-ab80-11ea-bec7-298d669304df', '1', '2020-06-11 01:11:59', '8cc9a8a0-ab80-11ea-b713-0d24b8954fd4'),
('915d1930-aadf-11ea-a4b1-593406cd9472', '1', '2020-06-10 05:59:38', '915d1400-aadf-11ea-8936-49b76636e3b1'),
('915e5390-aadf-11ea-abfe-e599295e21ee', '1', '2020-06-10 05:59:38', '915d1400-aadf-11ea-8936-49b76636e3b1'),
('a5ad33a0-aadc-11ea-b72e-2559a4a575a4', '1', '2020-06-10 05:38:43', 'a5ad3080-aadc-11ea-b0cb-df37ea9b67cd'),
('a5ae97d0-aadc-11ea-bd78-e35d8b7edee6', '1', '2020-06-10 05:38:43', 'a5ad3080-aadc-11ea-b0cb-df37ea9b67cd'),
('c93422e0-aae3-11ea-a622-3dfd8cab638a', '1', '2020-06-10 06:29:49', 'c9341f30-aae3-11ea-81fb-17060034bafc'),
('c9357060-aae3-11ea-9d37-bdf95e47f2b1', '1', '2020-06-10 06:29:49', 'c9341f30-aae3-11ea-81fb-17060034bafc'),
('ca940410-aadc-11ea-b39e-cd9805745e63', '1', '2020-06-10 05:39:45', 'ca940010-aadc-11ea-9e44-d92eff18037f'),
('ca9573b0-aadc-11ea-858c-3d10112bbcb9', '1', '2020-06-10 05:39:45', 'ca940010-aadc-11ea-9e44-d92eff18037f'),
('db2329d0-aadd-11ea-b242-cd40de069d14', '1', '2020-06-10 05:47:22', 'db2326a0-aadd-11ea-bf87-4dc8a16082ed'),
('db241db0-aadd-11ea-9e6c-3726fd4eb9e8', '1', '2020-06-10 05:47:22', 'db2326a0-aadd-11ea-bf87-4dc8a16082ed'),
('e44e5d30-aadd-11ea-885b-61ad5a302c27', '1', '2020-06-10 05:47:38', 'e44e59c0-aadd-11ea-adfb-d1e8bdc7beef'),
('e44f8730-aadd-11ea-a5d8-0bc2018f6b9b', '1', '2020-06-10 05:47:38', 'e44e59c0-aadd-11ea-adfb-d1e8bdc7beef'),
('e4761db0-aadc-11ea-875c-7503c3c47fc4', '1', '2020-06-10 05:40:29', 'e4761a80-aadc-11ea-8aef-e72539bbadd0'),
('e4774d80-aadc-11ea-8556-9f847df868c7', '1', '2020-06-10 05:40:29', 'e4761a80-aadc-11ea-8aef-e72539bbadd0'),
('f10e5910-aadc-11ea-8f3a-bd43eb03c550', '1', '2020-06-10 05:40:50', 'f10e5520-aadc-11ea-ab30-5f1e1bc141f4'),
('f10f8560-aadc-11ea-b2a8-49ed09f831ca', '1', '2020-06-10 05:40:50', 'f10e5520-aadc-11ea-ab30-5f1e1bc141f4'),
('f496fd30-aadb-11ea-af94-c1bb9d475030', '1', '2020-06-10 05:33:46', 'f496f840-aadb-11ea-9d84-038ac1ca6bab'),
('f49855e0-aadb-11ea-a7c8-adccf4b012b8', '1', '2020-06-10 05:33:46', 'f496f840-aadb-11ea-9d84-038ac1ca6bab'),
('f5ae7c20-aadd-11ea-90b7-b3e20dd50190', '1', '2020-06-10 05:48:07', 'f5ae7910-aadd-11ea-b40b-258dbbac01f8'),
('f5afa010-aadd-11ea-be0d-559f4a00af16', '1', '2020-06-10 05:48:07', 'f5ae7910-aadd-11ea-b40b-258dbbac01f8'),
('fe906ff0-aadc-11ea-b148-2de2a0137389', '1', '2020-06-10 05:41:12', 'fe906b00-aadc-11ea-8b5d-6101701dda25'),
('fe91a360-aadc-11ea-8852-bba8e3f0d302', '1', '2020-06-10 05:41:12', 'fe906b00-aadc-11ea-8b5d-6101701dda25');

-- --------------------------------------------------------

--
-- Table structure for table `profiles`
--

CREATE TABLE `profiles` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `company` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `question`
--

CREATE TABLE `question` (
  `id` varchar(150) NOT NULL,
  `quiz_id` varchar(20) NOT NULL,
  `question` varchar(255) NOT NULL,
  `option` varchar(150) NOT NULL,
  `answer` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `question_image`
--

CREATE TABLE `question_image` (
  `image` varchar(150) NOT NULL,
  `id` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `id` varchar(20) NOT NULL,
  `soal` varchar(255) NOT NULL,
  `expiration` varchar(10) NOT NULL,
  `total_question` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_session`
--

CREATE TABLE `quiz_session` (
  `id_session` varchar(150) NOT NULL,
  `starting_time` datetime NOT NULL,
  `wrong_count` int(11) NOT NULL,
  `correct_count` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `quiz_id` varchar(20) NOT NULL,
  `certificate` varchar(150) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sertifikat`
--

CREATE TABLE `sertifikat` (
  `id` varchar(20) NOT NULL,
  `users_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `topik`
--

CREATE TABLE `topik` (
  `id` varchar(20) NOT NULL,
  `training_id` int(11) NOT NULL,
  `nama_topik` varchar(150) NOT NULL,
  `deskripsi_topik` varchar(255) NOT NULL,
  `thumbnail` varchar(20) NOT NULL,
  `harga` int(11) NOT NULL,
  `zoom` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `topik`
--

INSERT INTO `topik` (`id`, `training_id`, `nama_topik`, `deskripsi_topik`, `thumbnail`, `harga`, `zoom`) VALUES
('1', 1, 'Topik 1.1', 'Ini adalah topik 1.1', 'thumbail.pg', 1000000, 0);

-- --------------------------------------------------------

--
-- Table structure for table `training`
--

CREATE TABLE `training` (
  `id` int(11) NOT NULL,
  `nama_training` varchar(100) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `thumbnail` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `training`
--

INSERT INTO `training` (`id`, `nama_training`, `deskripsi`, `thumbnail`) VALUES
(1, 'Training Satu', 'Ini adalah Training Satu', 'thumbail.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` longtext DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(27, 'Jesi Namora', 'jesinamora083@gmail.com', '$2y$10$mpF/EIYwwb2uU0Cn3QsxmuzcDp3aFnpvYl8KxtRIKvVS.zgpOUEt2', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjI3LCJpc3MiOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvYXBpL3YxL3VzZXIvc2lnbmluIiwiaWF0IjoxNTkxODM2NzU0LCJleHAiOjE1OTE4NDAzNTQsIm5iZiI6MTU5MTgzNjc1NCwianRpIjoidURWYVlPTlQ4ZThuMkVLZSJ9.aGWXQUqrZPGxpYH-06Uec73SCaNY6D93KoZJc0hpiSI', '2020-06-10 04:40:50', '2020-06-10 04:40:50'),
(71, '4OLSXz3MAvM26Qjf', 'email1@gmail.com', '$2y$10$Qf6bAYMrGwV7Pg/NrEJI6.Tgn4nDwpiYGFUiEN6Milz910vMN1E2e', NULL, '2020-06-11 01:49:40', '2020-06-11 01:49:40'),
(72, 'UH4sxsQKFG2SWDxZ', 'email2@gmail.com', '$2y$10$QBQN6DT7hm6dP2rz4LCRSOn/YZbB48zkqptZj1QISe9oS4D2g4JYa', NULL, '2020-06-11 01:49:40', '2020-06-11 01:49:40'),
(73, 'xVu2aZ5uwpnNxKRr', 'email3@gmail.com', '$2y$10$LyK7LWt5/ET3c3GYGxvsF.b3mlc5s3hNZ6X72ZSt4JtczQFcekAau', NULL, '2020-06-11 01:49:41', '2020-06-11 01:49:41');

-- --------------------------------------------------------

--
-- Table structure for table `user_modul`
--

CREATE TABLE `user_modul` (
  `id` int(11) NOT NULL,
  `id_modul` int(11) NOT NULL,
  `status_penyelesaian` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_topik`
--

CREATE TABLE `user_topik` (
  `id` int(11) NOT NULL,
  `jumlah_percobaan` varchar(45) DEFAULT NULL,
  `users_id` int(11) NOT NULL,
  `topik_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `video`
--

CREATE TABLE `video` (
  `id_video` int(11) NOT NULL,
  `id_modul` int(11) NOT NULL,
  `nama_video` varchar(30) NOT NULL,
  `url` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `downloadable`
--
ALTER TABLE `downloadable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_downloadable_modul1_idx` (`id_modul`);

--
-- Indexes for table `exclusive`
--
ALTER TABLE `exclusive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_exclusive_modul1_idx` (`id_modul`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image`);

--
-- Indexes for table `image_paket`
--
ALTER TABLE `image_paket`
  ADD PRIMARY KEY (`id`,`image`),
  ADD KEY `image_image_paket_fk` (`image`);

--
-- Indexes for table `image_produk`
--
ALTER TABLE `image_produk`
  ADD PRIMARY KEY (`id`,`image`),
  ADD KEY `image_image_produk_fk` (`image`);

--
-- Indexes for table `image_triaining`
--
ALTER TABLE `image_triaining`
  ADD PRIMARY KEY (`image`,`id`),
  ADD KEY `training_image_triaining_fk` (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `modul`
--
ALTER TABLE `modul`
  ADD PRIMARY KEY (`id_modul`),
  ADD KEY `produk_modul_fk` (`id_produk`);

--
-- Indexes for table `paket`
--
ALTER TABLE `paket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `training_paket_fk` (`training_id`);

--
-- Indexes for table `paket_max`
--
ALTER TABLE `paket_max`
  ADD KEY `fk_paket_max_paket1_idx` (`paket_id`);

--
-- Indexes for table `paket_topik`
--
ALTER TABLE `paket_topik`
  ADD PRIMARY KEY (`id`,`paket_id`),
  ADD KEY `paket_paket_produk_fk` (`paket_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`) USING BTREE;

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `fk_pembelia_users1_idx` (`users_id`);

--
-- Indexes for table `pembelian_paket`
--
ALTER TABLE `pembelian_paket`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `paket_pembelian_paket_fk` (`id`),
  ADD KEY `fk_pembelian_paket_pembelian1_idx` (`pembelian_id_pembelian`);

--
-- Indexes for table `pembelian_produk`
--
ALTER TABLE `pembelian_produk`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `produk_pembelian_produk_fk` (`id_produk`),
  ADD KEY `fk_pembelian_produk_pembelian1_idx` (`pembelian_id_pembelian`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profiles_user_id_foreign` (`user_id`) USING BTREE;

--
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_question_fk` (`quiz_id`);

--
-- Indexes for table `question_image`
--
ALTER TABLE `question_image`
  ADD PRIMARY KEY (`image`,`id`),
  ADD KEY `question_question_image_fk` (`id`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_session`
--
ALTER TABLE `quiz_session`
  ADD PRIMARY KEY (`id_session`),
  ADD KEY `users_quiz_session_fk` (`id`),
  ADD KEY `quiz_quiz_session_fk` (`quiz_id`);

--
-- Indexes for table `sertifikat`
--
ALTER TABLE `sertifikat`
  ADD PRIMARY KEY (`id`,`users_id`),
  ADD KEY `users_sertifikat_fk` (`users_id`);

--
-- Indexes for table `topik`
--
ALTER TABLE `topik`
  ADD PRIMARY KEY (`id`),
  ADD KEY `training_produk_fk` (`training_id`);

--
-- Indexes for table `training`
--
ALTER TABLE `training`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`) USING BTREE;

--
-- Indexes for table `user_modul`
--
ALTER TABLE `user_modul`
  ADD PRIMARY KEY (`id`,`id_modul`),
  ADD KEY `modul_user_modul_fk` (`id_modul`);

--
-- Indexes for table `user_topik`
--
ALTER TABLE `user_topik`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_topik_users1_idx` (`users_id`),
  ADD KEY `fk_user_topik_topik1_idx` (`topik_id`);

--
-- Indexes for table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`id_video`),
  ADD KEY `modul_video_fk` (`id_modul`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `modul`
--
ALTER TABLE `modul`
  MODIFY `id_modul` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `training`
--
ALTER TABLE `training`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `user_modul`
--
ALTER TABLE `user_modul`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_topik`
--
ALTER TABLE `user_topik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `video`
--
ALTER TABLE `video`
  MODIFY `id_video` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `downloadable`
--
ALTER TABLE `downloadable`
  ADD CONSTRAINT `fk_downloadable_modul1` FOREIGN KEY (`id_modul`) REFERENCES `modul` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `exclusive`
--
ALTER TABLE `exclusive`
  ADD CONSTRAINT `fk_exclusive_modul1` FOREIGN KEY (`id_modul`) REFERENCES `modul` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `image_paket`
--
ALTER TABLE `image_paket`
  ADD CONSTRAINT `image_image_paket_fk` FOREIGN KEY (`image`) REFERENCES `image` (`image`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `paket_image_paket_fk` FOREIGN KEY (`id`) REFERENCES `paket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `image_produk`
--
ALTER TABLE `image_produk`
  ADD CONSTRAINT `image_image_produk_fk` FOREIGN KEY (`image`) REFERENCES `image` (`image`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `training_image_produk_fk` FOREIGN KEY (`id`) REFERENCES `training` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `image_triaining`
--
ALTER TABLE `image_triaining`
  ADD CONSTRAINT `image_image_triaining_fk` FOREIGN KEY (`image`) REFERENCES `image` (`image`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `training_image_triaining_fk` FOREIGN KEY (`id`) REFERENCES `training` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `modul`
--
ALTER TABLE `modul`
  ADD CONSTRAINT `produk_modul_fk` FOREIGN KEY (`id_produk`) REFERENCES `topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `paket`
--
ALTER TABLE `paket`
  ADD CONSTRAINT `training_paket_fk` FOREIGN KEY (`training_id`) REFERENCES `training` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `paket_max`
--
ALTER TABLE `paket_max`
  ADD CONSTRAINT `fk_paket_max_paket1` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `paket_topik`
--
ALTER TABLE `paket_topik`
  ADD CONSTRAINT `paket_paket_produk_fk` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `produk_paket_produk_fk` FOREIGN KEY (`id`) REFERENCES `topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `fk_pembelia_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pembelian_paket`
--
ALTER TABLE `pembelian_paket`
  ADD CONSTRAINT `fk_pembelian_paket_pembelian1` FOREIGN KEY (`pembelian_id_pembelian`) REFERENCES `pembelian` (`id_pembelian`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `paket_pembelian_paket_fk` FOREIGN KEY (`id`) REFERENCES `paket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pembelian_produk`
--
ALTER TABLE `pembelian_produk`
  ADD CONSTRAINT `fk_pembelian_produk_pembelian1` FOREIGN KEY (`pembelian_id_pembelian`) REFERENCES `pembelian` (`id_pembelian`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `produk_pembelian_produk_fk` FOREIGN KEY (`id_produk`) REFERENCES `topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `quiz_question_fk` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `question_image`
--
ALTER TABLE `question_image`
  ADD CONSTRAINT `image_question_image_fk` FOREIGN KEY (`image`) REFERENCES `image` (`image`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `question_question_image_fk` FOREIGN KEY (`id`) REFERENCES `question` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `produk_quiz_fk` FOREIGN KEY (`id`) REFERENCES `topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `quiz_session`
--
ALTER TABLE `quiz_session`
  ADD CONSTRAINT `quiz_quiz_session_fk` FOREIGN KEY (`quiz_id`) REFERENCES `quiz` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_quiz_session_fk` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sertifikat`
--
ALTER TABLE `sertifikat`
  ADD CONSTRAINT `produk_sertifikat_fk` FOREIGN KEY (`id`) REFERENCES `topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_sertifikat_fk` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `topik`
--
ALTER TABLE `topik`
  ADD CONSTRAINT `training_produk_fk` FOREIGN KEY (`training_id`) REFERENCES `training` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_modul`
--
ALTER TABLE `user_modul`
  ADD CONSTRAINT `modul_user_modul_fk` FOREIGN KEY (`id_modul`) REFERENCES `modul` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_user_modul_fk` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_topik`
--
ALTER TABLE `user_topik`
  ADD CONSTRAINT `fk_user_topik_topik1` FOREIGN KEY (`topik_id`) REFERENCES `topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_topik_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `modul_video_fk` FOREIGN KEY (`id_modul`) REFERENCES `modul` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
