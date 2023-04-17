
-- 1번
SELECT COUNT(*) FROM TB_BOOK;
SELECT COUNT(*) FROM TB_WRITER;
SELECT COUNT(*) FROM TB_BOOK_AUTHOR;
SELECT COUNT(*) FROM TB_PUBLISHER;


-- 3번
SELECT BOOK_NO AS "책 번호", BOOK_NM AS "도서명" FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;

--4번
SELECT * 
FROM (SELECT ROWNUM AS RNUM, E.WRITER_NM, E.OFFICE_TELNO, E.HOME_TELNO, E.MOBILE_NO 
FROM (SELECT WRITER_NM, OFFICE_TELNO, HOME_TELNO, MOBILE_NO FROM TB_WRITER
WHERE SUBSTR(MOBILE_NO,1,3) = '019' AND WRITER_NM LIKE '김%'
ORDER BY 1) E)
WHERE RNUM = 1;


--5번
SELECT COUNT(DISTINCT(WRITER_NO)) FROM TB_WRITER 
JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
WHERE COMPOSE_TYPE = '옮김';


-- 6번
SELECT COMPOSE_TYPE, COUNT(*)
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IS NOT NULL
GROUP BY COMPOSE_TYPE
HAVING COUNT(*) >= 300;


-- 7번
SELECT BOOK_NM, ISSUE_DATE, PUBLISHER_NM
FROM TB_BOOK
WHERE SUBSTR(BOOK_NO,1,4) = (SELECT MAX(SUBSTR(BOOK_NO,1,4)) FROM TB_BOOK);


-- 8번
SELECT *
FROM(SELECT WRITER_NM AS "작가 이름", COUNT(*) AS "권 수"
    FROM TB_WRITER
    JOIN TB_BOOK_AUTHOR USING(WRITER_NO) 
    GROUP BY WRITER_NM
    ORDER BY 2 DESC)
WHERE ROWNUM < 4;


-- 9번
UPDATE TB_WRITER W SET REGIST_DATE =  
(SELECT MIN(ISSUE_DATE) 
    FROM TB_BOOK
        JOIN TB_BOOK_AUTHOR USING(BOOK_NO)
        GROUP BY WRITER_NO
        HAVING W.WRITER_NO = WRITER_NO
    );
COMMIT;



-- 10번
CREATE TABLE TB_BOOK_TRANSLATOR(
    BOOK_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_01 REFERENCES TB_BOOK(BOOK_NO) NOT NULL,
    WRITER_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER(WRITER_NO) NOT NULL,
    TRANS_LANG VARCHAR2(60),
    CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);


-- 11번
--도서 저작 형태(compose_type)가 '옮김', '역주', '편역', '공역'에 해당하는 데이터는
--도서 저자 정보 테이블에서 도서 역자 정보 테이블(TB_BOOK_ TRANSLATOR)로 옮기는 SQL 
--구문을 작성하시오. 단, “TRANS_LANG” 컬럼은 NULL 상태로 두도록 한다. (이동된 데이터는 더
--이상 TB_BOOK_AUTHOR 테이블에 남아 있지 않도록 삭제할 것)

INSERT INTO TB_BOOK_TRANSLATOR(BOOK_NO, WRITER_NO)
    (SELECT BOOK_NO, WRITER_NO FROM TB_BOOK_AUTHOR
    WHERE COMPOSE_TYPE IN('옮김','역주','편역','공역'));

DELETE FROM TB_BOOK_AUTHOR WHERE COMPOSE_TYPE IN ('옮김','역주','편역','공역');


-- 12번
-- 2007년도에 출판된 번역서 이름과 번역자(역자)를 표시하는 SQL 구문을 작성하시오
SELECT BOOK_NM, WRITER_NM, ISSUE_DATE 
FROM TB_BOOK
    JOIN TB_BOOK_TRANSLATOR USING(BOOK_NO)
    JOIN TB_WRITER TB_WRITER USING(WRITER_NO)
WHERE SUBSTR(ISSUE_DATE,1,2) = '07';



-- 13번
--12번 결과를 활용하여 대상 번역서들의 출판일을 변경할 수 없도록 하는 뷰를 생성하는 SQL
--구문을 작성하시오. (뷰 이름은 “VW_BOOK_TRANSLATOR”로 하고 도서명, 번역자, 출판일이 표시되도록 할 것)
GRANT CREATE VIEW TO JY; -- JY 계정에게 VIEW 생성 권한 줌

CREATE VIEW VW_BOOK_TRANSLATOR
AS SELECT BOOK_NM, WRITER_NM, ISSUE_DATE 
FROM TB_BOOK
    JOIN TB_BOOK_TRANSLATOR USING(BOOK_NO)
    JOIN TB_WRITER TB_WRITER USING(WRITER_NO)
WHERE SUBSTR(ISSUE_DATE,1,2) = '07' WITH CHECK OPTION;

SELECT * FROM VW_BOOK_TRANSLATOR;



-- 14번
-- 새로운 출판사(춘 출판사)와 거래 계약을 맺게 되었다. 제시된 다음 정보를 입력하는 SQL
-- 구문을 작성하시오.(COMMIT 처리할 것)
INSERT INTO TB_PUBLISHER VALUES('춘 출판사','02-6710-3737',DEFAULT);


