/**
  * @FileName : FAcUserProcessServicePDAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.process;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FAcUserProcessServicePDAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAcUserProcessServicePDAO" )
public class FAcUserProcessServicePDAO extends EgovComAbstractDAO {

	@SuppressWarnings ( "unchecked" )
	//public Map<String, Object> AcExFormInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
	public Map<String, Object> AcExFormInfoSelect ( Map<String, Object> params ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "PGwAcCode.AcExFormInfoSelect", params );
		return result;
	}
}
