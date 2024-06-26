-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: timekeeping_dev
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.22.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `active_storage_attachments`
--

DROP TABLE IF EXISTS `active_storage_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `active_storage_attachments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `record_type` varchar(255) NOT NULL,
  `record_id` bigint NOT NULL,
  `blob_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_attachments_uniqueness` (`record_type`,`record_id`,`name`,`blob_id`),
  KEY `index_active_storage_attachments_on_blob_id` (`blob_id`),
  CONSTRAINT `fk_rails_c3b3935057` FOREIGN KEY (`blob_id`) REFERENCES `active_storage_blobs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_attachments`
--

LOCK TABLES `active_storage_attachments` WRITE;
/*!40000 ALTER TABLE `active_storage_attachments` DISABLE KEYS */;
INSERT INTO `active_storage_attachments` VALUES (24,'avatar','User',32,24,'2024-06-14 03:59:15.011796'),(28,'avatar','User',44,28,'2024-06-22 03:42:07.595013');
/*!40000 ALTER TABLE `active_storage_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_storage_blobs`
--

DROP TABLE IF EXISTS `active_storage_blobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `active_storage_blobs` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `metadata` text,
  `service_name` varchar(255) NOT NULL,
  `byte_size` bigint NOT NULL,
  `checksum` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_blobs_on_key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_blobs`
--

LOCK TABLES `active_storage_blobs` WRITE;
/*!40000 ALTER TABLE `active_storage_blobs` DISABLE KEYS */;
INSERT INTO `active_storage_blobs` VALUES (24,'huk5c8ppc5s375ja7lvpo50kfo74','N2_NGUYENDUCMANH_25082002.jpg','image/jpeg','{\"identified\":true,\"analyzed\":true}','local',139897,'TLCPlVahErNYjfHpAs4LDw==','2024-06-14 03:59:15.007527'),(28,'b74nt7rpud92v3svdrnfu98v7kz0','surf & turf 4.jpg','image/jpeg','{\"identified\":true,\"analyzed\":true}','local',985138,'f1zSJMqdxqFZGJsLZZ7pYA==','2024-06-22 03:42:07.593672');
/*!40000 ALTER TABLE `active_storage_blobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `active_storage_variant_records`
--

DROP TABLE IF EXISTS `active_storage_variant_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `active_storage_variant_records` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blob_id` bigint NOT NULL,
  `variation_digest` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_active_storage_variant_records_uniqueness` (`blob_id`,`variation_digest`),
  CONSTRAINT `fk_rails_993965df05` FOREIGN KEY (`blob_id`) REFERENCES `active_storage_blobs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_storage_variant_records`
--

LOCK TABLES `active_storage_variant_records` WRITE;
/*!40000 ALTER TABLE `active_storage_variant_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_storage_variant_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ar_internal_metadata`
--

DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ar_internal_metadata`
--

LOCK TABLES `ar_internal_metadata` WRITE;
/*!40000 ALTER TABLE `ar_internal_metadata` DISABLE KEYS */;
INSERT INTO `ar_internal_metadata` VALUES ('environment','development','2024-05-11 14:04:46.069004','2024-05-11 14:04:46.069007'),('schema_sha1','fe6dbb61229dc78719bb07c90920130d59d6c712','2024-05-11 14:04:46.081702','2024-05-11 14:04:46.081703');
/*!40000 ALTER TABLE `ar_internal_metadata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendance_types`
--

DROP TABLE IF EXISTS `attendance_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendance_types` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendance_types`
--

LOCK TABLES `attendance_types` WRITE;
/*!40000 ALTER TABLE `attendance_types` DISABLE KEYS */;
INSERT INTO `attendance_types` VALUES (1,'Check in','2024-05-13 02:29:35.942900','2024-06-11 03:44:46.683173'),(2,'Check out','2024-05-13 02:29:35.959614','2024-06-11 03:44:53.997894');
/*!40000 ALTER TABLE `attendance_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendances`
--

DROP TABLE IF EXISTS `attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendances` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `attendance_type_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `time_check` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_77ad02f5c5` (`user_id`),
  KEY `fk_rails_65c18d8303` (`attendance_type_id`),
  CONSTRAINT `fk_rails_65c18d8303` FOREIGN KEY (`attendance_type_id`) REFERENCES `attendance_types` (`id`),
  CONSTRAINT `fk_rails_77ad02f5c5` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (283,'2024-06-21',44,1,'2024-06-21 03:57:45','01:00:00'),(284,'2024-06-21',44,2,'2024-06-21 03:57:57','10:00:00'),(286,'2024-06-15',44,2,'2024-06-21 03:59:59','10:00:00'),(288,'2024-05-01',44,1,'2024-06-21 04:01:26','01:00:00'),(289,'2024-05-01',44,2,'2024-06-21 04:01:31','10:00:00'),(297,'2024-06-15',44,1,'2024-06-21 06:58:49','01:00:00'),(303,'2024-04-02',44,1,'2024-06-21 07:38:55','03:00:00'),(304,'2024-04-02',44,2,'2024-06-21 07:39:02','12:00:00'),(311,'2024-04-02',44,2,'2024-06-21 07:58:26','11:59:59'),(312,'2024-04-03',44,1,'2024-06-21 19:40:19','01:00:00'),(313,'2024-06-22',32,1,'2024-06-21 19:52:31','02:52:31'),(314,'2024-06-22',32,2,'2024-06-21 19:52:33','02:52:33'),(315,'2024-06-22',32,1,'2024-06-21 19:52:52','02:52:52'),(316,'2024-06-22',32,1,'2024-06-21 19:55:12','02:55:12'),(317,'2024-06-22',44,1,'2024-06-21 20:07:46','03:07:46'),(318,'2024-06-22',44,2,'2024-06-21 20:07:52','03:07:52'),(323,'2024-06-22',44,1,'2024-06-21 20:45:44','01:00:00'),(326,'2024-06-22',44,2,'2024-06-22 03:16:23','10:16:22');
/*!40000 ALTER TABLE `attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'Phòng 1','2024-05-11 19:46:37'),(2,'Phòng 2','2024-05-12 19:41:12'),(3,'Phòng 3','2024-05-12 19:41:13'),(4,'Phòng 4','2024-05-12 19:41:13'),(5,'Phòng 5','2024-05-12 19:41:13'),(6,'Phòng 6','2024-05-12 19:41:13');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `face_data`
--

DROP TABLE IF EXISTS `face_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `face_data` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_25b1d77efc` (`user_id`),
  CONSTRAINT `fk_rails_25b1d77efc` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5251 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `face_data`
--

LOCK TABLES `face_data` WRITE;
/*!40000 ALTER TABLE `face_data` DISABLE KEYS */;
INSERT INTO `face_data` VALUES (1488,44,NULL),(1489,44,NULL),(1490,44,NULL),(1491,44,NULL),(1492,44,NULL),(1493,44,NULL),(1494,44,NULL),(1495,44,NULL),(1496,44,NULL),(1497,44,NULL),(1498,44,NULL),(1499,44,NULL),(1500,44,NULL),(1501,44,NULL),(1502,44,NULL),(1503,44,NULL),(1504,44,NULL),(1505,44,NULL),(1506,44,NULL),(1507,44,NULL),(1508,44,NULL),(1509,44,NULL),(1510,44,NULL),(1511,44,NULL),(1512,44,NULL),(1513,44,NULL),(1514,44,NULL),(1515,44,NULL),(1516,44,NULL),(1517,44,NULL),(1518,44,NULL),(1519,44,NULL),(1520,44,NULL),(1521,44,NULL),(1522,44,NULL),(1523,44,NULL),(1524,44,NULL),(1525,44,NULL),(1526,44,NULL),(1527,44,NULL),(1528,44,NULL),(1529,44,NULL),(1530,44,NULL),(1531,44,NULL),(1532,44,NULL),(1533,44,NULL),(1534,44,NULL),(1535,44,NULL),(1536,44,NULL),(1537,44,NULL),(1538,44,NULL),(1539,44,NULL),(1540,44,NULL),(1541,44,NULL),(1542,44,NULL),(1543,44,NULL),(1544,44,NULL),(1545,44,NULL),(1546,44,NULL),(1547,44,NULL),(1548,44,NULL),(1549,44,NULL),(1550,44,NULL),(1551,44,NULL),(1552,44,NULL),(1553,44,NULL),(1554,44,NULL),(1555,44,NULL),(1556,44,NULL),(1557,44,NULL),(1558,44,NULL),(1559,44,NULL),(1560,44,NULL),(1561,44,NULL),(1562,44,NULL),(1563,44,NULL),(1564,44,NULL),(1565,44,NULL),(1566,44,NULL),(1567,44,NULL),(1568,44,NULL),(1569,44,NULL),(1570,44,NULL),(1571,44,NULL),(1572,44,NULL),(1573,44,NULL),(1574,44,NULL),(1575,44,NULL),(1576,44,NULL),(1577,44,NULL),(1578,44,NULL),(1579,44,NULL),(1580,44,NULL),(1581,44,NULL),(1582,44,NULL),(1583,44,NULL),(1584,44,NULL),(1585,44,NULL),(1586,53,NULL),(1587,53,NULL),(1588,53,NULL),(1589,53,NULL),(1590,53,NULL),(1591,53,NULL),(1592,53,NULL),(1593,53,NULL),(1594,53,NULL),(1595,53,NULL),(1596,53,NULL),(1597,53,NULL),(1598,53,NULL),(1599,53,NULL),(1600,53,NULL),(1601,53,NULL),(1602,53,NULL),(1603,53,NULL),(1604,53,NULL),(1605,53,NULL),(1606,53,NULL),(1607,53,NULL),(1608,53,NULL),(1609,53,NULL),(1610,53,NULL),(1611,53,NULL),(1612,53,NULL),(1613,53,NULL),(1614,53,NULL),(1615,53,NULL),(1616,53,NULL),(1617,53,NULL),(1618,53,NULL),(1619,53,NULL),(1620,53,NULL),(1621,53,NULL),(1622,53,NULL),(1623,53,NULL),(1624,53,NULL),(1625,53,NULL),(1626,53,NULL),(1627,53,NULL),(1628,53,NULL),(1629,53,NULL),(1630,53,NULL),(1631,53,NULL),(1632,53,NULL),(1633,53,NULL),(1634,53,NULL),(1635,53,NULL),(1636,53,NULL),(1637,53,NULL),(1638,53,NULL),(1639,53,NULL),(1640,53,NULL),(1641,53,NULL),(1642,53,NULL),(1643,53,NULL),(1644,53,NULL),(1645,53,NULL),(1646,53,NULL),(1647,53,NULL),(1648,53,NULL),(1649,53,NULL),(1650,53,NULL),(1651,53,NULL),(1652,53,NULL),(1653,53,NULL),(1654,53,NULL),(1655,53,NULL),(1656,53,NULL),(1657,53,NULL),(1658,53,NULL),(1659,53,NULL),(1660,53,NULL),(1661,53,NULL),(1662,53,NULL),(1663,53,NULL),(1664,53,NULL),(1665,53,NULL),(1666,53,NULL),(1667,53,NULL),(1668,53,NULL),(1669,53,NULL),(1670,53,NULL),(1671,53,NULL),(1672,53,NULL),(1673,53,NULL),(1674,53,NULL),(1675,53,NULL),(1676,53,NULL),(1677,53,NULL),(1678,53,NULL),(1679,53,NULL),(1680,53,NULL),(1681,53,NULL),(1682,53,NULL),(1683,53,NULL),(1684,53,NULL),(1685,53,NULL),(1686,53,NULL),(1687,53,NULL),(1688,53,NULL),(1689,53,NULL),(1690,53,NULL),(1691,53,NULL),(1692,53,NULL),(1693,53,NULL),(1694,53,NULL),(1695,54,NULL),(1696,54,NULL),(1697,54,NULL),(1698,54,NULL),(1699,54,NULL),(1700,54,NULL),(1701,54,NULL),(1702,54,NULL),(1703,54,NULL),(1704,54,NULL),(1705,54,NULL),(1706,54,NULL),(1707,54,NULL),(1708,54,NULL),(1709,54,NULL),(1710,54,NULL),(1711,54,NULL),(1712,54,NULL),(1713,54,NULL),(1714,54,NULL),(1715,54,NULL),(1716,54,NULL),(1717,54,NULL),(1718,54,NULL),(1719,54,NULL),(1720,54,NULL),(1721,54,NULL),(1722,54,NULL),(1723,54,NULL),(1724,54,NULL),(1725,54,NULL),(1726,54,NULL),(1727,54,NULL),(1728,54,NULL),(1729,54,NULL),(1730,54,NULL),(1731,54,NULL),(1732,54,NULL),(1733,54,NULL),(1734,54,NULL),(1735,54,NULL),(1736,54,NULL),(1737,54,NULL),(1738,54,NULL),(1739,54,NULL),(1740,54,NULL),(1741,54,NULL),(1742,54,NULL),(1743,54,NULL),(1744,54,NULL),(1745,54,NULL),(1746,54,NULL),(1747,54,NULL),(1748,54,NULL),(1749,54,NULL),(1750,54,NULL),(1751,54,NULL),(1752,54,NULL),(1753,54,NULL),(1754,54,NULL),(1755,54,NULL),(1756,54,NULL),(1757,54,NULL),(1758,54,NULL),(1759,54,NULL),(1760,54,NULL),(1761,55,NULL),(1762,55,NULL),(1763,55,NULL),(1764,55,NULL),(1765,55,NULL),(1766,55,NULL),(1767,55,NULL),(1768,55,NULL),(1769,55,NULL),(1770,55,NULL),(1771,55,NULL),(1772,55,NULL),(1773,55,NULL),(1774,55,NULL),(1775,55,NULL),(1776,55,NULL),(1777,55,NULL),(1778,55,NULL),(1779,55,NULL),(1780,55,NULL),(1781,55,NULL),(1782,55,NULL),(1783,55,NULL),(1784,55,NULL),(1785,55,NULL),(1786,55,NULL),(1787,55,NULL),(1788,55,NULL),(1789,55,NULL),(1790,55,NULL),(1791,55,NULL),(1792,55,NULL),(1793,55,NULL),(1794,55,NULL),(1795,55,NULL),(1796,56,NULL),(1797,56,NULL),(1798,56,NULL),(1799,56,NULL),(1800,56,NULL),(1801,56,NULL),(1802,56,NULL),(1803,56,NULL),(1804,56,NULL),(1805,56,NULL),(1806,56,NULL),(1807,56,NULL),(1808,56,NULL),(1809,56,NULL),(1810,56,NULL),(1811,56,NULL),(1812,56,NULL),(1813,56,NULL),(1814,56,NULL),(1815,56,NULL),(1816,56,NULL),(1817,56,NULL),(1818,56,NULL),(1819,56,NULL),(1820,56,NULL),(1821,56,NULL),(1822,56,NULL),(1823,56,NULL),(1824,56,NULL),(1825,56,NULL),(1826,56,NULL),(1827,56,NULL),(1828,56,NULL),(1829,56,NULL),(1830,56,NULL),(1831,57,NULL),(1832,57,NULL),(1833,57,NULL),(1834,57,NULL),(1835,57,NULL),(1836,57,NULL),(1837,57,NULL),(1838,57,NULL),(1839,57,NULL),(1840,57,NULL),(1841,57,NULL),(1842,57,NULL),(1843,57,NULL),(1844,57,NULL),(1845,57,NULL),(1846,57,NULL),(1847,57,NULL),(1848,57,NULL),(1849,57,NULL),(1850,57,NULL),(1851,57,NULL),(1852,57,NULL),(1853,57,NULL),(1854,57,NULL),(1855,57,NULL),(1856,57,NULL),(1857,57,NULL),(1858,57,NULL),(1859,57,NULL),(1860,57,NULL),(1861,57,NULL),(1862,57,NULL),(1863,57,NULL),(1864,57,NULL),(1865,57,NULL),(1866,57,NULL),(1867,57,NULL),(1868,57,NULL),(1869,57,NULL),(1870,57,NULL),(1871,57,NULL),(1872,57,NULL),(1873,57,NULL),(1874,57,NULL),(1875,57,NULL),(1876,57,NULL),(1877,57,NULL),(1878,57,NULL),(1879,57,NULL),(1880,57,NULL),(1881,57,NULL),(1882,57,NULL),(1883,57,NULL),(1884,57,NULL),(1885,57,NULL),(1886,57,NULL),(1887,57,NULL),(1888,57,NULL),(1889,57,NULL),(1890,57,NULL),(1891,57,NULL),(1892,57,NULL),(1893,57,NULL),(1894,57,NULL),(1895,57,NULL),(1896,57,NULL),(1897,57,NULL),(1898,57,NULL),(1899,57,NULL),(1900,57,NULL),(1901,57,NULL),(1902,57,NULL),(1903,57,NULL),(1904,57,NULL),(1905,57,NULL),(1906,57,NULL),(1907,57,NULL),(1908,57,NULL),(1909,58,NULL),(1910,58,NULL),(1911,58,NULL),(1912,58,NULL),(1913,58,NULL),(1914,58,NULL),(1915,58,NULL),(1916,58,NULL),(1917,58,NULL),(1918,58,NULL),(1919,58,NULL),(1920,58,NULL),(1921,58,NULL),(1922,58,NULL),(1923,58,NULL),(1924,58,NULL),(1925,58,NULL),(1926,58,NULL),(1927,58,NULL),(1928,58,NULL),(1929,58,NULL),(1930,58,NULL),(1931,58,NULL),(1932,58,NULL),(1933,58,NULL),(1934,58,NULL),(1935,58,NULL),(1936,58,NULL),(1937,58,NULL),(1938,58,NULL),(1939,58,NULL),(1940,58,NULL),(1941,58,NULL),(1942,58,NULL),(1943,58,NULL),(1944,58,NULL),(1945,58,NULL),(1946,58,NULL),(1947,58,NULL),(1948,58,NULL),(1949,58,NULL),(1950,58,NULL),(1951,58,NULL),(1952,58,NULL),(1953,59,NULL),(1954,59,NULL),(1955,59,NULL),(1956,59,NULL),(1957,59,NULL),(1958,59,NULL),(1959,59,NULL),(1960,59,NULL),(1961,59,NULL),(1962,59,NULL),(1963,59,NULL),(1964,59,NULL),(1965,59,NULL),(1966,59,NULL),(1967,59,NULL),(1968,59,NULL),(1969,59,NULL),(1970,59,NULL),(1971,59,NULL),(1972,59,NULL),(1973,59,NULL),(1974,59,NULL),(1975,59,NULL),(1976,59,NULL),(1977,59,NULL),(1978,59,NULL),(1979,59,NULL),(1980,59,NULL),(1981,59,NULL),(1982,59,NULL),(1983,59,NULL),(1984,59,NULL),(1985,59,NULL),(1986,59,NULL),(1987,59,NULL),(1988,59,NULL),(1989,59,NULL),(1990,59,NULL),(1991,59,NULL),(1992,59,NULL),(1993,59,NULL),(1994,59,NULL),(1995,59,NULL),(1996,59,NULL),(1997,59,NULL),(1998,59,NULL),(1999,59,NULL),(2000,59,NULL),(2001,59,NULL),(2002,60,NULL),(2003,60,NULL),(2004,60,NULL),(2005,60,NULL),(2006,60,NULL),(2007,60,NULL),(2008,60,NULL),(2009,60,NULL),(2010,60,NULL),(2011,60,NULL),(2012,60,NULL),(2013,60,NULL),(2014,60,NULL),(2015,60,NULL),(2016,60,NULL),(2017,60,NULL),(2018,60,NULL),(2019,60,NULL),(2020,60,NULL),(2021,60,NULL),(2022,60,NULL),(2023,60,NULL),(2024,60,NULL),(2025,60,NULL),(2026,60,NULL),(2027,60,NULL),(2028,60,NULL),(2029,60,NULL),(2030,60,NULL),(2031,60,NULL),(2032,60,NULL),(2033,60,NULL),(2034,60,NULL),(2035,60,NULL),(2036,60,NULL),(2037,60,NULL),(2038,60,NULL),(2039,60,NULL),(2040,60,NULL),(2041,61,NULL),(2042,61,NULL),(2043,61,NULL),(2044,61,NULL),(2045,61,NULL),(2046,61,NULL),(2047,61,NULL),(2048,61,NULL),(2049,61,NULL),(2050,61,NULL),(2051,61,NULL),(2052,61,NULL),(2053,61,NULL),(2054,61,NULL),(2055,61,NULL),(2056,61,NULL),(2057,61,NULL),(2058,61,NULL),(2059,61,NULL),(2060,61,NULL),(2061,61,NULL),(2062,61,NULL),(2063,61,NULL),(2064,61,NULL),(2065,61,NULL),(2066,61,NULL),(2067,61,NULL),(2068,61,NULL),(2069,61,NULL),(2070,61,NULL),(2071,61,NULL),(2072,61,NULL),(2073,61,NULL),(2074,61,NULL),(2075,61,NULL),(2076,61,NULL),(2077,61,NULL),(2078,61,NULL),(2079,61,NULL),(2080,61,NULL),(2081,61,NULL),(2082,61,NULL),(2083,61,NULL),(2084,61,NULL),(2085,61,NULL),(2086,61,NULL),(2087,61,NULL),(2088,61,NULL),(2089,61,NULL),(2090,61,NULL),(2091,61,NULL),(2092,61,NULL),(2093,61,NULL),(2094,61,NULL),(2095,61,NULL),(2096,61,NULL),(2097,61,NULL),(2098,61,NULL),(2099,61,NULL),(2100,61,NULL),(2101,61,NULL),(2102,61,NULL),(2103,61,NULL),(2104,61,NULL),(2105,61,NULL),(2106,61,NULL),(2107,62,NULL),(2108,62,NULL),(2109,62,NULL),(2110,62,NULL),(2111,62,NULL),(2112,62,NULL),(2113,62,NULL),(2114,62,NULL),(2115,62,NULL),(2116,62,NULL),(2117,62,NULL),(2118,62,NULL),(2119,62,NULL),(2120,62,NULL),(2121,62,NULL),(2122,62,NULL),(2123,62,NULL),(2124,62,NULL),(2125,62,NULL),(2126,62,NULL),(2127,62,NULL),(2128,62,NULL),(2129,62,NULL),(2130,62,NULL),(2131,62,NULL),(2132,62,NULL),(2133,62,NULL),(2134,62,NULL),(2135,62,NULL),(2136,62,NULL),(2137,62,NULL),(2138,62,NULL),(2139,62,NULL),(2140,62,NULL),(2141,62,NULL),(2142,62,NULL),(2143,62,NULL),(2144,62,NULL),(2145,62,NULL),(2146,62,NULL),(2147,62,NULL),(2148,62,NULL),(2149,62,NULL),(2150,62,NULL),(2151,62,NULL),(2152,62,NULL),(2153,62,NULL),(2154,63,NULL),(2155,63,NULL),(2156,63,NULL),(2157,63,NULL),(2158,63,NULL),(2159,63,NULL),(2160,63,NULL),(2161,63,NULL),(2162,63,NULL),(2163,63,NULL),(2164,63,NULL),(2165,63,NULL),(2166,63,NULL),(2167,63,NULL),(2168,63,NULL),(2169,63,NULL),(2170,63,NULL),(2171,63,NULL),(2172,63,NULL),(2173,63,NULL),(2174,63,NULL),(2175,63,NULL),(2176,63,NULL),(2177,63,NULL),(2178,63,NULL),(2179,63,NULL),(2180,63,NULL),(2181,63,NULL),(2182,63,NULL),(2183,63,NULL),(2184,63,NULL),(2185,63,NULL),(2186,63,NULL),(2187,63,NULL),(2188,63,NULL),(2189,63,NULL),(2190,63,NULL),(2191,63,NULL),(2192,63,NULL),(2193,63,NULL),(2194,63,NULL),(2195,63,NULL),(2196,63,NULL),(2197,63,NULL),(2198,63,NULL),(2199,63,NULL),(2200,63,NULL),(2201,63,NULL),(2202,63,NULL),(2203,63,NULL),(2204,63,NULL),(2205,63,NULL),(2206,63,NULL),(2207,63,NULL),(2208,63,NULL),(2209,63,NULL),(2210,63,NULL),(2211,64,NULL),(2212,64,NULL),(2213,64,NULL),(2214,64,NULL),(2215,64,NULL),(2216,64,NULL),(2217,64,NULL),(2218,64,NULL),(2219,64,NULL),(2220,64,NULL),(2221,64,NULL),(2222,64,NULL),(2223,64,NULL),(2224,64,NULL),(2225,64,NULL),(2226,64,NULL),(2227,64,NULL),(2228,64,NULL),(2229,64,NULL),(2230,64,NULL),(2231,64,NULL),(2232,64,NULL),(2233,64,NULL),(2234,64,NULL),(2235,64,NULL),(2236,64,NULL),(2237,64,NULL),(2238,64,NULL),(2239,64,NULL),(2240,64,NULL),(2241,64,NULL),(2242,64,NULL),(2243,64,NULL),(2244,64,NULL),(2245,64,NULL),(2246,64,NULL),(2247,64,NULL),(2248,64,NULL),(2249,64,NULL),(2250,64,NULL),(2251,64,NULL),(2252,64,NULL),(2253,64,NULL),(2254,64,NULL),(2255,64,NULL),(2256,64,NULL),(2257,64,NULL),(2258,64,NULL),(2259,64,NULL),(2260,64,NULL),(2261,64,NULL),(2262,64,NULL),(2263,64,NULL),(2264,64,NULL),(2265,64,NULL),(2266,64,NULL),(2267,64,NULL),(2268,64,NULL),(2269,64,NULL),(2270,64,NULL),(2271,64,NULL),(2272,64,NULL),(2273,64,NULL),(2274,64,NULL),(2275,64,NULL),(2276,64,NULL),(2277,64,NULL),(2278,64,NULL),(2279,64,NULL),(2280,64,NULL),(2281,64,NULL),(2282,64,NULL),(2283,64,NULL),(2284,64,NULL),(2285,69,NULL),(2286,69,NULL),(2287,69,NULL),(2288,69,NULL),(2289,69,NULL),(2290,69,NULL),(2291,69,NULL),(2292,69,NULL),(2293,69,NULL),(2294,69,NULL),(2295,69,NULL),(2296,69,NULL),(2297,69,NULL),(2298,69,NULL),(2299,69,NULL),(2300,69,NULL),(2301,69,NULL),(2302,69,NULL),(2303,69,NULL),(2304,69,NULL),(2305,69,NULL),(2306,69,NULL),(2307,69,NULL),(2308,69,NULL),(2309,69,NULL),(2310,69,NULL),(2311,69,NULL),(2312,69,NULL),(2313,69,NULL),(2314,69,NULL),(2315,69,NULL),(2316,69,NULL),(2317,69,NULL),(2318,69,NULL),(2319,69,NULL),(2320,69,NULL),(2321,69,NULL),(2322,69,NULL),(2323,69,NULL),(2324,69,NULL),(2325,69,NULL),(2326,69,NULL),(2327,69,NULL),(2328,69,NULL),(2329,69,NULL),(2330,69,NULL),(2331,69,NULL),(2332,69,NULL),(2333,70,NULL),(2334,70,NULL),(2335,70,NULL),(2336,70,NULL),(2337,70,NULL),(2338,70,NULL),(2339,70,NULL),(2340,70,NULL),(2341,70,NULL),(2342,70,NULL),(2343,70,NULL),(2344,70,NULL),(2345,70,NULL),(2346,70,NULL),(2347,70,NULL),(2348,70,NULL),(2349,70,NULL),(2350,70,NULL),(2351,70,NULL),(2352,70,NULL),(2353,70,NULL),(2354,70,NULL),(2355,70,NULL),(2356,70,NULL),(2357,70,NULL),(2358,70,NULL),(2359,70,NULL),(2360,70,NULL),(2361,70,NULL),(2362,70,NULL),(2363,70,NULL),(2364,70,NULL),(2365,70,NULL),(2366,70,NULL),(2367,70,NULL),(2368,70,NULL),(2369,70,NULL),(2370,70,NULL),(2371,70,NULL),(2372,70,NULL),(2373,70,NULL),(2374,70,NULL),(2375,70,NULL),(2376,70,NULL),(2377,70,NULL),(2378,70,NULL),(2379,70,NULL),(2380,70,NULL),(2381,70,NULL),(2382,44,NULL),(2383,44,NULL),(2384,44,NULL),(2385,44,NULL),(2386,44,NULL),(2387,44,NULL),(2388,44,NULL),(2389,44,NULL),(2390,44,NULL),(2391,44,NULL),(2392,44,NULL),(2393,44,NULL),(2394,82,NULL),(2395,82,NULL),(2396,82,NULL),(2397,82,NULL),(2398,82,NULL),(2399,82,NULL),(2400,82,NULL),(2401,82,NULL),(2402,82,NULL),(2403,82,NULL),(2404,82,NULL),(2405,82,NULL),(2406,82,NULL),(2407,82,NULL),(2408,82,NULL),(2409,82,NULL),(2410,82,NULL),(2411,82,NULL),(2412,82,NULL),(2413,82,NULL),(2414,82,NULL),(2415,82,NULL),(2416,82,NULL),(2417,82,NULL),(2418,82,NULL),(2419,82,NULL),(2420,82,NULL),(2421,82,NULL),(2422,82,NULL),(2423,82,NULL),(2424,82,NULL),(2425,82,NULL),(2426,82,NULL),(2427,82,NULL),(2428,82,NULL),(2429,82,NULL),(2430,82,NULL),(2431,82,NULL),(2432,82,NULL),(2433,82,NULL),(2434,82,NULL),(2435,82,NULL),(2436,82,NULL),(2437,82,NULL),(2438,82,NULL),(2439,82,NULL),(2440,82,NULL),(2441,82,NULL),(2442,82,NULL),(2443,82,NULL),(2444,82,NULL),(2445,82,NULL),(2446,82,NULL),(2447,82,NULL),(2448,82,NULL),(2449,82,NULL),(2450,82,NULL),(2451,82,NULL),(2452,82,NULL),(2453,82,NULL),(2454,82,NULL),(2455,83,NULL),(2456,83,NULL),(2457,83,NULL),(2458,83,NULL),(2459,83,NULL),(2460,83,NULL),(2461,83,NULL),(2462,83,NULL),(2463,83,NULL),(2464,83,NULL),(2465,83,NULL),(2466,83,NULL),(2467,83,NULL),(2468,83,NULL),(2469,83,NULL),(2470,83,NULL),(2471,83,NULL),(2472,83,NULL),(2473,83,NULL),(2474,83,NULL),(2475,83,NULL),(2476,83,NULL),(2477,83,NULL),(2478,83,NULL),(2479,83,NULL),(2480,83,NULL),(2481,83,NULL),(2482,83,NULL),(2483,83,NULL),(2484,83,NULL),(2485,83,NULL),(2486,83,NULL),(2487,83,NULL),(2488,83,NULL),(2489,83,NULL),(2490,83,NULL),(2491,83,NULL),(2492,83,NULL),(2493,83,NULL),(2494,83,NULL),(2495,83,NULL),(2496,83,NULL),(2497,83,NULL),(2498,83,NULL),(2499,83,NULL),(2500,83,NULL),(2501,83,NULL),(2502,83,NULL),(2503,83,NULL),(2504,83,NULL),(2505,83,NULL),(2506,83,NULL),(2507,83,NULL),(2508,83,NULL),(2509,83,NULL),(2510,83,NULL),(2511,83,NULL),(2512,83,NULL),(2513,83,NULL),(2514,83,NULL),(2515,83,NULL),(2516,83,NULL),(2517,83,NULL),(2518,83,NULL),(2519,83,NULL),(2520,83,NULL),(2521,83,NULL),(2522,83,NULL),(2523,83,NULL),(2524,83,NULL),(2525,83,NULL),(2526,83,NULL),(2527,83,NULL),(2528,83,NULL),(2529,83,NULL),(2530,83,NULL),(2531,83,NULL),(2532,83,NULL),(2533,83,NULL),(2534,83,NULL),(2535,83,NULL),(2536,83,NULL),(2537,83,NULL),(2538,83,NULL),(2539,83,NULL),(2540,83,NULL),(2541,84,NULL),(2542,84,NULL),(2543,84,NULL),(2544,84,NULL),(2545,84,NULL),(2546,84,NULL),(2547,84,NULL),(2548,84,NULL),(2549,84,NULL),(2550,84,NULL),(2551,84,NULL),(2552,84,NULL),(2553,84,NULL),(2554,84,NULL),(2555,84,NULL),(2556,84,NULL),(2557,84,NULL),(2558,84,NULL),(2559,84,NULL),(2560,84,NULL),(2561,84,NULL),(2562,84,NULL),(2563,84,NULL),(2564,84,NULL),(2565,84,NULL),(2566,84,NULL),(2567,84,NULL),(2568,84,NULL),(2569,84,NULL),(2570,84,NULL),(2571,84,NULL),(2572,84,NULL),(2573,84,NULL),(2574,84,NULL),(2575,84,NULL),(2576,84,NULL),(2577,84,NULL),(2578,84,NULL),(2579,84,NULL),(2580,84,NULL),(2581,84,NULL),(2582,84,NULL),(2583,84,NULL),(2584,44,NULL),(2585,44,NULL),(2586,44,NULL),(2587,44,NULL),(2588,44,NULL),(2589,44,NULL),(2590,44,NULL),(2591,44,NULL),(2592,44,NULL),(2593,44,NULL),(2594,44,NULL),(2595,44,NULL),(2596,44,NULL);
/*!40000 ALTER TABLE `face_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holidays`
--

DROP TABLE IF EXISTS `holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `holidays` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `holiday_date` date DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holidays`
--

LOCK TABLES `holidays` WRITE;
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
INSERT INTO `holidays` VALUES (1,'2024-01-01','Tết Dương Lịch','2024-06-21 03:37:50'),(2,'2024-04-18','Giỗ Tổ Hùng Vương','2024-06-21 03:37:50'),(3,'2024-04-30','Ngày Giải Phóng Miền Nam','2024-06-21 03:37:50'),(4,'2024-05-01','Ngày Quốc Tế Lao Động','2024-06-21 03:37:50'),(5,'2024-09-02','Ngày Quốc Khánh','2024-06-21 03:37:50'),(6,'2024-09-03','Ngày Quốc Khánh (Nghỉ bù)','2024-06-21 03:37:50');
/*!40000 ALTER TABLE `holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `label` varchar(255) DEFAULT NULL,
  `day` date DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_notes_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_7f2323ad43` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `date` date NOT NULL,
  `attendance_type_id` bigint NOT NULL,
  `time_check` time DEFAULT NULL,
  `approved` tinyint(1) DEFAULT '0',
  `reason` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_reports_on_user_id` (`user_id`),
  KEY `index_reports_on_attendance_type_id` (`attendance_type_id`),
  CONSTRAINT `fk_rails_99cb148a6e` FOREIGN KEY (`attendance_type_id`) REFERENCES `attendance_types` (`id`),
  CONSTRAINT `fk_rails_c7699d537d` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,44,'2024-06-22',1,'08:00:00',1,'Late check-in','2024-06-22 04:42:27.563392','2024-06-22 04:46:51.427514'),(6,44,'2024-06-22',2,'17:48:00',1,'Forgot checkout','2024-06-22 09:48:48.773458','2024-06-22 09:49:11.534866'),(12,44,'2024-06-22',2,'10:14:00',1,'Forgot checkout','2024-06-22 10:14:20.282529','2024-06-22 11:30:57.389303');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salaries`
--

DROP TABLE IF EXISTS `salaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salaries` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `date` date NOT NULL,
  `total_salary` decimal(10,2) DEFAULT '0.00',
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_salaries_on_user_id` (`user_id`),
  CONSTRAINT `fk_rails_127539cef3` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1024 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salaries`
--

LOCK TABLES `salaries` WRITE;
/*!40000 ALTER TABLE `salaries` DISABLE KEYS */;
INSERT INTO `salaries` VALUES (744,32,'2024-06-01',0.00,'2024-06-21 14:05:16.649973','2024-06-21 14:05:16.649973'),(745,32,'2024-05-01',0.00,'2024-06-21 14:05:16.663427','2024-06-21 14:05:16.663427'),(746,32,'2024-04-01',0.00,'2024-06-21 14:05:16.677925','2024-06-21 14:05:16.677925'),(747,32,'2024-03-01',0.00,'2024-06-21 14:05:16.692678','2024-06-21 14:05:16.692678'),(748,32,'2024-02-01',0.00,'2024-06-21 14:05:16.714699','2024-06-21 14:05:16.714699'),(749,32,'2024-01-01',0.00,'2024-06-21 14:05:16.729049','2024-06-21 14:05:16.729049'),(750,32,'2023-12-01',0.00,'2024-06-21 14:05:16.742553','2024-06-21 14:05:16.742553'),(751,32,'2023-11-01',0.00,'2024-06-21 14:05:16.756108','2024-06-21 14:05:16.756108'),(752,32,'2023-10-01',0.00,'2024-06-21 14:05:16.770309','2024-06-21 14:05:16.770309'),(753,32,'2023-09-01',0.00,'2024-06-21 14:05:16.785011','2024-06-21 14:05:16.785011'),(754,32,'2023-08-01',0.00,'2024-06-21 14:05:16.798806','2024-06-21 14:05:16.798806'),(755,32,'2023-07-01',0.00,'2024-06-21 14:05:16.812027','2024-06-21 14:05:16.812027'),(1012,44,'2024-06-01',9721500.00,'2024-06-22 13:01:59.921189','2024-06-22 13:01:59.921189'),(1013,44,'2024-05-01',7200000.00,'2024-06-22 13:01:59.945516','2024-06-22 13:01:59.945516'),(1014,44,'2024-04-01',2340000.00,'2024-06-22 13:01:59.965557','2024-06-22 13:01:59.965557'),(1015,44,'2024-03-01',0.00,'2024-06-22 13:01:59.991774','2024-06-22 13:01:59.991774'),(1016,44,'2024-02-01',0.00,'2024-06-22 13:02:00.011396','2024-06-22 13:02:00.011396'),(1017,44,'2024-01-01',0.00,'2024-06-22 13:02:00.037659','2024-06-22 13:02:00.037659'),(1018,44,'2023-12-01',0.00,'2024-06-22 13:02:00.058036','2024-06-22 13:02:00.058036'),(1019,44,'2023-11-01',0.00,'2024-06-22 13:02:00.077776','2024-06-22 13:02:00.077776'),(1020,44,'2023-10-01',0.00,'2024-06-22 13:02:00.096666','2024-06-22 13:02:00.096666'),(1021,44,'2023-09-01',0.00,'2024-06-22 13:02:00.122569','2024-06-22 13:02:00.122569'),(1022,44,'2023-08-01',0.00,'2024-06-22 13:02:00.150008','2024-06-22 13:02:00.150008'),(1023,44,'2023-07-01',0.00,'2024-06-22 13:02:00.177964','2024-06-22 13:02:00.177964');
/*!40000 ALTER TABLE `salaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20240511135928'),('20240511135951'),('20240511140014'),('20240511140043'),('20240511140056'),('20240511141721'),('20240512015445'),('20240512090027'),('20240520014216'),('20240520022033'),('20240521021547'),('20240521022726'),('20240528081925'),('20240528082043'),('20240528082546'),('20240528083651'),('20240528083832'),('20240531035911'),('20240531040124'),('20240601102216'),('20240601102721'),('20240607051809'),('20240607053040'),('20240607072956'),('20240611043636'),('20240622035537'),('20240622041626');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_digest` varchar(255) DEFAULT NULL,
  `role` int DEFAULT NULL,
  `department_id` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `basic_salary` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rails_f29bf9cdf2` (`department_id`),
  CONSTRAINT `fk_rails_f29bf9cdf2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (32,'Nguyễn Đức ','Mạnh ','0905897381','2002-08-25','manh123@gmail.com','$2b$12$.ob04/uBcc9MHxfQqEBr2eg3Eo3A5MhJCZKnqsPnod7Q4j4X66sCS',1,3,'2024-05-22 10:51:37.000000','',300000.00),(44,'Manh','Nguyen','0123123123','2002-08-25','manhnguyen@gmail.com','$2b$12$undZ79W4wsivU1SUUhYo/uU6fHlJ9h5UAI/iuJ63yZZ5ze7qCK0GS',2,1,'2024-06-04 23:10:03.000000',NULL,300000.00),(53,'Account','123','0123123123','1999-02-21','account1@gmail.com','$2a$12$2PrJGDRAQKNJRppZBYsJKOJ7.15dhfWoNVeKFDo7Oqw7cuh9CWjeW',2,6,'2024-06-13 05:06:50.176919',NULL,500000.00),(54,'Account','2','0123123123','1998-02-02','account2@gmail.com','$2a$12$ixMRREfeakhdqD7h0kie9uCDJWImpNhyDOI1ytKGQoJV8KPuQ81D6',2,2,'2024-06-13 05:08:54.159660',NULL,300000.00),(55,'Account','3','0123123123','2000-02-12','account3@gmail.com','$2a$12$lizgpEbHnsN.tra4ALZ3zuLMVxa.SuYC2clQiPHQFfB8aR5dS4HiC',2,2,'2024-06-13 05:40:56.365626',NULL,350000.00),(56,'Account','4','0123123123','1987-12-20','account4@gmail.com','$2a$12$g8zpCMNg/f8jh2xNfXn3AeT34Mo01tg/.kNB9qBfdkECakbhxo24K',2,1,'2024-06-13 05:42:06.057406',NULL,300000.00),(57,'Account','5','0123123123','1997-08-20','account5@gmail.com','$2a$12$IeJUpCvYpHtznzULoFYwCupP7YBeohqb99O0zaHovQ7h8su1k16oC',2,6,'2024-06-13 05:43:15.414079',NULL,250000.00),(58,'Account','6','0123123123','1998-02-11','account6@gmail.com','$2a$12$SQhTJ09umcEqJIsO/8QO2.EsGuef8TwphJmt8jQvs7o7ZhOV7M1AG',2,5,'2024-06-13 05:44:21.329173',NULL,150000.00),(59,'Account','7','0123123123','1977-07-07','account7@gmail.com','$2a$12$r2jIb19uHIGdU5Af9tdn5uIPSKXHiiPBqgz8Hi32AJd6/ocg.GM.S',2,2,'2024-06-13 09:49:09.045247',NULL,400000.00),(60,'Account','8','0123123123','1988-08-08','account8@gmail.com','$2a$12$MMcXxjgxJBvD/ANNaUlVJ.OPfPb7z6KRw/Rg8fl81jjIFXHZHypca',2,4,'2024-06-13 09:50:19.084246',NULL,300000.00),(61,'Account','9','0123123123','1999-09-09','account9@gmail.com','$2a$12$NIwV3EZBtehqspE4G3HAwu38EBY8ebPHClh4AsKPrj2sOlJwz64wG',2,1,'2024-06-13 09:51:25.184450',NULL,300000.00),(62,'Account','10','0123123123','1991-10-10','account10@gmail.com','$2a$12$Ajmzd5vx5J/RaWgeXyLawe0P4RTgEQJXguA4ETaRdlJlnas/kcNty',2,6,'2024-06-13 11:51:37.014177',NULL,270000.00),(63,'Account','11','0123123123','1992-11-11','account11@gmail.com','$2a$12$B0309gc5d3Z1iwhcQRHn9uqNYTIIzmnb7sNX61AlOJj53/xG3GADe',2,6,'2024-06-13 11:55:44.261978',NULL,300000.00),(64,'Account','12','0123123123','1993-12-12','account12@gmail.com','$2a$12$T0PQTjmF1iuTjb5PYfDMHefvDOZzfxv4eC4Ru4B53kfkFXlaD2SOO',2,2,'2024-06-13 11:57:08.357639',NULL,300000.00),(69,'Account','13','0123123123','1993-02-13','account13@gmail.com','$2a$12$uLpC7ZfEUWKRy2yupWKqy.sn7j9r6XsnHHJq5kXG5RvcC9sC8glUO',2,4,'2024-06-14 11:18:46.070171',NULL,300000.00),(70,'Account','14','0123123123','2004-12-14','account14@gmail.com','$2a$12$zhG6/knD3gKYwhDeZ.93wemMMmYNFQ6X3PkMV.zogo.a99ISqWnmm',2,1,'2024-06-14 11:23:25.394326',NULL,250000.00),(82,'Account','15','0123123123','2000-08-20','account15@gmail.com','$2a$12$9xdFxlMBDLTCKEWbrpKt.ue2vJokASCUV/t.51mIx7y28epJJ9znW',2,1,'2024-06-23 03:38:02.846623',NULL,300000.00),(83,'Account','16','0123123123','1996-06-16','account16@gmail.com','$2a$12$wNhlkJH3IBVK0EfiAvyw1u6DZwivFgQi3z5PtNKgvi4CCKF7afVny',2,1,'2024-06-23 03:40:58.256423',NULL,300000.00),(84,'Account','17','0123123123','1997-07-17','account17@gmail.com','$2a$12$4YWwlCBkkILuZBS0MY.YJ.JpJAJEykFRVG2cF0cTVEsRhErz3m/Xe',2,1,'2024-06-23 03:42:42.292261',NULL,300000.00);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-23 11:04:21
