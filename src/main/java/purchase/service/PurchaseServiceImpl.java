package purchase.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.NotImplementedException;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;
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
	
	public Map<String, Object> InsertContract ( Map<String, Object> params ){
		return purchaseServiceDAO.InsertContract(params);
	}
}

