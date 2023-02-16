<%@page import="dto.CalendarDto"%>
<%@page import="java.util.List"%>
<%@page import="dao.CalendarDao"%>
<%@page import="util.CalendarUtil"%>
<%@page import="java.util.Calendar"%>
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
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
a{
	text-decoration: none;
}

</style>


</head>
<body>

<h1>일정관리</h1>

<%
	Calendar cal = Calendar.getInstance(); // Calendar 클래스는 추상클래스이기 때문에 getInstance 메서드 이용
	cal.set(Calendar.DATE, 1);	// 현재 월에서의 날짜(일)를 1일로 설정
	
	String syear = request.getParameter("year");  // bbslist.jsp에서 처음 넘어왔을 때는 넘겨줄 파라미터가 없다.
	String smonth = request.getParameter("month");
	
	// bbslist.jsp에서 처음 넘어왔을 때는 if문들은 그냥 통과한다.
	int year = cal.get(Calendar.YEAR); // 현재 연도
	if(CalendarUtil.nvl(syear) == false){		  // 넘어온 파라미터가 있음
		year = Integer.parseInt(syear);
	}

	int month = cal.get(Calendar.MONTH) + 1; // 현재 월(1월: 0이므로 +1을 해준다.)
	if(CalendarUtil.nvl(smonth) == false){		  // 넘어온 파라미터가 있음
		month = Integer.parseInt(smonth);
	}
	
	if(month < 1){ 			// 1월 이전은 12월로 내려가면서 year를 줄여야
		month = 12;
		year--;
	}
	if(month > 12){ 		// 12월 이후은 1월로 넘어가면서 year를 증가시켜야
		month = 1;
		year++;
	}
	
	cal.set(year, month - 1, 1); // 현재 년, 월, 일 지정
	
	// 요일
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); // 현재 요일(일요일: 1 ,토요일: 7)
	
	// << year--
	String pp = String.format("<a href='calendar.jsp?year=%d&month=%d'>"
							+ "	<img src='images/left.gif' width='20px' height='20px'>"
							+ "</a>",				year-1, month);
	
	// < month--
	String p = String.format("<a href='calendar.jsp?year=%d&month=%d'>"
							+ "		<img src='images/prec.gif' width='20px' height='20px'>"
							+ "</a>",				year, month-1);
	
	// > month++
	String n = String.format("<a href='calendar.jsp?year=%d&month=%d'>"
							+ "		<img src='images/next.gif' width='20px' height='20px'>"
							+ "</a>",				year, month+1);
	
	// >> year++
	String nn = String.format("<a href='calendar.jsp?year=%d&month=%d'>"
							+ "		<img src='images/last.gif' width='20px' height='20px'>"
							+ "</a>",				year+1, month);
	
	// DB
	CalendarDao dao = CalendarDao.getInstance();
	
	List<CalendarDto> list = dao.getCalendarList(login.getId(), year + CalendarUtil.two(month + ""));
	
	
%>

<div align="center">

<table border="1">
<col width="100"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100"><col width="100">

<tr>
	<td colspan="7" align="center">
		<%=pp %>&nbsp;&nbsp;<%=p %>&nbsp;&nbsp;&nbsp;&nbsp;
		
		<font color="black" style="font-size: 50px; font-family: fantasy">
			<%=String.format("%d년&nbsp;&nbsp;%2d월", year, month) %>
		</font>
		
		&nbsp;&nbsp;&nbsp;&nbsp;<%=n %>&nbsp;&nbsp;<%=nn %>
	</td>
</tr>

<tr height="50" style="background-color: #0000ff; color: white">
	
	<th>일</th>
	<th>월</th>
	<th>화</th>
	<th>수</th>
	<th>목</th>
	<th>금</th>
	<th>토</th>
	
</tr>

<tr height="100" align="left" valign="top">
<%
// 위쪽빈칸(현재 1일로 설정되어 있으므로 현재 요일 전까지만 빈칸을 만들어주면 된다.)
for(int i = 1; i < dayOfWeek; i++){ // dayOfWeek: 현재 요일(일요일: 1 ,토요일: 7)
	%>
	<td style="background-color: #eeeeee">&nbsp;</td>
	<%
}

// 날짜
int lastday = cal.getActualMaximum(Calendar.DAY_OF_MONTH); // 해당 월의 말일을 구함
for(int i = 1; i <= lastday; i++){
	%>
	<td>
		<%=CalendarUtil.callist(year, month, i) %>&nbsp;&nbsp;<%=CalendarUtil.calwrite(year, month, i) %>
		<%=CalendarUtil.makeTable(year, month, i, list) %>
	</td>
	<% // 날짜를 입력해 나가다가 한주가 꽉차면 다음 행을 추가한다
	if((i + dayOfWeek - 1) % 7 == 0 && i != lastday){
		%>
		</tr><tr height="100" align="left" valign="top"> 
		<%
	}
	
}
// 아래쪽 빈칸
cal.set(Calendar.DATE, lastday); // 현재 월에서의 날짜(일)를 말일로 설정
int weekday = cal.get(Calendar.DAY_OF_WEEK); // 현재 요일(일요일:1 ,토요일: 7)
for(int i = 0; i < 7 - weekday; i++){ // 7일 중 현재 요일까지를 제외한 나머지에 빈칸추가
	%>
	<td style="background-color: #eeeeee">&nbsp;</td>
	<%
}
%>
</tr>


</table>

</div>




</body>
</html>