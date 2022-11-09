package expend.ex.budget;

import java.util.Map;
import common.vo.common.ConnectionVO;
import common.vo.ex.ExCodeBudgetVO;

public interface FExBudgetServiceI {
    // 예산사용여부
    Map<String, Object> ExBudgetUseInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception;

    // 아이큐브 예산확인
    ExCodeBudgetVO ExBudgetAmtInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception;

    // 아이큐브 예산확인
    ExCodeBudgetVO ExBudgetAmtInfoSelect2(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception;

    // ERPiU 예산체크
    ExCodeBudgetVO UP_FI_Z_BIZBOX_BUDGET_DATA(ExCodeBudgetVO budget, ConnectionVO con) throws Exception;
}
