package common.vo.ex;

import common.helper.convert.CommonConvert;
import common.vo.common.CommonInterface.commonCode;


public class ExCodeETaxVO {

    private String compSeq = commonCode.EMPTYSTR; /* BizboxA *//* 회사 시퀀스 */
    private String erpCompSeq = commonCode.EMPTYSTR; /* iCUBE *//* ERPiU *//* 회사 시퀀스 */
    private String issNo = commonCode.EMPTYSTR; /* iCUBE *//* 승인번호 */
    private String hometaxIssNo = commonCode.EMPTYSTR; /* ERPiU *//* 국세청 번호 */
    private String coCd = commonCode.EMPTYSTR; /* iCUBE *//* 회사코드 */
    private String divCd = commonCode.EMPTYSTR; /* iCUBE *//* 사업장코드 */
    private String trCd = commonCode.EMPTYSTR; /* iCUBE *//* 거래처코드 */
    private String issDt = commonCode.EMPTYSTR; /* iCUBE *//* 작성일자 >> EXCEL :B열 (세금계산서 작성일자에 찍히는 날짜=전표일자isuDt?,신고기준일taxDt? ) */
    private String taxTy = commonCode.EMPTYSTR; /* iCUBE *//* 매입매출구분 >> 1.매출 2.매입 3.면세매출 4.면세매입 */
    private String isuDt = commonCode.EMPTYSTR; /* iCUBE *//* 발급일자 >> EXCEL :D열 (국세청에 들어온 날짜) */
    private String divregNb = commonCode.EMPTYSTR; /* iCUBE *//* 사업장사업자번호 */
    private String divsubNb = commonCode.EMPTYSTR; /* iCUBE *//* 사업장종사업장번호 */
    private String divNm = commonCode.EMPTYSTR; /* iCUBE *//* 사업장상호명 */
    private String divceoNm = commonCode.EMPTYSTR; /* iCUBE *//* 사업장대표자명 */
    private String trregNb = commonCode.EMPTYSTR; /* iCUBE *//* 거래처사업자번호 */
    private String trsubNb = commonCode.EMPTYSTR; /* iCUBE *//* 거래처종사업장번호 */
    private String trNm = commonCode.EMPTYSTR; /* iCUBE *//* 거래처명 */
    private String trceoNm = commonCode.EMPTYSTR; /* iCUBE *//* 거래처대표자명 */
    private String sumAm = "0.00"; /* iCUBE *//* 합계액 */
    private String amt = "0.00"; /* ERPiU *//* 합계액 */
    private String supAm = "0.00"; /* iCUBE *//* 공급가액 */
    private String am = "0.00"; /* ERPiU *//* 공급가액 */
    private String vatAm = "0.00"; /* iCUBE *//* 부가세액 */
    private String amVat = "0.00"; /* ERPiU *//* 부가세액 */
    private String etaxTy = commonCode.EMPTYSTR; /* iCUBE *//* 세금계산서구분 >> 1.일반, 2.수정 */
    private String etaxFg = commonCode.EMPTYSTR; /* iCUBE *//* 전자세금계산서종류 >> 1.일반, 1.일반(수정), 2.영세율, 2.영세율(수정), 3.위수탁, 4.수입, 5.위수탁영세율 */
    private String sendFg = commonCode.EMPTYSTR; /* iCUBE *//* 발행유형 >> 1.인터넷발행,2.ARS발행,3.VAN발행,4.ASP발행,5.자체발행,6.지로발행,7.대리발행 */
    private String dummy1 = commonCode.EMPTYSTR; /* iCUBE *//* 비고 */
    private String dummy2 = commonCode.EMPTYSTR; /* iCUBE *//* 기타(영수/청구 구분) >> 영수 OR 청구 */
    private String issYmd = commonCode.EMPTYSTR; /* iCUBE *//* 전송일자 */
    private String itemDc = commonCode.EMPTYSTR; /* iCUBE *//* 품목명 */
    private String addtaxCd = commonCode.EMPTYSTR; /* iCUBE *//* 가산세코드 >> 0.해당없음. 1.지연발급, 2.미발급, 3.지연수취(공제),4.지연수취(불공제), 5.지연전송, 6.미전송 */
    private String addtaxAm = "0.00"; /* iCUBE *//* 가산세액 */
    private String addrteRt = "0.00"; /* iCUBE *//* 세율 */
    private String emailDc = commonCode.EMPTYSTR; /* iCUBE *//* 공급자이메일 */
    private String trchargeEmail = commonCode.EMPTYSTR; /* iCUBE *//* 공급받는자이메일 */
    private String sendYN = commonCode.EMPTYNO; /* 상신여부 */
    private String note = commonCode.EMPTYSTR; /* 적요 */
    private int syncId = 0;
    private int expendEmpSeq = 0; /* 사원자 시퀀스 */
    private String empSeq = commonCode.EMPTYSTR; /* 사용자 시퀀스 */
    private String empName = commonCode.EMPTYSTR; /* 사용자 명 */
    private String deptSeq = commonCode.EMPTYSTR; /* 부서 시퀀스 */
    private String deptName = commonCode.EMPTYSTR; /* 부서 명 */
    private String erpPcSeq = commonCode.EMPTYSEQ; /* 사용자 회계단위 시퀀스 */
    private String erpPcName = commonCode.EMPTYSTR; /* 사용자 회계단위 명 */
    private String erpCcSeq = commonCode.EMPTYSEQ; /* 사용자 코스트센터 시퀀스 */
    private String erpCcName = commonCode.EMPTYSTR; /* 사용자 코스트센터 명 */
    private int expendSummarySeq = 0; /* 표준적요 시퀀스 */
    private String summaryCode = commonCode.EMPTYSTR; /* 표준적요 코드 */
    private String summaryName = commonCode.EMPTYSTR; /* 표준적요 명칭 */
    private int expendAuthSeq = 0; /* 증빙유형 시퀀스 */
    private String authDiv = commonCode.EMPTYSTR; /* 증빙유형 구분 */
    private String authCode = commonCode.EMPTYSTR; /* 증빙유형 코드 */
    private String authName = commonCode.EMPTYSTR; /* 증빙유형 명칭 */
    private String cashType = commonCode.EMPTYSTR; /* 현금영수증 구분 */
    private String crAcctCode = commonCode.EMPTYSTR; /* 대변 대체 계정 코드 */
    private String crAcctName = commonCode.EMPTYSTR; /* 대변 대체 계정 명칭 */
    private String vatAcctCode = commonCode.EMPTYSTR; /* 부가세 대체 계정 코드 */
    private String vatAcctName = commonCode.EMPTYSTR; /* 부가세 대체 계정 명칭 */
    private String vatTypeCode = commonCode.EMPTYSTR; /* 부가세 구분 ( 세무구분 ) 코드 */
    private String vatTypeName = commonCode.EMPTYSTR; /* 부가세 구분 ( 세무구분 ) 명칭 */
    private String erpAuthCode = commonCode.EMPTYSTR; /* ERP 증빙 코드 */
    private String erpAuthName = commonCode.EMPTYSTR; /* ERP 증빙 명칭 */
    private String expendAuthRequiredYN = commonCode.EMPTYSTR; /* 증빙일자 필수입력 여부 */
    private String expendPartnerRequiredYN = commonCode.EMPTYSTR; /* 거래처 필수입력 여부 */
    private String expendCardRequiredYN = commonCode.EMPTYSTR; /* 카드 필수입력 여부 */
    private String expendProjectRequiredYN = commonCode.EMPTYSTR; /* 프로젝트 필수입력 여부 */
    private String expendNoteRequiredYN = commonCode.EMPTYSTR; /* 적요 필수입력 여부 */
    private String noTaxCode = commonCode.EMPTYSTR; /* 불공제구분 코드 */
    private String noTaxName = commonCode.EMPTYSTR; /* 불공제구분 명칭 */
    private String vaTypeCode = commonCode.EMPTYSTR; /* 사유구분 코드 */
    private String vaTypeName = commonCode.EMPTYSTR; /* 사유구분 명칭 */
    private int expendProjectSeq = 0; /* 프로젝트 시퀀스 */
    private String projectCode = commonCode.EMPTYSTR; /* 프로젝트 코드 */
    private String projectName = commonCode.EMPTYSTR; /* 프로젝트 명칭 */
    private int expendCardSeq = 0; /* 카드 시퀀스 */
    private String cardNum = commonCode.EMPTYSTR; /* 카드 번호 */
    private String cardName = commonCode.EMPTYSTR; /* 카드 명칭 */
    private int expendBudgetSeq = 0; /* 예산 시퀀스 */
    private String searchFromDt = commonCode.EMPTYSTR; /* ERPiU *//* iCUBE *//* ERPiU *//* 검색시작일 */
    private String searchToDt = commonCode.EMPTYSTR; /* ERPiU *//* iCUBE *//* ERPiU *//* 검색종료일 */
    private String searchIssNo = commonCode.EMPTYSTR; /* ERPiU *//* iCUBE *//* ERPiU *//* 승인번호 검색 문자열 */
    private String searchPartnerNm = commonCode.EMPTYSTR; /* ERPiU *//* iCUBE *//* ERPiU *//* 공급자 상호 검색 문자열 */
    private String searchPartnerNo = commonCode.EMPTYSTR; /* ERPiU *//* iCUBE *//* ERPiU *//* 공급자 등록번호 문자열 */
    private String ifMId = commonCode.EMPTYSEQ; /* 연동 마스터 키 */
    private String ifDId = commonCode.EMPTYSEQ; /* 연동 디테일 키 */
    private String createSeq = commonCode.EMPTYSEQ; /* 작성자 */
    private String modifySeq = commonCode.EMPTYSEQ; /* 수정자 */
    private String callback = commonCode.EMPTYSTR; /* 콜백 */
    private String formSeq = commonCode.EMPTYSEQ; /* 양식 시퀀스 */
    private String expendSeq = commonCode.EMPTYSEQ; /* 지출결의 시퀀스 */
    private String drAcctCode = commonCode.EMPTYSEQ;
    private String drAcctName = commonCode.EMPTYSTR;
    private String budgetCode = commonCode.EMPTYSEQ;
    private String budgetName = commonCode.EMPTYSTR;
    private String bizplanCode = commonCode.EMPTYSEQ;
    private String bizplanName = commonCode.EMPTYSTR;
    private String bgacctCode = commonCode.EMPTYSEQ;
    private String bgacctName = commonCode.EMPTYSTR;
    private String adocuYN = commonCode.EMPTYSTR;
    private String adocuFg = commonCode.EMPTYSTR;
    private String gwInsertDt = commonCode.EMPTYSTR;
    private String approState = commonCode.EMPTYSTR;
    private String docuNo = commonCode.EMPTYSTR;
    private String issYN = commonCode.EMPTYSTR;
    private String notInsertIssNo = commonCode.EMPTYSTR;
    private String authRequiredYN = commonCode.EMPTYSTR; /* 증빙일자 */
    private String partnerRequiredYN = commonCode.EMPTYSTR; /* 거래처 */
    private String cardRequiredYN = commonCode.EMPTYSTR; /* 카드 */
    private String projectRequiredYN = commonCode.EMPTYSTR; /* 프로젝트 */
    private String noteRequiredYN = commonCode.EMPTYSTR; /* 적요 */
    private String searchStr = commonCode.EMPTYSTR; /* 검색어 */
    private String docuSt = commonCode.EMPTYSTR; /* iCUBE 계산서 전표 발행여부 */
    private String baseEmailAddr = commonCode.EMPTYSTR; /* 권한 없는 경우 사용자 이메일 주소로 조회되도록 */
    private String transferIssNo = commonCode.EMPTYSTR; /* 이관받은 세금계산서 번호 */
    private String tpTbTaxCompany = commonCode.EMPTYSTR;

