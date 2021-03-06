package com.myproject.myboard.board;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.myproject.myboard.cmn.PageVO;
import com.myproject.myboard.comment.CommentServiceImpl;
import com.myproject.myboard.comment.CommentVO;

@Controller
public class BoardController {
	final static Logger LOG = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	BoardServiceImpl boardServiceImpl;
	@Autowired
	CommentServiceImpl commentServiceImpl;
	
	
	@RequestMapping(value="board/doInsertView.do", method = RequestMethod.GET)
	public String doInsertView(BoardVO boardVO,HttpServletRequest req, HttpServletResponse res) {
		return "board/board_create";
	}
	
	/**
	 * 게시물 등록
	 * @param boardVO
	 * @return
	 */
	@RequestMapping(value="board/doInsert.do", method = RequestMethod.POST)
	@ResponseBody
	public int doInsert(BoardVO boardVO) {
		
		int flag = boardServiceImpl.doInsert(boardVO);
		
		return flag;
	}
	
	@RequestMapping(value="board/doSelectOne.do", method = {RequestMethod.GET, RequestMethod.POST })
	public ModelAndView doSelectOne(@RequestParam("seq") int seq,BoardVO boardVO,
									CommentVO commentVO, HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		boardVO.setSeq(seq);
		
		BoardVO outVO = boardServiceImpl.doSelectOne(boardVO);

		outVO.setViews(outVO.getViews()+1);
		int flag = boardServiceImpl.doUpdate(outVO);
		
		commentVO.setRefGroup(seq);
		List<CommentVO> outVO2 = commentServiceImpl.doSelectList(commentVO);

		mav.addObject("commentList", outVO2);
		mav.addObject("outVO", outVO);
		mav.setViewName("board/boardSelectView");
		
		return mav;
	}
	
	@RequestMapping(value="board/doSelectList.do", method = {RequestMethod.GET, RequestMethod.POST })
	public ModelAndView doSelectList(@RequestParam(value="nowPage", required=false)String nowPage,
									 @RequestParam(value="cntPerPage", required=false)String cntPerPage,
									 @RequestParam (defaultValue="REG_ID") String searchOption,
									 @RequestParam (defaultValue="" ) String searchWord ,
									 @RequestParam (defaultValue="") String startDate,
									 @RequestParam (defaultValue="" ) String endDate,
									 PageVO pageVO,
									 HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		int total = boardServiceImpl.count();
		
		if(nowPage == null && cntPerPage ==null) {
			nowPage = "1";
			cntPerPage="5";
		}
		else if(nowPage == null) {
			nowPage = "1";
		}
		else if(cntPerPage == null) {
			cntPerPage="5";
		}
		pageVO = new PageVO(Integer.parseInt(nowPage),total, Integer.parseInt(cntPerPage));
		pageVO.setSearchOption(searchOption);
		pageVO.setSearchWord(searchWord);
				
		pageVO.setStartDate(startDate);
		pageVO.setEndDate(endDate);
		
		List<BoardVO> outVO = boardServiceImpl.doSelectList(pageVO);
		
		mav.addObject("startDate"+startDate);
		mav.addObject("endDate"+endDate);
		mav.addObject("searchOption", searchOption);
		mav.addObject("searchWord", searchWord);
		mav.addObject("pageVO", pageVO);
		mav.addObject("outVO", outVO);
		mav.setViewName("board/board_list");
		
		return mav;
	}
	
	/**
	 * 게시물 삭제
	 * @param boardVO
	 * @return
	 */
	@RequestMapping(value="board/doDelete.do", method = RequestMethod.POST)
	@ResponseBody
	public int doDelete(BoardVO boardVO) {
		
		int flag = boardServiceImpl.doDelete(boardVO);
		
		
		return flag;
	}
	
	@RequestMapping(value="board/doUpdatePage.do", method = RequestMethod.POST)
	public ModelAndView doUpdatePage(BoardVO boardVO) {
		
		System.out.println(boardVO.getSeq());
		BoardVO outVO = boardServiceImpl.doSelectOne(boardVO);
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("outVO", outVO);
		mav.setViewName("board/board_mod");
		
		return mav;
	}
	
	/**
	 * 게시물 수정
	 * @param boardVO
	 * @return
	 */
	@RequestMapping(value="board/doUpdate.do", method = RequestMethod.POST)
	@ResponseBody
	public int doUpdate(BoardVO boardVO) {
		
		int flag = boardServiceImpl.doUpdate(boardVO);
		
		return flag;
	}
	

}
