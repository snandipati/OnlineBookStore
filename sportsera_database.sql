-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 15, 2014 at 06:29 AM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sportsera_database`
--
CREATE DATABASE IF NOT EXISTS `sportsera_database` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `sportsera_database`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `signup`(
	IN pemail  varchar(200),
	IN password varchar(15),
	IN pfirstname varchar(15),
	IN plastname varchar(15),
	IN pstreet varchar(50),
	IN pcity varchar(50),
	IN pstate varchar(50),
	IN pzipcode INT(11),
	IN pphone INT(10),
	OUT result int
)
BEGIN

	DECLARE aid int default 0;
	DECLARE uid int default 0;
  	DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;
    
    START TRANSACTION;
    	SET result = 0;
		insert into 
			address (addressline1, city, state, zipcode)
			values (pstreet, pcity,pstate, pzipcode);
		
		set aid = last_insert_id();
		
		if aid <> 0 then
			insert into 
				user  (email, password, firstname,lastname,phone)
				values (pemail, ppassword, pfirstname, plastname, pphone);
			
			set uid = last_insert_id();
			
			if uid <> 0 then
			
			insert ignore into 
				user_address ( userid, addressid)
				values ( uid, aid);
				 
			end if;
				
								 
		end if;	
   		SET result = 1;
   
    COMMIT;	      
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE IF NOT EXISTS `address` (
  `addressid` int(11) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) DEFAULT NULL,
  `addressline1` varchar(50) DEFAULT NULL,
  `addressline2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zipcode` int(11) NOT NULL,
  PRIMARY KEY (`addressid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`addressid`, `nickname`, `addressline1`, `addressline2`, `city`, `state`, `zipcode`) VALUES
(1, 'hello', '300 OliveWst', 'apt 1', 'Fremont', 'ca', 94041),
(2, 'hello', '202 Fairoaks Wst', 'apt 20', 'sunnyvale', 'ca', 94086),
(3, 'hello', '110 Crooked St', 'apt 55', 'san francisco', 'ca', 94111),
(4, '', '11', '22', 'sc', 'ca', 94086),
(5, '', 'sfw', 's bernando', 'sfo', 'ca', 98076),
(6, '', 'Fremont', NULL, 'Mountainview', 'CA', 94086),
(7, '', '360', 'western drive', 'santa cruz', 'CA', 95060),
(8, '', 'aaa', 'www', 'cs', 'CA', 98900),
(9, '', 'qwqw', 'qqw', 'sds', 'asa', 45555),
(10, NULL, '360', 's bernando', 'Mountainview', 'CA', 94086),
(11, NULL, 'SouthBernardo', NULL, 'santa cruz', 'CA', 94086),
(12, NULL, 'SouthBernardo', 'Apt 408', 'Santa Cruz', 'CA', 94086);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `categoryid` int(11) NOT NULL AUTO_INCREMENT,
  `categorytype` char(20) DEFAULT NULL,
  PRIMARY KEY (`categoryid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryid`, `categorytype`) VALUES
(1, 'fitness'),
(2, 'clothes'),
(3, 'shoes'),
(4, 'accessories'),
(5, 'teamsports'),
(6, 'games'),
(7, 'actionsports'),
(8, 'outdoors');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `commentid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `productid` int(11) DEFAULT NULL,
  `comment` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`commentid`),
  UNIQUE KEY `userid_productid` (`userid`,`productid`),
  KEY `comments_ibfk_2` (`productid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`commentid`, `userid`, `productid`, `comment`) VALUES
(1, 1, 1, 'Nice product'),
(2, 3, 4, 'Very Comfortable product!!');

-- --------------------------------------------------------

--
-- Table structure for table `lowinventory`
--

