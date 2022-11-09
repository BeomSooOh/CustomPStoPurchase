	<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.focus.js"></c:url>'></script>


<script>
    /* 변수정의 */
    var ifSystem = '${ViewBag.ifSystem}';

    var baseUrl = '<c:url value="/" />'; /* 팝업 호출시 사용 */
    var searchCompSeq = ''; /* 팝업 호출시 사용 */
    
    //엑셀 테스트 
	var listData = {};

    /* 문서로드 */
    $(document).ready(function() {
        fnConfigSummaryInit();
        fnConfigSummaryInitEvent();
        fnConfigSummarySearch();
        $('#txtSearchStr').focus();
    });

    /* 초기화 */
    function fnConfigSummaryInit() {
        $('button').kendoButton(); /* 켄도버튼정의 */
        setComboBox($("#selSummaryType"), JSON.parse('${ViewBag.commonCodeListSummaryType}'), '');/* 적요 구분 */
        setComboBox($("#selSummaryTypeInput"), JSON.parse('${ViewBag.commonCodeListSummaryType}'), '');/* 적요 구분 입력 */

        var combobox = $("#selSummaryType").data("kendoComboBox");
        combobox.enable(false); /* 적요 구분 비활성화 */
        combobox = $("#selSummaryTypeInput").data("kendoComboBox");
        combobox.enable(false); /* 적요 구분 입력 비활성화 */
    }

    /* 이벤트 초기화 */
    function fnConfigSummaryInitEvent() {
        /* 변수정의 */
        var param = {};
        /* 이벤트 정의 */
        /* 이벤트 정의 - 검색 */
        $('#btnConfigSummarySearch').click(function() {
            fnConfigSummarySearch();
            $('#txtSearchStr').focus();
        });
        
        $('#btnConfigSummaryExcelDownload').click(function(){
        	fnSummaryExcelDownload();
        })
        
        /* 이벤트 정의 - 신규 */
        $('#btnConfigSummaryNew').click(function() {
            fnConfigSummaryNew();
            $('#txtSummaryCode').focus();
        });
        /* 이벤트 정의 - 저장 */
        $('#btnConfigSummarySave').click(function() {
            fnConfigSummarySave();
            $('#txtSummaryCode').focus();
        });
        /* 이벤트 정의 - 삭제 */
        $('#btnConfigSummaryDelete').click(function() {
            fnConfigSummaryDelete();
            $('#txtSearchStr').focus();
        });
        /* 부가세계정과목, 차변계정과목, 대변계정과목 */
        $('#btnConfigSummaryVatAcctPopup, #btnConfigSummaryDrAcctPopup, #btnConfigSummaryCrAcctPopup, #btnConfigSummaryErpAuthPopup').click(function() {
        	var type = this.id.toString().replace('btnConfigSummary', '').replace('Popup','');
			fnCommonCodePop(type, false);
        });

        /* 초기화 버튼클릭 이벤트 정의 */
        $('.reload_btn').click(function( event ) {
            /* 대상자 찾기 */
            var par = $(this).parent();
            var input = $(par).prevAll('.txt_reset');
            /* 초기화 진행 */
            $.each(input, function( idx, target ) {
                $(target).val('');
            });
        });
        
        $('#txtConfigSummaryOrderNum').keydown(function () {
        	this.value = this.value.replace(/[^0-9\.]/g,'');
        });
        
        /* 엔터키를 이용한 검색 */
        $("#txtSearchStr").keydown(function (event) {
            if (event.which === 13) {
                event.returnValue = false;
                event.cancelBubble = true;

                fnConfigSummarySearch();
            }
        });
        
        /* 엔터키를 이용한 검색 [공통 코드 팝업]*/
    	$('#txtVatAcctName, #txtDrAcctName, #txtCrAcctName').bind('keydown', function( event ) {
	        /* 엔터입력 이벤트 적용 */
	        if (event.which == 113) {
	        	var type = this.id.toString().replace('txt', '').replace('Name','');
	        	fnCommonCodePop(type, true);
	        }
	    });
        
        /* 이벤트 정의 - 엔터입력시 포커스 이동 jQuery.exp.expend.focus.js 참조 */
        focus_fnSetFocusEvent(
           		[
           		 'txtSummaryCode'
           		 , 'txtSummaryName'
           		 , 'txtDrAcctName'
           		 , 'txtCrAcctName'
           		]
         	);
        
        return;
    }
    
    /* 공통코드 조회 팝업  */
    function fnCommonCodePop(type, pressEnterYN){
		var callback = '';
		var searchStr = {};
		var acctType = '';
		
		switch(type){
		case "VatAcct" :
			type = 'Acct';
			callback = 'fnConfigSummaryVatAcctPopup';
			searchStr = ($("#txtVatAcctName").val() || '');
			acctType = 'VAT';
			break;
		case "DrAcct" : 
			type = 'Acct';
			callback = 'fnConfigSummaryDrAcctPopup';
			searchStr = ($("#txtDrAcctName").val() || '');
			acctType = 'DR';
			break;
		case "CrAcct" : 
			type = 'Acct';
			callback = 'fnConfigSummaryCrAcctPopup';
			searchStr = ($("#txtCrAcctName").val() || '');
			acctType = 'CR';
			break;
		case "ErpAuth" : 
			type = 'ErpAuth';
			callback = 'fnConfigSummaryErpAuthPopup';
			searchStr = ($("#txtErpAuthName").val() || '');
			acctType = 'ErpAuth';
			break;		
		}
		
		if(!pressEnterYN){
			searchStr = '';
		}
    	var Popresult = fnOpenCodePop({
    		codeType : type
    		, callback : callback
    		, searchStr : searchStr
    		, acct_type : (acctType || '')
    		, reflectResultPop : true
    	});
    }

    /* 버튼클릭 이벤트 - 검색 */
    function fnConfigSummarySearch() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeSummary);
        
        param.compSeq = '${ViewBag.empInfo.compSeq}';
        searchCompSeq = '${ViewBag.empInfo.compSeq}'; /* 팝업 호출시 사용 */
        param.codeType = 'SUMMARY'
