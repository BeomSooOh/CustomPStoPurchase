/*문서로드*/
$(document).ready(function() {
    /* 초기화 */
    fnExCodeInit();
    /* 이벤트 바인딩 */
    fnExCodeEventInit();
    /* 최초검색 수행 */
    /* 최초검색 수정 정의 : btn + codeType + Search 를 id 로 부여하면, 페이지 로드시 클릭 이벤트를 발생한다. */
    if ($('#btn' + codeType + 'Search')) {
        $('#btn' + codeType + 'Search').click();
    }
    return;
})

/* 초기화 */
function fnExCodeInit() {
    /* 기본버튼 적용 */
    $(".controll_btn button").kendoButton();
    /* 기본 검색어 적용 */
    if ($('#txt' + codeType + 'SearchStr')) {
        if (paramSearchStr) {
            $('#txt' + codeType + 'SearchStr').val(paramSearchStr);
        }
    }
    /* 페이지별 초기화 */
    if (window['fnExCode' + codeType + 'PopInit']) {
        window['fnExCode' + codeType + 'PopInit']();
    }
}

/* 이벤트 바인딩 */
function fnExCodeEventInit() {
    /* 검색어 엔터이벤트 적용 */
    if ($('#txt' + codeType + 'SearchStr')) {
        $('#txt' + codeType + 'SearchStr').bind({
            keyup : function( event ) {
                if (event.keyCode == 13) {
                    if ($('#btn' + codeType + 'Search')) {
                        $('#btn' + codeType + 'Search').click();
                    }
                }
            }
        });
    }
    /* 버튼 이벤트 적용 */
    $('input[type=button]').click(function( event ) {
        var btnId = $(this).attr('id') + '';
        btnId = btnId.replace('btn', '');
        if (window['fnExCode' + codeType + 'EventButton_' + btnId]) {
            window['fnExCode' + codeType + 'EventButton_' + btnId](event);
        }
    });
    $("button").click(function( event ) {
        var btnId = $(this).attr('id');
        btnId = btnId.replace('btn');
        if (window['fnExCode' + codeType + 'EventButton_' + btnId]) {
            window['fnExCode' + codeType + 'EventButton_' + btnId](event);
        }
    });
    /* 페이지별 이벤트 바인딩 */
    if (window['fnExCode' + codeType + 'PopInitEvent']) {
        window['fnExCode' + codeType + 'PopInitEvent']();
    }
    return;
}

/* 테이블 정의 */
function fnExCodeTableInit( param ) {
    /* 파라미터 체크 */
    if (!param) {
        console.log('param 이 전달되지 않았습니다.');
        alert("param" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    /* 파라미터 체크 - target */
    if (!param.target) {
        console.log('param.target 이 전달되지 않았습니다.');
        alert("param.target" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    if (!param.columnDefs) {
        console.log('param.columnsDef 이 전달되지 않았습니다.');
        alert("param.columnsDef" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    if (!param.columns) {
        console.log('param.columns 이 전달되지 않았습니다.');
        alert("param.columns" + NeosUtil.getMessage("", " 이 전달되지 않았습니다."));
        return;
    }
    $('#' + param.target).dataTable({
        "fixedHeader" : true,
        "select" : true,
        "pageLength" : 10,
        "sScrollY" : param.scrollY,
        "bAutoWidth" : false,
        "destroy" : true,
        "language" : {
            "lengthMenu" : "보기 _MENU_",
            "zeroRecords" : NeosUtil.getMessage("TX000009638", "데이터가 없습니다"),
            "info" : "_PAGE_ / _PAGES_",
            "infoEmpty" : NeosUtil.getMessage("TX000009638", "데이터가 없습니다"),
            "infoFiltered" : "(전체 _MAX_ 중.)"
        },
        "data" : param.data,
        "fnRowCallback" : param.rowCallback,
        "columnDefs" : param.columnDefs,
        "aoColumns" : param.columns
    });
    /*
     * var oTable = $('#' + param.target).DataTable(); if ($('#txt' + codeType +
     * 'SearchStr')) { $('#txt' + codeType + 'SearchStr').on('keyup change',
     * function() { oTable.columns(1).search(this.value).draw(); });
     * 
     * $('#txtSearchStr').focus(); }
     */
    return;
}

/* 레이어 종료 */
function fnLayerPopClose() {
    if ($(".pop_wrap_dir").length > 1) {
        layerPopClose('layerCommonCode');
    } else {
        layerPopClose('');
    }
    return;
}