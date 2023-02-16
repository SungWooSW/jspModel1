<%@page import="util.CalendarUtil"%>
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
// calendar.jsp에서 calwrite 메서드를 통해 year, month, day 값을 넘겨받음
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

month = CalendarUtil.two(month);
day = CalendarUtil.two(day);
%>    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



</head>
<body>

<h2>일정추가</h2>

<div align="center">

<form action="calwriteAf.jsp" method="post">

<table border="1">
<col width="200"><col width="500">
<tr>
	<th>아이디</th>
	<td>
		<%=login.getId() %>
		<input type="hidden" name="id" value="<%=login.getId() %>">
	</td>
</tr>
<tr>
	<th>제목</th>
	<td>
		<input type="text" size="80" name="title">
	</td>
</tr>
<tr>
	<th>일정</th>
	<td>
		<input type="date" id="date" name="date">&nbsp;<input type="time" id="time" name="time">
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
		<textarea rows="20" cols="80" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="일정추가">
	</td>
</tr>


</table>

</form>

</div>

<script type="text/javascript">
let year = "<%=year %>";
let month = "<%=month %>";
let day = "<%=day %>";

document.getElementById("date").value = year + "-" + month + "-" + day; 	// setter

// Date 객체의 메서드를 사용
let date = new Date();
// 일단 현재 시간과 분을 setter -> input 태그에서 시간 선택하면 그 값이 calwriteAf.jsp로 넘어가게 됨
document.getElementById("time").value = date.getHours() + ":" + date.getMinutes(); // setter
</script>






</body>
</html>