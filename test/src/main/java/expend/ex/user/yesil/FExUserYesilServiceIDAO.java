package expend.ex.user.yesil;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.helper.logger.ExpInfo;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FExUserYesilServiceIDAO" )
public class FExUserYesilServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );

	public Map<String, Object> ExUserYesilBudgetFG ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		Map<String, Object> result = connector.Select( conVo, "UseriCUBEYesil.ExUserYesilBudgetFG", params );
		return result;
	}

	public Map<String, Object> ExUserYesilProjectInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		Map<String, Object> result = connector.Select( conVo, "UseriCUBEYesil.ExUserYesilProjectInfo", params );
		return result;
	}

	public List<Map<String, Object>> ExUserYesilInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		List<Map<String, Object>> result = connector.List( conVo, "UseriCUBEYesil.ExUserYesilInfoSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExUserYesilDetailSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		List<Map<String, Object>> result = connector.List( conVo, "UseriCUBEYesil.ExUserYesilDetailSelect", params );
		return result;
	}

	public List<Map<String, Object>> ExUserYesilProjectSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
	    ExpInfo.TempLog("[ERP_COMP_SEQ_Check - iCUBE] " + params.toString(), params);
		List<Map<String, Object>> result = connector.List( conVo, "UseriCUBEYesil.ExYesilProjectSelect", params );
		return result;
	}
	
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExUserYesilnoExpendSend ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = list( "ExAdminYesilA.ExAdminYesilnoExpendSend", params );
		return result;
	}
}
