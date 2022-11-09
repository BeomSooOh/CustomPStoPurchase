package common.vo.ex;

import common.vo.common.CommonInterface.commonCode;

public class ExiCUBEDocuVO {

	private String IN_DT = commonCode.EMPTYSTR; /* 처리일자 */ /* 일반계정 : 자동전표 입력일자 */ /* 부가세계정 : 자동전표일자 */
	private String IN_SQ = commonCode.EMPTYSEQ; /* 처리번호 */ /* 일반계정 : 자동전표 입력 NO */ /* 부가세계정 : 자동전표NO */
	private String LN_SQ = commonCode.EMPTYSEQ; /* 처리라인번호 */ /* 일반계정 : 자동전표 입력 LINE */ /* 부가세계정 : 자동전표LINE */
	private String CO_CD = commonCode.EMPTYSTR; /* 회사코드 */ /* 일반계정 : 회사코드 */ /* 부가세계정 : 회사코드 */
	private String IN_DIV_CD = commonCode.EMPTYSTR; /* 처리사업장 */ /* 일반계정 : 사업장코드 */ /* 부가세계정 : 사업장코드 */
	private String LOGIC_CD = commonCode.EMPTYSTR; /* 전표유형 */ /* 일반계정 : 21-매입, 31-매출, 41-수금,51-반제 */ /* 부가세계정 : 21-매입, 31-매출, 41-수금,51-반제 */
	/* + iCUBE 입력 필드-------------------- */
	private String ISU_DT = "00000000"; /* 결의일자 */ /* 일반계정 : 00000000 */ /* 부가세계정 : 00000000 */
	private String ISU_SQ = commonCode.EMPTYSEQ; /* 결의번호 */ /* 일반계정 : 0 */ /* 부가세계정 : 0 */
	private String DIV_CD = commonCode.EMPTYSTR; /* 회계단위 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String DEPT_CD = commonCode.EMPTYSTR; /* 결의부서 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String EMP_CD = commonCode.EMPTYSTR; /* 작업자 */ /* 일반계정 : NULL */ /* 부가세계정 : null */
	/* - iCUBE 입력 필드-------------------- */
	private String ACCT_CD = commonCode.EMPTYSTR; /* 계정과목 */ /* 일반계정 : 계정코드 */ /* 부가세계정 : 계정코드 */
	private String DRCR_FG = commonCode.EMPTYSTR; /* 차.대구분 */ /* 일반계정 : 3-차변, 4-대변 */ /* 부가세계정 : 3-차변, 4-대변 */
	private String ACCT_AM = "0.0000"; /* 금액 */ /* 일반계정 : 계정금액 */ /* 부가세계정 : 계정금액(24-불공인경우 전표입력과동일) 원가계정 : 부가세포함금액 부가세계정 : 계정금액 0 (부가세 : CT_QT) */
	private String RMK_NB = commonCode.EMPTYSEQ; /* 적요번호 */ /* 일반계정 : 0 */ /* 부가세계정 : 0 */
	private String RMK_DC = commonCode.EMPTYSTR; /* 적요 */ /* 일반계정 : 적요 */ /* 부가세계정 : 적요 */
	private String ATTR_CD = commonCode.EMPTYSTR; /* 증빙구분 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	/* + 각 계정과목의 관리항목 설정에 따라 입력 합니다. 관리항목타입이 없는 경우에 타입은 '0'으로 합니다.-------------------- */
	private String TRCD_TY = commonCode.EMPTYSEQ; /* A_TY */ /* 일반계정 : A1,A2 */ /* 부가세계정 : A1 */
	private String TRNM_TY = commonCode.EMPTYSEQ; /* B_TY */ /* 일반계정 : B1 */ /* 부가세계정 : B1 */
	private String DEPTCD_TY = commonCode.EMPTYSEQ; /* C_TY */ /* 일반계정 : C1,C2,C4,C5,C9 */ /* 부가세계정 : 0 */
	private String PJTCD_TY = commonCode.EMPTYSEQ; /* D_TY */ /* 일반계정 : D1,D3,D4,D5,D6,D8 */ /* 부가세계정 : D5-사업장 */
	private String CTNB_TY = commonCode.EMPTYSEQ; /* E_TY */ /* 일반계정 : E2,E3,EA */ /* 부가세계정 : EA-관리번호 */
	private String FRDT_TY = commonCode.EMPTYSEQ; /* F_TY */ /* 일반계정 : F1,F2,F3 */ /* 부가세계정 : F1-발생일자 */
	private String TODT_TY = commonCode.EMPTYSEQ; /* G_TY */ /* 일반계정 : G1,G2,G3 */ /* 부가세계정 : 0 */
	private String QT_TY = commonCode.EMPTYSEQ; /* H_TY */ /* 일반계정 : H1,H2,H3,H5,H6 */ /* 부가세계정 : 24-H3, 11-H6, 16-H5, 기타-0 */
	private String AM_TY = commonCode.EMPTYSEQ; /* I_TY */ /* 일반계정 : I2,I3,I4,I5,I6 */ /* 부가세계정 : I3-과세표준 */
	private String RT_TY = commonCode.EMPTYSEQ; /* J_TY */ /* 일반계정 : J1,J2,J3 */ /* 부가세계정 : 0 */
	private String DEAL_TY = commonCode.EMPTYSEQ; /* K_TY */ /* 일반계정 : K1,K2,K3,K4,K6,K7,K8,K9 */ /* 부가세계정 : K1-세무구분 */
	private String USER1_TY = commonCode.EMPTYSEQ; /* L_TY */ /* 일반계정 : L타입 */ /* 부가세계정 : 0 */
	private String USER2_TY = commonCode.EMPTYSEQ; /* M_TY */ /* 일반계정 : M타입 */ /* 부가세계정 : 0 */
	private String TR_CD = commonCode.EMPTYSTR; /* A_CD */ /* 일반계정 : 거래처코드 */ /* 부가세계정 : 거래처코드 필수입력 */
	private String TR_NM = commonCode.EMPTYSTR; /* B_NM */ /* 일반계정 : 거래처명 */ /* 부가세계정 : 거래처명 필수입력 */
	private String CT_DEPT = commonCode.EMPTYSTR; /* C_CD */ /* 일반계정 : C_TY관련코드 */ /* 부가세계정 : NULL */
	private String DEPT_NM = commonCode.EMPTYSTR; /* C_NM */ /* 일반계정 : C_TY관련 코드명 */ /* 부가세계정 : NULL */
	private String PJT_CD = commonCode.EMPTYSTR; /* D_CD */ /* 일반계정 : D_TY관련코드 */ /* 부가세계정 : 부가세사업장코드 필수입력 */
	private String PJT_NM = commonCode.EMPTYSTR; /* D_NM */ /* 일반계정 : D_TY관련 코드명 */ /* 부가세계정 : 부가세사업장명 */
	private String CT_NB = commonCode.EMPTYSTR; /* E_CD */ /* 일반계정 : E_TY관련코드 */ /* 부가세계정 : 수출신고번호(16-수출), 기타-NULL */
	private String FR_DT = "00000000"; /* F_CD */ /* 일반계정 : 일자(20061112) */ /* 부가세계정 : 세금계산서 발행일 필수입력 */
	private String TO_DT = "00000000"; /* G_CD */ /* 일반계정 : 일자(20061112) */ /* 부가세계정 : NULL */
	private String CT_QT = "0.000000"; /* H_CD */ /* 일반계정 : 숫자12256.1251 */ /* 부가세계정 : 부가세 세무구분에 따라 입력값 : 24매입불공제 ->불공제세액 / 11과세매출 ->카드수금액 / 16수출 -> 환율 / 기타 -> NULL */
	private String CT_AM = "0.0000"; /* I_CD */ /* 일반계정 : 숫자12345.1152 */ /* 부가세계정 : 공급가액 필수입력 */
	private String CT_RT = "0.0000"; /* J_CD */ /* 일반계정 : 숫자123.1224 */ /* 부가세계정 : NULL */
	private String CT_DEAL = commonCode.EMPTYSTR; /* K_CD */ /* 일반계정 : K_TY코드 */ /* 부가세계정 : 세무구분(11,12, 21…) 필수 입력 */
	private String DEAL_NM = commonCode.EMPTYSTR; /* K_NM */ /* 일반계정 : K_TY관련 코드명 */ /* 부가세계정 : 세무구분명 , 11-과세, 12-영세… */
	private String CT_USER1 = commonCode.EMPTYSTR; /* L_CD */ /* 일반계정 : L_TY코드 */ /* 부가세계정 : 23, 24, 26=>사유구분 */
	private String USER1_NM = commonCode.EMPTYSTR; /* L_NM */ /* 일반계정 : CT_USER1 */ /* 부가세계정 : 24-불공제인경우 불공제사유코드(41 ~ 4A)입력 */
	private String CT_USER2 = commonCode.EMPTYSTR; /* M_CD */ /* 일반계정 : M_TY코드 */ /* 부가세계정 : NULL */
	private String USER2_NM = commonCode.EMPTYSTR; /* M_NM */ /* 일반계정 : CT_USER2가 */ /* 부가세계정 : NULL */
	/* - 각 계정과목의 관리항목 설정에 따라 입력 합니다. 관리항목타입이 없는 경우에 타입은 '0'으로 합니다.-------------------- */
	/* + 부가세계정 수출인경우에만 입력합니다 -------------------- */
	private String EXCH_TY = commonCode.EMPTYSTR; /* 외화종류 */ /* 일반계정 : NULL */ /* 부가세계정 : 환종(수출16) */
	private String EXCH_AM = "0.0000"; /* 외화금액 */ /* 일반계정 : NULL */ /* 부가세계정 : 외화(수출16) 4556.2222 */
	/* - 부가세계정 수출인경우에만 입력합니다 -------------------- */
	/* + 받을어음계정이 차변인 경우에만 입력 합니다. -------------------- */
	private String PAYMENT = commonCode.EMPTYSTR; /* 지급은행지점명 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String ISU_NM = commonCode.EMPTYSTR; /* 발행인 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String ENDORS_NM = commonCode.EMPTYSTR; /* 배서인 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String BILL_FG1 = commonCode.EMPTYSTR; /* 어음종류 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String BILL_FG2 = commonCode.EMPTYSTR; /* 수금구분 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	/* - 받을어음계정이 차변인 경우에만 입력 합니다. -------------------- */
	private String DUMMY1 = commonCode.EMPTYSTR; /* 여분 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String DUMMY2 = commonCode.EMPTYSTR; /* 여분 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String DUMMY3 = commonCode.EMPTYSTR; /* 여분 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String INSERT_DT = commonCode.EMPTYSTR; /* 입력일자 */ /* 일반계정 : DEFAULT 값으로처리 */ /* 부가세계정 : DEFAULT 값으로처리 */
	private String EX_FG = commonCode.EMPTYSEQ; /* 자료구분 */ /* 일반계정 : DEFAULT 값으로처리 */ /* 부가세계정 : DEFAULT 값으로처리 */
	/* + 관리항목명의 다국어 입력필드 -------------------- */
	private String TR_NMK = commonCode.EMPTYSTR; /* B_NM_다국어 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String DEPT_NMK = commonCode.EMPTYSTR; /* C_NM_다국어 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String PJT_NMK = commonCode.EMPTYSTR; /* D_NM_다국어 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String DEAL_NMK = commonCode.EMPTYSTR; /* K_NM_다국어 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String USER1_NMK = commonCode.EMPTYSTR; /* L_NM_다국어 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String USER2_NMK = commonCode.EMPTYSTR; /* M_NM_다국어 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	private String RMK_DCK = commonCode.EMPTYSTR; /* 적요_다국어 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	/* - 관리항목명의 다국어 입력필드 -------------------- */
	/* + LN_SQ가 가장 낮은번호의 ISU_DOC 를 참조합니다. -------------------- */
	private String ISU_DOC = commonCode.EMPTYSTR; /* 품의내역 */ /* 일반계정 : 품의내역 */ /* 부가세계정 : 품의내역 */
	/* - LN_SQ가 가장 낮은번호의 ISU_DOC 를 참조합니다. -------------------- */
	/* + 품의내역의 다국어 필드 -------------------- */
	private String ISU_DOCK = commonCode.EMPTYSTR; /* 품의내역_다국어 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	/* - 품의내역의 다국어 필드 -------------------- */
	/* + 모듈구분(건설ERP) 1일때 -------------------- */
	private String PRS_FG = commonCode.EMPTYSTR; /*  */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	/* - 모듈구분(건설ERP) 1일때 -------------------- */
	/* + 0.부 1.여 -------------------- */
	private String JEONJA_YN = commonCode.EMPTYSTR; /* 전자세금계산서여부 */ /* 일반계정 : NULL */ /* 부가세계정 : 0.부 1.여 */
	/* - 0.부 1.여 -------------------- */
	/* + 받을어음 지급장소명 -------------------- */
	private String PAYMENT_PT = commonCode.EMPTYSTR; /* 지급은행지점명 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	/* - 받을어음 지급장소명 -------------------- */
	/* + 받을어음 보관구분 코드 1.보유 2.수탁 3.추심의뢰 4.기타 -------------------- */
	private String DEAL_FG = commonCode.EMPTYSTR; /* 보관구분 */ /* 일반계정 : NULL */ /* 부가세계정 : NULL */
	/* - 받을어음 보관구분 코드 1.보유 2.수탁 3.추심의뢰 4.기타 -------------------- */

