package expend.ex.admin.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckExistsException;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundDataException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.BizboxLog;
import common.helper.logger.CommonLogger;
import common.vo.common.BizboxLogVO;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExReportCardVO;
import common.vo.ex.ExSendStatVO;
import common.vo.ex.ExpendVO;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.expend.BExUserService;

@Service("BExAdminReportService")
public class BExAdminReportServiceImpl implements BExAdminReportService {

    /* 변수정의 */
    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());
    /* 변수정의 - Service */
    @Resource(name = "FExAdminReportServiceA")
    private FExAdminReportService reportServiceA;
    @Resource(name = "FExAdminReportServiceI")
    private FExAdminReportService reportServiceI;
    @Resource(name = "FExAdminReportServiceU")
    private FExAdminReportService reportServiceU;
    @Resource(name = "BExUserService")
    private BExUserService userService;
    @Resource(name = "BExUserCodeService") /* 공통 조회 서비스 */
    private BExUserCodeService codeService;
    @Resource(name = "BExAdminConfigService") /* 환경설정 서비스 */
    private BExAdminConfigService configService;
    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    private CommonLogger cmLog; /* Log 관리 */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
    @Resource(name = "FExAdminReportServiceA")
    private FExAdminReportService adminReportServiceA;

    /* Biz - 회계(관리자) */
    /* Biz - 회계(관리자) - 지출결의 관리 */
    /* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 현황 */
    /* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 현황 - 목록 조회 */
    @Override
    public ResultVO ExAdminExpendManagerReportListInfoSelect(@RequestParam Map<String, Object> params) throws Exception {
        /*
         * parameter : fromDate, toDate, reqDate, adocuNo, appUserName, docNo, docTitle
         */
        ResultVO resultVo = new ResultVO();
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
            /* 데이터 조회 */
            resultVo.setParams(params);
            resultVo.setAaData(reportServiceA.ExAdminExpendManagerReportListInfoSelect(params));
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVo;
    }

    /* 지출결의 - 지출결의 상세현황 이준성 */
    @Override
    public ResultVO ExSlipAdminExpendManagerReportListInfoSelect(Map<String, Object> params) throws Exception {
        ResultVO resultVo = new ResultVO();

        try {
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("FExUserReportServiceA - ExAdminSlipExpendManagerReportListInfoSelect - parameter not exists >> " + commonCode.COMPSEQ);
            }
            resultVo.setParams(params);
            resultVo.setaData(reportServiceA.ExAdminSlipExpendManagerReportListInfoSelect(params));
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVo;
    }

    /* 지출결의 - 지출결의서 상세현황 엑셀다운로드 - 이준성 */
    @Override
    public ResultVO ExSlipAdminExpendManagerReportListInfoSelectExceDown(Map<String, Object> params) throws Exception {
        ResultVO resultVO = new ResultVO();

        try {
            resultVO.setParams(params);
            resultVO.setAaData(reportServiceA.ExSlipAdminExpendManagerReportListInfoSelectExceDown(params));
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }

        return resultVO;
    }

    /* Biz - 회계 ( 관리자 ) - 지출결의 관리 - 카드 사용 현황 */
    /* Biz - 회계 ( 관리자 ) - 지출결의 관리 - 카드 사용 현황 - 목록 조회 */
    @Override
    public ResultVO ExAdminCardReportListInfoSelect(ExReportCardVO reportCardVO) throws Exception {
        /* parameter : fromDate, toDate, cardNum, mercName */
        ResultVO resultVo = new ResultVO();
        try {
            /* 필수 파라미터 점검 - 카드번호, 거래처명칭은 선택 검색 */
            /* 데이터 조회 */
            resultVo.setParams(CommonConvert.ConverObjectToMap(reportCardVO));
            resultVo.setAaData(reportServiceA.ExAdminCardReportListInfoSelect(reportCardVO));
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVo;
    }

    /* 예외처리 로직 필요 */
    /* Biz - 회계 ( 관리자 ) - 지출결의 관리 - 지출결의 확인 - ERP전송 */
    @Override
    public ResultVO ExReportExpendSendListInfoSend(Map<String, Object> param) throws NotFoundLoginSessionException, NotFoundConnectionException, CheckExistsException, Exception {
      
      LoginVO loginVo = new LoginVO();
      
      /*
       * 자동 전송 옵션 시 
       * LoginVo 정보 조회 
       * */
      if (CommonConvert.CommonGetStr(param.get("autoSendYN")).contentEquals("Y")) {
       
        loginVo = adminReportServiceA.ExGetLoginSessionForApprovalProcess(param);
        
      }else {
        
        loginVo = CommonConvert.CommonGetEmpVO();
        
      }
      
      if(loginVo == null) {

        logger.error(param.toString());
        throw new NotFoundLoginSessionException("로그인 정보를 확인할 수 없습니다. 새로고침 후 다시 시도하세요.");
      
      } else if (param.get("expendSeq") == null || param.get("expendSeq").toString().equals("")) {
        logger.error(param.toString());
        throw new CheckExistsException("지출결의 자동전표 전송에 필요한 정보가 충독되지 않았습니다. 지속 발생시 관리자에게 문의해주세요.");
      }
      
      
      //로그 수집기 기록 ( 사용자 정보 확인 완료 후 기록 )
      BizboxLogVO logParam = new BizboxLogVO(loginVo.getGroupSeq(), loginVo.getCompSeq(), loginVo.getOrgnztId(), loginVo.getUniqId());
      logParam.setExpendSeq(param.get("expendSeq").toString());
      logParam.setErpSendYn("Y");
      BizboxLog.ExpendConnectERPAutoDocuSend(logParam);
      
      ConnectionVO conVo = new ConnectionVO();
      try {
          conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getGroupSeq()), CommonConvert.CommonGetStr(loginVo.getCompSeq()));

          logger.info("- 연동 ERP 정보 : " + conVo.getErpTypeCode());
          logger.info("- 연동 DBMS 정보 : " + conVo.getDatabaseType());
          
      } catch (NotFoundConnectionException e) {
          logger.error("- ERP 연동정보 설정 확인중 오류가 발생되었습니다.");
          logger.error("- ERP 연동설정이 정상적으로 설정되었는지 확인이 필요합니다.");
          logger.error(param.toString());
          throw new NotFoundConnectionException("ERP 연동정보 설정 확인중 오류가 발생되었습니다.");
      }
      
      
      param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
      
      ExSendStatVO exSendStatVo = new ExSendStatVO(loginVo);
      exSendStatVo.setExpendSeq(param.get("expendSeq").toString());
      
      /*
       * 성일 2021-11-15 [1.2.148] 1차 전송값 I에 대해 로직수정
       * 기존 > I상태값은 전송불가, 전송취소 불가
       * 변경 > I상태값 전송시 erp_send_yn = 'N'으로 롤백
       */ 
      try {
           exSendStatVo = reportServiceA.ExGetSendState(exSendStatVo);
           if (exSendStatVo.getErpSendYn().equals("Y")) {
             logger.error("이미 전송된 지출결의 문서를 다시 전송 시도하였습니다. (expendSeq : " + exSendStatVo.getExpendSeq() + ")");
             throw new CheckExistsException("이미 자동전표 전송처리된 지출결의 문서입니다.");             
           }
      } catch (CheckExistsException e) {
          
          logger.error("이미 전송된 지출결의 및 서버 통신 문제 발생");
          logger.error(e);	
          throw new CheckExistsException(e.getMessage());
      }     
      try {
    	  
    	  if(exSendStatVo.getErpSendYn().equals("") || exSendStatVo.getErpSendYn().equals(null)||exSendStatVo.getErpSendYn().equals("N")) {  
    		  exSendStatVo.setErpSendYn("I");
              exSendStatVo = reportServiceA.ExSetSendState(exSendStatVo);
    	  }
          
          if(exSendStatVo.getErpSendStatUpdateCount() < 1) {
             throw new CheckExistsException("전송실패한 문서가 존재합니다. 재전송하시기 바랍니다.");
          }
      } catch (CheckExistsException e) {
          reportServiceA.ExSetSendStateRollback(exSendStatVo);
          logger.error("전송실패한 문서가 존재합니다.상태값을 미전송으로 변경합니다.");
          logger.error(param.toString());
          throw new CheckExistsException(e.getMessage());
      }
      
      try {
          FExAdminReportService erpService = null;
          ResultVO dummy = null;
          
          switch ( CommonConvert.CommonGetStr(conVo.getErpTypeCode()) ) {
            case commonCode.ICUBE:
                erpService = reportServiceI;
                dummy = reportServiceA.ExReportExpendDummyListInfoSelect(param);
                
                if ( dummy == null || CommonConvert.CommonGetStr(dummy.getResultCode()).equals(commonCode.FAIL) ) {
                  throw new Exception("iCUBE 자동전표 전송을 위한 지출정보 조회에 실패하였습니다.");
                }
                
              break;
              
            case commonCode.ERPIU:
                erpService = reportServiceU;
                dummy = reportServiceA.ExReportExpendDummyListInfoSelectU(param);
                
                if (dummy == null || CommonConvert.CommonGetStr(dummy.getResultCode()).equals(commonCode.FAIL)) {
                  throw new Exception("iU 자동전표 전송을 위한 지출정보 조회에 실패하였습니다.");
                }
                
                String issNo = commonCode.EMPTYSTR;
                
                for(Map<String, Object> tData : dummy.getAaData()) {
                  if (CommonConvert.CommonGetStr(tData.get("interface_type")).toLowerCase().equals("etax")) {
                    issNo += CommonConvert.CommonGetStr(tData.get("iss_no")) + "','";
                    logger.info("- 전자세금계산서 정보가 포함되었습니다. (" + CommonConvert.CommonGetStr(tData.get("iss_no")) + ")");
                  }
                }
                
                if (CommonConvert.CommonGetStr(issNo).length() > 0) {
                  logger.info("- 세금계산서 정보 기준으로 ERPiU 사업장 정보를 조회합니다.");
                  
                  ResultVO tempBizInfo = new ResultVO();
                  Map<String, Object> tempParam = new HashMap<String, Object>();
                  
                  issNo = issNo.substring(0, issNo.length() - 3);
                  tempParam.put("issNo", issNo);
                  tempParam.put("erpCoCd", loginVo.getErpCoCd());

                  tempBizInfo.setParams(tempParam);
                  
                  tempBizInfo = reportServiceU.ExAdminETaxBizInfoSelect(tempBizInfo, conVo);
                  
                  List<Map<String, String>> tempBizData = new ArrayList<Map<String, String>>();
                  
                  for (Map<String, Object> tData : tempBizInfo.getAaData()) {
                      if (tempBizData.isEmpty()) {
                        Map<String, String> zeroData = new HashMap<String, String>();
                        zeroData.put("issNo", CommonConvert.CommonGetStr(tData.get("issNo")));
                        zeroData.put("noIss", CommonConvert.CommonGetStr(tData.get("noIss")));
                        zeroData.put("bizCd", CommonConvert.CommonGetStr(tData.get("bizCd")));
                        zeroData.put("bizNm", CommonConvert.CommonGetStr(tData.get("bizNm")));
                        zeroData.put("isMulti", "N");
                        tempBizData.add(zeroData);
                        continue;
                      }
                      
                      boolean isPut = true;
                      int sBizDataSize = tempBizData.size();

                      for (int idx = 0; idx < sBizDataSize; idx++) {
                        Map<String, String> bizDataTmp = tempBizData.get(idx);
                        if (CommonConvert.CommonGetStr(bizDataTmp.get("issNo")).equals(CommonConvert.CommonGetStr(tData.get("issNo")))) {

                            isPut = false;
                            if ((bizDataTmp.containsKey("mngBizCd") && !commonCode.EMPTYSTR.equals(bizDataTmp.get("mngBizCd")))) {
                                break;
                            }

                            bizDataTmp.put("isMulti", "Y");
                            bizDataTmp.put("mngBizCd", commonCode.EMPTYSTR);
                            bizDataTmp.put("mngBizNm", commonCode.EMPTYSTR);

                            for (Map<String, Object> dummyTmp : dummy.getAaData()) {

                                if (CommonConvert.CommonGetStr(dummyTmp.get("interface_type")).equals("etax") && CommonConvert.CommonGetStr(dummyTmp.get("iss_no")).equals(CommonConvert.CommonGetStr(bizDataTmp.get("issNo")))) {
                                    // 관리항목 조회 ( dummy에서 조회하는 방식 )
                                    for (int dIdx = 1; dIdx <= 8; dIdx++) {
                                        String cdStr = "cd_mng" + dIdx;
                                        String cddStr = "cd_mngd" + dIdx;
                                        String nmdStr = "nm_mngd" + dIdx;

                                        if ("A01".equals(CommonConvert.CommonGetStr(dummyTmp.get(cdStr)))) {

                                            bizDataTmp.put("mngBizCd", CommonConvert.CommonGetStr(dummyTmp.get(cddStr)));
                                            bizDataTmp.put("mngBizNm", CommonConvert.CommonGetStr(dummyTmp.get(nmdStr)));

                                            break;
                                        }
                                    }
                                }
                            }
                        }
                      }
                      if (isPut) {
                        Map<String, String> oneData = new HashMap<String, String>();
                        oneData.put("issNo", CommonConvert.CommonGetStr(tData.get("issNo")));
                        oneData.put("noIss", CommonConvert.CommonGetStr(tData.get("noIss")));
                        oneData.put("bizCd", CommonConvert.CommonGetStr(tData.get("bizCd")));
                        oneData.put("bizNm", CommonConvert.CommonGetStr(tData.get("bizNm")));
                        oneData.put("isMulti", "N");

                        tempBizData.add(oneData);
                    }
                  }
                  
                  int dummySize = dummy.getAaData().size();
                  for (int idx = 0; idx < dummySize; idx++) {
                      Map<String, Object> dummyTmp = dummy.getAaData().get(idx);
                      for (Map<String, String> sData : tempBizData) {
                          if (CommonConvert.CommonGetStr(dummyTmp.get("interface_type")).equals("etax") && CommonConvert.CommonGetStr(dummyTmp.get("iss_no")).equals(CommonConvert.CommonGetStr(sData.get("issNo")))) {
                              if ("Y".equals(sData.get("isMulti"))) {

                                  /*
                                   * 다중 사업장 동일한 세금계산서에 사업장이 여러 건이 매핑되는 경우 관리항목 A01(귀속사업장) 값으로 매핑되도록 로직 추가. 한 건이 조회되는 경우 기존 로직 적용
                                   */

                                  dummyTmp.put("bizCd", sData.get("mngBizCd"));
                                  dummyTmp.put("bizNm", sData.get("mngBizNm"));

                              } else {
                                  /*
                                   * 단일 사업장 사업장이 한 건인 경우 기존 로직 진행
                                   */
                                  dummyTmp.put("bizCd", sData.get("bizCd"));
                                  dummyTmp.put("bizNm", sData.get("bizNm"));
                              }
                              break;
                          }
                      }
                  }
                }

                /*
                 * 2022-01-21 이진
                 * 다른 곳에 구현되어있던 일부 관리항목 코드 값 제거 코드가
                 * 문서 단위 전송 시에만 동작하여 항목 단위 전송 시에도 동작하도록
                 * 이 곳으로 위치 옮기고 코드값 제거할 관리항목코드 C16 (세액) 추가
                 * 아래는 다른 곳에 구현되어 있었을 때 주석
                 * ----------------------------------------------------------
                 * 21.09.28 성일 수정
                 * iU 문의로 자동전표체크리스트 전송시 특정 CD_MNG값 NULL 처리
                 * 관리항목 8개기준으로 1<i<9로 표시
                 * C05, B21외 추가Null처리 요청 개발예정
                 *-----------------------------------------------------------
                 */
                for(Map<String, Object> dummyData : dummy.getAaData()) {
                    for (int i = 1; i <= 8; i++) {
                        String cdMng = CommonConvert.CommonGetStr(dummyData.get("cd_mng" + i));
                        if (cdMng.equals("C05") || cdMng.equals("C16") || cdMng.equals("B21")) {
                            dummyData.put("cd_mngd" + i, "");
                        }
                    }
                }
              break;  

            default:
                logger.error(param.toString());
                throw new Exception("사용자 ERP설정 정보를 확인하세요.");
          }
          
          if(dummy.getAaData().size() > 0) {
            logger.info("- 지출결의 옵션 확인 ([자동전표] 자동전표 전송 범위 설정 (기본 : 문서단위 전송)");
            param.put(commonCode.FORMSEQ, dummy.getAaData().get(0).get("form_seq"));
            param.put("useSw", conVo.getErpTypeCode());
            param.put("optionCode", "003401");
          }
          
          ResultVO expendOption = new ResultVO();
          
          expendOption = configService.ExAdminConfigOptionSelect(param);
          
          if (expendOption.getAaData() == null || expendOption.getAaData().size() == 0 || CommonConvert.CommonGetStr(expendOption.getAaData().get(0).get("set_value")).equals("E")) {
              logger.info("- ERP 자동전표 전송 기준 : 문서 단위 전송");
              ResultVO erpSendResult = new ResultVO();
              erpSendResult = erpService.ExReportExpendSendListInfoSend(dummy.getAaData(), conVo, loginVo);
              
              return erpSendResult;
          }else {
              logger.info("- ERP 자동전표 전송 기준 : 항목 단위 전송");
              ResultVO erpSendResult = new ResultVO();
              
              int tListSeq = 0;
              int idx = 0;
              
              List<Map<String, Object>> listDummy = new ArrayList<Map<String, Object>>();
              
              for (Map<String, Object> tDummy : dummy.getAaData()) {
                if (tListSeq == 0) {
                    tListSeq = Integer.parseInt(tDummy.get("list_seq").toString());
                    listDummy.add(tDummy);
                } else if (tListSeq == Integer.parseInt(tDummy.get("list_seq").toString())) {
                    listDummy.add(tDummy);
                } else if (tListSeq != Integer.parseInt(tDummy.get("list_seq").toString())) {
                    /* ERP 전송 처리 */
                    erpSendResult = erpService.ExReportExpendSendListInfoSendByList(listDummy, conVo, loginVo);
                    listDummy = new ArrayList<Map<String, Object>>();
                    listDummy.add(tDummy);
                    tListSeq = Integer.parseInt(tDummy.get("list_seq").toString());
                }

                if (++idx == dummy.getAaData().size()) {
                    /* ERP 전송 처리 */
                    erpSendResult = erpService.ExReportExpendSendListInfoSendByList(listDummy, conVo, loginVo);
                    listDummy = new ArrayList<Map<String, Object>>();
                }
            }
              
             return erpSendResult;
            
          }
      }catch (Exception e) {
        reportServiceA.ExSetSendStateRollback(exSendStatVo);
        throw new Exception(e.getMessage());
      }
      
    }

    /* Biz - 회계 ( 관리자 ) - 지출결의 관리 - 지출결의 확인 - ERP전송 취소 */
    @Override
    public ResultVO ExReportExpendSendListInfoReturn(Map<String, Object> param) throws Exception {
        /* 사용자, 커넥션 정보 생성 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        if (loginVo == null) {
            throw new NotFoundLoginSessionException("새로고침 후 다시 시도하세요.");
        }
        /* 사용자 커넥션 정보 검색 */
        ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        /* 커넥션 정보에 따른 서비스 변경 */
        FExAdminReportService erpService = null;
        if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
            erpService = reportServiceI;
        } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
            erpService = reportServiceU;
        } else {
            throw new NotFoundConnectionException("사용자 ERP설정 정보를 확인하세요.");
        }
        /* 전송취소 로직 진행 */
        /* 문서단위 전송과 항목단위 전송 구분지어서 진행 */
        ExpendVO expendVo = new ExpendVO();
        expendVo.setExpendSeq(param.get("expendSeq").toString());
        expendVo = userService.ExUserExpendInfoSelect(expendVo);
        param.put("formSeq", expendVo.getFormSeq());
        param.put("docSeq", expendVo.getDocSeq());
        param.put("useSw", conVo.getErpTypeCode());
        param.put("compSeq", loginVo.getCompSeq());
        param.put("optionCode", "003401");
        ResultVO expendOption = configService.ExAdminConfigOptionSelect(param);
        List<Map<String, Object>> isEmpty = reportServiceA.ExAdminExpendReportListHistorySelect(param);
        if ((expendOption.getAaData() == null || expendOption.getAaData().size() == 0 || CommonConvert.CommonGetStr(expendOption.getAaData().get(0).get("set_value")).equals("E")) && (isEmpty == null || isEmpty.size() == 0)) {
          return erpService.ExReportExpendSendListInfoReturn(param, conVo);
        } else {
          return erpService.ExReportExpendSendListInfoAllReturn(param, conVo);
        }
    }

    /* Biz - 회계 ( 관리자 ) - 지출결의 관리 - 지출결의 확인 - 목록 조회 */
    @Override
    public ResultVO ExAdminExpendCheckReportListInfoSelect(Map<String, Object> params) throws Exception {
        /*
         * parameter : fromDate, toDate, reqDate
         */
        ResultVO resultVo = new ResultVO();
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
            /* 데이터 조회 */
            resultVo.setParams(params);

            // A : 기본정보 다운로드 , B : 상세정보 다운로드(분개)
            if ("B".equals(params.get("excelType"))) {
                /* 상세정보(분개) 엑셀다운로드 */
                resultVo.setAaData(reportServiceA.ExAdminExpendCheckReportListInfoSelect(params));
            } else {
                /* 기본정보 엑셀다운로드 */
                resultVo.setAaData(reportServiceA.ExAdminExpendCheckReportListInfoSelect(params));
            }
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVo;
    }

    /* Biz - 회계 ( 관리자 ) - 지출결의 관리 - 지출결의 확인 - 엑셀 데이터 조회(상세내용) */
    @Override
    public ResultVO ExAdminExpendCheckReportListInfoSelect2(Map<String, Object> params) throws Exception {
        /*
         * parameter : fromDate, toDate, reqDate
         */
        ResultVO resultVo = new ResultVO();
        try {
            /* 기본값 지정 */
            /* 기본값 지정 - 사용자 정보 처리 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* 필수 파라미터 점검 */
            /* 필수 파라미터 점검 - 회사 시퀀스 */
            if (CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)).equals(commonCode.EMPTYSTR)) {
                throw new Exception("FExUserReportServiceA - ExAdminExpendCheckReportListInfoSelect2 - parameter not exists >> " + commonCode.COMPSEQ);
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 From */
            if (CommonConvert.CommonGetStr(params.get("searchFromDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExAdminExpendCheckReportListInfoSelect2 - BizboxA - parameter not exists >> " + commonCode.FROMDATE);
            }
            /* 필수 파라미터 점검 - 결의(회계)일자 To */
            if (CommonConvert.CommonGetStr(params.get("searchToDate")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("ExAdminExpendCheckReportListInfoSelect2 - BizboxA - parameter not exists >> " + commonCode.TODATE);
            }
            /* 필수 파라미터 점검 - 지급요청일, 자동전표번호, 작성자, 문서번호는 선택 검색 */
            /* 데이터 조회 */
            resultVo.setParams(params);
            resultVo.setAaData(reportServiceA.ExAdminExpendCheckReportListInfoSelect2(params));

        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVo;
    }

    /* Biz - 회계 ( 관리자 ) - 지출결의 현황 - 지출결의 삭제 */
    @Override
    public ResultVO ExAdminExpendInfoDelete(Map<String, Object> params) throws Exception {

        // Login 정보 확인 >> NotFoundLoginSessionException
        LoginVO login = CommonConvert.CommonGetEmpVO();

        // ERP 연동 정보 확인 >> NotFoundConnectionException
        ConnectionVO con = cmInfo.CommonGetConnectionInfo(login.getCompSeq());
        if (!con.getErpTypeCode().equals(commonCode.ICUBE) && !con.getErpTypeCode().equals(commonCode.ERPIU)) {
            throw new NotFoundConnectionException("iCUBE 연동 또는 ERPiU 연동시에만 기능이 제공됩니다.");
        }

        ResultVO result = new ResultVO();
        params.put(commonCode.EMPSEQ, login.getUniqId());
        params.put(commonCode.EMPNAME, login.getName());
        params.put("cdCompany", login.getErpCoCd());
        params.put(commonCode.COMPSEQ, login.getCompSeq());

        // 지출결의 정보 조회
        ExpendVO expend = new ExpendVO();
        expend.setExpendSeq(params.get(commonCode.EXPENDSEQ).toString());

        try {
            expend = userService.ExUserExpendInfoSelect(expend);
            params.put("expendVo", expend);
        } catch (NotFoundDataException e) {
            throw (e);
        }

        result.setParams(params);

        // ERP 연동 정보 처리 ( 전송 : true / 미전송 : false )
        boolean expendToErpSendStat = false;
        //expendToErpSendStat = (expend.getErpSendYN() != null && expend.getErpSendYN().equals("Y") ? true : false);

        if( expend.getErpSendYN() != null && expend.getErpSendYN().equals("Y") ) {
        	expendToErpSendStat = true;
        }else {
        	expendToErpSendStat = false;
        }


        // 자동전표 전송 취소 진행
        if (expendToErpSendStat) {
            Map<String, Object> erpSendInfo = new HashMap<String, Object>();
            erpSendInfo.put(commonCode.EXPENDSEQ, expend.getExpendSeq());
            erpSendInfo.put("cdCompany", login.getErpCoCd());
            erpSendInfo.put("rowId", expend.getRowId());
            erpSendInfo.put("inDt", expend.getInDt());
            erpSendInfo.put("inSq", expend.getInSq());

            if (this.ExReportExpendSendListInfoReturn(erpSendInfo).getResultCode().equals(commonCode.FAIL)) {
                throw new NotFoundDataException("삭제 대상의 문서는 이미 전표처리가 진행되었습니다. 문서를 삭제하시려면, 연동중인 ERP에서 전표처리 취소를 진행해주세요.");
            }
        } else {
            // ERP 미전송된 지출결의 문서입니다.
        }

        // 예산 정보 삭제 진행 (ERPiU)
        if (con.getErpTypeCode().equals(commonCode.ERPIU)) {
            // 연동된 예상정보를 삭제합니다.
            try {
                result = reportServiceU.ExAdminExpendERPBudgetDelete(result, con);
            } catch (Exception e) {
                // 예산정보 삭제에 실패하였습니다.
            }
        }

        // 외부시스템 연동 내역 상태값 변경
        result = reportServiceA.ExAdminExpendOtherSystemRollback(result, con);
        
        if (con.getErpTypeCode().equals(commonCode.ICUBE)) {
          ResultVO tResult = new ResultVO();
          Map<String, Object> tMap = new HashMap<String, Object>();
          
          if(result.getAaData() != null && result.getAaData().size() >0) {
              for(Map<String, Object> interfaceType : result.getAaData()) {
                if(CommonConvert.CommonGetStr(interfaceType.get("interfaceType").toString()).equals("card")) {
                  
                   result = codeService.ExExpendCardAInfoListSelect(result);
                   
                   //초기 데이터 설정 하는 곳 
                   tMap = result.getParams();
                   tMap.put("gwState", "");
                   tMap.put("docNo", "");
                   tMap.put("docSeq", "");
                   
                   //ACARD_SUGNIN update
                   for (Map<String, Object> tData : result.getAaData()) {
                     tMap.put("syncId", tData.get("syncId"));
                     tMap.put("issDt", tData.get("issDt"));
                     tMap.put("issSq", tData.get("issSq"));
                     tMap.put("cardNum", tData.get("cardNum"));
                     tMap.put("authNum", tData.get("authNum"));
                     tMap.put("erpCompSeq", login.getErpCoCd());
                     result.setParams(tMap);
                     result = reportServiceI.ExAdminExpendOtherSystemRollback(result, con);
                   }
                  
                }else if (CommonConvert.CommonGetStr(interfaceType.get("interfaceType").toString()).equals("etax")) {

                  result = codeService.ExExpendETaxInfoListSelect(result);
                  /* ERP회사 및 사업장 정보 조회 */
                  tResult.setParams(result.getParams());
                  tResult = codeService.ExCodeERPInfoSelect(tResult);
                  tMap = result.getParams();
                  tMap.put("erpCompSeq", tResult.getaData().get("erpCompSeq"));
                  tMap.put("erpBizSeq", tResult.getaData().get("erpBizSeq"));
                  /* 초기값 설정 */
                  tMap.put("getFg", 0);
                  tMap.put("approState", 4);
                  result.setParams(tMap);
                  /* iCUBE 연동 데이터 초기화 */
                  for (Map<String, Object> tData : result.getAaData()) {
                      tMap.put("issNo", tData.get("issNo"));
                      result.setParams(tMap);
                      result = reportServiceI.ExAdminExpendOtherSystemERPInfoReollback(result, con);
                  }
                  
                }
              }
          }
        }

        // 전자결재 삭제 진행
        result = reportServiceA.ExAdminAppdocDelete(result);

        // 지출결의 정보 삭제 진행
        result = reportServiceA.ExAdminExpendInfoDelete(result);

        /* 지출결의 History 테이블에 이력 남김 */
        Map<String, Object> addMap = new HashMap<String, Object>();
        addMap = result.getParams();
        addMap.put("modifyReason", "지출결의 삭제");
        addMap.put("docSeq", expend.getDocSeq());
        addMap.put("createdBy", login.getUniqId());
        result.setParams(addMap);
        userService.ExExpendEditHistoryInsert(result);

        return result;
    }

    /* 지출결의 - 매입전자세금계산서 리스트 조회 */
    @Override
    public ResultVO ExAdminEtaxReportList(ResultVO param, ConnectionVO conVo) throws Exception {
        List<Map<String, Object>> erpList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> gwList = new ArrayList<Map<String, Object>>();

        /* 그룹웨어 데이터 조회 */
        if (param.getParams().get(commonCode.COMPSEQ) == null || CommonConvert.CommonGetStr(param.getParams().get(commonCode.COMPSEQ)).equals(commonCode.COMPSEQ)) {
            Map<String, Object> tParam = param.getParams();
            tParam.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO().getCompSeq());
            param.setParams(tParam);
        }
        Map<String, Object> aData = new HashMap<String, Object>();
        gwList = reportServiceA.ExAdminEtaxReportList(param, conVo);

        Map<String, Object> mapParam = param.getParams();
        for (Map<String, Object> map : gwList) {
            if (CommonConvert.CommonGetStr(map.get("sendYN")).equals("Y")) {
                if (mapParam.containsKey("notInISSNO")) {
                    mapParam.put("notInISSNO", CommonConvert.CommonGetStr(mapParam.get("notInISSNO")) + ", '" + CommonConvert.CommonGetStr(map.get("issNo")) + "'");
                } else {
                    mapParam.put("notInISSNO", "'" + CommonConvert.CommonGetStr(map.get("issNo")) + "'");
                }
            }
        }

        param.setParams(mapParam);

        switch (conVo.getErpTypeCode()) {
            case commonCode.ERPIU:
                erpList = reportServiceU.ExAdminEtaxReportList(param, conVo);
                erpList.addAll(gwList);
                break;
            case commonCode.ICUBE:
                erpList = reportServiceI.ExAdminEtaxReportList(param, conVo);
                erpList.addAll(gwList);
                break;
            default:
                throw new NotFoundConnectionException("사용자 ERP설정 정보를 확인하세요.");
        }

        aData.put("dataLength", erpList.size());
        param.setaData(aData);

        /* erpList.addAll( gwList ); */
        param.setAaData(erpList);
        return param;
    }

    /* 지출결의 - iCUBE 연동문서 현황 리스트 조회 */
    @Override
    public ResultVO ExAdminiCUBEDocList(ResultVO param, ConnectionVO conVo) throws Exception {
        param = reportServiceA.ExAdminiCUBEDocList(param, conVo);
        return param;
    }

    /* 지출결의 - iCUBE 연동문서 현황 문서 삭제 */
    @Override
    public ResultVO ExAdminiCUBEDocListDelete(ResultVO param, ConnectionVO conVo) throws Exception {
        if (CommonConvert.CommonGetStr(param.getParams().get(commonCode.ERPCOMPSEQ)).equals(commonCode.EMPTYSTR)) {
            throw new NotFoundConnectionException("사용자 ERP설정 정보를 확인하세요.");
        }
        if (param.getParams().get("targetList") == null && CommonConvert.CommonGetStr(param.getParams().get("targetList")).equals(commonCode.EMPTYSTR)) {
            throw new Exception("문서 번호를 확인하여 주십시오");
        }
        /* 로그인정보 */
        //LoginVO loginVo = CommonConvert.CommonGetEmpVO();

        /* ERP 연결정보 조회 */
        //conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));

        // 성공적으로 삭제 개수 건건이 카운트
        int successCount = 0;

        String[] arrayApprokey = param.getParams().get("targetList").toString().split(",");
        int arrayCount = arrayApprokey.length;

        for (String approkey : arrayApprokey) {

            // approkey 를 확인할 수 없는 경우에는 프로세스 수행되지 않도록 처리
            if (approkey == null || approkey.equals("")) {
                continue;
            }

            Map<String, Object> tParam = param.getParams();
            tParam.put(commonCode.APPROKEY, approkey);
            param.setParams(tParam);

            try {
                /*
                 * iCUBE 연동문서 삭제 처리 진행 no_doc -> '' appro_state -> -3
                 */
                param = reportServiceI.ExAdminiCUBEDocListDelete(param, conVo);

                if (CommonConvert.CommonGetStr(param.getResultCode()).equals(commonCode.SUCCESS)) {
                    /*
                     * 그룹웨어 전자결재 문서 삭제처리 진행 use_yn -> 0
                     */
                    successCount++;
                    param = reportServiceA.ExAdminiCUBEDocListDelete(param, conVo);

                }
            } catch (Exception e) {
                param.setResultCode(commonCode.FAIL);
                cmLog.CommonSetError(e);
                throw e;
            }
        }
        param.setCount(Integer.toString(successCount));

        return param;
    }

    /* 지출결의 - 세금계산서현황 - 세금계산서 사용/미사용처리 */
    @Override
    public ResultVO ExAdminETaxSetUseYN(ResultVO param) throws Exception {
        param = reportServiceA.ExAdminETaxSetUseYN(param);
        return param;
    }

    /* 지출결의 - 카드현황 - 카드사용내역 사용/미사용처리 */
    @Override
    public ResultVO ExAdminCardSetUseYN(ResultVO param) throws Exception {
        param = reportServiceA.ExAdminCardSetUseYN(param);
        return param;
    }

    @Override
    public ResultVO ExAdminCardReportListInfoSelectForExcel(Map<String, Object> params) throws Exception {
        /* parameter : fromDate, toDate, cardNum, mercName */
        ResultVO resultVo = new ResultVO();
        try {
            /* 필수 파라미터 점검 - 카드번호, 거래처명칭은 선택 검색 */
            /* 데이터 조회 */
            resultVo.setParams(params);
            resultVo.setAaData(reportServiceA.ExAdminCardReportListInfoSelectForExcel(params));
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVo;
    }

}
