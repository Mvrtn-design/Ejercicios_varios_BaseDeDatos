CREATE TABLE grupo
(cod_grupo CHAR(3)PRIMARY KEY,
curso NUMBER(1) NOT NULL,
turno CHAR(1) DEFAULT 'M'
CONSTRAINT Mañana_o_Tarde CHECK(turno IN ('M','T')),
CHECK (curso > '0' AND curso < '4'));

CREATE TABLE alumno
(num_mat CHAR(3),
nombre VARCHAR2(20) UNIQUE,
ciudad CHAR(25) NOT NULL,
cod_grupo CHAR(3),
PRIMARY KEY (num_mat),
FOREIGN KEY (cod_grupo) REFERENCES grupo ON DELETE SET NULL);

--Alterar tabla 
ALTER TABLE ALUMNO ADD (precio INTEGER);--Añadir mas columnas a una tabla

--INSERTAR FILAS

INSERT INTO PERSONA VALUES (11111111, 'Juan', 'Madrid', 1500, 'informatico', 1960, 'SI');
INSERT INTO PERSONA (Nombre, DNI,Ciudad, Salario, Profesion, Anyo_nac)
        VALUES ( 'Maria', 22222222,'Barcelona', 1800, 'informatico', 1980);
INSERT INTO PERSONA VALUES (33333333, 'Pedro', 'Valencia', 1200, 'administrativo', 1940, 'SI');
INSERT INTO PERSONA VALUES (44444444, 'Isabel', 'Madrid', 1600, 'informatico', 1974, 'NO');
INSERT INTO PERSONA VALUES (55555555, 'Antonio', 'Barcelona', 1000, 'administrativo', 1935, 'SI');
INSERT INTO PERSONA VALUES (66666666, 'Ana', 'Madrid', 900, 'administrativo', NULL, 'NO');

--MODIFEICAR FILAS
UPDATE ALUMNO
SET cod_grupo= 'I22', precio = precio * 50
WHERE nombre > 'Ramiro'; --mayor en el orden alfabetico

--Modificar Columnas
SELECT nombre, precio*0.5 MitadPrecio, 2 FROM alumno;--te saca precio pero ya multipicasdo y la llama mitadPrecio, luego 7 lo pone en el nombre de columna y en todas las filas

--ELLIMINAR FILAS
DELETE FROM GRUPO WHERE curso = '1';

--CONSULTAS
SELECT * FROM GRUPO; --todos los vlores de la tabla
SELECT * FROM ALUMNO;
SELECT nombre,ciudad FROM ALUMNO;
SELECT DISTINCT ciudad FROM alumno; --quita las filas repetidas
SELECT * FROM ALUMNO ORDER BY ciudad,nombre DESC; --la misma tabla ordenada alfabeticamente por ciudad, en caaso de empate , ordena por nombre, y en orden descendente
DESC ALUMNO;--TIPO DE VARIABLES Y SI SON NULOS O NO
DESCRIBE GRUPO; 
SELECT nombre, precio*0.5 MitadPrecio, 2 FROM alumno;--te saca precio pero ya multipicasdo y la llama mitadPrecio, luego 7 lo pone en el nombre de columna y en todas las filas
SELECT ciudad FROM alumno WHERE precio BETWEEN 220 AND 100000; --Mostrar los valores entre X rangos
SELECT NOMBRE FROM alumno WHERE cod_grupo IS NULL; --selecciona las filas en las que no haya nada
SELECT * FROM alumno WHERE ciudad LIKE '__d%';--muestra las ciudades donde la tercera letra sea una d y que despues haya lo que sea
SELECT * FROM alumno WHERE ciudad not IN ('Leganes','Madrid');
SELECT MAX (precio) FROM alumno GROUP BY nombre;
SELECT AVG (precio) FROM alumno; -- la media de valores
SELECT COUNT (cod_grupo) FROM alumno; --numero de elementos en esa columna
SELECT * FROM alumno,grupo; --producto cartesiano
SELECT * FROM alumno CROSS JOIN grupo; -- hace lo mismo

