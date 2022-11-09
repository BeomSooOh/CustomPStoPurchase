package expend.ex.admin.yesil;

import java.util.List;
import java.util.Map;

import common.vo.common.ConnectionVO;

public interface FExAdminYesilService {

	List<Map<String, Object>> ExAdminYesilPop( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExAdminYesilInfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExAdminYesilDetailSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	Map<String, Object> ExAdminYesilSendParam(Map<String, Object> params, ConnectionVO conVo)  throws Exception;

	Map<String, Object> ExAdminYesil2SendParam( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExAdminYesil2DeptInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExAdminYesil2BudgetGrInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExAdminYesil2BudgetDeptInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExAdminYesil2BizPlanInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExAdminYesil2BudgetAcctInfo( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	List<Map<String, Object>> ExAdminYesil2InfoSelect( Map<String, Object> params, ConnectionVO conVo) throws Exception;

	Map<String, Object> ExAdminYesilDetailPopInfo( Map<String, Object> params ) throws Exception;

	Map<String, Object> ExAdminYesil2DetailPopInfo(Map<String, Object> params) throws Exception;
	
	Map<String, Object> ExAdminYesilnoExpendSend( Map<String, Object> params ) throws Exception;
	
	/*예실대비현황2.0 미전송 결의 팝업 창 메인 리스트 */
    Map<String, Object> ExAdminIuYesilExpendDetailPop(Map<String, Object> params) throws Exception;
    /*예실대비현황2.0 미전송 결의 팝업 창 상단 리스트 */
    Map<String, Object> ExAdminIuYesilExpendTop(Map<String, Object> params) throws Exception; 
	
	
}
