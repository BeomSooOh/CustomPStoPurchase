/**
  * @FileName : BExAdminAcctServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.acct;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonInterface.commonCodeKey;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BExAdminAcctServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BExAdminAcctService" )
public class BExAdminAcctServiceImpl implements BExAdminAcctService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - Service */
	@Resource ( name = "FExAdminAcctServiceA" )
	private FExAdminAcctService serviceA;
	/* 변수정의 - Class */

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* ################################################## */
	/* [810000000]..회계 */
	/* ################################################## */
	/* ################################################## */
	/* [810200000]..└ 지출결의 설정 */
	/* ################################################## */
	/* ################################################## */
	/* [810201000]....└ 계정과목 설정 */ /* 관리자 > 회계 > 지출결의 설정 > 계정과목 설정 */
	/* ################################################## */
	/* 계정과목 목록 조회 */

	/**
	 *   * @Method Name : ExAdminConfigAcctListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 계정과목 목록 조회 ( Bizbox Alpha )
	 *   * @param result
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExAdminConfigAcctListInfoSelect ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			ConnectionVO conVo = new ConnectionVO( );
			Map<String, Object> params = new HashMap<String, Object>( );
			/* 파라미터 정의 */
			params = result.getParams( );
			params = CommonConvert.CommonSetMapCopy( params ); /* 공통 사용 키로 맞춤 */
			/* 필수값 확인 - compSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.COMPSEQ );
				chkParameter = false;
			}
			/* 계정과목 목록 조회 */
			if ( chkParameter ) {
				conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
				result = serviceA.ExAdminConfigAcctListInfoSelect( conVo, result );
			}
			else {
				result.setResultCode( commonCode.FAIL );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* 계정과목 생성 & 수정 */
	/**
	 *   * @Method Name : ExAdminConfigAcctInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 계정과목 등록 & 수정 ( Bizbox Alpha )
	 *   * @param result
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExAdminConfigAcctInfoInsert ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			ConnectionVO conVo = new ConnectionVO( );
			Map<String, Object> params = new HashMap<String, Object>( );
			/* 파라미터 정의 */
			params = result.getParams( );
			params = CommonConvert.CommonSetMapCopy( params ); /* 공통 사용 키로 맞춤 */
			/* 필수값 확인 - compSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.COMPSEQ );
				chkParameter = false;
			}
			/* 계정과목 등록 */
			if ( chkParameter ) {
				conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
				result = serviceA.ExAdminConfigAcctInfoInsert( conVo, result );
			}
			else {
				result.setResultCode( commonCode.FAIL );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* 계정과목 삭제 */
	/**
	 *   * @Method Name : ExAdminConfigAcctInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 계정과목 삭제 ( Bizbox Alpha )
	 *   * @param result
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExAdminConfigAcctInfoDelete ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			ConnectionVO conVo = new ConnectionVO( );
			Map<String, Object> params = new HashMap<String, Object>( );
			/* 파라미터 정의 */
			params = result.getParams( );
			params = CommonConvert.CommonSetMapCopy( params ); /* 공통 사용 키로 맞춤 */
			/* 필수값 확인 - compSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.COMPSEQ );
				chkParameter = false;
			}
			if ( chkParameter ) {
				conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
				result = serviceA.ExAdminConfigAcctInfoDelete( conVo, result );
			}
			else {
				result.setResultCode( commonCode.FAIL );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* 계정과목 설정 JSP 전달 파라미터 정의 */
	/**
	 *   * @Method Name : ExAdminAcctConfigSendParam
	 *   * @변경이력 :
	 *   * @메뉴 : 회계 - 지출결의 설정 - 계정과목 관리
	 *   * @Method 설명 : 페이지 접속시 JSP 전달 파라미터 생성 반환
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public Map<String, Object> ExAdminAcctConfigSendParam ( ) throws Exception {
		/* 변수정의 */
		ConnectionVO conVo = new ConnectionVO( );
		Map<String, Object> result = new HashMap<String, Object>( );
		Map<String, Object> empInfo = new HashMap<String, Object>( );
		String compSeq = commonCode.EMPTYSEQ;
		String langCode = "kr";
		String groupSeq = commonCode.EMPTYSTR;
		try {
			/* 변수값 정의 */
			empInfo = CommonConvert.CommonGetEmpInfo( ); /* 사용자 정보 */
			compSeq = CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) == commonCode.EMPTYSTR ? commonCode.EMPTYSEQ : CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ); /* 로그인된 사용자 회사 시퀀스 */
			langCode = CommonConvert.CommonGetStr( empInfo.get( commonCode.LANGCODE ) ) == commonCode.EMPTYSTR ? "kr" : CommonConvert.CommonGetStr( empInfo.get( commonCode.LANGCODE ) ); /* 로그인된 사용자 사용 언어 */
			groupSeq = CommonConvert.CommonGetStr( empInfo.get( commonCode.GROUPSEQ ) ) == commonCode.EMPTYSTR ? "" : CommonConvert.CommonGetStr( empInfo.get( commonCode.GROUPSEQ ) ); /* 로그인된 사용자 그룹 시퀀스 */
			conVo = cmInfo.CommonGetConnectionInfo( compSeq ); /* 로그인된 사용자 기준 연결 정보 */
			/* 반환값 정의 */
			result.put( "empInfo", empInfo );
			result.put( "erpTypeCode", conVo.getErpTypeCode( ) );
			result.put( commonCodeKey.USEYN, CommonConvert.CommonGetListMapToJson( cmInfo.CommonGetCodeA( groupSeq, compSeq, langCode, commonCodeKey.USEYN ) ) );
			result.put( commonCodeKey.YESORNO, CommonConvert.CommonGetListMapToJson( cmInfo.CommonGetCodeA( groupSeq, compSeq, langCode, commonCodeKey.YESORNO ) ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환처리 */
		/* result{ empInfo={}, erpTypeCode=, ex00001=[], ex00004=[] } */
		return result;
	}
}
