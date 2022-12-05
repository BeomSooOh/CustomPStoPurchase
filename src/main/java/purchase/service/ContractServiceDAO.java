
package purchase.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Repository("ContractServiceDAO")
public class ContractServiceDAO extends EgovComAbstractDAO {
 
	@SuppressWarnings("unchecked")
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
	public Map<String, Object> SelectConclusionChangeDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "PurchaseSQL.SelectConclusionChangeDetail", params );
	}	
	
	public int SelectContractSeqFromManageNo ( Map<String, Object> params ) {
		return (int) select( "PurchaseSQL.SelectContractSeqFromManageNo", params );
	}	
	
	public Map<String, Object> InsertContract ( Map<String, Object> params ) {
		
		int seq = 0;
		insert( "PurchaseSQL.InsertContract", params );
		seq = (int) select( "PurchaseSQL.SelectContractSeqFromManageNo", params );
				
		params.put("seq", seq);
		
		return params;
	}	
	
	public Map<String, Object> InsertConclusion ( Map<String, Object> params ) {
		
		int seq = 0;
		insert( "PurchaseSQL.InsertConclusion", params );
		seq = (int) select( "PurchaseSQL.SelectContractSeqFromManageNo", params );
				
		params.put("seq", seq);
		
		return params;
	}	
	
	public Map<String, Object> InsertConclusionChange ( Map<String, Object> params ) {
		insert( "PurchaseSQL.InsertConclusionChange", params );
		return params;
	}	
	
	public void UpdateContract ( Map<String, Object> params ) {
		
		update( "PurchaseSQL.UpdateContract", params );
		
	}
	
	public void UpdateConclusion ( Map<String, Object> params ) {
		
		update( "PurchaseSQL.UpdateConclusion", params );
		
	}	
	
	public void UpdateConclusionChange ( Map<String, Object> params ) {
		
		update( "PurchaseSQL.UpdateConclusionChange", params );
		
	}		
	
	public void UpdateMeet ( Map<String, Object> params ) {
		
		update( "PurchaseSQL.UpdateMeet", params );
		
	}	
	
	public void UpdateResult ( Map<String, Object> params ) {
		
		update( "PurchaseSQL.UpdateResult", params );
		
	}		
	
	
}