    // 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
    private String cdBgLevel = commonCode.EMPTYSTR; // 예산통제레벨계정 ( ERPiU 연동 사용 )
    private String ynControl = commonCode.EMPTYSTR; // 예산통제여부 ( N : 통제안함, Y : 통제 ) ( ERPiU 연동 사용 )
    private String tpControl = commonCode.EMPTYSTR; // 예산통제기준 ( 1 : 예산단위통제, 2 : 예산계정통제 ) ( ERPiU 연동 사용 )

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

    public String getIssNo() {
        return CommonConvert.CommonGetStr(issNo);
    }

    public void setIssNo(String issNo) {
        this.issNo = issNo;
    }


    public String getCoCd() {
        return CommonConvert.CommonGetStr(coCd);
    }

    public void setCoCd(String coCd) {
        this.coCd = coCd;
    }

    public String getDivCd() {
        return CommonConvert.CommonGetStr(divCd);
    }

    public void setDivCd(String divCd) {
        this.divCd = divCd;
    }

    public String getTrCd() {
        return CommonConvert.CommonGetStr(trCd);
    }

    public void setTrCd(String trCd) {
        this.trCd = trCd;
    }

    public String getIssDt() {
        return CommonConvert.CommonGetStr(issDt);
    }

    public void setIssDt(String issDt) {
        this.issDt = issDt;
    }

