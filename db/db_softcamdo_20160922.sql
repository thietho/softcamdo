-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 21, 2016 at 07:48 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_softcamdo`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `accountid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `accountname` text COLLATE utf8_unicode_ci NOT NULL,
  `parent` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `accountid`, `accountname`, `parent`, `amount`) VALUES
(1, '111', 'Tiền mặt', '', 0),
(2, '112', 'Tiền gửi ngân hàng', '', 0),
(3, '1111', 'Tiền Việt Nam', '111', 0),
(4, '1121', 'Tiền Việt Nam', '112', 0);

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE IF NOT EXISTS `bills` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `billnumber` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `billtype` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `createdate` date NOT NULL,
  `createby` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `accountid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `amount` double NOT NULL,
  `notes` text COLLATE utf8_unicode_ci NOT NULL,
  `invoiceid` bigint(20) NOT NULL,
  `cardid` bigint(20) NOT NULL,
  `fullname` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `billnumber`, `billtype`, `createdate`, `createby`, `accountid`, `amount`, `notes`, `invoiceid`, `cardid`, `fullname`) VALUES
(1, '201609211', 'collect', '2016-09-21', '', '111', 1000000, 'sdf ewwqwq', 0, 3, 'Nguyễn Văn B');

-- --------------------------------------------------------

--
-- Table structure for table `cards`
--

CREATE TABLE IF NOT EXISTS `cards` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fistname` text COLLATE utf8_unicode_ci NOT NULL,
  `lastname` text COLLATE utf8_unicode_ci NOT NULL,
  `fullname` text COLLATE utf8_unicode_ci NOT NULL,
  `idnumber` text COLLATE utf8_unicode_ci NOT NULL,
  `iddate` date NOT NULL,
  `idlocation` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `fistname`, `lastname`, `fullname`, `idnumber`, `iddate`, `idlocation`, `phone`, `address`, `email`) VALUES
(2, 'Tèo', 'Trần', 'Trần Văn Tèo', '423423', '2016-09-14', 'An Giang', '242342342', '423 dfwefw', 'ewwerw@fsefe.com'),
(3, 'B', 'Nguyễn', 'Nguyễn Văn B', '123456789', '2016-09-20', 'An Giang', '3432423', '34 dsf wefwefw', 'etweij@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `categoryid` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `categoryname` text COLLATE utf8_unicode_ci NOT NULL,
  `parent` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=20 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `categoryid`, `categoryname`, `parent`, `position`) VALUES
(3, 'Apple', 'Apple', 'brand', 1),
(2, 'brand', 'Hãng sản xuất', '', 2),
(4, 'Sony', 'Sony', 'brand', 2),
(5, 'Samsung', 'Samsung', 'brand', 3),
(6, 'status', 'Trạng thái', '', 3),
(14, '70phantram', '70% giá trị', 'status', 2),
(13, '50phantram', '50% giá trị', 'status', 1),
(9, 'storage', 'Tủ dựng', '', 4),
(10, 't1', 'Tủ 1', 'storage', 1),
(11, 't2', 'Tủ 2', 'storage', 2),
(12, 'Dell', 'Dell', 'brand', 4);

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE IF NOT EXISTS `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` text COLLATE utf8_unicode_ci NOT NULL,
  `rate` text COLLATE utf8_unicode_ci NOT NULL,
  `groupid` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `infodes` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`id`, `groupname`, `rate`, `groupid`, `infodes`) VALUES
