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
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.focus.js"></c:url>'></script>
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
    
    var erpVatType = {}; /* 불공제 구분 (ERPiU) / 사유구분 (iCUBE) */
    
    //엑셀 테스트 
    var listData = {};

    /* 문서로드 */
    $(document).ready(function() {
    	if(expendInfo.ifSystem === 'iCUBE'){
    		erpVatType.title = "${CL.ex_reasonType}";
    		erpVatType.code = 'vaTypeCode';
    		erpVatType.name = 'vaTypeName';
    		erpVatType.visible = true;
    	}else if(expendInfo.ifSystem === 'ERPiU'){
    		erpVatType.title = "${CL.ex_noType}";
    		erpVatType.code = 'noTaxCode';
    		erpVatType.name = 'noTaxName';
    		erpVatType.visible = true;
    	}else{
    		erpVatType.title = "<%=BizboxAMessage.getMessage("TX000010598","미지원")%>";
    		erpVatType.code = null;
    		erpVatType.name = null;
    		erpVatType.visible = false;
    	}
        fnConfigAuthInit();
        fnConfigAuthInitEvent();
        fnConfigAuthSearch();
        $('#txtSearchStr').focus();
        
        return;
    })
    /*-------------------------------------------------------------------------*/
    /* 초기화 */
    /*-------------------------------------------------------------------------*/
    /* 초기화  */
    function fnConfigAuthInit() {
        $(".controll_btn button").kendoButton(); /* 켄도버튼 정의 */
        fnConfigAuthSetComboBox(); /* Combobox 바인딩 */
        return;
    }
    
    /*-------------------------------------------------------------------------*/
    /* 레이아웃 변경 */
    /*-------------------------------------------------------------------------*/
    /* 레이아웃 변경 */
    function fnConfigAuthLayoutInit(isSearch) {
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
    	// 엘리먼트 초기화
    	$('#configAuthVat').hide();
    	$('.ERPElement').hide();
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
        return;
    }
    /* ERPiU */
    function fnConfigAuthLayoutInit_ERPiU( param ) {
    	// 부가세 대체계정 필수 입력
		// 엘리먼트 초기화
    	$("#configAuthVat").hide();
		$('.ERPElement').hide();
		
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
        fnConfigAuthEventEnter();
        fnConfigAuthEventKey();
    }
    
    /* 키보드 이벤트 정의 */
    function fnConfigAuthEventKey(){
    	$('#txtConfigAuthOrderNum').keydown(function () { 
    	    this.value = this.value.replace(/[^0-9\.]/g,'');
    	});
        $("#txtSearchStr").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;

                fnConfigAuthSearch();
            }
        });
    }
    
    /* 버튼이벤트 정의 */
    function fnConfigAuthEventButton( event ) {
        /* 조회 */
        $('#btnConfigAuthSearch').click(function() {
        	$('#txtSearchStr').focus();
            fnConfigAuthSearch();
        });
        /* 신규 */
        $('#btnConfigAuthNew').click(function() {
            fnConfigAuthNew();
            $('#txtConfigAuthCode').focus();
        });
        /* 저장 */
        $('#btnConfigAuthSave').click(function() {
        	$('#txtConfigAuthCode').focus();
        	fnConfigAuthSave();
        });
        /* 삭제 */
        $('#btnConfigAuthDelete').click(function() {
        	$('#txtSearchStr').focus();
            fnConfigAuthDelete();
        });
        
        $('#btnConfigAuthExcelDownload').click(function(){
        	fnAtuhExcelDownload();	
        })
                
        /* 이벤트 정의 - 엔터입력시 포커스 이동 jQuery.exp.expend.focus.js 참조 */
        focus_fnSetFocusEvent(
       		[
       		 'txtConfigAuthCode'
       		, 'txtConfigAuthName'
       		, 'txtConfigAuthVatAcctName'
       		, 'txtConfigAuthVaName'
       		]
     	);
        
        /* 초기화 버튼클릭 이벤트 정의 */
        $('.reload_btn').click(function( event ) {
            /* 대상자 찾기 */
            var par = $(this).parent();
            var input = $(par).prevAll('.txt_reset');
            
            if(expendInfo.ifSystem === 'iCUBE'){
	            if(input[0].id.indexOf('VatType') > -1){
	            	$('#configAuthVat').hide();
	            }
            }
            /* 초기화 진행 */
            $.each(input, function( idx, target ) {
                $(target).val('');
            });
            
        });
        
		/* 부가세구분, 대변대체계정, 부가세대체계정, ERP증빙설정,불공제구분, 사유구분 */
        $('#btnConfigAuthVatTypePopUp, #btnConfigAuthCrAcctPopUp, #btnConfigAuthVatAcctPopUp, #btnConfigAuthErpAuthPopUp'
        		+ ', #btnConfigAuthNotaxPopUp, #btnConfigAuthVaPopUp').click(function() {
			var type = this.id.toString().replace('btnConfigAuth', '').replace('PopUp','');
			if( type.toLowerCase() == "notax" ){
				type = "NoTax";
			}
			fnCommonCodePop(type, false);
        });
        return;
    }
    
    function fnConfigAuthEventEnter(){
    	$('#txtConfigAuthVatTypeName, #txtConfigAuthCrAcctName, #txtConfigAuthVatAcctName, #txtConfigAuthErpAuthName'
        		+ ', #txtConfigAuthNotaxName, #txtConfigAuthVaName').bind('keydown', function( event ) {
	        /* 엔터입력 이벤트 적용 */
	        if (event.which == 113) {
	        	var type = this.id.toString().replace('txtConfigAuth', '').replace('Name','');
	        	fnCommonCodePop(type, true);
	        }
	    });
    }
    
    function fnCommonCodePop(type, pressEnterYN){
		var callback = '';
		var searchStr = {};
		var acctType = '';
		var vatType = '';
		switch(type){
			case "VatType" :
			case "ErpAuth" :
			case "NoTax" :
			case "Va" :
				callback = 'fnConfigAuth' + type + 'PopUp';
				vatType = ($('#txtConfigAuthVatTypeCode').val() || '');
				searchStr = ($("#txtConfigAuth" + type + "Name").val() || ''); 
				break;
			case "CrAcct" :
				type = 'Acct';
				callback = 'fnConfigAuthCrAcctPopUp';
				searchStr = ($("#txtConfigAuthCrAcctName").val() || '');
				acctType = 'CR';
				break;
			case "VatAcct" :
				type = 'Acct';
				callback = 'fnConfigAuthVatAcctPopUp';
				searchStr = ($("#txtConfigAuthVatAcctName").val() || '');
				acctType = 'VAT';
				break;
		}
		if(!pressEnterYN){
			searchStr = '';
		}
    	var Popresult = fnOpenCodePop({
    		codeType : type
    		, callback : callback
    		, searchStr : searchStr
    		, vat_type : (vatType || '')
    		, acct_type : (acctType || '')
    		, reflectResultPop : true
    	});
    }
    
    /* 증빙유형 리스트 조회 */
    var baseData = {};
    function fnConfigAuthSearch() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeAuth);
        param.compSeq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        param.codeType = "AUTH";
        param.authDiv = 'A';
		param.searchStr = ($('#txtSearchStr').val() || '');
		param.useYN = 'Y';
		param.formSeq = '';
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex/user/code/ExCodeInfoSelect.do" />',

            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {

                expendInfo.ifSystem = '${ViewBag.ifSystem}';
                if (typeof data.result.aaData != 'undefined') {
                    /* 테이블 데이터 바인딩 */
                    fnConfigAuthSetTable(data.result.aaData);
                    /* 엑셀 list*/
                    listData = data.result.aaData;
                } else {
                    /* 테이블 데이터 바인딩 */
                    fnConfigAuthSetTable('');
                }
                fnConfigAuthNew();
                return;
            },
            error : function( data ) {
            	fnConfigAuthNew();
                return;
            }
        });
        return;
    }
    
    function fnConfigAuthSetTable( data ) {
    	baseData = data || {};
    	data = (data || '');
    	
    	$('#divConfigAuthList').empty();
        $('#divConfigAuthList').append('<table id="tblConfigAuthList"></table>');
        
        $('#tblConfigAuthList').dataTable( {
        	"aaSorting": [],
            "fixedHeader" : false,
            "select" : true,
            "pageLength" : 10,
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
//             "data" : data.aaData,
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                    fnConfigAuthEventSelect_Row(aData);
                    
                    if (expendInfo.ifSystem == 'iCUBE' || expendInfo.ifSystem == 'ERPiU') {
                		if($(".iCUBEVat").is(":visible")){
            	    		$(".ERPAuth").show();
            	    		$(".iCUBEVat").show();
            	    		$(".ERPiUVat").hide();
            	    	}else if($(".ERPiUVat").is(":visible")){
            	    		$(".ERPAuth").show();
            	    		$(".ERPiUVat").show();
            	    		$(".iCUBEVat").hide();
            	        }else{
            	        	$(".ERPiUVat").hide();
            	        	$(".iCUBEVat").hide();
            	        	$(".ERPAuth").show();
            	        }
                    }else{
                    	$(".ERPiUVat").hide();
                    	$(".iCUBEVat").hide();
                    }
                }));
            },
            /* { "targets" : 0, "data" : null, "render" : function( aData ) { if (data != null && data != "") { return '<input type="checkbox" name="inp_chk" id="inp_chk' + aData.comp_seq + '|' + aData.autCode + '" value="' + aData.comp_seq + '|' + aData.autCode + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="inp_chk' + aData.comp_seq + '|' + aData.autCode + '"></label>'; } else { return ""; } } }, */
            "columnDefs" : [ {
                "targets" : 4,
                "data" : null, //"vatYN", 
                "render" : function( data ) {
                	if(data.crAcctCode){
                		return data.crAcctCode + ' / '+ data.crAcctName;	
                	}
                	return '';
                }
            },{
               "targets" : 5,
               "data" : null, //"vatYN", 
               "render" : function( data ) {
            	   if(data.vatAcctCode){
            	   	return data.vatAcctCode + ' / '+ data.vatAcctName;
            	   }
            	   return '';
               }
            },{
                "targets" : 6,
                "data" : null,
                "render" : function( aData ) {
                    var result = "";

                    if (aData.noteRequiredYN == 'Y') {
                        if (result == '') {
                            result = "${CL.ex_note}";		/*적요*/ 
                        } else {
                            result += "/${CL.ex_note}";
                        }
                    }
                    if (aData.authRequiredYN == 'Y') {
                        if (result == '') {
                            result = "${CL.ex_evidenceDate}";		/*증빙일자*/
                        } else {
                            result += "/${CL.ex_evidenceDate}";
                        }
                    }
                    if (aData.cardRequiredYN == 'Y') {
                        if (result == '') {
                            result = "${CL.ex_card}";		/*카드*/
                        } else {
                            result += "/${CL.ex_card}";
                        }
                    }
                    if (aData.partnerRequiredYN == 'Y') {
                        if (result == '') {
                            result = "${CL.ex_vendor}";		/*거래처*/
                        } else {
                            result += "/${CL.ex_vendor}";
                        }
                    }
                    if (aData.projectRequiredYN == 'Y') {
                        if (result == '') {
                            result = "${CL.ex_project}";		/*프로젝트*/
                        } else {
                            result += "/${CL.ex_project}";
                        }
                    }

                    return result;
                }
            }, {
                "targets" : 7,
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
                "sTitle" : "${CL.ex_evidenceType}" /* 증빙유형 */ 
                + " " + "${CL.ex_code}", /* 코드 */
                "mDataProp" : "authCode",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "auth_code"
            }, {
                "sTitle" : "${CL.ex_evidenceType}" /* 증빙유형 */ 
                + " " + "${CL.ex_name}", /* 명칭 */
                
                "mDataProp" : "authName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "${CL.ex_classificationTax}" /* 부가세 구분 */
                + "(" + "${CL.ex_divisionBusiness}", /*세무구분*/
                "mDataProp" : "vatTypeName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : erpVatType.title,
                "mDataProp" : erpVatType.name,
                "bVisible" : erpVatType.visible,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "le"
            }, {
                "sTitle" : "${CL.ex_creditTransferAccount}" + "("  /*대변대체계정*/
               		+ "${CL.ex_code}" + "/" 
               		+ "${CL.ex_name}" + ")",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "${CL.ex_vatTransferAccount}" + "(" /*부가세대체계정*/
               		+ "${CL.ex_code}" + "/" 
               		+ "${CL.ex_name}" + ")",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "${CL.ex_essentialItem}", /*필수입력항목*/
                "bSearchable" : false,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "le"
            }, {
                "sTitle" : "${CL.ex_inUseYN}", /*사용여부*/
                "mDataProp" : "useYN",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            } ]
        });
    }
    /* 신규 */
    function fnConfigAuthNew() {
    	/* 엘리먼트 초기화 진행 */
    	fnConfigAuthLayoutInit();
    	
    	if (expendInfo.ifSystem == 'iCUBE' || expendInfo.ifSystem == 'ERPiU') {
    		if($(".iCUBEVat").is(":visible")){
	    		$(".ERPAuth").show();
	    		$(".iCUBEVat").show();
	    		$(".ERPiUVat").hide();
	    	}else if($(".ERPiUVat").is(":visible")){
	    		$(".ERPAuth").show();
	    		$(".ERPiUVat").show();
	    		$(".iCUBEVat").hide();
	        }else{
	        	$(".ERPiUVat").hide();
	        	$(".iCUBEVat").hide();
	        	$(".ERPAuth").show();
	        }
        }else{
        	$(".ERPiUVat").hide();
        	$(".iCUBEVat").hide();
        }
        return;
    }
    /* 저장 */
    function fnConfigAuthSave( param ) {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeAuth);
