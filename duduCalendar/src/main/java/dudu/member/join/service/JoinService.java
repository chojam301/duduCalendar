package dudu.member.join.service;

import java.util.List;

import egovframework.com.cmm.ComDefaultVO;

public interface JoinService {
	
	/**
	 * 부서 목록 조회
	 */
	public List<?> selectDeptList(ComDefaultVO searchVO) throws Exception;

	/** 중복 아이디 체크 */
	public int idCheck(String userEmail) throws Exception;
	
	/**
	 * 회원가입
	 */
	public String insertEntrprsmber(JoinVO entrprsManageVO) throws Exception;
	
    /**
     * 비밀번호 변경
     */
	public void updatePassword(JoinVO vo) throws Exception;

	public void updateName(JoinVO joinVO);
}
