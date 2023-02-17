<%@page import="dao.CalendarDao"%>
<%@page import="dao.BbsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int seq = Integer.parseInt(request.getParameter("seq"));

CalendarDao dao = CalendarDao.getInstance();
boolean isS = dao.deleteCalendar(seq);
if(isS){
	%>    
	<script type="text/javascript">
	alert("삭제되었습니다.");
	location.href="calendar.jsp";
	</script>
	<%
} else {
	%>    
	<script type="text/javascript">
	alert("삭제되지 않았습니다.");
	location.href="caldetail.jsp?seq=" + "<%=seq %>";
	</script>
	<%
}
%>
