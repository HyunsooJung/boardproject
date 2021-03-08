package com.myproject.myboard.board;


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

@Controller
public class BoardController {
	final static Logger LOG = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	BoardServiceImpl boardServiceImpl;
	
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
	
	@RequestMapping(value="board/doSelectOne.do", method = RequestMethod.GET)
	public ModelAndView doSelectOne(@RequestParam("seq") int seq,BoardVO boardVO) {
		ModelAndView mav = new ModelAndView();
		boardVO.setSeq(seq);
		
		BoardVO outVO = boardServiceImpl.doSelectOne(boardVO);

		outVO.setViews(outVO.getViews()+1);
		int flag = boardServiceImpl.doUpdate(outVO);

		mav.addObject("outVO", outVO);
		mav.setViewName("board/boardSelectView");
		
		return mav;
	}
	
	@RequestMapping(value="board/doSelectList.do", method = {RequestMethod.GET, RequestMethod.POST })
	public ModelAndView doSelectList(@RequestParam(value="nowPage", required=false)String nowPage,
									 @RequestParam(value="cntPerPage", required=false)String cntPerPage,
									 @RequestParam (defaultValue="REG_ID") String searchOption,
									 @RequestParam (defaultValue="" ) String searchWord ,
									 PageVO pageVO) {
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
		
		List<BoardVO> outVO = boardServiceImpl.doSelectList(pageVO);
				
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
	
	/**
	 * 게시물 단건 조회
	 * @param boardVO
	 * @return
	 */
	@RequestMapping(value = "board/doSelectOne2.do", method = RequestMethod.GET)
	public String doSelectOne2(BoardVO boardVO) {
		BoardVO outVO = boardServiceImpl.doSelectOne(boardVO);

		Gson gson = new Gson();
		String json = gson.toJson(outVO);

		return json;
	}
	
	//@RequestMapping(value = "board/doSelectList2.do", method = RequestMethod.GET)
	//public String doSelectList2(BoardVO boardVO) {
	//	List<BoardVO> outVO = boardServiceImpl.doSelectList(boardVO);
    //
	//	Gson gson = new Gson();
	//	String json = gson.toJson(outVO);
    //
	//	return json;
	//}
	
	
}
