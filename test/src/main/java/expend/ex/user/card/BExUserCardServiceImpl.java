package expend.ex.user.card;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import common.enums.ex.TaxType;
import common.enums.ex.TaxiUType;
import common.helper.convert.CommonConvert;
import common.helper.exception.BudgetAmtOverException;
import common.helper.exception.NotFoundDataException;
import common.helper.exception.NotFoundErpCardException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExExpendMngVO;
import common.vo.ex.ExpendVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import expend.ex.budget.BExBudgetService;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.expend.BExUserService;
import expend.ex.user.list.BExUserListService;
import expend.ex.user.mng.FExUserMngServiceUDAO;
import main.web.BizboxAMessage;


@Service ( "BExUserCardService" )
public class BExUserCardServiceImpl implements BExUserCardService {

    /* 변수정의 - Class */
    @Resource(name = "CommonLogger")
    private final CommonLogger cmLog = new CommonLogger();
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
    @Resource(name = "FExUserCardServiceADAO")
    private FExUserCardServiceADAO dao;
    @Resource(name = "BExUserCodeService")
    private BExUserCodeService exService;
    @Resource(name = "BExUserListService")
    private BExUserListService listService;
    @Resource(name = "BExUserService")
    private BExUserService userService;
    @Resource(name = "BExBudgetService")
    private BExBudgetService budgetService;/* 예산 서비스 */
    @Resource(name = "FExUserMngServiceUDAO")
    private FExUserMngServiceUDAO exUserMngServiceUDAO;

