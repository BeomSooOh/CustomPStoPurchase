package common.vo.ex;

import java.text.DecimalFormat;

import common.vo.common.CommonInterface.commonCode;

public class ExExpendForeignCurrencyVO {
	private String erpCompSeq = commonCode.EMPTYSTR; /* ERP회사코드 */
	private String authDate = commonCode.EMPTYSTR; /* 증빙일자 */
	private String exchangeUnitCode = commonCode.EMPTYSTR; /* 환종코드 */
	private String exchangeUnitName = commonCode.EMPTYSTR; /* 환종명 */
	private String exchangeRate = commonCode.EMPTYSEQ; /* 환율 */
	private String foreignCurrencyAmount = commonCode.EMPTYSEQ; /* 외화금액 */
	private String drAcctCode = commonCode.EMPTYSTR; /* 차변계정코드 */
	private String crAcctCode = commonCode.EMPTYSTR; /* 대변계정코드 */
	private String foreignAcctYN = commonCode.EMPTYSTR; /* 외화계정 여부(Y/N) */
	private String resultExchangeRate = commonCode.EMPTYSEQ; /* 환율정보(ERPiU) */
	private String resultRoundingType = commonCode.EMPTYSTR; /* 올림구분 */
	private String resultAcctCount = commonCode.EMPTYSTR; /* 외화계정인지 확인(조회 갯수가 1개 이상일때) */
	
	public String getErpCompSeq() {
		return erpCompSeq;
	}
	
	public void setErpCompSeq(String erpCompSeq) {
		this.erpCompSeq = erpCompSeq;
	}
	
	public String getAuthDate() {
		return authDate;
	}
	
	public void setAuthDate(String authDate) {
		this.authDate = authDate;
	}
	
	public String getExchangeUnitCode() {
		return exchangeUnitCode;
	}

	public void setExchangeUnitCode(String exchangeUnitCode) {
		this.exchangeUnitCode = exchangeUnitCode;
	}

	public String getExchangeUnitName() {
		return exchangeUnitName;
	}
	
	public void setExchangeUnitName(String exchangeUnitName) {
		this.exchangeUnitName = exchangeUnitName;
	}
	
	public String getExchangeRate() {
		return exchangeRate;
	}

	public void setExchangeRate(String exchangeRate) {
		this.exchangeRate = exchangeRate.replaceAll("\\,", "");
	}

	public String getForeignCurrencyAmount() {
		return foreignCurrencyAmount;
	}

	public void setForeignCurrencyAmount(String foreignCurrencyAmount) {
		this.foreignCurrencyAmount = foreignCurrencyAmount.replaceAll("\\,", "");
	}

	public String getDrAcctCode() {
		return drAcctCode;
	}

	public void setDrAcctCode(String drAcctCode) {
		this.drAcctCode = drAcctCode;
	}
	
	public String getCrAcctCode() {
		return crAcctCode;
	}

	public void setCrAcctCode(String crAcctCode) {
		this.crAcctCode = crAcctCode;
	}

	public String getForeignAcctYN() {
		return foreignAcctYN;
	}

	public void setForeignAcctYN(String foreignAcctYN) {
		this.foreignAcctYN = foreignAcctYN;
	}

	public String getResultExchangeRate() {
		return resultExchangeRate;
	}
	
	public void setResultExchangeRate(String resultExchangeRate) {
		//소수점 둘째자리에서 반올림
		DecimalFormat df = new DecimalFormat("0.00");
		
		this.resultExchangeRate = df.format(Double.valueOf(resultExchangeRate));
	}
	
	public String getResultRoundingType() {
		return resultRoundingType;
	}

	public void setResultRoundingType(String resultRoundingType) {
		this.resultRoundingType = resultRoundingType;
	}

	public String getResultAcctCount() {
		return resultAcctCount;
	}

	public void setResultAcctCount(String resultAcctCount) {
		this.resultAcctCount = resultAcctCount;
	}

	@Override
	public String toString ( ) {
		return "ExExpendForeignCurrencyVO [erpCompSeq=" + erpCompSeq + 
				                        ", authDate=" + authDate + 
				                        ", exchangeUnitCode=" + exchangeUnitCode + 
				                        ", exchangeUnitName=" + exchangeUnitName + 
				                        ", exchangeRate=" + exchangeRate + 
				                        ", foreignCurrencyAmount=" + foreignCurrencyAmount + 
				                        ", drAcctCode=" + drAcctCode + 
				                        ", crAcctCode=" + crAcctCode + 
				                        ", foreignAcctYN=" + foreignAcctYN + 
				                        ", resultExchangeRate=" + resultExchangeRate + 
				                        ", resultRoundingType=" + resultRoundingType + 
				                        ", resultAcctCount=" + resultAcctCount + 
				                        "]";
	}
}
