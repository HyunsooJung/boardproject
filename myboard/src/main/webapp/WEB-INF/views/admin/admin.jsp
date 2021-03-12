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
</head>
<body>
<%@ include file="/WEB-INF/views/top/topBar.jsp" %>
<h2>관리자 페이지</h2>

	<div id="outter">
		<!-- 검색 -->
		<form action="${hContext}/member/adminPage.do" method="get">
		<div style="float: right;">
			<select id="searchOption" name="searchOption">
				<option value="MEMBER_ID"
					<c:if test="${pageVO.searchOption == 'MEMBER_ID'}">selected</c:if>>
					회원아이디
				</option>
				<option value="name"
					<c:if test="${pageVO.searchOption == 'name'}">selected</c:if>>
					회원이름
				</option>
			</select>
			<input name="searchWord" value="${pageVO.searchWord}">
			
    		<input type="submit" value="조회">
		</div>
		</form>
		<!-- 검색 끝 -->
		
		<input type='checkbox'name='allBoard' value="${list.memberId }" onclick='selectAll(this)'/> <b>전체선택</b>
		<table border="1">
			<thead>
			<tr>
				<th>선택</th>
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
					<td>
						<input type="checkbox" name="allBoard" value= "${list.memberId }" >
					</td>
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
					<select name="sel">
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
						<input type="checkbox" name="admin_chk" value= "${list.memberId }" >
						<input type="hidden" name="hiddenValue" id="hiddenValue" value=""/>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<input type="button" value="모든게시물 삭제" style="float: left;" id="board_delete_btn">
		<input type="button" value="권한 수정" style="float: right;" id="admin_btn">
		
		<div style="display: block; text-align: center;" >
			<c:if test="${pageVO.startPage != 1 }">
				<a href="${hContext}/member/adminPage.do?nowPage=${pageVO.startPage - 1}&cntPerPage=${pageVO.cntPerPage}">&lt;</a>
			</c:if>
			<c:forEach begin="${pageVO.startPage }" end="${pageVO.endPage }" var="p" >
				<c:choose>
					<c:when test="${p == pageVO.nowPage }">
						<b>${p }</b>
					</c:when>
					<c:when test="${p != pageVO.nowPage }">
						<a href="${hContext}/member/adminPage.do?nowPage=${p}&cntPerPage=${pageVO.cntPerPage }&searchOption=${pageVO.searchOption }&searchWord=${pageVO.searchWord }" >${p}</a>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${pageVO.endPage != pageVO.lastPage }">
				<a href="${hContext}/member/adminPage.do?nowPage=${pageVO.endPage+1 }&cntPerPage=${pageVO.cntPerPage }&searchOption=$${pageVO.searchOption }&searchWord=${pageVO.searchWord }" >&gt;</a>	
			</c:if>
		</div>
	</div>
		<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="${hContext}/resources/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	
	//권한주기 이벤트
	$("#admin_btn").on("click",function(){
		if(false==confirm("권한수정을 하시겠습니까?"))return; 
		var idArray = [];
		var adminArray = [];
		
		//권한 이벤트
		$.each($('table tr'), function(idx){
			$(this).find('[name=sel]').val();
			if(idx != 0){
				if($(this).find('[name=admin_chk]').is(':checked')){
					adminArray.push($(this).find('[name=sel]').val());	
				}	
			}			
			console.log("adminArray:"+adminArray);
		}); 
		
		//체크박스 이벤트
		$('input:checkbox[name=admin_chk]:checked').each(function(){
			
			idArray.push(this.value);
			console.log("idArray:"+idArray);
		});
		
		var objParams = {
				"memberId" : idArray,
				"auth"	   : adminArray
		};
		$.ajax({
		    type:"POST",
		    url:"${hContext}/member/doAdminUpdate.do",
		    dataType:"html",
		    traditional:true, 
		    data:{
		    	"memberId"  : idArray,
		    	"auth"	   : adminArray
		    },
		    success:function(data){ //성공
		    	alert("권한 수정을 완료했습니다.");
			       window.location.href="${hContext}/member/adminPage.do";
				      
		    },		       
		    error:function(xhr,status,error){
		     alert("권한부여를 체크해주세요.");
		    },
		    complete:function(data){
		    
		    }   
		  
	});//--ajax 
		
	});
	
	//전체선택
	function selectAll(selectAll) {
		const checkboxes = document.getElementsByName('allBoard');
		
		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		})
	}
	
	//선택된 유저의 모든 게시물 삭제 이벤트
	$("#board_delete_btn").on("click",function(){
		if(false==confirm("게시물을 삭제하시겠습니까?"))return;
		var idArr = [];
		
		//체크박스 이벤트
		$('input:checkbox[name=allBoard]:checked').each(function(){
			idArr.push(this.value);
		});
		$.ajax({
			type:"POST",
			url:"${hContext}/member/boardAllDelete.do",
			dataType:"html",
			traditional:true,
			data:{
				"memberId" :idArr
			},
			success:function(data){
				alert("해당유저의 모든 게시물을 삭제했습니다.");
				location.reload();
			},
			error:function(xhr,status,error){
				alert("유저를 선택해주세요.");
			},
			complete:function(data){
				
			}
		});
	});
	
	</script>	
</body>
</html>