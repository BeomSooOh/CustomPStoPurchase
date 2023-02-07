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

import neos.cmm.util.CommonEventSend;

@Service("ContractService")
public class ContractServiceImpl implements ContractService {

    @Resource(name = "ContractServiceDAO")
    private ContractServiceDAO contractServiceDAO;    
    
    @Resource(name = "CommonServiceDAO")
    private CommonServiceDAO commonServiceDAO;     
	
	public Map<String, Object> InsertContract ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		//입찰계약정보 등록
		if(params.get("viewType").equals("I")) {
			Map<String, Object> result = contractServiceDAO.InsertContract(params);	
			params.put("seq", result.get("seq"));
		}else {
			contractServiceDAO.UpdateContract(params);	
		}
		
		//첨부파일정보 저장
		String jsonStr = (String)params.get("attch_file_info");
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> attachList = new ArrayList<Map<String, Object>>();
		attachList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		if(params.get("viewType").equals("U")) {
			commonServiceDAO.DeleteAttachInfo(params);	
		}
		
		for (Map<String, Object> map : attachList) {
			if(map.get("fileId") != null && !map.get("fileId").equals("")) {
				map.put("seq", params.get("seq"));
				map.put("outProcessCode", params.get("outProcessCode"));
				map.put("created_by", params.get("created_by"));
				commonServiceDAO.InsertAttachInfo(map);
			}
		}
		
