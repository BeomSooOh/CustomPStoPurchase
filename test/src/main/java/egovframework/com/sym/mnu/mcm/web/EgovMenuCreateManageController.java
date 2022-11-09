package egovframework.com.sym.mnu.mcm.web;

import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springmodules.validation.commons.DefaultBeanValidator;
import bizbox.orgchart.service.vo.LoginVO;
import egovframework.com.cmm.ComDefaultVO;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.mnu.mcm.service.EgovMenuCreateManageService;
import egovframework.com.sym.mnu.mcm.service.MenuCreatVO;
import egovframework.com.sym.mnu.mcm.service.MenuSiteMapVO;
import egovframework.rte.fdl.property.EgovPropertyService;

/**
 * 메뉴목록 관리및 메뉴생성, 사이트맵 생성을 처리하는 비즈니스 구현 클래스
 *
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 *
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 * 	 2011.07.29	 서준식          사이트맵 저장경로 수정
 *	2011.8.26	정진오			IncludedInfo annotation 추가
 * </pre>
 */

@Controller
public class EgovMenuCreateManageController {

	protected Log log = LogFactory.getLog(this.getClass());
	/* Validator */
	@Autowired
	private DefaultBeanValidator beanValidator;
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** EgovMenuManageService */
	@Resource(name = "meunCreateManageService")
	private EgovMenuCreateManageService menuCreateManageService;

	/** EgovMessageSource */
	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	/*********** 메뉴 생성 관리 ***************/

