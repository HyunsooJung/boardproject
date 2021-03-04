package com.myproject.myboard.member;

public class MemberVO {

	private String memberId;//아이디
	private String memberPw;//비밀번호
	private String name;//이름
	private int auth;//권한
	
	public MemberVO() {
		super();
	}

	public MemberVO(String memberId, String memberPw, String name, int auth) {
		super();
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.name = name;
		this.auth = auth;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberPw() {
		return memberPw;
	}

	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "MemberVO [memberId=" + memberId + ", memberPw=" + memberPw + ", name=" + name + ", auth=" + auth
				+ ", toString()=" + super.toString() + "]";
	}
	
}
