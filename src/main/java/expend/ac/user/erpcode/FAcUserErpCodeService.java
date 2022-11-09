/**
  * @FileName : FAcUserErpCodeService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.erpcode;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;


/**
 *   * @FileName : FAcUserErpCodeService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FAcUserErpCodeService {

	/* ERP 사원정보 조회 */
	Map<String, Object> AcErpCodeUserInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* ERP 기수정보 조회 */
	List<Map<String, Object>> AcErpCodeGisuInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* ERP 부서 예산 목록 조회 */
	List<Map<String, Object>> AcErpCodeDeptBudgetListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* ERP 프로젝트 예산 목록 조회 */
	List<Map<String, Object>> AcErpCodeProjectBudgetListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* ERP 사원 정보 조회 */
	List<Map<String, Object>> AcErpCodeEmpListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* ERP 입출근계좌 조회 */
	List<Map<String, Object>> AcErpCodeBtrListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;
}
