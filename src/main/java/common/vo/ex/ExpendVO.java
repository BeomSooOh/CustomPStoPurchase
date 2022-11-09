package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExpendVO {

    private String compSeq = commonCode.EMPTYSTR; /* 귀속회사 시퀀스 */
    private String erpCompSeq = commonCode.EMPTYSTR; /* ERP 회사코드 */
    private String expendSeq = commonCode.EMPTYSTR; /* 지출결의 시퀀스 */
    private String docSeq = commonCode.EMPTYSTR; /* 전자결재 시퀀스 */
    private String expendStatCode = commonCode.EMPTYSTR; /* 지출결의 상태코드 ( 전자결재 동일, 상태값 변경 비교를 위해 사용 ) */
    private String expendDate = commonCode.EMPTYSTR; /* 결의일자 ( 회계일자, 예산년월 ) */
    private String expendReqDate = commonCode.EMPTYSTR; /* 지급요청일자 ( 만기일자 ) */
    private String erpSendYN = commonCode.EMPTYSTR; /* ERP 전송여부 ( 전송 : Y / 미전송 : N ) */
    private int writeSeq = 0; /* 작성자 */
    private int empSeq = 0; /* 사용자 */
    private int budgetSeq = 0; /* 예산 */
    private int projectSeq = 0; /* 프로젝트 */
    private int partnerSeq = 0; /* 거래처 */
    private int cardSeq = 0; /* 카드 */
    private String jsonStr = commonCode.EMPTYSTR; /* 지출결의 JSON 문자열 */
    private String erpSendSeq = commonCode.EMPTYSEQ; /* 지출결의 > 자동전표 전송자 */
    private String erpSendDate = commonCode.EMPTYSTR; /* 지출결의 > 자동전표 전송일자 */
    private String rowId = commonCode.EMPTYSTR; /* ERPiU 자동전표 아이디 */
    private String inDt = commonCode.EMPTYSTR; /* iCUBE 자동전표 아이디 마스터 */
    private String inSq = commonCode.EMPTYSTR; /* iCUBE 자동전표 아이디 디테일 */
    private String formSeq = commonCode.EMPTYSEQ; /* 양식아이디 */
    private String createSeq = commonCode.EMPTYSTR; /* 생성자 */
    private String modifySeq = commonCode.EMPTYSTR; /* 수정자 */
    private String groupSeq = commonCode.EMPTYSTR; /* 그룹 시퀀스 */

    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
    private String erpiuBudgetVer = commonCode.EMPTYSTR; /* ERPiU 예산통제 버전 구분 */

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

    public String getExpendSeq() {
        return CommonConvert.CommonGetStr(expendSeq);
    }

    public void setExpendSeq(String expendSeq) {
        this.expendSeq = expendSeq;
    }

    public String getDocSeq() {
        return CommonConvert.CommonGetStr(docSeq);
    }

    public void setDocSeq(String docSeq) {
        this.docSeq = docSeq;
    }

    public String getExpendStatCode() {
        return CommonConvert.CommonGetStr(expendStatCode);
    }

    public void setExpendStatCode(String expendStatCode) {
        this.expendStatCode = expendStatCode;
    }

    public String getExpendDate() {
        return CommonConvert.CommonGetStr(expendDate);
    }

    public void setExpendDate(String expendDate) {
        this.expendDate = expendDate;
    }

    public String getExpendReqDate() {
        return CommonConvert.CommonGetStr(expendReqDate);
    }

    public void setExpendReqDate(String expendReqDate) {
        this.expendReqDate = expendReqDate;
    }

    public String getGroupSeq() {
        return CommonConvert.CommonGetStr(groupSeq);
    }

    public void setGroupSeq(String groupSeq) {
        this.groupSeq = groupSeq;
    }

    public String getErpSendYN() {
        return CommonConvert.CommonGetStr(erpSendYN);
    }

    public void setErpSendYN(String erpSendYN) {
        this.erpSendYN = erpSendYN;
    }

    public int getWriteSeq() {
        return writeSeq;
    }

    public void setWriteSeq(int writeSeq) {
        this.writeSeq = writeSeq;
    }

    public int getEmpSeq() {
        return empSeq;
    }

    public void setEmpSeq(int empSeq) {
        this.empSeq = empSeq;
    }

    public int getBudgetSeq() {
        return budgetSeq;
    }

    public void setBudgetSeq(int budgetSeq) {
        this.budgetSeq = budgetSeq;
    }

    public int getProjectSeq() {
        return projectSeq;
    }

    public void setProjectSeq(int projectSeq) {
        this.projectSeq = projectSeq;
    }

    public int getPartnerSeq() {
        return partnerSeq;
    }

    public void setPartnerSeq(int partnerSeq) {
        this.partnerSeq = partnerSeq;
    }

    public int getCardSeq() {
        return cardSeq;
    }

    public void setCardSeq(int cardSeq) {
        this.cardSeq = cardSeq;
    }

    public String getJsonStr() {
        return CommonConvert.CommonGetStr(jsonStr);
    }

    public void setJsonStr(String jsonStr) {
        this.jsonStr = jsonStr;
    }

    public String getErpSendSeq() {
        return CommonConvert.CommonGetStr(erpSendSeq);
    }

    public void setErpSendSeq(String erpSendSeq) {
        this.erpSendSeq = erpSendSeq;
    }

    public String getRowId() {
        return CommonConvert.CommonGetStr(rowId);
    }

    public void setRowId(String rowId) {
        this.rowId = rowId;
    }

    public String getInDt() {
        return CommonConvert.CommonGetStr(inDt);
    }

    public void setInDt(String inDt) {
        this.inDt = inDt;
    }

    public String getInSq() {
        return CommonConvert.CommonGetStr(inSq);
    }

    public void setInSq(String inSq) {
        this.inSq = inSq;
    }

    public String getFormSeq() {
        return CommonConvert.CommonGetStr(formSeq);
    }

    public void setFormSeq(String formSeq) {
        this.formSeq = formSeq;
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

    public String getErpSendDate() {
        return erpSendDate;
    }

    public void setErpSendDate(String erpSendDate) {
        this.erpSendDate = erpSendDate;
    }

    public String getErpiuBudgetVer() {
        return erpiuBudgetVer;
    }

    public void setErpiuBudgetVer(String erpiuBudgetVer) {
        this.erpiuBudgetVer = erpiuBudgetVer;
    }

    @Override
    public String toString() {
        return "ExpendVO [compSeq=" + compSeq + ", erpCompSeq=" + erpCompSeq + ", expendSeq=" + expendSeq + ", docSeq=" + docSeq + ", expendStatCode=" + expendStatCode + ", expendDate=" + expendDate + ", expendReqDate=" + expendReqDate + ", erpSendYN=" + erpSendYN + ", writeSeq=" + writeSeq + ", empSeq=" + empSeq + ", budgetSeq=" + budgetSeq + ", projectSeq=" + projectSeq + ", partnerSeq=" + partnerSeq + ", cardSeq=" + cardSeq + ", jsonStr=" + jsonStr + ", erpSendSeq=" + erpSendSeq + ", erpSendDate=" + erpSendDate + ", rowId=" + rowId + ", inDt=" + inDt + ", inSq=" + inSq + ", formSeq=" + formSeq + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + ", groupSeq=" + groupSeq + ", erpiuBudgetVer=" + erpiuBudgetVer + ", getCompSeq()=" + getCompSeq() + ", getErpCompSeq()=" + getErpCompSeq() + ", getExpendSeq()=" + getExpendSeq() + ", getDocSeq()=" + getDocSeq() + ", getExpendStatCode()=" + getExpendStatCode() + ", getExpendDate()=" + getExpendDate() + ", getExpendReqDate()="
                + getExpendReqDate() + ", getGroupSeq()=" + getGroupSeq() + ", getErpSendYN()=" + getErpSendYN() + ", getWriteSeq()=" + getWriteSeq() + ", getEmpSeq()=" + getEmpSeq() + ", getBudgetSeq()=" + getBudgetSeq() + ", getProjectSeq()=" + getProjectSeq() + ", getPartnerSeq()=" + getPartnerSeq() + ", getCardSeq()=" + getCardSeq() + ", getJsonStr()=" + getJsonStr() + ", getErpSendSeq()=" + getErpSendSeq() + ", getRowId()=" + getRowId() + ", getInDt()=" + getInDt() + ", getInSq()=" + getInSq() + ", getFormSeq()=" + getFormSeq() + ", getCreateSeq()=" + getCreateSeq() + ", getModifySeq()=" + getModifySeq() + ", getErpSendDate()=" + getErpSendDate() + ", getErpiuBudgetVer()=" + getErpiuBudgetVer() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
    }
}
