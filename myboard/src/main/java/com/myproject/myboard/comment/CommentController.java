package com.myproject.myboard.comment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.myproject.myboard.member.MemberVO;

@Controller
public class CommentController {
	final static Logger LOG = LoggerFactory.getLogger("CommentController");
	@Autowired
	CommentServiceImpl commentServiceImpl;
	
	/**
	 * 댓글등록
	 * @param commentVO
	 * @return
	 */
	@RequestMapping(value="comment/doInsert.do", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public ModelAndView doInsert(CommentVO commentVO, HttpServletRequest req) {
		
		MemberVO memberVO = (MemberVO) req.getSession().getAttribute("MemberVO");
		LOG.debug("memberVO23:"+memberVO);
		//댓글 작성자
		String memberId = memberVO.getMemberId();		
		//댓글의 그룹번호
		int refGroup = Integer.parseInt(req.getParameter("refGroup"));		
		//댓글의 대상자 아이디
		String targetId = req.getParameter("targetId");		
		//댓글의 내용
		String content = req.getParameter("content");
		//댓글 내에서의 그룹번호
		String commentGroup = req.getParameter("commentGroup");
		//저장할 댓글의 기본키 값
		LOG.debug("refGroup:"+refGroup);
		LOG.debug("targetId:"+targetId);
		LOG.debug("content:"+content);
		LOG.debug("commentGroup:"+commentGroup);
		int seq = commentServiceImpl.getSequence();
		commentVO.setMemberId(memberId);
		commentVO.setTargetId(targetId);
		commentVO.setContent(content);
		commentVO.setRefGroup(refGroup);
		
		if(commentGroup==null) {
			commentVO.setCommentGroup(seq);
		}
		else {
			commentVO.setCommentGroup(Integer.parseInt(commentGroup));
		}	
		int flag = commentServiceImpl.doInsert(commentVO);
		return new ModelAndView("redirect:/board/doSelectOne.do?seq="+refGroup);
	}

	/**
	 * 댓글삭제
	 * @param commentVO
	 * @return
	 */
	@RequestMapping(value="comment/doDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> doDelete(HttpServletRequest req,
						@RequestParam int num) {
		commentServiceImpl.doDelete(num);
		Map<String, Object> map = new HashMap();
		map.put("isSuccess", true);
		return map;
	}
	
	/**
	 * 댓글 수정
	 * @param commentVO
	 * @return
	 */
	@RequestMapping(value="comment/doUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> doUpdate(CommentVO commentVO) {
		commentServiceImpl.doUpdate(commentVO);
		Map<String,Object> map = new HashMap();
		map.put("isSuccess", true);
		return map;
	}

	/**
	 * 댓글 단건
	 * @param commentVO
	 * @return
	 */
	@RequestMapping(value="comment/doSelectOne.do", method = RequestMethod.GET)
	public String doSelectOne(CommentVO commentVO) {
		CommentVO outVO = commentServiceImpl.doSelectOne(commentVO);
		
		Gson gson = new Gson();
		String json = gson.toJson(outVO);
		return json;
	}

}
