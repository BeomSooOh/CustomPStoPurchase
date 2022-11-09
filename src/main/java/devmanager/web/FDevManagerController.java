package devmanager.web;

//import java.util.Collection;
import java.util.HashMap;
//import java.util.Iterator;
import java.util.List;
//import java.util.ListIterator;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

//import bizbox.orgchart.service.vo.LoginVO;
//import common.helper.convert.CommonConvert;
import common.helper.logger.CommonLogger;
//import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import common.vo.common.CommonInterface.commonCode;
//import common.vo.common.CommonMapInterface.commonDevPath;
import devmanager.bask.FDevManagerBaskPracticeService;
import devmanager.buildAssist.FDevManagerBuildAssistService;
import devmanager.cms.FDevManagerCMSService;
import devmanager.langpack.FDevManagerLangPackService;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;


@Controller
public class FDevManagerController extends EgovComAbstractDAO {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "FDevManagerLangPackServiceMaria" )
	private FDevManagerLangPackService DMlangPack;
	@Resource ( name = "FDevManagerCMSServiceMaria" )
	private FDevManagerCMSService DMCMS;
	@Resource ( name = "FDevManagerBuildAssistService")
	private FDevManagerBuildAssistService BuildService;
	@Resource ( name = "FDevManagerBaskPracticeService")
	private FDevManagerBaskPracticeService practiceService;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	/**
	 * @Method Name : FuncNp20Install
	 * @변경이력 :
	 * @메뉴 : 구축지원(980) 9802. 구축지원 - 비영리 회계 2.0 설치
	 * @Method 설명 : G20 1.0, 2.0, 스마트자금관리, 출장복명에 대한 배포를 지원하는 페이지
	 * @param params
	 * @param request
	 * @return
	 */
	@RequestMapping("/FuncNp20Check.do")
	public ModelAndView FuncNp20Check(@RequestParam Map<String,String> params, HttpServletRequest request) {

		ModelAndView mv = new ModelAndView();
		String config = BuildService.ConfigPassword(params).getResultCode();
		mv.addObject("pwd_config_result", config);

		if(config.equals(commonCode.SUCCESS)) {
			mv.addObject("cmsButton","<input class=\"puddSetup\" type=\"button\" id=\"install_button_cms\" value=\"CMS 연동모듈 설치\" onclick=\"fnPostBuild()\" style=\"width:300px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\" >");
			mv.addObject("g20Button","<input class=\"puddSetup\" type=\"button\" id=\"install_button_2.0\" value=\"회계 2.0 설치\" onclick=\"fnPostBuild()\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\">");
			mv.addObject("g20tripButton","<input class=\"puddSetup\" type=\"button\" id=\"install_button_trip_2.0\" value=\"출장복명 2.0 설치\" onclick=\"fnPostBuild()\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\">");
			mv.addObject("g20deleteButton","<input class=\"puddSetup\" type=\"button\" id=\"delete_button_2.0\" value=\"2.0 초기화\" onclick=\"fnDeleteExnp()\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\">");
			mv.addObject("fmButton","<input class=\"puddSetup\" type=\"button\" id=\"install_button_fm\" value=\"스마트자금관리 설치\" onclick=\"fnPostBuild()\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\">");
			mv.addObject("taxbillButtonIU","<input class=\"puddSetup\" type=\"button\" id= \"install_button_bill_iu\" value=\"IU 세금 계산서 설치\" onclick=\"fnPostBuild()\" style=\"width:300px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\" >");
			mv.addObject("taxbillButtonCUBE","<input class=\"puddSetup\" type=\"button\" id=\"install_button_bill_cube\" value=\"ICUBE 세금 계산서 설치\" onclick=\"fnPostBuild()\" style=\"width:300px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\">");
			mv.addObject("taxbillButtonAuto","<input class=\"puddSetup\" type=\"button\" id= \"install_button_bill_auto\" value=\"자동 세금 계산서 설치\" onclick=\"fnPostBuild()\" style=\"width:300px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\" >");

			mv.addObject("budgetButtonAll","<input class=\"puddSetup\" type=\"button\" id= \"install_button_budget_All\" value=\" 예산연동 모듈 설치\" onclick=\"fnBudget()\" style=\"width:300px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\" >");

			mv.addObject("cmsCloudBatchButton","<input class=\"puddSetup\" type=\"button\" id= \"install_button_CMS_Cloud\" value=\" 클라우드 cms연동 모듈 설치(2번 서버 이후)\" onclick=\"fnSynCloudcNow()\" style=\"width:600px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\" >");

			mv.addObject("cmsDelButton","<input class=\"puddSetup\" type=\"button\" id=\"delete_button_cms\" value=\"CMS 연동모듈 삭제\" onclick=\"fnPostBuild()\" style=\"width:300px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\" >");
			mv.addObject("cmsBatchButton","<input class=\"puddSetup\" type=\"button\" id=\"cms_batch_button\" value=\"CMS 배치 강제 실행\" onclick=\"fnSyncNow()\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\" >");
			mv.addObject("excelSummary","<input class=\"puddSetup\" type=\"file\" id=\"excel_summary\" value=\"표준적요 액셀 업로드\" onchange=\"fnExcelSummary(event)\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\" >");
			mv.addObject("excelAuth","<input class=\"puddSetup\" type=\"file\" id=\"excel_auth\" value=\"증빙적요 액셀 업로드\"  onchange=	\"fnExcelAuth(event)\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\" >");
			mv.addObject("refreshButton","<input class=\"puddSetup\" type=\"button\" id=\"refresh_button\" value=\"Refresh\"  onClick=	\"refreshGS()\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\" >");

			mv.addObject("exArea", "<div id=\"exArea\"></div>");
			mv.addObject("SummaryReset", "<input type=\"button\" class=\"puddSetup\" id=\"SummaryReset\" value=\"표준적요 초기화 버튼\" onclick=\"fnSummaryReset()\" style=\"width:400px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\">");
			mv.addObject("AuthReset", "<input type=\"button\" class=\"puddSetup\" id=\"AuthReset\" value=\"증빙유형 초기화 버튼\" onclick=\"fnAuthReset()\" style=\"width:400px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\">");

		}
		if (config.equals(commonCode.BPSUCCESS) ) {
			mv.addObject("excelSummary","<input class=\"puddSetup\" type=\"file\" id=\"excel_summary\" value=\"표준적요 액셀 업로드\" onchange=\"fnExcelSummary(event)\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\" >");
			mv.addObject("excelAuth","<input class=\"puddSetup\" type=\"file\" id=\"excel_auth\" value=\"증빙유형 액셀 업로드\"  onchange=	\"fnExcelAuth(event)\" style=\"width:300px; height: 45px; margin-top: 10px;  visibility: visible; font-size: 25px;\" >");
			mv.addObject("exArea", "<div id=\"exArea\"></div>");
            mv.addObject("SummaryReset", "<input type=\"button\" class=\"puddSetup\" id=\"SummaryReset\" value=\"표준적요 초기화 버튼\" onclick=\"fnSummaryReset()\" style=\"width:400px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\">");
            mv.addObject("AuthReset", "<input type=\"button\" class=\"puddSetup\" id=\"AuthReset\" value=\"증빙유형 초기화 버튼\" onclick=\"fnAuthReset()\" style=\"width:400px; height: 45px; margin-top: 10px; visibility: visible; font-size: 25px;\">");
		}

		mv.setViewName( "jsonView" );
		return mv;
	}

	/**
	 * @Method Name : FuncNp20Install
	 * @변경이력 :
	 * @메뉴 : 구축지원(980) 9802. 구축지원 - 비영리 회계 2.0 설치
	 * @Method 설명 : G20 1.0, 2.0, 스마트자금관리, 출장복명에 대한 배포를 지원하는 페이지
	 * @param params
	 * @param request
	 * @return
	 */
	@RequestMapping("/FuncNp20Install.do")
	public ModelAndView FuncNp20Install(@RequestParam Map<String,String> params, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		ResultVO vo = new ResultVO();

		if (request.isSecure()) {
			params.put("protocol", "https");
		} else {
			params.put("protocol", "http");
		}

		vo = BuildService.InsatllModules(params);

		if (vo.getResultCode().length() <= 8 && Integer.parseInt(vo.getResultCode()) == 11 ) {
			vo.setResultCode("SUCCESS");
		}
		else if (vo.getResultCode().length() <= 8 && Integer.parseInt(vo.getResultCode()) > 0  ) {
			vo.setResultCode("SUCCESS");
		}

		mv.addObject("isSuccess",vo.getResultCode());
		mv.setViewName( "jsonView" );
		return mv;
	}

	@RequestMapping("/FuncNp20Delete.do")
	public ModelAndView FuncNp20Delete(@RequestParam Map<String,String> params, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		ResultVO vo = new ResultVO();

		if (request.isSecure()) {
			params.put("protocol", "https");
		} else {
			params.put("protocol", "http");
		}

		vo = BuildService.deleteExnpDoc(params);

		if (vo.getResultCode().length() <= 8 && Integer.parseInt(vo.getResultCode()) == 11 ) {
			vo.setResultCode("SUCCESS");
		}
		else if (vo.getResultCode().length() <= 8 && Integer.parseInt(vo.getResultCode()) > 0  ) {
			vo.setResultCode("SUCCESS");
		}

		mv.addObject("isSuccess",vo.getResultCode());
		mv.setViewName( "jsonView" );
		return mv;
	}


	/**
	 * @Method Name : Refresh / exp, eap, gw
	 * @변경이력 :
	 * @메뉴 : 구축지원(980) 9802. 구축지원 - 비영리 회계 2.0 설치
	 * @Method 설명 : G20 1.0, 2.0, 스마트자금관리, 출장복명에 대한 배포를 지원하는 페이지
	 * @param params
	 * @param request
	 * @return
	 */
	@RequestMapping("/RefreshAll.do")
	public ModelAndView RefreshGS(@RequestParam Map<String,String> params, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		ResultVO vo = new ResultVO();

		if (request.isSecure()) {
			params.put("protocol", "https");
		} else {
			params.put("protocol", "http");
		}

		vo = BuildService.RefreshAll(params);

		if(!vo.getaData().get("group_seq").toString().equals("") && Integer.parseInt(vo.getResultCode()) >= 3) {
			vo.setResultCode("Refresh");
		}
		else {
			vo.setResultCode("Fail");
		}

		mv.addObject("isSuccess",vo.getResultCode());
		mv.setViewName( "jsonView" );
		return mv;
	}


	/**
	 *   * @Method Name : FuncDMLangPackMainList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 다국어 처리 페이지 ( devmanager/langpack/DevManagerLangPack.do ) / 다국어 코드 리스트 기본 조회
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@RequestMapping ( "/devmanager/langpack/FuncDMLangPackMainList.do" )
	public ModelAndView FuncDMLangPackMainList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		mv.addObject( "test", DMlangPack.SelectLanguageList( params ) );
		mv.setViewName( "jsonView" );
		/* 반환처리 */
		return mv;
	}

	/**
	 *   * @Method Name : FuncDMLangPackInsertorUpdate
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 다국어 처리 페이지 ( devmanager/langpack/DevManagerLangPack.do ) / 다국어 코드 업데이트, 인서트
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@RequestMapping ( "/devmanager/langpack/FuncDMLangPackInsertorUpdate.do" )
	public ModelAndView FuncDMLangPackInsertorUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		mv.addObject( "test", DMlangPack.InsertOrUpdateLanguageData( params ) );
		mv.setViewName( "jsonView" );
		/* 반환처리 */
		return mv;
	}

	/**
	 *   * @Method Name : FuncDMCMSMainList
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : CMS Log 조회
	 *   * @param param
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@RequestMapping ( "/devmanager/langpack/FuncDMCmsMainList.do" )
	public ModelAndView FuncDMCMSMainList ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		List<Map<String, Object>> vo = DMCMS.SelectCMSLogList( param );
		HashMap<String, Object> result = new HashMap<String, Object>( );
		result.put( "isSuccess", "true" );
		result.put( "returnObj", vo );
		mv.addAllObjects( result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	@RequestMapping("/devmanager/ExcelUpload.do")
	public ModelAndView FuncExcelUpload(@RequestParam Map<String, Object> params,HttpServletRequest request )throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.addObject( "result", BuildService.InsaltExcelUpload(params) );
		mv.setViewName( "jsonView" );
		return mv;
	}

	@RequestMapping("/devmanager/ResetSummary.do")
	public ModelAndView FunResetSummary(@RequestParam Map<String, Object> params,HttpServletRequest request )throws Exception{
	  ModelAndView mv = new ModelAndView();
	  mv.addObject("result", BuildService.ResetSummary(params));
	  mv.setViewName( "jsonView" );
	  return mv;
	}

	@RequestMapping("/devmanager/AuthExcelUpload.do")
	public ModelAndView FuncAuthExcelUpload(@RequestParam Map<String, Object> params,HttpServletRequest request )throws Exception{
		ModelAndView mv = new ModelAndView();
		mv.addObject( "result", BuildService.InsaltAuthExcelUpload(params) );
		mv.setViewName( "jsonView" );
		return mv;
	}

	   @RequestMapping("/devmanager/ResetAuth.do")
	    public ModelAndView FunResetAuth(@RequestParam Map<String, Object> params,HttpServletRequest request )throws Exception{
	      ModelAndView mv = new ModelAndView();
	      mv.addObject("result", BuildService.ResetAuth(params));
	      mv.setViewName( "jsonView" );
	      return mv;
	    }

	@RequestMapping("/devmanager/CompanyList.do")
	public ModelAndView FuncCompanyList(@RequestParam Map<String, Object> params,HttpServletRequest request )throws Exception{
	   ModelAndView mv = new ModelAndView();
       mv.addObject( "result", BuildService.MultiCompanyList(params) );
       mv.setViewName( "jsonView" );
      return mv;
    }

	@RequestMapping("/devmanager/InsertBudget.do")
	public ModelAndView FncBudget(@RequestParam Map<String, Object> params,HttpServletRequest request)throws Exception{
	     ResultVO vo = new ResultVO();
	     ModelAndView mv = new ModelAndView();
	     vo = BuildService.InsertBudgetAll(params);


	     mv.addObject("isSuccess", vo.getResultCode());
	     mv.setViewName( "jsonView" );

	     return mv;
	}

	@RequestMapping("/devmanager/CloudCmsBatch.do")
	public ModelAndView FncCloudCMSbatch(@RequestParam Map<String, Object> params,HttpServletRequest request)throws Exception{
        ResultVO vo = new ResultVO();
        ModelAndView mv = new ModelAndView();
        vo = BuildService.CloudCMSbatch(params);

        mv.addObject("isSuccess", vo.getResultCode());
        mv.setViewName( "jsonView" );

        return mv;
 }



	/**
	 * @Method Name : FuncUserAuth
	 * @변경이력 :
	 * @메뉴 : 구축지원(980) 9802. 구축지원 - 비영리 1.0
	 * @Method 설명 : 1.0 참조품의 권한 설정
	 * @param params
	 * @param request
	 * @return
	 */
	@RequestMapping("/FuncUserAuth.do")
	public ModelAndView FuncUserAuth(@RequestParam Map<String,String> params, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		ResultVO vo = new ResultVO();
		vo = BuildService.InsertConfferAuth(params);
		mv.addObject("isSuccess",vo.getResultCode());
		mv.setViewName( "jsonView" );
		return mv;
	}

	/**
	 * @Method Name : FuncDelAuth
	 * @변경이력 :
	 * @메뉴 : 구축지원(980) 9802. 구축지원 - 비영리 1.0
	 * @Method 설명 : 1.0 참조품의 권한 설정 삭제
	 * @param params
	 * @param request
	 * @return
	 */
	@RequestMapping("/FuncDelAuth.do")
	public ModelAndView FuncDelAuth(@RequestParam Map<String,String> params, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		ResultVO vo = new ResultVO();
		vo = BuildService.DeleteConfferAuth(params);
		mv.addObject("isSuccess",vo.getResultCode());
		mv.setViewName( "jsonView" );
		return mv;
	}

	/**
	 * @Method Name : FuncUserAuthUpdate
	 * @변경이력 :
	 * @메뉴 : 구축지원(980) 9802. 구축지원 - 비영리 1.0
	 * @Method 설명 : 1.0 참조품의 권한 설정 수정
	 * @param params
	 * @param request
	 * @return
	 */
	@RequestMapping("/FuncUserAuthUpdate.do")
	public ModelAndView FuncUserAuthUpdate(@RequestParam Map<String,String> params, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		ResultVO vo = new ResultVO();
		vo = BuildService.UpdateConfferAuth(params);
		mv.addObject("isSuccess",vo.getResultCode());
		mv.setViewName( "jsonView" );
		return mv;
	}

	/**
	 * @Method Name : FuncAuthList
	 * @변경이력 :
	 * @메뉴 : 구축지원(980) 9802. 구축지원 - 비영리 1.0
	 * @Method 설명 : 1.0 참조품의 권한 목록 리스트
	 * @param params
	 * @param request
	 * @return
	 */
	@RequestMapping("/FuncAuthList.do")
	public ModelAndView FuncAuthList(@RequestParam Map<String,String> params, HttpServletRequest request) {
		ModelAndView mv = new ModelAndView();
		ResultVO vo = new ResultVO();

		String searchCode = request.getParameter( "searchCode" );
		if ( searchCode == null ) {
			searchCode = "";
		}
		params.put( "searchCode", searchCode );

		try {
			vo = BuildService.SelectConfferAuth(params);
		}
		catch ( Exception ex ) {
			vo.setFail( "조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", vo );
		}

		return mv;

	}

	@RequestMapping ( "/practice/selectReportPage.do" )
	public ModelAndView practiceSelectReportPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );

		try {
			/* LIST */
			List<Map<String,Object>> result = practiceService.selectBaskMenu(params);
			mv.setViewName("jsonView");
			mv.addObject("menu",result);
		}
		catch (Exception e) {
			/* EXCEPTION */

			e.printStackTrace();
		}

		/* 반환처리 */
		return mv;
	}

}
