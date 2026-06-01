-- 1. Creación de la Base de Datos para RP Scrubs
CREATE DATABASE rp_scrubs_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE rp_scrubs_db;

-- 2. Tabla de Categorías de Indumentaria
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- 3. Tabla Principal de Productos (Scrubs Básicos)
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT,
    nombre VARCHAR(150) NOT NULL,
    marca VARCHAR(50) DEFAULT 'RP SCRUBS',
    precio_base DECIMAL(10,2) NOT NULL,
    stock_disponible INT DEFAULT 0,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE SET NULL
);

-- 4. Tabla de Variaciones Específicas (Talla / Color / Silueta)
CREATE TABLE variaciones_producto (
    id_variacion INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    talla VARCHAR(10) NOT NULL, -- XCH, CH, M, G, XG
    color VARCHAR(50) NOT NULL, -- Oxford, Negro, Azul Rey, etc.
    corte VARCHAR(30) DEFAULT 'General', -- Hombre, Mujer
    stock_variacion INT DEFAULT 0,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE
);

-- 5. Registro Histórico de Clientes / Leads de Newsletter
CREATE TABLE clientes_newsletter (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_suscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- INSERCIÓN DE DATOS DE PRUEBA (DATA SEED)
-- ==========================================
INSERT INTO categorias (nombre_categoria, descripcion) VALUES 
('Scrubs Mujer', 'Línea de uniformes médicos con silueta ajustada femenina'),
('Scrubs Hombre', 'Línea de uniformes médicos corte caballero');

INSERT INTO productos (id_categoria, nombre, precio_base, stock_disponible) VALUES 
(1, 'Uniforme Modelo Daila', 480.00, 25),
(1, 'Uniforme Recto Tradicional', 470.00, 40),
(1, 'Uniforme Jogger Moderno', 470.00, 50);

-- Variaciones para el Modelo Jogger (ID: 3)
INSERT INTO variaciones_producto (id_producto, talla, color, corte, stock_variacion) VALUES 
(3, 'CH', 'Azul Eléctrico', 'Mujer', 15),
(3, 'M', 'Negro', 'Mujer', 20),
(3, 'G', 'Morado Imperial', 'Hombre', 15);
