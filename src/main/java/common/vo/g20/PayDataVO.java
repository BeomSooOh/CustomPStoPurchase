package common.vo.g20;

import java.util.Arrays;

import common.vo.common.CommonInterface.commonCode;


public class PayDataVO {

	private String abdocu_no = commonCode.EMPTYSTR;
	private String abdocu_b_no = commonCode.EMPTYSTR;
	private String abdocu_t_no = commonCode.EMPTYSTR;
	private String erp_co_cd = commonCode.EMPTYSTR;
	private String emp_cd = commonCode.EMPTYSTR;
	private String PKEY = commonCode.EMPTYSTR;
	private String EMP_TR_CD = commonCode.EMPTYSTR; // EMP_CD
	private String KOR_NM = commonCode.EMPTYSTR;
	private String DEPT_NM = commonCode.EMPTYSTR;
	private String RVRS_YM = commonCode.EMPTYSTR;
	private String SQ = commonCode.EMPTYSTR;
	private String GISU_DT = commonCode.EMPTYSTR;
	private String PAY_DT = commonCode.EMPTYSTR;
	private String TPAY_AM = commonCode.EMPTYSTR;
	private String SUP_AM = commonCode.EMPTYSTR;
	private String VAT_AM = commonCode.EMPTYSTR;
	private String INTX_AM = commonCode.EMPTYSTR;
	private String RSTX_AM = commonCode.EMPTYSTR;
	private String ETC_AM = commonCode.EMPTYSTR;
	private String ACCT_NO = commonCode.EMPTYSTR;
	private String PYTB_CD = commonCode.EMPTYSTR;
	private String DPST_NM = commonCode.EMPTYSTR;
	private String BANK_NM = commonCode.EMPTYSTR;
	private String RSRG_NO = commonCode.EMPTYSTR;
	private String PJT_NM = commonCode.EMPTYSTR;
	private String strPKEY[];
	private String strEMP_TR_CD[]; // EMP_CD
	private String strKOR_NM[];
	private String strDEPT_NM[];
	private String strRVRS_YM[];
	private String strSQ[];
	private String strGISU_DT[];
	private String strPAY_DT[];
	private String strTPAY_AM[];
	private String strSUP_AM[];
	private String strVAT_AM[];
	private String strINTX_AM[];
	private String strRSTX_AM[];
	private String strETC_AM[];
	private String strACCT_NO[];
	private String strPYTB_CD[];
	private String strDPST_NM[];
	private String strBANK_NM[];
	private String strRSRG_NO[];
	private String strPJT_NM[];

	public String getAbdocu_no ( ) {
		return abdocu_no;
	}

	public void setAbdocu_no ( String abdocuNo ) {
		this.abdocu_no = abdocuNo;
	}

	public String getAbdocu_b_no ( ) {
		return abdocu_b_no;
	}

	public void setAbdocu_b_no ( String abdocuBNo ) {
		this.abdocu_b_no = abdocuBNo;
	}

	public String getAbdocu_t_no ( ) {
		return abdocu_t_no;
	}

	public void setAbdocu_t_no ( String abdocuTNo ) {
		this.abdocu_t_no = abdocuTNo;
	}

	public String getErp_co_cd ( ) {
		return erp_co_cd;
	}

	public void setErp_co_cd ( String erpCoCd ) {
		this.erp_co_cd = erpCoCd;
	}

	public String getEmp_cd ( ) {
		return emp_cd;
	}

	public void setEmp_cd ( String empCd ) {
		this.emp_cd = empCd;
	}

	public String getPKEY ( ) {
		return PKEY;
	}

	public void setPKEY ( String pKEY ) {
		PKEY = pKEY;
	}

	public String getEMP_TR_CD ( ) {
		return EMP_TR_CD;
	}

	public void setEMP_TR_CD ( String empTrCd ) {
		EMP_TR_CD = empTrCd;
	}

	public String getKOR_NM ( ) {
		return KOR_NM;
	}

	public void setKOR_NM ( String korNm ) {
		KOR_NM = korNm;
	}

	public String getDEPT_NM ( ) {
		return DEPT_NM;
	}

	public void setDEPT_NM ( String deptNm ) {
		DEPT_NM = deptNm;
	}

	public String getRVRS_YM ( ) {
		return RVRS_YM;
	}

	public void setRVRS_YM ( String rvrsYm ) {
		RVRS_YM = rvrsYm;
	}

	public String getSQ ( ) {
		return SQ;
	}

	public void setSQ ( String sQ ) {
		SQ = sQ;
	}

	public String getGISU_DT ( ) {
		return GISU_DT;
	}

