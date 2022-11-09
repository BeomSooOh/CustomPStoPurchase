package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExERPiUDocuVO {

	private String ROW_ID = commonCode.EMPTYSTR; /* 타시스템번호 */
	private String ROW_NO = commonCode.EMPTYSTR; /* 타시스템 라인번호 */
	private String NO_TAX = "*"; /* 부가세번호 */
	private String CD_PC = commonCode.EMPTYSTR; /* 회계단위 */
	private String CD_WDEPT = commonCode.EMPTYSTR; /* 작성부서 */
	private String NO_DOCU = commonCode.EMPTYSTR; /* 전표번호 */
	private int NO_DOLINE = 0; /* 라인번호 */
	private String CD_COMPANY = commonCode.EMPTYSTR; /* 회사코드 */
	private String ID_WRITE = commonCode.EMPTYSTR; /* 작성사원 */
	private String CD_DOCU = "13"; /* 전표유형 */
	private String DT_ACCT = commonCode.EMPTYSTR; /* 회계일자 */
	private String ST_DOCU = "3"; /* 승인여부 */
	private String TP_DRCR = commonCode.EMPTYSTR; /* 차대구분 */
	private String CD_ACCT = commonCode.EMPTYSTR; /* 계정코드 */
	private String AMT = "0.00"; /* 금액 */
	private String CD_PARTNER = commonCode.EMPTYSTR; /* 거래처코드 */
	private String NM_PARTNER = commonCode.EMPTYSTR; /* 거래처명칭 */
	private String DT_START = commonCode.EMPTYSTR; /* 발생일자 */
	private String DT_END = commonCode.EMPTYSTR; /* 자금예정일자(만기일자) */
	private String AM_TAXSTD = "0.00"; /* 과세표준액 */
	private String AM_ADDTAX = "0.00"; /* 세액 */
	private String TP_TAX = commonCode.EMPTYSTR; /* 세무구분 */
	private String NO_COMPANY = commonCode.EMPTYSTR; /* 사업자등록번호 */
	private String NM_NOTE = commonCode.EMPTYSTR; /* 적요 */
	private String CD_BIZAREA = commonCode.EMPTYSTR; /* 귀속사업장 */
	private String CD_DEPT = commonCode.EMPTYSTR; /* 부서 */
	private String CD_CC = commonCode.EMPTYSTR; /* 코스트센터 */
	private String CD_PJT = commonCode.EMPTYSTR; /* 프로젝트코드 */
	private String CD_FUND = commonCode.EMPTYSTR; /* 자금과목코드 */
	private String NO_CASH = commonCode.EMPTYSTR; /* 현금영수증번호 */
	private String ST_MUTUAL = commonCode.EMPTYSTR; /* 불공제구분 */
	private String CD_CARD = commonCode.EMPTYSTR; /* 신용카드번호 */
	private String NO_DEPOSIT = commonCode.EMPTYSTR; /* 예적금계좌 */
	private String CD_BANK = commonCode.EMPTYSTR; /* 금융기관 */
	private String UCD_MNG1 = commonCode.EMPTYSTR; /* 사용자정의1 */
	private String UCD_MNG2 = commonCode.EMPTYSTR; /* 사용자정의2 */
	private String UCD_MNG3 = commonCode.EMPTYSTR; /* 사용자정의3 */
	private String UCD_MNG4 = commonCode.EMPTYSTR; /* 사용자정의4 */
	private String UCD_MNG5 = commonCode.EMPTYSTR; /* 사용자정의5 */
	private String CD_EMPLOY = commonCode.EMPTYSTR; /* 사원 */
	private String TP_DOCU = commonCode.EMPTYNO; /* 전표처리결과 */
	private int NO_ACCT = 0; /* 회계승인번호 */
	private String TP_TRADE = commonCode.EMPTYSTR; /* 받을어음정리구분 */
	private String CD_EXCH = commonCode.EMPTYSTR; /* 환종 */
	private String RT_EXCH = "0.00"; /* 환율 */
	private String AM_EX = "0.00"; /* 외화금액 */
	private String NO_TO = commonCode.EMPTYSTR; /* 수출신고번호 */
	private String DT_SHIPPING = commonCode.EMPTYSTR; /* 선적일자 */
	private String TP_GUBUN = "13"; /* 전표구분 */
	private String MD_TAX1 = commonCode.EMPTYSTR; /* 월/일 */
	private String NM_ITEM1 = commonCode.EMPTYSTR; /* 품명 */
	private String NM_SIZE1 = commonCode.EMPTYSTR; /* 규격 */
	private String QT_TAX1 = "0.00"; /* 수량 */
	private String AM_PRC1 = "0.00"; /* 단가 */
	private String AM_SUPPLY1 = "0.00"; /* 공급가액 */
	private String AM_TAX1 = "0.00"; /* 세액 */
	private String NM_NOTE1 = commonCode.EMPTYSTR; /* 비고 */
	private String YN_ISS = commonCode.EMPTYSEQ; /* 전자세금계산서여부 */
	/* private String ST_TAX = commonCode.EMPTYSTR; */ /* 영수,청구 */
	/* private String FINAL_STATUS = commonCode.EMPTYSTR; */ /* 전자세금계산서 상태 */
	/* private String NO_BILL = commonCode.EMPTYSTR; */ /* 전자세금계산서번호 */
	/* private String NO_ASSET = commonCode.EMPTYSTR; */ /* 자산매입번호 */
	/* private String SELL_DAM_NM = commonCode.EMPTYSTR; */ /* 발행담당자이름 */
	/* private String SELL_DAM_EMAIL = commonCode.EMPTYSTR; */ /* 발행담당자이메일주소 */
	/* private String SELL_DAM_MOBIL = commonCode.EMPTYSTR; */ /* 발행담당자핸드폰번호 */
	private String JEONJASEND15_YN = "1"; /* 국세청전송15일이내 */
	/* private String NM_PTR = commonCode.EMPTYSTR; */ /* 상대방거래처담당자 */
	/* private String EX_HP = commonCode.EMPTYSTR; */ /* 상대방거래처 HP */
	/* private String EX_EMIL = commonCode.EMPTYSTR; */ /* 상대방거래처 EMAIL */
	private String CD_BUDGET = commonCode.EMPTYSTR; /* 예산단위코드 */
	private String CD_BIZPLAN = commonCode.EMPTYSTR; /* 사업계획 */
	private String CD_BGACCT = commonCode.EMPTYSTR; /* 예산계정 */
	private String CD_MNGD1 = commonCode.EMPTYSTR; /* 관리내역1 */
	private String NM_MNGD1 = commonCode.EMPTYSTR; /* 관리내역명1 */
	private String CD_MNGD2 = commonCode.EMPTYSTR; /* 관리내역2 */
	private String NM_MNGD2 = commonCode.EMPTYSTR; /* 관리내역명2 */
	private String CD_MNGD3 = commonCode.EMPTYSTR; /* 관리내역3 */
	private String NM_MNGD3 = commonCode.EMPTYSTR; /* 관리내역명3 */
	private String CD_MNGD4 = commonCode.EMPTYSTR; /* 관리내역4 */
	private String NM_MNGD4 = commonCode.EMPTYSTR; /* 관리내역명4 */
	private String CD_MNGD5 = commonCode.EMPTYSTR; /* 관리내역5 */
	private String NM_MNGD5 = commonCode.EMPTYSTR; /* 관리내역명5 */
	private String CD_MNGD6 = commonCode.EMPTYSTR; /* 관리내역6 */
	private String NM_MNGD6 = commonCode.EMPTYSTR; /* 관리내역명6 */
	private String CD_MNGD7 = commonCode.EMPTYSTR; /* 관리내역7 */
	private String NM_MNGD7 = commonCode.EMPTYSTR; /* 관리내역명7 */
	private String CD_MNGD8 = commonCode.EMPTYSTR; /* 관리내역8 */
	private String NM_MNGD8 = commonCode.EMPTYSTR; /* 관리내역명8 */
	private String ST_BIZBOX = "1"; /* 그룹웨어 전송여부 */

	public String getROW_ID ( ) {
		return CommonConvert.CommonGetStr(ROW_ID);
	}

	public void setROW_ID ( String rowId ) {
		ROW_ID = rowId;
	}

	public String getROW_NO ( ) {
		return CommonConvert.CommonGetStr(ROW_NO);
	}

	public void setROW_NO ( String rowNo ) {
		ROW_NO = rowNo;
	}

	public String getNO_TAX ( ) {
		return CommonConvert.CommonGetStr(NO_TAX);
	}

	public void setNO_TAX ( String noTax ) {
		NO_TAX = noTax;
	}

	public String getCD_PC ( ) {
		return CommonConvert.CommonGetStr(CD_PC);
	}

	public void setCD_PC ( String cdPc ) {
		CD_PC = cdPc;
	}

	public String getCD_WDEPT ( ) {
		return CommonConvert.CommonGetStr(CD_WDEPT);
	}

	public void setCD_WDEPT ( String cdWdept ) {
		CD_WDEPT = cdWdept;
	}

	public String getNO_DOCU ( ) {
		return CommonConvert.CommonGetStr(NO_DOCU);
	}

	public void setNO_DOCU ( String noDocu ) {
		NO_DOCU = noDocu;
	}

	public int getNO_DOLINE ( ) {
		return NO_DOLINE;
	}

	public void setNO_DOLINE ( int noDoline ) {
		NO_DOLINE = noDoline;
	}

	public String getCD_COMPANY ( ) {
		return CommonConvert.CommonGetStr(CD_COMPANY);
	}

	public void setCD_COMPANY ( String cdCompany ) {
		CD_COMPANY = cdCompany;
	}

	public String getID_WRITE ( ) {
		return CommonConvert.CommonGetStr(ID_WRITE);
	}

	public void setID_WRITE ( String idWrite ) {
		ID_WRITE = idWrite;
	}

	public String getCD_DOCU ( ) {
		return CommonConvert.CommonGetStr(CD_DOCU);
	}

	public void setCD_DOCU ( String cdDocu ) {
		CD_DOCU = cdDocu;
	}

	public String getDT_ACCT ( ) {
		return CommonConvert.CommonGetStr(DT_ACCT);
	}

	public void setDT_ACCT ( String dtAcct ) {
		DT_ACCT = dtAcct;
	}

	public String getST_DOCU ( ) {
		return CommonConvert.CommonGetStr(ST_DOCU);
	}

	public void setST_DOCU ( String stDocu ) {
		ST_DOCU = stDocu;
	}

	public String getTP_DRCR ( ) {
		return CommonConvert.CommonGetStr(TP_DRCR);
	}

	public void setTP_DRCR ( String tpDrcr ) {
		TP_DRCR = tpDrcr;
	}

	public String getCD_ACCT ( ) {
		return CommonConvert.CommonGetStr(CD_ACCT);
	}

	public void setCD_ACCT ( String cdAcct ) {
		CD_ACCT = cdAcct;
	}

	public String getAMT ( ) {
		return CommonConvert.CommonGetStr(AMT);
	}

	public void setAMT ( String aMT ) {
		AMT = aMT;
	}

	public String getCD_PARTNER ( ) {
		return CommonConvert.CommonGetStr(CD_PARTNER);
	}

	public void setCD_PARTNER ( String cdPartner ) {
		CD_PARTNER = cdPartner;
	}

	public String getNM_PARTNER ( ) {
		return CommonConvert.CommonGetStr(NM_PARTNER);
	}

	public void setNM_PARTNER ( String nmPartner ) {
		NM_PARTNER = nmPartner;
	}

	public String getDT_START ( ) {
		return CommonConvert.CommonGetStr(DT_START);
	}

	public void setDT_START ( String dtStart ) {
		DT_START = dtStart;
	}

	public String getDT_END ( ) {
		return CommonConvert.CommonGetStr(DT_END);
	}

	public void setDT_END ( String dtEnd ) {
		DT_END = dtEnd;
	}

	public String getAM_TAXSTD ( ) {
		return CommonConvert.CommonGetStr(AM_TAXSTD);
	}

	public void setAM_TAXSTD ( String amTaxstd ) {
		AM_TAXSTD = amTaxstd;
	}

	public String getAM_ADDTAX ( ) {
		return CommonConvert.CommonGetStr(AM_ADDTAX);
	}

	public void setAM_ADDTAX ( String amAddtax ) {
		AM_ADDTAX = amAddtax;
	}

	public String getTP_TAX ( ) {
		return CommonConvert.CommonGetStr(TP_TAX);
	}

	public void setTP_TAX ( String tpTax ) {
		TP_TAX = tpTax;
	}

	public String getNO_COMPANY ( ) {
		return CommonConvert.CommonGetStr(NO_COMPANY);
	}

	public void setNO_COMPANY ( String noCompany ) {
		NO_COMPANY = noCompany;
	}

	public String getNM_NOTE ( ) {
		return CommonConvert.CommonGetStr(NM_NOTE);
	}

	public void setNM_NOTE ( String nmNote ) {
		NM_NOTE = nmNote;
	}

	public String getCD_BIZAREA ( ) {
		return CommonConvert.CommonGetStr(CD_BIZAREA);
	}

	public void setCD_BIZAREA ( String cdBizarea ) {
		CD_BIZAREA = cdBizarea;
	}

	public String getCD_DEPT ( ) {
		return CommonConvert.CommonGetStr(CD_DEPT);
	}

	public void setCD_DEPT ( String cdDept ) {
		CD_DEPT = cdDept;
	}

	public String getCD_CC ( ) {
		return CommonConvert.CommonGetStr(CD_CC);
	}

	public void setCD_CC ( String cdCc ) {
		CD_CC = cdCc;
	}

	public String getCD_PJT ( ) {
		return CommonConvert.CommonGetStr(CD_PJT);
	}

	public void setCD_PJT ( String cdPjt ) {
		CD_PJT = cdPjt;
	}

	public String getCD_FUND ( ) {
		return CommonConvert.CommonGetStr(CD_FUND);
	}

	public void setCD_FUND ( String cdFund ) {
		CD_FUND = cdFund;
	}

	public String getNO_CASH ( ) {
		return CommonConvert.CommonGetStr(NO_CASH);
	}

	public void setNO_CASH ( String noCash ) {
		NO_CASH = noCash;
	}

	public String getST_MUTUAL ( ) {
		return CommonConvert.CommonGetStr(ST_MUTUAL);
	}

	public void setST_MUTUAL ( String stMutual ) {
		ST_MUTUAL = stMutual;
	}

	public String getCD_CARD ( ) {
		return CommonConvert.CommonGetStr(CD_CARD);
	}

	public void setCD_CARD ( String cdCard ) {
		CD_CARD = cdCard;
	}

	public String getNO_DEPOSIT ( ) {
		return CommonConvert.CommonGetStr(NO_DEPOSIT);
	}

	public void setNO_DEPOSIT ( String noDeposit ) {
		NO_DEPOSIT = noDeposit;
	}

	public String getCD_BANK ( ) {
		return CommonConvert.CommonGetStr(CD_BANK);
	}

	public void setCD_BANK ( String cdBank ) {
		CD_BANK = cdBank;
	}

	public String getUCD_MNG1 ( ) {
		return CommonConvert.CommonGetStr(UCD_MNG1);
	}

	public void setUCD_MNG1 ( String ucdMng1 ) {
		UCD_MNG1 = ucdMng1;
	}

	public String getUCD_MNG2 ( ) {
		return CommonConvert.CommonGetStr(UCD_MNG2);
	}

	public void setUCD_MNG2 ( String ucdMng2 ) {
		UCD_MNG2 = ucdMng2;
	}

	public String getUCD_MNG3 ( ) {
		return CommonConvert.CommonGetStr(UCD_MNG3);
	}

	public void setUCD_MNG3 ( String ucdMng3 ) {
		UCD_MNG3 = ucdMng3;
	}

	public String getUCD_MNG4 ( ) {
		return CommonConvert.CommonGetStr(UCD_MNG4);
	}

	public void setUCD_MNG4 ( String ucdMng4 ) {
		UCD_MNG4 = ucdMng4;
	}

	public String getUCD_MNG5 ( ) {
		return CommonConvert.CommonGetStr(UCD_MNG5);
	}

	public void setUCD_MNG5 ( String ucdMng5 ) {
		UCD_MNG5 = ucdMng5;
	}

	public String getCD_EMPLOY ( ) {
		return CommonConvert.CommonGetStr(CD_EMPLOY);
	}

	public void setCD_EMPLOY ( String cdEmploy ) {
		CD_EMPLOY = cdEmploy;
	}

	public String getTP_DOCU ( ) {
		return CommonConvert.CommonGetStr(TP_DOCU);
	}

	public void setTP_DOCU ( String tpDocu ) {
		TP_DOCU = tpDocu;
	}

	public int getNO_ACCT ( ) {
		return NO_ACCT;
	}

	public void setNO_ACCT ( int noAcct ) {
		NO_ACCT = noAcct;
	}

	public String getTP_TRADE ( ) {
		return CommonConvert.CommonGetStr(TP_TRADE);
	}

	public void setTP_TRADE ( String tpTrade ) {
		TP_TRADE = tpTrade;
	}

	public String getCD_EXCH ( ) {
		return CommonConvert.CommonGetStr(CD_EXCH);
	}

	public void setCD_EXCH ( String cdExch ) {
		CD_EXCH = cdExch;
	}

	public String getRT_EXCH ( ) {
		return CommonConvert.CommonGetStr(RT_EXCH);
	}

	public void setRT_EXCH ( String rtExch ) {
		RT_EXCH = rtExch;
	}

	public String getAM_EX ( ) {
		return CommonConvert.CommonGetStr(AM_EX);
	}

	public void setAM_EX ( String amEx ) {
		AM_EX = amEx;
	}

	public String getNO_TO ( ) {
		return CommonConvert.CommonGetStr(NO_TO);
	}

	public void setNO_TO ( String noTo ) {
		NO_TO = noTo;
	}

	public String getDT_SHIPPING ( ) {
		return CommonConvert.CommonGetStr(DT_SHIPPING);
	}

	public void setDT_SHIPPING ( String dtShipping ) {
		DT_SHIPPING = dtShipping;
	}

	public String getTP_GUBUN ( ) {
		return CommonConvert.CommonGetStr(TP_GUBUN);
	}

	public void setTP_GUBUN ( String tpGubun ) {
		TP_GUBUN = tpGubun;
	}

	public String getMD_TAX1 ( ) {
		return CommonConvert.CommonGetStr(MD_TAX1);
	}

	public void setMD_TAX1 ( String mdTax1 ) {
		MD_TAX1 = mdTax1;
	}

	public String getNM_ITEM1 ( ) {
		return CommonConvert.CommonGetStr(NM_ITEM1);
	}

	public void setNM_ITEM1 ( String nmItem1 ) {
		NM_ITEM1 = nmItem1;
	}

	public String getNM_SIZE1 ( ) {
		return CommonConvert.CommonGetStr(NM_SIZE1);
	}

	public void setNM_SIZE1 ( String nmSize1 ) {
		NM_SIZE1 = nmSize1;
	}

	public String getQT_TAX1 ( ) {
		return CommonConvert.CommonGetStr(QT_TAX1);
	}

	public void setQT_TAX1 ( String qtTax1 ) {
		QT_TAX1 = qtTax1;
	}

	public String getAM_PRC1 ( ) {
		return CommonConvert.CommonGetStr(AM_PRC1);
	}

	public void setAM_PRC1 ( String amPrc1 ) {
		AM_PRC1 = amPrc1;
	}

	public String getAM_SUPPLY1 ( ) {
		return CommonConvert.CommonGetStr(AM_SUPPLY1);
	}

	public void setAM_SUPPLY1 ( String amSupply1 ) {
		AM_SUPPLY1 = amSupply1;
	}

	public String getAM_TAX1 ( ) {
		return CommonConvert.CommonGetStr(AM_TAX1);
	}

	public void setAM_TAX1 ( String amTax1 ) {
		AM_TAX1 = amTax1;
	}

	public String getNM_NOTE1 ( ) {
		return CommonConvert.CommonGetStr(NM_NOTE1);
	}

	public void setNM_NOTE1 ( String nmNote1 ) {
		NM_NOTE1 = nmNote1;
	}

	public String getYN_ISS ( ) {
		return CommonConvert.CommonGetStr(YN_ISS);
	}

	public void setYN_ISS ( String ynIss ) {
		YN_ISS = ynIss;
	}

	public String getJEONJASEND15_YN ( ) {
		return CommonConvert.CommonGetStr(JEONJASEND15_YN);
	}

	public void setJEONJASEND15_YN ( String jeonjasend15Yn ) {
		JEONJASEND15_YN = jeonjasend15Yn;
	}

	public String getCD_BUDGET ( ) {
		return CommonConvert.CommonGetStr(CD_BUDGET);
	}

	public void setCD_BUDGET ( String cdBudget ) {
		CD_BUDGET = cdBudget;
	}

	public String getCD_BIZPLAN ( ) {
		return CommonConvert.CommonGetStr(CD_BIZPLAN);
	}

	public void setCD_BIZPLAN ( String cdBizplan ) {
		CD_BIZPLAN = cdBizplan;
	}

	public String getCD_BGACCT ( ) {
		return CommonConvert.CommonGetStr(CD_BGACCT);
	}

	public void setCD_BGACCT ( String cdBgacct ) {
		CD_BGACCT = cdBgacct;
	}

	public String getCD_MNGD1 ( ) {
		return CommonConvert.CommonGetStr(CD_MNGD1);
	}

	public void setCD_MNGD1 ( String cdMngd1 ) {
		CD_MNGD1 = cdMngd1;
	}

	public String getNM_MNGD1 ( ) {
		return CommonConvert.CommonGetStr(NM_MNGD1);
	}

	public void setNM_MNGD1 ( String nmMngd1 ) {
		NM_MNGD1 = nmMngd1;
	}

	public String getCD_MNGD2 ( ) {
		return CommonConvert.CommonGetStr(CD_MNGD2);
	}

	public void setCD_MNGD2 ( String cdMngd2 ) {
		CD_MNGD2 = cdMngd2;
	}

	public String getNM_MNGD2 ( ) {
		return CommonConvert.CommonGetStr(NM_MNGD2);
	}

	public void setNM_MNGD2 ( String nmMngd2 ) {
		NM_MNGD2 = nmMngd2;
	}

	public String getCD_MNGD3 ( ) {
		return CommonConvert.CommonGetStr(CD_MNGD3);
	}

	public void setCD_MNGD3 ( String cdMngd3 ) {
		CD_MNGD3 = cdMngd3;
	}

	public String getNM_MNGD3 ( ) {
		return CommonConvert.CommonGetStr(NM_MNGD3);
	}

	public void setNM_MNGD3 ( String nmMngd3 ) {
		NM_MNGD3 = nmMngd3;
	}

	public String getCD_MNGD4 ( ) {
		return CommonConvert.CommonGetStr(CD_MNGD4);
	}

	public void setCD_MNGD4 ( String cdMngd4 ) {
		CD_MNGD4 = cdMngd4;
	}

	public String getNM_MNGD4 ( ) {
		return CommonConvert.CommonGetStr(NM_MNGD4);
	}

	public void setNM_MNGD4 ( String nmMngd4 ) {
		NM_MNGD4 = nmMngd4;
	}

	public String getCD_MNGD5 ( ) {
		return CommonConvert.CommonGetStr(CD_MNGD5);
	}

	public void setCD_MNGD5 ( String cdMngd5 ) {
		CD_MNGD5 = cdMngd5;
	}

	public String getNM_MNGD5 ( ) {
		return CommonConvert.CommonGetStr(NM_MNGD5);
	}

	public void setNM_MNGD5 ( String nmMngd5 ) {
		NM_MNGD5 = nmMngd5;
	}

	public String getCD_MNGD6 ( ) {
		return CommonConvert.CommonGetStr(CD_MNGD6);
	}

	public void setCD_MNGD6 ( String cdMngd6 ) {
		CD_MNGD6 = cdMngd6;
	}

	public String getNM_MNGD6 ( ) {
		return CommonConvert.CommonGetStr(NM_MNGD6);
	}

	public void setNM_MNGD6 ( String nmMngd6 ) {
		NM_MNGD6 = nmMngd6;
	}

	public String getCD_MNGD7 ( ) {
		return CommonConvert.CommonGetStr(CD_MNGD7);
	}

	public void setCD_MNGD7 ( String cdMngd7 ) {
		CD_MNGD7 = cdMngd7;
	}

	public String getNM_MNGD7 ( ) {
		return CommonConvert.CommonGetStr(NM_MNGD7);
	}

	public void setNM_MNGD7 ( String nmMngd7 ) {
		NM_MNGD7 = nmMngd7;
	}

	public String getCD_MNGD8 ( ) {
		return CommonConvert.CommonGetStr(CD_MNGD8);
	}

	public void setCD_MNGD8 ( String cdMngd8 ) {
		CD_MNGD8 = cdMngd8;
	}

	public String getNM_MNGD8 ( ) {
		return CommonConvert.CommonGetStr(NM_MNGD8);
	}

	public void setNM_MNGD8 ( String nmMngd8 ) {
		NM_MNGD8 = nmMngd8;
	}

	public String getST_BIZBOX ( ) {
		return CommonConvert.CommonGetStr(ST_BIZBOX);
	}

	public void setST_BIZBOX ( String stBizbox ) {
		ST_BIZBOX = stBizbox;
	}

	@Override
	public String toString ( ) {
		return "ExERPiUDocuVO [ROW_ID=" + ROW_ID + ", ROW_NO=" + ROW_NO + ", NO_TAX=" + NO_TAX + ", CD_PC=" + CD_PC + ", CD_WDEPT=" + CD_WDEPT + ", NO_DOCU=" + NO_DOCU + ", NO_DOLINE=" + NO_DOLINE + ", CD_COMPANY=" + CD_COMPANY + ", ID_WRITE=" + ID_WRITE + ", CD_DOCU=" + CD_DOCU + ", DT_ACCT=" + DT_ACCT + ", ST_DOCU=" + ST_DOCU + ", TP_DRCR=" + TP_DRCR + ", CD_ACCT=" + CD_ACCT + ", AMT=" + AMT + ", CD_PARTNER=" + CD_PARTNER + ", NM_PARTNER=" + NM_PARTNER + ", DT_START=" + DT_START + ", DT_END=" + DT_END + ", AM_TAXSTD=" + AM_TAXSTD + ", AM_ADDTAX=" + AM_ADDTAX + ", TP_TAX=" + TP_TAX + ", NO_COMPANY=" + NO_COMPANY + ", NM_NOTE=" + NM_NOTE + ", CD_BIZAREA=" + CD_BIZAREA + ", CD_DEPT=" + CD_DEPT + ", CD_CC=" + CD_CC + ", CD_PJT=" + CD_PJT + ", CD_FUND=" + CD_FUND + ", NO_CASH=" + NO_CASH + ", ST_MUTUAL=" + ST_MUTUAL + ", CD_CARD=" + CD_CARD + ", NO_DEPOSIT=" + NO_DEPOSIT + ", CD_BANK=" + CD_BANK + ", UCD_MNG1=" + UCD_MNG1 + ", UCD_MNG2=" + UCD_MNG2 + ", UCD_MNG3=" + UCD_MNG3
				+ ", UCD_MNG4=" + UCD_MNG4 + ", UCD_MNG5=" + UCD_MNG5 + ", CD_EMPLOY=" + CD_EMPLOY + ", TP_DOCU=" + TP_DOCU + ", NO_ACCT=" + NO_ACCT + ", TP_TRADE=" + TP_TRADE + ", CD_EXCH=" + CD_EXCH + ", RT_EXCH=" + RT_EXCH + ", AM_EX=" + AM_EX + ", NO_TO=" + NO_TO + ", DT_SHIPPING=" + DT_SHIPPING + ", TP_GUBUN=" + TP_GUBUN + ", MD_TAX1=" + MD_TAX1 + ", NM_ITEM1=" + NM_ITEM1 + ", NM_SIZE1=" + NM_SIZE1 + ", QT_TAX1=" + QT_TAX1 + ", AM_PRC1=" + AM_PRC1 + ", AM_SUPPLY1=" + AM_SUPPLY1 + ", AM_TAX1=" + AM_TAX1 + ", NM_NOTE1=" + NM_NOTE1 + ", YN_ISS=" + YN_ISS + ", JEONJASEND15_YN=" + JEONJASEND15_YN + ", CD_BUDGET=" + CD_BUDGET + ", CD_BIZPLAN=" + CD_BIZPLAN + ", CD_BGACCT=" + CD_BGACCT + ", CD_MNGD1=" + CD_MNGD1 + ", NM_MNGD1=" + NM_MNGD1 + ", CD_MNGD2=" + CD_MNGD2 + ", NM_MNGD2=" + NM_MNGD2 + ", CD_MNGD3=" + CD_MNGD3 + ", NM_MNGD3=" + NM_MNGD3 + ", CD_MNGD4=" + CD_MNGD4 + ", NM_MNGD4=" + NM_MNGD4 + ", CD_MNGD5=" + CD_MNGD5 + ", NM_MNGD5=" + NM_MNGD5 + ", CD_MNGD6=" + CD_MNGD6
				+ ", NM_MNGD6=" + NM_MNGD6 + ", CD_MNGD7=" + CD_MNGD7 + ", NM_MNGD7=" + NM_MNGD7 + ", CD_MNGD8=" + CD_MNGD8 + ", NM_MNGD8=" + NM_MNGD8 + ", ST_BIZBOX=" + ST_BIZBOX + "]";
	}
}
