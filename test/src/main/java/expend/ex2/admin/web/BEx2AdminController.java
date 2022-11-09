/**
  * @FileName : BEx2AdminController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.ex2.admin.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.helper.logger.CommonLogger;
import common.vo.common.ResultVO;
import expend.ex2.admin.auth.BEx2AdminAuthService;
import expend.ex2.admin.summary.BEx2AdminSummaryService;


/**
 *   * @FileName : BEx2AdminController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Controller
public class BEx2AdminController {

	/* 변수정의 - Common */
	@Resource ( name = "CommonLogger" )
	private CommonLogger cmLog; /* Log 관리 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통 사용 정보 관리 */
	/* 변수정의 - Service */
	@Resource ( name = "BEx2AdminSummaryService" )
	private BEx2AdminSummaryService ex2AdminSummaryService;
	@Resource ( name = "BEx2AdminAuthService" )
	private BEx2AdminAuthService ex2AdminAuthService;

	/* 관리자 - 표준적요 설정 - 추가 */
	@RequestMapping ( "/expend/ex2/admin/summary/setAdminSummaryInsert.do" )
	public ModelAndView setAdminSummaryInsert ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameter : compSeq, summaryCode, summaryName, drAcctCode, drAcctName, crAcctCode, crAcctName, vatAcctCode, vatAcctName, erpAuthCode, erpAuthName, bankPartnerCode, bankPartnerName, useYN, empSeq, orderNum */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* null 처리 */
			params.put( "compSeq", CommonConvert.CommonGetStr( params.get( "compSeq" ) ) );
			params.put( "summaryCode", CommonConvert.CommonGetStr( params.get( "summaryCode" ) ) );
			params.put( "summaryName", CommonConvert.CommonGetStr( params.get( "summaryName" ) ) );
			params.put( "drAcctCode", CommonConvert.CommonGetStr( params.get( "drAcctCode" ) ) );
			params.put( "drAcctName", CommonConvert.CommonGetStr( params.get( "drAcctName" ) ) );
			params.put( "crAcctCode", CommonConvert.CommonGetStr( params.get( "crAcctCode" ) ) );
			params.put( "crAcctName", CommonConvert.CommonGetStr( params.get( "crAcctName" ) ) );
			params.put( "vatAcctCode", CommonConvert.CommonGetStr( params.get( "vatAcctCode" ) ) );
			params.put( "vatAcctName", CommonConvert.CommonGetStr( params.get( "vatAcctName" ) ) );
			params.put( "erpAuthCode", CommonConvert.CommonGetStr( params.get( "erpAuthCode" ) ) );
			params.put( "erpAuthName", CommonConvert.CommonGetStr( params.get( "erpAuthName" ) ) );
			params.put( "bankPartnerCode", CommonConvert.CommonGetStr( params.get( "bankPartnerCode" ) ) );
			params.put( "bankPartnerName", CommonConvert.CommonGetStr( params.get( "bankPartnerName" ) ) );
			params.put( "useYN", CommonConvert.CommonGetStr( params.get( "useYN" ) ) );
			params.put( "empSeq", CommonConvert.CommonGetStr( params.get( "empSeq" ) ) );
			params.put( "orderNum", CommonConvert.CommonGetStr( params.get( "orderNum" ) ) );
			/* 기본값 정의 */
			result.setParams( params );
			result = ex2AdminSummaryService.setAdminSummaryInsert( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 관리자 - 표준적요 수정 */
	@RequestMapping ( "/expend/ex2/admin/summary/setAdminSummaryUpdate.do" )
	public ModelAndView setAdminSummaryUpdate ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameter : summaryName, drAcctCode, drAcctName, crAcctCode, crAcctName, vatAcctCode, vatAcctName, erpAuthCode, erpAuthName, bankPartnerCode, bankPartnerName, useYN, empSeq, orderNum */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* null 처리 */
			params.put( "compSeq", CommonConvert.CommonGetStr( params.get( "compSeq" ) ) );
			params.put( "summaryCode", CommonConvert.CommonGetStr( params.get( "summaryCode" ) ) );
			params.put( "summaryName", CommonConvert.CommonGetStr( params.get( "summaryName" ) ) );
			params.put( "drAcctCode", CommonConvert.CommonGetStr( params.get( "drAcctCode" ) ) );
			params.put( "drAcctName", CommonConvert.CommonGetStr( params.get( "drAcctName" ) ) );
			params.put( "crAcctCode", CommonConvert.CommonGetStr( params.get( "crAcctCode" ) ) );
			params.put( "crAcctName", CommonConvert.CommonGetStr( params.get( "crAcctName" ) ) );
			params.put( "vatAcctCode", CommonConvert.CommonGetStr( params.get( "vatAcctCode" ) ) );
			params.put( "vatAcctName", CommonConvert.CommonGetStr( params.get( "vatAcctName" ) ) );
			params.put( "erpAuthCode", CommonConvert.CommonGetStr( params.get( "erpAuthCode" ) ) );
			params.put( "erpAuthName", CommonConvert.CommonGetStr( params.get( "erpAuthName" ) ) );
			params.put( "bankPartnerCode", CommonConvert.CommonGetStr( params.get( "bankPartnerCode" ) ) );
			params.put( "bankPartnerName", CommonConvert.CommonGetStr( params.get( "bankPartnerName" ) ) );
			params.put( "useYN", CommonConvert.CommonGetStr( params.get( "useYN" ) ) );
			params.put( "empSeq", CommonConvert.CommonGetStr( params.get( "empSeq" ) ) );
			params.put( "orderNum", CommonConvert.CommonGetStr( params.get( "orderNum" ) ) );
			/* 기본값 정의 */
			result.setParams( params );
			result = ex2AdminSummaryService.setAdminSummaryUpdate( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 관리자 - 표준적요 설정 - 삭제 */
	@RequestMapping ( "/expend/ex2/admin/summary/setAdminSummaryDelete.do" )
	public ModelAndView setAdminSummaryDelete ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameter : compSeq, summaryCode */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 기본값 정의 */
			result.setParams( params );
			result = ex2AdminSummaryService.setAdminSummaryDelete( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 관리자 - 표준적요 설정 - 조회 ( map ) */
	@RequestMapping ( "/expend/ex2/admin/summary/setAdminSummarySelect.do" )
	public ModelAndView setAdminSummarySelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameter : searchStr, useYN */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 기본값 정의 */
			result.setParams( params );
			result = ex2AdminSummaryService.setAdminSummarySelect( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 관리자 - 표준적요 설정 - 조회 ( list ) */
	@RequestMapping ( "/expend/ex2/admin/summary/setAdminSummaryListSelect.do" )
	public ModelAndView setAdminSummaryListSelect ( @RequestParam Map<String, Object> params, HttpServletRequest request ) throws Exception {
		/* parameter : searchStr, useYN */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 기본값 정의 */
			result.setParams( params );
			result = ex2AdminSummaryService.setAdminSummaryListSelect( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			cmLog.CommonSetError( e );
			throw e;
		}
		return mv;
	}

	/* 증빙유형 */
	/* 관리자 - 증빙유형 설정 - 추가 ( map ) */
	@RequestMapping ( "/expend/ex2/admin/auth/setAdminAuthInsert.do" )
	public ModelAndView setAdminAuthInsert ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		/* parameter : compSeq, authCode, authName, cashType, crAcctCode, crAcctName, vatAcctCode, vatAcctName, vatTypeCode, vatTypeName, erpAuthAode, erpAuthName, authRequiredYN, partnerRequiredYN, cardRequiredYN, projectRequiredYN, noteRequiredYN, noTaxCode, noTaxName, orderNum, useYN, empSeq, vaTypeCode, vaTypeName */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		/* null 처리 */
		param.put( "compSeq", CommonConvert.CommonGetStr( param.get( "compSeq" ) ) );
		param.put( "authCode", CommonConvert.CommonGetStr( param.get( "authCode" ) ) );
		param.put( "authName", CommonConvert.CommonGetStr( param.get( "authName" ) ) );
		param.put( "authNameEn", CommonConvert.CommonGetStr( param.get( "authNameEn" ) ) );
		param.put( "authNameCn", CommonConvert.CommonGetStr( param.get( "authNameCn" ) ) );
		param.put( "authNameJp", CommonConvert.CommonGetStr( param.get( "authNamejp" ) ) );
		param.put( "authDiv", CommonConvert.CommonGetStr( param.get( "authDiv" ) ) );
		param.put( "cashType", CommonConvert.CommonGetStr( param.get( "cashType" ) ) );
		param.put( "vatTypeCode", CommonConvert.CommonGetStr( param.get( "vatTypeCode" ) ) );
		param.put( "vatTypeName", CommonConvert.CommonGetStr( param.get( "vatTypeName" ) ) );
		param.put( "drAcctCode", CommonConvert.CommonGetStr( param.get( "drAcctCode" ) ) );
		param.put( "drAcctName", CommonConvert.CommonGetStr( param.get( "drAcctName" ) ) );
		param.put( "noTaxCode", CommonConvert.CommonGetStr( param.get( "noTaxCode" ) ) );
		param.put( "noTaxName", CommonConvert.CommonGetStr( param.get( "noTaxName" ) ) );
		param.put( "vaTypeCode", CommonConvert.CommonGetStr( param.get( "vaTypeCode" ) ) );
		param.put( "vaTypeName", CommonConvert.CommonGetStr( param.get( "vaTypeName" ) ) );
		param.put( "crAcctCode", CommonConvert.CommonGetStr( param.get( "crAcctCode" ) ) );
		param.put( "crAcctName", CommonConvert.CommonGetStr( param.get( "crAcctName" ) ) );
		param.put( "vatAcctCode", CommonConvert.CommonGetStr( param.get( "vatAcctCode" ) ) );
		param.put( "vatAcctName", CommonConvert.CommonGetStr( param.get( "vatAcctName" ) ) );
		param.put( "erpAuthCode", CommonConvert.CommonGetStr( param.get( "erpAuthCode" ) ) );
		param.put( "erpAuthName", CommonConvert.CommonGetStr( param.get( "erpAuthName" ) ) );
		param.put( "bankPartnerCode", CommonConvert.CommonGetStr( param.get( "bankPartnerCode" ) ) );
		param.put( "bankPartnerName", CommonConvert.CommonGetStr( param.get( "bankPartnerName" ) ) );
		param.put( "noteRequiredYN", CommonConvert.CommonGetStr( param.get( "noteRequiredYN" ) ) );
		param.put( "authRequiredYN", CommonConvert.CommonGetStr( param.get( "authRequiredYN" ) ) );
		param.put( "cardRequiredYN", CommonConvert.CommonGetStr( param.get( "cardRequiredYN" ) ) );
		param.put( "partnerRequiredYN", CommonConvert.CommonGetStr( param.get( "partnerRequiredYN" ) ) );
		param.put( "projectRequiredYN", CommonConvert.CommonGetStr( param.get( "projectRequiredYN" ) ) );
		param.put( "useYN", CommonConvert.CommonGetStr( param.get( "useYN" ) ) );
		param.put( "empSeq", CommonConvert.CommonGetStr( param.get( "empSeq" ) ) );
		param.put( "orderNum", CommonConvert.CommonGetStr( param.get( "orderNum" ) ) );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 기본값 정의 */
			result.setParams( param );
			result = ex2AdminAuthService.setAdminAuthInsert( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* 관리자 - 증빙유형 설정 - 수정 ( map ) */
	@RequestMapping ( "/expend/ex2/admin/auth/setAdminAuthUpdate.do" )
	public ModelAndView setAdminAuthUpdate ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		/* parameter : authName, cashType, crAcctCode, crAcctName, vatAcctCode, vatAcctName, vatTypeCode, vatTypeName, erpAuthCode, erpAuthName, authRequiredYN, partnerRequiredYN, cardRequiredYN, projectRequiredYN, noteRequiredYN, noTaxCode, noTaxName, orderNum, useYN, empSeq, vaTypeCode, vaTypeName, compSeq, authDiv, authCode */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* null 처리 */
			param.put( "compSeq", CommonConvert.CommonGetStr( param.get( "compSeq" ) ) );
			param.put( "authCode", CommonConvert.CommonGetStr( param.get( "authCode" ) ) );
			param.put( "authName", CommonConvert.CommonGetStr( param.get( "authName" ) ) );
			param.put( "authNameEn", CommonConvert.CommonGetStr( param.get( "authNameEn" ) ) );
			param.put( "authNameCn", CommonConvert.CommonGetStr( param.get( "authNameCn" ) ) );
			param.put( "authNameJp", CommonConvert.CommonGetStr( param.get( "authNamejp" ) ) );
			param.put( "authDiv", CommonConvert.CommonGetStr( param.get( "authDiv" ) ) );
			param.put( "cashType", CommonConvert.CommonGetStr( param.get( "cashType" ) ) );
			param.put( "vatTypeCode", CommonConvert.CommonGetStr( param.get( "vatTypeCode" ) ) );
			param.put( "vatTypeName", CommonConvert.CommonGetStr( param.get( "vatTypeName" ) ) );
			param.put( "drAcctCode", CommonConvert.CommonGetStr( param.get( "drAcctCode" ) ) );
			param.put( "drAcctName", CommonConvert.CommonGetStr( param.get( "drAcctName" ) ) );
			param.put( "noTaxCode", CommonConvert.CommonGetStr( param.get( "noTaxCode" ) ) );
			param.put( "noTaxName", CommonConvert.CommonGetStr( param.get( "noTaxName" ) ) );
			param.put( "vaTypeCode", CommonConvert.CommonGetStr( param.get( "vaTypeCode" ) ) );
			param.put( "vaTypeName", CommonConvert.CommonGetStr( param.get( "vaTypeName" ) ) );
			param.put( "crAcctCode", CommonConvert.CommonGetStr( param.get( "crAcctCode" ) ) );
			param.put( "crAcctName", CommonConvert.CommonGetStr( param.get( "crAcctName" ) ) );
			param.put( "vatAcctCode", CommonConvert.CommonGetStr( param.get( "vatAcctCode" ) ) );
			param.put( "vatAcctName", CommonConvert.CommonGetStr( param.get( "vatAcctName" ) ) );
			param.put( "erpAuthCode", CommonConvert.CommonGetStr( param.get( "erpAuthCode" ) ) );
			param.put( "erpAuthName", CommonConvert.CommonGetStr( param.get( "erpAuthName" ) ) );
			param.put( "bankPartnerCode", CommonConvert.CommonGetStr( param.get( "bankPartnerCode" ) ) );
			param.put( "bankPartnerName", CommonConvert.CommonGetStr( param.get( "bankPartnerName" ) ) );
			param.put( "noteRequiredYN", CommonConvert.CommonGetStr( param.get( "noteRequiredYN" ) ) );
			param.put( "authRequiredYN", CommonConvert.CommonGetStr( param.get( "authRequiredYN" ) ) );
			param.put( "cardRequiredYN", CommonConvert.CommonGetStr( param.get( "cardRequiredYN" ) ) );
			param.put( "partnerRequiredYN", CommonConvert.CommonGetStr( param.get( "partnerRequiredYN" ) ) );
			param.put( "projectRequiredYN", CommonConvert.CommonGetStr( param.get( "projectRequiredYN" ) ) );
			param.put( "useYN", CommonConvert.CommonGetStr( param.get( "useYN" ) ) );
			param.put( "empSeq", CommonConvert.CommonGetStr( param.get( "empSeq" ) ) );
			param.put( "orderNum", CommonConvert.CommonGetStr( param.get( "orderNum" ) ) );
			/* 기본값 정의 */
			result.setParams( param );
			result = ex2AdminAuthService.setAdminAuthUpdate( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* 관리자 - 증빙유형 설정 - 삭제 ( map ) */
	@RequestMapping ( "/expend/ex2/admin/auth/setAdminAuthDelete.do" )
	public ModelAndView setAdminAuthDelete ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		/* parameter : compSeq, authDiv, authCode */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 기본값 정의 */
			result.setParams( param );
			result = ex2AdminAuthService.setAdminAuthDelete( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* 관리자 - 증빙유형 설정 - 조회 ( list ) */
	@RequestMapping ( "/expend/ex2/admin/auth/setAdminAuthListSelect.do" )
	public ModelAndView setAdminAuthListSelect ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		/* parameter : searchStr, useYN */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 기본값 정의 */
			result.setParams( param );
			result = ex2AdminAuthService.setAdminAuthListSelect( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* 관리자 - 증빙유형 설정 - 조회 ( map ) */
	@RequestMapping ( "/expend/ex2/admin/auth/setAdminAuthSelect.do" )
	public ModelAndView setAdminAuthSelect ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		/* parameter : searchStr, useYN */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		try {
			/* 변수정의 */
			ResultVO result = new ResultVO( );
			/* 기본값 정의 */
			result.setParams( param );
			result = ex2AdminAuthService.setAdminAuthSelect( result );
			/* 반환값 정의 */
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return mv;
	}

	/* 관리자 - 증빙유형 설정 - 코드 자동 조회 (map) */
	@RequestMapping ( "/expend/ex2/admin/auth/setAdminAuthAuthCode.do" )
	public ModelAndView setAdminAuthAuthCode ( @RequestParam Map<String, Object> param, HttpServletRequest request ) throws Exception {
		/* parameter : searchStr, useYN */
		/* return : */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			result.setParams( param );
			result = ex2AdminAuthService.setAdminAuthAutoCode( result );
		}
		catch ( Exception ex ) {
			result.setFail( "서버조회 오류 발생", ex );
		}
		finally {
			mv.setViewName( "jsonView" );
			mv.addObject( "result", result );
		}
		return mv;
	}
}
