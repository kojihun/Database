-- 임시테이블
use employees;

create temporary table if not exists tempTBL(id INT, name char(5));
create temporary table if not exists employees(id INT, name char(5));

describe tempTBL;
describe employees;

insert into tempTBL values (1,'this');
insert into employees values(2, 'mySQL');

select*from tempTBL;
select*from employees;

-- 테이블 삭제 구문
drop table temptbl;

-- 열 추가
USE sqlDB;
ALTER TABLE userTbl
	ADD homepage VARCHAR(30)  -- FIRST or AFTER열이름 제일앞에 추가가 되거나, 열이름 뒤에 추가 기본적으로는 가장뒤에 추가
		DEFAULT 'http://www.hanbit.co.kr'
		NULL; -- Null 허용함

ALTER TABLE userTbl
	DROP COLUMN mobile1;

ALTER TABLE userTbl
	CHANGE COLUMN name uName VARCHAR(20) NULL ;

ALTER TABLE userTbl
	DROP PRIMARY KEY; -- userID열은 buyTBL의 외래키로 연결되어 있기 때문에 외래키를 제거한후 프라이머리키를 제거해야함

ALTER TABLE buyTbl
	DROP FOREIGN KEY buytbl_ibfk_1;
    
    
USE sqlDB;
DROP TABLE IF EXISTS buyTbl, userTbl;
CREATE TABLE userTbl 
( userID  char(8), 
  name    nvarchar(10),
  birthYear   int,  
  addr	  nchar(2), 
  mobile1	char(3), 
  mobile2   char(8), 
  height    smallint, 
  mDate    date 
);
CREATE TABLE buyTbl 
(  num int AUTO_INCREMENT PRIMARY KEY,
   userid  char(8),
   prodName nchar(6),
   groupName nchar(4),
   price     int ,
   amount    smallint
);

INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', NULL, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1871, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');

INSERT INTO buyTbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL,'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(NULL,'JYP', '모니터', '전자', 200,  1);
INSERT INTO buyTbl VALUES(NULL,'BBK', '모니터', '전자', 200,  5);


ALTER TABLE userTbl-- primary key로 지정하면 자동으로 not null
	ADD CONSTRAINT PK_userTbl_userID
	PRIMARY KEY (userID);

DESC userTbl;

ALTER TABLE buyTbl
	ADD CONSTRAINT FK_userTbl_buyTbl
	FOREIGN KEY (userID)
	REFERENCES userTbl (userID);

SET SQL_SAFE_UPDATES = 0; -- safeupdate error 해결책

DELETE FROM buyTbl WHERE userid = 'BBK';
ALTER TABLE buyTbl
	ADD CONSTRAINT FK_userTbl_buyTbl
	FOREIGN KEY (userID)
	REFERENCES userTbl (userID);

INSERT INTO buyTbl VALUES(NULL,'BBK', '모니터', '전자', 200,  5);

SET foreign_key_checks = 0;
INSERT INTO buyTbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buyTbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buyTbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buyTbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buyTbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
SET foreign_key_checks = 1;

ALTER TABLE userTbl
	ADD CONSTRAINT CK_birthYear
	CHECK  (birthYear >= 1900 AND birthYear <= YEAR(CURDATE())) ;

INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL , 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL , 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');

UPDATE userTbl SET userID = 'VVK' WHERE userID='BBK';

SET foreign_key_checks = 0;
UPDATE userTbl SET userID = 'VVK' WHERE userID='BBK';
SET foreign_key_checks = 1;

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2  AS '연락처'
   FROM buyTbl B
     INNER JOIN userTbl U
        ON B.userid = U.userid ;

SELECT COUNT(*) FROM buyTbl;

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2  AS '연락처'
   FROM buyTbl B
     LEFT OUTER JOIN userTbl U
        ON B.userid = U.userid
   ORDER BY B.userid ;

SET foreign_key_checks = 0;
UPDATE userTbl SET userID = 'BBK' WHERE userID='VVK';
SET foreign_key_checks = 1;

ALTER TABLE buyTbl
	DROP FOREIGN KEY FK_userTbl_buyTbl;
ALTER TABLE buyTbl 
	ADD CONSTRAINT FK_userTbl_buyTbl
		FOREIGN KEY (userID)
		REFERENCES userTbl (userID)
		ON UPDATE CASCADE
        ON DELETE CASCADE;-- 밑에 삭제가 되지 않아 구문 추가

UPDATE userTbl SET userID = 'VVK' WHERE userID='BBK';

SELECT B.userid, U.name, B.prodName, U.addr, U.mobile1 + U.mobile2  AS '연락처'
   FROM buyTbl B
     INNER JOIN userTbl U
        ON B.userid = U.userid
  ORDER BY B.userid;

DELETE FROM userTbl WHERE userID = 'VVK';  -- 외래키 재약조건 때문에 삭제가 되지 않음

DELETE FROM userTbl WHERE userID = 'VVK';
SELECT * FROM buyTbl ;

ALTER TABLE userTbl
	DROP COLUMN birthYear ;


