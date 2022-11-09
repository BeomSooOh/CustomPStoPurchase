/**
  * @FileName : FAnguUserCardServiceIImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.card;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.vo.common.CommonInterface.commonCode;
import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.angu.user.common.BAnUserCommonService;


/**
 *   * @FileName : FAnguUserCardServiceIImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FAnguUserCardServiceI" )
public class FAnguUserCardServiceIImpl implements FAnguUserCardService {

	/* 변수정의 */
	@Resource ( name = "BAnUserCommonService" )
	private BAnUserCommonService cmAngu; /* 국고보조통합시스템 연계 공통 */
	@Resource ( name = "FAnguUserCardServiceIDAO" )
	private FAnguUserCardServiceIDAO dao;

	/* 집행등록 - 국고보조사업 귀속 카드 */
	public ResultVO AnguCardInfoS ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* [iCUBE] parameter : langKind, erpCompSeq, ddtbzId */
		/* [ERPiU] parameter : */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			/* 기본값 정의 */
			params = (Map<String, Object>) result.getParams( );
			params.put( "langKind", "KOR" );
			params.put( "erpCompSeq", result.getErpCompSeq( ) );
			/* 파라미터 검증 */
			/* 파라미터 검증 - ddtlbzId */
			if ( CommonConvert.CommonGetStr(cmAngu.AnCommonCheckParam( result, params, "ddtlbzId" ).getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result.setAaData( dao.AnguCardInfoS( conVo, params ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* 집행등록 - 카드 사용 내역 코드 조회 */
	public ResultVO AnguCardListInfoS ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* [iCUBE] parameter : langKind, erpCompSeq, confmDeFr, confmDeTo, cardNo, mrhstNm, puchasTamt, ddtlbzId, tascCmmnDetailCodeNm */
		/* [ERPiU] parameter : */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			/* 기본값 정의 */
			params = (Map<String, Object>) result.getParams( );
			params.put( "langKind", "KOR" );
			params.put( "erpCompSeq", result.getErpCompSeq( ) );
			/* 파라미터 검증 */
			/* 파라미터 검증 - langKind */
			if ( CommonConvert.CommonGetStr(cmAngu.AnCommonCheckParam( result, params, "langKind" ).getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 파라미터 검증 - erpCompSeq */
			if ( CommonConvert.CommonGetStr(cmAngu.AnCommonCheckParam( result, params, "erpCompSeq" ).getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 파라미터 검증 - confmDeFr *//* 카드거래일자 검색 시작일 */
			if ( CommonConvert.CommonGetStr(cmAngu.AnCommonCheckParam( result, params, "confmDeFr" ).getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 파라미터 검증 - confmDeTo *//* 카드거래일자 검색 종료일 */
			if ( CommonConvert.CommonGetStr(cmAngu.AnCommonCheckParam( result, params, "confmDeTo" ).getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 파라미터 검증 - cardNo *//* 검색 카드 번호 */
			if ( CommonConvert.CommonGetStr(cmAngu.AnCommonCheckParam( result, params, "cardNo" ).getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 파라미터 검증 - ddtlbzId *//* 국고보조사업 */
			if ( CommonConvert.CommonGetStr(cmAngu.AnCommonCheckParam( result, params, "ddtlbzId" ).getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 파라미터 검증 - tascCmmnDetailCodeNm *//* 고정값 : 001 */
			if ( CommonConvert.CommonGetStr(cmAngu.AnCommonCheckParam( result, params, "tascCmmnDetailCodeNm" ).getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 형변환 진행 */
			/* 형변환 진행 - puchasTamt *//* 총금액 */
			params.put( "puchasTamt", CommonConvert.CommonGetDouble( params.get( "puchasTamt" ) ) );
			/* 집행등록 - 카드 사용 내역 코드 조회 */
			result.setAaData( dao.AnguCardListInfoS( conVo, params ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
}
