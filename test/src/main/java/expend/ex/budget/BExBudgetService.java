package expend.ex.budget;

import java.util.List;
import java.util.Map;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendVO;


public interface BExBudgetService {

    // 예산사용여부 및 예산단위 가져오기
    Map<String, Object> ExBudgetUseInfoSelect(Map<String, Object> params) throws Exception;

    // 예산계정과목 조회
    ExCodeBudgetVO ExBudgetAmtInfoSelect(Map<String, Object> params) throws Exception;

    // 예산계정과목 조회
    ExCodeBudgetVO ExBudgetAmtInfoSelect2(Map<String, Object> params) throws Exception;

    ExCodeBudgetVO ExBudgetAmtInfoSelect3(Map<String, Object> params) throws Exception;

    // 예산초과확인
    List<ExCommonResultVO> ExBudgetErrorInfoSelect(ExExpendVO expendVo) throws Exception;

    // 예산초과확인 수정
    List<ExCommonResultVO> ExBudgetErrorInfoSelect2(ExExpendVO expendVo) throws Exception;

    // 인터락 예산확인
    Boolean ExInterlockUseBudgetInfoSelect(Map<String, Object> params) throws Exception;

    // 항목 차변,대변 금액 일치 확인
    List<ExCommonResultVO> ExExpendSlipAmtChkSelect(Map<String, Object> params) throws Exception;

    // 분개단위 입력 시 차/대변 금액 일치 여부 확인
    List<ExCommonResultVO> ExExpendSlipAmtChkSelectSlipMode(Map<String, Object> params) throws Exception;

    // 인터락 ERPiU Row정보 생성
    Boolean ExInterLockERPiURowInsert(Map<String, Object> params) throws Exception;

    // 인터락 ERPiU Row정보 삭제
    Boolean ExInterLockERPiURowDelete(Map<String, Object> params) throws Exception;

    // 카드,계산서 반영 시 예산 체크 로직
    ResultVO ExInterfaceBudgetInfoCheck(Map<String, Object> params, ConnectionVO conVo) throws Exception;

    // 카드, 계산서 반영 시 예산 체크 로직(ERPiU 상위레벨 예산 체크 포함)
    ResultVO ExInterfaceBudgetInfoCheck2(Map<String, Object> params, ConnectionVO conVo) throws Exception;
}
