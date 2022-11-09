package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExReportSendExpendVO {

	private String comp_seq = commonCode.EMPTYSEQ; /* 회사 시퀀스 */
	private String erp_comp_seq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String emp_seq = commonCode.EMPTYSTR; /* 사원 시퀀스 */
	private String expend_seq = commonCode.EMPTYSEQ; /* 지출결의 시퀀스 */
	private String doc_seq = commonCode.EMPTYSEQ; /* 전자결재 시퀀스 */
	private String app_doc_no = commonCode.EMPTYSTR; /* 전자결재 문서번호 */
	private String app_rep_date = commonCode.EMPTYSTR; /* 전자결재 기안일자 */
	private String app_doc_title = commonCode.EMPTYSTR; /* 전자결재 문서제목 */
	private String expend_date = commonCode.EMPTYSTR; /* 결의일자 ( 회계일자, 예산년월 ) */
	private String expend_req_date = commonCode.EMPTYSTR; /* 지급요청일자 ( 만기일자 ) */
	private String app_user_name = commonCode.EMPTYSTR; /* 상신자 */
	private String expend_emp_seq = commonCode.EMPTYSEQ; /* 사용자 시퀀스 */
	private String expend_use_dept_name = commonCode.EMPTYSTR; /* 사용 부서 명 */
	private String expend_use_emp_name = commonCode.EMPTYSTR; /* 사용자 명 */
	private String expend_amt = commonCode.EMPTYSEQ; /* 금액 */
	private String expend_erp_send_yn = commonCode.EMPTYSTR; /* ERP 전송상태 */
	private String expend_erp_send_seq = commonCode.EMPTYSEQ; /* ERP 전송자 시퀀스 */
	private String expend_erp_send_name = commonCode.EMPTYSTR; /* ERP 전송자 명 */
	private String expend_adocu_id = commonCode.EMPTYSTR; /* ERP 자동전표 아이디 검색조건 */
	private String expend_erpiu_adocu_id = commonCode.EMPTYSTR; /* ERPiU row_id */
	private String expend_icube_adocu_id = commonCode.EMPTYSTR; /* iCUBE in_dt */
	private String expend_icube_adocu_seq = commonCode.EMPTYSEQ; /* iCUBE in_sq */
	private String search_doc_status = commonCode.EMPTYSTR; /* 전자결재 문서 상태 코드 */
	private String search_from_date = commonCode.EMPTYSTR; /* 검색조건 결의일자 시작일 */
	private String search_to_date = commonCode.EMPTYSTR; /* 검색조건 결의일자 종료일 */

	public String getComp_seq ( ) {
		return CommonConvert.CommonGetStr(comp_seq);
	}

	public void setComp_seq ( String compSeq ) {
		this.comp_seq = compSeq;
	}

	public String getErp_comp_seq ( ) {
		return CommonConvert.CommonGetStr(erp_comp_seq);
	}

	public void setErp_comp_seq ( String erpCompSeq ) {
		this.erp_comp_seq = erpCompSeq;
	}

	public String getEmp_seq ( ) {
		return CommonConvert.CommonGetStr(emp_seq);
	}

	public void setEmp_seq ( String empSeq ) {
		this.emp_seq = empSeq;
	}

	public String getExpend_seq ( ) {
		return CommonConvert.CommonGetStr(expend_seq);
	}

	public void setExpend_seq ( String expendSeq ) {
		this.expend_seq = expendSeq;
	}

	public String getDoc_seq ( ) {
		return CommonConvert.CommonGetStr(doc_seq);
	}

	public void setDoc_seq ( String docSeq ) {
		this.doc_seq = docSeq;
	}

	public String getApp_doc_no ( ) {
		return CommonConvert.CommonGetStr(app_doc_no);
	}

	public void setApp_doc_no ( String appDocNo ) {
		this.app_doc_no = appDocNo;
	}

	public String getApp_rep_date ( ) {
		return CommonConvert.CommonGetStr(app_rep_date);
	}

	public void setApp_rep_date ( String appRepDate ) {
		this.app_rep_date = appRepDate;
	}

	public String getApp_doc_title ( ) {
		return CommonConvert.CommonGetStr(app_doc_title);
	}

	public void setApp_doc_title ( String appDocTitle ) {
		this.app_doc_title = appDocTitle;
	}

	public String getExpend_date ( ) {
		return CommonConvert.CommonGetStr(expend_date);
	}

	public void setExpend_date ( String expendDate ) {
		this.expend_date = expendDate;
	}

	public String getExpend_req_date ( ) {
		return CommonConvert.CommonGetStr(expend_req_date);
	}

	public void setExpend_req_date ( String expendReqDate ) {
		this.expend_req_date = expendReqDate;
	}

	public String getApp_user_name ( ) {
		return CommonConvert.CommonGetStr(app_user_name);
	}

	public void setApp_user_name ( String appUserName ) {
		this.app_user_name = appUserName;
	}

	public String getExpend_emp_seq ( ) {
		return CommonConvert.CommonGetStr(expend_emp_seq);
	}

	public void setExpend_emp_seq ( String expendEmpSeq ) {
		this.expend_emp_seq = expendEmpSeq;
	}

	public String getExpend_use_dept_name ( ) {
		return CommonConvert.CommonGetStr(expend_use_dept_name);
	}

	public void setExpend_use_dept_name ( String expendUseDeptName ) {
		this.expend_use_dept_name = expendUseDeptName;
	}

	public String getExpend_use_emp_name ( ) {
		return CommonConvert.CommonGetStr(expend_use_emp_name);
	}

	public void setExpend_use_emp_name ( String expendUseEmpName ) {
		this.expend_use_emp_name = expendUseEmpName;
	}

	public String getExpend_amt ( ) {
		return CommonConvert.CommonGetStr(expend_amt);
	}

	public void setExpend_amt ( String expendAmt ) {
		this.expend_amt = expendAmt;
	}

	public String getExpend_erp_send_yn ( ) {
		return CommonConvert.CommonGetStr(expend_erp_send_yn);
	}

	public void setExpend_erp_send_yn ( String expendErpSendYn ) {
		this.expend_erp_send_yn = expendErpSendYn;
	}

	public String getExpend_erp_send_seq ( ) {
		return CommonConvert.CommonGetStr(expend_erp_send_seq);
	}

	public void setExpend_erp_send_seq ( String expendErpSendSeq ) {
		this.expend_erp_send_seq = expendErpSendSeq;
	}

	public String getExpend_erp_send_name ( ) {
		return CommonConvert.CommonGetStr(expend_erp_send_name);
	}

	public void setExpend_erp_send_name ( String expendErpSendName ) {
		this.expend_erp_send_name = expendErpSendName;
	}

	public String getExpend_adocu_id ( ) {
		return CommonConvert.CommonGetStr(expend_adocu_id);
	}

	public void setExpend_adocu_id ( String expendAdocuId ) {
		this.expend_adocu_id = expendAdocuId;
	}

	public String getExpend_erpiu_adocu_id ( ) {
		return CommonConvert.CommonGetStr(expend_erpiu_adocu_id);
	}

	public void setExpend_erpiu_adocu_id ( String expendErpiuAdocuId ) {
		this.expend_erpiu_adocu_id = expendErpiuAdocuId;
	}

	public String getExpend_icube_adocu_id ( ) {
		return CommonConvert.CommonGetStr(expend_icube_adocu_id);
	}

	public void setExpend_icube_adocu_id ( String expendIcubeAdocuId ) {
		this.expend_icube_adocu_id = expendIcubeAdocuId;
	}

	public String getExpend_icube_adocu_seq ( ) {
		return CommonConvert.CommonGetStr(expend_icube_adocu_seq);
	}

	public void setExpend_icube_adocu_seq ( String expendIcubeAdocuSeq ) {
		this.expend_icube_adocu_seq = expendIcubeAdocuSeq;
	}

	public String getSearch_doc_status ( ) {
		return CommonConvert.CommonGetStr(search_doc_status);
	}

	public void setSearch_doc_status ( String searchDocStatus ) {
		this.search_doc_status = searchDocStatus;
	}

	public String getSearch_from_date ( ) {
		return CommonConvert.CommonGetStr(search_from_date);
	}

	public void setSearch_from_date ( String searchFromDate ) {
		this.search_from_date = searchFromDate;
	}

	public String getSearch_to_date ( ) {
		return CommonConvert.CommonGetStr(search_to_date);
	}

	public void setSearch_to_date ( String searchToDate ) {
		this.search_to_date = searchToDate;
	}

	@Override
	public String toString ( ) {
		return "ExReportSendExpendVO [comp_seq=" + comp_seq + ", erp_comp_seq=" + erp_comp_seq + ", emp_seq=" + emp_seq + ", expend_seq=" + expend_seq + ", doc_seq=" + doc_seq + ", app_doc_no=" + app_doc_no + ", app_rep_date=" + app_rep_date + ", app_doc_title=" + app_doc_title + ", expend_date=" + expend_date + ", expend_req_date=" + expend_req_date + ", app_user_name=" + app_user_name + ", expend_emp_seq=" + expend_emp_seq + ", expend_use_dept_name=" + expend_use_dept_name + ", expend_use_emp_name=" + expend_use_emp_name + ", expend_amt=" + expend_amt + ", expend_erp_send_yn=" + expend_erp_send_yn + ", expend_erp_send_seq=" + expend_erp_send_seq + ", expend_erp_send_name=" + expend_erp_send_name + ", expend_adocu_id=" + expend_adocu_id + ", expend_erpiu_adocu_id=" + expend_erpiu_adocu_id + ", expend_icube_adocu_id=" + expend_icube_adocu_id + ", expend_icube_adocu_seq=" + expend_icube_adocu_seq + ", search_doc_status=" + search_doc_status + ", search_from_date=" + search_from_date
				+ ", search_to_date=" + search_to_date + "]";
	}
}
