package purchase.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface CommonService {

	public List<Map<String, Object>> SelectPurchaseDetailCodeList ( Map<String, Object> params );
	
	public Map<String, Object> updateCommonCodeProc ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException;
	
	public Map<String, Object> deleteCommonCodeProc ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException;
	
	public Map<String, Object> UpdateAttachInfo ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException;

	public void SaveFormInfo ( Map<String, Object> params );
	
	public void UpdateAppr ( Map<String, Object> params );
	
	public void DelConsTemp ( Map<String, Object> params );
	
}
