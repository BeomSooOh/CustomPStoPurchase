/**
  * @FileName : BAnguUserCardService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.card;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BAnguUserCardService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BAnguUserCardService {

	/* 집행등록 - 국고보조사업 귀속 카드 */
	public ResultVO AnguCardInfoS ( ResultVO result ) throws Exception;

	/* 집행등록 - 카드 사용 내역 코드 조회 */
	public ResultVO AnguCardListInfoS ( ResultVO result ) throws Exception;
}
