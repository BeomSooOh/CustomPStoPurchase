/**
  * @FileName : BAnguUserController.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.web;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ResultVO;
import expend.angu.user.angu.BAnguUserAnguService;
import expend.angu.user.code.BAnguUserCodeService;


/**
 *   * @FileName : BAnguUserController.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Controller
public class BAnguUserController {

	/* 변수정의 */
	@Resource ( name = "BAnguUserAnguService" )
	private BAnguUserAnguService AnguUser; /* 국고보조 집행등록 */
	@Resource ( name = "BAnguUserCodeService" )
	private BAnguUserCodeService AnguCode; /* 국고보조 코드 */
	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - 지급구분 */

	@RequestMapping ( "/expend/angu/getPayDivInfoI_Select.do" )
	public ModelAndView getPayDivInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			/* 데이터 조회 - 1차 개발 : 하드코딩 > 2차개발 : iCUBE API 요청하여 처리 */
			/* 반환처리 */
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조사업 */
	@RequestMapping ( "/expend/angu/getAnguBusinessInfoI_Select.do" )
	public ModelAndView getAnguBusinessInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* exec USP_ANGU300_DDTLBZ_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017' */
		/* return : anguBusinessCode, anguBusinessName */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguBusinessInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 이체계좌구분 */
	@RequestMapping ( "/expend/angu/getAnguAccountDivInfoI_Select.do" )
	public ModelAndView getAnguAccountDivInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'1089' */
		/* return : anguAccountDivCode, anguAccountDivName */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguAccountDivInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 자계좌이체사유코드 */
	@RequestMapping ( "/expend/angu/getAnguAccountReasonDivInfoI_Select.do" )
	public ModelAndView getAnguAccountReasonDivInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'0665' */
		/* return : anguAccountReasonDivCode, anguAccountReasonDivName */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguAccountReasonDivInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(과세) */
	@RequestMapping ( "/expend/angu/getAnguEtaxTaxInfoI_Select.do" )
	public ModelAndView getAnguEtaxTaxInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'2',@FR_DT=N'20170101',@TO_DT=N'20170921',@TAX_TY=N'2',@ETAX_TY=N'',@TR_CD=N'10000|',@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : anguEtaxTaxNum, CO_CD, DIV_CD, DIV_NM, anguEtaxTaxWriteDate, TAX_TY, anguEtaxTaxIssueDate, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNum, anguEtaxTaxAmt, anguEtaxTaxVat, anguEtaxTaxReqAmt, DIVCEO_NM, anguEtaxTaxDiv, TR_CD, BCNC_CMPNY_NM, DUZON_BANK_CODE, BCNC_ACNUT_NO, BCNC_ADRES, BCNC_RPRSNTY_NM, BCNC_TELNO, BCNC_BANK_CODE, BANK_NM, anguEtaxTaxUsedAmt, anguEtaxTaxNotUsedAmt, SUP_M_SPLPC, VAT_M_VAT, SEND_YN */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguEtaxTaxInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(면세) */
	@RequestMapping ( "/expend/angu/getAnguEtaxTaxFreeInfoI_Select.do" )
	public ModelAndView getAnguEtaxTaxFreeInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'1',@FR_DT=N'20170101',@TO_DT=N'20171007',@TAX_TY=N'4',@ETAX_TY=N'',@TR_CD=N'',@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : anguEtaxTaxNum, CO_CD, DIV_CD, DIV_NM, anguEtaxTaxWriteDate, TAX_TY, anguEtaxTaxIssueDate, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNum, anguEtaxTaxAmt, anguEtaxTaxVat, anguEtaxTaxReqAmt, DIVCEO_NM, anguEtaxTaxDiv, TR_CD, BCNC_CMPNY_NM, DUZON_BANK_CODE, BCNC_ACNUT_NO, BCNC_ADRES, BCNC_RPRSNTY_NM, BCNC_TELNO, BCNC_BANK_CODE, BANK_NM, anguEtaxTaxUsedAmt, anguEtaxTaxNotUsedAmt, SUP_M_SPLPC, VAT_M_VAT, SEND_YN */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguEtaxTaxFreeInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 */
	@RequestMapping ( "/expend/angu/getAnguCardAuthI_Select.do" )
	public ModelAndView getAnguCardAuthI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		/* return : CTR_CD, TR_NM, BA_NB */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguCardAuthI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 승인 내역 */
	@RequestMapping ( "/expend/angu/getAnguCardInfoI_Select.do" )
	public ModelAndView getAnguCardInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_ANGU300_CARDINFO_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CONFM_DE_FR=N'20170101',@CONFM_DE_TO=N'20171122',@CARD_NO=N'5525764197210327',@MRHST_NM=N'',@PUCHAS_TAMT=0,@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : confmDe, mrhstNm, mrbcrbRegistNo, splpc, vat, puchasTamt, puchasTkbakNo, puchasDe, bcncLsftNo, bcncRprsntvNm, bcncTelNo, trNm, ctrCd, cardNo, bcncBankCode, bankNm, trCd, bcncCmpnyNm, ceoNm, tel, duzonBankCode, bcncAcnutNo, bcncAdres, bcncAdres2, excutSumAmount, am, sumMSplpc, vatMVat */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguCardInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 사원 */
	@RequestMapping ( "/expend/angu/getAnguEmpInfoI_Select.do" )
	public ModelAndView getAnguEmpInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguEmpInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 */
	@RequestMapping ( "/expend/angu/getAnguPartnerInfoI_Select_01.do" )
	public ModelAndView getAnguPartnerInfoI_Select_01 ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=NULL */
		/* return : anguEtaxPartnerCode, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNameKr, anguEtaxTaxPartnerNum, BCNC_ACNUT_NO, BCNC_RPRSNTY_NM, CEO_NMK, TR_FG_NM, TR_FG, JIRO_CD, TR_NM, TR_NMK, JEONJA_YN, LIQ_RS, EMAIL, INTER_DT, TRCHARGE_EMAIL, INTER_RT */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguPartnerInfoI_Select_01( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 계좌 */
	@RequestMapping ( "/expend/angu/getAnguPartnerInfoI_Select_02.do" )
	public ModelAndView getAnguPartnerInfoI_Select_02 ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_ANGU300_STRADE_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@TR_CD=N'10005',@JIRO_CD=N'030',@TR_FG=N'1' */
		/* return : DEPOSITOR, REG_NB, ADDR, TEL, BANK_CD, BANK_NM */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguPartnerInfoI_Select_02( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(iCUBE G20) */
	@RequestMapping ( "/expend/angu/getAnguG20BankInfoI_Select_01.do" )
	public ModelAndView getAnguG20BankInfoI_Select_01 ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SBANK_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'DUMMY3 = ''1''' */
		/* return : DUZON_BANK_CODE, BANK_NM, BANK_NMK */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguG20BankInfoI_Select_01( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(e나라도움) */
	@RequestMapping ( "/expend/angu/getAnguG20BankInfoI_Select_02.do" )
	public ModelAndView getAnguG20BankInfoI_Select_02 ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_ANGU300_BANK_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BANK_CD=N'050' */
		/* BCNC_BANK_CODE, BANK_NM */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguG20BankInfoI_Select_02( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 보조비목세목 */
	@RequestMapping ( "/expend/angu/getAnguBimokInfoI_Select.do" )
	public ModelAndView getAnguBimokInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* [프로시저 미사용] EXEC USP_ANGU300_ASSTN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20171008',@MOSF_GISU_SQ=1,@FSYR=N'2017' */
		/* ASSTN_EXPITM_TAXITM_CODE, ASSTN_EXPITM_NM, ASSTN_TAXITM_NM */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguBimokInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 재원구분 */
	@RequestMapping ( "/expend/angu/getAnguJaewonInfoI_Select.do" )
	public ModelAndView getAnguJaewonInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* [프로시저 미사용] EXEC USP_ANGU300_ANBOJO_B_CMMN_CODE_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20171008',@MOSF_GISU_SQ=1,@MOSF_BG_SQ=1 */
		/* return : anguJaewonDivCode, anguJaewonDivName */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguJaewonInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행 금액 조회 */
	@RequestMapping ( "/expend/angu/getAnguResultAmtInfoI_Select.do" )
	public ModelAndView getAnguResultAmtInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_ANGU300_RESULTERP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@DDTLBZ_ID=N'20170125000000000787',@ASSTN_TAXITM_CODE=N'11003',@FNRSC_SE_CODE=N'001' */
		/* return : excutPlanAmount, excutAmount, sumAmount, sum, sub */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguResultAmtInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 프로젝트 조회 */
	@RequestMapping ( "/expend/angu/getAnguProjectInfoI_Select.do" )
	public ModelAndView getAnguProjectInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_ANGU300_MGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		/* return : MGT_CD, PJT_NM, TR_CD, TR_NM */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguProjectInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 예산과목 조회 */
	@RequestMapping ( "/expend/angu/getAnguBgtInfoI_Select.do" )
	public ModelAndView getAnguBgtInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* EXEC USP_ANGU300_BGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@ASSTN_TAXITM_CODE=N'11003' */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231',@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* return : BGT01_CD, BGT01_NM, BGT01_NMK, BGT02_CD, BGT02_NM, BGT02_NMK, BGT03_CD, BGT03_NM, BGT03_NMK, BGT04_CD, BGT04_NM, BGT04_NMK, BGT_CD, BGT_NM, BGT_NMK, DIV_FG, GROUP_CD, GROUP_NM, GROUP_NMK, HBGT_CD, USE_YN, CTL_FG, DUMMY1, DUMMY2, TO_DT, CARR_YN, DRCR_FG, GR_FG, HBGT_CD1, HBGT_CD2, HBGT_CD3, CP_YN, SYS_CD, LAST_YN2, BIZ_FG, LEVEL01_CD, LEVEL02_CD, LEVEL03_CD, LEVEL04_CD, LEVEL05_CD, LEVEL06_CD, LEVEL01_NM, LEVEL02_NM, LEVEL03_NM, LEVEL04_NM, LEVEL05_NM, LEVEL06_NM, LEVEL01_NMK, LEVEL02_NMK, LEVEL03_NMK, LEVEL04_NMK, LEVEL05_NMK, LEVEL06_NMK */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguBgtInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 금융거래처 조회 */
	@RequestMapping ( "/expend/angu/getAnguBankPartnerInfoI_Select.do" )
	public ModelAndView getAnguBankPartnerInfoI_Select ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5''' */
		/* return : TR_CD, ATTR_NM, ATTR_NMK, REG_NB, BA_NB, CEO_NM, CEO_NMK, TR_FG_NM, TR_FG, JIRO_CD, TR_NM, TR_NMK, JEONJA_YN, LIQ_RS, EMAIL, INTER_DT, TRCHARGE_EMAIL, INTER_RT */
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* 데이터 조회 */
			result = AnguCode.getAnguBankPartnerInfoI_Select( result );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [+] 국고보조 v2 ## - 문서 상세 정보 등록 */
	@RequestMapping ( "/expend/angu/setAnguDetailInfo_Insert.do" )
	public ModelAndView setAnguDetailInfo_Insert ( @RequestParam Map<String, Object> param, HttpServletRequest request ) {
		ModelAndView mv = new ModelAndView( );
		/* 변수정의 */
		ResultVO result = new ResultVO( );
		try {
			/* 변수정의 */
			/* Map<String, Object> anguInfo = new HashMap<String, Object>( ); */
			/* 기본값 정의 */
			param = CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), param );
			result.setParams( param );
			/* if ( MapUtil.hasKey( param, "resolve" ) ) { anguInfo.put( "resolve", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "resolve" ) ) ) ); } */
			/* if ( MapUtil.hasKey( param, "auth" ) ) { anguInfo.put( "auth", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "auth" ) ) ) ); } */
			/* if ( MapUtil.hasKey( param, "bimok" ) ) { anguInfo.put( "bimok", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "bimok" ) ) ) ); } */
			/* if ( MapUtil.hasKey( param, "jaewon" ) ) { anguInfo.put( "jaewon", CommonConvert.CommonGetJSONToListMap( CommonConvert.CommonGetStr( param.get( "jaewon" ) ) ) ); } */
			/* 데이터 생성 */
			result = AnguUser.setAnguDocumentAbdocu_Insert( result, CommonConvert.CommonGetStr( param.get( "anbojoSeq" ) ) );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		mv.addObject( "result", result );
		mv.setViewName( "jsonView" );
		return mv;
	}

	/* ## [-] 국고보조 v2 ## */
	/* 국고보조 */
	/*--------------------------------------------------*/
	/* 국고보조 집행등록 문서 생성 */
	@RequestMapping ( "/expend/angu/AnguI.do" )
	public ModelAndView AnguI ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguUser.AnguI( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 국고보조 집행등록 인력정보 등록 생성 */
	@RequestMapping ( "/expend/angu/AnguPayI.do" )
	public ModelAndView AnguPayI ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguUser.AnguPayI( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 국고보조 집행등록 문서 갱신 */
	@RequestMapping ( "/expend/angu/AnguU.do" )
	public ModelAndView AnguU ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 국고보조 집행등록 전자결재 상신 준비 */
	@RequestMapping ( "/expend/angu/AnguApprovalI.do" )
	public ModelAndView AnguApprovalI ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguUser.AnguApprovalI( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 공통코드 */
	/*--------------------------------------------------*/
	/* 국고보조사업 */
	@RequestMapping ( "/expend/angu/DdtlbzInfoS.do" )
	public ModelAndView DdtlbzInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_DDTLBZ_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017' */
		/* parameters : BSNSYEAR */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.DdtlbzInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 이쳬계좌구분 */
	@RequestMapping ( "/expend/angu/TransfracnutseInfoS.do" )
	public ModelAndView TransfracnutseInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'1089' */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.TransfracnutseInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 자계좌이체사유코드 */
	@RequestMapping ( "/expend/angu/SbsacnttrfrsnInfoS.do" )
	public ModelAndView SbsacnttrfrsnInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'0665' */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.SbsacnttrfrsnInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 코드 - 카드 코드도움 */
	@RequestMapping ( "/expend/angu/CardInfoS.do" )
	public ModelAndView CardInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 국고보조사업 귀속 카드 >> exec USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.CardInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 코드 - 증빙승인번호 - 카드 */
	@RequestMapping ( "/expend/angu/PrufsenoCardS.do" )
	public ModelAndView PrufsenoCardS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 국고보조사업 귀속 카드 >> exec USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.PrufsenoCardS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 증빙승인번호 */
	@RequestMapping ( "/expend/angu/PrufsenoInfoS.do" )
	public ModelAndView PrufsenoInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 전자세금계산서 >> exec USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'1',@FR_DT=N'20160101',@TO_DT=N'20170520',@TAX_TY=N'2',@ETAX_TY=N'',@TR_CD=N'1000|',@DDTLBZ_ID=N'TEST-00001',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* 카드거래 >> exec USP_ANGU300_CARDINFO_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CONFM_DE_FR=N'20160101',@CONFM_DE_TO=N'20170520',@CARD_NO=N'1234123412341234',@MRHST_NM=N'',@PUCHAS_TAMT=0,@DDTLBZ_ID=N'TEST-00001',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.PrufsenoInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 코드 */
	@RequestMapping ( "/expend/angu/TrInfoS.do" )
	public ModelAndView TrInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=NULL */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.TrInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 금융기관 */
	@RequestMapping ( "/expend/angu/BcncbankInfoS.do" )
	public ModelAndView BcncbankInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SBANK_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'DUMMY3 = ''1''' */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.BcncbankInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 보조비목세목코드 */
	@RequestMapping ( "/expend/angu/AsstntaxitmInfoS.do" )
	public ModelAndView AsstntaxitmInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_ASSTN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20170515',@MOSF_GISU_SQ=1,@FSYR=N'2017' */
		/* parameters : MOSF_GISU_DT, MOSF_GISU_SQ, FSYR */
		/* DDTLBZ_ID, BSNSYEAR */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.AsstntaxitmInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 재원구분 */
	@RequestMapping ( "/expend/angu/FnrscseInfoS.do" )
	public ModelAndView FnrscseInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_ANBOJO_B_CMMN_CODE_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20170515',@MOSF_GISU_SQ=1,@MOSF_BG_SQ=1 */
		/* parameters : MOSF_GISU_DT, MOSF_GISU_SQ, MOSF_BG_SQ */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.FnrscseInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 프로젝트 */
	@RequestMapping ( "/expend/angu/MgtInfoS.do" )
	public ModelAndView MgtInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_MGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'TEST-00001' */
		/* parameters : DDTLBZ_ID */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.MgtInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 예산과목 - 레벨 */
	@RequestMapping ( "/expend/angu/AbgtLevelInfoS.do" )
	public ModelAndView AbgtLevelInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.AbgtLevelInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 예산과목 */
	@RequestMapping ( "/expend/angu/AbgtInfoS.do" )
	public ModelAndView AbgtInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_BGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@ASSTN_TAXITM_CODE=N'11001' */
		/* exec USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=2,@FR_DT=N'20170101',@TO_DT=N'20171231',@GR_FG=N'2',@DIV_CDS=N'',@MGT_CDS=N'',@BOTTOM_CDS=N'',@BGT_CD=NULL,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'1',@OPT_03=N'1',@BGT_FR_DT=N'20170101',@GROUP_CD=N'' */
		/* exec USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.AbgtInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 코드 */
	@RequestMapping ( "/expend/angu/BtrInfoS.do" )
	public ModelAndView BtrInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5''' */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.BtrInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 금액집계 */
	@RequestMapping ( "/expend/angu/AmountInfoS.do" )
	public ModelAndView AmountInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_RESULTERP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@DDTLBZ_ID=N'TEST-00001',@ASSTN_TAXITM_CODE=N'11001',@FNRSC_SE_CODE=N'001' */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.AmountInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 인력정보등록 - 코드 */
	@RequestMapping ( "/expend/angu/HpmeticInfoS.do" )
	public ModelAndView HpmeticInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_ANGU300_HPMETIC_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BASE_DT=N'20170516' */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.HpmeticInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}
	/* 카드승인내역 */

	@RequestMapping ( "/expend/angu/AbdocuApprovalD.do" )
	public ModelAndView AbdocuApprovalD ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguUser.AbdocuApprovalDel( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 인력정보등록 - 소득구분 */
	@RequestMapping ( "/expend/angu/PayTpInfoS.do" )
	public ModelAndView PayTpInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SCTRL_D_CODE',@P_CO_CD=N'3585',@P_CODE=N'',@P_CODE2=N'',@P_CODE3=N'',@P_USE_YN=N'1',@P_NAME=N'',@P_STD_DT=N'',@P_WHERE=N'CTRL_CD = ''G'' AND MODULE_CD = ''H'' AND CTD_CD IN(''60'', ''62'', ''63'', ''68'', ''71'', ''72'', ''73'', ''74'', ''75'', ''76'')' */
		/* parameters : */
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.PayTpInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}

	/* 연동 거래처 정보 조회 */
	@RequestMapping ( "/expend/angu/LinkPartnerInfoS.do" )
	public ModelAndView LinkPartnerInfoS ( @RequestParam HashMap<String, Object> params, HttpServletRequest request ) throws Exception {
		/* 변수정의 */
		ModelAndView mv = new ModelAndView( );
		ResultVO result = new ResultVO( );
		try {
			result.setIpAddress( CommonConvert.CommonGetClientIP( request ) );
			result.setParams( params );
			result = AnguCode.LinkPartnerInfoS( result );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
			/* 반환값 정의 */
			mv.addObject( "result", result );
			mv.setViewName( "jsonView" );
		}
		/* 반환 */
		return mv;
	}
}