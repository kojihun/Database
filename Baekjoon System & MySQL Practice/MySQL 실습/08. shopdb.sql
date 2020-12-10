DROP DATABASE IF exists sqlDB; 
CREATE DATABASE sqlDB;
USE sqlDB; 

CREATE TABLE userTBL 
( 
    UserID     CHAR(8) NOT NULL , 
    name     VARCHAR(10) NOT NULL, 
    birthYear INT NOT NULL, 
    addr    CHAR(2) NOT NULL, 
    mobile1 CHAR(3), 
    mobile2 CHAR(8), 
    height    SMALLINT, 
    mDate     DATE
    -- email char(30) null unique
);

desc usertbl;

-- 만들어진 테이블 수정
alter table usertbl
	add constraint PK_usertbl_userID
	 primary KEY (userID);

desc usertbl;


CREATE TABLE buyTBL
(
    num INT auto_increment NOT NULL PRIMARY KEY,
    UserID char(8) not null, 
    prodName char(6) not null,  
    groupName char(4),  
    price int not null, 
    amount smallint not null, 
    foreign key (userID) REFERENCES userTBL(userID)
);

alter table buytbl
	alter column groupName Set default '부산';

desc buytbl;

-- 외래 키 제약 조건확인
/*alter table buytbl
	drop foreign key FK_userTbl_buyTbl;*/
    
alter table buytbl
	ADD constraint FK_userTbl_buyTbl
    foreign key(userid)
    references usertbl(userID)
    ON UPDATE CASCADE;

show index from buytbl;

CREATE TABLE prodTbl
(
	prodCode char(3) not null,
    prodID char(4) not null,
    prodDate datetime not null,
    prodCur char(10) null,
    constraint PK_prodTbl_prodcode_prodID
		Primary key(prodcode,prodID)
);
desc prodtbl;

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '11111111', 182, 20080808);
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '22222222', 173, 20120404);
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '33333333', 177, 20070707);
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '44444444', 166, 20090404);
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울',NULL, NULL, 186, 20131212);
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '66666666', 182, 20090909);
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남',NULL, NULL, 170, 20050505);
INSERT INTO usertbl VALUES('EJW', '은지원', 1978, '경북', '011', '88888888', 174, 20140303);
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, 20130505);
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '99999999', 172, 20101010);


INSERT INTO buytbl values(NULL, 'KBS', '운동화', default, 30,2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200, 5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50, 3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80, 10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책', '서적', 15, 5);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책', '서적', 16, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', default, 30, 2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책', '서적', 15, 1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', default, 30, 2);

-- 테이블정보 확인
desc buytbl;
desc usertbl;