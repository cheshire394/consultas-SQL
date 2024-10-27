
--HOJA 5: FUNCIONES ARITMETICAS

--Tablas Depart y Emple

CREATE TABLE DEPART (
 DEPT_NO  NUMBER(2) PRIMARY KEY,
 DNOMBRE  VARCHAR2(14), 
 LOC      VARCHAR2(14) ) ;
 
INSERT INTO DEPART VALUES (10,'CONTABILIDAD','SEVILLA');
INSERT INTO DEPART VALUES (20,'INVESTIGACION','MADRID');
INSERT INTO DEPART VALUES (30,'VENTAS','BARCELONA');
INSERT INTO DEPART VALUES (40,'PRODUCCION','BILBAO');
COMMIT;
 
 
REM ******** TABLA EMPLE: *************
 
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
 
DROP TABLE EMPLE cascade constraints; 
 
CREATE TABLE EMPLE (
 EMP_NO    NUMBER(4) PRIMARY KEY,
 APELLIDO  VARCHAR2(10)  ,
 OFICIO    VARCHAR2(10)  ,
 DIR       NUMBER(4) ,
 FECHA_ALT DATE      ,
 SALARIO   NUMBER(7),
 COMISION  NUMBER(7),
 DEPT_NO   NUMBER(2) NOT NULL,
 FOREIGN KEY (DEPT_NO) REFERENCES DEPART(DEPT_NO)) ;
 
INSERT INTO EMPLE VALUES (7369,'SANCHEZ','EMPLEADO',7902,'17/12/2005',
                        1040,NULL,20);
INSERT INTO EMPLE VALUES (7499,'ARROYO','VENDEDOR',7698,'20/02/2007',
                        1500,390,30);
INSERT INTO EMPLE VALUES (7521,'SALA','VENDEDOR',7698,'22/02/2008',
                        1625,650,30);
INSERT INTO EMPLE VALUES (7566,'JIMENEZ','DIRECTOR',7839,'02/04/2008',
                        2900,NULL,20);
INSERT INTO EMPLE VALUES (7654,'MARTIN','VENDEDOR',7698,'29/09/2008',
                        1600,1020,30);
INSERT INTO EMPLE VALUES (7698,'NEGRO','DIRECTOR',7839,'01/05/2008',
                        3005,NULL,30);
INSERT INTO EMPLE VALUES (7782,'CEREZO','DIRECTOR',7839,'09/06/2005',
                        2885,NULL,10);
INSERT INTO EMPLE VALUES (7788,'GIL','ANALISTA',7566,'09/11/2007',
                        3000,NULL,20);
INSERT INTO EMPLE VALUES (7839,'REY','PRESIDENTE',NULL,'17/11/2007',
                        4100,NULL,10);
INSERT INTO EMPLE VALUES (7844,'TOVAR','VENDEDOR',7698,'08/09/2007',
                        1350,0,30);
INSERT INTO EMPLE VALUES (7876,'ALONSO','EMPLEADO',7788,'23/09/2008',
                        1430,NULL,20);
INSERT INTO EMPLE VALUES (7900,'JIMENO','EMPLEADO',7698,'03/12/2008',
                        1335,NULL,30);
INSERT INTO EMPLE VALUES (7902,'FERNANDEZ','ANALISTA',7566,'03/12/2007',
                        3000,NULL,20);
INSERT INTO EMPLE VALUES (7934,'MUNNOZ','EMPLEADO',7782,'23/01/2009',
                        1690,NULL,10);
 
COMMIT;
--1. A partir de la tabla EMPLE, visualizar cuántos apellidos de los empleados empiezan con la letra A

SELECT COUNT (APELLIDO)
FROM EMPLE
WHERE UPPER(APELLIDO) LIKE 'A%';

--2. Dada la tabla EMPLE, obtener el sueldo medio, el número de comisiones no nulas,
--el máximo sueldo y el mínimo sueldo de los empleados del departamento 30.

SELECT ROUND(AVG(SALARIO), 2) AS PROMEDIO_SALARIO, MAX(SALARIO) AS SALARIO_MAX, MIN(SALARIO) AS SALARIO_MIN,
-- OJO ES WHEN, NO WHERE, FILTRACION SOLO PARA ESTE SELECT 
COUNT (CASE WHEN COMISION IS NOT NULL THEN 1 END) --OTRA FORMA COUNT(*) - COUNT(COMISION) SI QUIERE LOS NULL
--ESTO NO ES NECESARIO PORQUE COUNT CUENTA NOT NULL SIEMPRE, LOS NULL NO LOS CUENTA
FROM EMPLE
WHERE DEPT_NO = 30 ;

