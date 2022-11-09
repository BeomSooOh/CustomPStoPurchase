package expend.ex.admin.yesil;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FExAdminYesilServiceIDAO" )
public class FExAdminYesilServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );

	public List<Map<String, Object>> ExAdminYesilProjectSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = connector.List( conVo, "AdminiCUBEYesil.ExYesilProjectSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExAdminYesilDeptSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = connector.List( conVo, "AdminiCUBEYesil.ExAdminYesilDeptSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExAdminYesilSectSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = connector.List( conVo, "AdminiCUBEYesil.ExAdminYesilSectSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExAdminYesilInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = connector.List( conVo, "AdminiCUBEYesil.ExAdminYesilInfoSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExAdminYesilDetailSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = connector.List( conVo, "AdminiCUBEYesil.ExAdminYesilDetailSelect", params );
		return result;
	}

	public Map<String, Object> ExAdminYesilBudgetFG ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		Map<String, Object> result = connector.Select( conVo, "AdminiCUBEYesil.ExAdminYesilBudgetFG", params );
		return result;
	}

	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminYesilDetailPopInfo ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = list( "ExAdminYesilA.ExAdminYesilDetailPopInfo", params );
		return result;
	}
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExAdminYesilnoExpendSend ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = list( "ExAdminYesilA.ExAdminYesilnoExpendSend", params );
		return result;
	}
}
