/**
  * @FileName : FAcUserProcessServiceIDAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.process;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonAcConnect;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FAcUserProcessServiceIDAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAcUserProcessServiceIDAO" )
public class FAcUserProcessServiceIDAO extends EgovComAbstractDAO {

	/* 변수정의 - class */
	CommonAcConnect connector = new CommonAcConnect( );

	/* 사용자 ERP 정보 조회 */
	public Map<String, Object> AcExG20EmpInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "G20AcCode.AcExG20EmpInfoSelect", params );
		return result;
	}

	/* ERP 기수 정보 조회 */
	public List<Map<String, Object>> AcExG20GisuListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "G20AcCode.AcExG20GisuListInfoSelect", params );
		return result;
	}

	/* 양식 정보 조회 */
	public Map<String, Object> AcExFormInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "GwAcCode.AcExFormInfoSelect", params );
		return result;
	}

	/* G20 사원조회 */
	public List<Map<String, Object>> AcExG20EmpListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "G20AcCode.AcExG20EmpListInfoSelect", params );
		return result;
	}

	/* G20 공통코드 조회 */
	/* G20 공통코드 조회 - 프로젝트 */
	public List<Map<String, Object>> AcExErpProjectListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "G20AcCode.AcExErpProjectListInfoSelect", params );
		return result;
	}

	/* G20 공통코드 조회 - 부서 */
	public List<Map<String, Object>> AcExErpDeptListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "G20AcCode.AcExErpDeptListInfoSelect", params );
		return result;
	}

	/* G20 공통코드 조회 - 입출금계좌 */
	public List<Map<String, Object>> AcExErpBankTradeListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "G20AcCode.AcExErpBankTradeListInfoSelect", params );
		return result;
	}
}
