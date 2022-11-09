/*----------------------------------------------------------------------------*/
function fnCopyToBOservalbe( source, target ) {
    if (source != null) {
        var obj = source;
        Object.keys(obj).forEach(function( k ) {
            target.set(k, obj[k]);
        });
    }
}
/*----------------------------------------------------------------------------*/

/* 지출결의 - 생성 */

/* 지출결의 - 수정 */

/* 지출결의 - 삭제 */
function fnExpendDelete() {
    var param = {}
    $.extend(param, expend.toJSON());

    /* 서버호출 */
    $.ajax({
        type : 'post',
        url : baseUrl + "ex/expend/master/ExExpendInfoDelete.do",
        datatype : 'json',
        async : false,
        data : param,
        success : function( data ) {
        },
        error : function( data ) {
            console.log("! [EX][EXPENDDELETE] ERROR - " + JSON.stringify(data));
        }
    });
    return;
}
/* 지출결의 - 조회 */
function fnExpendSelect() {
    var param = {}
    $.extend(param, expend.toJSON());

    /* 서버호출 */
    $.ajax({
        type : 'post',
        url : baseUrl + "ex/expend/master/ExExpendInfoSelect.do",
        datatype : 'json',
        async : false,
        data : param,
        success : function( data ) {
            fnCopyToBOservalbe(data.aaData, expend);
        },
        error : function( data ) {
            console.log("! [EX][EXPENDSELECT] ERROR - " + JSON.stringify(data));
        }
    });
    return;
}

/*----------------------------------------------------------------------------*/
/* 지출결의 - 항목 생성 */
function fnExpendListInsert() {
    var param = {}
    $.extend(param, expendList.toJSON());

    param.comp_seq = empInfo.compSeq;
    param.auth_date = (param.auth_date).toString().replace(/-/g, '');

    /* 서버호출 */
    $.ajax({
        type : 'post',
        url : baseUrl + "ex/expend/list/ExListInfoInsert.do",
        datatype : 'json',
        async : false,
        data : param,
        success : function( data ) {
            /* fnCopyToBOservalbe(data.aaData, expendList); */

            /* EXPEND 변경시 UPDATE 실행 */
            /* expendList.bind('change', function( e ) { */
            /* fnExpendListUpdate(); */
            /* }); */
        },
        error : function( data ) {
            console.log("! [EX][EXPENDLISTINSERT] ERROR - " + JSON.stringify(data));
        }
    });
    return;
}

/* 지출결의 - 항목 수정 */
function fnExpendListUpdate() {
    var param = {}
    $.extend(param, expendList.toJSON());

    param.comp_seq = empInfo.compSeq;
    param.auth_date = (param.auth_date).toString().replace(/-/g, '');
    param.json_str = '';
    param.json_str = JSON.stringify(param);

    /* 서버호출 */
    $.ajax({
        type : 'post',
        url : baseUrl + "ex/expend/list/ExListInfoUpdate.do",
        datatype : 'json',
        async : false,
        data : param,
        success : function( data ) {
        },
        error : function( data ) {
            console.log("! [EX][EXPENDLISTUPDATE] ERROR - " + JSON.stringify(data));
        }
    });
    return;
}

/* 지출결의 - 항목 삭제 */
// function fnExpendListDelete( list_seq ) {
// var param = {};
// $.extend(param, ExExpendList);
//
// param.list_seq = list_seq;
//
// /* 서버호출 */
// $.ajax({
// type : 'post',
// url : baseUrl + "ex/expend/list/ExListInfoDelete.do",
// datatype : 'json',
// async : false,
// data : param,
// success : function( data ) {
// },
// error : function( data ) {
// console.log("! [EX][EXPENDLISTDELETE] ERROR - " + JSON.stringify(data));
// }
// });
// return;
// }
/* 지출결의 - 항목 복사 */
/*----------------------------------------------------------------------------*/
/* 지출결의 - 분개 생성 */
function fnExpendSlipInsert() {
    var param = {}
    $.extend(param, expendSlip.toJSON());

    param.comp_seq = empInfo.compSeq;
    param.auth_date = (param.auth_date).toString().replace(/-/g, '');

    /* 서버호출 */
    $.ajax({
        type : 'post',
        url : baseUrl + "ex/expend/slip/ExSlipInfoInsert.do",
        datatype : 'json',
        async : false,
        data : param,
        success : function( data ) {
            /* fnCopyToBOservalbe(data.aaData, expendSlip); */

            /* EXPEND 변경시 UPDATE 실행 */
            /* expendSlip.bind('change', function( e ) { */
            /* fnExpendSlipUpdate(); */
            /* }); */
        },
        error : function( data ) {
            console.log("! [EX][EXPENDSLIPINSERT] ERROR - " + JSON.stringify(data));
        }
    });
    return;
}
/* 지출결의 - 분개 수정 */
function fnExpendSlipUpdate() {
    var param = {}
    $.extend(param, expendSlip.toJSON());

    param.comp_seq = empInfo.compSeq;
    param.auth_date = (param.auth_date).toString().replace(/-/g, '');
    param.json_str = '';
    param.json_str = JSON.stringify(param);

    /* 서버호출 */
    $.ajax({
        type : 'post',
        url : baseUrl + "ex/expend/slip/ExSlipInfoUpdate.do",
        datatype : 'json',
        async : false,
        data : param,
        success : function( data ) {
        },
        error : function( data ) {
            console.log("! [EX][EXPENDSLIPUPDATE] ERROR - " + JSON.stringify(data));
        }
    });
    return;
}
/* 지출결의 - 분개 복사 */
/*----------------------------------------------------------------------------*/
/* 팝업 */
/* 팝업 - 항목추가 */
/* 팝업 - 분개추가 */
/* 팝업 - 관리항목 */
/* 팝업 - 카드사용내역 */
/* 팝업 - 가져오기 */
/*----------------------------------------------------------------------------*/
function fnLayerPopClose() {
    if ($(".pop_wrap_dir").length > 1) {
        layerPopClose('layerCommonCode');
    } else {
        layerPopClose('');
    }
    return;
}

