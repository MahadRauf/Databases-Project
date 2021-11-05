CREATE DATABASE  IF NOT EXISTS `BarBeerDrinkerSample` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `BarBeerDrinkerSample`;
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
-- Table structure for table `bars`
--

DROP TABLE IF EXISTS `bars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bars` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `license` varchar(7) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bars`
--

LOCK TABLES `bars` WRITE;
/*!40000 ALTER TABLE `bars` DISABLE KEYS */;
INSERT INTO `bars` VALUES ('A.P. Stump\'s','MA12347','Boston',NULL,NULL),('Blue Angel','CA45678','San Francisco',NULL,NULL),('Blue Tattoo','CA45678','San Francisco','415-567-1289','1500 Market St.'),('Britannia Arms','MA12346','Boston','345-567-1289',NULL),('Cabana','CA45678','San Francisco',NULL,'1200 California Ave.'),('Caravan','IL12345','Chicago',NULL,NULL),('Club 175','CA45678','San Francisco','415-567-1289',NULL),('Coconut Willie\'s Cocktail Lounge','CA45678','San Francisco','415-567-1289',NULL),('Eulipia','IL12346','Chicago','123-456-7890','1060 West Addison'),('Gecko Grill','IL12348','Chicago',NULL,'1060 West Addison'),('Giza Hookah Lounge','IL12349','Chicago','345-678-9012',NULL),('Hedley Club','NY12345','New York',NULL,'161st St and River Ave'),('Il Fornaio','NY12346','New York',NULL,'161st St and River Ave'),('Seven Bamboo','NY12347','New York',NULL,'161st St and River Ave'),('The B-Hive','MA12348','Boston','345-567-1280',NULL),('The Backbeat','CA45678','San Francisco','415-567-1289',NULL),('The Blank Club','MA12349','Boston','345-567-1281',NULL),('The Shark and Rose','MA12345','Boston',NULL,NULL);
/*!40000 ALTER TABLE `bars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `beers`
--

DROP TABLE IF EXISTS `beers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `beers` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `manf` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `beers`
--

LOCK TABLES `beers` WRITE;
/*!40000 ALTER TABLE `beers` DISABLE KEYS */;
INSERT INTO `beers` VALUES ('Blue Moon','Coors Brewing Company'),('Budweiser','Anheuser-Busch'),('Creamy Dark','Jacob Leinenkugel Brewing Company'),('Extra Gold','Coors Brewing Company'),('Hefeweizen','Jacob Leinenkugel Brewing Company'),('Hefeweizen Doppelbock','Jacob Leinenkugel Brewing Company'),('Heiniken','Heiniken Inernational'),('ICEHOUSE','Plank Road Brewery'),('Killian\'s','Coors Brewing Company'),('Michelob Amber Bock','Anheuser-Busch'),('Michelob Golden Draft','Anheuser-Busch'),('Michelob Golden Draft Light','Anheuser-Busch'),('Michelob ULTRA','Anheuser-Busch'),('Original Premium','Jacob Leinenkugel Brewing Company'),('Original Premium Lager','Jacob Leinenkugel Brewing Company'),('Original Premium Lager Dog','Plank Road Brewery'),('Sauza Diablo','Miller Brewing Company'),('Southpaw Light','Plank Road Brewery'),('Stolichnaya Citrona','Miller Brewing Company'),('Zima','Coors Brewing Company'),('Zima Citrus','Coors Brewing Company');
/*!40000 ALTER TABLE `beers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drinkers`
--

DROP TABLE IF EXISTS `drinkers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drinkers` (
  `name` varchar(50) NOT NULL DEFAULT '',
  `city` varchar(50) DEFAULT NULL,
  `phone` varchar(12) DEFAULT NULL,
  `addr` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drinkers`
--

LOCK TABLES `drinkers` WRITE;
/*!40000 ALTER TABLE `drinkers` DISABLE KEYS */;
INSERT INTO `drinkers` VALUES ('Bob','San Francisco','415-234-6789',NULL),('Erik','San Francisco','415-234-6789',NULL),('Herb','Boston',NULL,NULL),('Jesse','San Francisco','415-234-6789',NULL),('John','Chicago',NULL,'1060 West Addison'),('Justin','Boston',NULL,NULL),('Mike','Boston',NULL,NULL),('Rebecca','Chicago',NULL,'1060 West Addison'),('Thomas ','New York',NULL,'160 River Ave'),('Tom','Chicago',NULL,'1060 West Addison'),('Vince','New York','234-456-7890','161st St and River Ave');
/*!40000 ALTER TABLE `drinkers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frequents`
--

DROP TABLE IF EXISTS `frequents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `frequents` (
  `drinker` varchar(50) NOT NULL DEFAULT '',
  `bar` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`drinker`,`bar`),
  KEY `fk_frequents_bar` (`bar`),
  CONSTRAINT `fk_frequents_bar` FOREIGN KEY (`bar`) REFERENCES `bars` (`name`),
  CONSTRAINT `fk_frequents_drinker` FOREIGN KEY (`drinker`) REFERENCES `drinkers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frequents`
--

LOCK TABLES `frequents` WRITE;
/*!40000 ALTER TABLE `frequents` DISABLE KEYS */;
INSERT INTO `frequents` VALUES ('Mike','A.P. Stump\'s'),('Bob','Blue Angel'),('Erik','Blue Angel'),('Herb','Blue Angel'),('Jesse','Blue Angel'),('John','Blue Angel'),('Justin','Blue Angel'),('Mike','Blue Angel'),('Rebecca','Blue Angel'),('Tom','Blue Angel'),('Vince','Blue Angel'),('Mike','Cabana'),('John','Caravan'),('Tom','Caravan'),('Bob','Coconut Willie\'s Cocktail Lounge'),('Rebecca','Coconut Willie\'s Cocktail Lounge'),('Justin','Gecko Grill'),('Rebecca','Gecko Grill'),('Herb','Seven Bamboo'),('Thomas','Seven Bamboo'),('Vince','Seven Bamboo'),('Mike','The Shark and Rose');
/*!40000 ALTER TABLE `frequents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `drinker` varchar(50) NOT NULL DEFAULT '',
  `beer` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`drinker`,`beer`),
  KEY `fk_likes_beer` (`beer`),
  CONSTRAINT `fk_likes_beer` FOREIGN KEY (`beer`) REFERENCES `beers` (`name`),
  CONSTRAINT `fk_likes_drinker` FOREIGN KEY (`drinker`) REFERENCES `drinkers` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES ('John','Blue Moon'),('Mike','Blue Moon'),('John','Budweiser'),('Mike','Budweiser'),('John','Creamy Dark'),('Mike','Creamy Dark'),('Mike','Hefeweizen'),('John','Killian\'s'),('John','Michelob Golden Draft'),('Mike','Michelob Golden Draft Light'),('John','Original Premium'),('Mike','Original Premium Lager'),('Jesse','Original Premium Lager Dog'),('Mike','Original Premium Lager Dog'),('John','Stolichnaya Citrona');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;







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
