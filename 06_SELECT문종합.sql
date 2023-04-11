-- ����1 (��������ο� ���� ������� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�. ) �������� �ʰ�!


SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '���������');


-- ����2 (��������ο� ���� ����� �� ���� ������ ���� ����� �̸�,�μ��ڵ�,�޿��� ����Ͻÿ�)
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E1
WHERE DEPT_CODE = (SELECT DEPT_ID FROM DEPARTMENT WHERE DEPT_TITLE = '���������') 
AND SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE JOIN DEPARTMENT ON DEPT_ID =DEPT_CODE WHERE DEPT_TITLE = '���������');




--����3
--�Ŵ����� �ִ� ����߿� ������ ��ü��� ����� �Ѱ� 
--���,�̸�,�Ŵ��� �̸�, ������ ���Ͻÿ�. 
--1. JOIN�� �̿��Ͻÿ�
SELECT E2.EMP_ID, E2.EMP_NAME, E1.EMP_NAME AS "�Ŵ����̸�", E2.SALARY 
    FROM EMPLOYEE E1
    JOIN EMPLOYEE E2 ON E1.EMP_ID = E2.MANAGER_ID
WHERE E2.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);


--2. JOIN���� �ʰ�, ��Į��������(SELECT)�� �̿��ϱ�
SELECT E1.EMP_ID, E1.EMP_NAME, 
(SELECT E2.EMP_NAME FROM EMPLOYEE E2 WHERE E2.EMP_ID = E1.MANAGER_ID) 
, E1.SALARY
FROM EMPLOYEE E1
WHERE E1.MANAGER_ID IS NOT NULL AND E1.SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE) ;



-- ���� 4
--���� ������ ��ձ޿����� ���ų� ���� �޿��� �޴� ������ �̸�, �����ڵ�, �޿�, �޿���� ��ȸ
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;

SELECT E.EMP_NAME AS "�̸�", E.JOB_CODE AS "�����ڵ�", E.SALARY AS "�޿�", E.SAL_LEVEL AS "�޿����"
FROM EMPLOYEE E
    JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE E.SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE WHERE E.JOB_CODE = JOB_CODE);


-- ���� 5
--�μ��� ��� �޿��� 2200000 �̻��� �μ���, ��� �޿� ��ȸ
--��, ��� �޿��� �Ҽ��� ����, �μ����� ���� ��� '����'ó��

SELECT NVL(DEPT_TITLE,'����'), FLOOR(AVG(SALARY)) AS "AVGSAL"
FROM EMPLOYEE 
    LEFT JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
    GROUP BY DEPT_TITLE, 'AVGSAL'
HAVING AVG(SALARY) > 2200000;



--����6
--������ ���� ��պ��� ���� �޴� ���ڻ����
--�����,���޸�,�μ���,������ �̸� ������������ ��ȸ�Ͻÿ�
--���� ��� => (�޿�+(�޿�*���ʽ�))*12    
-- �����,���޸�,�μ���,������ EMPLOYEE ���̺��� ���� ����� ������  
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