    public String getTaxTy() {
        return CommonConvert.CommonGetStr(taxTy);
    }

    public void setTaxTy(String taxTy) {
        this.taxTy = taxTy;
    }

    public String getIsuDt() {
        return CommonConvert.CommonGetStr(isuDt);
    }

    public void setIsuDt(String isuDt) {
        this.isuDt = isuDt;
    }

    public String getDivregNb() {
        return CommonConvert.CommonGetStr(divregNb);
    }

    public void setDivregNb(String divregNb) {
        this.divregNb = divregNb;
    }

    public String getDivsubNb() {
        return CommonConvert.CommonGetStr(divsubNb);
    }

    public void setDivsubNb(String divsubNb) {
        this.divsubNb = divsubNb;
    }

    public String getDivNm() {
        return CommonConvert.CommonGetStr(divNm);
    }

    public void setDivNm(String divNm) {
        this.divNm = divNm;
    }

    public String getDivceoNm() {
        return CommonConvert.CommonGetStr(divceoNm);
    }

    public void setDivceoNm(String divceoNm) {
        this.divceoNm = divceoNm;
    }

    public String getTrregNb() {
        return CommonConvert.CommonGetStr(trregNb);
    }

    public void setTrregNb(String trregNb) {
        this.trregNb = trregNb;
    }

