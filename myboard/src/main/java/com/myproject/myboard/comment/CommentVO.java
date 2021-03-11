package com.myproject.myboard.comment;

public class CommentVO {
	
	private int num; //댓글의 글번호
	private String memberId; //댓글 작성자
	private String content; // 댓글 내용
	private String targetId; // 댓글의 대상이 되는 아이디(글작성자)
	private int refGroup; // 댓글 그룹번호
	private int commentGroup; //원글에 달린 댓글 내에서의 그룹번호
	private int deleted; // 댓글이 삭제되었는지 여부
	private String regDt; // 댓글 등록일
	
	public CommentVO() {
		super();
	}

	public CommentVO(int num, String memberId, String content, String targetId, int refGroup, int commentGroup,
			int deleted, String regDt) {
		super();
		this.num = num;
		this.memberId = memberId;
		this.content = content;
		this.targetId = targetId;
		this.refGroup = refGroup;
		this.commentGroup = commentGroup;
		this.deleted = deleted;
		this.regDt = regDt;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	public int getRefGroup() {
		return refGroup;
	}

	public void setRefGroup(int refGroup) {
		this.refGroup = refGroup;
	}

	public int getCommentGroup() {
		return commentGroup;
	}

	public void setCommentGroup(int commentGroup) {
		this.commentGroup = commentGroup;
	}

	public int getDeleted() {
		return deleted;
	}

	public void setDeleted(int deleted) {
		this.deleted = deleted;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	@Override
	public String toString() {
		return "CommentVO [num=" + num + ", memberId=" + memberId + ", content=" + content + ", targetId=" + targetId
				+ ", refGroup=" + refGroup + ", commentGroup=" + commentGroup + ", deleted=" + deleted + ", regDt="
				+ regDt + ", toString()=" + super.toString() + "]";
	}
		
}
