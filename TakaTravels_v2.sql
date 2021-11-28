
CREATE DATABASE  IF NOT EXISTS `TakaTravels` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `TakaTravels`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: cs336.ckksjtjg2jto.us-east-2.rds.amazonaws.com    Database: TakaTravels
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
  `questionNum` int NOT NULL auto_increment,
  `Question` varchar(300),
  `Answer` varchar(300) DEFAULT 'Not yet answered.',
  `username` varchar(50) NOT NULL,
  PRIMARY KEY (`questionNum`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/* this is somewhat how the Q&A functionality was described. no calls table. */
LOCK TABLES `Questions` WRITE;
/*!40000 ALTER TABLE `Questions` DISABLE KEYS */;
INSERT INTO `Questions` (`Question`,`Answer`,`username`) VALUES 
	('How do I book a flight?', DEFAULT , 'Anonymous'),
    ('How can I choose the cheapest flight?', DEFAULT , 'Anonymous'),
    ('Do I need to pay a fee to cancel my flight?', 'If you bought an economy ticket, you must pay a fee to change your ticket. However, if you bought a business or first class ticket, you may change your ticket without a fee.' , 'Anonymous'),
    ('When will I know if I am off the waiting list?', DEFAULT , 'Anonymous'),
    ('What can I do if I don’t have a specific departure date?', 'Select the "flexible" option when selecting a date for departure.' , 'Anonymous');
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
  `ticketNum` int NOT NULL AUTO_INCREMENT,
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
INSERT INTO `flightticketfor` VALUES 
(NULL, 1, 150.00, 25.00, 0, 0, 'EWR', 'LAX', 'AA', 1, 1), 
(NULL, 2, 400.00, 25.00, 1, 0, 'EWR', 'LAX', 'AA', 1, 1), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'EWR', 'LAX', 'AA', 1, 1),
(NULL, 1, 150.00, 25.00, 0, 0, 'LAX', 'EWR', 'AA', 1, 2), 
(NULL, 2, 400.00, 25.00, 1, 0, 'LAX', 'EWR', 'AA', 1, 2), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'LAX', 'EWR', 'AA', 1, 2),
(NULL, 1, 150.00, 25.00, 0, 0, 'JFK', 'LAX', 'AA', 1, 3), 
(NULL, 2, 400.00, 25.00, 1, 0, 'JFK', 'LAX', 'AA', 1, 3), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'JFK', 'LAX', 'AA', 1, 3),
(NULL, 1, 150.00, 25.00, 0, 0, 'LAX', 'JFK', 'AA', 1, 4), 
(NULL, 2, 400.00, 25.00, 1, 0, 'LAX', 'JFK', 'AA', 1, 4), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'LAX', 'JFK', 'AA', 1, 4),

(NULL, 1, 150.00, 25.00, 0, 0, 'EWR', 'LAX', 'DL', 1, 5), 
(NULL, 2, 400.00, 25.00, 1, 0, 'EWR', 'LAX', 'DL', 1, 5), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'EWR', 'LAX', 'DL', 1, 5),
(NULL, 1, 150.00, 25.00, 0, 0, 'LAX', 'EWR', 'DL', 1, 6), 
(NULL, 2, 400.00, 25.00, 1, 0, 'LAX', 'EWR', 'DL', 1, 6), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'LAX', 'EWR', 'DL', 1, 6),
(NULL, 1, 150.00, 25.00, 0, 0, 'JFK', 'LAX', 'DL', 1, 7), 
(NULL, 2, 400.00, 25.00, 1, 0, 'JFK', 'LAX', 'DL', 1, 7), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'JFK', 'LAX', 'DL', 1, 7),
(NULL, 1, 150.00, 25.00, 0, 0, 'LAX', 'JFK', 'DL', 1, 8), 
(NULL, 2, 400.00, 25.00, 1, 0, 'LAX', 'JFK', 'DL', 1, 8), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'LAX', 'JFK', 'DL', 1, 8),

(NULL, 1, 150.00, 25.00, 0, 0, 'EWR', 'LAX', 'UA', 1, 9), 
(NULL, 2, 400.00, 25.00, 1, 0, 'EWR', 'LAX', 'UA', 1, 9), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'EWR', 'LAX', 'UA', 1, 9),
(NULL, 1, 150.00, 25.00, 0, 0, 'LAX', 'EWR', 'UA', 1, 10), 
(NULL, 2, 400.00, 25.00, 1, 0, 'LAX', 'EWR', 'UA', 1, 10), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'LAX', 'EWR', 'UA', 1, 10),
(NULL, 1, 150.00, 25.00, 0, 0, 'JFK', 'LAX', 'UA', 1, 11), 
(NULL, 2, 400.00, 25.00, 1, 0, 'JFK', 'LAX', 'UA', 1, 11), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'JFK', 'LAX', 'UA', 1, 11),
(NULL, 1, 150.00, 25.00, 0, 0, 'LAX', 'JFK', 'UA', 1, 12), 
(NULL, 2, 400.00, 25.00, 1, 0, 'LAX', 'JFK', 'UA', 1, 12), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'LAX', 'JFK', 'UA', 1, 12),

