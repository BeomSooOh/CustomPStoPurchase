/**
  * @FileName : CloudCommonVO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.vo.common;

import common.helper.convert.CommonConvert;

/**
 *   * @FileName : CloudCommonVO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class CloudCommonVO {

	private String groupSeq = "";
	private String DB_NEOS = "";
	private String DB_MOBILE = "";
	private String DB_EDMS = "";

	public String getGroupSeq ( ) {
		return CommonConvert.CommonGetStr(groupSeq);
	}

	public void setGroupSeq ( String groupSeq ) {
		this.groupSeq = groupSeq;
	}

	public String getDB_NEOS ( ) {
		return CommonConvert.CommonGetStr(DB_NEOS);
	}

	public void setDB_NEOS ( String dbNeos ) {
		DB_NEOS = dbNeos;
	}

	public String getDB_MOBILE ( ) {
		return CommonConvert.CommonGetStr(DB_MOBILE);
	}

	public void setDB_MOBILE ( String dbMobile ) {
		DB_MOBILE = dbMobile;
	}

	public String getDB_EDMS ( ) {
		return CommonConvert.CommonGetStr(DB_EDMS);
	}

	public void setDB_EDMS ( String dbEdms ) {
		DB_EDMS = dbEdms;
	}
}
