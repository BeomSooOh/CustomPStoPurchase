package model.common;

import javax.annotation.Resource;
import org.apache.logging.log4j.LogManager;
import base.BaseDao;
import bizbox.orgchart.service.vo.LoginVO;
import common.helper.convert.CommonConvert;
import common.helper.exception.NotFoundLoginSessionException;
import exception.ExceptionNotConnectERP;
import exception.ExceptionNotFoundLoginSession;

public final class Mlogin {

    /* private --------------------------------------------------------------------------------------------- */

    // dao
    @Resource(name = "BaseDao")
    private BaseDao base; /* Bizbox Alpha */

    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    private String loginId = ""; // 로그인아이디
    private String groupSeq = ""; // 그룹시퀀
    private String groupName = ""; // 그룹명
    private String compSeq = ""; // 회사시퀀스
    private String compName = ""; // 회사명
    private String bizSeq = ""; // 사업장시퀀스
    private String bizName = ""; // 사업장명
    private String deptSeq = ""; // 부서시퀀스
    private String deptName = ""; // 부서명
    private String empSeq = ""; // 사용자시퀀스
    private String empName = ""; // 사용자명
    private String erpCompSeq = ""; // ERP회사코드
    private String erpEmpSeq = ""; // ERP사원번호
    private String langCode = ""; // 사용언어코드
    private String eaType = ""; // 전자결재구분

    private String userAuth = ""; // 사용자 세션 권한

    private String erpDatabaseType = ""; // ERP 사용 DBMS 구분
    private String erpType = ""; // ERP 연동구분
    private String g20Yn = ""; // G20여부

    private String ipAddr = ""; // 접속자 IP 주소
    private String reqUrl = ""; // 요청 url

    private String _toString() {
        return "Mlogin [loginId=" + loginId + ", groupSeq=" + groupSeq + ", groupName=" + groupName + ", compSeq=" + compSeq + ", compName=" + compName + ", bizSeq=" + bizSeq + ", bizName=" + bizName + ", deptSeq=" + deptSeq + ", deptName=" + deptName + ", empSeq=" + empSeq + ", empName=" + empName + ", erpCompSeq=" + erpCompSeq + ", erpEmpSeq=" + erpEmpSeq + ", langCode=" + langCode + ", eaType=" + eaType + ", userAuth=" + userAuth + ", erpDatabaseType=" + erpDatabaseType + ", erpType=" + erpType + ", g20Yn=" + g20Yn + ", ipAddr=" + ipAddr + ", reqUrl=" + reqUrl + "]";
    }

    private LoginVO _getLogin() throws NotFoundLoginSessionException {
        return CommonConvert.CommonGetEmpVO();
    }

    /* public --------------------------------------------------------------------------------------------- */
    /**
     *
     * <pre>
     * # 생성자 ( 로그인 정보를 기준으로 반영 )
     *   - 로그인아이디
     *   - 그룹시퀀스
     *   - 회사시퀀스
     *   - 사업장시퀀스
     *   - 부서시퀀스
     *   - 사원시퀀스
     *   - ERP 회사코드
     *   - ERP 사원번호
     *   - 사용언어코드
     *   - 전자결재구분
     *   - 사용자권한
     *   - ERP 사용DBMS구분
     *   - ERP 연동구분
     *   - G20여부
     * </pre>
     *
     * @throws ExceptionNotFoundLoginSession 로그인 정보를 확인할 수 없는 경우
     * @throws Exception 정의되지 않은 오류
     */
    public Mlogin() throws ExceptionNotFoundLoginSession, Exception {
        LoginVO login = new LoginVO();
        login = this._getLogin();

        if (login == null) {
            throw new ExceptionNotFoundLoginSession();
        } else {
            this.setLoginId(login.getId());
            this.setGroupSeq(login.getGroupSeq());
            this.setCompSeq(login.getCompSeq());
            this.setBizSeq(login.getBizSeq());
            this.setDeptSeq(login.getOrgnztId());
            this.setEmpSeq(login.getUniqId());
            this.setErpCompSeq(login.getErpCoCd());
            this.setErpEmpSeq(login.getErpEmpCd());
            this.setLangCode(login.getLangCode());
            this.setEaType(login.getEaType());
            this.setUserAuth(login.getUserSe());

            // Mconnect _connect = new Mconnect();
            // _connect = base.GetCoErp(this.getCompSeq());
            //
            // if (_connect == null) {
            // throw new ExceptionNotConnectERP();
            // }
            //
            // this.setErpDatabaseType(_connect.getErpDatabaseType());
            // this.setErpType(_connect.getErpType());
            // this.setG20Yn(_connect.getG20Yn());
        }

        logger.debug(this._toString());
    }

