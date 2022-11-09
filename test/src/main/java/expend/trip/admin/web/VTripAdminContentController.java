package expend.trip.admin.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckAuthorityException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CustomLabelVO;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.CommonMapInterface.commonTripPath;
import egovframework.com.cmm.annotation.IncludedInfo;


@Controller
public class VTripAdminContentController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );

	@IncludedInfo ( name = "출장비단가관리", order = 5100, gid = 510 )
	@RequestMapping ( "/expend/trip/admin/NpTripAmtSettingPage.do" )
	public ModelAndView NpTripAmtSettingPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/NpTripAmtSettingPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 페이지 리턴 */
			mv.setViewName( commonTripPath.TRIPADMINCONTENTPATH + commonTripPath.ADMINTRIPAMTSETTING );
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

	@IncludedInfo ( name = "교통수단관리", order = 5101, gid = 510 )
	@RequestMapping ( "/expend/trip/admin/NpTripTransportSettingPage.do" )
	public ModelAndView NpTripTransportSettingPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/NpTripTransportSettingPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 페이지 리턴 */
			mv.setViewName( commonTripPath.TRIPADMINCONTENTPATH + commonTripPath.ADMINTRIPTRANSPORTSETTING );
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

	@IncludedInfo ( name = "출장지관리", order = 5102, gid = 510 )
	@RequestMapping ( "/expend/trip/admin/NpTripLocationSettingPage.do" )
	public ModelAndView NpTripLocationSettingPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/NpTripLocationSettingPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 페이지 리턴 */
			mv.setViewName( commonTripPath.TRIPADMINCONTENTPATH + commonTripPath.ADMINTRIPLOCATIONSETTING );
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

	@IncludedInfo ( name = "직책그룹관리", order = 5103, gid = 510 )
	@RequestMapping ( "/expend/trip/admin/NpTripPositionGroupSettingPage.do" )
	public ModelAndView NpTripPositionGroupSettingPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/NpTripPositionGroupSettingPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 페이지 리턴 */
			mv.setViewName( commonTripPath.TRIPADMINCONTENTPATH + commonTripPath.ADMINTRIPPOSITIONGROUPSETTING );
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

	@IncludedInfo ( name = "[관리자] 출장품의현황", order = 5301, gid = 530 )
	@RequestMapping ( "/expend/trip/admin/AdminTripConsReport.do" )
	public ModelAndView AdminTripConsReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/AdminTripConsReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 페이지 리턴 */
			mv.setViewName( commonTripPath.TRIPADMINCONTENTPATH + commonTripPath.ADMINTRIPCONSREPORT );
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

	@IncludedInfo ( name = "[관리자] 출장결의현황", order = 5302, gid = 530 )
	@RequestMapping ( "/expend/trip/admin/AdminTripResReport.do" )
	public ModelAndView AdminTripResReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/admin/AdminTripResReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 페이지 리턴 */
			mv.setViewName( commonTripPath.TRIPADMINCONTENTPATH + commonTripPath.ADMINTRIPRESREPORT );
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