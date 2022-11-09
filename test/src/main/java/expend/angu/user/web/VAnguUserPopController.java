/**
  * @FileName : VAnguUserPopController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonMapInterface.commonAnguPath;
import common.vo.common.ResultVO;
import expend.angu.user.angu.BAnguUserAnguService;
import expend.angu.user.code.BAnguUserCodeService;


/**
 *   * @FileName : VAnguUserPopController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :s
 *   
 */
@Controller
public class VAnguUserPopController {

	/* 변수정의 */
	@Resource ( name = "BAnguUserAnguService" )
	private BAnguUserAnguService Angu;
	@Resource ( name = "BAnguUserCodeService" )
	private BAnguUserCodeService code;

	/* ## [+] 국고보조 v2 ## */
	@RequestMapping ( "/expend/angu/AnguPop.do" )
	public ModelAndView AnguPop ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			Map<String, Object> document = new HashMap<String, Object>( );
			Map<String, Object> erpInfo = new HashMap<String, Object>( );
			Map<String, Object> optionInfo = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* ## [+] 문서 생성 ## */
			result = Angu.setAnguDocument_Insert( result );
			document = CommonConvert.CommonSetMapCopy( result.getaData( ) );
			/* ## [-] 문서 생성 ## */
			/* ## [+] 기본 필요 정보 ## */
			/* ## 기본 필요 정보 ## - ERP 회사 코드 / 회사 명칭 ( ViewBag.aData.erpCompSeq / ViewBag.aData.erpCompName ) */
			/* ## 기본 필요 정보 ## - ERP 사업장 코드 / 사업장 명칭 ( ViewBag.aData.erpBizSeq / ViewBag.aData.erpBizName ) */
			/* ## 기본 필요 정보 ## - ERP 부서 코드 / 부서 명칭 ( ViewBag.aData.erpDeptSeq / ViewBag.aData.erpDeptName ) */
			/* ## 기본 필요 정보 ## - ERP 기수 / 기수 시작일 / 기수 종료일 ( ViewBag.aData.erpCompGisu / ViewBag.aData.erpCompFrDate / ViewBag.aData.erpCompToDate ) */
			result = code.getEmpInfoI_Select( result );
			erpInfo = CommonConvert.CommonSetMapCopy( result.getaData( ) );
			/* ## [-] 기본 필요 정보 ## */
			/* ## [+] 옵션 조회 ## */
			result = code.getAnguTermInfoI_Select( result );
			optionInfo = CommonConvert.CommonSetMapCopy( result.getaData( ) );
			/* ## [-] 옵션 조회 ## */
			/* 반환처리 */
			result.setaData( CommonConvert.CommonSetMapCopy( result.getaData( ), document ) );
			result.setaData( CommonConvert.CommonSetMapCopy( result.getaData( ), erpInfo ) );
			result.setaData( CommonConvert.CommonSetMapCopy( result.getaData( ), optionInfo ) );
			mv.addObject( "ViewBag", result );
			/* /expend/angu/user/pop/AnguMasterPop */
			mv.setViewName( commonAnguPath.USERPOPPATH + "AnguPop" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}
	/* ## [-] 국고보조 v2 ## */

	/* Popup View */
	/* Popup View - 국고보조집행결의서 */
	@RequestMapping ( "/expend/angu/AnguMasterPop.do" )
	public ModelAndView AnguMasterPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameters : formSeq */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 반환값 정의 */
			/* groupSeq, compSeq, bizSeq, deptSeq, empSeq, langCode, userSe, erpEmpSeq, erpCompSeq, eaType */
			result = Angu.EmpInfoS( result );
			params = CommonConvert.CommonSetMapCopy( result.getaData( ), params );
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			params = CommonConvert.CommonSetMapCopy( (Map<String, Object>) Angu.TermInfoS( result ).getaData( ), params );
			/* 기본값 정의 */
			result.setaData( params );
			/* 반환처리 */
			mv.addObject( "ViewBag", result.getaData( ) );
			/* /expend/angu/user/pop/AnguMasterPop */
			mv.setViewName( commonAnguPath.USERPOPPATH + commonAnguPath.ANGUMASTERPOP );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* Popup View - 인력정보등록 */
	@RequestMapping ( "/expend/angu/AnguEmpPop.do" )
	public ModelAndView AnguEmpPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameters : formSeq */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 반환값 정의 */
			/* groupSeq, compSeq, bizSeq, deptSeq, empSeq, langCode, userSe, erpEmpSeq, erpCompSeq, eaType */
			result = Angu.EmpInfoS( result );
			params = CommonConvert.CommonSetMapCopy( result.getaData( ), params );
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 정의 */
			result.setaData( params );
			/* 반환처리 */
			mv.addObject( "ViewBag", result.getaData( ) );
			/* /expend/angu/user/pop/AnguEmpPop */
			mv.setViewName( commonAnguPath.USERPOPPATH + commonAnguPath.ANGUEMPPOP );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* Popup View - 예산과목 코드도움 */
	@RequestMapping ( "/expend/angu/AnguBudgetListPop.do" )
	public ModelAndView AnguBudgetListPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameters : formSeq */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 반환값 정의 */
			/* groupSeq, compSeq, bizSeq, deptSeq, empSeq, langCode, userSe, erpEmpSeq, erpCompSeq, eaType */
			result = Angu.EmpInfoS( result );
			params = CommonConvert.CommonSetMapCopy( result.getaData( ), params );
			params = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), params );
			/* 기본값 정의 */
			result.setaData( params );
			/* 반환처리 */
			mv.addObject( "ViewBag", result.getaData( ) );
			/* /expend/angu/user/pop/AnguBudgetListPop */
			mv.setViewName( commonAnguPath.USERPOPPATH + commonAnguPath.ANGUBUDGETLISTPOP );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}
}
