package expend.ex.user.mng;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeMngVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExExpendMngVO;
import common.vo.ex.ExExpendSlipVO;
import common.vo.ex.ExExpendVO;
import expend.ex.master.config.FExMasterConfigServiceADAO;
import expend.ex.user.code.FExUserCodeServiceIDAO;
import expend.ex.user.code.FExUserCodeServiceUDAO;
import main.web.BizboxAMessage;


@Service ( "BExUserMngService" )
public class BExUserMngServiceImpl implements BExUserMngService {
	/* 변수정의 */

	/* 변수정의 - 관리항목 환경설정 */
	@Resource ( name = "FExMasterConfigServiceADAO" )
	private FExMasterConfigServiceADAO exMasterConfigServiceADAO;
	/* 변수정의 - 관리항목BizboxA */
	@Resource ( name = "FExUserMngServiceADAO" )
	private FExUserMngServiceADAO exUserMngServiceADAO;
	@Resource ( name = "FExUserMngServiceA" )
	private FExUserMngServiceAImpl exUserMngServiceAImpl;
	/* 변수정의 - 관리항목 iCUBE */
	@Resource ( name = "FExUserMngServiceI" )
	private FExUserMngServiceIImpl exUserMngServiceIImpl;
	@Resource ( name = "FExUserCodeServiceIDAO" )
	private FExUserCodeServiceIDAO exUserCodeServiceIDAO;
	/* 변수정의 - 관리항목 ERPiU */
	@Resource ( name = "FExUserMngServiceU" )
	private FExUserMngServiceUImpl exUserMngServiceUImpl;
	@Resource ( name = "FExUserCodeServiceUDAO" )
	private FExUserCodeServiceUDAO exUserCodeServiceUDAO;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* Pop */
	/* Pop - ExExpendMngPop 반환값 처리 */
	public Map<String, Object> ExUserMngPopReturn ( Map<String, Object> params ) throws Exception {
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

	/* 지출결의 */
	/* 지출결의 - 지출결의 항목 분개 관리항목 생성 */
	@Override
	public ExExpendMngVO ExMngInfoInsert ( ExExpendMngVO mngVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngInfoInsert" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		try {
			mngVo = exUserMngServiceADAO.ExMngInfoInsert( mngVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngInfoInsert" );
		return mngVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 수정 */
	@Override
	public ExCommonResultVO ExMngInfoUpdate ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngInfoUpdate" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exUserMngServiceADAO.ExMngInfoUpdate( mngVo );
			switch ( conVo.getErpTypeCode( ) ) {
				case commonCode.ICUBE:
					if ( mngVo.getMngCode( ).equals( "A1" ) ) { /* 거래처 수정 시 거래처 명 관리항목도 자동으로 수정한다. */
						List<ExExpendMngVO> mngList = exUserMngServiceADAO.ExMngListInfoSelect( mngVo );
						for ( ExExpendMngVO tData : mngList ) {
							if ( tData.getMngCode( ).equals( "B1" ) ) {
								tData.setCtdCode( mngVo.getCtdCode( ) );
								tData.setCtdName( mngVo.getCtdName( ) );
								resultVo = exUserMngServiceADAO.ExMngInfoUpdate( tData );
								break;
							}
						}
					}
					break;
				case commonCode.ERPIU:
					break;
				case commonCode.ETC:
					break;
				default:
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngInfoUpdate" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 조회 */
	@Override
	public ExExpendMngVO ExMngInfoSelect ( ExExpendMngVO mngVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		try {
			mngVo = exUserMngServiceADAO.ExMngInfoSelect( mngVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngInfoSelect" );
		return mngVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 목록 조회 */
	@Override
	public List<ExExpendMngVO> ExMngListInfoSelect ( ExExpendMngVO mngVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngListInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
		try {
			mngListVo = exUserMngServiceADAO.ExMngListInfoSelect( mngVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngListInfoSelect" );
		return mngListVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 삭제 */
	@Override
	public ExCommonResultVO ExMngInfoDelete ( ExExpendMngVO mngVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exUserMngServiceADAO.ExMngInfoDelete( mngVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngInfoDelete" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 하위 내역 모두 삭제 */
	@Override
	public ExCommonResultVO ExMngDInfoDelete ( ExExpendMngVO mngVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngDInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			resultVo = exUserMngServiceADAO.ExMngDInfoDelete( mngVo );
			if ( resultVo.getCode( ).equals( commonCode.FAIL ) ) {
				throw new Exception( BizboxAMessage.getMessage( "TX000009270", "관리항목 삭제에 실패하였습니다" ) );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngDInfoDelete" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 목록 조회 */
	@Override
	public List<Map<String, Object>> ExMngGridInfoSelect ( ExExpendMngVO mngVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngInfoDelete" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		try {
			result = exUserMngServiceADAO.ExMngGridInfoSelect( mngVo );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<Map<String, Object>> result >> " + result.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngInfoDelete" );
		return result;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 분개 처리 */
	@SuppressWarnings ( "unchecked" )
	@Override
	public ExCommonResultVO ExMngInfoMake ( LoginVO loginVo, Map<String, Object> param, ConnectionVO conVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngInfoMake" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + param.toString( ) );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		/* BizboxA 는 관리항목이 없으므로, 리턴한다. */
		if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.BIZBOXA ) ) {
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
			cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
			cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngInfoMake" );
			return resultVo;
		}
		try {
			/* 변수정의 */
			List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
			ExExpendVO expendVo = new ExExpendVO( ); /* 지출결의 */
			ExExpendListVO listVo = new ExExpendListVO( ); /* 지출결의 항목 */
			ExExpendSlipVO slipVo = new ExExpendSlipVO( ); /* 지출결의 항목 분개 */
			ExExpendMngVO mngVo = new ExExpendMngVO( ); /* 지출결의 항목 분개 관리항목 */
			ExCodeOrgVO orgVo = new ExCodeOrgVO( ); /* 지출결의 사용자 */
			ExCodeAuthVO authVo = new ExCodeAuthVO( ); /* 지출결의 증빙유형 */
			ExCodeSummaryVO summaryVo = new ExCodeSummaryVO( ); /* 지출결의 표준적요 */
			ExCodePartnerVO partnerVo = new ExCodePartnerVO( ); /* 지출결의 거래처 */
			ExCodeProjectVO projectVo = new ExCodeProjectVO( ); /* 지출결의 프로젝트 */
			ExCodeCardVO cardVo = new ExCodeCardVO( ); /* 지출결의 카드 */
			ExCodeMngVO mngUserSetVo = new ExCodeMngVO( );
			List<ExCodeMngVO> mngUserSetListVo = new ArrayList<ExCodeMngVO>( );
			List<ExExpendMngVO> erpCustomMngList = new ArrayList<ExExpendMngVO>( );
			/* 거래처 관리항목 존재 여부 확인 */
			boolean hasPartnerMng = false;
			/* 사원 관리항목 존재 여부 확인 */
			boolean hasEmpMng = false;
			/* 초기값 정의 */
			/* 초기값 정의 - 지출결의 */
			expendVo = (ExExpendVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "expend" ), expendVo );
			/* 초기값 정의 - 지출결의 항목 */
			listVo = (ExExpendListVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "list" ), listVo );
			/* 초기값 정의 - 지출결의 항목 분개 */
			slipVo = (ExExpendSlipVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "slip" ), slipVo );
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
			/* 초기값 정의 - 사용자 */
			orgVo = (ExCodeOrgVO) CommonConvert.CommonGetMapToObject( (Map<String, Object>) param.get( "emp" ), orgVo );

			/* 초기값 정의 - 관리항목 */
			mngVo.setErpCompSeq( loginVo.getErpCoCd( ) );
			mngVo.setAcctCode( slipVo.getAcctCode( ) );
			mngVo.setAcctName( slipVo.getAcctName( ) );
			/* 초기값 정의 - 관리항목 사용자 정의 */
			mngUserSetVo.setCompSeq( expendVo.getCompSeq( ) );
			mngUserSetVo.setFormSeq( expendVo.getFormSeq( ) );
			mngUserSetVo.setDrcrGbn( slipVo.getDrcrGbn( ).toLowerCase( ) );
			mngUserSetVo.setSearchStr( commonCode.EMPTYSTR );
			mngUserSetListVo = exMasterConfigServiceADAO.ExConfigMngListInfoSelect( mngUserSetVo );
			/* 데이터 생성 */
			/* 데이터 생성 - 관리항목 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				mngListVo = exUserMngServiceIImpl.ExCodeMngListInfoSelect( mngVo, conVo );
				erpCustomMngList = exUserMngServiceIImpl.ExCutomMngRealInfoSelect( mngVo, conVo );
			}
			else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				mngListVo = exUserMngServiceUImpl.ExCodeMngListInfoSelect( mngVo, conVo );
				/* 거래처 관리항목 존재 여부 확인 및 사원 존재여부 확인 */
				if ( slipVo.getDrcrGbn( ).equals( "cr" ) ) {
					for ( ExExpendMngVO exExpendMngVO : mngListVo ) {
						/* 거래처 관리항목이 존재하면 거래처 계좌번호가 들어가야한다.(무조건) 만약 거래처가 미존재하고 사원 관리항목이 존재하면 사원 계좌번호가 들어간다. */
						if ( exExpendMngVO.getMngCode( ).equals( "A06" ) ) { /* 거래처 관리항목 존재 유무 확인 */
							hasPartnerMng = true;
							break;
						}
						else if ( exExpendMngVO.getMngCode( ).equals( "A04" ) ) { /* 사원 관리항목 존재 유무 확인 */
							hasEmpMng = true;
						}
					}
				}
			}
			/* 데이터 생성 - 관리항목 - 지출결의 아이디 부여 / 관리항목 코드 맵핑 */
			if ( mngListVo.size( ) > 0 ) {
				for ( ExExpendMngVO exExpendMngVO : mngListVo ) {
					/* 데이터 생성 - 관리항목 - 지출결의 아이디 부여 */
					exExpendMngVO.setExpendSeq( slipVo.getExpendSeq( ) );
					exExpendMngVO.setListSeq( slipVo.getListSeq( ) );
					exExpendMngVO.setSlipSeq( slipVo.getSlipSeq( ) );
					for ( ExCodeMngVO exCodeMngVO : mngUserSetListVo ) {
						if ( exCodeMngVO.getMngCode( ).equals( exExpendMngVO.getMngCode( ) ) ) {
							if ( exCodeMngVO.getUseGbn( ).equals( "Default" ) ) { /* 기본값 */
								break;
							}
							else if ( exCodeMngVO.getUseGbn( ).equals( "UserInput" ) ) { /* 사용자 정의 */
								exExpendMngVO.setCtdCode( exCodeMngVO.getCtdCode( ) );
								exExpendMngVO.setCtdName( exCodeMngVO.getCtdName( ) );
							}
							else if ( exCodeMngVO.getUseGbn( ).equals( "DevInput" ) ) { /* 전용개발 */
								/* parameter : queryKey, execQuery, commandType */
								Map<String, Object> custMngParam = new HashMap<String, Object>( );
								Map<String, Object> custMngResult = new HashMap<String, Object>( );
								custMngParam.put( "queryKey", exCodeMngVO.getMngCode( ) + "_" + exCodeMngVO.getUseGbn( ) );
								custMngParam.put( "execQuery", exCodeMngVO.getCustSet( ) );
								custMngParam.put( "commandType", "select" );
								custMngParam.put( commonCode.EXPENDSEQ, slipVo.getExpendSeq( ) );
								custMngParam.put( commonCode.LISTSEQ, slipVo.getListSeq( ) );
								custMngParam.put( commonCode.SLIPSEQ, slipVo.getSlipSeq( ) );

								/* 카드 정보 */
								custMngParam.put("cardCode", cardVo.getCardCode());
								custMngParam.put("cardNum", cardVo.getCardNum());
								custMngParam.put("cardName", cardVo.getCardName());

								/* 증빙유형 정보 */
								custMngParam.put( "authCode", CommonConvert.CommonGetStr( authVo.getAuthCode( ) ) );

								if ( exCodeMngVO.getCustSetTarget( ).equals( commonCode.ICUBE ) ) {
									custMngResult = exUserCodeServiceIDAO.ExExpendMngDynamicQuerySelect( custMngParam, conVo );
								}
								else if ( exCodeMngVO.getCustSetTarget( ).equals( commonCode.ERPIU ) ) {
									custMngResult = exUserCodeServiceUDAO.ExExpendMngDynamicQuerySelect( custMngParam, conVo );
								}
								else {
									custMngResult.put( "ctd_code", commonCode.EMPTYSTR );
									custMngResult.put( "ctd_name", commonCode.EMPTYSTR );
								}
								exExpendMngVO.setCtdCode( (String) custMngResult.get( "ctd_code" ) == null ? commonCode.EMPTYSTR : (String) custMngResult.get( "ctd_code" ) );
								exExpendMngVO.setCtdName( (String) custMngResult.get( "ctd_name" ) == null ? commonCode.EMPTYSTR : (String) custMngResult.get( "ctd_name" ) );
							}
							else if ( exCodeMngVO.getUseGbn( ).equals( "EmpInfo" ) ) { /* 사용자 */
								exExpendMngVO.setCtdCode( orgVo.getErpEmpSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpEmpName( ) );
							}
							else if ( exCodeMngVO.getUseGbn( ).equals( "DeptInfo" ) ) { /* 사용부서 */
								exExpendMngVO.setCtdCode( orgVo.getErpDeptSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpDeptName( ) );
							}
							else if ( exCodeMngVO.getUseGbn( ).equals( "BizareaInfo" ) ) { /* 사용사업장 */
								exExpendMngVO.setCtdCode( orgVo.getErpBizSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpBizName( ) );
							}
							else if ( exCodeMngVO.getUseGbn( ).equals( "CompanyInfo" ) ) { /* 사용회사 */
								exExpendMngVO.setCtdCode( orgVo.getErpCompSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpCompName( ) );
							}
							break;
						}
					}

					/* 사용자 정의로 값이 연동된 경우에는 기본 기능을 수행하지 않는다. */
					if ( !exExpendMngVO.getCtdCode( ).equals( commonCode.EMPTYSTR ) || !exExpendMngVO.getCtdName( ).equals( commonCode.EMPTYSTR ) ) {
						continue;
					}

					/* 데이터 생성 - 관리항목 - 관리항목 코드 맵핑 */
					if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
						/* 데이터 생성 - 관리항목 - 관리항목 코드 맵핑 - iCUBE */
						switch ( exExpendMngVO.getMngCode( ) ) {
							case "A1": /* iCUBE - 거래처 */
								exExpendMngVO.setCtdCode( partnerVo.getPartnerCode( ) );
								exExpendMngVO.setCtdName( partnerVo.getPartnerName( ) );
								break;
							case "A2": /* iCUBE - 금융거래처 */
								exExpendMngVO.setCtdCode( cardVo.getCardCode( ) );
								exExpendMngVO.setCtdName( cardVo.getCardName( ) );
								break;
							case "B1": /* iCUBE - 거래처명 */
								exExpendMngVO.setCtdCode( partnerVo.getPartnerCode( ) );
								exExpendMngVO.setCtdName( partnerVo.getPartnerName( ) );
								break;
							case "C1": /* iCUBE - 사용부서 */
								exExpendMngVO.setCtdCode( orgVo.getErpDeptSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpDeptName( ) );
								break;
							case "D1": /* iCUBE - 프로젝트 */
								exExpendMngVO.setCtdCode( projectVo.getProjectCode( ) );
								exExpendMngVO.setCtdName( projectVo.getProjectName( ) );
								break;
							case "D4": /* iCUBE - 사원 */
								exExpendMngVO.setCtdCode( orgVo.getErpEmpSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpEmpName( ) );
								break;
							case "D5": /* iCUBE - 사업장 */
							    exExpendMngVO.setCtdCode( orgVo.getErpBizSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpBizName( ) );
								break;
							case "F1": /* iCUBE - 발생일 ( 증빙일자 ) */
								exExpendMngVO.setCtdCode( slipVo.getAuthDate( ) );
								exExpendMngVO.setCtdName( slipVo.getAuthDate( ) );
								break;
							case "F3": /* iCUBE - 요청일 ( 지급요청일 ) */
								exExpendMngVO.setCtdCode( expendVo.getExpendReqDate( ) );
								exExpendMngVO.setCtdName( expendVo.getExpendReqDate( ) );
								break;
							case "H3": /* iCUBE - 불공제세액 */
								exExpendMngVO.setCtdCode( slipVo.getSubTaxAmt( ) );
								exExpendMngVO.setCtdName( slipVo.getSubTaxAmt( ) );
								break;
							case "H5": /* iCUBE - 환율 */
								exExpendMngVO.setCtdCode( slipVo.getExchangeRate() );
								exExpendMngVO.setCtdName( slipVo.getExchangeRate() );
								break;
							case "I3": /* iCUBE - 과세표준액 */
								exExpendMngVO.setCtdCode( slipVo.getSubStdAmt( ) );
								exExpendMngVO.setCtdName( slipVo.getSubStdAmt( ) );
								break;
							case "I5": /* iCUBE - 외화금액 */
								exExpendMngVO.setCtdCode( slipVo.getForeignCurrencyAmount() );
								exExpendMngVO.setCtdName( slipVo.getForeignCurrencyAmount() );
								break;
							case "K1": /* iCUBE - 세무구분 */
								exExpendMngVO.setCtdCode( authVo.getVatTypeCode( ) );
								exExpendMngVO.setCtdName( authVo.getVatTypeName( ) );
								break;
							case "K2": /* iCUBE - 환종 */
								exExpendMngVO.setCtdCode( slipVo.getExchangeUnitCode() );
								exExpendMngVO.setCtdName( slipVo.getExchangeUnitName() );
								break;
							default:
								/* 사용자 정의 관리 항목중 연결설정되어잇는 관리항목은 해당 내역으로 매핑진행. */
								boolean isCutomLink = false;
								for ( ExExpendMngVO tMng : erpCustomMngList ) {
									if ( exExpendMngVO.getMngCode( ).equals( tMng.getMngCode( ) ) ) {
										isCutomLink = true;
										switch ( tMng.getRealMngCode( ) ) {
											case "A1": /* iCUBE - 거래처 */
												exExpendMngVO.setCtdCode( partnerVo.getPartnerCode( ) );
												exExpendMngVO.setCtdName( partnerVo.getPartnerName( ) );
												break;
											case "A2": /* iCUBE - 금융거래처 */
												exExpendMngVO.setCtdCode( cardVo.getCardCode( ) );
												exExpendMngVO.setCtdName( cardVo.getCardName( ) );
												break;
											case "B1": /* iCUBE - 거래처명 */
												exExpendMngVO.setCtdCode( partnerVo.getPartnerCode( ) );
												exExpendMngVO.setCtdName( partnerVo.getPartnerName( ) );
												break;
											case "C1": /* iCUBE - 사용부서 */
												exExpendMngVO.setCtdCode( orgVo.getErpDeptSeq( ) );
												exExpendMngVO.setCtdName( orgVo.getErpDeptName( ) );
												break;
											case "D1": /* iCUBE - 프로젝트 */
												exExpendMngVO.setCtdCode( projectVo.getProjectCode( ) );
												exExpendMngVO.setCtdName( projectVo.getProjectName( ) );
												break;
											case "D4": /* iCUBE - 사원 */
												exExpendMngVO.setCtdCode( orgVo.getErpEmpSeq( ) );
												exExpendMngVO.setCtdName( orgVo.getErpEmpName( ) );
												break;
											case "D5": /* iCUBE - 사업장 */
												exExpendMngVO.setCtdCode( orgVo.getErpBizSeq( ) );
												exExpendMngVO.setCtdName( orgVo.getErpBizName( ) );
												break;
											case "F1": /* iCUBE - 발생일 ( 증빙일자 ) */
												exExpendMngVO.setCtdCode( slipVo.getAuthDate( ) );
												exExpendMngVO.setCtdName( slipVo.getAuthDate( ) );
												break;
											case "F3": /* iCUBE - 요청일 ( 지급요청일 ) */
												exExpendMngVO.setCtdCode( expendVo.getExpendReqDate( ) );
												exExpendMngVO.setCtdName( expendVo.getExpendReqDate( ) );
												break;
											case "H3": /* iCUBE - 불공제세액 */
												exExpendMngVO.setCtdCode( slipVo.getSubTaxAmt( ) );
												exExpendMngVO.setCtdName( slipVo.getSubTaxAmt( ) );
												break;
											case "I3": /* iCUBE - 과세표준액 */
												exExpendMngVO.setCtdCode( slipVo.getSubStdAmt( ) );
												exExpendMngVO.setCtdName( slipVo.getSubStdAmt( ) );
												break;
											case "K1": /* iCUBE - 세무구분 */
												exExpendMngVO.setCtdCode( authVo.getVatTypeCode( ) );
												exExpendMngVO.setCtdName( authVo.getVatTypeName( ) );
												break;
											default:
												isCutomLink = false;
												break;
										}
									}
								} /* 사용자정의 관리항목 연동정보 매핑 끝 */
								if ( !isCutomLink ) {
									exExpendMngVO.setCtdCode( commonCode.EMPTYSTR );
									exExpendMngVO.setCtdName( commonCode.EMPTYSTR );
								}
								break;
						}
					}
					else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
						/* 데이터 생성 - 관리항목 - 관리항목 코드 맵핑 - ERPiU */
						switch ( exExpendMngVO.getMngCode( ) ) {
							case "A01": /* ERPiU - 귀속사업장 */
								exExpendMngVO.setCtdCode( orgVo.getErpBizSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpBizName( ) );
								break;
							case "A02": /* ERPiU - 코스트센터 */
								exExpendMngVO.setCtdCode( orgVo.getErpCcSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpCcName( ) );
								break;
							case "A03": /* ERPiU - 부서 */
								exExpendMngVO.setCtdCode( orgVo.getErpDeptSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpDeptName( ) );
								break;
							case "A04": /* ERPiU - 사원 */
								exExpendMngVO.setCtdCode( orgVo.getErpEmpSeq( ) );
								exExpendMngVO.setCtdName( orgVo.getErpEmpName( ) );
								break;
							case "A05": /* ERPiU - 프로젝트 */
								exExpendMngVO.setCtdCode( projectVo.getProjectCode( ) );
								exExpendMngVO.setCtdName( projectVo.getProjectName( ) );
								break;
							case "A06": /* ERPiU - 거래처 */
								exExpendMngVO.setCtdCode( partnerVo.getPartnerCode( ) );
								exExpendMngVO.setCtdName( partnerVo.getPartnerName( ) );
								break;
							case "A08": /* ERPiU - 신용카드 */
								exExpendMngVO.setCtdCode( cardVo.getCardNum( ) );
								exExpendMngVO.setCtdName( cardVo.getCardName( ) );
								break;
							case "A09": /* ERPiU - 금융기관 */
								exExpendMngVO.setCtdCode( cardVo.getBankPartnerCode( ) );
								exExpendMngVO.setCtdName( cardVo.getBankPartnerName( ) );
								break;
							case "B21": /* ERPiU - 발생일자 ( 증빙일자 ) */
							case "C08": /* ERPiU - 발행일자 ( 증빙일자 ) */
								exExpendMngVO.setCtdCode( slipVo.getAuthDate( ) );
								exExpendMngVO.setCtdName( slipVo.getAuthDate( ) );
								break;
							case "B22": /* ERPiU - 자급예정일자 ( 지급요청일자 ) */
							case "B23": /* ERPiU - 만기일자 ( 지급요청일자 ) */
								exExpendMngVO.setCtdCode( expendVo.getExpendReqDate( ) );
								exExpendMngVO.setCtdName( expendVo.getExpendReqDate( ) );
								break;
							case "B24": /* ERPiU - 환종 */
								exExpendMngVO.setCtdCode( slipVo.getExchangeUnitCode() );
								exExpendMngVO.setCtdName( slipVo.getExchangeUnitName() );
								break;
							case "B25": /* ERPiU - 환율 */
								exExpendMngVO.setCtdCode( slipVo.getExchangeRate() );
								exExpendMngVO.setCtdName( slipVo.getExchangeRate() );
								break;
							case "B26": /* ERPiU - 외화금액 */
								exExpendMngVO.setCtdCode( slipVo.getForeignCurrencyAmount() );
								exExpendMngVO.setCtdName( slipVo.getForeignCurrencyAmount() );
								break;
							case "C01": /* ERPiU - 사업자등록번호 */
								exExpendMngVO.setCtdCode( partnerVo.getPartnerNo( ) );
								exExpendMngVO.setCtdName( partnerVo.getPartnerNo( ) );
								break;
							case "C05": /* ERPiU - 과세표준액 */
								exExpendMngVO.setCtdCode( slipVo.getSubStdAmt( ) );
								exExpendMngVO.setCtdName( slipVo.getSubStdAmt( ) );
								break;
							case "C14": /* ERPiU - 세무구분 ( 부가세 구분 ) */
								exExpendMngVO.setCtdCode( authVo.getVatTypeCode( ) );
								exExpendMngVO.setCtdName( authVo.getVatTypeName( ) );
								break;
							case "C15": /* ERPiU - 거래처 계좌번호 */
								if( slipVo.getDrcrGbn( ).equals( "cr" )){
									if( hasPartnerMng ){
										exExpendMngVO.setCtdCode( partnerVo.getDepositCd( ) );
										exExpendMngVO.setCtdName( partnerVo.getDepositConvert( ) );
									}else if ( hasEmpMng ){
										exExpendMngVO.setCtdCode( orgVo.getDepositCd( ) );
										exExpendMngVO.setCtdName( orgVo.getDepositName( ) );
									}else{
										exExpendMngVO.setCtdCode( partnerVo.getDepositCd( ) );
										exExpendMngVO.setCtdName( partnerVo.getDepositConvert( ) );
									}
								}else{
									exExpendMngVO.setCtdCode( partnerVo.getDepositCd( ) );
									exExpendMngVO.setCtdName( partnerVo.getDepositConvert( ) );
								}

								break;
							case "C16": /* ERPiU - 세액 */
								exExpendMngVO.setCtdCode( slipVo.getSubTaxAmt( ) );
								exExpendMngVO.setCtdName( slipVo.getSubTaxAmt( ) );
								break;
							case "C18": /* ERPiU - 불공제구분 */
								exExpendMngVO.setCtdCode( authVo.getNoTaxCode( ) );
								exExpendMngVO.setCtdName( authVo.getNoTaxName( ) );
								break;
							case "C47":
                                exExpendMngVO.setCtdCode( cardVo.getAuthNum() );
                                exExpendMngVO.setCtdName( cardVo.getAuthNum() );
                                break;
							default:
								exExpendMngVO.setCtdCode( commonCode.EMPTYSTR );
								exExpendMngVO.setCtdName( commonCode.EMPTYSTR );
								break;
						}
					}
				}
			}
			/* 데이터 생성 - 관리항목 - 등록 */
			for ( ExExpendMngVO exExpendMngVO : mngListVo ) {
				this.ExMngInfoInsert( exExpendMngVO );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngInfoMake" );
		return resultVo;
	}

	/* 지출결의 - 지출결의 항목 분개 관리항목 복사 */
	@Override
	public ExCommonResultVO ExMngInfoCopy ( ExExpendMngVO mngVo, String targetListSeq, String targetSlipSeq ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] ExExpendMngService - ExMngInfoCopy" );
		cmLog.CommonSetInfo( "! [EX] ExExpendMngVO mngVo >> " + mngVo.toString( ) );
		cmLog.CommonSetInfo( "! [EX] targetSlipSeq >> " + targetSlipSeq );
		ExCommonResultVO resultVo = new ExCommonResultVO( );
		try {
			/* 변수정의 */
			/* 변수정의 - 지출결의 항목 분개 관리항목 */
			List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
			/* 관리항목 */
			mngListVo = this.ExMngListInfoSelect( mngVo );
			/* 관리항목 - 조회 */
			for ( ExExpendMngVO exExpendMngVO : mngListVo ) {
				/* 관리항목 - 가공 */
				exExpendMngVO.setListSeq( targetListSeq );
				exExpendMngVO.setSlipSeq( targetSlipSeq );
				/* 관리항목 - 생성 */
				this.ExMngInfoInsert( exExpendMngVO );
			}
			resultVo.setCode( commonCode.SUCCESS );
			resultVo.setMessage( BizboxAMessage.getMessage( "TX000009301", "정상처리되었습니다" ) );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] ExCommonResultVO resultVo >> " + resultVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] ExExpendMngService - ExMngInfoCopy" );
		return resultVo;
	}

	@Override
	public List<ExExpendMngVO> ExCodeMngListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		FExUserMngService service = null;
		switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
			case commonCode.ICUBE: /* ERP iCUBE */
				service = exUserMngServiceIImpl;
				// errorStr = "ExCommonCodeInfoSelect - iCUBE - parameter not exists >> ";
				break;
			case commonCode.ERPIU: /* ERP iU */
				service = exUserMngServiceUImpl;
				// errorStr = "ExCommonCodeInfoSelect - ERPiU - parameter not exists >> ";
				break;
			case commonCode.BIZBOXA: /* ERP iU */
				service = exUserMngServiceAImpl;
				// errorStr = "ExCommonCodeInfoSelect - ERPiU - parameter not exists >> ";
				break;
			default :
				break;
		}
		if ( service == null ) {
			return null;
		}
		return service.ExCodeMngListInfoSelect( mngVo, conVo );
	}

	@Override
	public List<ExExpendMngVO> ExCodeMngDListInfoSelect ( ExExpendMngVO mngVo, ConnectionVO conVo ) throws Exception {
		FExUserMngService service = null;
		switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
			case commonCode.ICUBE: /* ERP iCUBE */
				service = exUserMngServiceIImpl;
				// errorStr = "ExCommonCodeInfoSelect - iCUBE - parameter not exists >> ";
				break;
			case commonCode.ERPIU: /* ERP iU */
				service = exUserMngServiceUImpl;
				// errorStr = "ExCommonCodeInfoSelect - ERPiU - parameter not exists >> ";
				break;
			case commonCode.BIZBOXA: /* ERP iU */
				service = exUserMngServiceAImpl;
				// errorStr = "ExCommonCodeInfoSelect - ERPiU - parameter not exists >> ";
				break;
			default :
				break;
		}
		if ( service == null ) {
			return null;
		}
		return service.ExCodeMngDListInfoSelect( mngVo, conVo );
	}

	/* 지출결의 - 오류체크 - 관리항목 */
	public List<ExCommonResultVO> ExMngErrorInfoSelect ( ExExpendVO expendVo ) throws Exception {
		cmLog.CommonSetInfo( "+ [EX] BExUserMngService - ExExpendErrorMngInfoSelect" );
		cmLog.CommonSetInfo( "! [EX] ExExpendVO expendVo >> " + expendVo.toString( ) );
		List<ExCommonResultVO> resultListVo = new ArrayList<ExCommonResultVO>( );
		try {
			resultListVo = exUserMngServiceADAO.ExMngErrorInfoSelect( expendVo );
		}
		catch ( Exception e ) {
			StringWriter sw = new StringWriter( );
			e.printStackTrace( new PrintWriter( sw ) );
			String exceptionAsStrting = sw.toString( );
			cmLog.CommonSetInfo( "! [EX] ERROR - " + exceptionAsStrting );
			e.printStackTrace( );
			throw e;
		}
		cmLog.CommonSetInfo( "! [EX] List<ExCommonResultVO> resultListVo >> " + resultListVo.toString( ) );
		cmLog.CommonSetInfo( "- [EX] BExUserMngService - ExExpendErrorMngInfoSelect" );
		return resultListVo;
	}

	/* 지출결의 - 지출결의 가져오기 관리항목 진행 */
	@Override
	public ResultVO ExExpendHistoryMngReflect ( ExExpendMngVO mngVo, String targetListSeq, String targetSlipSeq, String newExpendSeq ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			/* 변수정의 - 지출결의 항목 분개 관리항목 */
			List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>( );
			/* 관리항목 */
			mngListVo = this.ExMngListInfoSelect( mngVo );
			/* 관리항목 - 조회 */
			for ( ExExpendMngVO exExpendMngVO : mngListVo ) {
				/* 관리항목 - 가공 */
				exExpendMngVO.setExpendSeq( newExpendSeq );
				exExpendMngVO.setListSeq( targetListSeq );
				exExpendMngVO.setSlipSeq( targetSlipSeq );
				/* 관리항목 - 생성 */
				this.ExMngInfoInsert( exExpendMngVO );
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

	/* 지출결의 - 분개추가 - 관리항목 필수값 조회 */
	@Override
	public ResultVO ExExpendMngNecessaryOptionInfoSelect ( Map<String, Object> param ) throws Exception {
		ResultVO result = new ResultVO( );
		LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
		FExUserMngService mngService;
		if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
			mngService = exUserMngServiceUImpl;
		}
		else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
			mngService = exUserMngServiceIImpl;
		}
		else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.BIZBOXA ) ) {
			mngService = exUserMngServiceAImpl;
		}
		else {
			throw new Exception( "ERP 코드 확인 불가" );
		}
		ExExpendMngVO mngVo = new ExExpendMngVO( );
		mngVo.setAcctCode( param.get( "acctCode" ).toString( ) );
		mngVo.setErpCompSeq( conVo.getErpCompSeq( ) );
		result = mngService.ExExpendMngNecessaryOptionInfoSelect( mngVo, conVo );
		return result;
	}

	/* 지출결의 */
	/* 지출결의 - 지출결의 관리항목 일괄 수정 */
	@Override
	public ExCommonResultVO ExMasterMngUpdate ( Map<String, Object> params ) throws Exception {
		ExCommonResultVO resultVo = new ExCommonResultVO();

		try {
			String mngCode = params.get("mngCode").toString();
			String[] mngCodeList = mngCode.split("\\|");
			params.put("mngCodeList", mngCodeList);

			resultVo = exUserMngServiceADAO.ExMasterMngUpdate( params );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return resultVo;
	}
}
