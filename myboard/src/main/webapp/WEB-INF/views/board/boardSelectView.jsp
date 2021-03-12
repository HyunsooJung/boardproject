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
		/* 글 내용의 경계선 표시 */
	.content{
		border: 1px dotted #cecece;
	}
	/* 댓글에 관련된 css */
	.comments ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	.comments ul li{
		border-top: 1px solid #888; /* li 의 윗쪽 경계선 */
	}
	.comments dt{
		margin-top: 5px;
	}
	.comments dd{
		margin-left: 26px;
	}
	/* .comments form textarea, .comments form button{
		float: left;
	} */
	.comments li{
		clear: left;
	}
	.comments form textarea{
		width: 85%;
		height: 100px;
	}
	.comments form button{
		width: 5%;
		height: 80px;
	}
	/* 댓글에 댓글을 다는 폼과 수정폼을 일단 숨긴다. */
	.comment form{
		display: none;
	}
	.comment{
		position: relative;
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
			<c:if test="${outVO.regId == sessionScope.MemberVO.getMemberId() || sessionScope.MemberVO.getAuth() == 9}">
				<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="수정" id="mod_btn" >
				<input style="width:150px; background-color:black; margin:5px;" class="btn btn-primary btn-lg" type="button" value="삭제" id="delete_btn" >
			</c:if>
		</div>
		</div>
	</form>
	<%@ include file="/WEB-INF/views/board/board_detail.jsp" %>
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
	
	
	<!-- 비로그인시 로그인창으로 이동하게 -->
	$(".comments form textarea").on("click", function(){
		var login = ${null != sessionScope.MemberVO.getMemberId()};
		if(login == false){
			var move = confirm("로그인페이지로 이동하시겠습니까?");
			if(move){
				window.location.href="${hContext}/member/loginPage.do";
			}
		}
		
	});
	
	//수정 링크 눌렀을시 수정폼 보이게 이벤트
	$(".comment-update-link").click(function(){
		$(this).parent().parent().parent().find(".comment_update_form").slideToggle(200);	
	});
	
	//댓글 수정 폼에 submit 이벤트가 일어났을때 호출되는 함수 등록
	$(".comment_update_form").on("submit", function(){
		var url=$(this).attr("action");
		//폼에 작성된 내용을 query 문자열로 읽어온다.
		// num=댓글번호&content=댓글내용
		var data=$(this).serialize();
		//이벤트가 일어난 폼을 선택해서 변수에 담아 놓는다.
		var $this=$(this);
		$.ajax({
			url:url,
			method:"post",
			data:data,
			success:function(responseData){
				// responseData : {isSuccess:true}
				if(responseData.isSuccess){
					//폼을 안보이게 한다 
					$this.slideUp(200);
					//폼에 입력한 내용 읽어오기
					var content=$this.find("textarea").val();
					//pre 요소에 수정 반영하기 
					$this.parent().find("pre").text(content);
				}
			}
		});
		//폼 제출 막기 
		return false;
	});
	
	//답글 눌렀을시 답글폼 보이게 이벤트
	$(".reply_link").click(function(){
		$(this).parent().parent().parent().find(".comment-insert-form").slideToggle(200);	
	});
	
	
	<!-- 댓글 삭제 -->
	function deleteComment(num){
		var isDelete = confirm("확인을 누를시 삭제됩니다.");
		if(isDelete){
			$.ajax({
				url:"${hContext}/comment/doDelete.do",
				method:"post",
				data:{"num":num}, 
				success:function(responseData){
					if(responseData.isSuccess){
						var sel="#comment"+num;
						$(sel).text("삭제된 댓글 입니다.");
					}
				}
			});
		}
	}
<!-- 댓글 삭제끝 -->
	</script>
</body>
</html>