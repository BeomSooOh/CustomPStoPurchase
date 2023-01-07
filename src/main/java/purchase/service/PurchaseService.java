package purchase.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

public interface PurchaseService {

	public Map<String, Object> InsertPurchase ( Map<String, Object> params ) throws JsonParseException, JsonMappingException, IOException;
}
