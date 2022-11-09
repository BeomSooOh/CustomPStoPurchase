/* commonCode : 조회된 공통코드 저장 변수 */
var commonCode = {};

/* getExpendCodes : 공통코드 조회 반환 */
var getExpendCodes = function( type ) {
    /* 변수정의 */
    var methods = {
        /* summary : 표준적요 조회 */
        summary : function() {
            log(' ! [FNC] getExpendCodes - summary');
            var result = ajax({
                url : "/expend/user/code/ExUserSummaryListInfoSelect.do",
                async : false,
                parameter : ""
            });

            log(result);

            /*
             * var result2 = ajax({ url :
             * "/expend/user/code/ExUserSummaryListInfoSelect.do", async :
             * false, parameter : "" });
             * 
             * var result3 = ajax({ url :
             * "/expend/user/code/ExUserSummaryListInfoSelect.do", async :
             * false, parameter : "" });
             * 
             * var result4 = ajax({ url :
             * "/expend/user/code/ExUserSummaryListInfoSelect.do", async :
             * false, parameter : "" });
             * 
             * var result5 = ajax({ url :
             * "/expend/user/code/ExUserSummaryListInfoSelect.do", async :
             * false, parameter : "" });
             */

            if (typeof result === "object") {
                if (typeof result.aaData === "object") {
                    commonCode.summary = result.aaData;
                    return commonCode.summary;
                }
            }

            return [];
        },
        /* auth : 증빙유형 조회 */
        auth : function() {
            log(' ! [FNC] getExpendCodes - auth');
            var result = ajax({
                url : "/expend/user/code/ExUserAuthListInfoSelect.do",
                async : false,
                parameter : ""
            });
            
            log(result);

            if (typeof result === "object") {
                if (typeof result.aaData === "object") {
                    commonCode.auth = result.aaData;
                    return commonCode.auth;
                }
            }

            return [];
        },
        /* project : 프로젝트 조회 */
        project : function() {
            log(' ! [FNC] getExpendCodes - project');
            var result = ajax({
                url : "/expend/user/code/ExUserProjectListInfoSelect.do",
                async : false,
                parameter : ""
            });
            
            log(result);

            if (typeof result === "object") {
                if (typeof result.aaData === "object") {
                    commonCode.project = result.aaData;
                    return commonCode.project;
                }
            }
        },
        /* partner : 거래처 조회 */
        partner : function() {
            log(' ! [FNC] getExpendCodes - partner');
            var result = ajax({
                url : "/expend/user/code/ExUserPartnerListInfoSelect.do",
                async : false,
                parameter : ""
            });
            
            log(result);

            if (typeof result === "object") {
                if (typeof result.aaData === "object") {
                    commonCode.partner = result.aaData;
                    return commonCode.partner;
                }
            }

            return [];
        },
        /* card : 카드 조회 */
        card : function() {
            log(' ! [FNC] getExpendCodes - card');
            var result = ajax({
                url : "/expend/user/code/ExUserCardListInfoSelect.do",
                async : false,
                parameter : ""
            });
            
            log(result);

            if (typeof result === "object") {
                if (typeof result.aaData === "object") {
                    commonCode.card = result.aaData;
                    return commonCode.card;
                }
            }

            return [];
        },
        /* car : 차량 조회 */
        car : function() {
            log(' ! [FNC] getExpendCodes - car');
            log(' ! [FNC] getExpendCodes - car >> 구현되지 않았습니다.');            
            
            return [];
        },
        /* emp : 사용자 조회 */
        emp : function() {
            log(' ! [FNC] getExpendCodes - emp');
            log(' ! [FNC] getExpendCodes - emp >> 구현되지 않았습니다.');

            return [];
        }
    };

    /* 프로세스 */
    log('+ [FNC] getExpendCodes(' + type + ')');
    /* 변수정의 */
    var result = null;
    /* 공통코드 존재 여부 확인 */
    if (commonCode[type] === 'object') {
        if (commonCode[type].length > 0) {
            result = commonCode[type];
        }
    }

    /* 공통코드 조회 */
    if (result === null) {
        if (typeof methods[type] === 'function') {
            result = methods[type]();
        } else {
            log(' ! [FNC] getExpendCodes - not exists API >> ' + type);
        }
    }
    log('- [FNC] getExpendCodes(' + type + ')');

    return result;
}


