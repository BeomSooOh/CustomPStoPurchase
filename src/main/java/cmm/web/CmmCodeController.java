package cmm.web;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import cmm.service.CmmCodeService;
import common.helper.convert.CommonConvert;
import egovframework.com.utl.fcc.service.EgovStringUtil;

@Controller
public class CmmCodeController {

	@Resource(name = "CmmCodeService")
	private CmmCodeService cmmCodeService;

	//	#region ***** 코드바인딩
	// 코드바인딩(공통) -- div : CMCD, CO, WORK ...
	@SuppressWarnings ( "unused" )
	@RequestMapping("/cmm/GetCodeBind.do")
	public ModelAndView GetCodeBind(@RequestParam Map<String, Object> paramMap, HttpServletRequest request) throws Exception {

        LoginVO loginVO = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
		ModelAndView mv = new ModelAndView();

		String div = (String) paramMap.get("div"); // 공통코드조회
		String spYn = (String) paramMap.get("sp_yn");
		String cmCd = (String) paramMap.get("cm_cd"); // 사용언어일경우
		String coId = (String) paramMap.get("co_id"); // 사용언어일경우
		String langKind = loginVO.getLangCode();
		String empSeq = loginVO.getUniqId();
		String compSeq = loginVO.getCompSeq();
		String groupSeq = loginVO.getGroupSeq();
		String userSe = loginVO.getUserSe();

		Map<String, Object> resultMap = null;
		List<Map<String, Object>> resultList = null;

		paramMap.put("langCode", langKind);
		paramMap.put("emp_seq", empSeq);
		paramMap.put("comp_seq", compSeq);
		paramMap.put("group_seq", groupSeq);
		paramMap.put("userSe", userSe);

		if (EgovStringUtil.isEmpty(coId)) {
			if (!CommonConvert.CommonGetStr(loginVO.getUserSe()).equals("MASTER")) {
				paramMap.put("co_id", loginVO.getCompSeq());
			}
		}

		// 공통코드조회
		if (div.equals("CMCD")) {
			if (spYn == "Y") {
				//            	resultMap = cmmCodeService.GetCMCDList_SP(loginVO, co_id, cm_cd);
			} else {
				//            	resultMap = cmmCodeService.GetCMCDList(co_id, cm_cd, LangKind);
				//
				//                // 사용언어일경우
				if (cmCd == "cm0001") {
					//                	Map<String,Object> MultiLangInfo = GetGroupMultiLanguageSupportInfo(loginVO.getGroupSeq();
					//
					//                    if (MultiLangInfo.get("use_multi_lang") == "1")
					//                    {
					//                        List<String, String> UseLang = null;
					//                        UseLang.Add("KR");
					//
					//                        if (MultiLangInfo.get("use_lang_en").equals("1")) { UseLang.Add("EN"); }
					//                        if (MultiLangInfo.get("use_lang_jp").equals("1")) { UseLang.Add("JP"); }
					//                        if (MultiLangInfo.get("use_lang_cn").equals("1")) { UseLang.Add("CN"); }
					//
					//                        resultMap = tVCM_COMMONCODE.Where(t => UseLang.Contains(t.cd_val)).ToList();
					//                    }
					//                    else
					//                    {
					//                    	resultMap = tVCM_COMMONCODE.Where(t => t.cd_val == "KR").ToList();
					//                    }
				}
			}
		}
		// 회사리스트조회
		else if (div.equals("CO")) {
			if (CommonConvert.CommonGetStr(loginVO.getUserSe()).equals("MASTER")) {
				paramMap.put("comp_seq", "");
			}
			resultList = cmmCodeService.GetCoList(paramMap);
		}
		// 사용자 회사리스트조회 (로그인한 사용자의 겸직 포함 회사리스트)
		else if (div.equals("EMP_CO")) {
			resultList = cmmCodeService.GetEmpCoList(paramMap);
		}
		// 부서리스트조회
		else if (div.equals("DEPT")) {
			//        	resultMap = cmmCodeService.GetDeptList(co_id, LangKind);
		} else if (div.equals("DEPT_ALL")) {
			//        	resultMap = cmmCodeService.GetAllDeptList(co_id, LangKind);
		}
		// 메뉴구분조회
		else if (div.equals("MENU")) {
			//        	resultMap = cmmCodeService.GetMenuList(LangKind);
		}
		// 메뉴구분조회 - 미사용메뉴포함
		else if (div.equals("MENU_ALL")) {
			//        	resultMap = cmmCodeService.GetAllMenuList(LangKind);
		}
		// 권한리스트조회 - app_div : 적용범위(회사아이디), cm_cd : 권한구분(USER/DEPT)
		else if (div.equals("ROLE")) {
			String appDiv = coId;
			//            resultMap = cmmCodeService.GetRoleList(app_div, cm_cd, LangKind);
		} else if (div.equals("EAActivity")) // 전자결재 종류
		{
			resultList = cmmCodeService.GetActivityCode(paramMap);

		} else if (div.equals("EAFormFolder")) // 전자결재 양식 분류
		{
			resultList = cmmCodeService.GetFormFolderCode(paramMap);
		} else if (div.equals("EAProcess")) // 전자결재 결재프로세스
		{
			resultList = cmmCodeService.GetProcessCode(paramMap);
		}
		/*
		 * else if (div == "EALineSetRole") // 전자결재 결재라인 Role { resultMap = cmmCodeService.GetLineSetRoleCode(); }
		 */
		else if (div.equals("EABox")) // 전자결재 결재함
		{
			//        	resultMap = cmmCodeService.GetEaBoxCode();
		}
		//그룹리스트
		else if (div.equals("GROUP")) {
			//        	resultMap = cmmCodeService.GetGroupList();
		}
		//기타관리자코드리스트
		/*
		 * else if (div == "ETCADMINCD") { resultMap = cmmCodeService.GetEtcAdminUserCDList(); }
		 */
		/*
		 * //포털타입 else if (div == "PORTAL_TP") { resultMap = cmmCodeService.GetPortalTypeList(); }
		 */
		// DDL 년도
		else if (div.equals("YYYY")) {
			String searchDiv = cmCd; // yyyy100 : 전후5년, yyyy200 : 전후10년
			//            resultMap = cmmCodeService.GetYYYYList(searchDiv);
		}
		// 급여지급순번
		/*
		 * else if (div == "PAYSQ") { int GrpID = this.UserContext.GrpID; int CoID = this.UserContext.CoID; int UserID = this.UserContext.UserID; String ErpCD = this.UserContext.CoErpCD; String sErpVer = this.UserContext.CoErpHrVersion;
		 *
		 * String payYm = cm_cd; resultMap = CommonManager.GetPaySqList(GrpID, CoID, UserID, ErpCD, payYm, sErpVer); }
		 */
		// 급여지급일자
		/*
		 * else if (div == "PAYDT") { String GrpID = loginVO.getGroupSeq(); String CoID = loginVO.getCompSeq(); String UserID = loginVO.getUniqId(); String CoErpCD = this.UserContext.CoErpCD; String ErpCD = this.UserContext.EmpNO; String sErpVer = this.UserContext.CoErpHrVersion;
		 *
		 * String payYYYY = cm_cd; resultMap = CommonManager.GetPayDtList(GrpID, CoID, UserID, CoErpCD, ErpCD, payYYYY, sErpVer); }
		 */
		// 급여양식코드 - U
		/*
		 * else if (div == "TPREPORT") { int GrpID = this.UserContext.GrpID; int CoID = this.UserContext.CoID; String CoErpCD = this.UserContext.CoErpCD; String sErpVer = this.UserContext.CoErpHrVersion;
		 *
		 * resultMap = CommonManager.GetTpReportList(GrpID, CoID, CoErpCD, sErpVer); }
		 */
		// 근태상세코드
		/*
		 * else if (div == "ATTDETAIL_DIV") { resultMap = CommonManager.GetAttDetailList(co_id, cm_cd, LangKind); }
		 */
		// 지출결의 증빙유형
		/*
		 * else if (div == "EXAuth") { resultMap = CommonManager.GetEXAuthList(co_id); }
		 */ // 로그인 가능한 회사리스트
		/*
		 * else if (div == "LoginCO") { List<VSM_TCMGUSERDEPT> mVSM_TCMGUSERDEPT = CMUserManager.GetLogOnCompany(UserContext);
		 *
		 * resultMap = mVSM_TCMGUSERDEPT.Select(t => new VCM_COMMONCODE { cd_nm = t.co_nm, cd_val = t.co_id.ToString() }).ToList();
		 *
		 * }
		 */
		mv.setViewName("jsonView");/*
									 * mv.addAllObjects(resultMap); // data.result
									 */
		mv.addObject("list", resultList);

		return mv;
	}

}
