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
<title>게시판</title>
</head>
<body>
	<form  class="form-horizontal" id="modForm" method="post">
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
				<textarea  id="contents" name="contents" readonly="readonly" >${outVO.contents }</textarea>				
			</div>
		</div>
		<div>
			<button type="button" id="list_btn" name="list_btn">목록</button>
		</div>
		<div>
			<button type="button" id="mod_btn" name="mod_btn">수정</button>
		</div>
		
		<div>
			<button type="button" id="delete_btn" name="delete_btn">삭제</button>
		</div>
	</form>
		<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript">
	
	//삭제 이벤트
	$("#delete_btn").on("click",function(){
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
	});
	
	//수정페이지이동 이벤트
	$("#mod_btn").on("click",function(){
		$("#modForm").attr('action', '${hContext}/board/doUpdatePage.do');
		$("#modForm").submit();
	});
	
	
	//목록화면으로 넘기기
	$("#list_btn").on("click",function(){
		window.location.href="${hContext}/board/doSelectList.do";
	});
	</script>
</body>
</html>