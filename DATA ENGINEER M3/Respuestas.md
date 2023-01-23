### 6) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto) ¿Cuál es la sucursal con mayor ganancia neta en 2019? 
select distinct s.Sucursal, SUM(v.precio*v.cantidad) - sum(g.Monto) as Ganancia
from venta v
join gasto g on (g.idsucursal = v.idsucursal)
join sucursal s on (s.idsucursal = v.idsucursal)
WHERE YEAR(v.Fecha) = 2019
group by s.Sucursal
HAVING Ganancia
Order by Ganancia desc;


SELECT
    s.IdSucursal,
    s.Sucursal,
    SUM(v.precio * v.Cantidad - g.monto) as gan
FROM venta v
JOIN sucursal s ON (v.IdSucursal = S.IdSucursal)
JOIN gasto g ON (s.IdSucursal = g.IdSucursal)
WHERE YEAR(v.fecha) = 2019
GROUP BY s.IdSucursal
ORDER BY gan DESC;

### 7) La ganancia neta por producto es las ventas menos las compras (Ganancia = Venta - Compra) ¿Cuál es el tipo de producto con mayor ganancia neta en 2019?

select distinct tp.TipoProducto, SUM(v.precio*c.cantidad - c.Precio*c.Cantidad) as Ganancia
from venta v
join compra c on (c.IdProducto = v.IdProducto)
join producto p on (p.IdProducto = c.IdProducto)
join tipo_producto tp on (p.IdTipoProducto = tp.IdTipoProducto)
WHERE YEAR(v.Fecha) = 2019 AND YEAR(c.Fecha) = 2019
group by TipoProducto
HAVING Ganancia
Order by Ganancia desc;

SELECT
    tp.TipoProducto,
    SUM(v.Precio*c.Cantidad - c.Precio*c.Cantidad) as gan
FROM venta v
JOIN compra c ON (v.IdProducto = c.IdProducto)
JOIN producto p ON (c.IdProducto = p.IdProducto)
JOIN tipo_producto tp ON (p.IdTipoProducto = tp.IdTipoProducto)
WHERE YEAR(v.Fecha) = 2019 AND YEAR(c.Fecha) = 2019
GROUP BY TipoProducto
ORDER BY gan DESC;




### 9) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje no había realizado compras en 2019? (expresado en porcentaje y con dos decimales, por ejemplo 11.11)

    WITH
    customers_2020 AS (
        SELECT DISTINCT v.IdCliente
        FROM venta v
        WHERE YEAR(v.Fecha) = 2020
    ),
    customers_2019 AS (
        SELECT DISTINCT v.IdCliente
        FROM venta v
        WHERE YEAR(v.Fecha) = 2019
    ),
    customers_2020_not_2019 AS (
        SELECT tab2020.IdCliente
        FROM customers_2020 tab2020
        LEFT JOIN customers_2019 tab2019 ON (tab2020.IdCliente = tab2019.IdCliente)
        WHERE tab2019.IdCliente IS NULL
    )
SELECT
    COUNT(IdCliente) / (SELECT COUNT(*) FROM customers_2020) AS Prom
FROM customers_2020_not_2019;



### 10) Del total de clientes que realizaron compras en 2019 ¿Qué porcentaje lo hizo también en 2020? (expresado en porcentaje y con dos decimales, por ejemplo 11.11)


WITH
    customers_2019 AS (
        SELECT DISTINCT v.IdCliente
        FROM venta v
        WHERE YEAR(v.Fecha) = 2019
    ),
    customers_2020 AS (
        SELECT DISTINCT v.IdCliente
        FROM venta v
        WHERE YEAR(v.Fecha) = 2020
    ),
    customers_2019_2020 AS (
        SELECT tab2020.IdCliente
        FROM customers_2020 tab2020
        INNER JOIN customers_2019 tab2019 ON (tab2020.IdCliente = tab2019.IdCliente)
    )
SELECT
    COUNT(IdCliente) / (SELECT COUNT(*) FROM customers_2019) AS Prom
FROM customers_2019_2020;



### 11) ¿Qué cantidad de clientes realizó compras sólo por el canal Presencial entre 2019 y 2020?

SELECT count(*) as Cantidad
FROM ( # Clientes que compraron Online en 2020
    SELECT DISTINCT v.IdCliente
    FROM venta v 
    JOIN canal_venta cv ON (v.IdCanal = cv.IdCanal)
    WHERE cv.Canal = "Presencial" AND YEAR(v.Fecha) BETWEEN 2019 AND 2020
    ) clientesOnline2019_2020
WHERE IdCliente NOT IN ( #CLientes que compraron por un medio diferente al Online en 2020
    SELECT DISTINCT v.IdCliente
    FROM venta v 
    JOIN canal_venta cv ON (v.IdCanal = cv.IdCanal)
    WHERE cv.Canal != "Presencial" AND YEAR(v.Fecha) BETWEEN 2019 AND 2020    
);

### 12) ¿Cuál es la sucursal que más Venta (Precio * Cantidad) hizo en 2019 a clientes que viven fuera de su provincia?
SELECT
    Sucursal,
    SUM(TotalVenta) AS TOTAL
