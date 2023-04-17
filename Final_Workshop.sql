
-- 1��
SELECT COUNT(*) FROM TB_BOOK;
SELECT COUNT(*) FROM TB_WRITER;
SELECT COUNT(*) FROM TB_BOOK_AUTHOR;
SELECT COUNT(*) FROM TB_PUBLISHER;


-- 3��
SELECT BOOK_NO AS "å ��ȣ", BOOK_NM AS "������" FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

--4��
SELECT * 
FROM (SELECT ROWNUM AS RNUM, E.WRITER_NM, E.OFFICE_TELNO, E.HOME_TELNO, E.MOBILE_NO 
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019' AND WRITER_NM LIKE '��%'
ORDER BY 1) E)
WHERE RNUM = 1;


--5��
SELECT COUNT(DISTINCT(WRITER_NO)) FROM TB_WRITER 
JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
WHERE COMPOSE_TYPE = '�ű�';


-- 6��
SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300;


-- 7��
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM TB_BOOK
WHERE SUBSTR(BOOK_NO,1,4) = (SELECT MAX(SUBSTR(BOOK_NO,1,4)) FROM TB_BOOK);


-- 8��
SELECT *
FROM(SELECT WRITER_NM AS "�۰� �̸�", COUNT(*) AS "�� ��"
    FROM TB_WRITER
    JOIN TB_BOOK_AUTHOR USING(WRITER_NO) 
    GROUP BY WRITER_NM
    ORDER BY 2 DESC)
WHERE ROWNUM < 4;


-- 9��
UPDATE TB_WRITER W SET REGIST_DATE =  
(SELECT MIN(ISSUE_DATE) 
    FROM TB_BOOK
        JOIN TB_BOOK_AUTHOR USING(BOOK_NO)
        GROUP BY WRITER_NO
        HAVING W.WRITER_NO = WRITER_NO
    );
COMMIT;



-- 10��
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK(BOOK_NO) NOT NULL,
    WRITER_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER(WRITER_NO) NOT NULL,
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);


-- 11��
--���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
--���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL 
--������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� ��
--�̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)

INSERT INTO TB_BOOK_TRANSLATOR(BOOK_NO, WRITER_NO)
    (SELECT BOOK_NO, WRITER_NO FROM TB_BOOK_AUTHOR
    WHERE COMPOSE_TYPE IN('�ű�','����','��','����'));

DELETE FROM TB_BOOK_AUTHOR WHERE COMPOSE_TYPE IN ('�ű�','����','��','����');


-- 12��
-- 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�
SELECT BOOK_NM, WRITER_NM, ISSUE_DATE 
FROM TB_BOOK
    JOIN TB_BOOK_TRANSLATOR USING(BOOK_NO)
    JOIN TB_WRITER TB_WRITER USING(WRITER_NO)
WHERE SUBSTR(ISSUE_DATE,1,2) = '07';



-- 13��
--12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
--������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, �������� ǥ�õǵ��� �� ��)
GRANT CREATE VIEW TO JY; -- JY �������� VIEW ���� ���� ��

CREATE VIEW VW_BOOK_TRANSLATOR
AS SELECT BOOK_NM, WRITER_NM, ISSUE_DATE 
FROM TB_BOOK
    JOIN TB_BOOK_TRANSLATOR USING(BOOK_NO)
    JOIN TB_WRITER TB_WRITER USING(WRITER_NO)
WHERE SUBSTR(ISSUE_DATE,1,2) = '07' WITH CHECK OPTION;

SELECT * FROM VW_BOOK_TRANSLATOR;



-- 14��
-- ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL
-- ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
INSERT INTO TB_PUBLISHER VALUES('�� ���ǻ�','02-6710-3737',DEFAULT);


-- 15��
-- ��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�.
SELECT WRITER_NM, COUNT(*)
    FROM TB_WRITER
    GROUP BY WRITER_NM
    HAVING COUNT(*) >=2;
 

-- 16��
-- ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷���
-- NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
UPDATE TB_BOOK_AUTHOR SET COMPOSE_TYPE = '����'
    WHERE COMPOSE_TYPE IS NULL;
COMMIT;


-- 17��
-- �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰���
-- �̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT WRITER_NM, OFFICE_TELNO
    FROM TB_WRITER
    WHERE OFFICE_TELNO LIKE '02-___-%';
 

-- 18��
-- 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- �� 372������
SELECT WRITER_NM
    FROM TB_WRITER 
    WHERE MONTHS_BETWEEN('06/01/01',REGIST_DATE) >= 372
    ORDER BY 1;


-- 19��
--    ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
--    ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
--    �ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
--    �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�. 
SELECT BOOK_NM AS ������, PRICE AS ����,
    CASE 
        WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�'
        ELSE '�ҷ�����'
    END AS ������
FROM TB_BOOK
WHERE PUBLISHER_NM = 'Ȳ�ݰ���' AND STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, 1 ASC; 


-- 20��
-- '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������,�����ڡ�,�����ڡ��� ǥ���� ��)
SELECT BOOK_NM AS ������, WRITER_NM AS ����,
        (SELECT WRITER_NM
            FROM TB_BOOK_TRANSLATOR 
                JOIN TB_WRITER USING (WRITER_NO)
                JOIN TB_BOOK USING (BOOK_NO)
                WHERE BOOK_NM = '��ŸƮ��') AS ����
FROM TB_BOOK
        JOIN TB_BOOK_TRANSLATOR USING(BOOK_NO)
        JOIN TB_WRITER USING(WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��'
UNION
SELECT BOOK_NM, WRITER_NM,  
                (SELECT WRITER_NM
                      FROM TB_BOOK_TRANSLATOR 
                      JOIN TB_WRITER USING (WRITER_NO)
                      JOIN TB_BOOK USING (BOOK_NO)
                      WHERE BOOK_NM = '��ŸƮ��')
    FROM TB_BOOK
    JOIN TB_BOOK_AUTHOR USING(BOOK_NO)
    JOIN TB_WRITER USING(WRITER_NO)
WHERE BOOK_NM = '��ŸƮ��';



-- 21��
--    ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
--    ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, �����
--    ������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������ ������ ǥ�õǵ��� �� ��)

SELECT BOOK_NM AS "������", STOCK_QTY AS "��� ����", TO_CHAR(PRICE,'999,999') AS "����(Org)", TO_CHAR(PRICE*0.8,'999,999') AS "����(New)"
    FROM TB_BOOK
    WHERE MONTHS_BETWEEN(SYSDATE,ISSUE_DATE) >= 12*30
     AND STOCK_QTY >=90;
    
    
    
SELECT * FROM TB_BOOK_TRANSLATOR;
SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_PUBLISHER;




