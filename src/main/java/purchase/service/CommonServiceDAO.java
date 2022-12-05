
package purchase.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("CommonServiceDAO")
public class CommonServiceDAO extends EgovComAbstractDAO {
 
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> GetGroupInfo ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "PurchaseSQL.getGroupInfo", params );
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> GetCompInfo ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "PurchaseSQL.getCompInfo", params );
	}
	
	public String GetCodeText ( Map<String, Object> params ) {
		
		String resultStr = "";
		
		Map<String, Object> result = (Map<String, Object>) select( "PurchaseSQL.SelectCodeValueText", params );
		
		if(result != null) {
			resultStr = result.get("value_name").toString();
		}
		
		return resultStr;
	}	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectApprFormData ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "PurchaseSQL.SelectApprFormData", params );
	}	
	
	public int SelectContractSeqFromManageNo ( Map<String, Object> params ) {
		return (int) select( "PurchaseSQL.SelectContractSeqFromManageNo", params );
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectPurchaseDetailCodeList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "PurchaseSQL.SelectPurchaseDetailCodeList", params );
		return result;
	}	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectPurchaseDetailCodeInfo ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "PurchaseSQL.SelectPurchaseDetailCodeInfo", params );
	}
	
	public void UpdateAppr ( Map<String, Object> params ) {
		
		update( "PurchaseSQL.UpdateAppr", params );
		
	}	
	
	public void SaveFormInfo ( Map<String, Object> params ) {
		
		update( "PurchaseSQL.SaveFormInfo", params );
		
	}		
	
	public void DeleteAttachInfo ( Map<String, Object> params ) {
		
		delete( "PurchaseSQL.DeleteAttachInfo", params );
		
	}
	
	public void InsertAttachInfo ( Map<String, Object> params ) {
		
		insert( "PurchaseSQL.InsertAttachInfo", params );
		
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectAttachList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "PurchaseSQL.SelectAttachList", params );
		return result;
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectFormAttachList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "PurchaseSQL.SelectFormAttachList", params );
		return result;
	}	
	
	
}
