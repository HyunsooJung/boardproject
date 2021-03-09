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
	
<title>관리자 페이지</title>

<style>
	body{
		padding-top:200px;
	}
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/top/topBar.jsp" %>
<h2>관리자 페이지</h2>

	<div id="outter">
		<!-- 검색 -->
		<%-- <form action="${hContext}/member/doAdminUpdate.do" method="post">
		<div style="float: right;">
			권한명<input name="searchWord" value="${outVO.getAuth()}">
    		<input type="submit" value="조회">
		</div>
		</form> --%>
		<!-- 검색 끝 -->
		
		<table border="1">
			<thead>
			<tr>
				<th>회원아이디</th>
				<th>회원이름</th>
				<th>권한</th>
				<th>권한명</th>
				<th>권한부여</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${memberVO}" var="list">
				<tr>
					<td>${list.memberId }</td>
					<td>${list.name }</td>
					<td>
						<c:if test="${list.auth == 9}">관리자</c:if>
						<c:if test="${list.auth == 0 }">권한없음</c:if>
						<c:if test="${list.auth == 1 }">권한없음</c:if>
						<c:if test="${list.auth == 2 }">읽기권한</c:if>
						<c:if test="${list.auth == 3 }">모든권한</c:if>
						<c:if test="${null == list.auth }">권한없음</c:if>
					</td>
					<td>
					<select id="cntPerPage" name="sel" onchange="selChange()">
						<option value="1">
							권한 없음
						</option>
						<option value="2">
							읽기권한
						</option>
						<option value="3">
							모든권한
						</option>
					</select>
					</td>
					<td>
						<input type="checkbox" id= "admin_chk" name="admin_chk">
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		
		<input type="button" value="권한 수정" style="float: right;" id="admin_btn">
		
		<%-- <div style="display: block; text-align: center;" >
			<c:if test="${pageVO.startPage != 1 }">
				<a href="${hContext}/board/doSelectList.do?nowPage=${pageVO.startPage - 1}&cntPerPage=${pageVO.cntPerPage}">&lt;</a>
			</c:if>
			<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" var="p" >
				<c:choose>
					<c:when test="${p == pageVO.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != pageVO.nowPage }">
						<a href="${hContext}/board/doSelectList.do?nowPage=${p}&cntPerPage=${pageVO.cntPerPage } " >${p}</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${pageVO.endPage != pageVO.lastPage }">
				<a href="${hContext}/board/doSelectList.do?nowPage=${pageVO.endPage+1 }&cntPerPage=${pageVO.cntPerPage } " >&gt;</a>	
			</c:if>
		</div> --%>
	</div>
		<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${hContext}/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
	//권한주기 이벤트
	$("#admin_btn").on("click",function(){
		
	});
	
	</script>	
</body>
</html>