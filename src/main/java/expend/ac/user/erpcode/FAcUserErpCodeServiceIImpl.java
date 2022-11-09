/**
  * @FileName : FAcUserErpCodeServiceIImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.erpcode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.CommonInterface.commonCode;


/**
 *   * @FileName : FAcUserErpCodeServiceIImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FAcUserErpCodeServiceI" )
public class FAcUserErpCodeServiceIImpl implements FAcUserErpCodeService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - DAO */
	@Resource ( name = "FAcUserErpCodeServiceIDAO" )
	private FAcUserErpCodeServiceIDAO dao; /* ERP Code DAO */

	public Map<String, Object> AcErpCodeUserInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* iCUBE 사원정보 조회 */
			if ( chkParameter ) {
				result = dao.AcErpCodeUserInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* ERP 기수정보 조회 */
	public List<Map<String, Object>> AcErpCodeGisuInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* iCUBE 사원정보 조회 */
			if ( chkParameter ) {
				result = dao.AcErpCodeGisuInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* ERP 부서 예산 목록 조회 */
	public List<Map<String, Object>> AcErpCodeDeptBudgetListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - CO_CD */
			if ( CommonConvert.CommonGetStr( params.get( "CO_CD" ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameter = false;
			}
			/* 필수값 확인 - EMP_CD */
			if ( CommonConvert.CommonGetStr( params.get( "EMP_CD" ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameter = false;
			}
			/* 필수값 확인 - LANGKIND */
			if ( CommonConvert.CommonGetStr( params.get( "LANGKIND" ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameter = false;
			}
			/* G20 시스템 설정 데이터 조회 */
			if ( chkParameter ) {
				result = dao.AcErpCodeDeptBudgetListInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* ERP 프로젝트 예산 목록 조회 */
	public List<Map<String, Object>> AcErpCodeProjectBudgetListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 - CO_CD */
			if ( CommonConvert.CommonGetStr( params.get( "CO_CD" ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameter = false;
			}
			/* 필수값 확인 - EMP_CD */
			if ( CommonConvert.CommonGetStr( params.get( "EMP_CD" ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameter = false;
			}
			/* 필수값 확인 - LANGKIND */
			if ( CommonConvert.CommonGetStr( params.get( "LANGKIND" ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameter = false;
			}
			/* G20 시스템 설정 데이터 조회 */
			if ( chkParameter ) {
				result = dao.AcErpCodeProjectBudgetListInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* ERP 사원 정보 조회 */
	public List<Map<String, Object>> AcErpCodeEmpListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 */
			/* G20 사원 정보 조회 */
			if ( chkParameter ) {
				result = dao.AcErpCodeEmpListInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* ERP 입출근계좌 조회 */
	public List<Map<String, Object>> AcErpCodeBtrListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 필수값 확인 */
			/* G20 사원 정보 조회 */
			if ( chkParameter ) {
				result = dao.AcErpCodeBtrListInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
}
