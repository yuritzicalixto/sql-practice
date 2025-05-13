CREATE TRIGGER nombre_disparador
AFTER/BEFORE INSERT/UPDATE/DELETE ON nombre_tabla
FOR EACH ROW
BEGIN
--Acción del disparador aquí
END;


-- En la BD de practica1 creamos el siguiente disparador
DELIMITER //
create trigger registrar_insercion_empleado
after insert on empleado
for each row
begin
insert into registro_empleados (id_empleado, fecha_insercion)
values (NEW.id_empleado, now());
END //

DELIMITER //
CREATE TRIGGER validar_precio_producto
AFTER INSERT on producto
FOR EACH ROW
BEGIN
IF NEW.precio_compra < 0 THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio del producto no puede ser negativo';
END IF;
END //