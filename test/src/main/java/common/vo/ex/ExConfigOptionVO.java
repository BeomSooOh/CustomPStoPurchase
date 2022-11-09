package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExConfigOptionVO {

	private String comp_seq = commonCode.EMPTYSEQ; /* 회사 시퀀스 */
	private String form_seq = commonCode.EMPTYSEQ; /* 양식 시퀀스 */
	private String option_gbn = commonCode.EMPTYSTR; /* 옵션 대구분 */
	private String option_code = commonCode.EMPTYSTR; /* 옵션 상세구분 */
	private String use_sw = commonCode.EMPTYSTR; /* 사용시스템 */
	private String order_num = commonCode.EMPTYSEQ; /* 정렬순서 */
	private String common_code = commonCode.EMPTYSTR; /* 귀속 공통코드 */
	private String base_code = commonCode.EMPTYSTR; /* 기본값 */
	private String base_value = commonCode.EMPTYSTR; /* 기본값 */
	private String base_name = commonCode.EMPTYSTR; /* 기본값 */
	private String base_emp_value = commonCode.EMPTYSTR; /* 기본값 */
	private String set_value = commonCode.EMPTYSTR; /* 설정값 */
	private String set_name = commonCode.EMPTYSTR; /* 설정값 */
	private String set_emp_value = commonCode.EMPTYSTR; /* 설정값 */
	private String option_select_type = commonCode.EMPTYSTR; /* 옵션표현형태 */
	private String optioin_process_type = commonCode.EMPTYSTR; /* 옵션사용형태 */
	private String option_name = commonCode.EMPTYSTR; /* 옵션명칭 */
	private String option_note = commonCode.EMPTYSTR; /* 옵셩설명 */
	private String use_yn = commonCode.EMPTYYES; /* 사용여부 */
	private String lang_code = "kr"; /* 언어코드 */
	private String create_seq = commonCode.EMPTYSEQ; /* 생성자 */
	private String modify_seq = commonCode.EMPTYSEQ; /* 수정자 */

	public String getComp_seq ( ) {
		return CommonConvert.CommonGetStr(comp_seq);
	}

	public void setComp_seq ( String compSeq ) {
		this.comp_seq = compSeq;
	}

	public String getForm_seq ( ) {
		return CommonConvert.CommonGetStr(form_seq);
	}

	public void setForm_seq ( String formSeq ) {
		this.form_seq = formSeq;
	}

	public String getOption_gbn ( ) {
		return CommonConvert.CommonGetStr(option_gbn);
	}

	public void setOption_gbn ( String optionGbn ) {
		this.option_gbn = optionGbn;
	}

	public String getOption_code ( ) {
		return CommonConvert.CommonGetStr(option_code);
	}

	public void setOption_code ( String optionCode ) {
		this.option_code = optionCode;
	}

	public String getUse_sw ( ) {
		return CommonConvert.CommonGetStr(use_sw);
	}

	public void setUse_sw ( String useSw ) {
		this.use_sw = useSw;
	}

	public String getOrder_num ( ) {
		return CommonConvert.CommonGetStr(order_num);
	}

	public void setOrder_num ( String orderNum ) {
		this.order_num = orderNum;
	}

	public String getCommon_code ( ) {
		return CommonConvert.CommonGetStr(common_code);
	}

	public void setCommon_code ( String commonCode ) {
		this.common_code = commonCode;
	}

	public String getBase_code ( ) {
		return CommonConvert.CommonGetStr(base_code);
	}

	public void setBase_code ( String baseCode ) {
		this.base_code = baseCode;
	}

	public String getBase_value ( ) {
		return CommonConvert.CommonGetStr(base_value);
	}

	public void setBase_value ( String baseValue ) {
		this.base_value = baseValue;
	}

	public String getBase_name ( ) {
		return CommonConvert.CommonGetStr(base_name);
	}

	public void setBase_name ( String baseName ) {
		this.base_name = baseName;
	}

	public String getBase_emp_value ( ) {
		return CommonConvert.CommonGetStr(base_emp_value);
	}

	public void setBase_emp_value ( String baseEmpValue ) {
		this.base_emp_value = baseEmpValue;
	}

	public String getSet_value ( ) {
		return CommonConvert.CommonGetStr(set_value);
	}

	public void setSet_value ( String setValue ) {
		this.set_value = setValue;
	}

	public String getSet_name ( ) {
		return CommonConvert.CommonGetStr(set_name);
	}

	public void setSet_name ( String setName ) {
		this.set_name = setName;
	}

	public String getSet_emp_value ( ) {
		return CommonConvert.CommonGetStr(set_emp_value);
	}

	public void setSet_emp_value ( String setEmpValue ) {
		this.set_emp_value = setEmpValue;
	}

	public String getOption_select_type ( ) {
		return CommonConvert.CommonGetStr(option_select_type);
	}

	public void setOption_select_type ( String optionSelectType ) {
		this.option_select_type = optionSelectType;
	}

	public String getOptioin_process_type ( ) {
		return CommonConvert.CommonGetStr(optioin_process_type);
	}

	public void setOptioin_process_type ( String optioinProcessType ) {
		this.optioin_process_type = optioinProcessType;
	}

	public String getOption_name ( ) {
		return CommonConvert.CommonGetStr(option_name);
	}

	public void setOption_name ( String optionName ) {
		this.option_name = optionName;
	}

	public String getOption_note ( ) {
		return CommonConvert.CommonGetStr(option_note);
	}

	public void setOption_note ( String optionNote ) {
		this.option_note = optionNote;
	}

	public String getUse_yn ( ) {
		return CommonConvert.CommonGetStr(use_yn);
	}

	public void setUse_yn ( String useYn ) {
		this.use_yn = useYn;
	}

	public String getLang_code ( ) {
		return CommonConvert.CommonGetStr(lang_code);
	}

	public void setLang_code ( String langCode ) {
		this.lang_code = langCode;
	}

	public String getCreate_seq ( ) {
		return CommonConvert.CommonGetStr(create_seq);
	}

	public void setCreate_seq ( String createSeq ) {
		this.create_seq = createSeq;
	}

	public String getModify_seq ( ) {
		return CommonConvert.CommonGetStr(modify_seq);
	}

	public void setModify_seq ( String modifySeq ) {
		this.modify_seq = modifySeq;
	}

	@Override
	public String toString ( ) {
		return "ExConfigOptionVO [comp_seq=" + comp_seq + ", form_seq=" + form_seq + ", option_gbn=" + option_gbn + ", option_code=" + option_code + ", use_sw=" + use_sw + ", order_num=" + order_num + ", common_code=" + common_code + ", base_code=" + base_code + ", base_value=" + base_value + ", base_name=" + base_name + ", base_emp_value=" + base_emp_value + ", set_value=" + set_value + ", set_name=" + set_name + ", set_emp_value=" + set_emp_value + ", option_select_type=" + option_select_type + ", optioin_process_type=" + optioin_process_type + ", option_name=" + option_name + ", option_note=" + option_note + ", use_yn=" + use_yn + ", lang_code=" + lang_code + ", create_seq=" + create_seq + ", modify_seq=" + modify_seq + "]";
	}
}