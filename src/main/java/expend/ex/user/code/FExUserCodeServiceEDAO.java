package expend.ex.user.code;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonExConnect;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;


@Repository ( "FExUserCodeServiceEDAO" )
public class FExUserCodeServiceEDAO {

	/* 변수정의 - class */
	CommonExConnect connector = new CommonExConnect( );

	/* Common ( BizboxA, iCUBE, ERPiU, ETC ) */
	/* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 */
	/* Common ( BizboxA, iCUBE, ERPiU, ETC ) - 사용자 - 목록 조회 */
	public List<Map<String, Object>> ExUserEmpListInfoSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "FExUserCodeServiceEDAO.ExUserEmpListInfoSelect", params );
		return result;
	}

	/* ----------------------------------------------------------------------------- */
	/* --------------------------------공통 팝업 조회 영역-------------------------- */
	/* ----------------------------------------------------------------------------- */
	public List<Map<String, Object>> ExCommonCodeAcctSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeBgAcctSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeBizplanSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeBudgetSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeCardSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeCcSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeEmpSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}
	
	public List<Map<String, Object>> ExCommonCodeDeptSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, erp_dept_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeErpAuthSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeNotaxSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodePartnerSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodePcSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeProjectSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeVaSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}

	public List<Map<String, Object>> ExCommonCodeVatTypeSelect ( Map<String, Object> params, ConnectionVO conVo ) throws Exception {
		/* parameters : erp_comp_seq, search_str, search_str */
		List<Map<String, Object>> result = connector.List( conVo, commonCode.EMPTYSTR, params );
		return result;
	}
}
