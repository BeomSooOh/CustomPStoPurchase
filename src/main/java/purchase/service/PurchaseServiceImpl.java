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
    
    @Resource(name = "CommonServiceDAO")
    private CommonServiceDAO commonServiceDAO;         
	
	public Map<String, Object> InsertPurchase ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException{
		
		//입찰계약정보 등록
		if(params.get("viewType").equals("I")) {
			Map<String, Object> result = purchaseServiceDAO.InsertPurchase(params);	
			params.put("seq", result.get("seq"));
		}else {
			purchaseServiceDAO.UpdatePurchase(params);	
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
		
		//물품정보 저장
		jsonStr = (String)params.get("item_list_info");
		mapper = new ObjectMapper();
		
		@SuppressWarnings("unused")
		List<Map<String, Object>> itemList = new ArrayList<Map<String, Object>>();
		itemList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		if(params.get("viewType").equals("U")) {
			purchaseServiceDAO.DeleteItemInfo(params);	
		}
		
		for (Map<String, Object> map : itemList) {
			map.put("seq", params.get("seq"));
			map.put("outProcessCode", params.get("outProcessCode"));
			map.put("created_by", params.get("created_by"));
			purchaseServiceDAO.InsertItemInfo(map);
		}		
		
		
		return params;
		
	}		

}

