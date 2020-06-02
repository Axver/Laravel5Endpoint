-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 02, 2020 at 07:00 AM
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
-- Table structure for table `downloadable`
--

CREATE TABLE `downloadable` (
  `id` varchar(150) NOT NULL,
  `file_modul` varchar(150) NOT NULL,
  `id_modul` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `downloadable`
--

INSERT INTO `downloadable` (`id`, `file_modul`, `id_modul`) VALUES
('ab48e870-a48c-11ea-9bf1-ab18116fedcc', '5249bd61b96acefb5f0313aa6cc4a6bc.jpeg', 1),
('ceb79cf0-a48c-11ea-860e-2515696443f2', 'dfae5feb751e30c034716ac64e54cdf9.jpeg', 1);

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
('70e157c0-a48a-11ea-83c1-a9bf37610dd1', '657f8aebf4c55a35f4a5d9c7e4557c15.pdf', 1),
('7e9d6b70-a48c-11ea-a169-c3f3067a943a', '087b7438961754f763ec1657b2b7a8dd.jpeg', 1);

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
('c833cfa0-a477-11ea-918c-13236468e7ec', 'f91aa3dced9aa8a4f73974f73d62c945.png'),
('c9b27e00-a477-11ea-8e68-77c4844ebb91', '06210f6afe82f64e49938e9720b2d62d.png'),
('caa21740-a477-11ea-9561-1d820401c61a', '6d97e8181c730f1d4ddfacb9d9cf7924.png'),
('cb7f2020-a477-11ea-8111-1797f0fb8f84', 'b9d30faf1716b5ec6e92f34996866262.png'),
('cc71e620-a477-11ea-86f5-2b8a14698aea', '45a29e6a46a4bce375fce4504b97ef42.png');

-- --------------------------------------------------------

--
-- Table structure for table `image_paket`
--

CREATE TABLE `image_paket` (
  `id` varchar(10) NOT NULL,
  `image` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `image_paket`
--

INSERT INTO `image_paket` (`id`, `image`) VALUES
('1', 'c9b27e00-a477-11ea-8e68-77c4844ebb91');

-- --------------------------------------------------------

--
-- Table structure for table `image_produk`
--

CREATE TABLE `image_produk` (
  `id` int(11) NOT NULL,
  `image` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `image_produk`
--

INSERT INTO `image_produk` (`id`, `image`) VALUES
(1, 'c833cfa0-a477-11ea-918c-13236468e7ec');

-- --------------------------------------------------------

--
-- Table structure for table `image_triaining`
--

CREATE TABLE `image_triaining` (
  `image` varchar(150) NOT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `image_triaining`
--

INSERT INTO `image_triaining` (`image`, `id`) VALUES
('c9b27e00-a477-11ea-8e68-77c4844ebb91', 1);

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

--
-- Dumping data for table `paket`
--

INSERT INTO `paket` (`id`, `training_id`, `nama_paket`, `deskripsi`, `harga`, `zoom`, `max_user`) VALUES
('1', 1, 'Paket A', 'Ini adaalah Paket A Yang Berisi Banyak Topik', 5000000, 0, 3),
('2', 1, 'Ini Adalah Paket B P', 'Ini adalah Paket B Pada Training 1', 5000000, 0, 4);

-- --------------------------------------------------------

--
-- Table structure for table `paket_topik`
--

CREATE TABLE `paket_topik` (
  `id` varchar(20) NOT NULL,
  `paket_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `paket_topik`
--

INSERT INTO `paket_topik` (`id`, `paket_id`) VALUES
('1', '1'),
('1', '2');

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
  `list_email` varchar(255) NOT NULL,
  `bukti_pembayaran` varchar(255) DEFAULT NULL,
  `status_pembayaran` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembelian_paket`
--

INSERT INTO `pembelian_paket` (`id_pembelian`, `id`, `id_user`, `list_email`, `bukti_pembayaran`, `status_pembayaran`) VALUES
('03a15b00-a47b-11ea-b862-f1d67100664d', '1', 1, 'email1@gmail.com,email2@gmail.com', '', ''),
('195ac6a0-a47b-11ea-95d4-35a4234c3a65', '1', 1, 'email1@gmail.com,email2@gmail.com', '', ''),
('1bef0300-a47b-11ea-9d81-d1f0ae93bac9', '1', 1, 'email1@gmail.com,email2@gmail.com,', '', ''),
('53b23f00-a47b-11ea-85d1-198428cbfca4', '1', 1, 'email1@gmail.com,email2@gmail.com,', '', ''),
('6e8d3bb0-a47b-11ea-a64e-319f6c07077e', '1', 1, 'email1@gmail.com,email2@gmail.com,', '', ''),
('7e894130-a47b-11ea-a8d8-9d233748ae3f', '1', 1, 'email1@gmail.com,email2@gmail.com,', '', ''),
('8d48e580-a47b-11ea-9ec2-75d2d6168172', '1', 1, 'email1@gmail.com,email2@gmail.com,', '', ''),
('9452eca0-a47b-11ea-89e9-afe63dc9d1b3', '1', 1, 'email1@gmail.com,email2@gmail.com,', 'ce0c2fd282a236ead593fb2241779cc9.png', '');

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_produk`
--

CREATE TABLE `pembelian_produk` (
  `id_pembelian` varchar(100) NOT NULL,
  `id_produk` varchar(20) NOT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `status_pembayaran` varchar(10) DEFAULT NULL,
  `bukti_pembayaran` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pembelian_produk`
--

INSERT INTO `pembelian_produk` (`id_pembelian`, `id_produk`, `id_user`, `created_at`, `status_pembayaran`, `bukti_pembayaran`) VALUES
('997ca790-a47a-11ea-b561-6f69748f232f', '1', 1, '2020-06-02 02:41:45', 'No', NULL),
('d7b45a80-a47a-11ea-a8de-37b99975b864', '1', 1, '2020-06-02 02:43:30', 'No', NULL),
('f025f140-a47a-11ea-b582-ad4023493aa2', '1', 1, '2020-06-02 02:44:11', 'No', '51efb571f2d154f2e039dade5c593f8d.png');

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
  `id_session` int(11) NOT NULL,
  `starting_time` datetime NOT NULL,
  `wrong_count` int(11) NOT NULL,
  `correct_count` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `quiz_id` varchar(20) NOT NULL
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
('1', 1, 'Topik A Traininng Satu', 'Ini adalah Topik A yang berada pada Training 1', 'thumbnil1.png', 4000000, 0),
('2', 1, 'Ini Topik 2 Dalam Traaining 1', 'Ini adalah deskripsi topik 2 dalam training 1', 'thumbnil2png', 2000000, 1);

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
(1, 'Training Satu', 'Ini adalah training satu', 'tr1.png'),
(2, 'Training 2', 'Ini adalah Training 2', 'tr2png');

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
(1, 'Jesi Namora', 'jesinamora08@gmail.com', '$2y$10$HCMLYUov30Ba94P7rt987OxqpT7E7otQVsSSrO1EmiPxw49f01w5q', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hcGkvdjEvdXNlci9zaWduaW4iLCJpYXQiOjE1OTEwNjM5NzUsImV4cCI6MTU5MTA2NzU3NSwibmJmIjoxNTkxMDYzOTc1LCJqdGkiOiJxamdvQmk4MjU1bW5KMmdEIn0.AZLc7egmdq6ChTj_GNHf254Y1yUoWBBt4TafAhl9sTU', '2020-06-02 02:11:33', '2020-06-02 02:11:33'),
(2, 'HugzSBmPjXb5dNdB', 'email1@gmail.com', '$2y$10$W4KnmA5OfP5i9hUr6UVA1.I5bKmVIwtR8f4JhpCIco264Uj3B3ZIy', NULL, '2020-06-02 02:44:43', '2020-06-02 02:44:43'),
(3, 'peeQs009AA7f0Oat', 'email2@gmail.com', '$2y$10$gEq2y4sfGYPaqHJhcv8keOoQk2XpFoemZiI94OvD/I0njRNMkr116', NULL, '2020-06-02 02:44:44', '2020-06-02 02:44:44');

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
-- Indexes for table `downloadable`
--
ALTER TABLE `downloadable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_modul` (`id_modul`);

--
-- Indexes for table `exclusive`
--
ALTER TABLE `exclusive`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_modul` (`id_modul`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
-- Constraints for table `paket_topik`
--
ALTER TABLE `paket_topik`
  ADD CONSTRAINT `paket_paket_produk_fk` FOREIGN KEY (`paket_id`) REFERENCES `paket` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `produk_paket_produk_fk` FOREIGN KEY (`id`) REFERENCES `topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
  ADD CONSTRAINT `produk_pembelian_produk_fk` FOREIGN KEY (`id_produk`) REFERENCES `topik` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `users_pembelian_produk_fk` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Constraints for table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `modul_video_fk` FOREIGN KEY (`id_modul`) REFERENCES `modul` (`id_modul`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