SELECT ROUND(AVG(SALARIO),2) AS PROMEDIO, MAX(SALARIO
--NO COMPILA
--3. Contar cuantos empleados y cuantos oficios distintos hay en el departamento de VENTAS.
SELECT COUNT(DISTINCT EMP_NO), COUNT(DISTINCT OFICIO)
FROM EMPLE
WHERE DEPT_NO = (SELECT DEPT_NO FROM EMPLE WHERE OFICIO = ('VENDEDOR'));


--4. Mostrar el apellido del empleado con mejor salario de la empresa sin tener en cuenta al presidente.

SELECT APELLIDO
FROM EMPLE
WHERE SALARIO = (SELECT MAX(SALARIO) FROM EMPLE WHERE UPPER(OFICIO) <>  'PRESIDENTE');

--5. Mostrar los datos del empleado con mejor salario de los que tienen por oficio EMPLEADO.

SELECT *
FROM EMPLE
WHERE SALARIO = (SELECT MAX(SALARIO) FROM EMPLE WHERE UPPER (OFICIO) = 'EMPLEADO');

--6. Mostrar el apellido de los empleados que ganan más del salario medio de la empresa.

SELECT APELLIDO
FROM EMPLE
WHERE SALARIO > (SELECT AVG(SALARIO) FROM EMPLE);

--7. Mostrar el salario incrementado en 3.21% y redondeado a un decimal.

SELECT ROUND(SALARIO * 1.0321, 1)AS INCREMENTO, SALARIO --PUEDES PONER ROUND(SALARIO+(SALARIO * 3.21/100)),1)
FROM EMPLE;




--Tablas Alumnos, Asignaturas, Notas
--TABLA ALUMNOS, NOTAS Y ASIGNATURAS



REM ******** TABLAS ALUMNOS, ASIGNATURAS, NOTAS: ***********
 
DROP TABLE ALUMNOS cascade constraints;
 
CREATE TABLE ALUMNOS
(
  DNI VARCHAR2(10) PRIMARY KEY,
  APENOM VARCHAR2(30),
  DIREC VARCHAR2(30),
  POBLA  VARCHAR2(15),
  TELEF  VARCHAR2(10)  
) ;
 
DROP TABLE ASIGNATURAS cascade constraints;
 
CREATE TABLE ASIGNATURAS
(
  COD NUMBER(2) PRIMARY KEY,
  NOMBRE VARCHAR2(25)
) ;
 
DROP TABLE NOTAS cascade constraints;
 
CREATE TABLE NOTAS
(
  DNI VARCHAR2(10) NOT NULL,
  COD NUMBER(2) NOT NULL,
  NOTA NUMBER(2),
  PRIMARY KEY(DNI,COD),
  FOREIGN KEY (DNI) REFERENCES ALUMNOS(DNI),
  FOREIGN KEY (COD) REFERENCES ASIGNATURAS(COD)
) ;
 
INSERT INTO ASIGNATURAS VALUES (1,'Programacion');
INSERT INTO ASIGNATURAS VALUES (2,'BBDD');
INSERT INTO ASIGNATURAS VALUES (3,'Marcas');
INSERT INTO ASIGNATURAS VALUES (4,'Sistemas');
 
 
 
INSERT INTO ALUMNOS VALUES
('12344345','Alcalde Garcia, Elena', 'C/Las Matas, 24','Madrid','917766545');
 
INSERT INTO ALUMNOS VALUES
('4448242','Cerrato Vela, Luis', 'C/Mina 28 - 3A', 'Madrid','916566545');
 
INSERT INTO ALUMNOS VALUES
('56882942','Diaz Fernandez, Maria', 'C/Luis Vives 25', 'Mostoles','915577545');
 
INSERT INTO ALUMNOS VALUES
('2112212','Sanz Martin, Roberto', 'C/Espronceda 89', 'Madrid','914431211');
 
INSERT INTO NOTAS VALUES('12344345', 1,6);
INSERT INTO NOTAS VALUES('12344345', 2,5);
INSERT INTO NOTAS VALUES('12344345', 3,6);
INSERT INTO NOTAS VALUES('12344345', 4,6);
 
INSERT INTO NOTAS VALUES('4448242', 1,6);
INSERT INTO NOTAS VALUES('4448242', 2,8);
INSERT INTO NOTAS VALUES('4448242', 3,4);
INSERT INTO NOTAS VALUES('4448242', 4,5);
 
INSERT INTO NOTAS VALUES('56882942', 1,8);
INSERT INTO NOTAS VALUES('56882942', 2,7);
INSERT INTO NOTAS VALUES('56882942', 3,8);
INSERT INTO NOTAS VALUES('56882942', 4,9);
 