/*지출결의 작성 사용 변수*/
var expendType = {
    "emp" : "emp",
    "dept" : "dept",
    "pc" : "pc",
    "cc" : "cc",
    "summary" : "summary",
    "auth" : "auth",
    "note" : "note",
    "project" : "project",
    "card" : "card",
    "partner" : "partner",
    "notax" : "notax",
    "budget" : "budget",
    "bizplan" : "bizplan",
    "bgacct" : "bgacct"
};

/* 지출결의 작성 사용 변수 - 지출결의 */
var ExExpend = {
    comp_seq : "", /* 귀속회사 시퀀스 */
    erp_comp_seq : "", /* ERP 회사코드 */
    expend_seq : "", /* 지출결의 시퀀스 */
    doc_seq : "", /* 전자결재 시퀀스 */
    expend_stat_code : "", /* 지출결의 상태코드 ( 전자결재 동일, 상태값 변경 비교를 위해 사용 ) */
    expend_date : "", /* 결의일자 ( 회계일자, 예산년월 ) */
    expend_req_date : "", /* 지급요청일자 ( 만기일자 ) */
    erp_send_yn : "", /* ERP 전송여부 ( 전송 : Y / 미전송 : N ) */
    write_seq : "0", /* 작성자 */
    emp_seq : "0", /* 사용자 */
    budget_seq : "0", /* 예산 */
    project_seq : "0", /* 프로젝트 */
    partner_seq : "0", /* 거래처 */
    card_seq : "0", /* 카드 */
    json_str : "", /* 지출결의 JSON 문자열 */
    erp_send_seq : "0", /* 지출결의 > 자동전표 전송자 */
    row_id : "", /* ERPiU 자동전표 아이디 */
    in_dt : "", /* iCUBE 자동전표 아이디 마스터 */
    in_sq : "", /* iCUBE 자동전표 아이디 디테일 */
    form_seq : "0", /* 양식 아이디 */
    create_seq : "", /* 생성자 */
    modify_seq : "" /* 수정자 */
};

/* 지출결의 작성 사용 변수 - 지출결의 - 항목 */
var ExExpendList = {
    comp_seq : "", /* 귀속회사 시퀀스 */
    erp_comp_seq : "", /* ERP 회사코드 */
    expend_seq : "", /* 지출결의 시퀀스 */
    list_seq : "", /* 지출결의 항목 시퀀스 */
    summary_seq : "0", /* 표준적요 시퀀스 */
    auth_seq : "0", /* 증빙유형 시퀀스 */
    write_seq : "0", /* 작성자 시퀀스 */
    emp_seq : "0", /* 사용자 시퀀스 */
    budget_seq : "0", /* 예산 시퀀스 */
    project_seq : "0", /* 프로젝트 시퀀스 */
    partner_seq : "0", /* 거래처 시퀀스 */
    card_seq : "0", /* 카드 시퀀스 */
    auth_date : "", /* 증빙일자 */
    note : "", /* 적요 */
    std_amt : "0", /* 공급가액 */
    tax_amt : "0", /* 부가세액 */
    amt : "0", /* 공급대가 */
    sub_std_amt : "0", /* 과세표준액 */
    sub_tax_amt : "0", /* 세액 */
    interface_type : "", /* 외부연동 구분 값 */
    interface_m_id : "", /* 외부연동 마스터 아이디 */
    interface_d_id : "", /* 외부연동 디테일 아이디 */
    json_str : "",
    form_seq : "0",
    create_seq : "", /* 생성자 */
    modify_seq : "" /* 수정자 */
};