	/**
	 * *메뉴생성목록을 조회한다.
	 *
	 * @param searchVO
	 *            ComDefaultVO
	 * @return 출력페이지정보 "sym/mnu/mcm/EgovMenuCreatManage"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/mnu/mcm/EgovMenuCreatManageSelect.do")
	public String selectMenuCreatManagList(
			@ModelAttribute("searchVO") ComDefaultVO searchVO, ModelMap model)
			throws Exception {

		return "egovframework/com/sym/mnu/mcm/EgovMenuCreatManage";
	}

	/* 메뉴생성 세부조회 */
	/**
	 * 메뉴생성 세부화면을 조회한다.
	 *
	 * @param menuCreatVO
	 *            MenuCreatVO
	 * @return 출력페이지정보 "sym/mnu/mcm/EgovMenuCreat"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/mnu/mcm/EgovMenuCreatSelect.do")
	public String selectMenuCreatList(
			@ModelAttribute("menuCreatVO") MenuCreatVO menuCreatVO,
			ModelMap model) throws Exception {

		// edward authorcode 값이 없으면 리턴.
		/*
		if(EgovStringUtil.isEmpty(menuCreatVO.getAuthorCode())){
			System.out.println("  잘못된 접근. ");
			return "forward:/sym/mnu/mcm/EgovMenuCreatManageSelect.do";
		}
		*/

		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource
					.getMessage("fail.common.login"));
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}
		List listMenulist = menuCreateManageService
				.selectMenuCreatList(menuCreatVO);
		model.addAttribute("list_menulist", listMenulist);
		model.addAttribute("resultVO", menuCreatVO);

		return "egovframework/com/sym/mnu/mcm/EgovMenuCreat";
	}

	/**
	 * 메뉴생성처리 및 메뉴생성내역을 등록한다.
	 *
	 * @param checkedAuthorForInsert
	 *            String
	 * @param checkedMenuNoForInsert
	 *            String
	 * @return 출력페이지정보 등록처리시 "forward:/sym/mnu/mcm/EgovMenuCreatSelect.do"
	 * @exception Exception
	 */
	@RequestMapping("/sym/mnu/mcm/EgovMenuCreatInsert.do")
	public String insertMenuCreatList(
			@RequestParam("checkedAuthorForInsert") String checkedAuthorForInsert,
			@RequestParam("checkedMenuNoForInsert") String checkedMenuNoForInsert,
			@ModelAttribute("menuCreatVO") MenuCreatVO menuCreatVO,
			ModelMap model) throws Exception {
		String resultMsg = "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource
					.getMessage("fail.common.login"));
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}
		String[] insertMenuNo = checkedMenuNoForInsert.split(",");
		if (insertMenuNo == null || (insertMenuNo.length == 0)) {
			resultMsg = egovMessageSource.getMessage("fail.common.insert");
		} else {
			menuCreateManageService.insertMenuCreatList(checkedAuthorForInsert,
					checkedMenuNoForInsert);
			resultMsg = egovMessageSource.getMessage("success.common.insert");
		}
		model.addAttribute("resultMsg", resultMsg);
		return "forward:/sym/mnu/mcm/EgovMenuCreatSelect.do";
	}

	/* 메뉴사이트맵 생성조회 */
	/**
	 * 메뉴사이트맵을 생성할 내용을 조회한다.
	 *
	 * @param menuSiteMapVO
	 *            MenuSiteMapVO
	 * @return 출력페이지정보 등록처리시 "sym/mnu/mcm/EgovMenuCreatSiteMap"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/mnu/mcm/EgovMenuCreatSiteMapSelect.do")
	public String selectMenuCreatSiteMap(
			@ModelAttribute("menuSiteMapVO") MenuSiteMapVO menuSiteMapVO,
			ModelMap model) throws Exception {
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource
					.getMessage("fail.common.login"));
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}
		List listMenulist = menuCreateManageService
				.selectMenuCreatSiteMapList(menuSiteMapVO);
		model.addAttribute("list_menulist", listMenulist);
        LoginVO user = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
		menuSiteMapVO.setCreatPersonId(user.getId());
		model.addAttribute("resultVO", menuSiteMapVO);
		return "/popup/egovframework/com/sym/mnu/mcm/EgovMenuCreatSiteMapPopup";
	}

	/**
	 * 메뉴사이트맵 생성처리 및 사이트맵을 등록한다.
	 *
	 * @param menuSiteMapVO
	 *            MenuSiteMapVO
	 * @param valueHtml
	 *            String
	 * @return 출력페이지정보 "sym/mnu/mcm/EgovMenuCreatSiteMap"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/mnu/mcm/EgovMenuCreatSiteMapInsert.do")
	public String selectMenuCreatSiteMapInsert(
			@ModelAttribute("menuSiteMapVO") MenuSiteMapVO menuSiteMapVO,
			@RequestParam("valueHtml") String valueHtml, ModelMap model)
			throws Exception {
		boolean chkCreat = false;
		String resultMsg = "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource
					.getMessage("fail.common.login"));
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}


		menuSiteMapVO.setTmpRootPath(EgovProperties.RELATIVE_PATH_PREFIX
				+ ".." + System.getProperty("file.separator") + ".."
				+ System.getProperty("file.separator") + "..");
		menuSiteMapVO.setBndeFilePath("/html/egovframework/com/sym/mnu/mcm/");

		/*
		 * 사이트맵 파일 생성 위치 지정 if ("WINDOWS".equals(Globals.OS_TYPE)) {
		 * menuSiteMapVO
		 * .setTmp_rootPath("D:/egovframework/workspace/egovcmm/src/main/webapp"
		 * ); }else{menuSiteMapVO.setTmp_rootPath(
		 * "/product/jeus/webhome/was_com/egovframework-com-1_0/egovframework-com-1_0_war___"
		 * ); }
		 */
		chkCreat = menuCreateManageService.creatSiteMap(menuSiteMapVO,
				valueHtml);
		if (!chkCreat) {
			resultMsg = egovMessageSource.getMessage("fail.common.insert");
		} else {
			resultMsg = egovMessageSource.getMessage("success.common.insert");
		}
		List listMenulist = menuCreateManageService
				.selectMenuCreatSiteMapList(menuSiteMapVO);
		model.addAttribute("list_menulist", listMenulist);
		model.addAttribute("resultVO", menuSiteMapVO);
		model.addAttribute("resultMsg", resultMsg);
		return "/popup/egovframework/com/sym/mnu/mcm/EgovMenuCreatSiteMapPopup";


	}

	/* 메뉴사이트맵 생성조회 */
	/**
	 * 메뉴사이트맵을 생성할 내용을 조회한다.
	 *
	 * @param menuSiteMapVO
	 *            MenuSiteMapVO
	 * @return 출력페이지정보 등록처리시 "sym/mnu/mcm/EgovMenuCreatSiteMap"
	 * @exception Exception
	 */
	@RequestMapping(value = "/sym/mnu/mcm/EgovSiteMap.do")
	public String selectSiteMap(
			@ModelAttribute("menuCreatVO") MenuSiteMapVO menuSiteMapVO,
			ModelMap model) throws Exception {
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource
					.getMessage("fail.common.login"));
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}

        LoginVO user = (LoginVO) RequestContextHolder.getRequestAttributes().getAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
		menuSiteMapVO.setCreatPersonId(user.getId());

		List listMenulist = menuCreateManageService
				.selectSiteMapByUser(menuSiteMapVO);
		model.addAttribute("list_menulist", listMenulist);

		model.addAttribute("resultVO", menuSiteMapVO);
		return "egovframework/com/sym/mnu/mcm/EgovSiteMap";
	}

}
