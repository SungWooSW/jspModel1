
select rnum, seq, id, ref, step, depth, title, content, wdate, del, readcount
from
(select row_number()over(order by ref desc, step asc) as rnum, -- 최신글이 맨 뒤에 등록되도록 정렬
	seq, id, ref, step, depth, title, content, wdate, del, readcount
from bbs
-- 검색
order by ref desc, step asc) a
where rnum between 1 and 10;