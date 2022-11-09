
package expend.ex.admin.report;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Repository;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExReportCardVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Repository("FExAdminReportServiceADAO")
public class FExAdminReportServiceADAO extends EgovComAbstractDAO {
    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 현황 */
    /* Bizbox Alpha - 지출결의 현황 - 목록 조회 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminExpendManagerReportListInfoSelect(Map<String, Object> params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("ExReportExpendAdmListInfoSelect", params);
        return result;
    }

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 상세 현황 */
    /* Bizbox Alpha - 지출결의 상세 현황 엑셀 다운로드 - 목록 조회 이준성 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExReportSlipExpendAdmListInfoSelectExcelDown(Map<String, Object> params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("ExAdminSlipReportA.ExReportSlipExpendAdmListInfoSelectExcelDown", params);
        return result;
    }

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 상세 현황 */
    /* Bizbox Alpha - 지출결의 상세 현황 - 목록 조회 이준성 totalCount */
    @SuppressWarnings("unchecked")
    public Map<String, Object> ExReportSlipExpendAdmListInfoSelectTotal(Map<String, Object> params) {
        return (Map<String, Object>) select("ExAdminSlipReportA.ExReportSlipExpendAdmListed_TOTALCOUNT", params);
    }

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 상세 현황 */
    /* Bizbox Alpha - 지출결의 상세 현황 - 목록 조회 이준성 Limit */
    public Map<String, Object> ExReportSlipExpendAdmListInfoSelected(Map<String, Object> params, PaginationInfo paginationInfo) {

        return listOfPaging2(params, paginationInfo, "ExAdminSlipReportA.ExReportSlipExpendAdmListed");
    }

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 확인 */
    /* Bizbox Alpha - 지출결의 확인 - 목록 조회 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminExpendCheckReportListInfoSelect(Map<String, Object> params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("ExReportExpendAdmCheckListInfoSelect", params);
        return result;
    }

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 확인 양식권한 */
    /* Bizbox Alpha - 지출결의 확인 - 양식권한별 목록 조회 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAuthFormExpendCheckReportListInfoSelect(Map<String, Object> params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("ExReportExpendAuthCheckListInfoSelect", params);
        return result;
    }

    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 확인 양식권한 */
    /* Bizbox Alpha - 지출결의 확인 - 엑셀다운로드(상세항목) */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAuthFormExpendCheckReportListInfoSelect2(Map<String, Object> params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("ExReportExpendAdmCheckListInfoSelect2", params);
        return result;
    }