SELECT * FROM alumno A WHERE precio < ALL 
    (SELECT precio FROM alumno AA WHERE A.num_mat <> AA.num_mat);--me saca el alumno cuyo precio sea menor que los de la misma tabla que sean diferente de él, es decir me saca al de menor precio

-- Borrar tablas antes de volver a crearlas
DROP TABLE grupo;
DROP TABLE alumno;


--- EJERCICIOS (el dominio no funciona en ORACLE)
-- 2º
CREATE TABLE persona (
DNI NUMBER (10) PRIMARY KEY,
nombre VARCHAR2 (20) NOT NULL CONSTRAINT UNIC_NAME UNIQUE,
ciudad VARCHAR2 (20) NOT NULL,
salario NUMBER (8,2) NOT NULL, --8 es el total, 2 de ellos son decimales
profesion VARCHAR2 (20) NOT NULL,
anyo_nac NUMBER (4),
jubilado CHAR (2) DEFAULT 'NO' CONSTRAINT S_N_JUBI CHECK (jubilado IN ('SI','NO'))
);
-- 3º lAS FILAS ESTAN ARRIBA EN INSERTAR FILAS

SELECT * FROM persona;

-- 4º INCREMENTAR UN 5% A LOS INFORMATICOS
UPDATE persona SET salario = salario + salario* 0.05 WHERE profesion = 'informatico';
SELECT SALARIO FROM PERSONA;

-- 5º Decrementar en un 2% el salario de los que viven en Madrid.
UPDATE PERSONA SET salario = salario - salario * 0.02 WHERE ciudad = 'Madrid';

SELECT SALARIO FROM PERSONA;
-- 6º. Modificar el nombre de la persona con DNI=55555555 por ‘Juan Antonio’.

UPDATE PERSONA SET NOMBRE = 'Juan Antonio' WHERE DNI = '55555555';

-- 7º. Todos los jubilados pasan a ganar 100 Euros más.
UPDATE PERSONA SET SALARIO = SALARIO + 100 WHERE jubilado = 'SI';
-- 8º. Borrar todas las personas de Valencia que hayan nacido antes de 1950
DELETE FROM PERSONA WHERE ciudad = 'Valencia' AND anyo_nac < 1950;
-- 9º. Obtener todos los campos de todas las personas ordenadas descendentemente por nombre
SELECT * FROM PERSONA ORDER BY nombre DESC;
-- 10º.Obtener el nombre y el salario de los informáticos ordenado por ciudad.
SELECT nombre,SALARIO FROM PERSONA WHERE UPPER (PROFESION) = 'INFORMATICO' ORDER BY ciudad;
-- 11º. Cree una vista "" usando la consulta anterior e intente insertar un dato en la vista.
CREATE VIEW Empleados_Inf AS SELECT nombre,SALARIO FROM PERSONA WHERE UPPER (PROFESION) = 'INFORMATICO' ORDER BY ciudad;
SELECT * FROM empleados_inf;

-- 12º. Añada una nueva columna obligatoria, correo_e, que almacene el correo electrónico. Si devuelve error, pruebe a crearla con un valor por defecto.

