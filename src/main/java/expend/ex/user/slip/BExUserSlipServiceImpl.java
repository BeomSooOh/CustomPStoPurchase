package expend.ex.user.slip;

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
import common.vo.ex.ExCodeAcctVO;
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
import common.vo.ex.ExExpendMngVO;
import common.vo.ex.ExExpendSlipVO;
import common.vo.ex.ExExpendVO;
import common.vo.ex.ExpendVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.budget.BExBudgetService;
import expend.ex.budget.FExBudgetServiceI;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.expend.BExUserService;
import expend.ex.user.expend.FExUserService;
import expend.ex.user.expend.FExUserServiceADAO;
import expend.ex.user.list.BExUserListService;
import expend.ex.user.mng.BExUserMngService;
import main.web.BizboxAMessage;


@Service ( "BExUserSlipService" )
public class BExUserSlipServiceImpl implements BExUserSlipService {

	/* 변수정의 */
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 */
	/* 변수정의 */
	@Resource ( name = "FExUserSlipServiceADAO" )
	private FExUserSlipServiceADAO exUserSlipServiceADAO;
	/* 변수정의 - 지출결의 */
	@Resource ( name = "BExUserService" )
	private BExUserService masterService;
	/* 변수정의 - 지출결의 항목 */
	@Resource ( name = "BExUserListService" )
	private BExUserListService exUserListService;
	/* 변수정의 - 관리항목 */
	@Resource ( name = "BExUserMngService" )
	private BExUserMngService exUserMngService;
	/* 변수정의 - 공토코드 */
	@Resource ( name = "BExUserCodeService" )
	private BExUserCodeService exUserCodeService;
	/* 변수정의 - 예산 */
	@Resource ( name = "BExBudgetService" )
	private BExBudgetService budgetService;/* 예산 서비스 */
	@Resource ( name = "FExUserServiceA" )
	private FExUserService exUserServiceA;
	@Resource ( name = "FExUserServiceI" )
	private FExUserService exUserServiceI;
	@Resource ( name = "FExUserServiceU" )
	private FExUserService exUserServiceU;
	@Resource ( name = "FExUserServiceE" )
	private FExUserService exUserServiceE;
	@Resource ( name = "FExBudgetServiceI" )
	private FExBudgetServiceI exBudgetServiceI;
	@Resource ( name = "FExBudgetServiceU" )
	private FExBudgetServiceI exBudgetServiceU;
	@Resource ( name = "BExAdminConfigService" ) /* 환경설정 서비스 */
	private BExAdminConfigService configService;
	/* 변수정의 - DAO */
	@Resource ( name = "FExUserServiceADAO" )
	private FExUserServiceADAO daoA; /* Bizbox Alpha */

