/**
  * @FileName : ErpUtil.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package cmm.util;

import common.helper.convert.CommonConvert;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;


/**
 *   * @FileName : ErpUtil.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class ErpUtil {

	public static ResultVO Chk_G20 ( ConnectionVO conVo, ResultVO result ) throws Exception {
		try {
			if ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ).equals( commonCode.ICUBE ) ) {
				if ( CommonConvert.CommonGetStr( conVo.getG20YN( ) ).equals( commonCode.EMPTYYES ) ) {
					result.setSuccess( );
				}
				else {
					result.setFail( "(iCUBE G20 지원) EPR 연동 설정 정보를 확인해주세요. ( 관리자 > 시스템설정 > 회사/조직 관리 > 회사정보관리 > 연동 정보 )" );
				}
			}
			else {
				result.setFail( "(iCUBE G20 지원) EPR 연동 설정 정보를 확인해주세요. ( 관리자 > 시스템설정 > 회사/조직 관리 > 회사정보관리 > 연동 정보 )" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	public static ResultVO Chk_iCUBE ( ConnectionVO conVo, ResultVO result ) throws Exception {
		try {
			if ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ).equals( commonCode.ICUBE ) ) {
				result.setSuccess( );
			}
			else {
				result.setFail( "(iCUBE 지원) EPR 연동 설정 정보를 확인해주세요. ( 관리자 > 시스템설정 > 회사/조직 관리 > 회사정보관리 > 연동 정보 )" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	public static ResultVO Chk_ERPiU ( ConnectionVO conVo, ResultVO result ) throws Exception {
		try {
			if ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ).equals( commonCode.ERPIU ) ) {
				result.setSuccess( );
			}
			else {
				result.setFail( "(ERPiU 지원) EPR 연동 설정 정보를 확인해주세요. ( 관리자 > 시스템설정 > 회사/조직 관리 > 회사정보관리 > 연동 정보 )" );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}
}
