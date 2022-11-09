<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>
<%-- <script type="text/javascript" src='<c:url value="/js/ex/ExCodePop.js"></c:url>'></script> --%>
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<script>
    /* 변수정의 */
    var baseUrl = '<c:url value="/" />';
    var expendInfo = {
//         ifSystem : 'BizboxA', /* 선택된 회사가 연동중인 시스템 구분 값 ( BizboxA / iCUBE / ERPiU ) */
		ifSystem : '${ViewBag.ifSystem}',
        expend : {
            useEmpInfo : {
                erpCompSeq : "",
                erpEmpSeq : ""
            }
        }
    };
    var searchCompSeq = ''; /* 검색대상 회사 */

    /* 문서로드 */
    $(document).ready(function() {
        fnConfigAuthInit();
        fnConfigAuthInitEvent();
        $('#btnConfigAuthSearch').click();
        return;
    })
    /*-------------------------------------------------------------------------*/
    /* 초기화 */
    /*-------------------------------------------------------------------------*/
    /* 초기화  */
    function fnConfigAuthInit() {
        $(".controll_btn button").kendoButton(); /* 켄도버튼 정의 */
        fnConfigAuthLayoutInit(); /* 레이아웃 변경 */
        fnConfigAuthSetComboBox(); /* Combobox 바인딩 */
        return;
    }
    /*-------------------------------------------------------------------------*/
    /* 레이아웃 변경 */
    /*-------------------------------------------------------------------------*/
    /* 레이아웃 변경 */
    function fnConfigAuthLayoutInit() {
        // 연동되는 시스템에 따라서, 표현되어야 할 부분과, 표현되지 않아야 할 부분을 처리한다.
        /* 공통사항 */
        var param = {};
        /* 연동시스템별 처리 */
        if (window[fnGetName().name + '_' + expendInfo.ifSystem]) {
            window[fnGetName().name + '_' + expendInfo.ifSystem](param);
        }
        return;
    }
    /* BizboxA */
    function fnConfigAuthLayoutInit_BizboxA( param ) {
        return;
    }
    /* iCUBE */
    function fnConfigAuthLayoutInit_iCUBE( param ) {
        return;
    }
    /* ERPiU */
    function fnConfigAuthLayoutInit_ERPiU( param ) {
        return;
    }
    /*-------------------------------------------------------------------------*/
    /* Combobox 바인딩 */
    /*-------------------------------------------------------------------------*/
    /* Combobox 바인딩 */
    function fnConfigAuthSetComboBox() {
        // 콤보박스에 기본적인 데이터를 반영하며, 기본값을 지정한다.
//         setComboBox($("#selConfigAuthCompany"), JSON.parse('${ViewBag.compListInfo}'), function( event ) {
//             fnConfigAuthSetComboBox_Change();
//         });/* 회사 설정 */
        
        setComboBox($("#selConfigAuthCashType"), JSON.parse('${ViewBag.commonCodeListYesOrNo}'), function( event ) {
            fnConfigAuthSetComboBox_Change();
        }); /* 현금영수증구분 설정 */
        var cashType = $('#selConfigAuthCashType').data('kendoComboBox'); /* 현금영수증구분 */
        cashType.value('N');
        setComboBox($("#selConfigAuthUseYN"), JSON.parse('${ViewBag.commonCodeListUseYN}'), function( event ) {
            fnConfigAuthSetComboBox_Change();
        });/* 사용여부 설정 */
        return;
    }
    function fnConfigAuthSetComboBox_Change() {
        /* 공통사항 */
        var eventType = event.target.parentElement.id.replace('_listbox', '').replace('sel', '');
        var param = {};
        /* 이벤트별 처리 */
        if (window[fnGetName().name + '_' + eventType]) {
            window[fnGetName().name + '_' + eventType](param);
        }
        return;
    }
    /* 회사 */
    function fnConfigAuthSetComboBox_Change_ConfigAuthCompany() {
        $('#btnConfigAuthSearch').click();
        return;
    }
    /* 현금영수증구분 */
    function fnConfigAuthSetComboBox_Change_ConfigAuthCashType() {
        return;
    }
    /* 사용여부 */
    function fnConfigAuthSetComboBox_Change_ConfigAuthUseYN() {
        return;
    }

    /* 이벤트 정의 */
    function fnConfigAuthInitEvent() {
        fnConfigAuthEventButton();
    }
    /* 버튼이벤트 정의 */
    function fnConfigAuthEventButton( event ) {
        /* 조회 */
        $('#btnConfigAuthSearch').click(function() {
            fnConfigAuthSearch();
        });
        /* 신규 */
        $('#btnConfigAuthNew').click(function() {
            fnConfigAuthNew();
        });
        /* 저장 */
        $('#btnConfigAuthSave').click(function() {
            fnConfigAuthSave();
        });
        /* 삭제 */
        $('#btnConfigAuthDelete').click(function() {
            fnConfigAuthDelete();
        });
        /* 부가세구분 */
        $('#btnConfigAuthVatTypePopUp').click(function() {
        	var Popresult = fnOpenCodePop({
        		codeType : 'VatType'
        		, callback : 'fnConfigAuthVatTypePopUp'
        		, searchStr : ($("#txtConfigAuthVatTypeName").val() || '')
        	});
        });
        /* 대변대체계정 */
        $('#btnConfigAuthCrAcctPopUp').click(function() {
        	var Popresult = fnOpenCodePop({
        		codeType : 'Acct'
        		, callback : 'fnConfigAuthCrAcctPopUp'
        		, searchStr : ($("#txtConfigAuthCrAcctName").val() || '')
        		, acct_type : 'DR'
        	});
        });
        /* 부가세대체계정 */
        $('#btnConfigAuthVatAcctPopUp').click(function() {
        	var Popresult = fnOpenCodePop({
        		codeType : 'Acct'
        		, callback : 'fnConfigAuthVatAcctPopUp'
        		, searchStr : ($("#txtConfigAuthVatAcctName").val() || '')
        		, acct_type : 'VAT'
        	});
        });
        /* ERP증빙설정 */
        $('#btnConfigAuthErpAuthPopUp').click(function() {
            var Popresult = fnOpenCodePop({
            	codeType : 'ErpAuth'
            	, callback : 'fnConfigAuthErpAuthPopUp'
            	, searchStr : ($("#txtConfigAuthErpAuthName").val() || '')
            });
        });
        /* 불공제구분 */
        $('#btnConfigAuthNotaxPopUp').click(function() {
        	var Popresult = fnOpenCodePop({
        		codeType : 'Notax'
        		, callback : 'fnConfigAuthNotaxPopUp'
        		, searchStr : ($("#txtConfigAuthNotaxName").val() || '')
        	});
        });
        /* 사유구분 */
        $('#btnConfigAuthVaTypePopUp').click(function() {
        	var Popresult = fnOpenCodePop({
        		codeType : 'Va'
        		, callback : 'fnConfigVaTypePopUp'
        		, searchStr : ($("#txtvaCtdNm").val() || '')
        	});
        });
        return;
    }
    /* 증빙유형 리스트 조회 */
    function fnConfigAuthSearch() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeAuth);
        
        <c:if test="${ViewBag.empInfo.userSe == 'MASTER'}"> /* 마스터인경우, 회사 선택 노툴 */
        param.comp_seq = $('#selConfigAuthCompany').val();
        </c:if>
        <c:if test="${ViewBag.empInfo.userSe != 'MASTER'}"> /* 마스터인경우, 회사 선택 노툴 */
        param.comp_seq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        </c:if>
        param.codeType = "AUTH";
        param.auth_div = 'A';

        $.ajax({
            type : 'post',
//             url : '<c:url value="/ex/code/auth/ExCodeAuthListInfoSelect.do" />',
            url : '<c:url value="/expend/ex/user/code/ExCodeInfoSelect.do" />',

            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {

                expendInfo.ifSystem = '${ViewBag.ifSystem}';

                if (data.result.aaData) {
                    var source = (data.result.aaData || {});
                    $('#divConfigAuthList').empty();
                    $('#divConfigAuthList').append('<table id="tblConfigAuthList"></table>');
                    
                    $('#tblConfigAuthList').dataTable({
                        "fixedHeader" : true,
                        "select" : true,
                        "pageLength" : 7,
                        // "sScrollY" : param.scrollY,
                        "bAutoWidth" : false,
                        "destroy" : true,
                        "language" : {
                            "lengthMenu" : "보기 _MENU_",
                            "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                            "info" : "_PAGE_ / _PAGES_",
                            "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                            "infoFiltered" : "(전체 _MAX_ 중.)"
                        },
//                         "data" : data.aaData,
                        "data" : source,
                        "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                            $(nRow).css("cursor", "pointer");
                            $(nRow).on('click', (function() {
                                fnConfigAuthEventSelect_Row(aData);
                            }));
                        },
                        /* { "targets" : 0, "data" : null, "render" : function( aData ) { if (data != null && data != "") { return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.comp_seq + '|' + aData.auth_code + '" value="' + aData.comp_seq + '|' + aData.auth_code + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="inp_chk' + aData.comp_seq + '|' + aData.auth_code + '"></label>'; } else { return ""; } } }, */
                        "columnDefs" : [ {
                            "targets" : 5,
                            "data" : null,
                            "render" : function( aData ) {
                                var result = "";

                                if (aData.note_required_yn == 'Y') {
                                    if (result == '') {
                                        result = "<%=BizboxAMessage.getMessage("TX000000604","적요")%>";
                                    } else {
                                        result += "/<%=BizboxAMessage.getMessage("TX000000604","적요")%>";
                                    }
                                }
                                if (aData.auth_required_yn == 'Y') {
                                    if (result == '') {
                                        result = "<%=BizboxAMessage.getMessage("TX000000514","증빙일자")%>";
                                    } else {
                                        result += "/<%=BizboxAMessage.getMessage("TX000000514","증빙일자")%>";
                                    }
                                }
                                if (aData.card_required_yn == 'Y') {
                                    if (result == '') {
                                        result = "<%=BizboxAMessage.getMessage("TX000005795","카드")%>";
                                    } else {
                                        result += "/<%=BizboxAMessage.getMessage("TX000005795","카드")%>";
                                    }
                                }
                                if (aData.partner_required_yn == 'Y') {
                                    if (result == '') {
                                        result = "<%=BizboxAMessage.getMessage("TX000000520","거래처")%>";
                                    } else {
                                        result += "/<%=BizboxAMessage.getMessage("TX000000520","거래처")%>";
                                    }
                                }
                                if (aData.project_required_yn == 'Y') {
                                    if (result == '') {
                                        result = "<%=BizboxAMessage.getMessage("TX000000519","프로젝트")%>";
                                    } else {
                                        result += "/<%=BizboxAMessage.getMessage("TX000000519","프로젝트")%>";
                                    }
                                }

                                return result;
                            }
                        }, {
                            "targets" : 6,
                            "data" : null, //"vatYN", 
                            "render" : function( data ) {
                                if (data != null && data != '') {
                                    if (data == 'Y') {
                                        return "<%=BizboxAMessage.getMessage("TX000000180","사용")%>";
                                    } else {
                                        return "<%=BizboxAMessage.getMessage("TX000001243","미사용")%>";
                                    }
                                } else {
                                    return '';
                                }
                            }
                        } ],
                        /* { "sTitle" : "<input type='checkbox' id='chk' name='all_chk' onclick='fnAllCheckBoxChecked(this, " + '"' + 'inp_chk' + '"' + ")'>", "bSearchable" : false, "bSortable" : false, "bVisible" : false, "sWidth" : "34", "sClass" : "center" }, */
                        "aoColumns" : [ {
                            "sTitle" : "<%=BizboxAMessage.getMessage("TX000000302","증빙코드")%>",
                            "mDataProp" : "auth_code",
                            "bVisible" : true,
                            "bSortable" : true,
                            "sWidth" : ""
                        }, {
                            "sTitle" : "<%=BizboxAMessage.getMessage("TX000000303","증빙유형")%>",
                            "mDataProp" : "auth_name",
                            "bVisible" : true,
                            "bSortable" : true,
                            "sWidth" : ""
                        }, {
                            "sTitle" : "<%=BizboxAMessage.getMessage("TX000005735","부가세구분")%>",
                            "mDataProp" : "vat_type_name",
                            "bVisible" : true,
                            "bSortable" : true,
                            "sWidth" : ""
                        }, {
                            "sTitle" : "<%=BizboxAMessage.getMessage("TX000000305","대변대체계정")%>",
                            "mDataProp" : "cr_acct_name",
                            "bVisible" : true,
                            "bSortable" : true,
                            "sWidth" : ""
                        }, {
                            "sTitle" : "<%=BizboxAMessage.getMessage("TX000000306","부가세대체계정")%>",
                            "mDataProp" : "vat_acct_name",
                            "bVisible" : true,
                            "bSortable" : true,
                            "sWidth" : ""
                        }, {
                            "sTitle" : "<%=BizboxAMessage.getMessage("TX000009624","필수입력")%>",
                            "bSearchable" : false,
                            "bSortable" : false,
                            "sWidth" : "",
                            "sClass" : "center"
                        }, {
                            "sTitle" : "<%=BizboxAMessage.getMessage("TX000000028","사용여부")%>",
                            "mDataProp" : "use_yn",
                            "bVisible" : true,
                            "bSortable" : true,
                            "sWidth" : ""
                        } ]
                    });
                }

                $('#btnConfigAuthNew').click();
                return;
            },
            error : function( data ) {
                $('#btnConfigAuthNew').click();
                return;
            }
        });
        return;
    }
    /* 신규 */
    function fnConfigAuthNew() {
        /* 증빙코드 입력 활성화 */
        $('#txtConfigAuthCode').removeAttr('disabled');
        /* 텍스트입력 초기화 */
        var input = $('.txt_reset');
        $.each(input, function( idx, target ) {
            $(target).val('');
        });
        /* 체크박스 초기화 */
        $('#chkConfigAuthNoteReq').prop('checked', false);
        $('#chkConfigAuthAuthReq').prop('checked', false);
        $('#chkConfigAuthCardReq').prop('checked', false);
        $('#chkConfigAuthPartnerReq').prop('checked', false);
        $('#chkConfigAuthProjectReq').prop('checked', false);
        /* 콤보박스 초기화 */
        // var useYN = $('#selConfigAuthUseYN').data('kendoComboBox'); /* 현금영수증구분 */
        // useYN.value('Y');
        // var cashType = $('#selConfigAuthCashType').data('kendoComboBox'); /* 현금영수증구분 */
        // cashType.value('N');
        /* 포커스 설정 */
        $('#txtConfigAuthCode').focus();
        return;
    }
    /* 저장 */
    function fnConfigAuthSave( param ) {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeAuth);
