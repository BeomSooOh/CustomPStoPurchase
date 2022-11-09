/**
  * @FileName : BExAdminItemService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.item;

import java.util.Map;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BExAdminItemService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BExAdminItemService {

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
	ResultVO ExAdminConfigItemListInfoSelect ( ResultVO result ) throws Exception;

	/* 항목 설정 목록 저장 */
	ResultVO ExAdminConfigItemListInfoInsert ( ResultVO result ) throws Exception;

	/* 항목 설정 JSP 전달 파라미터 정의 */
	Map<String, Object> ExAdminItemConfigSendParam ( ) throws Exception;
}
