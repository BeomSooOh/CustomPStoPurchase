/*지출결의 작성 사용 변수*/
var expendType = {
    "emp" : "emp",
    "dept" : "dept",
    "pc" : "pc",
    "cc" : "cc",
    "summary" : "summary",
    "auth" : "auth",
    "vat" : "vat",
    "va" : "va",
    "note" : "note",
    "project" : "project",
    "card" : "card",
    "partner" : "partner",
    "notax" : "notax",
    "budget" : "budget",
    "bizplan" : "bizplan",
    "bgacct" : "bgacct",
    "exchangeunit" : "exchangeunit"
};

/* 지출결의 작성 사용 변수 - 지출결의 */
var ExExpend = {
    compSeq : "", /* 귀속회사 시퀀스 */
    erpCompSeq : "", /* ERP 회사코드 */
    expendSeq : "", /* 지출결의 시퀀스 */
    docSeq : "", /* 전자결재 시퀀스 */
    expendStatCode : "", /* 지출결의 상태코드 ( 전자결재 동일, 상태값 변경 비교를 위해 사용 ) */
    expendDate : "", /* 결의일자 ( 회계일자, 예산년월 ) */
    expendReqDate : "", /* 지급요청일자 ( 만기일자 ) */
    erpSendYN : "", /* ERP 전송여부 ( 전송 : Y / 미전송 : N ) */
    writeSeq : "0", /* 작성자 */
    empSeq : "0", /* 사용자 */
    budgetSeq : "0", /* 예산 */
    projectSeq : "0", /* 프로젝트 */
    partnerSeq : "0", /* 거래처 */
    cardSeq : "0", /* 카드 */
    jsonStr : "", /* 지출결의 JSON 문자열 */
    erpSendSeq : "0", /* 지출결의 > 자동전표 전송자 */
    rowId : "", /* ERPiU 자동전표 아이디 */
    inDt : "", /* iCUBE 자동전표 아이디 마스터 */
    inSq : "", /* iCUBE 자동전표 아이디 디테일 */
    formSeq : "0", /* 양식 아이디 */
    createSeq : "", /* 생성자 */
    modifySeq : "" /* 수정자 */
};

/* 지출결의 작성 사용 변수 - 지출결의 - 항목 */
var ExExpendList = {
    compSeq : "", /* 귀속회사 시퀀스 */
    erpCompSeq : "", /* ERP 회사코드 */
    expendSeq : "", /* 지출결의 시퀀스 */
    listSeq : "", /* 지출결의 항목 시퀀스 */
    summarySeq : "0", /* 표준적요 시퀀스 */
    authSeq : "0", /* 증빙유형 시퀀스 */
    writeSeq : "0", /* 작성자 시퀀스 */
    empSeq : "0", /* 사용자 시퀀스 */
    budgetSeq : "0", /* 예산 시퀀스 */
    projectSeq : "0", /* 프로젝트 시퀀스 */
    partnerSeq : "0", /* 거래처 시퀀스 */
    cardSeq : "0", /* 카드 시퀀스 */
    feeSeq : "0", /* 접대비부표 시퀀스 */
    authDate : "", /* 증빙일자 */
    note : "", /* 적요 */
    stdAmt : "0", /* 공급가액 */
    taxAmt : "0", /* 부가세액 */
    amt : "0", /* 공급대가 */
    subStdAmt : "0", /* 과세표준액 */
    subTaxAmt : "0", /* 세액 */
    interfaceType : "", /* 외부연동 구분 값 */
    interfaceMId : "", /* 외부연동 마스터 아이디 */
    interfaceDId : "", /* 외부연동 디테일 아이디 */
    jsonStr : "",
    formSeq : "0",
    createSeq : "", /* 생성자 */
    modifySeq : "", /* 수정자 */
    extendStr1: "", /* 확장입력1 */
    extendStr2: "" /* 확장입력2 */
};

