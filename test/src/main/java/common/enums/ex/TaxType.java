package common.enums.ex;

/**
 * 과세유형 타입 
 * Created by Kwon Oh Gwang on 2020-02-27.
 */
public enum TaxType {
	GENERAL_TAXPAYER("1001", "1", "일반과세자"),
	SIMPLE_TAXPAYER("1002", "2", "간이과세자"),
	DUTY_FREE_OPERATOR("1003", "3", "면세사업자"),
	NONPROFIT_CORPORATION("1004", "6", "비영리법인"),
	CLOSE_TEMPORARILY_TAXPAYER("1005", "4", "휴업자"),
	UNREGISTERED_OPERATOR("1006", "8", "미등록 사업자"),
	CLOSED_TAXPAYER("1007", "5", "폐업자"),
	OVERSEAS_USAGE("2001", "0", "해외사용분"),
	UNDEFINED("9999", "7", "알수없음");
	
	private String taxTypeCode;
	private String vanTypeCode;
	private String taxTypeName;
	
	// iCUBE : taxTyepCode, VAN: vanTypeCode, iCUBE는 mcc_code 컬럼을 사용하지만 VAN사는 vat_stat를 사용하고 있음.
	TaxType(String taxTypeCode, String vanTypeCode, String taxTypeName) {
		this.taxTypeCode = taxTypeCode;
		this.vanTypeCode = vanTypeCode;
		this.taxTypeName = taxTypeName;
	}
	
	public static String findByTaxTypeCode(String code) {
		String result = "";
		
		for(TaxType array : TaxType.values()) {
			if(array.getTaxTypeCode().equals(code) || array.getVanTypeCode().equals(code)) {
				result = array.getTaxTypeName();
			}
		}
		
		return result;
	}
	
	public String getTaxTypeCode() {
		return taxTypeCode;
	}
	
	public String getVanTypeCode() {
		return vanTypeCode;
	}
	
	public String getTaxTypeName() {
		return taxTypeName;
	}
}
