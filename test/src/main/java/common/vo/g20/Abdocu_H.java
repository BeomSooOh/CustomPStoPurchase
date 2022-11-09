package common.vo.g20;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;


public class Abdocu_H {

	private String sessionid;
	private String rmk_dc;
	private String modify_id;
	private String modify_dt;
	private String mgt_nm;
	private String mgt_nm_encoding;
	private String mgt_cd;
	private String insert_id;
	private String insert_dt;
	private String erp_year;
	private String erp_gisu_to_dt;
	private String erp_gisu_sq;
	private String erp_gisu_from_dt;
	private String erp_gisu_dt;
	private String erp_gisu;
	private String erp_emp_nm;
	private String erp_emp_cd;
	private String erp_div_nm;
	private String erp_div_cd;
	private String erp_dept_nm;
	private String erp_dept_cd;
	private String erp_co_cd;
	private String erp_co_nm;
	private String edit_proc;
	private String docu_mode;
	private String docu_fg;
	private String docu_fg_text;
	private String btr_nm;
	private String btr_cd;
	private String bottom_nm;
	private String bottom_cd;
	private String abdocu_no_reffer;
	private String abdocu_no;
	private String abdocu_no_new;
	private String c_dikeycode;
	private String sanction_no;
	private String docnumber;
	private String btr_nb;
	/* 로그인 사원의 erp 정보 */
	private String tmp_dept_nm; // 부서명
	private String tmp_dept_cd; // 부서코드
	private String tmp_emp_nm; // 사원명
	private String tmp_emp_cd; // 사원코드
	private String cause_dt; // 원인행위
	private String sign_dt; // 계약일
	private String inspect_dt; // 검수일
	private String cause_id; // 원인행위자 코드
	private String cause_nm; // 원인행위자명
	private String hc_nm;
	private String hc_cd;
	private String complete_yn;
	private String[] date;
	private String it_businessLink;
	private List<HashMap<String, Object>> erpgisu;

	public String getSessionid ( ) {
		return sessionid;
	}

	public void setSessionid ( String sessionid ) {
		this.sessionid = sessionid;
	}

	public String getRmk_dc ( ) {
		return rmk_dc;
	}

	public void setRmk_dc ( String rmkDc ) {
		this.rmk_dc = rmkDc;
	}

	public String getModify_id ( ) {
		return modify_id;
	}

	public void setModify_id ( String modifyId ) {
		this.modify_id = modifyId;
	}

	public String getModify_dt ( ) {
		return modify_dt;
	}

	public void setModify_dt ( String modifyDt ) {
		this.modify_dt = modifyDt;
	}

	public String getMgt_nm ( ) {
		return mgt_nm;
	}

	public void setMgt_nm ( String mgtNm ) {
		this.mgt_nm = mgtNm;
	}

	public String getMgt_nm_encoding ( ) {
		return mgt_nm_encoding;
	}

	public void setMgt_nm_encoding ( String mgtNmEncoding ) {
		this.mgt_nm_encoding = mgtNmEncoding;
	}

	public String getMgt_cd ( ) {
		return mgt_cd;
	}

	public void setMgt_cd ( String mgtCd ) {
		this.mgt_cd = mgtCd;
	}

	public String getInsert_id ( ) {
		return insert_id;
	}

	public void setInsert_id ( String insertId ) {
		this.insert_id = insertId;
	}

	public String getInsert_dt ( ) {
		return insert_dt;
	}

	public void setInsert_dt ( String insertDt ) {
		this.insert_dt = insertDt;
	}

	public String getErp_year ( ) {
		return erp_year;
	}

	public void setErp_year ( String erpYear ) {
		this.erp_year = erpYear;
	}

	public String getErp_gisu_to_dt ( ) {
		return erp_gisu_to_dt;
	}

	public void setErp_gisu_to_dt ( String erpGisuToDt ) {
		this.erp_gisu_to_dt = erpGisuToDt;
	}

	public String getErp_gisu_sq ( ) {
		return erp_gisu_sq;
	}

	public void setErp_gisu_sq ( String erpGisuSq ) {
		this.erp_gisu_sq = erpGisuSq;
	}

	public String getErp_gisu_from_dt ( ) {
		return erp_gisu_from_dt;
	}

	public void setErp_gisu_from_dt ( String erpGisuGromDt ) {
		this.erp_gisu_from_dt = erpGisuGromDt;
	}

	public String getErp_gisu_dt ( ) {
		return erp_gisu_dt;
	}

	public void setErp_gisu_dt ( String erpGisuDt ) {
		this.erp_gisu_dt = erpGisuDt;
	}

	public String getErp_gisu ( ) {
		return erp_gisu;
	}

	public void setErp_gisu ( String erpGisu ) {
		this.erp_gisu = erpGisu;
	}

	public String getErp_emp_nm ( ) {
		return erp_emp_nm;
	}