/* 지출결의 작성 사용 변수 - 지출결의 - 항목 - 분개 */
var ExExpendSlip = {
    compSeq : "0", /* 귀속 회사 시퀀스 */
    erpCompSeq : "", /* ERP 회사코드 */
    expendSeq : "0", /* 지출결의 시퀀스 */
    listSeq : "0", /* 지출결의 항목 시퀀스 */
    slipSeq : "0", /* 지출결의 항목 분개 시퀀스 */
    summarySeq : 0, /* 표준적요 시퀀스 */
    authSeq : 0, /* 증빙유형 시퀀스 */
    writeSeq : 0, /* 작성자 시퀀스 */
    empSeq : 0, /* 사용자 시퀀스 */
    budgetSeq : 0, /* 예산 시퀀스 */
    projectSeq : 0, /* 프로젝트 시퀀스 */
    partnerSeq : 0, /* 거래처 시퀀스 */
    cardSeq : 0, /* 카드 시퀀스 */
    drcrGbn : "", /* 차대 구분 */
    acctCode : "", /* 계정과목 코드 */
    acctName : "", /* 계정과목 명칭 */
    vatYN : "N", /* 부가세여부 */
    authDate : "", /* 증빙일자 */
    note : "", /* 적요 */
    amt : "0", /* 금액 */
    subStdAmt : "0", /* 과세표준액 */
    subTaxAmt : "0", /* 세액 */
    interfaceType : "", /* 외부연동 구분 값 */
    interfaceMId : "0", /* 외부연동 마스터 아이디 */
    interfaceDId : "0", /* 외부연동 디테일 아이디 */
    rowId : "", /* ERPiU GMMSUM 연동 KEY 1 */
    rowNo : "", /* ERPiU GMMSUM 연동 KEY 2 */
    jsonStr : "",
    formSeq : "0", /* 양식 아이디 */
    callback : "",
    createSeq : "0", /* 생성자 */
    modifySeq : "0" /* 수정자 */
};

/* 지출결의 작성 사용 변수 - 지출결의 - 항목 - 분개 - 관리항목 */
var ExExpendMng = {
    compSeq : "",
    erpCompSeq : "",
    expendSeq : "0",
    listSeq : "0",
    slipSeq : "0",
    mngSeq : "0",
    acctCode : "",
    acctName : "",
    mngCode : "",
    mngName : "",
    mngFormCode : "",
    mngChildYN : "",
    mngStat : "",
    ctdCode : "",
    ctdName : "",
    jsonStr : "",
    formSeq : "0",
    searchStr : "",
    callback : "",
    createSeq : "0",
    modifySeq : "0",
    realMngCode : "0"
};

/* 지출결의 - 표준적요 */
var ExCodeSummary = {
    seq : "0",
    compSeq : "", /* 회사코드 */
    summaryCode : "", /* 표준적요 코드 */
    summaryName : "", /* 표준적요 명칭 */
    summaryDiv : "", /* 표준적요 구분 ( A : 지출 / B : 매입 ) */
    drAcctCode : "", /* 차변 계정과목 코드 */
    drAcctName : "", /* 차변 계정과목 명칭 */
    crAcctCode : "", /* 대변 계정과목 코드 */
    crAcctName : "", /* 대변 계정과목 명칭 */
    vatAcctCode : "", /* 부가세 계정과목 코드 */
    vatAcctName : "", /* 부가세 계정과목 명칭 */
    bankPartnerCode : "", /* 금융거래처 코드 */
    bankPartnerName : "", /* 금융거래처 명칭 */
    formSeq : "0",
    callback : "",
    searchStr : "", /* 검색어 */
    createSeq : "0", /* 생성자 */
    modifySeq : "0" /* 수정자 */
};

/* 지출결의 - 증빙유형 */
var ExCodeAuth = {
    seq : "0",
    compSeq : "",
    authDiv : "",
    authCode : "",
    authName : "",
    cashType : "",
    crAcctCode : "",
    crAcctName : "",
    vatAcctCode : "",
    vatAcctName : "",
    vatTypeCode : "",
    vatTypeName : "",
    erpAuthCode : "",
    erpAuthName : "",
    authRequiredYN : "N",
    partnerRequiredYN : "N",
    cardRequiredYN : "N",
    projectRequiredYN : "N",
    noteRequiredYN : "N",
    noTaxCode : "",
    noTaxName : "",
    orderNum : "",
    useYN : "Y",
    vaTypeCode : "",
    vaTypeName : "",
    createSeq : "",
    modifySeq : "",
    searchStr : "",
    formSeq : "",
    callback : "",
    etaxYN : "",
    etaxSendYN : "",
    noCash : ""
};

