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
import common.helper.exception.NotFoundDataException;
import common.helper.exception.NotFoundLogicException;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxVO;
import common.vo.ex.ExErpSendiUVO;
import common.vo.ex.ExReportCardVO;
import common.vo.ex.ExSendStatVO;
import common.vo.ex.ExpendVO;
import expend.ex.user.expend.BExUserService;
import neos.cmm.util.AESCipher;
import neos.cmm.util.code.CommonCode;


@Service("FExAdminReportServiceU")
public class FExAdminReportServiceUImpl implements FExAdminReportService {

    @Resource(name = "CommonLogger")
    private CommonLogger cmLog; /* Log 관리 */
    /* 변수정의 - 지출결의 */
    @Resource(name = "BExUserService")
    private BExUserService userService;
    @Resource(name = "FExAdminReportServiceA")
    private FExAdminReportService reportServiceA;
    @Resource(name = "FExAdminReportServiceUDAO")
    private FExAdminReportServiceUDAO daoU;
    @Resource(name = "FExAdminReportServiceADAO")
    private FExAdminReportServiceADAO daoA;

    /* Common */
    /* Bizbox Alpha */
    /* Bizbox Alpha - 지출결의 확인 */
    /* Bizbox Alpha - 지출결의 확인 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExAdminExpendManagerReportListInfoSelect(Map<String, Object> params) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    /* Bizbox Alpha - 카드 사용 현황 */
    /* Bizbox Alpha - 카드 사용 현황 - 목록 조회 */
    @Override
    public List<Map<String, Object>> ExAdminCardReportListInfoSelect(ExReportCardVO reportCardVO) throws Exception {
        throw new NotImplementedException("Bizbox Alpha 전용기능으로 지원하지 않습니다.");
    }

