use henry_m3;

SELECT IdProducto, avg(Precio) as promedio, avg(Precio) + (3 * stddev(Precio)) as maximo
from venta
GROUP BY IdProducto;

SELECT IdProducto, avg(Precio) as promedio, avg(Precio) - (3 * stddev(Precio)) as minimo
from venta
GROUP BY IdProducto;

-- Detección de Outliers
SELECT v.*, o.promedio, o.maximo 
from venta v
JOIN (SELECT IdProducto, avg(Precio) as promedio, avg(Precio) + (3 * stddev(Precio)) as maximo
	from venta
	GROUP BY IdProducto) o
ON (v.IdProducto = o.IdProducto)
WHERE v.Precio > o.maximo;

SELECT *
FROM venta
WHERE IdProducto = 42890;

SELECT v.*, o.promedio, o.maximo 
from venta v
JOIN (SELECT IdProducto, avg(Cantidad) as promedio, avg(Cantidad) + (3 * stddev(Cantidad)) as maximo
	from venta
	GROUP BY IdProducto) o
ON (v.IdProducto = o.IdProducto)
WHERE v.Cantidad > o.maximo;

SELECT *
FROM venta
WHERE IdProducto = 42883;

Select cantidad, count(*)
from venta
group by cantidad
ORDER BY 1;

-- Introducimos los outliers de cantidad en la tabla aux_venta

INSERT into aux_venta
select v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal, v.IdEmpleado,
v.IdProducto, v.Precio, v.Cantidad, 2
from venta v
JOIN (SELECT IdProducto, avg(Cantidad) as promedio, stddev(Cantidad) as Desv
	from venta
	GROUP BY IdProducto) v2
ON (v.IdProducto = v2.IdProducto)
WHERE v.Cantidad > (v2.Promedio + (3*v2.Desv)) OR v.Cantidad < (v2.Promedio - (3*v2.Desv)) OR v.Cantidad < 0;

-- Introducimos los outliers de precio en la tabla aux_venta

INSERT into aux_venta
select v.IdVenta, v.Fecha, v.Fecha_Entrega, v.IdCliente, v.IdSucursal,
v.IdEmpleado, v.IdProducto, v.Precio, v.Cantidad, 3
from venta v
JOIN (SELECT IdProducto, avg(Precio) as promedio, stddev(Precio) as Desv
	from venta
	GROUP BY IdProducto) v2
ON (v.IdProducto = v2.IdProducto)
WHERE v.Precio > (v2.Promedio + (3*v2.Desv)) OR v.Precio < (v2.Promedio - (3*v2.Desv)) OR v.Precio < 0;

-- Agrego 0 a los outliers en la tabla venta
ALTER TABLE venta ADD Outlier TINYINT  NOT NULL DEFAULT '1' AFTER Cantidad;
UPDATE venta v
JOIN aux_venta a
ON (v.IdVenta = a.IdVenta AND a.Motivo IN (2,3))
SET v.Outlier = 0;

-- Ventas con y sin outliers

SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(SELECT 	tp.TipoProducto,
			AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
	FROM 	venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto)
			JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
	GROUP BY tp.TipoProducto) co
JOIN
	(SELECT 	tp.TipoProducto,
			AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
	FROM 	venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
			JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
	GROUP BY tp.TipoProducto) so
ON co.TipoProducto = so.TipoProducto;

-- KPI: Margen de Ganancia por producto superior a 20%
SELECT 	venta.Producto, 
		venta.SumaVentas, 
        venta.CantidadVentas, 
        venta.SumaVentasOutliers,
        compra.SumaCompras, 
        compra.CantidadCompras,
        ((venta.SumaVentas / compra.SumaCompras - 1) * 100) as margen
FROM
	(SELECT 	p.Producto,
			SUM(v.Precio * v.Cantidad * v.Outlier) 	as 	SumaVentas,
			SUM(v.Outlier) 							as	CantidadVentas,
			SUM(v.Precio * v.Cantidad) 				as 	SumaVentasOutliers,
			COUNT(*) 								as	CantidadVentasOutliers
	FROM venta v JOIN producto p
		ON (v.IdProducto = p.IdProducto
			AND YEAR(v.Fecha) = 2019)
	GROUP BY p.Producto) AS venta
JOIN
	(SELECT 	p.Producto,
			SUM(c.Precio * c.Cantidad) 				as SumaCompras,
			COUNT(*)								as CantidadCompras
	FROM compra c JOIN producto p
		ON (c.IdProducto = p.IdProducto
			AND YEAR(c.Fecha) = 2019)
	GROUP BY p.Producto) as compra
ON (venta.Producto = compra.Producto);