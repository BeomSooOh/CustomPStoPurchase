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
	
	public List<Map<String, Object>> SelectPurchaseList ( Map<String, Object> params ){
		return purchaseServiceDAO.SelectPurchaseList(params);
	}		
	

}

