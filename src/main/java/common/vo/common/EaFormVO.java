package common.vo.common;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class EaFormVO {

	String form_id = commonCode.EMPTYSEQ;
	String form_nm = commonCode.EMPTYSTR;
	String form_nm_en = commonCode.EMPTYSTR;
	String form_nm_jp = commonCode.EMPTYSTR;
	String form_nm_cn = commonCode.EMPTYSTR;
	String form_short_nm = commonCode.EMPTYSTR;
	String form_tp = commonCode.EMPTYSTR;
	String form_d_tp = commonCode.EMPTYSTR;
	String form_size = commonCode.EMPTYSEQ;
	String form_mode = commonCode.EMPTYSTR;
	String form_alert = commonCode.EMPTYSTR;
	String interlock_url = commonCode.EMPTYSTR;
	String interlock_width = commonCode.EMPTYSEQ;
	String interlock_height = commonCode.EMPTYSEQ;
	String interlock_yn = commonCode.EMPTYNO;

	public String getForm_id ( ) {
		return CommonConvert.CommonGetStr(form_id);
	}

	public void setForm_id ( String formId ) {
		this.form_id = formId;
	}

	public String getForm_nm ( ) {
		return CommonConvert.CommonGetStr(form_nm);
	}

	public void setForm_nm ( String formNm ) {
		this.form_nm = formNm;
	}

	public String getForm_nm_en ( ) {
		return CommonConvert.CommonGetStr(form_nm_en);
	}

	public void setForm_nm_en ( String formNmEn ) {
		this.form_nm_en = formNmEn;
	}

	public String getForm_nm_jp ( ) {
		return CommonConvert.CommonGetStr(form_nm_jp);
	}

	public void setForm_nm_jp ( String formNmJp ) {
		this.form_nm_jp = formNmJp;
	}

	public String getForm_nm_cn ( ) {
		return CommonConvert.CommonGetStr(form_nm_cn);
	}

	public void setForm_nm_cn ( String formNmCn ) {
		this.form_nm_cn = formNmCn;
	}

	public String getForm_short_nm ( ) {
		return CommonConvert.CommonGetStr(form_short_nm);
	}

	public void setForm_short_nm ( String formShortNm ) {
		this.form_short_nm = formShortNm;
	}

	public String getForm_tp ( ) {
		return CommonConvert.CommonGetStr(form_tp);
	}

	public void setForm_tp ( String formTp ) {
		this.form_tp = formTp;
	}

	public String getForm_d_tp ( ) {
		return CommonConvert.CommonGetStr(form_d_tp);
	}

	public void setForm_d_tp ( String formDTp ) {
		this.form_d_tp = formDTp;
	}

	public String getForm_size ( ) {
		return CommonConvert.CommonGetStr(form_size);
	}

	public void setForm_size ( String formSize ) {
		this.form_size = formSize;
	}

	public String getForm_mode ( ) {
		return CommonConvert.CommonGetStr(form_mode);
	}

	public void setForm_mode ( String formMode ) {
		this.form_mode = formMode;
	}

	public String getForm_alert ( ) {
		return CommonConvert.CommonGetStr(form_alert);
	}

	public void setForm_alert ( String formAlert ) {
		this.form_alert = formAlert;
	}

	public String getInterlock_url ( ) {
		return CommonConvert.CommonGetStr(interlock_url);
	}

	public void setInterlock_url ( String interlockUrl ) {
		this.interlock_url = interlockUrl;
	}

	public String getInterlock_width ( ) {
		return CommonConvert.CommonGetStr(interlock_width);
	}

	public void setInterlock_width ( String interlockWidth ) {
		this.interlock_width = interlockWidth;
	}

	public String getInterlock_height ( ) {
		return CommonConvert.CommonGetStr(interlock_height);
	}

	public void setInterlock_height ( String interlockHeight ) {
		this.interlock_height = interlockHeight;
	}

	public String getInterlock_yn ( ) {
		return CommonConvert.CommonGetStr(interlock_yn);
	}

	public void setInterlock_yn ( String interlockYn ) {
		this.interlock_yn = interlockYn;
	}

	@Override
	public String toString ( ) {
		return "EaFormVO [form_id=" + form_id + ", form_nm=" + form_nm + ", form_nm_en=" + form_nm_en + ", form_nm_jp=" + form_nm_jp + ", form_nm_cn=" + form_nm_cn + ", form_short_nm=" + form_short_nm + ", form_tp=" + form_tp + ", form_d_tp=" + form_d_tp + ", form_size=" + form_size + ", form_mode=" + form_mode + ", form_alert=" + form_alert + ", interlock_url=" + interlock_url + ", interlock_width=" + interlock_width + ", interlock_height=" + interlock_height + ", interlock_yn=" + interlock_yn + "]";
	}
}
