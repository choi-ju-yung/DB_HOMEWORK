-- 문제1 (기술지원부에 속한 사람들의 사람의 이름,부서코드,급여를 출력하시오. ) 조인하지 않고!


SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '기술지원부');


-- 문제2 (기술지원부에 속한 사람들 중 가장 연봉이 높은 사람의 이름,부서코드,급여를 출력하시오)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E1
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '기술지원부') 
AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_ID =DEPT_CODE WHERE DEPT_TITLE = '기술지원부');




--문제3
--매니저가 있는 사원중에 월급이 전체사원 평균을 넘고 
--사번,이름,매니저 이름, 월급을 구하시오. 
--1. JOIN을 이용하시오
SELECT E2.EMP_ID, E2.EMP_NAME, E1.EMP_NAME AS "매니저이름", E2.SALARY 
    FROM EMPLOYEE E1
    JOIN EMPLOYEE E2 ON E1.EMP_ID = E2.MANAGER_ID
WHERE E2.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);


--2. JOIN하지 않고, 스칼라상관쿼리(SELECT)를 이용하기
SELECT E1.EMP_ID, E1.EMP_NAME, 
(SELECT E2.EMP_NAME FROM EMPLOYEE E2 WHERE E2.EMP_ID = E1.MANAGER_ID) 
, E1.SALARY
FROM EMPLOYEE E1
WHERE E1.MANAGER_ID IS NOT NULL AND E1.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE) ;



-- 문제 4
--같은 직급의 평균급여보다 같거나 많은 급여를 받는 직원의 이름, 직급코드, 급여, 급여등급 조회
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

SELECT E.EMP_NAME AS "이름", E.JOB_CODE AS "직급코드", E.SALARY AS "급여", E.SAL_LEVEL AS "급여등급"
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.JOB_CODE = JOB_CODE);


-- 문제 5
--부서별 평균 급여가 2200000 이상인 부서명, 평균 급여 조회
--단, 평균 급여는 소수점 버림, 부서명이 없는 경우 '인턴'처리

SELECT NVL(DEPT_TITLE,'인턴'), FLOOR(AVG(SALARY)) AS "AVGSAL"
FROM EMPLOYEE 
    LEFT JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
    GROUP BY DEPT_TITLE, 'AVGSAL'
HAVING AVG(SALARY) > 2200000;



--문제6
--직급의 연봉 평균보다 적게 받는 여자사원의
--사원명,직급명,부서명,연봉을 이름 오름차순으로 조회하시오
--연봉 계산 => (급여+(급여*보너스))*12    
-- 사원명,직급명,부서명,연봉은 EMPLOYEE 테이블을 통해 출력이 가능함  
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY*12*(1+NVL(BONUS,0))
FROM EMPLOYEE E
    JOIN DEPARTMENT D ON DEPT_ID = DEPT_CODE
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE SALARY*12*(1+NVL(BONUS,0)) 
< (SELECT SUM(SALARY*12*(1+NVL(BONUS,0))) FROM EMPLOYEE WHERE E.JOB_CODE = JOB_CODE)
AND SUBSTR(EMP_NO,8,1) IN (2,4)
ORDER BY EMP_NAME;


SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;