	/* Pop */
	/* Pop - ExExpendSlipPop 반환값 처리 */
	@Override
    public Map<String, Object> ExUserSlipPopReturn ( Map<String, Object> params ) throws Exception {
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

	/* 지출결의 - 지출결의 항목 분개 생성 */
	@Override
	public ExExpendSlipVO ExSlipInfoInsert ( ExExpendSlipVO slipVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		try {
			if ( slipVo.getSlipSeq( ).equals( commonCode.EMPTYSEQ ) ) {
				slipVo = exUserSlipServiceADAO.ExSlipInfoInsert( slipVo );
			}
			else {
				slipVo = exUserSlipServiceADAO.ExSlipInfoReInsert( slipVo );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipInfoInsert" );
		return slipVo;
	}

	/* 지출결의 - 지출결의 항목 분개 수정 */
	@Override
	public ExCommonResultVO ExSlipInfoUpdate ( ExExpendSlipVO slipVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exUserSlipServiceADAO.ExSlipInfoUpdate( slipVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipInfoUpdate" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 삭제 */
	@Override
	public ExCommonResultVO ExSlipInfoDelete ( ExExpendSlipVO slipVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			/* 하위 관리항목 삭제 */
			ExExpendMngVO mngVo = new ExExpendMngVO( );
			mngVo.setCompSeq( slipVo.getCompSeq( ) );
			mngVo.setExpendSeq( slipVo.getExpendSeq( ) );
			mngVo.setListSeq( slipVo.getListSeq( ) );
			mngVo.setSlipSeq( slipVo.getSlipSeq( ) );
			resultVo = exUserMngService.ExMngDInfoDelete( mngVo );
			resultVo = exUserSlipServiceADAO.ExSlipInfoDelete( slipVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipInfoDelete" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 하위 내역 모두 삭제 */
	@Override
    public ExCommonResultVO ExSlipDInfoDelete ( ExExpendSlipVO slipVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipDInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			/* 삭제 대상 분개 내역 조회 */
			List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
			slipListVo = this.ExSlipListInfoSelect( slipVo );
			for ( ExExpendSlipVO exExpendSlipVO : slipListVo ) {
				/* 하위 관리항목 삭제 */
				ExExpendMngVO mngVo = new ExExpendMngVO( );
				mngVo.setCompSeq( slipVo.getCompSeq( ) );
				mngVo.setExpendSeq( exExpendSlipVO.getExpendSeq( ) );
				mngVo.setListSeq( exExpendSlipVO.getListSeq( ) );
				mngVo.setSlipSeq( exExpendSlipVO.getSlipSeq( ) );
				resultVo = exUserMngService.ExMngDInfoDelete( mngVo );
				if ( resultVo.getCode( ).equals( commonCode.FAIL ) ) {
					throw new Exception( BizboxAMessage.getMessage( "TX000009270", "관리항목 삭제에 실패하였습니다" ) );
				}
			}
			if ( slipListVo.size( ) != 0 ) {
				resultVo = exUserSlipServiceADAO.ExSlipDInfoDelete( slipVo );
			}
			else {
				resultVo.setCode( commonCode.SUCCESS );
				resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			}
			if ( resultVo.getCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( BizboxAMessage.getMessage( "TX000009276", "분개 삭제에 실패하였습니다" ) );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipDInfoDelete" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 목록 삭제 */
	@Override
    public ExCommonResultVO ExSlipListInfoDelete ( List<ExExpendSlipVO> slipListVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipDInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] List<ExExpendSlipVO> slipListVo >> " + slipListVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			for ( ExExpendSlipVO exExpendSlipVO : slipListVo ) {
				resultVo = this.ExSlipInfoDelete( exExpendSlipVO );
				cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipDInfoDelete" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 복사 */
	@Override
	public ExCommonResultVO ExSlipInfoCopy ( LoginVO loginVo, List<ExExpendSlipVO> slipListVo, ConnectionVO conVo, String targetListSeq ) throws Exception {
		/* 번경이력
		 * 2019-09-09 남진우 commonCode.EMPTYSEQ  = 0 이기에 쿼리상에서 문제 발생 이에 null 삽입.  ExSameBudgetInfoSelect 쿼리 참조
		 *  */

		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipInfoCopy" );
		cmLog.CommonSetInfo( "! [EX] List<ExExpendSlipVO> slipListVo >> " + slipListVo.toString( ) );
		cmLog.CommonSetInfo( "! [EX] targetListSeq >> " + targetListSeq );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		String listSeq = "";
		try {
			for ( ExExpendSlipVO exExpendSlipVO : slipListVo ) {
				/* 변수정의 */
				/* 변수정의 - 지출결의 항목 분개 */
				ExExpendSlipVO slipVo = new ExExpendSlipVO( );
				/* 변수정의 - 지출결의 항목 분개 관리항목 */
				ExExpendMngVO mngVo = new ExExpendMngVO( );
				/* 변수정의 - 공통코드 */
				ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
				ExCodeAuthVO authVo = new ExCodeAuthVO( );
				ExCodeOrgVO empVo = new ExCodeOrgVO( );
				ExCodeProjectVO projectVo = new ExCodeProjectVO( );
				ExCodePartnerVO partnerVo = new ExCodePartnerVO( );
				ExCodeCardVO cardVo = new ExCodeCardVO( );
				ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( );
				/* 지출결의 항목 분개 소스 조회 */
				slipVo = this.ExSlipInfoSelect( exExpendSlipVO );
				slipVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
				/* 외부연동의 경우 복사 진행 못함! */
				//				if(!slipVo.getInterfaceType( ).equals( commonCode.EMPTYSTR )){
				//					resultVo.setCode( CommonInterface.commonCode.FAIL );
				//					resultVo.setMessage( "외부 시스템 연동의 경우 복사가 불가능 합니다." );
				//					continue;
				//				}
				/* 복사 전 예산체크 진행. */
				/* 해당 Map 반환하면서 예산 초과된 항목들 표시해준다 */
				Map<String, Object> returnResultMap = new HashMap<String, Object>( );
				/* 예산 초과된 항목들 저장하는 List 초과되면 size > 0 */
				List<ExCommonResultVO> returnBudget = new ArrayList<ExCommonResultVO>( );
				List<Map<String, Object>> budgetResult = new ArrayList<Map<String, Object>>( );
				/* 항목에는 여러개의 분개정보가 있을 수 있으므로 리스트로 조회한다. */
				Map<String, Object> param = new HashMap<String, Object>( );
				param.put( "expendSeq", slipVo.getExpendSeq( ) );
				param.put( "listSeq", slipVo.getListSeq( ) );
				param.put( "slipSeq", slipVo.getSlipSeq( ) );
				budgetResult = daoA.ExExpendSlipBudgetInfoSelect( param );
				/* 하위 분개 항목 중 하나라도 초과되는 항목이 있으면 패스한다. */
				for ( Map<String, Object> tBudget : budgetResult ) {
					/* 예산 체크용 파라미터 */
					Map<String, Object> budgetParam = new HashMap<String, Object>( );
					budgetParam.put( "compSeq", loginVo.getCompSeq( ) );
					budgetParam.put( "erpCompSeq", loginVo.getErpCoCd( ) );
					budgetParam.put( "expendSeq", slipVo.getExpendSeq( ) );
					budgetParam.put( "listSeq", slipVo.getListSeq( ) );
					budgetParam.put( "slipSeq", null );
					budgetParam.put( "acctCode", tBudget.get( "bgacctCode" ) );
					budgetParam.put( "budgetCode", tBudget.get( "budgetCode" ) );
					budgetParam.put( "budgetName", tBudget.get( "budgetName" ) );
					budgetParam.put( "bizplanCode", tBudget.get( "bizplanCode" ) );
					budgetParam.put( "bizplanName", tBudget.get( "bizplanName" ) );
					budgetParam.put( "bgacctCode", tBudget.get( "bgacctCode" ) );
					budgetParam.put( "bgacctName", tBudget.get( "bgacctName" ) );
					budgetParam.put( "budgetGbn", tBudget.get( "budgetGbn" ) );
					budgetParam.put( "budgetYm", tBudget.get( "budgetYm" ) );
					/* 해당 항목의 예산 초과 여부 확인 */
					ExCodeBudgetVO tResult = new ExCodeBudgetVO( );
					tResult = budgetService.ExBudgetAmtInfoSelect2( budgetParam );
					/* 위의 함수 실행을 하게되면 ERP금액 및 그룹웨어 금액이 집계가 된다. 또한 결재진행중 문서가 아닌경우는 현재 작성중인 문서의 예산금액까지 집계된다. */
					/* 예산 초과 여부 확인 */
					BigDecimal jsumAmt = new BigDecimal( tResult.getBudgetJsum( ) ); /* 실행금액(그룹웨어 제외) */
					BigDecimal actAmt = new BigDecimal( tResult.getBudgetActsum( ) ); /* 편성금액 */
					BigDecimal basicListAmt = new BigDecimal( tBudget.get( "totalAmt" ).toString( ) ); /* 복사하려고 하는 원본 데이터의 해당 예산금액 합계 */
					jsumAmt = jsumAmt.add( basicListAmt );
					BigDecimal zero = new BigDecimal( commonCode.EMPTYSEQ );
					BigDecimal subTract = new BigDecimal( commonCode.EMPTYSEQ );
					subTract = actAmt.subtract( jsumAmt );
					/* 예산 초과 시 표시 할 내용 저장하는 변수 */
					ExCommonResultVO tempResult = new ExCommonResultVO( );
					switch ( conVo.getErpTypeCode( ) ) {
						case commonCode.ICUBE:
							if ( subTract.compareTo( zero ) == -1 && tResult.getBudgetControlYN( ).equals( "Y" ) ) {
								tempResult.setCode( CommonInterface.commonCode.FAIL );
								tempResult.setMessage( "예산이 초과되어 분개생성이 불가능합니다." );
								tempResult.setMap( tBudget );
								returnBudget.add( tempResult );
								//								return resultVo;
							}
							else if ( tResult.getBudgetControlYN( ).equals( "B" ) ) {
								tempResult.setCode( CommonInterface.commonCode.FAIL );
								tempResult.setMessage( "예산이 미편성되어 분개생성이 불가능합니다." );
								tempResult.setMap( tBudget );
								returnBudget.add( tempResult );
								//								return resultVo;
							}
							break;
						case commonCode.ERPIU:
							if ( subTract.compareTo( zero ) == -1 && tResult.getBudgetControlYN( ).equals( "Y" ) ) {
								tempResult.setCode( CommonInterface.commonCode.FAIL );
								tempResult.setMessage( "예산이 초과되어 분개생성이 불가능합니다." );
								tempResult.setMap( tBudget );
								returnBudget.add( tempResult );
								//								return resultVo;
							}
							break;
						case commonCode.ETC:
							break;
						case commonCode.BIZBOXA:
							break;
						default:
							throw new Exception( "연동시스템 구분이 정의되지 않았습니다." );
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
				if ( slipVo.getSummarySeq( ) != 0 ) {
					/* 표준적요 - 조회 */
					summaryVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					summaryVo.setSeq( slipVo.getSummarySeq( ) );
					summaryVo = exUserCodeService.ExExpendSummaryInfoSelect( summaryVo );
					/* 표준적요 - 생성 */
					summaryVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					summaryVo.setSeq( 0 );
					summaryVo.setCreateSeq( loginVo.getUniqId( ) );
					summaryVo.setModifySeq( loginVo.getUniqId( ) );
					summaryVo = exUserCodeService.ExExpendSummaryInfoInsert( summaryVo );
				}
				else {
					summaryVo.setSeq( 0 );
				}
				/* 증빙유형 */
				if ( slipVo.getAuthSeq( ) != 0 ) {
					/* 증빙유형 - 증빙유형 조회 */
					authVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					authVo.setSeq( slipVo.getAuthSeq( ) );
					authVo = exUserCodeService.ExExpendAuthInfoSelect( authVo );
					/* 증빙유형 -증빙유형 생성 */
					authVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					authVo.setSeq( 0 );
					authVo.setCreateSeq( loginVo.getUniqId( ) );
					authVo.setModifySeq( loginVo.getUniqId( ) );
					authVo = exUserCodeService.ExExpendAuthInfoInsert( authVo );
				}
				else {
					authVo.setSeq( 0 );
				}
				/* 사용자 */
				if ( slipVo.getEmpSeq( ) != 0 ) {
					/* 사용자 - 사용자 조회 */
					empVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					empVo.setSeq( slipVo.getEmpSeq( ) );
					empVo.setGroupSeq( loginVo.getGroupSeq( ) );
					empVo = exUserCodeService.ExExpendEmpInfoSelect( empVo );
					/* 사용자 - 사용자 생성 */
					empVo.setCompName( exExpendSlipVO.getCompSeq( ) );
					empVo.setSeq( 0 );
					empVo.setCreateSeq( loginVo.getUniqId( ) );
					empVo.setModifySeq( loginVo.getUniqId( ) );
					empVo = exUserCodeService.ExExpendEmpInfoInsert( empVo );
				}
				else {
					empVo.setSeq( 0 );
				}
				/* 프로젝트 */
				if ( slipVo.getProjectSeq( ) != 0 ) {
					/* 프로젝트 - 프로젝트 조회 */
					projectVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					projectVo.setSeq( slipVo.getProjectSeq( ) );
					projectVo = exUserCodeService.ExExpendProjectInfoSelect( projectVo );
					/* 프로젝트 - 프로젝트 생성 */
					projectVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					projectVo.setSeq( 0 );
					projectVo.setCreateSeq( loginVo.getUniqId( ) );
					projectVo.setModifySeq( loginVo.getUniqId( ) );
					projectVo = exUserCodeService.ExExpendProjectInfoInsert( projectVo );
				}
				else {
					projectVo.setSeq( 0 );
				}
				/* 거래처 */
				if ( slipVo.getPartnerSeq( ) != 0 ) {
					/* 거래처 - 거래처 조회 */
					partnerVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					partnerVo.setSeq( slipVo.getPartnerSeq( ) );
					partnerVo = exUserCodeService.ExExpendPartnerInfoSelect( partnerVo );
					/* 거래처 - 거래처 생성 */
					partnerVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					partnerVo.setSeq( 0 );
					partnerVo.setCreateSeq( loginVo.getUniqId( ) );
					partnerVo.setModifySeq( loginVo.getUniqId( ) );
					partnerVo = exUserCodeService.ExExpendPartnerInfoInsert( partnerVo );
				}
				else {
					partnerVo.setSeq( 0 );
				}
				/* 카드 */
				if ( slipVo.getCardSeq( ) != 0 ) {
					/* 카드 - 카드 조회 */
					cardVo.setCompSeq( loginVo.getCompSeq( ) );
					cardVo.setSeq( slipVo.getCardSeq( ) );
					cardVo = exUserCodeService.ExExpendCardInfoSelect( cardVo );
					/* 카드 - 카드 생성 */
					cardVo.setCompSeq( loginVo.getCompSeq( ) );
					cardVo.setSeq( 0 );
					cardVo.setCreateSeq( loginVo.getUniqId( ) );
					cardVo.setModifySeq( loginVo.getUniqId( ) );
					cardVo = exUserCodeService.ExExpendCardInfoInsert( cardVo );
				}
				else {
					cardVo.setSeq( 0 );
				}
				/* 예산 */
				if ( slipVo.getBudgetSeq( ) != 0 ) {
					/* 카드 - 예산 조회 */
					budgetVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					budgetVo.setSeq( slipVo.getBudgetSeq( ) );
					budgetVo = exUserCodeService.ExExpendBudgetInfoSelect( budgetVo );
					/* 카드 - 예산 생성 */
					budgetVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
					budgetVo.setSeq( 0 );
					budgetVo.setCreateSeq( loginVo.getUniqId( ) );
					budgetVo.setModifySeq( loginVo.getUniqId( ) );
					budgetVo = exUserCodeService.ExExpendBudgetInfoInsert( budgetVo );
				}
				else {
					budgetVo.setSeq( 0 );
				}
				/* 지출결의 - 지출결의 항목 분개 생성 */
				slipVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
				if ( !targetListSeq.equals( commonCode.EMPTYSTR ) && !targetListSeq.equals( commonCode.EMPTYSEQ ) ) {
					slipVo.setListSeq( targetListSeq );
				}
				slipVo.setSlipSeq( commonCode.EMPTYSEQ );
				slipVo.setCreateSeq( loginVo.getUniqId( ) );
				slipVo.setModifySeq( loginVo.getUniqId( ) );
				slipVo.setSummarySeq( summaryVo.getSeq( ) );
				slipVo.setAuthSeq( authVo.getSeq( ) );
				slipVo.setEmpSeq( empVo.getSeq( ) );
				slipVo.setProjectSeq( projectVo.getSeq( ) );
				slipVo.setPartnerSeq( partnerVo.getSeq( ) );
				slipVo.setCardSeq( cardVo.getSeq( ) );
				slipVo.setBudgetSeq( budgetVo.getSeq( ) );
				//				slipVo.setInterfaceType( commonCode.EMPTYSTR );
				//				slipVo.setInterfaceMId( commonCode.EMPTYSEQ );
				//				slipVo.setInterfaceDId( commonCode.EMPTYSEQ );
				slipVo = this.ExSlipInfoInsert( slipVo );
				/* 지출결의 - 지출겨르이 항목 분개 관리항목 복사 */
				mngVo.setCompSeq( exExpendSlipVO.getCompSeq( ) );
				mngVo.setExpendSeq( exExpendSlipVO.getExpendSeq( ) );
				mngVo.setListSeq( exExpendSlipVO.getListSeq( ) );
				mngVo.setSlipSeq( exExpendSlipVO.getSlipSeq( ) );
				resultVo = exUserMngService.ExMngInfoCopy( mngVo, slipVo.getListSeq( ), slipVo.getSlipSeq( ) );
				if ( resultVo.getCode( ).equals( commonCode.FAIL ) ) {
					throw new Exception( );
				}
				listSeq = slipVo.getListSeq( );
			}
			/* 지출결의 결재중 수정 기능 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				if ( slipListVo.size( ) > 0 ) {
					ExpendVO expendVo = new ExpendVO( );
					expendVo.setExpendSeq( slipListVo.get( 0 ).getExpendSeq( ) );
					expendVo = masterService.ExUserExpendInfoSelect( expendVo );
					if ( !expendVo.getErpSendYN( ).equals( commonCode.EMPTYYES ) && !expendVo.getExpendStatCode( ).equals( "100" ) && !expendVo.getExpendStatCode( ).equals( "999" ) && !expendVo.getExpendStatCode( ).equals( commonCode.EMPTYSTR ) ) {
						//ERPiU 예산넣기(임시데이터 생성) 수정예정
						Map<String, Object> budgetParam = new HashMap<String, Object>( );
						budgetParam.put( "docSeq", expendVo.getDocSeq( ) );
						budgetParam.put( "expendSeq", expendVo.getExpendSeq( ) );
						budgetParam.put( "newListSeq", listSeq );
						budgetService.ExInterLockERPiURowInsert( budgetParam );
					}
				}
			}
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipInfoCopy" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 조회 */
	@Override
	public ExExpendSlipVO ExSlipInfoSelect ( ExExpendSlipVO slipVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		try {
			slipVo = exUserSlipServiceADAO.ExSlipInfoSelect( slipVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipInfoSelect" );
		return slipVo;
	}

	/* 지출결의 - 지출결의 항목 분개 목록 조회 */
	@Override
	public List<ExExpendSlipVO> ExSlipListInfoSelect ( ExExpendSlipVO slipVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
		try {
			slipListVo = exUserSlipServiceADAO.ExSlipListInfoSelect( slipVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		if ( slipListVo != null ) {
			cmLog.CommonSetInfo( "! [EX] List<ExExpendSlipVO> slipListVo >> " + slipListVo.toString( ) );
			cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipListInfoSelect" );
		}
		else {
			cmLog.CommonSetInfo( "! [EX] List<ExExpendSlipVO> slipListVo >> " + null );
			cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipListInfoSelect" );
		}
		return slipListVo;
	}

	/* 지출결의 - 지출결의 항목 분개 목록 조회 */
	@Override
    public List<Map<String, Object>> ExSlipGridInfoSelect ( ExExpendSlipVO slipVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipGridInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = exUserSlipServiceADAO.ExSlipGridInfoSelect( slipVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<Map<String, Object>> result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipGridInfoSelect" );
		return result;
	}

	/* 지출결의 - 지출결의 항목 분개 생성 처리 */
	@Override
    public ExCommonResultVO ExSlipInfoSingleMake ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipInfoSingleMake" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> param >> " + param.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		//		DecimalFormat df = new DecimalFormat( "#.00" );
		try {
			/* 변수정의 */
			ExpendVO expendVo = new ExpendVO( );/* 변수정의 - 지출결의 */
			ExExpendListVO listVo = new ExExpendListVO( );/* 변수정의 - 지출결의 항목 */
			ExExpendSlipVO slipVo = new ExExpendSlipVO( );/* 변수정의 - 지출결의 항목 분개 */
			Map<String, Object> slipInfo = new HashMap<String, Object>( ); /* 변수정의 - 지출결의 항목 분개 관리항목 기초 데이터 */
			ExCodeOrgVO orgVo = new ExCodeOrgVO( ); /* 변수정의 - 사용자 */
			ExCodeAcctVO acctVo = new ExCodeAcctVO( );/* 변수정의 - 계정과목 */
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );/* 변수정의 - 표준적요 */
			ExCodeAuthVO authVo = new ExCodeAuthVO( );/* 변수정의 - 증빙유형 */
			ExCodeProjectVO projectVo = new ExCodeProjectVO( );/* 변수정의 - 프로젝트 */
			ExCodeCardVO cardVo = new ExCodeCardVO( );/* 변수정의 - 카드 */
			ExCodePartnerVO partnerVo = new ExCodePartnerVO( );/* 변수정의 - 거래처 */
			ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( ); /* 변수정의 - 예산 */
			ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO( ); /* 외화정보 */
			//			ExAttachVO attachVo = new ExAttachVO( ); /* 변수정의 - 첨부파일 */
			List<Map<String, Object>> attachVo = new ArrayList<Map<String, Object>>( ); /* 첨부파일 */
			List<Map<String, Object>> delAttachListMap = new ArrayList<Map<String, Object>>( );/* 첨부삭제 파일 */
			/* 초기값 정의 - 첨부삭제 리스트 */
			cmLog.CommonSetInfo( "! [EX] 첨부파일: delAttachList >> " + param.get( "delAttachList" ) );
			cmLog.CommonSetInfo( "! [EX] 첨부파일 size : delAttachListMap >> " + param.get( "delAttachList" ) == null ? "NULL " : "NOT NULL" );
			if ( param.get( "delAttachList" ) != null ) {
				String deleteAttachList = param.get( "delAttachList" ).toString( );
				delAttachListMap = ConvertManager.ConvertJsonToListMap( deleteAttachList );
				cmLog.CommonSetInfo( "! [EX] 첨부파일 내용: delAttachListMap >> " + delAttachListMap.toString( ) );
				cmLog.CommonSetInfo( "! [EX] 첨부파일 size : delAttachListMap >> " + delAttachListMap.size( ) );
			}
			/* 기본값 지정 */
			/* 기본값 지정 - 지출결의 항목 분개 */
			slipVo = (ExExpendSlipVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "slip" ) ), slipVo );
			String modifySeq = EgovStringUtil.isNullToString( param.get( "modifySlipSeq" ) );
			if ( !modifySeq.equals( commonCode.EMPTYSTR ) ) {
				slipVo.setSlipSeq( modifySeq );
			}
			/* 기본값 지정 - 지출결의 */
			expendVo.setExpendSeq( slipVo.getExpendSeq( ) );
			expendVo.setCompSeq( loginVo.getCompSeq( ) );
			expendVo = masterService.ExUserExpendInfoSelect( expendVo );
			/* 기본값 지정 - 지출결의 항목 */
			listVo.setExpendSeq( slipVo.getExpendSeq( ) );
			listVo.setListSeq( slipVo.getListSeq( ) );
			listVo = exUserListService.ExUserListInfoSelect( listVo );
			/* 기본값 지정 - 지출결의 항목 분개 */
			slipVo.setWriteSeq( listVo.getWriteSeq( ) );
			slipVo.setEmpSeq( listVo.getEmpSeq( ) );
			slipVo.setCreateSeq( loginVo.getUniqId( ) );
			slipVo.setModifySeq( loginVo.getUniqId( ) );
			/* 기본값 지정 - 사용자 */
			// 사용자 분개단위 입력인 경우 체크 필요
			orgVo.setCompName( expendVo.getCompSeq( ) );
			orgVo.setSeq( slipVo.getEmpSeq( ) );
			orgVo.setGroupSeq( loginVo.getGroupSeq( ) );
			Map<String, Object> optionParam = new HashMap<String, Object>( );
			optionParam.put( "compSeq", expendVo.getCompSeq( ) );
			optionParam.put( "formSeq", expendVo.getFormSeq( ) );
			optionParam.put( "useSw", conVo.getErpTypeCode( ) );
			optionParam.put( "optionCode", "001002" );
			ResultVO expendOption = configService.ExAdminConfigOptionSelect( optionParam );
			boolean isSlipUserInfo = false;
			if ( expendOption != null && expendOption.getAaData( ).size( ) > 0 ) {
				if ( CommonConvert.CommonGetStr(expendOption.getAaData( ).get( 0 ).get( "set_value" )).equals( "S" ) ) {
					isSlipUserInfo = true;
				}
			}
			else if ( expendOption == null || expendOption.getAaData( ).size( ) == 0 ) { // 기본 옵션 조회(해당 회사, form 에 옵션 저장 안되있는 경우에
				optionParam.put( "compSeq", commonCode.EMPTYSEQ );
				optionParam.put( "formSeq", commonCode.EMPTYSEQ );
				optionParam.put( "useSw", conVo.getErpTypeCode( ) );
				optionParam.put( "optionCode", "001002" );
				expendOption = configService.ExAdminConfigOptionSelect( optionParam );
				if ( CommonConvert.CommonGetStr(expendOption.getAaData( ).get( 0 ).get( "set_value" )).equals( "S" ) ) {
					isSlipUserInfo = true;
				}
			}
			else {
				orgVo = exUserCodeService.ExExpendEmpInfoSelect( orgVo );
			}
			if ( isSlipUserInfo && param.get( "org" ) != null ) {
				// 지출결의 사용자 정보
				orgVo = (ExCodeOrgVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "org" ) ), orgVo );
				orgVo = exUserCodeService.ExExpendEmpInfoInsert( orgVo );
				slipVo.setEmpSeq( orgVo.getSeq( ) );
				slipVo.setWriteSeq( expendVo.getWriteSeq( ) );
			}
			else if ( !isSlipUserInfo && param.get( "org" ) != null ) {
				orgVo = (ExCodeOrgVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "org" ) ), orgVo );
				orgVo = exUserCodeService.ExExpendEmpInfoInsert( orgVo );
				slipVo.setEmpSeq( orgVo.getSeq( ) );
				slipVo.setWriteSeq( expendVo.getWriteSeq( ) );
			}
			/* 기본값 지정 - 표준적요 */
			slipVo.setSummarySeq( listVo.getSummarySeq( ) );
			/* 기본값 지정 - 계정과목 */
			acctVo = (ExCodeAcctVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "acct" ) ), acctVo );
			/* 기본값 지정 - 부가세관련 */
			authVo = (ExCodeAuthVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "auth" ) ), authVo );
			authVo.setCompSeq( expendVo.getCompSeq( ) );
			authVo.setSeq( 0 );
			/* 기본값 지정 - 프로젝트 */
			projectVo = (ExCodeProjectVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "project" ) ), projectVo );
			projectVo.setCompSeq( expendVo.getCompSeq( ) );
			projectVo.setSeq( 0 );
			/* 기본값 지정 - 카드 */
			cardVo = (ExCodeCardVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "card" ) ), cardVo );
			cardVo.setCompSeq( expendVo.getCompSeq( ) );
			cardVo.setSeq( 0 );
			/* 기본값 지정 - 거래처 */
			partnerVo = (ExCodePartnerVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "partner" ) ), partnerVo );
			partnerVo.setCompSeq( expendVo.getCompSeq( ) );
			partnerVo.setSeq( 0 );
			/* 기본값 지정 - 예산 */
			budgetVo = (ExCodeBudgetVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "budget" ) ), budgetVo );
			budgetVo.setCompSeq( expendVo.getCompSeq( ) );
			if ( budgetVo.getErpCompSeq( ).equals( commonCode.EMPTYSTR ) ) {
				budgetVo.setErpCompSeq( orgVo.getErpCompSeq( ) );
			}
			budgetVo.setSeq( 0 );
			/* 기본값 지정 - 외화정보 */
			foreignCurrencyVO = (ExExpendForeignCurrencyVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "foreignCurrency" ) ), foreignCurrencyVO );

			/* 데이터 생성 */
			/* 데이터 생성 - 증빙 */
			if ( !authVo.getVatTypeCode( ).equals( commonCode.EMPTYSTR ) && !authVo.getVatTypeCode( ).equals( commonCode.EMPTYSEQ ) ) {
				authVo.setCreateSeq( loginVo.getUniqId( ) );
				authVo.setModifySeq( loginVo.getUniqId( ) );
				authVo.setAuthDiv( "A" );
				authVo = exUserCodeService.ExExpendAuthInfoInsert( authVo );
				slipVo.setAuthSeq( authVo.getSeq( ) );
			}
			else {
				slipVo.setAuthSeq( listVo.getAuthSeq( ) );
			}
			/* 데이터 생성 - 프로젝트 */
			projectVo.setCreateSeq( loginVo.getUniqId( ) );
			projectVo.setModifySeq( loginVo.getUniqId( ) );
			projectVo = exUserCodeService.ExExpendProjectInfoInsert( projectVo );
			slipVo.setProjectSeq( projectVo.getSeq( ) );
			/* 데이터 생성 - 카드 */
			cardVo.setCreateSeq( loginVo.getUniqId( ) );
			cardVo.setModifySeq( loginVo.getUniqId( ) );
			cardVo = exUserCodeService.ExExpendCardInfoInsert( cardVo );
			slipVo.setCardSeq( cardVo.getSeq( ) );
			/* 데이터 생성 - 거래처 */
			/* 개인번호는 앞 7자리만 저장하고 나머지는 *로 채움 */
			if (partnerVo.getPplNo() != null && !partnerVo.getPplNo().equals(commonCode.EMPTYSTR)) {
				String pplNo = partnerVo.getPplNo().replace("-", commonCode.EMPTYSTR).trim();
				if (pplNo.length() >= 7) {
					pplNo = pplNo.substring(0, 7) + ("********************************").substring(0, pplNo.length() - 7);
					partnerVo.setPplNo(pplNo);
				}
			}
			partnerVo.setCreateSeq( loginVo.getUniqId( ) );
			partnerVo.setModifySeq( loginVo.getUniqId( ) );
			partnerVo = exUserCodeService.ExExpendPartnerInfoInsert( partnerVo );
			slipVo.setPartnerSeq( partnerVo.getSeq( ) );
			/* 초기값 정의 - 첨부 */
			//			attachVo = (ExAttachVO) ConvertManager.ConvertMapToObject( (Map<String, Object>) ConvertManager.ConvertJsonToMap( (String) param.get( "attach" ) ), attachVo );
			attachVo = CommonConvert.CommonGetJSONToListMap( (param.get( "attach" ) == null ? "[]" : param.get( "attach" ).toString( )) );
			//			attachVo.setCreate_seq( loginVo.getUniqId( ) );
			//			attachVo.setModify_seq( loginVo.getUniqId( ) );
			//			attachVo.setExpend_seq( slipVo.getExpendSeq( ) );
			//			attachVo.setList_seq( slipVo.getListSeq( ) );
			//			attachVo.setSlip_seq( slipVo.getSlipSeq( ) );
			/* 데이터 생성 - 예산 */
			if ( slipVo.getDrcrGbn( ).equals( "dr" ) ) {
				optionParam.put( "compSeq", expendVo.getCompSeq( ) );
				optionParam.put( "formSeq", expendVo.getFormSeq( ) );
				optionParam.put( "useSw", conVo.getErpTypeCode( ) );
				optionParam.put( "optionCode", "003301" );
				expendOption = configService.ExAdminConfigOptionSelect( optionParam );
				if ( expendOption != null && expendOption.getAaData( ).size( ) > 0 ) {
					if ( CommonConvert.CommonGetStr(expendOption.getAaData( ).get( 0 ).get( "set_value" )).equals( commonCode.EMPTYYES ) ) {
						/* 예산체크 진행 */
						switch ( conVo.getErpTypeCode( ) ) {
							case commonCode.ICUBE:
								if ( budgetVo.getBgacctCode( ).equals( commonCode.EMPTYSEQ ) || budgetVo.getBgacctCode( ).equals( commonCode.EMPTYSTR ) ) {
									budgetVo.setBgacctCode( slipVo.getAcctCode( ) );
									budgetVo.setBgacctName( slipVo.getAcctName( ) );
								}
								ExCodeBudgetVO iCUBEBudgetVo = new ExCodeBudgetVO( );
								iCUBEBudgetVo.setBudYm( budgetVo.getBudgetYm( ) );
								iCUBEBudgetVo.setCompSeq( budgetVo.getCompSeq( ) );
								iCUBEBudgetVo.setErpCompSeq( budgetVo.getErpCompSeq( ) );
								iCUBEBudgetVo.setBudgetCode( budgetVo.getBudgetCode( ) );
								iCUBEBudgetVo.setBgacctCode( budgetVo.getBgacctCode( ) );
								iCUBEBudgetVo = exBudgetServiceI.ExBudgetAmtInfoSelect( iCUBEBudgetVo, conVo );
								if ( budgetVo.getBudgetType( ).equals( commonCode.EMPTYSTR ) ) {
									budgetVo.setBudgetType( commonCode.ICUBE );
								}
								budgetVo.setBudYm( iCUBEBudgetVo.getBudYm( ) );
								budgetVo.setBudgetJsum( iCUBEBudgetVo.getBudgetJsum( ) );
								budgetVo.setBudgetActsum( iCUBEBudgetVo.getBudgetActsum( ) );
								budgetVo.setDracctAmt( slipVo.getAmt( ) );
								if ( budgetVo.getBudgetYm( ).length( ) > 6 ) {
									budgetVo.setBudgetYm( budgetVo.getBudgetYm( ).substring( 0, 6 ) );
								}
								else {
									budgetVo.setBudgetYm( budgetVo.getBudgetYm( ) );
								}
								//								budgetVo = exUserCodeService.ExCodeBudgetAmtInfoSelect( budgetVo, conVo );
								break;
							case commonCode.ERPIU:
								ExCodeBudgetVO eRPiUBudgetVo = new ExCodeBudgetVO( );
								eRPiUBudgetVo.setBudgetYm( budgetVo.getBudgetYm( ) );
								eRPiUBudgetVo.setCompSeq( budgetVo.getCompSeq( ) );
								eRPiUBudgetVo.setErpCompSeq( budgetVo.getErpCompSeq( ) );
								eRPiUBudgetVo.setBudgetCode( budgetVo.getBudgetCode( ) );
								eRPiUBudgetVo.setBgacctCode( budgetVo.getBgacctCode( ) );
								if ( budgetVo.getBizplanCode( ).equals( "*" ) || budgetVo.getBizplanCode( ).equals( commonCode.EMPTYSEQ ) || budgetVo.getBizplanCode( ).equals( commonCode.EMPTYSTR ) ) {
									eRPiUBudgetVo.setBizplanCode( "***" );
								}
								else {
									eRPiUBudgetVo.setBizplanCode( budgetVo.getBizplanCode( ) );
								}
								eRPiUBudgetVo = exBudgetServiceU.ExBudgetAmtInfoSelect( eRPiUBudgetVo, conVo );
								if ( budgetVo.getBudgetType( ).equals( commonCode.EMPTYSTR ) ) {
									budgetVo.setBudgetType( commonCode.ERPIU );
								}
								budgetVo.setBudYm( eRPiUBudgetVo.getBudYm( ) );
								budgetVo.setBudgetYm( eRPiUBudgetVo.getBudgetYm( ) );
								budgetVo.setBudgetJsum( eRPiUBudgetVo.getBudgetJsum( ) );
								budgetVo.setBudgetActsum( eRPiUBudgetVo.getBudgetActsum( ) );
								budgetVo.setBudgetControlYN( eRPiUBudgetVo.getBudgetControlYN( ) );
								budgetVo.setDracctAmt( slipVo.getAmt( ) );
								break;
							default :
								break;
						}
						/* 예산 정보 등록 */
						budgetVo.setCreateSeq( loginVo.getUniqId( ) );
						budgetVo.setModifySeq( loginVo.getUniqId( ) );
						budgetVo = exUserCodeService.ExExpendBudgetInfoInsert( budgetVo );
						slipVo.setBudgetSeq( budgetVo.getSeq( ) );
					}
				}
			}
			else {
				slipVo.setBudgetSeq( 0 );
			}
			/* 데이터 생성 - 외화정보 */
			slipVo.setExchangeUnitCode(foreignCurrencyVO.getExchangeUnitCode()); // 환종코드
			slipVo.setExchangeUnitName(foreignCurrencyVO.getExchangeUnitName()); // 환종명
			slipVo.setExchangeRate(foreignCurrencyVO.getExchangeRate()); // 환율
			slipVo.setForeignCurrencyAmount(foreignCurrencyVO.getForeignCurrencyAmount()); // 외화금액
			slipVo.setForeignAcctYN(foreignCurrencyVO.getForeignAcctYN()); // 외화금액
			/* 데이터 생성 - 지출결의 항목 분개 */
			slipVo = this.ExSlipInfoInsert( slipVo );
			/* 첨부파일 생성 */
			//			attachVo.setList_seq( slipVo.getListSeq( ) );
			//			String file_exist_count = commonCode.EMPTYSEQ;
			//			file_exist_count = exUserSlipServiceADAO.ExSlipExistAttachInfoSelect( attachVo );
			//			if ( attachVo.getType( ).equals( "slip" ) && file_exist_count.equals( commonCode.EMPTYSEQ ) ) {
			//				exUserSlipServiceADAO.ExSlipAttachInfoInsert( attachVo );
			//			}
			boolean isDeleted = false;
			for ( Map<String, Object> tAttach : attachVo ) {
				/* 기존의 첨부파일 정보 삭제처리 진행 */
				tAttach.put( commonCode.EXPENDSEQ, slipVo.getExpendSeq( ) );
				boolean isNewAttach = true;
				if ( tAttach.get( "list_seq" ) != null ) {
					tAttach.put( commonCode.LISTSEQ, tAttach.get( "list_seq" ).toString( ) );
				}
				if ( tAttach.get( "slip_seq" ) != null ) {
					tAttach.put( commonCode.SLIPSEQ, tAttach.get( "slip_seq" ).toString( ) );
					isNewAttach = false;
				}
				/* 기존 첨부파일 삭제는 최초 한번만 진행하며, 기존 첨부파일이 있어야만 삭제가 가능하다. */
				if ( !isNewAttach && !isDeleted ) {
					if ( !exUserSlipServiceADAO.ExExpendSliptAttachListInfoDelete( tAttach ) ) {
						continue;
					}
					else {
						isDeleted = true;
					}
				}
				/* 첨부파일 등록 */
				ExAttachVO tAttachVo = new ExAttachVO( );
				tAttachVo.setType( tAttach.get( "type" ).toString( ) );
				tAttachVo.setExpend_seq( slipVo.getExpendSeq( ) );
				tAttachVo.setList_seq( slipVo.getListSeq( ) );
				tAttachVo.setSlip_seq( slipVo.getSlipSeq( ) );
				tAttachVo.setFile_seq( tAttach.get( "file_seq" ).toString( ) );
				if ( tAttach.get( "create_seq" ) != null && tAttach.get( "create_seq" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
					tAttachVo.setCreate_seq( tAttach.get( "create_seq" ).toString( ) );
				}
				else {
					tAttachVo.setCreate_seq( loginVo.getUniqId( ) );
				}
				tAttachVo.setModify_seq( loginVo.getUniqId( ) );
				exUserSlipServiceADAO.ExSlipAttachInfoInsert( tAttachVo );
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
					deleteFileMap.put( "expendSeq", slipVo.getExpendSeq( ) );
					deleteFileMap.put( "listSeq", slipVo.getListSeq( ) );
					deleteFileMap.put( "slipSeq", slipVo.getSlipSeq( ) );
					exUserSlipServiceADAO.ExLSlipAttachInfoDelete( deleteFileMap );
				}
			}
			/* 데이터 생성 - 지출결의 항목 분개 관리항목 */
			slipInfo.put( "expend", CommonConvert.CommonGetObjectToMap( expendVo ) );
			slipInfo.put( "list", CommonConvert.CommonGetObjectToMap( listVo ) );
			slipInfo.put( "slip", CommonConvert.CommonGetObjectToMap( slipVo ) );
			slipInfo.put( "auth", CommonConvert.CommonGetObjectToMap( authVo ) );
			slipInfo.put( "summary", CommonConvert.CommonGetObjectToMap( summaryVo ) );
			slipInfo.put( "partner", CommonConvert.CommonGetObjectToMap( partnerVo ) );
			slipInfo.put( "project", CommonConvert.CommonGetObjectToMap( projectVo ) );
			slipInfo.put( "card", CommonConvert.CommonGetObjectToMap( cardVo ) );
			slipInfo.put( "emp", CommonConvert.CommonGetObjectToMap( orgVo ) );
			slipInfo.put( "budget", CommonConvert.CommonGetObjectToMap( budgetVo ) );
			resultVo = exUserMngService.ExMngInfoMake( loginVo, slipInfo, conVo );
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			resultVo.setExpendSeq( slipVo.getExpendSeq( ) );
			resultVo.setListSeq( slipVo.getListSeq( ) );
			resultVo.setSlipSeq( slipVo.getSlipSeq( ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipInfoSingleMake" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 처리 */
	@Override
    @SuppressWarnings ( "unchecked" )
	public ExCommonResultVO ExSlipInfoMake ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipInfoMake" );
		cmLog.CommonSetInfo( "! [EX] Map<String, Object> param >> " + param.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		//		DecimalFormat df = new DecimalFormat( "#.00" );
		try {
			/* 변수정의 */
			ExExpendSlipVO drVo = new ExExpendSlipVO( ); /* 지출결의 항목 차변 */
			ExExpendSlipVO vatVo = new ExExpendSlipVO( ); /* 지출결의 항목 부가세 */
			ExExpendSlipVO crVo = new ExExpendSlipVO( ); /* 지출결의 항목 대변 */
			Boolean vatFlag = false;
			ExExpendVO expendVo = new ExExpendVO( ); /* 지출결의 */
			ExExpendListVO listVo = new ExExpendListVO( ); /* 지출결의 항목 */
			ExCodeOrgVO orgVo = new ExCodeOrgVO( ); /* 지출결의 사용자 */
			ExCodeAuthVO authVo = new ExCodeAuthVO( ); /* 지출결의 증빙유형 */
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( ); /* 지출결의 표준적요 */
			ExCodePartnerVO partnerVo = new ExCodePartnerVO( ); /* 지출결의 거래처 */
			ExCodeProjectVO projectVo = new ExCodeProjectVO( ); /* 지출결의 프로젝트 */
			ExCodeCardVO cardVo = new ExCodeCardVO( ); /* 지출결의 카드 */
			ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( ); /* 지출결의 예산정보 */
			//			ExAttachVO attachVo = new ExAttachVO( );
			//			List<Map<String, Object>> attachVo = new ArrayList<Map<String, Object>>( ); /* 첨부파일 */
			Map<String, Object> drInfo = new HashMap<String, Object>( );
			Map<String, Object> vatInfo = new HashMap<String, Object>( );
			Map<String, Object> crInfo = new HashMap<String, Object>( );
			/* 초기값 정의 */
			/* 초기값 정의 - 지출결의 */
			expendVo = (ExExpendVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "expend" ), expendVo );
			/* 초기값 정의 - 지출결의 항목 */
			listVo = (ExExpendListVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "list" ), listVo );
			/* 초기값 지정 - 사용자 */
			orgVo.setSeq( listVo.getEmpSeq( ) );
			orgVo.setGroupSeq( loginVo.getGroupSeq( ) );
			orgVo = exUserCodeService.ExExpendEmpInfoSelect( orgVo );
			/* 초기값 정의 - 증빙유형 */
			authVo = (ExCodeAuthVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "auth" ), authVo );
			/* 초기값 정의 - 표준적요 */
			summaryVo = (ExCodeSummaryVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "summary" ), summaryVo );
			/* 초기값 정의 - 거래처 */
			partnerVo = (ExCodePartnerVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "partner" ), partnerVo );
			/* 초기값 정의 - 프로젝트 */
			projectVo = (ExCodeProjectVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "project" ), projectVo );
			/* 초기값 정의 - 카드 */
			cardVo = (ExCodeCardVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "card" ), cardVo );
			/* 초기값 정의 - 예산 */
			budgetVo = (ExCodeBudgetVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "budget" ), budgetVo );
			if ( budgetVo.getErpCompSeq( ).equals( commonCode.EMPTYSTR ) ) {
				budgetVo.setErpCompSeq( orgVo.getErpCompSeq( ) );
			}
			/* 초기값 정의 - 첨부 */
			//			attachVo = (ExAttachVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "attach" ), attachVo );
			//			attachVo = (List<Map<String, Object>>) param.get( "attach" );

			/*
			   항목추가, 카드사용내역, 매입세금계산서로 인해 생성된 분개정보의 경우 외화정보를 수정하지 못하도록
			   외화계정 여부를 N으로 넣어준다.(수정 할 경우 분개정보의 금액과 외화정보의 금액이 서로 맞지 않기 때문이다.)
			*/
			listVo.setForeignAcctYN("N");

			/* 초기값 정의 - 차변 */
			drVo.setDr(listVo, loginVo);
			drVo.setAcctCode( summaryVo.getDrAcctCode( ) );
			drVo.setAcctName( summaryVo.getDrAcctName( ) );
			/* 초기값 정의 - 부가세 */
			vatVo.setVat( listVo, loginVo );
			vatVo.setAcctCode( authVo.getVatAcctCode( ) == commonCode.EMPTYSTR ? summaryVo.getVatAcctCode( ) : authVo.getVatAcctCode( ) );
			vatVo.setAcctName( authVo.getVatAcctName( ) == commonCode.EMPTYSTR ? summaryVo.getVatAcctName( ) : authVo.getVatAcctName( ) );
			/* 초기값 정의 - 대변 */
			crVo.setCr( listVo, loginVo );
			crVo.setAcctCode( authVo.getCrAcctCode( ) == commonCode.EMPTYSTR ? summaryVo.getCrAcctCode( ) : authVo.getCrAcctCode( ) );
			crVo.setAcctName( authVo.getCrAcctName( ) == commonCode.EMPTYSTR ? summaryVo.getCrAcctName( ) : authVo.getCrAcctName( ) );
			// 항목 추가에서 카드 정보 입력한 경우는 대변의 거래처정보를 카드정보에 맞춰서 생성해준다.
			ExCodePartnerVO crPartner = new ExCodePartnerVO( );
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) || CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				if ( cardVo != null && !cardVo.getPartnerCode( ).equals( commonCode.EMPTYSTR ) ) {
					crPartner.setPartnerCode( cardVo.getPartnerCode( ) );
					crPartner.setPartnerName( cardVo.getPartnerName( ) );
					crPartner.setCreateSeq( loginVo.getUniqId( ) );
					crPartner.setModifySeq( loginVo.getUniqId( ) );
					crPartner.setCompSeq( partnerVo.getCompSeq( ) );
					crPartner.setErpCompSeq( partnerVo.getErpCompSeq( ) );
					crPartner.setPartnerFg( partnerVo.getPartnerFg( ) );
					crPartner.setFormSeq( partnerVo.getFormSeq( ) );
					/* ERPiU의 경우 금융거래처 정보를 한번 더 조회한다 */
					if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
						Map<String, Object> tParam = new HashMap<String, Object>( );
						tParam.put( commonCode.ERPCOMPSEQ, loginVo.getErpCoCd( ) );
						tParam.put( "searchStr", cardVo.getPartnerCode( ) );
						tParam.put( "searchType", "002" );
						tParam.put( commonCode.CODETYPE, commonCode.PARTNER );
						tParam.put( "groupSeq", loginVo.getGroupSeq( ) );
						ResultVO crResult = new ResultVO( );
						crResult = exUserCodeService.ExCommonCodeInfoSelect( tParam );
						if ( crResult.getAaData( ) != null && crResult.getAaData( ).size( ) > 0 ) {
							for ( Map<String, Object> tCrResult : crResult.getAaData( ) ) {
								if ( tCrResult.get( "partnerCode" ).toString( ).equals( crPartner.getPartnerCode( ) ) && tCrResult.get( "partnerName" ).toString( ).equals( crPartner.getPartnerName( ) ) ) {
									crPartner.setDepositName( tCrResult.get( "depositName" ).toString( ) );
									crPartner.setDepositConvert( tCrResult.get( "depositConvert" ).toString( ) );
									crPartner.setDepositCd( tCrResult.get( "depositCd" ).toString( ) );
									break;
								}
							}
						}
					}
					crPartner = exUserCodeService.ExExpendPartnerInfoInsert( crPartner );
					crVo.setPartnerSeq( crPartner.getSeq( ) );
				}
			}
			/* 데이터 생성 */
			/* 데이터 생성 - 차변 */
			/* 데이터 생성 - 예산 */
			param.put( "optionCode", "003301" );
			param.put( "compSeq", expendVo.getCompSeq( ) );
			param.put( "formSeq", expendVo.getFormSeq( ) );
			param.put( "useSw", conVo.getErpTypeCode( ) );
			ResultVO expendOption = configService.ExAdminConfigOptionSelect( param );
			if ( expendOption != null && expendOption.getAaData( ).size( ) > 0 ) {
				if ( CommonConvert.CommonGetStr(expendOption.getAaData( ).get( 0 ).get( "set_value" )).equals( commonCode.EMPTYYES ) ) {
					/* 예산 넣기 진행 */
					switch ( conVo.getErpTypeCode( ) ) {
						case commonCode.ICUBE:
							if ( budgetVo.getBgacctCode( ).equals( commonCode.EMPTYSEQ ) || budgetVo.getBgacctCode( ).equals( commonCode.EMPTYSTR ) ) {
								budgetVo.setBgacctCode( summaryVo.getDrAcctCode( ) );
								budgetVo.setBgacctName( summaryVo.getDrAcctName( ) );
							}
							ExCodeBudgetVO iCUBEBudgetVo = new ExCodeBudgetVO( );
							iCUBEBudgetVo.setBudYm( budgetVo.getBudgetYm( ) );
							iCUBEBudgetVo.setCompSeq( budgetVo.getCompSeq( ) );
							iCUBEBudgetVo.setErpCompSeq( budgetVo.getErpCompSeq( ) );
							iCUBEBudgetVo.setBudgetCode( budgetVo.getBudgetCode( ) );
							iCUBEBudgetVo.setBgacctCode( budgetVo.getBgacctCode( ) );
							iCUBEBudgetVo = exBudgetServiceI.ExBudgetAmtInfoSelect( iCUBEBudgetVo, conVo );
							if ( budgetVo.getBudgetType( ).equals( commonCode.EMPTYSTR ) ) {
								budgetVo.setBudgetType( commonCode.ICUBE );
							}
							budgetVo.setBudgetControlYN( iCUBEBudgetVo.getBudgetControlYN( ) );
							budgetVo.setBudYm( iCUBEBudgetVo.getBudYm( ) );
							budgetVo.setBudgetJsum( iCUBEBudgetVo.getBudgetJsum( ) );
							budgetVo.setBudgetActsum( iCUBEBudgetVo.getBudgetActsum( ) );
							budgetVo.setDracctAmt( drVo.getAmt( ) );
							break;
						case commonCode.ERPIU:
							ExCodeBudgetVO eRPiUBudgetVo = new ExCodeBudgetVO( );
							eRPiUBudgetVo.setBudgetYm( budgetVo.getBudgetYm( ) );
							eRPiUBudgetVo.setCompSeq( budgetVo.getCompSeq( ) );
							eRPiUBudgetVo.setErpCompSeq( budgetVo.getErpCompSeq( ) );
							eRPiUBudgetVo.setBudgetCode( budgetVo.getBudgetCode( ) );
							eRPiUBudgetVo.setBgacctCode( budgetVo.getBgacctCode( ) );
							if ( budgetVo.getBizplanCode( ).equals( "*" ) || budgetVo.getBizplanCode( ).equals( commonCode.EMPTYSEQ ) || budgetVo.getBizplanCode( ).equals( commonCode.EMPTYSTR ) ) {
								eRPiUBudgetVo.setBizplanCode( "***" );
							}
							else {
								eRPiUBudgetVo.setBizplanCode( budgetVo.getBizplanCode( ) );
							}

							eRPiUBudgetVo = exBudgetServiceU.ExBudgetAmtInfoSelect( eRPiUBudgetVo, conVo );
							if ( budgetVo.getBudgetType( ).equals( commonCode.EMPTYSTR ) ) {
								budgetVo.setBudgetType( commonCode.ERPIU );
							}
							budgetVo.setBudYm( eRPiUBudgetVo.getBudYm( ) );
							budgetVo.setBudgetYm( eRPiUBudgetVo.getBudgetYm( ) );
							budgetVo.setBudgetJsum( eRPiUBudgetVo.getBudgetJsum( ) );
							budgetVo.setBudgetActsum( eRPiUBudgetVo.getBudgetActsum( ) );
							budgetVo.setBudgetControlYN( eRPiUBudgetVo.getBudgetControlYN( ) );
							budgetVo.setDracctAmt( drVo.getAmt( ) );
							break;
						default :
							break;
					}
					/* 예산 정보 등록 */
					budgetVo = exUserCodeService.ExExpendBudgetInfoInsert( budgetVo );
					drVo.setBudgetSeq( budgetVo.getSeq( ) );
				}
			}
			drVo = this.ExSlipInfoInsert( drVo );
			/* 데이터 생성 - 부가세 */
			/* 데이터 생성 - 부가세 - BizboxA, iCUBE, ERPiU 부가세 생성 프로세스 */
			/* 데이터 생성 - 부가세 - [!주의사항] 프로세스를 단순화 하기 위하여, 증빙유형 또는 표준적요에 부가세 계정이 있는 경우에만 처리 - 부가세가 안나와요? 부가세 계정 맵핑 또는 부가세 대체 계정 맵핑해 주세요! / 기존 세무구분에 따른 처리는 별도로 하지 않는다. */
			/* 데이터 생성 - 부가세 - 증빙유형에 부가세 대체계정이 존재하는가? */
			if ( !authVo.getVatAcctCode( ).equals( commonCode.EMPTYSTR ) ) {
				vatFlag = true;
			}
			/* 데이터 생성 - 부가세 - 표준적요에 부가세 계정이 존재하는가? */
			else if ( !summaryVo.getVatAcctCode( ).equals( commonCode.EMPTYSTR ) ) {
				vatFlag = true;
			}
			if ( vatFlag ) {
				vatVo = this.ExSlipInfoInsert( vatVo );
			}
			/* 데이터 생성 - 대변 */
			crVo = this.ExSlipInfoInsert( crVo );
			/* 데이터 생성 - 관리항목 파라미터 */
			/* 데이터 생성 - 관리항목 파라미터 - 차변 */
			drInfo.put( "expend", CommonConvert.CommonGetObjectToMap( expendVo ) );
			drInfo.put( "list", CommonConvert.CommonGetObjectToMap( listVo ) );
			drInfo.put( "slip", CommonConvert.CommonGetObjectToMap( drVo ) );
			drInfo.put( "auth", CommonConvert.CommonGetObjectToMap( authVo ) );
			drInfo.put( "summary", CommonConvert.CommonGetObjectToMap( summaryVo ) );
			drInfo.put( "partner", CommonConvert.CommonGetObjectToMap( partnerVo ) );
			drInfo.put( "project", CommonConvert.CommonGetObjectToMap( projectVo ) );
			drInfo.put( "card", CommonConvert.CommonGetObjectToMap( cardVo ) );
			drInfo.put( "emp", CommonConvert.CommonGetObjectToMap( orgVo ) );
			drInfo.put( "budget", CommonConvert.CommonGetObjectToMap( budgetVo ) );
			/* 데이터 생성 - 관리항목 파라미터 - 부가세 */
			vatInfo.put( "expend", CommonConvert.CommonGetObjectToMap( expendVo ) );
			vatInfo.put( "list", CommonConvert.CommonGetObjectToMap( listVo ) );
			vatInfo.put( "slip", CommonConvert.CommonGetObjectToMap( vatVo ) );
			vatInfo.put( "auth", CommonConvert.CommonGetObjectToMap( authVo ) );
			vatInfo.put( "summary", CommonConvert.CommonGetObjectToMap( summaryVo ) );
			vatInfo.put( "partner", CommonConvert.CommonGetObjectToMap( partnerVo ) );
			vatInfo.put( "project", CommonConvert.CommonGetObjectToMap( projectVo ) );
			vatInfo.put( "card", CommonConvert.CommonGetObjectToMap( cardVo ) );
			vatInfo.put( "emp", CommonConvert.CommonGetObjectToMap( orgVo ) );
			vatInfo.put( "budget", CommonConvert.CommonGetObjectToMap( budgetVo ) );
			/* 데이터 생성 - 관리항목 파라미터 - 대변 */
			crInfo.put( "expend", CommonConvert.CommonGetObjectToMap( expendVo ) );
			crInfo.put( "list", CommonConvert.CommonGetObjectToMap( listVo ) );
			crInfo.put( "slip", CommonConvert.CommonGetObjectToMap( crVo ) );
			crInfo.put( "auth", CommonConvert.CommonGetObjectToMap( authVo ) );
			crInfo.put( "summary", CommonConvert.CommonGetObjectToMap( summaryVo ) );
			crInfo.put( "partner", CommonConvert.CommonGetObjectToMap( partnerVo ) );
			// 항목 추가에서 카드 정보 입력한 경우는 대변의 거래처정보를 카드정보에 맞춰서 생성해준다.
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) || CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				if ( cardVo != null && !cardVo.getPartnerCode( ).equals( commonCode.EMPTYSTR ) ) {
					crInfo.put( "partner", CommonConvert.CommonGetObjectToMap( crPartner ) );
				}
			}
			crInfo.put( "project", CommonConvert.CommonGetObjectToMap( projectVo ) );
			crInfo.put( "card", CommonConvert.CommonGetObjectToMap( cardVo ) );
			crInfo.put( "emp", CommonConvert.CommonGetObjectToMap( orgVo ) );
			crInfo.put( "budget", CommonConvert.CommonGetObjectToMap( budgetVo ) );
			/* 데이터 생성 - 관리항목 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.BIZBOXA ) ) {
				/* 연동시스템별 예외처리 */
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				/* 연동시스템별 예외처리 */
				/* 데이터 생성 - 관리항목 - 차변 */
				resultVo = exUserMngService.ExMngInfoMake( loginVo, drInfo, conVo );
				/* 데이터 생성 - 관리항목 - 부가세 */
				if ( vatFlag ) {
					resultVo = exUserMngService.ExMngInfoMake( loginVo, vatInfo, conVo );
				}
				/* 데이터 생성 - 관리항목 - 대변 */
				resultVo = exUserMngService.ExMngInfoMake( loginVo, crInfo, conVo );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				/* 연동시스템별 예외처리 */
				/* 데이터 생성 - 관리항목 - 차변 */
				resultVo = exUserMngService.ExMngInfoMake( loginVo, drInfo, conVo );
				/* 데이터 생성 - 관리항목 - 부가세 */
				if ( vatFlag ) {
					resultVo = exUserMngService.ExMngInfoMake( loginVo, vatInfo, conVo );
				}
				/* 데이터 생성 - 관리항목 - 대변 */
				resultVo = exUserMngService.ExMngInfoMake( loginVo, crInfo, conVo );
			}
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipInfoMake" );
		return resultVo;
	}

	/* 예산 */
	/* 예산 - 지출결의 임시예산 등록 연동 */
	@Override
    public ExCommonResultVO ExSlipBudgetInfoUpdate ( ExExpendSlipVO slipVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExSlipBudgetInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExExpendSlipVO slipVo >> " + slipVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exUserSlipServiceADAO.ExSlipBudgetInfoUpdate( slipVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExSlipBudgetInfoUpdate" );
		return resultVo;
	}

	/* 인터페이스 */
	/* 인터페이스 - 법인카드 사용내역 조회 */
	@Override
    public List<ExExpendSlipVO> ExInterfaceCardListInfoSelect ( ExExpendVO expendVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExInterfaceCardListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + expendVo.toString( ) );
		List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
		try {
			slipListVo = exUserSlipServiceADAO.ExInterfaceCardListInfoSelect( expendVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExExpendSlipVO> slipListVo >> " + slipListVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExInterfaceCardListInfoSelect" );
		return slipListVo;
	}

	/* 인터페이스 - 매입전자세금계산서 사용내역 조회 */
	@Override
    public List<ExExpendSlipVO> ExInterfaceETaxListInfoSelect ( ExExpendVO expendVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendSlipService - ExInterfaceETaxListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + expendVo.toString( ) );
		List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
		try {
			slipListVo = exUserSlipServiceADAO.ExInterfaceETaxListInfoSelect( expendVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExExpendSlipVO> slipListVo >> " + slipListVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendSlipService - ExInterfaceETaxListInfoSelect" );
		return slipListVo;
	}

	/* 파라메터 필수 expend_seq, list_seq group_seq */
	@Override
    public List<ExAttachVO> ExSlipAttachInfoSelect ( Map<String, Object> params ) throws Exception {
		List<ExAttachVO> attachList = new ArrayList<ExAttachVO>( );
		//파일아이디 가져오기
		cmLog.CommonSetInfo( "+ [EX] ExExpendListService - ExListAttachInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] Map<String,Object>params >> " + params.toString( ) );
		try {
			params.put( "type", "slip" );
			List<String> fileIdsList = new ArrayList<String>( );
			fileIdsList = exUserSlipServiceADAO.ExSlipAttchFileIDInfoSelect( params );
			//파일아이디가 존재한다면 파일정보를 가져온다.
			String fileIdList = commonCode.EMPTYSTR;
			for ( String item : fileIdsList ) {
				fileIdList = fileIdList + "\'" + item + "\'" + ",";
			}
			if ( fileIdsList.size( ) != 0 ) {
				params.put( "file_seq", fileIdList.substring( 0, fileIdList.length( ) - 1 ) );
				params.put( "os_type", CommonUtil.osType( ) );
				attachList = exUserSlipServiceADAO.ExSlipAttchInfoSelect( params );
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

	@Override
    public ExCommonResultVO ExSlipInfoSingleMakeApproval ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* 변수 정의 */
		ExpendVO expendVo = new ExpendVO( );
		ExExpendSlipVO baseSlipInfo = new ExExpendSlipVO( ); // 기존 분개 정보
		ExExpendSlipVO editSlipInfo = new ExExpendSlipVO( ); // 신구 분개 정보
		String slipModifyYN = "";
		String revisionHistory = "";
		String lineChange = System.getProperty( "line.separator" );
		//분개 수정 여부 확인
		slipModifyYN = EgovStringUtil.isNullToString( param.get( "modify" ) );
		// 기존 항목 정보 조회
		CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetJSONToMap( (String) param.get( "slip" ) ), baseSlipInfo );
		/* 초기값 정의 - 지출결의 */
		expendVo.setExpendSeq( baseSlipInfo.getExpendSeq( ) );
		expendVo = masterService.ExUserExpendInfoSelect( expendVo );
		if ( slipModifyYN.equals( commonCode.EMPTYYES ) ) {
			baseSlipInfo = this.ExSlipInfoSelect( baseSlipInfo );
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) && (param.get( "isUseBudget" ) == null || Boolean.parseBoolean( param.get( "isUseBudget" ).toString( ) )) ) {
				revisionHistory += ("기존 slipSeq/rowId/rowNo : " + baseSlipInfo.getSlipSeq( ) + "/" + baseSlipInfo.getRowId( ) + "/" + baseSlipInfo.getRowNo( ) + lineChange);
				/* 신규 예산정보 입력(slip에 있는 row_id, ERPiU의 gmm_sum_id) */
				//ERPiU 예산넣기(임시데이터 생성) 수정예정
				Map<String, Object> budgetParam = new HashMap<String, Object>( );
				budgetParam.put( "docSeq", expendVo.getDocSeq( ) );
				budgetParam.put( "expendSeq", expendVo.getExpendSeq( ) );
				/* 기존 예산정보 삭제(slip에 있는 row_id, ERPiU의 gmm_sum_id) 수정예정 */
				budgetParam.put( "newListSeq", baseSlipInfo.getListSeq( ) );
				budgetParam.put( "newSlipSeq", baseSlipInfo.getSlipSeq( ) );
				budgetParam.put( "isEditList", true );
				budgetService.ExInterLockERPiURowDelete( budgetParam );
			}
			// 분개삭제 수행
			ExExpendSlipVO slipVo = new ExExpendSlipVO( );
			slipVo.setCompSeq( baseSlipInfo.getCompSeq( ) );
			slipVo.setExpendSeq( baseSlipInfo.getExpendSeq( ) );
			slipVo.setListSeq( baseSlipInfo.getListSeq( ) );
			slipVo.setSlipSeq( baseSlipInfo.getSlipSeq( ) );
			resultVo = this.ExSlipInfoDelete( slipVo );
			if ( !resultVo.getCode( ).equals( CommonInterface.commonCode.SUCCESS ) ) {
				throw new Exception( BizboxAMessage.getMessage( "TX000009275", "항목 삭제에 실패하였습니다" ) );
			}
		}
		// 신규 항목 생성
		resultVo = this.ExSlipInfoSingleMake( loginVo, param, conVo );
		// 신규 항목 정보 조회
		editSlipInfo.setExpendSeq( resultVo.getExpendSeq( ) );
		editSlipInfo.setListSeq( resultVo.getListSeq( ) );
		editSlipInfo.setSlipSeq( resultVo.getSlipSeq( ) );
		editSlipInfo = this.ExSlipInfoSelect( editSlipInfo );
		// 변경내역 확인
		if ( slipModifyYN.equals( commonCode.EMPTYYES ) ) {
			revisionHistory += "분개 수정 (listSeq:" + resultVo.getListSeq( ) + ", slipSeq:" + resultVo.getSlipSeq( ) + ")" + lineChange;
			// 공급가액
			if ( !baseSlipInfo.getAmt( ).equals( editSlipInfo.getAmt( ) ) ) {
				revisionHistory += ("분개 공급가액 변경. 기존 : " + baseSlipInfo.getAmt( ) + "-> 변경 : " + editSlipInfo.getAmt( ) + lineChange);
			}
			// 과세표준액
			if ( !baseSlipInfo.getSubStdAmt( ).equals( editSlipInfo.getSubStdAmt( ) ) ) {
				revisionHistory += ("분개 과세표준액 변경. 기존 : " + baseSlipInfo.getSubStdAmt( ) + "-> 변경 : " + editSlipInfo.getSubStdAmt( ) + lineChange);
			}
			// 세액
			if ( !baseSlipInfo.getSubTaxAmt( ).equals( editSlipInfo.getSubTaxAmt( ) ) ) {
				revisionHistory += ("분개 세액 변경. 기존 : " + baseSlipInfo.getSubTaxAmt( ) + "-> 변경 : " + editSlipInfo.getSubTaxAmt( ) + lineChange);
			}
		}
		else {
			revisionHistory += "분개 추가 (listSeq:" + resultVo.getListSeq( ) + ", slipSeq:" + resultVo.getSlipSeq( ) + ")" + lineChange;
		}
		if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) && (param.get( "isUseBudget" ) == null || Boolean.parseBoolean( param.get( "isUseBudget" ).toString( ) )) ) {
			/* 신규 예산정보 입력(slip에 있는 row_id, ERPiU의 gmm_sum_id) */
			//ERPiU 예산넣기(임시데이터 생성) 수정예정
			Map<String, Object> budgetParam = new HashMap<String, Object>( );
			budgetParam.put( "docSeq", expendVo.getDocSeq( ) );
			budgetParam.put( "expendSeq", expendVo.getExpendSeq( ) );
			budgetParam.put( "newListSeq", editSlipInfo.getListSeq( ) );
			budgetParam.put( "newSlipSeq", editSlipInfo.getSlipSeq( ) );
			budgetService.ExInterLockERPiURowInsert( budgetParam ); // ERPiU 예산정보 insert
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
		return resultVo;
	}

	@Override
    public ExCommonResultVO ExListAmtInfoUpdate ( ExExpendSlipVO slipVo, boolean isAdd, boolean isCopy ) throws Exception {
		ExCommonResultVO result = new ExCommonResultVO( );
		try {
			/* 변수 정의 */
			ExExpendSlipVO basicSlipVo = new ExExpendSlipVO( );
			String slipDrCrGbn = slipVo.getDrcrGbn( );
			/* 분개단위 입력인 경우 기본 분개정보에서 수정 전 분개의 금액을 삭제한다. */
			if ( !isAdd || isCopy ) {
				basicSlipVo = this.ExSlipInfoSelect( slipVo );
				if ( slipVo.getDrcrGbn( ).equals( commonCode.EMPTYSTR ) || !isAdd ) {
					/* 분개 구분이 누락되어 있거나 삭제의 경우 기존 분개 정보의 구분값으로 설정한다. */
					slipVo.setDrcrGbn( basicSlipVo.getDrcrGbn( ) );
				}
			}
			if ( !basicSlipVo.getInterfaceType( ).equals( commonCode.EMPTYSTR ) ) {
				result.setCode( commonCode.FAIL );
				result.setMessage( "외부 시스템 연동의 경우 복사가 불가능 합니다." );
				return result;
			}
			// 항목 정보 금액 수정
			ExExpendListVO listVo = new ExExpendListVO( );
			listVo.setExpendSeq( slipVo.getExpendSeq( ) );
			listVo.setListSeq( slipVo.getListSeq( ) );
			// 항목 정보 조회
			Map<String, Object> listAmtInfo = new HashMap<String, Object>( );
			listAmtInfo = exUserListService.ExListAmtSelect( listVo );
			Map<String, Object> amtParam = new HashMap<String, Object>( );
			BigDecimal amt = new BigDecimal( "0.00" );
			BigDecimal taxAmt = new BigDecimal( "0.00" );
			BigDecimal stdAmt = new BigDecimal( "0.00" );
			BigDecimal subStdAmt = new BigDecimal( "0.00" );
			BigDecimal subTaxAmt = new BigDecimal( "0.00" );
			if ( slipVo.getDrcrGbn( ).equals( "dr" ) ) {
				/*
				 * 작성자 : 신재호, 작성일 : 2017-02-24
				 * 차변 - 공급대가, 공급가액을 더한다.
				 * 부가세 - 공급대가, 부가세액, 세액, 과세표준액을 더한다.
				 * 대변 - 변경 없이 기존 항목금액으로 진행한다.
				 * 분개 복사인 경우 기존 분개정보로 금액을 더한다.
				 * 분개 추가인 경우 신규 분개정보로 금액을 더한다.
				 */
				if ( isAdd ) {
					if ( isCopy ) {
						amt = new BigDecimal( listAmtInfo.get( "amt" ).toString( ) ).add( new BigDecimal( basicSlipVo.getAmt( ) ) );
						stdAmt = new BigDecimal( listAmtInfo.get( "stdAmt" ).toString( ) ).add( new BigDecimal( basicSlipVo.getAmt( ) ) );
					}
					else {
						amt = new BigDecimal( listAmtInfo.get( "amt" ).toString( ) ).add( new BigDecimal( slipVo.getAmt( ) ) );
						stdAmt = new BigDecimal( listAmtInfo.get( "stdAmt" ).toString( ) ).add( new BigDecimal( slipVo.getAmt( ) ) );
					}
				}
				else {
					amt = new BigDecimal( listAmtInfo.get( "amt" ).toString( ) ).subtract( new BigDecimal( basicSlipVo.getAmt( ) ) );
					stdAmt = new BigDecimal( listAmtInfo.get( "stdAmt" ).toString( ) ).subtract( new BigDecimal( basicSlipVo.getAmt( ) ) );
				}
				/* 변경이 없는 금액은 기존 항목의 금액으로 설정한다. */
				taxAmt = new BigDecimal( listAmtInfo.get( "taxAmt" ).toString( ) );
				subStdAmt = new BigDecimal( listAmtInfo.get( "subStdAmt" ).toString( ) );
				subTaxAmt = new BigDecimal( listAmtInfo.get( "subTaxAmt" ).toString( ) );
			}
			else if ( slipVo.getDrcrGbn( ).equals( "vat" ) ) {
				if ( isAdd ) {
					if ( isCopy ) {
						amt = new BigDecimal( listAmtInfo.get( "amt" ).toString( ) ).add( new BigDecimal( basicSlipVo.getAmt( ) ) );
						taxAmt = new BigDecimal( listAmtInfo.get( "taxAmt" ).toString( ) ).add( new BigDecimal( basicSlipVo.getAmt( ) ) );
						subStdAmt = new BigDecimal( listAmtInfo.get( "subStdAmt" ).toString( ) ).add( new BigDecimal( basicSlipVo.getSubStdAmt( ) ) );
						subTaxAmt = new BigDecimal( listAmtInfo.get( "subTaxAmt" ).toString( ) ).add( new BigDecimal( basicSlipVo.getSubTaxAmt( ) ) );
					}
					else {
						amt = new BigDecimal( listAmtInfo.get( "amt" ).toString( ) ).add( new BigDecimal( slipVo.getAmt( ) ) );
						taxAmt = new BigDecimal( listAmtInfo.get( "taxAmt" ).toString( ) ).add( new BigDecimal( slipVo.getAmt( ) ) );
						subStdAmt = new BigDecimal( listAmtInfo.get( "subStdAmt" ).toString( ) ).add( new BigDecimal( slipVo.getSubStdAmt( ) ) );
						subTaxAmt = new BigDecimal( listAmtInfo.get( "subTaxAmt" ).toString( ) ).add( new BigDecimal( slipVo.getSubTaxAmt( ) ) );
					}
				}
				else {
					amt = new BigDecimal( listAmtInfo.get( "amt" ).toString( ) ).subtract( new BigDecimal( basicSlipVo.getAmt( ) ) );
					taxAmt = new BigDecimal( listAmtInfo.get( "taxAmt" ).toString( ) ).subtract( new BigDecimal( basicSlipVo.getAmt( ) ) );
					subStdAmt = new BigDecimal( listAmtInfo.get( "subStdAmt" ).toString( ) ).subtract( new BigDecimal( basicSlipVo.getSubStdAmt( ) ) );
					subTaxAmt = new BigDecimal( listAmtInfo.get( "subTaxAmt" ).toString( ) ).subtract( new BigDecimal( basicSlipVo.getSubTaxAmt( ) ) );
				}
				/* 변경이 없는 금액은 기존 항목의 금액으로 설정한다. */
				stdAmt = new BigDecimal( listAmtInfo.get( "stdAmt" ).toString( ) );
			}
			else {
				amt = new BigDecimal( listAmtInfo.get( "amt" ).toString( ) );
				stdAmt = new BigDecimal( listAmtInfo.get( "stdAmt" ).toString( ) );
				taxAmt = new BigDecimal( listAmtInfo.get( "taxAmt" ).toString( ) );
				subStdAmt = new BigDecimal( listAmtInfo.get( "subStdAmt" ).toString( ) );
				subTaxAmt = new BigDecimal( listAmtInfo.get( "subTaxAmt" ).toString( ) );
			}
			amtParam.put( "amt", amt );
			amtParam.put( "taxAmt", taxAmt );
			amtParam.put( "stdAmt", stdAmt );
			amtParam.put( "subStdAmt", subStdAmt );
			amtParam.put( "subTaxAmt", subTaxAmt );
			amtParam.put( "expendSeq", slipVo.getExpendSeq( ) );
			amtParam.put( "listSeq", slipVo.getListSeq( ) );
			if ( !slipDrCrGbn.equals( commonCode.EMPTYSTR ) ) {
				slipVo.setDrcrGbn( slipDrCrGbn );
			}
			exUserListService.ExListAmtEdit( amtParam );
		}
		catch ( Exception e ) {
			// do nothing
		}
		return result;
	}

	/* 지출결의 분개 목록 조회(해당 지출결의의 분개) */
	@Override
    public List<ExExpendSlipVO> ExExpendSlipListSelect ( Map<String, Object> param ) {
		List<ExExpendSlipVO> slipList = new ArrayList<ExExpendSlipVO>( );
		slipList = exUserSlipServiceADAO.ExExpendSlipListSelect( param );
		return slipList;
	}

	/* 지출결의 종결문서 수정 시 카드/매입전자세금계산서 사용 내역 전송 여부 수정 */
	@Override
    public ResultVO ExInterfaceInfoUpdate ( ExExpendListVO listVo ) throws Exception {
		/* 변수 정의 */
		ResultVO result = new ResultVO( );
		ExExpendSlipVO slipVo = new ExExpendSlipVO( );
		List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>( );
		/* 초기값 정의 */
		slipVo.setExpendSeq( listVo.getExpendSeq( ) );
		slipVo.setListSeq( listVo.getListSeq( ) );
		slipListVo = exUserSlipServiceADAO.ExSlipListInfoSelect( slipVo );
		for ( ExExpendSlipVO tSlip : slipListVo ) {
			if ( !tSlip.getInterfaceType( ).equals( commonCode.EMPTYSTR ) && !tSlip.getInterfaceType( ).equals( "-" ) ) {
				if ( tSlip.getDrcrGbn( ).equals( "dr" ) ) {
					slipVo = tSlip;
					break;
				}
			}
		}
		Map<String, Object> updateParam = new HashMap<String, Object>( );
		updateParam.put( "sendYN", commonCode.EMPTYNO );
		updateParam.put( "syncId", slipVo.getInterfaceMId( ) );
		/* 추후 추가 모듈 연동시 확장성을 위해 아래와 같이 처리 진행 */
		if ( slipVo.getInterfaceType( ).equals( "card" ) ) {
			result = exUserSlipServiceADAO.ExInterfaceCardInfoUpdate( updateParam );
		}
		else if ( slipVo.getInterfaceType( ).equals( "etax" ) ) {
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( CommonConvert.CommonGetEmpVO( ).getCompSeq( ) ) );
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				/* issNo, erpBizSeq */
				updateParam.putAll( exUserSlipServiceADAO.ExExpendSlipETaxInfoSelect( updateParam ) );
			}
			result = exUserSlipServiceADAO.ExInterfaceETaxInfoUpdate( updateParam, conVo );
		}
		return result;
	}

	/* 지출결의 - 지출결의 가져오기 분개 진행 */
	@Override
	public ResultVO ExExpendHistorySlipReflect ( LoginVO loginVo, ExExpendSlipVO tSlipVo, ConnectionVO conVo, String targetListSeq, String newExpendSeq ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			/* 변수정의 - 지출결의 항목 분개 */
			ExExpendSlipVO slipVo = new ExExpendSlipVO( );
			/* 변수정의 - 지출결의 항목 분개 관리항목 */
			ExExpendMngVO mngVo = new ExExpendMngVO( );
			/* 변수정의 - 공통코드 */
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( );
			ExCodeAuthVO authVo = new ExCodeAuthVO( );
			ExCodeOrgVO empVo = new ExCodeOrgVO( );
			ExCodeProjectVO projectVo = new ExCodeProjectVO( );
			ExCodePartnerVO partnerVo = new ExCodePartnerVO( );
			ExCodeCardVO cardVo = new ExCodeCardVO( );
			ExCodeBudgetVO budgetVo = new ExCodeBudgetVO( );
			/* 지출결의 항목 분개 소스 조회 */
			slipVo = this.ExSlipInfoSelect( tSlipVo );
			slipVo.setCompSeq( tSlipVo.getCompSeq( ) );
			slipVo.setExpendSeq( newExpendSeq );
			/* 표준적요 */
			if ( slipVo.getSummarySeq( ) != 0 ) {
				/* 표준적요 - 조회 */
				summaryVo.setCompSeq( tSlipVo.getCompSeq( ) );
				summaryVo.setSeq( slipVo.getSummarySeq( ) );
				summaryVo = exUserCodeService.ExExpendSummaryInfoSelect( summaryVo );
				/* 표준적요 - 생성 */
				summaryVo.setCompSeq( tSlipVo.getCompSeq( ) );
				summaryVo.setSeq( 0 );
				summaryVo.setCreateSeq( loginVo.getUniqId( ) );
				summaryVo.setModifySeq( loginVo.getUniqId( ) );
				summaryVo = exUserCodeService.ExExpendSummaryInfoInsert( summaryVo );
			}
			else {
				summaryVo.setSeq( 0 );
			}
			/* 증빙유형 */
			if ( slipVo.getAuthSeq( ) != 0 ) {
				/* 증빙유형 - 증빙유형 조회 */
				authVo.setCompSeq( tSlipVo.getCompSeq( ) );
				authVo.setSeq( slipVo.getAuthSeq( ) );
				authVo.setGroupSeq( loginVo.getGroupSeq( ) );
				authVo = exUserCodeService.ExExpendAuthInfoSelect( authVo );
				/* 증빙유형 -증빙유형 생성 */
				authVo.setCompSeq( tSlipVo.getCompSeq( ) );
				authVo.setSeq( 0 );
				authVo.setCreateSeq( loginVo.getUniqId( ) );
				authVo.setModifySeq( loginVo.getUniqId( ) );
				authVo = exUserCodeService.ExExpendAuthInfoInsert( authVo );
			}
			else {
				authVo.setSeq( 0 );
			}
			/* 사용자 */
			if ( slipVo.getEmpSeq( ) != 0 ) {
				/* 사용자 - 사용자 조회 */
				empVo.setCompSeq( tSlipVo.getCompSeq( ) );
				empVo.setSeq( slipVo.getEmpSeq( ) );
				empVo.setGroupSeq( loginVo.getGroupSeq( ) );
				empVo = exUserCodeService.ExExpendEmpInfoSelect( empVo );
				/* 사용자 - 사용자 생성 */
				empVo.setCompName( tSlipVo.getCompSeq( ) );
				empVo.setSeq( 0 );
				empVo.setCreateSeq( loginVo.getUniqId( ) );
				empVo.setModifySeq( loginVo.getUniqId( ) );
				empVo = exUserCodeService.ExExpendEmpInfoInsert( empVo );
			}
			else {
				empVo.setSeq( 0 );
			}
			/* 프로젝트 */
			if ( slipVo.getProjectSeq( ) != 0 ) {
				/* 프로젝트 - 프로젝트 조회 */
				projectVo.setCompSeq( tSlipVo.getCompSeq( ) );
				projectVo.setSeq( slipVo.getProjectSeq( ) );
				projectVo = exUserCodeService.ExExpendProjectInfoSelect( projectVo );
				/* 프로젝트 - 프로젝트 생성 */
				projectVo.setCompSeq( tSlipVo.getCompSeq( ) );
				projectVo.setSeq( 0 );
				projectVo.setCreateSeq( loginVo.getUniqId( ) );
				projectVo.setModifySeq( loginVo.getUniqId( ) );
				projectVo = exUserCodeService.ExExpendProjectInfoInsert( projectVo );
			}
			else {
				projectVo.setSeq( 0 );
			}
			/* 거래처 */
			if ( slipVo.getPartnerSeq( ) != 0 ) {
				/* 거래처 - 거래처 조회 */
				partnerVo.setCompSeq( tSlipVo.getCompSeq( ) );
				partnerVo.setSeq( slipVo.getPartnerSeq( ) );
				partnerVo = exUserCodeService.ExExpendPartnerInfoSelect( partnerVo );
				/* 거래처 - 거래처 생성 */
				partnerVo.setCompSeq( tSlipVo.getCompSeq( ) );
				partnerVo.setSeq( 0 );
				partnerVo.setCreateSeq( loginVo.getUniqId( ) );
				partnerVo.setModifySeq( loginVo.getUniqId( ) );
				partnerVo = exUserCodeService.ExExpendPartnerInfoInsert( partnerVo );
			}
			else {
				partnerVo.setSeq( 0 );
			}
			/* 카드 */
			if ( slipVo.getCardSeq( ) != 0 ) {
				/* 카드 - 카드 조회 */
				cardVo.setCompSeq( loginVo.getCompSeq( ) );
				cardVo.setSeq( slipVo.getCardSeq( ) );
				cardVo = exUserCodeService.ExExpendCardInfoSelect( cardVo );
				/* 카드 - 카드 생성 */
				if ( cardVo != null ) {
					cardVo.setCompSeq( loginVo.getCompSeq( ) );
					cardVo.setSeq( 0 );
					cardVo.setCreateSeq( loginVo.getUniqId( ) );
					cardVo.setModifySeq( loginVo.getUniqId( ) );
					cardVo = exUserCodeService.ExExpendCardInfoInsert( cardVo );
				}
			}
			else {
				cardVo.setSeq( 0 );
			}
			/* 예산 */
			if ( slipVo.getBudgetSeq( ) != 0 ) {
				ExpendVO expendVo = new ExpendVO( );
				expendVo.setExpendSeq( newExpendSeq );
				expendVo = masterService.ExUserExpendInfoSelect( expendVo );
				// 예산 사용 여부 확인
				Map<String, Object> optionParam = new HashMap<String, Object>( );
				optionParam.put( "compSeq", expendVo.getCompSeq( ) );
				optionParam.put( "formSeq", expendVo.getFormSeq( ) );
				optionParam.put( "useSw", conVo.getErpTypeCode( ) );
				optionParam.put( "optionCode", "003301" );
				ResultVO expendOption = configService.ExAdminConfigOptionSelect( optionParam );
				if ( expendOption != null && expendOption.getAaData( ).size( ) > 0 ) {
					if ( expendOption.getAaData( ).get( 0 ).get( "set_value" ).toString( ).equals( commonCode.EMPTYYES ) ) {
						/* 카드 - 예산 조회 */
						budgetVo.setCompSeq( tSlipVo.getCompSeq( ) );
						budgetVo.setSeq( slipVo.getBudgetSeq( ) );
						budgetVo = exUserCodeService.ExExpendBudgetInfoSelect( budgetVo );
						/* 카드 - 예산 생성 */
						/* 현재 지출결의의 회계일자로 예산정보 설정 */
						budgetVo.setBudgetYm( expendVo.getExpendDate( ).substring( 0, 6 ) );
						if ( budgetVo.getBudYm( ) != null && !budgetVo.getBudYm( ).equals( "" ) && budgetVo.getBudYm( ).length( ) == 6 ) {
							budgetVo.setBudYm( expendVo.getExpendDate( ).substring( 0, 6 ) );
						}
						budgetVo.setCompSeq( tSlipVo.getCompSeq( ) );
						budgetVo.setSeq( 0 );
						budgetVo.setCreateSeq( loginVo.getUniqId( ) );
						budgetVo.setModifySeq( loginVo.getUniqId( ) );
						budgetVo = exUserCodeService.ExExpendBudgetInfoInsert( budgetVo );
					}
				}
			}
			else {
				budgetVo.setSeq( 0 );
			}
			/* 지출결의 - 지출결의 항목 분개 생성 */
			slipVo.setCompSeq( tSlipVo.getCompSeq( ) );
			slipVo.setListSeq( targetListSeq );
			slipVo.setSlipSeq( commonCode.EMPTYSEQ );
			slipVo.setCreateSeq( loginVo.getUniqId( ) );
			slipVo.setModifySeq( loginVo.getUniqId( ) );
			slipVo.setSummarySeq( summaryVo.getSeq( ) );
			slipVo.setAuthSeq( authVo.getSeq( ) );
			slipVo.setEmpSeq( empVo.getSeq( ) );
			slipVo.setProjectSeq( projectVo.getSeq( ) );
			slipVo.setPartnerSeq( partnerVo.getSeq( ) );
			if ( cardVo != null ) {
				slipVo.setCardSeq( cardVo.getSeq( ) );
			}
			else {
				slipVo.setCardSeq( Integer.parseInt( commonCode.EMPTYSEQ ) );
			}
			if ( budgetVo != null ) {
				slipVo.setBudgetSeq( budgetVo.getSeq( ) );
			}
			else {
				slipVo.setBudgetSeq( Integer.parseInt( commonCode.EMPTYSEQ ) );
			}
			slipVo.setInterfaceType( tSlipVo.getInterfaceType( ) );
			slipVo.setInterfaceMId( tSlipVo.getInterfaceMId( ) );
			slipVo.setInterfaceDId( tSlipVo.getInterfaceDId( ) );
			slipVo = this.ExSlipInfoInsert( slipVo );
			/* 지출결의 - 지출겨르이 항목 분개 관리항목 복사 */
			// mngVo 는 기존 정보를 조회해야한다.
			mngVo.setCompSeq( tSlipVo.getCompSeq( ) );
			mngVo.setExpendSeq( tSlipVo.getExpendSeq( ) );
			mngVo.setListSeq( tSlipVo.getListSeq( ) );
			mngVo.setSlipSeq( tSlipVo.getSlipSeq( ) );
			resultVo = exUserMngService.ExExpendHistoryMngReflect( mngVo, slipVo.getListSeq( ), slipVo.getSlipSeq( ), newExpendSeq );
			if ( resultVo.getResultCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( );
			}
			resultVo.setResultCode( commonCode.SUCCESS );
			resultVo.setResultName( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultVo;
	}

	/* 지출결의 - 해당 지출결의 분개 첨부파일 조회 */
	@Override
    public List<Map<String, Object>> ExExpendSlipAttachListInfoSelect ( Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = exUserSlipServiceADAO.ExExpendSlipAttachListInfoSelect( param );
		return result;
	}
}