/* 지출결의 - 계정과목 */
var ExCodeAcct = {
    compSeq : "", /* 회사코드 */
    erpCompSeq : "", /* ERP 회사코드 */
    acctCode : "", /* 계정과목코드 */
    acctName : "", /* 계정과목명칭 */
    vatYN : "", /* 부가세구분 */
    useYN : "", /* 사용여부 */
    formSeq : "0", /* 양식아이디 */
    searchType : "", /* 계정과목 검색 조건 */
    searchStr : "", /* 검색어 */
    callback : "", /* 콜백 */
    createSeq : "", /* 최초작성자 */
    modifySeq : "" /* 최종수정자 */
}

/* 지출결의 - 관리항목 */
var ExCodeMng = {
    compSeq : "0", /* 회사 시퀀스 */
    erpCompSeq : "", /* ERP 회사 시퀀스 */
    formSeq : "0", /* 양식 시퀀스 */
    mngCode : "", /* 관리항목 코드 */
    mngName : "", /* 관리항목 명칭 */
    ctdCode : "", /* 관리항목 입력 코드 */
    ctdName : "", /* 관리항목 입력 명칭 */
    note : "", /* 비고 */
    mngType : "", /* 관리항목 코드 그룹 */
    mngChildYN : "", /* 관리항목 하위코드 존재여부 */
    mngForm : "", /* 관리항목 입력 형식 */
    drcrGbn : "", /* 차대구분 */
    useGbn : "", /* 사용자정의 타입 */
    useGbnName : "", /* 사용자정의 타입 명칭 */
    custSet : "", /* 커스터마이징 구분 ( 프로시저, 쿼리 ) */
    custSetTarget : "", /* 프로시저, 쿼리 구동 대상 */
    modifyYN : "Y", /* 수정가능여부 ( 전용개발인 경우, 사용자에 의해 수정 및 삭제가 진행되면 안되기 때문 ) */
    createseq : "0", /* 생성자 */
    modifySeq : "0", /* 수정자 */
    searchStr : "" /* 검색어 */
}

/* 지출결의 - 조직도 */
var ExCodeOrg = {
    seq : 0,
    compSeq : "",
    compName : "",
    bizSeq : "",
    bizName : "",
    deptSeq : "",
    deptName : "",
    empSeq : "",
    empName : "",
    erpCompSeq : "",
    erpCompName : "",
    erpBizSeq : "",
    erpBizName : "",
    erpDeptSeq : "",
    erpDeptName : "",
    erpEmpSeq : "",
    erpEmpName : "",
    erpPcSeq : "",
    erpPcName : "",
    erpCcSeq : "",
    erpCcName : "",
    depositName : "",
    depositCd : "",
    /* 급여 계좌 */
    depositName2 : "",
    depositCd2 : "",
    formSeq : "",
    langCode : "",
    searchStr : "",
    callback : "",
    createSeq : "",
    modifySeq : ""
};

