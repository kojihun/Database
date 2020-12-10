-- 1번
create database finalExam;
use finalExam;

-- 2번

create table customs
(
	customer_num INT,
    f_name varchar(10) not null,
    l_name varchar(10) not null,
    phone_number varchar(30) primary key
);

insert into customs values (100,'홍','길동','051-890-1111');
insert into customs values (100,'홍','길동','051-890-1212');
insert into customs values (200,'김','철수','051-890-2222');
insert into customs values (300,'이','영희','051-890-3333');


-- 3번
/*갱신 이상 기술을 알려주는 종업원이 다른 종업원으로 대체가 되면 그 종업원이 담당하고 있는 모든 기술이 바뀌는 것이 아닌 하나의 기술에 대해서만 변경이 된다.*/
create table employee_name
(
	employee varchar(20) primary key
);

insert into employee_name values ('Jones');
insert into employee_name values ('Bravo');
insert into employee_name values ('Ellis');
insert into employee_name values ('Harrison');

create table employee_teq
(
	employee_teqn varchar(20) primary key
);

insert into employee_teq values('Typing');
insert into employee_teq values('Shorthand');
insert into employee_teq values('Whittling');
insert into employee_teq values('Light Cleaning');
insert into employee_teq values('Alchemy');
insert into employee_teq values('Flying');

create table employees
(
	employee_name varchar(20),
    employee_teq varchar(20) not null,
    workspace varchar(30) not null,
    foreign key (employee_name) references employee_name(employee)
    on update cascade,
    foreign key (employee_teq) references employee_teq(employee_teqn)
    on update cascade
);

insert into employees values ('Jones','Typing','114 Main Street');
insert into employees values ('Jones','Shorthand','114 Main Street');
insert into employees values ('Jones','Whittling','114 Main Street');
insert into employees values ('Bravo','Light Cleaning','73 Industrial Way');
insert into employees values ('Ellis','Alchemy','73 Industrial Way');
insert into employees values ('Ellis','Flying','73 Industrial Way');
insert into employees values ('Harrison','Light Cleaning','73 Industrial Way');

-- Light Cleaning을 담당하고 있는 Bravo가 Jihun으로 바뀔 경우
update employee_name set employee = 'Jihun' where employee = 'Harrison';
-- Flying과 Alchemy를 담당하고 있는 Ellis가 SeoungChol로 바뀔 경우
update employee_name set employee = 'SeoungChol' where employee = 'Ellis';
-- Jones의 Typing과목이 폐강되고 computer로 바뀔 경우
update employee_teq set employee_teqn = 'computer' where employee_teqn = 'Typing';

-- 4번
create table festival_winner
(
	E_name varchar(30) primary key,
    birth varchar(50) not null
);

insert into festival_winner values ('Chip Masterson','14 March 1977');
insert into festival_winner values ('Al Fredrickson','21 March 1977');
insert into festival_winner values ('Bob Albertson','28 March 1977');

create table festival
(
	F_name varchar(30),
    F_year INT not null,
    F_winner varchar(30),
    foreign key (F_winner) references festival_winner(E_name)
    on update cascade
);

insert into festival values ('Des Moines Master',1988,'Chip Masterson');
insert into festival values ('Indiana Invitational',1988,'Al Fredrickson');
insert into festival values ('Cleveland Open',1999,'Bob Albertson');
insert into festival values ('Des Moines Master',1999,'Al Fredrickson');
insert into festival values ('Indiana Invitational',1999,'Chip Masterson');

select festival.F_name, festival.F_year, festival.F_winner,festival_winner.birth from festival
	inner join festival_winner On festival.F_winner=festival_winner.E_name order by F_year;
    
-- 우승자가 바뀔 경우
update festival set F_winner = 'Al Fredrickson' where F_winner = 'Chip Masterson' and F_year = 1988;

-- 5번
create table students
(
	num INT primary key,
    name varchar(30),
    grade INT,
    class varchar(30)
);
insert into students values (100, '김길동', 4, '컴퓨터공학');
insert into students values (200, '이길동', 3, '게임공학');
insert into students values (300, '박길동', 1, '컴퓨터소프트웨어공학');
insert into students values (400, '최길동', 4, '건축공학');
insert into students values (500, '송길동', 2, '수학');

create table course
(
	c_num varchar(30) primary key,
    c_name varchar(30),
    c_socore INT,
    class varchar(30),
    professer varchar(10)
);

insert into course values ('C123','프로그래밍기초',3,'컴퓨터공학','이교수');
insert into course values ('C312','자료구조',3,'컴퓨터공학','홍교수');
insert into course values ('C324','알고리즘',3,'컴퓨터공학','박교수');
insert into course values ('C413','데이터베이스',3,'컴퓨터공학','김교수');
insert into course values ('E412','미적분학',3,'전자공학','최교수');

create table score
(
	num INT,
    c_num varchar(30),
    degree varchar(10),
    midtest INT,
    fintest INT,
    foreign key (num) references students(num),
    foreign key (c_num) references course(c_num)
);

insert into score values (100,'C413','A',90,95);
insert into score values (100,'E412','A',95,95);
insert into score values (200,'C123','B',85,80);
insert into score values (300,'C312','A',90,95);
insert into score values (300,'C324','C',75,75);
insert into score values (300,'C413','A',95,90);
insert into score values (400,'C312','A',90,95);
insert into score values (400,'C324','A',95,90);
insert into score values (400,'C413','B',80,85);
insert into score values (500,'C312','B',85,80);

-- 최길동 학생의 학번을 검색
select num as '학번',name from students where name = '최길동';
-- 과목번호가 C로 시작하는 과목을 수강하는 학생들 학번 검색
select num,c_num from score where c_num LIKE 'C%';
-- 컴퓨터 공학과 학생 수 검색
select count(num) as '학생 수' from students where class = '컴퓨터공학';
-- 학생별 중간고사 최대값을 이름 오름차순으로 정렬
select students.name , MAX(score.midtest) from score inner join students on score.num = students.num group by students.name;
-- 400번 학생의 기말고사 성적으로 오름차순 검색
select num,fintest from score where num=400 order by fintest desc;
-- 프로그래밍 기초를 수강하는 학생이름 검색

-- 각 과목별 중간고사 평균
select c_num, avg(fintest) from score group by c_num;
