use henry_m3;

-- #1
SELECT DISTINCT c.IdCliente, c.Nombre_y_Apellido, v.IdProducto, v.Precio
FROM venta v
LEFT JOIN cliente c using(IdCliente);

-- #2
SELECT c.IdCliente, c.Nombre_y_Apellido,
		SUM(v.Cantidad) as cantidad_productos_null,
        SUM(ifnull(v.Cantidad, 0)) as cantidad_productos
FROM cliente c
LEFT JOIN venta v using(IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido
ORDER BY cantidad_productos DESC;

-- #3
SELECT c.IdCliente, c.Nombre_y_Apellido, YEAR(v.Fecha), count(v.IdVenta) as total_compras
FROM venta v
JOIN cliente c using(IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido, YEAR(v.Fecha)
ORDER BY YEAR(v.Fecha) DESC;

-- #4
SELECT c.IdCliente, c.Nombre_y_Apellido, p.Producto, p.IdProducto,
		SUM(v.Cantidad) as cantidad_productos,
        ROUND(AVG(v.Precio), 2) as precio_promedio
FROM venta v
JOIN producto p using(IdProducto)
JOIN cliente c using(IdCliente)
GROUP BY c.IdCliente, c.Nombre_y_Apellido, p.Producto, p.IdProducto
ORDER BY c.IdCliente;

-- #5
-- Revisar duplicados
SELECT localidad 
FROM localidad
GROUP BY localidad
HAVING count(*) > 1;

SELECT p.Provincia, l.Localidad,
		SUM(v.Cantidad) AS cantidad_productos,
        SUM(v.Precio * v.Cantidad) as total_ventas,
        count(v.IdVenta) as volumen_venta
FROM venta v
LEFT JOIN cliente c using(IdCliente)
LEFT JOIN localidad l ON(l.IdLocalidad = c.IdLocalidad)
LEFT JOIN provincia p using(IdProvincia)
WHERE v.Outlier = 1
GROUP BY p.Provincia, l.Localidad
ORDER BY p.Provincia, l.Localidad;

-- #6
SELECT p.Provincia,
		SUM(v.Cantidad) AS cantidad_productos,
        SUM(v.Precio * v.Cantidad) as total_ventas,
        count(v.IdVenta) as volumen_venta
FROM venta v
LEFT JOIN cliente c using(IdCliente)
LEFT JOIN localidad l ON(l.IdLocalidad = c.IdLocalidad)
LEFT JOIN provincia p using(IdProvincia)
WHERE v.Outlier = 1
GROUP BY p.Provincia
HAVING total_ventas > 100000
ORDER BY total_ventas desc;

-- #7
SELECT c.Rango_Etario,
		SUM(v.Cantidad) AS cantidad_productos,
        SUM(v.Precio * v.Cantidad) as total_ventas
FROM venta v
JOIN cliente c using(IdCliente)
WHERE v.Outlier = 1
GROUP BY c.Rango_Etario
ORDER BY c.Rango_Etario;

-- #8
SELECT p.IdProvincia, p.Provincia, count(c.IdCliente) as cantidad_clientes
FROM provincia p
LEFT JOIN localidad l ON(l.IdProvincia = p.IdProvincia)
LEFT JOIN cliente c ON(c.IdLocalidad = l.IdLocalidad)
GROUP BY p.IdProvincia, p.Provincia
ORDER BY p.IdProvincia;

