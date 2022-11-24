package purchase;

import javax.annotation.Resource;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Service;

import purchase.service.PurchaseService;
import purchase.service.PurchaseServiceDAO;

public class PurchaseTest {
	
	public static void main(String[] args) throws EmailException {
		
    	//메일전송
		/*
		HtmlEmail email = new HtmlEmail();
		email.setCharset("UTF-8");
		email.setHostName("gw.st-tech.org");
		email.setSmtpPort(25);
		
		//TLS or SSL
		if(groupInfo.get("smtpSecuTp") != null) {
			if(groupInfo.get("smtpSecuTp").equals("TLS")) {
				email.setTLS(true);
			}else if(groupInfo.get("smtpSecuTp").equals("SSL")) {
				email.setSSL(true);
			}
		}
		
		if(!smtpId.equals("") && !smtpPw.equals("")) {
			email.setAuthenticator(new DefaultAuthenticator(smtpId, smtpPw));
		}
		
		email.setSocketConnectionTimeout(60000);
		email.setSocketTimeout(60000);
		email.setFrom("admin11111@st-tech.org");
		email.addTo("ohk0306@gmail.com");
		
		for(String to : mailTo){
			email.addTo(to);
    	}
		
		email.setSubject("제목입니다.");
		email.setHtmlMsg("내용입니다.");		
		
		email.send();
		*/
		
		String temp = "{1}, {1}, {1}";
		System.out.println(temp.replace("{1}", "{22}"));
		
	}
	
}
