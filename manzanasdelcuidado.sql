-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-10-2024 a las 02:33:23
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `manzanasdelcuidado`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `manzanas`
--

CREATE TABLE `manzanas` (
  `id_manzana` int(5) NOT NULL,
  `Nombre_manzana` varchar(30) DEFAULT NULL,
  `Localidad` set('BOSA','KENNEDY','SUBA') DEFAULT NULL,
  `Direccion_manzana` text DEFAULT NULL,
  `fk_id_mujer` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `manzanas_servicios`
--

CREATE TABLE `manzanas_servicios` (
  `fk_id_manzana` int(5) DEFAULT NULL,
  `fk_id_servicio` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(5) NOT NULL,
  `Nombre_servicio` varchar(30) DEFAULT NULL,
  `Tipo_servicio` varchar(30) DEFAULT NULL,
  `fk_id_solicitud` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `id_solicitud` int(5) NOT NULL,
  `Municipios` varchar(30) DEFAULT NULL,
  `Fecha_asistencia` date DEFAULT NULL,
  `Nombre_establecimiento` varchar(50) DEFAULT NULL,
  `Responsable_establecimiento` varchar(30) DEFAULT NULL,
  `Direccion_establecimiento` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_mujer` int(5) NOT NULL,
  `Tipo_documento` set('CC','TI','CE') DEFAULT NULL,
  `Documento` int(10) DEFAULT NULL,
  `Nombres` varchar(50) DEFAULT NULL,
  `Apellidos` varchar(50) DEFAULT NULL,
  `Telefono` int(10) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Ciudad` varchar(30) DEFAULT NULL,
  `Direccion_mujer` text DEFAULT NULL,
  `Ocupacion` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `manzanas`
--
ALTER TABLE `manzanas`
  ADD PRIMARY KEY (`id_manzana`),
  ADD KEY `fk_3` (`fk_id_mujer`);

--
-- Indices de la tabla `manzanas_servicios`
--
ALTER TABLE `manzanas_servicios`
  ADD KEY `fk_1` (`fk_id_manzana`),
  ADD KEY `fk_2` (`fk_id_servicio`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`),
  ADD KEY `fk_4` (`fk_id_solicitud`);

--
-- Indices de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`id_solicitud`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_mujer`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `manzanas`
--
ALTER TABLE `manzanas`
  MODIFY `id_manzana` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `id_solicitud` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_mujer` int(5) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `manzanas`
--
ALTER TABLE `manzanas`
  ADD CONSTRAINT `fk_3` FOREIGN KEY (`fk_id_mujer`) REFERENCES `usuario` (`id_mujer`);

--
-- Filtros para la tabla `manzanas_servicios`
--
ALTER TABLE `manzanas_servicios`
  ADD CONSTRAINT `fk_1` FOREIGN KEY (`fk_id_manzana`) REFERENCES `manzanas` (`id_manzana`),
  ADD CONSTRAINT `fk_2` FOREIGN KEY (`fk_id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD CONSTRAINT `fk_4` FOREIGN KEY (`fk_id_solicitud`) REFERENCES `solicitudes` (`id_solicitud`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
