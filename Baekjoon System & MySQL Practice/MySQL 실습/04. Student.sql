drop table if exists student;

create table student (
ID INT not null primary key,
Name varchar(50) not null,
Marks INT not null
);

LOAD DATA LOCAL INFILE 'C:/temp/student.txt' into table aftermidterm.student fields terminated by ' '(ID, Name ,Marks) ;

-- 75점이상 학생이름 정의 이름 마지막 3글자 오름차순 정렬 같을경우 ID 오름차순 정렬 keep
select * from student where marks >= 75 order by right(Name,3) ASC, ID ASC;

-- 평균점수 
select avg(marks) as '평균점수' from aftermidterm.student;

-- 90점,80점,70점,60점 학생목록

select Name,marks as '점수',
	case
    when (marks>90) then '90점이상'
    when (marks between 80 and 90) then '80점이상'
    when (marks between 70 and 80) then '70점이상'
    when (marks between 60 and 70) then '60점이상'
    when (marks <60) then '60점미만'
	End as '점수대 등급'
from aftermidterm.student order by marks;