//         param.summary_div = $('#selSummaryType').val(); // 현재는 A로 고정, 추후 매출결의 개발시 사용
        param.summaryDiv = 'A';
        param.searchStr = $('#txtSearchStr').val();
        param.formSeq = '';
        /* 서버 호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex/user/code/ExCodeInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
//                 ifSystem = (data.ifSystem || 'BizboxA');

                if (typeof data.result.aaData != 'undefined') {
                    /* 테이블 데이터 바인딩 */
                    fnConfigSummarySetTable(data.result.aaData);
                    /* 엑셀 list*/
                    listData = data.result.aaData;
                } else {
                    /* 테이블 데이터 바인딩 */
                    fnConfigSummarySetTable('');
                }
                /* 신규 버튼 클릭이벤트 발생 */
                fnConfigSummaryNew();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    var baseData = {};
    function fnConfigSummarySetTable( data ) {
    	baseData = data || {};
    	data = (data || '');
        $('#divSummaryList').empty();
        $('#divSummaryList').append('<table id="tblSummaryList"></table>');
        
        $('#tblSummaryList').dataTable({
        	"aaSorting": [],
            "fixedHeader" : true,
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
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                    fnConfigSummary_SelectRow(aData);
                }));
            },
            "columnDefs" : [ {
                "targets" : 2,
                "data" : null,
                "render" : function( aData ) {
                    if (aData.drAcctCode && aData.drAcctCode != '' && aData.drAcctName && aData.drAcctName != '') {
                        return aData.drAcctCode + ' / ' + aData.drAcctName
                    } else {
                        return '';
                    }
                }
            }, {
                "targets" : 3,
                "data" : null,
                "render" : function( aData ) {
                    if (aData.vatAcctCode && aData.vatAcctCode != '' && aData.vatAcctName && aData.vatAcctName != '') {
                        return aData.vatAcctCode + ' / ' + aData.vatAcctName
                    } else {
                        return '';
                    }
                }
            }, {
                "targets" : 4,
                "data" : null,
                "render" : function( aData ) {
                    if (aData.crAcctCode && aData.crAcctCode != '' && aData.crAcctName && aData.crAcctName != '') {
                        return aData.crAcctCode + ' / ' + aData.crAcctName
                    } else {
                        return '';
                    }
                }
            } ],
            "aoColumns" : [ {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000344","적요 코드")%>",
                "mDataProp" : "summaryCode",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "10%"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000017131","적요 명칭")%>",
                "mDataProp" : "summaryName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "td_le"
            }, {
                "sTitle" : "${CL.ex_debitTitle}" + "(" 
           		+ "${CL.ex_code}" + "/" 
           		+ "${CL.ex_name}" + ")",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "20%",
                "sClass" : "td_le"
            }, {
            	
                "sTitle" : "${CL.ex_vatTitle}" + "(" 
           		+ "${CL.ex_code}" + "/" 
           		+ "${CL.ex_name}" + ")",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "20%",
                "sClass" : "td_le"
            }, {
                "sTitle" : "${CL.ex_creditAccount}" + "(" 
           		+ "${CL.ex_code}" + "/" 
           		+ "${CL.ex_name}" + ")",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "20%",
                "sClass" : "td_le"
            }, ]
        });
    }

    /* 버튼클릭 이벤트 - 신규 */
    function fnConfigSummaryNew() {
        /* 초기화 */
        $('#txtSummaryCode').val(''); /* 적요코드 초기화 */
        $('#txtSummaryName').val(''); /* 적요명 초기화 */
        $('#txtDrAcctCode').val(''); /* 차변계정과목 초기화 */
        $('#txtDrAcctName').val(''); /* 차변계정과목 초기화 */
        $('#txtCrAcctCode').val(''); /* 대변계정과목 초기화 */
        $('#txtCrAcctName').val(''); /* 대변계정과목 초기화 */
        $('#txtVatAcctCode').val(''); /* 부가세계정과목 초기화 */
        $('#txtVatAcctName').val(''); /* 부가세계정과목 초기화 */
        $('#txtErpAuthCode').val(''); /* ERP증빙 초기화 */
        $('#txtErpAuthName').val(''); /* ERP증빙 초기화 */
        /* 비활성화 해제 */
        $('#txtSummaryCode').removeAttr('disabled'); /* 적요코드 */
        $('#txtSummaryOrderNum').val(''); /* 정렬순서 초기화 */
       
        return;
    }

    /* 버튼클릭 이벤트 - 저장 */
    function fnConfigSummarySave() {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeSummary);
        
        param.compSeq = '${ViewBag.empInfo.compSeq}';
        
        param.summaryCode = $('#txtSummaryCode').val().trim();
        param.summaryName = $('#txtSummaryName').val();
