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
<title>회원 수정, 탈퇴</title>
</head>
<body>
<%@ include file="/WEB-INF/views/top/topBar.jsp" %>
	<div style="text-align: center;" class="container">
		<h1>회원 수정, 탈퇴</h1>
		<hr>
			<input type="hidden" value="${sessionScope.MemberVO.getMemberId() }" id="memberId" >
			<input type="hidden" value="${sessionScope.MemberVO.getMemberPw() }" id="memberPw" >
			<c:choose>
				<c:when test="${sessionScope.MemberVO != null }">
					<div class= "contents text-center">
						<div class="col-sm-6 col-md-offset-10" style="display:inline-block" >
							<div class="form-group">
								<label for="inputId">아이디</label>
								<input type="text" class="form-control" id="inputId" name="inputId" placeholder="ID" style="width:300px" >
							</div>
					
							<div class="form-group">
								<label for="inputPw">비밀번호</label>
								<input type="password" class="form-control" id="inputPw" name="inputPw" placeholder="PASSWORD" style="width:300px" >
							</div>
							<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="수정" id="modBtn" >
							<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="탈퇴" id="deleteBtn" >
							<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="뒤로가기" id="backBtn" >
				
						</div>
					</div>
				</c:when>
				<c:otherwise>
					<script type="text/javascript">
						alert("로그인이 필요합니다.");
						window.location.href="${hContext}/member/loginPage.do";
					</script>
				</c:otherwise>
			</c:choose>
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript">
	
	//뒤로가기 버튼 이벤트
	$("#backBtn").on("click",function(){
		window.location.href = "${hContext}/board/doSelectList.do";
	});
	
	//수정페이지 버튼 이벤트
	$("#modBtn").on("click",function(){
		if($("#inputId").val() == ''){
			alert("아이디를 입력해주세요.");
			return ;
		}
		if($("#inputPw").val() == ''){
			alert("비밀번호를 입력해주세요.")
			return ;
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
					alert("회원확인 성공");
					window.location.href = "${hContext}/member/modPage.do";			
				}else if(data == 2){
					console.log(data);
					alert("비밀번호를 확인하세요.");
					location.reload();
				}else if(data == 3){
					console.log(data);
					alert("ID를 확인하세요.");
					location.reload();
				}
			},
			error:function(data){
				
			}	
		});
	});
	
	//탈퇴 버튼 이벤트
	$("#deleteBtn").on("click",function(){
		if($("#inputId").val() == ''){
			alert("아이디를 입력해주세요.");
			return ;
		}
		if($("#inputPw").val() == ''){
			alert("비밀번호를 입력해주세요.")
			return ;
		}
		if(false==confirm("탈퇴 하시겠습니까?"))return; 
		$.ajax({
			type : "POST",
			url  : "${hContext}/member/doDelete.do",
			dataType : "html",
			data:{
				"memberId" : $("#inputId").val(),
				"memberPw": $("#inputPw").val()
			},
			success:function(data){
				alert("탈퇴하였습니다.");
				window.location.href = "${hContext}/member/loginPage.do";
			},
			error:function(data){
				alert("정보를 다시 입력해주세요");
			}
		});
	});
	
	
	</script>
</body>
</html>