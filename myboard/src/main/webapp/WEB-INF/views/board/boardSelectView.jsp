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
	.comments form textarea, .comments form button{
		float: left;
	}
	.comments li{
		clear: left;
	}
	.comments form textarea{
		width: 85%;
		height: 100px;
	}
	.comments form button{
		width: 15%;
		height: 100px;
	}
	/* 댓글에 댓글을 다는 폼과 수정폼을 일단 숨긴다. */
	.comment form{
		display: none;
	}
	.comment{
		position: relative;
	}
	.comment .reply_icon{
		width: 8px;
		height: 8px;
		position: absolute;
		top: 10px;
		left: 30px;
	}
	.comments .user-img{
		width: 20px;
		height: 20px;
		border-radius: 50%;
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
	<!-- 댓글 작성 -->
	<div class="comments">
		<!-- 원글에 댓글을 작성할 수 있는 폼 -->
		<div class="comment_form">
			<form action="${hContext}/comment/doInsert.do" method="post">
			<!-- 댓글의 그룹번호는 원글의 글번호가 된다 -->
				<input type="hidden" name="refGroup" value="${outVO.seq }" />
			<!-- 댓글의 대상자는 원글의 작성자가 된다. -->
				<input type="hidden" name="targetId" value="${outVO.regId }" />
				<textarea name="content">
					<c:if test="${null == sessionScope.MemberVO.getMemberId()}">
					로그인이 필요합니다.
					</c:if>
				</textarea>	
				<button type="submit">등록</button>
			</form>
		</div>
	</div>
	<form class="comment-insert-form" action="${hContext}/comment/doInsert.do" method="post">
		<!-- 덧글 그룹 -->
		<input type="hidden" name="refGroup" vlaue="${outVO.seq }" />
		<!-- 덧글 대상 -->
		<input type="hidden" name="targetId" vlaue="${commentList.memberId }" />
		<input type="hidden" name="commentGroup" vlaue="${commentList.num }" />
		<textarea name="content">
			<c:if test="${null == sessionScope.MemberVO.getMemberId()}">
			로그인이 필요합니다.
			</c:if>
		</textarea>	
		<button type="submit">등록</button>
	</form>
	<!-- 댓글 작성끝 -->
			
	<!-- 댓글 읽어오기 -->
	<ul>
	<c:forEach items="${commentList }" var="tmp" >
		<c:choose>
			<c:when test="${tmp.deleted != 'yes' }">
				<li class = "comment" id="comment${tmp.num }" <c:if test="${tmp.num != tmp.commentGroup }" >style="padding-left:50px;"</c:if> >
				<dl>
					<dt>
						<span>${tmp.memberId }</span>
						<c:if test="${tmp.num != tmp.commentGroup }" >
							to <strong>${tmp.targetId }</strong>
						</c:if>
						<span>${tmp.regDt }</span>
						<a href="javascript:" class="reply_link" >답글</a> |
						<c:choose>
							<!-- 로그인된 아이디와 댓글의 작성자가 같으면 -->
							<c:when test="${tmp.memberId == sessionScope.MemberVO.getMemberId()} " >
								<a href="javascript:" class="comment-update-link" >수정</a>&nbsp;&nbsp;
								<a href="javascript:deleteComment(${tmp.num })" >삭제</a>
							</c:when>
							<c:otherwise>
								<a href="javascript" >신고</a>
							</c:otherwise>
						</c:choose>
					</dt>
					<dd>
						<pre>${tmp.content }</pre>
					</dd>
				</dl>
				<form action="${hContext}/comment/doInsert.do" method="post" class= "comment-insert-form">
					<!-- 대댓글 그룹 -->
					<input type="hidden" name="refGroup" vlaue="${outVO.seq }" >
					<!-- 대댓글 대상 -->
					<input type="hidden" name="targetId" value="${tmp.memberId }" >
					<input type="hidden" name="commentGroup" value="${tmp.commentGroup }" >
					<textarea name="content"><c:if test="${null == sessionScope.MemberVO.getMemberId()}" >로그인이 필요합니다.</c:if></textarea>
					<button type="submit" >등록</button>
				</form>
				<!-- 로그인한 아이디와 댓글의 작성자 같으면 수정폼 출력 -->
				<c:if test="${tmp.memberId == sessionScope.MemberVO.getMemberId()}" >
					<form class="comment-update-form" action="${hContext}/comment/doUpdate.do">
						<input type="hidden" name="num" value="${tmp.num }">
						<textarea name="content">${tmp.content }</textarea>
						<button type="submit" >수정</button>
					</form>
				</c:if>
				</li>
			</c:when>
			<c:otherwise>
			<li <c:if test="${tmp.num != tmp.commentGroup }" >style="padding-left:50px;"</c:if> >
				삭제된 댓글입니다.
			</li>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	</ul>
		<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${hContext}/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
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