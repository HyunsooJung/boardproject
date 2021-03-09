<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="hContext" value="${pageContext.request.contextPath }" ></c:set> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
	<div style="text-align: center;" class="container">
		<h1>로그인</h1>
		<hr>
		<div>
			<div style="display:inline-block">
				<form method = "post" action="${hContext }/member/doLogin.do" id="loginForm" name="loginForm" >
					<div class="form-group">
						<label for="inputId">아이디</label>
						<input type="text" class="form-control" id="inputId" name="inputId" placeholder="ID" style="width:300px" >
					</div>
					
					<div class="form-group">
						<label for="inputPw">비밀번호</label>
						<input type="password" class="form-control" id="inputPw" name="inputPw" placeholder="PASSWORD" style="width:300px" >
					</div>
						<input style="width:150px; background-color:white; margin:5px;" class="btn btn-primary btn-lg" type="button" value="LOGIN" id="loginBtn" >
						<input style="width:150px; background-color:white; margin:5px;" class="btn btn-primary btn-lg" type="button" value="SIGNUP" id="signUpBtn" >
				</form>			
			</div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="${hContext}/resources/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
	
	//회원가입페이지 이동 이벤트
	$("#signUpBtn").on("click",function(){
		window.location.href="${hContext }/member/signUpPage.do";
	});
	
	//로그인 이벤트
	$("#loginBtn").on("click",function(){
		if($("#inputId").val() == ''){
			alert("아이디를 입력해주세요.");
		}
		if($("#inputPw").val() == ''){
			alert("비밀번호를 입력해주세요.")
		}
		
		$.ajax({
			type: "POST",
			url: "${hContext }/member/doLogin.do",
			dataType:"html",
			data:{
				  "memberId": $("#inputId").val(),
				  "memberPw": $("#inputPw").val()
			},
			success : function(data){
				console.log(data);
				if(data == 1){						
					alert("로그인 성공");
					window.location.href = "${hContext}/board/doSelectList.do";
				}else if(data == 2){
					console.log(data);
					alert("비밀번호를 확인하세요.");
					window.location.href = "${hContext}/member/loginPage.do";
				}else if(data == 3){
					console.log(data);
					alert("ID를 확인하세요.");
					window.location.href = "${hContext}/member/loginPage.do";
				}
			},
			error:function(data){
				
			}	
		});
		
	});
	
	</script>
</body>
</html>