FROM ( # Tabla con la sucursal y provincia de sucursal en cada venta
    SELECT 
        v.IdVenta, 
        s.IdSucursal,
        S.Sucursal, 
        p.IdProvincia as Provincia_Sucursal,
        v.Cantidad * v.Precio AS TotalVenta
    FROM venta v
    JOIN sucursal s ON (v.IdSucursal = s.IdSucursal)
    JOIN localidad l ON (s.IdLocalidad = l.IdLocalidad)
    JOIN provincia p ON (l.IdProvincia = p.IdProvincia)
    WHERE YEAR(v.Fecha) = 2019
    ) Sucursal_p
JOIN ( # Tabla con el cliente y provincia de cliente en cada venta
    SELECT 
        v.IdVenta, 
        c.IdCliente, 
        p.IdProvincia as Provincia_Cliente
    FROM venta v
    JOIN cliente c ON (v.IdCliente = c.IdCliente)
    JOIN localidad l ON (c.IdLocalidad = l.IdLocalidad)
    JOIN provincia p ON (l.IdProvincia = p.IdProvincia)
    WHERE YEAR(v.Fecha) = 2019
    ) Cliente_p ON (Sucursal_p.IdVenta = Cliente_p.IdVenta)
WHERE Provincia_Sucursal != Provincia_Cliente
GROUP BY Sucursal
ORDER BY TOTAL DESC;

### 13) ¿Cuál fué el mes del año 2020, de mayor decrecimiento (o menor crecimiento) con respecto al mismo mes del año 2019 si se toman en cuenta a nivel general Ventas (Precio * Cantidad) - Compras (Precio * Cantidad) - Gastos? 
#### Responder el Número del Mes:
SELECT Dif_Ventas.Mes, Dif_Ventas.Ventas-Dif_Gastos.Gastos-Dif_Compras.Compras as Balance
FROM ( #Tabla con la diferencia de ventas entre 2020 y 2019 por mes
    SELECT 
        vent2020.Mes as Mes,
        vent2020.Venta - vent2019.Venta as Ventas
    FROM( #Tabla con la venta de 2020 por mes 
        SELECT 
            MONTH(fecha) as Mes,
            SUM(Precio * Cantidad) as Venta
        FROM venta v
        WHERE YEAR(Fecha) = 2020
        GROUP BY Mes
        ) vent2020
    JOIN( #Tabla con la venta de 2019 por mes 
        SELECT 
            MONTH(fecha) as Mes, 
            SUM(Precio * Cantidad) as Venta
        FROM venta v
        WHERE YEAR(Fecha) = 2019
        GROUP BY Mes
        ) vent2019 ON (vent2020.Mes = vent2019.Mes)
    ) Dif_Ventas
JOIN ( # Tabla con la diferencia de compra entre 2020 y 2019 por mes
    SELECT 
        comp2020.Mes as Mes,
        comp2020.Compra - comp2019.Compra as Compras
    FROM( #Compra de 2020 por mes
        SELECT 
            MONTH(fecha) as Mes,
            SUM(Precio * Cantidad) as Compra
        FROM compra c
        WHERE YEAR(Fecha) = 2020
        GROUP BY Mes
        ) comp2020
    JOIN(# Compra de 2019 por mes
        SELECT 
            MONTH(fecha) as Mes, 
            SUM(Precio * Cantidad) as Compra
        FROM compra c
        WHERE YEAR(Fecha) = 2019
        GROUP BY Mes
        ) comp2019 ON (comp2020.Mes = comp2019.Mes)
    ) Dif_Compras ON (Dif_Ventas.Mes = Dif_Compras.Mes)
JOIN (#Tabla con diferencia de gastos de 2020 y 2019 por mes
        SELECT 
        gast2020.Mes as Mes,
        gast2020.Gasto - gast2019.Gasto as Gastos
    FROM( # Tabla gastos por mes 2020
        SELECT 
            MONTH(fecha) as Mes,
            SUM(Monto) as Gasto
        FROM gasto g
        WHERE YEAR(Fecha) = 2020
        GROUP BY Mes
        ) gast2020
    JOIN( # Tabla Gastos por mes 2019
        SELECT 
            MONTH(fecha) as Mes, 
            SUM(Monto) as Gasto
        FROM gasto g
        WHERE YEAR(Fecha) = 2019
        GROUP BY Mes
        ) gast2019 ON (gast2020.Mes = gast2019.Mes)
    ) Dif_Gastos ON (Dif_Ventas.Mes = Dif_Gastos.Mes)
ORDER BY Balance;


### 14) El negocio suele requerir con gran frecuencia consultas a nivel trimestral tanto sobre las ventas, como las compras y los gastos, entonces:
SELECT 
    c.CodigoEmpleado,
    SUM(c.Porcentaje) as TotalPercent,
    e.Salario*SUM(c.Porcentaje)/100 as TotalComision
FROM comision c
JOIN empleado e ON (e.CodigoEmpleado = c.CodigoEmpleado)
WHERE Anio = 2020
GROUP BY CodigoEmpleado
ORDER BY TotalPercent DESC;