package devmanager.langpack;

import java.util.Map;


public interface FDevManagerLangPackService {

	/**
	 *   * @Method Name : SelectLanguageList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 다국어 코드 데이터 조회
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	Map<String, Object> SelectLanguageList ( Map<String, Object> params ) throws Exception;

	/**
	 *   * @Method Name : InsertOrUpdateLanguageData
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 다국어 코드 생성 및 업데이트
	 *   * @param params
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	int InsertOrUpdateLanguageData ( Map<String, Object> params ) throws Exception;
}