// /* 1. 변수정의 */
// var baseUrl = '<c:url value="/" />';
// var width = '380'; /* 공통코드 레이어 너비 */
// var height = '643'; /* 공통코드 레이어 높이 */
// var expendInfo = {
// gridList : JSON.parse('${ViewBag.jsonParam.gridList}'),
// gridSlip : JSON.parse('${ViewBag.jsonParam.gridSlip}'),
// gridMng : JSON.parse('${ViewBag.jsonParam.gridMng}'),
// empInfo : JSON.parse('${ViewBag.jsonParam.empInfo}'),
// option : JSON.parse('${ViewBag.jsonParam.optionListInfo}'),
// form : JSON.parse('${ViewBag.jsonParam.formInfo}'),
// write : JSON.parse('${ViewBag.jsonParam.empInfo}'),
// ifSystem : '${ViewBag.ifSystem}',
// ifBudget : '${ViewBag.ifBudget}',
// expend : {
// creEmpInfo : {},
// useEmpInfo : {},
// budgetInfo : {},
// bizplanInfo : {},
// bgAcctInfo : {},
// projectInfo : {},
// partnerInfo : {},
// cardInfo : {},
// header : {},
// info : {
// user : {}
// },
// expendDate : '${ViewBag.expendDate}',
// expendReqDate : '${ViewBag.expendReqDate}',
// expendLayout : ''
// },
// list : {
// gridHead : [],
// columnDefs : [],
// aoColumns : [],
// info : {
// /* 1 : {
// "amt" : "56,786,786",
// "authDate" : "20160628",
// "expendSeq" : "63",
// "list" : {
// "authInfo" : {
// "authCode" : "1",
// "authDateReqYN" : "N",
// "authGbn" : "A",
// "authName" : "증빙없음",
// "cardReqYN" : "N",
// "cashType" : "Y",
// "compSeq" : "6",
// "crAcctCode" : "",
// "crAcctName" : "",
// "erpAuthCode" : "",
// "erpAuthName" : "",
// "noteReqYN" : "Y",
// "partnerReqYN" : "Y",
// "projectReqYN" : "N",
// "seq" : 71,
// "vatAcctCode" : "",
// "vatAcctName" : "",
// "vatTypeCode" : "",
// "vatTypeName" : ""
// },
// "budgetInfo" : {
// "seq" : 0
// },
// "cardInfo" : {
// "seq" : 0
// },
// "notaxInfo" : {
// "seq" : 0
// },
// "partnerInfo" : {
// "bankCode" : "",
// "ceoName" : "",
// "clsJobGbn" : "",
// "createDate" : "",
// "createSeq" : "",
// "depositConvert" : "//",
// "depositName" : "",
// "depositNo" : "",
// "jobGbn" : "",
// "modifyDate" : "",
// "modifySeq" : "",
// "partnerCode" : "000000003",
// "partnerEmpCode" : "",
// "partnerFg" : "001",
// "partnerHpEmpNo" : "",
// "partnerName" : "HTC*HOTELCLUB.COMHOTELCLUB.",
// "partnerNo" : "8888888888",
// "seq" : 35
// },
// "projectInfo" : {
// "seq" : 0
// },
// "summaryInfo" : {
// "compSeq" : "6",
// "crAcctCode" : "25300",
// "crAcctName" : "미지급금",
// "drAcctCode" : "81100",
// "drAcctName" : "복리후생비",
// "seq" : 200,
// "summaryCode" : "80000",
// "summaryName" : "간식비",
// "summaryType" : "A",
// "vatAcctCode" : null,
// "vatAcctName" : null
// },
// "useEmpInfo" : {
// "erpBizName" : "UC개발본부",
// "erpBizSeq" : "1010",
// "erpCcName" : "Suite, UC파트",
// "erpCcSeq" : "3006",
// "erpCompName" : "UC개발",
// "erpCompSeq" : "1000",
// "erpDeptName" : "Suite, UC파트",
// "erpDeptSeq" : "3006",
// "erpEmpName" : "김상겸",
// "erpEmpSeq" : "10000011",
// "erpPcName" : "UC개발본부",
// "erpPcSeq" : "1000",
// "seq" : 0
// }
// },
// "listSeq" : "1",
// "note" : "간식비 [복리후생비(81100) / 미지급금(25300)]",
// "stdAmt" : "56,786,786",
// "subStdAmt" : "",
// "subTaxAmt" : "",
// "taxAmt" : "0"
// } */
// }
// },
// slip : {
// gridHead : [],
// columnDefs : [],
// aoColumns : [],
// info : {
// user : {}
// }
// },
// mng : {
// gridHead : [],
// columnDefs : [],
// aoColumns : []
// }
// };
// /* 2. 문서로드 */
// $(document).ready(function() {
// fnExpendInit();
// fnExpendInitEvent();
// $('#btnTestBind').click(function() {
// fnSetExpendGridBind_List_ERPiU('');
// });
// });
// /* 2.1 문서로드 - 초기화 */
// function fnExpendInit() {
// fnExpendSetPopHeight();
// fnExpendSetDatepicker();
// fnExpendSetExpendLayout();
// fnSetEmpInfo();
// fnExpendInsert();
// fnSetExpendGrid();
// return;
// }
// /* 2.1.1 문서로드 - 초기화 - 팝업 높이 지정 */
// function fnExpendSetPopHeight() {
// var popHeight = ($('.pop_sign_head').css('height')).replace('px', '');
// popHeight = Number(popHeight) + 1;
// $('.pop_sign_con').css('height', window.innerHeight - popHeight + 'px');
// return;
// }
// /* 2.1.2 문서로드 - 초기화 - datepicker 설정 */
// function fnExpendSetDatepicker() {
// $("#txtExpendDate").kendoDatePicker({
// culture : "ko-KR",
// format : "yyyy-MM-dd",
// change : function() {
// var value = this.value();
// var param = {};
// var year = value.getFullYear();
// var month = "00" + Number(value.getMonth() + 1);
// month = month.substring(month.length - 2);
// var date = "00" + value.getDate();
// date = date.substring(date.length - 2);
// param.expendDate = [ year, month, date ].join('');
// fnExpendUpdate(param);
// }
// });
// $("#txtExpendReqDate").kendoDatePicker({
// culture : "ko-KR",
// format : "yyyy-MM-dd",
// change : function() {
// var value = this.value();
// var param = {};
// var year = value.getFullYear();
// var month = "00" + Number(value.getMonth() + 1);
// month = month.substring(month.length - 2);
// var date = "00" + value.getDate();
// date = date.substring(date.length - 2);
// param.expendDate = [ year, month, date ].join('');
// fnExpendUpdate(param);
// }
// });
// var datePicker = $("#txtExpendDate, #txtExpendReqDate");
// datePicker.kendoMaskedTextBox({
// mask : '0000-00-00'
// });
// datePicker.closest(".k-datepicker").add(datePicker).removeClass('k-textbox');
// $('#txtExpendDate').val(expendInfo.expend.expendDate);
// $('#txtExpendReqDate').val(expendInfo.expend.expendReqDate);
// return;
// }
// /* 2.1.3 문서로드 - 초기화 - 문서 레이아웃 설정 */
// function fnExpendSetExpendLayout() {
// /* 공통처리 */
// $('.ExpendBizboxA, .ExpendiCUBE, .ExpendERPiU').hide();
// /* 연동시스템별 처리 */
// if (window[fnGetName().name + '_' + expendInfo.ifSystem]) {
// window[fnGetName().name + '_' + expendInfo.ifSystem]();
// }
// return;
// }
// /* 2.1.3.1 문서로드 - 초기화 - 문서 레이아웃 설정 - BizboxA 헤더 레이아웃 설정 */
// function fnExpendSetExpendLayout_BizboxA() {
// $.each(expendInfo.option, function( idx, option ) {
// if (option.optionGbn == '002' && option.optionCode == '002002') {
// /* [일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 작성자 편집 기능 */
// if (option.value == 'N') {
// /* 결의일자 ( 회계일자, 예산년월 ) 비활성화 */
// var datepicker = $('#txtExpendDate').data('kendoDatePicker');
// datepicker.readonly();
// }
// } else if (option.optionGbn == '002' && option.optionCode == '002004') {
// /* [일자설정] 기본입력 지급요청일자 작성자 편집 기능 */
// if (option.value == 'N') {
// /* 지급요청일자 비활성화 */
// var datepicker = $('#txtExpendReqDate').data('kendoDatePicker');
// datepicker.readonly();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001001') {
// /* 레이아웃 옵션 기록 */
// expendInfo.expend.expendLayout = option.value
// /* [레이아웃] 지출결의 표시범위 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 항목 표현 */
// $('.ExpendList').show();
// } else {
// /* 항목 미표현 */
// $('.ExpendList').hide();
// }
// if (option.value.indexOf('S') > -1) {
// /* 분개 표현 */
// $('.ExpendSlip').show();
// } else {
// /* 분개 미표현 */
// $('.ExpendSlip').hide();
// }
// if (option.value.indexOf('M') > -1) {
// /* 관리항목 미표현 */
// $('.ExpendMng').hide();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001002') {
// /* [레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 ) */
// if (option.value.indexOf('E') > -1) {
// /* 사용자 정뵤 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendEmp').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001004') {
// /* [레이아웃] 프로젝트정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 프로젝트 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendProject').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001005') {
// /* [레이아웃] 거래처정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 거래처 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendPartner').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001006') {
// /* [레이아웃] 카드정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 카드 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendCard').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001007') {
// /* [레이아웃] 기본입력 적요 설정 */
// if (option.value.indexOf('Y') > -1) {
// /* 기본적요 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendBaseNote').show();
// }
// }
// });
// return;
// }
// /* 2.1.3.2 문서로드 - 초기화 - 문서 레이아웃 설정 - iCUBE 헤더 레이아웃 설정 */
// function fnExpendSetExpendLayout_iCUBE() {
// $.each(expendInfo.option, function( idx, option ) {
// if (option.optionGbn == '002' && option.optionCode == '002002') {
// /* [일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 작성자 편집 기능 */
// if (option.value == 'N') {
// /* 결의일자 ( 회계일자, 예산년월 ) 비활성화 */
// var datepicker = $('#txtExpendDate').data('kendoDatePicker');
// datepicker.readonly();
// }
// } else if (option.optionGbn == '002' && option.optionCode == '002004') {
// /* [일자설정] 기본입력 지급요청일자 작성자 편집 기능 */
// if (option.value == 'N') {
// /* 지급요청일자 비활성화 */
// var datepicker = $('#txtExpendReqDate').data('kendoDatePicker');
// datepicker.readonly();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001001') {
// /* 레이아웃 옵션 기록 */
// expendInfo.expend.expendLayout = option.value
// /* [레이아웃] 지출결의 표시범위 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 항목 표현 */
// $('.ExpendList').show();
// } else {
// /* 항목 미표현 */
// $('.ExpendList').hide();
// }
// if (option.value.indexOf('S') > -1) {
// /* 분개 표현 */
// $('.ExpendSlip').show();
// } else {
// /* 분개 미표현 */
// $('.ExpendSlip').hide();
// }
// if (option.value.indexOf('M') > -1) {
// /* 관리항목 표현 */
// $('.ExpendMng').show();
// } else {
// /* 관리항목 미표현 */
// $('.ExpendMng').hide();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001002') {
// /* [레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 ) */
// if (option.value.indexOf('E') > -1) {
// /* 사용자 정뵤 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendEmp').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001003') {
// /* [레이아웃] 예산정보 입력 설정 ( 예산단위, 사업계획, 예산계정 ) */
// if (option.value.indexOf('E') > -1) {
// /* 예산 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendBudget').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001004') {
// /* [레이아웃] 프로젝트정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 프로젝트 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendProject').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001005') {
// /* [레이아웃] 거래처정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 거래처 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendPartner').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001006') {
// /* [레이아웃] 카드정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 카드 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendCard').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001007') {
// /* [레이아웃] 기본입력 적요 설정 */
// if (option.value.indexOf('Y') > -1) {
// /* 기본적요 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendBaseNote').show();
// }
// }
// });
// return;
// }
// /* 2.1.3.3 문서로드 - 초기화 - 문서 레이아웃 설정 - ERPiU 헤더 레이아웃 설정 */
// function fnExpendSetExpendLayout_ERPiU() {
// $.each(expendInfo.option, function( idx, option ) {
// if (option.optionGbn == '002' && option.optionCode == '002002') {
// /* [일자설정] 기본입력 결의일자 ( 회계일자, 예산년월 ) 작성자 편집 기능 */
// if (option.value == 'N') {
// /* 결의일자 ( 회계일자, 예산년월 ) 비활성화 */
// var datepicker = $('#txtExpendDate').data('kendoDatePicker');
// datepicker.readonly();
// }
// } else if (option.optionGbn == '002' && option.optionCode == '002004') {
// /* [일자설정] 기본입력 지급요청일자 작성자 편집 기능 */
// if (option.value == 'N') {
// /* 지급요청일자 비활성화 */
// var datepicker = $('#txtExpendReqDate').data('kendoDatePicker');
// datepicker.readonly();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001001') {
// /* 레이아웃 옵션 기록 */
// expendInfo.expend.expendLayout = option.value
// /* [레이아웃] 지출결의 표시범위 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 항목 표현 */
// $('.ExpendList').show();
// } else {
// /* 항목 미표현 */
// $('.ExpendList').hide();
// }
// if (option.value.indexOf('S') > -1) {
// /* 분개 표현 */
// $('.ExpendSlip').show();
// } else {
// /* 분개 미표현 */
// $('.ExpendSlip').hide();
// }
// if (option.value.indexOf('M') > -1) {
// /* 관리항목 표현 */
// $('.ExpendMng').show();
// } else {
// /* 관리항목 미표현 */
// $('.ExpendMng').hide();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001002') {
// /* [레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 ) */
// if (option.value.indexOf('E') > -1) {
// /* 사용자 정뵤 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendEmp').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001003') {
// /* [레이아웃] 예산정보 입력 설정 ( 예산단위, 사업계획, 예산계정 ) */
// if (option.value.indexOf('E') > -1) {
// /* 예산 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendBudget').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001004') {
// /* [레이아웃] 프로젝트정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 프로젝트 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendProject').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001005') {
// /* [레이아웃] 거래처정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 거래처 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendPartner').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001006') {
// /* [레이아웃] 카드정보 입력 설정 */
// if (option.value.indexOf('E') > -1) {
// /* 카드 정보 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendCard').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001007') {
// /* [레이아웃] 기본입력 적요 설정 */
// if (option.value.indexOf('Y') > -1) {
// /* 기본적요 입력 표현 */
// $('.Expend' + expendInfo.ifSystem + '.ExpendBaseNote').show();
// }
// }
// });
// return;
// }
// /* 로그인사용자 정보 가져오기 */
// function fnSetEmpInfo() {
// /* 변수정의 */
// var ajaxParam = {};
// ajaxParam.searchCompSeq = expendInfo.empInfo.compSeq;
// ajaxParam.erpCompSeq = expendInfo.empInfo.erpCompSeq;
// ajaxParam.erpEmpSeq = expendInfo.empInfo.erpEmpSeq;
// /* 사용자 정보 조회 */
// expendInfo.expend.useEmpInfo = fnExCodeOrgEmpInfoSelect(ajaxParam);
// if (Object.keys(expendInfo.expend.creEmpInfo).length == 0) {
// $.extend(expendInfo.expend.creEmpInfo, expendInfo.expend.useEmpInfo)
// }
// /* 사용자 정보 바인딩 */
// if (expendInfo.expend.useEmpInfo) {
// $('#txtExpendEmpCode').val(expendInfo.expend.useEmpInfo.erpEmpSeq || '');
// $('#txtExpendEmpName').val(expendInfo.expend.useEmpInfo.erpEmpName || '');
// $('#txtExpendDeptCode').val(expendInfo.expend.useEmpInfo.erpDeptSeq || '');
// $('#txtExpendDeptName').val(expendInfo.expend.useEmpInfo.erpDeptName || '');
// $('#txtExpendPcCode').val(expendInfo.expend.useEmpInfo.erpPcSeq || '');
// $('#txtExpendPcName').val(expendInfo.expend.useEmpInfo.erpPcName || '');
// $('#txtExpendCcCode').val(expendInfo.expend.useEmpInfo.erpCcSeq || '');
// $('#txtExpendCcName').val(expendInfo.expend.useEmpInfo.erpCcName || '');
// }
// }
// /* 2.1.4 문서로드 - 초기화 - 지출결의 문서 생성 */
// function fnExpendInsert() {
// expendInfo.expend.header.expendStatCode = '0';
// expendInfo.expend.header.expendDate = '${ViewBag.expendDate}'.replace(/-/g,
// '');
// expendInfo.expend.header.expendReqDate =
// '${ViewBag.expendReqDate}'.replace(/-/g, '');
// expendInfo.expend.header.erpSendYN = 'N';
// $.ajax({
// type : 'post',
// url : '<c:url value="/ex/expend/master/ExExpendMasterInfoInsert.do" />',
// datatype : 'json',
// async : false,
// data : expendInfo.expend.header,
// success : function( data ) {
// if (data && data.aaData) {
// expendInfo.expend.header = data.aaData;
// }
// },
// error : function( data ) {
// console.log(' -_- ? Error ! >>>> ' + JSON.stringify(data));
// }
// });
// return;
// }
// function getObjects( obj, key, val ) {
// var objects = [];
// for ( var i in obj) {
// if (!obj.hasOwnProperty(i)) continue;
// if (typeof obj[i] == 'object') {
// objects = objects.concat(getObjects(obj[i], key, val));
// } else if (i == key && obj[key] == val) {
// objects.push(obj);
// }
// }
// return objects;
// }
// /* 2.2 문서로드 - 이벤트 바인딩 */
// function fnExpendInitEvent() {
// /* 상단버튼 : 가져오기, 결재상신 */
// $('#btnExpendReper, #btnExpendApproval').click(function( event ) {
// fnExpendInitEventButton(event);
// });
// /* 항목버튼 : 카드사용내역, 항목 추가, 항목 복사, 항목 삭제 */
// $('#btnExpendListAdd, #btnExpendListCopy, #btnExpendListDelete,
// #btnExpendInterfaceCard').click(function( event ) {
// fnExpendInitEventButton(event);
// });
// /* 분개버튼 : 분개 추가, 분개 복사, 분개 삭제 */
// $('#btnExpendSlipAdd, #btnExpendSlipCopy,
// #btnExpendSlipDelete').click(function( event ) {
// fnExpendInitEventButton(event);
// });
// /* 사용자 정보 버튼 : 사용자, 회계단위, 코스트센터 */
// $('#btnExpendEmpSearch, #btnExpendPcSearch,
// #btnExpendCcSearch').click(function( event ) {
// fnExpendInitEventButton(event);
// });
// /* 예산 정보 버튼 : 에산단위, 사업계획, 에산계정 */
// $('#btnExpendBudgetSearch, #btnExpendBizplanSearch,
// #btnExpendBgAcctSearch').click(function( event ) {
// fnExpendInitEventButton(event);
// });
// /* 프로젝트 정보 버튼 : 프로젝트 */
// $('#btnExpendProjectSearch').click(function( event ) {
// fnExpendInitEventButton(event);
// });
// /* 거래처 정보 버튼 : 거래처 */
// $('#btnExpendPartnerSearch').click(function( event ) {
// fnExpendInitEventButton(event);
// });
// /* 카드 정보 버튼 : 카드 */
// $('#btnExpendCardSearch').click(function( event ) {
// fnExpendInitEventButton(event);
// });
// return;
// }
// /* 2.2.1 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 */
// function fnExpendInitEventButton( event ) {
// var eventType = event.target.id.replace('btn', '');
// /* 버튼별 처리 */
// if (window[fnGetName().name + '_' + eventType]) {
// window[fnGetName().name + '_' + eventType]();
// }
// }
// /* 2.2.1.1 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 지출결의 가져오기 */
// function fnExpendInitEventButton_ExpendReper() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.2 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 결재상신 */
// function fnExpendInitEventButton_ExpendApproval() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.3 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 항목 추가 */
// function fnExpendInitEventButton_ExpendListAdd( callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&expendSeq=' + expendInfo.expend.header.expendSeq;
// getParam += '&listSeq=';
// var listParam = {
// url : "<c:url value='/ex/expend/list/ExExpendListPopup.do'/>",
// getParam : getParam,
// title : "항목 추가",
// opener : "2",
// parentId : ""
// };
// fnExListPopup(listParam);
// }
// return;
// }
// /* 2.2.1.4 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 항목 복사 */
// function fnExpendInitEventButton_ExpendListCopy() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.5 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 항목 삭제 */
// function fnExpendInitEventButton_ExpendListDelete() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.6 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 분개 추가 */
// function fnExpendInitEventButton_ExpendSlipAdd( param, callbackParam ) {
// // tkdrua
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// if (($('#hidListSeq').val() || '0') == '0') {
// alert('항목이 선택되지 않았습니다.');
// return;
// }
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&expendSeq=' + expendInfo.expend.header.expendSeq;
// getParam += '&listSeq=' + ($('#hidSlipSeq').val() || '0');
// var listParam = {
// url : "<c:url value='/ex/expend/slip/ExExpendSlipPopup.do'/>",
// getParam : getParam,
// title : "분개 추가",
// opener : "2",
// parentId : ""
// };
// fnExListPopup(listParam);
// }
// return;
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.7 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 분개 복사 */
// function fnExpendInitEventButton_ExpendSlipCopy() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.8 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 분개 삭제 */
// function fnExpendInitEventButton_ExpendSlipDelete() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.9 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 법인카드 가져오기 */
// function fnExpendInitEventButton_ExpendInterfaceCard() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.10 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 사용자 */
// function fnExpendInitEventButton_ExpendEmpSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('emp', '', fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('useEmpInfo', callbackParam, function( value ) {
// $('#txtExpendEmpCode').val(value.erpEmpSeq || '');
// $('#txtExpendEmpName').val(value.erpEmpName || '');
// $('#txtExpendDeptCode').val(value.erpDeptSeq || '');
// $('#txtExpendDeptName').val(value.erpDeptName || '');
// $('#txtExpendPcCode').val(value.erpPcSeq || '');
// $('#txtExpendPcName').val(value.erpPcName || '');
// $('#txtExpendCcCode').val(value.erpCcSeq || '');
// $('#txtExpendCcName').val(value.erpCcName || '');
// });
// }
// return;
// }
// /* 2.2.1.11 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 회계단위 */
// function fnExpendInitEventButton_ExpendPcSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('pc', '', fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('useEmpInfo', callbackParam, function( value ) {
// $('#txtExpendPcCode').val(value.erpPcSeq || '');
// $('#txtExpendPcName').val(value.erpPcName || '');
// });
// }
// return;
// }
// /* 2.2.1.12 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 코스트센터 */
// function fnExpendInitEventButton_ExpendCcSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('cc', '', fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('useEmpInfo', callbackParam, function( value ) {
// $('#txtExpendCcCode').val(value.erpCcSeq || '');
// $('#txtExpendCcName').val(value.erpCcName || '');
// });
// }
// return;
// }
// /* 2.2.1.13 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 예산단위 */
// function fnExpendInitEventButton_ExpendBudgetSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('budget', '', fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('budgetInfo', callbackParam, function( value ) {
// $('#txtExpendBudgetCode').val(value.budgetCode || '');
// $('#txtExpendBudgetName').val(value.budgetName || '');
// });
// }
// return;
// }
// /* 2.2.1.14 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 사업계획 */
// function fnExpendInitEventButton_ExpendBizplanSearch( param, callbackParam )
// {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// /* 예산단위 정보가 있어야만, 사업계획 조회가 가능함 */
// if (Object.keys(expendInfo.expend.budgetInfo).length == 0) {
// alert('예산단위가 선택되지 않았습니다.');
// return;
// }
// if (expendInfo.expend.budgetInfo.budgetCode == '') {
// alert('예산단위가 선택되지 않았습니다.');
// return;
// }
// var addGetParam = '&erpBudgetCode=' +
// expendInfo.expend.budgetInfo.budgetCode;
// fnExCodeCommonPopup('bizplan', addGetParam, fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('budgetInfo', callbackParam, function( value ) {
// $('#txtExpendBizplanCode').val(value.bizplanCode || '');
// $('#txtExpendBizplanName').val(value.bizplanName || '');
// });
// }
// return;
// }
// /* 2.2.1.15 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 예산계정 */
// function fnExpendInitEventButton_ExpendBgAcctSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// /* 예산단위 정보가 있어야만, 사업계획 조회가 가능함 */
// if (Object.keys(expendInfo.expend.budgetInfo).length == 0) {
// alert('예산단위가 선택되지 않았습니다.');
// return;
// }
// if (expendInfo.expend.budgetInfo.budgetCode == '') {
// alert('예산단위가 선택되지 않았습니다.');
// return;
// }
// var addGetParam = '&erpBudgetCode=' +
// expendInfo.expend.budgetInfo.budgetCode;
// fnExCodeCommonPopup('bgacct', addGetParam, fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('budgetInfo', callbackParam, function( value ) {
// $('#txtExpendBgAcctCode').val(value.bgAcctCode || '');
// $('#txtExpendBgAcctName').val(value.bgAcctName || '');
// });
// }
// return;
// }
// /* 2.2.1.16 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 프로젝트 */
// function fnExpendInitEventButton_ExpendProjectSearch( param, callbackParam )
// {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('project', '', fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('projectInfo', callbackParam, function( value ) {
// $('#txtExpendProjectCode').val(value.projectCode || '');
// $('#txtExpendProjectName').val(value.projectName || '');
// });
// }
// return;
// }
// /* 2.2.1.17 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 거래처 */
// function fnExpendInitEventButton_ExpendPartnerSearch( param, callbackParam )
// {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var addGetParam = '&partnerType=';
// fnExCodeCommonPopup('partner', '', fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('partnerInfo', callbackParam, function( value ) {
// $('#txtExpendPartnerCode').val(value.partnerCode || '');
// $('#txtExpendPartnerName').val(value.partnerName || '');
// });
// }
// return;
// }
// /* 2.2.1.18 문서로드 - 이벤트 바인딩 - 버튼클릭 이벤트 - 카드 */
// function fnExpendInitEventButton_ExpendCardSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var addGetParam = '&partnerType=';
// fnExCodeCommonPopup('card', '', fnGetName().name, '2', '');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('cardInfo', callbackParam, function( value ) {
// $('#txtExpendCardCode').val(value.cardCode || '');
// $('#txtExpendCardName').val(value.cardName || '');
// });
// }
// return;
// }
// /* 3. 헤더 변경 */
// function fnExpendUpdate( param ) {
// var param = (param || '');
// if (param) {
// /* - 회계일자 */
// if (param.expendDate) {
// expendInfo.expend.header.expendDate = param.expendDate;
// }
// /* - 지급요청일 */
// if (param.expendReqDate) {
// expendInfo.expend.header.expendReqDate = param.expendReqDate;
// }
// }
// $.ajax({
// type : 'post',
// url : '<c:url value="/ex/expend/master/ExExpendMasterInfoUpdate.do" />',
// datatype : 'json',
// async : true,
// data : expendInfo.expend.header,
// success : function( data ) {
// return;
// },
// error : function( data ) {
// console.log(' -_- ? Error ! >>>> ' + JSON.stringify(data));
// }
// });
// }
// /* 4. 그리드 설정 */
// function fnSetExpendGrid() {
// var list = expendInfo.gridList;
// var slip = expendInfo.gridSlip;
// var mng = expendInfo.gridMng;
// var items = [];
// if (expendInfo.expend.expendLayout.indexOf('L') > -1) {
// /* [레이아웃] 항목 사용인 경우 */
// $.each(list, function( idx, item ) {
// if (item.item_gbn == 'All' || item.item_gbn == 'EX2002001') {
// items.push(item);
// }
// });
// expendInfo.list.gridHead = items;
// items = [];
// /* [레이아웃] 항목 적용 */
// fnSetExpendGrid_List();
// }
// if (expendInfo.expend.expendLayout.indexOf('S') > -1) {
// /* [레이아웃] 분개 사용인 경우 */
// $.each(slip, function( idx, item ) {
// if (item.item_gbn == 'All' || item.item_gbn == 'EX2002002') {
// items.push(item);
// }
// });
// expendInfo.slip.gridHead = items;
// items = [];
// /* [레이아웃] 분개 적용 */
// fnSetExpendGrid_Slip();
// }
// if (expendInfo.expend.expendLayout.indexOf('M') > -1) {
// /* [레이아웃] 관리항목 사용인 경우 */
// $.each(mng, function( idx, item ) {
// if (item.item_gbn == 'All' || item.item_gbn == 'EX2002003') {
// items.push(item);
// }
// });
// expendInfo.mng.gridHead = items;
// items = [];
// /* [레이아웃] 관리항목 적용 */
// fnSetExpendGrid_Mng();
// }
// return;
// }
// /* 4.1 그리드 설정 - 항목 */
// function fnSetExpendGrid_List() {
// if (window[fnGetName().name + '_' + expendInfo.ifSystem]) {
// window[fnGetName().name + '_' + expendInfo.ifSystem]();
// }
// fnSetExpendGridBind("List", "");
// return;
// }
// /* 4.1.1 그리드 설정 - 항목 - BizboxA */
// function fnSetExpendGrid_List_BizboxA() {
// return;
// }
// /* 4.1.2 그리드 설정 - 항목 - iCUBE */
// function fnSetExpendGrid_List_iCUBE() {
// var defs = [];
// var columns = [];
// if (expendInfo.list.gridHead) {
// $.each(expendInfo.list.gridHead, function( idx, item ) {
// var def = {};
// var column = {};
// if (item.item_gbn == 'All' && item.head_code == '') {
// /* 체크박스 - 렌더정의 */
// def.targets = 0;
// def.data = null;
// def.render = function( aData ) {
// if (aData != null && aData != "") {
// return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.expendSeq
// + '" value="' + aData.expendSeq + '" class="k-checkbox" /><label
// class="k-checkbox-label bdChk" for="inp_chk' + aData.expendSeq +
// '"></label>';
// } else {
// return "";
// }
// }
// /* 체크박스 - 컬럼정의 */
// column.sTitle = "<input type='checkbox' id='chk' name='all_chk'
// onclick='fnAllCheckBoxChecked(this, " + '"' + 'inp_chk' + '"' + ")'>";
// column.bSearchable = false;
// column.bSortable = false;
// column.sWidth = "34";
// column.sClass = "center";
// } else {
// /* 데이터 - 렌더정의 */
// def = null;
// /* 데이터 - 컬럼정의 */
// column.sTitle = item.langpack_name;
// column.mData = item.head_code;
// column.sClass = item.display_align;
// column.sWidth = "";
// column.bVisible = true;
// column.bSortable = true;
// }
// if (null != def) {
// defs.push(def);
// }
// columns.push(column);
// });
// expendInfo.list.columnDefs = defs;
// expendInfo.list.aoColumns = columns;
// }
// return;
// }
// /* 4.1.3 그리드 설정 - 항목 - ERPiU */
// function fnSetExpendGrid_List_ERPiU() {
// var defs = [];
// var columns = [];
// if (expendInfo.list.gridHead) {
// $.each(expendInfo.list.gridHead, function( idx, item ) {
// var def = {};
// var column = {};
// if ((item.item_gbn == 'All' && item.head_code == '') || (item.item_gbn ==
// 'EX2002001' && item.head_code == '')) {
// /* 체크박스 - 렌더정의 */
// def.targets = 0;
// def.data = null;
// def.render = function( aData ) {
// if (aData != null && aData != "") {
// return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.expendSeq
// + '" value="' + aData.expendSeq + '" class="k-checkbox" /><label
// class="k-checkbox-label bdChk" for="inp_chk' + aData.expendSeq +
// '"></label>';
// } else {
// return "";
// }
// }
// /* 체크박스 - 컬럼정의 */
// column.sTitle = "<input type='checkbox' id='chk' name='all_chk'
// onclick='fnAllCheckBoxChecked(this, " + '"' + 'inp_chk' + '"' + ")'>";
// column.bSearchable = false;
// column.bSortable = false;
// column.sWidth = "34";
// column.sClass = "center";
// } else {
// /* 데이터 - 렌더정의 */
// def = null;
// /* 데이터 - 컬럼정의 */
// column.sTitle = item.langpack_name;
// column.mData = item.head_code;
// column.sClass = item.display_align;
// column.sWidth = "";
// column.bVisible = true;
// column.bSortable = true;
// }
// if (null != def) {
// defs.push(def);
// }
// columns.push(column);
// });
// expendInfo.list.columnDefs = defs;
// expendInfo.list.aoColumns = columns;
// }
// return;
// }
// /* 4.2 그리드 설정 - 분개 */
// function fnSetExpendGrid_Slip() {
// if (window[fnGetName().name + '_' + expendInfo.ifSystem]) {
// window[fnGetName().name + '_' + expendInfo.ifSystem]();
// }
// fnSetExpendGridBind("Slip", "");
// return;
// }
// /* 4.2.1 그리드 설정 - 분개 - BizboxA */
// function fnSetExpendGrid_Slip_BizboxA() {
// return;
// }
// /* 4.2.2 그리드 설정 - 분개 - iCUBE */
// function fnSetExpendGrid_Slip_iCUBE() {
// var defs = [];
// var columns = [];
// if (expendInfo.slip.gridHead) {
// $.each(expendInfo.slip.gridHead, function( idx, item ) {
// var def = {};
// var column = {};
// if (item.item_gbn == 'All' && item.head_code == '') {
// /* 체크박스 - 렌더정의 */
// def.targets = 0;
// def.data = null;
// def.render = function( aData ) {
// if (aData != null && aData != "") {
// return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.expendSeq
// + '" value="' + aData.expendSeq + '" class="k-checkbox" /><label
// class="k-checkbox-label bdChk" for="inp_chk' + aData.expendSeq +
// '"></label>';
// } else {
// return "";
// }
// }
// /* 체크박스 - 컬럼정의 */
// column.sTitle = "<input type='checkbox' id='chk' name='all_chk'
// onclick='fnAllCheckBoxChecked(this, " + '"' + 'inp_chk' + '"' + ")'>";
// column.bSearchable = false;
// column.bSortable = false;
// column.sWidth = "34";
// column.sClass = "center";
// } else {
// /* 데이터 - 렌더정의 */
// def = null;
// /* 데이터 - 컬럼정의 */
// column.sTitle = item.langpack_name;
// column.mData = item.head_code;
// column.sClass = item.display_align;
// column.sWidth = "";
// column.bVisible = true;
// column.bSortable = true;
// }
// if (null != def) {
// defs.push(def);
// }
// columns.push(column);
// });
// expendInfo.slip.columnDefs = defs;
// expendInfo.slip.aoColumns = columns;
// }
// return;
// }
// /* 4.2.3 그리드 설정 - 분개 - ERPiU */
// function fnSetExpendGrid_Slip_ERPiU() {
// var defs = [];
// var columns = [];
// if (expendInfo.slip.gridHead) {
// $.each(expendInfo.slip.gridHead, function( idx, item ) {
// var def = {};
// var column = {};
// if ((item.item_gbn == 'All' && item.head_code == '') || (item.item_gbn ==
// 'EX2002002' && item.head_code == '')) {
// /* 체크박스 - 렌더정의 */
// def.targets = 0;
// def.data = null;
// def.render = function( aData ) {
// if (aData != null && aData != "") {
// return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.expendSeq
// + '" value="' + aData.expendSeq + '" class="k-checkbox" /><label
// class="k-checkbox-label bdChk" for="inp_chk' + aData.expendSeq +
// '"></label>';
// } else {
// return "";
// }
// }
// /* 체크박스 - 컬럼정의 */
// column.sTitle = "<input type='checkbox' id='chk' name='all_chk'
// onclick='fnAllCheckBoxChecked(this, " + '"' + 'inp_chk' + '"' + ")'>";
// column.bSearchable = false;
// column.bSortable = false;
// column.sWidth = "34";
// column.sClass = "center";
// } else {
// /* 데이터 - 렌더정의 */
// def = null;
// /* 데이터 - 컬럼정의 */
// column.sTitle = item.langpack_name;
// column.mData = item.head_code;
// column.sClass = item.display_align;
// column.sWidth = "";
// column.bVisible = true;
// column.bSortable = true;
// }
// if (null != def) {
// defs.push(def);
// }
// columns.push(column);
// });
// expendInfo.slip.columnDefs = defs;
// expendInfo.slip.aoColumns = columns;
// }
// return;
// }
// /* 4.3 그리드 설정 - 관리항목 */
// function fnSetExpendGrid_Mng() {
// if (window[fnGetName().name + '_' + expendInfo.ifSystem]) {
// window[fnGetName().name + '_' + expendInfo.ifSystem]();
// }
// fnSetExpendGridBind("Mng", "");
// return;
// }
// /* 4.3.1 그리드 설정 - 관리항목 - BizboxA */
// function fnSetExpendGrid_Mng_BizboxA() {
// return;
// }
// /* 4.3.2 그리드 설정 - 관리항목 - iCUBE */
// function fnSetExpendGrid_Mng_iCUBE() {
// var defs = [];
// var columns = [];
// if (expendInfo.mng.gridHead) {
// $.each(expendInfo.mng.gridHead, function( idx, item ) {
// var def = {};
// var column = {};
// if (item.item_gbn == 'All' && item.head_code == '') {
// /* 체크박스 - 렌더정의 */
// def.targets = 0;
// def.data = null;
// def.render = function( aData ) {
// if (aData != null && aData != "") {
// return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.expendSeq
// + '" value="' + aData.expendSeq + '" class="k-checkbox" /><label
// class="k-checkbox-label bdChk" for="inp_chk' + aData.expendSeq +
// '"></label>';
// } else {
// return "";
// }
// }
// /* 체크박스 - 컬럼정의 */
// column.sTitle = "<input type='checkbox' id='chk' name='all_chk'
// onclick='fnAllCheckBoxChecked(this, " + '"' + 'inp_chk' + '"' + ")'>";
// column.bSearchable = false;
// column.bSortable = false;
// column.sWidth = "34";
// column.sClass = "center";
// } else {
// /* 데이터 - 렌더정의 */
// def = null;
// /* 데이터 - 컬럼정의 */
// column.sTitle = item.langpack_name;
// column.mData = item.head_code;
// column.sClass = item.display_align;
// column.sWidth = "";
// column.bVisible = true;
// column.bSortable = true;
// }
// if (null != def) {
// defs.push(def);
// }
// columns.push(column);
// });
// expendInfo.mng.columnDefs = defs;
// expendInfo.mng.aoColumns = columns;
// }
// return;
// }
// /* 4.3.3 그리드 설정 - 관리항목 - ERPiU */
// function fnSetExpendGrid_Mng_ERPiU() {
// var defs = [];
// var columns = [];
// if (expendInfo.mng.gridHead) {
// $.each(expendInfo.mng.gridHead, function( idx, item ) {
// var def = {};
// var column = {};
// if (item.item_gbn == 'All' && item.head_code == '') {
// /* 체크박스 - 렌더정의 */
// def.targets = 0;
// def.data = null;
// def.render = function( aData ) {
// if (aData != null && aData != "") {
// return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.expendSeq
// + '" value="' + aData.expendSeq + '" class="k-checkbox" /><label
// class="k-checkbox-label bdChk" for="inp_chk' + aData.expendSeq +
// '"></label>';
// } else {
// return "";
// }
// }
// /* 체크박스 - 컬럼정의 */
// column.sTitle = "<input type='checkbox' id='chk' name='all_chk'
// onclick='fnAllCheckBoxChecked(this, " + '"' + 'inp_chk' + '"' + ")'>";
// column.bSearchable = false;
// column.bSortable = false;
// column.sWidth = "34";
// column.sClass = "center";
// } else {
// /* 데이터 - 렌더정의 */
// def = null;
// /* 데이터 - 컬럼정의 */
// column.sTitle = item.langpack_name;
// column.mData = item.head_code;
// column.sClass = item.display_align;
// column.sWidth = "";
// column.bVisible = true;
// column.bSortable = true;
// }
// if (null != def) {
// defs.push(def);
// }
// columns.push(column);
// });
// expendInfo.mng.columnDefs = defs;
// expendInfo.mng.aoColumns = columns;
// }
// return;
// }
// /* 5. 그리드 바인딩 */
// function fnSetExpendGridBind( type, data ) {
// if (type == "List") {
// if (expendInfo.expend.expendLayout.indexOf('L') > -1) {
// if (window[fnGetName().name + '_' + type]) {
// window[fnGetName().name + '_' + type](data);
// }
// } else {
// return;
// }
// } else if (type == "Slip") {
// if (expendInfo.expend.expendLayout.indexOf('S') > -1) {
// if (window[fnGetName().name + '_' + type]) {
// window[fnGetName().name + '_' + type](data);
// }
// } else {
// return;
// }
// } else if (type == "Mng") {
// if (expendInfo.expend.expendLayout.indexOf('M') > -1) {
// if (window[fnGetName().name + '_' + type]) {
// window[fnGetName().name + '_' + type](data);
// }
// } else {
// return;
// }
// }
// return;
// }
// /* 5.1 그리드 바인딩 - 항목 */
// function fnSetExpendGridBind_List( data ) {
// console.log('fnSetExpendGridBind_List 진입');
// if (window[fnGetName().name + '_' + expendInfo.ifSystem]) {
// window[fnGetName().name + '_' + expendInfo.ifSystem](data);
// }
// return;
// }
// /* 5.1.1 그리드 바인딩 - 항목 - BizboxA */
// function fnSetExpendGridBind_List_BizboxA( data ) {
// return;
// }
// /* 5.1.2 그리드 바인딩 - 항목 - iCUBE */
// function fnSetExpendGridBind_List_iCUBE( data ) {
// if (data == undefined || data == '') {
// if (!expendInfo['list']['info']) { return; }
// var tableData = expendInfo['list']['info'];
// var obj = {};
// var arr = [];
// $.each(tableData, function( sourceIdx, sourceItem ) {
// $.each(expendInfo['list']['gridHead'], function( headIdx, headItem ) {
// var item = getObjectsValue(sourceItem, headItem.head_code);
// if (obj[headItem.head_code] == undefined || obj[headItem.head_code] == '') {
// if (item[0]) {
// if (item[0][headItem.head_code] != undefined) {
// obj[headItem.head_code] = item[0][headItem.head_code];
// } else {
// obj[headItem.head_code] = '';
// }
// } else {
// if (item[headItem.head_code] != undefined) {
// obj[headItem.head_code] = headItem.head_code;
// } else {
// obj[headItem.head_code] = '';
// }
// }
// }
// })
// /* 기본사항 처리 */
// var baseValue = [ 'expendSeq', 'listSeq', 'stdAmt', 'subStdAmt', 'taxAmt',
// 'subTaxAmt', 'amt' ]
// $.each(baseValue, function( headIdx, headItem ) {
// var item = getObjectsValue(sourceItem, headItem);
// if (obj[headItem] == undefined || obj[headItem] == '') {
// if (item[0]) {
// if (item[0][headItem] != undefined) {
// obj[headItem] = item[0][headItem];
// } else {
// obj[headItem] = '';
// }
// } else {
// if (item[headItem] != undefined) {
// obj[headItem] = headItem;
// } else {
// obj[headItem] = '';
// }
// }
// }
// });
// /* 기본사항 처리 - 공급가액 */
// if (obj.stdAmt == '') {
// obj.stdAmt = '0';
// } else {
// obj.stdAmt = obj.stdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
// }
// /* 기본사항 처리 - 과세표준액 */
// if (obj.subStdAmt == '') {
// obj.subStdAmt = '0';
// } else {
// obj.subStdAmt = obj.subStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
// ",")
// }
// /* 기본사항 처리 - 부가세액 */
// if (obj.taxAmt == '') {
// obj.taxAmt = '0';
// } else {
// obj.taxAmt = obj.taxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
// }
// /* 기본사항 처리 - 세액 */
// if (obj.subTaxAmt == '') {
// obj.subTaxAmt = '0';
// } else {
// obj.subTaxAmt = obj.subTaxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
// ",")
// }
// /* 기본사항 처리 - 공급대가 */
// if (obj.amt == '') {
// obj.amt = '0';
// } else {
// obj.amt = obj.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
// }
// arr.push(obj);
// obj = {};
// });
// data = {};
// data = arr;
// }
// var listStdAmt = 0;
// var listTaxAmt = 0;
// var listAmt = 0;
// var listSubStdAmt = 0;
// var listSubTaxAmt = 0;
// $.each(data, function( name, value ) {
// var stdAmt= 0, taxAmt=0, amt=0, subStdAmt=0, subTaxAmt=0;
// if(name == 'stdAmt')
// {
// stdAmt = (value || '0').toString().replace(/,/g, '');
// }
// else if(name == 'taxAmt')
// {
// taxAmt = (value || '0').toString().replace(/,/g, '');
// }
// else if(name == 'amt')
// {
// amt = (value || '0').toString().replace(/,/g, '');
// }
// else if(name=='subStdAmt')
// {
// subStdAmt == (value || '0').toString().replace(/,/g, '');
// }
// else if(name =='subTaxAmt')
// {
// subTaxAmt == (value || '0').toString().replace(/,/g, '');
// }
// listStdAmt = Number(listStdAmt) + Number(stdAmt);
// listTaxAmt = Number(listTaxAmt) + Number(taxAmt);
// listAmt = Number(listAmt) + Number(amt);
// listSubStdAmt = Number(listSubStdAmt) + Number(subStdAmt);
// listSubTaxAmt = Number(listSubTaxAmt) + Number(subTaxAmt);
// });
// listStdAmt = listStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
// listTaxAmt = listTaxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
// listAmt = listAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
// listSubStdAmt = listSubStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
// ",");
// listSubTaxAmt = listSubTaxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
// ",");
// $('#lbListStdAmt').html(listStdAmt + ' (' + listSubStdAmt + ')');
// $('#lbListTaxAmt').html(listTaxAmt + ' (' + listSubTaxAmt + ')');
// $('#lbListAmt').html(listAmt);
// console.log('데이터:'+JSON.stringify(data));
// console.log('컬럼 헤더:'+JSON.stringify(expendInfo.list.columnDefs));
// console.log('컬럼 바인딩:'+JSON.stringify(expendInfo.list.aoColumns));
// $('#tblExpendList').dataTable({
// bJQueryUI : true, //jQuery UI 테마를 적용받음
// sDom : '<r>t', //컬럼 드레그 재정렬
// bProcessing : true, //처리 중 표시
// bServerSide : false,
// destroy : true,
// // sScrollY : "370px",
// bAutoWidth : false,
// paging : false,
// ordering : false,
// info : false,
// fixedHeader : true,
// select : true,
// data : data.listJsonStr,
// language : {
// lengthMenu : "보기 _MENU_",
// zeroRecords : "데이터가 없습니다.",
// info : "_PAGE_ / _PAGES_",
// infoEmpty : "데이터가 없습니다.",
// infoFiltered : "(전체 _MAX_ 중.)"
// },
// fnRowCallback : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
// $(nRow).css("cursor", "pointer");
// /* $(nRow).on('click', (function() { fnConfigExpendEventSelect_Row(aData);
// })); */
// return nRow;
// },
// columnDefs : expendInfo.list.columnDefs,
// aoColumns : expendInfo.list.aoColumns
// });
// return;
// }
// function getObjectsValue( obj, key ) {
// var objects = [];
// for ( var i in obj) {
// if (!obj.hasOwnProperty(i)) continue;
// if (typeof obj[i] == 'object') {
// objects = objects.concat(getObjectsValue(obj[i], key));
// } else if (i == key) {
// objects.push(obj);
// }
// }
// return objects;
// }
// /* 5.1.3 그리드 바인딩 - 항목 - ERPiU */
// function fnSetExpendGridBind_List_ERPiU( data ) {
// if (data == undefined || data == '') {
// if (!expendInfo['list']['info']) { return; }
// var tableData = expendInfo['list']['info'];
// var obj = {};
// var arr = [];
// $.each(tableData, function( sourceIdx, sourceItem ) {
// $.each(expendInfo['list']['gridHead'], function( headIdx, headItem ) {
// var item = getObjectsValue(sourceItem, headItem.head_code);
// if (obj[headItem.head_code] == undefined || obj[headItem.head_code] == '') {
// if (item[0]) {
// if (item[0][headItem.head_code] != undefined) {
// obj[headItem.head_code] = item[0][headItem.head_code];
// } else {
// obj[headItem.head_code] = '';
// }
// } else {
// if (item[headItem.head_code] != undefined) {
// obj[headItem.head_code] = headItem.head_code;
// } else {
// obj[headItem.head_code] = '';
// }
// }
// }
// })
// /* 기본사항 처리 */
// var baseValue = [ 'expendSeq', 'listSeq', 'stdAmt', 'subStdAmt', 'taxAmt',
// 'subTaxAmt', 'amt' ]
// $.each(baseValue, function( headIdx, headItem ) {
// var item = getObjectsValue(sourceItem, headItem);
// if (obj[headItem] == undefined || obj[headItem] == '') {
// if (item[0]) {
// if (item[0][headItem] != undefined) {
// obj[headItem] = item[0][headItem];
// } else {
// obj[headItem] = '';
// }
// } else {
// if (item[headItem] != undefined) {
// obj[headItem] = headItem;
// } else {
// obj[headItem] = '';
// }
// }
// }
// });
// /* 기본사항 처리 - 공급가액 */
// if (obj.stdAmt == '') {
// obj.stdAmt = '0';
// } else {
// obj.stdAmt = obj.stdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
// }
// /* 기본사항 처리 - 과세표준액 */
// if (obj.subStdAmt == '') {
// obj.subStdAmt = '0';
// } else {
// obj.subStdAmt = obj.subStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
// ",")
// }
// /* 기본사항 처리 - 부가세액 */
// if (obj.taxAmt == '') {
// obj.taxAmt = '0';
// } else {
// obj.taxAmt = obj.taxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
// }
// /* 기본사항 처리 - 세액 */
// if (obj.subTaxAmt == '') {
// obj.subTaxAmt = '0';
// } else {
// obj.subTaxAmt = obj.subTaxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
// ",")
// }
// /* 기본사항 처리 - 공급대가 */
// if (obj.amt == '') {
// obj.amt = '0';
// } else {
// obj.amt = obj.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
// }
// arr.push(obj);
// obj = {};
// });
// data = {};
// data = arr;
// }
// var listStdAmt = 0;
// var listTaxAmt = 0;
// var listAmt = 0;
// var listSubStdAmt = 0;
// var listSubTaxAmt = 0;
// $.each(data, function( idx, item ) {
// var stdAmt, taxAmt, amt, subStdAmt, subTaxAmt;
// stdAmt = (item.stdAmt || '0').toString().replace(/,/g, '');
// taxAmt = (item.taxAmt || '0').toString().replace(/,/g, '');
// amt = (item.amt || '0').toString().replace(/,/g, '');
// subStdAmt = (item.subStdAmt || '0').toString().replace(/,/g, '');
// subTaxAmt = (item.subTaxAmt || '0').toString().replace(/,/g, '');
// listStdAmt = Number(listStdAmt) + Number(stdAmt);
// listTaxAmt = Number(listTaxAmt) + Number(taxAmt);
// listAmt = Number(listAmt) + Number(amt);
// listSubStdAmt = Number(listSubStdAmt) + Number(subStdAmt);
// listSubTaxAmt = Number(listSubTaxAmt) + Number(subTaxAmt);
// });
// listStdAmt = listStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
// listTaxAmt = listTaxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
// listAmt = listAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
// listSubStdAmt = listSubStdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
// ",");
// listSubTaxAmt = listSubTaxAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g,
// ",");
// $('#lbListStdAmt').html(listStdAmt + ' (' + listSubStdAmt + ')');
// $('#lbListTaxAmt').html(listTaxAmt + ' (' + listSubTaxAmt + ')');
// $('#lbListAmt').html(listAmt);
// $('#tblExpendList').dataTable({
// bJQueryUI : true, //jQuery UI 테마를 적용받음
// sDom : '<r>t', //컬럼 드레그 재정렬
// bProcessing : true, //처리 중 표시
// bServerSide : false,
// destroy : true,
// // sScrollY : "370px",
// bAutoWidth : false,
// paging : false,
// ordering : false,
// info : false,
// fixedHeader : true,
// select : true,
// data : data,
// language : {
// lengthMenu : "보기 _MENU_",
// zeroRecords : "데이터가 없습니다.",
// info : "_PAGE_ / _PAGES_",
// infoEmpty : "데이터가 없습니다.",
// infoFiltered : "(전체 _MAX_ 중.)"
// },
// fnRowCallback : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
// $(nRow).css("cursor", "pointer");
// /* $(nRow).on('click', (function() { fnConfigExpendEventSelect_Row(aData);
// })); */
// return nRow;
// },
// columnDefs : expendInfo.list.columnDefs,
// aoColumns : expendInfo.list.aoColumns
// });
// return;
// }
// /* 5.2 그리드 바인딩 - 분개 */
// function fnSetExpendGridBind_Slip( data ) {
// if (window[fnGetName().name + '_' + expendInfo.ifSystem]) {
// window[fnGetName().name + '_' + expendInfo.ifSystem](data);
// }
// return;
// }
// /* 5.3.1 그리드 바인딩 - 분개 - BizboxA */
// function fnSetExpendGridBind_Slip_BizboxA( data ) {
// return;
// }
// /* 5.2.2 그리드 바인딩 - 분개 - iCUBE */
// function fnSetExpendGridBind_Slip_iCUBE( data ) {
// $('#tblExpendSlip').dataTable({
// bJQueryUI : true, //jQuery UI 테마를 적용받음
// sDom : '<r>t', //컬럼 드레그 재정렬
// bProcessing : true, //처리 중 표시
// bServerSide : false,
// destroy : true,
// // sScrollY : "370px",
// bAutoWidth : false,
// paging : false,
// ordering : false,
// info : false,
// fixedHeader : true,
// select : true,
// data : data,
// language : {
// lengthMenu : "보기 _MENU_",
// zeroRecords : "데이터가 없습니다.",
// info : "_PAGE_ / _PAGES_",
// infoEmpty : "데이터가 없습니다.",
// infoFiltered : "(전체 _MAX_ 중.)"
// },
// fnRowCallback : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
// $(nRow).css("cursor", "pointer");
// /* $(nRow).on('click', (function() { fnConfigExpendEventSelect_Row(aData);
// })); */
// return nRow;
// },
// // columnDefs : expendInfo.slip.columnDefs,
// aoColumns : expendInfo.slip.aoColumns
// });
// return;
// }
// /* 5.2.3 그리드 바인딩 - 분개 - ERPiU */
// function fnSetExpendGridBind_Slip_ERPiU( data ) {
// $('#tblExpendSlip').dataTable({
// bJQueryUI : true, //jQuery UI 테마를 적용받음
// sDom : '<r>t', //컬럼 드레그 재정렬
// bProcessing : true, //처리 중 표시
// bServerSide : false,
// destroy : true,
// // sScrollY : "370px",
// bAutoWidth : false,
// paging : false,
// ordering : false,
// info : false,
// fixedHeader : true,
// select : true,
// data : data,
// language : {
// lengthMenu : "보기 _MENU_",
// zeroRecords : "데이터가 없습니다.",
// info : "_PAGE_ / _PAGES_",
// infoEmpty : "데이터가 없습니다.",
// infoFiltered : "(전체 _MAX_ 중.)"
// },
// fnRowCallback : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
// $(nRow).css("cursor", "pointer");
// /* $(nRow).on('click', (function() { fnConfigExpendEventSelect_Row(aData);
// })); */
// return nRow;
// },
// // columnDefs : expendInfo.slip.columnDefs,
// aoColumns : expendInfo.slip.aoColumns
// });
// return;
// }
// /* 5.3 그리드 바인딩 - 관리항목 */
// function fnSetExpendGridBind_Mng( data ) {
// if (window[fnGetName().name + '_' + expendInfo.ifSystem]) {
// window[fnGetName().name + '_' + expendInfo.ifSystem](data);
// }
// return;
// }
// /* 5.3.1 그리드 바인딩 - 관리항목 - BizboxA */
// function fnSetExpendGridBind_Mng_BizboxA( data ) {
// return;
// }
// /* 5.3.2 그리드 바인딩 - 관리항목 - iCUBE */
// function fnSetExpendGridBind_Mng_iCUBE( data ) {
// $('#tblExpendMng').dataTable({
// bJQueryUI : true, //jQuery UI 테마를 적용받음
// sDom : '<r>t', //컬럼 드레그 재정렬
// bProcessing : true, //처리 중 표시
// bServerSide : false,
// destroy : true,
// // sScrollY : "370px",
// bAutoWidth : false,
// paging : false,
// ordering : false,
// info : false,
// fixedHeader : true,
// select : true,
// data : data,
// language : {
// lengthMenu : "보기 _MENU_",
// zeroRecords : "데이터가 없습니다.",
// info : "_PAGE_ / _PAGES_",
// infoEmpty : "데이터가 없습니다.",
// infoFiltered : "(전체 _MAX_ 중.)"
// },
// fnRowCallback : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
// $(nRow).css("cursor", "pointer");
// /* $(nRow).on('click', (function() { fnConfigExpendEventSelect_Row(aData);
// })); */
// return nRow;
// },
// // columnDefs : expendInfo.mng.columnDefs,
// aoColumns : expendInfo.mng.aoColumns
// });
// return;
// }
// /* 5.3.3 그리드 바인딩 - 관리항목 - ERPiU */
// function fnSetExpendGridBind_Mng_ERPiU( data ) {
// $('#tblExpendMng').dataTable({
// bJQueryUI : true, //jQuery UI 테마를 적용받음
// sDom : '<r>t', //컬럼 드레그 재정렬
// bProcessing : true, //처리 중 표시
// bServerSide : false,
// destroy : true,
// // sScrollY : "370px",
// bAutoWidth : false,
// paging : false,
// ordering : false,
// info : false,
// fixedHeader : true,
// select : true,
// data : data,
// language : {
// lengthMenu : "보기 _MENU_",
// zeroRecords : "데이터가 없습니다.",
// info : "_PAGE_ / _PAGES_",
// infoEmpty : "데이터가 없습니다.",
// infoFiltered : "(전체 _MAX_ 중.)"
// },
// fnRowCallback : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
// $(nRow).css("cursor", "pointer");
// /* $(nRow).on('click', (function() { fnConfigExpendEventSelect_Row(aData);
// })); */
// return nRow;
// },
// // columnDefs : expendInfo.mng.columnDefs,
// aoColumns : expendInfo.mng.aoColumns
// });
// return;
// }

