![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Introducción a DML y ORM. Interacción con bases de datos.

En la clase anterior aprendimos como modelar un negocio para poder crear la estructura de una base de datos, siendo estas una de las fuentes de datos a consultar cuando sea necesario obtener información para la toma de decisiones.

SQL no solo permite interactuar con las bases de datos para crear sus objetos, sino que además nos permite escribir y recuperar datos. Esto es posible gracias al DML.

**DML (INSERT, UPDATE, DROP, SELECT, WHERE):**

Son sentencias que permiten administrar la información de una base de datos a partir de las tablas que la conforman. Las acciones que se pueden ejecutar son INSERTAR, MODIFICAR, ELIMINAR y CONSULTAR.

Insertar Datos

El tipo de datos a ingresar en el campo siempre debe coincidir con el definido al momento de crear la tabla.<br>
Opción 1: Se detallan en orden los campos y los registros a ingresar en cada uno ellos. Por cada sentencia INSERT INTO se puede declarar un VALUES. Es la opción menos eficiente para insertar datos en una tabla.
```SQL
INSERT INTO alumnos(nombre,apellido,fecha_nacimiento,ciudad,pais,cedulaIdentidad)
VALUES('Maria ','Becerra','2000-4-1','Rosario',,'Argentina',38564122)
```
```SQL
INSERT INTO alumnos(nombre,apellido,fecha_nacimiento,ciudad,pais,cedulaIdentidad)
VALUES('El ','Duki','1998-9-8','Santa Fé','Colombia',39874156)
```

Opción 2: Al igual que en la opción anterior, se detallan en orden los campos y los datos a ingresar en cada uno ellos. Solo se declara una sentencia INSERT INTO y luego se listan en VALUES cada uno de los registros separados por coma.
```SQL
INSERT INTO alumnos(nombre,apellido,fecha_nacimiento,ciudad,pais,cedulaIdentidad) 
VALUES('Jeronimo','Gonzales','1988-8-9','Córdoba','Argentina',33687456),
('Ricardo','Lorenzo','1975-2-10','La Paz','Bolivia',20856147),
('Carlos','Principe','1985-6-11','Montevideo','Montevideo','Uruguay',25478369)
```

Opción 3 : Se declara la sentencia INSERT INTO y el nombre de la tabla, luego se repite el VALUES de la opción 2. La diferencia con las anteriores es que se deben insertar datos para todos los campos que forman parte de la tabla.

```SQL
INSERT INTO alumnos
VALUES('Ernesto','Corvalan','1993-12-12','Caleta Olivia','Argentina',35879145),
('Roberto','Carlos','1997-1-13','Cuidad de México','México',37854698),
('Luis','Rodriguez','1976-3-14','Montevideo','Uruguay',20896369),
('Hernan','Crespo','1999-9-15','Santiago de Chile','Chile',39546178)
```

Es importante aclarar que la inserción de datos no se da desde la interacción directa de un usuario con el gestor de la base de datos (PgAdmin o Workbench), sino que se hace a por medio del código en el cual se desarrolla una aplicación.

En este ejemplo, puedes observar un script de PHP en donde se solicitan datos a un usuario mediante una aplicación:


![PHP](/_src/assets/PHP.png)


**Modificar Datos:**

Las sentencias de inserción no pueden utilizarse para modificar datos. Ya que en ese caso, deberíamos obtener advertencias por parte del gestor debido a el ingreso de datos duplicados. En caso de tener que reemplazar el valor de un registro utilizaremos UPDATE. Para utilizar esta sentencia, deberemos utilizar además SET y WHERE.

UPDATE <TABLA> - Especifica la tabla que vamos a modificar
SET <CAMPO> = <VALOR> - Especifica el campo a modificar y el nuevo valor a guardar.
WHERE <CAMPO> = <VALOR> - Declara una ruta de entrada al registro que vamos a modificar.

Como se menciono en el punto anterior, este tipo de procesos corren principalmente sobre aplicaciones.

Opción 1:
```SQL
UPDATE alumnos
SET nombre = 'Carlos' 
WHERE cedulaIdentidad = 35879145;
```

Opción 2:
```SQL
UPDATE alumnos
SET nombre = 'Juan',ciudad='Santa Fé' 
WHERE cedulaIdentidad = 33687456;
```

Será importante establecer cuidadosamente el campo a modificar, si no lo hacemos corremos el riesgo de modificar varios registros. Ese campo u otros pueden ser “filtrados” mediante la sentencia WHERE.

**Eliminar Datos:**

Cuando utilizamos DELETE, lo que se están borrando son registros y no datos de manera aislada. Si por ejemplo verificamos un error, no se debería eliminar el registro, sino realizar un UPDATE por el valor correcto.
```SQL
DELETE FROM alumnos WHERE idPerfil=1 

DELETE FROM alumnos WHERE fechaInscripcion>'2021-01-08'
```

**Consultar Datos:**

Para consultar los datos que se encuentran guardados en una tabla, se debe utilizar la sentencia SELECT, esta sentencia debe estar acompañada de manera obligatoria por FROM, se presentará en diversas variantes más adelante.<br>
SELECT es una sentencia de proyección, donde puedes “solicitar” los campos a consultar. En FROM se debe especificar cual será la tabla a consultar.<br>
Es muy común que a la hora de consultar, debas hacerlo según ciertas condiciones vinculadas a una problema de negocios, para poder incorporarlas a la lógica de la consulta, se utiliza la cláusula WHERE. Esta clausula además se acompañan por operadores que permiten establecer los criterios de segmentación.<br>
Nuevamente para dejar en claro, la aplicación habitual de una consulta se da dentro de las aplicaciones y podemos verlas reflejadas en los informes. Mucha de la información que vemos en la interfaz de una aplicación, es el resultado de consultas a una base datos.

**Operadores:**

Aritméticos
* " + " : Sumar.
* " - " : Restar.
* " * " : Multiplicar.
* " / " : Dividir.

```SQL
SELECT nombreProducto, subtotal + impuestos AS Total
FROM productos

SELECT nombreColaborador, sueldo - retenciones AS SueldoNeto
FROM staff

SELECT nombreProducto, precio * cantidad AS Total
FROM productos

```
Relacionales
* " = " : Igual.
* "!= ": Distinto.
* " > ": Mayor que, se puede agregar = para obtener >= mayor o igual.
* " < " : Menor que, se puede agregar = para obtener >= menor o igual.

```SQL
SELECT *
FROM productos
WHERE fechaVenta = '2022-03-28'

SELECT *
FROM productos
WHERE fechaVenta != '2021-12-25'

SELECT *
FROM productos
WHERE fechaVenta > '2021-12-31'

SELECT *
FROM productos
WHERE fechaVenta < '2022-1-1'
```

Lógicos
* NOT     : No. Se puede vincular con IN.
* AND     : Y. 
* OR      : O.
* BETWEEN : Entre.
* IN      : Define conjuntos.
* LIKE    : Como. Para comparar textos.

```SQL
SELECT *
FROM alumnos
WHERE carrera IS NOT 'Full Stack' 

SELECT *
FROM alumnos
WHERE pais = 'Colombia' AND pais = 'Mexico'

SELECT *
FROM alumnos
WHERE pais = 'Colombia' OR pais = 'Mexico'

SELECT *
FROM alumnos
WHERE fechaIngreso = '2022-01-01' BETWEEN '2022-05-31'

SELECT *
FROM alumnos
WHERE pais IN ('Colombia','Mexico')

SELECT *
FROM alumnos
WHERE nombreModulo LIKE '%datos%'
```

Haz visto como estos procesos pueden correr sobre aplicaciones o podemos realizarlos dentro del nuestro DBMS. En nuestro caso nos centraremos en la interacción como usuarios de un DBMS.

**ORM . Conceptos:**

[SQLAlchemy - The Database Toolkit for](https://www.sqlalchemy.org/)

Un ORM es un modelo de programación que permite interactuar con las estructuras de una base de datos relacional (SQL Server, MySQL, PostgreSQL, etc.), lo que ayuda a simplificar y acelerar el desarrollo de aplicaciones. Anteriormente habíamos mencionado que a través de las aplicaciones es como habitualmente se realizan los procesos de inserción, actualización, eliminación y consulta en una base de datos, el ORM permite a los desarrolladores simplificar esos procesos.<br>
Esta interacción es posible gracias a que las estructuras de la base de datos relacional se vinculan con las entidades lógicas del ORM, de tal modo que las acciones CRUD (Create, Read, Update, Delete) a ejecutar sobre la base de datos física se realizan de forma indirecta por medio del ORM.
Lo anterior permite al desarrollador no generar de manera manual el código SQL, debido a que los objetos o entidades de la base de datos serán manipulados mediante el leguaje de programación en el cual se este desarrollado (Python, javascript, PHP, ect.) a través de métodos desarrollados en el ORM.<br>
¿Cuándo usar un ORM?
Uno de los aspectos más importantes a evaluar para decidir utilizar un ORM es su rendimiento; a menor complejidad, menor rendimiento y viceversa. Si se opta por no utilizarlo en un proceso de desarrollo, el equipo deberá contar con bases sólidas en SQL.
La utilización de un ORM además permite la reducción de código en la aplicación, pero la principal desventaja derivada del alto nivel de abstracción generado entre el modelo de entidades de nuestra aplicación y el RDBMS subyacente. Esto puede llevar a importantes deficiencias en el rendimiento de las aplicaciones.

* Ejemplo para crear una tabla en ORM de Python.
```python
class Producto(db.Base):
  __tablename__ = 'producto'
    id = Column(Integer, primary_key=True)
    nombre = Column(String, nullable=False)
    precio = Column(Float)
  def __init__(self, nombre, precio):
    self.nombre = nombre
    self.precio = precio
  def __repr__(self):
    return f'Producto({self.nombre}, {self.precio})'
  def __str__(self):
    return self.nombre
```
* Ejemplo para agregar datos a una tabla en ORM de Python.
```python

def run():
arroz = Producto('Arroz', 1.25)
db.session.add(arroz)
print(arroz.id)
agua = Producto('Agua', 0.3)
db.session.add(agua)
db.session.commit()
print(arroz.id)
consulta = db.session.query(Producto)
ob = db.session.query(Producto).get(1)
productos = db.session.query(Producto).all()
num_productos = db.session.query(Producto).count()
agua = db.session.query(Producto).filter_by(nombre='Agua').first()
menos_de_1 = db.session.query(Producto).filter(Producto.precio < 1).all()
```
## Recursos adicionales

* [W3 SQL](https://www.w3schools.com/sql/)

* [SQL desde 0](http://deletesql.com/viewtopic.php?f=5&t=5&sid=67ee04e434bd9793ac2413325c095cb3)

## Homework

1.	Inserte los [siguientes](https://github.com/soyHenry/DS-M2/blob/main/Clase%2002/Homework/registros_henry.sql) registros dentro de la base de datos creada en la clase anterior, corregir los errores que impidan la instrucción.<br>
2.	No se sabe con certeza el lanzamiento de las cohortes N° 1245 y N° 1246, se solicita que las elimine de la tabla.<br>
DELETE FROM cohorte
WHERE idCohorte IN (1245, 1246);

3.	Se ha decidido retrasar el comienzo de la cohorte N°1243, por lo que la nueva fecha de inicio será el 16/05. Se le solicita modificar la fecha de inicio de esos alumnos.<br>
UPDATE cohorte
SET fechaInicio ='2022-05-16'
WHERE idCohorte = 1243;

4.	El alumno N° 165 solicito el cambio de su Apellido por “Ramirez”. <br>
UPDATE alumno
SET apellido ='Ramirez'
WHERE idAlumno = 165;

5.	El área de Learning le solicita un listado de alumnos de la Cohorte N°1243 que incluya la fecha de ingreso.<br>
SELECT *
FROM alumno
WHERE idCohorte = 1243;

6.	Como parte de un programa de actualización, el área de People le solicita un listado de los instructores que dictan la carrera de Full Stack Developer.<br>
SELECT DISTINCT idInstructor
FROM cohorte
WHERE idCarrera = 1;

SELECT DISTINCT i.idInstructor, i.nombre, i.apellido
FROM instructor i
JOIN cohorte c ON (c.idInstructor = i.idInstructor)
JOIN carrera ca ON (c.idCarrera = ca.idCarrera)
WHERE ca.nombre = 'Full Stack Developer';

7. Se desea saber que alumnos formaron parte de la cohorte N° 1235. Elabore un listado.<br>
SELECT *
FROM alumno
WHERE idCohorte = 1235;

8. Del listado anterior se desea saber quienes ingresaron en el año 2019.<br>
FROM alumno
WHERE idCohorte = 1235
-- AND fechaIngreso BETWEEN '2019-01-01' AND '2019-12-31';
AND YEAR(fechaIngreso) = 2019;

9. La siguiente consulta permite acceder a datos de otras tablas y devolver un listado con la carrera a la cual pertenece cada alumno:
SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre AS nombre_carrera
FROM alumno a 
JOIN cohorte c ON (c.idCohorte = a.idCohorte)
JOIN carrera ca ON (c.idCarrera = ca.idCarrera)
WHERE ca.idCarrera IN (1, 2);


```SQL
/* En el M3 profudizaremos en el aprendizaje de SQL, pero aprovechemos lo que sabemos hasta aquí para entender como funcionan las relacionales. */

SELECT alumnos.nombre, apellido, fechaNacimiento, carreras.nombre
FROM alumnos
INNER JOIN cohortes
ON cohorte=idCohorte
INNER JOIN carreras
ON carrera = idCarrera
```
Coneste la siguientes interrogantes:
  a. ¿Que campos permiten que se puedan acceder al nombre de la carrera?
  IdCohorte
  b. ¿Que tipo de ralación existe entre el nombre la tabla cohortes y alumnos?
Una cohorte pude tener muchos alumnos
  c. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer', utilizando LIKE y NOT LIKE?, ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que?
SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre AS nombre_carrera
FROM alumno a 
JOIN cohorte c ON (c.idCohorte = a.idCohorte)
JOIN carrera ca ON (c.idCarrera = ca.idCarrera)
WHERE ca.nombre LIKE ('%full stack%'); -- OK
WHERE ca.nombre NOT LIKE ('%Data%');

  d. ¿Proponga dos opciones para filtrar el listado solo por los alumnos que pertenecen a 'Full Stack Developer', utilizando " = " y " != "?  ¿Cual de las dos opciones es la manera correcta de hacerlo?, ¿Por que?
SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre AS nombre_carrera
FROM alumno a 
JOIN cohorte c ON (c.idCohorte = a.idCohorte)
JOIN carrera ca ON (c.idCarrera = ca.idCarrera)
WHERE ca.nombre = 'Full Stack Developer'; -- OK
WHERE ca.nombre != 'Data Science';


  e. ¿Como emplearía el filtrado utilizando el campo idCarrera?
SELECT a.nombre, a.apellido, a.fechaNacimiento, ca.nombre
FROM alumno a
INNER JOIN cohorte c
ON (c.idCohorte = a.idCohorte)
INNER JOIN carrera ca
ON (c.idCarrera = ca.idCarrera)
WHERE ca.idCarrera=1;


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