	public String getIN_DT ( ) {
		return IN_DT;
	}

	public void setIN_DT ( String inDt ) {
		IN_DT = inDt;
	}

	public String getIN_SQ ( ) {
		return IN_SQ;
	}

	public void setIN_SQ ( String inSq ) {
		IN_SQ = inSq;
	}

	public String getLN_SQ ( ) {
		return LN_SQ;
	}

	public void setLN_SQ ( String lnSq ) {
		LN_SQ = lnSq;
	}

	public String getCO_CD ( ) {
		return CO_CD;
	}

	public void setCO_CD ( String coCd ) {
		CO_CD = coCd;
	}

	public String getIN_DIV_CD ( ) {
		return IN_DIV_CD;
	}

	public void setIN_DIV_CD ( String inDivCd ) {
		IN_DIV_CD = inDivCd;
	}

	public String getLOGIC_CD ( ) {
		return LOGIC_CD;
	}

	public void setLOGIC_CD ( String logicCd ) {
		LOGIC_CD = logicCd;
	}

	public String getISU_DT ( ) {
		return ISU_DT;
	}

	public void setISU_DT ( String isuDt ) {
		ISU_DT = isuDt;
	}

	public String getISU_SQ ( ) {
		return ISU_SQ;
	}

	public void setISU_SQ ( String isuSq ) {
		ISU_SQ = isuSq;
	}

