create table project
(
	task_id INT not null,
    start_date Date,
    End_data date
);

LOAD DATA LOCAL INFILE 'C:/temp/project.txt' into table aftermidterm.project fields terminated by ' '(task_id, start_date,End_data) ;

select * from aftermidterm.project ;

drop view v_project;
create view v_project AS SELECT task_id, start_date as End_data, End_data as start_date from project;
select * from v_project;

select project.start_date from project inner join v_project where project.start_date != v_project.start_date;

select min(start_date), max(End_data) from project;