INSERT INTO NOTAS VALUES('2112212', 1,3);
INSERT INTO NOTAS VALUES('2112212', 2,3);
INSERT INTO NOTAS VALUES('2112212', 3,2);
INSERT INTO NOTAS VALUES('2112212', 4,6);
COMMIT;
 
REM ******** FIN ***********************


--8. Hallar la nota media que ha obtenido la alumna llamada Elena redondeándola a un único decimal.
SELECT ROUND(AVG(NOTA),1)
FROM ALUMNOS AL
JOIN NOTAS N ON N.DNI = AL.DNI
JOIN ASIGNATURAS ASI ON ASI.COD = N.COD
WHERE UPPER(APENOM) LIKE ('%ELENA%');


--9. Hallar la peor nota entre las notas aprobadas por alumnos de Madrid.

SELECT MIN(NOTA) AS PEOR_NOTA
FROM NOTAS N
JOIN ALUMNOS AL ON AL.DNI = N.DNI
WHERE N.NOTA >= 5 AND UPPER(AL.POBLA) = ('MADRID');
            
            
--10. Mostrar el nombre del alumno que peor nota ha sacado en BBDD
--retorna varios resultados y deberia retornar solo uno
SELECT AL.APENOM
FROM ALUMNOS AL
JOIN NOTAS N ON AL.DNI = N.DNI
JOIN ASIGNATURAS ASI ON ASI.COD = N.COD
WHERE NOTA = (SELECT MIN(NOTA)
		FROM NOTAS JOIN ASIGNATURAS ASI ON ASI.COD = NOTAS.COD
		WHERE UPPER(ASI.NOMBRE) IN ('BBDD'));


--11. Mostrar cuantas notas distintas se han sacado en la asignatura de Marcas

SELECT DISTINCT N.NOTA
FROM NOTAS N
JOIN ASIGNATURAS ASI ON ASI.COD = N.COD
WHERE UPPER(ASI.NOMBRE) IN ('MARCAS');

--TABLAS PARQUE DE ATRACCIONES

--************* TABLAS ATRACCIONES***********************************************************************
            

drop table averias_parque ;
drop table atracciones ;
drop table zonas ;
drop table emple_parque ;
 
 
 
 create table emple_parque
 (dni_emple varchar2(9) primary key,
 Nom_Empleado varchar2(30) NOT NULL,
 Alta_empresa date  not null );
   
insert into emple_parque values
('6664321M','Ignacio Penna','12/10/2008');
insert into emple_parque values
('3455344J','Luis Perez','10/05/2008');
insert into emple_parque values
('23552335I','Alvaro Marton','19/05/2009');
insert into emple_parque values
('11111111I','Ana Gil','19/05/2009');
insert into emple_parque values
('33333333I','Chus Sabio','10/05/2008');
 
 
create table ZONAS
(Nom_Zona varchar2(30) primary key,
 Dni_Encargado varchar2(9) references emple_parque(dni_emple),
 Presupuesto number(10,2));
 
insert into Zonas values
('Infantil','3455344J',40000);
insert into Zonas values
('Agua','33333333I',50000);
insert into Zonas values
('Gran Maquinaria','33333333I',12006);
insert into Zonas values
('Familiares','3455344J',21000);
 
 
 
 create table atracciones
 (Cod_Atraccion char(4) primary key,  
  Nom_Atraccion varchar2(30) ,
  Fec_Inauguracion date,
  Capacidad number ,
  Nom_Zona varchar2(30) references zonas);
 
insert into atracciones values
('A100','Los Vikingos','01/05/2006',90,'Infantil');
insert into atracciones values
('A110','Lejano Oeste','01/09/2006',80,'Infantil');
insert into atracciones values
('A120','Tio Vivo','01/05/2006',120,'Infantil');
insert into atracciones values
('A130','La Peque Montana','01/09/2006',60,'Infantil');
insert into atracciones values
('B100','Los Rapidos','01/05/2006',40,'Agua');
insert into atracciones values
('B110','Cataratas Locas','01/09/2006',40,'Agua');
insert into atracciones values
('C100','Dragon Chiflado','01/05/2007',100, 'Gran Maquinaria');
insert into atracciones values
('C110','Enterprise', '01/09/2007',90,'Gran Maquinaria');
insert into atracciones values
('C120','Los 7 Picos','01/05/2007', 110,'Gran Maquinaria');
insert into atracciones values
('C130','Montanna Rusa','01/05/2006',80, 'Gran Maquinaria');
insert into atracciones values
('C200','La Noria', '01/05/2006',40,'Familiares');
insert into atracciones values
('C210','El Ferrocarril', '01/05/2006',60,'Familiares');
insert into atracciones values
('C220','Tunel Terrorifico', '01/05/2006',70,'Familiares');
 
 
 create table averias_parque
 (Cod_Atraccion char(4),
 Fecha_Falla date,
 Fecha_Arreglo date,
 Coste_Averia number(10,2),
 dni_emple varchar2(9) references emple_parque,
 primary key(Cod_atraccion,fecha_falla),
 foreign key (Cod_atraccion) references atracciones);
 
