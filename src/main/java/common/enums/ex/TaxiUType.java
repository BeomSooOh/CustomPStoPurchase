package common.enums.ex;

/*
 * 이준성 개발 
 * ERP iU 과세 구분 유형 개발 
 */


public enum TaxiUType {

  GENERAL_TAXATION("1","일반"),
  SIMPLE_TAXATION("2","간이"),
  TAXFREE_TAXATION("3","면세"),
  CLOSING_TAXATION("4","휴업"),
  CLOSED_TAXATION("5","폐업"),
  NONPROFIT_TAXATION("6","비영리"),
  OVERSEAS_CASE_TAXATION("7","해외건"),
  UNREGISTERED_TAXATION("8","미등록"),
  ERROR_TAXATION("9","오류"),
  SIMPLE_TAXPAYER_TAX_INVOICE("A","간이과세자(세금계산서발급사업자)");
  
  private String taxTypeCode;
  private String taxTypeName; 
  
  TaxiUType(String taxTypeCode, String taxTypeName){
    this.taxTypeCode = taxTypeCode;
    this.taxTypeName = taxTypeName;
  }
  
  public static String findByTaxTypeCode(String code) {
    String result = "";
    for(TaxiUType type : TaxiUType.values()) {
      if(type.getTaxTypeCode().equals(code)) {
        result = type.getTaxTypeName();
      }
    }
    return result;
  }

  public String getTaxTypeCode() {
    return taxTypeCode;
  }

  public void setTaxTypeCode(String taxTypeCode) {
    this.taxTypeCode = taxTypeCode;
  }

  public String getTaxTypeName() {
    return taxTypeName;
  }

  public void setTaxTypeName(String taxTypeName) {
    this.taxTypeName = taxTypeName;
  }

}
