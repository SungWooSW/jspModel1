<%@page import="util.CalendarUtil"%>
<%@page import="dao.CalendarDao"%>
<%@page import="dto.CalendarDto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// loginAf.jsp에서 "login" name의 세션에 변수 mem을 저장했다.
	MemberDto login = (MemberDto)session.getAttribute("login"); //session.getAttribute("login")의 리턴값은 mem(Object)이므로 cast(형변환)!
	if(login == null){ // 세션값이 없다. 즉, 세션이 만료된 경우가 포함된다.
		%>
		<script>
		alert('로그인 해 주십시오');
		location.href = "login.jsp";
		</script>
		<%
	}	
%>       
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));

CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = dao.getDay(seq);
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>상세 일정 보기</h1>

<div align="center">
<table border="1">
<col width="200"><col width="500">
<tr>
	<th>아이디</th>
	<td><%= dto.getId() %></td>
</tr>
<tr>
	<th>제목</th>
	<td><%= dto.getTitle() %></td>
</tr>
<tr>
	<th>일정</th>
	<td><%= CalendarUtil.toDates(dto.getRdate()) %></td>
</tr>
<tr>
	<th>내용</th>
	<td>
	<textarea rows="20" cols="60" name="content"><%=dto.getContent() %></textarea>
	</td>
</tr>
</table>
<br>

<button type="button" onclick="calUpdate(<%=dto.getSeq() %>)">수정</button>

<button type="button" onclick="calDelete(<%=dto.getSeq() %>)">삭제</button>


</div>
<script type="text/javascript">
function calUpdate(seq){
	location.href="calupdate.jsp?seq=" + seq;
}
function calDelete(seq){
	location.href="caldelete.jsp?seq=" + seq;
}


</script>




</body>
</html>