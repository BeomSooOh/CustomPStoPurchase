package expend.np.admin.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import bizbox.orgchart.service.vo.LoginVO;
import bizbox.orgchart.util.JedisClient;
import cloud.CloudConnetInfo;
import common.helper.convert.CommonConvert;
import common.helper.convert.CommonException;
import common.helper.exception.CheckAuthorityException;
import common.helper.exception.CheckErpTypeException;
import common.helper.exception.CheckICUBEG20TypeException;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundERPEmpCdException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import common.vo.common.ResultVO;
import egovframework.com.cmm.annotation.IncludedInfo;
import expend.np.admin.config.BNpAdminConfigService;
import expend.np.admin.option.BNpAdminOptionService;
import expend.np.user.option.BNpUserOptionService;


@Controller
public class VNpAdminContentController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService userServiceOption; /* Expend Service */
	@Resource ( name = "BNpAdminOptionService" )
	private BNpAdminOptionService serviceOption;
	@Resource ( name = "BNpAdminConfigService" )
	private BNpAdminConfigService configService;

	/**
	 * Contents View
	 * 비영리 옵션 설정
	 * [비영리] 옵션 설정 페이지
	 */
	@IncludedInfo ( name = "[비영리/관리자] 품의결의 환경설정", order = 4100, gid = 410 )
	@RequestMapping ( "/expend/np/admin/NpAdminOptionSettingPage.do" )
	public ModelAndView NpUserCodeTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminOptionSettingPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 페이지 리턴 */
			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPEXPENDSETTING );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Contents View
	 * 비영리 지출결의 현황
	 * [비영리] 지출결의 현황 - 지출결의 전송
	 */
	@IncludedInfo ( name = "[비영리/관리자] 지출결의 전송", order = 4110, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpApprovalSendList.do" )
	public ModelAndView NpApprovalSendList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpApprovalSendList.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - 전자결재 양식 정보 */
			ArrayList<Map<String, Object>> eaFormInfo = (ArrayList<Map<String, Object>>) userServiceOption.selectEaBaseData( params, conVo ).getAaData( );
			mv.addObject( "eaBaseInfo", CommonConvert.CommonGetListMapToJson( eaFormInfo ) );
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			/* 사용자 기본 옵션 조회 - ERP 옵션 정보 조회 */
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			/* 사용자 기본 옵션 조회 - GW 옵션 정보 조회 */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			/* 사용자 기본 옵션 조회 - ERP 기본정보 조회 */
			mv.addObject( "erpBaseInfo", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPBaseData( params, conVo ).getAaData( ) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);

			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINRESSENDLIST );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Contents View
	 * 비영리 카드사용 현황
	 * [비영리] 카드사용 현황
	 */
	@IncludedInfo ( name = "[비영리/관리자] 카드사용현황", order = 4111, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminCardReport.do" )
	public ModelAndView NpAdminCardReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminCardReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			boolean bool = false;
			
			JedisClient jedisClient = CloudConnetInfo.getJedisClient();

	        String buildType = jedisClient.getBuildType();

            if (buildType != null && buildType.equals("build")) {
                bool = true;
            }
	        
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			mv.addObject("ViewBag", params);
			mv.addObject("buildType", bool);
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPCARDREPORT );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Contents View
	 * [비영리] 품의서 현황
	 */
	@IncludedInfo ( name = "[비영리/관리자] 품의서 현황", order = 4112, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminConsReport.do" )
	public ModelAndView NpAdminConsReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminConsReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPCONSREPORT );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Contents View
	 * [비영리] 결의서 현황
	 */
	@IncludedInfo ( name = "[비영리/관리자] 결의서 현황", order = 4113, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminResReport.do" )
	public ModelAndView NpAdminResReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminResReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);

			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPRESREPORT );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Contents View
	 * [비영리] 지출결의설정 - 기본설정
	 */
	@IncludedInfo ( name = "[비영리/관리자] 품의결의 기본설정", order = 4115, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminMasterOption.do" )
	public ModelAndView NpAdminMasterOption ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminMasterOption.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}

			/* 기본설정 옵션 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(CommonConvert.CommonGetEmpVO().getCompSeq()));
			params.put( "compSeq", CommonConvert.CommonGetEmpVO( ).getCompSeq( ) );
			params.put( "erpType", conVo.getErpTypeCode( ) );
			mv.addObject( "erpType", conVo.getErpTypeCode( ) );
			if(conVo.getErpTypeCode( ).equals( commonCode.ICUBE )){
				params.put( "optionType", "NP_OPTION_G20" );
				params.put( "useSw", commonCode.ICUBE );
			}else if(conVo.getErpTypeCode( ).equals( commonCode.ERPIU )){
				params.put( "optionType", "NP_OPTION_U" );
				params.put( "useSw", commonCode.ERPIU );
			}

			/* 품의결의 양식 정보 조회 */
			List<Map<String, Object>> formList = new ArrayList<Map<String, Object>>( );
			formList = cmInfo.CommonGetNPFormListInfo( params );
			/* 양식이 존재하는 경우 제일 첫번째 양식의 옵션 표시 */
			if ( formList.get( 0 ) != null ) {
				if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPCON" ) > -1 ) {
					params.put( "formDTp", "CON" );
				}
				else if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPRES" ) > -1 ) {
					params.put( "formDTp", "RES" );
				}
				params.put( "formSeq", formList.get( 0 ).get( "formSeq" ).toString( ) );
			}
			mv.addObject( "aaData", CommonConvert.CommonGetListMapToJsonArray( formList ) );

			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );

			// ResultVO result = new ResultVO( );
			// result.setAaData( configService.NpMasterOptionSelect( params ) );
			// mv.addObject( "result", CommonConvert.CommonGetListMapToJsonArray( result.getAaData( ) ) );
			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPMASTEROPTION );
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
	 * Contents View
	 * [비영리] 지출결의설정 - 기본설정
	 */
	@IncludedInfo ( name = "[비영리/관리자] 양식 별 옵션", order = 4116, gid = 411 )
	@RequestMapping ( "/expend/np/admin/AdminNPFormOption.do" )
	public ModelAndView AdminNPFormOption ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/AdminNPFormOption.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		/* 변수 설정 */
		List<Map<String, Object>> formList = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> optionList = new ArrayList<Map<String, Object>>( );
		String compSeq = CommonConvert.CommonGetEmpVO( ).getCompSeq( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( compSeq );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			params.put( "compSeq", compSeq );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			params.put( "erpType", conVo.getErpTypeCode( ) );
			/* 품의결의 양식 정보 조회 */
			formList = cmInfo.CommonGetNPFormListInfo( params );
			/* 양식이 존재하는 경우 제일 첫번째 양식의 옵션 표시 */
			if ( formList.get( 0 ) != null ) {
				if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPCON" ) > -1 ) {
					params.put( "formDTp", "CON" );
				}
				else if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPRES" ) > -1 ) {
					params.put( "formDTp", "RES" );
				}
				params.put( "formSeq", formList.get( 0 ).get( "formSeq" ).toString( ) );
			}
			/* 항목 옵션 조회 */
			optionList = configService.NpFormOptionSelect( params );
			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPFORMOPTION );
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
		finally {
			mv.addObject( "formList", CommonConvert.CommonGetListMapToJsonArray( formList ) );
			mv.addObject( "optionList", CommonConvert.CommonGetListMapToJsonArray( optionList ) );
		}
		return mv;
	}

