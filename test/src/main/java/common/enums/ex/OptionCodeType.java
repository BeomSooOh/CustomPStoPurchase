package common.enums.ex;

/**
 * 환경설정 옵션 코드 
 * Created by Kwon Oh Gwang on 2019-05-23.
 */
public enum OptionCodeType {
	//[레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 )
	LAYOUT_INPUT_SETTING_USERINFO("001002"),
	//[일반설정] 지출결의 전송 시 iCUBE 거래처 자동등록 여부 설정 ( 기본 : 사용 )
	NORMAL_AUTO_INPUT_CUSTOMER_ON_TRANSMISSION("003006"),
	//[입력설정] 표준적요 변경 시 예산정보 초기화 설정 ( 기본 : 미사용 )
	INPUT_INIT_BUDGET_BY_SUMMARY("003105");
	
	private String optionCode;
	
	OptionCodeType(String optionCode) {
		this.optionCode = optionCode;
	}
	
	public String getOptionCode() {
		return optionCode;
	}
}
