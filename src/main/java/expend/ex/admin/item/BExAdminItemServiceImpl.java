/**
  * @FileName : BExAdminItemServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.item;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BExAdminItemServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BExAdminItemService" )
public class BExAdminItemServiceImpl implements BExAdminItemService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - Service */
	@Resource ( name = "FExAdminItemServiceA" )
	private FExAdminItemService itemServiceA;
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
	/* [810208000]....└ 항목 설정 */ /* 관리자 > 회계 > 지출결의 설정 > 항목 설정 */
	/* ################################################## */
	/* 항목 설정 목록 조회 */
	/**
	 *   * @Method Name : ExAdminConfigItemListInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 목록 조회 ( Bizbox Alpha, iCUBE, iU )
	 *   * @param result
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExAdminConfigItemListInfoSelect ( ResultVO result ) throws Exception {
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
			/* 항목 설정 목록 조회 */
			if ( chkParameter ) {
				conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
				result = itemServiceA.ExAdminConfigItemListInfoSelect( conVo, result );
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

	/* 항목 설정 목록 저장 */
	/**
	 *   * @Method Name : ExAdminConfigItemListInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 목록 저장 ( Bizbox Alpha, iCUBE, iU )
	 *   * @param result
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExAdminConfigItemListInfoInsert ( ResultVO result ) throws Exception {
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
			/* 항목 설정 목록 조회 */
			if ( chkParameter ) {
				conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
				result = itemServiceA.ExAdminConfigItemListInfoInsert( conVo, result );
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

	/* 항목 설정 JSP 전달 파라미터 정의 */
	/**
	 *   * @Method Name : ExAdminItemConfigSendParam
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 JSP 전달 파라미터 정의
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public Map<String, Object> ExAdminItemConfigSendParam ( ) throws Exception {
		/* 변수정의 */
		ConnectionVO conVo = new ConnectionVO( );
		Map<String, Object> result = new HashMap<String, Object>( );
		Map<String, Object> empInfo = new HashMap<String, Object>( );
		String compSeq = commonCode.EMPTYSEQ;
		try {
			/* 변수값 정의 */
			empInfo = CommonConvert.CommonGetEmpInfo( ); /* 사용자 정보 */
			compSeq = CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) == commonCode.EMPTYSTR ? commonCode.EMPTYSEQ : CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ); /* 로그인된 사용자 회사 시퀀스 */
			conVo = cmInfo.CommonGetConnectionInfo( compSeq ); /* 로그인된 사용자 기준 연결 정보 */
			/* 반환값 정의 */
			result.put( "empInfo", empInfo );
			result.put( "formInfo", CommonConvert.CommonGetListMapToJson( cmInfo.CommonGetExFormListInfo(empInfo) ) );
			result.put( "erpTypeCode", conVo.getErpTypeCode( ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환처리 */
		/* result{ empInfo={}, formInfo= [], erpTypeCode= } */
		return result;
	}
}
