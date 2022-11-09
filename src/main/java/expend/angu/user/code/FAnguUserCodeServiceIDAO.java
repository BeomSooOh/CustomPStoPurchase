/**
  * @FileName : FAnguUserCodeServiceIDAO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package expend.angu.user.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import common.helper.connection.CommonAnConnect;
import common.vo.common.ConnectionVO;


/**
 *   * @FileName : FAnguUserCodeServiceIDAO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@Repository ( "FAnguUserCodeServiceIDAO" )
public class FAnguUserCodeServiceIDAO {

	/* 변수정의 */
	CommonAnConnect connector = new CommonAnConnect( );

	/* ## [+] 국고보조 v2 ## */
	/* ## [+] 국고보조 v2 ## - ERP 사원정보 및 기수정보 조회 */
	public Map<String, Object> getEmpInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) {
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.getEmpInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - ERP 통장표시내용 환경 설정 */
	public Map<String, Object> getAnguTermInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) {
		/* EXEC USP_ANGU300_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* return : CO_CD, BOJO_RMK, TR_RMK */
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.getAnguTermInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - ERP 국고보조사업 조회 */
	public List<Map<String, Object>> getAnguBusinessInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* exec USP_ANGU300_DDTLBZ_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017' */
		/* return : anguBusinessCode, anguBusinessName */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguBusinessInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 이체계좌구분 */
	public List<Map<String, Object>> getAnguAccountDivInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'1089' */
		/* return : anguAccountDivCode, anguAccountDivName */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguAccountDivInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 자계좌이체사유 */
	public List<Map<String, Object>> getAnguAccountReasonDivInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'0665' */
		/* return : anguAccountReasonDivCode, anguAccountReasonDivName */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguAccountReasonDivInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(과세) */
	public List<Map<String, Object>> getAnguEtaxTaxInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'2',@FR_DT=N'20170101',@TO_DT=N'20170921',@TAX_TY=N'2',@ETAX_TY=N'',@TR_CD=N'10000|',@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : anguEtaxTaxNum, CO_CD, DIV_CD, DIV_NM, anguEtaxTaxWriteDate, TAX_TY, anguEtaxTaxIssueDate, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNum, anguEtaxTaxAmt, anguEtaxTaxVat, anguEtaxTaxReqAmt, DIVCEO_NM, anguEtaxTaxDiv, TR_CD, BCNC_CMPNY_NM, DUZON_BANK_CODE, BCNC_ACNUT_NO, BCNC_ADRES, BCNC_RPRSNTY_NM, BCNC_TELNO, BCNC_BANK_CODE, BANK_NM, anguEtaxTaxUsedAmt, anguEtaxTaxNotUsedAmt, SUP_M_SPLPC, VAT_M_VAT, SEND_YN */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguEtaxTaxInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 전자세금계산서(면세) */
	public List<Map<String, Object>> getAnguEtaxTaxFreeInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'1',@FR_DT=N'20170101',@TO_DT=N'20171007',@TAX_TY=N'4',@ETAX_TY=N'',@TR_CD=N'',@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : anguEtaxTaxNum, CO_CD, DIV_CD, DIV_NM, anguEtaxTaxWriteDate, TAX_TY, anguEtaxTaxIssueDate, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNum, anguEtaxTaxAmt, anguEtaxTaxVat, anguEtaxTaxReqAmt, DIVCEO_NM, anguEtaxTaxDiv, TR_CD, BCNC_CMPNY_NM, DUZON_BANK_CODE, BCNC_ACNUT_NO, BCNC_ADRES, BCNC_RPRSNTY_NM, BCNC_TELNO, BCNC_BANK_CODE, BANK_NM, anguEtaxTaxUsedAmt, anguEtaxTaxNotUsedAmt, SUP_M_SPLPC, VAT_M_VAT, SEND_YN */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguEtaxTaxFreeInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 */
	public List<Map<String, Object>> getAnguCardAuthI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		/* return : CTR_CD, TR_NM, BA_NB */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguCardAuthI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙승인번호 - 카드 승인 내역 */
	public List<Map<String, Object>> getAnguCardInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_ANGU300_CARDINFO_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CONFM_DE_FR=N'20170101',@CONFM_DE_TO=N'20171122',@CARD_NO=N'5525764197210327',@MRHST_NM=N'',@PUCHAS_TAMT=0,@DDTLBZ_ID=N'20170125000000000787',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		/* return : confmDe, mrhstNm, mrbcrbRegistNo, splpc, vat, puchasTamt, puchasTkbakNo, puchasDe, bcncLsftNo, bcncRprsntvNm, bcncTelNo, trNm, ctrCd, cardNo, bcncBankCode, bankNm, trCd, bcncCmpnyNm, ceoNm, tel, duzonBankCode, bcncAcnutNo, bcncAdres, bcncAdres2, excutSumAmount, am, sumMSplpc, vatMVat */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguCardInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 사원 */
	public List<Map<String, Object>> getAnguEmpInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguEmpInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 */
	public List<Map<String, Object>> getAnguPartnerInfoI_Select_01 ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=NULL */
		/* return : anguEtaxPartnerCode, anguEtaxTaxPartnerName, anguEtaxTaxPartnerNameKr, anguEtaxTaxPartnerNum, BCNC_ACNUT_NO, BCNC_RPRSNTY_NM, CEO_NMK, TR_FG_NM, TR_FG, JIRO_CD, TR_NM, TR_NMK, JEONJA_YN, LIQ_RS, EMAIL, INTER_DT, TRCHARGE_EMAIL, INTER_RT */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguPartnerInfoI_Select_01", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 거래처 계좌 */
	public Map<String, Object> getAnguPartnerInfoI_Select_02 ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_ANGU300_STRADE_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@TR_CD=N'10005',@JIRO_CD=N'030',@TR_FG=N'1' */
		/* return : DEPOSITOR, REG_NB, ADDR, TEL, BANK_CD, BANK_NM */
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.getAnguPartnerInfoI_Select_02", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(iCUBE G20) */
	public List<Map<String, Object>> getAnguG20BankInfoI_Select_01 ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SBANK_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'DUMMY3 = ''1''' */
		/* return : DUZON_BANK_CODE, BANK_NM, BANK_NMK */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguG20BankInfoI_Select_01", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 증빙 - 금융기관(e나라도움) */
	public Map<String, Object> getAnguG20BankInfoI_Select_02 ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_ANGU300_BANK_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BANK_CD=N'050' */
		/* BCNC_BANK_CODE, BANK_NM */
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.getAnguG20BankInfoI_Select_02", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 보조비목세목 */
	public List<Map<String, Object>> getAnguBimokInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* [프로시저 미사용] EXEC USP_ANGU300_ASSTN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20171008',@MOSF_GISU_SQ=1,@FSYR=N'2017' */
		/* return : ASSTN_EXPITM_TAXITM_CODE, ASSTN_EXPITM_NM, ASSTN_TAXITM_NM */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguBimokInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 재원구분 */
	public List<Map<String, Object>> getAnguJaewonInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* [프로시저 미사용] EXEC USP_ANGU300_ANBOJO_B_CMMN_CODE_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20171008',@MOSF_GISU_SQ=1,@MOSF_BG_SQ=1 */
		/* return : anguJaewonDivCode, anguJaewonDivName */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguJaewonInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 국고보조 집행 금액 조회 */
	public Map<String, Object> getAnguResultAmtInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_ANGU300_RESULTERP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@DDTLBZ_ID=N'20170125000000000787',@ASSTN_TAXITM_CODE=N'11003',@FNRSC_SE_CODE=N'001' */
		/* return : excutPlanAmount, excutAmount, sumAmount, sum, sub */
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.getAnguResultAmtInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 프로젝트 조회 */
	public List<Map<String, Object>> getAnguProjectInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_ANGU300_MGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		/* return : MGT_CD, PJT_NM, TR_CD, TR_NM */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguProjectInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 예산과목 조회 */
	public List<Map<String, Object>> getAnguBgtInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		/* EXEC USP_ANGU300_BGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@ASSTN_TAXITM_CODE=N'11003' */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231',@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* return : BGT01_CD, BGT01_NM, BGT01_NMK, BGT02_CD, BGT02_NM, BGT02_NMK, BGT03_CD, BGT03_NM, BGT03_NMK, BGT04_CD, BGT04_NM, BGT04_NMK, BGT_CD, BGT_NM, BGT_NMK, DIV_FG, GROUP_CD, GROUP_NM, GROUP_NMK, HBGT_CD, USE_YN, CTL_FG, DUMMY1, DUMMY2, TO_DT, CARR_YN, DRCR_FG, GR_FG, HBGT_CD1, HBGT_CD2, HBGT_CD3, CP_YN, SYS_CD, LAST_YN2, BIZ_FG, LEVEL01_CD, LEVEL02_CD, LEVEL03_CD, LEVEL04_CD, LEVEL05_CD, LEVEL06_CD, LEVEL01_NM, LEVEL02_NM, LEVEL03_NM, LEVEL04_NM, LEVEL05_NM, LEVEL06_NM, LEVEL01_NMK, LEVEL02_NMK, LEVEL03_NMK, LEVEL04_NMK, LEVEL05_NMK, LEVEL06_NMK */
		/* ############################################################################################################################################ */
		/* @LANGKIND=N'KOR' > 언어코드 */
		/* @CO_CD=N'3585' > 회사코드 */
		/* @GISU=3 > 작업기수 */
		/* @FR_DT=N'20180101' > 작업기수 시작일 */
		/* @TO_DT=N'20181231' > 작업기수 종료일 */
		/* @GR_FG=N'2' > 모르겠음. "2" 고정 가자! */
		/* @DIV_CDS=N'1000|' > 사업장코드 */
		/* @MGT_CDS=N'00001|' > 프로젝트코드 */
		/* @BOTTOM_CDS=N'' > 모르겠음. "공백" 고정 가자! */
		/* @BGT_CD=NULL > 부분검색 - 예산과목코드 */
		/* @BGT_NM=NULL > 부분검색 - 예산과목명 */
		/* @OPT_01=N'1' > 예산과목표시 ( 모든 예산과목 표시 : 1 / 당기 예산편성된 과목만 표시 : 2 / 프로젝트기간 예산편성된 과목만 표시 : 3 */
		/* @OPT_02=N'2' > 사용기한 ( 모두 표시 : 1 / 사용기한 경과분 숨김 : 2 ) */
		/* @OPT_03=N'1' > 상위과목표시 ( 모두 표시 : 1 / 최하위 표시 : 2 ) */
		/* @BGT_FR_DT=N'20180101' > 작업기수 시작일 */
		/* @GROUP_CD=N'' > 모르곘음. "공백" 고정 가자! */
		/* ############################################################################################################################################ */
		/* - 부분검색 */
		/* - 예산과목명 : "" */
		/* - 예산과목코드 : "" */
		/* - 예산과목표시 */
		/* - [V]모든 예산과목 표시 */
		/* - 당기 예산편성된 과목만 표시 */
		/* - 프로젝트기간 예산편성된 과목만 표시 */
		/* - 사용기한 */
		/* - 모두 표시 */
		/* - [V]사용기한 경과분 숨김 */
		/* - 상위과목표시 */
		/* - [V]모두 표시 */
		/* - 최하위 표시 */
		/* - 예산그룹표시 */
		/* - [V]표시 */
		/* - 숨김 */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231' */
		/* ,@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL */
		/* ,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* ############################################################################################################################################ */
		/* - 부분검색 */
		/* - 예산과목명 : "예산과목명" */
		/* - 예산과목코드 : "" */
		/* - 예산과목표시 */
		/* - [V]모든 예산과목 표시 */
		/* - 당기 예산편성된 과목만 표시 */
		/* - 프로젝트기간 예산편성된 과목만 표시 */
		/* - 사용기한 */
		/* - 모두 표시 */
		/* - [V]사용기한 경과분 숨김 */
		/* - 상위과목표시 */
		/* - [V]모두 표시 */
		/* - 최하위 표시 */
		/* - 예산그룹표시 */
		/* - [V]표시 */
		/* - 숨김 */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231' */
		/* ,@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL */
		/* ,@BGT_NM=N'예산과목명',@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* ############################################################################################################################################ */
		/* - 부분검색 */
		/* - 예산과목명 : "" */
		/* - 예산과목코드 : "예산과목코드" */
		/* - 예산과목표시 */
		/* - [V]모든 예산과목 표시 */
		/* - 당기 예산편성된 과목만 표시 */
		/* - 프로젝트기간 예산편성된 과목만 표시 */
		/* - 사용기한 */
		/* - 모두 표시 */
		/* - [V]사용기한 경과분 숨김 */
		/* - 상위과목표시 */
		/* - [V]모두 표시 */
		/* - 최하위 표시 */
		/* - 예산그룹표시 */
		/* - [V]표시 */
		/* - 숨김 */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231' */
		/* ,@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=N'예산과목코드' */
		/* ,@BGT_NM=N'',@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* ############################################################################################################################################ */
		/* - 부분검색 */
		/* - 예산과목명 : "" */
		/* - 예산과목코드 : "" */
		/* - 예산과목표시 */
		/* - 모든 예산과목 표시 */
		/* - [V]당기 예산편성된 과목만 표시 */
		/* - 프로젝트기간 예산편성된 과목만 표시 */
		/* - 사용기한 */
		/* - 모두 표시 */
		/* - [V]사용기한 경과분 숨김 */
		/* - 상위과목표시 */
		/* - [V]모두 표시 */
		/* - 최하위 표시 */
		/* - 예산그룹표시 */
		/* - [V]표시 */
		/* - 숨김 */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231' */
		/* ,@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL */
		/* ,@BGT_NM=NULL,@OPT_01=N'2',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* ############################################################################################################################################ */
		/* - 부분검색 */
		/* - 예산과목명 : "" */
		/* - 예산과목코드 : "" */
		/* - 예산과목표시 */
		/* - 모든 예산과목 표시 */
		/* - 당기 예산편성된 과목만 표시 */
		/* - [V]프로젝트기간 예산편성된 과목만 표시 */
		/* - 사용기한 */
		/* - 모두 표시 */
		/* - [V]사용기한 경과분 숨김 */
		/* - 상위과목표시 */
		/* - [V]모두 표시 */
		/* - 최하위 표시 */
		/* - 예산그룹표시 */
		/* - [V]표시 */
		/* - 숨김 */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231' */
		/* ,@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL */
		/* ,@BGT_NM=NULL,@OPT_01=N'3',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* ############################################################################################################################################ */
		/* - 부분검색 */
		/* - 예산과목명 : "" */
		/* - 예산과목코드 : "" */
		/* - 예산과목표시 */
		/* - [V]모든 예산과목 표시 */
		/* - 당기 예산편성된 과목만 표시 */
		/* - 프로젝트기간 예산편성된 과목만 표시 */
		/* - 사용기한 */
		/* - [V]모두 표시 */
		/* - 사용기한 경과분 숨김 */
		/* - 상위과목표시 */
		/* - [V]모두 표시 */
		/* - 최하위 표시 */
		/* - 예산그룹표시 */
		/* - [V]표시 */
		/* - 숨김 */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231' */
		/* ,@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL */
		/* ,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'1',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* ############################################################################################################################################ */
		/* - 부분검색 */
		/* - 예산과목명 : "" */
		/* - 예산과목코드 : "" */
		/* - 예산과목표시 */
		/* - [V]모든 예산과목 표시 */
		/* - 당기 예산편성된 과목만 표시 */
		/* - 프로젝트기간 예산편성된 과목만 표시 */
		/* - 사용기한 */
		/* - 모두 표시 */
		/* - [V]사용기한 경과분 숨김 */
		/* - 상위과목표시 */
		/* - 모두 표시 */
		/* - [V]최하위 표시 */
		/* - 예산그룹표시 */
		/* - [V]표시 */
		/* - 숨김 */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231' */
		/* ,@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL */
		/* ,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'2',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* ############################################################################################################################################ */
		/* - 부분검색 */
		/* - 예산과목명 : "" */
		/* - 예산과목코드 : "" */
		/* - 예산과목표시 */
		/* - [V]모든 예산과목 표시 */
		/* - 당기 예산편성된 과목만 표시 */
		/* - 프로젝트기간 예산편성된 과목만 표시 */
		/* - 사용기한 */
		/* - 모두 표시 */
		/* - [V]사용기한 경과분 숨김 */
		/* - 상위과목표시 */
		/* - [V]모두 표시 */
		/* - 최하위 표시 */
		/* - 예산그룹표시 */
		/* - 표시 */
		/* - [V]숨김 */
		/* EXEC USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=3,@FR_DT=N'20180101',@TO_DT=N'20181231' */
		/* ,@GR_FG=N'2',@DIV_CDS=N'1000|',@MGT_CDS=N'00001|',@BOTTOM_CDS=N'',@BGT_CD=NULL */
		/* ,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'2',@OPT_03=N'1',@BGT_FR_DT=N'20180101',@GROUP_CD=N'' */
		/* ############################################################################################################################################ */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguBgtInfoI_Select", param );
		return result;
	}

	/* ## [+] 국고보조 v2 ## - 금융거래처 조회 */
	public List<Map<String, Object>> getAnguBankPartnerInfoI_Select ( ConnectionVO conVo, Map<String, Object> param ) throws Exception {
		/* EXEC USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5''' */
		/* return : TR_CD, ATTR_NM, ATTR_NMK, REG_NB, BA_NB, CEO_NM, CEO_NMK, TR_FG_NM, TR_FG, JIRO_CD, TR_NM, TR_NMK, JEONJA_YN, LIQ_RS, EMAIL, INTER_DT, TRCHARGE_EMAIL, INTER_RT */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.getAnguBankPartnerInfoI_Select", param );
		return result;
	}
	/* ## [-] 국고보조 v2 ## */

	/* 코드 - 국고보조사업 */
	public List<Map<String, Object>> DdtlbzInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_DDTLBZ_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.DdtlbzInfoS", params );
		return result;
	}

	/* 코드 - 이체계좌구분 */
	public List<Map<String, Object>> TransfracnutseInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'1089' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.TransfracnutseInfoS", params );
		return result;
	}

	/* 코드 - 자계좌이체사유코드 */
	public List<Map<String, Object>> SbsacnttrfrsnInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_CMMN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CMMN_CODE=N'0665' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.SbsacnttrfrsnInfoS", params );
		return result;
	}

	/* 코드 - 전자세금계산서 */
	public List<Map<String, Object>> PrufsenoETaxInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_ETAX_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DT_FG=N'1',@FR_DT=N'20160101',@TO_DT=N'20170520',@TAX_TY=N'2',@ETAX_TY=N'',@TR_CD=N'1000|',@DDTLBZ_ID=N'TEST-00001',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.PrufsenoETaxInfoS", params );
		return result;
	}

	/* 코드 - 카드승인 - 카드 */
	public List<Map<String, Object>> PrufsenoCardS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.PrufsenoCardS", params );
		return result;
	}

	/* 코드 - 카드승인 */
	public List<Map<String, Object>> PrufsenoCardInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_CARDINFO_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@CONFM_DE_FR=N'20160101',@CONFM_DE_TO=N'20170520',@CARD_NO=N'1234123412341234',@MRHST_NM=N'',@PUCHAS_TAMT=0,@DDTLBZ_ID=N'TEST-00001',@TASC_CMMN_DETAIL_CODE_NM=N'001' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.PrufsenoCardInfoS", params );
		return result;
	}

	/* 코드 - 코드 */
	public List<Map<String, Object>> TrInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=NULL */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.TrInfoS", params );
		return result;
	}

	/* 코드 - 금융기관 */
	public List<Map<String, Object>> BcncbankInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SBANK_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=NULL,@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'DUMMY3 = ''1''' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.BcncbankInfoS", params );
		return result;
	}

	/* 코드 - 보조비목세목코드 */
	public List<Map<String, Object>> AsstntaxitmInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_ASSTN_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20170515',@MOSF_GISU_SQ=1,@FSYR=N'2017' */
		/* DDTLBZ_ID, BSNSYEAR */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.AsstntaxitmInfoS", params );
		return result;
	}

	/* 코드 - 재원구분 */
	public List<Map<String, Object>> FnrscseInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_ANBOJO_B_CMMN_CODE_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@MOSF_GISU_DT=N'20170515',@MOSF_GISU_SQ=1,@MOSF_BG_SQ=1 */
		/* DDTLBZ_ID, BSNSYEAR, ASSTN_TAXITM_CODE */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.FnrscseInfoS", params );
		return result;
	}

	/* 코드 - 프로젝트 */
	public List<Map<String, Object>> MgtInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_MGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'TEST-00001' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.MgtInfoS", params );
		return result;
	}

	/* 코드 - 예산과목 레벨 */
	public List<Map<String, Object>> AbgtLevelInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_COMMON_ACC_ABSDOCU_TERM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.AbgtLevelInfoS", params );
		return result;
	}

	/* 코드 - 귀속 예산과목 코드 */
	public List<Map<String, Object>> AbgtCodeInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_BGT_CD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@ASSTN_TAXITM_CODE=N'11001' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.AbgtCodeInfoS", params );
		return result;
	}

	/* 코드 - 예산과목 */
	public List<Map<String, Object>> AbgtInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_COMMON_ACC_CUSTOMHELP_SBGTCD_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@GISU=2,@FR_DT=N'20170101',@TO_DT=N'20171231',@GR_FG=N'2',@DIV_CDS=N'',@MGT_CDS=N'',@BOTTOM_CDS=N'',@BGT_CD=NULL,@BGT_NM=NULL,@OPT_01=N'1',@OPT_02=N'1',@OPT_03=N'1',@BGT_FR_DT=N'20170101',@GROUP_CD=N'' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.AbgtInfoS", params );
		return result;
	}

	/* 코드 - 코드 */
	public List<Map<String, Object>> BtrInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'STRADE_CODE',@P_CO_CD=N'3585',@P_CODE=NULL,@P_CODE2=NULL,@P_CODE3=NULL,@P_USE_YN=N'1',@P_NAME=NULL,@P_STD_DT=NULL,@P_WHERE=N'TR_FG >= ''5''' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.BtrInfoS", params );
		return result;
	}

	/* 코드 - 금액집계 */
	public Map<String, Object> AmountInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_RESULTERP_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BSNSYEAR=N'2017',@DDTLBZ_ID=N'TEST-00001',@ASSTN_TAXITM_CODE=N'11001',@FNRSC_SE_CODE=N'001' */
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.AmountInfoS", params );
		return result;
	}

	/* 인력정보등록 - 코드 */
	public List<Map<String, Object>> HpmeticInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_ANGU300_HPMETIC_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@BASE_DT=N'20170516' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.HpmeticInfoS", params );
		return result;
	}

	/* 인력정보등록 - 소득구분 */
	public List<Map<String, Object>> PayTpInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* exec USP_GET_HELPCODE @LANGKIND=N'KOR',@P_HELP_TY=N'SCTRL_D_CODE',@P_CO_CD=N'3585',@P_CODE=N'',@P_CODE2=N'',@P_CODE3=N'',@P_USE_YN=N'1',@P_NAME=N'',@P_STD_DT=N'',@P_WHERE=N'CTRL_CD = ''G'' AND MODULE_CD = ''H'' AND CTD_CD IN(''60'', ''62'', ''63'', ''68'', ''71'', ''72'', ''73'', ''74'', ''75'', ''76'')' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.PayTpInfoS", params );
		return result;
	}

	/* 카드 */
	public List<Map<String, Object>> CardInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* 국고보조사업 귀속 카드 >> exec USP_ANGU300_CARD_NM_SELECT @LANGKIND=N'KOR',@CO_CD=N'3585',@DDTLBZ_ID=N'20170125000000000787' */
		List<Map<String, Object>> result = new ArrayList<Map<String, Object>>( );
		result = connector.List( conVo, "AnguCode.CardInfoS", params );
		return result;
	}

	/* 연동 거래처 정보 조회 */
	public Map<String, Object> LinkPartnerInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* USP_GET_HELPCODE */
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.LinkPartnerInfoS", params );
		return result;
	}

	/* 연동 금융 거래처 정보 조회 */
	public Map<String, Object> LinkBankInfoS ( Map<String, Object> params, ConnectionVO conVo ) {
		/* USP_GET_HELPCODE */
		Map<String, Object> result = new HashMap<String, Object>( );
		result = connector.Select( conVo, "AnguCode.LinkBankInfoS", params );
		return result;
	}
}
