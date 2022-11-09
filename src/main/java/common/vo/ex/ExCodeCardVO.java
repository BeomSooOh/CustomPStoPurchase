package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;

public class ExCodeCardVO {

	private int seq = 0; /* 시퀀스 */
	private String compSeq = commonCode.EMPTYSTR; /* 회사코드 */
	private String empCompSeq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
	private String cardCode = commonCode.EMPTYSTR; /* 카드코드 */
	private String cardNum = commonCode.EMPTYSTR; /* 카드번호 */
	private String cardName = commonCode.EMPTYSTR; /* 카드명칭 */
	private String partnerCode = commonCode.EMPTYSTR; /* 금융거래처코드 */
	private String partnerName = commonCode.EMPTYSTR; /* 금융거래처명칭 */
	private String cardPublicJson = commonCode.EMPTYSTR; /* 공개범위 interface JSON 문자열 */
	private String cardPublic = commonCode.EMPTYSTR; /* 공개범위 입력 데이터 JSON Array 문자열 */
	private String useYN = commonCode.EMPTYYES; /* 사용여부 */
	private String erpCompSeq = commonCode.EMPTYSTR; /* ERP회사코드 */
	private String bankPartnerCode = commonCode.EMPTYSTR; /* ERPiU 금융거래처 코드 */
	private String bankPartnerName = commonCode.EMPTYSTR; /* ERPiU 금융거래처 명칭 */
	private String callback = commonCode.EMPTYSTR; /* 콜백 */
	private String formSeq = commonCode.EMPTYSEQ; /* 양식 시퀀스 */
	private String searchStr = commonCode.EMPTYSTR; /* 검색문자열 */
	private String searchType = commonCode.EMPTYSTR; /* 검색구분 ( IN : BizboxA / OUT : 연동시스템 ) */
	private String createSeq = commonCode.EMPTYSEQ; /* 최초 생성자 */
	private String modifySeq = commonCode.EMPTYSEQ; /* 최종 수정자 */
	private String searchFromDate = commonCode.EMPTYSTR; /* 검색 시작일 */
	private String searchToDate = commonCode.EMPTYSTR; /* 검색 종료일 */
	private String searchCardNum = commonCode.EMPTYSTR; /* 검색 카드번호 */
	private String syncId = commonCode.EMPTYSEQ; /* 카드 사용내역 키값 */
	private String authDate = commonCode.EMPTYSTR; /* 거래 승인일자 */
	private String authTime = commonCode.EMPTYSTR; /* 증빙시간 */
	private String authNum = commonCode.EMPTYSTR; /* 승인번호 */
	private String georaeCand = commonCode.EMPTYSTR; /* 거래 취소일자 */
	private String mercName = commonCode.EMPTYSTR; /* 거래처 명칭 */
	private String mercSaupNo = commonCode.EMPTYSTR; /* 거래처 사업자 등록 번호 */
	private String mercTel = commonCode.EMPTYSTR; /* 거래처 유선 연락처 */
	private String mercZip = commonCode.EMPTYSTR; /* 사업장 주소 우편번호 */
	private String mercAddr = commonCode.EMPTYSTR; /* 사업장 주소 */
	private String gongjeNoChk = commonCode.EMPTYNO; /* 불공제 여부 */
	private String mccStat = commonCode.EMPTYSTR; /* 거래처 구분 */
	private String requestAmount = commonCode.EMPTYSEQ; /* 공급가액 */
	private String vatMdAmount = commonCode.EMPTYSEQ; /* 부가세액 */
	private String amtMdAmount = commonCode.EMPTYSEQ; /* 공급대가 */
	private String serAmount = commonCode.EMPTYSEQ; /* 서비스 금액 */
	private String empSeq = commonCode.EMPTYSTR; /* 사용자 시퀀스 */
	private String dispEmpName = commonCode.EMPTYSTR; /* 사용자 표현 명칭 */
	private String deptSeq = commonCode.EMPTYSTR; /* 사용자 부서 시퀀스 */
	private String erpDeptSeq = commonCode.EMPTYSTR; /* ERP 사용자 부서 시퀀스 */
	private String empName = commonCode.EMPTYSTR; /* 사용자 명 */
	private String erpEmpName = commonCode.EMPTYSTR; /* ERP 사용자 명 */
	private String summarySeq = commonCode.EMPTYSTR; /* 표준적요 시퀀스 */
	private String dispSummaryName = commonCode.EMPTYSTR; /* 표준적요 표현 명칭 */
	private String summaryName = commonCode.EMPTYSTR; /* 표준적요 명칭 */
	private String drAcctCode = commonCode.EMPTYSTR; /* 차변 계정과목 코드 */
	private String drAcctName = commonCode.EMPTYSTR; /* 차변 계정과목 명칭 */
	private String authSeq = commonCode.EMPTYSTR; /* 증빙유형 시퀀스 */
	private String dispAuthName = commonCode.EMPTYSTR; /* 증빙유형 표현 명칭 */
	private String authName = commonCode.EMPTYSTR; /* 증빙유형 명칭 */
	private String projectSeq = commonCode.EMPTYSTR; /* 프로젝트 시퀀스 */
	private String dispProjectName = commonCode.EMPTYSTR; /* 프로젝트 표현 명칭 */
	private String projectCode = commonCode.EMPTYSTR; /* 프로젝트 코드 */
	private String projectName = commonCode.EMPTYSTR; /* 프로젝트 명칭 */
	private String budgetSeq = commonCode.EMPTYSTR; /* 예산 시퀀스 */
	private String dispBudgetName = commonCode.EMPTYSTR; /* 예산단위 표현 명칭 */
	private String dispBizplanName = commonCode.EMPTYSTR; /* 사업계획 표현 명칭 */
	private String dispBgacctName = commonCode.EMPTYSTR; /* 예산계정 표현 명칭 */
	private String budgetName = commonCode.EMPTYSTR; /* 예산단위 명칭 */
	private String bizplanName = commonCode.EMPTYSTR; /* 사업계획 명칭 */
	private String bgacctName = commonCode.EMPTYSTR; /* 예산계정 명칭 */
	private String note = commonCode.EMPTYSTR; /* 적요 */
	private String sendYN = commonCode.EMPTYNO; /* 상신여부 */
	private String userSendYN = commonCode.EMPTYNO; /* 관리자 마감 처리 여부 */
	private String ifMId = commonCode.EMPTYSEQ; /* 외부연동 아이디 */
	private String ifDId = commonCode.EMPTYSEQ; /* 외부연동 아이디 */
	private String georaeStat = "1"; /* 승인구분 */
	private String abroad = "A"; /* 해외결재여부 */
	private String docSeq = commonCode.EMPTYSEQ; /* 전자결재 아이디 */
	private String docNo = commonCode.EMPTYSTR; /* 전자결재 문서 번호 */
	private String docTitle = commonCode.EMPTYSTR; /* 전자결재 문서 제목 */
	private String docSts = commonCode.EMPTYSTR; /* 전자결재 문서 상태 */
	private String docUseYN = commonCode.EMPTYSTR; /* 전자결재 삭제 여부 */
	private String formMode = commonCode.EMPTYSTR; /* 전자결재 양식 모드 */
	private String mercRepr = commonCode.EMPTYSTR; /* 거래처 대표자 명 */
	private String amtSerMdAmount = commonCode.EMPTYSTR; /* 공급가액 + 서비스금액 */
	private String expendSeq = commonCode.EMPTYSTR; /* 공급가액 + 서비스금액 */
	
