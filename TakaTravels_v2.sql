
CREATE DATABASE  IF NOT EXISTS `TakaTravels` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `TakaTravels`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: cs336.ckksjtjg2jto.us-east-2.rds.amazonaws.com    Database: BarBeerDrinkerSample
-- ------------------------------------------------------
-- Server version	5.6.35-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;



--
-- Table structure for table `account`
--
DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `type`  int NOT NULL DEFAULT 0,
  `lastname` varchar(50) NOT NULL default "", /* there was a question on piazza that said these should be here idk */
  `firstname` varchar(50) NOT NULL default "",
  `ID#` int,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/* no reservation attribute or table because it can be retrieved by searching buy */

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('admin','admin',1, 'admin', 'admin', 545),('reps','reps',2, 'reps', 'reps', 434),('user1', 'user1', 0, 'ree','ree', 546),('user2', 'user2', 0, 'reee','reee', 894);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Questions`;
CREATE TABLE `Questions` (
  `questionNum` int NOT NULL,
  `Question` varchar(300),
  `Answer` varchar(300) DEFAULT 'N/A',
  `username` varchar(50) NOT NULL,
  PRIMARY KEY (`questionNum`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/* this is somewhat how the Q&A functionality was described. no calls table. */
LOCK TABLES `Questions` WRITE;
/*!40000 ALTER TABLE `Questions` DISABLE KEYS */;
INSERT INTO `Questions` VALUES (00001, 'is taka sussy?', DEFAULT ,'user1'), (00002, 'is taka onii-chan sugoi?', DEFAULT, 'user1'), (00003, 'how is Moeez so cool?', DEFAULT, 'user2'), (00004, 'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee', DEFAULT, 'user2');
/*!40000 ALTER TABLE `Questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buy`
--

DROP TABLE IF EXISTS `buy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buy` (
  `username` varchar(50) NOT NULL,
  `ticketNum` int NOT NULL,
  `purchaseDate` date,  /* <<< */
  `purchaseTime` time, /* ^thought these should be stored in purchases table and not in tickets lmk */
  PRIMARY KEY (`username`,`ticketNum`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`),
  FOREIGN KEY (`ticketNum`) REFERENCES `flightticketfor` (`ticketNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `buy` VALUES ('user1', 0001, '1776-07-04', '23:59'), ('user1', 0002, '1766-11-10', '01:37'), ('user1', 0003, '2020-11-30', '21:14'), ('user1', 0004, '2020-01-06', '17:14'), ('user2', 0005, '2020-11-30', '21:14'), ('user2', 0006, '2020-09-30', '05:55'), ('user2', 0007, '2020-03-06', '13:52'), ('user2', 0008, '2020-05-21', '09:10');
--
-- Table structure for table `waits`
--

DROP TABLE IF EXISTS `waits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waits` (
  `username` varchar(50) NOT NULL DEFAULT '',
  `ticketNum` int NOT NULL DEFAULT 0,

  PRIMARY KEY (`username`,`ticketNum`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`),
  FOREIGN KEY (`ticketNum`) REFERENCES `flightticketfor` (`ticketNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
--
-- Table structure for table `flightticketfor`
--
/* didnt make any test data for this because im thinking we could put someone on a waitng list for all the tickets for a flight between two airports when there are none and that should be done through a query on the tickets */


DROP TABLE IF EXISTS `flightticketfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flightticketfor` (
  `ticketNum` int NOT NULL,
  `seatNum` int NOT NULL,
  `totalFare` float NOT NULL,
  `bookingFee` float NOT NULL,
  `class` int NOT NULL, /*0:economy, 1:business, 2:first*/
  `type` int NOT NULL, /* 0:round trip, 1: one way */
  `from` varchar(5) NOT NULL,
  `to` varchar(5) NOT NULL,
  `twoLetID` varchar(2) NOT NULL,
  `AircraftID` int NOT NULL,
  `flightNum` int NOT NULL,

  
  PRIMARY KEY (`ticketNum`),
  FOREIGN KEY (`twoLetID`, `AircraftID`, `flightNum`) 
  REFERENCES `flightBy` (`twoLetID`,`AircraftID`,`flightNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `flightticketfor` WRITE;
/*!40000 ALTER TABLE `flightticketfor` DISABLE KEYS */;
INSERT INTO `flightticketfor` VALUES (0001, 01, 999999.99, 1000.00, 0, 0, 'EWR', 'LAX', 'AA', 001, 0001), (0002, 02, 999999.99, 1000.00, 0, 0, 'EWR', 'LAX', 'AA', 001, 0001), (0003, 03, 999999.99, 1000.00, 0, 0, 'EWR', 'LAX', 'AA', 001, 0001), (0004, 04, 999999.99, 1000.00, 0, 0, 'EWR', 'LAX', 'AA', 001, 0001),
(0005, 05, 9999999.99, 1000.00, 2, 0, 'EWR', 'LAX', 'AA', 001, 0001), (0006, 06, 9999999.99, 1000.00, 2, 0, 'EWR', 'LAX', 'AA', 001, 0001), (0007, 07, 9999999.99, 1000.00, 2, 0, 'EWR', 'LAX', 'AA', 001, 0001), (0008, 08, 9999999.99, 1000.00, 2, 0, 'EWR', 'LAX', 'AA', 001, 0001);
/*!40000 ALTER TABLE `flightticketfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airlineCompany`
--

DROP TABLE IF EXISTS `airlineCompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airlineCompany` (
  `twoLetID` varchar(2) NOT NULL DEFAULT '',
  PRIMARY KEY (`twoLetID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `airlineCompany` WRITE;
/*!40000 ALTER TABLE `airlineCompany` DISABLE KEYS */;
INSERT INTO `airlineCompany` VALUES ('AA'),('DL'),('UA'),('WN');
/*!40000 ALTER TABLE `airlineCompany` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aircraft` (
  `twoLetID` varchar(2) NOT NULL,
  `AircraftID` int NOT NULL,
  `seats` varchar(10) NOT NULL ,
  `operatingDays` varchar(50) NOT NULL, /* have some ideas on how to do this but we'll talk about that later. isnt really that important i think so its alright for now. */

  
  PRIMARY KEY (`twoLetID`,`AircraftID`),
  FOREIGN KEY (`twoLetID`) 
  REFERENCES `airlineCompany` (`twoLetID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES ('AA', 001, 8, 'SMTWTFS'), ('DL', 001, 8, 'SMTWTFS'), ('UA', 001, 8, 'SMTWTFS'), ('WN', 001, 8, 'SMTWTFS');
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;




--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `airport` (
  `threeLetID` varchar(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`threeLetID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('EWR'),('LGA'),('JFK'), ('LAX');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `flightBy`
--

DROP TABLE IF EXISTS `flightBy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flightBy` (
  `flightNum` int NOT NULL,
  `twoLetID` varchar(2) NOT NULL,
  `AircraftID` int NOT NULL,
  `fromAirport` varchar(50) NOT NULL,
  `toAirport` varchar(50) NOT NULL,
  `departureDate` date NOT NULL,
  `arrivalDate` date NOT NULL,
  `type` int NOT NULL DEFAULT 0, /* 0:domestic, 1: international. one-way/round in ticket lmk */
  PRIMARY KEY (`twoLetID`,`AircraftID`,`flightNum`),
  FOREIGN KEY (`twoLetID`,`AircraftID`) 
  REFERENCES `aircraft` (`twoLetID`,`AircraftID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `flightBy` WRITE;
/*!40000 ALTER TABLE `flightBy` DISABLE KEYS */;
INSERT INTO `flightBy` VALUES (0001, 'AA', 001, 'EWR', 'LAX', '2021-11-20', '2021-11-21', 0);
/*!40000 ALTER TABLE `flightBy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operates`
--

DROP TABLE IF EXISTS `operates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operates` (
  `threeLetID` varchar(3) NOT NULL,
  `twoLetID` varchar(2) NOT NULL,
  PRIMARY KEY (`threeLetID`,`twoLetID`),
  FOREIGN KEY (`threeLetID`) REFERENCES `airport` (`threeLetID`),
  FOREIGN KEY (`twoLetID`) REFERENCES `airlineCompany` (`twoLetID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
LOCK TABLES `operates` WRITE;
/*!40000 ALTER TABLE `operates` DISABLE KEYS */;
INSERT INTO `operates` VALUES ('EWR', 'AA'), ('EWR', 'DL'), ('EWR', 'UA'), ('EWR', 'WN'), ('LGA', 'AA'), ('LGA', 'DL'), ('LGA', 'UA'), ('LGA', 'WN'), ('JFK', 'AA'), ('JFK', 'DL'), ('JFK', 'UA'), ('JFK', 'WN'),
('LAX', 'AA'), ('LAX', 'DL'), ('LAX', 'UA'), ('LAX', 'WN');
/*!40000 ALTER TABLE `operates` ENABLE KEYS */;
UNLOCK TABLES;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-10 13:49:53