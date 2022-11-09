package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExCodePartnerVO {

	private int seq = 0; /* 시퀀스 */
	private String compSeq = commonCode.EMPTYSEQ; /* 회사 시퀀스 */
	private String erpCompSeq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String partnerCode = commonCode.EMPTYSTR; /* 거래처 코드 */
	private String partnerName = commonCode.EMPTYSTR; /* 거래처 명칭 */
	private String partnerNo = commonCode.EMPTYSTR; /* 사업자 등록 번호 */
	private String pplNo = commonCode.EMPTYSTR; /* 개인 번호 */
	private String partnerFg = commonCode.EMPTYSTR; /* 거래처 구분 */
	private String ceoName = commonCode.EMPTYSTR; /* CEO 이름 */
	private String jobGbn = commonCode.EMPTYSTR; /* 업종 */
	private String clsJobGbn = commonCode.EMPTYSTR; /* 업태 */
	private String depositNo = commonCode.EMPTYSTR; /* 계좌번호 */
	private String bankCode = commonCode.EMPTYSTR; /* 은행코드 */
	private String partnerEmpCode = commonCode.EMPTYSTR; /* 거래처 담당자 */
	private String partnerHpEmpNo = commonCode.EMPTYSTR; /* 거래처 담당자 연락처 */
	private String depositName = commonCode.EMPTYSTR; /* 은행명 */
	private String depositConvert = commonCode.EMPTYSTR; /* ERPiU 계좌정보 관리항목 */
	private String depositCd = commonCode.EMPTYSTR; /* ERPiU 계좌정보 관리항목 코드 */
	private String callback = commonCode.EMPTYSTR; /* 콜백 */
	private String formSeq = commonCode.EMPTYSEQ; /* 양식 시퀀스 */
	private String searchStr = commonCode.EMPTYSTR; /* 검색어 */
	private String searchType = commonCode.EMPTYSTR; /* 검색구분 */
	private String createSeq = commonCode.EMPTYSEQ; /* 생성자 */
	private String modifySeq = commonCode.EMPTYSEQ; /* 수정자 */
	private String groupSeq = commonCode.EMPTYSTR; /* 그룹 시퀀스 */
	private String expendSeq = commonCode.EMPTYSEQ; /* 지출결의서 시퀀스 */

	/* 2019.02.21.김상겸 추가 ==> http://jira.duzon.com:8080/browse/UBA-33466 */
	private String pratnerFg = commonCode.EMPTYSTR; /* 거래처 구분 */

	public String getGroupSeq() {
		return CommonConvert.CommonGetStr(groupSeq);
	}

	public void setGroupSeq(String groupSeq) {
		this.groupSeq = groupSeq;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getCompSeq() {
		return CommonConvert.CommonGetStr(compSeq);
	}

	public void setCompSeq(String compSeq) {
		this.compSeq = compSeq;
	}

	public String getErpCompSeq() {
		return CommonConvert.CommonGetStr(erpCompSeq);
	}

	public void setErpCompSeq(String erpCompSeq) {
		this.erpCompSeq = erpCompSeq;
	}

	public String getPartnerCode() {
		return CommonConvert.CommonGetStr(partnerCode);
	}

	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}

	public String getPartnerName() {
		return CommonConvert.CommonGetStr(partnerName);
	}

	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}

	public String getPartnerNo() {
		return CommonConvert.CommonGetStr(partnerNo);
	}

	public void setPartnerNo(String partnerNo) {
		this.partnerNo = partnerNo;
	}

	public String getPplNo() {
		return pplNo;
	}

	public void setPplNo(String pplNo) {
		this.pplNo = pplNo;
	}

	public String getPartnerFg() {
		return CommonConvert.CommonGetStr(partnerFg);
	}

	public void setPartnerFg(String partnerFg) {
		this.partnerFg = partnerFg;
	}

	public String getCeoName() {
		return CommonConvert.CommonGetStr(ceoName);
	}

	public void setCeoName(String ceoName) {
		this.ceoName = ceoName;
	}

	public String getJobGbn() {
		return CommonConvert.CommonGetStr(jobGbn);
	}

	public void setJobGbn(String jobGbn) {
		this.jobGbn = jobGbn;
	}

	public String getClsJobGbn() {
		return CommonConvert.CommonGetStr(clsJobGbn);
	}

	public void setClsJobGbn(String clsJobGbn) {
		this.clsJobGbn = clsJobGbn;
	}

	public String getDepositNo() {
		return CommonConvert.CommonGetStr(depositNo);
	}

	public void setDepositNo(String depositNo) {
		this.depositNo = depositNo;
	}

	public String getBankCode() {
		return CommonConvert.CommonGetStr(bankCode);
	}

	public void setBankCode(String bankCode) {
		this.bankCode = bankCode;
	}

	public String getPartnerEmpCode() {
		return CommonConvert.CommonGetStr(partnerEmpCode);
	}

	public void setPartnerEmpCode(String partnerEmpCode) {
		this.partnerEmpCode = partnerEmpCode;
	}

	public String getPartnerHpEmpNo() {
		return CommonConvert.CommonGetStr(partnerHpEmpNo);
	}

	public void setPartnerHpEmpNo(String partnerHpEmpNo) {
		this.partnerHpEmpNo = partnerHpEmpNo;
	}

	public String getDepositName() {
		return CommonConvert.CommonGetStr(depositName);
	}

	public void setDepositName(String depositName) {
		this.depositName = depositName;
	}

	public String getDepositConvert() {
		return CommonConvert.CommonGetStr(depositConvert);
	}

	public void setDepositConvert(String depositConvert) {
		this.depositConvert = depositConvert;
	}

	public String getDepositCd() {
		return CommonConvert.CommonGetStr(depositCd);
	}

	public void setDepositCd(String depositCd) {
		this.depositCd = depositCd;
	}

	public String getCallback() {
		return CommonConvert.CommonGetStr(callback);
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}

	public String getFormSeq() {
		return CommonConvert.CommonGetStr(formSeq);
	}

	public void setFormSeq(String formSeq) {
		this.formSeq = formSeq;
	}

	public String getSearchStr() {
		return CommonConvert.CommonGetStr(searchStr);
	}

	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}

	public String getSearchType() {
		return CommonConvert.CommonGetStr(searchType);
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getCreateSeq() {
		return CommonConvert.CommonGetStr(createSeq);
	}

	public void setCreateSeq(String createSeq) {
		this.createSeq = createSeq;
	}

	public String getModifySeq() {
		return CommonConvert.CommonGetStr(modifySeq);
	}

	public void setModifySeq(String modifySeq) {
		this.modifySeq = modifySeq;
	}

	public String getPratnerFg() {
		return pratnerFg;
	}

	public void setPratnerFg(String pratnerFg) {
		this.pratnerFg = pratnerFg;
	}
	

	public String getExpendSeq() {
		return CommonConvert.CommonGetStr(expendSeq);
	}

	public void setExpendSeq(String expendSeq) {
		this.expendSeq = expendSeq;
	}

	@Override
	public String toString() {
		return "ExCodePartnerVO [seq=" + seq + ", compSeq=" + compSeq + ", erpCompSeq=" + erpCompSeq + ", partnerCode="
				+ partnerCode + ", partnerName=" + partnerName + ", partnerNo=" + partnerNo + ", partnerFg=" + partnerFg
				+ ", ceoName=" + ceoName + ", jobGbn=" + jobGbn + ", clsJobGbn=" + clsJobGbn + ", depositNo="
				+ depositNo + ", bankCode=" + bankCode + ", partnerEmpCode=" + partnerEmpCode + ", partnerHpEmpNo="
				+ partnerHpEmpNo + ", depositName=" + depositName + ", depositConvert=" + depositConvert
				+ ", depositCd=" + depositCd + ", callback=" + callback + ", formSeq=" + formSeq + ", searchStr="
				+ searchStr + ", searchType=" + searchType + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq
				+ ", getSeq()=" + getSeq() + ", getCompSeq()=" + getCompSeq() + ", getErpCompSeq()=" + getErpCompSeq()
				+ ", getPartnerCode()=" + getPartnerCode() + ", getPartnerName()=" + getPartnerName()
				+ ", getPartnerNo()=" + getPartnerNo() + ", getPartnerFg()=" + getPartnerFg() + ", getCeoName()="
				+ getCeoName() + ", getJobGbn()=" + getJobGbn() + ", getClsJobGbn()=" + getClsJobGbn()
				+ ", getDepositNo()=" + getDepositNo() + ", getBankCode()=" + getBankCode() + ", getPartnerEmpCode()="
				+ getPartnerEmpCode() + ", getPartnerHpEmpNo()=" + getPartnerHpEmpNo() + ", getDepositName()="
				+ getDepositName() + ", getDepositConvert()=" + getDepositConvert() + ", getDepositCd()="
				+ getDepositCd() + ", getCallback()=" + getCallback() + ", getFormSeq()=" + getFormSeq()
				+ ", getSearchStr()=" + getSearchStr() + ", getSearchType()=" + getSearchType() + ", getCreateSeq()="
				+ getCreateSeq() + ", getModifySeq()=" + getModifySeq() + ", getClass()=" + getClass() + ", hashCode()="
				+ hashCode() + ", toString()=" + super.toString() + "]";
	}
}
