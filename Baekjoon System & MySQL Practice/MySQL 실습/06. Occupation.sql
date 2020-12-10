drop table if exists occupation;

create table occupation(
Name varchar(50),
Occupation varchar(50)
);

LOAD DATA LOCAL INFILE 'C:/temp/occupation.txt' into table aftermidterm.occupation fields terminated by ' '(Name,Occupation) ;

select * from aftermidterm.occupation order by name;

-- 각 이름 뒤에 괄호 안에 직업의 첫글자를 함께 출력
select concat(Name,'(',left(occupation,1),')') as '이름(직업의 첫글자)' from aftermidterm.occupation order by Name;

-- 각 직업의 발생 수를 함께 출력, 발생 개수로 오름차순 하기

SELECT
		COUNT(IF(occupation='actor',1, NULL)) AS 'actor'
        ,COUNT(IF(occupation='professor',1, NULL)) AS 'professor'
        ,COUNT(IF(occupation='Doctor',1, NULL)) AS 'Doctor'
        ,COUNT(IF(occupation='singer',1, NULL)) AS 'singer'
FROM occupation group by occupation order by count(occupation);

select occupation,count(occupation) as '갯수' from occupation group by occupation order by count(occupation);