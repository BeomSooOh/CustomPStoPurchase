package expend.ex.admin.yesil2;

import java.util.List;
import java.util.Map;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface FExAdminYesil2Service {


    Map<String, Object> ExAdminYesilIuSendParam(Map<String, Object> params, ConnectionVO conVo) throws Exception;
    List<Map<String, Object>> ExAdminIuYesilInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception;
    ResultVO ExAdminYesilList(Map<String, Object> params, ConnectionVO conVo) throws Exception;
    ResultVO ExAdminYesilBizPlanCheck(Map<String, Object> params, ConnectionVO conVo)throws Exception;
    
}
