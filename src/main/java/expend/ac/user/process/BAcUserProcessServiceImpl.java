/**
  * @FileName : BAcUserProcessServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.process;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BAcUserProcessServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BAcUserProcessService" )
public class BAcUserProcessServiceImpl implements BAcUserProcessService {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FAcUserProcessServiceI" )
	private FAcUserProcessService IService; /* iCUBE 서비스 */
	@Resource ( name = "FAcUserProcessServiceA" )
	private FAcUserProcessService AService; /* 비영리 결재 서비스 */
	@Resource ( name = "FAcUserProcessServiceP" )
	private FAcUserProcessService PService; /* 영리 결재 서비스 */
	/* 변수정의 - Class */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* G20 품의 / 결의서 */
	/* G20 품의 / 결의서 - 회계기수목록정보 조회 */
	@Override
	public ResultVO AcExErpGisuListInfo ( Map<String, Object> params ) throws Exception {
		return null;
	}

	/* G20 품의 / 결의서 - 사용자정보 조회 */
	public ResultVO AcExErpEmpInfo ( Map<String, Object> params ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 지정 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params ); /* 사용자 정보 적용 및 변수 재정의 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) ); /* ERP 연결 설정 정보 조회 */
			/* 연동시스템별 정보 처리 *//* iCUBE 연동이면서 G20인 경우만 지원 */
			if ( CommonConvert.CommonGetNP( conVo ) ) {
				switch ( CommonConvert.CommonGetStr( params.get( commonCode.EATYPE ) ) ) {
					case commonCode.EA: /* 비영리 */
					case commonCode.EAP: /* 영리 */
						resultVo.setaData( IService.AcExErpEmpInfoSelect( conVo, params ) );
						resultVo.setResultCode( commonCode.SUCCESS );
					default:
						resultVo.setResultCode( commonCode.FAIL );
						resultVo.setResultName( "연동 전자결재 구분값이 확인되지 않습니다." );
						break;
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return resultVo;
	}

	/* G20 품의 / 결의서 - 사용자목록정보 조회 */
	@Override
	public ResultVO AcExErpEmpListInfo ( Map<String, Object> params ) throws Exception {
		return null;
	}

	/* G20 품의 / 결의서 - 양식정보 조회 */
	public ResultVO AcExFormInfo ( Map<String, Object> params ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 지정 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params ); /* 사용자 정보 적용 및 변수 재정의 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) ); /* ERP 연결 설정 정보 조회 */
			/* 연동시스템별 정보 처리 *//* iCUBE 연동이면서 G20인 경우만 지원 */
			if ( CommonConvert.CommonGetNP( conVo ) ) {
				switch ( CommonConvert.CommonGetStr( params.get( commonCode.EATYPE ) ) ) {
					case commonCode.EA: /* 비영리 */
						resultVo.setaData( AService.AcExFormInfoSelect( conVo, params ) );
						resultVo.setResultCode( commonCode.SUCCESS );
						break;
					case commonCode.EAP: /* 영리 */
						resultVo.setaData( PService.AcExFormInfoSelect( conVo, params ) );
						resultVo.setResultCode( commonCode.SUCCESS );
						break;
					default:
						resultVo.setResultCode( commonCode.FAIL );
						resultVo.setResultName( "연동 전자결재 구분값이 확인되지 않습니다." );
						break;
				}
			}
			else {
				resultVo.setResultCode( commonCode.FAIL );
				resultVo.setResultName( "ERP 연동설정이 G20으로 설정되지 않았습니다." );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return resultVo;
	}

	/* G20 공통코드 조회 */
	public ResultVO AcExErpCommonCodeListInfo ( Map<String, Object> params ) throws Exception {
		ResultVO resultVo = new ResultVO( );
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 지정 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params ); /* 사용자 정보 적용 및 변수 재정의 */
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) ); /* ERP 연결 설정 정보 조회 */
			/* 연동시스템별 정보 처리 *//* iCUBE 연동이면서 G20인 경우만 지원 */
			if ( CommonConvert.CommonGetNP( conVo ) ) {
				switch ( CommonConvert.CommonGetStr( params.get( commonCode.EATYPE ) ) ) {
					case commonCode.EA: /* 비영리 */
					case commonCode.EAP: /* 영리 */
						switch ( CommonConvert.CommonGetStr( params.get( "type" ) ) ) {
							case "project": /* 프로젝트 *//* 프로젝트별 예산 사용 */
								resultVo.setAaData( IService.AcExErpProjectListInfoSelect( conVo, params ) );
								break;
							case "dept": /* 부서 *//* 부서별 예산 사용 */
								resultVo.setAaData( IService.AcExErpDeptListInfoSelect( conVo, params ) );
								break;
							case "bankTrade": /* 입출금계좌 */
								resultVo.setAaData( IService.AcExErpBankTradeListInfoSelect( conVo, params ) );
								break;
							default :
								break;
						}
						break;
					default:
						resultVo.setResultCode( commonCode.FAIL );
						resultVo.setResultName( "연동 전자결재 구분값이 확인되지 않습니다." );
						break;
				}
			}
			else {
				resultVo.setResultCode( commonCode.FAIL );
				resultVo.setResultName( "ERP 연동설정이 G20으로 설정되지 않았습니다." );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return resultVo;
	}
	//	/* G20 품의/결의 작성 Init */
	//	public ResultVO AcExDocInit ( Map<String, Object> params ) throws Exception {
	//		ResultVO result = new ResultVO( );
	//		try {
	//			/* 기본값 지정 */
	//			/* 기본값 지정 - 사용자 정보 처리 */
	//			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
	//			/* 기본값 지정 - 연동 시스템 정보 처리 */
	//			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
	//			/* 기본값 지정 - 파라미터 공통 변환 */
	//			params = CommonConvert.CommonSetMapCopy( params );
	//			result.setParams( params );
	//			/* 연동시스템별 정보 처리 *//* iCUBE 연동이면서 G20 인 경우만 지원 */
	//			if ( CommonConvert.CommonGetNP( conVo ) ) {
	//				/* 변수정의 */
	//				Map<String, Object> resultData = new HashMap<String, Object>( );
	//				/* 사용자 ERP 기준 정보 조회 */
	//				params.put( "erpCompSeq", params.get( commonCode.ERPCOMPSEQ ) );
	//				params.put( "erpEmpSeq", params.get( commonCode.ERPEMPSEQ ) );
	//				params.put( "langCode", "KR" );
	//				resultData.put( "erpEmpInfo", processIService.AcExG20EmpInfoSelect( conVo, params ).getaData( ) );
	//				/* ERP 기수 정보 조회 */
	//				resultData.put( "erpGisuListInfo", processIService.AcExG20GisuListInfoSelect( conVo, params ).getAaData( ) );
	//				/* 시스템 시간 조회 */
	//				SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy-MM-dd" );
	//				resultData.put( "erpGisuDate", (String) dateFormat.format( new Date( ) ) );
	//				/* 양식 정보 조회 */
	//				result.setaData( resultData );
	//			}
	//			else {
	//				throw new Exception( "[iCUBE G20 전용기능] ERP 연동 정보를 확인해 주세요." );
	//			}
	//		}
	//		catch ( Exception e ) {
	//			// TODO: handle exception
	//		}
	//		return result;
	//	}
	//
	//	/* G20 사원조회 */
	//	public ResultVO AcExErpUserListInfo ( Map<String, Object> params ) throws Exception {
	//		ResultVO result = new ResultVO( );
	//		try {
	//			/* 기본값 지정 */
	//			/* 기본값 지정 - 사용자 정보 처리 */
	//			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
	//			/* 기본값 지정 - 연동 시스템 정보 처리 */
	//			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
	//			/* 기본값 지정 - 파라미터 공통 변환 */
	//			params = CommonConvert.CommonSetMapCopy( params );
	//			result.setParams( params );
	//			/* 연동시스템별 정보 처리 *//* iCUBE 연동이면서 G20 인 경우만 지원 */
	//			if ( CommonConvert.CommonGetNP( conVo ) ) {
	//				processIService.AcExErpUserListInfoSelect( conVo, params );
	//			}
	//			else {
	//				throw new Exception( "[iCUBE G20 전용기능] ERP 연동 정보를 확인해 주세요." );
	//			}
	//		}
	//		catch ( Exception e ) {
	//			// TODO: handle exception
	//		}
	//		return result;
	//	}
}