/* 지출결의 - 거래처 */
var ExCodePartner = {
    seq : "0",
    comp_seq : "",
    erpCompSeq : "",
    partnerCode : "",
    partnerName : "",
    partnerNo : "",
    partnerFg : "",
    ceoName : "",
    jobGbn : "",
    clsJobGbn : "",
    depositNo : "",
    bankCode : "",
    partnerEmpCode : "",
    partnerHpEmpNo : "",
    depositName : "",
    depositConvert : "",
    callback : "",
    formSeq : "",
    searchStr : "",
    searchType : "",
    createSeq : "",
    modifySeq : ""
};
/* 지출결의 - 프로젝트 */
var ExCodeProject = {
    seq : "0",
    compSeq : "",
    userSe : "",
    deptSeq : "",
    empSeq : "",
    erpCompSeq : "",
    projectCode : "",
    projectName : "",
    callback : "",
    formSeq : "",
    searchStr : "",
    createSeq : "",
    modifySeq : ""
};
/* 지출결의 - 카드 */
var ExCodeCard = {
    seq : "0", /* 시퀀스 */
    compSeq : "", /* 회사코드 */
    empCompSeq : "", /* ERP 회사 시퀀스 */
    cardCode : "", /* 카드코드 */
    cardNum : "", /* 카드번호 */
    cardName : "", /* 카드명칭 */
    partnerCode : "", /* 금융거래처코드 */
    partnerName : "", /* 금융거래처명칭 */
    cardPublicJson : "", /* 공개범위 interface JSON 문자열 */
    cardPublic : "", /* 공개범위 입력 데이터 JSON Array 문자열 */
    useYN : "Y", /* 사용여부 */
    erpCompSeq : "", /* ERP회사코드 */
    bankPartnerCode : "", /* ERPiU 금융거래처 코드 */
    bankPartnerName : "", /* ERPiU 금융거래처 명칭 */
    callback : "", /* 콜백 */
    formSeq : "0", /* 양식 시퀀스 */
    searchStr : "", /* 검색문자열 */
    searchType : "", /* 검색구분 ( IN : BizboxA / OUT : 연동시스템 ) */
    createSeq : "0", /* 최초 생성자 */
    modifySeq : "0", /* 최종 수정자 */

    searchFromDate : "", /* 검색 시작일 */
    searchToDate : "", /* 검색 종료일 */
    searchCardNum : "", /* 검색 카드번호 */

    syncId : "0", /* 카드 사용내역 키값 */
    authDate : "", /* 거래 승인일자 */
    authTime : "", /* 증빙시간 */
    authNum : "", /* 승인번호 */
    georaeCand : "", /* 거래 취소일자 */
    mercName : "", /* 거래처 명칭 */
    mercSaupNo : "", /* 거래처 사업자 등록 번호 */
    mercTel : "", /* 거래처 유선 연락처 */
    mercZip : "", /* 사업장 주소 우편번호 */
    mercAddr : "", /* 사업장 주소 */
    gongjeNoChk : "N", /* 불공제 여부 */
    mccStat : "", /* 거래처 구분 */
    requestAmount : "0", /* 공급가액 */
    vatMdAmount : "0", /* 부가세액 */
    amtMdAmount : "0", /* 공급대가 */
    serAmount : "0", /* 서비스 금액 */
    empSeq : "", /* 사용자 시퀀스 */
    dispEmpName : "", /* 사용자 표현 명칭 */
    deptSeq : "", /* 사용자 부서 시퀀스 */
    erpDeptSeq : "", /* ERP 사용자 부서 시퀀스 */
    empName : "", /* 사용자 명 */
    erpEmpName : "", /* ERP 사용자 명 */
    summarySeq : "", /* 표준적요 시퀀스 */
    dispSummaryName : "", /* 표준적요 표현 명칭 */
    summaryName : "", /* 표준적요 명칭 */
    drAcctCode : "", /* 차변 계정과목 코드 */
    drAcctName : "", /* 차변 계정과목 명칭 */
    authSeq : "", /* 증빙유형 시퀀스 */
    dispAuthName : "", /* 증빙유형 표현 명칭 */
    authName : "", /* 증빙유형 명칭 */
    projectSeq : "", /* 프로젝트 시퀀스 */
    dispProjectName : "", /* 프로젝트 표현 명칭 */
    projectCode : "", /* 프로젝트 코드 */
    projectName : "", /* 프로젝트 명칭 */
    budgetSeq : "", /* 예산 시퀀스 */
    dispBudgetName : "", /* 예산단위 표현 명칭 */
    dispBizplanName : "", /* 사업계획 표현 명칭 */
    dispBgacctName : "", /* 예산계정 표현 명칭 */
    budgetName : "", /* 예산단위 명칭 */
    bizplanName : "", /* 사업계획 명칭 */
    bgacctName : "", /* 예산계정 명칭 */
    note : "", /* 적요 */

    sendYN : "N", /* 상신여부 */
    userSendYN : "N", /* 관리자 마감 처리 여부 */
    ifMId : "0", /* 외부연동 아이디 */
    ifDId : "0", /* 외부연동 아이디 */

    georaeStat : "", /* 승인구분 */
    abroad : "", /* 해외결재여부 */
    docSeq : "", /* 전자결재 아이디 */

    docNo : "", /* 전자결재 문서 번호 */
    docTitle : "", /* 전자결재 문서 제목 */
    docSts : "", /* 전자결재 문서 상태 */
    docUseYN : "", /* 전자결재 삭제 여부 */
    formMode : "", /* 전자결재 양식 모드 */

    mercRepr : "" /* 거래처 대표자 명 */
};
/* 지출결의 - 카드 - 공개범위 */
var ExCodeCardPublic = {
    comp_seq : "", /* 회사 시퀀스 */
    card_num : "", /* 카드번호 */
    org_div : "", /* 조직도 구분 */
    org_id : "", /* 조직도 시퀀스 */
    create_seq : "", /* 최초 생성자 */
    modify_seq : "" /* 최종 수정자 */
};
/*
 * var ExCodeCardPublic = { comp_seq : "", 회사시퀀스 card_num : "", 카드번호 org_div :
 * "", 조직도 구분 org_id : "", 조직도 시퀀스 create_seq : "", 최초 생성자 modify_seq : "" 최종
 * 수정자 };
 */

