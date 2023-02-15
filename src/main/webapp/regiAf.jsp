<%@page import="dto.MemberDto"%>
<%@page import="dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
	request.setCharacterEncoding("utf-8"); // DB에 넣는 값들 중 한글이 깨지는 것을 해결하기 위함

	// form태그의 name을 통해 넘어옴
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String name = request.getParameter("name");
	String email = request.getParameter("email");

	// 회원의 정보를 저장할 Model이 필요하다. DB에 넣어줘야 하니까
	// Model(DAO, DTO)
	MemberDao dao = MemberDao.getInstance();
	// 회원의 정보를 저장할 객체 생성 후 참조변수 dto가 참조
	MemberDto dto = new MemberDto(id, pwd, name, email, 0);
	boolean isS = dao.addMember(dto); // addMember를 통해 DB에 dto가 참조하는 객체에 들어있는 회원정보 저장
	if(isS == true){
		%>
		<script>
		alert("성공적으로 가입되었습니다");
		location.href = "login.jsp";
		</script>
		<% 
	} else {
		%>
		<script>
		alert("다시 기입해 주십시오");
		location.href = "regi.jsp"; // 회원가입 창으로
		</script>
   		<% 
	}
%>
