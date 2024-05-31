package dudu.service;

import java.util.List;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import dudu.service.DailyVO;

public interface DailyService {
	public void Dailyupdate(DailyVO vo) throws Exception;
	public void Dailydelete(DailyVO vo) throws Exception;
	public void Dailyinsert(DailyVO vo) throws Exception;
	public List<ProjectVO> project(String name) throws Exception;
	public void DailyDateupdate(DailyVO vo) throws Exception;
	public List<DailyVO> pagingList(int page, int pjno);
	public PageVO pagingParam(int page, int pjno);
}