-- 15번
-- 동명이인(同名異人) 작가의 이름을 찾으려고 한다. 이름과 동명이인 숫자를 표시하는 SQL 구문을
-- 작성하시오.
SELECT WRITER_NM, COUNT(*)
    FROM TB_WRITER
    GROUP BY WRITER_NM
    HAVING COUNT(*) >=2;
 

-- 16번
-- 도서의 저자 정보 중 저작 형태(compose_type)가 누락된 데이터들이 적지 않게 존재한다. 해당 컬럼이
-- NULL인 경우 '지음'으로 변경하는 SQL 구문을 작성하시오.(COMMIT 처리할 것)
UPDATE TB_BOOK_AUTHOR SET COMPOSE_TYPE = '지음'
    WHERE COMPOSE_TYPE IS NULL;
COMMIT;


-- 17번
-- 서울지역 작가 모임을 개최하려고 한다. 사무실이 서울이고, 사무실 전화 번호 국번이 3자리인 작가의
-- 이름과 사무실 전화 번호를 표시하는 SQL 구문을 작성하시오.
SELECT WRITER_NM, OFFICE_TELNO
    FROM TB_WRITER
    WHERE OFFICE_TELNO LIKE '02-___-%';
 

-- 18번
-- 2006년 1월 기준으로 등록된 지 31년 이상 된 작가 이름을 이름순으로 표시하는 SQL 구문을 작성하시오.
-- 총 372개월임
SELECT WRITER_NM
    FROM TB_WRITER 
    WHERE MONTHS_BETWEEN('06/01/01',REGIST_DATE) >= 372
    ORDER BY 1;


-- 19번
--    요즘 들어 다시금 인기를 얻고 있는 '황금가지' 출판사를 위한 기획전을 열려고 한다. '황금가지' 
--    출판사에서 발행한 도서 중 재고 수량이 10권 미만인 도서명과 가격, 재고상태를 표시하는 SQL 구문을
--    작성하시오. 재고 수량이 5권 미만인 도서는 ‘추가주문필요’로, 나머지는 ‘소량보유’로 표시하고, 
--    재고수량이 많은 순, 도서명 순으로 표시되도록 한다. 
SELECT BOOK_NM AS 도서명, PRICE AS 가격,
    CASE 
        WHEN STOCK_QTY < 5 THEN '추가주문필요'
        ELSE '소량보유'
    END AS 재고상태
FROM TB_BOOK
WHERE PUBLISHER_NM = '황금가지' AND STOCK_QTY < 10
ORDER BY STOCK_QTY DESC, 1 ASC; 


-- 20번
-- '아타트롤' 도서 작가와 역자를 표시하는 SQL 구문을 작성하시오. (결과 헤더는 ‘도서명’,’저자’,’역자’로 표시할 것)
SELECT BOOK_NM AS 도서명, WRITER_NM AS 저자,
        (SELECT WRITER_NM
            FROM TB_BOOK_TRANSLATOR 
                JOIN TB_WRITER USING (WRITER_NO)
                JOIN TB_BOOK USING (BOOK_NO)
                WHERE BOOK_NM = '아타트롤') AS 역자
FROM TB_BOOK
        JOIN TB_BOOK_TRANSLATOR USING(BOOK_NO)
        JOIN TB_WRITER USING(WRITER_NO)
WHERE BOOK_NM = '아타트롤'
UNION
SELECT BOOK_NM, WRITER_NM,  
                (SELECT WRITER_NM
                      FROM TB_BOOK_TRANSLATOR 
                      JOIN TB_WRITER USING (WRITER_NO)
                      JOIN TB_BOOK USING (BOOK_NO)
                      WHERE BOOK_NM = '아타트롤')
    FROM TB_BOOK
    JOIN TB_BOOK_AUTHOR USING(BOOK_NO)
    JOIN TB_WRITER USING(WRITER_NO)
WHERE BOOK_NM = '아타트롤';



-- 21번
--    현재 기준으로 최초 발행일로부터 만 30년이 경과되고, 재고 수량이 90권 이상인 도서에 대해 도서명, 재고
--    수량, 원래 가격, 20% 인하 가격을 표시하는 SQL 구문을 작성하시오. (결과 헤더는 “도서명”, “재고
--    수량”, “가격(Org)”, “가격(New)”로 표시할 것. 재고 수량이 많은 순, 할인 가격이 높은 순, 도서명 순으로 표시되도록 할 것)

SELECT BOOK_NM AS "도서명", STOCK_QTY AS "재고 수량", TO_CHAR(PRICE,'999,999') AS "가격(Org)", TO_CHAR(PRICE*0.8,'999,999') AS "가격(New)"
    FROM TB_BOOK
    WHERE MONTHS_BETWEEN(SYSDATE,ISSUE_DATE) >= 12*30
     AND STOCK_QTY >=90;
    
    
    
SELECT * FROM TB_BOOK_TRANSLATOR;
SELECT * FROM TB_BOOK;
SELECT * FROM TB_WRITER;
SELECT * FROM TB_BOOK_AUTHOR;
SELECT * FROM TB_PUBLISHER;




