package common.vo.common;

public class BizboxLogVO {
	private String groupSeq = ""; // 그룹시퀀스
	private String compSeq = ""; // 회사시퀀스
	private String deptSeq = ""; // 부서시퀀스
	private String empSeq = ""; // 사원시퀀스
	private String expendSeq = ""; // 지출결의서 시퀀스
	private String interfaceType = ""; // 항목 구분
	private String syncId = ""; // 연동항목 아이디
	private String erpType = ""; // 연동 ERP 구분
	private String approKey = ""; // 전자결재 외부연동 키
	private String transferType = ""; // 이관 또는 취소 구분
	private String transferSeq = ""; // 이관자 또는 취소자 시퀀스
	private String receiveSeq = ""; // 수신자 시퀀스
	private String erpSendYn = ""; // 전송 구분 값
	private String actionIP = ""; // 사용자 IP

	public BizboxLogVO() {

	}
	
	public BizboxLogVO(String groupSeq, String compSeq, String deptSeq, String empSeq) {
		this.setGroupSeq(groupSeq);
		this.setCompSeq(compSeq);
		this.setDeptSeq(deptSeq);
		this.setEmpSeq(empSeq);
	}

	public BizboxLogVO(String expendSeq, String interfaceType, String syncId, String erpType, String approKey,
			String transferType, String transferSeq, String receiveSeq, String erpSendYn, String actionIP) {
		this.setExpendSeq(expendSeq);
		this.setInterfaceType(interfaceType);
		this.setSyncId(syncId);
		this.setErpType(erpType);
		this.setApproKey(approKey);
		this.setTransferType(transferType);
		this.setTransferSeq(transferSeq);
		this.setReceiveSeq(receiveSeq);
		this.setErpSendYn(erpSendYn);
		this.setActionIP(actionIP);
	}

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

	public String getDeptSeq() {
		return deptSeq;
	}

	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}

	public String getEmpSeq() {
		return empSeq;
	}

	public void setEmpSeq(String empSeq) {
		this.empSeq = empSeq;
	}

	public String getExpendSeq() {
		return expendSeq;
	}

	public void setExpendSeq(String expendSeq) {
		this.expendSeq = expendSeq;
	}

	public String getInterfaceType() {
		return interfaceType;
	}

	public void setInterfaceType(String interfaceType) {
		this.interfaceType = interfaceType;
	}

	public String getSyncId() {
		return syncId;
	}

	public void setSyncId(String syncId) {
		this.syncId = syncId;
	}

	public String getErpType() {
		return erpType;
	}

	public void setErpType(String erpType) {
		this.erpType = erpType;
	}

	public String getApproKey() {
		return approKey;
	}

	public void setApproKey(String approKey) {
		this.approKey = approKey;
	}

	public String getTransferType() {
		return transferType;
	}

	public void setTransferType(String transferType) {
		this.transferType = transferType;
	}

	public String getTransferSeq() {
		return transferSeq;
	}

	public void setTransferSeq(String transferSeq) {
		this.transferSeq = transferSeq;
	}

	public String getReceiveSeq() {
		return receiveSeq;
	}

	public void setReceiveSeq(String receiveSeq) {
		this.receiveSeq = receiveSeq;
	}

	public String getErpSendYn() {
		return erpSendYn;
	}

	public void setErpSendYn(String erpSendYn) {
		this.erpSendYn = erpSendYn;
	}

	public String getActionIP() {
		return actionIP;
	}

	public void setActionIP(String actionIP) {
		this.actionIP = actionIP;
	}

}
