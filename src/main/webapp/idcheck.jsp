<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String id = request.getParameter("id");
	System.out.println("id: " + id);

	MemberDao dao = MemberDao.getInstance(); // singleton
	boolean b = dao.getId(id);
	
	// 값을 다시 regi.jsp로 돌려준다.
	if(b == true){ // 동일한 id 이미 있음
		out.println("NO");
	}
	else {         // id 없음(사용가능)
		out.println("YES");
	}
	
%>