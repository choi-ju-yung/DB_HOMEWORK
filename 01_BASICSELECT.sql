--1. JOB���̺��� JOB_NAME�� ������ ��µǵ��� �Ͻÿ�
--2. DEPARTMENT���̺��� ���� ��ü�� ����ϴ� SELECT���� �ۼ��Ͻÿ�
--3. EMPLOYEE ���̺��� �̸�(EMP_NAME),�̸���(EMAIL),��ȭ��ȣ(PHONE),�����(HIRE_DATE)�� ����Ͻÿ�
--4. EMPLOYEE ���̺��� �����(HIRE_DATE) �̸�(EMP_NAME),����(SALARY)�� ����Ͻÿ�
--5. EMPLOYEE ���̺��� ����(SALARY)�� 2,500,000���̻��� ����� EMP_NAME �� SAL_LEVEL�� ����Ͻÿ� 
--    (��Ʈ : >(ũ��) , <(�۴�) �� �̿�)
--6. EMPLOYEE ���̺��� ����(SALARY)�� 350���� �̻��̸鼭 
--    JOB_CODE�� 'J3' �� ����� �̸�(EMP_NAME)�� ��ȭ��ȣ(PHONE)�� ����Ͻÿ�
--    (��Ʈ : AND(�׸���) , OR (�Ǵ�))
--7. EMPLOYEE ���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�� ���ɾ�-(����*���� 3%))�� ��µǵ��� �Ͻÿ�
--8. EMPLOYEE ���̺��� �̸�, �ٹ� �ϼ�(�Ի����� �����ΰ�)�� ����غ��ÿ�. (��¥�� ������갡����.)
--9. EMPLOYEE ���̺��� 20�� �̻� �ټ����� �̸�,����,���ʽ����� ����Ͻÿ�
--10.EMPLOYEE ���̺��� ������� 90/01/01 ~ 01/01/01 �� ����� ��ü ������ ����Ͻÿ�
--11.�̸��� '��'�� ���� ����� ��� ����ϼ���.
--12.EMPLOYEE ���̺��� �̸� ���� ������ ������ ����� �̸��� ����Ͻÿ�
--13.EMPLOYEE ���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ����Ͻÿ�
--14 EMPLOYEE ���̺��� �����ּ� '_'�� ���� 4���̸鼭, DEPT_CODE�� D9 �Ǵ� D6�̰� ������� 90/01/01 ~ 00/12/01�̸鼭, ������ 270�����̻��� ����� ��ü ������ ����Ͻÿ�
--15. �μ� ��ġ�� ���� �ʾ����� ���ʽ��� �����ϴ� ���� ��ȸ
--16. �����ڵ� ���� �μ� ��ġ�� ���� ���� ���� �̸� ��ȸ



SELECT JOB_NAME FROM JOB;  -- 1��

SELECT * FROM DEPARTMENT;  -- 2��

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE 
FROM EMPLOYEE;  -- 3��

SELECT HIRE_DATE, EMP_NAME, SALARY 
FROM EMPLOYEE;  -- 4��

SELECT EMP_NAME, SAL_LEVEL 
FROM EMPLOYEE 
WHERE SALARY >= 2500000;  -- 5��

SELECT EMP_NAME, PHONE 
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND JOB_CODE = 'J3'; -- 6��

SELECT EMP_NAME AS "�̸�", SALARY * 12 AS "����", SALARY * 12 * (1+BONUS) AS "�Ѽ��ɾ�(���ʽ�����)", (SALARY * 12 * (1+BONUS) -(SALARY*0.3)) AS "�Ǽ��ɾ�"
FROM EMPLOYEE; -- 7��

SELECT EMP_NAME AS "�̸�", SYSDATE - HIRE_DATE AS "�ٹ� �ϼ�" 
FROM EMPLOYEE;  -- 8��

SELECT EMP_NAME AS "�̸�", SALARY AS "����", BONUS AS "���ʽ���", HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > '20/01/01';   -- 9��

SELECT * FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';  -- 10��

SELECT * FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%'; // 11��

SELECT EMP_NAME AS "�̸�" FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��'; // 12��

SELECT EMP_NAME AS "�̸�", PHONE AS "��ȭ��ȣ" 
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%'; // 13��

SELECT * FROM EMPLOYEE
WHERE EMAIL LIKE '____\_%' ESCAPE '\' AND (DEPT_CODE IN ('D6','D9')) AND HIRE_DATE 
BETWEEN '90/01/01' AND '00/12/01' AND SALARY >= 2700000;  // 14��

SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL; // 15��


SELECT * FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL ; // 16��


-- SCOTT/TIGER ������ ���� �� SCOTT_EN ���̺� �߰�



