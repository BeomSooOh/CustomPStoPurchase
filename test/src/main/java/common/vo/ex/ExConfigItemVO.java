package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExConfigItemVO {

	private String comp_seq = commonCode.EMPTYSTR;
	private String display_align = commonCode.EMPTYSTR;
	private String form_seq = commonCode.EMPTYSTR;
	private String head_code = commonCode.EMPTYSTR;
	private String langpack_code = commonCode.EMPTYSTR;
	private String item_gbn = commonCode.EMPTYSTR;
	private String langpack_name = commonCode.EMPTYSTR;
	private String order_num = commonCode.EMPTYSTR;
	private String select_yn = commonCode.EMPTYSTR;
	private String lang_type = commonCode.EMPTYSTR;

	public String getLang_type() {
		return lang_type;
	}

	public void setLang_type(String langType) {
		this.lang_type = langType;
	}

	public String getComp_seq ( ) {
		return CommonConvert.CommonGetStr(comp_seq);
	}

	public void setComp_seq ( String compSeq ) {
		this.comp_seq = compSeq;
	}

	public String getDisplay_align ( ) {
		return CommonConvert.CommonGetStr(display_align);
	}

	public void setDisplay_align ( String displayAlign ) {
		this.display_align = displayAlign;
	}

	public String getForm_seq ( ) {
		return CommonConvert.CommonGetStr(form_seq);
	}

	public void setForm_seq ( String formSeq ) {
		this.form_seq = formSeq;
	}

	public String getHead_code ( ) {
		return CommonConvert.CommonGetStr(head_code);
	}

	public void setHead_code ( String headCode ) {
		this.head_code = headCode;
	}

	public String getLangpack_code ( ) {
		return CommonConvert.CommonGetStr(langpack_code);
	}

	public void setLangpack_code ( String langpackCode ) {
		this.langpack_code = langpackCode;
	}

	public String getItem_gbn ( ) {
		return CommonConvert.CommonGetStr(item_gbn);
	}

	public void setItem_gbn ( String itemGbn ) {
		this.item_gbn = itemGbn;
	}

	public String getLangpack_name ( ) {
		return CommonConvert.CommonGetStr(langpack_name);
	}

	public void setLangpack_name ( String langpackName ) {
		this.langpack_name = langpackName;
	}

	public String getOrder_num ( ) {
		return CommonConvert.CommonGetStr(order_num);
	}

	public void setOrder_num ( String orderNum ) {
		this.order_num = orderNum;
	}

	public String getSelect_yn ( ) {
		return CommonConvert.CommonGetStr(select_yn);
	}

	public void setSelect_yn ( String selectYn ) {
		this.select_yn = selectYn;
	}

	@Override
	public String toString ( ) {
		return "ExConfigItemVO [comp_seq=" + comp_seq + ", display_align=" + display_align + ", form_seq=" + form_seq + ", head_code=" + head_code + ", langpack_code=" + langpack_code + ", item_gbn=" + item_gbn + ", langpack_name=" + langpack_name + ", order_num=" + order_num + ", select_yn=" + select_yn + ", lang_type=" + lang_type + "]";
	}
}
