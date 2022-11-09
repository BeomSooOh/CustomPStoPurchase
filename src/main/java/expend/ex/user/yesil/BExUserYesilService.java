package expend.ex.user.yesil;

import java.util.Map;

import common.vo.common.ResultVO;

public interface BExUserYesilService {

	ResultVO ExUserYesilSendParam(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesilInfoSelect(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesilDetailSelect(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesilPop(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesil2SendParam(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesil2BudgetGrInfo(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesil2BudgetDeptInfo(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesil2BizPlanInfo(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesil2BudgetAcctInfo(Map<String, Object> params) throws Exception;

	ResultVO ExUserYesil2InfoSelect(Map<String, Object> params) throws Exception;
	
	ResultVO ExUserYesilnoExpendSend(Map<String, Object> params) throws Exception;

}
