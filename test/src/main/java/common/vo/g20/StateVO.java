package common.vo.g20;

import common.vo.common.CommonInterface.commonCode;

/**
 *
 * @title BudgetVO.java
 * @author doban7
 *
 * @date 2016. 10. 26.
 */
public class StateVO {

	private String LANGKIND = "KR";
	private String searchKeyword = commonCode.EMPTYSTR;
	private String searchYN = commonCode.EMPTYSTR;
	private String DATE_FROM = commonCode.EMPTYSTR;
	private String DATE_TO = commonCode.EMPTYSTR;
	private String FR_DT = commonCode.EMPTYSTR;
	private String TO_DT = commonCode.EMPTYSTR;
	private String CO_CD = commonCode.EMPTYSTR;
	private String CO_NM = commonCode.EMPTYSTR;
	private String DIV_CD = commonCode.EMPTYSTR;
	private String DIV_CDS = commonCode.EMPTYSTR;
	private String MGT_CD = commonCode.EMPTYSTR;
	private String MGT_CDS = commonCode.EMPTYSTR;
	private String MGT_CD_NM = commonCode.EMPTYSTR;
	private String BGT_NM = commonCode.EMPTYSTR;
	private String BGT_CD;
	private String BGT_CD_FROM = commonCode.EMPTYSTR;
	private String BGT_NM_FROM = commonCode.EMPTYSTR;
	private String BGT_CD_TO = commonCode.EMPTYSTR;
	private String BGT_NM_TO = commonCode.EMPTYSTR;
	private String DIV_FG = commonCode.EMPTYSTR;
	private String GR_FG = commonCode.EMPTYSTR;
	private String OPT12 = "1";
	private String OPT13 = "1";
	private String OPT14 = "1";
	private String ZEROLINE_FG = "1";
	private String GISU = commonCode.EMPTYSTR;
	private String BASE_DT = commonCode.EMPTYSTR;
	private String JOT_OPTION1 = "2";
	private String BGT_DIFF_S = "2";
	private String BGT_DIFF_D = "6";
	private String EMP_CD = commonCode.EMPTYSTR;
	private String FG_TY = commonCode.EMPTYSTR;
	private String BOTTOM_YN = commonCode.EMPTYSTR;
	private String BOTTOM_CD = commonCode.EMPTYSTR;
	private String BOTTOM_CDS = commonCode.EMPTYSTR;
	private String BOTTOM_NM = commonCode.EMPTYSTR;
	private String EXCEL_YN = commonCode.EMPTYSTR;
	private String target = commonCode.EMPTYSTR;
	private String DATE_FROMS = commonCode.EMPTYSTR;
	private String DATE_TOS = commonCode.EMPTYSTR;
	private String FR_DT_origin = commonCode.EMPTYSTR;
	private String TO_DT_origin = commonCode.EMPTYSTR;
	private String GISU_DT = commonCode.EMPTYSTR;
	private String SYS_CD_FROM = commonCode.EMPTYSTR;
	private String SYS_CD_TO = commonCode.EMPTYSTR;
	/** 차수 추가 2014.05.26 lhy **/
	private String BGT_CNT = "1";
	/** 11/11 추가 duckyo **/
	private String DIV_NM = commonCode.EMPTYSTR;
	private String PJT_NM = commonCode.EMPTYSTR;
	private String PJT_CD = commonCode.EMPTYSTR;
	private String DEPT_NM = commonCode.EMPTYSTR;
	private String DEPT_CD = commonCode.EMPTYSTR;
	private String EMP_NM = commonCode.EMPTYSTR;
	private String ASSET_NM = commonCode.EMPTYSTR;
	private String ASSET_CD = commonCode.EMPTYSTR;
	private String DEFP_NM = commonCode.EMPTYSTR;
	private String DEFP_CD = commonCode.EMPTYSTR;
	private String DEFA_NM = commonCode.EMPTYSTR;
	private String DEFA_CD = commonCode.EMPTYSTR;
	private String DEFB_NM = commonCode.EMPTYSTR;
	private String DEFB_CD = commonCode.EMPTYSTR;
	private String DEFC_NM = commonCode.EMPTYSTR;
	private String DEFC_CD = commonCode.EMPTYSTR;
	private String DEFD_NM = commonCode.EMPTYSTR;
	private String DEFD_CD = commonCode.EMPTYSTR;
	private String IN_DT_FR = commonCode.EMPTYSTR;
	private String IN_DT_TO = commonCode.EMPTYSTR;
	private String DOC_MODE = commonCode.EMPTYSTR;

