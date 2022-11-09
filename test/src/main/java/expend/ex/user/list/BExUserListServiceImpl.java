package expend.ex.user.list;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import cmm.util.CommonUtil;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExAttachVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExExpendSlipVO;
import common.vo.ex.ExExpendVO;
import common.vo.ex.ExpendVO;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.budget.BExBudgetService;
import expend.ex.user.card.BExUserCardService;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.etax.BExUserEtaxService;
import expend.ex.user.expend.BExUserService;
import expend.ex.user.expend.FExUserServiceADAO;
import expend.ex.user.slip.BExUserSlipService;
import expend.ex.user.slip.FExUserSlipServiceADAO;
import main.web.BizboxAMessage;


@Service ( "BExUserListService" )
public class BExUserListServiceImpl implements BExUserListService {

	/* 변수정의 */
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 - Service */
	@Resource ( name = "BExUserService" )
	private BExUserService masterService; /* Master */
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService codeService;/* Code */
	@Resource ( name = "BExUserSlipService" )
	private BExUserSlipService slipService; /* Master */
	@Resource ( name = "BExBudgetService" )
	private BExBudgetService budgetService;/* 예산 서비스 */
	@Resource ( name = "BExAdminConfigService" ) /* 환경설정 서비스 */
	private BExAdminConfigService configService;
	@Resource ( name = "BExUserCardService" ) /* 카드 서비스 */
	private BExUserCardService cardService;
	@Resource ( name = "BExUserEtaxService" ) /* 세금계산서 서비스 */
	private BExUserEtaxService etaxService;
	@Resource ( name = "FExUserListServiceA" )
	private FExUserListService userListServiceA; /* Bizbox Alpha */
	@Resource ( name = "FExUserListServiceI" )
	private FExUserListService userListServiceI; /* Bizbox Alpha */
	@Resource ( name = "FExUserListServiceU" )
	private FExUserListService userListServiceU; /* Bizbox Alpha */
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserServiceADAO" )
	private FExUserServiceADAO daoA; /* Bizbox Alpha */
	@Resource ( name = "FExUserListServiceADAO" )
	private FExUserListServiceADAO listDAOA; /* Bizbox Alpha */
	@Resource ( name = "FExUserSlipServiceADAO" )
	private FExUserSlipServiceADAO exUserSlipServiceADAO;
	@Resource ( name = "FExUserListServiceUDAO" )
	private FExUserListServiceUDAO userListServiceUDAO;
	@Resource ( name = "FExUserListServiceIDAO" )
	private FExUserListServiceIDAO userListServiceIDAO;

