USE sqlDB;
CREATE VIEW v_userTbl
AS
	SELECT userid, name, addr FROM userTbl;

SELECT * FROM v_userTbl;

USE sqlDB;
CREATE VIEW v_userbuyTbl
AS
   SELECT U.userid AS 'USER ID', U.name AS 'USER NAME', B.prodName AS 'PRODUCT NAME', 
		U.addr, CONCAT(U.mobile1, U.mobile2) AS 'MOBILE PHONE'
      FROM userTbl U
	INNER JOIN buyTbl B
	 ON U.userid = B.userid;

SELECT `USER ID`, `USER NAME` FROM v_userbuyTbl;

ALTER VIEW v_userbuyTbl -- 수정
AS
   SELECT U.userid AS '사용자 아이디', U.name AS '이름', B.prodName AS '제품 이름', 
		U.addr, CONCAT(U.mobile1, U.mobile2)  AS '전화 번호'
      FROM userTbl U
          INNER JOIN buyTbl B
             ON U.userid = B.userid ;

SELECT `이름`,`전화 번호` FROM v_userbuyTbl;

DROP VIEW v_userbuyTbl; -- 삭제

USE sqlDB;
CREATE OR REPLACE VIEW v_userTbl
AS
	SELECT userid, name, addr FROM userTbl;

DESCRIBE v_userTbl;

SHOW CREATE VIEW v_userTbl;

UPDATE v_userTbl SET addr = '부산' WHERE userid='JKW' ;

INSERT INTO v_userTbl(userid, name, addr) VALUES('KBM','김병만','충북') ;

select *from v_userTbl;

CREATE VIEW v_sum
AS
	SELECT userid AS 'userid', SUM(price*amount) AS 'total'  
	   FROM buyTbl GROUP BY userid;

SELECT * FROM v_sum;

SELECT * FROM INFORMATION_SCHEMA.VIEWS
     WHERE TABLE_SCHEMA = 'sqlDB' AND TABLE_NAME = 'v_sum';

CREATE VIEW v_height177
AS
	SELECT * FROM userTbl WHERE height >= 177 ;

SELECT * FROM v_height177 ;

DELETE FROM v_height177 WHERE height < 177 ;
INSERT INTO v_height177 VALUES('KBM', '김병만', '경기', '010', '5555555', 158, '2019-01-01') ;
INSERT INTO v_height177 VALUES('KBM', '김병만', '경기', '010', '5555555', 158, '2019-01-01') ;
ALTER VIEW v_height177
AS
	SELECT * FROM userTbl WHERE height >= 177
	    WITH CHECK OPTION ;

INSERT INTO v_height177 VALUES('WDT', '서장훈', '서울', '010', '3333333', 155, '2019-3-3') ;

CREATE VIEW v_userbuyTbl
AS
  SELECT U.userid, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS mobile
   FROM userTbl U
      INNER JOIN buyTbl B
         ON U.userid = B.userid ;

INSERT INTO v_userbuyTbl VALUES('PKL','박경리','운동화','경기','00000000000','2020-2-2');

DROP TABLE IF EXISTS buyTbl, userTbl;

SELECT * FROM v_userbuyTbl;

CHECK TABLE v_userbuyTbl;



