/**
  * @FileName : BAnguUserCodeServiceImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cmm.util.ErpUtil;
import common.helper.convert.CommonConvert;
import common.helper.info.CommonInfo;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.angu.user.common.BAnUserCommonService;


/**
 *   * @FileName : BAnguUserCodeServiceImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "BAnguUserCodeService" )
public class BAnguUserCodeServiceImpl implements BAnguUserCodeService {

	/* 변수정의 */
	@Resource ( name = "CommonInfo" )
	private CommonInfo cmInfo; /* 공통사용 정보 */
	@Resource ( name = "BAnUserCommonService" )
	private BAnUserCommonService AnguCommon; /* 국고보조 전용 공통 */
	@Resource ( name = "FAnguUserCodeServiceI" )
	private FAnguUserCodeService AnguCode; /* 국고보조 코드 */

	/* ## [+] 국고보조 v2 ## */
	/* iCUBE - 사용자 정보 조회 ( 회사, 사업장, 부서 ) */
	public ResultVO getEmpInfoI_Select ( ResultVO result ) throws Exception {
		/* return : erpCompSeq, erpCompName, erpCompFrDate, erpCompToDate, erpCompGisu, erpBizSeq, erpBizName, erpSectSeq, erpSectName, erpDeptSeq, erpDeptName, erpEmpSeq, erpEmpName */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getEmpInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setaData( new HashMap<String, Object>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - ERP 통장표시내용 환경 설정 */
	public ResultVO getAnguTermInfoI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* return : CO_CD, BOJO_RMK, TR_RMK */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguTermInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setaData( new HashMap<String, Object>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - ERP 국고보조사업 조회 */
	public ResultVO getAnguBusinessInfoI_Select ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_DDTLBZ_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017' */
		/* return : anguBusinessCode, anguBusinessName */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguBusinessInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 이체계좌구분 */
	public ResultVO getAnguAccountDivInfoI_Select ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'1089' */
		/* return : anguAccountDivCode, anguAccountDivName */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguAccountDivInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 자계좌이체사유코드 */
	public ResultVO getAnguAccountReasonDivInfoI_Select ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'0665' */
		/* return : anguAccountReasonDivCode, anguAccountReasonDivName */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguAccountReasonDivInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(과세) */
	public ResultVO getAnguEtaxTaxInfoI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'2',@FR_DT=N'20170101',@TO_DT=N'20170921',@TAX_TY=N'2',@ETAX_TY=N'',@TR_CD=N'10000|',@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : anguEtaxTaxNum, CO_CD, DIV_CD, DIV_NM, anguEtaxTaxWriteDate, TAX_TY, anguEtaxTaxIssueDate, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNum, anguEtaxTaxAmt, anguEtaxTaxVat, anguEtaxTaxReqAmt, DIVCEO_NM, anguEtaxTaxDiv, TR_CD, BCNC_CMPNY_NM, DUZON_BANK_CODE, BCNC_ACNUT_NO, BCNC_ADRES, BCNC_RPRSNTY_NM, BCNC_TELNO, BCNC_BANK_CODE, BANK_NM, anguEtaxTaxUsedAmt, anguEtaxTaxNotUsedAmt, SUP_M_SPLPC, VAT_M_VAT, SEND_YN */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguEtaxTaxInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(면세) */
	public ResultVO getAnguEtaxTaxFreeInfoI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'1',@FR_DT=N'20170101',@TO_DT=N'20171007',@TAX_TY=N'4',@ETAX_TY=N'',@TR_CD=N'',@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : anguEtaxTaxNum, CO_CD, DIV_CD, DIV_NM, anguEtaxTaxWriteDate, TAX_TY, anguEtaxTaxIssueDate, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNum, anguEtaxTaxAmt, anguEtaxTaxVat, anguEtaxTaxReqAmt, DIVCEO_NM, anguEtaxTaxDiv, TR_CD, BCNC_CMPNY_NM, DUZON_BANK_CODE, BCNC_ACNUT_NO, BCNC_ADRES, BCNC_RPRSNTY_NM, BCNC_TELNO, BCNC_BANK_CODE, BANK_NM, anguEtaxTaxUsedAmt, anguEtaxTaxNotUsedAmt, SUP_M_SPLPC, VAT_M_VAT, SEND_YN */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguEtaxTaxFreeInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 */
	public ResultVO getAnguCardAuthI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		/* return : CTR_CD, TR_NM, BA_NB */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguCardAuthI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 승인 내역 */
	public ResultVO getAnguCardInfoI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_CARDINFO_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CONFM_DE_FR=N'20170101',@CONFM_DE_TO=N'20171122',@CARD_NO=N'5525764197210327',@MRHST_NM=N'',@PUCHAS_TAMT=0,@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : confmDe, mrhstNm, mrbcrbRegistNo, splpc, vat, puchasTamt, puchasTkbakNo, puchasDe, bcncLsftNo, bcncRprsntvNm, bcncTelNo, trNm, ctrCd, cardNo, bcncBankCode, bankNm, trCd, bcncCmpnyNm, ceoNm, tel, duzonBankCode, bcncAcnutNo, bcncAdres, bcncAdres2, excutSumAmount, am, sumMSplpc, vatMVat */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguCardInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 사원 */
	public ResultVO getAnguEmpInfoI_Select ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguEmpInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 */
	public ResultVO getAnguPartnerInfoI_Select_01 ( ResultVO result ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=NULL */
		/* return : anguEtaxPartnerCode, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNameKr, anguEtaxTaxPartnerNum, BCNC_ACNUT_NO, BCNC_RPRSNTY_NM, CEO_NMK, TR_FG_NM, TR_FG, JIRO_CD, TR_NM, TR_NMK, JEONJA_YN, LIQ_RS, EMAIL, INTER_DT, TRCHARGE_EMAIL, INTER_RT */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguPartnerInfoI_Select_01( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(iCUBE G20) */
	public ResultVO getAnguG20BankInfoI_Select_01 ( ResultVO result ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SBANK_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'DUMMY3 = ''1''' */
		/* return : DUZON_BANK_CODE, BANK_NM, BANK_NMK */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguG20BankInfoI_Select_01( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(e나라도움) */
	public ResultVO getAnguG20BankInfoI_Select_02 ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_BANK_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BANK_CD=N'050' */
		/* BCNC_BANK_CODE, BANK_NM */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguG20BankInfoI_Select_02( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 계좌 */
	public ResultVO getAnguPartnerInfoI_Select_02 ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_STRADE_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@TR_CD=N'10005',@JIRO_CD=N'030',@TR_FG=N'1' */
		/* return : DEPOSITOR, REG_NB, ADDR, TEL, BANK_CD, BANK_NM */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguPartnerInfoI_Select_02( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 보조비목세목 */
	public ResultVO getAnguBimokInfoI_Select ( ResultVO result ) throws Exception {
		/* [프로시저 미사용] EXEC USP_ANGU300_ASSTN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20171008',@MOSF_GISU_SQ=1,@FSYR=N'2017' */
		/* ASSTN_EXPITM_TAXITM_CODE, ASSTN_EXPITM_NM, ASSTN_TAXITM_NM */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguBimokInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 재원구분 */
	public ResultVO getAnguJaewonInfoI_Select ( ResultVO result ) throws Exception {
		/* [프로시저 미사용] EXEC USP_ANGU300_ANBOJO_B_CMMN_CODE_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20171008',@MOSF_GISU_SQ=1,@MOSF_BG_SQ=1 */
		/* return : anguJaewonDivCode, anguJaewonDivName */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguJaewonInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행 금액 조회 */
	public ResultVO getAnguResultAmtInfoI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_RESULTERP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@DDTLBZ_ID=N'20170125000000000787',@ASSTN_TAXITM_CODE=N'11003',@FNRSC_SE_CODE=N'001' */
		/* return : excutPlanAmount, excutAmount, sumAmount, sum, sub */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguResultAmtInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setaData( new HashMap<String, Object>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setaData( new HashMap<String, Object>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 프로젝트 조회 */
	public ResultVO getAnguProjectInfoI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_MGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		/* return : MGT_CD, PJT_NM, TR_CD, TR_NM */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguProjectInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 예산과목 조회 */
	public ResultVO getAnguBgtInfoI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* EXEC USP_ANGU300_BGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@ASSTN_TAXITM_CODE=N'11003' */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231',@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* return : BGT01_CD, BGT01_NM, BGT01_NMK, BGT02_CD, BGT02_NM, BGT02_NMK, BGT03_CD, BGT03_NM, BGT03_NMK, BGT04_CD, BGT04_NM, BGT04_NMK, BGT_CD, BGT_NM, BGT_NMK, DIV_FG, GROUP_CD, GROUP_NM, GROUP_NMK, HBGT_CD, USE_YN, CTL_FG, DUMMY1, DUMMY2, TO_DT, CARR_YN, DRCR_FG, GR_FG, HBGT_CD1, HBGT_CD2, HBGT_CD3, CP_YN, SYS_CD, LAST_YN2, BIZ_FG, LEVEL01_CD, LEVEL02_CD, LEVEL03_CD, LEVEL04_CD, LEVEL05_CD, LEVEL06_CD, LEVEL01_NM, LEVEL02_NM, LEVEL03_NM, LEVEL04_NM, LEVEL05_NM, LEVEL06_NM, LEVEL01_NMK, LEVEL02_NMK, LEVEL03_NMK, LEVEL04_NMK, LEVEL05_NMK, LEVEL06_NMK */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguBgtInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 금융거래처 조회 */
	public ResultVO getAnguBankPartnerInfoI_Select ( ResultVO result ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5''' */
		/* return : TR_CD, ATTR_NM, ATTR_NMK, REG_NB, BA_NB, CEO_NM, CEO_NMK, TR_FG_NM, TR_FG, JIRO_CD, TR_NM, TR_NMK, JEONJA_YN, LIQ_RS, EMAIL, INTER_DT, TRCHARGE_EMAIL, INTER_RT */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result.setParams( CommonConvert.CommonSetMapCopy( CommonConvert.CommonGetEmpInfo( ), result.getParams( ) ) );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getParams( ).get( commonCode.COMPSEQ ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr( (ErpUtil.Chk_G20( conVo, result )).getResultCode( ) ).equals( commonCode.SUCCESS ) ) {
				/* 정보 조회 */
				result = AnguCode.getAnguBankPartnerInfoI_Select( conVo, result );
				if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.SUCCESS ) ) {
					result.setSuccess( );
				}
				else {
					result.setAaData( new ArrayList<Map<String, Object>>( ) );
					result.setFail( "" );
				}
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setAaData( new ArrayList<Map<String, Object>>( ) );
			result.setFail( e.toString( ) );
		}
		return result;
	}
	/* ## [-] 국고보조 v2 ## */

	/* 코드 - 국고보조사업 */
	public ResultVO DdtlbzInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_DDTLBZ_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.DdtlbzInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 이체계좌구분 */
	public ResultVO TransfracnutseInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'1089' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.TransfracnutseInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 자계좌이체사유코드 */
	public ResultVO SbsacnttrfrsnInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'0665' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.SbsacnttrfrsnInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 증빙승인번호 - 카드 */
	public ResultVO PrufsenoCardS ( ResultVO result ) throws Exception {
		/* 국고보조사업 귀속 카드 >> exec USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.PrufsenoInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 증빙승인번호 */
	public ResultVO PrufsenoInfoS ( ResultVO result ) throws Exception {
		/* 전자세금계산서 >> exec USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'1',@FR_DT=N'20160101',@TO_DT=N'20170520',@TAX_TY=N'2',@ETAX_TY=N'',@TR_CD=N'1000|',@DDTLBZ_ID=N'TEST-00001',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* 카드거래 >> exec USP_ANGU300_CARDINFO_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CONFM_DE_FR=N'20160101',@CONFM_DE_TO=N'20170520',@CARD_NO=N'1234123412341234',@MRHST_NM=N'',@PUCHAS_TAMT=0,@DDTLBZ_ID=N'TEST-00001',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.PrufsenoInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 코드 */
	public ResultVO TrInfoS ( ResultVO result ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=NULL */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.TrInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 금융기관 */
	public ResultVO BcncbankInfoS ( ResultVO result ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SBANK_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'DUMMY3 = ''1''' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.BcncbankInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 보조비목세목코드 */
	public ResultVO AsstntaxitmInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_ASSTN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20170515',@MOSF_GISU_SQ=1,@FSYR=N'2017' */
		/* DDTLBZ_ID, BSNSYEAR */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.AsstntaxitmInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 재원구분 */
	public ResultVO FnrscseInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_ANBOJO_B_CMMN_CODE_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20170515',@MOSF_GISU_SQ=1,@MOSF_BG_SQ=1 */
		/* DDTLBZ_ID, BSNSYEAR, ASSTN_TAXITM_CODE */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.FnrscseInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 프로젝트 */
	public ResultVO MgtInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_MGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'TEST-00001' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.MgtInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 에산과목 레벨 */
	public ResultVO AbgtLevelInfoS ( ResultVO result ) throws Exception {
		/* exec USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.AbgtLevelInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 예산과목 */
	public ResultVO AbgtInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_BGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@ASSTN_TAXITM_CODE=N'11001' */
		/* exec USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=2,@FR_DT=N'20170101',@TO_DT=N'20171231',@GR_FG=N'2',@DIV_CDS=N'',@MGT_CDS=N'',@BOTTOM_CDS=N'',@BGT_CD=NULL,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'1',@OPT_03=N'1',@BGT_FR_DT=N'20170101',@GROUP_CD=N'' */
		/* exec USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.AbgtInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 코드 */
	public ResultVO BtrInfoS ( ResultVO result ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5''' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.BtrInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 금액집계 */
	public ResultVO AmountInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_RESULTERP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@DDTLBZ_ID=N'TEST-00001',@ASSTN_TAXITM_CODE=N'11001',@FNRSC_SE_CODE=N'001' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.AmountInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 인력정보등록 - 코드 */
	public ResultVO HpmeticInfoS ( ResultVO result ) throws Exception {
		/* exec USP_ANGU300_HPMETIC_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BASE_DT=N'20170516' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				/* 프로세스 진행 */
				result = AnguCode.HpmeticInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 인력정보등록 - 소득구분 */
	public ResultVO PayTpInfoS ( ResultVO result ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SCTRL_D_CODE',@P_CO_CD=N'3585',@P_CODE=N'',@P_CODE2=N'',@P_CODE3=N'',@P_USE_YN=N'1',@P_NAME=N'',@P_STD_DT=N'',@P_WHERE=N'CTRL_CD = ''G'' AND MODULE_CD = ''H'' AND CTD_CD IN(''60'', ''62'', ''63'', ''68'', ''71'', ''72'', ''73'', ''74'', ''75'', ''76'')' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result = AnguCode.PayTpInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 카드 */
	public ResultVO CardInfoS ( ResultVO result ) throws Exception {
		/* 국고보조사업 귀속 카드 >> exec USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result = AnguCode.CardInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 연동 거래처 정보 조회 */
	public ResultVO LinkPartnerInfoS ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result = AnguCode.LinkPartnerInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 연동 금융 거래처 정보 조회 */
	public ResultVO LinkBankInfoS ( ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			ConnectionVO conVo = new ConnectionVO( );
			/* 기본값 정의 */
			result = (ResultVO) CommonConvert.CommonGetMapToObject( CommonConvert.CommonGetEmpInfo( ), result );
			conVo = cmInfo.CommonGetConnectionInfo( CommonConvert.CommonGetStr( result.getCompSeq( ) ) );
			/* ERP 연동 확인 */
			if ( CommonConvert.CommonGetStr(AnguCommon.AnCommonCheck( conVo, result ).getResultCode( )).equals( commonCode.SUCCESS ) ) {
				result = AnguCode.LinkBankInfoS( result, conVo );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}
}
