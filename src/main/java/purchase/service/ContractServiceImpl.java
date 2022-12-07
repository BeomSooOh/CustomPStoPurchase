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

@Service("ContractService")
public class ContractServiceImpl implements ContractService {

    @Resource(name = "ContractServiceDAO")
    private ContractServiceDAO contractServiceDAO;    
    
    @Resource(name = "CommonServiceDAO")
    private CommonServiceDAO commonServiceDAO;     
	
	public List<Map<String, Object>> SelectContractList ( Map<String, Object> params ){
		return contractServiceDAO.SelectContractList(params);
	}	
	
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
	
}

