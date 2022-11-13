package purchase.service;

import java.util.List;
import java.util.Map;

public interface PurchaseService {

	public List<Map<String, Object>> SelectPurchaseDetailCodeList ( Map<String, Object> params );
	
	public Map<String, Object> InsertContract ( Map<String, Object> params );
	
}