/* 지출결의 작성 사용 변수 - 지출결의 - 항목 - 분개 */
var ExExpendSlip = {
    comp_seq : "0", /* 귀속 회사 시퀀스 */
    erp_comp_seq : "", /* ERP 회사코드 */
    expend_seq : "0", /* 지출결의 시퀀스 */
    list_seq : "0", /* 지출결의 항목 시퀀스 */
    slip_seq : "0", /* 지출결의 항목 분개 시퀀스 */
    summary_seq : 0, /* 표준적요 시퀀스 */
    auth_seq : 0, /* 증빙유형 시퀀스 */
    write_seq : 0, /* 작성자 시퀀스 */
    emp_seq : 0, /* 사용자 시퀀스 */
    budget_seq : 0, /* 예산 시퀀스 */
    project_seq : 0, /* 프로젝트 시퀀스 */
    partner_seq : 0, /* 거래처 시퀀스 */
    card_seq : 0, /* 카드 시퀀스 */
    drcr_gbn : "", /* 차대 구분 */
    acct_code : "", /* 계정과목 코드 */
    acct_name : "", /* 계정과목 명칭 */
    vat_yn : "N", /* 부가세여부 */
    auth_date : "", /* 증빙일자 */
    note : "", /* 적요 */
    amt : "0", /* 금액 */
    sub_std_amt : "0", /* 과세표준액 */
    sub_tax_amt : "0", /* 세액 */
    interface_type : "-", /* 외부연동 구분 값 */
    interface_m_id : "0", /* 외부연동 마스터 아이디 */
    interface_d_id : "0", /* 외부연동 디테일 아이디 */
    row_id : "", /* ERPiU GMMSUM 연동 KEY 1 */
    row_no : "", /* ERPiU GMMSUM 연동 KEY 2 */
    json_str : "",
    form_seq : "0", /* 양식 아이디 */
    callback : "",
    create_seq : "0", /* 생성자 */
    modify_seq : "0" /* 수정자 */
};

/* 지출결의 작성 사용 변수 - 지출결의 - 항목 - 분개 - 관리항목 */
var ExExpendMng = {
    comp_seq : "",
    erp_comp_seq : "",
    expend_seq : "0",
    list_seq : "0",
    slip_seq : "0",
    mng_seq : "0",
    acct_code : "",
    acct_name : "",
    mng_code : "",
    mng_name : "",
    mng_form_code : "",
    mng_child_yn : "",
    mng_stat : "",
    ctd_code : "",
    ctd_name : "",
    json_str : "",
    form_seq : "0",
    search_str : "",
    callback : "",
    create_seq : "0",
    modify_seq : "0"
};

/* 지출결의 - 표준적요 */
var ExCodeSummary = {
    seq : "0",
    comp_seq : "", /* 회사코드 */
    summary_code : "", /* 표준적요 코드 */
    summary_name : "", /* 표준적요 명칭 */
    summary_div : "", /* 표준적요 구분 ( A : 지출 / B : 매입 ) */
    dr_acct_code : "", /* 차변 계정과목 코드 */
    dr_acct_name : "", /* 차변 계정과목 명칭 */
    cr_acct_code : "", /* 대변 계정과목 코드 */
    cr_acct_name : "", /* 대변 계정과목 명칭 */
    vat_acct_code : "", /* 부가세 계정과목 코드 */
    vat_acct_name : "", /* 부가세 계정과목 명칭 */
    bank_partner_code : "", /* 금융거래처 코드 */
    bank_partner_name : "", /* 금융거래처 명칭 */
    form_seq : "0",
    callback : "",
    search_str : "", /* 검색어 */
    create_seq : "0", /* 생성자 */
    modify_seq : "0" /* 수정자 */
};

/* 지출결의 - 증빙유형 */
var ExCodeAuth = {
    seq : "0",
    comp_seq : "",
    auth_div : "",
    auth_code : "",
    auth_name : "",
    cash_type : "",
    cr_acct_code : "",
    cr_acct_name : "",
    vat_acct_code : "",
    vat_acct_name : "",
    vat_type_code : "",
    vat_type_name : "",
    erp_auth_code : "",
    erp_auth_name : "",
    auth_required_yn : "N",
    partner_required_yn : "N",
    card_required_yn : "N",
    project_required_yn : "N",
    note_required_yn : "N",
    no_tax_code : "",
    no_tax_name : "",
    order_num : "",
    use_yn : "Y",
    va_type_code : "",
    va_type_name : "",
    create_seq : "",
    modify_seq : "",
    search_str : "",
    form_seq : "",
    callback : ""
};

