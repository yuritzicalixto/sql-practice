USE jugos;
insert into tbproductos(producto, nombre, envase, volumen, sabor, precio) values ('773912', 'clean', 'botella pet', '1 litro', 'naranja', 8.01);
select * from tbproductos;
select * from tbclientes;


create database tienda;
use tienda;
create table direccion (
id_direccion smallint auto_increment primary key,
calle varchar (40) not null,
numero varchar (5) not null,
colonia varchar (40) not null,
codigo_p varchar (5) not null,
ciudad varchar (40) not null,
entidad_f varchar (30) not null,
estado boolean not null default true
);
select * from direccion;

create table usuario (
id_usuario smallint auto_increment primary key,
usuario varchar (25) not null unique,
contrasena varchar (20) not null,
imagen varchar (30) not null,
fecha_creacion timestamp not null default current_timestamp on update current_timestamp,
tipo varchar (30) not null,
estado boolean not null default true
);

create table categoria (
id_categoria smallint auto_increment primary key,
nombre varchar (30) not null,
estado boolean not null default true
);

select * from usuario;
select * from categoria;

create table proveedor (
id_proveedor smallint auto_increment primary key,
rfc char (13) not null unique,
nombre varchar (20) not null,
apellido_p varchar (20) not null,
apellido_m varchar (20) not null,
telefono char (10) not null unique,
correo_e varchar (40) not null unique,
estado boolean not null default true,
id_direccion smallint not null,
foreign key (id_direccion) references direccion (id_direccion) on update cascade on delete cascade
);

create table empleado (
id_empleado smallint auto_increment primary key,
nombre varchar (20) not null,
apellido_p varchar (20) not null,
apellido_m varchar (20) not null,
telefono char (10) not null,
correo_e varchar (40) not null unique,
puesto varchar (40) not null,
sueldo float not null,
estado boolean not null default true,
id_direccion smallint not null,
foreign key (id_direccion) references direccion (id_direccion) on update cascade on delete cascade,
id_usuario smallint not null,
foreign key (id_usuario) references usuario (id_usuario) on update cascade on delete cascade
);

create table cliente (
id_cliente smallint auto_increment primary key,
rfc char (13) not null unique,
nombre varchar (20) not null,
apellido_p varchar (20) not null,
apellido_m varchar (20) not null,
telefono char (10) not null,
correo_e varchar (40) not null unique,
estado boolean not null default true,
id_direccion smallint not null,
foreign key (id_direccion) references direccion (id_direccion) on update cascade on delete cascade,
id_usuario smallint not null,
foreign key (id_usuario) references usuario (id_usuario) on update cascade on delete cascade
);

create table producto (
id_producto smallint auto_increment primary key,
sku char (8) not null unique,
descripcion varchar (50) not null,
precio_compra float not null,
precio_venta float not null,
existencia int (11) not null,
imagen varchar (30) not null,
estado boolean not null default true,
id_categoria smallint not null,
foreign key (id_categoria ) references categoria (id_categoria) on update cascade on delete cascade
);

create table pedido (
id_pedido smallint auto_increment primary key,
fecha timestamp not null default current_timestamp on update current_timestamp,
total float not null,
estado boolean not null default true,
id_proveedor smallint not null,
foreign key (id_proveedor) references proveedor (id_proveedor) on update cascade on delete cascade,
id_empleado smallint not null,
foreign key (id_empleado) references empleado (id_empleado) on update cascade on delete cascade
);

create table detallepedido (
cantidad int (11) not null, 
subtotal float not null,
id_pedido smallint not null,
foreign key (id_pedido) references pedido (id_pedido) on update cascade on delete cascade,
id_producto smallint not null,
foreign key (id_producto) references producto (id_producto) on update cascade on delete cascade,
primary key (id_pedido, id_producto) 
);

create table venta (
id_venta smallint auto_increment primary key,
fecha timestamp not null default current_timestamp on update current_timestamp,
total float not null,
id_cliente smallint not null,
foreign key (id_cliente) references cliente (id_cliente) on update cascade on delete cascade
);

create table detalleventa (
cantidad int (11) not null, 
subtotal float not null,
id_venta smallint not null,
foreign key (id_venta) references venta (id_venta) on update cascade on delete cascade,
id_producto smallint not null,
foreign key (id_producto) references producto (id_producto) on update cascade on delete cascade,
primary key (id_venta, id_producto) 
);

insert into categoria (nombre) values ("Frutas");
insert into categoria (nombre) values ("Verduras");
insert into categoria (nombre) values ("Legumbres");
insert into categoria (nombre) values ("Lácteos");
insert into categoria (nombre) values ("Cereales");

