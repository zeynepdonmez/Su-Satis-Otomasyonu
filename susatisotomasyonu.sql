/*
Navicat MySQL Data Transfer

Source Server         : javaproje
Source Server Version : 100113
Source Host           : localhost:3306
Source Database       : susatis

Target Server Type    : MYSQL
Target Server Version : 100113
File Encoding         : 65001

Date: 2016-06-27 02:45:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for kullanicilar
-- ----------------------------
DROP TABLE IF EXISTS `kullanicilar`;
CREATE TABLE `kullanicilar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adi` varchar(255) DEFAULT NULL,
  `sifre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin5;

-- ----------------------------
-- Records of kullanicilar
-- ----------------------------
INSERT INTO `kullanicilar` VALUES ('1', 'susatis', '1234');

-- ----------------------------
-- Table structure for musteriler
-- ----------------------------
DROP TABLE IF EXISTS `musteriler`;
CREATE TABLE `musteriler` (
  `musteri_id` int(11) NOT NULL AUTO_INCREMENT,
  `adi` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `soyadi` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  `telefon` int(11) DEFAULT NULL,
  `adres` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL,
  PRIMARY KEY (`musteri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin5;

-- ----------------------------
-- Records of musteriler
-- ----------------------------
INSERT INTO `musteriler` VALUES ('4', 'Nefise', 'Kartal', '2147483647', 'Balikesir');
INSERT INTO `musteriler` VALUES ('16', 'ZEYNEP', 'DÖNMEZ', '13424356', 'ERDEK');

-- ----------------------------
-- Table structure for siparisler
-- ----------------------------
DROP TABLE IF EXISTS `siparisler`;
CREATE TABLE `siparisler` (
  `siparis_id` int(11) NOT NULL AUTO_INCREMENT,
  `musteri_id` int(11) NOT NULL,
  `tur_id` int(11) NOT NULL,
  `durum` varchar(255) CHARACTER SET utf8 COLLATE utf8_turkish_ci DEFAULT NULL COMMENT '''iletildi''\r\n''beklemede''\r\n''iletilmedi''\r\n''default''\r\n',
  `siparis_tarihi` date DEFAULT NULL,
  `adet` int(11) DEFAULT NULL,
  PRIMARY KEY (`siparis_id`,`musteri_id`,`tur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin5;

-- ----------------------------
-- Records of siparisler
-- ----------------------------
INSERT INTO `siparisler` VALUES ('26', '6', '2', 'iletilmedi', '2016-06-26', '3');
INSERT INTO `siparisler` VALUES ('27', '7', '2', 'iletilmedi', '2016-06-26', '4');
INSERT INTO `siparisler` VALUES ('28', '1', '5', 'iletildi', '2016-06-26', '5');
INSERT INTO `siparisler` VALUES ('29', '1', '3', 'iletildi', '2016-06-26', '5');
INSERT INTO `siparisler` VALUES ('32', '5', '2', 'yolda', '2016-06-26', '3');
INSERT INTO `siparisler` VALUES ('33', '4', '2', 'iletilmedi', '2016-06-26', '1');
INSERT INTO `siparisler` VALUES ('34', '4', '1', 'iletilmedi', '2016-06-26', '1');
INSERT INTO `siparisler` VALUES ('35', '13', '2', 'iletilmedi', '2016-06-26', '1');
INSERT INTO `siparisler` VALUES ('36', '14', '3', 'iletilmedi', '2016-06-26', '1');

-- ----------------------------
-- Table structure for sucinsi
-- ----------------------------
DROP TABLE IF EXISTS `sucinsi`;
CREATE TABLE `sucinsi` (
  `tur_id` int(11) NOT NULL AUTO_INCREMENT,
  `boyut` varchar(11) DEFAULT NULL,
  `fiyat` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`tur_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin5;

-- ----------------------------
-- Records of sucinsi
-- ----------------------------
INSERT INTO `sucinsi` VALUES ('1', '5', '3');
INSERT INTO `sucinsi` VALUES ('2', '10', '5');
INSERT INTO `sucinsi` VALUES ('3', '20', '8');

-- ----------------------------
-- Procedure structure for adiSoyadi
-- ----------------------------
DROP PROCEDURE IF EXISTS `adiSoyadi`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `adiSoyadi`(IN `adi` varchar(255),IN `soyadi` varchar(255))
BEGIN
select * from musteriler where Adi=adi and Soyadi=soyadi;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncekle
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncekle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncekle`(IN `miktar` int(11),IN `tip` int(11),IN `id` int(11))
BEGIN
	
	insert into siparisler values(null,id,tip,'iletilmedi',now(),miktar);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fnctumsiparis
-- ----------------------------
DROP PROCEDURE IF EXISTS `fnctumsiparis`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fnctumsiparis`(IN `ilktarih` varchar(255),IN `sontarih` varchar(255))
BEGIN
select adi,soyadi,fiyat,durum,adet from siparisler 
LEFT JOIN musteriler  on musteriler.musteri_id=siparisler.musteri_id  
LEFT JOIN sucinsi on sucinsi.tur_id=siparisler.tur_id 
WHERE siparisler.siparis_tarihi BETWEEN ilktarih and sontarih;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncupdate
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncupdate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncupdate`(IN `adi` varchar(255),IN `soyadi` varchar(255),IN `telefon` varchar(255),IN `adres` varchar(255),IN `idd` int(11))
BEGIN
update musteriler  set Adi=adi,Soyadi=soyadi,Telefon=telefon,Adres=adres where musteri_id=idd ;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for fncupdate2
-- ----------------------------
DROP PROCEDURE IF EXISTS `fncupdate2`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fncupdate2`(IN `id` varchar(255),IN `tip` varchar(10),IN `miktar` int(10))
BEGIN
	insert into siparisler values(null,id,tip,'beklemede',now(),miktar,null);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for musteriekle
-- ----------------------------
DROP PROCEDURE IF EXISTS `musteriekle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `musteriekle`(IN `adi` varchar(250),IN `soyadi` varchar(250),IN `tel` varchar(250),IN `adres` varchar(250))
BEGIN
INSERT INTO musteriler VALUE (null,adi,soyadi,tel,adres);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for musterisil
-- ----------------------------
DROP PROCEDURE IF EXISTS `musterisil`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `musterisil`(IN `sil` varchar(255))
BEGIN
delete from musteriler where musteri_id=sil;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for siparisEkle
-- ----------------------------
DROP PROCEDURE IF EXISTS `siparisEkle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `siparisEkle`(IN `musteri_adi` varchar(255),IN `musteri_soyadi` varchar(255),IN `durum` varchar(255),IN `adres` varchar(255),IN `tutar` varchar(255))
BEGIN
INSERT INTO siparisler VALUE (null,musteri_adi,musteri_soyadi,durum,adres,tutar);

END
;;
DELIMITER ;
