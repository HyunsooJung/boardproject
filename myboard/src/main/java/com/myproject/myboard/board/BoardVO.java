package com.myproject.myboard.board;

public class BoardVO {
	private int rn; //화면에 나타낼 순번
	private int seq; //순번
	private String title; //제목
	private String contents; //내용
	private int views; //조회수
	private String regId; //작성자
	private String regDt; //작성일
	private String modId; //수정자
	private String modDt; //수정일
		
	public BoardVO() {
	}

	public BoardVO(int rn, int seq, String title, String contents, int views, String regId, String regDt, String modId,
			String modDt) {
		super();
		this.rn = rn;
		this.seq = seq;
		this.title = title;
		this.contents = contents;
		this.views = views;
		this.regId = regId;
		this.regDt = regDt;
		this.modId = modId;
		this.modDt = modDt;
	}

	public int getRn() {
		return rn;
	}

	public void setRn(int rn) {
		this.rn = rn;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getRegDt() {
		return regDt;
	}

	public void setRegDt(String regDt) {
		this.regDt = regDt;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getModDt() {
		return modDt;
	}

	public void setModDt(String modDt) {
		this.modDt = modDt;
	}

	@Override
	public String toString() {
		return "BoardVO [rn=" + rn + ", seq=" + seq + ", title=" + title + ", contents=" + contents + ", views=" + views
				+ ", regId=" + regId + ", regDt=" + regDt + ", modId=" + modId + ", modDt=" + modDt + ", toString()="
				+ super.toString() + "]";
	}
	
}
