/**
  * @FileName : BExAdminAcctService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex.admin.acct;

import java.util.Map;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BExAdminAcctService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BExAdminAcctService {

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
	ResultVO ExAdminConfigAcctListInfoSelect ( ResultVO result ) throws Exception;

	/* 계정과목 등록 & 수정 */
	ResultVO ExAdminConfigAcctInfoInsert ( ResultVO result ) throws Exception;

	/* 계정과목 등록 & 수정 */
	ResultVO ExAdminConfigAcctInfoDelete ( ResultVO result ) throws Exception;

	/* 계정과목 설정 JSP 전달 파라미터 정의 */
	Map<String, Object> ExAdminAcctConfigSendParam ( ) throws Exception;
}