(NULL, 1, 150.00, 25.00, 0, 0, 'EWR', 'LAX', 'WN', 1, 13), 
(NULL, 2, 400.00, 25.00, 1, 0, 'EWR', 'LAX', 'WN', 1, 13), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'EWR', 'LAX', 'WN', 1, 13),
(NULL, 1, 150.00, 25.00, 0, 0, 'LAX', 'EWR', 'WN', 1, 14), 
(NULL, 2, 400.00, 25.00, 1, 0, 'LAX', 'EWR', 'WN', 1, 14), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'LAX', 'EWR', 'WN', 1, 14),
(NULL, 1, 150.00, 25.00, 0, 0, 'JFK', 'LAX', 'WN', 1, 15), 
(NULL, 2, 400.00, 25.00, 1, 0, 'JFK', 'LAX', 'WN', 1, 15), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'JFK', 'LAX', 'WN', 1, 15),
(NULL, 1, 150.00, 25.00, 0, 0, 'LAX', 'JFK', 'WN', 1, 16), 
(NULL, 2, 400.00, 25.00, 1, 0, 'LAX', 'JFK', 'WN', 1, 16), 
(NULL, 3, 1000.00, 25.00, 2, 0, 'LAX', 'JFK', 'WN', 1, 16)
;









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
  `takeoff` time NOT NULL,
  `landing` time NOT NULL,
  `numStop` int NOT NULL,
  
  PRIMARY KEY (`twoLetID`,`AircraftID`,`flightNum`),
  FOREIGN KEY (`twoLetID`,`AircraftID`) 
  REFERENCES `aircraft` (`twoLetID`,`AircraftID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
LOCK TABLES `flightBy` WRITE;
/*!40000 ALTER TABLE `flightBy` DISABLE KEYS */;
INSERT INTO `flightBy` VALUES 
(1, 'AA', 1, 'EWR', 'LAX', '2022-1-1', '2022-1-2', 0, '5:00', '11:00',4),
(2, 'AA', 1, 'LAX', 'EWR', '2022-1-3', '2022-1-4', 0, '5:00', '10:00',4),
(3, 'AA', 1, 'JFK', 'LAX', '2022-1-1', '2022-1-2', 0, '8:00', '13:00',4),
(4, 'AA', 1, 'LAX', 'JFK', '2022-1-3', '2022-1-4', 0, '12:00', '17:00',5),

(5, 'DL', 1, 'EWR', 'LAX', '2022-1-1', '2022-1-2', 0, '4:30', '8:00',2),
(6, 'DL', 1, 'LAX', 'EWR', '2022-1-3', '2022-1-4', 0, '8:00', '13:00',2),
(7, 'DL', 1, 'JFK', 'LAX', '2022-1-1', '2022-1-2', 0, '20:00', '1:00',3),
(8, 'DL', 1, 'LAX', 'JFK', '2022-1-3', '2022-1-4', 0, '15:00', '20:00',3),

(9, 'UA', 1, 'EWR', 'LAX', '2022-1-1', '2022-1-3', 0, '8:00', '15:00',2),
(10, 'UA', 1, 'LAX', 'EWR', '2022-1-3', '2022-1-4', 0, '7:00', '12:00',2),
(11, 'UA', 1, 'JFK', 'LAX', '2022-1-1', '2022-1-2', 0, '13:00', '18:00',3),
(12, 'UA', 1, 'LAX', 'JFK', '2022-1-3', '2022-1-4', 0, '12:00', '17:00',2),

(13, 'WN', 1, 'EWR', 'LAX', '2022-1-1', '2022-1-1', 0, '11:00', '16:00', 1),
(14, 'WN', 1, 'LAX', 'EWR', '2022-1-3', '2022-1-4', 0, '6:00', '11:00', 2),
(15, 'WN', 1, 'JFK', 'LAX', '2022-1-1', '2022-1-2', 0, '15:00', '20:00', 2),
(16, 'WN', 1, 'LAX', 'JFK', '2022-1-3', '2022-1-4', 0, '13:00', '18:00',2)
;
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
