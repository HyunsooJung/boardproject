package com.myproject.myboard.comment;

import java.util.List;

public interface CommentService {

	public int doInsert(CommentVO commentVO);
	public int doDelete(int num);
	public int doUpdate(CommentVO commentVO);
	public CommentVO doSelectOne(CommentVO commentVO);
	public List<CommentVO> doSelectList(CommentVO commentVO);
	public int getSequence ();
}
