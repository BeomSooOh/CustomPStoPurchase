package expend.ex.admin.card;

import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import common.helper.connection.CommonExConnect;
import common.helper.logger.ExpInfo;
import common.vo.common.ConnectionVO;


@Repository("FExAdminConfigCardSyncServiceUDAO")
public class FExAdminConfigCardSyncServiceUDAO {

    /* 변수정의 - class */
    CommonExConnect connector = new CommonExConnect();

    /* 주석없음 */
    /**
     *   * @Method Name : ExCommonCodeCardSelect   * @변경이력 :   * @메뉴 :   * @Method 설명 : 주석없음   * @param params   * @param conVo   * @return   * @throws Exception   
     */
    public List<Map<String, Object>> ExCommonCodeCardSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {

        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        /* parameters : erp_comp_seq, search_str, search_str */
        List<Map<String, Object>> result = connector.List(conVo, "AdminiUConfig.ExCommonCodeCardSelect", params);
        return result;
    }
}
