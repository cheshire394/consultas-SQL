--Ejercicios Mix de funciones
--Conexión con usuario hr
--Tablas: Departments y Employees


--TABLA DEPARTMENTS
DEPARTMENT_ID	NUMBER(4,0)	No		1
DEPARTMENT_NAME	VARCHAR2(30 BYTE)	No		2
MANAGER_ID	NUMBER(6,0)	Yes		3
LOCATION_ID	NUMBER(4,0)	Yes		4

--TABLA EMPLOYEES
EMPLOYEE_ID	NUMBER(6,0)	No	
FIRST_NAME	VARCHAR2(20 BYTE)	Yes	
LAST_NAME	VARCHAR2(25 BYTE)	No	
EMAIL	VARCHAR2(25 BYTE)	No	
PHONE_NUMBER	VARCHAR2(20 BYTE)	Yes	
HIRE_DATE	DATE	No	
JOB_ID	VARCHAR2(10 BYTE)	No	
SALARY	NUMBER(8,2)	Yes	
COMMISSION_PCT	NUMBER(2,2)	Yes	
MANAGER_ID	NUMBER(6,0)	Yes	
DEPARTMENT_ID	NUMBER(4,0)	Yes	

--1. Muestra el nombre, apellido y número de teléfono de los empleados sustituyendo el punto ‘.’ que aparece en el teléfono por un guión ‘-‘.
--RESULTADO CORRECTOS
SELECT FIRST_NAME, LAST_NAME, REPLACE(PHONE_NUMBER, '.','-')
FROM EMPLOYEES;

--2. Muestra de los empleados que llevan más de 15 años en la empresa, su nombre y fecha de llegada a la empresa.
--NO COMPILA
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE (TRUNC(MONTHS_BETWEEN(SYSDATE - HIRE_DATE))/12) > 15;

--SI COMPILA
SELECT FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TRUNC((SYSDATE - HIRE_DATE)/365) > 15;


--3. Muestra las poblaciones (LOCATIONS) en las que de su código postal coinciden.
--RESULTADOS CORRECTOS
SELECT LOCATION_ID, CITY, POSTAL_CODE
FROM LOCATIONS 
WHERE SUBSTR(POSTAL_CODE, '1','1') = SUBSTR(POSTAL_CODE, '-1',1); 


--4. Muestra de cada empleado (employee_id) su código de departamento y el número de meses (sin decimales) que trabajó en dicho departamento. Busca los
--resultados en la tabla JOB_HISTORY

--EL EMPLEADO 122 TRABAJA DESDE 1 ENERO HASTA 30 DE DICIMBRE Y RETORNA 11 MESES CUANDO DEBERIAN DE SER 12, (ERA POR EL TRUNC, LO CAMBIO A ROUND)
SELECT EMPLOYEE_ID, DEPARTMENT_ID, ROUND(MONTHS_BETWEEN(END_DATE, START_DATE)) "MESES TRABAJADOS" , END_DATE, START_DATE
FROM JOB_HISTORY;

--si lo hacemos con dias
SELECT EMPLOYEE_ID, DEPARTMENT_ID, ROUND((END_DATE - START_DATE)/30) "MESES TRABAJADOS" , END_DATE, START_DATE
FROM JOB_HISTORY;

--5. Muestra sólo la información anterior para trabajos que duraron más de 2 años.

--RESULTADOS CORRECTOS
SELECT EMPLOYEE_ID, DEPARTMENT_ID, TRUNC(MONTHS_BETWEEN(END_DATE, START_DATE)) "MESES TRABAJADOS" , END_DATE, START_DATE
FROM JOB_HISTORY
WHERE TRUNC(MONTHS_BETWEEN(END_DATE, START_DATE)) > 24; 


--6. Muestra de cada empleado el nombre y el número de días que trabajaron en su primer mes de trabajo.

---NO COMPILA
SELECT FIRST_NAME, 
FROM EMPLOYEES EM
JOIN JOB_HISTORY H ON EM.EMPLOYEE_ID = H.EMPLOYEE_ID
WHERE TO_CHAR(START_DATE, 'DD') = START_DATE - LAST_MONTHS(START_DATE) ;

