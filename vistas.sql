-- 1. Mostrar los clientes y sus direcciones en orden alfabético por nombre de cliente
SELECT cliente.nombre, cliente.apellido_paterno, cliente.apellido_materno, 
       direccion.calle, direccion.numero, direccion.colonia, direccion.codigo_postal, 
       direccion.ciudad, direccion.entidad_federativa
FROM cliente
JOIN direccion ON cliente.id_direccion = direccion.id_direccion
ORDER BY cliente.nombre;

-- 2. Encontrar las ventas realizadas en 'Ciudad Principal' junto con la información del cliente
SELECT venta.id_venta, venta.fecha, venta.total, 
       cliente.nombre, cliente.apellido_paterno, cliente.apellido_materno, 
       direccion.ciudad
FROM venta
JOIN cliente ON venta.id_cliente = cliente.id_cliente
JOIN direccion ON cliente.id_direccion = direccion.id_direccion
WHERE direccion.ciudad = 'Ciudad Principal';

-- 3. Encontrar todos los clientes y sus ventas (incluso si no han realizado ninguna venta)
SELECT cliente.id_cliente, cliente.nombre, cliente.apellido_paterno, cliente.apellido_materno, 
       venta.id_venta, venta.fecha, venta.total
FROM cliente
LEFT JOIN venta ON cliente.id_cliente = venta.id_cliente;

--4. Mostrar todas las ventas con detalles completos (cliente y dirección), incluyendo aquellas sin información de cliente
SELECT venta.id_venta, venta.fecha, venta.total, 
       cliente.nombre, cliente.apellido_paterno, cliente.apellido_materno, 
       direccion.calle, direccion.numero, direccion.colonia, direccion.codigo_postal, 
       direccion.ciudad, direccion.entidad_federativa
FROM venta
LEFT JOIN cliente ON venta.id_cliente = cliente.id_cliente
LEFT JOIN direccion ON cliente.id_direccion = direccion.id_direccion;
