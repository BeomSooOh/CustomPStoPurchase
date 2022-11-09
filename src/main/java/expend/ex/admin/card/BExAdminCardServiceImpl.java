package expend.ex.admin.card;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.helper.ConvertManager;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonInterface.commonCodeKey;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeCardPublicVO;
import expend.ex.admin.config.FExAdminConfigService;
import main.web.BizboxAMessage;


@Service ( "BExAdminCardService" )
public class BExAdminCardServiceImpl implements BExAdminCardService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FExAdminConfigServiceA" )
	private FExAdminConfigService adminConfigA;
	@Resource ( name = "FExAdminConfigCardSyncServiceI" )
	private FExAdminConfigCardSyncService cardSyncI;
	@Resource ( name = "FExAdminConfigCardSyncServiceU" )
	private FExAdminConfigCardSyncService cardSyncU;
	/* 변수정의 - Data Access Object */
	@Resource ( name = "FExAdminCardServiceADAO" )
	private FExAdminCardServiceADAO configADAO;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* (관리자)설정 - ERP법인카드 정보 신규 생성 */
	/**
	 *   * @Method Name : ExConfigCardInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : ERP 카드 정보 신규 생성
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExConfigCardInfoInsert ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExCodeCardVO cardVo >> " + params.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			/* 카드 등록 */
			resultVo = configADAO.ExCodeCardInfoInsert( params );
			/* 공개범위 삭제 */
			this.ExConfigCardPublicListInfoDelete( params );
			/* 공개범위 등록 */
			if ( !CommonConvert.CommonGetStr(params.get( "card_public" )).equals( commonCode.EMPTYSTR ) ) {
				List<ExCodeCardPublicVO> publicListVo = new ArrayList<ExCodeCardPublicVO>( );
				List<Map<String, Object>> cardPublic = ConvertManager.ConvertJsonToListMap( params.get( "card_public" ).toString( ) );
				for ( Map<String, Object> map : cardPublic ) {
					ExCodeCardPublicVO publicVo = new ExCodeCardPublicVO( );
					publicListVo.add( (ExCodeCardPublicVO) ConvertManager.ConvertMapToObject( map, publicVo ) );
				}
				this.ExConfigCardPublicListInfoInsert( cardPublic );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeCardVO cardVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardInfoInsert" );
		return resultVo;
	}

	/* (관리자)설정 - ERP법인카드 정보 수정 */
	/**
	 *   * @Method Name : ExConfigCardInfoUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : ERP 카드 정보 수정
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExConfigCardInfoUpdate ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExCodeCardVO cardVo >> " + params.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			/* 카드 수정 */
			resultVo = configADAO.ExCodeCardInfoUpdate( params );
			/* 공개범위 삭제 */
			this.ExConfigCardPublicListInfoDelete( params );
			/* 공개범위 등록 */
			if ( !CommonConvert.CommonGetStr(params.get( "cardPublic" )).equals( commonCode.EMPTYSTR ) ) {
				List<ExCodeCardPublicVO> publicListVo = new ArrayList<ExCodeCardPublicVO>( );
				List<Map<String, Object>> cardPublic = ConvertManager.ConvertJsonToListMap( params.get( "cardPublic" ).toString( ) );
				for ( Map<String, Object> map : cardPublic ) {
					ExCodeCardPublicVO publicVo = new ExCodeCardPublicVO( );
					publicListVo.add( (ExCodeCardPublicVO) ConvertManager.ConvertMapToObject( map, publicVo ) );
				}
				this.ExConfigCardPublicListInfoInsert( cardPublic );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeAcctVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardInfoUpdate" );
		return resultVo;
	}

	/* (관리자)설정 - 카드 정보 삭제 */
	/**
	 *   * @Method Name : ExConfigCardInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 정보 삭제
	 *   * @param parms
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExConfigCardInfoDelete ( Map<String, Object> parms ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExCodeCardVO cardVo >> " + parms.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			resultVo = configADAO.ExCodeCardInfoDelete( parms );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeAcctVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardInfoDelete" );
		return resultVo;
	}

	/* (관리자)설정 - ERP법인카드 정보 가져오기 */
	/**
	 *   * @Method Name : ExConfigCardInfoFromErpCopy
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : ERP 카드 정보 가져오기
	 *   * @param parms
	 *   * @param conVo
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExConfigCardInfoFromErpCopy ( Map<String, Object> parms, ConnectionVO conVo ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		if ( !CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.BIZBOXA ) ) {
			/* 서비스 정의 */
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ERPIU:
					/* ERP에서 가져오기 */
					resultVo = cardSyncU.ExCodeCardInfoFromErpCopy( parms, conVo );
					break;
				case commonCode.ICUBE:
					resultVo = cardSyncI.ExCodeCardInfoFromErpCopy( parms, conVo );
					break;
				default:
					break;
			}
		}
		else {
			resultVo.setResultCode( commonCode.FAIL );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000016525", "ERP를 연동하지 않은 경우에는 지원하지 않습니다" ) );
		}
		return resultVo;
	}

	/* (관리자)설정 - 카드 공개범위 등록 */
	/**
	 *   * @Method Name : ExConfigCardPublicListInfoInsert
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 공개범위 등록
	 *   * @param parms
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExConfigCardPublicListInfoInsert ( List<Map<String, Object>> parms ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardPublicListInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] List<ExCodeCardPublicVO> publicVo >> " + parms.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			for ( Map<String, Object> cardPublic : parms ) {
				resultVo = configADAO.ExCodeCardPublicListInfoInsert( cardPublic );
				if ( !CommonConvert.CommonGetStr(resultVo.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					throw new Exception( BizboxAMessage.getMessage( "TX000009297", "카드 공개범위 저장 실패" ) );
				}
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardPublicListInfoInsert" );
		return resultVo;
	}

	/* (관리자)설정 - 카드 공개범위 삭제 */
	/**
	 *   * @Method Name : ExConfigCardPublicListInfoDelete
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 공개범위 삭제
	 *   * @param parms
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public ResultVO ExConfigCardPublicListInfoDelete ( Map<String, Object> parms ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExCodeCardPublicListInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExCodeCardVO cardVo >> " + parms.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			resultVo = configADAO.ExCodeCardPublicListInfoDelete( parms );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExCodeCardBizboxAService - ExCodeCardPublicListInfoDelete" );
		return resultVo;
	}

	/* (관리자)설정 - 법인카드 리스트 조회 */
	/**
	 *   * @Method Name : ExConfigCardInfoSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 카드 리스트 조회
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@Override
	public ResultVO ExConfigCardInfoSelect ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExConfigCardInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExCodeCardVO cardVo >> " + params.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			/* 법인카드 리스트 조회 */
			resultVo = configADAO.ExCodeCardInfoSelect( params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeCardVO cardVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "+ [EX] ExCodeCardBizboxAService - ExConfigCardInfoSelect" );
		return resultVo;
	}

	/* 계정과목 설정 JSP 전달 파라미터 정의 */
	/**
	 *   * @Method Name : ExAdminAcctConfigSendParam
	 *   * @변경이력 :
	 *   * @메뉴 : 회계 - 지출결의 설정 - 법인카드 관리
	 *   * @Method 설명 : 페이지 접속시 JSP 전달 파라미터 생성 반환
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public Map<String, Object> ExAdminCardConfigSendParam ( ) throws Exception {
		/* 변수정의 */
		ConnectionVO conVo = new ConnectionVO( );
		Map<String, Object> result = new HashMap<String, Object>( );
		Map<String, Object> empInfo = new HashMap<String, Object>( );
		String compSeq = commonCode.EMPTYSEQ;
		String groupSeq = commonCode.GROUPSEQ;
		String langCode = "kr";
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
			result.put( commonCodeKey.SETORNOTSET, CommonConvert.CommonGetListMapToJson( cmInfo.CommonGetCodeA( groupSeq, compSeq, langCode, commonCodeKey.SETORNOTSET ) ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환처리 */
		/* result{ empInfo={}, erpTypeCode=, ex00001=[], ex00004=[] } */
		return result;
	}
}
