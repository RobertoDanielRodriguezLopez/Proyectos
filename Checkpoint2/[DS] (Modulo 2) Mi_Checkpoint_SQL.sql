USE checkpoint_m2;
-- 6. 
SELECT IDProducto, concepto
FROM producto
WHERE concepto LIKE 'EPSON COPYFAX 2000'
;
-- 7
SELECT IdCanal, COUNT(idventa) AS cantidad
FROM venta
GROUP BY idCanal
ORDER BY cantidad ASC
;
-- 8
SELECT YEAR(fecha), MONTH(fecha), IdSucursal, sum(Precio*Cantidad) AS ventas_totales
FROM venta
WHERE YEAR(fecha) = 2015 AND idSucursal = 13
GROUP BY MONTH(fecha)
ORDER BY ventas_totales DESC
;
# Julian's version
select month(Fecha), count(*) as ventas 
from venta 
where IdSucursal=13 and fecha between '2015/1/1' and '2015/12/31'
group by month(fecha)
order by ventas desc ;

-- 9
SELECT YEAR(fecha) AS Año, ROUND(AVG(timestampdiff(day, Fecha, Fecha_Entrega)),2) AS dias
FROM Venta
GROUP BY YEAR(fecha)
ORDER BY dias DESC
;
-- 10
SELECT p.Tipo, sum(v.precio*v.cantidad) AS cantidadTotal
FROM venta AS v JOIN producto AS p ON v.IdProducto = p.IdProducto
WHERE YEAR(v.Fecha) = 2020
GROUP BY p.Tipo
ORDER BY cantidadTotal DESC
;
#Majo's version
select p.`Tipo`,v.`Fecha`, sum(v.precio*v.cantidad) as cantidadTotal 
from venta as v join producto as p on v.`IdProducto`=p.`IDProducto` 
where year(v.`Fecha`)=2020 
GROUP BY p.`Tipo` 
order by cantidadTotal desc;
    
-- 11
SELECT YEAR(fecha), MONTH(fecha), SUM(cantidad) AS Cantidad_Ventas
FROM venta
GROUP BY fecha
ORDER BY cantidad_ventas DESC
;
-- 12
SELECT concepto, count(*)
FROM producto
WHERE concepto LIKE '%DVD%'
;
-- 13
#Gracias majo!
SELECT Tipo, (MAX(Precio)-MIN(Precio)) AS Diferencia
FROM producto
GROUP BY Tipo
ORDER BY Diferencia
;
-- 14
SELECT count(*) 
FROM (SELECT Fecha, date_format(Fecha, '%Y%m') AS fecha_real_compra, Fecha_Entrega, date_format(Fecha_Entrega, '%Y%M') AS Fecha_Entrega_2 
FROM venta
WHERE date_format(Fecha, '%Y%m') != date_format(Fecha_Entrega, '%Y%m')) AS Table1
;
-- 15
SELECT idEmpleado, SUM(cantidad) AS Cantidad_Productos
FROM venta
GROUP BY idEmpleado
ORDER BY cantidad_Productos DESC
;