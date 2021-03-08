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
	
<title>게시판</title>
<style>
	h2{
		text-align: center;
	}
	table{
		width: 100%;
	}
	#outter {
		display: block;
		width: 60%;
		margin: auto;
	}
	a{
		text-decoration: none;
	}
	
	body{
		padding-top:200px;
	}
</style>
<script type="text/javascript">
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href = "${hContext}/board/doSelectList.do?nowPage=${pageVO.nowPage}&cntPerPage="+sel;
	}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/top/topBar.jsp" %>
<h2>게시판</h2>

	<div id="outter">
		<!-- 검색 -->
		<form action="${hContext}/board/doSelectList.do" method="post">
		<div style="float: right;">
			<select id="searchOption" name="searchOption">
				<option value="REG_ID"
					<c:if test="${pageVO.searchOption == 'REG_ID'}">selected</c:if>>
					작성자
				</option>
				<option value="title"
					<c:if test="${pageVO.searchOption == 'title'}">selected</c:if>>
					제목
				</option>
				<option value="contents"
					<c:if test="${pageVO.searchOption == 'contents'}">selected</c:if>>
					내용
				</option>
				<option value="all"
					<c:if test="${pageVO.searchOption == 'all'}">selected</c:if>>
					전체
				</option>
			</select>
			<input name="searchWord" value="${pageVO.searchWord}">
    		<input type="submit" value="조회">
		</div>
		</form>
		<!-- 검색 끝 -->
		<!-- 옵션선택 -->
		<div style="float: right;">
			<select id="cntPerPage" name="sel" onchange="selChange()">
				<option value="5"
					<c:if test="${pageVO.cntPerPage == 5}">selected</c:if>>
					5줄보기
				</option>
				<option value="10"
					<c:if test="${pageVO.cntPerPage == 10}">selected</c:if>>
					10줄보기
				</option>
				<option value="15"
					<c:if test="${pageVO.cntPerPage == 15}">selected</c:if>>
					15줄보기
				</option>
				<option value="20"
					<c:if test="${pageVO.cntPerPage == 20}">selected</c:if>>
					20줄보기
				</option>
			</select>
		</div>
		<!-- 옵션선택 끝 -->
		<table border="1">
			<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
				<th>조회수</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${outVO}" var="list">
				<tr>
					<td>${list.rn }</td>
					<div style="display: none"><c:out value="${list.seq }" /></div>
					<td><a <c:if test="${null != sessionScope.MemberVO }">href='${hContext}/board/doSelectOne.do?seq=${list.seq }' </c:if>> ${list.title }</a></td>
					<td>${list.regId }</td>
					<td>${list.regDt }</td>
					<td>${list.views }</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<input type="button" value="글쓰기" style="float: right;" id="write_btn"><br>
		
		<div style="display: block; text-align: center;" >
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
		</div>
	</div>
	<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
    <script src="${hContext}/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
	$("#write_btn").on("click",function(){
		window.location.href="${hContext}/board/doInsertView.do"
	});
	
	</script>
</body>
</html>