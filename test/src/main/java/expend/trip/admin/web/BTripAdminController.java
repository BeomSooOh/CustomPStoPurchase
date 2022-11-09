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
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.trip.admin.option.BTripAdminOptionService;
import expend.trip.admin.report.BTripAdminReportServiceImpl;


@Controller
public class BTripAdminController {

	/* 변수정의 */
	/* 변수정의 - Service */
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	@Resource ( name = "BTripAdminOptionService" )
	private BTripAdminOptionService optionService;
	@Resource ( name = "BTripAdminConsService" )
	private BTripAdminReportServiceImpl reportService;

	@RequestMapping ( "/expend/trip/admin/option/AdminTripSettingPageSelect.do" )
	public ModelAndView AdminTripSettingPageSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminTripSettingPageSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		String searchCode = request.getParameter( "searchCode" );
		if ( searchCode == null ) {
			searchCode = "";
		}
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			params.put( "langCode", loginVo.getLangCode( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "searchCode", searchCode );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.selectSettingOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	@RequestMapping ( "/expend/trip/admin/option/AdminTripSettingPageInsert.do" )
	public ModelAndView AdminTripSettingPageInsert ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminTripSettingPageInsert.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			params.put( "langCode", loginVo.getLangCode( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "compName", loginVo.getOrganNm( ) );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.insertSettingOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	@RequestMapping ( "/expend/trip/admin/option/AdminTripSettingPageUpdate.do" )
	public ModelAndView AdminTripSettingPageUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminTripSettingPageUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			params.put( "langCode", loginVo.getLangCode( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "compName", loginVo.getOrganNm( ) );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.updateSettingOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	@RequestMapping ( "/expend/trip/admin/option/AdminTripDelete.do" )
	public ModelAndView AdminTripSettingPageDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminTripSettingPageDelete.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.deleteSettingOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	@RequestMapping ( "/expend/trip/admin/option/AdminLocationSelect.do" )
	public ModelAndView AdminLocationSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminLocationSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		String searchCode = request.getParameter( "searchCode" );
		if ( searchCode == null ) {
			searchCode = "";
		}
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			params.put( "langCode", loginVo.getLangCode( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "useYn", "Y" );
			params.put( "searchCode", searchCode );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.selectLocationOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "출장지 조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	@RequestMapping ( "/expend/trip/admin/option/AdminTransPortSelect.do" )
	public ModelAndView AdminTransPortSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminTransPortSelect.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		String searchCode = request.getParameter( "searchCode" );
		if ( searchCode == null ) {
			searchCode = "";
		}
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			params.put( "langCode", loginVo.getLangCode( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "searchCode", searchCode );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.selectTransportOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "교통수단 조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	@RequestMapping ( "/expend/trip/admin/option/AdminTransPortInsert.do" )
	public ModelAndView AdminTransPortInsert ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminTransPortInsert.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			params.put( "langCode", loginVo.getLangCode( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "compName", loginVo.getOrganNm( ) );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.insertTransportOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "교통수단 조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	@RequestMapping ( "/expend/trip/admin/option/AdminTransPortUpdate.do" )
	public ModelAndView AdminTransPortUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminTransPortUpdate.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			/* 변수정의 */
			/* 세션 정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			/* ERP 연결정보 조회 */
			params.put( "langCode", loginVo.getLangCode( ) );
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "compName", loginVo.getOrganNm( ) );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.updateTransportOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "교통수단 조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	@RequestMapping ( "/expend/trip/admin/option/AdminTransPortDelete.do" )
	public ModelAndView AdminTransPortDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/code/AdminTransPortDelete.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			result = optionService.deleteTransportOption( params, conVo );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "교통수단 조회 실패", ex );
			ex.printStackTrace( );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 품의 현황 정보 조회 */
	@RequestMapping ( "/trip/admin/cons/selectTripConsReport.do" )
	public ModelAndView selectTripConsReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/admin/cons/selectTripConsReport.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = reportService.selectTripConsReport( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 현황 정보 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 결의 현황 정보 조회 */
	@RequestMapping ( "/trip/admin/res/selectTripResReport.do" )
	public ModelAndView selectTripResReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/admin/res/selectTripResReport.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			result = reportService.selectTripResReport( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 현황 정보 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 품의현황 - 품의서 삭제 */
	@RequestMapping ( "/trip/admin/report/deleteTripConsDoc.do" )
	public ModelAndView deleteTripConsDoc ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/admin/report/deleteTripConsDoc.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );
		ResultVO result = null;
		try {
			String requestDomain = request.getScheme() + "://" + ( request.getServerName() + ":" + request.getServerPort() );
            params.put( "requestDomain", requestDomain );
			result = reportService.deleteTripConsDoc( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 현황 정보 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}

	/* 관리자 결의현황 - 결의서 삭제 */
	@RequestMapping ( "/trip/admin/report/deleteTripResDoc.do" )
	public ModelAndView deleteTripResDoc ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/trip/admin/report/deleteTripResDoc.do] " + params.toString( ), "-", "TRIP" );
		ModelAndView mv = new ModelAndView( );

		ResultVO result = null;
		try {
			String requestDomain = request.getScheme() + "://" + ( request.getServerName() + ":" + request.getServerPort() );
            params.put( "requestDomain", requestDomain );
			result = reportService.deleteTripResDoc( params );
			mv.addObject( "result", result );
		}
		catch ( Exception ex ) {
			result = new ResultVO( ).setFail( "품의 현황 정보 조회 실패", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}




}
