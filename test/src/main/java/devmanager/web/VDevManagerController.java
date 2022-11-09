package devmanager.web;

//import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.helper.logger.CommonLogger;
import common.vo.common.CommonMapInterface.commonDevPath;
import devmanager.cloudEnv.CloudDAOTestDAO;
import egovframework.com.cmm.annotation.IncludedInfo;


@Controller
public class VDevManagerController {
	/* 변수정의 */
	/* 변수정의 - Service */

	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	@Resource ( name = "CloudDAOTestDAO" )
	private CloudDAOTestDAO cloudDAOTestDAO ;

	/**
	 *   * @Method Name : DevManagerBuildAssistDocu
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 양식관련 다운로드 페이지
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "구축지원 - 지출결의 양식함", order = 9801, gid = 980 )
	@RequestMapping ( "/devmanager/langpack/DevManagerBuildAssistDocu.do" )
	public ModelAndView DevManagerBuildAssistDocu ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 */
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.BUILDASSISTDOCU );
		/* 반환처리 */
		return mv;
	}


	/**
	 *   * @Method Name : DevManagerBuildAssistDocu
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 양식관련 다운로드 페이지
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "구축지원 - 비영리 회계 2.0 설치", order = 9802, gid = 980 )
	@RequestMapping ( "/setting.do" )
	public ModelAndView Np20Install ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 */
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.NP20INSTALL );
		/* 반환처리 */
		return mv;
	}

	/**
	 *   * @Method Name : DevManagerLangPack
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 다국어 처리 조회 및 추가 페이지
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "개발지원 - 다국어 컨트롤", order = 9901, gid = 990 )
	@RequestMapping ( "/devmanager/langpack/ViewDevManagerLangPack.do" )
	public ModelAndView DevManagerLangPack ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 */
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.LANGPACK );
		/* 반환처리 */
		return mv;
	}

	/**
	 *   * @Method Name : DevManagerCMS
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : CMS 로그 조회 및 배치 강제 진행
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "개발지원 - CMS관리", order = 9902, gid = 990 )
	@RequestMapping ( "/devmanager/langpack/ViewDevManagerCMS.do" )
	public ModelAndView DevManagerCMS ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 [CMS.jsp] */
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.CMS );
		/* 반환처리 */
		return mv;
	}

	/**
	 *   * @Method Name :
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 신입사원 연습 페이지 no.1
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "개발지원 - 신입사원 스크립트연습 페이지", order = 9903, gid = 990 )
	@RequestMapping ( "/devmanager/langpack/practiceForNewbie.do" )
	public ModelAndView practiceForNewbie ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 [CMS.jsp] */

		cloudDAOTestDAO.getCloudVOSelect();
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.PRACTICEFORNEWBIE );
		/* 반환처리 */
		return mv;
	}

	/**
	 *   * @Method Name :
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 신입사원 연습 페이지 no.2
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "개발지원 - 신입사원 스크립트연습 페이지2", order = 9904, gid = 990 )
	@RequestMapping ( "/devmanager/langpack/practiceForBeginner.do" )
	public ModelAndView practiceForBeginner ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 [CMS.jsp] */
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.PRACTICEFORBEGINNER );
		/* 반환처리 */
		return mv;
	}

	/**
	 *   * @Method Name :
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 신입사원 연습 페이지 no.3
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "개발지원 - 신입사원 스크립트연습 페이지3", order = 9905, gid = 990 )
	@RequestMapping ( "/devmanager/langpack/practiceForJunior.do" )
	public ModelAndView practiceForJunior ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 [CMS.jsp] */
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.PRACTICEFORJUNIOR );
		/* 반환처리 */
		return mv;
	}

	/**
	 *   * @Method Name :
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 신입사원 연습 페이지 no.3
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "개발지원 - 신입사원 스크립트연습 페이지4", order = 9906, gid = 990 )
	@RequestMapping ( "/devmanager/langpack/practiceForMaster.do" )
	public ModelAndView practiceForMaster ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 [CMS.jsp] */
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.PRACTICEFORMASTER );
		/* 반환처리 */
		return mv;
	}


	/**
	 *   * @Method Name :
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 비영리 1.0 참조품의 권한 부여 페이지
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "비영리 1.0 참조품의 권한 부여 페이지", order = 9807, gid = 990 )
	@RequestMapping ( "/authManagerMain.do" )
	public ModelAndView authManagerMain ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* 페이지 고정 */
		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.AUTHMANAGERMAIN );
		/* 반환처리 */
		return mv;
	}


	/**
	 *   * @Method Name :
	 *   * @변경이력 :
	 *   * @메뉴 :
	 *   * @Method 설명 : 신입사원 연습 페이지 no.5
	 *   * @param params
	 *   * @param request
	 *   * @return
	 *   * @throws Exception
	 *   
	 */
	@IncludedInfo ( name = "개발지원 - 신입사원 현황페이지 연습 페이지5", order = 9907, gid = 990 )
	@RequestMapping ( "/practice/reportPage.do" )
	public ModelAndView practiceReportPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );



		mv.setViewName( commonDevPath.CONTENTPATH + commonDevPath.PRACTICEREPORTPAGE );
		/* 반환처리 */
		return mv;
	}


}
