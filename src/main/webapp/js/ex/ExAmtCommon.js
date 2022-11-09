/* ERPiU ////////////////////////////////////////////////////////////// */
/* .. [부가세 있는 프로세스] : 공급대가, 공급가액, 부가세 전송 건 - 부가세 행 셍성 */
/* ..... 공급대가 입력시 : 공급가액, 부가세 자동계산 */
/* ........ 공급가액 : 공급대가 - FLOOR ( 공급대가 / 11 ) */
/* ........ 부가세 : FLOOR ( 공급대가 / 11 ) */
/* ........ 과세표준액 : 공급대가 - FLOOR ( 공급대가 / 11 ) */
/* ........ 세액 : FLOOR ( 공급대가 / 11 ) */
/* ..... 공급가액 입력시 : 공급대가, 부가세 자동계산 */
/* ........ 공급대가 : 공급가액 + FLOOR ( 공급가액 / 10 ) */
/* ........ 부가세 : FLOOR ( 공급가액 / 10 ) */
/* ........ 과세표준액 : 공급가액 */
/* ........ 세액 : FLOOR ( 공급가액 / 10 ) */
/* ..... 부가세 입력시 : 공급대가 자동계산 */
/* ........ 공급대가 : 부가세 + 공급가액 */
/* ........ 공급가액 : 수정하지 않음 */
/* ........ 과세표준액 : 수정하지 않음 */
/* ........ 세액 : 부가세 */
/* ..... 대상 세무구분 */
/* ........ ( 21 ) 과세(매입세금계산서), ( 24 ) 기타(신용카드), ( 31 ) 현금영수증 */
/* ........ , ( 38 ) 수입(세금계산서), ( 43 ) 매입자발행세금계산서 */
/* .. [부가세는 없고, 세액만 있는 프로세스] : 부가세는 0원이지만, 세액을 전송하는 건 - 부가세 행 생성 */
/* ..... 공급대가 입력시 : 공급가액, 부가세 자동계산 */
/* ........ 공급가액 : 공급대가 */
/* ........ 부가세 : 0 */
/* ........ 과세표준액 : 공급대가 - FLOOR ( 공급대가 / 11 ) */
/* ........ 세액 : FLOOR ( 공급대가 / 11 ) */
/* ..... 공급가액 입력시 : 공급대가, 부가세 자동계산 */
/* ........ 공급대가 : 공급가액 + FLOOR ( 공급가액 / 10 ) */
/* ........ 부가세 : 0 */
/* ........ 과세표준액 : 공급가액 */
/* ........ 세액 : FLOOR ( 공급가액 / 10 ) */
/* ..... 부가세 입력시 : 공급대가 자동계산 */
/* ........ 공급대가 : 과세표준액 + 세액 */
/* ........ 공급가액 : 수정하지 않음 */
/* ........ 과세표준액 : 수정하지 않음 */
/* ........ 세액 : 부가세 */
/* ..... 대상 세무구분 */
/* ........ ( 22 ) 불공(세금계산서), ( 50 ) 불공(신용카드) */
/* .. [부가세도 없고, 세액도 없는 프로세스] : 부가세는 0원, 세액도 0원 - 부가세 행 생성 */
/* ..... 공급대가 입력시 : 공급가액, 부가세 자동계산 */
/* ........ 공급가액 : 공급대가 */
/* ........ 부가세 : 0 */
/* ........ 과세표준액 : 공급대가 */
/* ........ 세액 : 0 */
/* ..... 공급가액 입력시 : 공급대가, 부가세 자동계산 */
/* ........ 공급대가 : 공급가액 */
/* ........ 부가세 : 0 */
/* ........ 과세표준액 : 공급가액 */
/* ........ 세액 : 0 */
/* ..... 부가세 입력시 : 공급대가 자동계산 */
/* ........ 공급대가 : 공급가액 + 부가세 */
/* ........ 공급가액 : 수정하지 않음 */
/* ........ 과세표준액 : 수정하지 않음 */
/* ........ 세액 : 부가세 */
/* ..... 대상 세무구분 */
/* ........ ( 23 ) 영세(세금계산서), ( 25 ) 면세(기타), ( 26 ) 면세(계산서) */
/* ........ , ( 37 ) 현금영수증(면세), ( 39 ) 면세(신용카드), ( 60 ) 의제매입세액 */
/* ........ , ( 99 ) 영수증 */
/*  */
/* .. [프로세스가 복잡하여, 그룹웨어 미구현 사항] */
/* ..... 대상 세무구분 */
/* ........ ( 27 ) 의제(계산서 2/102), ( 28 ) 의제(기타 2/102), ( 29 ) 의제(계산서 3/103) */
/* ........ , ( 30 ) 의제(기타 3/103), ( 32 ) 의제(계산서 5/105), ( 33 ) 의제(기타 5/105) */
/*
 * ........ , ( 34 ) 의제(신용카드 2/102), ( 35 ) 의제(신용카드 3/103), ( 36 ) 의제(신용카드
 * 5/105)
 */
