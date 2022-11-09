/**
  * @FileName : FEx2UserExpendService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.expend;

import common.vo.common.ResultVO;


/**
 *   * @FileName : FEx2UserExpendService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FEx2UserExpendService {

	/* 접대비등록 생성 */
	ResultVO setEntertainmentFeeInsert ( ) throws Exception;

	/* 접대비등록 수정 */
	ResultVO setEntertainmentFeeUpdate ( ) throws Exception;

	/* 접대비등록 삭제 */
	ResultVO setEntertainmentFeeDelete ( ) throws Exception;

	/* 접대비등록 조회 */
	ResultVO setEntertainmentFeeSelect ( ) throws Exception;
}
