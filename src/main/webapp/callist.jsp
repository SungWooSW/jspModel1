<%@page import="dto.MemberDto"%>
<%@page import="util.CalendarUtil"%>
<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
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
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String yyyymmdd = year + CalendarUtil.two(month) + CalendarUtil.two(day);

CalendarDao dao = CalendarDao.getInstance();
List<CalendarDto> list = dao.getDayList(login.getId(), yyyymmdd);

%>    

    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2><%=year %>년 <%=month %>월 <%=day %>일의 일정</h2>

<hr>
<br>

<div align="center">
<table border="1">
<col width="100"><col width="450"><col width="300">
<thead>
<tr>
	<th>번호</th>
	<th>제목</th>
	<th>일정</th>
</tr>
</thead>
<tbody>

<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="3">작성된 일정이 없습니다</td>
	</tr>
	<%
} else {
	for(int i = 0;i < list.size(); i++)
	{
		CalendarDto dto = list.get(i);
	%>
	<tr>
		<th><%=i+1 %></th>
		<td>
			<a href="caldetail.jsp?seq=<%=dto.getSeq() %>">
				<%=dto.getTitle() %>
			</a>
		</td>
		<td><%=CalendarUtil.toDates(dto.getRdate()) %></td>
	</tr>
		<%
	}
}
		%>

</table>
<br><br>
<button type="button" onclick="location.href='calendar.jsp'">일정관리</button>
</div>




</body>
</html>