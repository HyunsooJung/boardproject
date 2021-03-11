package com.myproject.myboard.comment;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

@Repository("CommentDao")
public class CommentDao {
	

	@Autowired
	@Resource(name = "transactionManager")
	private PlatformTransactionManager transactionManager;
	   
	@Autowired
	@Resource(name = "sqlSession")
	private SqlSessionTemplate sqlSession;
	   
	final String NAMESPACE = "com.myproject.myboard.comment";
	
	/**
	 * 댓글 등록
	 * @param commentVO
	 * @return
	 */
	public int doInsert(CommentVO commentVO) {
		
		String statement = NAMESPACE + ".doInsert";
		
		int flag = sqlSession.insert(statement, commentVO);
		
		return flag;
	}
	
	/**
	 * 댓글 삭제
	 * @param commentVO
	 * @return
	 */
	public int doDelete(int num) {
		
		String statement = NAMESPACE + ".doDelete";
		
		int flag = sqlSession.delete(statement, num);
		
		return flag;
	}
	
	/**
	 * 댓글 수정
	 * @param commentVO
	 * @return
	 */
	public int doUpdate(CommentVO commentVO) {
		
		String statement = NAMESPACE + ".doUpdate";
		
		int flag = sqlSession.update(statement, commentVO);
		
		return flag;
	}
	
	/**
	 * 댓글 단건
	 * @param commentVO
	 * @return
	 */
	public CommentVO doSelectOne(CommentVO commentVO) {
		String statement = NAMESPACE + ".doSelectOne";
		
		CommentVO outVO = sqlSession.selectOne(statement, commentVO);
		
		return outVO;
	}
	
	/**
	 * 댓글 리스트
	 * @param commentVO
	 * @return
	 */
	public List<CommentVO> doSelectList(CommentVO commentVO) {
		String statement = NAMESPACE + ".doSelectList";
		List<CommentVO> outVO = sqlSession.selectList(statement, commentVO);
		return outVO;
	}
	
	public int getSequence () {
		String statement = NAMESPACE + ".getSequence";
		int flag = sqlSession.selectOne(statement);
		
		return flag;
	}
	
	
	
	
	
	
}
