package expend.ex.user.yesil;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service("BExUserYesilService")
public class BExUserYesilServiceImpl implements BExUserYesilService{
	
	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource(name = "FExUserYesilServiceI")
	private FExUserYesilService yesilServiceI;
	@Resource(name = "FExUserYesilServiceU")
	private FExUserYesilService yesilServiceU;
	
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황  */
	/* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
	@Override
	public ResultVO ExUserYesilSendParam(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesilSendParam(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setParams( yesilServiceI.ExUserYesilSendParam( params, conVo ) );
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황 조회 */
	@Override
	public ResultVO ExUserYesilInfoSelect(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesilInfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setAaData( yesilServiceI.ExUserYesilInfoSelect( params, conVo ) );
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황 상세조회 */
	@Override
	public ResultVO ExUserYesilDetailSelect(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesilDetailSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setAaData( yesilServiceI.ExUserYesilDetailSelect( params, conVo ) );
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 사용자 - 프로젝트 조회 */
	@Override
	public ResultVO ExUserYesilPop ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesilPop(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setAaData( yesilServiceI.ExUserYesilPop( params, conVo ) );
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* IU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT)  */
	/* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
	@Override
	public ResultVO ExUserYesil2SendParam(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2SendParam(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setParams( yesilServiceU.ExUserYesil2SendParam( params, conVo ) );
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 예산단위그룹 조회  */
	@Override
	public ResultVO ExUserYesil2BudgetGrInfo(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2BudgetGrInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setAaData( yesilServiceU.ExUserYesil2BudgetGrInfo( params, conVo ) );
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 예산단위 조회  */
	@Override
	public ResultVO ExUserYesil2BudgetDeptInfo(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call fnUserYesil2BudgetDeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setAaData( yesilServiceU.ExUserYesil2BudgetDeptInfo( params, conVo ) );
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 사업계획 조회  */
	@Override
	public ResultVO ExUserYesil2BizPlanInfo(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call fnUserYesil2BizPlanInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setAaData( yesilServiceU.ExUserYesil2BizPlanInfo( params, conVo ) );
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}

	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 예산계정 조회  */
	@Override
	public ResultVO ExUserYesil2BudgetAcctInfo(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2BudgetAcctInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setAaData( yesilServiceU.ExUserYesil2BudgetAcctInfo( params, conVo ) );
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 사용자 */ /* iU */
	/* Biz - 예실대비현황 - 사용자 - 예실대비현황2(PIVOT) - 예실대비 조회  */
	@Override
	public ResultVO ExUserYesil2InfoSelect(Map<String, Object> params) throws Exception {
		cmLog.CommonSetInfo( "Call ExUserYesil2InfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO();
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setAaData( yesilServiceU.ExUserYesil2InfoSelect( params, conVo ) );
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
	
	@Override
	public ResultVO ExUserYesilnoExpendSend ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilDetailPopInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExAdminYesilnoExpendSend - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setParams( yesilServiceI.ExUserYesilnoExpendSend( params ) );
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExAdminYesilnoExpendSend - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExAdminYesilnoExpendSend - ETC - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				default: /* Bizbox Alpha */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExAdminYesilnoExpendSend - BizboxA - parameter not exists >> " + commonCode.COMPSEQ );
					}
					break;
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
}
