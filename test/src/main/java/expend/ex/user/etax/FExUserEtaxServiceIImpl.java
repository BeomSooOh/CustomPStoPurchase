package expend.ex.user.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeETaxVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.interlock.InterlockExpendVO;
import expend.ex.user.code.BExUserCodeService;
import main.web.BizboxAMessage;


@Service ( "FExUserEtaxServiceIImpl" )
public class FExUserEtaxServiceIImpl implements FExUserEtaxService {

	/* 변수정의 - Helper */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 - 공통코드 */
	@Resource ( name = "BExUserCodeService" ) /* 공통 조회 서비스 */
	private BExUserCodeService codeService;
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserEtaxServiceADAO" )
	private FExUserEtaxServiceADAO daoA;
	@Resource ( name = "FExUserEtaxServiceIDAO" )
	private FExUserEtaxServiceIDAO daoI;

	/* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
	@Override
	public List<ExCodeETaxVO> ExETaxListInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExUserEtaxServiceIImpl - ExETaxListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExCodeETaxVO etaxVo >> " + etaxVo.toString( ) );
		List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>( );
		List<ExCodeETaxVO> etaxBizboxAListVo = new ArrayList<ExCodeETaxVO>( );
		List<ExCodeETaxVO> etaxAppListVo = new ArrayList<ExCodeETaxVO>( );
		/* 반환 데이터 */
		List<ExCodeETaxVO> resultListVo = new ArrayList<ExCodeETaxVO>( );
		try {
			/* 현재 작성중인 세금계산서, 미사용 세금계산서 제외 */
			etaxAppListVo = daoA.ExExpendETaxSubAppListInfoSelect( etaxVo );
			String userIssNo = commonCode.EMPTYSTR;
			if ( etaxAppListVo != null && etaxAppListVo.size( ) > 0 ) {
				for ( ExCodeETaxVO usedEtax : etaxAppListVo ) {
					userIssNo += usedEtax.getIssNo( ) + "','";
				}
				userIssNo = userIssNo.substring( 0, userIssNo.length( ) - 3 );
				etaxVo.setNotInsertIssNo( userIssNo );
			}

			/* 그룹웨어 세금계산서 권한 조회 */
			List<Map<String, Object>> gwEtaxAuth = new ArrayList<Map<String, Object>>( );
			Map<String, Object> param = new HashMap<String, Object>( );
			param.put("empSeq", etaxVo.getEmpSeq( ) );
			param.put("compSeq", etaxVo.getCompSeq( ) );
			gwEtaxAuth = daoA.ExExpendETaxAuthSelect( param );
			String gwAuthEmail = commonCode.EMPTYSTR;
			String gwAuthRegNo = commonCode.EMPTYSTR;
			if( gwEtaxAuth != null && gwEtaxAuth.size( ) > 0 ){
				for( Map<String, Object> tData : gwEtaxAuth ){
					if(CommonConvert.CommonGetStr(tData.get( "authType" )).equals( "P" )){
						gwAuthRegNo += CommonConvert.CommonGetStr(tData.get( "code" )) + "','";
					}else{
						gwAuthEmail += CommonConvert.CommonGetStr(tData.get( "code" )) + "','";
					}
				}
				if( gwAuthRegNo.length( ) > 3 ){
					gwAuthRegNo = gwAuthRegNo.substring( 0, gwAuthRegNo.length( ) - 3 );
				}
				if( gwAuthEmail.length( ) > 3 ){
					gwAuthEmail = gwAuthEmail.substring( 0, gwAuthEmail.length( ) - 3 );
				}
				etaxVo.setTrchargeEmail( gwAuthEmail );
				etaxVo.setTrregNb( gwAuthRegNo );
			}
			/* 이관 받은 세금계산서 정보 조회 */
			List<Map<String, Object>> gwTransferList = new ArrayList<Map<String, Object>>( );
			param.put( "searchFromDt", etaxVo.getSearchFromDt( ) );
			param.put( "searchToDt", etaxVo.getSearchToDt( ) );
			gwTransferList = daoA.ExExpendTransferETaxListSelect( param );
			if ( gwTransferList != null && !gwTransferList.isEmpty( ) ) {
				String transferIssNo = "";
				for ( Map<String, Object> tData : gwTransferList ) {
					transferIssNo += tData.get( "issNo" ).toString( ) + "','";
				}
				if ( transferIssNo.length( ) > 3 ) {
					transferIssNo = transferIssNo.substring( 0, transferIssNo.length( ) - 3 );
				}
				etaxVo.setTransferIssNo( transferIssNo );
			}
			/* 자신의 Email 주소는 기본으로 검색 */
			etaxVo.setBaseEmailAddr( CommonConvert.CommonGetEmpVO( ).getEmail( ) + "@" );

			/* iCUBE 매입전자세금계산서 데이터 */
			/* 매입 전자 세금계산서 조회 */
			etaxVo.setTaxTy( "2" );
			List<ExCodeETaxVO> eTaxList1 = new ArrayList<ExCodeETaxVO>( );
			eTaxList1 = daoI.ExETaxListInfoSelect( etaxVo, conVo );
			/* 면세 매입 전자 세금계산서 조회 */
			List<ExCodeETaxVO> eTaxList2 = new ArrayList<ExCodeETaxVO>( );
			etaxVo.setTaxTy( "4" );
			eTaxList2 = daoI.ExETaxListInfoSelect( etaxVo, conVo );
			etaxListVo.addAll( eTaxList1 );
			etaxListVo.addAll( eTaxList2 );
			/* 그룹웨어 데이터 */
			String issNo = commonCode.EMPTYSTR;
			for ( ExCodeETaxVO tData : etaxListVo ) {
				issNo += tData.getIssNo( ) + "','";
			}
			/* ERP에서 조회된 세금계산서 정보만 조회(불필요한 그룹웨어 데이터 미조회) */
			if ( etaxListVo != null && etaxListVo.size( ) > 0 ) {
				issNo = issNo.substring( 0, issNo.length( ) - 3 );
				etaxVo.setNotInsertIssNo( issNo );
			}
			etaxBizboxAListVo = daoA.ExExpendETaxSubListInfoSelect( etaxVo );
			int defaultCount = 0;
			for ( ExCodeETaxVO etaxiCUBEVo : etaxListVo ) {
				if ( etaxVo.getSearchStr( ).equals( commonCode.EMPTYSTR ) && defaultCount == commonCode.ETAXDEAFAULTCOUNT ) {
					break;
				}
				boolean isBizboxAData = false;
				for ( ExCodeETaxVO etaxBizboxAVo : etaxBizboxAListVo ) {
					if ( etaxBizboxAVo.getIssNo( ).equals( etaxiCUBEVo.getIssNo( ) ) ) {
						etaxiCUBEVo.setSyncId( etaxBizboxAVo.getSyncId( ) );
						etaxiCUBEVo.setSendYN( etaxBizboxAVo.getSendYN( ) );
						etaxiCUBEVo.setExpendEmpSeq( etaxBizboxAVo.getExpendEmpSeq( ) );
						etaxiCUBEVo.setExpendSummarySeq( etaxBizboxAVo.getExpendSummarySeq( ) );
						etaxiCUBEVo.setExpendAuthSeq( etaxBizboxAVo.getExpendAuthSeq( ) );
						etaxiCUBEVo.setExpendProjectSeq( etaxBizboxAVo.getExpendProjectSeq( ) );
						etaxiCUBEVo.setExpendCardSeq( etaxBizboxAVo.getExpendCardSeq( ) );
						etaxiCUBEVo.setNote( etaxBizboxAVo.getNote( ) ); /* 적요 */
						etaxiCUBEVo.setEmpSeq( etaxBizboxAVo.getEmpSeq( ) ); /* 사용자 시퀀스 */
						etaxiCUBEVo.setEmpName( etaxBizboxAVo.getEmpName( ) ); /* 사용자 명 */
						etaxiCUBEVo.setDeptSeq( etaxBizboxAVo.getDeptSeq( ) ); /* 부서 시퀀스 */
						etaxiCUBEVo.setDeptName( etaxBizboxAVo.getDeptName( ) ); /* 부서 명 */
						etaxiCUBEVo.setErpPcSeq( etaxBizboxAVo.getErpPcSeq( ) ); /* 사용자 회계단위 시퀀스 */
						etaxiCUBEVo.setErpPcName( etaxBizboxAVo.getErpPcName( ) ); /* 사용자 회계단위 명 */
						etaxiCUBEVo.setErpCcSeq( etaxBizboxAVo.getErpCcSeq( ) ); /* 사용자 코스트센터 시퀀스 */
						etaxiCUBEVo.setErpCcName( etaxBizboxAVo.getErpCcName( ) ); /* 사용자 코스트센터 명 */
						etaxiCUBEVo.setSummaryCode( etaxBizboxAVo.getSummaryCode( ) ); /* 표준적요 코드 */
						etaxiCUBEVo.setSummaryName( etaxBizboxAVo.getSummaryName( ) ); /* 표준적요 명칭 */
						etaxiCUBEVo.setAuthDiv( etaxBizboxAVo.getAuthDiv( ) ); /* 증빙유형 구분 */
						etaxiCUBEVo.setAuthCode( etaxBizboxAVo.getAuthCode( ) ); /* 증빙유형 코드 */
						etaxiCUBEVo.setAuthName( etaxBizboxAVo.getAuthName( ) ); /* 증빙유형 명칭 */
						etaxiCUBEVo.setCashType( etaxBizboxAVo.getCashType( ) ); /* 현금영수증 구분 */
						etaxiCUBEVo.setDrAcctCode(etaxBizboxAVo.getDrAcctCode()); /* 차변 계정 코드 */
						etaxiCUBEVo.setDrAcctName(etaxBizboxAVo.getDrAcctName()); /* 차변 계정 명칭 */
						etaxiCUBEVo.setCrAcctCode( etaxBizboxAVo.getCrAcctCode( ) ); /* 대변 대체 계정 코드 */
						etaxiCUBEVo.setCrAcctName( etaxBizboxAVo.getCrAcctName( ) ); /* 대변 대체 계정 명칭 */
						etaxiCUBEVo.setVatAcctCode( etaxBizboxAVo.getVatAcctCode( ) ); /* 부가세 대체 계정 코드 */
						etaxiCUBEVo.setVatAcctName( etaxBizboxAVo.getVatAcctName( ) ); /* 부가세 대체 계정 명칭 */
						etaxiCUBEVo.setVatTypeCode( etaxBizboxAVo.getVatTypeCode( ) ); /* 부가세 구분 ( 세무구분 ) 코드 */
						etaxiCUBEVo.setVatTypeName( etaxBizboxAVo.getVatTypeName( ) ); /* 부가세 구분 ( 세무구분 ) 명칭 */
						etaxiCUBEVo.setErpAuthCode( etaxBizboxAVo.getErpAuthCode( ) ); /* ERP 증빙 코드 */
						etaxiCUBEVo.setErpAuthName( etaxBizboxAVo.getErpAuthName( ) ); /* ERP 증빙 명칭 */
						etaxiCUBEVo.setExpendAuthRequiredYN( etaxBizboxAVo.getExpendAuthRequiredYN( ) ); /* 증빙일자 필수입력 여부 */
						etaxiCUBEVo.setExpendPartnerRequiredYN( etaxBizboxAVo.getExpendPartnerRequiredYN( ) ); /* 거래처 필수입력 여부 */
						etaxiCUBEVo.setExpendCardRequiredYN( etaxBizboxAVo.getExpendCardRequiredYN( ) ); /* 카드 필수입력 여부 */
						etaxiCUBEVo.setExpendProjectRequiredYN( etaxBizboxAVo.getExpendProjectRequiredYN( ) ); /* 프로젝트 필수입력 여부 */
						etaxiCUBEVo.setExpendNoteRequiredYN( etaxBizboxAVo.getExpendNoteRequiredYN( ) ); /* 적요 필수입력 여부 */
						etaxiCUBEVo.setNoTaxCode( etaxBizboxAVo.getNoTaxCode( ) ); /* 불공제구분 코드 */
						etaxiCUBEVo.setNoTaxName( etaxBizboxAVo.getNoTaxName( ) ); /* 불공제구분 명칭 */
						etaxiCUBEVo.setVaTypeCode( etaxBizboxAVo.getVaTypeCode( ) ); /* 사유구분 코드 */
						etaxiCUBEVo.setVaTypeName( etaxBizboxAVo.getVaTypeName( ) ); /* 사유구분 명칭 */
						etaxiCUBEVo.setProjectCode( etaxBizboxAVo.getProjectCode( ) ); /* 프로젝트 코드 */
						etaxiCUBEVo.setProjectName( etaxBizboxAVo.getProjectName( ) ); /* 프로젝트 명칭 */
						etaxiCUBEVo.setCardNum( etaxBizboxAVo.getCardNum( ) ); /* 카드 번호 */
						etaxiCUBEVo.setCardName( etaxBizboxAVo.getCardName( ) ); /* 카드 명칭 */
						/* 예산정보 */
						etaxiCUBEVo.setExpendBudgetSeq( etaxBizboxAVo.getExpendBudgetSeq( ) );
						etaxiCUBEVo.setBudgetCode( etaxBizboxAVo.getBudgetCode( ) );
						etaxiCUBEVo.setBudgetName( etaxBizboxAVo.getBudgetName( ) );
						etaxiCUBEVo.setBizplanCode( etaxBizboxAVo.getBizplanCode( ) );
						etaxiCUBEVo.setBizplanName( etaxBizboxAVo.getBizplanName( ) );
						etaxiCUBEVo.setBgacctCode( etaxBizboxAVo.getBgacctCode( ) );
						etaxiCUBEVo.setBgacctName( etaxBizboxAVo.getBgacctName( ) );
						if ( etaxBizboxAVo.getSendYN( ).equals( commonCode.EMPTYYES ) ) {
							isBizboxAData = true;
						}
						break;
					}
				}
				if ( !isBizboxAData ) {
					resultListVo.add( etaxiCUBEVo );
					defaultCount++;
				}
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExCodeETaxVO> etaxListVo >> " + etaxListVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FExUserEtaxServiceIImpl - ExETaxListInfoSelect" );
		return resultListVo;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 조회 */
	@Override
	public ExCodeETaxVO ExETaxDetailInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExUserEtaxServiceIImpl - ExETaxDetailInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExCodeETaxVO etaxVo >> " + etaxVo.toString( ) );
		try {
			etaxVo = daoI.ExETaxDetailInfoSelect( etaxVo, conVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCodeETaxVO etaxVo >> " + etaxVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FExUserEtaxServiceIImpl - ExETaxDetailInfoSelect" );
		return etaxVo;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 연동 코드 저장 */
	@Override
	public ResultVO ExExpendETaxInfoMapUpdate ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExUserEtaxServiceIImpl - ExExpendETaxInfoMapUpdate" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> param >> " + param.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			ExCodeOrgVO orgVo = new ExCodeOrgVO( );
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
			ExCodeAuthVO authVo = new ExCodeAuthVO( );
			ExCodeProjectVO projectVo = new ExCodeProjectVO( );
			ExCodeCardVO cardVo = new ExCodeCardVO( );
			ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( );
			List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>( );
			orgVo = (ExCodeOrgVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "empInfo" ) ), orgVo );
			summaryVo = (ExCodeSummaryVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "summaryInfo" ) ), summaryVo );
			authVo = (ExCodeAuthVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "authInfo" ) ), authVo );
			projectVo = (ExCodeProjectVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "projectInfo" ) ), projectVo );
			cardVo = (ExCodeCardVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "cardInfo" ) ), cardVo );
			if ( param.get( "budgetInfo" ) != null ) {
				budgetVo = (ExCodeBudgetVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "budgetInfo" ) ), budgetVo );
			}
			for ( Map<String, Object> map : (List<Map<String, Object>>) ConvertManager.ConvertJsonToListMap( (String) param.get( "key" ) ) ) {
				ExCodeETaxVO etaxVo = new ExCodeETaxVO( );
				etaxVo.setIssNo( (String) map.get( "key" ) ); /* 승인번호 */
				etaxVo.setIssDt( (String) map.get( "item_1" ) ); /* 작성일자 */
				etaxVo.setTrregNb( (String) map.get( "item_2" ) ); /* 공급자 사업자등록번호 */
				etaxVo.setCompSeq( loginVo.getCompSeq( ) );
				etaxVo.setCreateSeq( loginVo.getUniqId( ) );
				etaxVo.setModifySeq( loginVo.getUniqId( ) );
				etaxListVo.add( etaxVo );
			}
			for ( ExCodeETaxVO exCodeETaxVO : etaxListVo ) {
				/* 사용자 처리 */
				if ( orgVo.getSeq( ) == 0 ) {
					cmLog.CommonSetInfo( "! [EX] 사용자 정보 신규 생성" );
					orgVo.setCompSeq( loginVo.getCompSeq( ) );
					orgVo.setCreateSeq( loginVo.getUniqId( ) );
					orgVo.setModifySeq( loginVo.getUniqId( ) );
					orgVo = codeService.ExExpendEmpInfoInsert( orgVo );
					exCodeETaxVO.setExpendEmpSeq( orgVo.getSeq( ) );
					orgVo.setSeq( 0 );
				}
				else {
					exCodeETaxVO.setExpendEmpSeq( orgVo.getSeq( ) );
				}
				/* 표준적요 처리 */
				if ( summaryVo.getSeq( ) == 0 ) {
					cmLog.CommonSetInfo( "! [EX] 표준적요 정보 신규 생성" );
					summaryVo.setCompSeq( loginVo.getCompSeq( ) );
					summaryVo.setCreateSeq( loginVo.getUniqId( ) );
					summaryVo.setModifySeq( loginVo.getUniqId( ) );
					summaryVo = codeService.ExExpendSummaryInfoInsert( summaryVo );
					exCodeETaxVO.setExpendSummarySeq( summaryVo.getSeq( ) );
					summaryVo.setSeq( 0 );
				}
				else {
					exCodeETaxVO.setExpendSummarySeq( summaryVo.getSeq( ) );
				}
				/* 증빙유형 처리 */
				if ( authVo.getSeq( ) == 0 ) {
					cmLog.CommonSetInfo( "! [EX] 증빙유형 정보 신규 생성" );
					authVo.setCompSeq( loginVo.getCompSeq( ) );
					authVo.setCreateSeq( loginVo.getUniqId( ) );
					authVo.setModifySeq( loginVo.getUniqId( ) );
					authVo = codeService.ExExpendAuthInfoInsert( authVo );
					exCodeETaxVO.setExpendAuthSeq( authVo.getSeq( ) );
					authVo.setSeq( 0 );
				}
				else {
					exCodeETaxVO.setExpendAuthSeq( authVo.getSeq( ) );
				}
				/* 프로젝트 처리 */
				if ( projectVo.getSeq( ) == 0 ) {
					boolean isDeleteProject = false;
					if ( param.get( "isDeleteProject" ) != null ) {
						isDeleteProject = Boolean.parseBoolean( param.get( "isDeleteProject" ).toString( ) );
					}
					cmLog.CommonSetInfo( "! [EX] 프로젝트 정보 신규 생성" );
					projectVo.setCompSeq( loginVo.getCompSeq( ) );
					projectVo.setCreateSeq( loginVo.getUniqId( ) );
					projectVo.setModifySeq( loginVo.getUniqId( ) );
					/* 프로젝트 정보 삭제 후 저장 시 */
					if ( !isDeleteProject ) {
						projectVo = codeService.ExExpendProjectInfoInsert( projectVo );
					}
					exCodeETaxVO.setExpendProjectSeq( projectVo.getSeq( ) );
					projectVo.setSeq( 0 );
				}
				else {
					exCodeETaxVO.setExpendProjectSeq( projectVo.getSeq( ) );
				}
				/* 카드 처리 */
				if ( cardVo.getSeq( ) == 0 ) {
					boolean isDeleteCard = false;
					if ( param.get( "isDeleteCard" ) != null ) {
						isDeleteCard = Boolean.parseBoolean( param.get( "isDeleteCard" ).toString( ) );
					}
					cmLog.CommonSetInfo( "! [EX] 카드 정보 신규 생성" );
					cardVo.setCompSeq( loginVo.getCompSeq( ) );
					cardVo.setCreateSeq( loginVo.getUniqId( ) );
					cardVo.setModifySeq( loginVo.getUniqId( ) );
					/* 카드 정보 삭제 후 저장 시 */
					if ( !isDeleteCard ) {
						cardVo = codeService.ExExpendCardInfoInsert( cardVo );
					}
					exCodeETaxVO.setExpendCardSeq( cardVo.getSeq( ) );
					cardVo.setSeq( 0 );
				}
				else {
					exCodeETaxVO.setExpendCardSeq( cardVo.getSeq( ) );
				}
				/* 예산 처리 */
				if ( budgetVo.getSeq( ) == 0 ) {
					cmLog.CommonSetInfo( "! [EX] 예산 정보 신규 생성" );
					budgetVo.setCompSeq( loginVo.getCompSeq( ) );
					budgetVo.setCreateSeq( loginVo.getUniqId( ) );
					budgetVo.setModifySeq( loginVo.getUniqId( ) );
					budgetVo = codeService.ExExpendBudgetInfoInsert( budgetVo );
					exCodeETaxVO.setExpendBudgetSeq( budgetVo.getSeq( ) );
					budgetVo.setSeq( 0 );
				}
				else {
					exCodeETaxVO.setExpendBudgetSeq( budgetVo.getSeq( ) );
				}
				/* 적요처리 */
				exCodeETaxVO.setNote( (String) param.get( "note" ) );
				cmLog.CommonSetInfo( "! [EX] ExCodeETaxVO exCodeETaxVO >> " + exCodeETaxVO.toString( ) );
				/* 매입전자세금계산서 생성 또는 수정 */
				resultVo = this.ExExpendETaxSubInfoUpdate( exCodeETaxVO );
				if ( resultVo.getResultCode( ).equals( commonCode.FAIL ) ) {
					throw new Exception( BizboxAMessage.getMessage( "TX000009291", "카드 사용내역 갱신 실패" ) );
				}
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FExUserEtaxServiceIImpl - ExExpendETaxInfoMapUpdate" );
		return resultVo;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 지출결의 항목 분개 처리 */
	@Override
	public ExCommonResultVO ExETaxInfoMake ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception {
		/* BizboxAService 수행 */
		return null;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 상태값 수정 */
	@Override
	public ResultVO ExExpendETaxInfoUpdate ( ExCodeETaxVO etaxVo ) throws Exception {
		/* BizboxAService 수행 */
		return null;
	}

	/* 매입전자세금계산서 생성 또는 수정 */
	private ResultVO ExExpendETaxSubInfoUpdate ( ExCodeETaxVO etaxVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExUserEtaxServiceIImpl - ExExpendETaxSubInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExCodeETaxVO etaxVo >> " + etaxVo.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			ExCodeETaxVO beforeETaxVo = new ExCodeETaxVO( );
			beforeETaxVo = daoA.ExExpendETaxSubInfoSelect( etaxVo );
			if ( beforeETaxVo == null ) {
				beforeETaxVo = new ExCodeETaxVO( );
			}
			if ( String.valueOf( beforeETaxVo.getSyncId( ) ).equals( commonCode.EMPTYSEQ ) ) {
				resultVo = daoA.ExExpendETaxSubInfoInsert( etaxVo );
			}
			else {
				resultVo = daoA.ExExpendETaxSubInfoUpdate( etaxVo );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] FExUserEtaxServiceIImpl - ExExpendETaxSubInfoUpdate" );
		return resultVo;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 목록 상태값 수정 */
	@Override
	public InterlockExpendVO ExUserETaxStateListInfoUpdate ( Map<String, Object> params ) throws Exception {
		return null;
	}

	/* 매입전자세금계산서 - 세금계산서 현황 리스트 조회 */
	public List<Map<String, Object>> ExUserTtaxReportList ( ResultVO etaxResult, ConnectionVO conVo ) throws Exception {
		/* 매입 전자 세금계산서 조회 */
		ExCodeETaxVO etaxVo = new ExCodeETaxVO( );
		List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>( );
		List<ExCodeETaxVO> etaxAppListVo = new ArrayList<ExCodeETaxVO>( );
		/* 현재 작성중인 세금계산서, 미사용 세금계산서 제외 */
		etaxVo.setSearchFromDt( etaxResult.getParams( ).get( "searchFromDt" ).toString( ) );
		etaxVo.setSearchToDt( etaxResult.getParams( ).get( "searchToDt" ).toString( ) );
		etaxVo.setEmpSeq( etaxResult.getParams( ).get("empSeq").toString( ) );
		etaxVo.setCompSeq( etaxResult.getParams( ).get("compSeq").toString( ) );
		etaxAppListVo = daoA.ExExpendETaxSubAppListInfoSelect( etaxVo );
		String userIssNo = commonCode.EMPTYSTR;
		if ( etaxAppListVo != null && etaxAppListVo.size( ) > 0 ) {
			for ( ExCodeETaxVO usedEtax : etaxAppListVo ) {
				userIssNo += usedEtax.getIssNo( ) + "','";
			}
			userIssNo = userIssNo.substring( 0, userIssNo.length( ) - 3 );
			etaxVo.setNotInsertIssNo( userIssNo );
		}
		/* 그룹웨어 세금계산서 권한 조회 */
		List<Map<String, Object>> gwEtaxAuth = new ArrayList<Map<String, Object>>( );
		Map<String, Object> param = new HashMap<String, Object>( );
		param.put( "empSeq", etaxVo.getEmpSeq( ) );
		param.put( "compSeq", etaxVo.getCompSeq( ) );
		gwEtaxAuth = daoA.ExExpendETaxAuthSelect( param );
		String gwAuthEmail = commonCode.EMPTYSTR;
		String gwAuthRegNo = commonCode.EMPTYSTR;
		if ( gwEtaxAuth != null && gwEtaxAuth.size( ) > 0 ) {
			for ( Map<String, Object> tData : gwEtaxAuth ) {
				if ( CommonConvert.CommonGetStr(tData.get( "authType" )).equals( "P" ) ) {
					gwAuthRegNo += CommonConvert.CommonGetStr(tData.get( "code" )) + "','";
				}
				else {
					gwAuthEmail += CommonConvert.CommonGetStr(tData.get( "code" )) + "','";
				}
			}
			if ( gwAuthRegNo.length( ) > 3 ) {
				gwAuthRegNo = gwAuthRegNo.substring( 0, gwAuthRegNo.length( ) - 3 );
			}
			if ( gwAuthEmail.length( ) > 3 ) {
				gwAuthEmail = gwAuthEmail.substring( 0, gwAuthEmail.length( ) - 3 );
			}
			etaxVo.setTrchargeEmail( gwAuthEmail );
			etaxVo.setTrregNb( gwAuthRegNo );
		}else{
			etaxVo.setTrchargeEmail( "DouzoneEmptyEmail" );
			etaxVo.setTrregNb( "DouzoneEmptyTrregNb" );
		}
		/* 이관 받은 세금계산서 정보 조회 */
		List<Map<String, Object>> gwTransferList = new ArrayList<Map<String, Object>>( );
		param.put( "searchFromDt", etaxVo.getSearchFromDt( ) );
		param.put( "searchToDt", etaxVo.getSearchToDt( ) );
		gwTransferList = daoA.ExExpendTransferETaxListSelect( param );
		if ( gwTransferList != null && !gwTransferList.isEmpty( ) ) {
			String transferIssNo = "";
			for ( Map<String, Object> tData : gwTransferList ) {
				transferIssNo += tData.get( "issNo" ).toString( ) + "','";
			}
			if ( transferIssNo.length( ) > 3 ) {
				transferIssNo = transferIssNo.substring( 0, transferIssNo.length( ) - 3 );
			}
			etaxVo.setTransferIssNo( transferIssNo );
		}
		/* 자신의 Email 주소는 기본으로 검색 */
		etaxVo.setBaseEmailAddr( CommonConvert.CommonGetEmpVO( ).getEmail( ) + "@" );
		etaxVo.setErpCompSeq( conVo.getErpCompSeq( ) );

		/* 검색조건 */
		etaxVo.setSearchIssNo( etaxResult.getParams( ).get( "issNo" ).toString( ) );
		etaxVo.setSearchPartnerNm( etaxResult.getParams( ).get( "partnerName" ).toString( ) );
		etaxVo.setSearchPartnerNo( etaxResult.getParams( ).get( "partnerNo" ).toString( ) );
		etaxVo.setEmailDc( etaxResult.getParams( ).get( "emailDc" ).toString( ) );

		/* iCUBE 매입전자세금계산서 데이터 */
		/* 매입 전자 세금계산서 조회 */
		etaxVo.setBizplanCode( etaxResult.getParams( ).get( "bizplanCode" ).toString( ) );
		etaxVo.setTaxTy( "2" );
		List<Map<String, Object>> eTaxList1 = new ArrayList<Map<String, Object>>( );
		eTaxList1 = daoI.ExETaxListInfoSelectMap( etaxVo, conVo );
		/* 면세 매입 전자 세금계산서 조회 */
		List<Map<String, Object>> eTaxList2 = new ArrayList<Map<String, Object>>( );
		etaxVo.setTaxTy( "4" );
		eTaxList2 = daoI.ExETaxListInfoSelectMap( etaxVo, conVo );
		etaxListVo.addAll( eTaxList1 );
		etaxListVo.addAll( eTaxList2 );
		return etaxListVo;
	}

	/* 매입전자세금계산서 - 세금계산서 상세 정보 조회 */
	@Override
	public Map<String, Object> ExExpendEtaxGWInfoSelect ( Map<String, Object> param ){
		Map<String, Object> result = new HashMap<String, Object>( );
		return result;
	}

	/* 매입전자세금계산서 - 지출결의 정보 조회 */
	@Override
	public List<Map<String, Object>> ExUserETaxExpendInfoSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}
}
