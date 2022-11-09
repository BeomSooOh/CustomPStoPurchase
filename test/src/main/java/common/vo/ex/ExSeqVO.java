package common.vo.ex;

public class ExSeqVO {

	private int login_comp_seq = 0; /* BizboxA 회사 시퀀스 */
	private int login_biz_seq = 0; /* BizboxA 사업장 시퀀스 */
	private int login_dept_seq = 0; /* BizboxA 부서 시퀀스 */
	private int login_emp_seq = 0; /* BizboxA 사원 시퀀스 */
	private int expend_seq = 0; /* 지출결의 시퀀스 */
	private int list_seq = 0; /* 지출결의 항목 시퀀스 */
	private int slip_seq = 0; /* 지출결의 항목 분개 시퀀스 */
	private int write_seq = 0; /* 작성자 시퀀스 */
	private int emp_seq = 0; /* 사용자 시퀀스 */
	private int summary_seq = 0; /* 표준적요 시퀀스 */
	private int auth_seq = 0; /* 증빙유형 시퀀스 */
	private int budget_seq = 0; /* 예산 시퀀스 */
	private int project_seq = 0; /* 프로젝트 시퀀스 */
	private int card_seq = 0; /* 카드 시퀀스 */
	private int partner_seq = 0; /* 거래처 시퀀스 */

	public int getLogin_comp_seq ( ) {
		return login_comp_seq;
	}

	public void setLogin_comp_seq ( int loginCompSeq ) {
		this.login_comp_seq = loginCompSeq;
	}

	public int getLogin_biz_seq ( ) {
		return login_biz_seq;
	}

	public void setLogin_biz_seq ( int loginBizSeq ) {
		this.login_biz_seq = loginBizSeq;
	}

	public int getLogin_dept_seq ( ) {
		return login_dept_seq;
	}

	public void setLogin_dept_seq ( int loginDeptSeq ) {
		this.login_dept_seq = loginDeptSeq;
	}

	public int getLogin_emp_seq ( ) {
		return login_emp_seq;
	}

	public void setLogin_emp_seq ( int loginEmpSeq ) {
		this.login_emp_seq = loginEmpSeq;
	}

	public int getExpend_seq ( ) {
		return expend_seq;
	}

	public void setExpend_seq ( int expendSeq ) {
		this.expend_seq = expendSeq;
	}

	public int getList_seq ( ) {
		return list_seq;
	}

	public void setList_seq ( int listSeq ) {
		this.list_seq = listSeq;
	}

	public int getSlip_seq ( ) {
		return slip_seq;
	}

	public void setSlip_seq ( int slipSeq ) {
		this.slip_seq = slipSeq;
	}

	public int getWrite_seq ( ) {
		return write_seq;
	}

	public void setWrite_seq ( int writeSeq ) {
		this.write_seq = writeSeq;
	}

	public int getEmp_seq ( ) {
		return emp_seq;
	}

	public void setEmp_seq ( int empSeq ) {
		this.emp_seq = empSeq;
	}

	public int getSummary_seq ( ) {
		return summary_seq;
	}

	public void setSummary_seq ( int summarySeq ) {
		this.summary_seq = summarySeq;
	}

	public int getAuth_seq ( ) {
		return auth_seq;
	}

	public void setAuth_seq ( int authSeq ) {
		this.auth_seq = authSeq;
	}

	public int getBudget_seq ( ) {
		return budget_seq;
	}

	public void setBudget_seq ( int budgetSeq ) {
		this.budget_seq = budgetSeq;
	}

	public int getProject_seq ( ) {
		return project_seq;
	}

	public void setProject_seq ( int projectSeq ) {
		this.project_seq = projectSeq;
	}

	public int getCard_seq ( ) {
		return card_seq;
	}

	public void setCard_seq ( int cardSeq ) {
		this.card_seq = cardSeq;
	}

	public int getPartner_seq ( ) {
		return partner_seq;
	}

	public void setPartner_seq ( int partnerSeq ) {
		this.partner_seq = partnerSeq;
	}

	@Override
	public String toString ( ) {
		return "ExSeqVO [login_comp_seq=" + login_comp_seq + ", login_biz_seq=" + login_biz_seq + ", login_dept_seq=" + login_dept_seq + ", login_emp_seq=" + login_emp_seq + ", expend_seq=" + expend_seq + ", list_seq=" + list_seq + ", slip_seq=" + slip_seq + ", write_seq=" + write_seq + ", emp_seq=" + emp_seq + ", summary_seq=" + summary_seq + ", auth_seq=" + auth_seq + ", budget_seq=" + budget_seq + ", project_seq=" + project_seq + ", card_seq=" + card_seq + ", partner_seq=" + partner_seq + "]";
	}
}
