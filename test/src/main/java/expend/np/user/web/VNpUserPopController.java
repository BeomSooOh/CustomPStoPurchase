package expend.np.user.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.CheckDocSettingException;
import common.helper.exception.CheckICUBEG20TypeException;
import common.helper.exception.NotFoundConnectionException;
import common.helper.exception.NotFoundERPEmpCdException;
import common.helper.exception.NotFoundLoginSessionException;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.procedure.npG20.BCommonProcService;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.CommonMapInterface.commonExPath;
import common.vo.common.CommonMapInterface.commonTripPath;
import common.vo.common.ConnectionVO;
import common.vo.common.CustomLabelVO;
import common.vo.common.ResultVO;
import expend.np.user.code.BNpUserCodeService;
import expend.np.user.cons.BNpUserConsService;
import expend.np.user.option.BNpUserOptionService;
import expend.np.user.report.BNpUserReportService;
import expend.np.user.res.BNpUserResService;
import expend.np.user.reuse.BNpUserReUseServiceImpl;
import net.sf.json.JSONArray;


@Controller
public class VNpUserPopController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption; /* Expend Service */
	@Resource ( name = "BNpUserCodeService" )
	private BNpUserCodeService codeService;
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService procService;
	@Resource ( name = "BNpUserConsService" )
	private BNpUserConsService consService; /* ????????? ?????? ?????? */
	@Resource ( name = "BNpUserResService" )
	private BNpUserResService resService; /* ????????? ?????? ?????? */
	@Resource ( name = "BNpUserReportService" )
	private BNpUserReportService reportService;
	@Resource ( name = "BNpUserReUseService" )
	private BNpUserReUseServiceImpl reUseService;


	private Map<String, Object> getPublicLoginVo (LoginVO loginVo){
		Map<String, Object> returnObj = new HashMap<>( );
		if(loginVo == null){
			return returnObj;
		}

		returnObj.put( "bizSeq", loginVo.getBizSeq( ) );
		returnObj.put( "classNm", loginVo.getClassNm( ) );
		returnObj.put( "classCode", loginVo.getClassCode( ) );
		returnObj.put( "authorCode", loginVo.getAuthorCode( ) );
		returnObj.put( "compSeq", loginVo.getCompSeq( ) );
		returnObj.put( "deptSeq", loginVo.getOrganId( ) );
		returnObj.put( "eaType", loginVo.getEaType( ) );
		returnObj.put( "erpCoCd", loginVo.getErpCoCd( ) );
		returnObj.put( "erpEmpCd", loginVo.getErpEmpCd( ) );
		returnObj.put( "groupSeq", loginVo.getGroupSeq( ) );
		returnObj.put( "langCode", loginVo.getLangCode( ) );
		returnObj.put( "name", loginVo.getName( ) );
		returnObj.put( "organId", loginVo.getOrganId( ) );
		returnObj.put( "organNm", loginVo.getOrganNm( ) );
		returnObj.put( "orgnztId", loginVo.getOrgnztId( ) );
		returnObj.put( "orgnztNm", loginVo.getOrgnztNm( ) );
		returnObj.put( "positionCode", loginVo.getPositionCode( ) );
		returnObj.put( "positionNm", loginVo.getPositionNm( ) );
		returnObj.put( "empSeq", loginVo.getUniqId( ) );
		returnObj.put( "uniqId", loginVo.getUniqId( ) );

		return returnObj;
	}

	/**
	 * Pop View
	 * ????????? ??????/????????? ????????? ??????
	 */
	@RequestMapping ( "/expend/np/user/NpUserCRDocPop.do" )
	public ModelAndView NpUserCRDocPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserCRDocPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );

		ResultVO result = null;
		try {
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
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

			/* interface ?????? ???????????? ?????? */
			if (!params.containsKey("outProcessInterfaceId")) { params.put("outProcessInterfaceId", ""); }
			mv.addObject("outProcessInterfaceId", params.get("outProcessInterfaceId"));
			if (!params.containsKey("outProcessInterfaceMId")) { params.put("outProcessInterfaceMId", ""); }
			mv.addObject("outProcessInterfaceMId", params.get("outProcessInterfaceMId"));
			if (!params.containsKey("outProcessInterfaceDId")) { params.put("outProcessInterfaceDId", ""); }
			mv.addObject("outProcessInterfaceDId", params.get("outProcessInterfaceDId"));
			/* ???????????? ????????? */
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "erpCompSeq", conVo.getErpCompSeq( ) );

			/* ?????? ????????? ?????? ?????? ??????
			 * ??????(2???) ????????? ?????? ????????? ?????? ???????????? ?????? ?????? ????????? ??????
			 * */
			ArrayList<Map<String, Object>> eaFormInfo = new ArrayList<>( );
			if( CommonConvert.NullToString( params.get( "EXNPInterlockAPI" ) ).equals( "1" ) ){
				String erpGbn = "";
				if(conVo.getErpTypeCode( ).equals( commonCode.ICUBE )){
					erpGbn = "I";
				}else if(conVo.getErpTypeCode( ).equals( commonCode.ERPIU )){
					erpGbn = "U";
				}else{
					erpGbn = "ETC";
				}

				Map<String, Object> item = new HashMap<>( );
				item.put( "formDTp", "EXNP" +  CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP" ) ) + erpGbn );
				item.put( "formDTp2","EXNP" +  CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP2" ) ) + erpGbn );
				eaFormInfo.add( item );
				params.put( "formDTp", CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP" ) ) + erpGbn );
				params.put( "formDTp2", CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP2" ) ) + erpGbn );
				mv.addObject("EXNPInterlockAPI", "TRIP" + CommonConvert.NullToString( params.get( "EXNPInterlockFormDTP" )  ) );
				mv.addObject( "tripDocSeq", CommonConvert.NullToString( params.get( "tripDocSeq" ) ) );
			}
			else{
				/* ????????? ?????? ?????? ?????? - ???????????? ?????? ?????? */
				eaFormInfo = (ArrayList<Map<String, Object>>) serviceOption.selectEaBaseData( params, conVo ).getAaData( );
			}
			mv.addObject( "eaBaseInfo", CommonConvert.CommonGetListMapToJson( eaFormInfo ) );
			if ( eaFormInfo.get( 0 ) != null ) {
				if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPCON" ) > -1 ) {
					params.put( "formDTp", "CON" );
				}
				else if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "EXNPRES" ) > -1 ) {
					params.put( "formDTp", "RES" );
				}
				if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "TRIPCONS" ) > -1 ) {
					params.put( "formDTp", "TRIPCON" );
				}
				else if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "TRIPRES" ) > -1 ) {
					params.put( "formDTp", "TRIPRES" );
				}
			}

			/* ????????? ?????? ?????? ?????? - ERP ????????? ?????? */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* ???????????? ?????? ?????? */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ????????? ?????? ?????? ?????? - ????????? ?????? ?????? */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			/* ????????? ?????? ?????? ?????? - ERP ?????? ?????? ?????? */
			if(conVo.getErpTypeCode().equals("ERPiU")){
				List<Map<String, Object>> erpOption = new ArrayList<Map<String, Object>>();
				erpOption = serviceOption.selectERPOption( params, conVo ).getAaData( );
				JSONArray jr = new JSONArray();
				for (Map<String, Object> map : erpOption) {
					jr.add(CommonConvert.CommonGetMapToJSONObj(map));
				}
				mv.addObject("erp_optionSet", jr);
			} else {
				mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			}
			/* ????????? ?????? ?????? ?????? - GW ?????? ?????? ?????? */
			ResultVO gwOption = serviceOption.selectGWOption( params, conVo );
			if(!gwOption.getResultCode( ).equals( commonCode.SUCCESS )){
				throw new Exception(gwOption.getResultName( ));
			}
			/* ????????? ?????? ?????? ?????? - GW ???????????? ??????  */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( gwOption.getAaData( ) ) );
			/* ????????? ?????? ?????? ?????? - GW ?????????????????? ??????  */
			mv.addObject( "gw_customOptionSet", CommonConvert.CommonGetMapToJSONStr( gwOption.getaData( ) ) );
			/* ????????? ?????? ?????? ?????? - GW ?????????????????? ?????? ?????? */
			if(!gwOption.getaData( ).isEmpty( )){
				String code = gwOption.getaData( ).get( "commonCode" ).toString( );
				String [] options = code.split( "\\|" );
				for(String option : options){
					if(option.indexOf( "EXNP_CUST_" ) > -1){
						mv.addObject( option, true);
					}
				}
			}

			/* ????????? ?????? ?????? ?????? - ERP ???????????? ?????? */
			mv.addObject( "erpBaseInfo", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPBaseData( params, conVo ).getAaData( ) ) );
			/* ????????? ?????? ?????? ?????? - ERP ???????????? ?????? */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				HashMap<String, Object> procParams = new HashMap<>( );
				DateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
				Calendar cal = Calendar.getInstance( );
				procParams.put( "procType", "absdocuInfo" );
				procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
				mv.addObject( "erpAbsDocu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );
			}
			else {
				mv.addObject( "erpAbsDocu", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
			}
			/* ERP ?????? ?????? ?????? */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE ) ) {
				HashMap<String, Object> procParams = new HashMap<>( );
				DateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
				Calendar cal = Calendar.getInstance( );
				procParams.put( "procType", "commonGisuInfo" );
				procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
				procParams.put( "baseDate", dateFormat.format( cal.getTime( ) ) );
				procParams.put( "erpType", CommonConvert.CommonGetStr(conVo.getErpTypeCode( )) );
				mv.addObject( "erpGisu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );
			}
			else {
				HashMap<String, Object> procParams = new HashMap<>( );
				DateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd" );
				Calendar cal = Calendar.getInstance( );
				procParams.put( "procType", "commonGisuInfo" );
				procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
				procParams.put( "baseDate", dateFormat.format( cal.getTime( ) ) );
				procParams.put( "erpType", CommonConvert.CommonGetStr(conVo.getErpTypeCode( )) );
				mv.addObject( "erpGisu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );
			}
			/* ????????????(????????????) ?????? ??? */
			if ( params.get( "approKey" ) != null ) {
				mv.addObject( "approBefore", "Y" );
				String approKey = params.get( "approKey" ).toString( );
				String formType = CommonConvert.CommonGetStr( approKey.split( "_" )[0] );
				String docSeq = CommonConvert.CommonGetStr( approKey.split( "_" )[2] );
				if ( docSeq == null || docSeq.equals( "" ) ) {
					throw new CheckDocSettingException( "dosSeq??? ?????? ??? ????????????." );
				}
				else {
					if ( formType.equals( "EXNPCONU" ) ) {
						// ????????? ?????? ?????? - ERPiU
						params.put( "consDocSeq", docSeq );
						result = consService.selectConsApprovalBefore( params );
						mv.addObject( "consHeadInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "consHeadInfo" ) ) );
						mv.addObject( "consBudgetInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "budgetInfo" ) ) );
						mv.addObject( "consTradeInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "tradeInfo" ) ) );
					}
					else if ( formType.equals( "EXNPRESU" ) ) {
						// ????????? ?????? ?????? - ERPiU
						params.put( "resDocSeq", docSeq );
						result = resService.selectResApprovalBefore( params );
						mv.addObject( "resHeadInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "resHeadInfo" ) ) );
						mv.addObject( "resBudgetInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "budgetInfo" ) ) );
						mv.addObject( "resTradeInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "tradeInfo" ) ) );
					}
					else if ( formType.equals( "EXNPCONI" ) ) {
						// ????????? ?????? ?????? - iCUBE G20
						try {
							params.put( "consDocSeq", docSeq );
							result = consService.selectConsApprovalBefore( params );
						}
						catch ( Exception ex ) {
							//result =
						}
						mv.addObject( "consDocInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "consDocInfo" ) ) );
						mv.addObject( "consHeadInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "consHeadInfo" ) ) );
						mv.addObject( "consBudgetInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "budgetInfo" ) ) );
						mv.addObject( "consTradeInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "tradeInfo" ) ) );
					}
					else if ( formType.equals( "EXNPRESI" ) ) {
						// ????????? ?????? ?????? - iCUBE G20
						try {
							params.put( "resDocSeq", docSeq );
							result = resService.selectResApprovalBefore( params );
						}
						catch ( Exception ex ) {
							//result =
						}
						mv.addObject( "resDocInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "resDocInfo" ) ) );
						mv.addObject( "resHeadInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "resHeadInfo" ) ) );
						mv.addObject( "resBudgetInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "budgetInfo" ) ) );
						mv.addObject( "resTradeInfo", CommonConvert.CommonGetListMapToJson( (List<Map<String, Object>>) result.getaData( ).get( "tradeInfo" ) ) );
					}
					else {
						mv.addObject( "consHeadInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "consBudgetInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "consTradeInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "resHeadInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "resBudgetInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
						mv.addObject( "resTradeInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
					}
				}
			}
			else {
				mv.addObject( "approBefore", "N" );
				mv.addObject( "consHeadInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "consBudgetInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "consTradeInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "resHeadInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "resBudgetInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
				mv.addObject( "resTradeInfo", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
			}
			/* ??????/?????? ?????? ?????? ?????? */
			String formDTp = eaFormInfo.get( 0 ).get( "formDTp" ).toString( );

			if ( formDTp.equals( "EXNPCONU" ) ) {
				// ????????? ?????? ?????? - ERPiU
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.NUSERCONSPOP );
			}
			else if ( formDTp.equals( "EXNPRESU" ) ) {
				// ????????? ?????? ?????? - ERPiU
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.NUSERRESPOP );
			}
			else if ( formDTp.equals( "EXNPCONI" ) ) {
				// ????????? ?????? ?????? - iCUBE G20
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.NUSERCONSPOP );
			}
			else if ( formDTp.equals( "EXNPRESI" ) ) {
				// ????????? ?????? ?????? - iCUBE G20
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.NUSERRESPOP );
			}
			else if ( formDTp.equals( "TRIPCONS" ) ) {
				// ?????? ????????? ?????? ??????
				mv.setViewName( commonTripPath.TRIPUSERPOPPATH + commonTripPath.TRIPUSERCONSPOP );
			}
			else if ( formDTp.equals( "TRIPRES" ) ) {
				// ?????? ????????? ?????? ??????
				mv.setViewName( commonTripPath.TRIPUSERPOPPATH + commonTripPath.TRIPUSERRESPOP );
			}
			else {
				throw new CheckDocSettingException( "formDTp ?????? ?????? ??? ????????????." );
			}

		}
		catch ( CheckDocSettingException ex ) {
			mv.addObject( "errMsg", ex.getMessage( ) );
			mv.setViewName( commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKDOCSETTING );
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
	 * Pop View
	 * ????????? ?????? ?????? ??????
	 */
	@RequestMapping ( "/expend/np/user/NpCommonCodePop.do" )
	public ModelAndView NpCommonCodePop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpCommonCodePop.do] " + "", "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> sendParam = new LinkedHashMap<String, Object>( );
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			Map<String, Object> tempParam = CommonConvert.CommonGetJSONToMap( params.get( "param" ).toString( ) );
			List<Map<String, Object>> commonCodeData = CommonConvert.CommonGetJSONToListMap( params.get( "data" ).toString( ) );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			sendParam.put( "ERPType", conVo.getErpTypeCode( ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* [?????? ??????] ?????? ?????? ???????????? ?????? */
			if ( tempParam.get( "code" ) == null || tempParam.get( "code" ).toString( ).equals( commonCode.EMPTYSTR ) ) {
				throw new Exception( "?????? ?????? ?????????." );
			}
			else {
				/* ???????????? ?????? ?????? */
				sendParam.put( "code", tempParam.get( "code" ).toString( ) );
			}
			/* ????????? ????????? ????????? ?????? ?????? ?????? ???????????? ?????? */
			sendParam.put( "param", CommonConvert.CommonGetMapToJSONStr( tempParam ) );
			sendParam.put( "data", CommonConvert.CommonGetListMapToJsonArray( commonCodeData ) );
			if ( tempParam.get( "popupType" ) == null || !tempParam.get( "popupType" ).toString( ).equals( "1" ) ) {
				/* ???????????? ?????? ????????? ?????? ????????? ?????? */
				if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "ERPiU" ) ) {
					switch ( tempParam.get( "code" ).toString( ) ) {
						case "tr":
							ResultVO group1 = new ResultVO( );
							ResultVO group2 = new ResultVO( );
							Map<String, Object> trParamMap = new HashMap<String, Object>( );
							trParamMap.put( "code", "TrGroup" );
							trParamMap.put( "param", tempParam.get( "param" ) );
							group1 = codeService.GetCommonCode( trParamMap );
							trParamMap.put( "code", "TrGroup2" );
							group2 = codeService.GetCommonCode( trParamMap );
							sendParam.put( "trGroup", CommonConvert.CommonGetListMapToJson( group1.getAaData( ) ) );
							sendParam.put( "trGroup2", CommonConvert.CommonGetListMapToJson( group2.getAaData( ) ) );
							break;
						default:
							break;
					}
				}
				else if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) ) {
					switch ( tempParam.get( "code" ).toString( ) ) {
						case "budgetlist":
							ResultVO budgetName = new ResultVO( );
							Map<String, Object> trParamMap = new HashMap<String, Object>( );
							trParamMap.put( "code", "budgetName" );
							trParamMap.put( "param", tempParam.get( "param" ) );
							budgetName = codeService.GetCommonCode( trParamMap );
							trParamMap.put( "code", "TrGroup2" );
							sendParam.put( "budgetHeaderName", CommonConvert.CommonGetListMapToJsonArray( budgetName.getAaData( ) ) );
							break;
						case "tr":
							sendParam.put( "trOpt", tempParam.get( "param" ) );
							break;
						default:
							break;
					}
				}
				/* ?????? ?????? ?????? */
				sendParam.put( "callbackFunction", tempParam.get( "callbackFunction" ).toString( ) );
				mv.addObject( "ViewBag", sendParam );
				/* ???????????? ?????? ?????? */
				LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
				String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
				String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
				String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
				CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
				mv.addObject( "CL", vo.getData( ) );
				/* ?????? ?????? ?????? ?????? */
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCOMMONCODEPOP );
			}
			else {
				/* ?????? ?????? ?????? */
				ResultVO result = null;
				result = codeService.GetCommonCode( tempParam );
				mv.setViewName( "jsonView" );
				mv.addObject( "result", result );
			}
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
	 * Pop View
	 * ????????? ???????????? ?????? ??????
	 */
	@RequestMapping ( "/expend/np/user/UserItemSpecPop.do" )
	public ModelAndView UserItemSpecPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserItemSpecPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );

			mv.addObject("params",params);

			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERITEMSPECPOP );
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
	 * Pop View
	 * ????????? ????????? ???????????? ???????????? ?????? ??????
	 */
	@RequestMapping ( "/expend/np/user/UserResFavoritesPop.do" )
	public ModelAndView UserResFavoritesResPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserResFavoritesPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ???????????? ???????????? ?????? ?????? */
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERBRINGFAVORITESRESPOP );
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
	 * Pop View
	 * ????????? ????????? ???????????? ???????????? ?????? ??????
	 */
	@RequestMapping ( "/expend/np/user/UserConsFavoritesPop.do" )
	public ModelAndView UserResFavoritesConsPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserResFavoritesPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* ???????????? ???????????? ?????? ?????? */
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERBRINGFAVORITESCONSPOP );
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
	 * Pop View
	 * ????????? ???????????? ?????? ??????
	 */
	@RequestMapping ( "/expend/np/user/UserConfferPop.do" )
	public ModelAndView UserConfferPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpConfferPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "formSeq", params.get( "formSeq" ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			/* ???????????? ???????????? ?????? ?????? */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCONFFERPOP );
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
	 * Pop View
	 * ?????????????????????????????? ??????
	 */
	@RequestMapping ( "/expend/np/user/CardUseHistoryPop.do" )
	public ModelAndView UserCardHistoryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/CardUseHistoryPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );

			/* ????????? ?????? ?????? ?????? - GW ?????? ?????? ?????? */
			ResultVO gwOption = serviceOption.selectGWOption( params, conVo );
			if(!gwOption.getResultCode( ).equals( commonCode.SUCCESS )){
				throw new Exception(gwOption.getResultName( ));
			}
			/* ????????? ?????? ?????? ?????? - GW ???????????? ??????  */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( gwOption.getAaData( ) ) );

			/* ???????????? ???????????? ?????? ?????? */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCARDHISTORYPOP );
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
	 * Pop View
	 * ????????????????????????????????? ??????
	 */
	@RequestMapping ( "/expend/np/user/ETaxUseHistoryPop.do" )
	public ModelAndView UserETaxHistoryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/ETaxUseHistoryPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			/* ???????????? ???????????? ?????? ?????? */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERETAXHISTORYPOP );
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
	 * Pop View
	 * ???????????????????????? ??????
	 */
	@RequestMapping ( "/expend/np/user/UserCardTransHistoryPop.do" )
	public ModelAndView UserCardTransHistoryPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserCardTransHistoryPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );
			/* ???????????? ???????????? ?????? ?????? */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCARDTRANSHISTORYPOP );
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
	 * Pop View
	 * ???????????? ????????? ???????????? ??????
	 */
	@RequestMapping ( "/expend/np/user/UserCardDetailPop.do" )
	public ModelAndView UserCardDetailPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserCardDetailPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 ??????????????? ?????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );

			/* ???????????? ???????????? ?????? ????????? ?????? */
			ResultVO cardResult = reportService.NPUserCardDetailInfo( params );
			if(cardResult == null){
				throw new Exception("ERP?????? ????????? ???????????? ?????????.");
			}
			if(CommonConvert.CommonGetStr(cardResult.getResultCode( )).equals( commonCode.FAIL )){
				throw new Exception("???????????? ???????????? ?????? ??????");
			}
			mv.addObject( "cardInfo", cardResult.getaData( ) );

			/* ???????????? ???????????? ?????? */
			mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERCARDDETAILPOP );
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
	 * Pop View
	 * ???????????? ????????? ????????? ???????????? ??????
	 */
	@RequestMapping ( "/expend/np/user/UserETaxDetailPop.do" )
	public ModelAndView UserETaxDetailPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/UserETaxDetailPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [?????? ??????] ????????? ?????? ?????? */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "????????? ?????? ?????? ??????" );
			}
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [?????? ??????] ERP ?????? ?????? */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP ?????? ????????? ???????????????." );
			}
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP ?????? ????????? ???????????? ??????." );
			}
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "ERPType", conVo.getErpTypeCode( ) );
			mv.addObject( "ViewBag", CommonConvert.CommonGetMapToJSONObj( params ) );

			/* ???????????? ??????????????? ?????? ????????? ?????? */
			ResultVO eTaxResult = reportService.NPUserETaxDetailInfo( params, conVo );
			if(eTaxResult == null){
				throw new Exception("ERP?????? ????????? ???????????? ?????????.");
			}
			if(CommonConvert.CommonGetStr(eTaxResult.getResultCode( )).equals( commonCode.FAIL )){
				throw new Exception("?????? ?????? ????????? ?????? ?????? ?????? ??????");
			}

			//???????????? ??????????????? ?????? ????????? ?????? ??? ?????? list
			List<Map<String, Object>> eTaxResultList = new ArrayList<>();

			for(int i=0; i < eTaxResult.getAaData().size(); i++) {
				Map<String, Object> resultMap = new HashMap<>();
				Map<String, Object> eTaxMap = eTaxResult.getAaData().get(i);

				Set<String> key = eTaxMap.keySet();
				//Map??? ???????????? ?????? ??? ?????? List??? ??????(????????????, ??????????????? ??????)
				for (Iterator<String> iterator = key.iterator(); iterator.hasNext();) {
					String keyName = CommonConvert.CommonGetStr(iterator.next());
					resultMap.put(keyName, CommonConvert.CommonConvertSpecialCharaterForHTML(CommonConvert.CommonGetStr(eTaxMap.get(keyName))));
				}
				eTaxResultList.add(resultMap);
			}

			mv.addObject( "eTaxInfo", eTaxResult.getaData( ) );
			mv.addObject( "eTaxItemInfo", CommonConvert.CommonGetListMapToJson( eTaxResultList ) );

			/* ERP ????????? ????????? ?????? */
			if(CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ERPIU )){
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERETAXDETAILPOPU );
			}else if(CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( commonCode.ICUBE )){
				mv.setViewName( commonExPath.NPUSERPOPPATH + commonExPath.USERETAXDETAILPOPI );
			}

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

	@RequestMapping("/expend/np/user/NpUserReUsePop.do")
	public ModelAndView NpUserReUsePop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpUserReUsePop.do] " + params.toString(), "-", "EXNP");

		// http://local.duzonnext.com:8080/exp/expend/np/user/NpUserReUsePop.do?oriApproKey=&oriDocId=&form_gb=&formGb=&copyApprovalLine=&copyAttachFile=&formDTp=&consDocSeq=
		// http://local.duzonnext.com:8080/exp/expend/np/user/NpUserReUsePop.do?oriApproKey=&oriDocId=&form_gb=&formGb=&copyApprovalLine=&copyAttachFile=&formDTp=&resDocSeq=
		ModelAndView mv = new ModelAndView();

		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
			/* [?????? ??????] ????????? ?????? ?????? */
			if (CommonConvert.CommonGetEmpInfo() == null) { throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????"); }
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
			/* [?????? ??????] ERP ?????? ?????? */
			if (conVo.getErpCompSeq() == null || conVo.getErpCompSeq().isEmpty()) { throw new NotFoundConnectionException("ERP ?????? ????????? ???????????????."); }
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if (conVo.getErpTypeCode().equals("iCUBE") && conVo.getG20YN().equals("N")) { throw new CheckICUBEG20TypeException("iCUBE G20 ??????????????? ?????????."); }
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if (empInfo.get(commonCode.ERPEMPSEQ) == null || empInfo.get(commonCode.ERPEMPSEQ).toString().isEmpty()) { throw new NotFoundERPEmpCdException("ERP ?????? ????????? ???????????? ??????."); }

			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
			String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
			String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
			mv.addObject("CL", vo.getData());
			mv.addObject("ERPType", conVo.getErpTypeCode());
			mv.addObject("ViewBag", CommonConvert.CommonGetMapToJSONObj(params));
			mv.addObject("EmpInfo", CommonConvert.CommonGetEmpInfo());

			ResultVO p = new ResultVO();
			params.put("eaType", CommonConvert.CommonGetEmpVO().getEaType());
			p.setParams(params);
			mv.addObject("OriFormInfo", reUseService.ConsReUseFormInfoSelect(p).getaData());

			// View ??????
			ResultVO r = new ResultVO();
			switch (CommonConvert.CommonGetStr(params.get("formDTp"))) {
				case "EXNPCONI":
				case "EXNPCONU":
					mv.setViewName(commonExPath.NPUSERPOPPATH + commonExPath.USERCONSREUSEPOP);

					r = new ResultVO();
					r.setParams(params);
					r = reUseService.ConsReUseGisuSelect(r);
					mv.addObject("ConsGisu", r.getaData());
					break;
				case "EXNPRESI":
				case "EXNPRESU":
					mv.setViewName(commonExPath.NPUSERPOPPATH + commonExPath.USERRESREUSEPOP);

					r = new ResultVO();
					r.setParams(params);
					r = reUseService.ResReUseGisuSelect(r);
					mv.addObject("ResGisu", r.getaData());
					break;
				default:
					mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
					break;
			}
		}
		catch (NotFoundLoginSessionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (CheckICUBEG20TypeException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE);
		}
		catch (NotFoundERPEmpCdException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING);
		}
		catch (NotFoundConnectionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}

		return mv;
	}

	/**
	 * Pop View ??????????????? ???????????? ??????
	 */
	@RequestMapping("/expend/np/user/UserETaxTransHistoryPop.do")
	public ModelAndView UserETaxTransHistoryPop(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {
		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/UserETaxTransHistoryPop.do] " + params.toString(), "-", "EXNP");
		ModelAndView mv = new ModelAndView();
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo();
			/* [?????? ??????] ????????? ?????? ?????? */
			if (CommonConvert.CommonGetEmpInfo() == null) { throw new NotFoundLoginSessionException("????????? ?????? ?????? ??????"); }
			/* [?????? ??????] ERP ???????????? ?????? */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo(CommonConvert.CommonGetStr(empInfo.get(commonCode.COMPSEQ)));
			/* [?????? ??????] ERP ?????? ?????? */
			if (conVo.getErpCompSeq() == null || conVo.getErpCompSeq().isEmpty()) { throw new NotFoundConnectionException("ERP ?????? ????????? ???????????????."); }
			/* [?????? ??????] ERP ?????? ?????? / iCUBE G20 */
			if (conVo.getErpTypeCode().equals("iCUBE") && conVo.getG20YN().equals("N")) { throw new CheckICUBEG20TypeException("iCUBE G20 ??????????????? ?????????."); }
			/* [?????? ??????] ERP ?????? ?????? ?????? */
			if (empInfo.get(commonCode.ERPEMPSEQ) == null || empInfo.get(commonCode.ERPEMPSEQ).toString().isEmpty()) { throw new NotFoundERPEmpCdException("ERP ?????? ????????? ???????????? ??????."); }
			/* ???????????? ?????? ?????? */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO();
			String pCompSeq = CommonConvert.CommonGetStr(loginVo.getCompSeq());
			String plangCode = CommonConvert.CommonGetStr(loginVo.getLangCode());
			String pGroupSeq = CommonConvert.CommonGetStr(loginVo.getGroupSeq());
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo(pCompSeq, plangCode, pGroupSeq);
			mv.addObject("CL", vo.getData());
			mv.addObject("ERPType", conVo.getErpTypeCode());
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", CommonConvert.CommonGetMapToJSONObj(params));
			/* ???????????? ???????????? ?????? ?????? */
			mv.setViewName(commonExPath.NPUSERPOPPATH + commonExPath.USERETAXTRANSHISTORYPOP);
		}
		catch (NotFoundLoginSessionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKLOGIN);
		}
		catch (CheckICUBEG20TypeException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKICUBEG20TYPE);
		}
		catch (NotFoundERPEmpCdException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPEMPCDMAPPING);
		}
		catch (NotFoundConnectionException ex) {
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERRORCHECKERPSETTING);
		}
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}
		return mv;
	}
}