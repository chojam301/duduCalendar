package dudu.project.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import dudu.project.service.ProjectLogsService;
import dudu.project.service.ProjectLogsVO;
import dudu.service.ProjectVO;
import dudu.sql.CommonDAO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("projectLogsService")
public class ProjectLogsServiceImpl extends EgovAbstractServiceImpl implements ProjectLogsService {
	
	@Resource(name="projectLogsDAO")
	private ProjectLogsDAO projectLogsDAO;
	
	@Resource(name="commonDAO")
	private CommonDAO commondao;
	
	@Resource(name = "projectLogsService")
	private ProjectLogsService projectLogsService;
	
	@Override
	public List<?> getLogNum(ProjectLogsVO plvo) throws Exception {
//		System.out.println("p넘버1: " + projectLogsDAO.getLogNum(pjvo.getPjno()));
//		return projectLogsDAO.getLogNum(pjvo.getPjno());
		System.out.println("p넘버1: " + projectLogsDAO.getLogNum(plvo.getPjno()));
		return projectLogsDAO.getLogNum(plvo.getPjno());
	}
	
	@Override
	public List<ProjectLogsVO> plList(ProjectLogsVO vo) throws Exception {
		return projectLogsDAO.plList(vo);
	}
	
	@Override
	public int plListChk(ProjectLogsVO plvo) throws Exception {
		return projectLogsDAO.plListChk(plvo);
	}
	
	@Override
	public void plInsert(ProjectLogsVO plvo) throws Exception {
		projectLogsDAO.plInsert(plvo);
	}
	
	@Override
	public void plCopyInsert(ProjectLogsVO plvo) throws Exception {
		projectLogsDAO.plCopyInsert(plvo);
	}
	
	@Override
	public void plUpdate(ProjectLogsVO plvo) throws Exception {
		projectLogsDAO.plUpdate(plvo);
	}
	
}
