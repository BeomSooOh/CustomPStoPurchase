/**
  * @FileName : FAcUserProcessServiceIImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.process;

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
 *   * @FileName : FAcUserProcessServiceIImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FAcUserProcessServiceI" )
public class FAcUserProcessServiceIImpl implements FAcUserProcessService {

	/* 변수정의 */
	/* 변수정의 - DAO */
	@Resource ( name = "FAcUserProcessServiceIDAO" )
	private FAcUserProcessServiceIDAO dao;

	/* G20 품의 / 결의서 */
	/* G20 품의 / 결의서 - 회계기수목록정보 조회 */
	@Override
	public List<Map<String, Object>> AcExErpGisuListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	/* G20 품의 / 결의서 - 사용자정보 조회 */
	public Map<String, Object> AcExErpEmpInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			/* 변수정의 */
			/* parameters : erpCompSeq, erpEmpSeq, langCode */
			@SuppressWarnings ( "unused" )
			String[] parameters = { commonCode.ERPCOMPSEQ, commonCode.ERPEMPSEQ, commonCode.LANGCODE };
			boolean chkParameters = true;
			/* 필수값 확인 */
			/* 필수값 확인 - erpCompSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.ERPCOMPSEQ );
			}
			/* 필수값 확인 - erpEmpSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPEMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.ERPEMPSEQ );
			}
			/* 필수값 확인 - langCode */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.LANGCODE ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.LANGCODE );
			}
			/* 사용자정보 조회 */
			if ( chkParameters ) {
				result = dao.AcExG20EmpInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* G20 품의 / 결의서 - 사용자목록정보 조회 */
	@Override
	public List<Map<String, Object>> AcExErpEmpListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	/* G20 품의 / 결의서 - 양식정보 조회 */
	@Override
	public Map<String, Object> AcExFormInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		return result;
	}

	/* G20 공통코드 조회 */
	/* G20 공통코드 조회 - 프로젝트 */
	public List<Map<String, Object>> AcExErpProjectListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			/* parameters : erpCompSeq, erpEmpSeq, langCode */
			@SuppressWarnings ( "unused" )
			String[] parameters = { commonCode.ERPCOMPSEQ, commonCode.ERPEMPSEQ, commonCode.LANGCODE };
			boolean chkParameters = true;
			/* 필수값 확인 */
			/* 필수값 확인 - erpCompSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.ERPCOMPSEQ );
			}
			/* 필수값 확인 - erpEmpSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPEMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.ERPEMPSEQ );
			}
			/* 필수값 확인 - langCode */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.LANGCODE ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.LANGCODE );
			}
			/* 프로젝트정보 조회 */
			if ( chkParameters ) {
				result = dao.AcExErpProjectListInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* G20 공통코드 조회 - 부서 */
	public List<Map<String, Object>> AcExErpDeptListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			/* parameters : erpCompSeq, erpEmpSeq, langCode, jobOption */
			@SuppressWarnings ( "unused" )
			String[] parameters = { commonCode.ERPCOMPSEQ, commonCode.ERPEMPSEQ, commonCode.LANGCODE, "jobOption" };
			boolean chkParameters = true;
			/* 필수값 확인 */
			/* 필수값 확인 - erpCompSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.ERPCOMPSEQ );
			}
			/* 필수값 확인 - erpEmpSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPEMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.ERPEMPSEQ );
			}
			/* 필수값 확인 - langCode */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.LANGCODE ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.LANGCODE );
			}
			/* 필수값 확인 - langCode */
			if ( CommonConvert.CommonGetStr( params.get( "jobOption" ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + "jobOption" );
			}
			/* 프로젝트정보 조회 */
			if ( chkParameters ) {
				result = dao.AcExErpDeptListInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* G20 공통코드 조회 - 입출금계좌 */
	public List<Map<String, Object>> AcExErpBankTradeListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			/* 변수정의 */
			/* parameters : erpCompSeq, erpEmpSeq, langCode */
			@SuppressWarnings ( "unused" )
			String[] parameters = { commonCode.ERPCOMPSEQ, commonCode.ERPEMPSEQ, commonCode.LANGCODE };
			boolean chkParameters = true;
			/* 필수값 확인 */
			/* 필수값 확인 - erpCompSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.ERPCOMPSEQ );
			}
			/* 필수값 확인 - erpEmpSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPEMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.ERPEMPSEQ );
			}
			/* 필수값 확인 - langCode */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.LANGCODE ) ).equals( commonCode.EMPTYSTR ) ) {
				chkParameters = false;
				throw new Exception( "parameter 누락 : " + commonCode.LANGCODE );
			}
			/* 프로젝트정보 조회 */
			if ( chkParameters ) {
				result = dao.AcExErpBankTradeListInfoSelect( conVo, params );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
	//	/* 사용자 ERP 기준 정보 조회 */
	//	public ResultVO AcExG20EmpInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
	//		/* parameters : erpCompSeq, erpEmpSeq, langCode */
	//		ResultVO result = new ResultVO( );
	//		String[] parameters = { commonCode.ERPCOMPSEQ, commonCode.ERPEMPSEQ, "langCode" };
	//		try {
	//			/* 변수정의 */
	//			boolean chkParameter = true;
	//			/* 필수값 확인 - ERP 회사코드 ( erpCompSeq ) */
	//			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
	//				result.setResultName( "parameter 누락 : " + commonCode.ERPCOMPSEQ );
	//				chkParameter = false;
	//			}
	//			/* 필수값 확인 - ERP 회사코드 ( erpEmpSeq ) */
	//			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPEMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
	//				result.setResultName( "parameter 누락 : " + commonCode.ERPEMPSEQ );
	//				chkParameter = false;
	//			}
	//			/* 사용자 ERP 정보 조회 */
	//			if ( chkParameter ) {
	//				params = CommonConvert.CommonSetParams( params, parameters );
	//				result.setaData( dao.AcExG20EmpInfoSelect( conVo, params ) );
	//				result.setResultCode( commonCode.SUCCESS );
	//			}
	//			else {
	//				result.setResultCode( commonCode.FAIL );
	//			}
	//		}
	//		catch ( Exception e ) {
	//			// TODO: handle exception
	//		}
	//		return result;
	//	}
	//
	//	/* ERP 기수 정보 조회 */
	//	public ResultVO AcExG20GisuListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
	//		ResultVO result = new ResultVO( );
	//		try {
	//		}
	//		catch ( Exception e ) {
	//			// TODO: handle exception
	//		}
	//		return result;
	//	}
	//
	//	/* 양식 정보 조회 */
	//	public ResultVO AcExFormInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
	//		return null;
	//	}
	//
	//	/* G20 사원조회 */
	//	public ResultVO AcExErpUserListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception {
	//		/* parameters : erpCompSeq, erpDivSeq, erpDeptSeq, erpEmpSeq, erpEmpName, baseDate, langCode, toDate */
	//		ResultVO result = new ResultVO( );
	//		String[] parameters = { commonCode.ERPCOMPSEQ, "erpDivSeq", "erpDeptSeq", commonCode.ERPEMPSEQ, "erpEmpName", "baseDate", "langCode", "toDate" };
	//		try {
	//			/* 변수정의 */
	//			boolean chkParameter = true;
	//			/* 필수값 확인 - ERP 회사코드 ( erpCompSeq ) */
	//			if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
	//				result.setResultName( "parameter 누락 : " + commonCode.ERPCOMPSEQ );
	//				chkParameter = false;
	//			}
	//			/* 필수값 확인 - ERP 회사코드 ( toDate ) */
	//			if ( CommonConvert.CommonGetStr( params.get( "toDate" ) ).equals( commonCode.EMPTYSTR ) ) {
	//				result.setResultName( "parameter 누락 : " + "toDate" );
	//				chkParameter = false;
	//			}
	//			/* 필수값 확인 - ERP 회사코드 ( langCode ) */
	//			params.put( commonCode.LANGCODE, "KR" );
	//			/* G20 사원조회 */
	//			if ( chkParameter ) {
	//				params = CommonConvert.CommonSetParams( params, parameters );
	//				result.setAaData( dao.AcExG20EmpListInfoSelect( conVo, params ) );
	//				result.setResultCode( commonCode.SUCCESS );
	//			}
	//			else {
	//				result.setResultCode( commonCode.FAIL );
	//			}
	//		}
	//		catch ( Exception e ) {
	//			// TODO: handle exception
	//		}
	//		return result;
	//	}
}
