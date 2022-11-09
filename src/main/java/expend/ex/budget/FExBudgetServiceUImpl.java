package expend.ex.budget;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.ex.ExCodeBudgetVO;



@Service("FExBudgetServiceU")
public class FExBudgetServiceUImpl implements FExBudgetServiceI {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 변수정의 - Common */
    @Resource(name = "FExBudgetServiceUDAO")
    private FExBudgetServiceUDAO exBudgetDAO;
    @Resource(name = "FExBudgetServiceADAO")
    private FExBudgetServiceADAO exBudgetServiceADAO;
    /* 변수정의 - Class */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    // 예산사용여부 및 예산단위 가져오기
    @Override
    public Map<String, Object> ExBudgetUseInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        return exBudgetDAO.ExBudgetUseInfoSelect(params, conVo);
    }

    /* 공통코드 */
    /* 공통코드 - ERPiU + 그룹웨어 - 예산확인 */
    @Override
    public ExCodeBudgetVO ExBudgetAmtInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        ExCodeBudgetVO temp = new ExCodeBudgetVO();
        temp = budgetVo;
        try {
            /* ERPiU 예산잔액 조회 및 통제구분 조회 */
            if (budgetVo.getBudgetYm() != null && budgetVo.getBudgetYm().length() == 6) {
                budgetVo.setBudgetYm(budgetVo.getBudgetYm() + "01");
            }
            budgetVo = exBudgetDAO.ExBudgetAmtInfoSelect(budgetVo, conVo);
            /* ERPiU는 상신 시 임시예산을 등록하므로 그룹웨어 예산을 조회 할 필요가 없다. (2017-01-03 / 신재호) */
            if (budgetVo != null) {
                // 예산단위
                budgetVo.setBudgetCode(temp.getBudgetCode());
                budgetVo.setBudgetName(temp.getBudgetName());
                // 사업계획
                budgetVo.setBizplanCode(temp.getBizplanCode());
                budgetVo.setBizplanName(temp.getBizplanName());
                // 예산계정
                budgetVo.setBgacctCode(temp.getBgacctCode());
                budgetVo.setBgacctName(temp.getBgacctName());
                // budget_type
                budgetVo.setBudgetType(temp.getBudgetType());
                // 예산년월
                if (temp.getBudgetYm().length() == 8) {
                    temp.setBudgetYm(temp.getBudgetYm().substring(0, 4) + temp.getBudgetYm().substring(4, 6));
                }
                budgetVo.setBudYm(temp.getBudYm());
                budgetVo.setBudgetYm(temp.getBudgetYm());
                budgetVo.setAmt(temp.getAmt());
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            e.printStackTrace();
            throw e;
        }
        return budgetVo;
    }


    /* 공통코드 */
    /* 공통코드 - ERPiU + 그룹웨어 - 예산확인 */
    @Override
    public ExCodeBudgetVO ExBudgetAmtInfoSelect2(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        ExCodeBudgetVO temp = new ExCodeBudgetVO();
        temp = budgetVo;
        try {
            /* ERPiU 예산잔액 조회 및 통제구분 조회 */
            if (budgetVo.getBudgetYm() != null && budgetVo.getBudgetYm().length() == 6) {
                budgetVo.setBudgetYm(budgetVo.getBudgetYm() + "01");
            }
            budgetVo = exBudgetDAO.ExBudgetAmtInfoSelect(budgetVo, conVo);
            /* ERPiU는 상신 시 임시예산을 등록하므로 그룹웨어 예산을 조회 할 필요가 없다. (2017-01-03 / 신재호) */
            if (budgetVo != null) {
                // 예산단위
                budgetVo.setBudgetCode(temp.getBudgetCode());
                budgetVo.setBudgetName(temp.getBudgetName());
                // 사업계획
                budgetVo.setBizplanCode(temp.getBizplanCode());
                budgetVo.setBizplanName(temp.getBizplanName());
                // 예산계정
                budgetVo.setBgacctCode(temp.getBgacctCode());
                budgetVo.setBgacctName(temp.getBgacctName());
                // budget_type
                budgetVo.setBudgetType(temp.getBudgetType());
                // 예산년월
                if (temp.getBudgetYm().length() == 8) {
                    temp.setBudgetYm(temp.getBudgetYm().substring(0, 4) + temp.getBudgetYm().substring(4, 6));
                }
                budgetVo.setBudYm(temp.getBudYm());
                budgetVo.setBudgetYm(temp.getBudgetYm());
                budgetVo.setAmt(temp.getAmt());

                /* 현재 작성중인 분개 정보 중 동일한 예산정보의 금액을 더해준다. */
                Map<String, Object> tResult = new HashMap<String, Object>();
                tResult.put("expendSeq", temp.getExpendSeq());
                tResult.put("budgetCode", temp.getBudgetCode());
                tResult.put("bizplanCode", temp.getBizplanCode().replace("***", ""));
                tResult.put("bgacctCode", temp.getBgacctCode());
                tResult.put("expendSeq", temp.getExpendSeq());
                tResult.put("listSeq", temp.getListSeq());
                tResult.put("slipSeq", temp.getSlipSeq());
                tResult.put("groupSeq", temp.getGroupSeq());
                /* 현재 작성중인 지출결의 정보 중 동일한 예산정보의 총합계금액을 구한다. */
                tResult = exBudgetServiceADAO.ExSameBudgetInfoSelect(tResult);
                /* iCUBE 예산금액과 그룹웨어 결의금액 계산 */
                BigDecimal iUJsum = new BigDecimal(budgetVo.getBudgetJsum());
                /* 결재 진행중 문서가 아니면 현재 작성중인 지결에서 동일한 예산정보의 금액들을 확인한다. */
                if ((tResult != null && tResult.get("isApproval") != null && CommonConvert.CommonGetStr(tResult.get("isApproval")).equals(commonCode.EMPTYNO)) || temp.getIsComeHistory()) {
                    BigDecimal gwTotalJsum = new BigDecimal(tResult.get("totalBudgetAmt").toString());
                    iUJsum = iUJsum.add(gwTotalJsum);
                }

                budgetVo.setBudgetJsum(iUJsum.toString());
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionAsStrting = sw.toString();
            e.printStackTrace();
            throw e;
        }
        return budgetVo;
    }

    // ERPiU 예산확인
    @Override
    public ExCodeBudgetVO UP_FI_Z_BIZBOX_BUDGET_DATA(ExCodeBudgetVO budget, ConnectionVO con) throws Exception {

        ExCodeBudgetVO apiResult = new ExCodeBudgetVO();

        try {
            // ERPiU는 상신시점 임시예산을 등록하므로 그룹웨어 예산을 조회할 필요가 없음.
            apiResult = exBudgetDAO.UP_FI_Z_BIZBOX_BUDGET_DATA(budget, con);
        } catch (Exception e) {
            // TODO: handle exception
        }

        return apiResult;
    }
}
