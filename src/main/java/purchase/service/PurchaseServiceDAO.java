
package purchase.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("PurchaseServiceDAO")
public class PurchaseServiceDAO extends EgovComAbstractDAO {
 
	public Map<String, Object> SelectPurchaseList (Map<String, Object> paramMap, PaginationInfo paginationInfo) {
		return super.listOfPaging2(paramMap, paginationInfo, "PurchaseSQL.SelectPurchaseList");
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
	
	public void UpdatePurchaseAttachInfo ( Map<String, Object> params ) {
		update( "PurchaseSQL.UpdatePurchaseAttachInfo", params );
	}	
	
	public void UpdatePurchaseCheck ( Map<String, Object> params ) {
		update( "PurchaseSQL.UpdatePurchaseCheck", params );
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
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectNewManageNo ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "PurchaseSQL.SelectNewManageNo", params );

	}	
	
	public void UpdateItemCheckCnt ( Map<String, Object> params ) {
		update( "PurchaseSQL.UpdateItemCheckCnt", params );
	}
	

	public Map<String, Object> SelectPurchasePaymentList (Map<String, Object> paramMap, PaginationInfo paginationInfo) {
		
		return super.listOfPaging2(paramMap, paginationInfo, "PurchaseSQL.SelectPurchasePaymentList");
		
	}	
	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectPurchasePaymentAmt ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "PurchaseSQL.SelectPurchasePaymentAmt", params );
		
	}		
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectPurchasePaymentDocInfo ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "PurchaseSQL.SelectPurchasePaymentDocInfo", params );
		
	}		
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectPurchasePaymentDocInfoCheck ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "PurchaseSQL.SelectPurchasePaymentDocInfoCheck", params );
		
	}
	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectPurchasePaymentNextDocInfo ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "PurchaseSQL.SelectPurchasePaymentNextDocInfo", params );
		
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectPurchaseConsDocInfo ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "PurchaseSQL.SelectPurchaseConsDocInfo", params );
		
	}	
	
	
	
}
