package expend.np.user.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.convert.CommonException;
//import common.helper.exception.CheckAuthorityException;
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
import egovframework.com.cmm.annotation.IncludedInfo;
import expend.np.user.option.BNpUserOptionService;


@Controller
public class VNpUserContentController {

	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo;
	@Resource ( name = "CommonLogger" )
	private final CommonLogger cmLog = new CommonLogger( );
	@Resource ( name = "BNpUserOptionService" )
	private BNpUserOptionService serviceOption; /* Expend Service */

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
	 * Contents View
	 * 비영리 API TEST
	 * [비영리] API TEST PAGE
	 */
	@IncludedInfo ( name = "[비영리] API 테스트 페이지 / 미배포", order = 3100, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserAPITestPage.do" )
	public ModelAndView NpUserAPITestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserAPITestPage.do] " + params.toString( ), "-", "EXNP" );
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
			/* 파라미터 재정의 */
			params.put( "compSeq", loginVo.getCompSeq( ) );
			/* 명칭설정 기능 정의 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 */
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( conVo ) ) );
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			/** TODO : */
			/* VIEW 경로 정의 */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERAPITESTPAGE );
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
	 * 비영리 품의/결의서 테스트 페이지
	 */
	@IncludedInfo ( name = "[비영리] 품의/결의 테스트 페이지 / 미배포", order = 3101, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserPopTestPage.do" )
	public ModelAndView NpUserPopTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserPopTestPage.do] " + params.toString( ), "-", "EXNP" );
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
			/* 파라미터 재정의 */
			params.put( "compSeq", loginVo.getCompSeq( ) );
			/* 명칭설정 기능 정의 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 */
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( conVo ) ) );
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			/** TODO : */
			/* VIEW 경로 정의 */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERCONSRESTESTPAGE );
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
	 * 비영리 코드/상태
	 * [비영리] GW 기본설정 확인
	 */
	@IncludedInfo ( name = "[비영리] GW 기본설정 확인 / 미배포", order = 3102, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserUserStatTestPage.do" )
	public ModelAndView NpUserUserStatTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserUserStatTestPage.do] " + params.toString( ), "-", "EXNP" );
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
			/** 파라미터 재정의 */
			params.put( "compSeq", loginVo.getCompSeq( ) );
			/* 명칭설정 기능 정의 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/** MV 결과 반환 준비 : */
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( conVo ) ) );
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			/* View path 정의 [UserCmmCodePopTestPage.jsp] */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERSTATTASTPAGE );
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
	 * 비영리 코드/상태
	 * [비영리] 공통 코드 테스트 페이지
	 */
	@IncludedInfo ( name = "[비영리] 코드 테스트 페이지 / 미배포", order = 3103, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserUserCodeTestPage.do" )
	public ModelAndView NpUserCodeTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserUserCodeTestPage.do] " + params.toString( ), "-", "EXNP" );
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
			/* 명칭설정 기능 정의 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/*** TODO : */
			/* View path 정의 [UserCmmCodePopTestPage.jsp] */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERCODETESTPAGE );
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

	@IncludedInfo ( name = "[비영리] 공통코드 테스트 페이지 / 미배포", order = 3104, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserCodePopTestPage.do" )
	public ModelAndView NpUserCodePopTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserCodePopTestPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 처리 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/*** TODO : */
			/* View path 정의 [UserCmmCodePopTestPage.jsp] */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERCODEPOPTESTPAGE );
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

	@IncludedInfo ( name = "[비영리] 예산잔액 테스트 페이지 / 미배포", order = 3106, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserBudgetBalanceTestPage.do" )
	public ModelAndView NpUserBudgetBalanceTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserCodePopTestPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 처리 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/*** TODO : */
			/* View path 정의 [UserCmmCodePopTestPage.jsp] */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERBUDGETBALANCETESTPAGE );
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

	@IncludedInfo ( name = "[비영리] 프로시저 테스트 메뉴 / 미배포", order = 3107, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserProcedureTestPage.do" )
	public ModelAndView NpUserProcedureTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserCodePopTestPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 처리 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/*** TODO : */
			/* View path 정의 [UserCmmCodePopTestPage.jsp] */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERPROCEDURETESTPAGE );
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

	
	@IncludedInfo ( name = "[비영리] 결재문서 - 법인카드 사용내역 상세정보 팝업 테스트 / 미배포", order = 3108, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserCardDetailPopTestPage.do" )
	public ModelAndView NpUserCardDetailPopTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserCardDetailPopTestPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 처리 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/*** TODO : */
			/* View path 정의 [UserCmmCodePopTestPage.jsp] */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERCARDDETAILPOPTESTPAGE );
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
	
	@IncludedInfo ( name = "[비영리] 결재문서 - 매입전자 세금계산서 사용내역 상세정보 팝업 테스트 / 미배포", order = 3109, gid = 310 )
	@RequestMapping ( "/expend/np/user/NpUserETaxDetailPopTestPage.do" )
	public ModelAndView NpUserETaxDetailPopTestPage ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserETaxDetailPopTestPage.do] " + params.toString( ), "-", "EXNP" );
		ModelAndView mv = new ModelAndView( );
		
		try {
			Map<String, Object> empInfo = CommonConvert.CommonGetEmpInfo( );
			/* [예외 검증] 로그인 세션 확인 */
			if ( CommonConvert.CommonGetEmpInfo( ) == null ) {
				throw new NotFoundLoginSessionException( "로그인 세션 검색 실패" );
			}
			/* [예외 검증] ERP 연결정보 조회 */
			ConnectionVO conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( empInfo.get( commonCode.COMPSEQ ) ) );
			/* [예외 검증] ERP 연동 확인 */
			if ( conVo.getErpCompSeq( ) == null || conVo.getErpCompSeq( ).isEmpty( ) ) {
				throw new NotFoundConnectionException( "ERP 연동 설정을 확인하세요." );
			}
			/* [예외 검증] ERP 타입 확인 / iCUBE G20 */
			if ( CommonConvert.CommonGetStr(conVo.getErpTypeCode( )).equals( "iCUBE" ) && conVo.getG20YN( ).equals( "N" ) ) {
				throw new CheckICUBEG20TypeException( "iCUBE G20 설정확인이 필요함." );
			}
			/* [예외 검증] ERP 사번 매핑 확인 */
			if ( empInfo.get( commonCode.ERPEMPSEQ ) == null || empInfo.get( commonCode.ERPEMPSEQ ).toString( ).isEmpty( ) ) {
				throw new NotFoundERPEmpCdException( "ERP 사번 매핑이 진행되지 않음." );
			}
			/* 명칭설정 처리 */
			LoginVO loginVo = CommonConvert.CommonGetEmpVO( );
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/*** TODO : */
			/* View path 정의 [UserCmmCodePopTestPage.jsp] */
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERETAXDETAILPOPTESTPAGE );
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
	@IncludedInfo ( name = "[비영리/사용자] 카드사용현황", order = 4005, gid = 400 )
	@RequestMapping ( "/expend/np/user/NpUserCardReport.do" )
	public ModelAndView NpUserCardReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserCardReport.do] " + params.toString( ), "-", "EXNP" );
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
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERNPCARDREPORT );
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
	 * 비영리 품의서 현황
	 */
	@IncludedInfo ( name = "[비영리/사용자] 품의서 현황", order = 4001, gid = 400 )
	@RequestMapping ( "/expend/np/user/NpUserConsUserReport.do" )
	public ModelAndView NpUserConsUserReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserConsUserReport.do] " + params.toString( ), "-", "EXNP" );
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
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERNPCONSREPORT );
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
	 * 비영리 결의서 현황
	 */
	@IncludedInfo ( name = "[비영리/사용자] 결의서 현황", order = 4002, gid = 400 )
	@RequestMapping ( "/expend/np/user/NpUserResUserReport.do" )
	public ModelAndView NpUserResUserReport ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserResUserReport.do] " + params.toString( ), "-", "EXNP" );
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
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERNPRESREPORT );
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
	 * Contents View 비영리 세금 계산서 현황<br />
	 * - 2018. 06. 08. 김상겸 수정<br />
	 * > 예외 검증 간소화<br />
	 * > ViewBag 통일
	 */
	@IncludedInfo(name = "[비영리/사용자] 나의 세금계산서 현황", order = 4003, gid = 400)
	@RequestMapping("/expend/np/user/NpUserEtaxReport.do")
	public ModelAndView NpUserEtaxReport(@RequestParam Map<String, Object> params, HttpServletRequest request) throws Exception {

		cmLog.CommonSetInfoToDatabase("[ #EXNP# @Controller-/expend/np/user/NpUserEtaxReport.do] " + params.toString(), "-", "EXNP");

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
					/* /expend/np/user/content/UserNPETaxReportERPiU */
					mv.setViewName(commonExPath.NPUSERCONTENTPATH + commonExPath.USERNPETAXREPORTERPIU);
					break;
				case commonCode.ICUBE:
					/* /expend/np/user/content/UserNPETaxReportiCUBE */
					mv.setViewName(commonExPath.NPUSERCONTENTPATH + commonExPath.USERNPETAXREPORTICUBE);
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
		catch (Exception ex) {
			cmLog.CommonSetError(ex);
			mv.addObject("errMsg", ex.getMessage());
			mv.setViewName(commonExPath.ERRORPAGEPATH + commonExPath.CMERROR);
		}
		return mv;
	}

	/**
	 * Contents View
	 * 비영리 품의서 반환
	 */
	@IncludedInfo ( name = "[비영리/사용자] 품의서 반환", order = 4004, gid = 400 )
	@RequestMapping ( "/expend/np/user/NpUserConsConfferReturn.do" )
	public ModelAndView NpUserConsConfferReturn ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/user/NpUserConsConfferReturn.do] " + params.toString( ), "-", "EXNP" );
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
			/* 사용자 기본 옵션 조회 - ERP 커넥션 정보 */
			Map<String, Object> conInfoTemp = CommonConvert.CommonGetObjectToMap( conVo );
			Map<String, Object> conInfo = new HashMap<>( );
			conInfo.put( "erpCompName", conInfoTemp.get( "erpCompName" ).toString( ) );
			conInfo.put( "erpCompSeq", conInfoTemp.get( "erpCompSeq" ).toString( ) );
			conInfo.put( "erpTypeCode", conInfoTemp.get( "erpTypeCode" ).toString( ) );
			conInfo.put( "g20YN", conInfoTemp.get( "g20YN" ).toString( ) );
			mv.addObject( "conVo", CommonConvert.CommonGetMapToJSONObj( conInfo ) );
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
			mv.addObject( "erpInfo",  conInfo );
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( getPublicLoginVo(loginVo) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERNPCONSCONFFERRETURN );
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
	 * [비영리/사용자] G20예실대비 현황
	 */
	@IncludedInfo ( name = "[비영리/사용자] 나의G20예실대비 현황", order = 4122, gid = 412 )
	@RequestMapping ( "/expend/np/user/NpUserG20Yesil.do" )
	public ModelAndView NpUserG20Yesil ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpApprovalSendList.do] " + params.toString( ), "-", "EXNP" );
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
			/* 명칭설정 처리 */
			String pCompSeq = CommonConvert.CommonGetStr( loginVo.getCompSeq( ) );
			String plangCode = CommonConvert.CommonGetStr( loginVo.getLangCode( ) );
			String pGroupSeq = CommonConvert.CommonGetStr( loginVo.getGroupSeq( ) );
			CustomLabelVO vo = cmInfo.CommonGetCustomLabelInfo( pCompSeq, plangCode, pGroupSeq );
			mv.addObject( "CL", vo.getData( ) );
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
			/* 사용자 기본 옵션 조회 - 로그인 정보 조회 */
			mv.addObject( "loginVo", CommonConvert.CommonGetMapToJSONObj( CommonConvert.CommonGetObjectToMap( loginVo ) ) );
			/* 사용자 기본 옵션 조회 - ERP 옵션 정보 조회 */
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			/* 사용자 기본 옵션 조회 - GW 옵션 정보 조회 */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			/* 사용자 기본 옵션 조회 - ERP 기본정보 조회 */
			mv.addObject( "erpBaseInfo", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPBaseData( params, conVo ).getAaData( ) ) );
			params.put("empInfo", CommonConvert.CommonGetMapToJSONObj(CommonConvert.CommonGetEmpInfo()));
			mv.addObject("ViewBag", params);
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERNPG20YESIL );
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
	 * [비영리/관리자] ERPiU 예실대비 현황
	 */
	@IncludedInfo ( name = "[비영리/사용자] ERPiU 예실대비 현황", order = 4124, gid = 412 )
	@RequestMapping ( "/expend/np/user/NpUserERPiUYesil.do" )
	public ModelAndView NpUserERPiUYesil ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		cmLog.CommonSetInfoToDatabase( "[ #EXNP# @Controller-/expend/np/admin/NpUserERPiUYesil.do] " + params.toString( ), "-", "EXNP" );
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
			mv.addObject( "erp_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPOption( params, conVo ).getAaData( ) ) );
			
			/* 사용자 기본 옵션 조회 - GW 옵션 정보 조회 */
			mv.addObject( "gw_optionSet", CommonConvert.CommonGetListMapToJson( serviceOption.selectGWOption( params, conVo ).getAaData( ) ) );
			
			/* 사용자 기본 옵션 조회 - ERP 기본정보 조회 */
			mv.addObject( "erpBaseInfo", CommonConvert.CommonGetListMapToJson( serviceOption.selectERPBaseData( params, conVo ).getAaData( ) ) );
			
			mv.setViewName( commonExPath.NPUSERCONTENTPATH + commonExPath.USERNPERPIUYESIL );
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
