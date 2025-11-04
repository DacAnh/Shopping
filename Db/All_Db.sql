CREATE DATABASE  IF NOT EXISTS `laptopshop` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laptopshop`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: laptopshop
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cart_detail`
--

DROP TABLE IF EXISTS `cart_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` decimal(38,2) DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbql1m2v2po7hcawonqsgqex88` (`cart_id`),
  KEY `FKclb1c0wg3mofxnpgidib1t987` (`product_id`),
  CONSTRAINT `FKbql1m2v2po7hcawonqsgqex88` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  CONSTRAINT `FKclb1c0wg3mofxnpgidib1t987` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_detail`
--

LOCK TABLES `cart_detail` WRITE;
/*!40000 ALTER TABLE `cart_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sum` int NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_64t7ox312pqal3p7fg9o503c2` (`user_id`),
  CONSTRAINT `FKb5o626f86h46m4s7ms6ginnop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `carts_chk_1` CHECK ((`sum` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` decimal(38,2) DEFAULT NULL,
  `quantity` bigint NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrws2q0si6oyd6il8gqe2aennc` (`order_id`),
  KEY `FKc7q42e9tu0hslx6w4wxgomhvn` (`product_id`),
  CONSTRAINT `FKc7q42e9tu0hslx6w4wxgomhvn` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKrws2q0si6oyd6il8gqe2aennc` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total_price` decimal(38,2) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `receiver_address` varchar(255) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `detail_desc` mediumtext NOT NULL,
  `factory` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(38,2) NOT NULL,
  `quantity` bigint NOT NULL,
  `short_desc` varchar(255) NOT NULL,
  `sold` bigint NOT NULL,
  `target` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `products_chk_1` CHECK ((`quantity` >= 1))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'ASUS TUF Gaming F15 FX506HF HN017W là chiếc laptop gaming giá rẻ nhưng vô cùng mạnh mẽ. Không chỉ bộ vi xử lý Intel thế hệ thứ 11, card đồ họa RTX 20 series mà điểm mạnh còn đến từ việc trang bị sẵn 16GB RAM, cho bạn hiệu năng xuất sắc mà không cần nâng cấp máy.','ASUS','1711078092373-asus-01.png','Laptop Asus TUF Gaming',17490000.00,100,' Intel, Core i5, 11400H',0,'GAMING'),(2,'Khám phá sức mạnh tối ưu từ Dell Inspiron 15 N3520, chiếc laptop có cấu hình cực mạnh với bộ vi xử lý Intel Core i5 1235U thế hệ mới và dung lượng RAM lên tới 16GB. Bạn có thể thoải mái xử lý nhiều tác vụ, nâng cao năng suất trong công việc mà không gặp bất kỳ trở ngại nào.','DELL','1711078452562-dell-01.png','Laptop Dell Inspiron 15 ',15490000.00,200,'i5 1235U/16GB/512GB/15.6\"FHD',0,'VAN-PHONG'),(3,' Mới đây, Lenovo đã tung ra thị trường một sản phẩm gaming thế hệ mới với hiệu năng mạnh mẽ, thiết kế tối giản, lịch lãm phù hợp cho những game thủ thích sự đơn giản. Tản nhiệt mát mẻ với hệ thống quạt kép kiểm soát được nhiệt độ máy luôn mát mẻ khi chơi game.','LENOVO','1711079073759-lenovo-01.png','Lenovo IdeaPad Gaming 3',19500000.00,150,' i5-10300H, RAM 8G',0,'GAMING'),(4,'Tận hưởng cảm giác mát lạnh sành điệu với thiết kế kim loại\r\nĐược thiết kế để đáp ứng những nhu cầu điện toán hàng ngày của bạn, dòng máy tính xách tay ASUS K Series sở hữu thiết kế tối giản, gọn nhẹ và cực mỏng với một lớp vỏ họa tiết vân kim loại phong cách. Hiệu năng của máy rất mạnh mẽ nhờ trang bị bộ vi xử lý Intel® Core™ i7 processor và đồ họa mới nhất. Bên cạnh đó, các công nghệ sáng tạo độc quyền của ASUS đưa thiết bị lên đẳng cấp mới, cho bạn một trải nghiệm người dùng trực quan và tính năng công thái học vượt trội.','ASUS','1711079496409-asus-02.png','Asus K501UX',11900000.00,99,'VGA NVIDIA GTX 950M- 4G',0,'THIET-KE-DO-HOA'),(5,'Chiếc MacBook Air có hiệu năng đột phá nhất từ trước đến nay đã xuất hiện. Bộ vi xử lý Apple M1 hoàn toàn mới đưa sức mạnh của MacBook Air M1 13 inch 2020 vượt xa khỏi mong đợi người dùng, có thể chạy được những tác vụ nặng và thời lượng pin đáng kinh ngạc.','APPLE','1711079954090-apple-01.png','MacBook Air 13',17690000.00,99,'Apple M1 GPU 7 nhân',0,'GAMING'),(6,'14.0 Chính: inch, 2880 x 1800 Pixels, OLED, 90 Hz, OLED','LG','1711080386941-lg-01.png','Laptop LG Gram Style',31490000.00,99,'Intel Iris Plus Graphics',0,'VAN-PHONG'),(7,'Không chỉ khơi gợi cảm hứng qua việc cách tân thiết kế, MacBook Air M2 2022 còn chứa đựng nguồn sức mạnh lớn lao với chip M2 siêu mạnh, thời lượng pin chạm  ngưỡng 18 giờ, màn hình Liquid Retina tuyệt đẹp và hệ thống camera kết hợp cùng âm thanh tân tiến.','APPLE','1711080787179-apple-02.png','MacBook Air 13 ',24990000.00,99,' Apple M2 GPU 8 nhân',0,'VAN-PHONG'),(8,'Là chiếc laptop gaming thế hệ mới nhất thuộc dòng Nitro 5 luôn chiếm được rất nhiều cảm tình của game thủ trước đây, Acer Nitro Gaming AN515-58-769J nay còn ấn tượng hơn nữa với bộ vi xử lý Intel Core i7 12700H cực khủng và card đồ họa RTX 3050, sẵn sàng cùng bạn chinh phục những đỉnh cao.\r\n','ACER','1711080948771-acer-01.png','Laptop Acer Nitro ',23490000.00,99,'AN515-58-769J i7 12700H',0,'VAN-PHONG'),(9,'15.6 inch, FHD (1920 x 1080), IPS, 144 Hz, 250 nits, Acer ComfyView LED-backlit','ASUS','1711081080930-asus-03.png','Laptop Acer Nitro V',26999000.00,99,' NVIDIA GeForce RTX 4050',0,'VAN-PHONG'),(10,'Dell Inspiron N3520 là chiếc laptop lý tưởng cho công việc hàng ngày. Bộ vi xử lý Intel Core i5 thế hệ thứ 12 hiệu suất cao, màn hình lớn 15,6 inch Full HD 120Hz mượt mà, thiết kế bền bỉ sẽ giúp bạn giải quyết công việc nhanh chóng mọi lúc mọi nơi.','DELL','1711081278418-dell-02.png','Laptop Dell Latitude 3420',21399000.00,99,' Intel Iris Xe Graphics',0,'VAN-PHONG'),(11,'Ngoại hình bắt mắt cùng một cấu hình lý tưởng cho mọi nhu cầu sử dụng hiện nay, thế hệ SCAR chắc chắn sẽ một lựa chọn không thể bỏ nếu bạn là một người dùng có hầu bao lớn. Và đến năm 2025, chúng ta sẽ có thế hệ ROG Strix SCAR 18 với mã G835LX SA193W.','ASUS','1750332962906-laptop_rog2.png','Laptop ASUS ROG Strix ',145000000.00,50,'Ultra 9 275HX/32GB/RTX5090/2TB/18\" 2.5K',0,'GAMING');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Admin thì full quyền','ADMIN'),(2,'User thông thường','USER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session`
--

DROP TABLE IF EXISTS `spring_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint NOT NULL,
  `LAST_ACCESS_TIME` bigint NOT NULL,
  `MAX_INACTIVE_INTERVAL` int NOT NULL,
  `EXPIRY_TIME` bigint NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session`
--

LOCK TABLES `spring_session` WRITE;
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
INSERT INTO `spring_session` VALUES ('0f3b7d89-5292-4c39-b68e-c82b646294b3','06e281d7-5843-4842-8371-2d91c3dbda56',1762248072435,1762249207770,1800,1762251007770,NULL),('53537156-3182-4e94-9b70-63b28098e425','8c6a0c28-3eac-4b38-a274-9b6a73d62012',1762247981107,1762248037542,1800,1762249837542,NULL);
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session_attributes`
--

DROP TABLE IF EXISTS `spring_session_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session_attributes`
--

LOCK TABLES `spring_session_attributes` WRITE;
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
INSERT INTO `spring_session_attributes` VALUES ('0f3b7d89-5292-4c39-b68e-c82b646294b3','jakarta.servlet.jsp.jstl.fmt.request.charset',_binary '�\�\0t\0UTF-8'),('0f3b7d89-5292-4c39-b68e-c82b646294b3','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$7eb18897-ceee-4d70-a2a0-50385844a7de'),('53537156-3182-4e94-9b70-63b28098e425','jakarta.servlet.jsp.jstl.fmt.request.charset',_binary '�\�\0t\0UTF-8'),('53537156-3182-4e94-9b70-63b28098e425','org.springframework.security.web.csrf.HttpSessionCsrfTokenRepository.CSRF_TOKEN',_binary '�\�\0sr\06org.springframework.security.web.csrf.DefaultCsrfTokenZ\�\�/��\�\0L\0\nheaderNamet\0Ljava/lang/String;L\0\rparameterNameq\0~\0L\0tokenq\0~\0xpt\0X-CSRF-TOKENt\0_csrft\0$ec05d8c1-7ca8-486d-bcc2-97a5bebc8f72');
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp56c1712k691lhsyewcssf40f` (`role_id`),
  CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (5,'Viet Nam','1750407402421-honkai1.jpg','anh@gmail.com',' Anh Nguyen Dac','$2a$10$S4SoK2TjHz1dCqAOm9tU9en707K2jJW5EOR2bxa89iqoWCJhVFIBm','42134214000000000',1),(6,'Viet Nam','1751469081294-Sao_bang.jpg','user@gmail.com','Mr User','$2a$10$5p3FYnZDVauwbauRIR3AveYl.kPTnMO13qaay6lMQwlnKLiXQvK7y','42134214000000000',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-04 16:49:34
