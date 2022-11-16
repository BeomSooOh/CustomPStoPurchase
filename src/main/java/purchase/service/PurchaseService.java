package purchase.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface PurchaseService {

	public List<Map<String, Object>> SelectPurchaseDetailCodeList ( Map<String, Object> params );
	
	public List<Map<String, Object>> SelectContractList ( Map<String, Object> params );
	
	public Map<String, Object> InsertContract ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException;
	
	public boolean InsertAttachList ( List<Map<String, Object>> params );
	
}
