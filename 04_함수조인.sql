
-- 1������
SELECT EMP_NAME, EMAIL, LENGTH(EMAIL)
FROM EMPLOYEE;

-- 3������
SELECT EMP_NAME, SUBSTR(EMP_NO,1,2), NVL(BONUS,0)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,1,2) BETWEEN 60 AND 69; 


-- 4������
SELECT COUNT(*)||'��' AS "�ڵ��� ���� �ο� ��" FROM EMPLOYEE
WHERE PHONE IS NULL;


--5������ (������� �Ի����� ����Ͻÿ� )
SELECT EMP_NAME AS "������", 
EXTRACT(YEAR FROM HIRE_DATE)||'�� '||EXTRACT(MONTH FROM HIRE_DATE)||'��' AS "�Ի���"
FROM EMPLOYEE;


--6������ ������� �ֹι�ȣ�� ��ȸ�Ͻÿ�
SELECT EMP_NAME AS "������",
RPAD(SUBSTR(EMP_NO,1,8),LENGTH(EMP_NO),'*')
FROM EMPLOYEE;


-- 7������
SELECT EMP_NAME AS "������", DEPT_CODE AS "�����ڵ�",
TO_CHAR(SALARY*12*(1+NVL(BONUS,0)),'L999,999,999')
FROM EMPLOYEE;


--8������    �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� �����߿� ��ȸ
SELECT EMP_NO, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D9') AND SUBSTR(HIRE_DATE,1,2) = '04'; 


--9������
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) AS "�ٹ��ϼ�"
FROM EMPLOYEE;


--11. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�. ���������� ��ü�������� ���Ͻÿ�
--	-------------------------------------------------------------------------
--	 1998��   1999��   2000��   2001��   2002��   2003��   2004��  ��ü������
--	-------------------------------------------------------------------------
SELECT COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'1998',0)) AS "1998��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'1999',0)) AS "1999��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2000',0)) AS "2000��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2001',0)) AS "2001��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2002',0)) AS "2002��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2003',0)) AS "2003��",
COUNT(DECODE(TO_CHAR(HIRE_DATE,'YYYY'),'2004',0)) AS "2004��",
COUNT(*) AS "��ü ������"
FROM EMPLOYEE;


-- 12��
--   �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.(case ���)
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ�ϰ�, �μ��ڵ� �������� �������� ������.
SELECT EMP_NAME, 
CASE
    WHEN DEPT_CODE ='D5' THEN '�ѹ���'
    WHEN DEPT_CODE ='D6' THEN '��ȹ��'
    WHEN DEPT_CODE ='D9' THEN '������'
END
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY DEPT_CODE ASC;


-- 13�� EMPLOYEE ���̺��� ������ J1�� �����ϰ�, ���޺� ����� �� ��ձ޿��� ���
SELECT COUNT(*) "���޺� �����" , AVG(SALARY) AS "��ձ޿�"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY JOB_CODE;

-- 14�� EMPLOYEE���̺��� ������ J1�� �����ϰ�,  �Ի�⵵�� �ο����� ��ȸ�ؼ�, �Ի�� �������� �������� ����
SELECT COUNT(*) AS "�λ�⵵�� �ο���"
FROM EMPLOYEE
WHERE JOB_CODE != 'J1'
GROUP BY HIRE_DATE
ORDER BY HIRE_DATE ASC;


-- 15��
--[EMPLOYEE] ���̺��� EMP_NO�� 8��° �ڸ��� 1, 3 �̸� '��', 2, 4 �̸� '��'�� ����� ��ȸ�ϰ�,
-- ������ �޿��� ���(����ó��), �޿��� �հ�, �ο����� ��ȸ�� �� �ο����� ���������� ���� �Ͻÿ�
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'��',2,'��',3,'��',4,'��') AS "����",
FLOOR(AVG(SALARY)) AS "������ �޿��� ���", SUM(SALARY) AS "�޿��� �հ�", COUNT(*) AS "�ο���"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1,'��',2,'��',3,'��',4,'��')
ORDER BY  COUNT(*) DESC;


-- 16�� �μ��� ���� �ο����� ���ϼ���.
SELECT DEPT_CODE, COUNT(*) AS "�ο���"
FROM EMPLOYEE
GROUP BY DEPT_CODE, DECODE(SUBSTR(EMP_NO,8,1),1,'��',2,'��',3,'��',4,'��');


-- 17�� --�μ��� �ο��� 3���� ���� �μ��� �ο����� ����ϼ���.
SELECT DEPT_CODE AS "�μ���", COUNT(*) AS "�ο���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*) >=3;


-- 18�� --�μ��� ���޺� �ο����� 3���̻��� ������ �μ��ڵ�, �����ڵ�, �ο����� ���
SELECT DEPT_CODE, JOB_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE
HAVING COUNT(*) >=3;


-- 19�� --�Ŵ����� �����ϴ� ����� 2���̻��� �Ŵ������̵�� �����ϴ� ������� ���
SELECT MANAGER_ID AS "�Ŵ������̵�", COUNT(*) AS "�����"
FROM EMPLOYEE
GROUP BY MANAGER_ID
HAVING COUNT(*) >=2;


-- 20�� --�μ���� �������� ����ϼ���. DEPARTMENT, LOCATION ���̺� �̿�.
SELECT DEPT_TITLE AS "�μ���", LOCAL_NAME AS "������"
FROM DEPARTMENT
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;


-- 21�� --������� �������� ����ϼ���. LOCATION, NATION ���̺�
SELECT LOCAL_NAME AS "������", NATIONAL_NAME AS "������"
FROM LOCATION L
    JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE;


-- 22�� --������� �������� ����ϼ���. LOCATION, NATIONAL ���̺��� �����ϵ� USING�� ����Ұ�.
SELECT LOCAL_NAME AS "������", NATIONAL_NAME AS "������"
FROM LOCATION
    JOIN NATIONAL USING(NATIONAL_CODE);


SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;