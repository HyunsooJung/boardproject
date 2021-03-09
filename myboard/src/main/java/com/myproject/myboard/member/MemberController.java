package com.myproject.myboard.member;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.myproject.myboard.board.BoardServiceImpl;
import com.myproject.myboard.board.BoardVO;

@Controller
public class MemberController {
	final static Logger LOG = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberServiceImpl memberServiceImpl;
	@Autowired
	BoardServiceImpl boardServiceImpl;
	
	/**
	 * 로그인
	 * @param memberVO
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="member/doLogin.do", method = RequestMethod.POST)
	@ResponseBody
	public int doLogin(HttpServletRequest req, MemberVO memberVO) throws Exception {
		HttpSession httpSession = req.getSession();
		int flag=0;
		MemberVO outVO = memberServiceImpl.doSelectOne(memberVO);
		String encode_pw = LoginUtil.encryptPassword(memberVO.getMemberId(), memberVO.getMemberPw());
		
		try {
			if(outVO.getMemberPw().equals(encode_pw)) {
				flag = 1;
				httpSession.setAttribute("MemberVO", outVO);
			}
			else {
				flag=2;
				
			}
		} catch (NullPointerException e) {
			flag=3;
		}
		
		return flag;
	}
	
	/**
	 * 아이디 체크
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value="member/doMemberIdChk.do", method = RequestMethod.POST)
	@ResponseBody
	public int doMemberIdChk(MemberVO memberVO) {
		
		int flag = memberServiceImpl.doMemberIdChk(memberVO);
		
		return flag;
	}
	
	@RequestMapping(value="member/doAdminUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public int doAdminUpdate(MemberVO memberVO, HttpServletRequest req) {
		HttpSession httpSession = req.getSession();
		
		String memberId[] = req.getParameterValues("memberId");
		String auth[] = req.getParameterValues("auth");
		
		for(int i=0; i<memberId.length; i++) {
			
			memberVO.setMemberId(memberId[i]);
			memberVO.setAuth(Integer.parseInt(auth[i]));
			
			int flag = memberServiceImpl.doAdminUpdate(memberVO);
			MemberVO outVO = memberServiceImpl.doSelectOne(memberVO);
			if(flag==1) {
				httpSession.setAttribute("MemberVO", outVO);
			}
			return flag;
		}
		return 0;
		
		
	}
	
	/**
	 * 관리자 페이지
	 * @return
	 */
	@RequestMapping(value="member/adminPage.do", method = RequestMethod.GET)
	public ModelAndView adminPage(MemberVO memberVO) {
		ModelAndView mav = new ModelAndView();
		
		List<MemberVO> outVO = memberServiceImpl.doSelectList(memberVO);
		
		mav.addObject("memberVO",outVO);
		mav.setViewName("admin/admin");
		return mav;
	}
	
	/**
	 * 회원정보수정페이지 넘기기전,탈퇴 페이지
	 * @return
	 */
	@RequestMapping(value="member/memberConfirmPage.do", method = RequestMethod.GET)
	public String memberConfirm() {
		return "member/memberConfirm";
	}
	
	/**
	 * 유저 정보수정 페이지
	 * @return
	 */
	@RequestMapping(value="member/modPage.do", method = RequestMethod.GET)
	public String memberMod() {
		return "member/memberMod";
	}
	
	/**
	 * 로그인 페이지
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="member/loginPage.do", method = RequestMethod.GET)
	public String login(HttpServletRequest req, HttpServletResponse res) {
		return "member/login";
	}
	
	/**
	 * 로그아웃
	 * @return
	 */
	@RequestMapping(value="member/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session, 
			@ModelAttribute("MemberVO") MemberVO memberVO,
            HttpServletRequest request,
            Model model) {
		request.getSession().removeAttribute("MemberVO");
		
		return "redirect:/member/loginPage.do";
	}
	
	/**
	 * 회원가입 페이지
	 * @param req
	 * @param res
	 * @return
	 */
	@RequestMapping(value="member/signUpPage.do", method = RequestMethod.GET)
	public String signUp(HttpServletRequest req, HttpServletResponse res) {
		return "member/signUp";
	}
	
	/**
	 * 회원등록
	 * @param memberVO
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="member/doInsert.do", method = RequestMethod.POST)
	@ResponseBody
	public int doInsert(MemberVO memberVO) throws Exception {
		
		String encode_password = LoginUtil.encryptPassword(memberVO.getMemberId(), memberVO.getMemberPw());
		memberVO.setMemberPw(encode_password);
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
		
		BoardVO boardVO= new BoardVO();
		boardVO.setRegId(memberVO.getMemberId());
		
		boardServiceImpl.allDelete(boardVO);
		return flag;
	}
	
	/**
	 * 회원수정
	 * @param memberVO
	 * @return
	 */
	@RequestMapping(value="member/doUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public int doUpdate(MemberVO memberVO, HttpServletRequest req) {
		HttpSession httpSession = req.getSession();
		
		int flag = memberServiceImpl.doUpdate(memberVO);
		MemberVO outVO = memberServiceImpl.doSelectOne(memberVO);
		if(flag==1) {
			httpSession.setAttribute("MemberVO", outVO);
		}
		
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
