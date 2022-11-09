package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExCodeMngVO {

	private String compSeq = commonCode.EMPTYSEQ; /* 회사 시퀀스 */
	private String erpCompSeq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String formSeq = commonCode.EMPTYSEQ; /* 양식 시퀀스 */
	private String mngCode = commonCode.EMPTYSTR; /* 관리항목 코드 */
	private String mngName = commonCode.EMPTYSTR; /* 관리항목 명칭 */
	private String ctdCode = commonCode.EMPTYSTR; /* 관리항목 입력 코드 */
	private String ctdName = commonCode.EMPTYSTR; /* 관리항목 입력 명칭 */
	private String note = commonCode.EMPTYSTR; /* 비고 */
	private String mngType = commonCode.EMPTYSTR; /* 관리항목 코드 그룹 */
	private String mngChildYN = commonCode.EMPTYSTR; /* 관리항목 하위코드 존재여부 */
	private String mngForm = commonCode.EMPTYSTR; /* 관리항목 입력 형식 */
	private String drcrGbn = commonCode.EMPTYSTR; /* 차대구분 */
	private String useGbn = commonCode.EMPTYSTR; /* 사용자정의 타입 */
	private String useGbnName = commonCode.EMPTYSTR; /* 사용자정의 타입 명칭 */
	private String custSet = commonCode.EMPTYSTR; /* 커스터마이징 구분 ( 프로시저, 쿼리 ) */
	private String custSetTarget = commonCode.EMPTYSTR; /* 프로시저, 쿼리 구동 대상 */
	private String modifyYN = commonCode.EMPTYYES; /*수정가능여부 ( 전용개발인 경우, 사용자에 의해 수정 및 삭제가 진행되면 안되기 때문 ) */
	private String createSeq = commonCode.EMPTYSEQ; /* 생성자 */
	private String modifySeq = commonCode.EMPTYSEQ; /* 수정자 */
	private String searchStr = commonCode.EMPTYSTR; /* 검색어 */
	
	public String getCompSeq ( ) {
		return CommonConvert.CommonGetStr(compSeq);
	}
	
	public void setCompSeq ( String compSeq ) {
		this.compSeq = compSeq;
	}
	
	public String getErpCompSeq ( ) {
		return CommonConvert.CommonGetStr(erpCompSeq);
	}
	
	public void setErpCompSeq ( String erpCompSeq ) {
		this.erpCompSeq = erpCompSeq;
	}
	
	public String getFormSeq ( ) {
		return CommonConvert.CommonGetStr(formSeq);
	}
	
	public void setFormSeq ( String formSeq ) {
		this.formSeq = formSeq;
	}
	
	public String getMngCode ( ) {
		return CommonConvert.CommonGetStr(mngCode);
	}
	
	public void setMngCode ( String mngCode ) {
		this.mngCode = mngCode;
	}
	
	public String getMngName ( ) {
		return CommonConvert.CommonGetStr(mngName);
	}
	
	public void setMngName ( String mngName ) {
		this.mngName = mngName;
	}
	
	public String getCtdCode ( ) {
		return CommonConvert.CommonGetStr(ctdCode);
	}
	
	public void setCtdCode ( String ctdCode ) {
		this.ctdCode = ctdCode;
	}
	
	public String getCtdName ( ) {
		return CommonConvert.CommonGetStr(ctdName);
	}
	
	public void setCtdName ( String ctdName ) {
		this.ctdName = ctdName;
	}
	
	public String getNote ( ) {
		return CommonConvert.CommonGetStr(note);
	}
	
	public void setNote ( String note ) {
		this.note = note;
	}
	
	public String getMngType ( ) {
		return CommonConvert.CommonGetStr(mngType);
	}
	
	public void setMngType ( String mngType ) {
		this.mngType = mngType;
	}
	
	public String getMngChildYN ( ) {
		return CommonConvert.CommonGetStr(mngChildYN);
	}
	
	public void setMngChildYN ( String mngChildYN ) {
		this.mngChildYN = mngChildYN;
	}
	
	public String getMngForm ( ) {
		return CommonConvert.CommonGetStr(mngForm);
	}
	
	public void setMngForm ( String mngForm ) {
		this.mngForm = mngForm;
	}
	
	public String getDrcrGbn ( ) {
		return CommonConvert.CommonGetStr(drcrGbn);
	}
	
	public void setDrcrGbn ( String drcrGbn ) {
		this.drcrGbn = drcrGbn;
	}
	
	public String getUseGbn ( ) {
		return CommonConvert.CommonGetStr(useGbn);
	}
	
	public void setUseGbn ( String useGbn ) {
		this.useGbn = useGbn;
	}
	
	public String getUseGbnName ( ) {
		return CommonConvert.CommonGetStr(useGbnName);
	}
	
	public void setUseGbnName ( String useGbnName ) {
		this.useGbnName = useGbnName;
	}
	
	public String getCustSet ( ) {
		return CommonConvert.CommonGetStr(custSet);
	}
	
	public void setCustSet ( String custSet ) {
		this.custSet = custSet;
	}
	
	public String getCustSetTarget ( ) {
		return CommonConvert.CommonGetStr(custSetTarget);
	}
	
	public void setCustSetTarget ( String custSetTarget ) {
		this.custSetTarget = custSetTarget;
	}
	
	public String getModifyYN ( ) {
		return CommonConvert.CommonGetStr(modifyYN);
	}
	
	public void setModifyYN ( String modifyYN ) {
		this.modifyYN = modifyYN;
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

	@Override
	public String toString ( ) {
		return "ExCodeMngVO [compSeq=" + compSeq + ", erpCompSeq=" + erpCompSeq + ", formSeq=" + formSeq + ", mngCode=" + mngCode + ", mngName=" + mngName + ", ctdCode=" + ctdCode + ", ctdName=" + ctdName + ", note=" + note + ", mngType=" + mngType + ", mngChildYN=" + mngChildYN + ", mngForm=" + mngForm + ", drcrGbn=" + drcrGbn + ", useGbn=" + useGbn + ", useGbnName=" + useGbnName + ", custSet=" + custSet + ", custSetTarget=" + custSetTarget + ", modifyYN=" + modifyYN + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + ", searchStr=" + searchStr + "]";
	}

}