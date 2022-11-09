package expend.ex.user.etax;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import common.vo.common.CommonInterface;
import org.springframework.stereotype.Repository;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("FExUserEtaxServiceUDAO")
public class FExUserEtaxServiceUDAO extends EgovComAbstractDAO {
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
    private final CommonExConnect exConnect = new CommonExConnect();

    /* 지출결의 - 매입전자세금계산서 목록 조회 */
    public List<ExCodeETaxVO> ExETaxListInfoSelect(ExCodeETaxVO etaxVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + etaxVo.toString(), etaxVo);

        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(CommonInterface.commonCode.ORACLE)) {
            etaxVo.setBaseEmailAddr(etaxVo.getBaseEmailAddr().toLowerCase());
            etaxVo.setTrchargeEmail(etaxVo.getTrchargeEmail().toLowerCase());
        }

        List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>();
        try {
            Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);
            List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

            // ERP 회사코드 통일
            param.put("erpCompSeq", etaxVo.getCoCd());
            String tpTbTaxCompany = exConnect.Select(conVo, "ExUserERPiUETax.ExTaxListCompOption", param).get("tpTbTaxCompany").toString();

            param.put("tpTbTaxCompany", tpTbTaxCompany);
            result = exConnect.List(conVo, "ExETaxListInfoSelect", param);
            for (int i = 0; i < result.size(); i++) {
                etaxListVo.add((ExCodeETaxVO) result.get(i));
            }
        } catch (Exception e) {
            throw e;
        }
        return etaxListVo;
    }

    /* 지출결의 - 매입전자세금계산서 조회 */
    public ExCodeETaxVO ExETaxDetailInfoSelect(ExCodeETaxVO etaxVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + etaxVo.toString(), etaxVo);

        try {
            Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);


            String tpTbTaxCompany = exConnect.Select(conVo, "ExUserERPiUETax.ExTaxListCompOption", param).get("tpTbTaxCompany").toString();
            param.put("tpTbTaxCompany", tpTbTaxCompany);
            param = exConnect.Select(conVo, "ExETaxDetailInfoSelect", param);

            CommonConvert.CommonGetMapToObject(param, etaxVo);
        } catch (Exception e) {
            throw e;
        }
        return etaxVo;
    }

    /* ERPiU 매입전자세금계산서 정보 업데이트 진행 */
    public int ExETaxInfoUpdate(ResultVO param, ConnectionVO conVo) {
    	ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + conVo.toString(), conVo);
    	ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + param.toString(), param);
    	/* 변수정의 */
        int result = 0;
        // result = exConnect.Update( conVo, "ExETaxInfoUpdate", param.getParams( ) );
        return result;
    }

    /* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
    public List<Map<String, Object>> ExETaxListInfoSelectMap(ExCodeETaxVO etaxVo, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + etaxVo.toString(), etaxVo);

        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(CommonInterface.commonCode.ORACLE)) {
            etaxVo.setBaseEmailAddr(etaxVo.getBaseEmailAddr().toLowerCase());
            etaxVo.setTrchargeEmail(etaxVo.getTrchargeEmail().toLowerCase());
        }

        List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>();
        try {
            Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);

            String tpTbTaxCompany = exConnect.Select(conVo, "ExUserERPiUETax.ExTaxListCompOption", param).get("tpTbTaxCompany").toString();
            param.put("tpTbTaxCompany", tpTbTaxCompany);
            etaxListVo = exConnect.List(conVo, "ExETaxListInfoSelectMap", param);
        } catch (Exception e) {
            throw e;
        }
        return etaxListVo;
    }

    /* 매입전자세금계산서 - 매입전자세금계산서 귀속 사업장 정보 조회 */
    public Map<String, Object> ExETaxBizareaInfoSelectMap(Map<String, Object> p, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + p.toString(), p);

        Map<String, Object> map = new HashMap<String, Object>();

        try {
            map = exConnect.Select(conVo, "ExETaxBizareaInfoSelectMap", p);
        } catch (Exception e) {
            throw e;
        }

        return map;
    }

    /* 매입전자세금계산서 - ERPiU 매입전자세금계산서 옵션 조회 */
    public ExCodeETaxVO ExTaxListCompOption(ExCodeETaxVO etaxVo, ConnectionVO conVo) throws Exception {
    	 ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + etaxVo.toString(), etaxVo);

         try {
             Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);

             String tpTbTaxCompany = exConnect.Select(conVo, "ExUserERPiUETax.ExTaxListCompOption", param).get("tpTbTaxCompany").toString();
             etaxVo.setTpTbTaxCompany(tpTbTaxCompany);

         } catch (Exception e) {
             throw e;
         }
         return etaxVo;
    }
}
