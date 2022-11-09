package devmanager.cms;

import java.util.List;
import java.util.Map;


public interface FDevManagerCMSService {

	/**
	 *   * @Method Name : SelectCMSLogList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : CMS 연동 로그정보를 조회합니다. 기본 조회 최신 10건 로그 조회
	 *   * @param param
	 *   * @return
	 *   
	 */
	public List<Map<String, Object>> SelectCMSLogList ( Map<String, Object> param );
}
