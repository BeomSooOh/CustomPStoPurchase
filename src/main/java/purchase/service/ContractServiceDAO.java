
package purchase.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("ContractServiceDAO")
public class ContractServiceDAO extends EgovComAbstractDAO {
 
	public Map<String, Object> SelectContractList (Map<String, Object> paramMap, PaginationInfo paginationInfo) {
		
		return super.listOfPaging2(paramMap, paginationInfo, "ContractSQL.SelectContractList");
		
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectContractDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "ContractSQL.SelectContractDetail", params );
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectPurchaseDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "ContractSQL.SelectPurchaseDetail", params );
	}
	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectConsdocDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "ContractSQL.SelectConsdocDetail", params );
	}
	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectConclusionChangeDetail ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "ContractSQL.SelectConclusionChangeDetail", params );
	}	
	
	public Map<String, Object> InsertContract ( Map<String, Object> params ) {
		insert( "ContractSQL.InsertContract", params );
		return params;
	}	
	
	public Map<String, Object> InsertConclusion ( Map<String, Object> params ) {
		insert( "ContractSQL.InsertConclusion", params );
		return params;
	}	
	
	public Map<String, Object> InsertConclusionChange ( Map<String, Object> params ) {
		insert( "ContractSQL.InsertConclusionChange", params );
		return params;
	}	
	
	public void UpdateContract ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateContract", params );
		
	}
	
	public void UpdateContractAdmin ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateContractAdmin", params );
		
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
	
	
	public void UpdateModify ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateModify", params );
		
	}
	
	
	public void UpdateModifyStatus ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateModifyStatus", params );
		
	}
	
	public void UpdateApprModify ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateApprModify", params );
		
	}
	
	
	public void UpdateReturnConsdoc ( Map<String, Object> params ) {
		
		update( "ContractSQL.UpdateReturnConsdoc", params );
		
	}
	
	
	public Map<String, Object> SelectConclusionPaymentList (Map<String, Object> paramMap, PaginationInfo paginationInfo) {
		
		return super.listOfPaging2(paramMap, paginationInfo, "ContractSQL.SelectConclusionPaymentList");
		
	}	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectTradeAmt (Map<String, Object> params) {
		
		return (Map<String, Object>) select( "ContractSQL.SelectTradeAmt", params );
		
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
	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectConclusionPaymentNextDocInfo ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "ContractSQL.SelectConclusionPaymentNextDocInfo", params );
		
	}	
	
	
	public void deleteContractList ( Map<String, Object> params ) {
		
		delete( "ContractSQL.deleteContractList", params );
		
	}
	
	public void deletePurchaseList ( Map<String, Object> params ) {
		
		delete( "ContractSQL.deletePurchaseList", params );
		
	}
	
//	@SuppressWarnings("unchecked")
//	public Map<String, Object> SelectConclusionConsDocInfo ( Map<String, Object> params ) {
//		
//		return (Map<String, Object>) select( "ContractSQL.SelectConclusionConsDocInfo", params );
//		
//	}
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectConclusionConsDocInfo ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "ContractSQL.SelectConclusionConsDocInfo", params );
		return result;
	}	
	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectConsDocInfo ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "ContractSQL.SelectConsDocInfo", params );
		
	}
	
	public void deleteConsHead ( Map<String, Object> params ) {
		
		delete( "ContractSQL.deleteConsHead", params );
		
	}
	
	public void deleteConsBudget ( Map<String, Object> params ) {
		
		delete( "ContractSQL.deleteConsBudget", params );
		
	}
	
	public void deleteConsDoc ( Map<String, Object> params ) {
		
		delete( "ContractSQL.deleteConsDoc", params );
		
	}
	
	public void deleteBudgetInfo ( Map<String, Object> params ) {
		
		delete( "ContractSQL.deleteBudgetInfo", params );
		
	}
	
	public void deleteErpgwlink ( Map<String, Object> params ) {
		
		delete( "ContractSQL.deleteErpgwlink", params );
		
	}
	
}
