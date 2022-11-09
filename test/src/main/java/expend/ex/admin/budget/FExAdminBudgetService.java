package expend.ex.admin.budget;

import java.util.List;
import java.util.Map;


/**
 *   * @FileName : FExAdminBudgetService.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public interface FExAdminBudgetService {

	/**
	 *   * @Method Name : getOrgUnitList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	public List<Map<String, Object>> getOrgUnitList ( Map<String, Object> params ) throws Exception;

	/**
	 *   * @Method Name : getOrgListSearch
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	public List<Map<String, Object>> getOrgListSearch ( Map<String, Object> params ) throws Exception;

	/**
	 *   * @Method Name : getOrgInfoList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	public List<Map<String, Object>> getOrgInfoList ( Map<String, Object> params ) throws Exception;

	/**
	 *   * @Method Name : insertOrgBaseInfo
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	public boolean insertOrgBaseInfo ( Map<String, Object> params ) throws Exception;

	/**
	 *   * @Method Name : chkBudgetAmt
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 :
	 *   * @param params
	 *   * @return
	 *   
	 */
	public Map<String, Object> chkBudgetAmt ( Map<String, Object> params ) throws Exception;
}