/* ........ , ( 40 ) 의제(계산서 6/106), ( 41 ) 의제(기타 6/106), ( 42 ) 의제(신용카드 6/106) */
/*
 * ........ , ( 44 ) 재활용(계산서 6/106), ( 45 ) 재활용(기타 6/106), ( 46 ) 재활용(계산서
 * 10/110)
 */
/* ........ , ( 47 ) 재활용(기타 10/110), ( 48 ) 의제(계산서 8/108), ( 49 ) 의제(신용카드 8/108) */
/* ........ , ( 51 ) 의제(계산서 4/104), ( 52 ) 의제(신용카드 4/104), ( 53 ) 의제(기타 4/104) */
/*
 * ........ , ( 54 ) 재활용(계산서 9/109), ( 55 ) 재활용(기타 9/109), ( 56 ) 의제(현금영수증
 * 2/102)
 */
/*
 * ........ , ( 57 ) 의제(현금영수증 4/104), ( 58 ) 의제(현금영수증 6/106), ( 59 ) 의제(현금영수증
 * 8/108)
 */

/* 고민거리 : 나중에, 반올림, 올림, 버림 옵션을 만들어야 할까? */
/* calcType > 1 : Math.round() : 반올림 */
/* calcType > 2 : Math.floor() : 버림 */
/* calcType > 3 : Math.ceil() : 올림 */

var summary = {};
var auth = {};

/* 1. 공급대가 입력 : 모든 금액이 초기화되며, 재계산 처리 됨. */
function fnInputAmt( amt, calcType, summaryParam, authParam ) {
    summary = summaryParam;
    auth = authParam;

    amt = (amt || '0').replace(/,/g, '');
    var result = {};
    if (window[fnGetName().name + '_' + ifSystem]) {
        result = window[fnGetName().name + '_' + ifSystem](amt, calcType);
        fnSetAmtNum(result);
    }
    return;
}
/* 1.1 공급대가 입력 : 모든 금액이 초기화되며, 재계산 처리 됨. - BizboxA */
function fnInputAmt_BizboxA( amt, calcType ) {
    alert('준비중입니다.. [fnInputAmt_BizboxA]');
    return;
}
/* 1.2 공급대가 입력 : 모든 금액이 초기화되며, 재계산 처리 됨. - iCUBE */
/**
 * 부가세 계정인 경우 처리를 확인해야 한다.
 */
