package purchase.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import neos.cmm.util.BizboxAProperties;

@Service("PurchaseService")
public class PurchaseServiceImpl implements PurchaseService {

    @Resource(name = "PurchaseServiceDAO")
    private PurchaseServiceDAO purchaseServiceDAO;    	
	
	public List<Map<String, Object>> SelectPurchaseDetailCodeList ( Map<String, Object> params ){
		return purchaseServiceDAO.SelectPurchaseDetailCodeList(params);
	}
	
	public List<Map<String, Object>> SelectContractList ( Map<String, Object> params ){
		return purchaseServiceDAO.SelectContractList(params);
	}	
	
	public Map<String, Object> InsertContract ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		//입찰계약정보 등록
		if(params.get("viewType").equals("I")) {
			Map<String, Object> result = purchaseServiceDAO.InsertContract(params);	
			params.put("seq", result.get("seq"));
		}else {
			purchaseServiceDAO.UpdateContract(params);	
		}
		
		//첨부파일정보 저장
		String jsonStr = (String)params.get("attch_file_info");
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> attachList = new ArrayList<Map<String, Object>>();
		attachList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		if(params.get("viewType").equals("U")) {
			purchaseServiceDAO.DeleteAttachInfo(params);	
		}
		
		for (Map<String, Object> map : attachList) {
			if(map.get("fileId") != null && !map.get("fileId").equals("")) {
				map.put("seq", params.get("seq"));
				map.put("outProcessCode", params.get("outProcessCode"));
				map.put("created_by", params.get("created_by"));
				purchaseServiceDAO.InsertAttachInfo(map);
			}
		}
		
