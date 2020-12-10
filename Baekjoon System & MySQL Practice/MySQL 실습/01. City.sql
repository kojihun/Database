drop table if exists city;

create table city
(ID int not null primary key,
NAME varchar(17) not null,
COUNTRYCODE varchar(3) not null,
DISTRICT varchar(20) not null,
POPULATION int not null
);

-- 테이블에 데이터 저장후 확인
insert into city values (6,'Rotterdam','NLD','Zuid-Holland',593321);
insert into city values (3878,'Scottsdale','USA','Arizona',202705);
insert into city values (3965,'Corona','USA','California',124966);
insert into city values (3973,'Concord','USA','California',121780);
insert into city values (3977,'Cedar Rapids','USA','Iowa',120758);
insert into city values (3982,'Coral Springs','USA','Florida',117549);
insert into city values (4054,'Fairfield','USA','California',92256);
insert into city values (4058,'Boulder','USA','Colorado',91238);
insert into city values (4061,'Fall River','USA','Messachusetts',90555);

SELECT * FROM aftermidterm.city;

-- 인구가 12만이상인 USA의 도시를 구하는 Query문
SELECT * FROM aftermidterm.city where POPULATION>120000 and COUNTRYCODE ='USA';

LOAD DATA LOCAL INFILE 'C:/temp/city.txt' into table aftermidterm.city fields terminated by ','(ID, NAME , COUNTRYCODE, DISTRICT, POPULATION) ;
-- ENCLOSED BY ' ' LINES TERMINATED BY '\n';

-- ID가 1661인 투플찾기
SELECT *FROM aftermidterm.city where ID=1661;

-- 일본의 도시이름을 출력
SELECT DISTRICT, COUNTRYCODE from aftermidterm.city where COUNTRYCODE = 'JPN';


-- 국가별 city의 갯수
SELECT COUNTRYCODE, DISTRICT from aftermidterm.city order by COUNTRYCODE;
select COUNTRYCODE, count(DISTINCT DISTRICT) from aftermidterm.city group by countrycode;

-- 국가별 인구 수
select countrycode, sum(POPULATION) from aftermidterm.city group by COUNTRYCODE;


