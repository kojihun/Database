create table esalary
(
	employee_id INT not null,
    name varchar(50) not null,
    months INT not null,
    salary INT not null
);

LOAD DATA LOCAL INFILE 'C:/temp/esalary.txt' into table aftermidterm.esalary fields terminated by ' '(employee_id, name, months, salary) ;

select name from aftermidterm.esalary where salary>2000 and months<10 order by employee_id;