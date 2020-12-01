
/* create문 */
create table event(
  event_type varchar(20) ,
  event_product  int ,
  event_contant  varchar(20) ,
  event_startday date , 
  event_endday date , 
  
  CONSTRAINT eventProduct_fk FOREIGN KEY (event_product) REFERENCES distribution(product_id),
  CONSTRAINT eventType_pk PRIMARY KEY(event_type)
  
);

create table distribution(
  product_id int ,
  product_category  varchar(20) ,
  product_name  varchar(20) ,
  product_price int , 
  product_expire date , 
  product_count int , 
  product_event int ,
  
  CONSTRAINT productId_pk PRIMARY KEY(product_id)
);

create table delivery(
  Hproduct_id int,
  Hproduct_category varchar(20),
  Hproduct_name varchar(20),
  Hproduct_count int,
  Hproduct_expire date,
  Hproduct_price int,
  
  CONSTRAINT HproductId_pk PRIMARY KEY (Hproduct_id)
);

create table cardEvent(
  card_type varchar(20),
  card_discout int,
  card_startday date,
  card_endday date,
  
  CONSTRAINT cardType_pk PRIMARY KEY (card_type)
);


create table delivery(
  Hproduct_id int,
  Hproduct_category varchar(20),
  Hproduct_name varchar(20),
  Hproduct_count int,
  Hproduct_expire date,
  Hproduct_price int,
  
  CONSTRAINT HproductId_pk PRIMARY KEY (Hproduct_id)
);

create table refrige(
  customer_id varchar(20),
  refrige_id varchar(20),
  ref_productname varchar(20),
  ref_count varchar(20),
  ref_price varchar(20),
  
  CONSTRAINT customerIdRefrigeId_pk PRIMARY KEY (customer_id, refrige_id),
  CONSTRAINT customerId_fk FOREIGN KEY (customer_Id) REFERENCES customer(customer_id)
);

create table customer(
  customer_id varchar(20),
  customer_tel varchar(20),
  customer_ref int,
  
  CONSTRAINT customerId_pk PRIMARY KEY (customer_id)
);


create table manager
(
  staff_grade varchar(30),
  staff_salary int not null,
  staff_bonus int,
  constraint staffGrade_pk primary key (staff_grade)
);

create table emergencyCall
(
  emergency_id int,
  emergency_name varchar(30) not null,
  emergency_num varchar(30) not null,
  constraint emergencyId_pk primary key (emergency_id)
);

create table employee
(
  staff_grade varchar(30),
  staff_id varchar(30),
  staff_name varchar(10) not null,
  staff_age varchar(10) not null,
  staff_sex varchar(10) not null,
  staff_attendence date not null,
  staff_acnum varchar(30) not null,
  staff_addr varchar(50) not null,
  staff_tel varchar(30) not null,
  constraint staffId_pk primary key (staff_id),
  constraint staffGrade_fk foreign key (staff_grade) references manager(staff_grade)
);

create table branchOffice
(
  office_head varchar(30),
  office_num varchar(30),
  office_location varchar(30),
  constraint officeLocation_pk primary key (office_location),
  constraint officeHead_fk foreign key (office_head) references employee(staff_id)
);


/* view 테이블 형성 */

create or eplace view del_dis
as 
select del.HPRODUCT_CATEGORY, del.HPRODUCT_NAME
from distribution dis, delivery del
where del.Hproduct_id = dis.product_id(+) and dis.PRODUCT_ID is null;

create view owner_location as select employee.staff_id, employee.staff_name, employee.staff_sex, branchoffice.office_location from employee inner join branchoffice on employee.staff_id = branchoffice.OFFICE_HEAD; 


/* insert */

insert into distribution values ( 201911, 'snack','snackstick', 1500, '2019/12/20', 30, 1);
insert into distribution values ( 201912, 'snack','chocostick', 1000, '2019/12/20', 25, 1);
insert into distribution values ( 201921, 'lunchbox','kimchigimbap', 1200, '2019/12/20', 5, 0);
insert into distribution values ( 201922, 'lunchbox','bulgogigimbap', 1400, '2019/12/20', 5, 0);
insert into distribution values ( 201931, 'drink','sparklingdrink', 1600, '2019/12/20', 10, 0);
insert into distribution values ( 201932, 'drink','fruitdrink', 1800, '2019/12/20', 10, 1);

