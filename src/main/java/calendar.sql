drop table calendar;

create table calendar(
	seq int auto_increment primary key,
	id varchar(50) not null,
	title varchar(200) not null,
	content varchar(4000),
	rdate varchar(50) not null,    -- 50자리로 넉넉하게 두긴 했는데 12자리로 해도 됨
	wdate timestamp not null
);

alter table calendar
add
constraint fk_cal_id foreign key(id)
references member(id);

select * from calendar;

-- ?월의 일정에서 5개만 갖고 온다
select seq, id, title, content, rdate, wdate
from 
	(select row_number()over(partition by substr(rdate, 1, 8) order by rdate asc) as rnum,
		seq, id, title, content, rdate, wdate
	from calendar
	where id='abc' and substr(rdate, 1, 6) = '20230216123525') a
where rnum between 1 and 5;

-- 202302170600 rdate
-- 일별 일정 목록 보기 위한 쿼리문
select seq, id, title, content, rdate, wdate
from calendar
where id='abc' and substr(rdate, 1, 8) = '20230217'
order by rdate asc;

-- 월별 일정 목록 보기 위한 쿼리문
select seq, id, title, content, rdate, wdate
from calendar
where id='abc' and substr(rdate, 1, 6) = '202302'
order by rdate asc;





