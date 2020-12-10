create table pair
(
	x int not null,
    y int not null
);

LOAD DATA LOCAL INFILE 'C:/temp/pairs.txt' into table aftermidterm.pair fields terminated by ' '(x, y) ;

select distinct A.x, A.y from pair as A ,pair as B where (A.x =B.y and A.y = A.x) or (A.x = B.x and A.y= B.y) ;

select if(x < y, x, y) as x ,if (x < y, y, x) as y from pair group by 1,2 having count(*) > 1;