/**
 *   * @FileName : FEx2UserCodeServiceUDAO.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
package expend.ex2.user.code;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import common.helper.connection.CommonExConnect;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


/**
 *   * @FileName : FEx2UserCodeServiceUDAO.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
@Repository("FEx2UserCodeServiceUDAO")
public class FEx2UserCodeServiceUDAO extends EgovComAbstractDAO {

    CommonExConnect connector = new CommonExConnect();

    public List<Map<String, Object>> getCommonCodeListSelect(ConnectionVO conVo, Map<String, Object> param) throws Exception {
        /* parameters : sourceType, codeType */
        /* return : masterCode, masterCodeName, detailCode, detailCodeName */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = connector.List(conVo, "Ex2UserCode.Ex2UserCodeCommonCodeListSelect", param);
        return result;
    }

    public List<Map<String, Object>> insertEntertainmentFee(ConnectionVO conVo, Map<String, Object> param) throws Exception {
        /* parameters : 미정 */
        /* return : fee_seq */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = connector.List(conVo, "Ex2UserCodeCommonCodeListSelect", param);
        return result;
    }
}