    public String getTrsubNb() {
        return CommonConvert.CommonGetStr(trsubNb);
    }

    public void setTrsubNb(String trsubNb) {
        this.trsubNb = trsubNb;
    }

    public String getTrNm() {
        return CommonConvert.CommonGetStr(trNm);
    }

    public void setTrNm(String trNm) {
        this.trNm = trNm;
    }

    public String getTrceoNm() {
        return CommonConvert.CommonGetStr(trceoNm);
    }

    public void setTrceoNm(String trceoNm) {
        this.trceoNm = trceoNm;
    }

    public String getSumAm() {
        return CommonConvert.CommonGetStr(sumAm);
    }

    public void setSumAm(String sumAm) {
        this.sumAm = sumAm;
    }

    public String getAmt() {
        return CommonConvert.CommonGetStr(amt);
    }

    public void setAmt(String amt) {
        this.amt = amt;
    }

    public String getSupAm() {
        return CommonConvert.CommonGetStr(supAm);
    }

    public void setSupAm(String supAm) {
        this.supAm = supAm;
    }

    public String getAm() {
        return CommonConvert.CommonGetStr(am);
    }

    public void setAm(String am) {
        this.am = am;
    }

    public String getVatAm() {
        return CommonConvert.CommonGetStr(vatAm);
    }

    public void setVatAm(String vatAm) {
        this.vatAm = vatAm;
    }

    public String getAmVat() {
        return CommonConvert.CommonGetStr(amVat);
    }

    public void setAmVat(String amVat) {
        this.amVat = amVat;
    }

    public String getEtaxTy() {
        return CommonConvert.CommonGetStr(etaxTy);
    }

    public void setEtaxTy(String etaxTy) {
        this.etaxTy = etaxTy;
    }

    public String getEtaxFg() {
        return CommonConvert.CommonGetStr(etaxFg);
    }

    public void setEtaxFg(String etaxFg) {
        this.etaxFg = etaxFg;
    }

    public String getSendFg() {
        return CommonConvert.CommonGetStr(sendFg);
    }

    public void setSendFg(String sendFg) {
        this.sendFg = sendFg;
    }

    public String getDummy1() {
        return CommonConvert.CommonGetStr(dummy1);
    }

    public void setDummy1(String dummy1) {
        this.dummy1 = dummy1;
    }

    public String getDummy2() {
        return CommonConvert.CommonGetStr(dummy2);
    }

    public void setDummy2(String dummy2) {
        this.dummy2 = dummy2;
    }

    public String getIssYmd() {
        return CommonConvert.CommonGetStr(issYmd);
    }

    public void setIssYmd(String issYmd) {
        this.issYmd = issYmd;
    }

    public String getItemDc() {
        return CommonConvert.CommonGetStr(itemDc);
    }

    public void setItemDc(String itemDc) {
        this.itemDc = itemDc;
    }

    public String getAddtaxCd() {
        return CommonConvert.CommonGetStr(addtaxCd);
    }

    public void setAddtaxCd(String addtaxCd) {
        this.addtaxCd = addtaxCd;
    }

    public String getAddtaxAm() {
        return CommonConvert.CommonGetStr(addtaxAm);
    }

    public void setAddtaxAm(String addtaxAm) {
        this.addtaxAm = addtaxAm;
    }

    public String getAddrteRt() {
        return CommonConvert.CommonGetStr(addrteRt);
    }

    public void setAddrteRt(String addrteRt) {
        this.addrteRt = addrteRt;
    }

    public String getEmailDc() {
        return CommonConvert.CommonGetStr(emailDc);
    }

