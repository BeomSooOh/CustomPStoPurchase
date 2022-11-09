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
import expend.ex.user.list.BExUserListService;
import main.web.BizboxAMessage;


@Service ( "FExUserEtaxServiceUImpl" )
public class FExUserEtaxServiceUImpl implements FExUserEtaxService {

	/* 변수정의 - Helper */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 - 공통코드 */
	@Resource ( name = "BExUserCodeService" ) /* 공통 조회 서비스 */
	private BExUserCodeService codeService;
	/* 변수정의 - 전표 */
	@Resource ( name = "BExUserListService" ) /* 전표 서비스 */
	private BExUserListService listService;
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserEtaxServiceADAO" )
	private FExUserEtaxServiceADAO daoA;
	@Resource ( name = "FExUserEtaxServiceUDAO" )
	private FExUserEtaxServiceUDAO daoU;

	/* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
	@Override
	public List<ExCodeETaxVO> ExETaxListInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExUserEtaxServiceIImpl - ExETaxListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExCodeETaxVO etaxVo >> " + etaxVo.toString( ) );
		List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>( );
		List<ExCodeETaxVO> etaxBizboxAListVo = new ArrayList<ExCodeETaxVO>( );
		List<ExCodeETaxVO> etaxAppListVo = new ArrayList<ExCodeETaxVO>( );
		ExCodeETaxVO subEtaxVo = new ExCodeETaxVO();
		/* 반환 데이터 */
		List<ExCodeETaxVO> resultListVo = new ArrayList<ExCodeETaxVO>( );
		try {
			/*ERPiU 옵션에 따른 미사용처리된 매입전자세금계산서 변경 */
			subEtaxVo = daoU.ExTaxListCompOption( etaxVo, conVo );
			etaxVo.setTpTbTaxCompany(subEtaxVo.getTpTbTaxCompany());
			//System.out.println(etaxVo.getTpTbTaxCompany());
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
			/* ERPiU 매입전자세금계산서 데이터 */
			etaxListVo = daoU.ExETaxListInfoSelect( etaxVo, conVo );
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

                        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
			etaxBizboxAListVo = daoA.ExExpendETaxSubListInfoSelect( etaxVo );
			int defaultCount = 0;
			for ( ExCodeETaxVO etaxERPiUVo : etaxListVo ) {
				if ( etaxVo.getSearchStr( ).equals( commonCode.EMPTYSTR ) && defaultCount == commonCode.ETAXDEAFAULTCOUNT ) {
					break;
				}
				boolean isBizboxAData = false;
				for ( ExCodeETaxVO etaxBizboxAVo : etaxBizboxAListVo ) {
					if ( etaxBizboxAVo.getIssNo( ).equals( etaxERPiUVo.getIssNo( ) ) ) {
						etaxERPiUVo.setHometaxIssNo( etaxERPiUVo.getHometaxIssNo( ) );
						etaxERPiUVo.setSyncId( etaxBizboxAVo.getSyncId( ) );
						etaxERPiUVo.setSendYN( etaxBizboxAVo.getSendYN( ) );
						etaxERPiUVo.setExpendEmpSeq( etaxBizboxAVo.getExpendEmpSeq( ) );
						etaxERPiUVo.setExpendSummarySeq( etaxBizboxAVo.getExpendSummarySeq( ) );
						etaxERPiUVo.setExpendAuthSeq( etaxBizboxAVo.getExpendAuthSeq( ) );
						etaxERPiUVo.setExpendProjectSeq( etaxBizboxAVo.getExpendProjectSeq( ) );
						etaxERPiUVo.setExpendCardSeq( etaxBizboxAVo.getExpendCardSeq( ) );
						etaxERPiUVo.setNote( etaxBizboxAVo.getNote( ) ); /* 적요 */
						etaxERPiUVo.setEmpSeq( etaxBizboxAVo.getEmpSeq( ) ); /* 사용자 시퀀스 */
						etaxERPiUVo.setEmpName( etaxBizboxAVo.getEmpName( ) ); /* 사용자 명 */
						etaxERPiUVo.setDeptSeq( etaxBizboxAVo.getDeptSeq( ) ); /* 부서 시퀀스 */
						etaxERPiUVo.setDeptName( etaxBizboxAVo.getDeptName( ) ); /* 부서 명 */
						etaxERPiUVo.setErpPcSeq( etaxBizboxAVo.getErpPcSeq( ) ); /* 사용자 회계단위 시퀀스 */
						etaxERPiUVo.setErpPcName( etaxBizboxAVo.getErpPcName( ) ); /* 사용자 회계단위 명 */
						etaxERPiUVo.setErpCcSeq( etaxBizboxAVo.getErpCcSeq( ) ); /* 사용자 코스트센터 시퀀스 */
						etaxERPiUVo.setErpCcName( etaxBizboxAVo.getErpCcName( ) ); /* 사용자 코스트센터 명 */
						etaxERPiUVo.setSummaryCode( etaxBizboxAVo.getSummaryCode( ) ); /* 표준적요 코드 */
						etaxERPiUVo.setSummaryName( etaxBizboxAVo.getSummaryName( ) ); /* 표준적요 명칭 */
						etaxERPiUVo.setAuthDiv( etaxBizboxAVo.getAuthDiv( ) ); /* 증빙유형 구분 */
						etaxERPiUVo.setAuthCode( etaxBizboxAVo.getAuthCode( ) ); /* 증빙유형 코드 */
						etaxERPiUVo.setAuthName( etaxBizboxAVo.getAuthName( ) ); /* 증빙유형 명칭 */
						etaxERPiUVo.setCashType( etaxBizboxAVo.getCashType( ) ); /* 현금영수증 구분 */
						etaxERPiUVo.setCrAcctCode( etaxBizboxAVo.getCrAcctCode( ) ); /* 대변 대체 계정 코드 */
						etaxERPiUVo.setCrAcctName( etaxBizboxAVo.getCrAcctName( ) ); /* 대변 대체 계정 명칭 */
						etaxERPiUVo.setVatAcctCode( etaxBizboxAVo.getVatAcctCode( ) ); /* 부가세 대체 계정 코드 */
						etaxERPiUVo.setVatAcctName( etaxBizboxAVo.getVatAcctName( ) ); /* 부가세 대체 계정 명칭 */
						etaxERPiUVo.setVatTypeCode( etaxBizboxAVo.getVatTypeCode( ) ); /* 부가세 구분 ( 세무구분 ) 코드 */
						etaxERPiUVo.setVatTypeName( etaxBizboxAVo.getVatTypeName( ) ); /* 부가세 구분 ( 세무구분 ) 명칭 */
						etaxERPiUVo.setErpAuthCode( etaxBizboxAVo.getErpAuthCode( ) ); /* ERP 증빙 코드 */
						etaxERPiUVo.setErpAuthName( etaxBizboxAVo.getErpAuthName( ) ); /* ERP 증빙 명칭 */
						etaxERPiUVo.setExpendAuthRequiredYN( etaxBizboxAVo.getExpendAuthRequiredYN( ) ); /* 증빙일자 필수입력 여부 */
						etaxERPiUVo.setExpendPartnerRequiredYN( etaxBizboxAVo.getExpendPartnerRequiredYN( ) ); /* 거래처 필수입력 여부 */
						etaxERPiUVo.setExpendCardRequiredYN( etaxBizboxAVo.getExpendCardRequiredYN( ) ); /* 카드 필수입력 여부 */
						etaxERPiUVo.setExpendProjectRequiredYN( etaxBizboxAVo.getExpendProjectRequiredYN( ) ); /* 프로젝트 필수입력 여부 */
						etaxERPiUVo.setExpendNoteRequiredYN( etaxBizboxAVo.getExpendNoteRequiredYN( ) ); /* 적요 필수입력 여부 */
						etaxERPiUVo.setNoTaxCode( etaxBizboxAVo.getNoTaxCode( ) ); /* 불공제구분 코드 */
						etaxERPiUVo.setNoTaxName( etaxBizboxAVo.getNoTaxName( ) ); /* 불공제구분 명칭 */
						etaxERPiUVo.setVaTypeCode( etaxBizboxAVo.getVaTypeCode( ) ); /* 사유구분 코드 */
						etaxERPiUVo.setVaTypeName( etaxBizboxAVo.getVaTypeName( ) ); /* 사유구분 명칭 */
						etaxERPiUVo.setProjectCode( etaxBizboxAVo.getProjectCode( ) ); /* 프로젝트 코드 */
						etaxERPiUVo.setProjectName( etaxBizboxAVo.getProjectName( ) ); /* 프로젝트 명칭 */
						etaxERPiUVo.setCardNum( etaxBizboxAVo.getCardNum( ) ); /* 카드 번호 */
						etaxERPiUVo.setCardName( etaxBizboxAVo.getCardName( ) ); /* 카드 명칭 */
						etaxERPiUVo.setDrAcctCode( etaxBizboxAVo.getDrAcctCode()); /* 표준적요에 매핑되어있는 차변계정 코드 */
						etaxERPiUVo.setDrAcctName( etaxBizboxAVo.getDrAcctName()); /* 표준적요에 매핑되어있는 차변계정 명칭 */
						/* 예산정보 */
						etaxERPiUVo.setExpendBudgetSeq( etaxBizboxAVo.getExpendBudgetSeq( ) );
						etaxERPiUVo.setBudgetCode( etaxBizboxAVo.getBudgetCode( ) );
						etaxERPiUVo.setBudgetName( etaxBizboxAVo.getBudgetName( ) );
						etaxERPiUVo.setBizplanCode( etaxBizboxAVo.getBizplanCode( ) );
						etaxERPiUVo.setBizplanName( etaxBizboxAVo.getBizplanName( ) );
						etaxERPiUVo.setBgacctCode( etaxBizboxAVo.getBgacctCode( ) );
						etaxERPiUVo.setBgacctName( etaxBizboxAVo.getBgacctName( ) );
						etaxERPiUVo.setAuthRequiredYN( etaxBizboxAVo.getAuthRequiredYN( ) );
						etaxERPiUVo.setPartnerRequiredYN( etaxBizboxAVo.getPartnerRequiredYN( ) );
						etaxERPiUVo.setCardRequiredYN( etaxBizboxAVo.getCardRequiredYN( ) );
						etaxERPiUVo.setProjectRequiredYN( etaxBizboxAVo.getProjectRequiredYN( ) );
						etaxERPiUVo.setNoteRequiredYN( etaxBizboxAVo.getNoteRequiredYN( ) );

						// 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
						etaxERPiUVo.setCdBgLevel(etaxBizboxAVo.getCdBgLevel());
						etaxERPiUVo.setYnControl(etaxBizboxAVo.getYnControl());
						etaxERPiUVo.setTpControl(etaxBizboxAVo.getTpControl());

						if ( etaxBizboxAVo.getSendYN( ).equals( commonCode.EMPTYYES ) ) {
							isBizboxAData = true;
						}
						break;
					}
				}
				if ( !isBizboxAData ) {
					resultListVo.add( etaxERPiUVo );
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
		return null;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 연동 코드 저장 */
	@Override
	public ResultVO ExExpendETaxInfoMapUpdate ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] FExUserEtaxServiceUImpl - ExExpendETaxInfoMapUpdate" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> param >> " + param.toString( ) );
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			ExCodeOrgVO orgVo = new ExCodeOrgVO( );
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
			ExCodeAuthVO authVo = new ExCodeAuthVO( );
			ExCodeProjectVO projectVo = new ExCodeProjectVO( );
			ExCodeCardVO cardVo = new ExCodeCardVO( );
            // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
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
			for ( Map<String, Object> map : ConvertManager.ConvertJsonToListMap( (String) param.get( "key" ) ) ) {
				ExCodeETaxVO etaxVo = new ExCodeETaxVO( );
				etaxVo.setIssNo( (String) map.get( "key" ) ); /* 승인번호 */
				etaxVo.setIssDt( (String) map.get( "item_1" ) ); /* 작성일자 */
				etaxVo.setTrregNb( (String) map.get( "item_2" ) ); /* 공급자 사업자등록번호 */
				etaxVo.setHometaxIssNo( (String) map.get( "item_3" ) ); /*국세청 번호 */
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
					budgetVo.setBudgetType( conVo.getErpTypeCode( ) );
					if ( budgetVo.getBizplanCode( ) == commonCode.EMPTYSEQ ) {
                                            budgetVo.setBizplanCode("***");
					}
                    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
					budgetVo = codeService.ExExpendBudgetInfoInsert( budgetVo );
					exCodeETaxVO.setExpendBudgetSeq( budgetVo.getSeq( ) );
					budgetVo.setSeq( 0 );
				}
				else {
					ExCodeBudgetVO tBudget = new ExCodeBudgetVO( );
					boolean isEditBudget = false;
					tBudget.setSeq( budgetVo.getSeq( ) );
					// 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
					tBudget = codeService.ExExpendBudgetInfoSelect( tBudget );
					/* 기존 정보와 신규 정보 비교 */
					if ( !tBudget.getBudgetCode( ).equals( budgetVo.getBudgetCode( ) ) ) {
						budgetVo.setSeq( Integer.parseInt( commonCode.EMPTYSEQ ) );
						isEditBudget = true;
					}
					if ( !tBudget.getBizplanCode( ).equals( budgetVo.getBizplanCode( ) ) ) {
						budgetVo.setSeq( Integer.parseInt( commonCode.EMPTYSEQ ) );
						isEditBudget = true;
					}
					if ( !tBudget.getBgacctCode( ).equals( budgetVo.getBgacctCode( ) ) ) {
						budgetVo.setSeq( Integer.parseInt( commonCode.EMPTYSEQ ) );
						isEditBudget = true;
					}
					// 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
					if(tBudget.getCdBgLevel() == null || tBudget.getCdBgLevel().equals("")
					    || tBudget.getYnControl() == null || tBudget.getYnControl().equals("")
					    || tBudget.getTpControl() == null || tBudget.getTpControl().equals("")) {
					    isEditBudget = true;
					}

					if(!tBudget.getCdBgLevel().equals(budgetVo.getCdBgLevel())) {
					    budgetVo.setSeq( Integer.parseInt( commonCode.EMPTYSEQ ) );
                        isEditBudget = true;
					}
					if(!tBudget.getYnControl().equals(budgetVo.getYnControl())) {
                        budgetVo.setSeq( Integer.parseInt( commonCode.EMPTYSEQ ) );
                        isEditBudget = true;
                                        }
					if(!tBudget.getTpControl().equals(budgetVo.getTpControl())) {
                        budgetVo.setSeq( Integer.parseInt( commonCode.EMPTYSEQ ) );
                        isEditBudget = true;
                                        }
					if ( isEditBudget ) {
						budgetVo.setCompSeq( loginVo.getCompSeq( ) );
						budgetVo.setCreateSeq( loginVo.getUniqId( ) );
						budgetVo.setModifySeq( loginVo.getUniqId( ) );
						budgetVo.setBudgetType( conVo.getErpTypeCode( ) );
						budgetVo = codeService.ExExpendBudgetInfoInsert( budgetVo );
                        exCodeETaxVO.setExpendBudgetSeq(budgetVo.getSeq());
						budgetVo.setSeq( 0 );
					} else {
					    exCodeETaxVO.setExpendBudgetSeq( budgetVo.getSeq( ) );
					}
				}
				/* 적요처리 */
				exCodeETaxVO.setNote( (String) param.get( "note" ) );
				cmLog.CommonSetInfo( "! [EX] ExCodeETaxVO exCodeETaxVO >> " + exCodeETaxVO.toString( ) );
				/* 매입전자세금계산서 생성 또는 수정 */
				resultVo = this.ExExpendETaxSubInfoUpdate( exCodeETaxVO );
				if ( resultVo.getResultCode( ).equals( commonCode.FAIL ) ) {
                    throw new Exception(BizboxAMessage.getMessage("TX000009291", "매입전자세금계산서 갱신 실패"));
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
	@Override
    public List<Map<String, Object>> ExUserTtaxReportList ( ResultVO etaxResult, ConnectionVO conVo ) throws Exception {
		/* 매입 전자 세금계산서 조회 */
		ExCodeETaxVO etaxVo = new ExCodeETaxVO( );
		List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>( );
		List<ExCodeETaxVO> etaxAppListVo = new ArrayList<ExCodeETaxVO>( );
		ExCodeETaxVO subEtaxVo = new ExCodeETaxVO( );
		/* 현재 작성중인 세금계산서, 미사용 세금계산서 제외 */
		etaxVo.setSearchFromDt( etaxResult.getParams( ).get( "searchFromDt" ).toString( ) );
		etaxVo.setSearchToDt( etaxResult.getParams( ).get( "searchToDt" ).toString( ) );
		etaxVo.setEmpSeq( etaxResult.getParams( ).get("empSeq").toString( ) );
		etaxVo.setCompSeq( etaxResult.getParams( ).get("compSeq").toString( ) );
		etaxVo.setErpCompSeq( conVo.getErpCompSeq( ) );
		/*ERPiU 옵션에 따른 미사용처리된 매입전자세금계산서 변경 */
		subEtaxVo = daoU.ExTaxListCompOption( etaxVo, conVo );
		etaxVo.setTpTbTaxCompany(subEtaxVo.getTpTbTaxCompany());
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

		/* 검색조건 */
		etaxVo.setSearchIssNo( etaxResult.getParams( ).get( "issNo" ).toString( ) );
		etaxVo.setSearchPartnerNm( etaxResult.getParams( ).get( "partnerName" ).toString( ) );
		etaxVo.setSearchPartnerNo( etaxResult.getParams( ).get( "partnerNo" ).toString( ) );
		etaxVo.setEmailDc( etaxResult.getParams( ).get( "emailDc" ).toString( ) );
		etaxListVo = daoU.ExETaxListInfoSelectMap( etaxVo, conVo );
		return etaxListVo;
	}

	/* 매입전자세금계산서 - 세금계산서 상세 정보 조회 */
	@Override
    public Map<String, Object> ExExpendEtaxGWInfoSelect ( Map<String, Object> param ) {
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
