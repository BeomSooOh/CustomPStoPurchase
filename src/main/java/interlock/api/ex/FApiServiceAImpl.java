package interlock.api.ex;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;

@Service("FApiServiceA")
public class FApiServiceAImpl {

    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    @Resource(name = "FApiServiceADAO")
    private FApiServiceADAO dao;

    // 카드 내역을 조회합니다.
    public Map<String, Object> GetCardGeorae(Map<String, Object> param) throws Exception {

        Map<String, Object> card = new HashMap<String, Object>();

        try {
            if (!param.containsKey("syncId") || param.get("syncId") == null || param.get("syncId").toString().equals("") || param.get("syncId").toString().equals("0")) {
                logger.error("syncId가 수신되지 않았습니다.");
                throw new Exception("syncId가 수신되지 않았습니다.");
            }

            card = dao.GetCardGeorae(param);
        } catch (Exception e) {
            throw new Exception(e);
        }

        return card;
    }

    // 카드 내역 상태값을 업데이트합니다.
    public int SetCardGeoraeSendYn(Map<String, Object> param) throws Exception {

        int updateCount = 0;

        try {
            if (!param.containsKey("syncId") || param.get("syncId") == null || param.get("syncId").toString().equals("") || param.get("syncId").toString().equals("0")) {
                logger.error("syncId가 수신되지 않았습니다.");
                throw new Exception("syncId가 수신되지 않았습니다.");
            }

            if (!param.containsKey("sendYn") || param.get("sendYn") == null || param.get("sendYn").toString().equals("")) {
                logger.error("sendYn가 수신되지 않았습니다.");
                throw new Exception("sendYn가 수신되지 않았습니다.");
            }

            if (!param.get("sendYn").toString().equals("Y") && !param.get("sendYn").toString().equals("N")) {
                logger.error("상태값이 잘못 전달되었습니다. sendYn 값은 [Y, N] 만 허용됩니다.");
                throw new Exception("상태값이 잘못 전달되었습니다. sendYn 값은 [Y, N] 만 허용됩니다.");
            }

            updateCount = dao.SetCardGeoraeSendYn(param);
        } catch (Exception e) {
            throw new Exception(e);
        }

        return updateCount;
    }


}
