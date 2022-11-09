/**
  * @FileName : FAcUserProcessServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.process;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonAcConnect;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FAcUserProcessServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAcUserProcessServiceADAO" )
public class FAcUserProcessServiceADAO extends EgovComAbstractDAO {

	/* 변수정의 - class */
	CommonAcConnect connector = new CommonAcConnect( );

	/* 양식정보 조회 */
	@SuppressWarnings ( "unchecked" )
	//public Map<String, Object> AcExFormInfoSelect ( ConnectionVO conVo, Map<String, Object> params ) {
	public Map<String, Object> AcExFormInfoSelect ( Map<String, Object> params ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = (Map<String, Object>) select( "PGwAcCode.AcExFormInfoSelect", params );
		return result;
	}
}