	/* 2019-02-21 김상겸 추가 ==> UBA-33466 */
	private String partnerNo = commonCode.EMPTYSTR; /* 사업자등록번호 */
	private String pplNo = commonCode.EMPTYSTR; /* 개인 번호 */
	private String pratnerFg = commonCode.EMPTYSTR; /* 거래처 구분 */
	private String groupSeq = commonCode.EMPTYSTR; /* 거래처 구분 */
	
	/* 2019-10-17 권오광 추가 ==> UCAIMP-4128 */
	private String georaeGukga = commonCode.EMPTYSTR; /* 환종 */
	private String aquiRate = "0.0000"; /* 환율 */
	private String forAmount = "0.0000"; /* 외화금액 */

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getCompSeq() {
		return CommonConvert.CommonGetStr(compSeq);
	}

	public void setCompSeq(String compSeq) {
		this.compSeq = compSeq;
	}

	public String getEmpCompSeq() {
		return CommonConvert.CommonGetStr(empCompSeq);
	}

	public void setEmpCompSeq(String empCompSeq) {
		this.empCompSeq = empCompSeq;
	}

	public String getCardCode() {
		return CommonConvert.CommonGetStr(cardCode);
	}

	public void setCardCode(String cardCode) {
		this.cardCode = cardCode;
	}

