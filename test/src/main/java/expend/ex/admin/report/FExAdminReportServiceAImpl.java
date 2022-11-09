package expend.ex.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.NotImplementedException;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExReportCardVO;
import common.vo.ex.ExSendStatVO;
import common.vo.ex.ExpendVO;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import expend.ex.user.expend.BExUserService;

@Service("FExAdminReportServiceA")
public class FExAdminReportServiceAImpl implements FExAdminReportService {

    // 변수정의
    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    // dao
    @Resource(name = "FExAdminReportServiceADAO")
    private FExAdminReportServiceADAO dao;
    @Resource(name = "BExUserService")
    private BExUserService userService;

    /* Common */
    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 확인 */
    /* Bizbox Alpha - 지출결의 확인 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExAdminExpendManagerReportListInfoSelect(Map<String, Object> params) throws Exception {
        /*
         * parameter : fromDate, toDate, reqDate, adocuNo, appUserName, docNo, docTitle
         */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            /* 기본값 지정 */
            /* 기본값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 필수 파라미터 점검 */
            /* 필수 파라미터 점검 - 회사 시퀀스 */
            if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("FExUserReportServiceA - ExUserExpendReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ);
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 From */
            if (CommonConvert.CommonGetStr(params.get("searchFromDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExUserExpendReportListInfoSelect - BizboxA - parameter not exists >> " + commonCode.FROMDATE);
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 To */
            if (CommonConvert.CommonGetStr(params.get("searchToDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExUserExpendReportListInfoSelect - BizboxA - parameter not exists >> " + commonCode.TODATE);
            }
            /* 필수 파라미터 점검 - 지급요청일, 자동전표번호, 작성자, 문서번호는 선택 검색 */
            /* 사용자 입력 검색어로 오류 발생 문자열 치환 */
            params.put("adocuNo", CommonConvert.CommonGetStr(params.get("adocuNo")).replace("'", "''"));
            params.put("appUserName", CommonConvert.CommonGetStr(params.get("appUserName")).replace("'", "''"));
            params.put("docNo", CommonConvert.CommonGetStr(params.get("docNo")).replace("'", "''"));
            params.put(commonCode.DOCTITLE, CommonConvert.CommonGetStr(params.get(commonCode.DOCTITLE)).replace("'", "''"));
            /* 데이터 조회 */
            result = dao.ExAdminExpendManagerReportListInfoSelect(params);
        } catch (Exception e) {
            throw new Exception(e);
        }
        return result;
    }

    /* Bizbox Alpha - 카드 사용 현황 */
    /* Bizbox Alpha - 카드 사용 현황 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExAdminCardReportListInfoSelect(ExReportCardVO reportCardVO) throws Exception {
        /*
         * parameter : compSeq, bizSeq, deptSeq, fromDate, toDate, cardNum, mercName
         */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            /* 데이터 조회 */
            result = dao.ExAdminCardReportListInfoSelect(reportCardVO);
        } catch (Exception e) {
            throw new Exception(e);
        }
        return result;
    }

