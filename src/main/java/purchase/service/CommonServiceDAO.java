
package purchase.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import bizbox.orgchart.service.vo.LoginVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("CommonServiceDAO")
public class CommonServiceDAO extends EgovComAbstractDAO {
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectOverallHopeAmtInfo ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectOverallHopeAmtInfo", params );
		return result;
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectDeptHopeAmtInfo ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectDeptHopeAmtInfo", params );
		return result;
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectGreenAmtInfo ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectGreenAmtInfo", params );
		return result;
	}	
 
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
	
	public Boolean CheckAuthFromMenuInfo ( LoginVO loginVo, String servletPath ) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("groupSeq", loginVo.getGroupSeq());
		params.put("compSeq", loginVo.getOrganId());
		params.put("deptSeq", loginVo.getOrgnztId());
		params.put("empSeq", loginVo.getUniqId());		
		params.put("servletPath", servletPath);
		
		int checkAuthResult = (int) select( "CommonSQL.checkAuth", params );
		
		if(checkAuthResult > 0) {
			return true;
		}else {
			return false;
		}
		
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
		
		if(params.get("outProcessCode").toString().contains("Con")) {
			return (Map<String, Object>) select( "CommonSQL.SelectApprFormDataContract", params );	
		}else {
			return (Map<String, Object>) select( "CommonSQL.SelectApprFormDataPurchase", params );	
		}
		
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
	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelConsTemp ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "CommonSQL.SelConsTemp", params );
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelResTemp ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelResTemp", params );
		return result;
	}	
	
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelConsbudget ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "CommonSQL.SelConsbudget", params );
	}
	
	
	
	public void InsertCodeInfo ( Map<String, Object> params ) {
		
		insert( "CommonSQL.InsertCodeInfo", params );
		
	}	
	
	public void UpdateAppr ( Map<String, Object> params ) {
		
		if(params.get("processId").equals("Purchase01") || params.get("processId").equals("Purchase02")) {
			update( "CommonSQL.UpdateApprPurchase", params );
		}else {
			update( "CommonSQL.UpdateApprContract", params );
		}		
		
	}	
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> SelectNewManageNo ( Map<String, Object> params ) {
		
		return (Map<String, Object>) select( "CommonSQL.SelectNewManageNo", params );

	}	
	
	public void DelConsTemp ( Map<String, Object> params ) {
		
		update( "CommonSQL.DelConsTemp", params );
		
	}
	
	public void confferReturn ( Map<String, Object> params ) {
		
		update( "CommonSQL.confferReturn", params );
		
	}
	
	public void paymentChange ( Map<String, Object> params ) {
		
		update( "CommonSQL.paymentChange", params );
		
	}
	
	public void updateDeptCons ( Map<String, Object> params ) {
		
		update( "CommonSQL.updateDeptCons", params );
		
	}
	
	public void updateCempName ( Map<String, Object> params ) {
		
		update( "CommonSQL.updateCempName", params );
		
	}
	
	public void UpdateApprChange ( Map<String, Object> params ) {
		
		update( "CommonSQL.UpdateApprChange", params );
		
	}
	
	public void ChangeBudgetInfo ( Map<String, Object> params ) {
		
		update( "CommonSQL.ChangeBudgetInfo", params );
		
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
	
	
	public void DeleteTradeInfo ( Map<String, Object> params ) {
		
		delete( "CommonSQL.DeleteTradeInfo", params );
		
	}
	
	public void InsertTradeInfo ( Map<String, Object> params ) {
		
		insert( "CommonSQL.InsertTradeInfo", params );
		
	}
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectTradeList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectTradeList", params );
		return result;
	}		
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectTradeInfo ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "CommonSQL.SelectTradeInfo", params );
	}
	
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> SelectResdocInfo ( Map<String, Object> params ) {
		return (Map<String, Object>) select( "CommonSQL.SelectResdocInfo", params );
	}	
	
	public void DeletePaymentDocInfo ( Map<String, Object> params ) {
		
		delete( "CommonSQL.DeletePaymentDocInfo", params );
		
	}
	
	public void InsertPaymentDocInfo ( Map<String, Object> params ) {
		
		insert( "CommonSQL.InsertPaymentDocInfo", params );
		
	}
	
	public void UpdateConsDocSts ( Map<String, Object> params ) {
		
		update( "CommonSQL.UpdateConsDocSts", params );
		
	}	
	
	public void ChangeConsDocSts ( Map<String, Object> params ) {
		
		update( "CommonSQL.ChangeConsDocSts", params );
		
	}	
	
	public void UpdateCommonCode ( Map<String, Object> params ) {
		
		update( "CommonSQL.UpdateCommonCode", params );
		
	}	
	
	public void DeleteCommonCode ( Map<String, Object> params ) {
		
		update( "CommonSQL.DeleteCommonCode", params );
		
	}	
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectContractManagerList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectContractManagerList", params );
		return result;
	}	
	
	public Map<String, Object> SelectCodeGroupList (Map<String, Object> paramMap, PaginationInfo paginationInfo) {
		return super.listOfPaging2(paramMap, paginationInfo, "CommonSQL.SelectCodeGroupList");
	}	
	
	public Map<String, Object> SelectCodeList (Map<String, Object> paramMap, PaginationInfo paginationInfo) {
		return super.listOfPaging2(paramMap, paginationInfo, "CommonSQL.SelectCodeList");
	}
	

