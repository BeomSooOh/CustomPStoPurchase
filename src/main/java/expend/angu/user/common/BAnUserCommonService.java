/**
  * @FileName : BAnUserCommonService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.common;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : BAnUserCommonService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BAnUserCommonService {

	public ResultVO AnCommonCheck ( ConnectionVO conVo, ResultVO result ) throws Exception;

	public ResultVO AnCommonCheckParam ( ResultVO result, Map<String, Object> params, String key ) throws Exception;
}
