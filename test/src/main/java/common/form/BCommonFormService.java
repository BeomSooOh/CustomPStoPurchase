
package common.form;

import java.util.HashMap;
import java.util.Map;
import common.vo.common.ResultVO;


public interface BCommonFormService {

    ResultVO CommonFormSendParam(Map<String, Object> params) throws Exception;

    ResultVO CommonFormDataInfo(Map<String, Object> params) throws Exception;

    ResultVO CommonNPFormDataInfo(Map<String, Object> params) throws Exception;

    int CommonFormSave(Map<String, Object> params) throws Exception;

    int CommonNpFormSave(Map<String, Object> params) throws Exception;

    ResultVO NPDocMaker(Map<String, Object> params) throws Exception;

    ResultVO DocMaker(Map<String, Object> params) throws Exception;

    HashMap<String, Object> GetSampleData() throws Exception;

    ResultVO NpDocMake(Map<String, Object> params) throws Exception;

    String NpInterlockCodeQuery(Map<String, Object> params) throws Exception;

    /**
     * 전자결재 양식 옵션 정보 조회 - 접힘 / 펼침 기본 설정 조
     * 
     * @return
     * @throws Exception
     */
    Map<String, Object> CommonPFormOptionInfoSelect_ea230() throws Exception;
    
    ResultVO CommonAInterlockUpdate(Map<String, Object> params) throws Exception;
    
    ResultVO CommonPInterlockUpdate(Map<String, Object> params) throws Exception;

	ResultVO CopyInterlock(Map<String, Object> params) throws Exception;
}
