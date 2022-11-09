package common.vo.common;

import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;

public class BizboxCmm {

    private String resultCode = ""; // 프로세스 처리 상태 기록
    private String resultName = ""; // 프로세스 처리 메시지 기록

    private String groupSeq = ""; // 그룹 시퀀스
    private String compSeq = ""; // 회사 시퀀스
    private String deptSeq = ""; // 부서 시퀀스
    private String empSeq = ""; // 사원 시퀀스
    private String erpCompSeq = ""; // ERP 회사 시퀀스
    private String erpEmpSeq = ""; // ERP 사원 시퀀스


    public String getResultCode() {
        return resultCode;
    }

    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    public String getResultName() {
        return resultName;
    }

    public void setResultName(String resultName) {
        this.resultName = resultName;
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

    /* ==================================================================================================== */

    /**
     * 로그인 사용자 기준으로 조직도 정보 설정
     * 
     * @throws NotFoundLoginSessionException
     */
    public void setLogin() throws NotFoundLoginSessionException {
        LoginVO login = new LoginVO();
        login = CommonConvert.CommonGetEmpVO();

        this.setGroupSeq(login.getGroupSeq());
        this.setCompSeq(login.getCompSeq());
        this.setDeptSeq(login.getOrgnztId());
        this.setEmpSeq(login.getUniqId());
        this.setErpCompSeq(login.getErpCoCd());
        this.setErpEmpSeq(login.getErpEmpCd());
    }

    /**
     * 프로세스 처리 성공 기록
     * 
     * @param resultMessage : 프로세스 처리 메시지 기록
     */
    public void setSuccess(String resultMessage) {
        this.setResultCode("SUCCESS");
        this.setResultName(resultMessage);
    }

    /**
     * 프로세스 처리 실패 기록
     * 
     * @param resultMessage : 프로세스 처리 메시지 기록
     */
    public void setFail(String resultMessage) {
        this.setResultCode("FAIL");
        this.setResultName(resultMessage);
    }

    /**
     * resultCode 정의 상태 확인
     * 
     * @return
     * 
     *         <pre>
     * # return true : resultCode 미정의 상태
     * # return false : resultCode 정의 상태
     *         </pre>
     */
    public boolean isResultCode() {
        if (this.getResultCode() == null) {
            return false;
        }
        if (this.getResultCode().equals("")) {
            return false;
        } else {
            return true;
        }
    }
}
