
package purchase.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("PurchaseServiceDAO")
public class PurchaseServiceDAO extends EgovComAbstractDAO {
 
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectContractList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "PurchaseSQL.SelectContractList", params );
		return result;
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectContractDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "PurchaseSQL.SelectContractDetail", params );
	}
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectPurchaseDetailCodeList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "PurchaseSQL.SelectPurchaseDetailCodeList", params );
		return result;
	}	
	
	public Map<String, Object> InsertContract ( Map<String, Object> params ) {
		
		int result = 0;
		super.insert( "PurchaseSQL.InsertContract", params );
		result = Integer.parseInt(params.get("seq").toString());
				
		params.put("newSeq", result);
		
		return params;
	}		
	
}
