package common.vo.ex;

import common.vo.common.CommonInterface.commonCode;

public class ExReportCardVO {

	private String groupSeq = commonCode.EMPTYSTR; /* 그룹시퀀스 */
	private String compSeq = commonCode.EMPTYSTR; /* 회사시퀀스 */
	private String empSeq = commonCode.EMPTYSTR; /* 사원시퀀스 */
	private String langCode = commonCode.EMPTYSTR; /* 사용언어코드 */
	private String cardNum = commonCode.EMPTYSTR; /* 카드번호 */
	private String cardName = commonCode.EMPTYSTR; /* 법인카드명 */
	private String fromDate = commonCode.EMPTYSTR; /* 검색시작일 */
	private String toDate = commonCode.EMPTYSTR; /* 검색종료일 */
	private String mercName = commonCode.EMPTYSTR; /* 거래처 */
	private String docSts = commonCode.EMPTYSTR; /* 문서상태 */
	private String useYN = commonCode.EMPTYSTR; /* 미사용구분 Y:사용, N:미사용 */
	private String sortField = commonCode.EMPTYSTR; /* 정렬컬럼 */
	private String sortType = commonCode.EMPTYSTR; /* 정렬순서 */
	
	public String getGroupSeq() {
		return groupSeq;
	}

	public void setGroupSeq(String groupSeq) {
		this.groupSeq = groupSeq;
	}

	public String getCompSeq() {
		return compSeq;
	}

	public void setCompSeq(String compSeq) {
		this.compSeq = compSeq;
	}
	
	public String getEmpSeq() {
		return empSeq;
	}

	public void setEmpSeq(String empSeq) {
		this.empSeq = empSeq;
	}

	public String getLangCode() {
		return langCode;
	}

	public void setLangCode(String langCode) {
		this.langCode = langCode;
	}
	
	public String getCardNum() {
		return cardNum;
	}
	
	public void setCardNum(String cardNum) {
		cardNum.replace("'", "''");
		this.cardNum = cardNum;
	}
	
	public String getCardName() {
		return cardName;
	}
	
	public void setCardName(String cardName) {
		cardName.replace("'", "''");
		this.cardName = cardName;
	}
	
	public String getFromDate() {
		return fromDate;
	}
	
	public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	
	public String getToDate() {
		return toDate;
	}
	
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	
	public String getMercName() {
		return mercName;
	}
	
	public void setMercName(String mercName) {
		mercName.replace("'", "''");
		this.mercName = mercName;
	}
	
	public String getDocSts() {
		return docSts;
	}
	
	public void setDocSts(String docSts) {
		this.docSts = docSts;
	}
	
	public String getUseYN() {
		return useYN;
	}
	
	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}
	
	public String getSortField() {
		return sortField;
	}

	public void setSortField(String sortField) {
		this.sortField = sortField;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}

	@Override
	public String toString() {
		return "ExReportCardVO [groupSeq=" + groupSeq + ", compSeq=" + compSeq + ", empSeq=" + empSeq + ", langCode=" + langCode + 
				             ", cardNum=" + cardNum + ", cardName=" + cardName + ", fromDate=" + fromDate + ", toDate=" + toDate + 
				             ", mercName=" + mercName + ", docSts=" + docSts +  ", useYN=" + useYN + ", sortField=" + sortField +  
				             ", sortType=" + sortType + "]";
	}
}
