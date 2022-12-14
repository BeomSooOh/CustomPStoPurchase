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
<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>

<script type="text/javascript">

	/* [Map] declare javascipt hashmap prototype
	========================================*/
	Map = function () {
		this.map = new Object();
	};
	Map.prototype = {
		put: function (key, value) {
			this.map[key] = value;
		},
		get: function (key) {
			return this.map[key];
		},
		containsKey: function (key) {
			return key in this.map;
		},
		containsValue: function (value) {
			for (var prop in this.map) {
				if (this.map[prop] == value) return true;
			}
			return false;
		},
		isEmpty: function (key) {
			return (this.size() == 0);
		},
		clear: function () {
			for (var prop in this.map) {
				delete this.map[prop];
			}
		},
		remove: function (key) {
			delete this.map[key];
		},
		keys: function () {
			var keys = new Array();
			for (var prop in this.map) {
				keys.push(prop);
			}
			return keys;
		},
		values: function () {
			var values = new Array();
			for (var prop in this.map) {
				values.push(this.map[prop]);
			}
			return values;
		},
		size: function () {
			var count = 0;
			for (var prop in this.map) {
				count++;
			}
			return count;
		}
	};
</script>

<script>
	/* ## ---------------------------------------------------------------------------------------------------------- ##*/
	/* ## ????????? ???????????? ##*/
	var ifSystem = '${ifSystem}';
	
	$(document).ready(function(){
		$ ( document ).ready ( function ( ) {
			fnInit ( );
		} );
	});
	
	/* ?????? ????????? ?????? */
	function fnInit ( ) {
		var useYNInfo = ('${useYN}' === '' ? [] : ${useYN});
		var comboBoxItem = [];
		$.each(useYNInfo, function(idx, item) {
			var itemObj = {};
			itemObj.commonCode = item.code;
			itemObj.commonName = item.name;
			comboBoxItem.push(itemObj);
		});
		exComboBox($('#selUseYN'), comboBoxItem, function(){
			fnAuthListInfo();
		});
		
		fnInitEvent ( );
		$ ( "#btnSearch" ).click ( );
		return;
	}
	
	/* ?????? ????????? ?????? */
	function fnInitEvent() {
		/* ?????? */
		$ ( "#btnSearch" ).click ( function ( ) {
			fnSubLayerInfoReset();
			dal_Box_detail();
			fnAuthListInfo ( );
		} );
		
		/* ?????? */
		$ ( "#btnDel" ).click ( function ( ) {
			fnAuthDelete ( );
		} );
		
		/* ?????? */
		$ ( "#btnAdd" ).click ( function ( ) {
			var $DALBD = $(".dal_Box_detail");
			$DALBD.removeClass("animated05s fadeOutRight").addClass("animated05s fadeInRight").show();
			
			fnSubLayerInfoReset ( );
		} );
		
		/* ?????? */
		$ ( "#btnSave" ).click ( function ( ) {
			fnAuthSave ( );
		} );
		
		/* ????????? ????????? ?????? ????????? */
		$("#authTableList").on("click", "tr", function(e){
			onSelect(this);
		});	
		
		/* ?????? ?????? */
		/* ????????? ??????, ???????????? ??????, ???????????? ?????????, ???????????? */
		$ ( "#btnAuthVatTypePopup, #btnAuthCrAcctPopup, #btnAuthVatAcctPopup, #btnAuthErpAuthPopup, #btnAuthVaPopup" ).on ( "click", function ( ) {
			var type = this.id.toString ( ).replace ( 'btnAuth', '' ).replace ( 'Popup', '' );
			fnCommonCodePop ( type, false );
			
		} );
		
        /* ????????? ???????????? ????????? ?????? */
        $('.reload_btn').click(function( event ) {
            /* ????????? ?????? */
            var par = $(this).parent();
            var input = $(par).prevAll('.txt_reset');
            /* ????????? ?????? */
            $.each(input, function( idx, target ) {
                $(target).val('');
            });
        });
        
        /* ???????????? ????????? ?????? [?????? ?????? ??????]*/
    	$('#txtVatTypeName, #txtCrAcctName, #txtVatAcctName, #txtErpAuthName').bind('keydown', function( event ) {
	        /* ???????????? ????????? ?????? */
	        if (event.which == 13 || event.which == 113) {
	        	var type = this.id.toString ( ).replace ( 'txt', '' ).replace ( 'Name', '' );
	        	fnCommonCodePop(type, true);
	        }
	    });
        
        /* ????????? ?????? - ??????????????? ????????? ?????? jQuery.exp.expend.focus.js ?????? */
        focus_fnSetFocusEvent(
       		[
       		 'txtAuthCode'
       		, 'txtAuthName'
       		, 'txtAuthVatAcctName'
       		, 'txtAuthVaName'
       		]
     	);
	}
	
	/* ???????????? ????????? ?????? */
	var authJsonData = new Map();
	var baseData = '';
	function fnAuthListInfo() {
		/* ???????????? */
        var param = {};
        param.compSeq = '${empInfo.compSeq}';
        searchCompSeq = '${empInfo.compSeq}'; /* ?????? ????????? ?????? */
//      param.summary_div = $('#selSummaryType').val(); // ????????? A??? ??????, ?????? ???????????? ????????? ??????
        param.authDiv = 'A';
        param.searchStr = ($('#txtSearchStr').val() || '');
		param.useYN = $("#selUseYN").val();

		/* ???????????? ????????? ?????? */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex2/admin/auth/setAdminAuthListSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	baseData = data.result.aaData
            	
            	/* ???????????? ???????????? ???????????? ?????? ??? */
            	if(data.result.aaData.length == 0) {
            		/* ????????? ????????? ????????? */
                    fnAuthListBind('');
            	} else {
            		/* ?????? ??? ?????? */
            		for(var i=0; i<data.result.aaData.length; i++) {
            			authJsonData.put(i, data.result.aaData[i])
            		}
            		
            		/* ????????? ????????? ????????? */
            		fnAuthListBind(data.result.aaData);
            	}
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
		return;
	}
	
	/* ????????? ????????? ????????? */
	function fnAuthListBind(data) {
		var tag = '';
		var length = data.length;

		if (data != '') {
			for (var i = 0; i < length; i++) {
				var checkItems = '';
				var useText = '';
				
				if(data[i].noteRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "??????";
					} else {
						checkItems += "/??????";
					}
				}
				
				if(data[i].authRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "????????????";
					} else {
						checkItems += "/????????????";
					}
				}
				
				if(data[i].cardRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "????????????";
					} else {
						checkItems += "/????????????";
					}
				}
				
				if(data[i].partnerRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "?????????";
					} else {
						checkItems += "/?????????";
					}
				}
				
				if(data[i].projectRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "????????????";
					} else {
						checkItems += "/????????????";
					}
				}
				
				if(data[i].useYN == "Y" || data[i].useYN == "") {
					useText = "??????";
				} else {
					useText = "?????????";
				}
				
				
				tag += '<tr id="' + i + '" class="borderR" type="' + data[i].vatTypeCode + '">';
				tag += '  <td onclick="event.cancelBubble=true;">';
				tag += '    <input type="checkbox" class="tetete chkAuthCode" name="chkAuthCode" id="authCode_' + data[i].authCode +'" class=""/>';
				tag += '    <label class="tetete" for="authCode_' + data[i].authCode +'"><span></span></label>';
				tag += '  </td>';
				tag += '  <td class="cen">' + data[i].authCode + '</td>';
				tag += '  <td class="cen ellipsis">' + data[i].authName + '</td>';
				tag += '  <td class="cen ellipsis">' + data[i].vatTypeName + '</td>';
				if(ifSystem == "iCUBE") {
					console.log(data[i].vaTypeName);
					tag += '  <td class="cen ellipsis">' + data[i].vaTypeName + '</td>';
				} else {
					tag += '  <td class="cen ellipsis">' + data[i].noTaxName + '</td>';
				}

				tag += '  <td class="cen ellipsis">' + data[i].crAcctCode
						+ '/' + data[i].crAcctName + '</td>';
				tag += '  <td class="cen ellipsis">' + data[i].vatAcctCode
						+ '/' + data[i].vatAcctName + '</td>';
				tag += '  <td class="cen ellipsis">' + data[i].erpAuthCode
						+ '/' + data[i].erpAuthName + '</td>';
				tag += '  <td class="cen ellipsis">' + checkItems + '</td>';
				tag += '  <td class = "cen">' + useText + '</td>';
				tag += '</tr>';
			}
		} else {
			tag += '<tr class="borderR">';
			tag += '  <td class="nocon" onclick="event.cancelBubble=true;">';
			tag += '    <input type="checkbox" name="inp_chk" id="Chk01" class="" disabled="" />';
			tag += '    <label class="" for="Chk01"><span></span></label>';
			tag += '  </td>';
			tag += '  <td colspan="8" class="nocon">???????????? ????????? ????????????.</td>';
			tag += '</tr>';	
		}

		$("#authTableList").html(tag);

		return;
	}
	
	/* ????????? ????????? ?????? ????????? */
	function onSelect(data) {
		var authCode = $(data).attr("id");
		var varType = $(data).attr("type");
		$("#authTableList tr").removeClass("on");
		
		$(data).addClass("on");
		
		fnAuthDetailInfo(authCode, varType);
	}
	
	/* ?????? ???????????? ?????? ?????? */
	function fnAuthDetailInfo(code, type) {
		/* ???????????? */
		var authCode = code;
		var vatTypeCode = type;

		/* ???????????? ?????? */
		var $DALBD = $(".dal_Box_detail");
		$DALBD.removeClass("animated05s fadeOutRight").addClass(
				"animated05s fadeInRight").show();

		/* authCode ????????? ?????? */
		if (authCode == null || authCode == "undefined" || authCode == "") {
			console.log("???????????? ????????? ??????????????????.");
			authCode = "";
		} else {
			$('#txtAuthCode').attr('disabled', 'disabled');

			var authItems = authJsonData.get(authCode);

			if('${ifSystem}' == "iCUBE") {
				if(vatTypeCode == "23" || vatTypeCode == "24") {
					$(".ERPElement").show();
				} else {
					$(".ERPElement").hide();	
				}
				
			} else {
				
			}
			
			//console.log("authItems : " + JSON.stringify(authItems));
			
			$("#txtAuthCode").val(authItems.authCode);
			$("#txtAuthNameKr").val(authItems.authNameKr);
			$("#txtAuthNameEn").val(authItems.authNameEn);
			$("#txtAuthNameJp").val(authItems.authNameJp);
			$("#txtAuthNameCn").val(authItems.authNameCn);
			$("#txtDrAcctCode").val(authItems.drAcctCode);
			$("#txtDrAcctName").val(authItems.drAcctName);
			$("#txtCrAcctCode").val(authItems.crAcctCode);
			$("#txtCrAcctName").val(authItems.crAcctName);
			$("#txtVatAcctCode").val(authItems.vatAcctCode);
			$("#txtVatAcctName").val(authItems.vatAcctName);
			$("#txtErpAuthCode").val(authItems.erpAuthCode);
			$("#txtErpAuthName").val(authItems.erpAuthName);
			$("#txtVatTypeCode").val(authItems.vatTypeCode);
			$("#txtVatTypeName").val(authItems.vatTypeName);
			$("#txtAuthOrderNum").val(authItems.orderNum);
			$("#txtVaTypeCode").val(authItems.vaTypeCode);
			$("#txtVaTypeName").val(authItems.vaTypeName);
			/* ?????? */
			if (authItems.noteRequiredYN == "Y") {
				$('#chkConfigAuthNoteReq').prop('checked', true);
			} else {
				$('#chkConfigAuthNoteReq').prop('checked', false);
			}

			/* ???????????? */
			if (authItems.authRequiredYN == "Y") {
				$('#chkConfigAuthAuthReq').prop('checked', true);
			} else {
				$('#chkConfigAuthAuthReq').prop('checked', false);
			}

			/* ???????????? */
			if (authItems.cardRequiredYN == "Y") {
				$('#chkConfigAuthCardReq').prop('checked', true);
			} else {
				$('#chkConfigAuthCardReq').prop('checked', false);
			}

			/* ????????? */
			if (authItems.partnerRequiredYN == "Y") {
				$('#chkConfigAuthPartnerReq').prop('checked', true);
			} else {
				$('#chkConfigAuthPartnerReq').prop('checked', false);
			}

			/* ???????????? */
			if (authItems.projectRequiredYN == "Y") {
				$('#chkConfigAuthProjectReq').prop('checked', true);
			} else {
				$('#chkConfigAuthProjectReq').prop('checked', false);
			}

			if (authItems.useYN == "Y") {
				$('#useY').prop('checked', true);
				$('#useN').prop('checked', false);
			} else {
				$('#useY').prop('checked', false);
				$('#useN').prop('checked', true);
			}
			
		}
	}	
	
	/* ???????????? ????????? */
	function fnSubLayerInfoReset() {
		$("#txtAuthCode").val('');
		$("#txtAuthNameKr").val('');
		$("#txtAuthNameEn").val('');
		$("#txtAuthNameJp").val('');
		$("#txtAuthNameCn").val('');
		$("#txtDrAcctCode").val('');
		$("#txtDrAcctName").val('');
		$("#txtCrAcctCode").val('');
		$("#txtCrAcctName").val('');
		$("#txtVaTypeCode").val('');
		$("#txtVaTypeName").val('');
		$("#txtVatTypeCode").val('');
		$("#txtVatTypeName").val('');
		$("#txtVatAcctCode").val('');
		$("#txtVatAcctName").val('');
		$("#txtErpAuthCode").val('');
		$("#txtErpAuthName").val('');
		$("#txtAuthOrderNum").val('');

		/* ???????????? ?????? */
		$('#txtAuthCode').removeAttr('disabled');

		$('#chkConfigAuthNoteReq').prop('checked', false);
		$('#chkConfigAuthAuthReq').prop('checked', false);
		$('#chkConfigAuthCardReq').prop('checked', false);
		$('#chkConfigAuthPartnerReq').prop('checked', false);
		$('#chkConfigAuthProjectReq').prop('checked', false);
		$(".iCUBEVat").hide();
		return;
	}
	
	/* ???????????? ?????? */
	function fnAuthSave ( ) {
		/* ?????? ?????? ?????? ???????????? */
// 		if(fnCheckNecessaryCode() == false){
// 			return;
// 		}
		
		/* ???????????? */
		var param = {};
		var paramCheck = false;
		var url = '';

		param.compSeq = '${empInfo.compSeq}';
		param.authCode = $ ( '#txtAuthCode' ).val ( );	/* ?????????????????? */
		param.authName = $ ( '#txtAuthNameKr' ).val ( ); /* ??????????????????(kr) */
		param.authNameEn = $ ( '#txtAuthNameEn' ).val ( ); /* ??????????????????(en) */
		param.authNameCn = $ ( '#txtAuthNameCn' ).val ( ); /* ??????????????????(cn) */
		param.authNameJp = $ ( '#txtAuthNameJp' ).val ( ); /* ??????????????????(jp) */
//      param.auth_div = $('#selSummaryTypeInput').val();// ????????? A??? ??????, ?????? ???????????? ????????? ??????
		param.authDiv = 'A';
		param.drAcctCode = $ ( '#txtDrAcctCode' ).val ( );
		param.drAcctName = $ ( '#txtDrAcctName' ).val ( );
		param.crAcctCode = $ ( '#txtCrAcctCode' ).val ( );
		param.crAcctName = $ ( '#txtCrAcctName' ).val ( );
		param.vatAcctCode = $ ( '#txtVatAcctCode' ).val ( );
		param.vatAcctName = $ ( '#txtVatAcctName' ).val ( );
		param.erpAuthCode = $ ( '#txtErpAuthCode' ).val ( );
		param.erpAuthName = $ ( '#txtErpAuthName' ).val ( );
		param.useYN = $(':radio[name="useRadio"]:checked').val();
		param.orderNum = $('#txtAuthOrderNum').val() || 0;		

		param.cashType = $('#selConfigAuthCashType').val(); /* ????????????????????? */

        param.noTaxCode = $('#txtConfigAuthNotaxCode').val(); /* ???????????????(ERPiU) ?????? */
        param.noTaxName = $('#txtConfigAuthNotaxName').val(); /* ???????????????(ERPiU) ?????? */
        param.vaTypeCode = $('#txtVaTypeCode').val();/* ????????????(iCUBE) ?????? */
        param.vaTypeName = $('#txtVaTypeName').val();/* ????????????(iCUBE) ?????? */
        param.vatTypeCode = $('#txtVatTypeCode').val();
        param.vatTypeName = $('#txtVatTypeName').val();
        
        if ($("#chkConfigAuthNoteReq").is(":checked")) {
            param.noteRequiredYN = 'Y';
        } else {
            param.noteRequiredYN = 'N';
        } /* ???????????? ?????? */
        if ($("#chkConfigAuthAuthReq").is(":checked")) {
            param.authRequiredYN = 'Y';
        } else {
            param.authRequiredYN = 'N';
        } /* ???????????? ???????????? */
        if ($("#chkConfigAuthCardReq").is(":checked")) {
            param.cardRequiredYN = 'Y';
        } else {
            param.cardRequiredYN = 'N';
        } /* ???????????? ???????????? */
        if ($("#chkConfigAuthPartnerReq").is(":checked")) {
            param.partnerRequiredYN = 'Y';
        } else {
            param.partnerRequiredYN = 'N';
        } /* ???????????? ????????? */
        if ($("#chkConfigAuthProjectReq").is(":checked")) {
            param.projectRequiredYN = 'Y';
        } else {
            param.projectRequiredYN = 'N';
        } /* ???????????? ???????????? */
		
		/* ????????? ?????? */
		paramCheck = fnSaveParamCheck ( param );
		
 		var attr = $('#txtAuthCode').attr('disabled');
// 		/* ??????/?????? ?????? */
		if(typeof attr !== typeof undefined && attr !== false) {
			url = '<c:url value="/expend/ex2/admin/auth/setAdminAuthUpdate.do" />';
		} else {
			url = '<c:url value="/expend/ex2/admin/auth/setAdminAuthInsert.do" />';
		}
		
		console.log(JSON.stringify(param));
		
		if(paramCheck) {
			$.ajax({
				type : 'post',
	            url : url,
	            datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
	            	/* ???????????? ?????? */
	                $ ( "#btnSearch" ).click ( );
	                alert("<%=BizboxAMessage.getMessage("TX000002073", "?????????????????????.")%>");
				},
				error : function(data) {
					console.log("! [EX] ERROR - " + JSON.stringify(data));
				}
			});
		}
		
		return;
	}	
	
	/* ?????? ????????? ?????? */
	function fnSaveParamCheck ( data ) {
		var base = JSON.stringify(baseData);
		
		if(data.authCode == "" || data.authCode == null || data.authCode == "undefined"){
    		alert("<%=BizboxAMessage.getMessage("TX000018740","????????????????????? ???????????????.")%>");
    		return false;
    	}if(data.authName == "" || data.authName == null || data.authName == "undefined"){
    		alert("<%=BizboxAMessage.getMessage("TX000018741","????????????????????? ???????????????.")%>");
    		return false;
    	}if((!$('#txtAuthCode:disabled').length) &&  base.indexOf('"autCode":"'+data.autCode+'"') > -1){
    		alert("<%=BizboxAMessage.getMessage("TX000018742","???????????? ?????????????????????.")%>");
    		return false;
    	}
    	
    	if(ifSystem === 'iCUBE' && !data.vatAcctCode ){
    		alert("<%=BizboxAMessage.getMessage("TX000018743","???????????????????????? ???????????? ????????????")%>");
     		$('#btnAuthVatAcctPopUp').click();
     		return false;
     	}
   	
   	
    	if(ifSystem === 'iCUBE' && $(".iCUBEVat:visible").length && !data.vaTypeCode){
    		alert("<%=BizboxAMessage.getMessage("TX000007557","??????????????? ???????????? ????????????.")%>");
    		$('#btnAuthVaPopUp').click();
    		return false;
    	}

//     	if(ifSystem === 'ERPiU' && $(".ERPiUVat:visible").length && !param.noTaxCode){
<%--     		alert("<%=BizboxAMessage.getMessage("TX000007553","?????????????????? ???????????? ????????????.")%>"); --%>
//     		return false;
//     	}
//     	if(ifSystem === 'ERPiU'){
//    	        switch (data.vatTypeCode) {
//    	        	case '21':
//    	        	case '22':
//    	        	case '24':
//    	        	case '31':
//    	        	case '38':
//    	        	case '43':
//    	        	case '50':
//    	        		// ????????? ???????????? ?????? ??????
//    	        		if($("#txtConfigAuthVatAcctCode").val() === ''){
<%--    	        			alert("<%=BizboxAMessage.getMessage("TX000018743","???????????????????????? ???????????? ????????????")%>"); --%>
//    	        			return false;
//    	        		}
//    					break;
//    			}
//    	    }

		return true;
	}
	
	/* ???????????? ?????? */
	function fnAuthDelete ( ) {
		if(!confirm("<%=BizboxAMessage.getMessage("","????????? ???????????? ????????? ?????????????????????????")%>")){
    		return;
    	}
		
		 var param = {};
		 param.compSeq = '${empInfo.compSeq}';
//		 param.authCode = $("#txtAuthCode").val();
		 param.authDiv = "A";
		 
		 if($("input:checkbox[name='chkAuthCode']:checked").length > 0) {
			 var authCodes = '';
			 
			 $(".chkAuthCode").each(function(){
				if($(this).prop("checked")) {
					console.log("id : " + $(this).attr("id"));
					authCodes += $(this).attr("id").replace("authCode_", "") + ",";
				} 
			 });
			 
			 param.authCode = authCodes;
		 } else {
			 alert("<%=BizboxAMessage.getMessage("","????????? ??????????????? ??????????????????")%>");
		 }
		
		 $.ajax({
			type : 'post',
            url : '<c:url value="/expend/ex2/admin/auth/setAdminAuthDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	console.log(JSON.stringify(data));
            	/* ERP ???????????? ?????? ?????? */
            	if(parseInt(data.result.aData.erpSendNCount) > 0) {
            		alert("<%=BizboxAMessage.getMessage("","ERP ????????? ??????????????? ?????? ?????? ??????????????? ????????? ??? ????????????.\\n[????????????  ??????] ???????????? ???????????? ??? ??????????????????.")%>");
            	} else {
            		
            	}
            	
            	/* ???????????? ?????? */
				$ ( "#btnSearch" ).click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
		});
		
		return;
	}
	
	/*	[?????? ?????? ??????] ???????????? ??? ????????? ?????? ??????
	-------------------------------------------- */
	function fnCheckNecessaryCode(){
		var necText = '';
		var param = [];
		if( !$('#txtDrAcctCode').val()){
			if($('#txtDrAcctName').val()){
				param.push({
					'acctType' : 'DR'
					, 'searchStr' : $('#txtDrAcctName').val()
				});
			}else {
				alert( '?????? ??????????????? ???????????????.' );
				return false;
			}
		}
		else if( !$('#txtVatAcctCode').val() ){
			if($('#txtVatAcctName').val()){
				param.push({
					'acctType' : 'VAT'
					, 'searchStr' : $('#txtVatAcctName').val()
				});
			}else {
				alert( '????????? ??????????????? ???????????????.' );
				return false;
			}
		}
		else if( !$('#txtCrAcctCode').val() ){
			if($('#txtCrAcctName').val()){
				param.push({
					'acctType' : 'CR'
					, 'searchStr' : $('#txtCrAcctName').val()					
				});
			}else {
				alert( '?????? ??????????????? ???????????????.' );
				return false;
			}
		}
		
		/* ???????????? ????????? ?????? */
		if(param.length){
			var returnResult = true;
			$.ajax({
				type : 'post',
	            url : '<c:url value="/expend/ex2/admin/auth/setAdminAuthAuthCode.do" />',
	            datatype : 'json',
	            async : false,
	            data : { 'filter' : JSON.stringify(param)},
	            success : function( data ) {
	            	if(data.result.resultCode == 'FAIL'){
						if(data.result.resultName == 'DR'){
							alert('?????? ??????????????? ???????????????.');
						}else if(data.result.resultName == 'VAT'){
							alert('????????? ??????????????? ???????????????.');
						}else if(data.result.resultName == 'CR'){
							alert('?????? ??????????????? ???????????????.');
						}
						returnResult =  false;
	            	}else{
	            		for(var i = 0; i< data.result.aaData.length; i++){
	            			var item = data.result.aaData[i];
	            			if(item.acctType == 'DR'){
	            				$('#txtDrAcctCode').val(item.acctCode);
	            				$('#txtDrAcctName').val(item.acctName);
	            			} else if(item.acctType == 'VAT'){
	            				$('#txtVatAcctCode').val(item.acctCode);
	            				$('#txtVatAcctName').val(item.acctName);
	            			} else if(item.acctType == 'CR'){
	            				$('#txtCrAcctCode').val(item.acctCode);
	            				$('#txtCrAcctName').val(item.acctName);
	            			}    
	            		}
	            	}
	            },
	            error : function( data ) {
	                console.log('	[untitled error in fnCheckNecessaryCode ]');
	            }
			});
			return returnResult;
		}
	}
	
	/* ???????????? ?????? ??????  */
	function fnCommonCodePop(type, pressEnterYN) {
		var callback = '';
		var searchStr = {};
		var acctType = '';

		switch (type) {
			case "VatType":
				type = 'VatType';
				callback = 'fnAuthVatTypePopup';
				searchStr = ($("#txtVaTypeName").val() || '');
				acctType = '';
				break;
			case "ErpAuth":
				type = 'Acct';
				callback = 'fnAuthErpAuthPopup';
				searchStr = ($("#txtErpAuthName").val() || '');
				acctType = 'AUTH';
				break;

// 			case "NoTax":
// 				type = 'NoTax';
// 				callback = 'fnNoTaxPopup';
// 				searchStr = ($("#txtErpAuthName").val() || '');
// 				acctType = 'AUTH';
// 				break;
			case "Va":
				type = 'Va';
				callback = 'fnAuthVaTypePopup';
				searchStr = ($("#txtAuthVaName").val() || '');
				acctType = '';
				break;
			
			case "CrAcct":
				type = 'Acct';
				callback = 'fnAuthCrAcctPopup';
				searchStr = ($("#txtCrAcctName").val() || '');
				acctType = 'CR';
				break;
			case "VatAcct":
				type = 'Acct';
				callback = 'fnAuthVatAcctPopup';
				searchStr = ($("#txtVatAcctName").val() || '');
				acctType = 'VAT';
				break;
		}

		if (!pressEnterYN) {
			searchStr = '';
		}
		var Popresult = fnOpenCodePop({
			codeType : type,
			callback : callback,
			searchStr : searchStr,
			acct_type : (acctType || ''),
			reflectResultPop : true
		});
	}

    /* ??????????????? */
    function fnConfigAuthNoTaxPopUp( param ) {
        $('#txtAuthNotaxCode').val(param.obj.noTaxCode);
        $('#txtAuthNotaxName').val(param.obj.noTaxName);
        focus_fnSetNextFocus();
        return;
    }
    
    /* ???????????? */
    function fnAuthVaTypePopup( param ) {
        $('#txtAuthVaCode').val(param.obj.vaTypeCode);
        $('#txtAuthVaName').val(param.obj.vaTypeName);
        focus_fnSetNextFocus();
        return;
    }
	
	/* ???????????? ????????? ?????? */
	function fnAuthVatAcctPopup(param) {
		$('#txtVatAcctCode').val(param.obj.acctCode || '');
		$('#txtVatAcctName').val(param.obj.acctName || '');
		focus_fnSetNextFocus();
		return;
	}

	/* ??????????????? ?????? */
	function fnAuthVatTypePopup(param) {
		$('#txtVatTypeCode').val(param.obj.vatTypeCode || '');
		$('#txtVatTypeName').val(param.obj.vatTypeName || '');
		if(ifSystem === 'iCUBE'){
	        switch (param.obj.vatTypeCode) {
				case '23':
				case '24':
				case '26':
					// ?????? ?????? ??????????????? ???????????? ????????? ?????????
					$(".ERPElement, .iCUBEVat").show();
					$(".ERPiUVat").hide();
					break;
				default:
					$('#txtAuthVaCode').val('');
					$('#txtAuthVaName').val('');
					$(".iCUBEVat, .ERPElement").hide();
					
					break;
			}
        }else if(ifSystem === 'ERPiU'){
	        switch (param.obj.vatTypeCode) {
	        	case '21':
	        	case '22':
	        	case '24':
	        	case '31':
	        	case '38':
	        	case '43':
	        	case '50':
	        		// ????????? ?????? ??????????????? ????????? ?????????
					if(param.obj.vatTypeCode === '22' || param.obj.vatTypeCode === '50'){
						$(".ERPElement, .ERPiUVat").show();
						$(".iCUBEVat").hide();	
					}else{
						$(".ERPiUVat, .ERPElement").hide();	
					}
					break;
				default:
					$(".ERPiUVat, .ERPElement").hide();
					break;
			}
	    }
		focus_fnSetNextFocus();
		return;
	}

	/* ???????????? ?????? ?????? */
	function fnAuthCrAcctPopup(param) {
		$('#txtCrAcctCode').val(param.obj.acctCode || '');
		$('#txtCrAcctName').val(param.obj.acctName || '');
		focus_fnSetNextFocus();
		return;
	}

	/* ???????????? ?????? */
	function fnAuthErpAuthPopup(param) {
		$('#txtErpAuthCode').val(param.obj.acctCode || '');
		$('#txtErpAuthName').val(param.obj.acctName || '');
		focus_fnSetNextFocus();
		return;
	}

	/* ????????? ????????? ????????? */
	function dalBoxScroll() {
		var leftTableContentsLeft = $(".dal_BoxIn .leftContents").scrollLeft();
		$(".dal_BoxIn .leftHeader").scrollLeft(leftTableContentsLeft);
	};

	/* ???????????? ?????? ?????? */
	function dal_Box_detail() {
		var $DALBD = $(".dal_Box_detail");
		$DALBD.removeClass("animated05s fadeInRight").addClass(
				"animated05s fadeOutRight");
		$(".posi_left table td").parent().removeClass('on');
		setTimeout(function() {
			$DALBD.hide();
		}, 500);
	};

	/* ## ---------------------------------------------------------------------------------------------------------- ##*/

	/* ## ---------------------------------------------------------------------------------------------------------- ##*/
	/* ## ????????? ???????????? ##*/

	/* ## ---------------------------------------------------------------------------------------------------------- ##*/
