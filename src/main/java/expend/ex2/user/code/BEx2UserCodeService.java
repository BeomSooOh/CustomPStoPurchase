/**
  * @FileName : BEx2UserCodeService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.code;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BEx2UserCodeService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BEx2UserCodeService {

	/* 공통코드 조회 */
	ResultVO getCommonCodeListSelect ( ResultVO result ) throws Exception;

	/* 접대비 부표 저장 */
	ResultVO insertEntertainmentFee ( ResultVO result ) throws Exception;
	/* 접대비 부표 업데이트 */
	ResultVO updateEntertainmentFee ( ResultVO result ) throws Exception;
	/* 접대비 부표 조회 */
	ResultVO selectEntertainmentFee ( ResultVO result ) throws Exception;
}
