<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="hContext" value="${pageContext.request.contextPath }" ></c:set> 
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="${hContext }/board/doSelectList.do" style="font-size:40px; color:white" >BOARD</a>
		<button class="navbar-toggler" type= "button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation" >
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive" >
			<ul class="navbar-nav ml-auto" >			
				<li class="nav-item">
					<a type="button" class="nav-link" id="moveToBoard" >게시판</a>
					<form action="${hContext }/board/doSelectList.do" name="moveBoard">
					</form>
				</li>
				
				<li class="nav-item">
				<c:choose>
					<c:when test="${sessionScope.MemberVO != null}">
						<li class="nav-item">
		        			<a href="${hContext}/member/logout.do" class="nav-link">로그아웃</a>
		        		</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item">
		        			<a href="${hContext}/member/loginPage.do" class="nav-link">로그인</a>
		        		</li>
						<li class="nav-item">
		        			<a href="${hContext}/member/signUpPage.do" class="nav-link">회원가입</a>
		        		</li>		        		
					</c:otherwise>
				</c:choose>
				</li>			
			</ul>
		</div>
	</div>
</nav>
<script src="${hContext}/resources/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script type="text/javascript">

	$("#moveToBoard").on("click", function(){
		moveBoardList();
	});
	
	function moveBoardList(){
		var frm = document.moveBoard;
		frm.submit();
	};
</script>
