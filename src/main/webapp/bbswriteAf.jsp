<%@page import="dto.BbsDto"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    
	request.setCharacterEncoding("utf-8");

	// bbswrite(글쓰기)에서 입력한 값 넘겨받음
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");

	// DB에 넣는다.
	BbsDao dao = BbsDao.getInstance();
	BbsDto dto = new BbsDto(id, title, content);
	boolean isS = dao.writeBbs(dto);
	if(isS){ // 글쓰기에 성공했을 때
		%>
		<script>
		alert("추가되었습니다");
		location.href="bbslist.jsp";
		</script>
		<%
	} else { // 글쓰기에 실패했을 때
		%>
		<script>
		alert("다시 작성해 주십시오");
		location.href="bbswrite.jsp";
		</script>
		<%
		
	}	
%>