/* 지출결의 - 계정과목 */
var ExCodeAcct = {
    comp_seq : "", /* 회사코드 */
    erp_comp_seq : "", /* ERP 회사코드 */
    acct_code : "", /* 계정과목코드 */
    acct_name : "", /* 계정과목명칭 */
    vat_yn : "", /* 부가세구분 */
    use_yn : "", /* 사용여부 */
    form_seq : "0", /* 양식아이디 */
    search_type : "", /* 계정과목 검색 조건 */
    search_str : "", /* 검색어 */
    callback : "", /* 콜백 */
    create_seq : "", /* 최초작성자 */
    modify_seq : "" /* 최종수정자 */
}

/* 지출결의 - 관리항목 */
var ExCodeMng = {
    comp_seq : "0", /* 회사 시퀀스 */
    erp_comp_seq : "", /* ERP 회사 시퀀스 */
    form_seq : "0", /* 양식 시퀀스 */
    mng_code : "", /* 관리항목 코드 */
    mng_name : "", /* 관리항목 명칭 */
    ctd_code : "", /* 관리항목 입력 코드 */
    ctd_name : "", /* 관리항목 입력 명칭 */
    note : "", /* 비고 */
    mng_type : "", /* 관리항목 코드 그룹 */
    mng_child_yn : "", /* 관리항목 하위코드 존재여부 */
    mng_form : "", /* 관리항목 입력 형식 */
    drcr_gbn : "", /* 차대구분 */
    use_gbn : "", /* 사용자정의 타입 */
    use_gbn_name : "", /* 사용자정의 타입 명칭 */
    cust_set : "", /* 커스터마이징 구분 ( 프로시저, 쿼리 ) */
    cust_set_target : "", /* 프로시저, 쿼리 구동 대상 */
    modify_yn : "Y", /* 수정가능여부 ( 전용개발인 경우, 사용자에 의해 수정 및 삭제가 진행되면 안되기 때문 ) */
    create_seq : "0", /* 생성자 */
    modify_seq : "0", /* 수정자 */
    search_str : "" /* 검색어 */
}

/* 지출결의 - 조직도 */
var ExCodeOrg = {
    seq : 0,
    comp_seq : "",
    comp_name : "",
    biz_seq : "",
    biz_name : "",
    dept_seq : "",
    dept_name : "",
    emp_seq : "",
    emp_name : "",
    erp_comp_seq : "",
    erp_comp_name : "",
    erp_biz_seq : "",
    erp_biz_name : "",
    erp_dept_seq : "",
    erp_dept_name : "",
    erp_emp_seq : "",
    erp_emp_name : "",
    erp_pc_seq : "",
    erp_pc_name : "",
    erp_cc_seq : "",
    erp_cc_name : "",
    form_seq : "",
    lang_code : "",
    search_str : "",
    callback : "",
    create_seq : "",
    modify_seq : ""
};

