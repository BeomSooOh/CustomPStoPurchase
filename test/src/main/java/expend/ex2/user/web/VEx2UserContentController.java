/**
  * @FileName : VEx2UserPopController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.user.web;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.vo.common.CommonMapInterface.commonExPath;
import egovframework.com.cmm.annotation.IncludedInfo;

/**
  * @FileName : VEx2UserPopController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
@Controller
public class VEx2UserContentController {
	
	/**
	 * Contents View
	 * 공통사용 영역
	 * 접대부 비표 테스트 페이지
	 */
	@IncludedInfo ( name = "접대부 비표 테스트 페이지", order = 907, gid = 90 )
	@RequestMapping ( "/expend/ex/user/userEntertainmentFeeTestPage.do" )
	public ModelAndView userEntertainmentFeeTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		/* View path 정의 [UserCmmCodePopTestPage.jsp] */
		mv.setViewName( commonExPath.USERCONTENTPATH2 + commonExPath.USERENTERTAINMENTFEETESTPAGE );
		return mv;
	}
}
