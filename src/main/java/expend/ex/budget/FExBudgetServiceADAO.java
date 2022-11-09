package expend.ex.budget;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExExpendVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository ( "FExBudgetServiceADAO" )
public class FExBudgetServiceADAO extends EgovComAbstractDAO {

	/* 공통코드 - BizboxA - 예산확인 for iCUBE */
	public ExCodeBudgetVO ExiCUBEBudgetAmtInfoSelect ( ExCodeBudgetVO budgetVo ) throws Exception {
		budgetVo = (ExCodeBudgetVO) select( "ExCodeiCUBEBudgetAmtInfoSelect", budgetVo );
		return budgetVo;
	}

	/* 공통코드 - BizboxA - 예산확인 for ERPiU */
	public ExCodeBudgetVO ExERPiUBudgetAmtInfoSelect ( ExCodeBudgetVO budgetVo ) throws Exception {
		budgetVo = (ExCodeBudgetVO) select( "ExERPiUBudgetAmtInfoSelect", budgetVo );
		return budgetVo;
	}

	@SuppressWarnings ( "unchecked" )
	public List<ExCodeBudgetVO> ExExpendUseBudgetInfoSelect ( ExExpendVO expendVo ) throws Exception {
		return list( "ExExpendUseBudgetInfoSelect", expendVo );
	}

    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
    @SuppressWarnings("unchecked")
    public List<ExCodeBudgetVO> ExExpendUseBudgetInfoSelect2(ExExpendVO expendVo) throws Exception {
        return list("ExExpendUseBudgetInfoSelect2", expendVo);
    }

	/* 전자결재 외부연동 결재 호출 후 지출결의 기본정보 가져오기 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExInterlockCompInfoSelect ( Map<String, Object> params ) throws Exception {
		Map<String, Object> resultMap = new HashMap<String, Object>( );
		try {
			resultMap = (Map<String, Object>) select( "ExInterlockCompInfoSelect", params );
		}
		catch ( Exception e ) {
			e.printStackTrace();
		}
		return resultMap;
	}

	/* 항목 차변,대변 금액 일치 확인 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendSlipAmtChkSelect ( Map<String, Object> params ) throws Exception {
		return list( "ExExpendErrorAmtChkSelect", params );
	}

	/* 분개 차변,대변 금액 일치 확인 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExExpendSlipAmtChkSelectSlipMode ( Map<String, Object> params ) throws Exception {
		return list( "ExExpendSlipAmtChkSelectSlipMode", params );
	}

	/* rowid 생성 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExInterlockERPiUBudgetInfoSelect ( Map<String, Object> params ) throws Exception {
		return list( "ExInterlockERPiUBudgetInfoSelect", params );
	}

	/* rowid 정보 가져오기 */
	@SuppressWarnings ( "unchecked" )
	public List<Map<String, Object>> ExInterlockERPiURowInfoSelect ( Map<String, Object> params ) throws Exception {
		return list( "ExInterlockERPiURowInfoSelect", params );
	}

	/* 예산 체크 시 현재 작성중인 지출결의의 동일한 예산정보 금액 조회 */
	@SuppressWarnings ( "unchecked" )
	public Map<String, Object> ExSameBudgetInfoSelect ( Map<String, Object> params ) throws Exception {
		Map<String, Object> result = new HashMap<String, Object>( );
		try {
			result = (Map<String, Object>) select( "ExSameBudgetInfoSelect", params );
		}
		catch ( Exception e ) {
			e.printStackTrace( );
		}
		return result;
	}

    /* 예산 체크 시 현재 작성중인 지출결의의 동일한 예산정보 금액 조회 ( ERPiU 전용 - 상위예산 조회 기능 ) */
    @SuppressWarnings("unchecked")
    public Map<String, Object> ExSameBudgetInfoSelectERPiU(Map<String, Object> params) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = (Map<String, Object>) select("ExSameBudgetInfoSelectERPiU", params);
            result = (result == null ? new HashMap<String, Object>() : result);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
