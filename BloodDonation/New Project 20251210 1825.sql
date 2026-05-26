-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.25a


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema blood
--

CREATE DATABASE IF NOT EXISTS blood;
USE blood;

--
-- Definition of table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(45) DEFAULT NULL,
  `pass` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` (`id`,`email`,`pass`,`status`) VALUES 
 (1,'admin','admin','');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;


--
-- Definition of table `ambulance`
--

DROP TABLE IF EXISTS `ambulance`;
CREATE TABLE `ambulance` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `drivername` varchar(45) NOT NULL,
  `ambulanceno` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ambulance`
--

/*!40000 ALTER TABLE `ambulance` DISABLE KEYS */;
INSERT INTO `ambulance` (`id`,`drivername`,`ambulanceno`,`phone`,`email`,`password`,`location`) VALUES 
 (2,'DD','TN-01-AB-1233','6546546546','dd@gmail.com','11','T Nagar');
/*!40000 ALTER TABLE `ambulance` ENABLE KEYS */;


--
-- Definition of table `bloodbank`
--

DROP TABLE IF EXISTS `bloodbank`;
CREATE TABLE `bloodbank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `email` varchar(245) DEFAULT NULL,
  `password` varchar(245) DEFAULT NULL,
  `bid` varchar(245) DEFAULT NULL,
  `location` longtext,
  `address` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bloodbank`
--

/*!40000 ALTER TABLE `bloodbank` DISABLE KEYS */;
INSERT INTO `bloodbank` (`id`,`name`,`email`,`password`,`bid`,`location`,`address`) VALUES 
 (4,'CC','cc@gmail.com','11','1111','T Nagar','3rd Floor, Upstairs Hotel Murugan Idly, 78, N Usman Rd, T. Nagar, Chennai, Tamil Nadu 600017');
/*!40000 ALTER TABLE `bloodbank` ENABLE KEYS */;


--
-- Definition of table `blooddetails`
--

DROP TABLE IF EXISTS `blooddetails`;
CREATE TABLE `blooddetails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `donor_name` varchar(245) DEFAULT NULL,
  `blood_group` varchar(245) DEFAULT NULL,
  `quantity` varchar(245) DEFAULT NULL,
  `donation_date` varchar(245) DEFAULT NULL,
  `location` longtext,
  `bid` varchar(245) DEFAULT NULL,
  `email` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `blooddetails`
--

/*!40000 ALTER TABLE `blooddetails` DISABLE KEYS */;
INSERT INTO `blooddetails` (`id`,`donor_name`,`blood_group`,`quantity`,`donation_date`,`location`,`bid`,`email`) VALUES 
 (7,'Vicky','A+','100','2025-11-22','Tambaram','1111','cc@gmail.com'),
 (8,'Ajith','A+','100','2025-11-22','T Nagar','1111','cc@gmail.com'),
 (9,'Bala','O+','100','2025-11-22','koyambedu','1111','cc@gmail.com');
/*!40000 ALTER TABLE `blooddetails` ENABLE KEYS */;


--
-- Definition of table `campdetails`
--

DROP TABLE IF EXISTS `campdetails`;
CREATE TABLE `campdetails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hospitalname` varchar(245) DEFAULT NULL,
  `email` varchar(245) DEFAULT NULL,
  `number` varchar(245) DEFAULT NULL,
  `address` longtext,
  `city` varchar(245) DEFAULT NULL,
  `state` varchar(245) DEFAULT NULL,
  `ziecode` varchar(245) DEFAULT NULL,
  `date` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campdetails`
--

/*!40000 ALTER TABLE `campdetails` DISABLE KEYS */;
INSERT INTO `campdetails` (`id`,`hospitalname`,`email`,`number`,`address`,`city`,`state`,`ziecode`,`date`) VALUES 
 (9,'Governtment','thanush@gmail.com','9176644044','3rd Floor, Upstairs Hotel Murugan Idly, 78, N Usman Rd, T. Nagar, Chennai, Tamil Nadu 600017','tnagar','Tamil Nadu','600017','2025-11-29');
/*!40000 ALTER TABLE `campdetails` ENABLE KEYS */;


--
-- Definition of table `campdonate`
--

