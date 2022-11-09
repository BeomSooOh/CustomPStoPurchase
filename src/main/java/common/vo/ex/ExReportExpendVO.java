package common.vo.ex;

import com.sun.star.bridge.oleautomation.Date;

import common.helper.convert.CommonConvert;


public class ExReportExpendVO extends ExCodeOrgVO {

	private int seq; /* 시퀀스 */
	private String doc_no; /* 문서법호 */
	private String doc_subject; /* 제목 */
	private String req_dt; /* 기안일자 */
	private String writer; /* 기안자 */
	private String use_dept; /* 사용부서 */
	private String user_nm; /* 사용자 */
	private String expend_amt; /* 지출결의 금액 */
	private String doc_sts; /* 문서상태 */
	private Date to_date; /* 조회 시작일자 */
	private Date from_date; /* 조회 종료일자 */

	public int getSeq ( ) {
		return seq;
	}

	public void setSeq ( int seq ) {
		this.seq = seq;
	}

	public String getDoc_no ( ) {
		return CommonConvert.CommonGetStr(doc_no);
	}

	public void setDoc_no ( String docNo ) {
		this.doc_no = docNo;
	}

	public String getDoc_subject ( ) {
		return CommonConvert.CommonGetStr(doc_subject);
	}

	public void setDoc_subject ( String docSubject ) {
		this.doc_subject = docSubject;
	}

	public String getReq_dt ( ) {
		return CommonConvert.CommonGetStr(req_dt);
	}

	public void setReq_dt ( String reqDt ) {
		this.req_dt = reqDt;
	}

	public String getWriter ( ) {
		return CommonConvert.CommonGetStr(writer);
	}

	public void setWriter ( String writer ) {
		this.writer = writer;
	}

	public String getUse_dept ( ) {
		return CommonConvert.CommonGetStr(use_dept);
	}

	public void setUse_dept ( String useDept ) {
		this.use_dept = useDept;
	}

	public String getUser_nm ( ) {
		return CommonConvert.CommonGetStr(user_nm);
	}

	public void setUser_nm ( String userNm ) {
		this.user_nm = userNm;
	}

	public String getExpend_amt ( ) {
		return CommonConvert.CommonGetStr(expend_amt);
	}

	public void setExpend_amt ( String expendAmt ) {
		this.expend_amt = expendAmt;
	}

	public String getDoc_sts ( ) {
		return CommonConvert.CommonGetStr(doc_sts);
	}

	public void setDoc_sts ( String docSts ) {
		this.doc_sts = docSts;
	}

	public Date getTo_date ( ) {
		return to_date;
	}

	public void setTo_date ( Date toDate ) {
		this.to_date = toDate;
	}

	public Date getFrom_date ( ) {
		return from_date;
	}

	public void setFrom_date ( Date fromDate ) {
		this.from_date = fromDate;
	}
}
