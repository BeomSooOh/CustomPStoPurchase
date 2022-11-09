/**
  * @FileName : VEx2UserPopController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.eclipse.jetty.util.ajax.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import expend.ex2.user.code.BEx2UserCodeService;


/**
 *   * @FileName : VEx2UserPopController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Controller
public class VEx2UserPopController {

	@Resource ( name = "BEx2UserCodeServiceImpl" )
	private BEx2UserCodeService Ex2UserCode;

	/**
	 * Contents View
	 * 공통사용 영역
	 * 접대부 비표 작성 팝업
	 */
	@RequestMapping ( "/expend/ex/user/userEntertainmentFee.do" )
	public ModelAndView userEntertainmentFee ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* feeSeq, callBack */
		/* JSON.parse('${FI_T000024}') ==> 사용구분(접대구분) */
		/* JSON.parse('${FI_T000025}') ==> 증빙구분 */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result24 = new ResultVO( );
			ResultVO result25 = new ResultVO( );
			List<Map<String, Object>> fiT000024 = new ArrayList<Map<String, Object>>( );
			List<Map<String, Object>> fiT000025 = new ArrayList<Map<String, Object>>( );
			/* 기본 사용 코드 조회 - 사용구분/접대구분 - FI_T000024 */
			params.put( "sourceType", commonCode.ERPIU );
			params.put( "codeType", "FI_T000024" );
			result24.setParams( params );
			fiT000024 = Ex2UserCode.getCommonCodeListSelect( result24 ).getAaData( );
			/* 기본 사용 코드 조회 - 증빙구분 - FI_T000025 */
			params.put( "sourceType", commonCode.ERPIU );
			params.put( "codeType", "FI_T000025" );
			result25.setParams( params );
			fiT000025 = Ex2UserCode.getCommonCodeListSelect( result25 ).getAaData( );
			/* 반환값 정의 */
			mv.addObject( "FI_T000024", CommonConvert.CommonGetListMapToJson( fiT000024 ) );
			mv.addObject( "FI_T000025", CommonConvert.CommonGetListMapToJson( fiT000025 ) );
			mv.addObject( "ViewBag", params );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		/* View path 정의 [UserCmmCodePopTestPage.jsp] */
		mv.setViewName( commonExPath.USERPOPPATH2 + commonExPath.USERENTERTAINMENTFEEPOP );
		return mv;
	}
}
