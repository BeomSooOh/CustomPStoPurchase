package common.vo.np;

public class NpOutInterfaceVO {
	/* 사용자 정보 */
	private String groupSeq = ""; /* 그룹 시퀀스 */
	private String compSeq = ""; /* 회사 시퀀스 */
	private String bizSeq = ""; /* 사업장 시퀀스 */
	private String deptSeq = ""; /* 부서 시퀀스 */
	private String empSeq = ""; /* 사원 시퀀스 */

	/* 품의 / 결의 정보 */
	private String consDocSeq = ""; /* 품의서 고유 아이디 */
	private String resDocSeq = ""; /* 결의서 고유 아이디 */

	/* 전자결재 정보 */
	private String docSeq = ""; /* 전자결재 고유 아이디 */
	private String docNo = ""; /* 전자결재 문서 번호 */
	private String formSeq = "";

	/* interface 정보 */
	private String interfaceId = ""; /* 인터페이스 아이디 */
	private String iframeUrl = ""; /* 인터페이스 아이프레임 URL */
	private String iframeHeight = ""; /* 인터페이스 아이프레임 높이 */
	private String interfaceCallForm = ""; /* 인터페이스 양식 */
	private String interfaceCallSave = ""; /* 인터페이스 저장 */
	private String interfaceCallApproval = ""; /* 인터페이스 상신 */
	private String interfaceCallReturn = ""; /* 인터페이스 반려 */
	private String interfaceCallEnd = ""; /* 인터페이스 종결 */
	private String interfaceCallDelete = ""; /* 인터페이스 삭제 */
	private String licence = ""; /* 라이센스 */

	/* interface 키 정보 */
	private String outProcessInterfaceMId = ""; /* 외부 수신 키 값 1 */
	private String outProcessInterfaceDId = ""; /* 외부 수신 키 값 2 */

	/* interface 기록 정보 */
	private String interfaceType = ""; /* 연동 호출 구분 ( processId ) */
	private String approvalStatusCode = ""; /* 전자결재 상태 코드 값 */
	private String interfaceUrl = ""; /* 호출 URL */
	private String interfaceParam = ""; /* 호출 파라미터 */
	private String interfaceResult = ""; /* 호출 결과 */

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

	public String getBizSeq() {
		return bizSeq;
	}

