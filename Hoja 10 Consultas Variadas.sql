--Ejercicios Variados de consultas 
--Conexión con usuario hr 

--1. Muestra cuántos empleados tienen comisión. 
SELECT COUNT(*)"EMPLEADOS_CON_COMISION" FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

--2. ¿Cuál es la longitud media sin decimales de los nombre de los países (COUNTRIES)? 
SELECT ROUND(AVG(LENGTH(COUNTRY_NAME)))"MEDIA" FROM COUNTRIES;

--3. Calcula el salario medio de los empleados que trabajan en el departamento 60. 
SELECT AVG(SALARY)"SALARIO_MEDIO" FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--4. Muestra el salario máximo de todos los empleados, el salario mínimo y la diferencia entre ambos. 
SELECT MAX(SALARY)"MAXIMO", MIN(SALARY)"MINIMO", MAX(SALARY)-MIN(SALARY)"DIFERENCIA" FROM EMPLOYEES;

--5. Muestra la información anterior clasificada por código de departamento. 
SELECT DEPARTMENT_ID,MAX(SALARY)"MAXIMO", MIN(SALARY)"MINIMO", MAX(SALARY)-MIN(SALARY)"DIFERENCIA" FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING DEPARTMENT_ID IS NOT NULL
ORDER BY DEPARTMENT_ID;

--6. ¿Cuántos empleados hay cuyo nombre comienza con vocal? 
SELECT SUM(DECODE(UPPER(SUBSTR(FIRST_NAME,1,1)),'A',1,'E',1,'I',1,'O',1,'U',1,0)) "N_EMPLEADOS" FROM EMPLOYEES;

SELECT COUNT(*)"N_EMPLEADOS" FROM EMPLOYEES
WHERE UPPER(SUBSTR(FIRST_NAME,1,1)) IN ('A','E','I','O','U');
--7. Y ¿Cuántos empleados hay cuyo nombre comienza con consonante? 
SELECT COUNT(*)-SUM(DECODE(UPPER(SUBSTR(FIRST_NAME,1,1)),'A',1,'E',1,'I',1,'O',1,'U',1,0)) "EMPLEADOS" FROM EMPLOYEES;

--8. Muestra cuántos empleados tienen una comisión de 0,25 ó 0,2. 
SELECT COUNT(*) "EMPLEADOS" FROM EMPLOYEES
WHERE COMMISSION_PCT = 0.25 OR COMMISSION_PCT = 0.2;

--9. Visualiza ahora, para cada valor de la columna comisión, cuántos empleados cobran cada valor (NOTA: cuenta también los nulos). 
SELECT COUNT(*) "EMPLEADOS", COMMISSION_PCT "COMISION" FROM EMPLOYEES
WHERE COMMISSION_PCT = 0.25 OR COMMISSION_PCT = 0.2 OR COMMISSION_PCT IS NULL
GROUP BY COMMISSION_PCT;

--10. Muestra de cada región su código (REGION_ID) y el número de países de dicha región. 
SELECT REGION_NAME "CONTINENTE", COUNT(COUNTRY_NAME)"PAISES" FROM REGIONS R
JOIN COUNTRIES C ON C.REGION_ID = R.REGION_ID
GROUP BY REGION_NAME;

--11. De la consulta anterior, selecciona el código de regiones que tengan al menos 5 países. 
SELECT REGION_NAME "CONTINENTE", COUNT(COUNTRY_NAME)"PAISES" FROM REGIONS R
JOIN COUNTRIES C ON C.REGION_ID = R.REGION_ID
GROUP BY REGION_NAME
HAVING COUNT(COUNTRY_NAME)>5;

--12. ¿Cuántos países tiene la región que más países tiene? 
SELECT REGION_NAME "CONTINENTE", COUNT(COUNTRY_NAME)"PAISES" FROM REGIONS R
JOIN COUNTRIES C ON C.REGION_ID = R.REGION_ID
GROUP BY REGION_NAME
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM COUNTRIES
                    GROUP BY REGION_ID);

--13. ¿Cuántos empleados hay cuyo job_id acabe con la palabra ‘CLERK’? (PU_CLERK, ST_CLERK y SH_CLERK) 
SELECT COUNT(*) "N_EMPLEADOS" FROM EMPLOYEES
WHERE UPPER(JOB_ID) LIKE '%CLERK';

--14. ¿Y cuántos hay de cada tipo? (Cuántos PU_CLERK, cuántos ST_CLERK y cuántos SH_CLERK? 
SELECT JOB_ID, COUNT(*) "N_EMPLEADOS" FROM EMPLOYEES
WHERE UPPER(JOB_ID) LIKE '%CLERK'
GROUP BY JOB_ID;

---15. Muestra de cada departamento, su código y el salario medio de sus empleados. 
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, ROUND(AVG(SALARY))"SALARIO_MEDIO" FROM DEPARTMENTS D
JOIN EMPLOYEES E ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME, D.DEPARTMENT_ID;

--16. Muestra el código de los departamentos cuyo salario medio de empleados sea superior a 7000. 
SELECT DEPARTMENT_ID FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY)>7000;

--17. ¿Cuántos departamentos hay cuyo salario medio de empleados es superior a 7000?. 
SELECT COUNT(COUNT(DISTINCT DEPARTMENT_ID)) "N_DEPARTAMENTOS" FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) > 7000;

--18. ¿Cuál es el salario medio más bajo del listado anterior?
SELECT ROUND(MIN(AVG(SALARY)))"SALARIO_MEDIO" FROM EMPLOYEES E
JOIN DEPARTMENTS D ON D.DEPARTMENT_ID= E.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
HAVING AVG(SALARY)>7000;
