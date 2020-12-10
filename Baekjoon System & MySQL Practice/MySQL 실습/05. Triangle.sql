drop table if exists triangle ;

create table triangle(
A Int not null,
B Int not null,
C Int not null
);

LOAD DATA LOCAL INFILE 'C:/temp/triangle.txt' into table aftermidterm.triangle fields terminated by ' '(A,B,C) ;

select *,
	case
    when A=B and B=C Then '정삼각형'
    when A=B OR B=C OR C=A Then '이등변삼각형'
    when A!=B AND B!=C AND C!=A Then '부등변삼각형'
    else '삼각형 아님'
    End as '삼각형 유형'
from triangle;