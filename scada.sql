-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-12-2020 a las 03:55:21
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
(1, 1, '', '2020-12-02', NULL, 1, 'Motorola', 'Vinex', '2020-12-11 11:32:01', 'EM1234'),
(3, 1, 'asd', '2020-12-01', NULL, 1, 'asdd', 'adddd', '2020-12-11 11:32:01', 'EM12222'),
(4, 1, 'eeeee', '2020-12-23', NULL, 1, 'qqwqw', 'wwwww', '1900-01-01 00:00:00', 'sdfsdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `graficas`
--

DROP TABLE IF EXISTS `graficas`;
CREATE TABLE `graficas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `ruta` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, '2020-12-11 11:26:01', '49', 1, 1),
(2, '2020-12-11 11:26:01', '46', 1, 2),
(3, '2020-12-11 11:26:01', '51', 1, 3),
(4, '2020-12-11 11:26:01', '1024.46', 1, 4),
(5, '2020-12-11 11:26:01', '1.18', 1, 5),
(6, '2020-12-11 11:26:01', '0.52', 1, 6),
(7, '2020-12-11 11:26:01', '15.68', 1, 7),
(8, '2020-12-11 11:26:01', '47', 1, 8),
(9, '2020-12-11 11:26:01', '0.4288', 1, 9),
(10, '2020-12-11 11:26:01', '22', 3, 1),
(11, '2020-12-11 11:26:01', '24', 3, 2),
(12, '2020-12-11 11:26:01', '75', 3, 3),
(13, '2020-12-11 11:26:01', '1240.11', 3, 4),
(14, '2020-12-11 11:26:01', '1.74', 3, 5),
(15, '2020-12-11 11:26:01', '0.05', 3, 6),
(16, '2020-12-11 11:26:01', '14.75', 3, 7),
(17, '2020-12-11 11:26:01', '155', 3, 8),
(18, '2020-12-11 11:26:01', '0.5107', 3, 9),
(19, '2020-12-11 11:32:01', '26', 1, 1),
(20, '2020-12-11 11:32:01', '25', 1, 2),
(21, '2020-12-11 11:32:01', '61', 1, 3),
(22, '2020-12-11 11:32:01', '1341.69', 1, 4),
(23, '2020-12-11 11:32:01', '1.17', 1, 5),
(24, '2020-12-11 11:32:01', '0.28', 1, 6),
(25, '2020-12-11 11:32:01', '13.61', 1, 7),
(26, '2020-12-11 11:32:01', '294', 1, 8),
(27, '2020-12-11 11:32:01', '0.6921', 1, 9),
(28, '2020-12-11 11:32:01', '25', 3, 1),
(29, '2020-12-11 11:32:01', '41', 3, 2),
(30, '2020-12-11 11:32:01', '57', 3, 3),
(31, '2020-12-11 11:32:01', '1216.84', 3, 4),
(32, '2020-12-11 11:32:01', '1.39', 3, 5),
(33, '2020-12-11 11:32:01', '0.13', 3, 6),
(34, '2020-12-11 11:32:01', '10.36', 3, 7),
(35, '2020-12-11 11:32:01', '8', 3, 8),
(36, '2020-12-11 11:32:01', '0.2013', 3, 9);

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
  `nombre` varchar(20) NOT NULL,
  `min` float DEFAULT NULL,
  `max` float DEFAULT NULL,
  `id_grafica` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sensores`
--

INSERT INTO `sensores` (`id`, `id_tipo`, `id_sensor_secundario`, `unidadmedida`, `nombre`, `min`, `max`, `id_grafica`) VALUES
(1, 1, 1, ' ºC', 'T_amb', NULL, NULL, NULL),
(3, 1, 2, 'ºC', 'T_int', NULL, NULL, NULL),
(5, 1, 3, '%', 'Humedad', NULL, NULL, NULL),
(6, 1, 4, 'HPa', 'Pres_atm', NULL, NULL, NULL),
(7, 1, 5, ' W/m^2', 'Irrad_solar', NULL, NULL, NULL),
(8, 1, 6, 'W/m^2', 'Irrad_UV', NULL, NULL, NULL),
(9, 1, 7, 'm/s', 'Vel_viento', NULL, NULL, NULL),
(10, 1, 8, 'Grados, ', 'Dir_viento', NULL, NULL, NULL),
(11, 1, 9, 'mm / m^2', 'Ind_pluvio', NULL, NULL, NULL),
(12, 3, 1, 'ºC', 'Temperatura', NULL, NULL, NULL);

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
(1, 1, 'Estacion metereologica', ''),
(3, 1, '1', '1');

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
-- Indices de la tabla `graficas`
--
ALTER TABLE `graficas`
  ADD PRIMARY KEY (`id`);

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
  ADD KEY `id_tipo` (`id_tipo`),
  ADD KEY `sensores_grafica` (`id_grafica`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `graficas`
--
ALTER TABLE `graficas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `logdispositivos`
--
ALTER TABLE `logdispositivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medidas`
--
ALTER TABLE `medidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `sensores`
--
ALTER TABLE `sensores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `tipos_dispositivos`
--
ALTER TABLE `tipos_dispositivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  ADD CONSTRAINT `sensores_grafica` FOREIGN KEY (`id_grafica`) REFERENCES `graficas` (`id`),
  ADD CONSTRAINT `sensores_ibfk_1` FOREIGN KEY (`id_tipo`) REFERENCES `tipos_dispositivos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
