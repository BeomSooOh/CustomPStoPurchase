package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExOptionVO {

	private String option_name = commonCode.EMPTYSTR; /* 옵션 명 */
	private String option_code = commonCode.EMPTYSTR; /* 옵션 코드 */
	private String option_value = commonCode.EMPTYSTR; /* 옵션 값 */

	public String getOption_name ( ) {
		return CommonConvert.CommonGetStr(option_name);
	}

	public void setOption_name ( String optionName ) {
		this.option_name = optionName;
	}

	public String getOption_code ( ) {
		return CommonConvert.CommonGetStr(option_code);
	}

	public void setOption_code ( String optionCode ) {
		this.option_code = optionCode;
	}

	public String getOption_value ( ) {
		return CommonConvert.CommonGetStr(option_value);
	}

	public void setOption_value ( String optionValue ) {
		this.option_value = optionValue;
	}

	@Override
	public String toString ( ) {
		return "ExOptionVO [option_name=" + option_name + ", option_code=" + option_code + ", option_value=" + option_value + "]";
	}
}
