package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExCodeProjectVO {

	private int seq = 0; /* 시퀀스 */
	private String compSeq = commonCode.EMPTYSEQ; /* 회사 시퀀스 */
	private String userSe = commonCode.EMPTYSTR; /* 사용자 권한 구분 */
	private String deptSeq = commonCode.EMPTYSEQ; /* 부서 시퀀스 */
	private String empSeq = commonCode.EMPTYSEQ; /* 사용자 시퀀스 */
	private String erpCompSeq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String projectCode = commonCode.EMPTYSTR; /* 프로젝트 코드 */
	private String projectName = commonCode.EMPTYSTR; /* 프로젝트 명칭 */
	private String callback = commonCode.EMPTYSTR; /* 콜백 */
	private String formSeq = commonCode.EMPTYSEQ; /* 양식 시퀀스 */
	private String searchStr = commonCode.EMPTYSTR; /* 검색어 */
	private String createSeq = commonCode.EMPTYSEQ; /* 생성자 */
	private String modifySeq = commonCode.EMPTYSEQ; /* 수정자 */
	private String expendSeq = commonCode.EMPTYSEQ; /* 지출결의서 시퀀스 */
	private String groupSeq = commonCode.EMPTYSEQ; /* 지출결의서 시퀀스 */
	
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
	
	public String getUserSe ( ) {
		return CommonConvert.CommonGetStr(userSe);
	}
	
	public void setUserSe ( String userSe ) {
		this.userSe = userSe;
	}
	
	public String getDeptSeq ( ) {
		return CommonConvert.CommonGetStr(deptSeq);
	}
	
	public void setDeptSeq ( String deptSeq ) {
		this.deptSeq = deptSeq;
	}
	
	public String getEmpSeq ( ) {
		return CommonConvert.CommonGetStr(empSeq);
	}
	
	public void setEmpSeq ( String empSeq ) {
		this.empSeq = empSeq;
	}
	
	public String getErpCompSeq ( ) {
		return CommonConvert.CommonGetStr(erpCompSeq);
	}
	
	public void setErpCompSeq ( String erpCompSeq ) {
		this.erpCompSeq = erpCompSeq;
	}
	
	public String getProjectCode ( ) {
		return CommonConvert.CommonGetStr(projectCode);
	}
	
	public void setProjectCode ( String projectCode ) {
		this.projectCode = projectCode;
	}
	
	public String getProjectName ( ) {
		return CommonConvert.CommonGetStr(projectName);
	}
	
	public void setProjectName ( String projectName ) {
		this.projectName = projectName;
	}
	
	public String getCallback ( ) {
		return CommonConvert.CommonGetStr(callback);
	}
	
	public void setCallback ( String callback ) {
		this.callback = callback;
	}
	
	public String getFormSeq ( ) {
		return CommonConvert.CommonGetStr(formSeq);
	}
	
	public void setFormSeq ( String formSeq ) {
		this.formSeq = formSeq;
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
	
	public String getExpendSeq() {
		return CommonConvert.CommonGetStr(expendSeq);
	}

	public void setExpendSeq(String expendSeq) {
		this.expendSeq = expendSeq;
	}
	
	public String getGroupSeq() {
		return CommonConvert.CommonGetStr(groupSeq);
	}

	public void setGroupSeq(String groupSeq) {
		this.groupSeq = groupSeq;
	}

	@Override
	public String toString ( ) {
		return "ExCodeProjectVO [seq=" + seq + ", compSeq=" + compSeq + ", userSe=" + userSe + ", deptSeq=" + deptSeq + ", empSeq=" + empSeq + ", erpCompSeq=" + erpCompSeq + ", projectCode=" + projectCode + ", projectName=" + projectName + ", callback=" + callback + ", formSeq=" + formSeq + ", searchStr=" + searchStr + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + ", expendSeq=" + expendSeq + "]";
	}

	//	private int		seq	= 0;		/* 지출결의 프로젝트 시퀀스 */
	//	private String	projectCode;	/* 프로젝트 코드 */
	//	private String	projectName;	/* 프로젝트 명칭 */
	//	private String	createSeq;		/* 최초 작성자 */
	//	private String	createDate;		/* 최초 작성일자 */
	//	private String	modifySeq;		/* 최종 수정자 */
	//	private String	modifyDate;		/* 최종 수정일자 */
}