ALTER TABLE persona ADD correo_e CHAR(20) DEFAULT 'SIN CORREO' NOT NULL;
SELECT * FROM PERSONA;
UPDATE persona SET correo_e = NULL WHERE correo_e = 'TRABO@GMAIL.COM';
-- 13º. Obtener el sueldo medio por profesiones (profesión, sueldo medio).
SELECT profesion, AVG (salario) FROM persona GROUP BY profesion;
-- 14º.Obtener el sueldo medio por profesiones de las personas de Madrid.
SELECT profesion, AVG (SALARIO) FROM PERSONA WHERE UPPER (ciudad) = 'MADRID' GROUP BY profesion;
-- 15º. Obtener el sueldo medio por profesiones de las personas de Madrid siempre que dicho sueldo medio supere los 1000 euros y ordenado por profesión
SELECT profesion, AVG (SALARIO) FROM PERSONA WHERE UPPER (CIUDAD) = 'MADRID' AND SALARIO > 1000 AND dni > 100 GROUP BY profesion;
-- PONGO UN ADMINISTRATIVO QUE GANE 1500.(lo habia cre
INSERT INTO persona VALUES (77777777,'Matías','Madrid',1760,'administrador','NO');
UPDATE persona SET anyo_nac = 1946 WHERE nombre = 'Matías';

---Ejercicio 2 (TODAS TIENEN CLAVES AJENAS ASI QUE LA PRIMERA LA HERAMOS SIN PONERLA)

CREATE TABLE DEPARTAMENTO(
Numero_D    NUMBER(10) PRIMARY KEY,
Nombre_D    VARCHAR2 (20),
NSSE        NUMBER(20)
);

CREATE TABLE PROYECTO (
Cod_P       NUMBER(10) PRIMARY KEY,
Nombre_P    VARCHAR2 (20),
Lugar_P     VARCHAR2 (20),
Num_Dep     NUMBER(2),
CONSTRAINT FK_proy_dep
FOREIGN KEY (Num_Dep) REFERENCES DEPARTAMENTO (Numero_D));

CREATE TABLE EMPLEADO (
NSS             CHAR(20) PRIMARY KEY,
Nombre          VARCHAR2(10),
Apellidos       VARCHAR2(20),
NSS_Supervisor  NUMBER(20),
Fecha_Nac       DATE,
Direccion       VARCHAR2(20),
Sexo            CHAR(1) CONSTRAINT SEX CHECK (sexo IN ('M' , 'F')),
Num_Dep         NUMBER (10),
Salario         NUMBER (8,2),
FOREIGN KEY (NSS_Supervisor)REFERENCES EMPLEADO (NSS),
FOREIGN KEY (Num_Dep) REFERENCES DEPARTAMENTO (Numero_D));
ALTER TABLE EMPLEADO ADD (Ciudad VARCHAR2(20));
ALTER TABLE EMPLEADO ADD Sexo CHAR(1) CONSTRAINT SEX CHECK (sexo IN ('H' , 'M'));

CREATE TABLE FAMILIAR (
NSSE        NUMBER (10),
Nombre      VARCHAR2 (20),
CONSTRAINT DOS_PRIM PRIMARY KEY (NSSE,Nombre),
Sexo        CHAR(1) CONSTRAINT SEX2 CHECK (sexo IN ('M' , 'F')),
Parentesco  VARCHAR (20),
FOREIGN KEY (NSSE) REFERENCES EMPLEADO (NSS));

CREATE TABLE TRABAJA_EN (
NSS_E       NUMBER(20),
Cod_Proy    NUMBER (10),
CONSTRAINT DOS_PRIM_2 PRIMARY KEY (NSS_E,Cod_Proy),
Horas       NUMBER (3),
FOREIGN KEY (NSS_E) REFERENCES EMPLEADO (NSS),
FOREIGN KEY (Cod_Proy) REFERENCES PROYECTO (Cod_P));



--mETER DATOS
DELETE FROM EMPLEADO;

UPDATE EMPLEADO SET SEXO = 'H'  WHERE Nombre = 'Juan';

INSERT INTO EMPLEADO (NSS,Nombre,Apellidos,Fecha_Nac,Direccion,Sexo,Salario) VALUES (28123456,'Juan','Alvarez Xovio',to_date('23/03/1978','DD/MM/YYYY'),'calle de las flores','H',1300);

INSERT INTO EMPLEADO (NSS, Nombre, Apellidos, NSS_Supervisor, Fecha_Nac,
       Direccion, Ciudad, Sexo, Salario) VALUES ('28342139',
       'MARÍA','Silvano','28123456',to_date('12/12/1975','DD/MM/YYYY'),'Calle del Pez','Móstoles', 'M',850);
INSERT INTO EMPLEADO (NSS, Nombre, Apellidos, NSS_Supervisor, Fecha_Nac,
       Direccion, Ciudad, Sexo, Salario) VALUES ('28999999',
       'RAÚL','RUEDA ROMERO','28123456',to_date('23/07/1968','DD/MM/YYYY'),'Calle Echegaray','Móstoles','H',1500);
INSERT INTO EMPLEADO (NSS, Nombre, Apellidos, NSS_Supervisor, Fecha_Nac,
       Direccion, Ciudad, Sexo, Salario) VALUES ('28000001',
       'VERÓNICA','VIERA VÁZQUEZ','28342139',to_date('18/03/1980','DD/MM/YYYY'),'Plaza de España','Moriles','M',700);
INSERT INTO EMPLEADO (NSS, Nombre, Apellidos, NSS_Supervisor, Fecha_Nac,
       Direccion, Ciudad, Sexo, Salario) VALUES ('28000010',
       'LUIS','VIERA VIERA','28000001',to_date('19/07/1970','DD/MM/YYYY'),'Plaza del Rey','Madrid','H',3050);
INSERT INTO EMPLEADO (NSS, Nombre, Apellidos, NSS_Supervisor, Fecha_Nac,
       Direccion, Ciudad, Sexo, Salario) VALUES ('28000020',
       'ANTONIO','VÁZQUEZ VIERA','28000010',to_date('12/06/1967','DD/MM/YYYY'),'Calle Europa','Barcelona','H',3100);
INSERT INTO EMPLEADO (NSS, Nombre, Apellidos, NSS_Supervisor, Fecha_Nac,
       Direccion, Ciudad, Sexo, Salario) VALUES ('28000030',
       'JESÚS','VIERA LÓPEZ','28000010',to_date('11/12/1956','DD/MM/YYYY'),'Avenida España','Valencia','H',2500);
INSERT INTO EMPLEADO (NSS, Nombre, Apellidos, NSS_Supervisor, Fecha_Nac,
       Direccion, Ciudad, Sexo, Salario) VALUES ('28000040',
       'MARIA','VIERA JIMÉNEZ','28000010',to_date('28/10/1981','DD/MM/YYYY'),'Plaza Constitución','Sevilla','M',3100);
INSERT INTO EMPLEADO (NSS, Nombre, Apellidos, NSS_Supervisor, Fecha_Nac,
       Direccion, Ciudad, Sexo, Salario) VALUES ('28000050',
       'ANA','VIERA GARCÍA','28000010',to_date('23/04/1989','DD/MM/YYYY'),'Calle Mayor','Bilbao','M',3100);

-- TABLA DEPARTAMENTO
INSERT INTO DEPARTAMENTO (Numero_D, Nombre_D, NSS_Gerente) VALUES
(5, 'Investigación', '28123456');
INSERT INTO DEPARTAMENTO (Numero_D, Nombre_D, NSS_Gerente) VALUES
(2, 'Análisis', '28123456');
INSERT INTO DEPARTAMENTO (Numero_D, Nombre_D, NSS_Gerente) VALUES
(1, 'Dirección', '28342139');

-- Actualizo los departamentos a los que pertenecen los empleados
UPDATE EMPLEADO
SET Num_Dep= 1 WHERE NSS='28123456';
UPDATE EMPLEADO
SET Num_Dep= 5 WHERE NSS='28342139';
UPDATE EMPLEADO
SET Num_Dep= 5 WHERE NSS='28999999';
UPDATE EMPLEADO
SET Num_Dep= 2 WHERE NSS='28000001';
UPDATE EMPLEADO
SET Num_Dep= 1 WHERE NSS='28000010';
UPDATE EMPLEADO
SET Num_Dep= 1 WHERE NSS='28000020';
UPDATE EMPLEADO
SET Num_Dep= 1 WHERE NSS='28000030';
UPDATE EMPLEADO
SET Num_Dep= 1 WHERE NSS='28000040';
UPDATE EMPLEADO
SET Num_Dep= 1 WHERE NSS='28000050';


-- TABLA PROYECTO
INSERT INTO PROYECTO (Cod_P, Nombre_P, Lugar_P, Num_Dep) VALUES( '123456789', 'WEB
Ayuntamiento', 'MADRID',5);
INSERT INTO PROYECTO (Cod_P, Nombre_P, Lugar_P, Num_Dep) VALUES( '123000000', 'WEB
Ministerio', 'MADRID',5);
INSERT INTO PROYECTO (Cod_P, Nombre_P, Lugar_P, Num_Dep) VALUES( '999999999', 'ERP
VIPS', 'MADRID',2);
INSERT INTO PROYECTO (Cod_P, Nombre_P, Lugar_P, Num_Dep) VALUES( '777777777',
'PRESUPUESTO HOTEL SA', 'BARCELONA',1);
-- TABLA FAMILIAR
INSERT INTO FAMILIAR(NSSE, Nombre, Sexo, Parentesco) VALUES
('28123456', 'JUAN', 'H', 'HIJO');
INSERT INTO FAMILIAR(NSSE, Nombre, Sexo, Parentesco) VALUES
('28123456', 'JUANITA', 'M', 'HIJA');
INSERT INTO FAMILIAR(NSSE, Nombre, Sexo, Parentesco) VALUES
('28123456', 'JUANA', 'M', 'MUJER');
-- TABLA TRABAJA_EN
INSERT INTO TRABAJA_EN (NSS_E, Cod_Proy, Horas) VALUES
('28123456', '123456789',100);
INSERT INTO TRABAJA_EN (NSS_E, Cod_Proy, Horas) VALUES
('28342139', '123456789',100);
INSERT INTO TRABAJA_EN (NSS_E, Cod_Proy, Horas) VALUES
('28342139', '123000000',100);
INSERT INTO TRABAJA_EN (NSS_E, Cod_Proy, Horas) VALUES
('28342139', '999999999',150);
INSERT INTO TRABAJA_EN (NSS_E, Cod_Proy, Horas) VALUES
('28999999', '123456789',300);
INSERT INTO TRABAJA_EN (NSS_E, Cod_Proy, Horas) VALUES
('28999999', '999999999',350);
INSERT INTO TRABAJA_EN (NSS_E, Cod_Proy, Horas) VALUES
('28000001', '777777777',200);



-- 1.Obtener todas las combinaciones de empleados y departamentos.
SELECT * FROM EMPLEADO CROSS JOIN DEPARTAMENTO;

-- 2.Obtener todas las combinaciones de NSS de empleados y nombres de departamento.
SELECT  EMPLEADO.NSS,Nombre_D FROM EMPLEADO,DEPARTAMENTO;

-- 3.Seleccionar el salario de cada uno de los empleados.
SELECT salario FROM EMPLEADO;

-- 4.Seleccionar los distintos salarios que cobran los empleados.
SELECT DISTINCT Salario FROM EMPLEADO;

-- 5.Obtener todos los empleados del departamento 5.
SELECT * FROM EMPLEADO WHERE Num_Dep = 5;

-- 6.Seleccionar los empleados del departamento de ‘Investigación’ y la información de este departamento.
SELECT * FROM EMPLEADO join DEPARTAMENTO ON Num_Dep = Numero_D WHERE DEPARTAMENTO.NOMBRE_D = 'Investigación';

-- 7.Nombre y apellidos de los empleados de Móstoles.
SELECT NOMBRE,APELLIDOS FROM EMPLEADO WHERE CIUDAD = 'Móstoles';

-- 8.Nombre y apellidos de los empleados que vivan en una ciudad que empiece por ‘M’ y termine por ‘les’.
SELECT NOMBRE,APELLIDOS,CIUDAD FROM EMPLEADO WHERE CIUDAD LIKE 'M%les';

-- 9.Nombre del departamento, nombre y apellidos de los empleados ordenados descendentemente por nombre de departamento y ascendentemente por apellidos
SELECT Nombre_D , NOMBRE,APELLIDOS FROM EMPLEADO JOIN DEPARTAMENTO ON Num_Dep = Numero_D ORDER BY NOMBRE_D DESC, APELLIDOS ASC;

-- 10.NSS de los empleados del departamento 1, 2 o 3.
SELECT NSS FROM EMPLEADO WHERE Num_Dep = 1 or Num_Dep = 2 or Num_Dep = 3 ;

-- 11.Nombre y apellidos de los empleados que tengan un salario desconocido.
SELECT NOMBRE,APELLIDOS FROM EMPLEADO WHERE SALARIO = NULL;

-- 12.Nombre y apellidos de los empleados junto con el nombre y apellidos de su supervisor.
SELECT EMP.NOMBRE,EMP.APELLIDOS,SUPER.NOMBRE ,SUPER.APELLIDOS FROM EMPLEADO EMP, EMPLEADO SUPER WHERE EMP.NSS_Supervisor = SUPER.NSS;

-- 13.Obtener el total de los salarios, el salario máximo, el salario mínimo y la media del salario de todos los empleados.
SELECT SUM(salario),MAX (salario), MIN (salario) ,AVG (salario) FROM EMPLEADO;

-- 14.Obtener el total de los salarios, el salario máximo, el salario mínimo y la media del salario de los empleados del departamento de ‘Investigación’.
SELECT SUM(salario),MAX (salario), MIN (salario) ,AVG (salario) FROM EMPLEADO JOIN DEPARTAMENTO ON Num_Dep = Numero_D WHERE Nombre_D = 'Investigación' ;

-- 15.Número de empleados que tiene el departamento de ‘Investigación’.
SELECT COUNT (*) Todos_los_empleados FROM EMPLEADO JOIN DEPARTAMENTO ON Num_Dep = Numero_D WHERE Nombre_D = 'Investigación';

-- 16.Número de salarios diferentes en la empresa.
SELECT DISTINCT salario FROM EMPLEADO;

-- 17. Seleccionar los NSS de los empleados que trabajan en el mismo proyecto y con las mismas horas de trabajo que el empleado con NSS=‘28342139’.
SELECT NSS_E FROM TRABAJA_EN WHERE (Horas, Cod_Proy) IN (SELECT Horas,Cod_Proy FROM TRABAJA_EN WHERE NSS_E =  28342139);

-- 18.NSS, nombre y apellidos de los empleados que no tienen familiares dependientes de él.
SELECT NOMBRE,APELLIDOS FROM EMPLEADO WHERE NSS NOT IN (SELECT NSSE FROM FAMILIAR);

-- 19.Nombre y apellidos de los empleados que tengan 2 o más familiares a su cargo.
SELECT NOMBRE,APELLIDOS FROM EMPLEADO WHERE NSS IN (SELECT NSSE FROM FAMILIAR GROUP BY NSSE HAVING COUNT (*) <= 2);

-- 20.Por cada departamento que tenga más de 5 empleados, obtener el nombre de departamento y el número de empleados que ganan más de 3000 euros.
SELECT Nombre_D, COUNT(*) FROM EMPLEADO JOIN DEPARTAMENTO ON Num_Dep = Numero_D WHERE salario > 3000 AND Num_Dep IN (SELECT Num_Dep FROM DEPARTAMENTO GROUP BY Num_Dep HAVING COUNT (*) >= 5 );

-- 21.Nombre y apellidos de los empleados que tengan un salario mayor que cualquiera de los Nombre y apellidos de los empleados que tengan un salario mayor que cualquiera de los empleados del departamento 5.empleados del departamento 5.
SELECT NOMBRE, APELLIDOS FROM EMPLEADO WHERE Salario >  (SELECT MAX (SALARIO) FROM EMPLEADO WHERE Num_Dep = 5);
