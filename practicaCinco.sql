SELECT cliente.nombre, cliente.apellido_p, cliente.apellido_m, direccion.id_direccion, direccion.calle, direccion.numero, direccion.colonia, direccion.codigo_p, direccion.ciudad, direccion.entidad_f 
FROM cliente 
INNER JOIN direccion ON direccion.id_direccion = cliente.id_direccion 
ORDER BY cliente.nombre;

SELECT venta.fecha, venta.total,direccion.calle, direccion.numero, direccion.colonia, direccion.codigo_p, direccion.ciudad, direccion.entidad_f FROM venta INNER JOIN cliente ON venta.id_cliente = cliente.id_cliente INNER JOIN direccion ON cliente.id_direccion = direccion.id_direccion;

SELECT venta.id_venta, venta.fecha, venta.total, cliente.nombre, cliente.apellido_p,cliente.apellido_m, direccion.colonia, direccion.calle, direccion.numero,direccion.codigo_p FROM venta
INNER JOIN cliente ON venta.id_cliente = cliente.id_cliente
INNER JOIN direccion ON cliente.id_direccion = direccion.id_direccion

SELECT venta.id_venta, venta.fecha, venta.total, cliente.nombre, cliente.apellido_p,cliente.apellido_m FROM venta
LEFT JOIN cliente ON venta.id_cliente = cliente.id_cliente

SELECT venta.id_venta, venta.fecha, venta.total, cliente.nombre, cliente.apellido_p,cliente.apellido_m, direccion.colonia, direccion.calle, direccion.numero,direccion.codigo_p FROM venta
INNER JOIN cliente ON venta.id_cliente = cliente.id_cliente
INNER JOIN direccion ON cliente.id_direccion = direccion.id_direccion

SELECT direccion.id_direccion, direccion.calle, direccion.numero, direccion.colonia, direccion.codigo_p, direccion.ciudad, direccion.entidad_f, cliente.name, cliente.apellido_p, cliente.apellido_m FROM direccion
LEFT JOIN cliente ON direccion.id_direccion = cliente.id_direccion