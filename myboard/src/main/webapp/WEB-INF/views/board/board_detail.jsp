<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!-- 댓글 작성 -->
	<div class="comments">
		<!-- 원글에 댓글을 작성할 수 있는 폼 -->
		<div class="comment_form">
			<form action="${hContext}/comment/doInsert.do" method="post">
			<!-- 댓글의 그룹번호는 원글의 글번호가 된다 -->
				<input type="hidden" name="refGroup" value="${outVO.seq }" />
			<!-- 댓글의 대상자는 원글의 작성자가 된다. -->
				<input type="hidden" name="targetId" value="${outVO.regId }" />
				<textarea name="content" >
					<c:if test="${null == sessionScope.MemberVO.getMemberId()}">
					로그인이 필요합니다.
					</c:if>
				</textarea>	
				<button type="submit">등록</button>
			</form>
		</div>
	</div>
	<!-- 댓글 작성끝 -->
			
	<!-- 댓글 읽어오기 -->
	<ul>
	<c:forEach items="${commentList}" var="tmp" >
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
						<a href="#" class="reply_link" >답글</a> |
						<c:choose>
							<c:when test="${tmp.memberId == sessionScope.MemberVO.getMemberId() }" >
								<a href="#" class="comment-update-link" >수정</a>&nbsp;&nbsp;
								<a href="javascript:deleteComment(${tmp.num })" >삭제</a>
							</c:when>
							<c:otherwise>
								<a href="#" >신고</a>
							</c:otherwise>
						</c:choose>
					</dt>
					<dd>
						<pre>${tmp.content }</pre>
					</dd>
				</dl>
				<form action="${hContext}/comment/doInsert.do" method="post" class= "comment-insert-form">
					<input type="hidden" name="refGroup" value="${outVO.seq }" />	
					<input type="hidden" name="targetId" value="${tmp.memberId }" />
					<input type="hidden" name="commentGroup" value="${tmp.commentGroup}" />
					<textarea name="content"><c:if test="${null == sessionScope.MemberVO.getMemberId()}" >로그인이 필요합니다.</c:if></textarea>
					<button type="submit" >등록</button>
				</form>
				<!-- 로그인한 아이디와 댓글의 작성자 같으면 수정폼 출력 -->
				<c:if test="${tmp.memberId == sessionScope.MemberVO.getMemberId()}" >
					<form class="comment_update_form" action="${hContext}/comment/doUpdate.do">
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
	<!-- 댓글 읽어오기끝 -->
