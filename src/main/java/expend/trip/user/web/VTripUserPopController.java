package expend.trip.user.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
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
import expend.np.user.option.BNpUserOptionService;
import net.sf.json.JSONArray;


@Controller
public class VTripUserPopController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption; /* Expend Service */
	@Resource ( name = "BCommonProcService" )
	private BCommonProcService procService;

	private Map<String, Object> getPublicLoginVo ( LoginVO loginVo ) {
		Map<String, Object> returnObj = new HashMap<>( );
		if ( loginVo == null ) {
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
	 * Contents View
	 * 출장복명 출장 품의/결의 테스트
	 */
	@RequestMapping ( "/expend/trip/user/TripUserCRDocPop.do" )
	public ModelAndView TripUserCRDocPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/user/TripUserCRDocPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
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

			/* interface 연동 파라미터 확인 */
			if (!params.containsKey("outProcessInterfaceId")) { params.put("outProcessInterfaceId", ""); }
			mv.addObject("outProcessInterfaceId", params.get("outProcessInterfaceId"));
			if (!params.containsKey("outProcessInterfaceMId")) { params.put("outProcessInterfaceMId", ""); }
			mv.addObject("outProcessInterfaceMId", params.get("outProcessInterfaceMId"));
			if (!params.containsKey("outProcessInterfaceDId")) { params.put("outProcessInterfaceDId", ""); }
			mv.addObject("outProcessInterfaceDId", params.get("outProcessInterfaceDId"));
			/* 파라미터 재정의 */
			params.put( "compSeq", loginVo.getCompSeq( ) );
			params.put( "erpCompSeq", conVo.getErpCompSeq( ) );
			/* 파라미터 재정의 */
			params.put( "compSeq", loginVo.getCompSeq( ) );
			/* 옵션 세트 지정 */
			mv = setOptionSet( loginVo, conVo, mv, params );


			/* 사용자 기본 옵션 조회 - 전자결재 양식 정보 */
			ArrayList<Map<String, Object>> eaFormInfo = new ArrayList<>( );
			eaFormInfo = (ArrayList<Map<String, Object>>) serviceOption.selectEaBaseData( params, conVo ).getAaData( );
			mv.addObject( "eaBaseInfo", CommonConvert.CommonGetListMapToJson( eaFormInfo ) );
			String formDTp = "";
			if ( eaFormInfo.get( 0 ) != null ) {
				if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "TRIPCON" ) > -1 ) {
					params.put( "formDTp", "TRIPCON" );
					formDTp = "TRIPCON";
				}
				else if ( eaFormInfo.get( 0 ).get( "formDTp" ).toString( ).indexOf( "TRIPRES" ) > -1 ) {
					params.put( "formDTp", "TRIPRES" );
					formDTp = "TRIPRES";
				}
			}
			if ( formDTp.equals( "TRIPCON" ) ) {
				mv.setViewName( commonTripPath.TRIPUSERPOPPATH + commonTripPath.TRIPUSERCONSPOP );
			}
			else {
				mv.setViewName( commonTripPath.TRIPUSERPOPPATH + commonTripPath.TRIPUSERRESPOP );
			}

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
	 * 출장복명 참조품의 가져오기
	 */
	@RequestMapping ( "/expend/trip/user/TripUserConnfferPop.do" )
	public ModelAndView TripUserConnfferPop ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/trip/user/TripUserConnfferPop.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
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
			mv.setViewName( commonTripPath.TRIPUSERPOPPATH + commonTripPath.TRIPUSERCONFFERPOP );
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

	private ModelAndView setOptionSet ( LoginVO loginVo, ConnectionVO conVo, ModelAndView mv, Map<String, Object> params ) {
		if ( (loginVo == null) || (conVo == null) ) {
			return mv.addObject( "optionResult", commonCode.FAIL );
		}
		try {
			/* 사용자 기본 옵션 조회 - 전자결재 양식 정보 */
			ArrayList<Map<String, Object>> eaFormInfo = (ArrayList<Map<String, Object>>) serviceOption.selectEaBaseData( params, conVo ).getAaData( );
			mv.addObject( "eaBaseInfo", CommonConvert.CommonGetListMapToJson( eaFormInfo ) );
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 명칭설정 기능 정의 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo( loginVo ) ) );
			/* 사용자 기본 옵션 조회 - ERP 옵션 정보 조회 */
			if ( conVo.getErpTypeCode( ).equals( "ERPiU" ) ) {
				List<Map<String, Object>> erpOption = new ArrayList<Map<String, Object>>( );
				erpOption = serviceOption.selectERPOption( params, conVo ).getAaData( );
				JSONArray jr = new JSONArray( );
				for ( Map<String, Object> map : erpOption ) {
					jr.add( CommonConvert.CommonGetMapToJSONObj( map ) );
				}
				mv.addObject( "erp_optionSet", jr );
			}
			else {
				mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			}
			/* 사용자 기본 옵션 조회 - GW 옵션 정보 조회 */
			ResultVO gwOption = serviceOption.selectGWOption( params, conVo );
			if ( !gwOption.getResultCode( ).equals( commonCode.SUCCESS ) ) {
				throw new Exception( gwOption.getResultName( ) );
			}
			/* 사용자 기본 옵션 조회 - GW 기본설정 정보 */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( gwOption.getAaData( ) ) );
			/* 사용자 기본 옵션 조회 - GW 커스터마이징 정보 */
			mv.addObject( "gw_customOptionSet", CommonConvert.CommonGetMapToJSONStr( gwOption.getaData( ) ) );
			/* 사용자 기본 옵션 조회 - GW 커스터마이징 코드 등록 */
			if ( !gwOption.getaData( ).isEmpty( ) ) {
				String code = gwOption.getaData( ).get( "commonCode" ).toString( );
				String[] options = code.split( "\\|" );
				for ( String option : options ) {
					if ( option.indexOf( "EXNP_CUST_" ) > -1 ) {
						mv.addObject( option, true );
					}
				}
			}
			/* 사용자 기본 옵션 조회 - ERP 기본정보 조회 */
			mv.addObject( "erpBaseInfo", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPBaseData( params, conVo ).getAaData( ) ) );
			/* 결의서 기본 옵션 조회 - ERP 기본정보 조회 */
			if ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ).equals( commonCode.ICUBE ) ) {
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
			/* ERP 기수 정보 조회 */
			if ( CommonConvert.CommonGetStr( conVo.getErpTypeCode( ) ).equals( commonCode.ICUBE ) ) {
				HashMap<String, Object> procParams = new HashMap<>( );
				DateFormat dateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault() );
				Calendar cal = Calendar.getInstance( );
				procParams.put( "procType", "commonGisuInfo" );
				procParams.put( "erpCompSeq", loginVo.getErpCoCd( ) );
				procParams.put( "baseDate", dateFormat.format( cal.getTime( ) ) );
				mv.addObject( "erpGisu", CommonConvert.CommonGetListMapToJson( procService.getProcResult( procParams ).getAaData( ) ) );
			}
			else {
				mv.addObject( "erpGisu", CommonConvert.CommonGetListMapToJson( new ArrayList( ) ) );
			}
			mv.addObject( "optionResult", commonCode.SUCCESS );
		}
		catch ( Exception ex ) {
			cmLog.CommonSetError( ex );
			mv.addObject( "optionResult", commonCode.FAIL );
		}
		return mv;
	}
}