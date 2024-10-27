--Ejercicios Tratamiento de Fechas

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

--1. Mostrar el mes y año en el que entró a trabajar el empleado presidente.

SELECT TO_CHAR(FECHA_ALT, 'MM,YYYY')
FROM EMPLE
WHERE UPPER (OFICIO) LIKE 'PRESIDENTE';


--2. Mostrar los empleados que entraron a trabajar en viernes.

SELECT *
FROM EMPLE
WHERE TO_CHAR(FECHA_ALT, 'D' )=6;

--3. Mostrar el mes (en número y en letra) en el que entraron a trabajar en la  empresa los empleados que entraron en el año 2007
--RESULTADO CORRECTO
SELECT TO_CHAR(FECHA_ALT, 'MONTH, MM, YYYY') AS MES
FROM EMPLE
WHERE TO_CHAR(FECHA_ALT , 'YYYY') = 2007;

--4. Mostrar apellido, fecha de alta, años que llevan en la empresa y localidad en la que trabajan los empleados que entraron a trabajar en un mes de NOVIEMBRE O DICIENMBRE.
--RESULTADO CORRECTO

SELECT APELLIDO, FECHA_ALT, TRUNC(MONTHS_BETWEEN(SYSDATE, FECHA_ALT)/12) AS AÑOS_TRABAJADOS , LOC
FROM EMPLE EMP
JOIN DEPART D ON EMP.DEPT_NO = D.DEPT_NO
WHERE TO_CHAR (FECHA_ALT, 'MM') IN(11, 12);


--5. Mostrar cuantos trienios llevan en la empresa los empleados de los departamentos de INVESTIGACION y VENTAS.

--CALCULA TRIENOS
SELECT APELLIDO, TRUNC(MONTHS_BETWEEN (SYSDATE, FECHA_ALT) / 36) AS TRIENIOS
FROM EMPLE
JOIN DEPART D ON D.DEPT_NO = EMPLE.DEPT_NO
WHERE UPPER(D.DNOMBRE) IN('INVESTIGACION', 'VENTAS'); 

--OTROS CALCULOS
 -- DIAS --> *30, AÑOS -->/12, ---> SEMESTRES /6  ---> TRIMESTRES /3 
 
 --OTRA FORMA UN POCO MÁS EXACTA DE CALCULAR LOS DIAS ES: 
 --PREGUNTAR SI LA RESTA LA HACE SI NO TIENE EL MISMO FORMATO
 --aqui como es dias la operacion quedaria asi
SELECT APELLIDO, TRUNC(SYSDATE - FECHA_ALT/365/3) AS DIAS_TRABAJADOS
FROM EMPLE
JOIN DEPART D ON D.DEPT_NO = EMPLE.DEPT_NO
WHERE UPPER(D.DNOMBRE) IN('INVESTIGACION', 'VENTAS'); 

--6. Mostrar una paga especial que se va a dar a los empleados que lleven más de 3 años en la empresa y que consiste en 200€ por año trabajado.
--PREGUNTAR EN CLASE
SELECT TRUNC(MONTHS_BETWEEN(SYSDATE, FECHA_ALT)/12)* 200 AS COMPLEMENTO
FROM EMPLE
WHERE TRUNC(MONTHS_BETWEEN(FECHA_ALT, SYSDATE) / 12) > 3 ;


--7. Mostrar cuantos años lleva trabajando el empleado más antiguo de la empresa.
--RESULTADO CORRECTO
SELECT APELLIDO, FECHA_ALT, TRUNC(MONTHS_BETWEEN(SYSDATE, FECHA_ALT)/ 12) AS AÑOS_TRABAJADOS
FROM EMPLE
WHERE FECHA_ALT = (SELECT MIN(FECHA_ALT) FROM EMPLE);           

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
 
  
 
--trabla parques 
--8. Mostrar cuantos años llevarán los empleados del departamento de Ventas el día 30/06/2015
--RESULTADO CORRECTO
SELECT TRUNC(MONTHS_BETWEEN('30/06/2015', FECHA_ALT)/12) AS AÑOS_TRABAJADOS, FECHA_ALT
FROM EMPLE 
JOIN DEPART D ON D.DEPT_NO = EMPLE.DEPT_NO
WHERE D.DNOMBRE = 'VENTAS';

--9. Mostrar a qué hora y minutos se estropeó la atracción Cataratas Locas y en los tres primeros caracteres de la zona donde se encuentra.
--RESULTADOS CORREGIDOS
SELECT TO_CHAR(FECHA_FALLA, 'HH24 : MI') AS HORA_FALLO, SUBSTR(Z.NOM_ZONA, 1,3) AS UBICACIÓN
FROM AVERIAS_PARQUE AVE
JOIN ATRACCIONES AT ON AVE.COD_ATRACCION = AT.COD_ATRACCION
JOIN ZONAS Z ON Z.NOM_ZONA = AT.NOM_ZONA --JOIN CON UNA TABLA JOIN
WHERE UPPER(NOM_ATRACCION) = 'CATARATAS LOCAS';


