package expend.bi.user.web;

import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonMapInterface;
import expend.ex.user.expend.BExUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
public class VBiUserPopController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "BExUserService" )
	private BExUserService expendService; /* Expend Service */
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */


	/* Pop View */
	/* Pop View - 지출결의 */
	/* Pop View - 지출결의 - 지출결의 작성 */
//	@IncludedInfo ( name = "사용자 지출결의 작성", order = 901, gid = 90 )
//	@RequestMapping ( "/bi/car/asd.do" )
//	public ModelAndView BiUserCarPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
//		ModelAndView mv = new ModelAndView( );
//		try {
//			/* View path, ViewBag 정의 [MasterPop.jsp] */
////			mv.addObject( "ViewBag", result );
//			mv.setViewName( commonBiPath.AdminContentPath + commonBiPath.BiCarPublicPage );
//		}
//		catch ( Exception e ) {
//			cmLog.CommonSetError( e );
//			throw e;
//		}
//		/* 반환처리 */
//		return mv;
//	}

	/* Pop View */
	/* Pop View - 운행기록부 */
	/* Pop View - 운행기록부 - 차량선택 팝업 */
	@RequestMapping( "/bi/car/CarSelectPop.do" )
	public ModelAndView BiUserCarSelectionPop () throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			/* View path, ViewBag 정의 [UserCarSelectPop.jsp] */
			mv.setViewName( CommonMapInterface.commonBiPath.USERPOPPATH + CommonMapInterface.commonBiPath.USERCARSELECTPOP);
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		/* 반환처리 */
		return mv;
	}
}