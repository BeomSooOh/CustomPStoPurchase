/**
  * @FileName : VInterlockPopController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package interlock.exp.web;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.helper.info.CommonInfo;
import common.vo.common.CustomLabelVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonPath;
import common.vo.common.ResultVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import interlock.exp.approval.BApprovalService;

/**
 *   * @FileName : VInterlockPopController.java   * @Project : BizboxA_exp   * @변경이력 :   * @프로그램 설명 :   
 */
@Controller
public class VInterlockPopController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource(name = "BApprovalService")
	private BApprovalService approvalService;

	@Resource(name = "CommonInfo")
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */

	/* 변수정의 - Class */
	/* Pop View */
	/* Pop View - 공통 */
	@RequestMapping("/ExpendPop.do")
	public ModelAndView ExpendPop(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView();
		String redirectUrl = commonCode.EMPTYSTR;
		/* 인증확인 */
		// if (EgovUserDetailsHelper.isAuthenticated()) {
		if (CommonConvert.CommonGetEmpVO() != null) {
			/* 프로세스 처리 */
			Map<String, Object> reParams = new HashMap<String, Object>();
			reParams = CommonConvert.CommonSetMapCopy(params, reParams);
			if (((String) reParams.get(commonCode.FORMTP)).equals(commonCode.EMPTYSTR)) {
				mv.setViewName(commonCode.EMPTYSTR);
			}
			else {
				switch ((String) reParams.get(commonCode.FORMTP)) {
					case commonCode.EXA: /* 지출결의서 ( Bizbox Alpha ) */
					case commonCode.EXI: /* 지출결의서 ( iCUBE ) */
					case commonCode.EXU: /* 지출결의서 ( ERPiU ) */
						redirectUrl = "/ex/expend/master/ExUserMasterPop.do";
						break;
					case commonCode.G20C: /* G20품의서 */
						redirectUrl = "/expend/ac/user/AcUserConsMasterPop.do";
						break;
					case commonCode.G20R: /* G20결의서 */
						redirectUrl = "/ex/expend/user/ExUserMasterPop.do";
						break;
					case commonCode.EZICUBE: /* 이지바로결의서 iCUBE */
					case commonCode.EZERPIU: /* 이지바로결의서 iU */
						redirectUrl = "/expend/ezbaro/EzbaroDocPop.do";
						break;
					case commonCode.ANGUI: /* iCUBE 국고보조통합시스템 연계 결의서 */
					case commonCode.ANGUU: /* ERPiU 국고보조통합시스템 연계 결의서 */
						redirectUrl = "/expend/angu/AnguPop.do";
						break;
					case commonCode.EXNPCONI: /* iCUBE G20 품의서 */
					case commonCode.EXNPCONU: /* ERPiU 원인행위 품의서 */
					case commonCode.EXNPRESI: /* iCUBE G20 결의서 */
					case commonCode.EXNPRESU: /* ERPiU 원인행위 결의서 */
						{
							String initTitle = URLEncoder.encode(CommonConvert.NullToString(reParams.get("initTitle")), "EUC-KR");
							reParams.put("initTitle", initTitle);
							redirectUrl = "/expend/np/user/NpUserCRDocPop.do";
							break;
						}
					case commonCode.TRIPCONS:
					case commonCode.TRIPRES :
						{
							String initTitle = URLEncoder.encode(CommonConvert.NullToString(reParams.get("initTitle")), "EUC-KR");
							reParams.put("initTitle", initTitle);
							redirectUrl = "/expend/trip/user/TripUserCRDocPop.do";
							break;
						}
	                default :
	                	break;
				}

				redirectUrl = redirectUrl + CommonConvert.CommonGetParamStr(reParams);
				mv.setViewName("redirect:" + redirectUrl);
			}
		}
		else {
			mv.setViewName("redirect:/uat/uia/egovLoginUsr.do");
		}
		return mv;
	}

	@RequestMapping("/ExpendReUsePop.do")
	public ModelAndView ExpendReUsePop(@RequestParam Map<String, Object> p, HttpServletRequest req, HttpServletResponse res) throws Exception {
		// 변수정의
		ModelAndView mv = new ModelAndView();
		Map<String, Object> reParam = new HashMap<String, Object>();
		String[] arrOriApproKey = CommonConvert.CommonGetStr(p.get("oriApproKey")).split("_");
		String formDTp = (arrOriApproKey.length >= 1 ? arrOriApproKey[0] : "");
		String seq = (arrOriApproKey.length >= 3 ? arrOriApproKey[2] : "");

		// 인증확인
		if (CommonConvert.CommonGetEmpVO() != null) {
			if (CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getEaType()).toUpperCase().equals("EA")) {
				// 현재 비영리 전자결재만 재기안 기능 제공 됨
				// { "oriApproKey": "원문서 외부시스템 연동 키", "oriDocId": "원문서 전자결재 아이디", "form_gb": "양식 타입(hwp : 0, html : 1)", "copyApprovalLine": "결재라인 포함 여부 ( 포함 : Y / 미포함 : N )", "첨부파일 포함 여부": "copyAttachFile": "첨부파일 포함 여부 ( 포함 : Y / 미포함 : N )" }
				// 현재 비영리 품의/결의 2.0 버전만 기능 제공 됨
				if (!CommonConvert.CommonGetStr(p.get("oriApproKey")).equals("")) {

					if ("|EXNPCONI|EXNPRESI|EXNPCONU|EXNPRESU|".indexOf(formDTp) > 0) {
						// 전자결재 연동 정보
						reParam.put("oriApproKey", CommonConvert.CommonGetStr(p.get("oriApproKey")));
						reParam.put("oriDocId", CommonConvert.CommonGetStr(p.get("oriDocId")));
						reParam.put("form_gb", CommonConvert.CommonGetStr(p.get("form_gb")));
						reParam.put("formGb", CommonConvert.CommonGetStr(p.get("form_gb")));
						reParam.put("copyApprovalLine", CommonConvert.CommonGetStr(p.get("copyApprovalLine")));
						reParam.put("copyAttachFile", CommonConvert.CommonGetStr(p.get("copyAttachFile")));
						reParam.put("formDTp", formDTp);

						if (formDTp.equals("EXNPCONI") || formDTp.equals("EXNPCONU")) {
							reParam.put("consDocSeq", seq);
						}
						else if (formDTp.equals("EXNPRESI") || formDTp.equals("EXNPRESU")) {
							reParam.put("resDocSeq", seq);
						}

						mv.addObject("ViewBag", reParam);
						mv.setViewName("redirect:/expend/np/user/NpUserReUsePop.do" + CommonConvert.CommonGetParamStr(reParam));
					}
				}
			}

		}
		else {
			mv.setViewName("redirect:/uat/uia/egovLoginUsr.do");
		}

		return mv;
	}

	@IncludedInfo(name = "ExpendPop 테스트 페이지", order = 9201, gid = 920)
	@RequestMapping("/ExpendPopTestPage.do")
	public ModelAndView ExpendPopTestPage(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/interlock/ExpendPopTestPage");
		return mv;
	}

	@IncludedInfo(name = "분개 정보 상세 팝업", order = 9202, gid = 920)
	@RequestMapping("/ExpendSlipDeatilPop.do")
	public ModelAndView ExpendSlipDetailPop(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/interlock/ExpendPopTestPage");
		return mv;
	}

	@IncludedInfo(name = "관리항목 정보 상세 팝업", order = 9203, gid = 920)
	@RequestMapping("/ExpendMngDeatilPop.do")
	public ModelAndView ExpendMngDetailPop(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/interlock/ExpendPopTestPage");
		return mv;
	}

	@IncludedInfo(name = "첨부파일 확인 팝업", order = 9204, gid = 920)
	@RequestMapping("/ApprovalAttachPop.do")
	public ModelAndView ApprovalAttachPop(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		ResultVO result = approvalService.SelectApprovalAttachInfo(params);
		mv.addObject("groupSeq", params.get("group_seq").toString());
		mv.addObject("expendSeq", params.get("expend_seq").toString());
		mv.addObject("listSeq", params.get("list_seq").toString());
		mv.addObject("fileInfos", CommonConvert.CommonGetListMapToJson(result.getAaData()));
		mv.setViewName(commonPath.POPPATH + commonPath.APPROVALATTACHPOP);
		return mv;
	}

	@IncludedInfo(name = "분개정보 확인 팝업", order = 9205, gid = 920)
	@RequestMapping("/ApprovalListPop.do")
	public ModelAndView ApprovalListPop(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
		String pCompSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
		String plangCode = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.LANGCODE)));
		String pGroupSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.GROUPSEQ)));
		CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
		mv.addObject("CL", vo.getData());
		ResultVO result = approvalService.SelectApprovalListInfo(params);
		mv.addObject("groupSeq", params.get("group_seq").toString());
		mv.addObject("expendSeq", params.get("expend_seq").toString());
		mv.addObject("listSeq", params.get("list_seq").toString());
		mv.addObject("listInfos", CommonConvert.CommonGetListMapToJson(result.getAaData()));
		mv.setViewName(commonPath.POPPATH + commonPath.APPROVALLISTPOP);
		return mv;
	}

	@IncludedInfo(name = "관리항목 확인 팝업", order = 9206, gid = 920)
	@RequestMapping("/ApprovalSlipPop.do")
	public ModelAndView ApprovalSlipPop(@RequestParam Map<String, Object> params, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
		String pCompSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
		String plangCode = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.LANGCODE)));
		String pGroupSeq = CommonConvert.CommonGetStr(CommonConvert.CommonGetStr(empInfo.get(commonCode.GROUPSEQ)));
		CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
		mv.addObject("CL", vo.getData());
		ResultVO result = approvalService.SelectApprovalSlipInfo(params);
		mv.addObject("groupSeq", params.get("group_seq").toString());
		mv.addObject("expendSeq", params.get("expend_seq").toString());
		mv.addObject("listSeq", params.get("list_seq").toString());
		mv.addObject("slipSeq", params.get("slip_seq").toString());
		mv.addObject("slipInfos", CommonConvert.CommonGetListMapToJson(result.getAaData()));
		mv.setViewName(commonPath.POPPATH + commonPath.APPROVALSLIPPOP);
		return mv;
	}

}