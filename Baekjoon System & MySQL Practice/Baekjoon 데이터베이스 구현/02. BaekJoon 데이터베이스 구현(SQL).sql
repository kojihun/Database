-- 데이터베이스 생성
create database onlinejudgesiteKO;
use onlinejudgesiteKO;

-- 회원테이블 생성
create table usertbl
(
	ID varchar(12) primary key ,
    userName varchar(20) not null,
    userEmail varchar(20) not null,
    userPhone_no varchar(14) not null,
    isLogin INT not null,
    grade varchar(10) not null, 
    foreign key (grade) references grade(grade)
);

create table grade
(
    grade varchar(10) not null primary key
);
-- 문제테이블 생성
create table questiontbl
(
	question_no INT auto_increment primary key,
    question_title varchar(45) not null,
    madebyID varchar(12) null ,
    Question varchar(100) not null,
    com_language varchar(30) not null,
    correct_per INT not null,
    grade varchar(10) not null, -- 0이면 회원 1이면 관리자
    foreign key(madebyID) references usertbl(ID)
	on delete set null
    on update cascade,

	foreign key(grade) references grade(grade)
    on update cascade
);

-- 문제제출테이블 생성
create table usedQuestiontbl
(
	state_no int auto_increment primary key,
	question_no INT ,
    ID varchar(12),
    success INT,
    question_answer varchar(20),
    Time datetime,
    foreign key(ID) references usertbl(ID)
	on delete cascade
    on update cascade,
    
    foreign key(question_no) references questiontbl(question_no)
	on delete cascade
    on update cascade
);

-- 게시판테이블 생성
drop table board;
create table board
(
	board_num INT auto_increment primary key,
    board_title varchar(30),
	board_ID varchar(12),
    board_content varchar(100),
    foreign key(board_ID) references usertbl(ID)
	on delete cascade
    on update cascade
);
drop table board_answer;
create table board_answer
(
	board_num INT,
    reply_ID varchar(12),
    reply_content varchar(50),
    foreign key(board_num) references board(board_num)
	on delete cascade
    on update cascade,
	foreign key(reply_ID) references usertbl(ID)
	on delete cascade
    on update cascade
);

-- grade 테이블
insert into grade values ('Member');
insert into grade values ('MASTER');

-- usertbl에 회원정보 삽입
insert into usertbl values ('KO','KOJIHUN','KO@naver.com','01012345678',1,'Member');
insert into usertbl values ('JO','JOHYEONYUP','JO@naver.com','01012345678',1,'Member');
insert into usertbl values ('SHIN','SHINJIHUN','SHIN@naver.com','01012345678',1,'Member');
insert into usertbl values ('LEE','LEEJIHUN','LEE@naver.com','01012345678',1,'Member');
insert into usertbl values ('KANG','KANGJIHUN','KANG@naver.com','01012345678',1,'Member');
insert into usertbl values ('HO','HOJIHUN','HO@naver.com','01012345678',1,'Member');
insert into usertbl values ('DONG','DONGJIHUN','DONG@naver.com','01012345678',1,'Member');
insert into usertbl values ('LAM','LAMJIHUN','LAM@naver.com','01012345678',1,'Member');
insert into usertbl values ('GOD','GOD','GOD','GOD',1,'MASTER');




-- questiontbl에 문제 삽입 (회원이 문제를 삽입한다)
insert into questiontbl(question_title,madebyID,Question,com_language,correct_per,grade) values ('A+B','LEE','A+B','C',0,'Member');
insert into questiontbl(question_title,madebyID,Question,com_language,correct_per,grade) values ('A-B','SHIN','A-B','C++',0,'Member');
insert into questiontbl(question_title,madebyID,Question,com_language,correct_per,grade) values ('A*B','JO','A*B','C',0,'Member');
insert into questiontbl(question_title,madebyID,Question,com_language,correct_per,grade) values ('A/B','KO','A/B','C++',0,'Member');
insert into questiontbl(question_title,madebyID,Question,com_language,correct_per,grade) values ('A+B*C','KO','A+B','JAVA',0,'Member');
insert into questiontbl(question_title,madebyID,Question,com_language,correct_per,grade) values ('(A+B)/C','LEE','A+B','JAVA',0,'Member');

-- 문제 삽입을 위한 프로시져
delimiter //
create procedure question_add(
 in title varchar(45),
 in ID varchar(12),
 in question varchar(100),
 in com_language varchar(30),
 in correct int,
 in grade varchar(10) 
)
begin
 insert into questiontbl(question_title,madebyID,Question,com_language,correct_per,grade) 
   values (title,ID,question,com_language,correct,grade);
end // 
delimiter ;
-- 삽입 예시
call question_add ('(A+B)/C*C','KO','(A+B)/C*C','JAVA',0,'Member');

-- usedquestiontbl에 문제 제출을 위한 procedure 생성
delimiter //
create procedure answer(
 in answer varchar(100),
 in ID varchar(12),
 in question_no INT 
)
begin
 insert into usedquestiontbl(ID,question_no,question_answer,success,time) 
   values (ID,question_no,answer,round(rand()),sysdate());
