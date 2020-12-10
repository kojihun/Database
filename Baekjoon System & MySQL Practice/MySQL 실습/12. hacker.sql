drop table if exists hackerstable;

create table hackerstable
(
    hacker_id INT not null primary key,
    name varchar(50) not null
);
LOAD DATA LOCAL INFILE 'C:/temp/hackers.txt' into table aftermidterm.hackerstable fields terminated by ' '(hacker_id, name) ;

drop table if exists challengetable;

create table challengetable
(
	challenge_id INT not null,
    hacker_id INT not null,
	foreign key(hacker_id) references hackerstable(hacker_id)
);
LOAD DATA LOCAL INFILE 'C:/temp/challenges.txt' into table aftermidterm.challengetable fields terminated by ' '(challenge_id, hacker_id) ;

select hackerstable.hacker_id, name, count(challenge_id)as '문제수' from hackerstable inner join challengetable ON hackerstable.hacker_id = challengetable.hacker_id group by hacker_id order by count(challenge_id) desc;
