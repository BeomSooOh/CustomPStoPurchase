package expend.ex.admin.yesil;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


@Service ( "BExAdminYesilService" )
public class BExAdminYesilServiceImpl implements BExAdminYesilService {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FExAdminYesilServiceI" )
	private FExAdminYesilService yesilServiceI;
	@Resource ( name = "FExAdminYesilServiceU" )
	private FExAdminYesilService yesilServiceU;
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황 */
	/* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
	@Override
	public ResultVO ExAdminYesilSendParam ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilSendParam(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setParams( yesilServiceI.ExAdminYesilSendParam( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 관리자 - 부서, 프로젝트, 부문 조회 */
	@Override
	public ResultVO ExAdminYesilPop ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilPop(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceI.ExAdminYesilPop( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황 조회 */
	@Override
	public ResultVO ExAdminYesilInfoSelect ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilInfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceI.ExAdminYesilInfoSelect( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황 상세조회 */
	@Override
	public ResultVO ExAdminYesilDetailSelect ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesilDetailSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceI.ExAdminYesilDetailSelect( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* IU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) */
	/* 페이지 접속시 JSP 전달 파라미터 생성 반환 */
	public ResultVO ExAdminYesil2SendParam ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2SendParam(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setParams( yesilServiceU.ExAdminYesil2SendParam( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 결의부서 조회 */
	@Override
	public ResultVO ExAdminYesil2DeptInfo ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2DeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceU.ExAdminYesil2DeptInfo( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예산단위그룹 조회 */
	@Override
	public ResultVO ExAdminYesil2BudgetGrInfo ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call fnAdminYesil2BudgetGrInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceU.ExAdminYesil2BudgetGrInfo( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예산단위 조회 */
	@Override
	public ResultVO ExAdminYesil2BudgetDeptInfo ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call fnAdminYesil2BudgetDeptInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceU.ExAdminYesil2BudgetDeptInfo( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 사업계획 조회 */
	@Override
	public ResultVO ExAdminYesil2BizPlanInfo ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call fnAdminYesil2BizPlanInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceU.ExAdminYesil2BizPlanInfo( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예산계정 조회 */
	@Override
	public ResultVO ExAdminYesil2BudgetAcctInfo ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2BudgetAcctInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceU.ExAdminYesil2BudgetAcctInfo( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예실대비 조회 */
	@Override
	public ResultVO ExAdminYesil2InfoSelect ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExAdminYesil2InfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
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
					result.setAaData( yesilServiceU.ExAdminYesil2InfoSelect( params, conVo ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황 - 예실대비 지출결의현황 조회 */
	@Override
	public ResultVO ExAdminYesilDetailPopInfo ( Map<String, Object> params ) throws Exception {
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
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setParams( yesilServiceI.ExAdminYesilDetailPopInfo( params ) );
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
	/* Biz - 예실대비현황 - 관리자 */ /* iU */
	/* Biz - 예실대비현황 - 관리자 - 예실대비현황2(PIVOT) - 예실대비 지출결의현황 조회 */
	@Override
	public ResultVO ExAdminYesil2DetailPopInfo ( Map<String, Object> params ) throws Exception {
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
						throw new Exception( "ExUserSummaryListInfoSelect - iCUBE - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					break;
				case commonCode.ERPIU: /* ERP iU */
					/* 필수 파라미터 점검 */
					if ( CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
						throw new Exception( "ExUserSummaryListInfoSelect - ERPiU - parameter not exists >> " + commonCode.ERPCOMPSEQ );
					}
					/* 데이터 조회 */
					result.setParams( yesilServiceU.ExAdminYesil2DetailPopInfo( params ) );
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


	/*예실대비현황2.0 미전송 결의 팝업 창*/
	/*예실대비현황2.0 팝업창 메인 리스트 */
	/* 이준성 개발 중 */
	@Override
	public ResultVO ExAdminIuYesilExpendsend(Map<String,Object> params) throws Exception{
      cmLog.CommonSetInfo( "Call ExAdminYesilDetailPopInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
	  ResultVO result = new ResultVO();
	  try {
        params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );

        ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );

        switch( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
          case commonCode.ERPIU :
           result.setParams( yesilServiceU.ExAdminIuYesilExpendDetailPop(params) );
           break;
          default :
        	  break;
        }

      } catch (Exception e) {
        cmLog.CommonSetError(e);
        throw e;
      }

	  return result;
	}

    /*예실대비현황2.0 미전송 결의 팝업 창*/
    /*예실대비현황2.0 팝업창 상단 리스트 */
    /* 이준성 개발 중 */
	@Override
	public ResultVO ExAdminIuYesilExpendTop(Map<String, Object> params) throws Exception{
      cmLog.CommonSetInfo( "Call ExAdminYesilDetailPopInfo(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
	  ResultVO result = new ResultVO();

	  try {
        params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo(), params);

        ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );

        switch( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
          case commonCode.ERPIU :
           result.setParams( yesilServiceU.ExAdminIuYesilExpendTop(params) );
           break;
          default :
        	  break;
        }

      } catch (Exception e) {
        cmLog.CommonSetError(e);
        throw e;
      }

	  return result;
	}






	/* Biz - 예실대비현황 */
	/* Biz - 예실대비현황 - 관리자 */ /* iCUBE */
	/* Biz - 예실대비현황 - 관리자 - 예실대비 지출결의현황 조회시 그룹웨어내 미전송 지출결의서 확인 */
	@Override
	public ResultVO ExAdminYesilnoExpendSend ( Map<String, Object> params ) throws Exception {
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
					result.setParams( yesilServiceI.ExAdminYesilnoExpendSend( params ) );
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
