package expend.ex.user.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import common.enums.ex.OptionCodeType;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.CommonMapInterface.commonPath;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExAttachVO;
import common.vo.ex.ExCodeAuthVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCodeSummaryVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExExpendMngVO;
import common.vo.ex.ExExpendSlipVO;
import common.vo.ex.ExpendVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.budget.BExBudgetService;
import expend.ex.cmm.BExCommonService;
import expend.ex.user.card.BExUserCardService;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.expend.BExUserService;
import expend.ex.user.list.BExUserListService;
import expend.ex.user.mng.BExUserMngService;
import expend.ex.user.slip.BExUserSlipService;
import expend.ex.user.yesil.BExUserYesilService;
import neos.cmm.util.code.CommonCodeUtil;
import net.sf.json.JSONArray;


@Controller
public class VExUserPopController {

    /* 변수정의 */
    /* 변수정의 - Service */
    @Resource(name = "BExUserService")
    private BExUserService expendService; /* Expend Service */
    @Resource(name = "BExUserListService")
    private BExUserListService listService; /* List Service */
    @Resource(name = "BExUserSlipService")
    private BExUserSlipService slipService; /* Sliip Service */
    @Resource(name = "BExUserMngService")
    private BExUserMngService mngService; /* Mng Service */
    @Resource(name = "BExUserCodeService")
    private BExUserCodeService codeService; /* Mng Service */
    @Resource(name = "BExBudgetService")
    private BExBudgetService budgetService; /* Mng Service */
    @Resource(name = "BExUserCardService")
    private BExUserCardService userCardService; /* Card Service */
    @Resource(name = "BExUserYesilService")
    private BExUserYesilService yesilService; /* Yesil Service */
    @Resource(name = "BExUserService")
    private BExUserService userService;
    @Resource(name = "BExAdminConfigService") /* 환경설정 서비스 */
    private BExAdminConfigService configService;
    @Resource(name = "BExCommonService")
    private BExCommonService exCommonService;
    /* 변수정의 - Class */
    // @Resource ( name = "CommonLogger" )
    // private CommonLogger cmLog = new CommonLogger( );
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    /* Pop View */
    /* Pop View - 지출결의 */
    /* Pop View - 지출결의 - 지출결의 작성 */
    @IncludedInfo(name = "사용자 지출결의 작성", order = 901, gid = 90)
    @RequestMapping("/ex/expend/master/ExUserMasterPop.do")
    public ModelAndView ExUserMasterPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 전자결재 > 결재작성 > 문서양식 > 지출결의서(양식) > 팝업 호출 */
        /* 지출결의 작성을 위한 팝업으로, 지출결의 작성의 핵심 팝업이다. */
        /* 사용자에 의해 호출되는 페이지로 지출결의 작성, 수정 등의 이벤트가 있다. */
        ModelAndView mv = new ModelAndView();
        try {
            Map<String, Object> result = new HashMap<String, Object>();
            /* 반환정보 가공 */
            params.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpVO().getGroupSeq());
            result = expendService.ExUserMasterPopReturn(params);
            String formId = EgovStringUtil.isNullToString(result.get("formId"));
            result.put("formSeq", formId);
            result.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpVO().getGroupSeq());
            String docSeq = EgovStringUtil.isNullToString(result.get(commonCode.DOCID));
            params.put(commonCode.DOCSEQ, docSeq);
            if (params.get(commonCode.EXPENDSEQ) == null || params.get(commonCode.EXPENDSEQ).toString().equals(commonCode.EMPTYSTR)) {
                result.put(commonCode.EXPENDSEQ, commonCode.EMPTYSEQ);
            } else {
                // 전자결재 상태 조회
                Map<String, Object> expendSimpleInfo = new HashMap<String, Object>();
                expendSimpleInfo = codeService.ExUserExpendDocStsSelect(params);
                result.put("expendStatCode", expendSimpleInfo.get("expendStatCode"));
                result.put("erpSendYN", expendSimpleInfo.get("erpSendYN"));
            }
            /* 명칭설정 반영 */
            Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
            String pCompSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
            String plangCode = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.LANGCODE)));
            String pGroupSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.GROUPSEQ)));
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            Map<String, Object> formInfo = new HashMap<String, Object>();
            formInfo = cmInfo.CommonGetEapFormInfo(CommonConvert.CommonGetStr(result.get("formId")));
            formInfo.put("form_alert", CommonConvert.CommonGetStr(formInfo.get("form_alert")).replace("\r\n", "<br />").replace("\n", "<br />"));
            mv.addObject("formInfo", CommonConvert.CommonGetMapToJSONObj(formInfo)); /* 전자결재 양식 정보 */
            // mv.addObject( "formInfo", formInfo ); /* 전자결재 양식 정보 */
            /* 카드사용내역, 매입전자세금계산서 노출여부 확인 */
            String cardUse = CommonCodeUtil.getCodeName("ex00027", "CARDBTN");
            String etaxUse = CommonCodeUtil.getCodeName("ex00027", "ETAXBTN");
            result.put("cardUse", cardUse);
            result.put("etaxUse", etaxUse);
            /* 지출결의 마감 설정 반영 */
            List<Map<String, Object>> closeArr = new ArrayList<Map<String, Object>>();
            closeArr = userService.ExExpendCloseDateSelect(result);
            result.put("authCloseDate", commonCode.EMPTYSTR);
            result.put("expendCloseDate", commonCode.EMPTYSTR);
            result.put("createCloseDate", commonCode.EMPTYSTR);
            if (closeArr != null) {
                List<Map<String, Object>> authDateList = new ArrayList<Map<String, Object>>();
                List<Map<String, Object>> expendDateList = new ArrayList<Map<String, Object>>();
                List<Map<String, Object>> createDateList = new ArrayList<Map<String, Object>>();
                for (Map<String, Object> tMap : closeArr) {
                    /* A : 증빙일자, E : 회계일자, C : 작성일자 */
                    if (CommonConvert.CommonGetStr(tMap.get("closeType")).equals("A")) {
                        // result.put( "authCloseDate", tMap.get( "closeToDate" ) );
                        authDateList.add(tMap);
                    } else if (CommonConvert.CommonGetStr(tMap.get("closeType")).equals("E")) {
                        // result.put( "expendCloseDate", tMap.get("closeToDate") );
                        expendDateList.add(tMap);
                    } else {
                        // result.put( "createCloseDate", tMap.get("closeToDate") );
                        createDateList.add(tMap);
                    }
                }
                result.put("authDateList", CommonConvert.CommonGetListMapToJson(authDateList));
                result.put("expendDateList", CommonConvert.CommonGetListMapToJson(expendDateList));
                result.put("createDateList", CommonConvert.CommonGetListMapToJson(createDateList));
            }
            /* 버튼설정 내용 반영 */
            String btns = "[]";
            HashMap<String, Object> btnInfoParam = new HashMap<>();
            btnInfoParam.put("formSeq", result.get("formId"));
            btns = CommonConvert.CommonGetListMapToJson(userService.ExExpendButtonInfoSelect(btnInfoParam).getAaData());
            result.put("btnInfo", btns);
            result.put("langKind", CommonConvert.CommonGetStr(empInfo.get(commonCode.LANGCODE)));
            /* 관리자 - 지출결의 확인 메뉴 접근 여부 처리 */
            result.put("adminReport", params.get("adminReport"));
            /* 예산체크 스킵 관련 */
            String flag = commonCode.EMPTYSTR;
            try {
                Map<String, Object> codeParams = new HashMap<String, Object>();
                codeParams.put("groupSeq", CommonConvert.CommonGetEmpVO().getGroupSeq());
                codeParams.put("code", "ex00037");
                codeParams.put("detailCode", "0001");
                Map<String, Object> codeResult = exCommonService.CommonCodeSelect(codeParams);
                flag = codeResult.get("FLAG_1").toString();
                result.put("skipBudgetCheck", flag);
            } catch (Exception e) {
                result.put("skipBudgetCheck", -1);
            }
            /* View path, ViewBag 정의 [MasterPop.jsp] */
            mv.addObject("ViewBag", result);
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USEREXPENDPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        /* 반환처리 */
        return mv;
    }

    /* Pop View - 지출결의 - 항목추가 작성 */
    @RequestMapping("/ex/expend/list/ExUserListPop.do")
    public ModelAndView ExUserListPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 지출결의 작성 > 항목 추가 */
        /* 영수증의 정보를 입력하기 위한 팝업이다. */
        /* 표준적요, 증빙유형 금액 등을 입력한다. */
        /* 분개처리, 관리항목을 처리 할 수 있는 정보를 입력 받는다. */
        /* 기본 : 표준적요, 증빙유형, 적요, 프로젝트, 거래처, 카드, 차량, 금액, 예산(선택) */
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            Map<String, Object> result = new HashMap<String, Object>();
            /* 반환정보 가공 */
            result = listService.ExUserListPopReturn(params);
            mv.addObject("ViewBag", result);
            /* View path 정의 [ListPop.jsp] */
            mv.setViewName(commonExPath.POPPATH + commonExPath.USERLISTPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 지출결의 - 분개추가 작성 */
    @RequestMapping("/ex/expend/slip/ExUserSlipPop.do")
    public ModelAndView ExUserSlipPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 지출결의 작성 > 항목 선택 > 분개 추가 */
        /* 분개된 결과에 대한 세부 조정을 할 수 있는 팝업이다. */
        /* 분개입력, 관리항목을 처리할 수 있는 정보를 입력 받는다. */
        /* 기본 : 계정과목, 부가세 구분, 적요, 프로젝트, 거래처, 카드, 차량 ,금액, 예산(선택) */
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            Map<String, Object> result = new HashMap<String, Object>();
            /* 반환정보 가공 */
            result = slipService.ExUserSlipPopReturn(params);
            mv.addObject("ViewBag", result);
            /* View path 정의 [SlipPop.jsp] */
            mv.setViewName(commonExPath.POPPATH + commonExPath.USERSLIPPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 지출결의 - 관리항목 수정 */
    @RequestMapping("/ex/expend/mng/ExUserMngPop.do")
    public ModelAndView ExUserMngPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 지출결의 작성 > 항목 선택 > 분개 선택 > 관리항목 선택 팝업 */
        /* 입력된 관리항목의 수정 또는 미입력된 관리항목의 수정을 진행할 수 있는 팝업니다. */
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            Map<String, Object> result = new HashMap<String, Object>();
            /* 반환정보 가공 */
            result = mngService.ExUserMngPopReturn(params);
            mv.addObject("ViewBag", result);
            /* View path 정의 [MngPop.jsp] */
            mv.setViewName(commonExPath.POPPATH + commonExPath.USERMNGPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 공통코드 - 차량 */
    @SuppressWarnings("unused")
    @RequestMapping("/ex/expend/code/ExUserCarPop.do")
    public ModelAndView ExUserCarPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* iCUBE */ /* ERPiU */
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            Map<String, Object> result = new HashMap<String, Object>();
            /* 반환정보 가공 */
            mv.addObject("ViewBag", commonCode.EMPTYSTR);
            /* View path 정의 [CarPop.jsp] */
            mv.setViewName(commonExPath.POPPATH + commonExPath.USERCARPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 공통코드 - 공통팝업 */
    @RequestMapping("/ex/expend/code/UserCmmCodePop.do")
    public ModelAndView UserCmmCodePop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            } else if (CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).equals(commonCode.EMPTYSEQ)) {
                throw new NotFoundLoginSessionException("사용자 소속 회사 조회 실패");
            }
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
            result = cmInfo.CommonGetCodeA(loginVo.getGroupSeq(), loginVo.getCompSeq(), loginVo.getLangCode(), "ex00031");
            /* 반환정보 가공 */
            mv.addObject("codeType", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("codeType").toString()));
            mv.addObject("callback", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("callback").toString()));
            mv.addObject("searchStr", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("searchStr").toString()));
            mv.addObject("erp_emp_seq", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("erp_emp_seq").toString()));
            mv.addObject("erp_dept_seq", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("erp_dept_seq").toString()));
            mv.addObject("budget_code", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("budget_code").toString()));
            mv.addObject("bizplan_code", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("bizplan_code").toString()));
            mv.addObject("acct_type", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("acct_type").toString()));
            mv.addObject("acct_code", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("acct_code").toString()));
            mv.addObject("vat_type", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("vat_type").toString()));
            mv.addObject("reflectResultPop", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("reflectResultPop").toString()));
            mv.addObject("expendCardOption", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("expendCardOption").toString()));
            mv.addObject("searchType", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("search_type").toString()));
            mv.addObject("summryDisplayOption", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("summryDisplayOption").toString()));
            mv.addObject("codeSortType", CommonConvert.CommonConvertSpecialCharaterForHTML(params.get("codeSortType").toString()));
            mv.addObject("viewLangth", JSONArray.fromObject(result));
            mv.addObject(commonCode.FORMSEQ, (params.get(commonCode.FORMSEQ) == null ? commonCode.EMPTYSTR : params.get(commonCode.FORMSEQ)));
            /* CustomLabel / 명칭정보 사용 ViewObject 추가. */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());

            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            mv.addObject("ifSystem", conVo.getErpTypeCode());

            /* View path 정의 [UserCmmCodePop.jsp] */
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERCMMCODEPOP);
            //System.out.println(commonExPath.USERPOPPATH + commonExPath.UserCmmCodePop);
        } catch (NotFoundLoginSessionException ex) {
            mv.addObject("errMsg", ex.getMessage());
            mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
        } catch (Exception ex) {
            // cmLog.CommonSetError( ex );
            mv.addObject("errMsg", ex.getMessage());
            mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
        }
        return mv;
    }

    /* Pop View - 카드사용내역 선택 팝업 */
    @SuppressWarnings("unused")
    @RequestMapping("/ex/card/UserCardUsageHistoryPop.do")
    public ModelAndView UserCardUsageHistoryPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ServletContext sc = request.getSession().getServletContext();
            ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* 사용자 정보 */
            // exUtilCommonService.ConvertEmpInfo(loginVo)
            sendParam.put("empInfo", CommonConvert.CommonGetEmpInfo());
            /* ERP 연결정보 조회 */
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(params.get(commonCode.COMPSEQ)));
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            sendParam.put("callback", params.get("callback"));
            /* 사용자 정보 표시 위치 옵션 확인 */
            params.put("optionCode", OptionCodeType.LAYOUT_INPUT_SETTING_USERINFO.getOptionCode());
            params.put("useSw", conVo.getErpTypeCode());
            ResultVO optionList = configService.ExAdminConfigOptionSelect(params);
            boolean isEmpInfoLocateExpend = false;
            if (optionList == null || optionList.getAaData().size() == 0 || CommonConvert.CommonGetStr(optionList.getAaData().get(0).get("set_value")).equals("E")) {
                isEmpInfoLocateExpend = true;
            }
            sendParam.put("isEmpInfoLocateExpend", isEmpInfoLocateExpend);
            sendParam.put("isSearchWithCancel", params.get("isSearchWithCancel"));

            /* 표준적요 변경 시 예산정보 초기화 옵션 확인 */
            params.put("optionCode", OptionCodeType.INPUT_INIT_BUDGET_BY_SUMMARY.getOptionCode());
            optionList = new ResultVO();
            optionList = configService.ExAdminConfigOptionSelect(params);
            String isSummaryChangeReset = "";
            if (optionList.getAaData().size() > 0) {
                isSummaryChangeReset = CommonConvert.CommonGetStr(optionList.getAaData().get(0).get("set_value"));
            }
            sendParam.put("isSummaryChangeReset", isSummaryChangeReset);

            /* 명칭설정 반영 */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERCARDUSAGEHISTORYPOP);
            //System.out.println(commonExPath.USERPOPPATH + commonExPath.UserCardUsageHistoryPop);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 카드사용내역 선택 팝업 - 카드정보 도움창 팝업 */
    @RequestMapping("/ex/card/UserCardInfoHelpPop.do")
    public ModelAndView UserCardInfoHelpPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();

            sendParam.put("callback", params.get("callback"));
            sendParam.put("searchStr", params.get("searchStr"));
            sendParam.put("checkedCardInfo", params.get("checkedCardInfo"));

            /* 명칭설정 반영 */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERCARDINFOHELPPOP + ".pudding_popup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* View - 지출결의 항목 작성팝업 */
    @IncludedInfo(name = "사용자 항목 작성", order = 903, gid = 90)
    @RequestMapping("/ex/expend/list/ExExpendListPopup.do")
    public ModelAndView ExExpendListPopup(@ModelAttribute("listVo") ExExpendListVO listVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            Map<String, Object> formInfo = new HashMap<String, Object>();
            Map<String, Object> formInfoParam = new HashMap<String, Object>();
            /* 사용자 정보 */
            sendParam.put("empInfo", CommonConvert.CommonGetEmpInfo());
            sendParam.put("compSeq", loginVo.getCompSeq());
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            /* 양식정보 조회 */
            formInfoParam.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            formInfoParam.put(commonCode.BIZSEQ, loginVo.getBizSeq());
            formInfoParam.put(commonCode.DEPTSEQ, loginVo.getOrgnztId());
            formInfoParam.put(commonCode.EMPSEQ, loginVo.getUniqId());
            formInfoParam.put(commonCode.LANGCODE, loginVo.getLangCode());
            formInfoParam.put("searchFormSeq", listVo.getFormSeq());
            // formInfo = codeService.ExCodeCommonFormDetailInfoSelect( formInfoParam, conVo );
            formInfo = cmInfo.CommonGetEapFormDetailInfo(formInfoParam);
            /* 예산연동 시스템 조회 */
            sendParam.put("ifBudget", cmInfo.UtilIfBudgetInfoSelect(formInfo));
            if (!listVo.getListSeq().equals(commonCode.EMPTYSTR) && !listVo.getListSeq().equals(commonCode.EMPTYSEQ)) {
                /* 지출결의 - 항목 */
                /* 지출결의 - 항목 데이터 처리 */
                listVo = listService.ExUserListInfoSelect(listVo);
                listVo.setCompSeq(loginVo.getCompSeq());
                // listVo.setNote( CommonConvert.CommonConvertSpecialCharaterForHTML( listVo.getNote( ) ) );
                // sendParam.put( "list", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( listVo ) ) );
                sendParam.put("list", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(listVo)));
                /* 공통코드 - 사용자 */
                /* 공통코드 - 사용자 서비스 정의 */
                /* 공통코드 - 사용자 데이터 처리 */
                ExCodeOrgVO orgVo = new ExCodeOrgVO();
                orgVo.setCompSeq(listVo.getCompSeq());
                orgVo.setSeq(listVo.getEmpSeq());
                orgVo = codeService.ExExpendEmpInfoSelect(orgVo);
                // sendParam.put( "emp", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( orgVo ) ) );
                sendParam.put("emp", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(orgVo)));
                /* 공통코드 - 표준적요 */
                /* 공통코드 - 표준적요 서비스 정의 */
                /* 공통코드 - 표준적요 데이터 처리 */
                ExCodeSummaryVO summaryVo = new ExCodeSummaryVO();
                summaryVo.setCompSeq(listVo.getCompSeq());
                summaryVo.setSeq(listVo.getSummarySeq());
                summaryVo = codeService.ExExpendSummaryInfoSelect(summaryVo);
                // summaryVo.setDrAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( summaryVo.getDrAcctName( ) ) );
                // summaryVo.setVatAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( summaryVo.getVatAcctName( ) ) );
                // summaryVo.setCrAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( summaryVo.getCrAcctName( ) ) );
                // summaryVo.setSummaryName( CommonConvert.CommonConvertSpecialCharaterForHTML( summaryVo.getSummaryName( ) ) );
                // sendParam.put( "summary", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( summaryVo ) ) );
                /* 접대비 계정 여부 확인 */
                if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU) && (loginVo.getGroupSeq().equals("visang") || loginVo.getGroupSeq().equals("demo") || loginVo.getGroupSeq().equals("portal"))) {
                    Map<String, Object> param = new HashMap<String, Object>();
                    param.put(commonCode.ERPCOMPSEQ, loginVo.getErpCoCd());
                    param.put("acctCode", summaryVo.getDrAcctCode());
                    ResultVO result = new ResultVO();
                    result = codeService.ExCommonAcctReceptYN(param, conVo);
                    String isReceptYN = "N";
                    if (result != null && result.getAaData() != null && !result.getAaData().isEmpty() && CommonConvert.CommonGetStr(result.getAaData().get(0).get("receptYN")).equals("Y")) {
                        isReceptYN = "Y";
                    } else {
                        isReceptYN = "N";
                    }
                    sendParam.put("isReceptYN", isReceptYN);
                } else {
                    sendParam.put("isReceptYN", "N");
                }
                sendParam.put("summary", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(summaryVo)));
                /* 공통코드 - 증빙유형 */
                /* 공통코드 - 증빙유형 서비스 정의 */
                /* 공통코드 - 증빙유형 데이터 처리 */
                ExCodeAuthVO authVo = new ExCodeAuthVO();
                authVo.setCompSeq(listVo.getCompSeq());
                authVo.setSeq(listVo.getAuthSeq());
                authVo = codeService.ExExpendAuthInfoSelect(authVo);
                // authVo.setVatAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( authVo.getVatAcctName( ) ) );
                // authVo.setCrAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( authVo.getCrAcctName( ) ) );
                // authVo.setAuthName( CommonConvert.CommonConvertSpecialCharaterForHTML( authVo.getAuthName( ) ) );
                // sendParam.put( "auth", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( authVo ) ) );
                sendParam.put("auth", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(authVo)));
                /* 공통코드 - 프로젝트 */
                /* 공통코드 - 프로젝트 서비스 정의 */
                /* 공통코드 - 프로젝트 데이터 처리 */
                ExCodeProjectVO projectVo = new ExCodeProjectVO();
                projectVo.setCompSeq(listVo.getCompSeq());
                projectVo.setSeq(listVo.getProjectSeq());
                if (projectVo.getSeq() != 0) {
                    projectVo = codeService.ExExpendProjectInfoSelect(projectVo);
                    // projectVo.setProjectName( CommonConvert.CommonConvertSpecialCharaterForHTML( projectVo.getProjectName( ) ) );
                }
                // sendParam.put( "project", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( projectVo ) ) );
                sendParam.put("project", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(projectVo)));
                /* 공통코드 - 거래처 */
                /* 공통코드 - 거래처 서비스 정의 */
                /* 공통코드 - 거래처 데이터 처리 */
                ExCodePartnerVO partnerVo = new ExCodePartnerVO();
                partnerVo.setCompSeq(listVo.getCompSeq());
                partnerVo.setSeq(listVo.getPartnerSeq());
                if (partnerVo.getSeq() != 0) {
                    partnerVo = codeService.ExExpendPartnerInfoSelect(partnerVo);
                    // partnerVo.setPartnerName( CommonConvert.CommonConvertSpecialCharaterForHTML( partnerVo.getPartnerName( ) ) );
                }
                // sendParam.put( "partner", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( partnerVo ) ) );
                sendParam.put("partner", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(partnerVo)));
                /* 공통코드 - 카드 */
                /* 공통코드 - 카드 서비스 정의 */
                /* 공통코드 - 카드 데이터 처리 */
                ExCodeCardVO cardVo = new ExCodeCardVO();
                cardVo.setCompSeq(listVo.getCompSeq());
                cardVo.setSeq(listVo.getCardSeq());
                if (cardVo.getSeq() != 0) {
                    // iCUBE일때만 조회(ERPiU는 카드정보 테이블(FI_CARD)에 거래처정보가 없음)
                    // iCUBE에 존재하는 카드이지만 그룹웨어에는 없을때 카드정보에 있는 거래처정보를 가져오기 위해 조회
                    if(conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
                    	cardVo = codeService.ExExpendCardInfoSelectWithPartner(cardVo, conVo);
                    }else {
                    	cardVo = codeService.ExExpendCardInfoSelect(cardVo);
                    }
                    // cardVo.setCardName( CommonConvert.CommonConvertSpecialCharaterForHTML( cardVo.getCardName( ) ) );
                }
                // sendParam.put( "card", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( cardVo ) ) );
                sendParam.put("card", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(cardVo)));
                /* 공통코드 - 예산 */
                /* 공통코드 - 예산 서비스 정의 */
                /* 공통코드 - 예산 데이터 처리 */
                ExCodeBudgetVO budgetVo = new ExCodeBudgetVO();
                budgetVo.setCompSeq(listVo.getCompSeq());
                budgetVo.setSeq(listVo.getBudgetSeq());
                /* ERPiU는 예산정보 미 조회시 예산단위, 사업계획, 예산계정 미노출되므로 아래 소스 삭제하면 안됨. */
                if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU)) {
                    /* slip 차변의 min seq 의 seq 값을 가지고 뿌려준다. */
                    ExExpendSlipVO tSlipVo = new ExExpendSlipVO();
                    List<ExExpendSlipVO> tSlipList = new ArrayList<ExExpendSlipVO>();
                    tSlipVo.setExpendSeq(listVo.getExpendSeq());
                    tSlipVo.setListSeq(listVo.getListSeq());
                    tSlipList = slipService.ExSlipListInfoSelect(tSlipVo);
                    if (tSlipList != null && tSlipList.size() > 0) {
                        boolean ifNotExistDr = true;
                        for (ExExpendSlipVO tData : tSlipList) {
                            if (tData.getDrcrGbn().equals("dr") && tData.getBudgetSeq() != 0) {
                                budgetVo.setSeq(tData.getBudgetSeq());
                                ifNotExistDr = false;
                                break;
                            }
                        }
                        if (!ifNotExistDr) {
                            budgetVo = codeService.ExExpendBudgetInfoSelect(budgetVo);
                            // budgetVo.setBudgetName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBudgetName( ) ) );
                            // budgetVo.setBizplanName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBizplanName( ) ) );
                            // budgetVo.setBgacctName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBgacctName( ) ) );
                            // sendParam.put( "budget", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( budgetVo ) ) );
                            sendParam.put("budget", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(budgetVo)));
                        }
                    }
                } else if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                    /* slip 차변의 min seq 의 seq 값을 가지고 뿌려준다. */
                    ExExpendSlipVO tSlipVo = new ExExpendSlipVO();
                    List<ExExpendSlipVO> tSlipList = new ArrayList<ExExpendSlipVO>();
                    tSlipVo.setExpendSeq(listVo.getExpendSeq());
                    tSlipVo.setListSeq(listVo.getListSeq());
                    tSlipList = slipService.ExSlipListInfoSelect(tSlipVo);
                    if (tSlipList != null && tSlipList.size() > 0) {
                        boolean ifNotExistDr = true;
                        for (ExExpendSlipVO tData : tSlipList) {
                            if (tData.getDrcrGbn().equals("dr") && tData.getBudgetSeq() != 0) {
                                budgetVo.setSeq(tData.getBudgetSeq());
                                ifNotExistDr = false;
                                break;
                            }
                        }
                        if (!ifNotExistDr) {
                            budgetVo = codeService.ExExpendBudgetInfoSelect(budgetVo);
                            // budgetVo.setBudgetName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBudgetName( ) ) );
                            // budgetVo.setBizplanName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBizplanName( ) ) );
                            // budgetVo.setBgacctName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBgacctName( ) ) );
                            // sendParam.put( "budget", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( budgetVo ) ) );
                            sendParam.put("budget", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(budgetVo)));
                        }
                    }
                }
                /* 공통코드 - 첨부파일 */
                List<ExAttachVO> attachList = new ArrayList<ExAttachVO>();
                Map<String, Object> serviceParams = new HashMap<String, Object>();
                serviceParams.put("group_seq", loginVo.getGroupSeq());
                serviceParams.put("expend_seq", listVo.getExpendSeq());
                serviceParams.put("list_seq", listVo.getListSeq());
                attachList = listService.ExListAttachInfoSelect(serviceParams);
                List<Map<String, Object>> attLstMap = new ArrayList<Map<String, Object>>();
                for (ExAttachVO attachVo : attachList) {
                    attLstMap.add(ConvertManager.ConverObjectToMap(attachVo));
                }
                sendParam.put("attach", ConvertManager.ConvertListMapToJson(attLstMap));
                /* 공통코드 - 지출결의 첨부파일 정보 */
                Map<String, Object> expAttachParam = new HashMap<String, Object>();
                List<Map<String, Object>> expAttachList = new ArrayList<Map<String, Object>>();
                expAttachParam.put(commonCode.EXPENDSEQ, listVo.getExpendSeq());
                expAttachParam.put(commonCode.LISTSEQ, listVo.getListSeq());
                expAttachList = listService.ExExpendListAttachListInfoSelect(expAttachParam);
                sendParam.put("expendAttachList", ConvertManager.ConvertListMapToJson(expAttachList));
            } else {
                /* 사용자 항목단위 입력인 경우 최초 항목 추가 시 로그인한 사용자로 표시 */
                ExpendVO expendVo = new ExpendVO();
                expendVo.setExpendSeq(listVo.getExpendSeq());
                expendVo = expendService.ExUserExpendInfoSelect(expendVo);
                /* 공통코드 - 사용자 */
                /* 공통코드 - 사용자 서비스 정의 */
                /* 공통코드 - 사용자 데이터 처리 */
                ExCodeOrgVO orgVo = new ExCodeOrgVO();
                orgVo.setCompSeq(expendVo.getCompSeq());
                orgVo.setSeq(expendVo.getEmpSeq());
                orgVo = codeService.ExExpendEmpInfoSelect(orgVo);
                sendParam.put("emp", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(orgVo)));
                sendParam.put("list", commonCode.EMPTYSTR);
                // sendParam.put( "emp", commonCode.EMPTYSTR );
                sendParam.put("summary", commonCode.EMPTYSTR);
                sendParam.put("auth", commonCode.EMPTYSTR);
                sendParam.put("project", commonCode.EMPTYSTR);
                sendParam.put("partner", commonCode.EMPTYSTR);
                sendParam.put("card", commonCode.EMPTYSTR);
                sendParam.put("budget", commonCode.EMPTYSTR);
                sendParam.put("attach", commonCode.EMPTYSTR);
                sendParam.put("expendAttachList", commonCode.EMPTYSTR);
            }
            /* 예산통제 구분 조회 */
            if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ICUBE)) {
                /* 변수정의 */
                ExCodeBudgetVO budgetVo = new ExCodeBudgetVO();
                budgetVo.setErpCompSeq(loginVo.getErpCoCd());
                /* iCUBE 예산통제 구분 정보 조회 */
                // budgetVo = codeService.ExCodeBudgetTypeInfoSelect(budgetVo, conVo);
                Map<String, Object> tBudget = CommonConvert.CommonGetObjectToMap(budgetVo);
                tBudget.put("erpType", conVo.getErpTypeCode());
                tBudget = budgetService.ExBudgetUseInfoSelect(tBudget);
                budgetVo = (ExCodeBudgetVO) CommonConvert.CommonGetMapToObject(tBudget, budgetVo);
                sendParam.put("iCUBEBudgetUseYN", tBudget.get("useYN"));// budgetVo.getUse_yn());
                sendParam.put("iCUBEBudgetType", tBudget.get("budgetType")); // budgetVo.getBudget_type());
            } else {
                sendParam.put("iCUBEBudgetUseYN", commonCode.EMPTYSTR);
                sendParam.put("iCUBEBudgetType", commonCode.EMPTYSTR);
            }

            /* 표준적요 변경 시 예산정보 초기화 옵션 확인 */
            Map<String, Object> optionParam = new HashMap<String, Object>();
            optionParam.put("compSeq", listVo.getCompSeq());
            optionParam.put("formSeq", formInfo.get("formSeq"));
            optionParam.put("useSw", conVo.getErpTypeCode());
            optionParam.put("optionCode", OptionCodeType.INPUT_INIT_BUDGET_BY_SUMMARY.getOptionCode());

            ResultVO optionList = new ResultVO();
            optionList = configService.ExAdminConfigOptionSelect(optionParam);
            String isSummaryChangeReset = "";
            if (optionList.getAaData().size() > 0) {
                isSummaryChangeReset = CommonConvert.CommonGetStr(optionList.getAaData().get(0).get("set_value"));
            }
            sendParam.put("isSummaryChangeReset", isSummaryChangeReset);

            // 반환값 처리
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.setViewName("/expend/ex/user/pop/ExExpendListPopup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 항목관리 선택 팝업 */
    @SuppressWarnings("unused")
    @RequestMapping("/ex/user/UserMngPop.do")
    public ModelAndView UserMngPopup(@ModelAttribute ExExpendMngVO mngVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ServletContext sc = request.getSession().getServletContext();
            ApplicationContext act = WebApplicationContextUtils.getRequiredWebApplicationContext(sc);
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* 사용자 정보 */
            sendParam.put("empInfo", CommonConvert.CommonGetEmpInfo());
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(mngVo.getCompSeq()));
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            // 데이터 좋
            if (!mngVo.getMngSeq().equals(commonCode.EMPTYSTR) && !mngVo.getMngSeq().equals(commonCode.EMPTYSEQ)) {
                mngVo = mngService.ExMngInfoSelect(mngVo);
                sendParam.put("mngInfo", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(mngVo)));
            }
            /* 반환값 처리 */
            mv.addObject("ViewBag", sendParam);
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERMNGPOP);
            //System.out.println(commonExPath.USERPOPPATH + commonExPath.UserMngPop);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* 지출결의 - 예산체크 팝업 */
    @RequestMapping("/ex/user/expend/ExBudgetCheckPopup.do")
    public ModelAndView ExBudgetiCUBEChkPop(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            if (param.get("acct_name") != null) {
                param.put("acct_name", URLDecoder.decode((String) param.get("acct_name"), "utf-8"));
            }
            if (param.get("bgacct_name") != null) {
                param.put("bgacct_name", URLDecoder.decode((String) param.get("bgacct_name"), "utf-8"));
            }
            /* null 처리 */
            if (param.get("acct_code") == null) {
                param.put("acct_code", commonCode.EMPTYSEQ);
            }
            // if (param.get("acct_name") == null) {
            // param.put("acct_name", URLDecoder.decode("''", "utf-8"));
            // }
            if (param.get("bgacct_code") == null) {
                param.put("bgacct_code", commonCode.EMPTYSEQ);
            }
            // if (param.get("bgacct_name") == null) {
            // param.put("bgacct_name", URLDecoder.decode("''", "utf-8"));
            // }
            // if (param.get("bizplan_code") == null) {
            // param.put("bizplan_code", "''");
            // }

            if (param.get("bizplan_code") == null || param.get("bizplan_code").toString().equals("")) {
                param.put("bizplan_code", "***");
            }

            /* 반환처리 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("budget_param", param);
            mv.setViewName(commonExPath.USERPOPPATH + "ExBudgetCheckPopup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* 지출결의 - 예산초과 팝업 */
    @RequestMapping("/ex/user/expend/ExBudgetOverPopup.do")
    public ModelAndView ExBudgetOverPopup(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            if (param.get("acct_name") != null) {
                param.put("acct_name", URLDecoder.decode((String) param.get("acct_name"), "utf-8"));
            }
            if (param.get("bgacct_name") != null) {
                param.put("bgacct_name", URLDecoder.decode((String) param.get("bgacct_name"), "utf-8"));
            }
            if (param.get("acct_name") == null) {
                param.put("acct_name", URLDecoder.decode("''", "utf-8"));
            }
            if (param.get("bgacct_name") == null) {
                param.put("bgacct_name", URLDecoder.decode("''", "utf-8"));
            }
            /* 반환처리 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("budget_param", param);
            mv.setViewName(commonExPath.USERPOPPATH + "ExBudgetOverPopup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* 지출결의 - 외화입력 팝업 */
    @RequestMapping("/ex/user/expend/ExForeignCurrencyInputPopup.do")
    public ModelAndView ExForeignCurrencyInputPopup(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 반환처리 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", param);
            mv.setViewName(commonExPath.USERPOPPATH + "ExForeignCurrencyInputPopup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* View - 지출결의 항목 분개 작성팝업 */
    @RequestMapping("/ex/expend/slip/ExExpendSlipPopup.do")
    public ModelAndView ExExpendSlipPopup(@ModelAttribute("slipVo") ExExpendSlipVO slipVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            Map<String, Object> formInfo = new HashMap<String, Object>();
            Map<String, Object> formInfoParam = new HashMap<String, Object>();
            /* 사용자 정보 */
            sendParam.put("empInfo", CommonConvert.CommonGetEmpInfo());
            sendParam.put("compSeq", loginVo.getCompSeq());
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            /* 양식정보 조회 */
            formInfoParam.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            formInfoParam.put(commonCode.BIZSEQ, loginVo.getBizSeq());
            formInfoParam.put(commonCode.DEPTSEQ, loginVo.getOrgnztId());
            formInfoParam.put(commonCode.EMPSEQ, loginVo.getUniqId());
            formInfoParam.put(commonCode.LANGCODE, loginVo.getLangCode());
            formInfoParam.put("searchFormSeq", slipVo.getFormSeq());
            // formInfo = codeService.ExCodeCommonFormDetailInfoSelect(formInfoParam, conVo);
            formInfo = cmInfo.CommonGetEapFormDetailInfo(formInfoParam);
            ExExpendListVO listVo = new ExExpendListVO();
            listVo.setExpendSeq(slipVo.getExpendSeq());
            listVo.setListSeq(slipVo.getListSeq());
            listVo = listService.ExUserListInfoSelect(listVo);
            slipVo.setInterfaceType(listVo.getInterfaceType());
            slipVo.setInterfaceMId(listVo.getInterfaceMId());
            slipVo.setInterfaceDId(listVo.getInterfaceDId());
            /* 예산연동 시스템 조회 */
            sendParam.put("ifBudget", cmInfo.UtilIfBudgetInfoSelect(formInfo));
            if (!slipVo.getSlipSeq().equals(commonCode.EMPTYSTR) && !slipVo.getSlipSeq().equals(commonCode.EMPTYSEQ)) {
                /* 지출결의 - 분개 */
                /* 지출결의 - 분개 데이터 처리 */
                slipVo = slipService.ExSlipInfoSelect(slipVo);
                /* 접대비 계정 여부 확인 */
                if (slipVo.getDrcrGbn().equals("dr") && CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU) && (loginVo.getGroupSeq().equals("visang") || loginVo.getGroupSeq().equals("demo") || loginVo.getGroupSeq().equals("portal"))) {
                    Map<String, Object> param = new HashMap<String, Object>();
                    param.put(commonCode.ERPCOMPSEQ, loginVo.getErpCoCd());
                    param.put("acctCode", slipVo.getAcctCode());
                    ResultVO result = new ResultVO();
                    result = codeService.ExCommonAcctReceptYN(param, conVo);
                    String isReceptYN = "N";
                    if (result != null && result.getAaData() != null && !result.getAaData().isEmpty() && CommonConvert.CommonGetStr(result.getAaData().get(0).get("receptYN")).equals("Y")) {
                        isReceptYN = "Y";
                    } else {
                        isReceptYN = "N";
                    }
                    sendParam.put("isReceptYN", isReceptYN);
                } else {
                    sendParam.put("isReceptYN", "N");
                }
                // slipVo.setNote( CommonConvert.CommonConvertSpecialCharaterForHTML( slipVo.getNote( ) ) );
                // slipVo.setAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( slipVo.getAcctName( ) ) );
                // sendParam.put( "slip", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( slipVo ) ) );
                sendParam.put("slip", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(slipVo)));
                /* 공통코드 - 사용자 */
                /* 공통코드 - 사용자 데이터 처리 */
                ExCodeOrgVO orgVo = new ExCodeOrgVO();
                orgVo.setCompSeq(loginVo.getCompSeq());
                orgVo.setSeq(slipVo.getEmpSeq());
                orgVo = codeService.ExExpendEmpInfoSelect(orgVo);
                sendParam.put("emp", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(orgVo)));
                /* 공통코드 - 표준적요 */
                if (slipVo.getSummarySeq() != 0) {
                    /* 공통코드 - 표준적요 데이터 처리 */
                    ExCodeSummaryVO summaryVo = new ExCodeSummaryVO();
                    summaryVo.setCompSeq(loginVo.getCompSeq());
                    summaryVo.setSeq(slipVo.getSummarySeq());
                    summaryVo = codeService.ExExpendSummaryInfoSelect(summaryVo);
                    // summaryVo.setDrAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( summaryVo.getDrAcctName( ) ) );
                    // summaryVo.setCrAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( summaryVo.getCrAcctName( ) ) );
                    // summaryVo.setVatAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( summaryVo.getVatAcctName( ) ) );
                    // summaryVo.setSummaryName( CommonConvert.CommonConvertSpecialCharaterForHTML( summaryVo.getSummaryName( ) ) );
                    sendParam.put("summary", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(summaryVo)));
                } else {
                    sendParam.put("summary", commonCode.EMPTYSTR);
                }
                /* 공통코드 - 증빙유형 */
                if (slipVo.getAuthSeq() != 0) {
                    /* 공통코드 - 증빙유형 데이터 처리 */
                    ExCodeAuthVO authVo = new ExCodeAuthVO();
                    authVo.setCompSeq(loginVo.getCompSeq());
                    authVo.setSeq(slipVo.getAuthSeq());
                    authVo = codeService.ExExpendAuthInfoSelect(authVo);
                    // authVo.setCrAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( authVo.getCrAcctName( ) ) );
                    // authVo.setVatAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( authVo.getVatAcctName( ) ) );
                    // authVo.setAuthName( CommonConvert.CommonConvertSpecialCharaterForHTML( authVo.getAuthName( ) ) );
                    sendParam.put("auth", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(authVo)));
                } else {
                    sendParam.put("auth", commonCode.EMPTYSTR);
                }
                /* 공통코드 - 프로젝트 */
                if (slipVo.getProjectSeq() != 0) {
                    /* 공통코드 - 프로젝트 데이터 처리 */
                    ExCodeProjectVO projectVo = new ExCodeProjectVO();
                    projectVo.setCompSeq(loginVo.getCompSeq());
                    projectVo.setSeq(slipVo.getProjectSeq());
                    projectVo = codeService.ExExpendProjectInfoSelect(projectVo);
                    // projectVo.setProjectName( CommonConvert.CommonConvertSpecialCharaterForHTML( projectVo.getProjectName( ) ) );
                    sendParam.put("project", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(projectVo)));
                } else {
                    sendParam.put("project", commonCode.EMPTYSTR);
                }
                /* 공통코드 - 거래처 */
                if (slipVo.getPartnerSeq() != 0) {
                    /* 공통코드 - 거래처 데이터 처리 */
                    ExCodePartnerVO partnerVo = new ExCodePartnerVO();
                    partnerVo.setCompSeq(loginVo.getCompSeq());
                    partnerVo.setSeq(slipVo.getPartnerSeq());
                    partnerVo = codeService.ExExpendPartnerInfoSelect(partnerVo);
                    // partnerVo.setPartnerName( CommonConvert.CommonConvertSpecialCharaterForHTML( partnerVo.getPartnerName( ) ) );
                    sendParam.put("partner", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(partnerVo)));
                } else {
                    sendParam.put("partner", commonCode.EMPTYSTR);
                }
                /* 공통코드 - 카드 */
                if (slipVo.getCardSeq() != 0) {
                    /* 공통코드 - 카드 데이터 처리 */
                    ExCodeCardVO cardVo = new ExCodeCardVO();
                    cardVo.setCompSeq(loginVo.getCompSeq());
                    cardVo.setSeq(slipVo.getCardSeq());
                    cardVo = codeService.ExExpendCardInfoSelect(cardVo);
                    // cardVo.setCardName( CommonConvert.CommonConvertSpecialCharaterForHTML( cardVo.getCardName( ) ) );
                    sendParam.put("card", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(cardVo)));
                } else {
                    sendParam.put("card", commonCode.EMPTYSTR);
                }
                /* 공통코드 - 예산 */
                /* ERPiU는 예산정보 미 조회시 예산단위, 사업계획, 예산계정 미노출되므로 아래 소스 삭제하면 안됨. */
                if (CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.ERPIU) && slipVo.getBudgetSeq() != 0) {
                    /* 공통코드 - 예산 데이터 처리 */
                    ExCodeBudgetVO budgetVo = new ExCodeBudgetVO();
                    budgetVo.setCompSeq(loginVo.getCompSeq());
                    budgetVo.setSeq(slipVo.getBudgetSeq());
                    budgetVo = codeService.ExExpendBudgetInfoSelect(budgetVo);
                    // budgetVo.setBudgetName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBudgetName( ) ) );
                    // budgetVo.setBizplanName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBizplanName( ) ) );
                    // budgetVo.setBgacctName( CommonConvert.CommonConvertSpecialCharaterForHTML( budgetVo.getBgacctName( ) ) );
                    sendParam.put("budget", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(budgetVo)));
                } else {
                    sendParam.put("budget", commonCode.EMPTYSTR);
                }
                /* 첨부파일 */
                List<ExAttachVO> attachList = new ArrayList<ExAttachVO>();
                Map<String, Object> serviceParams = new HashMap<String, Object>();
                serviceParams.put("group_seq", loginVo.getGroupSeq());
                serviceParams.put("expend_seq", slipVo.getExpendSeq());
                serviceParams.put("list_seq", slipVo.getListSeq());
                serviceParams.put("slip_seq", slipVo.getSlipSeq());
                attachList = slipService.ExSlipAttachInfoSelect(serviceParams);
                List<Map<String, Object>> attLstMap = new ArrayList<Map<String, Object>>();
                for (ExAttachVO attachVo : attachList) {
                    attLstMap.add(ConvertManager.ConverObjectToMap(attachVo));
                }
                sendParam.put("attach", ConvertManager.ConvertListMapToJson(attLstMap));
                /* 공통코드 - 지출결의 첨부파일 정보 */
                Map<String, Object> expAttachParam = new HashMap<String, Object>();
                List<Map<String, Object>> expAttachList = new ArrayList<Map<String, Object>>();
                expAttachParam.put(commonCode.EXPENDSEQ, slipVo.getExpendSeq());
                expAttachParam.put(commonCode.LISTSEQ, slipVo.getListSeq());
                expAttachParam.put(commonCode.SLIPSEQ, slipVo.getSlipSeq());
                expAttachList = slipService.ExExpendSlipAttachListInfoSelect(expAttachParam);
                sendParam.put("expendAttachList", ConvertManager.ConvertListMapToJson(expAttachList));
            } else {
                /* 사용자 항목단위 입력인 경우 최초 항목 추가 시 로그인한 사용자로 표시 */
                ExpendVO expendVo = new ExpendVO();
                expendVo.setExpendSeq(slipVo.getExpendSeq());
                expendVo = expendService.ExUserExpendInfoSelect(expendVo);
                /* 공통코드 - 사용자 */
                /* 공통코드 - 사용자 서비스 정의 */
                /* 공통코드 - 사용자 데이터 처리 */
                ExCodeOrgVO orgVo = new ExCodeOrgVO();
                orgVo.setCompSeq(expendVo.getCompSeq());
                orgVo.setSeq(expendVo.getEmpSeq());
                orgVo = codeService.ExExpendEmpInfoSelect(orgVo);
                sendParam.put("emp", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(orgVo)));
                sendParam.put("slip", commonCode.EMPTYSTR);
                if (slipVo.getInterfaceType().equals("card") || slipVo.getInterfaceType().equals("etax")) {
                    sendParam.put("slip", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(slipVo)));
                }
                //sendParam.put("summary", commonCode.EMPTYSTR);
                if (listVo.getSummarySeq() != 0) {
                    ExCodeSummaryVO summaryVo = new ExCodeSummaryVO();
                    summaryVo.setCompSeq(loginVo.getCompSeq());
                    summaryVo.setSeq(listVo.getSummarySeq());
                    summaryVo = codeService.ExExpendSummaryInfoSelect(summaryVo);
                    sendParam.put("summary", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(summaryVo)));
                } else {
                    sendParam.put("summary", commonCode.EMPTYSTR);
                }
                //sendParam.put("auth", commonCode.EMPTYSTR);
                if (listVo.getAuthSeq() != 0) {
                    ExCodeAuthVO authVo = new ExCodeAuthVO();
                    authVo.setCompSeq(loginVo.getCompSeq());
                    authVo.setSeq(listVo.getAuthSeq());
                    authVo = codeService.ExExpendAuthInfoSelect(authVo);
                    sendParam.put("auth", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(authVo)));
                } else {
                    sendParam.put("auth", commonCode.EMPTYSTR);
                }
                sendParam.put("project", commonCode.EMPTYSTR);
                sendParam.put("partner", commonCode.EMPTYSTR);
                sendParam.put("card", commonCode.EMPTYSTR);
                sendParam.put("attach", commonCode.EMPTYSTR);
                sendParam.put("budget", commonCode.EMPTYSTR);
                sendParam.put("expendAttachList", commonCode.EMPTYSTR);
            }
            // 반환값 처리
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.setViewName("expend/ex/user/pop/ExExpendSlipPopup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* View - 지출결의 항목 분개 관리항목 팝업 */
    @RequestMapping("/ex/expend/mng/ExExpendMngPopup.do")
    public ModelAndView ExExpendMngPopup(@ModelAttribute("mngVo") ExExpendMngVO mngVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* 사용자 정보 */
            sendParam.put("empInfo", CommonConvert.CommonGetEmpInfo());
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            if (!mngVo.getMngSeq().equals(commonCode.EMPTYSTR) && !mngVo.getMngSeq().equals(commonCode.EMPTYSEQ)) {
                String searchStr = mngVo.getSearchStr();
                mngVo = mngService.ExMngInfoSelect(mngVo);
                mngVo.setSearchStr(searchStr);
                // mngVo.setCtdName( CommonConvert.CommonConvertSpecialCharaterForHTML( mngVo.getCtdName( ) ) );
                // mngVo.setMngName( CommonConvert.CommonConvertSpecialCharaterForHTML( mngVo.getMngName( ) ) );
                // mngVo.setRealMngName( CommonConvert.CommonConvertSpecialCharaterForHTML( mngVo.getRealMngName( ) ) );
                // mngVo.setAcctName( CommonConvert.CommonConvertSpecialCharaterForHTML( mngVo.getAcctName( ) ) );
                // mngVo.setSearchStr( CommonConvert.CommonConvertSpecialCharaterForHTML( mngVo.getSearchStr( ) ) );
                // sendParam.put( "mngInfo", ConvertManager.ConvertMapToJson( ConvertManager.ConverObjectToMap( mngVo ) ) );
                sendParam.put("mngInfo", CommonConvert.CommonGetMapToJSONObj(ConvertManager.ConverObjectToMap(mngVo)));
            }
            /* 명칭설정 반영 */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 반환값 처리 */
            mv.addObject("CL", vo.getData());
            mv.addObject("ViewBag", sendParam);
            mv.setViewName("/expend/ex/user/pop/ExExpendMngPopup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    @RequestMapping("/expend/ex/user/card/ExExpendCardDetailInfo.do")
    public ModelAndView ExExpendCardDetailInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            Map<String, Object> sendParam = new HashMap<String, Object>();
            ResultVO resultVo = new ResultVO();
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            resultVo.setParams(params);
            /* 명칭설정 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);

            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));

            /* 조회 */
            sendParam = userCardService.ExExpendCardDetailInfoSelect(resultVo, conVo);
            sendParam.put("isDisplayFullNumber", params.get("isDisplayFullNumber"));
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            /* 반환처리 */
            mv.addObject("ViewBag", sendParam);
            mv.addObject("CL", vo.getData());
            mv.setViewName("/expend/ex/user/pop/ExExpendCardDetailPop");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* View - 매입전자세금계산서 내역 */
    @RequestMapping("/expend/ex/user/etax/ExExpendETaxPopup.do")
    public ModelAndView ExExpendETaxPopup(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* 사용자 정보 */
            sendParam.put("empInfo", CommonConvert.CommonGetEmpInfo());
            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            /* 명칭설정 정보 */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            /* 사용자 정보 표시 위치 옵션 확인 */
            params.put("optionCode", OptionCodeType.LAYOUT_INPUT_SETTING_USERINFO.getOptionCode());
            params.put("useSw", conVo.getErpTypeCode());
            ResultVO optionList = configService.ExAdminConfigOptionSelect(params);
            boolean isEmpInfoLocateExpend = false;
            if (optionList == null || optionList.getAaData().size() == 0 || optionList.getAaData().get(0).get("set_value").toString().equals("E")) {
                isEmpInfoLocateExpend = true;
            }
            sendParam.put("isEmpInfoLocateExpend", isEmpInfoLocateExpend);

            /* 표준적요 변경 시 예산정보 초기화 옵션 확인 */
            params.put("optionCode", OptionCodeType.INPUT_INIT_BUDGET_BY_SUMMARY.getOptionCode());
            optionList = new ResultVO();
            optionList = configService.ExAdminConfigOptionSelect(params);
            String isSummaryChangeReset = "";
            if (optionList.getAaData().size() > 0) {
                isSummaryChangeReset = CommonConvert.CommonGetStr(optionList.getAaData().get(0).get("set_value"));
            }
            sendParam.put("isSummaryChangeReset", isSummaryChangeReset);

            sendParam = CommonConvert.CommonSetMapCopy(params, sendParam);
            /* 반환값 처리 */
            mv.addObject("ViewBag", sendParam);
            mv.addObject("eTaxDefault", commonCode.ETAXDEAFAULTCOUNT);
            mv.addObject("CL", vo.getData());
            mv.setViewName("/expend/ex/user/pop/ExExpendETaxPopup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* View - 매입전자세금계산서 상세보기 */
    @RequestMapping("/ex/expend/etax/ExExpendETaxDetailPopup.do")
    public ModelAndView ExExpendETaxDetailPopup(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            /* 사용자 정보 */
            sendParam.put("empInfo", CommonConvert.CommonGetEmpInfo());
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            sendParam.put(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            sendParam = CommonConvert.CommonSetMapCopy(param, sendParam);
            /* 반환값 처리 */
            mv.addObject("ViewBag", sendParam);
            mv.setViewName("/expend/ex/user/pop/ExExpendETaxDetailPopup");
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 예실대비 현황 - 선택 팝업 */
    @RequestMapping("/ex/expend/user/ExUserYesilPop.do")
    public ModelAndView ExUserYesilPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 예실대비현황 > 부서,프로젝트,부문 > 선택 팝업 */
        /* iCUBE */
        ModelAndView mv = new ModelAndView();
        try {
            /* 반환값 처리 */
            mv.addObject("budgetFlag", params.get("budgetFlag"));
            mv.addObject("fromDt", params.get("fromDt"));
            mv.addObject("toDt", params.get("toDt"));
            mv.addObject("searchStr", params.get("searchStr"));
            /* View path 정의 */
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERYESILPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 예실대비 현황2(PIVOT) - 예산단위 그룹 선택 팝업 */
    @RequestMapping("/ex/expend/user/ExUserYesil2BudgetGrPop.do")
    public ModelAndView ExUserYesil2BudgetGrPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 예실대비현황2(PIVOT) > 예산단위 선택 팝업 */
        /* ERP iU */
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* ERP 연결정보 조회 */
            ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            /* ERP 회사 코드 확인 */
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());
            result = yesilService.ExUserYesil2SendParam(params);
            /* 반환처리 */
            mv.addObject("ViewBag", result);
            /* View path 정의 */
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERYESIL2BUDGETGRPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 예실대비 현황2(PIVOT) - 예산단위 선택 팝업 */
    @RequestMapping("/ex/expend/user/ExUserYesil2BudgetDeptPop.do")
    public ModelAndView ExUserYesil2BudgetDeptPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 예실대비현황2(PIVOT) > 예산단위 선택 팝업 */
        /* ERP iU */
        ModelAndView mv = new ModelAndView();
        try {
            mv.addObject("authDept", params.get("authDept"));
            /* View path 정의 */
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERYESIL2BUDGETDEPTPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 예실대비 현황2(PIVOT) - 사업계획 선택 팝업 */
    @RequestMapping("/ex/expend/user/ExUserYesil2BizPlanPop.do")
    public ModelAndView ExUserYesil2BizPlanPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 예실대비현황2(PIVOT) > 사업계획 선택 팝업 */
        /* ERP iU */
        ModelAndView mv = new ModelAndView();
        try {
            /* View path 정의 */
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERYESIL2BIZPLANPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* Pop View - 예실대비 현황2(PIVOT) - 예산계정 선택 팝업 */
    @RequestMapping("/ex/expend/user/ExUserYesil2BudgetAcctPop.do")
    public ModelAndView ExUserYesil2BudgetAcctPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        /* 예실대비현황2(PIVOT) > 예산계정 선택 팝업 */
        /* ERP iU */
        ModelAndView mv = new ModelAndView();
        try {
            mv.addObject("cdDeptPipe", params.get("cdDeptPipe"));
            mv.addObject("cdBudgetPipe", params.get("cdBudgetPipe"));
            mv.addObject("cdBizplanPipe", params.get("cdBizplanPipe"));
            mv.addObject("tpAclevel", params.get("tpAclevel"));
            /* View path 정의 */
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.USERYESIL2BUDGETACCTPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* 사용자 작업 실패 내역 팝업 */
    @RequestMapping("/ex/expend/common/ProcessFailPop.do")
    public ModelAndView CmmProcessFailPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* 커스텀레이어 - 프로그레스바 / 실패 팝업 */
        ModelAndView mv = new ModelAndView();
        try {
            mv.addObject("pageTitle", params.get("pageTitle"));
            mv.addObject("colGbn", params.get("colGbn"));
            mv.addObject("colDetail", params.get("colDetail"));
            mv.addObject("colData", params.get("colData"));
            /* View path 정의 */
            mv.setViewName(commonPath.POPPATH + commonPath.PROCESSFAILPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }

    /* 지출결의 가져오기 팝업 호출 */
    @RequestMapping("/ex/expend/user/ExpendHistoryPop.do")
    public ModelAndView ExExpendHistoryPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* 커스텀레이어 - 프로그레스바 / 실패 팝업 */
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ExCommonResultVO commonParam = new ExCommonResultVO();
            List<ExCommonResultVO> commonListCode = new ArrayList<ExCommonResultVO>();
            List<ExCommonResultVO> docStatCode = new ArrayList<ExCommonResultVO>();
            commonParam.setGroupSeq(loginVo.getGroupSeq());
            commonParam.setSearchType(commonCode.DOCSTATUS);
            commonParam.setLangCode(loginVo.getLangCode());
            commonListCode = codeService.ExCodeCommonCodeListInfoSelect(commonParam);
            ExCommonResultVO total = new ExCommonResultVO();
            total.setCommonCode(commonCode.EMPTYSEQ);
            total.setCommonName("전체");
            docStatCode.add(total);
            for (ExCommonResultVO tResult : commonListCode) {
                if (tResult.getCommonCode().equals("20") || tResult.getCommonCode().equals("30") || tResult.getCommonCode().equals("90") || tResult.getCommonCode().equals("100")) {
                    docStatCode.add(tResult);
                }
            }
            /* 명칭설정 반영 */
            String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
            String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
            String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("docStatCode", JSONArray.fromObject(docStatCode));
            mv.addObject("expendSeq", params.get("expendSeq").toString());
            mv.addObject("formSeq", params.get("formSeq").toString());
            mv.addObject("isInsertSlipMode", params.get("isInsertSlipMode").toString());
            /* View path 정의 */
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.EXPENDHISTORYPOP);
        } catch (Exception e) {
            // cmLog.CommonSetError( e );
            throw e;
        }
        return mv;
    }
    /*
     * 법인카드 사용 내역 카드 검색조건 팝업
     *
     * @RequestMapping ( "/ex/expend/user/ExSearchCardListPop.do" ) public ModelAndView ExSearchCardListPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception { Bizbox Alpha ModelAndView mv = new ModelAndView( ); ResultVO result = new ResultVO( ); try { mv.setViewName( commonExPath.USERPOPPATH + commonExPath.ExSearchCardListPop ); } catch ( Exception e ) { // TODO: handle exception } return mv; }
     */

    /* 회계 (사용자) - 지출결의 관리 - 나의 세금계산서 현황(ERPiU) - 계산서 이관 내역 팝업 */
    @RequestMapping("/ex/user/report/ExUserETaxTransferHistoryPop.do")
    public ModelAndView ExUserETaxTransferHistoryPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* Bizbox Alpha */
        ModelAndView mv = new ModelAndView();
        try {
            if (CommonConvert.CommonGetEmpInfo() == null) {
                throw new NotFoundLoginSessionException("로그인 세션 검색 실패");
            }
            Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
            String pCompSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
            String plangCode = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.LANGCODE)));
            String pGroupSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.GROUPSEQ)));
            CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
            mv.addObject("CL", vo.getData());
            mv.addObject("fiEaType", CommonConvert.CommonGetStr(params.get("fiEaType")));

            /* View path 정의 [UserCardReport.jsp] */
            mv.setViewName(commonExPath.USERPOPPATH + commonExPath.EXETAXTRANSFERHISTORYPOP);
        } catch (NotFoundLoginSessionException ex) {
            mv.addObject("errMsg", ex.getMessage());
            mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
        } catch (Exception ex) {
            mv.addObject("errMsg", ex.getMessage());
            mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
        }
        return mv;
    }
}
