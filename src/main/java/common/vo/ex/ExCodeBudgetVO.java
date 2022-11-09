package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExCodeBudgetVO {

    private int seq = 0; /* 예산정보 시퀀스 */
    private String expendSeq = commonCode.EMPTYSTR; /* 지출결의 시퀀스 */
    private String listSeq = commonCode.EMPTYSTR; /* 지출결의 항목 시퀀스 */
    private String slipSeq = commonCode.EMPTYSTR; /* 지출결의 항목 분개 시퀀스 */
    private String rowId = commonCode.EMPTYSTR; /* 임시예산 연동 아이디 마스터 */
    private String rowNo = commonCode.EMPTYSTR; /* 임시예산 연동 아이디 디테일 */
    private String compSeq = commonCode.EMPTYSTR; /* 회사 시퀀스 */
    private String erpCompSeq = commonCode.EMPTYSTR; /* ERP 회사 시퀀스 */
    private String deptSeq = commonCode.EMPTYSTR; /* 부서 시퀀스 */
    private String deptName = commonCode.EMPTYSTR; /* 부서 명칭 */
    private String erpDeptSeq = commonCode.EMPTYSTR; /* ERP 부서 시퀀스 */
    private String erpDeptName = commonCode.EMPTYSTR; /* ERP 부서 명칭 */
    private String empSeq = commonCode.EMPTYSTR; /* 사원 시퀀스 */
    private String erpEmpSeq = commonCode.EMPTYSTR; /* ERP 사원 시퀀스 */
    private String useYN = commonCode.EMPTYSEQ; /* 예산관리여부 ( iCUBE ) : 예산통제 > 1, 예산미통제 > 0 */
    private String budgetType = commonCode.EMPTYSTR; /* 예산통제 구분 ( iCUBE ) : 결의부서 > 0 / 사용부서 > 1 / 프로젝트 > 2 */
    private String tpDrcr = "1"; /* 차대구분 */
    private String budgetYm = commonCode.EMPTYSTR; /* 예산년월 */
    private String budgetGbn = commonCode.EMPTYSTR; /* 통제구분 ( 년, 반기, 분기, 월 ) */
    private String budYm = commonCode.EMPTYSTR; /* 예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... ) */
    private String budgetCode = commonCode.EMPTYSTR; /* 예산단위 코드 */
    private String budgetName = commonCode.EMPTYSTR; /* 예산단위 명칭 */
    private String projectCode = commonCode.EMPTYSTR; /* 프로젝트 코드 */
    private String projectName = commonCode.EMPTYSTR; /* 프로젝트 명칭 */
    private String bizplanCode = commonCode.EMPTYSTR; /* 사업계획 코드 */
    private String bizplanName = commonCode.EMPTYSTR; /* 사업계획 명칭 */
    private String bgacctCode = commonCode.EMPTYSTR; /* 예산계정 코드 */
    private String bgacctName = commonCode.EMPTYSTR; /* 예산계정 명칭 */
    private String budgetJsum = commonCode.EMPTYSEQ; /* 예산진행금액 ( 편성 + 조정 금액 ) */
    private String budgetActsum = commonCode.EMPTYSEQ; /* 예산 실행합 금액 ( 사용예산 금액 ) */
    private String budgetAmAction = commonCode.EMPTYSEQ; /* 문서상 예산 신청 금액 */
    private String budgetGwAct = commonCode.EMPTYSEQ; /* 예산 실행합 금액 ( 사용예산 금액 >> iCUBE ) */
    private String budgetControlYN = commonCode.EMPTYNO; /* 예산 통제 여부 */
    private String amt = "0.00"; /* 예산체크시 체크 금액 >> 결재작성시 사용 */
    private String dracctAmt = "0.00"; /* 사용금액 */
    private String searchStr = commonCode.EMPTYSTR; /* 검색어 */
    private String callback = commonCode.EMPTYSTR; /* 콜백 */
    private String idInsert = commonCode.EMPTYSTR; /* ERPiU 전송자 ( 사원번호 ) */
    private String createSeq = commonCode.EMPTYSTR; /* 최초 생성자 */
    private String idUpdate = commonCode.EMPTYSTR; /* ERPiU 수정자 ( 사원번호 ) */
    private String modifySeq = commonCode.EMPTYSTR; /* 최종 수정자 */
    private boolean isComeHistory = false; /* 지출결의 가져오기에서 사용한건지 확인(예산체크를 위하여) */
    private String groupSeq = commonCode.EMPTYSTR; /* 그룹 시퀀스 */

    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
    private String cdBgLevel = commonCode.EMPTYSTR; // 예산통제레벨계정 ( ERPiU 연동 사용 )
    private String ynControl = commonCode.EMPTYSTR; // 예산통제여부 ( N : 통제안함, Y : 통제 ) ( ERPiU 연동 사용 )
    private String tpControl = commonCode.EMPTYSTR; // 예산통제기준 ( 1 : 예산단위통제, 2 : 예산계정통제 ) ( ERPiU 연동 사용 )

    public String getGroupSeq() {
        return CommonConvert.CommonGetStr(groupSeq);
    }

    public void setGroupSeq(String groupSeq) {
        this.groupSeq = groupSeq;
    }

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getExpendSeq() {
        return CommonConvert.CommonGetStr(expendSeq);
    }

    public void setExpendSeq(String expendSeq) {
        this.expendSeq = expendSeq;
    }

    public String getListSeq() {
        return CommonConvert.CommonGetStr(listSeq);
    }

    public void setListSeq(String listSeq) {
        this.listSeq = listSeq;
    }

    public String getSlipSeq() {
        return CommonConvert.CommonGetStr(slipSeq);
    }

    public void setSlipSeq(String slipSeq) {
        this.slipSeq = slipSeq;
    }

    public String getRowId() {
        return CommonConvert.CommonGetStr(rowId);
    }

    public void setRowId(String rowId) {
        this.rowId = rowId;
    }

    public String getRowNo() {
        return CommonConvert.CommonGetStr(rowNo);
    }

    public void setRowNo(String rowNo) {
        this.rowNo = rowNo;
    }

    public String getCompSeq() {
        return CommonConvert.CommonGetStr(compSeq);
    }

    public void setCompSeq(String compSeq) {
        this.compSeq = compSeq;
    }

    public String getErpCompSeq() {
        return CommonConvert.CommonGetStr(erpCompSeq);
    }

    public void setErpCompSeq(String erpCompSeq) {
        this.erpCompSeq = erpCompSeq;
    }

    public String getDeptSeq() {
        return CommonConvert.CommonGetStr(deptSeq);
    }

    public void setDeptSeq(String deptSeq) {
        this.deptSeq = deptSeq;
    }

    public String getDeptName() {
        return CommonConvert.CommonGetStr(deptName);
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getErpDeptSeq() {
        return CommonConvert.CommonGetStr(erpDeptSeq);
    }

    public void setErpDeptSeq(String erpDeptSeq) {
        this.erpDeptSeq = erpDeptSeq;
    }

    public String getErpDeptName() {
        return CommonConvert.CommonGetStr(erpDeptName);
    }

    public void setErpDeptName(String erpDeptName) {
        this.erpDeptName = erpDeptName;
    }

    public String getEmpSeq() {
        return CommonConvert.CommonGetStr(empSeq);
    }

    public void setEmpSeq(String empSeq) {
        this.empSeq = empSeq;
    }

    public String getErpEmpSeq() {
        return CommonConvert.CommonGetStr(erpEmpSeq);
    }

    public void setErpEmpSeq(String erpEmpSeq) {
        this.erpEmpSeq = erpEmpSeq;
    }

    public String getUseYN() {
        return CommonConvert.CommonGetStr(useYN);
    }

    public void setUseYN(String useYN) {
        this.useYN = useYN;
    }

    public String getBudgetType() {
        return CommonConvert.CommonGetStr(budgetType);
    }

    public void setBudgetType(String budgetType) {
        this.budgetType = budgetType;
    }

    public String getTpDrcr() {
        return CommonConvert.CommonGetStr(tpDrcr);
    }

    public void setTpDrcr(String tpDrcr) {
        this.tpDrcr = tpDrcr;
    }

    public String getBudgetYm() {
        return CommonConvert.CommonGetStr(budgetYm);
    }

    public void setBudgetYm(String budgetYm) {
        this.budgetYm = budgetYm;
    }

    public String getBudgetGbn() {
        return CommonConvert.CommonGetStr(budgetGbn);
    }

    public void setBudgetGbn(String budgetGbn) {
        this.budgetGbn = budgetGbn;
    }

    public String getBudYm() {
        return CommonConvert.CommonGetStr(budYm);
    }

    public void setBudYm(String budYm) {
        this.budYm = budYm;
    }

    public String getBudgetCode() {
        return CommonConvert.CommonGetStr(budgetCode);
    }

    public void setBudgetCode(String budgetCode) {
        this.budgetCode = budgetCode;
    }

    public String getBudgetName() {
        return CommonConvert.CommonGetStr(budgetName);
    }

    public void setBudgetName(String budgetName) {
        this.budgetName = budgetName;
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

    public String getBizplanCode() {
        return CommonConvert.CommonGetStr(bizplanCode);
    }

    public void setBizplanCode(String bizplanCode) {
        this.bizplanCode = bizplanCode;
    }

    public String getBizplanName() {
        return CommonConvert.CommonGetStr(bizplanName);
    }

    public void setBizplanName(String bizplanName) {
        this.bizplanName = bizplanName;
    }

    public String getBgacctCode() {
        return CommonConvert.CommonGetStr(bgacctCode);
    }

    public void setBgacctCode(String bgacctCode) {
        this.bgacctCode = bgacctCode;
    }

    public String getBgacctName() {
        return CommonConvert.CommonGetStr(bgacctName);
    }

    public void setBgacctName(String bgacctName) {
        this.bgacctName = bgacctName;
    }

    public String getBudgetJsum() {
        return CommonConvert.CommonGetStr(budgetJsum);
    }

    public void setBudgetJsum(String budgetJsum) {
        this.budgetJsum = budgetJsum;
    }

    public String getBudgetActsum() {
        return CommonConvert.CommonGetStr(budgetActsum);
    }

    public void setBudgetActsum(String budgetActsum) {
        this.budgetActsum = budgetActsum;
    }

    public String getBudgetAmAction() {
        return CommonConvert.CommonGetStr(budgetAmAction);
    }

    public void setBudgetAmAction(String budgetAmAction) {
        this.budgetAmAction = budgetAmAction;
    }

    public String getBudgetGwAct() {
        return CommonConvert.CommonGetStr(budgetGwAct);
    }

    public void setBudgetGwAct(String budgetGwAct) {
        this.budgetGwAct = budgetGwAct;
    }

    public String getBudgetControlYN() {
        return CommonConvert.CommonGetStr(budgetControlYN);
    }

    public void setBudgetControlYN(String budgetControlYN) {
        this.budgetControlYN = budgetControlYN;
    }

    public String getAmt() {
        return CommonConvert.CommonGetStr(amt);
    }

    public void setAmt(String amt) {
        this.amt = amt;
    }

    public String getDracctAmt() {
        return CommonConvert.CommonGetStr(dracctAmt);
    }

    public void setDracctAmt(String dracctAmt) {
        this.dracctAmt = dracctAmt;
    }

    public String getSearchStr() {
        return CommonConvert.CommonGetStr(searchStr);
    }

    public void setSearchStr(String searchStr) {
        this.searchStr = searchStr;
    }

    public String getCallback() {
        return CommonConvert.CommonGetStr(callback);
    }

    public void setCallback(String callback) {
        this.callback = callback;
    }

    public String getIdInsert() {
        return CommonConvert.CommonGetStr(idInsert);
    }

    public void setIdInsert(String idInsert) {
        this.idInsert = idInsert;
    }

    public String getCreateSeq() {
        return CommonConvert.CommonGetStr(createSeq);
    }

    public void setCreateSeq(String createSeq) {
        this.createSeq = createSeq;
    }

    public String getIdUpdate() {
        return CommonConvert.CommonGetStr(idUpdate);
    }

    public void setIdUpdate(String idUpdate) {
        this.idUpdate = idUpdate;
    }

    public String getModifySeq() {
        return CommonConvert.CommonGetStr(modifySeq);
    }

    public void setModifySeq(String modifySeq) {
        this.modifySeq = modifySeq;
    }

    public String getCdBgLevel() {
        return cdBgLevel;
    }

    public void setCdBgLevel(String cdBgLevel) {
        this.cdBgLevel = cdBgLevel;
    }

    public String getYnControl() {
        return ynControl;
    }

    public void setYnControl(String ynControl) {
        this.ynControl = ynControl;
    }

    public String getTpControl() {
        return tpControl;
    }

    public void setTpControl(String tpControl) {
        this.tpControl = tpControl;
    }

    public boolean getIsComeHistory() {
        return isComeHistory;
    }

    public void setIsComeHistory(boolean isComeHistory) {
        this.isComeHistory = isComeHistory;
    }

    @Override
    public String toString() {
        return "ExCodeBudgetVO [seq=" + seq + ", expendSeq=" + expendSeq + ", listSeq=" + listSeq + ", slipSeq=" + slipSeq + ", rowId=" + rowId + ", rowNo=" + rowNo + ", compSeq=" + compSeq + ", erpCompSeq=" + erpCompSeq + ", deptSeq=" + deptSeq + ", deptName=" + deptName + ", erpDeptSeq=" + erpDeptSeq + ", erpDeptName=" + erpDeptName + ", empSeq=" + empSeq + ", erpEmpSeq=" + erpEmpSeq + ", useYN=" + useYN + ", budgetType=" + budgetType + ", tpDrcr=" + tpDrcr + ", budgetYm=" + budgetYm + ", budgetGbn=" + budgetGbn + ", budYm=" + budYm + ", budgetCode=" + budgetCode + ", budgetName=" + budgetName + ", projectCode=" + projectCode + ", projectName=" + projectName + ", bizplanCode=" + bizplanCode + ", bizplanName=" + bizplanName + ", bgacctCode=" + bgacctCode + ", bgacctName=" + bgacctName + ", budgetJsum=" + budgetJsum + ", budgetActsum=" + budgetActsum + ", budgetAmAction=" + budgetAmAction + ", budgetGwAct=" + budgetGwAct + ", budgetControlYN=" + budgetControlYN + ", amt=" + amt
                + ", dracctAmt=" + dracctAmt + ", searchStr=" + searchStr + ", callback=" + callback + ", idInsert=" + idInsert + ", createSeq=" + createSeq + ", idUpdate=" + idUpdate + ", modifySeq=" + modifySeq + ", isComeHistory=" + isComeHistory + ", groupSeq=" + groupSeq + ", cdBgLevel=" + cdBgLevel + ", ynControl=" + ynControl + ", tpControl=" + tpControl + "]";
    }
}
