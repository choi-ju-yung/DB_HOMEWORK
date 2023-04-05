SELECT * FROM EMPLOYEE;

-- 1�� ����
SELECT * FROM JOB;

-- 2�� ����
SELECT JOB_NAME FROM JOB;

-- 3�� ����
SELECT * FROM DEPARTMENT;

-- 4�� ����
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5�� ����
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 6�� ����
--  EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT EMP_NAME AS "�̸�", SALARY*12 AS "����", 
SALARY*12*(1+BONUS) AS "�Ѽ��ɾ�(���ʽ�����)", (SALARY*12*(1+BONUS) - ((SALARY*12)*0.03)) AS "�Ǽ��ɾ�"
FROM EMPLOYEE;

-- 7�� ����
--  EMPLOYEE���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE, PHONE
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 8�� ����
--  EMPLOYEE���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT EMP_NAME, SALARY,(SALARY*12*(1+BONUS) - ((SALARY*12)*0.03)),HIRE_DATE
FROM EMPLOYEE
WHERE (SALARY*12*(1+BONUS) - ((SALARY*12)*0.03)) >= 50000000;

-- 9�� ���� 
--  EMPLOYEE���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT * FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';


-- 10�� ����
-- EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� �� ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE 
FROM EMPLOYEE
WHERE  (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE < '02/01/01';


-- 11�� ����
-- EMPLOYEE���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';  

-- 12�� ����
-- EMPLOYEE���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

-- 13�� ���� 
-- EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- 14�� ����  
-- EMPLOYEE���̺��� �����ּ� '_'�� ���� 4���̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
-- ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '____\_%' ESCAPE '\' AND (DEPT_CODE = 'D6' OR DEPT_CODE = 'D9')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01' AND SALARY >= 2700000;

-- 15�� ����  EMPLOYEE���̺��� ��� ��� ������ �ֹι�ȣ�� �̿��Ͽ� ����, ����, ���� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO,1,2) AS "����", SUBSTR(EMP_NO,3,2) AS "����",
SUBSTR(EMP_NO,5,2) AS "����" FROM EMPLOYEE;

-- 16�� ����  EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲٱ�)
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,INSTR(EMP_NO,'-')),LENGTH(EMP_NO),'*')
FROM EMPLOYEE;

-- 17�� ���� EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ *�⵵�� ���� �ϼ��� �ٸ� �� ����. ������ ��
-- (��, �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ǵ��� �ϰ� ��� ����(����), ����� �ǵ��� ó��)
SELECT EMP_NAME, FLOOR(SYSDATE - HIRE_DATE) AS "�ٹ��ϼ�1" , FLOOR(ABS(HIRE_DATE - SYSDATE)) AS "�ٹ��ϼ�2"
FROM EMPLOYEE;

-- 18�� ���� ( EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ)
SELECT * FROM EMPLOYEE
WHERE MOD(EMP_ID,2) = 1;

-- 19�� ����  (�ٹ������ 25�� �̻��� ���� ���� ��ȸ)
SELECT * FROM EMPLOYEE
WHERE  EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >= 25;

-- 20�� ����
-- EMPLOYEE ���̺��� �����, �޿� ��ȸ (��, �޿��� '\9,000,000' �������� ǥ��)
SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999') FROM EMPLOYEE;


-- 21�� ����
-- EMPLOYEE���̺��� ���� ��, �μ��ڵ�, �������, ����(��) ��ȸ
-- (��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
-- ���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���)
SELECT EMP_NAME, DEPT_CODE, SUBSTR(EMP_NO,1,2)||'�� '||SUBSTR(EMP_NO,3,2)||'�� '||SUBSTR(EMP_NO,5,2)||'��' ,
EXTRACT(YEAR FROM SYSDATE)-(
    TO_NUMBER(SUBSTR(EMP_NO,1,2))+
    CASE
        WHEN SUBSTR(EMP_NO,8,1) IN (1,2) THEN 1900 
        WHEN SUBSTR(EMP_NO,8,1) IN (3,4) THEN 2000 
    END
    ) AS "��"
FROM EMPLOYEE;


-- 22�� ����
-- EMPLOYEE���̺��� �μ��ڵ尡 D5, D6, D9�� ����� ��ȸ�ϵ� D5�� �ѹ���, D6�� ��ȹ��, D9�� �����η� ó��
-- (��, �μ��ڵ� ������������ ����)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, 
        CASE DEPT_CODE
                WHEN 'D5' THEN '�ѹ���'
                WHEN 'D6' THEN '��ȹ��'
                WHEN 'D9' THEN '������'
        END
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9');

-- 23������
--  EMPLOYEE���̺��� ����� 201���� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�,  �ֹι�ȣ ���ڸ��� ���ڸ��� �� ��ȸ
SELECT EMP_NAME, SUBSTR(EMP_NO,1,6) AS "�ֹι�ȣ ���ڸ�", SUBSTR(EMP_NO,8,7) AS "�ֹι�ȣ ���ڸ�",
TO_NUMBER(SUBSTR(EMP_NO,1,6)) + TO_NUMBER(SUBSTR(EMP_NO,8,7)) AS "�հ� �� ��"
FROM EMPLOYEE
WHERE EMP_ID = 201;


-- 24������
-- EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �� ��ȸ
-- ���ʽ� ���Ը��ϰ���
SELECT SUM(SALARY*12*(1+NVL(BONUS,0)))  
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING DEPT_CODE = 'D5'; 

-- 25������
-- EMPLOYEE���̺��� �������� �Ի��Ϸκ��� �⵵�� ������ �� �⵵�� �Ի� �ο��� ��ȸ
-- ��ü ���� ��, 2001��, 2002��, 2003��, 2004��

SELECT COUNT(*) AS ��ü������, 
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2001',0)) as "2001��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2002',0)) as "2002��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2003',0)) as "2003��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2004',0)) as "2004��"
FROM EMPLOYEE;
