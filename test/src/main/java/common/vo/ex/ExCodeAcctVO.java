package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExCodeAcctVO {

	// CommonEX >> var ExCodeAcct 동일
	private String comp_seq = commonCode.EMPTYSTR; /* 회사코드 */
	private String erp_comp_seq = commonCode.EMPTYSTR; /* ERP 회사코드 */
	private String acct_code = commonCode.EMPTYSTR; /* 계정과목코드 */
	private String acct_name = commonCode.EMPTYSTR; /* 계정과목명칭 */
	private String vat_yn = commonCode.EMPTYSTR; /* 부가세구분 */
	private String use_yn = commonCode.EMPTYSTR; /* 사용여부 */
	private String form_seq = commonCode.EMPTYSEQ; /* 양식아이디 */
	private String search_type = commonCode.EMPTYSTR; /* 계정과목 검색 조건 */
	private String search_str = commonCode.EMPTYSTR; /* 검색어 */
	private String callback = commonCode.EMPTYSTR; /* 콜백 */
	private String create_seq = commonCode.EMPTYSTR; /* 최초작성자 */
	private String modify_seq = commonCode.EMPTYSTR; /* 최종수정자 */

	public String getComp_seq ( ) {
		return CommonConvert.CommonGetStr(comp_seq);
	}

	public void setComp_seq ( String compSeq ) {
		this.comp_seq = compSeq;
	}

	public String getErp_comp_seq ( ) {
		return CommonConvert.CommonGetStr(erp_comp_seq);
	}

	public void setErp_comp_seq ( String erpCompSeq ) {
		this.erp_comp_seq = erpCompSeq;
	}

	public String getAcct_code ( ) {
		return CommonConvert.CommonGetStr(acct_code);
	}

	public void setAcct_code ( String acctCode ) {
		this.acct_code = acctCode;
	}

	public String getAcct_name ( ) {
		return CommonConvert.CommonGetStr(acct_name);
	}

	public void setAcct_name ( String acctName ) {
		this.acct_name = acctName;
	}

	public String getVat_yn ( ) {
		return CommonConvert.CommonGetStr(vat_yn);
	}

	public void setVat_yn ( String vatYn ) {
		this.vat_yn = vatYn;
	}

	public String getUse_yn ( ) {
		return CommonConvert.CommonGetStr(use_yn);
	}

	public void setUse_yn ( String useYn ) {
		this.use_yn = useYn;
	}

	public String getForm_seq ( ) {
		return CommonConvert.CommonGetStr(form_seq);
	}

	public void setForm_seq ( String formSeq ) {
		this.form_seq = formSeq;
	}

	public String getSearch_type ( ) {
		return CommonConvert.CommonGetStr(search_type);
	}

	public void setSearch_type ( String searchType ) {
		this.search_type = searchType;
	}

	public String getSearch_str ( ) {
		return CommonConvert.CommonGetStr(search_str);
	}

	public void setSearch_str ( String searchStr ) {
		this.search_str = searchStr;
	}

	public String getCallback ( ) {
		return CommonConvert.CommonGetStr(callback);
	}

	public void setCallback ( String callback ) {
		this.callback = callback;
	}

	public String getCreate_seq ( ) {
		return CommonConvert.CommonGetStr(create_seq);
	}

	public void setCreate_seq ( String createSeq ) {
		this.create_seq = createSeq;
	}

	public String getModify_seq ( ) {
		return CommonConvert.CommonGetStr(modify_seq);
	}

	public void setModify_seq ( String modifySeq ) {
		this.modify_seq = modifySeq;
	}

	@Override
	public String toString ( ) {
		return "ExCodeAcctVO [comp_seq=" + comp_seq + ", erp_comp_seq=" + erp_comp_seq + ", acct_code=" + acct_code + ", acct_name=" + acct_name + ", vat_yn=" + vat_yn + ", use_yn=" + use_yn + ", form_seq=" + form_seq + ", search_type=" + search_type + ", search_str=" + search_str + ", callback=" + callback + ", create_seq=" + create_seq + ", modify_seq=" + modify_seq + "]";
	}
}
