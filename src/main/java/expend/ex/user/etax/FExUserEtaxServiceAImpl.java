package expend.ex.user.etax;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import common.helper.convert.CommonConvert;
import common.helper.exception.BudgetAmtOverException;
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
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExpendVO;
import common.vo.interlock.InterlockExpendVO;
import expend.ex.budget.BExBudgetService;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.expend.BExUserService;
import expend.ex.user.list.BExUserListService;
import main.web.BizboxAMessage;


@Service ( "FExUserEtaxServiceAImpl" )
public class FExUserEtaxServiceAImpl implements FExUserEtaxService {

	/* 변수정의 - Helper */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 - 공통코드 - Service */
	@Resource ( name = "BExUserCodeService" ) /* 공통 조회 서비스 */
	private BExUserCodeService codeService;
	/* 변수정의 - 전표 - Service */
	@Resource ( name = "BExUserListService" ) /* 전표 서비스 */
	private BExUserListService listService;
	@Resource ( name = "BExUserService" )
	private BExUserService userService;
	@Resource ( name = "BExBudgetService" )
	private BExBudgetService budgetService;/* 예산 서비스 */
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserEtaxServiceADAO" )
	private FExUserEtaxServiceADAO daoA;
	@Resource ( name = "FExUserEtaxServiceIDAO" )
	private FExUserEtaxServiceIDAO daoI;
	@Resource ( name = "FExUserEtaxServiceUDAO" )
	private FExUserEtaxServiceUDAO daoU;

