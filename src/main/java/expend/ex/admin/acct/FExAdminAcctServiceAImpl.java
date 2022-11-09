/**
  * @FileName : FExAdminAcctServiceAImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.acct;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FExAdminAcctServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FExAdminAcctServiceA" )
public class FExAdminAcctServiceAImpl implements FExAdminAcctService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminAcctServiceADAO" )
	private FExAdminAcctServiceADAO dao;

	/* ################################################## */
	/* [810000000]..회계 */
	/* ################################################## */
	/* ################################################## */
	/* [810200000]..└ 지출결의 설정 */
	/* ################################################## */
	/* ################################################## */
	/* [810201000]....└ 계정과목 설정 */ /* 관리자 > 회계 > 지출결의 설정 > 계정과목 설정 */
	/* ################################################## */
	/* 게정과목 목록 조회 */
	/**
	 *   * @Method Name : ExAdminConfigAcctListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 : 관리자 > 회계 > 지출결의 설정 > 계정과목 설정
	 *   * @Method 설명 : 계정과목 목록 조회 ( Bizbox Alpha )
	 *   * @param conVo
	 *   * @param result
	 *   * @return
	 *   
	 */
	public ResultVO ExAdminConfigAcctListInfoSelect ( ConnectionVO conVo, ResultVO result ) {
		/* 변수정의 */
		Map<String, Object> params = new HashMap<String, Object>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 파라미터 정의 */
			params = result.getParams( );
			/* 필수값 확인 - compSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.COMPSEQ );
				chkParameter = false;
			}
			/* 계정과목 목록 조회 */
			if ( chkParameter ) {
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.BIZBOXA ) ) {
					result.setAaData( dao.ExAdminConfigAcctListInfoSelect( params ) );
					/* 데이터 검증 */
					if ( result.getAaData( ) == null ) {
						result.setAaData( new ArrayList<Map<String, Object>>( ) );
						result.setResultName( "정상적으로 조회되었으나, 결과값이 존재하지 않습니다." );
					}
					else {
						result.setResultName( "정상적으로 조회되었으며, 총 " + result.getAaData( ).size( ) + "의 검색 결과가 나왔습니다." );
					}
					result.setResultCode( commonCode.SUCCESS );
				}
				else {
					result.setResultCode( commonCode.FAIL );
					result.setResultName( "ExAdminConfigAcctListInfoSelect >> Bizbox Alpha 만 지원" );
				}
			}
			else {
				result.setResultCode( commonCode.FAIL );
			}
		}
		catch ( Exception e ) {
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.toString( ) );
		}
		/* 반환처리 */
		return result;
	}

	/* 계정과목 등록 & 수정 */
	/**
	 *   * @Method Name : ExAdminConfigAcctInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 : 관리자 > 회계 > 지출결의 설정 > 계정과목 설정
	 *   * @Method 설명 : 계정과목 등록 & 수정
	 *   * @param conVo
	 *   * @param result
	 *   * @return
	 *   
	 */
	public ResultVO ExAdminConfigAcctInfoInsert ( ConnectionVO conVo, ResultVO result ) {
		/* 변수정의 */
		Map<String, Object> params = new HashMap<String, Object>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 파라미터 정의 */
			params = result.getParams( );
			/* 필수값 확인 - compSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.COMPSEQ );
				chkParameter = false;
			}
			/* 필수값 확인 - empSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.EMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.EMPSEQ );
				chkParameter = false;
			}
			/* 필수값 확인 - acctCode */
			if ( CommonConvert.CommonGetStr( params.get( "acctCode" ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + "acctCode" );
				chkParameter = false;
			}
			/* 필수값 확인 - acctName */
			if ( CommonConvert.CommonGetStr( params.get( "acctName" ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + "acctName" );
				chkParameter = false;
			}
			/* 필수값 확인 - vatYN */
			if ( !CommonConvert.CommonGetStr( params.get( "vatYN" ) ).equals( commonCode.EMPTYSTR ) 
					&& !CommonConvert.CommonGetStr( params.get( "vatYN" ) ).equals( commonCode.EMPTYYES ) 
					&& !CommonConvert.CommonGetStr( params.get( "vatYN" ) ).equals( commonCode.EMPTYNO ) ) {
				result.setResultName( "parameter 누락 : " + "vatYN" + " 또는 입력값 차이 발생, 입력제한 : [\"\" / " + commonCode.EMPTYYES + " / " + commonCode.EMPTYNO + "]" );
				chkParameter = false;
			}
			/* 필수값 확인 - useYN */
			if ( !CommonConvert.CommonGetStr( params.get( commonCode.USEYN ) ).equals( commonCode.EMPTYSTR ) 
					&& !CommonConvert.CommonGetStr( params.get( commonCode.USEYN ) ).equals( commonCode.EMPTYYES ) 
					&& !CommonConvert.CommonGetStr( params.get( commonCode.USEYN ) ).equals( commonCode.EMPTYNO ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.USEYN + " 또는 입력값 차이 발생, 입력제한 : [\"\" / " + commonCode.EMPTYYES + " / " + commonCode.EMPTYNO + "]" );
				chkParameter = false;
			}
			/* 계정과목 등록 & 수정 */
			if ( chkParameter ) {
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.BIZBOXA ) ) {
					result.setResultCode( String.valueOf( dao.ExAdminConfigAcctInfoInsert( params ) ) );
					/* 데이터 검증 */
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.EMPSEQ ) ) {
						result.setResultCode( commonCode.FAIL );
						result.setResultName( "정상처리 되지 않았습니다. 업데이트 또는 인서트시 반환된 카운트가 존재하지 않습니다." );
					}
					else {
						result.setResultName( "정상 처리 되었습니다." );
					}
				}
				else {
					result.setResultCode( commonCode.FAIL );
					result.setResultName( "ExAdminConfigAcctListInfoSelect >> Bizbox Alpha 만 지원" );
				}
			}
			else {
				result.setResultCode( commonCode.FAIL );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환처리 */
		return result;
	}

	/* 계정과목 삭제 */
	/**
	 *   * @Method Name : ExAdminConfigAcctInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 : 관리자 > 회계 > 지출결의 설정 > 계정과목 설정
	 *   * @Method 설명 : 계정과목 삭제 ( Bizbox Alpha )
	 *   * @param conVo
	 *   * @param result
	 *   * @return
	 *   
	 */
	public ResultVO ExAdminConfigAcctInfoDelete ( ConnectionVO conVo, ResultVO result ) {
		/* 변수정의 */
		Map<String, Object> params = new HashMap<String, Object>( );
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			/* 파라미터 정의 */
			params = result.getParams( );
			/* 필수값 확인 - compSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.COMPSEQ );
				chkParameter = false;
			}
			/* 필수값 확인 - empSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.EMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.EMPSEQ );
				chkParameter = false;
			}
			/* 필수값 확인 - acctCode */
			if ( CommonConvert.CommonGetStr( params.get( "acctCode" ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + "acctCode" );
				chkParameter = false;
			}
			/* 계정과목 삭제 */
			if ( chkParameter ) {
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.BIZBOXA ) ) {
					result.setResultCode( String.valueOf( dao.ExAdminConfigAcctInfoDelete( params ) ) );
					/* 데이터 검증 */
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.EMPSEQ ) ) {
						result.setResultCode( commonCode.FAIL );
						result.setResultName( "정상처리 되지 않았습니다. 삭제시 반환된 카운트가 존재하지 않습니다." );
					}
					else {
						result.setResultName( "정상 처리 되었습니다." );
					}
				}
				else {
					result.setResultCode( commonCode.FAIL );
					result.setResultName( "ExAdminConfigAcctListInfoSelect >> Bizbox Alpha 만 지원" );
				}
			}
			else {
				result.setResultCode( commonCode.FAIL );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환처리 */
		return result;
	}
}
