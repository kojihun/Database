drop table if exists station;

create table station
(ID int not null primary key,
CITY varchar(21) not null,
STATE varchar(2) not null,
LAT_N int not null,
LONG_W int not null
);

LOAD DATA LOCAL INFILE 'C:/temp/station.txt' into table aftermidterm.station fields terminated by ','(ID, CITY , STATE, LAT_N, LONG_W) ;

-- ID가 짝수인 city이름을 중복되지 않도록 질의하는 SQL문 작성
select  distinct ID , CITY from aftermidterm.station where ID%2=0;

-- city 전체 목록의 수와 중복된 city목록을 제외한 수의 차를 구하는 SQL문
select count(ID), count(DISTINCT CITY) from aftermidterm.station;
select sum((select count(ID) from aftermidterm.station)-(select count(distinct CITY) from aftermidterm.station));

SET @X = (select city from aftermidterm.station where char_length(CITY) = (select  MIN(CHAR_LENGTH(CITY)) from aftermidterm.station) order by city limit 1);
SET @Y = (select city from aftermidterm.station where char_length(CITY) = (select MAX(CHAR_LENGTH(CITY)) from aftermidterm.station));
select @X as'MIN',@Y as 'MAX';

select MIN(CHAR_LENGTH(CITY)),MAX(CHAR_LENGTH(CITY)) from aftermidterm.station order by city;

-- a,e,i,o,u 로 시작하는 city이름
select distinct city from aftermidterm.station where city REGEXP  ('^a|^e|^i|^o|^u') order by city;

-- a,e,i,o,u 로 끝나는 city이름
select distinct city from aftermidterm.station where city REGEXP  ('a$|e$|i$|o$|u$') order by city;

-- a,e,i,o,u로 시작하고 a,e,i,o,u로 끝나는 city이름
select distinct city from aftermidterm.station where city REGEXP  ('^a|^e|^i|^o|^u')  and city REGEXP  ('a$|e$|i$|o$|u$') order by city;

-- 자음으로 시작하는 city이름
select distinct city from aftermidterm.station where city not REGEXP  ('^a|^e|^i|^o|^u') order by city;

-- 자음으로 끝나는 city이름
select distinct city from aftermidterm.station where city not REGEXP  ('a$|e$|i$|o$|u$') order by city;

-- 자음으로 시작하고 자음으로 끝나는 city이름
select distinct city from aftermidterm.station where city not REGEXP  ('^a|^e|^i|^o|^u')  and city not REGEXP  ('a$|e$|i$|o$|u$') order by city;