/*
 * 항목추가
 * --------------------------------------------------------------------------------
 */
/*
 * 항목추가
 * --------------------------------------------------------------------------------
 */
/*
 * 항목추가
 * --------------------------------------------------------------------------------
 */
/*
 * 항목추가
 * --------------------------------------------------------------------------------
 */
/*
 * 항목추가
 * --------------------------------------------------------------------------------
 */
/*
 * 항목추가
 * --------------------------------------------------------------------------------
 */

// /* 1. 변수정의 */
// var testType = 'test';
// var listInfo = {
// expendSeq : "",
// listSeq : "",
// note : "",
// authDate : "",
// stdAmt : "",
// taxAmt : "",
// amt : "",
// subStdAmt : "",
// subTaxAmt : "",
// list : {
// creEmpInfo : {},
// useEmpInfo : {},
// budgetInfo : {},
// projectInfo : {},
// partnerInfo : {},
// cardInfo : {},
// summaryInfo : {},
// authInfo : {},
// notaxInfo : {},
// vatInfo : {},
// }
// };
// fnExCodeCopy();
// var width = '380'; /* 공통코드 레이어 너비 */
// var height = '643'; /* 공통코드 레이어 높이 */
// var parentId = 'layerExpendList';
// var childrenId = 'layerCommonCode';
// /* 2. 문서로드 */
// $(document).ready(function() {
// fnListInit();
// fnListInitEvent();
// });
// /* 2.1 문서로드 - 초기화 */
// function fnListInit() {
// fnListSetMoneyMask();
// fnListSetDatepicker();
// fnExpendSetListLayout();
// return;
// }
// /* 2.1.1 문서로드 - 초기화 - datepicker 설정 */
// function fnListSetDatepicker() {
// var datePicker = $("#txtListAuthDate");
// datePicker.kendoMaskedTextBox({
// mask : '0000-00-00'
// });
// datePicker.kendoDatePicker({
// previous : "",
// culture : "ko-KR",
// format : "yyyy-MM-dd",
// change : function() {
// var value = this.value();
// var year = value.getFullYear();
// var month = "00" + Number(value.getMonth() + 1);
// month = month.substring(month.length - 2);
// var date = "00" + value.getDate();
// date = date.substring(date.length - 2);
// // $('#txtListNote').val([ year, month, date ].join('-') + ' ' +
// $('#txtListNote').val());
// }
// });
// datePicker.closest(".k-datepicker").add(datePicker).removeClass('k-textbox');
// }
// function fnListSetMoneyMask() {
// $('#txtListStdAmt, #txtListTaxAmt, #txtListAmt').maskMoney({
// precision : 0
// });
// $('#txtListStdAmt').change(function() {
// var paramStdAmt = $('#txtListStdAmt').val();
// paramStdAmt = paramStdAmt.replace(/,/, '');
// fnInputStdAmt(paramStdAmt, '2');
// });
// $('#txtListTaxAmt').change(function() {
// var paramTaxAmt = $('#txtListTaxAmt').val();
// paramTaxAmt = paramTaxAmt.replace(/,/, '');
// fnInputTaxAmt(paramTaxAmt, '2');
// });
// $('#txtListAmt').change(function() {
// var paramAmt = $('#txtListAmt').val();
// paramAmt = paramAmt.replace(/,/, '');
// fnInputAmt(paramAmt, '2');
// });
// $('#txtListSubStdAmt').change(function() {
// var paramAmt = $('#txtListSubStdAmt').val();
// paramAmt = paramAmt.replace(/,/, '');
// fnInputSubStdAmt(paramAmt, '2');
// });
// $('#txtListSubTaxAmt').change(function() {
// var paramAmt = $('#txtListSubTaxAmt').val();
// paramAmt = paramAmt.replace(/,/, '');
// fnInputSubTaxAmt(paramAmt, '2');
// });
// }
// /* 2.2 문서로드 - 이벤트 바인딩 */
// function fnListInitEvent() {
// var fncName = fnGetName().name;
// /* 저장 - BizboxA */
// $('#btnListSave').click(function() {
// /* - 저장 */
// fnListSave();
// });
// /* 표준적요 - BizboxA / 증빙유형 - BizboxA */
// $('#btnListSummarySearch, #btnListAuthSearch').click(function( event ) {
// /* - 표준적요 *//* - 증빙유형 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 연동시스템별 처리 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// if (window[fnGetName().name + '_' + info.ifSystem]) {
// window[fnGetName().name + '_' + info.ifSystem]();
// }
// return;
// }
// /* 2.2.1 문서로드 - 이벤트 바인딩 - 표준적요 */
// function fnListInitEvent_ListSummarySearch() {
// /* 연동시스템별 처리 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// if (window[fnGetName().name + '_' + info.ifSystem]) {
// window[fnGetName().name + '_' + info.ifSystem]();
// }
// return;
// }
// /* 2.2.1.1 문서로드 - 이벤트 바인딩 - 표준적요 - BizboxA */
// function fnListInitEvent_ListSummarySearch_BizboxA( param, callbackParam ) {
// return;
// }
// /* 2.2.1.2 문서로드 - 이벤트 바인딩 - 표준적요 - iCUBE */
// function fnListInitEvent_ListSummarySearch_iCUBE( param, callbackParam ) {
// /* 파라미터 확인 */
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// // getParam += '&searchStr=' + $('#txtListSummaryName').val();
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// getParam += '&summarySearchType=A';
// var summaryParam = {
// url : "<c:url value='/ex/code/summary/ExSummaryPopup.do'/>",
// getParam : getParam,
// title : "표준적요",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(summaryParam);
// return;
// } else {
// /* callbackParam = { compSeq : "", summaryCode : "", summaryName : "",
// summaryType : "", drAcctCode : "", drAcctName : "", crAcctCode : "",
// crAcctName : "", vatAcctCode : "", vatAcctName : "" } */
// $.extend(listInfo.list.summaryInfo, callbackParam);
// /* 적요코드 : summaryCode */
// $('#txtListSummaryCode').val((callbackParam.summaryCode || ''));
// /* 차변계정명칭 : drAcctName */
// $('#txtListDrAcctName').val((callbackParam.drAcctName || ''));
// /* 적요명칭 : summaryName */
// $('#txtListSummaryName').val((callbackParam.summaryName || ''));
// /* 적요 자동입력 */
// /* 고민거리 : 적요 자동입력 옵션 및 적요 형태 처리 */
// if ($('#txtListNote').val() == '') {
// $('#txtListNote').val(callbackParam.summaryName + ' [' +
// callbackParam.drAcctName + '(' + callbackParam.drAcctCode + ') / ' +
// callbackParam.crAcctName + '(' + callbackParam.crAcctCode + ')' + ']');
// }
// }
// }
// /* 2.2.1.3 문서로드 - 이벤트 바인딩 - 표준적요 - ERPiU */
// function fnListInitEvent_ListSummarySearch_ERPiU( param, callbackParam ) {
// /* 파라미터 확인 */
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// // getParam += '&searchStr=' + $('#txtListSummaryName').val();
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// getParam += '&summarySearchType=A';
// var summaryParam = {
// url : "<c:url value='/ex/code/summary/ExSummaryPopup.do'/>",
// getParam : getParam,
// title : "표준적요",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(summaryParam);
// return;
// } else {
// /* callbackParam = { compSeq : "", summaryCode : "", summaryName : "",
// summaryType : "", drAcctCode : "", drAcctName : "", crAcctCode : "",
// crAcctName : "", vatAcctCode : "", vatAcctName : "" } */
// $.extend(listInfo.list.summaryInfo, callbackParam);
// /* 적요코드 : summaryCode */
// $('#txtListSummaryCode').val((callbackParam.summaryCode || ''));
// /* 차변계정명칭 : drAcctName */
// $('#txtListDrAcctName').val((callbackParam.drAcctName || ''));
// /* 적요명칭 : summaryName */
// $('#txtListSummaryName').val((callbackParam.summaryName || ''));
// /* 적요 자동입력 */
// /* 고민거리 : 적요 자동입력 옵션 및 적요 형태 처리 */
// if ($('#txtListNote').val() == '') {
// $('#txtListNote').val(callbackParam.summaryName + ' [' +
// callbackParam.drAcctName + '(' + callbackParam.drAcctCode + ') / ' +
// callbackParam.crAcctName + '(' + callbackParam.crAcctCode + ')' + ']');
// }
// }
// }
// /* 2.2.2 문서로드 - 이벤트 바인딩 - 증빙유형 */
// function fnListInitEvent_ListAuthSearch() {
// /* 공통사항 */
// if (!listInfo || !listInfo.list.summaryInfo ||
// !listInfo.list.summaryInfo.summaryCode) {
// alert('표준적요가 선택되지 않았습니다.');
// return;
// }
// /* 연동시스템별 처리 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// if (window[fnGetName().name + '_' + info.ifSystem]) {
// window[fnGetName().name + '_' + info.ifSystem]();
// }
// return;
// }
// /* 2.2.2.1 문서로드 - 이벤트 바인딩 - 증빙유형 - BizboxA */
// function fnListInitEvent_ListAuthSearch_BizboxA( param, callbackParam ) {
// return;
// }
// /* 2.2.2.2 문서로드 - 이벤트 바인딩 - 증빙유형 - iCUBE */
// function fnListInitEvent_ListAuthSearch_iCUBE( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// // getParam += '&searchStr=' + $('#txtListAuthName').val();
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// var authParam = {
// url : "<c:url value='/ex/code/auth/ExAuthPopup.do'/>",
// getParam : getParam,
// title : "증빙유형",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(authParam);
// return;
// } else {
// /**************************** 증빙유형 값 매핑 수행 ************** *************/
// $.extend(listInfo.list.authInfo, callbackParam);
// /* 증빙유형코드 : authCode */
// $('#txtListAuthCode').val((callbackParam.authCode || ''));
// /* 증빙유형명칭 : authName */
// $('#txtListAuthName').val((callbackParam.authName || ''));
// /* 공급가액, 부가세 활성화 */
// $('#txtListStdAmt, #txtListTaxAmt').removeAttr('disabled');
// //필수값 처리
// fnExpendSetListLayout();
// //금액 계산
// fnInputAmt($('#txtListAmt').val(), '2');
// /**************** 증빙유형에 따른 부가세 구분 및 사유 구분 값 바인딩 **************/
// /*
// * 값 매핑시 부가세 구분 확인, 사유구분 값 확인
// * 1. 부가세 구분이 존재한다면 부가세 tr 표시
// * 2. 부가세 매핑
// */
// if (callbackParam.vatTypeCode != '') {
// $('.ExpendListiCUBE.ExpendVatType').show();
// $('.ExpendListiCUBE.ExpendVatType').removeAttr('disabled');
// console.log(callbackParam.vatTypeCode);
// console.log(callbackParam.vatTypeName);
// /*
// * 부가세 구분 값: 23 - 면세매입, 24 - 매입불공, 26 - 의제매입세액 인경우 사유 구분 tr 표시
// * 사유 구분값 매핑
// */
// if ('|23|24|26|'.indexOf(callbackParam.vatTypeCode) != -1) {
// $('.ExpendListiCUBE.ExpendVatReason').removeAttr('disabled');
// $('#txtListVateReasonCode').val(callbackParam.vaCtdCode);
// $('#txtListVatReasonName').val(callbackParam.vaCtdName);
// $('.ExpendListiCUBE.ExpendVatReason').show();
// } else {
// $('.ExpendListiCUBE.ExpendVatReason').hide();
// $('.ExpendListiCUBE.ExpendVatReason').attr('disabled');
// $('#txtListVaReasonCode').val('');
// $('#txtListVaReasonName').val('');
// }
// var newVatInfo = [];
// newVatInfo.vatCode = callbackParam.vatTypeCode;
// newVatInfo.vatName = callbackParam.vatTypeName;
// fnExCodeCommonBind('vatInfo', newVatInfo, function( value ) {
// $('#txtListVatTypeCode').val(value.vatCode);
// $('#txtListVatTypeName').val(value.vatName);
// });
// var newNotaxInfo = [];
// newNotaxInfo.vaCtdCd = callbackParam.vaCtdCd;
// newNotaxInfo.vaCtdNm = callbackParam.vaCtdNm;
// fnExCodeCommonBind('notaxInfo', newNotaxInfo, function( value ) {
// $('#txtListVatReasonCode').val(value.vaCtdCd);
// $('#txtListVatReasonName').val(value.vaCtdNm);
// });
// console.log('list.notaxInfo:' + JSON.stringify(listInfo.list.notaxInfo));
// console.log('list.vatInfo' + JSON.stringify(listInfo.list.vatInfo));
// } else {
// $('.ExpendListiCUBE.ExpendVatType').hide();
// $('.ExpendListiCUBE.ExpendVatType').attr('disabled');
// $('#txtListVatTypeCode').val('');
// $('#txtListVatTypeName').val('');
// var newVatInfo = [];
// fnExCodeCommonBind('vatInfo', newVatInfo, function( value ) {
// $('#txtListVatTypeCode').val('');
// $('#txtListVatTypeName').val('');
// });
// var newNotaxInfo = [];
// fnExCodeCommonBind('notaxInfo', newNotaxInfo, function( value ) {
// $('#txtListVatReasonCode').val('');
// $('#txtListVatReasonName').val('');
// });
// }
// }
// return;
// }
// /* 2.2.2.3 문서로드 - 이벤트 바인딩 - 증빙유형 - ERPiU */
// function fnListInitEvent_ListAuthSearch_ERPiU( param, callbackParam ) {
// /* 파라미터 확인 */
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// // getParam += '&searchStr=' + $('#txtListAuthName').val();
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// var authParam = {
// url : "<c:url value='/ex/code/auth/ExAuthPopup.do'/>",
// getParam : getParam,
// title : "증빙유형",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(authParam);
// return;
// } else {
// $.extend(listInfo.list.authInfo, callbackParam);
// /* callbackParam = { authCode: "", authDateReqYN: "", authGbn: "", authName:
// "", cardReqYN: "", cashType: "", compSeq: "", crAcctCode: "", crAcctName: "",
// erpAuthCode: "", erpAuthName: "", noTaxCode: "", noTaxName: "", noteReqYN:
// "", partnerReqYN: "", projectReqYN: "", vatAcctCode: "", vatAcctName: "",
// vatTypeCode: "", vatTypeName: "" } */
// /* 증빙유형코드 : authCode */
// $('#txtListAuthCode').val((callbackParam.authCode || ''));
// /* 증빙유형명칭 : authName */
// $('#txtListAuthName').val((callbackParam.authName || ''));
// /* 공급가액, 부가세 활성화 */
// $('#txtListStdAmt, #txtListTaxAmt').removeAttr('disabled');
// /* 세무구분에 따른 별도 처리 */
// if (callbackParam.vatTypeCode && callbackParam.vatTypeCode != '') {
// /* ERPiU 부가세 구분에 따른 처리 */
// /* 불공인경우 불공제구분 선택할 수 있도록 조치 */
// if ('|22|50|'.indexOf(callbackParam.vatTypeCode) != -1) {
// /* 22 : 불공(세금계산서) *//* 50 : 불공(신용카드) */
// $('.ExpendListERPiU.ExpendListNoTax').show();
// /* 공급가액, 부가세 비활성화 */
// $('#txtListStdAmt, #txtListTaxAmt').attr('disabled', 'disabled');
// } else {
// $('.ExpendListERPiU.ExpendListNoTax').hide();
// }
// /* 계산서인 경우 전자세금계산서여부 및 국세청 전송을 선택할 수 있도록 조치 */
// if
// ('|21|22|23|26|27|29|32|38|40|43|44|46|48|51|54|'.indexOf(callbackParam.vatTypeCode)
// != -1) {
// /* 21 : 과세(매입세금계산서) *//* 22 : 불공(세금계산서) *//* 23 : 영세(세금계산서) */
// /* 26 : 면세(계산서) *//* 27 : 의제(계산서 2/102) *//* 29 : 의제(계산서 3/103) */
// /* 32 : 의제(계산서 5/105) *//* 38 : 수입(세금계산서) *//* 40 : 의제(계산서 6/106) */
// /* 43 : 매입자발행세금계산서 *//* 44 : 재활용(계산서 6/106) *//* 46 : 재활용(계산서 10/110) */
// /* 48 : 의제(계산서 8/108) *//* 51 : 의제(계산서 4/104) *//* 54 : 재활용(계산서 9/109) */
// $('.ExpendListERPiU.ExpendListTax').show();
// // 전자세금계산서 여부 ( 기본값을 선택으로 지정 >> 사유 : 전자세금계산서를 사용할 케이스가 80% 정도라, 체크 해제가 더 적게
// 발생되기 때문)
// $('#tax1').prop('checked', true);
// // 국세청 전송 11일 이내 ( 기본값을 선택으로 지정 >> 사유 : 전자세금계산서가 기본이라서, 따라가기 위함 )
// $('#tax2').prop('checked', true);
// } else {
// $('.ExpendListERPiU.ExpendListTax').hide();
// $('#tax1').prop('checked', false);
// $('#tax2').prop('checked', false);
// }
// } else {
// $('.ExpendListERPiU.ExpendListNoTax').hide();
// $('.ExpendListERPiU.ExpendListTax').hide();
// $('#tax1').prop('checked', false);
// $('#tax2').prop('checked', false);
// }
// /* 필수값 처리 */
// fnInitListRequired();
// /* 금액 재계산 */
// fnInputAmt($('#txtListAmt').val(), '2');
// }
// }
// /* 2.2.3 문서로드 - 이벤트 바인딩 - BizboxA */
// function fnListInitEvent_BizboxA() {
// var fncName = fnGetName().name;
// /* 2.2.3.1 문서로드 - 이벤트 바인딩 - 사용자 */
// $('#btnListEmpSearch, #btnListEmpDeptSearch').click(function( event ) {
// /* - 사용자 *//* - 사용부서 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.3.2 문서로드 - 이벤트 바인딩 - 예산 */
// $('#btnListBudgetSearch').click(function( event ) {
// /* - 예산단위 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.3.3 문서로드 - 이벤트 바인딩 - 프로젝트 */
// $('#btnListProjectSearch').click(function( event ) {
// /* - 프로젝트 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.3.4 문서로드 - 이벤트 바인딩 - 거래처 */
// $('#btnListPartnerSearch').click(function( event ) {
// /* - 거래처 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.3.5 문서로드 - 이벤트 바인딩 - 카드 */
// $('#btnListCardSearch').click(function( event ) {
// /* - 카드 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// return;
// }
// /* 2.2.1.1 문서로드 - 이벤트 바인딩 - BizboxA - 사용자 */
// function fnListInitEvent_BizboxA_ListEmpSearch() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.1 문서로드 - 이벤트 바인딩 - BizboxA - 사용부서 */
// function fnListInitEvent_BizboxA_ListEmpDeptSearch() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.1 문서로드 - 이벤트 바인딩 - BizboxA - 예산단위 */
// function fnListInitEvent_BizboxA_ListBudgetSearch() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.1 문서로드 - 이벤트 바인딩 - BizboxA - 프로젝트 */
// function fnListInitEvent_BizboxA_ListProjectSearch() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.1 문서로드 - 이벤트 바인딩 - BizboxA - 거래처 */
// function fnListInitEvent_BizboxA_ListPartnerSearch() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.1.1 문서로드 - 이벤트 바인딩 - BizboxA - 카드 */
// function fnListInitEvent_BizboxA_ListCardSearch() {
// alert('서비스 준비중입니다...');
// return;
// }
// /* 2.2.2 문서로드 - 이벤트 바인딩 - iCUBE */
// function fnListInitEvent_iCUBE() {
// var fncName = fnGetName().name;
// /* 2.2.1 문서로드 - 이벤트 바인딩 - 사용자 */
// $('#btnListEmpSearch, #btnListEmpDeptSearch').click(function( event ) {
// /* - 사용자 *//* - 사용부서 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.3 문서로드 - 이벤트 바인딩 - 프로젝트 */
// $('#btnListProjectSearch').click(function( event ) {
// /* - 프로젝트 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.4 문서로드 - 이벤트 바인딩 - 거래처 */
// $('#btnListPartnerSearch').click(function( event ) {
// /* - 거래처 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.5 문서로드 - 이벤트 바인딩 - 카드 */
// $('#btnListCardSearch').click(function( event ) {
// /* - 카드 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.6 문서로드 - 이벤트 바인딩 - 불공제구분 / 사유구분 */
// $('#btnListNoTaxSearch').click(function( event ) {
// /* - 사유구분 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.7 문서로드 - 이벤트 바인딩 - 부가세 구분 */
// $("#btnListVatTypeSearch").click(function( event ) {
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// return;
// }
// /* 2.2.2.1 문서로드 - 이벤트 바인딩 - iCUBE - 사용자 */
// function fnListInitEvent_iCUBE_ListEmpSearch() {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// var partnerParam = {
// url : "<c:url value='/ex/code/org/ExEmpPopup.do'/>",
// getParam : getParam,
// title : "사용자",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodeCommonPopup('emp', '', fnGetName().name, '3', 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('useEmpInfo', callbackParam, function( value ) {
// $('#txtListEmpCode').val(value.erpEmpSeq || '');
// $('#txtListEmpName').val(value.erpEmpName || '');
// $('#txtListDeptCode').val(value.erpDeptSeq || '');
// $('#txtListDeptName').val(value.erpDeptName || '');
// $('#txtListPcCode').val(value.erpPcSeq || '');
// $('#txtListPcName').val(value.erpPcName || '');
// $('#txtListCcCode').val(value.erpCcSeq || '');
// $('#txtListCcName').val(value.erpCcName || '');
// });
// }
// return;
// }
// /* 2.2.2.2 문서로드 - 이벤트 바인딩 - iCUBE - 사용부서 */
// function fnListInitEvent_iCUBE_ListEmpDeptSearch() {
// return;
// }
// /* 2.2.2.3 문서로드 - 이벤트 바인딩 - iCUBE - 프로젝트 */
// function fnListInitEvent_iCUBE_ListProjectSearch( param, callbackParam ) {
// /* 파라미터 확인 */
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// // getParam += '&searchStr=' + $('#txtListAuthName').val();
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// var authParam = {
// url : "<c:url value='/ex/code/project/ExProjectPopup.do'/>",
// getParam : getParam,
// title : "프로잭트(iCUBE)",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(authParam);
// return;
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('projectInfo', callbackParam, function( value ) {
// $('#txtListProjectCode').val(value.projectCode || '');
// $('#txtListProjectName').val(value.projectName || '');
// });
// }
// return;
// }
// /* 2.2.2.4 문서로드 - 이벤트 바인딩 - iCUBE - 거래처 */
// function fnListInitEvent_iCUBE_ListPartnerSearch( param, callbackParam ) {
// /* 파라미터 확인 */
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// // getParam += '&searchStr=' + $('#txtListAuthName').val();
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// /* 거래처 구분 : 1.일반 / 2.수출 / 3.주민 / 4.기타 / 5.금융기관 / 6.정기예금 / 7.정기적금 / 8.카드사 /
// 9.신용카드 */
// //getParam += '&partnerType=5'
// var partnerParam = {
// url : "<c:url value='/ex/code/partner/ExPartnerPopup.do'/>",
// getParam : getParam,
// title : "거래처",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(partnerParam);
// return;
// //fnExCodeCommonPopup('project', '', fnGetName().name, '3',
// 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('partnerInfo', callbackParam, function( value ) {
// $('#txtListPartnerCode').val(value.partnerCode || '');
// $('#txtListPartnerName').val(value.partnerName || '');
// });
// }
// return;
// }
// /* 2.2.2.5 문서로드 - 이벤트 바인딩 - iCUBE - 카드 */
// function fnListInitEvent_iCUBE_ListCardSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// // getParam += '&searchStr=' + $('#txtListAuthName').val();
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// var cardParam = {
// url : "<c:url value='/ex/code/card/ExCardPopup.do'/>",
// getParam : getParam,
// title : "법인카드(iCUBE)",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(cardParam);
// return;
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('cardInfo', callbackParam, function( value ) {
// $('#txtListCardCode').val(value.cardCode || '');
// $('#txtListCardName').val(value.cardName || '');
// });
// }
// return;
// }
// /* 2.2.2.6 문서로드 - 이벤트 바인딩 - iCUBE - 사유구분 */
// function fnListInitEvent_iCUBE_ListNoTaxSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// getParam += '&searchsVatTypeCode=' + listInfo.list.vatInfo.vatCode;
// console.log(getParam);
// var cardParam = {
// url : "<c:url value='/ex/code/tax/ExVaPopup.do'/>",
// getParam : getParam,
// title : "사유구분",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(cardParam);
// return;
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// console.log(callbackParam);
// // vaTypeCode
// // vaTypeName
// var newNotaxInfo = [];
// newNotaxInfo.vaCtdCd = callbackParam.vaTypeCode;
// newNotaxInfo.vaCtdCd = callbackParam.vaTypeName;
// fnExCodeCommonBind('notaxInfo', newNotaxInfo, function( value ) {
// $('#txtListVatReasonCode').val(value.vaCtdCd || '');
// $('#txtListVatReasonName').val(value.vaCtdCd || '');
// });
// }
// return;
// }
// /* 2.2.2.7 문서로드 - 이벤트 바인딩 - iCUBE - 부가세구분 */
// function fnListInitEvent_iCUBE_ListVatTypeSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// console.log(expendInfo);
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// getParam += '&searchStr=' + '';
// var cardParam = {
// url : "<c:url value='/ex/code/tax/ExVatTypePopup.do'/>",
// getParam : getParam,
// title : "부가세구분",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(cardParam);
// return;
// } else {
// /* callback 으로 호출된 경우 */
// if ('|23|24|26|'.indexOf(callbackParam.vatTypeCode) != -1) {
// $('.ExpendListiCUBE.ExpendVatReason').removeAttr('disabled');
// $('.ExpendListiCUBE.ExpendVatReason').show();
// $('#txtListVatReasonCode').val((callbackParam.vatTypeCode || ''));
// $('#txtListVatReasonName').val((callbackParam.vatTypeName || ''));
// } else {
// $('.ExpendListiCUBE.ExpendVatReason').attr('disabled');
// $('.ExpendListiCUBE.ExpendVatReason').hide();
// $('#txtListVatReasonCode').val('');
// $('#txtListVatReasonName').val('');
// }
// var newVatInfo = [];
// newVatInfo.vatCode = callbackParam.vatTypeCode;
// newVatInfo.vatName = callbackParam.vatTypeName;
// /* 부가세구분 데이터바인딩 */
// fnExCodeCommonBind('vatInfo', newVatInfo, function( value ) {
// $('#txtListVatTypeCode').val(value.vatCode || '');
// $('#txtListVatTypeName').val(value.vatName || '');
// });
// var newNotaxInfo = [];
// newNotaxInfo.vaCtdCd = callbackParam.vatTypeCode;
// newNotaxInfo.vaCtdNm = callbackParam.vatTypeName;
// /* 사유구분 데이터바인딩 */
// fnExCodeCommonBind('notaxInfo', newNotaxInfo, function( value ) {
// $('#txtListVatTypeCode').val(value.vaCtdCd || '');
// $('#txtListVatTypeName').val(value.vaCtdNm || '');
// });
// }
// return;
// }
// /* 2.2.3 문서로드 - 이벤트 바인딩 - ERPiU */
// function fnListInitEvent_ERPiU() {
// var fncName = fnGetName().name;
// /* 2.2.1 문서로드 - 이벤트 바인딩 - 사용자 */
// $('#btnListEmpSearch, #btnListEmpDeptSearch, #btnListPcSearch,
// #btnListCcSearch').click(function( event ) {
// /* - 사용자 *//* - 사용부서 *//* - 회계단위 *//* - 코스트센터 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.2 문서로드 - 이벤트 바인딩 - 예산 */
// $('#btnListBudgetSearch, #btnListBizplanSearch,
// #btnListBgAcctSearch').click(function( event ) {
// /* - 예산단위 *//* - 사업계획 *//* - 예산계정 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.3 문서로드 - 이벤트 바인딩 - 프로젝트 */
// $('#btnListProjectSearch').click(function( event ) {
// /* - 프로젝트 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.4 문서로드 - 이벤트 바인딩 - 거래처 */
// $('#btnListPartnerSearch').click(function( event ) {
// /* - 거래처 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.5 문서로드 - 이벤트 바인딩 - 카드 */
// $('#btnListCardSearch').click(function( event ) {
// /* - 카드 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// /* 2.2.6 문서로드 - 이벤트 바인딩 - 불공제구분 / 사유구분 */
// $('#btnListNoTaxSearch').click(function( event ) {
// /* - 불공제구분 */
// var eventType = event.target.id.replace('btn', '');
// if (window[fncName + '_' + eventType]) {
// window[fncName + '_' + eventType]();
// }
// });
// return;
// }
// /* 2.2.3.1 문서로드 - 이벤트 바인딩 - ERPiU - 사용자 */
// function fnListInitEvent_ERPiU_ListEmpSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('emp', '', fnGetName().name, '3', 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('useEmpInfo', callbackParam, function( value ) {
// $('#txtListEmpCode').val(value.erpEmpSeq || '');
// $('#txtListEmpName').val(value.erpEmpName || '');
// $('#txtListDeptCode').val(value.erpDeptSeq || '');
// $('#txtListDeptName').val(value.erpDeptName || '');
// $('#txtListPcCode').val(value.erpPcSeq || '');
// $('#txtListPcName').val(value.erpPcName || '');
// $('#txtListCcCode').val(value.erpCcSeq || '');
// $('#txtListCcName').val(value.erpCcName || '');
// });
// }
// }
// /* 2.2.3.3 문서로드 - 이벤트 바인딩 - ERPiU - 회계단위 */
// function fnListInitEvent_ERPiU_ListPcSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('pc', '', fnGetName().name, '3', 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('useEmpInfo', callbackParam, function( value ) {
// $('#txtListPcCode').val(value.erpPcSeq || '');
// $('#txtListPcName').val(value.erpPcName || '');
// });
// }
// return;
// }
// /* 2.2.3.4 문서로드 - 이벤트 바인딩 - ERPiU - 코스트센터 */
// function fnListInitEvent_ERPiU_ListCcSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('cc', '', fnGetName().name, '3', 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('useEmpInfo', callbackParam, function( value ) {
// $('#txtListCcCode').val(value.erpCcSeq || '');
// $('#txtListCcName').val(value.erpCcName || '');
// });
// }
// return;
// }
// /* 2.2.3.5 문서로드 - 이벤트 바인딩 - ERPiU - 예산단위 */
// function fnListInitEvent_ERPiU_ListBudgetSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('budget', '', fnGetName().name, '3', 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('budgetInfo', callbackParam, function( value ) {
// $('#txtListBudgetCode').val(value.budgetCode || '');
// $('#txtListBudgetName').val(value.budgetName || '');
// });
// }
// return;
// }
// /* 2.2.3.6 문서로드 - 이벤트 바인딩 - ERPiU - 사업계획 */
// function fnListInitEvent_ERPiU_ListBizplanSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// /* 예산단위 정보가 있어야만, 사업계획 조회가 가능함 */
// if (Object.keys(listInfo.list.budgetInfo).length == 0) {
// alert('예산단위가 선택되지 않았습니다.');
// return;
// }
// if (listInfo.list.budgetInfo.budgetCode == '') {
// alert('예산단위가 선택되지 않았습니다.');
// return;
// }
// var addGetParam = '&erpBudgetCode=' + listInfo.list.budgetInfo.budgetCode;
// fnExCodeCommonPopup('bizplan', addGetParam, fnGetName().name, '3',
// 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('budgetInfo', callbackParam, function( value ) {
// $('#txtListBizplanCode').val(value.bizplanCode || '');
// $('#txtListBizplanName').val(value.bizplanName || '');
// });
// }
// return;
// }
// /* 2.2.3.7 문서로드 - 이벤트 바인딩 - ERPiU - 예산계정 */
// function fnListInitEvent_ERPiU_ListBgAcctSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// /* 예산단위 정보가 있어야만, 사업계획 조회가 가능함 */
// if (Object.keys(listInfo.list.budgetInfo).length == 0) {
// alert('예산단위가 선택되지 않았습니다.');
// return;
// }
// if (listInfo.list.budgetInfo.budgetCode == '') {
// alert('예산단위가 선택되지 않았습니다.');
// return;
// }
// var addGetParam = '&erpBudgetCode=' + listInfo.list.budgetInfo.budgetCode;
// fnExCodeCommonPopup('bgacct', addGetParam, fnGetName().name, '3',
// 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('budgetInfo', callbackParam, function( value ) {
// $('#txtListBgAcctCode').val(value.bgAcctCode || '');
// $('#txtListBgAcctName').val(value.bgAcctName || '');
// });
// }
// return;
// }
// /* 2.2.3.8 문서로드 - 이벤트 바인딩 - ERPiU - 프로젝트 */
// function fnListInitEvent_ERPiU_ListProjectSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var getParam = 'callBack=' + fnGetName().name;
// getParam += '&formSeq=' + expendInfo.form.formSeq;
// // getParam += '&searchStr=' + $('#txtListAuthName').val();
// getParam += '&searchStr=';
// getParam += '&searchCompSeq=' + expendInfo.empInfo.compSeq;
// getParam += '&erpCompSeq=' + expendInfo.empInfo.erpCompSeq;
// getParam += '&erpEmpSeq=' + expendInfo.empInfo.erpEmpSeq;
// var projectParam = {
// url : "<c:url value='/ex/code/project/ExProjectPopup.do'/>",
// getParam : getParam,
// title : "프로젝트",
// opener : "3",
// parentId : "layerExpendList"
// };
// fnExCodePopup(projectParam);
// return;
// //fnExCodeCommonPopup('project', '', fnGetName().name, '3',
// 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('projectInfo', callbackParam, function( value ) {
// $('#txtListProjectCode').val(value.projectCode || '');
// $('#txtListProjectName').val(value.projectName || '');
// });
// }
// return;
// }
// /* 2.2.3.9 문서로드 - 이벤트 바인딩 - ERPiU - 거래처 */
// function fnListInitEvent_ERPiU_ListPartnerSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// var addGetParam = '&partnerType=';
// fnExCodeCommonPopup('partner', '', fnGetName().name, '3', 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('partnerInfo', callbackParam, function( value ) {
// $('#txtListPartnerCode').val(value.partnerCode || '');
// $('#txtListPartnerName').val(value.partnerName || '');
// });
// }
// return;
// }
// /* 2.2.3.10 문서로드 - 이벤트 바인딩 - ERPiU - 카드 */
// function fnListInitEvent_ERPiU_ListCardSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('card', '', fnGetName().name, '3', 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('cardInfo', callbackParam, function( value ) {
// $('#txtListCardCode').val(value.cardCode || '');
// $('#txtListCardName').val(value.cardName || '');
// });
// }
// return;
// }
// /* 2.2.3.11 문서로드 - 이벤트 바인딩 - ERPiU - 불공제구분 */
// function fnListInitEvent_ERPiU_ListNoTaxSearch( param, callbackParam ) {
// callbackParam = (callbackParam || '');
// if (callbackParam == '') {
// fnExCodeCommonPopup('notax', '', fnGetName().name, '3', 'layerExpendList');
// } else {
// /* callback 으로 호출된 경우 */
// /* 데이터바인딩 */
// fnExCodeCommonBind('notaxInfo', callbackParam, function( value ) {
// $('#txtListNoTaxCode').val(value.noTaxCode || '');
// $('#txtListNoTaxName').val(value.noTaxName || '');
// });
// }
// }
// /* 2.3 문서로드 - 초기화 - 문서 레이아웃 설정 */
// function fnExpendSetListLayout() {
// /* 공통처리 */
// $('.ExpendListBizboxA, .ExpendListiCUBE, .ExpendListERPiU').hide();
// /* 필수값 표현 처리 */
// fnInitListRequired();
// /* 연동시스템별 처리 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// if (window[fnGetName().name + '_' + info.ifSystem]) {
// window[fnGetName().name + '_' + info.ifSystem]();
// }
// return;
// }
// /* 2.3.1 문서로드 - 초기화 - 문서 레이아웃 설정 - BizboxA */
// function fnExpendSetListLayout_BizboxA() {
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// $.each(info.option, function( idx, option ) {
// if (option.optionGbn == '001' && option.optionCode == '001002') {
// /* [레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 ) */
// if (option.value.indexOf('L') > -1) {
// /* 사용자 정뵤 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListEmp').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001003') {
// /* [레이아웃] 예산정보 입력 설정 ( 예산단위, 사업계획, 예산계정 ) */
// if (option.value.indexOf('L') > -1) {
// /* 예산 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListBudget').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001004') {
// /* [레이아웃] 프로젝트정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 프로젝트 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListProject').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001005') {
// /* [레이아웃] 거래처정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 거래처 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListPartner').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001006') {
// /* [레이아웃] 카드정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 카드 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListCard').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001007') {
// /* [레이아웃] 기본입력 적요 설정 */
// if (option.value.indexOf('Y') > -1) {
// /* 기본적요 입력 표현 */
// // $('.Expend' + expendInfo.ifSystem + '.ExpendBaseNote').show();
// $('#txtListNote').val($('#txtExpendBaseNote').val());
// }
// }
// });
// return;
// }
// /* 2.3.2 문서로드 - 초기화 - 문서 레이아웃 설정 - iCUBE */
// function fnExpendSetListLayout_iCUBE() {
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// /***********************아이큐브 미사용(세액,과세표준액)********************************/
// $("#thListSubTaxAmt").css('display', 'none');
// $("#thListSubStdAmt").css('display', 'none');
// $("#tdListSubTaxAmt").css('display', 'none');
// $("#tdListSubStdAmt").css('display', 'none');
// /**************************************************************************/
// $.each(info.option, function( idx, option ) {
// if (option.optionGbn == '001' && option.optionCode == '001002') {
// /* [레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 ) */
// if (option.value.indexOf('L') > -1) {
// /* 사용자 정뵤 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListEmp').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001003') {
// /* [레이아웃] 예산정보 입력 설정 ( 예산단위, 사업계획, 예산계정 ) */
// if (option.value.indexOf('L') > -1) {
// /* 예산 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListBudget').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001004') {
// /* [레이아웃] 프로젝트정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 프로젝트 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListProject').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001005') {
// /* [레이아웃] 거래처정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 거래처 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListPartner').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001006') {
// /* [레이아웃] 카드정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 카드 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListCard').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001007') {
// /* [레이아웃] 기본입력 적요 설정 */
// if (option.value.indexOf('Y') > -1) {
// /* 기본적요 입력 표현 */
// // $('.Expend' + expendInfo.ifSystem + '.ExpendBaseNote').show();
// $('#txtListNote').val($('#txtExpendBaseNote').val());
// }
// }
// });
// return;
// }
// /* 2.3.3 문서로드 - 초기화 - 문서 레이아웃 설정 - ERPiU */
// function fnExpendSetListLayout_ERPiU() {
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// $.each(info.option, function( idx, option ) {
// if (option.optionGbn == '001' && option.optionCode == '001002') {
// /* [레이아웃] 사용자정보 입력 설정 ( 사용자, 사용부서 ) */
// if (option.value.indexOf('L') > -1) {
// /* 사용자 정뵤 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListEmp').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001003') {
// /* [레이아웃] 예산정보 입력 설정 ( 예산단위, 사업계획, 예산계정 ) */
// if (option.value.indexOf('L') > -1) {
// /* 예산 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListBudget').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001004') {
// /* [레이아웃] 프로젝트정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 프로젝트 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListProject').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001005') {
// /* [레이아웃] 거래처정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 거래처 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListPartner').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001006') {
// /* [레이아웃] 카드정보 입력 설정 */
// if (option.value.indexOf('L') > -1) {
// /* 카드 정보 입력 표현 */
// $('.ExpendList' + info.ifSystem + '.ExpendListCard').show();
// }
// } else if (option.optionGbn == '001' && option.optionCode == '001007') {
// /* [레이아웃] 기본입력 적요 설정 */
// if (option.value.indexOf('Y') > -1) {
// /* 기본적요 입력 표현 */
// // $('.Expend' + expendInfo.ifSystem + '.ExpendBaseNote').show();
// $('#txtListNote').val($('#txtExpendBaseNote').val());
// }
// }
// });
// return;
// }
// /* 3. 필수값 설정 */
// function fnInitListRequired() {
// /* 증빙유형에 따른 필수값 처리 */
// if (listInfo && listInfo.list.authInfo) {
// /* 증빙일자 필수입력 여부 */
// if (listInfo.list.authInfo.authDateReqYN == 'Y') {
// $('#reqAuthDate').css('display', '');
// } else {
// $('#reqAuthDate').css('display', 'none');
// }
// /* 적요 필수입력 여부 */
// if (listInfo.list.authInfo.noteReqYN == 'Y') {
// $('#reqNote').css('display', '');
// } else {
// $('#reqNote').css('display', 'none');
// }
// /* 프로젝트 필수입력 여부 */
// if (listInfo.list.authInfo.projectReqYN == 'Y') {
// $('#reqProject').css('display', '');
// } else {
// $('#reqProject').css('display', 'none');
// }
// /* 거래처 필수입력 여부 */
// if (listInfo.list.authInfo.partnerReqYN == 'Y') {
// $('#reqPartner').css('display', '');
// } else {
// $('#reqPartner').css('display', 'none');
// }
// /* 카드 필수입력 여부 */
// if (listInfo.list.authInfo.cardReqYN == 'Y') {
// $('#reqCard').css('display', '');
// } else {
// $('#reqCard').css('display', 'none');
// }
// } else {
// $('#reqAuthDate').css('display', 'none');
// $('#reqNote').css('display', 'none');
// $('#reqProject').css('display', 'none');
// $('#reqPartner').css('display', 'none');
// $('#reqCard').css('display', 'none');
// }
// /* 연동시스템별 처리 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// if (window[fnGetName().name + '_' + info.ifSystem]) {
// (window[fnGetName().name + '_' + info.ifSystem]());
// }
// }
// /* 3.1 필수값 설정 - BizboxA */
// /* 3.2 필수값 설정 - iCUBE */
// function fnInitListRequired_iCUBE() {
// /* 부가세구분 처리 */
// if ($('.ExpendListiCUBE.ExpendVatType').attr('display') != 'none') {
// $('#reqNoTax').css('display', '');
// } else {
// $('#reqNoTax').css('display', '');
// }
// /* 사유구분구분 처리 */
// if ($('.ExpendListiCUBE.ExpendVatReason').attr('display') != 'none') {
// $('#reqNoTax').css('display', '');
// } else {
// $('#reqNoTax').css('display', '');
// }
// }
// /* 3.3 필수값 설정 - ERPiU */
// function fnInitListRequired_ERPiU() {
// /* 불공제구분 처리 */
// if ($('.ExpendList.ExpendListNoTax').attr('display') != 'none') {
// $('#reqNoTax').css('display', '');
// } else {
// $('#reqNoTax').css('display', '');
// }
// }
// /* 4. 저장 */
// function fnListSave() {
// /* 필수값 체크 */
// if (!fnListSaveComfirm()) { return; }
// /* 공급가액 / 부가세액 / 공급대가 확인 */
// if ($('#txtListAmt').val() == '' || $('#txtListAmt').val() == '0') {
// if (!confirm('금액이 "0" 원으로 입력되었습니다. 계속진행할까요?')) { return; }
// }
// /* 연동시스템별 처리 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// /* 파라미터 추가 정의 */
// /* 지출결의 아이디 */
// listInfo.expendSeq = info.expend.header.expendSeq;
// /* 적요 */
// listInfo.note = ($('#txtListNote').val() || '');
// /* 증빙일자 */
// listInfo.authDate = ($('#txtListAuthDate').val() || '').replace(/-/g, '');
// /* 공급가액 */
// listInfo.stdAmt = ($('#txtListStdAmt').val() || 0);
// /* 부가세액 */
// listInfo.taxAmt = ($('#txtListTaxAmt').val() || 0);
// /* 공급대가 */
// listInfo.amt = ($('#txtListAmt').val() || 0);
// if (window[fnGetName().name + '_' + info.ifSystem]) {
// (window[fnGetName().name + '_' + info.ifSystem]());
// }
// }
// /* 4.1 필수값 확인 */
// function fnListSaveComfirm() {
// /* 테스트용 //////////////////////////////////////////////////////////////-*/
// if (testType == 'test') {
// if (!listInfo || !listInfo.list.summaryInfo ||
// !listInfo.list.summaryInfo.summaryCode) {
// alert('표준적요가 입력되지 않았습니다.');
// return false;
// }
// /* 증빙유형 : 필수확인 */
// if (!listInfo || !listInfo.list.authInfo || !listInfo.list.authInfo.authCode)
// {
// alert('증빙유형이 입력되지 않았습니다.');
// return false;
// }
// return true;
// }
// /* ////////////////////////////////////////////////////////////////////*/
// /* 공통사항 */
// /* 표준적요 : 필수확인 */
// if (!listInfo || !listInfo.list.summaryInfo ||
// !listInfo.list.summaryInfo.summaryCode) {
// alert('표준적요가 입력되지 않았습니다.');
// return false;
// }
// /* 증빙유형 : 필수확인 */
// if (!listInfo || !listInfo.list.authInfo || !listInfo.list.authInfo.authCode)
// {
// alert('증빙유형이 입력되지 않았습니다.');
// return false;
// }
// /* 적요 : 옵션에 따른 필수 확인 / 증빙유형 정보에 필수 여부가 있으나, 위에서 먼저 증빙유형을 체크 하기 때문에 옵션 바로 체크
// 진행 */
// if (listInfo.list.authInfo.noteReqYN == 'Y' && (!listInfo || !listInfo.note))
// {
// alert('적요가 입력되지 않았습니다.');
// return false;
// }
// /* 증빙일자 : 옵션에 따른 필수 확인 */
// if (listInfo.list.authInfo.authDateReqYN == 'Y' && (!listInfo ||
// !listInfo.authDate)) {
// alert('증빙일자가 입력되지 않았습니다.');
// return false;
// }
// /* 프로젝트 : 옵션에 따른 필수 확인 */
// if (listInfo.list.authInfo.projectReqYN == 'Y' && (!listInfo ||
// !listInfo.project || !listInfo.project.projectCode)) {
// alert('증빙일자가 입력되지 않았습니다.');
// return false;
// }
// /* 거래처 : 옵션에 따른 필수 확인 */
// if (listInfo.list.authInfo.partnerReqYN == 'Y' && (!listInfo ||
// !listInfo.partner || !listInfo.partner.partnerCode)) {
// alert('증빙일자가 입력되지 않았습니다.');
// return false;
// }
// /* 카드 : 옵션에 따른 필수 확인 */
// if (listInfo.list.authInfo.cardReqYN == 'Y' && (!listInfo || !listInfo.card
// || !listInfo.card.cardCode)) {
// alert('증빙일자가 입력되지 않았습니다.');
// return false;
// }
// /* 연동시스템별 처리 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// if (window[fnGetName().name + '_' + info.ifSystem]) {
// return (window[fnGetName().name + '_' + info.ifSystem]());
// } else {
// return true;
// }
// }
// /* 4.1.1 저장 - 필수값 확인 - BizboxA */
// function fnListSaveComfirm_BizboxA() {
// return true;
// }
// /* 4.1.2 저장 - 필수값 확인 - iCUBE */
// function fnListSaveComfirm_iCUBE() {
// /* 부가세구분, 사유구분 추가 */
// /* 부가세구분 처리 */
// if ($('.ExpendListiCUBE.ExpendVatType').attr('display') != 'none' &&
// !listInfo || !listInfo.list.authInfo || !listInfo.list.authInfo.vatTypeCode)
// {
// alert('부가세구분을 입력하지 않았습니다.');
// return false;
// }
// /* 사유구분구분 처리 */
// if ($('.ExpendListiCUBE.ExpendVatReason').attr('display') != 'none' &&
// !listInfo || !listInfo.list.authInfo || !listInfo.list.authInfo.vaCtdCode) {
// alert('사유구분을 입력하지 않았습니다.');
// return false;
// }
// return true;
// }
// /* 4.1.3 저장 - 필수값 확인 - ERPiU */
// function fnListSaveComfirm_ERPiU() {
// /* 에산단위 */
// /* 사업계획 */
// /* 예산계정 */
// /* 불공제구분 */
// return true;
// }
// /* 4.2 저장 - BizboxA */
// function fnListSave_BizboxA() {
// listInfo.listType = 'BizboxA';
// return;
// }
// /* 4.3 저장 - iCUBE */
// function fnListSave_iCUBE() {
// listInfo.listType = 'iCUBE';
// /* 부모변수 정보 확인 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// /* 변수정의 */
// if (listInfo.listSeq > 0) {
// /* 업데이트 */
// var url = '<c:url value="/ex/expend/list/ExExpendListInfoUpdate.do" />';
// } else {
// /* 신규생성 */
// var url = '<c:url value="/ex/expend/list/ExExpendListInfoInsert.do" />';
// }
// var ajaxParam = {};
// /* 하위코드 정보 */
// ajaxParam.summaryInfo = JSON.stringify(getInfo('summaryInfo'));
// ajaxParam.authInfo = JSON.stringify(getInfo('authInfo'));
// ajaxParam.noTaxInfo = JSON.stringify(getInfo('notaxInfo'))
// ajaxParam.creEmpInfo = JSON.stringify(getInfo('creEmpInfo'));
// ajaxParam.useEmpInfo = JSON.stringify(getInfo('useEmpInfo'));
// ajaxParam.budgetInfo = JSON.stringify(getInfo('budgetInfo'));
// ajaxParam.projectInfo = JSON.stringify(getInfo('projectInfo'));
// ajaxParam.partnerInfo = JSON.stringify(getInfo('partnerInfo'));
// ajaxParam.cardInfo = JSON.stringify(getInfo('cardInfo'));
// /**************** 부가세 데이터 생성 시작 *****************/
// var vatTaxInfo = {};
// vatTaxInfo.ex_gb = 'list';
// vatTaxInfo.ex_vat_seq = '';
// vatTaxInfo.vat_type_code = listInfo.list.vatInfo.vatCode;
// vatTaxInfo.vat_type_name = listInfo.list.vatInfo.vatName;
// vatTaxInfo.va_type_code = listInfo.list.notaxInfo.vaCtdCd;
// vatTaxInfo.va_type_name = listInfo.list.notaxInfo.vaCtdNm;
// vatTaxInfo.mutual_code = listInfo.list.notaxInfo.vaCtdCd;
// vatTaxInfo.mutual_name = listInfo.list.notaxInfo.vaCtdNm;
// vatTaxInfo.iis_yn = '';
// vatTaxInfo.jeonjasend_yn = '';
// vatTaxInfo.tex_md = '';
// vatTaxInfo.item_name = '';
// vatTaxInfo.size_name = '';
// vatTaxInfo.tax_qt = '0.00';
// vatTaxInfo.prc_am = '0.00';
// vatTaxInfo.supply_am = ($('#txtListSubStdAmt').val() || '0').replace(/,/g,
// '');
// vatTaxInfo.tax_am = ($('#txtListSubTaxAmt').val() || '0').replace(/,/g, '');
// vatTaxInfo.create_user_seq = '';
// vatTaxInfo.create_date = '';
// vatTaxInfo.modify_user_seq = '';
// vatTaxInfo.modify_date = '';
// console.log("vatTaxInfo:" + JSON.stringify(vatTaxInfo));
// /****************** 부가세 데이터 생성 끝 ******************/
// ajaxParam.vatInfo = JSON.stringify(vatTaxInfo);
// /* 고정값 정보 */
// ajaxParam.expendSeq = listInfo.expendSeq;
// ajaxParam.listSeq = listInfo.listSeq;
// ajaxParam.jeonjaSendYN = '';
// ajaxParam.issYN = '';
// ajaxParam.authDate = ($('#txtListAuthDate').val() || '').replace(/-/g, '');
// ajaxParam.amt = ($('#txtListAmt').val() || '0').replace(/,/g, '');
// ajaxParam.stdAmt = ($('#txtListStdAmt').val() || '0').replace(/,/g, '');
// ajaxParam.taxAmt = ($('#txtListTaxAmt').val() || '0').replace(/,/g, '');
// ajaxParam.subStdAmt = ($('#txtListSubStdAmt').val() || '0').replace(/,/g,
// '');
// ajaxParam.subTaxAmt = ($('#txtListSubTaxAmt').val() || '0').replace(/,/g,
// '');
// ajaxParam.formSeq = expendInfo.form.formSeq;
// console.log(ajaxParam);
// $.ajax({
// type : 'post',
// url : url,
// datatype : 'json',
// async : false,
// data : {
// listInfo : JSON.stringify(ajaxParam)
// },
// success : function( data ) {
// console.log("리스트 리턴데이터:" + JSON.stringify(data));
// if (data.aaData) {
// listInfo.listSeq = data.aaData.listSeq;/* 항목 아이디 정의 */
// listInfo.list.useEmpInfo.seq = data.aaData.empSeq;/* 사용자 아이디 정의 */
// listInfo.list.budgetInfo.seq = data.aaData.budgetSeq;/* 예산 아이디 정의 */
// listInfo.list.projectInfo.seq = data.aaData.projectSeq;/* 프로젝트 아이디 정의 */
// listInfo.list.partnerInfo.seq = data.aaData.partnerSeq;/* 거래처 아이디 정의 */
// listInfo.list.cardInfo.seq = data.aaData.cardSeq;/* 카드 아이디 정의 */
// listInfo.list.summaryInfo.seq = data.aaData.summarySeq;/* 표준적요 아이디 정의 */
// listInfo.list.authInfo.seq = data.aaData.authSeq;/* 증빙유형 아이디 정의 */
// listInfo.list.notaxInfo.seq = data.aaData.vatSeq;/* 부가세 아이디 정의 */
// listInfo.stdAmt = data.aaData.stdAmt; /* 공급가액 */
// listInfo.subStdAmt = data.aaData.subStdAmt; /* 과세표준액 */
// listInfo.taxAmt = data.aaData.taxAmt; /* 부가세 */
// listInfo.subTaxAmt = data.aaData.subTaxAmt; /* 세액 */
// listInfo.amt = data.aaData.amt; /* 공급대가 */
// expendInfo['list']['info'][data.aaData.listSeq] = listInfo;
// alert('저장되었습니다.');
// fnSetExpendGridBind_List(data.aaData);
// fnLayerPopClose();
// }
// },
// error : function( data ) {
// console.log(' -_- ? Error ! >>>> ' + JSON.stringify(data));
// }
// });
// return;
// }
// /* 4.4 저장 - ERPiU */
// function fnListSave_ERPiU() {
// /* 부모변수 정보 확인 */
// var info;
// if (expendInfo) {
// /* 팝업으로 처리되므로, 변수 확인 */
// info = expendInfo;
// } else if (parent.expendInfo) {
// /* 팝업으로 처리되므로, 부모의 변수 확인 */
// info = parent.expendInfo;
// }
// /* 변수정의 */
// if (listInfo.listSeq > 0) {
// /* 업데이트 */
// var url = '<c:url value="/ex/expend/list/ExExpendListInfoUpdate.do" />';
// } else {
// /* 신규생성 */
// var url = '<c:url value="/ex/expend/list/ExExpendListInfoInsert.do" />';
// }
// var ajaxParam = {};
// /* 하위코드 정보 */
// ajaxParam.summaryInfo = JSON.stringify(getInfo('summaryInfo'));
// ajaxParam.authInfo = JSON.stringify(getInfo('authInfo'));
// ajaxParam.noTaxInfo = JSON.stringify(getInfo('notaxInfo'));
// ajaxParam.creEmpInfo = JSON.stringify(getInfo('creEmpInfo'));
// ajaxParam.useEmpInfo = JSON.stringify(getInfo('useEmpInfo'));
// ajaxParam.budgetInfo = JSON.stringify(getInfo('budgetInfo'));
// ajaxParam.projectInfo = JSON.stringify(getInfo('projectInfo'));
// ajaxParam.partnerInfo = JSON.stringify(getInfo('partnerInfo'));
// ajaxParam.cardInfo = JSON.stringify(getInfo('cardInfo'));
// /* 고정값 정보 */
// ajaxParam.expendSeq = listInfo.expendSeq;
// ajaxParam.listSeq = listInfo.listSeq;
// ajaxParam.jeonjaSend11YN = '';
// ajaxParam.issYN = '';
// ajaxParam.authDate = ($('#txtListAuthDate').val() || '').replace(/-/g, '');
// ajaxParam.amt = ($('#txtListAmt').val() || '0').replace(/,/g, '');
// ajaxParam.stdAmt = ($('#txtListStdAmt').val() || '0').replace(/,/g, '');
// ajaxParam.taxAmt = ($('#txtListTaxAmt').val() || '0').replace(/,/g, '');
// ajaxParam.subStdAmt = ($('#txtListSubStdAmt').val() || '0').replace(/,/g,
// '');
// ajaxParam.subTaxAmt = ($('#txtListSubTaxAmt').val() || '0').replace(/,/g,
// '');
// $.ajax({
// type : 'post',
// url : url,
// datatype : 'json',
// async : false,
// data : {
// listInfo : JSON.stringify(ajaxParam)
// },
// success : function( data ) {
// if (data.aaData) {
// listInfo.listSeq = data.aaData.listSeq;/* 항목 아이디 정의 */
// listInfo.list.useEmpInfo.seq = data.aaData.empSeq;/* 사용자 아이디 정의 */
// listInfo.list.budgetInfo.seq = data.aaData.budgetSeq;/* 예산 아이디 정의 */
// listInfo.list.projectInfo.seq = data.aaData.projectSeq;/* 프로젝트 아이디 정의 */
// listInfo.list.partnerInfo.seq = data.aaData.partnerSeq;/* 거래처 아이디 정의 */
// listInfo.list.cardInfo.seq = data.aaData.cardSeq;/* 카드 아이디 정의 */
// listInfo.list.summaryInfo.seq = data.aaData.summarySeq;/* 표준적요 아이디 정의 */
// listInfo.list.authInfo.seq = data.aaData.authSeq;/* 증빙유형 아이디 정의 */
// listInfo.list.notaxInfo.seq = data.aaData.vatSeq;/* 부가세 아이디 정의 */
// listInfo.stdAmt = data.aaData.stdAmt; /* 공급가액 */
// listInfo.subStdAmt = data.aaData.subStdAmt; /* 과세표준액 */
// listInfo.taxAmt = data.aaData.taxAmt; /* 부가세 */
// listInfo.subTaxAmt = data.aaData.subTaxAmt; /* 세액 */
// listInfo.amt = data.aaData.amt; /* 공급대가 */
// expendInfo['list']['info'][data.aaData.listSeq] = listInfo;
// alert('저장되었습니다.');
// fnSetExpendGridBind_List(data.aaData);
// fnLayerPopClose();
// }
// },
// error : function( data ) {
// console.log(' -_- ? Error ! >>>> ' + JSON.stringify(data));
// }
// });
// return;
// }
