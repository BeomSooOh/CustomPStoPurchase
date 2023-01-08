
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
}