	public String getDIV_NM ( ) {
		return DIV_NM;
	}

	public void setDIV_NM ( String divNm ) {
		DIV_NM = divNm;
	}

	public String getPJT_NM ( ) {
		return PJT_NM;
	}

	public void setPJT_NM ( String pjtNm ) {
		PJT_NM = pjtNm;
	}

	public String getPJT_CD ( ) {
		return PJT_CD;
	}

	public void setPJT_CD ( String pjtCd ) {
		PJT_CD = pjtCd;
	}

	public String getDEPT_NM ( ) {
		return DEPT_NM;
	}

	public void setDEPT_NM ( String deptNm ) {
		DEPT_NM = deptNm;
	}

	public String getDEPT_CD ( ) {
		return DEPT_CD;
	}

	public void setDEPT_CD ( String deptCd ) {
		DEPT_CD = deptCd;
	}

	public String getEMP_NM ( ) {
		return EMP_NM;
	}

	public void setEMP_NM ( String empNm ) {
		EMP_NM = empNm;
	}

	public String getASSET_NM ( ) {
		return ASSET_NM;
	}

	public void setASSET_NM ( String assetNm ) {
		ASSET_NM = assetNm;
	}

	public String getASSET_CD ( ) {
		return ASSET_CD;
	}

	public void setASSET_CD ( String assetCd ) {
		ASSET_CD = assetCd;
	}

	public String getDEFP_NM ( ) {
		return DEFP_NM;
	}

	public void setDEFP_NM ( String defpNm ) {
		DEFP_NM = defpNm;
	}

	public String getDEFP_CD ( ) {
		return DEFP_CD;
	}

	public void setDEFP_CD ( String defpCd ) {
		DEFP_CD = defpCd;
	}

	public String getDEFA_NM ( ) {
		return DEFA_NM;
	}

	public void setDEFA_NM ( String defaNm ) {
		DEFA_NM = defaNm;
	}

	public String getDEFA_CD ( ) {
		return DEFA_CD;
	}

	public void setDEFA_CD ( String defaCd ) {
		DEFA_CD = defaCd;
	}

	public String getDEFB_NM ( ) {
		return DEFB_NM;
	}

	public void setDEFB_NM ( String defbNm ) {
		DEFB_NM = defbNm;
	}

	public String getDEFB_CD ( ) {
		return DEFB_CD;
	}

	public void setDEFB_CD ( String defbCd ) {
		DEFB_CD = defbCd;
	}

	public String getDEFC_NM ( ) {
		return DEFC_NM;
	}

	public void setDEFC_NM ( String defcNm ) {
		DEFC_NM = defcNm;
	}

	public String getDEFC_CD ( ) {
		return DEFC_CD;
	}

	public void setDEFC_CD ( String defcCd ) {
		DEFC_CD = defcCd;
	}

	public String getDEFD_NM ( ) {
		return DEFD_NM;
	}

	public void setDEFD_NM ( String defdNm ) {
		DEFD_NM = defdNm;
	}

	public String getDEFD_CD ( ) {
		return DEFD_CD;
	}

	public void setDEFD_CD ( String defdCd ) {
		DEFD_CD = defdCd;
	}

	public String getIN_DT_FR ( ) {
		return IN_DT_FR;
	}

	public void setIN_DT_FR ( String inDtFr ) {
		IN_DT_FR = inDtFr;
	}

	public String getIN_DT_TO ( ) {
		return IN_DT_TO;
	}

	public void setIN_DT_TO ( String inDtTo ) {
		IN_DT_TO = inDtTo;
	}

	public String getLANGKIND ( ) {
		return LANGKIND;
	}

	public void setLANGKIND ( String lANGKIND ) {
		LANGKIND = lANGKIND;
	}

	public String getSearchYN ( ) {
		return searchYN;
	}

	public void setSearchYN ( String searchYN ) {
		this.searchYN = searchYN;
	}

