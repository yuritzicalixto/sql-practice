-- Creación de la base de datos
CREATE DATABASE PracticaSQL;
USE PracticaSQL;

-- Tabla Usuario (Relacion 1:1 con Perfil, 1:N con Orden)
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Tabla Perfil (Relacion 1:1 con Usuario)
CREATE TABLE Perfil (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT UNIQUE,
    direccion VARCHAR(255),
    telefono VARCHAR(15),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabla Orden (Relacion 1:N con Usuario)
CREATE TABLE Orden (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    fecha DATE,
    total DECIMAL(10,2),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabla Producto (Relacion N:N con Orden)
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2)
);

-- Tabla intermedia Orden_Producto (Relacion N:N entre Orden y Producto)
CREATE TABLE Orden_Producto (
    id_orden INT,
    id_producto INT,
    cantidad INT,
    PRIMARY KEY (id_orden, id_producto),
    FOREIGN KEY (id_orden) REFERENCES Orden(id_orden),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Insertando datos en Usuario
INSERT INTO Usuario (nombre, email) VALUES
('Diana', 'diana@email.com'),
('Carlos', 'carlos@email.com');

-- Insertando datos en Perfil
INSERT INTO Perfil (id_usuario, direccion, telefono) VALUES
(1, 'Calle 123, Ciudad', '555-1234'),
(2, 'Avenida 456, Ciudad', '555-5678');

-- Insertando datos en Orden
INSERT INTO Orden (id_usuario, fecha, total) VALUES
(1, '2024-02-01', 150.00),
(1, '2024-02-05', 200.00),
(2, '2024-02-03', 300.00);

-- Insertando datos en Producto
INSERT INTO Producto (nombre, precio) VALUES
('Laptop', 1000.00),
('Mouse', 25.00),
('Teclado', 50.00);

-- Insertando datos en Orden_Producto
INSERT INTO Orden_Producto (id_orden, id_producto, cantidad) VALUES
(1, 1, 1), -- Diana compró una Laptop
(1, 2, 2), -- Diana compró dos Mouse
(2, 3, 1), -- Diana compró un Teclado
(3, 1, 1), -- Carlos compró una Laptop
(3, 3, 1); -- Carlos compró un Teclado

-- Ejemplos de Consultas

-- SELECT: Obtener todos los usuarios
SELECT * FROM Usuario;

-- DISTINCT: Obtener correos únicos
SELECT DISTINCT email FROM Usuario;

-- WHERE: Obtener órdenes de Diana
SELECT * FROM Orden WHERE id_usuario = 1;

-- ORDER BY: Ordenar productos por precio descendente
SELECT * FROM Producto ORDER BY precio DESC;

-- LIKE: Buscar usuarios cuyo nombre empieza con 'D'
SELECT * FROM Usuario WHERE nombre LIKE 'D%';

-- AND, OR, NOT: Filtrar productos con precio entre 30 y 100
SELECT * FROM Producto WHERE precio BETWEEN 30 AND 100;

-- LIMIT: Obtener solo 2 órdenes
SELECT * FROM Orden LIMIT 2;

-- MIN, MAX: Obtener el producto más caro
SELECT MAX(precio) FROM Producto;

-- COUNT: Contar cuántos usuarios hay
SELECT COUNT(*) FROM Usuario;

-- SUM: Sumar total de todas las órdenes
SELECT SUM(total) FROM Orden;

-- AVG: Obtener el precio promedio de los productos
SELECT AVG(precio) FROM Producto;

-- IN: Filtrar órdenes de usuarios con ID 1 o 2
SELECT * FROM Orden WHERE id_usuario IN (1, 2);

-- ALIAS: Renombrar columnas en la consulta
SELECT nombre AS 'Nombre del Producto', precio AS 'Costo' FROM Producto;

-- CONCAT: Concatenar nombre y email de usuarios
SELECT CONCAT(nombre, ' - ', email) AS 'Usuario Info' FROM Usuario;

-- GROUP BY: Total gastado por usuario
SELECT id_usuario, SUM(total) AS total_gastado FROM Orden GROUP BY id_usuario;

-- HAVING: Filtrar usuarios con total gastado mayor a 200
SELECT id_usuario, SUM(total) AS total_gastado FROM Orden GROUP BY id_usuario HAVING total_gastado > 200;

-- CASE: Asignar categorías a productos según precio
SELECT nombre, precio, CASE 
    WHEN precio > 500 THEN 'Caro'
    WHEN precio BETWEEN 100 AND 500 THEN 'Medio'
    ELSE 'Barato'
END AS categoria FROM Producto;

-- IFNULL: Reemplazar valores NULL
SELECT nombre, IFNULL(email, 'Correo Electronico') FROM Usuario;

-- INNER JOIN: Obtener órdenes con usuario
SELECT Usuario.nombre, Orden.fecha, Orden.total FROM Usuario INNER JOIN Orden ON Usuario.id_usuario = Orden.id_usuario;
-- seleccionamos t1.nombre, t2.

-- LEFT JOIN: Obtener todos los usuarios y sus órdenes (incluye los que no tienen)
SELECT Usuario.nombre, Orden.fecha, Orden.total FROM Usuario LEFT JOIN Orden ON Usuario.id_usuario = Orden.id_usuario;

-- RIGHT JOIN: Obtener todas las órdenes y sus usuarios (incluye órdenes sin usuario)
SELECT Usuario.nombre, Orden.fecha, Orden.total FROM Usuario RIGHT JOIN Orden ON Usuario.id_usuario = Orden.id_usuario;

-- UNION: Unir listas de nombres de usuarios y productos
SELECT nombre FROM Usuario UNION SELECT nombre FROM Producto;
