<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="hContext" value= "${pageContext.request.contextPath }"></c:set>
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
	<form  class="form-horizontal" id="modForm" method="post">
	<div class="container">
		<div class="form-group">
			<input type="hidden" id="seq" name="seq" value='<c:out value="${outVO.seq }"/>'>
			<label>제목</label>
			<div>
				<input type="text" class="form-control" id="title" name="title" value="${outVO.title }" readonly="readonly"/>				
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
				<textarea style="width:400px; height:200px; margin:5px;"  id="contents" name="contents" readonly="readonly" >${outVO.contents }</textarea>				
			</div>
		</div>
		<div>
				<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="목록" id="list_btn" >
			<c:if test="${outVO.regId == sessionScope.MemberVO.getMemberId()}">
				<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="수정" id="mod_btn" >
				<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="삭제" id="delete_btn" >
			</c:if>
		</div>
		</div>
	</form>
		<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${hContext}/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
	//삭제 이벤트
	$("#delete_btn").on("click",function(){
		if(${sessionScope.MemberVO.getAuth()>=3}){
			if(false==confirm("삭제 하시겠습니까?"))return; 
			$.ajax({
				type:"POST",
				url:"${hContext}/board/doDelete.do",
				dataType:"html",
				data:{
					"seq":$("#seq").val(),
					"title" : $("#title").val(),
					"contents" : $("#contents").val(),
					"regId" : $("#regId").val()
				},
				success:function(data){
					alert("삭제되었습니다");
					window.location.href="${hContext}/board/doSelectList.do";
				},
				error:function(xhr,status,error){
					alert("error:"+error);
					console.log("error:"+error);
				}
			});	
		}
		else{
			alert("삭제권한이 없습니다.");
		}
		
	});
	
	//수정페이지이동 이벤트
	$("#mod_btn").on("click",function(){
		if(${sessionScope.MemberVO.getAuth()>=3}){
			$("#modForm").attr('action', '${hContext}/board/doUpdatePage.do');
			$("#modForm").submit();	
		}
		else{
			alert("수정권한이 없습니다.");
		}
		
	});
	
	
	//목록화면으로 넘기기
	$("#list_btn").on("click",function(){
		window.location.href="${hContext}/board/doSelectList.do";
	});
	</script>
</body>
</html>