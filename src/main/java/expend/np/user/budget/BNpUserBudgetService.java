package expend.np.user.budget;

import java.util.Map;

import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;

public interface BNpUserBudgetService {
	
	/** ERP 예산 예산잔액 조회 */
	ResultVO selectERPBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/** ERP 예산 현액 정보 조회 */
	ResultVO selectiUBudgetInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/** ERP 예산 현액 정보 조회 */
	ResultVO selectG20BudgetInfo ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/** 품의서 잔액 조회 */
	ResultVO selectConsBudgetBalance ( Map<String, Object> params ) throws Exception;
	
	/** 품의서 잔액 조회 */
	ResultVO selectConsBudgetBalance ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/** 미전송 결의액 조회 */
	ResultVO selectResUseAmt ( Map<String, Object> params ) throws Exception;
	
	/** 미전송 결의액 조회 */
	ResultVO selectResUseAmt ( Map<String, Object> params, ConnectionVO conVo ) throws Exception;
	
	/** 품의서 잔액 조회 [예실대비현황] */
	ResultVO selectConsBudgetBalanceForYesil ( Map<String, Object> params ) throws Exception;
	
	/** 미전송 결의액 조회 [예실대비현황]*/
	ResultVO selectResUseAmtForYesil ( Map<String, Object> params ) throws Exception;
	
	/** 품의서 품의액 조회 */
	ResultVO selectConsAmt ( Map<String, Object> params ) throws Exception;
	
	/** 결의서 결의액 조회 */
	ResultVO selectResAmt ( Map<String, Object> params ) throws Exception;
	
	/** 문서 예산별 총 금액 조회 */
	ResultVO selectTryAmt ( Map<String, Object> params ) throws Exception;
	
	/** 참조품의서 예산정보 조회 */
	ResultVO selectConfferBudgetInfo ( Map<String, Object> params ) throws Exception;
	
	/** 참조품의서 예산(금액)정보 조회 */
	ResultVO selectConfferBudgetBalanceAmt ( Map<String, Object> params ) throws Exception;
	
	/** 참조품의서 예산정보 업데이트 */
	ResultVO updateConfferBudgetInfo(Map<String, Object> params) throws Exception;

	ResultVO selectConfferTryAmt(Map<String, Object> params) throws Exception;
	
}
