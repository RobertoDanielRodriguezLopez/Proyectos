use henry_m3;

-- Creamos la tabla que auditará a los usuarios que realizan cambios
DROP TABLE IF EXISTS `fact_venta_auditoria`;
CREATE TABLE IF NOT EXISTS `fact_venta_auditoria` (
	IdFactVentaAuditoria INT NOT NULL AUTO_INCREMENT,
    `Fecha`				DATE,
	`Fecha_Entrega`		DATE,
  	`IdCanal` 			INTEGER,
  	`IdCliente` 		INTEGER,
  	`IdEmpleado` 		INTEGER,
  	`IdProducto` 		INTEGER,
    `usuario` 			VARCHAR(30),
    `fechaModificacion` 	DATETIME,
    PRIMARY KEY(IdFactVentaAuditoria)
);

DROP TRIGGER fact_venta_auditoria;
CREATE TRIGGER fact_venta_auditoria AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_auditoria (Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado,
 IdProducto, usuario, fechaModificacion)
VALUES (NEW.Fecha, NEW.Fecha_Entrega, NEW.IdCanal, NEW.IdCliente, NEW.IdEmpleado,
 NEW.IdProducto, current_user(), NOW());

TRUNCATE TABLE fact_venta;

INSERT INTO fact_venta
SELECT IdVenta, Fecha, Fecha_Entrega, IdCanal, IdCliente, IdEmpleado, IdProducto, Precio, Cantidad
FROM venta
LIMIT 30;

-- Creamos la tabla que llevara una cuenta de los registros.
DROP TABLE IF EXISTS `fact_venta_registros`;
CREATE TABLE IF NOT EXISTS `fact_venta_registros` (
  	IdFactVentaRegistros INT NOT NULL AUTO_INCREMENT,
	cantidadRegistros INT,
	usuario VARCHAR (20),
	fechaHora DATETIME,
	PRIMARY KEY (IdFactVentaRegistros)
);

DROP TRIGGER fact_venta_registros;
CREATE TRIGGER fact_venta_registros AFTER INSERT ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_registros (cantidadRegistros, usuario, fechaHora)
VALUES ((SELECT count(*) FROM fact_venta), current_user(), now());

-- Creamos una tabla donde podremos almacenar la cantidad de registros por día
DROP TABLE registros_tablas;
CREATE TABLE registros_tablas (
idRegistros INT NOT NULL AUTO_INCREMENT,
tabla VARCHAR(30),
fechaHora DATETIME,
cantidadRegistros INT,
PRIMARY KEY (idRegistros)
);

INSERT INTO registros_tablas (tabla, fechaHora, cantidadRegistros)
SELECT 'venta', NOW(), COUNT(*)
FROM venta;

INSERT INTO registros_tablas (tabla, fechaHora, cantidadRegistros)
SELECT 'gasto', NOW(), COUNT(*)
FROM gasto;

-- Creamos una tabla para auditar cambios
DROP TABLE IF EXISTS `fact_venta_cambios`;
CREATE TABLE IF NOT EXISTS `fact_venta_cambios` (
  	IdFactVentaCambios INT NOT NULL AUTO_INCREMENT,
    `Fecha` 			DATE,
  	`IdCliente` 		INTEGER,
  	`IdProducto` 		INTEGER,
    `Precio` 			DECIMAL(15,3),
    `Cantidad` 			INTEGER,
    `usuario` 			VARCHAR(20),
    `fechaHoraModificacion` 	DATETIME,
    PRIMARY KEY(IdFactVentaCambios)
);

DROP TRIGGER control_actualizacion;
CREATE TRIGGER control_actualizacion AFTER UPDATE ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_cambios
VALUES (NULL, OLD.Fecha, OLD.IdCliente, OLD.IdProducto, OLD.Precio, OLD.Cantidad, current_user(), NOW());

-- Bonus Track Tabla para eliminados (cuidado con eliminar datos sin un control estricto)

DROP TABLE IF EXISTS `fact_venta_eliminados`;
CREATE TABLE IF NOT EXISTS fact_venta_eliminados (
  	IdFactVentaEliminados INT NOT NULL AUTO_INCREMENT,
    `Fecha` 			DATE,
  	`IdCliente` 		INTEGER,
  	`IdProducto` 		INTEGER,
    `Precio` 			DECIMAL(15,3),
    `Cantidad` 			INTEGER,
    `usuario` 			VARCHAR(20),
    `fechaHoraModificacion` 	DATETIME,
    PRIMARY KEY(IdFactVentaEliminados)
);

DROP TRIGGER control_eliminados;
CREATE TRIGGER control_eliminados AFTER DELETE ON fact_venta
FOR EACH ROW
INSERT INTO fact_venta_eliminados
VALUES (NULL, OLD.Fecha, OLD.IdCliente, OLD.IdProducto, OLD.Precio, OLD.Cantidad, current_user(), NOW());

UPDATE fact_venta
SET Cantidad = 2
WHERE IdVenta = 2;

DELETE
FROM fact_venta
WHERE IdVenta = 2;
