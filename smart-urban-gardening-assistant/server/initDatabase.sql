-- MySQL dump 10.13  Distrib 8.2.0, for Win64 (x86_64)
--
-- Host: localhost    Database: db
-- ------------------------------------------------------
-- Server version	8.2.0

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
-- Table structure for table `environmentalcondition`
--

DROP TABLE IF EXISTS `environmentalcondition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `environmentalcondition` (
  `ID` int NOT NULL,
  `plantID` int DEFAULT NULL,
  `idealTempMin` int DEFAULT NULL,
  `idealTempMax` int DEFAULT NULL,
  `acceptTempMin` int DEFAULT NULL,
  `acceptTempMax` int DEFAULT NULL,
  `deficientTempMin` int DEFAULT NULL,
  `deficientTempMax` int DEFAULT NULL,
  `idealHumMin` int DEFAULT NULL,
  `idealHumMax` int DEFAULT NULL,
  `acceptHumMin` int DEFAULT NULL,
  `acceptHumMax` int DEFAULT NULL,
  `deficientHumMin` int DEFAULT NULL,
  `deficientHumMax` int DEFAULT NULL,
  `idealLightMin` int DEFAULT NULL,
  `idealLightMax` int DEFAULT NULL,
  `acceptLightMin` int DEFAULT NULL,
  `acceptLightMax` int DEFAULT NULL,
  `deficientLightMin` int DEFAULT NULL,
  `deficientLightMax` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `plantID` (`plantID`),
  CONSTRAINT `environmentalcondition_ibfk_1` FOREIGN KEY (`plantID`) REFERENCES `plant` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `environmentalcondition`
--

LOCK TABLES `environmentalcondition` WRITE;
/*!40000 ALTER TABLE `environmentalcondition` DISABLE KEYS */;
INSERT INTO `environmentalcondition` VALUES (1,1,15,25,10,30,5,35,40,70,30,80,20,90,500,2000,300,1500,100,500),(2,2,20,25,15,30,10,35,40,70,30,80,20,90,500,2000,300,1500,100,500),(3,3,18,30,15,35,10,40,50,80,30,90,20,95,500,2000,300,1500,100,500),(4,4,20,25,15,30,10,35,40,70,30,80,20,90,500,2000,300,1500,100,500),(5,5,15,25,10,30,5,35,40,70,30,80,20,90,500,2000,300,1500,100,500),(6,6,18,25,15,30,10,35,40,70,30,80,20,90,500,2000,300,1500,100,500),(7,7,15,25,10,30,5,35,40,70,30,80,20,90,500,2000,300,1500,100,500);
/*!40000 ALTER TABLE `environmentalcondition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plant`
--

DROP TABLE IF EXISTS `plant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plant` (
  `ID` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `latinName` varchar(255) DEFAULT NULL,
  `plantFamily` varchar(255) DEFAULT NULL,
  `floweringTime` varchar(255) DEFAULT NULL,
  `growthHeightMin` int DEFAULT NULL,
  `growthHeightMax` int DEFAULT NULL,
  `speciesCount` int DEFAULT NULL,
  `distribution` varchar(255) DEFAULT NULL,
  `funFact` varchar(255) DEFAULT NULL,
  `environmentalConID` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plant`
--

LOCK TABLES `plant` WRITE;
/*!40000 ALTER TABLE `plant` DISABLE KEYS */;
INSERT INTO `plant` VALUES (1,'Gänseblümchen','Bellis perennis','Korbblütler','März',4,15,15,'Mitteleuropa','kann als Salbe gegen schuppige Gesichtshaut verwendet werden',1),(2,'Kastanie','Castanea','Seifenbaumgewächse','Mai',2000,2500,20,'Eurasien und Amerika','in Zentralasien und auf der gesamten Welt gelten Esskastanien als Delikatesse',2),(3,'Mais','Zea mays','Süßgräser','Juli',100,300,5000,'Weltweit','in Mexiko wird Mais schon seit 3000 ? 5000 v. Chr. angebaut',3),(4,'Apfelbaum','Malus','Laubbaum','Mai',200,1000,40,'Weltweit','Lebensdauer beträgt etwa 100 Jahre',4),(5,'Weizen','Triticum','Süßgräser','Mai',50,100,20000,'Weltweit','Einer der ältesten Sammelpflanzen ist der Wild-Emmer',5),(6,'Rose','Rosa','Rosengewächse','Juni',50,80,3000,'Weltweit','Die Rose gilt als Symbol der Liebe',6),(7,'Brennnessel','Urtica','Brennnesselgewächse','Juni',30,120,45,'Weltweit','Brennnesselpflanzen bilden die Lebensgrundlage für über 50 Schmetterlingsarten',7);
/*!40000 ALTER TABLE `plant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `language` varchar(2) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'argjent','1234','de'),(2,'natalia','1234','de'),(3,'valon','1234','en');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userplant`
--

DROP TABLE IF EXISTS `userplant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userplant` (
  `userID` int NOT NULL,
  `plantID` int NOT NULL,
  PRIMARY KEY (`userID`,`plantID`),
  KEY `plantID` (`plantID`),
  CONSTRAINT `userplant_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`ID`),
  CONSTRAINT `userplant_ibfk_2` FOREIGN KEY (`plantID`) REFERENCES `plant` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userplant`
--

LOCK TABLES `userplant` WRITE;
/*!40000 ALTER TABLE `userplant` DISABLE KEYS */;
INSERT INTO `userplant` VALUES (1,1),(1,2),(3,2),(1,3),(2,4),(3,4),(2,5),(2,6),(3,6),(2,7);
/*!40000 ALTER TABLE `userplant` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-14 14:45:08
