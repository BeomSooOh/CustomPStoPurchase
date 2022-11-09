package common.vo.ex.ERPiU;

import java.util.HashMap;
import java.util.Map;
import common.helper.exception.NotFoundLoginSessionException;
import common.vo.common.BizboxCmm;

public class ERPiUAccSeq extends BizboxCmm {

    // ERPiU 회계 기수 정보 관리
    private String noAccSeq = ""; // 회계 기수
    private String dtFrom = ""; // 기수 시작일
    private String dtTo = ""; // 기수 종료일

    public String getNoAccSeq() {
        return noAccSeq;
    }

    public void setNoAccSeq(String noAccSeq) {
        this.noAccSeq = noAccSeq;
    }

    public String getDtFrom() {
        return dtFrom;
    }

    public void setDtFrom(String dtFrom) {
        this.dtFrom = dtFrom;
    }

    public String getDtTo() {
        return dtTo;
    }

    public void setDtTo(String dtTo) {
        this.dtTo = dtTo;
    }

    @Override
    public String toString() {
        return "ERPiUAccSeq [noAccSeq=" + noAccSeq + ", dtFrom=" + dtFrom + ", dtTo=" + dtTo + "]";
    }

    /* ==================================================================================================== */

    public ERPiUAccSeq() throws NotFoundLoginSessionException {
        this.setLogin();
    }

    public Map<String, Object> getMap() {
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("resultCode", this.getResultCode());
        map.put("resultName", this.getResultName());
        map.put("groupSeq", this.getGroupSeq());
        map.put("compSeq", this.getCompSeq());
        map.put("deptSeq", this.getDeptSeq());
        map.put("empSeq", this.getEmpSeq());
        map.put("erpCompSeq", this.getErpCompSeq());
        map.put("erpEmpSeq", this.getErpEmpSeq());
        map.put("noAccSeq", this.getNoAccSeq());
        map.put("dtFrom", this.getDtFrom());
        map.put("dtTo", this.getDtTo());

        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.setNoAccSeq(map.get("noAccSeq").toString());
        this.setDtFrom(map.get("dtFrom").toString());
        this.setDtTo(map.get("dtTo").toString());
    }
}