    /* 지출결의 - 카드 상신 목록 조회 ( 사용자 ) */
    @Override
    public List<Map<String, Object>> ExExpendEmpCardListInfoSelect(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> returnMap = new ArrayList<Map<String, Object>>();
        /* 작성중인 카드정보는 제외 */
        List<Map<String, Object>> useCardInfo = new ArrayList<Map<String, Object>>();
        useCardInfo = dao.ExExpendUseCardInfoSelect(params);
        String notInSyncId = commonCode.EMPTYSTR;

        try {
          for (Map<String, Object> tData : useCardInfo) {
            notInSyncId += tData.get("syncId").toString() + "','";
          }
          if (notInSyncId.length() > 3) {
            notInSyncId = notInSyncId.substring(0, notInSyncId.length() - 3);
          }

          params.put("notInSyncId", notInSyncId);
        } catch (Exception e) {
          cmLog.CommonSetError(e);
          throw e;
        }

        try {
            // 카드사용내역 조회 시 취소분 포함일때
            if (params.get("isSearchWithCancel").equals("Y")) {
                // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                returnMap = dao.ExExpendEmpCardListInfoWithCancelInfoSelect(params);
            } else {
                // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                returnMap = dao.ExExpendEmpCardListInfoSelect(params);
            }
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return returnMap;
    }

    /* 지출결의 */
    /* 지출결의 - 카드 사용내역 상태값 수정 */
    @Override
    public ExCommonResultVO ExExpendCardSubInfoUpdate(ExCodeCardVO cardVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] ExExpendCardService - ExExpendCardSubInfoUpdate");
        cmLog.CommonSetInfo("! [EX] Map<String, Object> cardMap >> " + cardVo.toString());
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            resultVo = dao.ExExpendCardSubInfoUpdate(cardVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        cmLog.CommonSetInfo("! [EX] Map<String, Object> resultVo >> " + resultVo.toString());
        cmLog.CommonSetInfo("- [EX] ExExpendCardService - ExExpendCardSubInfoUpdate");
        return resultVo;
    }

    /* 지출결의 - 카드 사용내역 지출결의 항목 분개 처리 */
    @Override
    public ExCommonResultVO ExCardInfoMake(Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] ExExpendCardService - ExCardInfoMake");
        cmLog.CommonSetInfo("! [EX] Map<String, Object> param >> " + param.toString());
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            /* 반영 내역 정의 */
            List<ExCodeCardVO> cardListVo = new ArrayList<ExCodeCardVO>();
            boolean isSlipMode = false;
            if (param.get("isSlipMode") != null) {
                isSlipMode = Boolean.parseBoolean(param.get("isSlipMode").toString());
            }
            for (Map<String, Object> map : ConvertManager.ConvertJsonToListMap((String) param.get("target"))) {
                ExCodeCardVO cardVo = new ExCodeCardVO();
                cardVo = (ExCodeCardVO) ConvertManager.ConvertMapToObject(map, cardVo);
                cardVo.setCompSeq(loginVo.getCompSeq());

                try {
                    // 카드 사용내역 상세 취소분 포함일 경우
                    if (CommonConvert.CommonGetStr(param.get("isSearchWithCancel")).equals("Y")) {
                        cardVo = this.ExReportCardDetailInfoWithCancelInfoSelect(cardVo);
                    } else {
                        cardVo = this.ExReportCardDetailInfoSelect(cardVo);
                    }
                } catch (NullPointerException e) {
                    throw new NotFoundDataException("카드사용내역을 불러올 수 없습니다. ERP 카드등록 또는 그룹웨어 카드설정을 다시 확인해 주시기 바랍니다.");
                }

                cardListVo.add(cardVo);
            }
            for (ExCodeCardVO exCodeCardVO : cardListVo) {
                /* list param */
                Map<String, Object> listParam = new HashMap<String, Object>();
                /* 데이터 생성 - 사용자 */
                ExCodeOrgVO empVo = new ExCodeOrgVO(); /* 지출결의 사용자 */
                if (param.get("emp") != null && exCodeCardVO.getEmpSeq().equals(commonCode.EMPTYSEQ)) {
                    empVo = (ExCodeOrgVO) ConvertManager.ConvertMapToObject(ConvertManager.ConvertJsonToMap((String) param.get("emp")), empVo);
                } else if (!exCodeCardVO.getEmpSeq().equals(commonCode.EMPTYSEQ)) {
                    empVo.setSeq(Integer.parseInt(exCodeCardVO.getEmpSeq()));
                    empVo.setGroupSeq(loginVo.getGroupSeq());
                    empVo = exService.ExExpendEmpInfoSelect(empVo);
                } else {
                    empVo = null;
                }
                if (empVo != null) {
                    empVo.setCreateSeq(loginVo.getUniqId());
                    empVo.setModifySeq(loginVo.getUniqId());
                    empVo.setSeq(0);
                    listParam.put("emp", empVo);
                }
                /* auth */
                ExCodeAuthVO authVo = new ExCodeAuthVO();
                authVo.setSeq(Integer.parseInt(exCodeCardVO.getAuthSeq()));
                authVo = exService.ExExpendAuthInfoSelect(authVo);
                if (authVo == null) {
                    // 승인정보 데이터 조회 필요
                    throw new Exception("지출결의 정보 확인에 실패하였습니다.");
                }
                authVo.setSeq(0);
                listParam.put("auth", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(authVo)));
                /* summary */
                ExCodeSummaryVO summaryVo = new ExCodeSummaryVO();
                summaryVo.setSeq(Integer.parseInt(exCodeCardVO.getSummarySeq()));
                summaryVo = exService.ExExpendSummaryInfoSelect(summaryVo);
                summaryVo.setSeq(0);
                listParam.put("summary", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(summaryVo)));
                /* partner - 신규생성 */
                ExCodePartnerVO partnerVo = new ExCodePartnerVO();
                partnerVo.setErpCompSeq(loginVo.getErpCoCd());
                partnerVo.setSearchStr(exCodeCardVO.getMercSaupNo().replaceAll("-", commonCode.EMPTYSTR));
                // 폼양식 정보
                Map<String, Object> formInfo = ConvertManager.ConvertJsonToMap(CommonConvert.CommonGetStr(param.get("formInfo")));
                partnerVo.setFormSeq(CommonConvert.CommonGetStr(formInfo.get("formSeq")));// 폼 시퀀스
                if (partnerVo.getPartnerNo().equals(commonCode.EMPTYSTR) && CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                    partnerVo.setPartnerNo(exCodeCardVO.getMercSaupNo());
                    partnerVo.setPartnerName(exCodeCardVO.getMercName());
                    partnerVo.setCeoName(exCodeCardVO.getMercRepr());
                }
                /* 해외 거래처인 경우 사업자 등록번호를 강제로 넣어준다(전체조회 안되게) */
                /* 2019-03-13. 김상겸, 이준성 : 세포아소프트 요구사항으로 사업자등록번호가 "0"인 경우 해외거래처 판단하도록 프로세스 추가 ==> 이준성 연구원 테스트 필요!!!! */
                if (partnerVo.getSearchStr().equals(commonCode.EMPTYSTR) || partnerVo.getSearchStr().equals("0000000000") || partnerVo.getSearchStr().equals("0")) {
                    partnerVo.setPartnerNo("");
                    partnerVo.setSearchStr("!@#$%^&*()");
                }
                /* 거래처 정보 조회 */
                if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.BIZBOXA)) {
                    partnerVo = exService.ExCodePartnerInfoSelect(partnerVo, conVo);
                } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                    partnerVo = exService.ExCodePartnerInfoSelect(partnerVo, conVo);
                } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
                    partnerVo = exService.ExCodePartnerInfoSelect(partnerVo, conVo);
                }
                /* 거래처가 미존재 하는 경우는 거래처 명만 처리 */
                if (partnerVo.getPartnerName().equals(commonCode.EMPTYSTR)) {
                    partnerVo.setPartnerName(exCodeCardVO.getMercName());
                    if (partnerVo.getSearchStr().equals("!@#$%^&*()")) {
                        partnerVo.setSearchStr(commonCode.EMPTYSTR);
                    }
                }
                partnerVo.setSeq(0);
                listParam.put("partner", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(partnerVo)));
                /* project */
                ExCodeProjectVO projectVo = new ExCodeProjectVO();
                projectVo.setSeq(Integer.parseInt(exCodeCardVO.getProjectSeq()));
                if (!exCodeCardVO.getProjectSeq().equals(commonCode.EMPTYSEQ)) {
                    projectVo = exService.ExExpendProjectInfoSelect(projectVo);
                }
                projectVo.setSeq(0);
                listParam.put("project", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(projectVo)));
                /* card - 신규생성 */
                ExCodeCardVO cardVo = new ExCodeCardVO();
                cardVo.setErpCompSeq(loginVo.getErpCoCd());
                cardVo.setSearchCardNum(exCodeCardVO.getCardNum());
                cardVo.setSearchStr(exCodeCardVO.getCardNum());
                cardVo.setCompSeq(loginVo.getCompSeq());
                cardVo.setAuthNum(exCodeCardVO.getAuthNum());
                if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.BIZBOXA)) {
                    cardVo = exService.ExCodeCardInfoSelect(cardVo, conVo);
                } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                    try {
                        cardVo = exService.ExCodeCardInfoSelect(cardVo, conVo);
                                    } catch (Exception e) {
                        throw new NotFoundErpCardException("ERP 카드정보를 확인할 수 없습니다. 카드가 등록되지 않았거나, 카드번호가 잘못 지정되었을 수 있습니다.");
                                    }
                } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
                    cardVo = exService.ExCodeCardInfoSelect(cardVo, conVo);
                }
                listParam.put("card", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(cardVo)));
                /* budget */
                ExCodeBudgetVO budgetVo = new ExCodeBudgetVO();
                budgetVo.setSeq(Integer.parseInt(exCodeCardVO.getBudgetSeq()));
                budgetVo = exService.ExExpendBudgetInfoSelect(budgetVo);

                /*
                 * setAmt, setDracctAmt 수정 예산체크 시에 증빙유형에 따라 분기처리 된 공급가액을 예산체크 하도록 수정 적용
                 */
                String calcAmt = GetCheckBudgetAMT(CommonConvert.CommonGetStr(conVo.getErpTypeCode()), authVo, exCodeCardVO);
                budgetVo.setAmt(calcAmt);
                budgetVo.setDracctAmt(calcAmt);

                budgetVo.setErpCompSeq(exCodeCardVO.getErpCompSeq());
                budgetVo.setErpDeptSeq(exCodeCardVO.getErpDeptSeq());
                budgetVo.setErpEmpSeq(exCodeCardVO.getErpEmpName());
                /* 현재 지출결의의 회계일자로 예산정보 변경해줘야 한다. */
                ExpendVO expendVo = new ExpendVO();
                expendVo.setExpendSeq((String) param.get("expendSeq"));
                expendVo = userService.ExUserExpendInfoSelect(expendVo);
                budgetVo.setBudgetYm(expendVo.getExpendDate().substring(0, 6));
                budgetVo.setSeq(0);
                listParam.put("budget", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(budgetVo)));
                /* 예산 체크 진행 */
                boolean isUseBudget = false;
                if (param.get("isUseBudget") != null) {
                    isUseBudget = Boolean.parseBoolean(param.get("isUseBudget").toString());
                }
                if (isUseBudget) {
                    Map<String, Object> budgetParam = new HashMap<String, Object>();
                    budgetParam.put("budgetCode", budgetVo.getBudgetCode());
                    budgetParam.put("budgetName", budgetVo.getBudgetName());
                    budgetParam.put("bgacctCode", budgetVo.getBgacctCode());
                    budgetParam.put("bgacctName", budgetVo.getBgacctName());
                    budgetParam.put("acctCode", budgetVo.getBgacctCode());
                    if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                        if (budgetVo.getBgacctCode().equals(commonCode.EMPTYSTR)) {
                            budgetParam.put("acctCode", summaryVo.getDrAcctCode());
                            budgetParam.put("bgacctCode", summaryVo.getDrAcctCode());
                            budgetParam.put("bgacctName", summaryVo.getDrAcctName());
                        }
                    }
                    budgetParam.put("bizplanCode", budgetVo.getBizplanCode());
                    budgetParam.put("bizplanName", budgetVo.getBizplanName());
                    budgetParam.put("erpCompSeq", loginVo.getErpCoCd());

                    // budgetParam.put( "amt", exCodeCardVO.getAmtMdAmount() );
                    budgetParam.put("amt", budgetVo.getDracctAmt());
                    budgetParam.put("budgetYm", budgetVo.getBudgetYm());
                    budgetParam.put("isApprovalEditMode", false);
                    budgetParam.put("expendSeq", param.get("expendSeq").toString());
                    budgetParam.put("drcrGbn", "dr");
                    budgetParam.put("compSeq", loginVo.getCompSeq());

                    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                    ExpendVO tmepExpend = new ExpendVO();
                    tmepExpend.setExpendSeq((String) param.get("expendSeq"));
                    tmepExpend = userService.ExUserExpendInfoSelect(tmepExpend);

                    if (!expendVo.getExpendStatCode().equals(commonCode.EMPTYSTR) && !expendVo.getExpendStatCode().equals("999") && !expendVo.getExpendStatCode().equals("100") && !expendVo.getErpSendYN().equals(commonCode.EMPTYYES)) {
                        budgetParam.put("isApprovalEditMode", true);
                    }

                    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                    if (tmepExpend.getErpiuBudgetVer() == null || tmepExpend.getErpiuBudgetVer().equals("")) {
                        budgetService.ExInterfaceBudgetInfoCheck(budgetParam, conVo);
                    }
                    /* 2020.05.08 이준성 ERPiU 예산정보 필수입력 설정에 대한 사용/미사용 여부 체크 */
                    else if (((param.get("budgetUseYn").equals("0")|| param.get("budgetUseYn").equals("2") || param.get("budgetUseYn").equals("4") ) &&  ( budgetVo.getCdBgLevel() == null || budgetVo.getCdBgLevel().equals("") )) && (budgetVo.getBudgetCode() == null || budgetVo.getBudgetCode().equals(""))) {
                      budgetService.ExInterfaceBudgetInfoCheck(budgetParam, conVo);
                    } else {
                        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                        // ERPiU 상위과목 예산통제 기능
                        budgetParam.put("cdBgLevel", budgetVo.getCdBgLevel());
                        budgetParam.put("ynControl", budgetVo.getYnControl());
                        budgetParam.put("tpControl", budgetVo.getTpControl());
                        budgetService.ExInterfaceBudgetInfoCheck2(budgetParam, conVo);
                    }
                }
                /* list */
                ExExpendListVO listVo = new ExExpendListVO(); /* 지출결의 항목 */
                listVo.setExpendSeq((String) param.get("expendSeq"));
                listVo.setAuthDate(exCodeCardVO.getAuthDate());
                listVo.setNote(exCodeCardVO.getNote());
                listVo.setAmt(exCodeCardVO.getRequestAmount());
                /* list - 금액 재계산 처리 */
                if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.BIZBOXA)) {
                    listVo.setTaxAmt(exCodeCardVO.getVatMdAmount());
                    listVo.setSubTaxAmt(exCodeCardVO.getVatMdAmount());
                    listVo.setStdAmt(exCodeCardVO.getAmtMdAmount());
                    listVo.setSubStdAmt(exCodeCardVO.getAmtMdAmount());
                } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                    switch (authVo.getVatTypeCode()) {
                        case "":
                            listVo.setTaxAmt(commonCode.EMPTYSEQ);
                            listVo.setSubTaxAmt(commonCode.EMPTYSEQ);
                            listVo.setStdAmt(exCodeCardVO.getRequestAmount());
                            listVo.setSubStdAmt(exCodeCardVO.getRequestAmount());
                            break;
                        /* 부가세는 없고, 세액만 있는 프로세스 */
                        case "24":
                            /* 부가세가 존재한다면 ? */
                            if ( Double.parseDouble(exCodeCardVO.getVatMdAmount()) > 0 || Double.parseDouble(exCodeCardVO.getVatMdAmount()) != 0 ) {
                                /* 부가세 > 0 / 세액 > 부가세 */
                                listVo.setTaxAmt(commonCode.EMPTYSEQ);
                                listVo.setSubTaxAmt(exCodeCardVO.getVatMdAmount());
                                /* 공급가액 > 공급대가 / 과세표준액 > 공급대가 - 세액 */
                                listVo.setStdAmt(exCodeCardVO.getRequestAmount());
                                listVo.setSubStdAmt(exCodeCardVO.getAmtMdAmount());
                                /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                                double serAmt, subStdAmt;
                                serAmt = Double.parseDouble(exCodeCardVO.getSerAmount());
                                subStdAmt = Double.parseDouble(listVo.getSubStdAmt());
                                subStdAmt = subStdAmt + serAmt;
                                listVo.setSubStdAmt(Double.toString(subStdAmt));

                            }
                            /* 부가세가 존재하지 않는다면 ? */
                            else {
                                double reqAmt, subTaxAmt, subStdAmt;
                                reqAmt = Double.parseDouble(exCodeCardVO.getRequestAmount());
                                /* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
                                /* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
                                subTaxAmt = Math.floor(reqAmt / 11);
                                listVo.setTaxAmt(commonCode.EMPTYSEQ);
                                listVo.setSubTaxAmt(String.valueOf(subTaxAmt));
                                subStdAmt = reqAmt - subTaxAmt;
                                listVo.setStdAmt(String.valueOf(reqAmt));
                                listVo.setSubStdAmt(String.valueOf(subStdAmt));
                            }
                            break;
                        /* 부가세도 없고, 세액도 없는 프로세스 */
                        case "22":
                        case "23":
                            listVo.setTaxAmt(commonCode.EMPTYSEQ);
                            listVo.setSubTaxAmt(commonCode.EMPTYSEQ);
                            listVo.setStdAmt(exCodeCardVO.getRequestAmount());
                            listVo.setSubStdAmt(exCodeCardVO.getRequestAmount());
                            break;
                        default:
                            /* 부가세가 존재한다면 ? */
                            if ( Double.parseDouble(exCodeCardVO.getVatMdAmount()) > 0 || Double.parseDouble(exCodeCardVO.getVatMdAmount()) != 0 ) {
                                listVo.setTaxAmt(exCodeCardVO.getVatMdAmount());
                                listVo.setSubTaxAmt(exCodeCardVO.getVatMdAmount());
                                listVo.setStdAmt(exCodeCardVO.getAmtMdAmount());
                                listVo.setSubStdAmt(exCodeCardVO.getAmtMdAmount());
                                /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                                double serAmt, stdAmt, subStdAmt;
                                serAmt = Double.parseDouble(exCodeCardVO.getSerAmount());
                                stdAmt = Double.parseDouble(listVo.getStdAmt());
                                subStdAmt = Double.parseDouble(listVo.getSubStdAmt());
                                stdAmt = stdAmt + serAmt;
                                subStdAmt = subStdAmt + serAmt;
                                listVo.setStdAmt(Double.toString(stdAmt));
                                listVo.setSubStdAmt(Double.toString(subStdAmt));
                            } else {
                                double reqAmt, subTaxAmt, subStdAmt;
                                /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                                reqAmt = Double.parseDouble(exCodeCardVO.getRequestAmount()) - Double.parseDouble(exCodeCardVO.getSerAmount());
                                /* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
                                /* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
                                subTaxAmt = Math.floor(reqAmt / 11);
                                listVo.setTaxAmt(String.valueOf(subTaxAmt));
                                listVo.setSubTaxAmt(String.valueOf(subTaxAmt));
                                subStdAmt = reqAmt - subTaxAmt + Double.parseDouble(exCodeCardVO.getSerAmount());
                                listVo.setStdAmt(String.valueOf(subStdAmt));
                                listVo.setSubStdAmt(String.valueOf(subStdAmt));

                            }
                            break;
                    }
                } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
                    switch (authVo.getVatTypeCode()) {
                        case "":
                            listVo.setTaxAmt(commonCode.EMPTYSEQ);
                            listVo.setSubTaxAmt(commonCode.EMPTYSEQ);
                            listVo.setStdAmt(exCodeCardVO.getRequestAmount());
                            listVo.setSubStdAmt(exCodeCardVO.getRequestAmount());
                            break;
                        /* 부가세는 없고, 세액만 있는 프로세스 */
                        case "22":
                        case "50":
                            /* 부가세가 존재한다면 ? */
                            if (Double.parseDouble(exCodeCardVO.getVatMdAmount()) > 0 || Double.parseDouble(exCodeCardVO.getVatMdAmount()) != 0 ) {
                                /* 부가세 > 0 / 세액 > 부가세 */
                                listVo.setTaxAmt(commonCode.EMPTYSEQ);
                                listVo.setSubTaxAmt(exCodeCardVO.getVatMdAmount());
                                /* 공급가액 > 공급대가 / 과세표준액 > 공급대가 - 세액 */
                                listVo.setStdAmt(exCodeCardVO.getRequestAmount());
                                listVo.setSubStdAmt(exCodeCardVO.getAmtMdAmount());
                                /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                                double serAmt, subStdAmt;
                                serAmt = Double.parseDouble(exCodeCardVO.getSerAmount());
                                subStdAmt = Double.parseDouble(listVo.getSubStdAmt());
                                subStdAmt = subStdAmt + serAmt;
                                listVo.setSubStdAmt(Double.toString(subStdAmt));
                            }
                            /* 부가세가 존재하지 않는다면 ? */
                            else {
                                double reqAmt, subTaxAmt, subStdAmt;
                                reqAmt = Double.parseDouble(exCodeCardVO.getRequestAmount()) - Double.parseDouble(exCodeCardVO.getSerAmount());
                                /* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
                                /* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
                                subTaxAmt = Math.floor(reqAmt / 11);
                                listVo.setTaxAmt(commonCode.EMPTYSEQ);
                                listVo.setSubTaxAmt(String.valueOf(subTaxAmt));
                                subStdAmt = reqAmt - subTaxAmt + Double.parseDouble(exCodeCardVO.getSerAmount());
                                listVo.setStdAmt(String.valueOf(reqAmt));
                                listVo.setSubStdAmt(String.valueOf(subStdAmt));
                            }
                            break;
                        /* 부가세도 없고, 세액도 없는 프로세스 */
                        case "23":
                        case "25":
                        case "26":
                        case "37":
                        case "39":
                        case "60":
                        case "99":
                            listVo.setTaxAmt(commonCode.EMPTYSEQ);
                            listVo.setSubTaxAmt(commonCode.EMPTYSEQ);
                            listVo.setStdAmt(exCodeCardVO.getRequestAmount());
                            listVo.setSubStdAmt(exCodeCardVO.getRequestAmount());
                            break;
                        default:
                            /* 부가세가 존재한다면 ? */
                            if ( Double.parseDouble(exCodeCardVO.getVatMdAmount()) > 0 || Double.parseDouble(exCodeCardVO.getVatMdAmount()) != 0) {
                                listVo.setTaxAmt(exCodeCardVO.getVatMdAmount());
                                listVo.setSubTaxAmt(exCodeCardVO.getVatMdAmount());
                                listVo.setStdAmt(exCodeCardVO.getAmtMdAmount());
                                listVo.setSubStdAmt(exCodeCardVO.getAmtMdAmount());
                                /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                                double serAmt, stdAmt, subStdAmt;
                                serAmt = Double.parseDouble(exCodeCardVO.getSerAmount());
                                stdAmt = Double.parseDouble(listVo.getStdAmt());
                                subStdAmt = Double.parseDouble(listVo.getSubStdAmt());
                                stdAmt = stdAmt + serAmt;
                                subStdAmt = subStdAmt + serAmt;
                                listVo.setStdAmt(Double.toString(stdAmt));
                                listVo.setSubStdAmt(Double.toString(subStdAmt));
                            } else {
                                double reqAmt, subTaxAmt, subStdAmt;
                                /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                                reqAmt = Double.parseDouble(exCodeCardVO.getRequestAmount()) - Double.parseDouble(exCodeCardVO.getSerAmount());
                                /* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
                                /* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
                                subTaxAmt = Math.floor(reqAmt / 11);
                                listVo.setTaxAmt(String.valueOf(subTaxAmt));
                                listVo.setSubTaxAmt(String.valueOf(subTaxAmt));
                                subStdAmt = reqAmt - subTaxAmt + Double.parseDouble(exCodeCardVO.getSerAmount());
                                listVo.setStdAmt(String.valueOf(subStdAmt));
                                listVo.setSubStdAmt(String.valueOf(subStdAmt));
                            }
                            break;
                    }
                }
                /* listVo 금액 소수점 제거 진행 */
                double tAmt = Double.parseDouble(listVo.getAmt());
                double tStdAmt = Double.parseDouble(listVo.getStdAmt());
                double tTaxAmt = Double.parseDouble(listVo.getTaxAmt());
                double tSubStdAmt = Double.parseDouble(listVo.getSubStdAmt());
                double tSubTaxAmt = Double.parseDouble(listVo.getSubTaxAmt());
                listVo.setAmt(String.valueOf((long) tAmt));
                listVo.setStdAmt(String.valueOf((long) tStdAmt));
                listVo.setTaxAmt(String.valueOf((long) tTaxAmt));
                listVo.setSubStdAmt(String.valueOf((long) tSubStdAmt));
                listVo.setSubTaxAmt(String.valueOf((long) tSubTaxAmt));
                listVo.setInterfaceType("card");
                listVo.setInterfaceMId(exCodeCardVO.getSyncId());
                listParam.put("list", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(listVo)));
                listParam.put("isUseBudget", param.get("isUseBudget"));

                /* 외화정보 담기 */
                ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();
                foreignCurrencyVO.setErpCompSeq(loginVo.getErpCoCd());
                foreignCurrencyVO.setDrAcctCode(summaryVo.getDrAcctCode());
                // 대변계정의 경우 증빙유형설정의 대변대체계정 값이 있는 경우 대변대체계정값을 우선시 하여 조회한다.
                foreignCurrencyVO.setCrAcctCode((authVo.getCrAcctCode() == commonCode.EMPTYSTR) ? summaryVo.getCrAcctCode() : authVo.getCrAcctCode());
                ResultVO resultForeignCurrencyVo = listService.CheckForeignCurrencyAcctCode(foreignCurrencyVO, conVo);

                // 외화계정일 경우에만
                if (Integer.valueOf(CommonConvert.CommonGetSeq(resultForeignCurrencyVo.getaData().get("resultAcctCount"))) > 0) {
                    foreignCurrencyVO.setExchangeUnitName(exCodeCardVO.getGeoraeGukga());
                    foreignCurrencyVO.setExchangeRate(exCodeCardVO.getAquiRate());
                    foreignCurrencyVO.setForeignCurrencyAmount(exCodeCardVO.getForAmount());
                    foreignCurrencyVO.setForeignAcctYN(commonCode.EMPTYYES);

                    ExExpendMngVO mngParam = new ExExpendMngVO();
                    mngParam.setErpCompSeq(foreignCurrencyVO.getErpCompSeq());
                    mngParam.setSearchStr(foreignCurrencyVO.getExchangeUnitName());
                    List<ExExpendMngVO> result = new ArrayList<ExExpendMngVO>();

                    // 환종코드 조회(ERPiU만 조회. iCUBE는 CMS 데이터에서 거래국가 코드를 넘겨주고 있지 않음.(KRW로 하드코딩되어 있음))
                    if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU) && !mngParam.getSearchStr().equals("")) {
                        result = exUserMngServiceUDAO.ExCodeMngDB24ListInfoSelect(mngParam, conVo);
                        foreignCurrencyVO.setExchangeUnitCode(result.get(0).getCtdCode());
                    } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                        foreignCurrencyVO.setExchangeUnitCode(commonCode.EMPTYSTR);
                        foreignCurrencyVO.setExchangeUnitName(commonCode.EMPTYSTR);
                    }
                }

                listParam.put("foreignCurrency", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(foreignCurrencyVO)));

                resultVo = listService.ExListInfoMake(loginVo, listParam, conVo);
                if (resultVo.getCode().equals(commonCode.FAIL)) {
                    throw new Exception(BizboxAMessage.getMessage("TX000009290", "분개생성에 실패하였습니다"));
                } else {
                    /* 결재 중 수정 여부 확인 */
                    if (!expendVo.getExpendStatCode().equals(commonCode.EMPTYSTR) && !expendVo.getExpendStatCode().equals("999") && !expendVo.getExpendStatCode().equals("100") && !expendVo.getErpSendYN().equals(commonCode.EMPTYYES)) {
                        /*
                         * 결재 중 수정 로직 진행 1. 생성 된 카드 정보 전송여부 Y로 업데이트 2. ERPiU인 경우 생성된 항목의 차변 분개에 row_id 생성
                         */
                        Map<String, Object> syncUpdate = new HashMap<String, Object>();
                        syncUpdate.put("interfaceMId", listVo.getInterfaceMId());
                        syncUpdate.put("sendYN", commonCode.EMPTYYES);
                        syncUpdate.put("expendSeq", listVo.getExpendSeq());
                        syncUpdate.put("listSeq", resultVo.getListSeq());
                        dao.ExUserCardStateInfoUpdate(syncUpdate);
                        if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
                            // ERPiU 예산넣기(임시데이터 생성)
                            Map<String, Object> budgetParam = new HashMap<String, Object>();
                            budgetParam.put("docSeq", expendVo.getDocSeq());
                            budgetParam.put("expendSeq", expendVo.getExpendSeq());
                            budgetParam.put("newListSeq", resultVo.getListSeq());
                            budgetService.ExInterLockERPiURowInsert(budgetParam);
                        }
                    }
                    if (isSlipMode) {
                        /*
                         * 분개단위 입력 시 항목에 금액 수정 진행 기존 항목의 금액 + 신규 추가되는 금액으로 변경
                         */
                        Map<String, Object> amtMap = new HashMap<String, Object>();
                        Map<String, Object> listAmtMap = new HashMap<String, Object>();
                        ExExpendListVO tListVo = new ExExpendListVO();
                        tListVo.setExpendSeq(listVo.getExpendSeq());
                        tListVo.setListSeq("1");
                        listAmtMap = listService.ExListAmtSelect(tListVo);
                        /* 기초값 설정 : 기존 항목의 금액으로 설정한다 */
                        BigDecimal amt = new BigDecimal(listAmtMap.get("amt").toString());
                        BigDecimal stdAmt = new BigDecimal(listAmtMap.get("stdAmt").toString());
                        BigDecimal taxAmt = new BigDecimal(listAmtMap.get("taxAmt").toString());
                        BigDecimal subStdAmt = new BigDecimal(listAmtMap.get("subStdAmt").toString());
                        BigDecimal subTaxAmt = new BigDecimal(listAmtMap.get("subTaxAmt").toString());
                        /* 추가된 항목의 금액을 더한다. */
                        amtMap.put("amt", amt.add(new BigDecimal(listVo.getAmt())));
                        amtMap.put("stdAmt", stdAmt.add(new BigDecimal(listVo.getStdAmt())));
                        amtMap.put("taxAmt", taxAmt.add(new BigDecimal(listVo.getTaxAmt())));
                        amtMap.put("subStdAmt", subStdAmt.add(new BigDecimal(listVo.getSubStdAmt())));
                        amtMap.put("subTaxAmt", subTaxAmt.add(new BigDecimal(listVo.getSubTaxAmt())));
                        amtMap.put("expendSeq", listVo.getExpendSeq());
                        amtMap.put("listSeq", "1");
                        listService.ExListAmtEdit(amtMap);
                    }
                }
                resultVo.setExpendSeq(listVo.getExpendSeq());
            }
        } catch (BudgetAmtOverException e) {
            throw e;
        } catch (Exception e) {
            throw e;
        }
        cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + resultVo.toString());
        cmLog.CommonSetInfo("- [EX] ExExpendCardService - ExCardInfoMake");
        return resultVo;
    }

    private String GetCheckBudgetAMT(String erpType, ExCodeAuthVO authType, ExCodeCardVO cardVo) {

        String returnAmt = "0";

        if (erpType.equals(commonCode.BIZBOXA)) {
            returnAmt = cardVo.getAmtMdAmount();
        } else if (erpType.equals(commonCode.ICUBE)) {
            switch (authType.getVatTypeCode()) {
                case "":
                    returnAmt = cardVo.getRequestAmount();
                    break;
                /* 부가세는 없고, 세액만 있는 프로세스 */
                case "24":
                    /* 부가세가 존재한다면 ? */
                    if (Double.parseDouble(cardVo.getVatMdAmount()) > 0) {
                        returnAmt = cardVo.getRequestAmount();
                    }
                    /* 부가세가 존재하지 않는다면 ? */
                    else {
                        double reqAmt, subTaxAmt, subStdAmt;
                        reqAmt = Double.parseDouble(cardVo.getRequestAmount());
                        /* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
                        /* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
                        subTaxAmt = Math.floor(reqAmt / 11);
                        subStdAmt = reqAmt - subTaxAmt;

                        returnAmt = String.valueOf(subStdAmt);
                    }
                    break;
                /* 부가세도 없고, 세액도 없는 프로세스 */
                case "22":
                case "23":
                    returnAmt = cardVo.getRequestAmount();
                    break;
                default:
                    /* 부가세가 존재한다면 ? */
                    if (Double.parseDouble(cardVo.getVatMdAmount()) > 0) {

                        /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                        double serAmt, stdAmt, subStdAmt;
                        serAmt = Double.parseDouble(cardVo.getSerAmount());
                        stdAmt = Double.parseDouble(cardVo.getAmtMdAmount());
                        stdAmt = stdAmt + serAmt;

                        returnAmt = Double.toString(stdAmt);
                    } else {
                        double reqAmt, subTaxAmt, subStdAmt;
                        /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                        reqAmt = Double.parseDouble(cardVo.getRequestAmount()) - Double.parseDouble(cardVo.getSerAmount());
                        /* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
                        /* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
                        subTaxAmt = Math.floor(reqAmt / 11);
                        subStdAmt = reqAmt - subTaxAmt + Double.parseDouble(cardVo.getSerAmount());

                        returnAmt = String.valueOf(subStdAmt);
                    }
                    break;
            }
        } else if (erpType.equals(commonCode.ERPIU)) {
            switch (authType.getVatTypeCode()) {
                case "":
                    returnAmt = cardVo.getRequestAmount();
                    break;
                /* 부가세는 없고, 세액만 있는 프로세스 */
                case "22":
                case "50":
                    /* 부가세가 존재한다면 ? */
                    if (Double.parseDouble(cardVo.getVatMdAmount()) > 0) {
                        /* 부가세 > 0 / 세액 > 부가세 */
                        returnAmt = cardVo.getRequestAmount();
                    }
                    /* 부가세가 존재하지 않는다면 ? */
                    else {
                        double reqAmt, subTaxAmt, subStdAmt;
                        reqAmt = Double.parseDouble(cardVo.getRequestAmount()) - Double.parseDouble(cardVo.getSerAmount());
                        /* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
                        /* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
                        subTaxAmt = Math.floor(reqAmt / 11);
                        subStdAmt = reqAmt - subTaxAmt + Double.parseDouble(cardVo.getSerAmount());

                        returnAmt = String.valueOf(subStdAmt);

                    }
                    break;
                /* 부가세도 없고, 세액도 없는 프로세스 */
                case "23":
                case "25":
                case "26":
                case "37":
                case "39":
                case "60":
                case "99":
                    returnAmt = cardVo.getRequestAmount();
                    break;
                default:
                    /* 부가세가 존재한다면 ? */
                    if (Double.parseDouble(cardVo.getVatMdAmount()) > 0) {

                        /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                        double serAmt, stdAmt, subStdAmt;
                        serAmt = Double.parseDouble(cardVo.getSerAmount());
                        stdAmt = Double.parseDouble(cardVo.getAmtMdAmount());
                        stdAmt = stdAmt + serAmt;

                        returnAmt = Double.toString(stdAmt);

                    } else {
                        double reqAmt, subTaxAmt, subStdAmt;
                        /* 봉사료 관련 금액 처리 진행. 2018. 04. 02 - 신재호 */
                        reqAmt = Double.parseDouble(cardVo.getRequestAmount()) - Double.parseDouble(cardVo.getSerAmount());
                        /* 반올림 : Math.round(d) */ /* 올림 : Math.ceil(d) */ /* 버림 : Math.floor(d) */
                        /* 부가세 > 0 / 세액 > 공급대가 / 11 (버림) */
                        subTaxAmt = Math.floor(reqAmt / 11);
                        subStdAmt = reqAmt - subTaxAmt + Double.parseDouble(cardVo.getSerAmount());

                        returnAmt = String.valueOf(subStdAmt);
                    }
                    break;
            }
        }

        return returnAmt;
    }

    /* 지출결의 - 카드 사용내역 지출결의 정보 맵핑 */
    @Override
    public ExCommonResultVO ExExpendCardInfoMapUpdate(Map<String, Object> param, ConnectionVO conVo, LoginVO loginVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] ExExpendCardService - ExExpendCardInfoMapUpdate");
        cmLog.CommonSetInfo("! [EX] ExCodeCardVO cardVo >> " + param.toString());
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            /* 변수 정의 */
            ExCodeOrgVO orgVo = new ExCodeOrgVO(); /* 사용자 */
            ExCodeSummaryVO summaryVo = new ExCodeSummaryVO(); /* 표준적요 */
            ExCodeAuthVO authVo = new ExCodeAuthVO(); /* 증빙유형 */
            ExCodeProjectVO projectVo = new ExCodeProjectVO(); /* 프로젝트 */
            ExCodeBudgetVO budgetVo = new ExCodeBudgetVO(); /* 예산 */
            List<ExCodeCardVO> cardListVo = new ArrayList<ExCodeCardVO>();
            orgVo = (ExCodeOrgVO) ConvertManager.ConvertMapToObject(ConvertManager.ConvertJsonToMap((String) param.get("empInfo")), orgVo);
            summaryVo = (ExCodeSummaryVO) ConvertManager.ConvertMapToObject(ConvertManager.ConvertJsonToMap((String) param.get("summaryInfo")), summaryVo);
            authVo = (ExCodeAuthVO) ConvertManager.ConvertMapToObject(ConvertManager.ConvertJsonToMap((String) param.get("authInfo")), authVo);
            projectVo = (ExCodeProjectVO) ConvertManager.ConvertMapToObject(ConvertManager.ConvertJsonToMap((String) param.get("projectInfo")), projectVo);
            if (param.get("budgetInfo") != null) {
                budgetVo = (ExCodeBudgetVO) ConvertManager.ConvertMapToObject(ConvertManager.ConvertJsonToMap((String) param.get("budgetInfo")), budgetVo);
            }
            for (Map<String, Object> map : ConvertManager.ConvertJsonToListMap((String) param.get("target"))) {
                ExCodeCardVO cardVo = new ExCodeCardVO();
                cardListVo.add((ExCodeCardVO) ConvertManager.ConvertMapToObject(map, cardVo));
            }
            for (ExCodeCardVO exCodeCardVO : cardListVo) {
                /* 사용자 처리 */
                if (orgVo.getSeq() == 0) {
                    cmLog.CommonSetInfo("! [EX] 사용자 정보 신규 생성");
                    orgVo.setCompSeq(loginVo.getCompSeq());
                    orgVo.setCreateSeq(loginVo.getUniqId());
                    orgVo.setModifySeq(loginVo.getUniqId());
                    orgVo = exService.ExExpendEmpInfoInsert(orgVo);
                    exCodeCardVO.setEmpSeq(String.valueOf(orgVo.getSeq()));
                    orgVo.setSeq(0);
                }
                /* 표준적요 처리 */
                if (summaryVo.getSeq() == 0) {
                    cmLog.CommonSetInfo("! [EX] 표준적요 정보 신규 생성");
                    summaryVo.setCompSeq(loginVo.getCompSeq());
                    summaryVo.setCreateSeq(loginVo.getUniqId());
                    summaryVo.setModifySeq(loginVo.getUniqId());
                    summaryVo = exService.ExExpendSummaryInfoInsert(summaryVo);
                    exCodeCardVO.setSummarySeq(String.valueOf(summaryVo.getSeq()));
                    summaryVo.setSeq(0);
                }
                /* 증빙유형 처리 */
                if (authVo.getSeq() == 0) {
                    cmLog.CommonSetInfo("! [EX] 증빙유형 정보 신규 생성");
                    authVo.setCompSeq(loginVo.getCompSeq());
                    authVo.setCreateSeq(loginVo.getUniqId());
                    authVo.setModifySeq(loginVo.getUniqId());
                    authVo.setGroupSeq(loginVo.getGroupSeq());
                    authVo = exService.ExExpendAuthInfoInsert(authVo);
                    exCodeCardVO.setAuthSeq(String.valueOf(authVo.getSeq()));
                    authVo.setSeq(0);
                }
                /* 프로젝트 처리 */
                if (projectVo.getSeq() == 0) {
                    boolean isDeleteProject = false;
                    if (param.get("isDeleteProject") != null) {
                        isDeleteProject = Boolean.parseBoolean(param.get("isDeleteProject").toString());
                    }
                    cmLog.CommonSetInfo("! [EX] 프로젝트 정보 신규 생성");
                    projectVo.setCompSeq(loginVo.getCompSeq());
                    projectVo.setCreateSeq(loginVo.getUniqId());
                    projectVo.setModifySeq(loginVo.getUniqId());
                    /* 카드사용 내역에서 프로젝트 정보 삭제 후 저장 시 */
                    if (!isDeleteProject) {
                        projectVo = exService.ExExpendProjectInfoInsert(projectVo);
                    }
                    exCodeCardVO.setProjectSeq(String.valueOf(projectVo.getSeq()));
                    projectVo.setSeq(0);
                }
                /* 예산 처리 */
                if (budgetVo.getSeq() == 0) {
                    cmLog.CommonSetInfo("! [EX] 예산 정보 신규 생성");
                    budgetVo.setCompSeq(loginVo.getCompSeq());
                    budgetVo.setCreateSeq(loginVo.getUniqId());
                    budgetVo.setModifySeq(loginVo.getUniqId());
                    budgetVo.setBudgetType(conVo.getErpTypeCode());
                    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                    budgetVo = exService.ExExpendBudgetInfoInsert(budgetVo);
                    exCodeCardVO.setBudgetSeq(String.valueOf(budgetVo.getSeq()));
                    budgetVo.setSeq(0);
                }
                /* 적요 처리 */
                exCodeCardVO.setNote((String) param.get("note"));
                cmLog.CommonSetInfo("! [EX] ExCodeCardVO exCodeCardVO >> " + exCodeCardVO.toString());
                /* 카드 사용내역 갱신 */
                resultVo = this.ExExpendCardSubInfoUpdate(exCodeCardVO);
                if (resultVo.getCode().equals(commonCode.FAIL)) {
                    throw new Exception(BizboxAMessage.getMessage("TX000009291", "카드 사용내역 갱신 실패"));
                }
            }
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        cmLog.CommonSetInfo("! [EX] ExCommonResultVO resultVo >> " + resultVo.toString());
        cmLog.CommonSetInfo("- [EX] ExExpendCardService - ExExpendCardInfoMapUpdate");
        return resultVo;
    }

    /* 지출결의 - 카드 사용내역 상세 */
    @Override
    public ExCodeCardVO ExReportCardDetailInfoSelect(ExCodeCardVO cardVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] ExExpendCardService - ExExpendCardInfoSelect");
        cmLog.CommonSetInfo("! [EX] ExCodeCardVO cardVo >> " + cardVo.toString());
        try {
            cardVo = dao.ExReportCardDetailInfoSelect(cardVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        cmLog.CommonSetInfo("! [EX] ExCodeCardVO cardVo >> " + cardVo.toString());
        cmLog.CommonSetInfo("- [EX] ExExpendCardService - ExExpendCardInfoSelect");
        return cardVo;
    }

    /* 지출결의 - 카드 사용내역 상세_취소분 포함 */
    @Override
    public ExCodeCardVO ExReportCardDetailInfoWithCancelInfoSelect(ExCodeCardVO cardVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] ExExpendCardService - ExReportCardDetailInfoWithCancelInfoSelect");
        cmLog.CommonSetInfo("! [EX] ExCodeCardVO cardVo >> " + cardVo.toString());
        try {
            cardVo = dao.ExReportCardDetailInfoWithCancelInfoSelect(cardVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        cmLog.CommonSetInfo("! [EX] ExCodeCardVO cardVo >> " + cardVo.toString());
        cmLog.CommonSetInfo("- [EX] ExExpendCardService - ExReportCardDetailInfoWithCancelInfoSelect");
        return cardVo;
    }

    /* 지출결의 - 카드 사용내역 상세 */
    @Override
    public Map<String, Object> ExExpendCardDetailInfoSelect(ResultVO params, ConnectionVO conVo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] ExExpendCardService - ExExpendCardDetailInfoSelect");
        cmLog.CommonSetInfo("! [EX] ResultVO params >> " + params.toString());
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            result = dao.ExExpendCardDetailInfoSelect(params);
            // 과세유형명 검색결과 추가
            String taxTypeName = "";
            if(conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
        		// vatStat를 먼저 읽어 매칭되는 값이 있을경우 taxTypeName 반환 그렇지 않은 경우 mccCode 사용
        		if(TaxType.findByTaxTypeCode(CommonConvert.CommonGetStr(result.get("vatStat"))).equals("")){
        			taxTypeName = TaxType.findByTaxTypeCode(CommonConvert.CommonGetStr(result.get("mccCode")));
        		}else {
        			taxTypeName = TaxType.findByTaxTypeCode(CommonConvert.CommonGetStr(result.get("vatStat")));
        		}
            }else if(conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
              taxTypeName = TaxiUType.findByTaxTypeCode(CommonConvert.CommonGetStr(result.get("vatStat")));
            }
            result.put("taxTypeName", taxTypeName);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        cmLog.CommonSetInfo("! [EX] Map<String, Object> result >> " + result.toString());
        cmLog.CommonSetInfo("- [EX] ExExpendCardService - ExExpendCardDetailInfoSelect");
        return result;
    }

    /* 지출결의 - 카드 사용내역 지출결의 정보 초기화 */
    @Override
    public ExCommonResultVO ExExpendCardInfoMapReset ( Map<String, Object> param ) throws Exception {
        ExCommonResultVO resultVo = new ExCommonResultVO();
        try {
            for (Map<String, Object> map : ConvertManager.ConvertJsonToListMap((String) param.get("target"))) {
                map = CommonConvert.CommonSetMapCopy(map, CommonConvert.CommonGetEmpInfo());
                dao.ExExpendCardInfoMapReset(map);
            }
        } catch (Exception e) {
            resultVo.setCommonCode(commonCode.FAIL);
            resultVo.setCommonName("카드 사용내역 초기화 오류");
        }
        return resultVo;
    }

    /* 지출결의 - 카드사용내역 - 카드정보 조회 */
    @Override
    public ResultVO ExExpendUserCardInfoSelect(Map<String, Object> param, PaginationInfo paginationInfo) throws Exception {
        cmLog.CommonSetInfo("+ [EX] ExExpendCardService - ExExpendUserCardInfoSelect");
        cmLog.CommonSetInfo("! [EX] Map<String, Object> param " + param.toString());
        ResultVO result = new ResultVO();
        try {
            result.setParams(param);
            result.setaData(dao.ExExpendUserCardInfoSelect(param, paginationInfo));
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        cmLog.CommonSetInfo("! [EX] ResultVO result >> " + result.toString());
        cmLog.CommonSetInfo("- [EX] ExExpendCardService - ExExpendUserCardInfoSelect");
        return result;
    }
}