//         param.summary_div = $('#selSummaryTypeInput').val();// 현재는 A로 고정, 추후 매출결의 개발시 사용
        param.summaryDiv = 'A';
        param.drAcctCode = $('#txtDrAcctCode').val();
        param.drAcctName = $('#txtDrAcctName').val();
        param.crAcctCode = $('#txtCrAcctCode').val();
        param.crAcctName = $('#txtCrAcctName').val();
        param.vatAcctCode = $('#txtVatAcctCode').val();
        param.vatAcctName = $('#txtVatAcctName').val();
        param.orderNum = $('#txtSummaryOrderNum').val();
        param.erpAuthCode = $('#txtErpAuthCode').val();
        param.erpAuthName = $('#txtErpAuthName').val();
        param.formSeq = '';
        if(fnValidateSaveData(param) == -1){
        	return;
        }
        /* 호출 URL 지정 */
        var url = '';
        var attr = $('#txtSummaryCode').attr('disabled');
        if (typeof attr !== typeof undefined && attr !== false) {
            url = '<c:url value="/ex/master/config/SummaryInfoUpdate.do" />';
        } else {
            url = '<c:url value="/ex/master/config/SummaryInfoInsert.do" />';
        }
        /* 서버 호출 */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 조회버튼 클릭 */
                fnConfigSummarySearch();
                alert("<%=BizboxAMessage.getMessage("TX000002073","저장되었습니다.")%>");
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 파라미터 검증 */
    function fnValidateSaveData(param){
    	
    	var base = JSON.stringify(baseData);
    	if(!param.summaryCode){
    		alert("<%=BizboxAMessage.getMessage("TX000018754","적요코드를 입력하여 주십시오")%>"); 
    		return -1;
    	}if(!param.summaryName){
    		alert("<%=BizboxAMessage.getMessage("TX000018755","적요명칭을 입력하여 주십시오")%>"); 
    		return -1;
    	}if( (!$('#txtSummaryCode:disabled').length) &&  base.indexOf('"summaryCode":"'+param.summaryCode+'"') > -1){
    		alert("<%=BizboxAMessage.getMessage("TX000003523","입력하신 적요코드가 이미 등록되어있습니다. 적요코드를 다시 입력하여 주십시오")%>");
    		return -1;
    	}if(!param.drAcctCode){
    		alert("<%=BizboxAMessage.getMessage("TX000003521","차변계정과목을 입력하여 주십시오")%>");
    		return -1;
    	}if(!param.crAcctCode){
    		alert("<%=BizboxAMessage.getMessage("TX000003522","대변계정과목을 입력하여 주십시오")%>");
    		return -1;
    	}
    	return 0;
    }
    
    
    /* 버튼클릭 이벤트 - 삭제 */
    function fnConfigSummaryDelete() {
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000015635","정말 삭제하시겠습니까 ?")%>")){
    		return;
    	}
    	
        var param = {};
        $.extend(param, ExCodeSummary);
        
        param.compSeq = '${ViewBag.empInfo.compSeq}';
        
        param.summaryCode = $('#txtSummaryCode').val();
