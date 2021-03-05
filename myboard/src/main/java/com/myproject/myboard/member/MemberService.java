package com.myproject.myboard.member;

import java.util.List;

public interface MemberService {

	public int doInsert(MemberVO memberVO);
	public int doDelete(MemberVO memberVO);
	public int doUpdate(MemberVO memberVO);
	public MemberVO doSelectOne(MemberVO memberVO);
	public List<MemberVO> doSelectList(MemberVO memberVO);
	public int doMemberIdChk(MemberVO memberVO);
}