insert into direccion (calle, numero, colonia, codigo_p, ciudad, entidad_f) 
values ("1", "S/N", "Centro", "94470", "Córdoba", "Veracruz");

insert into direccion (calle, numero, colonia, codigo_p, ciudad, entidad_f) 
values ("Real", "19", "Lomas", "94477", "Fortin", "Veracruz");

insert into direccion (calle, numero, colonia, codigo_p, ciudad, entidad_f) 
values ("Santa Ana", "5", "San José", "94570", "Cd Mendoza", "Veracruz");

insert into direccion (calle, numero, colonia, codigo_p, ciudad, entidad_f) 
values ("1", "20", "Centro", "94470", "Oriental", "Puebla");

insert into direccion (calle, numero, colonia, codigo_p, ciudad, entidad_f) 
values ("1", "278", "Puebla", "96470", "Tehuacán", "Puebla");
select * from categoria;
select * from direccion;

select * from direccion where colonia = "Centro";
select ciudad, entidad_f from direccion;
select distinct entidad_f from direccion;
select distinct colonia from direccion;
select colonia from direccion order by colonia asc;
select colonia from direccion order by colonia desc;
select * from direccion where colonia = "Centro" and ciudad = "Córdoba";
select * from direccion where colonia = "Centro" or ciudad = "Córdoba";
select * from direccion where not colonia = "Centro";


update direccion set colonia = "Colorines" where id_direccion = 1;
delete from direccion where id_direccion = 1;



