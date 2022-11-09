package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExConfigMngVO {

	private String comp_seq = commonCode.EMPTYSTR; /* 회사 시퀀스 */
	private String ctd_cd = commonCode.EMPTYSTR; /* 관리내역 코드 */
	private String ctd_nm = commonCode.EMPTYSTR; /* 관리내역 명칭 */
	private String cust_set = commonCode.EMPTYSTR;
	private String form_seq = commonCode.EMPTYSTR; /* 양식 시퀀스 */
	private String mng_cd = commonCode.EMPTYSTR; /* 관리항목 코드 */
	private String mng_gb = commonCode.EMPTYSTR; /* 관리항목 구분 */
	private String mng_nm = commonCode.EMPTYSTR; /* 관리항목 명칭 */
	private String use_gb = commonCode.EMPTYSTR; /* 사용구분 */

	public String getComp_seq ( ) {
		return CommonConvert.CommonGetStr(comp_seq);
	}

	public void setComp_seq ( String compSeq ) {
		this.comp_seq = compSeq;
	}

	public String getCtd_cd ( ) {
		return CommonConvert.CommonGetStr(ctd_cd);
	}

	public void setCtd_cd ( String ctdCd ) {
		this.ctd_cd = ctdCd;
	}

	public String getCtd_nm ( ) {
		return CommonConvert.CommonGetStr(ctd_nm);
	}

	public void setCtd_nm ( String ctdNm ) {
		this.ctd_nm = ctdNm;
	}

	public String getCust_set ( ) {
		return CommonConvert.CommonGetStr(cust_set);
	}

	public void setCust_set ( String custSet ) {
		this.cust_set = custSet;
	}

	public String getForm_seq ( ) {
		return CommonConvert.CommonGetStr(form_seq);
	}

	public void setForm_seq ( String formSeq ) {
		this.form_seq = formSeq;
	}

	public String getMng_cd ( ) {
		return CommonConvert.CommonGetStr(mng_cd);
	}

	public void setMng_cd ( String mngCd ) {
		this.mng_cd = mngCd;
	}

	public String getMng_gb ( ) {
		return CommonConvert.CommonGetStr(mng_gb);
	}

	public void setMng_gb ( String mngGb ) {
		this.mng_gb = mngGb;
	}

	public String getMng_nm ( ) {
		return CommonConvert.CommonGetStr(mng_nm);
	}

	public void setMng_nm ( String mngNm ) {
		this.mng_nm = mngNm;
	}

	public String getUse_gb ( ) {
		return CommonConvert.CommonGetStr(use_gb);
	}

	public void setUse_gb ( String useGb ) {
		this.use_gb = useGb;
	}

	@Override
	public String toString ( ) {
		return "ExConfigMngVO [comp_seq=" + comp_seq + ", ctd_cd=" + ctd_cd + ", ctd_nm=" + ctd_nm + ", cust_set=" + cust_set + ", form_seq=" + form_seq + ", mng_cd=" + mng_cd + ", mng_gb=" + mng_gb + ", mng_nm=" + mng_nm + ", use_gb=" + use_gb + "]";
	}
}
