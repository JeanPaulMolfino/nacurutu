-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-12-2020 a las 06:11:53
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dispositivos`
--

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
(1, 1, 'Azotea PDA', '2020-12-02', NULL, 1, 'Temptec', 'TM-3000', '2020-12-21 21:34:01', 'TM-1'),
(15, 1, 'Acuario PDA', '2020-12-16', NULL, 3, 'Glass', 'GSS-63', '2020-12-23 20:01:36', 'Pecera - Tropical'),
(16, 0, 'Terrario PDA', '2020-12-06', NULL, 4, 'Terra', 'T-62', '2020-12-20 20:01:42', 'Terratio - Tortugas');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `graficas`
--

CREATE TABLE `graficas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `ruta` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `graficas`
--

INSERT INTO `graficas` (`id`, `nombre`, `ruta`) VALUES
(1, 'Lineal', NULL),
(5, 'Radar', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logdispositivos`
--

CREATE TABLE `logdispositivos` (
  `id` int(11) NOT NULL,
  `id_dispositivo` int(11) NOT NULL,
  `descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medidas`
--

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
(258, '2020-12-21 20:12:01', '24', 1, 1),
(259, '2020-12-21 20:12:01', '19', 1, 2),
(260, '2020-12-21 20:12:01', '70', 1, 3),
(261, '2020-12-21 20:12:01', '1294.24', 1, 4),
(262, '2020-12-21 20:12:01', '1.22', 1, 5),
(263, '2020-12-21 20:12:01', '0.55', 1, 6),
(264, '2020-12-21 20:12:01', '19.31', 1, 7),
(265, '2020-12-21 20:12:01', '199', 1, 8),
(266, '2020-12-21 20:12:01', '0.4212', 1, 9),
(267, '2020-12-21 20:14:01', '19', 1, 1),
(268, '2020-12-21 20:14:01', '31', 1, 2),
(269, '2020-12-21 20:14:01', '88', 1, 3),
(270, '2020-12-21 20:14:01', '1307.46', 1, 4),
(271, '2020-12-21 20:14:01', '0.18', 1, 5),
(272, '2020-12-21 20:14:01', '0.25', 1, 6),
(273, '2020-12-21 20:14:01', '15.24', 1, 7),
(274, '2020-12-21 20:14:01', '329', 1, 8),
(275, '2020-12-21 20:14:01', '0.5102', 1, 9),
(276, '2020-12-21 20:21:01', '28', 1, 1),
(277, '2020-12-21 20:21:01', '34', 1, 2),
(278, '2020-12-21 20:21:01', '59', 1, 3),
(279, '2020-12-21 20:21:01', '1363.8', 1, 4),
(280, '2020-12-21 20:21:01', '0.73', 1, 5),
(281, '2020-12-21 20:21:01', '0.99', 1, 6),
(282, '2020-12-21 20:21:01', '18.51', 1, 7),
(283, '2020-12-21 20:21:01', '262', 1, 8),
(284, '2020-12-21 20:21:01', '0.0186', 1, 9),
(285, '2020-12-21 20:24:01', '-2', 1, 1),
(286, '2020-12-21 20:24:01', '21', 1, 2),
(287, '2020-12-21 20:24:01', '93', 1, 3),
(288, '2020-12-21 20:24:01', '947.06', 1, 4),
(289, '2020-12-21 20:24:01', '1.94', 1, 5),
(290, '2020-12-21 20:24:01', '0.06', 1, 6),
(291, '2020-12-21 20:24:01', '9.73', 1, 7),
(292, '2020-12-21 20:24:01', '225', 1, 8),
(293, '2020-12-21 20:24:01', '0.8286', 1, 9),
(294, '2020-12-21 21:34:01', '8', 1, 1),
(295, '2020-12-21 21:34:01', '20', 1, 2),
(296, '2020-12-21 21:34:01', '63', 1, 3),
(297, '2020-12-21 21:34:01', '903.96', 1, 4),
(298, '2020-12-21 21:34:01', '0.1', 1, 5),
(299, '2020-12-21 21:34:01', '0.36', 1, 6),
(300, '2020-12-21 21:34:01', '7.57', 1, 7),
(301, '2020-12-21 21:34:01', '220', 1, 8),
(302, '2020-12-21 21:34:01', '0.465', 1, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sensores`
--

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
(1, 1, 1, ' ºC', 'T_amb', NULL, NULL, 1),
(3, 1, 2, 'ºC', 'T_int', NULL, NULL, 1),
(5, 1, 3, '%', 'Humedad', NULL, NULL, 1),
(6, 1, 4, 'HPa', 'Pres_atm', NULL, NULL, 1),
(7, 1, 5, ' W/m^2', 'Irrad_solar', NULL, NULL, 1),
(8, 1, 6, 'W/m^2', 'Irrad_UV', NULL, NULL, 1),
(9, 1, 7, 'm/s', 'Vel_viento', NULL, NULL, 1),
(10, 1, 8, 'Grados', 'Dir_viento', NULL, NULL, 5),
(11, 1, 9, 'mm / m^2', 'Ind_pluvio', NULL, NULL, 1),
(20, 3, 3, 'C°', 'Temperatura', 25, 27, 1),
(21, 4, 7, '%', 'Nivel de agua', 30, 100, 1),
(22, 4, 8, 'tests', 'Temperatura ambiente', 16, 24, 1),
(23, 4, 9, '%', 'Humedad de la tierra', 10, 18, 1),
(24, 3, 4, 'l/m^3', 'Volumen de agua', 20, 24, 1),
(25, 3, 5, 'mg/l', 'Nivel de Oxigeno', 6, 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_dispositivos`
--

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
(1, 1, 'Estación metereológica', ''),
(3, 1, 'Acuario', 'Control'),
(4, 12, 'Terrario', 'Control');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `graficas`
--
ALTER TABLE `graficas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `logdispositivos`
--
ALTER TABLE `logdispositivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medidas`
--
ALTER TABLE `medidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=313;

--
-- AUTO_INCREMENT de la tabla `sensores`
--
ALTER TABLE `sensores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `tipos_dispositivos`
--
ALTER TABLE `tipos_dispositivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
