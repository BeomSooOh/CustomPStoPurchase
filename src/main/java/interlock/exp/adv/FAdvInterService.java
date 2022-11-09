/**
  * @FileName : FAdvInterService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.adv;

import java.util.Map;

import common.vo.common.ResultVO;

/**
 *   * @FileName : FAdvInterService.java   * @Project : BizboxA_exp   * @변경이력 :
 *   * @프로그램 설명 :   
 */
public interface FAdvInterService {

	/** 법인카드 승인내역 GW결재 상태 연동 */
	ResultVO UpdateICubeCardGwState(Map<String, Object> params) throws Exception;
	
	/** 한아세안센터 전용개발 CODE : 001 */
	String advMethod001(Map<String, Object> params) throws Exception;
}