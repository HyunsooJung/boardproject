<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
    
<c:set var="hContext" value="${pageContext.request.contextPath }"></c:set>    
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
<title>게시판</title>
</head>
<body>
<%@ include file="/WEB-INF/views/top/topBar.jsp" %>
	<section>
	<div class="container">
	
		<div >
			<label>제목</label>
			<div>
				<input type="text" class="form-control" id="title" name="title" />				
			</div>
		</div>
		<div >
			<label>작성자</label>
			<div>
				<input type="text" id="regId" name="regId" value="${sessionScope.MemberVO.getMemberId()}" readonly="readonly"/>				
			</div>
		</div>
		<div >
			<label>내용</label>
			<div>
				<textarea  id="contents" name="contents" ></textarea>				
			</div>
		</div>
		<div>
			<button type="button" id="list_btn" name="list_btn">목록</button>
		</div>
		<div>
			<button type="button" id="create_btn" name="create_btn">등록</button>
		</div>
	
	</div>
	</section>
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript">
	
	$("#create_btn").on("click",function(){
		var title = $("#title").val();
		if(null == title || title.trim().length==0){
			$("#title").focus();
			alert("제목을 입력하세요");
			return;
		}
		var contents = $("#contents").val();
		if(null ==contents || contents.trim().length==0){
			$("#contents").focus();
			alert("내용을 입력하세요");
			return;
		}
		
		$.ajax({
				type:"POST",
				url:"${hContext}/board/doInsert.do",
				dataType:"html",
				data:{
					"title" : $("#title").val(),
					"contents" : $("#contents").val(),
					"regId" : $("#regId").val()
				},
				success:function(data){
					alert("등록완료");
					window.location.href="${hContext}/board/doSelectList.do";
				},
				error:function(xhr,status,error){
					alert("error:"+error);
					console.log("error:"+error);
				}
		});
	});
	
	</script>
</body>
</html>