//         param.comp_seq = $('#selConfigAuthCompany').val();
		param.compSeq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        param.authDiv = 'A';
        param.authCode = $('#txtConfigAuthCode').val().trim(); /* 증빙코드 */
        param.authName = $('#txtConfigAuthName').val(); /* 증빙유형명칭 */
        param.orderNum = $('#txtConfigAuthOrderNum').val(); /* 정렬순서 */
        param.vatTypeCode = $('#txtConfigAuthVatTypeCode').val(); /* 부가세구분 코드 */
        param.vatTypeName = $('#txtConfigAuthVatTypeName').val(); /* 부가세구분 명칭 */
        param.crAcctCode = $('#txtConfigAuthCrAcctCode').val(); /* 대변대체계정 코드 */
        param.crAcctName = $('#txtConfigAuthCrAcctName').val(); /* 대변대체계정 명칭 */
        param.vatAcctCode = $('#txtConfigAuthVatAcctCode').val(); /* 부가세대체계정 코드 */
        param.vatAcctName = $('#txtConfigAuthVatAcctName').val(); /* 부가세대체계정 명칭 */
        param.formSeq = '';
        
        if ($("#chkConfigAuthNoteReq").is(":checked")) {
            param.noteRequiredYN = 'Y';
        } else {
            param.noteRequiredYN = 'N';
        } /* 필수입력 적요 */
        if ($("#chkConfigAuthAuthReq").is(":checked")) {
            param.authRequiredYN = 'Y';
        } else {
            param.authRequiredYN = 'N';
        } /* 필수입력 증빙일자 */
        if ($("#chkConfigAuthCardReq").is(":checked")) {
            param.cardRequiredYN = 'Y';
        } else {
            param.cardRequiredYN = 'N';
        } /* 필수입력 법인카드 */
        if ($("#chkConfigAuthPartnerReq").is(":checked")) {
            param.partnerRequiredYN = 'Y';
        } else {
            param.partnerRequiredYN = 'N';
        } /* 필수입력 거래처 */
        if ($("#chkConfigAuthProjectReq").is(":checked")) {
            param.projectRequiredYN = 'Y';
        } else {
            param.projectRequiredYN = 'N';
        } /* 필수입력 프로젝트 */
        param.cashType = $('#selConfigAuthCashType').val(); /* 현금영수증구분 */
        param.useYN = $('#selConfigAuthUseYN').val(); /* 사용여부 */
        param.erpAuthCode = $('#txtConfigAuthErpAuthCode').val(); /* ERP증빙 코드 */
        param.erpAuthName = $('#txtConfigAuthErpAuthName').val(); /* ERP증빙 명칭 */
        param.noTaxCode = $('#txtConfigAuthNotaxCode').val(); /* 불공제구분(ERPiU) 코드 */
        param.noTaxName = $('#txtConfigAuthNotaxName').val(); /* 불공제구분(ERPiU) 명칭 */
        param.vaTypeCode = $('#txtConfigAuthVaCode').val();/* 사유구분(iCUBE) 코드 */
        param.vaTypeName = $('#txtConfigAuthVaName').val();/* 사유구분(iCUBE) 명청 */

        if(fnValidateSaveData(param) == -1){
        	return;
        }
        
        if (expendInfo.ifSystem == 'iCUBE') {
            param.vaTypeCode = $('#txtConfigAuthVaCode').val();
            param.vaTypeName = $('#txtConfigAuthVaName').val();
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
            	fnInitErpElement();
            	$('#configAuthVat').show();
            	fnConfigAuthSearch();
                alert("<%=BizboxAMessage.getMessage("TX000002073","저장되었습니다.")%>");
                
            },
            error : function( data ) {
            	alert("<%=BizboxAMessage.getMessage("TX000018739","코드 중복을 확인하세요.")%>");
                if (data.aaData) {
                    alert(data.aaData.message);
                }
            }
        });
        return;
    }
    
    /* 필수 파라미터 벨리데이션 체크 */
    function fnValidateSaveData(param){
    	var base = JSON.stringify(baseData);
    	if(!param.authCode){
    		alert("<%=BizboxAMessage.getMessage("TX000018740","증빙유형코드를 확인하세요.")%>");
    		return -1;
    	}if(!param.authName){
    		alert("<%=BizboxAMessage.getMessage("TX000018741","증빙유형명칭을 확인하세요.")%>");
    		return -1;
    	}if((!$('#txtConfigAuthCode:disabled').length) &&  base.indexOf('"autCode":"'+param.autCode+'"') > -1){
    		alert("<%=BizboxAMessage.getMessage("TX000018742","중복되는 적요코드입니다.")%>");
    		return -1;
    	}
    	if(expendInfo.ifSystem === 'iCUBE' && $(".iCUBEVat:visible").length && !param.vaTypeCode){
    		alert("<%=BizboxAMessage.getMessage("TX000007557","사유구분을 입력하여 주십시요.")%>");
    		$('#btnConfigAuthVaPopUp').click();
    		return -1;
    	}
    	if(expendInfo.ifSystem === 'iCUBE' && $("#txtConfigAuthVatAcctCode:visible").length && !param.vatAcctCode && $('#configAuthVat:visible').length ){
    		alert("<%=BizboxAMessage.getMessage("TX000018743","부가세대체계정을 입력하여 주십시요")%>");
    		$('#btnConfigAuthVatAcctPopUp').click();
    		return -1;
    	}
    	if(expendInfo.ifSystem === 'ERPiU' && $(".ERPiUVat:visible").length && !param.noTaxCode){
    		alert("<%=BizboxAMessage.getMessage("TX000007553","불공제구분을 입력하여 주십시요.")%>");
    		return -1;
    	}
    	if(expendInfo.ifSystem === 'ERPiU'){
   	        switch (param.vatTypeCode) {
   	        	case '21':
   	        	case '22':
   	        	case '24':
   	        	case '31':
   	        	case '38':
   	        	case '43':
   	        	case '50':
   	        		// 부가세 대체계정 필수 입력
   	        		if($("#txtConfigAuthVatAcctCode").val() === ''){
   	        			alert("<%=BizboxAMessage.getMessage("TX000018743","부가세대체계정을 입력하여 주십시요")%>");
   	        			return -1;
   	        		}
   					break;
   			}
   	    }
    	
    	return 0;
    }
    
    /* 삭제 */
    function fnConfigAuthDelete( param ) {
    	if(!$('#txtConfigAuthCode').val() || !$('#txtConfigAuthCode').is(":disabled")){
    		alert("<%=BizboxAMessage.getMessage("TX000009543","증빙유형이 선택되지 않았습니다")%>");
    		return;
    	}
    	
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000015635","정말 삭제하시겠습니까 ?")%>")){
    		return;
    	}
        var param = {};
        $.extend(param, ExCodeAuth);
		param.compSeq = '${ViewBag.empInfo.compSeq}'; /* 회사 */
        param.authDiv = 'A';
        param.authCode = $('#txtConfigAuthCode').val();
        param.formSeq = '';
        
        /* 서버 호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/master/config/AuthInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	fnConfigAuthSearch();
            },
            error : function( data ) {
                alert(data.aaData.resultMessage);
            }
        });
        return;
    }
    /* 부가세구분 */
    function fnConfigAuthVatTypePopUp( param) {
        $('#txtConfigAuthVatTypeCode').val(param.obj.vatTypeCode);
        $('#txtConfigAuthVatTypeName').val(param.obj.vatTypeName);
        if(expendInfo.ifSystem === 'iCUBE'){
	        switch (param.obj.vatTypeCode) {
				case '23':
				case '24':
				case '26':
					// 불공 혹은 면세인경우 사유구분 입력란 활성화
					$(".ERPElement, .iCUBEVat").show();
					$(".ERPiUVat").hide();
					break;
				default:
					$('#txtConfigAuthVaCode').val('');
					$('#txtConfigAuthVaName').val('');
					// 불공 혹은 면세가 아닌 경우 사유구분 입력란 비활성화
					// $(".iCUBEVat, .ERPElement").hide();
					
					// 증빙 정보가 사유구분과 함께 미표시되여, 예외처리(UBA-34139)
					$(".ERPElement, .iCUBEVat").show(); // 입력항목 활성화
					$('tr.ERPElement.ERPAuth th.iCUBEVat').hide(); // 사유구분 미표시
					$('tr.ERPElement.ERPAuth td.iCUBEVat').hide(); // 사유구분 미표시
					
					break;
			}
	        $('#configAuthVat').show();
        }else if(expendInfo.ifSystem === 'ERPiU'){
	        switch (param.obj.vatTypeCode) {
	        	case '21':
	        	case '22':
	        	case '24':
	        	case '31':
	        	case '38':
	        	case '43':
	        	case '50':
	        		// 부가세 대체계정 필수 입력
	        		$("#configAuthVat").show();
	        		// 불공인 경우 불공제구분 입력란 활성화
					if(param.obj.vatTypeCode === '22' || param.obj.vatTypeCode === '50'){
						$(".ERPElement, .ERPiUVat").show();
						$(".iCUBEVat").hide();	
					}else{
						$(".ERPiUVat, .ERPElement").hide();	
					}
					break;
				default:
					$("#configAuthVat").hide();
					$(".ERPiUVat, .ERPElement").hide();
					break;
			}
	    }
        return;
    }
    /* 대변대체계정 */
    function fnConfigAuthCrAcctPopUp( param ) {
        $('#txtConfigAuthCrAcctCode').val(param.obj.acctCode || '');
        $('#txtConfigAuthCrAcctName').val(param.obj.acctName || '');
        focus_fnSetNextFocus();
        return;
    }
    /* 부가세대체계정 */
    function fnConfigAuthVatAcctPopUp( param ) {
        $('#txtConfigAuthVatAcctCode').val(param.obj.acctCode || '');
        $('#txtConfigAuthVatAcctName').val(param.obj.acctName || '');
        focus_fnSetNextFocus();
        return;
    }
    /* ERP증빙설정 */
    function fnConfigAuthErpAuthPopUp( param ) {
        $('#txtConfigAuthErpAuthCode').val(param.obj.ctdCode);
        $('#txtConfigAuthErpAuthName').val(param.obj.ctdName);
        focus_fnSetNextFocus();
        return;
    }
    /* 불공제구분 */
    function fnConfigAuthNoTaxPopUp( param ) {
        $('#txtConfigAuthNotaxCode').val(param.obj.noTaxCode);
        $('#txtConfigAuthNotaxName').val(param.obj.noTaxName);
        focus_fnSetNextFocus();
        return;
    }
    /* 사유구분(ICUBE) */
    function fnConfigAuthVaPopUp( param ) {
        $('#txtConfigAuthVaCode').val(param.obj.vaTypeCode);
        $('#txtConfigAuthVaName').val(param.obj.vaTypeName);
        return;
    }
    /* 행성택 이벤트 */
    function fnConfigAuthEventSelect_Row( data ) {
        /* 초기화 */
        fnConfigAuthNew();
        /* 선택값 바인딩 */
        $('#txtConfigAuthCode').attr('disabled', 'disabled');
        $('#txtConfigAuthCode').val(data.authCode); /* 증빙코드 */
        $('#txtConfigAuthName').val(data.authName); /* 증빙유형 */
        $('#txtConfigAuthOrderNum').val(data.orderNum); /* 정렬순서 */
        $('#txtConfigAuthVatTypeCode').val(data.vatTypeCode); /* 부가세구분 코드 */
        $('#txtConfigAuthVatTypeName').val(data.vatTypeName); /* 부가세구분 명칭 */
        $('#txtConfigAuthCrAcctCode').val(data.crAcctCode); /* 대변대체계정 코드 */
        $('#txtConfigAuthCrAcctName').val(data.crAcctName); /* 대변대체계정 명칭 */
        $('#txtConfigAuthVatAcctCode').val(data.vatAcctCode); /* 부가세대체계정 코드 */
        $('#txtConfigAuthVatAcctName').val(data.vatAcctName); /* 부가세대체계정 명칭 */
        if(expendInfo.ifSystem === 'iCUBE'){
        	// iCUBE 부가세 타입 불공으로 선택 한 경우는 사유구분 입력 팝업 표시
   	        switch (data.vatTypeCode) {
   				case '23':
   				case '24':
   				case '26':
   					$(".ERPElement, .iCUBEVat").show();
   					$(".ERPiUVat").hide();
   					$("#txtConfigAuthVaCode").val(data.vaTypeCode);
   					$("#txtConfigAuthVaName").val(data.vaTypeName);
   					break;
   				default:
   					$("#txtConfigAuthVaCode").val('');
					$("#txtConfigAuthVaName").val('');
   					$(".iCUBEVat, .ERPElement").hide();
   					break;
   			}
        	if(data.vatTypeCode != ''){
        		$('#configAuthVat').show();
        	}else{
        		$('#configAuthVat').hide();
        	}
        }else if(expendInfo.ifSystem === 'ERPiU'){
        	// ERPiU 부가세 타입 불공으로 선택 한 경우는 불공제구분 입력 팝업 표시
        	switch (data.vatTypeCode) {
				case '21':
	        	case '22':
	        	case '24':
	        	case '31':
	        	case '38':
	        	case '43':
	        	case '50':
	        		// 부가세 대체계정 필수 입력
	        		$("#configAuthVat").show();
	        		// 불공인 경우 불공제구분 입력란 활성화
					if(data.vatTypeCode === '22' || data.vatTypeCode === '50'){
						$(".ERPElement, .ERPiUVat").show();
						$(".iCUBEVat").hide();
						$("#txtConfigAuthNotaxCode").val(data.vaTypeCode);
						$("#txtConfigAuthNotaxName").val(data.vaTypeName);
					}else{
						$(".ERPiUVat, .ERPElement").hide();	
					}
					break;
				default:
					$("#txtConfigAuthNotaxCode").val('');
					$("#txtConfigAuthNotaxName").val('');
					$(".ERPiUVat, .ERPElement").hide();
					break;
			}
        }
        if (data.noteRequiredYN == 'Y') { /* 필수입력 설정 ( 적요 ) */
            $('#chkConfigAuthNoteReq').prop('checked', true);
        } else {
            $('#chkConfigAuthNoteReq').prop('checked', false);
        }
        if (data.authRequiredYN == 'Y') { /* 필수입력 설정 ( 증빙일자 ) */
            $('#chkConfigAuthAuthReq').prop('checked', true);
        } else {
            $('#chkConfigAuthAuthReq').prop('checked', false);
        }
        if (data.cardRequiredYN == 'Y') { /* 필수입력 설정 ( 법인카드 ) */
            $('#chkConfigAuthCardReq').prop('checked', true);
        } else {
            $('#chkConfigAuthCardReq').prop('checked', false);
        }
        if (data.partnerRequiredYN == 'Y') { /* 필수입력 설정 ( 거래처 ) */
            $('#chkConfigAuthPartnerReq').prop('checked', true);
        } else {
            $('#chkConfigAuthPartnerReq').prop('checked', false);
        }
        if (data.projectRequiredYN == 'Y') { /* 필수입력 설정 ( 프로젝트 ) */
            $('#chkConfigAuthProjectReq').prop('checked', true);
        } else {
            $('#chkConfigAuthProjectReq').prop('checked', false);
        }
        // var cashType = $('#selConfigAuthCashType').data('kendoComboBox'); /* 현금영수증구분 */
        // cashType.value(data.cashType)
        var useYN = $('#selConfigAuthUseYN').data('kendoComboBox'); /* 사용여부 */
        useYN.value(data.useYN)
        $('#txtConfigAuthErpAuthCode').val(data.erpAuthCode); /* ERP증빙설정 코드 */
        $('#txtConfigAuthErpAuthName').val(data.erpAuthName); /* ERP증빙설정 명칭 */
        $('#txtConfigAuthNotaxCode').val(data.noTaxCode); /* 사유구분 코드 / 불공제구분 코드 */
        $('#txtConfigAuthNotaxName').val(data.noTaxName); /* 사유구분 명칭 / 불공제구분 명칭 */
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
    
    /* ERP 관련 항목 초기화 */
    function fnInitErpElement(){
    	$('#txtConfigAuthVaCode').val(''); /* 사유구분 코드 */
        $('#txtConfigAuthVaName').val(''); /* 사유구분 명칭 */
        $('#txtConfigAuthNotaxCode').val(''); /* 불공제구분 코드 */
        $('#txtConfigAuthNotaxName').val(''); /* 불공제구분 명칭 */
        $(".ERPElement, .ERPiUVat, .iCUBEVat, #configAuthVat").hide();
    }
    
    /* [ 서버 호출 ] 표준적요 엑셀 다운로드 */
    function fnAtuhExcelDownload(){
    	var param = {};
    	
    	
    	param.fileName = "증빙유형";
		$("#fileName").val( param.fileName );
		param.listData = JSON.stringify(listData);
		$("#listData").val( param.listData );
		param.compSeq = '${ViewBag.empInfo.compSeq}';
		$("#compSeq").val( param.compSeq );
		param.codeType = 'AUTH';
		$("#codeType").val( param.codeType );
		param.searchStr = '';
		$("#searchStr").val( param.searchStr );
		
		
		/* Excel 헤더 정의 */
		var excelHeader = {};
		excelHeader.authCode = "증빙유형코드";
		excelHeader.authName = "증빙유형명";
		excelHeader.vatTypeCode = "부가세구분코드";
		excelHeader.vatTypeName = "부가세구분명";
		excelHeader.crAcctCode = "대변계정과목코드";
		excelHeader.crAcctName = "대변계정과목명";
		excelHeader.vatAcctCode = "부가세계졍과목코드";
		excelHeader.vatAcctName = "부가세계정과목명";
		
		param.excelHeader = JSON.stringify(excelHeader);
		$("#excelHeader").val( param.excelHeader );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
    }
</script>

<form id="excelDownload" name="excel" method="post">
	 <input type="hidden" name="excelHeader" value="" id="excelHeader" /> 
	 <input type="hidden" name="fileName" value="" id="fileName"/>
	 <input type="hidden" name="compSeq" value="" id="compSeq"/>
	 <input type="hidden" name="codeType" value="" id="codeType"/>
	 <input type="hidden" name="searchStr" value="" id="searchStr"/>
</form>


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
	<div class="top_box">
		<dl>
			<dt>${CL.ex_keyWord}</dt> <!-- 검색어 -->		
			<dd>
				<div class="controll_btn p0">
					<input id="txtSearchStr" type="text" style="width: 200px;" />
					<button id="btnConfigAuthSearch" class="btn_sc_add">${CL.ex_search}</button>
		        </div>
			</dd>
		</dl>
	</div>
	<div id="" class="controll_btn">
		<button id="btnConfigAuthExcelDownload" class="k-button"><%=BizboxAMessage.getMessage("TX000009553","엑셀다운로드")%></button>
		<button id="btnConfigAuthSearch" class="k-button" style="display: none;"><%=BizboxAMessage.getMessage("TX000000047","회사")%></button>
		<button id="btnConfigAuthNew" class="k-button"><%=BizboxAMessage.getMessage("TX000003101","신규")%></button>
		<button id="btnConfigAuthSave" class="k-button">${CL.ex_save}</button> <!-- 저장 -->
		<button id="btnConfigAuthDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424","삭제")%></button>	
	</div>
	
	<div class="twinbox"> 
		<table>
			<colgroup>
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<tr>
				<td class="twinbox_td">
					<!-- 리스트 -->
					<div id="divConfigAuthList" class="com_ta2">
						<table id="tblConfigAuthList">
						</table>
					</div>
				</td>
				<td class="twinbox_td">
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="140" />
								<col width="" />
								<col width="140" />
								<col width="" />
							</colgroup>
							<tr>
								<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> ${CL.ex_evidenceType} <!-- 증빙유형  --> &nbsp;${CL.ex_code} <!-- 코드 -->
								</th>
								<td>
									<input id="txtConfigAuthCode" type="text" style="width: 66%" class="txt_reset" />
								</td>
							</tr>
							<tr>
								<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> ${CL.ex_evidenceType} <!-- 증빙유형  --> &nbsp; ${CL.ex_name} <!-- 명칭 --> 
								</th>
								<td>
									<input id="txtConfigAuthName" type="text" style="width: 66%" class="txt_reset" />
								</td>
							</tr>
							<tr>
								<th>${CL.ex_sortOrder}</th> <!-- 정렬순서 -->
								<td>
									<input id="txtConfigAuthOrderNum" type="text" style="width: 19%" class="txt_reset" />
								</td>
							</tr>
							<tr>
								<th>${CL.ex_classificationTax} <!-- 부가세 구분 -->(${CL.ex_divisionBusiness}) <!-- 세무구분 --></th>
								<td>
									<input id="txtConfigAuthVatTypeCode" type="text" style="width: 19%" class="txt_reset" readonly/> <input id="txtConfigAuthVatTypeName" type="text" style="width: 46%" class="txt_reset" />
									<div class="controll_btn p0">
										<button id="btnConfigAuthVatTypePopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
										<button class="reload_btn"></button>
									</div>
								</td>
							</tr>
							<tr>
								<th>${CL.ex_creditTransferAccount}</br> <!-- 대변대체계정 -->
								(${CL.ex_code}/${CL.ex_name})</th>
								<td>
									<input id="txtConfigAuthCrAcctCode" type="text" style="width: 19%" class="txt_reset" readonly/> <input id="txtConfigAuthCrAcctName" type="text" style="width: 46%" class="txt_reset" />
									<div class="controll_btn p0">
										<button id="btnConfigAuthCrAcctPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
										<button class="reload_btn"></button>
									</div>
								</td>
							</tr>
							<tr>
								<th>
								<img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id="configAuthVat" style="display: none;"/>
								${CL.ex_vatTransferAccount}</br>
								(${CL.ex_code}/${CL.ex_name})</th>
								<td>
									<input id="txtConfigAuthVatAcctCode" type="text" style="width: 19%" class="txt_reset" readonly/> <input id="txtConfigAuthVatAcctName" type="text" style="width: 46%" class="txt_reset" />
									<div class="controll_btn p0">
										<button id="btnConfigAuthVatAcctPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
										<button class="reload_btn"></button>
									</div>
								</td>
							</tr>
							<tr>
								<th>${CL.ex_essentialItem}</th>
								<td>
									<ul class="check_ul">
										<li><input type="checkbox" name="mf" id="chkConfigAuthNoteReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthNoteReq">${CL.ex_note}</label></li>
										<li><input type="checkbox" name="mf" id="chkConfigAuthAuthReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthAuthReq">${CL.ex_requiredDate}</label></li>
										<li><input type="checkbox" name="mf" id="chkConfigAuthCardReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthCardReq">${CL.ex_essentialCard}</label></li>
										<li><input type="checkbox" name="mf" id="chkConfigAuthPartnerReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthPartnerReq">${CL.ex_essentialVendor}</label></li>
										<li><input type="checkbox" name="mf" id="chkConfigAuthProjectReq" class="k-checkbox" /> <label class="k-checkbox-label radioSel" for="chkConfigAuthProjectReq">${CL.ex_essentialProject}</label></li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>${CL.ex_inUseYN}</th>
								<td>
									<input type="text" id="selConfigAuthUseYN" class="kendoComboBox" />
								</td>
							</tr>
							<tr style="display: none;">
								<th><%=BizboxAMessage.getMessage("TX000005736","현금영수증구분")%></th>
								<td>
									<input type="text" id="selConfigAuthCashType" class="kendoComboBox" />
								</td>
							</tr>
							<tr style="display: none;" class="ERPElement ERPAuth">
								<th class="ERPiUVat"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id='NoTax'/>
								${CL.ex_noType}(ERPiU)</th>
								<td class="ERPiUVat">
									<input id="txtConfigAuthNotaxCode" type="text" style="width: 19%" class="txt_reset" /> 
									<input id="txtConfigAuthNotaxName" type="text" style="width: 46%" class="txt_reset" />
									<div class="controll_btn p0">
										<button id="btnConfigAuthNotaxPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
										<button class="reload_btn"></button>
									</div>
								</td>
							</tr>
							<tr style="display: none;" class="ERPElement ERPAuth">
								<th class="iCUBEVat"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id='vatReason'/>
								${CL.ex_reasonType}(ICUBE)</th>
								<td class="iCUBEVat">
									<input id="txtConfigAuthVaCode" type="text" style="width: 19%" class="txt_reset" /> 
									<input id="txtConfigAuthVaName" type="text" style="width: 46%" class="txt_reset" />
									<div class="controll_btn p0">
										<button id="btnConfigAuthVaPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
										<button class="reload_btn"></button>
									</div>
								</td>
							</tr>
							<tr style="display: none;" class="ERPElement ERPAuth">
								<th class="ERPAuth">
									ERP증빙설정
								</th>
								<td class="ERPAuth">
									<input id="txtConfigAuthErpAuthCode" type="text" style="width: 19%;" class="txt_reset" /> 
									<input id="txtConfigAuthErpAuthName" type="text" style="width: 46%;" class="txt_reset" />
									<div class="controll_btn p0">
										<button id="btnConfigAuthErpAuthPopUp"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
										<button class="reload_btn"></button>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
<!-- //sub_contents_wrap -->