	public String getCardNum() {
		return CommonConvert.CommonGetStr(cardNum);
	}

	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}

	public String getCardName() {
		return CommonConvert.CommonGetStr(cardName);
	}

	public void setCardName(String cardName) {
		this.cardName = cardName;
	}

	public String getPartnerCode() {
		return CommonConvert.CommonGetStr(partnerCode);
	}

	public void setPartnerCode(String partnerCode) {
		this.partnerCode = partnerCode;
	}

	public String getPartnerName() {
		return CommonConvert.CommonGetStr(partnerName);
	}

	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}

	public String getCardPublicJson() {
		return CommonConvert.CommonGetStr(cardPublicJson);
	}

	public void setCardPublicJson(String cardPublicJson) {
		this.cardPublicJson = cardPublicJson;
	}

	public String getCardPublic() {
		return CommonConvert.CommonGetStr(cardPublic);
	}

	public void setCardPublic(String cardPublic) {
		this.cardPublic = cardPublic;
	}

	public String getUseYN() {
		return CommonConvert.CommonGetStr(useYN);
	}

	public void setUseYN(String useYN) {
		this.useYN = useYN;
	}

	public String getErpCompSeq() {
		return CommonConvert.CommonGetStr(erpCompSeq);
	}

	public void setErpCompSeq(String erpCompSeq) {
		this.erpCompSeq = erpCompSeq;
	}

	public String getBankPartnerCode() {
		return CommonConvert.CommonGetStr(bankPartnerCode);
	}

	public void setBankPartnerCode(String bankPartnerCode) {
		this.bankPartnerCode = bankPartnerCode;
	}

	public String getBankPartnerName() {
		return CommonConvert.CommonGetStr(bankPartnerName);
	}

	public void setBankPartnerName(String bankPartnerName) {
		this.bankPartnerName = bankPartnerName;
	}

	public String getCallback() {
		return CommonConvert.CommonGetStr(callback);
	}

	public void setCallback(String callback) {
		this.callback = callback;
	}

	public String getFormSeq() {
		return CommonConvert.CommonGetStr(formSeq);
	}

	public void setFormSeq(String formSeq) {
		this.formSeq = formSeq;
	}

	public String getSearchStr() {
		return CommonConvert.CommonGetStr(searchStr);
	}

	public void setSearchStr(String searchStr) {
		this.searchStr = searchStr;
	}

	public String getSearchType() {
		return CommonConvert.CommonGetStr(searchType);
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getCreateSeq() {
		return CommonConvert.CommonGetStr(createSeq);
	}

	public void setCreateSeq(String createSeq) {
		this.createSeq = createSeq;
	}

	public String getModifySeq() {
		return CommonConvert.CommonGetStr(modifySeq);
	}

	public void setModifySeq(String modifySeq) {
		this.modifySeq = modifySeq;
	}

	public String getSearchFromDate() {
		return CommonConvert.CommonGetStr(searchFromDate);
	}

	public void setSearchFromDate(String searchFromDate) {
		this.searchFromDate = searchFromDate;
	}

	public String getSearchToDate() {
		return CommonConvert.CommonGetStr(searchToDate);
	}

	public void setSearchToDate(String searchToDate) {
		this.searchToDate = searchToDate;
	}

	public String getSearchCardNum() {
		return CommonConvert.CommonGetStr(searchCardNum);
	}

	public void setSearchCardNum(String searchCardNum) {
		this.searchCardNum = searchCardNum;
	}

	public String getSyncId() {
		return CommonConvert.CommonGetStr(syncId);
	}

	public void setSyncId(String syncId) {
		this.syncId = syncId;
	}

	public String getAuthDate() {
		return CommonConvert.CommonGetStr(authDate);
	}

	public void setAuthDate(String authDate) {
		this.authDate = authDate;
	}

	public String getAuthTime() {
		return CommonConvert.CommonGetStr(authTime);
	}

	public void setAuthTime(String authTime) {
		this.authTime = authTime;
	}

	public String getAuthNum() {
		return CommonConvert.CommonGetStr(authNum);
	}

	public void setAuthNum(String authNum) {
		this.authNum = authNum;
	}

	public String getGeoraeCand() {
		return CommonConvert.CommonGetStr(georaeCand);
	}

	public void setGeoraeCand(String georaeCand) {
		this.georaeCand = georaeCand;
	}

	public String getMercName() {
		return CommonConvert.CommonGetStr(mercName);
	}

	public void setMercName(String mercName) {
		this.mercName = mercName;
	}

	public String getMercSaupNo() {
		return CommonConvert.CommonGetStr(mercSaupNo);
	}

	public void setMercSaupNo(String mercSaupNo) {
		this.mercSaupNo = mercSaupNo;
	}

	public String getMercTel() {
		return CommonConvert.CommonGetStr(mercTel);
	}

	public void setMercTel(String mercTel) {
		this.mercTel = mercTel;
	}

	public String getMercZip() {
		return CommonConvert.CommonGetStr(mercZip);
	}

	public void setMercZip(String mercZip) {
		this.mercZip = mercZip;
	}

	public String getMercAddr() {
		return CommonConvert.CommonGetStr(mercAddr);
	}

	public void setMercAddr(String mercAddr) {
		this.mercAddr = mercAddr;
	}

	public String getGongjeNoChk() {
		return CommonConvert.CommonGetStr(gongjeNoChk);
	}

	public void setGongjeNoChk(String gongjeNoChk) {
		this.gongjeNoChk = gongjeNoChk;
	}

	public String getMccStat() {
		return CommonConvert.CommonGetStr(mccStat);
	}

	public void setMccStat(String mccStat) {
		this.mccStat = mccStat;
	}

	public String getRequestAmount() {
		return CommonConvert.CommonGetStr(requestAmount);
	}

	public void setRequestAmount(String requestAmount) {
		this.requestAmount = requestAmount;
	}

	public String getVatMdAmount() {
		return CommonConvert.CommonGetStr(vatMdAmount);
	}

	public void setVatMdAmount(String vatMdAmount) {
		this.vatMdAmount = vatMdAmount;
	}

	public String getAmtMdAmount() {
		return CommonConvert.CommonGetStr(amtMdAmount);
	}

	public void setAmtMdAmount(String amtMdAmount) {
		this.amtMdAmount = amtMdAmount;
	}

	public String getSerAmount() {
		return CommonConvert.CommonGetStr(serAmount);
	}

	public void setSerAmount(String serAmount) {
		this.serAmount = serAmount;
	}

	public String getEmpSeq() {
		return CommonConvert.CommonGetStr(empSeq);
	}

	public void setEmpSeq(String empSeq) {
		this.empSeq = empSeq;
	}

	public String getDispEmpName() {
		return CommonConvert.CommonGetStr(dispEmpName);
	}

	public void setDispEmpName(String dispEmpName) {
		this.dispEmpName = dispEmpName;
	}

	public String getDeptSeq() {
		return CommonConvert.CommonGetStr(deptSeq);
	}

	public void setDeptSeq(String deptSeq) {
		this.deptSeq = deptSeq;
	}

	public String getErpDeptSeq() {
		return CommonConvert.CommonGetStr(erpDeptSeq);
	}

	public void setErpDeptSeq(String erpDeptSeq) {
		this.erpDeptSeq = erpDeptSeq;
	}

	public String getEmpName() {
		return CommonConvert.CommonGetStr(empName);
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getErpEmpName() {
		return CommonConvert.CommonGetStr(erpEmpName);
	}

	public void setErpEmpName(String erpEmpName) {
		this.erpEmpName = erpEmpName;
	}

	public String getSummarySeq() {
		return CommonConvert.CommonGetStr(summarySeq);
	}

	public void setSummarySeq(String summarySeq) {
		this.summarySeq = summarySeq;
	}

	public String getDispSummaryName() {
		return CommonConvert.CommonGetStr(dispSummaryName);
	}

	public void setDispSummaryName(String dispSummaryName) {
		this.dispSummaryName = dispSummaryName;
	}

	public String getSummaryName() {
		return CommonConvert.CommonGetStr(summaryName);
	}

	public void setSummaryName(String summaryName) {
		this.summaryName = summaryName;
	}

	public String getDrAcctCode() {
		return CommonConvert.CommonGetStr(drAcctCode);
	}

	public void setDrAcctCode(String drAcctCode) {
		this.drAcctCode = drAcctCode;
	}

	public String getDrAcctName() {
		return CommonConvert.CommonGetStr(drAcctName);
	}

	public void setDrAcctName(String drAcctName) {
		this.drAcctName = drAcctName;
	}

	public String getAuthSeq() {
		return CommonConvert.CommonGetStr(authSeq);
	}

	public void setAuthSeq(String authSeq) {
		this.authSeq = authSeq;
	}

	public String getDispAuthName() {
		return CommonConvert.CommonGetStr(dispAuthName);
	}

	public void setDispAuthName(String dispAuthName) {
		this.dispAuthName = dispAuthName;
	}

	public String getAuthName() {
		return CommonConvert.CommonGetStr(authName);
	}

	public void setAuthName(String authName) {
		this.authName = authName;
	}

	public String getProjectSeq() {
		return CommonConvert.CommonGetStr(projectSeq);
	}

	public void setProjectSeq(String projectSeq) {
		this.projectSeq = projectSeq;
	}

	public String getDispProjectName() {
		return CommonConvert.CommonGetStr(dispProjectName);
	}

	public void setDispProjectName(String dispProjectName) {
		this.dispProjectName = dispProjectName;
	}

	public String getProjectCode() {
		return CommonConvert.CommonGetStr(projectCode);
	}

	public void setProjectCode(String projectCode) {
		this.projectCode = projectCode;
	}

	public String getProjectName() {
		return CommonConvert.CommonGetStr(projectName);
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getBudgetSeq() {
		return CommonConvert.CommonGetStr(budgetSeq);
	}

	public void setBudgetSeq(String budgetSeq) {
		this.budgetSeq = budgetSeq;
	}

	public String getDispBudgetName() {
		return CommonConvert.CommonGetStr(dispBudgetName);
	}

	public void setDispBudgetName(String dispBudgetName) {
		this.dispBudgetName = dispBudgetName;
	}

	public String getDispBizplanName() {
		return CommonConvert.CommonGetStr(dispBizplanName);
	}

	public void setDispBizplanName(String dispBizplanName) {
		this.dispBizplanName = dispBizplanName;
	}

	public String getDispBgacctName() {
		return CommonConvert.CommonGetStr(dispBgacctName);
	}

	public void setDispBgacctName(String dispBgacctName) {
		this.dispBgacctName = dispBgacctName;
	}

	public String getBudgetName() {
		return CommonConvert.CommonGetStr(budgetName);
	}

	public void setBudgetName(String budgetName) {
		this.budgetName = budgetName;
	}

	public String getBizplanName() {
		return CommonConvert.CommonGetStr(bizplanName);
	}

	public void setBizplanName(String bizplanName) {
		this.bizplanName = bizplanName;
	}

	public String getBgacctName() {
		return CommonConvert.CommonGetStr(bgacctName);
	}

	public void setBgacctName(String bgacctName) {
		this.bgacctName = bgacctName;
	}

	public String getNote() {
		return CommonConvert.CommonGetStr(note);
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getSendYN() {
		return CommonConvert.CommonGetStr(sendYN);
	}

	public void setSendYN(String sendYN) {
		this.sendYN = sendYN;
	}

	public String getUserSendYN() {
		return CommonConvert.CommonGetStr(userSendYN);
	}

	public void setUserSendYN(String userSendYN) {
		this.userSendYN = userSendYN;
	}

	public String getIfMId() {
		return CommonConvert.CommonGetStr(ifMId);
	}

	public void setIfMId(String ifMId) {
		this.ifMId = ifMId;
	}

	public String getIfDId() {
		return CommonConvert.CommonGetStr(ifDId);
	}

	public void setIfDId(String ifDId) {
		this.ifDId = ifDId;
	}

	public String getGeoraeStat() {
		return CommonConvert.CommonGetStr(georaeStat);
	}

	public void setGeoraeStat(String georaeStat) {
		this.georaeStat = georaeStat;
	}

	public String getAbroad() {
		return CommonConvert.CommonGetStr(abroad);
	}

	public void setAbroad(String abroad) {
		this.abroad = abroad;
	}

	public String getDocSeq() {
		return CommonConvert.CommonGetStr(docSeq);
	}

	public void setDocSeq(String docSeq) {
		this.docSeq = docSeq;
	}

	public String getDocNo() {
		return CommonConvert.CommonGetStr(docNo);
	}

	public void setDocNo(String docNo) {
		this.docNo = docNo;
	}

	public String getDocTitle() {
		return CommonConvert.CommonGetStr(docTitle);
	}

	public void setDocTitle(String docTitle) {
		this.docTitle = docTitle;
	}

	public String getDocSts() {
		return CommonConvert.CommonGetStr(docSts);
	}

	public void setDocSts(String docSts) {
		this.docSts = docSts;
	}

	public String getDocUseYN() {
		return CommonConvert.CommonGetStr(docUseYN);
	}

	public void setDocUseYN(String docUseYN) {
		this.docUseYN = docUseYN;
	}

	public String getFormMode() {
		return CommonConvert.CommonGetStr(formMode);
	}

	public void setFormMode(String formMode) {
		this.formMode = formMode;
	}

	public String getMercRepr() {
		return CommonConvert.CommonGetStr(mercRepr);
	}

	public void setMercRepr(String mercRepr) {
		this.mercRepr = mercRepr;
	}

	public String getAmtSerMdAmount() {
		return CommonConvert.CommonGetStr(amtSerMdAmount);
	}

	public void setAmtSerMdAmount(String amtSerMdAmount) {
		this.amtSerMdAmount = amtSerMdAmount;
	}

	public String getPartnerNo() {
		return partnerNo;
	}

	public void setPartnerNo(String partnerNo) {
		this.partnerNo = partnerNo;
	}

	public String getPplNo() {
		return pplNo;
	}

	public void setPplNo(String pplNo) {
		this.pplNo = pplNo;
	}

	public String getPratnerFg() {
		return pratnerFg;
	}

	public void setPratnerFg(String pratnerFg) {
		this.pratnerFg = pratnerFg;
	}
	
	public String getExpendSeq() {
		return expendSeq;
	}

	public void setExpendSeq(String expendSeq) {
		this.expendSeq = expendSeq;
	}
	
	public String getGroupSeq() {
		return groupSeq;
	}

	public void setGroupSeq(String groupSeq) {
		this.groupSeq = groupSeq;
	}
	
	public String getGeoraeGukga() {
		return georaeGukga;
	}

	public void setGeoraeGukga(String georaeGukga) {
		this.georaeGukga = georaeGukga;
	}

	public String getAquiRate() {
		return aquiRate;
	}

	public void setAquiRate(String aquiRate) {
		this.aquiRate = aquiRate;
	}

	public String getForAmount() {
		return forAmount;
	}

	public void setForAmount(String forAmount) {
		this.forAmount = forAmount;
	}

	@Override
	public String toString() {
		return "ExCodeCardVO [seq=" + seq + ", compSeq=" + compSeq + ", empCompSeq=" + empCompSeq + ", cardCode="
				+ cardCode + ", cardNum=" + cardNum + ", cardName=" + cardName + ", partnerCode=" + partnerCode
				+ ", partnerName=" + partnerName + ", cardPublicJson=" + cardPublicJson + ", cardPublic=" + cardPublic
				+ ", useYN=" + useYN + ", erpCompSeq=" + erpCompSeq + ", bankPartnerCode=" + bankPartnerCode
				+ ", bankPartnerName=" + bankPartnerName + ", callback=" + callback + ", formSeq=" + formSeq
				+ ", searchStr=" + searchStr + ", searchType=" + searchType + ", createSeq=" + createSeq
				+ ", modifySeq=" + modifySeq + ", searchFromDate=" + searchFromDate + ", searchToDate=" + searchToDate
				+ ", searchCardNum=" + searchCardNum + ", syncId=" + syncId + ", authDate=" + authDate + ", authTime="
				+ authTime + ", authNum=" + authNum + ", georaeCand=" + georaeCand + ", mercName=" + mercName
				+ ", mercSaupNo=" + mercSaupNo + ", mercTel=" + mercTel + ", mercZip=" + mercZip + ", mercAddr="
				+ mercAddr + ", gongjeNoChk=" + gongjeNoChk + ", mccStat=" + mccStat + ", requestAmount="
				+ requestAmount + ", vatMdAmount=" + vatMdAmount + ", amtMdAmount=" + amtMdAmount + ", serAmount="
				+ serAmount + ", empSeq=" + empSeq + ", dispEmpName=" + dispEmpName + ", deptSeq=" + deptSeq
				+ ", erpDeptSeq=" + erpDeptSeq + ", empName=" + empName + ", erpEmpName=" + erpEmpName + ", summarySeq="
				+ summarySeq + ", dispSummaryName=" + dispSummaryName + ", summaryName=" + summaryName + ", drAcctCode="
				+ drAcctCode + ", drAcctName=" + drAcctName + ", authSeq=" + authSeq + ", dispAuthName=" + dispAuthName
				+ ", authName=" + authName + ", projectSeq=" + projectSeq + ", dispProjectName=" + dispProjectName
				+ ", projectCode=" + projectCode + ", projectName=" + projectName + ", budgetSeq=" + budgetSeq
				+ ", dispBudgetName=" + dispBudgetName + ", dispBizplanName=" + dispBizplanName + ", dispBgacctName="
				+ dispBgacctName + ", budgetName=" + budgetName + ", bizplanName=" + bizplanName + ", bgacctName="
				+ bgacctName + ", note=" + note + ", sendYN=" + sendYN + ", userSendYN=" + userSendYN + ", ifMId="
				+ ifMId + ", ifDId=" + ifDId + ", georaeStat=" + georaeStat + ", abroad=" + abroad + ", docSeq="
				+ docSeq + ", docNo=" + docNo + ", docTitle=" + docTitle + ", docSts=" + docSts + ", docUseYN="
				+ docUseYN + ", formMode=" + formMode + ", mercRepr=" + mercRepr + ", amtSerMdAmount=" + amtSerMdAmount
				+ ", georaeGukga=" + georaeGukga + ", aquiRate=" + aquiRate + ", forAmount=" + forAmount
				+ "]";
	}

}
