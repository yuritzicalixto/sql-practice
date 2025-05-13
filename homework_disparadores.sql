DELIMITER //

-- 1. Validar que el correo electrónico de un nuevo cliente sea válido
CREATE TRIGGER validar_correo_cliente
BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
    IF NEW.correo_e NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El correo electrónico no es válido';
    END IF;
END //

-- Correcta 
INSERT INTO cliente (rfc, nombre, apellido_p, telefono, correo_e, estado, id_direccion, id_usuario)
VALUES ('XAXX010101000', 'Juan', 'Pérez', '5551234567', 'juan.perez@email.com', TRUE, 1, 1);

--Incorrecta 
INSERT INTO cliente (rfc, nombre, apellido_p, telefono, correo_e, estado, id_direccion, id_usuario)
VALUES ('XAXX010101000', 'Juan', 'Pérez', '5551234567', 'juan.perez-email.com', TRUE, 1, 1);




-- 2. Validar el formato de la imagen al registrar un nuevo producto (solo PNG)
CREATE TRIGGER validar_formato_imagen_producto
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
    IF NEW.imagen NOT LIKE '%.png' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El formato de la imagen debe ser PNG';
    END IF;
END //
-- Correcta
INSERT INTO producto (sku, descripcion, precio_compra, precio_venta, existencia, imagen, estado, id_categoria)
VALUES ('PROD001', 'Producto de prueba', 50.0, 100.0, 10, 'imagen.png', TRUE, 1);

-- Incorrecta
INSERT INTO producto (sku, descripcion, precio_compra, precio_venta, existencia, imagen, estado, id_categoria)
VALUES ('PROD002', 'Producto de prueba', 50.0, 100.0, 10, 'imagen.jpg', TRUE, 1);



-- 3. Validar que la contraseña tenga al menos 8 caracteres
CREATE TRIGGER validar_longitud_contrasena
BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
    IF CHAR_LENGTH(NEW.contrasena) < 8 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La contraseña debe tener al menos 8 caracteres';
    END IF;
END //
-- Correcta
INSERT INTO usuario (usuario, contrasena, imagen, tipo, estado)
VALUES ('usuario1', 'segura123', 'avatar.png', 'Cliente', TRUE);

-- Incorrecta
INSERT INTO usuario (usuario, contrasena, imagen, tipo, estado)
VALUES ('usuario2', 'short', 'avatar.png', 'Cliente', TRUE);



-- 4. Validar que el precio de venta no sea menor que el de compra
CREATE TRIGGER validar_precio_venta
BEFORE INSERT ON producto
FOR EACH ROW
BEGIN
    IF NEW.precio_venta < NEW.precio_compra THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio de venta no puede ser menor que el precio de compra';
    END IF;
END //
-- Correcta
INSERT INTO producto (sku, descripcion, precio_compra, precio_venta, existencia, imagen, estado, id_categoria)
VALUES ('PROD003', 'Producto Correcto', 50.0, 60.0, 10, 'imagen.png', TRUE, 1);

-- Incorrecta
INSERT INTO producto (sku, descripcion, precio_compra, precio_venta, existencia, imagen, estado, id_categoria)
VALUES ('PROD004', 'Producto Incorrecto', 50.0, 40.0, 10, 'imagen.png', TRUE, 1);




-- 5. Aceptar solo "Administrador", "Cliente" o "Invitado" como tipo de usuario
CREATE TRIGGER validar_tipo_usuario
BEFORE INSERT ON usuario
FOR EACH ROW
BEGIN
    IF NEW.tipo NOT IN ('Administrador', 'Cliente', 'Invitado') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tipo de usuario debe ser Administrador, Cliente o Invitado';
    END IF;
END //
-- Correcta
INSERT INTO usuario (usuario, contrasena, imagen, tipo, estado)
VALUES ('admin1', 'password123', 'avatar.png', 'Administrador', TRUE);

-- Incorrecta
INSERT INTO usuario (usuario, contrasena, imagen, tipo, estado)
VALUES ('usuario3', 'password123', 'avatar.png', 'SuperAdmin', TRUE);



-- 6. Historial de actualizaciones en la tabla cliente
CREATE TABLE historial_cliente (
    id_historial SMALLINT AUTO_INCREMENT PRIMARY KEY,
    id_cliente SMALLINT NOT NULL,
    fecha_actualizacion TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    campo_actualizado VARCHAR(50) NOT NULL,
    valor_anterior VARCHAR(255) NOT NULL,
    valor_nuevo VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TRIGGER registrar_actualizacion_cliente
AFTER UPDATE ON cliente
FOR EACH ROW
BEGIN
    IF OLD.nombre <> NEW.nombre THEN
        INSERT INTO historial_cliente (id_cliente, campo_actualizado, valor_anterior, valor_nuevo)
        VALUES (OLD.id_cliente, 'nombre', OLD.nombre, NEW.nombre);
    END IF;
    IF OLD.apellido_p <> NEW.apellido_p THEN
        INSERT INTO historial_cliente (id_cliente, campo_actualizado, valor_anterior, valor_nuevo)
        VALUES (OLD.id_cliente, 'apellido_p', OLD.apellido_p, NEW.apellido_p);
    END IF;
    IF OLD.apellido_m <> NEW.apellido_m THEN
        INSERT INTO historial_cliente (id_cliente, campo_actualizado, valor_anterior, valor_nuevo)
        VALUES (OLD.id_cliente, 'apellido_m', OLD.apellido_m, NEW.apellido_m);
    END IF;
    IF OLD.telefono <> NEW.telefono THEN
        INSERT INTO historial_cliente (id_cliente, campo_actualizado, valor_anterior, valor_nuevo)
        VALUES (OLD.id_cliente, 'telefono', OLD.telefono, NEW.telefono);
    END IF;
    IF OLD.correo_e <> NEW.correo_e THEN
        INSERT INTO historial_cliente (id_cliente, campo_actualizado, valor_anterior, valor_nuevo)
        VALUES (OLD.id_cliente, 'correo_e', OLD.correo_e, NEW.correo_e);
    END IF;
END //

DELIMITER ;


-- Insertar
INSERT INTO cliente (rfc, nombre, apellido_p, telefono, correo_e, estado, id_direccion, id_usuario)
VALUES ('XAXX010101001', 'Ana', 'López', '5559876543', 'ana.lopez@email.com', TRUE, 1, 1);

-- Modificar
UPDATE cliente SET nombre = 'Andrea' WHERE rfc = 'XAXX010101001';

-- Verificar
SELECT * FROM historial_cliente WHERE id_cliente = (SELECT id_cliente FROM cliente WHERE rfc = 'XAXX010101001');
