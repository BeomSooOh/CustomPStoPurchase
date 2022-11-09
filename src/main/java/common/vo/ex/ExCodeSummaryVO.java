package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExCodeSummaryVO {

	private int seq = 0;
	private String compSeq = commonCode.EMPTYSEQ; /* 회사코드 */
	private String summaryCode = commonCode.EMPTYSTR; /* 표준적요 코드 */
	private String summaryName = commonCode.EMPTYSTR; /* 표준적요 명칭 */
	private String summaryDiv = commonCode.EMPTYSTR; /* 표준적요 구분 ( A : 지출 / B : 매입 ) */
	private String drAcctCode = commonCode.EMPTYSTR; /* 차변 계정과목 코드 */
	private String drAcctName = commonCode.EMPTYSTR; /* 차변 계정과목 명칭 */
	private String crAcctCode = commonCode.EMPTYSTR; /* 대변 계정과목 코드 */
	private String crAcctName = commonCode.EMPTYSTR; /* 대변 계정과목 명칭 */
	private String vatAcctCode = commonCode.EMPTYSTR; /* 부가세 계정과목 코드 */
	private String vatAcctName = commonCode.EMPTYSTR; /* 부가세 계정과목 명칭 */
	private String erpAuthCode = commonCode.EMPTYSTR; /* ERP 증빙 코드 */
	private String erpAuthName = commonCode.EMPTYSTR; /* ERP 증빙 명칭 */
	private String bankPartnerCode = commonCode.EMPTYSTR; /* 금융거래처 코드 */
	private String bankPartnerName = commonCode.EMPTYSTR; /* 금융거래처 명칭 */
	private String formSeq = commonCode.EMPTYSEQ; /* 양식 시퀀스 */
	private String callback = commonCode.EMPTYSTR; /* 콜백 */
	private String searchStr = commonCode.EMPTYSTR; /* 검색어 */
	private String createSeq = commonCode.EMPTYSEQ; /* 생성자 */
	private String modifySeq = commonCode.EMPTYSEQ; /* 수정자 */
	private String orderNum = commonCode.EMPTYSEQ; /* 정렬순서 */
	private String groupSeq = commonCode.EMPTYSTR; /* 그룹 시퀀스 */

	public String getGroupSeq ( ) {
		return CommonConvert.CommonGetStr(groupSeq);
	}

	public void setGroupSeq ( String groupSeq ) {
		this.groupSeq = groupSeq;
	}

	public int getSeq ( ) {
		return seq;
	}

	public void setSeq ( int seq ) {
		this.seq = seq;
	}

	public String getCompSeq ( ) {
		return CommonConvert.CommonGetStr(compSeq);
	}

	public void setCompSeq ( String compSeq ) {
		this.compSeq = compSeq;
	}

	public String getSummaryCode ( ) {
		return CommonConvert.CommonGetStr(summaryCode);
	}

	public void setSummaryCode ( String summaryCode ) {
		this.summaryCode = summaryCode;
	}

	public String getSummaryName ( ) {
		return CommonConvert.CommonGetStr(summaryName);
	}

	public void setSummaryName ( String summaryName ) {
		this.summaryName = summaryName;
	}

	public String getSummaryDiv ( ) {
		return CommonConvert.CommonGetStr(summaryDiv);
	}

	public void setSummaryDiv ( String summaryDiv ) {
		this.summaryDiv = summaryDiv;
	}

	public String getDrAcctCode ( ) {
		return CommonConvert.CommonGetStr(drAcctCode);
	}

	public void setDrAcctCode ( String drAcctCode ) {
		this.drAcctCode = drAcctCode;
	}

	public String getDrAcctName ( ) {
		return CommonConvert.CommonGetStr(drAcctName);
	}

	public void setDrAcctName ( String drAcctName ) {
		this.drAcctName = drAcctName;
	}

	public String getCrAcctCode ( ) {
		return CommonConvert.CommonGetStr(crAcctCode);
	}

	public void setCrAcctCode ( String crAcctCode ) {
		this.crAcctCode = crAcctCode;
	}

	public String getCrAcctName ( ) {
		return CommonConvert.CommonGetStr(crAcctName);
	}

	public void setCrAcctName ( String cracctName ) {
		this.crAcctName = cracctName;
	}

	public String getVatAcctCode ( ) {
		return CommonConvert.CommonGetStr(vatAcctCode);
	}

	public void setVatAcctCode ( String vatAcctCode ) {
		this.vatAcctCode = vatAcctCode;
	}

	public String getVatAcctName ( ) {
		return CommonConvert.CommonGetStr(vatAcctName);
	}

	public void setVatAcctName ( String vatAcctName ) {
		this.vatAcctName = vatAcctName;
	}

	public String getBankPartnerCode ( ) {
		return CommonConvert.CommonGetStr(bankPartnerCode);
	}

	public void setBankPartnerCode ( String bankPartnerCode ) {
		this.bankPartnerCode = bankPartnerCode;
	}

	public String getBankPartnerName ( ) {
		return CommonConvert.CommonGetStr(bankPartnerName);
	}

	public void setBankPartnerName ( String bankPartnerName ) {
		this.bankPartnerName = bankPartnerName;
	}

	public String getFormSeq ( ) {
		return CommonConvert.CommonGetStr(formSeq);
	}

	public void setFormSeq ( String formSeq ) {
		this.formSeq = formSeq;
	}

	public String getCallback ( ) {
		return CommonConvert.CommonGetStr(callback);
	}

	public void setCallback ( String callback ) {
		this.callback = callback;
	}

	public String getSearchStr ( ) {
		return CommonConvert.CommonGetStr(searchStr);
	}

	public void setSearchStr ( String searchStr ) {
		this.searchStr = searchStr;
	}

	public String getCreateSeq ( ) {
		return CommonConvert.CommonGetStr(createSeq);
	}

	public void setCreateSeq ( String createSeq ) {
		this.createSeq = createSeq;
	}

	public String getModifySeq ( ) {
		return CommonConvert.CommonGetStr(modifySeq);
	}

	public void setModifySeq ( String modifySeq ) {
		this.modifySeq = modifySeq;
	}

	public String getOrderNum ( ) {
		return CommonConvert.CommonGetStr(orderNum);
	}

	public void setOrderNum ( String orderNum ) {
		this.orderNum = orderNum;
	}

	public String getErpAuthCode ( ) {
		return CommonConvert.CommonGetStr(erpAuthCode);
	}

	public void setErpAuthCode ( String erpAuthCode ) {
		this.erpAuthCode = erpAuthCode;
	}

	public String getErpAuthName ( ) {
		return CommonConvert.CommonGetStr(erpAuthName);
	}

	public void setErpAuthName ( String erpAuthName ) {
		this.erpAuthName = erpAuthName;
	}

	@Override
	public String toString ( ) {
		return "ExCodeSummaryVO [seq=" + seq + ", compSeq=" + compSeq + ", summaryCode=" + summaryCode + ", summaryName=" + summaryName + ", summaryDiv=" + summaryDiv + ", drAcctCode=" + drAcctCode + ", drAcctName=" + drAcctName + ", crAcctCode=" + crAcctCode + ", cracctName=" + crAcctName + ", vatAcctCode=" + vatAcctCode + ", vatAcctName=" + vatAcctName + ", erpAuthCode=" + erpAuthCode + ", erpAuthName=" + erpAuthName + ", bankPartnerCode=" + bankPartnerCode + ", bankPartnerName=" + bankPartnerName + ", formSeq=" + formSeq + ", callback=" + callback + ", searchStr=" + searchStr + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + "]";
	}
}