	public void setErp_emp_nm ( String erpEmpNm ) {
		this.erp_emp_nm = erpEmpNm;
	}

	public String getErp_emp_cd ( ) {
		return erp_emp_cd;
	}

	public void setErp_emp_cd ( String erpEmpCd ) {
		this.erp_emp_cd = erpEmpCd;
	}

	public String getErp_div_nm ( ) {
		return erp_div_nm;
	}

	public void setErp_div_nm ( String erpDivNm ) {
		this.erp_div_nm = erpDivNm;
	}

	public String getErp_div_cd ( ) {
		return erp_div_cd;
	}

	public void setErp_div_cd ( String erpDivCd ) {
		this.erp_div_cd = erpDivCd;
	}

	public String getErp_dept_nm ( ) {
		return erp_dept_nm;
	}

	public void setErp_dept_nm ( String erpDeptNm ) {
		this.erp_dept_nm = erpDeptNm;
	}

	public String getErp_dept_cd ( ) {
		return erp_dept_cd;
	}

	public void setErp_dept_cd ( String erpDeptCd ) {
		this.erp_dept_cd = erpDeptCd;
	}

	public String getErp_co_cd ( ) {
		return erp_co_cd;
	}

	public void setErp_co_cd ( String erpCoCd ) {
		this.erp_co_cd = erpCoCd;
	}

	public String getErp_co_nm ( ) {
		return erp_co_nm;
	}

	public void setErp_co_nm ( String erpCoNm ) {
		this.erp_co_nm = erpCoNm;
	}

	public String getEdit_proc ( ) {
		return edit_proc;
	}

	public void setEdit_proc ( String editProc ) {
		this.edit_proc = editProc;
	}

	public String getDocu_mode ( ) {
		return docu_mode;
	}

	public void setDocu_mode ( String docuMode ) {
		this.docu_mode = docuMode;
	}

	public String getDocu_fg ( ) {
		return docu_fg;
	}

	public void setDocu_fg ( String docuFg ) {
		this.docu_fg = docuFg;
	}

	public String getDocu_fg_text ( ) {
		return docu_fg_text;
	}

	public void setDocu_fg_text ( String docuFgText ) {
		this.docu_fg_text = docuFgText;
	}

	public String getBtr_nm ( ) {
		return btr_nm;
	}

	public void setBtr_nm ( String btrNm ) {
		this.btr_nm = btrNm;
	}

	public String getBtr_cd ( ) {
		return btr_cd;
	}

	public void setBtr_cd ( String btrCd ) {
		this.btr_cd = btrCd;
	}

	public String getBottom_nm ( ) {
		return bottom_nm;
	}

	public void setBottom_nm ( String bottomNm ) {
		this.bottom_nm = bottomNm;
	}

	public String getBottom_cd ( ) {
		return bottom_cd;
	}

	public void setBottom_cd ( String bottomCd ) {
		this.bottom_cd = bottomCd;
	}

	public String getAbdocu_no_reffer ( ) {
		return abdocu_no_reffer;
	}

	public void setAbdocu_no_reffer ( String abdocuNoReffer ) {
		this.abdocu_no_reffer = abdocuNoReffer;
	}

	public String getAbdocu_no ( ) {
		return abdocu_no;
	}

	public void setAbdocu_no ( String abdocuNo ) {
		this.abdocu_no = abdocuNo;
	}

	public String getAbdocu_no_new ( ) {
		return abdocu_no_new;
	}

	public void setAbdocu_no_new ( String abdocuNoNew ) {
		this.abdocu_no_new = abdocuNoNew;
	}

	public String getC_dikeycode ( ) {
		return c_dikeycode;
	}

	public void setC_dikeycode ( String cDikeycode ) {
		this.c_dikeycode = cDikeycode;
	}

	public String getSanction_no ( ) {
		return sanction_no;
	}

	public void setSanction_no ( String sanctionNo ) {
		this.sanction_no = sanctionNo;
	}

	public String getDocnumber ( ) {
		return docnumber;
	}

	public void setDocnumber ( String docnumber ) {
		this.docnumber = docnumber;
	}

	public String getBtr_nb ( ) {
		return btr_nb;
	}

	public void setBtr_nb ( String btrNb ) {
		this.btr_nb = btrNb;
	}

	public String getTmp_dept_nm ( ) {
		return tmp_dept_nm;
	}

	public void setTmp_dept_nm ( String tmpDeptNm ) {
		this.tmp_dept_nm = tmpDeptNm;
	}

	public String getTmp_dept_cd ( ) {
		return tmp_dept_cd;
	}

	public void setTmp_dept_cd ( String tmpDeptCd ) {
		this.tmp_dept_cd = tmpDeptCd;
	}

	public String getTmp_emp_nm ( ) {
		return tmp_emp_nm;
	}