/* 지출결의 - 예산 */
var ExCodeBudget = {
    seq : 0, /* 예산정보 시퀀스 */
    expendSeq : "",
    listSeq : "",
    slipSeq : "",
    rowId : "", /* 임시예산 연동 아이디 마스터 */
    rowNo : "", /* 임시예산 연동 아이디 디테일 */
    compSeq : "", /* 회사 시퀀스 */
    erpCompSeq : "", /* ERP 회사 시퀀스 */
    deptSeq : "", /* 부서 시퀀스 */
    deptName : "", /* 부서 명칭 */
    erpDeptSeq : "", /* ERP 부서 시퀀스 */
    erpDeptName : "", /* ERP 부서 명칭 */
    empSeq : "", /* 사원 시퀀스 */
    erpEmpSeq : "", /* ERP 사원 시퀀스 */
    useYN : "0", /* 예산관리여부 ( iCUBE ) : 예산통제 > 1, 예산미통제 > 0 */
    budgetType : "", /* 예산통제 구분 ( iCUBE ) : 결의부서 > 0 / 사용부서 > 1 / 프로젝트 > 2 */
    budgetYm : "", /* 예산년월 */
    budgetGbn : "", /* 통제구분 ( 년, 반기, 분기, 월 ) */
    budYm : "", /* 예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... ) */
    budgetCode : "", /* 예산단위 코드 */
    budgetName : "", /* 예산단위 명칭 */
    projectCode : "", /* 프로젝트 코드 */
    projectName : "", /* 프로젝트 명칭 */
    bizplanCode : "", /* 사업계획 코드 */
    bizplanName : "", /* 사업계획 명칭 */
    bgacctCode : "", /* 예산계정 코드 */
    bgacctName : "", /* 예산계정 명칭 */
    budgetJsum : "0", /* 예산진행금액 ( 편성 + 조정 금액 ) */
    budgetActsum : "0", /* 예산 실행합 금액 ( 사용예산 금액 ) */
    budgetAmAction : "0", /* 문서상 예산 신청 금액 */
    budgetGwAct : "0", /* 예산 실행합 금액 ( 사용예산 금액 >> iCUBE ) */
    budget_controlYN : "N", /* 예산 통제 여부 */
    amt : "0.00", /* 예산체크시 체크 금액 >> 결재작성시 사용 */
    searchStr : "", /* 검색어 */
    callback : "", /* 콜백 */
    createSeq : "", /* 최초 생성자 */
    modifySeq : "" /* 최종 수정자 */
};

