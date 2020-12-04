-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-12-2020 a las 16:39:46
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `scada`
--
CREATE DATABASE IF NOT EXISTS `scada` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `scada`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dispositivos`
--

DROP TABLE IF EXISTS `dispositivos`;
CREATE TABLE `dispositivos` (
  `id` int(11) NOT NULL,
  `actividad` tinyint(1) NOT NULL,
  `ubicacion` varchar(60) NOT NULL,
  `fecha_alta` date NOT NULL,
  `fecha_baja` date DEFAULT NULL,
  `id_tipo` int(11) NOT NULL,
  `marca` varchar(40) NOT NULL,
  `modelo` varchar(40) NOT NULL,
  `ultima_actualizacion` datetime NOT NULL,
  `identificador` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `dispositivos`
--

INSERT INTO `dispositivos` (`id`, `actividad`, `ubicacion`, `fecha_alta`, `fecha_baja`, `id_tipo`, `marca`, `modelo`, `ultima_actualizacion`, `identificador`) VALUES
(1, 1, '', '2020-12-02', NULL, 1, 'Motorola', 'Vinex', '2020-12-03 01:02:26', 'EM1234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logdispositivos`
--

DROP TABLE IF EXISTS `logdispositivos`;
CREATE TABLE `logdispositivos` (
  `id` int(11) NOT NULL,
  `id_dispositivo` int(11) NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medidas`
--

DROP TABLE IF EXISTS `medidas`;
CREATE TABLE `medidas` (
  `id` int(11) NOT NULL,
  `tiempo` datetime NOT NULL,
  `lectura` varchar(10) NOT NULL,
  `id_dispositivo` int(11) NOT NULL,
  `id_sensor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `medidas`
--

INSERT INTO `medidas` (`id`, `tiempo`, `lectura`, `id_dispositivo`, `id_sensor`) VALUES
(1287, '2020-12-03 01:02:26', '8', 1, 1),
(1288, '2020-12-03 01:02:26', '31', 1, 2),
(1289, '2020-12-03 01:02:26', '70', 1, 3),
(1290, '2020-12-03 01:02:26', '938.49', 1, 4),
(1291, '2020-12-03 01:02:26', '0.57', 1, 5),
(1292, '2020-12-03 01:02:26', '0.08', 1, 6),
(1293, '2020-12-03 01:02:26', '10.35', 1, 7),
(1294, '2020-12-03 01:02:26', '225', 1, 8),
(1295, '2020-12-03 01:02:26', '0.2558', 1, 9),
(1296, '2020-12-03 01:02:26', '41', 1, 1),
(1297, '2020-12-03 01:02:26', '24', 1, 2),
(1298, '2020-12-03 01:02:26', '56', 1, 3),
(1299, '2020-12-03 01:02:26', '1206.55', 1, 4),
(1300, '2020-12-03 01:02:26', '0.21', 1, 5),
(1301, '2020-12-03 01:02:26', '0.89', 1, 6),
(1302, '2020-12-03 01:02:26', '13.35', 1, 7),
(1303, '2020-12-03 01:02:26', '287', 1, 8),
(1304, '2020-12-03 01:02:26', '0.5866', 1, 9),
(1305, '2020-12-03 01:02:26', '22', 1, 1),
(1306, '2020-12-03 01:02:26', '17', 1, 2),
(1307, '2020-12-03 01:02:26', '68', 1, 3),
(1308, '2020-12-03 01:02:26', '1282.58', 1, 4),
(1309, '2020-12-03 01:02:26', '1.11', 1, 5),
(1310, '2020-12-03 01:02:26', '0.67', 1, 6),
(1311, '2020-12-03 01:02:26', '16.19', 1, 7),
(1312, '2020-12-03 01:02:26', '211', 1, 8),
(1313, '2020-12-03 01:02:26', '0.932', 1, 9),
(1314, '2020-12-03 01:02:26', '3', 1, 1),
(1315, '2020-12-03 01:02:26', '25', 1, 2),
(1316, '2020-12-03 01:02:26', '62', 1, 3),
(1317, '2020-12-03 01:02:26', '1162.8', 1, 4),
(1318, '2020-12-03 01:02:26', '0.54', 1, 5),
(1319, '2020-12-03 01:02:26', '0.45', 1, 6),
(1320, '2020-12-03 01:02:26', '8.15', 1, 7),
(1321, '2020-12-03 01:02:26', '67', 1, 8),
(1322, '2020-12-03 01:02:26', '0.0724', 1, 9),
(1323, '2020-12-03 01:02:26', '12', 1, 1),
(1324, '2020-12-03 01:02:26', '24', 1, 2),
(1325, '2020-12-03 01:02:26', '70', 1, 3),
(1326, '2020-12-03 01:02:26', '1264.23', 1, 4),
(1327, '2020-12-03 01:02:26', '0.41', 1, 5),
(1328, '2020-12-03 01:02:26', '0', 1, 6),
(1329, '2020-12-03 01:02:26', '18.18', 1, 7),
(1330, '2020-12-03 01:02:26', '359', 1, 8),
(1331, '2020-12-03 01:02:26', '0.7342', 1, 9),
(1332, '2020-12-03 01:02:26', '16', 1, 1),
(1333, '2020-12-03 01:02:26', '58', 1, 2),
(1334, '2020-12-03 01:02:26', '81', 1, 3),
(1335, '2020-12-03 01:02:26', '1303.14', 1, 4),
(1336, '2020-12-03 01:02:26', '0.6', 1, 5),
(1337, '2020-12-03 01:02:26', '0.59', 1, 6),
(1338, '2020-12-03 01:02:26', '14.5', 1, 7),
(1339, '2020-12-03 01:02:26', '262', 1, 8),
(1340, '2020-12-03 01:02:26', '0.5539', 1, 9),
(1341, '2020-12-03 01:02:26', '5', 1, 1),
(1342, '2020-12-03 01:02:26', '48', 1, 2),
(1343, '2020-12-03 01:02:26', '55', 1, 3),
(1344, '2020-12-03 01:02:26', '1209.46', 1, 4),
(1345, '2020-12-03 01:02:26', '1.85', 1, 5),
(1346, '2020-12-03 01:02:26', '0.11', 1, 6),
(1347, '2020-12-03 01:02:26', '12.91', 1, 7),
(1348, '2020-12-03 01:02:26', '356', 1, 8),
(1349, '2020-12-03 01:02:26', '0.1602', 1, 9),
(1350, '2020-12-03 01:02:26', '17', 1, 1),
(1351, '2020-12-03 01:02:26', '45', 1, 2),
(1352, '2020-12-03 01:02:26', '91', 1, 3),
(1353, '2020-12-03 01:02:26', '942.93', 1, 4),
(1354, '2020-12-03 01:02:26', '0.37', 1, 5),
(1355, '2020-12-03 01:02:26', '0.25', 1, 6),
(1356, '2020-12-03 01:02:26', '12.56', 1, 7),
(1357, '2020-12-03 01:02:26', '166', 1, 8),
(1358, '2020-12-03 01:02:26', '0.7309', 1, 9),
(1359, '2020-12-03 01:02:26', '30', 1, 1),
(1360, '2020-12-03 01:02:26', '30', 1, 2),
(1361, '2020-12-03 01:02:26', '97', 1, 3),
(1362, '2020-12-03 01:02:26', '1156.82', 1, 4),
(1363, '2020-12-03 01:02:26', '1.45', 1, 5),
(1364, '2020-12-03 01:02:26', '0.89', 1, 6),
(1365, '2020-12-03 01:02:26', '7.98', 1, 7),
(1366, '2020-12-03 01:02:26', '333', 1, 8),
(1367, '2020-12-03 01:02:26', '0.4488', 1, 9),
(1368, '2020-12-03 01:02:26', '31', 1, 1),
(1369, '2020-12-03 01:02:26', '35', 1, 2),
(1370, '2020-12-03 01:02:26', '64', 1, 3),
(1371, '2020-12-03 01:02:26', '975.14', 1, 4),
(1372, '2020-12-03 01:02:26', '1.19', 1, 5),
(1373, '2020-12-03 01:02:26', '0.99', 1, 6),
(1374, '2020-12-03 01:02:26', '15.69', 1, 7),
(1375, '2020-12-03 01:02:26', '49', 1, 8),
(1376, '2020-12-03 01:02:26', '0.3557', 1, 9),
(1377, '2020-12-03 01:02:26', '39', 1, 1),
(1378, '2020-12-03 01:02:26', '43', 1, 2),
(1379, '2020-12-03 01:02:26', '88', 1, 3),
(1380, '2020-12-03 01:02:26', '1029.22', 1, 4),
(1381, '2020-12-03 01:02:26', '0.47', 1, 5),
(1382, '2020-12-03 01:02:26', '0.45', 1, 6),
(1383, '2020-12-03 01:02:26', '19.82', 1, 7),
(1384, '2020-12-03 01:02:26', '171', 1, 8),
(1385, '2020-12-03 01:02:26', '0.022', 1, 9),
(1386, '2020-12-03 01:02:26', '36', 1, 1),
(1387, '2020-12-03 01:02:26', '27', 1, 2),
(1388, '2020-12-03 01:02:26', '53', 1, 3),
(1389, '2020-12-03 01:02:26', '1149.32', 1, 4),
(1390, '2020-12-03 01:02:26', '0.19', 1, 5),
(1391, '2020-12-03 01:02:26', '0.91', 1, 6),
(1392, '2020-12-03 01:02:26', '11.39', 1, 7),
(1393, '2020-12-03 01:02:26', '82', 1, 8),
(1394, '2020-12-03 01:02:26', '0.0444', 1, 9),
(1395, '2020-12-03 01:02:26', '38', 1, 1),
(1396, '2020-12-03 01:02:26', '54', 1, 2),
(1397, '2020-12-03 01:02:26', '77', 1, 3),
(1398, '2020-12-03 01:02:26', '1353.08', 1, 4),
(1399, '2020-12-03 01:02:26', '1.96', 1, 5),
(1400, '2020-12-03 01:02:26', '0.95', 1, 6),
(1401, '2020-12-03 01:02:26', '6.38', 1, 7),
(1402, '2020-12-03 01:02:26', '6', 1, 8),
(1403, '2020-12-03 01:02:26', '0.8149', 1, 9),
(1404, '2020-12-03 01:02:26', '18', 1, 1),
(1405, '2020-12-03 01:02:26', '53', 1, 2),
(1406, '2020-12-03 01:02:26', '60', 1, 3),
(1407, '2020-12-03 01:02:26', '1391.99', 1, 4),
(1408, '2020-12-03 01:02:26', '0.99', 1, 5),
(1409, '2020-12-03 01:02:26', '0.55', 1, 6),
(1410, '2020-12-03 01:02:26', '17.56', 1, 7),
(1411, '2020-12-03 01:02:26', '215', 1, 8),
(1412, '2020-12-03 01:02:26', '0.9103', 1, 9),
(1413, '2020-12-03 01:02:26', '21', 1, 1),
(1414, '2020-12-03 01:02:26', '18', 1, 2),
(1415, '2020-12-03 01:02:26', '65', 1, 3),
(1416, '2020-12-03 01:02:26', '928.88', 1, 4),
(1417, '2020-12-03 01:02:26', '1.95', 1, 5),
(1418, '2020-12-03 01:02:26', '0.33', 1, 6),
(1419, '2020-12-03 01:02:26', '14.34', 1, 7),
(1420, '2020-12-03 01:02:26', '159', 1, 8),
(1421, '2020-12-03 01:02:26', '0.1817', 1, 9),
(1422, '2020-12-03 01:02:26', '49', 1, 1),
(1423, '2020-12-03 01:02:26', '47', 1, 2),
(1424, '2020-12-03 01:02:26', '54', 1, 3),
(1425, '2020-12-03 01:02:26', '1023.06', 1, 4),
(1426, '2020-12-03 01:02:26', '1.59', 1, 5),
(1427, '2020-12-03 01:02:26', '0.94', 1, 6),
(1428, '2020-12-03 01:02:26', '9.59', 1, 7),
(1429, '2020-12-03 01:02:26', '223', 1, 8),
(1430, '2020-12-03 01:02:26', '0.8977', 1, 9),
(1431, '2020-12-03 01:02:26', '15', 1, 1),
(1432, '2020-12-03 01:02:26', '30', 1, 2),
(1433, '2020-12-03 01:02:26', '70', 1, 3),
(1434, '2020-12-03 01:02:26', '1179.21', 1, 4),
(1435, '2020-12-03 01:02:26', '0.37', 1, 5),
(1436, '2020-12-03 01:02:26', '0.12', 1, 6),
(1437, '2020-12-03 01:02:26', '5.58', 1, 7),
(1438, '2020-12-03 01:02:26', '356', 1, 8),
(1439, '2020-12-03 01:02:26', '0.3596', 1, 9),
(1440, '2020-12-03 01:02:26', '-2', 1, 1),
(1441, '2020-12-03 01:02:26', '55', 1, 2),
(1442, '2020-12-03 01:02:26', '62', 1, 3),
(1443, '2020-12-03 01:02:26', '1357.79', 1, 4),
(1444, '2020-12-03 01:02:26', '0.91', 1, 5),
(1445, '2020-12-03 01:02:26', '0.23', 1, 6),
(1446, '2020-12-03 01:02:26', '7.92', 1, 7),
(1447, '2020-12-03 01:02:26', '51', 1, 8),
(1448, '2020-12-03 01:02:26', '0.5457', 1, 9),
(1449, '2020-12-03 01:02:26', '12', 1, 1),
(1450, '2020-12-03 01:02:26', '29', 1, 2),
(1451, '2020-12-03 01:02:26', '60', 1, 3),
(1452, '2020-12-03 01:02:26', '1112.58', 1, 4),
(1453, '2020-12-03 01:02:26', '1.25', 1, 5),
(1454, '2020-12-03 01:02:26', '0.56', 1, 6),
(1455, '2020-12-03 01:02:26', '6.15', 1, 7),
(1456, '2020-12-03 01:02:26', '308', 1, 8),
(1457, '2020-12-03 01:02:26', '0.0173', 1, 9),
(1458, '2020-12-03 01:02:26', '13', 1, 1),
(1459, '2020-12-03 01:02:26', '54', 1, 2),
(1460, '2020-12-03 01:02:26', '94', 1, 3),
(1461, '2020-12-03 01:02:26', '1357.65', 1, 4),
(1462, '2020-12-03 01:02:26', '1.67', 1, 5),
(1463, '2020-12-03 01:02:26', '1', 1, 6),
(1464, '2020-12-03 01:02:26', '6.82', 1, 7),
(1465, '2020-12-03 01:02:26', '266', 1, 8),
(1466, '2020-12-03 01:02:26', '0.3368', 1, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sensores`
--

DROP TABLE IF EXISTS `sensores`;
CREATE TABLE `sensores` (
  `id` int(11) NOT NULL,
  `id_tipo` int(11) NOT NULL,
  `id_sensor_secundario` int(11) NOT NULL,
  `unidadmedida` varchar(8) NOT NULL,
  `grafica` varchar(40) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sensores`
--

INSERT INTO `sensores` (`id`, `id_tipo`, `id_sensor_secundario`, `unidadmedida`, `grafica`, `nombre`) VALUES
(1, 1, 1, ' ºC', '', 'T_amb'),
(3, 1, 2, 'ºC', '', 'T_int'),
(5, 1, 3, '%', '', 'Humedad'),
(6, 1, 4, 'HPa', '', 'Pres_atm'),
(7, 1, 5, ' W/m^2', '', 'Irrad_solar'),
(8, 1, 6, 'W/m^2', '', 'Irrad_UV'),
(9, 1, 7, 'm/s', '', 'Vel_viento'),
(10, 1, 8, 'Grados, ', '', 'Dir_viento'),
(11, 1, 9, 'mm / m^2', '', 'Ind_pluvio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_dispositivos`
--

DROP TABLE IF EXISTS `tipos_dispositivos`;
CREATE TABLE `tipos_dispositivos` (
  `id` int(11) NOT NULL,
  `updatetime` int(20) NOT NULL,
  `categoria` varchar(40) NOT NULL,
  `proposito` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipos_dispositivos`
--

INSERT INTO `tipos_dispositivos` (`id`, `updatetime`, `categoria`, `proposito`) VALUES
(1, 1, 'Estacion metereologica', '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `identificador` (`identificador`),
  ADD KEY `fk_dispositivo_tipos` (`id_tipo`);

--
-- Indices de la tabla `logdispositivos`
--
ALTER TABLE `logdispositivos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_logdispositivos_dispositivos` (`id_dispositivo`);

--
-- Indices de la tabla `medidas`
--
ALTER TABLE `medidas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_medidas_dispositivos` (`id_dispositivo`);

--
-- Indices de la tabla `sensores`
--
ALTER TABLE `sensores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipo` (`id_tipo`);

--
-- Indices de la tabla `tipos_dispositivos`
--
ALTER TABLE `tipos_dispositivos`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `logdispositivos`
--
ALTER TABLE `logdispositivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medidas`
--
ALTER TABLE `medidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1467;

--
-- AUTO_INCREMENT de la tabla `sensores`
--
ALTER TABLE `sensores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tipos_dispositivos`
--
ALTER TABLE `tipos_dispositivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD CONSTRAINT `fk_dispositivo_tipos` FOREIGN KEY (`id_tipo`) REFERENCES `tipos_dispositivos` (`id`);

--
-- Filtros para la tabla `logdispositivos`
--
ALTER TABLE `logdispositivos`
  ADD CONSTRAINT `fk_logdispositivos_dispositivos` FOREIGN KEY (`id_dispositivo`) REFERENCES `dispositivos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `medidas`
--
ALTER TABLE `medidas`
  ADD CONSTRAINT `fk_medidas_dispositivos` FOREIGN KEY (`id_dispositivo`) REFERENCES `dispositivos` (`id`);

--
-- Filtros para la tabla `sensores`
--
ALTER TABLE `sensores`
  ADD CONSTRAINT `sensores_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `tipos_dispositivos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