    /* Bizbox Alpha - 카드 사용 현황 */
    /* Bizbox Alpha - 카드 사용 현황 - 목록 조회 */
    @SuppressWarnings("unchecked")
	public List<Map<String, Object>> ExAdminCardReportListInfoSelect(ExReportCardVO reportCardVO) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("ExAdminReportA.ExAdminCardUseReportListInfoSelect", reportCardVO);
        return result;
    }

    /* Bizbox Alpha - 카드 사용 현황 */
    /* Bizbox Alpha - 카드 사용 현황 - 엑셀데이터 조회 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminCardReportListInfoSelectForExcel(Map<String, Object> params) {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = list("ExAdminReportA.ExAdminCardReportListInfoSelectForExcel", params);
        return result;
    }

    /* Bizbox Alpha - 지출결의 전체 정보 조회 - iCUBE용 포멧 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminExpendReportListInfoSelect(Map<String, Object> params) {
        return list("ExAdminExpendSend.SelectExpendInfo", params);
    }

    /* Bizbox Alpha - 지출결의 전체 정보 조회 - iU용 포멧 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminExpendReportListInfoSelectU(Map<String, Object> params) {
        return list("ExAdminExpendSend.SelectExpendInfoU", params);
    }

    /* Bizbox Alpha - 그룹웨어 문서 정보 조회 iCUBE */
    @SuppressWarnings("unchecked")
    public Map<String, Object> ExAdminExpendReportDocInfoSelect(Map<String, Object> params) {
        return (Map<String, Object>) this.select("ExAdminExpendSend.SelectDocInfo", params);
    }

    /* Bizbox Alpha - 그룹웨어 전표정보 업데이트 iCUBE */
    public int ExAdminExpendReportUpdate(Map<String, Object> params) {
        return this.update("ExAdminExpendSend.SelectExpendUpdate", params);
    }

    /* Bizbox Alpha - 그룹웨어 전표정보 업데이트 iU */
    public int ExAdminExpendReportUpdateU(Map<String, Object> params) {
        return this.update("ExAdminExpendSend.SelectExpendUpdateU", params);
    }

    /* Bizbox Alpha - 그룹웨어 전표정보 연동 키 조회 */
    @SuppressWarnings("unchecked")
    public ResultVO ExAdminExpendReportKeySelect(Map<String, Object> params) {
        ResultVO result = new ResultVO();
        result.addAaData((Map<String, Object>) this.select("ExAdminReportA.ExAdminExpendManagerReportSelect", params));
        return result;
    }

    /* Bizbox Alpha - 그룹웨어 전표정보 삭제 iCUBE */
    public int ExAdminExpendReportKeyRollback(Map<String, Object> params) {
        int result = 0;
        if (CommonConvert.CommonGetStr(params.get(commonCode.EMPTYSEQ)).equals("")) {
            try {
                params.put(commonCode.EMPTYSEQ, CommonConvert.CommonGetEmpVO().getUniqId());
            } catch (NotFoundLoginSessionException e) {
            	e.printStackTrace();

            }
        }
        result = this.update("ExAdminReportA.ExAdminExpendReportKeyRollback", params);
        return result;
    }

    /* 
     * 해당 지출결의의 분개 정보 조회(dr만) 
     * 조회 쿼리 변경 - 준성 
     * */
    @SuppressWarnings("unchecked")
    public ResultVO ExAdminExpendDrSlipSelect(ResultVO param) {
        param.setAaData(this.list("ExAdminReportA.ExAdminExpendDrSlipSelect", param.getParams()));
        return param;
    }

    /* 해당 지출결의의 매입전자세금계산서 업데이트 */
    public ResultVO ExAdminExpendETaxInfoUpdate(ResultVO param) throws Exception {
        try {
            this.update("ExAdminExpendETaxInfoUpdate", param.getParams());
            param.setResultCode(commonCode.EMPTYYES);
        } catch (Exception e) {
            param.setResultCode(commonCode.EMPTYNO);
        }
        return param;
    }

    /* 해당 지출결의의 카드사용내역 업데이트 */
    public ResultVO ExAdminExpendCardInfoUpdate(ResultVO param) throws Exception {
        try {
            this.update("ExAdminExpendCardInfoUpdate", param.getParams());
            param.setResultCode(commonCode.EMPTYYES);
        } catch (Exception e) {
            param.setResultCode(commonCode.EMPTYNO);
        }
        return param;
    }

    /* 해당 지출결의의 전자결재 문서 삭제 처리 */
    public ResultVO ExAdminAppdocDelete(ResultVO param) throws Exception {
        try {
            /*
             * 변경이력
             * - 2019-09-23 / 김상겸 : 전자결재 문서 삭제의 경우 doc_sts = 999 추가
             * - 2019-09-23 / 김상겸 : 전자결재 문서 삭제의 경우 히스토리 기록 추가
             */
            if(this.update("ExAdminAppdocDelete", param.getParams()) > 0) {
                this.insert("ExAdminAppdocHistoryInsert", param.getParams());
                param.setResultCode(commonCode.EMPTYYES);
            } else {
                param.setResultCode(commonCode.EMPTYNO);
            }
        } catch (Exception e) {
            param.setResultCode(commonCode.EMPTYNO);
        }
        return param;
    }

    /* 해당 지출결의의 항목 삭제 처리 */
    public ResultVO ExAdminExpendListDelete(ResultVO param) throws Exception {
        try {
            this.update("ExAdminExpendListDelete", param.getParams());
            param.setResultCode(commonCode.EMPTYYES);
        } catch (Exception e) {
            param.setResultCode(commonCode.EMPTYNO);
        }
        return param;
    }

    /* 해당 지출결의의 분개 삭제 처리 */
    public ResultVO ExAdminExpendSlipDelete(ResultVO param) throws Exception {
        try {
            this.update("ExAdminExpendSlipDelete", param.getParams());
            param.setResultCode(commonCode.EMPTYYES);
        } catch (Exception e) {
            param.setResultCode(commonCode.EMPTYNO);
        }
        return param;
    }

    /* 항목단위 입력인 경우 전송 이력 저장 */
    public int ExAdminExpendReportListHistoryInsert(Map<String, Object> params) {
        return this.update("ExAdminExpendReportListHistoryInsert", params);
    }

    /* 항목단위 입력인 경우 전송 이력 조회 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminExpendReportListHistorySelect(Map<String, Object> params) {
        return this.list("ExAdminExpendReportListHistorySelect", params);
    }

    /* Bizbox Alpha - 그룹웨어 전표정보 삭제 ERPiU */
    public int ExAdminExpendReportKeyRollbackAllERPiU(Map<String, Object> params) {
        int result = 0;
        result = this.update("ExAdminExpendReportKeyRollbackAllERPiU", params);
        return result;
    }

    /* Bizbox Alpha - 그룹웨어 전표정보 삭제 iCUBE */
    public int ExAdminExpendReportKeyRollbackAlliCUBE(Map<String, Object> params) {
        int result = 0;
        result = this.update("ExAdminExpendReportKeyRollbackAlliCUBE", params);
        return result;
    }

    /* 지출결의 - iCUBE 연동문서 현황 리스트 조회 */
    @SuppressWarnings("unchecked")
    //public ResultVO ExAdminiCUBEDocList(ResultVO param, ConnectionVO conVo) throws Exception {
    public ResultVO ExAdminiCUBEDocList(ResultVO param) throws Exception {
        param.setAaData(this.list("ExAdminiCUBEDocList", param.getParams()));
        return param;
    }

    /* 지출결의 - iCUBE 연동문서 현황 리스트 조회(비영리) */
    //public ResultVO ExAdminiCUBEDocListEAP(ResultVO param, ConnectionVO conVo) throws Exception {
    public ResultVO ExAdminiCUBEDocListEAP(ResultVO param) throws Exception {
        // param.setAaData( this.list( "ExAdminiCUBEDocListEAP", param.getParams( ) ) );
        return param;
    }

    /* 지출결의 - iCUBE 연동문서 현황 리스트 조회 */
    //public ResultVO ExAdminiCUBEDocListDelete(ResultVO param, ConnectionVO conVo) throws Exception {
    public ResultVO ExAdminiCUBEDocListDelete(ResultVO param) throws Exception {
        int result = 0;

        if (param.getParams().get("approKey") == null || param.getParams().get("approKey").toString().equals("")) {
            throw new Exception("approKey 값이 수신되지 않았습니다.");
        }

        result = this.update("ExAdminiCUBEDocListDelete", param.getParams());
        if (result > 0) {
            param.setResultCode(commonCode.SUCCESS);
        } else {
            param.setResultCode(commonCode.FAIL);
        }
        return param;
    }

    /* 지출결의 - GW 세금계산서 정보 조회 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminGWEtaxInfoSelect(ResultVO param) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = this.list("ExAdminReportA.ExAdminGWEtaxInfoSelect", param.getParams());
        return result;
    }

    /* 지출결의 - 세금계산서현황 - 세금계산서 사용/미사용처리 */
    @SuppressWarnings("unchecked")
    public boolean ExAdminETaxSetUseYN(ResultVO param) throws Exception {
        boolean result = true;
        try {
            List<Map<String, Object>> temp = this.list("ExAdminSpecificETaxSelect", param.getParams());
            if (temp != null && temp.size() > 0) {
                Map<String, Object> mp = new LinkedHashMap<String, Object>();
                mp = param.getParams();
                mp.put("syncId", temp.get(0).get("syncId").toString());
                this.update("ExAdminETaxSetUseYNUpdate", mp);
            } else {
                this.insert("ExAdminETaxSetUseYNInsert", param.getParams());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /* 지출결의 - 카드사용현황 - 카드사용내역 사용/미사용처리 */
    public boolean ExAdminCardSetUseYN(ResultVO param) throws Exception {
        boolean result = true;
        try {
            this.update("ExAdminCardSetUseYNUpdate", param.getParams());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /* ERPiU 문서 링크 전달 정보 조회 */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminDocLinkListInfoSelect(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> docLinkList = new ArrayList<Map<String, Object>>();
        try {
            docLinkList = this.list("ExAdminDocLinkListInfoSelect", params);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return docLinkList;
    }

    /* 지출결의 - ERP 전송 - 첨부파일 목록 조회 ( 항목단위 ) */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminSendAttachSelectList(Map<String, Object> param) throws Exception {
        List<Map<String, Object>> attachList = new ArrayList<Map<String, Object>>();
        try {
            attachList = this.list("ExAdminSendAttachSelectList", param);
        } catch (Exception e) {
            logger.error(e.getStackTrace());
            attachList = new ArrayList<Map<String, Object>>();
        }

        return attachList;
    }

    /* 지출결의 - ERP 전송 - 첨부파일 목록 조회 ( 문서단위 ) */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> ExAdminSendAttachAllSelectList(Map<String, Object> param) throws Exception {
        List<Map<String, Object>> attachList = new ArrayList<Map<String, Object>>();
        try {
            attachList = this.list("ExAdminSendAttachAllSelectList", param);
        } catch (Exception e) {
            logger.error(e.getStackTrace());
            attachList = new ArrayList<Map<String, Object>>();
        }

        return attachList;
    }

    /* Bizbox Alpha - 전자결재 회계API 연동 시에는 로그인세션이 따로 없기 때문에 로그인세션정보를 별도로 구해준다. */
    public LoginVO ExGetLoginSessionForApprovalProcessSelect(Map<String, Object> param) {
        return (LoginVO) this.select("ExAdminExpendSend.ExGetLoginSessionForApprovalProcessSelect", param);
    }

    /* Bizbox Alpha - 지출결의 자동전표 전송 이전 전송 상태값 확인 */
    @SuppressWarnings("unchecked")
    public Map<String, Object> ExGetSendState(Map<String, Object> p) throws Exception {
        return (Map<String, Object>) this.select("ExAdminExpendSend.ExGetSendState", p);
    }

    /* Bizbox Alpha - 지출결의 자동전표 전송 진행중 상태값 업데이트 */
    public int ExSetSendState(Map<String, Object> p) throws Exception {
        return this.update("ExAdminExpendSend.ExSetSendState", p);
    }

    /* Bizbox Alpha - 지출결의 자동전표 전송 진행중 상태값 업데이트 복구 */
    public int ExSetSendStateRollback(Map<String, Object> p) throws Exception {
        return this.update("ExAdminExpendSend.ExSetSendStateRollback", p);
    }

    /* Bizbox Alpha - 지출경릐 삭제에 따른, ERPiU 연동정보조회(rownId, rowNO)  */
    @SuppressWarnings("unchecked")
    public ResultVO ExAdminExpendDrInfo_ERPiU(ResultVO param) {
        param.setAaData(this.list("ExAdminReportA.ExAdminExpendDrInfo_ERPiU", param.getParams()));
        return param;
    }
}
