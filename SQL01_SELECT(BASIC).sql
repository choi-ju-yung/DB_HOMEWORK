
-- 1번
SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY AS 계열
FROM TB_DEPARTMENT;

-- 2번
SELECT DEPARTMENT_NAME||'의 정원은 '||CAPACITY||'명 입니다.'
FROM TB_DEPARTMENT;

-- 3번
SELECT STUDENT_NAME AS "이름"
FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과' AND ABSENCE_YN = 'Y'
            AND SUBSTR(STUDENT_SSN,8,1) IN (2,4);


-- 4번
SELECT STUDENT_NAME AS "대출 도서 장기 연체자"
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110','A513119')
ORDER BY STUDENT_NAME DESC;



-- 5번
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;


-- 6번
SELECT PROFESSOR_NAME AS "총장 이름"
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;


-- 7번
SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;


-- 8번
SELECT CLASS_NO AS "선수과목"
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;


-- 9번
SELECT DISTINCT(CATEGORY) AS "계열"
FROM TB_DEPARTMENT;


-- 10번
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,2) = 'A2' AND SUBSTR(STUDENT_ADDRESS,1,2) = '전주'
AND ABSENCE_YN = 'N';


SELECT * FROM TB_CLASS;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;