    /* Bizbox Alpha - 카드 사용 현황 */
    /* Bizbox Alpha - 카드 사용 현황 - 엑셀 데이터 조회 */
    @Override
    public List<Map<String, Object>> ExAdminCardReportListInfoSelectForExcel(Map<String, Object> params) throws Exception {
        /*
         * parameter : compSeq, bizSeq, deptSeq, fromDate, toDate, cardNum, mercName
         */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            /* 필수 파라미터 점검 - 카드번호, 거래처명은 선택 검색 */
            /* 사용자 입력 검색어로 오류 발생 문자열 치환 */
            params.put("cardNum", params.get("cardNum") == null ? commonCode.EMPTYSTR : params.get("cardNum"));
            params.put("mercName", params.get("mercName") == null ? commonCode.EMPTYSTR : params.get("mercName"));
            params.put("cardName", params.get("cardName") == null ? commonCode.EMPTYSTR : params.get("cardName"));

            params.put("cardNum", params.get("cardNum").toString().replace("'", "''"));
            params.put("mercName", params.get("mercName").toString().replace("'", "''"));
            params.put("cardName", params.get("cardName").toString().replace("'", "''"));
            /* 데이터 조회 */
            result = dao.ExAdminCardReportListInfoSelectForExcel(params);
        } catch (Exception e) {
            throw new Exception(e);
        }
        return result;
    }

    @Override
    public ResultVO ExReportExpendSendListInfoSend(List<Map<String, Object>> data, ConnectionVO conVo, LoginVO loginVo) throws Exception {
        throw new NotImplementedException("자체예산 ERP 전송 기능이 구현되지 않았습니다.");
    }

    @Override
    public ResultVO ExReportExpendSendListInfoReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        throw new NotImplementedException("자체예산 ERP 전송 취소 기능이 구현되지 않았습니다.");
    }

    /* 자동전표 전송위한 더미데이터 준비 - iCUBE용 */
    @Override
    public ResultVO ExReportExpendDummyListInfoSelect(Map<String, Object> param) throws Exception {
        ResultVO result = new ResultVO();
        
        result.setAaData(dao.ExAdminExpendReportListInfoSelect(param));
            
        if(result.getAaData() != null && result.getAaData().size() >0) {
            result.setResultCode(commonCode.SUCCESS);  
        }else {
            result.setResultCode(commonCode.FAIL);
            logger.error(param.toString());
        }
        
        return result;
    }

    /* 자동전표 전송위한 더미데이터 준비 - iU용 */
    @Override
    public ResultVO ExReportExpendDummyListInfoSelectU(Map<String, Object> param) throws Exception {
        ResultVO result = new ResultVO();
        
        result.setAaData(dao.ExAdminExpendReportListInfoSelectU(param));
            
        if(result.getAaData() != null && result.getAaData().size() >0) {
            result.setResultCode(commonCode.SUCCESS);  
        }else {
            result.setResultCode(commonCode.FAIL);
            logger.error(param.toString());
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> ExAdminExpendCheckReportListInfoSelect(Map<String, Object> params) throws Exception {
        /*
         * parameter : fromDate, toDate, reqDate
         */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            /* 기본값 지정 */
            /* 기본값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 필수 파라미터 점검 - 지급요청일, 자동전표번호, 작성자, 문서번호는 선택 검색 */
            /* 사용자 입력 검색어로 오류 발생 문자열 치환 */
            params.put("adocuNo", CommonConvert.CommonGetStr(params.get("adocuNo")).replace("'", "''"));
            params.put("appUserName", CommonConvert.CommonGetStr(params.get("appUserName")).replace("'", "''"));
            params.put("docNo", CommonConvert.CommonGetStr(params.get("docNo")).replace("'", "''"));
            params.put(commonCode.DOCTITLE, CommonConvert.CommonGetStr(params.get(commonCode.DOCTITLE)).replace("'", "''"));
            /* 데이터 조회 */
            if (CommonConvert.CommonGetStr(params.get("authPageYN")).equals("N")) {
                result = dao.ExAdminExpendCheckReportListInfoSelect(params);
            } else if (CommonConvert.CommonGetStr(params.get("authPageYN")).equals("Y")) {
                result = dao.ExAuthFormExpendCheckReportListInfoSelect(params);
            } else {
                throw new Exception("ExAdminExpendCheckReportListInfoSelect - BizboxA - parameter not exists >> authPageYN");
            }
        } catch (Exception e) {
            throw new Exception(e);
        }
        return result;
    }

    @Override
    public List<Map<String, Object>> ExAdminExpendCheckReportListInfoSelect2(Map<String, Object> params) throws Exception {
        /*
         * parameter : fromDate, toDate, reqDate (신규 엑셀다운로드 데이터 조회 )
         */
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        try {
            /* 기본값 지정 */
            /* 기본값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 필수 파라미터 점검 - 지급요청일, 자동전표번호, 작성자, 문서번호는 선택 검색 */
            /* 사용자 입력 검색어로 오류 발생 문자열 치환 */
            params.put("adocuNo", CommonConvert.CommonGetStr(params.get("adocuNo")).replace("'", "''"));
            params.put("appUserName", CommonConvert.CommonGetStr(params.get("appUserName")).replace("'", "''"));
            params.put("docNo", CommonConvert.CommonGetStr(params.get("docNo")).replace("'", "''"));
            params.put(commonCode.DOCTITLE, CommonConvert.CommonGetStr(params.get(commonCode.DOCTITLE)).replace("'", "''"));

            result = dao.ExAuthFormExpendCheckReportListInfoSelect2(params);

        } catch (Exception e) {
            throw new Exception(e);
        }
        return result;
    }

    /* Biz - 회계 ( 관리자 ) - 지출결의 현황 - 지출결의 삭제 */
    @Override
    public ResultVO ExAdminExpendInfoDelete(ResultVO param) throws Exception {
        ResultVO result = new ResultVO();
        /* 지출결의 ERP 정보 삭제 */
        /* 지출결의 정보 조회 */
        ExpendVO expendVo = new ExpendVO();
        expendVo = (ExpendVO) param.getParams().get("expendVo");
        expendVo.setErpSendYN(commonCode.EMPTYSTR);
        expendVo.setRowId(commonCode.EMPTYSTR);
        expendVo.setInDt(commonCode.EMPTYSTR);
        expendVo.setInSq(commonCode.EMPTYSTR);
        expendVo.setErpSendSeq(commonCode.EMPTYSTR);
        expendVo.setErpSendDate("00000000");
        expendVo.setErpSendYN(commonCode.EMPTYNO);
        expendVo.setModifySeq(param.getParams().get("empSeq").toString());
        expendVo.setExpendStatCode("999");
        expendVo.setGroupSeq(CommonConvert.CommonGetStr(param.getParams().get("groupSeq")));
        userService.ExUserExpendInfoUpdate(expendVo);
        /* 항목 정보 삭제 */
        result = dao.ExAdminExpendListDelete(param);
        /* 분개 정보 삭제 */
        result = dao.ExAdminExpendSlipDelete(param);
        return result;
    }

    /* ERP 전송한 전표 삭제 */
    @Override
    public ResultVO ExAdminExpendSendERPDataDelete(ResultVO param, ConnectionVO conVo) throws Exception {
        return param;
    }

    /* ERP 임시 예산삭제 */
    @Override
    public ResultVO ExAdminExpendERPBudgetDelete(ResultVO param, ConnectionVO conVo) throws Exception {
        return param;
    }

    /* 외부연동(법인카드, 매입전자세금계산서) 미사용 처리 */
    @Override
    public ResultVO ExAdminExpendOtherSystemRollback(ResultVO param, ConnectionVO conVo) throws Exception {
        /* 연동 정보 조회 */
        List<Map<String, Object>> interfaceList = new ArrayList<Map<String, Object>>();
        
        ResultVO interfaceType  = dao.ExAdminExpendDrSlipSelect(param);
       
        if(interfaceType.getAaData() != null && interfaceType.getAaData().size() >0) {
            for(Map<String, Object> map : interfaceType.getAaData()) {
                interfaceList.add(map);
            }
        }

        for (Map<String, Object> tMap : interfaceList) {
            Map<String, Object> tParam = new HashMap<String, Object>();
            tParam = param.getParams();
            tParam.put("syncId", tMap.get("interfaceMId").toString());
            param.setParams(tParam);
            if (CommonConvert.CommonGetStr(tMap.get("interfaceType")).equals("card")) {
                /* 매입전자세금계산서 미사용 처리 */
                param = dao.ExAdminExpendCardInfoUpdate(param);
                if (CommonConvert.CommonGetStr(param.getResultCode()).equals(commonCode.EMPTYNO)) {
                    throw new Exception();
                }
            } else if (CommonConvert.CommonGetStr(tMap.get("interfaceType").toString()).equals("etax")) {
                /* 카드사용내역 미사용 처리 */
                param = dao.ExAdminExpendETaxInfoUpdate(param);
                if (CommonConvert.CommonGetStr(param.getResultCode()).equals(commonCode.EMPTYNO)) {
                    throw new Exception();
                }
            }
        }

        return param;
    }

    /* 전자결재 문서 삭제 */
    @Override
    public ResultVO ExAdminAppdocDelete(ResultVO param) throws Exception {
        Map<String, Object> tMap = new HashMap<String, Object>();
        ExpendVO expendVo = new ExpendVO();
        tMap = param.getParams();
        expendVo = (ExpendVO) tMap.get("expendVo");
        tMap.put("docSeq", expendVo.getDocSeq());
        param.setParams(tMap);
        dao.ExAdminAppdocDelete(param);
        return param;
    }

    /* 매입전자세금계산서 ERP 연동 정보 초기화(iCUBE) */
    @Override
    public ResultVO ExAdminExpendOtherSystemERPInfoReollback(ResultVO param, ConnectionVO conVo) throws Exception {
        return param;
    }

    /* 지출결의 ERP 전송(항목 별 전송) */
    @Override
    public ResultVO ExReportExpendSendListInfoSendByList(List<Map<String, Object>> data, ConnectionVO conVo, LoginVO loginVo) throws Exception {
        ResultVO result = new ResultVO();
        return result;
    }

    /* 지출결의 ERP 전송 취소(항목단위) */
    @Override
    public ResultVO ExReportExpendSendListInfoAllReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        ResultVO resultVo = new ResultVO();
        return resultVo;
    }

    /* 지출결의 - 매입전자세금계산서 리스트 조회 */
    @Override
    public List<Map<String, Object>> ExAdminEtaxReportList(ResultVO param, ConnectionVO conVo) throws Exception {
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        result = dao.ExAdminGWEtaxInfoSelect(param);
        return result;
    }

    /* 지출결의 - iCUBE 연동문서 현황 리스트 조회 */
    @Override
    public ResultVO ExAdminiCUBEDocList(ResultVO param, ConnectionVO conVo) throws Exception {
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        switch (loginVo.getEaType()) {
            case "ea":
                // param = dao.ExAdminiCUBEDocListEAP( param, conVo );
                break;
            case "eap":
                //param = dao.ExAdminiCUBEDocList(param, conVo);
            	param = dao.ExAdminiCUBEDocList(param);
                break;
            default :
            	break;
        }
        return param;
    }

    /* 지출결의 - iCUBE 연동문서 현황 문서 삭제 */
    @Override
    public ResultVO ExAdminiCUBEDocListDelete(ResultVO param, ConnectionVO conVo) throws Exception {
        //param = dao.ExAdminiCUBEDocListDelete(param, conVo);
    	param = dao.ExAdminiCUBEDocListDelete(param);
        return param;
    }

    /* 항목단위 입력인 경우 전송 이력 조회 */
    @Override
    public List<Map<String, Object>> ExAdminExpendReportListHistorySelect(Map<String, Object> params) {
        return dao.ExAdminExpendReportListHistorySelect(params);
    }

    /* 매입전자세금계산서 - 해당 세금계산서의 사업장 정보 조회 (ERPiU 전용) */
    @Override
    public ResultVO ExAdminETaxBizInfoSelect(ResultVO param, ConnectionVO conVo) throws Exception {
        return param;
    }

    /* 지출결의 - 세금계산서현황 - 세금계산서 사용/미사용처리 */
    @Override
    public ResultVO ExAdminETaxSetUseYN(ResultVO param) throws Exception {
        dao.ExAdminETaxSetUseYN(param);
        return param;
    }

    /* 지출결의 - 카드사용현황 - 카드사용내역 사용/미사용처리 */
    @Override
    public ResultVO ExAdminCardSetUseYN(ResultVO param) throws Exception {
        dao.ExAdminCardSetUseYN(param);
        return param;
    }

    /* 지출결의 - ERP 전송 - 첨부파일 목록 조회 */
    @Override
    public List<Map<String, Object>> ExAdminSendAttachSelectList(Map<String, Object> param) throws Exception {
        // parameters : rowId, expendSeq, listSeq, cdPc, erpEmpNo
        return dao.ExAdminSendAttachSelectList(param);
    }

    /* 지출결의 - ERP 전송 - 첨부파일 목록 조회 ( 문서 기준 ) */
    @Override
    public List<Map<String, Object>> ExAdminSendAttachAllSelectList(Map<String, Object> param) throws Exception {
        // parameters : rowId, expendSeq, cdPc, erpEmpNo
        return dao.ExAdminSendAttachAllSelectList(param);
    }

    /* 지출결의 - ERP 자동전송 - 전자결재 회계API 연동 시에는 로그인세션이 따로 없기 때문에 로그인세션정보를 별도로 구해준다. */
    @Override
    public LoginVO ExGetLoginSessionForApprovalProcess(Map<String, Object> param) throws Exception {
        return dao.ExGetLoginSessionForApprovalProcessSelect(param);
    }

    @Override
    public List<Map<String, Object>> ExSlipAdminExpendManagerReportListInfoSelectExceDown(Map<String, Object> params) throws Exception {

        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

        try {
            /* 기본값 지정 */
            /* 기본값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 필수 파라미터 점검 */
            /* 필수 파라미터 점검 - 회사 시퀀스 */
            if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("FExAdminReportServiceA - ExAdminSlipExpendManagerReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ);
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 searchDocStartDate */
            if (CommonConvert.CommonGetStr(params.get("searchexpendDateStartDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExAdminSlipExpendManagerReportListInfoSelect - BizboxA - parameter not exists >> " + params.get("searchexpendDateStartDate"));
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 searchDocEndDate */
            if (CommonConvert.CommonGetStr(params.get("searchexpendDateEndtDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExAdminSlipExpendManagerReportListInfoSelect - BizboxA - parameter not exists >> " + params.get("searchexpendDateEndtDate"));
            }

            /* 필수 파라미터 점검 - 지급요청일, 자동전표번호, 작성자, 문서번호는 선택 검색 */
            /* 사용자 입력 검색어로 오류 발생 문자열 치환 */
            params.put("adocuNo", CommonConvert.CommonGetStr(params.get("adocuNo")).replace("'", "''"));
            params.put("appUserName", CommonConvert.CommonGetStr(params.get("appUserName")).replace("'", "''"));
            params.put("docNo", CommonConvert.CommonGetStr(params.get("docNo")).replace("'", "''"));
            params.put(commonCode.DOCTITLE, CommonConvert.CommonGetStr(params.get(commonCode.DOCTITLE)).replace("'", "''"));

            result = dao.ExReportSlipExpendAdmListInfoSelectExcelDown(params);

        } catch (Exception e) {
            throw new Exception(e);
        }
        return result;
    }

    /* 지출결의 - 지출결의 상세현황 이준성 */
    @Override
    @SuppressWarnings("unchecked")
    public Map<String, Object> ExAdminSlipExpendManagerReportListInfoSelect(Map<String, Object> params) throws Exception {

        Map<String, Object> result = new HashMap<String, Object>();

        try {
            /* 기본값 지정 */
            /* 기본값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 필수 파라미터 점검 */
            /* 필수 파라미터 점검 - 회사 시퀀스 */
            if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("FExAdminReportServiceA - ExAdminSlipExpendManagerReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ);
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 searchDocStartDate */
            if (CommonConvert.CommonGetStr(params.get("searchexpendDateStartDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExAdminSlipExpendManagerReportListInfoSelect - BizboxA - parameter not exists >> " + params.get("searchexpendDateStartDate"));
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 searchDocEndDate */
            if (CommonConvert.CommonGetStr(params.get("searchexpendDateEndtDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExAdminSlipExpendManagerReportListInfoSelect - BizboxA - parameter not exists >> " + params.get("searchexpendDateEndtDate"));
            }

            /* 필수 파라미터 점검 - 지급요청일, 자동전표번호, 작성자, 문서번호는 선택 검색 */
            /* 사용자 입력 검색어로 오류 발생 문자열 치환 */
            params.put("adocuNo", CommonConvert.CommonGetStr(params.get("adocuNo")).replace("'", "''"));
            params.put("appUserName", CommonConvert.CommonGetStr(params.get("appUserName")).replace("'", "''"));
            params.put("docNo", CommonConvert.CommonGetStr(params.get("docNo")).replace("'", "''"));
            params.put(commonCode.DOCTITLE, CommonConvert.CommonGetStr(params.get(commonCode.DOCTITLE)).replace("'", "''"));

            PaginationInfo paginationInfo = new PaginationInfo();
            paginationInfo.setCurrentPageNo(EgovStringUtil.zeroConvert(params.get("page")));
            paginationInfo.setPageSize(EgovStringUtil.zeroConvert(params.get("pageSize")));

            result.put("resultList", dao.ExReportSlipExpendAdmListInfoSelected(params, paginationInfo));
        } catch (Exception e) {
            throw new Exception(e);
        }

        return result;
    }

    /* 지출결의 - ERP 전송 - 전송 상태 점검 */
    @Override
    public ExSendStatVO ExGetSendState(ExSendStatVO p) throws Exception {
        Map<String, Object> sendState = new HashMap<String, Object>();
        sendState.put("groupSeq", p.getGroupSeq());
        sendState.put("expendSeq", p.getExpendSeq());
        sendState = dao.ExGetSendState(sendState);

        if (sendState == null) {
            throw new Exception("전송할 지출정보의 상태값 조회에 실패했습니다."); 
        } else {
            sendState.get("erpSendYn");
            p.setErpSendYn(sendState.get("erpSendYn").toString());
        }

        return p;
    }

    /* 지출결의 - ERP 전송 - 전송 상태 업데이 */
    @Override
    public ExSendStatVO ExSetSendState(ExSendStatVO p) throws Exception {
        logger.info("[PROCESS] 지출결의 전송중 상태값을 업데이트합니다. >> " + p.toString());

        Map<String, Object> sendState = new HashMap<String, Object>();
        sendState.put("groupSeq", p.getGroupSeq());
        sendState.put("expendSeq", p.getExpendSeq());
        p.setErpSendStatUpdateCount(dao.ExSetSendState(sendState));
        return p;
    }

    /* 지출결의 - ERP 전송 - 전송 상태복원 */
    @Override
    public ExSendStatVO ExSetSendStateRollback(ExSendStatVO p) throws Exception {
        Map<String, Object> sendState = new HashMap<String, Object>();
        sendState.put("groupSeq", p.getGroupSeq());
        sendState.put("expendSeq", p.getExpendSeq());
        p.setErpSendStatUpdateCount(dao.ExSetSendStateRollback(sendState));

        ExpInfo.CoreLogNotLoop("Rollback count : " + p.getErpSendStatUpdateCount() + " / 지출결의 전송중 오류가 발생되었습니다. >> " + p.toString(), null);

        return p;
    }
    /* 문서 단위 전송 취소 - 옛날꺼 */
    @Override
    public ResultVO ExReportExpendSendListInfoChekedReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception {
      ResultVO result = new ResultVO();
      return result;
    }

    /* 항목 단위 전송 취소 - 옛날꺼 */
    @Override
    public ResultVO ExReportExpendSendListInfoAllReturn2(Map<String, Object> param, ConnectionVO conVo) throws Exception {
      ResultVO result = new ResultVO();
      return result;
    }
}
