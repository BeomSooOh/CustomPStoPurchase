/**
  * @FileName : FExAdminAcctService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.acct;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


/**
 *   * @FileName : FExAdminAcctService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FExAdminAcctService {

	/* ################################################## */
	/* [810000000]..회계 */
	/* ################################################## */
	/* ################################################## */
	/* [810200000]..└ 지출결의 설정 */
	/* ################################################## */
	/* ################################################## */
	/* [810201000]....└ 계정과목 설정 */ /* 관리자 > 회계 > 지출결의 설정 > 계정과목 설정 */
	/* ################################################## */
	/* 계정과목 목록 조회 */
	ResultVO ExAdminConfigAcctListInfoSelect ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* 계정과목 등록 & 수정 */
	ResultVO ExAdminConfigAcctInfoInsert ( ConnectionVO conVo, ResultVO result ) throws Exception;

	/* 계정과목 삭제 */
	ResultVO ExAdminConfigAcctInfoDelete ( ConnectionVO conVo, ResultVO result ) throws Exception;
}
