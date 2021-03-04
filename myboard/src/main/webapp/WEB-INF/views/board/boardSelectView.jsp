<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="hContext" value= "${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>게시판</title>
</head>
<body>
		<div >
			<label>제목</label>
			<div>
				<input type="text" class="form-control" id="title" name="title" var="${outVO.title }" readonly="readonly"/>				
			</div>
		</div>
		<div >
			<label>작성자</label>
			<div>
				<input type="text" id="regId" name="regId" var="${outVO.regId }" readonly="readonly"/>				
			</div>
		</div>
		<div >
			<label>내용</label>
			<div>
				<textarea  id="contents" name="contents" var="${outVO.contents }" readonly="readonly" ></textarea>				
			</div>
		</div>
		<div>
			<button type="button" id="list_btn" name="list_btn">목록</button>
		</div>
		<div>
			<button type="button" id="create_btn" name="create_btn">수정</button>
		</div>
		<div>
			<button type="button" id="delete_btn" name="delete_btn">삭제</button>
		</div>
		<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script type="text/javascript">
	
	$(delete_btn).on("click",function(){
		alert("삭제하시겠습니까?");
		$.ajax({
			type:"POST",
			url:"${hContext}/board/doDelete.do",
			dataType:"html",
			data:{
				"seq":2,
				"title" : $("#title").val(),
				"contents" : $("#contents").val(),
				"regId" : $("#regId").val()
			},
			success:function(data){
				alert("삭제완료");
				location.reload();
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