DROP TABLE IF EXISTS `campdonate`;
CREATE TABLE `campdonate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `donorname` varchar(245) DEFAULT NULL,
  `donormail` varchar(245) DEFAULT NULL,
  `donornumber` varchar(245) DEFAULT NULL,
  `hname` varchar(245) DEFAULT NULL,
  `hmail` varchar(245) DEFAULT NULL,
  `hcontact` varchar(245) DEFAULT NULL,
  `date` varchar(245) DEFAULT NULL,
  `status` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `campdonate`
--

/*!40000 ALTER TABLE `campdonate` DISABLE KEYS */;
/*!40000 ALTER TABLE `campdonate` ENABLE KEYS */;


--
-- Definition of table `certificate`
--

DROP TABLE IF EXISTS `certificate`;
CREATE TABLE `certificate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dname` varchar(45) DEFAULT NULL,
  `dmail` varchar(45) DEFAULT NULL,
  `dnumber` varchar(45) DEFAULT NULL,
  `hname` varchar(45) DEFAULT NULL,
  `hmail` varchar(45) DEFAULT NULL,
  `hnumber` varchar(45) DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `certificate`
--

/*!40000 ALTER TABLE `certificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `certificate` ENABLE KEYS */;


--
-- Definition of table `donatedetails`
--

DROP TABLE IF EXISTS `donatedetails`;
CREATE TABLE `donatedetails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `patientname` varchar(245) DEFAULT NULL,
  `hospitalname` varchar(245) DEFAULT NULL,
  `blood group` varchar(245) DEFAULT NULL,
  `blood or plasma` varchar(245) DEFAULT NULL,
  `Doner mail` varchar(245) DEFAULT NULL,
  `donor number` varchar(245) DEFAULT NULL,
  `beforedate` varchar(245) DEFAULT NULL,
  `afterdate` varchar(245) DEFAULT NULL,
  `status` varchar(245) DEFAULT NULL,
  `cid` longtext,
  `txhash` longtext,
  `sender_addr` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `donatedetails`
--

/*!40000 ALTER TABLE `donatedetails` DISABLE KEYS */;
INSERT INTO `donatedetails` (`id`,`patientname`,`hospitalname`,`blood group`,`blood or plasma`,`Doner mail`,`donor number`,`beforedate`,`afterdate`,`status`,`cid`,`txhash`,`sender_addr`) VALUES 
 (26,'Kandamani','Governtment','A+','blood','javaa3775@gmail.com','25','25-11-2025 ','23-02-2026','donated','QmUJ6iecNa5eoJrGA5wxvE2k6b3wzZHjrMJq65DQ3DLQBG','0x0764fd023bf734c9c982803127c70b1829b7e45da4849a731f50d16a80eabe0a','0x0ab966ead74c5d5f8c6dc46f5f5db0145f8526c6'),
 (31,'Donated In Camp','Governtment                                   ','O+','blood','mailjavasend@gmail.com','9176644044','29-11-2025','28-02-2026','donated','QmYnYdyvj6ijanjrCEqMibSs87rtFnttFjdFvBwnLrhC4o','0xd784e45d162d086a794a4b5fcbfaec8f42a6367a649b61f7cff1256849be15af','0xe435c6e9617970ee6fa8f3fdc7577209f76aea49');
/*!40000 ALTER TABLE `donatedetails` ENABLE KEYS */;


--
-- Definition of table `donorbloodrequest`
--

DROP TABLE IF EXISTS `donorbloodrequest`;
CREATE TABLE `donorbloodrequest` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bid` varchar(245) DEFAULT NULL,
  `patientname` varchar(245) DEFAULT NULL,
  `age` varchar(245) DEFAULT NULL,
  `hospital` varchar(245) DEFAULT NULL,
  `bloodgroup` varchar(245) DEFAULT NULL,
  `qty` varchar(245) DEFAULT NULL,
  `reason` varchar(245) DEFAULT NULL,
  `file` longblob,
  `status` varchar(245) DEFAULT NULL,
  `email` varchar(245) DEFAULT NULL,
  `mobile` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `donorbloodrequest`
--

/*!40000 ALTER TABLE `donorbloodrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `donorbloodrequest` ENABLE KEYS */;


--
-- Definition of table `donorlist`
--

