/**
  * @FileName : FApprovalServiceADAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.adv;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FApprovalServiceADAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAdvInterServiceADAO" )
public class FAdvInterServiceADAO extends EgovComAbstractDAO {
	/* 외부 데이터 추가 연동 로직 조회 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> SelectResCMSCardTradeInfo ( Map<String, Object> params ) throws Exception{
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
		result = (List<Map<String, Object>>) list( "NpUserOutInterfaceA.SelectResCMSCardTradeInfo", params );		
		return result;
	}
}