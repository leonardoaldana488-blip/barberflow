-- Base de Datos Relacional: BarberFlow
-- Motor: MySQL 8.0 | Codificación: utf8mb4
CREATE DATABASE IF NOT EXISTS barberflow_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE barberflow_db;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    rol ENUM('CLIENTE', 'BARBERO', 'ADMINISTRADOR') NOT NULL DEFAULT 'CLIENTE',
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    preferencias_corte TEXT,
    FOREIGN KEY (id_cliente) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE barberos (
    id_barbero INT PRIMARY KEY,
    especialidad VARCHAR(100) NOT NULL,
    disponible BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (id_barbero) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    descripcion VARCHAR(255),
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    duracion_min INT NOT NULL CHECK (duracion_min > 0),
    activo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_barbero INT NOT NULL,
    id_servicio INT NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    estado ENUM('RESERVADA', 'CLIENTE_LLEGO', 'EN_ATENCION', 'FINALIZADA', 'CANCELADA') NOT NULL DEFAULT 'RESERVADA',
    notas VARCHAR(255),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_barbero) REFERENCES barberos(id_barbero),
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio),
    UNIQUE KEY uq_barbero_fecha_hora (id_barbero, fecha, hora)
);

-- Datos semilla iniciales
INSERT INTO servicios (nombre, descripcion, precio, duracion_min) VALUES
('Corte de cabello', 'Corte clásico o degradado con lavado básico', 20000.00, 30),
('Servicio de barba', 'Perfilado, rebaje y toalla caliente', 15000.00, 20),
('Corte + barba', 'Combo completo de corte de cabello y arreglo de barba', 32000.00, 45),
('Corte infantil', 'Corte para niños menores de 12 años', 16000.00, 25);