insert into delivery values ( 201911, 'snack','snackstick', 1500, '2019/12/20', 1000);
insert into delivery values ( 201912, 'snack','chocostick', 1000, '2019/12/20', 1000);
insert into delivery values ( 201921, 'lunchbox','kimchigimbap', 1200, '2019/12/20', 1000);
insert into delivery values ( 201922, 'lunchbox','bulgogigimbap', 1400, '2019/12/20', 1000);
insert into delivery values ( 201931, 'drink','sparklingdrink', 1600, '2019/12/20', 1000);
insert into delivery values ( 201932, 'drink','fruitdrink', 1800, '2019/12/20', 1000);
insert into delivery values ( 201933, 'drink','milk', 1800, '2019/12/20', 1000);
insert into delivery values ( 201913, 'snack','chocosnack', 1800, '2019/12/20', 1000);


insert into event values ( 'additem', 201911 , '1+1', '2019/11/27', '2019/12/20' );
insert into event values ( 'sale', 201921 , '30%', '2019/11/27', '2019/12/20' );
insert into event values ( '20%sale', 201931 , '20%', '2019/11/27', '2019/12/20' );

insert into cardEvent
values ('samsung', 30, '2019/11/20', '2019/12/20');

insert into cardEvent
values ('lg', 20, '2019/11/25', '2019/12/25');

insert into customer
values('guswns121234', '010-4336-2155', 1);

insert into customer
values('dlfghks12123', '010-1212-5656', 0);

insert into customer
values ('gowlgns', '010-1234-5678', 0);

insert into refrige
values ('guswns121234', '1', 'fruitdrink', '1', '1800');

insert into refrige
values ('guswns121234', '2', 'snackstick', '2', '1500');

insert into manager(staff_grade, staff_salary, staff_bonus) values ('owner', 300, 300*0.3);
insert into manager(staff_grade, staff_salary, staff_bonus) values ('manager', 150, 150*0.2);
insert into manager(staff_grade, staff_salary, staff_bonus) values ('parttime', 50, 50*0.1);

insert into emergencyCall(emergency_id, emergency_name, emergency_num) values(1, '경찰서', '112');
insert into emergencyCall(emergency_id, emergency_name, emergency_num) values(2, '소방서', '119');
insert into employee(staff_grade, staff_id, staff_name, staff_age, staff_sex, staff_attendence, staff_acnum, staff_addr, staff_tel) values ('owner', 'o100', 'justin', '32', 'M', '2019/09/01', '110-302-04-6502', 'Busan donraegu', '010-9987-1125');
insert into employee(staff_grade, staff_id, staff_name, staff_age, staff_sex, staff_attendence, staff_acnum, staff_addr, staff_tel) values ('manager', 'm100', 'Maximus', '27', 'F', '2019/10/30', '110-102-02-2201', 'Busan donraegu', '010-1524-4562');
insert into employee(staff_grade, staff_id, staff_name, staff_age, staff_sex, staff_attendence, staff_acnum, staff_addr, staff_tel) values ('parttime', 'p100', 'Rose', '21', 'F', '2019/11/22', '110-202-09-3303', 'Busan namgu', '010-3542-1564');
insert into employee(staff_grade, staff_id, staff_name, staff_age, staff_sex, staff_attendence, staff_acnum, staff_addr, staff_tel) values ('parttime', 'p200', 'Ann', '22', 'M', '2019/11/30', '110-703-01-9658', 'Busan busanjingu', '010-1248-8978');
insert into branchOffice(office_head, office_num, office_location) values('o100', '051-988-7652', 'DEU');



commit;

/* create index 부분 */
create unique index testindex
on distribution(product_name);

/* 프로시저 */
create or replace procedure delete_employee
(
    staffid varchar
)
AS
BEGIN
  DELETE FROM employee where staff_id = staffid;
END delete_employee;

--프로시저호출문
execute delete_employee('p300');
commit;


/* select */

select *
from distribution
where product_id = 201911;

select *
from del_dis;

select *
from distribution dis, delivery del
where del.Hproduct_id = dis.product_id(+);

select product_price from DISTRIBUTION where PRODUCT_ID = 201911;
