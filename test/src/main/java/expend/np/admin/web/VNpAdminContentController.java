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
	 * ????????? ?????? ??????
	 * [?????????] ?????? ?????? ?????????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ???????????? ????????????", order = 4100, gid = 410 )
	@RequestMapping ( "/expend/np/admin/NpAdminOptionSettingPage.do" )
	public ModelAndView NpUserCodeTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminOptionSettingPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ????????? ?????? */
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
	 * ????????? ???????????? ??????
	 * [?????????] ???????????? ?????? - ???????????? ??????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ???????????? ??????", order = 4110, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpApprovalSendList.do" )
	public ModelAndView NpApprovalSendList ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpApprovalSendList.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ????????? ?????? ?????? ?????? - ???????????? ?????? ?????? */
			ArrayList<Map<String, Object>> eaFormInfo = (ArrayList<Map<String, Object>>) userServiceOption.selectEaBaseData( params, conVo ).getAaData( );
			mv.addObject( "eaBaseInfo", CommonConvert.CommonGetListMapToJson( eaFormInfo ) );
			/* ????????? ?????? ?????? ?????? - ERP ????????? ?????? */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			/* ????????? ?????? ?????? ?????? - ERP ?????? ?????? ?????? */
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			/* ????????? ?????? ?????? ?????? - GW ?????? ?????? ?????? */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			/* ????????? ?????? ?????? ?????? - ERP ???????????? ?????? */
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
	 * ????????? ???????????? ??????
	 * [?????????] ???????????? ??????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ??????????????????", order = 4111, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminCardReport.do" )
	public ModelAndView NpAdminCardReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminCardReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* ???????????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ????????? ?????? ?????? ?????? - ERP ????????? ?????? */
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
			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
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
	 * [?????????] ????????? ??????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ????????? ??????", order = 4112, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminConsReport.do" )
	public ModelAndView NpAdminConsReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminConsReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* ???????????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ????????? ?????? ?????? ?????? - ERP ????????? ?????? */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
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
	 * [?????????] ????????? ??????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ????????? ??????", order = 4113, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminResReport.do" )
	public ModelAndView NpAdminResReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminResReport.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* ???????????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ????????? ?????? ?????? ?????? - ERP ????????? ?????? */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
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
	 * [?????????] ?????????????????? - ????????????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ???????????? ????????????", order = 4115, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminMasterOption.do" )
	public ModelAndView NpAdminMasterOption ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminMasterOption.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}

			/* ???????????? ?????? ?????? */
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

			/* ???????????? ?????? ?????? ?????? */
			List<Map<String, Object>> formList = new ArrayList<Map<String, Object>>( );
			formList = cmInfo.CommonGetNPFormListInfo( params );
			/* ????????? ???????????? ?????? ?????? ????????? ????????? ?????? ?????? */
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
	 * [?????????] ?????????????????? - ????????????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ?????? ??? ??????", order = 4116, gid = 411 )
	@RequestMapping ( "/expend/np/admin/AdminNPFormOption.do" )
	public ModelAndView AdminNPFormOption ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/AdminNPFormOption.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		/* ?????? ?????? */
		List<Map<String, Object>> formList = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> optionList = new ArrayList<Map<String, Object>>( );
		String compSeq = CommonConvert.CommonGetEmpVO( ).getCompSeq( );
		ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( compSeq );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			params.put( "compSeq", compSeq );
			params.put( "empSeq", CommonConvert.CommonGetEmpVO( ).getUniqId( ) );
			params.put( "erpType", conVo.getErpTypeCode( ) );
			/* ???????????? ?????? ?????? ?????? */
			formList = cmInfo.CommonGetNPFormListInfo( params );
			/* ????????? ???????????? ?????? ?????? ????????? ????????? ?????? ?????? */
			if ( formList.get( 0 ) != null ) {
				if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPCON" ) > -1 ) {
					params.put( "formDTp", "CON" );
				}
				else if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPRES" ) > -1 ) {
					params.put( "formDTp", "RES" );
				}
				params.put( "formSeq", formList.get( 0 ).get( "formSeq" ).toString( ) );
			}
			/* ?????? ?????? ?????? */
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