//         param.comp_seq = $('#selConfigAuthCompany').val();
		param.comp_seq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        param.auth_div = 'A';
        param.auth_code = $('#txtConfigAuthCode').val(); /* 증빙코드 */
        param.auth_name = $('#txtConfigAuthName').val(); /* 증빙유형명칭 */
        param.order_num = $('#txtConfigAuthOrderNum').val(); /* 정렬순서 */
        param.vat_type_code = $('#txtConfigAuthVatTypeCode').val(); /* 부가세구분 코드 */
        param.vat_type_name = $('#txtConfigAuthVatTypeName').val(); /* 부가세구분 명칭 */
        param.cr_acct_code = $('#txtConfigAuthCrAcctCode').val(); /* 대변대체계정 코드 */
        param.cr_acct_name = $('#txtConfigAuthCrAcctName').val(); /* 대변대체계정 명칭 */
        param.vat_acct_code = $('#txtConfigAuthVatAcctCode').val(); /* 부가세대체계정 코드 */
        param.vat_acct_name = $('#txtConfigAuthVatAcctName').val(); /* 부가세대체계정 명칭 */
        if ($("#chkConfigAuthNoteReq").is(":checked")) {
            param.note_required_yn = 'Y';
        } else {
            param.note_required_yn = 'N';
        } /* 필수입력 적요 */
        if ($("#chkConfigAuthAuthReq").is(":checked")) {
            param.auth_required_yn = 'Y';
        } else {
            param.auth_required_yn = 'N';
        } /* 필수입력 증빙일자 */
        if ($("#chkConfigAuthCardReq").is(":checked")) {
            param.card_required_yn = 'Y';
        } else {
            param.card_required_yn = 'N';
        } /* 필수입력 법인카드 */
        if ($("#chkConfigAuthPartnerReq").is(":checked")) {
            param.partner_required_yn = 'Y';
        } else {
            param.partner_required_yn = 'N';
        } /* 필수입력 거래처 */
        if ($("#chkConfigAuthProjectReq").is(":checked")) {
            param.project_required_yn = 'Y';
        } else {
            param.project_required_yn = 'N';
        } /* 필수입력 프로젝트 */
        param.cash_type = $('#selConfigAuthCashType').val(); /* 현금영수증구분 */
        param.use_yn = $('#selConfigAuthUseYN').val(); /* 사용여부 */
        param.erp_auth_code = $('#txtConfigAuthErpAuthCode').val(); /* ERP증빙 코드 */
        param.erp_auth_name = $('#txtConfigAuthErpAuthName').val(); /* ERP증빙 명칭 */
        param.no_tax_code = $('#txtConfigAuthNotaxCode').val(); /* 불공제구분(ERPiU) 코드 *//* 사유구분(iCUBE) 코드 */
        param.no_tax_name = $('#txtConfigAuthNotaxName').val(); /* 불공제구분(ERPiU) 명칭 *//* 사유구분(iCUBE) 명청 */

        if (expendInfo.ifSystem == 'iCUBE') {
            param.va_type_code = $('#txtvaCtdCd').val();
            param.va_type_name = $('#txtvaCtdNm').val();
        }
        /* 호출분기 처리 */
        var url = '';
        if ($('#txtConfigAuthCode').attr('disabled')) {
            /* 수정 수행 */
            url = '<c:url value="/ex/master/config/AuthInfoUpdate.do" />';
        } else {
            /* 생성 수행 */
            url = '<c:url value="/ex/master/config/AuthInfoInsert.do" />';
        }
        /* ajax 호출 */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                $('#btnConfigAuthSearch').click();
            },
            error : function( data ) {
                if (data.aaData) {
                    alert(data.aaData.message);
                }
            }
        });
        return;
    }
    /* 삭제 */
    function fnConfigAuthDelete( param ) {
        var param = {};
        $.extend(param, ExCodeAuth);
//         param.comp_seq = $('#selConfigAuthCompany').val();
		param.comp_seq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        param.auth_div = 'A';
        param.auth_code = $('#txtConfigAuthCode').val();
        /* 서버 호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/master/config/AuthInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                $('#btnConfigAuthSearch').click();
            },
            error : function( data ) {
                alert(data.aaData.resultMessage);
            }
        });
        return;
    }
    /* 부가세구분 */
    function fnConfigAuthVatTypePopUp( param) {
        $('#txtConfigAuthVatTypeCode').val(param.obj.vat_code);
        $('#txtConfigAuthVatTypeName').val(param.obj.vat_name);
        return;
    }
    /* 대변대체계정 */
    function fnConfigAuthCrAcctPopUp( param ) {
        $('#txtConfigAuthCrAcctCode').val(param.obj.acct_code || '');
        $('#txtConfigAuthCrAcctName').val(param.obj.acct_name || '');
        return;
    }
    /* 부가세대체계정 */
    function fnConfigAuthVatAcctPopUp( param ) {
        $('#txtConfigAuthVatAcctCode').val(param.obj.acct_code || '');
        $('#txtConfigAuthVatAcctName').val(param.obj.acct_name || '');
        return;
    }
    /* ERP증빙설정 */
    function fnConfigAuthErpAuthPopUp( param ) {
        $('#txtConfigAuthErpAuthCode').val(param.obj.erpAuthCode);
        $('#txtConfigAuthErpAuthName').val(param.obj.erpAuthName);
        return;
    }
    /* 불공제구분 / 사유구분 */
    function fnConfigAuthNotaxPopUp( param ) {
        $('#txtConfigAuthNotaxCode').val(param.obj.no_tax_code);
        $('#txtConfigAuthNotaxName').val(param.obj.no_tax_name);
        return;
    }
    /* 사유구분(ICUBE) */
    function fnConfigVaTypePopUp( param ) {
        $('#txtvaCtdCd').val(param.obj.va_type_code);
        $('#txtvaCtdNm').val(param.obj.va_type_name);
        return;
    }
    /* 엔터이벤트 */
    function fnConfigAuthSetEnterEvent( event ) {
        if (event.keyCode == 13) {
            if ($('#txtConfigAuthCode').val() == '') {
                /* 증빙유형 코드 */
                $('#txtConfigAuthCode').focus();
            } else if ($('#txtConfigAuthName').val() == '') {
                /* 증빙유형 명칭 */
                $('#txtConfigAuthName').focus();
            } else if ($('#txtConfigAuthOrderNum').val() == '') {
                /* 정렬순서 */
                $('#txtConfigAuthOrderNum').focus();
            }
        }
        return;
    }
    /* 행성택 이벤트 */
    function fnConfigAuthEventSelect_Row( data ) {
        /* 초기화 */
        $('#btnConfigAuthNew').click();
        /* 선택값 바인딩 */
        $('#txtConfigAuthCode').attr('disabled', 'disabled');
        $('#txtConfigAuthCode').val(data.auth_code); /* 증빙코드 */
        $('#txtConfigAuthName').val(data.auth_name); /* 증빙유형 */
        $('#txtConfigAuthOrderNum').val(data.order_num); /* 정렬순서 */
        $('#txtConfigAuthVatTypeCode').val(data.vat_type_code); /* 부가세구분 코드 */
        $('#txtConfigAuthVatTypeName').val(data.vat_type_name); /* 부가세구분 명칭 */
        $('#txtConfigAuthCrAcctCode').val(data.cr_acct_code); /* 대변대체계정 코드 */
        $('#txtConfigAuthCrAcctName').val(data.cr_acct_name); /* 대변대체계정 명칭 */
        $('#txtConfigAuthVatAcctCode').val(data.vat_acct_code); /* 부가세대체계정 코드 */
        $('#txtConfigAuthVatAcctName').val(data.vat_acct_name); /* 부가세대체계정 명칭 */
        if (data.note_required_yn == 'Y') { /* 필수입력 설정 ( 적요 ) */
            $('#chkConfigAuthNoteReq').prop('checked', true);
        } else {
            $('#chkConfigAuthNoteReq').prop('checked', false);
        }
        if (data.auth_required_yn == 'Y') { /* 필수입력 설정 ( 증빙일자 ) */
            $('#chkConfigAuthAuthReq').prop('checked', true);
        } else {
            $('#chkConfigAuthAuthReq').prop('checked', false);
        }
        if (data.card_required_yn == 'Y') { /* 필수입력 설정 ( 법인카드 ) */
            $('#chkConfigAuthCardReq').prop('checked', true);
        } else {
            $('#chkConfigAuthCardReq').prop('checked', false);
        }
        if (data.partner_required_yn == 'Y') { /* 필수입력 설정 ( 거래처 ) */
            $('#chkConfigAuthPartnerReq').prop('checked', true);
        } else {
            $('#chkConfigAuthPartnerReq').prop('checked', false);
        }
        if (data.project_required_yn == 'Y') { /* 필수입력 설정 ( 프로젝트 ) */
            $('#chkConfigAuthProjectReq').prop('checked', true);
        } else {
            $('#chkConfigAuthProjectReq').prop('checked', false);
        }
        // var cashType = $('#selConfigAuthCashType').data('kendoComboBox'); /* 현금영수증구분 */
        // cashType.value(data.cashType)
        // var useYN = $('#selConfigAuthUseYN').data('kendoComboBox'); /* 사용여부 */
        // useYN.value(data.useYN)
        $('#txtConfigAuthErpAuthCode').val(data.erp_auth_code); /* ERP증빙설정 코드 */
        $('#txtConfigAuthErpAuthName').val(data.erp_auth_name); /* ERP증빙설정 명칭 */
        $('#txtConfigAuthNotaxCode').val(data.no_tax_code); /* 사유구분 코드 / 불공제구분 코드 */
        $('#txtConfigAuthNotaxName').val(data.no_tax_name); /* 사유구분 명칭 / 불공제구분 명칭 */
        $('#txtvaCtdCd').val(data.va_type_code); /* 사유구분(ICUBE) 코드*/
        $('#txtvaCtdNm').val(data.va_type_name); /* 사유구분(ICUBE) 명*/
    }

    /* 공통사용 */
    /* 공통사용 - 팝업호출 파라미터 */
    function fnMakePopParam( getParam ) {
        var param = {};
        param.url = '';
        param.title = '';
        param.width = 650;
        param.height = 689;
        param.opener = '1';
        param.parentId = '';
        param.childerenId = '';
        param.getParam = getParam;
        return param;
    }
</script>

<div class="modal" style="display: none;"></div>
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<!-- 마스터인경우, 회사 선택 노툴 -->
<!-- 	<div class="top_box"> -->
<!-- 		<dl> -->
<%-- 			<dt><%=BizboxAMessage.getMessage("TX000000047","회사")%></dt> --%>
<!-- 			<dd> -->
<!-- 				<div class="dod_search"> -->
<!-- 					<input type="text" id="selConfigAuthCompany" class="kendoComboBox" style="width: 200px;" /> -->
<!-- 				</div> -->
<!-- 			</dd> -->
<!-- 		</dl> -->
<!-- 	</div> -->
	<div id="" class="controll_btn">
		<button id="btnConfigAuthSearch" class="k-button" style="display: none;"><%=BizboxAMessage.getMessage("TX000000047","회사")%></button>
		<button id="btnConfigAuthNew" class="k-button"><%=BizboxAMessage.getMessage("TX000003101","신규")%></button>
		<button id="btnConfigAuthSave" class="k-button"><%=BizboxAMessage.getMessage("TX000001256","저장")%></button>
		<button id="btnConfigAuthDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424","삭제")%></button>
	</div>
	<div id="divConfigAuthList" class="com_ta2">
		<table id="tblConfigAuthList">
		</table>
	</div>
	<div class="com_ta mt20">
		<table>
			<colgroup>
				<col width="140" />
				<col width="" />
				<col width="140" />
				<col width="" />
			</colgroup>
			<tr>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000000302","증빙코드")%></th>
				<td>
					<input id="txtConfigAuthCode" type="text" style="width: 66%" class="txt_reset" />
				</td>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000000303","증빙유형")%></th>
				<td>
					<input id="txtConfigAuthName" type="text" style="width: 66%" class="txt_reset" />
				</td>
			</tr>
			<tr>
				<th><%=BizboxAMessage.getMessage("TX000000125","정렬순서")%></th>
				<td>
					<input id="txtConfigAuthOrderNum" type="text" style="width: 19%" class="txt_reset" />
				</td>
				<th><%=BizboxAMessage.getMessage("TX000005735","부가세구분")%></th>
				<td>
					<input id="txtConfigAuthVatTypeCode" type="text" style="width: 19%" class="txt_reset" /> <input id="txtConfigAuthVatTypeName" type="text" style="width: 46%" class="txt_reset" />
					<div class="controll_btn p0">
						<button id="btnConfigAuthVatTypePopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr>
			<tr>
				<th><%=BizboxAMessage.getMessage("TX000000305","대변대체계정")%></th>
				<td>
					<input id="txtConfigAuthCrAcctCode" type="text" style="width: 19%" class="txt_reset" /> <input id="txtConfigAuthCrAcctName" type="text" style="width: 46%" class="txt_reset" />
					<div class="controll_btn p0">
						<button id="btnConfigAuthCrAcctPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
				<th><%=BizboxAMessage.getMessage("TX000000306","부가세대체계정")%></th>
				<td>
					<input id="txtConfigAuthVatAcctCode" type="text" style="width: 19%" class="txt_reset" /> <input id="txtConfigAuthVatAcctName" type="text" style="width: 46%" class="txt_reset" />
					<div class="controll_btn p0">
						<button id="btnConfigAuthVatAcctPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr>
			<tr>
			</tr>
			<tr>
				<th><%=BizboxAMessage.getMessage("TX000000307","필수입력설정")%></th>
				<td>
					<ul class="check_ul">
						<li><input type="checkbox" name="mf" id="chkConfigAuthNoteReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthNoteReq">${CL.ex_note} <!--적요--></label></li>
						<li><input type="checkbox" name="mf" id="chkConfigAuthAuthReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthAuthReq">${CL.ex_requiredDate} <!--증빙일자필수입력--></label></li>
						<li><input type="checkbox" name="mf" id="chkConfigAuthCardReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthCardReq">${CL.ex_essentialCard} <!--법인카드필수입력--></label></li>
						<li><input type="checkbox" name="mf" id="chkConfigAuthPartnerReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthPartnerReq">${CL.ex_essentialVendor} <!--거래처필수입력--></label></li>
						<li><input type="checkbox" name="mf" id="chkConfigAuthProjectReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthProjectReq">${CL.ex_essentialProject} <!--프로젝트필수입력--></label></li>
					</ul>
				</td>
				<th><%=BizboxAMessage.getMessage("TX000005736","현금영수증구분")%></th>
				<td>
					<input type="text" id="selConfigAuthCashType" class="kendoComboBox" />
				</td>
			</tr>
			<tr>
				<th><%=BizboxAMessage.getMessage("TX000000028","사용여부")%></th>
				<td>
					<input type="text" id="selConfigAuthUseYN" class="kendoComboBox" />
				</td>
				<th>
					<!-- ERP증빙설정 -->
				</th>
				<td>
					<input id="txtConfigAuthErpAuthCode" type="text" style="width: 19%; display: none;" class="txt_reset" /> <input id="txtConfigAuthErpAuthName" type="text" style="width: 46%; display: none;" class="txt_reset" />
					<div class="controll_btn p0" style="display: none;">
						<button id="btnConfigAuthErpAuthPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr>
			<tr style="display: none;">
				<th><%=BizboxAMessage.getMessage("TX000005802","불공제구분")%>(ERPiU)</th>
				<td>
					<input id="txtConfigAuthNotaxCode" type="text" style="width: 19%" class="txt_reset" /> <input id="txtConfigAuthNotaxName" type="text" style="width: 46%" class="txt_reset" />
					<div class="controll_btn p0">
						<button id="btnConfigAuthNotaxPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
				<th><%=BizboxAMessage.getMessage("TX000007119","사유구분")%>(ICUBE)</th>
				<td>
					<input id="txtvaCtdCd" type="text" style="width: 19%" class="txt_reset" /> <input id="txtvaCtdNm" type="text" style="width: 46%" class="txt_reset" />
					<div class="controll_btn p0">
						<button id="btnConfigAuthVaTypePopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
<!-- //sub_contents_wrap -->
