
-- 1번문제
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- 3번문제
SELECT EMP_NAME, SUBSTR(EMP_NO,1,2), NVL(BONUS,0)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69; 


-- 4번문제
SELECT COUNT(*)||'명' AS "핸드폰 없는 인원 수" FROM EMPLOYEE
WHERE PHONE IS NULL;


--5번문제 (직원명과 입사년월을 출력하시오 )
SELECT EMP_NAME AS "직원명", 
EXTRACT(YEAR FROM HIRE_DATE)||'년 '||EXTRACT(MONTH FROM HIRE_DATE)||'월' AS "입사년월"
FROM EMPLOYEE;


--6번문제 직원명과 주민번호를 조회하시오
SELECT EMP_NAME AS "직원명",
RPAD(SUBSTR(EMP_NO,1,8),LENGTH(EMP_NO),'*')
FROM EMPLOYEE;


-- 7번문제
SELECT EMP_NAME AS "직원명", DEPT_CODE AS "직급코드",
TO_CHAR(SALARY*12*(1+NVL(BONUS,0)),'L999,999,999')
FROM EMPLOYEE;


--8번문제    부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원중에 조회
SELECT EMP_NO, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D9') AND SUBSTR(HIRE_DATE,1,2) = '04'; 


--9번문제
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) AS "근무일수"
FROM EMPLOYEE;


--11. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오. 마지막으로 전체직원수도 구하시오
--	-------------------------------------------------------------------------
--	 1998년   1999년   2000년   2001년   2002년   2003년   2004년  전체직원수
--	-------------------------------------------------------------------------
SELECT COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'1998',0)) AS "1998년",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'1999',0)) AS "1999년",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2000',0)) AS "2000년",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2001',0)) AS "2001년",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2002',0)) AS "2002년",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2003',0)) AS "2003년",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2004',0)) AS "2004년",
COUNT(*) AS "전체 직원수"
FROM EMPLOYEE;


-- 12번
--   부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.(case 사용)
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회하고, 부서코드 기준으로 오름차순 정렬함.
SELECT EMP_NAME, 
CASE
    WHEN DEPT_CODE ='D5' THEN '총무부'
    WHEN DEPT_CODE ='D6' THEN '기획부'
    WHEN DEPT_CODE ='D9' THEN '영업부'
END
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY DEPT_CODE ASC;


-- 13번 EMPLOYEE 테이블에서 직급이 J1을 제외하고, 직급별 사원수 및 평균급여를 출력
SELECT COUNT(*) "직급별 사원수" , AVG(SALARY) AS "평균급여"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE;

-- 14번 EMPLOYEE테이블에서 직급이 J1을 제외하고,  입사년도별 인원수를 조회해서, 입사년 기준으로 오름차순 정렬
SELECT COUNT(*) AS "인사년도별 인원수"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY HIRE_DATE
ORDER BY HIRE_DATE ASC;


-- 15번
--[EMPLOYEE] 테이블에서 EMP_NO의 8번째 자리가 1, 3 이면 '남', 2, 4 이면 '여'로 결과를 조회하고,
-- 성별별 급여의 평균(정수처리), 급여의 합계, 인원수를 조회한 뒤 인원수로 내림차순을 정렬 하시오
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여',3,'남',4,'여') AS "성별",
FLOOR(AVG(SALARY)) AS "성별별 급여의 평균", SUM(SALARY) AS "급여의 합계", COUNT(*) AS "인원수"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여',3,'남',4,'여')
ORDER BY  COUNT(*) DESC;


-- 16번 부서내 성별 인원수를 구하세요.
SELECT DEPT_CODE, COUNT(*) AS "인원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여',3,'남',4,'여');


-- 17번 --부서별 인원이 3명보다 많은 부서와 인원수를 출력하세요.
SELECT DEPT_CODE AS "부서명", COUNT(*) AS "인원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) >=3;


-- 18번 --부서별 직급별 인원수가 3명이상인 직급의 부서코드, 직급코드, 인원수를 출력
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >=3;


-- 19번 --매니져가 관리하는 사원이 2명이상인 매니져아이디와 관리하는 사원수를 출력
SELECT MANAGER_ID AS "매니져아이디", COUNT(*) AS "사원수"
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >=2;


-- 20번 --부서명과 지역명을 출력하세요. DEPARTMENT, LOCATION 테이블 이용.
SELECT DEPT_TITLE AS "부서명", LOCAL_NAME AS "지역명"
FROM DEPARTMENT
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


-- 21번 --지역명과 국가명을 출력하세요. LOCATION, NATION 테이블
SELECT LOCAL_NAME AS "지역명", NATIONAL_NAME AS "국가명"
FROM LOCATION L
    JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE;


-- 22번 --지역명과 국가명을 출력하세요. LOCATION, NATIONAL 테이블을 조인하되 USING을 사용할것.
SELECT LOCAL_NAME AS "지역명", NATIONAL_NAME AS "국가명"
FROM LOCATION
    JOIN NATIONAL USING(NATIONAL_CODE);


SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;