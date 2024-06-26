package dudu.project.service;

import java.util.List;

public interface ProjectLogsService {
	
	/** 로그 번호 확인 */
	public List<?> getLogNum(ProjectLogsVO plvo) throws Exception;
	/** 수정 로그 원본 */
	public void plInsert(ProjectLogsVO plvo) throws Exception;
	/** 수정 로그 사본 */
	public void plCopyInsert(ProjectLogsVO plvo) throws Exception;
	/** 수정 로그 업데이트 */
	public void plUpdate(ProjectLogsVO plvo) throws Exception;
	/** 로그 출력 */
	public List<ProjectLogsVO> plList(ProjectLogsVO plvo) throws Exception;
	/** 로그 있는지 확인 */
	public int plListChk(ProjectLogsVO plvo) throws Exception;
	
}
