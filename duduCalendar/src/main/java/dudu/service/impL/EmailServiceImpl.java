package dudu.service.impL;

import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import dudu.sql.CommonDAO;
import dudu.service.UserVO;
import dudu.service.EmailService;

@Service
public class EmailServiceImpl implements EmailService {
	
	@Inject
	JavaMailSender mailSender;
	
	@Resource(name="commonDAO")
	private CommonDAO commondao;
	
	/*이메일 전송*/
	@Override
	public void sendMail(UserVO vo, String str) {
		
		try {
			MimeMessage msg = mailSender.createMimeMessage();
			String password = str;
			msg.addRecipient(RecipientType.TO, new InternetAddress(vo.getUseremail()));
			msg.addFrom(new InternetAddress[] {
					new InternetAddress("######","DUDU Calendar")
			});
			msg.setSubject("인증번호");
			msg.setText("인증번호 입니다. "+password);
			mailSender.send(msg);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	/*비밀번호 변경*/
	@Override
	public void updatePassword(UserVO vo) throws Exception{
		commondao.update("duduDAO.reset",vo);
	}
	
	@Override
	public String getPassword() {
		char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        String str = "";

        int idx = 0;
        for (int i = 0; i < 6; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
			}
        return str;
	}
	
	@Override
	public List<UserVO> userlist(UserVO vo){
		List<UserVO> userlist = commondao.selectList("duduDAO.userlist",vo);
		return userlist;
	}
	
}
