<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript" ></script> <!-- cookie 사용하기 위함 -->

<style>
.center{
	margin: auto;
	width: 60%;
	border: 3px solid #ff0000;
	padding: 10px;
}

</style>

</head>
<body>

<h2>login page</h2>

<div class="center">
    <!-- login이니까 post방식 사용 -->
<form action="loginAf.jsp" method="post">
	<table border="1">
		<tr>
			<th>아이디</th>
			<td>
				<input type="text" id="id" name="id" size="20"><br>
				<input type="checkbox" id="chk_save_id">id 저장
			</td>
		</tr>
		<tr>
			<th>패스워드</th>
			<td>
				<input type="password" name="pwd" size="20"><br>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="log-in">
				<a href="regi.jsp">회원가입</a>
			</td>
		</tr>
	</table>
</form>
</div>

<script>
/*
	cookie: id저장, pw저장 == String으로 저장 ------ 저장 영역은 client에 있다.
	session: log-in한 정보 저장 == Object로 저장 --- 저장 영역은 server에 있다.
*/
///////////////// id 저장 부분(cookie)///////////////

let user_id = $.cookie("user_id");

if(user_id != null){ // 저장한 id가 있음
	$("#id").val(user_id); // 저장한 id를 넣어준다.(setter)
	$("#chk_save_id").prop("checked", true);
}

$("#chk_save_id").click(function(){
	
	if( $("#chk_save_id").is(":checked") == true){
		
		if( $("#id").val().trim() == ""){ // 스페이스 다 제거하고도 빈칸이면
			alert('id를 입력해주십시오'); // id 올바르게 입력하도록 하고
			$("#chk_save_id").prop("checked", false); // 체크는 해제시킨다.
			
		} 
		else {
			// 올바르게 입력했을 경우
			// cookie를 저장(cookie는 client 영역에 저장된다)
			// $.cookie(key, value) 형식으로 값을 넣어준다.
			$.cookie("user_id", $("#id").val().trim(), { expires:7, path:'./'}); // {만료기한, 경로} -- 사용안해도 됨
		}
		
	}
	else { // id저장 체크박스를 해제하면, 저장된 쿠키 삭제
		$.removeCookie("user_id", { path: './'});
	}
});

</script>




</body>
</html>