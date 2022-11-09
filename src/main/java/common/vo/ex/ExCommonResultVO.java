package common.vo.ex;

import java.util.HashMap;
import java.util.Map;

import common.helper.convert.CommonConvert;


public class ExCommonResultVO {

	private String commonCode = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 공통코드 */
	private String commonName = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 공통명칭 */
	private String groupSeq = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 그룹 시퀀스 */
	private String compSeq = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 회사 시퀀스 */
	private String erpCompSeq = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String langCode = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 사용언어 코드 */
	private String searchStr = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 검색어 */
	private String searchType = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 검색구분 */
	private String expendSeq = common.vo.common.CommonInterface.commonCode.EMPTYSEQ; /* 지출결의 시퀀스 */
	private String listSeq = common.vo.common.CommonInterface.commonCode.EMPTYSEQ; /* 지출결의 항목 시퀀스 */
	private String slipSeq = common.vo.common.CommonInterface.commonCode.EMPTYSEQ; /* 지출결의 항목 분개 시퀀스 */
	private String mngSeq = common.vo.common.CommonInterface.commonCode.EMPTYSEQ; /* 지출결의 항목 분개 관리항목 시퀀스 */
	private String mngCode = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 지출결의 항목 분개 관리항목 코드 */
	private String ctdCode = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 지출결의 항목 분개 사용자 입력 관리항목 코드 */
	private String ctdName = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 지출결의 항목 분개 사용자 입력 관리항목 명칭 */
	private String code = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 코드 */
	private String message = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 메시지 */
	private String error = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 에러메시지 */
	private String validateCode = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 오류대상 코드 */
	private String validateStat = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* 오류 여부 */
	private Map<String, Object> map = new HashMap<String, Object>( );
	private String seq = common.vo.common.CommonInterface.commonCode.EMPTYSTR; /* seq */
	
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

	public String getGroupSeq ( ) {
		return CommonConvert.CommonGetStr(groupSeq);
	}

	public void setGroupSeq ( String groupSeq ) {
		this.groupSeq = groupSeq;
	}

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

	public String getLangCode ( ) {
		return CommonConvert.CommonGetStr(langCode);
	}

	public void setLangCode ( String langCode ) {
		this.langCode = langCode;
	}

	public String getSearchStr ( ) {
		return CommonConvert.CommonGetStr(searchStr);
	}

	public void setSearchStr ( String searchStr ) {
		this.searchStr = searchStr;
	}

	public String getSearchType ( ) {
		return CommonConvert.CommonGetStr(searchType);
	}

	public void setSearchType ( String searchType ) {
		this.searchType = searchType;
	}

	public String getExpendSeq ( ) {
		return CommonConvert.CommonGetStr(expendSeq);
	}

	public void setExpendSeq ( String expendSeq ) {
		this.expendSeq = expendSeq;
	}

	public String getListSeq ( ) {
		return CommonConvert.CommonGetStr(listSeq);
	}

	public void setListSeq ( String listSeq ) {
		this.listSeq = listSeq;
	}

	public String getSlipSeq ( ) {
		return CommonConvert.CommonGetStr(slipSeq);
	}

	public void setSlipSeq ( String slipSeq ) {
		this.slipSeq = slipSeq;
	}

	public String getMngSeq ( ) {
		return CommonConvert.CommonGetStr(mngSeq);
	}

	public void setMngSeq ( String mngSeq ) {
		this.mngSeq = mngSeq;
	}

	public String getMngCode() {
		return mngCode;
	}

	public void setMngCode(String mngCode) {
		this.mngCode = mngCode;
	}

	public String getCtdCode() {
		return ctdCode;
	}

	public void setCtdCode(String ctdCode) {
		this.ctdCode = ctdCode;
	}

	public String getCtdName() {
		return ctdName;
	}

	public void setCtdName(String ctdName) {
		this.ctdName = ctdName;
	}

	public String getCode ( ) {
		return CommonConvert.CommonGetStr(code);
	}

	public void setCode ( String code ) {
		this.code = code;
	}

	public String getMessage ( ) {
		return CommonConvert.CommonGetStr(message);
	}

	public void setMessage ( String message ) {
		this.message = message;
	}

	public String getError ( ) {
		return CommonConvert.CommonGetStr(error);
	}

	public void setError ( String error ) {
		this.error = error;
	}

	public String getValidateCode ( ) {
		return CommonConvert.CommonGetStr(validateCode);
	}

	public void setValidateCode ( String validateCode ) {
		this.validateCode = validateCode;
	}

	public String getValidateStat ( ) {
		return CommonConvert.CommonGetStr(validateStat);
	}

	public void setValidateStat ( String validateStat ) {
		this.validateStat = validateStat;
	}

	public Map<String, Object> getMap ( ) {
		return map;
	}

	public void setMap ( Map<String, Object> map ) {
		this.map = map;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	@Override
	public String toString ( ) {
		return "ExCommonResultVO [commonCode=" + commonCode + ", commonName=" + commonName + ", groupSeq=" + groupSeq + ", compSeq=" + compSeq + ", erpCompSeq=" + erpCompSeq + ", langCode=" + langCode + ", searchStr=" + searchStr + ", searchType=" + searchType + ", expendSeq=" + expendSeq + ", listSeq=" + listSeq + ", slipSeq=" + slipSeq + ", mngSeq=" + mngSeq + ", mngCode=" + mngCode + ", ctdCode=" + ctdCode + ", ctdName=" + ctdName + ", code=" + code + ", message=" + message + ", error=" + error + ", validateCode=" + validateCode + ", validateStat=" + validateStat + ", map=" + map +", seq="+ seq +"]";
	}
}