	public void setBizSeq(String bizSeq) {
		this.bizSeq = bizSeq;
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

	public String getConsDocSeq() {
		return consDocSeq;
	}

	public void setConsDocSeq(String consDocSeq) {
		this.consDocSeq = consDocSeq;
	}

	public String getResDocSeq() {
		return resDocSeq;
	}

	public void setResDocSeq(String resDocSeq) {
		this.resDocSeq = resDocSeq;
	}

	public String getDocSeq() {
		return docSeq;
	}

	public void setDocSeq(String docSeq) {
		this.docSeq = docSeq;
	}

	public String getDocNo() {
		return docNo;
	}

	public void setDocNo(String docNo) {
		this.docNo = docNo;
	}

	public String getFormSeq() {
		return formSeq;
	}

	public void setFormSeq(String formSeq) {
		this.formSeq = formSeq;
	}

	public String getInterfaceId() {
		return interfaceId;
	}

	public void setInterfaceId(String interfaceId) {
		this.interfaceId = interfaceId;
	}

	public String getIframeUrl() {
		return iframeUrl;
	}

	public void setIframeUrl(String iframeUrl) {
		this.iframeUrl = iframeUrl;
	}

	public String getIframeHeight() {
		return iframeHeight;
	}

	public void setIframeHeight(String iframeHeight) {
		this.iframeHeight = iframeHeight;
	}

	public String getInterfaceCallForm() {
		return interfaceCallForm;
	}

	public void setInterfaceCallForm(String interfaceCallForm) {
		this.interfaceCallForm = interfaceCallForm;
	}

	public String getInterfaceCallSave() {
		return interfaceCallSave;
	}

	public void setInterfaceCallSave(String interfaceCallSave) {
		this.interfaceCallSave = interfaceCallSave;
	}

	public String getInterfaceCallApproval() {
		return interfaceCallApproval;
	}

	public void setInterfaceCallApproval(String interfaceCallApproval) {
		this.interfaceCallApproval = interfaceCallApproval;
	}

	public String getInterfaceCallReturn() {
		return interfaceCallReturn;
	}

	public void setInterfaceCallReturn(String interfaceCallReturn) {
		this.interfaceCallReturn = interfaceCallReturn;
	}

	public String getInterfaceCallEnd() {
		return interfaceCallEnd;
	}

	public void setInterfaceCallEnd(String interfaceCallEnd) {
		this.interfaceCallEnd = interfaceCallEnd;
	}

	public String getInterfaceCallDelete() {
		return interfaceCallDelete;
	}

	public void setInterfaceCallDelete(String interfaceCallDelete) {
		this.interfaceCallDelete = interfaceCallDelete;
	}

	public String getLicence() {
		return licence;
	}

	public void setLicence(String licence) {
		this.licence = licence;
	}

	public String getOutProcessInterfaceMId() {
		return outProcessInterfaceMId;
	}

	public void setOutProcessInterfaceMId(String outProcessInterfaceMId) {
		this.outProcessInterfaceMId = outProcessInterfaceMId;
	}

	public String getOutProcessInterfaceDId() {
		return outProcessInterfaceDId;
	}

	public void setOutProcessInterfaceDId(String outProcessInterfaceDId) {
		this.outProcessInterfaceDId = outProcessInterfaceDId;
	}

	public String getInterfaceType() {
		return interfaceType;
	}

	public void setInterfaceType(String interfaceType) {
		this.interfaceType = interfaceType;
	}

	public String getApprovalStatusCode() {
		return approvalStatusCode;
	}

	public void setApprovalStatusCode(String approvalStatusCode) {
		this.approvalStatusCode = approvalStatusCode;
	}

	public String getInterfaceUrl() {
		return interfaceUrl;
	}

	public void setInterfaceUrl(String interfaceUrl) {
		this.interfaceUrl = interfaceUrl;
	}

	public String getInterfaceParam() {
		return interfaceParam;
	}

	public void setInterfaceParam(String interfaceParam) {
		this.interfaceParam = interfaceParam;
	}

	public String getInterfaceResult() {
		return interfaceResult;
	}

	public void setInterfaceResult(String interfaceResult) {
		this.interfaceResult = interfaceResult;
	}

	@Override
	public String toString() {
		return "NpOutInterfaceVO [groupSeq=" + groupSeq + ", compSeq=" + compSeq + ", bizSeq=" + bizSeq + ", deptSeq="
				+ deptSeq + ", empSeq=" + empSeq + ", consDocSeq=" + consDocSeq + ", resDocSeq=" + resDocSeq
				+ ", docSeq=" + docSeq + ", docNo=" + docNo + ", formSeq=" + formSeq + ", interfaceId=" + interfaceId
				+ ", iframeUrl=" + iframeUrl + ", iframeHeight=" + iframeHeight + ", interfaceCallForm="
				+ interfaceCallForm + ", interfaceCallSave=" + interfaceCallSave + ", interfaceCallApproval="
				+ interfaceCallApproval + ", interfaceCallReturn=" + interfaceCallReturn + ", interfaceCallEnd="
				+ interfaceCallEnd + ", interfaceCallDelete=" + interfaceCallDelete + ", licence=" + licence
				+ ", outProcessInterfaceMId=" + outProcessInterfaceMId + ", outProcessInterfaceDId="
				+ outProcessInterfaceDId + ", interfaceType=" + interfaceType + ", approvalStatusCode="
				+ approvalStatusCode + ", interfaceUrl=" + interfaceUrl + ", interfaceParam=" + interfaceParam
				+ ", interfaceResult=" + interfaceResult + "]";
	}

}