/**
  * @FileName : InterlockExpendVO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.vo.interlock;

import javax.xml.bind.annotation.XmlRootElement;

import common.vo.common.CommonInterface.commonCode;


/**
 *   * @FileName : InterlockExpendVO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
@XmlRootElement ( name = "content" )
public class InterlockExpendVO {

	private String resultCode = commonCode.EMPTYSTR;
	private String resultMessage = commonCode.EMPTYSTR;
	private String content = commonCode.EMPTYSTR;

	public String getResultCode ( ) {
		return resultCode;
	}

	public void setResultCode ( String resultCode ) {
		this.resultCode = resultCode;
	}

	public String getResultMessage ( ) {
		return resultMessage;
	}

	public void setResultMessage ( String resultMessage ) {
		this.resultMessage = resultMessage;
	}

	public String getContent ( ) {
		return content;
	}

	public void setContent ( String content ) {
		this.content = content;
	}
}
