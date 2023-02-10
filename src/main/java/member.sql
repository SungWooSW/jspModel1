
drop table member;

create table member(
	id varchar(50) primary key,
	pwd varchar(50) not null,
	name varchar(50) not null,
	email varchar(50) unique,
	auth int
);

-- id가 존재하는지 확인하는 방법 두가지
-- 1
select id 
from member
where id='abc'; 
-- 2
select count(*)
from member
where id='abc';

select * from member;