(1, 'Máy tính', '5', 'computer', 'Loại máy - Model - CPU - RAM - HDD - Kèm'),
(3, 'Xe', '4', 'car', 'Loại xe - Biển số - NĐK:datepicker - Số máy - S.Khung - M.Sơn'),
(4, 'Vàng', '3', 'gold', 'Loại vàng - Model - Trọng lượng'),
(5, 'Điện thoại', '3', 'phone', 'Loại ĐT - Model - Kèm');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE IF NOT EXISTS `invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invoicenumber` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createby` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `itemid` bigint(20) NOT NULL,
  `cardid` bigint(20) NOT NULL,
  `fistname` text COLLATE utf8_unicode_ci NOT NULL,
  `lastname` text COLLATE utf8_unicode_ci NOT NULL,
  `fullname` text COLLATE utf8_unicode_ci NOT NULL,
  `idnumber` text COLLATE utf8_unicode_ci NOT NULL,
  `iddate` date NOT NULL,
  `idlocation` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `email` text COLLATE utf8_unicode_ci NOT NULL,
  `group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pricenow` double NOT NULL,
  `amount` double NOT NULL,
  `rate` double NOT NULL,
  `itemname` text COLLATE utf8_unicode_ci NOT NULL,
  `itemnumber` text COLLATE utf8_unicode_ci NOT NULL,
  `deallinedate` date NOT NULL,
  `numberexpirydate` int(11) NOT NULL,
  `notes` text COLLATE utf8_unicode_ci NOT NULL,
  `storage` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `invoices`
--

INSERT INTO `invoices` (`id`, `invoicenumber`, `createdate`, `createby`, `itemid`, `cardid`, `fistname`, `lastname`, `fullname`, `idnumber`, `iddate`, `idlocation`, `phone`, `address`, `email`, `group`, `pricenow`, `amount`, `rate`, `itemname`, `itemnumber`, `deallinedate`, `numberexpirydate`, `notes`, `storage`, `status`) VALUES
(1, 'CD201609181', '2016-09-18 00:00:00', 'admin', 1, 2, 'Tèo', 'Trần', 'Trần Văn Tèo', '423423', '2016-09-14', 'An Giang', '242342342', '423 dfwefw', 'ewwerw@fsefe.com', 'phone', 7000000, 3000000, 3, 'Iphone 6', '423423423', '2016-10-18', 7, 'sdf aawdqaw', 't1', 'new'),
(2, 'CD201609191', '2016-09-19 00:00:00', 'admin', 4, 3, 'B', 'Nguyễn', 'Nguyễn Văn B', '123456789', '2016-09-20', 'An Giang', '3432423', '34 dsf wefwefw', 'etweij@gmail.com', 'computer', 3000000, 2000000, 5, 'Dell 2740p', '3423423', '2016-10-19', 5, 'edfw erwe', 't2', 'new'),
(3, 'CD201609192', '2016-09-19 00:00:00', 'admin', 0, 2, 'Tèo', 'Trần', 'Trần Văn Tèo', '423423', '2016-09-14', 'An Giang', '242342342', '423 dfwefw', 'ewwerw@fsefe.com', 'car', 20000000, 10000000, 4, 'Xe Vision', '', '2016-10-19', 10, 'dfg wewew', '', 'new');

-- --------------------------------------------------------

--
-- Table structure for table `invoices_info`
--

CREATE TABLE IF NOT EXISTS `invoices_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invoiceid` bigint(20) NOT NULL,
  `infoname` text COLLATE utf8_unicode_ci NOT NULL,
  `infovalue` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `invoices_info`
--

INSERT INTO `invoices_info` (`id`, `invoiceid`, `infoname`, `infovalue`) VALUES
(1, 1, 'type', 'Iphone'),
(2, 1, 'model', 'Iphone 6'),
(3, 1, 'attach', 'Adapter'),
(4, 2, 'type', 'Laptop'),
(5, 2, 'cpu', 'Core i3 4th'),
(6, 2, 'ram', '4G'),
(7, 2, 'hdd', '500G'),
(8, 2, 'attach', 'Sac + tui xach'),
(9, 1, 'info', 'eyJMb1x1MWVhMWkgXHUwMTEwVCI6IklwaG9uZSIsIk1vZGVsIjoiSXBob25lIDYiLCJLXHUwMGU4bSI6IlNhYyJ9'),
(10, 3, 'info', 'eyJMb1x1MWVhMWkgeGUiOiJUYXkgR2EiLCJCaVx1MWVjM24gc1x1MWVkMSI6IjUyTDMgLSA0NTY3MiIsIk5cdTAxMTBLIjoiMDFcLzA5XC8yMDE2IiwiU1x1MWVkMSBtXHUwMGUxeSI6IjU2NDY0NjQiLCJTLktodW5nIjoiNTQ2NDY0IiwiTS5TXHUwMWExbiI6IkRvIn0=');

-- --------------------------------------------------------

--
-- Table structure for table `invoices_log`
--

CREATE TABLE IF NOT EXISTS `invoices_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invoiceid` bigint(20) NOT NULL,
  `status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `notes` text COLLATE utf8_unicode_ci NOT NULL,
  `datelog` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `invoices_log`
