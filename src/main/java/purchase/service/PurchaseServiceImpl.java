package purchase.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.NotImplementedException;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExReportCardVO;
import common.vo.ex.ExSendStatVO;
import common.vo.ex.ExpendVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import expend.ex.admin.config.FExAdminConfigService;

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
		Map<String, Object> result = purchaseServiceDAO.InsertContract(params);
		
		//첨부파일정보 저장
		String jsonStr = (String)params.get("attch_file_info");
		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, Object>> attachList = new ArrayList<Map<String, Object>>();
		attachList = mapper.readValue(jsonStr, new TypeReference<List<Map<String, Object>>>(){});
		
		for (Map<String, Object> map : attachList) {
			if(map.get("fileId") != null && !map.get("fileId").equals("")) {
				map.put("seq", result.get("seq"));
				map.put("outProcessCode", params.get("outProcessCode"));
				map.put("created_by", params.get("created_by"));
				purchaseServiceDAO.InsertAttachInfo(map);
			}
		}
		
		return params;
		
	}
	
	public boolean InsertAttachList ( List<Map<String, Object>> params ) {
		
		
		
		
		return true;
	}
}