//	/* Contents View - ?????? (?????????) - ???????????? ?????? - ??????????????????????????? ?????? ERPiU */
//	@IncludedInfo ( name = "??????????????? ??????(ERPiU)", order = 4117, gid = 411 )
//	@RequestMapping ( "/expend/np/admin/NPAdminETaxlListERPiU.do" )
//	public ModelAndView ExAdminETaxlListERPiU ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
//		/* Bizbox Alpha */
//		ModelAndView mv = new ModelAndView( );
//		try {
//			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
//				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
//			}
//			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
//				throw new CheckAuthorityException( commonCode.ADMIN );
//			}
//			else if ( CommonConvert.CommonGetEmpInfo( ).get( commonCode.COMPSEQ ).equals( commonCode.EMPTYSEQ ) ) {
//				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ?????? ??????" );
//			}
//			/* ????????? ?????? ?????? */
//			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetEmpInfo( ).get( commonCode.COMPSEQ ).toString( ) );
//			/* ???????????? */
//			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
//			params.put( commonCode.COMPSEQ, loginVo.getCompSeq( ) );
//			params.put( commonCode.EMPSEQ, loginVo.getUniqId( ) );
//			params.put( "empInfo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetEmpInfo( ) ) );
//			mv.addObject( "ViewBag", params );
//			mv.addObject( "ifUseSystem", conVo.getErpTypeCode( ) );
//			/* View path ?????? [UserCardReport.jsp] */
//			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
//				mv.setViewName( commonExPath.NPADMINCONTENTPATH + commonExPath.AdminNPETaxReportERPiU );
//			}
//			else {
//				throw new NotFoundLogicException( commonCode.ERPIU + "?????? ?????? ?????????.", conVo.getErpTypeCode( ) );
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
	 * [?????????] ?????????????????? - ????????????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ????????????", order = 4118, gid = 411 )
	@RequestMapping ( "/expend/np/admin/AdminNPFormSetting.do" )
	public ModelAndView AdminNPFormSetting ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/AdminNPFormSetting.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		/* ?????? ?????? */
		List<Map<String, Object>> formList = new ArrayList<Map<String, Object>>( );
		List<Map<String, Object>> optionList = new ArrayList<Map<String, Object>>( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			String compSeq = CommonConvert.CommonGetEmpVO( ).getCompSeq( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( compSeq );
			params.put( "compSeq", compSeq );
			params.put( "erpType", conVo.getErpTypeCode( ) );
			/* ???????????? ?????? ?????? ?????? */
			formList = cmInfo.CommonGetNPFormListInfo( params );
			/* ????????? ???????????? ?????? ?????? ????????? ????????? ?????? ?????? */
			if ( formList.get( 0 ) != null ) {
				if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPCON" ) > -1 ) {
					params.put( "formDTp", "CON" );
				}
				else if ( formList.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPRES" ) > -1 ) {
					params.put( "formDTp", "RES" );
				}
				params.put( "formSeq", formList.get( 0 ).get( "formSeq" ).toString( ) );
			}
			/* ?????? ?????? ?????? */
			optionList = configService.NpFormOptionSelect( params );
			mv.addObject( "aaData", CommonConvert.CommonGetListMapToJsonArray( formList ) );
			mv.addObject( "groupSeq", CommonConvert.CommonGetEmpInfo( ).get( "groupSeq" ) );
			mv.addObject( "optionList", optionList );
			mv.addObject( "erpType", conVo.getErpTypeCode( )  );

			/* ????????? ?????? */
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
	 * [?????????] ????????? ??????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ????????? ??????", order = 4119, gid = 411 )
	@RequestMapping ( "/expend/np/admin/NpAdminConsConfferReturn.do" )
	public ModelAndView NpAdminConsConfferReturn ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminConsConfferReturn.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* ???????????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ????????? ?????? ?????? ?????? - ERP ????????? ?????? */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
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
	 * [?????????/?????????] G20???????????? ??????
	 */
	@IncludedInfo ( name = "[?????????/?????????] G20???????????? ??????", order = 4121, gid = 412 )
	@RequestMapping ( "/expend/np/admin/NpAdminG20Yesil.do" )
	public ModelAndView NpAdminG20Yesil ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminG20Yesil.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ????????? ?????? ?????? ?????? - ???????????? ?????? ?????? */
			ArrayList<Map<String, Object>> eaFormInfo = (ArrayList<Map<String, Object>>) userServiceOption.selectEaBaseData( params, conVo ).getAaData( );
			mv.addObject( "eaBaseInfo", CommonConvert.CommonGetListMapToJson( eaFormInfo ) );
			/* ????????? ?????? ?????? ?????? - ERP ????????? ?????? */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			/* ????????? ?????? ?????? ?????? - ERP ?????? ?????? ?????? */
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			/* ????????? ?????? ?????? ?????? - GW ?????? ?????? ?????? */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			/* ????????? ?????? ?????? ?????? - ERP ???????????? ?????? */
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
	 * Contents View ????????? ?????? ????????? ??????<br />
	 * - 2018. 06. 08. ????????? ??????<br />
	 * > ?????? ?????? ?????????<br />
	 * > ViewBag ??????
	 */
	@IncludedInfo(name = "??????????????? ??????(ERPiU)", order = 4117, gid = 411)
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

			/* [?????? ??????] ????????? ?????? ?????? */
			CommonException.Login();

			/* [?????? ??????] ?????? ?????? */
			CommonException.AdminAuth();

			/* [?????? ??????] ERP ?????? ?????? */
			CommonException.ERP(conVo);

			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			CommonException.iCUBEG20(conVo);

			/* ???????????? ?????? */
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, pLangCode, pGroupSeq);
			mv.addObject("CL", vo.getData());

			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
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
	 * [?????????/?????????] ERPiU ???????????? ??????
	 */
	@IncludedInfo ( name = "[?????????/?????????] ERPiU ???????????? ??????", order = 4123, gid = 412 )
	@RequestMapping ( "/expend/np/admin/NpAdminERPiUYesil.do" )
	public ModelAndView NpAdminERPiUYesil ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpAdminERPiUYesil.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			else if ( !CommonConvert.CommonGetEmpInfo( ).get( "userSe" ).equals( commonCode.ADMIN ) ) {
				throw new CheckAuthorityException( commonCode.ADMIN );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( loginVo.getCompSeq( ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( !CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU ) ) {
				throw new CheckErpTypeException( "ERPiU ?????? ?????? ?????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( loginVo.getErpEmpCd( ) == null || loginVo.getErpEmpCd( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}

			/* ???????????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );

			/* ????????? ?????? ?????? ?????? - ERP ????????? ?????? */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );

			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );

			/* ????????? ?????? ?????? ?????? - ERP ?????? ?????? ?????? */
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectERPOption( params, conVo ).getAaData( ) ) );

			/* ????????? ?????? ?????? ?????? - GW ?????? ?????? ?????? */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( userServiceOption.selectGWOption( params, conVo ).getAaData( ) ) );

			/* ????????? ?????? ?????? ?????? - ERP ???????????? ?????? */
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