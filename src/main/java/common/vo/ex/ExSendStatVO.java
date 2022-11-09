package common.vo.ex;

import bizbox.orgchart.service.vo.LoginVO;

public class ExSendStatVO {
    // 그룹 시퀀
    private String groupSeq = "";

    // 회사 시퀀
    private String compSeq = "";

    // 부서 시퀀
    private String deptSeq = "";

    // 회사 시퀀스
    private String empSeq = "";

    // ERP 회사 코드
    private String erpCompSeq = "";

    // ERP 사원번호
    private String erpEmpSeq = "";

    // 지출결의 시퀀
    private String expendSeq = "";

    // 지출결의 항목 시퀀
    private String listSeq = "";

    // 지출결의 회계일
    private String expendDate = "";

    // 전송 순번 ( FI_ADOCU 자동전표 )
    private String rowId = "";

    // 전송 일자 ( SAUTODOCU 자동전표 )
    private String inDt = "";

    // 전송 순번 ( SAUTODOCU 자동전표 )
    private String inSq = "";

    // 현재 최대
    private String maxSeq = "";

    // 전송 상태
    private String erpSendYn = "";

    private int erpSendStatUpdateCount = 0;

    public ExSendStatVO() {

    }

    public ExSendStatVO(LoginVO loginVo) {
        this.setGroupSeq(loginVo.getGroupSeq());
        this.setCompSeq(loginVo.getCompSeq());
        this.setDeptSeq(loginVo.getOrgnztId());
        this.setEmpSeq(loginVo.getUniqId());
        this.setErpCompSeq(loginVo.getErpCoCd());
        this.setErpEmpSeq(loginVo.getErpEmpCd());
    }

    public String getGroupSeq() {
        return groupSeq;
    }

    public void setGroupSeq(String groupSeq) {
        this.groupSeq = groupSeq;
    }

    public String getCompSeq() {
        return compSeq;
    }

    public void setCompSeq(String compSeq) {
        this.compSeq = compSeq;
    }

    public String getDeptSeq() {
        return deptSeq;
    }

    public void setDeptSeq(String deptSeq) {
        this.deptSeq = deptSeq;
    }

    public String getEmpSeq() {
        return empSeq;
    }

    public void setEmpSeq(String empSeq) {
        this.empSeq = empSeq;
    }

    public String getErpCompSeq() {
        return erpCompSeq;
    }

    public void setErpCompSeq(String erpCompSeq) {
        this.erpCompSeq = erpCompSeq;
    }

    public String getErpEmpSeq() {
        return erpEmpSeq;
    }

    public void setErpEmpSeq(String erpEmpSeq) {
        this.erpEmpSeq = erpEmpSeq;
    }

    public String getExpendSeq() {
        return expendSeq;
    }

    public void setExpendSeq(String expendSeq) {
        this.expendSeq = expendSeq;
    }

    public String getListSeq() {
        return listSeq;
    }

    public void setListSeq(String listSeq) {
        this.listSeq = listSeq;
    }

    public String getExpendDate() {
        return expendDate.replaceAll("-", "");
    }

    public void setExpendDate(String expendDate) {
        this.expendDate = expendDate.replaceAll("-", "");
    }

    public String getRowId() {
        return rowId;
    }

    public void setRowId(String rowId) {
        this.rowId = rowId;
    }

    public String getInDt() {
        return inDt.replaceAll("-", "");
    }

    public void setInDt(String inDt) {
        this.inDt = inDt.replaceAll("-", "");
    }

    public String getInSq() {
        return inSq;
    }

    public void setInSq(String inSq) {
        this.inSq = inSq;
    }

    public String getMaxSeq() {
        return maxSeq;
    }

    public void setMaxSeq(String maxSeq) {
        this.maxSeq = maxSeq;
    }

    public String getErpSendYn() {
        return erpSendYn;
    }

    public void setErpSendYn(String erpSendYn) {
        this.erpSendYn = erpSendYn;
    }



    public int getErpSendStatUpdateCount() {
        return erpSendStatUpdateCount;
    }

    public void setErpSendStatUpdateCount(int erpSendStatUpdateCount) {
        this.erpSendStatUpdateCount = erpSendStatUpdateCount;
    }

    @Override
    public String toString() {
        return "ExSendStatVO [groupSeq=" + groupSeq + ", compSeq=" + compSeq + ", deptSeq=" + deptSeq + ", empSeq=" + empSeq + ", erpCompSeq=" + erpCompSeq + ", erpEmpSeq=" + erpEmpSeq + ", expendSeq=" + expendSeq + ", listSeq=" + listSeq + ", expendDate=" + expendDate + ", rowId=" + rowId + ", inDt=" + inDt + ", inSq=" + inSq + ", maxSeq=" + maxSeq + ", erpSendYn=" + erpSendYn + ", erpSendStatUpdateCount=" + erpSendStatUpdateCount + "]";
    }
}