SELECT FIRST_NAME, 
FROM EMPLOYEES
JOIN JOB_HISTORY H USING(EMPLOYEE_ID)
WHERE H.START_DATE = (SELECT TO_CHAR(START_DATE, 'DD') = START_DATE - LAST_MONTHS(START_DATE) FROM JOB_HISTORY);

--CORRECCION DE CLASE

SELECT FIRST_NAME, TO_CHAR(LAST_DAY(HIRE_DATE),'DD') - TO_CHAR(HIRE_DATE,'DD') "NUM DIAS"
FROM EMPLOYESS;


--7. ¿En qué día de la semana caerá tu próximo cumpleaños?

SELECT TO_CHAR(TO_DATE('27062024', 'DD/MM/YYYY'), 'DAY') FROM DUAL;

--8. ¿Qué día del año 2013 es hoy?
--RESULTADO CORREGIDO
--AQUI OBSERVAMOS COMO CUANDO INTRODUCIMOS UN FORMATO SYSDATE NO ES NECESARIO ESPECIFICAR EL TIPO DE FORMATO QUE HEMOS INTRODUCIDO
SELECT TO_CHAR(TO_DATE('18012013'), 'DAY') FROM DUAL;

--9. Muestra el nombre y apellido de los empleados cuyos nombre y apellidos tienen la misma longitud.
--RESULTADOS CORRECTOS
SELECT FIRST_NAME, LAST_NAME 
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) = LENGTH(LAST_NAME);

--10. Muestra un listado de empleados donde aparezca el nombre, el apellido y si tienen ambos la misma longitud, que aparezca al lado “Igual longitud” y si son
--diferentes que aparezca “diferente longitud”.
 
 --NO COMPILA
SELECT FIRST_NAME, LAST_NAME, LENGTH(FIRST_NAME) = LENGTH(LAST_NAME) AS IGUAL_LONGITUD,  LENGTH(FIRST_NAME) <> LENGTH(LAST_NAME) AS DISTINTA LONGITUD
FROM EMPLOYEES;

--CORREGIDO EN CLASE ES UN IF-ELSE, Y ES OBLIGATORIO HACELO CON DECODE.
SELECT FIRST_NAME, LAST_NAME, DECODE(LENGTH(FIRST_NAME), LENGTH(LAST_NAME), "IGUAL LONGITUD", "DIFERENTE LONGITUD") 
FROM EMPLOYEES; 

--11. Muestra la inicial del nombre y el apellido completo de los empleados cuyo EMAIL coincida con estos valores, es decir con la concatenación de la inicial
--1del nombre y el apellido completo (hay que ignorar mayúsculas y minúsculas para que devuelva resultados).

--RESULTADOS CORRECTOS
SELECT SUBSTR(FIRST_NAME, 1,1) AS INCIAL, LAST_NAME, EMAIL
FROM EMPLOYEES
WHERE EMAIL = UPPER(CONCAT(SUBSTR(FIRST_NAME, 1,1),LAST_NAME));


--12. Muestra ordenados de menor a mayor por el código de empleado, el código de empleado, el nombre, el apellido y el EMAIL de los empleados cuyos EMAIL
--coincide con la inicial del nombre y las primeras letras del apellido

--RESULTADOS CORRECTOS(ESTA MAL PORQUE TU COGES LAS TRES PRIMERAS LETRAS PORQUE TE DA LA GANA )
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL
FROM EMPLOYEES
WHERE EMAIL = UPPER(CONCAT(SUBSTR(FIRST_NAME, 1,1),SUBSTR(LAST_NAME, 1,3)))
ORDER BY EMPLOYEE_ID; --ASCENDENTE

--CORRECCION DE CLASE (EL EJERCICIO ES MAS DIFICIL DE LO QUE PARECE)
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL
FROM EMPLOYEES
WHERE EMAIL = UPPER(SUBSTR(FIRST_NAME,1,1) || SUBSTR(LAST_NAME,1,LENGTH(EMAIL)-1)
ORDER BY EMPLOYEE_ID; --ASCENDENTE