	public void setTmp_emp_nm ( String tmpEmpNm ) {
		this.tmp_emp_nm = tmpEmpNm;
	}

	public String getTmp_emp_cd ( ) {
		return tmp_emp_cd;
	}

	public void setTmp_emp_cd ( String tmpEmpCd ) {
		this.tmp_emp_cd = tmpEmpCd;
	}

	public String getCause_dt ( ) {
		return cause_dt;
	}

	public void setCause_dt ( String causeDt ) {
		this.cause_dt = causeDt;
	}

	public String getSign_dt ( ) {
		return sign_dt;
	}

	public void setSign_dt ( String signDt ) {
		this.sign_dt = signDt;
	}

	public String getInspect_dt ( ) {
		return inspect_dt;
	}

	public void setInspect_dt ( String inspectDt ) {
		this.inspect_dt = inspectDt;
	}

	public String getCause_id ( ) {
		return cause_id;
	}

	public void setCause_id ( String causeId ) {
		this.cause_id = causeId;
	}

	public String getCause_nm ( ) {
		return cause_nm;
	}

	public void setCause_nm ( String causeNm ) {
		this.cause_nm = causeNm;
	}

	public String getHc_nm ( ) {
		return hc_nm;
	}

	public void setHc_nm ( String hcNm ) {
		this.hc_nm = hcNm;
	}

	public String getHc_cd ( ) {
		return hc_cd;
	}

	public void setHc_cd ( String hcCd ) {
		this.hc_cd = hcCd;
	}

	public String getComplete_yn ( ) {
		return complete_yn;
	}

	public void setComplete_yn ( String completeYn ) {
		this.complete_yn = completeYn;
	}

	public String[] getDate ( ) {
		return date;
	}

	public void setDate ( String[] date ) {
		this.date = date;
	}

	public String getIt_businessLink ( ) {
		return it_businessLink;
	}

	public void setIt_businessLink ( String itBusinessLink ) {
		this.it_businessLink = itBusinessLink;
	}

	public List<HashMap<String, Object>> getErpgisu ( ) {
		return erpgisu;
	}

	public void setErpgisu ( List<HashMap<String, Object>> erpgisu ) {
		this.erpgisu = erpgisu;
	}

	@Override
	public String toString ( ) {
		return "Abdocu_H [sessionid=" + sessionid + ", rmk_dc=" + rmk_dc + ", modify_id=" + modify_id + ", modify_dt=" + modify_dt + ", mgt_nm=" + mgt_nm + ", mgt_nm_encoding=" + mgt_nm_encoding + ", mgt_cd=" + mgt_cd + ", insert_id=" + insert_id + ", insert_dt=" + insert_dt + ", erp_year=" + erp_year + ", erp_gisu_to_dt=" + erp_gisu_to_dt + ", erp_gisu_sq=" + erp_gisu_sq + ", erp_gisu_from_dt=" + erp_gisu_from_dt + ", erp_gisu_dt=" + erp_gisu_dt + ", erp_gisu=" + erp_gisu + ", erp_emp_nm=" + erp_emp_nm + ", erp_emp_cd=" + erp_emp_cd + ", erp_div_nm=" + erp_div_nm + ", erp_div_cd=" + erp_div_cd + ", erp_dept_nm=" + erp_dept_nm + ", erp_dept_cd=" + erp_dept_cd + ", erp_co_cd=" + erp_co_cd + ", erp_co_nm=" + erp_co_nm + ", edit_proc=" + edit_proc + ", docu_mode=" + docu_mode + ", docu_fg=" + docu_fg + ", docu_fg_text=" + docu_fg_text + ", btr_nm=" + btr_nm + ", btr_cd=" + btr_cd + ", bottom_nm=" + bottom_nm + ", bottom_cd=" + bottom_cd + ", abdocu_no_reffer=" + abdocu_no_reffer
				+ ", abdocu_no=" + abdocu_no + ", abdocu_no_new=" + abdocu_no_new + ", c_dikeycode=" + c_dikeycode + ", sanction_no=" + sanction_no + ", docnumber=" + docnumber + ", btr_nb=" + btr_nb + ", tmp_dept_nm=" + tmp_dept_nm + ", tmp_dept_cd=" + tmp_dept_cd + ", tmp_emp_nm=" + tmp_emp_nm + ", tmp_emp_cd=" + tmp_emp_cd + ", cause_dt=" + cause_dt + ", sign_dt=" + sign_dt + ", inspect_dt=" + inspect_dt + ", cause_id=" + cause_id + ", cause_nm=" + cause_nm + ", hc_nm=" + hc_nm + ", hc_cd=" + hc_cd + ", complete_yn=" + complete_yn + ", date=" + Arrays.toString( date ) + ", it_businessLink=" + it_businessLink + ", erpgisu=" + erpgisu + "]";
	}
}
