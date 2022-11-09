/**
  * @FileName : FEx2UserCodeServiceUImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.code;

//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import cmm.util.MapUtil;
//import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLogicException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FEx2UserCodeServiceAImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FEx2UserCodeServiceA" )
public class FEx2UserCodeServiceAImpl implements FEx2UserCodeService {

	@Resource ( name = "FEx2UserCodeServiceADAO" )
	private FEx2UserCodeServiceADAO dao;

	public ResultVO getCommonCodeListSelect ( ConnectionVO conVo, ResultVO result ) throws Exception {
		throw new NotFoundLogicException( "A 미지원 기능입니다.", commonCode.ERPIU );
	}

	@Override
	public ResultVO insertEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception {
		//return dao.insertEntertainmentFee( conVo, result.getParams( ) );
		return dao.insertEntertainmentFee( result.getParams( ) );
	}

	@Override
	public ResultVO updateEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception {
		//return dao.updateEntertainmentFee( conVo, result.getParams( ) );
		return dao.updateEntertainmentFee( result.getParams( ) );
	}

	@Override
	public ResultVO selectEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception {
		//return dao.selectEntertainmentFee( conVo, result.getParams( ) );
		return dao.selectEntertainmentFee( result.getParams( ) );
	}
}
