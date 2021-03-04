package com.myproject.myboard.board;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import com.myproject.myboard.cmn.PageVO;



@Repository("BoardDao")
public class BoardDao {
	
	@Autowired
   @Resource(name = "transactionManager")
   private PlatformTransactionManager transactionManager;
   
   @Autowired
   @Resource(name = "sqlSession")
   private SqlSessionTemplate sqlSession;
   
   final String NAMESPACE = "com.myproject.myboard.board";
   
   /**
    * 게시물 등록
    * @param boardVO
    * @return
    */
   public int doInsert(BoardVO boardVO) {
		 
		 String statement = NAMESPACE + ".doInsert";
		 
		 int flag = sqlSession.insert(statement, boardVO);
		return flag;
	}
   
   /**
    * 게시물 삭제
    * @param boardVO
    * @return
    */
   public int doDelete(BoardVO boardVO) {	
		 
		 String statement = NAMESPACE + ".doDelete";
		 
		 int flag = sqlSession.delete(statement, boardVO);
	
		return flag;
	}
   
   /**
    * 게시물 수정
    * @param boardVO
    * @return
    */
   public int doUpdate(BoardVO boardVO) {
		String statement = NAMESPACE + ".doUpdate";
		
		int flag = sqlSession.update(statement,boardVO);
		
		return flag;
	}
   
   /**
    * 게시물 단건 조회
    * @param boardVO
    * @return
    */
   public BoardVO doSelectOne(BoardVO boardVO) {
		String statement = NAMESPACE + ".doSelectOne";
		
		BoardVO outVO = sqlSession.selectOne(statement,boardVO);
       
		return outVO;
	}
   
   /**
    * 게시물 리스트 조회
    * @param boardVO
    * @return
    */
   public List<BoardVO> doSelectList(PageVO pageVO) {
		String statement = NAMESPACE + ".doSelectList";
		List<BoardVO> outVO = sqlSession.selectList(statement,pageVO);

		return outVO;
	}
   
   /**
    * 총 게시글 갯수
    * @return
    */
   public int count() {
	   String statement = NAMESPACE + ".count";
	   int flag = sqlSession.selectOne(statement);
	   return flag;
   }
}