</script>

<div class="modal" style="display: none;"></div>

<div class="sub_contents">
	<!-- iframe wrap -->
	<div class="iframe_wrap">
		<!-- ??????????????? -->
		<div class="top_box">
			<dl>
				<dt>?????????</dt>
				<dd>
					<input type="text" id="txtSearchStr" style="width: 186px;" />
				</dd>
				<dt>????????????</dt>
				<dd>
					<input id="selUseYN" class="kendoComboBox" />
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="??????" />
				</dd>
			</dl>
		</div>

		<div class="sub_contents_wrap posi_re">
			<div class="btn_div">
				<div class="left_div">
					<p class="tit_p m0 mt5">???????????? ??????</p>
				</div>
				<div class="right_div">
					<div class="controll_btn p0">
						<button id="btnDel">??????</button>
						<button id="btnAdd">??????</button>
					</div>
				</div>
			</div>

			<div class="dal_Box stExtract">
				<!-- ???????????? -->
				<div class="dal_BoxIn posi_re">
					<div class="posi_left" style="width: 60%;">
						<div class="com_ta2 sc_head2 rowHeight ovh leftHeader">
							<table style="table-layout: fixed;">
								<colgroup>
									<col width="34" />
									<col width="40" />
									<col width="60" />
									<col width="90" />
									<col width="90" />
									<col width="80" />
									<col width="80" />
									<col width="90" />
									<col width="90" />
									<col width="60" />
								</colgroup>
								<thead>
									<tr class="borderR">
										<th rowspan="2"><input type="checkbox" name="all_chk" id="allChk" />&nbsp;<label for="allChk"></label></th>
										<th colspan="2">????????????</th>
										<th rowspan="2">???????????????<br />(????????????)
										</th>
										
										<c:if test="${ifSystem == 'ERPiU' }">
										<th rowspan="2">???????????????</th>
										</c:if>
										<c:if test="${ifSystem == 'iCUBE' }">
										<th rowspan="2">????????????</th>
										</c:if>
										
										<th colspan="2">????????????(??????/??????)</th>
										<th rowspan="2">????????????</th>
										<th rowspan="2">??????<br />????????????
										</th>
										<th rowspan="2">??????<br />??????
										</th>
									</tr>
									<tr class="borderR">
										<th>??????</th>
										<th>??????</th>
										<th>??????</th>
										<th>?????????</th>
									</tr>
								</thead>
							</table>
						</div>
						<div class="com_ta2 borderB rowHeight cursor_p bg_lightgray ova_sc2 leftContents" onScroll="dalBoxScroll()" style="height: 344px;">
							<table class="brtn">
								<colgroup>
									<col width="34" />
									<col width="40" />
									<col width="60" />
									<col width="90" />
									<col width="90" />
									<col width="80" />
									<col width="80" />
									<col width="90" />
									<col width="90" />
									<col width="60" />
								</colgroup>
								<tbody id="authTableList">
									<!-- 									
									<tr class="borderR">
										<td class="nocon"><input type="checkbox" name="inp_chk" id="Chk01" class="" disabled="" />&nbsp;<label class="" for="Chk01"><span></span></label></td>
										<td colspan="8" class="nocon">???????????? ????????? ????????????.</td>
									</tr>
									<tr class="borderR">
										<td><input type="checkbox" name="inp_chk" id="Chk02" class="" />&nbsp;<label class="" for="Chk02"><span></span></label></td>
										<td class="cen">03</td>
										<td class="cen ellipsis">??????</td>
										<td class="cen ellipsis">??????(??????)</td>
										<td class="cen ellipsis"></td>
										<td class="cen ellipsis"></td>
										<td class="cen ellipsis">12/??????????????????</td>
										<td class="cen ellipsis"></td>
										<td class="cen">??????</td>
									</tr> 
