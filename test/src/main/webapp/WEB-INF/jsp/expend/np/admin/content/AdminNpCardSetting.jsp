<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%-- <%@ include file="/WEB-INF/jsp/ea/include/includeCmmOrgPop.jsp"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/jquery.mask.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCodePop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.focus.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<script>
	/* ???????????? */
	var ifSystem = '${ViewBag.erpTypeCode}';
	var baseUrl = '<c:url value="/" />'; /* ?????? ????????? ?????? */
	var searchCompSeq = ''; /* ?????? ????????? ?????? */
	var empInfo = {
	    erpEmpSeq : "${ViewBag.empInfo.erpEmpSeq}",
	    langCode : "${ViewBag.empInfo.langCode}",
	    erpCompSeq : "${ViewBag.empInfo.erpCompSeq}",
	    groupSeq : "${ViewBag.empInfo.groupSeq}",
	    empSeq : "${ViewBag.empInfo.empSeq}",
	    compSeq : "${ViewBag.empInfo.compSeq}",
	    userSe : "${ViewBag.empInfo.userSe}",
	    deptSeq : "${ViewBag.empInfo.deptSeq}",
	    bizSeq : "${ViewBag.empInfo.bizSeq}"
	};
	
    /* ???????????? */
    $(document).ready(function() {
        fnConfigCardInit();
        fnConfigCardInitEvent();
        $('#btnConfigCardSearch').click();
        if(ifSystem != 'ERPiU'){
        	$('.ERPiU').hide();	
        }
    });
    
    /* ????????? */
    function fnConfigCardInit() {
    	
        $('#devMode_forCmPop').val(empInfo.groupSeq);
        $('#langCode_forCmPop').val(empInfo.langCode);
        $('#groupSeq_forCmPop').val(empInfo.groupSeq);
        $('#compSeq_forCmPop').val(empInfo.compSeq);
        $('#deptSeq_forCmPop').val(empInfo.deptSeq);
        $('#empSeq_forCmPop').val(empInfo.empSeq);
        
        $('#compFilter_forCmPop').val("${ViewBag.empInfo.compSeq}");
        $('#selectedItems_forCmPop').val("");
		
        /* ?????? ????????? ?????? ????????? ?????? ?????? */
    	if(ifSystem == 'BizboxA'){
    		// ??????????????? ?????? 
            /* ERP?????? ???????????? ?????? ????????? */
            $('#btnConfigCardFromErp').hide();
    	}
    	else if(ifSystem == 'iCUBE'){
    		// iCUEBE??? ??????.
    		$("#txtCardName").css("border", "none");
    		$("#txtCardNum").css("border", "none");
    		$("#trBank").hide();
 
            /* ERP?????? ???????????? ?????? ?????? */
            $('#btnConfigCardFromErp').show();
    	} else if(ifSystem == 'ERPiU'){
    		// ERPiU??? ??????. 
    		$("#txtCardName").css("border", "none");
    		$("#txtCardNum").css("border", "none");
            
            /* ERP?????? ???????????? ?????? ?????? */
            $('#btnConfigCardFromErp').show();
    	}else{
    		// ?????? ???????????? ??????
    	}
        
        // ?????? ?????? ????????? ?????? ?????? 
        $('#searchCardName').focus();
        return;
    }

    /* ????????? ????????? */
    function fnConfigCardInitEvent() {
        /* ???????????? */
        var param = {};
        /* ????????? ?????? */
        /* ????????? ?????? - ERP???????????? */
        $('#btnConfigCardFromErp').click(function() {
            fnConfigCardFromErp();
            return;
        });
        
        /* ????????? ?????? - ?????? ????????????*/
        $('#txtSearchStr').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#btnConfigCardSearch').click();
            }
        });
        
        /* ????????? ?????? - ?????? */
        $('#btnConfigCardSearch').click(function() {
            fnConfigCardSearch();
            return;
        });
        /* ????????? ?????? - ?????? */
        $('#btnConfigCardNew').click(function() {
            fnConfigCardNew();
            $('#txtCardName').focus();
            return;
        });
        /* ????????? ?????? - ?????? */
        $('#btnConfigCardSave').click(function() {
            fnConfigCardSave();
            return;
        });
        /* ????????? ?????? - ?????? */
        $('#btnConfigCardDelete').click(function() {
            fnConfigCardDelete();
            return;
        });
        /* ????????? ?????? - ???????????? */
        $('#btnOrgChart').click(function() {

            var url = "<c:url value='/gw/systemx/orgChart.do'/>";
            var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");

            frmPop2.target = "cmmOrgPop";
            frmPop2.method = "post";
            frmPop2.action = url.replace("/exp", "");
            frmPop2.submit();
            frmPop2.target = "";
            pop.focus();
            return;
        });
        /* ????????? ?????? - ??????????????? */
        $('#btnPartnerPop').click(function() {
            fnConfigCardPartnerPop();
            return;
        });
        /* ????????? ?????? - ???????????? ????????? */
        $('#btnPublicReload').click(function(event){
        	fnCardPublicReload();
        })
        
        /* ???????????? ????????? ????????? ?????? - ???????????? ?????? ????????? ?????? */
        $('#txtCardPublic').focus(function(){
        	if(!$('#txtCardPublic').val()){
        		$('#btnOrgChart').click();	
        	}
        });
        
        /* ????????? ?????? - ??????????????? ????????? ?????? jQuery.exp.expend.focus.js ?????? */
        focus_fnSetFocusEvent(
       		['txtCardName', 'txtCardNum', 'cardPublic']
       		, fnConfigCardSave
     	);
        return;
    }

    /* ???????????? ????????? - ???????????? ????????? */
    function fnCardPublicReload(param){
        $('#selectedItems_forCmPop').val('');
        $('#hidCardPublic').val('');
        $('#txtCardPublic').val('');
    }
    
    /* ???????????? ????????? - ?????? */
    var autoSync = false;
    function fnConfigCardSearch( param ) {
        /* ???????????? */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        searchCompSeq = "${ViewBag.empInfo.compSeq}"; /* ?????? ????????? ?????? */
        param.codeType = "CARD";
        param.searchType = 'IN';
        param.useYN = $("#selUseYN").val();
		param.searchCardName = ($("#searchCardName").val() || '');
		param.searchCardNum = ($("#searchCardNum").val() || '');
		param.searchPartnerCode = ($("#searchPartnerCode").val() || '');
		param.searchPartnerName = ($("#searchPartnerName").val() || '');
		param.selPublic = ($("#selPublic").val() || '');
		param.eaType = 'ea';
		
        /* ???????????? */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	console.log(data);
            	if(!data.result.aaData.length && !autoSync && ifSystem != 'BizboxA'){
            		// ????????? ?????? ?????? ?????? ?????? ??????
           			$('#btnConfigCardFromErp').click();
            	}else{
	                if (typeof data.result.aaData != 'undefined') {
	                    /* ????????? ????????? ????????? */
	                    fnConfigCardSetTable(data.result.aaData);
	                } else {
	                    /* ????????? ????????? ????????? */
	                    fnConfigCardSetTable('');
	                }
	                /* ?????? ?????? ??????????????? ?????? */
	                $('#btnConfigCardNew').click();
	                
	                /* ????????? ?????? ????????? ?????? */
	                if($('#txtCardName').val()){
	                	$('#txtCardName').focus();
	                	isSearchFlag = false;
	                }
	                
	                $('#cardCount').html(data.result.aaData.length);
	                
            	}
            	
            	autoSync = true;
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* ????????? ????????? ????????? */
    function fnConfigCardSetTable( data ) {
        data = (data || '');
        $('#divConfigCardList').empty();
        $('#divConfigCardList').append('<table id="tblConfigCardList"></table>');

        $('#tblConfigCardList').DataTable({
            "select" : true,
            "paging" : false,
            "bAutoWidth" : false,
            "destroy" : true,
            "sScrollY" : '350px',
            'bSort' : true,
            "language" : {
                "lengthMenu" : "?????? _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
                "infoFiltered" : "(?????? _MAX_ ???.)"
            },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                    fnConfigCardSelectRow(aData);
                }));
            },
            /* { "targets" : 0, "data" : null, "render" : function( aData ) { if (aData != null && aData != "") { return "<input type='checkbox' id='chkSel' name='chkSel' value='" + aData.compSeq + "|" + aData.cardNum + "'/>"; } else { return ""; } } }, */
            columnDefs : [ {
                "targets" : 2,
                "data" : null,
                "render" : function( aData ) {
                    if ((aData.partnerCode || '') != '' && (aData.partnerName || '') != '') {
                        return '[' + (aData.partnerCode || '') + '] ' + (aData.partnerName || '');
                    } else {
                        return '';
                    }
                }
            }, {
                "targets" : 3,
                "data" : null,
                "render" : function( aData ) {
                    if (aData != null && aData != "") {
                        var useLabel = "";
                        if (aData.useYN == "0" || aData.useYN == "N") {
                        	useLabel = "<%=BizboxAMessage.getMessage("TX000001243","?????????")%>";

                        } else {
                        	useLabel = "<%=BizboxAMessage.getMessage("TX000000180","??????")%>";

                        }
                        return useLabel;

                    } else {
                        return "";
                    }
                }
            }, {
            	"targets" : 4
            	, "data" : null
	           	, "render" : function (aData){
    				var data = '' + (aData.cardPublicJson || '"returnObj":[]');
    				if( data.indexOf('"returnObj":[]') > -1  ){
    					return '<span class="text_red">${CL.ex_notSetting}</span>';
    				} else {
    					return '<span>${CL.ex_setting}</span>';
    				}
            		return "";
            	}
            } ],
            /* { sTitle : "<input type='checkbox' id='chkSels' name='chkSels' onclick='fnAllCheckBoxChecked(this, " + '"' + "chkSel" + '"' + " )'/>", bSearchable : false, bSortable : false, sWidth : "34", sClass : "center" }, */
            aoColumns : //????????? ???????????? ??????
            [ {
                sTitle : "<%=BizboxAMessage.getMessage("TX000000527","?????????")%>",
                mDataProp : "cardName",
                bVisible : true,
                bSortable : true,
                className : "td_le"
            }, {
                sTitle : "${CL.ex_cardNumber}",
                mData : function (source, type, val){
                	var cardNum = source.cardNum.replace(/-/gi,'') || '';
                	cardNum = cardNum.toString().replace(/\B(?=(\d{4})+(?!\d))/g, "-")
                	return cardNum;
                },
                //mDataProp : "cardNum",
                bVisible : true,
                bSortable : true,
                sWidth : ""
            }, {
                sTitle : "${CL.ex_financeClient}",
                bVisible : true,
                bSortable : true,
                className : "td_le"
            }, {
                sTitle : "${CL.ex_inUseYN}",
                bVisible : true,
                bSortable : true
            }, {
                sTitle : "<%=BizboxAMessage.getMessage("TX000018746","???????????? ????????????")%>",
                bVisible : true,
                bSortable : true
            } ]
        });

        if (ifSystem != 'BizboxA') {
            $('#btnConfigCardNew').hide(); /* ERP????????? ??????, ?????? ?????? ?????? ?????? ?????? - ERP ?????? ????????? ???????????? ?????? ?????? */
            $('#btnConfigCardDelete').hide(); /* ERP????????? ??????, ?????? ?????? ?????? ?????? - ERP ?????? ????????? ???????????? ?????? ?????? */
            $('#btnConfigCardFromErp').show(); /* ERP????????? ??????, ERP?????????????????? ?????? - ERP ?????? ????????? ???????????? ?????? ?????? */
        } else {
            $('#btnConfigCardNew').show(); /* ERP ????????? ????????????, ?????? ?????? ?????? */
            $('#btnConfigCardDelete').show(); /* ERP ????????? ????????????, ?????? ?????? ?????? */
            $('#btnConfigCardFromErp').hide(); /* ERP ????????? ????????????, ????????? ?????? ?????? */
        }
    }

    /* ????????? ????????? */
    function fnConfigCardSelectRow( data ) {
    	var displayPartner = "";
    	var useYN = "";
        if (data.cardPublicJson != undefined && data.cardPublicJson != '') {
            fnCallbackSel(JSON.parse(data.cardPublicJson)); /* ???????????? */
        } else {
        	fnCallbackSel({"returnObj":[]});
            $('#selectedItems_forCmPop').val('');
            $('#hidCardPublic').val('');
            $('#txtCardPublic').val('');
        }

        if(data.useYN == "Y") {
        	useYN = "??????";
        } else {
        	useYN = "?????????";
        }
        
        displayPartner = "[ " + data.partnerCode + " ] " + data.partnerName;  
        $('#txtCardCode').val(data.card_code); /* ???????????? */
        $('#txtCardName').val(data.cardName); /* ???????????? */
        $('#txtCardNum').val(data.cardNum); /* ???????????? */
        $('#cardUseYN').text(useYN); /* ???????????? */
        $('#txtPartnerCode').val(data.partnerCode); /* ??????????????? */
        $('#txtPartnerName').val(data.partnerName); /* ??????????????? */
        $('#txtPartnerDisplay').val(displayPartner); /* ??????????????? */
        
    	if(ifSystem == 'BizboxA'){
    		// ??????????????? ?????? 
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerDisplay').attr('disabled', 'disabled');
    	}
    	else if(ifSystem == 'iCUBE'){
    		// iCUEBE??? ??????. 
    		$("#txtCardName").css("border", "none");
    		$("#txtCardNum").css("border", "none");
    		$("#trBank").hide();
    	} else if(ifSystem == 'ERPiU'){
    		// ERPiU??? ??????. 
    		$("#txtCardName").css("border", "none");
    		$("#txtCardNum").css("border", "none");
    	}else{
    		// ?????? ???????????? ??????
    	}
        
        return;
    }

    /* ???????????? ????????? - ?????????????????? */
    function fnConfigCardInitEventButton_ConfigCardExcelDownload( param ) {
        alert("<%=BizboxAMessage.getMessage("TX000009615","????????? ??????????????????")%>" + '...');
        return;
    }

    /* ???????????? ????????? - ERP?????????????????? */
    function fnConfigCardFromErp( param ) {
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000018747","ERP??? ???????????? ????????? ????????????????")%>")){
    		return;
    	}
    	
        /* ???????????? */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = $('#selCompany').val();
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        /* ???????????? */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoFromErpCopy.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* ?????? ?????? ??????????????? ?????? */
                $('#btnConfigCardSearch').click();
                alert("<%=BizboxAMessage.getMessage("TX000018749","??????????????? ????????????????????????.")%>");
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* ???????????? ????????? - ?????? */
    function fnConfigCardNew( param ) {

    	if(ifSystem == 'BizboxA'){
    	} else if(ifSystem == 'iCUBE'){
    	} else if(ifSystem == 'ERPiU'){
    	} else{
    		// ?????? ???????????? ??????
    	}

        // ????????? ????????? ??????
        $('#selectedItems_forCmPop').val('');
        $('#hidCardPublic').val('');
        $('#txtCardPublic').val('');
        $('#txtCardCode').val('');
        $('#txtPartnerCode').val('');
        $('#txtPartnerDisplay').val('');
        $('#txtCardPublic').val('');
        return;
    }
    /* ???????????? ????????? - ?????? */
    function fnConfigCardSave( param ) {
        /* ???????????? */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        param.cardCode = $('#txtCardCode').val();
        if (param.cardCode == '') {
            param.cardCode = ($('#txtCardNum').val()).toString().replace(/-/g, '');
        }
        param.cardNum = $('#txtCardNum').val();
        param.cardName = $('#txtCardName').val();
        param.partnerCode = $('#txtPartnerCode').val();
        param.partnerName = $('#txtPartnerName').val();
        param.useYn = $('#selUseYN').val();
        param.searchStr = '';
        param.cardPublicJson = ($('#hidCardPublic').val() || '');

        /* ???????????? ?????? ?????? */
        if(!param.cardName){
        	$('#txtCardName').focus();
        	alert("<%=BizboxAMessage.getMessage("TX000009613","???????????? ???????????????")%>");
        	return;
        }
        if(!param.cardNum){
        	alert("<%=BizboxAMessage.getMessage("TX000018751","??????????????? ???????????????")%>");
        	console.log('open org pop');
        	$('#txtCardNum').focus();
        	return;
        }
        
        
        var public_json_str = JSON.parse(($('#hidCardPublic').val() || '{}'));
        var temp = [];

        if( !public_json_str.returnObj){
        	alert("<%=BizboxAMessage.getMessage("TX000009611","??????????????? ???????????????")%>");
        	$('#btnOrgChart').click();
        	return ;
        }
        
        $.each(public_json_str.returnObj, function( idx, item ) {
            var cardPublic = {};
            $.extend(cardPublic, ExCodeCardPublic);
            cardPublic.compSeq = item.compSeq;
            cardPublic.cardNum = $('#txtCardNum').val();
            cardPublic.orgDiv = item.empDeptFlag;

            if (item.empDeptFlag == 'c') {
                cardPublic.orgId = item.compSeq;
            } else if (item.empDeptFlag == 'd') {
                cardPublic.orgId = item.deptSeq;
            } else if (item.empDeptFlag == 'u') {
                cardPublic.orgId = item.empSeq;
            }
            temp.push(cardPublic);
        });
        param.cardPublic = JSON.stringify(temp);
        
        /* URL ?????? */
        var url = '';
        var attr = $('#txtCardNum').attr('disabled');
        
        url = '<c:url value="/ex/admin/config/CardInfoUpdate.do" />';
        
        /* ???????????? */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                // console.log("! [EX] SUCCESS - " + JSON.stringify(data));
                /* ?????? ?????? ??????????????? ?????? */
                $('#btnConfigCardSearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* ???????????? ????????? - ?????? */
    function fnConfigCardDelete( param ) {
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000015635","?????? ???????????????????????? ?")%>")){
    		return;
    	}
    	
        /* ???????????? */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        param.cardNum = $('#txtCardNum').val();
        /* ???????????? */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                // console.log("! [EX] SUCCESS - " + JSON.stringify(data));
                /* ?????? ?????? ??????????????? ?????? */
                $('#btnConfigCardSearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* ???????????? ????????? - ??????????????? */
    function fnConfigCardPartnerPop( param ) {
        param = (param || '');
        if( param == ''){ // ?????? ?????? ?????? ??????
        	var Popresult = fnOpenCodePop({
        		codeType : 'Partner'
        		, callback : 'fnConfigCardPartnerPop'
        		, searchStr : ''
        		, acct_type : ''
        		, search_type : '002'
        		/* ERPiU  "" ( ?????? > ?????? ) / 001 ( ?????? ) / 002 ( ?????? ) / 003 ( ?????? ) / 004 ( ?????? ) / 005 ( ?????? ) */
       			/* iCUBE "" ( ?????? > ?????? ) / 1.?????? / 2.?????? / 3.?????? / 4.?????? / 5.???????????? / 6.???????????? / 7.???????????? / 8.????????? / 9.???????????? */
        	});	
        }else{ // ?????? ??? ????????? ?????????
        	var displayPartner = "[ " + param.obj.partnerCode + " ]" + param.obj.partnerName;  
        	//$('#txtPartnerCode').val(param.obj.partnerCode);
        	$('#txtPartnerCode').val(param.obj.partnerCode);
        	$('#txtPartnerName').val(param.obj.partnerName);
        	$('#txtPartnerDisplay').val(displayPartner);
        }
        
        return;
    }

    /* ???????????? */
    /* ???????????? - ???????????? ???????????? */
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

    /* ???????????? */
    /* ???????????? - ???????????? ?????? ?????? */
    function fnCallbackSel( params ) {
        var returnObj = params.returnObj;
        var length = returnObj.length;
        var showSelectedNames = '';
        var selectedItems = '';
		
        console.log(returnObj);
        
        $("#authCount").html(returnObj.length);
        
        
        $("#cardAuthTable").empty();
        
        var colGroup = '<colgroup>';
        colGroup += '<col width="35%"/>';
        colGroup += '<col width="30%"/>';
        colGroup += '<col width=""/>';
        
        $("#cardAuthTable").append(colGroup);
        
        var emptyTable = function () {
        	$("#authCount").text("0");
        	var tr = document.createElement("tr");
        	$ ( tr ).append ( '<td colspan="' + $ ( "#cardAuthTable colgroup col" ).length + '">${CL.ex_dataDoNotExists}</td>' );
			$ ( "#authCount" ).append ( tr );
        };
        
        var resultCount = 0;
        $.each(returnObj, function(idx, val){
        	resultCount++;
        	var tr = document.createElement("tr");
        	$(tr).data('data', val);
        	if(!val.compName) {
        		$(tr).append('<td></td>');
        	} else {
        		$(tr).append('<td>' + val.compName + '</td>');
        	}
        	if(!val.deptName) {
        		$(tr).append('<td></td>');
        	} else {
        		$(tr).append('<td>' + val.deptName + '</td>');
        	}
        	if(!val.empName) {
        		$(tr).append('<td></td>');
        	} else {
        		$(tr).append('<td>' + val.empName + '</td>');
        	}
        	
        	$("#cardAuthTable").append(tr);
        });
        
        for (var i = 0; i < length; i++) {
            var item = returnObj[i];
            selectedItems += ',' + item.superKey;
            showSelectedNames += '/' + (item.empName || item.deptName || item.compName);
        }

        selectedItems = selectedItems.substring(1);
        showSelectedNames = showSelectedNames.substring(1);

        // ????????? ????????? ??????
        $('#selectedItems_forCmPop').val(selectedItems);
        // ?????? ?????? ??????.
        $('#hidCardPublic').val(JSON.stringify(params));
        // ????????? ????????? ????????? 		
        $('#txtCardPublic').val(showSelectedNames);

        return;
    }
  
  
</script>

<!-- ??????????????? -->
<div class="top_box">
	<dl>
		<input id="txtCardCode" type="hidden" /> 
		<dt>${CL.ex_cardNm}  <!--?????????--></dt>
		<dd><input id="searchCardName" type="text" style="width:173px;"/></dd>
		<dt>${CL.ex_cardNumber}  <!--????????????--></dt>
		<dd><input id="searchCardNum" type="text" style="width:170px;"/></dd>
		<dt>${CL.ex_openTo}  <!--????????????--></dt>
		<dd>
			<select id="selPublic" class="selectmenu" style="width:120px;">
				<option value="A" selected="selected">${CL.ex_all}  <!--??????--></option>
				<option value="Y">${CL.ex_setting}  <!--??????--></option>
				<option value="N">${CL.ex_notSetting}  <!--?????????--></option>
			</select>
		</dd>
		<dd><input id="btnConfigCardSearch" type="button" value="${CL.ex_search}"/></dd><!--??????-->
	</dl>
	<span class="btn_Detail">${CL.ex_detailSearch}  <!--????????????--> <img id="all_menu_btn" src='../../../Images/ico/ico_btn_arr_down01.png'/></span>
</div>

<div class="SearchDetail">
	<dl>
		<dt>${CL.ex_financialAccCode}  <!--??????????????? ??????--></dt>
		<dd><input id="searchPartnerCode" type="text" style="width:120px;" /></dd>
		<dt style="width:100px;">${CL.ex_financialAccNm}  <!--??????????????????--></dt>
		<dd>
			<input id="searchPartnerName" type="text" style="width:148px;" />
		</dd>
		<dt style="width:76px;">${CL.ex_inUseYN}  <!--????????????--></dt>
		<dd>
			<select id="selUseYN" class="selectmenu" style="width:120px;">
				<option value="" selected="selected">${CL.ex_all}  <!--??????--></option>
				<option value="Y">${CL.ex_use}  <!--??????--></option>
				<option value="N">${CL.ex_noUser}  <!--?????????--></option>
			</select>
		</dd>
	</dl>
</div>

<div class="sub_contents_wrap">		
	<!-- ?????? -->
    <div class="btn_div cl">
    	<div class="left_div mt5">
        	<p class="tit_p m0">${CL.ex_cardResiComment1} <!-- ?????? ?????? ??? ??? -->   (<span id="cardCount" class="">10</span>) <span class="fwn f11 ml20">${CL.ex_cardResiComment2}  <!--??????????????? ???????????? ??????????????? ???????????????.--></span></p> 
        </div>
		<div class="right_div">							
			<div class="controll_btn p0">
				<button id="btnConfigCardFromErp">${CL.ex_erpInfoPull}  <!--ERP ?????? ????????????--></button>
                <button id="btnConfigCardSave">${CL.ex_save}  <!--??????--></button>
            </div>
		</div>
	</div>

	<div class="twinbox">
 	
		<table>
			<colgroup>
				<col width="50%"/>
				<col width=""/>
			</colgroup>
			<tr>
				<td class="twinbox_td" style="">
					<div id="divConfigCardList" class="com_ta2 sc_head mt10">
						<table id="tblConfigCardList">
						</table>
					</div>
				</td>
				<td class="twinbox_td" style="">
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="140"/>
								<col width=""/>
							</colgroup>
							<tr>
								<th><img src="../../../Images/ico/ico_check01.png" alt=""> ${CL.ex_cardNm}  <!--?????????--></th>
								<td><input id="txtCardName" type="text" readonly="readonly"/></td>
							</tr>
							<tr>
								<th><img src="../../../Images/ico/ico_check01.png" alt=""> ${CL.ex_cardNumber}  <!--????????????--></th>
								<td><input id="txtCardNum" type="text" readonly="readonly"/></td>
							</tr>
							<tr id="trBank">
								<th>${CL.ex_financeClient}  <!--???????????????--></th>
								<td>
									<div>
										<input id="txtPartnerCode" type="hidden" style="width:170px" readonly="readonly" />
										<input id="txtPartnerName" type="hidden" style="width:170px" readonly="readonly" />
										<input id="txtPartnerDisplay" type="text" style="width:170px" readonly="readonly" />
										<input id="btnPartnerPop" type="button" value="${CL.ex_select}" /><!--??????-->
										<div class="controll_btn p0">
											<button class="reload_btn"></button>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<th>${CL.ex_inUseYN}  <!--????????????--></th>
								<td id="cardUseYN"></td>
							</tr>
						</table>
					</div>
					<div class="btn_div mt20">
							<div class="left_div">							
								<p class="tit_p mt7 mb0">${CL.ex_openTo}  <!--????????????--> (<span id="authCount">0</span>)</p>
							</div>
							<div class="right_div">
								<input id="hidCardPublic" type="hidden" style="width: 19%" />
								<div id="" class="controll_btn p0" style="">
									<button id="btnOrgChart" onclick="">${CL.ex_select}  <!--??????--></button>
								</div>	
							</div>
						</div>
						<div class="com_ta2 sc_head">
							<table>
								<colgroup>
									<col width="35%"/>
									<col width="30%"/>
									<col width=""/>
								</colgroup>
								<tr>
									<th>${CL.ex_company}  <!--??????--></th>
									<th>${CL.ex_department}  <!--??????--></th>
									<th>${CL.ex_fullName}  <!--??????--></th>
								</tr>
							</table>
						</div>
						<div class="com_ta2 ova_sc2 bg_lightgray" style="height:317px;">
							<table id="cardAuthTable">
								<colgroup>
									<col width="35%"/>
									<col width="30%"/>
									<col width=""/>
								</colgroup>
							</table>
						</div>
				</td>
			</tr>
		</table>
	</div><!-- twinbox -->
</div><!-- //sub_contents_wrap -->

<!-- ???????????? ?????? ???????????? ?????? ??? -->

<form id="frmPop2" name="frmPop2">
	<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="" /> 
	<input type="hidden" name="devModeUrl" width="500" value="http://local.duzonnext.com:8080" /> 
	<input type="hidden" id="langCode_forCmPop" name="langCode" width="500" /> 
	<input type="hidden" id="groupSeq_forCmPop" name="groupSeq" width="500" /> 
	<input type="hidden" id="compSeq_forCmPop" name="compSeq" width="500" /> 
	<input type="hidden" id="deptSeq_forCmPop" name="deptSeq" width="500" /> 
	<input type="hidden" id="empSeq_forCmPop" name="empSeq" width="500" /> 
	<input type="hidden" id="compFilter_forCmPop" name="compFilter" width="500" /> 
	<input type="hidden" name="selectMode" width="500" value="ud" /> 
	<input type="hidden" name="selectItem" width="500" value="m" /> 
	<input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" /> 
	<input type="hidden" name="callback" width="500" value="fnCallbackSel"/> 
	<input type="hidden" name="callbackUrl" width="500" value="<c:url value='/html/common/callback/cmmOrgPopCallback.jsp' />" />
</form>