CREATE TABLE IF NOT EXISTS `lowinventory` (
  `productid` int(11) NOT NULL,
  PRIMARY KEY (`productid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lowinventory`
--

INSERT INTO `lowinventory` (`productid`) VALUES
(1),
(3),
(10),
(11),
(18),
(19),
(22),
(25),
(26),
(27),
(29),
(31),
(38),
(46),
(47),
(55),
(57),
(58),
(71),
(72),
(73),
(74),
(81);

-- --------------------------------------------------------

--
-- Table structure for table `manufacturer`
--

CREATE TABLE IF NOT EXISTS `manufacturer` (
  `manufacturerid` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturername` varchar(15) NOT NULL,
  `URL` varchar(100) NOT NULL,
  `phone` int(10) NOT NULL,
  PRIMARY KEY (`manufacturerid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `manufacturer`
--

INSERT INTO `manufacturer` (`manufacturerid`, `manufacturername`, `URL`, `phone`) VALUES
(1, 'Adidas', 'http://www.adidas.com', 2134567895),
(2, 'Nike', 'http://www.nike.com', 2147483647),
(3, 'Reebok', 'http://www.reebok.com', 2134567894),
(4, 'Northface', 'http://www.thenorthface.com', 2134567695),
(5, 'Asics', 'http://www.asicsamerica.com/', 2034567895),
(6, 'Under Armour', 'http://www.underarmour.com/shop/us/en', 2084567895),
(7, 'Columbia', 'http://www.columbia.com/', 2074567895),
(8, 'Brooks', 'https://www.brooksrunning.com/', 2147406647),
(9, 'Hurley', 'http://www.hurley.com/', 2147483647),
(10, 'New Balance', 'http://www.newbalance.com/', 2147483540);

-- --------------------------------------------------------

--
-- Table structure for table `onlineorderitems`
--

CREATE TABLE IF NOT EXISTS `onlineorderitems` (
  `orderitemid` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` int(11) DEFAULT NULL,
  `productid` int(11) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `quantity` int(15) DEFAULT NULL,
  PRIMARY KEY (`orderitemid`),
  KEY `orderid` (`orderid`),
  KEY `productid` (`productid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Dumping data for table `onlineorderitems`
--

INSERT INTO `onlineorderitems` (`orderitemid`, `orderid`, `productid`, `price`, `quantity`) VALUES
(1, 56, 1, 9.5, 1),
(2, 60, 2, 11.4, 1),
(3, 61, 4, 14.25, 1),
(4, 61, 5, 6.65, 2),
(5, 62, 1, 9.5, 1),
(6, 62, 3, 12.35, 1),
(7, 62, 4, 14.25, 1),
(8, 63, 24, 76, 1),
(9, 63, 25, 142.5, 1),
(10, 64, 5, 7, 1),
(11, 64, 6, 15, 1),
(12, 65, 1, 10, 1),
(13, 66, 12, 89, 1),
(14, 66, 13, 99, 2),
(15, 67, 1, 9.5, 1),
(16, 68, 10, 189.05, 1),
(17, 68, 11, 189.05, 3),
(25, 73, 10, 189.05, 1),
(26, 74, 80, 57, 2),
(27, 74, 81, 76, 1),
(28, 75, 31, 42, 1),
(29, 75, 32, 40, 2);

-- --------------------------------------------------------

--
-- Table structure for table `onlineorders`
--

CREATE TABLE IF NOT EXISTS `onlineorders` (
  `orderid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `addressid` int(11) NOT NULL,
  `orderstatus` int(4) DEFAULT '1',
  `ordereddate` date DEFAULT NULL,
  PRIMARY KEY (`orderid`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=76 ;

--
-- Dumping data for table `onlineorders`
--

INSERT INTO `onlineorders` (`orderid`, `userid`, `addressid`, `orderstatus`, `ordereddate`) VALUES
(1, 1, 1, 1, '2014-03-01'),
(2, 2, 2, 1, '2014-03-05'),
(3, 2, 2, 1, '2014-03-11'),
(4, 2, 2, 1, '2014-03-11'),
(5, 2, 2, 1, '2014-03-11'),
(6, 2, 2, 1, '2014-03-11'),
(7, NULL, 4, 1, '2014-03-11'),
(8, NULL, 5, 1, '2014-03-12'),
(9, 2, 2, 1, '2014-03-12'),
(10, 4, 6, 1, '2014-03-12'),
(11, 4, 6, 1, '2014-03-12'),
(12, 2, 2, 1, '2014-03-12'),
(13, 2, 2, 1, '2014-03-12'),
(14, 2, 2, 1, '2014-03-12'),
(15, 2, 2, 1, '2014-03-12'),
(16, 2, 2, 1, '2014-03-12'),
(17, 2, 2, 1, '2014-03-12'),
(18, 2, 2, 1, '2014-03-12'),
(19, 2, 2, 1, '2014-03-12'),
(20, 2, 2, 1, '2014-03-12'),
(21, 2, 2, 1, '2014-03-12'),
(22, 2, 2, 1, '2014-03-12'),
(23, 2, 2, 1, '2014-03-12'),
(24, 2, 2, 1, '2014-03-12'),
(25, 2, 2, 1, '2014-03-12'),
(26, 2, 2, 1, '2014-03-12'),
(27, 2, 2, 1, '2014-03-12'),
(28, 2, 2, 1, '2014-03-12'),
(29, 2, 2, 1, '2014-03-12'),
(30, 2, 2, 1, '2014-03-13'),
(31, 2, 2, 1, '2014-03-13'),
(32, 2, 2, 1, '2014-03-13'),
(33, 2, 2, 1, '2014-03-13'),
(34, 2, 2, 1, '2014-03-13'),
(35, 2, 2, 1, '2014-03-13'),
(36, 2, 2, 1, '2014-03-13'),
(37, 2, 2, 1, '2014-03-13'),
(38, 2, 2, 1, '2014-03-13'),
(39, 2, 2, 1, '2014-03-13'),
(40, 2, 2, 1, '2014-03-13'),
(41, 2, 2, 1, '2014-03-13'),
(42, 2, 2, 1, '2014-03-13'),
(43, 2, 2, 1, '2014-03-13'),
(44, 2, 2, 1, '2014-03-13'),
(45, 2, 2, 1, '2014-03-13'),
(46, 2, 2, 1, '2014-03-13'),
(47, 2, 2, 1, '2014-03-13'),
(48, 2, 2, 1, '2014-03-13'),
(49, 2, 2, 1, '2014-03-13'),
(50, 2, 2, 1, '2014-03-13'),
(51, 2, 2, 1, '2014-03-13'),
(52, 2, 2, 1, '2014-03-13'),
(53, 2, 2, 1, '2014-03-13'),
(54, 2, 2, 1, '2014-03-13'),
(55, 2, 2, 1, '2014-03-13'),
(56, 2, 2, 1, '2014-03-13'),
(57, 2, 2, 1, '2014-03-13'),
(58, 2, 2, 1, '2014-03-13'),
(59, 2, 2, 1, '2014-03-13'),
(60, 2, 2, 1, '2014-03-13'),
(61, 2, 2, 1, '2014-03-13'),
(62, 2, 2, 1, '2014-03-13'),
(63, 2, 2, 1, '2014-03-13'),
(64, NULL, 7, 1, '2014-03-13'),
(65, NULL, 8, 1, '2014-03-13'),
(66, NULL, 9, 1, '2014-03-13'),
(67, 4, 6, 1, '2014-03-13'),
(68, 2, 2, 1, '2014-03-14'),
(69, NULL, 10, 1, '2014-03-14'),
(70, 2, 2, 1, '2014-03-14'),
(71, 2, 2, 1, '2014-03-14'),
(72, 2, 2, 1, '2014-03-14'),
(73, 2, 2, 1, '2014-03-14'),
(74, 2, 2, 1, '2014-03-14'),
(75, NULL, 12, 1, '2014-03-14');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `productid` int(11) NOT NULL AUTO_INCREMENT,
  `title` char(30) NOT NULL,
  `productname` varchar(100) NOT NULL,
  `image` varchar(200) NOT NULL,
  `price` float NOT NULL,
  `productdescription` text NOT NULL,
  `stockavailable` int(11) NOT NULL,
  `manufacturerid` int(11) NOT NULL,
  `categoryid` int(11) NOT NULL,
  PRIMARY KEY (`productid`),
  KEY `categoryid` (`categoryid`),
  KEY `manufacturerid` (`manufacturerid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=102 ;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productid`, `title`, `productname`, `image`, `price`, `productdescription`, `stockavailable`, `manufacturerid`, `categoryid`) VALUES
(1, 'Socks', 'ASICS kayano low-cut socks', 'images/accessories/menslocut.jpg', 10, 'Comfortable for Men', 3, 5, 4),
(2, 'Socks', 'UNDERARMOUR Mens training sock', 'images/accessories/mensmultipack.jpg', 12, 'Keep your feet healthy and comfortable while you work out with these UNDER ARMOUR training socks fo', 7, 6, 4),
(3, 'Socks', 'ASICS Kayano Classic Low-Cut Socks', 'images/accessories/womenslocut.jpg', 13, 'anatomic fit, NanoGLIDE moisture and friction management, articulated arch support, horizontal lace', 4, 5, 4),
(4, 'Socks', 'Rebook Adult Rebel Fusion Trekker Quarter Socks', 'images/accessories/womenscrew3.jpg', 15, 'The Rebook Rebel Fusion Trekker quarter socks are built with a knit-in liner', 6, 3, 4),
(5, 'Socks', 'UNDER ARMOUR youth no-show socks', 'images/accessories/kidsmultipack.jpg', 7, ' strategic cushioning pads to protect the high-impact areas of your child''s feet that suffer the mos', 8, 6, 4),
(6, 'Socks', 'NIKE girls socks', 'images/accessories/nikegirlssocks.jpg', 15, 'NIKE women''s lightweight no-show socks come in 6 great colors, so you can mix and match with workout', 9, 2, 4),
(7, 'mountainboots', 'ASICS womensmountainboots', 'images/actionsports/womensmountainboots.jpg', 15, 'women''s ski boots are good both in the lodge and on the slopes', 13, 2, 7),
(8, 'mountainboots', 'REEBOK mensmountainboots', 'images/actionsports/womensmountainboots.jpg', 17, 'for speed with Twinframe and 360-degree Custom Shell technologies for ultimate performance, comfort.', 13, 2, 7),
(9, 'mountainboots', 'NIKE kidsboots', 'images/actionsports/kidsboots.jpg', 12, 'Adidas youth Hot Rod 60 ski boots are designed to deliver outstanding comfort to the aspiring all-', 10, 3, 7),
(10, 'byke', 'TITAN TRAIL mountainbyke', 'images/actionsports/mountainbyke.jpg', 199, 'feel what it''s like to ride road-size wheels on a mountain bike. Tree roots, rocks.', 5, 3, 7),
(11, 'byke', 'KAWASAKI mountainbyke', 'images/actionsports/roadbyke.jpg', 199, 'the 29" wheels roll along any surface, dirt or asphalt', 9, 4, 7),
(12, 'Shoes', 'ASICS menshoes', 'images/shoes/menshoes.jpg', 89, 'ASIC GEL external Heel Clutching System and a Biomorphic Fit upper for incredible comfort and depe', 6, 5, 3),
(13, 'Shoes', 'NIKE mensshoes', 'images/shoes/mensshoes2.jpg', 99, 'NIKE Power Platform, the Lunar Ascend men''s golf shoes offer enhanced power and stability throughou', 5, 2, 3),
(14, 'Shoes', 'BROOKS kidsshoe', 'images/shoes/kidsshoe.jpg', 59, 'The Brooks Boy''s Suede Cosmic rental shoe is constructed of 100% brushed leather.', 7, 8, 3),
(15, 'Shoes', 'NIKE kidssshoe', 'images/shoes/kidsshoe2.jpg', 79, 'NIKE Future track stars will love the super-comfy fit and feel of the NIKE® boys'' Free 5.0 running s', 7, 2, 3),
(16, 'Shoes', 'ASICS womensshoe', 'images/shoes/womensshoe.jpg', 99, 'Dive for every shot in the ASICS women''s GEL-1140 volleyball shoes.', 7, 5, 3),
(17, 'Shoes', 'UNDER ARMOUR womensshoe', 'images/shoes/womensshoe2.jpg', 99, 'Bask in the comfort of these Underarmour women''s Bailey Bow boots.', 7, 6, 3),
(18, 'Dumbells', 'Cap Barbell 10 lb Hexagon Solid Dumbbell Weight', 'images/fitness/dumbells.jpg', 15, 'This Cap Barbell 10-lb Hexagon solid dumbbell has a vinyl-dipped design and hexagonal shape.', 2, 9, 1),
(19, 'Dumbells', 'Bowflex 5lbs-52lbs SelectTech Dumbells', 'images/fitness/dumbells2.jpg', 350, 'The Bowflex SelectTech Dumbbells features a unique weight system that lets you adjust each dumbbel', 4, 9, 1),
(20, 'Treadmill', 'LifeSpan TR1200-DT7 Desktop Treadmill', 'images/fitness/lifespandesktoptreadmill.jpg', 1999, 'The TR1200-DT7 treadmill desk from LifeSpan is ideal for your office!', 5, 9, 1),
(21, 'Treadmill', 'Exerpeutic 2000 "Workfit" High Capacity Desk Station Treadmill', 'images/fitness/highcapacitydeskstationtreadmill.jpg', 849, 'combines both, letting you burn calories as you take care of business.', 3, 10, 1),
(22, 'Elliptical', 'FreeMotion 545 Elliptical', 'images/fitness/elliptical.jpg', 999, 'Featuring incline up to 20 degrees, the total-body toning ramp adjusts your incline.', 1, 10, 1),
(23, 'Elliptical', 'Exerpeutic 770 Heavy Duty 21" Pro Stride Magnetic Elliptical', 'images/fitness/elliptical2.jpg', 749, 'provides a virtually zero-impact workout with no stress on the hips, ankles and joints, plus dual-ac', 4, 9, 1),
(24, 'Clothes', 'adidas Men''s Adizero F50 Messi Track Top', 'images/clothes/Men/adidasmenlongsleeve2.jpg', 80, 'lightweight woven fabric with mesh panels on the back and underarms for superior ventilation', 8, 1, 2),
(25, 'Clothes', 'NIKE Men''s Element Reflective 1/2-Zip Running Top', 'images/clothes/Men/nikemenlongsleeves.jpg', 150, 'In chilly conditions, the NIKE men''s Element 1/2-zip running top keeps cold air from slowing you do', 3, 2, 2),
(26, 'Clothes', 'UNDER ARMOUR Men''s Charged Cotton Short-Sleeve T-Shirt', 'images/clothes/Men/UAmenshortsleeves.jpg', 20, 'The UNDER ARMOUR men''s Charged Cotton short-sleeve t-shirt.', 4, 7, 2),
(27, 'Clothes', 'adidas Men''s Clima Ultimate Short-Sleeve Training T-Shirt', 'images/clothes/Men/adidasmenshortsleeves2.jpg', 22, 'Built to take you through each phase of your workout, the adidas men''s CLIMA Ultimate short-sleeve', 4, 1, 2),
(28, 'Clothes', 'NIKE Men''s JDI Tank', 'images/clothes/Men/nikementank3.jpg', 28, 'Swear to never second guess your mad skills and throw on this NIKE men''s JDI Tank before breaking t', 5, 2, 2),
(29, 'Clothes', 'NIKE Men''s JDI Tank', 'images/clothes/Men/hurleymentank2.jpg', 20, 'Stamped with a pair of bold brand graphics, this HURLEY men''s One & Only Premium tank will grab you', 2, 9, 2),
(30, 'Clothes', 'COLUMBIA Men''s Watertight II Rain Jacket', 'images/clothes/Men/menrainjacket.jpg', 60, 'Wet weather doesn''t stand a chance against this COLUMBIA men''s WatertightII rain jacket.', 5, 10, 2),
(31, 'Clothes', 'NIKE Men''s KO Annihilator Hoodie', 'images/clothes/Men/Nikehoodie1.jpg', 42, 'When the weather cools, turn up the heat with this NIKE men''s KO Annihilator hoodie.', 4, 2, 2),
(32, 'Clothes', 'adidas Men''s Ultimate Fleece Pullover Hoodie', 'images/clothes/Men/Adidashoodie2.jpg', 40, 'Layer up with the adidas men''s Ultimate fleece pullover hoodie when there''s a chill in the air.', 5, 1, 2),
(33, 'Clothes', 'UNDER ARMOUR Men''s Armour Fleece Storm Big Logo Hoodie', 'images/clothes/Men/UAhoodie3.jpg', 55, 'The UNDER ARMOUR men''s Armour Fleece Big Logo hoodie is crafted with a Storm finish to repel water', 5, 6, 2),
(34, 'Clothes', 'THE NORTH FACE Men''s Canyonlands Insulated Softshell Jacket', 'images/clothes/Men/NFmenjacket1.jpg', 180, 'You''re not just outside as you dash from building to building, you work and play in the great outdoor', 6, 4, 2),
(35, 'Clothes', 'NIKE Men''s Speed Hybrid Thermore Jacket', 'images/clothes/Men/Nikemenjacket.jpg', 130, 'You''ll love the low-bulk design of this NIKE Speed Hybrid men''s jacket when you''re out.', 6, 2, 2),
(36, 'Clothes', 'COLUMBIA Men''s Grade Max Jacket', 'images/clothes/Men/Columbiamenjacket3.jpg', 99, 'Fortified with Omni-Wind Block and a heat-retaining Omni-Heat thermal reflective lining.', 6, 10, 2),
(37, 'Clothes', 'THE NORTH FACE Men''s TKA 100 Microvelour Glacier 1/4-Zip Fleece', 'images/clothes/Men/NFmenfleece1.jpg', 40, 'Cozy up with a classic! THE NORTH FACE men''s TKA 100 Glacier microvelour 1/4-zip fleece', 7, 4, 2),
(38, 'Clothes', 'COLUMBIA Men''s Fast Trek II Full-Zip Fleece Jacket', 'images/clothes/Men/Columbiamenfleece2.jpg', 50, 'The perfect companion for your everyday adventures, the COLUMBIA men''s Fast Trek II full-zip fleece.', 2, 10, 2),
(39, 'Clothes', 'Asics 56" x 80" PVC/Nylon Rain Poncho', 'images/clothes/Men/asicsmenrain1.jpg', 40, 'crafted with nylon laminated to vinyl for added protection from the elements. It features a visored ', 8, 6, 2),
(40, 'Clothes', 'COLUMBIA Men''s Glennaker Lake Rain Jacket', 'images/clothes/Men/Columbiamenrain2.jpg', 49, 'In changing weather conditions, grab the COLUMBIA men''s Glennaker Lake rain.', 8, 10, 2),
(41, 'Clothes', 'NIKE Men''s STK Lights Out II Baseball Pants', 'images/clothes/Men/nikemenpant1.jpg', 45, 'he NIKE men''s STK Lights Out II baseball pants pull sweat away from your skin.', 11, 2, 2),
(42, 'Clothes', 'UNDER ARMOUR Men''s Leadoff II Baseball Pants', 'images/clothes/Men/UAmenpant2.jpg', 40, 'Made from HeatGear fabric to keep you cool, dry and light, the UNDER ARMOUR men''s Leadoff.', 5, 6, 2),
(43, 'Clothes', 'NIKE Men''s Lights Out Baseball/Softball Pants', 'images/clothes/Men/nikemenpant2.jpg', 40, 'Perfect for game day, the NIKE men''s Lights Out baseball/softball pants.', 7, 2, 2),
(44, 'Clothes', 'NIKE Men''s LeBron Gravity Basketball Shorts', 'images/clothes/Men/Nikemenshort1.jpg', 45, 'Attack the blacktop with confidence in the NIKE men''s LeBron Gravity basketball shorts.', 8, 2, 2),
(46, 'Clothes', 'UNDER ARMOUR Men''s Big Timin'' Basketball Shorts', 'images/clothes/Men/UAmenshort2.jpg', 30, 'Hit the court in the UNDER ARMOUR men''s Big Timin'' basketball shorts.', 4, 6, 2),
(47, 'Clothes', 'NIKE Women''s Deep V-Neck Short-Sleeve T-Shirt', 'images/clothes/Women/Nwomenshortsleeve1.jpg', 19, 'Give your fellow gym-goers a little extra motivation with this NIKE womens sleeve.', 4, 2, 2),
(48, 'Clothes', 'adidas Women''s Ultimate V-Neck Short-Sleeve T-Shirt', 'images/clothes/Women/Awomenshortsleeve2.jpg', 17, 'Sure to become a staple in your workout wardrobe, the adidas women''s Ultimate v-neck t-shirt offers.', 5, 1, 2),
(49, 'Clothes', 'adidas Women''s Ultimate Long-Sleeve V-Neck T-Shirt', 'images/clothes/Women/Wlongsleeve1.jpg', 27, 'Think it''s impossible to look good in the middle of an intense workout? Try the adidas women''s.', 6, 1, 2),
(50, 'Clothes', 'NIKE Women''s Twist Styled Wrap', 'images/clothes/Women/wlongsleeve2.jpg', 72, 'Stand out before you even lace up your sneakers and go to work with NIKE s women''s Twist Styled.', 7, 2, 2),
(51, 'Clothes', 'adidas Women''s Stella McCartney Barricade 2 Tennis Tank', 'images/clothes/Women/adidaswtank1.jpg', 50, 'Give your game a big edge with the adidas women''s Stella McCartney Barricade 2 tennis tank.', 5, 1, 2),
(52, 'Clothes', 'NIKE Women''s Sculpt Printed Tank', 'images/clothes/Women/NikeWtank2.jpg', 18, 'This NIKE women''s Sculpt printed tank helps you go the distance with its moisture-wicking Dri-FIT', 6, 2, 2),
(53, 'Clothes', 'NIKE Women''s Bold Stripe Short-Sleeve Golf Polo', 'images/clothes/Women/NWshortsleeve1.jpg', 70, 'Play to your full potential in a NIKE women''s Bold Stripe short-sleeve golf polo.', 8, 1, 2),
(54, 'Clothes', 'COLUMBIA Women''s Freeze Degree Short-Sleeve Polo', 'images/clothes/Women/CWshortsleeve2.jpg', 50, 'Play to your full potential in a NIKE women''s Bold Stripe short-sleeve golf polo.', 8, 7, 2),
(55, 'Clothes', 'THE NORTH FACE Women''s Half Dome Hoodie', 'images/clothes/Women/NFWhoodie1.jpg', 45, 'Designed with athletic-inspired ribbing at the cuffs and hem, the women''s Half Dome hoodie.', 3, 4, 2),
(56, 'Clothes', 'UNDER ARMOUR Women''s Battle Hoodie', 'images/clothes/Women/UMWhoodie2.jpg', 40, 'Conquer your toughest workouts in the UNDER ARMOUR women''s Battle hoodie!', 6, 6, 2),
(57, 'Clothes', 'THE NORTH FACE Women''s Momentum Triclimate Jacket', 'images/clothes/Women/NFWrainjacket.jpg', 140, 'When it''s too warm for your winter jacket, layering is the way to go. THE NORTH FACE women''s Moment.', 3, 4, 2),
(58, 'Clothes', 'COLUMBIA Women''s Arcadia Rain Jacket', 'images/clothes/Women/CWrainjacket2.jpg', 75, 'Don''t let inclement weather slow you down during your next adventure. The COLUMBIA Arcadia women''s', 3, 7, 2),
(59, 'Clothes', 'THE NORTH FACE Women''s Aconcagua Jacket', 'images/clothes/Women/NFWjacket1.jpg', 160, 'The women''s Aconcagua jacket from THE NORTH FACE provides unbeatable warmth.', 5, 4, 2),
(60, 'Clothes', 'COLUMBIA Women''s Mercury Maven II Jacket', 'images/clothes/Women/CWjacket2.jpg', 100, 'Mother Nature is no match for the COLUMBIA women''s Mercury Maven II jacket.', 5, 7, 2),
(61, 'Clothes', 'HURLEY Women''s Bandit Beachrider Shorts', 'images/clothes/Women/HWshort1.jpg', 30, 'Stop the heat from stealing your energy with a pair of HURLEY women''s Bandit shorts.', 9, 9, 2),
(62, 'Clothes', 'THE NORTH FACE Women''s Reversible Trunks', 'images/clothes/Women/NFshort2.jpg', 30, 'Get two great looks in one with THE NORTH FACE women''s reversible trunks!', 9, 4, 2),
(63, 'Clothes', 'THE NORTH FACE Women''s Paramount Valley Convertible Pants', 'images/clothes/Women/NFWpant1.jpg', 60, 'THE NORTH FACE women''s Paramount Valley convertible pants are newly updated.', 5, 4, 2),
(64, 'Clothes', 'THE NORTH FACE Women''s Paramount Valley Convertible Pants', 'images/clothes/Women/ColumbiaWpant2.jpg', 40, 'The sweat-wicking COLUMBIA women''s Aruba convertible pants are designed to be comfortable.', 5, 7, 2),
(65, 'Clothes', 'NIKE Boys'' KO 2.0 Multisport Graphic Pullover Hoodie', 'images/clothes/kids/NBhoodie1.jpg', 32, 'The NIKE boys'' KO 2.0 Multisport graphic pullover hoodie wards off the chill.', 5, 2, 2),
(66, 'Clothes', 'UNDER ARMOUR Boys'' Alter Ego Spider-Man Allover Graphic T-Shirt', 'images/clothes/kids/UABgraphictee1.jpg', 40, 'His quest for invincibility starts with the UNDER ARMOUR boys'' Alter Ego allover graphic t-shirt.', 5, 6, 2),
(67, 'Clothes', 'COLUMBIA Boys'' Windy Explorer Jacket', 'images/clothes/kids/ColumbiaBrjacket1.jpg', 30, 'The COLUMBIA boys'' Windy Explorer jacket wraps him in water-repellent protection.', 5, 7, 2),
(68, 'Clothes', 'NIKE Girls'' Ultimate Protect Jacket', 'images/clothes/kids/NGirlsjacket1.jpg', 64, 'Sporty dudes will stay warm and dry in this NIKE boys'' Ultimate Protect jacket.', 5, 2, 2),
(69, 'Clothes', 'NIKE Girls'' Just Do It Paint Brush Short-Sleeve T-Shirt', 'images/clothes/kids/Ngirlstshirt1.jpg', 14, 'She can show off some so-cute, so-sporty style in this NIKE girls'' Just Do.', 5, 2, 2),
(70, 'Clothes', 'UNDER ARMOUR Girls'' Wordmark Graphic Short-Sleeve T-Shirt', 'images/clothes/kids/UAGthirt2.jpg', 16, 'Crafted with moisture-wicking Charged Cotton fabric, the UNDER ARMOUR girls'' wordmark graphic short.', 6, 6, 2),
(71, 'Clothes', 'THE NORTH FACE Toddler Girls'' Insulated Snowdrift Bib', 'images/clothes/kids/kidsg.jpg', 80, 'If your young ski diva is just learning the ropes, suit her up for success on the slopes.', 4, 4, 2),
(72, 'games', 'Butterfly Centrefold Rollaway 25', 'images/games/tt1.jpg', 1999, 'The Butterfly Centrefold Rollaway 25 table tennis table was the official table of the 2004 and 2005.', 4, 8, 6),
(73, 'games', 'Kettler Top Star XL Outdoor Table Tennis Table', 'images/games/tt2.jpg', 499, 'The absolutely weatherproof Kettler Top Star XL outdoor table tennis tables.', 4, 10, 6),
(74, 'games', 'Ping Pong Performance Four Player Table Tennis Set', 'images/games/ppbat1.jpg', 40, 'This four-player performance table tennis set from Ping Pong is designed for high-quality play.', 4, 10, 6),
(75, 'games', 'Ping Pong Performance Two Player Racket Set', 'images/games/ppbat2.jpg', 20, 'The Ping Pong two-player racket set features two rackets with concave handles and 5-ply blades.', 7, 10, 6),
(76, 'games', 'SKLZ Speedminton Super 16 Player Set', 'images/games/bt1.jpg', 339, 'Speedminton combines features of badminton, tennis and squash into a fun.', 9, 10, 6),
(77, 'games', 'Park & Sun Badminton Pro Set', 'images/games/bt2.jpg', 130, 'The Park & Sun Badminton Pro Set can be set up in your backyard.', 16, 10, 6),
(78, 'games', 'Mizerak Donovan II 8'' Slatron Billiard Table', 'images/games/billiard1.jpg', 1099, 'Designed with cool, contemporary features, the Mizerak Donovan II 8'' slatron billiard table.', 16, 10, 6),
(79, 'games', 'Mizerak Deluxe Billiard Balls', 'images/games/billiardballs.jpg', 60, 'The Mizerak Deluxe billiard ball set includes 15 pool balls and one cue ball.', 10, 8, 6),
(80, 'teamsports', 'NIKE Youth V-Touch Football', 'images/teamsports/Nfootball1.jpg', 60, 'With its refined shaping and soft-touch grip channels, this NIKE youth V-Touch football helps young', 8, 2, 5),
(81, 'teamsports', 'WILSON Official GST Leather Football', 'images/teamsports/Wilsonfootball2.jpg', 80, 'Practice playing with the WILSON Official GST leather football. WILSON replaced traditional laces.', 4, 2, 5),
(82, 'teamsports', 'Diamond Sports DLL Tournament Grade Little League Baseball by the Dozen', 'images/teamsports/baseball.jpg', 60, 'Diamond Sports DLL Tournament-Grade Little League  baseballs are built for demanding situations, inc.', 5, 2, 5),
(83, 'teamsports', 'Trend Sports Heater Leather Pitching Machine Baseballs by the Dozen', 'images/teamsports/baseball2.jpg', 40, 'Recommended for the Heater Pitching Machines (sold separately), these Trend Sports Heater Leather B.', 10, 2, 5),
(84, 'teamsports', 'NIKE Strike Soccer Ball', 'images/teamsports/Nsoccerball1.jpg', 30, 'Dribble through a crowd and execute quick moves with confidence knowing this NIKE Strike soccer ball.', 9, 2, 5),
(85, 'teamsports', 'adidas F50 Messi Soccer Ball', 'images/teamsports/adidassoccerball2.jpg', 25, 'Inspired by superstar Lionel Messi, the adidas F50 Messi soccer ball bring performance.', 9, 1, 5),
(86, 'teamsports', 'EASTON Stealth 85S II Senior Ice Hockey Stick', 'images/teamsports/hockey1.jpg', 200, 'Rock the rink with this high-performance EASTON Stealth 85S II senior ice hockey stick!', 9, 10, 5),
(87, 'teamsports', 'EASTON Stealth 85S II Senior Ice Hockey Stick', 'images/teamsports/hockey2.jpg', 65, 'Rock the rink with this high-performance EASTON Stealth 85S II senior ice hockey stick!', 9, 6, 5),
(88, 'teamsports', 'EASTON Stealth 65S Senior Ice Hockey Skates', 'images/teamsports/skate1.jpg', 200, 'These EASTON Stealth 65S senior ice hockey skates boast thermoformable.', 10, 6, 5),
(89, 'teamsports', 'Tour TR-700 Ice Hockey Skate', 'images/teamsports/skate2.jpg', 51, 'The Tour TR-700 ice hockey skate is crafted with reinforced quarter panels, a brushed tricot lining.', 11, 6, 5),
(90, 'teamsports', 'Gray-Nicolls Plastic Cricket Set', 'images/teamsports/cricket1.jpg', 80, 'Ideal for kids and recreational play, the Gray-Nicolls Lazer cricket set includes 2 plastic cricket.', 9, 6, 5),
(91, 'teamsports', 'Slazenger Hyper Blade Xtreme Cricket Bat', 'images/teamsports/cricket2.jpg', 375, 'The Slazenger Hyper Blade Xtreme cricket bat is traditionally crafted and pressed to deliver optimum.', 5, 6, 5),
(92, 'accessories', 'THE NORTH FACE USA Base Camp Crimp Backpack', 'images/accessories/NFbag1.jpg', 99, 'THE NORTH FACE USA Base Camp Crimp backpack hauls your gear in your country''s colors for a dose.', 5, 2, 4),
(93, 'accessories', 'UNDER ARMOUR Parralux Storm Backpack', 'images/accessories/UAbackpack2.jpg', 120, 'Designed for the long haul, UNDER ARMOUR''s Parralux Storm backpack is loaded with all the features.', 7, 6, 4),
(94, 'accessories', 'adidas Climacool Strength III Pack', 'images/accessories/adidasbackpack3.jpg', 70, 'If you hit the gym after a long day at the office, you''ll love the comfort and convenience.', 8, 1, 4),
(95, 'accessories', 'NIKE Brasilia 6 Duffel Bag - Medium', 'images/accessories/nikegymbag1.jpg', 30, 'Head off to the gym or team practice with the NIKE Brasilia 6 medium duffel bag.', 10, 2, 4),
(96, 'accessories', 'UNDER ARMOUR Camden Duffel - Medium', 'images/accessories/UAgymbag2.jpg', 70, 'Confidently secure every necessity when you''re on the move with the UNDER ARMOUR Camden medium duff.', 6, 6, 4),
(97, 'accessories', 'adidas Alliance Sport Sack Pack', 'images/accessories/adidascamopack1.jpg', 16, 'The Alliance Sport sack pack from adidas features a large main compartment with a drawstring closure.', 10, 1, 4),
(98, 'accessories', 'THE NORTH FACE Sack Pack', 'images/accessories/NFcamopack2.jpg', 20, 'Keep the day''s essentials conveniently close with this THE NORTH FACE sack pack!', 9, 4, 4),
(99, 'accessories', 'adidas Weekend Warrior Cap', 'images/accessories/acap1.jpg', 18, 'The adidas Weekend Warrior cap is built tough to go wherever you go during your off-the-clock.', 9, 1, 4),
(100, 'accessories', 'COLUMBIA Kids'' Bora Bora Jr. II Booney Hat', 'images/accessories/ccap2.jpg', 30, 'The COLUMBIA Bora Bora Jr. II booney hat is the perfect way for kids to stay protected from the sunlight.', 9, 7, 4),
(101, 'accessories', 'THE NORTH FACE USA Mountain Scarf', 'images/accessories/scarf1.jpg', 40, 'THE NORTH FACE USA Mountain scarf tops off your winter wardrobe in your country''s colors.', 10, 4, 4);

--
-- Triggers `product`
--
DROP TRIGGER IF EXISTS `lowinvent`;
DELIMITER //
CREATE TRIGGER `lowinvent` AFTER UPDATE ON `product`
 FOR EACH ROW BEGIN 
		IF  NEW.stockavailable <  5 THEN
	 		INSERT IGNORE INTO lowinventory (productid) values (NEW.productid);
	 	END IF;	
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(200) NOT NULL,
  `password` varchar(15) NOT NULL,
  `firstname` char(15) NOT NULL,
  `lastname` char(15) NOT NULL,
  `isadmin` tinyint(1) NOT NULL DEFAULT '0',
  `phone` int(10) NOT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `email`, `password`, `firstname`, `lastname`, `isadmin`, `phone`) VALUES
(1, 'silpa@sportsera.com', 'hello', 'Silpa', 'Nandipati', 1, 2147483647),
(2, 'goutham@sportsera.com', 'test', 'Goutham', 'Damalcheruvu', 0, 2147483647),
(3, 'srinu@sportsera.com', 'test', 'Srinu', 'Nandipati', 0, 2147483647),
(4, 'lakshmi@yahoo.com', 'test', 'Lakshmi', 'Bommareddy', 0, 2147483647),
(5, 'vamsi@yahoo.com', 'test', 'vamsi', 'Bollareddy', 0, 2147483647);

-- --------------------------------------------------------

--
-- Table structure for table `user_address`
--

CREATE TABLE IF NOT EXISTS `user_address` (
  `userid` int(11) NOT NULL,
  `addressid` int(11) NOT NULL,
  PRIMARY KEY (`userid`,`addressid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_address`
--

INSERT INTO `user_address` (`userid`, `addressid`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 6),
(5, 11);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `user` (`userid`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`productid`) REFERENCES `product` (`productid`);

--
-- Constraints for table `lowinventory`
--
ALTER TABLE `lowinventory`
  ADD CONSTRAINT `lowinventory_ibfk_1` FOREIGN KEY (`productid`) REFERENCES `product` (`productid`);

--
-- Constraints for table `onlineorderitems`
--
ALTER TABLE `onlineorderitems`
  ADD CONSTRAINT `onlineorderitems_ibfk_1` FOREIGN KEY (`orderid`) REFERENCES `onlineorders` (`orderid`),
  ADD CONSTRAINT `onlineorderitems_ibfk_2` FOREIGN KEY (`productid`) REFERENCES `product` (`productid`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`categoryid`) REFERENCES `category` (`categoryid`),
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`manufacturerid`) REFERENCES `manufacturer` (`manufacturerid`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
