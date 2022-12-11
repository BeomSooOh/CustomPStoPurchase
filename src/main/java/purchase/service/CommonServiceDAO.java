
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
		return (Map<String, Object>) select( "CommonSQL.getGroupInfo", params );
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> GetGroupPathInfo ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "CommonSQL.getGroupPathInfo", params );
	}	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> GetCompInfo ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "CommonSQL.getCompInfo", params );
	}
	
	public String GetCodeText ( Map<String, Object> params ) {
		
		String resultStr = "";
		
		Map<String, Object> result = (Map<String, Object>) select( "CommonSQL.SelectCodeValueText", params );
		
		if(result != null) {
			resultStr = result.get("value_name").toString();
		}
		
		return resultStr;
	}	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectApprFormData ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "CommonSQL.SelectApprFormData", params );
	}	
	
	public int SelectContractSeqFromManageNo ( Map<String, Object> params ) {
		return (int) select( "CommonSQL.SelectContractSeqFromManageNo", params );
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectPurchaseDetailCodeList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectPurchaseDetailCodeList", params );
		return result;
	}	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectPurchaseDetailCodeInfo ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "CommonSQL.SelectPurchaseDetailCodeInfo", params );
	}
	
	public void UpdateAppr ( Map<String, Object> params ) {
		
		update( "CommonSQL.UpdateAppr", params );
		
	}	
	
	public void UpdateApprChange ( Map<String, Object> params ) {
		
		update( "CommonSQL.UpdateApprChange", params );
		
	}	
	
	public void SaveFormInfo ( Map<String, Object> params ) {
		
		update( "CommonSQL.SaveFormInfo", params );
		
	}		
	
	public void DeleteAttachInfo ( Map<String, Object> params ) {
		
		delete( "CommonSQL.DeleteAttachInfo", params );
		
	}
	
	public void InsertAttachInfo ( Map<String, Object> params ) {
		
		insert( "CommonSQL.InsertAttachInfo", params );
		
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectAttachList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectAttachList", params );
		return result;
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectFormAttachList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectFormAttachList", params );
		return result;
	}	
	
	public void DeleteBudgetInfo ( Map<String, Object> params ) {
		
		delete( "CommonSQL.DeleteBudgetInfo", params );
		
	}
	
	public void InsertBudgetInfo ( Map<String, Object> params ) {
		
		insert( "CommonSQL.InsertBudgetInfo", params );
		
	}
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectBudgetList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectBudgetList", params );
		return result;
	}	
	
	
}