/* 지출결의 현황 */
var ExReportSend = {
    compSeq : "0", /* 회사 시퀀스 */
    erpCompSeq : "", /* ERP 회사 시퀀스 */
    empSeq : "", /* 사원 시퀀스 */
    expendSeq : "0", /* 지출결의 시퀀스 */
    docSeq : "0", /* 전자결재 시퀀스 */
    appDocNo : "", /* 전자결재 문서번호 */
    appRepDate : "", /* 전자결재 기안일자 */
    appDocTitle : "", /* 전자결재 문서제목 */
    expendDate : "", /* 결의일자 ( 회계일자, 예산년월 ) */
    expendReqDate : "", /* 지급요청일자 ( 만기일자 ) */
    appUserName : "", /* 상신자 */
    expendEmpSeq : "0", /* 사용자 시퀀스 */
    expendUseDeptName : "", /* 사용 부서 명 */
    expendUseEmpName : "", /* 사용자 명 */
    expendAmt : "0", /* 금액 */
    expendErpSendYn : "", /* ERP 전송상태 */
    expendErpSendSeq : "0", /* ERP 전송자 시퀀스 */
    expendErpSendName : "", /* ERP 전송자 명 */
    expendErpiuAdocuId : "", /* ERPiU row_id */
    expendIcubeAdocuId : "", /* iCUBE in_dt */
    expendIcubeAdocuSeq : "0", /* iCUBE in_sq */
    searchDocStatus : "", /* 전자결재 문서 상태 코드 */
    searchFromDate : "", /* 검색조건 결의일자 시작일 */
    searchToDate : "" /* 검색조건 결의일자 종료일 */
}

/* 지출결의 확인 */
var ExReportExpend = {
    comp_seq : "",
    erp_comp_seq : "",
    seq : "",
    doc_no : "", /* 문서법호 */
    doc_subject : "", /* 제목 */
    req_dt : "", /* 기안일자 */
    writer : "", /* 기안자 */
    use_dept : "", /* 사용부서 */
    user_nm : "", /* 사용자 */
    expend_amt : "",
    doc_sts : "", /* 문서상태 */
    to_date : "", /* 조회 시작일자 */
    from_date : "" /* 조회 종료일자 */
}

/* 법인카드사용내역 확인 */
var ExReportCard = {
    comp_seq : "",
    erp_comp_seq : "",
    seq : "",
    card_no : "", // 카드번호
    card_nm : "", // 법인카드명
    user_nm : "", // 사용자
    approval_no : "", // 승인번호
    approval_dr : "", // 승인일시
    cancel_dt : "", // 승인취소일시
    account : "", // 거래처
    no_tax : "", // 매입불공제
    supply_amt : "", // 공급액
    vat_amt : "", // 부가세
    total_amt : "", // 합계
    appdoc_yn : "", // 상신구분
    doc_no : "", // 문서번호
    list_no : "", // 전표번호
    item_no : "", // 순번
    to_date : "", // 검색시작일
    from_date : "" // 검색종료일
}

/* 매입전자세금계산서 */
var ExCodeETax = {
    comp_seq : "", /* BizboxA *//* 회사 시퀀스 */
    erp_comp_seq : "", /* iCUBE *//* ERPiU *//* 회사 시퀀스 */
    iss_no : "", /* iCUBE *//* 승인번호 */
    co_cd : "", /* iCUBE *//* 회사코드 */
    div_cd : "", /* iCUBE *//* 사업장코드 */
    tr_cd : "", /* iCUBE *//* 거래처코드 */
    iss_dt : "", /* iCUBE *//*
                             * 작성일자 >> EXCEL :B열 (세금계산서 작성일자에 찍히는 날짜"
                             * :전표일자isu_dt?,신고기준일tax_dt? )
                             */
    tax_ty : "", /* iCUBE *//* 매입매출구분 >> 1.매출 2.매입 3.면세매출 4.면세매입 */
    isu_dt : "", /* iCUBE *//* 발급일자 >> EXCEL :D열 (국세청에 들어온 날짜) */
    divreg_nb : "", /* iCUBE *//* 사업장사업자번호 */
    divsub_nb : "", /* iCUBE *//* 사업장종사업장번호 */
    div_nm : "", /* iCUBE *//* 사업장상호명 */
    divceo_nm : "", /* iCUBE *//* 사업장대표자명 */
    trreg_nb : "", /* iCUBE *//* 거래처사업자번호 */
    trsub_nb : "", /* iCUBE *//* 거래처종사업장번호 */
    tr_nm : "", /* iCUBE *//* 거래처명 */
    trceo_nm : "", /* iCUBE *//* 거래처대표자명 */
    sum_am : "0.00", /* iCUBE *//* 합계액 */
    sup_am : "0.00", /* iCUBE *//* 공급가액 */
    vat_am : "0.00", /* iCUBE *//* 부가세액 */
    etax_ty : "", /* iCUBE *//* 세금계산서구분 >> 1.일반, 2.수정 */
    etax_fg : "", /* iCUBE *//*
                                 * 전자세금계산서종류 >> 1.일반, 1.일반(수정), 2.영세율,
                                 * 2.영세율(수정), 3.위수탁, 4.수입, 5.위수탁영세율
                                 */
    send_fg : "", /* iCUBE *//*
                                 * 발행유형 >>
                                 * 1.인터넷발행,2.ARS발행,3.VAN발행,4.ASP발행,5.자체발행,6.지로발행,7.대리발행
                                 */
    dummy1 : "", /* iCUBE *//* 비고 */
    dummy2 : "", /* iCUBE *//* 기타(영수/청구 구분) >> 영수 OR 청구 */
    iss_ymd : "", /* iCUBE *//* 전송일자 */
    item_dc : "", /* iCUBE *//* 품목명 */
    addtax_cd : "", /* iCUBE *//*
                                 * 가산세코드 >> 0.해당없음. 1.지연발급, 2.미발급,
                                 * 3.지연수취(공제),4.지연수취(불공제), 5.지연전송, 6.미전송
                                 */
    addtax_am : "0.00", /* iCUBE *//* 가산세액 */
    addrte_rt : "0.00", /* iCUBE *//* 세율 */
    email_dc : "", /* iCUBE *//* 공급자이메일 */
    trcharge_email : "", /* iCUBE *//* 공급받는자이메일 */

    search_from_dt : "", /* iCUBE *//* ERPiU *//* 검색시작일 */
    search_to_dt : "", /* iCUBE *//* ERPiU *//* 검색종료일 */
    search_iss_no : "", /* iCUBE *//* ERPiU *//* 승인번호 검색 문자열 */
    search_partner_nm : "", /* iCUBE *//* ERPiU *//* 공급자 상호 검색 문자열 */
    search_partner_no : "" /* iCUBE *//* ERPiU *//* 공급자 등록번호 문자열 */
};

