package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExCodeBudgetiCUBEVO {

	private String CO_CD = commonCode.EMPTYSTR; /* ERP 회사코드 */
	private String BUDGET_FG = commonCode.EMPTYSTR; /* 예산 사용 구분 */
	private String DEPT_CD = commonCode.EMPTYSTR; /* 귀속 예산코드 ( 부서코드 또는 프로젝트 코드 ) */
	private String DEPT_NM = commonCode.EMPTYSTR; /* 귀속 예산명칭 ( 부서명칭 또는 프로젝트 명칭 ) */
	private String ACCT_CD = commonCode.EMPTYSTR; /* 계정과목 코드 */
	private String ACCT_NM = commonCode.EMPTYSTR; /* 계정과목 명칭 */
	private String DATA_FG = commonCode.EMPTYSTR; /* 통제구분 ( Y, H, Q, M ) */
	private String BUD_YM = commonCode.EMPTYSTR; /* 귀속년월 ( 1Q, Y, 1H, 12M ) */
	private String PROP_AM = "0.00"; /* ?? */
	private String FORM_AM = "0.00"; /* ?? */
	private String BUDGET_AM = "0.00"; /* 실행합 금액 ( 편성예산 + 조정예산 ) */
	private String ACCT_AM = "0.00"; /* ?? */
	private String PLAN_AM = "0.00"; /* 결의집행 금액 ( 자동전표 부터 집계 ) */
	private String RESULT_AM = "0.00"; /* 잔여예산 ( iCUBE 기준, 결재진행중 문서 판단 불가 ) */

	public String getCO_CD ( ) {
		return CommonConvert.CommonGetStr(CO_CD);
	}

	public void setCO_CD ( String coCd ) {
		CO_CD = coCd;
	}

	public String getBUDGET_FG ( ) {
		return CommonConvert.CommonGetStr(BUDGET_FG);
	}

	public void setBUDGET_FG ( String budgetFg ) {
		BUDGET_FG = budgetFg;
	}

	public String getDEPT_CD ( ) {
		return CommonConvert.CommonGetStr(DEPT_CD);
	}

	public void setDEPT_CD ( String deptCd ) {
		DEPT_CD = deptCd;
	}

	public String getDEPT_NM ( ) {
		return CommonConvert.CommonGetStr(DEPT_NM);
	}

	public void setDEPT_NM ( String deptNm ) {
		DEPT_NM = deptNm;
	}

	public String getACCT_CD ( ) {
		return CommonConvert.CommonGetStr(ACCT_CD);
	}

	public void setACCT_CD ( String acctCd ) {
		ACCT_CD = acctCd;
	}

	public String getACCT_NM ( ) {
		return CommonConvert.CommonGetStr(ACCT_NM);
	}

	public void setACCT_NM ( String acctNm ) {
		ACCT_NM = acctNm;
	}

	public String getDATA_FG ( ) {
		return CommonConvert.CommonGetStr(DATA_FG);
	}

	public void setDATA_FG ( String dataFg ) {
		DATA_FG = dataFg;
	}

	public String getBUD_YM ( ) {
		return CommonConvert.CommonGetStr(BUD_YM);
	}

	public void setBUD_YM ( String budYm ) {
		BUD_YM = budYm;
	}

	public String getPROP_AM ( ) {
		return CommonConvert.CommonGetStr(PROP_AM);
	}

	public void setPROP_AM ( String propAm ) {
		PROP_AM = propAm;
	}

	public String getFORM_AM ( ) {
		return CommonConvert.CommonGetStr(FORM_AM);
	}

	public void setFORM_AM ( String formAm ) {
		FORM_AM = formAm;
	}

	public String getBUDGET_AM ( ) {
		return CommonConvert.CommonGetStr(BUDGET_AM);
	}

	public void setBUDGET_AM ( String budgetAm ) {
		BUDGET_AM = budgetAm;
	}

	public String getACCT_AM ( ) {
		return CommonConvert.CommonGetStr(ACCT_AM);
	}

	public void setACCT_AM ( String acctAm ) {
		ACCT_AM = acctAm;
	}

	public String getPLAN_AM ( ) {
		return CommonConvert.CommonGetStr(PLAN_AM);
	}

	public void setPLAN_AM ( String planAm ) {
		PLAN_AM = planAm;
	}

	public String getRESULT_AM ( ) {
		return CommonConvert.CommonGetStr(RESULT_AM);
	}

	public void setRESULT_AM ( String resultAm ) {
		RESULT_AM = resultAm;
	}

	@Override
	public String toString ( ) {
		return "ExCodeBudgetiCUBEVO [CO_CD=" + CO_CD + ", BUDGET_FG=" + BUDGET_FG + ", DEPT_CD=" + DEPT_CD + ", DEPT_NM=" + DEPT_NM + ", ACCT_CD=" + ACCT_CD + ", ACCT_NM=" + ACCT_NM + ", DATA_FG=" + DATA_FG + ", BUD_YM=" + BUD_YM + ", PROP_AM=" + PROP_AM + ", FORM_AM=" + FORM_AM + ", BUDGET_AM=" + BUDGET_AM + ", ACCT_AM=" + ACCT_AM + ", PLAN_AM=" + PLAN_AM + ", RESULT_AM=" + RESULT_AM + "]";
	}
}
