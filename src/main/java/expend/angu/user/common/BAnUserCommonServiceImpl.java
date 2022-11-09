/**
  * @FileName : BAnUserCommonServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.common;

import java.util.Map;

import org.springframework.stereotype.Service;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BAnUserCommonServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BAnUserCommonService" )
public class BAnUserCommonServiceImpl implements BAnUserCommonService {

	public ResultVO AnCommonCheck ( ConnectionVO conVo, ResultVO result ) throws Exception {
		try {
			if ( !(CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ).equals( commonCode.ERPIU )) && !(CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ).equals( commonCode.ICUBE )) ) {
				/* 1. iCUBE 연동 설정 정보 확인 */
				result.setResultCode( commonCode.FAIL );
				result.setResultName( "EPR 연동 설정 정보를 확인해주세요. ( 관리자 > 시스템설정 > 회사/조직 관리 > 회사정보관리 > 연동 정보 )" );
				return result;
			}
			else {
				/* 2. iCUBE G20 연동 설정 정보 확인 */
				if ( !(CommonConvert.CommonGetStr( conVo.getG20YN( ) ).equals( commonCode.EMPTYYES )) ) {
					result.setResultCode( commonCode.FAIL );
					result.setResultName( "EPR 연동 설정 정보를 확인해주세요. ( 관리자 > 시스템설정 > 회사/조직 관리 > 회사정보관리 > 연동 정보 )\r\niCUBE G20 버전만 지원합니다." );
					return result;
				}
			}
			if ( CommonConvert.CommonGetStr( result.getErpCompSeq( ) ).equals( commonCode.EMPTYSTR ) ) {
				/* 3. 회사 EPR 회사 맵핑 확인 */
				result.setResultCode( commonCode.FAIL );
				result.setResultName( "EPR 연동 설정 정보를 확인해주세요. ( 관리자 > 시스템설정 > 회사/조직 관리 > 회사정보관리 > 연동 정보 )" );
				return result;
			}
			if ( CommonConvert.CommonGetStr( result.getErpEmpSeq( ) ).equals( commonCode.EMPTYSTR ) ) {
				/* 4. 사용자 ERP 사원번호 맵핑 확인 */
				result.setResultCode( commonCode.FAIL );
				result.setResultName( "ERP사번 설정 정보를 확인해주세요. ( 관리자 > 시스템설정 > 사원관리 > 사원정보관리 > ERP사번 )" );
				return result;
			}
			result.setResultCode( commonCode.SUCCESS );
			result.setResultName( "국고보조금통합시스템 연동 사용을 위한 ERP 연동설정이 정상적으로 되어있습니다." );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	public ResultVO AnCommonCheckParam ( ResultVO result, Map<String, Object> params, String key ) throws Exception {
		try {
			if ( CommonConvert.CommonGetStr( params.get( key ) ).equals( commonCode.EMPTYSTR ) ) {
				result.setResultCode( commonCode.FAIL );
				result.setResultName( "필수값이 수신되지 않았습니다. ( " + commonCode.ERPCOMPSEQ + " )" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
}
