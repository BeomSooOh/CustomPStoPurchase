/**
  * @FileName : CommonCodeVO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.vo.common;

import common.helper.convert.CommonConvert;

/**
 *   * @FileName : CommonCodeVO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class CommonCodeVO {

	private String commonCode = common.vo.common.CommonInterface.commonCode.EMPTYSTR;
	private String commonName = common.vo.common.CommonInterface.commonCode.EMPTYSEQ;
	private int commonOrder = 99999;

	public String getCommonCode ( ) {
		return CommonConvert.CommonGetStr(commonCode);
	}

	public void setCommonCode ( String commonCode ) {
		this.commonCode = commonCode;
	}

	public String getCommonName ( ) {
		return CommonConvert.CommonGetStr(commonName);
	}

	public void setCommonName ( String commonName ) {
		this.commonName = commonName;
	}

	public int getCommonOrder ( ) {
		return commonOrder;
	}

	public void setCommonOrder ( int commonOrder ) {
		this.commonOrder = commonOrder;
	}

	@Override
	public String toString ( ) {
		return "CommonCodeVO [commonCode=" + commonCode + ", commonName=" + commonName + ", commonOrder=" + commonOrder + "]";
	}
}