    @Override
    /* iU - ERP 자동전표 전송 */
    public ResultVO ExReportExpendSendListInfoSend(List<Map<String, Object>> param, ConnectionVO conVo, LoginVO loginVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceUImpl - ExReportExpendSendListInfoSend");
        cmLog.CommonSetInfo("! [EX] List<ExReportSendExpendVO> sendListVo >> " + param.toString());
        ResultVO reuslt = new ResultVO();
        try {
            /* ERP 전송 VO생성. */
            ExErpSendiUVO data = new ExErpSendiUVO(param);
            /* ERP 전송 미완성 키 생성 */
            String unfinishedRowId;
            /* Date dt = new Date( ); */
            unfinishedRowId = "GW";
            unfinishedRowId += data.getExpendDate();
            /* ERP의 키 정보 조회 */
            Map<String, Object> keyQueryParam = new HashMap<String, Object>();
            keyQueryParam.put("UNFINISHED_ROW_ID", unfinishedRowId);
            Map<String, Object> key = daoU.ExReportKeySelect(conVo, keyQueryParam);
            int rowIdTemp = Integer.parseInt(key.get("ROW_ID").toString());
            int rowNoTemp = 0;
            String rowId = "";
            String cdPc = "";
            int checkParamIndex = -1;
            while (data.NextData() > -1) {
                /* ERP 키 정보 조합하여 새로운 슈퍼키 생성 */
                rowId = commonCode.EMPTYSTR + unfinishedRowId + String.format("%05d", rowIdTemp);
                String cdCompany = conVo.getErpCompSeq();
                String rowNo = commonCode.EMPTYSTR + (++rowNoTemp);
                cdPc = (cdPc.equals("") ? String.valueOf(data.data.getMap().get("CD_PC")) : cdPc);
                Map<String, Object> queryParam = data.data.getMap();
                /* 부가세 번호 입력 */
                if (!CommonConvert.CommonGetStr(queryParam.get("NO_TAX")).equals("*")) {
                    queryParam.put("NO_TAX", rowId + rowNo);
                }
                /* 그룹웨어 키정보, ERP전표 키번호 일치 */
                queryParam.put("ROW_ID", rowId);
                queryParam.put("ROW_NO", rowNo);
                queryParam.put("NO_DOCU", rowId);
                queryParam.put("NO_DOLINE", rowNo);
                queryParam.put("CD_COMPANY", cdCompany);
                checkParamIndex++;
                Map<String, Object> checkCdMng = param.get(checkParamIndex);
                
                
                /*21.09.28 성일 수정
                 * iU 문의로 자동전표체크리스트 전송시 특정 CD_MNG값 NULL 처리
                 * 관리항목 8개기준으로 1<i<9로 표시
                 * C05, B21외 추가Null처리 요청 개발예정
                 */
                for (int i=1; i<9; i++) {
                	if(checkCdMng.get("cd_mng"+i).equals("C05") || checkCdMng.get("cd_mng"+i).equals("B21")) {
                		queryParam.put("CD_MNGD"+i, "");
                	}
                }
                
                int result = daoU.ExReportExpendErpSend(queryParam, conVo);
                if (result == 0) {
                    throw new NotFoundDataException("결의서 전송실패");
                } else if (result == -1) {
                    throw new NotFoundDataException("접대비 부표 전송실패");
                } else if (result == -2) {
                    throw new NotFoundDataException("파일정보 전송실패");
                }
            }

            /* 첨부파일 정보 전송 ( 1차 개발 : 실패 시 별도 처리 없음 ) */
            Map<String, Object> attachParam = new HashMap<String, Object>();
            List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
            attachParam.put("rowId", rowId);
            attachParam.put("expendSeq", data.getExpendSeq());
            attachParam.put("cdPc", cdPc);
            attachParam.put("erpEmpNo", loginVo.getErpEmpCd());
            attachParam.put("groupSeq", loginVo.getGroupSeq());
            fileList = reportServiceA.ExAdminSendAttachAllSelectList(attachParam);

            for (Map<String, Object> map : fileList) {
                map.put("rowId", rowId);
                map.put("noDocu", rowId);
                map.put("cdPc", cdPc);
                map.put("cdCompany", loginVo.getErpCoCd());
                String filePath = "";
                filePath = filePath + "/exp/Common/File/Download.do?inLine=Y&file=";
                filePath = filePath + AESCipher.AES_Encode(loginVo.getGroupSeq() + "_" + map.get("pathSeq") + "_" + map.get("fileId") + "_" + map.get("fileSn"));
                map.put("filePath", filePath);
                map.put("idInsert", loginVo.getErpEmpCd());
            }

            if (fileList != null && fileList.size() > 0) {
                attachParam.put("fileList", fileList); // parameters : rowId, expendSeq, [listSeq], cdPc, erpEmpNo
                daoU.ExAdminDocAttachListInfoInsert(attachParam, conVo);
            }

            /* 그룹웨어 전표 연동 업데이트 */
            if (!data.isEmpty()) {
                Map<String, Object> updateParam = new HashMap<String, Object>();
                updateParam.put("rowId", rowId);
                updateParam.put("compSeq", data.getCompSeq());
                updateParam.put("empSeq", loginVo.getUniqId());
                updateParam.put("expendSeq", data.getExpendSeq());
                updateParam.put("groupSeq", loginVo.getGroupSeq());

                daoA.ExAdminExpendReportUpdateU(updateParam);

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

                if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).toUpperCase().equals("MSSQL") || CommonConvert.CommonGetStr(conVo.getDatabaseType()).toUpperCase().equals("ORACLE") ) {
                    /* 지출결의 문서 링크 정보 전달 */
                    /* 지출결의 문서 링크 정보 전달 - 전달 정보 조회 */
                    List<Map<String, Object>> docLinkList = new ArrayList<Map<String, Object>>();
                    docLinkList = daoA.ExAdminDocLinkListInfoSelect(updateParam);
                    /* 지출결의 문서 링크 정보 전달 - 전송 */
                    for (Map<String, Object> map : docLinkList) {
                        map.put("erpEmpSeq", loginVo.getErpEmpCd());
                        daoU.ExAdminDocLinkListInfoInsert(map, conVo);
                    }
                }
            }
            reuslt.setResultName("");
            reuslt.setResultCode(commonCode.SUCCESS);
        } catch (NotFoundDataException ex) {
            reuslt.setResultName("데이터 전송실패");
            reuslt.setResultCode(commonCode.FAIL);
        } catch (Exception ex) {
            cmLog.CommonSetError(ex);
            throw ex;
        }
        cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + reuslt.toString());
        cmLog.CommonSetInfo("- [EX] ExReportExpendSendiCUBEService - ExReportExpendSendListInfoSend");
        return reuslt;
    }

    @Override
    /* iU - ERP 전송 취소 */
    public ResultVO ExReportExpendSendListInfoChekedReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceIImpl - ExReportExpendSendListInfoReturn");
        cmLog.CommonSetInfo("! [EX] Map<String, Object> " + param.toString());
        ResultVO resultVo = new ResultVO();
        try {
            /* 1. 삭제 가능한 정보인지 검증 */
            if (daoU.ExReportExpendReturnCountInfoSelect(param, conVo) == 0) {
                throw new NotFoundDataException("전표 발행이 진행된 문서입니다.");
            }
            /* 2. 그룹웨어 연동 정보 삭제 */
            if (daoA.ExAdminExpendReportKeyRollback(param) == 0) {
                throw new NotFoundDataException("전송기록이 없습니다.");
            }
            /* 3. ERP연동 정보 삭제 */
            if (daoU.ExReportExpendSendInfoDelete(param, conVo) == 0) {
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
    
    
    /*
     * 준성 - ERP iU (문서 단위) 전송 취소 
     * */
    @Override
    public ResultVO ExReportExpendSendListInfoReturn(Map<String,Object> param, ConnectionVO conVo ) throws Exception{
      cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceIImpl - ExReportExpendSendListInfoReturn2");
      cmLog.CommonSetInfo("! [EX] Map<String, Object> " + param.toString());
      ResultVO resultVo = new ResultVO();
      
      try {
        
        /* ERP iU에서 전표 발행 한 건이 있는지 확인 */
        daoU.ExReportExpendTpDocuInfoSelect(param , conVo);
        
        /* 그룹웨어 row_id update */
        if (daoA.ExAdminExpendReportKeyRollback(param) == 0) {
            throw new NotFoundDataException("전송기록이 없습니다.");
        }
        
        /* ERP iU에서 전표,링크,첨부파일 등 지우는 곳  */
        daoU.ExReportExpendSendDelete(param, conVo);
        
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
       
      } catch (Exception e) {
        resultVo.setResultCode(commonCode.FAIL);
        resultVo.setResultName(e.getMessage());
      }
      cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + resultVo.toString());
      cmLog.CommonSetInfo("- [EX] ExReportExpendSendListInfoReturn2 - ExReportExpendSendListInfoReturn2");
      return resultVo;
    }
    
    
     /*
     * 준성 - ERP iU (항목 단위) 전송 취소
     */
    @Override
    public ResultVO ExReportExpendSendListInfoAllReturn(Map<String, Object> param, ConnectionVO conVo) throws Exception {
      cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceIImpl - ExReportExpendSendListInfoAllReturn2");
      cmLog.CommonSetInfo("! [EX] Map<String, Object> " + param.toString());
      ResultVO resultVo = new ResultVO();
  
      try {
        /* 삭제 하려고 하는 지출결의 정보 조회 */
          List<Map<String, Object>> expendERPInfo = daoA.ExAdminExpendReportListHistorySelect(param);
          
            /* ERP iU에서 전표 발행 한 건이 있는지 확인 */
            for (Map<String, Object> tMap : expendERPInfo) {
              param.put("rowId", tMap.get("rowId"));
              daoU.ExReportExpendTpDocuInfoSelect(param, conVo);
            }
            
            for (Map<String, Object> tMap : expendERPInfo) {
              param.put("rowId", tMap.get("rowId"));
              /* 그룹웨어 연동 정보 삭제 */
              if (daoA.ExAdminExpendReportKeyRollback(param) == 0) {
                throw new NotFoundDataException("전송기록이 없습니다.");
              }
              /* ERP iU에서 전표,링크,첨부파일 등 지우는 곳 */
              daoU.ExReportExpendSendDelete(param, conVo);
    
              /* 그룹웨어 전송 테이블 삭제 */
              if (daoA.ExAdminExpendReportKeyRollbackAllERPiU(param) == 0) {
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
  
      } catch (Exception e) {
        resultVo.setResultCode(commonCode.FAIL);
        resultVo.setResultName(e.getMessage());
      }
  
      return resultVo;
    }

    @Override
    public ResultVO ExReportExpendDummyListInfoSelect(Map<String, Object> param) throws Exception {
        throw new NotFoundLogicException("해당 기능은 지출결의 정보 조회이며, 그룹웨어 커넥션 전용입니다.", commonCode.ERPIU);
    }

    @Override
    public ResultVO ExReportExpendDummyListInfoSelectU(Map<String, Object> param) throws Exception {
        throw new NotFoundLogicException("해당 기능은 지출결의 정보 조회이며, 그룹웨어 커넥션 전용입니다.", "iU");
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
        tMap.put("rowId", expendVo.getRowId());
        param.setParams(tMap);
        param = daoU.ExAdminExpendSendERPDataDelete(param, conVo);
        return param;
    }

    /* ERP 임시 예산삭제 */
    @Override
    public ResultVO ExAdminExpendERPBudgetDelete(ResultVO param, ConnectionVO conVo) throws Exception {
        /* 슬립 정보 조회 */
        param = daoA.ExAdminExpendDrInfo_ERPiU(param);
        for (Map<String, Object> tData : param.getAaData()) {
            if (!CommonConvert.CommonGetStr(tData.get("budgetSeq")).equals(commonCode.EMPTYSEQ)) {
                daoU.ExAdminExpendERPBudgetDelete(tData, conVo);
            }
        }
        return param;
    }

    /* 외부연동(법인카드, 매입전자세금계산서) 미사용 처리 */
    @Override
    public ResultVO ExAdminExpendOtherSystemRollback(ResultVO param, ConnectionVO conVo) throws Exception {
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
        return param;
    }

    /* 지출결의 ERP 전송(항목 별 전송) */
    @Override
    public ResultVO ExReportExpendSendListInfoSendByList(List<Map<String, Object>> param, ConnectionVO conVo, LoginVO loginVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceUImpl - ExReportExpendSendListInfoSend");
        cmLog.CommonSetInfo("! [EX] List<ExReportSendExpendVO> sendListVo >> " + param.toString());
        ResultVO reuslt = new ResultVO();
        try {
            /* ERP 전송 VO생성. */
            ExErpSendiUVO data = new ExErpSendiUVO(param);
            /* ERP 전송 미완성 키 생성 */
            String unfinishedRowId;
            unfinishedRowId = "GW";
            unfinishedRowId += data.getExpendDate();
            /* ERP의 키 정보 조회 */
            Map<String, Object> keyQueryParam = new HashMap<String, Object>();
            keyQueryParam.put("UNFINISHED_ROW_ID", unfinishedRowId);
            Map<String, Object> key = daoU.ExReportKeySelect(conVo, keyQueryParam);
            int rowIdTemp = Integer.parseInt(key.get("ROW_ID").toString());
            int rowNoTemp = 0;
            String rowId = "";
            String cdPc = "";

            while (data.NextData() > -1) {
                /* ERP 키 정보 조합하여 새로운 슈퍼키 생성 */
            	rowId = commonCode.EMPTYSTR + unfinishedRowId + String.format("%05d", rowIdTemp);
                String cdCompany = conVo.getErpCompSeq();
                String rowNo = commonCode.EMPTYSTR + (++rowNoTemp);
                cdPc = (cdPc.equals("") ? String.valueOf(data.data.getMap().get("CD_PC")) : cdPc);
                Map<String, Object> queryParam = data.data.getMap();
                /* 부가세 번호 입력 */
                if (!CommonConvert.CommonGetStr(queryParam.get("NO_TAX")).equals("*")) {
                    queryParam.put("NO_TAX", rowId + rowNo);
                }
                /* 그룹웨어 키정보, ERP전표 키번호 일치 */
                queryParam.put("ROW_ID", rowId);
                queryParam.put("ROW_NO", rowNo);
                queryParam.put("NO_DOCU", rowId);
                queryParam.put("NO_DOLINE", rowNo);
                queryParam.put("CD_COMPANY", cdCompany);
                int result = daoU.ExReportExpendErpSend(queryParam, conVo);
                if (result < 1) {
                    throw new NotFoundDataException("데이터 전송실패");
                }
            }

            Map<String, Object> attachParam = new HashMap<String, Object>();
            List<Map<String, Object>> fileList = new ArrayList<Map<String, Object>>();
            attachParam.put("rowId", rowId);
            attachParam.put("expendSeq", data.getExpendSeq());
            attachParam.put("listSeq", data.getListSeq());
            attachParam.put("cdPc", cdPc);
            attachParam.put("erpEmpNo", loginVo.getErpEmpCd());
            attachParam.put("groupSeq", loginVo.getGroupSeq());
            fileList = reportServiceA.ExAdminSendAttachSelectList(attachParam);

            for (Map<String, Object> map : fileList) {
                map.put("rowId", rowId);
                map.put("noDocu", rowId);
                map.put("cdPc", cdPc);
                map.put("cdCompany", loginVo.getErpCoCd());
                String filePath = "";
                filePath = filePath + "/exp/Common/File/Download.do?inLine=Y&file=";
                filePath = filePath + AESCipher.AES_Encode(loginVo.getGroupSeq() + "_" + map.get("pathSeq") + "_" + map.get("fileId") + "_" + map.get("fileSn"));
                map.put("filePath", filePath);
                map.put("idInsert", loginVo.getErpEmpCd());
            }

            if (fileList != null && fileList.size() > 0) {
                attachParam.put("fileList", fileList); // parameters : rowId, expendSeq, [listSeq], cdPc, erpEmpNo
                daoU.ExAdminDocAttachListInfoInsert(attachParam, conVo);
            }

            /* 그룹웨어 전표 연동 업데이트 */
            if (!data.isEmpty()) {
                Map<String, Object> updateParam = new HashMap<String, Object>();
                updateParam.put("rowId", rowId);
                updateParam.put("compSeq", data.getCompSeq());
                updateParam.put("empSeq", loginVo.getUniqId());
                updateParam.put("expendSeq", data.getExpendSeq());
                updateParam.put("groupSeq", loginVo.getGroupSeq());
                //준성 개발 중
                daoA.ExAdminExpendReportUpdateU(updateParam);
                /* 항목단위 입력인 경우 지출결의 변경이력 테이블에 RowID 저장 */
                updateParam.put("listSeq", param.get(0).get("list_seq"));
                updateParam.put("rowId", rowId);
                updateParam.put("inDt", "");
                updateParam.put("inSq", "");
                updateParam.put("docSeq", param.get(0).get("doc_seq"));
                updateParam.put("createSeq", loginVo.getUniqId());
                updateParam.put("sendType", "multi");

                daoA.ExAdminExpendReportListHistoryInsert(updateParam);

                if (CommonConvert.CommonGetStr(conVo.getDatabaseType()).toUpperCase().equals("MSSQL")) {
                    /* 지출결의 문서 링크 정보 전달 */
                    /* 지출결의 문서 링크 정보 전달 - 전달 정보 조회 */
                    List<Map<String, Object>> docLinkList = new ArrayList<Map<String, Object>>();
                    docLinkList = daoA.ExAdminDocLinkListInfoSelect(updateParam);
                    /* 지출결의 문서 링크 정보 전달 - 전송 */
                    for (Map<String, Object> map : docLinkList) {
                        map.put("erpEmpSeq", loginVo.getErpEmpCd());
                        daoU.ExAdminDocLinkListInfoInsert(map, conVo);
                    }
                }
            }
            reuslt.setResultName("");
            reuslt.setResultCode(commonCode.SUCCESS);
        } catch (NotFoundDataException ex) {
            reuslt.setResultName("데이터 전송실패");
            reuslt.setResultCode(commonCode.FAIL);
        } catch (Exception ex) {
            cmLog.CommonSetError(ex);
            throw ex;
        }
        cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + reuslt.toString());
        cmLog.CommonSetInfo("- [EX] ExReportExpendSendiCUBEService - ExReportExpendSendListInfoSend");
        return reuslt;
    }

    /* 지출결의 ERP 전송 취소(항목단위) */
    @Override
    public ResultVO ExReportExpendSendListInfoAllReturn2(Map<String, Object> param, ConnectionVO conVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] FExAdminReportServiceIImpl - ExReportExpendSendListInfoAllReturn");
        cmLog.CommonSetInfo("! [EX] Map<String, Object> " + param.toString());
        ResultVO resultVo = new ResultVO();
        try {
            /* 삭제 하려고 하는 지출결의 정보 조회 */
            List<Map<String, Object>> expendERPInfo = new ArrayList<Map<String, Object>>();
            expendERPInfo = daoA.ExAdminExpendReportListHistorySelect(param);
            if (expendERPInfo.size() > 0) {
                for (Map<String, Object> tMap : expendERPInfo) {
                    /* 1. 삭제 가능한 정보인지 검증 */
                    param.put("rowId", tMap.get("rowId"));
                    if (daoU.ExReportExpendReturnCountInfoSelect(param, conVo) == 0) {
                        throw new NotFoundDataException("전표 발행이 진행된 문서입니다.");
                    }
                }
                /* 전표 발행이 진행된 문서가 하나라도 존재하면 전송취소 금지. */
                for (Map<String, Object> tMap : expendERPInfo) {
                    param.put("rowId", tMap.get("rowId"));
                    /* 2. 그룹웨어 연동 정보 삭제 */
                    if (daoA.ExAdminExpendReportKeyRollback(param) == 0) {
                        throw new NotFoundDataException("전송기록이 없습니다.");
                    }
                    /* 3. ERP연동 정보 삭제 */
                    if (daoU.ExReportExpendSendInfoDelete(param, conVo) == 0) {
                        throw new NotFoundDataException("ERP연동 정보가 없습니다.");
                    }
                    /* 4. 그룹웨어 전송 테이블 삭제 */
                    if (daoA.ExAdminExpendReportKeyRollbackAllERPiU(param) == 0) {
                        throw new NotFoundDataException("전송기록이 없습니다.");
                    }
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
        etaxVo.setSearchFromDt(param.getParams().get("searchFromDt").toString());
        etaxVo.setSearchToDt(param.getParams().get("searchToDt").toString());
        /* 검색조건 */
        etaxVo.setIssNo(param.getParams().get("issNo").toString());
        etaxVo.setTrNm(param.getParams().get("partnerName").toString());
        etaxVo.setTrregNb(param.getParams().get("partnerNo").toString());
        etaxVo.setEmailDc(param.getParams().get("emailDc").toString());
        etaxListVo = daoU.ExAdminETaxListInfoSelectMap(etaxVo, conVo);
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
        param = daoU.ExAdminETaxBizInfoSelect(param, conVo);
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

}