//         param.summary_div = $('#selSummaryTypeInput').val();// 현재는 A로 고정, 추후 매출결의 개발시 사용
        param.summaryDiv = 'A';
        param.formSeq = '';
        /* 서버 호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/master/config/SummaryInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 조회버튼 클릭 */
                fnConfigSummarySearch();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 버튼클릭 이벤트 - 엑셀업로드 */
    function fnConfigSummaryExcelUpload() {
        alert("<%=BizboxAMessage.getMessage("TX000009615","서비스 준비중입니다")%>" + '..');
        return;
    }

    /* 버튼클릭 이벤트 - 엑셀다운로드 */
    function fnConfigSummaryExcelDownload() {
    	alert("<%=BizboxAMessage.getMessage("TX000009615","서비스 준비중입니다")%>" + '..');
        return;
    }

    /* 버튼클릭 이벤트 - 차변계정과목 */
    function fnConfigSummaryDrAcctPopup( param ) {
		$('#txtDrAcctCode').val(param.obj.acctCode || '');
		$('#txtDrAcctName').val(param.obj.acctName || '');
		focus_fnSetNextFocus();
        return;
    }

    /* 버튼클릭 이벤트 - 대변계정과목 */
    function fnConfigSummaryCrAcctPopup( param ) {
        $('#txtCrAcctCode').val(param.obj.acctCode || '');
        $('#txtCrAcctName').val(param.obj.acctName || '');
        focus_fnSetNextFocus();
        return;
    }

    /* 버튼클릭 이벤트 - 부가세계정과목 */
    function fnConfigSummaryVatAcctPopup( param ) {
        $('#txtVatAcctCode').val(param.obj.acctCode || '');
        $('#txtVatAcctName').val(param.obj.acctName || '');
        focus_fnSetNextFocus();
        return;
    }
    
    /* 버튼클릭 이벤트 - iCUBE 증빙 */
    function fnConfigSummaryErpAuthPopup( param ) {
        $('#txtErpAuthCode').val(param.obj.ctdCode || '');
        $('#txtErpAuthName').val(param.obj.ctdName || '');
        focus_fnSetNextFocus();
        return;
    }

    /* 행클릭 이벤트 */
    function fnConfigSummary_SelectRow( data ) {
        /* 선택값 적용 */
        $('#txtSummaryCode').val(data.summaryCode); /* 적요코드 */
        $('#txtSummaryName').val(data.summaryName); /* 적요명 */
        $('#txtDrAcctCode').val(data.drAcctCode); /* 차변계정과목 */
        $('#txtDrAcctName').val(data.drAcctName); /* 차변계정과목 */
        $('#txtCrAcctCode').val(data.crAcctCode); /* 대변계정과목 */
        $('#txtCrAcctName').val(data.crAcctName); /* 대변계정과목 */
        $('#txtVatAcctCode').val(data.vatAcctCode); /* 부가세계정과목 */
        $('#txtVatAcctName').val(data.vatAcctName); /* 부가세계정과목 */
        $('#txtErpAuthCode').val(data.erpAuthCode); /* iCUBE증빙 */
        $('#txtErpAuthName').val(data.erpAuthName); /* iCUBE증빙 */
        /* 비활성화 처리 */
        $('#txtSummaryCode').attr('disabled', 'disabled');
        $('#txtSummaryOrderNum').val(data.orderNum); /* 정렬순서 */
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
    
    /* [ 서버 호출 ] 표준적요 엑셀 다운로드 */
    function fnSummaryExcelDownload(){
    	var param = {};
    	
    	param.fileName = "표준적요";
		$("#fileName").val( param.fileName );
		param.listData = JSON.stringify(listData);
		$("#listData").val( param.listData );
		param.compSeq = '${ViewBag.empInfo.compSeq}';
		$("#compSeq").val( param.compSeq );
		param.codeType = 'SUMMARY';
		$("#codeType").val( param.codeType );
		param.searchStr = '';
		$("#searchStr").val( param.searchStr );
		
		/* Excel 헤더 정의 */
		var excelHeader = {};
		excelHeader.summaryCode = "표준적요코드";
		excelHeader.summaryName = "표준적요명";
		excelHeader.drAcctCode = "차변계졍과목코드";
		excelHeader.drAcctName = "차변계정과목명";
		excelHeader.vatAcctCode = "부가세계졍과목코드";
		excelHeader.vatAcctName = "부가세계정과목명";
		excelHeader.crAcctCode = "대변계정과목코드";
		excelHeader.crAcctName = "대변계정과목명";
		
		param.excelHeader = JSON.stringify(excelHeader);
		$("#excelHeader").val( param.excelHeader );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
    	
    }
    
</script>

<style type="text/css">

	.no-footer.fixedHeader-floating{
		display:none;
	}

</style>

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
	<div class="top_box">
		<dl>
			<dt style="display: none;">${CL.ex_division}</dt>
			<dd style="display: none;">
				<input type="text" id="selSummaryType" class="kendoComboBox" style="width: 100px;" />
			</dd>
			<dt>${CL.ex_keyWord}</dt>
			<dd>
				<div class="controll_btn p0">
					<input id="txtSearchStr" type="text" style="width: 200px;" /> 
					<button id="btnConfigSummarySearch" class="btn_sc_add">${CL.ex_search}</button>
				</div>
			</dd>
		</dl>
	</div>
	<div id="" class="controll_btn">
		<button id="btnConfigSummaryExcelDownload" class="k-button"><%=BizboxAMessage.getMessage("TX000009553","엑셀다운로드")%></button>
		<button id="btnConfigSummaryNew" class="k-button"><%=BizboxAMessage.getMessage("TX000003101","신규")%></button>
		<button id="btnConfigSummarySave" class="k-button">${CL.ex_save}</button>
		<button id="btnConfigSummaryDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424","삭제")%></button>
		<button id="btnConfigSummaryExcelUpload" class="k-button" style="display: none;"><%=BizboxAMessage.getMessage("TX000003519","엑셀업로드")%></button>
	</div>
	
	<div class="twinbox" >
	<table>
		<colgroup>
			<col style="width:50%;">
		</colgroup>
	<tr>
		<td class="twinbox_td">
			<div id=divSummaryList " class="com_ta2" style="height: auto;">
				<table id="tblSummaryList">
				</table>
			</div> 	
	</td>
	
	<td class="twinbox_td" style="width: 350px;" > 

		<div class="com_ta">
		<table>
			<colgroup>
				<col width="140"/>
				<col width="" />
				<col width="140" />
				<col width="" />
			</colgroup>
			<tr>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000000344","적요 코드")%></th>
				<td>
					<input id="txtSummaryCode" type="text" style="width: 66%" class="txt_reset" />
				</td>
				
			</tr>
			
			<tr>
			<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage("TX000017131","적요 명칭")%></th>
				<td>
					<input id="txtSummaryName" type="text" style="width: 66%" class="txt_reset" />
				</td>
			</tr>
				
			<tr>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> ${CL.ex_division}</th>
					<td style="display: none;">
						<input id="selSummaryTypeInput" style="display: none; width: 45%;" />
					</td>
					<td>
						<span><%=BizboxAMessage.getMessage("TX000018760","지출결의")%></span>
					</td>
			
			</tr>
			<tr>
			<th>${CL.ex_vatTitle}</th>
					<td>
						<input id="txtVatAcctCode" type="text" style="width: 19%" class="txt_reset txt_readonly" readonly/> 
						<input id="txtVatAcctName" type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnConfigSummaryVatAcctPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr>
			
			<tr>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> ${CL.ex_debitTitle}</th>
				<td>
					<input id="txtDrAcctCode" type="text" style="width: 19%" class="txt_reset txt_readonly" readonly/> 
					<input id="txtDrAcctName" type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnConfigSummaryDrAcctPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>			
			</tr>		
			<tr>
			<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />${CL.ex_creditAccount}</th>
				<td>
					<input id="txtCrAcctCode" type="text" style="width: 19%" class="txt_reset txt_readonly" readonly/> 
					<input id="txtCrAcctName" type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnConfigSummaryCrAcctPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
						<button class="reload_btn"></button>
					</div>
				</td>
			</tr>
			<tr>
				<th>${CL.ex_sortOrder}</th>
				<td>
					<input id="txtSummaryOrderNum" type="text" style="width: 19%" class="txt_reset" />
				</td>
				</tr>		
				<tr>
				<th class="ERPAuth">ERP증빙</th>
				<td class="ERPAuth">
					<input id="txtErpAuthCode" type="text" style="width: 19%" class="txt_reset txt_readonly" readonly/> 
					<input id="txtErpAuthName" type="text" style="width: 46%" class="txt_reset txt_readonly" />
					<div class="controll_btn p0">
						<button id="btnConfigSummaryErpAuthPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
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
<div id="loadingProgressBar"></div>