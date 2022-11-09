package expend.ex.user.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.helper.ConvertManager;
import cmm.util.CommonUtil;
import common.helper.connection.CommonErpConnect;
import common.helper.convert.CommonConvert;
import common.helper.excel.CommonExcel;
import common.helper.exception.BudgetAmtOverException;
import common.helper.exception.NotFoundErpCardException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.InterlockName;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeBudgetVO;
import common.vo.ex.ExCodeCardVO;
import common.vo.ex.ExCodeETaxVO;
import common.vo.ex.ExCodeOrgVO;
import common.vo.ex.ExCodePartnerVO;
import common.vo.ex.ExCodeProjectVO;
import common.vo.ex.ExCommonResultVO;
import common.vo.ex.ExExpendForeignCurrencyVO;
import common.vo.ex.ExExpendListVO;
import common.vo.ex.ExExpendMngVO;
import common.vo.ex.ExExpendSlipVO;
import common.vo.ex.ExExpendVO;
import common.vo.ex.ExReportCardVO;
import common.vo.ex.ExpendVO;
import common.vo.ex.ERPiU.ERPiUAccSeq;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import expend.ex.cmm.BExCommonService;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.budget.BExBudgetService;
import expend.ex.user.card.BExUserCardService;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.etax.BExUserEtaxService;
import expend.ex.user.expend.BExUserService;
import expend.ex.user.list.BExUserListService;
import expend.ex.user.mng.BExUserMngService;
import expend.ex.user.report.BExUserReportService;
import expend.ex.user.slip.BExUserSlipService;
import expend.ex.user.yesil.BExUserYesilService;
import interlock.exp.approval.BApprovalService;
import net.sf.json.JSONObject;

@Controller
public class BExUserController {

    //
    protected org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    // common service
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    // code service
    @Resource(name = "BExUserCodeService")
    private BExUserCodeService codeService;

    @Resource(name = "BExUserService")
    private BExUserService userService;

    // expend service
    @Resource(name = "BExUserListService")
    private BExUserListService listService;

    @Resource(name = "BExUserSlipService")
    private BExUserSlipService slipService;

    @Resource(name = "BExUserMngService")
    private BExUserMngService mngService;

    @Resource(name = "BExAdminConfigService") /* 환경설정 서비스 */
    private BExAdminConfigService configService;

    // approval service
    @Resource(name = "BApprovalService")
    private BApprovalService approvalService;

    // ext service
    @Resource(name = "BExBudgetService")
    private BExBudgetService budgetService;

    @Resource(name = "BExUserCardService")
    private BExUserCardService userCardService;

    @Resource(name = "BExUserEtaxService")
    private BExUserEtaxService eTaxService;

    // report service
    @Resource(name = "BExUserReportService")
    private BExUserReportService userReportService;

    @Resource(name = "BExUserYesilService")
    private BExUserYesilService userYesilService;

    @Resource(name = "BExCommonService")
    private BExCommonService exCommonService;

    /* Biz - 지출결의 - 초기화 */
    @RequestMapping("/ex/expend/master/ExUserInitExpend.do")
    public ModelAndView ExUserInitExpendSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            Map<String, Object> result = new HashMap<String, Object>();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();

            // TODO: 설명 기록
            try {
                result = userService.ExUserInitExpendSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserInitExpend.do >> userService.ExUserInitExpendSelect(params)", params);
                throw new Exception(e);
            }


