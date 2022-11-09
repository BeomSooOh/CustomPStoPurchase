/**
  * @FileName : FExAdminItemService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.item;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FExAdminItemService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FExAdminItemService {

	/* ################################################## */
	/* [810000000]..회계 */
	/* ################################################## */
	/* ################################################## */
	/* [810200000]..└ 지출결의 설정 */
	/* ################################################## */
	/* ################################################## */
	/* [810208000]....└ 항목 설정 */ /* 관리자 > 회계 > 지출결의 설정 > 항목 설정 */
	/* ################################################## */
	/* 항목 설정 목록 조회 */
	ResultVO ExAdminConfigItemListInfoSelect ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* 항목 설정 목록 저장 */
	ResultVO ExAdminConfigItemListInfoInsert ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* 항목 설정 초기화 */
	ResultVO ExAdminConfigItemListDelete ( ConnectionVO conVo, ResultVO result ) throws Exception;
}
