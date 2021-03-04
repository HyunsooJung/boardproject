package com.myproject.myboard.board;

import java.util.List;

import com.myproject.myboard.cmn.PageVO;

public interface BoardService {

	public int doInsert(BoardVO boardVO);
	public int doDelete(BoardVO boardVO);
	public int doUpdate(BoardVO boardVO);
	public BoardVO doSelectOne(BoardVO boardVO);
	public List<BoardVO> doSelectList(PageVO pageVO);
	public int count();
}
