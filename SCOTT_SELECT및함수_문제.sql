-- 1������
SELECT * FROM EMP
WHERE COMM IS NOT NULL;

-- 2������
SELECT * FROM EMP
WHERE COMM IS NULL;

-- 3�� ����
SELECT * FROM EMP
WHERE MGR IS NULL;

-- 4�� ����
SELECT * FROM EMP
ORDER BY SAL DESC;

-- 5�� ���� (�޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ)
SELECT * FROM EMP
ORDER BY SAL DESC, COMM DESC;

-- 6�� ����
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM EMP
ORDER BY HIREDATE;

-- 7�� ����
SELECT EMPNO, ENAME
FROM EMP
ORDER BY EMPNO DESC;


-- 8��
SELECT EMPNO, HIREDATE, ENAME, DEPTNO
FROM EMP
ORDER BY DEPTNO, HIREDATE DESC;

-- 9�� ���ó�¥�� ���� ���� ��ȸ
SELECT SYSDATE FROM DUAL;


-- 10�� (�޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
SELECT EMPNO, ENAME, TRUNC(SAL,-2)
FROM EMP
ORDER BY SAL DESC;


-- 11�� EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT * FROM EMP
WHERE MOD(EMPNO,2) = 1;


-- 12�� �����, �Ի��� ��ȸ (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
SELECT ENAME, EXTRACT(YEAR FROM HIREDATE)||'�⵵' AS �⵵,
EXTRACT(MONTH FROM HIREDATE)||'��' AS "��"
FROM EMP;


-- 13��  EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
SELECT * FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = '9';


-- 14��  EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ
SELECT * FROM EMP
WHERE SUBSTR(EXTRACT(YEAR FROM HIREDATE),3,2) = 81;


-- 15�� EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
SELECT * FROM EMP
WHERE SUBSTR(ENAME,-1,1) = 'E';


-- 16��  EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
SELECT * FROM EMP
WHERE SUBSTR(ENAME,3,1) = 'R';

SELECT * FROM EMP
WHERE ENAME LIKE '__R%';


-- 17�� EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
SELECT EMPNO, ENAME, HIREDATE, ADD_MONTHS(HIREDATE,480)
FROM EMP;


-- 18�� EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
-- 456���� -> 38��
SELECT * FROM EMP
WHERE FLOOR(MONTHS_BETWEEN(SYSDATE,HIREDATE)) >= 456;


-- 19�� ���� ��¥���� �⵵�� ����
SELECT EXTRACT(YEAR FROM SYSDATE) AS ���س⵵
FROM DUAL;