alter session set nls_date_format = 'dd/mm/yyyy hh24:mi';
insert into averias_parque values
('A100','10/07/2013 16:30','17/09/2013 17:45',300,'6664321M');
insert into averias_parque values
('A120','17/12/2013 18:30','22/02/2014 10:30',1600,'3455344J');
insert into averias_parque values
('B110','15/08/2013 18:30','16/08/2013 18:30',9000,'3455344J');
insert into averias_parque values
('B110','10/07/2014 16:30','18/07/2014 12:00',300,'6664321M');
insert into averias_parque values
('A110','15/06/2014 16:35','17/06/2014 12:45',5000,'6664321M');
insert into averias_parque values
('C120','12/03/2014 13:30','16/03/2014 11:30',7000,'3455344J');
insert into averias_parque values
('A100','15/05/2014 13:30','15/05/2014 13:30',400,'33333333I');
insert into averias_parque values
('C100','15/08/2014 13:30',null,null,'33333333I');
insert into averias_parque values
('B110','03/09/2014 18:30',null,null,'3455344J');
 
  
 
COMMIT;

--*************************MAYOR DIFICULTAD****************************************************

--12. Mostrar cuantos arreglos ha terminado Ignacio Peña

SELECT COUNT(AV.FECHA_ARREGLO)
FROM AVERIAS_PARQUE AV
JOIN EMPLE_PARQUE EMP ON AV.DNI_EMPLE = EMP.DNI_EMPLE
WHERE UPPER(EMP.NOM_EMPLEADO) LIKE ('%IGNACIO PENNA%');

--13. Mostrar cuantas atracciones hay en la zona Gran Maquinaria

SELECT COUNT(AT.COD_ATRACCION) AS NUM_ATRACCIONES
FROM ATRACCIONES AT
JOIN ZONAS Z ON AT.NOM_ZONA = Z.NOM_ZONA
WHERE UPPER(Z.NOM_ZONA) = 'GRAN MAQUINARIA';

--14. Mostrar cuantas averías ha habido en la zona Gran Maquinaria

SELECT COUNT(AV.FECHA_FALLA)
FROM AVERIAS_PARQUE AV
JOIN ATRACCIONES AT ON AV.COD_ATRACCION = AT.COD_ATRACCION
JOIN ZONAS Z ON Z.NOM_ZONA = AT.NOM_ZONA --UNION INDIRECTA
WHERE UPPER(Z.NOM_ZONA) IN ('GRAN MAQUINARIA');

--15. Mostrar el código de la última atracción que se ha averiado
--FALLA PORQUE MUESTRA TODAS LAS ATRACCIONES FALLADAS
SELECT AT.COD_ATRACCION
FROM ATRACCIONES AT
JOIN AVERIAS_PARQUE AV ON AV.COD_ATRACCION = AT.COD_ATRACCION
WHERE AV.FECHA_FALLA = (SELECT MAX(AV.FECHA_FALLA) FROM AVERIAS_PARQUE);

--CORECCION DE CLASE 
SELECT COD_ATRACCION
FROM AVERIAS_PARQUE
WHERE FECHA_FALLA = (SELECT MAX(FECHA_FALLA) FROM AVERIAS_PARQUE);

--16. Mostrar el código y el nombre de la atracción que más ha costado arreglar
--MISMO PROBLEMA MUESTRA TODAS LAS ATRACCIONES, NO LA QUE MAS
SELECT AT.NOM_ATRACCION, AT.COD_ATRACCION
FROM ATRACCIONES AT
JOIN AVERIAS_PARQUE AVE ON AVE.COD_ATRACCION = AT.COD_ATRACCION
WHERE AVE.COSTE_AVERIA = (SELECT MAX(AVE.COSTE_AVERIA) FROM AVERIAS_PARQUE);

--CORRECCION DE CLASE
SELECT NOM_ATRACCION, AV.COD_ATRACCION
FROM AVERIAS_PARQUE AV 
JOIN ATRACCIONES A ON AV.COD_ATRACCION = A.COD_ATRACCION+
WHERE COSTE_AVERIA = (SELECT MAX(COSTE_AVERIA) FROM AVERIAS_PARQUE);



