drop table bbs;

create table bbs(
	seq int auto_increment primary key, 
	id varchar(50) not null, -- 외래키
	
	ref decimal(8) not null,
	step decimal(8) not null,
	depth decimal(8) not null,
	
	title varchar(200) not null,
	content varchar(4000) not null,
	wdate timestamp not null,
	
	del decimal(1) not null,
	readcount decimal(8) not null
);

alter table bbs
add foreign key(id) references member(id); -- member table과 연결

insert into bbs(id, ref, step, depth, title, content, wdate, del, readcount)
values('id', (select ifnull(max(ref), 0)+1 from bbs b), 0, 0, 'title', 'content', now(), 0, 0));
-- ifnull(max(ref), 0)에서 IFNULL(Column명, "Null일 경우 대체 값")과, 값이 처음 추가되면 max(ref)는 null이 됨을 인식하자.
-- bbs 뒤의 b는  You can't specify target table '테이블명' for update in FROM clause 에러가 발생하기 때문. 
-- 이 에러는 insert, update, delete에서 서브쿼리로 동일한 테이블의 조건을 사용할 경우 발생한다. 따라서 서브쿼리 내부의 테이블에 별칭을 부여하면 해결된다.


update bbs
set step=step+1
where ref=(select ref from bbs where seq=?) 
	and step>(select step from bbs where seq=?) -- step이 더 크다는 얘기는 아래에 있다는 것
	
insert into bbs(id, ref, step, depth, title, content, wdate, del, readcount)
values(?, 
		(select ref from bbs where seq=?),
		(select step from bbs where seq=?) + 1,
		(select depth from bbs where seq=?) + 1,
		?, ?, now(), 0, 0)
		

	
select * from bbs;	

delete from bbs
where seq=36;