/* 지출결의 - 거래처 */
var ExCodePartner = {
    seq : "0",
    comp_seq : "",
    erp_comp_seq : "",
    partner_code : "",
    partner_name : "",
    partner_no : "",
    partner_fg : "",
    ceo_name : "",
    job_gbn : "",
    cls_job_gbn : "",
    deposit_no : "",
    bank_code : "",
    partner_emp_code : "",
    partner_hp_emp_no : "",
    deposit_name : "",
    deposit_convert : "",
    callback : "",
    form_seq : "",
    search_str : "",
    search_type : "",
    create_seq : "",
    modify_seq : ""
};
/* 지출결의 - 프로젝트 */
var ExCodeProject = {
    seq : "0",
    comp_seq : "",
    userSe : "",
    dept_seq : "",
    emp_seq : "",
    erp_comp_seq : "",
    project_code : "",
    project_name : "",
    callback : "",
    form_seq : "",
    search_str : "",
    create_seq : "",
    modify_seq : ""
};
/* 지출결의 - 카드 */
var ExCodeCard = {
    seq : "0", /* 시퀀스 */
    comp_seq : "", /* 회사코드 */
    emp_comp_seq : "", /* ERP 회사 시퀀스 */
    card_code : "", /* 카드코드 */
    card_num : "", /* 카드번호 */
    card_name : "", /* 카드명칭 */
    partner_code : "", /* 금융거래처코드 */
    partner_name : "", /* 금융거래처명칭 */
    card_public_json : "", /* 공개범위 interface JSON 문자열 */
    card_public : "", /* 공개범위 입력 데이터 JSON Array 문자열 */
    use_yn : "Y", /* 사용여부 */
    erp_comp_seq : "", /* ERP회사코드 */
    bank_partner_code : "", /* ERPiU 금융거래처 코드 */
    bank_partner_name : "", /* ERPiU 금융거래처 명칭 */
    callback : "", /* 콜백 */
    form_seq : "0", /* 양식 시퀀스 */
    search_str : "", /* 검색문자열 */
    search_type : "", /* 검색구분 ( IN : BizboxA / OUT : 연동시스템 ) */
    create_seq : "0", /* 최초 생성자 */
    modify_seq : "0", /* 최종 수정자 */

    search_from_date : "", /* 검색 시작일 */
    search_to_date : "", /* 검색 종료일 */
    search_card_num : "", /* 검색 카드번호 */

    sync_id : "0", /* 카드 사용내역 키값 */
    auth_date : "", /* 거래 승인일자 */
    auth_time : "", /* 증빙시간 */
    auth_num : "", /* 승인번호 */
    georae_cand : "", /* 거래 취소일자 */
    merc_name : "", /* 거래처 명칭 */
    merc_saup_no : "", /* 거래처 사업자 등록 번호 */
    merc_tel : "", /* 거래처 유선 연락처 */
    merc_zip : "", /* 사업장 주소 우편번호 */
    merc_addr : "", /* 사업장 주소 */
    gongje_no_chk : "N", /* 불공제 여부 */
    mcc_stat : "", /* 거래처 구분 */
    request_amount : "0", /* 공급가액 */
    vat_md_amount : "0", /* 부가세액 */
    amt_md_amount : "0", /* 공급대가 */
    ser_amount : "0", /* 서비스 금액 */
    emp_seq : "", /* 사용자 시퀀스 */
    disp_emp_name : "", /* 사용자 표현 명칭 */
    dept_seq : "", /* 사용자 부서 시퀀스 */
    erp_dept_seq : "", /* ERP 사용자 부서 시퀀스 */
    emp_name : "", /* 사용자 명 */
    erp_emp_name : "", /* ERP 사용자 명 */
    summary_seq : "", /* 표준적요 시퀀스 */
    disp_summary_name : "", /* 표준적요 표현 명칭 */
    summary_name : "", /* 표준적요 명칭 */
    dr_acct_code : "", /* 차변 계정과목 코드 */
    dr_acct_name : "", /* 차변 계정과목 명칭 */
    auth_seq : "", /* 증빙유형 시퀀스 */
    disp_auth_name : "", /* 증빙유형 표현 명칭 */
    auth_name : "", /* 증빙유형 명칭 */
    project_seq : "", /* 프로젝트 시퀀스 */
    disp_project_name : "", /* 프로젝트 표현 명칭 */
    project_code : "", /* 프로젝트 코드 */
    project_name : "", /* 프로젝트 명칭 */
    budget_seq : "", /* 예산 시퀀스 */
    disp_budget_name : "", /* 예산단위 표현 명칭 */
    disp_bizplan_name : "", /* 사업계획 표현 명칭 */
    disp_bgacct_name : "", /* 예산계정 표현 명칭 */
    budget_name : "", /* 예산단위 명칭 */
    bizplan_name : "", /* 사업계획 명칭 */
    bgacct_name : "", /* 예산계정 명칭 */
    note : "", /* 적요 */

    send_yn : "N", /* 상신여부 */
    user_send_yn : "N", /* 관리자 마감 처리 여부 */
    if_m_id : "0", /* 외부연동 아이디 */
    if_d_id : "0", /* 외부연동 아이디 */

    georae_stat : "", /* 승인구분 */
    abroad : "", /* 해외결재여부 */
    doc_seq : "", /* 전자결재 아이디 */

    doc_no : "", /* 전자결재 문서 번호 */
    doc_title : "", /* 전자결재 문서 제목 */
    doc_sts : "", /* 전자결재 문서 상태 */
    doc_use_yn : "", /* 전자결재 삭제 여부 */
    form_mode : "", /* 전자결재 양식 모드 */

    merc_repr : "" /* 거래처 대표자 명 */
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
    expend_seq : "",
    list_seq : "",
    slip_seq : "",
    row_id : "", /* 임시예산 연동 아이디 마스터 */
    row_no : "", /* 임시예산 연동 아이디 디테일 */
    comp_seq : "", /* 회사 시퀀스 */
    erp_comp_seq : "", /* ERP 회사 시퀀스 */
    dept_seq : "", /* 부서 시퀀스 */
    dept_name : "", /* 부서 명칭 */
    erp_dept_seq : "", /* ERP 부서 시퀀스 */
    erp_dept_name : "", /* ERP 부서 명칭 */
    emp_seq : "", /* 사원 시퀀스 */
    erp_emp_seq : "", /* ERP 사원 시퀀스 */
    use_yn : "0", /* 예산관리여부 ( iCUBE ) : 예산통제 > 1, 예산미통제 > 0 */
    budget_type : "", /* 예산통제 구분 ( iCUBE ) : 결의부서 > 0 / 사용부서 > 1 / 프로젝트 > 2 */
    budget_ym : "", /* 예산년월 */
    budget_gbn : "", /* 통제구분 ( 년, 반기, 분기, 월 ) */
    bud_ym : "", /* 예산년월 귀속 ( 1Q, 2Q, 3Q, 4Q, Y, M .... ) */
    budget_code : "", /* 예산단위 코드 */
    budget_name : "", /* 예산단위 명칭 */
    project_code : "", /* 프로젝트 코드 */
    project_name : "", /* 프로젝트 명칭 */
    bizplan_code : "", /* 사업계획 코드 */
    bizplan_name : "", /* 사업계획 명칭 */
    bgacct_code : "", /* 예산계정 코드 */
    bgacct_name : "", /* 예산계정 명칭 */
    budget_jsum : "0", /* 예산진행금액 ( 편성 + 조정 금액 ) */
    budget_actsum : "0", /* 예산 실행합 금액 ( 사용예산 금액 ) */
    budget_am_action : "0", /* 문서상 예산 신청 금액 */
    budget_gw_act : "0", /* 예산 실행합 금액 ( 사용예산 금액 >> iCUBE ) */
    budget_control_yn : "N", /* 예산 통제 여부 */
    amt : "0.00", /* 예산체크시 체크 금액 >> 결재작성시 사용 */
    search_str : "", /* 검색어 */
    callback : "", /* 콜백 */
    create_seq : "", /* 최초 생성자 */
    modify_seq : "" /* 최종 수정자 */
};

