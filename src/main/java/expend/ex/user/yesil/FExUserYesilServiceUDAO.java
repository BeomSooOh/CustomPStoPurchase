package expend.ex.user.yesil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Repository("FExUserYesilServiceUDAO")
public class FExUserYesilServiceUDAO extends EgovComAbstractDAO {

    /* 변수정의 - class */
    CommonExConnect connector = new CommonExConnect();

    public List<Map<String, Object>> ExUserYesil2CommonCode(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        if (conVo.getDatabaseType().equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            params.put("RC2", null);
            connector.List(conVo, "UseriUYesil2.ExUserYesil2CommonCode", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else {
            result = connector.List(conVo, "UseriUYesil2.ExUserYesil2CommonCode", params);
        }

        return result;
    }

    public List<Map<String, Object>> ExUserYesil2DeptInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = connector.List(conVo, "UseriUYesil2.ExUserYesil2DeptInfo", params);
        return result;
    }

    public List<Map<String, Object>> ExUserYesil2BudgetGr(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        if (conVo.getDatabaseType().equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "UseriUYesil2.ExUserYesil2BudgetGr", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else {
            result = connector.List(conVo, "UseriUYesil2.ExUserYesil2BudgetGr", params);
        }

        return result;
    }

    public List<Map<String, Object>> ExUserYesil2BudgetCodeSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = connector.List(conVo, "UseriUYesil2.ExUserYesil2BudgetCodeSelect", params);
        return result;
    }

    public List<Map<String, Object>> ExUserYesil2DetailAuth(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        if (conVo.getDatabaseType().equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "UseriUYesil2.ExUserYesil2DetailAuth", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else {
            result = connector.List(conVo, "UseriUYesil2.ExUserYesil2DetailAuth", params);
        }

        return result;
    }

    public List<Map<String, Object>> ExUserYesil2BizPlan(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        if (conVo.getDatabaseType().equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "UseriUYesil2.ExUserYesil2BizPlan", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else {
            result = connector.List(conVo, "UseriUYesil2.ExUserYesil2BizPlan", params);
        }

        return result;
    }

    public List<Map<String, Object>> ExUserYesil2BudgetAcctInfo(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        if (conVo.getDatabaseType().equals(commonCode.ORACLE)) {
            params.put("RC1", null);
            connector.List(conVo, "UseriUYesil2.ExUserYesil2BudgetAcctInfo", params);
            result = (List<Map<String, Object>>) params.get("RC1");
        } else {
            result = connector.List(conVo, "UseriUYesil2.ExUserYesil2BudgetAcctInfo", params);
        }
        return result;
    }

    public List<Map<String, Object>> ExUserYesil2InfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        ExpInfo.TempLog("[ERP_COMP_SEQ_Check - ERPiU] " + params.toString(), params);

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.ORACLE)) {
            result = connector.yesilList_oracle(conVo, "UseriUYesil2.ExUserYesil2InfoSelect", params);
        }else if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(commonCode.MSSQL)) {
        	result = connector.List(conVo, "UseriUYesil2.ExUserYesil2InfoSelect", params);
        }
        return result;
    }
    
    public Map<String, Object> ExUserYesil2DeptAuthority (Map<String, Object> params, ConnectionVO conVo) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        
        result = connector.Select(conVo, "UseriUYesil2.ExUserYesil2DeptAuthority", params);
       
        return result;
      
    }
    
    
}
