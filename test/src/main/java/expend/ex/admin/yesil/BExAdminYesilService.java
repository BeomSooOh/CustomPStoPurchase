package expend.ex.admin.yesil;

import java.util.Map;

import common.vo.common.ResultVO;


public interface BExAdminYesilService {
	
	ResultVO ExAdminYesilPop(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesilInfoSelect(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesilDetailSelect(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesilSendParam(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesil2SendParam(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesil2DeptInfo(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesil2BudgetGrInfo(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesil2BudgetDeptInfo(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesil2BizPlanInfo(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesil2BudgetAcctInfo(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesil2InfoSelect(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesilDetailPopInfo(Map<String, Object> params) throws Exception;

	ResultVO ExAdminYesil2DetailPopInfo(Map<String, Object> params) throws Exception;
	
	ResultVO ExAdminYesilnoExpendSend(Map<String, Object> params) throws Exception;
	
	ResultVO ExAdminIuYesilExpendsend(Map<String, Object> params) throws Exception;
	
	ResultVO ExAdminIuYesilExpendTop(Map<String, Object> params) throws Exception;
	
	
	
}
