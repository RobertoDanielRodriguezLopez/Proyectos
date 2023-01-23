![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## KPIs & Business Applications

Un KPI (Key Performance Indicator) como su denominación lo define, es un indicador clave de rendimiento. Puede ayudarte a evaluar el valor actual y el estado de una métrica en relación con un objetivo definido. Debido a esto es importante entender el valor del objetivo para que se pueda a partir de él definir métricas claves.<br>

Para que un KPI funcione como debe, este tiene que cumplir con las siguientes características:

- Alcanzable: Los objetivos planteados deben de ser realistas.<br>
- Medible: Aunque suene obvio, un KPI debe de poder medirse.<br>
- Relevante: No te llenes de datos, selecciona solo los más importantes.<br>
- Periódico: El indicador tiene que ser analizable periódicamente.<br>
- Exacto: Elige solo la parte más precisa de toda la información recabada.<br>

Un KPI es un número, que puede obtenerse de manera de directa o mediante alguna fórmula de cálculo. Por ejemplo, si el objetivo es incrementar las ventas anuales un 25 %, nuestro KPI sería el resultado de “VENTAS ACTUALES x 1.25”. Ese mismo KPI podría expresarse en N° de unidades, volumen de ventas, etc., como mencionábamos anteriormente depende del objetivo.<br>
Los KPI’s además se relacionan con el nivel de responsabilidades sobre los resultados en una organización. Tomando el ejemplo anterior, un agente de ventas puede tener un KPI individual que contribuya a cumplir con el objetivo operativo del área.<br>
En la industria de la tecnología en muy común que una empresa se financie a través de capital de riesgo, por lo que la definición y seguimiento de buenos KPI son cruciales para acceder a nueva inversión y asegurar en éxito de la compañía.

[¿Como tener éxito en una stratup?](https://www.ycombinator.com/library/89-how-to-succeed-with-a-startup-sus-2018)

[Stratup - Paul Graham](http://paulgraham.com/start.html)

[Understanding The Real Keys To Effective KPis](https://ide.mit.edu/wp-content/uploads/2018/08/2018-08-MITIDE-researchbrief-Schrage-Kiron.pdf?x57209)

### ¿Cuáles son los KPI´s relevantes en tecnología?

* Runway:

El runway es la cantidad de tiempo de vida que tiene una startup antes de quedarse sin efectivo, medido en número de meses.<br>
Runway = Efectivo ÷ Gastos mensuales totales. (Expresado en meses).

Por ejemplo, si una startup gasta USD $ 10 mil al mes y tienes USD $ 50 mil en caja, tiene 5 meses de “vida”.

¿Por qué es importante?

El runway es la principal métrica de supervivencia a la que el CEO de una startup tiene que dar seguimiento. De hecho, quedarse sin runway es la primera razón más común por las que las startups fracasan.

[Runway](https://www.brex.com/blog/startup-runway/#:~:text=Startup%20runway%20refers%20to%20how,fundraising%20throughout%20your%20company%27s%20lifecycle.)

* Conversion rate:

Permite conocer la capacidad de monetizar un negocio. Las startups están basadas en tecnología, lo que les permite poder escalar de manera rápida. La tasa de conversión es el la cantidad de clientes que compraron mi producto sobre la cantidad total de clientes "registrados" o "interesados". Las tasas de conversión se toman en base a distintos grados de avance que puede tener un cliente a través del proceso de compra.<br>
Visita al sitio - Registro - Inicio del proceso de compra - Compra.

Para cada paso se puede medir una conversión:<br>
  -- Registros / Visitas al sitio.<br>
  -- Inicios de proceso de compra / Registros.<br>
  -- Compras / Inicios del proceso de compra.<br>

[Conversion rate](https://blog.useproof.com/calculate-conversion-rate)

* CAC (Customer Adquisition Cost): 
El CAC es una suma de los costos de adquisición directos e indirectos de cada canal, dividiéndolo entre el número total de usuarios captados. En los inicios de la vida de una startup, gran parte del costo está directamente relacionado a la pauta (Google Ads, Facebook Ads, etc.) y prensa (notas en medios). Es de esperar que este costo disminuya en el tiempo conforme aumenta la captación orgánica (potenciales clientes que buscan específicamente nuestro negocio).<br>
Los modelos de atribución permiten fidelizar esta métrica a partir de poder distinguir de que campañas o anuncios se atribuye un cliente.

[Modelo de atribución de Google Ads](https://support.google.com/google-ads/answer/6259715?hl=es-419)

[Modelo de atribución de Facebook Ads](https://www.facebook.com/business/help/370704083280490?id=399393560487908)

* LTV (Lifetime Value):
Es el valor neto de ingresos que genera un cliente durante el tiempo que permanece en cartera. Como puedes apreciar, esta métrica es una estimación debido a que se obtiene a partir de otros cálculos tales como cuanto tiempo un cliente estará activo.

LTV= Compra media x Cantidad de compras x Tiempo activo en cartera

Esta métrica se relaciona con el CAC debido a que siempre debe ser mayor, debido a que un cliente debería reportanos en ingresos más de lo que nos cuesta captarlo.

[LTV](https://www.makingscience.es/blog/como-calcular-y-entender-el-ltv-y-cac-de-tu-negocio/)

* Churn rate:
El churn rate es la tasa de cancelación o abandono registrada en la cartera de clientes. Podria medirse a partir de los clientes que no llegan abonar en un e-comerce, los que han dado de baja su suscripción de un servicio On-Demand, o aquellos que no presentan actividad por cierto tiempo en servicios basados en comisiones. Se para un periodo específico mensual, trimestral o anual.

(Clientes al cierre del período - Nuevos clientes del período) / Abandonos del periodo.

[Churn rate](https://blog.hubspot.es/service/que-es-churn)

* ROI (Return On Investment):
Esta métrica permite medir el retorno de un determinado proyecto o una empresa, puede darse el caso de que sea en base a estimaciones o variables concretas.

(Ingresos – Inversión total del proyecto) / Inversión total del proyecto

Podríamos medir el ROI de una campaña en Facebook Ads:

(Compras totales de clientes que fueron captados por un determinado anuncio - Inversión total en ese anuncio) / Inversión total en ese anuncio.

[Como un CFO trabaja con KIP Financieros - MIT](https://mitsloan.mit.edu/ideas-made-to-matter/how-chief-financial-officers-optimize-kpis-data-automation)

## Funciones en SQL
Como vimos en el apartado anterior, para construir KPI es importante relacionar distintas variables y obtener conclusiones a partir de los calculos que realizamos. Comencemos ahora con un primer acercamiento en SQL.

Al igual que en Excel, algunos lenguajues de programación y software estadísticos, hay que tener en cuenta lo siguiente a la hora de utilizar una función:

- Acción: es poco probable que conozcas todas las funciones que forman parte de SQL, por lo es importante al momento de buscar una función o funcionalidad, entender que tipo de acción u operación deseamos realizar.<br>
Ej: Quiero buscar una palabra específica en un campo y saber cuantas veces aparece (LIKE y COUNT). <br>
- Sintaxis: las fucniones poseen un nombre que esta dado por una palabra reservada y una forma específica de invocarla. Si ese nombre no se escribe de manera correcta, se iuncurre en un error de sintaxis.<br>
- Argumentos: los argumentos son los valores que se le deben pasar a una función para que esta pueda operar, si los argumentos no son válidos, la función no puede ejecutar la operación y devolvera un error.<br>
- Valor de retorno: Cuando utilizas una función debes saber que tipo de valor retorna (INT, STRING, BOOL, etc.). Puede suceder que a veces la función retorne un valor, pero no sea el esperado por el usuario.

Todo lo anterior siempre lo podrás encontrar en la documentación del software que utilices.


ORDER BY - Permite ordenar los registros de manera ascendente o descendente, dependiendo del orden que se declare. Por defecto los registros se ordenan de manera ascendente. Se puede ordenar por más de un campo teniendo relevancia el orden en el cual se encuentran listados en la consulta.

```SQL
--Ordena los registros por apellido de la A-Z
SELECT nombre, apellido, fechaIngreso
FROM alumnos
WHERE carrera = "Data Science"
ORDER BY apellido ASC

--Ordena los registros por la fecha de ingreso de la más reciente a la más antigua y luego por apellido de la A-Z.
SELECT nombre, apellido, fechaIngreso
FROM alumnos
WHERE carrera = "Data Science"
ORDER BY fechaIngreso DESC, apellido ASC

```

LIMIT - Permite devolver un número determinado de registros. Por defecto ordena los registros de manera ascendente.

```SQL
--Devuelve los 10 primeros.

SELECT nombre, apellido, fechaIngreso
FROM alumnos
WHERE carrera = "Data Science"
LIMIT 10;

--Devuelve del registro 6 al 15
SELECT nombre, apellido, fechaIngreso
FROM alumnos
WHERE carrera = "Data Science"
LIMIT 5,10;
```
## Agregaciones

COUNT - Permite contar los registros de una tabla.

```SQL

SELECT COUNT(*)
FROM alumnos
WHERE carrera = "Data Science"

```

SUM - Permite sumar valores cuantitativos.

```SQL
--Obtenemos el ingreso por pagos de AIC.
SELECT SUM(PagoAIC)
FROM alumnos
WHERE carrera = "Data Science" and graduado = "true"

```

AVG - Permite obtener el promedio de un campo cuantitativo.

```SQL
--Obtenemos el ingreso promedio por pagos de AIC.
SELECT AVG(PagoAIC)
FROM alumnos
WHERE carrera = "Data Science" and graduado = "true"

```
MAX, MIN - Permite obtener los valores máximos y mínimos de un determinado campo.

```SQL
--Obtenemos cuando fue el último ingreso de los alumnos graduados.
SELECT MAX(fechaIngreso)
FROM alumnos
WHERE carrera = "Data Science" and graduado = "true"

--Obtenemos cuando fue el primer ingreso de los alumnos graduados.
SELECT MIN(fechaIngreso)
FROM alumnos
WHERE carrera = "Data Science" and graduado = "true"
```
Las agregaciones anteriores te permiten obtener las primeras métricas en una organización, como puedes ver, en cada ejemplo solo se ha consultado sobre un campo; ¿Qué pasa si deseas agregar campos a tus consultas? en definitiva, expresar esas métricas en función de otros campos. Para poder hacerlo debes utilizar las sentencias:  
GROUP BY y HAVING.

GROUP BY - Permite agrupar campos cuando utilizamos funciones de agregación. Se deben agrupar todos los campos que no formen parte de la función de agregación.

```SQL
--Cantidad de alumnos por carrera
SELECT carrera, COUNT(*)
FROM alumnos
GROUP BY carrera

--Cantidad de alumnos por carrera por fecha de ingreso
SELECT carreras, fechaIngreso, COUNT(*)
FROM alumnos
GROUP BY carreras, fechaIngreso

```
HAVING - Funciona de manera similar a WHERE y permite filtrar sobre los campos agregados.

```SQL
--Listado de cohortes con más de 50 alumnos.
SELECT cohortes, COUNT(*)
FROM alumnos
GROUP BY carrera
HAVING COUNT (*) > 50

```

SELECT DISTINCT - Se utiliza para devolver sólo valores diferentes dentro de una tabla.

```SQL
--Listado de cohortes que poseen alumnos inscriptos.
SELECT DISTINCT cohortes
FROM alumnos

```
CONCAT - Retorna una concatenación de campos.

```SQL

SELECT CONCAT(nombre," ",apellido) AS [Nombre y Apellido]
FROM alumnos

```
Lee la documentación oficial de MySQL para familiarizarte con otras funciones puedes utilizar. Por ahora solo nos centraremos en las fucniones númericas, de texto y de fecha/hora. Mas Adelante en el M3 profundizaremos en un conocimiento más avanzado de SQL.

[Funciones númericas](https://dev.mysql.com/doc/refman/8.0/en/numeric-functions.html)

[Funciones de texto](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html#function_concat)

[Funciones de fecha y hora](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html)


## Orden de tecleado de una consulta

Cuando realizas una consulta SQL, existe un orden definido para declarar las sentencias y así evitar los errores.

1. SELECT:Primero debemos definir los campos a mostrar en nuestra consulta, cuando utilizamos (*) mostramos todos los campos.
2. FROM: Luego establecemos desde que tabla se obtendrán los campos que se listaron anteriormente.
3. WHERE: Establecemos las condiciones sobre las que se va a ejecutar la consulta.
4. GROUP BY: Agrupamos los campos en caso de tener funciones de agregación en SELECT.
5. HAVING: Se establecen filtros sobre los campos agregados, es importante agrupar antes de filtrar con HAVING.
6. ORDER BY: Por último, ordenamos según los criterios necesarios.  

Muchos de estos conceptos serán retomados en el M5, cuando desarrollemos las herramientas que nos ayudarán en la visualización y difusión de las métricas.

## Homework

1. ¿Cuantas carreas tiene Henry?
SELECT COUNT(nombre) AS Cantidad_carreras
FROM carrera;
2. ¿Cuantos alumnos hay en total?
SELECT COUNT(idAlumno) AS Cantidad_Alumnos
FROM alumno;
3. ¿Cuantos alumnos tiene cada cohorte?
SELECT idCohorte, COUNT(*)
FROM alumno
GROUP BY idCohorte;
4. Confecciona un listado de los alumnos ordenado por los últimos alumnos que ingresaron, con nombre y apellido en un solo campo.
SELECT concat(nombre, ' ', apellido) AS nombres_apellidos, fechaIngreso
FROM alumno
ORDER BY fechaIngreso DESC;
5. ¿Cual es el nombre del primer alumno que ingreso a Henry?
SELECT concat(nombre, ' ', apellido) AS nombres_apellidos, fechaIngreso
FROM alumno
ORDER BY fechaIngreso
LIMIT  1;
6. ¿En que fecha ingreso?
SELECT MIN(fechaIngreso)
FROM alumno;
7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?
SELECT concat(nombre, ' ', apellido) AS nombre_apellido, fechaIngreso
FROM alumno
ORDER BY fechaIngreso DESC
LIMIT 1;
8. La función YEAR le permite extraer el año de un campo date, utilice esta función y especifique cuantos alumnos ingresarona a Henry por año.
SELECT YEAR(fechaIngreso), count(*) 
FROM alumno
GROUP BY YEAR(fechaIngreso)
ORDER BY YEAR(fechaIngreso) DESC;
9. ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año. WEEKOFYEAR()
SELECT YEAR(fechaIngreso) AS Año_ingreso, count(*) AS contador,  WEEKOFYEAR(fechaIngreso) AS semana_año
FROM alumno
GROUP BY YEAR(fechaIngreso), WEEKOFYEAR(fechaIngreso)
ORDER BY YEAR(fechaIngreso) , WEEKOFYEAR(fechaIngreso);
10. ¿En que años ingresaron más de 20 alumnos?
SELECT YEAR(fechaIngreso) AS Año, count(*) AS ingresos_al_año
FROM alumno
GROUP BY YEAR(fechaIngreso)
HAVING count(*) > 20
ORDER BY YEAR(fechaIngreso);
11. Investigue las funciones TIMESTAMPDIFF() y CURDATE(). ¿Podría utilizarlas para saber cual es la edad de los instructores?. ¿Como podrías verificar si la función cálcula años completos? Utiliza DATE_ADD().
SELECT nombre,apellido,fechaNacimiento, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), fechaNacimiento)), '%Y') + 0 AS Edad
FROM instructor
ORDER BY Edad DESC;
12. Cálcula:<br>
            - La edad de cada alumno.<br>
UPDATE alumno
SET fechaNacimiento = '2002-01-02'
WHERE idAlumno = 127;

SELECT nombre,apellido,fechaNacimiento, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), fechaNacimiento)), '%Y') + 0 AS Edad
FROM alumno
ORDER BY Edad DESC;

            - La edad promedio de los alumnos de henry.<br>
SELECT AVG(DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), fechaNacimiento)), '%Y') + 0) AS Edad_promedio
FROM alumno;

            - La edad promedio de los alumnos de cada cohorte.<br>
SELECT idCohorte, AVG(DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), fechaNacimiento)), '%Y') + 0) AS Edad_promedio
FROM alumno
GROUP BY idCohorte;
13. Elabora un listado de los alumnos que superan la edad promedio de Henry.
SELECT nombre,apellido,fechaNacimiento, DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), fechaNacimiento)), '%Y') + 0 AS Edad
FROM alumno
WHERE DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), fechaNacimiento)), '%Y') + 0 > (SELECT AVG(DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW(), fechaNacimiento)), '%Y') + 0) AS Edad_promedio FROM alumno)
ORDER BY Edad DESC;

![ORDEN](/_src/assets/SQL.PNG)

<table class="hide" width="100%" style='table-layout:fixed;'>
  <tr>
    <td>
      <a href="https://airtable.com/shrSzEYT4idEFGB8d?prefill_clase=00-PrimerosPasos">
        <img src="https://static.thenounproject.com/png/204643-200.png" width="100"/>
        <br>
        Hacé click acá para dejar tu feedback sobre esta clase.
      </a>
    </td>
  </tr>
</table>
