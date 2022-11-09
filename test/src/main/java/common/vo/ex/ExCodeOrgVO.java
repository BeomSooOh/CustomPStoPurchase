package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExCodeOrgVO {

	private int		seq			= 0;					/* 시퀀스 */
	private String	compSeq		= commonCode.EMPTYSTR;	/* 회사 시퀀스 */
	private String	compName	= commonCode.EMPTYSTR;	/* 회사 명칭 */
	private String	bizSeq		= commonCode.EMPTYSTR;	/* 사업장 시퀀스 */
	private String	bizName		= commonCode.EMPTYSTR;	/* 사업장 명칭 */
	private String	deptSeq		= commonCode.EMPTYSTR;	/* 부서 시퀀스 */
	private String	deptName	= commonCode.EMPTYSTR;	/* 부서 명칭 */
	private String	empSeq		= commonCode.EMPTYSTR;	/* 사원 시퀀스 */
	private String	empName		= commonCode.EMPTYSTR;	/* 사원 명 */
	private String	erpCompSeq	= commonCode.EMPTYSTR;	/* ERP 회사 시퀀스 */
	private String	erpCompName	= commonCode.EMPTYSTR;	/* ERP 회사 명칭 */
	private String	erpBizSeq	= commonCode.EMPTYSTR;	/* ERP 사업장 시퀀스 */
	private String	erpBizName	= commonCode.EMPTYSTR;	/* ERP 사업장 명칭 */
	private String	erpDeptSeq	= commonCode.EMPTYSTR;	/* ERP 부서 시퀀스 */
	private String	erpDeptName	= commonCode.EMPTYSTR;	/* ERP 부서 명칭 */
	private String	erpEmpSeq	= commonCode.EMPTYSTR;	/* ERP 사원 시퀀스 */
	private String	erpEmpName	= commonCode.EMPTYSTR;	/* ERP 사원 명 */
	private String	erpPcSeq	= commonCode.EMPTYSTR;	/* ERP 회계단위 시퀀스 */
	private String	erpPcName	= commonCode.EMPTYSTR;	/* ERP 회계단위 명칭 */
	private String	erpCcSeq	= commonCode.EMPTYSTR;	/* ERP 코스트센터 시퀀스 */
	private String	erpCcName	= commonCode.EMPTYSTR;	/* ERP 코스트센터 명칭 */
	private String	formSeq		= commonCode.EMPTYSTR;	/* 양식 시퀀스 */
	private String	langCode	= commonCode.EMPTYSTR;	/* 사용언어 코드 */
	private String	searchStr	= commonCode.EMPTYSTR;	/* 검색어 */
	private String	callback	= commonCode.EMPTYSTR;	/* 콜백 */
	private String	createSeq	= commonCode.EMPTYSTR;	/* 생성자 */
	private String	modifySeq	= commonCode.EMPTYSTR;	/* 수정자 */
	private String	depositName	= commonCode.EMPTYSTR;	/* 계좌번호 */
	private String	depositCd	= commonCode.EMPTYSTR;	/* 계좌번호코드 */
	private String	groupSeq	= commonCode.EMPTYSTR;	/* 그룹 시퀀스 */

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

	public String getCompName() {
		return CommonConvert.CommonGetStr(compName);
	}

	public void setCompName(String compName) {
		this.compName = compName;
	}

	public String getBizSeq() {
		return CommonConvert.CommonGetStr(bizSeq);
	}

	public void setBizSeq(String bizSeq) {
		this.bizSeq = bizSeq;
	}

	public String getBizName() {
		return CommonConvert.CommonGetStr(bizName);
	}

	public void setBizName(String bizName) {
		this.bizName = bizName;
	}

	public String getDeptSeq() {
		return CommonConvert.CommonGetStr(deptSeq);
	}

	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}

	public String getDeptName() {
		return CommonConvert.CommonGetStr(deptName);
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public String getEmpSeq() {
		return CommonConvert.CommonGetStr(empSeq);
	}

	public void setEmpSeq(String empSeq) {
		this.empSeq = empSeq;
	}

	public String getEmpName() {
		return CommonConvert.CommonGetStr(empName);
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getErpCompSeq() {
		return CommonConvert.CommonGetStr(erpCompSeq);
	}

	public void setErpCompSeq(String erpCompSeq) {
		this.erpCompSeq = erpCompSeq;
	}

	public String getErpCompName() {
		return CommonConvert.CommonGetStr(erpCompName);
	}

	public void setErpCompName(String erpCompName) {
		this.erpCompName = erpCompName;
	}

	public String getErpBizSeq() {
		return CommonConvert.CommonGetStr(erpBizSeq);
	}

	public void setErpBizSeq(String erpBizSeq) {
		this.erpBizSeq = erpBizSeq;
	}

	public String getErpBizName() {
		return CommonConvert.CommonGetStr(erpBizName);
	}

	public void setErpBizName(String erpBizName) {
		this.erpBizName = erpBizName;
	}

	public String getErpDeptSeq() {
		return CommonConvert.CommonGetStr(erpDeptSeq);
	}

	public void setErpDeptSeq(String erpDeptSeq) {
		this.erpDeptSeq = erpDeptSeq;
	}

	public String getErpDeptName() {
		return CommonConvert.CommonGetStr(erpDeptName);
	}

	public void setErpDeptName(String erpDeptName) {
		this.erpDeptName = erpDeptName;
	}

	public String getErpEmpSeq() {
		return CommonConvert.CommonGetStr(erpEmpSeq);
	}

	public void setErpEmpSeq(String erpEmpSeq) {
		this.erpEmpSeq = erpEmpSeq;
	}

	public String getErpEmpName() {
		return CommonConvert.CommonGetStr(erpEmpName);
	}

	public void setErpEmpName(String erpEmpName) {
		this.erpEmpName = erpEmpName;
	}

	public String getErpPcSeq() {
		return CommonConvert.CommonGetStr(erpPcSeq);
	}

	public void setErpPcSeq(String erpPcSeq) {
		this.erpPcSeq = erpPcSeq;
	}

	public String getErpPcName() {
		return CommonConvert.CommonGetStr(erpPcName);
	}

	public void setErpPcName(String erpPcName) {
		this.erpPcName = erpPcName;
	}

	public String getErpCcSeq() {
		return CommonConvert.CommonGetStr(erpCcSeq);
	}

	public void setErpCcSeq(String erpCcSeq) {
		this.erpCcSeq = erpCcSeq;
	}

	public String getErpCcName() {
		return CommonConvert.CommonGetStr(erpCcName);
	}

	public void setErpCcName(String erpCcName) {
		this.erpCcName = erpCcName;
	}

	public String getFormSeq() {
		return CommonConvert.CommonGetStr(formSeq);
	}

	public void setFormSeq(String formSeq) {
		this.formSeq = formSeq;
	}

	public String getLangCode() {
		return CommonConvert.CommonGetStr(langCode);
	}

	public void setLangCode(String langCode) {
		this.langCode = langCode;
	}

	public String getSearchStr() {
		return CommonConvert.CommonGetStr(searchStr);
	}

	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}

	public String getCallback() {
		return CommonConvert.CommonGetStr(callback);
	}

	public void setCallback(String callback) {
		this.callback = callback;
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

	//	private String	erpEmpSeq;		/* 사원번호 */
	//	private String	erpEmpName;		/* 사원명 */
	//	private String	erpCompSeq;		/* 회사코드 */
	//	private String	erpCompName;	/* 회사명칭 */
	//	private String	erpBizSeq;		/* 사업장코드 */
	//	private String	erpBizName;		/* 사업장명칭 */
	//	private String	erpDeptSeq;		/* 부서코드 */
	//	private String	erpDeptName;	/* 부서명칭 */
	//	private String	erpPcSeq;		/* 회계단위코드 */
	//	private String	erpPcName;		/* 회계단위명칭 */
	//	private String	erpCcSeq;		/* 코스트센터코드 */
	//	private String	erpCcName;		/* 코스트센터명칭 */
	public String getDepositName() {
		return CommonConvert.CommonGetStr(depositName);
	}

	public void setDepositName(String depositName) {
		this.depositName = depositName;
	}

	public String getDepositCd() {
		return CommonConvert.CommonGetStr(depositCd);
	}

	public void setDepositCd(String depositCd) {
		this.depositCd = depositCd;
	}

	@Override
	public String toString() {
		return "ExCodeOrgVO [seq=" + seq + ", compSeq=" + compSeq + ", compName=" + compName + ", bizSeq=" + bizSeq + ", bizName=" + bizName + ", deptSeq=" + deptSeq + ", deptName=" + deptName + ", empSeq=" + empSeq + ", empName=" + empName + ", erpCompSeq=" + erpCompSeq + ", erpCompName=" + erpCompName + ", erpBizSeq=" + erpBizSeq + ", erpBizName=" + erpBizName + ", erpDeptSeq=" + erpDeptSeq + ", erpDeptName=" + erpDeptName + ", erpEmpSeq=" + erpEmpSeq + ", erpEmpName=" + erpEmpName + ", erpPcSeq=" + erpPcSeq + ", erpPcName=" + erpPcName + ", erpCcSeq=" + erpCcSeq + ", erpCcName=" + erpCcName + ", formSeq=" + formSeq + ", langCode=" + langCode + ", searchStr=" + searchStr + ", callback=" + callback + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + ", depositName=" + depositName + ", depositCd=" + depositCd + ", groupSeq=" + groupSeq + "]";
	}
}
