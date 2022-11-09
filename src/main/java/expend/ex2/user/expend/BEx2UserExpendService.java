/**
  * @FileName : BEx2UserExpendService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.expend;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BEx2UserExpendService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BEx2UserExpendService {

	/* 접대비 등록 / 수정 / 삭제 */
	ResultVO setEntertainmentFee ( ResultVO result ) throws Exception;
}
