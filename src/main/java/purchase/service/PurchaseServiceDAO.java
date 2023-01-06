
package purchase.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("PurchaseServiceDAO")
public class PurchaseServiceDAO extends EgovComAbstractDAO {
 
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> SelectContractList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "PurchaseSQL.SelectContractList", params );
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> SelectPurchaseList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "PurchaseSQL.SelectPurchaseList", params );
		return result;
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectPurchaseDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "PurchaseSQL.SelectPurchaseDetail", params );
	}
	
	public Map<String, Object> InsertPurchase ( Map<String, Object> params ) {
		insert( "PurchaseSQL.InsertPurchase", params );
		return params;
	}	
	
	public void UpdatePurchase ( Map<String, Object> params ) {
		update( "PurchaseSQL.UpdatePurchase", params );
	}	
	
	public void DeleteItemInfo ( Map<String, Object> params ) {
		delete( "PurchaseSQL.DeleteItemInfo", params );
	}
	
	public void InsertItemInfo ( Map<String, Object> params ) {
		insert( "PurchaseSQL.InsertItemInfo", params );
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectItemList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "PurchaseSQL.SelectItemList", params );
		return result;
	}	
	
}
