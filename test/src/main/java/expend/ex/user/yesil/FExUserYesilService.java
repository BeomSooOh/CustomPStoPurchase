package expend.ex.user.yesil;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;

public interface FExUserYesilService {

	Map<String, Object> ExUserYesilSendParam(Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExUserYesilInfoSelect(Map<String, Object> params, ConnectionVO conVo)  throws Exception;

	List<Map<String, Object>> ExUserYesilDetailSelect( Map<String, Object> params, ConnectionVO conVo)  throws Exception;

	List<Map<String, Object>> ExUserYesilPop(Map<String, Object> params, ConnectionVO conVo) throws Exception;

	Map<String, Object> ExUserYesil2SendParam(Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExUserYesil2BudgetGrInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExUserYesil2BudgetDeptInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExUserYesil2BizPlanInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExUserYesil2BudgetAcctInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExUserYesil2InfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception;
	
	Map<String, Object> ExUserYesilnoExpendSend( Map<String, Object> params ) throws Exception;

}
