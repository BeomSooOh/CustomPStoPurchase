/**
  * @FileName : FExAdminItemServiceAImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.item;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;


/**
 *   * @FileName : FExAdminItemServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FExAdminItemServiceA" )
public class FExAdminItemServiceAImpl implements FExAdminItemService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminItemServiceADAO" )
	private FExAdminItemServiceADAO dao;

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
	 *   * @Method 설명 :
	 *   * @param result
	 *   * @return
	 *   
	 */
	@Override
	public ResultVO ExAdminConfigItemListInfoSelect ( ConnectionVO conVo, ResultVO result ) throws Exception {
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
			/* 필수값 확인 - formSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.FORMSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.FORMSEQ );
				chkParameter = false;
			}
			/* 필수값 확인 - itemGbn */
			if ( CommonConvert.CommonGetStr( params.get( "itemGbn" ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + "itemGbn" );
				chkParameter = false;
			}
			/* 항목 설정 목록 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.ExAdminConfigItemListInfoSelect( params ) );
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
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환처리 */
		return result;
	}

	/* 항목 설정 목록 저장 */
	/**
	 *   * @Method Name : ExAdminConfigItemListInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param result
	 *   * @return
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	@Override
	public ResultVO ExAdminConfigItemListInfoInsert ( ConnectionVO conVo, ResultVO result ) throws Exception {
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
			/* 필수값 확인 - formSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.FORMSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.FORMSEQ );
				chkParameter = false;
			}
			/* 필수값 확인 - items */
			if ( CommonConvert.CommonGetStr( params.get( "items" ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + "items" );
				chkParameter = false;
			}
			else {
				params.put( "items", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( params.get( "items" ) ) ) );
			}
			/* 항목 설정 저장 */
			if ( chkParameter ) {
				List<Map<String, Object>> items = new ArrayList<Map<String, Object>>( );
				items = (List<Map<String, Object>>) params.get( "items" );
				for ( Map<String, Object> item : items ) {
					if ( dao.ExAdminConfigItemInfoInsert( item ) < 1 ) {
						result.setResultCode( commonCode.FAIL );
						result.setResultName( "진행중 오류가 발생되었습니다." );
						return result;
					}
					else {
						result.setResultCode( commonCode.SUCCESS );
						result.setResultName( "정상 처리 되었습니다." );
					}
				}
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

	/* 항목 설정 초기화 */
	/**
	 *   * @Method Name : ExAdminConfigItemListDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 항목 설정 초기화
	 *   * @param conVo
	 *   * @param result
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExAdminConfigItemListDelete ( ConnectionVO conVo, ResultVO result ) throws Exception {
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
			/* 필수값 확인 - formSeq */
			if ( CommonConvert.CommonGetStr( params.get( commonCode.FORMSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + commonCode.FORMSEQ );
				chkParameter = false;
			}
			/* 필수값 확인 - itemGbn */
			if ( CommonConvert.CommonGetStr( params.get( "itemGbn" ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultName( "parameter 누락 : " + "itemGbn" );
				chkParameter = false;
			}
			/* 항목 설정 초기화 */
			if ( chkParameter ) {
				result.setResultCode( String.valueOf( dao.ExAdminConfigItemListInfoSelect( params ) ) );
				/* 데이터 검증 */
				if ( Integer.parseInt( result.getResultCode( ) ) < 1 ) {
					result.setResultCode( commonCode.FAIL );
					result.setResultName( "처리중 오류가 발생되었습니다." );
				}
				else {
					result.setResultName( "정상처리 되었습니다." );
				}
				result.setResultCode( commonCode.SUCCESS );
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
}