	public void setGISU_DT ( String gisuDt ) {
		GISU_DT = gisuDt;
	}

	public String getPAY_DT ( ) {
		return PAY_DT;
	}

	public void setPAY_DT ( String payDt ) {
		PAY_DT = payDt;
	}

	public String getTPAY_AM ( ) {
		return TPAY_AM;
	}

	public void setTPAY_AM ( String tpayAm ) {
		TPAY_AM = tpayAm;
	}

	public String getSUP_AM ( ) {
		return SUP_AM;
	}

	public void setSUP_AM ( String supAm ) {
		SUP_AM = supAm;
	}

	public String getVAT_AM ( ) {
		return VAT_AM;
	}

	public void setVAT_AM ( String vatAm ) {
		VAT_AM = vatAm;
	}

	public String getINTX_AM ( ) {
		return INTX_AM;
	}

	public void setINTX_AM ( String intxAm ) {
		INTX_AM = intxAm;
	}

	public String getRSTX_AM ( ) {
		return RSTX_AM;
	}

	public void setRSTX_AM ( String rstxAm ) {
		RSTX_AM = rstxAm;
	}

	public String getETC_AM ( ) {
		return ETC_AM;
	}

	public void setETC_AM ( String etcAm ) {
		ETC_AM = etcAm;
	}

	public String getACCT_NO ( ) {
		return ACCT_NO;
	}

	public void setACCT_NO ( String acctNo ) {
		ACCT_NO = acctNo;
	}

	public String getPYTB_CD ( ) {
		return PYTB_CD;
	}

	public void setPYTB_CD ( String pytbCd ) {
		PYTB_CD = pytbCd;
	}

	public String getDPST_NM ( ) {
		return DPST_NM;
	}

	public void setDPST_NM ( String dpstNm ) {
		DPST_NM = dpstNm;
	}

	public String getBANK_NM ( ) {
		return BANK_NM;
	}

	public void setBANK_NM ( String bankNm ) {
		BANK_NM = bankNm;
	}

	public String getRSRG_NO ( ) {
		return RSRG_NO;
	}

	public void setRSRG_NO ( String rsrgNo ) {
		RSRG_NO = rsrgNo;
	}

	public String getPJT_NM ( ) {
		return PJT_NM;
	}

	public void setPJT_NM ( String pjtNm ) {
		PJT_NM = pjtNm;
	}

	public String[] getStrPKEY ( ) {
		return strPKEY;
	}

	public void setStrPKEY ( String[] strPKEY ) {
		this.strPKEY = strPKEY;
	}

	public String[] getStrEMP_TR_CD ( ) {
		return strEMP_TR_CD;
	}

	public void setStrEMP_TR_CD ( String[] strempTrCd ) {
		this.strEMP_TR_CD = strempTrCd;
	}

	public String[] getStrKOR_NM ( ) {
		return strKOR_NM;
	}

	public void setStrKOR_NM ( String[] strkorNm ) {
		this.strKOR_NM = strkorNm;
	}

	public String[] getStrDEPT_NM ( ) {
		return strDEPT_NM;
	}

	public void setStrDEPT_NM ( String[] strdeptNm ) {
		this.strDEPT_NM = strdeptNm;
	}

	public String[] getStrRVRS_YM ( ) {
		return strRVRS_YM;
	}

	public void setStrRVRS_YM ( String[] strrvrsYm ) {
		this.strRVRS_YM = strrvrsYm;
	}

	public String[] getStrSQ ( ) {
		return strSQ;
	}

	public void setStrSQ ( String[] strSQ ) {
		this.strSQ = strSQ;
	}

	public String[] getStrGISU_DT ( ) {
		return strGISU_DT;
	}

	public void setStrGISU_DT ( String[] strgisuDt ) {
		this.strGISU_DT = strgisuDt;
	}

	public String[] getStrPAY_DT ( ) {
		return strPAY_DT;
	}

	public void setStrPAY_DT ( String[] strpayDt ) {
		this.strPAY_DT = strpayDt;
	}

	public String[] getStrTPAY_AM ( ) {
		return strTPAY_AM;
	}

	public void setStrTPAY_AM ( String[] strtpayAm ) {
		this.strTPAY_AM = strtpayAm;
	}

	public String[] getStrSUP_AM ( ) {
		return strSUP_AM;
	}

	public void setStrSUP_AM ( String[] strsupAm ) {
		this.strSUP_AM = strsupAm;
	}

	public String[] getStrVAT_AM ( ) {
		return strVAT_AM;
	}

	public void setStrVAT_AM ( String[] strvatAm ) {
		this.strVAT_AM = strvatAm;
	}

