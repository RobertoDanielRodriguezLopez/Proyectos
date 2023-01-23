use henry_m3;

-- Venta agrupado por trimestre y rango etario
SELECT ca.trimestre, c.Rango_Etario, SUM(v.Precio * v.Cantidad) as venta
FROM venta v
JOIN cliente c ON(v.IdCliente = c.IdCliente) -- AND YEAR(v.Fecha) = 2020)
JOIN calendario ca ON(ca.Fecha = v.Fecha)
WHERE YEAR(v.Fecha) = 2020
GROUP BY ca.trimestre, c.Rango_Etario
ORDER BY ca.trimestre, c.Rango_Etario;
-- 14 seg
-- 0.25 seg

-- Venta agrupado por año, trimestre tipo de producto
SELECT c.anio, c.trimestre, tp.TipoProducto, SUM(v.Precio * v.Cantidad) as venta
FROM venta v
JOIN producto p ON(p.IdProducto = v.IdProducto)
JOIN tipo_producto tp ON(tp.IdTipoProducto = p.IdTipoProducto)
JOIN calendario c ON(c.Fecha = v.Fecha)
GROUP BY c.anio, c.trimestre, tp.TipoProducto
ORDER BY c.anio, c.trimestre, tp.TipoProducto;
-- 2.8 seg
-- 0.8 seg

-- Venta agrupado por sucursal, canal, mayor a 5000000
SELECT s.Sucursal, cv.Canal, SUM(v.Precio * v.Cantidad) as venta
FROM venta v
JOIN sucursal s ON(s.IdSucursal = v.IdSucursal)
JOIN canal_venta cv ON(cv.IdCanal = v.IdCanal)
GROUP BY s.Sucursal, cv.Canal
HAVING venta > 5000000
ORDER BY 3 DESC;
-- 0.4 seg
-- 1.3 seg
SELECT YEAR(g.Fecha), tg.Tipo_Gasto, SUM(g.Monto)
FROM gasto g
JOIN tipo_gasto tg ON(tg.IdTipoGasto = g.IdTipoGasto)
GROUP BY YEAR(g.Fecha), tg.Tipo_Gasto
ORDER BY 3 DESC;
-- 0.07
-- 0.07
/*Creamos indices de las tablas determinando claves primarias y foraneas*/
ALTER TABLE `venta` ADD PRIMARY KEY(`IdVenta`);
ALTER TABLE `venta` ADD INDEX(`IdProducto`);
ALTER TABLE `venta` ADD INDEX(`IdEmpleado`);
ALTER TABLE `venta` ADD INDEX(`Fecha`);
ALTER TABLE `venta` ADD INDEX(`Fecha_Entrega`);
ALTER TABLE `venta` ADD INDEX(`IdCliente`);
ALTER TABLE `venta` ADD INDEX(`IdSucursal`);
ALTER TABLE `venta` ADD INDEX(`IdCanal`);

ALTER TABLE `calendario` ADD UNIQUE(`fecha`);

ALTER TABLE `canal_venta` ADD PRIMARY KEY(`IdCanal`);

ALTER TABLE `producto` ADD PRIMARY KEY(`IdProducto`);
ALTER TABLE `producto` ADD INDEX(`IdTipoProducto`);

-- ALTER TABLE `tipo_producto` ADD PRIMARY KEY(`IdTipoProducto`); -- Ya fue definido como PK

ALTER TABLE `sucursal` ADD PRIMARY KEY(`IdSucursal`);
ALTER TABLE `sucursal` ADD INDEX(`IdLocalidad`);

ALTER TABLE `empleado` ADD PRIMARY KEY(`IdEmpleado`); -- Revisar duplicados
-- ALTER TABLE `empleado` ADD PRIMARY KEY(`CodigoEmpleado`); -- Esto da error de clave duplicada
ALTER TABLE `empleado` ADD INDEX(`IdSucursal`);
ALTER TABLE `empleado` ADD INDEX(`IdSector`);
ALTER TABLE `empleado` ADD INDEX(`IdCargo`);

ALTER TABLE `localidad` ADD INDEX(`IdProvincia`);

ALTER TABLE `proveedor` ADD PRIMARY KEY(`IdProveedor`);
ALTER TABLE `proveedor` ADD INDEX(`IdLocalidad`);

ALTER TABLE `gasto` ADD PRIMARY KEY(`IdGasto`);
ALTER TABLE `gasto` ADD INDEX(`IdSucursal`);
ALTER TABLE `gasto` ADD INDEX(`IdTipoGasto`);
ALTER TABLE `gasto` ADD INDEX(`Fecha`);

ALTER TABLE `cliente` ADD PRIMARY KEY(`IdCliente`);
ALTER TABLE `cliente` ADD INDEX(`IdLocalidad`);

ALTER TABLE `compra` ADD PRIMARY KEY(`IdCompra`);
ALTER TABLE `compra` ADD INDEX(`Fecha`);
ALTER TABLE `compra` ADD INDEX(`IdProducto`);
ALTER TABLE `compra` ADD INDEX(`IdProveedor`);

-- DROP INDEX IdCliente ON venta; -- Ejemplo borrar índice