		return params;
		
	}
	
	
	public Map<String, Object> ContractAdminChangeProc ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		//변경정보 리스트화
		String jsonStr = (String)params.get("change_info_list");
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> changeInfoList = new ArrayList<Map<String, Object>>();
		changeInfoList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		for (Map<String, Object> map : changeInfoList) {
			
			contractServiceDAO.UpdateContractAdmin(map);
			
			if(map.containsKey("contract_attach_info") || map.containsKey("notice_start_dt") || map.containsKey("notice_end_dt")) {
				
				Map<String, Object> contractInfo = contractServiceDAO.SelectContractDetail(map);
				
				if(contractInfo != null) {
					
					if((map.containsKey("notice_start_dt") || map.containsKey("notice_end_dt")) && !contractInfo.get("notice_start_dt").equals("") && !contractInfo.get("notice_end_dt").equals("")) {
						
						//본 공고기간 등록 알림이벤트 전송
						Map<String, Object> eventParam = new HashMap<String,Object>();
						eventParam.put("eventType", "CUST");
						eventParam.put("eventSubType", "PURCHASE001");
						eventParam.put("groupSeq", params.get("groupSeq"));
						eventParam.put("compSeq", params.get("compSeq"));
						eventParam.put("empSeq", params.get("empSeq"));
						eventParam.put("url", "/CustomPStoPurchase/purchase/user/ContractList.do");
						
						Map<String, Object> eventData = new HashMap<String,Object>();
						
						String title = "[공고기간 등록알림] " + contractInfo.get("title");
						String contents = title;
						contents += "\r\n 등록자 : " + params.get("empName");
						contents += "\r\n 공고기간 : " + contractInfo.get("notice_start_dt") + " ~ " + contractInfo.get("notice_end_dt");
						
						eventData.put("title", title);
						eventData.put("contents", contents);
						eventData.put("userSeq", params.get("empSeq"));
						
						List<Map<String, Object>> recvEmpList = new ArrayList<Map<String, Object>>();
						Map<String, Object> recvEmpInfo = new HashMap<String,Object>();
						recvEmpInfo.put("empSeq", contractInfo.get("write_emp_seq"));
						recvEmpList.add(recvEmpInfo);
						
						eventParam.put("eventData", eventData);
						eventParam.put("recvEmpList", recvEmpList);
						
						CommonEventSend.commonEventSend(eventParam);
						
					}						
					
					if(map.containsKey("contract_attach_info")) {
						
						//계약서 등록 알림이벤트 전송
						Map<String, Object> eventParam = new HashMap<String,Object>();
						eventParam.put("eventType", "CUST");
						eventParam.put("eventSubType", "PURCHASE001");
						eventParam.put("groupSeq", params.get("groupSeq"));
						eventParam.put("compSeq", params.get("compSeq"));
						eventParam.put("empSeq", params.get("empSeq"));
						eventParam.put("url", "/CustomPStoPurchase/purchase/user/ContractList.do");
						
						Map<String, Object> eventData = new HashMap<String,Object>();
						
						String title = "[계약서 등록알림] " + contractInfo.get("c_title");
						String contents = title;
						contents += "\r\n 등록자 : " + params.get("empName");
						
						eventData.put("title", title);
						eventData.put("contents", contents);
						eventData.put("userSeq", params.get("empSeq"));
						
						List<Map<String, Object>> recvEmpList = new ArrayList<Map<String, Object>>();
						Map<String, Object> recvEmpInfo = new HashMap<String,Object>();
						recvEmpInfo.put("empSeq", contractInfo.get("c_write_emp_seq"));
						recvEmpList.add(recvEmpInfo);
						
						eventParam.put("eventData", eventData);
						eventParam.put("recvEmpList", recvEmpList);
						
						CommonEventSend.commonEventSend(eventParam);
						
					}
					
				}
			
				
			}
			

		}
		
		return params;
		
	}	
	
	
	
	public Map<String, Object> InsertConclusion ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		//입찰계약정보 등록
		if(params.get("viewType").equals("I")) {
			Map<String, Object> result = contractServiceDAO.InsertConclusion(params);	
			params.put("seq", result.get("seq"));
		}else {
			contractServiceDAO.UpdateConclusion(params);	
		}
		
		//첨부파일정보 저장
		String jsonStr = (String)params.get("attch_file_info");
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> attachList = new ArrayList<Map<String, Object>>();
		attachList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		if(params.get("viewType").equals("U")) {
			commonServiceDAO.DeleteAttachInfo(params);	
		}
		
		for (Map<String, Object> map : attachList) {
			if(map.get("fileId") != null && !map.get("fileId").equals("")) {
				map.put("seq", params.get("seq"));
				map.put("outProcessCode", params.get("outProcessCode"));
				map.put("created_by", params.get("created_by"));
				commonServiceDAO.InsertAttachInfo(map);
			}
		}
		
		//예산정보 저장
		jsonStr = (String)params.get("budget_list_info");
		mapper = new ObjectMapper();
		
		@SuppressWarnings("unused")
		List<Map<String, Object>> budgetList = new ArrayList<Map<String, Object>>();
		budgetList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		if(params.get("viewType").equals("U")) {
			commonServiceDAO.DeleteBudgetInfo(params);	
		}
		
		for (Map<String, Object> map : budgetList) {
			map.put("seq", params.get("seq"));
			map.put("outProcessCode", params.get("outProcessCode"));
			map.put("created_by", params.get("created_by"));
			commonServiceDAO.InsertBudgetInfo(map);
		}
		
		
		//결재정보 저장
		jsonStr = (String)params.get("trade_list_info");
		mapper = new ObjectMapper();
		
		@SuppressWarnings("unused")
		List<Map<String, Object>> tradeList = new ArrayList<Map<String, Object>>();
		tradeList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		if(params.get("viewType").equals("U")) {
			commonServiceDAO.DeleteTradeInfo(params);		
		}
		
		int tr_inx = 0;
		
		for (Map<String, Object> map : tradeList) {
			
			map.put("tr_idx", tr_inx);
			map.put("seq", params.get("seq"));
			map.put("outProcessCode", params.get("outProcessCode"));
			map.put("created_by", params.get("created_by"));
			commonServiceDAO.InsertTradeInfo(map);
			tr_inx ++;
		}		
		
		return params;
		
	}	
	
	public Map<String, Object> InsertConclusionChange ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		//신규등록 
		if(params.get("viewType").equals("I")) {
			Map<String, Object> result = contractServiceDAO.InsertConclusionChange(params);	
			params.put("change_seq", result.get("change_seq"));
		}else {
			contractServiceDAO.UpdateConclusionChange(params);	
		}
		
		//첨부파일정보 저장
		String jsonStr = (String)params.get("attch_file_info");
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> attachList = new ArrayList<Map<String, Object>>();
		attachList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		params.put("seq", params.get("change_seq"));
		
		if(params.get("viewType").equals("U")) {
			commonServiceDAO.DeleteAttachInfo(params);	
		}
		
		for (Map<String, Object> map : attachList) {
			if(map.get("fileId") != null && !map.get("fileId").equals("")) {
				map.put("seq", params.get("change_seq"));
				map.put("outProcessCode", params.get("outProcessCode"));
				map.put("created_by", params.get("created_by"));
				commonServiceDAO.InsertAttachInfo(map);
			}
		}
		
		return params;
		
	}	
	
	public Map<String, Object> UpdateMeet ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		contractServiceDAO.UpdateMeet(params);
		
		//예산정보 저장
		String jsonStr = (String)params.get("budget_list_info");
		ObjectMapper mapper = new ObjectMapper();
		
		@SuppressWarnings("unused")
		List<Map<String, Object>> budgetList = new ArrayList<Map<String, Object>>();
		budgetList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		commonServiceDAO.DeleteBudgetInfo(params);	
		
		for (Map<String, Object> map : budgetList) {
			map.put("seq", params.get("seq"));
			map.put("outProcessCode", params.get("outProcessCode"));
			map.put("created_by", params.get("created_by"));
			commonServiceDAO.InsertBudgetInfo(map);
		}			
		
		return params;
		
	}
	
	public Map<String, Object> deleteContractList ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		String jsonStr = (String)params.get("change_info_list");
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> changeInfoList = new ArrayList<Map<String, Object>>();
		changeInfoList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		Map<String, Object> contractInfo;
		Map<String, Object> consDocInfo;
		
		
		for (Map<String, Object> map : changeInfoList) {
		
			contractInfo = contractServiceDAO.SelectContractDetail(map);
			
			String doc_sts =  (String) contractInfo.get("doc_sts"); 
			
			if (!contractInfo.get("doc_sts").equals("")) {
				params.put("resultCode", "error");
				return params;	
			} 
		}
		for (Map<String, Object> map : changeInfoList) {
			
			contractInfo = contractServiceDAO.SelectContractDetail(map);
			
			consDocInfo = contractServiceDAO.SelectConsDocInfo(map);
			
			contractServiceDAO.deleteConsDoc(map);
			
			contractServiceDAO.deleteConsHead(consDocInfo);
			
			contractServiceDAO.deleteConsBudget(consDocInfo);
			
			contractServiceDAO.deleteContractList(map); 
			
			contractServiceDAO.deleteBudgetInfo(map);
			
			params.put("resultCode", "success");	
		}
		return params;
	}	
	
	
}

