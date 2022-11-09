package common.batch.cms;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import common.helper.connection.CommonBatchCmsConnect;
import common.helper.connection.CommonErpConnect;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;


@Repository("CommonBatchCmsERPiUDAO")
public class CommonBatchCmsERPiUDAO {

    /* 변수정의 */
    /* 변수정의 - Class */
    CommonErpConnect conn = new CommonErpConnect();
    CommonBatchCmsConnect connector = new CommonBatchCmsConnect();
    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    CommonLogger cmLog;

    /* Batch - CMS - ERPiU */
    /* Batch - CMS - ERPiU - Select */
    public List<Map<String, Object>> CommonCmsERPiUInfoListSelect(ConnectionVO conVo, Map<String, Object> params) throws Exception {
        /* key : ACCT_NO, BANK_CODE, TRADE_DATE, TRADE_TIME, SEQ */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = connector.List(conVo, "BatchCmsERPiU.CommonCmsERPiUInfoListSelect", params);
        return result;
    }

    /* Batch - CMS - ERPiU - Update */
    public int CommonCmsERPiUInfoListUpdate(ConnectionVO conVo, List<Map<String, Object>> params) throws Exception {
        /* key : ACCT_NO, BANK_CODE, TRADE_DATE, TRADE_TIME, SEQ */
        int result = 0;
        /* >> List 전달로 변경 개발 필요 */
        for (Map<String, Object> map : params) {
            result += connector.Update(conVo, "BatchCmsERPiU.CommonCmsERPiUInfoListUpdate", map);
        }
        if (result != params.size()) {
            result = 0;
        }
        return result;
    }

    /* Batch - CMS - ERPiU - Select - 프로시저 */ /* Z_GWA_EXPCMS_S_iU */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> CommonCmsERPiUInfoListSelect_Procedure(ConnectionVO conVo, Map<String, Object> params) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        if (conVo.getDatabaseType().equals("mssql")) {
            result = connector.List(conVo, "BatchCmsERPiU.CommonCmsERPiUInfoListSelect_Procedure", params);
        } else {
            params.put("RC1", null);
            connector.List(conVo, "BatchCmsERPiU.CommonCmsERPiUInfoListSelect_Procedure", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        }

        return result;
    }
}
