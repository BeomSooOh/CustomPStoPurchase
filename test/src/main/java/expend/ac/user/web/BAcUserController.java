/**
  * @FileName : BAcUserController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ac.user.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.vo.common.ResultVO;
import expend.ac.user.process.BAcUserProcessService;


/**
 *   * @FileName : BAcUserController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Controller
public class BAcUserController {

	/* ################################################## */
	/* 변수정의 */
	/* ################################################## */
	/* 변수정의 - Service */
	@Resource ( name = "BAcUserProcessService" )
	private BAcUserProcessService processService; /* 프로세스 */
	/* 변수정의 - Class */
	

	/* 양식 정보 조회 */
	@RequestMapping ( "/Ac/G20/Ex/AcExFormInfo.do" )
	public ModelAndView AcExFormInfo ( @RequestParam Map<String, Object> params ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			@SuppressWarnings ( "unused" )
			Map<String, Object> tempMap = new HashMap<String, Object>( );
			/* 양식정보 조회 */
			result.setaData( processService.AcExFormInfo( params ).getaData( ) );
			/* 반환 처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* G20 사원조회 */
	@RequestMapping ( "/Ac/G20/Ex/AcExErpEmpInfo.do" )
	public ModelAndView AcExErpEmpInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 초기값 정의 */
			result = processService.AcExErpEmpInfo( params );
			/* 반환 처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* G20 공통코드 조회 */
	@RequestMapping ( "/Ac/G20/Ex/AcExErpCommonCodeListInfo.do" )
	public ModelAndView AcExErpCommonCodeListInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 초기값 정의 */
			result = processService.AcExErpCommonCodeListInfo( params );
			/* 반환처리 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}
}