	public String getZEROLINE_FG ( ) {
		return ZEROLINE_FG;
	}

	public void setZEROLINE_FG ( String zerolineFg ) {
		ZEROLINE_FG = zerolineFg;
	}

	public String getDATE_FROM ( ) {
		return DATE_FROM;
	}

	public void setDATE_FROM ( String dateFrom ) {
		DATE_FROM = dateFrom;
	}

	public String getBGT_CD_TO ( ) {
		return BGT_CD_TO;
	}

	public String getBGT_NM_TO ( ) {
		return BGT_NM_TO;
	}

	public void setBGT_CD_TO ( String bgtCdTo ) {
		BGT_CD_TO = bgtCdTo;
	}

	public void setBGT_NM_TO ( String bgtNmTo ) {
		BGT_NM_TO = bgtNmTo;
	}

	public String getDATE_TO ( ) {
		return DATE_TO;
	}

	public void setDATE_TO ( String dateTo ) {
		DATE_TO = dateTo;
	}

	public String getSearchKeyword ( ) {
		return searchKeyword;
	}

	public void setSearchKeyword ( String searchKeyword ) {
		this.searchKeyword = searchKeyword;
	}

	public String getFR_DT ( ) {
		return FR_DT;
	}

	public void setFR_DT ( String frDt ) {
		FR_DT = frDt;
	}

	public String getTO_DT ( ) {
		return TO_DT;
	}

	public void setTO_DT ( String toDt ) {
		TO_DT = toDt;
	}

	public String getCO_CD ( ) {
		return CO_CD;
	}

	public void setCO_CD ( String coCd ) {
		CO_CD = coCd;
	}

	public String getDIV_CD ( ) {
		return DIV_CD;
	}

	public void setDIV_CD ( String divCd ) {
		DIV_CD = divCd;
	}

	public String getMGT_CD ( ) {
		return MGT_CD;
	}

	public void setMGT_CD ( String mgtCd ) {
		MGT_CD = mgtCd;
	}

	public String getMGT_CD_NM ( ) {
		return MGT_CD_NM;
	}

	public void setMGT_CD_NM ( String mgtCdNm ) {
		MGT_CD_NM = mgtCdNm;
	}

	public String getBGT_CD ( ) {
		return BGT_CD;
	}

	public void setBGT_CD ( String bgtCd ) {
		BGT_CD = bgtCd;
	}

	public String getBGT_NM ( ) {
		return BGT_NM;
	}

	public void setBGT_NM ( String bgtNm ) {
		BGT_NM = bgtNm;
	}

	public String getBGT_CD_FROM ( ) {
		return BGT_CD_FROM;
	}

	public void setBGT_CD_FROM ( String bgtCdFrom ) {
		BGT_CD_FROM = bgtCdFrom;
	}

	public String getBGT_NM_FROM ( ) {
		return BGT_NM_FROM;
	}

	public void setBGT_NM_FROM ( String bgtNmFrom ) {
		BGT_NM_FROM = bgtNmFrom;
	}

	public String getDIV_FG ( ) {
		return DIV_FG;
	}

	public void setDIV_FG ( String divFg ) {
		DIV_FG = divFg;
	}

	public String getGR_FG ( ) {
		return GR_FG;
	}

	public String getEMP_CD ( ) {
		return EMP_CD;
	}

	public void setEMP_CD ( String empCd ) {
		EMP_CD = empCd;
	}

	public void setGR_FG ( String grFg ) {
		GR_FG = grFg;
	}

	public String getOPT12 ( ) {
		return OPT12;
	}

	public void setOPT12 ( String oPT12 ) {
		OPT12 = oPT12;
	}

	public String getOPT13 ( ) {
		return OPT13;
	}

	public String getBGT_DIFF_S ( ) {
		return BGT_DIFF_S;
	}

	public void setBGT_DIFF_S ( String bgtDiffS ) {
		BGT_DIFF_S = bgtDiffS;
	}

	public String getBGT_DIFF_D ( ) {
		return BGT_DIFF_D;
	}

	public void setBGT_DIFF_D ( String bgtDiffD ) {
		BGT_DIFF_D = bgtDiffD;
	}

	public void setOPT13 ( String oPT13 ) {
		OPT13 = oPT13;
	}

