/**
  * @FileName : FAcUserProcessService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.process;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;


/**
 *   * @FileName : FAcUserProcessService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FAcUserProcessService {

	/* G20 품의 / 결의서 */
	/* G20 품의 / 결의서 - 회계기수목록정보 조회 */
	List<Map<String, Object>> AcExErpGisuListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* G20 품의 / 결의서 - 사용자정보 조회 */
	Map<String, Object> AcExErpEmpInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* G20 품의 / 결의서 - 사용자목록정보 조회 */
	List<Map<String, Object>> AcExErpEmpListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* G20 품의 / 결의서 - 양식정보 조회 */
	Map<String, Object> AcExFormInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* G20 공통코드 조회 */
	/* G20 공통코드 조회 - 프로젝트 */
	List<Map<String, Object>> AcExErpProjectListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* G20 공통코드 조회 - 부서 */
	List<Map<String, Object>> AcExErpDeptListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;

	/* G20 공통코드 조회 - 입출금계좌 */
	List<Map<String, Object>> AcExErpBankTradeListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;
	//	/* 사용자 ERP 기준 정보 조회 */
	//	ResultVO AcExG20EmpInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;
	//
	//	/* ERP 기수 정보 조회 */
	//	ResultVO AcExG20GisuListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;
	//
	//	/* 양식 정보 조회 */
	//	ResultVO AcExFormInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;
	//
	//	/* G20 사원조회 */
	//	ResultVO AcExErpUserListInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) throws Exception;
}
