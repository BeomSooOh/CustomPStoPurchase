package expend.ex.admin.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.text.SimpleDateFormat;
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
import cmm.util.CommonUtil;
import common.helper.convert.CommonConvert;
import common.helper.excel.CommonExcel;
import common.helper.exception.CheckExistsException;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundDataException;
import common.helper.exception.NotFoundLogicException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.ExpInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.ex.ExCodeETaxAuthVO;
import common.vo.ex.ExReportCardVO;
import expend.ex.admin.acct.BExAdminAcctService;
import expend.ex.admin.card.BExAdminCardService;
import expend.ex.admin.config.BExAdminConfigService;
import expend.ex.admin.etax.BExAdminETaxService;
import expend.ex.admin.item.BExAdminItemService;
import expend.ex.admin.report.BExAdminReportService;
import expend.ex.admin.yesil.BExAdminYesilService;
//import expend.ex.admin.yesil2.BExAdminYesil2Service;
import expend.ex.admin.yesil2.FExAdminYesil2Service;
import expend.ex.user.code.BExUserCodeService;
import expend.np.admin.report.BNpAdminReportService;
import net.sf.json.JSONObject;

@Controller
public class BExAdminController {

    /* ################################################## */
    /* 변수정의 */
    /* ################################################## */
    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());
    /* 변수정의 - Service */
    @Resource(name = "BExAdminReportService")
    private BExAdminReportService reportService;
    @Resource(name = "BExAdminConfigService")
    private BExAdminConfigService adminConfig;
    @Resource(name = "BExUserCodeService")
    private BExUserCodeService codeService;
    @Resource(name = "BExAdminAcctService")
    private BExAdminAcctService acctService;
    @Resource(name = "BExAdminItemService")
    private BExAdminItemService itemService;
    @Resource(name = "BExAdminCardService")
    private BExAdminCardService cardService;
    @Resource(name = "BExAdminYesilService")
    private BExAdminYesilService yesilService;
    @Resource(name = "BExAdminETaxService")
    private BExAdminETaxService etaxService;
    @Resource(name = "BNpAdminReportService")
    private BNpAdminReportService npReportService;
    @Resource(name = "FExAdminYesil2ServiceU")
    private FExAdminYesil2Service yesil2ServiceU;
    /* 변수정의 - Class */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

    /* 계정과목 목록 조회 */
    @RequestMapping("/ex/admin/ExAdminConfigAcctListInfoSelect")
    public ModelAndView ExAdminConfigAcctListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ResultVO result = new ResultVO();
            Map<String, Object> empInfo = new HashMap<String, Object>();
            String[] keys = {commonCode.EMPSEQ};
            /* 변수값 정의 */
            empInfo = CommonConvert.CommonGetEmpInfo();
            CommonConvert.CommonSetMapCopy(empInfo, params, keys);
            result.setParams(params);
            if (CommonConvert.CommonGetStr(empInfo.get(commonCode.USERSE)).equals(commonCode.ADMIN)) {

            	/* 반환데이터 조회 */
            	try {
            		result = acctService.ExAdminConfigAcctListInfoSelect(result);

            		/* 반환데이터 검증 */
            		if (result == null) {
            			result = new ResultVO();
            			result.setParams(params);
            		}
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/admin/ExAdminConfigAcctListInfoSelect >> acctService.ExAdminConfigAcctListInfoSelect(result)", result);
                    throw new Exception(e);
            	}

                /* 반환정보 가공 */
            	mv.setViewName("jsonView");
                mv.addObject("result", result);
            } else {
                /* 반환데이터 검증 */
                result.setResultCode(commonCode.FAIL);
                result.setResultName("관리자 권한이 없습니다.");
                /* 반환정보 가공 */
                mv.setViewName("jsonView");
                mv.addObject("result", result);
            }
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminAcctService.ExAdminConfigAcctListInfoSelect 호출 오류 발생", params);
            logger.error(e);
        }
        return mv;
    }

    /* 계정과목 등록 & 수정 */
    @RequestMapping("/ex/admin/ExAdminConfigAcctInfoInsert.do")
    public ModelAndView ExAdminConfigAcctInfoInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ResultVO result = new ResultVO();
            Map<String, Object> empInfo = new HashMap<String, Object>();
            String[] keys = {commonCode.EMPSEQ};
            /* 변수값 정의 */
            empInfo = CommonConvert.CommonGetEmpInfo();
            CommonConvert.CommonSetMapCopy(empInfo, params, keys);
            result.setParams(params);
            if (CommonConvert.CommonGetStr(empInfo.get(commonCode.USERSE)).equals(commonCode.ADMIN)) {
                /* 반환데이터 조회 */
            	try {
            		result = acctService.ExAdminConfigAcctInfoInsert(result);
            		/* 반환데이터 검증 */
            		if (result == null) {
            			result = new ResultVO();
            			result.setParams(params);
            		}
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/admin/ExAdminConfigAcctInfoInsert.do >> acctService.ExAdminConfigAcctInfoInsert(result)", result);
                    throw new Exception(e);
            	}
                /* 반환정보 가공 */
            	mv.setViewName("jsonView");
                mv.addObject("result", result);
            } else {
                /* 반환데이터 검증 */
                result.setResultCode(commonCode.FAIL);
                result.setResultName("관리자 권한이 없습니다.");
                /* 반환정보 가공 */
                mv.setViewName("jsonView");
                mv.addObject("result", result);
            }
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminAcctService.ExAdminConfigAcctInfoInsert 호출 오류 발생", params);
            logger.error(e);
        }
        return mv;
    }

    /* 계정과목 삭제 */
    @RequestMapping("/ex/admin/ExAdminConfigAcctInfoDelete.do")
    public ModelAndView ExAdminConfigAcctInfoDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ResultVO result = new ResultVO();
            Map<String, Object> empInfo = new HashMap<String, Object>();
            String[] keys = {commonCode.EMPSEQ};
            /* 변수값 정의 */
            empInfo = CommonConvert.CommonGetEmpInfo();
            CommonConvert.CommonSetMapCopy(empInfo, params, keys);
            result.setParams(params);
            if (CommonConvert.CommonGetStr(empInfo.get(commonCode.USERSE)).equals(commonCode.ADMIN)) {
                /* 삭제 진행 */
            	try {
            		result = acctService.ExAdminConfigAcctInfoDelete(result);
            		/* 반환데이터 검증 */
            		if (result == null) {
            			result = new ResultVO();
            			result.setParams(params);
            		}
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/admin/ExAdminConfigAcctInfoDelete.do >> acctService.ExAdminConfigAcctInfoDelete(result)", result);
                    throw new Exception(e);
            	}
                /* 반환정보 가공 */
            	mv.setViewName("jsonView");
                mv.addObject("result", result);
            } else {
                /* 반환데이터 검증 */
                result.setResultCode(commonCode.FAIL);
                result.setResultName("관리자 권한이 없습니다.");
                /* 반환정보 가공 */
                mv.setViewName("jsonView");
                mv.addObject("result", result);
            }
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminAcctService.ExAdminConfigAcctInfoDelete 호출 오류 발생", params);
            logger.error(e);
        }
        return mv;
    }

    /* 항목 설정 목록 조회 */
    @RequestMapping("/ex/admin/ExAdminConfigItemListInfoSelect.do")
    public ModelAndView ExAdminConfigItemListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ResultVO result = new ResultVO();
            Map<String, Object> empInfo = new HashMap<String, Object>();
            String[] keys = {commonCode.EMPSEQ};
            /* 변수값 정의 */
            empInfo = CommonConvert.CommonGetEmpInfo();
            params.put("langCode", empInfo.get("langCode"));
            CommonConvert.CommonSetMapCopy(empInfo, params, keys);
            result.setParams(params);
            if (CommonConvert.CommonGetStr(empInfo.get(commonCode.USERSE)).equals(commonCode.ADMIN)) {
                /* 반환데이터 조회 */
            	try {
            		result = itemService.ExAdminConfigItemListInfoSelect(result);
            		/* 반환데이터 검증 */
            		if (result == null) {
            			result = new ResultVO();
            			result.setParams(params);
            		}
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/admin/ExAdminConfigItemListInfoSelect.do >> itemService.ExAdminConfigItemListInfoSelect(result)", result);
                    throw new Exception(e);
            	}
                /* 반환정보 가공 */
            	mv.setViewName("jsonView");
                mv.addObject("result", result);
            } else {
                /* 반환데이터 검증 */
                result.setResultCode(commonCode.FAIL);
                result.setResultName("관리자 권한이 없습니다.");
                /* 반환정보 가공 */
                mv.setViewName("jsonView");
                mv.addObject("result", result);
            }
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminItemService.ExAdminConfigItemListInfoSelect 호출 오류 발생", params);
            logger.error(e);
        }
        return mv;
    }

    /* 항목 설정 목록 저장 */
    @RequestMapping("/ex/admin/ExAdminConfigItemListInfoInsert.do")
    public ModelAndView ExAdminConfigItemListInfoInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ResultVO result = new ResultVO();
            Map<String, Object> empInfo = new HashMap<String, Object>();
            String[] keys = {commonCode.EMPSEQ};
            /* 변수값 정의 */
            empInfo = CommonConvert.CommonGetEmpInfo();
            CommonConvert.CommonSetMapCopy(empInfo, params, keys);
            result.setParams(params);
            if (CommonConvert.CommonGetStr(empInfo.get(commonCode.USERSE)).equals(commonCode.ADMIN)) {
                /* 수신데이터 저장 */
            	try {
            		result = itemService.ExAdminConfigItemListInfoInsert(result);
            		/* 반환데이터 검증 */
            		if (result == null) {
            			result = new ResultVO();
            			result.setParams(params);
            		}
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/admin/ExAdminConfigItemListInfoInsert.do >> itemService.ExAdminConfigItemListInfoInsert(result)", result);
                    throw new Exception(e);
            	}
                /* 반환정보 가공 */
                mv.setViewName("jsonView");
                mv.addObject("result", result);
            } else {
                /* 반환데이터 검증 */
                result.setResultCode(commonCode.FAIL);
                result.setResultName("관리자 권한이 없습니다.");
                /* 반환정보 가공 */
                mv.setViewName("jsonView");
                mv.addObject("result", result);
            }
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminItemService.ExAdminConfigItemListInfoInsert 호출 오류 발생", params);
            logger.error(e);
        }
        return mv;
    }

    /* Biz - 회계(관리자) */
    /* Biz - 회계(관리자) - 지출결의 관리 */
    /* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 */
    /* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 - 목록 조회 */
    @RequestMapping("/expend/ex/admin/ExAdminExpendCheckReportListInfoSelect.do")
    public ModelAndView ExAdminExpendManagerReportListInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /*
         * parameter : fromDate, toDate, reqDate, adocuNo, appUserName, docNo, docTitle
         */
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ResultVO resultVo = new ResultVO();
            /* 현재사용자의 고유값 넣기 */
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
            params.put(commonCode.DEPTSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
            /* 반환데이터 조회 */
            try {
            	resultVo = reportService.ExAdminExpendCheckReportListInfoSelect(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /expend/ex/admin/ExAdminExpendCheckReportListInfoSelect.do >> reportService.ExAdminExpendCheckReportListInfoSelect(params)", params);
                throw new Exception(e);
        	}
            /* 반환정보 가공 */
            mv.setViewName("jsonView");
            mv.addObject("result", resultVo);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminReportService.ExAdminExpendCheckReportListInfoSelect 호출 오류 발생", params);
            logger.error(e);
        }
        return mv;
    }

    /* Biz - 회계(관리자) */
    /* Biz - 회계(관리자) - 지출결의 관리 */
    /* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 */
    /* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 - 전송 */
    @RequestMapping("/expend/ex/admin/ExAdminExpendManagerReportSend.do")
    public ModelAndView ExAdminExpendManagerReportSend(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
        	result = reportService.ExReportExpendSendListInfoSend(param);
        	
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLogicException e) {
            ExpInfo.TipLog("잘못된 패턴 정의로 인한 문제가 발생되었습니다. FEx의 ERP 구분별 프로세스를 확인해주세요.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.GetTryConnType() + " 연동은 지원하지 않습니다.");
        } catch (NotFoundConnectionException e) {
            ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("사용자의 로그인정보를 확인할 수 없습니다. 정상적인 로그인 상태인지, 자동로그아웃된 상태인지 확인이 필요합니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (CheckExistsException e) {
        	ExpInfo.TipLog("중복전송 요청이 시도되었습니다.", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminReportService.ExReportExpendSendListInfoSend 호출 오류 발생", param);
        	logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* Biz - 회계(관리자) */
    /* Biz - 회계(관리자) - 지출결의 관리 */
    /* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 */
    /* Biz - 회계(관리자) - 지출결의 관리 - 지출결의 확인 - 전송 취소 */
    @RequestMapping("/expend/ex/admin/ExReportExpendSendListInfoSendCancel.do")
    public ModelAndView ExReportExpendSendListInfoSendCancel(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
        	try {
        		result = reportService.ExReportExpendSendListInfoReturn(param);
        	} catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /expend/ex/admin/ExReportExpendSendListInfoSendCancel.do >> reportService.ExReportExpendSendListInfoReturn(param)", param);
                throw new Exception(e);
        	}
        } catch (NotFoundLogicException e) {
        	ExpInfo.TipLog("잘못된 패턴 정의로 인한 문제가 발생되었습니다. FEx의 ERP 구분별 프로세스를 확인해주세요.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.GetTryConnType() + " 연동은 지원하지 않습니다.");
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("사용자의 로그인정보를 확인할 수 없습니다. 정상적인 로그인 상태인지, 자동로그아웃된 상태인지 확인이 필요합니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminReportService.ExReportExpendSendListInfoReturn 호출 오류 발생", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 카드 사용 현황 */
    /* Biz - 회계 ( 사용자 ) - 지출결의 관리 - 카드 사용 현황 - 목록 조회 */
    @RequestMapping("/ex/admin/card/cardReportList.do")
    public ModelAndView ExAdminCardReportListInfoSelect(@ModelAttribute ExReportCardVO reportCardVO, HttpServletRequest request) throws Exception {
        /* parameter : fromDate, toDate, reqDate, docNo, docTitle */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
        	reportCardVO.setLangCode(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE)));

            try {
            	result = reportService.ExAdminCardReportListInfoSelect(reportCardVO);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/admin/card/cardReportList.do >> reportService.ExAdminCardReportListInfoSelect(params)", reportCardVO);
                throw new Exception(e);
        	}
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", reportCardVO);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminReportService.ExAdminCardReportListInfoSelect 호출 오류 발생", reportCardVO);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 공통코드 - 카드정보 조회 */
    @RequestMapping("/ex/admin/config/CardInfoSelect.do")
    public ModelAndView CardInfoSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* 초기값 지정 */
            param.put("createSeq", loginVo.getUniqId());
            param.put("modifySeq", loginVo.getUniqId());
            param.put("compSeq", loginVo.getCompSeq());

            // 비영리 회계 - 영리 결재의 경우 정상동작 불가능.
            // 파라미터 컨텐츠에서 제작으로 변경
            // param.put("eaType", loginVo.getEaType());
            /* 등록 */
            try {
            	result = cardService.ExConfigCardInfoSelect(param);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/admin/config/CardInfoSelect.do >> cardService.ExConfigCardInfoSelect(param)", param);
                throw new Exception(e);
        	}
            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
            mv.addObject(commonCode.IFSYSTEM, param.get(commonCode.IFSYSTEM));
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminCardService.ExConfigCardInfoSelect 호출 오류 발생", param);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* 공통코드 - 카드정보 생성 */
    @RequestMapping("/ex/admin/config/CardInfoInsert.do")
    public ModelAndView CardInfoInsert(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* 초기값 지정 */
            param.put("createSeq", loginVo.getUniqId());
            param.put("modifySeq", loginVo.getUniqId());
            // setCommonParams( param );
            /* 등록 */
            try {
            	result = cardService.ExConfigCardInfoInsert(param);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/admin/config/CardInfoInsert.do >> cardService.ExConfigCardInfoInsert(param)", param);
                throw new Exception(e);
        	}
            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("aaData", result);
            mv.addObject(commonCode.IFSYSTEM, param.get(commonCode.IFSYSTEM));
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminCardService.ExConfigCardInfoInsert 호출 오류 발생", param);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* 공통코드 - 카드정보 수정 */
    @RequestMapping("/ex/admin/config/CardInfoUpdate.do")
    public ModelAndView CardInfoUpdate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* 초기값 지정 */
            param.put("createSeq", loginVo.getUniqId());
            param.put("modifySeq", loginVo.getUniqId());
            // setCommonParams( param );
            /* 등록 */
            try {
            	result = cardService.ExConfigCardInfoUpdate(param);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/admin/config/CardInfoUpdate.do >> cardService.ExConfigCardInfoUpdate(param)", param);
                throw new Exception(e);
        	}
            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("aaData", result);
            mv.addObject(commonCode.IFSYSTEM, param.get(commonCode.IFSYSTEM));
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminCardService.ExConfigCardInfoUpdate 호출 오류 발생", param);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* 공통코드 - 카드정보 삭제 */
    @RequestMapping("/ex/admin/config/CardInfoDelete.do")
    public ModelAndView CardInfoDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            /* 초기값 지정 */
            param.put("create_seq", loginVo.getUniqId());
            param.put("modify_seq", loginVo.getUniqId());
            // setCommonParams( param );
            /* 등록 */
            try {
            	result = cardService.ExConfigCardInfoDelete(param);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/admin/config/CardInfoDelete.do >> cardService.ExConfigCardInfoDelete(param)", param);
                throw new Exception(e);
        	}
            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("aaData", result);
            mv.addObject(commonCode.IFSYSTEM, param.get(commonCode.IFSYSTEM));
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminCardService.ExConfigCardInfoDelete 호출 오류 발생", param);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* 공통코드 - ERP에서 가져오기 */
    @RequestMapping("/ex/admin/config/CardInfoFromErpCopy.do")
    public ModelAndView ExCodeCardInfoFromErpCopy(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO resultVo = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();
            /* 초기값 지정 */
            param.put("createSeq", loginVo.getUniqId());
            param.put("modifySeq", loginVo.getUniqId());
            // setCommonParams( param );
            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}
            /* ERP 회사 코드 확인 */
            param.put("erpCompSeq", conVo.getErpCompSeq());
            // ERP 데이터 확인
            try {
            	resultVo = cardService.ExConfigCardInfoFromErpCopy(param, conVo);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/admin/config/CardInfoFromErpCopy.do >> cardService.ExConfigCardInfoFromErpCopy(param, conVo)", param);
                throw new Exception(e);
        	}
            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("aaData", resultVo);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminCardService.ExConfigCardInfoFromErpCopy 호출 오류 발생", param);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* 지출결의 - 지출결의 현황 관리자 목록 조회 */
    @RequestMapping("/ex/report/ExReportExpendAdmListInfoSelect.do")
    public ModelAndView ExReportExpendAdmListInfoSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();
            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/report/ExReportExpendAdmListInfoSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", param);
                throw new Exception(e);
        	}
            param.put(commonCode.ERPCOMPSEQ, erpCompSeq);
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());

            /* 지출결의 현황 관리자 목록 조회 */
            try {
            	result = reportService.ExAdminExpendManagerReportListInfoSelect(param);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/report/ExReportExpendAdmListInfoSelect.do >> reportService.ExAdminExpendManagerReportListInfoSelect(param)", param);
                throw new Exception(e);
        	}
            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("aaData", result.getAaData());
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminReportService.ExAdminExpendManagerReportListInfoSelect 호출 오류 발생", param);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* 지출결의 - 지출결의 상세현황 관리자 목록 조회 이준성 */
    @RequestMapping("/ex/report/ExSlipReportExpendAdmListInfoSelect.do")
    public ModelAndView ExSlipReportExpendAdmListInfoSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/report/ExSlipReportExpendAdmListInfoSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", param);
                throw new Exception(e);
        	}
            param.put(commonCode.ERPCOMPSEQ, erpCompSeq);
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());

            /* 지출결의 현황 관리자 목록 조회 */
            try {
            	result = reportService.ExSlipAdminExpendManagerReportListInfoSelect(param);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/report/ExSlipReportExpendAdmListInfoSelect.do >> reportService.ExSlipAdminExpendManagerReportListInfoSelect(param)", param);
                throw new Exception(e);
        	}
            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("aData", result.getaData());
            mv.addObject("result", result);
            mv.addObject(commonCode.IFSYSTEM, conVo.getErpTypeCode());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminReportService.ExSlipAdminExpendManagerReportListInfoSelect 호출 오류 발생", param);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황 ------------------------- */
    /* 부서 , 프로젝트 , 부문 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesilPopInfoSelect.do")
    public ModelAndView ExAdminYesilPopInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesilPopInfoSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비 현황 팝업(부서, 프로젝트, 부문) 목록 조회 */
            try {
            	result = yesilService.ExAdminYesilPop(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesilPopInfoSelect.do >> yesilService.ExAdminYesilPop(params)", params);
                throw new Exception(e);
        	}
            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesilPop 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황 ------------------------- */
    /* 예실대비현황 목록 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesilInfoSelect.do")
    public ModelAndView ExAdminYesilInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesilInfoSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비 현황 목록 조회 */
            try {
            	result = yesilService.ExAdminYesilInfoSelect(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesilInfoSelect.do >> yesilService.ExAdminYesilInfoSelect(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesilInfoSelect 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황 ------------------------- */
    /* 예실대비현황 지출결의현황 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesilDetailPopInfo.do")
    public ModelAndView ExAdminYesilDetailPopInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesilDetailPopInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비 현황 지출결의현황 조회 */
            try {
            	result = yesilService.ExAdminYesilDetailPopInfo(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesilDetailPopInfo.do >> yesilService.ExAdminYesilDetailPopInfo(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
            mv.addObject("eaType", loginVo.getEaType());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesilDetailPopInfo 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황 ------------------------- */
    /* 예실대비현황 상세 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesilDetailSelect.do")
    public ModelAndView ExAdminYesilDetailSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ResultVO subResult = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesilDetailSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비 현황 목록 조회 */
            try {
            	result = yesilService.ExAdminYesilDetailSelect(params);
            	subResult = yesilService.ExAdminYesilnoExpendSend(params);

            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesilDetailSelect.do >> yesilService.ExAdminYesilDetailSelect(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
            mv.addObject("subResult", subResult);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesilDetailSelect 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 결의부서 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesil2DeptInfo.do")
    public ModelAndView ExAdminYesil2DeptInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2DeptInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비2 현황 팝업 결의부서 목록 조회 */
            try {
            	result = yesilService.ExAdminYesil2DeptInfo(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2DeptInfo.do >> yesilService.ExAdminYesil2DeptInfo(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2DeptInfo 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예산단위그룹 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesil2BudgetGrInfo.do")
    public ModelAndView ExAdminYesil2BudgetGrInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2BudgetGrInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비2 현황 팝업 예산단위그룹 목록 조회 */
            try {
            	result = yesilService.ExAdminYesil2BudgetGrInfo(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2BudgetGrInfo.do >> yesilService.ExAdminYesil2BudgetGrInfo(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2BudgetGrInfo 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예산단위 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesil2BudgetDeptInfo.do")
    public ModelAndView ExAdminYesil2BudgetDeptInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2BudgetDeptInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비2 현황 팝업 예산단위 목록 조회 */
            try {
            	result = yesilService.ExAdminYesil2BudgetDeptInfo(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2BudgetDeptInfo.do >> yesilService.ExAdminYesil2BudgetDeptInfo(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2BudgetDeptInfo 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 사업계획 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesil2BizPlanInfo.do")
    public ModelAndView ExAdminYesil2BizPlanInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2BizPlanInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비2 현황 팝업 사업계획 목록 조회 */
            try {
            	result = yesilService.ExAdminYesil2BizPlanInfo(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2BizPlanInfo.do >> yesilService.ExAdminYesil2BizPlanInfo(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2BizPlanInfo 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예산계정 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesil2BudgetAcctInfo.do")
    public ModelAndView ExAdminYesil2BudgetAcctInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2BudgetAcctInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비2 현황 팝업 사업계획 목록 조회 */
            try {
            	result = yesilService.ExAdminYesil2BudgetAcctInfo(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2BudgetAcctInfo.do >> yesilService.ExAdminYesil2BudgetAcctInfo(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2BudgetAcctInfo 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황2 (PIVOT) ------------------------- */
    /* 예실대비2(PIVOT) 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesil2InfoSelect.do")
    public ModelAndView ExAdminYesil2InfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2InfoSelect.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비2 현황 팝업 사업계획 목록 조회 */
            try {
            	result = yesilService.ExAdminYesil2InfoSelect(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2InfoSelect.do >> yesilService.ExAdminYesil2InfoSelect(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2InfoSelect 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }

    /* ------------------------- 예실 대비 현황 ------------------------- */
    /* 예실대비현황 지출결의현황 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminYesil2DetailPopInfo.do")
    public ModelAndView ExAdminYesil2DetailPopInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            LoginVO loginVo = CommonConvert.CommonGetEmpVO();
            ResultVO result = new ResultVO();
            ConnectionVO conVo = new ConnectionVO();

            /* ERP 연결정보 조회 */
            try {
            	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
            } catch (Exception e) {
            	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
                throw new Exception(e);
        	}

            /* ERP 회사 코드 확인 */
            String erpCompSeq = "";
            try {
            	erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2DetailPopInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
                throw new Exception(e);
        	}
            params.put("erpCompSeq", erpCompSeq);
            params.put("compSeq", loginVo.getCompSeq());

            /* 예실대비 현황 지출결의현황 조회 */
            try {
            	result = yesilService.ExAdminYesil2DetailPopInfo(params);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2DetailPopInfo.do >> yesilService.ExAdminYesil2DetailPopInfo(params)", params);
                throw new Exception(e);
        	}

            /* 반환처리 */
            mv.setViewName("jsonView");
            mv.addObject("result", result);
            mv.addObject("eaType", loginVo.getEaType());
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2DetailPopInfo 호출 오류 발생", params);
            logger.error(e);
            throw e;
        }
        return mv;
    }
    /* 예실대비 현황 미전송 결의 팝업 창 */
    @RequestMapping("/ex/expend/admin/ExYesilExpendDetailInfo.do")
    public ModelAndView ExYesilExpendDatailReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception{
      ModelAndView mv = new ModelAndView();

      try {
        //VO 선언
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ResultVO result = new ResultVO();
        ConnectionVO conVo = new ConnectionVO();

        try {
            conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        } catch (Exception e) {
            ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
            throw new Exception(e);
        }

          String erpCompSeq = "";
          try {
              erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
          } catch (Exception e) {
              ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2DetailPopInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
              throw new Exception(e);
          }

          params.put("erpCompSeq", loginVo.getErpCoCd());
          params.put("compSeq", loginVo.getCompSeq());

          try {
            result = yesilService.ExAdminIuYesilExpendsend(params);
        } catch (Exception e) {
            ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2DetailPopInfo.do >> yesilService.ExAdminYesil2DetailPopInfo(params)", params);
            throw new Exception(e);
        }

        /* 반환처리 */
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        mv.addObject("eaType", loginVo.getEaType());


      } catch (Exception e) {
        ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2DetailPopInfo 호출 오류 발생", params);
        logger.error(e);
        throw e;

      }

      return mv;
    }

    /* 예실대비 현황 2.0 상단 리스트 조회 */
    @RequestMapping("/ex/expend/admin/ExYesilExpendTopInfo.do")
    public ModelAndView ExYesilExpendTopReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception{

      ModelAndView mv = new ModelAndView();

      try {
        LoginVO loginVo = new LoginVO();
        ResultVO result = new ResultVO();
        ConnectionVO conVo = new ConnectionVO();

        try {
          conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        } catch (Exception e) {
          ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
          throw new Exception(e);
        }

        String erpCompSeq = "";
        try {
          erpCompSeq = codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq());
        } catch (Exception e) {
          ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2DetailPopInfo.do >> codeService.getErpCompSeq(loginVo, conVo.getErpTypeCode(), loginVo.getCompSeq())", params);
          throw new Exception(e);
        }
        params.put("erpCompSeq", erpCompSeq);
        params.put("compSeq", loginVo.getCompSeq());

        try {
          result = yesilService.ExAdminIuYesilExpendTop(params);

        } catch (Exception e) {
          ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminYesil2DetailPopInfo.do >> yesilService.ExAdminYesil2DetailPopInfo(params)", params);
          throw new Exception(e);
        }


        mv.setViewName("jsonView");
        mv.addObject("result", result);
        mv.addObject("eaType", loginVo.getEaType());

      } catch (Exception e) {
        ExpInfo.TipLog("BExAdminYesilService.ExAdminYesil2DetailPopInfo 호출 오류 발생", params);
        logger.error(e);
        throw e;
      }


      return mv;
    }


    /* 관리자설정 / 명칭설정 데이터 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminGetLabelInfoList.do")
    public ModelAndView ExAdminGetLabelInfoList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("jsonView");
        try {
            mv.addObject("result", adminConfig.ExAdminLabelInfoListSelect(params));
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminGetLabelInfoList.do >> adminConfig.ExAdminLabelInfoListSelect(params)", params);
            logger.error(e);
            ResultVO result = new ResultVO();
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 관리자설정 / 명칭설정 데이터 업데이트 */
    @RequestMapping("/ex/expend/admin/ExAdminSetLabelInfoList.do")
    public ModelAndView ExAdminSetLabelInfoList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("jsonView");
        List<Map<String, Object>> params = CommonConvert.CommonGetJSONToListMap(param.get("param").toString());
        try {
            mv.addObject("result", adminConfig.ExAdminLabelInfoListUpdate(params));
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminSetLabelInfoList.do >> adminConfig.ExAdminLabelInfoListUpdate(params)", params);
            logger.error(e);
            ResultVO result = new ResultVO();
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 관리자설정 / 버튼설정 양식 정보 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminGetFormInfoList.do")
    public ModelAndView ExAdminGetFormInfoList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result.setaData(itemService.ExAdminItemConfigSendParam());
            result.setResultCode(commonCode.SUCCESS);
            result.setResultName("양식 리스트 조회 성공");
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminGetFormInfoList.do >> itemService.ExAdminItemConfigSendParam()", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 관리자설정 / 버튼설정 버튼 정보 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminGetButtonInfoList.do")
    public ModelAndView ExAdminGetButtonInfoList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        ResultVO formResult = new ResultVO();
        try {
        	try {
        		formResult.setaData(adminConfig.ExAdminGetFormInfoSelect(param).getaData());
        	} catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminGetButtonInfoList.do >> adminConfig.ExAdminGetFormInfoSelect(param)", param);
                throw new Exception(e);
        	}

        	try {
        		result = adminConfig.ExAdminGetButtonInfoList(param);
        	} catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminGetButtonInfoList.do >> adminConfig.ExAdminGetButtonInfoList(param)", param);
                throw new Exception(e);
        	}

            result.setResultCode(commonCode.SUCCESS);
            result.setResultName("버튼 리스트 조회 성공");
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminConfigService.ExAdminGetButtonInfoList 호출 오류 발생", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
            mv.addObject("formInfo", formResult);
        }
        return mv;
    }

    /* 관리자설정 / 버튼설정 버튼 전체 저장 */
    @RequestMapping("/ex/expend/admin/ExAdminSetButtonLocationUpdate.do")
    public ModelAndView ExAdminSetButtonLocationUpdate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = adminConfig.ExAdminSetButtonLocationUpdate(param);
            result.setResultCode(commonCode.SUCCESS);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminSetButtonLocationUpdate.do >> adminConfig.ExAdminSetButtonLocationUpdate(param)", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 관리자설정 / 버튼설정 버튼 세부 저장 */
    @RequestMapping("/ex/expend/admin/ExAdminSetButtonUpdate.do")
    public ModelAndView ExAdminSetButtonUpdate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = adminConfig.ExAdminSetButtonUpdate(param);
            result.setResultCode(commonCode.SUCCESS);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminSetButtonUpdate.do >> adminConfig.ExAdminSetButtonUpdate(param)", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 관리자설정 / 버튼설정 버튼 개발자 신규 생성 */
    @RequestMapping("/ex/expend/admin/ExAdminSetButtonCreate.do")
    public ModelAndView ExAdminSetButtonCreate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = adminConfig.ExAdminSetButtonCreate(param);
            result.setResultCode(commonCode.SUCCESS);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminSetButtonCreate.do >> adminConfig.ExAdminSetButtonCreate(param)", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 관리자설정 / 버튼설정 버튼 개발자 삭제 */
    @RequestMapping("/ex/expend/admin/ExAdminSetButtonDelete.do")
    public ModelAndView ExAdminSetButtonDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = adminConfig.ExAdminSetButtonDelete(param);
            result.setResultCode(commonCode.SUCCESS);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminSetButtonDelete.do >> adminConfig.ExAdminSetButtonDelete(param)", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 현황 - 지출결의 삭제 */
    @RequestMapping("/ex/expend/admin/ExExpendDelete.do")
    public ModelAndView ExAdminExpendDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = reportService.ExAdminExpendInfoDelete(param);
        } catch (NotFoundLogicException e) {
        	ExpInfo.TipLog("잘못된 패턴 정의로 인한 문제가 발생되었습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.GetTryConnType() + " 연동은 지원하지 않습니다.");
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundDataException e) {
        	ExpInfo.TipLog("데이터를 조회하지 못하였습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExExpendDelete.do >> reportService.ExAdminExpendInfoDelete(param)", param);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    @RequestMapping("/ex/admin/report/ExTaxReportList.do")
    public ModelAndView ExAdminEtaxReportiCUBEList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ConnectionVO conVo = new ConnectionVO();
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();

        /* ERP 연결정보 조회 */
        try {
        	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        } catch (Exception e) {
        	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
            throw new Exception(e);
    	}

        param.put("empSeq", "ADMIN");
        result.setParams(param);
        try {
            result = reportService.ExAdminEtaxReportList(result, conVo);
            result.setResultCode(commonCode.SUCCESS);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/report/ExTaxReportList.do >> reportService.ExAdminEtaxReportList(result, conVo)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    @RequestMapping("/ex/admin/report/ExiCUBEDocListSelect.do")
    public ModelAndView ExAdminiCUBEDocListReport(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ConnectionVO conVo = new ConnectionVO();
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();

        /* ERP 연결정보 조회 */
        try {
        	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        } catch (Exception e) {
        	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
            throw new Exception(e);
    	}

        param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
        result.setParams(param);
        try {
            result = reportService.ExAdminiCUBEDocList(result, conVo);
            result.setResultCode(commonCode.SUCCESS);
        } catch (NotFoundLoginSessionException e) {
            ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/report/ExiCUBEDocListSelect.do >> reportService.ExAdminiCUBEDocList(result, conVo)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 현황 - 지출결의 삭제 */
    @RequestMapping("/ex/expend/admin/ExiCUBEDocListDelete.do")
    public ModelAndView ExiCUBEDocListDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ConnectionVO conVo = new ConnectionVO();

        /* ERP 연결정보 조회 */
        try {
        	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        } catch (Exception e) {
        	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
            throw new Exception(e);
    	}

        param.put(commonCode.ERPCOMPSEQ, conVo.getErpCompSeq());
        try {
            result.setParams(param);
            result = reportService.ExAdminiCUBEDocListDelete(result, conVo);
        } catch (NotFoundLogicException e) {
        	ExpInfo.TipLog("잘못된 패턴 정의로 인한 문제가 발생되었습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.GetTryConnType() + " 연동은 지원하지 않습니다.");
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExiCUBEDocListDelete.do >> reportService.ExAdminiCUBEDocListDelete(result, conVo)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 설정 - 세금계산서 권한 설정 - 권한 추가 */
    @RequestMapping("/ex/admin/config/ExETaxAuthInsert.do")
    public ModelAndView ExETaxAuthInsert(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        try {
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            result.setParams(param);
            result = etaxService.ExAdminETaxAuthInsert(result);
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (CheckExistsException e) {
        	ExpInfo.TipLog("이미 등록된 정보가 있습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExETaxAuthInsert.do >> etaxService.ExAdminETaxAuthInsert(result)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 설정 - 세금계산서 권한 설정 - 권한 조회 */
    @RequestMapping("/ex/admin/config/ExETaxAuthAllSelect.do")
    public ModelAndView ExETaxAuthAllSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();

        try {
            param.put(commonCode.GROUPSEQ, loginVo.getGroupSeq());
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            result.setParams(param);
            result = etaxService.AdminETaxAuthAllListSelect(result);
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExETaxAuthAllSelect.do >> etaxService.AdminETaxAuthAllListSelect(result)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 설정 - 세금계산서 권한 설정 - 권한 조회 */
    @RequestMapping("/ex/admin/config/ExETaxAuthSelect.do")
    public ModelAndView ExETaxAuthSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        try {
            param.put(commonCode.GROUPSEQ, loginVo.getGroupSeq());
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            result.setParams(param);
            result = etaxService.ExAdminETaxAuthListSelect(result);
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExETaxAuthSelect.do >> etaxService.ExAdminETaxAuthListSelect(result)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 설정 - 세금계산서 권한 설정 - 권한 삭제 */
    @RequestMapping("/ex/admin/config/ExETaxAuthDelete.do")
    public ModelAndView ExETaxAuthDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        try {
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            result.setParams(param);
            result = etaxService.ExAdminETaxAuthDelete(result);
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExETaxAuthDelete.do >> etaxService.ExAdminETaxAuthDelete(result)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 설정 - 세금계산서 권한 설정 - 권한 수정 */
    @RequestMapping("/ex/admin/config/ExETaxAuthUpdate.do")
    public ModelAndView ExETaxAuthUpdate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        try {
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            result.setParams(param);
            result = etaxService.ExAdminETaxAuthUpdate(result);
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExETaxAuthUpdate.do >> etaxService.ExAdminETaxAuthUpdate(result)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 설정 - 세금계산서 권한 설정 - 공개범위 추가 */
    @RequestMapping("/ex/admin/config/ExETaxAuthPublicInsert.do")
    public ModelAndView ExETaxAuthPublicInsert(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        try {
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            result.setParams(param);
            result = etaxService.ExAdminETaxAuthPublicInsert(result);
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExETaxAuthPublicInsert.do >> etaxService.ExAdminETaxAuthPublicInsert(result)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 설정 - 세금계산서 권한 설정 - 공개범위 삭제 */
    @RequestMapping("/ex/admin/config/ExETaxAuthPublicDelete.do")
    public ModelAndView ExETaxAuthPublicDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        try {
            param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
            result.setParams(param);
            result = etaxService.ExAdminETaxAuthPublicDelete(result);
        } catch (NotFoundConnectionException e) {
        	ExpInfo.TipLog("ERP 연동 설정을 확인하세요. 지원되는 ERP는 iCUBE와 ERPiU입니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExETaxAuthPublicDelete.do >> etaxService.ExAdminETaxAuthPublicDelete(result)", result);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* 지출결의 설정 - 세금계산서 권한 설정 - 사업자등록번호/이메일 중복체크 */
    @RequestMapping("/ex/admin/config/ExETaxAuthCodeDuplicationCheck.do")
    public ModelAndView ExETaxAuthCodeDuplicationCheck(@ModelAttribute ExCodeETaxAuthVO eTaxAuthVO, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        /* 로그인정보 */
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        try {
            eTaxAuthVO.setCompSeq(loginVo.getCompSeq());

            result.setParams(CommonConvert.ConverObjectToMap(eTaxAuthVO));
            result = etaxService.ExETaxAuthCodeDuplicationCheck(eTaxAuthVO);
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", eTaxAuthVO);
            result.setResultCode(commonCode.FAIL);
            result.setResultName(e.getMessage());
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExETaxAuthSelect.do >> etaxService.ExETaxAuthCodeDuplicationCheck(eTaxAuthVO)", eTaxAuthVO);
            logger.error(e);
            result.setResultCode(commonCode.FAIL);
            result.setResultName("서버와 통신에 실패하였습니다.");
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        }
        return mv;
    }

    /* ## 양식별 표준적요 설정 ## */
    /* ## 양식별 표준적요 설정 ## - 표준적요 등록 */
    @RequestMapping("/ex/admin/config/ExAdminSetSummaryAuthCreate.do")
    public ModelAndView ExAdminSetSummaryAuthCreate(@RequestParam Map<String, Object> param) throws Exception {
        /* 변수정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = adminConfig.ExAdminSetSummaryAuthCreate(param);
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExAdminSetSummaryAuthCreate.do >> adminConfig.ExAdminSetSummaryAuthCreate(param)", param);
            // TODO: handle exception
            result.setFail(e.toString());
        }
        return mv;
    }

    /* ## 양식별 표준적요 설정 ## - 표쥰적요 삭제 */
    @RequestMapping("/ex/admin/config/ExAdminSetSummaryAuthDelete.do")
    public ModelAndView ExAdminSetSummaryAuthDelete(@RequestParam Map<String, Object> param) throws Exception {
        /* 변수정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = adminConfig.ExAdminSetSummaryAuthDelete(param);
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExAdminSetSummaryAuthDelete.do >> adminConfig.ExAdminSetSummaryAuthDelete(param)", param);
            // TODO: handle exception
            result.setFail(e.toString());
        }
        return mv;
    }

    /* ## 양식별 증빙유형 설정 ## */
    /* ## 양식별 증빙유형 설정 ## - 증빙유형 등록 */
    @RequestMapping("/ex/admin/config/ExAdminSetAuthTypeAuthCreate.do")
    public ModelAndView ExAdminSetAuthTypeAuthCreate(@RequestParam Map<String, Object> param) throws Exception {
        /* 변수정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = adminConfig.ExAdminSetAuthTypeAuthCreate(param);
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExAdminSetAuthTypeAuthCreate.do >> adminConfig.ExAdminSetAuthTypeAuthCreate(param)", param);
            // TODO: handle exception
            result.setFail(e.toString());
        }
        return mv;
    }

    /* ## 양식별 증빙유형 설정 ## - 증빙유형 삭제 */
    @RequestMapping("/ex/admin/config/ExAdminSetAuthTypeAuthDelete.do")
    public ModelAndView ExAdminSetAuthTypeAuthDelete(@RequestParam Map<String, Object> param) throws Exception {
        /* 변수정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            result = adminConfig.ExAdminSetAuthTypeAuthDelete(param);
            mv.setViewName("jsonView");
            mv.addObject("result", result);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/config/ExAdminSetAuthTypeAuthDelete.do >> adminConfig.ExAdminSetAuthTypeAuthDelete(param)", param);
            // TODO: handle exception
            result.setFail(e.toString());
        }
        return mv;
    }

    /* 지출결의 엑셀 다운로드 */
    /*
     * 필요파라미터 fileName : 파일명칭( 예 : 카드사용현황 ) listData : 엑셀 다운로드 할 데이터 excelHeader : 엑셀 헤더 ( Map으로 되어있음 )
     */
    @RequestMapping("/ex/admin/CommonExcelDown.do")
    public void ExAdminCardReportListExcelDown(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ConnectionVO conVo = new ConnectionVO();

        try {
        	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        } catch (Exception e) {
        	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
            throw new Exception(e);
    	}

        /* parameter : fromDate, toDate, reqDate, docNo, docTitle */
        FileInputStream fis = null;
        BufferedInputStream in = null;
        ByteArrayOutputStream bStream = null;
        params.put("langCode", CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
        try {
            /* 데이터 조회 */
            ResultVO result = new ResultVO();
            params.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.ERPCOMPSEQ));
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
            params.put(commonCode.DEPTSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
            switch (params.get("fileName").toString()) {
                case "지출결의확인":

                    // A : 기본정보 , B : 상세정보
                    if ("B".equals(params.get("excelType"))) {
                    	try {
                    		result = reportService.ExAdminExpendCheckReportListInfoSelect2(params);
                    	} catch (Exception e) {
                    		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> reportService.ExAdminExpendCheckReportListInfoSelect2(params)", params);
                            throw new Exception(e);
                    	}
                    } else {
                    	try {
                    		result = reportService.ExAdminExpendCheckReportListInfoSelect(params);
                    	} catch (Exception e) {
                    		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> reportService.ExAdminExpendCheckReportListInfoSelect(params)", params);
                            throw new Exception(e);
                    	}
                    }

                    break;
                case "지출결의현황":
                	try {
                		result = reportService.ExAdminExpendManagerReportListInfoSelect(params);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> reportService.ExAdminExpendManagerReportListInfoSelect(params)", params);
                        throw new Exception(e);
                	}
                    break;
                case "지출결의상세현황":
                  try {
                    //이준성
                      result = reportService.ExSlipAdminExpendManagerReportListInfoSelectExceDown(params);
                  } catch (Exception e) {
                      ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> reportService.ExSlipAdminExpendManagerReportListInfoSelectExceDown(params)", params);
                      throw new Exception(e);
                  }
                  break;
                case "카드사용현황":
                	try {
                		result = reportService.ExAdminCardReportListInfoSelectForExcel(params);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> reportService.ExAdminCardReportListInfoSelectForExcel(params)", params);
                        throw new Exception(e);
                	}
                    break;
                case "세금계산서현황":
                    result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;
                case "비영리 카드사용현황":
                    result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;
                case "지출결의전송":
                	try {
                		result = npReportService.selectSendList(params);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> npReportService.selectSendList(params)", params);
                        throw new Exception(e);
                	}
                    break;
                case "품의서반환":
                	try {
                		result = npReportService.selectConsReport(params);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> npReportService.selectConsReport(params)", params);
                        throw new Exception(e);
                	}
                    break;
                case "품의서상세현황":
                	try {
                		result = npReportService.selectConsBudgetList(params);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> npReportService.selectConsReport(params)", params);
                        throw new Exception(e);
                	}
                    break;
                case "예실대비현황":
                	try {
                		result = npReportService.NPAdminYesilListExcel(params, conVo);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> npReportService.NPAdminYesilListExcel(params, conVo)", params);
                        throw new Exception(e);
                	}
                    break;
                case "예실대비현황 품의집행실적":
                	try {
                		result = npReportService.NPAdminConsAmtList(params, conVo);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> npReportService.NPAdminConsAmtList(params, conVo)", params);
                        throw new Exception(e);
                	}
                    break;
                case "예실대비현황 결집행실적":
                	try {
                		result = npReportService.NPAdminResAmtList(params, conVo);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> npReportService.NPAdminResAmtList(params, conVo)", params);
                        throw new Exception(e);
                	}
                    break;
                case "예실대비현황 ERP결의행실적":
                	try {
                		result = npReportService.NPAdminERPResAmtList(params, conVo);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> npReportService.NPAdminERPResAmtList(params, conVo)", params);
                        throw new Exception(e);
                	}
                    break;
                case "예실대비 현황(ERPiU)":
                	try {
                		result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> 예실대비현황  ERPiU", params);
                        throw new Exception(e);
                	}
                    break;
                case "결의서현황":
                	result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;
                case "품의서현황":
                	result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;
                case "표준적요":
                  try {
                      result = codeService.ExCommonCodeInfoSelect(params);
                  } catch (Exception e) {
                      ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> codeService.ExCommonCodeInfoSelect(params)-표준적요 엑셀 다운로드", params);
                      throw new Exception(e);
                  }
                  break;
                case "증빙유형":
                  try {

                    result = codeService.ExCommonCodeInfoSelect(params);
                  } catch (Exception e) {
                      ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> codeService.ExCommonCodeInfoSelect(params)-증빙유형 엑셀 다운로드", params);
                      throw new Exception(e);
                  }
                  break;
                default:
                    break;
            }
            if (result == null) {
                result = new ResultVO();
            }
            /* 파일 명칭(카드사용현황20170925_사용지시퀀스.xlsx) */
            String fileName = commonCode.EMPTYSTR;
            fileName = params.get("fileName").toString();
            Calendar day = Calendar.getInstance();
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
            fileName = fileName + df.format(day.getTime()) + "_" + CommonConvert.CommonGetEmpInfo().get(commonCode.EMPSEQ).toString() + ".xlsx";
            /* 파일 경로(d:/upload/expend/temp/excel/ */
            String filePath = commonCode.EMPTYSTR;
            /* 회계모듈 기본 경로 확인 */
            Map<String, Object> tData = new HashMap<String, Object>();
            tData.put("osType", CommonUtil.osType());
            tData.put("pathSeq", commonCode.EXPPATHSEQ);
            tData.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.GROUPSEQ).toString());

            // 기본 경로 조회
            try {
            	tData = codeService.ExCommonExpGroupPathSelect(tData);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> codeService.ExCommonExpGroupPathSelect(tData)", tData);
                throw new Exception(e);
        	}

            if (tData == null || tData.get("absolPath") == null || CommonConvert.CommonGetStr(tData.get("absolPath")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("그룹 패스를 확인하여 주시길 바랍니다.");
            }
            filePath = tData.get("absolPath").toString() + File.separator + commonCode.EXCELPATH + File.separator;
            /* 파일 구분자 변경 */
            // fileName = fileName.replaceAll( "/", File.separator );
            // filePath = filePath.replaceAll( "/", File.separator ) +
            // File.separator;
            if (CommonExcel.CreateExcelFile(result.getAaData(), params, filePath, fileName)) {
                /* 파일 리턴 */
        		CommonExcel.ExcelDownload(fis, in, bStream, (filePath + fileName), fileName, request, response);
            }
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("CommonExcel.ExcelDownload 호출 오류 발생", params);
        	logger.error(e);
        } finally {
            if (bStream != null) {
                try {
                    bStream.close();
                } catch (Exception ignore) {
                    // LOGGER.debug("IGNORE: {}", ignore.getMessage());
                }
            }
            if (in != null) {
                try {
                    in.close();
                } catch (Exception ignore) {
                    // LOGGER.debug("IGNORE: {}", ignore.getMessage());
                }
            }
            if (fis != null) {
                try {
                    fis.close();
                } catch (Exception ignore) {
                    // LOGGER.debug("IGNORE: {}", ignore.getMessage());
                }
            }
        }
    }

    @RequestMapping("/ex/admin/YesilExcelDown.do")
    public void ExAdminYesilExcelDown(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ConnectionVO conVo = new ConnectionVO();

        try {
        	conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        } catch (Exception e) {
        	ExpInfo.TipLog("[설정알림] ERP 연동 설정 정보를 확인할 수 없습니다. ERP 연동 설정 정보를 확인해주세요.");
            throw new Exception(e);
    	}

        /* parameter : fromDate, toDate, reqDate, docNo, docTitle */
        FileInputStream fis = null;
        BufferedInputStream in = null;
        ByteArrayOutputStream bStream = null;
        params.put("langCode", CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
        try {
            /* 데이터 조회 */
            ResultVO result = new ResultVO();
            params.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.ERPCOMPSEQ));
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
            params.put(commonCode.DEPTSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
            switch (params.get("fileName").toString()) {
                case "예실대비현황(iCUBE)":
                	result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;

                default:
                    break;
            }
            if (result == null) {
                result = new ResultVO();
            }
            String fileName = commonCode.EMPTYSTR;
            fileName = params.get("fileName").toString();
            Calendar day = Calendar.getInstance();
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
            fileName = fileName + df.format(day.getTime()) + "_" + CommonConvert.CommonGetEmpInfo().get(commonCode.EMPSEQ).toString() + ".xlsx";
            /* 파일 경로(d:/upload/expend/temp/excel/ */
            String filePath = commonCode.EMPTYSTR;
            /* 회계모듈 기본 경로 확인 */
            Map<String, Object> tData = new HashMap<String, Object>();
            tData.put("osType", CommonUtil.osType());
            tData.put("pathSeq", commonCode.EXPPATHSEQ);
            tData.put(commonCode.GROUPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.GROUPSEQ).toString());

            // 기본 경로 조회
            try {
            	tData = codeService.ExCommonExpGroupPathSelect(tData);
            } catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/admin/CommonExcelDown.do >> codeService.ExCommonExpGroupPathSelect(tData)", tData);
                throw new Exception(e);
        	}

            if (tData == null || tData.get("absolPath") == null || CommonConvert.CommonGetStr(tData.get("absolPath")).equals(commonCode.EMPTYSTR)) {
                throw new Exception("그룹 패스를 확인하여 주시길 바랍니다.");
            }
            filePath = tData.get("absolPath").toString() + File.separator + commonCode.EXCELPATH + File.separator;
            /* 파일 구분자 변경 */
            // fileName = fileName.replaceAll( "/", File.separator );
            // filePath = filePath.replaceAll( "/", File.separator ) +
            // File.separator;

            if(params.get("fileName").toString().equals("예실대비현황(iCUBE)")) {
            	/* 예실대비 현황 엑셀 다운시 표기해야할 테이블이 2개이기에 별도로 구현 */
            	if(CommonExcel.CreateExcelFile_plusSubTable(result.getAaData(), params, filePath, fileName)) {
            		CommonExcel.ExcelDownload(fis, in, bStream, (filePath + fileName), fileName, request, response);
            	}
            }
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("YesilExcelDownload 호출 오류 발생", params);
        	logger.error(e);
        } finally {
            if (bStream != null) {
                try {
                    bStream.close();
                } catch (Exception ignore) {
                    // LOGGER.debug("IGNORE: {}", ignore.getMessage());
                }
            }
            if (in != null) {
                try {
                    in.close();
                } catch (Exception ignore) {
                    // LOGGER.debug("IGNORE: {}", ignore.getMessage());
                }
            }
            if (fis != null) {
                try {
                    fis.close();
                } catch (Exception ignore) {
                    // LOGGER.debug("IGNORE: {}", ignore.getMessage());
                }
            }
        }
    }

    @RequestMapping(value = "/ex/admin/CommonNewExcelDown.do", method = RequestMethod.POST)
    @ResponseBody
    public Object ExAdminCardReportListNewExcelDown(@RequestBody Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {

        /* parameter : fromDate, toDate, reqDate, docNo, docTitle */
        params.put("langCode", CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
        LoginVO loginVo = CommonConvert.CommonGetEmpVO();
        ConnectionVO conVo = new ConnectionVO();
        conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
        JSONObject excelListJson = new JSONObject();
        try {
            /* 데이터 조회 */
            ResultVO result = new ResultVO();
            params.put(commonCode.ERPCOMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.ERPCOMPSEQ));
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ));
            params.put(commonCode.DEPTSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.LANGCODE));
            switch (params.get("fileName").toString()) {
                case "지출결의확인":
                    // A : 기본정보 , B : 상세정보
                    if ("B".equals(params.get("excelType"))) {
                    	try {
                    		result = reportService.ExAdminExpendCheckReportListInfoSelect2(params);
                    	} catch (Exception e) {
                    		ExpInfo.CLog("[에러발생] /ex/admin/CommonNewExcelDown.do >> reportService.ExAdminExpendCheckReportListInfoSelect2(params)", params);
                            throw new Exception(e);
                    	}
                    } else {
                    	try {
                    		result = reportService.ExAdminExpendCheckReportListInfoSelect(params);
                    	} catch (Exception e) {
                    		ExpInfo.CLog("[에러발생] /ex/admin/CommonNewExcelDown.do >> reportService.ExAdminExpendCheckReportListInfoSelect(params)", params);
                            throw new Exception(e);
                    	}
                    }
                    break;
                case "지출결의현황":
                	try {
                		result = reportService.ExAdminExpendManagerReportListInfoSelect(params);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonNewExcelDown.do >> reportService.ExAdminExpendManagerReportListInfoSelect(params)", params);
                        throw new Exception(e);
                	}
                    break;
                case "카드사용현황":
                	try {
                		result = reportService.ExAdminCardReportListInfoSelectForExcel(params);
                	} catch (Exception e) {
                		ExpInfo.CLog("[에러발생] /ex/admin/CommonNewExcelDown.do >> reportService.ExAdminCardReportListInfoSelectForExcel(params)", params);
                        throw new Exception(e);
                	}
                    break;
                case "세금계산서현황":
                    result = null; // result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;
                case "비영리 카드사용현황":
                    result = null; // result.setAaData(CommonConvert.CommonGetJSONToListMap(params.get("tableData").toString()));
                    break;
                case "지출결의전송":
                    result = null; // result = npReportService.selectSendList(params);
                    break;
                case "품의서반환":
                    result = null; // result = npReportService.selectConsReport(params);
                    break;
                case "예실대비현황 지출결의서":
                  try {
                     result = yesilService.ExAdminIuYesilExpendsend(params);
                     result.setAaData((List<Map<String, Object>>)result.getParams().get("resultData"));
                 } catch (Exception e) {
                   ExpInfo.CLog("[에러발생] /ex/admin/CommonNewExcelDown.do >> 예실대비현황  ERPiU", params);
                   throw new Exception(e);
                 }
                  break;
                case "예실대비현황2.0":
                  try {
                    result = yesil2ServiceU.ExAdminYesilList(params,conVo);
                  } catch (Exception e) {
                    ExpInfo.CLog("[에러발생] /ex/admin/CommonNewExcelDown.do >> 예실대비현황  ERPiU", params);
                    throw new Exception(e);
                  }
                  break;

                default:
                    break;
            }
            if (result == null) {
                result = new ResultVO();
            }

            // js excel 에서 사용 할 형태로 변환
            Map<String, Object> resultMap = new HashMap<String, Object>();
            int resultCnt = 0;
            resultCnt = result.getAaData().size();

            resultMap.put("list", result.getAaData());
            resultMap.put("totalCount", resultCnt);

            excelListJson = JSONObject.fromObject(resultMap);

        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.TipLog("ExAdminCardReportListNewExcelDown 호출 오류 발생", params);
        	logger.error(e);
        }

        return excelListJson;
    }

    /* 양식 별 표준적요 & 증빙유형 설정 - 표준적요 선택 팝업 */
    @RequestMapping("/ex/expend/admin/ExFormLinkSummaryListSelect.do")
    public ModelAndView ExFormLinSummaryPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* compSeq 정의 */
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            if (params.get(commonCode.FORMSEQ) == null || CommonConvert.CommonGetStr(params.get(commonCode.FORMSEQ)).equals(commonCode.EMPTYSTR)) {
                result.setFail("필수파라미터 " + commonCode.FORMSEQ + "누락");
            }

            result = adminConfig.ExFormLinkSummaryListSelect(params);
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExFormLinkSummaryListSelect.do >> adminConfig.ExFormLinkSummaryListSelect(params)", params);
            result.setFail(e.getMessage());
            logger.error(e);
            throw e;
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 양식 별 표준적요 & 증빙유형 설정 - 증빙유형 선택 팝업 */
    @RequestMapping("/ex/expend/admin/ExFormLinkAuthListSelect.do")
    public ModelAndView ExFormLinkAuthPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* compSeq 정의 */
            params.put(commonCode.COMPSEQ, CommonConvert.CommonGetEmpInfo().get(commonCode.COMPSEQ).toString());
            if (params.get(commonCode.FORMSEQ) == null || CommonConvert.CommonGetStr(params.get(commonCode.FORMSEQ)).equals(commonCode.EMPTYSTR)) {
                result.setFail("필수파라미터 " + commonCode.FORMSEQ + "누락");
            }

        	result = adminConfig.ExFormLinkAuthListSelect(params);
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", params);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExFormLinkAuthListSelect.do >> adminConfig.ExFormLinkAuthListSelect(params)", params);
            result.setFail(e.getMessage());
            logger.error(e);
            throw e;
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 양식 별 표준적요 & 증빙유형 설정 -설정된 표준적요 조회 */
    @RequestMapping("/ex/expend/admin/ExFormLinkSettingSummaryListSelect.do")
    public ModelAndView ExFormLinkSettingSummaryListSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* formSeq */
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            result.setParams(param);
            /* 정보 조회 */
        	result = adminConfig.ExFormLinkSettingSummaryListSelect(result);
        	result.setSuccess();
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExFormLinkSettingSummaryListSelect.do >> adminConfig.ExFormLinkSettingSummaryListSelect(result)", result);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 양식 별 표준적요 & 증빙유형 설정 -설정된 증빙유형 조회 */
    @RequestMapping("/ex/expend/admin/ExFormLinkSettingAuthListSelect.do")
    public ModelAndView ExFormLinkSettingAuthListSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* formSeq */
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            result.setParams(param);
            /* 정보 조회 */
        	result = adminConfig.ExFormLinkSettingAuthListSelect(result);
        	result.setSuccess();
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExFormLinkSettingAuthListSelect.do >> adminConfig.ExFormLinkSettingAuthListSelect(result)", result);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 지출결의 마감설정 조회 */
    @RequestMapping("/ex/expend/admin/ExAdminExpendCloseDateSelect.do")
    public ModelAndView ExAdminExpendCloseDateSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* formSeq */
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            result.setParams(param);
            /* 정보 조회 */
        	result = adminConfig.ExAdminExpendCloseDateSelect(result);
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminExpendCloseDateSelect.do >> adminConfig.ExAdminExpendCloseDateSelect(result)", result);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 지출결의 마감설정 등록 - 모든양식적용 시 마감기간 중 등록된 내역 있는지 확인 */
    @RequestMapping("/ex/expend/admin/ExAdminExpendCloseFormInsertChkValidate.do")
    public ModelAndView ExAdminExpendCloseFormInsertChkValidate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* formSeq */
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            result.setParams(param);
            /* 정보 조회 */
        	try {
        		result = adminConfig.ExAdminExpendCloseFormInsertChkValidate(result);
        	} catch (Exception e) {
        		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminExpendCloseFormInsertChkValidate.do >> adminConfig.ExAdminExpendCloseFormInsertChkValidate(result)", result);
                throw new Exception(e);
        	}
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminConfigService.ExAdminExpendCloseFormInsertChkValidate(result) 호출 오류 발생", param);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 지출결의 마감설정 등록 */
    @RequestMapping("/ex/expend/admin/ExAdminExpendCloseDateInsert.do")
    public ModelAndView ExAdminExpendCloseDateInsert(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* formSeq */
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            param.put("modifySeq", param.get(commonCode.EMPSEQ).toString());
            param.put("createSeq", param.get(commonCode.EMPSEQ).toString());
            param.put("modifyName", param.get(commonCode.EMPNAME).toString());
            result.setParams(param);
            /* 정보 조회 */
            if (CommonConvert.CommonGetStr(param.get("isTotalInsert")).equals(commonCode.EMPTYYES)) {
            	try {
            		result = adminConfig.ExAdminExpendCloseInsertAllForm(result);
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminExpendCloseDateInsert.do >> adminConfig.ExAdminExpendCloseInsertAllForm(result)", result);
                    throw new Exception(e);
            	}
            } else {
            	try {
            		result = adminConfig.ExAdminExpendCloseDateInsert(result);
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminExpendCloseDateInsert.do >> adminConfig.ExAdminExpendCloseDateInsert(result)", result);
                    throw new Exception(e);
            	}
            }
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminConfigService.ExAdminExpendCloseDateInsert(result) 호출 오류 발생", param);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 지출결의 마감설정 수정 */
    @RequestMapping("/ex/expend/admin/ExAdminExpendCloseDateUpdate.do")
    public ModelAndView ExAdminExpendCloseDateUpdate(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* formSeq */
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            param.put("modifySeq", param.get(commonCode.EMPSEQ).toString());
            param.put("createSeq", param.get(commonCode.EMPSEQ).toString());
            param.put("modifyName", param.get(commonCode.EMPNAME).toString());
            result.setParams(param);
            /* 정보 조회 */
        	result = adminConfig.ExAdminExpendCloseDateUpdate(result);
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminExpendCloseDateUpdate.do >> adminConfig.ExAdminExpendCloseDateUpdate(result)", result);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 지출결의 마감설정 삭제 */
    @RequestMapping("/ex/expend/admin/ExAdminExpendCloseDateDelete.do")
    public ModelAndView ExAdminExpendCloseDateDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* formSeq */
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            param.put("modifySeq", param.get(commonCode.EMPSEQ).toString());
            param.put("createSeq", param.get(commonCode.EMPSEQ).toString());
            param.put("modifyName", param.get(commonCode.EMPNAME).toString());
            result.setParams(param);
            /* 정보 조회 */
            if (!CommonConvert.CommonGetStr(param.get("isAllDelete")).equals("Y")) {
            	try {
            		result = adminConfig.ExAdminExpendCloseDateDelete(result);
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminExpendCloseDateDelete.do >> adminConfig.ExAdminExpendCloseDateDelete(result)", result);
                    throw new Exception(e);
            	}
            } else {
            	try {
            		result = adminConfig.ExAdminExpendSelectedCloseDateDelete(result);
            	} catch (Exception e) {
            		ExpInfo.CLog("[에러발생] /ex/expend/admin/ExAdminExpendCloseDateDelete.do >> adminConfig.ExAdminExpendSelectedCloseDateDelete(result)", result);
                    throw new Exception(e);
            	}
            }
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.TipLog("BExAdminConfigService.ExAdminExpendCloseDateDelete(result) 호출 오류 발생", param);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 세금계산서현황 사용/미사용 처리 */
    @RequestMapping("/ex/admin/report/ExAdminETaxSetUseYN.do")
    public ModelAndView ExAdminETaxSetUseYN(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            param.put("modifySeq", param.get(commonCode.EMPSEQ).toString());
            param.put("createSeq", param.get(commonCode.EMPSEQ).toString());
            param.put("modifyName", param.get(commonCode.EMPNAME).toString());
            result.setParams(param);
        	reportService.ExAdminETaxSetUseYN(result);
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/report/ExAdminETaxSetUseYN.do >> reportService.ExAdminETaxSetUseYN(result)", result);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }

    /* 카드사용현황 사용/미사용 처리 */
    @RequestMapping("/ex/admin/report/ExAdminCardSetUseYN.do")
    public ModelAndView ExAdminCardSetUseYN(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        /* 변수 정의 */
        ModelAndView mv = new ModelAndView();
        ResultVO result = new ResultVO();
        try {
            /* 기본값 정의 */
            param = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), param);
            param.put("modifySeq", param.get(commonCode.EMPSEQ).toString());
            param.put("createSeq", param.get(commonCode.EMPSEQ).toString());
            param.put("modifyName", param.get(commonCode.EMPNAME).toString());
            result.setParams(param);
        	reportService.ExAdminCardSetUseYN(result);
        	result.setSuccess();
        } catch (NotFoundLoginSessionException e) {
        	ExpInfo.TipLog("Login 정보를 확인할 수 없습니다.", param);
        } catch (Exception e) {
        	ExpInfo.CLog("[에러발생] /ex/admin/report/ExAdminCardSetUseYN.do >> reportService.ExAdminCardSetUseYN(result)", result);
        	logger.error(e);
            // TODO: handle exception
            result.setFail("");
        }
        mv.setViewName("jsonView");
        mv.addObject("result", result);
        return mv;
    }
}
