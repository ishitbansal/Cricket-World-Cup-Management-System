-- MySQL dump 10.13  Distrib 8.0.31, for Linux (x86_64)
--
-- Host: localhost    Database: WORLDCUP
-- ------------------------------------------------------
-- Server version	8.0.31-0ubuntu0.22.04.1

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
-- Table structure for table `CAPTAIN`
--

DROP TABLE IF EXISTS `CAPTAIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CAPTAIN` (
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `Team_name` varchar(15) NOT NULL,
  PRIMARY KEY (`Team_name`),
  CONSTRAINT `captain_fk` FOREIGN KEY (`Team_name`) REFERENCES `TEAMS` (`Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAPTAIN`
--

LOCK TABLES `CAPTAIN` WRITE;
/*!40000 ALTER TABLE `CAPTAIN` DISABLE KEYS */;
INSERT INTO `CAPTAIN` VALUES ('Aaron','Finch','Australia'),('Virat','Kohli','India'),('Babar','Azam','Pakistan'),('Temba','Bavuma','South Africa');
/*!40000 ALTER TABLE `CAPTAIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COACH`
--

DROP TABLE IF EXISTS `COACH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COACH` (
  `Team_name` varchar(15) NOT NULL,
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `Nationality` varchar(15) NOT NULL,
  PRIMARY KEY (`Fname`,`Lname`,`Team_name`),
  KEY `coach_fk` (`Team_name`),
  CONSTRAINT `coach_fk` FOREIGN KEY (`Team_name`) REFERENCES `TEAMS` (`Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COACH`
--

LOCK TABLES `COACH` WRITE;
/*!40000 ALTER TABLE `COACH` DISABLE KEYS */;
INSERT INTO `COACH` VALUES ('Australia','Andrew','McDonald','Australian'),('South Africa','Mark','Boucher','South African'),('Pakistan','Matthew','Hayden','Australian'),('India','Rahul','Dravid','Indian');
/*!40000 ALTER TABLE `COACH` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JERSEY`
--

DROP TABLE IF EXISTS `JERSEY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `JERSEY` (
  `Team_name` varchar(15) NOT NULL,
  `Jersey_color` varchar(15) NOT NULL,
  PRIMARY KEY (`Team_name`,`Jersey_color`),
  CONSTRAINT `JERSEY_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAMS` (`Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JERSEY`
--

LOCK TABLES `JERSEY` WRITE;
/*!40000 ALTER TABLE `JERSEY` DISABLE KEYS */;
INSERT INTO `JERSEY` VALUES ('Australia','Green'),('Australia','Yellow'),('India','Blue'),('India','Orange'),('Pakistan','Dark Green'),('Pakistan','Yellow'),('South Africa','Light Green'),('South Africa','Yellow');
/*!40000 ALTER TABLE `JERSEY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MATCHES`
--

DROP TABLE IF EXISTS `MATCHES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MATCHES` (
  `Match_no` int NOT NULL,
  `Date` date NOT NULL,
  `TeamA` varchar(15) NOT NULL,
  `TeamB` varchar(15) NOT NULL,
  `Time` varchar(15) NOT NULL,
  `Stadium_name` varchar(15) NOT NULL,
  `Team_won` varchar(15) NOT NULL,
  `Man_match_fname` varchar(15) NOT NULL,
  `Man_match_lname` varchar(15) NOT NULL,
  `Umpire_fname` varchar(15) NOT NULL,
  `Umpire_lname` varchar(15) NOT NULL,
  PRIMARY KEY (`Match_no`),
  UNIQUE KEY `Date` (`Date`,`Time`),
  KEY `TeamA` (`TeamA`),
  KEY `TeamB` (`TeamB`),
  KEY `Team_won` (`Team_won`),
  KEY `Stadium_name` (`Stadium_name`),
  KEY `Umpire_fname` (`Umpire_fname`,`Umpire_lname`),
  CONSTRAINT `MATCHES_ibfk_1` FOREIGN KEY (`TeamA`) REFERENCES `TEAMS` (`Team_name`),
  CONSTRAINT `MATCHES_ibfk_2` FOREIGN KEY (`TeamB`) REFERENCES `TEAMS` (`Team_name`),
  CONSTRAINT `MATCHES_ibfk_3` FOREIGN KEY (`Team_won`) REFERENCES `TEAMS` (`Team_name`),
  CONSTRAINT `MATCHES_ibfk_4` FOREIGN KEY (`Stadium_name`) REFERENCES `STADIUM` (`Name`),
  CONSTRAINT `MATCHES_ibfk_5` FOREIGN KEY (`Umpire_fname`, `Umpire_lname`) REFERENCES `UMPIRE` (`Fname`, `Lname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MATCHES`
--

LOCK TABLES `MATCHES` WRITE;
/*!40000 ALTER TABLE `MATCHES` DISABLE KEYS */;
INSERT INTO `MATCHES` VALUES (1,'2022-11-13','India','Pakistan','Afternoon','Wankhede','India','Virat','Kohli','Marais','Erasmus'),(2,'2022-11-14','South Africa','Pakistan','Evening','Eden Gardens','South Africa','Aiden','Markram','Kumar','Dharmasena'),(3,'2022-11-16','Australia','India','Afternoon','Chinnaswamy','India','Rohit','Sharma','Paul','Reiffel'),(4,'2022-11-16','Australia','South Africa','Evening','Arun Jaitley','Australia','David','Warner','Nitin','Menon');
/*!40000 ALTER TABLE `MATCHES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLAY`
--

DROP TABLE IF EXISTS `PLAY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PLAY` (
  `Match_no` int NOT NULL,
  `Team_name` varchar(15) NOT NULL,
  `Jersey_no` int NOT NULL,
  PRIMARY KEY (`Match_no`,`Team_name`,`Jersey_no`),
  KEY `Team_name` (`Team_name`,`Jersey_no`),
  CONSTRAINT `PLAY_ibfk_1` FOREIGN KEY (`Match_no`) REFERENCES `MATCHES` (`Match_no`),
  CONSTRAINT `PLAY_ibfk_2` FOREIGN KEY (`Team_name`, `Jersey_no`) REFERENCES `PLAYERS` (`Team_name`, `Jersey_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLAY`
--

LOCK TABLES `PLAY` WRITE;
/*!40000 ALTER TABLE `PLAY` DISABLE KEYS */;
INSERT INTO `PLAY` VALUES (3,'Australia',1),(3,'Australia',2),(3,'Australia',3),(3,'Australia',4),(3,'Australia',5),(3,'Australia',6),(3,'Australia',7),(3,'Australia',8),(3,'Australia',9),(3,'Australia',10),(3,'Australia',11),(1,'India',1),(3,'India',1),(1,'India',2),(3,'India',2),(1,'India',3),(3,'India',3),(1,'India',4),(3,'India',4),(1,'India',5),(3,'India',5),(1,'India',6),(3,'India',6),(1,'India',7),(3,'India',7),(1,'India',8),(3,'India',8),(1,'India',9),(3,'India',9),(1,'India',10),(3,'India',10),(1,'India',11),(3,'India',11),(1,'Pakistan',3),(2,'Pakistan',3),(1,'Pakistan',4),(2,'Pakistan',4),(1,'Pakistan',5),(2,'Pakistan',5),(1,'Pakistan',6),(2,'Pakistan',6),(1,'Pakistan',7),(2,'Pakistan',7),(1,'Pakistan',8),(2,'Pakistan',8),(1,'Pakistan',9),(2,'Pakistan',9),(1,'Pakistan',10),(2,'Pakistan',10),(1,'Pakistan',11),(2,'Pakistan',11),(1,'Pakistan',12),(2,'Pakistan',12),(1,'Pakistan',13),(2,'Pakistan',13),(2,'South Africa',2),(2,'South Africa',3),(2,'South Africa',4),(2,'South Africa',5),(2,'South Africa',6),(2,'South Africa',7),(2,'South Africa',8),(2,'South Africa',9),(2,'South Africa',10),(2,'South Africa',11),(2,'South Africa',12);
/*!40000 ALTER TABLE `PLAY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLAYERS`
--

DROP TABLE IF EXISTS `PLAYERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PLAYERS` (
  `Team_name` varchar(15) NOT NULL,
  `Jersey_no` int NOT NULL,
  `DOB` date NOT NULL,
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `Age` int NOT NULL,
  PRIMARY KEY (`Jersey_no`,`Team_name`),
  KEY `Player_fk` (`Team_name`),
  CONSTRAINT `Player_fk` FOREIGN KEY (`Team_name`) REFERENCES `TEAMS` (`Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLAYERS`
--

LOCK TABLES `PLAYERS` WRITE;
/*!40000 ALTER TABLE `PLAYERS` DISABLE KEYS */;
INSERT INTO `PLAYERS` VALUES ('Australia',1,'1997-01-01','Aaron','Finch',25),('India',1,'1995-01-01','Virat','Kohli',27),('Australia',2,'1997-01-02','David','Warner',25),('India',2,'1995-01-02','Rohit','Sharma',27),('South Africa',2,'1996-01-01','Temba','Bavuma',26),('Australia',3,'1997-01-03','Mitchell','Marsh',25),('India',3,'1995-01-03','KL','Rahul',27),('Pakistan',3,'1994-01-12','Babar','Azam',28),('South Africa',3,'1996-01-02','Heinrich','Klaasen',26),('Australia',4,'1997-01-04','Glenn','Maxwell',25),('India',4,'1995-01-04','Suryakumar','Yadav',27),('Pakistan',4,'1994-01-13','Shadab','Khan',28),('South Africa',4,'1996-01-03','Rezza','Hendricks',26),('Australia',5,'1997-01-05','Marcus','Stoinis',25),('India',5,'1995-01-05','Hardik','Pandya',27),('Pakistan',5,'1994-01-14','Asif','Ali',28),('South Africa',5,'1996-01-04','Keshav','Maharaj',26),('Australia',6,'1997-01-06','Tim','David',25),('India',6,'1995-01-06','Rishabh','Pant',27),('Pakistan',6,'1994-01-15','Fakhar','Zaman',28),('South Africa',6,'1996-01-05','Aiden','Markram',26),('Australia',7,'1997-01-07','Mattew','Wade',25),('India',7,'1995-01-07','Bhuvneshwar','Kumar',27),('Pakistan',7,'1994-01-16','Haider','Ali',28),('South Africa',7,'1996-01-06','David','Miller',26),('Australia',8,'1997-01-08','Pat','Cummins',25),('India',8,'1995-01-08','Axar','Patel',27),('Pakistan',8,'1994-01-17','Haris','Rauf',28),('South Africa',8,'1996-01-07','Lungi','Ngidi',26),('Australia',9,'1997-01-09','Mitchell','Starc',25),('India',9,'1995-01-09','Ravichandran','Ashwin',27),('Pakistan',9,'1994-01-18','Naseem','Shah',28),('South Africa',9,'1996-01-08','Anrich','Nortje',26),('Australia',10,'1997-01-10','Josh','Hazlewood',25),('India',10,'1995-01-10','Mohammad','Shami',27),('Pakistan',10,'1994-01-19','Shaheen','Shah',28),('South Africa',10,'1996-01-09','Wayne','Parnell',26),('Australia',11,'1997-01-11','Adam','Zampa',25),('India',11,'1995-01-11','Arshdeep','Singh',27),('Pakistan',11,'1994-01-20','Shan','Masood',28),('South Africa',11,'1996-01-10','Kagiso','Rabada',26),('Pakistan',12,'1994-01-21','Mohammad','Nawaz',28),('South Africa',12,'1996-01-11','Tabraiz','Shamsi',26),('Pakistan',13,'1994-01-22','Mohammad','Rizwan',28);
/*!40000 ALTER TABLE `PLAYERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRACTICE`
--

DROP TABLE IF EXISTS `PRACTICE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PRACTICE` (
  `Stadium_name` varchar(15) NOT NULL,
  `Team_name` varchar(15) NOT NULL,
  `Jersey_no` int NOT NULL,
  PRIMARY KEY (`Stadium_name`,`Team_name`,`Jersey_no`),
  KEY `Team_name` (`Team_name`,`Jersey_no`),
  CONSTRAINT `PRACTICE_ibfk_1` FOREIGN KEY (`Stadium_name`) REFERENCES `STADIUM` (`Name`),
  CONSTRAINT `PRACTICE_ibfk_2` FOREIGN KEY (`Team_name`, `Jersey_no`) REFERENCES `PLAYERS` (`Team_name`, `Jersey_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRACTICE`
--

LOCK TABLES `PRACTICE` WRITE;
/*!40000 ALTER TABLE `PRACTICE` DISABLE KEYS */;
INSERT INTO `PRACTICE` VALUES ('Arun Jaitley','Australia',1),('Chinnaswamy','Australia',1),('Arun Jaitley','Australia',2),('Chinnaswamy','Australia',2),('Arun Jaitley','Australia',3),('Chinnaswamy','Australia',3),('Arun Jaitley','Australia',4),('Chinnaswamy','Australia',4),('Arun Jaitley','Australia',5),('Chinnaswamy','Australia',5),('Arun Jaitley','Australia',6),('Chinnaswamy','Australia',6),('Arun Jaitley','Australia',7),('Chinnaswamy','Australia',7),('Arun Jaitley','Australia',8),('Chinnaswamy','Australia',8),('Arun Jaitley','Australia',9),('Chinnaswamy','Australia',9),('Arun Jaitley','Australia',10),('Chinnaswamy','Australia',10),('Arun Jaitley','Australia',11),('Chinnaswamy','Australia',11),('Chinnaswamy','India',1),('Wankhede','India',1),('Chinnaswamy','India',2),('Wankhede','India',2),('Chinnaswamy','India',3),('Wankhede','India',3),('Chinnaswamy','India',4),('Wankhede','India',4),('Chinnaswamy','India',5),('Wankhede','India',5),('Chinnaswamy','India',6),('Wankhede','India',6),('Chinnaswamy','India',7),('Wankhede','India',7),('Chinnaswamy','India',8),('Wankhede','India',8),('Chinnaswamy','India',9),('Wankhede','India',9),('Chinnaswamy','India',10),('Wankhede','India',10),('Chinnaswamy','India',11),('Wankhede','India',11),('Eden Gardens','Pakistan',3),('Wankhede','Pakistan',3),('Eden Gardens','Pakistan',4),('Wankhede','Pakistan',4),('Eden Gardens','Pakistan',5),('Wankhede','Pakistan',5),('Eden Gardens','Pakistan',6),('Wankhede','Pakistan',6),('Eden Gardens','Pakistan',7),('Wankhede','Pakistan',7),('Eden Gardens','Pakistan',8),('Wankhede','Pakistan',8),('Eden Gardens','Pakistan',9),('Wankhede','Pakistan',9),('Eden Gardens','Pakistan',10),('Wankhede','Pakistan',10),('Eden Gardens','Pakistan',11),('Wankhede','Pakistan',11),('Eden Gardens','Pakistan',12),('Wankhede','Pakistan',12),('Eden Gardens','Pakistan',13),('Wankhede','Pakistan',13),('Arun Jaitley','South Africa',2),('Eden Gardens','South Africa',2),('Arun Jaitley','South Africa',3),('Eden Gardens','South Africa',3),('Arun Jaitley','South Africa',4),('Eden Gardens','South Africa',4),('Arun Jaitley','South Africa',5),('Eden Gardens','South Africa',5),('Arun Jaitley','South Africa',6),('Eden Gardens','South Africa',6),('Arun Jaitley','South Africa',7),('Eden Gardens','South Africa',7),('Arun Jaitley','South Africa',8),('Eden Gardens','South Africa',8),('Arun Jaitley','South Africa',9),('Eden Gardens','South Africa',9),('Arun Jaitley','South Africa',10),('Eden Gardens','South Africa',10),('Arun Jaitley','South Africa',11),('Eden Gardens','South Africa',11),('Arun Jaitley','South Africa',12),('Eden Gardens','South Africa',12);
/*!40000 ALTER TABLE `PRACTICE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STADIUM`
--

DROP TABLE IF EXISTS `STADIUM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STADIUM` (
  `Name` varchar(15) NOT NULL,
  `Location` varchar(15) NOT NULL,
  `Area` int DEFAULT NULL,
  PRIMARY KEY (`Name`),
  UNIQUE KEY `Location` (`Location`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STADIUM`
--

LOCK TABLES `STADIUM` WRITE;
/*!40000 ALTER TABLE `STADIUM` DISABLE KEYS */;
INSERT INTO `STADIUM` VALUES ('Arun Jaitley','Delhi',16),('Chinnaswamy','Bangalore',14),('Eden Gardens','Kolkata',15),('Wankhede','Mumbai',13);
/*!40000 ALTER TABLE `STADIUM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STATISTICS`
--

DROP TABLE IF EXISTS `STATISTICS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `STATISTICS` (
  `Team_name` varchar(15) NOT NULL,
  `Jersey_no` int NOT NULL,
  `Wickets_taken` int DEFAULT NULL,
  `Runs_conceived` int DEFAULT NULL,
  `Balls_bowled` int DEFAULT NULL,
  `Balls_played` int DEFAULT NULL,
  `Max_runs` int DEFAULT NULL,
  `Total_runs` int DEFAULT NULL,
  PRIMARY KEY (`Jersey_no`,`Team_name`),
  KEY `statistics_fk` (`Team_name`),
  CONSTRAINT `statistics_fk` FOREIGN KEY (`Team_name`) REFERENCES `TEAMS` (`Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STATISTICS`
--

LOCK TABLES `STATISTICS` WRITE;
/*!40000 ALTER TABLE `STATISTICS` DISABLE KEYS */;
INSERT INTO `STATISTICS` VALUES ('Australia',1,NULL,NULL,NULL,9,4,4),('India',1,NULL,NULL,NULL,60,100,95),('Australia',2,NULL,NULL,NULL,12,18,18),('India',2,NULL,NULL,NULL,20,15,25),('South Africa',2,NULL,NULL,NULL,60,40,70),('Australia',3,0,6,13,24,39,39),('India',3,NULL,NULL,NULL,40,50,80),('Pakistan',3,NULL,NULL,NULL,20,18,16),('South Africa',3,NULL,NULL,NULL,20,15,25),('Australia',4,1,12,18,30,59,59),('India',4,NULL,NULL,NULL,50,50,90),('Pakistan',4,2,48,80,32,51,31),('South Africa',4,NULL,NULL,NULL,20,10,20),('Australia',5,1,12,17,16,39,39),('India',5,NULL,NULL,NULL,30,40,60),('Pakistan',5,NULL,NULL,NULL,12,11,10),('South Africa',5,4,45,24,15,10,20),('Australia',6,NULL,NULL,NULL,10,20,20),('India',6,NULL,NULL,NULL,20,10,20),('Pakistan',6,NULL,NULL,NULL,17,23,16),('South Africa',6,NULL,NULL,NULL,40,50,80),('Australia',7,NULL,NULL,NULL,15,23,23),('India',7,6,65,48,5,5,8),('Pakistan',7,NULL,NULL,NULL,11,10,7),('South Africa',7,NULL,NULL,NULL,30,40,60),('Australia',8,2,24,31,4,6,6),('India',8,4,45,48,15,10,20),('Pakistan',8,3,48,65,13,18,15),('South Africa',8,6,40,24,5,5,8),('Australia',9,1,18,37,NULL,NULL,NULL),('India',9,6,60,48,13,18,20),('Pakistan',9,2,48,68,12,8,6),('South Africa',9,9,30,24,4,2,5),('Australia',10,1,24,35,NULL,NULL,NULL),('India',10,9,55,48,4,2,5),('Pakistan',10,3,48,64,9,12,12),('South Africa',10,5,25,12,10,13,20),('Australia',11,1,24,32,NULL,NULL,NULL),('India',11,10,50,48,3,1,2),('Pakistan',11,NULL,NULL,NULL,50,71,44),('South Africa',11,10,40,24,3,1,2),('Pakistan',12,2,48,75,28,37,25),('South Africa',12,6,20,12,13,18,20),('Pakistan',13,NULL,NULL,NULL,36,46,29);
/*!40000 ALTER TABLE `STATISTICS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEAMS`
--

DROP TABLE IF EXISTS `TEAMS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `TEAMS` (
  `Team_name` varchar(15) NOT NULL,
  `Matches_won` int DEFAULT '0',
  PRIMARY KEY (`Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAMS`
--

LOCK TABLES `TEAMS` WRITE;
/*!40000 ALTER TABLE `TEAMS` DISABLE KEYS */;
INSERT INTO `TEAMS` VALUES ('Australia',0),('India',2),('Pakistan',0),('South Africa',1);
/*!40000 ALTER TABLE `TEAMS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UMPIRE`
--

DROP TABLE IF EXISTS `UMPIRE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UMPIRE` (
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `Nationality` varchar(15) NOT NULL,
  PRIMARY KEY (`Fname`,`Lname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UMPIRE`
--

LOCK TABLES `UMPIRE` WRITE;
/*!40000 ALTER TABLE `UMPIRE` DISABLE KEYS */;
INSERT INTO `UMPIRE` VALUES ('Kumar','Dharmasena','Sri Lankan'),('Marais','Erasmus','South African'),('Nitin','Menon','Indian'),('Paul','Reiffel','Australian');
/*!40000 ALTER TABLE `UMPIRE` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-16  0:03:28
