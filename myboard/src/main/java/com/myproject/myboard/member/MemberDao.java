package com.myproject.myboard.member;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import com.myproject.myboard.cmn.PageVO;

@Repository("MemberDao")
public class MemberDao {

	@Autowired
	@Resource(name = "transactionManager")
	private PlatformTransactionManager transactionManager;
	
	@Autowired
	@Resource(name = "sqlSession")
	private SqlSessionTemplate sqlSession;
	
	final String NAMESPACE = "com.myproject.myboard.member";
	
	/**
	 * 아이디 체크
	 * @param memberVO
	 * @return
	 */
	public int doMemberIdChk(MemberVO memberVO) {
		String statement = NAMESPACE + ".doMemberIdChk";
		
		int flag = sqlSession.selectOne(statement, memberVO);
		
		return flag;
	}
	
	/**
	 * 회원등록
	 * @param memberVO
	 * @return
	 */
	public int doInsert(MemberVO memberVO) {
			 
		String statement = NAMESPACE + ".doInsert";
	 
		int flag = sqlSession.insert(statement, memberVO);
		return flag;
	}
	
	/**
	 * 회원삭제
	 * @param memberVO
	 * @return
	 */
	public int doDelete(MemberVO memberVO) {
		 
		String statement = NAMESPACE + ".doDelete";
	 
		int flag = sqlSession.delete(statement, memberVO);
		return flag;
	}
	
	/**
	 * 회원수정
	 * @param memberVO
	 * @return
	 */
	public int doUpdate(MemberVO memberVO) {
		 
		String statement = NAMESPACE + ".doUpdate";
	 
		int flag = sqlSession.update(statement, memberVO);
		return flag;
	}

	/**
	 * 회원 권한 수정
	 * @param memberVO
	 * @return
	 */
	public int doAdminUpdate(MemberVO memberVO) {
		 
		String statement = NAMESPACE + ".doAdminUpdate";
	 
		int flag = sqlSession.update(statement, memberVO);
		return flag;
	}
	
	/**
	 * 회원단건조회
	 * @param memberVO
	 * @return
	 */
	public MemberVO doSelectOne(MemberVO memberVO) {
		String statement = NAMESPACE + ".doSelectOne";
		
		MemberVO outVO = sqlSession.selectOne(statement,memberVO);
       
		return outVO;
	}
	
	/**
	 * 회원리스트조회
	 * @param memberVO
	 * @return
	 */
	public List<MemberVO> doSelectList(PageVO pageVO) {
		String statement = NAMESPACE + ".doSelectList";
		
		List<MemberVO> outVO = sqlSession.selectList(statement,pageVO);
       
		return outVO;
	}
}
