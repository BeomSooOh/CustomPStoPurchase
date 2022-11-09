/**
  * @FileName : BAnguUserCardServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.card;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.angu.user.common.BAnUserCommonService;


/**
 *   * @FileName : BAnguUserCardServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BAnguUserCardService" )
public class BAnguUserCardServiceImpl implements BAnguUserCardService {

	/* 변수정의 */
	
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통사용 정보 */
	@Resource ( name = "BAnUserCommonService" )
	private BAnUserCommonService cmAngu; /* 국고보조통합시스템 연계 공통 */
	@Resource ( name = "FAnguUserCardServiceI" )
	private FAnguUserCardService cardI; /* 국고보조통합시스템 연계 공통 */

	/* 집행등록 - 국고보조사업 귀속 카드 */
	public ResultVO AnguCardInfoS ( ResultVO result ) throws Exception {
		/* [iCUBE] parameter : langKind, erpCompSeq, ddtbzId */
		/* [ERPiU] parameter : */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* 기본설정정정보 검증 */
			result = cmAngu.AnCommonCheck( conVo, result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 집행등록 - 국고보조사업 귀속 카드 */
			result = cardI.AnguCardInfoS( conVo, result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* 집행등록 - 카드 사용 내역 코드 조회 */
	public ResultVO AnguCardListInfoS ( ResultVO result ) throws Exception {
		/* [iCUBE] parameter : langKind, erpCompSeq, confmDeFr, confmDeTo, cardNo, mrhstNm, puchasTamt, ddtlbzId, tascCmmnDetailCodeNm */
		/* [ERPiU] parameter : */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* 기본설정정보 검증 */
			result = cmAngu.AnCommonCheck( conVo, result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 집행등록 - 카드 사용 내역 코드 조회 */
			result = cardI.AnguCardListInfoS( conVo, result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
}