	public String[] getStrINTX_AM ( ) {
		return strINTX_AM;
	}

	public void setStrINTX_AM ( String[] strintxAm ) {
		this.strINTX_AM = strintxAm;
	}

	public String[] getStrRSTX_AM ( ) {
		return strRSTX_AM;
	}

	public void setStrRSTX_AM ( String[] strrstxAm ) {
		this.strRSTX_AM = strrstxAm;
	}

	public String[] getStrETC_AM ( ) {
		return strETC_AM;
	}

	public void setStrETC_AM ( String[] stretcAm ) {
		this.strETC_AM = stretcAm;
	}

	public String[] getStrACCT_NO ( ) {
		return strACCT_NO;
	}

	public void setStrACCT_NO ( String[] stracctNo ) {
		this.strACCT_NO = stracctNo;
	}

	public String[] getStrPYTB_CD ( ) {
		return strPYTB_CD;
	}

	public void setStrPYTB_CD ( String[] strpytbCd ) {
		this.strPYTB_CD = strpytbCd;
	}

	public String[] getStrDPST_NM ( ) {
		return strDPST_NM;
	}

	public void setStrDPST_NM ( String[] strdpstNm ) {
		this.strDPST_NM = strdpstNm;
	}

	public String[] getStrBANK_NM ( ) {
		return strBANK_NM;
	}

	public void setStrBANK_NM ( String[] strbankNm ) {
		this.strBANK_NM = strbankNm;
	}

	public String[] getStrRSRG_NO ( ) {
		return strRSRG_NO;
	}

	public void setStrRSRG_NO ( String[] strrsrgNo ) {
		this.strRSRG_NO = strrsrgNo;
	}

	public String[] getStrPJT_NM ( ) {
		return strPJT_NM;
	}

	public void setStrPJT_NM ( String[] strpjtNm ) {
		this.strPJT_NM = strpjtNm;
	}

	@Override
	public String toString ( ) {
		return "PayDataVO [abdocu_no=" + abdocu_no + ", abdocu_b_no=" + abdocu_b_no + ", abdocu_t_no=" + abdocu_t_no + ", erp_co_cd=" + erp_co_cd + ", emp_cd=" + emp_cd + ", PKEY=" + PKEY + ", EMP_TR_CD=" + EMP_TR_CD + ", KOR_NM=" + KOR_NM + ", DEPT_NM=" + DEPT_NM + ", RVRS_YM=" + RVRS_YM + ", SQ=" + SQ + ", GISU_DT=" + GISU_DT + ", PAY_DT=" + PAY_DT + ", TPAY_AM=" + TPAY_AM + ", SUP_AM=" + SUP_AM + ", VAT_AM=" + VAT_AM + ", INTX_AM=" + INTX_AM + ", RSTX_AM=" + RSTX_AM + ", ETC_AM=" + ETC_AM + ", ACCT_NO=" + ACCT_NO + ", PYTB_CD=" + PYTB_CD + ", DPST_NM=" + DPST_NM + ", BANK_NM=" + BANK_NM + ", RSRG_NO=" + RSRG_NO + ", PJT_NM=" + PJT_NM + ", strPKEY=" + Arrays.toString( strPKEY ) + ", strEMP_TR_CD=" + Arrays.toString( strEMP_TR_CD ) + ", strKOR_NM=" + Arrays.toString( strKOR_NM ) + ", strDEPT_NM=" + Arrays.toString( strDEPT_NM ) + ", strRVRS_YM=" + Arrays.toString( strRVRS_YM ) + ", strSQ=" + Arrays.toString( strSQ ) + ", strGISU_DT=" + Arrays.toString( strGISU_DT ) + ", strPAY_DT="
				+ Arrays.toString( strPAY_DT ) + ", strTPAY_AM=" + Arrays.toString( strTPAY_AM ) + ", strSUP_AM=" + Arrays.toString( strSUP_AM ) + ", strVAT_AM=" + Arrays.toString( strVAT_AM ) + ", strINTX_AM=" + Arrays.toString( strINTX_AM ) + ", strRSTX_AM=" + Arrays.toString( strRSTX_AM ) + ", strETC_AM=" + Arrays.toString( strETC_AM ) + ", strACCT_NO=" + Arrays.toString( strACCT_NO ) + ", strPYTB_CD=" + Arrays.toString( strPYTB_CD ) + ", strDPST_NM=" + Arrays.toString( strDPST_NM ) + ", strBANK_NM=" + Arrays.toString( strBANK_NM ) + ", strRSRG_NO=" + Arrays.toString( strRSRG_NO ) + ", strPJT_NM=" + Arrays.toString( strPJT_NM ) + "]";
	}
}
