-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-11-2024 a las 01:39:15
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

CREATE DATABASE Manzanas_Cuidado;
USE Manzanas_Cuidado;


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
  `Nombre_manzana` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `manzanas`
--

INSERT INTO `manzanas` (`id_manzana`, `Nombre_manzana`) VALUES
(1, 'Puente Aranda'),
(2, 'Bosa'),
(3, 'Suba'),
(4, 'Kennedy');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `manzanas_servicios`
--

CREATE TABLE `manzanas_servicios` (
  `fk_id_manzana` int(5) DEFAULT NULL,
  `fk_id_servicio` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `manzanas_servicios`
--

INSERT INTO `manzanas_servicios` (`fk_id_manzana`, `fk_id_servicio`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(4, 1),
(4, 2),
(4, 3),
(4, 4),
(4, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(5) NOT NULL,
  `Nombre_servicio` varchar(30) DEFAULT NULL,
  `Tipo_servicio` varchar(30) DEFAULT NULL,
  `Descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `Nombre_servicio`, `Tipo_servicio`, `Descripcion`) VALUES
(1, 'Mantenimiento', 'Preventivo', 'Revisión y ajuste de equipos cada 6 meses'),
(2, 'Instalación', 'Eléctrica', 'Instalación de cableado y dispositivos eléctricos'),
(3, 'Reparación', 'Electrónica', 'Reparación de circuitos y componentes electrónicos'),
(4, 'Consultoría', 'Tecnológica', 'Asesoría en la implementación de tecnologías de la información'),
(5, 'Desarrollo', 'Software', 'Desarrollo de aplicaciones web a medida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudes`
--

CREATE TABLE `solicitudes` (
  `id_solicitud` int(5) NOT NULL,
  `Fecha_asistencia` date DEFAULT NULL,
  `fk_id_mujer` int(5) DEFAULT NULL,
  `fk_id_servicio` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_mujer` int(5) NOT NULL,
  `Tipo_documento` varchar(30) DEFAULT NULL,
  `Documento` varchar(20) DEFAULT NULL,
  `Nombres` varchar(30) DEFAULT NULL,
  `Apellidos` varchar(30) DEFAULT NULL,
  `Telefono` int(10) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Ciudad` varchar(30) DEFAULT NULL,
  `Direccion_mujer` text DEFAULT NULL,
  `Ocupacion` varchar(30) DEFAULT NULL,
  `fk_id_manzana` int(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_mujer`, `Tipo_documento`, `Documento`, `Nombres`, `Apellidos`, `Telefono`, `Email`, `Ciudad`, `Direccion_mujer`, `Ocupacion`, `fk_id_manzana`) VALUES
(2, 'CC', '74237623472433', 'santiago', NULL, NULL, NULL, NULL, NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `manzanas`
--
ALTER TABLE `manzanas`
  ADD PRIMARY KEY (`id_manzana`);

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
  ADD PRIMARY KEY (`id_servicio`);

--
-- Indices de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `fk_5` (`fk_id_servicio`),
  ADD KEY `fk7` (`fk_id_mujer`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_mujer`),
  ADD KEY `fk_3` (`fk_id_manzana`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `manzanas`
--
ALTER TABLE `manzanas`
  MODIFY `id_manzana` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
  MODIFY `id_solicitud` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_mujer` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `manzanas_servicios`
--
ALTER TABLE `manzanas_servicios`
  ADD CONSTRAINT `fk_1` FOREIGN KEY (`fk_id_manzana`) REFERENCES `manzanas` (`id_manzana`),
  ADD CONSTRAINT `fk_2` FOREIGN KEY (`fk_id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `solicitudes`
--
ALTER TABLE `solicitudes`
   FOREIGN KEY (`fk_id_mujer`) REFERENCES `usuario` (`id_mujer`),
  FOREIGN KEY (`fk_id_servicio`) REFERENCES `servicios` (`id_servicio`),


--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_3` FOREIGN KEY (`fk_id_manzana`) REFERENCES `manzanas` (`id_manzana`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
