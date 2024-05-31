package dudu.member.login.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dudu.member.login.service.DuduLoginService;
import dudu.member.login.service.DuduLoginVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.config.EgovLoginConfig;
import egovframework.com.cmm.service.EgovCmmUseService;
import egovframework.com.uat.uia.service.EgovLoginService;

@Controller
public class DuduLoginController {
	/** EgovLoginService */
	@Resource(name = "loginService")
	private EgovLoginService loginService;

	/** EgovCmmUseService */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;

	@Resource(name = "duduLoginService")
	private DuduLoginService duduLoginService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "egovLoginConfig")
	EgovLoginConfig egovLoginConfig;

	/** log */
	private static final Logger LOGGER = LoggerFactory.getLogger(DuduLoginController.class);

	/** 로그인 */
	@SuppressWarnings("null")
	@RequestMapping(value = "/login.do")
	public String LoginDo(@ModelAttribute("duduLoginVO") DuduLoginVO duduLoginVO, HttpServletRequest req) throws Exception {

		try {
			DuduLoginVO loggedInUser = duduLoginService.actionLogin(duduLoginVO, req);
			if (loggedInUser.getEmail() != null) {
				if (loggedInUser.getEntrprsMberSttus().equals("미승인")) {
					req.getSession().setAttribute("err_msg", "회원 가입 승인 대기중인 아이디입니다.");
					return "redirect:/main.do";
				}
				return "redirect:/test.do";
			} else {
				req.getSession().setAttribute("err_msg", "이메일과 비밀번호를 확인해주세요");
				return "redirect:/main.do";
			}

		} catch (Exception e) {
			e.printStackTrace();
			return "error-page";
		}
	}

	/** 로그아웃 */
	@RequestMapping(value = "/logout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) throws Exception {
		request.getSession().setAttribute("loginMember", null);
		
		// 로그아웃 컨트롤러나 서비스에서 세션 초기화
		HttpSession session = request.getSession(false); // 기존 세션이 없으면 새로 생성하지 않음
		if (session != null) {
			String userId = (String) session.getAttribute("userId");
			session.removeAttribute("loginMessageDisplayed_" + userId);
			session.invalidate(); // 세션 무효화 (선택 사항)
		}
		
		/* model.addAttribute("logout", "로그아웃 되었습니다."); */
		
		return "redirect:/main.do";
	}

	@RequestMapping("/checkPw.do")
	@SuppressWarnings("null")
	@ResponseBody
	public String checkPw(@ModelAttribute("duduLoginVO") DuduLoginVO duduLoginVO,  HttpServletRequest request, RedirectAttributes redirect) throws Exception{		
		System.out.println("duduLoginVO:"+duduLoginVO);
		System.out.println("email:"+duduLoginVO.getEmail());
		System.out.println("password:"+duduLoginVO.getPassword());
		System.out.println("id:"+duduLoginVO.getId());
		
		DuduLoginVO loggedInUser = duduLoginService.actionLogin(duduLoginVO, request);
		System.out.println("loggedInUser:"+loggedInUser);
		
		if(loggedInUser.getName()!=null) {
			return "1";
		}else {
			return "0";
		}
	}
	
}
