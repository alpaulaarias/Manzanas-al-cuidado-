CREATE DATABASE manzanasdelcuidado2;

USE manzanasdelcuidado2;

CREATE TABLE Manzanas(
    id_manzana INT(5) PRIMARY KEY AUTO_INCREMENT,
    Nombre_Manzana VARCHAR(39)
);

CREATE TABLE servicios(
    id_servicio INT(5) PRIMARY KEY AUTO_INCREMENT,
    Nombre_servicio VARCHAR(39),
    Tipo_servicio VARCHAR(39),
    Descripcion VARCHAR(39)
);
CREATE TABLE manzanas_servicios(
    fk_id_manzana INT(5),
    fk_id_servicio INT(5),
    FOREIGN KEY (fk_id_manzana) REFERENCES Manzanas(id_manzana) ON DELETE CASCADE,
    FOREIGN KEY (fk_id_servicio) REFERENCES servicios(id_servicio)  ON DELETE CASCADE
);

CREATE TABLE usuario(
    id_mujer INT(5) PRIMARY KEY AUTO_INCREMENT,
    Tipo_documento VARCHAR(39),
    Documento VARCHAR(39),
    Nombres VARCHAR(39),
    Apellidos VARCHAR(39),
    Telefono VARCHAR(39),
    Email VARCHAR(39),
    Ciudad VARCHAR(39),
    Direccion_mujer VARCHAR(39),
    Ocupacion VARCHAR(39),
    fk_id_manzana INT(5),
    FOREIGN KEY (fk_id_manzana) REFERENCES Manzanas(id_manzana) ON DELETE CASCADE
);

CREATE TABLE solicitudes(
    id_solicitud INT(5) PRIMARY KEY AUTO_INCREMENT,
    Fecha_asistencia DATE,
    fk_id_mujer INT(5),
    fk_id_servicio INT(5),
    FOREIGN KEY (fk_id_mujer) REFERENCES usuario(id_mujer)  ON DELETE CASCADE,
    FOREIGN KEY (fk_id_servicio) REFERENCES servicios(id_servicio)  ON DELETE CASCADE
);

INSERT INTO `manzanas` (`id_manzana`, `Nombre_manzana`) VALUES
(1, 'Puente Aranda'),
(2, 'Bosa'),
(3, 'Suba'),
(4, 'Kennedy');

INSERT INTO usuario 
(id_mujer, Tipo_documento, Documento, Nombres, Apellidos, Telefono, Email, Ciudad, Direccion_mujer, Ocupacion, fk_id_manzana) 
VALUES
(2, 'CC', '74237623472433', 'Santiago', 'Pérez', '3112345678', 'santiago.perez@example.com', 'Bogotá', 'Calle 123 #45-67', 'Ingeniero', 1),
(3, 'CC', '123456789', 'Maria', 'Gómez', '3219876543', 'maria.gomez@example.com', 'Medellín', 'Carrera 45 #56-78', 'Diseñadora', 2),
(4, 'TI', '987654321', 'Carlos', 'López', '3107654321', 'carlos.lopez@example.com', 'Cali', 'Avenida Siempre Viva #101', 'Estudiante', 3);

INSERT INTO `servicios` (`id_servicio`, `Nombre_servicio`, `Tipo_servicio`, `Descripcion`) VALUES
(1, 'Mantenimiento', 'Preventivo', 'Revisión y ajuste de equipos cada 6 meses'),
(2, 'Instalación', 'Eléctrica', 'Instalación de cableado y dispositivos eléctricos'),
(3, 'Reparación', 'Electrónica', 'Reparación de circuitos y componentes electrónicos'),
(4, 'Consultoría', 'Tecnológica', 'Asesoría en la implementación de tecnologías de la información'),
(5, 'Desarrollo', 'Software', 'Desarrollo de aplicaciones web a medida');

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
