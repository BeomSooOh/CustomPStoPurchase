package expend.trip.admin.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.CommonMapInterface.commonTripPath;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;


@Controller
public class VTripAdminPopController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	/**
	 * Pop View
	 * [비영리/관리자] 출장지 조회 팝업
	 *
	 */
	@RequestMapping ( "/expend/trip/admin/AdminTripLocationInfo.do" )
	public ModelAndView AdminTripLocationInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/AdminTripLocationInfo.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			HttpSession session = request.getSession( );
			String langCode = (session.getAttribute( "langCode" ) == null ? "kr" : (String) session.getAttribute( "langCode" )).toLowerCase( );
			params.put( "langCode", langCode );
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "domesticDiv", request.getParameter( "domesticDiv" ) );
			mv.setViewName( commonTripPath.TRIPADMINPOPPATH + commonTripPath.ADMINTRIPLOCATIONINFO );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * [비영리/관리자] 직책그룹 조회 팝업
	 *
	 */
	@RequestMapping ( "/expend/trip/admin/AdminTripPositionGroupInfo.do" )
	public ModelAndView AdminTripPositionGroupInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/AdminTripPositionGroupInfo.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			HttpSession session = request.getSession( );
			String langCode = (session.getAttribute( "langCode" ) == null ? "kr" : (String) session.getAttribute( "langCode" )).toLowerCase( );
			params.put( "langCode", langCode );
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "domesticDiv", request.getParameter( "domesticDiv" ) );
			mv.setViewName( commonTripPath.TRIPADMINPOPPATH + commonTripPath.ADMINTRIPPOSITIONGROUPINFO );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Pop View
	 * [비영리/관리자] 교통수단 조회 팝업
	 *
	 */
	@RequestMapping ( "/expend/trip/admin/AdminTripTransPortInfo.do" )
	public ModelAndView AdminTripTransPortInfo ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/AdminTripTransPortInfo.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			HttpSession session = request.getSession( );
			String langCode = (session.getAttribute( "langCode" ) == null ? "kr" : (String) session.getAttribute( "langCode" )).toLowerCase( );
			params.put( "langCode", langCode );
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* 명칭설정 기능 정의 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "domesticDiv", request.getParameter( "domesticDiv" ) );
			mv.setViewName( commonTripPath.TRIPADMINPOPPATH + commonTripPath.ADMINTRIPTRANSPORTINFO );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}
}
