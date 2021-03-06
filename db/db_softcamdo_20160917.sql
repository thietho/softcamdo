-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 17, 2016 at 03:42 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `cards`
--

INSERT INTO `cards` (`id`, `fistname`, `lastname`, `fullname`, `idnumber`, `iddate`, `idlocation`, `phone`, `address`, `email`) VALUES
(2, 'Tèo', 'Trần', 'Trần Văn Tèo', '423423', '2016-09-14', 'An Giang', '242342342', '423 dfwefw', 'ewwerw@fsefe.com');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `categoryid`, `categoryname`, `parent`, `position`) VALUES
(3, 'Apple', 'Apple', 'brand', 1),
(2, 'brand', 'Hãng sản xuất', '', 2),
(4, 'Sony', 'Sony', 'brand', 2),
(5, 'Samsung', 'Samsung', 'brand', 3),
(6, 'status', 'Trạng thái', '', 3),
(7, 'new', 'Hàng mới', 'status', 1),
(8, 'secondhand', 'Hàng đã qua sử dụng', 'status', 2),
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Dumping data for table `group`
--

INSERT INTO `group` (`id`, `groupname`, `rate`, `groupid`) VALUES
(1, 'Máy tính', '5', 'computer'),
(3, 'Xe', '4', 'car'),
(4, 'Vàng', '3', 'gold'),
(5, 'Điện thoại', '3', 'phone');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE IF NOT EXISTS `invoices` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `invoiceid` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `createdate` datetime NOT NULL,
  `createby` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `itemid` bigint(20) NOT NULL,
  `fistname` text COLLATE utf8_unicode_ci NOT NULL,
  `lastname` text COLLATE utf8_unicode_ci NOT NULL,
  `fullname` text COLLATE utf8_unicode_ci NOT NULL,
  `idnumber` text COLLATE utf8_unicode_ci NOT NULL,
  `iddate` date NOT NULL,
  `idlocation` text COLLATE utf8_unicode_ci NOT NULL,
  `phone` text COLLATE utf8_unicode_ci NOT NULL,
  `group` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `valuenow` double NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

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
(1, 'Iphone 6', 7000000, 'Apple', 'phone', '', 'ádasđacsc', 'secondhand'),
(4, 'Dell 2740p', 3000000, 'Dell', 'computer', '', 'sdfwef', 'secondhand');

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
