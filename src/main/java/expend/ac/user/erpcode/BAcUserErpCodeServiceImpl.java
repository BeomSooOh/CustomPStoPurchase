/**
  * @FileName : BAcUserErpCodeServiceImpl.java
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
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;


/**
 *   * @FileName : BAcUserErpCodeServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BAcUserErpCodeService" )
public class BAcUserErpCodeServiceImpl implements BAcUserErpCodeService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - Service */
	@Resource ( name = "FAcUserErpCodeServiceI" )
	private FAcUserErpCodeService erpCodeService; /* ERP Code */
	/* 변수정의 - Class */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;

	/* ERP 사원정보 & 기수정보 조회 */
	public Map<String, Object> AcErpCodeUserInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			/* 변수정의 */
			Map<String, Object> erpuser = new HashMap<String, Object>( );
			List<Map<String, Object>> erpgisu = new ArrayList<Map<String, Object>>( );
			/* 변수 기본값 정의 */
			/* 변수 기본값 정의 - ERP 사원정보 */
			erpuser = erpCodeService.AcErpCodeUserInfoSelect( conVo, params );
			/* 변수 기본값 정의 - ERP 기수정보 */
			erpgisu = erpCodeService.AcErpCodeGisuInfoSelect( conVo, params );
			/* 반환값 정의 */
			result.put( "erpuser", erpuser );
			result.put( "erpgisu", erpgisu );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* G20 프로젝트 정보 조회 */
	public List<Map<String, Object>> AcErpCodeProjectListInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			Map<String, Object> empInfo = new HashMap<String, Object>( );
			/* 변수값 정의 */
			empInfo = CommonConvert.CommonGetEmpInfo( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* 변수값 정의 - 파라미터 */
			if ( CommonConvert.CommonGetStr( params.get( "CO_CD" ) ).equals( "" ) ) {
				params.put( "CO_CD", CommonConvert.CommonGetStr( empInfo.get( commonCode.ERPCOMPSEQ ) ) );
			}
			params.put( "LANGKIND", CommonConvert.CommonGetStr( empInfo.get( commonCode.LANGCODE ) ) );
			/* 프로세스 - 프로젝트 조회 */
			if ( CommonConvert.CommonGetStr( params.get( "FG_TY" ) ).equals( "1" ) ) {
				/* 프로세스 - 프로젝트 조회 - 부서 예산 */
				result = erpCodeService.AcErpCodeDeptBudgetListInfoSelect( conVo, params );
			}
			else {
				/* 프로세스 - 프로젝트 조회 - 프로젝트 예산 */
				result = erpCodeService.AcErpCodeProjectBudgetListInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* G20 사원 정보 조회 */
	public List<Map<String, Object>> AcErpCodeEmpListInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			Map<String, Object> empInfo = new HashMap<String, Object>( );
			/* 변수값 정의 */
			empInfo = CommonConvert.CommonGetEmpInfo( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* 변수값 정의 - 파라미터 */
			if ( CommonConvert.CommonGetStr( params.get( "CO_CD" ) ).equals( "" ) ) {
				params.put( "CO_CD", CommonConvert.CommonGetStr( empInfo.get( commonCode.ERPCOMPSEQ ) ) );
			}
			params.put( "LANGKIND", CommonConvert.CommonGetStr( empInfo.get( commonCode.LANGCODE ) ) );
			params.put( "EMP_CD", null );
			params.put( "EMP_NM", null );
			/* 프로세스 - 사원정보 조회 */
			result = erpCodeService.AcErpCodeEmpListInfoSelect( conVo, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* G20 입출금계좌 조회 */
	public List<Map<String, Object>> AcErpCodeBtrListInfoSelect ( Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			Map<String, Object> empInfo = new HashMap<String, Object>( );
			/* 변수값 정의 */
			empInfo = CommonConvert.CommonGetEmpInfo( );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* 변수값 정의 - 파라미터 */
			if ( CommonConvert.CommonGetStr( params.get( "CO_CD" ) ).equals( "" ) ) {
				params.put( "CO_CD", CommonConvert.CommonGetStr( empInfo.get( commonCode.ERPCOMPSEQ ) ) );
			}
			/* 프로세스 - 입출금계좌 조회 */
			result = erpCodeService.AcErpCodeBtrListInfoSelect( conVo, params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
}