		return params;
		
	}
	
	public Map<String, Object> UpdateAttachInfo ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		//기존파일정보 삭제
		purchaseServiceDAO.DeleteAttachInfo(params);
		
		//첨부파일정보 저장
		String jsonStr = (String)params.get("attch_file_info");
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> attachList = new ArrayList<Map<String, Object>>();
		attachList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		for (Map<String, Object> map : attachList) {
			if(map.get("fileId") != null && !map.get("fileId").equals("")) {
				map.put("seq", params.get("seq"));
				map.put("outProcessCode", params.get("outProcessCode"));
				map.put("created_by", params.get("created_by"));
				purchaseServiceDAO.InsertAttachInfo(map);
			}
		}
		
		return params;
		
	}	
	
	public void UpdateAppr ( Map<String, Object> params ) {
		//임시저장{processId=Contract01, approKey=Contract01_77, docId=3618, docSts=10, appSts=10, groupSeq=st, compSeq=1000, bizSeq=1000, deptSeq=1010, empSeq=1, userId=admin, langCode=kr, userSe=USER, erpEmpSeq=1910292, erpCompSeq=2014, docNum=, dfId=admin, dfErpEmpSeq=1910292, dfEmpSeq=1, dfDeptSeq=1010, formId=304, docTitle=123123123}
		
		if(params.get("processId").equals("Contract01")) {
			params.put("approkeyPlan", params.get("approKey"));
			params.put("seq", params.get("approKey").toString().split("_")[1]);
		}else if(params.get("processId").equals("Contract02")) {
			params.put("approkeyMeet", params.get("approKey"));
			params.put("seq", params.get("approKey").toString().split("_")[1]);
		}else if(params.get("processId").equals("Contract03")) {
			params.put("approkeyResult", params.get("approKey"));
			params.put("seq", params.get("approKey").toString().split("_")[1]);
		}
		
		purchaseServiceDAO.UpdateAppr(params);
		
		/*
		try {
			SendMailAlert(params.get("groupSeq").toString(), params.get("compSeq").toString(), "제목입니다.", "내용입니다.", "");
		} catch (EmailException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
		
	}
	
	@SuppressWarnings("deprecation")
	public boolean SendMailAlert ( String groupSeq, String compSeq, String subject, String contents, String mailTo ) throws EmailException {
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("groupSeq", groupSeq);
		params.put("compSeq", compSeq);
		Map<String, Object> groupInfo = purchaseServiceDAO.GetGroupInfo ( params );
		Map<String, Object> compInfo = purchaseServiceDAO.GetCompInfo ( params );
		
		String smtpServer = "";
		String smtpPort = "25";
		String smtpId = "";
		String smtpPw = "";
		String groupEmailName = "그룹웨어시스템";
		String groupEmailId = "groupwaresystem";
		String groupEmailDomain = compInfo != null && compInfo.get("email_domain") != null && !compInfo.get("email_domain").equals("") ? compInfo.get("email_domain").toString() : "";
		
		if(groupInfo.get("group_email_name") != null && !groupInfo.get("group_email_name").equals("")) {
			groupEmailName = groupInfo.get("group_email_name").toString();
		}
		
		if(groupInfo.get("group_email_id") != null && !groupInfo.get("group_email_id").equals("")) {
			groupEmailId = groupInfo.get("group_email_id").toString();
		}  
		
		if(groupInfo.get("group_email_domain") != null && !groupInfo.get("group_email_domain").equals("")) {
			groupEmailDomain = groupInfo.get("group_email_domain").toString();
		}
		
		if(groupInfo.get("out_smtp_use_yn") != null && !groupInfo.get("out_smtp_use_yn").equals("Y") && groupInfo.get("smtp_server") != null && !groupInfo.get("smtp_server").equals("")) {
			smtpServer = groupInfo.get("smtp_server").toString();
			smtpPort = groupInfo.get("smtp_port").toString();
			smtpId = groupInfo.get("smtp_id").toString();
			smtpPw = groupInfo.get("smtp_pw").toString();
		}else {
			
			//프로퍼티 설정값이 있을경우 우선으로 처리
			if(!BizboxAProperties.getProperty("BizboxA.smtp.url").equals("99")) {
				
				smtpServer = BizboxAProperties.getProperty("BizboxA.smtp.url");
				
				if(!BizboxAProperties.getProperty("BizboxA.smtp.port").equals("99")) {
					smtpPort = BizboxAProperties.getProperty("BizboxA.smtp.port");
				}

				if(BizboxAProperties.getProperty("BizboxA.smtp.auth").equals("Y")) {
					
					if(!BizboxAProperties.getProperty("BizboxA.smtp.auth.id").equals("99")) {
						smtpId = BizboxAProperties.getProperty("BizboxA.smtp.auth.id");		
					}
					
					if(!BizboxAProperties.getProperty("BizboxA.smtp.auth.password").equals("99")) {
						smtpPw = BizboxAProperties.getProperty("BizboxA.smtp.auth.password");		
					}
					
				}
				
			}else if(groupInfo.get("mail_url") != null && !groupInfo.get("mail_url").equals("")) {
				
				String mailUrl = groupInfo.get("mail_url").toString();
				mailUrl = mailUrl.split("://")[1];
				mailUrl = mailUrl.split("/mail")[0];
				smtpServer = mailUrl.split(":")[0];
				
			}
		}
		
		if(smtpServer.equals("") || groupEmailDomain.equals("")) {
			return false;
		}
    	
    	//메일전송
		HtmlEmail email = new HtmlEmail();
		email.setCharset("UTF-8");
		email.setHostName(smtpServer);
		email.setSmtpPort(Integer.parseInt(smtpPort)); 
		
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
		email.setFrom(groupEmailId + "@" + groupEmailDomain, groupEmailName);
		email.addTo(mailTo);
		
		/*
		for(String to : mailTo){
			email.addTo(to);
    	}
		*/
		
		email.setSubject(subject);
		email.setHtmlMsg(contents);
		
		try {
			email.send();
		}catch(Exception ex) {
			return false;
		}		
		
		return true;
	}
}

