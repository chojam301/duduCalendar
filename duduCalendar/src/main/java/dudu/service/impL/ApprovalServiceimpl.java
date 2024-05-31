package dudu.service.impL;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import dudu.sql.CommonDAO;
import dudu.service.ApprovalVO;
import dudu.member.login.service.DuduLoginVO;
import dudu.service.ApprovalService;
import dudu.service.PageVO;

@Service
public class ApprovalServiceimpl implements ApprovalService {
	
	@Resource(name="commonDAO")
	private CommonDAO commondao;
	
	/*결재함 목록*/
	@Override
	public void appinsert(ApprovalVO vo) {
		commondao.insert("ApprovalDAO.appinsert",vo);
	}
	

	/*결재함 상세페이지*/
	@Override
	public ApprovalVO detailapp(int appauto) {
		return commondao.selectOne("ApprovalDAO.detailapp",appauto);
	}
	
	/*결재 승인*/
	@Override
	public void appupdate(ApprovalVO vo) throws Exception {
		commondao.update("ApprovalDAO.appupdate",vo);
	}
	/*결재 반려*/
	@Override
	public void appback(ApprovalVO vo) {
		commondao.update("ApprovalDAO.appback",vo);
	}
	
	int pageLimit = 7;
	int blockLimit =7;
	
	/*결재함 목록 페이징*/
	@Override
	public List<ApprovalVO> applist(DuduLoginVO vo,int page, String appstatus)throws Exception{
		int pagingStart = (page - 1) * pageLimit;
		Map<String, Object> pagingParams = new HashMap<>();
		pagingParams.put("start", pagingStart);
		pagingParams.put("limit", pageLimit);
		pagingParams.put("auth",Integer.parseInt(vo.getAuth()));
		pagingParams.put("name", vo.getName());
		pagingParams.put("email", vo.getEmail());
		pagingParams.put("appstatus", appstatus);
		System.out.println("pagingParams = "+pagingParams);
		List<ApprovalVO> applist = commondao.selectList("ApprovalDAO.applist",pagingParams);

		return applist;
	}
	
	@Override
	public PageVO pagingParam(int page,String appstatus,DuduLoginVO loginvo) {
		Map<String, Object> vo = new HashMap<>();
		vo.put("auth", Integer.parseInt(loginvo.getAuth()));
		vo.put("email",loginvo.getEmail());
		vo.put("name",loginvo.getName());
		System.out.println("auth = "+ loginvo.getAuth());
		vo.put("appstatus", appstatus);
	int count = commondao.selectOne("ApprovalDAO.count",vo);
	System.out.println("count = "+count);
	int maxPage = (int)(Math.ceil((double) count / pageLimit));
	int startPage = (((int)(Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
	
	int endPage = startPage + blockLimit - 1;
	if(endPage > maxPage) {
		endPage = maxPage;
	}
	
	PageVO pagevo = new PageVO();
	
	pagevo.setPage(page);
	pagevo.setMaxPage(maxPage);
	pagevo.setStartPage(startPage);
	pagevo.setEndpage(endPage);
	return pagevo;
}
	
	/*결재 알림 목록*/
	@Override
	public int CCC(DuduLoginVO loginvo,String appstatus) {
		Map<String, Object> vo = new HashMap<>();
		vo.put("auth", loginvo.getAuth());
		vo.put("appstatus", appstatus);
		vo.put("name",loginvo.getName());
		vo.put("email",loginvo.getEmail());
		System.out.println("email = "+loginvo.getEmail());
		
		System.out.println("appstatus = "+appstatus);
		return commondao.selectOne("ApprovalDAO.cnt",vo);
	}
	
}
