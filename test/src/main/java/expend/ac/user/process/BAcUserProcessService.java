/**
  * @FileName : BAcUserProcessService.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.process;

import java.util.Map;

import common.vo.common.ResultVO;


/**
 *   * @FileName : BAcUserProcessService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface BAcUserProcessService {

	/* G20 품의 / 결의서 */
	/* G20 품의 / 결의서 - 회계기수목록정보 조회 */
	ResultVO AcExErpGisuListInfo ( Map<String, Object> params ) throws Exception;

	/* G20 품의 / 결의서 - 사용자정보 조회 */
	ResultVO AcExErpEmpInfo ( Map<String, Object> params ) throws Exception;

	/* G20 품의 / 결의서 - 사용자목록정보 조회 */
	ResultVO AcExErpEmpListInfo ( Map<String, Object> params ) throws Exception;

	/* G20 품의 / 결의서 - 양식정보 조회 */
	ResultVO AcExFormInfo ( Map<String, Object> params ) throws Exception;

	/* G20 공통코드 조회 */
	ResultVO AcExErpCommonCodeListInfo ( Map<String, Object> params ) throws Exception;
	/* G20 품의/결의 작성 Init */
	/* ResultVO AcExDocInit ( Map<String, Object> param ) throws Exception; */
	/* G20 사원조회 */
	/* ResultVO AcExErpUserListInfo ( Map<String, Object> params ) throws Exception; */
}
