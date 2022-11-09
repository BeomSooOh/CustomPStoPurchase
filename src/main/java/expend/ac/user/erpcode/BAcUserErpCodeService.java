/**
  * @FileName : BAcUserErpCodeService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.erpcode;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;


/**
 *   * @FileName : BAcUserErpCodeService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BAcUserErpCodeService {

	/* G20 사용자 정보 조회 */
	Map<String, Object> AcErpCodeUserInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* G20 프로젝트 정보 조회 */
	List<Map<String, Object>> AcErpCodeProjectListInfoSelect ( Map<String, Object> params ) throws Exception;

	/* G20 사원 정보 조회 */
	List<Map<String, Object>> AcErpCodeEmpListInfoSelect ( Map<String, Object> params ) throws Exception;

	/* G20 입출금계좌 조회 */
	List<Map<String, Object>> AcErpCodeBtrListInfoSelect ( Map<String, Object> params ) throws Exception;
}
