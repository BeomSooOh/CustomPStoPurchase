package expend.ex.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import common.helper.connection.CommonExConnect;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundDataException;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;

@Repository("FExAdminReportServiceUDAO")
public class FExAdminReportServiceUDAO {

    /* 변수정의 - class */
    CommonExConnect connector = new CommonExConnect();

    /* ERP - IU 자동전표 전송 */
    public int ExReportExpendErpSend(Map<String, Object> params, ConnectionVO conVo) throws Exception {

        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        int result = 0;
        try {
            /* ERP 결의서 전송 */
            result = connector.Insert(conVo, "AdminiUReport.ExFI_ADOCUInsert", params);
            if ((result > 0) && (Integer.parseInt(params.get("FEE_SEQ").toString()) != 0)) {
                /* 접대비 부표 전송. */
                int serviceResult = connector.Insert(conVo, "AdminiUReport.FI_RECEPTRELAInsert", params);
                if (serviceResult < 1) {
                    /* 접대비 부표 전송 실패 -> 결의서 전송 취소 */
                    connector.Delete(conVo, "AdminiUReport.ExFI_ADOCUDelete", params);
                    result = -1;
                }
            }
        } catch (Exception ex) {
            throw ex;
        }
        return result;
    }

    public Map<String, Object> ExReportKeySelect(ConnectionVO conVo, Map<String, Object> params) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        Map<String, Object> returnObj = new HashMap<String, Object>();
        try {
            returnObj = connector.Select(conVo, "AdminiUReport.ExFI_ADOCUKeySelect", params);
        } catch (Exception ex) {
            returnObj.put("ROW_NO", commonCode.EMPTYSEQ);
            returnObj.put("ROW_ID", commonCode.EMPTYSEQ);
        }
        return returnObj;
    }

    public int ExReportExpendSendInfoDelete(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        int result = 0;
        if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(CommonInterface.commonCode.ORACLE)) {
            int count = Integer.parseInt(String.valueOf(connector.Select(conVo, "ExFI_ADOCUDelete_01", params).get("count")));
            connector.Delete(conVo, "ExFI_ADOCUDelete_02", params);
            connector.Delete(conVo, "ExFI_ADOCUDelete_04", params);
            connector.Delete(conVo, "ExFI_ADOCUDelete_05", params);
            result = count - Integer.parseInt(String.valueOf(connector.Delete(conVo, "ExFI_ADOCUDelete_03", params)));
        } else {
            result = Integer.parseInt(connector.Select(conVo, "AdminiUReport.ExFI_ADOCUDelete", params).get("returnValue").toString());
        }
        if (result == 0) {
            throw new NotFoundDataException("연동된 ERP데이터를 찾을 수 없습니다.");
        }
        return result;
    }

    public int ExReportExpendReturnCountInfoSelect(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        int result = 0;
        try {
            result = Integer.parseInt(connector.Select(conVo, "AdminiUReport.ExCheckCanDelete", params).get("COUNT").toString());
        } catch (Exception e) {
            return 0;
        }
        return result;
    }
    
    /*
     * 준성 
     * ERP iU 전표 데이터 체크 
     * N:미처리
     * Y:처리
     * D:삭제
     * */ 
    public List<Map<String, Object>> ExReportExpendTpDocuInfoSelect(Map<String , Object > params, ConnectionVO conVo) throws Exception{
      if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
        ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
      }
      List<Map<String, Object>> result = new ArrayList<Map<String,Object>>();
      
      if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(CommonInterface.commonCode.ORACLE)) {
        result = connector.List(conVo, "ExCheckCancleTpDocu", params);
      }
      else {
        result = connector.List(conVo, "AdminiUReport.ExCheckCancleTpDocu", params); 
      }
      
      for (Map<String, Object> map : result) {
        /* 전표 발행 한 건이 존재하면 삭제 불가능 */
        if (map.size() > 0 && map.get("tpDocu").equals("Y")) {
          throw new NotFoundDataException("전표 발행이 진행된 문서입니다.");
        }
      }
      
      return result;
    }
    
    /*
     * 준성 
     * ERP iU전표 데이터 삭제 
     * */
    public ResultVO ExReportExpendSendDelete(Map<String, Object> params, ConnectionVO conVo) throws Exception {
      if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
        ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
      }
      ResultVO result = new ResultVO();
      if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(CommonInterface.commonCode.ORACLE)) {
        connector.Delete(conVo, "ExFI_ADOCUDelete_02", params);
        connector.Delete(conVo, "ExFI_ADOCUDelete_04", params);
        connector.Delete(conVo, "ExFI_ADOCUDelete_05", params);
        connector.Delete(conVo, "ExFI_ADOCUDelete_03", params);
      }else {
        result.setAaData(connector.List(conVo, "AdminiUReport.ExFiDocuDelete", params));
      }
      
      return result;
    }

    /* ERP 전송한 전표 삭제 */
    public ResultVO ExAdminExpendSendERPDataDelete(ResultVO params, ConnectionVO conVo) throws Exception {
        if (params.getParams().get("erpCompSeq") == null || params.getParams().get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        try {
            if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(CommonInterface.commonCode.ORACLE)) {
                Map<String, Object> map = new HashMap<String, Object>();
                // processYN
                int count = Integer.parseInt(String.valueOf(connector.Select(conVo, "ExAdminExpendSendERPDataDelete_01", params.getParams()).get("count")));
                if (count > 0) {
                    connector.Delete(conVo, "ExAdminExpendSendERPDataDelete_02", params.getParams());
                    connector.Delete(conVo, "ExAdminExpendSendERPDataDelete_03", params.getParams());
                    connector.Delete(conVo, "ExAdminExpendSendERPDataDelete_04", params.getParams());
                    map.put("processYN", "Y");
                } else {
                    map.put("processYN", "N");
                }
                params.addAaData(map);
            } else {
                params.setAaData(connector.List(conVo, "AdminiUReport.ExAdminExpendSendERPDataDelete", params.getParams()));
            }
        } catch (Exception e) {
        	throw e;
        }
        return params;
    }

    /* ERP 임시 예산삭제 */
    public ResultVO ExAdminExpendERPBudgetDelete(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        ResultVO result = new ResultVO();
        try {
            result.setAaData(connector.List(conVo, "AdminiUReport.ExAdminExpendERPBudgetDelete", params));
        } catch (Exception e) {
        	throw e;
        }
        return result;
    }

    /* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
    public List<Map<String, Object>> ExAdminETaxListInfoSelectMap(ExCodeETaxVO etaxVo, ConnectionVO conVo) throws Exception {
        if (etaxVo.getErpCompSeq() == null || etaxVo.getErpCompSeq().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>();
        try {
            Map<String, Object> param = CommonConvert.CommonGetObjectToMap(etaxVo);

            // 세금계산서 조회 테이블 옵션 조회
            String tpTbTaxCompany = connector.Select(conVo, "AdminiUReport.ExTaxListCompOption", param).get("tpTbTaxCompany").toString();
            param.put("tpTbTaxCompany", tpTbTaxCompany);
            etaxListVo = connector.List(conVo, "AdminiUReport.ExAdminETaxListInfoSelectMap", param);
        } catch (Exception e) {
            throw e;
        }
        return etaxListVo;
    }

    /* 매입전자세금계산서 - 해당 세금계산서의 사업장 정보 조회 (ERPiU 전용) */
    public ResultVO ExAdminETaxBizInfoSelect(ResultVO params, ConnectionVO conVo) throws Exception {
        if (params.getParams().get("erpCompSeq") == null || params.getParams().get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        try {

            // ERP 회사코드 통일
            params.getParams().put("erpCompSeq", params.getParams().get("erpCoCd"));
            String tpTbTaxCompany = connector.Select(conVo, "AdminiUReport.ExTaxListCompOption", params.getParams()).get("tpTbTaxCompany").toString();

            params.getParams().put("tpTbTaxCompany", tpTbTaxCompany);
            params.setAaData(connector.List(conVo, "AdminiUReport.ExAdminETaxBizInfoSelect", params.getParams()));
        } catch (Exception e) {
            throw e;
        }

        return params;
    }

    /* 지출결의 문서 링크 정보 전달 - 전송 */
    public void ExAdminDocLinkListInfoInsert(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        try {
            if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).equals(CommonInterface.commonCode.ORACLE)) {
                params.put("cdCompany", params.get("P_CD_COMPANY"));
                params.put("rowId", params.get("P_NO_DOCU"));
                connector.Delete(conVo, "ExFI_ADOCUDelete_04", params);
                connector.Insert(conVo, "AdminiUReport.ExAdminDocLinkList", params);
            } else {
                connector.Insert(conVo, "AdminiUReport.ExAdminDocLinkList", params);
            }
        } catch (Exception e) {
            throw e;
        }
    }

    @SuppressWarnings("unchecked")
    public void ExAdminDocAttachListInfoInsert(Map<String, Object> params, ConnectionVO conVo) throws Exception {
        if (params.get("erpCompSeq") == null || params.get("erpCompSeq").toString().equals("")) {
            ExpInfo.CoreLogNotLoop("ERP 회사코드를 확인할 수 없습니다. [" + Thread.currentThread().getStackTrace()[1].getClassName() + "." + Thread.currentThread().getStackTrace()[1].getMethodName() + "]", null);
        }

        try {
            if (params != null && params.get("fileList") != null && !(params.get("fileList") + "").equals("") && ((List<Map<String, Object>>) params.get("fileList")).size() > 0) {
                connector.Insert(conVo, "AdminiUReport.ExAdminDocAttachListInfoInsert", params);
            }
        } catch (Exception e) {
            throw e;
        }
    }
}