DROP TABLE IF EXISTS `donorlist`;
CREATE TABLE `donorlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `donor_name` varchar(245) DEFAULT NULL,
  `donor_email` varchar(245) DEFAULT NULL,
  `donor_age` varchar(245) DEFAULT NULL,
  `donor_bgp` varchar(245) DEFAULT NULL,
  `donor_PastMedical_issue` varchar(245) DEFAULT NULL,
  `donor_location` varchar(245) DEFAULT NULL,
  `donor_password` varchar(245) DEFAULT NULL,
  `status` varchar(245) DEFAULT NULL,
  `address` longtext,
  `mobile` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `donorlist`
--

/*!40000 ALTER TABLE `donorlist` DISABLE KEYS */;
INSERT INTO `donorlist` (`id`,`donor_name`,`donor_email`,`donor_age`,`donor_bgp`,`donor_PastMedical_issue`,`donor_location`,`donor_password`,`status`,`address`,`mobile`) VALUES 
 (4,'AA','mailjavasend@gmail.com','25','A+','No health issues','T Nagar','11','donated','3rd Floor, Upstairs Hotel Murugan Idly, 78, N Usman Rd, T. Nagar, Chennai, Tamil Nadu 600017','9898989898'),
 (5,'CC','javaa3775@gmail.com','34','O+','Cold issues','T Nagar','11','registered','3rd Floor, Upstairs Hotel Murugan Idly, 78, N Usman Rd, T. Nagar, Chennai, Tamil Nadu 600017','9176644044');
/*!40000 ALTER TABLE `donorlist` ENABLE KEYS */;


--
-- Definition of table `hospitaldetails`
--

DROP TABLE IF EXISTS `hospitaldetails`;
CREATE TABLE `hospitaldetails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `docid` varchar(245) DEFAULT NULL,
  `email` varchar(245) DEFAULT NULL,
  `mobile` varchar(245) DEFAULT NULL,
  `hosname` varchar(245) DEFAULT NULL,
  `address` longtext,
  `password` varchar(245) DEFAULT NULL,
  `filename` longblob,
  `status` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hospitaldetails`
--

/*!40000 ALTER TABLE `hospitaldetails` DISABLE KEYS */;
INSERT INTO `hospitaldetails` (`id`,`name`,`docid`,`email`,`mobile`,`hosname`,`address`,`password`,`filename`,`status`) VALUES 
 (4,'Government','112','thanush@gmail.com','7575475777','general','no.45 chennai','11',0x49544A485730352E706466,'Accepted');
/*!40000 ALTER TABLE `hospitaldetails` ENABLE KEYS */;


--
-- Definition of table `patient`
--

DROP TABLE IF EXISTS `patient`;
CREATE TABLE `patient` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(245) DEFAULT NULL,
  `email` varchar(245) DEFAULT NULL,
  `number` varchar(245) DEFAULT NULL,
  `address` longtext,
  `gender` varchar(245) DEFAULT NULL,
  `age` varchar(245) DEFAULT NULL,
  `hospital` varchar(245) DEFAULT NULL,
  `blood` varchar(245) DEFAULT NULL,
  `blood group` varchar(245) DEFAULT NULL,
  `status` varchar(245) DEFAULT NULL,
  `donormail` varchar(245) DEFAULT NULL,
  `donornumber` varchar(245) DEFAULT NULL,
  `location` longtext,
  `date` varchar(245) DEFAULT NULL,
  `p_priscription` longblob,
  `ambulanceno` varchar(245) DEFAULT NULL,
  `drivername` varchar(245) DEFAULT NULL,
  `ambcontact` varchar(245) DEFAULT NULL,
  `ambstatus` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patient`
--

/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;


--
-- Definition of table `patients`
--

DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `p_name` varchar(245) DEFAULT NULL,
  `p_mail` varchar(245) DEFAULT NULL,
  `p_mobile` varchar(245) DEFAULT NULL,
  `p_gender` varchar(245) DEFAULT NULL,
  `p_age` varchar(245) DEFAULT NULL,
  `p_bgp` varchar(245) DEFAULT NULL,
  `type` varchar(245) DEFAULT NULL,
  `status` varchar(245) DEFAULT NULL,
  `donor_mail` varchar(245) DEFAULT NULL,
  `p_priscription` longblob,
  `h_name` varchar(245) DEFAULT NULL,
  `h_addres` longtext,
  `d_number` varchar(245) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `patients`
--

/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
