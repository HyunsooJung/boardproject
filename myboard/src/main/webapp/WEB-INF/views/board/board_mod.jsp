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
<title>게시판 수정</title>
</head>
<body>
<%@ include file="/WEB-INF/views/top/topBar.jsp" %>
<section>
	<div class="container">
	
		<div >
			<label>제목</label>
			<div>
				<input type="text" class="form-control" value="${outVO.title }" id="title" name="title" />				
			</div>
		</div>
		<div >
			<label>작성자</label>
			<div>
				<input type="text" id="regId" name="regId" value="${outVO.regId }" readonly="readonly"/>				
			</div>
		</div>
		<div >
			<label>내용</label>
			<div>
				<textarea style="width:400px; height:200px; margin:5px;" id="contents" name="contents" >${outVO.contents }</textarea>				
			</div>
		</div>
		<div>
			<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="목록" id="list_btn" >
			<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="수정" id="modify_btn" >
		</div>
	
	</div>
	</section>
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript">

 	//목록페이지 이동이벤트
	$("#list_btn").on("click",function(){
		window.location.href="${hContext}/board/doSelectList.do"
	});
	
	//수정 이벤트
	$("#modify_btn").on("click", function(){
		if(false==confirm("수정 하시겠습니까?"))return; 
		$.ajax({
			type:"POST",
			url:"${hContext}/board/doUpdate.do",
			dataType:"html",
			data:{
				"seq": ${outVO.seq},
				"title" : $("#title").val(),
				"contents" : $("#contents").val(),
				"modId" : $("#regId").val()
				
			},
			success:function(data){
				alert("수정되었습니다.");
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