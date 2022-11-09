/**
  * @FileName : FAcUserErpCodeServiceIDAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.erpcode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonAcConnect;
import common.vo.common.ConnectionVO;


/**
 *   * @FileName : FAcUserErpCodeServiceIDAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAcUserErpCodeServiceIDAO" )
public class FAcUserErpCodeServiceIDAO {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - Class */
	CommonAcConnect connector = new CommonAcConnect( );

	/* ERP 사원정보 조회 */
	public Map<String, Object> AcErpCodeUserInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AcErpCode.AcErpCodeUserInfoSelect", params );
		return result;
	}

	/* ERP 기수정보 조회 */
	public List<Map<String, Object>> AcErpCodeGisuInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AcErpCode.AcErpCodeGisuInfoSelect", params );
		return result;
	}

	/* ERP 부서 예산 목록 조회 */
	public List<Map<String, Object>> AcErpCodeDeptBudgetListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AcErpCode.AcErpCodeDeptBudgetListInfoSelect", params );
		return result;
	}

	/* ERP 프로젝트 예산 목록 조회 */
	public List<Map<String, Object>> AcErpCodeProjectBudgetListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AcErpCode.AcErpCodeProjectBudgetListInfoSelect", params );
		return result;
	}

	/* ERP 사원 정보 조회 */
	public List<Map<String, Object>> AcErpCodeEmpListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		/* EXEC P_GWG20_COMMON_TR_LIST @CO_CD='${CO_CD}',@TR_CD='${TR_CD}',@TR_NM='${TR_NM}',@TYPE='${TYPE}',@DETAIL_TYPE='${DETAIL_TYPE}',@LANGKIND='${LANGKIND}' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AcErpCode.AcErpCodeEmpListInfoSelect", params );
		return result;
	}

	/* ERP 입출근계좌 조회 */
	public List<Map<String, Object>> AcErpCodeBtrListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AcErpCode.AcErpCodeBtrListInfoSelect", params );
		return result;
	}
}
