package expend.ex2.admin.code;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

@Service ( "BEx2AdminCodeService" )
public class BEx2AdminCodeServiceImpl implements BEx2AdminCodeService {
	
	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FEx2AdminCodeServiceA" )
	private FEx2AdminCodeService codeA; /* Bizbox Alpha */
	@Resource ( name = "FEx2AdminCodeServiceI" )
	private FEx2AdminCodeService codeI; /* ERP iCUBE */
	@Resource ( name = "FEx2AdminCodeServiceU" )
	private FEx2AdminCodeService codeU; /* ERP iU */
	@Resource ( name = "FEx2AdminCodeServiceE" )
	private FEx2AdminCodeService codeE; /* ERP ETC */
	/* 변수정의 - DAO */
	@Resource ( name = "FEx2AdminCodeServiceADAO" )
	private FEx2AdminCodeServiceADAO daoA; /* Bizbox Alpha */
	@Resource ( name = "FEx2AdminCodeServiceIDAO" )
	private FEx2AdminCodeServiceIDAO daoI; /* ERP iCUBE */
	@Resource ( name = "FEx2AdminCodeServiceUDAO" )
	private FEx2AdminCodeServiceUDAO daoU; /* ERP iU */
	@Resource ( name = "FEx2AdminCodeServiceEDAO" )
	private FEx2AdminCodeServiceEDAO daoE; /* ERP ETC */
	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	
	/* Biz - 공통코드 - 공통코드 조회 */
	@Override
	public ResultVO Ex2CommonCodeInfoSelect ( Map<String, Object> params ) throws Exception {
		cmLog.CommonSetInfo( "Call ExCommonCodeInfoSelect(params >> " + CommonConvert.CommonGetMapStr( params ) + ")" );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 지정 */
			/* 기존값 지정 - 사용자 정보 처리 */
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 지정 - 연동 시스템 정보 처리 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "erpCompSeq", conVo.getErpCompSeq( ) );
			if ( params.get( commonCode.COMPSEQ ) == null || params.get( commonCode.COMPSEQ ).equals( "" ) ) {
				params.put( commonCode.COMPSEQ, loginVo.getCompSeq( ) );
			}
			if ( params.get( commonCode.DEPTSEQ ) == null || params.get( commonCode.DEPTSEQ ).equals( "" ) ) {
				params.put( commonCode.DEPTSEQ, loginVo.getOrganId( ) );
			}
			if ( params.get( commonCode.EMPSEQ ) == null || params.get( commonCode.EMPSEQ ).equals( "" ) ) {
				params.put( commonCode.EMPSEQ, loginVo.getUserSe( ) );
			}
			if ( params.get( commonCode.ERPCOMPSEQ ) == null || params.get( commonCode.ERPCOMPSEQ ).equals( "" ) ) {
				params.put( commonCode.ERPCOMPSEQ, loginVo.getErpCoCd( ) );
			}
			if ( params.get( commonCode.GROUPSEQ ) == null || params.get( commonCode.GROUPSEQ ).equals( "" ) ) {
				params.put( commonCode.GROUPSEQ, loginVo.getGroupSeq( ) );
			}
			params.put( commonCode.USERSE, CommonConvert.CommonGetEmpInfo( ).get( commonCode.USERSE ) );
			FEx2AdminCodeService service = null;
			String errorStr = commonCode.EMPTYSTR;
			/* 연동시스템별 정보 처리 */
			switch ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ) ) {
				case commonCode.ICUBE: /* ERP iCUBE */
					service = codeI;
					errorStr = "Ex2CommonCodeInfoSelect - iCUBE - parameter not exists >> ";
					break;
				case commonCode.ERPIU: /* ERP iU */
					service = codeU;
					errorStr = "Ex2CommonCodeInfoSelect - ERPiU - parameter not exists >> ";
					break;
				case commonCode.ETC: /* ERP ETC *//* 타 ERP 대응 건 */
					service = codeE;
					errorStr = "Ex2CommonCodeInfoSelect - ETC - parameter not exists >> ";
					break;
				default: /* Bizbox Alpha */
					service = codeA;
					errorStr = "Ex2CommonCodeInfoSelect - Alpha - parameter not exists >> ";
					break;
			}
			/* 필수 파라미터 점검 */
			if ( !CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.BIZBOXA ) && CommonConvert.CommonGetStr( params.get( commonCode.ERPCOMPSEQ ) ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( errorStr + commonCode.ERPCOMPSEQ );
			}
			// 데이터 조회
			result.setAaData( service.Ex2AdminCommCodeSelect( params, conVo ) );
		}
		catch ( NotFoundLogicException e ) {
			/* iCUBE, iU, ETC erp에 없는 모듈 호출시 그룹웨어로 재시도 */
			if ( !e.GetTryConnType( ).equals( commonCode.BIZBOXA ) ) {
				ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( params.get( commonCode.COMPSEQ ) ) );
				result.setAaData( codeA.Ex2AdminCommCodeSelect( params, conVo ) );
			}
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		return result;
	}
}
