package com.myproject.myboard.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("CommentServiceImpl")
public class CommentServiceImpl implements CommentService {

	@Autowired
	CommentDao commentDao;
	
	@Override
	public int doInsert(CommentVO commentVO) {
		return commentDao.doInsert(commentVO);
	}

	@Override
	public int doDelete(int num) {
		return commentDao.doDelete(num);
	}

	@Override
	public int doUpdate(CommentVO commentVO) {
		return commentDao.doUpdate(commentVO);
	}

	@Override
	public CommentVO doSelectOne(CommentVO commentVO) {
		return commentDao.doSelectOne(commentVO);
	}

	@Override
	public List<CommentVO> doSelectList(CommentVO commentVO) {
		return commentDao.doSelectList(commentVO);
	}

	@Override
	public int getSequence() {
		return commentDao.getSequence();
	}

}
