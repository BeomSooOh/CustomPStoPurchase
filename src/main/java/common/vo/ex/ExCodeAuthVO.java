package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExCodeAuthVO {

	private int seq = 0; /* 시퀀스 */
	private String compSeq = commonCode.EMPTYSTR; /* 회사 시퀀스 */
	private String erpCompseq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String authDiv = commonCode.EMPTYSTR; /* 증빙유형 구분 ( A : 매입 / B : 매출 ) */
	private String authCode = commonCode.EMPTYSTR; /* 증빙유형 코드 */
	private String authName = commonCode.EMPTYSTR; /* 증빙유형 명칭 */
	private String cashType = commonCode.EMPTYSTR; /* 현금영수증 구분 */
	private String crAcctCode = commonCode.EMPTYSTR; /* 차변 계정과목 코드 */
	private String crAcctName = commonCode.EMPTYSTR; /* 차변 계정괌고 명칭 */
	private String vatAcctCode = commonCode.EMPTYSTR; /* 부가세 계정과목 코드 */
	private String vatAcctName = commonCode.EMPTYSTR; /* 부가세 계정과목 명칭 */
	private String vatTypeCode = commonCode.EMPTYSTR; /* 부가세 구분 코드 ( 세무구분 코드 ) */
	private String vatTypeName = commonCode.EMPTYSTR; /* 부가세 구분 명칭 ( 세무구분 명칭 ) */
	private String erpAuthCode = commonCode.EMPTYSTR; /* ERP 증빙 코드 */
	private String erpAuthName = commonCode.EMPTYSTR; /* ERP 증빙 명칭 */
	private String authRequiredYN = commonCode.EMPTYNO; /* 증빙일자 필수입력 여부 */
	private String partnerRequiredYN = commonCode.EMPTYNO; /* 거래처 필수입력 여부 */
	private String cardRequiredYN = commonCode.EMPTYNO; /* 카드 필수입력 여부 */
	private String projectRequiredYN = commonCode.EMPTYNO; /* 프로젝트 필수입력 여부 */
	private String noteRequiredYN = commonCode.EMPTYNO; /* 적요 필수입력 여부 */
	private String noTaxCode = commonCode.EMPTYSTR; /* 불공제구분 코드 */
	private String noTaxName = commonCode.EMPTYSTR; /* 불공제구분 명칭 */
	private String orderNum = commonCode.EMPTYSTR; /* 정렬 순서 */
	private String useYN = commonCode.EMPTYYES; /* 사용여부 */
	private String vaTypeCode = commonCode.EMPTYSTR; /* 사유구분 코드 */
	private String vaTypeName = commonCode.EMPTYSTR; /* 사유구분 명칭 */
	private String etaxSendYN = commonCode.EMPTYSTR; /* 국세청전송 15일 이내 여부 */
	private String etaxYN = commonCode.EMPTYSTR; /* 전자세금계산서 여부 */
	private String createSeq = commonCode.EMPTYSTR; /* 생성자 */
	private String modifySeq = commonCode.EMPTYSTR; /* 수정자 */
	private String searchStr = commonCode.EMPTYSTR; /* 검색어 */
	private String formSeq = commonCode.EMPTYSTR; /* 양식 시퀀스 */
	private String callback = commonCode.EMPTYSTR; /* 콜백 */
	private String groupSeq = commonCode.EMPTYSTR; /* 그룹 시퀀스 */
	private String noCash = commonCode.EMPTYSTR; /* ERPiU 현금승인번호 */

	public String getGroupSeq ( ) {
		return CommonConvert.CommonGetStr(groupSeq);
	}

	public void setGroupSeq ( String groupSeq ) {
		this.groupSeq = groupSeq;
	}

	public int getSeq ( ) {
		return seq;
	}

	public void setSeq ( int seq ) {
		this.seq = seq;
	}

	public String getCompSeq ( ) {
		return CommonConvert.CommonGetStr(compSeq);
	}

	public void setCompSeq ( String compSeq ) {
		this.compSeq = compSeq;
	}

	public String getErpCompseq ( ) {
		return CommonConvert.CommonGetStr(erpCompseq);
	}

	public void setErpCompseq ( String erpCompseq ) {
		this.erpCompseq = erpCompseq;
	}

	public String getAuthDiv ( ) {
		return CommonConvert.CommonGetStr(authDiv);
	}

	public void setAuthDiv ( String authDiv ) {
		this.authDiv = authDiv;
	}

	public String getAuthCode ( ) {
		return CommonConvert.CommonGetStr(authCode);
	}

	public void setAuthCode ( String authCode ) {
		this.authCode = authCode;
	}

	public String getAuthName ( ) {
		return CommonConvert.CommonGetStr(authName);
	}

	public void setAuthName ( String authName ) {
		this.authName = authName;
	}

	public String getCashType ( ) {
		return CommonConvert.CommonGetStr(cashType);
	}

	public void setCashType ( String cashType ) {
		this.cashType = cashType;
	}

	public String getCrAcctCode ( ) {
		return CommonConvert.CommonGetStr(crAcctCode);
	}

	public void setCrAcctCode ( String crAcctCode ) {
		this.crAcctCode = crAcctCode;
	}

	public String getCrAcctName ( ) {
		return CommonConvert.CommonGetStr(crAcctName);
	}

	public void setCrAcctName ( String crAcctName ) {
		this.crAcctName = crAcctName;
	}

	public String getVatAcctCode ( ) {
		return CommonConvert.CommonGetStr(vatAcctCode);
	}

	public void setVatAcctCode ( String vatAcctCode ) {
		this.vatAcctCode = vatAcctCode;
	}

	public String getVatAcctName ( ) {
		return CommonConvert.CommonGetStr(vatAcctName);
	}

	public void setVatAcctName ( String vatAcctName ) {
		this.vatAcctName = vatAcctName;
	}

	public String getVatTypeCode ( ) {
		return CommonConvert.CommonGetStr(vatTypeCode);
	}

	public void setVatTypeCode ( String vatTypeCode ) {
		this.vatTypeCode = vatTypeCode;
	}

	public String getVatTypeName ( ) {
		return CommonConvert.CommonGetStr(vatTypeName);
	}

	public void setVatTypeName ( String vatTypeName ) {
		this.vatTypeName = vatTypeName;
	}

	public String getErpAuthCode ( ) {
		return CommonConvert.CommonGetStr(erpAuthCode);
	}

	public void setErpAuthCode ( String erpAuthCode ) {
		this.erpAuthCode = erpAuthCode;
	}

	public String getErpAuthName ( ) {
		return CommonConvert.CommonGetStr(erpAuthName);
	}

	public void setErpAuthName ( String erpAuthName ) {
		this.erpAuthName = erpAuthName;
	}

	public String getAuthRequiredYN ( ) {
		return CommonConvert.CommonGetStr(authRequiredYN);
	}

	public void setAuthRequiredYN ( String authRequiredYN ) {
		this.authRequiredYN = authRequiredYN;
	}

	public String getPartnerRequiredYN ( ) {
		return CommonConvert.CommonGetStr(partnerRequiredYN);
	}

	public void setPartnerRequiredYN ( String partnerRequiredYN ) {
		this.partnerRequiredYN = partnerRequiredYN;
	}

	public String getCardRequiredYN ( ) {
		return CommonConvert.CommonGetStr(cardRequiredYN);
	}

	public void setCardRequiredYN ( String cardRequiredYN ) {
		this.cardRequiredYN = cardRequiredYN;
	}

	public String getProjectRequiredYN ( ) {
		return CommonConvert.CommonGetStr(projectRequiredYN);
	}

	public void setProjectRequiredYN ( String projectRequiredYN ) {
		this.projectRequiredYN = projectRequiredYN;
	}

	public String getNoteRequiredYN ( ) {
		return CommonConvert.CommonGetStr(noteRequiredYN);
	}

	public void setNoteRequiredYN ( String noteRequiredYN ) {
		this.noteRequiredYN = noteRequiredYN;
	}

	public String getNoTaxCode ( ) {
		return CommonConvert.CommonGetStr(noTaxCode);
	}

	public void setNoTaxCode ( String noTaxCode ) {
		this.noTaxCode = noTaxCode;
	}

	public String getNoTaxName ( ) {
		return CommonConvert.CommonGetStr(noTaxName);
	}

	public void setNoTaxName ( String noTaxName ) {
		this.noTaxName = noTaxName;
	}

	public String getOrderNum ( ) {
		return CommonConvert.CommonGetStr(orderNum);
	}

	public void setOrderNum ( String orderNum ) {
		this.orderNum = orderNum;
	}

	public String getUseYN ( ) {
		return CommonConvert.CommonGetStr(useYN);
	}

	public void setUseYN ( String useYN ) {
		this.useYN = useYN;
	}

	public String getVaTypeCode ( ) {
		return CommonConvert.CommonGetStr(vaTypeCode);
	}

	public void setVaTypeCode ( String vaTypeCode ) {
		this.vaTypeCode = vaTypeCode;
	}

	public String getVaTypeName ( ) {
		return CommonConvert.CommonGetStr(vaTypeName);
	}

	public void setVaTypeName ( String vaTypeName ) {
		this.vaTypeName = vaTypeName;
	}

	public String getEtaxSendYN ( ) {
		return CommonConvert.CommonGetStr(etaxSendYN);
	}

	public void setEtaxSendYN ( String etaxSendYN ) {
		this.etaxSendYN = etaxSendYN;
	}

	public String getEtaxYN ( ) {
		return CommonConvert.CommonGetStr(etaxYN);
	}

	public void setEtaxYN ( String etaxYN ) {
		this.etaxYN = etaxYN;
	}

	public String getCreateSeq ( ) {
		return CommonConvert.CommonGetStr(createSeq);
	}

	public void setCreateSeq ( String createSeq ) {
		this.createSeq = createSeq;
	}

	public String getModifySeq ( ) {
		return CommonConvert.CommonGetStr(modifySeq);
	}

	public void setModifySeq ( String modifySeq ) {
		this.modifySeq = modifySeq;
	}

	public String getSearchStr ( ) {
		return CommonConvert.CommonGetStr(searchStr);
	}

	public void setSearchStr ( String searchStr ) {
		this.searchStr = searchStr;
	}

	public String getFormSeq ( ) {
		return CommonConvert.CommonGetStr(formSeq);
	}

	public void setFormSeq ( String formSeq ) {
		this.formSeq = formSeq;
	}

	public String getCallback ( ) {
		return CommonConvert.CommonGetStr(callback);
	}

	public void setCallback ( String callback ) {
		this.callback = callback;
	}
	
	public String getNoCash ( ) {
		return CommonConvert.CommonGetStr(noCash);
	}

	
	public void setNoCash ( String noCash ) {
		this.noCash = noCash;
	}

	@Override
	public String toString ( ) {
		return "ExCodeAuthVO [seq=" + seq + ", compSeq=" + compSeq + ", erpCompseq=" + erpCompseq + ", authDiv=" + authDiv + ", authCode=" + authCode + ", authName=" + authName + ", cashType=" + cashType + ", crAcctCode=" + crAcctCode + ", crAcctName=" + crAcctName + ", vatAcctCode=" + vatAcctCode + ", vatAcctName=" + vatAcctName + ", vatTypeCode=" + vatTypeCode + ", vatTypeName=" + vatTypeName + ", erpAuthCode=" + erpAuthCode + ", erpAuthName=" + erpAuthName + ", authRequiredYN=" + authRequiredYN + ", partnerRequiredYN=" + partnerRequiredYN + ", cardRequiredYN=" + cardRequiredYN + ", projectRequiredYN=" + projectRequiredYN + ", noteRequiredYN=" + noteRequiredYN + ", noTaxCode=" + noTaxCode + ", noTaxName=" + noTaxName + ", orderNum=" + orderNum + ", useYN=" + useYN + ", vaTypeCode=" + vaTypeCode + ", vaTypeName=" + vaTypeName + ", etaxSendYN=" + etaxSendYN + ", etaxYN=" + etaxYN + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + ", searchStr=" + searchStr + ", formSeq="
				+ formSeq + ", callback=" + callback + ", groupSeq=" + groupSeq + ", noCash=" + noCash + "]";
	}
}
