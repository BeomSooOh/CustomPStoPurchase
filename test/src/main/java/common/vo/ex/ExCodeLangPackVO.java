package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExCodeLangPackVO {

	private String comp_seq = commonCode.EMPTYSTR; /* 회사 시퀀스 */
	private String langpack_code = commonCode.EMPTYSTR;
	private String langpack_name = commonCode.EMPTYSTR;
	private String name_kr = commonCode.EMPTYSTR;
	private String name_en = commonCode.EMPTYSTR;
	private String name_jp = commonCode.EMPTYSTR;
	private String name_cn = commonCode.EMPTYSTR;

	public String getComp_seq ( ) {
		return CommonConvert.CommonGetStr(comp_seq);
	}

	public void setComp_seq ( String compSeq ) {
		this.comp_seq = compSeq;
	}

	public String getLangpack_code ( ) {
		return CommonConvert.CommonGetStr(langpack_code);
	}

	public void setLangpack_code ( String langpackCode ) {
		this.langpack_code = langpackCode;
	}

	public String getLangpack_name ( ) {
		return CommonConvert.CommonGetStr(langpack_name);
	}

	public void setLangpack_name ( String langpackName ) {
		this.langpack_name = langpackName;
	}

	public String getName_kr ( ) {
		return CommonConvert.CommonGetStr(name_kr);
	}

	public void setName_kr ( String nameKr ) {
		this.name_kr = nameKr;
	}

	public String getName_en ( ) {
		return CommonConvert.CommonGetStr(name_en);
	}

	public void setName_en ( String nameEn ) {
		this.name_en = nameEn;
	}

	public String getName_jp ( ) {
		return CommonConvert.CommonGetStr(name_jp);
	}

	public void setName_jp ( String nameJp ) {
		this.name_jp = nameJp;
	}

	public String getName_cn ( ) {
		return CommonConvert.CommonGetStr(name_cn);
	}

	public void setName_cn ( String nameCn ) {
		this.name_cn = nameCn;
	}

	@Override
	public String toString ( ) {
		return "ExCodeLangPackVO [comp_seq=" + comp_seq + ", langpack_code=" + langpack_code + ", langpack_name=" + langpack_name + ", name_kr=" + name_kr + ", name_en=" + name_en + ", name_jp=" + name_jp + ", name_cn=" + name_cn + "]";
	}
}
