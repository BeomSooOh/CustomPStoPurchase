package expend.bi.admin.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonBiPath;
import common.vo.common.ConnectionVO;
import expend.ex.user.report.BExUserReportService;


@Controller
public class VBiAdminContentController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "BExUserReportService" )
	private BExUserReportService reportService;
	/* 변수정의 - Class */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */


	/* Contents View */
	/* Contents View - 회계 (사용자) */
	/* Contents View - 회계 (사용자) - 지출결의 관리 */
	/* Contents View - 회계 (사용자) - 지출결의 관리 - 나의 지출결의 현황 */
	//	@IncludedInfo ( name = "차량공개범위 관리", order = 1401, gid = 140 )
	@RequestMapping ( "/bi/admin/car/CarPublicPage.do" )
	public ModelAndView BiAdminCarPublicPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		try {
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			if ( CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				/* 변수정의 */
				LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
				/* ERP 연결정보 조회 */
				@SuppressWarnings ( "unused" )
				ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
				/* View path 정의 [UserExpendReport.jsp] */
				mv.setViewName( commonBiPath.ADMINCONTENTPATH + commonBiPath.ADMINCARPUBLIC );
			}
			else {
				mv.setViewName( commonBiPath.ERRORPAGEPATH + commonBiPath.CMERRORCHECKAUTH );
			}
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonBiPath.ERRORPAGEPATH + commonBiPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception e ) {
			cmLog.CommonSetError( e );
			throw e;
		}
		/* 반환처리 */
		return mv;
	}
}
