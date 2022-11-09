package interlock.api.ex;

import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;

@Service("FApiServiceADAO")
public class FApiServiceADAO extends EgovComAbstractDAO {

    //private org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 카드 승인 내역 조회
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> GetCardGeorae(Map<String, Object> param) throws Exception {
        return (Map<String, Object>) this.select("InterlockAPiEx.GetCardGeorae", param);
    }

    /**
     * 카드 상태값 업데이트
     */
    public int SetCardGeoraeSendYn(Map<String, Object> param) throws Exception {
        return this.update("InterlockAPiEx.SetCardGeoraeSendYn", param);
    }
}
