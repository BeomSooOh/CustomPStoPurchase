package expend.ex.user.expend;

import static org.junit.Assert.assertTrue;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExConfigOptionVO;
import common.vo.ex.ExExpendVO;
import common.vo.ex.ExOptionVO;
import common.vo.ex.ExpendVO;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.budget.BExBudgetService;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.mng.BExUserMngService;


@Service ( "BExUserService" )
public class BExUserServiceImpl implements BExUserService {

    /* 변수정의 */
    /* 변수정의 - Service */
    @Resource(name = "FExUserServiceA")
    private FExUserService expendA; /* Bizbox Alpha */
    @Resource(name = "FExUserServiceI")
    private FExUserService expendI; /* ERP iCUBE */
    @Resource(name = "FExUserServiceU")
    private FExUserService expendU; /* ERP iU */
    @Resource(name = "FExUserServiceE")
    private FExUserService expendE; /* ERP ETC */
    @Resource(name = "FExUserFileServiceDAO")
    private FExUserFileServiceDAO expendF; /* ERP File */
    @Resource(name = "BExUserMngService") /* 관리항목 서비스 */
    private BExUserMngService mngService;
    @Resource(name = "BExBudgetService") /* 예산 서비스 */
    private BExBudgetService budgetService;
    @Resource(name = "BExAdminConfigService") /* 환경설정 서비스 */
    private BExAdminConfigService configService;
    @Resource(name = "BExUserCodeService") /* 공통 조회 서비스 */
    private BExUserCodeService codeService;
    /* 변수정의 - Common */
    @Resource(name = "CommonLogger")
    private CommonLogger cmLog; /* Log 관리 */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
    @Resource(name = "BExBudgetService")
    private BExBudgetService exBudgetService; /* ERP ETC */
    /* 변수정의 - VO */
    private ConnectionVO conVo = new ConnectionVO();

