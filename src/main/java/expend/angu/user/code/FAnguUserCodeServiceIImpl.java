/**
  * @FileName : FAnguUserCodeServiceIImpl.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.code;

//import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

//import cmm.util.ErpUtil;
import cmm.util.MapUtil;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;
import common.vo.common.ConnectionVO;
import common.vo.common.ResultVO;
import expend.angu.user.common.BAnUserCommonService;


/**
 *   * @FileName : FAnguUserCodeServiceIImpl.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Service ( "FAnguUserCodeServiceI" )
public class FAnguUserCodeServiceIImpl implements FAnguUserCodeService {

	/* 변수정의 */
	@Resource ( name = "BAnUserCommonService" )
	private BAnUserCommonService AnguCommon; /* 국고보조 전용 공통 */
	@Resource ( name = "FAnguUserCodeServiceIDAO" )
	private FAnguUserCodeServiceIDAO dao; /* 국고보조 전용 공통 */

	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - ERP 사원정보 및 기수정보 조회 */
	public ResultVO getEmpInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* return : erpCompSeq, erpCompName, erpCompFrDate, erpCompToDate, erpCompGisu, erpBizSeq, erpBizName, erpSectSeq, erpSectName, erpDeptSeq, erpDeptName, erpEmpSeq, erpEmpName */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "erpCompSeq", "Y", "erpEmpSeq", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setaData( dao.getEmpInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - ERP 통장표시내용 환경 설정 */
	public ResultVO getAnguTermInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* return : CO_CD, BOJO_RMK, TR_RMK */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setaData( dao.getAnguTermInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - ERP 국고보조사업 조회 */
	public ResultVO getAnguBusinessInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* exec USP_ANGU300_DDTLBZ_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017' */
		/* return : anguBusinessCode, anguBusinessName */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "BSNSYEAR", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguBusinessInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 이체계좌구분 */
	public ResultVO getAnguAccountDivInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'1089' */
		/* return : anguAccountDivCode, anguAccountDivName */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "CMMN_CODE", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguAccountDivInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 자계좌이체사유코드 */
	public ResultVO getAnguAccountReasonDivInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'0665' */
		/* return : anguAccountReasonDivCode, anguAccountReasonDivName */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "CMMN_CODE", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguAccountReasonDivInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(과세) */
	public ResultVO getAnguEtaxTaxInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'2',@FR_DT=N'20170101',@TO_DT=N'20170921',@TAX_TY=N'2',@ETAX_TY=N'',@TR_CD=N'10000|',@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : anguEtaxTaxNum, CO_CD, DIV_CD, DIV_NM, anguEtaxTaxWriteDate, TAX_TY, anguEtaxTaxIssueDate, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNum, anguEtaxTaxAmt, anguEtaxTaxVat, anguEtaxTaxReqAmt, DIVCEO_NM, anguEtaxTaxDiv, TR_CD, BCNC_CMPNY_NM, DUZON_BANK_CODE, BCNC_ACNUT_NO, BCNC_ADRES, BCNC_RPRSNTY_NM, BCNC_TELNO, BCNC_BANK_CODE, BANK_NM, anguEtaxTaxUsedAmt, anguEtaxTaxNotUsedAmt, SUP_M_SPLPC, VAT_M_VAT, SEND_YN */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "DT_FG", "Y", "FR_DT", "Y", "TO_DT", "Y", "ETAX_TY", "N", "TR_CD", "N", "DDTLBZ_ID", "Y", "TASC_CMMN_DETAIL_CODE_NM", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguEtaxTaxInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(면세) */
	public ResultVO getAnguEtaxTaxFreeInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'1',@FR_DT=N'20170101',@TO_DT=N'20171007',@TAX_TY=N'4',@ETAX_TY=N'',@TR_CD=N'',@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : anguEtaxTaxNum, CO_CD, DIV_CD, DIV_NM, anguEtaxTaxWriteDate, TAX_TY, anguEtaxTaxIssueDate, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNum, anguEtaxTaxAmt, anguEtaxTaxVat, anguEtaxTaxReqAmt, DIVCEO_NM, anguEtaxTaxDiv, TR_CD, BCNC_CMPNY_NM, DUZON_BANK_CODE, BCNC_ACNUT_NO, BCNC_ADRES, BCNC_RPRSNTY_NM, BCNC_TELNO, BCNC_BANK_CODE, BANK_NM, anguEtaxTaxUsedAmt, anguEtaxTaxNotUsedAmt, SUP_M_SPLPC, VAT_M_VAT, SEND_YN */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "DT_FG", "Y", "FR_DT", "Y", "TO_DT", "Y", "ETAX_TY", "N", "TR_CD", "N", "DDTLBZ_ID", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguEtaxTaxFreeInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 */
	public ResultVO getAnguCardAuthI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		/* return : CTR_CD, TR_NM, BA_NB */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "DDTLBZ_ID", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguCardAuthI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 승인 내역 */
	public ResultVO getAnguCardInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_CARDINFO_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CONFM_DE_FR=N'20170101',@CONFM_DE_TO=N'20171122',@CARD_NO=N'5525764197210327',@MRHST_NM=N'',@PUCHAS_TAMT=0,@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : confmDe, mrhstNm, mrbcrbRegistNo, splpc, vat, puchasTamt, puchasTkbakNo, puchasDe, bcncLsftNo, bcncRprsntvNm, bcncTelNo, trNm, ctrCd, cardNo, bcncBankCode, bankNm, trCd, bcncCmpnyNm, ceoNm, tel, duzonBankCode, bcncAcnutNo, bcncAdres, bcncAdres2, excutSumAmount, am, sumMSplpc, vatMVat */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "CONFM_DE_FR", "Y", "CONFM_DE_TO", "Y", "CARD_NO", "Y", "MRHST_NM", "N", "PUCHAS_TAMT", "Y", "DDTLBZ_ID", "Y", "TASC_CMMN_DETAIL_CODE_NM", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguCardInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 사원 */
	public ResultVO getAnguEmpInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "erpCompSeq", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguEmpInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 */
	public ResultVO getAnguPartnerInfoI_Select_01 ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=NULL */
		/* return : anguEtaxPartnerCode, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNameKr, anguEtaxTaxPartnerNum, BCNC_ACNUT_NO, BCNC_RPRSNTY_NM, CEO_NMK, TR_FG_NM, TR_FG, JIRO_CD, TR_NM, TR_NMK, JEONJA_YN, LIQ_RS, EMAIL, INTER_DT, TRCHARGE_EMAIL, INTER_RT */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			param.put( "P_HELP_TY", "STRADE_CODE" );
			param.put( "P_USE_YN", "1" );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "P_HELP_TY", "Y", "P_CO_CD", "Y", "P_USE_YN", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguPartnerInfoI_Select_01( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 계좌 */
	public ResultVO getAnguPartnerInfoI_Select_02 ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_STRADE_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@TR_CD=N'10005',@JIRO_CD=N'030',@TR_FG=N'1' */
		/* return : DEPOSITOR, REG_NB, ADDR, TEL, BANK_CD, BANK_NM */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "TR_CD", "Y", "JIRO_CD", "Y", "TR_FG", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setaData( dao.getAnguPartnerInfoI_Select_02( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(iCUBE G20) */
	public ResultVO getAnguG20BankInfoI_Select_01 ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SBANK_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'DUMMY3 = ''1''' */
		/* return : DUZON_BANK_CODE, BANK_NM, BANK_NMK */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			param.put( "P_HELP_TY", "SBANK_CODE" );
			param.put( "P_WHERE", "DUMMY3 = '1'" );
			param.put( "P_CODE", "" );
			param.put( "P_CODE2", "" );
			param.put( "P_CODE3", "" );
			param.put( "P_USE_YN", "" );
			param.put( "P_NAME", "" );
			param.put( "P_STD_DT", "" );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "P_HELP_TY", "Y", "P_CO_CD", "Y", "P_CODE", "N", "P_CODE2", "N", "P_CODE3", "N", "P_USE_YN", "N", "P_NAME", "N", "P_STD_DT", "N", "P_WHERE", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguG20BankInfoI_Select_01( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(e나라도움) */
	public ResultVO getAnguG20BankInfoI_Select_02 ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_BANK_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BANK_CD=N'050' */
		/* BCNC_BANK_CODE, BANK_NM */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "BANK_CD", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setaData( dao.getAnguG20BankInfoI_Select_02( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 보조비목세목 */
	public ResultVO getAnguBimokInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* [프로시저 미사용] EXEC USP_ANGU300_ASSTN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20171008',@MOSF_GISU_SQ=1,@FSYR=N'2017' */
		/* ASSTN_EXPITM_TAXITM_CODE, ASSTN_EXPITM_NM, ASSTN_TAXITM_NM */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "BSNSYEAR", "Y", "FSYR", "Y", "DDTLBZ_ID", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguBimokInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 재원구분 */
	public ResultVO getAnguJaewonInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* [프로시저 미사용] EXEC USP_ANGU300_ANBOJO_B_CMMN_CODE_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20171008',@MOSF_GISU_SQ=1,@MOSF_BG_SQ=1 */
		/* return : anguJaewonDivCode, anguJaewonDivName */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "DDTLBZ_ID", "Y", "BSNSYEAR", "Y", "ASSTN_TAXITM_CODE", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguJaewonInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행 금액 조회 */
	public ResultVO getAnguResultAmtInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_RESULTERP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@DDTLBZ_ID=N'20170125000000000787',@ASSTN_TAXITM_CODE=N'11003',@FNRSC_SE_CODE=N'001' */
		/* return : excutPlanAmount, excutAmount, sumAmount, sum, sub */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "BSNSYEAR", "Y", "DDTLBZ_ID", "Y", "ASSTN_TAXITM_CODE", "Y", "FNRSC_SE_CODE", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setaData( dao.getAnguResultAmtInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 프로젝트 조회 */
	public ResultVO getAnguProjectInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_ANGU300_MGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		/* return : MGT_CD, PJT_NM, TR_CD, TR_NM */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "DDTLBZ_ID", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguProjectInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 예산과목 조회 */
	public ResultVO getAnguBgtInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* EXEC USP_ANGU300_BGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@ASSTN_TAXITM_CODE=N'11003' */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231',@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* return : BGT01_CD, BGT01_NM, BGT01_NMK, BGT02_CD, BGT02_NM, BGT02_NMK, BGT03_CD, BGT03_NM, BGT03_NMK, BGT04_CD, BGT04_NM, BGT04_NMK, BGT_CD, BGT_NM, BGT_NMK, DIV_FG, GROUP_CD, GROUP_NM, GROUP_NMK, HBGT_CD, USE_YN, CTL_FG, DUMMY1, DUMMY2, TO_DT, CARR_YN, DRCR_FG, GR_FG, HBGT_CD1, HBGT_CD2, HBGT_CD3, CP_YN, SYS_CD, LAST_YN2, BIZ_FG, LEVEL01_CD, LEVEL02_CD, LEVEL03_CD, LEVEL04_CD, LEVEL05_CD, LEVEL06_CD, LEVEL01_NM, LEVEL02_NM, LEVEL03_NM, LEVEL04_NM, LEVEL05_NM, LEVEL06_NM, LEVEL01_NMK, LEVEL02_NMK, LEVEL03_NMK, LEVEL04_NMK, LEVEL05_NMK, LEVEL06_NMK */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "CO_CD", "Y", "GISU", "Y", "FR_DT", "Y", "TO_DT", "Y", "GR_FG", "Y", "DIV_CDS", "Y", "MGT_CDS", "Y", "BOTTOM_CDS", "N", "BGT_CD", "N", "BGT_NM", "N", "OPT_01", "Y", "OPT_02", "Y", "OPT_03", "Y", "BGT_FR_DT", "Y", "GROUP_CD", "N" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguBgtInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 금융거래처 조회 */
	public ResultVO getAnguBankPartnerInfoI_Select ( ConnectionVO conVo, ResultVO result ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5''' */
		/* return : TR_CD, ATTR_NM, ATTR_NMK, REG_NB, BA_NB, CEO_NM, CEO_NMK, TR_FG_NM, TR_FG, JIRO_CD, TR_NM, TR_NMK, JEONJA_YN, LIQ_RS, EMAIL, INTER_DT, TRCHARGE_EMAIL, INTER_RT */
		try {
			/* 변수정의 */
			boolean chkParameter = true;
			Map<String, Object> param = new HashMap<String, Object>( );
			/* 기본값 정의 */
			param = result.getParams( );
			param.put( "P_HELP_TY", "STRADE_CODE" );
			param.put( "P_USE_YN", "1" );
			param.put( "P_WHERE", "TR_FG >= '5'" );
			/* 필수 파라미터 검증 */
			String[] parametersCheck = { "LANGKIND", "Y", "P_HELP_TY", "Y", "P_CO_CD", "Y", "P_CODE", "N", "P_CODE2", "N", "P_CODE3", "N", "P_USE_YN", "Y", "P_NAME", "N", "P_STD_DT", "N", "P_WHERE", "Y" };
			if ( !MapUtil.hasParameters( param, parametersCheck ) ) {
				result.setFail( "필수 입력 정보가 누락되었습니다." );
				chkParameter = false;
			}
			/* 데이터 조회 */
			if ( chkParameter ) {
				result.setAaData( dao.getAnguBankPartnerInfoI_Select( conVo, param ) );
				result.setSuccess( );
			}
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setFail( e.toString( ) );
		}
		return result;
	}
	/* ## [-] 국고보조 v2 ## */

	/* 코드 - 국고보조사업 */
	public ResultVO DdtlbzInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_DDTLBZ_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "BSNSYEAR" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.DdtlbzInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 이체계좌구분 */
	public ResultVO TransfracnutseInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'1089' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "CMMN_CODE", "1089" );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CMMN_CODE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.TransfracnutseInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 자계좌이체사유코드 */
	public ResultVO SbsacnttrfrsnInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'0665' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "CMMN_CODE", "0665" );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CMMN_CODE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.TransfracnutseInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 증빙승인번호 - 카드 */
	public ResultVO PrufsenoCardS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* 국고보조사업 귀속 카드 >> exec USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.PrufsenoCardS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* 코드 - 증빙승인번호 */
	public ResultVO PrufsenoInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* 전자세금계산서 >> exec USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'1',@FR_DT=N'20160101',@TO_DT=N'20170520',@TAX_TY=N'2',@ETAX_TY=N'',@TR_CD=N'1000|',@DDTLBZ_ID=N'TEST-00001',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* 카드거래 >> exec USP_ANGU300_CARDINFO_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CONFM_DE_FR=N'20160101',@CONFM_DE_TO=N'20170520',@CARD_NO=N'1234123412341234',@MRHST_NM=N'',@PUCHAS_TAMT=0,@DDTLBZ_ID=N'TEST-00001',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			String prufseCode = CommonConvert.CommonGetStr( params.get( "prufseCode" ) );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			switch ( prufseCode ) {
				case "001":
				case "002":
					/* 기본값 정의 */
					/* 파라미터 검증 */
					result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "DT_FG" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "FR_DT" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "TO_DT" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "TAX_TY" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "TR_CD" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "TASC_CMMN_DETAIL_CODE_NM" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					/* 데이터 조회 */
					result.setAaData( dao.PrufsenoETaxInfoS( params, conVo ) );
					break;
				case "004":
					/* 기본값 정의 */
					/* 파라미터 검증 */
					result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "CONFM_DE_FR" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "CONFM_DE_TO" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "CARD_NO" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "PUCHAS_TAMT" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					else {
						params.put( "PUCHAS_TAMT", CommonConvert.CommonGetDouble( params.get( "PUCHAS_TAMT" ) ) );
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "TASC_CMMN_DETAIL_CODE_NM" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					result = AnguCommon.AnCommonCheckParam( result, params, "TASC_CMMN_DETAIL_CODE_NM" );
					if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
						return result;
					}
					/* 데이터 조회 */
					result.setAaData( dao.PrufsenoCardInfoS( params, conVo ) );
					break;
				default:
					result.setResultCode( commonCode.FAIL );
					result.setResultName( "증빙구분값이 잘못 정의되었습니다." );
					break;
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
	public ResultVO TrInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=NULL */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "P_HELP_TY", "STRADE_CODE" );
			params.put( "P_CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "P_CODE", "" );
			params.put( "P_CODE2", "" );
			params.put( "P_CODE3", "" );
			params.put( "P_USE_YN", "1" );
			params.put( "P_NAME", "" );
			params.put( "P_STD_DT", "" );
			params.put( "P_WHERE", "ISNULL(TR_CD, '') LIKE '%' + ISNULL('" + CommonConvert.CommonGetStr( params.get( "searchStr" ) ) + "', '') + '%' OR ISNULL(ATTR_NM, '') LIKE '%' + ISNULL('" + CommonConvert.CommonGetStr( params.get( "searchStr" ) ) + "', '') + '%' OR ISNULL(TR_NM, '') LIKE '%' + ISNULL('" + CommonConvert.CommonGetStr( params.get( "searchStr" ) ) + "', '') + '%' OR ISNULL(REG_NB, '') LIKE '%' + ISNULL('" + CommonConvert.CommonGetStr( params.get( "searchStr" ) ) + "', '') + '%'" );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_HELP_TY" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_USE_YN" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.TrInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 금융기관 */
	public ResultVO BcncbankInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SBANK_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'DUMMY3 = ''1''' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "P_HELP_TY", "SBANK_CODE" );
			params.put( "P_CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "P_CODE", "" );
			params.put( "P_CODE2", "" );
			params.put( "P_CODE3", "" );
			params.put( "P_USE_YN", "1" );
			params.put( "P_NAME", "" );
			params.put( "P_STD_DT", "" );
			params.put( "P_WHERE", "DUMMY3 = '1'" );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_HELP_TY" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_USE_YN" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_WHERE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.BcncbankInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 보조비목세목코드 */
	public ResultVO AsstntaxitmInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_ASSTN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20170515',@MOSF_GISU_SQ=1,@FSYR=N'2017' */
		/* DDTLBZ_ID, BSNSYEAR */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "BSNSYEAR" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "FSYR" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.AsstntaxitmInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 재원구분 */
	public ResultVO FnrscseInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_ANBOJO_B_CMMN_CODE_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20170515',@MOSF_GISU_SQ=1,@MOSF_BG_SQ=1 */
		/* DDTLBZ_ID, BSNSYEAR, ASSTN_TAXITM_CODE */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "BSNSYEAR" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "ASSTN_TAXITM_CODE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.FnrscseInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 프로젝트 */
	public ResultVO MgtInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_MGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'TEST-00001' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.MgtInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 에산과목 레벨 */
	public ResultVO AbgtLevelInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 - 예산과목 레벨 */
			result.setAaData( dao.AbgtLevelInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
		}
		return result;
	}

	/* 코드 - 예산과목 */
	public ResultVO AbgtInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_BGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@ASSTN_TAXITM_CODE=N'11001' */
		/* exec USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=2,@FR_DT=N'20170101',@TO_DT=N'20171231',@GR_FG=N'2',@DIV_CDS=N'',@MGT_CDS=N'',@BOTTOM_CDS=N'',@BGT_CD=NULL,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'1',@OPT_03=N'1',@BGT_FR_DT=N'20170101',@GROUP_CD=N'' */
		/* exec USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		try {
			/* 변수정의 */
			String bgtCode = "";
			Map<String, Object> params = new HashMap<String, Object>( );
			Map<String, Object> aData = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "BSNSYEAR" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "ASSTN_TAXITM_CODE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "GISU" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			else {
				params.put( "GISU", CommonConvert.CommonGetDouble( params.get( "GISU" ) ) );
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "FR_DT" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "TO_DT" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "GR_FG" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "OPT_01" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "OPT_02" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "OPT_03" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "BGT_FR_DT" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 - 예산과목 레벨 */
			aData.put( "bgtLevel", dao.AbgtLevelInfoS( params, conVo ) );
			result.setaData( aData );
			/* 데이터 조회 - 귀속 예산과목 코드 */
			for ( Map<String, Object> map : dao.AbgtCodeInfoS( params, conVo ) ) {
				/* group by 를 iCUEB API 에서 제공하지 않으므로, 강제 group by 를 하기 위하여 문자열 조합 처리 */
				String bgtCd = "|" + CommonConvert.CommonGetStr( map.get( "BGT_CD" ) ) + "|";
				if ( !(bgtCode.contains( bgtCd )) ) {
					bgtCode += bgtCd;
				}
			}
			/* 데이터 조회 - 예산과목 코드 */
			for ( Map<String, Object> map : dao.AbgtInfoS( params, conVo ) ) {
				/* 귀속 예산과목 코드내 결과물만 표현하므로, 강제 where 를 하기 위하여 문자열 처리 */
				String bgtCd = "|" + CommonConvert.CommonGetStr( map.get( "BGT_CD" ) ) + "|";
				if ( bgtCode.contains( bgtCd ) ) {
					result.addAaData( map );
				}
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
	public ResultVO BtrInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5''' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "P_HELP_TY", "STRADE_CODE" );
			params.put( "P_CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "P_CODE", "" );
			params.put( "P_CODE2", "" );
			params.put( "P_CODE3", "" );
			params.put( "P_USE_YN", "1" );
			params.put( "P_STD_DT", "" );
			params.put( "P_STD_DT", "" );
			params.put( "P_WHERE", "TR_FG >= '5'" );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_HELP_TY" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_USE_YN" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_WHERE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.BtrInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 코드 - 금액집계 */
	public ResultVO AmountInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_RESULTERP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@DDTLBZ_ID=N'TEST-00001',@ASSTN_TAXITM_CODE=N'11001',@FNRSC_SE_CODE=N'001' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "BSNSYEAR" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "ASSTN_TAXITM_CODE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "FNRSC_SE_CODE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setaData( dao.AmountInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 인력정보등록 - 코드 */
	public ResultVO HpmeticInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_ANGU300_HPMETIC_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BASE_DT=N'20170516' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "BASE_DT" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.HpmeticInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 인력정보등록 - 소득구분 */
	public ResultVO PayTpInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SCTRL_D_CODE',@P_CO_CD=N'3585',@P_CODE=N'',@P_CODE2=N'',@P_CODE3=N'',@P_USE_YN=N'1',@P_NAME=N'',@P_STD_DT=N'',@P_WHERE=N'CTRL_CD = ''G'' AND MODULE_CD = ''H'' AND CTD_CD IN(''60'', ''62'', ''63'', ''68'', ''71'', ''72'', ''73'', ''74'', ''75'', ''76'')' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "P_HELP_TY", "SCTRL_D_CODE" );
			params.put( "P_CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "P_CODE", "" );
			params.put( "P_CODE2", "" );
			params.put( "P_CODE3", "" );
			params.put( "P_USE_YN", "1" );
			params.put( "P_NAME", "" );
			params.put( "P_STD_DT", "" );
			params.put( "P_WHERE", "CTRL_CD = 'G' AND MODULE_CD = 'H' AND CTD_CD IN('60', '62', '63', '68', '71', '72', '73', '74', '75', '76')" );
			result.setParams( params );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_HELP_TY" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_USE_YN" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_HELP_TY" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.PayTpInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 카드 */
	public ResultVO CardInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		/* 국고보조사업 귀속 카드 >> exec USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "DDTLBZ_ID" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setAaData( dao.CardInfoS( params, conVo ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 연동 거래처 정보 조회 */
	public ResultVO LinkPartnerInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			Map<String, Object> partnerInfo = new HashMap<String, Object>( );
			Map<String, Object> bankInfo = new HashMap<String, Object>( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "P_HELP_TY", "STRADE_CODE" );
			params.put( "P_CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "P_CODE", "" );
			params.put( "P_CODE2", "" );
			params.put( "P_CODE3", "" );
			params.put( "P_USE_YN", "1" );
			params.put( "P_NAME", "" );
			params.put( "P_STD_DT", "" );
			params.put( "P_WHERE", " REG_NB=" + "'" + params.get( "regNb" ) + "'" );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_HELP_TY" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_USE_YN" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_WHERE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			/* 데이터 조회 - 거래처 */
			partnerInfo = dao.LinkPartnerInfoS( params, conVo );
			if ( partnerInfo == null ) {
				partnerInfo = new HashMap<String, Object>( );
			}
			result.getaData( ).put( "attrName", partnerInfo.get( "ATTR_NM" ) );
			result.getaData( ).put( "baNumber", partnerInfo.get( "BA_NB" ) );
			result.getaData( ).put( "ceoName", partnerInfo.get( "CEO_NM" ) );
			result.getaData( ).put( "interDt", partnerInfo.get( "INTER_DT" ) );
			result.getaData( ).put( "jeonjaYN", partnerInfo.get( "JEONJA_YN" ) );
			result.getaData( ).put( "jiroCode", partnerInfo.get( "JIRO_CD" ) );
			result.getaData( ).put( "liqRs", partnerInfo.get( "LIQ_RS" ) );
			result.getaData( ).put( "regNumber", partnerInfo.get( "REG_NB" ) );
			result.getaData( ).put( "trCode", partnerInfo.get( "TR_CD" ) );
			result.getaData( ).put( "trFgCode", partnerInfo.get( "TR_FG" ) );
			result.getaData( ).put( "trFgName", partnerInfo.get( "TR_FG_NM" ) );
			result.getaData( ).put( "trName", partnerInfo.get( "TR_NM" ) );
			result.getaData( ).put( "trNameKr", partnerInfo.get( "TR_NM" ) );
			/* 데이터 조회 - 은행 */
			params.put( "bankCode", partnerInfo.get( "JIRO_CD" ) );
			params.put( "LANGKIND", "KOR" );
			params.put( "P_HELP_TY", "SBANK_CODE" );
			params.put( "P_CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "P_CODE", "" );
			params.put( "P_CODE2", "" );
			params.put( "P_CODE3", "" );
			params.put( "P_NAME", "" );
			params.put( "P_STD_DT", "" );
			params.put( "P_WHERE", " DUMMY3 = '1' AND BANK_CD = '" + params.get( "bankCode" ) + "' " );
			bankInfo = dao.LinkBankInfoS( params, conVo );
			if ( bankInfo == null ) {
				bankInfo = new HashMap<String, Object>( );
			}
			result.getaData( ).put( "bankCode", bankInfo.get( "BANK_CD" ) );
			result.getaData( ).put( "bankName", bankInfo.get( "BANK_NM" ) );
			result.getaData( ).put( "bankNameKr", bankInfo.get( "BANK_NMK" ) );
			return result;
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}

	/* 연동 금융 거래처 정보 조회 */
	public ResultVO LinkBankInfoS ( ResultVO result, ConnectionVO conVo ) throws Exception {
		try {
			/* 변수정의 */
			Map<String, Object> params = new HashMap<String, Object>( );
			params = (Map<String, Object>) result.getParams( );
			/* 기본값 정의 */
			params.put( "LANGKIND", "KOR" );
			params.put( "P_HELP_TY", "SBANK_CODE" );
			params.put( "P_CO_CD", CommonConvert.CommonGetStr( result.getErpCompSeq( ) ) );
			params.put( "P_CODE", "" );
			params.put( "P_CODE2", "" );
			params.put( "P_CODE3", "" );
			params.put( "P_NAME", "" );
			params.put( "P_STD_DT", "" );
			params.put( "P_WHERE", " DUMMY3 = '1' AND BANK_CD = '" + params.get( "bankCode" ) + "' " );
			/* 파라미터 검증 */
			result = AnguCommon.AnCommonCheckParam( result, params, "LANGKIND" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_HELP_TY" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_CO_CD" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			result = AnguCommon.AnCommonCheckParam( result, params, "P_WHERE" );
			if ( CommonConvert.CommonGetStr(result.getResultCode( )).equals( commonCode.FAIL ) ) {
				return result;
			}
			/* 데이터 조회 */
			result.setaData( dao.LinkPartnerInfoS( params, conVo ) );
			result.getaData( ).put( "bankCode", result.getaData( ).get( "BANK_CD" ) );
			result.getaData( ).put( "bankName", result.getaData( ).get( "BANK_NM" ) );
			result.getaData( ).put( "bankNameKr", result.getaData( ).get( "BANK_NMK" ) );
		}
		catch ( Exception e ) {
			// TODO: handle exception
			result.setResultCode( commonCode.FAIL );
			result.setResultName( e.getMessage( ) );
		}
		return result;
	}
}
