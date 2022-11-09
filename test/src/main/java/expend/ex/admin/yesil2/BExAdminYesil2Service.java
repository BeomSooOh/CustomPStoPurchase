package expend.ex.admin.yesil2;

import java.util.Map;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;


public interface BExAdminYesil2Service {

    ResultVO ExAdminIuYesilSendParam(Map<String, Object> params) throws Exception;
    ResultVO ExAdminYesilList(Map<String, Object> params, ConnectionVO conVo) throws Exception;
    ResultVO ExAdminIuYesilInfoSelect(Map<String, Object> params) throws Exception;
    ResultVO ExAdminYesilBizPlanCheck(Map<String, Object> params, ConnectionVO conVo) throws Exception;
}

