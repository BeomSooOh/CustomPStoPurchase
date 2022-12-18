
package purchase.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("ContractServiceDAO")
public class ContractServiceDAO extends EgovComAbstractDAO {
 
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> SelectContractList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ContractSQL.SelectContractList", params );
		return result;
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectContractDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "ContractSQL.SelectContractDetail", params );
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectConclusionChangeDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "ContractSQL.SelectConclusionChangeDetail", params );
	}	
	
	public int SelectContractSeqFromManageNo ( Map<String, Object> params ) {
		return (int) select( "ContractSQL.SelectContractSeqFromManageNo", params );
	}	
	
	public Map<String, Object> InsertContract ( Map<String, Object> params ) {
		
		int seq = 0;
		insert( "ContractSQL.InsertContract", params );
		seq = (int) select( "ContractSQL.SelectContractSeqFromManageNo", params );
				
		params.put("seq", seq);
		
		return params;
	}	
	
	public Map<String, Object> InsertConclusion ( Map<String, Object> params ) {
		
		int seq = 0;
		insert( "ContractSQL.InsertConclusion", params );
		seq = (int) select( "ContractSQL.SelectContractSeqFromManageNo", params );
				
		params.put("seq", seq);
		
		return params;
	}	
	
	public Map<String, Object> InsertConclusionChange ( Map<String, Object> params ) {
		insert( "ContractSQL.InsertConclusionChange", params );
		return params;
	}	
	
	public void UpdateContract ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateContract", params );
		
	}
	
	public void UpdateConclusion ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateConclusion", params );
		
	}	
	
	public void UpdateConclusionChange ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateConclusionChange", params );
		
	}		
	
	public void UpdateMeet ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateMeet", params );
		
	}	
	
	public void UpdateResult ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateResult", params );
		
	}
	
	public Map<String, Object> SelectConclusionPaymentList (Map<String, Object> paramMap, PaginationInfo paginationInfo) {
		
		return super.listOfPaging2(paramMap, paginationInfo, "ContractSQL.SelectConclusionPaymentList");
		
	}	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectConclusionPaymentAmt ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "ContractSQL.SelectConclusionPaymentAmt", params );
		
	}		
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectConclusionPaymentDocInfo ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "ContractSQL.SelectConclusionPaymentDocInfo", params );
		
	}		
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectConclutionPaymentDocInfoCheck ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "ContractSQL.SelectConclutionPaymentDocInfoCheck", params );
		
	}		
	
	
}
