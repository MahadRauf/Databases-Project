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
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES ('admin','admin',1),('reps','reps',2);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `username` varchar(50) NOT NULL,
  `reservation` varchar(50) DEFAULT '',
  /* removed type cause that is in account, or maybe put type here and remove it from account*/
  PRIMARY KEY (`username`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `buy`
--

DROP TABLE IF EXISTS `buy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buy` (
  `username` varchar(50) NOT NULL, /* i removed the default cause it'd just allow empty accounts, but mayeb we could add some kind of default username for when people arent logged in */
  `ticketNum` int NOT NULL,
  PRIMARY KEY (`username`,`ticketNum`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`),
  FOREIGN KEY (`ticketNum`) REFERENCES `flightticketfor` (`ticketNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `change`
--

DROP TABLE IF EXISTS `change`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change` (
  `username` varchar(50) NOT NULL,
  `ticketNum` int NOT NULL,
  PRIMARY KEY (`username`,`ticketNum`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`),
  FOREIGN KEY (`ticketNum`) REFERENCES `flightticketfor` (`ticketNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search`
--

DROP TABLE IF EXISTS `search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search` (
  `username` varchar(50) NOT NULL,
  `ticketNum` int NOT NULL,
  `date` date NOT NULL,
  `isflexible` int NOT NULL DEFAULT 0,
  
  PRIMARY KEY (`username`,`ticketNum`),
  FOREIGN KEY (`username`) REFERENCES `account` (`username`),
  FOREIGN KEY (`ticketNum`) REFERENCES `flightticketfor` (`ticketNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `enter`
--

DROP TABLE IF EXISTS `enter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enter` (
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

DROP TABLE IF EXISTS `flightticketfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flightticketfor` (
  `ticketNum` int NOT NULL DEFAULT 0,
  `idNum` int NOT NULL DEFAULT 0,
  `flightNum` int NOT NULL DEFAULT 0,
  `seatNum` int NOT NULL DEFAULT 0,
  `timePurchased` varchar(50) NOT NULL DEFAULT '',
  `lastName` varchar(50) NOT NULL DEFAULT '',
  `firstName` varchar(50) NOT NULL DEFAULT '',
  `totalFare` float NOT NULL DEFAULT 0,
  `bookingFee` float NOT NULL DEFAULT 0,
  `hasFee` float NOT NULL DEFAULT 0,
  `twoLetID` varchar(2) NOT NULL DEFAULT '',
  `seats` varchar(10) NOT NULL DEFAULT '',
  `operatingDays` varchar(50) NOT NULL DEFAULT '',

  
  PRIMARY KEY (`ticketNum`),
  FOREIGN KEY (`twoLetID`,`seats`,`operatingDays`,`flightNum`) 
  REFERENCES `flightBy` (`twoLetID`,`seats`,`operatingDays`,`flightNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `waitingList`
--

DROP TABLE IF EXISTS `waitingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waitingList` (
  `ticketNum` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`ticketNum`),
  FOREIGN KEY (`ticketNum`) REFERENCES `flightticketfor` (`ticketNum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


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



--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aircraft` (
  `twoLetID` varchar(2) NOT NULL DEFAULT '',
  `seats` varchar(10) NOT NULL DEFAULT '',
  `operatingDays` varchar(50) NOT NULL DEFAULT '',

  
  PRIMARY KEY (`twoLetID`,`seats`,`operatingDays`),
  FOREIGN KEY (`twoLetID`) 
  REFERENCES `airlineCompany` (`twoLetID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;




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




--
-- Table structure for table `flightBy`
--

DROP TABLE IF EXISTS `flightBy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flightBy` (
  `flightNum` int NOT NULL DEFAULT 0,
  `twoLetID` varchar(2) NOT NULL DEFAULT '',
  `seats` varchar(10) NOT NULL DEFAULT '',
  `operatingDays` varchar(50) NOT NULL DEFAULT '',
  `fromAirport` varchar(50) NOT NULL DEFAULT '',
  `toAirport` varchar(50) NOT NULL DEFAULT '',
  `departureDate` date NOT NULL,
  `isDomestic` int NOT NULL DEFAULT 0,
  `isOneWay` int NOT NULL DEFAULT 0,
  `price` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`twoLetID`,`seats`,`operatingDays`,`flightNum`),
  FOREIGN KEY (`twoLetID`,`seats`,`operatingDays`) 
  REFERENCES `aircraft` (`twoLetID`,`seats`,`operatingDays`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `operates`
--

DROP TABLE IF EXISTS `operates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operates` (
  `threeLetID` varchar(3) NOT NULL DEFAULT '',
  `twoLetID` varchar(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`threeLetID`,`twoLetID`),
  FOREIGN KEY (`threeLetID`) REFERENCES `airport` (`threeLetID`),
  FOREIGN KEY (`twoLetID`) REFERENCES `airlineCompany` (`twoLetID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;



/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-10 13:49:53
