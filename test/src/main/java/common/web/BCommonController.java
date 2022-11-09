/**
 *   * @FileName : BCommonController.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
package common.web;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.logging.log4j.LogManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import common.form.BCommonFormService;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.helper.logger.ExpInfo;
import common.mgr.BCommonMgrService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.ex.user.code.BExUserCodeService;
import expend.ex.user.report.BExUserReportService;

/**
 *   * @FileName : BCommonController.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
@Controller
public class BCommonController {

    //protected org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());
	protected final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    /* ################################################## */
    /* 변수정의 */
    /* ################################################## */
    /* 변수정의 - Service */
    /* 변수정의 - Service */
    @Resource(name = "BCommonFormService")
    private BCommonFormService formService;
    @Resource(name = "BCommonMgrService")
    private BCommonMgrService mgrService;
    @Resource(name = "BExUserReportService")
    private BExUserReportService userReportService;
    @Resource(name = "BExUserCodeService")
    private BExUserCodeService codeService;
    /* 변수정의 - Class */
    @Resource(name = "CommonInfo")
    private CommonInfo cmInfo;
    @Resource(name = "CommonLogger")
    private final CommonLogger cmLog = new CommonLogger();

    /* ################################################## */
    /* 코드조회 */
    /* ################################################## */
    /* 공통코드 조회 - Bizbox Alpha */
    @RequestMapping("/common/helper/CommonCode.do")
    public ModelAndView CommonCode(@RequestParam HashMap<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            /* 변수정의 */
            ResultVO result = new ResultVO();
            /* 로그인 사용자 정보 조회 */
            result = (ResultVO) CommonConvert.CommonGetMapToObject(CommonConvert.CommonGetEmpInfo(), result);
            /* 공통코드 목록 조회 */
            result.setAaData(cmInfo.CommonGetCodeA(result.getGroupSeq(), result.getCompSeq(), result.getLangCode(), CommonConvert.CommonGetStr(params.get("commonCode"))));
            /* 반환값 정의 */
            mv.addObject("result", result);
            mv.setViewName("jsonView");
        } catch (Exception e) {
            // TODO: handle exception
        }
        /* 반환 */
        return mv;
    }
    /* 공통코드 조회 - iCUBE */
    /* 미구현 */
    /* 공통코드 조회 - ERPiU */
    /* 미구현 */

    /**
     * 회계 관리자 - 양식설정 - 양식별 정보 조회
     */
    @RequestMapping("/common/form/CommonFormDataInfo.do")
    public ModelAndView CommonFormDataInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* 변수정의 */
        ModelAndView mv = new ModelAndView();

        ResultVO result = new ResultVO();

        /* 영리 양식정보 호출 - ex */
        if (params.get("isNp") == null) {
            /* 영리 용 */
            result = formService.CommonFormDataInfo(params);
        } else if (CommonConvert.CommonGetStr(params.get("isNp")).toUpperCase().equals("Y".toUpperCase())) {
            /* 비영리 용 */
            result = formService.CommonNPFormDataInfo(params);
        }

        mv.addObject("result", result);
        mv.setViewName("jsonView");
        return mv;
    }

    /**
     * 회계 관리자 - 양식설정 - 설정된 양식 저장
     */
    @RequestMapping("/common/form/CommonFormSave.do")
    public ModelAndView CommonFormSave(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        /* 변수정의 */
        ModelAndView mv = new ModelAndView();
        try {
            int result = -1;
            if (params.get("isNp") == null) {
                /* 영리 용 */
                result = formService.CommonFormSave(params);
            } else if (CommonConvert.CommonGetStr(params.get("isNp")).toUpperCase().equals("Y".toUpperCase())) {
                /* 비영리 용 */
                result = formService.CommonNpFormSave(params);
            }
            mv.addObject("result", result);
            mv.setViewName("jsonView");
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return mv;
    }

    /**
     * 회계 관리자 - 양식설정 - 전자결재 생성 테스트 HTML 구성
     */
    @RequestMapping("/form/interlock/ExDocMakeTest.do")
    public ModelAndView ExDocMakeTest(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO resultVo = new ResultVO();
        try {
            params.put(commonCode.EXPENDSEQ, "0");
            params.put(commonCode.FORMSEQ, "0");
            /* 인터락 정보 조회 */
            resultVo = formService.DocMaker(params);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", resultVo);
        }
        return mv;
    }

    /**
     * 회계 관리자 - [비영리]양식설정 - 전자결재 생성 테스트 HTML 구성
     */
    @RequestMapping("/form/interlock/ExNPDocMakeTest.do")
    public ModelAndView ExNPDocMakeTest(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO resultVo = new ResultVO();
        try {
            // params.put( commonCode.exDocSeq, "0" );
            params.put(commonCode.FORMSEQ, "0");
            /* 인터락 정보 조회 */
            resultVo = formService.NPDocMaker(params);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName(e.getMessage());
        } finally {
            mv.setViewName("jsonView");
            mv.addObject("result", resultVo);
        }
        return mv;
    }

    /**
     * AES256 암호화 테스트
     */
    // @RequestMapping ( "/encode/aes256cipher.do" )
    // public ModelAndView aes256cipher ( @RequestParam Map<String, Object>
    // params, HttpServletRequest request ) throws Exception {
    // ModelAndView mv = new ModelAndView( );
    // ResultVO resultVo = new ResultVO( );
    // try {
    // // local_policy.jar, US_export_policy.jar
    // java.security.InvalidKeyException: Illegal key size or default
    // parameters, java, tomcat
    // // String 값을 암호화 하는데 아래처럼 에러가 났다.
    // // java.security.InvalidKeyException: Illegal key size or default
    // parameters
    // // 원인
    // // 확인해보니 기본적으로는 128Bit로 암호화를 하는데 그이상(256Bit)으로 암호화를 해야 하는 경우에는
    // local_policy.jar, US_export_policy.jar 이렇게 두개를 패치해줘야 한다.
    // // 이걸 패치하면 제한이 걸려있는 암호화 길이를 무시하게 된다.
    // // 해결
    // // 1. 아래 URL 경로나 첨부파일에서 버전에 맞게 파일을 다운받는다
    // // 2. JDK설치경로\jre\lib\security 와 JRE설치경로\lib\security 에 두파일을 모두 덮어쓴다.
    // // (Linux 계열에는 JDK설치경로에만 넣어주면 해결됨)
    // // (JDK 설치 경로를 모르면 내컴퓨터 우클릭 > 속성 > 고급 시스템 설정 > 환경변수 > JAVA_HOME을 찾는다)
    // // 3. WAS 재기동
    // // 다운로드 경로
    // // jdk8 (Java Cryptography Extension (JCE) Unlimited Strength
    // Jurisdiction Policy Files 8)
    // //
    // http://www.oracle.com/technetwork/java/javase/downloads/jce8-download-2133166.html
    // // jdk7 (Java Cryptography Extension (JCE) Unlimited Strength
    // Jurisdiction Policy Files 7)
    // //
    // http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html
    // // jdk6 (Java Cryptography Extension (JCE) Unlimited Strength
    // Jurisdiction Policy Files 6)
    // //
    // http://www.oracle.com/technetwork/java/javase/downloads/jce-6-download-429243.html
    //
    // String source = CommonConvert.CommonGetStr( params.get( "source" ) );
    // String target = "";
    //
    // target = AES256Cipher.AES_Encode( source );
    //
    // resultVo.setResultCode( target );
    // resultVo.setResultName( source );
    // }
    // catch ( Exception e ) {
    // // TODO: handle exception
    // resultVo.setResultCode( "" );
    // resultVo.setResultName( CommonConvert.CommonGetStr( params.get( "source"
    // ) ) );
    // }
    // finally {
    // mv.setViewName( "jsonView" );
    // mv.addObject( "result", resultVo );
    // }
    // return mv;
    // }

    /* ## [MGR] - 회사목록 조회 ## */
    @RequestMapping("/mgr/summar/ExMgrSummaryCompListSelect.do")
    public ModelAndView ExMgrSummaryCompListSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO resultVo = new ResultVO();

        try {
            resultVo.setParams(param);
            resultVo = mgrService.CommonMgrCompListSelect(resultVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName(e.getMessage());
        }

        mv.setViewName("jsonView");
        mv.addObject("result", resultVo);

        return mv;
    }

    /* ## [MGR] - 표준적요 목록 조회 ## */
    @RequestMapping("/mgr/summar/ExMgrSummaryListSelect.do")
    public ModelAndView ExMgrSummaryListSelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO resultVo = new ResultVO();

        try {
            /* compSeq */
            resultVo.setParams(param);
            resultVo = mgrService.CommonMgrSummaryListSelect(resultVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName(e.getMessage());
        }

        mv.setViewName("jsonView");
        mv.addObject("result", resultVo);

        return mv;
    }

    /* ## [MGR] - 표준적요 목록 삭제 ## */
    @RequestMapping("/mgr/summar/ExMgrSummaryListDelete.do")
    public ModelAndView ExMgrSummaryListDelete(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO resultVo = new ResultVO();

        try {
            /* compSeq */
            resultVo.setParams(param);
            resultVo = mgrService.CommonMgrSummaryListDelete(resultVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName(e.getMessage());
        }

        mv.setViewName("jsonView");
        mv.addObject("result", resultVo);

        return mv;
    }

    /* ## [MGR] - 표준적요 목록 등록 ## */
    @RequestMapping("/mgr/summar/ExMgrSummaryListInsert.do")
    public ModelAndView ExMgrSummaryListInsert(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        ResultVO resultVo = new ResultVO();

        try {
            /* compSeq, summaryCode, summaryName, summaryDiv, drAcctCode, drAcctName, crAcctCode, crAcctName, vatAcctCode, vatAcctName, erpAuthCode, erpAuthName, bankPartnerCode, bankPartnerName, useYN, orderNum */
            resultVo.setParams(param);
            resultVo = mgrService.CommonMgrSummaryInsert(resultVo);
        } catch (Exception e) {
            cmLog.CommonSetError(e);
            resultVo.setResultCode(commonCode.FAIL);
            resultVo.setResultName(e.getMessage());
        }

        mv.setViewName("jsonView");
        mv.addObject("result", resultVo);

        return mv;
    }


    @RequestMapping("/form/interloca/FormOptionInfoSelect_ea230.do")
    public ModelAndView FormOptionInfoSelect_ea230(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();

        try {
            mv.addObject("result", formService.CommonPFormOptionInfoSelect_ea230());
        } catch (Exception e) {
            ExpInfo.TipLog("전자결재 옵션 [ea230] 조회중 오류가 발생되었습니다. 쿼리는 전자결재 담당 개발자에게 검토 받으세요.");
            e.printStackTrace();
            logger.error(e);
        }

        mv.setViewName("jsonView");

        return mv;
    }
}
