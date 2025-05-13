use practica1;

CREATE VIEW productos_disponibles AS
SELECT * FROM producto WHERE existencia > 0;
select * from productos_disponibles;

CREATE VIEW clientes_activos AS
SELECT * FROM cliente WHERE estado = TRUE;
select * from clientes_activos;

CREATE VIEW vista_pedidos_proveedores AS
SELECT pedido.id_pedido, proveedor.nombre AS nombre_proveedor, pedido.total
FROM pedido
JOIN proveedor ON pedido.id_proveedor = proveedor.id_proveedor;
select * from vista_pedidos_proveedores;


CREATE VIEW vista_ventas_clientes AS
SELECT venta.id_venta, cliente.nombre AS nombre_cliente, venta.fecha, venta.total
FROM venta
JOIN cliente ON venta.id_cliente = cliente.id_cliente;
select * from vista_ventas_clientes;


CREATE VIEW vista_empleados_usuarios AS
SELECT empleado.id_empleado, empleado.nombre, empleado.apellido_p, empleado.apellido_m, usuario.usuario
FROM empleado
JOIN usuario ON empleado.id_usuario = usuario.id_usuario;
select * from vista_empleados_usuarios;           



-- 6. Crear una vista con productos y sus categorías
CREATE VIEW vista_productos_categorias AS
SELECT producto.id_producto, producto.descripcion, categoria.nombre AS nombre_categoria
FROM producto
JOIN categoria ON producto.id_categoria = categoria.id_categoria;
select * from vista_productos_categorias;             


-- 7. Crear una vista con ventas agrupadas por mes con el total vendido
CREATE VIEW vista_ventas_por_mes AS
SELECT DATE_FORMAT(fecha, '%Y-%m') AS mes, SUM(total) AS total_vendido
FROM venta
GROUP BY mes;
select * from vista_ventas_por_mes;                           


-- 8. Crear una vista con los productos más vendidos, ordenados por la cantidad vendida
CREATE VIEW vista_productos_mas_vendidos AS
SELECT producto.id_producto, producto.descripcion, SUM(detalleventa.cantidad) AS cantidad_vendida
FROM detalleventa
JOIN producto ON detalleventa.id_producto = producto.id_producto
GROUP BY producto.id_producto
ORDER BY cantidad_vendida DESC;
select * from vista_productos_mas_vendidos;

-- 9. Crear una vista con proveedores y la cantidad de pedidos recibidos
CREATE VIEW vista_proveedores_pedidos AS
SELECT proveedor.id_proveedor, proveedor.nombre AS nombre_proveedor, COUNT(pedido.id_pedido) AS cantidad_pedidos
FROM proveedor
JOIN pedido ON proveedor.id_proveedor = pedido.id_proveedor
GROUP BY proveedor.id_proveedor;
select * from vista_proveedores_pedidos;


-- 10. Crear una vista con clientes frecuentes (clientes con más de 5 compras)
CREATE VIEW vista_clientes_frecuentes AS
SELECT cliente.id_cliente, cliente.nombre AS nombre_cliente, COUNT(venta.id_venta) AS total_compras
FROM cliente
JOIN venta ON cliente.id_cliente = venta.id_cliente
GROUP BY cliente.id_cliente
HAVING total_compras > 5;
select * from vista_clientes_frecuentes;