/* 지출결의 환경설정 */
var ExConfigOption ={
	comp_seq : "0",	/* 회사 시퀀스 */
	form_seq : "0",	/* 양식 시퀀스 */
	option_gbn : "",	/* 옵션 대구분 */
	option_code	: "",	/* 옵션 상세구분 */
	use_sw : "",	/* 사용시스템 */
	order_num : "0",	/* 정렬순서 */
	common_code	: "",	/* 귀속 공통코드 */
	base_code : "",	/* 기본값 */
	base_value : "",	/* 기본값 */
	base_name : "",	/* 기본값 */
	base_emp_value : "",	/* 기본값 */
	set_value : "",	/* 설정값 */
	set_name : "",	/* 설정값 */
	set_emp_value : "",	/* 설정값 */
	option_select_type : "",	/* 옵션표현형태 */
	optioin_process_type : "",	/* 옵션사용형태 */
	option_name	: "",	/* 옵션명칭 */
	option_note	: "",	/* 옵셩설명 */
	use_yn : "Y",	/* 사용여부 */
	lang_code : "kr",	/* 언어코드 */
	create_seq : "0",	/* 생성자 */
	modify_seq : "0"	/* 수정자 */
};

// Ajax Call
function callAjax( url, param, successFnc, errorFnc, sync ) {
    $.ajax({
        type : "post",
        url : url,
        datatype : "json",
        data : param,
        async : sync,
        success : function( data ) {
            successFnc(data);
        },
        error : function( data ) {
            errorFnc(data);
        }
    });
}

// ComboBox 처리
function setComboBox( target, source, changeEvent, selectEvent ) {
    var $comboBox = $(target);
    changeEvent = (changeEvent || '');

    if (typeof source === 'string') {
        source = JSON.parse(source);
    }

    if (typeof source === 'object') {
        if (JSON.stringify(source).indexOf('[') != 0) {
            source = JSON.parse('[' + JSON.stringify(source) + ']');
        }

        $comboBox.kendoComboBox({
            dataSource : source,
            dataTextField : 'commonName',
            dataValueField : 'commonCode',
            index : 0,
            change : function( e ) {
                if (typeof changeEvent === 'function') {
                    changeEvent();
                } else {
                    return;
                }
            },
        	select : function( e ) {
                if (typeof selectEvent === 'function') {
                	selectEvent();
                } else {
                    return;
                }
            } 
        });
    } else {
        return;
    }
}

