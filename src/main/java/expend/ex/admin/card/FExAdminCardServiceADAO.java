package expend.ex.admin.card;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository ( "FExAdminCardServiceADAO" )
public class FExAdminCardServiceADAO extends EgovComAbstractDAO {

	/* 법인카드 설정(관리자) - 카드 리스트 조회 */
	/**
	 *   * @Method Name : ExCodeCardInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 목록 조회
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@SuppressWarnings ( "unchecked" )
	public ResultVO ExCodeCardInfoSelect ( Map<String, Object> params ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			if(CommonConvert.CommonGetStr(params.get( "eaType" )).equals( "ea" )) {
				if(CommonConvert.CommonGetStr(params.get( "selPublic" )).equals( "A" )) {
					params.put("public", "");
				} else if(CommonConvert.CommonGetStr(params.get( "selPublic" )).equals( "Y" )) {
					params.put("public", "returnObj");
				} else {
					params.put( "public", "▒" );
				}
				resultVo.setAaData( (List<Map<String, Object>>) this.list( "NpExCodeCardInfoSelect", params ) );
			} else {
				resultVo.setAaData( (List<Map<String, Object>>) this.list( "ExCodeCardInfoSelect", params ) );
			}
			
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			throw e;
		}
		return resultVo;
	}

	/* 법인카드 설정(관리자) - 카드 신규 생성 */
	/**
	 *   * @Method Name : ExCodeCardInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 신규 생성
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeCardInfoInsert ( Map<String, Object> params ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			insert( "ExCodeCardInfoInsert", params );
		}
		catch ( Exception e ) {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
			throw e;
		}
		return resultVo;
	}

	/* 법인카드 설정(관리자) - 카드 정보 수정 */
	/**
	 *   * @Method Name : ExCodeCardInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 정보 수정
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeCardInfoUpdate ( Map<String, Object> params ) throws Exception {
		/* parameters : card_name, partner_code, partner_name, modify_seq, comp_seq, card_code */
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 update() 실행시 return 값 : 성공시 "1" / 실패시 "0" */
		if ( update( "ExCodeCardInfoUpdate", params ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 법인카드 설정(관리자) - 카드 삭제 */
	/**
	 *   * @Method Name : ExCodeCardInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 삭제
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeCardInfoDelete ( Map<String, Object> params ) throws Exception {
		/* parameters : comp_seq, card_code */
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeCardInfoDelete", params ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 법인카드 설정(관리자) - 연동정보 전체 삭제 */
	/**
	 *   * @Method Name : ExCodeCardInfoDeleteAll
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 연동 정보 전체 삭제
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeCardInfoDeleteAll ( Map<String, Object> params ) throws Exception {
		/* parameters : comp_seq, card_code */
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		if ( delete( "ExCodeCardInfoDeleteAll", params ) > 0 ) {
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 법인카드 설정(관리자) - 카드 공개범위 등록 */
	/**
	 *   * @Method Name : ExCodeCardPublicListInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 공개범위 등록
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeCardPublicListInfoInsert ( Map<String, Object> params ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			insert( "ExCodeCardPublicListInfoInsert", params );
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009300", "실패하였습니다" ) );
		}
		return resultVo;
	}

	/* 법인카드 설정(관리자) - 카드 공개범위 삭제 */
	/**
	 *   * @Method Name : ExCodeCardPublicListInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 공개범위 삭제
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExCodeCardPublicListInfoDelete ( Map<String, Object> params ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		/* ibatis 에서 delete() 실행시 return 값 : 삭제한 row 수 */
		
		try{
			delete( "ExCodeCardPublicListInfoDelete", params );
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}catch(Exception ex){
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName(ex.getMessage( ));
		}
		return resultVo;
	}
}
