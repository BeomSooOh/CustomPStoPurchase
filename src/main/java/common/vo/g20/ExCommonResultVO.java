package common.vo.g20;

import java.util.HashMap;
import java.util.Map;

import common.vo.common.CommonInterface.commonCode;


public class ExCommonResultVO {

	private String common_code = commonCode.EMPTYSTR; /* 공통코드 */
	private String common_name = commonCode.EMPTYSTR; /* 공통명칭 */
	private String comp_seq = commonCode.EMPTYSTR; /* 회사 시퀀스 */
	private String erp_comp_seq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String lang_code = commonCode.EMPTYSTR; /* 사용언어 코드 */
	private String search_str = commonCode.EMPTYSTR; /* 검색어 */
	private String search_type = commonCode.EMPTYSTR; /* 검색구분 */
	private String expend_seq = commonCode.EMPTYSEQ; /* 지출결의 시퀀스 */
	private String list_seq = commonCode.EMPTYSEQ; /* 지출결의 항목 시퀀스 */
	private String slip_seq = commonCode.EMPTYSEQ; /* 지출결의 항목 분개 시퀀스 */
	private String mng_seq = commonCode.EMPTYSEQ; /* 지출결의 항목 분개 관리항목 시퀀스 */
	private String code = commonCode.EMPTYSTR; /* 코드 */
	private String message = commonCode.EMPTYSTR; /* 메시지 */
	private String error = commonCode.EMPTYSTR; /* 에러메시지 */
	private String validate_code = commonCode.EMPTYSTR; /* 오류대상 코드 */
	private String validate_stat = commonCode.EMPTYSTR; /* 오류 여부 */
	private Map<String, Object> map = new HashMap<String, Object>( );

	public String getCommon_code ( ) {
		return common_code;
	}

	public void setCommon_code ( String commonCode ) {
		this.common_code = commonCode;
	}

	public String getCommon_name ( ) {
		return common_name;
	}

	public void setCommon_name ( String commonName ) {
		this.common_name = commonName;
	}

	public String getComp_seq ( ) {
		return comp_seq;
	}

	public void setComp_seq ( String compSeq ) {
		this.comp_seq = compSeq;
	}

	public String getErp_comp_seq ( ) {
		return erp_comp_seq;
	}

	public void setErp_comp_seq ( String erpCompSeq ) {
		this.erp_comp_seq = erpCompSeq;
	}

	public String getLang_code ( ) {
		return lang_code;
	}

	public void setLang_code ( String langCode ) {
		this.lang_code = langCode;
	}

	public String getSearch_str ( ) {
		return search_str;
	}

	public void setSearch_str ( String searchStr ) {
		this.search_str = searchStr;
	}

	public String getSearch_type ( ) {
		return search_type;
	}

	public void setSearch_type ( String searchType ) {
		this.search_type = searchType;
	}

	public String getExpend_seq ( ) {
		return expend_seq;
	}

	public void setExpend_seq ( String expendSeq ) {
		this.expend_seq = expendSeq;
	}

	public String getList_seq ( ) {
		return list_seq;
	}

	public void setList_seq ( String listSeq ) {
		this.list_seq = listSeq;
	}

	public String getSlip_seq ( ) {
		return slip_seq;
	}

	public void setSlip_seq ( String slipSeq ) {
		this.slip_seq = slipSeq;
	}

	public String getMng_seq ( ) {
		return mng_seq;
	}

	public void setMng_seq ( String mngSeq ) {
		this.mng_seq = mngSeq;
	}

	public String getCode ( ) {
		return code;
	}

	public void setCode ( String code ) {
		this.code = code;
	}

	public String getMessage ( ) {
		return message;
	}

	public void setMessage ( String message ) {
		this.message = message;
	}

	public String getError ( ) {
		return error;
	}

	public void setError ( String error ) {
		this.error = error;
	}

	public Map<String, Object> getMap ( ) {
		return map;
	}

	public void setMap ( Map<String, Object> map ) {
		this.map = map;
	}

	public String getValidate_code ( ) {
		return validate_code;
	}

	public void setValidate_code ( String validateCode ) {
		this.validate_code = validateCode;
	}

	public String getValidate_stat ( ) {
		return validate_stat;
	}

	public void setValidate_stat ( String validateStat ) {
		this.validate_stat = validateStat;
	}

	@Override
	public String toString ( ) {
		return "ExCommonResultVO [common_code=" + common_code + ", common_name=" + common_name + ", comp_seq=" + comp_seq + ", erp_comp_seq=" + erp_comp_seq + ", lang_code=" + lang_code + ", search_str=" + search_str + ", search_type=" + search_type + ", expend_seq=" + expend_seq + ", listS_eq=" + list_seq + ", slip_seq=" + slip_seq + ", mng_seq=" + mng_seq + ", code=" + code + ", message=" + message + ", error=" + error + ", validate_code=" + validate_code + ", validate_stat=" + validate_stat + ", map=" + map + "]";
	}
}
