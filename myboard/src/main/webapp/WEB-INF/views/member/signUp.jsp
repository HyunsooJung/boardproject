<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %> 
<c:set var="hContext" value="${pageContext.request.contextPath }" ></c:set> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">	
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
	
	<!-- Bootstrap core CSS -->
    <link href="${hContext}/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<style>
		body{
			padding-top:200px;
		}
	</style>
<title>회원가입</title>
</head>
<body>
<%@ include file="/WEB-INF/views/top/topBar.jsp" %>
	<article class="container">
		<div class="page-header">
			<div class="col-md-6 col-md-offset-3">
				<h3>회원가입</h3>
			</div>
		</div>
		<div class="col-sm6 col-md-offset-3">
			<form action="doInsert.do" method="post" role="form" id="signupForm" name="signupForm" >
				<div class="form-group">
					<label for="inputId">아이디</label>
					<input type="text" class="form-control" id="inputId" name="inputId" placeholder="ID">
					<div class="ehck_font" id="id_check" ></div>
				</div>
				
				<div class="form-group">
					<label for="inputPw">비밀번호</label>
					<input type="password" class="form-control" id="inputPw" name="inputPw" placeholder="PassWord">
					<div class="ehck_font" id="pw_check" ></div>
				</div>
				
				<div class="form-group">
					<label for="inputPwChk">비밀번호확인</label>
					<input type="password" class="form-control" id="inputPwChk" name="inputPwChk" placeholder="PassWord">
					<div class="ehck_font" id="pw2_check" ></div>
				</div>
				
				<div class="form-group">
					<label for="inputName">이름</label>
					<input type="text" class="form-control" id="inputName" name="inputName" placeholder="NAME">
					<div class="ehck_font" id="name_check" ></div>
				</div>
				<br>
				<br>
				<input style="width:300px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="회원가입" id="signupBtn">
			</form>		
		</div>
	</article>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript">
	
	//모든 공백 체크 정규식
	var empJ = /\s/g; 
	//아이디 정규식 
	var idJ = /^[A-Za-z0-9][A-Za-z0-9_\-]{4,19}$/; 
	// 비밀번호 정규식 
	var pwJ = /^[A-Za-z0-9]{4,12}$/; 
	// 이름 정규식 
	var nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/; 
	
	//아이디 중복확인
	$("#inputId").blur(function(){
		if($("#inputId").val()==''){
			$("#id_check").text("아이디를 입력하세요");
			$("#id_check").css("color","red");
		}
		else if(idJ.test($("#inputId").val()) != true){
			$("#id_check").text("5~20자 사이의 영문, 숫자만 사용 가능합니다");
			$("#id_check").css("color","red");
		}
		else if($("#inputId").val() != ''){
			var inputId = $("#inputId").val();
			$.ajax({
				async : true,
				type : "POST",
				data : {"memberId" : inputId},
				url : "doMemberIdChk.do",
				dataType : "html",
				success : function(data){
					if(data > 0){
						$('#id_check').text('중복된 아이디 입니다.'); 
						$('#id_check').css('color', 'red'); 
						$("#signupFrom").attr("disabled", true);
					}else{
						if(idJ.test(inputId)){
							$('#id_check').text('사용가능한 아아디 입니다.'); 
							$('#id_check').css('color', 'blue'); 
							$("#signupFrom").attr("disabled", false);
						}else if(inputId==''){
							$('#id_check').text('아이디를 입력해주세요.'); 
							$('#id_check').css('color', 'red'); 
							$("#signupFrom").attr("disabled", true); 
						}else{
							$('#id_check').text("아이디는 영문, 숫자 5~20자리만 가능합니다.");
							$('#id_check').css('color', 'red'); 
							$("#usercheck").attr("disabled", true);
						}
				 	}	
					
				}
			});	//ajax
		}
	});
	
	//비밀번호
	$("#inputPw").blur(function(){
		if(pwJ.test($("#inputPw").val())) {
			$("#pw_check").text("사용할 수 있는 비밀번호입니다.");
			$("#pw_check").css("color","blue");
		}
		else{
			$("#pw_check").text("4~12자리 숫자, 영문자로만 사용 가능합니다.");
			$("#pw_check").css("color","red");
		}
	});
	
	//비밀번호 일치 확인
	$("#inputPwChk").blur(function(){
		if($("#inputPw").val() != $("#inputPwChk").val()) {
			$("#pw2_check").text("비밀번호가 일치 하지 않습니다.");
			$("#pw2_check").css("color","red");
		}
		else if($("#inputPwChk").val() == ''){
			$("#pw2_check").text("비밀번호가 일치 하지 않습니다.");
			$("#pw2_check").css("color","red");
		}
		else{
			$("#pw2_check").text("비밀번호가 일치합니다.");
			$("#pw2_check").css("color","blue");
		}
	});
	
	//이름
	$("#inputName").blur(function(){
		if(nameJ.test($("#inputName").val())){
			$("#name_check").text('');
		}
		else{
			$("#name_check").text("한글 2글자이상 입력해주세요.(특수기호, 공백 사용 불가)");
			$("#name_check").css("color","red");
		}
	});
	
	//회원가입 버튼 이벤트
	$("#signupBtn").on("click",function(){
		var chk_Arr = new Array(3).fill(false);
		//아이디 정규식
		if(idJ.test($("#inputId").val())){
			chk_Arr[0] = true;
		}
		else{
			chk_Arr[0] = false;
			alert("아이디를 확인하세요.");
			return false;
		}
		//비밀번호 일치와 비밀번호 정규식
		if(($("#inputPw").val()==($("#inputPwChk").val())) && pwJ.test($("#inputPw").val()) ){
			chk_Arr[1] = true;
		}
		else{
			chk_Arr[1] = false;
			alert("비밀번호를 확인하세요.");
			return false;
		}
		//이름 정규식
		if(nameJ.test($("#inputName").val())){
			chk_Arr[2] = true;
		}
		else{
			chk_Arr[2] = false;
			alert("이름을 확인하세요.");
			return false;
		}
		
		//전체 유효성 검사
		var validAll = true;
		for(var i = 0; i < chk_Arr.length; i++){
			if(chk_Arr[i] == false){
				validAll = false;
			}
		}
		
		if(validAll == true){
			$.ajax({
				type : "POST",
				url : "${hContext}/member/doInsert.do",
				dataType : "html",
				data : {
						"memberId" : $("#inputId").val(),
						"memberPw" : $("#inputPw").val(),
						"name"	   : $("#inputName").val()
				},
				success:function(data){
					alert("회원가입이 완료되었습니다.");
					window.location.href = "${hContext}/member/loginPage.do";
				},
				error:function(data){
					console.log("data: " +data);
					alert("id중복입니다");
				}
			});
		}
	});
	
	</script>
</body>
</html>



