	/* 매입전자세금계산서 */
	/* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
	@Override
	public List<ExCodeETaxVO> ExETaxListInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		return null;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 조회 */
	@Override
	public ExCodeETaxVO ExETaxDetailInfoSelect ( ExCodeETaxVO etaxVo, ConnectionVO conVo ) throws Exception {
		return null;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 연동 코드 저장 */
	@Override
	public ResultVO ExExpendETaxInfoMapUpdate ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception {
		return null;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 지출결의 항목 분개 처리 */
	@Override
	public ExCommonResultVO ExETaxInfoMake ( Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			/* 반영 내역 정의 */
			List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>( );
			boolean isSlipMode = false;
			if ( param.get( "isSlipMode" ) != null ) {
				isSlipMode = Boolean.parseBoolean( param.get( "isSlipMode" ).toString( ) );
			}
			//			for ( Map<String, Object> map : (List<Map<String, Object>>) cmConvert.CommonGetJSONToListMap( (String) param.get( "key" ) ) ) {
			//				ExCodeETaxVO etaxVo = new ExCodeETaxVO( );
			//				etaxVo.setIssNo( (String) map.get( "item_0" ) ); /* 매입전자세금계산서 등록번호 */
			//				etaxVo.setIssDt( (String) map.get( "item_1" ) ); /* 매입전자세금계상서 작성일자 */
			//				etaxVo.setTrregNb( (String) map.get( "item_2" ) ); /* 매입전자세금계산서 공급자 사업자 등록번호 */
			//				etaxVo.setCompSeq( loginVo.getCompSeq( ) );
			//				etaxListVo.add( etaxVo );
			//			}
			ExCodeETaxVO tempETaxVo = new ExCodeETaxVO( );
			tempETaxVo.setIssNo( param.get( "item_0" ).toString( ) ); /* 매입전자세금계산서 등록번호 */
			tempETaxVo.setIssDt( param.get( "item_1" ).toString( ) ); /* 매입전자세금계상서 작성일자 */
			tempETaxVo.setTrregNb( param.get( "item_2" ).toString( ) ); /* 매입전자세금계산서 공급자 사업자 등록번호 */
			tempETaxVo.setCompSeq( loginVo.getCompSeq( ) );
			etaxListVo.add( tempETaxVo );
			for ( ExCodeETaxVO etaxVo : etaxListVo ) {
				/* etax param */
				ExCodeETaxVO etaxBizboxAVo = new ExCodeETaxVO( );
				ExCodeETaxVO etaxERPVo = new ExCodeETaxVO( );
				etaxBizboxAVo.setCompSeq( etaxVo.getCompSeq( ) );
				etaxBizboxAVo.setIssNo( etaxVo.getIssNo( ) );
				etaxBizboxAVo.setIssDt( etaxVo.getIssDt( ) );
				etaxBizboxAVo.setSearchFromDt( etaxVo.getIssDt( ) );
				etaxBizboxAVo.setSearchToDt( etaxVo.getIssDt( ) );
				etaxBizboxAVo.setTrregNb( etaxVo.getTrregNb( ) );
				etaxBizboxAVo = daoA.ExExpendETaxSubInfoSelect( etaxBizboxAVo );
				etaxBizboxAVo.setSearchFromDt( etaxVo.getIssDt( ) );
				etaxBizboxAVo.setSearchToDt( etaxVo.getIssDt( ) );
				etaxBizboxAVo.setTrregNb( etaxVo.getTrregNb( ) );
				etaxERPVo.setCompSeq( etaxVo.getCompSeq( ) );
				etaxERPVo.setErpCompSeq( loginVo.getErpCoCd( ) );
				etaxERPVo.setIssNo( etaxVo.getIssNo( ) );
				etaxERPVo.setSearchIssNo( etaxVo.getIssNo( ) );
				etaxERPVo.setIssDt( etaxVo.getIssDt( ) );
				etaxERPVo.setTrregNb( etaxVo.getTrregNb( ) );
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
					etaxERPVo = daoI.ExETaxDetailInfoSelect( etaxERPVo, conVo );
				}
				else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
					etaxERPVo = daoU.ExETaxDetailInfoSelect( etaxERPVo, conVo );
				}
				/* list param */
				Map<String, Object> listParam = new HashMap<String, Object>( );
				/* 데이터 생성 - 사용자 */
				ExCodeOrgVO empVo = new ExCodeOrgVO( ); /* 지출결의 사용자 */
//				if ( param.get( "emp" ) != null ) {
//					empVo = (ExCodeOrgVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "emp" ) ), empVo );
//				}
//				else {
//					empVo = null;
//				}
//				if ( empVo != null ) {
//					empVo.setCreateSeq( loginVo.getUniqId( ) );
//					empVo.setModifySeq( loginVo.getUniqId( ) );
//					empVo.setSeq( 0 );
//					listParam.put( "emp", empVo );
//				}
				empVo.setSeq( etaxBizboxAVo.getExpendEmpSeq( ) );
				empVo = codeService.ExExpendEmpInfoSelect( empVo );
				empVo.setCreateSeq( loginVo.getUniqId( ) );
				empVo.setModifySeq( loginVo.getUniqId( ) );

				/* 매입전자세금계산서 사업장 정보 조회 및 반영 처리 */
				if(conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
					// jira : UBA-16458
					// 상세기능 : 매입전자세금계산서 가져오기 시 관리항목 '귀속 사업장'에 작성자가 아닌 매입전자세금계산서의 '사업장'정보가 표시 되도록 개선
					// 세금계산서 기준 사업장 정보 조회 : etaxERPVo.getIssDt(), etaxERPVo.getIssNo(), etaxERPVo.getErpCompSeq()

					Map<String, Object> bizP = new HashMap<String, Object>();
					bizP.put("issDt", etaxERPVo.getIssDt());
					bizP.put("issNo", etaxERPVo.getIssNo());
					bizP.put("erpCompSeq", etaxERPVo.getErpCompSeq());
					bizP.put("userErpBizSeq", empVo.getErpBizSeq());

					bizP = daoU.ExETaxBizareaInfoSelectMap(bizP, conVo);

					if(bizP != null && !CommonConvert.CommonGetStr(bizP.get("erpBizareaSeq")).equals("")) {
						/* 조회된 정보가 존재하는 경우에만 처리, 정보가 없는데 공백을 지정하면 전표 연동 시 오류 발생 */
						empVo.setErpBizName(CommonConvert.CommonGetStr(bizP.get("erpBizareaName")));
						empVo.setErpBizSeq(CommonConvert.CommonGetStr(bizP.get("erpBizareaSeq")));
					}
					 
				}else if(conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
				  
				    Map<String, Object> etaxDiv = new HashMap<String,Object>();
				    etaxDiv.put("issDt", etaxERPVo.getIssDt());
				    etaxDiv.put("issNo", etaxERPVo.getIssNo());
				    etaxDiv.put("erpCompSeq", etaxERPVo.getErpCompSeq());
				    
				    etaxDiv = daoI.ExEtaxDivInfoSelect(etaxDiv,conVo);
				    
				    if(etaxDiv != null && !CommonConvert.CommonGetStr(etaxDiv.get("divCd")).equals("")) {
                      /* 조회된 정보가 존재하는 경우에만 처리, 정보가 없는데 공백을 지정하면 전표 연동 시 오류 발생 */
                      empVo.setErpBizName(CommonConvert.CommonGetStr(etaxDiv.get("divNm")));
                      empVo.setErpBizSeq(CommonConvert.CommonGetStr(etaxDiv.get("divCd")));
                  }  
				}

				empVo.setSeq( 0 );
				listParam.put( "emp", empVo );
				/* auth */
				ExCodeAuthVO authVo = new ExCodeAuthVO( );
				authVo.setSeq( etaxBizboxAVo.getExpendAuthSeq( ) );
				authVo = codeService.ExExpendAuthInfoSelect( authVo );
				if ( authVo == null ) {
					// 승인정보 데이터 조회 필요
					throw new Exception( "지출결의 정보 확인에 실패하였습니다." );
				}
				authVo.setEtaxSendYN( commonCode.EMPTYYES );
				authVo.setEtaxYN( commonCode.EMPTYYES );
				authVo.setSeq( 0 );
				listParam.put( "auth", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( authVo ) ) );
				/* summary */
				ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
				summaryVo.setSeq( etaxBizboxAVo.getExpendSummarySeq( ) );
				summaryVo = codeService.ExExpendSummaryInfoSelect( summaryVo );
				summaryVo.setSeq( 0 );
				listParam.put( "summary", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( summaryVo ) ) );
				/* partner - 신규생성 */
				ExCodePartnerVO partnerVo = new ExCodePartnerVO( );
				partnerVo.setErpCompSeq( loginVo.getErpCoCd( ) );
				partnerVo.setSearchStr( etaxBizboxAVo.getTrregNb( ).replaceAll( "-", commonCode.EMPTYSTR ) );
				//폼양식 정보
				Map<String, Object> formInfo = ConvertManager.ConvertJsonToMap(CommonConvert.CommonGetStr(param.get("formInfo")));
				partnerVo.setFormSeq( CommonConvert.CommonGetStr(formInfo.get("formSeq")) );// 폼 시퀀스
				if ( partnerVo.getPartnerName( ).equals( commonCode.EMPTYSTR ) ) {
					partnerVo.setPartnerName( etaxERPVo.getTrNm( ) );
				}
				if ( partnerVo.getCeoName( ).equals( commonCode.EMPTYSTR ) ) {
					partnerVo.setCeoName( etaxERPVo.getTrceoNm( ) );
				}
				/* 거래처 정보 조회 */
				partnerVo = codeService.ExCodePartnerInfoSelect( partnerVo, conVo );
				/* 거래처가 미존재 하는 경우는 거래처 명만 처리 */
				if ( partnerVo.getPartnerName( ).equals( commonCode.EMPTYSTR ) ) {
					//					partnerVo.setPartnerName( etaxBizboxAVo.getTrregNb( ) );
					partnerVo.setPartnerName( etaxERPVo.getTrNm( ) );
				}
				partnerVo.setSeq( 0 );
				listParam.put( "partner", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( partnerVo ) ) );
				/* project */
				ExCodeProjectVO projectVo = new ExCodeProjectVO( );
				projectVo.setSeq( etaxBizboxAVo.getExpendProjectSeq( ) );
				projectVo = codeService.ExExpendProjectInfoSelect( projectVo );
				if ( projectVo != null ) {
					projectVo.setSeq( 0 );
					listParam.put( "project", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( projectVo ) ) );
				}
				else {
					projectVo = new ExCodeProjectVO( );
					listParam.put( "project", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( projectVo ) ) );
				}
				/* card */
				ExCodeCardVO cardVo = new ExCodeCardVO( );
				cardVo.setSeq( etaxBizboxAVo.getExpendCardSeq( ) );
				cardVo.setCompSeq( loginVo.getCompSeq( ) );
				cardVo = codeService.ExExpendCardInfoSelect( cardVo );
				if ( cardVo != null && !cardVo.getCardNum( ).equals( commonCode.EMPTYSTR ) ) {
					cardVo.setCompSeq( loginVo.getCompSeq( ) );
					cardVo.setErpCompSeq( conVo.getErpCompSeq( ) );
					cardVo.setSearchCardNum( cardVo.getCardNum( ) );
					cardVo = codeService.ExCodeCardInfoSelect( cardVo, conVo );
					cardVo.setSeq( 0 );
					listParam.put( "card", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( cardVo ) ) );
				}
				else {
					cardVo = new ExCodeCardVO( );
					listParam.put( "card", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( cardVo ) ) );
				}
				/* budget */
				ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( );
				budgetVo.setSeq( etaxBizboxAVo.getExpendBudgetSeq( ) );
				budgetVo = codeService.ExExpendBudgetInfoSelect( budgetVo );
				budgetVo = (budgetVo == null ? new ExCodeBudgetVO() : budgetVo);
				budgetVo.setSeq( 0 );
				listParam.put( "budget", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( budgetVo ) ) );
				/* 예산 체크 진행 */
				boolean isUseBudget = false;
				if ( param.get( "isUseBudget" ) != null ) {
					isUseBudget = Boolean.parseBoolean( param.get( "isUseBudget" ).toString( ) );
				}
				if ( isUseBudget ) {
					Map<String, Object> budgetParam = new HashMap<String, Object>( );
					budgetParam.put( "budgetCode", budgetVo.getBudgetCode( ) );
					budgetParam.put( "budgetName", budgetVo.getBudgetName( ) );
					budgetParam.put( "bgacctCode", budgetVo.getBgacctCode( ) );
					budgetParam.put( "bgacctName", budgetVo.getBgacctName( ) );
					budgetParam.put( "acctCode", budgetVo.getBgacctCode( ) );
					if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
						if ( budgetVo.getBgacctCode( ).equals( commonCode.EMPTYSTR ) ) {
							budgetParam.put( "acctCode", summaryVo.getDrAcctCode( ) );
							budgetParam.put( "bgacctCode", summaryVo.getDrAcctCode( ) );
							budgetParam.put( "bgacctName", summaryVo.getDrAcctName( ) );
						}
					}
					budgetParam.put( "bizplanCode", budgetVo.getBizplanCode( ) );
					budgetParam.put( "bizplanName", budgetVo.getBizplanName( ) );
					budgetParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
					budgetParam.put( "amt", etaxERPVo.getSupAm( ) );
					budgetParam.put( "budgetYm", budgetVo.getBudgetYm( ) );
					budgetParam.put( "isApprovalEditMode", false );
					budgetParam.put( "expendSeq", param.get( "expendSeq" ).toString( ) );
					budgetParam.put( "drcrGbn", "dr" );
					budgetParam.put( "compSeq", loginVo.getCompSeq( ) );
					ExpendVO expendVo = new ExpendVO( );
					expendVo.setExpendSeq( (String) param.get( "expendSeq" ) );
					// 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
					expendVo = userService.ExUserExpendInfoSelect( expendVo );
					if ( !expendVo.getExpendStatCode( ).equals( commonCode.EMPTYSTR ) && !expendVo.getExpendStatCode( ).equals( "999" ) && !expendVo.getExpendStatCode( ).equals( "100" ) && !expendVo.getErpSendYN( ).equals( commonCode.EMPTYYES ) ) {
						budgetParam.put( "isApprovalEditMode", true );
						budgetParam.put("erpiuBudgetVer", expendVo.getErpiuBudgetVer());
					} else {
					    budgetParam.put("erpiuBudgetVer", expendVo.getErpiuBudgetVer());
					}

					if(expendVo.getErpiuBudgetVer() == null || expendVo.getErpiuBudgetVer().equals("")) {
					    budgetService.ExInterfaceBudgetInfoCheck( budgetParam, conVo );
					}
					/* 2020.05.08 이준성 ERPiU 예산정보 필수입력 설정에 대한 사용/미사용 여부 체크 */
					else if (((param.get("budgetUseYn").equals("0")|| param.get("budgetUseYn").equals("2") || param.get("budgetUseYn").equals("4") ) &&  ( budgetVo.getCdBgLevel() == null || budgetVo.getCdBgLevel().equals("") )) && (budgetVo.getBudgetCode() == null || budgetVo.getBudgetCode().equals(""))) {
                      budgetService.ExInterfaceBudgetInfoCheck(budgetParam, conVo);
                    }
					else {
					    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
					    // ERPiU 상위과목 예산통제 기능
                        budgetParam.put("cdBgLevel", budgetVo.getCdBgLevel());
                        budgetParam.put("ynControl", budgetVo.getYnControl());
                        budgetParam.put("tpControl", budgetVo.getTpControl());
					    budgetService.ExInterfaceBudgetInfoCheck2( budgetParam, conVo );
					}

				}
				/* list */
				ExExpendListVO listVo = new ExExpendListVO( ); /* 지출결의 항목 */
				listVo.setExpendSeq( (String) param.get( "expendSeq" ) );
				listVo.setAuthDate( etaxBizboxAVo.getIssDt( ) );
				listVo.setNote( etaxBizboxAVo.getNote( ) );
				listVo.setAmt( etaxERPVo.getSumAm( ) );
				/* list - 금액 재계산 처리 */
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
					/* 공급대가 : getSum_am(); */ /* 부가세 : getVat_am(); */ /* 공급가액 : getSup_am(); */
					switch ( authVo.getVatTypeCode( ) ) {
						/* 부가세는 없고, 세액만 있는 프로세스 */
						case "24":
							/* 부가세가 존재한다면 ? */
							if ( Double.parseDouble( etaxERPVo.getVatAm( ) ) != 0 ) {
								/* 부가세 > 0 / 세액 > 부가세 */
								listVo.setTaxAmt( commonCode.EMPTYSEQ );
								listVo.setSubTaxAmt( etaxERPVo.getVatAm( ) );
								/* 공급가액 > 공급대가 / 과세표준액 > 공급대가 - 세액 */
								listVo.setStdAmt( etaxERPVo.getSumAm( ) );
								listVo.setSubStdAmt( etaxERPVo.getSupAm( ) );
							}
							/* 부가세가 존재하지 않는다면 ? */
							else {
								double reqAmt, subTaxAmt, subStdAmt;
								reqAmt = Double.parseDouble( etaxERPVo.getSumAm( ) );
								/* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
								/* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
								if (reqAmt >= 0) {
									subTaxAmt = Math.floor( reqAmt / 11 );
								} else {
									// 금액이 마이너스일 경우 올림
									subTaxAmt = Math.ceil( reqAmt / 11 );
								}
								listVo.setTaxAmt( commonCode.EMPTYSEQ );
								listVo.setSubTaxAmt( String.valueOf( subTaxAmt ) );
								subStdAmt = reqAmt - subTaxAmt;
								listVo.setStdAmt( String.valueOf( reqAmt ) );
								listVo.setSubStdAmt( String.valueOf( subStdAmt ) );
							}
							break;
						/* 부가세도 없고, 세액도 없는 프로세스 */
						case "22":
						case "23":
							listVo.setTaxAmt( commonCode.EMPTYSEQ );
							listVo.setSubTaxAmt( commonCode.EMPTYSEQ );
							listVo.setStdAmt( etaxERPVo.getSumAm( ) );
							listVo.setSubStdAmt( etaxERPVo.getSumAm( ) );
							break;
						default:
							listVo.setTaxAmt( etaxERPVo.getVatAm( ) );
							listVo.setSubTaxAmt( etaxERPVo.getVatAm( ) );
							listVo.setStdAmt( etaxERPVo.getSupAm( ) );
							listVo.setSubStdAmt( etaxERPVo.getSupAm( ) );
							break;
					}
				}
				else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
					/* 공급대가 : getSum_am(); */ /* 부가세 : getVat_am(); */ /* 공급가액 : getSup_am(); */
					switch ( authVo.getVatTypeCode( ) ) {
						/* 부가세는 없고, 세액만 있는 프로세스 */
						case "22":
						case "50":
							/* 부가세가 존재한다면 ? */
							if ( Double.parseDouble( etaxERPVo.getVatAm() ) != 0 ) {
								/* 부가세 > 0 / 세액 > 부가세 */
								listVo.setTaxAmt( commonCode.EMPTYSEQ );
								listVo.setSubTaxAmt( etaxERPVo.getVatAm( ) );
								/* 공급가액 > 공급대가 / 과세표준액 > 공급대가 - 세액 */
								listVo.setStdAmt( etaxERPVo.getSumAm( ) );
								listVo.setSubStdAmt( etaxERPVo.getSupAm( ) );
							}
							/* 부가세가 존재하지 않는다면 ? */
							else {
								double reqAmt, subTaxAmt, subStdAmt;
								reqAmt = Double.parseDouble( etaxERPVo.getSumAm( ) );
								/* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
								/* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
								if (reqAmt >= 0) {
									subTaxAmt = Math.floor( reqAmt / 11 );
								} else {
									// 금액이 마이너스일 경우 올림
									subTaxAmt = Math.ceil( reqAmt / 11 );
								}
								listVo.setTaxAmt( commonCode.EMPTYSEQ );
								listVo.setSubTaxAmt( String.valueOf( subTaxAmt ) );
								subStdAmt = reqAmt - subTaxAmt;
								listVo.setStdAmt( String.valueOf( reqAmt ) );
								listVo.setSubStdAmt( String.valueOf( subStdAmt ) );
							}
							break;
						/* 부가세도 없고, 세액도 없는 프로세스 */
						case "23":
						case "25":
						case "26":
						case "37":
						case "39":
						case "60":
						case "99":
							listVo.setTaxAmt( commonCode.EMPTYSEQ );
							listVo.setSubTaxAmt( commonCode.EMPTYSEQ );
							listVo.setStdAmt( etaxERPVo.getSumAm( ) );
							listVo.setSubStdAmt( etaxERPVo.getSumAm( ) );
							break;
						default:
							listVo.setTaxAmt( etaxERPVo.getVatAm( ) );
							listVo.setSubTaxAmt( etaxERPVo.getVatAm( ) );
							listVo.setStdAmt( etaxERPVo.getSupAm( ) );
							listVo.setSubStdAmt( etaxERPVo.getSupAm( ) );
							break;
					}
				}
				listVo.setInterfaceType( "etax" );
				listVo.setInterfaceMId( String.valueOf( etaxBizboxAVo.getSyncId( ) ) );
				listParam.put( "list", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( listVo ) ) );

				/* 외화정보 담기 - 매입세금계산서에는 외화계정이 없어서 파라미터만 넘김 */
				ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();
				listParam.put( "foreignCurrency", CommonConvert.CommonGetMapToJSONStr( CommonConvert.CommonGetObjectToMap( foreignCurrencyVO ) ) );

				/* 매입전자세금계산서 분개 처리 진행 */
				resultVo = listService.ExListInfoMake( loginVo, listParam, conVo );
				if ( resultVo.getCode( ).equals( commonCode.FAIL ) ) {
					throw new Exception( BizboxAMessage.getMessage( "TX000009290", "분개생성에 실패하였습니다" ) );
				}
				else {
					/* 결재 중 수정 여부 확인 */
					ExpendVO expendVo = new ExpendVO( );
					expendVo.setExpendSeq( listVo.getExpendSeq( ) );
					expendVo = userService.ExUserExpendInfoSelect( expendVo );
					if ( !expendVo.getExpendStatCode( ).equals( commonCode.EMPTYSTR ) && !expendVo.getExpendStatCode( ).equals( "999" ) && !expendVo.getExpendStatCode( ).equals( "100" ) && !expendVo.getErpSendYN( ).equals( commonCode.EMPTYYES ) ) {
						/*
						 * 결재 중 수정 로직 진행
						 * 1. 생성 된 카드 정보 전송여부 Y로 업데이트
						 * 2. ERPiU인 경우 생성된 항목의 차변 분개에 row_id 생성
						 */
						Map<String, Object> syncUpdate = new HashMap<String, Object>( );
						syncUpdate.put( "interfaceMId", listVo.getInterfaceMId( ) );
						syncUpdate.put( "sendYN", commonCode.EMPTYYES );
						syncUpdate.put( "expendSeq", listVo.getExpendSeq( ) );
						syncUpdate.put( "listSeq", resultVo.getListSeq( ) );
						daoA.ExUserETaxStateInfoUpdate( syncUpdate );
						if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
							//ERPiU 예산넣기(임시데이터 생성)
							Map<String, Object> budgetParam = new HashMap<String, Object>( );
							budgetParam.put( "docSeq", expendVo.getDocSeq( ) );
							budgetParam.put( "expendSeq", expendVo.getExpendSeq( ) );
							budgetParam.put( "newListSeq", resultVo.getListSeq( ) );
							budgetService.ExInterLockERPiURowInsert( budgetParam );
						}
					}
					if ( isSlipMode ) {
						/*
						 * 분개단위 입력 시 항목에 금액 수정 진행
						 * 기존 항목의 금액 + 신규 추가되는 금액으로 변경
						 */
						Map<String, Object> amtMap = new HashMap<String, Object>( );
						Map<String, Object> listAmtMap = new HashMap<String, Object>( );
						ExExpendListVO tListVo = new ExExpendListVO( );
						tListVo.setExpendSeq( listVo.getExpendSeq( ) );
						tListVo.setListSeq( "1" );
						listAmtMap = listService.ExListAmtSelect( tListVo );
						/* 기초값 설정 : 기존 항목의 금액으로 설정한다 */
						BigDecimal amt = new BigDecimal( listAmtMap.get( "amt" ).toString( ) );
						BigDecimal stdAmt = new BigDecimal( listAmtMap.get( "stdAmt" ).toString( ) );
						BigDecimal taxAmt = new BigDecimal( listAmtMap.get( "taxAmt" ).toString( ) );
						BigDecimal subStdAmt = new BigDecimal( listAmtMap.get( "subStdAmt" ).toString( ) );
						BigDecimal subTaxAmt = new BigDecimal( listAmtMap.get( "subTaxAmt" ).toString( ) );
						/* 추가된 항목의 금액을 더한다. */
						amtMap.put( "amt", amt.add( new BigDecimal( listVo.getAmt( ) ) ) );
						amtMap.put( "stdAmt", stdAmt.add( new BigDecimal( listVo.getStdAmt( ) ) ) );
						amtMap.put( "taxAmt", taxAmt.add( new BigDecimal( listVo.getTaxAmt( ) ) ) );
						amtMap.put( "subStdAmt", subStdAmt.add( new BigDecimal( listVo.getSubStdAmt( ) ) ) );
						amtMap.put( "subTaxAmt", subTaxAmt.add( new BigDecimal( listVo.getSubTaxAmt( ) ) ) );
						amtMap.put( "expendSeq", listVo.getExpendSeq( ) );
						amtMap.put( "listSeq", "1" );
						listService.ExListAmtEdit( amtMap );
					}
				}
			}
		}
		catch ( BudgetAmtOverException e ) {
			throw e;
		}
		catch ( Exception e ) {
			throw e;
		}
		return resultVo;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 상태값 수정 */
	@Override
	public ResultVO ExExpendETaxInfoUpdate ( ExCodeETaxVO etaxVo ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			resultVo = daoA.ExExpendETaxInfoUpdate( etaxVo );
		}
		catch ( Exception e ) {
			throw e;
		}
		return resultVo;
	}

	/* 매입전자세금계산서 - 매입전자세금계산서 사용내역 목록 상태값 수정 */
	/* ################################################## */
	/* 전자결재 연동 - 매입전자세금계산서 상태값 동기화 */
	/* 주의사항 : LoginVO 사용 불가 */
	/* ################################################## */
	@Override
    public InterlockExpendVO ExUserETaxStateListInfoUpdate ( Map<String, Object> params ) throws Exception {
		/* parameters : expendSeq, sendYN */
		InterlockExpendVO result = new InterlockExpendVO( );
		boolean isApprovalEnd = false;
		if ( params.get( "isApprovalEnd" ) != null ) {
			isApprovalEnd = Boolean.parseBoolean( params.get( "isApprovalEnd" ).toString( ) );
		}
		/* ERP 연결정보 조회 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ), CommonConvert.CommonGetStr( daoA.ExExpendCompSeqSelect( params ) ) );
		try {
			/* 상태값 동기화 대상 조회 */
			List<Map<String, Object>> etaxList = new ArrayList<Map<String, Object>>( );
			etaxList = daoA.ExUserETaxStateSyncListInfoSelect( params );
			for ( Map<String, Object> map : etaxList ) {
				String expendSeq = map.get( commonCode.EXPENDSEQ ).toString( );
				String interfaceMId = map.get( "interfaceMId" ).toString( );
				map.put(commonCode.GROUPSEQ, CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ));
				map.put( "sendYN", CommonConvert.CommonGetStr( params.get( "sendYN" ) ) );
				/* ERP 회사 사업장 정보 조회 */
				ResultVO tParam = new ResultVO( );
				tParam.setGroupSeq(CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ));
				tParam.setParams( params );
				tParam = codeService.ExCodeERPInfoSelect( tParam );
				if ( isApprovalEnd ) {
					/* 종결 */
					if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
						ResultVO resultVo = new ResultVO( );
						Map<String, Object> erpMap = new HashMap<String, Object>( );
                        erpMap.put(commonCode.GROUPSEQ, params.get(commonCode.GROUPSEQ));
						erpMap.put( "expendSeq", expendSeq );
						erpMap.put( "interfaceMId", interfaceMId );
						resultVo.setGroupSeq(CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ));
						resultVo.setParams( erpMap );
						resultVo = daoA.ExuserETaxISSNoInfoSelect( resultVo );
						erpMap.put( "getFg", "1" );
						erpMap.put( "approState", "1" );
						erpMap.put( "erpCompSeq", tParam.getaData( ).get( "erpCompSeq" ).toString( ) );
						erpMap.put( "erpBizSeq", tParam.getaData( ).get( "erpBizSeq" ).toString( ) );
						erpMap.put( "docNo", tParam.getaData( ).get( "docNo" ).toString( ) );
						/* 추후 보완 예정 */
						erpMap.put( "issNo", resultVo.getAaData( ).get( 0 ).get( "issNo" ).toString( ) );
						resultVo.setParams( erpMap );
						daoI.ExETaxInfoUpdate( resultVo, conVo );
					}
					else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
						// do nothing
					}
				}
				else if ( CommonConvert.CommonGetStr( params.get( "sendYN" ) ).equals( commonCode.EMPTYNO ) ) {
					/* 반려 / 삭제 */
					map.put( commonCode.EXPENDSEQ, commonCode.EMPTYSEQ );
					map.put( commonCode.LISTSEQ, commonCode.EMPTYSEQ );
					map.put( "sendYN", commonCode.EMPTYNO );
					if ( (daoA.ExUserETaxStateInfoUpdate( map )) == 0 ) {
						result.setResultCode( commonCode.FAIL );
						result.setResultMessage( "매입전자세금계산서 상태 값 동기화[" + CommonConvert.CommonGetStr( params.get( "sendYN" ) ) + "] 진행 중 동기화 누락 건이 발생되었습니다." );
						throw new Exception( commonCode.EMPTYSTR );
					}
					else { /* ERP 매입전자세금계산서 정보 업데이트 */
						if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
							ResultVO resultVo = new ResultVO( );
							Map<String, Object> erpMap = new HashMap<String, Object>( );
                            erpMap.put(commonCode.GROUPSEQ, params.get(commonCode.GROUPSEQ));
							erpMap.put( "expendSeq", expendSeq );
							erpMap.put( "interfaceMId", interfaceMId );
							resultVo.setGroupSeq(CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ));
							resultVo.setParams( erpMap );
							resultVo = daoA.ExuserETaxISSNoInfoSelect( resultVo );
							erpMap.put( "getFg", "0" );
							erpMap.put( "approState", "4" );
							erpMap.put( "issNo", resultVo.getAaData( ).get( 0 ).get( "issNo" ).toString( ) );
							erpMap.put( "erpCompSeq", tParam.getaData( ).get( "erpCompSeq" ).toString( ) );
							erpMap.put( "erpBizSeq", tParam.getaData( ).get( "erpBizSeq" ).toString( ) );
							erpMap.put( "groupSeq", CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ) );
							resultVo.setParams( erpMap );
							daoI.ExETaxInfoUpdate( resultVo, conVo );
						}
						else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
							// do nothing
						}
					}
				}
				else if ( CommonConvert.CommonGetStr( params.get( "sendYN" ) ).equals( commonCode.EMPTYYES ) ) {
					/* 보관 / 상신 */
					map.put( "sendYN", commonCode.EMPTYYES );
					if ( (daoA.ExUserETaxStateInfoUpdate( map )) == 0 ) {
						result.setResultCode( commonCode.FAIL );
						result.setResultMessage( "매입전자세금계산서 상태 값 동기화[" + CommonConvert.CommonGetStr( params.get( "sendYN" ) ) + "] 진행 중 동기화 누락 건이 발생되었습니다." );
						throw new Exception( commonCode.EMPTYSTR );
					}
					else { /* ERP 매입전자세금계산서 정보 업데이트 */
						if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
							ResultVO resultVo = new ResultVO( );
							Map<String, Object> erpMap = new HashMap<String, Object>( );
                            erpMap.put(commonCode.GROUPSEQ, params.get(commonCode.GROUPSEQ));
							erpMap.put( "expendSeq", expendSeq );
							erpMap.put( "interfaceMId", interfaceMId );
							resultVo.setGroupSeq(CommonConvert.CommonGetStr( params.get( commonCode.GROUPSEQ ) ));
							resultVo.setParams( erpMap );
							resultVo = daoA.ExuserETaxISSNoInfoSelect( resultVo );
							erpMap.put( "getFg", "1" );
							erpMap.put( "approState", "0" );
							/* 추후 보완 예정 */
							//							erpMap.put( "docNo", resultVo.getAaData( ).get( 0 ).get( "docNo" ).toString( ) );
							erpMap.put( "docNo", commonCode.EMPTYSTR );
							erpMap.put( "issNo", resultVo.getAaData( ).get( 0 ).get( "issNo" ).toString( ) );
							erpMap.put( "erpCompSeq", tParam.getaData( ).get( "erpCompSeq" ).toString( ) );
							erpMap.put( "erpBizSeq", tParam.getaData( ).get( "erpBizSeq" ).toString( ) );
							resultVo.setParams( erpMap );
							daoI.ExETaxInfoUpdate( resultVo, conVo );
						}
						else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
							// do nothing
						}
					}
				}
			}
			result.setResultCode( commonCode.SUCCESS );
			result.setResultMessage( "정상 처리되었습니다." );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* 매입전자세금계산서 - 세금계산서 현황 리스트 조회 */
	@Override
    public List<Map<String, Object>> ExUserTtaxReportList ( ResultVO param, ConnectionVO conVo ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		return result;
	}

	/* 매입전자세금계산서 - 세금계산서 상세 정보 조회 */
	@Override
    public Map<String, Object> ExExpendEtaxGWInfoSelect ( Map<String, Object> param ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = daoA.ExExpendEtaxGWInfoSelect( param );
		return result;
	}

	/* 매입전자세금계산서 - 지출결의 정보 조회 */
	@Override
    public List<Map<String, Object>> ExUserETaxExpendInfoSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = daoA.ExUserETaxExpendInfoSelect( param );
		return result;
	}
}