	public String getDIV_CD ( ) {
		return DIV_CD;
	}

	public void setDIV_CD ( String divCd ) {
		DIV_CD = divCd;
	}

	public String getDEPT_CD ( ) {
		return DEPT_CD;
	}

	public void setDEPT_CD ( String deptCd ) {
		DEPT_CD = deptCd;
	}

	public String getEMP_CD ( ) {
		return EMP_CD;
	}

	public void setEMP_CD ( String empCd ) {
		EMP_CD = empCd;
	}

	public String getACCT_CD ( ) {
		return ACCT_CD;
	}

	public void setACCT_CD ( String acctCd ) {
		ACCT_CD = acctCd;
	}

	public String getDRCR_FG ( ) {
		return DRCR_FG;
	}

	public void setDRCR_FG ( String drcrFg ) {
		DRCR_FG = drcrFg;
	}

	public String getACCT_AM ( ) {
		return ACCT_AM;
	}

	public void setACCT_AM ( String acctAm ) {
		ACCT_AM = acctAm;
	}

	public String getRMK_NB ( ) {
		return RMK_NB;
	}

	public void setRMK_NB ( String rmkNb ) {
		RMK_NB = rmkNb;
	}

	public String getRMK_DC ( ) {
		return RMK_DC;
	}

	public void setRMK_DC ( String rmkDc ) {
		RMK_DC = rmkDc;
	}