// 체크박스 전체 체크/언체크
//function fnAllCheckBoxChecked( obj, objChked ) {
//    var chk = $('input[name=' + objChked + ']');
//    $.each(chk, function( idx, target ) {
//        $(target).prop('checked', obj.checked);
//    });
//}

// 휠이벤트 처리 ( 휠 이동시, 스크롤 이동 제한 )
function fnSetWheelPrevent( target ) {
    var box = $(target);
    var height = box.height();
    var scrollHeight = box.get(0).scrollHeight;

    box.bind('mousewheel', function( event, d ) {
        if (event.originalEvent.wheelDelta < 0) {
            d = -1; // scroll down
        } else {
            d = 1; // scroll up
        }

        if ((this.scrollTop === (scrollHeight - height) && d < 0) || (this.scrollTop === 0 && d > 0)) {
            event.preventDefault();
        }
    });
}

function callDlg( url, width, height, title, actions ) {
    // $(".modal").fadeIn(700);
    var dialog = document.getElementById('dialog');

    if (dialog == null) {
        dialog = [ document.createElement('div') ]
        dialog.setAttribute('id', 'dialog');
        body[0].appendChild(dlg[0]);
    }

    if ((url || '') == '') { return; }

    title = (title || '');

    // actions : [ "Minimize", "Close", "Refresh" ]
    actions = (actions || [ "Close" ]);

    width = width.replace(/[^0-9]/g, ''); // 숫자만 처리
    height = height.replace(/[^0-9]/g, ''); // 숫자만 처리

    var kendoWin = $(dialog);

    kendoWin.kendoWindow({
        iframe : true,
        draggable : false,
        width : width,
        height : height,
        title : title,
        visible : false,
        content : {
            url : url,
            type : "POST",
        },
        actions : actions
    }).data("kendoWindow").center().open();
}

function closeDlg() {
    // $(".modal").fadeOut(700);
    $("#dialog").data("kendoWindow").close();
}

function fnGetName( caller ) {
    var f = arguments.callee.caller;
    if (caller) f = f.caller;
    var pat = /^function\s+([a-zA-Z0-9_]+)\s*\(/i;
    pat.exec(f);
    var func = new Object();
    func.name = RegExp.$1;
    return func;
}

/*-------------------------------------------------------------------------*/
/* 이벤트 정의 */
/*-------------------------------------------------------------------------*/
/* 이벤트 정의 */
function fnCodeInitEvent() {
    /* 공통사항 */
    var param = {};
    /* 무슨이유인지 모르겠으나, button tag 가 아닌, input tag 를 사용함 ( 퍼블리싱 파트에서 이렇게 제공 ) */
    $('input[type=button]').click(function( event ) {
        fnCodeEventButton(event);
    }); /* 버튼클릭 이벤트 정의 */

    /* 이벤트별 처리 */
    // if (window[fnGetName().name + '_' + ifSystemType]) {
    // window[fnGetName().name + '_' + ifSystemType](param);
    // }
    return;
}

/*-------------------------------------------------------------------------*/
/* 버튼클릭 이벤트 정의 */
/*-------------------------------------------------------------------------*/
function fnCodeEventButton( event ) {
    /* console.log('CommonEX : fnCodeEventButton'); */
    /* 공통사항 */
    var eventType = event.target.id.replace('btn', '');
    var param = {};

    /* 버튼별 처리 *//* 신규 / 저장 / 삭제 */
    if (window[fnGetName().name + '_' + eventType]) {
        window[fnGetName().name + '_' + eventType](param);
    }

    return;
}

/* 취소 */
function fnCodeEventButton_Close() {
    /* 레이어 종료 */
    layerPopClose();
    return;
}

/* &#39; ' 기호 변경 함수 */
function fnConvertSpecialCharater( data ){
	var result = data;
//	result = result.toString().replace(/&#39;/g,'\'').replace(/&quot;/g,'\"');
//	result = result.toString().replace(/&quot;/g,'\"');
	result = result.toString().replace(/&#39;/g,'\'');
//	if( result.indexOf("&quot;") > -1 ){
//		result = result.replaceAll("&quot;", "\"");
//	}
	return result
}
