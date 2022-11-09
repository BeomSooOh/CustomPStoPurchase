package expend.ex.budget;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Repository;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCommonResultVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import main.web.BizboxAMessage;


@Repository("FExBudgetServiceUDAO")
public class FExBudgetServiceUDAO extends EgovComAbstractDAO {

    /* 변수정의 - Common */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
    /* 변수정의 - class */
    CommonExConnect connector = new CommonExConnect();

    // 예산사용 여부 가져오기
    public Map<String, Object> ExBudgetUseInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        Map<String, Object> resultMap = new HashMap<String, Object>();
        /* parameters : erp_comp_seq, search_str, search_str */
        try {
            if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
                params.put("P_AM_JSUM", null);
                params.put("P_AM_ACTSUM", null);
                params.put("P_YN_CONTROL", null);

                connector.Select(conVo, "ExUserCode.ERPiUBudgetInfoSelect", params);

                if (params.get("P_AM_JSUM") == null || params.get("P_AM_ACTSUM") == null || params.get("P_YN_CONTROL") == null) {
                    resultMap.put("budgetControlYN", "B");
                } else {
                    resultMap.put("budgetJsum", params.get("P_AM_JSUM").toString());
                    resultMap.put("budgetActsum", params.get("P_AM_ACTSUM").toString());
                    resultMap.put("budgetControlYN", params.get("P_YN_CONTROL").toString());
                }
            } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
                resultMap = connector.Select(conVo, "ExUserCode.ERPiUBudgetInfoSelect", params);
            }
        } catch (Exception e) {
            throw e;
        }
        return resultMap;
    }

    /* 공통코드 - 예산확인 */
    public ExCodeBudgetVO ExBudgetAmtInfoSelect(ExCodeBudgetVO budgetVo, ConnectionVO conVo) throws Exception {
        if (budgetVo.getErpCompSeq() == null || budgetVo.getErpCompSeq().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        ExCodeBudgetVO erpBudgetVo = new ExCodeBudgetVO();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap = CommonConvert.CommonGetObjectToMap(budgetVo);
        try {

            if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
                paramMap.put("P_AM_JSUM", null);
                paramMap.put("P_AM_ACTSUM", null);
                paramMap.put("P_YN_CONTROL", null);

                /*
                 * OUTPUT 으로 데이터를 넘겨 받기 때문에 따로 return 존재 무의미 paramMap에 이미 전달 받을 데이터 KEY값을 미리생성
                 */
                connector.OutputSelect(conVo, "ExUserCode.ERPiUBudgetInfoSelect", paramMap);
                if (paramMap.get("P_AM_JSUM") == null || paramMap.get("P_AM_ACTSUM") == null || paramMap.get("P_YN_CONTROL") == null) {
                    erpBudgetVo = new ExCodeBudgetVO();
                    erpBudgetVo.setBudgetControlYN("B");
                } else {
                    erpBudgetVo.setBudgetJsum(paramMap.get("P_AM_JSUM").toString());
                    erpBudgetVo.setBudgetActsum(paramMap.get("P_AM_ACTSUM").toString());
                    erpBudgetVo.setBudgetControlYN(paramMap.get("P_YN_CONTROL").toString());
                }
            } else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
                erpBudgetVo = (ExCodeBudgetVO) CommonConvert.CommonGetMapToObject(connector.Select(conVo, "ExUserCode.ERPiUBudgetInfoSelect", paramMap), erpBudgetVo);
                if (erpBudgetVo == null) {
                    erpBudgetVo = new ExCodeBudgetVO();
                    erpBudgetVo.setBudgetControlYN("B");
                }
            }
        } catch (Exception e) {
            throw e;
        }
        return erpBudgetVo;
    }

    public ExCodeBudgetVO UP_FI_Z_BIZBOX_BUDGET_DATA(ExCodeBudgetVO budget, ConnectionVO con) throws Exception {
        if (budget.getErpCompSeq() == null || budget.getErpCompSeq().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        ExCodeBudgetVO erpBudgetVo = new ExCodeBudgetVO();
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap = CommonConvert.CommonGetObjectToMap(budget);

        try {
            if (CommonConvert.CommonGetStr(con.getDatabaseType()).equals(commonCode.ORACLE)) {
            	// do nothing

            } else if (CommonConvert.CommonGetStr(con.getDatabaseType()).equals(commonCode.MSSQL)) {
                erpBudgetVo = (ExCodeBudgetVO) CommonConvert.CommonGetMapToObject(connector.Select(con, "ExUserCode.UP_FI_Z_BIZBOX_BUDGET_DATA", paramMap), erpBudgetVo);

                if (erpBudgetVo == null) {
                    erpBudgetVo = new ExCodeBudgetVO();
                    erpBudgetVo.setBudgetControlYN("B");
                }
            }
        } catch (Exception e) {
            throw e;
        }

        return erpBudgetVo;
    }

    /* 지출결의 */
    /* 지출결의 - 임시예산 등록 */
    public ExCommonResultVO ExExpendGmmsumOtherInfoInsert(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            connector.Insert(conVo, "ExExpendGmmsumOtherInfoInsert", params);
            resultVo.setCode(commonCode.SUCCESS);
            resultVo.setMessage(BizboxAMessage.getMessage("TX000009301", "정상처리되었습니다"));
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }

    /* 지출결의 - 임시예산 삭제 */
    public ExCommonResultVO ExExpendGmmsumOtherInfoDelete(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            connector.Delete(conVo, "ExExpendGmmsumOtherInfoDelete", params);
            resultVo.setCode(commonCode.SUCCESS);
            resultVo.setMessage(BizboxAMessage.getMessage("TX000009301", "정상처리되었습니다"));
        } catch (Exception e) {
            throw e;
        }
        return resultVo;
    }
}
