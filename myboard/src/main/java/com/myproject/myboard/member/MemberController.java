package com.myproject.myboard.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class MemberController {

	@Autowired
	MemberServiceImpl memberServiceImpl;
	
	/**
	 * 회원등록
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value="member/doInsert.do", method = RequestMethod.POST)
	@ResponseBody
	public int doInsert(MemberVO memberVO) {
		int flag= memberServiceImpl.doInsert(memberVO);
		
		return flag;
	}
	
	/**
	 * 회원탈퇴
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value="member/doDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public int doDelete(MemberVO memberVO) {
		int flag= memberServiceImpl.doDelete(memberVO);
		
		return flag;
	}
	
	/**
	 * 회원수정
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value="member/doUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public int doUpdate(MemberVO memberVO) {
		int flag = memberServiceImpl.doUpdate(memberVO);
		
		return flag;
	}
	
	/**
	 * 회원 단건조회
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value = "member/doSelectOne.do", method = RequestMethod.GET)
	@ResponseBody
	public String doSelectOne(MemberVO memberVO) {
		MemberVO outVO= memberServiceImpl.doSelectOne(memberVO);
		
		Gson gson = new Gson();
		String json=gson.toJson(outVO);
		
		return json;
	}
	
	/**
	 * 회원 리스트 조회
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value = "member/doSelectList.do", method = RequestMethod.GET)
	@ResponseBody
	public String doSelectList(MemberVO memberVO){
		List<MemberVO> outVO = memberServiceImpl.doSelectList(memberVO);
		
		Gson gson = new Gson();
		String json=gson.toJson(outVO);
		return json;
	}
}
