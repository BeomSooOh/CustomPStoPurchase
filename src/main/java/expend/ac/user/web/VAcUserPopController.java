/**
  * @FileName : BAcUserPopController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonMapInterface.commonAcPath;


/**
 *   * @FileName : BAcUserPopController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Controller
public class VAcUserPopController {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - Class */
	

	/* ################################################## */
	/* Popup View */
	/* ################################################## */
	/* Popup View - G20 품의서 - Bizbox Alpha */
	@RequestMapping ( "/expend/ac/user/AcUserConsMasterPop.do" )
	public ModelAndView AcExConsDocForm ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> result = new HashMap<String, Object>( );
			/* 초기값 정의 */
			result = CommonConvert.CommonSetMapCopyNotKey( params );
			result = CommonConvert.CommonSetMapCopy( result );
			result.put( "requestUrl", request.getRequestURI( ) );
			result.put( "mode", "0" ); /* 품의서 / 결의서 구분 */
			/* 반환값 정의 */
			mv.addObject( "ViewBag", result );
			mv.setViewName( commonAcPath.USERPOPPATH + commonAcPath.CONSDOCPOP );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* 반환 */
		return mv;
	}

	/* Popup View - G20 결의서 - Bizbox Alpha */
	@RequestMapping ( "/ex/expend/user/ExUserMasterPop.do" )
	public ModelAndView AcExResDocForm ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			Map<String, Object> result = new HashMap<String, Object>( );
			/* 초기값 정의 */
			result = CommonConvert.CommonSetMapCopyNotKey( params );
			result = CommonConvert.CommonSetMapCopy( result );
			result.put( "requestUrl", request.getRequestURI( ) );
			result.put( "mode", "1" ); /* 품의서 / 결의서 구분 */
			result = CommonConvert.CommonSetMapCopy( result );
			/* 반환값 정의 */
			mv.addObject( "ViewBag", result );
			mv.setViewName( commonAcPath.USERPOPPATH + commonAcPath.RESDOCPOP );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* Popup View - G20 품의 / 결의 - 공통코드 */
	@RequestMapping ( "/ex/expend/user/ExUserCodePop.do" )
	public ModelAndView ExUserCodePop ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 반환값 정의 */
			mv.addObject( "ViewBag", params );
			mv.setViewName( commonAcPath.USERPOPPATH + commonAcPath.COMMONPOP );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}
}
