-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2020 at 03:19 AM
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
-- Database: `laravel`
--

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
(1, '1', 'Modul 1 Perkenalan', 'modul1.pdf');

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
('1', 1, 'Paket A', 'Paket A Berisi Berbagai Mcam Produk', 5000000, 0, 5);

-- --------------------------------------------------------

--
-- Table structure for table `paket_produk`
--

CREATE TABLE `paket_produk` (
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

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('emailbaruyeah@gmail.com', '950404', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_paket`
--

CREATE TABLE `pembelian_paket` (
  `id_pembelian` varchar(100) NOT NULL,
  `id` varchar(10) NOT NULL,
  `id_user` int(11) NOT NULL,
  `list_email` varchar(255) DEFAULT NULL,
  `status_pembayaran` varchar(10) DEFAULT NULL,
  `bukti_pembayaran` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembelian_paket`
--

INSERT INTO `pembelian_paket` (`id_pembelian`, `id`, `id_user`, `list_email`, `status_pembayaran`, `bukti_pembayaran`) VALUES
('0250eb10-98bb-11ea-9038-51d11deab6a8', '1', 1, '2@gmail.com,v@gmail.com,emailbaruyeah@gmail.com', NULL, NULL),
('0b5c7d30-98b2-11ea-829a-2f302159d909', '1', 1, 'test1@gmail.com,test2@gmail.com,test3@gmail.com', NULL, NULL),
('0b81f160-98d2-11ea-a8d6-c5abce317691', '1', 1, 'email1@gmail.com,email2@gmail.com,email3@gmail.com,email4@gmail.com,emil5@gmail.com', 'Yes', NULL),
('0c66e990-98b3-11ea-9cb7-b72d87f0667a', '1', 1, 'test1@gmail.com,test2@gmail.com', NULL, NULL),
('0eb149a0-98b7-11ea-9a29-653464d000b8', '1', 1, '2@gmail.com', NULL, NULL),
('0f1a4280-98bb-11ea-a93d-610a21e9c4e3', '1', 1, '2@gmail.com,v@gmail.com,emailbaruyeah@gmail.com', NULL, NULL),
('11d272b0-98b1-11ea-a6ba-876234ae9908', '1', 1, 'test1@gmail.com,test2@gmail.com,test3@gmail.com', NULL, NULL),
('169042f0-98bb-11ea-9211-23457b08a69d', '1', 1, '2@gmail.com,v@gmail.com,emailbaruyeah@gmail.com', NULL, NULL),
('1791f640-98b3-11ea-981f-2de0f238b09f', '1', 1, 'test1@gmail.com,test2@gmail.com', NULL, NULL),
('1798e950-98c5-11ea-859a-49d4730ca1c3', '1', 1, '2@gmail.com,v@gmail.com,emailbaruyeah@gmail.com', NULL, NULL),
('1e835940-98b2-11ea-b12c-bb9881ba98bd', '1', 1, 'test1@gmail.com,test2@gmail.com,test3@gmail.com,test1@gmail.com,test2@gmail.com,test3@gmail.com', NULL, NULL),
('27ca1830-98bb-11ea-95b8-8926e7e05354', '1', 1, '2@gmail.com,v@gmail.com,emailbaruyeah@gmail.com', NULL, NULL),
('33b1b900-98d3-11ea-a726-cf4a79e367a1', '1', 1, 'email1@gmail.com,email2@gmail.com,email3@gmail.com,email4@gmail.com,emil5@gmail.com', 'Yes', NULL),
('39ba0150-98b7-11ea-abae-b716a98e7186', '1', 1, '2@gmail.com', NULL, NULL),
('4158ad70-98b3-11ea-a054-298e1f384159', '1', 1, 'test1@gmail.com,test2@gmail.com', NULL, NULL),
('41705640-98b7-11ea-bc2a-6fb65fd8db41', '1', 1, '2@gmail.com', NULL, NULL),
('41f89fc0-98c5-11ea-bdec-297433be7bed', '1', 1, 'email1@gmail.com,email2@gmail.com,email3@gmail.com,email4@gmail.com,emil5@gmail.com', NULL, NULL),
('4a11a4f0-98b7-11ea-a278-6752018e8ae1', '1', 1, '2@gmail.com', NULL, NULL),
('4dcb5c10-98cd-11ea-9e6e-8f34da5afb2d', '1', 1, 'email1@gmail.com,email2@gmail.com,email3@gmail.com,email4@gmail.com,emil5@gmail.com', NULL, NULL),
('4ed7a740-98ba-11ea-8011-05899fc64d0b', '1', 1, '2@gmail.com,v@gmail.com,k@gmail.com', NULL, NULL),
('5465d1e0-98b4-11ea-9106-9fcf70c74195', '1', 1, 'test1@gmail.com', NULL, NULL),
('5a21eb40-98b6-11ea-831e-179485c61944', '1', 1, '1@gmail.com', NULL, NULL),
('67bf1910-98b4-11ea-a903-0f919033f45c', '1', 1, 'test1@gmail.com', NULL, NULL),
('6f82e150-98b4-11ea-a9e5-bfed2aa358bd', '1', 1, 'test10@gmail.com', NULL, NULL),
('7bd0e8c0-98cc-11ea-a8d2-e366595609c9', '1', 1, 'email1@gmail.com,email2@gmail.com,email3@gmail.com,email4@gmail.com,emil5@gmail.com', NULL, NULL),
('8670f240-98b9-11ea-b9f7-d3995f39a180', '1', 1, '2@gmail.com,v@gmail.com,n@gmail.com', NULL, NULL),
('89e43070-98b3-11ea-8c67-a392c18a9338', '1', 1, 'test1@gmail.com', NULL, NULL),
('8d58b290-98b6-11ea-be90-e5de2d391b9f', '1', 1, '2@gmail.com', NULL, NULL),
('91a32ad0-98b3-11ea-b22d-bd8d5d8e7106', '1', 1, 'test1@gmail.com', NULL, NULL),
('9b0ad560-98d5-11ea-b64b-2bde75adb28e', '1', 80, NULL, 'Yes', NULL),
('9b0c97a0-98d5-11ea-a77a-45e7f8073883', '1', 81, NULL, 'Yes', NULL),
('9b0cc750-98d5-11ea-a9bf-450e59a2aca1', '1', 82, NULL, 'Yes', NULL),
('9b0cfb80-98d5-11ea-a537-a3b02e258ed1', '1', 83, NULL, 'Yes', NULL),
('9b0d2d40-98d5-11ea-b6a4-85e4f869f25d', '1', 84, NULL, 'Yes', NULL),
('9bc52540-98b9-11ea-9cc8-61001db30a43', '1', 1, '2@gmail.com,v@gmail.com,n@gmail.com', NULL, NULL),
('9f0ce410-98b8-11ea-8aeb-87c688084260', '1', 1, '2@gmail.com,v@gmail.com', NULL, NULL),
('a5b35b10-98d0-11ea-8b08-1b0cf7aee5bb', '1', 1, 'email1@gmail.com,email2@gmail.com,email3@gmail.com,email4@gmail.com,emil5@gmail.com', 'Yes', NULL),
('a7c39900-98b9-11ea-b8f4-4b874a446ed7', '1', 1, '2@gmail.com,v@gmail.com,k@gmail.com', NULL, NULL),
('a9d18980-98b8-11ea-af48-c3dfb4338449', '1', 1, '2@gmail.com,v@gmail.com', NULL, NULL),
('ab1ebba0-98ba-11ea-8468-e1fec22aa38f', '1', 1, '2@gmail.com,v@gmail.com', NULL, NULL),
('ad7a3c30-98c4-11ea-83b9-cb4a2658e326', '1', 1, '2@gmail.com,v@gmail.com,emailbaruyeah@gmail.com', NULL, NULL),
('b1cf4d40-98ba-11ea-ba72-23ec8e880df2', '1', 1, '2@gmail.com,v@gmail.com,emailbaruyeah@gmail.com', NULL, NULL),
('b1dfc450-98b8-11ea-830e-a701a60ec1db', '1', 1, '2@gmail.com,v@gmail.com,n@gmail.com', NULL, NULL),
('c0479c00-98b9-11ea-b6a9-c90b57e4552a', '1', 1, '2@gmail.com,v@gmail.com,k@gmail.com', NULL, NULL),
('cae52b80-98b9-11ea-8d23-97314b68d8dd', '1', 1, '2@gmail.com,v@gmail.com,k@gmail.com', NULL, NULL),
('caf9f640-98b3-11ea-b774-315ba04928a8', '1', 1, 'test1@gmail.com', NULL, NULL),
('d5a68a40-98b9-11ea-af2e-a381a832df6f', '1', 1, '2@gmail.com,v@gmail.com,k@gmail.com', NULL, NULL),
('d5e9bbe0-98b7-11ea-b359-1b8072e546a7', '1', 1, '2@gmail.com', NULL, NULL),
('db5cec90-98b5-11ea-99ea-e73b4b04363c', '1', 1, 'test10@gmail.com,test11@gmail.com', NULL, NULL),
('de05a9d0-98b2-11ea-a35d-63441ea89265', '1', 1, 'test1@gmail.com,test2@gmail.com', NULL, NULL),
('de9688c0-98bb-11ea-8a65-cbba0927f962', '1', 1, '2@gmail.com,v@gmail.com,emailbaruyeah@gmail.com', NULL, NULL),
('e1b9c160-98cc-11ea-8244-a37bedbf6fc9', '1', 1, 'email1@gmail.com,email2@gmail.com,email3@gmail.com,email4@gmail.com,emil5@gmail.com', NULL, NULL),
('e5a55b90-98b7-11ea-a047-3ddbaa0dc71a', '1', 1, '2@gmail.com', NULL, NULL),
('e9a01860-98b3-11ea-b86d-754423c226d6', '1', 1, 'test1@gmail.com', NULL, NULL),
('ee22bed0-98b9-11ea-afd0-69cd5a38b4f7', '1', 1, '2@gmail.com,v@gmail.com,k@gmail.com', NULL, NULL),
('fe6a6060-98b3-11ea-9082-41867668672d', '1', 1, 'test1@gmail.com', NULL, NULL),
('fe8fa540-98b6-11ea-97eb-91ee0b61a844', '1', 1, '2@gmail.com', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_produk`
--

CREATE TABLE `pembelian_produk` (
  `id_pembelian` varchar(100) NOT NULL,
  `id_produk` varchar(20) NOT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `status_pembayaran` varchar(10) NOT NULL,
  `bukti_pembayaran` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembelian_produk`
--

INSERT INTO `pembelian_produk` (`id_pembelian`, `id_produk`, `id_user`, `created_at`, `status_pembayaran`, `bukti_pembayaran`) VALUES
('6c7408c0-9a54-11ea-9901-23c6c7a1704f', '1', 1, '2020-05-20 04:43:17', 'Yes', NULL),
('a8d53280-98ab-11ea-a5af-55f2dac3939f', '1', 1, '2020-05-18 02:02:42', 'No', NULL),
('c2552a80-98ab-11ea-b79a-2b2c2125f6f8', '1', 1, '2020-05-18 02:03:25', 'No', NULL),
('d3d08fe0-98d7-11ea-8dd4-b7f33a262200', '1', 1, '2020-05-18 07:18:52', 'Yes', NULL),
('ddf39aa0-98ae-11ea-9c04-97cb2f6da6b7', '1', 1, '2020-05-18 02:25:40', 'No', NULL),
('e4f87070-98ab-11ea-ba45-2dcbc53ab390', '1', 1, '2020-05-18 02:04:23', 'No', NULL),
('ed707cc0-98d6-11ea-baca-bfe7aed41e2b', '1', 1, '2020-05-18 07:12:26', 'Yes', NULL),
('f6665b30-98ab-11ea-9c79-d95bccc71acc', '1', 1, '2020-05-18 02:04:52', 'No', NULL),
('fe748500-98aa-11ea-8ddb-139c1d362a66', '1', 1, '2020-05-18 01:57:56', 'No', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` varchar(20) NOT NULL,
  `training_id` int(11) NOT NULL,
  `nama_produk` varchar(20) NOT NULL,
  `deskripsi_produk` varchar(255) NOT NULL,
  `foto` varchar(20) NOT NULL,
  `harga` int(11) NOT NULL,
  `zoom` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `training_id`, `nama_produk`, `deskripsi_produk`, `foto`, `harga`, `zoom`) VALUES
('1', 1, 'Beljar Pemprograman', 'Belajaar Pemprograman Deskripsi', 'foto3.png', 4000000, 0);

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
-- Table structure for table `training`
--

CREATE TABLE `training` (
  `id` int(11) NOT NULL,
  `nama_training` varchar(30) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `foto` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `training`
--

INSERT INTO `training` (`id`, `nama_training`, `deskripsi`, `foto`) VALUES
(1, 'Training 1', 'Data Training 1', 'foto1.png'),
(2, 'Traning 2', 'Data Training 2', 'foto2.png');

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
(1, 'Jesi Namora', 'jesinamora08@gmail.com', '$2y$10$AkZ9C2V4WmXWI6EfRYPUcuuwWuXzre7pId7Rdd.wpCKFvYdyqf18W', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hcGkvdjEvdXNlci9zaWduaW4iLCJpYXQiOjE1ODk3NjQzNjQsImV4cCI6MTU4OTc2Nzk2NCwibmJmIjoxNTg5NzY0MzY0LCJqdGkiOiJKU3JNam1ab0lCekxNb0YzIn0.0gKE4osjA3BFdnQ86l28DLjYRtZnybcxctQa8K8CR3E', '2020-05-18 00:59:43', '2020-05-18 00:59:43'),
(2, 'nhk7NuTmNEpxb9o3', '1@gmail.com', '$2y$10$kMmF8Y3YVbaRkyKdjOx8S.tNhRIAKDnWDBKNCw35hO/qRam9pNVYC', NULL, '2020-05-18 03:19:15', '2020-05-18 03:19:15'),
(4, 'MTLkHbdhQTywsHoO', '2@gmail.com', '$2y$10$Y2.oU/SuUQIIYVCbti.sgOkjXJUCJbvdZ6qB5qm4R52mis05zvJuq', NULL, '2020-05-18 03:20:41', '2020-05-18 03:20:41'),
(15, 'lqfmJSoFlbUXE7qF', 'v@gmail.com', '$2y$10$8xuxZWmr/c6.xYm5v3817OEvnvxM0EmNI1rnO8yuCbe6heGy2YZmK', NULL, '2020-05-18 03:35:29', '2020-05-18 03:35:29'),
(20, 'vM8wrjnAJteq1ybJ', 'n@gmail.com', '$2y$10$pxdsQUWlXK26P5xcr/ZHt.hdy3snDGxp99DUWZWe.uvvRzm/AwGPa', NULL, '2020-05-18 03:36:01', '2020-05-18 03:36:01'),
(29, '5kqdJvcS0xtRgv2t', 'k@gmail.com', '$2y$10$ppw3I4mbox0tko51bQso6.UuVYDCuXaBIM3FqqEipHyImjcNLR3xS', NULL, '2020-05-18 03:42:54', '2020-05-18 03:42:54'),
(49, 'biv8Gpcv3bDm7Ip6', 'emailbaruyeah@gmail.com', '$2y$10$3W7mmtmoVzh3UlXyi8AmcuKzcT8HKESuf1HnfNsFeBCXkPev6k0Xm', NULL, '2020-05-18 03:50:20', '2020-05-18 03:50:20'),
(80, 'z76hF5aRKhKH7rfX', 'email1@gmail.com', '$2y$10$DLVFNPb/fgjcwvRc1M445ORX/Wus.KBPA3K4uryS1cguzRLYVl6Te', NULL, '2020-05-18 05:05:57', '2020-05-18 05:05:57'),
(81, 'QSUEWQOXdz4An7o9', 'email2@gmail.com', '$2y$10$sV6I4wRBZGTcaJyp3tqGIe9WSyv/zMzZWPc1V4k5/OFJWa2jBwnXe', NULL, '2020-05-18 05:05:57', '2020-05-18 05:05:57'),
(82, 'JsvJ7H52hWXFgEfO', 'email3@gmail.com', '$2y$10$LzZ5Vaybx99HlcFJ1ZZ0uOj8kWdu9OcaMm3Ff1vb8ycjeqLgd3zqK', NULL, '2020-05-18 05:05:57', '2020-05-18 05:05:57'),
(83, 'tz52a0LlDW2LDrsW', 'email4@gmail.com', '$2y$10$UHs5Lh9qUAi./RmC5MQgH.OvSdOXnE6u5BmA7tavlE4PYXPFKQNvi', NULL, '2020-05-18 05:05:57', '2020-05-18 05:05:57'),
(84, 'zJAc84YfPr8T3MOQ', 'emil5@gmail.com', '$2y$10$slVrR1/H0PNaAjmGM3px8uOsYSiCgY97BJtWAl/7nAu5cE8Y.r02W', NULL, '2020-05-18 05:05:57', '2020-05-18 05:05:57');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `paket_produk`
--
ALTER TABLE `paket_produk`
  ADD PRIMARY KEY (`id`,`paket_id`),
  ADD KEY `paket_paket_produk_fk` (`paket_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`) USING BTREE;

--
-- Indexes for table `pembelian_paket`
--
ALTER TABLE `pembelian_paket`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `users_pembelian_paket_fk` (`id_user`),
  ADD KEY `paket_pembelian_paket_fk` (`id`);

--
-- Indexes for table `pembelian_produk`
--
ALTER TABLE `pembelian_produk`
  ADD PRIMARY KEY (`id_pembelian`),
  ADD KEY `users_pembelian_produk_fk` (`id_user`),
  ADD KEY `produk_pembelian_produk_fk` (`id_produk`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `training_produk_fk` (`training_id`);

--
-- Indexes for table `profiles`
--
ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profiles_user_id_foreign` (`user_id`) USING BTREE;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `modul`
--
ALTER TABLE `modul`
  ADD CONSTRAINT `produk_modul_fk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `paket`
--
ALTER TABLE `paket`
  ADD CONSTRAINT `training_paket_fk` FOREIGN KEY (`training_id`) REFERENCES `training` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `paket_produk`
--
ALTER TABLE `paket_produk`
  ADD CONSTRAINT `paket_paket_produk_fk` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `produk_paket_produk_fk` FOREIGN KEY (`id`) REFERENCES `produk` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pembelian_paket`
--
ALTER TABLE `pembelian_paket`
  ADD CONSTRAINT `paket_pembelian_paket_fk` FOREIGN KEY (`id`) REFERENCES `paket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_pembelian_paket_fk` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `pembelian_produk`
--
ALTER TABLE `pembelian_produk`
  ADD CONSTRAINT `produk_pembelian_produk_fk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_pembelian_produk_fk` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `training_produk_fk` FOREIGN KEY (`training_id`) REFERENCES `training` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `profiles`
--
ALTER TABLE `profiles`
  ADD CONSTRAINT `profiles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