create database practica1;
use practica1;
CREATE TABLE direccion(
    id_direccion SMALLINT AUTO_INCREMENT PRIMARY KEY,
    calle VARCHAR(40) NOT NULL,
    numero VARCHAR(5) NULL,
    colonia VARCHAR(40) NOT NULL,
    codigo_p VARCHAR(5) NOT NULL,
    ciudad VARCHAR(40) NOT NULL,
    entidad_f VARCHAR(30) NOT NULL,
    estado BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE usuario(
    id_usuario SMALLINT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(25) NOT NULL UNIQUE,
    contrasena VARCHAR(20) NOT NULL,
    imagen VARCHAR(30) NOT NULL,
    fecha_creacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    tipo VARCHAR(30) NOT NULL,
    estado BOOLEAN NOT NULL DEFAULT TRUE
);
    
CREATE TABLE categoria(
    id_categoria SMALLINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    estado BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE proveedor(
    id_proveedor SMALLINT AUTO_INCREMENT PRIMARY KEY,
    rfc CHAR(13) NOT NULL UNIQUE,
    nombre VARCHAR(20) NOT NULL,
    apellido_p VARCHAR(20) NOT NULL,
    apellido_m VARCHAR(20) NULL,
    telefono CHAR(10) NOT NULL UNIQUE,
    correo_e VARCHAR(40) NOT NULL UNIQUE,
    estado BOOLEAN NOT NULL DEFAULT TRUE,
    id_direccion SMALLINT NOT NULL,
    FOREIGN KEY(id_direccion) REFERENCES direccion(id_direccion) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE empleado(
    id_empleado SMALLINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    apellido_p VARCHAR(20) NOT NULL,
    apellido_m VARCHAR(20) NULL,
    telefono CHAR(10) NOT NULL,
    correo_e VARCHAR(40) NOT NULL UNIQUE,
    puesto VARCHAR(20) NOT NULL,
    sueldo FLOAT NOT NULL,
    estado BOOLEAN NOT NULL DEFAULT TRUE,
    id_direccion SMALLINT NOT NULL,
    id_usuario SMALLINT NOT NULL,
    FOREIGN KEY(id_direccion) REFERENCES direccion(id_direccion) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE cliente(
    id_cliente SMALLINT AUTO_INCREMENT PRIMARY KEY,
    rfc CHAR(13) NOT NULL UNIQUE,
    nombre VARCHAR(20) NOT NULL,
    apellido_p VARCHAR(20) NOT NULL,
    apellido_m VARCHAR(20) NULL,
    telefono CHAR(10) NOT NULL,
    correo_e VARCHAR(40) NOT NULL UNIQUE,
    estado BOOLEAN NOT NULL DEFAULT TRUE,
    id_direccion SMALLINT NOT NULL,
    id_usuario SMALLINT NOT NULL,
    FOREIGN KEY(id_direccion) REFERENCES direccion(id_direccion) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(id_usuario) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE producto(
    id_producto SMALLINT AUTO_INCREMENT PRIMARY KEY,
    sku CHAR(8) NOT NULL UNIQUE,
    descripcion VARCHAR(50) NOT NULL,
    precio_compra FLOAT NOT NULL,
    precio_venta FLOAT NOT NULL,
    existencia INTEGER NOT NULL,
    imagen VARCHAR(30) NOT NULL,
    estado BOOLEAN NOT NULL DEFAULT TRUE,
    id_categoria SMALLINT NOT NULL,
    FOREIGN KEY(id_categoria) REFERENCES categoria(id_categoria) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE pedido(
    id_pedido SMALLINT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    total FLOAT NOT NULL,
    id_proveedor SMALLINT NOT NULL,
    id_empleado SMALLINT NOT NULL,
    FOREIGN KEY(id_proveedor) REFERENCES proveedor(id_proveedor) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(id_empleado) REFERENCES empleado(id_empleado) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE detallepedido(
    cantidad INT NOT NULL,
    subtotal FLOAT NOT NULL,
    id_pedido SMALLINT NOT NULL,
    id_producto SMALLINT NOT NULL,
    FOREIGN KEY(id_pedido) REFERENCES pedido(id_pedido) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(id_producto) REFERENCES producto(id_producto) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(id_pedido, id_producto)
);

CREATE TABLE venta(
    id_venta SMALLINT AUTO_INCREMENT PRIMARY KEY,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    total FLOAT NOT NULL,
    id_cliente SMALLINT NOT NULL,
    FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE detalleventa(
    cantidad INT NOT NULL,
    subtotal FLOAT NOT NULL,
    id_venta SMALLINT NOT NULL,
    id_producto SMALLINT NOT NULL,
    FOREIGN KEY(id_venta) REFERENCES venta(id_venta) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(id_producto) REFERENCES producto(id_producto) ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(id_venta, id_producto)
);

INSERT INTO direccion (calle, numero, colonia, codigo_p, ciudad, entidad_f) VALUES
('Calle Real 1', '123', 'Centro', '12345', 'Ciudad Principal', 'Estado Principal'),
('Avenida Principal 2', '456', 'Norte', '67890', 'Otra Ciudad', 'Otra Entidad'),
('Calle Secundaria 3', '789', 'Sur', '54321', 'Ciudad Secundaria', 'Entidad Secundaria'),
('Avenida Norte 4', '101', 'Este', '98765', 'Ciudad del Este', 'Entidad del Este'),
('Calle Oeste 5', '202', 'Oeste', '56789', 'Ciudad del Oeste', 'Entidad del Oeste'),
('Avenida Central 6', '303', 'Centro', '34567', 'Ciudad Central', 'Entidad Central'),
('Calle Principal 7', '404', 'Norte', '87654', 'Ciudad del Norte', 'Entidad del Norte'),
('Avenida Sur 8', '505', 'Sur', '23456', 'Ciudad del Sur', 'Entidad del Sur'),
('Calle del Este 9', '606', 'Este', '65432', 'Ciudad del Este', 'Entidad del Este'),
('Avenida del Oeste 10', '707', 'Oeste', '43210', 'Ciudad del Oeste', 'Entidad del Oeste');

INSERT INTO usuario (usuario, contrasena, imagen, fecha_creacion, tipo) VALUES
('Admin1', 'Contraseña1', 'imagen1.jpg', '2024-01-18', 'Administrador'),
('Cliente2', 'Contraseña2', 'imagen2.jpg', '2024-01-18', 'Cliente'),
('Usuario3', 'Contraseña3', 'imagen3.jpg', '2024-01-18', 'Cliente'),
('Usuario4', 'Contraseña4', 'imagen4.jpg', '2024-01-18', 'Cliente'),
('Usuario5', 'Contraseña5', 'imagen5.jpg', '2024-01-18', 'Cliente'),
('Usuario6', 'Contraseña6', 'imagen6.jpg', '2024-01-18', 'Cliente'),
('Usuario7', 'Contraseña7', 'imagen7.jpg', '2024-01-18', 'Cliente'),
('Usuario8', 'Contraseña8', 'imagen8.jpg', '2024-01-18', 'Cliente'),
('Usuario9', 'Contraseña9', 'imagen9.jpg', '2024-01-18', 'Cliente'),
('Usuario10', 'Contraseña10', 'imagen10.jpg', '2024-01-18', 'Cliente');

INSERT INTO cliente (rfc, nombre, apellido_p, apellido_m, telefono, correo_e, id_direccion, id_usuario) VALUES
('RFC111111A', 'Juan', 'Pérez', 'Gómez', '555-1234', 'juan@example.com', 1, 1),
('RFC222222B', 'María', 'López', 'Hernández', '555-5678', 'maria@example.com', 2, 2),
('RFC333333C', 'Carlos', 'González', 'Rodríguez', '555-9876', 'carlos@example.com', 3, 3),
('RFC444444D', 'Ana', 'Martínez', 'Gutiérrez', '555-5432', 'ana@example.com', 4, 4),
('RFC555555E', 'David', 'Díaz', 'Sánchez', '555-6789', 'david@example.com', 5, 5),
('RFC666666F', 'Laura', 'Herrera', 'Fernández', '555-2345', 'laura@example.com', 6, 6),
('RFC777777G', 'Francisco', 'Peralta', 'Ramírez', '555-8765', 'francisco@example.com', 7, 7),
('RFC888888H', 'Sofía', 'Castañeda', 'Mendoza', '555-4321', 'sofia@example.com', 8, 8),
('RFC999999I', 'Pedro', 'Ramírez', 'Sánchez', '555-9999', 'pedro@example.com', 9, 9),
('RFC101010J', 'Isabel', 'Gómez', 'Martínez', '555-1111', 'isabel@example.com', 10, 10);

INSERT INTO venta (fecha, total, id_cliente) VALUES
('2024-01-18', 100.00, 1),
('2024-01-18', 150.00, 2),
('2024-01-18', 200.00, 3),
('2024-01-18', 120.00, 4),
('2024-01-18', 180.00, 5),
('2024-01-18', 90.00, 6),
('2024-01-18', 130.00, 7),
('2024-01-18', 170.00, 8),
('2024-01-18', 110.00, 9),
('2024-01-18', 160.00, 10);




select * from usuario;
SET SQL_SAFE_UPDATES = 0;

UPDATE usuario
SET estado = FALSE;



SET SQL_SAFE_UPDATES = 1;
SELECT * FROM cliente WHERE estado = TRUE;
select * from direccion;
SELECT * FROM usuario WHERE estado = FALSE;
select nombre from cliente order by nombre asc;
select * from cliente where not direccion = "Ciudad Principal";
select usuario from usuario;

SELECT cliente.* 
FROM cliente
JOIN direccion ON cliente.id_direccion = direccion.id_direccion
WHERE direccion.ciudad != 'Ciudad Principal';

select * from cliente 
join direccion 
on cliente.id_direccion = direccion.id_direccion 
where not direccion.ciudad = 'Ciudad Principal';

select tipo, COUNT(*) as total_repeticiones from usuario where tipo ="cliente" group by tipo;

select * from direccion order by ciudad asc;

select * from venta where total < 150;
update cliente set telefono = "5562345079" where rfc = "RFC222222B";


select * from cliente;
delete from venta where id_venta = 3;
select * from venta;

use practica1;
select * from direccion;
SELECT AVG(total) AS promedio_venta
FROM venta;
SELECT *
FROM direccion
WHERE calle LIKE 'C%';

SELECT *
FROM direccion
WHERE colonia IN ('Centro', 'Norte', 'Sur');

SELECT *
FROM venta
WHERE total BETWEEN 100 AND 150;

SELECT id_direccion AS ID
FROM direccion;


INSERT INTO `categoria` (`id_categoria`, `nombre`, `estado`)
VALUES  (NULL, 'Frutas', '1'),
        (NULL, 'Verduras', '1'),
        (NULL, 'Lácteos', '1'),
        (NULL, 'Cereales', '1'),
        (NULL, 'Carnes Frías', '1');

INSERT INTO `producto` (`id_producto`, `sku`, `descripcion`, `precio_compra`, `precio_venta`, `existencia`, `imagen`, `estado`, `id_categoria`)
VALUES  (NULL, 'ABC12345', 'MANZANA', '35', '40', '500', 'manzana.png', '1', '1'),
        (NULL, 'CHA12345', 'CHAYOTE', '15', '20', '200', 'cha.png', '1', '2'),
        (NULL, 'PER12345', 'PERA', '55', '60', '40', 'pera.png', '1', '1'),
        (NULL, 'QUF12345', 'QUESO FRESCO', '150', '200', '10', 'que.png', '1', '3');
        
select producto.id_producto, producto.descripcion, 
categoria.id_categoria, categoria.nombre
from producto inner join categoria
on producto.id_categoria = categoria.id_categoria; 

select  producto.descripcion, 
categoria.nombre
from categoria left join producto
on categoria.id_categoria = producto.id_categoria; 

select * from direccion;
select * from cliente;

SELECT 
    cliente.id_cliente id_cliente, 
    cliente.nombre nombre_cliente, 
    direccion.id_direccion id_direccion, 
    direccion.calle calle_direccion
FROM 
    cliente
INNER JOIN 
    direccion
ON 
    cliente.id_direccion = direccion.id_direccion;
    
    
    
use practica1;
select * from venta
inner join cliente 
on venta.id_cliente = cliente.id_cliente
inner join direccion 
on direccion.id_direccion = cliente.id_direccion;

select * from direccion
left join cliente
on direccion.id_direccion = cliente.id_direccion;

select * from venta
left join cliente 
on venta.id_cliente = cliente.id_cliente;


USE practica1;

-- Consulta
SELECT count(tipo)
FROM usuario
WHERE tipo = "cliente";

-- Contar 
CREATE VIEW contar_tipo_cliente AS
SELECT count(tipo)
FROM usuario
WHERE tipo = "cliente";

CREATE VIEW contar_tipo_cliente AS
select nombre from cliente;

SELECT nombre 
from cliente
where tipo = "nombre";

CREATE VIEW CLIENTE_DIRECION AS
SELECT cliente.nombre, direccion.calle AS project 
FROM cliente 
LEFT JOIN direccion 
ON cliente.id_direccion = direccion.id_direccion;


select * from cliente_direcion;

CREATE VIEW cliente__direccion AS
SELECT cliente.nombre, direccion.calle AS calle 
FROM cliente 
LEFT JOIN direccion 
ON cliente.id_direccion = direccion.id_direccion;

select * from cliente__direccion;


select * from detalles_ventas_clientes_direcciones;
select * from direcciones_clientes;
select * from ventas_clientes;

USE practica1;
-- VIEWS
CREATE VIEW DETALLES_VENTAS_CLIENTES_DIRECCIONES AS
SELECT venta.id_venta, venta.fecha, venta.total, cliente.nombre, cliente.apellido_p,cliente.apellido_m, direccion.colonia, direccion.calle, direccion.numero,direccion.codigo_p FROM venta
INNER JOIN cliente ON venta.id_cliente = cliente.id_cliente
INNER JOIN direccion ON cliente.id_direccion = direccion.id_direccion;

CREATE VIEW DIRECCIONES_CLIENTES AS
SELECT direccion.id_direccion, direccion.calle, direccion.numero, direccion.colonia, direccion.codigo_p, direccion.ciudad, direccion.entidad_f, cliente.nombre, cliente.apellido_p, cliente.apellido_m FROM direccion
LEFT JOIN cliente ON direccion.id_direccion = cliente.id_direccion;

CREATE VIEW VENTAS_CLIENTES AS
SELECT venta.id_venta, venta.fecha, venta.total, cliente.nombre, cliente.apellido_p,cliente.apellido_m FROM venta
LEFT JOIN cliente ON venta.id_cliente = cliente.id_cliente;


use practica1;
 
CREATE TABLE registro_empleados (
id_empleado smallint auto_increment primary key,
fecha_insercion datetime,
foreign key (id_empleado) references empleado(id_empleado)
);

--Crea el siguiente disparador
DELIMITER //
create trigger registrar_insercion_empleado
after insert on empleado
for each row
begin
insert into registro_empleados (id_empleado, fecha_insercion)
values (NEW.id_empleado, now());
END //

INSERT INTO empleado (nombre, apellido_p, apellido_m, telefono, correo_e, puesto, sueldo, estado, id_direccion, id_usuario)
VALUES ('Juan', 'Pérez', 'Gómez', '5551234567', 'juan.perez@email.com', 'Desarrollador', 50000, TRUE, 1, 1);

select * from registro_empleados;
select * from empleado;

DELIMITER //
CREATE TRIGGER validar_precio_producto
AFTER INSERT on producto
FOR EACH ROW
BEGIN
IF NEW.precio_compra < 0 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio del producto no puede ser negativo';
END IF;
END //

INSERT INTO producto (sku, descripcion, precio_compra, precio_venta, existencia, imagen, id_categoria)
VALUES 
('PROD001', 'Laptop Gamer', 800, 1200, 10, 'laptop.jpg', 1),
('PROD002', 'Teclado Mecánico', 50, 80, 20, 'teclado.jpg', 2);


INSERT INTO producto (sku, descripcion, precio_compra, precio_venta, existencia, imagen, id_categoria)
VALUES ('PROD003', 'Mouse Inalámbrico', -25, 40, 15, 'mouse.jpg', 2);

select * from producto;