function fnInputAmt_iCUBE( amt, calcType ) {
    /*
     * 아이큐브 부가세 구분 코드 내용 21 : 과세매입 22 : 영세매입 23 : 면세매입 24 : 매입 불공제 - 화면에는 부가세액이
     * 0원으로 표시한다. 25 : 수입 26 : 의제매입세액등 27 : 카드매입 28 : 현금영수증매입 29 : 과세매입
     * 매입자발행세금계산서분 41 : 카드기타
     * 
     * 부가세처리 관련 내용 부가세처리의 경우, 특정 부가세구분 코드가 일치 하거나, 부가세구분과 부가세대체계정이 모두 입력된 경우 부가세
     * 처리
     * 
     * 특정 부가세구분 ( ERP ICUBE ) 24 : 매입불공 - 부가세 계정 존재 - 부가세 금액 0원 - 데이터 기록상 공급가액 /
     * 부가세액 분리 저장 - 불공제구분 필수 입력 ( 기본값 : 면세사업과 관련된 분 ) - 공통매입세액안분계산서분 : 부가세 존재할 수
     * 있음. 기본값은 0원
     * 
     * 부가세처리 코드(부가세) 21:과세매입, 25 :수입, 26:의제매입세액, 27:카드매입, 28 : 현금영수증매입, 29:과세매입
     * 매입자발행세금계산서분 41:카드기타
     * 
     * 특정 부가세구분 코드가 아닌경우 부가세 처리 방법 증빙유형 : 사용자지정 부가세구분 : 사용자지정 ( 반드시 지정 ) <--
     * 분개에서 수정가능 부가세대체계정 : 사용자지정 ( 반드시 지정 )
     * 
     * 특정 부가세구분 코드가 아닌경우 부가세 미처리 방법 증빙유형 : 사용자지정 부가세구분 : 사용자지정 ( 부가세구분을 지정할 경우,
     * 부가세대체계정을 지정하면 안됨 ) 부가세대체계정 : 사용자지정 ( 부가세대체계정을 지정할 경우, 부가세구분을 지정하면 안됨 )
     */

    calcType = (calcType || '2');
    var stdAmt = 0; /* 공급가액 */
    var taxAmt = 0; /* 부가세 */
    var subStdAmt = 0; /* 과세표준액 */
    var subTaxAmt = 0; /* 세액 */

    /* 부가세 존재 */
    if ('|21|25|26|27|28|29|41|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세 있는 프로세스] : 공급대가, 공급가액, 부가세 전송 건 - 부가세 행 생성 */
        stdAmt = amt - (fnNumCalc((amt / 11), calcType)); /* 공급가액:공급대가-(공급대가/11 ) */
        taxAmt = (fnNumCalc((amt / 11), calcType)); /* 부가세 : ( 공급대가 / 11 ) */
        subStdAmt = stdAmt; /* 고세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세액 */
    } else if ('|24|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세는 없고, 세액만 있는 프로세스] : 부가세는 0원이지만, 세액을 전송하는 건 - 부가세 행 생성 */
        stdAmt = amt; /* 공급가액 : 공급대가 */
        taxAmt = 0; /* 부가세 : 0 */
        subStdAmt = amt - (fnNumCalc((amt / 11), calcType)); /* 고세표준액:공급대가-(공급대가/11 ) */
        subTaxAmt = (fnNumCalc((amt / 11), calcType));/* 세액 : 공급대가 / 11 */
    } else if ('|22|23|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세도 없고, 세액도 없는 프로세스] : 부가세는 0원, 세액도 0원 - 부가세 행 생성 */
        stdAmt = amt;
        taxAmt = 0;
        subStdAmt = stdAmt; /* 고세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세액 */
    } else {
        stdAmt = amt;
        taxAmt = 0;
        subStdAmt = amt;
        subTaxAmt = 0;
    }

    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 1.3 공급대가 입력 : 모든 금액이 초기화되며, 재계산 처리 됨. - ERPiU */
function fnInputAmt_ERPiU( amt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var stdAmt = 0; /* 공급가액 */
    var taxAmt = 0; /* 부가세 */
    var subStdAmt = 0; /* 과세표준액 */
    var subTaxAmt = 0; /* 세액 */
    /* 세무구분에 따른 분리 */
    if ('|21|24|31|38|43|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세 있는 프로세스] : 공급대가, 공급가액, 부가세 전송 건 - 부가세 행 생성 */
        stdAmt = amt - (fnNumCalc((amt / 11), calcType)); /* 공급가액:공급대가-(공급대가/11) */
        taxAmt = (fnNumCalc((amt / 11), calcType)); /* 부가세 : ( 공급대가 / 11 ) */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세액 */
    } else if ('|22|50|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세는 없고, 세액만 있는 프로세스] : 부가세는 0원이지만, 세액을 전송하는 건 - 부가세 행 생성 */
        stdAmt = amt; /* 공급가액 : 공급대가 */
        taxAmt = 0; /* 부가세 : 0 */
        subStdAmt = amt - (fnNumCalc((amt / 11), calcType)); /* 과세표준액:공급대가-(공급대가/11 ) */
        subTaxAmt = (fnNumCalc((amt / 11), calcType));/* 세액 : 공급대가 / 11 */
    } else if ('|23|25|26|37|39|60|99|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세도 없고, 세액도 없는 프로세스] : 부가세는 0원, 세액도 0원 - 부가세 행 생성 */
        stdAmt = amt;
        taxAmt = 0;
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세액 */
    } else {
        /* 지원불가항목:|27|28|29|30|32|33|34|35|36|40|41|42|44|45|46|47|48|49|51|52|53|54|55|56|57|58|59| */
        /* 지원불가항목 : 세무구분이 입력되지 않은 경우 - 부가세 행 미생성 */
        stdAmt = amt;
        taxAmt = 0;
        subStdAmt = amt;
        subTaxAmt = 0;
    }
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 2. 공급가액 입력 : 모든 금액이 초기화되며, 재계산 처리 됨. */
function fnInputStdAmt( stdAmt, calcType, summaryParam, authParam ) {
    summary = summaryParam;
    auth = authParam;

    stdAmt = (stdAmt || '0').replace(/,/g, '');
    var result = {};
    if (window[fnGetName().name + '_' + ifSystem]) {
        result = window[fnGetName().name + '_' + ifSystem](stdAmt, calcType);
        fnSetAmtNum(result);
    }
    return;
}
/* 2.1 공급가액 입력 : 모든 금액이 초기화되며, 재계산 처리 됨. - BizboxA */
function fnInputStdAmt_BizboxA( stdAmt, calcType ) {
    alert('준비중입니다.. [fnInputStdAmt_BizboxA]');
    return;
}
/* 2.2 공급가액 입력 : 모든 금액이 초기화되며, 재계산 처리 됨. - iCUBE */
function fnInputStdAmt_iCUBE( stdAmt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var amt = 0; /* 공급대가 */
    var taxAmt = 0; /* 부가세 */
    var subStdAmt = 0; /* 과세표준액 */
    var subTaxAmt = 0; /* 세액 */
    /* 세무구분에 따른 분리 */
    if ('|21|25|26|27|28|29|41|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세 있는 프로세스] : 공급대가, 공급가액, 부가세 전송 건 - 부가세 행 생성 */
        amt = Number(stdAmt) + Number((fnNumCalc((stdAmt / 10), calcType))); /* 공급대가:공급가액+(공급가액/10 ) */
        taxAmt = (fnNumCalc((stdAmt / 10), calcType)); /* 부가세 : 공급가액/10 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세액 */
    } else if ('|24|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세는 없고, 세액만 있는 프로세스] : 부가세는 0원이지만, 세액을 전송하는 건 - 부가세 행 생성 */
        amt = Number(stdAmt) + (fnNumCalc((stdAmt / 10), calcType)); /* 공급대가:공급가액 */
        taxAmt = 0; /* 부가세 : 0 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = (fnNumCalc((stdAmt / 10), calcType)); /* 세액:공급가액/10 */
        stdAmt = amt; /* 불공인데,공급가액을입력한경우는영수증을보고입력한케이스라판단하여,공급가앧+부가세액을강제조정하여처리한다. */
    } else if ('|22|23|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세도 없고, 세액도 없는 프로세스] : 부가세는 0원, 세액도 0원 - 부가세 행 생성 */
        amt = stdAmt; /* 공급대가 : 공급가액 */
        taxAmt = 0; /* 부가세 : 0 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = 0; /* 세액 : 0 */
    } else {
        /* 지원불가항목:|27|28|29|30|32|33|34|35|36|40|41|42|44|45|46|47|48|49|51|52|53|54|55|56|57|58|59| */
        /* 지원불가항목 : 세무구분이 입력되지 않은 경우 - 부가세 행 미생성 */
        amt = stdAmt;
        taxAmt = 0;
        subStdAmt = stdAmt;
        subTaxAmt = 0;
    }
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 2.3 공급가액 입력 : 모든 금액이 초기화되며, 재계산 처리 됨. - ERPiU */
function fnInputStdAmt_ERPiU( stdAmt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var amt = 0; /* 공급대가 */
    var taxAmt = 0; /* 부가세 */
    var subStdAmt = 0; /* 과세표준액 */
    var subTaxAmt = 0; /* 세액 */
    /* 세무구분에 따른 분리 */
    if ('|21|24|31|38|43|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세 있는 프로세스] : 공급대가, 공급가액, 부가세 전송 건 - 부가세 행 생성 */
        amt = Number(stdAmt) + Number((fnNumCalc((stdAmt / 10), calcType))); /* 공급대가:공급가액+(공급가액/10 ) */
        taxAmt = (fnNumCalc((stdAmt / 10), calcType)); /* 부가세 : 공급가액/10 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세액 */
    } else if ('|22|50|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세는 없고, 세액만 있는 프로세스] : 부가세는 0원이지만, 세액을 전송하는 건 - 부가세 행 생성 */
        amt = Number(stdAmt) + (fnNumCalc((stdAmt / 10), calcType)); /* 공급대가:공급가액 */
        taxAmt = 0; /* 부가세 : 0 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = (fnNumCalc((stdAmt / 10), calcType)); /* 세액:공급가액/10 */
        stdAmt = amt; /* 불공인데,공급가액을입력한경우는영수증을보고입력한케이스라판단하여,공급가앧+부가세액을강제조정하여처리한다. */
    } else if ('|23|25|26|37|39|60|99|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세도 없고, 세액도 없는 프로세스] : 부가세는 0원, 세액도 0원 - 부가세 행 생성 */
        amt = stdAmt; /* 공급대가 : 공급가액 */
        taxAmt = 0; /* 부가세 : 0 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = 0; /* 세액 : 0 */
    } else {
        /* 지원불가항목:|27|28|29|30|32|33|34|35|36|40|41|42|44|45|46|47|48|49|51|52|53|54|55|56|57|58|59| */
        /* 지원불가항목 : 세무구분이 입력되지 않은 경우 - 부가세 행 미생성 */
        amt = stdAmt;
        taxAmt = 0;
        subStdAmt = stdAmt;
        subTaxAmt = 0;
    }
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 3 부가세 입력 : 모든금액은 그대로 가져가며, 추가 계산만 진행 됨. */
function fnInputTaxAmt( taxAmt, calcType, summaryParam, authParam ) {
    summary = summaryParam;
    auth = authParam;

    taxAmt = (taxAmt || '0').replace(/,/g, '');
    var result = {};
    if (window[fnGetName().name + '_' + ifSystem]) {
        result = window[fnGetName().name + '_' + ifSystem](taxAmt, calcType);
        fnSetAmtNum(result);
    }
    return;
}
/* 3.1 부가세 입력 : 모든금액은 그대로 가져가며, 추가 계산만 진행 됨. - BizboxA */
function fnInputTaxAmt_BizboxA( taxAmt, calcType ) {
    alert('준비중입니다.. [fnInputTaxAmt_BizboxA]');
    return;
}
/* 3.2 부가세 입력 : 모든금액은 그대로 가져가며, 추가 계산만 진행 됨. - iCUBE */
function fnInputTaxAmt_iCUBE( taxAmt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var amt = 0; /* 공급대가 */
    var stdAmt = 0; /* 공급가액 */
    var subStdAmt = 0; /* 과세표준액 */
    var subTaxAmt = 0; /* 세액 */
    /* 공급대가 입력 값 확인 */
    if ($('#txtSlipAmt')[0] != undefined) {
        amt = $('#txtSlipAmt').val();
    } else if ($('#txtListAmt')[0] != undefined) {
        amt = $('#txtListAmt').val();
    }
    amt = ((amt || '0').replace(/,/g, '') || 0);
    
    /* 공급가액 입력 값 확인 */
    if ($('#txtSlipStdAmt')[0] != undefined) {
        stdAmt = $('#txtSlipStdAmt').val();
    } else if ($('#txtListStdAmt')[0] != undefined) {
        stdAmt = $('#txtListStdAmt').val();
    }
    
    stdAmt = ((stdAmt || '0').replace(/,/g, '') || 0);
    /* 과세표준액 입력 값 확인 */
    if ($('#txtSlipSubStdAmt')[0] != undefined) {
        subStdAmt = $('#txtSlipSubStdAmt').val();
    } else if ($('#txtListSubStdAmt')[0] != undefined) {
        subStdAmt = $('#txtListSubStdAmt').val();
    }
    
    subStdAmt = ((subStdAmt || '0').replace(/,/g, '') || 0);
    /* 세액 입력 값 확인 */
    if ($('#txtSlipSubTaxAmt')[0] != undefined) {
        subTaxAmt = $('#txtSlipSubTaxAmt').val();
    } else if ($('#txtListSubTaxAmt')[0] != undefined) {
        subTaxAmt = $('#txtListSubTaxAmt').val();
    }
    subTaxAmt = ((subTaxAmt || '0').replace(/,/g, '') || 0);

    if ('|21|25|26|27|28|29|41|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세 있는 프로세스] : 공급대가, 공급가액, 부가세 전송 건 - 부가세 행 생성 */
//        amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
    	amt = amt; /* 공급대가 : 수정하지 않음 */
        stdAmt = Number(amt) - Number(taxAmt); /* 공급가액 : 공급대가 - 부가세 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세 */
    } else if ('|24|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세는 없고, 세액만 있는 프로세스] : 부가세는 0원이지만, 세액을 전송하는 건 - 부가세 행 생성 */
        amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
        stdAmt = stdAmt; /* 공급가액 : 수정하지 않음 */

        if (taxAmt != '0') {
            subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
            subTaxAmt = taxAmt; /* 세액 : 부가세 */
        } else {
            subStdAmt = Number(amt) - Number(fnNumCalc(amt / 11, calcType));
            subTaxAmt = (fnNumCalc(amt / 11, calcType));
        }
    } else if ('|22|23|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세도 없고, 세액도 없는 프로세스] : 부가세는 0원, 세액도 0원 - 부가세 행 생성 */
        amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
        stdAmt = stdAmt; /* 공급가액 : 수정하지 않음 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세 */
    } else {
        /* 지원불가항목 : 세무구분이 입력되지 않은 경우 - 부가세 행 미생성 */
        amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
        stdAmt = stdAmt; /* 공급가액 : 수정하지 않음 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세 */
    }
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 3.3 부가세 입력 : 모든금액은 그대로 가져가며, 추가 계산만 진행 됨. - ERPiU */
function fnInputTaxAmt_ERPiU( taxAmt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var amt = 0; /* 공급대가 */
    var stdAmt = 0; /* 공급가액 */
    var subStdAmt = 0; /* 과세표준액 */
    var subTaxAmt = 0; /* 세액 */
    /* 공급대가 입력 값 확인 */
    if ($('#txtSlipAmt')[0] != undefined) {
        amt = $('#txtSlipAmt').val();
    } else if ($('#txtListAmt')[0] != undefined) {
        amt = $('#txtListAmt').val();
    }
    amt = ((amt || '0').replace(/,/g, '') || 0);
    /* 공급가액 입력 값 확인 */
    if ($('#txtSlipStdAmt')[0] != undefined) {
        stdAmt = $('#txtSlipStdAmt').val();
    } else if ($('#txtListStdAmt')[0] != undefined) {
        stdAmt = $('#txtListStdAmt').val();
    }
    stdAmt = ((stdAmt || '0').replace(/,/g, '') || 0);
    /* 과세표준액 입력 값 확인 */
    if ($('#txtSlipSubStdAmt')[0] != undefined) {
        subStdAmt = $('#txtSlipSubStdAmt').val();
    } else if ($('#txtListSubStdAmt')[0] != undefined) {
        subStdAmt = $('#txtListSubStdAmt').val();
    }
    subStdAmt = ((subStdAmt || '0').replace(/,/g, '') || 0);
    /* 세액 입력 값 확인 */
    if ($('#txtSlipSubTaxAmt')[0] != undefined) {
        subTaxAmt = $('#txtSlipSubTaxAmt').val();
    } else if ($('#txtListSubTaxAmt')[0] != undefined) {
        subTaxAmt = $('#txtListSubTaxAmt').val();
    }
    subTaxAmt = ((subTaxAmt || '0').replace(/,/g, '') || 0);
    /* [부가세 있는 프로세스] : 공급대가, 공급가액, 부가세 전송 건 - 부가세 행 생성 */
    /* [부가세는 없고, 세액만 있는 프로세스] : 부가세는 0원이지만, 세액을 전송하는 건 - 부가세 행 생성 */
    /* [부가세도 없고, 세액도 없는 프로세스] : 부가세는 0원, 세액도 0원 - 부가세 행 생성 */
    /* 지원불가항목:|27|28|29|30|32|33|34|35|36|40|41|42|44|45|46|47|48|49|51|52|53|54|55|56|57|58|59| */
    /* 지원불가항목 : 세무구분이 입력되지 않은 경우 - 부가세 행 미생성 */
    // amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
    // stdAmt = stdAmt; /* 공급가액 : 수정하지 않음 */
    // subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
    // subTaxAmt = taxAmt; /* 세액 : 부가세 */
    /* 세무구분에 따른 분리 */
    if ('|21|24|31|38|43|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세 있는 프로세스] : 공급대가, 공급가액, 부가세 전송 건 - 부가세 행 생성 */
//      amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
    	amt = amt; /* 공급대가 : 수정하지 않음 */
        stdAmt = Number(amt) - Number(taxAmt); /* 공급가액 : 공급대가 - 부가세 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세 */
    } else if ('|22|50|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세는 없고, 세액만 있는 프로세스] : 부가세는 0원이지만, 세액을 전송하는 건 - 부가세 행 생성 */
        amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
        stdAmt = stdAmt; /* 공급가액 : 수정하지 않음 */

        if (taxAmt != '0') {
            subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
            subTaxAmt = taxAmt; /* 세액 : 부가세 */
        } else {
            subStdAmt = Number(amt) - Number(fnNumCalc(amt / 11, calcType));
            subTaxAmt = (fnNumCalc(amt / 11, calcType));
        }
    } else if ('|23|25|26|37|39|60|99|'.indexOf('|' + auth.vatTypeCode + '|') != -1) {
        /* [부가세도 없고, 세액도 없는 프로세스] : 부가세는 0원, 세액도 0원 - 부가세 행 생성 */
        amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
        stdAmt = stdAmt; /* 공급가액 : 수정하지 않음 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세 */
    } else {
        /*
         * 지원불가항목:|27|28|29|30|32|33|34|35|36|40|41|42|44|45|46|47|48|49|51|52|53|54|55|56|57|58|59|
         */
        /* 지원불가항목 : 세무구분이 입력되지 않은 경우 - 부가세 행 미생성 */
        amt = Number(taxAmt) + Number(stdAmt); /* 공급대가 : 부가세 + 공급가액 */
        stdAmt = stdAmt; /* 공급가액 : 수정하지 않음 */
        subStdAmt = stdAmt; /* 과세표준액 : 공급가액 */
        subTaxAmt = taxAmt; /* 세액 : 부가세 */
    }
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 4. 과세표준액 입력 */
function fnInputSubStdAmt( subStdAmt, calcType, summaryParam, authParam ) {
    summary = summaryParam;
    auth = authParam;

    subStdAmt = (subStdAmt || '0').replace(/,/g, '');
    var result = {};
    
    if(ifSystem == 'iCUBE') {
    	result = fnInputSubStdAmt_iCUBE(subStdAmt, calcType);
    	fnSetAmtNum(result);
    } else if(ifSystem == 'ERPiU'){
    	result = fnInputSubStdAmt_ERPiU(subStdAmt, calcType);
    	fnSetAmtNum(result);
    }
    
//    if (window[fnGetName().name + '_' + ifSystem]) {
//        result = window[fnGetName().name + '_' + ifSystem](subStdAmt, calcType);
//        fnSetAmtNum(result);
//    }
    return;
}
/* 4.1 과세표준액 입력 : 공급대가 기준 범위 안에서만 금액 수정 가능 - BizboxA */
function fnInputSubStdAmt_BizboxA( subStdAmt, calcType ) {
    return null;
}
/* 4.2 과세표준액 입력 : 공급대가 기준 범위 안에서만 금액 수정 가능 - iCUBE */
function fnInputSubStdAmt_iCUBE( subStdAmt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var amt = 0; /* 공급대가 */
    var stdAmt = 0; /* 공급가액 */
    var taxAmt = 0; /* 부가세 */
    var subTaxAmt = 0; /* 세액 */
    /* 공급대가 입력 값 확인 */
    if ($('#txtSlipAmt')[0] != undefined) {
        amt = $('#txtSlipAmt').val();
    } else if ($('#txtListAmt')[0] != undefined) {
        amt = $('#txtListAmt').val();
    }
    amt = ((amt || '0').replace(/,/g, '') || 0);
    /* 공급가액 입력 값 확인 */
    if ($('#txtSlipStdAmt')[0] != undefined) {
        stdAmt = $('#txtSlipStdAmt').val();
    } else if ($('#txtListStdAmt')[0] != undefined) {
        stdAmt = $('#txtListStdAmt').val();
    }
    stdAmt = ((stdAmt || '0').replace(/,/g, '') || 0);
    /* 부가세 값 확인 */
    if ($('#txtSlipTaxAmt')[0] != undefined) {
        taxAmt = $('#txtSlipTaxAmt').val();
    } else if ($('#txtListTaxAmt')[0] != undefined) {
        taxAmt = $('#txtListTaxAmt').val();
    }
    stdAmt = ((stdAmt || '0').replace(/,/g, '') || 0);
    /* 세액 입력 값 확인 */
    if ($('#txtSlipSubTaxAmt')[0] != undefined) {
        subTaxAmt = $('#txtSlipSubTaxAmt').val();
    } else if ($('#txtListSubTaxAmt')[0] != undefined) {
        subTaxAmt = $('#txtListSubTaxAmt').val();
    }
    subTaxAmt = ((subTaxAmt || '0').replace(/,/g, '') || 0);
    /* 금액계산 */
    if (Number(amt) < Number(subStdAmt)) {
        subStdAmt = Number(amt) - Number(subTaxAmt);
    } else {
        subTaxAmt = Number(amt) - Number(subStdAmt);
    }
    /* 반환 */
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 4.3 과세표준액 입력 : 공급대가 기준 범위 안에서만 금액 수정 가능 - ERPiU */
function fnInputSubStdAmt_ERPiU( subStdAmt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var amt = 0; /* 공급대가 */
    var stdAmt = 0; /* 공급가액 */
    var taxAmt = 0; /* 부가세 */
    var subTaxAmt = 0; /* 세액 */
    /* 공급대가 입력 값 확인 */
    if ($('#txtSlipAmt')[0] != undefined) {
        amt = $('#txtSlipAmt').val();
    } else if ($('#txtListAmt')[0] != undefined) {
        amt = $('#txtListAmt').val();
    }
    amt = ((amt || '0').replace(/,/g, '') || 0);
    /* 공급가액 입력 값 확인 */
    if ($('#txtSlipStdAmt')[0] != undefined) {
        stdAmt = $('#txtSlipStdAmt').val();
    } else if ($('#txtListStdAmt')[0] != undefined) {
        stdAmt = $('#txtListStdAmt').val();
    }
    stdAmt = ((stdAmt || '0').replace(/,/g, '') || 0);
    /* 부가세 값 확인 */
    if ($('#txtSlipTaxAmt')[0] != undefined) {
        taxAmt = $('#txtSlipTaxAmt').val();
    } else if ($('#txtListTaxAmt')[0] != undefined) {
        taxAmt = $('#txtListTaxAmt').val();
    }
    stdAmt = ((stdAmt || '0').replace(/,/g, '') || 0);
    /* 세액 입력 값 확인 */
    if ($('#txtSlipSubTaxAmt')[0] != undefined) {
        subTaxAmt = $('#txtSlipSubTaxAmt').val();
    } else if ($('#txtListSubTaxAmt')[0] != undefined) {
        subTaxAmt = $('#txtListSubTaxAmt').val();
    }
    subTaxAmt = ((subTaxAmt || '0').replace(/,/g, '') || 0);
    /* 금액계산 */
    if (Number(amt) < Number(subStdAmt)) {
        subStdAmt = Number(amt) - Number(subTaxAmt);
    } else {
        subTaxAmt = Number(amt) - Number(subStdAmt);
    }
    /* 반환 */
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 5. 세액 입력 */
function fnInputSubTaxAmt( subTaxAmt, calcType, summaryParam, authParam ) {
    summary = summaryParam;
    auth = authParam;
    
    subTaxAmt = (subTaxAmt || '0').replace(/,/g, '');
    var result = {};
    
    if(ifSystem == 'iCUBE') {
    	result = fnInputSubTaxAmt_iCUBE(subTaxAmt, calcType);
    	fnSetAmtNum(result);
    } else if (ifSystem == 'ERPiU'){
    	result = fnInputSubTaxAmt_ERPiU(subTaxAmt, calcType);
    	fnSetAmtNum(result);
    }
    
//    if (window[fnGetName().name + '_' + ifSystem]) {
//        result = window[fnGetName().name + '_' + ifSystem](subTaxAmt, calcType);
//        fnSetAmtNum(result);
//    }
    return;
}
/* 5.1 세액 입력 : 공급대가 기준 범위 안에서만 금액 수정 가능 - BizboxA */
function fnInputSubTaxAmt_BizboxA( subTaxAmt, calcType ) {
    return null;
}
/* 5.2 세액 입력 : 공급대가 기준 범위 안에서만 금액 수정 가능 - iCUBE */
function fnInputSubTaxAmt_iCUBE( subTaxAmt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var amt = 0; /* 공급대가 */
    var stdAmt = 0; /* 공급가액 */
    var taxAmt = 0; /* 부가세 */
    var subStdAmt = 0; /* 과세표준액 */
    /* 공급대가 입력 값 확인 */
    if ($('#txtSlipAmt')[0] != undefined) {
        amt = $('#txtSlipAmt').val();
    } else if ($('#txtListAmt')[0] != undefined) {
        amt = $('#txtListAmt').val();
    }
    amt = ((amt || '0').replace(/,/g, '') || 0);
    /* 공급가액 입력 값 확인 */
    if ($('#txtSlipStdAmt')[0] != undefined) {
        stdAmt = $('#txtSlipStdAmt').val();
    } else if ($('#txtListStdAmt')[0] != undefined) {
        stdAmt = $('#txtListStdAmt').val();
    }
    /* 부가세 값 확인 */
    if ($('#txtSlipTaxAmt')[0] != undefined) {
        taxAmt = $('#txtSlipTaxAmt').val();
    } else if ($('#txtListTaxAmt')[0] != undefined) {
        taxAmt = $('#txtListTaxAmt').val();
    }
    stdAmt = ((stdAmt || '0').replace(/,/g, '') || 0);
    /* 과세표준액 입력 값 확인 */
    if ($('#txtSlipSubStdAmt')[0] != undefined) {
        subStdAmt = $('#txtSlipSubStdAmt').val();
    } else if ($('#txtListSubStdAmt')[0] != undefined) {
        subStdAmt = $('#txtListSubStdAmt').val();
    }
    subStdAmt = ((subStdAmt || '0').replace(/,/g, '') || 0);
    /* 금액계산 */
    if (Number(amt) < Number(subTaxAmt)) {
        subTaxAmt = Number(amt) - Number(subStdAmt);
    } else {
        subStdAmt = Number(amt) - Number(subTaxAmt);
    }
    /* 반환 */
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 5.3 세액 입력 : 공급대가 기준 범위 안에서만 금액 수정 가능 - ERPiU */
function fnInputSubTaxAmt_ERPiU( subTaxAmt, calcType ) {
    /* 변수정의 */
    calcType = (calcType || '2');
    var amt = 0; /* 공급대가 */
    var stdAmt = 0; /* 공급가액 */
    var taxAmt = 0; /* 부가세 */
    var subStdAmt = 0; /* 과세표준액 */
    /* 공급대가 입력 값 확인 */
    if ($('#txtSlipAmt')[0] != undefined) {
        amt = $('#txtSlipAmt').val();
    } else if ($('#txtListAmt')[0] != undefined) {
        amt = $('#txtListAmt').val();
    }
    amt = ((amt || '0').replace(/,/g, '') || 0);
    /* 공급가액 입력 값 확인 */
    if ($('#txtSlipStdAmt')[0] != undefined) {
        stdAmt = $('#txtSlipStdAmt').val();
    } else if ($('#txtListStdAmt')[0] != undefined) {
        stdAmt = $('#txtListStdAmt').val();
    }
    /* 부가세 값 확인 */
    if ($('#txtSlipTaxAmt')[0] != undefined) {
        taxAmt = $('#txtSlipTaxAmt').val();
    } else if ($('#txtListTaxAmt')[0] != undefined) {
        taxAmt = $('#txtListTaxAmt').val();
    }
    stdAmt = ((stdAmt || '0').replace(/,/g, '') || 0);
    /* 과세표준액 입력 값 확인 */
    if ($('#txtSlipSubStdAmt')[0] != undefined) {
        subStdAmt = $('#txtSlipSubStdAmt').val();
    } else if ($('#txtListSubStdAmt')[0] != undefined) {
        subStdAmt = $('#txtListSubStdAmt').val();
    }
    subStdAmt = ((subStdAmt || '0').replace(/,/g, '') || 0);
    /* 금액계산 */
    if (Number(amt) < Number(subTaxAmt)) {
        subTaxAmt = Number(amt) - Number(subStdAmt);
    } else {
        subStdAmt = Number(amt) - Number(subTaxAmt);
    }
    /* 반환 */
    var result = {
        amt : amt,
        stdAmt : stdAmt,
        taxAmt : taxAmt,
        subStdAmt : subStdAmt,
        subTaxAmt : subTaxAmt
    }
    return result;
}
/* 자리올림 처리 함수 */
function fnNumCalc( num, calcType ) {
    switch (calcType) {
        /* Math.round - 반올림 */
        case '1':
            num = Math.round(num);
            break;
        case '2': /* Math.floor - 버림 */
            num = Math.floor(num);
            break;
        case '3': /* Math.ceil - 올림 */
            num = Math.ceil(num);
            break;
        default: /* Math.floor - 버림 */
            num = Math.floor(num);
            break;
    }
    return num;
}

/* 금액 표현 처리 */
function fnSetAmtNum( param ) {
    if (typeof param != 'undefined' && param != null) {
        /* 공급대가 처리 */
        if ($('#txtSlipAmt')[0] != undefined) {
            $('#txtSlipAmt').val(param.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        } else if ($('#txtListAmt')[0] != undefined) {
            $('#txtListAmt').val(param.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        }

        /* 공급가액 처리 */
        if ($('#txtSlipStdAmt')[0] != undefined) {
            $('#txtSlipStdAmt').val(param.stdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        } else if ($('#txtListStdAmt')[0] != undefined) {
            $('#txtListStdAmt').val(param.stdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        }

        /* 부가세 처리 */
        if ($('#txtSlipTaxAmt')[0] != undefined) {
            $('#txtSlipTaxAmt').val(param.taxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        } else if ($('#txtListTaxAmt')[0] != undefined) {
            $('#txtListTaxAmt').val(param.taxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        }

        /* 과세표준액 처리 */
        if ($('#txtSlipSubStdAmt')[0] != undefined) {
            $('#txtSlipSubStdAmt').val(param.subStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            expendListBudget.set('dracct_amt', param.subStdAmt);
            expendListBudget.set('amt', param.subStdAmt);
        } else if ($('#txtListSubStdAmt')[0] != undefined) {
            $('#txtListSubStdAmt').val(param.subStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            expendListBudget.set('dracct_amt', param.subStdAmt);
            expendListBudget.set('amt', param.subStdAmt);
        }

        /* 과세표준액 처리 */
        if ($('#txtSlipSubTaxAmt')[0] != undefined) {
            $('#txtSlipSubTaxAmt').val(param.subTaxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        } else if ($('#txtListSubTaxAmt')[0] != undefined) {
            $('#txtListSubTaxAmt').val(param.subTaxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        }
    } else {
        alert(NeosUtil.getMessage("TX000009394", "표준적요 또는 증빙유형이 선택되지 않았습니다"));
    }
    return;
}