            // TODO: 설명 기록
            mv.addObject("aaData", result);
            mv.addObject("eaType", loginVo.getEaType());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
            ExpInfo.TipLog("BExUserService.ExUserInitExpendSelect 호출 오류 발생", params);
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 지출결의 - 생성 */
    @RequestMapping("/ex/expend/master/ExUserExpendInfoInsert.do")
    public ModelAndView ExUserExpendInfoInsert(@ModelAttribute ExpendVO expendVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            ExpendVO result = new ExpendVO();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            Map<String, Object> params = new HashMap<String, Object>();

            // TODO: 설명 기록
            try {
                // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                result = userService.ExUserExpendInfoInsert(expendVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserExpendInfoInsert.do >> result = userService.ExUserExpendInfoInsert(expendVo);", expendVo);
                throw new Exception(e);
            }

            // TOOD : 설명 기록
            String listSeq = "0";
            params.put("compSeq", result.getCompSeq());
            params.put("formSeq", result.getFormSeq());
            params.put("useSw", conVo.getErpTypeCode());
            params.put("optionCode", "001001");
            ResultVO expendOption = new ResultVO();

            try {
                expendOption = configService.ExAdminConfigOptionSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserExpendInfoInsert.do >> configService.ExAdminConfigOptionSelect(params);", params);
                throw new Exception(e);
            }

            if (expendOption != null && expendOption.getAaData().size() > 0) {
                if (expendOption.getAaData().get(0).get("set_value").toString().indexOf("L") == -1) {
                    /* 분개단위 입력인 경우 기본 항목 생성 */
                    ExExpendListVO listVo = new ExExpendListVO();
                    listVo.setCompSeq(result.getCompSeq());
                    listVo.setExpendSeq(result.getExpendSeq());
                    listVo = listService.ExListInfoInsert(listVo);
                    listSeq = "1";
                }
            }

            mv.addObject("listSeq", listSeq);
            mv.addObject("aaData", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 지출결의 - 삭제 */
    @RequestMapping("/ex/expend/master/ExUserExpendInfoDelete.do")
    public ModelAndView ExUserExpendInfoDelete(@ModelAttribute ExpendVO expendVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            ResultVO result = new ResultVO();

            // TODO : 설명 기록
            result = userService.ExUserExpendInfoDelete(expendVo);
            mv.addObject("aaData", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserExpendInfoDelete.do >> userService.ExUserExpendInfoDelete(expendVo);", expendVo);
            throw new Exception(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 지출결의 - 수정 */
    @RequestMapping("/ex/expend/master/ExUserExpendInfoUpdate.do")
    public ModelAndView ExUserExpendInfoUpdate(@ModelAttribute ExpendVO expendVo, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            ResultVO result = new ResultVO();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ExpendVO basicExpend = new ExpendVO();
            StringBuilder changeInfo = new StringBuilder();

            try {
                // TODO : 설명 기록
                basicExpend = userService.ExUserExpendInfoSelect(expendVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserExpendInfoUpdate.do >> userService.ExUserExpendInfoSelect(expendVo);", expendVo);
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록
                result = userService.ExUserExpendInfoUpdate(expendVo);
                mv.addObject("aaData", result);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserExpendInfoUpdate.do >> userService.ExUserExpendInfoUpdate(expendVo);", expendVo);
                throw new Exception(e);
            }

            if (!basicExpend.getExpendDate().equals(expendVo.getExpendDate())) {
                changeInfo.append("[변경] 회계일자 변경 >> 이전정보 : ");
                changeInfo.append(basicExpend.getExpendDate());
                changeInfo.append("/변경정보 : ");
                changeInfo.append(expendVo.getExpendDate());
                changeInfo.append(System.getProperty("line.separator"));

                ExpInfo.ProcessLog("사용자에 의해 지출결의 회계일자가 변경되었습니다.(" + basicExpend.getExpendDate() + " >> " + expendVo.getExpendDate() + ")", expendVo);
            }

            if (!basicExpend.getExpendReqDate().equals(expendVo.getExpendReqDate())) {
                changeInfo.append("[변경] 지급요청일자 변경 >> 이전정보 : ");
                changeInfo.append(basicExpend.getExpendReqDate());
                changeInfo.append("/변경정보 : ");
                changeInfo.append(expendVo.getExpendReqDate());
                changeInfo.append(System.getProperty("line.separator"));

                ExpInfo.ProcessLog("사용자에 의해 지출결의 지급요청일자가 변경되었습니다.(" + basicExpend.getExpendReqDate() + " >> " + expendVo.getExpendReqDate() + ")", expendVo);
            }

            try {
                // TODO : 설명 기록
                ExCommonInterlockUpdate(expendVo.getExpendSeq(), loginVo, params, request, changeInfo.toString());
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserExpendInfoUpdate.do >> ExCommonInterlockUpdate(expendVo.getExpendSeq(), loginVo, params, request, changeInfo.toString());", expendVo);
                throw new Exception(e);
            }
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 지출결의 - 조회 */
    @RequestMapping("/ex/expend/master/ExUserExpendInfoSelect.do")
    public ModelAndView ExUserExpendInfoSelect(@ModelAttribute ExpendVO expendVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            Map<String, Object> result = new HashMap<String, Object>();

            try {
                // TODO : 설명 기록
                result = userService.ExUserExpendLoadInfo(expendVo);
                mv.addObject("aaData", result);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserExpendInfoSelect.do >> userService.ExUserExpendLoadInfo(expendVo);", expendVo);
                throw new Exception(e);
            }
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
            mv.addObject("aaData", new HashMap<String, Object>());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 지출결의 - 관리항목 오류체크 */
    @RequestMapping("/ex/expend/master/ExUserErrorInfoSelect.do")
    public ModelAndView ExUserErrorInfoSelect(@ModelAttribute ExExpendVO expendVo, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            List<ExCommonResultVO> resultListVo = new ArrayList<ExCommonResultVO>();
            Map<String, Object> sendParam = new HashMap<String, Object>();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	e.printStackTrace();
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록
                expendVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), expendVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserErrorInfoSelect.do >> expendVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), expendVo.getCompSeq()));", conVo.getErpTypeCode());
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록
                sendParam = CommonConvert.CommonSetMapCopy(params, sendParam);
                sendParam.put("compSeq", expendVo.getCompSeq());
                sendParam.put("formSeq", expendVo.getFormSeq());
                sendParam.put("useSw", conVo.getErpTypeCode());
                sendParam.put("expendSeq", expendVo.getExpendSeq());
                resultListVo = userService.ExUserExpendErrorInfoList(expendVo, sendParam);

                mv.addObject("aaData", resultListVo);
            } catch (Exception e) {
            	e.printStackTrace();
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserErrorInfoSelect.do >> userService.ExUserExpendErrorInfoList(expendVo, sendParam);", sendParam);
                throw new Exception(e);
            }
        } catch (NotFoundLoginSessionException e) {
        	e.printStackTrace();
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
        	e.printStackTrace();
            logger.error(e);
            mv.addObject("aaData", new ArrayList<ExCommonResultVO>());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 지출결의 - 예산 초과체크 */
    @RequestMapping("/ex/expend/master/ExUserBudgetOverInfoSelect.do")
    public ModelAndView ExUserBudgetOverInfoSelect(@ModelAttribute ExExpendVO expendVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            List<ExCommonResultVO> resultListVo = new ArrayList<ExCommonResultVO>();

            try {
                // TODO : 설명 기록
                resultListVo = budgetService.ExBudgetErrorInfoSelect(expendVo);
                mv.addObject("aaData", resultListVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExUserBudgetOverInfoSelect.do >> budgetService.ExBudgetErrorInfoSelect(expendVo);", expendVo);
                throw new Exception(e);
            }

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
            mv.addObject("aaData", new ArrayList<ExCommonResultVO>());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 지출결의 현황 - 목록 조회 */
    @RequestMapping(value = "/expend/ex/user/ExUserExpendReportListInfoSelect.do", method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView ExUserExpendReportListInfoSelect(@RequestBody Map<String, Object> params, HttpServletRequest request) throws Exception {
        // parameters ( params ) : appDocNo, appDocTitle, appRepDate, bizCd, compSeq, docSeq, empSeq, endPosition, erpCompSeq, expendAmt, expendDate, expendEmpSeq, expendErpAdocuNumber, expendErpSendName, expendErpSendSeq, expendErpSendYn, expendErpiuAdocuId, expendIcubeAdocuId, expendIcubeAdocuSeq, expendReqDate, expendSeq, expendUseDeptName, expendUseEmpName, formName, page, pageSize, searchDocFromDate, searchDocStatus, searchDocToDate, searchFromDate, searchReqFromDate, searchReqToDate, searchToDate, sortField, sortType, startPosition

        ModelAndView mv = new ModelAndView();

        try {
            ResultVO resultVo = new ResultVO();
            params.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpVO().getGroupSeq());

            try {
                // TODO : 설명 기록
                resultVo = userReportService.ExUserExpendReportListInfoNewSelect(params);

                mv.addObject("aaData", resultVo.getaData().get("aaData"));
                mv.addObject("totalCount", resultVo.getaData().get("aaDataTotalSize"));
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/ExUserExpendReportListInfoSelect.do >> userReportService.ExUserExpendReportListInfoNewSelect(params);", params);
                throw new Exception(e);
            }
        } catch (Exception e) {
            logger.error(e);
            mv.addObject("aaData", new ArrayList<HashMap<String, Object>>());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 나의 지출결의 상세 현황 - 이준성 */
    @RequestMapping("/expend/ex/user/ExUserSlipExpendReportListInfoSelect.do")
    public ModelAndView ExUserExpendSlipListInfoSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
      ModelAndView mv = new ModelAndView();

      try {
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ResultVO resultVo = new ResultVO();

        param.put(commonCode.COMPSEQ, loginVo.getCompSeq());

        resultVo = userReportService.ExUserExpendSlipReportListInfoSelect(param);

        mv.setViewName("jsonView");
        mv.addObject("aData", resultVo.getaData());
        mv.addObject("result", resultVo);

      } catch (Exception e) {
        logger.error(e);
        throw e;
      }

      return mv;
    }



    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 나의 카드 사용 현황 - 목록 조회 */
    @RequestMapping("/expend/ex/user/ExUserCardReportListInfoSelect.do")
    public ModelAndView ExUserCardReportListInfoSelect(@ModelAttribute ExReportCardVO reportCardVO, @RequestParam(defaultValue = "1") String page, @RequestParam(defaultValue = "10") String pageSize, HttpServletRequest request) throws Exception {
        /* parameter : fromDate, toDate, compSeq, empSeq, searchCardNum, searchCardName */

        ModelAndView mv = new ModelAndView();

        try {
            ResultVO resultVo = new ResultVO();
            PaginationInfo paginationInfo = new PaginationInfo();

            paginationInfo.setCurrentPageNo(EgovStringUtil.zeroConvert(page));
            paginationInfo.setPageSize(EgovStringUtil.zeroConvert(pageSize));
            reportCardVO.setLangCode(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE)));

            try {
                // 나의카드사용현황 목록 조회
                resultVo = userReportService.ExUserCardReportListInfoSelect(reportCardVO, paginationInfo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/ExUserCardReportListInfoSelect.do >> userReportService.ExUserCardReportListInfoSelect(params, paginationInfo);", reportCardVO);
                throw new Exception(e);
            }

            mv.addObject("result", resultVo);
        } catch (Exception e) {
            logger.error(e);
            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 공통코드 */
    /* Biz - 공통코드 - 표준적요 */
    /* Biz - 공통코드 - 표준적요 - 목록 조회 */
    @RequestMapping("/expend/user/code/ExUserSummaryListInfoSelect.do")
    public ModelAndView ExUserSummaryListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        // 사용되는지 확인 필요
        ExpInfo.CallCheckLog("/expend/user/code/ExUserSummaryListInfoSelect.do", params);

        try {
            ResultVO result = new ResultVO();
            mv.addObject("result", result);
        } catch (Exception e) {
            ExpInfo.CLog("[에러발생] /expend/user/code/ExUserSummaryListInfoSelect.do >> ", params);
            logger.info(e);
            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 공통코드 - 증빙유형 */
    /* Biz - 공통코드 - 증빙유형 - 목록 조회 */
    @RequestMapping("/expend/user/code/ExUserAuthListInfoSelect.do")
    public ModelAndView ExUserAuthListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        // 사용되는지 확인 필요
        ExpInfo.CallCheckLog("/expend/user/code/ExUserAuthListInfoSelect.do", params);

        try {
            ResultVO result = new ResultVO();

            /* result = codeService.ExUserAuthListInfoSelect(params); */
            mv.addObject("result", result);
        } catch (Exception e) {
            ExpInfo.CLog("[에러발생] /expend/user/code/ExUserAuthListInfoSelect.do >> ", params);
            logger.info(e);
            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 공통코드 - 프로젝트 */
    /* Biz - 공통코드 - 프로젝트 - 목록 조회 */
    @RequestMapping("/expend/user/code/ExUserProjectListInfoSelect.do")
    public ModelAndView ExUserProjectListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        // 사용되는지 확인 필요
        ExpInfo.CallCheckLog("/expend/user/code/ExUserProjectListInfoSelect.do", params);

        try {
            ResultVO result = new ResultVO();

            /* result = codeService.ExUserProjectListInfoSelect(params); */
            mv.addObject("result", result);
        } catch (Exception e) {
            logger.error(e);
            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 공통코드 - 거래처 */
    /* Biz - 공통코드 - 거래처 - 목록 조회 */
    @RequestMapping("/expend/user/code/ExUserPartnerListInfoSelect.do")
    public ModelAndView ExUserPartnerListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        // 사용되는지 확인 필요
        ExpInfo.CallCheckLog("/expend/user/code/ExUserPartnerListInfoSelect.do", params);

        try {
            ResultVO result = new ResultVO();

            /* result = codeService.ExUserPartnerListInfoSelect(params); */
            mv.addObject("result", result);
        } catch (Exception e) {
            ExpInfo.CLog("[에러발생] /expend/user/code/ExUserPartnerListInfoSelect.do >> ", params);
            logger.error(e);
            mv.addObject("result", new ModelAndView());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 공통코드 - 카드 */
    /* Biz - 공통코드 - 카드 - 목록 조회 */
    @RequestMapping("/expend/user/code/ExUserCardListInfoSelect.do")
    public ModelAndView ExUserCardListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        // 사용되는지 확인 필요
        ExpInfo.CallCheckLog("/expend/user/code/ExUserCardListInfoSelect.do", params);

        try {
            ResultVO result = new ResultVO();

            /* result = codeService.ExUserCardListInfoSelect(params); */
            mv.addObject("result", result);
        } catch (Exception e) {
            ExpInfo.CLog("[에러발생] /expend/user/code/ExUserCardListInfoSelect.do >> ", params);
            logger.error(e);
            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* Biz - 공통코드 - 자체예산 */
    /* Biz - 공통코드 - 자체예산 - 예산 조회 */
    @RequestMapping("/expend/ex/user/budget/ExBudgetInfoSelect.do")
    public ModelAndView ExBudgetInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        // 사용되는지 확인 필요
        ExpInfo.CallCheckLog("/expend/ex/user/budget/ExBudgetInfoSelect.do", params);

        try {
            List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
            mv.addObject("result", listMap);
        } catch (Exception e) {
            ExpInfo.CLog("[에러발생] /expend/ex/user/budget/ExBudgetInfoSelect.do >> ", params);
            logger.error(e);
            mv.addObject("result", new ArrayList<Map<String, Object>>());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 공통 코드 조회 영역 ------------------------- */
    /* 공통 코드 조회 - 모든 코드 조회 공통사용 */
    @RequestMapping("/expend/ex/user/code/ExCodeInfoSelect.do")
    public ModelAndView ExCodeInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        // 사용되는지 확인 필요
        ExpInfo.CallCheckLog("/expend/ex/user/code/ExCodeInfoSelect.do", params);

        try {
            ResultVO result = new ResultVO();

            params.put(commonCode.FORMSEQ, params.get(commonCode.FORMSEQ) == null ? commonCode.EMPTYSTR : params.get(commonCode.FORMSEQ));
            params.put("searchStr", CommonConvert.CommonConvertSpecialCharaterForJava(params.get("searchStr").toString()));

            try {
                // TODO : 설명 기록
                result = codeService.ExCommonCodeInfoSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/code/ExCodeInfoSelect.do >> codeService.ExCommonCodeInfoSelect(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);
        } catch (Exception e) {
            logger.error(e);
            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 예산 확인 */
    @SuppressWarnings("unused")
    @RequestMapping("/expend/ex/user/code/ExCodeBudgetAmtInfoSelect.do")
    public ModelAndView ExCodeBudgetAmtInfoSelect(@ModelAttribute ExCodeBudgetVO budgetVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();

            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
                // 2019. 07. 25. 김상겸. groupSeq 추가
                budgetVo.setGroupSeq(loginVo.getGroupSeq());
                budgetVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), budgetVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/code/ExCodeBudgetAmtInfoSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), budgetVo.getCompSeq())", budgetVo);
                throw new Exception(e);
            }

            if (!CommonConvert.CommonGetStr(conVo.getErpTypeCode()).equals(commonCode.BIZBOXA)) {
                try {
                    // TODO : 설명 기록
                    budgetVo = codeService.ExCodeBudgetAmtInfoSelect(budgetVo, conVo);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /expend/ex/user/code/ExCodeBudgetAmtInfoSelect.do >> codeService.ExCodeBudgetAmtInfoSelect(budgetVo, conVo);", budgetVo);
                    throw new Exception(e);
                }
            } else {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception("Not Defined Connect ERP..");
            }

            mv.addObject("aaData", budgetVo);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);

            budgetVo.setBudgetJsum(commonCode.EMPTYSEQ); /* 예산편성금액 ( 편성 + 조정 ) */
            budgetVo.setBudgetActsum(commonCode.EMPTYSEQ); /* 결의집행금액 ( 임시보관 ~ ERP미전송, 자동전표, 승인전표 ) */
            budgetVo.setBudgetControlYN(commonCode.EMPTYNO); /* 예산통제여부 */
            mv.addObject("aaData", budgetVo);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 카드 조회 영역 ------------------------- */
    /*  */
    @RequestMapping("/expend/ex/user/card/ExCardListInfoSelect.do")
    public ModelAndView ExCardListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            List<Map<String, Object>> returnMap = new ArrayList<Map<String, Object>>();

            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);

            params.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            params.put(commonCode.DEPTSEQ, loginVo.getOrgnztId());
            params.put(commonCode.EMPSEQ, loginVo.getUniqId());
            params.put(commonCode.SEARCHSTR, params.get("searchStr").toString());
            params.put("serachFromDate", params.get("searchFromDate").toString().replaceAll("-", commonCode.EMPTYSTR));
            params.put("serachToDate", params.get("searchToDate").toString().replaceAll("-", commonCode.EMPTYSTR));
            params.put("isSearchWithCancel", CommonConvert.CommonGetStr(params.get("isSearchWithCancel")));

            try {
                returnMap = userCardService.ExExpendEmpCardListInfoSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/card/ExCardListInfoSelect.do >> userCardService.ExExpendEmpCardListInfoSelect(params);", params);
                throw new Exception(e);
            }

            mv.addObject("aaData", returnMap);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ArrayList<Map<String, Object>>());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ArrayList<Map<String, Object>>());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    @RequestMapping("/expend/ex/user/card/ExCardInfoMapUpdate.do")
    public ModelAndView ExCardInfoMㅇapUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            ExCommonResultVO resultVo = new ExCommonResultVO();
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록
                resultVo = userCardService.ExExpendCardInfoMapUpdate(params, conVo, loginVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/card/ExCardInfoMapUpdate.do >> userCardService.ExExpendCardInfoMapUpdate(param, conVo, loginVo);", params);
                throw new Exception(e);
            }

            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
            mv.addObject("aaData", resultVo);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject(commonCode.IFSYSTEM, "");
            mv.addObject("aaData", new ExCommonResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject(commonCode.IFSYSTEM, "");
            mv.addObject("aaData", new ExCommonResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    @RequestMapping("/expend/ex/user/card/ExCardInfoMake.do")
    public ModelAndView ExCardInfoMake(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            ExCommonResultVO resultVo = new ExCommonResultVO();
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);

            try {
                // TODO : 설명 기록
                resultVo = userCardService.ExCardInfoMake(params, conVo, loginVo);
            } catch (BudgetAmtOverException e) {
                throw e;
            } catch (Exception e) {
                throw e;
            }

            try {
                // 결재 중 지출결의 수정 기능
                ExCommonInterlockUpdate(resultVo.getExpendSeq(), loginVo, params, request, "카드 내역 추가 (listSeq:" + resultVo.getListSeq() + ")");
            } catch (BudgetAmtOverException e) {
                throw e;
            } catch (Exception e) {
                throw e;
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (BudgetAmtOverException e) {
            logger.error(e);

            ExCommonResultVO resultVo = new ExCommonResultVO();
            resultVo.setCode(CommonInterface.commonCode.FAIL);
            resultVo.setError(e.getMessage());

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            ExCommonResultVO resultVo = new ExCommonResultVO();
            resultVo.setCode(CommonInterface.commonCode.FAIL);
            resultVo.setError(e.getMessage());

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (NotFoundErpCardException e) {
            logger.error(e);
            ExCommonResultVO resultVo = new ExCommonResultVO();
            resultVo.setCode(CommonInterface.commonCode.FAIL);
            resultVo.setError(e.getLocalizedMessage());

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);
            ExCommonResultVO resultVo = new ExCommonResultVO();
            resultVo.setCode(CommonInterface.commonCode.FAIL);
            //resultVo.setError("오류가 발생되었습니다.");
            resultVo.setError(e.getMessage());

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    @RequestMapping("/expend/ex/user/card/ExReportCardDetailInfo.do")
    public ModelAndView ExReportCardDetailInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCodeCardVO cardVo = new ExCodeCardVO();
            Map<String, Object> sendParam = new HashMap<String, Object>();

            params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
            cardVo.setSyncId(params.get("sync_id").toString());

            try {
                // TODO : 설명 기록
                cardVo = userCardService.ExReportCardDetailInfoSelect(cardVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/card/ExReportCardDetailInfo.do >> userCardService.ExReportCardDetailInfoSelect(cardVo);", cardVo);
                throw new Exception(e);
            }

            sendParam.put("cardDetailInfo", ConvertManager.ConvertMapToJson(ConvertManager.ConverObjectToMap(cardVo)));

            mv.addObject("aaData", params);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", params);
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 카드사용내역 - 카드정보 검색 */
    @RequestMapping("/expend/ex/user/card/ExExpendUserCardInfoSelect.do")
    public ModelAndView ExExpendUserCardInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            PaginationInfo paginationInfo = new PaginationInfo();

            paginationInfo.setCurrentPageNo(EgovStringUtil.zeroConvert(params.get("page")));
            paginationInfo.setPageSize(EgovStringUtil.zeroConvert(params.get("pageSize")));

            params.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            params.put(commonCode.DEPTSEQ, loginVo.getOrgnztId());
            params.put(commonCode.EMPSEQ, loginVo.getUniqId());

            try {
                // TODO : 설명 기록
                result = userCardService.ExExpendUserCardInfoSelect(params, paginationInfo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/card/ExExpendUserCardInfoSelect.do >> userCardService.ExExpendUserCardInfoSelect(params, paginationInfo);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);
            mv.addObject("totalCount", result.getAaData().size());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
            mv.addObject("totalCount", 0);
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
            mv.addObject("totalCount", 0);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 사용자 등록 */
    @RequestMapping("/ex/user/expend/master/ExpendEmpInfoInsert.do")
    public ModelAndView ExExpendEmpInfoInsert(@ModelAttribute ExCodeOrgVO orgVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            orgVo.setGroupSeq(loginVo.getGroupSeq()); // 2019. 06. 10. 그룹시퀀스 미지정 확인으로 기본값 정
            orgVo.setCreateSeq(loginVo.getUniqId());
            orgVo.setModifySeq(loginVo.getUniqId());

            if (orgVo.getEmpName().equals(commonCode.EMPTYSTR) || orgVo.getErpEmpSeq().contentEquals(commonCode.EMPTYSTR)) {
                // 사용자 정보가 완전하지 않은경우, 데이터를 조회하여 처리
                if (conVo.getErpTypeCode().equals(commonCode.ICUBE) || conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                    orgVo.setSearchStr(orgVo.getErpEmpSeq());
                } else {
                    throw new Exception("[기타알림] ERP 연동설정을 확인해주세요.");
                }

                ResultVO result = new ResultVO();
                Map<String, Object> tUser = new HashMap<String, Object>();
                tUser = CommonConvert.CommonGetObjectToMap(orgVo);
                tUser.put("codeType", "EMPONE");

                try {
                    // TODO : 설명 기록
                    result = codeService.ExCommonCodeInfoSelect(tUser);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/master/ExpendEmpInfoInsert.do >> codeService.ExCommonCodeInfoSelect(tUser);", tUser);
                    throw new Exception(e);
                }

                if (result.getAaData().size() > 0) {
                    if (!orgVo.getErpEmpSeq().equals(commonCode.EMPTYSTR)) {
                        orgVo = (ExCodeOrgVO) CommonConvert.CommonGetMapToObject(result.getAaData().get(0), orgVo);
                    } else {
                        throw new Exception("ERP 연동된 사용자 정보를 확인할 수 없습니다. 사원번호 정상 연동설정여부 확인 및 ERP 조직도 정상 사원등록여부를 점검해야합니다.");
                    }
                } else {
                    throw new Exception("ERP 연동된 사용자 정보를 확인할 수 없습니다. 사원번호 정상 연동설정여부 확인 및 ERP 조직도 정상 사원등록여부를 점검해야합니다.");
                }
            }

            try {
                // TODO : 설명 기록
                orgVo = codeService.ExExpendEmpInfoInsert(orgVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/master/ExpendEmpInfoInsert.do >> codeService.ExExpendEmpInfoInsert(orgVo);", orgVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", orgVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCodeOrgVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCodeOrgVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 사용자 수정 */
    @RequestMapping("/ex/user/expend/master/ExpendEmpInfoUpdate.do")
    public ModelAndView ExExpendEmpInfoUpdate(@ModelAttribute ExCodeOrgVO orgVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            orgVo.setCreateSeq(loginVo.getUniqId());
            orgVo.setModifySeq(loginVo.getUniqId());

            try {
                // TODO : 설명 기록 (기존 주석 : 등록)
                resultVo = codeService.ExExpendEmpInfoUpdate(orgVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/master/ExpendEmpInfoUpdate.do >> codeService.ExExpendEmpInfoUpdate(orgVo);", orgVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 프로젝 등록 수정 */
    @RequestMapping("/ex/user/expend/master/fnExpendProjectInsert_Update.do")
    public ModelAndView fnExpendProjectInsert_Update(@ModelAttribute ExCodeProjectVO resultVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ConnectionVO conVo = new ConnectionVO();

            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록 (기존 주석 : 등록)
                resultVo = codeService.fnExpendProjectInsert_Update(resultVo);


            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/master/ExpendEmpInfoUpdate.do >> codeService.ExExpendEmpInfoUpdate(orgVo);", resultVo);
                throw new Exception(e);
            }


        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }
        return mv;
    }

    /* 지출결의 - partner 등록 수정 */
    @RequestMapping("/ex/user/expend/master/fnExpendPartnerInsert_Update.do")
    public ModelAndView fnExpendPartnerInsert_Update(@ModelAttribute ExCodePartnerVO resultVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ConnectionVO conVo = new ConnectionVO();

            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록 (기존 주석 : 등록)
                resultVo = codeService.fnExpendPartnerInsert_Update(resultVo);


            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/master/ExpendEmpInfoUpdate.do >> codeService.ExExpendEmpInfoUpdate(orgVo);", resultVo);
                throw new Exception(e);
            }


        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }
        return mv;
    }

    /* 지출결의 - card 등록 수정 */
    @RequestMapping("/ex/user/expend/master/fnExpendCardInsert_Update.do")
    public ModelAndView fnExpendCardInsert_Update(@ModelAttribute ExCodeCardVO resultVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ConnectionVO conVo = new ConnectionVO();

            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록 (기존 주석 : 등록)
                resultVo = codeService.fnExpendCardInsert_Update(resultVo);


            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/master/ExpendEmpInfoUpdate.do >> codeService.ExExpendEmpInfoUpdate(orgVo);", resultVo);
                throw new Exception(e);
            }


        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }
        return mv;
    }


    /* 지출결의 - 지출결의 항목 목록 조회 */
    @RequestMapping("/ex/user/expend/list/ListGridInfoSelect.do")
    public ModelAndView ExListGridInfoSelect(@ModelAttribute ExExpendListVO listVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	e.printStackTrace();
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

            listVo.setGroupSeq(loginVo.getGroupSeq());

            try {
                // TODO : 설명 기록 (기존 주석 : ERP 회사 코드 확인)
                listVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), listVo.getCompSeq()));
            } catch (Exception e) {
            	e.printStackTrace();
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListGridInfoSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), listVo.getCompSeq())", loginVo);
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록 (기존 주석 : 조회)
                result = listService.ExListGridInfoSelect(listVo);
            } catch (Exception e) {
            	e.printStackTrace();
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListGridInfoSelect.do >> listService.ExListGridInfoSelect(listVo);", listVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", result);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
        	e.printStackTrace();
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
        	e.printStackTrace();
            logger.error(e);

            mv.addObject("aaData", new ArrayList<Map<String, Object>>());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 목록 조회 */
    @RequestMapping("/ex/user/expend/slip/SlipGridInfoSelect.do")
    public ModelAndView ExSlipGridInfoSelect(@ModelAttribute ExExpendSlipVO slipVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

            slipVo.setGroupSeq(loginVo.getGroupSeq());

            try {
                // TODO : 설명 기록 (기존 주석 : ERP 회사 코드 확인)
                slipVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), slipVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipGridInfoSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), slipVo.getCompSeq())", loginVo.getCompSeq());
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록 (기존 주석 : 조회)
                result = slipService.ExSlipGridInfoSelect(slipVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipGridInfoSelect.do >> slipService.ExSlipGridInfoSelect(slipVo);", slipVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", result);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ArrayList<Map<String, Object>>());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ArrayList<Map<String, Object>>());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 처리 */
    @RequestMapping("/ex/user/expend/list/ListInfoMake.do")
    public ModelAndView ExListInfoMake(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            try {
                // TODO : 설명 기록 (기존 주석 : 지출결의 항목 분개 처리)
                resultVo = listService.ExListInfoMake(loginVo, params, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoMake.do >> listService.ExListInfoMake(loginVo, params, conVo);", params);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 처리 수정( 결재 진행중 ) */
    @RequestMapping("/ex/user/expend/list/ListInfoMakeUpdateApproval.do")
    public ModelAndView ExListInfoMakeUpdateApproval(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            Map<String, Object> formInfo = new HashMap<String, Object>();
            Map<String, Object> interlockParam = new HashMap<String, Object>();

            try {
                // TODO : 지출결의 항목 분개 처
                resultVo = listService.ExListInfoMakeUpdateApproval(loginVo, params, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoMakeUpdateApproval.do >> listService.ExListInfoMakeUpdateApproval(loginVo, params, conVo);", params);
                throw new Exception(e);
            }

            // 양식 정보 적용
            formInfo = CommonConvert.CommonGetJSONToMap(params.get("formInfo").toString());

            // 인터락 정보 덥데이트를 위한 변수 적용 ( resultVo에는 docSeq가 없어 code에 담아준다 )
            interlockParam.put(commonCode.PROCESSID, formInfo.get("formDTp").toString());
            interlockParam.put(commonCode.APPROKEY, formInfo.get("formDTp").toString() + "_EX_" + resultVo.getExpendSeq());

            interlockParam.put(commonCode.INTERLOCKNAME, InterlockName.PREVIOUSBUTTONKR.toString());
            interlockParam.put(commonCode.INTERLOCKNAMEEN, InterlockName.PREVIOUSBUTTONEN.toString());
            interlockParam.put(commonCode.INTERLOCKNAMEJP, InterlockName.PREVIOUSBUTTONJP.toString());
            interlockParam.put(commonCode.INTERLOCKNAMECN, InterlockName.PREVIOUSBUTTONKR.toString());

            interlockParam.put(commonCode.DOCSEQ, resultVo.getCode());
            interlockParam.put(commonCode.FORMSEQ, formInfo.get("formSeq").toString());
            interlockParam.put("header", commonCode.EMPTYSTR);
            interlockParam.put("content", commonCode.EMPTYSTR);
            interlockParam.put("footer", commonCode.EMPTYSTR);
            interlockParam.put(commonCode.EXPENDSEQ, resultVo.getExpendSeq());
            interlockParam.put("eapCallDomain", CommonConvert.CommonGetStr((params == null ? "" : params.get("eapCallDomain"))));

            try {
                // TODO : 설명 기록
                this.ExDocMake(interlockParam, request);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoMakeUpdateApproval.do >> ExDocMake(interlockParam, request);", interlockParam);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 처리 수정 */
    @RequestMapping("/ex/user/expend/list/ListInfoMakeUpdate.do")
    public ModelAndView ExListInfoMakeUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            try {
                // TODO : 설명 기록 (이전 주석 : 지출결의 항목 분개 처리)
                resultVo = listService.ExListInfoMakeUpdate(loginVo, params, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoMakeUpdate.do >> listService.ExListInfoMakeUpdate(loginVo, params, conVo);", params);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 목록 삭제 */
    @RequestMapping("/ex/user/expend/list/ListInfoDelete.do")
    public ModelAndView ExListListInfoDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExpendVO expendVo = new ExpendVO();
            ExCommonResultVO resultVo = new ExCommonResultVO();

            Map<String, Object> budgetParam = new HashMap<String, Object>();

            List<ExExpendListVO> listListVo = new ArrayList<ExExpendListVO>();
            List<Map<String, Object>> listParam = new ArrayList<Map<String, Object>>();

            String deleteListSeqInfo = commonCode.EMPTYSTR; /* 종결문서 수정시 변경 내역 저장을 위한 변수 */

            // TODO : 설명 기록 (이전 주석 : 초기값 지정)
            listParam = ConvertManager.ConvertJsonToListMap((String) params.get("listListVo"));
            for (Map<String, Object> map : listParam) {
                ExExpendListVO listVo = new ExExpendListVO();
                ConvertManager.ConvertMapToObject(map, listVo);
                listVo.setCompSeq(loginVo.getCompSeq());
                listListVo.add(listVo);
            }

            // TODO : 설명 기록 (이전 주석 : 결재중 수정인 경우 삭제 전)
            expendVo.setExpendSeq(listListVo.get(0).getExpendSeq());

            try {
                // TODO : 설명 기록
                expendVo = userService.ExUserExpendInfoSelect(expendVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoDelete.do >> userService.ExUserExpendInfoSelect(expendVo);", expendVo);
                throw new Exception(e);
            }

            // TODO : 설명 기록
            if (!expendVo.getExpendStatCode().equals(commonCode.EMPTYSTR) && !expendVo.getExpendStatCode().equals("999") && !expendVo.getErpSendYN().equals(commonCode.EMPTYYES)) {
                // expend_stat_code != "" && expend_stat_code != "999" && erp_send_yn != "Y"
                // 상신된 상태 && 삭제가 아닌 상태 && 임시보관이 아닌 상태 && ERP 전송되지 않은 상태
                if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                    budgetParam.put(commonCode.DOCSEQ, expendVo.getDocSeq());
                    budgetParam.put(commonCode.EXPENDSEQ, expendVo.getExpendSeq());
                    budgetParam.put("newListSeq", listListVo);
                    budgetParam.put("isEditList", false);

                    try {
                        budgetService.ExInterLockERPiURowDelete(budgetParam);
                        ExpInfo.CoreLogNotLoop("[ERPiU] 예신연동 정보가 삭제", budgetParam);
                    } catch (Exception e) {
                        ExpInfo.CoreLogNotLoop("[ERPiU] 예산삭제 실패.. ( 예산연동 미사용일 수 있습니다. )", budgetParam);
                        ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoDelete.do >> budgetService.ExInterLockERPiURowDelete(budgetParam);", budgetParam);
                    }
                } else {
                    ExpInfo.ProcessLog("[iCUBE] 예신연동 정보가 삭제되지 않습니다.", expendVo);
                }

                // 매입전자세금계산서, 카드 전송여부 수정
                for (ExExpendListVO tList : listListVo) {

                    try {
                        listService.ExInterfaceInfoUpdate(tList);
                        ExpInfo.CoreLogNotLoop("[iCUBE / ERPiU] 항목기준 매입전자세금계산서, 카드 전송여부 수정 진행", tList);
                    } catch (Exception e) {
                        ExpInfo.CoreLogNotLoop("[iCUBE / ERPiU] 항목기준 매입전자세금계산서, 카드 전송여부 수정 실패..", tList);
                    }

                    try {
                        slipService.ExInterfaceInfoUpdate(tList);
                        ExpInfo.CoreLogNotLoop("[iCUBE / ERPiU] 분개기준 매입전자세금계산서, 카드 전송여부 수정 진행", tList);
                    } catch (Exception e) {
                        ExpInfo.CoreLogNotLoop("[iCUBE / ERPiU] 분개기준 매입전자세금계산서, 카드 전송여부 수정 실패..", tList);
                    }

                    deleteListSeqInfo += tList.getListSeq() + ",";
                }
                deleteListSeqInfo = deleteListSeqInfo.substring(0, deleteListSeqInfo.length() - 1);
            } else {
                ExpInfo.ProcessLog("[iCUBE / ERPiU] 예신연동 정보가 삭제되지 않습니다.", expendVo);
                ExpInfo.ProcessLog("[iCUBE / ERPiU] 카드내역 연동 정보가 삭제되지 않습니다.", expendVo);
                ExpInfo.ProcessLog("[iCUBE / ERPiU] 계산서내역 연동 정보가 삭제되지 않습니다.", expendVo);
            }

            try {
                // TODO : 설명 기록 (이전 주석 : 삭제)
                resultVo = listService.ExListListInfoDelete(listListVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoDelete.do >> listService.ExListListInfoDelete(listListVo);", listListVo);
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록 (이전 주석 : 결재중 수정인 경우 Interlock정보 업데이트 및 수정내역 입력)
                ExCommonInterlockUpdate(expendVo.getExpendSeq(), loginVo, params, request, "항목삭제 (listSeq:" + deleteListSeqInfo + ")");
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoDelete.do >> ExCommonInterlockUpdate(expendVo.getExpendSeq(), loginVo, params, request, \"항목삭제 (listSeq:\" + deleteListSeqInfo + \")\");", params);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 복사 */
    @RequestMapping("/ex/user/expend/list/ListInfoCopy.do")
    public ModelAndView ExListInfoCopy(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            List<ExExpendListVO> listListVo = new ArrayList<ExExpendListVO>();
            List<Map<String, Object>> listParam = new ArrayList<Map<String, Object>>();

            String copyListSeqInfo = commonCode.EMPTYSTR; /* 종결문서 수정시 변경 내역 저장을 위한 변수 */

            // 초기값 지정
            listParam = ConvertManager.ConvertJsonToListMap((String) params.get("listListVo"));

            for (Map<String, Object> map : listParam) {
                ExExpendListVO listVo = new ExExpendListVO();
                ConvertManager.ConvertMapToObject(map, listVo);
                listVo.setCompSeq(loginVo.getCompSeq());
                listVo.setCreateSeq(loginVo.getUniqId());
                listVo.setModifySeq(loginVo.getUniqId());
                listListVo.add(listVo);
                copyListSeqInfo += listVo.getListSeq() + ",";
            }

            copyListSeqInfo = copyListSeqInfo.substring(0, copyListSeqInfo.length() - 1);

            try {
                // TODO : 설명 기록 (이전 주석 : 복사)
                resultVo = listService.ExListInfoCopy(loginVo, listListVo, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoCopy.do >> listService.ExListInfoCopy(loginVo, listListVo, conVo);", listListVo);
                throw new Exception(e);
            }

            if (resultVo.getCode().equals(commonCode.SUCCESS)) {
                try {
                    // TODO : 설명 기록 (이전 주석 : 결재중 수정인 경우 Interlock 정보 업데이트 및 수정내역 입력)
                    ExCommonInterlockUpdate(listListVo.get(0).getExpendSeq(), loginVo, params, request, "항목복사 (listSeq:" + copyListSeqInfo + ")");
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoCopy.do >> ExCommonInterlockUpdate(listListVo.get(0).getExpendSeq(), loginVo, params, request, \"항목복사 (listSeq:\" + copyListSeqInfo + \")\");", copyListSeqInfo);
                }
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 복사 */
    @RequestMapping("/ex/user/expend/list/ListInfoCopy2.do")
    public ModelAndView ExListInfoCopy2(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExExpendListVO listVo = new ExExpendListVO();
            ExCommonResultVO resultVo = new ExCommonResultVO();

            Map<String, Object> listParam = new HashMap<String, Object>();

            List<ExExpendListVO> listListVo = new ArrayList<ExExpendListVO>();
            List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>();

            String copyListSeqInfo = commonCode.EMPTYSTR; /* 종결문서 수정시 변경 내역 저장을 위한 변수 */

            // 초기값 지정
            paramList = ConvertManager.ConvertJsonToListMap(params.get("target").toString());
            for (Map<String, Object> tList : paramList) {
                listParam = tList;
            }

            ConvertManager.ConvertMapToObject(listParam, listVo);

            listVo.setCompSeq(loginVo.getCompSeq());
            listVo.setCreateSeq(loginVo.getUniqId());
            listVo.setModifySeq(loginVo.getUniqId());

            listListVo.add(listVo);

            copyListSeqInfo += listVo.getListSeq();

            try {
                // TODO : 설명 기록 (이전 주속 : 복사)
                resultVo = listService.ExListInfoCopy(loginVo, listListVo, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoCopy2.do >> listService.ExListInfoCopy(loginVo, listListVo, conVo);", listListVo);
                throw new Exception(e);
            }

            if (resultVo.getCode().equals(commonCode.SUCCESS)) {
                try {
                    // TODO : 설명 기록 (이전 주석 : 결재중 수정인 경우 Interlock 정보 업데이트 및 수정내역 입력)
                    ExCommonInterlockUpdate(listListVo.get(0).getExpendSeq(), loginVo, params, request, "항목복사 (listSeq:" + copyListSeqInfo + ")");
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoCopy2.do >> ExCommonInterlockUpdate(listListVo.get(0).getExpendSeq(), loginVo, params, request, \"항목복사 (listSeq:\" + copyListSeqInfo + \")\");", copyListSeqInfo);
                }
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 목록 삭제 */
    @RequestMapping("/ex/user/expend/slip/SlipListInfoDelete.do")
    public ModelAndView ExSlipListInfoDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExpendVO expendVo = new ExpendVO();
            ExCommonResultVO resultVo = new ExCommonResultVO();

            Map<String, Object> budgetParam = new HashMap<String, Object>();

            List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>();
            List<Map<String, Object>> slipParam = new ArrayList<Map<String, Object>>();

            boolean isSlipMode = false;
            String deleteSlipSeq = commonCode.EMPTYSTR; /* 분개정보 삭제시 seq 저장 */

            // 초기값 설정
            slipParam = ConvertManager.ConvertJsonToListMap((String) params.get("slipListVo"));

            // 분개단위 입력 여부 판단
            if (params.get("isSlipMode") != null) {
                isSlipMode = Boolean.parseBoolean(params.get("isSlipMode").toString());
            }

            for (Map<String, Object> map : slipParam) {
                ExExpendSlipVO slipVo = new ExExpendSlipVO();
                ConvertManager.ConvertMapToObject(map, slipVo);

                slipVo.setCompSeq(loginVo.getCompSeq());
                slipListVo.add(slipVo);

                // 분개 단위 입력 시 항목 금액 수
                if (isSlipMode) {
                    try {
                        slipService.ExListAmtInfoUpdate(slipVo, false, false);
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipListInfoDelete.do >> slipService.ExListAmtInfoUpdate(slipVo, false, false);", slipVo);
                        throw new Exception(e);
                    }
                }

                deleteSlipSeq += slipVo.getListSeq() + "/" + slipVo.getListSeq() + ",";
            }

            // 결재중 수정인 경우 삭제 전
            expendVo.setExpendSeq(slipListVo.get(0).getExpendSeq());

            try {
                // TODO : 설명 기록
                expendVo = userService.ExUserExpendInfoSelect(expendVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipListInfoDelete.do >> userService.ExUserExpendInfoSelect(expendVo);", expendVo);
                throw new Exception(e);
            }

            // TODO : 설명 기록
            if (!expendVo.getExpendStatCode().equals(commonCode.EMPTYSTR) && !expendVo.getExpendStatCode().equals("999")  && !expendVo.getErpSendYN().equals(commonCode.EMPTYYES)) {
                // expend_stat_code != "" && expend_stat_code != "999" && expend_stat_code != "10" && erp_send_yn != "Y"
                // 상신된 상태 && 삭제가 아닌 상태  && ERP 전송되지 않은 상태
            	//****  2020.01.08  임시보관 문서일시에도 삭제 처리 필요!!
                if (conVo.getErpTypeCode().equals(commonCode.ERPIU)) {
                    budgetParam.put(commonCode.DOCSEQ, expendVo.getDocSeq());
                    budgetParam.put(commonCode.EXPENDSEQ, expendVo.getExpendSeq());
                    budgetParam.put("newSlipSeq", slipListVo);
                    budgetParam.put("isEditList", false);

                    try {
                        budgetService.ExInterLockERPiURowDelete(budgetParam);
                        ExpInfo.CoreLogNotLoop("[ERPiU] 예신연동 정보가 삭제", budgetParam);
                    } catch (Exception e) {
                        ExpInfo.CoreLogNotLoop("[ERPiU] 예산삭제 실패.. ( 예산연동 미사용일 수 있습니다. )", budgetParam);
                        ExpInfo.CLog("[에러발생] /ex/user/expend/list/ListInfoDelete.do >> budgetService.ExInterLockERPiURowDelete(budgetParam);", budgetParam);
                    }
                } else {
                    ExpInfo.ProcessLog("[iCUBE] 예신연동 정보가 삭제되지 않습니다.", expendVo);
                }
            } else {
                ExpInfo.ProcessLog("[iCUBE / ERPiU] 예신연동 정보가 삭제되지 않습니다.", expendVo);
            }

            try {
                // TODO : 설명 기록 (이전 주속 : 삭제)
                resultVo = slipService.ExSlipListInfoDelete(slipListVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipListInfoDelete.do >> slipService.ExSlipListInfoDelete(slipListVo);", slipListVo);
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록 (이전 주석 : 결재중 수정인 경우 Interlock정보 업데이트 및 수정내역 입력)
                ExCommonInterlockUpdate(expendVo.getExpendSeq(), loginVo, params, request, "분개삭제 (listSeq/slipSeq:" + deleteSlipSeq + ")");
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipListInfoDelete.do >> ExCommonInterlockUpdate(expendVo.getExpendSeq(), loginVo, params, request, \"분개삭제 (listSeq/slipSeq:\" + deleteSlipSeq + \")\");", deleteSlipSeq);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 복사 */
    @RequestMapping("/ex/user/expend/slip/SlipInfoCopy.do")
    public ModelAndView ExSlipInfoCopy(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();
            List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>();
            List<Map<String, Object>> slipParam = new ArrayList<Map<String, Object>>();

            boolean isSlipMode = false;
            String copySlipSeq = commonCode.EMPTYSTR; /* 지출결의 분개 복사 seq 저장 */

            // 초기값 지정
            slipParam = ConvertManager.ConvertJsonToListMap((String) params.get("slipListVo"));

            // 분개단위 입력 여부 확인
            if (params.get("isSlipMode") != null) {
                isSlipMode = Boolean.parseBoolean(params.get("isSlipMode").toString());
            }

            for (Map<String, Object> map : slipParam) {
                ExExpendSlipVO slipVo = new ExExpendSlipVO();
                ConvertManager.ConvertMapToObject(map, slipVo);

                slipVo.setCompSeq(loginVo.getCompSeq());
                slipVo.setCreateSeq(loginVo.getUniqId());
                slipVo.setModifySeq(loginVo.getUniqId());
                slipListVo.add(slipVo);

                // 분개단위 입력 사용시 분개 복사하는 경우에 항목에 분개 금액 반영
                if (isSlipMode) {
                    try {
                        slipService.ExListAmtInfoUpdate(slipVo, true, true);
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipInfoCopy.do >> slipService.ExListAmtInfoUpdate(slipVo, true, true);", slipVo);
                        throw new Exception(e);
                    }
                }

                copySlipSeq += slipVo.getListSeq() + "/" + slipVo.getSlipSeq() + ",";
            }

            copySlipSeq = copySlipSeq.substring(0, copySlipSeq.length() - 1);

            try {
                // TODO : 설명 기록 (기존 주석 : 복사)
                resultVo = slipService.ExSlipInfoCopy(loginVo, slipListVo, conVo, commonCode.EMPTYSEQ);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipInfoCopy.do >> slipService.ExSlipInfoCopy(loginVo, slipListVo, conVo, commonCode.EMPTYSEQ);", slipListVo);
                throw new Exception(e);
            }

            if (resultVo.getCode().equals(commonCode.SUCCESS)) {
                try {
                    // TODO : 설명 기록 (기존 주석 : 결재중 수정인 경우 Interlock 정보 업데이트 및 수정내역 입력)
                    ExCommonInterlockUpdate(slipListVo.get(0).getExpendSeq(), loginVo, params, request, "분개복사 (listSeq/slipSeq" + copySlipSeq + ")");
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipInfoCopy.do >> ExCommonInterlockUpdate(slipListVo.get(0).getExpendSeq(), loginVo, params, request, \"분개복사 (listSeq/slipSeq\" + copySlipSeq + \")\");", params);
                }
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 복사 */
    @RequestMapping("/ex/user/expend/slip/SlipInfoCopy2.do")
    public ModelAndView ExSlipInfoCopy2(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExExpendSlipVO slipVo = new ExExpendSlipVO();
            ExCommonResultVO resultVo = new ExCommonResultVO();

            Map<String, Object> slipParam = new HashMap<String, Object>();

            List<ExExpendSlipVO> slipListVo = new ArrayList<ExExpendSlipVO>();
            List<Map<String, Object>> paramList = new ArrayList<Map<String, Object>>();

            boolean isSlipMode = false;
            String copySlipSeq = commonCode.EMPTYSTR; /* 지출결의 분개 복사 seq 저장 */


            // 초기값 지정
            paramList = ConvertManager.ConvertJsonToListMap(params.get("target").toString());
            for (Map<String, Object> tSlip : paramList) {
                slipParam = tSlip;
            }

            // 분개단위 입력 여부 판단
            if (params.get("isSlipMode") != null) {
                isSlipMode = Boolean.parseBoolean(params.get("isSlipMode").toString());
            }

            ConvertManager.ConvertMapToObject(slipParam, slipVo);

            slipVo.setCompSeq(loginVo.getCompSeq());
            slipVo.setCreateSeq(loginVo.getUniqId());
            slipVo.setModifySeq(loginVo.getUniqId());
            slipListVo.add(slipVo);

            // 분개단위 입력 사용시 분개 복사하는 경우에 항목에 분개 금액 반영
            if (isSlipMode) {
                if (!slipVo.getInterfaceType().equals("")) {
                    // 외부연동의 경우 복사 진행 불가
                    if (!slipVo.getInterfaceType().equals(commonCode.EMPTYSTR)) {
                        resultVo.setCode(CommonInterface.commonCode.FAIL);
                        resultVo.setMessage("외부시스템 연동의 경우 복사가 불가능합니다.");
                    }
                } else {
                    try {
                        // TODO : 설명 기록
                        resultVo = slipService.ExListAmtInfoUpdate(slipVo, true, true);
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipInfoCopy2.do >> slipService.ExListAmtInfoUpdate(slipVo, true, true);", slipVo);
                        throw new Exception(e);
                    }
                }
            }

            if (!resultVo.getCode().equals(commonCode.FAIL)) {
                copySlipSeq += slipVo.getListSeq() + "/" + slipVo.getSlipSeq();

                // 복사
                try {
                    resultVo = slipService.ExSlipInfoCopy(loginVo, slipListVo, conVo, commonCode.EMPTYSEQ);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipInfoCopy2.do >> slipService.ExSlipInfoCopy(loginVo, slipListVo, conVo, commonCode.EMPTYSEQ);", slipListVo);
                    throw new Exception(e);
                }

                if (resultVo.getCode().equals(commonCode.SUCCESS)) {
                    try {
                        // 결재중 수정인 경우 Interlock 정보 업데이트 및 수정내역 입력
                        ExCommonInterlockUpdate(slipListVo.get(0).getExpendSeq(), loginVo, params, request, "분개복사 (listSeq/slipSeq" + copySlipSeq + ")");
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] /ex/user/expend/slip/SlipInfoCopy.do >> ExCommonInterlockUpdate(slipListVo.get(0).getExpendSeq(), loginVo, params, request, \"분개복사 (listSeq/slipSeq\" + copySlipSeq + \")\");", params);
                    }
                }
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }
    // Mng 항목관리 작업

    /* 지출결의 */
    /* 지출결의 - 지출결의 항목 분개 관리항목 생성 */
    @RequestMapping("/ex/expend/mng/ExMngInfoInsert.do")
    public ModelAndView ExMngInfoInsert(@ModelAttribute ExExpendMngVO mngVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            // 초기값 지정
            mngVo.setModifySeq(loginVo.getUniqId());

            // ERP 회사코드 확인
            mngVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), mngVo.getCompSeq()));

            try {
                // TODO : 설명 기록 (이전 주석 : 생성)
                mngVo = mngService.ExMngInfoInsert(mngVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/mng/ExMngInfoInsert.do >> mngService.ExMngInfoInsert(mngVo);", mngVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", mngVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExExpendMngVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 관리항목 수정 */
    @RequestMapping("/ex/expend/mng/ExMngInfoUpdate.do")
    public ModelAndView ExMngInfoUpdate(@ModelAttribute ExExpendMngVO mngVo, @RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExpendVO expendVo = new ExpendVO();
            ExCommonResultVO resultVo = new ExCommonResultVO();

            // Interlock 업데이트 관련 변수
            Map<String, Object> formInfo = new HashMap<String, Object>();
            Map<String, Object> interlockParam = new HashMap<String, Object>();

            // 초기값 지정
            mngVo.setModifySeq(loginVo.getUniqId());
            mngVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), mngVo.getCompSeq()));

            try {
                // TODO : 설명 기록 (기존 주석 : 생성)
                resultVo = mngService.ExMngInfoUpdate(mngVo, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/mng/ExMngInfoUpdate.do >> mngService.ExMngInfoUpdate(mngVo, conVo);", mngVo);
                throw new Exception(e);
            }

            // 지출결의 정보 조회
            expendVo.setExpendSeq(mngVo.getExpendSeq());

            try {
                expendVo = userService.ExUserExpendInfoSelect(expendVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/mng/ExMngInfoUpdate.do >> userService.ExUserExpendInfoSelect(expendVo);", expendVo);
                throw new Exception(e);
            }

            // 양식 정보
            if (params.get("formInfo") != null && !expendVo.getExpendStatCode().equals(commonCode.EMPTYSTR)) {
                formInfo = CommonConvert.CommonGetJSONToMap(params.get("formInfo").toString());

                // Interlock 정보 업데이트를 위해 변수 담아준다 ( resultVo에는 docSeq가 없어 code에 담아준다. )
                interlockParam.put("processId", formInfo.get("formDTp").toString());
                interlockParam.put("approKey", formInfo.get("formDTp").toString() + "_EX_" + expendVo.getExpendSeq());

                interlockParam.put("interlockName", InterlockName.PREVIOUSBUTTONKR.toString());
                interlockParam.put("interlockNameEn", InterlockName.PREVIOUSBUTTONEN.toString());
                interlockParam.put("interlockNameJp", InterlockName.PREVIOUSBUTTONJP.toString());
                interlockParam.put("interlockNameCn", InterlockName.PREVIOUSBUTTONKR.toString());

                interlockParam.put("docSeq", expendVo.getDocSeq());
                interlockParam.put("formSeq", formInfo.get("formSeq").toString());

                interlockParam.put("header", commonCode.EMPTYSTR);
                interlockParam.put("content", commonCode.EMPTYSTR);
                interlockParam.put("footer", commonCode.EMPTYSTR);

                interlockParam.put("expendSeq", expendVo.getExpendSeq());
                interlockParam.put("eapCallDomain", CommonConvert.CommonGetStr((params == null ? "" : params.get("eapCallDomain"))));

                /* 인터락 정보 업데이트 */
                try {
                    this.ExDocMake(interlockParam, request);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/expend/mng/ExMngInfoUpdate.do >> this.ExDocMake(interlockParam, request);", interlockParam);
                    throw new Exception(e);
                }
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 관리항목 조회 */
    @RequestMapping("/ex/expend/mng/ExMngInfoSelect.do")
    public ModelAndView ExMngInfoSelect(@ModelAttribute ExExpendMngVO mngVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            // 초기값 지정
            mngVo.setModifySeq(loginVo.getUniqId());

            // ERP 회사코드 확인
            mngVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), mngVo.getCompSeq()));

            try {
                // TODO : 설명 기록 (이전 주석 : 생성)
                mngVo = mngService.ExMngInfoSelect(mngVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/mng/ExMngInfoSelect.do >> mngService.ExMngInfoSelect(mngVo);", mngVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", mngVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExExpendMngVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 관리항목 삭제 */
    @RequestMapping("/ex/expend/mng/ExMngInfoDelete.do")
    public ModelAndView ExMngInfoDelete(@ModelAttribute ExExpendMngVO mngVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            // 초기값 지정
            mngVo.setModifySeq(loginVo.getUniqId());

            // ERP 회사코드 확인
            mngVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), mngVo.getCompSeq()));

            try {
                // TODO : 설명 기록 (이전 주석 : 생성)
                resultVo = mngService.ExMngInfoDelete(mngVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/mng/ExMngInfoDelete.do >> mngService.ExMngInfoDelete(mngVo);", mngVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 관리항목 목록 조회 */
    @RequestMapping("/ex/expend/mng/ExMngGridInfoSelect.do")
    public ModelAndView ExListGridInfoSelect(@ModelAttribute ExExpendMngVO mngVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();

            // groupSeq 확인
            mngVo.setGroupSeq(loginVo.getGroupSeq());

            // ERP 회사코드 확인
            mngVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), mngVo.getCompSeq()));

            try {
                // TODO : 설명 기록 (기존 주석 : 조회)
                result = mngService.ExMngGridInfoSelect(mngVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/mng/ExMngGridInfoSelect.do >> mngService.ExMngGridInfoSelect(mngVo);", mngVo);
                logger.error(e);
            }

            mv.addObject("aaData", result);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 공통코드 */
    /* 공통코드 - 지출결의 항목 분개 관리항목 하위코드 목록 조회 */
    @RequestMapping("/ex/expend/mng/ExCodeMngDListInfoSelect.do")
    public ModelAndView ExCodeMngDListInfoSelect(@ModelAttribute ExExpendMngVO mngVo, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            List<ExExpendMngVO> mngListVo = new ArrayList<ExExpendMngVO>();

            // ERP 회사코드 확인
            mngVo.setErpCompSeq(codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), mngVo.getCompSeq()));

            // searchStr 특수문자 변경
            mngVo.setSearchStr(CommonConvert.CommonConvertSpecialCharaterForJava(mngVo.getSearchStr()));

            try {
                // TODO : 설명 기록 (이전 주석 : 조회)
                mngListVo = mngService.ExCodeMngDListInfoSelect(mngVo, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/mng/ExCodeMngDListInfoSelect.do >> mngService.ExCodeMngDListInfoSelect(mngVo, conVo);", mngVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", mngListVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - iCUBE 예산체크 팝업 */
    @RequestMapping("/ex/user/expend/ExBudgetAmtCheck.do")
    public ModelAndView ExBudgetAmtCheck(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCodeBudgetVO resultVo = new ExCodeBudgetVO();

            // ERP 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));

            // GW 회사코드 확인
            params.put("compSeq", loginVo.getCompSeq());

            try {
                resultVo = budgetService.ExBudgetAmtInfoSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/ExBudgetAmtCheck.do >> budgetService.ExBudgetAmtInfoSelect(params);", params);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - iCUBE 예산체크 팝업 */
    @RequestMapping("/ex/user/expend/ExBudgetAmtCheck2.do")
    public ModelAndView ExBudgetAmtCheck2(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCodeBudgetVO resultVo = new ExCodeBudgetVO();

            // ERP 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));

            // GW 회사코드 확인
            params.put("compSeq", loginVo.getCompSeq());
            /* 조회 */

            try {
                // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                resultVo = budgetService.ExBudgetAmtInfoSelect3(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/ExBudgetAmtCheck2.do >> budgetService.ExBudgetAmtInfoSelect2(params);", params);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 생성 처리 이준성 담당 */
    @RequestMapping("/ex/user/expend/SlipInfoSingleMake.do")
    public ModelAndView ExSlipInfoSingleMake(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ExCommonResultVO resultVo = new ExCommonResultVO();

            boolean isProcess = false;
            // 분개 수정 여부 확인
            String slipModifyYN = "";
            slipModifyYN = EgovStringUtil.isNullToString(params.get("modify"));
            // 분개삭제 수행
            ExExpendSlipVO slipVo = new ExExpendSlipVO();
            Map<String, Object> slipMap = new HashMap<String, Object>();
            slipMap = ConvertManager.ConvertJsonToMap((String) params.get("slip"));
            ConvertManager.ConvertMapToObject(slipMap, slipVo);
            // 분개단위 입력 여부 확인
            boolean isSlipMode = false;
            if (params.get("isSlipMode") != null) {
                isSlipMode = Boolean.parseBoolean(params.get("isSlipMode").toString());
            }

            if (slipModifyYN.equals(commonCode.EMPTYYES)) {
                try {
                    if (isSlipMode) {
                        slipService.ExListAmtInfoUpdate(slipVo, false, false);
                    }
                    resultVo = slipService.ExSlipInfoDelete(slipVo);

                    if (slipVo.getSlipSeq() == null) {
                        throw new Exception("getSlipSeq.NULL 상태 입니다. ");
                    }
                    params.put("modifySlipSeq", slipVo.getSlipSeq());
                    if (resultVo.getCode().equals(commonCode.SUCCESS)) {
                        isProcess = true;
                    }
                } catch (NullPointerException e) {
                    logger.error(e);
                } catch (Exception e) {
                    logger.error(e);
                }
            } else if (slipModifyYN.equals(commonCode.EMPTYNO)) {
                isProcess = true;
            }
            /* 변수 정의 */
            if (isProcess) {
                try {
                    /* ERP 연결정보 조회 */
                    ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
                    /* 지출결의 항목 분개 생성 처리 */
                    resultVo = slipService.ExSlipInfoSingleMake(loginVo, params, conVo);
                    /* 분개단위 입력시 항목 금액 수정 */
                    if (isSlipMode) {
                        slipService.ExListAmtInfoUpdate(slipVo, true, false);
                    }
                    /* 반환처리 */
                    mv.setViewName("jsonView");
                    mv.addObject("aaData", resultVo);
                    mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
                } catch (Exception e) {
                    logger.error(e);
                }
            } else {
                throw new Exception();
            }

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 항목 분개 생성 처리(결재 진행중) */
    @RequestMapping("/ex/user/expend/SlipInfoSingleMakeApproval.do")
    public ModelAndView ExSlipInfoSingleMakeApproval(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            // Interlock 업데이트 관련 변수
            Map<String, Object> formInfo = new HashMap<String, Object>();
            Map<String, Object> interlockParam = new HashMap<String, Object>();

            try {
                // TODO : 설명 기록 (이전 주석 : 분개 수정 or 추가 진행)
                resultVo = slipService.ExSlipInfoSingleMakeApproval(loginVo, params, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/SlipInfoSingleMakeApproval.do >> slipService.ExSlipInfoSingleMakeApproval(loginVo, params, conVo);", params);
                throw new Exception(e);
            }

            // 양식 정보
            formInfo = CommonConvert.CommonGetJSONToMap(params.get("formInfo").toString());

            // Interlock 정보 업데이트를 위해 변수 담아준다. (resultVo에는 docSeq가 없어 code에 담아준다)
            interlockParam.put("processId", formInfo.get("formDTp").toString());
            interlockParam.put("approKey", formInfo.get("formDTp").toString() + "_EX_" + resultVo.getExpendSeq());

            interlockParam.put("interlockName", InterlockName.PREVIOUSBUTTONKR.toString());
            interlockParam.put("interlockNameEn", InterlockName.PREVIOUSBUTTONEN.toString());
            interlockParam.put("interlockNameJp", InterlockName.PREVIOUSBUTTONJP.toString());
            interlockParam.put("interlockNameCn", InterlockName.PREVIOUSBUTTONKR.toString());

            interlockParam.put("docSeq", resultVo.getCode());
            interlockParam.put("formSeq", formInfo.get("formSeq").toString());

            interlockParam.put("header", commonCode.EMPTYSTR);
            interlockParam.put("content", commonCode.EMPTYSTR);
            interlockParam.put("footer", commonCode.EMPTYSTR);

            interlockParam.put("expendSeq", resultVo.getExpendSeq());
            interlockParam.put("eapCallDomain", CommonConvert.CommonGetStr((params == null ? "" : params.get("eapCallDomain"))));

            // Interlock 정보 업데이
            try {
                this.ExDocMake(interlockParam, request);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/SlipInfoSingleMakeApproval.do >> this.ExDocMake(interlockParam, request);", interlockParam);
                throw new Exception(e);
            }

            mv.setViewName("jsonView");
            mv.addObject("aaData", resultVo);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 인터락 */
    /* 인터락 HTML 스트링 조회 */
    @RequestMapping("/ex/expend/interlock/ExInterlockUrl.do")
    public ModelAndView ExInterlockUrl(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            ResultVO result = new ResultVO();

            try {
                result = userService.ExUserExpendInterlockHtmlCode(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/interlock/ExInterlockUrl.do >> userService.ExUserExpendInterlockHtmlCode(params);", params);
                throw new Exception(e);
            }

            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 전자결재 문서 생성 */
    @RequestMapping("/ex/expend/interlock/ExDocMake.do")
    public ModelAndView ExDocMake(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다." + loginVo);

            // TODO : 설명 기록
            String wegUrl = CommonConvert.CommonGetStr(params.get("eapCallDomain"));
            if ("".equals(wegUrl)) {
                String serverName = request.getServerName();
                int portName = request.getServerPort();
                wegUrl = serverName + ":" + portName;

                String flag = commonCode.EMPTYSTR;
                try {
                    Map<String, Object> codeParams = new HashMap<String, Object>();
                    codeParams.put("groupSeq", loginVo.getGroupSeq());
                    codeParams.put("code", "ex00037");
                    codeParams.put("detailCode", "0000");
                    Map<String, Object> codeResult = exCommonService.CommonCodeSelect(codeParams);
                    flag = codeResult.get("FLAG_1").toString();
                } catch (Exception e) {
                    logger.error("CommonCodeSelect 오류 : " + e.getMessage());
                    flag = commonCode.EMPTYSTR;
                }

                if (flag.equals("1")) {
                    String gwUrl = commonCode.EMPTYSTR;
                    try {
                        gwUrl = exCommonService.GroupwareUrlSelect(loginVo.getGroupSeq());
                    } catch (Exception e) {
                        logger.error("GroupwareUrlSelect 오류 : " + e.getMessage());
                        gwUrl = commonCode.EMPTYSTR;
                    }

                    if (!gwUrl.equals("")) {
                        String protocol = gwUrl.substring(0, gwUrl.indexOf("://"));
                        wegUrl = protocol + "://" + wegUrl;
                    } else {
                        if (request.isSecure()) {
                            wegUrl = "https://" + wegUrl;
                        } else {
                            wegUrl = "http://" + wegUrl;
                        }
                    }
                } else {
                    if (request.isSecure()) {
                        wegUrl = "https://" + wegUrl;
                    } else {
                        wegUrl = "http://" + wegUrl;
                    }
                }
            }
            
            logger.info(" URL [" + wegUrl.toString() + "]");

            // 이전단계 url 정의
            ExpInfo.CoreLogNotLoop("[Call wegUrl : " + wegUrl + "]", wegUrl);
            String interlockUrl = wegUrl + "/exp/ex/expend/master/ExUserMasterPop.do?expendSeq=" + params.get(commonCode.EXPENDSEQ);

            // Interlock 정보 가져오기
            Map<String, Object> serviceParamMap = new HashMap<String, Object>();
            Map<String, Object> headerMap = new HashMap<String, Object>();
            Map<String, Object> footerMap = new HashMap<String, Object>();
            List<Map<String, Object>> contentsMap = new ArrayList<Map<String, Object>>();

            serviceParamMap.put(commonCode.EXPENDSEQ, params.get(commonCode.EXPENDSEQ));

            try {
                // TODO : 설명 기록
                headerMap = userReportService.ExReportHeaderInterLockInfoSelect(serviceParamMap);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/interlock/ExDocMake.do >> userReportService.ExReportHeaderInterLockInfoSelect(serviceParamMap);", serviceParamMap);
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록
                contentsMap = userReportService.ExReportContentsInterLockInfoSelect(serviceParamMap);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/interlock/ExDocMake.do >> userReportService.ExReportContentsInterLockInfoSelect(serviceParamMap);", serviceParamMap);
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록
                footerMap = userReportService.ExReportFooterInterLockInfoSelect(serviceParamMap);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/interlock/ExDocMake.do >> userReportService.ExReportFooterInterLockInfoSelect(serviceParamMap);", serviceParamMap);
                throw new Exception(e);
            }

            // 인터페이스 호출
            ResultVO resultVo = new ResultVO();

            resultVo.setProcessId(CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID)));
            resultVo.setApproKey(CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY)));
            resultVo.setInterlockUrl(interlockUrl);
            resultVo.setInterlockName(InterlockName.EDITINFOBUTTONKR.toString());
            resultVo.setInterlockNameEn(InterlockName.EDITINFOBUTTONEN.toString());
            resultVo.setInterlockNameJp(InterlockName.EDITINFOBUTTONJP.toString());
            resultVo.setInterlockNameCn(InterlockName.EDITINFOBUTTONCN.toString());
            resultVo.setPreUrl(CommonConvert.CommonGetStr(wegUrl));
            resultVo.setDocSeq(commonCode.EMPTYSEQ);


            if (params.get("docSeq") != null) {
              resultVo.setDocSeq(params.get("docSeq").toString());
              // dcoTitle 조회 후 parameter로 넘겨야 한다.
              if (!params.get("docSeq").toString().equals(commonCode.EMPTYSTR)) {
                  ResultVO tResult = new ResultVO();
                  tResult.setParams(params);
                  try {
                       // TODO : 설명 기록
                       tResult = codeService.ExExpendDocInfoSelect(tResult);
                      } catch (Exception e) {
                          ExpInfo.CLog("[에러발생] /ex/expend/interlock/ExDocMake.do >> codeService.ExExpendDocInfoSelect(tResult);", tResult);
                          throw new Exception(e);
                      }
                      resultVo.setDocTitle(tResult.getaData().get(commonCode.DOCTITLE).toString());
                  }
                }

            resultVo.setFormSeq(CommonConvert.CommonGetSeq(params.get(commonCode.FORMSEQ)));
            resultVo.setFormSeq(params.get(commonCode.FORMSEQ).toString());
            resultVo.setHeader(headerMap);
            resultVo.setContent(contentsMap);
            resultVo.setFooter(footerMap);
            resultVo.setExpendSeq(params.get(commonCode.EXPENDSEQ).toString());
            // LoginVo 회사정보 담는 곳
            resultVo.setCompSeq(loginVo.getCompSeq());

            try {
                // TODO : 설명 기록
                resultVo = approvalService.DocMake(resultVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/interlock/ExDocMake.do >> approvalService.DocMake(resultVo);", resultVo);
                throw new Exception(e);
            }

            resultVo.setInterlockUrl(interlockUrl + "?docSeq=" + resultVo.getDocSeq());
            resultVo.setEaType(loginVo.getEaType());

            mv.addObject("result", resultVo);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 매입전자세금계산서 - 매입전자세금계산서 목록 조회 */
    @RequestMapping("/ex/user/etax/ExETaxListInfoSelect.do")
    public ModelAndView ExETaxListInfoSelect(@ModelAttribute ExCodeETaxVO etaxVo, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            List<ExCodeETaxVO> etaxListVo = new ArrayList<ExCodeETaxVO>();

            // ERP 회사코드 확인
            etaxVo.setErpCompSeq(conVo.getErpCompSeq());

            // 작성장 정보 추가
            etaxVo.setCreateSeq(loginVo.getUniqId());
            etaxVo.setTrchargeEmail(loginVo.getEmail() + "@");
            etaxVo.setCompSeq(loginVo.getCompSeq());
            etaxVo.setEmpSeq(loginVo.getUniqId());
            etaxVo.setCoCd(loginVo.getErpCoCd());

            try {
                // TODO : 설명 기록 (이전 주석 : 조회)
                // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                etaxListVo = eTaxService.ExETaxListInfoSelect(etaxVo, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/etax/ExETaxListInfoSelect.do >> eTaxService.ExETaxListInfoSelect(etaxVo, conVo);", etaxVo);
                throw new Exception(e);
            }

            mv.addObject("aaData", etaxListVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ArrayList<ExCodeETaxVO>());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ArrayList<ExCodeETaxVO>());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 매입전자세금계산서 - 매입전자세금계산서 연동 코드 저장 */
    @RequestMapping("/ex/user/etax/ExExpendETaxInfoMapUpdate.do")
    public ModelAndView ExExpendETaxInfoMapUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO resultVo = new ResultVO();

            try {
                // TODO : 설명 기록 (기존 주석 : 반환 처리)
                // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
                resultVo = eTaxService.ExExpendETaxInfoMapUpdate(params, conVo, loginVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/etax/ExExpendETaxInfoMapUpdate.do >> eTaxService.ExExpendETaxInfoMapUpdate(params, conVo, loginVo);", params);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo.getAaData().get(0));
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 매입전자세금계산서 - 매입전자세금계산서 사용내역 지출결의 항목 분개 처리 */
    @RequestMapping("/ex/user/etax/ExETaxInfoMake.do")
    public ModelAndView ExETaxInfoMake(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            try {
                // TODO : 설명 기록
                resultVo = eTaxService.ExETaxInfoMake(params, conVo, loginVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/etax/ExETaxInfoMake.do >> eTaxService.ExETaxInfoMake(params, conVo, loginVo);", params);
                throw e;
            }

            try {
                // TODO : 설명 기록
                ExCommonInterlockUpdate(params.get("expendSeq").toString(), loginVo, params, request, "매입전자세금계산서 내역 추가 (listSeq:" + resultVo.getListSeq() + ")");
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/etax/ExETaxInfoMake.do >> ExCommonInterlockUpdate(params.get(\"expendSeq\").toString(), loginVo, params, request, \"매입전자세금계산서 내역 추가 (listSeq:\" + resultVo.getListSeq() + \")\");", params);
                throw e;
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (BudgetAmtOverException e) {
            logger.error(e);

            ExCommonResultVO resultVo = new ExCommonResultVO();
            resultVo.setCode(CommonInterface.commonCode.FAIL);
            resultVo.setError(e.getMessage());

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            ExCommonResultVO resultVo = new ExCommonResultVO();
	        resultVo.setCode(CommonInterface.commonCode.FAIL);
	        resultVo.setError(e.getMessage());

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            ExCommonResultVO resultVo = new ExCommonResultVO();
	        resultVo.setCode(CommonInterface.commonCode.FAIL);
	        //resultVo.setError("오류가 발생되었습니다.");
	        resultVo.setError(e.getMessage());

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 예실 대비 현황 ------------------------- */
    /* 예실대비현황 목록 조회 */
    @RequestMapping("/ex/expend/user/ExUserYesilInfoSelect.do")
    public ModelAndView ExAdminYesilPopInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            // 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());

            try {
                // TODO : 설명 기록 (이전 주석 : 예실대비 현황 목록 조회)
                result = userYesilService.ExUserYesilInfoSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExUserYesilInfoSelect.do >> userYesilService.ExUserYesilInfoSelect(params);", params);
                throw new Exception(e);
            }

            mv.setViewName("jsonView");
            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 예실 대비 현황 ------------------------- */
    /* 예실대비현황 상세 조회 */
    @RequestMapping("/ex/expend/user/ExUserYesilDetailSelect.do")
    public ModelAndView ExAdminYesilDetailSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO subResult = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            // 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());

            try {
                // TODO : 설명 기록 (기존 주석 : 예실대비 현황 목록 조회)
                result = userYesilService.ExUserYesilDetailSelect(params);
                subResult = userYesilService.ExUserYesilnoExpendSend(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExUserYesilDetailSelect.do >> userYesilService.ExUserYesilDetailSelect(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);
            mv.addObject("subResult", subResult);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 예실 대비 현황 ------------------------- */
    /* 프로젝트 조회 */
    @RequestMapping("/ex/expend/user/ExUserYesilPopInfoSelect.do")
    public ModelAndView ExUserYesilPopInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            // 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());

            try {
                // TODO : 설명 기록 (이전 주석 : 예실대비 현황 팝업(부서, 프로젝트, 부문) 목록 조회)
                result = userYesilService.ExUserYesilPop(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExUserYesilPopInfoSelect.do >> userYesilService.ExUserYesilPop(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예산단위그룹 조회 */
    @RequestMapping("/ex/expend/user/ExUserYesil2BudgetGrInfo.do")
    public ModelAndView ExUserYesil2BudgetGrInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            // 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());

            try {
                // TODO : 설명 기록 (이전 주석 : 예실대비2 현황 팝업 예산단위그룹 목록 조회)
                result = userYesilService.ExUserYesil2BudgetGrInfo(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExUserYesil2BudgetGrInfo.do >> userYesilService.ExUserYesil2BudgetGrInfo(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예산단위 조회 */
    @RequestMapping("/ex/expend/user/ExUserYesil2BudgetDeptInfo.do")
    public ModelAndView ExUserYesil2BudgetDeptInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            // 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());

            try {
                // TODO : 설명 기록 (이전 주석 : 예실대비2 현황 팝업 예산단위 목록 조회)
                result = userYesilService.ExUserYesil2BudgetDeptInfo(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExUserYesil2BudgetDeptInfo.do >> userYesilService.ExUserYesil2BudgetDeptInfo(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 사업계획 조회 */
    @RequestMapping("/ex/expend/user/ExUserYesil2BizPlanInfo.do")
    public ModelAndView ExUserYesil2BizPlanInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            // 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());

            try {
                // TODO : 설명 기록 (이전 주석 : 예실대비2 현황 팝업 사업계획 목록 조회)
                result = userYesilService.ExUserYesil2BizPlanInfo(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExUserYesil2BizPlanInfo.do >> userYesilService.ExUserYesil2BizPlanInfo(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예산계정 조회 */
    @RequestMapping("/ex/expend/user/ExUserYesil2BudgetAcctInfo.do")
    public ModelAndView ExUserYesil2BudgetAcctInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            // 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());

            try {
                // TODO : 설명 기록 (이전 주석 : 예실대비2 현황 팝업 사업계획 목록 조회)
                result = userYesilService.ExUserYesil2BudgetAcctInfo(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExUserYesil2BudgetAcctInfo.do >> userYesilService.ExUserYesil2BudgetAcctInfo(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예실대비2(PIVOT) 조회 */
    @RequestMapping("/ex/expend/user/ExUserYesil2InfoSelect.do")
    public ModelAndView ExUserYesil2InfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            // 회사코드 확인
            params.put("erpCompSeq", codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq()));
            params.put("compSeq", loginVo.getCompSeq());
            // ERP 부서 체크 
            params.put("deptAutoSeq", loginVo.getErpEmpCd());

            try {
                // TODO : 설명 기록 (이전 주석 : 예실대비2 현황 팝업 사업계획 목록 조회)
                result = userYesilService.ExUserYesil2InfoSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExUserYesil2InfoSelect.do >> userYesilService.ExUserYesil2InfoSelect(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("result", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    private void ExCommonInterlockUpdate(String expendSeq, LoginVO loginVo, Map<String, Object> params, HttpServletRequest request, String revisionHistory) throws Exception {

        try {
            // 결재중 수정인 경우 복사 후
            ExpendVO expendVo = new ExpendVO();

            // Interlock 업데이트 관련 변수
            Map<String, Object> formInfo = new HashMap<String, Object>();
            Map<String, Object> interlockParam = new HashMap<String, Object>();

            expendVo.setExpendSeq(expendSeq);

            try {
                // TODO : 설명 기록
                expendVo = userService.ExUserExpendInfoSelect(expendVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] ExCommonInterlockUpdate >> userService.ExUserExpendInfoSelect(expendVo);", expendVo);
                throw new Exception(e);
            }

            // 결재중 혹은 종결건에대해서만 진행한다.
            if (!expendVo.getExpendStatCode().equals(commonCode.EMPTYSTR) && !expendVo.getExpendStatCode().equals("999") && !expendVo.getExpendStatCode().equals("100") && !expendVo.getErpSendYN().equals(commonCode.EMPTYYES)) {

                ResultVO historyMap = new ResultVO();

                Map<String, Object> appdocParam = new HashMap<String, Object>();

                // 변경내역 입력 (본문 양식도 넘어줘야한다. 따라서 기존 본문도구해야한다.)
                appdocParam.put(commonCode.DOCSEQ, expendVo.getDocSeq());
                appdocParam.put("modifyReason", revisionHistory);
                appdocParam.put("createdBy", loginVo.getUniqId());
                appdocParam.put(commonCode.EXPENDSEQ, expendVo.getExpendSeq());

                historyMap.setParams(appdocParam);

                try {
                    // TODO : 설명 기록
                    userService.ExExpendEditHistoryInsert(historyMap);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] ExCommonInterlockUpdate >> userService.ExExpendEditHistoryInsert(historyMap);", historyMap);
                    throw new Exception(e);
                }

                // 양식 정보
                if (!params.containsKey("formInfo")) {
                    ExpInfo.CoreLogNotLoop("파리미터 정보가 누락되었습니다. (formInfo)", params);
                    throw new Exception("파리미터 정보가 누락되었습니다. (formInfo)");
                }
                formInfo = CommonConvert.CommonGetJSONToMap(params.get("formInfo").toString());

                // Interlock 정보 업데이트를 위해 변수 담아준다. (resultVo에는 docSeq가 없어 code에 담아준다)
                interlockParam.put("processId", formInfo.get("formDTp").toString());
                interlockParam.put("approKey", formInfo.get("formDTp").toString() + "_EX_" + expendVo.getExpendSeq());

                interlockParam.put("interlockName", InterlockName.PREVIOUSBUTTONKR.toString());
                interlockParam.put("interlockNameEn", InterlockName.PREVIOUSBUTTONEN.toString());
                interlockParam.put("interlockNameJp", InterlockName.PREVIOUSBUTTONJP.toString());
                interlockParam.put("interlockNameCn", InterlockName.PREVIOUSBUTTONKR.toString());

                interlockParam.put("docSeq", expendVo.getDocSeq());
                interlockParam.put("formSeq", formInfo.get("formSeq").toString());
                interlockParam.put("expendSeq", expendVo.getExpendSeq());
                interlockParam.put("eapCallDomain", CommonConvert.CommonGetStr((appdocParam == null ? "" : appdocParam.get("eapCallDomain"))));

                interlockParam.put("header", commonCode.EMPTYSTR);
                interlockParam.put("content", commonCode.EMPTYSTR);
                interlockParam.put("footer", commonCode.EMPTYSTR);

                // 전자결재 title 조회 후 넘겨줘야한다.
                if (!expendVo.getDocSeq().equals(commonCode.EMPTYSTR)) {
                    ResultVO tResult = new ResultVO();
                    tResult.setParams(interlockParam);

                    try {
                        // TODO : 설명 기록
                        tResult = codeService.ExExpendDocInfoSelect(tResult);
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] ExCommonInterlockUpdate >> codeService.ExExpendDocInfoSelect(tResult);", tResult);
                        throw new Exception(e);
                    }

                    interlockParam.put("docTitle", tResult.getaData().get("docTitle").toString());
                }

                // Interlock 정보 업데이트
                try {
                    this.ExDocMake(interlockParam, request);

                    StringBuilder sb = new StringBuilder();
                    sb.append(System.getProperty("line.separator"));
                    sb.append("processId : ");
                    sb.append(interlockParam.get("processId"));
                    sb.append(System.getProperty("line.separator"));
                    sb.append("docId : ");
                    sb.append(interlockParam.get("docSeq"));
                    sb.append(System.getProperty("line.separator"));
                    sb.append("formId : ");
                    sb.append(interlockParam.get("docSeq"));
                    sb.append(System.getProperty("line.separator"));
                    sb.append("approKey : ");
                    sb.append(interlockParam.get("approKey"));
                    sb.append(System.getProperty("line.separator"));
                    sb.append("eapCallDomain : ");
                    sb.append(interlockParam.get("eapCallDomain"));
                    sb.append(System.getProperty("line.separator"));
                    sb.append("history : ");
                    sb.append(revisionHistory);

                    ExpInfo.ProcessLog(sb.toString());
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] ExCommonInterlockUpdate >> this.ExDocMake(interlockParam, request);", interlockParam);
                    throw new Exception(e);
                }
            }

        } catch (Exception e) {
            logger.error(e);
        }
    }

    /* 지출결의 가져오기 리스트 조회 */
    @RequestMapping("/ex/expend/user/ExExpendHistoryListSelect.do")
    public ModelAndView ExExpendHistoryListSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ResultVO result = new ResultVO();

            params.put("compSeq", loginVo.getCompSeq());
            params.put("empSeq", loginVo.getUniqId());
            result.setParams(CommonConvert.CommonSetMapCopy(params, result.getParams()));

            try {
                // TODO : 설명 기록
                result = userService.ExExpendHistoryListSelect(result);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ExExpendHistoryListSelect.do >> userService.ExExpendHistoryListSelect(result);", result);
                throw new Exception(e);
            }

            mv.addObject("aaData", result.getAaData());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ResultVO().getAaData());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ResultVO().getAaData());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 가져오기 V2 반영 [데이터 반영] */
    @RequestMapping("/ex/user/expend/list/ExExpendHistoryReflectV2.do")
    public ModelAndView ExExpendHistoryReflectV2(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO resultVo = new ResultVO();

            boolean isSlipMode = Boolean.parseBoolean(params.get("isSlipMode").toString());

            // 항목단위 입력인 경우 진행
            if (!isSlipMode) {
                ExExpendListVO listVo = new ExExpendListVO(CommonConvert.CommonGetJSONToMap(params.get("listVo").toString()));
                listVo.setCompSeq(loginVo.getCompSeq());

                try {
                    // TODO : 설명 기록
                    resultVo = listService.ExExpendHistoryReflect(loginVo, listVo, conVo, params.get("newExpendSeq").toString());
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflectV2.do >> listService.ExExpendHistoryReflect(loginVo, listVo, conVo, params.get(\"newExpendSeq\").toString());", listVo);
                    throw new Exception(e);
                }
            } else {
                // 기본 항목 생성
                ExExpendListVO slipList = new ExExpendListVO();

                slipList.setCompSeq(loginVo.getCompSeq());
                slipList.setExpendSeq(params.get("newExpendSeq").toString());

                try {
                    // TODO : 설명 기록
                    slipList = listService.ExListInfoInsert(slipList);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflectV2.do >> listService.ExListInfoInsert(slipList);", slipList);
                    throw new Exception(e);
                }

                try {
                    // TODO : 설명 기록
                    slipList = listService.ExUserListInfoSelect(slipList);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflectV2.do >> listService.ExUserListInfoSelect(slipList);", slipList);
                    throw new Exception(e);
                }

                ExExpendListVO listVo = new ExExpendListVO(CommonConvert.CommonGetJSONToMap(params.get("listVo").toString()));

                try {
                    // TODO : 설명 기록
                    resultVo = listService.ExExpendHistoryReflectSlipMode(loginVo, listVo, conVo, params.get("newExpendSeq").toString(), slipList);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflectV2.do >> listService.ExExpendHistoryReflectSlipMode(loginVo, listVo, conVo, params.get(\"newExpendSeq\").toString(), slipList);", slipList);
                    throw new Exception(e);
                }

                // 항목 금액정보 업데이트
                Map<String, Object> amtParam = new HashMap<String, Object>();

                amtParam.put("amt", slipList.getAmt());
                amtParam.put("stdAmt", slipList.getStdAmt());
                amtParam.put("taxAmt", slipList.getTaxAmt());
                amtParam.put("subStdAmt", slipList.getSubStdAmt());
                amtParam.put("subTaxAmt", slipList.getSubTaxAmt());
                amtParam.put("expendSeq", slipList.getExpendSeq());
                amtParam.put("listSeq", slipList.getListSeq());

                try {
                    // TODO : 설명 기록
                    listService.ExListAmtEdit(amtParam);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflectV2.do >> listService.ExListAmtEdit(amtParam);", amtParam);
                    throw new Exception(e);
                }
            }

            ExpendVO expendVo = new ExpendVO();

            expendVo.setExpendSeq(params.get("expendSeq").toString());
            expendVo = userService.ExUserExpendInfoSelect(expendVo);

            Map<String, Object> resultDate = new HashMap<String, Object>();

            resultDate.put("expendDate", expendVo.getExpendDate());
            resultDate.put("expendReqDate", expendVo.getExpendReqDate());

            mv.addObject("basicDateValue", resultDate);
            mv.addObject("aaData", resultVo);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("basicDateValue", new HashMap<String, Object>());
            mv.addObject("aaData", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("basicDateValue", new HashMap<String, Object>());
            mv.addObject("aaData", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 가져오기 V2 반영 [프로그레스 준비] */
    @RequestMapping("/ex/user/expend/list/ExExpendHistoryReflectV2List.do")
    public ModelAndView ExExpendHistoryReflectV2List(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO resultVo = new ResultVO();

            List<ExExpendListVO> expendListVo = new ArrayList<ExExpendListVO>();

            // ERP 연결정보
            params.put("compSeq", loginVo.getCompSeq());
            params.put("useSw", conVo.getErpTypeCode());
            params.put("erpCompSeq", loginVo.getErpCoCd());
            resultVo.setParams(params);

            try {
                // TODO : 설명 기록 (이전 주석 : 지출결의 가져오기 진행 시 예산체크 진행 후 이상없을 경우만 진행)
                listService.ExExpendHistoryBudgetInfoSelect(resultVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflectV2List.do >> listService.ExExpendHistoryBudgetInfoSelect(resultVo);", resultVo);
                throw new Exception(e);
            }

            if (!resultVo.getResultCode().equals(commonCode.FAIL)) {

                // 반영 할 항목 리스트 조회
                expendListVo = listService.ExExpendListSelect(params);

                // 작성중인 지출결의 정보 삭제 진행
                List<ExExpendListVO> listListVo = new ArrayList<ExExpendListVO>();
                Map<String, Object> tMap = new HashMap<String, Object>();

                tMap.put("expendSeq", params.get("newExpendSeq").toString());

                try {
                    // TODO : 설명 기록
                    listListVo = listService.ExExpendListSelect(tMap);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflectV2List.do >> listService.ExExpendListSelect(tMap);", tMap);
                    throw new Exception(e);
                }

                try {
                    // TODO : 설명 기록
                    listService.ExListListInfoDelete(listListVo);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflectV2List.do >> listService.ExListListInfoDelete(listListVo);", listListVo);
                    throw new Exception(e);
                }

                mv.addObject("expendListVo", expendListVo);
                mv.addObject("resultCode", commonCode.SUCCESS);
            } else {
                mv.addObject("resultCode", commonCode.FAIL);
            }

            mv.addObject("aaData", resultVo);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("expendListVo", new ArrayList<ExExpendListVO>());
            mv.addObject("resultCode", commonCode.FAIL);
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("expendListVo", new ArrayList<ExExpendListVO>());
            mv.addObject("resultCode", commonCode.FAIL);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 가져오기 반영 */
    @RequestMapping("/ex/user/expend/list/ExExpendHistoryReflect.do")
    public ModelAndView ExExpendHistoryReflect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            List<ExExpendListVO> expendListVo = new ArrayList<ExExpendListVO>();
            List<ExExpendListVO> listListVo = new ArrayList<ExExpendListVO>();

            ResultVO resultVo = new ResultVO();

            boolean isSlipMode = false;

            // ERP 연결정보
            params.put("compSeq", loginVo.getCompSeq());
            params.put("useSw", conVo.getErpTypeCode());
            params.put("erpCompSeq", loginVo.getErpCoCd());
            resultVo.setParams(params);

            try {
                // TODO : 설명 기록 (기존 주석 : 지출결의 가져오기 진행 시 예산체크 진행 후 이상없을 경우만 진행)
                listService.ExExpendHistoryBudgetInfoSelect(resultVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> listService.ExExpendHistoryBudgetInfoSelect(resultVo);", resultVo);
                throw new Exception(e);
            }

            if (!resultVo.getResultCode().equals(commonCode.FAIL)) {
                try {
                    // TODO : 설명 기록 (이전 주석 : 반영 할 항목 리스트 조회)
                    expendListVo = listService.ExExpendListSelect(params);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> listService.ExExpendListSelect(params);", params);
                    throw new Exception(e);
                }

                // 분개단위 입력 여부 확인
                isSlipMode = Boolean.parseBoolean(params.get("isSlipMode").toString());

                // 작성중인 항목 리스트 조회
                Map<String, Object> tMap = new HashMap<String, Object>();
                tMap.put("expendSeq", params.get("newExpendSeq").toString());

                try {
                    // TODO : 설명 기록
                    listListVo = listService.ExExpendListSelect(tMap);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> listService.ExExpendListSelect(tMap);", tMap);
                    throw new Exception(e);
                }

                try {
                    // TODO : 설명 기록 (이전 주석 : 작성중인 지출결의 정보 삭제 진행)
                    listService.ExListListInfoDelete(listListVo);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> listService.ExListListInfoDelete(listListVo);", listListVo);
                    throw new Exception(e);
                }

                if (!isSlipMode) {

                    // 항목단위 입력인 경우 진행
                    for (ExExpendListVO listVo : expendListVo) {

                        // 지출결의 가져오기 진행
                        listVo.setCompSeq(loginVo.getCompSeq());

                        try {
                            // TODO : 설명 기록
                            resultVo = listService.ExExpendHistoryReflect(loginVo, listVo, conVo, params.get("newExpendSeq").toString());
                        } catch (Exception e) {
                            ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> listService.ExExpendHistoryReflect(loginVo, listVo, conVo, params.get(\"newExpendSeq\").toString());", listVo);
                            throw new Exception(e);
                        }

                    }
                } else {

                    // 분개단위 입력인 경우 진행

                    // 기타 항목 생성
                    ExExpendListVO slipList = new ExExpendListVO();

                    slipList.setCompSeq(loginVo.getCompSeq());
                    slipList.setExpendSeq(params.get("newExpendSeq").toString());

                    try {
                        // TODO : 설명 기록
                        slipList = listService.ExListInfoInsert(slipList);
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> listService.ExListInfoInsert(slipList);", slipList);
                        throw new Exception(e);
                    }

                    try {
                        // TODO : 설명 기록
                        slipList = listService.ExUserListInfoSelect(slipList);
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> listService.ExUserListInfoSelect(slipList);", slipList);
                        throw new Exception(e);
                    }

                    for (ExExpendListVO listVo : expendListVo) {

                        // 지출결의 가져오기 진행
                        try {
                            // TODO : 설명 기록
                            resultVo = listService.ExExpendHistoryReflectSlipMode(loginVo, listVo, conVo, params.get("newExpendSeq").toString(), slipList);
                        } catch (Exception e) {
                            ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> listService.ExExpendHistoryReflectSlipMode(loginVo, listVo, conVo, params.get(\"newExpendSeq\").toString(), slipList);", listVo);
                            throw new Exception(e);
                        }
                    }

                    /* 항목 금액정보 업데이트 */
                    Map<String, Object> amtParam = new HashMap<String, Object>();

                    amtParam.put("amt", slipList.getAmt());
                    amtParam.put("stdAmt", slipList.getStdAmt());
                    amtParam.put("taxAmt", slipList.getTaxAmt());
                    amtParam.put("subStdAmt", slipList.getSubStdAmt());
                    amtParam.put("subTaxAmt", slipList.getSubTaxAmt());
                    amtParam.put("expendSeq", slipList.getExpendSeq());
                    amtParam.put("listSeq", slipList.getListSeq());

                    listService.ExListAmtEdit(amtParam);
                }

                ExpendVO expendVo = new ExpendVO();

                expendVo.setExpendSeq(params.get("expendSeq").toString());

                try {
                    // TODO : 설명 기록
                    expendVo = userService.ExUserExpendInfoSelect(expendVo);
                } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendHistoryReflect.do >> userService.ExUserExpendInfoSelect(expendVo);", expendVo);
                    throw new Exception(e);
                }

                Map<String, Object> resultDate = new HashMap<String, Object>();

                resultDate.put("expendDate", expendVo.getExpendDate());
                resultDate.put("expendReqDate", expendVo.getExpendReqDate());

                mv.addObject("basicDateValue", resultDate);
            }

            mv.addObject("aaData", resultVo);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("basicDateValue", new HashMap<String, Object>());
            mv.addObject("aaData", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("basicDateValue", new HashMap<String, Object>());
            mv.addObject("aaData", new ResultVO());
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 버튼설정 조회 테스트 */
    @RequestMapping("/ex/user/expend/list/ExExpendButtonInfo.do")
    public ModelAndView ExExpendButtonInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            ResultVO result = new ResultVO();
            params.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpVO().getGroupSeq());

            try {
                result = userService.ExExpendButtonInfoSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/list/ExExpendButtonInfo.do >> userService.ExExpendButtonInfoSelect(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("result", new ResultVO());
        } catch (Exception e) {
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
            mv.addObject("result", result);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 관리항목 필수여부 조회 */
    @RequestMapping("/ex/user/expend/slip/ExExpendMngNecessaryOptionInfoSelect.do")
    public ModelAndView ExExpendMngNecessaryOptionInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            ResultVO result = new ResultVO();

            try {
                // TODO : 설명 기록
                result = mngService.ExExpendMngNecessaryOptionInfoSelect(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/slip/ExExpendMngNecessaryOptionInfoSelect.do >> mngService.ExExpendMngNecessaryOptionInfoSelect(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (Exception e) {
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
            mv.addObject("result", result);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    @RequestMapping("/ex/user/report/ExUserETaxReportList.do")
    public ModelAndView ExUserTtaxReportList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {

            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            params.put("empSeq", loginVo.getUniqId());
            params.put("compSeq", loginVo.getCompSeq());

            result.setParams(params);

            try {
                // TODO : 설명 기록
                result = eTaxService.ExUserTtaxReportList(result, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/report/ExUserETaxReportList.do >> eTaxService.ExUserTtaxReportList(result, conVo);", result);
                throw new Exception(e);
            }

            result.setSuccess();

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
            mv.addObject("result", result);
        } catch (Exception e) {
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
            mv.addObject("result", result);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 엑셀 다운로드 */
    /*
     * 필요파라미터 fileName : 파일명칭( 예 : 카드사용현황 ) listData : 엑셀 다운로드 할 데이터 excelHeader : 엑셀 헤더 ( Map으로 되어있음 ) 수정 : 카드사용현황은 /ex/user/CommonNewExcelDown.do을 이용하므로 제거 by Kwon Oh Gwang on 2019-01-24
     */
    @RequestMapping("/ex/user/CommonExcelDown.do")
    public void ExUserCardReportListExcelDown(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {

        /* parameter : fromDate, toDate, reqDate, docNo, docTitle */
        FileInputStream fis = null;
        BufferedInputStream in = null;
        ByteArrayOutputStream bStream = null;

        try {
            ResultVO result = new ResultVO();

            params.put("langCode", CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
            params.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpVO().getGroupSeq());
            params.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.ERPCOMPSEQ));
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
            params.put(commonCode.DEPTSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));

            switch (params.get("fileName").toString()) {
                case "지출결의현황":
                    try {
                        // TODO : 설명 기록
                        result = userReportService.ExUserExpendReportListInfoSelect(params);
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] /ex/user/CommonExcelDown.do >> userReportService.ExUserExpendReportListInfoSelect(params);", params);
                        throw new Exception(e);
                    }

                    break;
                case "세금계산서현황":
                    result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;
                case "나의품의서현황" :
                	result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                	break;
                case "품의서반환" :
                	result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                	break;
                case "나의결의서현황" :
                	result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                	break;
                case "나의 예실대비 현황(ERPiU)" :
                	result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                	break;
                default:
                    break;
            }

            if (result == null) {
                result = new ResultVO();
            }

            // 파일 명칭 (카드사용현황20170925_사용지시퀀스.xlsx)
            String fileName = commonCode.EMPTYSTR;
            Calendar day = Calendar.getInstance();
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

            fileName = params.get("fileName").toString();
            fileName = fileName + df.format(day.getTime()) + "_" + CommonConvert.CommonGetEmpInfo().get(commonCode.EMPSEQ).toString() + ".xlsx";

            // 파일 경로 (d:/upload/expend/temp/excel/)
            String filePath = commonCode.EMPTYSTR;

            // 회계모듈 기본 경로 확인
            Map<String, Object> tData = new HashMap<String, Object>();

            tData.put("osType", CommonUtil.osType());
            tData.put("pathSeq", commonCode.EXPPATHSEQ);
            tData.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.GROUPSEQ).toString());

            // 기본 경로 조회
            try {
                // TODO : 설명 기록
                tData = codeService.ExCommonExpGroupPathSelect(tData);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/CommonExcelDown.do >> tData = codeService.ExCommonExpGroupPathSelect(tData);", tData);
                throw new Exception(e);
            }

            if (tData == null || tData.get("absolPath") == null || tData.get("absolPath").toString().equals(commonCode.EMPTYSTR)) {
                throw new Exception("그룹 패스를 확인하여 주시길 바랍니다.");
            }

            filePath = tData.get("absolPath").toString() + File.separator + commonCode.EXCELPATH + File.separator;

            if (CommonExcel.CreateExcelFile(result.getAaData(), params, filePath, fileName)) {
                /* 파일 리턴 */
                CommonExcel.ExcelDownload(fis, in, bStream, (filePath + fileName), fileName, request, response);
            }

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        } finally {
            if (bStream != null) {
                try {
                    bStream.close();
                } catch (Exception ignore) {
                    logger.error(ignore);
                }
            }
            if (in != null) {
                try {
                    in.close();
                } catch (Exception ignore) {
                    logger.error(ignore);
                }
            }
            if (fis != null) {
                try {
                    fis.close();
                } catch (Exception ignore) {
                    logger.error(ignore);
                }
            }
        }
    }

    @RequestMapping("/ex/user/YesilExcelDown.do")
    public void ExUserYesilExcelDown(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {

        /* parameter : fromDate, toDate, reqDate, docNo, docTitle */
        FileInputStream fis = null;
        BufferedInputStream in = null;
        ByteArrayOutputStream bStream = null;

        try {
            ResultVO result = new ResultVO();

            params.put("langCode", CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
            params.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpVO().getGroupSeq());
            params.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.ERPCOMPSEQ));
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
            params.put(commonCode.DEPTSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));

            switch (params.get("fileName").toString()) {
                case "나의 예실대비현황(iCUBE)" :
                	result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                	break;
                default:
                    break;
            }

            if (result == null) {
                result = new ResultVO();
            }

            // 파일 명칭 (카드사용현황20170925_사용지시퀀스.xlsx)
            String fileName = commonCode.EMPTYSTR;
            Calendar day = Calendar.getInstance();
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());

            fileName = params.get("fileName").toString();
            fileName = fileName + df.format(day.getTime()) + "_" + CommonConvert.CommonGetEmpInfo().get(commonCode.EMPSEQ).toString() + ".xlsx";

            // 파일 경로 (d:/upload/expend/temp/excel/)
            String filePath = commonCode.EMPTYSTR;

            // 회계모듈 기본 경로 확인
            Map<String, Object> tData = new HashMap<String, Object>();

            tData.put("osType", CommonUtil.osType());
            tData.put("pathSeq", commonCode.EXPPATHSEQ);
            tData.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.GROUPSEQ).toString());

            // 기본 경로 조회
            try {
                // TODO : 설명 기록
                tData = codeService.ExCommonExpGroupPathSelect(tData);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/YesilExcelDown.do >> tData = codeService.ExCommonExpGroupPathSelect(tData);", tData);
                throw new Exception(e);
            }

            if (tData == null || tData.get("absolPath") == null || tData.get("absolPath").toString().equals(commonCode.EMPTYSTR)) {
                throw new Exception("그룹 패스를 확인하여 주시길 바랍니다.");
            }

            filePath = tData.get("absolPath").toString() + File.separator + commonCode.EXCELPATH + File.separator;
            if(params.get("fileName").toString().equals("나의 예실대비현황(iCUBE)")) {
            	if(CommonExcel.CreateExcelFile_plusSubTable(result.getAaData(), params, filePath, fileName)) {
            		CommonExcel.ExcelDownload(fis, in, bStream, (filePath + fileName), fileName, request, response);
            	}
            }

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        } finally {
            if (bStream != null) {
                try {
                    bStream.close();
                } catch (Exception ignore) {
                    logger.error(ignore);
                }
            }
            if (in != null) {
                try {
                    in.close();
                } catch (Exception ignore) {
                    logger.error(ignore);
                }
            }
            if (fis != null) {
                try {
                    fis.close();
                } catch (Exception ignore) {
                    logger.error(ignore);
                }
            }
        }
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/ex/user/CommonNewExcelDown.do", method = RequestMethod.POST)
    @ResponseBody
    public Object ExUserCardReportListNewExcelDown(@RequestBody Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
        /* parameter : fromDate, toDate, reqDate, docNo, docTitle */

        try {
            ResultVO result = new ResultVO();
            PaginationInfo paginationInfo = new PaginationInfo();
            JSONObject excelListJson = new JSONObject();
            ExReportCardVO reportCardVO = new ExReportCardVO();

            params.put(commonCode.LANGCODE, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
            params.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpVO().getGroupSeq());
            params.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.ERPCOMPSEQ));
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
            params.put(commonCode.DEPTSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));

            paginationInfo.setCurrentPageNo(EgovStringUtil.zeroConvert(CommonConvert.CommonGetStr(params.get("page"))));
            paginationInfo.setPageSize(EgovStringUtil.zeroConvert(CommonConvert.CommonGetStr(params.get("pageTotalSize"))));

            switch (params.get("fileName").toString()) {
                case "지출결의현황":
                    result = null;
                    break;
                case "카드사용현황":
                    try {
                        reportCardVO.setCompSeq(CommonConvert.CommonGetStr(params.get("compSeq")));
                        reportCardVO.setEmpSeq(CommonConvert.CommonGetEmpVO().getUniqId());
                        reportCardVO.setLangCode(CommonConvert.CommonGetStr(params.get("langCode")));
                        reportCardVO.setCardNum(CommonConvert.CommonGetStr(params.get("cardNum")));
                        reportCardVO.setCardName(CommonConvert.CommonGetStr(params.get("cardName")));
                        reportCardVO.setFromDate(CommonConvert.CommonGetStr(params.get("fromDate")));
                        reportCardVO.setToDate(CommonConvert.CommonGetStr(params.get("toDate")));
                        reportCardVO.setMercName(CommonConvert.CommonGetStr(params.get("mercName")));
                        reportCardVO.setDocSts(CommonConvert.CommonGetStr(params.get("docSts")));

                        result = userReportService.ExUserCardReportListInfoSelect(reportCardVO, paginationInfo);
                    } catch (Exception e) {
                        ExpInfo.CLog("[에러발생] /ex/user/CommonNewExcelDown.do >> userReportService.ExUserCardReportListInfoSelect(params, paginationInfo);", params);
                        throw new Exception(e);
                    }

                    result.setAaData((List<Map<String, Object>>) result.getaData().get("list"));
                    break;
                case "세금계산서현황":
                    result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;
                default:
                    break;
            }

            if (result == null) {
                result = new ResultVO();
            }

            // js excel에서 사용 할 형태로 변환
            Map<String, Object> resultMap = new HashMap<String, Object>();
            int resultCnt = 0;
            resultCnt = result.getAaData().size();

            resultMap.put("list", result.getAaData());
            resultMap.put("totalCount", resultCnt);

            excelListJson = JSONObject.fromObject(resultMap);

            return excelListJson;
        } catch (Exception e) {
            logger.error(e);
        }

        return new JSONObject();
    }


    /* /ex/expend/user/ChkAcctReceptYN.do */
    @RequestMapping("/ex/expend/user/ChkAcctReceptYN.do")
    public ModelAndView ChkAcctReceptYN(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ResultVO result = new ResultVO();

            params.put(commonCode.ERPCOMPSEQ, loginVo.getErpCoCd());

            try {
                result = codeService.ExCommonAcctReceptYN(params, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/user/ChkAcctReceptYN.do >> codeService.ExCommonAcctReceptYN(params, conVo);", params);
                throw new Exception(e);
            }

            if (result == null) {
                result = new ResultVO();
                result.setFail("");
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setFail("");
            mv.addObject("result", result);
        } catch (Exception e) {
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setFail("");
            mv.addObject("result", result);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* /ex/user/report/ExUserInterfaceTransfer.do */
    /* 세금계산서 현황 이관 처리 진행 */
    @RequestMapping("/ex/user/report/ExUserInterfaceTransfer.do")
    public ModelAndView ExUserInterfaceTransfer(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ResultVO result = new ResultVO();

            params.put(commonCode.ERPCOMPSEQ, loginVo.getErpCoCd());
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO().getCompSeq());
            params.put(commonCode.EMPSEQ, CommonConvert.CommonGetEmpVO().getUniqId());

            try {
                // TODO : 설명 기록
                result = userReportService.ExUserInterfaceTransfer(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/report/ExUserInterfaceTransfer.do >> userReportService.ExUserInterfaceTransfer(params);", params);
                throw new Exception(e);
            }

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setFail("세금계산서 이관에 실패하였습니다.", e);
        } catch (Exception e) {
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setFail("세금계산서 이관에 실패하였습니다.", e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* /ex/user/report/ExUserInterfaceTransferCancel.do */
    /* 세금계산서 현황 이관 취소 진행 */
    @RequestMapping("/ex/user/report/ExUserInterfaceTransferCancel.do")
    public ModelAndView ExUserInterfaceTransferCancel(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ResultVO result = new ResultVO();

            params.put(commonCode.ERPCOMPSEQ, loginVo.getErpCoCd());
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO().getCompSeq());
            params.put(commonCode.EMPSEQ, CommonConvert.CommonGetEmpVO().getUniqId());

            try {
                // TODO : 설명 기록
                result = userReportService.ExUserInterfaceTransferCancel(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/report/ExUserInterfaceTransferCancel.do >> userReportService.ExUserInterfaceTransferCancel(params);", params);
                throw new Exception(e);
            }

            result.setSuccess();

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setFail("세금계산서 이관 취소에 실패하였습니다.", e);
        } catch (Exception e) {
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setFail("세금계산서 이관 취소에 실패하였습니다.", e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* /ex/user/report/ExUserInterfaceTransferHistory.do */
    /* 세금계산서 현황 이관 내역 조회 */
    @RequestMapping("/ex/user/report/ExUserInterfaceTransferHistory.do")
    public ModelAndView ExUserInterfaceTransferHistory(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ResultVO result = new ResultVO();

            params.put(commonCode.ERPCOMPSEQ, loginVo.getErpCoCd());
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpVO().getCompSeq());
            params.put(commonCode.EMPSEQ, CommonConvert.CommonGetEmpVO().getUniqId());
            if (!CommonConvert.CommonGetStr(params.get("userSe")).equals("")) {
                params.put(commonCode.EMPSEQ, "ADMIN");
            }

            try {
                // TODO : 설명 기록
                result.setAaData(userReportService.ExUserETaxTransferHistory(params));
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/report/ExUserInterfaceTransferHistory.do >> userReportService.ExUserETaxTransferHistory(params)", params);
                throw new Exception(e);
            }

            result.setSuccess();

            mv.addObject("result", result);

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setFail("세금계산서 이관 이력 조회에 실패하였습니다.", e);
        } catch (Exception e) {
            logger.error(e);

            ResultVO result = new ResultVO();
            result.setFail("세금계산서 이관 이력 조회에 실패하였습니다.", e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    @RequestMapping("/expend/ex/user/card/ExCardInfoMapReset.do")
    public ModelAndView ExCardInfoMapReset(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            try {
                // TODO : 설명 기록 (이전 주석 : 수정)
                resultVo = userCardService.ExExpendCardInfoMapReset(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/card/ExCardInfoMapReset.do >> userCardService.ExExpendCardInfoMapReset(params);", params);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    @RequestMapping("/expend/ex/user/etax/ExETaxInfoMapReset.do")
    public ModelAndView ExETaxInfoMapReset(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            ExCommonResultVO resultVo = new ExCommonResultVO();

            try {
                // TODO : 설명 기록
                resultVo = eTaxService.ExExpendETaxInfoMapReset(params);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /expend/ex/user/etax/ExETaxInfoMapReset.do >> eTaxService.ExExpendETaxInfoMapReset(param);", params);
                throw new Exception(e);
            }

            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());

        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }

    @RequestMapping("/expend/ex/ExErpConnectReset.do")
    public ModelAndView ExErpConnectReset(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            CommonErpConnect.connections.clear();
        } catch (Exception e) {
            ExpInfo.CLog("[에러발생] CommonErpConnect 초기화에 실패하였습니다.", params);
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /**
     * ERPiU 회계 기수 정보 조회
     *
     * @param params
     * @param request
     * @return : noAccSeq, dtFrom, dtTo
     * @throws Exception
     */
    @RequestMapping("/expend/ex/ExERPiUAccSeqInfo.do")
    public ModelAndView ExERPiUAccSeqInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ERPiUAccSeq accSeq = new ERPiUAccSeq();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();

            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                accSeq.setFail("ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                mv.addObject("result", accSeq.getMap());

                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
                // TODO : 설명 기록
                accSeq = codeService.ExERPiUAccSeqInfo(accSeq, conVo);
                accSeq.setSuccess("ERPiU 회계기수 조회에 성공하였습니다.");
                mv.addObject("result", accSeq.getMap());
            } catch (Exception e) {
                accSeq.setFail("ERPiU 회계기수 조회에 실패하였습니다.");
                mv.addObject("result", accSeq.getMap());

                ExpInfo.CLog("[에러발생] /expend/ex/ExERPiUAccSeqInfo.do >> eTaxService.ExExpendETaxInfoMapReset(param);", params);
                throw new Exception(e);
            }

        } catch (NotFoundLoginSessionException e) {
            if (accSeq.isResultCode()) {
                accSeq.setFail("로그인정보를 확인할 수 없습니다.");
                mv.addObject("result", accSeq.getMap());
            }

            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            e.printStackTrace();
            logger.error(e);
        } catch (Exception e) {
            if (accSeq.isResultCode()) {
                accSeq.setFail("ERPiU 회계기수 조회에 실패하였습니다.");
                mv.addObject("result", accSeq.getMap());
            }

            ExpInfo.CoreLogNotLoop("[에러발생] ERPiU 회계 기수 정보를 확인할 수 없습니다. 오늘을 기준으로 ERPiU 의 FI_ACCSEQ 테이블에 데이터가 존재하는지 확인하여주세요.", params);
            e.printStackTrace();
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }


    /**
     * ERPiU 회계 기수 정보 조회
     *
     * @param params
     * @param request
     * @return : noAccSeq, dtFrom, dtTo
     * @throws Exception
     */
    @RequestMapping("/expend/ex/ExERPYesilIUAccSeqInfo.do")
    public ModelAndView ExERPYesiIiUAccSeqInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ERPiUAccSeq accSeq = new ERPiUAccSeq();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();

            try {
                // TODO : 설명 기록 (기존 주석 : ERP 연결정보 조회)
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                accSeq.setFail("ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                mv.addObject("result", accSeq.getMap());

                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
                accSeq.setNoAccSeq((String) params.get("noAccSeq"));

                // TODO : 설명 기록
                accSeq = codeService.ExERPYesilIUAccSeqInfo(accSeq, conVo);
                accSeq.setSuccess("ERPiU 회계기수 조회에 성공하였습니다.");
                mv.addObject("result", accSeq.getMap());
            } catch (Exception e) {
                accSeq.setFail("ERPiU 회계기수 조회에 실패하였습니다.");
                mv.addObject("result", accSeq.getMap());

                ExpInfo.CLog("[에러발생] /expend/ex/ExERPiUAccSeqInfo.do >> eTaxService.ExExpendETaxInfoMapReset(param);", params);
                throw new Exception(e);
            }

        } catch (NotFoundLoginSessionException e) {
            if (accSeq.isResultCode()) {
                accSeq.setFail("로그인정보를 확인할 수 없습니다.");
                mv.addObject("result", accSeq.getMap());
            }

            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            e.printStackTrace();
            logger.error(e);
        } catch (Exception e) {
            if (accSeq.isResultCode()) {
                accSeq.setFail("ERPiU 회계기수 조회에 실패하였습니다.");
                mv.addObject("result", accSeq.getMap());
            }

            ExpInfo.CoreLogNotLoop("[에러발생] ERPiU 회계 기수 정보를 확인할 수 없습니다. 오늘을 기준으로 ERPiU 의 FI_ACCSEQ 테이블에 데이터가 존재하는지 확인하여주세요.", params);
            e.printStackTrace();
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 외화입력 - 환율정보 조회 */
    @RequestMapping("/ex/user/expend/foreigncurrency/ExchangeRateInfoSelect.do")
    public ModelAndView ExchangeRateInfoSelect(@ModelAttribute ExExpendForeignCurrencyVO foreignCurrencyVO, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            ResultVO resultVo = new ResultVO();

            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
            	foreignCurrencyVO.setErpCompSeq(loginVo.getErpCoCd());
            	resultVo = listService.ExchangeRateInfoSelect(foreignCurrencyVO, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/foreigncurrency/ExchangeRateInfoSelect.do >> listService.ExchangeRateInfoSelect(ForeignCurrencyVO);", foreignCurrencyVO);
                throw new Exception(e);
            }

            mv.addObject("aData", resultVo.getaData());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 외화입력 - 올림구분 조회 */
    @RequestMapping("/ex/user/expend/foreigncurrency/RoundingTypeInfoSelect.do")
    public ModelAndView RoundingTypeInfoSelect(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            ResultVO resultVo = new ResultVO();
            ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();

            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
            	foreignCurrencyVO.setErpCompSeq(loginVo.getErpCoCd());
            	resultVo = listService.RoundingTypeInfoSelect(foreignCurrencyVO, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/foreigncurrency/RoundingTypeInfoSelect.do >> listService.RoundingTypeInfoSelect(ForeignCurrencyVO);", foreignCurrencyVO);
                throw new Exception(e);
            }

            mv.addObject("aData", resultVo.getaData());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 외화입력 - 외화계정인지 확인 */
    @RequestMapping("/ex/user/expend/foreigncurrency/CheckForeignCurrencyAcctCode.do")
    public ModelAndView CheckForeignCurrencyAcctCode(@ModelAttribute ExExpendForeignCurrencyVO foreignCurrencyVO, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            ResultVO resultVo = new ResultVO();

            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
            	foreignCurrencyVO.setErpCompSeq(loginVo.getErpCoCd());
            	resultVo = listService.CheckForeignCurrencyAcctCode(foreignCurrencyVO, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/foreigncurrency/CheckForeignCurrencyAcctCode.do >> listService.CheckForeignCurrencyAcctCode(ForeignCurrencyVO);", foreignCurrencyVO);
                throw new Exception(e);
            }

            mv.addObject("aData", resultVo.getaData());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 외화입력 - iCUBE 환율, 외화금액 소수점 자릿수 조회(iCUBE 시스템 환경설정) */
    @RequestMapping("/ex/user/expend/foreigncurrency/PointLengthInfoSelect.do")
    public ModelAndView PointLengthInfoSelect(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();
            ConnectionVO conVo = new ConnectionVO();
            ResultVO resultVo = new ResultVO();
            ExExpendForeignCurrencyVO foreignCurrencyVO = new ExExpendForeignCurrencyVO();

            try {
                // TODO : 설명 기록
                conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
                ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
            }

            try {
            	foreignCurrencyVO.setErpCompSeq(loginVo.getErpCoCd());
            	resultVo = listService.PointLengthInfoSelect(foreignCurrencyVO, conVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/user/expend/foreigncurrency/PointLengthInfoSelect.do >> listService.PointLengthInfoSelect(ForeignCurrencyVO);", foreignCurrencyVO);
                throw new Exception(e);
            }

            mv.addObject("aData", resultVo.getaData());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }

        mv.setViewName("jsonView");
        return mv;
    }

    /* 지출결의 - 지출결의 관리항목 일괄 수정 */
    @RequestMapping("/ex/expend/master/ExMasterMngUpdate.do")
    public ModelAndView ExMasterMngUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            LoginVO loginVo = new LoginVO();
            loginVo = CommonConvert.CommonGetEmpVO();

            ExCommonResultVO resultVo = new ExCommonResultVO();

            try {
                // TODO : 설명 기록 (기존 주석 : 생성)
                resultVo = mngService.ExMasterMngUpdate(params);

                mv.addObject("aaData", resultVo);
            } catch (Exception e) {
                ExpInfo.CLog("[에러발생] /ex/expend/master/ExMasterMngUpdate.do >> mngService.ExMasterMngUpdate(params);", params);
                throw new Exception(e);
            }
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("[기타알림] 로그인정보를 확인할 수 없습니다.");
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        } catch (Exception e) {
            logger.error(e);

            mv.addObject("aaData", new ExCommonResultVO());
            mv.addObject(commonCode.IFSYSTEM, "");
        }

        mv.setViewName("jsonView");
        return mv;
    }
}