    /* Pop */
    /* 지출결의 작성 - 초기변수 담기 */
    @Override
    @SuppressWarnings({"unused", "unchecked"})
    public Map<String, Object> ExUserInitExpendSelect(Map<String, Object> params) throws Exception {
        ExConfigOptionVO configVo = new ExConfigOptionVO();
        List<ExOptionVO> configExpendListVo = new ArrayList<ExOptionVO>();
        List<ExConfigOptionVO> configDateListVo = new ArrayList<ExConfigOptionVO>();
        List<ExConfigOptionVO> configLayoutListVo = new ArrayList<ExConfigOptionVO>();
        Map<String, Object> empInfo = new HashMap<String, Object>();
        Map<String, Object> sendParam = new HashMap<String, Object>();
        Map<String, Object> formInfo = new HashMap<String, Object>();
        Map<String, Object> formInfoParam = new HashMap<String, Object>();
        Map<String, Object> optionListInfoParam = new HashMap<String, Object>();
        Map<String, Object> jsonParam = new HashMap<String, Object>();
        Map<String, Object> paramd = new HashMap<String, Object>();
        List<Map<String, Object>> optionListInfo = new ArrayList<Map<String, Object>>();
        Map<String, Object> expendWriter = new HashMap<String, Object>();
        try {
            LoginVO loginVO = CommonConvert.CommonGetEmpVO();
            // 사용자 정보
            empInfo = CommonConvert.CommonGetEmpInfo();
            sendParam.put("empInfo", empInfo);
            // 파라메터 생성
            String[] parameter = new String[] {commonCode.COMPSEQ, commonCode.BIZSEQ, commonCode.DEPTSEQ, commonCode.EMPSEQ, commonCode.LANGCODE, commonCode.USERSE, commonCode.ERPEMPSEQ, commonCode.ERPCOMPSEQ};
            sendParam = CommonConvert.CommonSetMapCopy(empInfo, sendParam, parameter);
            parameter = new String[] {commonCode.DOCID, "formId", "expendId", "docType"};
            sendParam = CommonConvert.CommonSetMapCopy(params, sendParam, parameter);
            // 시스템 정보
            conVo = cmInfo.CommonGetConnectionInfo((String) empInfo.get(commonCode.COMPSEQ));
            // 작성자 정보 가져오기
            // 양식 정보
            parameter = new String[] {commonCode.COMPSEQ, commonCode.BIZSEQ, commonCode.DEPTSEQ, commonCode.EMPSEQ, commonCode.LANGCODE};
            formInfoParam = CommonConvert.CommonSetMapCopy(empInfo, formInfoParam, parameter);
            formInfoParam.put("form_id", params.get("formSeq"));
            formInfoParam.put(commonCode.FORMSEQ, params.get("formSeq"));
            formInfoParam.put("formId", params.get("formSeq"));
            formInfoParam.put("searchFormSeq", params.get("formSeq"));
            formInfoParam.put(commonCode.LANGCODE, empInfo.get(commonCode.LANGCODE));
            formInfoParam.put(commonCode.COMPSEQ, empInfo.get(commonCode.COMPSEQ));
            formInfo = ExExpendGetMasterPopFormInfoReturn(formInfoParam);
            sendParam.put("formInfo", formInfo);
            // 옵션 정보 가져오기
            Map<String, Object> optionParam = new HashMap<String, Object>();
            optionParam.put("comp_seq", empInfo.get(commonCode.COMPSEQ));
            optionParam.put("form_seq", params.get("formSeq"));
            optionParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            configExpendListVo = cmInfo.ExOptionLoadSetting(optionParam);
            for (ExOptionVO item : configExpendListVo) {
                optionListInfo.add(CommonConvert.CommonGetObjectToMap(item));
            }
            // 예산사용여부 확인 params(erp_comp_seq, erpType, loginVo)
            params.put("loginVo", loginVO);
            params.put("erp_comp_seq", conVo.getErpCompSeq());
            params.put("erpType", conVo.getErpTypeCode());
            Map<String, Object> mResult = exBudgetService.ExBudgetUseInfoSelect(params);
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                if (CommonConvert.CommonGetStr(mResult.get("budgetUse")).equals(commonCode.EMPTYYES)) {
                    sendParam.put("iCubeBudgetType", CommonConvert.CommonGetStr(mResult.get("budgetUnit")));
                } else {
                    sendParam.put("iCubeBudgetType", "NOTUSE");
                }
            } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
            	// do nothing
            } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.BIZBOXA)) {
                sendParam.put("iCubeBudgetType", "NOTUSE");
            }
            // ERP 연동코드
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            // ERP 예산구분
            sendParam.put("ifBudget", cmInfo.UtilIfBudgetInfoSelect(formInfo));
            // 반환값 처리
            jsonParam.put("empInfo", CommonConvert.CommonGetMapToJSONStr(empInfo));
            jsonParam.put("formInfo", CommonConvert.CommonGetMapToJSONStr(formInfo));
            jsonParam.put("optionListInfo", CommonConvert.CommonGetListMapToJson(optionListInfo));
            jsonParam.put("gridList", CommonConvert.CommonGetListMapToJson((List<Map<String, Object>>) sendParam.get("gridList")));
            jsonParam.put("gridSlip", CommonConvert.CommonGetListMapToJson((List<Map<String, Object>>) sendParam.get("gridSlip")));
            jsonParam.put("gridMng", CommonConvert.CommonGetListMapToJson((List<Map<String, Object>>) sendParam.get("gridMng")));
            sendParam.put("jsonParam", jsonParam);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return sendParam;
    }
    /*
     * ------------------------------------------------------------------------- PRIVATE -------------------------------------------------------------------------
     */

    // Pop - ExExpendMasterPop 반환값 처리 - 전자결재 타입 조회
    private Map<String, Object> ExExpendGetMasterPopFormInfoReturn(Map<String, Object> params) throws Exception {
        /* 양식정보 조회 */
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String eaType = cmInfo.CommonGetCompEaTypeInfo((String) params.get(commonCode.COMPSEQ));
        switch (eaType) {
            case commonCode.EA: /* 비영리 전자결자 */
                throw new Exception("비영리 전자결재 정보를 가져올 수 없습니다. 프로세스가 없습니다.");
                // break;
            case commonCode.EAP: /* 영리 전자결재 */
                resultMap = cmInfo.CommonGetEapFormDetailInfo(params);
                break;
            case commonCode.EAA: /* 통합 전자결재 */
                break;
            default:
                throw new Exception("전자결재 구분이 정의되지 않았습니다.");
        }
        return resultMap;
    }

    @SuppressWarnings("unused")
    private String ExUserErpCodeInfoSelect(Map<String, Object> params) throws Exception {
        String retValue = commonCode.EMPTYSTR;
        retValue = expendA.ExUserErpCodeInfoSelect(params);
        return retValue;
    }

    /*
     * ------------------------------------------------------------------------- ----------------------------
     */
    /* Pop - ExExpendMasterPop 반환값 처리 */
    @Override
    public Map<String, Object> ExUserMasterPopReturn(Map<String, Object> params) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            /* 변수정의 - VO */
            /* ExConfigOptionVO configVo = new ExConfigOptionVO(); */
            /* 변수정의 - Map */
            Map<String, Object> empInfo = new HashMap<String, Object>();
            /* 사용자 정보 */
            empInfo = CommonConvert.CommonGetEmpInfo();
            result.put("empInfo", empInfo);
            /* 파리미터 처리 */
            result = CommonConvert.CommonSetMapCopy(empInfo, result);
            result = CommonConvert.CommonSetMapCopy(params, result);
            /* 시스템 정보 */
            /*
             * conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(empInfo .get(commonCode.COMPSEQ)));
             */
            /*
             * result.put("eaType", cmInfo.CommonGetEaTypeInfo(CommonConvert.CommonGetStr(empInfo.get (commonCode.COMPSEQ))));
             */
            /*
             * result.put(commonCode.IFSYSTEM, CommonConvert.CommonGetStr(conVo.getErp_type_code()));
             */
            /* 양식정보 조회 */
            /* result = ExExpendGetMasterPopFormInfoReturn(result); */
            /* 연동시스템별 추가 반환 설정 */
            /*
             * result = CommonConvert.CommonSetMapCopy(ExExpendGetMasterPopIfSystemReturn( CommonConvert.CommonGetStr(conVo.getErp_type_code())), result);
             */
            /* 옵션정보 조회 */
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }

    /* Pop - ExExpendMasterPop 반환값 처리 - 연동 시스템별 별도 처리 */
    @SuppressWarnings("unused")
    private Map<String, Object> ExExpendGetMasterPopIfSystemReturn(String erpTypeCode) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        /* 연동시스템별 추가 반환 설정 */
        switch (CommonConvert.CommonGetStr(erpTypeCode)) {
            case commonCode.ICUBE:
                result = expendI.ExpendPopReturnInfo(null);
                break;
            case commonCode.ERPIU:
                result = expendU.ExpendPopReturnInfo(null);
                break;
            case commonCode.ETC:
                result = expendE.ExpendPopReturnInfo(null);
                break;
            case commonCode.BIZBOXA:
                result = expendA.ExpendPopReturnInfo(null);
                break;
            default:
                throw new Exception("연도시스템 구분이 정의되지 않았습니다.");
        }
        return result;
    }
    /*
     * ------------------------------------------------------------------------- ----------------------------
     */
    /*
     * ------------------------------------------------------------------------- ----------------------------
     */

    /* Biz */
    /* Biz - 지출결의 생성 */
    @Override
    public ExpendVO ExUserExpendInfoInsert(ExpendVO expendVo) throws Exception {
        ExpendVO result = new ExpendVO();
        try {
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            expendVo.setCreateSeq(loginVo.getUniqId());
            expendVo.setModifySeq(loginVo.getUniqId());
            /* ERP 연결정보 조회 */
            // conVo = cmInfo.CommonGetConnectionInfo(expendVo.getComp_seq());
            /* ERP 회사 코드 확인 */
            expendVo.setErpCompSeq(loginVo.getErpCoCd());
            /* 그룹 시퀀스 */
            expendVo.setGroupSeq(loginVo.getGroupSeq());
            // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
            result = expendA.ExUserExpendInfoInsert(expendVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }

    /* Biz - 지출결의 삭제 */
    @Override
    public ResultVO ExUserExpendInfoDelete(ExpendVO expendVo) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result = expendA.ExUserExpendInfoDelete(expendVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }

    /* Biz - 지출결의 수정 */
    @Override
    public ResultVO ExUserExpendInfoUpdate(ExpendVO expendVo) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result = expendA.ExUserExpendInfoUpdate(expendVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }

    /* Biz - 지출결의 조회 */
    @Override
    public ExpendVO ExUserExpendInfoSelect(ExpendVO expendVo) throws Exception {
        ExpendVO result = new ExpendVO();
        try {
            // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
            result = expendA.ExUserExpendInfoSelect(expendVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }

    /* Biz - 지출결의 오류체크 */
    @Override
    public ResultVO ExUserExpendErrorInfoSelect(ExpendVO expendVo) throws Exception {
        ResultVO result = new ResultVO();
        try {
            result = expendA.ExUserExpendInfoErrorCheck(expendVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }

    @Override
    public ResultVO ExUserExpendInterlockHtmlCode(Map<String, Object> params) throws Exception {
        // TODO Auto-generated method stub
        //return expendF.ReadHtmlCodeForEx(params);
    	return expendF.ReadHtmlCodeForEx();
    }

    /*
     * 항목이 많이 있는 경우에는 오류체크가 너무 느림 개선 진행 필요 현재는 쿼리 조회가 아닌 자바에서 반복문으로 돌면서 확인 하기 때문에 느린것으로 예상됨 2017. 05. 11 신재호 작성
     */
    @Override
    public List<ExCommonResultVO> ExUserExpendErrorInfoList(ExExpendVO expendVo, Map<String, Object> param) throws Exception {
        // 반환 변수
        List<ExCommonResultVO> resultVO = new ArrayList<ExCommonResultVO>();
        // 관리항목 누락 변수
        List<ExCommonResultVO> resultMng = new ArrayList<ExCommonResultVO>();
        // 예산 초과 변수
        List<ExCommonResultVO> resultBudget = new ArrayList<ExCommonResultVO>();
        // 차,대변 및 항목 금액 일치 여부 확인 변수
        List<ExCommonResultVO> resultAmtChk = new ArrayList<ExCommonResultVO>();
        // 증빙일자 마감일 유효성 체크 변수
        List<ExCommonResultVO> authDateChk = new ArrayList<ExCommonResultVO>();

        ExpendVO tExpendVo = new ExpendVO();
        tExpendVo.setExpendSeq(expendVo.getExpendSeq());
        tExpendVo = expendA.ExUserExpendInfoSelect(tExpendVo);
        // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
        expendVo.setErpiuBudgetVer(tExpendVo.getErpiuBudgetVer());
        expendVo.setExpendStatCode(tExpendVo.getExpendStatCode());
        expendVo.setExpendDate(tExpendVo.getExpendDate());
        try {
            ResultVO expendOption = new ResultVO();

            /**
             * 증빙일자 마감일 유효성 확인
             */
            authDateChk = expendA.ExAuthDateErrorInfoSelect(param);
            for (ExCommonResultVO authDateError : authDateChk) {
                if (authDateError.getValidateStat().equals("false")) {
                    authDateError.setError("마감 기간에 포함된 유효하지 않은 증빙일자가 등록되어 있습니다. 관리자에게 문의해주세요.");
                    resultVO.add(authDateError);
                }
            }

            /**
             * 예산 사용 여부 확인
             */
            param.put("optionCode", "003301");
            expendOption = configService.ExAdminConfigOptionSelect(param);
            if (expendOption != null && expendOption.getAaData().size() > 0 && Boolean.parseBoolean(param.get("isBudgetCheck").toString())) {
                if (CommonConvert.CommonGetStr(expendOption.getAaData().get(0).get("set_value")).equals(commonCode.EMPTYYES)) {
                    // 예산 초과 여부 조회
                    resultBudget = budgetService.ExBudgetErrorInfoSelect2(expendVo);
                    for (ExCommonResultVO budgetError : resultBudget) {
                        if (budgetError.getValidateStat().equals("false")) {
                            resultVO.add(budgetError);
                        }
                    }
                }
            }
            /**
             * 항목 및 분개 금액 확인 설정
             */
            param.put("optionCode", "001001");
            expendOption = configService.ExAdminConfigOptionSelect(param);
            if (expendOption == null || expendOption.getAaData().size() == 0 || expendOption.getAaData().get(0).get("set_value").toString().indexOf("L") > -1) {
                /*
                 * 항목단위 입력인 경우에는 아래과 같은 로직으로 체크를 진행한다. 1. 차/대변 금액 일치 여부 확인. 2. 분개 총 금액과 항목 금액의 일치 여부 확인.
                 */
                resultAmtChk = budgetService.ExExpendSlipAmtChkSelect(param);
            } else {
                /*
                 * 분개단위 입력인 경우에는 아래와 같은 로직으로 체크를 진행한다. 1. 차/대변 금액 일치 여부 확인.
                 */
                resultAmtChk = budgetService.ExExpendSlipAmtChkSelectSlipMode(param);
            }
            if (resultAmtChk != null && resultAmtChk.size() > 0) {
                resultVO.addAll(resultAmtChk);
            }
            /**
             * 관리항목 필수입력 확인 설정
             */
            param.put("optionCode", "003004");
            expendOption = configService.ExAdminConfigOptionSelect(param);
            if (expendOption != null && expendOption.getAaData().size() > 0) {
                if (CommonConvert.CommonGetStr(expendOption.getAaData().get(0).get("set_value")).equals(commonCode.EMPTYYES)) {
                    // 관리항목 누락 여부 조회
                    resultVO.addAll(ExMngErrorInfoCheck(expendVo));
                }
            } else { // 기본옵션으로 사용중인 경우
                resultVO.addAll(ExMngErrorInfoCheck(expendVo));
            }
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return resultVO;
    }

    // 관리항목 누락 여부 체크
    @SuppressWarnings("unused")
    private List<ExCommonResultVO> ExMngErrorInfoCheck(ExExpendVO expendVo) throws Exception {
        List<ExCommonResultVO> result = new ArrayList<ExCommonResultVO>();

        List<ExCommonResultVO> resultMng = mngService.ExMngErrorInfoSelect(expendVo);

        for (ExCommonResultVO mngError : resultMng) {
            if (mngError.getValidateStat().equals("false")) {
                if (mngError.getMngCode().equals("C15")) { // 관리항목 C15(거래계좌번호) 예외처리(거래처계좌번호는 코드값이 없기 때문에 명만 체크한다)
                    if (mngError.getCtdName().replace("/", "").trim().equals("")) {
                        mngError.setError("관리항목이 누락되었습니다.");
                        result.add(mngError);
                    }
                } else {
                    mngError.setError("관리항목이 누락되었습니다.");
                    result.add(mngError);
                }
            }
        }

        return result;
    }

    @Override
    public Map<String, Object> ExUserExpendLoadInfo(ExpendVO expendVo) throws Exception {
        Map<String, Object> result = new HashMap<String, Object>();
        // 기본 지출결의 정보
        try {
            // 변수 정의
            ExpendVO resultExpendVo = new ExpendVO();
            ExCodeOrgVO userOrgVo = new ExCodeOrgVO();
            ExCodeOrgVO writeOrgVo = new ExCodeOrgVO();
            ExCodeCardVO cardVO = new ExCodeCardVO();
            ExCodeProjectVO projectVO = new ExCodeProjectVO();
            ExCodePartnerVO partnerVO = new ExCodePartnerVO();

            // 지출결의 정보 조회
            resultExpendVo = this.ExUserExpendInfoSelect(expendVo);
            // 사용자 정보 조회
            userOrgVo.setSeq(resultExpendVo.getEmpSeq());
            userOrgVo.setGroupSeq(expendVo.getGroupSeq());
            userOrgVo = codeService.ExExpendEmpInfoSelect(userOrgVo);
            if (userOrgVo == null) {
                userOrgVo = new ExCodeOrgVO();
            }
            // 작성자 정보 조회
            writeOrgVo.setSeq(resultExpendVo.getWriteSeq());
            writeOrgVo.setGroupSeq(resultExpendVo.getGroupSeq());
            writeOrgVo = codeService.ExExpendEmpInfoSelect(writeOrgVo);
            if (writeOrgVo == null) {
                writeOrgVo = new ExCodeOrgVO();
            }
            // 프로젝트 정보 조회
            projectVO.setSeq(resultExpendVo.getProjectSeq());
            projectVO.setGroupSeq(resultExpendVo.getGroupSeq());
            projectVO = codeService.ExExpendProjectInfoSelect(projectVO);
            if (projectVO == null) {
                projectVO = new ExCodeProjectVO();
            }
            // 거래처 정보 조회
            partnerVO.setSeq(resultExpendVo.getPartnerSeq());
            partnerVO.setGroupSeq(resultExpendVo.getGroupSeq());
            partnerVO = codeService.ExExpendPartnerInfoSelect(partnerVO);
            if (partnerVO == null) {
                partnerVO = new ExCodePartnerVO();
            }
            // 카드 정보 조회
            cardVO.setSeq(resultExpendVo.getCardSeq());
            cardVO.setGroupSeq(resultExpendVo.getGroupSeq());
            cardVO = codeService.ExExpendCardInfoSelect(cardVO);
            if (cardVO == null) {
                cardVO = new ExCodeCardVO();
            }

            result.put("expend", resultExpendVo);
            result.put("expendUseEmp", userOrgVo);
            result.put("expendWriter", writeOrgVo);
            result.put("card", cardVO);
            result.put("partner", partnerVO);
            result.put("project", projectVO);
            // result.put( "expendEmpVo", commonCode.EMPTYSTR );
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            throw e;
        }
        return result;
    }

    /* 본문내역 수정 이력 입력 */
    @Override
    public ResultVO ExAppDocHistoryInsert(Map<String, Object> params) {
        // return expendA.ExAppDocHistoryInsert( params );
        return null;
    }

    /* 본문내역 수정 이력 컨텐츠 입력 */
    @Override
    public ResultVO ExAppDocContentsHistoryInsert(Map<String, Object> params) {
        // return expendA.ExAppDocContentsHistoryInsert( params );
        return null;
    }

    /* 지출결의 가져오기 리스트 조회 */
    @Override
    public ResultVO ExExpendHistoryListSelect(ResultVO param) {
        return expendA.ExExpendHistoryListSelect(param);
    }

    /* 지출결의 수정 내역 이력 추가 */
    @Override
    public ResultVO ExExpendEditHistoryInsert(ResultVO param) {
        return expendA.ExExpendEditHistoryInsert(param);
    }

    /* 지출결의 버튼설정 정보 조회 */
    @Override
    public ResultVO ExExpendButtonInfoSelect(Map<String, Object> params) throws Exception {
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        if (loginVo == null) {
            throw new Exception("로그인 세션 검색 실패");
        }
        params.put("compSeq", loginVo.getCompSeq());
        return expendA.ExExpendButtonInfoSelect(params);
    }

    /* 지출결의 마감 정보 조회 */
    @Override
    public List<Map<String, Object>> ExExpendCloseDateSelect(Map<String, Object> param) {
        /* 파라미터 확인 */
        if (param.get("compSeq") == null || CommonConvert.CommonGetStr(param.get("compSeq")).equals(commonCode.EMPTYSTR)) {
            return null;
        }
        if (param.get("formSeq") == null || CommonConvert.CommonGetStr(param.get("formSeq")).equals(commonCode.EMPTYSTR)) {
            return null;
        }
        return expendA.ExExpendCloseDateSelect(param);
    }
}