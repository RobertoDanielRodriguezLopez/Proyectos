use henry_m3;
-- #1
DROP PROCEDURE listaProductos;
DELIMITER $$
CREATE PROCEDURE listaProductos (fechaVenta DATE)
BEGIN
	SELECT DISTINCT p.Producto
    FROM venta v
    JOIN producto p ON(p.IdProducto = v.IdProducto AND v.Fecha = fechaVenta);
END $$
DELIMITER ;
CALL listaProductos('2018-01-26');

-- #2
DROP FUNCTION margenBruto;
DELIMITER $$
CREATE FUNCTION margenBruto(precio DECIMAL(15,2), margen DECIMAL(8,2)) RETURNS DECIMAL (15,2)
BEGIN
	DECLARE margenBruto DECIMAL(15,2);
    SET margenBruto = precio * margen;
    RETURN margenBruto;
END $$
DELIMITER ;
SELECT margenBruto(100, 1.2);

SELECT c.Fecha, pr.nombre as Proveedor, p.Producto, c.Precio as Precio_Compra, margenBruto(c.Precio, 1.2) as precio_con_margen
FROM compra c
JOIN producto p ON(p.IdProducto = c.IdProducto)
JOIN proveedor pr ON(pr.IdProveedor = c.IdProveedor);

-- #3
SELECT p.IdProducto, p.Producto, p.Precio, margenBruto(p.Precio, 1.2) as precio_con_margen
FROM producto p
JOIN tipo_producto tp ON(p.IdTipoProducto = tp.IdTipoProducto AND TipoProducto = 'Impresión');

-- #4
DROP PROCEDURE listaProductosCategoria;
DELIMITER $$
CREATE PROCEDURE listaProductosCategoria (categoria VARCHAR(30))
BEGIN
	SELECT v.*, p.Producto
    FROM venta v
    JOIN producto p ON(p.IdProducto = v.IdProducto)
    JOIN tipo_producto tp ON(tp.IdTipoProducto = p.IdTipoProducto AND TipoProducto collate utf8mb4_spanish_ci = categoria);
END $$
DELIMITER ;
CALL listaProductosCategoria('Limpieza');

-- #5
DROP PROCEDURE cargarFact_venta;
DELIMITER $$
CREATE PROCEDURE cargarFact_venta()
BEGIN
	INSERT INTO fact_venta
    SELECT IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
    FROM venta
    WHERE Outlier = 1
    LIMIT 10;
END $$
DELIMITER ;
CALL cargarFact_venta();

-- #6
DROP PROCEDURE ventasGrupoEtario;
DELIMITER $$
CREATE PROCEDURE ventasGrupoEtario(rango_etario VARCHAR(30))
BEGIN
	SELECT c.Rango_Etario, SUM(v.Precio * v.Cantidad) AS total_ventas
    FROM venta v
    JOIN cliente c ON(c.IdCliente = v.IdCliente AND c.Rango_Etario collate utf8mb4_spanish_ci LIKE concat('%', rango_etario, '%'))
    GROUP BY c.Rango_Etario;
END $$
DELIMITER ;
SELECT DISTINCT Rango_Etario
FROM cliente
WHERE Rango_Etario LIKE '%51 a 60%';
CALL ventasGrupoEtario('51%60');

-- #7
SET @grupo_etario = '4_De 51 a 60 años' collate utf8mb4_spanish_ci;
SELECT *
FROM dim_cliente
WHERE Rango_Etario  = @grupo_etario;


