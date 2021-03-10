package com.myproject.myboard.member;

import java.util.List;

import com.myproject.myboard.cmn.PageVO;

public interface MemberService {

	public int doInsert(MemberVO memberVO);
	public int doDelete(MemberVO memberVO);
	public int doUpdate(MemberVO memberVO);
	public MemberVO doSelectOne(MemberVO memberVO);
	public List<MemberVO> doSelectList(PageVO pageVO);
	public int doMemberIdChk(MemberVO memberVO);
	public int doAdminUpdate(MemberVO memberVO);
}
