<%@page import="dto.CalendarDto"%>
<%@page import="dao.CalendarDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
// DB에 넣어줘야 하므로 인코딩!
request.setCharacterEncoding("utf-8");

int seq = Integer.parseInt(request.getParameter("seq"));
String title = request.getParameter("title");
String content = request.getParameter("content");

// rdate 넘겨 받기
String date = request.getParameter("date");
String time = request.getParameter("time");

//어떻게 값이 넘어오는가?
//2023-02-17
//09:14(오전 시간) 15:14(오후 시간)
//-,:를 기준으로 자르자!

String[] datesplit = date.split("-");
String year = datesplit[0];
String month = datesplit[1];
String day = datesplit[2];

String[] timesplit = time.split(":");
String hour = timesplit[0];
String min = timesplit[1];

String rdate = year + month + day + hour + min;  // 예를들면, 202302161517

CalendarDao dao = CalendarDao.getInstance();
CalendarDto dto = new CalendarDto(seq, null, title, content, rdate, null); // dto 생성자 매개변수 순서 조심
boolean isS = dao.updateCalendar(dto);

if(isS){
%>    
	<script type="text/javascript">
	alert("일정이 성공적으로 수정되었습니다.");
	location.href="calendar.jsp";
	</script>
	<%
} else {
	%>
	<script type="text/javascript">
	alert("일정이 수정되지 않았습니다.");
	location.href="calupdate.jsp?seq=" + "<%=seq %>";
	</script>
	<%
}
%>    
    
    
    
    
    
    
    
    
  