-- 1번문제
SELECT * FROM EMP
WHERE COMM IS NOT NULL;

-- 2번문제
SELECT * FROM EMP
WHERE COMM IS NULL;

-- 3번 문제
SELECT * FROM EMP
WHERE MGR IS NULL;

-- 4번 문제
SELECT * FROM EMP
ORDER BY SAL DESC;

-- 5번 문제 (급여가 같을 경우 커미션을 내림차순 정렬 조회)
SELECT * FROM EMP
ORDER BY SAL DESC, COMM DESC;

-- 6번 문제
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE;

-- 7번 문제
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;


-- 8번
SELECT EMPNO, HIREDATE, ENAME, DEPTNO
FROM EMP
ORDER BY DEPTNO, HIREDATE DESC;

-- 9번 오늘날짜에 대한 정보 조회
SELECT SYSDATE FROM DUAL;


-- 10번 (급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO, ENAME, TRUNC(SAL,-2)
FROM EMP
ORDER BY SAL DESC;


-- 11번 EMP테이블에서 사원번호가 홀수인 사원들을 조회
SELECT * FROM EMP
WHERE MOD(EMPNO,2) = 1;


-- 12번 사원명, 입사일 조회 (단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT ENAME, EXTRACT(YEAR FROM HIREDATE)||'년도' AS 년도,
EXTRACT(MONTH FROM HIREDATE)||'월' AS "월"
FROM EMP;


-- 13번  EMP테이블에서 9월에 입사한 직원의 정보 조회
SELECT * FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = '9';


-- 14번  EMP테이블에서 81년도에 입사한 직원 조회
SELECT * FROM EMP
WHERE SUBSTR(EXTRACT(YEAR FROM HIREDATE),3,2) = 81;


-- 15번 EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT * FROM EMP
WHERE SUBSTR(ENAME,-1,1) = 'E';


-- 16번  EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
SELECT * FROM EMP
WHERE SUBSTR(ENAME,3,1) = 'R';

SELECT * FROM EMP
WHERE ENAME LIKE '__R%';


-- 17번 EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE,480)
FROM EMP;


-- 18번 EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
-- 456개월 -> 38년
SELECT * FROM EMP
WHERE FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) >= 456;


-- 19번 오늘 날짜에서 년도만 추출
SELECT EXTRACT(YEAR FROM SYSDATE) AS 올해년도
FROM DUAL;