    public void setEmailDc(String emailDc) {
        this.emailDc = emailDc;
    }

    public String getTrchargeEmail() {
        return CommonConvert.CommonGetStr(trchargeEmail);
    }

    public void setTrchargeEmail(String trchargeEmail) {
        this.trchargeEmail = trchargeEmail;
    }

    public String getSendYN() {
        return CommonConvert.CommonGetStr(sendYN);
    }

    public void setSendYN(String sendYN) {
        this.sendYN = sendYN;
    }

    public String getNote() {
        return CommonConvert.CommonGetStr(note);
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getSyncId() {
        return syncId;
    }

    public void setSyncId(int syncId) {
        this.syncId = syncId;
    }

    public int getExpendEmpSeq() {
        return expendEmpSeq;
    }

    public void setExpendEmpSeq(int expendEmpSeq) {
        this.expendEmpSeq = expendEmpSeq;
    }

    public String getEmpSeq() {
        return CommonConvert.CommonGetStr(empSeq);
    }

    public void setEmpSeq(String empSeq) {
        this.empSeq = empSeq;
    }

    public String getEmpName() {
        return CommonConvert.CommonGetStr(empName);
    }

    public void setEmpName(String empName) {
        this.empName = empName;
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

    public int getExpendSummarySeq() {
        return expendSummarySeq;
    }

    public void setExpendSummarySeq(int expendSummarySeq) {
        this.expendSummarySeq = expendSummarySeq;
    }

    public String getSummaryCode() {
        return CommonConvert.CommonGetStr(summaryCode);
    }

    public void setSummaryCode(String summaryCode) {
        this.summaryCode = summaryCode;
    }

    public String getSummaryName() {
        return CommonConvert.CommonGetStr(summaryName);
    }

    public void setSummaryName(String summaryName) {
        this.summaryName = summaryName;
    }

    public int getExpendAuthSeq() {
        return expendAuthSeq;
    }

    public void setExpendAuthSeq(int expendAuthSeq) {
        this.expendAuthSeq = expendAuthSeq;
    }

    public String getAuthDiv() {
        return authDiv;
    }

    public void setAuthDiv(String authDiv) {
        this.authDiv = authDiv;
    }

    public String getAuthCode() {
        return CommonConvert.CommonGetStr(authCode);
    }

    public void setAuthCode(String authCode) {
        this.authCode = authCode;
    }

    public String getAuthName() {
        return CommonConvert.CommonGetStr(authName);
    }

    public void setAuthName(String authName) {
        this.authName = authName;
    }

    public String getCashType() {
        return cashType;
    }

    public void setCashType(String cashType) {
        this.cashType = cashType;
    }

    public String getCrAcctCode() {
        return crAcctCode;
    }

    public void setCrAcctCode(String crAcctCode) {
        this.crAcctCode = crAcctCode;
    }

    public String getCrAcctName() {
        return crAcctName;
    }

    public void setCrAcctName(String crAcctName) {
        this.crAcctName = crAcctName;
    }

    public String getVatAcctCode() {
        return vatAcctCode;
    }

    public void setVatAcctCode(String vatAcctCode) {
        this.vatAcctCode = vatAcctCode;
    }

    public String getVatAcctName() {
        return vatAcctName;
    }

    public void setVatAcctName(String vatAcctName) {
        this.vatAcctName = vatAcctName;
    }

    public String getVatTypeCode() {
        return vatTypeCode;
    }

    public void setVatTypeCode(String vatTypeCode) {
        this.vatTypeCode = vatTypeCode;
    }

    public String getVatTypeName() {
        return vatTypeName;
    }

    public void setVatTypeName(String vatTypeName) {
        this.vatTypeName = vatTypeName;
    }

    public String getErpAuthCode() {
        return erpAuthCode;
    }

    public void setErpAuthCode(String erpAuthCode) {
        this.erpAuthCode = erpAuthCode;
    }

    public String getErpAuthName() {
        return erpAuthName;
    }

    public void setErpAuthName(String erpAuthName) {
        this.erpAuthName = erpAuthName;
    }

    public String getExpendAuthRequiredYN() {
        return expendAuthRequiredYN;
    }

    public void setExpendAuthRequiredYN(String expendAuthRequiredYN) {
        this.expendAuthRequiredYN = expendAuthRequiredYN;
    }

    public String getExpendPartnerRequiredYN() {
        return expendPartnerRequiredYN;
    }

    public void setExpendPartnerRequiredYN(String expendPartnerRequiredYN) {
        this.expendPartnerRequiredYN = expendPartnerRequiredYN;
    }

    public String getExpendCardRequiredYN() {
        return expendCardRequiredYN;
    }

    public void setExpendCardRequiredYN(String expendCardRequiredYN) {
        this.expendCardRequiredYN = expendCardRequiredYN;
    }

    public String getExpendProjectRequiredYN() {
        return expendProjectRequiredYN;
    }

    public void setExpendProjectRequiredYN(String expendProjectRequiredYN) {
        this.expendProjectRequiredYN = expendProjectRequiredYN;
    }

    public String getExpendNoteRequiredYN() {
        return expendNoteRequiredYN;
    }

    public void setExpendNoteRequiredYN(String expendNoteRequiredYN) {
        this.expendNoteRequiredYN = expendNoteRequiredYN;
    }

    public String getNoTaxCode() {
        return noTaxCode;
    }

    public void setNoTaxCode(String noTaxCode) {
        this.noTaxCode = noTaxCode;
    }

    public String getNoTaxName() {
        return noTaxName;
    }

    public void setNoTaxName(String noTaxName) {
        this.noTaxName = noTaxName;
    }

    public String getVaTypeCode() {
        return vaTypeCode;
    }

    public void setVaTypeCode(String vaTypeCode) {
        this.vaTypeCode = vaTypeCode;
    }

    public String getVaTypeName() {
        return vaTypeName;
    }

    public void setVaTypeName(String vaTypeName) {
        this.vaTypeName = vaTypeName;
    }

    public int getExpendProjectSeq() {
        return expendProjectSeq;
    }

    public void setExpendProjectSeq(int expendProjectSeq) {
        this.expendProjectSeq = expendProjectSeq;
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

    public int getExpendCardSeq() {
        return expendCardSeq;
    }

    public void setExpendCardSeq(int expendCardSeq) {
        this.expendCardSeq = expendCardSeq;
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

    public int getExpendBudgetSeq() {
        return expendBudgetSeq;
    }

    public void setExpendBudgetSeq(int expendBudgetSeq) {
        this.expendBudgetSeq = expendBudgetSeq;
    }

    public String getSearchFromDt() {
        return CommonConvert.CommonGetStr(searchFromDt);
    }

    public void setSearchFromDt(String searchFromDt) {
        this.searchFromDt = searchFromDt;
    }

    public String getSearchToDt() {
        return CommonConvert.CommonGetStr(searchToDt);
    }

    public void setSearchToDt(String searchToDt) {
        this.searchToDt = searchToDt;
    }

    public String getSearchIssNo() {
        return CommonConvert.CommonGetStr(searchIssNo);
    }

    public void setSearchIssNo(String searchIssNo) {
        this.searchIssNo = searchIssNo;
    }

    public String getSearchPartnerNm() {
        return CommonConvert.CommonGetStr(searchPartnerNm);
    }

    public void setSearchPartnerNm(String searchPartnerNm) {
        this.searchPartnerNm = searchPartnerNm;
    }

    public String getSearchPartnerNo() {
        return CommonConvert.CommonGetStr(searchPartnerNo);
    }

    public void setSearchPartnerNo(String searchPartnerNo) {
        this.searchPartnerNo = searchPartnerNo;
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

    public String getExpendSeq() {
        return CommonConvert.CommonGetStr(expendSeq);
    }

    public void setExpendSeq(String expendSeq) {
        this.expendSeq = expendSeq;
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

    public String getBizplanCode() {
        if(bizplanCode == null ||  CommonConvert.CommonGetStr(bizplanCode).equals(commonCode.EMPTYSTR) || CommonConvert.CommonGetStr(bizplanCode).equals(commonCode.EMPTYSEQ)){
          return bizplanCode = "***";
        }else {
          return bizplanCode;
        }
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

    public String getAdocuYN() {
        return CommonConvert.CommonGetStr(adocuYN);
    }

    public void setAdocuYN(String adocuYN) {
        this.adocuYN = adocuYN;
    }

    public String getAdocuFg() {
        return CommonConvert.CommonGetStr(adocuFg);
    }

    public void setAdocuFg(String adocuFg) {
        this.adocuFg = adocuFg;
    }

    public String getGwInsertDt() {
        return CommonConvert.CommonGetStr(gwInsertDt);
    }

    public void setGwInsertDt(String gwInsertDt) {
        this.gwInsertDt = gwInsertDt;
    }

    public String getApproState() {
        return CommonConvert.CommonGetStr(approState);
    }

    public void setApproState(String approState) {
        this.approState = approState;
    }

    public String getDocuNo() {
        return CommonConvert.CommonGetStr(docuNo);
    }

    public void setDocuNo(String docuNo) {
        this.docuNo = docuNo;
    }

    public String getIssYN() {
        return CommonConvert.CommonGetStr(issYN);
    }

    public void setIssYN(String issYN) {
        this.issYN = issYN;
    }

    public String getNotInsertIssNo() {
        return CommonConvert.CommonGetStr(notInsertIssNo);
    }

    public void setNotInsertIssNo(String notInsertIssNo) {
        this.notInsertIssNo = notInsertIssNo;
    }

    public String getAuthRequiredYN() {
        return CommonConvert.CommonGetStr(authRequiredYN);
    }

    public void setAuthRequiredYN(String authRequiredYN) {
        this.authRequiredYN = authRequiredYN;
    }

    public String getPartnerRequiredYN() {
        return CommonConvert.CommonGetStr(partnerRequiredYN);
    }

    public void setPartnerRequiredYN(String partnerRequiredYN) {
        this.partnerRequiredYN = partnerRequiredYN;
    }

    public String getCardRequiredYN() {
        return CommonConvert.CommonGetStr(cardRequiredYN);
    }

    public void setCardRequiredYN(String cardRequiredYN) {
        this.cardRequiredYN = cardRequiredYN;
    }

    public String getProjectRequiredYN() {
        return CommonConvert.CommonGetStr(projectRequiredYN);
    }

    public void setProjectRequiredYN(String projectRequiredYN) {
        this.projectRequiredYN = projectRequiredYN;
    }

    public String getNoteRequiredYN() {
        return CommonConvert.CommonGetStr(noteRequiredYN);
    }

    public void setNoteRequiredYN(String noteRequiredYN) {
        this.noteRequiredYN = noteRequiredYN;
    }

    public String getSearchStr() {
        return CommonConvert.CommonGetStr(searchStr);
    }

    public void setSearchStr(String searchStr) {
        this.searchStr = searchStr;
    }

    public String getDocuSt() {
        return CommonConvert.CommonGetStr(docuSt);
    }

    public void setDocuSt(String docuSt) {
        this.docuSt = docuSt;
    }

    public String getErpPcSeq() {
        return CommonConvert.CommonGetStr(erpPcSeq);
    }

    public void setErpPcSeq(String erpPcSeq) {
        this.erpPcSeq = erpPcSeq;
    }

    public String getErpPcName() {
        return CommonConvert.CommonGetStr(erpPcName);
    }

    public void setErpPcName(String erpPcName) {
        this.erpPcName = erpPcName;
    }

    public String getErpCcSeq() {
        return CommonConvert.CommonGetStr(erpCcSeq);
    }

    public void setErpCcSeq(String erpCcSeq) {
        this.erpCcSeq = erpCcSeq;
    }

    public String getErpCcName() {
        return CommonConvert.CommonGetStr(erpCcName);
    }

    public void setErpCcName(String erpCcName) {
        this.erpCcName = erpCcName;
    }

    public String getBaseEmailAddr() {
        return CommonConvert.CommonGetStr(baseEmailAddr);
    }

    public void setBaseEmailAddr(String baseEmailAddr) {
        this.baseEmailAddr = baseEmailAddr;
    }

    public String getTransferIssNo() {
        return CommonConvert.CommonGetStr(transferIssNo);
    }

    public void setTransferIssNo(String transferIssNo) {
        this.transferIssNo = transferIssNo;
    }



    public String getHometaxIssNo() {
        return CommonConvert.CommonGetStr(hometaxIssNo);
    }

    public void setHometaxIssNo(String hometaxIssNo) {
        this.hometaxIssNo = hometaxIssNo;
    }

    public String getTpTbTaxCompany() {
        return CommonConvert.CommonGetStr(tpTbTaxCompany);
    }

    public void setTpTbTaxCompany(String tpTbTaxCompany) {
        this.tpTbTaxCompany = tpTbTaxCompany;
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

    @Override
    public String toString() {
        return "ExCodeETaxVO [compSeq=" + compSeq + ", erpCompSeq=" + erpCompSeq + ", issNo=" + issNo + ", hometaxIssNo=" + hometaxIssNo + ", coCd=" + coCd + ", divCd=" + divCd + ", trCd=" + trCd + ", issDt=" + issDt + ", taxTy=" + taxTy + ", isuDt=" + isuDt + ", divregNb=" + divregNb + ", divsubNb=" + divsubNb + ", divNm=" + divNm + ", divceoNm=" + divceoNm + ", trregNb=" + trregNb + ", trsubNb=" + trsubNb + ", trNm=" + trNm + ", trceoNm=" + trceoNm + ", sumAm=" + sumAm + ", amt=" + amt + ", supAm=" + supAm + ", am=" + am + ", vatAm=" + vatAm + ", amVat=" + amVat + ", etaxTy=" + etaxTy + ", etaxFg=" + etaxFg + ", sendFg=" + sendFg + ", dummy1=" + dummy1 + ", dummy2=" + dummy2 + ", issYmd=" + issYmd + ", itemDc=" + itemDc + ", addtaxCd=" + addtaxCd + ", addtaxAm=" + addtaxAm + ", addrteRt=" + addrteRt + ", emailDc=" + emailDc + ", trchargeEmail=" + trchargeEmail + ", sendYN=" + sendYN + ", note=" + note + ", syncId=" + syncId + ", expendEmpSeq=" + expendEmpSeq + ", empSeq=" + empSeq
                + ", empName=" + empName + ", deptSeq=" + deptSeq + ", deptName=" + deptName + ", erpPcSeq=" + erpPcSeq + ", erpPcName=" + erpPcName + ", erpCcSeq=" + erpCcSeq + ", erpCcName=" + erpCcName + ", expendSummarySeq=" + expendSummarySeq + ", summaryCode=" + summaryCode + ", summaryName=" + summaryName + ", expendAuthSeq=" + expendAuthSeq + ", authDiv=" + authDiv + ", authCode=" + authCode + ", authName=" + authName + ", cashType=" + cashType + ", crAcctCode=" + crAcctCode + ", crAcctName=" + crAcctName + ", vatAcctCode=" + vatAcctCode + ", vatAcctName=" + vatAcctName + ", vatTypeCode=" + vatTypeCode + ", vatTypeName=" + vatTypeName + ", erpAuthCode=" + erpAuthCode + ", erpAuthName=" + erpAuthName + ", expendAuthRequiredYN=" + expendAuthRequiredYN + ", expendPartnerRequiredYN=" + expendPartnerRequiredYN + ", expendCardRequiredYN=" + expendCardRequiredYN + ", expendProjectRequiredYN=" + expendProjectRequiredYN + ", expendNoteRequiredYN=" + expendNoteRequiredYN
                + ", noTaxCode=" + noTaxCode + ", noTaxName=" + noTaxName + ", vaTypeCode=" + vaTypeCode + ", vaTypeName=" + vaTypeName + ", expendProjectSeq=" + expendProjectSeq + ", projectCode=" + projectCode + ", projectName=" + projectName + ", expendCardSeq=" + expendCardSeq + ", cardNum=" + cardNum + ", cardName=" + cardName + ", expendBudgetSeq=" + expendBudgetSeq + ", searchFromDt=" + searchFromDt + ", searchToDt=" + searchToDt + ", searchIssNo=" + searchIssNo + ", searchPartnerNm=" + searchPartnerNm + ", searchPartnerNo=" + searchPartnerNo + ", ifMId=" + ifMId + ", ifDId=" + ifDId + ", createSeq=" + createSeq + ", modifySeq=" + modifySeq + ", callback=" + callback + ", formSeq=" + formSeq + ", expendSeq=" + expendSeq + ", drAcctCode=" + drAcctCode + ", drAcctName=" + drAcctName + ", budgetCode=" + budgetCode + ", budgetName=" + budgetName + ", bizplanCode=" + bizplanCode + ", bizplanName=" + bizplanName + ", bgacctCode=" + bgacctCode + ", bgacctName=" + bgacctName
                + ", adocuYN=" + adocuYN + ", adocuFg=" + adocuFg + ", gwInsertDt=" + gwInsertDt + ", approState=" + approState + ", docuNo=" + docuNo + ", issYN=" + issYN + ", notInsertIssNo=" + notInsertIssNo + ", authRequiredYN=" + authRequiredYN + ", partnerRequiredYN=" + partnerRequiredYN + ", cardRequiredYN=" + cardRequiredYN + ", projectRequiredYN=" + projectRequiredYN + ", noteRequiredYN=" + noteRequiredYN + ", searchStr=" + searchStr + ", docuSt=" + docuSt + ", baseEmailAddr=" + baseEmailAddr + ", transferIssNo=" + transferIssNo + ", tpTbTaxCompany=" + tpTbTaxCompany + ", cdBgLevel=" + cdBgLevel + ", ynControl=" + ynControl + ", tpControl=" + tpControl + "]";
    }

}
