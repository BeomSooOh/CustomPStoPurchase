package expend.ex.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.commons.lang.NotImplementedException;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.ErpSendFailException;
import common.helper.exception.NotFoundDataException;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import common.vo.ex.ExErpSendiCUBEVO;
import common.vo.ex.ExReportCardVO;
import common.vo.ex.ExSendStatVO;
import common.vo.ex.ExpendVO;
import expend.ex.user.expend.BExUserService;


@Service("FExAdminReportServiceI")
public class FExAdminReportServiceIImpl implements FExAdminReportService {

    @Resource(name = "CommonLogger")
    private CommonLogger cmLog; /* Log 관리 */
    /* 변수정의 - 지출결의 */
    @Resource(name = "BExUserService")
    private BExUserService userService;
    @Resource(name = "FExAdminReportServiceIDAO")
    private FExAdminReportServiceIDAO daoI;
    @Resource(name = "FExAdminReportServiceADAO")
    private FExAdminReportServiceADAO daoA;

    /* Common */
    /* iCUBE */
    /* iCUBE - 지출결의 확인 */
    /* iCUBE - 지출결의 확인 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExAdminExpendManagerReportListInfoSelect(Map<String, Object> params) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* iCUBE - 카드 사용 현황 */
    /* iCUBE - 카드 사용 현황 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExAdminCardReportListInfoSelect(ExReportCardVO reportCardVO) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* iCUBE - ERP 전송 */
    @Override
    public ResultVO ExReportExpendSendListInfoSend(List<Map<String, Object>> param, ConnectionVO conVo, LoginVO loginVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceIImpl - ExReportExpendSendListInfoSend");
        cmLog.CommonSetInfo("! [EX] List<ExReportSendExpendVO> sendListVo >> " + param.toString());
        ResultVO resultVo = new ResultVO();
        try {
            /* 1. ERP 전송 VO생성 (iCUBE). */
            ExErpSendiCUBEVO data = new ExErpSendiCUBEVO(param);
            /* 2. 연동 변수 정의 */
            int lnSq = 1;
            String inSq = commonCode.EMPTYSTR;
            String expendDate = commonCode.EMPTYSTR;

            /* ERP 테이블 버전 조회 */
            boolean colFlag = (daoI.ExReportExpendErpCheckColumn(conVo) == 1);

            Map<String, Object> docInfoSelectParam = new HashMap<String, Object>();
            String docId = "";
            String docNo = "";

            if (colFlag) {
              docInfoSelectParam.put("expendSeq", data.getExpendSeq());
              docInfoSelectParam.put("groupSeq", loginVo.getGroupSeq());
              Map<String, Object> result = daoA.ExAdminExpendReportDocInfoSelect(docInfoSelectParam);
              docId = result.get("doc_id").toString();
              docNo = result.get("doc_no").toString();
            }

            /* 3. ERP 전표 전송 로직 진행 */
            while (data.NextData() > -1) {
                Map<String, Object> item = data.data.getMap();
                // ERP iCUBE key(IN_SQ) 조회 //
                if (inSq.equals(commonCode.EMPTYSTR)) {
                	expendDate = item.get("IN_DT").toString(); // 옵션에 따라 변경 가능성. - VO내부 처리 완료
                    inSq = daoI.ExInSqSelect(conVo, expendDate);
                }

                // ERP 자동 전표 전송 (data insert) //
                if (colFlag) {
                    if (daoI.ExReportExpendErpSendWithDocInfo(conVo, item, expendDate, inSq, lnSq, docId, docNo) == 0) {
                        throw new ErpSendFailException(data.data);
                    }
                }
                // ERP 자동 전표 전송 (DOC_ID, DOC_no 컬럼이 없는 테이블의 경우) (data insert) //
                else {
                    if (daoI.ExReportExpendErpSend(conVo, item, expendDate, inSq, lnSq) == 0) {
                        throw new ErpSendFailException(data.data);
                    }
                }
                lnSq++;
            }
            /* 4. 그룹웨어 전표 연동 업데이트 */
            if (!data.isEmpty()) {
                Map<String, Object> updateParam = new HashMap<String, Object>();
                updateParam.put("inDt", expendDate);
                updateParam.put("inSq", inSq);
                updateParam.put("expendSeq", data.getExpendSeq());
                updateParam.put("compSeq", data.getCompSeq());
                updateParam.put("empSeq", loginVo.getUniqId());
                updateParam.put("groupSeq", loginVo.getGroupSeq());
                daoA.ExAdminExpendReportUpdate(updateParam);

                /* 전송 이력 insert */
                /* 지출결의 History 테이블에 이력 남김. */
                Map<String, Object> addMap = new HashMap<String, Object>();
                ResultVO tResult = new ResultVO();
                addMap = tResult.getParams();
                addMap.put("modifyReason", "ERP전송 진행(empSeq : " + loginVo.getUniqId() + ")");
                if (!data.getOriginData().isEmpty()) {
                    addMap.put("docSeq", data.getOriginData().get(0).get("doc_seq"));
                } else {
                    addMap.put("docSeq", "0");
                }
                addMap.put("createdBy", loginVo.getUniqId());
                addMap.put("expendSeq", data.getExpendSeq());
                addMap.put("groupSeq", loginVo.getGroupSeq());
                tResult.setParams(addMap);
                userService.ExExpendEditHistoryInsert(tResult);
            }
            /* 5. 반환 처리 */
            resultVo.setResultCode(commonCode.SUCCESS);
            resultVo.setResultName("전표전송에 성공하였습니다.");
        } catch (ErpSendFailException ex) {
            /* Map<String, Object> map = (Map<String, Object>) ex.getMap( ); */
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName("전표전송 실패하였습니다.");
        }
        cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + resultVo.toString());
        cmLog.CommonSetInfo("- [EX] ExReportExpendSendiCUBEService - ExReportExpendSendListInfoSend");
        return resultVo;
    }

    /* iCUBE - ERP 전송 취소 */
    @Override
    public ResultVO ExReportExpendSendListInfoReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceIImpl - ExReportExpendSendListInfoReturn");
        cmLog.CommonSetInfo("! [EX] Map<String, Object> " + param.toString());
        ResultVO resultVo = new ResultVO();
        try {
            /* 1. 삭제 가능한 정보인지 검증 */
            if (daoI.ExReportExpendReturnCountInfoSelect(param, conVo) == 0) {
                throw new NotFoundDataException("전표 발행이 진행된 문서입니다.");
            }
            /* 2. 그룹웨어 연동 정보 삭제 */
            if (daoA.ExAdminExpendReportKeyRollback(param) == 0) {
                throw new NotFoundDataException("전송기록이 없습니다.");
            }
            /* 3. ERP연동 정보 삭제 */
            if (daoI.ExReportExpendSendInfoDelete(param, conVo) == 0) {
                throw new NotFoundDataException("ERP연동 정보가 없습니다.");
            }
            /* 4. 반환 처리 */
            resultVo.setResultCode(commonCode.SUCCESS);
            resultVo.setResultName("전송취소에 성공하였습니다.");

            /* 전송 이력 insert */
            /* 지출결의 History 테이블에 이력 남김. */
            Map<String, Object> addMap = new HashMap<String, Object>();
            ResultVO tResult = new ResultVO();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            addMap = tResult.getParams();
            addMap.put("modifyReason", "ERP전송 취소 진행(empSeq : " + loginVo.getUniqId() + ")");
            addMap.put("docSeq", CommonConvert.CommonGetStr(param.get("docSeq")));
            addMap.put("createdBy", loginVo.getUniqId());
            addMap.put("expendSeq", CommonConvert.CommonGetStr(param.get("expendSeq")));
            tResult.setParams(addMap);
            userService.ExExpendEditHistoryInsert(tResult);
        } catch (NotFoundDataException ex) {
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName(ex.getMessage());
        }
        cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + resultVo.toString());
        cmLog.CommonSetInfo("- [EX] ExReportExpendSendiCUBEService - ExReportExpendSendListInfoReturn");
        return resultVo;
    }

    @Override
    public ResultVO ExReportExpendDummyListInfoSelect(Map<String, Object> param) throws Exception {
        throw new NotImplementedException("해당 기능은 지출결의 정보 조회이며, 그룹웨어 커넥션 전용입니다.");
    }

    @Override
    public ResultVO ExReportExpendDummyListInfoSelectU(Map<String, Object> param) throws Exception {
        throw new NotImplementedException("해당 기능은 지출결의 정보 조회이며, ERPiU 전용입니다.");
    }

    @Override
    public List<Map<String, Object>> ExAdminExpendCheckReportListInfoSelect(Map<String, Object> params) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    @Override
    public List<Map<String, Object>> ExAdminExpendCheckReportListInfoSelect2(Map<String, Object> params) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* Biz - 회계 ( 관리자 ) - 지출결의 현황 - 지출결의 삭제 */
    @Override
    public ResultVO ExAdminExpendInfoDelete(ResultVO param) throws Exception {
        ResultVO result = new ResultVO();
        return result;
    }

    /* ERP 전송한 전표 삭제 */
    @Override
    public ResultVO ExAdminExpendSendERPDataDelete(ResultVO param, ConnectionVO conVo) throws Exception {
        Map<String, Object> tMap = new HashMap<String, Object>();
        ExpendVO expendVo = new ExpendVO();
        tMap = param.getParams();
        expendVo = (ExpendVO) param.getParams().get("expendVo");
        tMap.put("inDt", expendVo.getInDt());
        tMap.put("inSq", expendVo.getInSq());
        param.setParams(tMap);
        param = daoI.ExAdminExpendSendERPDataDelete(param, conVo);
        return param;
    }

    /* ERP 임시 예산삭제 */
    @Override
    public ResultVO ExAdminExpendERPBudgetDelete(ResultVO param, ConnectionVO conVo) throws Exception {
        return param;
    }

    /* 준성 
     * ERP iCUBE
     * ACARD_SUNGIN UPDATE
     * */
    @Override
    public ResultVO ExAdminExpendOtherSystemRollback(ResultVO param, ConnectionVO conVo) throws Exception {
        daoI.ExAdminExpendERPAcardSunginGwState(param, conVo);
        return param;
    }

    /* 전자결재 문서 삭제 */
    @Override
    public ResultVO ExAdminAppdocDelete(ResultVO param) throws Exception {
        return param;
    }

    /* 매입전자세금계산서 ERP 연동 정보 초기화(iCUBE) */
    @Override
    public ResultVO ExAdminExpendOtherSystemERPInfoReollback(ResultVO param, ConnectionVO conVo) throws Exception {
        daoI.ExAdminExpendOtherSystemERPInfoReollback(param, conVo);
        return param;
    }

    /* 지출결의 ERP 전송(항목 별 전송) */
    @Override
    public ResultVO ExReportExpendSendListInfoSendByList(List<Map<String, Object>> param, ConnectionVO conVo, LoginVO loginVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceIImpl - ExReportExpendSendListInfoSendByList");
        cmLog.CommonSetInfo("! [EX] List<ExReportSendExpendVO> sendListVo >> " + param.toString());
        ResultVO resultVo = new ResultVO();
        try {
            /* 1. ERP 전송 VO생성 (iCUBE). */
            ExErpSendiCUBEVO data = new ExErpSendiCUBEVO(param);
            /* 2. 연동 변수 정의 */
            int lnSq = 1;
            String inSq = commonCode.EMPTYSTR;
            String expendDate = commonCode.EMPTYSTR;

            /* ERP 테이블 버전 조회 */
            boolean colFlag = (daoI.ExReportExpendErpCheckColumn(conVo) == 1);

            /* 3. ERP 전표 전송 로직 진행 */
            while (data.NextData() > -1) {
                Map<String, Object> item = data.data.getMap();
                // ERP iCUBE key(IN_SQ) 조회 //
                if (inSq.equals(commonCode.EMPTYSTR)) {
                	expendDate = item.get("IN_DT").toString(); // 옵션에 따라 변경 가능성. - VO내부 처리 완료
                    inSq = daoI.ExInSqSelect(conVo, expendDate);
                }

                // ERP 자동 전표 전송 (data insert) //
                if (colFlag) {
                    Map<String, Object> docInfoSelectParam = new HashMap<String, Object>();
                    docInfoSelectParam.put("expendSeq", data.getExpendSeq());
                    docInfoSelectParam.put("groupSeq", loginVo.getGroupSeq());
                    Map<String, Object> result = daoA.ExAdminExpendReportDocInfoSelect(docInfoSelectParam);
                    String docId = result.get("doc_id").toString();
                    String docNo = result.get("doc_no").toString();

                    if (daoI.ExReportExpendErpSendWithDocInfo(conVo, item, expendDate, inSq, lnSq, docId, docNo) == 0) {
                        throw new ErpSendFailException(data.data);
                    }
                }
                // ERP 자동 전표 전송 (DOC_ID, DOC_no 컬럼이 없는 테이블의 경우) (data insert) //
                else {
                    if (daoI.ExReportExpendErpSend(conVo, item, expendDate, inSq, lnSq) == 0) {
                        throw new ErpSendFailException(data.data);
                    }
                }
                lnSq++;
            }
            /* 4. 그룹웨어 전표 연동 업데이트 */
            if (!data.isEmpty()) {
                Map<String, Object> updateParam = new HashMap<String, Object>();
                updateParam.put("inDt", expendDate);
                updateParam.put("inSq", inSq);
                updateParam.put("expendSeq", data.getExpendSeq());
                updateParam.put("compSeq", data.getCompSeq());
                updateParam.put("empSeq", loginVo.getUniqId());
                updateParam.put("groupSeq", loginVo.getGroupSeq());
                daoA.ExAdminExpendReportUpdate(updateParam);
                /* 항목단위 입력인 경우 지출결의 변경이력 테이블에 RowID 저장 */
                updateParam.put("listSeq", param.get(0).get("list_seq"));
                updateParam.put("rowId", "");
                updateParam.put("inDt", expendDate);
                updateParam.put("inSq", inSq);
                updateParam.put("docSeq", param.get(0).get("doc_seq"));
                updateParam.put("createSeq", loginVo.getUniqId());
                daoA.ExAdminExpendReportListHistoryInsert(updateParam);
            }
            /* 5. 반환 처리 */
            resultVo.setResultCode(commonCode.SUCCESS);
            resultVo.setResultName("전표전송에 성공하였습니다.");
        } catch (ErpSendFailException ex) {
            /* Map<String, Object> map = ex.getMap( ); */
            resultVo.setResultCode(commonCode.SUCCESS);
            resultVo.setResultName("전표전송 실패하였습니다.");
        }
        cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + resultVo.toString());
        cmLog.CommonSetInfo("- [EX] ExReportExpendSendiCUBEService - ExReportExpendSendListInfoSendByList");
        return resultVo;
    }

    /* 지출결의 ERP 전송 취소(항목단위) */
    @Override
    public ResultVO ExReportExpendSendListInfoAllReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceIImpl - ExReportExpendSendListInfoAllReturn");
        cmLog.CommonSetInfo("! [EX] Map<String, Object> " + param.toString());
        ResultVO resultVo = new ResultVO();
        try {
            /* 삭제 하려고 하는 지출결의 정보 조회 */
            List<Map<String, Object>> expendERPInfo = new ArrayList<Map<String, Object>>();
            expendERPInfo = daoA.ExAdminExpendReportListHistorySelect(param);
            if (expendERPInfo.size() > 0) {
                for (Map<String, Object> tMap : expendERPInfo) {
                    param.put("inDt", tMap.get("inDt"));
                    param.put("inSq", tMap.get("inSq"));
                    /* 1. 삭제 가능한 정보인지 검증 */
                    if (daoI.ExReportExpendReturnCountInfoSelect(param, conVo) == 0) {
                        throw new NotFoundDataException("전표 발행이 진행된 문서입니다.");
                    }
                }
                for (Map<String, Object> tMap : expendERPInfo) {
                    param.put("inDt", tMap.get("inDt"));
                    param.put("inSq", tMap.get("inSq"));
                    /* 2. 그룹웨어 연동 정보 삭제 */
                    if (daoA.ExAdminExpendReportKeyRollback(param) == 0) {
                        throw new NotFoundDataException("전송기록이 없습니다.");
                    }
                    /* 3. ERP연동 정보 삭제 */
                    if (daoI.ExReportExpendSendInfoDelete(param, conVo) == 0) {
                        throw new NotFoundDataException("ERP연동 정보가 없습니다.");
                    }
                    /* 4. 그룹웨어 전송 테이블 삭제 */
                    if (daoA.ExAdminExpendReportKeyRollbackAlliCUBE(param) == 0) {
                        throw new NotFoundDataException("전송기록이 없습니다.");
                    }
                }
                resultVo.setResultCode(commonCode.SUCCESS);
                resultVo.setResultName("전송취소에 성공하였습니다.");

                /* 전송 이력 insert */
                /* 지출결의 History 테이블에 이력 남김. */
                Map<String, Object> addMap = new HashMap<String, Object>();
                ResultVO tResult = new ResultVO();
                LoginVO loginVo = CommonConvert.CommonGetEmpVO();
                addMap = tResult.getParams();
                addMap.put("modifyReason", "ERP전송 취소 진행(empSeq : " + loginVo.getUniqId() + ")");
                addMap.put("docSeq", CommonConvert.CommonGetStr(param.get("docSeq")));
                addMap.put("createdBy", loginVo.getUniqId());
                addMap.put("expendSeq", CommonConvert.CommonGetStr(param.get("expendSeq")));
                tResult.setParams(addMap);
                userService.ExExpendEditHistoryInsert(tResult);
            } else {
                resultVo = this.ExReportExpendSendListInfoReturn(param, conVo);
            }
        } catch (NotFoundDataException ex) {
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName(ex.getMessage());
        }
        cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + resultVo.toString());
        cmLog.CommonSetInfo("- [EX] ExReportExpendSendiCUBEService - ExReportExpendSendListInfoAllReturn");
        return resultVo;
    }

    /* 지출결의 - 매입전자세금계산서 리스트 조회 */
    @Override
    public List<Map<String, Object>> ExAdminEtaxReportList(ResultVO param, ConnectionVO conVo) throws Exception {
        /* 매입 전자 세금계산서 조회 */
        ExCodeETaxVO etaxVo = new ExCodeETaxVO();
        List<Map<String, Object>> etaxListVo = new ArrayList<Map<String, Object>>();
        etaxVo.setErpCompSeq(conVo.getErpCompSeq());
        etaxVo.setBizplanCode(commonCode.EMPTYSTR);
        etaxVo.setSearchFromDt(param.getParams().get("searchFromDt").toString());
        etaxVo.setSearchToDt(param.getParams().get("searchToDt").toString());
        /* 검색조건 */
        etaxVo.setIssNo(param.getParams().get("issNo").toString());
        etaxVo.setTrNm(param.getParams().get("partnerName").toString());
        etaxVo.setTrregNb(param.getParams().get("partnerNo").toString());
        etaxVo.setEmailDc(param.getParams().get("emailDc").toString());
        if (param.getParams().get("docuSt").toString().equals("D")) {
            etaxVo.setDocuSt("1");
        } else if (CommonConvert.CommonGetStr(param.getParams().get("docuSt")).equals("2")) {
            etaxVo.setDocuSt("0");
        }

        etaxVo.setTaxTy("2");
        List<Map<String, Object>> eTaxList1 = new ArrayList<Map<String, Object>>();
        eTaxList1 = daoI.ExAdminETaxListInfoSelectMap(etaxVo, conVo);
        /* 면세 매입 전자 세금계산서 조회 */
        List<Map<String, Object>> eTaxList2 = new ArrayList<Map<String, Object>>();
        etaxVo.setTaxTy("4");
        eTaxList2 = daoI.ExAdminETaxListInfoSelectMap(etaxVo, conVo);
        etaxListVo.addAll(eTaxList1);
        etaxListVo.addAll(eTaxList2);
        return etaxListVo;
    }

    /* 지출결의 - iCUBE 연동문서 현황 리스트 조회 */
    @Override
    public ResultVO ExAdminiCUBEDocList(ResultVO param, ConnectionVO conVo) throws Exception {
        return param;
    }

    /* 지출결의 - iCUBE 연동문서 현황 문서 삭제 */
    @Override
    public ResultVO ExAdminiCUBEDocListDelete(ResultVO param, ConnectionVO conVo) throws Exception {
        param = daoI.ExAdminiCUBEDocListDelete(param, conVo);
        return param;
    }

    /* 항목단위 입력인 경우 전송 이력 조회 */
    @Override
    public List<Map<String, Object>> ExAdminExpendReportListHistorySelect(Map<String, Object> params) {
        return null;
    }

    /* 매입전자세금계산서 - 해당 세금계산서의 사업장 정보 조회 (ERPiU 전용) */
    @Override
    public ResultVO ExAdminETaxBizInfoSelect(ResultVO param, ConnectionVO conVo) throws Exception {
        return param;
    }

    /* 지출결의 - 세금계산서현황 - 세금계산서 사용/미사용처리 */
    @Override
    public ResultVO ExAdminETaxSetUseYN(ResultVO param) throws Exception {
        return param;
    }

    /* 법인카드 사용내역 현황 엑셀 데이터 조회 ( 그룹웨어 전용 ) */
    @Override
    public List<Map<String, Object>> ExAdminCardReportListInfoSelectForExcel(Map<String, Object> params) throws Exception {
        // TODO Auto-generated method stub
        return null;
    }

    /* 지출결의 - 카드사용현황 - 카드사용내역 사용/미사용처리 */
    @Override
    public ResultVO ExAdminCardSetUseYN(ResultVO param) throws Exception {
        return param;
    }

    /* 지출결의 - ERP 전송 - 첨부파일 목록 조회 */
    @Override
    public List<Map<String, Object>> ExAdminSendAttachSelectList(Map<String, Object> param) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* 지출결의 - ERP 전송 - 첨부파일 목록 조회 ( 문서 기준 ) */
    @Override
    public List<Map<String, Object>> ExAdminSendAttachAllSelectList(Map<String, Object> param) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* 지출결의 - ERP 자동전송 - 전자결재 회계API 연동 시에는 로그인세션이 따로 없기 때문에 로그인세션정보를 별도로 구해준다. */
    @Override
    public LoginVO ExGetLoginSessionForApprovalProcess(Map<String, Object> param) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* 지출결의 - 지출결의 상세현황 리스트 이준성 */
    @Override
    public Map<String, Object> ExAdminSlipExpendManagerReportListInfoSelect(Map<String, Object> params) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    @Override
    public List<Map<String, Object>> ExSlipAdminExpendManagerReportListInfoSelectExceDown(Map<String, Object> params) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* 지출결의 - ERP 전송 - 전송 상태 점검 */
    @Override
    public ExSendStatVO ExGetSendState(ExSendStatVO p) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* 지출결의 - ERP 전송 - 전송 상태 업데이 */
    @Override
    public ExSendStatVO ExSetSendState(ExSendStatVO p) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* 지출결의 - ERP 전송 - 전송 상태복원 */
    @Override
    public ExSendStatVO ExSetSendStateRollback(ExSendStatVO p) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /*
     * 준성 - 나중에 사용 
     * */
    @Override
    public ResultVO ExReportExpendSendListInfoChekedReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception {
      throw new NotImplementedException("나중에 사용할 예정");
    }

    /*
     * 준성 - 나중에 사용 
     * */
    @Override
    public ResultVO ExReportExpendSendListInfoAllReturn2(Map<String, Object> param, ConnectionVO conVo) throws Exception {
      throw new NotImplementedException("나중에 사용할 예정");
    }
}