	public String getATTR_CD ( ) {
		return ATTR_CD;
	}

	public void setATTR_CD ( String attrCd ) {
		ATTR_CD = attrCd;
	}

	public String getTRCD_TY ( ) {
		return TRCD_TY;
	}

	public void setTRCD_TY ( String trcdTy ) {
		TRCD_TY = trcdTy;
	}

	public String getTRNM_TY ( ) {
		return TRNM_TY;
	}

	public void setTRNM_TY ( String trnmTy ) {
		TRNM_TY = trnmTy;
	}

	public String getDEPTCD_TY ( ) {
		return DEPTCD_TY;
	}

	public void setDEPTCD_TY ( String deptcdTy ) {
		DEPTCD_TY = deptcdTy;
	}

	public String getPJTCD_TY ( ) {
		return PJTCD_TY;
	}

	public void setPJTCD_TY ( String pjtcdTy ) {
		PJTCD_TY = pjtcdTy;
	}

	public String getCTNB_TY ( ) {
		return CTNB_TY;
	}

	public void setCTNB_TY ( String ctnbTy ) {
		CTNB_TY = ctnbTy;
	}

	public String getFRDT_TY ( ) {
		return FRDT_TY;
	}

	public void setFRDT_TY ( String frdtTy ) {
		FRDT_TY = frdtTy;
	}