	/* Pop */
	/* Pop - ExExpendListPop 반환값 처리 */
	@Override
    public Map<String, Object> ExUserListPopReturn ( Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			/* 파리미터 처리 */
			result = CommonConvert.CommonSetMapCopy( params, result );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* 지출결의 - 지출결의 항목 조회 */
	@Override
	public ExExpendListVO ExUserListInfoSelect ( ExExpendListVO listVo ) throws Exception {
		try {
			listVo = daoA.ExUserListInfoSelect( listVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return listVo;
	}

	/* 지출결의 - 지출결의 항목 그리드 목록 조회 */
	@Override
	public List<Map<String, Object>> ExListGridInfoSelect ( ExExpendListVO listVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListGridInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendListVO listVo >> " + listVo.toString( ) );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = listDAOA.ExListGridInfoSelect( listVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<Map<String, Object>> result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListGridInfoSelect" );
		return result;
	}

	/* 지출결의 - 지출결의 항목 처리 */
	@Override
	public ExCommonResultVO ExListInfoMake ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> param >> " + param.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			/* 변수정의 */
			ExExpendListVO listVo = new ExExpendListVO( ); /* 지출결의 항목 */
			ExpendVO expendVo = new ExpendVO( ); /* 지출결의 */
			ExCodeOrgVO empVo = new ExCodeOrgVO( ); /* 지출결의 사용자 */
			ExCodeAuthVO authVo = new ExCodeAuthVO( ); /* 지출결의 증빙유형 */
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( ); /* 지출결의 표준적요 */
			ExCodePartnerVO partnerVo = new ExCodePartnerVO( ); /* 지출결의 거래처 */
			ExCodeProjectVO projectVo = new ExCodeProjectVO( ); /* 지출결의 프로젝트 */
			ExCodeCardVO cardVo = new ExCodeCardVO( ); /* 지출결의 카드 */
			ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( ); /* 예산 */
			ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO(); /* 외화정보 */
			//			ExAttachVO attachVo = new ExAttachVO( ); /* 첨부파일 */
			List<Map<String, Object>> attachVo = new ArrayList<Map<String, Object>>( ); /* 첨부파일 */
			List<Map<String, Object>> delAttachListMap = new ArrayList<Map<String, Object>>( );/* 첨부삭제 파일 */
			Map<String, Object> listInfo = new HashMap<String, Object>( );
			/* 초기값 정의 */
			/* 초기값 정의 - 지출결의 항목 */
			listVo = (ExExpendListVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "list" ) ), listVo );
			listVo.setExtendStr1(CommonConvert.CommonGetStr(param.get("extendStr1")));
			listVo.setExtendStr2(CommonConvert.CommonGetStr(param.get("extendStr2")));
			/* 초기값 정의 - 지출결의 */
			expendVo.setExpendSeq( listVo.getExpendSeq( ) );
			expendVo = masterService.ExUserExpendInfoSelect( expendVo );
			if ( listVo.getModifySeq( ).equals( commonCode.EMPTYSTR ) ) {
				listVo.setModifySeq( commonCode.EMPTYSEQ );
			}
			/* 초기값 정의 - 사용자 */
			if ( param.get( "emp" ) != null && (listVo.getInterfaceType( ).equals( commonCode.EMPTYSTR ) || (listVo.getInterfaceType( ).equals( "card" ) && !listVo.getModifySeq( ).equals( commonCode.EMPTYSEQ )) || (listVo.getInterfaceType( ).equals( "etax" ) && !listVo.getModifySeq( ).equals( commonCode.EMPTYSEQ ))) ) {
				empVo = (ExCodeOrgVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( CommonConvert.CommonGetStr(param.get( "emp" )) ), empVo );
			}
			else if ( param.get( "emp" ) != null ) {
				if(param.get("emp") instanceof String) {
					empVo = (ExCodeOrgVO)ConvertManager.ConvertMapToObject(ConvertManager.ConvertJsonToMap(param.get("emp").toString()), empVo);
				}
				else {
					empVo = (ExCodeOrgVO)param.get("emp");
				}
			}
			/* 초기값 정의 - 증빙유형 */
			authVo = (ExCodeAuthVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "auth" ) ), authVo );
			/* 초기값 정의 - 표준적요 */
			summaryVo = (ExCodeSummaryVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "summary" ) ), summaryVo );
			/* 초기값 정의 - 거래처 */
			partnerVo = (ExCodePartnerVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "partner" ) ), partnerVo );
			/* 초기값 정의 - 프로젝트 */
			projectVo = (ExCodeProjectVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "project" ) ), projectVo );
			/* 초기값 정의 - 카드 */
			cardVo = (ExCodeCardVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "card" ) ), cardVo );
			/* 초기값 정의 - 예산 */
			budgetVo = (ExCodeBudgetVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "budget" ) ), budgetVo );
			/* 초기값 정의 - 외화정보 */
			foreignCurrencyVO = (ExExpendForeignCurrencyVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "foreignCurrency" ) ), foreignCurrencyVO );
			/* 초기값 정의 - 첨부 */
			//			attachVo = (ExAttachVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (param.get( "attach" ) == null ? "{}" : param.get( "attach" ).toString( )) ), attachVo );
			String tmpAttach = (param.get( "attach" ) == null ? "[]" : param.get( "attach" ).toString( ));
			if( !tmpAttach.equals( "[]" ) ){
				attachVo = CommonConvert.CommonGetJSONToListMap( tmpAttach );
			}

			/* 초기값 정의 - 첨부삭제 리스트 */
			if ( param.get( "delAttachList" ) != null ) {
				String deleteAttachList = param.get( "delAttachList" ).toString( );
				delAttachListMap = ConvertManager.ConvertJsonToListMap( deleteAttachList );
			}
			/* 데이터 생성 */
			listVo.setWriteSeq( expendVo.getWriteSeq( ) );
			//사용자는 항목 별로 다를 수 있으므로 별도로 입력받아 수정한다.
			listVo.setEmpSeq( expendVo.getEmpSeq( ) );
			listVo.setBudgetSeq( expendVo.getBudgetSeq( ) );
			listVo.setProjectSeq( expendVo.getProjectSeq( ) );
			listVo.setPartnerSeq( expendVo.getPartnerSeq( ) );
			listVo.setCardSeq( expendVo.getCardSeq( ) );
			listVo.setBudgetSeq( expendVo.getBudgetSeq( ) );
			listVo.setCreateSeq( loginVo.getUniqId( ) );
			listVo.setModifySeq( loginVo.getUniqId( ) );
			/* 데이터 생성 - 사용자 */
			if ( empVo != null ) {
				empVo.setCreateSeq( loginVo.getUniqId( ) );
				empVo.setModifySeq( loginVo.getUniqId( ) );
				empVo = codeService.ExExpendEmpInfoInsert( empVo );
				// listVo.setEmpSeq( empVo.getSeq( ) == 0 ? listVo.getEmpSeq( ) : empVo.getSeq( ) );
				listVo.setEmpSeq( (empVo == null || empVo.getSeq( ) == 0) ? listVo.getEmpSeq( ) : empVo.getSeq( ) );
			}
			/* 데이터 생성 - 증빙유형 */
			authVo.setCreateSeq( loginVo.getUniqId( ) );
			authVo.setModifySeq( loginVo.getUniqId( ) );
			authVo = codeService.ExExpendAuthInfoInsert( authVo );
			listVo.setAuthSeq( authVo.getSeq( ) == 0 ? listVo.getAuthSeq( ) : authVo.getSeq( ) );
			/* 데이터 생성 - 표준적요 */
			summaryVo.setCreateSeq( loginVo.getUniqId( ) );
			summaryVo.setModifySeq( loginVo.getUniqId( ) );
			summaryVo = codeService.ExExpendSummaryInfoInsert( summaryVo );
			listVo.setSummarySeq( summaryVo.getSeq( ) == 0 ? listVo.getSummarySeq( ) : summaryVo.getSeq( ) );
			/* 데이터 생성 - 거래처 */
			partnerVo.setCreateSeq( loginVo.getUniqId( ) );
			partnerVo.setModifySeq( loginVo.getUniqId( ) );
			partnerVo = codeService.ExExpendPartnerInfoInsert( partnerVo );
			listVo.setPartnerSeq( partnerVo.getSeq( ) == 0 ? listVo.getPartnerSeq( ) : partnerVo.getSeq( ) );
			/* 데이터 생성 - 프로젝트 */
			projectVo.setCreateSeq( loginVo.getUniqId( ) );
			projectVo.setModifySeq( loginVo.getUniqId( ) );
			projectVo = codeService.ExExpendProjectInfoInsert( projectVo );
			listVo.setProjectSeq( projectVo.getSeq( ) == 0 ? listVo.getProjectSeq( ) : projectVo.getSeq( ) );
			/* 데이터 생성 - 카드 */
			cardVo.setCreateSeq( loginVo.getUniqId( ) );
			cardVo.setModifySeq( loginVo.getUniqId( ) );
			cardVo = codeService.ExExpendCardInfoInsert( cardVo );
			listVo.setCardSeq( cardVo.getSeq( ) == 0 ? listVo.getCardSeq( ) : cardVo.getSeq( ) );
			/* 데이터 생성 - 예산 */
			budgetVo.setCreateSeq( loginVo.getUniqId( ) );
			budgetVo.setModifySeq( loginVo.getUniqId( ) );
			// list에는 budget정보 안들어가므로 무조건 0으로 처리한다(2017-01-10/신재호)
			listVo.setBudgetSeq( 0 );
			/* 데이터 생성 - 외화정보 */
			listVo.setExchangeUnitCode(foreignCurrencyVO.getExchangeUnitCode()); // 환종코드
			listVo.setExchangeUnitName(foreignCurrencyVO.getExchangeUnitName()); // 환종명
			listVo.setExchangeRate(foreignCurrencyVO.getExchangeRate()); // 환율
			listVo.setForeignCurrencyAmount(foreignCurrencyVO.getForeignCurrencyAmount()); // 외화금액
			listVo.setForeignAcctYN(foreignCurrencyVO.getForeignAcctYN()); // 외화계정 여부(Y/N)

			/* 데이터 생성 - 지출결의 항목 */
			Map<String, Object> optionParam = new HashMap<String, Object>( );
			optionParam.put( "optionCode", "001001" );
			optionParam.put( "compSeq", expendVo.getCompSeq( ) );
			optionParam.put( "formSeq", expendVo.getFormSeq( ) );
			optionParam.put( "useSw", conVo.getErpTypeCode( ) );
			ResultVO expendOption = configService.ExAdminConfigOptionSelect( optionParam );
			boolean isSlipInsertMode = true;
			if ( expendOption != null && expendOption.getAaData( ).size( ) > 0 ) {
				if ( expendOption.getAaData( ).get( 0 ).get( "set_value" ).toString( ).indexOf( "L" ) == -1 ) {
					listVo.setListSeq( "1" );
					isSlipInsertMode = false;
				}
			}
			if ( isSlipInsertMode ) {
				//항목정보 정렬순서 채번
				int orderSeq = userListServiceA.ExGetOrderSeqFromListInfo(listVo);
				listVo.setOrderSeq(orderSeq);

				listVo = this.ExListInfoInsert( listVo );
			}
			/* 첨부파일 넣기 */
			//			attachVo.setExpend_seq( listVo.getExpendSeq( ) );
			//			attachVo.setList_seq( listVo.getListSeq( ) );
			//			String file_exist_count = commonCode.EMPTYSEQ;
			//			file_exist_count = listDAOA.ExListExistAttachInfoSelect( attachVo );
			//			if ( attachVo.getType( ).equals( "list" ) && file_exist_count.equals( commonCode.EMPTYSEQ ) ) {
			//				listDAOA.ExListAttachInfoInsert( attachVo );
			//			}
			//			/* list 첨부파일 초기화 */
			//			attachVo.InitValue( );
			boolean isDeleted = false;
			for ( Map<String, Object> tAttach : attachVo ) {
				/* 기존의 첨부파일 정보 삭제처리 진행 */
				boolean isNewAttach = true;
				tAttach.put( commonCode.EXPENDSEQ, listVo.getExpendSeq( ) );
				if ( tAttach.get( "list_seq" ) != null ) {
					tAttach.put( commonCode.LISTSEQ, tAttach.get( "list_seq" ).toString( ) );
					isNewAttach = false;
				}
				/* 기존 첨부파일 삭제는 최초 한번만 진행하며, 기존 첨부파일이 있어야만 삭제가 가능하다. */
				if ( !isNewAttach && !isDeleted ) {
					if ( !listDAOA.ExExpendListAttachListInfoDelete( tAttach ) ) {
						continue;
					}
					else {
						isDeleted = true;
					}
				}
				/* 첨부파일 등록 */
				ExAttachVO tAttachVo = new ExAttachVO( );
				tAttachVo.setType( tAttach.get( "type" ).toString( ) );
				tAttachVo.setExpend_seq( listVo.getExpendSeq( ) );
				tAttachVo.setList_seq( listVo.getListSeq( ) );
				tAttachVo.setSlip_seq( commonCode.EMPTYSEQ );
				tAttachVo.setFile_seq( tAttach.get( "file_seq" ).toString( ) );
				tAttachVo.setCreate_seq( tAttach.get( "create_seq" ).toString( ) );
				tAttachVo.setModify_seq( loginVo.getUniqId( ) );
				listDAOA.ExListAttachInfoInsert( tAttachVo );
				tAttach.put( "type", commonCode.EMPTYSTR ); /* 첨부파일을 업로드한 모듈 */
				tAttach.put( "expend_seq", commonCode.EMPTYSEQ ); /* 지출결의 시퀀스 */
				tAttach.put( "list_seq", commonCode.EMPTYSEQ ); /* 지출결의 항목 시퀀스 */
				tAttach.put( "slip_seq", commonCode.EMPTYSEQ ); /* 지출결의 항목 시퀀스 */
				tAttach.put( "file_seq", commonCode.EMPTYSEQ ); /* 지출결의 파일 시퀀스 */
				tAttach.put( "create_seq", commonCode.EMPTYSEQ ); /* 지출결의 파일 생성자 */
				tAttach.put( "create_date", commonCode.EMPTYSTR ); /* 지출결의 생성일자 */
				tAttach.put( "modify_seq", commonCode.EMPTYSEQ ); /* 지출결의 파일 수정자 */
				tAttach.put( "modify_date", commonCode.EMPTYSTR ); /* 지출결의 파일 수정일자 */
				tAttach.put( "file_sn", commonCode.EMPTYSEQ ); /* 지출결의 파일 순번 */
				tAttach.put( "file_absol_path", commonCode.EMPTYSTR ); /* 지출결의 서버 내 파일절대경로 */
				tAttach.put( "file_size", commonCode.EMPTYSTR ); /* 지출결의 파일 크기 */
			}
			/* 첨부파일 수정(삭제) */
			if ( delAttachListMap.size( ) > 0 ) {
				for ( Map<String, Object> deleteFileMap : delAttachListMap ) {
					deleteFileMap.put( "expendSeq", listVo.getExpendSeq( ) );
					deleteFileMap.put( "listSeq", listVo.getListSeq( ) );
					deleteFileMap.put( "slipSeq", "0" );
					listDAOA.ExListAttachInfoDelete( deleteFileMap );
				}
			}
			/* 데이터 생성 - 지출결의 항목 분개 파라미터 */
			listInfo.put( "expend", ConvertManager.ConverObjectToMap( expendVo ) );
			listInfo.put( "list", ConvertManager.ConverObjectToMap( listVo ) );
			listInfo.put( "auth", ConvertManager.ConverObjectToMap( authVo ) );
			listInfo.put( "summary", ConvertManager.ConverObjectToMap( summaryVo ) );
			listInfo.put( "partner", ConvertManager.ConverObjectToMap( partnerVo ) );
			listInfo.put( "project", ConvertManager.ConverObjectToMap( projectVo ) );
			listInfo.put( "card", ConvertManager.ConverObjectToMap( cardVo ) );
			listInfo.put( "budget", ConvertManager.ConverObjectToMap( budgetVo ) );
			listInfo.put( "attach", attachVo );
			/* 데이터 생성 - 예산 사용 여부 옵션 */
			listInfo.put( "isUseBudget", param.get( "isUseBudget" ) );
			/* 데이터 생성 - 지출결의 항목 분개 */
			resultVo = slipService.ExSlipInfoMake( loginVo, listInfo, conVo );
			if ( resultVo.getCode( ).equals( CommonInterface.commonCode.FAIL ) ) {
				throw new Exception( BizboxAMessage.getMessage( "TX000009290", "분개생성에 실패하였습니다" ) );
			}
			resultVo.setCode( CommonInterface.commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setListSeq( listVo.getListSeq( ) );
			// 사용자 변경후 seq 값 return
			resultVo.setSlipSeq( Integer.toString( empVo.getSeq( ) ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListInfoSelect" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 처리 수정( 결재 진행중 ) */
	@Override
    public ExCommonResultVO ExListInfoMakeUpdateApproval ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListInfoMakeUpdate" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> param >> " + param.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			/* 변수정의 */
			/* 기존 항목 정보 */
			ExpendVO expendVo = new ExpendVO( );
			ExExpendListVO listVo = new ExExpendListVO( );
			Map<String, Object> listDetailInfo = new HashMap<String, Object>( ); // 기존 항목 정보
			Map<String, Object> editListDetailInfo = new HashMap<String, Object>( ); // 신규 항목 정보
			String revisionHistory = "";
			String lineChange = System.getProperty( "line.separator" );
			List<ExExpendListVO> listListVo = new ArrayList<ExExpendListVO>( ); // 기존 항목 삭제 시 필요한 Vo
			boolean isEdit = false; // 지출결의 신규인지 수정인지 구분
			/* 초기값 지정 */
			listVo = (ExExpendListVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "list" ) ), listVo );
			isEdit = Boolean.parseBoolean( param.get( "isEdit" ).toString( ) );
			/* 초기값 정의 - 지출결의 */
			expendVo.setExpendSeq( listVo.getExpendSeq( ) );
			expendVo = masterService.ExUserExpendInfoSelect( expendVo );
			/* 기존 항목정보 조회 */
			if ( isEdit ) {
				listVo = this.ExUserListInfoSelect( listVo );
				listDetailInfo.put( "expendSeq", listVo.getExpendSeq( ) );
				listDetailInfo.put( "listSeq", listVo.getListSeq( ) );
				listDetailInfo = listDAOA.ExListDetailInfoSelect( listDetailInfo );
			}
			/* 항목 생성 (ERPiU의 경우 row_id 안들어감) */
			resultVo = this.ExListInfoMake( loginVo, param, conVo );
			if ( resultVo.getCode( ).equals( CommonInterface.commonCode.FAIL ) ) {
				throw new Exception( BizboxAMessage.getMessage( "TX000009274", "항목 생성에 실패하였습니다" ) );
			}
			/* 신규 항목정보 조회 */
			editListDetailInfo.put( "expendSeq", listVo.getExpendSeq( ) );
			editListDetailInfo.put( "listSeq", resultVo.getListSeq( ) );
			editListDetailInfo = listDAOA.ExListDetailInfoSelect( editListDetailInfo );
			/* 기존 항목과 신규 항목 비교(변경내역 입력을 위해) */
			// 비교 로직 처리
			if ( isEdit ) {
				revisionHistory += ("항목수정(listSeq:" + resultVo.getListSeq( ) + ")" + lineChange);
				// 표준적요
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "summaryCode" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "summaryCode" )) ) ) {
					revisionHistory += ("표준적요 변경 기존 : (" + listDetailInfo.get( "summaryCode" ).toString( ) + ")" + listDetailInfo.get( "summaryName" ).toString( ) + "-> 변경 : (" + editListDetailInfo.get( "summaryCode" ).toString( ) + ")" + editListDetailInfo.get( "summaryName" ).toString( ) + lineChange);
				}
				// 증빙유형
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "authCode" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "authCode" )) ) ) {
					revisionHistory += ("증빙유형 변경 기존 : (" + listDetailInfo.get( "authCode" ).toString( ) + ")" + listDetailInfo.get( "authName" ).toString( ) + "-> 변경 : (" + editListDetailInfo.get( "authCode" ).toString( ) + ")" + editListDetailInfo.get( "authName" ).toString( ) + lineChange);
				}
				// 적요
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "note" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "note" )) ) ) {
					revisionHistory += ("적요 변경 기존 : " + listDetailInfo.get( "note" ).toString( ) + "-> 변경 : " + editListDetailInfo.get( "note" ).toString( ) + lineChange);
				}
				// 증빙일자
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "authDate" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "authDate" )) ) ) {
					revisionHistory += ("증빙일자 변경 기존 : " + listDetailInfo.get( "authDate" ).toString( ) + "-> 변경 : " + editListDetailInfo.get( "authDate" ).toString( ) + lineChange);
				}
				// 거래처
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "partnerCode" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "partnerCode" )) ) || !listDetailInfo.get( "partnerName" ).toString( ).equals( editListDetailInfo.get( "partnerName" ).toString( ) ) ) {
					revisionHistory += ("거래처 변경 기존 : (" + listDetailInfo.get( "partnerCode" ).toString( ) + ")" + listDetailInfo.get( "partnerName" ).toString( ) + "-> 변경 : (" + editListDetailInfo.get( "partnerCode" ).toString( ) + ")" + editListDetailInfo.get( "partnerName" ).toString( ) + lineChange);
				}
				// 프로젝트
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "projectCode" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "projectCode" )) ) ) {
					revisionHistory += ("프로젝트 변경 기존 : (" + listDetailInfo.get( "projectCode" ).toString( ) + ")" + listDetailInfo.get( "projectName" ).toString( ) + "-> 변경 : (" + editListDetailInfo.get( "projectCode" ).toString( ) + ")" + editListDetailInfo.get( "projectName" ).toString( ) + lineChange);
				}
				// 사용자
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "erpEmpSeq" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "erpEmpSeq" )) ) ) {
					revisionHistory += ("사용자 변경 기존 : (" + listDetailInfo.get( "erpEmpSeq" ).toString( ) + ")" + listDetailInfo.get( "erpEmpName" ).toString( ) + "-> 변경 : (" + editListDetailInfo.get( "erpEmpSeq" ).toString( ) + ")" + editListDetailInfo.get( "erpEmpName" ).toString( ) + lineChange);
				}
				// 부서
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "erpDeptSeq" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "erpDeptSeq" )) ) ) {
					revisionHistory += ("사용자 부서 변경 기존 : (" + listDetailInfo.get( "erpDeptSeq" ).toString( ) + ")" + listDetailInfo.get( "erpDeptName" ).toString( ) + "-> 변경 : (" + editListDetailInfo.get( "erpDeptSeq" ).toString( ) + ")" + editListDetailInfo.get( "erpDeptName" ).toString( ) + lineChange);
				}
				// 카드
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "cardCode" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "cardCode" )) ) ) {
					revisionHistory += ("카드 변경 기존 : (" + listDetailInfo.get( "cardCode" ).toString( ) + ")" + listDetailInfo.get( "cardName" ).toString( ) + "-> 변경 : (" + editListDetailInfo.get( "cardCode" ).toString( ) + ")" + editListDetailInfo.get( "cardName" ).toString( ) + lineChange);
				}
				// ERPiU 전용
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) && (param.get( "isUseBudget" ) == null || Boolean.parseBoolean( param.get( "isUseBudget" ).toString( ) )) ) {
					// 예산단위
					if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "budgetCode" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "budgetCode" )) ) ) {
						revisionHistory += ("예산단위 변경 기존 : (" + listDetailInfo.get( "budgetCode" ).toString( ) + ")" + listDetailInfo.get( "budgetName" ).toString( ) + "-> 변경 : (" + CommonConvert.CommonGetStr(editListDetailInfo.get( "budgetCode" )) + ")" + editListDetailInfo.get( "budgetName" ).toString( ) + lineChange);
					}
					// 사업계획
					if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "bizplanCode" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "bizplanCode" )) ) ) {
						revisionHistory += ("사업계획 변경 기존 : (" + listDetailInfo.get( "bizplanCode" ).toString( ) + ")" + listDetailInfo.get( "bizplanName" ).toString( ) + "-> 변경 : (" + CommonConvert.CommonGetStr(editListDetailInfo.get( "bizplanCode" )) + ")" + editListDetailInfo.get( "bizplanName" ).toString( ) + lineChange);
					}
					// 예산계정
					if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "bgacctCode" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "bgacctCode" )) ) ) {
						revisionHistory += ("예산계정 변경 기존 : (" + listDetailInfo.get( "bgacctCode" ).toString( ) + ")" + listDetailInfo.get( "bgacctName" ).toString( ) + "-> 변경 : (" + CommonConvert.CommonGetStr(editListDetailInfo.get( "bgacctCode" )) + ")" + editListDetailInfo.get( "bgacctName" ).toString( ) + lineChange);
					}
				}
				// 공급대가
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "amt" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "amt" )) ) ) {
					revisionHistory += ("공급대가 변경 기존 : " + listDetailInfo.get( "amt" ).toString( ) + "-> 변경 : " + editListDetailInfo.get( "amt" ).toString( ) + lineChange);
				}
				// 부가세
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "taxAmt" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "taxAmt" )) ) ) {
					revisionHistory += ("부가세 변경 기존 : " + listDetailInfo.get( "taxAmt" ).toString( ) + "-> 변경 : " + editListDetailInfo.get( "taxAmt" ).toString( ) + lineChange);
				}
				// 공급가액
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "stdAmt" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "stdAmt" )) ) ) {
					revisionHistory += ("공급가액 변경 기존 : " + listDetailInfo.get( "stdAmt" ).toString( ) + "-> 변경 : " + editListDetailInfo.get( "stdAmt" ).toString( ) + lineChange);
				}
				// 과세표준액
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "subStdAmt" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "subStdAmt" )) ) ) {
					revisionHistory += ("과셰표준액 변경 기존 : " + listDetailInfo.get( "subStdAmt" ).toString( ) + "-> 변경 : " + editListDetailInfo.get( "subStdAmt" ).toString( ) + lineChange);
				}
				// 세액
				if ( !CommonConvert.CommonGetStr(listDetailInfo.get( "subTaxAmt" )).equals( CommonConvert.CommonGetStr(editListDetailInfo.get( "subTaxAmt" )) ) ) {
					revisionHistory += ("세액 변경 기존 : " + listDetailInfo.get( "subTaxAmt" ).toString( ) + "-> 변경 : " + editListDetailInfo.get( "subTaxAmt" ).toString( ) + lineChange);
				}
			}
			else {
				revisionHistory += "항목추가 (listSeq:" + resultVo.getListSeq( ) + ")";
			}
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				if ( param.get( "isUseBudget" ) == null || Boolean.parseBoolean( param.get( "isUseBudget" ).toString( ) ) ) {
					//ERPiU 예산넣기(임시데이터 생성) 수정예정
					Map<String, Object> budgetParam = new HashMap<String, Object>( );
					budgetParam.put( "docSeq", expendVo.getDocSeq( ) );
					budgetParam.put( "expendSeq", expendVo.getExpendSeq( ) );
					budgetParam.put( "newListSeq", editListDetailInfo.get( "listSeq" ) );
					budgetService.ExInterLockERPiURowInsert( budgetParam );
					if ( isEdit ) {
						/* 기존 항목에 포함된 예산정보 조회(log 관리를 위하여) */
						// 기존 항목의 row_id
						ResultVO basicRowID = new ResultVO( );
						if ( listDetailInfo.get( "expendSeq" ) == null ) {
							listDetailInfo.put( "expendSeq", listVo.getExpendSeq( ) );
						}
						basicRowID.setParams( listDetailInfo );
						basicRowID = codeService.ExExpendSlipBudgetInfoSelect( basicRowID );
						for ( Map<String, Object> bMap : basicRowID.getAaData( ) ) {
							revisionHistory += ("기존 slipSeq/rowId/rowNo : " + bMap.get( "slipSeq" ).toString( ) + "/" + bMap.get( "rowId" ).toString( ) + "/" + bMap.get( "rowNo" ).toString( ) + lineChange);
						}
						/* 기존 예산정보 삭제(slip에 있는 row_id, ERPiU의 gmm_sum_id) 수정예정 */
						budgetParam.put( "newListSeq", listDetailInfo.get( "listSeq" ) );
						budgetParam.put( "isEditList", true );
						budgetService.ExInterLockERPiURowDelete( budgetParam );
					}
				}
				if ( isEdit ) {
					/* 기존 항목 + 항목 하위 삭제 */
					listListVo.add( listVo );
					resultVo = this.ExListListInfoDelete( listListVo );
					if ( !resultVo.getCode( ).equals( CommonInterface.commonCode.SUCCESS ) ) {
						throw new Exception( BizboxAMessage.getMessage( "TX000009275", "항목 삭제에 실패하였습니다" ) );
					}
				}
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				if ( isEdit ) {
					/* 기존 항목 + 항목 하위 삭제 */
					listListVo.add( listVo );
					resultVo = this.ExListListInfoDelete( listListVo );
					if ( !resultVo.getCode( ).equals( CommonInterface.commonCode.SUCCESS ) ) {
						throw new Exception( BizboxAMessage.getMessage( "TX000009275", "항목 삭제에 실패하였습니다" ) );
					}
				}
			}
			/* 변경내역 입력(본문 양식도 넣어줘야한다. 따라서 기존 본문도 구해야한다) */
			Map<String, Object> appdocParam = new HashMap<String, Object>( );
			appdocParam.put( "docSeq", expendVo.getDocSeq( ) );
			appdocParam.put( "modifyReason", revisionHistory );
			appdocParam.put( "createdBy", loginVo.getUniqId( ) );
			appdocParam.put( "expendSeq", expendVo.getExpendSeq( ) );
			ResultVO historyMap = new ResultVO( );
			historyMap.setParams( appdocParam );
			masterService.ExExpendEditHistoryInsert( historyMap );
			/* 인터락 정보 업데이트를 위해 변수 담아준다. (resultVo에는 docSeq가 없어 code에 담아준다 */
			resultVo.setCode( expendVo.getDocSeq( ) );
			resultVo.setExpendSeq( expendVo.getExpendSeq( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListInfoMakeUpdate" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 처리 수정 */
	@Override
    public ExCommonResultVO ExListInfoMakeUpdate ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListInfoMakeUpdate" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> param >> " + param.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			/* 변수정의 */
			ExExpendListVO listVo = new ExExpendListVO( ); /* 지출결의 */
			List<ExExpendListVO> listListVo = new ArrayList<ExExpendListVO>( );
			/* 초기값 지정 */
			listVo = (ExExpendListVO) ConvertManager.ConvertMapToObject( ConvertManager.ConvertJsonToMap( (String) param.get( "list" ) ), listVo );
			listListVo.add( listVo );
			/* 기존 항목 + 항목 하위 삭제 */
			resultVo = this.ExListListInfoDelete( listListVo );
			if ( resultVo.getCode( ).equals( CommonInterface.commonCode.SUCCESS ) ) {
				/* 항목 재생성 */
				resultVo = this.ExListInfoMake( loginVo, param, conVo );
				if ( resultVo.getCode( ).equals( CommonInterface.commonCode.FAIL ) ) {
					throw new Exception( BizboxAMessage.getMessage( "TX000009274", "항목 생성에 실패하였습니다" ) );
				}
			}
			else {
				throw new Exception( BizboxAMessage.getMessage( "TX000009275", "항목 삭제에 실패하였습니다" ) );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListInfoMakeUpdate" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 생성 */
	@Override
	public ExExpendListVO ExListInfoInsert ( ExExpendListVO listVo ) throws Exception {
		try {
			listVo = listDAOA.ExListInfoInsert( listVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return listVo;
	}

	/* 지출결의 - 지출결의 항목 수정 */
	@Override
	public ExCommonResultVO ExListInfoUpdate ( ExExpendListVO listVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExExpendListVO listVo >> " + listVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = listDAOA.ExListInfoUpdate( listVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListInfoUpdate" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 삭제 */
	@Override
	public ExCommonResultVO ExListInfoDelete ( ExExpendListVO listVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExExpendListVO listVo >> " + listVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = listDAOA.ExListInfoDelete( listVo );
			/* 지출결의 첨부파일 삭제 */
			ResultVO attachResult = new ResultVO( );
			Map<String, Object> tMap = new HashMap<String, Object>( );
			tMap.put( commonCode.EXPENDSEQ, listVo.getExpendSeq( ) );
			tMap.put( commonCode.LISTSEQ, listVo.getListSeq( ) );
			attachResult.setParams( tMap );
			attachResult = this.ExExpendListAttachDelete( attachResult );
			if ( CommonConvert.CommonGetStr(attachResult.getResultCode( )).equals( commonCode.EMPTYNO ) ) {
				throw new Exception( "첨부파일 삭제에 실패하였습니다." );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListInfoDelete" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 복사 */
	@Override
	public ExCommonResultVO ExListInfoCopy ( LoginVO loginVo, List<ExExpendListVO> listListVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListInfoCopy" );
		cmLog.CommonSetInfo( "! [EX] List<ExExpendListVO> listListVo >> " + listListVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {

            ExpendVO exExpend = null;

			for ( ExExpendListVO exExpendListVO : listListVo ) {

                if (exExpend == null) {
                    exExpend = new ExpendVO();
                    exExpend.setExpendSeq(listListVo.get(0).getExpendSeq());
                    exExpend = masterService.ExUserExpendInfoSelect(exExpend);
                }

				/* 변수정의 */
				/* 변수정의 - 지출결의 항목 */
				ExExpendListVO listVo = new ExExpendListVO( );
				/* 변수정의 - 지출결의 항목 분개 목록 */
				ExExpendSlipVO slipVo = new ExExpendSlipVO( );
				List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
				/* 변수정의 - 공통코드 */
				ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
				ExCodeAuthVO authVo = new ExCodeAuthVO( );
				ExCodeOrgVO empVo = new ExCodeOrgVO( );
				/* ExCodeBudgetVO budgetVo = new ExCodeBudgetVO(); */
				ExCodeProjectVO projectVo = new ExCodeProjectVO( );
				ExCodePartnerVO partnerVo = new ExCodePartnerVO( );
				ExCodeCardVO cardVo = new ExCodeCardVO( );
				/* 지출결의 항목 소스 조회 */
				listVo = this.ExUserListInfoSelect( exExpendListVO );
				listVo.setCompSeq( exExpendListVO.getCompSeq( ) );
				/* 외부 시스템 연동이 아닌경우에만 복사 가능( 외부시스템 : 카드사용내역, 매입전자세금계산서 ) */
				if ( !listVo.getInterfaceType( ).equals( commonCode.EMPTYSTR ) ) {
					resultVo.setCode( CommonInterface.commonCode.FAIL );
					resultVo.setMessage( "외부 시스템 연동의 경우 복사가 불가능 합니다." );
					continue;
				}
				/* 복사 전 예산체크 진행. */
				/* 해당 Map 반환하면서 예산 초과된 항목들 표시해준다 */
				Map<String, Object> returnResultMap = new HashMap<String, Object>( );
				/* 예산 초과된 항목들 저장하는 List 초과되면 size > 0 */
				List<ExCommonResultVO> returnBudget = new ArrayList<ExCommonResultVO>( );
				List<Map<String, Object>> budgetResult = new ArrayList<Map<String, Object>>( );
				/* 항목에는 여러개의 분개정보가 있을 수 있으므로 리스트로 조회한다. */
				Map<String, Object> param = new HashMap<String, Object>( );
				param.put( "expendSeq", listVo.getExpendSeq( ) );
				param.put( "listSeq", listVo.getListSeq( ) );
				budgetResult = daoA.ExExpendListBudgetInfoSelect( param );
				/* 하위 분개 항목 중 하나라도 초과되는 항목이 있으면 패스한다. */
                // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행


                if (exExpend.getErpiuBudgetVer() != null && exExpend.getErpiuBudgetVer().equals("2.0")) {
                    for (Map<String, Object> tBudget : budgetResult) {
                        /* 예산 체크용 파라미터 */
                        Map<String, Object> budgetParam = new HashMap<String, Object>();

                        budgetParam.put("compSeq", loginVo.getCompSeq());
                        budgetParam.put("erpCompSeq", loginVo.getErpCoCd());
                        budgetParam.put("expendSeq", listVo.getExpendSeq());
                        budgetParam.put("budgetCode", tBudget.get("budgetCode"));
                        budgetParam.put("budgetName", tBudget.get("budgetName"));
                        budgetParam.put("bizplanCode", tBudget.get("bizplanCode"));
                        budgetParam.put("bizplanName", tBudget.get("bizplanName"));
                        budgetParam.put("bgacctCode", tBudget.get("bgacctCode"));
                        budgetParam.put("bgacctName", tBudget.get("bgacctName"));
                        budgetParam.put("budgetGbn", tBudget.get("budgetGbn"));
                        budgetParam.put("budgetYm", tBudget.get("budgetYm"));
                        budgetParam.put("ynControl", tBudget.get("ynControl"));
                    }
                } else {
                    for (Map<String, Object> tBudget : budgetResult) {
                        /* 예산 체크용 파라미터 */
                        Map<String, Object> budgetParam = new HashMap<String, Object>();
                        budgetParam.put("compSeq", loginVo.getCompSeq());
                        budgetParam.put("erpCompSeq", loginVo.getErpCoCd());
                        budgetParam.put("expendSeq", listVo.getExpendSeq());
                        budgetParam.put("acctCode", tBudget.get("bgacctCode"));
                        budgetParam.put("budgetCode", tBudget.get("budgetCode"));
                        budgetParam.put("budgetName", tBudget.get("budgetName"));
                        budgetParam.put("bizplanCode", tBudget.get("bizplanCode"));
                        budgetParam.put("bizplanName", tBudget.get("bizplanName"));
                        budgetParam.put("bgacctCode", tBudget.get("bgacctCode"));
                        budgetParam.put("bgacctName", tBudget.get("bgacctName"));
                        budgetParam.put("budgetGbn", tBudget.get("budgetGbn"));
                        budgetParam.put("budgetYm", tBudget.get("budgetYm"));
                        /* 해당 항목의 예산 초과 여부 확인 */
                        ExCodeBudgetVO tResult = new ExCodeBudgetVO();
                        tResult = budgetService.ExBudgetAmtInfoSelect2(budgetParam);
                        /* 위의 함수 실행을 하게되면 ERP금액 및 그룹웨어 금액이 집계가 된다. 또한 결재진행중 문서가 아닌경우는 현재 작성중인 문서의 예산금액까지 집계된다. */
                        /* 예산 초과 여부 확인 */
                        BigDecimal jsumAmt = new BigDecimal(tResult.getBudgetJsum()); /* 실행금액(그룹웨어 제외) */
                        BigDecimal actAmt = new BigDecimal(tResult.getBudgetActsum()); /* 편성금액 */
                        BigDecimal basicListAmt = new BigDecimal(tBudget.get("totalAmt").toString()); /* 복사하려고 하는 원본 데이터의 해당 예산금액 합계 */
                        jsumAmt = jsumAmt.add(basicListAmt);
                        BigDecimal zero = new BigDecimal(commonCode.EMPTYSEQ);
                        BigDecimal subTract = new BigDecimal(commonCode.EMPTYSEQ);
                        subTract = actAmt.subtract(jsumAmt);
                        /* 예산 초과 시 표시 할 내용 저장하는 변수 */
                        ExCommonResultVO tempResult = new ExCommonResultVO();
                        switch (conVo.getErpTypeCode()) {
                            case commonCode.ICUBE:
                                if (subTract.compareTo(zero) == -1 && tResult.getBudgetControlYN().equals("Y")) {
                                    tempResult.setCode(CommonInterface.commonCode.FAIL);
                                    tempResult.setMessage("예산이 초과되어 항목생성이 불가능합니다.");
                                    tempResult.setMap(tBudget);
                                    returnBudget.add(tempResult);
                                } else if (CommonConvert.CommonGetStr(tResult.getBudgetControlYN()).equals("B")) {
                                    tempResult.setCode(CommonInterface.commonCode.FAIL);
                                    tempResult.setMessage("예산이 미편성되어 항목생성이 불가능합니다.");
                                    tempResult.setMap(tBudget);
                                    returnBudget.add(tempResult);
                                }
                                break;
                            case commonCode.ERPIU:
                                if (subTract.compareTo(zero) == -1 && tResult.getBudgetControlYN().equals("Y")) {
                                    tempResult.setCode(CommonInterface.commonCode.FAIL);
                                    tempResult.setMessage("예산이 초과되어 항목생성이 불가능합니다.");
                                    tempResult.setMap(tBudget);
                                    returnBudget.add(tempResult);
                                }
                                break;
                            case commonCode.ETC:
                                break;
                            case commonCode.BIZBOXA:
                                break;
                            default:
                                throw new Exception("연동시스템 구분이 정의되지 않았습니다.");
                        }
                    }
				}
				/* 리스트에 뭔가가 들어가잇으면 예산에 문제 있는거다! */
				if ( returnBudget.size( ) > 0 ) {
					returnResultMap.put( "returnBudget", returnBudget );
					resultVo.setMap( returnResultMap );
					resultVo.setCode( commonCode.FAIL );
					return resultVo;
				}
				/* 표준적요 */
				if ( listVo.getSummarySeq( ) != 0 ) {
					/* 표준적요 - 조회 */
					summaryVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					summaryVo.setSeq( listVo.getSummarySeq( ) );
					summaryVo = codeService.ExExpendSummaryInfoSelect( summaryVo );
					/* 표준적요 - 생성 */
					summaryVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					summaryVo.setSeq( 0 );
					summaryVo.setCreateSeq( loginVo.getUniqId( ) );
					summaryVo.setModifySeq( loginVo.getUniqId( ) );
					summaryVo = codeService.ExExpendSummaryInfoInsert( summaryVo );
				}
				else {
					summaryVo.setSeq( 0 );
				}
				/* 증빙유형 */
				if ( listVo.getAuthSeq( ) != 0 ) {
					/* 증빙유형 - 조회 */
					authVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					authVo.setSeq( listVo.getAuthSeq( ) );
					authVo = codeService.ExExpendAuthInfoSelect( authVo );
					/* 증빙유형 -생성 */
					authVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					authVo.setSeq( 0 );
					authVo.setCreateSeq( loginVo.getUniqId( ) );
					authVo.setModifySeq( loginVo.getUniqId( ) );
					authVo = codeService.ExExpendAuthInfoInsert( authVo );
				}
				else {
					authVo.setSeq( 0 );
				}
				/* 사용자 */
				if ( listVo.getEmpSeq( ) != 0 ) {
					/* 사용자 - 조회 */
					empVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					empVo.setSeq( listVo.getEmpSeq( ) );
					empVo.setGroupSeq( loginVo.getGroupSeq( ) );
					empVo = codeService.ExExpendEmpInfoSelect( empVo );
					/* 사용자 - 생성 */
					empVo.setCompName( exExpendListVO.getCompSeq( ) );
					empVo.setSeq( 0 );
					empVo.setCreateSeq( loginVo.getUniqId( ) );
					empVo.setModifySeq( loginVo.getUniqId( ) );
					empVo = codeService.ExExpendEmpInfoInsert( empVo );
				}
				else {
					empVo.setSeq( 0 );
				}
				/* 예산 */
				if ( listVo.getBudgetSeq( ) != 0 ) {
					/* 예산 - 조회 */
					/* 예산 - 생성 */
				}

				/* 프로젝트 */
				if ( listVo.getProjectSeq( ) != 0 ) {
					/* 프로젝트 - 조회 */
					projectVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					projectVo.setSeq( listVo.getProjectSeq( ) );
					projectVo = codeService.ExExpendProjectInfoSelect( projectVo );
					/* 프로젝트 - 생성 */
					projectVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					projectVo.setSeq( 0 );
					projectVo.setCreateSeq( loginVo.getUniqId( ) );
					projectVo.setModifySeq( loginVo.getUniqId( ) );
					projectVo = codeService.ExExpendProjectInfoInsert( projectVo );
				}
				else {
					projectVo.setSeq( 0 );
				}
				/* 거래처 */
				if ( listVo.getPartnerSeq( ) != 0 ) {
					/* 거래처 - 조회 */
					partnerVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					partnerVo.setSeq( listVo.getPartnerSeq( ) );
					partnerVo = codeService.ExExpendPartnerInfoSelect( partnerVo );
					/* 거래처 - 생성 */
					partnerVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					partnerVo.setSeq( 0 );
					partnerVo.setCreateSeq( loginVo.getUniqId( ) );
					partnerVo.setModifySeq( loginVo.getUniqId( ) );
					partnerVo = codeService.ExExpendPartnerInfoInsert( partnerVo );
				}
				else {
					partnerVo.setSeq( 0 );
				}
				/* 카드 */
				if ( listVo.getCardSeq( ) != 0 ) {
					/* 카드 - 조회 */
					cardVo.setCompSeq( loginVo.getCompSeq( ) );
					cardVo.setSeq( listVo.getCardSeq( ) );
					cardVo = codeService.ExExpendCardInfoSelect( cardVo );
					/* 카드 - 생성 */
					cardVo.setCompSeq( exExpendListVO.getCompSeq( ) );
					cardVo.setSeq( 0 );
					cardVo.setCreateSeq( loginVo.getUniqId( ) );
					cardVo.setModifySeq( loginVo.getUniqId( ) );
					cardVo = codeService.ExExpendCardInfoInsert( cardVo );
				}
				else {
					cardVo.setSeq( 0 );
				}
				/* 지출결의 - 지출결의 항목 생성 */
				listVo.setCompSeq( exExpendListVO.getCompSeq( ) );
				listVo.setListSeq( commonCode.EMPTYSEQ );
				listVo.setCreateSeq( loginVo.getUniqId( ) );
				listVo.setModifySeq( loginVo.getUniqId( ) );
				listVo.setSummarySeq( summaryVo.getSeq( ) );
				listVo.setAuthSeq( authVo.getSeq( ) );
				listVo.setEmpSeq( empVo.getSeq( ) );
				listVo.setBudgetSeq( 0 );
				listVo.setProjectSeq( projectVo.getSeq( ) );
				listVo.setPartnerSeq( partnerVo.getSeq( ) );
				listVo.setCardSeq( cardVo.getSeq( ) );
				listVo.setInterfaceType( CommonInterface.commonCode.EMPTYSTR );
				listVo.setInterfaceMId( commonCode.EMPTYSEQ );
				listVo.setInterfaceDId( commonCode.EMPTYSEQ );

				//항목정보 정렬순서 채번
				int orderSeq = userListServiceA.ExGetOrderSeqFromListInfo(listVo);
				listVo.setOrderSeq(orderSeq);

				listVo = this.ExListInfoInsert( listVo );
				/* 지출결의 - 지출결의 항목 분개 복사 */
				slipVo.setCompSeq( exExpendListVO.getCompSeq( ) );
				slipVo.setExpendSeq( exExpendListVO.getExpendSeq( ) );
				slipVo.setListSeq( exExpendListVO.getListSeq( ) );
				slipListVo = slipService.ExSlipListInfoSelect( slipVo );
				for ( ExExpendSlipVO exExpendSlipVO : slipListVo ) {
					exExpendSlipVO.setCompSeq( exExpendListVO.getCompSeq( ) );
				}
				resultVo = slipService.ExSlipInfoCopy( loginVo, slipListVo, conVo, listVo.getListSeq( ) );
				if ( resultVo.getCode( ).equals( CommonInterface.commonCode.FAIL ) ) {
					throw new Exception( );
				}
			}
			if ( !resultVo.getCode( ).equals( commonCode.FAIL ) ) {
				resultVo.setCode( CommonInterface.commonCode.SUCCESS );
				resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListInfoCopy" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 목록 삭제 */
	@Override
	public ExCommonResultVO ExListListInfoDelete ( List<ExExpendListVO> listListVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListListInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] List<ExExpendListVO> listVo >> " + listListVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			for ( ExExpendListVO exExpendListVO : listListVo ) {
				/* 지출결의 항목 분개 삭제 */
				ExExpendSlipVO slipVo = new ExExpendSlipVO( );
				slipVo.setCompSeq( exExpendListVO.getCompSeq( ) );
				slipVo.setExpendSeq( exExpendListVO.getExpendSeq( ) );
				slipVo.setListSeq( exExpendListVO.getListSeq( ) );
				resultVo = slipService.ExSlipDInfoDelete( slipVo );
				if ( resultVo.getCode( ).equals( CommonInterface.commonCode.FAIL ) ) {
					throw new Exception( BizboxAMessage.getMessage( "TX000009276", "분개 삭제에 실패하였습니다" ) );
				}
				/* 지출결의 항목 삭제 */
				resultVo = this.ExListInfoDelete( exExpendListVO );
				if ( resultVo.getCode( ).equals( CommonInterface.commonCode.FAIL ) ) {
					throw new Exception( BizboxAMessage.getMessage( "TX000009275", "항목 삭제에 실패하였습니다" ) );
				}
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListListInfoDelete" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 첨부파일 정보 조회 */
	/* 파라메터 필수 expend_seq, list_seq group_seq */
	@Override
    public List<ExAttachVO> ExListAttachInfoSelect ( Map<String, Object> params ) throws Exception {
		List<ExAttachVO> attachList = new ArrayList<ExAttachVO>( );
		//파일아이디 가져오기
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListAttachInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object>params >> " + params.toString( ) );
		try {
			params.put( "type", "list" );
			params.put( "slip_seq", commonCode.EMPTYSEQ );
			List<String> fileIdsList = new ArrayList<String>( );
			fileIdsList = listDAOA.ExListAttchFileIDInfoSelect( params );
			//파일아이디가 존재한다면 파일정보를 가져온다.
			String fileIdList = CommonInterface.commonCode.EMPTYSTR;
			for ( String item : fileIdsList ) {
				fileIdList = fileIdList + "\'" + item + "\'" + ",";
			}
			if ( fileIdsList.size( ) != 0 ) {
				params.put( "file_seq", fileIdList.substring( 0, fileIdList.length( ) - 1 ) );
				params.put( "os_type", CommonUtil.osType( ) );
				attachList = listDAOA.ExListAttchInfoSelect( params );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExAttachVO> attach_list >> " + attachList.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendListService - ExListAttachInfoSelect" );
		return attachList;
	}

	/* 지출결의 - 지출결의 분개단위 입력 시 항목 금액 수정 */
	@Override
    public ExCommonResultVO ExListAmtEdit ( Map<String, Object> param ) throws Exception {
		ExCommonResultVO result = new ExCommonResultVO( );
		listDAOA.ExListAmtEdit( param );
		return result;
	}

	/* 지출결의 - 지출결의 항목 금액 정보 조회 */
	@Override
    public Map<String, Object> ExListAmtSelect ( ExExpendListVO listVo ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = listDAOA.ExListAmtSelect( listVo );
		return result;
	}

	/* 지출결의 - 지출결의 가져오기 */
	@Override
	public ResultVO ExExpendHistoryReflect ( LoginVO loginVo, ExExpendListVO listVo, ConnectionVO conVo, String newExpendSeq ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			/* 변수정의 - 지출결의 항목 */
			ExExpendListVO newListVo = new ExExpendListVO( );
			/* 변수정의 - 지출결의 항목 분개 목록 */
			ExExpendSlipVO slipVo = new ExExpendSlipVO( );
			List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
			/* 변수정의 - 공통코드 */
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
			ExCodeAuthVO authVo = new ExCodeAuthVO( );
			ExCodeOrgVO empVo = new ExCodeOrgVO( );
			/* ExCodeBudgetVO budgetVo = new ExCodeBudgetVO(); */
			ExCodeProjectVO projectVo = new ExCodeProjectVO( );
			ExCodePartnerVO partnerVo = new ExCodePartnerVO( );
			ExCodeCardVO cardVo = new ExCodeCardVO( );
			/* 지출결의 항목 소스 조회 */
			newListVo = this.ExUserListInfoSelect( listVo );
			newListVo.setCompSeq( listVo.getCompSeq( ) );
			newListVo.setExpendSeq( newExpendSeq );
			/* 외부 시스템중 카드내역, 세금계산서의 경우 해당 내역이 미상신 상태이면 사용가능 */
			if ( !newListVo.getInterfaceType( ).equals( commonCode.EMPTYSTR ) ) {
				ResultVO tResult = new ResultVO( );
				Map<String, Object> tMap = new HashMap<String, Object>( );
				tMap.put( "syncId", newListVo.getInterfaceMId( ) );
				tResult.setParams( tMap );
				if ( CommonConvert.CommonGetStr(newListVo.getInterfaceType( )).equals( "card" ) ) {
					tMap = cardService.ExExpendCardDetailInfoSelect( tResult, conVo );
				}
				else if ( CommonConvert.CommonGetStr(newListVo.getInterfaceType( )).equals( "etax" ) ) {
					tMap = etaxService.ExExpendEtaxGWInfoSelect( tMap );
				}
				else {
					resultVo.setResultCode( commonCode.FAIL );
					resultVo.setResultName( "외부시스템은 반영이 불가능 합니다." );
					return resultVo;
				}
				if ( tMap != null && CommonConvert.CommonGetStr(tMap.get( "sendYN" )).equals( commonCode.EMPTYYES ) ) {

					// 법인카드 및 세금계산서의 경우 반영되지 않도록 한다. ( 이미 사용된 데이터의 경우 )
					// 가져오기가 반영이 안되도록 되는 것이 아니라 PASS가 되도록 적용한다. ( 단순 return 처리 진행  )

					resultVo.setResultCode( commonCode.SUCCESS );
					return resultVo;
				}
			}
			else {
				newListVo.setInterfaceType( CommonInterface.commonCode.EMPTYSTR );
				newListVo.setInterfaceMId( commonCode.EMPTYSEQ );
				newListVo.setInterfaceDId( commonCode.EMPTYSEQ );
			}
			/* 표준적요 */
			if ( newListVo.getSummarySeq( ) != 0 ) {
				/* 표준적요 - 조회 */
				summaryVo.setCompSeq( listVo.getCompSeq( ) );
				summaryVo.setSeq( newListVo.getSummarySeq( ) );
				summaryVo = codeService.ExExpendSummaryInfoSelect( summaryVo );
				/* 표준적요 - 생성 */
				summaryVo.setCompSeq( listVo.getCompSeq( ) );
				summaryVo.setSeq( 0 );
				summaryVo.setCreateSeq( loginVo.getUniqId( ) );
				summaryVo.setModifySeq( loginVo.getUniqId( ) );
				summaryVo = codeService.ExExpendSummaryInfoInsert( summaryVo );
			}
			else {
				summaryVo.setSeq( 0 );
			}
			/* 증빙유형 */
			if ( newListVo.getAuthSeq( ) != 0 ) {
				/* 증빙유형 - 조회 */
				authVo.setCompSeq( listVo.getCompSeq( ) );
				authVo.setSeq( newListVo.getAuthSeq( ) );
				authVo = codeService.ExExpendAuthInfoSelect( authVo );
				/* 증빙유형 -생성 */
				authVo.setCompSeq( listVo.getCompSeq( ) );
				authVo.setSeq( 0 );
				authVo.setCreateSeq( loginVo.getUniqId( ) );
				authVo.setModifySeq( loginVo.getUniqId( ) );
				authVo = codeService.ExExpendAuthInfoInsert( authVo );
			}
			else {
				authVo.setSeq( 0 );
			}
			/* 사용자 */
			if ( newListVo.getEmpSeq( ) != 0 ) {
				/* 사용자 - 조회 */
				empVo.setCompSeq( listVo.getCompSeq( ) );
				empVo.setSeq( newListVo.getEmpSeq( ) );
				empVo.setGroupSeq( loginVo.getGroupSeq() );
				empVo = codeService.ExExpendEmpInfoSelect( empVo );
				/* 사용자 - 생성 */
				empVo.setCompName( listVo.getCompSeq( ) );
				empVo.setSeq( 0 );
				empVo.setCreateSeq( loginVo.getUniqId( ) );
				empVo.setModifySeq( loginVo.getUniqId( ) );
				empVo = codeService.ExExpendEmpInfoInsert( empVo );
			}
			else {
				empVo.setSeq( 0 );
			}
			/* 예산 */
			if ( newListVo.getBudgetSeq( ) != 0 ) {
				/* 예산 - 조회 */
				/* 예산 - 생성 */
			}

			/* 프로젝트 */
			if ( newListVo.getProjectSeq( ) != 0 ) {
				/* 프로젝트 - 조회 */
				projectVo.setCompSeq( listVo.getCompSeq( ) );
				projectVo.setSeq( newListVo.getProjectSeq( ) );
				projectVo = codeService.ExExpendProjectInfoSelect( projectVo );
				/* 프로젝트 - 생성 */
				projectVo.setCompSeq( listVo.getCompSeq( ) );
				projectVo.setSeq( 0 );
				projectVo.setCreateSeq( loginVo.getUniqId( ) );
				projectVo.setModifySeq( loginVo.getUniqId( ) );
				projectVo = codeService.ExExpendProjectInfoInsert( projectVo );
			}
			else {
				projectVo.setSeq( 0 );
			}
			/* 거래처 */
			if ( newListVo.getPartnerSeq( ) != 0 ) {
				/* 거래처 - 조회 */
				partnerVo.setCompSeq( listVo.getCompSeq( ) );
				partnerVo.setSeq( newListVo.getPartnerSeq( ) );
				partnerVo = codeService.ExExpendPartnerInfoSelect( partnerVo );
				/* 거래처 - 생성 */
				partnerVo.setCompSeq( listVo.getCompSeq( ) );
				partnerVo.setSeq( 0 );
				partnerVo.setCreateSeq( loginVo.getUniqId( ) );
				partnerVo.setModifySeq( loginVo.getUniqId( ) );
				partnerVo = codeService.ExExpendPartnerInfoInsert( partnerVo );
			}
			else {
				partnerVo.setSeq( 0 );
			}
			/* 카드 */
			if ( newListVo.getCardSeq( ) != 0 ) {
				/* 카드 - 조회 */
				cardVo.setCompSeq( loginVo.getCompSeq( ) );
				cardVo.setSeq( newListVo.getCardSeq( ) );
				cardVo = codeService.ExExpendCardInfoSelect( cardVo );
				/* 카드 - 생성 */
				cardVo.setCompSeq( listVo.getCompSeq( ) );
				cardVo.setSeq( 0 );
				cardVo.setCreateSeq( loginVo.getUniqId( ) );
				cardVo.setModifySeq( loginVo.getUniqId( ) );
				cardVo = codeService.ExExpendCardInfoInsert( cardVo );
			}
			else {
				cardVo.setSeq( 0 );
			}
			/* 지출결의 - 지출결의 항목 생성 */
			newListVo.setCompSeq( listVo.getCompSeq( ) );
			newListVo.setListSeq( commonCode.EMPTYSEQ );
			newListVo.setCreateSeq( loginVo.getUniqId( ) );
			newListVo.setModifySeq( loginVo.getUniqId( ) );
			newListVo.setSummarySeq( summaryVo.getSeq( ) );
			newListVo.setAuthSeq( authVo.getSeq( ) );
			newListVo.setEmpSeq( empVo.getSeq( ) );
			newListVo.setBudgetSeq( 0 );
			newListVo.setProjectSeq( projectVo.getSeq( ) );
			newListVo.setPartnerSeq( partnerVo.getSeq( ) );
			newListVo.setCardSeq( cardVo.getSeq( ) );
			newListVo = this.ExListInfoInsert( newListVo );
			/* 지출결의 - 지출결의 항목 분개 복사 */
			// 기존 분개정보를 조회해야한다.
			slipVo.setCompSeq( listVo.getCompSeq( ) );
			slipVo.setExpendSeq( listVo.getExpendSeq( ) );
			slipVo.setListSeq( listVo.getListSeq( ) );
			slipListVo = slipService.ExSlipListInfoSelect( slipVo );
			for ( ExExpendSlipVO exExpendSlipVO : slipListVo ) {
				exExpendSlipVO.setCompSeq( listVo.getCompSeq( ) );
				exExpendSlipVO.setInterfaceType( newListVo.getInterfaceType( ) );
				exExpendSlipVO.setInterfaceMId( newListVo.getInterfaceMId( ) );
				exExpendSlipVO.setInterfaceDId( newListVo.getInterfaceDId( ) );
				/* 분개 복사 진행 */
				resultVo = slipService.ExExpendHistorySlipReflect( loginVo, exExpendSlipVO, conVo, newListVo.getListSeq( ), newExpendSeq );
				if ( resultVo.getResultCode( ).equals( CommonInterface.commonCode.FAIL ) ) {
					throw new Exception( );
				}
			}
			resultVo.setResultCode( CommonInterface.commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultVo;
	}

	/* 지출결의 - 지출결의 가져오기(분개단위 입력) */
	@Override
	public ResultVO ExExpendHistoryReflectSlipMode ( LoginVO loginVo, ExExpendListVO listVo, ConnectionVO conVo, String newExpendSeq, ExExpendListVO basicList ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			/* 변수정의 - 지출결의 항목 */
			ExExpendListVO newListVo = new ExExpendListVO( );
			/* 변수정의 - 지출결의 항목 분개 목록 */
			ExExpendSlipVO slipVo = new ExExpendSlipVO( );
			List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
			/* 지출결의 항목 소스 조회 */
			newListVo = this.ExUserListInfoSelect( listVo );
			newListVo.setCompSeq( listVo.getCompSeq( ) );
			newListVo.setExpendSeq( newExpendSeq );
			/* 외부 시스템중 카드내역, 세금계산서의 경우 해당 내역이 미상신 상태이면 사용가능 */
			if ( !newListVo.getInterfaceType( ).equals( commonCode.EMPTYSTR ) ) {
				ResultVO tResult = new ResultVO( );
				Map<String, Object> tMap = new HashMap<String, Object>( );
				tMap.put( "syncId", newListVo.getInterfaceMId( ) );
				tResult.setParams( tMap );
				if ( newListVo.getInterfaceType( ).equals( "card" ) ) {
					tMap = cardService.ExExpendCardDetailInfoSelect( tResult, conVo );
				}
				else if ( newListVo.getInterfaceType( ).equals( "etax" ) ) {
					tMap = etaxService.ExExpendEtaxGWInfoSelect( tMap );
				}
				else {
					resultVo.setResultCode( commonCode.FAIL );
					resultVo.setResultName( "외부시스템은 반영이 불가능 합니다." );
					return resultVo;
				}
				if ( tMap != null && CommonConvert.CommonGetStr(tMap.get( "sendYN" )).equals( commonCode.EMPTYYES ) ) {
					resultVo.setResultCode( commonCode.FAIL );
					resultVo.setResultName( "외부시스템은 반영이 불가능 합니다." );
					newListVo.setInterfaceType( CommonInterface.commonCode.EMPTYSTR );
					newListVo.setInterfaceMId( commonCode.EMPTYSEQ );
					newListVo.setInterfaceDId( commonCode.EMPTYSEQ );
					return resultVo;
				}
			}
			else {
				newListVo.setInterfaceType( CommonInterface.commonCode.EMPTYSTR );
				newListVo.setInterfaceMId( commonCode.EMPTYSEQ );
				newListVo.setInterfaceDId( commonCode.EMPTYSEQ );
			}
			/* 현재 항목 금액 정보에 신규 항목의 금액 정보를 더한다. */
			BigDecimal amt = new BigDecimal( basicList.getAmt( ) );
			BigDecimal stdAmt = new BigDecimal( basicList.getStdAmt( ) );
			BigDecimal taxAmt = new BigDecimal( basicList.getTaxAmt( ) );
			BigDecimal subStdAmt = new BigDecimal( basicList.getSubStdAmt( ) );
			BigDecimal subTaxAmt = new BigDecimal( basicList.getSubTaxAmt( ) );
			amt = amt.add( new BigDecimal( newListVo.getAmt( ) ) );
			stdAmt = stdAmt.add( new BigDecimal( newListVo.getStdAmt( ) ) );
			taxAmt = taxAmt.add( new BigDecimal( newListVo.getTaxAmt( ) ) );
			subStdAmt = subStdAmt.add( new BigDecimal( newListVo.getSubStdAmt( ) ) );
			subTaxAmt = subTaxAmt.add( new BigDecimal( newListVo.getSubTaxAmt( ) ) );
			basicList.setAmt( amt.toString( ) );
			basicList.setStdAmt( stdAmt.toString( ) );
			basicList.setTaxAmt( taxAmt.toString( ) );
			basicList.setSubStdAmt( subStdAmt.toString( ) );
			basicList.setSubTaxAmt( subTaxAmt.toString( ) );
			/* 지출결의 - 지출결의 항목 분개 복사 */
			// 기존 분개정보를 조회해야한다.
			slipVo.setCompSeq( listVo.getCompSeq( ) );
			slipVo.setExpendSeq( listVo.getExpendSeq( ) );
			slipVo.setListSeq( listVo.getListSeq( ) );
			slipListVo = slipService.ExSlipListInfoSelect( slipVo );
			for ( ExExpendSlipVO exExpendSlipVO : slipListVo ) {
				exExpendSlipVO.setCompSeq( listVo.getCompSeq( ) );
				exExpendSlipVO.setInterfaceType( newListVo.getInterfaceType( ) );
				exExpendSlipVO.setInterfaceMId( newListVo.getInterfaceMId( ) );
				exExpendSlipVO.setInterfaceDId( newListVo.getInterfaceDId( ) );
				/* 분개 복사 진행 */
				resultVo = slipService.ExExpendHistorySlipReflect( loginVo, exExpendSlipVO, conVo, "1", newExpendSeq );
				if ( resultVo.getResultCode( ).equals( CommonInterface.commonCode.FAIL ) ) {
					throw new Exception( );
				}
			}
			resultVo.setResultCode( CommonInterface.commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 리스트 조회 */
	@Override
    public List<ExExpendListVO> ExExpendListSelect ( Map<String, Object> param ) {
		List<ExExpendListVO> result = new ArrayList<ExExpendListVO>( );
		result = listDAOA.ExExpendListSelect( param );
		return result;
	}

	/* 지출결의 - 지출결의 항목 첨부파일 삭제 */
	@Override
    public ResultVO ExExpendListAttachDelete ( ResultVO param ) {
		listDAOA.ExExpendListAttachDelete( param );
		return param;
	}

	/* 지출결의 - 해당 지출결의 예산정보 조회 */
	@Override
    public ResultVO ExExpendHistoryBudgetInfoSelect ( ResultVO param ) {
		/**
		 * 예산 사용 여부 확인
		 */
		// 예산 초과 변수
		List<ExCommonResultVO> resultBudget = new ArrayList<ExCommonResultVO>( );
		ExExpendVO expendVo = new ExExpendVO( );
		Map<String, Object> tParam = new HashMap<String, Object>( );
		expendVo.setExpendSeq( param.getParams( ).get( "expendSeq" ).toString( ) );
		expendVo.setCompSeq( param.getParams( ).get( "compSeq" ).toString( ) );
		expendVo.setErpCompSeq( param.getParams( ).get( "erpCompSeq" ).toString( ) );
		/* 지출결의 옵션 조회 */
		ResultVO expendOption = new ResultVO( );
		tParam.put( "compSeq", param.getParams( ).get( "compSeq" ) );
		tParam.put( "formSeq", param.getParams( ).get( "formSeq" ) );
		tParam.put( "useSw", param.getParams( ).get( "useSw" ) );
		tParam.put( "optionCode", "003301" );
		expendOption = configService.ExAdminConfigOptionSelect( tParam );
		if ( expendOption != null && expendOption.getAaData( ).size( ) > 0 ) {
			if ( CommonConvert.CommonGetStr(expendOption.getAaData( ).get( 0 ).get( "set_value" )).equals( commonCode.EMPTYYES ) ) {
				// 예산 초과 여부 조회
				try {
					expendVo.setComeHistory( true );
					resultBudget = budgetService.ExBudgetErrorInfoSelect2( expendVo );
					param.setResultCode( commonCode.SUCCESS );
				}
				catch ( Exception e ) {
					param.setResultCode( commonCode.FAIL );
					param.setResultName( e.getMessage( ) );
				}
				for ( ExCommonResultVO budgetError : resultBudget ) {
					if ( budgetError.getValidateStat( ).equals( "false" ) ) {
						param.setResultCode( commonCode.FAIL );
						param.setResultName( budgetError.getError( ) );
						param.setaData( budgetError.getMap( ) );
						break;
					}
				}
			}
		}
		return param;
	}

	/* 지출결의 - 해당 지출결의 항목 첨부파일 조회 */
	@Override
    public List<Map<String, Object>> ExExpendListAttachListInfoSelect ( Map<String, Object> param ) {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = listDAOA.ExExpendListAttachListInfoSelect( param );
		return result;
	}

	/* 지출결의 종결문서 수정 시 카드/매입전자세금계산서 사용 내역 전송 여부 수정 */
	@Override
    public ResultVO ExInterfaceInfoUpdate ( ExExpendListVO tListVo ) throws Exception{
		/* 변수 정의 */
		ResultVO result = new ResultVO( );
		ExExpendListVO listVo = new ExExpendListVO( );
		/* 초기값 정의 */
		listVo.setExpendSeq( listVo.getExpendSeq( ) );
		listVo.setListSeq( listVo.getListSeq( ) );

		Map<String, Object> updateParam = new HashMap<String, Object>( );
		updateParam.put( "expendSeq", tListVo.getExpendSeq( ) );
		updateParam.put( "listSeq", tListVo.getListSeq( ) );
		Map<String, Object> resultList = new HashMap<String, Object>( );
		resultList = listDAOA.ExListInterfaceSelect( updateParam );
		listVo.setInterfaceType( CommonConvert.CommonGetStr( resultList.get( "interfaceType" ) ) );
		listVo.setInterfaceMId( CommonConvert.CommonGetStr( resultList.get( "interfaceMId" ) ) );
		updateParam.put( "sendYN", commonCode.EMPTYNO );
		updateParam.put( "syncId", listVo.getInterfaceMId( ) );

		/* 추후 추가 모듈 연동시 확장성을 위해 아래와 같이 처리 진행 */
		if ( listVo.getInterfaceType( ).equals( "card" ) ) {
			result = exUserSlipServiceADAO.ExInterfaceCardInfoUpdate( updateParam );
		}
		else if ( listVo.getInterfaceType( ).equals( "etax" ) ) {
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( CommonConvert.CommonGetEmpVO( ).getCompSeq( ) ) );
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				/* issNo, erpBizSeq */
				updateParam.putAll( listDAOA.ExExpendListETaxInfoSelect( updateParam ) );
			}
			result = exUserSlipServiceADAO.ExInterfaceETaxInfoUpdate( updateParam, conVo );
		}
		return result;
	}

	/* 외화입력 - 환율정보 조회 */
	@Override
    public ResultVO ExchangeRateInfoSelect ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception {
		ResultVO resultVo = new ResultVO();
		resultVo = userListServiceUDAO.ExchangeRateInfoSelect( foreignCurrencyVO, conVo );
		return resultVo;
	}

	/* 외화입력 - 올림구분 조회 */
	@Override
    public ResultVO RoundingTypeInfoSelect ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception {
		ResultVO resultVo = new ResultVO();
		resultVo = userListServiceUDAO.RoundingTypeInfoSelect( foreignCurrencyVO, conVo );
		return resultVo;
	}

	/* 외화입력 - 외화계정인지 확인 */
	@Override
    public ResultVO CheckForeignCurrencyAcctCode ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception {
		/* 연동시스템별 정보 처리 */
		FExUserListService service = null;
        switch (CommonConvert.CommonGetStr(conVo.getErpTypeCode())) {
            case commonCode.ICUBE: /* ERP iCUBE */
                service = userListServiceI;
                break;
            case commonCode.ERPIU: /* ERP iU */
                service = userListServiceU;
                break;
            default: /* Bizbox Alpha */
                service = userListServiceA;
                break;
        }

		return service.CheckForeignCurrencyAcctCode( foreignCurrencyVO, conVo );
	}

	/* 외화입력 - iCUBE 환율, 외화금액 소수점 자릿수 조회(iCUBE 시스템 환경설정) */
	@Override
    public ResultVO PointLengthInfoSelect ( ExExpendForeignCurrencyVO foreignCurrencyVO, ConnectionVO conVo ) throws Exception {
		ResultVO resultVo = new ResultVO();
		resultVo = userListServiceIDAO.PointLengthInfoSelect( foreignCurrencyVO, conVo );
		return resultVo;
	}
}