/*Creamos las relaciones entre las tablas, y con ellas las restricciones*/
ALTER TABLE venta ADD CONSTRAINT `venta_fk_fecha` FOREIGN KEY (fecha) REFERENCES calendario (fecha) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_cliente` FOREIGN KEY (IdCliente) REFERENCES cliente (IdCliente) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_sucursal` FOREIGN KEY (IdSucursal) REFERENCES sucursal (IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_producto` FOREIGN KEY (IdProducto) REFERENCES producto (IdProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_empleado` FOREIGN KEY (IdEmpleado) REFERENCES empleado (IdEmpleado) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE venta ADD CONSTRAINT `venta_fk_canal` FOREIGN KEY (IdCanal) REFERENCES canal_venta (IdCanal) ON DELETE RESTRICT ON UPDATE RESTRICT;

select * from venta where IdCliente = 969;
delete from cliente where IdCliente = 969; -- No me deja porque está creada la restricción

select * from cliente where IdCliente
NOT IN (SELECT DISTINCT IdCliente FROM venta);
delete from cliente where IdCliente = 59; -- Me deja, está creada la restricción, pero no existe el cliente en ventas

ALTER TABLE producto ADD CONSTRAINT `producto_fk_tipoproducto` FOREIGN KEY (IdTipoProducto) REFERENCES tipo_producto (IdTipoProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE empleado ADD CONSTRAINT `empleado_fk_sector` FOREIGN KEY (IdSector) REFERENCES sector (IdSector) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE empleado ADD CONSTRAINT `empleado_fk_cargo` FOREIGN KEY (IdCargo) REFERENCES cargo (IdCargo) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE empleado ADD CONSTRAINT `empleado_fk_sucursal` FOREIGN KEY (IdSucursal) REFERENCES sucursal (IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE cliente ADD CONSTRAINT `cliente_fk_localidad` FOREIGN KEY (IdLocalidad) REFERENCES localidad (IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE proveedor ADD CONSTRAINT `proveedor_fk_localidad` FOREIGN KEY (IdLocalidad) REFERENCES localidad (IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE sucursal ADD CONSTRAINT `sucursal_fk_localidad` FOREIGN KEY (IdLocalidad) REFERENCES localidad (IdLocalidad) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE localidad ADD CONSTRAINT `localidad_fk_provincia` FOREIGN KEY (IdProvincia) REFERENCES provincia (IdProvincia) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE compra ADD CONSTRAINT `compra_fk_fecha` FOREIGN KEY (Fecha) REFERENCES calendario (fecha) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE compra ADD CONSTRAINT `compra_fk_producto` FOREIGN KEY (IdProducto) REFERENCES producto (IdProducto) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE compra ADD CONSTRAINT `compra_fk_proveedor` FOREIGN KEY (IdProveedor) REFERENCES proveedor (IdProveedor) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE gasto ADD CONSTRAINT `gasto_fk_fecha` FOREIGN KEY (Fecha) REFERENCES calendario (fecha) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE gasto ADD CONSTRAINT `gasto_fk_sucursal` FOREIGN KEY (IdSucursal) REFERENCES sucursal (IdSucursal) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE gasto ADD CONSTRAINT `gasto_fk_tipogasto` FOREIGN KEY (IdTipoGasto) REFERENCES tipo_gasto (IdTipoGasto) ON DELETE RESTRICT ON UPDATE RESTRICT;

/*Cracion de Tablas de Hechos para modelo Estrella*/
DROP TABLE IF EXISTS `fact_venta`;
CREATE TABLE IF NOT EXISTS `fact_venta` (
  `IdVenta`				INTEGER,
  `Fecha` 				DATE NOT NULL,
  `Fecha_Entrega` 		DATE NOT NULL,
  `IdCanal`				INTEGER, 
  `IdCliente`			INTEGER, 
  `IdEmpleado`			INTEGER,
  `IdProducto`			INTEGER,
  `Precio`				DECIMAL(15,2),
  `Cantidad`			INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO fact_venta
SELECT IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
FROM venta
WHERE YEAR(Fecha) = 2020;

ALTER TABLE `fact_venta` ADD PRIMARY KEY(`IdVenta`);
ALTER TABLE `fact_venta` ADD INDEX(`IdProducto`);
ALTER TABLE `fact_venta` ADD INDEX(`IdEmpleado`);
ALTER TABLE `fact_venta` ADD INDEX(`Fecha`);
ALTER TABLE `fact_venta` ADD INDEX(`Fecha_Entrega`);
ALTER TABLE `fact_venta` ADD INDEX(`IdCliente`);
ALTER TABLE `fact_venta` ADD INDEX(`IdCanal`);

DROP TABLE IF EXISTS dim_cliente;
CREATE TABLE IF NOT EXISTS dim_cliente (
	IdCliente			INTEGER,
	Nombre_y_Apellido	VARCHAR(80),
	Domicilio			VARCHAR(150),
	Telefono			VARCHAR(30),
	Rango_Etario		VARCHAR(20),
	IdLocalidad			INTEGER,
	Latitud				DECIMAL(13,10),
	Longitud			DECIMAL(13,10)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO dim_cliente
SELECT IdCliente, Nombre_y_Apellido, Domicilio, Telefono, Rango_Etario, IdLocalidad, Latitud, Longitud
FROM cliente
WHERE IdCliente IN (SELECT distinct IdCliente FROM fact_venta);

DROP TABLE IF EXISTS dim_producto;
CREATE TABLE IF NOT EXISTS dim_producto (
	IdProducto					INTEGER,
	Producto					VARCHAR(100),
	IdTipoProducto				VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

INSERT INTO dim_producto
SELECT IdProducto, Producto, IdTipoProducto
FROM producto
WHERE IdProducto IN (SELECT distinct IdProducto FROM fact_venta);
