package common.vo.ex;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExExpendSlipVO {

	private String groupSeq = commonCode.EMPTYSEQ; /* 그룹 시퀀스 */
	private String compSeq = commonCode.EMPTYSEQ; /* 귀속 회사 시퀀스 */
	private String erpCompSeq = commonCode.EMPTYSTR; /* ERP 회사코드 */
	private String expendSeq = commonCode.EMPTYSEQ; /* 지출결의 시퀀스 */
	private String listSeq = commonCode.EMPTYSEQ; /* 지출결의 항목 시퀀스 */
	private String slipSeq = commonCode.EMPTYSEQ; /* 지출결의 항목 분개 시퀀스 */
	private int summarySeq = 0; /* 표준적요 시퀀스 */
	private int authSeq = 0; /* 증빙유형 시퀀스 */
	private int writeSeq = 0; /* 작성자 시퀀스 */
	private int empSeq = 0; /* 사용자 시퀀스 */
	private int budgetSeq = 0; /* 예산 시퀀스 */
	private int projectSeq = 0; /* 프로젝트 시퀀스 */
	private int partnerSeq = 0; /* 거래처 시퀀스 */
	private int cardSeq = 0; /* 카드 시퀀스 */
	private int feeSeq = 0; /* 접대비부표 시퀀스 */
	private String drcrGbn = commonCode.EMPTYSTR; /* 차대 구분 */
	private String acctCode = commonCode.EMPTYSTR; /* 계정과목 코드 */
	private String acctName = commonCode.EMPTYSTR; /* 계정과목 명칭 */
	private String vatYN = commonCode.EMPTYNO; /* 부가세여부 */
	private String authDate = commonCode.EMPTYSTR; /* 증빙일자 */
	private String note = commonCode.EMPTYSTR; /* 적요 */
	private String amt = commonCode.EMPTYSEQ; /* 금액 */
	private String subStdAmt = commonCode.EMPTYSEQ; /* 과세표준액 */
	private String subTaxAmt = commonCode.EMPTYSEQ; /* 세액 */
	private String interfaceType = commonCode.EMPTYSTR; /* 외부연동 구분 값 */
	private String interfaceMId = commonCode.EMPTYSEQ; /* 외부연동 마스터 아이디 */
	private String interfaceDId = commonCode.EMPTYSEQ; /* 외부연동 디테일 아이디 */
	private String rowId = commonCode.EMPTYSTR; /* ERPiU GMMSUM 연동 KEY 1 */
	private String rowNo = commonCode.EMPTYSTR; /* ERPiU GMMSUM 연동 KEY 2 */
	private String jsonStr = commonCode.EMPTYSTR;
	private String formSeq = commonCode.EMPTYSEQ; /* 양식 아이디 */
	private String callback = commonCode.EMPTYSTR;
	private String createSeq = commonCode.EMPTYSEQ; /* 생성자 */
	private String modifySeq = commonCode.EMPTYSEQ; /* 수정자 */
	private String exchangeUnitCode = commonCode.EMPTYSTR; /* 환종코드 */
    private String exchangeUnitName = commonCode.EMPTYSTR; /* 환종명 */
    private String exchangeRate = commonCode.EMPTYSEQ; /* 환율 */
    private String foreignCurrencyAmount = commonCode.EMPTYSEQ; /* 외화금액 */
    private String foreignAcctYN = commonCode.EMPTYSTR; /* 외화계정 여부(Y/N) */

	public String getGroupSeq ( ) {
		return CommonConvert.CommonGetStr(groupSeq);
	}

	public void setGroupSeq ( String groupSeq ) {
		this.groupSeq = groupSeq;
	}

	public String getCompSeq ( ) {
		return CommonConvert.CommonGetStr(compSeq);
	}

	public void setCompSeq ( String compSeq ) {
		this.compSeq = compSeq;
	}

	public String getErpCompSeq ( ) {
		return CommonConvert.CommonGetStr(erpCompSeq);
	}

	public void setErpCompSeq ( String erpCompSeq ) {
		this.erpCompSeq = erpCompSeq;
	}

	public String getExpendSeq ( ) {
		return CommonConvert.CommonGetStr(expendSeq);
	}

	public void setExpendSeq ( String expendSeq ) {
		this.expendSeq = expendSeq;
	}

	public String getListSeq ( ) {
		return CommonConvert.CommonGetStr(listSeq);
	}

	public void setListSeq ( String listSeq ) {
		this.listSeq = listSeq;
	}

	public String getSlipSeq ( ) {
		return CommonConvert.CommonGetStr(slipSeq);
	}

	public void setSlipSeq ( String slipSeq ) {
		this.slipSeq = slipSeq;
	}

	public int getSummarySeq ( ) {
		return summarySeq;
	}

	public void setSummarySeq ( int summarySeq ) {
		this.summarySeq = summarySeq;
	}

	public int getAuthSeq ( ) {
		return authSeq;
	}

	public void setAuthSeq ( int authSeq ) {
		this.authSeq = authSeq;
	}

	public int getWriteSeq ( ) {
		return writeSeq;
	}

	public void setWriteSeq ( int writeSeq ) {
		this.writeSeq = writeSeq;
	}

	public int getEmpSeq ( ) {
		return empSeq;
	}

	public void setEmpSeq ( int empSeq ) {
		this.empSeq = empSeq;
	}

	public int getBudgetSeq ( ) {
		return budgetSeq;
	}

	public void setBudgetSeq ( int budgetSeq ) {
		this.budgetSeq = budgetSeq;
	}

	public int getProjectSeq ( ) {
		return projectSeq;
	}

	public void setProjectSeq ( int projectSeq ) {
		this.projectSeq = projectSeq;
	}

	public int getPartnerSeq ( ) {
		return partnerSeq;
	}

	public void setPartnerSeq ( int partnerSeq ) {
		this.partnerSeq = partnerSeq;
	}

	public int getCardSeq ( ) {
		return cardSeq;
	}

	public void setCardSeq ( int cardSeq ) {
		this.cardSeq = cardSeq;
	}

	public String getDrcrGbn ( ) {
		return CommonConvert.CommonGetStr(drcrGbn);
	}

	public void setDrcrGbn ( String drcrGbn ) {
		this.drcrGbn = drcrGbn;
	}

	public String getAcctCode ( ) {
		return CommonConvert.CommonGetStr(acctCode);
	}

	public void setAcctCode ( String acctCode ) {
		this.acctCode = acctCode;
	}

	public String getAcctName ( ) {
		return CommonConvert.CommonGetStr(acctName);
	}

	public void setAcctName ( String acctName ) {
		this.acctName = acctName;
	}

	public String getVatYN ( ) {
		return CommonConvert.CommonGetStr(vatYN);
	}

	public void setVatYN ( String vatYN ) {
		this.vatYN = vatYN;
	}

	public String getAuthDate ( ) {
		return CommonConvert.CommonGetStr(authDate);
	}

	public void setAuthDate ( String authDate ) {
		this.authDate = authDate;
	}

	public String getNote ( ) {
		return CommonConvert.CommonGetStr(note);
	}

	public void setNote ( String note ) {
		this.note = note;
	}

	public String getAmt ( ) {
		return CommonConvert.CommonGetStr(amt);
	}

	public void setAmt ( String amt ) {
		this.amt = amt;
	}

	public String getSubStdAmt ( ) {
		return CommonConvert.CommonGetStr(subStdAmt);
	}

	public void setSubStdAmt ( String subStdAmt ) {
		this.subStdAmt = subStdAmt;
	}

	public String getSubTaxAmt ( ) {
		return CommonConvert.CommonGetStr(subTaxAmt);
	}

	public void setSubTaxAmt ( String subTaxAmt ) {
		this.subTaxAmt = subTaxAmt;
	}

	public String getInterfaceType ( ) {
		return CommonConvert.CommonGetStr(interfaceType);
	}

	public void setInterfaceType ( String interfaceType ) {
		this.interfaceType = interfaceType;
	}

	public String getInterfaceMId ( ) {
		return CommonConvert.CommonGetStr(interfaceMId);
	}

	public void setInterfaceMId ( String interfaceMId ) {
		this.interfaceMId = interfaceMId;
	}

	public String getInterfaceDId ( ) {
		return CommonConvert.CommonGetStr(interfaceDId);
	}

	public void setInterfaceDId ( String interfaceDId ) {
		this.interfaceDId = interfaceDId;
	}

	public String getRowId ( ) {
		return CommonConvert.CommonGetStr(rowId);
	}

	public void setRowId ( String rowId ) {
		this.rowId = rowId;
	}

	public String getRowNo ( ) {
		return CommonConvert.CommonGetStr(rowNo);
	}

	public void setRowNo ( String rowNo ) {
		this.rowNo = rowNo;
	}

	public String getJsonStr ( ) {
		return CommonConvert.CommonGetStr(jsonStr);
	}

	public void setJsonStr ( String jsonStr ) {
		this.jsonStr = jsonStr;
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
		this.exchangeRate = exchangeRate;
	}

	public String getForeignCurrencyAmount() {
		return foreignCurrencyAmount;
	}

	public void setForeignCurrencyAmount(String foreignCurrencyAmount) {
		this.foreignCurrencyAmount = foreignCurrencyAmount;
	}
	
	public String getForeignAcctYN() {
		return foreignAcctYN;
	}

	public void setForeignAcctYN(String foreignAcctYN) {
		this.foreignAcctYN = foreignAcctYN;
	}

	public void setDr ( ExExpendListVO listVo, LoginVO loginVo ) {
		this.setExpendSeq( listVo.getExpendSeq( ) );
		this.setListSeq( listVo.getListSeq( ) );
		this.setWriteSeq( listVo.getWriteSeq( ) );
		this.setEmpSeq( listVo.getEmpSeq( ) );
		this.setSummarySeq( listVo.getSummarySeq( ) );
		this.setAuthSeq( listVo.getAuthSeq( ) );
		this.setBudgetSeq( listVo.getBudgetSeq( ) );
		this.setProjectSeq( listVo.getProjectSeq( ) );
		this.setPartnerSeq( listVo.getPartnerSeq( ) );
		this.setCardSeq( listVo.getCardSeq( ) );
		this.setFeeSeq( listVo.getFeeSeq( ) );
		this.setDrcrGbn( "dr" );
		this.setAuthDate( listVo.getAuthDate( ) );
		this.setNote( listVo.getNote( ) );
		this.setAmt( listVo.getStdAmt( ) );
		this.setSubStdAmt( commonCode.EMPTYSEQ );
		this.setSubTaxAmt( commonCode.EMPTYSEQ );
		this.setInterfaceType( listVo.getInterfaceType( ) );
		this.setInterfaceMId( listVo.getInterfaceMId( ) );
		this.setInterfaceDId( listVo.getInterfaceDId( ) );
		this.setCreateSeq( loginVo.getUniqId( ) );
		this.setModifySeq( loginVo.getUniqId( ) );
		// 외화정보
		this.setExchangeUnitCode( listVo.getExchangeUnitCode( ) );
		this.setExchangeUnitName( listVo.getExchangeUnitName( ) );
		this.setExchangeRate( listVo.getExchangeRate( ) );
		this.setForeignCurrencyAmount( listVo.getForeignCurrencyAmount( ) );
		this.setForeignAcctYN(listVo.getForeignAcctYN());
	}

	public void setVat ( ExExpendListVO listVo, LoginVO loginVo ) {
		this.setExpendSeq( listVo.getExpendSeq( ) );
		this.setListSeq( listVo.getListSeq( ) );
		this.setWriteSeq( listVo.getWriteSeq( ) );
		this.setEmpSeq( listVo.getEmpSeq( ) );
		this.setSummarySeq( listVo.getSummarySeq( ) );
		this.setAuthSeq( listVo.getAuthSeq( ) );
		/* this.setBudgetSeq(listVo.getBudgetSeq()); */
		this.setProjectSeq( listVo.getProjectSeq( ) );
		this.setPartnerSeq( listVo.getPartnerSeq( ) );
		this.setCardSeq( listVo.getCardSeq( ) );
		this.setDrcrGbn( "vat" );
		this.setAuthDate( listVo.getAuthDate( ) );
		this.setNote( listVo.getNote( ) );
		this.setAmt( listVo.getTaxAmt( ) );
		this.setSubStdAmt( listVo.getSubStdAmt( ) );
		this.setSubTaxAmt( listVo.getSubTaxAmt( ) );
		this.setInterfaceType( listVo.getInterfaceType( ) );
		this.setInterfaceMId( listVo.getInterfaceMId( ) );
		this.setInterfaceDId( listVo.getInterfaceDId( ) );
		this.setCreateSeq( loginVo.getUniqId( ) );
		this.setModifySeq( loginVo.getUniqId( ) );
		// 외화정보
		this.setExchangeUnitCode( listVo.getExchangeUnitCode( ) );
		this.setExchangeUnitName( listVo.getExchangeUnitName( ) );
		this.setExchangeRate( listVo.getExchangeRate( ) );
		this.setForeignCurrencyAmount( listVo.getForeignCurrencyAmount( ) );
		this.setForeignAcctYN(listVo.getForeignAcctYN());
	}

	public void setCr ( ExExpendListVO listVo, LoginVO loginVo ) {
		this.setExpendSeq( listVo.getExpendSeq( ) );
		this.setListSeq( listVo.getListSeq( ) );
		this.setWriteSeq( listVo.getWriteSeq( ) );
		this.setEmpSeq( listVo.getEmpSeq( ) );
		this.setSummarySeq( listVo.getSummarySeq( ) );
		this.setAuthSeq( listVo.getAuthSeq( ) );
		/* this.setBudgetSeq(listVo.getBudgetSeq()); */
		this.setProjectSeq( listVo.getProjectSeq( ) );
		this.setPartnerSeq( listVo.getPartnerSeq( ) );
		this.setCardSeq( listVo.getCardSeq( ) );
		this.setDrcrGbn( "cr" );
		this.setAuthDate( listVo.getAuthDate( ) );
		this.setNote( listVo.getNote( ) );
		this.setAmt( listVo.getAmt( ) );
		this.setSubStdAmt( commonCode.EMPTYSEQ );
		this.setSubTaxAmt( commonCode.EMPTYSEQ );
		this.setInterfaceType( listVo.getInterfaceType( ) );
		this.setInterfaceMId( listVo.getInterfaceMId( ) );
		this.setInterfaceDId( listVo.getInterfaceDId( ) );
		this.setCreateSeq( loginVo.getUniqId( ) );
		this.setModifySeq( loginVo.getUniqId( ) );
		// 외화정보
		this.setExchangeUnitCode( listVo.getExchangeUnitCode( ) );
		this.setExchangeUnitName( listVo.getExchangeUnitName( ) );
		this.setExchangeRate( listVo.getExchangeRate( ) );
		this.setForeignCurrencyAmount( listVo.getForeignCurrencyAmount( ) );
		this.setForeignAcctYN(listVo.getForeignAcctYN());
	}

	public int getFeeSeq ( ) {
		return feeSeq;
	}

	public void setFeeSeq ( int feeSeq ) {
		this.feeSeq = feeSeq;
	}

	@Override
	public String toString ( ) {
		return "ExExpendSlipVO [groupSeq=" + groupSeq 
				           + ", compSeq=" + compSeq 
				           + ", erpCompSeq=" + erpCompSeq 
				           + ", expendSeq=" + expendSeq 
				           + ", listSeq=" + listSeq 
				           + ", slipSeq=" + slipSeq 
				           + ", summarySeq=" + summarySeq 
				           + ", authSeq=" + authSeq 
				           + ", writeSeq=" + writeSeq 
				           + ", empSeq=" + empSeq 
				           + ", budgetSeq=" + budgetSeq 
				           + ", projectSeq=" + projectSeq 
				           + ", partnerSeq=" + partnerSeq 
				           + ", cardSeq=" + cardSeq 
				           + ", feeSeq=" + feeSeq 
				           + ", drcrGbn=" + drcrGbn 
				           + ", acctCode=" + acctCode 
				           + ", acctName=" + acctName 
				           + ", vatYN=" + vatYN 
				           + ", authDate=" + authDate 
				           + ", note=" + note 
				           + ", amt=" + amt 
				           + ", subStdAmt=" + subStdAmt 
				           + ", subTaxAmt=" + subTaxAmt 
				           + ", interfaceType=" + interfaceType 
				           + ", interfaceMId=" + interfaceMId 
				           + ", interfaceDId=" + interfaceDId 
				           + ", rowId=" + rowId 
				           + ", rowNo=" + rowNo 
				           + ", jsonStr=" + jsonStr 
				           + ", formSeq=" + formSeq 
				           + ", callback=" + callback 
				           + ", createSeq=" + createSeq 
				           + ", modifySeq=" + modifySeq 
				           + ", exchangeUnitCode=" + exchangeUnitCode 
				           + ", exchangeUnitName=" + exchangeUnitName 
				           + ", exchangeRate=" + exchangeRate 
				           + ", foreignCurrencyAmount=" + foreignCurrencyAmount 
				           + ", foreignAcctYN=" + foreignAcctYN 
				           + "]";
	}
}