	public String getTODT_TY ( ) {
		return TODT_TY;
	}

	public void setTODT_TY ( String todtTy ) {
		TODT_TY = todtTy;
	}

	public String getQT_TY ( ) {
		return QT_TY;
	}

	public void setQT_TY ( String qtTy ) {
		QT_TY = qtTy;
	}

	public String getAM_TY ( ) {
		return AM_TY;
	}

	public void setAM_TY ( String amTy ) {
		AM_TY = amTy;
	}

	public String getRT_TY ( ) {
		return RT_TY;
	}

	public void setRT_TY ( String rtTy ) {
		RT_TY = rtTy;
	}

	public String getDEAL_TY ( ) {
		return DEAL_TY;
	}

	public void setDEAL_TY ( String dealTy ) {
		DEAL_TY = dealTy;
	}

	public String getUSER1_TY ( ) {
		return USER1_TY;
	}

	public void setUSER1_TY ( String user1Ty ) {
		USER1_TY = user1Ty;
	}

	public String getUSER2_TY ( ) {
		return USER2_TY;
	}

	public void setUSER2_TY ( String user2Ty ) {
		USER2_TY = user2Ty;
	}

	public String getTR_CD ( ) {
		return TR_CD;
	}

	public void setTR_CD ( String trCd ) {
		TR_CD = trCd;
	}

	public String getTR_NM ( ) {
		return TR_NM;
	}

	public void setTR_NM ( String trNm ) {
		TR_NM = trNm;
	}

	public String getCT_DEPT ( ) {
		return CT_DEPT;
	}

	public void setCT_DEPT ( String ctDept ) {
		CT_DEPT = ctDept;
	}

	public String getDEPT_NM ( ) {
		return DEPT_NM;
	}

	public void setDEPT_NM ( String deptNm ) {
		DEPT_NM = deptNm;
	}

	public String getPJT_CD ( ) {
		return PJT_CD;
	}

	public void setPJT_CD ( String pjtCd ) {
		PJT_CD = pjtCd;
	}

	public String getPJT_NM ( ) {
		return PJT_NM;
	}

	public void setPJT_NM ( String pjtNm ) {
		PJT_NM = pjtNm;
	}

	public String getCT_NB ( ) {
		return CT_NB;
	}

