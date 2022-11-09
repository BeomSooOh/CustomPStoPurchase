package model.common;

import org.apache.logging.log4j.LogManager;
import exception.ExceptionNotConnectERP;

public final class Mconnect {

    /* private --------------------------------------------------------------------------------------------- */
    private final org.apache.logging.log4j.Logger logger = LogManager.getLogger(this.getClass());

    private String erpDatabaseType = ""; /* 사용 DBMS */
    private String erpType = ""; /* 연동시스템 구분 ( iCUBE / ERPiU / ETC ) */
    private String g20Yn = "";
    private String erpCompSeq = "";
    private String erpCompName = "";

    private String _toString() {
        return "Mconnect [erpDatabaseType=" + erpDatabaseType + ", erpType=" + erpType + ", g20Yn=" + g20Yn + ", erpCompSeq=" + erpCompSeq + ", erpCompName=" + erpCompName + "]";
    }

    /* public --------------------------------------------------------------------------------------------- */
    public Mconnect() {
        logger.debug(this._toString());
    }

    /* Setter --------------------------------------------------------------------------------------------- */
    public void setErpDatabaseType(String erpDatabaseType) {
        this.erpDatabaseType = erpDatabaseType;
    }

    public void setErpType(String erpType) {
        this.erpType = erpType;
    }

    public void setG20Yn(String g20Yn) {
        this.g20Yn = g20Yn;
    }

    public void setErpCompSeq(String erpCompSeq) {
        this.erpCompSeq = erpCompSeq;
    }

    public void setErpCompName(String erpCompName) {
        this.erpCompName = erpCompName;
    }

    /* Getter --------------------------------------------------------------------------------------------- */
    public String getErpDatabaseType() {
        return erpDatabaseType;
    }

    public String getErpType() {
        return erpType;
    }

    public String getG20Yn() {
        return g20Yn;
    }

    public String getErpCompSeq() {
        return erpCompSeq;
    }

    public String getErpCompName() {
        return erpCompName;
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
}
