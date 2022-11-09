package common.vo.batch;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class CommonBatchCmsDataVO {

    /* Bizbox Alpha */
    /* Bizbox Alpha - t_ex_card_aq_tmp */
    private String cardNum = commonCode.EMPTYSTR; /* 카드번호 */
    private String authNum = commonCode.EMPTYSTR; /* 승인번호 */
    private String authDate = commonCode.EMPTYSTR; /* 승인일자 */
    private String authTime = commonCode.EMPTYSTR; /* 승인시간 */
    private String georaeColl = commonCode.EMPTYSTR; /* 거래번호 */
    private String georaeStat = commonCode.EMPTYSTR; /* 거래상태 */
    private String georaeCand = commonCode.EMPTYSTR; /* 승인취소일자 */
    private String requestAmount = commonCode.EMPTYSEQ; /* 총금액 */
    private String amtAmount = commonCode.EMPTYSEQ; /* 공급가액 */
    private String vatAmount = commonCode.EMPTYSEQ; /* 부가세액 */
    private String serAmount = commonCode.EMPTYSEQ; /* 서비스금액 */
    private String freAmount = commonCode.EMPTYSEQ;
    private String amtMdAmount = commonCode.EMPTYSEQ; /* 공급가액 */
    private String vatMdAmount = commonCode.EMPTYSEQ; /* 부가세액 */
    private String georaeGukga = commonCode.EMPTYSTR; /* 거래국가 */
    private String forAmount = commonCode.EMPTYSEQ;
    private String usdAmount = commonCode.EMPTYSEQ;
    private String mercName = commonCode.EMPTYSTR; /* 거래처명 */
    private String mercSaupNo = commonCode.EMPTYSTR; /* 거래처사업자등록번호 */
    private String mercAddr = commonCode.EMPTYSTR; /* 거래처주소 */
    private String mercRepr = commonCode.EMPTYSTR; /* 거래처대표자명 */
    private String mercTel = commonCode.EMPTYSTR; /* 거래처연락처 */
    private String mercZip = commonCode.EMPTYSTR; /* 거래처우편번호 */
    private String mccName = commonCode.EMPTYSTR;
    private String mccCode = commonCode.EMPTYSTR;
    private String mccStat = commonCode.EMPTYSTR;
    private String vatStat = commonCode.EMPTYSTR;
    private String gongjeNoChk = commonCode.EMPTYSTR; /* 기본값 : N */
    private String abroad = commonCode.EMPTYSTR; /* 해외사용구분 */ /* 기본값 : A */
    private String editedAction = commonCode.EMPTYSTR; /* 기본값 : "" */
    /* ERPiU */
    private String acctNo = commonCode.EMPTYSTR; /* 카드번호 */
    private String bankCode = commonCode.EMPTYSTR; /* 금융기관 코드 */
    private String tradeDate = commonCode.EMPTYSTR; /* 승인일자 */
    private String tradeTime = commonCode.EMPTYSTR; /* 승인시간 */
    private String seq = commonCode.EMPTYSEQ; /* 순번 */
    private String aquiRate = "0.0000"; /* 환율 */
    /* iCUBE */
    /* iCUBE - 하나은행 */
    private String cardNo = commonCode.EMPTYSTR;
    private String apprDate = commonCode.EMPTYSTR;
    private String apprNo = commonCode.EMPTYSEQ;
    private String apprAmt = commonCode.EMPTYSEQ;
    private String apprSeq = commonCode.EMPTYSEQ;
    private String cmsType = commonCode.EMPTYSTR;
    /* private String erpCompSeq = commonCode.EMPTYSTR; */
    /* private String regNb = commonCode.EMPTYSTR; */
    /* private String cmsType = commonCode.EMPTYSTR; */
    /* iCUBE - 기업은행 */
    /* private String erpCompSeq = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String regNb = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String bankCode = commonCode.EMPTYSEQ; *//* ERPiU 포함 */
    /* private String cardNo = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* privaet String apprDate=commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* privaet String apprSeq=commonCode.EMPTYSEQ; *//* iCUBE - 하나은행 포함 */
    /* private String cmsType = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* iCUBE - 국민은행 */
    /* private String regNb =commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String bankCode = commonCode.EMPTYSTR; *//* ERPiU 포함 */
    /* private String cardNo = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String apprDate = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String apprSeq = commonCode.EMPTYSEQ; *//* iCUBE - 하나은행 포함 */
    /* private String cmsType = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* iCUBE - 농협은행 */
    /* private String erpCompSeq = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String regNb = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String bankCode = commonCode.EMPTYSTR; *//* ERPiU 포함 */
    /* private String cardNo = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String apprDate = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String apprSeq = commonCode.EMPTYSEQ; *//* iCUBE - 하나은행 포함 */
    /* private String cmsType = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* iCUBE - 신한은행 */
    private String cardSeq = commonCode.EMPTYSEQ;
    private String apprBuyDate = commonCode.EMPTYSTR;
    private String apprBuyNbSeq = commonCode.EMPTYSEQ;
    /* private String apprDate = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String cmsType = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* iCUBE - 우리은행 */
    /* private String erpCompSeq = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String regNb = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    private String trnxId = commonCode.EMPTYSTR;
    private String ifKey = commonCode.EMPTYSTR;
    private String apprClass = commonCode.EMPTYSTR;
    /* private String cmsType = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String cardNo = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* private String apprNo = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    private String transDate = commonCode.EMPTYSTR;
    /* private String cmsType = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    /* iCUBE - 스마트증빙 */
    /* private String erpCompSeq = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    private String issDt = commonCode.EMPTYSTR;
    private String issSq = commonCode.EMPTYSEQ;

    private String groupSeq = commonCode.EMPTYSEQ;
    private String DB_NEOS = commonCode.EMPTYSEQ;
    private String DB_MOBILE = commonCode.EMPTYSEQ;
    private String DB_EDMS = commonCode.EMPTYSEQ;

    private String PK1 = "";
    private String PK2 = "";
    private String PK3 = "";
    private String PK4 = "";
    private String PK5 = "";
    private String PK6 = "";
    private String PK7 = "";
    private String BANK_NM = "";
    private String CANCEL_YN = "";
    private String CARD_NO = "";
    private String APPR_NO = "";
    private String APPR_DT = "";
    private String APPR_TM = "";
    private String CARD_TY = "";
    private String CUR_CD = "";
    private String APPRTOT_AM = "";
    private String SUPPLY_AM = "";
    private String VAT_AM = "";
    private String SERVICE_AM = "";
    private String FEE_AM = "";
    private String EXCH_YN = "";
    private String EXCH_RT = "";
    private String EXCH_APPRTOT_AM = "";
    private String INST_TY = "";
    private String MONTHLY_PLAN = "";
    private String CHAIN_REG_NO = "";
    private String CHAIN_NO = "";
    private String CHAIN_NM = "";
    private String CHAIN_CEO_NM = "";
    private String CHAIN_TEL = "";
    private String CHAIN_ZIP_CD = "";
    private String CHAIN_ADDR1 = "";
    private String CHAIN_ADDR2 = "";
    private String BUSINESS_NM = "";
    private String DEDUCT_YN = "";
    private String TAX_TY = "";
    private String CHAIN_CESS_DT = "";
    private String MEMO_DC = "";
    private String EBANK_KEY = "";
    private String CO_CD = "";
    private String ISS_DT = "";
    private String ISS_SQ = "";
    private String SYNC_ID = "";

    /* private String cmsType = commonCode.EMPTYSTR; *//* iCUBE - 하나은행 포함 */
    public String getCardNum() {
        return CommonConvert.CommonGetStr(cardNum);
    }

    public void setCardNum(String cardNum) {
        this.cardNum = cardNum;
    }

    public String getAuthNum() {
        return CommonConvert.CommonGetStr(authNum);
    }

    public void setAuthNum(String authNum) {
        this.authNum = authNum;
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

    public String getGeoraeColl() {
        return CommonConvert.CommonGetStr(georaeColl);
    }

    public void setGeoraeColl(String georaeColl) {
        this.georaeColl = georaeColl;
    }

    public String getGeoraeStat() {
        return CommonConvert.CommonGetStr(georaeStat);
    }

    public void setGeoraeStat(String georaeStat) {
        this.georaeStat = georaeStat;
    }

    public String getGeoraeCand() {
        return CommonConvert.CommonGetStr(georaeCand);
    }

    public void setGeoraeCand(String georaeCand) {
        this.georaeCand = georaeCand;
    }

    public String getRequestAmount() {
        return CommonConvert.CommonGetStr(requestAmount);
    }

    public void setRequestAmount(String requestAmount) {
        this.requestAmount = requestAmount;
    }

    public String getAmtAmount() {
        return CommonConvert.CommonGetStr(amtAmount);
    }

    public void setAmtAmount(String amtAmount) {
        this.amtAmount = amtAmount;
    }

    public String getVatAmount() {
        return CommonConvert.CommonGetStr(vatAmount);
    }

    public void setVatAmount(String vatAmount) {
        this.vatAmount = vatAmount;
    }

    public String getSerAmount() {
        return CommonConvert.CommonGetStr(serAmount);
    }

    public void setSerAmount(String serAmount) {
        this.serAmount = serAmount;
    }

    public String getFreAmount() {
        return CommonConvert.CommonGetStr(freAmount);
    }

    public void setFreAmount(String freAmount) {
        this.freAmount = freAmount;
    }

    public String getAmtMdAmount() {
        return CommonConvert.CommonGetStr(amtMdAmount);
    }

    public void setAmtMdAmount(String amtMdAmount) {
        this.amtMdAmount = amtMdAmount;
    }

    public String getVatMdAmount() {
        return CommonConvert.CommonGetStr(vatMdAmount);
    }

    public void setVatMdAmount(String vatMdAmount) {
        this.vatMdAmount = vatMdAmount;
    }

    public String getGeoraeGukga() {
        return CommonConvert.CommonGetStr(georaeGukga);
    }

    public void setGeoraeGukga(String georaeGukga) {
        this.georaeGukga = georaeGukga;
    }

    public String getForAmount() {
        return CommonConvert.CommonGetStr(forAmount);
    }

    public void setForAmount(String forAmount) {
        this.forAmount = forAmount;
    }

    public String getUsdAmount() {
        return CommonConvert.CommonGetStr(usdAmount);
    }

    public void setUsdAmount(String usdAmount) {
        this.usdAmount = usdAmount;
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

    public String getMercAddr() {
        return CommonConvert.CommonGetStr(mercAddr);
    }

    public void setMercAddr(String mercAddr) {
        this.mercAddr = mercAddr;
    }

    public String getMercRepr() {
        return CommonConvert.CommonGetStr(mercRepr);
    }

    public void setMercRepr(String mercRepr) {
        this.mercRepr = mercRepr;
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

    public String getMccName() {
        return CommonConvert.CommonGetStr(mccName);
    }

    public void setMccName(String mccName) {
        this.mccName = mccName;
    }

    public String getMccCode() {
        return CommonConvert.CommonGetStr(mccCode);
    }

    public void setMccCode(String mccCode) {
        this.mccCode = mccCode;
    }

    public String getMccStat() {
        return CommonConvert.CommonGetStr(mccStat);
    }

    public void setMccStat(String mccStat) {
        this.mccStat = mccStat;
    }

    public String getVatStat() {
        return CommonConvert.CommonGetStr(vatStat);
    }

    public void setVatStat(String vatStat) {
        this.vatStat = vatStat;
    }

    public String getGongjeNoChk() {
        return CommonConvert.CommonGetStr(gongjeNoChk);
    }

    public void setGongjeNoChk(String gongjeNoChk) {
        this.gongjeNoChk = gongjeNoChk;
    }

    public String getAbroad() {
        return CommonConvert.CommonGetStr(abroad);
    }

    public void setAbroad(String abroad) {
        this.abroad = abroad;
    }

    public String getEditedAction() {
        return CommonConvert.CommonGetStr(editedAction);
    }

    public void setEditedAction(String editedAction) {
        this.editedAction = editedAction;
    }

    public String getAcctNo() {
        return CommonConvert.CommonGetStr(acctNo);
    }

    public void setAcctNo(String acctNo) {
        this.acctNo = acctNo;
    }

    public String getBankCode() {
        return CommonConvert.CommonGetStr(bankCode);
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public String getTradeDate() {
        return CommonConvert.CommonGetStr(tradeDate);
    }

    public void setTradeDate(String tradeDate) {
        this.tradeDate = tradeDate;
    }

    public String getTradeTime() {
        return CommonConvert.CommonGetStr(tradeTime);
    }

    public void setTradeTime(String tradeTime) {
        this.tradeTime = tradeTime;
    }

    public String getSeq() {
        return CommonConvert.CommonGetStr(seq);
    }

    public void setSeq(String seq) {
        this.seq = seq;
    }

    public String getAquiRate() {
        return aquiRate;
    }

    public void setAquiRate(String aquiRate) {
        this.aquiRate = aquiRate;
    }

    public String getCardNo() {
        return CommonConvert.CommonGetStr(cardNo);
    }

    public void setCardNo(String cardNo) {
        this.cardNo = cardNo;
    }

    public String getApprDate() {
        return CommonConvert.CommonGetStr(apprDate);
    }

    public void setApprDate(String apprDate) {
        this.apprDate = apprDate;
    }

    public String getApprNo() {
        return CommonConvert.CommonGetStr(apprNo);
    }

    public void setApprNo(String apprNo) {
        this.apprNo = apprNo;
    }

    public String getApprAmt() {
        return CommonConvert.CommonGetStr(apprAmt);
    }

    public void setApprAmt(String apprAmt) {
        this.apprAmt = apprAmt;
    }

    public String getApprSeq() {
        return CommonConvert.CommonGetStr(apprSeq);
    }

    public void setApprSeq(String apprSeq) {
        this.apprSeq = apprSeq;
    }

    public String getCmsType() {
        return CommonConvert.CommonGetStr(cmsType);
    }

    public void setCmsType(String cmsType) {
        this.cmsType = cmsType;
    }

    public String getCardSeq() {
        return CommonConvert.CommonGetStr(cardSeq);
    }

    public void setCardSeq(String cardSeq) {
        this.cardSeq = cardSeq;
    }

    public String getApprBuyDate() {
        return CommonConvert.CommonGetStr(apprBuyDate);
    }

    public void setApprBuyDate(String apprBuyDate) {
        this.apprBuyDate = apprBuyDate;
    }

    public String getApprBuyNbSeq() {
        return CommonConvert.CommonGetStr(apprBuyNbSeq);
    }

    public void setApprBuyNbSeq(String apprBuyNbSeq) {
        this.apprBuyNbSeq = apprBuyNbSeq;
    }

    public String getTrnxId() {
        return CommonConvert.CommonGetStr(trnxId);
    }

    public void setTrnxId(String trnxId) {
        this.trnxId = trnxId;
    }

    public String getIfKey() {
        return CommonConvert.CommonGetStr(ifKey);
    }

    public void setIfKey(String ifKey) {
        this.ifKey = ifKey;
    }

    public String getApprClass() {
        return CommonConvert.CommonGetStr(apprClass);
    }

    public void setApprClass(String apprClass) {
        this.apprClass = apprClass;
    }

    public String getTransDate() {
        return CommonConvert.CommonGetStr(transDate);
    }

    public void setTransDate(String transDate) {
        this.transDate = transDate;
    }

    public String getIssDt() {
        return CommonConvert.CommonGetStr(issDt);
    }

    public void setIssDt(String issDt) {
        this.issDt = issDt;
    }

    public String getIssSq() {
        return CommonConvert.CommonGetStr(issSq);
    }

    public void setIssSq(String issSq) {
        this.issSq = issSq;
    }

    public String getGroupSeq() {
        return groupSeq;
    }

    public void setGroupSeq(String groupSeq) {
        this.groupSeq = groupSeq;
    }

    public String getDB_NEOS() {
        return CommonConvert.CommonGetStr(DB_NEOS);
    }

    public void setDB_NEOS(String dbNeos) {
        DB_NEOS = dbNeos + ".";
    }

    public String getDB_MOBILE() {
        return CommonConvert.CommonGetStr(DB_MOBILE);
    }

    public void setDB_MOBILE(String dbMobile) {
        DB_MOBILE = dbMobile + ".";
    }

    public String getDB_EDMS() {
        return CommonConvert.CommonGetStr(DB_EDMS);
    }

    public void setDB_EDMS(String dbEdms) {
        DB_EDMS = dbEdms + ".";
    }

    public String getPK1() {
        return PK1;
    }

    public void setPK1(String pK1) {
        PK1 = pK1;
    }

    public String getPK2() {
        return PK2;
    }

    public void setPK2(String pK2) {
        PK2 = pK2;
    }

    public String getPK3() {
        return PK3;
    }

    public void setPK3(String pK3) {
        PK3 = pK3;
    }

    public String getPK4() {
        return PK4;
    }

    public void setPK4(String pK4) {
        PK4 = pK4;
    }

    public String getPK5() {
        return PK5;
    }

    public void setPK5(String pK5) {
        PK5 = pK5;
    }

    public String getPK6() {
        return PK6;
    }

    public void setPK6(String pK6) {
        PK6 = pK6;
    }

    public String getPK7() {
        return PK7;
    }

    public void setPK7(String pK7) {
        PK7 = pK7;
    }

    public String getBANK_NM() {
        return BANK_NM;
    }

    public void setBANK_NM(String bankNm) {
        BANK_NM = bankNm;
    }

    public String getCANCEL_YN() {
        return CANCEL_YN;
    }

    public void setCANCEL_YN(String cancelYn) {
        CANCEL_YN = cancelYn;
    }

    public String getCARD_NO() {
        return CARD_NO;
    }

    public void setCARD_NO(String cardNo) {
        CARD_NO = cardNo;
    }

    public String getAPPR_NO() {
        return APPR_NO;
    }

    public void setAPPR_NO(String apprNo) {
        APPR_NO = apprNo;
    }

    public String getAPPR_DT() {
        return APPR_DT;
    }

    public void setAPPR_DT(String apprDt) {
        APPR_DT = apprDt;
    }

    public String getAPPR_TM() {
        return APPR_TM;
    }

    public void setAPPR_TM(String apprTm) {
        APPR_TM = apprTm;
    }

    public String getCARD_TY() {
        return CARD_TY;
    }

    public void setCARD_TY(String cardTy) {
        CARD_TY = cardTy;
    }

    public String getCUR_CD() {
        return CUR_CD;
    }

    public void setCUR_CD(String curCd) {
        CUR_CD = curCd;
    }

    public String getAPPRTOT_AM() {
        return APPRTOT_AM;
    }

    public void setAPPRTOT_AM(String apprtotAm) {
        APPRTOT_AM = apprtotAm;
    }

    public String getSUPPLY_AM() {
        return SUPPLY_AM;
    }

    public void setSUPPLY_AM(String supplyAm) {
        SUPPLY_AM = supplyAm;
    }

    public String getVAT_AM() {
        return VAT_AM;
    }

    public void setVAT_AM(String vatAm) {
        VAT_AM = vatAm;
    }

    public String getSERVICE_AM() {
        return SERVICE_AM;
    }

    public void setSERVICE_AM(String serviceAm) {
        SERVICE_AM = serviceAm;
    }

    public String getFEE_AM() {
        return FEE_AM;
    }

    public void setFEE_AM(String feeAm) {
        FEE_AM = feeAm;
    }

    public String getEXCH_YN() {
        return EXCH_YN;
    }

    public void setEXCH_YN(String exchYn) {
        EXCH_YN = exchYn;
    }

    public String getEXCH_RT() {
        return EXCH_RT;
    }

    public void setEXCH_RT(String exchRt) {
        EXCH_RT = exchRt;
    }

    public String getEXCH_APPRTOT_AM() {
        return EXCH_APPRTOT_AM;
    }

    public void setEXCH_APPRTOT_AM(String exchApprtotAm) {
        EXCH_APPRTOT_AM = exchApprtotAm;
    }

    public String getINST_TY() {
        return INST_TY;
    }

    public void setINST_TY(String instTy) {
        INST_TY = instTy;
    }

    public String getMONTHLY_PLAN() {
        return MONTHLY_PLAN;
    }

    public void setMONTHLY_PLAN(String monthlyPlan) {
        MONTHLY_PLAN = monthlyPlan;
    }

    public String getCHAIN_REG_NO() {
        return CHAIN_REG_NO;
    }

    public void setCHAIN_REG_NO(String chainRegNo) {
        CHAIN_REG_NO = chainRegNo;
    }

    public String getCHAIN_NO() {
        return CHAIN_NO;
    }

    public void setCHAIN_NO(String chainNo) {
        CHAIN_NO = chainNo;
    }

    public String getCHAIN_NM() {
        return CHAIN_NM;
    }

    public void setCHAIN_NM(String chainNm) {
        CHAIN_NM = chainNm;
    }

    public String getCHAIN_CEO_NM() {
        return CHAIN_CEO_NM;
    }

    public void setCHAIN_CEO_NM(String chainCeoNm) {
        CHAIN_CEO_NM = chainCeoNm;
    }

    public String getCHAIN_TEL() {
        return CHAIN_TEL;
    }

    public void setCHAIN_TEL(String chainTel) {
        CHAIN_TEL = chainTel;
    }

    public String getCHAIN_ZIP_CD() {
        return CHAIN_ZIP_CD;
    }

    public void setCHAIN_ZIP_CD(String chainZipCd) {
        CHAIN_ZIP_CD = chainZipCd;
    }

    public String getCHAIN_ADDR1() {
        return CHAIN_ADDR1;
    }

    public void setCHAIN_ADDR1(String chainAddr1) {
        CHAIN_ADDR1 = chainAddr1;
    }

    public String getCHAIN_ADDR2() {
        return CHAIN_ADDR2;
    }

    public void setCHAIN_ADDR2(String chainAddr2) {
        CHAIN_ADDR2 = chainAddr2;
    }

    public String getBUSINESS_NM() {
        return BUSINESS_NM;
    }

    public void setBUSINESS_NM(String businessNm) {
        BUSINESS_NM = businessNm;
    }

    public String getDEDUCT_YN() {
        return DEDUCT_YN;
    }

    public void setDEDUCT_YN(String deductYn) {
        DEDUCT_YN = deductYn;
    }

    public String getTAX_TY() {
        return TAX_TY;
    }

    public void setTAX_TY(String taxTy) {
        TAX_TY = taxTy;
    }

    public String getCHAIN_CESS_DT() {
        return CHAIN_CESS_DT;
    }

    public void setCHAIN_CESS_DT(String chainCessDt) {
        CHAIN_CESS_DT = chainCessDt;
    }

    public String getMEMO_DC() {
        return MEMO_DC;
    }

    public void setMEMO_DC(String memoDc) {
        MEMO_DC = memoDc;
    }

    public String getEBANK_KEY() {
        return EBANK_KEY;
    }

    public void setEBANK_KEY(String ebankKey) {
        EBANK_KEY = ebankKey;
    }

    public String getCO_CD() {
        return CO_CD;
    }

    public void setCO_CD(String coCd) {
        CO_CD = coCd;
    }

    public String getISS_DT() {
        return ISS_DT;
    }

    public void setISS_DT(String issDt) {
        ISS_DT = issDt;
    }

    public String getISS_SQ() {
        return ISS_SQ;
    }

    public void setISS_SQ(String issSq) {
        ISS_SQ = issSq;
    }

    public String getSYNC_ID() {
        return SYNC_ID;
    }

    public void setSYNC_ID(String syncId) {
        SYNC_ID = syncId;
    }

    @Override
    public String toString() {
        return "CommonBatchCmsDataVO [cardNum=" + cardNum + ", authNum=" + authNum + ", authDate=" + authDate + ", authTime=" + authTime + ", georaeColl=" + georaeColl + ", georaeStat=" + georaeStat + ", georaeCand=" + georaeCand + ", requestAmount=" + requestAmount + ", amtAmount=" + amtAmount + ", vatAmount=" + vatAmount + ", serAmount=" + serAmount + ", freAmount=" + freAmount + ", amtMdAmount=" + amtMdAmount + ", vatMdAmount=" + vatMdAmount + ", georaeGukga=" + georaeGukga + ", forAmount=" + forAmount + ", usdAmount=" + usdAmount + ", mercName=" + mercName + ", mercSaupNo=" + mercSaupNo + ", mercAddr=" + mercAddr + ", mercRepr=" + mercRepr + ", mercTel=" + mercTel + ", mercZip=" + mercZip + ", mccName=" + mccName + ", mccCode=" + mccCode + ", mccStat=" + mccStat + ", vatStat=" + vatStat + ", gongjeNoChk=" + gongjeNoChk + ", abroad=" + abroad + ", editedAction=" + editedAction + ", acctNo=" + acctNo + ", bankCode=" + bankCode + ", tradeDate=" + tradeDate + ", tradeTime="
                + tradeTime + ", seq=" + seq + ", aquiRate=" + aquiRate + ", cardNo=" + cardNo + ", apprDate=" + apprDate + ", apprNo=" + apprNo + ", apprAmt=" + apprAmt + ", apprSeq=" + apprSeq + ", cmsType=" + cmsType + ", cardSeq=" + cardSeq + ", apprBuyDate=" + apprBuyDate + ", apprBuyNbSeq=" + apprBuyNbSeq + ", trnxId=" + trnxId + ", ifKey=" + ifKey + ", apprClass=" + apprClass + ", transDate=" + transDate + ", issDt=" + issDt + ", issSq=" + issSq + ", groupSeq=" + groupSeq + ", DB_NEOS=" + DB_NEOS + ", DB_MOBILE=" + DB_MOBILE + ", DB_EDMS=" + DB_EDMS + ", PK1=" + PK1 + ", PK2=" + PK2 + ", PK3=" + PK3 + ", PK4=" + PK4 + ", PK5=" + PK5 + ", PK6=" + PK6 + ", PK7=" + PK7 + ", BANK_NM=" + BANK_NM + ", CANCEL_YN=" + CANCEL_YN + ", CARD_NO=" + CARD_NO + ", APPR_NO=" + APPR_NO + ", APPR_DT=" + APPR_DT + ", APPR_TM=" + APPR_TM + ", CARD_TY=" + CARD_TY + ", CUR_CD=" + CUR_CD + ", APPRTOT_AM=" + APPRTOT_AM + ", SUPPLY_AM=" + SUPPLY_AM + ", VAT_AM=" + VAT_AM + ", SERVICE_AM=" + SERVICE_AM
                + ", FEE_AM=" + FEE_AM + ", EXCH_YN=" + EXCH_YN + ", EXCH_RT=" + EXCH_RT + ", EXCH_APPRTOT_AM=" + EXCH_APPRTOT_AM + ", INST_TY=" + INST_TY + ", MONTHLY_PLAN=" + MONTHLY_PLAN + ", CHAIN_REG_NO=" + CHAIN_REG_NO + ", CHAIN_NO=" + CHAIN_NO + ", CHAIN_NM=" + CHAIN_NM + ", CHAIN_CEO_NM=" + CHAIN_CEO_NM + ", CHAIN_TEL=" + CHAIN_TEL + ", CHAIN_ZIP_CD=" + CHAIN_ZIP_CD + ", CHAIN_ADDR1=" + CHAIN_ADDR1 + ", CHAIN_ADDR2=" + CHAIN_ADDR2 + ", BUSINESS_NM=" + BUSINESS_NM + ", DEDUCT_YN=" + DEDUCT_YN + ", TAX_TY=" + TAX_TY + ", CHAIN_CESS_DT=" + CHAIN_CESS_DT + ", MEMO_DC=" + MEMO_DC + ", CO_CD=" + CO_CD + ", ISS_DT=" + ISS_DT + ", ISS_SQ=" + ISS_SQ + ", SYNC_ID=" + SYNC_ID + "]";
    }
        
    public String makeTempCardData() {
    	replaceCardData();
    	return ", ('" + ISS_DT + "','" + ISS_SQ + "','" + CARD_NO + "','" + APPR_NO + "','" + APPR_DT + "','" + APPR_TM + "','" + "GEORAECOLL" + "','" + CANCEL_YN + "','" + "" + "','" + APPRTOT_AM + "','" + SUPPLY_AM + "','" + VAT_AM + "','" + SERVICE_AM + "','" + FEE_AM + "','" + SUPPLY_AM + "','" + VAT_AM + "','" + CUR_CD + "','" + "0" + "','" + "0" + "','" + CHAIN_NM + "','" + CHAIN_REG_NO + "','" + CHAIN_ADDR1 + " " + CHAIN_ADDR2 + "','" + CHAIN_CEO_NM + "','" + CHAIN_TEL + "','" + CHAIN_ZIP_CD + "','" + BUSINESS_NM + "','" + TAX_TY + "','" + "" + "','" + "" + "','" + DEDUCT_YN + "','" + CUR_CD + "','" + "0" + "','"+ PK1 + "','" + PK2 + "','" + PK3 + "','" + PK4 + "','" + PK5 + "','" + PK6 + "','" + PK7 + "') ";    
    }
    
    private void replaceCardData() {
    	this.CHAIN_NM = this.CHAIN_NM.replace("'", "`");
    	this.CHAIN_ADDR1 = this.CHAIN_ADDR1.replace("'", "`");
    	this.CHAIN_ADDR2 = this.CHAIN_ADDR2.replace("'", "`");
    	this.CHAIN_CEO_NM = this.CHAIN_CEO_NM.replace("'", "`");
    	this.BUSINESS_NM = this.BUSINESS_NM.replace("'", "`");
    	this.APPR_TM = this.APPR_TM.replace(":", "");
    }
}