	public void setCT_NB ( String ctNb ) {
		CT_NB = ctNb;
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

	public String getCT_QT ( ) {
		return CT_QT;
	}

	public void setCT_QT ( String ctQt ) {
		CT_QT = ctQt;
	}

	public String getCT_AM ( ) {
		return CT_AM;
	}

	public void setCT_AM ( String ctAm ) {
		CT_AM = ctAm;
	}

	public String getCT_RT ( ) {
		return CT_RT;
	}

	public void setCT_RT ( String ctRt ) {
		CT_RT = ctRt;
	}

	public String getCT_DEAL ( ) {
		return CT_DEAL;
	}

	public void setCT_DEAL ( String ctDeal ) {
		CT_DEAL = ctDeal;
	}

	public String getDEAL_NM ( ) {
		return DEAL_NM;
	}

	public void setDEAL_NM ( String dealNm ) {
		DEAL_NM = dealNm;
	}

	public String getCT_USER1 ( ) {
		return CT_USER1;
	}

	public void setCT_USER1 ( String ctUser1 ) {
		CT_USER1 = ctUser1;
	}

	public String getUSER1_NM ( ) {
		return USER1_NM;
	}

	public void setUSER1_NM ( String user1Nm ) {
		USER1_NM = user1Nm;
	}

	public String getCT_USER2 ( ) {
		return CT_USER2;
	}

	public void setCT_USER2 ( String ctUser2 ) {
		CT_USER2 = ctUser2;
	}

	public String getUSER2_NM ( ) {
		return USER2_NM;
	}

	public void setUSER2_NM ( String user2Nm ) {
		USER2_NM = user2Nm;
	}

	public String getEXCH_TY ( ) {
		return EXCH_TY;
	}

	public void setEXCH_TY ( String exchTy ) {
		EXCH_TY = exchTy;
	}

	public String getEXCH_AM ( ) {
		return EXCH_AM;
	}

	public void setEXCH_AM ( String exchAm ) {
		EXCH_AM = exchAm;
	}

	public String getPAYMENT ( ) {
		return PAYMENT;
	}

	public void setPAYMENT ( String payment ) {
		PAYMENT = payment;
	}

	public String getISU_NM ( ) {
		return ISU_NM;
	}

	public void setISU_NM ( String isuNm ) {
		ISU_NM = isuNm;
	}

	public String getENDORS_NM ( ) {
		return ENDORS_NM;
	}

	public void setENDORS_NM ( String endorsNm ) {
		ENDORS_NM = endorsNm;
	}

	public String getBILL_FG1 ( ) {
		return BILL_FG1;
	}

	public void setBILL_FG1 ( String billFg1 ) {
		BILL_FG1 = billFg1;
	}

	public String getBILL_FG2 ( ) {
		return BILL_FG2;
	}

	public void setBILL_FG2 ( String billFg2 ) {
		BILL_FG2 = billFg2;
	}

	public String getDUMMY1 ( ) {
		return DUMMY1;
	}

	public void setDUMMY1 ( String dUMMY1 ) {
		DUMMY1 = dUMMY1;
	}

	public String getDUMMY2 ( ) {
		return DUMMY2;
	}

	public void setDUMMY2 ( String dUMMY2 ) {
		DUMMY2 = dUMMY2;
	}

	public String getDUMMY3 ( ) {
		return DUMMY3;
	}

	public void setDUMMY3 ( String dUMMY3 ) {
		DUMMY3 = dUMMY3;
	}

	public String getINSERT_DT ( ) {
		return INSERT_DT;
	}

	public void setINSERT_DT ( String insertDt ) {
		INSERT_DT = insertDt;
	}

	public String getEX_FG ( ) {
		return EX_FG;
	}

	public void setEX_FG ( String exFg ) {
		EX_FG = exFg;
	}

	public String getTR_NMK ( ) {
		return TR_NMK;
	}

	public void setTR_NMK ( String trNmk ) {
		TR_NMK = trNmk;
	}

	public String getDEPT_NMK ( ) {
		return DEPT_NMK;
	}

	public void setDEPT_NMK ( String deptNmk ) {
		DEPT_NMK = deptNmk;
	}

	public String getPJT_NMK ( ) {
		return PJT_NMK;
	}

	public void setPJT_NMK ( String pjtNmk ) {
		PJT_NMK = pjtNmk;
	}

	public String getDEAL_NMK ( ) {
		return DEAL_NMK;
	}

	public void setDEAL_NMK ( String dealNmk ) {
		DEAL_NMK = dealNmk;
	}

	public String getUSER1_NMK ( ) {
		return USER1_NMK;
	}

	public void setUSER1_NMK ( String user1Nmk ) {
		USER1_NMK = user1Nmk;
	}

	public String getUSER2_NMK ( ) {
		return USER2_NMK;
	}

	public void setUSER2_NMK ( String user2Nmk ) {
		USER2_NMK = user2Nmk;
	}

	public String getRMK_DCK ( ) {
		return RMK_DCK;
	}

	public void setRMK_DCK ( String rmkDck ) {
		RMK_DCK = rmkDck;
	}

	public String getISU_DOC ( ) {
		return ISU_DOC;
	}

	public void setISU_DOC ( String isuDoc ) {
		ISU_DOC = isuDoc;
	}

	public String getISU_DOCK ( ) {
		return ISU_DOCK;
	}

	public void setISU_DOCK ( String isuDock ) {
		ISU_DOCK = isuDock;
	}

	public String getPRS_FG ( ) {
		return PRS_FG;
	}

	public void setPRS_FG ( String prsFg ) {
		PRS_FG = prsFg;
	}

	public String getJEONJA_YN ( ) {
		return JEONJA_YN;
	}

	public void setJEONJA_YN ( String jeonjaYn ) {
		JEONJA_YN = jeonjaYn;
	}

	public String getPAYMENT_PT ( ) {
		return PAYMENT_PT;
	}

	public void setPAYMENT_PT ( String paymentPt ) {
		PAYMENT_PT = paymentPt;
	}

	public String getDEAL_FG ( ) {
		return DEAL_FG;
	}

	public void setDEAL_FG ( String dealFg ) {
		DEAL_FG = dealFg;
	}

	@Override
	public String toString ( ) {
		return "ExiCUBEDocuVO [IN_DT=" + IN_DT + ", IN_SQ=" + IN_SQ + ", LN_SQ=" + LN_SQ + ", CO_CD=" + CO_CD + ", IN_DIV_CD=" + IN_DIV_CD + ", LOGIC_CD=" + LOGIC_CD + ", ISU_DT=" + ISU_DT + ", ISU_SQ=" + ISU_SQ + ", DIV_CD=" + DIV_CD + ", DEPT_CD=" + DEPT_CD + ", EMP_CD=" + EMP_CD + ", ACCT_CD=" + ACCT_CD + ", DRCR_FG=" + DRCR_FG + ", ACCT_AM=" + ACCT_AM + ", RMK_NB=" + RMK_NB + ", RMK_DC=" + RMK_DC + ", ATTR_CD=" + ATTR_CD + ", TRCD_TY=" + TRCD_TY + ", TRNM_TY=" + TRNM_TY + ", DEPTCD_TY=" + DEPTCD_TY + ", PJTCD_TY=" + PJTCD_TY + ", CTNB_TY=" + CTNB_TY + ", FRDT_TY=" + FRDT_TY + ", TODT_TY=" + TODT_TY + ", QT_TY=" + QT_TY + ", AM_TY=" + AM_TY + ", RT_TY=" + RT_TY + ", DEAL_TY=" + DEAL_TY + ", USER1_TY=" + USER1_TY + ", USER2_TY=" + USER2_TY + ", TR_CD=" + TR_CD + ", TR_NM=" + TR_NM + ", CT_DEPT=" + CT_DEPT + ", DEPT_NM=" + DEPT_NM + ", PJT_CD=" + PJT_CD + ", PJT_NM=" + PJT_NM + ", CT_NB=" + CT_NB + ", FR_DT=" + FR_DT + ", TO_DT=" + TO_DT + ", CT_QT=" + CT_QT + ", CT_AM=" + CT_AM
				+ ", CT_RT=" + CT_RT + ", CT_DEAL=" + CT_DEAL + ", DEAL_NM=" + DEAL_NM + ", CT_USER1=" + CT_USER1 + ", USER1_NM=" + USER1_NM + ", CT_USER2=" + CT_USER2 + ", USER2_NM=" + USER2_NM + ", EXCH_TY=" + EXCH_TY + ", EXCH_AM=" + EXCH_AM + ", PAYMENT=" + PAYMENT + ", ISU_NM=" + ISU_NM + ", ENDORS_NM=" + ENDORS_NM + ", BILL_FG1=" + BILL_FG1 + ", BILL_FG2=" + BILL_FG2 + ", DUMMY1=" + DUMMY1 + ", DUMMY2=" + DUMMY2 + ", DUMMY3=" + DUMMY3 + ", INSERT_DT=" + INSERT_DT + ", EX_FG=" + EX_FG + ", TR_NMK=" + TR_NMK + ", DEPT_NMK=" + DEPT_NMK + ", PJT_NMK=" + PJT_NMK + ", DEAL_NMK=" + DEAL_NMK + ", USER1_NMK=" + USER1_NMK + ", USER2_NMK=" + USER2_NMK + ", RMK_DCK=" + RMK_DCK + ", ISU_DOC=" + ISU_DOC + ", ISU_DOCK=" + ISU_DOCK + ", PRS_FG=" + PRS_FG + ", JEONJA_YN=" + JEONJA_YN + ", PAYMENT_PT=" + PAYMENT_PT + ", DEAL_FG=" + DEAL_FG + "]";
	}
}