--

INSERT INTO `invoices_log` (`id`, `invoiceid`, `status`, `notes`, `datelog`) VALUES
(1, 1, 'new', 'sdf aawdqaw', '2016-09-18 17:33:14'),
(2, 2, 'new', 'edfw erwe', '2016-09-19 16:47:37'),
(3, 3, 'new', 'dfg wewew', '2016-09-19 18:25:37');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `itemname` text COLLATE utf8_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `brand` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `files` text COLLATE utf8_unicode_ci NOT NULL,
  `link` text COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `itemname`, `price`, `brand`, `group`, `files`, `link`, `status`) VALUES
(1, 'Iphone 6', 7000000, 'Apple', 'phone', '', 'ádasđacsc', '50phantram'),
(4, 'Dell 2740p', 3000000, 'Dell', 'computer', '', 'sdfwef', '70phantram');

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE IF NOT EXISTS `language` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `languageid` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `code` varchar(5) NOT NULL,
  `locale` varchar(255) NOT NULL,
  `image` varchar(64) DEFAULT NULL,
  `directory` varchar(32) NOT NULL,
  `filename` varchar(64) NOT NULL,
  `sortOrder` int(3) DEFAULT NULL,
  `status` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id`, `languageid`, `name`, `code`, `locale`, `image`, `directory`, `filename`, `sortOrder`, `status`) VALUES
(1, 1, 'VietNam', 'vn', 'en_US.UTF-8,en_US,en-gb,vietnam', 'vn.png', 'vietnam', 'vietnam', 1, 1),
(2, 2, 'English', 'en', 'en_US.UTF-8,en_US,en-gb,english', 'en.png', 'english', 'english', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `userid` varchar(50) NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usertypeid` varchar(20) NOT NULL,
  `username` text,
  `password` text,
  `fullname` text NOT NULL,
  `email` text NOT NULL,
  `status` varchar(20) NOT NULL,
  `imageid` bigint(20) NOT NULL,
  `imagepath` text NOT NULL,
  `address` text NOT NULL,
  `provincecity` text NOT NULL,
  `country` text NOT NULL,
  `birthday` datetime NOT NULL,
  `phone` text NOT NULL,
  `activedate` datetime NOT NULL,
  `updateddate` datetime NOT NULL,
  `deleteddate` datetime NOT NULL,
  `activeby` varchar(50) NOT NULL,
  `updatedby` varchar(50) NOT NULL,
  `deletedby` varchar(50) NOT NULL,
  `userip` varchar(50) NOT NULL,
  `assignid` bigint(20) NOT NULL,
  `commissions` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userid`, `id`, `usertypeid`, `username`, `password`, `fullname`, `email`, `status`, `imageid`, `imagepath`, `address`, `provincecity`, `country`, `birthday`, `phone`, `activedate`, `updateddate`, `deleteddate`, `activeby`, `updatedby`, `deletedby`, `userip`, `assignid`, `commissions`) VALUES
('admin', 1, 'admin', 'admin', '827ccb0eea8a706c4c34a16891f84e7b', 'Administrator', 'thietho1982@gmail.com', 'active', 0, '', '', '', '', '0000-00-00 00:00:00', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '', '', '', '', 0, '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
