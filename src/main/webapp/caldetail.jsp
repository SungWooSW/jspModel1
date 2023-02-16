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
CalendarDto dto = dao.getCal(seq);
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
<colgroup>
	<col style="width: 200px"/>
	<col style="width: 200px"/>
</colgroup>
<tr>
	<th>작성자</th>
	<td><%= dto.getId() %></td>
</tr>
<tr>
	<th>제목</th>
	<td><%= dto.getTitle() %></td>
</tr>
<tr>
	<th>일정 일자</th>
	<td><%= dto.getRdate() %></td>
</tr>
<tr>
	<th>작성일</th>
	<td><%= dto.getWdate() %></td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="15" cols="90"><%= dto.getContent() %></textarea>
	</td>
</tr>
</table>
<br>


<%
	// login은 맨 위에서 세션을 통해 생성된 참조변수
	// 작성자와 로그인 한 사람의 id가 같을 때만 수정, 삭제 버튼이 나타나도록 한다.
	if(dto.getId().equals(login.getId())){
		%>
		<button type="button" onclick="updateCal(<%=dto.getSeq() %>)">수정</button>

		<button type="button" onclick="deleteCal(<%=dto.getSeq() %>)">삭제</button>
		<%
	}
%>

</div>



</body>
</html>