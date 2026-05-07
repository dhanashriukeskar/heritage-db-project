-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: heritage_db
-- ------------------------------------------------------
-- Server version	8.0.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `Admin_ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Role` varchar(50) DEFAULT NULL,
  `Access_Level` varchar(50) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Admin_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'Dhanashri Keskar','dhanashri@heritage.com','Super Admin','Full','$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO'),(2,'Adishree Kulkarni','adishree@heritage.com','Manager','Full','$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO'),(3,'Gauri Kondawar','gauri@heritage.com','Editor','Full','$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO'),(4,'Manasvi Mor','manasvi@heritage.com','Viewer','Full','$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_manages_site`
--

DROP TABLE IF EXISTS `admin_manages_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_manages_site` (
  `Admin_ID` int NOT NULL,
  `Site_ID` int NOT NULL,
  PRIMARY KEY (`Admin_ID`,`Site_ID`),
  KEY `Site_ID` (`Site_ID`),
  CONSTRAINT `admin_manages_site_ibfk_1` FOREIGN KEY (`Admin_ID`) REFERENCES `admin` (`Admin_ID`),
  CONSTRAINT `admin_manages_site_ibfk_2` FOREIGN KEY (`Site_ID`) REFERENCES `heritage_site` (`Site_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_manages_site`
--

LOCK TABLES `admin_manages_site` WRITE;
/*!40000 ALTER TABLE `admin_manages_site` DISABLE KEYS */;
INSERT INTO `admin_manages_site` VALUES (1,1),(1,2),(1,3),(2,4),(2,5),(3,6);
/*!40000 ALTER TABLE `admin_manages_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_verifies_contribution`
--

DROP TABLE IF EXISTS `admin_verifies_contribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_verifies_contribution` (
  `Admin_ID` int NOT NULL,
  `Contribution_ID` int NOT NULL,
  PRIMARY KEY (`Admin_ID`,`Contribution_ID`),
  KEY `Contribution_ID` (`Contribution_ID`),
  CONSTRAINT `admin_verifies_contribution_ibfk_1` FOREIGN KEY (`Admin_ID`) REFERENCES `admin` (`Admin_ID`),
  CONSTRAINT `admin_verifies_contribution_ibfk_2` FOREIGN KEY (`Contribution_ID`) REFERENCES `contribution` (`Contribution_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_verifies_contribution`
--

LOCK TABLES `admin_verifies_contribution` WRITE;
/*!40000 ALTER TABLE `admin_verifies_contribution` DISABLE KEYS */;
INSERT INTO `admin_verifies_contribution` VALUES (1,1),(1,2),(2,2),(3,3),(1,4),(1,5),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18);
/*!40000 ALTER TABLE `admin_verifies_contribution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `architecture_style`
--

DROP TABLE IF EXISTS `architecture_style`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `architecture_style` (
  `Style_ID` int NOT NULL AUTO_INCREMENT,
  `Style_Name` varchar(100) DEFAULT NULL,
  `Dynasty` varchar(100) DEFAULT NULL,
  `Description` text,
  `Site_ID` int DEFAULT NULL,
  PRIMARY KEY (`Style_ID`),
  KEY `Site_ID` (`Site_ID`),
  CONSTRAINT `architecture_style_ibfk_1` FOREIGN KEY (`Site_ID`) REFERENCES `heritage_site` (`Site_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `architecture_style`
--

LOCK TABLES `architecture_style` WRITE;
/*!40000 ALTER TABLE `architecture_style` DISABLE KEYS */;
INSERT INTO `architecture_style` VALUES (1,'Mughal Architecture','Mughal Dynasty','White marble with intricate inlay work and Persian influences',1),(2,'Colonial Architecture','British Colonial','Indo-Saracenic style combining Hindu, Islamic and Gothic elements',2),(3,'Mughal Architecture','Mughal Dynasty','Red sandstone construction with elaborate decorations',3),(4,'Maratha Architecture','Peshwa Dynasty','Fortification style with strong Deccan influences',4),(5,'Rock Cut Architecture','Rashtrakuta Dynasty','Cave temples carved directly into volcanic rock',5),(6,'Dravidian Architecture','Vijayanagara Dynasty','Intricate stone carvings with large temple complexes',6),(7,'Dravidian Architecture','Pallava Dynasty','Stone temple architecture with pyramid shaped towers',7),(8,'Nagara Architecture','Chandela Dynasty','North Indian temple style with curvilinear shikhara towers',8),(9,'Kalinga Architecture','Eastern Ganga Dynasty','Distinctive Odishan style with deula and jagamohana',9),(10,'Mughal Architecture','Mughal Dynasty','Persian influenced style with red sandstone construction',10),(11,'Indo-Saracenic Architecture','Wadiyar Dynasty','Blend of Hindu Rajput and Islamic architectural elements',11),(12,'Dravidian Architecture','Chola Dynasty','Magnificent vimana towers with intricate stone carvings',12),(13,'Kalinga Architecture','Eastern Ganga Dynasty','Designed as chariot with 24 wheels pulled by 7 horses',13),(14,'Buddhist Architecture','Maurya Dynasty','Hemispherical dome stupa with ceremonial gateways',14),(15,'Nagara Architecture','Various Dynasties','Sacred temple on banks of Ganga with traditional shikara',15),(16,'Rajput Architecture','Rajput Dynasty','Blend of Hindu and Mughal styles with massive fortifications',16),(17,'Qutb Shahi Architecture','Qutb Shahi Dynasty','Persian and Hindu elements with massive granite fortifications',17),(18,'Chalukya Architecture','Chalukya Dynasty','Cave temples carved directly into red sandstone cliffs',18),(19,'Buddhist Rock Cut Architecture','Satavahana Dynasty','Elaborate cave paintings with Buddhist iconography',19),(20,'Indo-Islamic Architecture','Delhi Sultanate','First major Islamic monument in India with Arabic calligraphy',20),(21,'Himalayan Temple Architecture','Ancient','Stone temple built in Himalayan style at high altitude',21),(22,'Himalayan Temple Architecture','Ancient','Sacred shrine with gold plated roof in Himalayan style',22),(23,'Modern Hindu Architecture','Modern','Grand Nagara style temple built with pink sandstone',23),(24,'Chalukya Architecture','Ancient','Ancient temple with intricate stone carvings near sea coast',24),(25,'Dravidian Architecture','Medieval','Magnificent temple with golden dome on Tirumala Hills',25),(26,'Dravidian Architecture','Nayak Dynasty','Stunning temple with 14 colorful gopurams and 1000 pillared hall',26),(27,'Modern Hindu Architecture','Modern','Rebuilt temple with Solanki style architecture',27),(28,'Rajputana Architecture','Medieval','Sacred temple with beautiful courtyard and marble construction',28),(29,'Sikh Architecture','Sikh Period','Golden temple with marble pathways surrounded by sacred lake',29),(30,'Buddhist Architecture','Maurya Dynasty','UNESCO listed temple with Bodhi tree and diamond throne',30),(31,'Ghat Architecture','Ancient','Sacred ghats with temples lining the banks of River Ganga',31),(32,'Modern Temple Architecture','Modern','Beautiful white marble temple with extensive complex',32),(33,'Hemadpanthi Architecture','Yadava Dynasty','Black stone temple with intricate carvings near Brahmagiri hill',33),(34,'Paramara Architecture','Ancient','Ancient temple with unique south facing Shivalinga',34),(35,'Ghat Architecture','Ancient','Sacred ghat where Ganga descends from mountains to plains',35),(36,'Dravidian Architecture','Medieval','Temple with longest corridor in world stretching 1200 meters',36),(37,'Ancient Temple Architecture','Ancient','Sacred complex marking birthplace of Lord Krishna',37),(38,'Bengali Architecture','Medieval','Temple combining Bengali and classical styles',38),(39,'Himalayan Temple Architecture','Ancient','Sacred temple at 3100m altitude near Gangotri glacier',39),(40,'Himalayan Temple Architecture','Ancient','Remote temple at 3291m altitude near Yamunotri glacier',40),(41,'Hemadpanthi Architecture','Yadava Dynasty','Ancient temple built in Hemadpanthi style with black stone on banks of River Bhima',41),(42,'Math Architecture','Modern Period','Sacred math complex with temple and meditation hall built in traditional Maharashtrian style',42),(43,'Traditional Maharashtrian Architecture','Modern Period','Peaceful temple and math complex built in traditional style surrounded by natural beauty',43),(44,'Hemadpanthi Architecture','Ancient Period','Ancient shakti peeth temple built in Hemadpanthi style with stone carvings',44);
/*!40000 ALTER TABLE `architecture_style` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contribution`
--

DROP TABLE IF EXISTS `contribution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contribution` (
  `Contribution_ID` int NOT NULL AUTO_INCREMENT,
  `Status` varchar(50) DEFAULT NULL,
  `date_submitted` date DEFAULT NULL,
  `Contribution_date` date DEFAULT NULL,
  `Visitor_ID` int DEFAULT NULL,
  `Site_ID` int DEFAULT NULL,
  PRIMARY KEY (`Contribution_ID`),
  KEY `Visitor_ID` (`Visitor_ID`),
  KEY `Site_ID` (`Site_ID`),
  CONSTRAINT `contribution_ibfk_1` FOREIGN KEY (`Visitor_ID`) REFERENCES `visitors` (`Visitor_ID`),
  CONSTRAINT `contribution_ibfk_2` FOREIGN KEY (`Site_ID`) REFERENCES `heritage_site` (`Site_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contribution`
--

LOCK TABLES `contribution` WRITE;
/*!40000 ALTER TABLE `contribution` DISABLE KEYS */;
INSERT INTO `contribution` VALUES (1,'Approved','2026-03-01','2026-03-05',1,1),(2,'Approved','2026-03-10','2026-04-24',2,3),(3,'Approved','2026-02-15','2026-02-20',3,5),(4,'Approved','2026-04-12','2026-04-24',5,45),(5,'Approved','2026-04-12','2026-04-24',5,46),(6,'Approved','2026-04-12','2026-04-24',5,47),(7,'Approved','2026-04-12','2026-04-24',6,48),(8,'Approved','2026-04-12','2026-04-24',7,49),(9,'Approved','2026-04-13','2026-04-24',8,50),(10,'Approved','2026-04-24','2026-04-24',5,51),(11,'Approved','2026-04-25','2026-04-25',5,52),(12,'Rejected','2026-04-26','2026-04-26',9,NULL),(13,'Approved','2026-04-26','2026-04-26',10,54),(14,'Rejected','2026-04-27','2026-04-27',13,NULL),(15,'Approved','2026-04-27','2026-04-27',5,55),(16,'Approved','2026-04-27','2026-05-06',17,56),(17,'Approved','2026-04-27','2026-05-06',18,57),(18,'Approved','2026-05-06','2026-05-06',5,41),(19,'Rejected','2026-05-06','2026-05-07',24,NULL);
/*!40000 ALTER TABLE `contribution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `heritage_site`
--

DROP TABLE IF EXISTS `heritage_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `heritage_site` (
  `Site_ID` int NOT NULL AUTO_INCREMENT,
  `Site_Name` varchar(200) DEFAULT NULL,
  `Description` text,
  `Historical_Period` varchar(100) DEFAULT NULL,
  `UNESCO_Status` varchar(50) DEFAULT NULL,
  `Location_ID` int DEFAULT NULL,
  PRIMARY KEY (`Site_ID`),
  KEY `Location_ID` (`Location_ID`),
  CONSTRAINT `heritage_site_ibfk_1` FOREIGN KEY (`Location_ID`) REFERENCES `location` (`Location_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `heritage_site`
--

LOCK TABLES `heritage_site` WRITE;
/*!40000 ALTER TABLE `heritage_site` DISABLE KEYS */;
INSERT INTO `heritage_site` VALUES (1,'Taj Mahal','Iconic white marble mausoleum built by Mughal Emperor Shah Jahan in 1632.','Mughal Period (1632-1653)','UNESCO World Heritage',1),(2,'Gateway of India','Historic arch monument overlooking the Arabian Sea built during British rule.','Colonial Period','State Heritage',2),(3,'Red Fort','Massive red sandstone fort that served as main residence of Mughal Emperors.','Mughal Period (1638-1648)','UNESCO World Heritage',3),(4,'Shaniwar Wada','Historic fortification and seat of the Peshwa rulers of the Maratha Empire.','Maratha Empire (1732)','State Heritage',4),(5,'Ellora Caves','Ancient rock-cut cave temples representing Hindu, Buddhist and Jain traditions.','Medieval Period (6th-10th Century)','UNESCO World Heritage',5),(6,'Hampi Ruins','Ruins of the magnificent Vijayanagara Empire capital city.','Vijayanagara Period (14th-16th Century)','UNESCO World Heritage',6),(7,'Shore Temple Mahabalipuram','Structural temple built by Pallava King Narasimhavarman II overlooking Bay of Bengal.','Pallava Period (700-728 AD)','UNESCO World Heritage',7),(8,'Khajuraho Temples','Group of Hindu and Jain temples famous for their nagara-style architecture and erotic sculptures.','Chandela Dynasty (950-1050 AD)','UNESCO World Heritage',8),(9,'Jagannath Temple Puri','Sacred Hindu temple dedicated to Lord Jagannath and one of the Char Dham pilgrimage sites.','Eastern Ganga Dynasty (12th Century)','State Heritage',9),(10,'Fatehpur Sikri','Abandoned Mughal city built by Emperor Akbar serving as capital of Mughal Empire for 14 years.','Mughal Period (1571-1585)','UNESCO World Heritage',10),(11,'Mysore Palace','Magnificent royal palace of the Wadiyar dynasty and one of the most visited monuments in India.','Wadiyar Dynasty (1912)','State Heritage',11),(12,'Brihadeeswarar Temple','Magnificent Chola temple dedicated to Lord Shiva built by Raja Raja Chola I over 1000 years ago.','Chola Dynasty (1010 AD)','UNESCO World Heritage',12),(13,'Konark Sun Temple','Iconic 13th century temple designed as a gigantic chariot of the Sun God with intricate stone carvings.','Eastern Ganga Dynasty (1250 AD)','UNESCO World Heritage',13),(14,'Sanchi Stupa','Ancient Buddhist monument built by Emperor Ashoka containing relics of Lord Buddha.','Maurya Period (3rd Century BC)','UNESCO World Heritage',14),(15,'Kashi Vishwanath Temple','One of the most sacred Hindu temples dedicated to Lord Shiva situated on the banks of River Ganga.','Ancient Period','State Heritage',15),(16,'Amber Fort','Magnificent Rajput fort palace built by Raja Man Singh I overlooking Maota Lake in Jaipur.','Rajput Period (1592)','UNESCO World Heritage',16),(17,'Golconda Fort','Magnificent medieval fort and former capital of Qutb Shahi dynasty known for its acoustics.','Qutb Shahi Dynasty (16th Century)','State Heritage',17),(18,'Badami Cave Temples','Series of Hindu and Jain cave temples carved out of sandstone cliffs by Chalukya dynasty.','Chalukya Dynasty (6th Century)','State Heritage',18),(19,'Ajanta Caves','Rock-cut Buddhist cave monuments with magnificent paintings and sculptures depicting Jataka tales.','Satavahana to Vakataka Period (2nd BC - 6th AD)','UNESCO World Heritage',19),(20,'Qutub Minar','Tallest brick minaret in the world built by Qutb ud-Din Aibak of Delhi Sultanate.','Delhi Sultanate (1193 AD)','UNESCO World Heritage',20),(21,'Kedarnath Temple','One of the twelve Jyotirlingas dedicated to Lord Shiva situated at 3583m altitude in Himalayas.','Ancient Period (8th Century AD)','State Heritage',21),(22,'Badrinath Temple','Sacred Hindu temple dedicated to Lord Vishnu and one of the four Char Dham pilgrimage sites.','Ancient Period','State Heritage',22),(23,'Ram Mandir Ayodhya','Newly built grand temple at the birthplace of Lord Ram in Ayodhya inaugurated in 2024.','Modern Period (2024)','State Heritage',23),(24,'Dwarkadhish Temple','Ancient temple dedicated to Lord Krishna built at the legendary city of Dwarka on Arabian Sea coast.','Ancient Period (2nd Century BC)','State Heritage',24),(25,'Tirumala Venkateswara Temple','Most visited religious site in the world dedicated to Lord Venkateswara on Tirumala Hills.','Medieval Period (9th Century)','State Heritage',25),(26,'Meenakshi Amman Temple','Magnificent Dravidian temple dedicated to Goddess Meenakshi with 14 towering gopurams.','Nayak Dynasty (17th Century)','UNESCO Tentative List',26),(27,'Somnath Temple','First of the twelve Jyotirlingas and one of the most sacred pilgrimage sites rebuilt seven times.','Ancient Period','State Heritage',27),(28,'Banke Bihari Temple','Famous Krishna temple in Vrindavan one of the most sacred places associated with Lord Krishna.','Medieval Period (1864)','State Heritage',28),(29,'Golden Temple Amritsar','Holiest shrine of Sikhism also known as Harmandir Sahib with stunning golden architecture.','Sikh Period (1604)','State Heritage',29),(30,'Mahabodhi Temple','Sacred Buddhist temple marking the spot where Gautama Buddha attained enlightenment under Bodhi Tree.','Maurya Period (3rd Century BC)','UNESCO World Heritage',30),(31,'Triveni Ghat Rishikesh','Sacred bathing ghat at confluence of rivers where evening Ganga Aarti is performed daily.','Ancient Period','State Heritage',31),(32,'Sai Baba Temple Shirdi','Sacred shrine dedicated to Saint Sai Baba visited by millions of devotees every year.','Modern Period (19th Century)','State Heritage',32),(33,'Trimbakeshwar Temple','One of the twelve Jyotirlingas situated near the origin of sacred Godavari river in Nashik.','Peshwa Period (18th Century)','State Heritage',33),(34,'Mahakaleshwar Temple','One of the twelve Jyotirlingas in Ujjain famous for its unique south facing Shivalinga.','Ancient Period','State Heritage',34),(35,'Har Ki Pauri Haridwar','Sacred ghat in Haridwar where Ganga descends to plains famous for Ganga Aarti ceremony.','Ancient Period','State Heritage',35),(36,'Ramanathaswamy Temple','Sacred Hindu temple dedicated to Lord Shiva and one of the twelve Jyotirlingas in Rameswaram.','Medieval Period (12th Century)','State Heritage',36),(37,'Krishna Janmabhoomi','Sacred birthplace of Lord Krishna in Mathura one of the seven sacred cities of Hinduism.','Ancient Period','State Heritage',37),(38,'Kalighat Temple','One of the 51 Shakti Peethas dedicated to Goddess Kali situated on banks of Adi Ganga in Kolkata.','Medieval Period (1809)','State Heritage',38),(39,'Gangotri Temple','Sacred Hindu temple and origin of River Ganga one of the four sites of Chota Char Dham.','Ancient Period (18th Century)','State Heritage',39),(40,'Yamunotri Temple','Sacred temple at origin of River Yamuna and one of the four sites of Chota Char Dham.','Ancient Period (19th Century)','State Heritage',40),(41,'Vitthal Rukmini Mandir Pandharpur','Sacred temple dedicated to Lord Vitthal and Goddess Rukmini on the banks of River Bhima. Most important pilgrimage site for Varkari sect of Maharashtra.','Medieval Period (13th Century)','State Heritage',41),(42,'Akkalkot Swami Samarth Math','Sacred math and temple of Swami Samarth one of the most revered saints of Maharashtra visited by millions of devotees.','Modern Period (19th Century)','State Heritage',42),(43,'Shri Brahmachaitanya Gondavlekar Maharaj Mandir','Sacred temple and math of Sant Brahmachaitanya Gondavlekar Maharaj known for Ram Naam devotion in Gondavale village.','Modern Period (19th Century)','State Heritage',43),(44,'Tulja Bhavani Temple Tuljapur','Ancient temple of Goddess Tulja Bhavani one of the three and half Shakti Peethas of Maharashtra and Kuladaivat of Chhatrapati Shivaji Maharaj.','Ancient Period (6th Century)','State Heritage',44),(45,'Gajanan Maharaj Temple Pandharpur.','The Shree Gajanan Maharaj Mandir in Pandharpur is a serene, marble-built branch of the Shegaon Sansthan located near Sangola Naka. Situated in a well-maintained 8.5-acre campus, it is known for its peaceful, green, and clean environment offering, affordable lodging and clean, spiritual ambience. The temple features a 72-foot-high Mahadwar built in Dholpuri stone.','late 19th century or early 20th century','Local Heritage',45),(46,'Vaishno Devi Temple','One of the most famous Hindu pilgrimage temples in India.\r\nDedicated to Mata Vaishno Devi, considered a form of Durga (Mahakali, Mahalakshmi, Mahasaraswati).\r\nLocated at about 5200 feet (???1585 m) height in the mountains.\r\nDevotees trek around 13 km from Katra to reach the cave temple.','Ancient origin; mentioned in Mahabharata, developed in medieval period.','State Heritage',47),(47,'Shree GanpatiPule Temple ','Ganpatipule Temple is a famous temple of Lord Ganesha.\r\nKnown for its self-originated (Swayambhu) idol.\r\nLocated near the Arabian Sea, offering scenic views.\r\nThe temple is visited by many devotees and tourists.','Ancient temple; believed to be over 400 years old.','State Heritage',48),(48,'Durgadi Fort Kalyan','Durgadi Fort is a historic fort located in Kalyan.\r\nBuilt during the Maratha period and associated with Chhatrapati Shivaji Maharaj.\r\nThe fort has a temple of Goddess Durga (Durgadi Temple) inside.\r\nIt holds both historical and religious importance','17th century; Maratha period (Shivaji Maharaj era).','Local Heritage',49),(49,'Western Ghats','Western Ghats is a long mountain range along the western coast of India.\r\nKnown for rich biodiversity and wildlife.\r\nDeclared a UNESCO World Heritage Site.\r\nImportant for climate, rivers, and forests in India.','Ancient natural formation; millions of years old.','Unknown',50),(50,'Padmanabhaswamy Temple:','Padmanabhaswamy Temple is a famous Hindu temple dedicated to Lord Vishnu.\r\nKnown for its Dravidian-style architecture.\r\nOne of the richest temples in the world.\r\nThe deity is seen in a reclining (Anantashayana) posture.','Ancient origin; major development in 16th century.','State Heritage',51),(51,'Hawa Mahal','Hawa Mahal, also known as the “Palace of Winds,” is a five-story palace made of red and pink sandstone. Built with 953 small windows (jharokhas), it allowed royal women to observe street festivals while remaining unseen. Its unique honeycomb design also keeps the structure cool by allowing air to circulate.','Rajput Period (1799 AD)','State Heritage',52),(52,'Shri Suryanarayan Mandir','Shri Suryanarayan Mandir is Mumbai\'s oldest and one of its very few temples dedicated to Lord Surya, the Sun God.\r\nLocated in the bustling Bhuleshwar area, it is renowned for its beautiful stone architecture and daily morning rituals.\r\nThe temple remains an important spiritual and cultural landmark in South Mumbai.','Late 19th Century (1899 CE)','State Heritage',53),(54,'Gangapur Temple','Gangapur Temple, located near Solapur in Maharashtra, is a revered Hindu pilgrimage site known for its spiritual significance and peaceful surroundings. Dedicated to Lord Dattatreya, the temple attracts thousands of devotees every year, especially during religious festivals and special occasions. Its traditional architecture, serene atmosphere, and cultural importance make it a notable heritage landmark in the region.','Medieval Period (14th–15th Century AD)  UNESCO Status:','Local Heritage',55),(55,'Mandu','A magnificent fortified city known for Afghan architecture, palaces, and romantic legends, especially the famous Jahaz Mahal.','10th–16th Century CE','UNESCO Tentative List',56),(56,'Chand Baori','One of India\'s deepest and most geometrically stunning stepwells, featuring over 3,500 perfectly symmetrical steps.','8th–9th Century CE','State Heritage',57),(57,'Living Root Bridges','Ingenious natural bridges created by training tree roots, showcasing sustainable indigenous engineering.','Several Centuries Old','UNESCO Tentative List',58);
/*!40000 ALTER TABLE `heritage_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image_gallery`
--

DROP TABLE IF EXISTS `image_gallery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image_gallery` (
  `Image_ID` int NOT NULL AUTO_INCREMENT,
  `Image_Url` varchar(500) DEFAULT NULL,
  `Upload_Date` date DEFAULT NULL,
  `Uploaded_By` varchar(100) DEFAULT NULL,
  `Site_ID` int DEFAULT NULL,
  PRIMARY KEY (`Image_ID`),
  KEY `Site_ID` (`Site_ID`),
  CONSTRAINT `image_gallery_ibfk_1` FOREIGN KEY (`Site_ID`) REFERENCES `heritage_site` (`Site_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image_gallery`
--

LOCK TABLES `image_gallery` WRITE;
/*!40000 ALTER TABLE `image_gallery` DISABLE KEYS */;
INSERT INTO `image_gallery` VALUES (1,'https://lh3.googleusercontent.com/gps-cs-s/APNQkAEs1m6EIywrYOq6-pDgIU6aj67Ni79bVQIxh9EOQ75T-xveUb5VxQflU352jsOORBtyGyUAOuYQImGhtTnsk7-WCpxmfj78Bi6G-ax-CU577Co5iGf55ISdrFZ9V6umjJL-vrHX=s1360-w1360-h1020-rw','2026-01-10','Admin',1),(2,'https://mediaindia.eu/wp-content/uploads/2020/01/sarang-pande-k3SHcT9zGkE-unsplash-_1_.webp','2026-01-11','Admin',2),(3,'https://d18x2uyjeekruj.cloudfront.net/wp-content/uploads/2023/08/red-fort.jpg','2026-01-12','Admin',3),(4,'https://punetourism.co.in/images/places-to-visit/headers/shaniwar-wada-pune-tourism-entry-fee-timings-holidays-reviews-header.jpg','2026-01-13','Admin',4),(6,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBFjdTNzZ5N6vlpehb4NPviNnEWEU-Tz-jNg&s','2026-01-15','Admin',6),(7,'https://cdn.britannica.com/12/100812-050-27483D5E/Mamallapuram-Shore-Temple-Chennai-India-Tamil-Nadu.jpg','2026-01-16','Admin',7),(8,'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_1032564361_20200219140048.jpg','2026-01-17','Admin',8),(9,'https://s7ap1.scene7.com/is/image/incredibleindia/sri-jagannath-temple-puri-odisha-3-attr-hero?qlt=82&ts=1726663744795','2026-01-18','Admin',9),(10,'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/2e/7b/57/01/caption.jpg?w=900&h=500&s=1','2026-01-19','Admin',10),(11,'https://www.mysoretourism.org.in/images/v2/places-to-visit/mysore-maharaja-palace-header-mysore-tourism.jpg','2026-01-20','Admin',11),(12,'https://cdn.thedecorjournalindia.com/wp-content/uploads/2022/03/Brihadeshwara-Temple-A-structure-conceived-with-grace-and-Magnificence-1.jpg','2026-01-21','Admin',12),(13,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLY88HyTuF6rzYkA6egAK3FI7n6i50G4TZMw&s','2026-01-22','Admin',13),(14,'https://inditales.com/wp-content/uploads/2009/09/sanchi-great-stupa.jpg','2026-01-23','Admin',14),(15,'https://content.skyscnr.com/m/26eaa06a2be696f0/original/GettyImages-525109131.jpg','2026-01-24','Admin',15),(16,'https://hblimg.mmtcdn.com/content/hubble/img/jaipur/mmt/activities/m_activities_amber_fort_2_l_436_573.jpg','2026-01-25','Admin',16),(17,'https://s7ap1.scene7.com/is/image/incredibleindia/golconda-fort-hyderabad-secunderabad-telangana-3-musthead-hero?qlt=82&ts=1742197014098','2026-01-26','Admin',17),(18,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh6oqBjEdDlVOcdm6pD0ex1Js-zUDJEVDpIw&s','2026-01-27','Admin',18),(19,'https://www.gokitetours.com/wp-content/uploads/2024/11/Top-7-Unique-Facts-About-the-Ajanta-and-Ellora-Caves-1200x720.webp','2026-01-28','Admin',19),(20,'https://s7ap1.scene7.com/is/image/incredibleindia/qutab-minar-delhi-attr-hero?qlt=82&ts=1742169673469','2026-01-29','Admin',20),(21,'https://tsms.b-cdn.net/tsms/staging/home_slider/home_slider-110320251006031765.jpg','2026-02-01','Admin',21),(22,'https://www.chardham-pilgrimage-tour.com/assets/images/badrinath-banner3.webp','2026-02-02','Admin',22),(23,'https://api.ayodhya-dham.in/AppImages/135-202409201552292593.jpg','2026-02-03','Admin',23),(24,'https://hblimg.mmtcdn.com/content/hubble/img/dwarka/mmt/activities/m_Dwarkadhish%20Temple-1_l_498_640.jpg','2026-02-04','Admin',24),(25,'https://www.pilgrimagetour.in/blog/wp-content/uploads/2023/09/Tirumala-Tirupati-Balaji-Temple-Timings.jpg','2026-02-05','Admin',25),(26,'https://miro.medium.com/v2/resize:fit:1400/1*R7yKx3b1UEthFsGP6v4tIg.jpeg','2026-02-06','Admin',26),(27,'https://www.thehitavada.com/Encyc/2026/1/9/Swabhiman-Parva-begins-at-Somnath-Temple-in-Gujarat_202601091136399612_H@@IGHT_482_W@@IDTH_803.jpg','2026-02-07','Admin',27),(28,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnxyBXgg9fJNaQfyDEs6rYt1PQ4bk1pPuSNQ&s','2026-02-08','Admin',28),(29,'https://sacredsites.com/images/asia/india/punjab/Golden-Temple-1.webp','2026-02-09','Admin',29),(30,'https://www.tripsavvy.com/thmb/vzVTgJuv8L5RU3iXFaaZ0KYoh5k=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-618355052-b865a78b33cf412b915909ad9d941f27.jpg','2026-02-10','Admin',30),(31,'https://www.trawell.in/admin/images/upload/148894262Rishikesh_Triveni_Ghat_Main.jpg','2026-02-11','Admin',31),(32,'https://bhatkantiholidays.com/wp-content/uploads/2020/10/shirdi-sai-baba.jpg','2026-02-12','Admin',32),(33,'https://s7ap1.scene7.com/is/image/incredibleindia/1-trimbakeshwar-nashik-maharashtra-attr-hero?qlt=82&ts=1726669890287','2026-02-13','Admin',33),(34,'https://upload.wikimedia.org/wikipedia/commons/7/75/Mahakaleshwar_Temple%2C_Ujjain.jpg','2026-02-14','Admin',34),(35,'https://s7ap1.scene7.com/is/image/incredibleindia/har-ki-pauri-haridwar-uttarakhand-1-attr-hero?qlt=82&ts=1726645951242','2026-02-15','Admin',35),(36,'https://www.justahotels.com/wp-content/uploads/2024/02/Ramanathaswamy-Temple.jpg','2026-02-16','Admin',36),(37,'https://www.trawell.in/admin/images/upload/103055465Mathura_Krishna_Janmabhoomi_Temple_Main.jpg','2026-02-17','Admin',37),(38,'https://res.cloudinary.com/rehash-studio/image/upload/fl_progressive:semi,f_jpg,q_60,c_fill,g_auto:subject,ar_4:3/if_w_gt_1200,w_1200/v1737959550/upload/1c4a9051-76a1-4dde-af2b-ea83ecbac71f.png','2026-02-18','Admin',38),(39,'https://travelvaidya.com/blog/wp-content/uploads/2025/05/gangotri-temple.webp','2026-02-19','Admin',39),(40,'https://www.bizarexpedition.com/api/uploads/gallary/file-1769511234777.webp','2026-02-20','Admin',40),(41,'https://vitthalrukminimandir.org/images/Temple2.jpg','2026-03-01','Admin',41),(42,'https://praveenmusafir.com/wp-content/uploads/2024/04/Akkalkot-Temple-1024x768.jpg','2026-03-02','Admin',42),(43,'https://static.wixstatic.com/media/cab5da_a485981c3a7841a381603e137d0bb741~mv2.jpg/v1/fill/w_332,h_320,al_c/cab5da_a485981c3a7841a381603e137d0bb741~mv2.jpg','2026-03-03','Admin',43),(44,'https://utsav.gov.in/public/uploads/darshan_cover_image/darshan_7/16491374841691482530.jpg','2026-03-04','Admin',44),(45,'https://temple.yatradham.org/public/Product/temple/temple_QcG6Eije_202507282051060.webp','2026-04-12','dhanashri  keskar',45),(46,'https://res.cloudinary.com/kmadmin/image/upload/v1734333916/kiomoi/Vaishno_Devi_Temple-3_5633.png','2026-04-12','dhanashri  keskar',46),(47,'https://thetempleguru.com/wp-content/uploads/2024/08/Shree-Ganpatipule-Temple-4.jpg','2026-04-12','Dhanashri  Keskar',47),(48,'https://upload.wikimedia.org/wikipedia/commons/2/2a/Durgadi_Fort_%2CKalyan%2C_Maharashtra_-_panoramio_%2820%29.jpg','2026-04-12','Prajakta Keskar',48),(49,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRDfemcsn90ow77yaX1UJD56DYH5e6zVD48Q&s','2026-04-12','Mayuri Keskar',49),(50,'https://assets.gqindia.com/photos/5f0ec391532fa7831d9d6e81/16:9/w_2560%2Cc_limit/Everything-you-need-to-know-about-the-world\'s-richest-temple-Sree-Padmanabhaswamy-and-its-treasures-worth-Rs-1%2C00%2C000-crore.jpg','2026-04-13','adishree kulkarni',50),(51,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6CjTmMRIK0yXZZKaatCguZdgfT4vb4u9ZQQ&s','2026-04-24','Dhanashri Keskar',51),(52,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw027Swfol0iIn4iLGHPTEiLL2u4585SdvSg&s','2026-04-25','Dhanashri Keskar',52),(53,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsXxe6Q2hIGYJVubgrtyQzjSwndxg0CnC84A&s','2026-04-26','Sanskruti  Khankal',54),(54,'https://upload.wikimedia.org/wikipedia/commons/a/ab/JahazMahal.jpg','2026-04-27','Dhanashri Keskar',55),(55,'https://upload.wikimedia.org/wikipedia/commons/3/35/Chand_Baori_perspective_panorama_%28July_2022%29.jpg','2026-05-06','Varad Keskar',56),(56,'https://www.trawell.in/admin/images/upload/64576125Mawlynnong_Living_Root_Bridge_%20Main.jpg','2026-05-06','Tejashri  Keskar',57),(57,'https://s7ap1.scene7.com/is/image/incredibleindia/ellora-caves-chhatrapati-sambhaji-nagar-maharashtra-attr-hero-2?qlt=82&ts=1727010631584','2026-05-07','Admin',5);
/*!40000 ALTER TABLE `image_gallery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `location` (
  `Location_ID` int NOT NULL AUTO_INCREMENT,
  `city` varchar(100) DEFAULT NULL,
  `area` varchar(100) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Location_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Agra','Taj Ganj','282001','Uttar Pradesh','Agra'),(2,'Mumbai','Colaba','400001','Maharashtra','Mumbai'),(3,'Delhi','Old Delhi','110006','Delhi','Central Delhi'),(4,'Pune','Kasba Peth','411011','Maharashtra','Pune'),(5,'Aurangabad','Ellora','431102','Maharashtra','Aurangabad'),(6,'Hospet','Hampi','583221','Karnataka','Ballari'),(7,'Mahabalipuram','Shore Temple Area','603104','Tamil Nadu','Chengalpattu'),(8,'Khajuraho','Temple Area','471606','Madhya Pradesh','Chhatarpur'),(9,'Puri','Sea Beach Road','752001','Odisha','Puri'),(10,'Fatehpur Sikri','Agra Road','283110','Uttar Pradesh','Agra'),(11,'Mysuru','Sayyaji Rao Road','570001','Karnataka','Mysuru'),(12,'Thanjavur','East Main Street','613001','Tamil Nadu','Thanjavur'),(13,'Konark','Temple Road','752111','Odisha','Puri'),(14,'Sanchi','Sanchi Hill','464661','Madhya Pradesh','Raisen'),(15,'Varanasi','Dashashwamedh Ghat','221001','Uttar Pradesh','Varanasi'),(16,'Jaipur','Amber Fort Road','302001','Rajasthan','Jaipur'),(17,'Golconda','Ibrahim Bagh','500008','Telangana','Hyderabad'),(18,'Badami','Cave Temple Road','587201','Karnataka','Bagalkot'),(19,'Ajanta','Ajanta Caves Road','431117','Maharashtra','Aurangabad'),(20,'Qutub Minar','Mehrauli','110030','Delhi','South Delhi'),(21,'Kedarnath','Kedarnath Valley','246445','Uttarakhand','Rudraprayag'),(22,'Badrinath','Badrinath Valley','246422','Uttarakhand','Chamoli'),(23,'Ayodhya','Ram Janmabhoomi','224123','Uttar Pradesh','Ayodhya'),(24,'Dwarka','Dwarka Beach Road','361335','Gujarat','Devbhumi Dwarka'),(25,'Tirupati','Tirumala Hills','517502','Andhra Pradesh','Tirupati'),(26,'Madurai','Meenakshi Amman Road','625001','Tamil Nadu','Madurai'),(27,'Somnath','Somnath Temple Road','362268','Gujarat','Gir Somnath'),(28,'Vrindavan','Mathura Road','281121','Uttar Pradesh','Mathura'),(29,'Amritsar','Golden Temple Road','143001','Punjab','Amritsar'),(30,'Bodh Gaya','Temple Road','824231','Bihar','Gaya'),(31,'Rishikesh','Triveni Ghat Road','249201','Uttarakhand','Dehradun'),(32,'Shirdi','Sai Baba Road','423109','Maharashtra','Ahmednagar'),(33,'Nashik','Panchavati Road','422001','Maharashtra','Nashik'),(34,'Ujjain','Mahakal Road','456001','Madhya Pradesh','Ujjain'),(35,'Haridwar','Har Ki Pauri Road','249401','Uttarakhand','Haridwar'),(36,'Rameswaram','Temple Street','623526','Tamil Nadu','Ramanathapuram'),(37,'Mathura','Krishna Janmabhoomi','281001','Uttar Pradesh','Mathura'),(38,'Kolkata','Kalighat Road','700026','West Bengal','Kolkata'),(39,'Gangotri','Gangotri Temple Road','249193','Uttarakhand','Uttarkashi'),(40,'Yamunotri','Yamunotri Valley','249141','Uttarakhand','Uttarkashi'),(41,'Pandharpur','Vitthal Mandir Road','413304','Maharashtra','Solapur'),(42,'Akkalkot','Swami Samarth Math Road','413216','Maharashtra','Solapur'),(43,'Gondavale','Gondavale Budruk','415521','Maharashtra','Satara'),(44,'Tuljapur','Tulja Bhavani Mandir Road','413601','Maharashtra','Dharashiv'),(45,'Pandharpur ','Pandharpur','413304','Maharashtra','Solapur'),(46,'Katra','Trikuta Hills (mountain region)','182301','Jammu and Kashmir','Reasi District'),(47,'Katra','Trikuta Hills (mountain region)','182301','Jammu and Kashmir','Reasi District'),(48,'Ganpatipule','Konkan coast','415615','Maharashtra','Ratnagiri District'),(49,'Kalyan','Ulhas River region','421301','Maharashtra','Thane District'),(50,'Extends along many regions (not a single city)','Western Ghats','NA','Maharashtra, Karnataka, Kerala, Tamil Nadu (and parts of Goa & Gujarat)','Covers multiple districts across these states'),(51,'Thiruvananthapuram','East Fort area','695023','Kerala','Thiruvananthapuram'),(52,'Jaipur','Badi Choupad / Pink City','302002','Rajasthan','Jaipur'),(53,'Mumbai','Bhuleshwar, South Mumbai','400004','Maharashtra','Mumbai City'),(55,'Akkalkot','Gangapur','413216','Maharashtra','Solapur'),(56,'Mandu','Malwa Region','454010','Madhya Pradesh','Dhar'),(57,'Abhaneri','Abhaneri Village','303326','Rajasthan','Dausa'),(58,'Cherrapunji Region','Khasi Hills','793108','Meghalaya','East Khasi Hills');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `used` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
INSERT INTO `password_reset_tokens` VALUES (1,'adishree@gmail.com','7cmAnNg1OeA-D45Xw0N18zRe9MiMKc2VgqCqem3R1jI','2026-04-27 01:20:16',0),(2,'dhanashri.keskar@cumminscollege.in','wUxMchmqhgymMoj_o3_AEqAchirNnHB4sLr3gAK1iRw','2026-04-27 11:33:38',0),(3,'gauri.kondawar@cumminscollege.in','p7yz49mk8dqd3LjHcOW4SO8Soj4dpw90PhMeeAnF0yg','2026-05-06 11:33:59',0),(4,'sanskrutikhankal@gmail.com','ARsMqQhzDIDeFHXIN4Ga9zSS5tMQXf_9c-P0eFCBVfU','2026-05-06 11:41:07',1),(5,'sanskrutikhankal@gmail.com','HkRvl7bFysKVD82-kMSP9onwGEZPruLNBsFUEtCrn-4','2026-05-06 11:49:16',0),(6,'dhanashri.keskar@cumminscollege.in','hKdk59UPU6hiCcE8cVrsFs8BAVPRh9kaI4KyKiSw72w','2026-05-06 11:54:30',1),(7,'dhanashri.keskar@cumminscollege.in','-xxNWzKd4fxVI_yEF2RU-ydJ_yV31BuO3q7QqYl4KHY','2026-05-06 12:03:46',0),(8,'dhanashri.keskar@cumminscollege.in','qc2IByDHtzHcAVb8QejUJtYdAZE2oYVW8L1g-U-xd-w','2026-05-06 12:07:08',1),(9,'adishreekulkarni13@gmail.com','Jy4hF1wdkXONbzVkcTx8u3SGAlV7I4b5-l1pTARcG1E','2026-05-06 20:21:00',1),(10,'dhanashri.keskar@cumminscollege.in','iHC5qy0sBa6AmOwDEeJOIUxa548dOG1o9eizRAcM5bQ','2026-05-07 02:01:03',1),(11,'dhanashri.keskar@cumminscollege.in','ByV1yNDMZyxdL8YTGwdUFj-KCCv7g9EM6nde626Y9yw','2026-05-07 09:20:41',1);
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_sites`
--

DROP TABLE IF EXISTS `pending_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pending_sites` (
  `Pending_ID` int NOT NULL AUTO_INCREMENT,
  `Site_Name` varchar(255) DEFAULT NULL,
  `Description` text,
  `Historical_Period` varchar(255) DEFAULT NULL,
  `UNESCO_Status` varchar(255) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `Area` varchar(100) DEFAULT NULL,
  `District` varchar(100) DEFAULT NULL,
  `State` varchar(100) DEFAULT NULL,
  `Pincode` varchar(20) DEFAULT NULL,
  `Image_Url` varchar(500) DEFAULT NULL,
  `Submitted_By` varchar(255) DEFAULT NULL,
  `Visitor_ID` int DEFAULT NULL,
  `Contribution_ID` int DEFAULT NULL,
  `submitted_at` date DEFAULT NULL,
  PRIMARY KEY (`Pending_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_sites`
--

LOCK TABLES `pending_sites` WRITE;
/*!40000 ALTER TABLE `pending_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `pending_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `Review_ID` int NOT NULL AUTO_INCREMENT,
  `Rating` int DEFAULT NULL,
  `Review_Text` text,
  `Review_Date` date DEFAULT NULL,
  `Visitor_ID` int DEFAULT NULL,
  `Site_ID` int DEFAULT NULL,
  PRIMARY KEY (`Review_ID`),
  KEY `Visitor_ID` (`Visitor_ID`),
  KEY `Site_ID` (`Site_ID`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`Visitor_ID`) REFERENCES `visitors` (`Visitor_ID`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`Site_ID`) REFERENCES `heritage_site` (`Site_ID`),
  CONSTRAINT `review_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,5,'Absolutely breathtaking! A must visit place.','2026-03-22',1,1),(2,4,'Amazing historical monument in the heart of Mumbai.','2026-03-18',2,2),(3,5,'Incredible Mughal architecture and rich history.','2026-03-15',3,3),(4,4,'Rich Maratha history preserved so beautifully.','2026-03-10',4,4),(5,5,'The caves are absolutely stunning and well preserved.','2026-03-05',1,5),(6,4,'Hampi is magical! History comes alive here.','2026-02-28',2,6),(7,5,'Every Indian must visit the Taj Mahal once.','2026-02-20',3,1),(8,4,'nice','2026-04-27',15,2),(9,5,'this place is too good & pleasent !! must visit!','2026-04-27',5,26),(10,5,'peacefull and spiritual vibes! must visit','2026-05-06',23,41);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitors`
--

DROP TABLE IF EXISTS `visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visitors` (
  `Visitor_ID` int NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone_no` varchar(15) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT '0',
  `verify_token` varchar(255) DEFAULT NULL,
  `otp` varchar(6) DEFAULT NULL,
  `otp_expires` datetime DEFAULT NULL,
  PRIMARY KEY (`Visitor_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitors`
--

LOCK TABLES `visitors` WRITE;
/*!40000 ALTER TABLE `visitors` DISABLE KEYS */;
INSERT INTO `visitors` VALUES (1,'Priya','Patel','priya@gmail.com','9876543210','$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(2,'Rahul','Sharma','rahul@gmail.com','9823456789','$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(3,'Sneha','Kallam','sneha@gmail.com','9812345678','$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(4,'Arjun','Mehta','arjun@gmail.com','9801234567','$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(5,'dhanashri ','keskar','dhanashri.keskar@cumminscollege.in',NULL,'$2b$12$dHHFrWtsgQ5U2n0SjqL7g.CGc5lFS7gKZprMc7/HB6ohwg9NMP86y',1,NULL,NULL,NULL),(6,'Prajakta','Keskar','prajakta123@gmail.com',NULL,'$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(7,'Mayuri','Keskar','Mayurigirishkeskar@gmail.com',NULL,'$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(8,'adishree','kulkarni','adishree@gmail.com',NULL,'$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(9,'gauri','kondawar','gaurikondawar1106@gmail.com',NULL,'$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(10,'Sanskruti ','Khankal','sanskruti@gmail.com',NULL,'$2b$12$ll3UtIN.slF8YwDcyNoms.0kLOqnu2qsrdpBeklUBDpfprR5io3hO',1,NULL,NULL,NULL),(11,'Kaushiki','Sharma','kaushiki@gmail.com',NULL,'$2b$12$k/D7043tuDXtty802Qykju0BYCAJhxpBce6Dm99A0w5q6Whu6IogG',1,NULL,NULL,NULL),(12,'kat','haily','katty@gmail.com',NULL,'$2b$12$QhB8OakI0o7/CeOCgzBXAu06JazXzFjWV8rPaxT2rw.ck.UG.y3Wi',1,NULL,NULL,NULL),(13,'miya','shekh','miya@gmail.com',NULL,NULL,1,NULL,NULL,NULL),(14,'siya','patel','siyaa@gmail.com',NULL,'$2b$12$1mhvREhBjtKLthl0IL1B8.vh898qE6hgH9e4kh8lmJxoyxZYj9fq.',1,NULL,NULL,NULL),(15,'gauri','kondawar','gauri@gmail.com',NULL,NULL,1,NULL,NULL,NULL),(16,'sakshi','verma','sakshi@gmail.com',NULL,'$2b$12$b7Ial/ASX8B4Q94eGuKC1.Z22DuY93DZXFyBmqtnNv0v0KV0oN3cK',1,NULL,NULL,NULL),(17,'Varad','Keskar','varad@gmail.com',NULL,NULL,1,NULL,NULL,NULL),(18,'Tejashri ','Keskar','teju@gmail.com',NULL,NULL,1,NULL,NULL,NULL),(19,'dhanashri','keskar','dukeskar0496@gmail.com',NULL,'$2b$12$b9IDHPY8GA6IMhpKvE12CeNpQtemgS4mumVmgzWhGWL/xwtcPkGdi',1,NULL,NULL,NULL),(20,'Gauri','Kondawar','gauri.kondawar@cumminscollege.in',NULL,'$2b$12$oOOl23XcPvCPOU7y2z.k4eJcPBCeLRA.tOd4KdETlhTZUSpr/riMu',1,NULL,NULL,NULL),(21,'Sanskruti','Khankal','sanskruti.khankal@cumminscollege.in',NULL,'$2b$12$SL.dmlMiXqOBdxqScnbmYOqJgFakvlAdGC46RAQyYtcKI.lyccS6q',1,NULL,NULL,NULL),(22,'Sanskruti','Khankal','sanskrutikhankal@gmail.com',NULL,'$2b$12$JBtp4SAXmt3nEARU91xyru2vHfUhI/6.nevvY1DQmNFbPSTRUbmgK',0,'J-uoQv7jaa0u_jb1hKmSnK1izFQQ0ahURSy8PJKT7Mc',NULL,NULL),(23,'Lineysha','Benare','lineysha.benare@cumminscollege.in',NULL,'$2b$12$ivA6B5n4RqTyMrFfhhlLJOybo47JKiFBQijztWkYAp2u3cshmjJkG',1,NULL,NULL,NULL),(24,'sara','khan','sara@gmail.com',NULL,NULL,0,NULL,NULL,NULL),(25,'Gauri','Kondawar','kondawargauri@gmail.com',NULL,'$2b$12$KoSNXMMQhZZjgNtFPUPy1.Ci2jrqd2BKyPS84NcCKfDvPu80rNxcG',1,NULL,NULL,NULL),(26,'Mansvi','Mor','mansvimor16@gmail.com',NULL,'$2b$12$khptAnuRzMIAlWAm4ep0KeKkbLidB2YCqWZZ47aAXb7yaOMTlCwiu',0,NULL,'487117','2026-05-06 19:58:24'),(27,'Adishree','Kulkarni','adishreekulkarni13@gmail.com',NULL,'$2b$12$B6HPF1783zQ4mXed6GdnueDovR3habaz5ERG7bqjpX640rEz.0GaG',1,NULL,NULL,NULL),(28,'Charvi','Joshi','charvisj27@gmail.com',NULL,'$2b$12$NOV7OkBzs8Wiwkim67.Wz.o7J2kE.s1kskes.uBW7lVz8oGdR751u',1,NULL,NULL,NULL),(29,'Samruddhi','Mahajan','samrudhimahajan3@gmail.com',NULL,'$2b$12$UlBLJtxWt9M7fc2CAOZmVOCodLTOvg2YNwEbnCGcBQEILPm13Q4E.',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `visitors` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-07  9:50:01
