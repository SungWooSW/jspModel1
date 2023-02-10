<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	MemberDao dao = MemberDao.getInstance();

	MemberDto mem = dao.login(id, pwd);

	if(mem != null){ // id 정보 찾았을 때(로그인이 된 회원상태)
		
		// 회원이 로그인을 했는지, 로그인을 했다면 로그인중인 회원에 대한 정보를 세션에 저장해놓는다.
		// 로그인을 해야만 보이는 정보들이 있으니 새로운 페이지에서 세션에 저장된 정보를 꺼내서 어떤 회원이 로그인중인지를 확인할 수 있다.
		// session에 저장
// 		request.getSession().setAttribute("login", mem);
		session.setAttribute("login", mem); 
		session.setMaxInactiveInterval(60*60*2);
		%>
		<script type="text/javascript">
		alert("환영합니다. <%=mem.getId() %>님");
//  		location.href="";
		</script>
		<%
	} else {
		// id 정보를 찾을 수 없을 때(로그인이 되지 않음)
		%>
		<script type="text/javascript">
		alert("아이디나 패스워드를 확인하십시오");
		location.href="login.jsp";
		</script>
		<%
	}	
%>






