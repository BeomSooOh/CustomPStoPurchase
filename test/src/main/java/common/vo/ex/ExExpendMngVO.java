package common.vo.ex;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExExpendMngVO {

	private String groupSeq = commonCode.EMPTYSTR; /* 그룹 시퀀스 */
	private String compSeq = commonCode.EMPTYSTR; /* 회사 시퀀스 */
	private String erpCompSeq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String expendSeq = commonCode.EMPTYSEQ; /* 지출결의 시퀀스 */
	private String listSeq = commonCode.EMPTYSEQ; /* 지출결의 항목 시퀀스 */
	private String slipSeq = commonCode.EMPTYSEQ; /* 지출결의 항목 분개 시퀀스 */
	private String mngSeq = commonCode.EMPTYSEQ; /* 지출결의 항목 분개 관리항목 시퀀스 */
	private String acctCode = commonCode.EMPTYSTR; /* 계정과목 코드 */
	private String acctName = commonCode.EMPTYSTR; /* 계정과목 명칭 */
	private String mngCode = commonCode.EMPTYSTR; /* 관리항목 코드 */
	private String mngName = commonCode.EMPTYSTR; /* 관리항목 명칭 */
	private String mngFormCode = commonCode.EMPTYSTR; /* 관리항목 입력 형태 */
	private String mngChildYN = commonCode.EMPTYSTR; /* 관리항목 하위코드 여부 */
	private String mngStat = commonCode.EMPTYSTR; /* 관리항목 필수값 여부 */
	private String ctdCode = commonCode.EMPTYSTR; /* 관리항목 선택 내역 ( 입력 내역 ) 코드 */
	private String ctdName = commonCode.EMPTYSTR; /* 관리항목 선택 내역 ( 입력 내역 ) 명칭 */
	private String jsonStr = commonCode.EMPTYSTR;
	private String formSeq = commonCode.EMPTYSEQ; /* 양식 시퀀스 */
	private String searchStr = commonCode.EMPTYSTR; /* 검색어 */
	private String callback = commonCode.EMPTYSTR; /* 콜백 */
	private String createSeq = commonCode.EMPTYSEQ; /* 생성자 */
	private String modifySeq = commonCode.EMPTYSEQ; /* 수정자 */
	private String realMngCode = commonCode.EMPTYSEQ; /* 연동 관리항목 코드 */
	private String realMngName = commonCode.EMPTYSEQ; /* 연동 관리항목 명칭 */
	private String subDummy1 = commonCode.EMPNAME; /* 관리항목 추가 정보 */ /* 거래처 : 사업자 등록 번호 */ /* 사유구분 : iCUBE 세무구분 */
	private String subDummy2 = commonCode.EMPNAME; /* 관리항목 추가 정보 */
	private String subDummy3 = commonCode.EMPNAME; /* 관리항목 추가 정보 */
	private String subDummy4 = commonCode.EMPNAME; /* 관리항목 추가 정보 */
	private String subDummy5 = commonCode.EMPNAME; /* 관리항목 추가 정보 */
	
	private List<Map<String, Object>> result = new ArrayList<Map<String, Object>>(); /* oracle 프로시저 결과값 */

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

	public String getAcctCode ( ) {
		return CommonConvert.CommonGetStr(acctCode);
	}

	public void setAcctCode ( String acctCode ) {
		this.acctCode = acctCode;
	}

	public String getAcctName ( ) {
		return CommonConvert.CommonGetStr(acctName);
	}

	public void setAcctName ( String acctName ) {
		this.acctName = acctName;
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

	public String getMngFormCode ( ) {
		return CommonConvert.CommonGetStr(mngFormCode);
	}

	public void setMngFormCode ( String mngFormCode ) {
		this.mngFormCode = mngFormCode;
	}

	public String getMngChildYN ( ) {
		return CommonConvert.CommonGetStr(mngChildYN);
	}

	public void setMngChildYN ( String mngChildYN ) {
		this.mngChildYN = mngChildYN;
	}

	public String getMngStat ( ) {
		return CommonConvert.CommonGetStr(mngStat);
	}

	public void setMngStat ( String mngStat ) {
		this.mngStat = mngStat;
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

	public String getJsonStr ( ) {
		return CommonConvert.CommonGetStr(jsonStr);
	}

	public void setJsonStr ( String jsonStr ) {
		this.jsonStr = jsonStr;
	}

	public String getFormSeq ( ) {
		return CommonConvert.CommonGetStr(formSeq);
	}

	public void setFormSeq ( String formSeq ) {
		this.formSeq = formSeq;
	}

	public String getSearchStr ( ) {
		return CommonConvert.CommonGetStr(searchStr);
	}

	public void setSearchStr ( String searchStr ) {
		this.searchStr = searchStr;
	}

	public String getCallback ( ) {
		return CommonConvert.CommonGetStr(callback);
	}

	public void setCallback ( String callback ) {
		this.callback = callback;
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

	public String getRealMngCode ( ) {
		return CommonConvert.CommonGetStr(realMngCode);
	}

	public void setRealMngCode ( String realMngCode ) {
		this.realMngCode = realMngCode;
	}

	public String getRealMngName ( ) {
		return CommonConvert.CommonGetStr(realMngName);
	}

	public void setRealMngName ( String realMngName ) {
		this.realMngName = realMngName;
	}

	public String getSubDummy1 ( ) {
		return CommonConvert.CommonGetStr(subDummy1);
	}

	public void setSubDummy1 ( String subDummy1 ) {
		this.subDummy1 = subDummy1;
	}

	public String getSubDummy2 ( ) {
		return CommonConvert.CommonGetStr(subDummy2);
	}

	public void setSubDummy2 ( String subDummy2 ) {
		this.subDummy2 = subDummy2;
	}

	public String getSubDummy3 ( ) {
		return CommonConvert.CommonGetStr(subDummy3);
	}

	public void setSubDummy3 ( String subDummy3 ) {
		this.subDummy3 = subDummy3;
	}

	public String getSubDummy4 ( ) {
		return CommonConvert.CommonGetStr(subDummy4);
	}

	public void setSubDummy4 ( String subDummy4 ) {
		this.subDummy4 = subDummy4;
	}

	public String getSubDummy5 ( ) {
		return CommonConvert.CommonGetStr(subDummy5);
	}

	public void setSubDummy5 ( String subDummy5 ) {
		this.subDummy5 = subDummy5;
	}
	
	public List<Map<String, Object>> getResult() {
		return result;
	}

	public void setResult(List<Map<String, Object>> result) {
		this.result = result;
	}

	@Override
	public String toString ( ) {
		return "ExExpendMngVO [groupSeq=" + groupSeq + ", compSeq=" + compSeq + ", erpCompSeq=" + erpCompSeq + ", expendSeq=" + expendSeq + ", listSeq=" + listSeq + ", slipSeq=" + slipSeq + ", mngSeq=" + mngSeq + ", acctCode=" + acctCode + ", acctName=" + acctName + ", mngCode=" + mngCode + ", mngName=" + mngName + ", mngFormCode=" + mngFormCode + ", mngChildYN=" + mngChildYN + ", mngStat=" + mngStat + ", ctdCode=" + ctdCode + ", ctdName=" + ctdName + ", jsonStr=" + jsonStr + ", formSeq=" + formSeq + ", searchStr=" + searchStr + ", callback=" + callback + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + ", realMngCode=" + realMngCode + ", realMngName=" + realMngName + ", subDummy1=" + subDummy1 + ", subDummy2=" + subDummy2 + ", subDummy3=" + subDummy3 + ", subDummy4=" + subDummy4 + ", subDummy5=" + subDummy5 + "]";
	}
}
