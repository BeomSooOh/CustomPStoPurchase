package expend.bi.admin.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;

import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import expend.ex.user.expend.BExUserService;


@Controller
public class VBiAdminPopController {

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
//			mv.setViewName( commonBiPath.AdminContentPath + commonBiPath.BiCarPublicPage );
//		}
//		catch ( Exception e ) {
//			cmLog.CommonSetError( e );
//			throw e;
//		}
//		/* 반환처리 */
//		return mv;
//	}

}