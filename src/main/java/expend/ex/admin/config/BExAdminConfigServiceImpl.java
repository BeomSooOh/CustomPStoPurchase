package expend.ex.admin.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BExAdminConfigServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 : 지출결의 설정 ( 관리자 )
 *   
 */
@Service ( "BExAdminConfigService" )
public class BExAdminConfigServiceImpl implements BExAdminConfigService {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FExAdminConfigServiceA" )
	private FExAdminConfigService adminConfigA;
	/* 변수정의 - DAO */
	@Resource ( name = "FExAdminConfigServiceADAO" )
	private FExAdminConfigServiceADAO configADAO;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/**
	 *   * @Method Name : ExAdminConfigOptionSelect
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 주석없음
	 *   * @param param
	 *   * @return
	 *   
	 */
	@Override
    public ResultVO ExAdminConfigOptionSelect ( Map<String, Object> param ) {
		ResultVO result = new ResultVO( );
		try {
			result.setAaData( configADAO.ExAdminConfigOptionSelect( param ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	@Override
	public ResultVO ExAdminLabelInfoListSelect ( Map<String, Object> param ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			param.put( "langKind", loginVo.getLangCode( ) );
			param.put( "compSeq", loginVo.getCompSeq( ) );
			result.setResultName( commonCode.SUCCESS );
			result.setResultCode( commonCode.SUCCESS );
			result.setAaData( configADAO.ExAdminLabelInfoListSelect( param ) );
		}
		catch ( Exception e ) {
			result.setResultName( e.getMessage( ) );
			result.setResultCode( commonCode.SUCCESS );
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
		}
		return result;
	}

	@Override
	public ResultVO ExAdminLabelInfoListUpdate ( List<Map<String, Object>> param ) {
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 데이터 저장 */
			for ( int i = 0; i < param.size( ); i++ ) {
				Map<String, Object> item = param.get( i );
				HashMap<String, Object> updateParam = new HashMap<String, Object>( );
				updateParam.put( "modifySeq", loginVo.getUniqId( ) );
				updateParam.put( "createSeq", loginVo.getUniqId( ) );
				updateParam.put( "compSeq", item.get( "compSeq" ).toString( ) );
				updateParam.put( "basicName", item.get( "basicName" ).toString( ) );
				updateParam.put( "langCode", item.get( "langCode" ).toString( ) );
				updateParam.put( "langpackCode", item.get( "langpackCode" ).toString( ) );
				/* 한국어 처리 */
				updateParam.put( "langName", item.get( "langKR" ).toString( ) );
				updateParam.put( "langType", "kr" );
				configADAO.ExAdminLabelInfoListUpdate( updateParam );
				/* 영어 처리 */
				updateParam.put( "langName", item.get( "langEN" ).toString( ) );
				updateParam.put( "langType", "en" );
				configADAO.ExAdminLabelInfoListUpdate( updateParam );
				/* 중국어 처리 */
				updateParam.put( "langName", item.get( "langCN" ).toString( ) );
				updateParam.put( "langType", "cn" );
				configADAO.ExAdminLabelInfoListUpdate( updateParam );
				/* 일본어 처리 */
				updateParam.put( "langName", item.get( "langJP" ).toString( ) );
				updateParam.put( "langType", "jp" );
				configADAO.ExAdminLabelInfoListUpdate( updateParam );
				/* 툴팁 처리 */
				updateParam.put( "tooltip", item.get( "tooltip" ).toString( ) );
				configADAO.ExAdminLabelTolltipInfoListUpdate( updateParam );
			}
			/* 저장후 재 조회 */
			HashMap<String, Object> selectParam = new HashMap<>( );
			result = this.ExAdminLabelInfoListSelect( selectParam );
		}
		catch ( Exception e ) {
			result.setResultName( e.getMessage( ) );
			result.setResultCode( commonCode.FAIL );
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
		}
		return result;
	}

	@Override
	public ResultVO ExAdminLabelInfoinInitialization ( Map<String, Object> param ) {
		ResultVO result = new ResultVO( );
		LoginVO loginVo = new LoginVO( );
		try {
			loginVo = CommonConvert.CommonGetEmpVO( );
		}
		catch ( NotFoundLoginSessionException e ) {
			// TODO Auto-generated catch block
			e.printStackTrace( );
		}
		param.put( commonCode.COMPSEQ, loginVo.getCompSeq( ) );
		param.put( commonCode.EMPSEQ, loginVo.getUniqId( ) );
		/* 전체 데이터 삭제 */
		configADAO.ExAdminLabelInfoinInitialization( param );
		/* 기초코드에서 전체 데이터 복사 */
		int resultCnt = configADAO.ExAdminLabelInfoWholeInsert( param );
		result.setResultCode( commonCode.SUCCESS );
		if ( resultCnt == 0 ) {
			result.setResultCode( commonCode.FAIL );
			result.setResultName( "기초코드 정보가 없습니다. 관리자에게 문의하세요." );
		}
		return result;
	}

	@Override
	public ResultVO ExAdminGetButtonInfoList ( Map<String, Object> param ) throws Exception {
		/* 파라미터 정의 */
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		param.put( commonCode.COMPSEQ, loginVo.getCompSeq( ) );
		/* 버튼 설정정보 조회 */
		result = adminConfigA.ExAdminGetButtonInfoList( param );
		/* 버튼 설정정보 포멧 확인 */
		Map<String, Object> pages = new HashMap<>( );
		for ( Map<String, Object> item : result.getAaData( ) ) {
			if ( pages.get( "page" + item.get( "pageSeq" ).toString( ) ) == null ) {
				pages.put( "page" + item.get( "pageSeq" ).toString( ), new HashMap<String, Object>( ) );
			}
			@SuppressWarnings ( "unchecked" )
			HashMap<String, Object> page = (HashMap<String, Object>) pages.get( "page" + item.get( "pageSeq" ).toString( ) );
			if ( page.get( "position" + item.get( "position" ).toString( ) ) == null ) {
				page.put( "position" + item.get( "position" ).toString( ), new ArrayList<HashMap<String, Object>>( ) );
			}
			@SuppressWarnings ( "unchecked" )
			ArrayList<Map<String, Object>> btns = (ArrayList<Map<String, Object>>) page.get( "position" + item.get( "position" ).toString( ) );
			btns.add( item );
		}
		result.setaData( pages );
		result.setAaData( null );
		return result;
	}

	@Override
	public ResultVO ExAdminSetButtonLocationUpdate ( Map<String, Object> param ) throws Exception {
		/* 파라미터 정의 */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		param.put( commonCode.COMPSEQ, loginVo.getCompSeq( ) );
		/* 파라미터 포멧 변경 */
		List<Map<String, Object>> params = CommonConvert.CommonGetJSONToListMap( param.get( "param" ).toString( ) );
		return adminConfigA.ExAdminSetButtonLocationUpdate( params );
	}

	@Override
	public ResultVO ExAdminSetButtonUpdate ( Map<String, Object> param ) throws Exception {
		/* 파라미터 정의 */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		param.put( commonCode.COMPSEQ, loginVo.getCompSeq( ) );
		return adminConfigA.ExAdminSetButtonUpdate( param );
	}

	@Override
	public ResultVO ExAdminSetButtonCreate ( Map<String, Object> param ) throws Exception {
		return adminConfigA.ExAdminSetButtonCreate( param );
	}

	@Override
	public ResultVO ExAdminSetButtonDelete ( Map<String, Object> param ) throws Exception {
		return adminConfigA.ExAdminSetButtonDelete( param );
	}

	@Override
	public ResultVO ExAdminGetFormInfoSelect ( Map<String, Object> param ) throws Exception {
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( loginVo.getCompSeq( ) );
		param.put( "useSw", conVo.getErpTypeCode( ) );
		param.put( "compSeq", loginVo.getCompSeq( ) );
		return adminConfigA.ExAdminGetFormInfoSelect( param );
	}

	/* ## 양식별 표준적요 설정 ## */
	/* ## 양식별 표준적요 설정 ## - 표준적요 등록 */
    // @Transactional(propagation=Propagation.REQUIRES_NEW, rollbackFor=Exception.class)
	@Override
    public ResultVO ExAdminSetSummaryAuthCreate ( Map<String, Object> param ) throws Exception {
		/* compSeq, formSeq, summaryCode */
		/* 변수정의 */
		ResultVO result = new ResultVO( );

		List<Map<String, Object>> summaryArr = CommonConvert.ConvertJsonToListMap(param.get("summaryArr").toString());

		Map<String, Object> deleteParam = new HashMap<>();

		deleteParam.put("formSeq", summaryArr.get(0).get("formSeq"));
		deleteParam.put("isInsert", "Y");

		// 표준적요 등록 전 삭제
		result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), deleteParam ) );
		result = adminConfigA.ExAdminSetSummaryAuthDelete( result );

