package expend.ex2.user.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.ResultVO;
import expend.ex2.user.code.BEx2UserCodeService;


@Controller
public class BEx2UserController {

	@Resource ( name = "BEx2UserCodeServiceImpl" )
	private BEx2UserCodeService Ex2UserCode;

	/* Biz */
	/* Biz - 지출결의 */
	/* Biz - 지출결의 - 접대비 정보 저장 */
	@RequestMapping ( "/ex2/expend/user/ExUserInsertEntertainmentFee.do" )
	public ModelAndView ExUserInsertEntertainmentFee ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result.setParams( params );
			result = Ex2UserCode.insertEntertainmentFee( result );
		}
		catch ( Exception ex ) {
			result.setFail( "접대비 정보 저장 실패", ex );
		}
		finally {
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		return mv;
	}

	/* Biz */
	/* Biz - 지출결의 */
	/* Biz - 지출결의 - 접대비 정보 갱신 */
	@RequestMapping ( "/ex2/expend/user/ExUserUpdateEntertainmentFee.do" )
	public ModelAndView ExUserUpdateEntertainmentFee ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			result.setParams( params );
			result = Ex2UserCode.updateEntertainmentFee( result );
		}
		catch ( Exception ex ) {
			result.setFail( "접대비 정보 갱신 실패", ex );
		}
		finally {
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		return mv;
	}

	/* Biz */
	/* Biz - 지출결의 */
	/* Biz - 지출결의 - 접대비 정보 조회 */
	@RequestMapping ( "/ex2/expend/user/ExUserSelectEntertainmentFee.do" )
	public ModelAndView ExUserSelectEntertainmentFee ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setParams( params );
			result = Ex2UserCode.selectEntertainmentFee( result );
		}
		catch ( Exception ex ) {
			result.setFail( "접대비 정보 갱신 실패", ex );
		}
		finally {
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		return mv;
	}
}