	public String getOPT14 ( ) {
		return OPT14;
	}

	public void setOPT14 ( String oPT14 ) {
		OPT14 = oPT14;
	}

	public String getGISU ( ) {
		return GISU;
	}

	public void setGISU ( String gISU ) {
		GISU = gISU;
	}

	public String getBASE_DT ( ) {
		return BASE_DT;
	}

	public void setBASE_DT ( String baseDt ) {
		BASE_DT = baseDt;
	}

	public String getJOT_OPTION1 ( ) {
		return JOT_OPTION1;
	}

	public void setJOT_OPTION1 ( String jotOption1 ) {
		JOT_OPTION1 = jotOption1;
	}

	public String getFG_TY ( ) {
		return FG_TY;
	}

	public void setFG_TY ( String fgTy ) {
		FG_TY = fgTy;
	}

	public String getBOTTOM_YN ( ) {
		return BOTTOM_YN;
	}

	public void setBOTTOM_YN ( String bottomYn ) {
		BOTTOM_YN = bottomYn;
	}

	public String getBOTTOM_CD ( ) {
		return BOTTOM_CD;
	}

	public void setBOTTOM_CD ( String bottomCd ) {
		BOTTOM_CD = bottomCd;
	}

	public String getBOTTOM_NM ( ) {
		return BOTTOM_NM;
	}

	public void setBOTTOM_NM ( String bottomNm ) {
		BOTTOM_NM = bottomNm;
	}

	public String getEXCEL_YN ( ) {
		return EXCEL_YN;
	}

	public void setEXCEL_YN ( String excelYn ) {
		EXCEL_YN = excelYn;
	}

	public String getTarget ( ) {
		return target;
	}

	public void setTarget ( String target ) {
		this.target = target;
	}

	public String getDATE_FROMS ( ) {
		return DATE_FROMS;
	}

	public void setDATE_FROMS ( String dateFroms ) {
		DATE_FROMS = dateFroms;
	}

	public String getDATE_TOS ( ) {
		return DATE_TOS;
	}

	public void setDATE_TOS ( String dateTos ) {
		DATE_TOS = dateTos;
	}

	public String getFR_DT_origin ( ) {
		return FR_DT_origin;
	}

	public void setFR_DT_origin ( String frDtOrigin ) {
		FR_DT_origin = frDtOrigin;
	}

	public String getTO_DT_origin ( ) {
		return TO_DT_origin;
	}

	public void setTO_DT_origin ( String toDtOrigin ) {
		TO_DT_origin = toDtOrigin;
	}

	public String getGISU_DT ( ) {
		return GISU_DT;
	}

	public void setGISU_DT ( String gisuDt ) {
		GISU_DT = gisuDt;
	}

	public String getSYS_CD_FROM ( ) {
		return SYS_CD_FROM;
	}

	public void setSYS_CD_FROM ( String sysCdFrom ) {
		SYS_CD_FROM = sysCdFrom;
	}

	public String getSYS_CD_TO ( ) {
		return SYS_CD_TO;
	}

	public void setSYS_CD_TO ( String sysCdTo ) {
		SYS_CD_TO = sysCdTo;
	}

	public String getDIV_CDS ( ) {
		return DIV_CDS;
	}

	public void setDIV_CDS ( String divCds ) {
		DIV_CDS = divCds;
	}

	public String getMGT_CDS ( ) {
		return MGT_CDS;
	}

	public void setMGT_CDS ( String mgtCds ) {
		MGT_CDS = mgtCds;
	}

	public String getBOTTOM_CDS ( ) {
		return BOTTOM_CDS;
	}

	public void setBOTTOM_CDS ( String bottomCds ) {
		BOTTOM_CDS = bottomCds;
	}

	public String getBGT_CNT ( ) {
		return BGT_CNT;
	}

	public void setBGT_CNT ( String bgtCnt ) {
		BGT_CNT = bgtCnt;
	}

	public String getDOC_MODE ( ) {
		return DOC_MODE;
	}

	public void setDOC_MODE ( String docMode ) {
		DOC_MODE = docMode;
	}

	public String getCO_NM ( ) {
		return CO_NM;
	}

	public void setCO_NM ( String coNm ) {
		CO_NM = coNm;
	}
}
