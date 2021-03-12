\<%@ page language="java" contentType="text/html; charset=UTF-8"
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
					<a type="button" class="nav-link" id="moveToBoard" href="${hContext }/board/doSelectList.do" >게시판</a>					
				</li>
				
				<li class="nav-item">
				<c:choose>
					<c:when test="${sessionScope.MemberVO != null}">
					<c:if test = "${sessionScope.MemberVO.getAuth() == 9 }">
						<li class="nav-item">
							<a href="${hContext}/member/adminPage.do" class="nav-link">관리자 페이지</a>		        				        			
		        		</li>
					</c:if>
						<li class="nav-item">
							<a href="${hContext}/member/memberConfirmPage.do" class="nav-link">회원정보 수정</a>		        				        			
		        		</li>
		        		<li>
		        			<a href="${hContext}/member/logout.do" class="nav-link">로그아웃</a>	
		        		</li>
		        		<li class="nav-link">
		        			${sessionScope.MemberVO.getName()}님 환영합니다.
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


