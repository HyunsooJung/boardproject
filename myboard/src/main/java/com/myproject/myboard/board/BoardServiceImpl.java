package com.myproject.myboard.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myproject.myboard.cmn.PageVO;

@Service("BoardServiceImpl")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	@Override
	public int doInsert(BoardVO boardVO) {
		return boardDao.doInsert(boardVO);
	}

	@Override
	public int doDelete(BoardVO boardVO) {
		return boardDao.doDelete(boardVO);
	}

	@Override
	public int doUpdate(BoardVO boardVO) {
		return boardDao.doUpdate(boardVO);
	}

	@Override
	public BoardVO doSelectOne(BoardVO boardVO) {
		return boardDao.doSelectOne(boardVO);
	}

	@Override
	public List<BoardVO> doSelectList(PageVO pageVO) {
		return boardDao.doSelectList(pageVO);
	}

	@Override
	public int count() {
		return boardDao.count();
	}

}
