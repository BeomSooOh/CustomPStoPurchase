/**
  * @FileName : FEx2UserCodeService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.code;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FEx2UserCodeService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FEx2UserCodeService {

	ResultVO getCommonCodeListSelect ( ConnectionVO conVo, ResultVO result ) throws Exception;
	
	ResultVO insertEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception;
	ResultVO updateEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception;
	ResultVO selectEntertainmentFee ( ConnectionVO conVo, ResultVO result ) throws Exception;
}