--10. Mostrar cuantos días estuvieron sin funcionar las atracciones que están arregladas y el nombre de la atracción, el nombre de la zona y su presupuesto.
--RESULTADOS COMPROBADOS
SELECT TRUNC(FECHA_ARREGLO - FECHA_FALLA) AS DIAS_AVERIADA, AT.NOM_ATRACCION, Z.NOM_ZONA, Z.PRESUPUESTO, AT.COD_ATRACCION
FROM AVERIAS_PARQUE AVE
JOIN ATRACCIONES AT ON AT.COD_ATRACCION = AVE.COD_ATRACCION
JOIN ZONAS Z ON Z.NOM_ZONA = AT.NOM_ZONA
WHERE FECHA_ARREGLO IS NOT NULL;


--11. Mostrar cuantos días llevan averiadas las atracciones que están sin arreglar y mostrar el nombre del encargado de la zona y el del empleado que ha de
--arreglar la avería.
--NO TE SALIA,ESTA CORREGIDA

SELECT TRUNC(SYSDATE - FECHA_FALLA) AS DIAS_AVERIADA, EMP.NOM_EMPLEADO AS ENCARGADO_ZONA , EMP2.NOM_EMPLE AS EMPLEADO_ARREGLA 
FROM AVERIAS_PARQUE AVE
JOIN ATRACCIONES AT ON AT.COD_ATRACCION = AVE.COD_ATRACCION --ES NECESARIA PARA SACAR MAS ADELANTE EL NOMBRE DE LA ZONA DONDE SE UBICA CADA ATRACCION
JOIN ZONAS Z ON Z.NOM_ZONA = AT.NOM_ZONA
JOIN EMPLE_PARQUE EMP ON Z.DNI_ENCARGADO = EMP.DNI_EMPLE -- SACAMOS EL NOMBRE DEL ENCARGADO DE LA ZONA
JOIN EMPLE_PARQUE EMP2 ON AVE.DNI_EMPLE = EMP2.DNI_EMPLE--ARREGLA AVERIA
WHERE FECHA_ARREGLO IS NULL;

--12. Mostrar la suma del coste de las averías arregladas a partir de las seis de la tarde.
--NO ACONSEJA PONER LETRAS EN HORAS ES DECIR EN STRING, PORQUE ESTAS COMPARANDO NUMERICOS
--CORREGIDA NO ME SALIA
SELECT SUM(COSTE_AVERIA) AS COSTE_TOTAL 
FROM AVERIAS_PARQUE
WHERE TO_CHAR(FECHA_ARREGLO, 'HH24:MI') > 1800;

--13. Mostrar los datos de las averías producidas un día 15 de los meses de junio a diciembre del año 2013.
--CORREGIDA DATOS CORRECTOS

--ESTA PRIMERA SOLUCIÓN NO LE GUSTA, DICE QUE ES CHAPUZA
SELECT *
FROM AVERIAS_PARQUE
WHERE TO_CHAR(FECHA_FALLA, 'DD') = 15 AND TO_CHAR( FECHA_FALLA, 'MM YYYY') IN ('06 2013','07 2013','08 2013','09 2013','10 2013','11 2013');

SELECT *
FROM AVERIAS_PARQUE
WHERE TO_CHAR(FECHA_FALLA, 'DD') = 15 AND TO_CHAR( FECHA_FALLA, 'MM')BETWEEN 6 AND 12 
AND TO_CHAR(FECHA_FALLA, 'YYYY')= 2013;


--14. Mostrar los datos de la avería que más ha tardado en arreglarse de aquellas que han sufrido averías de la zona Infantil
--NO COMPILA PREGUNTAR
SELECT *
FROM AVERIAS_PARQUE
JOIN ATRACCIONES AT ON AT.COD_ATRACCION = AVE.COD_ATRACCION --ES NECESARIA PARA SACAR MAS ADELANTE EL NOMBRE DE LA ZONA DONDE SE UBICA CADA ATRACCION
JOIN ZONAS Z ON Z.NOM_ZONA = AT.NOM_ZONA
WHERE UPPER(Z.NOM_ZONA) = 'INFANTIL' AND (FECHA_ARREGLO - FECHA_FALLA) = (SELECT MAX(FECHA_ARREGLO - FECHA_FALLA) FROM AVERIAS_PARQUE AV
										JOIN ATRACCIONES AT ON AV.COD_ATRACCION = AT.COD_ATRACCION
										JOIN ZONAS Z ON A.NOM_ZONA = Z.NOM_ZONA
										WHERE UPPER(Z.NOM_ZONA)='INFANTIL');

