--Ejercicios Variados de consultas 
--Conexi�n con usuario hr 

--1. Muestra cu�ntos empleados tienen comisi�n. 
SELECT COUNT(*)"EMPLEADOS_CON_COMISION" FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

--2. �Cu�l es la longitud media sin decimales de los nombre de los pa�ses (COUNTRIES)? 
SELECT ROUND(AVG(LENGTH(COUNTRY_NAME)))"MEDIA" FROM COUNTRIES;

--3. Calcula el salario medio de los empleados que trabajan en el departamento 60. 
SELECT AVG(SALARY)"SALARIO_MEDIO" FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--4. Muestra el salario m�ximo de todos los empleados, el salario m�nimo y la diferencia entre ambos. 
SELECT MAX(SALARY)"MAXIMO", MIN(SALARY)"MINIMO", MAX(SALARY)-MIN(SALARY)"DIFERENCIA" FROM EMPLOYEES;

--5. Muestra la informaci�n anterior clasificada por c�digo de departamento. 
SELECT DEPARTMENT_ID,MAX(SALARY)"MAXIMO", MIN(SALARY)"MINIMO", MAX(SALARY)-MIN(SALARY)"DIFERENCIA" FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL
ORDER BY DEPARTMENT_ID;

--6. �Cu�ntos empleados hay cuyo nombre comienza con vocal? 
SELECT SUM(DECODE(UPPER(SUBSTR(FIRST_NAME,1,1)),'A',1,'E',1,'I',1,'O',1,'U',1,0)) "N_EMPLEADOS" FROM EMPLOYEES;

SELECT COUNT(*)"N_EMPLEADOS" FROM EMPLOYEES
WHERE UPPER(SUBSTR(FIRST_NAME,1,1)) IN ('A','E','I','O','U');
--7. Y �Cu�ntos empleados hay cuyo nombre comienza con consonante? 
SELECT COUNT(*)-SUM(DECODE(UPPER(SUBSTR(FIRST_NAME,1,1)),'A',1,'E',1,'I',1,'O',1,'U',1,0)) "EMPLEADOS" FROM EMPLOYEES;

--8. Muestra cu�ntos empleados tienen una comisi�n de 0,25 � 0,2. 
SELECT COUNT(*) "EMPLEADOS" FROM EMPLOYEES
WHERE COMMISSION_PCT = 0.25 OR COMMISSION_PCT = 0.2;

--9. Visualiza ahora, para cada valor de la columna comisi�n, cu�ntos empleados cobran cada valor (NOTA: cuenta tambi�n los nulos). 
SELECT COUNT(*) "EMPLEADOS", COMMISSION_PCT "COMISION" FROM EMPLOYEES
WHERE COMMISSION_PCT = 0.25 OR COMMISSION_PCT = 0.2 OR COMMISSION_PCT IS NULL
GROUP BY COMMISSION_PCT;

--10. Muestra de cada regi�n su c�digo (REGION_ID) y el n�mero de pa�ses de dicha regi�n. 
SELECT REGION_NAME "CONTINENTE", COUNT(COUNTRY_NAME)"PAISES" FROM REGIONS R
JOIN COUNTRIES C ON C.REGION_ID = R.REGION_ID
GROUP BY REGION_NAME;

--11. De la consulta anterior, selecciona el c�digo de regiones que tengan al menos 5 pa�ses. 
SELECT REGION_NAME "CONTINENTE", COUNT(COUNTRY_NAME)"PAISES" FROM REGIONS R
JOIN COUNTRIES C ON C.REGION_ID = R.REGION_ID
GROUP BY REGION_NAME
HAVING COUNT(COUNTRY_NAME)>5;

--12. �Cu�ntos pa�ses tiene la regi�n que m�s pa�ses tiene? 
SELECT REGION_NAME "CONTINENTE", COUNT(COUNTRY_NAME)"PAISES" FROM REGIONS R
JOIN COUNTRIES C ON C.REGION_ID = R.REGION_ID
GROUP BY REGION_NAME
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM COUNTRIES
                    GROUP BY REGION_ID);

--13. �Cu�ntos empleados hay cuyo job_id acabe con la palabra �CLERK�? (PU_CLERK, ST_CLERK y SH_CLERK) 
SELECT COUNT(*) "N_EMPLEADOS" FROM EMPLOYEES
WHERE UPPER(JOB_ID) LIKE '%CLERK';

--14. �Y cu�ntos hay de cada tipo? (Cu�ntos PU_CLERK, cu�ntos ST_CLERK y cu�ntos SH_CLERK? 
SELECT JOB_ID, COUNT(*) "N_EMPLEADOS" FROM EMPLOYEES
WHERE UPPER(JOB_ID) LIKE '%CLERK'
GROUP BY JOB_ID;

---15. Muestra de cada departamento, su c�digo y el salario medio de sus empleados. 
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, ROUND(AVG(SALARY))"SALARIO_MEDIO" FROM DEPARTMENTS D
JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME, D.DEPARTMENT_ID;

--16. Muestra el c�digo de los departamentos cuyo salario medio de empleados sea superior a 7000. 
SELECT DEPARTMENT_ID FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY)>7000;

--17. �Cu�ntos departamentos hay cuyo salario medio de empleados es superior a 7000?. 
SELECT COUNT(COUNT(DISTINCT DEPARTMENT_ID)) "N_DEPARTAMENTOS" FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 7000;

--18. �Cu�l es el salario medio m�s bajo del listado anterior?
SELECT ROUND(MIN(AVG(SALARY)))"SALARIO_MEDIO" FROM EMPLOYEES E
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID= E.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
HAVING AVG(SALARY)>7000;
