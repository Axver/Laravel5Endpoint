-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 31, 2020 at 03:02 AM
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
-- Database: `laravel_new`
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
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image` varchar(150) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`image`, `name`) VALUES
('442dea40-a2da-11ea-95f3-cd8db5c6d7f9', 'c405d91b75926adbde55fae8cfc4cbc3.png');

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

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_paket`
--

CREATE TABLE `pembelian_paket` (
  `id_pembelian` varchar(100) NOT NULL,
  `id` varchar(10) NOT NULL,
  `id_user` int(11) NOT NULL,
  `list_email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `id` int(11) NOT NULL,
  `id_modul` int(11) NOT NULL,
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
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `id_modul` int(11) NOT NULL,
  `soal` varchar(255) NOT NULL,
  `expiration` varchar(10) NOT NULL,
  `total_question` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_session`
--

CREATE TABLE `quiz_session` (
  `id_session` int(11) NOT NULL,
  `starting_time` datetime NOT NULL,
  `id_modul` int(11) NOT NULL,
  `wrong_count` int(11) NOT NULL,
  `correct_count` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `id` int(11) NOT NULL
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
-- Table structure for table `training`
--

CREATE TABLE `training` (
  `id` int(11) NOT NULL,
  `nama_training` varchar(30) NOT NULL,
  `deskripsi` varchar(255) NOT NULL,
  `foto` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Indexes for table `question`
--
ALTER TABLE `question`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quiz_question_fk` (`id_modul`);

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
  ADD PRIMARY KEY (`id_modul`);

--
-- Indexes for table `quiz_session`
--
ALTER TABLE `quiz_session`
  ADD PRIMARY KEY (`id_session`),
  ADD KEY `users_quiz_session_fk` (`id`),
  ADD KEY `quiz_quiz_session_fk` (`id_modul`);

--
-- Indexes for table `sertifikat`
--
ALTER TABLE `sertifikat`
  ADD PRIMARY KEY (`id`,`users_id`),
  ADD KEY `users_sertifikat_fk` (`users_id`);

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
  MODIFY `id_modul` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `profiles`
--
ALTER TABLE `profiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `training`
--
ALTER TABLE `training`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_modul`
--
ALTER TABLE `user_modul`
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

--
-- Constraints for table `question`
--
ALTER TABLE `question`
  ADD CONSTRAINT `quiz_question_fk` FOREIGN KEY (`id_modul`) REFERENCES `quiz` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `modul_quiz_fk` FOREIGN KEY (`id_modul`) REFERENCES `modul` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `quiz_session`
--
ALTER TABLE `quiz_session`
  ADD CONSTRAINT `quiz_quiz_session_fk` FOREIGN KEY (`id_modul`) REFERENCES `quiz` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_quiz_session_fk` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sertifikat`
--
ALTER TABLE `sertifikat`
  ADD CONSTRAINT `produk_sertifikat_fk` FOREIGN KEY (`id`) REFERENCES `produk` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_sertifikat_fk` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_modul`
--
ALTER TABLE `user_modul`
  ADD CONSTRAINT `modul_user_modul_fk` FOREIGN KEY (`id_modul`) REFERENCES `modul` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_user_modul_fk` FOREIGN KEY (`id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `modul_video_fk` FOREIGN KEY (`id_modul`) REFERENCES `modul` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