-->
								</tbody>
							</table>
						</div>
					</div>

					<!-- ????????? default -->
					<div class="posi_right disInfoBox borderB" style="left: 60%; height: 400px;">
						<div class="text01">???????????? ?????? ??????</div>
						<div class="text02">
							<ul>
								<li>- ???????????? ?????? ????????? ??????[??????] ????????? ????????? ?????????.</li>
								<li>- ?????? ???????????? ???????????? ?????? ?????? ??? ?????? ?????? ????????? ???????????????.</li>
								<li><br /></li>
								<li>??? ??????????????? ?????? ????????? ????????????, ????????? ????????????, ??????????????? ??????????????? ????????? ????????? ??????????????? ????????? ???????????????. ???????????? ????????? ???????????? ???????????? ?????? ??? ????????? ???????????????.</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- ????????? -->
			<div class="dal_Box_detail scroll_on boxHeight stExtract" style="left: 60%;">
				<div class="btn_div posi_re">
					<div class="left_div">
						<h5>????????????</h5>
					</div>
					<div class="controll_btn p0 mr30">
						<button id="btnSave" type="button">??????</button>
					</div>
					<a href="#n" class="close" onclick="dal_Box_detail()"></a>
				</div>

				<div class="com_ta">
					<table>
						<colgroup>
							<col width="120" />
							<col width="100" />
							<col width="" />
						</colgroup>
						<tr>
							<th colspan="2"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> ??????????????????</th>
							<td><input type="text" class="txt_reset" id="txtAuthCode" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th rowspan="4"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> ??????????????????</th>
							<th><img src="../../../Images/ico/ico_check01.png" alt=""> ?????????</th>
							<td><input type="text" id="txtAuthNameKr" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>??????</th>
							<td><input type="text" id="txtAuthNameEn" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>?????????</th>
							<td><input type="text" id="txtAuthNameJp" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>?????????</th>
							<td><input type="text" id="txtAuthNameCn" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th colspan="2">???????????????(????????????)</th>
							<td><input type="text" class="txt_reset" id="txtVatTypeName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtVatTypeCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnAuthVatTypePopup">??????</button>
									<button class="reload_btn" title="?????????"></button>
								</div></td>
						</tr>
						<tr>
							<th rowspan="2">????????????</th>
							<th>??????</th>
							<td><input type="text" class="txt_reset" id="txtCrAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtCrAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnAuthCrAcctPopup">??????</button>
									<button class="reload_btn" title="?????????"></button>
								</div></td>
						</tr>
						<tr>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>"></img>?????????</th>
							<td><input type="text" class="txt_reset" id="txtVatAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtVatAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnAuthVatAcctPopup">??????</button>
									<button class="reload_btn" title="?????????"></button>
								</div></td>
						</tr>
						<tr>
							<th colspan="2">????????????</th>
							<td><input type="text" class="txt_reset" id="txtErpAuthName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtErpAuthCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnAuthErpAuthPopup">??????</button>
									<button class="reload_btn" title="?????????"></button>
								</div></td>
						</tr>
						<tr>
							<th colspan="2">??????????????????</th>
							<td><input type="checkbox" name="op_chk" id="chkConfigAuthNoteReq" class="" />&nbsp;<label class="mb5" for="chkConfigAuthNoteReq"><span>??????</span></label> <br /> <input type="checkbox" name="op_chk" id="chkConfigAuthAuthReq" class="" />&nbsp;<label class="mb5" for="chkConfigAuthAuthReq"><span>????????????</span></label> <br /> <input type="checkbox" name="op_chk" id="chkConfigAuthCardReq" class="" />&nbsp;<label class="mb5" for="chkConfigAuthCardReq"><span>????????????</span></label> <br /> <input type="checkbox" name="op_chk" id="chkConfigAuthPartnerReq" class="" />&nbsp;<label class="mb5" for="chkConfigAuthPartnerReq"><span>?????????</span></label> <br /> <input type="checkbox" name="op_chk" id="chkConfigAuthProjectReq" class="" />&nbsp;<label class="" for="chkConfigAuthProjectReq"><span>????????????</span></label></td>
						</tr>
						<tr>
							<th colspan="2">????????????</th>
							<td><input type="text" id="txtAuthOrderNum" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th colspan="2">????????????</th>
							<td><input type="radio" name="useRadio" id="useN" value="N" class="" checked="" />&nbsp;<label for="useN">?????????</label> <input type="radio" name="useRadio" id="useY" value="Y" class="ml10" />&nbsp;<label for="useY">??????</label></td>
						</tr>
						<tr style="display: none;" class="ERPElement">
						<c:if test="${ifSystem == 'ERPiU' }">
							<th class="ERPiUVat" colspan="2"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id='NoTax'/>
							${CL.ex_noType}(ERPiU)</th>
							<td class="ERPiUVat">
								<input id="txtAuthNotaxCode" type="hidden" style="width: 59%;" class="txt_reset" /> 
								<input id="txtAuthNotaxName" type="text" style="width: 59%;" class="txt_reset" />
								<div class="controll_btn p0">
									<button id="btnAuthNotaxPopup"><%=BizboxAMessage.getMessage("TX000000265","??????")%></button>
									<button class="reload_btn"></button>
								</div>
							</td>
						</c:if>
						<c:if test="${ifSystem == 'iCUBE' }">
							<th class="iCUBEVat" colspan="2"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id='vatReason'/>
							${CL.ex_reasonType}(ICUBE)</th>
							<td class="iCUBEVat">
								<input id="txtVaTypeCode" type="hidden" style="width: 59%;" class="txt_reset" /> 
								<input id="txtVaTypeName" type="text" style="width: 59%;" class="txt_reset" />
								<div class="controll_btn p0">
									<button id="btnAuthVaPopup"><%=BizboxAMessage.getMessage("TX000000265","??????")%></button>
									<button class="reload_btn"></button>
								</div>
							</td>
						</c:if>
						</tr>
					</table>
				</div>
			</div>

		</div>
		<!-- //sub_contents_wrap -->
	</div>
	<!-- iframe wrap -->
</div>
<!-- //sub_contents -->