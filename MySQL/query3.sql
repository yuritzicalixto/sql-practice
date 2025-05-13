-- 1. Mostrar los clientes y sus direcciones en orden alfabético por nombre de cliente
CREATE VIEW CLIENTES_DIRECCIONES_ALFABETICO AS
SELECT cliente.nombre, cliente.apellido_p, cliente.apellido_m, direccion.id_direccion, direccion.calle, direccion.numero, direccion.colonia, direccion.codigo_p, direccion.ciudad, direccion.entidad_f 
FROM cliente 
INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion 
ORDER BY cliente.nombre;

-- 2. Encontrar las ventas realizadas en 'Ciudad Principal' junto con la información del cliente
CREATE VIEW VENTAS_CIUDADPRINCIPAL AS
SELECT venta.id_venta, venta.fecha, venta.total, 
       cliente.id_cliente, cliente.nombre, cliente.apellido_p, cliente.apellido_m,
       direccion.ciudad
FROM venta
INNER JOIN cliente ON venta.id_cliente = cliente.id_cliente
INNER JOIN direccion ON cliente.id_direccion = direccion.id_direccion
WHERE direccion.ciudad = 'Ciudad Principal';

select * from ventas_ciudadprincipal_cliente;

-- 3. Encontrar todos los clientes y sus ventas (incluso si no han realizado ninguna venta)
CREATE VIEW CLIENTES_CON_SUS_VENTAS AS
SELECT cliente.id_cliente, cliente.nombre, cliente.apellido_p, cliente.apellido_m, 
       venta.id_venta, venta.fecha, venta.total
FROM cliente
LEFT JOIN venta ON cliente.id_cliente = venta.id_cliente;

-- 4. Mostrar todas las ventas con detalles completos (cliente y dirección), 
--    incluyendo aquellas sin información de cliente
CREATE VIEW VENTAS_CON_DETALLES_COMPLETOS AS
SELECT venta.id_venta, venta.fecha, venta.total, 
       cliente.id_cliente, cliente.nombre, cliente.apellido_p, cliente.apellido_m, 
       direccion.id_direccion, direccion.colonia, direccion.calle, direccion.numero, direccion.codigo_p
FROM venta
LEFT JOIN cliente ON venta.id_cliente = cliente.id_cliente
LEFT JOIN direccion ON cliente.id_direccion = direccion.id_direccion;

-- 5. Mostrar todos los clientes y sus direcciones asociadas (incluso si no hay información de cliente)
CREATE VIEW CLIENTES_Y_SUS_DIRECCIONES AS
SELECT direccion.id_direccion, direccion.calle, direccion.numero, direccion.colonia, 
       direccion.ciudad, direccion.entidad_f, 
       cliente.id_cliente, cliente.nombre, cliente.apellido_p, cliente.apellido_m
FROM direccion
LEFT JOIN cliente ON direccion.id_direccion = cliente.id_direccion;

select * from clientes_direcciones_alfabetico;
select * from VENTAS_CIUDADPRINCIPAL;
select * from CLIENTES_CON_SUS_VENTAS;
select * from VENTAS_CON_DETALLES_COMPLETOS;
select * from CLIENTES_Y_SUS_DIRECCIONES;