//	/* Contents View - 회계 (관리자) - 지출결의 관리 - 매입전자세금계산서 현황 ERPiU */
//	@IncludedInfo ( name = "세금계산서 현황(ERPiU)", order = 4117, gid = 411 )
//	@RequestMapping ( "/expend/np/admin/NPAdminETaxlListERPiU.do" )
//	public ModelAndView ExAdminETaxlListERPiU ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
//		/* Bizbox Alpha */
//		ModelAndView mv = new ModelAndView( );
//		try {
//			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
//				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
//			}
//			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
//				throw new CheckAuthorityException( commonCode.ADMIN );
//			}
//			else if ( CommonConvert.CommonGetEmpInfo( ).get( commonCode.COMPSEQ ).equals( commonCode.EMPTYSEQ ) ) {
//				throw new NotFoundLoginSessionException( "사용자 소속 회사 조회 실패" );
//			}
//			/* 커넥션 설정 확인 */
//			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetEmpInfo( ).get( commonCode.COMPSEQ ).toString( ) );
//			/* 변수정의 */
//			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
//			params.put( commonCode.COMPSEQ, loginVo.getCompSeq( ) );
//			params.put( commonCode.EMPSEQ, loginVo.getUniqId( ) );
//			params.put( "empInfo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetEmpInfo( ) ) );
//			mv.addObject( "ViewBag", params );
//			mv.addObject( "ifUseSystem", conVo.getErpTypeCode( ) );
//			/* View path 정의 [UserCardReport.jsp] */
//			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
//				mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.AdminNPETaxReportERPiU );
//			}
//			else {
//				throw new NotFoundLogicException( commonCode.ERPIU + "전용 메뉴 입니다.", conVo.getErpTypeCode( ) );
//			}
//		}
//		catch ( NotFoundLogicException ex ) {
//			mv.addObject( "errMsg", ex.getMessage( ) );
//			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERP );
//		}
//		catch ( CheckAuthorityException ex ) {
//			mv.addObject( "errMsg", ex.getMessage( ) );
//			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.cmErrorCheckAuth );
//		}
//		catch ( NotFoundLoginSessionException ex ) {
//			mv.addObject( "errMsg", ex.getMessage( ) );
//			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
//		}
//		catch ( Exception ex ) {
//			cmLog.CommonSetError( ex );
//			mv.addObject( "errMsg", ex.getMessage( ) );
//			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
//		}
//		return mv;
//	}

	/**
	 * Contents View
	 * [비영리] 지출결의설정 - 양식설정
	 */
	@IncludedInfo ( name = "[비영리/관리자] 양식설정", order = 4118, gid = 411 )
	@RequestMapping ( "/expend/np/admin/AdminNPFormSetting.do" )
	public ModelAndView AdminNPFormSetting ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/AdminNPFormSetting.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		/* 변수 설정 */
		List<Map<String, Object>> formList = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> optionList = new ArrayList<Map<String, Object>>( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			String compSeq = CommonConvert.CommonGetEmpVO( ).getCompSeq( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( compSeq );
			params.put( "compSeq", compSeq );
			params.put( "erpType", conVo.getErpTypeCode( ) );
			/* 품의결의 양식 정보 조회 */
			formList = cmInfo.CommonGetNPFormListInfo( params );
			/* 양식이 존재하는 경우 제일 첫번째 양식의 옵션 표시 */
			if ( formList.get( 0 ) != null ) {
				if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPCON" ) > -1 ) {
					params.put( "formDTp", "CON" );
				}
				else if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPRES" ) > -1 ) {
					params.put( "formDTp", "RES" );
				}
				params.put( "formSeq", formList.get( 0 ).get( "formSeq" ).toString( ) );
			}
			/* 항목 옵션 조회 */
			optionList = configService.NpFormOptionSelect( params );
			mv.addObject( "aaData", CommonConvert.CommonGetListMapToJsonArray( formList ) );
			mv.addObject( "groupSeq", CommonConvert.CommonGetEmpInfo( ).get( "groupSeq" ) );
			mv.addObject( "optionList", optionList );
			mv.addObject( "erpType", conVo.getErpTypeCode( )  );

			/* 다국어 적용 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
                        String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
                        String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
                        CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
                        mv.addObject( "CL", vo.getData( ) );

			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPFORMSETTING );
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
		finally {
			mv.addObject( "formList", CommonConvert.CommonGetListMapToJsonArray( formList ) );
			mv.addObject( "optionList", CommonConvert.CommonGetListMapToJsonArray( optionList ) );
		}
		return mv;
	}

	/**
	 * Contents View
	 * [비영리] 품의서 반환
	 */
	@IncludedInfo ( name = "[비영리/관리자] 품의서 반환", order = 4119, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminConsConfferReturn.do" )
	public ModelAndView NpAdminConsConfferReturn ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminConsConfferReturn.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);

			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.NPADMINCONSCONFFERRETURN );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}


	/**
	 * Contents View
	 * [비영리/관리자] G20예실대비 현황
	 */
	@IncludedInfo ( name = "[비영리/관리자] G20예실대비 현황", order = 4121, gid = 412 )
	@RequestMapping ( "/expend/np/admin/NpAdminG20Yesil.do" )
	public ModelAndView NpAdminG20Yesil ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminG20Yesil.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - 전자결재 양식 정보 */
			ArrayList<Map<String, Object>> eaFormInfo = (ArrayList<Map<String, Object>>) userServiceOption.selectEaBaseData( params, conVo ).getAaData( );
			mv.addObject( "eaBaseInfo", CommonConvert.CommonGetListMapToJson( eaFormInfo ) );
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			/* 사용자 기본 옵션 조회 - ERP 옵션 정보 조회 */
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			/* 사용자 기본 옵션 조회 - GW 옵션 정보 조회 */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			/* 사용자 기본 옵션 조회 - ERP 기본정보 조회 */
			mv.addObject( "erpBaseInfo", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPBaseData( params, conVo ).getAaData( ) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);

			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPG20YESIL );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}

	/**
	 * Contents View 비영리 세금 계산서 현황<br />
	 * - 2018. 06. 08. 김상겸 수정<br />
	 * > 예외 검증 간소화<br />
	 * > ViewBag 통일
	 */
	@IncludedInfo(name = "세금계산서 현황(ERPiU)", order = 4117, gid = 411)
	@RequestMapping("/expend/np/admin/NpAdminEtaxReport.do")
	public ModelAndView NpAdminEtaxReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpAdminEtaxReport.do] " + params.toString(), "-", "EXNP");

		/* ModelAndView */
		ModelAndView mv = new ModelAndView();

		try {
			/* VO */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(loginVo.getCompSeq()));

			/* Map */
			Map<String, Object> conInfo = new HashMap<String, Object>();

			/* String */
			String pGroupSeq = loginVo.getGroupSeq(), pCompSeq = loginVo.getCompSeq(), pLangCode = loginVo.getLangCode();

			/* [예외 검증] 로그인 세션 확인 */
			CommonException.Login();

			/* [예외 검증] 권한 확인 */
			CommonException.AdminAuth();

			/* [예외 검증] ERP 연동 확인 */
			CommonException.ERP(conVo);

			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			CommonException.iCUBEG20(conVo);

			/* 명칭설정 처리 */
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, pLangCode, pGroupSeq);
			mv.addObject("CL", vo.getData());

			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			params.put("conVo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.ConToMap(conVo)));
			params.put("ifUseSystem", CommonConvert.CommonGetStr(conVo.getErpTypeCode()));
			mv.addObject("ViewBag", params);

			switch (conVo.getErpTypeCode()) {
				case commonCode.ERPIU:
					/* /expend/np/admin/content/AdminNPETaxReportERPiU */
					mv.setViewName(commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPETAXREPORTERPIU);
					break;
				case commonCode.ICUBE:
					/* /expend/np/admin/content/AdminNPETaxReportiCUBE */
					mv.setViewName(commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPETAXREPORTICUBE);
					break;
				default:
					mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH);
					break;
			}
		}
		catch (NotFoundLoginSessionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (CheckErpTypeException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE);
		}
		catch (CheckICUBEG20TypeException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE);
		}
		catch (CheckAuthorityException ex){
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKAUTH);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}
		return mv;
	}

	/**
	 * Contents View
	 * [비영리/관리자] ERPiU 예실대비 현황
	 */
	@IncludedInfo ( name = "[비영리/관리자] ERPiU 예실대비 현황", order = 4123, gid = 412 )
	@RequestMapping ( "/expend/np/admin/NpAdminERPiUYesil.do" )
	public ModelAndView NpAdminERPiUYesil ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminERPiUYesil.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( !CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				throw new CheckErpTypeException( "ERPiU 연동 전용 메뉴 입니다." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}

			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );

			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );

			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );

			/* 사용자 기본 옵션 조회 - ERP 옵션 정보 조회 */
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPOption( params, conVo ).getAaData( ) ) );

			/* 사용자 기본 옵션 조회 - GW 옵션 정보 조회 */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectGWOption( params, conVo ).getAaData( ) ) );

			/* 사용자 기본 옵션 조회 - ERP 기본정보 조회 */
			mv.addObject( "erpBaseInfo", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPBaseData( params, conVo ).getAaData( ) ) );

			mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.ADMINNPERPIUYESIL );
		}
		catch ( NotFoundLoginSessionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN );
		}
		catch ( CheckICUBEG20TypeException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE );
		}
		catch ( NotFoundERPEmpCdException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING );
		}
		catch ( NotFoundConnectionException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERROR );
		}
		return mv;
	}
}