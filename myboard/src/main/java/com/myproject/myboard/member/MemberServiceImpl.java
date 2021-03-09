package com.myproject.myboard.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("MemberServiceImpl")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int doInsert(MemberVO memberVO) {
		return memberDao.doInsert(memberVO);
	}

	@Override
	public int doDelete(MemberVO memberVO) {
		return memberDao.doDelete(memberVO);
	}

	@Override
	public int doUpdate(MemberVO memberVO) {
		return memberDao.doUpdate(memberVO);
	}

	@Override
	public MemberVO doSelectOne(MemberVO memberVO) {
		return memberDao.doSelectOne(memberVO);
	}

	@Override
	public List<MemberVO> doSelectList(MemberVO memberVO) {
		return memberDao.doSelectList(memberVO);
	}

	@Override
	public int doMemberIdChk(MemberVO memberVO) {
		return memberDao.doMemberIdChk(memberVO);
	}

	@Override
	public int doAdminUpdate(MemberVO memberVO) {
		return memberDao.doAdminUpdate(memberVO);
	}

}
