package expend.np.user.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.util.CommonUtil;
import common.form.BCommonFormService;
import common.helper.convert.CommonConvert;
import common.helper.convert.CommonException;
import common.helper.excel.CommonExcel;
import common.helper.exception.CheckErpTypeException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.ConnectionVO;
import common.vo.common.InterlockName;
import common.vo.common.ResultVO;
import expend.ex.user.code.BExUserCodeService;
import expend.np.user.budget.BNpUserBudgetService;
import expend.np.user.card.BNpUserCardService;
import expend.np.user.code.BNpUserCodeService;
import expend.np.user.cons.BNpUserConsService;
import expend.np.user.cust.BNpUserCustService;
import expend.np.user.etax.BNpUserETaxService;
import expend.np.user.report.BNpUserReportService;
import expend.np.user.res.BNpUserResService;
import expend.np.user.reuse.BNpUserReUseServiceImpl;
import interlock.exp.approval.BApprovalService;

@Controller
public class BNpUserController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource(name = "CommonInfo")
	private CommonInfo				cmInfo;
	@Resource(name = "CommonLogger")
	private final CommonLogger			cmLog	= new CommonLogger();
	@Resource(name = "BNpUserCodeService")
	private BNpUserCodeService		codeService;
	@Resource(name = "BNpUserConsService")
	private BNpUserConsService		consService;					/* 품의서 정보 관리 */
	@Resource(name = "BNpUserResService")
	private BNpUserResService		resService;						/* 결의서 정보 관리 */
	@Resource(name = "BNpUserReportService")
	private BNpUserReportService	reportService;					/* 품의서 정보 관리 */
	@Resource(name = "BNpUserETaxService")
	private BNpUserETaxService		etaxService;					/* 세금계산서 정보 관리 */
	@Resource(name = "BApprovalService")
	private BApprovalService		approvalService;				/* 전자결재 연동 API */
	@Resource(name = "BCommonProcService")
	private BCommonProcService		g20ProcService;					/* 전자결재 연동 API */
	@Resource(name = "BNpUserBudgetService")
	private BNpUserBudgetService	budgetService;					/* 예산정보 연동 API */
	@Resource(name = "BExUserCodeService")
	private BExUserCodeService		exCodeService;
	@Resource(name = "BNpUserCardService")
	private BNpUserCardService		npCardService;
	@Resource(name = "BNpUserReUseService")
	private BNpUserReUseServiceImpl	npReUsedService;
	@Resource(name = "BNpUserCustService")
	private BNpUserCustService	custService;					/* 커스터마이징 전용 API */
	@Resource(name = "BCommonFormService")
	private BCommonFormService formService;
	/* ------------------------- 프로시저 사용 데이터 조회 테스트 ------------------------- */
	@RequestMapping("/expend/np/user/code/ExProcDataSelect.do")
	public ModelAndView ExProcDataSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/code/ExProcDataSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = g20ProcService.getProcResult(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("공통 코드 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* ------------------------- 공통 코드 조회 영역 ------------------------- */
	/* 공통 코드 조회 - 모든 코드 조회 공통사용 */
	@RequestMapping("/expend/np/user/code/ExCodeInfoSelect.do")
	public ModelAndView ExCodeInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/code/ExCodeInfoSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = codeService.GetCommonCode(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("공통 코드 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* ------------------------- 결재 작성 ------------------------- */
	/* 결재 작성 - 전자결재 인터락 정보 조회 */
	@RequestMapping("/ex/np/user/cons/interlock/ExDocMake.do")
	public ModelAndView ExDocMake(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/interlock/ExDocMake.do] " + params.toString(),params.get("groupSeq").toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO result = new ResultVO();
		try {
			/* 이전단계 URL 생성 */
			String interlockUrl = commonCode.EMPTYSTR;

		    /* servlet request property 확인용 로그  */
	        /* cmLog.CommonSetInfo("[[ request ContextPath ]] :: " + request.getContextPath());
	          cmLog.CommonSetInfo("[[ request PathInfo ]] :: " + request.getPathInfo());
		      cmLog.CommonSetInfo("[[ request RequestURL ]] :: " + request.getRequestURL().toString());
		      cmLog.CommonSetInfo("[[ request serverName ]] :: " + request.getServerName());
		      cmLog.CommonSetInfo("[[ request portName ]] :: " + request.getServerPort());
		      cmLog.CommonSetInfo("[[ request protocol ]] :: " + request.getProtocol());
		      cmLog.CommonSetInfo("[[ request servletPath ]] :: " + request.getServletPath());
		      cmLog.CommonSetInfo("[[ request isSecure ]] :: " + request.isSecure());
		      cmLog.CommonSetInfo("[[ request getScheme ]] :: " + request.getScheme());
		    */

		    String wegUrl = CommonConvert.CommonGetStr(params.get("eapCallDomain"));
		    if("".equals(wegUrl)) {
		      throw new Exception("eapCallDomain is Empty");
		    }
		    cmLog.CommonSetInfo("[[ CALL wegUrl ]] :: " + wegUrl);

			Map<String, Object> headerMap = new HashMap<String, Object>();
			List<Map<String, Object>> contentsMap = new ArrayList<Map<String, Object>>();
			Map<String, Object> footerMap = new HashMap<String, Object>();
			interlockUrl = wegUrl + "/exp/expend/np/user/NpUserCRDocPop.do?formSeq=" + params.get(commonCode.FORMSEQ).toString();
			headerMap.put(commonCode.APPROKEY, CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY)));
			headerMap.put(commonCode.PROCESSID, CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID)));
			headerMap.put(commonCode.FORMSEQ, CommonConvert.CommonGetStr(params.get(commonCode.FORMSEQ)));

			result.setHeader(headerMap);
			result.setContent(contentsMap);
			result.setFooter(footerMap);
			result.setProcessId(CommonConvert.CommonGetStr(params.get(commonCode.PROCESSID)));
			result.setApproKey(CommonConvert.CommonGetStr(params.get(commonCode.APPROKEY)));
			result.setInterlockUrl(interlockUrl);
			result.setInterlockName(InterlockName.EDITINFOBUTTONKR.toString());
			// 20180910 soyoung, interlockName 정보수정 영문/일문/중문 추가
			result.setInterlockNameEn(InterlockName.EDITINFOBUTTONEN.toString());
			result.setInterlockNameJp(InterlockName.EDITINFOBUTTONJP.toString());
			result.setInterlockNameCn(InterlockName.EDITINFOBUTTONCN.toString());
			result.setPreUrl(CommonConvert.CommonGetStr(wegUrl));
			result.setDocSeq(commonCode.EMPTYSEQ);
			result.setReDraftUrl(CommonConvert.CommonGetStr(params.get("reDraftUrl")));
			result.setOriApproKey(CommonConvert.CommonGetStr(params.get("oriApproKey")));
			result.setOriDocId(CommonConvert.CommonGetStr(params.get("oriDocId")));
			result.setFormGb(CommonConvert.CommonGetStr(params.get("form_gb")));
			result.setCopyApprovalLine(CommonConvert.CommonGetStr(params.get("copyApprovalLine")));
			result.setCopyAttachFile(CommonConvert.CommonGetStr(params.get("copyAttachFile")));
			params.put("eaType", loginVo.getEaType());
			result.setSelectSql( CommonConvert.CommonGetStr( formService.NpInterlockCodeQuery( params ) ) );

			if (params.get("docSeq") != null && !params.get("docSeq").toString().equals(commonCode.EMPTYSTR) && !params.get("docSeq").toString().equals(commonCode.EMPTYSEQ)) {
				result.setDocSeq(params.get("docSeq").toString());
				/* docTitle 조회 후 parameter로 넘겨야 한다. */
				if (!params.get("docSeq").toString().equals(commonCode.EMPTYSTR)) {
					// ResultVO tResult = new ResultVO();
					// tResult.setParams(params);
					/* 기존 전자결재 정보 조회 */
					// tResult = codeService.ExExpendDocInfoSelect( tResult );
					// result.setDocTitle(tResult.getaData().get(commonCode.DOCTITLE).toString());
				}
			}

			/* 결의서의 경우 참조품의 정보 조회 */
			if(params.get( "formType" ).toString( ).equals( "RES" )){
				result.setRefDocList( "" );
				ResultVO resInfo = resService.selectResDoc( params );
				if(resInfo.getResultCode( ).equals( commonCode.SUCCESS )){
					String confferDocSeq = CommonConvert.NullToString( resInfo.getAaData( ).get( 0 ).get( "confferDocSeq" ) );
					if(!confferDocSeq.equals( "" )){
						Map<String, Object> consInfoParam = new HashMap<String, Object>();
						consInfoParam.put( "consDocSeq", confferDocSeq );
						ResultVO consInfo = consService.selectConsDoc( consInfoParam );
						result.setRefDocList( CommonConvert.NullToString( consInfo.getAaData( ).get( 0 ).get( "docSeq" ) ) );
					}
				}
			}

			/* 출장 결의서의 경우 참조품의 정보 조회 */
			if(params.get( "formType" ).toString( ).equals( "TRIPRES" )){
				result.setRefDocList( "" );
					if(!CommonConvert.NullToString(params.get("tripConsDocSeq")).equals("")){
						Map<String, Object> consInfoParam = new HashMap<String, Object>();
						consInfoParam.put( "tripConsDocSeq", params.get("tripConsDocSeq") );
						ResultVO consInfo = consService.selecTripConsDoc( consInfoParam );
						result.setRefDocList( CommonConvert.NullToString( consInfo.getAaData( ).get( 0 ).get( "doc_seq" ) ) );
					}
				result.setReDraftUrl("");
			}
			
			if(params.get( "formType" ).toString( ).equals( "TRIPCONS" )){
				result.setReDraftUrl("");
			}

			result.setFormSeq(CommonConvert.CommonGetSeq(params.get(commonCode.FORMSEQ)));
			result = approvalService.DocMake(result);
			result.setInterlockUrl(interlockUrl + "?docSeq=" + result.getDocSeq());
			result.setEaType(loginVo.getEaType());

			//			result = consService.GetExDocMake( params );
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("전자결재 인터락 정보 조회 실패", ex);
			ex.printStackTrace();
			cmLog.CommonSetInfoToDatabase("[ #EXNP# ERROR @Controller-/ex/np/user/cons/interlock/ExDocMake.do] catch " + params.toString() + ex.toString(),params.get("groupSeq").toString(), "-", "EXNP");
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* ------------------------- 결재 작성 ------------------------- */
	/* 품의/결의 예산 초과 확인 */
	@RequestMapping("/ex/np/user/cons/approvalValidation.do")
	public ModelAndView approvalBudgetOverValidation(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/approvalValidation.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			// do nothing
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의/결의 예산 초과 확인 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* ------------------------- 결재 작성 ------------------------- */
	/* 품의/결의 예산과목 금액 정보 확인 */
	@RequestMapping("/ex/np/user/cons/consBudgetInfoSelect.do")
	public ModelAndView consBudgetInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/consBudgetInfoSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
			if (conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
				result = budgetService.selectG20BudgetInfo(params, conVo);
			}
			else {
				result = budgetService.selectiUBudgetInfo(params, conVo);
			}
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의/결의 예산 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* ------------------------- 결재 작성 ------------------------- */
	/* 품의/결의 예산과목 금액 정보 확인 */
	@RequestMapping("/ex/np/user/res/resBudgetInfoSelect.do")
	public ModelAndView resBudgetInfoSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/resBudgetInfoSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
			if (conVo.getErpTypeCode().equals(commonCode.ICUBE)) {
				result = budgetService.selectG20BudgetInfo(params, conVo);
			}
			else {
				result = budgetService.selectiUBudgetInfo(params, conVo);
			}
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의/결의 예산 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* ------------------------- 결재 작성 ------------------------- */
	/* 품의서 작성 - 참조 품의 리스트 조회 */
	@RequestMapping("/ex/np/user/cons/refferConsList.do")
	public ModelAndView refferConsList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/refferConsList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = reportService.selectUserConsList(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("참조품의 리스트 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 문서 전체 정보 조회 */
	@RequestMapping("/ex/np/user/cons/ConsAllinfo.do")
	public ModelAndView ConsDocAllinfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsDocList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = consService.selectConsAllInfo(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 정보 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 문서 정보 조회 */
	@RequestMapping("/ex/np/user/cons/ConsDocList.do")
	public ModelAndView ConsDocList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsDocList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.selectConsDoc(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 문서 정보 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 문서 정보 갱신 */
	@RequestMapping("/ex/np/user/cons/ConsDocUpdate.do")
	public ModelAndView ConsDocUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsDocUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.updateConsDoc(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 문서 정보 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 문서 결재 정보 갱신 */
	@RequestMapping("/ex/np/user/cons/ConsDocUpdataEAInfo.do")
	public ModelAndView ConsDocUpdataEAInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsDocUpdataEAInfo.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.updateConsDocEaInfo(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 문서 결재 정보 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 문서 정보 생성 */
	@RequestMapping("/ex/np/user/cons/ConsDocInsert.do")
	public ModelAndView ConsDocInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsDocInsert.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.insertConsDoc(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 문서 정보 생성 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 문서 정보 삭제 */
	@RequestMapping("/ex/np/user/cons/ConsDocDelete.do")
	public ModelAndView ConsDocDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsDocDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.deleteConsDoc(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 문서 정보 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 정보 조회 */
	@RequestMapping("/ex/np/user/cons/ConsHeadList.do")
	public ModelAndView ConsHeadList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsHeadList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.selectConsHead(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의서 정보 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 정보 갱신 */
	@RequestMapping("/ex/np/user/cons/ConsHeadUpdate.do")
	public ModelAndView ConsHeadUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsHeadUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.updateConsHead(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의서 정보 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 정보 생성 */
	@RequestMapping("/ex/np/user/cons/ConsHeadInsert.do")
	public ModelAndView ConsHeadInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsHeadInsert.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.insertConsHead(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의서 정보 생성 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 정보 삭제 */
	@RequestMapping("/ex/np/user/cons/ConsHeadDelete.do")
	public ModelAndView ConsHeadDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsHeadDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.deleteConsHead(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의서 정보 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 예산 조회 */
	@RequestMapping("/ex/np/user/cons/ConsBudgetList.do")
	public ModelAndView ConsBudgetList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsBudgetList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.consService.selectConsBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 예산 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 예산 갱신 */
	@RequestMapping("/ex/np/user/cons/ConsBudgetUpdate.do")
	public ModelAndView ConsBudgetUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsBudgetUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.consService.updateConsBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 예산 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 예산 생성 */
	@RequestMapping("/ex/np/user/cons/ConsBudgetInsert.do")
	public ModelAndView ConsBudgetInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsBudgetInsert.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.consService.insertConsBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO();
			result.setFail("품의 예산 생성 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 예산 삭제 */
	@RequestMapping("/ex/np/user/cons/ConsBudgetDelete.do")
	public ModelAndView ConsBudgetDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsBudgetDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.consService.deleteConsBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 예산 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 거래처 조회 */
	@RequestMapping("/ex/np/user/cons/ConsTradeList.do")
	public ModelAndView ConsTradeList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsTradeList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.selectConsTrade(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 거래처 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 거래처 갱신 */
	@RequestMapping("/ex/np/user/cons/ConsTradeUpdate.do")
	public ModelAndView ConsTradeUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsTradeUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.consService.updateConsTrade(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 거래처 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 거래처 생성 */
	@RequestMapping("/ex/np/user/cons/ConsTradeInsert.do")
	public ModelAndView ConsTradeInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsTradeInsert.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.consService.insertConsTrade(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 거래처 생성 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의 거래처 삭제 */
	@RequestMapping("/ex/np/user/cons/ConsTradeDelete.do")
	public ModelAndView ConsTradeDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsTradeDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.consService.deleteConsTrade(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 거래처 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 예산 잔액 조회 */
	@RequestMapping("/ex/np/user/cons/ConsBudgetBalanceSelect.do")
	public ModelAndView ConsBudgetBalanceSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsBudgetBalanceSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			/* 예산 잔액 조회 */
			result = CommonConvert.setNpResultFormat(this.consService.selectConsBudgetBalance(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 거래처 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 리스트 조회 */
	@RequestMapping("/ex/np/user/cons/ConsListSelect.do")
	public ModelAndView ConsListSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsListSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.selectRefferConsList(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 리스트 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}



	/* 권한 품의서 - 품의서 상세 정보 조회 */
	@RequestMapping("/ex/np/user/cons/selectConsDetailBudget.do")
	public ModelAndView selectConsDetailBudget(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/selectConsDetailBudget.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.consService.selectConsDetailBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("품의 상세 정보 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 문서 전체 정보 조회 */
	@RequestMapping("/ex/np/user/res/ResDocAllinfo.do")
	public ModelAndView ResDocAllinfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsDocList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = resService.selectResAllInfo(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 정보 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 - 결의 문서 최초 생성 */
	@RequestMapping("/ex/np/user/res/ResDocInsert.do")
	public ModelAndView ResDocInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/insertResDoc.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.resService.insertResDoc(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 문서 최초 생성 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서[참조 품의 가져오기] - 참조품의 문서 반영 */
	@RequestMapping("/ex/np/user/res/ResConfferInfoUpdate.do")
	public ModelAndView ResConfferInfoUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/updateResConfferInfo.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.resService.updateResConfferInfo(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("참조 품의 리스트 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 즐겨찾기 가져오기 반영 */
	@RequestMapping("/ex/np/user/res/ResFavoriteInfoUpdate.do")
	public ModelAndView ResFavoriteInfoUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResFavoriteInfoUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.resService.updateResFavoriteInfo(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("즐겨찾기 리스트 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 즐겨찾기 가져오기 반영 */
	@RequestMapping("/ex/np/user/cons/ConsFavoriteInfoUpdate.do")
	public ModelAndView ConsFavoriteInfoUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsFavoriteInfoUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.consService.updateConsFavoriteInfo(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("즐겨찾기 리스트 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 문서 정보 갱신 */
	@RequestMapping("/ex/np/user/res/ResDocUpdate.do")
	public ModelAndView ResDocUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/RessDocUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.resService.updateResDoc(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 문서 정보 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 문서 결재 정보 갱신 */
	@RequestMapping("/ex/np/user/res/ResDocUpdataEAInfo.do")
	public ModelAndView ResDocUpdataEAInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResDocUpdataEAInfo.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.resService.updateResDocEaInfo(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 문서 결재 정보 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 문서 정보 삭제 */
	@RequestMapping("/ex/np/user/res/ResDocDelete.do")
	public ModelAndView ResDocDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResDocDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.resService.deleteResDoc(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 문서 정보 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 정보 생성 */
	@RequestMapping("/ex/np/user/res/ResHeadInsert.do")
	public ModelAndView ResHeadInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResHeadInsert.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
		params.put("erpTypeCode", conVo.getErpTypeCode());
		try {
			result = this.resService.insertResHead(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의서 정보 생성 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 정보 조회 */
	@RequestMapping("/ex/np/user/res/ResHeadList.do")
	public ModelAndView ResHeadList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResHeadList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.resService.selectResHead(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의서 정보 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 정보 갱신 */
	@RequestMapping("/ex/np/user/res/ResHeadUpdate.do")
	public ModelAndView ResHeadUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResHeadUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
		params.put("erpTypeCode", conVo.getErpTypeCode());
		try {
			result = this.resService.updateResHead(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의서 정보 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}
	
	/* 임시저장 체크 */
	@RequestMapping("/ex/np/user/res/CheckDraftInfo.do")
	public ModelAndView CheckDraftInfo(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/CheckDraftInfo.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
		params.put("erpTypeCode", conVo.getErpTypeCode());
		try {
			result = this.resService.CheckDraftInfo(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("임시저장 체크 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}
	
	/* 결의서 정보 삭제 */
	@RequestMapping("/ex/np/user/res/ResHeadDelete.do")
	public ModelAndView ResHeadDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResHeadDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
		params.put("erpTypeCode", conVo.getErpTypeCode());
		try {
			result = this.resService.deleteResHead(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의서 정보 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 예산 조회 */
	@RequestMapping("/ex/np/user/res/ResBudgetList.do")
	public ModelAndView ResBudgetList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResBudgetList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.resService.selectResBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 예산 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 예산 갱신 */
	@RequestMapping("/ex/np/user/res/ResBudgetUpdate.do")
	public ModelAndView ResBudgetUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResBudgetUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.resService.updateResBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 예산 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 예산 생성 */
	@RequestMapping("/ex/np/user/res/ResBudgetInsert.do")
	public ModelAndView ResBudgetInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResBudgetInsert.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.resService.insertResBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 예산 생성 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 예산 삭제 */
	@RequestMapping("/ex/np/user/res/ResBudgetDelete.do")
	public ModelAndView ResBudgetDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResBudgetDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.resService.deleteResBudget(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 예산 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 거래처 조회 */
	@RequestMapping("/ex/np/user/res/ResTradeList.do")
	public ModelAndView ResTradeList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResTradeList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.resService.selectResTrade(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 거래처 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 거래처 갱신 */
	@RequestMapping("/ex/np/user/res/ResTradeUpdate.do")
	public ModelAndView ResTradeUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResTradeUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.resService.updateResTrade(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 거래처 갱신 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 거래처 생성 */
	@RequestMapping("/ex/np/user/res/ResTradeInsert.do")
	public ModelAndView ResTradeInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResTradeInsert.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.resService.insertResTrade(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 거래처 생성 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의 거래처 삭제 */
	@RequestMapping("/ex/np/user/res/ResTradeDelete.do")
	public ModelAndView ResTradeDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResTradeDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = CommonConvert.setNpResultFormat(this.resService.deleteResTrade(params));
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의 거래처 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 카드사용내역 조회 */
	@RequestMapping("/ex/np/user/res/CardUseHistorySelect.do")
	public ModelAndView ResCardUseHistorySelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/CardUseHistorySelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();


//		ResultVO result = null;
//		try {
//			result = this.resService.selectCardDataList(params);
//		}
//		catch (Exception ex) {
//			result = new ResultVO().setFail("카드사용내역 조회 실패", ex);
//		}
//		finally {
//			mv.setViewName("jsonView");
//			mv.addObject("result", result);
//		}
		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			params.put( "empSeq", loginVo.getUniqId() );
			params.put( "deptSeq", loginVo.getOrgnztId() );
			params.put( "compSeq", loginVo.getCompSeq() );
			params.put( "groupSeq", loginVo.getGroupSeq() );

			result.setLoginVo(loginVo);
			result.setParams(params);

			/* 카드 내역 조회 */
			result = npCardService.GetCardList2(params);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 세금계산서내역 조회 */
	@RequestMapping("/ex/np/user/res/ETaxUseHistorySelect.do")
	public ModelAndView ResETaxUseHistorySelect(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/ResETaxUseHistorySelect.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);

			/* [예외 검증] ERP 연동 확인 */
			CommonException.ERP(conVo);
			result.setParams(param);

			/* 세금계산서 목록 조회 */
			result = etaxService.GetETaxList(result, conVo);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (CheckErpTypeException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERP);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;

		//		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ETaxUseHistorySelect.do] " + params.toString(), "-", "EXNP");
		//		ModelAndView mv = new ModelAndView();
		//		ResultVO result = null;
		//		List<Map<String, Object>> gwList = new ArrayList<Map<String, Object>>();
		//		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
		//		params = CommonConvert.CommonSetMapCopy(CommonConvert.CommonGetEmpInfo(), params);
		//		try {
		//			/* ERP 세금계산서 정보 조회 */
		//			result = etaxService.SelectETaxList(params, conVo);
		//		}
		//		catch (Exception ex) {
		//			result = new ResultVO().setFail("카드사용내역 조회 실패", ex);
		//		}
		//		finally {
		//			mv.setViewName("jsonView");
		//			mv.addObject("result", result);
		//			mv.addObject("gwList", gwList);
		//		}
		//		return mv;
	}

	/* 사용자 - 품의서 현황 - 참조 결의 리스트 조회 */
	@RequestMapping("/expend/np/user/NpUserConsConfferResList.do")
	public ModelAndView NpAdminConsConfferResList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpUserConsConfferResList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			result = reportService.selectConsConfferResList(params);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 사용자 - 품의서 현황 - 품의현황 리스트 조회 */
	@RequestMapping("/expend/np/user/NpUserConsReportSelect.do")
	public ModelAndView NpUserConsReportSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/report/NpUserConsReportSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			result = reportService.selectConsReport(params);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 사용자 - 품의서 반환 - 품의서 예산목록 조회 */
	@RequestMapping("/expend/np/user/NpUserConsBudgetList.do")
	public ModelAndView NpAdminConsBudgetList(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpUserConsBudgetList.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			result = reportService.selectConsBudgetList(params);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 사용자 - 품의서 현황 - 예산별 반환/반환취소 */
	@RequestMapping("/expend/np/user/NpUnseConsConfferBudgetStatusUpdate.do")
	public ModelAndView NpUserConsConfferBudgetStatusUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpUnseConsConfferBudgetStatusUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			result = reportService.updateConfferBudgetStatus(params);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 사용자 - 품의서 현황 - 반환/반환취소 */
	@RequestMapping("/expend/np/user/NpUserConsConfferStatusUpdate.do")
	public ModelAndView NpUserConsConfferStatusUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/report/NpUserConsConfferStatus.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			result = reportService.updateConfferStatus(params);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 사용자 - 결의서 현황 - 결의현황 리스트 조회 */
	@RequestMapping("/expend/np/user/NpUserResReportSelect.do")
	public ModelAndView NpUserResReportSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/report/NpUserResReportSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			result = reportService.selectResReport(params);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 사용자 - 세금계산서 반영 - 세금계산서 내역 반영 */
	@RequestMapping("/expend/np/user/NpUserETaxReflect.do")
	public ModelAndView NpUserETaxReflect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/report/NpUserETaxReflect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			params.put("compSeq", loginVo.getCompSeq());
			params.put("empSeq", loginVo.getUniqId());
			result = etaxService.NpUserETaxReflect(params);
		}
		catch (Exception ex) {
			ex.printStackTrace();
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 매입전자세금계산서 현황 조회 */
	@RequestMapping("/expend/np/user/NPUserETaxReportList.do")
	public ModelAndView NPUserETaxReportList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		/* 로그인정보 */
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		/* ERP 연결정보 조회 */
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		param.put(commonCode.EMPSEQ, loginVo.getUniqId());
		param.put(commonCode.COMPSEQ, loginVo.getCompSeq());
		result.setParams(param);
		try {
			result = reportService.NPUserETaxReportList(result, conVo);
			result.setResultCode(commonCode.SUCCESS);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			result.setResultCode(commonCode.FAIL);
			result.setResultName(e.getMessage());
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 및 기능 2차 구현 - 김상겸 */
	/* ## ############################################# ## */
	/* 매입전자세금계산서 현황 조회 */
	@RequestMapping("/expend/np/user/NpGetETaxList.do")
	public ModelAndView NpGetETaxList(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpGetETaxList.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);

			/* [예외 검증] ERP 연동 확인 */
			CommonException.ERP(conVo);
			result.setParams(param);

			/* 세금계산서 목록 조회 */
			result = etaxService.GetETaxList(result, conVo);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (CheckErpTypeException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERP);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 매입전자세금계산서 현황 엑셀 다운로드 */
	@RequestMapping("/expend/np/user/NpGetETaxListExcel.do")
	public void NpGetETaxListExcel(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		/* Map */
		Map<String, Object> map = new HashMap<String, Object>();

		/* File */
		FileInputStream fileStream = null;
		BufferedInputStream bufferStream = null;
		ByteArrayOutputStream outStream = null;

		/* String */
		String fileName = "", filePath = "";

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);

			/* [예외 검증] ERP 연동 확인 */
			CommonException.ERP(conVo);
			result.setParams(param);

			/* 세금계산서 목록 조회 */
			result = etaxService.GetETaxList(result, conVo);

			for(Map<String, Object> item : result.getAaData( )){
				/* 사용 / 미사용 텍스트 보정 */
				String useYn = CommonConvert.NullToString( item.get( "useYn" ) );
				if( useYn.equals( "N" ) ){
					item.put( "useYn", "미사용" );
				}else {
					item.put( "useYn", "사용" );
				}

				/* 결의 / 미결의 텍스트 보정 */
				String sendYn = CommonConvert.NullToString( item.get( "sendYn" ) );
				if( sendYn.equals( "Y" ) ){
					item.put( "sendYn", "결의" );
				}else {
					item.put( "sendYn", "미결의" );
				}
			}

			/* 파일 명칭 정의 ( 매입전자세금계산서현황_20180101_사용자이름.xlsx ) */
			fileName = "매입전자세금계산서현황_" + CommonConvert.CommonGetStr(param.get("issDateFrom")) + "_" + CommonConvert.CommonGetStr(param.get("issDateTo")) + "_" + loginVo.getName() + ".xlsx";

			/* 파일 경로 */
            map.put("osType", CommonUtil.osType());
			map.put("pathSeq", commonCode.EXPPATHSEQ);
			map.put(commonCode.GROUPSEQ, loginVo.getGroupSeq());
			map = exCodeService.ExCommonExpGroupPathSelect(map);

			if (map == null || map.get("absolPath") == null || map.get("absolPath").toString().equals("")) { throw new Exception("Group path not exists.."); }

			filePath = map.get("absolPath").toString() + File.separator + commonCode.EXCELPATH + File.separator;

			/* 엑셀 생성 */
			if (CommonExcel.CreateExcelFile(result.getAaData(), param, filePath, fileName)) {
				/* 파일 반환 */
				CommonExcel.ExcelDownload(fileStream, bufferStream, outStream, (filePath + fileName), fileName, request, response);
			}

			result.setSuccess();
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}

	/* 매입전자세금계산서 미사용 처리 */
	@RequestMapping("/expend/np/user/NpSetETaxUseUpdateN.do")
	public ModelAndView NpSetETaxUseUpdateN(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		/* http://local.duzonnext.com:8080/exp/expend/np/user/NpSetETaxUseUpdateN.do?issNo=2017010141000009c0003o08&issDt=20180607&trRegNb=4382384230 */

		ModelAndView mv = new ModelAndView();

		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO result = new ResultVO();
		result.setLoginVo(loginVo);
		result.setParams(param);

		result = reportService.SetETaxUseUpdateN(result);

		mv.setViewName("jsonView");
		mv.addObject("result", result);
		return mv;
	}

	/* 매입전자세금계산서 사용 처리 */
	@RequestMapping("/expend/np/user/NpSetETaxUseUpdateY.do")
	public ModelAndView NpSetETaxUseUpdateY(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		/* http://local.duzonnext.com:8080/exp/expend/np/user/NpSetETaxUseUpdateY.do?issNo=2017010141000009c0003o08&issDt=20180607&trRegNb=4382384230 */

		ModelAndView mv = new ModelAndView();

		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO result = new ResultVO();
		result.setLoginVo(loginVo);
		result.setParams(param);

		result = reportService.SetETaxUseUpdateY(result);

		mv.setViewName("jsonView");
		mv.addObject("result", result);
		return mv;
	}

	/* 매입전자세금계산서 이관 처리 */
	@RequestMapping("/expend/np/user/NpSetETaxTrans.do")
	public ModelAndView NpSetETaxTrans(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();

		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		ResultVO result = new ResultVO();
		result.setLoginVo(loginVo);
		result.setParams(param);

		result = reportService.SetETaxTrans(result);

		mv.setViewName("jsonView");
		mv.addObject("result", result);
		return mv;
	}

	/* ## ############################################# ## */
	/* 나의 카드 사용 현황 및 기능 */
	/* ## ############################################# ## */
	/* 카드사용현황 */
	@RequestMapping("/expend/np/user/NpUserCardReportSelect.do")
	public ModelAndView NpUserCardReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpUserCardReportSelect.do] " + params.toString(), "-", "EXNP");

		/* MODELANDVIEW */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			result.setLoginVo(loginVo);
			result.setParams(params);

			/* 카드 내역 조회 */
			result = npCardService.GetCardList(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}


	/* ## ############################################# ## */
	/* 나의 카드 사용 현황 및 기능 */
	/* ## ############################################# ## */
	/* 카드사용현황 */
	@RequestMapping("/expend/np/user/NpUserCardReportSelect2.do")
	public ModelAndView NpUserCardReport2(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpUserCardReportSelect2.do] " + params.toString(), "-", "EXNP");

		/* MODELANDVIEW */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			params.put( "empSeq", loginVo.getUniqId() );
			params.put( "deptSeq", loginVo.getOrgnztId() );
			params.put( "compSeq", loginVo.getCompSeq() );
			params.put( "groupSeq", loginVo.getGroupSeq() );

			result.setLoginVo(loginVo);
			result.setParams(params);

			/* 카드 내역 조회 */
			result = npCardService.GetCardList2(params);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}


	/* 카드 내역 이관 */
	@RequestMapping("/expend/np/user/NPUserCardTrans.do")
	public ModelAndView NPUserCardTrans(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NPUserCardTrans.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 카드 내역 이관 */
			result = npCardService.SetCardTrans(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 카드 내역 사용 / 미사용 처리 */
	@RequestMapping("/expend/np/user/NPUserCardUseYN.do")
	public ModelAndView NPUserCardUseYN(@RequestParam Map<String, Object> param, HttpServletRequest request) throws Exception {
		// cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NPUserCardUseYN.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 카드 내역 사용 / 미사용 처리 */
			result = npCardService.SetCardUseYN(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 카드 내역 엑셀 다운로드 */
	@RequestMapping("/expend/np/user/NpUserCardReportExcel.do")
	public void ExAdminCardReportListExcelDown(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		/* Map */
		Map<String, Object> map = new HashMap<String, Object>();

		/* File */
		FileInputStream fileStream = null;
		BufferedInputStream bufferStream = null;
		ByteArrayOutputStream outStream = null;

		/* String */
		String fileName = "", filePath = "";

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);

			/* 카드 내역 목록 조회 */
			result.setAaData(CommonConvert.CommonGetJSONToListMap(CommonConvert.NullToString(param.get("tableData").toString())));

			/* 파일 명칭 정의 ( 나의카드사용내역현황_20180101_사용자이름.xlsx ) */
			fileName = "나의카드사용내역현황_" + CommonConvert.GetToday() + "_" + loginVo.getName() + ".xlsx";

			/* 파일 경로 */
            map.put("osType", CommonUtil.osType());
			map.put("pathSeq", commonCode.EXPPATHSEQ);
			map.put(commonCode.GROUPSEQ, loginVo.getGroupSeq());
			map = exCodeService.ExCommonExpGroupPathSelect(map);

			if (map == null || map.get("absolPath") == null || map.get("absolPath").toString().equals("")) { throw new Exception("Group path not exists.."); }

			filePath = map.get("absolPath").toString() + File.separator + commonCode.EXCELPATH + File.separator;

			/* 엑셀 생성 */
			if (CommonExcel.CreateExcelFile(result.getAaData(), param, filePath, fileName)) {
				/* 파일 반환 */
				CommonExcel.ExcelDownload(fileStream, bufferStream, outStream, (filePath + fileName), fileName, request, response);
			}

			result.setSuccess();
		}
		catch (Exception e) {
			// TODO: handle exception
		}
	}

	/* 카드사용내역 이관관리 조회 */
	@RequestMapping("/expend/np/user/NPUserCardTransHistoryList.do")
	public ModelAndView NpUserCardTransHistoryList(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NPUserCardTransHistoryList.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 카드 내역 사용 / 미사용 처리 */
			result = npCardService.GetCardTransHistoryList(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 매입전자세금계산서 이관관리 조회 */
	@RequestMapping("/expend/np/user/NPUserETaxTransHistoryList.do")
	public ModelAndView NPUserETaxTransHistoryList(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NPUserETaxTransHistoryList.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		/* VO */
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 매입전자세금계산서 이관 내역 조회 */
			result = etaxService.GetETaxTransHistoryList(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 품의서 재기안 기수정보 및 품의일자 조회 */
	@RequestMapping("/expend/np/user/ConsReUseGisu.do")
	public ModelAndView ConsReUseGisu(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/ConsReUseGisu.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 품의서 재기안 기수정보 및 품의일자 조회 */
			result = npReUsedService.ConsReUseGisuSelect(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 결의서 재기안 기수정보 및 발의일자 조회 */
	@RequestMapping("/expend/np/user/ResReUseGisu.do")
	public ModelAndView ResReUseGisu(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/ResReUseGisu.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 결의서 재기안 기수정보 및 품의일자 조회 */
			result = npReUsedService.ResReUseGisuSelect(result);
			result.setSuccess();
			mv.setViewName("jsonView");
		}
		catch (NotFoundLoginSessionException e) {
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 품의서 재기안 데이터 조회 */
	@RequestMapping("/expend/np/user/ConsReUseInfo.do")
	public ModelAndView ConsReUseInfo(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/ConsReUseInfo.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 품의서 재기안 처리를 위한 기존 데이터 조회 */
			npReUsedService.ConsReUseSelect(result);
			mv.setViewName("jsonView");
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* 결의서 재기안 데이터 조회 */
	@RequestMapping("/expend/np/user/ResReUseInfo.do")
	public ModelAndView ResReUseInfo(@RequestParam Map<String, Object> param, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/ResReUseInfo.do] " + param.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));
			result.setLoginVo(loginVo);
			result.setParams(param);

			/* 결의서 재기안 처리를 위한 기존 데이터 조회 */
			npReUsedService.ResReUseSelect(result);
			mv.setViewName("jsonView");
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		mv.addObject("result", result);
		return mv;
	}

	/* [CUST_001] ERPiU 회계단위-사업계획 연동 여부 확인 */
	@RequestMapping("/expend/np/user/CUST001NpUserCheckDivCdInclude.do")
	public ModelAndView CUST001NpUserCheckDivCdInclude(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/CUST001NpUserCheckDivCdInclude.do] " + params.toString(), "-", "EXNP");

		/* 서비스 파라미터 정리 */
		ModelAndView mv = new ModelAndView();
		LoginVO loginVo = new LoginVO();
		ConnectionVO conVo = new ConnectionVO();
		ResultVO result = new ResultVO();

		try {
			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();
			loginVo = CommonConvert.CommonGetEmpVO();
			conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));

			/* 결의서 재기안 처리를 위한 기존 데이터 조회 */
			result = custService.CUST001NpUserCheckDivCdInclude( params, conVo );
			mv.setViewName("jsonView");
		}
		catch (Exception e) {
			cmLog.CommonSetError(e);
			mv.addObject("errMsg", e.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}
		mv.addObject("result", result);
		return mv;
	}

	/* 결의서 즐겨찾기 등록 */
	@RequestMapping("/ex/np/user/res/FavoritesUpdate.do")
	public ModelAndView FavoritesResUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/FavoritesUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		try {
			result = this.resService.updateFavoritesStatus(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의서 정보 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 즐겨찾기 등록 */
	@RequestMapping("/ex/np/user/cons/FavoritesUpdate.do")
	public ModelAndView FavoritesConsUpdate(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/FavoritesUpdate.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		try {
			result = this.consService.updateFavoritesStatus(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("결의서 정보 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 즐겨찾기 조회 */
	@RequestMapping("/ex/np/user/res/ResFavoritesListSelect.do")
	public ModelAndView ResFavoritesListSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResFavoritesListSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		try {
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "empSeq", loginVo.getUniqId( ) );
			result = this.resService.selectFavoritesList(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("즐겨찾기 리스트 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 즐겨찾기 조회 */
	@RequestMapping("/ex/np/user/cons/ConsFavoritesListSelect.do")
	public ModelAndView ConsFavoritesListSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsFavoritesListSelect.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		try {
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "empSeq", loginVo.getUniqId( ) );
			result = this.consService.selectFavoritesList(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("즐겨찾기 리스트 조회 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 즐겨찾기 삭제 */
	@RequestMapping("/ex/np/user/res/ResFavoritesListDelete.do")
	public ModelAndView ResFavoritesListDelete(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResFavoritesListDelete.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		try {
			result = this.resService.deleteFavoritesList(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("즐겨찾기 리스트 삭제 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 물품명세 등록 */
	@RequestMapping("/ex/np/user/cons/ConsItemSpecInsert.do")
	public ModelAndView ConsItemSpecInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsItemSpecInsert.do] " + params.toString(), "-", "EXNP");

		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		try {
			result = this.consService.insertConsItemSpec(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("물품명세 정보 삽입 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 물품명세 조회 */
	@RequestMapping("/ex/np/user/cons/ConsItemSpecSelect.do")
	public ModelAndView ConsItemSpecSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/ConsItemSpecSelect.do] " + params.toString(), "-", "EXNP");

		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		try {
			result = this.consService.selectConsItemSpec(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("물품명세 조회실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}


	/* 결의서 물품명세 등록 */
	@RequestMapping("/ex/np/user/res/ResItemSpecInsert.do")
	public ModelAndView ResItemSpecInsert(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResItemSpecInsert.do] " + params.toString(), "-", "EXNP");

		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		try {
			result = this.resService.insertResItemSpec(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("물품명세 정보 삽입 실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 물품명세 조회 */
	@RequestMapping("/ex/np/user/res/ResItemSpecSelect.do")
	public ModelAndView ResItemSpecSelect(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/ResItemSpecSelect.do] " + params.toString(), "-", "EXNP");

		ModelAndView mv = new ModelAndView();
		ResultVO result = null;
		LoginVO loginVo = CommonConvert.CommonGetEmpVO();
		try {
			result = this.resService.selectResItemSpec(params);
		}
		catch (Exception ex) {
			result = new ResultVO().setFail("물품명세 조회실패", ex);
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 결의서 전자결재 인터양식 최신화 */
	@RequestMapping("/expend/np/user/res/UpdateResInterlock.do")
	public ModelAndView UpdateResInterlock(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/UpdateResInterlock.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
			params.put( "type", "res" );
			params.put( "preApproKey", "EXNPRES" );
			params.put( "preErpType", conVo.getErpTypeCode( ).equals( commonCode.ERPIU ) ? "U" : "I");
			params.put( "exDocSeq", params.get( "resDocSeq" ) );
			result = approvalService.UpdateInterlockForm(params);
		}
		catch (Exception ex) {
			result.setFail( "인터양식 갱신 실패", ex );
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/* 품의서 전자결재 인터양식 최신화 */
	@RequestMapping("/expend/np/user/cons/CopyInterlock.do")
	public ModelAndView CopyConsInterlock(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/cons/CopyInterlock.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
			params.put( "ErpType", conVo.getErpTypeCode( ).equals( commonCode.ERPIU ) ? "EXNPCONU" : "EXNPCONI");
			result = approvalService.CopyInterlock(params);
		}
		catch (Exception ex) {
			result.setFail( "인터양식 갱신 실패", ex );
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}

	/*결의서 전자결재 인터양식 최신화 */
	@RequestMapping("/expend/np/user/res/CopyInterlock.do")
	public ModelAndView CopyResInterlock(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/ex/np/user/res/CopyInterlock.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		ResultVO result = new ResultVO();
		try {
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
			params.put( "ErpType", conVo.getErpTypeCode( ).equals( commonCode.ERPIU ) ? "EXNPRESU" : "EXNPRESI");
			result = approvalService.CopyInterlock(params);
		}
		catch (Exception ex) {
			result.setFail( "인터양식 갱신 실패", ex );
		}
		finally {
			mv.setViewName("jsonView");
			mv.addObject("result", result);
		}
		return mv;
	}
}
