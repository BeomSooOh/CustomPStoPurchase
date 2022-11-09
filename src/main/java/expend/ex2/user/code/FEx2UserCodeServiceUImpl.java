/**
  * @FileName : FEx2UserCodeServiceUImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.code;

import java.util.ArrayList;
//import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FEx2UserCodeServiceUImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FEx2UserCodeServiceU" )
public class FEx2UserCodeServiceUImpl implements FEx2UserCodeService {

	@Resource ( name = "FEx2UserCodeServiceUDAO" )
	private FEx2UserCodeServiceUDAO dao;

	public ResultVO getCommonCodeListSelect ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* parameters : sourceType, codeType */
		/* return : masterCode, masterCodeName, detailCode, detailCodeName */
		try {
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ).equals( commonCode.ERPIU ) ) {
				/* 변수정의 */
				boolean chkParameter = true;
				/* 필수 파라미터 검증 */
				String[] parametersCheck = { "erpCompSeq", "Y", "codeType", "Y" };
				if ( !MapUtil.hasParameters( result.getParams( ), parametersCheck ) ) {
					result.setFail( "필수 입력 정보가 누락되었습니다." );
					chkParameter = false;
				}
				/* 데이터 조회 */
				if ( chkParameter ) {
					result.setAaData( dao.getCommonCodeListSelect( conVo, result.getParams( ) ) );
					result.setSuccess( );
				}
			}
			else {
				result.setAaData( new ArrayList<Map<String, Object>>( ) );
				result.setFail( "ERPiU와 연동되지 않았습니다." );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	@Override
	public ResultVO insertEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception {
		throw new NotFoundLogicException( "ERPiU 미지원 기능입니다.", commonCode.ERPIU );
	}

	@Override
	public ResultVO updateEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception {
		throw new NotFoundLogicException( "ERPiU 미지원 기능입니다.", commonCode.ERPIU );
	}

	@Override
	public ResultVO selectEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception {
		throw new NotFoundLogicException( "ERPiU 미지원 기능입니다.", commonCode.ERPIU );
	}
}
