package common.vo.ex;

import java.util.Map;
import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExExpendListVO {

    public ExExpendListVO() {}

    public ExExpendListVO(Map<String, Object> param) {
        this.groupSeq = ObjectToString(param.get("groupSeq"));
        this.compSeq = ObjectToString(param.get("compSeq"));
        this.erpCompSeq = ObjectToString(param.get("erpCompSeq"));
        this.expendSeq = ObjectToString(param.get("expendSeq"));
        this.listSeq = ObjectToString(param.get("listSeq"));

        this.summarySeq = ObjectToInt(param.get("summarySeq"));
        this.authSeq = ObjectToInt(param.get("authSeq"));
        this.vatSeq = ObjectToInt(param.get("vatSeq"));
        this.writeSeq = ObjectToInt(param.get("writeSeq"));
        this.empSeq = ObjectToInt(param.get("empSeq"));
        this.budgetSeq = ObjectToInt(param.get("budgetSeq"));
        this.projectSeq = ObjectToInt(param.get("projectSeq"));
        this.partnerSeq = ObjectToInt(param.get("partnerSeq"));
        this.cardSeq = ObjectToInt(param.get("cardSeq"));
        this.feeSeq = ObjectToInt(param.get("feeSeq"));

        this.authDate = ObjectToString(param.get("authDate"));
        this.note = ObjectToString(param.get("note"));
        this.stdAmt = ObjectToString(param.get("stdAmt"));
        this.taxAmt = ObjectToString(param.get("taxAmt"));
        this.amt = ObjectToString(param.get("amt"));
        this.subStdAmt = ObjectToString(param.get("subStdAmt"));
        this.subTaxAmt = ObjectToString(param.get("subTaxAmt"));
        this.interfaceType = ObjectToString(param.get("interfaceType"));
        this.interfaceMId = ObjectToString(param.get("interfaceMId"));
        this.interfaceDId = ObjectToString(param.get("interfaceDId"));
        this.jsonStr = ObjectToString(param.get("jsonStr"));
        this.formSeq = ObjectToString(param.get("formSeq"));
        this.callback = ObjectToString(param.get("callback"));
        this.createSeq = ObjectToString(param.get("createSeq"));
        this.modifySeq = ObjectToString(param.get("modifySeq"));
        this.autoCalcYn = ObjectToString(param.get("autoCalcYn"));
        this.orderSeq = ObjectToInt(param.get("orderSeq"));
        this.exchangeUnitCode = ObjectToString(param.get("exchangeUnitCode"));
        this.exchangeUnitName = ObjectToString(param.get("exchangeUnitName"));
        this.exchangeRate = ObjectToString(param.get("exchangeRate"));
        this.foreignCurrencyAmount = ObjectToString(param.get("foreignCurrencyAmount"));
        this.foreignAcctYN = ObjectToString(param.get("foreignAcctYN"));
        this.extendStr1 = ObjectToString(param.get("extendStr1"));
        this.extendStr1 = ObjectToString(param.get("extendStr2"));
    }

    private int ObjectToInt(Object o) {
        int result = 0;
        try {
            result = Integer.parseInt(o.toString());
        } catch (Exception ex) {
            result = 0;
        }
        return result;
    }

    private String ObjectToString(Object o) {
        if (o == null) {
            return "";
        } else {
            return o.toString();
        }
    }

    private String groupSeq = commonCode.EMPTYSTR; /* ?????? ????????? */
    private String compSeq = commonCode.EMPTYSEQ; /* ?????? ????????? */
    private String erpCompSeq = commonCode.EMPTYSTR; /* ERP ?????? ????????? */
    private String expendSeq = commonCode.EMPTYSEQ; /* ???????????? ????????? */
    private String listSeq = commonCode.EMPTYSEQ; /* ???????????? ?????? ????????? */
    private int summarySeq = 0; /* ???????????? ????????? */
    private int authSeq = 0; /* ???????????? ????????? */
    private int vatSeq = 0; /* ????????? ????????? */
    private int writeSeq = 0; /* ????????? ????????? */
    private int empSeq = 0; /* ????????? ????????? */
    private int budgetSeq = 0; /* ?????? ????????? */
    private int projectSeq = 0; /* ???????????? ????????? */
    private int partnerSeq = 0; /* ????????? ????????? */
    private int cardSeq = 0; /* ?????? ????????? */
    private int feeSeq = 0; /* ??????????????? ????????? */
    private String authDate = commonCode.EMPTYSTR; /* ???????????? */
    private String note = commonCode.EMPTYSTR; /* ?????? */
    private String stdAmt = commonCode.EMPTYSEQ; /* ???????????? */
    private String taxAmt = commonCode.EMPTYSEQ; /* ???????????? */
    private String amt = commonCode.EMPTYSEQ; /* ???????????? */
    private String subStdAmt = commonCode.EMPTYSEQ; /* ??????????????? */
    private String subTaxAmt = commonCode.EMPTYSEQ; /* ?????? */
    private String interfaceType = commonCode.EMPTYSTR; /* ???????????? ?????? ??? */
    private String interfaceMId = commonCode.EMPTYSEQ; /* ???????????? ????????? ??? */
    private String interfaceDId = commonCode.EMPTYSEQ; /* ???????????? ????????? ??? */
    private String jsonStr = commonCode.EMPTYSTR;
    private String formSeq = commonCode.EMPTYSEQ; /* ?????? ????????? */
    private String callback = commonCode.EMPTYSTR; /* ?????? */
    private String createSeq = commonCode.EMPTYSEQ; /* ????????? */
    private String modifySeq = commonCode.EMPTYSEQ; /* ????????? */
    private String autoCalcYn = "Y"; /* ?????????????????? ?????? ?????? ( Y : ??????, N : ????????? ) */
    private int orderSeq = 0; /* ???????????? */
    private String exchangeUnitCode = commonCode.EMPTYSTR; /* ???????????? */
    private String exchangeUnitName = commonCode.EMPTYSTR; /* ????????? */
    private String exchangeRate = commonCode.EMPTYSEQ; /* ?????? */
    private String foreignCurrencyAmount = commonCode.EMPTYSEQ; /* ???????????? */
    private String foreignAcctYN = commonCode.EMPTYSTR; /* ???????????? ??????(Y/N) */
    private String extendStr1 = "";
    private String extendStr2 = "";

    public String getGroupSeq() {
        return CommonConvert.CommonGetStr(groupSeq);
    }

    public void setGroupSeq(String groupSeq) {
        this.groupSeq = groupSeq;
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

    public int getSummarySeq() {
        return summarySeq;
    }

    public void setSummarySeq(int summarySeq) {
        this.summarySeq = summarySeq;
    }

    public int getAuthSeq() {
        return authSeq;
    }

    public void setAuthSeq(int authSeq) {
        this.authSeq = authSeq;
    }

    public int getVatSeq() {
        return vatSeq;
    }

    public void setVatSeq(int vatSeq) {
        this.vatSeq = vatSeq;
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

    public String getAuthDate() {
        return authDate;
    }

    public void setAuthDate(String authDate) {
        this.authDate = authDate;
    }

    public String getNote() {
        return CommonConvert.CommonGetStr(note);
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStdAmt() {
        return CommonConvert.CommonGetStr(stdAmt);
    }

    public void setStdAmt(String stdAmt) {
        this.stdAmt = stdAmt;
    }

    public String getTaxAmt() {
        return CommonConvert.CommonGetStr(taxAmt);
    }

    public void setTaxAmt(String taxAmt) {
        this.taxAmt = taxAmt;
    }

    public String getAmt() {
        return CommonConvert.CommonGetStr(amt);
    }

    public void setAmt(String amt) {
        this.amt = amt;
    }

    public String getSubStdAmt() {
        return CommonConvert.CommonGetStr(subStdAmt);
    }

    public void setSubStdAmt(String subStdAmt) {
        this.subStdAmt = subStdAmt;
    }

    public String getSubTaxAmt() {
        return CommonConvert.CommonGetStr(subTaxAmt);
    }

    public void setSubTaxAmt(String subTaxAmt) {
        this.subTaxAmt = subTaxAmt;
    }

    public String getInterfaceType() {
        return CommonConvert.CommonGetStr(interfaceType);
    }

    public void setInterfaceType(String interfaceType) {
        this.interfaceType = interfaceType;
    }

    public String getInterfaceMId() {
        return CommonConvert.CommonGetStr(interfaceMId);
    }

    public void setInterfaceMId(String interfaceMId) {
        this.interfaceMId = interfaceMId;
    }

    public String getInterfaceDId() {
        return CommonConvert.CommonGetStr(interfaceDId);
    }

    public void setInterfaceDId(String interfaceDId) {
        this.interfaceDId = interfaceDId;
    }

    public String getJsonStr() {
        return CommonConvert.CommonGetStr(jsonStr);
    }

    public void setJsonStr(String jsonStr) {
        this.jsonStr = jsonStr;
    }

    public String getFormSeq() {
        return CommonConvert.CommonGetStr(formSeq);
    }

    public void setFormSeq(String formSeq) {
        this.formSeq = formSeq;
    }

    public String getCallback() {
        return CommonConvert.CommonGetStr(callback);
    }

    public void setCallback(String callback) {
        this.callback = callback;
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

    public int getFeeSeq() {
        return feeSeq;
    }

    public void setFeeSeq(int feeSeq) {
        this.feeSeq = feeSeq;
    }

    public String getAutoCalcYn() {
        return CommonConvert.CommonGetStr(autoCalcYn);
    }

    public void setAutoCalcYn(String autoCalcYn) {
        this.autoCalcYn = autoCalcYn;
    }

    public int getOrderSeq() {
        return orderSeq;
    }

    public void setOrderSeq(int orderSeq) {
        this.orderSeq = orderSeq;
    }

    public String getExchangeUnitCode() {
        return exchangeUnitCode;
    }

    public void setExchangeUnitCode(String exchangeUnitCode) {
        this.exchangeUnitCode = exchangeUnitCode;
    }

    public String getExchangeUnitName() {
        return exchangeUnitName;
    }

    public void setExchangeUnitName(String exchangeUnitName) {
        this.exchangeUnitName = exchangeUnitName;
    }

    public String getExchangeRate() {
        return exchangeRate;
    }

    public void setExchangeRate(String exchangeRate) {
        this.exchangeRate = exchangeRate;
    }

    public String getForeignCurrencyAmount() {
        return foreignCurrencyAmount;
    }

    public void setForeignCurrencyAmount(String foreignCurrencyAmount) {
        this.foreignCurrencyAmount = foreignCurrencyAmount;
    }

    public String getForeignAcctYN() {
        return foreignAcctYN;
    }

    public void setForeignAcctYN(String foreignAcctYN) {
        this.foreignAcctYN = foreignAcctYN;
    }



    public String getExtendStr1() {
        return extendStr1;
    }

    public void setExtendStr1(String extendStr1) {
        this.extendStr1 = extendStr1;
    }

    public String getExtendStr2() {
        return extendStr2;
    }

    public void setExtendStr2(String extendStr2) {
        this.extendStr2 = extendStr2;
    }

    @Override
    public String toString() {
        return "ExExpendListVO [groupSeq=" + groupSeq + ", compSeq=" + compSeq + ", erpCompSeq=" + erpCompSeq + ", expendSeq=" + expendSeq + ", listSeq=" + listSeq + ", summarySeq=" + summarySeq + ", authSeq=" + authSeq + ", vatSeq=" + vatSeq + ", writeSeq=" + writeSeq + ", empSeq=" + empSeq + ", budgetSeq=" + budgetSeq + ", projectSeq=" + projectSeq + ", partnerSeq=" + partnerSeq + ", cardSeq=" + cardSeq + ", feeSeq=" + feeSeq + ", authDate=" + authDate + ", note=" + note + ", stdAmt=" + stdAmt + ", taxAmt=" + taxAmt + ", amt=" + amt + ", subStdAmt=" + subStdAmt + ", subTaxAmt=" + subTaxAmt + ", interfaceType=" + interfaceType + ", interfaceMId=" + interfaceMId + ", interfaceDId=" + interfaceDId + ", jsonStr=" + jsonStr + ", formSeq=" + formSeq + "" + ", callback=" + callback + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + ", autoCalcYn=" + autoCalcYn + ", orderSeq=" + orderSeq + ", exchangeUnitCode=" + exchangeUnitCode + ", exchangeUnitName=" + exchangeUnitName
                + ", exchangeRate=" + exchangeRate + ", foreignCurrencyAmount=" + foreignCurrencyAmount + ", foreignAcctYN=" + foreignAcctYN + "]";
    }
}