//	@SuppressWarnings ( "unchecked" )
//	public Map<String, Object> SelectPurchaseResGreenInfo ( Map<String, Object> params ) {
//		return (Map<String, Object>) select( "CommonSQL.SelectPurchaseResGreenInfo", params );
//	}
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectPurchaseResGreenInfo ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectPurchaseResGreenInfo", params );
		return result;
	}
	
	
	public void InsertPurchaseResGreenInfo ( Map<String, Object> params ) {
		
		insert( "CommonSQL.InsertPurchaseResGreenInfo", params );
		
	}
	
	
	public void UpdatePurchaseItemGreenInfo ( Map<String, Object> params ) {
		
		update( "CommonSQL.UpdatePurchaseItemGreenInfo", params );
		
	}
	
	
	public void DeletePurchaseResGreenInfo ( Map<String, Object> params ) {
		
		delete( "CommonSQL.DeletePurchaseResGreenInfo", params );
		
	}
	
	public void DeletePurchaseItemGreenInfo ( Map<String, Object> params ) {
		
		update( "CommonSQL.DeletePurchaseItemGreenInfo", params );
		
	}

		
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectPurchaseResHopeInfoList ( Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = (List<Map<String, Object>>) list( "CommonSQL.SelectPurchaseResHopeInfoList", params );
		return result;
	}		
	
	public void InsertPurchaseResHopeInfo ( Map<String, Object> params ) {
		
		insert( "CommonSQL.InsertPurchaseResHopeInfo", params );
		
	}
	
	public void UpdatePurchaseContractHopeInfo ( Map<String, Object> params ) {
		
		update( "CommonSQL.UpdatePurchaseContractHopeInfo", params );
		
	}
	
	public void UpdatePurchaseTradeHopeInfo ( Map<String, Object> params ) {
		
		update( "CommonSQL.UpdatePurchaseTradeHopeInfo", params );
		
	}
	
	public void DeletePurchaseResHopeInfo ( Map<String, Object> params ) {
		
		delete( "CommonSQL.DeletePurchaseResHopeInfo", params );
		
	}	

	
	public void DeletePurchaseContractHopeInfo ( Map<String, Object> params ) {
		
		update( "CommonSQL.DeletePurchaseContractHopeInfo", params );
		
	}
	
	
	public void DeletePurchaseTradeHopeInfo ( Map<String, Object> params ) {
		
		update( "CommonSQL.DeletePurchaseTradeHopeInfo", params );
		
	}
	
	
}
