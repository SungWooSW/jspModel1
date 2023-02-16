
create table calendar(
	seq int auto_increment primary key,
	id varchar(50) not null,
	title varchar(200) not null,
	content varchar(4000),
	rdate varchar(12) not null,    -- 2023 0216 0945 -> 12자리 ( 연 월일 시분 )
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

