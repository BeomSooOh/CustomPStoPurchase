/**
  * @FileName : AnguAbdocuVO.java
  * @Project : BizboxA_exp
  * @변경이력 :
  * @프로그램 설명 :
  */
package common.vo.angu;

import common.helper.convert.CommonConvert;

/**
 *   * @FileName : AnguAbdocuVO.java
 *   * @Project : BizboxA_exp
 *   * @변경이력 :
 *   * @프로그램 설명 :
 *   
 */
public class AnguAbdocuVO {

	private String compSeq; /* 귀속 회사 시퀀스 */
	private String anbojoSeq; /* 국고보조 시퀀스 */
	private String docSeq; /* 전자결재 아이디 */
	private String formSeq; /* 양시 시퀀스 */
	private String anbojoStatCode; /* 국고보조 상태 코드 */
	private String gisuDate; /* 결의일자 ( 회계일자 ) */
	private String writeSeq; /* 작성자 정보 */
	private String jsonStr; /* 국고보조 JSON 문자열 */
	private String erpSendYN; /* 국고보조 ERP 전송 여부 */
	private String erpSendSeq; /* 국고보조 ERP 전송자 */
	private String erpSendDate; /* 국고보조 ERP 전송일 */
	private String createSeq; /* 최초 작성자 */
	private String createDate; /* 최초 작성일 */
	private String modifySeq; /* 최종 수정자 */
	private String modifyDate; /* 최종 수정일 */

	public String getCompSeq ( ) {
		return CommonConvert.CommonGetStr(compSeq);
	}

	public void setCompSeq ( String compSeq ) {
		this.compSeq = compSeq;
	}

	public String getAnbojoSeq ( ) {
		return CommonConvert.CommonGetStr(anbojoSeq);
	}

	public void setAnbojoSeq ( String anbojoSeq ) {
		this.anbojoSeq = anbojoSeq;
	}

	public String getDocSeq ( ) {
		return CommonConvert.CommonGetStr(docSeq);
	}

	public void setDocSeq ( String docSeq ) {
		this.docSeq = docSeq;
	}

	public String getFormSeq ( ) {
		return CommonConvert.CommonGetStr(formSeq);
	}

	public void setFormSeq ( String formSeq ) {
		this.formSeq = formSeq;
	}

	public String getAnbojoStatCode ( ) {
		return CommonConvert.CommonGetStr(anbojoStatCode);
	}

	public void setAnbojoStatCode ( String anbojoStatCode ) {
		this.anbojoStatCode = anbojoStatCode;
	}

	public String getGisuDate ( ) {
		return CommonConvert.CommonGetStr(gisuDate);
	}

	public void setGisuDate ( String gisuDate ) {
		this.gisuDate = gisuDate;
	}

	public String getWriteSeq ( ) {
		return CommonConvert.CommonGetStr(writeSeq);
	}

	public void setWriteSeq ( String writeSeq ) {
		this.writeSeq = writeSeq;
	}

	public String getJsonStr ( ) {
		return CommonConvert.CommonGetStr(jsonStr);
	}

	public void setJsonStr ( String jsonStr ) {
		this.jsonStr = jsonStr;
	}

	public String getErpSendYN ( ) {
		return CommonConvert.CommonGetStr(erpSendYN);
	}

	public void setErpSendYN ( String erpSendYN ) {
		this.erpSendYN = erpSendYN;
	}

	public String getErpSendSeq ( ) {
		return CommonConvert.CommonGetStr(erpSendSeq);
	}

	public void setErpSendSeq ( String erpSendSeq ) {
		this.erpSendSeq = erpSendSeq;
	}

	public String getErpSendDate ( ) {
		return CommonConvert.CommonGetStr(erpSendDate);
	}

	public void setErpSendDate ( String erpSendDate ) {
		this.erpSendDate = erpSendDate;
	}

	public String getCreateSeq ( ) {
		return CommonConvert.CommonGetStr(createSeq);
	}

	public void setCreateSeq ( String createSeq ) {
		this.createSeq = createSeq;
	}

	public String getCreateDate ( ) {
		return CommonConvert.CommonGetStr(createDate);
	}

	public void setCreateDate ( String createDate ) {
		this.createDate = createDate;
	}

	public String getModifySeq ( ) {
		return CommonConvert.CommonGetStr(modifySeq);
	}

	public void setModifySeq ( String modifySeq ) {
		this.modifySeq = modifySeq;
	}

	public String getModifyDate ( ) {
		return CommonConvert.CommonGetStr(modifyDate);
	}

	public void setModifyDate ( String modifyDate ) {
		this.modifyDate = modifyDate;
	}

	@Override
	public String toString ( ) {
		return "AnguAbdocuVO [compSeq=" + compSeq + ", anbojoSeq=" + anbojoSeq + ", docSeq=" + docSeq + ", formSeq=" + formSeq + ", anbojoStatCode=" + anbojoStatCode + ", gisuDate=" + gisuDate + ", writeSeq=" + writeSeq + ", jsonStr=" + jsonStr + ", erpSendYN=" + erpSendYN + ", erpSendSeq=" + erpSendSeq + ", erpSendDate=" + erpSendDate + ", createSeq=" + createSeq + ", createDate=" + createDate + ", modifySeq=" + modifySeq + ", modifyDate=" + modifyDate + "]";
	}
}
