--Tablas Depart y Emple


drop table emple;
drop table depart;

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

--EJERCICIOS HOJA 2 SUBCONSULTAS
--1. Empleados que están en el mismo departamento que GIL.

SELECT EMP_NO, APELLIDO, DEPT_NO, OFICIO
FROM EMPLE 
WHERE DEPT_NO = ( SELECT DEPT_NO FROM EMPLE WHERE UPPER(APELLIDO) = 'GIL');

--2. Empleados con salario superior al salario de TOVAR.

SELECT EMP_NO, APELLIDO, SALARIO
FROM EMPLE
WHERE SALARIO > (SELECT SALARIO FROM EMPLE WHERE UPPER(APELLIDO) = 'TOVAR');

--3. Empleados que tienen el mismo oficio que MARTIN o ganan menos que ALONSO
--(ALONSO GANA  1430 Y MARTIN ES VENDEDOR)

SELECT EMP_NO, APELLIDO, OFICIO, SALARIO
FROM EMPLE
WHERE OFICIO = (SELECT OFICIO FROM EMPLE WHERE UPPER(APELLIDO) = 'MARTIN')
OR SALARIO < (SELECT SALARIO FROM EMPLE WHERE UPPER(APELLIDO) = 'ALONSO');


--4. Apellido y salario de los empleados que tienen por director (campo dir) a quien se apellida NEGRO.

SELECT EMP_NO, APELLIDO, DIR
FROM EMPLE
WHERE DIR = (SELECT DIR FROM EMPLE WHERE UPPER(APELLIDO) = 'NEGRO')
AND UPPER(APELLIDO) <> 'NEGRO'; -- Y EL APPELLIDO NO SEA NEGRO, PORQUE SINO NEGRO TE SALE COMO UN EMPLEADO MÁS.


--5. Empleados en el mismo departamento que GIL y tienen su mismo oficio y salario

SELECT EMP_NO, APELLIDO, OFICIO, SALARIO
FROM EMPLE
WHERE DEPT_NO = (SELECT DEPT_NO FROM EMPLE WHERE UPPER(APELLIDO) = 'GIL')
AND SALARIO =(SELECT SALARIO  FROM EMPLE WHERE UPPER(APELLIDO) = 'GIL')
AND UPPER(APELLIDO) != 'GIL'; -- Y EL APELLIDO NO SEA GIL.

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


--6. Datos de los alumnos que viven en la misma población que Luis.

--AQUI VEMOS UN EJEMPLO, EN EL QUE EL OPERADOR = NO FUNCIONA, Y AL USAR LIKE EL PORBLEMA SE RESUELVE,


--DEJO LA EXPLICACION 
--el uso de LIKE con patrones de cadena, como %LUIS%, puede ser más flexible para manejar situaciones en las que el nombre 'Luis' 
--está incrustado en otros nombres. La igualdad estricta (=) requiere que las cadenas coincidan exactamente,
--mientras que LIKE con % permite coincidencias parciales.

SELECT *
FROM ALUMNOS
WHERE POBLA = (SELECT POBLA FROM ALUMNOS WHERE UPPER(APENOM) = 'LUIS')
AND UPPER(APENOM) != 'LUIS';

SELECT APENOM
FROM ALUMNOS
WHERE POBLA = (SELECT POBLA FROM ALUMNOS WHERE UPPER(APENOM) = 'LUIS')
AND UPPER(APENOM) != 'LUIS';


--7. Nombre de las asignaturas que no han tenido ningún 6.
--LA DIFICULTAD DE ESTE EJERCICIO ES QUE TAL Y COMO HEMOS VISTO HASTA AHORA, LAS FILTRACIONES SE HACIAN VALOR POR VALOR
--PERO AHORA QUEREMOS OBTENER UN VALOR QUE ES TRUE O FALSE, DEPENDIENDO DE VARIOS VALORES, ES DECIR QUE POR EJEMPLO
--PROGRAMACION PUEDE SER UN 6 DEPENDIENDO DEL ALUMNO, POR LO TANTO ES TRUE Y FALSE DEPENDIENDO DEL ALUMNO
--EXISTE UN METODO LLAMADO EXIST, EN EL CUAL SI HAY UN SOLO TRUE ESA COLUMNA ES EXIST Y SINO ES NO EXISTE

SELECT COD, NOMBRE
FROM ASIGNATURAS
WHERE NOT EXISTS (SELECT 1 FROM NOTAS WHERE NOTAS.COD = ASIGNATURAS.COD AND NOTA = 6);



--8. Visualizar los nombres de asignaturas que no tengan suspensos.
--, ES DECIR QUE QUEREMOS OBTNER
--LAS ASIGNATURAS QUE TIENEN O NO TIENE SUSPENSO, PERO CADA ASIGNATURA PUEDE TENER VARIOS APROBADOS Y SUSPENSOS O NINGUNO O ALGUNO, 
--ESTO SE HACE CON EXIST O NO EXIST