    /* Setter --------------------------------------------------------------------------------------------- */
    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public void setGroupSeq(String groupSeq) {
        this.groupSeq = groupSeq;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public void setCompSeq(String compSeq) {
        this.compSeq = compSeq;
    }

    public void setCompName(String compName) {
        this.compName = compName;
    }

    public void setBizSeq(String bizSeq) {
        this.bizSeq = bizSeq;
    }

    public void setBizName(String bizName) {
        this.bizName = bizName;
    }

    public void setDeptSeq(String deptSeq) {
        this.deptSeq = deptSeq;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public void setEmpSeq(String empSeq) {
        this.empSeq = empSeq;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public void setErpCompSeq(String erpCompSeq) {
        this.erpCompSeq = erpCompSeq;
    }

    public void setErpEmpSeq(String erpEmpSeq) {
        this.erpEmpSeq = erpEmpSeq;
    }

    public void setLangCode(String langCode) {
        this.langCode = langCode;
    }

    public void setErpDatabaseType(String erpDatabaseType) {
        this.erpDatabaseType = erpDatabaseType;
    }

    public void setErpType(String erpType) {
        this.erpType = erpType;
    }

    public void setG20Yn(String g20Yn) {
        this.g20Yn = g20Yn;
    }

    public void setEaType(String eaType) {
        this.eaType = eaType;
    }

    public void setUserAuth(String userAuth) {
        this.userAuth = userAuth;
    }

    public void setIpAddr(String ipAddr) {
        this.ipAddr = ipAddr;
    }

    public void setReqUrl(String reqUrl) {
        this.reqUrl = reqUrl;
    }

    /* Getter --------------------------------------------------------------------------------------------- */
    public void getLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getGroupSeq() {
        return groupSeq;
    }

    public String getGroupName() {
        return groupName;
    }

    public String getCompSeq() {
        return compSeq;
    }

    public String getCompName() {
        return compName;
    }

    public String getBizSeq() {
        return bizSeq;
    }

    public String getBizName() {
        return bizName;
    }

    public String getDeptSeq() {
        return deptSeq;
    }

    public String getDeptName() {
        return deptName;
    }

    public String getEmpSeq() {
        return empSeq;
    }

    public String getEmpName() {
        return empName;
    }

    public String getErpCompSeq() {
        return erpCompSeq;
    }

    public String getErpEmpSeq() {
        return erpEmpSeq;
    }

    public String getLangCode() {
        return langCode;
    }

    public String getErpDatabaseType() {
        return this.erpDatabaseType;
    }

    public String getErpType() {
        return erpType;
    }

    public String getG20Yn() {
        return g20Yn;
    }

    public String getEaType() {
        return eaType;
    }

    public String getUserAuth() {
        return userAuth;
    }

    public String getIpAddr() {
        return ipAddr;
    }

    public String getReqUrl() {
        return reqUrl;
    }

    /* Def Getter --------------------------------------------------------------------------------------------- */

    /**
     * <pre>
     * # ERP 연동이 ERPiU인지 확인
     *   - true : ERPiU
     *   - false : !ERPiU
     * </pre>
     *
     * @return
     * @throws ExceptionNotConnectERP
     */
    public boolean isERPiU() throws ExceptionNotConnectERP {
        try {
            if (this.getErpType() != null && this.getErpType().equals("ERPiU")) {
                return true;
            } else {
                if (this.getErpType() == null || this.getErpType().equals("")) {
                    throw new ExceptionNotConnectERP();
                } else {
                    return false;
                }
            }
        } catch (ExceptionNotConnectERP e) {
            throw e;
        }
    }

    /**
     * <pre>
     * # ERP 연동이 iCUBE인지 확인
     *   - true : iCUBE
     *   - false : !iCUBE
     * </pre>
     *
     * @return
     * @throws ExceptionNotConnectERP
     */
    public boolean isiCUBE() throws ExceptionNotConnectERP {
        try {
            if (this.getErpType() != null && this.getErpType().equals("iCUBE")) {
                return true;
            } else {
                if (this.getErpType() == null || this.getErpType().equals("")) {
                    throw new ExceptionNotConnectERP();
                } else {
                    return false;
                }
            }
        } catch (ExceptionNotConnectERP e) {
            throw e;
        }
    }

    /**
     * <pre>
     * # ERP 연동이 iCUBE G20인지 확인
     *   - true : iCUBE G20
     *   - false : !iCUBE G20
     * </pre>
     *
     * @return
     * @throws ExceptionNotConnectERP
     */
    public boolean isG20() throws ExceptionNotConnectERP {
        try {
            if (this.isiCUBE()) {
                if (this.getG20Yn() != null && this.getG20Yn().equals("Y")) {
                    return true;
                } else {
                    if (this.getG20Yn() == null || this.getG20Yn().equals("")) {
                        throw new ExceptionNotConnectERP();
                    } else {
                        return false;
                    }
                }
            } else {
                return false;
            }
        } catch (ExceptionNotConnectERP e) {
            throw e;
        }
    }

    /**
     * <pre>
     * # 전자결재 연동이 비영리 버전인지 확인
     *   - true : 비영리 전자결재
     *   - false : !비영리 전자결재
     * </pre>
     *
     * @return
     * @throws ExceptionNotFoundLoginSession
     */
    public boolean isEA() throws ExceptionNotFoundLoginSession {
        try {
            if (this.getEaType() != null && this.getEaType().toUpperCase().equals("EA")) {
                return true;
            } else {
                if (this.getEaType() == null || this.getEaType().equals("")) {
                    throw new ExceptionNotFoundLoginSession();
                } else {
                    return false;
                }
            }
        } catch (ExceptionNotFoundLoginSession e) {
            throw e;
        }
    }

    /**
     * <pre>
     * # 전자결재 연동이 영리 버전인지 확인
     *   - true : 영리 전자결재
     *   - false : !영리 전자결재
     * </pre>
     *
     * @return
     * @throws ExceptionNotFoundLoginSession
     */
    public boolean isEAP() throws ExceptionNotFoundLoginSession {
        try {
            if (this.getEaType() != null && this.getEaType().toUpperCase().equals("EAP")) {
                return true;
            } else {
                if (this.getEaType() == null || this.getEaType().equals("")) {
                    throw new ExceptionNotFoundLoginSession();
                } else {
                    return false;
                }
            }
        } catch (ExceptionNotFoundLoginSession e) {
            throw e;
        }
    }

    /**
     * <pre>
     * # 로그인 여부 확인
     *   - true : 로그인 상태
     *   - false : !로그인 상태
     * </pre>
     *
     * @return
     * @throws NotFoundLoginSessionException
     */
    public boolean isLogin() throws NotFoundLoginSessionException {
        if (this._getLogin() == null) {
            return false;
        } else {
            return true;
        }
    }
}