/* 지출결의 현황 */
var ExReportSend = {
    comp_seq : "0", /* 회사 시퀀스 */
    erp_comp_seq : "", /* ERP 회사 시퀀스 */
    emp_seq : "", /* 사원 시퀀스 */
    expend_seq : "0", /* 지출결의 시퀀스 */
    doc_seq : "0", /* 전자결재 시퀀스 */
    app_doc_no : "", /* 전자결재 문서번호 */
    app_rep_date : "", /* 전자결재 기안일자 */
    app_doc_title : "", /* 전자결재 문서제목 */
    expend_date : "", /* 결의일자 ( 회계일자, 예산년월 ) */
    expend_req_date : "", /* 지급요청일자 ( 만기일자 ) */
    app_user_name : "", /* 상신자 */
    expend_emp_seq : "0", /* 사용자 시퀀스 */
    expend_use_dept_name : "", /* 사용 부서 명 */
    expend_use_emp_name : "", /* 사용자 명 */
    expend_amt : "0", /* 금액 */
    expend_erp_send_yn : "", /* ERP 전송상태 */
    expend_erp_send_seq : "0", /* ERP 전송자 시퀀스 */
    expend_erp_send_name : "", /* ERP 전송자 명 */
    expend_erpiu_adocu_id : "", /* ERPiU row_id */
    expend_icube_adocu_id : "", /* iCUBE in_dt */
    expend_icube_adocu_seq : "0", /* iCUBE in_sq */
    search_doc_status : "", /* 전자결재 문서 상태 코드 */
    search_from_date : "", /* 검색조건 결의일자 시작일 */
    search_to_date : "" /* 검색조건 결의일자 종료일 */
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