SELECT ASI.COD, ASI.NOMBRE
FROM ASIGNATURAS ASI
WHERE NOT EXISTS (
   SELECT 1 --EN EXITTS ES COMUN USAR 1 , PORQUE NO QUIERE REVISAR TODA LAS FILAS DE UNA COLUMNAS (EN ESTE CASO NOTA) SINO CUANDO ENCUENTRE UN VALOR SE DETIENE. Y ES MAS EFICIENTE, COMO UN BREAK.
   FROM NOTAS N
   WHERE N.COD = ASI.COD AND N.NOTA < 5
);


--9. Visualizar los nombres de alumnos de “Madrid” que tengan alguna asignatura suspensa.
--AQUI HAY QUE HAY  QUE CRIBAR LOS ALUMNOS QUE SON DE MADRID (PRIMERA CONSULTA) + EXIST.

SELECT APENOM, DNI, POBLA
FROM ALUMNOS
WHERE UPPER(POBLA) = 'MADRID' AND EXISTS (SELECT 1 FROM NOTAS WHERE NOTAS.DNI = ALUMNOS.DNI AND NOTA < 5);


-- *************************************DIFICULTAD MUCHO MAYOR A PARTIR DE AQUI*****************************************************************************


--10. Mostrar los nombres de alumnos que tengan la misma nota que tiene María en  Marcas en cualquier asignatura
--PRIMERO TENEMOS QUE CONOCER QUE NOTA TIENE MARIA EN MARCAR Y DESPUES COMPARARLO CON OTRAS ASIGNATURAS DE TODOS LOS ALUMNOS

SELECT APENOM
FROM ALUMNOS 
WHERE DNI  IN (SELECT DISTINCT DNI FROM NOTAS WHERE NOTA=(SELECT NOTA FROM NOTAS
                                                          WHERE DNI = (SELECT DNI FROM ALUMNOS WHERE UPPER(APENOM) LIKE '%MARIA%')
                                                          AND COD = (SELECT COD FROM ASIGNATURAS WHERE UPPER(NOMBRE)='MARCAS')));


--11. Mostrar los nombres de alumnos que tengan en Programación la misma nota que tiene Luis en Programación

--NOMBRE DE ALUMNOS QUE TIENEN LA MISMA NOTA QUE LUIS EN PROGRAMACIÓN EN PROGRAMACIÓN
SELECT  APENOM
FROM ALUMNOS
WHERE DNI IN (SELECT DNI
FROM NOTAS
WHERE COD=(SELECT COD FROM ASIGNATURAS WHERE UPPER(NOMBRE)='PROGRAMACIÓN')
AND NOTA=(SELECT NOTA
          FROM NOTAS 
          WHERE DNI = (SELECT DNI FROM ALUMNOS WHERE UPPER(APENOM) LIKE '%LUIS%')
          AND COD = (SELECT COD FROM ASIGNATURAS WHERE UPPER(NOMBRE)='PROGRAMACIÓN')));
          
          
          
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


--12. Mostrar el nombre de las atracciones que están en la misma zona que Lejano Oeste (LEJANO OESTE ES UNA ATRACCION, NO UNA ZONA)

SELECT NOM_ATRACCION, NOM_ZONA
FROM ATRACCIONES
WHERE NOM_ZONA IN (SELECT NOM_ZONA FROM ATRACCIONES WHERE UPPER(NOM_ATRACCION) = UPPER('LEJANO OESTE'))


--13. Mostrar el nombre de las atracciones que no han tenido averías.

--UTILIZANDO EXISTS
SELECT NOM_ATRACCION
FROM ATRACCIONES
WHERE NOT EXISTS (SELECT 1 FROM AVERIAS_PARQUE WHERE ATRACCIONES.COD_ATRACCION = AVERIAS_PARQUE.COD_ATRACCION);


--FORMA CONVENCIONAL
SELECT COD_ATRACCION, NOM_ATRACCION
FROM ATRACCIONES
WHERE COD_ATRACCION NOT IN (SELECT COD_ATRACCION
                        	FROM AVERIAS_PARQUE);

--14. Mostrar el nombre de las atracciones que no están actualmente averiadas

SELECT NOM_ATRACCION, COD_ATRACCION
FROM ATRACCIONES
WHERE COD_ATRACCION NOT IN (SELECT COD_ATRACCION
                       FROM AVERIAS_PARQUE
                       WHERE FECHA_ARREGLO IS NULL);


--15. Mostrar los empleados que no han hecho arreglos en el año 2013

--UTILIZANDO EXISTS
SELECT NOM_EMPLEADO, DNI_EMPLE
FROM EMPLE_PARQUE
WHERE NOT EXISTS (SELECT 1 
                    FROM AVERIAS_PARQUE 
                    WHERE EMPLE_PARQUE.DNI_EMPLE = AVERIAS_PARQUE.DNI_EMPLE 
                    AND TO_CHAR(FECHA_ARREGLO, 'YYYY') = '2013');
                                                

--UTILIZANDO NOT IN

SELECT NOM_EMPLEADO, DNI_EMPLE
FROM EMPLE_PARQUE
WHERE DNI_EMPLE NOT IN (
    SELECT DNI_EMPLE 
    FROM AVERIAS_PARQUE 
    WHERE TO_CHAR(FECHA_ARREGLO, 'YYYY') = '2013'
);















