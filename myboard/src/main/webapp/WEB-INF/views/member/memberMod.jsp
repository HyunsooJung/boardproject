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
<title>회원정보 수정</title>
</head>
<body>
<%@ include file="/WEB-INF/views/top/topBar.jsp" %>
	<article class="container">
		<div class="page-header">
			<div class="col-md-6 col-md-offset-3">
				<h3>회원정보 수정</h3>
			</div>		
		</div>	
		<div class="col-md-6 col-md-offset-3">
			<form action="doUpdate.do" method ="post" role="form" id="modForm" name="modForm" >
				<div class="form-group">
					<label for="inputId">아이디</label>
					<input type="text" class="form-control" id="inputId" name="inputId" value="${sessionScope.MemberVO.getMemberId() }" readonly="readonly" >
					<div class="ehck_font" id="id_check"></div>
				</div>
				
				<div class="form-group">
					<label for="inputPw">비밀번호</label>
					<input type="password" class="form-control" id="inputPw" name="inputPw" placeholder="PASSWORD" >
					<div class="ehck_font" id="pw_check"></div>
				</div>
				
				<div class="form-group">
					<label for="inputPw2">비밀번호확인</label>
					<input type="password" class="form-control" id="inputPw2" name="inputPw2" placeholder="PASSWORD" >
					<div class="ehck_font" id="pw2_check"></div>
				</div>
				
				<div class="form-group">
					<label for="inputName">이름</label>
					<input type="text" class="form-control" id="inputName" name="inputName" value="${sessionScope.MemberVO.getName() }" readonly="readonly" >
					<div class="ehck_font" id="name_check"></div>
				</div>
				<br>
				<br>
				<input style="width:300px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="수정" id="modBtn">
				<input style="width:300px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="뒤로가기" id="backBtn">
			</form>
		</div>
	</article>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="${hContext}/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
	//모든 공백 체크 정규식
	var empJ = /\s/g; 
	//아이디 정규식 
	var idJ = /^[A-Za-z0-9][A-Za-z0-9_\-]{4,19}$/; 
	// 비밀번호 정규식 
	var pwJ = /^[A-Za-z0-9]{4,12}$/; 
	// 이름 정규식 
	var nameJ = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/; 
	
	//비밀번호
	$("#inputPw").blur(function(){
		if(pwJ.test($("#inputPw").val())){
			$("#pw_check").text("사용할 수 있는 비밀번호입니다.");
			$("#pw_check").css("color","blue");
		}
		else{
			$("#pw_check").text("4~12자리 영문자,숫자로만 사용 가능합니다.");
			$("#pw_check").css("color","red");
		}
	});
	
	//비밀번호 일치 확인
	$("#inputPw2").blur(function(){
		if($("#inputPw").val() != $("#inputPw2").val()){
			$("#pw2_check").text("비밀번호가 일치하지 않습니다.");
			$("#pw2_check").css("color","red");
		}
		if($("#inputPw2").val() == ''){
			$("#pw2_check").text("비밀번호가 일치하지 않습니다.");
			$("#pw2_check").css("color","red");
		}
		else{
			$("#pw2_check").text("비밀번호가 일치합니다.");
			$("#pw2_check").css("color","blue");
		}
	})
	
	
	//뒤로가기 이벤트
	$("#backBtn").on("click",function(){
		window.location.href="${hContext}/board/doSelectList.do";
	});
	
	//수정버튼 이벤트
	$("#modBtn").on("click",function(){
		var chk_Arr = new Array(1).fill(false);
		//비밀번호 일치와 비밀번호 정규식
		if(($("#inputPw").val()== $("#inputPw2").val()) && pwJ.test($("#inputPw").val())){
			chk_Arr[0] = true;
		}
		else{
			alert("비밀번호를 확인하세요.");
			chk_Arr[0] = false;
			console.log(chk_Arr[0]);
		}
		
		//유효성 검사
		var valid = true;
		if(chk_Arr[0] ==false){
			valid = false;
		}
		if(valid == true){
			$.ajax({
				type : "POST",
				url  : "${hContext}/member/doUpdate.do",
				dataType : "html",
				data :{
					"memberId" : $("#inputId").val(),
					"memberPw" : $("#inputPw").val()
				},
				success:function(data){
					alert("수정 되었습니다.");
					window.location.href = "${hContext}/board/doSelectList.do";
				},
				error:function(data){
					alert("정보를 다시 입력해주세요");
				}
			});
		}
		
	});
	
	</script>
	
</body>
</html>