call correct_per(question_no);
end // 
delimiter ;

-- 정답률 계산을 위한 procedure
delimiter //
create procedure correct_per(
 in x int
)
begin
 set @x=(select count(question_no) from usedQuestiontbl where question_no= x);
 set @y=(select count(question_no) from usedQuestiontbl where question_no = x and success = 1);
 update questiontbl set correct_per = (@y/@x)*100 where question_no = x ;
end // 
delimiter ;

-- 문제 제출 쿼리문 (회원이 문제의 답을 제출한다)
call answer('This is answer!','LEE',1);
call answer('This is answer!','SHIN',1);
call answer('This is answer!','KO',1);
call answer('This is answer!','KO',2);
call answer('This is answer!','LEE',2);
call answer('This is answer!','SHIN',2);
call answer('This is answer!','KO',3);
call answer('This is answer!','JO',3);
call answer('This is answer!','JO',3);
call answer('This is answer!','LEE',4);
call answer('This is answer!','SHIN',4);
call answer('This is answer!','KO',4);
call answer('This is answer!','KO',5);
call answer('This is answer!','LEE',5);
call answer('This is answer!','SHIN',5);
call answer('This is answer!','KO',6);
call answer('This is answer!','JO',6);
call answer('This is answer!','JO',6);

-- 회원이 문제 유형을 정할 수 있다
select question_title, madebyID, Question, com_language 
	from questiontbl where com_language = 'C++';
select question_title, madebyID, Question, com_language 
	from questiontbl where com_language = 'JAVA';
select question_title, madebyID, Question, com_language 
	from questiontbl where com_language = 'C';

-- 문제를 검색한다
select question_title, madebyID, Question, com_language 
	from questiontbl where question_title = 'A+B';
select question_title, madebyID, Question, com_language 
	from questiontbl where question_title = 'A*B';
select question_title, madebyID, Question, com_language 
	from questiontbl where question_title = 'A-B';
select question_title, madebyID, Question, com_language 
	from questiontbl where question_title = 'A/B';

-- 최근에 해결한 문제 정보를 알 수 있다
select question_no,ID,success,question_answer,Time 
	from usedquestiontbl where ID ='KO' and success=1 order by Time desc;
select question_no,ID,success,question_answer,Time 
	from usedquestiontbl where ID ='SHIN' and success=1 order by Time desc;

-- 사용자가 장 게시판에 글을 올릴 수 있다
insert into board(board_title, board_ID,board_content) values('How to use mysql?', 'KO', 'How to use mysql?');
insert into board(board_title, board_ID,board_content) values('How to use visualstudio?', 'SHIN', 'How to use visualstudio?');
insert into board(board_title, board_ID,board_content) values('How to use Github?', 'JO', 'How to use Github?');
insert into board(board_title, board_ID,board_content) values('How to use Unity?', 'LEE', 'How to use Unity?');

-- 게시판의 질문에 대한 답을 올릴 수 있다
insert into board_answer(board_num,reply_ID,reply_content) values(1,'LEE','Click mysql');
insert into board_answer(board_num,reply_ID,reply_content) values(2,'KO','Click visualstudio');
insert into board_answer(board_num,reply_ID,reply_content) values(3,'SHIN','Click Github');
insert into board_answer(board_num,reply_ID,reply_content) values(4,'JO','Click Unity');
insert into board_answer(board_num,reply_ID,reply_content) values(1,'KANG','Click mysql');
insert into board_answer(board_num,reply_ID,reply_content) values(2,'HO','Click visualstudio');
insert into board_answer(board_num,reply_ID,reply_content) values(3,'DONG','Click Github');
insert into board_answer(board_num,reply_ID,reply_content) values(4,'LAM','Click Unity');

-- 게시판 전체 조회
select board.board_num, board_title,board_ID,board_content,
	board_answer.reply_ID,board_answer.reply_content from board inner join board_answer 
		ON board.board_num = board_answer.board_num order by board_num;
        
-- 회원이 탈퇴했을 경우
drop procedure user_withdrawal;

delimiter //
create procedure user_withdrawal(
 in user_ID varchar(12)
)
begin
 call user_delete(user_ID);
 set @x= (select ifnull(questiontbl.madebyID,(select ID from usertbl where ID= 'GOD'))  
		 from questiontbl limit 1);
 UPDATE `onlinejudgesiteko`.`questiontbl` SET `madebyID`= @x where grade = 'MASTER' ;
end // 
delimiter ;

drop procedure user_delete;
delimiter //
create procedure user_delete(
in user_ID varchar(12)
)
begin
update usertbl set grade = 'MASTER' where ID=user_ID;
update questiontbl set grade ='MASTER' where madebyID = user_ID;
delete from usertbl where ID=user_ID;
end // 
delimiter ;

call user_withdrawal ('KO');


