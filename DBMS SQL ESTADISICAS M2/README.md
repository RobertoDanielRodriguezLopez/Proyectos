![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

## Introducción a sistemas de gestión de bases de datos

En este módulo aprenderás como es el proceso mediante el cual se generan las estructuras que forman parte de las bases de datos. Un dato es "una representación simbólica de un objeto o hecho de la realidad".
Teniendo esto presente, resulta claro que para poder crear una base de datos, primero deberás representar en un modelo aquello que va a persistir en ella.

"Modelamos la realidad para poder describirla a través de los datos que la representan".

### Modelos relacionales - Modelo Entidad - Relación

**Modelos de negocios:**

El modelado de datos es el proceso mediante el cual se definen los requisitos de negocio y se diseñan las mejores estructuras de datos para soportarlos.
El modelo de datos es el equivalente al plano de un edificio, y representa de forma conceptual aquello que se pretende diseñar. Durante cada etapa de madurez de datos que atraviesa una empresa, pueden existir distintos modelos que describan la realidad del negocio. En este módulo en particular nos centraremos en los inicios de un proyecto de tecnología, en el cual se debe definir la estructura de la base de datos de una aplicación (como concepto amplio que incluye tanto apps móviles, web, ect.).

**Bases de datos:**

Una base de datos “es una colección de datos almacenados de forma coherente y permanente”, estos datos provienen de entidades, objetos o hechos de la realidad, por lo que una de las primeras tareas al crear una base de datos tal como ya lo mencionamos, será definirlos y modelarlos.<br>
Para poder modelar la realidad y traducirla en una estructura coherente, uno de los modelos más utilizados, es el modelo relacional, basado principalmente en el modelo ENTIDAD-RELACIÓN. La información necesaria para su construcción se basa en el relevamiento del modelo de negocios de la organización a través de entidades, atributos y relaciones.<br>
La interacción de estas entidades en la realidad con los atributos que las describen, determinan las “relaciones” que se darán en la base de datos.
Una entidad es un "objeto" de la realidad que se puede describir a través de sus "atributos", a su vez cada entidad interactúa con otras entidades, lo que se denomina "relación". Cabe destacar que tanto las entidades como sus relaciones se definen a partir del grado de relevancia que tienen para el negocio que se esta modelando, y de ellos surgen los registros que luego van a persistir en la base de datos.<br>
Si pensamos en una Edtech, un "Alumno" es una entidad relevante que se puede describir mediante atributos tales como su nombre, apellido, fecha de nacimiento, fecha de ingreso, carrera que cursa, ect. Otra entidad importante es la del "Instructor" que también puede describirse por su nombre, apellido, fecha de nacimiento, fecha de incorporación, carrera que dicta, ect. Otros atributos tales como estatura, talle de calzado u otras, no serían importantes en este modelo.

**Modelo Entidad-Realación:**

El modelo entidad-relación, nos permite representar estos objetos de forma visual y ordenada, en el las entidades se representan con rectángulos, los atributos como elipses y las relaciones con líneas y rombos que grafican el tipo de relación.

#### Ejemplo 

Entidad: Alumno.<br>
Atributos: Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Ingreso, Carrera, ect.<br>
Relaciones: Un alumno “cursa” una cohorte.

Entidad: Cohorte.<br>
Atributos: Número, Fecha de Inicio, Carrera, ect.<br>
Relaciones: Una cohorte "pertene" a una carrera. Una cohorte "posee" alumnos.

Entidad: Carrera.<br>
Atributos: Nombre, Estado, ect.<br>
Relaciones: Una carrera "tiene" cohortes.

![Modelo E-R](../_src/assets/ER.PNG)
<br>
<br>
Hemos desarrollado los conceptos más importantes de este modelo, pero aún nos falta entender como se rigen las relaciones entre las entidades.<br>
Las relaciones aportan dos grandes características a una base datos, la no duplicidad y la integridad referencial. Se representan mediante dos elementos denominados "primary key" y "foreing key". Una primary key, es un atributo que representa de manera única e inequívoca a un elemento (registro) de la entidad, en el caso del alumno una primary key puede ser su N° de cédula de identidad o N° de Inscripción. Si se desea representar a ese mismo alumno en otra entidad como por ejemplo una cohorte, basta con incluir dentro de la tabla a la primary key como uno de sus campos, quedando representando ese alumno a través de su cédula de identidad/N° de Inscripción como una Foreing Key. Para resumir, una Foreing Key es generalemente una Primary Key en otra tabla.<br>
Las relaciones a su vez pueden ser 1-1 (uno-uno), 1-M (uno-muchos), N-M (muchos-muchos)lo que se denomina como cardinalidad. En nuestro ejemplo, un alumno de Henry solo puede cursar en una cohorte, por lo que tenemos una relación de 1-1; esta restricción es generalmente impuesta por el modelo de negocios. En otros modelos de negocios como el de los cursos On-Demand, un alumno podría hacer varios cursos a la vez por lo que la relación sería de 1-M (claro que en ese caso no tendrías la solidez y acompañamiento de Henry 😊).

![Relaciones1](../_src/assets/relaciones.png)

![Relaciones2](../_src/assets/pk-fk.png)

**Tipo de datos:**

Una base de datos puede guardar diferentes tipos de datos: caracteres, numéricos, fechas, texto, booleanos, decimales, etc. El nombre específico que se le da a un tipo de datos, varia en cada sistema de gestión de bases de datos. En SQL Server un dato true (1) o false(0) se denomina BIT, ese mismo tipo de dato en MySQL se denomina TINYINT. Al crear una tabla en una base de datos, es muy importante definir de manera adecuada que tipo de datos se guardará en cada campo.

[Tipos de datos en MySQL](https://dev.mysql.com/doc/refman/8.0/en/data-types.html)

[Tipos de datos en PostgreSQL](https://www.postgresql.org/docs/current/datatype.html)

[Tipos de datos en SQL Server](https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver15)

### Introducción a SQL 

SQL por sus siglas en inglés significa Lenguaje de Consulta Estructurada (Structured Query Language), es un lenguaje diseñado para interactuar con las bases de datos relacionales. SQL se subdivide a su vez entre distintos tipos de sublenguajes como DDL, DML, DCL  y TCL. Cada uno con sentencias características de esa subdivisión.

* DDL: Data Definition Language.
* DML: Data Manipulation Language. 
* DCL: Data Control Language.
* TCL: Transacition Control Language.
 
Todos los sistemas de gestión de bases de datos relacionales (RDMS) como MySQL, SQL Server, Oracle, o Postgres utilizan SQL como su lenguaje estándar. Suelen tener algunas pequeñas modificaciones entre herramientas por lo que se sugiere siempre verificar la documentación.

**Data Definition Laguage:**

Son sentencias que permiten definir la estructura de una base de datos, esta estructura esta compuesta por “objetos” (no confundir con POO en Python) que se desean gestionar. Los tipos de objetos que se pueden gestinar son: bases de datos, tablas, vistas o procedimientos. Las acciones que se pueden ejecutar son CREAR, MODIFICAR o ELIMINAR. <br>
CREATE permite crear objetos en la base de datos, incluyendo la base de datos en si misma. 

Crear base de datos
```SQL
CREATE DATABASE henry – Crear.
ALTER DATABASE henry – Modificar.
DROP DATABASE henry – Borrar.
```

Tablas
```SQL
CREATE TABLE alumno (
cedulaIdentidad INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(20),
apellido VARCHAR(20),
fechaInicio DATE,
PRIMARY KEY (cedulaIdentidad)
)


ALTER TABLE alumno (
direccion VARCHAR(20)
)

DROP TABLE alumno
```

Vistas
```SQL
CREATE VIEW datosAlumnos AS  
SELECT *
FROM alumnos

ALTER VIEW datosAlumnos

DROP VIEW datosAlumnos
```

Procedimientos
```SQL
CREATE PROCEDURE contarAlumnos (OUT param1 INT)
     BEGIN
       SELECT COUNT(*) INTO param1 FROM alumnos;
     END

ALTER PROCEDURE contarAlumnos (OUT param1 INT)
     BEGIN
       SELECT COUNT(*) INTO param1 FROM alumnos;
     END

DROP PROCEDURE contarAlumnos
```
### Introducción a bases de datos.

Es una colección de datos almacenados de forma coherente y permanente; los cuales se pueden manipular, visualizar, registrar, actualizar o eliminar. Normalmente, una base de datos está controlada por un sistema de gestión de bases de datos (DBMS). En conjunto, los datos y el DBMS, junto con las aplicaciones asociadas a ellos, reciben el nombre de sistema de bases de datos, abreviado normalmente a simplemente base de datos.

El principal objetivo de cualquier base de datos es almacenar información, pero existen otros objetivos relacionados que llevan a un desarrollados elegir una u otra.

Estos objetivos están relacionados con: capacidad de respuesta, volumen de datos a almacenar, integración con otras tecnologías, etc.

Las primeras bases de datos se basaron en el modelo relacional, evolucionando con el surgimiento de las redes sociales y otras aplicaciones a modelos no relacionales.

**BD On-Premise o Cloud:**<br>
Las bases de datos pueden estar alojadas de manera local (On-premise) o en la nube. También se pueden encontrar de forma “distribuida”.

Las bases de datos On-Premise, se denominan de esta manera debido a que los servidores se encuentran físicamente alojados en instalaciones pertenecientes a la organización. Esto implica que tanto el crecimiento en capacidad y mantenimiento, están a la cargo de la organización; lo que convierte en un costo significativo. En Argentina esto es muy común en bancos, debido a que la normativa les exige adoptar esta opción.

Cuando hablamos de bases de datos en la nube, se trata de servidores que pertenecen a terceros (AWS, Azure, GCP, etc.). En este caso tanto la capacidad como el mantenimiento esta a cargo de prestador, esto permite “pagar por lo que se usa” y escalar rápidamente. Instituciones como la CIA [utilizan el servicio de la nube privada de AWS.](https://wikileaks.org/amazon-atlas/)

En el entorno empresarial actual de rápido crecimiento, las empresas necesitan tener acceso en tiempo real a sus datos para poder tomar decisiones a tiempo y aprovechar las nuevas oportunidades. Por lo que las startups optan por escalar gracias a estos servicios.

Esto libera a los administradores de bases de datos de supervisar continuamente la base de datos por si surgen problemas y realizar un mantenimiento preventivo, así como aplicar parches y actualizaciones de software. 

**Bases de datos relaciones vs Bases de datos no relaciones:**

Los datos generalemente se suelen almacenar en estructuras de filas y columnas a través de una seria de tablas, esto permite para aumentar la eficacia del procesamiento y la consulta de datos. Así, se puede acceder, gestionar, modificar, actualizar, controlar y organizar fácilmente los datos. La mayoría de las bases de datos utilizan un lenguaje de consulta estructurada (SQL) para escribir y consultar datos. Estos tipos de bases de datos se denominan relacionales.

Durante décadas, el modelo de datos predominante utilizado para el desarrollo de aplicaciones era el modelo de datos relacional empleado por Oracle, DB2, SQL Server, MySQL, PostgreSQL, etc. No fue sino hasta mediados y finales de la década del 2000 que otros modelos de datos comenzaron a adoptarse y aumentó su uso significativamente. Para diferenciar y categorizar estas nuevas clases de bases de datos y modelos de datos, se acuñó el término "NoSQL". Con frecuencia, los términos "NoSQL" y "no relacional" se usan indistintamente.

El termino no relacional hace referencia a la no utilización del modelo relacional característico de las primeras bases de datos. Las bases de datos NoSQL pueden estar basadas en documentos, grafos, clave-valor u otras variantes. Algunas de las más conocidas son Cassandra, MongoDB, Firebase o DynamoDB.

¿Cómo funciona una base de datos NoSQL (no relacionales)? <br>

Estas bases de datos están optimizadas específicamente para aplicaciones que requieren grandes volúmenes de datos, baja latencia y modelos de datos flexibles, lo que se logra mediante la flexibilización de algunas de las restricciones de coherencia de datos en otras bases de datos.

[Consideremos el ejemplo de modelado del esquema para una base de datos simple de libros:](https://aws.amazon.com/es/nosql/) 

En una base de datos relacional, un registro de libros a menudo se enmascara (o "normaliza") y se almacena en tablas separadas, y las relaciones se definen mediante restricciones de claves primarias y externas. En este ejemplo, la tabla Libros tiene las columnas ISBN, Título del libro y Número de edición, la tabla Autores tiene las columnas IDAutor y Nombre de autor y, finalmente, la tabla Autor-ISBN tiene las columnas IDAutor e ISBN. El modelo relacional está diseñado para permitir que la base de datos aplique la integridad referencial entre tablas en la base de datos, normalizada para reducir la redundancia y, generalmente, está optimizada para el almacenamiento.

En una base de datos NoSQL, el registro de un libro generalmente se almacena como un documento JSON. Para cada libro, el elemento, ISBN, Título del libro, Número de edición, Nombre autor y IDAutor se almacenan como atributos en un solo documento. En este modelo, los datos están optimizados para un desarrollo intuitivo y escalabilidad horizontal.
Son BD orientadas y diseñadas para procesar consultas complejas. Además pueden correr grandes volúmenes de datos en un lapso menor de tiempo que las BD orientadas a transacciones.

**Bases de datos transaccionales vs Bases de datos analíticas:**

Las bases de datos de las grandes empresas de hoy en día soportan a menudo consultas muy complejas y se espera que proporcionen respuestas casi instantáneas a esas consultas. En consecuencia, se solicita a los administradores de bases de datos que empleen una amplia variedad de métodos para ayudar a mejorar el rendimiento. Algunos desafíos comunes a los que se enfrentan incluyen:
1. Absorción de aumentos significativos en el volumen de datos. La explosión de datos provenientes de sensores, máquinas conectadas y docenas de otras fuentes hace que los administradores de bases de datos tengan que luchar para administrar y organizar los datos de sus empresas’ de manera eficiente.

2. Garantía de seguridad de los datos. Actualmente, se producen filtraciones de datos en todas partes, y los piratas informáticos son cada vez más ingeniosos. Garantizar que los datos estén seguros es más importante que nunca, pero también que los usuarios puedan acceder a ellos fácilmente.

Este tipo de requisitos llevan a seleccionar otros tipos de bases de datos dependiendo de si el objetivo es soportar la persistencia de datos de las aplicaciones o servir de soporte analítico a la toma de decisiones.<br>
Lo anterior no implica que una base de datos transaccional no se puedan consultar con fines analíticos, pero claramente este no es su principal objetivo, ya que un crecimiento acelerado del volumen de datos entre otras cosas, podría afectar su rendimiento al realizar consultas analíticas complejas.

Para abordar este tipo de problemas, se crearon herramientas tales como Datamarts, Datawarehouse o Datalake. Que permiten un repositorio centralizado de datos orientados a la analítica. Estos conceptos han evolucionado en la actualidad para converger en el concepto como el de Datamesh. Más adelante en módulo 3, exploraremos en detalle cada uno.


## Rceursos adicionales

* [Modelo entidad-relación](https://www.youtube.com/watch?v=Vu5x95UTD80)

* [Relaciones](https://www.youtube.com/watch?v=TKuxYHb-Hvc&t=209s)

* [Cardinalidad](https://www.youtube.com/watch?v=f5ZB05OWNCM)

* [Claves](https://www.youtube.com/watch?v=jshi9VCTm7g)

* [DDL](https://www.youtube.com/watch?v=sx4QE7u5ahI)

* [SQL](https://www.youtube.com/watch?v=cWMCHbxMiMI)

* [DER - MySQL](https://www.youtube.com/watch?v=hfE0_Mme32k)

## Homework

Instalación MySQL y Wokrbench<br>
MySQL Server: [Download](https://dev.mysql.com/downloads/mysql/)<br>
MySQL Installer: [Download](https://dev.mysql.com/downloads/installer/)<br>
Workbench: [Download](https://dev.mysql.com/downloads/workbench/)<br>
MySQL: [Documentation](https://dev.mysql.com/doc/)

Crear un modelo relacional basado en el modelo de negocios de Henry:

1. Identificar las relaciones.
2. Identifcar primery key´s y foreing key´s.
3. Definir los tipos de datos.

La entidades a modelar junto sus atributos son: <br>
* Carrea: ID, Nombre.<br>
* Cohorte: ID, Código, Carrera, Fecha de Inicio, Fecha de Finalización, Instructor.<br>
* Instructores: ID, Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Incorporación.<br>
* Alumnos: ID, Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Ingreso, Cohorte.<br>

Crear en MySQL las tablas y relaciones del modelo definido.<br>
Foreing Key en MySQL: [Download](https://www.w3schools.com/sql/sql_foreignkey.asp)



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
