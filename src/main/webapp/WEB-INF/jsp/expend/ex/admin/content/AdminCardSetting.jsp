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

<!-- ????????? > ?????? > ???????????? ?????? > ?????? ?????? -->

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
    var clickCount =0;

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
        $('button').kendoButton(); /* ?????????????????? */
        
        setComboBox($("#selUsed"), JSON.parse('${ViewBag.commonCodeListYesOrNo}' || '{"common_name" : "", "common_code" : ""}'));
        
    	
        /* ????????? ?????? */
        var selUseYN = '${selUseYN}' === '' ? [] : ${selUseYN};
        selUseYN.push({commonName:"??????",commonCode:"",order_num:0});
        setComboBox($("#selUseYN"), selUseYN);
        var combobox = $("#selUseYN").data("kendoComboBox");
        combobox.value('Y');
        combobox.trigger("change"); /* ???????????? */
// 		});
		
		
        /* ?????? ????????? ?????? ????????? ?????? ?????? */
    	if(ifSystem == 'BizboxA'){
    		// ??????????????? ?????? 
    		$('#txtCardName').removeAttr('disabled');
    		$('#txtCardNum').removeAttr('disabled');
    		$("#selUsed").kendoComboBox({ enabled : true });
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerName').attr('disabled', 'disabled');
			
            /* ERP?????? ???????????? ?????? ????????? */
            $('#btnConfigCardFromErp').hide();
    	}
    	else if(ifSystem == 'iCUBE'){
    		// iCUEBE??? ??????. 
    		$('#txtCardName').attr('disabled', 'disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : false });
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerName').attr('disabled', 'disabled');
            
            /* ERP?????? ???????????? ?????? ?????? */
            $('#btnConfigCardFromErp').show();
    	} else if(ifSystem == 'ERPiU'){
    		// ERPiU??? ??????. 
    		$('#txtCardName').attr('disabled', 'disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : false });
            $('#txtPartnerCode').removeAttr('disabled');
            $('#txtPartnerName').removeAttr('disabled');
            
            /* ERP?????? ???????????? ?????? ?????? */
            $('#btnConfigCardFromErp').show();
    	}else{
    		// ?????? ???????????? ??????
    	}
        
        // ?????? ?????? ????????? ?????? ?????? 
        $('#txtSearchStr').focus();
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

            var url = "<c:url value='/html/common/cmmOrgPop.jsp'/>";
            var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");

            frmPop2.target = "cmmOrgPop";
            frmPop2.method = "post";
            frmPop2.action = url;
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
        
        /* ????????? ?????? - ??????????????? ????????? */
        $('#btnPartnerReload').click(function(event){
        	fnCardPartnerReload();
        })
        
        /* ???????????? ????????? ????????? ?????? - ???????????? ?????? ????????? ?????? */
        //20180823 soyoung ?????? ?????????????????? ???????????? ??? ?????? ????????? ??????????????? ????????? ?????? ?????????????????? ??????
        $('#txtCardPublic').click(function(){
	        	if(!$('#txtCardPublic').val()){
	        		$('#btnOrgChart').click();	
	        	}
        });
        
        /* ????????? ?????? - ??????????????? ????????? ?????? jQuery.exp.expend.focus.js ?????? */
        focus_fnSetFocusEvent(
       		['txtCardName', 'txtCardNum', 'txtCardPublic']
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
    
    /* ???????????? ????????? - ??????????????? ????????? */
    function fnCardPartnerReload(){
     	$('#txtPartnerCode').val('');
    	$('#txtPartnerName').val('');
    }
    
    
    /* ???????????? ????????? - ?????? */
    var autoSync = false;
    function fnConfigCardSearch( param ) {
        /* ???????????? */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        searchCompSeq = "${ViewBag.empInfo.compSeq}"; /* ?????? ????????? ?????? */
        param.searchStr = '';
        param.codeType = "CARD";
        param.searchType = 'IN';
        param.textFilter = $('#txtSearchStr').val() || '';
        param.useYN = $("#selUseYN").val();
        param.selPublic = 'A';
        param.eaType = 'eap';
        /* ???????????? */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	if(!data.result.aaData.length && !autoSync && ifSystem != 'BizboxA'){
            		// ????????? ?????? ?????? ?????? ?????? ??????
           			$('#btnConfigCardFromErp').click();
            	}else{
	                if (typeof data.result.aaData != 'undefined') {
	                    /* ????????? ????????? ????????? */
// 	                    fnConfigCardSetTable(data.result.aaData);
	                    fnSetGrid(data.result.aaData);
	                } else {
	                    /* ????????? ????????? ????????? */
// 	                    fnConfigCardSetTable('');
	                    fnSetGrid('');
	                }
	                /* ?????? ?????? ??????????????? ?????? */
	                $('#btnConfigCardNew').click();
	                
	                /* ????????? ?????? ????????? ?????? */
	                if($('#txtSearchStr').val()){
	                	$('#txtSearchStr').focus();
	                	isSearchFlag = false;
	                }
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
	function fnSetGrid(data){
		$("#tblConfigCardList").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="140"/>';
		colGroup += '<col width="150"/>';
		colGroup += '<col width="20%"/>';
		colGroup += '<col width="20%"/>';
		colGroup += '<col width="*"/>';
		colGroup += '</colgroup>';
		
		$("#tblConfigCardList").append(colGroup);
		if(data == null || data == undefined || data.length == 0){
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="' + $("#tblConfigCardList colgroup col").length + '">???????????? ????????????.</td>')
			$("#tblConfigCardList").append(tr);
		}else{
			$.each(data,function(idx, val){
				var tr = document.createElement('tr');
				$(tr).data('data', val);
				var cardNum = val.cardNum.replace(/-/gi,'') || '';
            	cardNum = cardNum.toString().replace(/\B(?=(\d{4})+(?!\d))/g, "-")
				$(tr).append('<td class="ce">' + cardNum + '</td>');
            	$(tr).append('<td class="le">' + val.cardName + '</td>');
            	if ((val.partnerCode || '') != '' && (val.partnerName || '') != '') {
                    $(tr).append('<td class="le">[' + (val.partnerCode || '') + '] ' + (val.partnerName || '') + '</td>');
                } else {
                	$(tr).append('<td class="le"></td>');
                }
				var useLabel = "";
				if (val.useYN == "0" || val.useYN == "N") {
					useLabel = "<%=BizboxAMessage.getMessage("TX000001243","?????????")%>";
				} else {
					useLabel = "<%=BizboxAMessage.getMessage("TX000000180","??????")%>";
				}
				$(tr).append('<td class="ce">'+useLabel+'</td>');
				var data = '' + (val.cardPublicJson || '"returnObj":[]');
				if( data.indexOf('"returnObj":[]') > -1  ){
					$(tr).append('<td class="ce"><span class="text_red">?????????</span></td>');	
				}else{
					$(tr).append('<td class="ce">??????</td>');
				}
				$("#tblConfigCardList").append(tr);
			});
			
			$("#tblConfigCardList tr").on("click",function(e){
				clickCount++;
				var clickElement = this;
				if(clickCount === 1){
					timeOut = setTimeout(function(){
						clickCount = 0;
						fnConfigCardSelectRow($(clickElement).data().data);
					}, 200);
				}
			});
		}
		
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
        if (data.cardPublicJson != undefined && data.cardPublicJson != '') {
            fnCallbackSel(JSON.parse(data.cardPublicJson)); /* ???????????? */
        } else {
            $('#selectedItems_forCmPop').val('');
            $('#hidCardPublic').val('');
            $('#txtCardPublic').val('');
        }

        // $('#').val(data.card_code); /* ???????????? */
        $('#txtCardCode').val(data.cardCode); /* ???????????? */
        $('#txtCardName').val(data.cardName); /* ???????????? */
        var cardNum = data.cardNum.replace(/-/gi,'') || '';
    	cardNum = cardNum.toString().replace(/\B(?=(\d{4})+(?!\d))/g, "-")
    	$('#txtCardNum').val(cardNum); /* ???????????? */
        $('#txtPartnerCode').val(data.partnerCode); /* ??????????????? */
        $('#txtPartnerName').val(data.partnerName); /* ??????????????? */
        var combobox = $("#selUsed").data("kendoComboBox");
        combobox.value(data.useYn);
        combobox.trigger("change"); /* ???????????? */
        
    	if(ifSystem == 'BizboxA'){
    		// ??????????????? ?????? 
    		$('#txtCardName').removeAttr('disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : true });
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerName').attr('disabled', 'disabled');
    	}
    	else if(ifSystem == 'iCUBE'){
    		// iCUEBE??? ??????. 
    		$('#txtCardName').attr('disabled', 'disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : false });
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerName').attr('disabled', 'disabled');
    	} else if(ifSystem == 'ERPiU'){
    		// ERPiU??? ??????. 
    		$('#txtCardName').attr('disabled', 'disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : false });
            $('#txtPartnerCode').removeAttr('disabled');
            $('#txtPartnerName').removeAttr('disabled');
    	}else{
    		// ?????? ???????????? ??????
    	}
        
        return;
    }

    /* ???????????? ????????? - ?????????????????? */
    function fnConfigCardInitEventButton_ConfigCardExcelDownload( param ) {
        alert("<%=BizboxAMessage.getMessage("TX000009615", "????????? ??????????????????")%>" + '...');
        return;
    }

    /* ???????????? ????????? - ERP?????????????????? */
    function fnConfigCardFromErp( param ) {
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000018747", "ERP??? ???????????? ????????? ????????????????")%>")){
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
                alert("<%=BizboxAMessage.getMessage("TX000018749", "??????????????? ????????????????????????.")%>");
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
    		$('#txtCardName').removeAttr('disabled');
            $('#txtCardNum').removeAttr('disabled');
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
        $('#txtCardName').val('');
        $('#txtCardNum').val('');
        $('#txtPartnerCode').val('');
        $('#txtPartnerName').val('');
        $('#txtCardPublic').val('');
        
        var combobox = $("#selUsed").data("kendoComboBox");
        combobox.value('Y');
        combobox.trigger("change"); /* ???????????? */
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
        param.useYn = $('#selUsed').val();
        param.searchStr = '';
        param.cardPublicJson = ($('#hidCardPublic').val() || '');

        /* ???????????? ?????? ?????? */
        if(!param.cardName){
        	$('#txtCardName').focus();
        	alert("<%=BizboxAMessage.getMessage("TX000009613", "???????????? ???????????????")%>");
        	return;
        }
        if(!param.cardNum){
        	alert("<%=BizboxAMessage.getMessage("TX000018751", "??????????????? ???????????????")%>");
        	console.log('open org pop');
        	$('#txtCardNum').focus();
        	return;
        }
//         if(param.cardPublicJson.indexOf('"returnObj":[]') > -1 ){
<%--         	alert("<%=BizboxAMessage.getMessage("TX000009611","??????????????? ???????????????")%>"); --%>
//         	$('#btnOrgChart').click();
//         	return;
//         }
        
        var public_json_str = JSON.parse(($('#hidCardPublic').val() || '{}'));
        var temp = [];

//         if( !public_json_str.returnObj){
<%--         	alert("<%=BizboxAMessage.getMessage("TX000009611","??????????????? ???????????????")%>"); --%>
//         	$('#btnOrgChart').click();
//         	return ;
//         }
        
		if( public_json_str.returnObj){
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
		}
        param.cardPublic = JSON.stringify(temp);
        
        /* URL ?????? */
        var url = '';
        var attr = $('#txtCardNum').attr('disabled');
        if (typeof attr !== typeof undefined && attr !== false) {
            url = '<c:url value="/ex/admin/config/CardInfoUpdate.do" />';
        } else {
            url = '<c:url value="/ex/admin/config/CardInfoInsert.do" />';
        }
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
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000015635", "?????? ???????????????????????? ?")%>")){
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
        	$('#txtPartnerCode').val(param.obj.partnerCode);
        	$('#txtPartnerName').val(param.obj.partnerName);
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
    
  //??? ????????? ????????? ?????????
    function table1Scroll() {
//     	$(".table3 .leftContents").scrollTop($(".table3 .rightContents").scrollTop());
    	$(".table3 .rightHeader").scrollLeft($(".table3 .rightContents").scrollLeft());
    }

</script>

<div id="grid"></div>

<div class="sub_contents_wrap">
	<div class="top_box">
		<dl>
			<dt>${CL.ex_keyWord}</dt>

			<dd>
				<div class="controll_btn p0">
					<input id="txtSearchStr" type="text" style="width: 200px;" />
					<button id="btnConfigCardSearch" class="btn_sc_add">${CL.ex_search}</button>
				</div>
			</dd>
			<dt>${CL.ex_inUseYN}
				<!--????????????-->
			</dt>
			<dd>
				<input id="selUseYN" style="width: 100px" />
			</dd>
		</dl>
	</div>

	<input type="hidden" id="hidComCD" />
	<!-- ??????????????? -->

	<input type="button" id="searchButton" value="${CL.ex_search}"
		style="display: none;" />


	<div id="" class="controll_btn">
		<button id="btnConfigCardExcelDownload" class="k-button"
			style="display: none;"><%=BizboxAMessage.getMessage("TX000002977", "??????")%></button>
		<button id="btnConfigCardFromErp" class="k-button"><%=BizboxAMessage.getMessage("TX000003085", "ERP??????????????????")%></button>
		<button id="btnConfigCardNew" class="k-button"><%=BizboxAMessage.getMessage("TX000003101", "??????")%></button>
		<button id="btnConfigCardSave" class="k-button">${CL.ex_save}</button>
		<button id="btnConfigCardDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424", "??????")%></button>
	</div>



	<div class="twinbox">
		<table>
			<colgroup>
				<col style="width: 50%;">
					<col width="" />
			</colgroup>
			<tr>
				<td class="twinbox_td">
					<div class="scbg table3 posi_re">
						<span class="scy_head1"></span>
						<div id="" class="com_ta2 ovh rightHeader mr15">
							<table>
								<colgroup>
									<col width="140" />
									<col width="150" />
									<col width="20%" />
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tr>
									<th>${CL.ex_cardNumber}<!--????????????--></th>
									<th>${CL.ex_cardNm}<!--?????????--></th>
									<th>${CL.ex_financeClient}<!--???????????????--></th>
									<th>${CL.ex_inUseYN}<!--????????????--></th>
									<th><span style ='word-break:keep-all;'>${CL.ex_rangeSetCondition}</span> <!--???????????? ????????????--></th>
								</tr>
							</table>
						</div>
						<div id=""
							class="com_ta2 ova_sc2 bg_lightgray flex_ta rightContents"
							style="height: 500px;" onscroll="table1Scroll()">
							<table id="tblConfigCardList">
							</table>
						</div>
					</div>
				</td>
				<td class="twinbox_td">
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="140" />
								<col width="" />
							</colgroup>
							<tr>
								<th><img
									src="<c:url value='/Images/ico/ico_check01.png' />" alt="" />
									<%=BizboxAMessage.getMessage("TX000000527", "?????????")%></th>
								<td><input id="txtCardName" type="text" style="width: 90%" />
								</td>
							</tr>
							<tr>
								<th><img
									src="<c:url value='/Images/ico/ico_check01.png' />" alt="" />
									${CL.ex_cardNumber}</th>
								<td><input id="txtCardCode" type="hidden" /> <input
									id="txtCardNum" type="text" style="width: 90%" class='card_cep' />
								</td>
							</tr>
							<th>
								<!-- <img src="<c:url value='/Images/ico/ico_check01.png' />" alt="" />-->
								${CL.ex_openTo}
							</th>
							<td><input id="hidCardPublic" type="hidden"
								style="width: 19%" /> <input type="text" id="txtCardPublic"
								style="width: 46%" />
								<div class="controll_btn p0">
									<button id="btnOrgChart"><%=BizboxAMessage.getMessage("TX000000265", "??????")%></button>
									<button id="btnPublicReload" class="reload_btn"></button>
								</div></td>
							</tr>
							<tr>
								<th>${CL.ex_inUseYN}</th>
								<td><input id="selUsed" style="width: 100px" /></td>

							</tr>

							<tr>

								<th class='ERPiU'>${CL.ex_financeClient}</th>
								<td class='ERPiU' colspan="3"><input id="txtPartnerCode"
									type="text" style="width: 25%" readonly="readonly" /> <input
									id="txtPartnerName" type="text" style="width: 45%" />
									<div class="controll_btn p0">
										<button id="btnPartnerPop"><%=BizboxAMessage.getMessage("TX000000265", "??????")%></button>
										<button id="btnPartnerReload" class="reload_btn"></button>
									</div></td>
							</tr>
						</table>
					</div>
				</td>
		</table>
	</div>
</div>
<div id="dialog"></div>
<!-- //sub_contents_wrap -->

<!-- ???????????? ?????? ???????????? ?????? ??? -->

<form id="frmPop2" name="frmPop2">
	<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="<c:url value='/systemx/orgChart.do' />" /> 
	<input type="hidden" id="devMode_forCmPop" name="devMode" width="500" value="dev" /> 
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