		if(result.getResultCode().equals(commonCode.FAIL)) {
			throw new Exception("표준적요 등록 전 삭제 중 오류가 발생하였습니다.");
		}

		// 표준적요 등록
		for(Map<String, Object> summaryParam : summaryArr) {
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), summaryParam ) );
			result = adminConfigA.ExAdminSetSummaryAuthCreate( result );

			if(result.getResultCode().equals(commonCode.FAIL)) {
				throw new Exception("표준적요 등록 중 오류가 발생하였습니다.");
			}
		}

		return result;
	}

	/* ## 양식별 표준적요 설정 ## - 표쥰적요 삭제 */
	@Override
    public ResultVO ExAdminSetSummaryAuthDelete ( Map<String, Object> param ) throws Exception {
		/* compSeq, formSeq, summaryCode */
		/* 변수정의 */
		ResultVO result = new ResultVO( );

		try {
			/* 기본값 정의 */
			//result.setParams( param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param ) );
			result.setParams(CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param ));
			result = adminConfigA.ExAdminSetSummaryAuthDelete( result );
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## 양식별 증빙유형 설정 ## */
	/* ## 양식별 증빙유형 설정 ## - 증빙유형 등록 */
    // @Transactional(propagation=Propagation.REQUIRES_NEW, rollbackFor=Exception.class)
	@Override
    public ResultVO ExAdminSetAuthTypeAuthCreate ( Map<String, Object> param ) throws Exception {
		/* compSeq, formSeq, authTypeCode */
		/* 변수정의 */
		ResultVO result = new ResultVO( );

		List<Map<String, Object>> authArr = CommonConvert.ConvertJsonToListMap(param.get("authArr").toString());

		Map<String, Object> deleteParam = new HashMap<>();

		deleteParam.put("formSeq", authArr.get(0).get("formSeq"));
		deleteParam.put("isInsert", "Y");

		// 증빙유형 등록 전 삭제
		result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), deleteParam ) );
		result = adminConfigA.ExAdminSetAuthTypeAuthDelete( result );

		if(result.getResultCode().equals(commonCode.FAIL)) {
			throw new Exception("증빙유형 등록 전 삭제 중 오류가 발생하였습니다.");
		}

		// 증빙유형 등록
		for(Map<String, Object> authParam : authArr) {
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), authParam ) );
			result = adminConfigA.ExAdminSetAuthTypeAuthCreate( result );

			if(result.getResultCode().equals(commonCode.FAIL)) {
				throw new Exception("증빙유형 등록 중 오류가 발생하였습니다.");
			}
		}

		return result;
	}

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 삭제 */
	@Override
    public ResultVO ExAdminSetAuthTypeAuthDelete ( Map<String, Object> param ) throws Exception {
		/* compSeq, formSeq, authTypeCode */
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			//result.setParams( param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param ) );
		    result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param ) );
			result = adminConfigA.ExAdminSetAuthTypeAuthDelete( result );
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## 양식별 증빙유형 설정 ## - 증빙유형 리스트 조회 */
	@Override
    public ResultVO ExFormLinkAuthListSelect ( Map<String, Object> param ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		result.setParams( param );
		try {
			result = adminConfigA.ExFormLinkAuthListSelect( result );
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## 양식별 증빙유형 설정 ## - 표준적요 리스트 조회 */
	@Override
    public ResultVO ExFormLinkSummaryListSelect ( Map<String, Object> param ) throws Exception {
		/* compSeq, formSeq */
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		result.setParams( param );
		try {
			result = adminConfigA.ExFormLinkSummaryListSelect( result );
			result.setSuccess( );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 양식 별 표준적요 & 증빙유형 설정 -설정된 표준적요 조회 */
	@Override
    public ResultVO ExFormLinkSettingSummaryListSelect ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExFormLinkSettingSummaryListSelect( result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 양식 별 표준적요 & 증빙유형 설정 -설정된 증빙유형 조회 */
	@Override
    public ResultVO ExFormLinkSettingAuthListSelect ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExFormLinkSettingAuthListSelect( result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 조회 */
	@Override
    public ResultVO ExAdminExpendCloseDateSelect ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExAdminExpendCloseDateSelect( result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 등록 */
	@Override
	public ResultVO ExAdminExpendCloseDateInsert ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExAdminExpendCloseDateInsert( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setResultName( "등록" );
				result = ExAdminExpendCloseHistorySetParam( result );
				result = ExAdminExpendCloseDateHistoryInsert( result );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 등록(전체양식) - 모든양식적용 시 마감기간 중 등록된 내역 있는지 확인 */
	@Override
    public ResultVO ExAdminExpendCloseFormInsertChkValidate ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExAdminExpendCloseFormInsertChkValidate( result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 등록(전체양식) */
	@Override
    public ResultVO ExAdminExpendCloseInsertAllForm ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExAdminExpendCloseInsertAllForm( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS )
					|| (
							CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL )
							&& !CommonConvert.CommonGetStr(result.getResultName( )).equals( commonCode.EMPTYSTR )
						)) {
				result.setResultName( "양식전체등록" + result.getResultName( ) );
				Map<String, Object> tParam = new HashMap<String, Object>( );
				tParam = result.getParams( );
				tParam.put( "seq", "0" );
				tParam.put( commonCode.FORMSEQ, "0" );
				result.setParams( tParam );
				result = ExAdminExpendCloseHistorySetParam( result );
				result = ExAdminExpendCloseDateHistoryInsert( result );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 수정 */
	@Override
    public ResultVO ExAdminExpendCloseDateUpdate ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExAdminExpendCloseDateUpdate( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setResultName( "마감상태값 수정" );
				result = ExAdminExpendCloseHistorySetParam( result );
				result = ExAdminExpendCloseDateHistoryInsert( result );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 삭제 */
	@Override
    public ResultVO ExAdminExpendCloseDateDelete ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExAdminExpendCloseDateDelete( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setResultName( "삭제" );
				result = ExAdminExpendCloseHistorySetParam( result );
				result = ExAdminExpendCloseDateHistoryInsert( result );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 지출결의 마감일 설정 리스트 선택 삭제 */
	@Override
    public ResultVO ExAdminExpendSelectedCloseDateDelete ( ResultVO result ) throws Exception {
		try {
			String[] selectedCloseSeq = result.getParams( ).get( "closeSeqs" ).toString( ).split( "," );
			if ( selectedCloseSeq != null ) {
				for ( int i = 0; i < selectedCloseSeq.length; i++ ) {
					Map<String, Object> param = new HashMap<String, Object>( );
					param = result.getParams( );
					param.put( "seq", selectedCloseSeq[i] );
					result.setParams( param );
					result = adminConfigA.ExAdminExpendCloseDateDelete( result );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
						result.setResultName( "삭제" );
						result = ExAdminExpendCloseHistorySetParam( result );
						result = ExAdminExpendCloseDateHistoryInsert( result );
					}
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* 지출결의 마감일 이력 등록 */
	@Override
    public ResultVO ExAdminExpendCloseDateHistoryInsert ( ResultVO result ) throws Exception {
		try {
			result = adminConfigA.ExAdminExpendCloseDateHistoryInsert( result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	private ResultVO ExAdminExpendCloseHistorySetParam ( ResultVO result ) {
		Map<String, Object> tParam = result.getParams( );
		String historyInfo = commonCode.EMPTYSTR;
		historyInfo += (tParam.get( "closeType" ) == null ? "" : tParam.get( "closeType" ).toString( ) ) + "/";
		historyInfo += (tParam.get( "closeFromDate" ) == null ? "" : tParam.get( "closeFromDate" ).toString( ) ) + "/";
		historyInfo += (tParam.get( "closeToDate" ) == null ? "" : tParam.get( "closeToDate" ).toString( ) ) + "/";
		historyInfo += (tParam.get( "note" ) == null ? "" : tParam.get( "note" ).toString( ) ) + "/";
		historyInfo += (tParam.get( "createSeq" ) == null ? "" : tParam.get( "createSeq" ).toString( ) ) + "/";
		historyInfo += result.getResultName( );
		tParam.put( "closeSeq", tParam.get( "seq" ) );
		tParam.put( "historyInfo", historyInfo );
		tParam.put( "createSeq", tParam.get( "modifySeq" ) );
		tParam.put( "createName", tParam.get( "modifyName" ) );
		tParam.put( "createDate", tParam.get( "modifyDate" ) );
		result.setParams( tParam );
		return result;
	}
}
