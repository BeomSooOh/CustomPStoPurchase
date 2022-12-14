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
	$ ( document ).ready ( function ( ) {
		fnInit ( );
		//PuddManager.create('#txtSearchStr',   'PuddText', { } ); 
	} );

	/* ?????? ????????? ?????? */
	function fnInit ( ) {
		/* ???????????? */
		var useYNInfo = ('${useYN}' === '' ? [] : ${useYN});
		var comboBoxItem = [];
		$.each(useYNInfo, function(idx, item) {
			var itemObj = {};
			itemObj.commonCode = item.code;
			itemObj.commonName = item.name;
			comboBoxItem.push(itemObj);
		});
		
		exComboBox($('#selUseYN'), comboBoxItem, function(){
			fnSummaryListInfo();
		});
		
		fnInitEvent ( );
		$ ( "#btnSearch" ).click ( );
		return;
	}

	/* ?????? ????????? ?????? */
	function fnInitEvent ( ) {
		/* ?????? */
		$ ( "#btnSearch" ).click ( function ( ) {
			fnSubLayerInfoReset();
			dal_Box_detail();
			fnSummaryListInfo ( );
		} );

		/* ?????? */
		$ ( "#btnDel" ).click ( function ( ) {
			fnSummaryDelete ( );
		} );

		/* ?????? */
		$ ( "#btnAdd" ).click ( function ( ) {
			var $DALBD = $(".dal_Box_detail");
			$DALBD.removeClass("animated05s fadeOutRight").addClass("animated05s fadeInRight").show();
			
			fnSubLayerInfoReset ( );
		} );

		/* ?????? */
		$ ( "#btnSave" ).click ( function ( ) {
			fnSummarySave ( );
		} );

		/* ????????? ????????? ?????? ????????? */
		$("#summaryTableList").on("click", "tr", function(){
			onSelect(this);
		});

		/* ?????? ?????? */
		/* ????????? ????????????, ?????? ????????????, ?????? ????????????, ?????? ?????? */
		$ ( "#btnConfigSummaryVatAcctPopup, #btnConfigSummaryDrAcctPopup, #btnConfigSummaryCrAcctPopup, #btnConfigSummaryErpAuthPopup" ).on ( "click", function ( ) {
			var type = this.id.toString ( ).replace ( 'btnConfigSummary', '' ).replace ( 'Popup', '' );
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
    	$('#txtDrAcctName, #txtVatAcctName, #txtCrAcctName, #txtErpAuthName').bind('keydown', function( event ) {
    		/* ???????????? ????????? ?????? */
	        if (event.which == 13 || event.which == 113) {
	        	var type = this.id.toString ( ).replace ( 'txt', '' ).replace ( 'Name', '' );
	        	fnCommonCodePop(type, true);
	        }
	    });
        
        /* ????????? ?????? - ??????????????? ????????? ?????? jQuery.exp.expend.focus.js ?????? */
        focus_fnSetFocusEvent(
       		[
       		 'txtSummaryCode'
       		, 'txtSummaryNameKr'
       		, 'txtDrAcctName'
       		, 'txtVatAcctName'
       		, 'txtCrAcctName'
       		]
     	);
		return;
	}
	
	/* ???????????? ?????? */
	var summaryJsonData = new Map();
	var baseData = '';
	function fnSummaryListInfo ( ) {
		/* ???????????? */
        var param = {};
        param.compSeq = '${empInfo.compSeq}';
        searchCompSeq = '${empInfo.compSeq}'; /* ?????? ????????? ?????? */
        param.codeType = 'SUMMARY'
//      param.summary_div = $('#selSummaryType').val(); // ????????? A??? ??????, ?????? ???????????? ????????? ??????
        param.summaryDiv = 'A';
        param.searchStr = $('#txtSearchStr').val();
		param.useYN = $("#selUseYN").val();

        /* ???????????? ????????? ?????? */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex2/admin/summary/setAdminSummaryListSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	baseData = data.result.aaData
            	
            	/* ???????????? ???????????? ???????????? ?????? ??? */
            	if(data.result.aaData.length == 0) {
            		 /* ????????? ????????? ????????? */
            		fnSummaryListBind('');
            	} else {
            		/* ?????? ??? ?????? */
            		for(var i=0; i<data.result.aaData.length; i++) {
            			summaryJsonData.put(i, data.result.aaData[i])
            		}
            		
            		/* ????????? ????????? ????????? */
                    fnSummaryListBind(data.result.aaData);
            	}
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
		return;
	}
	
	/* ????????? ????????? */
	function fnSummaryListBind ( data ) {
		//console.log(JSON.stringify(data));   
		var tag = '';
		var length = data.length;
		
		if(data != '') {
			for(var i=0; i<length; i++) {
				var useText = '';
				
				if(data[i].useYN == "Y" || data[i].useYN == "") {
					useText = "??????";
				} else {
					useText = "?????????";
				}
				
				tag += '<tr id="' + i + '" class="borderR">';
				tag += '  <td onclick="event.cancelBubble=true;">';
				tag += '    <input type="checkbox" class="chkSummaryCode" name="chkSummaryCode" id="summaryCode_' + data[i].summaryCode +'" class=""/>';
				tag += '    <label class="" for="summaryCode_' + data[i].summaryCode +'"><span></span></label>';
				tag += '  </td>';
				tag += '  <td>' + data[i].summaryCode + '</td>';
				tag += '  <td>' + data[i].summaryName + '</td>';
				tag += '  <td>' + data[i].drAcctCode + '/' + data[i].drAcctName + '</td>';
				tag += '  <td>' + data[i].vatAcctCode + '/' + data[i].vatAcctName + '</td>';
				tag += '  <td>' + data[i].crAcctCode + '/' + data[i].crAcctName + '</td>';
				tag += '  <td>' + data[i].erpAuthCode + '/' + data[i].erpAuthName + '</td>';
				tag += '  <td class = "cen">' + useText + '</td>';
				tag += '</tr>';	
			}
			
		} else {
			tag += '<tr class="borderR">';
			tag += '  <td class="nocon" onclick="event.cancelBubble=true;">';
			tag += '    <input type="checkbox" name="inp_chk" id="Chk01" class="" disabled="" />';
			tag += '    <label class="" for="Chk01"><span></span></label>';
			tag += '  </td>';
			tag += '  <td colspan="6" class="nocon">???????????? ????????? ????????????.</td>';
			tag += '</tr>';	
		}
		
		$("#summaryTableList").html(tag);
		
		return;
	}	

	/* ????????? ????????? ?????? ????????? */
	function onSelect(data) {
		var summaryCode = $(data).attr("id");
		
		$("#summaryTableList tr").removeClass("on");
		
		$(data).addClass("on");
		
		/* ?????? ???????????? ?????? ?????? */
		fnSummaryDetailInfo(summaryCode);
	}
	
	/* ?????? ???????????? ?????? ?????? */
	function fnSummaryDetailInfo(code) {
		/* ???????????? */
		var summaryCode = code;
		
		/* ???????????? ?????? */
		var $DALBD = $(".dal_Box_detail");
		$DALBD.removeClass("animated05s fadeOutRight").addClass("animated05s fadeInRight").show();
		
		/* summaryCode ????????? ?????? */
		if(summaryCode == null || summaryCode == "undefined" || summaryCode == "") {
			console.log("???????????? ????????? ??????????????????.");
			summaryCode = "";
		} else {
			$('#txtSummaryCode').attr('disabled', 'disabled');
			
			var summaryItems = summaryJsonData.get(summaryCode);
			
			//console.log("summayItems : " + JSON.stringify(summaryItems));
			
			$("#txtSummaryCode").val(summaryItems.summaryCode);
			$("#txtSummaryNameKr").val(summaryItems.summaryNameKr);
			$("#txtSummaryNameEn").val(summaryItems.summaryNameEn);
			$("#txtSummaryNameJp").val(summaryItems.summaryNameJp);
			$("#txtSummaryNameCn").val(summaryItems.summaryNameCn);
			$("#txtDrAcctCode").val(summaryItems.drAcctCode);
			$("#txtDrAcctName").val(summaryItems.drAcctName);
			$("#txtCrAcctCode").val(summaryItems.crAcctCode);
			$("#txtCrAcctName").val(summaryItems.crAcctName);
			$("#txtVatAcctCode").val(summaryItems.vatAcctCode);
			$("#txtVatAcctName").val(summaryItems.vatAcctName);
			$("#txtErpAuthCode").val(summaryItems.erpAuthCode);
			$("#txtErpAuthName").val(summaryItems.erpAuthName);
			$("#txtSummaryOrderNum").val(summaryItems.orderNum);
		}
	}

	/* ???????????? ????????? */
	function fnSubLayerInfoReset ( ) {
		/* ????????? */
		$ ( '#txtSummaryCode' ).val ( '' ); /* ???????????? ????????? */
		$ ( '#txtSummaryNameKr' ).val ( '' ); /* ????????? ?????? ????????? */
		$ ( '#txtSummaryNameEn' ).val ( '' ); /* ????????? ?????? ????????? */
		$ ( '#txtSummaryNameJp' ).val ( '' ); /* ????????? ????????? ????????? */
		$ ( '#txtSummaryNameCn' ).val ( '' ); /* ????????? ????????? ????????? */
		$ ( '#txtDrAcctCode' ).val ( '' ); /* ?????????????????? ????????? */
		$ ( '#txtDrAcctName' ).val ( '' ); /* ?????????????????? ????????? */
		$ ( '#txtCrAcctCode' ).val ( '' ); /* ?????????????????? ????????? */
		$ ( '#txtCrAcctName' ).val ( '' ); /* ?????????????????? ????????? */
		$ ( '#txtVatAcctCode' ).val ( '' ); /* ????????????????????? ????????? */
		$ ( '#txtVatAcctName' ).val ( '' ); /* ????????????????????? ????????? */
		$ ( '#txtErpAuthCode' ).val ( '' ); /* ?????? ?????? ????????? */
		$ ( '#txtErpAuthName' ).val ( '' ); /* ?????? ?????? ????????? */

		/* ???????????? ?????? */
		$ ( '#txtSummaryCode' ).removeAttr ( 'disabled' ); /* ???????????? */
		$('#txtSummaryOrderNum').val(''); /* ???????????? ????????? */
		
		return;
	}
	
	/* ???????????? ?????? */
	function fnSummarySave ( ) {
		/* ?????? ?????? ?????? ???????????? */
		if(fnCheckNecessaryCode() == false){
			return;
		}
		
		/* ???????????? */
		var param = {};
		var paramCheck = false;
		var url = '';

		param.compSeq = '${empInfo.compSeq}';
		param.summaryCode = $ ( '#txtSummaryCode' ).val ( );
		param.summaryName = $ ( '#txtSummaryNameKr' ).val ( );
		param.summaryNameEn = $ ( '#txtSummaryNameEn' ).val ( );
		param.summaryNameCn = $ ( '#txtSummaryNameCn' ).val ( );
		param.summaryNameJp = $ ( '#txtSummaryNameJp' ).val ( );
//      param.summary_div = $('#selSummaryTypeInput').val();// ????????? A??? ??????, ?????? ???????????? ????????? ??????
		param.summaryDiv = 'A';
		param.drAcctCode = $ ( '#txtDrAcctCode' ).val ( );
		param.drAcctName = $ ( '#txtDrAcctName' ).val ( );
		param.crAcctCode = $ ( '#txtCrAcctCode' ).val ( );
		param.crAcctName = $ ( '#txtCrAcctName' ).val ( );
		param.vatAcctCode = $ ( '#txtVatAcctCode' ).val ( );
		param.vatAcctName = $ ( '#txtVatAcctName' ).val ( );
		param.erpAuthCode = $ ( '#txtErpAuthCode' ).val ( );
		param.erpAuthName = $ ( '#txtErpAuthName' ).val ( );
		param.useYN = $('input:radio[name="useRadio"]:checked').val();
		param.orderNum = $('#txtSummaryOrderNum').val() || 0;

		/* ????????? ?????? */
		paramCheck = fnSaveParamCheck ( param );
		
		var attr = $('#txtSummaryCode').attr('disabled');
		
		/* ??????/?????? ?????? */
		if(typeof attr !== typeof undefined && attr !== false) {
			url = '<c:url value="/expend/ex2/admin/summary/setAdminSummaryUpdate.do" />';
		} else {
			url = '<c:url value="/expend/ex2/admin/summary/setAdminSummaryInsert.do" />';
		}
		
		if ( paramCheck ) {
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
	            error : function( data ) {
	                console.log("! [EX] ERROR - " + JSON.stringify(data));
	            }
			});
		} else {
			console.log("????????? ??????");
			return;
		}

		return;
	}	
	
	/* ???????????? ?????? */
	function fnSummaryDelete ( ) {
		
		if(!confirm("<%=BizboxAMessage.getMessage("","????????? ???????????? ????????? ?????????????????????????")%>")){
    		return;
    	}
		
		 var param = {};
		 param.compSeq = '${empInfo.compSeq}';
		 //param.summaryCode = $("#txtSummaryCode").val();
		 param.summaryDiv = 'A';
		 
		 /* ???????????? ????????? */
		 if($("input:checkbox[name='chkSummaryCode']:checked").length > 0) {
			 var summaryCodes = '';
			 
			 $(".chkSummaryCode").each(function(){
				if($(this).prop("checked")) {
					console.log("id : " + $(this).attr("id"));
					summaryCodes += $(this).attr("id").replace("summaryCode_", "") + ",";
				} 
			 });
			 
			 param.summaryCode = summaryCodes;
		 } else {
			 alert("<%=BizboxAMessage.getMessage("","????????? ??????????????? ??????????????????")%>");
		 }
		 
		 $.ajax({
			type : 'post',
            url : '<c:url value="/expend/ex2/admin/summary/setAdminSummaryDelete.do" />',
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

	/* ?????? ???????????? ?????? */
	function fnSummaryDrAcctPopup ( param ) {
		$ ( '#txtDrAcctCode' ).val ( param.obj.acctCode || '' );
		$ ( '#txtDrAcctName' ).val ( param.obj.acctName || '' );
		//focus_fnSetNextFocus ( );
		return;
	}

	/* ?????? ?????? ?????? */
	function fnSummaryErpAuthPopup ( param ) {
		$ ( '#txtErpAuthCode' ).val ( param.obj.acctCode || '' );
		$ ( '#txtErpAuthName' ).val ( param.obj.acctName || '' );
		//focus_fnSetNextFocus ( );
		return;
	}

	/* ????????? ???????????? ?????? */
	function fnSummaryVatAcctPopup ( param ) {
		$ ( '#txtVatAcctCode' ).val ( param.obj.acctCode || '' );
		$ ( '#txtVatAcctName' ).val ( param.obj.acctName || '' );
		//focus_fnSetNextFocus ( );
		return;
	}

	/* ?????? ???????????? ?????? */
	function fnSummaryCrAcctPopup ( param ) {
		$ ( '#txtCrAcctCode' ).val ( param.obj.acctCode || '' );
		$ ( '#txtCrAcctName' ).val ( param.obj.acctName || '' );
		//focus_fnSetNextFocus ( );
		return;
	}

	/* ???????????? ?????? ??????  */
	function fnCommonCodePop ( type, pressEnterYN ) {
		var callback = '';
		var searchStr = {};
		var acctType = '';

		switch ( type ) {
			case "VatAcct":
				type = 'Acct';
				callback = 'fnSummaryVatAcctPopup';
				searchStr = ( $ ( "#txtVatAcctName" ).val ( ) || '' );
				acctType = 'VAT';
				break;
			case "DrAcct":
				type = 'Acct';
				callback = 'fnSummaryDrAcctPopup';
				searchStr = ( $ ( "#txtDrAcctName" ).val ( ) || '' );
				acctType = 'DR';
				break;
			case "CrAcct":
				type = 'Acct';
				callback = 'fnSummaryCrAcctPopup';
				searchStr = ( $ ( "#txtCrAcctName" ).val ( ) || '' );
				acctType = 'CR';
				break;
			case "ErpAuth":
				type = 'Acct';
				callback = 'fnSummaryErpAuthPopup';
				searchStr = ( $ ( "#txtErpAuthName" ).val ( ) || '' );
				acctType = 'AUTH';
				break;
		}

		if ( !pressEnterYN ) {
			searchStr = '';
		}
		var Popresult = fnOpenCodePop ( {
			codeType: type,
			callback: callback,
			searchStr: searchStr,
			acct_type: ( acctType || '' ),
			reflectResultPop: true
		} );
	}

	/* ?????? ????????? ?????? */
	function fnSaveParamCheck ( data ) {
		var base = JSON.stringify(baseData);
		
		if ( data.summaryCode == "" || data.summaryCode == null || data.summaryCode == "undefined") {
			alert("<%=BizboxAMessage.getMessage("TX000018754", "??????????????? ???????????? ????????????")%>");
			return false;
		}
		if ( data.summaryName == "" || data.summaryName == null || data.summaryName == "undefined") {
			alert("<%=BizboxAMessage.getMessage("TX000018755", "??????????????? ???????????? ????????????")%>");
			return false;
		}
		if ( data.drAcctCode == "" || data.drAcctCode == null || data.drAcctCode == "undefined") {
			alert("<%=BizboxAMessage.getMessage("TX000003521", "????????????????????? ???????????? ????????????")%>");
			return false;
		}
		if ( data.crAcctCode == "" || data.crAcctCode == null || data.crAcctCode == "undefined") {
			alert("<%=BizboxAMessage.getMessage("TX000003522", "????????????????????? ???????????? ????????????")%>");
			return false;
		}
		if( (!$('#txtSummaryCode:disabled').length) &&  base.indexOf('"summaryCode":"'+data.summaryCode+'"') > -1){
    		alert("<%=BizboxAMessage.getMessage("TX000003523","???????????? ??????????????? ?????? ????????????????????????. ??????????????? ?????? ???????????? ????????????")%>");
    		return false;
    	}

		return true;
	}
	
	/* ????????? ????????? ????????? */
	function dalBoxScroll() {
		var leftTableContentsLeft = $(".dal_BoxIn .leftContents").scrollLeft();
    	$(".dal_BoxIn .leftHeader").scrollLeft(leftTableContentsLeft);
	};
	
	/* ???????????? ?????? ?????? */
	function dal_Box_detail(){
		var $DALBD = $(".dal_Box_detail");
			$DALBD.removeClass("animated05s fadeInRight").addClass("animated05s fadeOutRight");
			$(".posi_left table td").parent().removeClass('on');
			setTimeout(function(){$DALBD.hide();},500);
	};

	/* ## ---------------------------------------------------------------------------------------------------------- ##*/
	/* ## ????????? ???????????? ##*/

	/* ## ---------------------------------------------------------------------------------------------------------- ##*/
</script>

<div class="modal" style="display: none;"></div>

<div class="sub_contents_wrap">
	<!-- iframe wrap -->
	<div class="iframe_wrap">
		<!-- ??????????????? -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_keyWord}</dt>
				<dd>
					<pudd:input setAttribute="{ 'style':{'width':'186px'} }"></pudd:input>
					<!-- <input type="text" id="txtSearchStr" style="width: 186px;" /> -->
				</dd>

				<dt>????????????</dt>
				<dd>
					<input id="selUseYN" class="kendoComboBox" />
				</dd>

				<dd>
					<input type="button" id="btnSearch" value="${CL.ex_search}" />
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
						<button id="btnDel"><%=BizboxAMessage.getMessage( "TX000000424", "??????" )%></button>
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
									<col width="60" />
									<col width="80" />
									<col width="120" />
									<col width="120" />
									<col width="120" />
									<col width="120" />
									<col width="60" />
								</colgroup>
								<thead>
									<tr class="borderR">
										<th rowspan="2"><input type="checkbox" name="all_chk" id="allChk" />&nbsp;<label for="allChk"></label></th>
										<th colspan="2">????????????</th>
										<th colspan="3">??????????????????(??????/??????)</th>
										<th rowspan="2">ERP??????</th>
										<th rowspan="2">??????<br />??????
									</tr>
									<tr class="borderR">
										<th>??????</th>
										<th>??????</th>
										<th>??????-????????????</th>
										<th>?????????-????????????</th>
										<th>??????-????????????</th>
									</tr>
								</thead>
							</table>
						</div>
						<div id="divSummaryList" class="com_ta2 borderB rowHeight cursor_p bg_lightgray ova_sc2 leftContents" onScroll="dalBoxScroll()" style="height: 344px;">
							<table id="tblSummaryList" class="brtn">
								<colgroup>
									<col width="34" />
									<col width="60" />
									<col width="80" />
									<col width="120" />
									<col width="120" />
									<col width="120" />
									<col width="120" />
									<col width="60" />
								</colgroup>
								<tbody id="summaryTableList">
									<!-- 
									<tr class="borderR">
										<td class="nocon"><input type="checkbox" name="inp_chk"
											id="Chk01" class="" disabled="" />&nbsp;<label class=""
											for="Chk01"><span></span></label></td>
										<td colspan="6" class="nocon">???????????? ????????? ????????????.</td>
									</tr>
									<tr class="borderR">
										<td>
										  <input type="checkbox" name="inp_chk" id="Chk02" class="" />&nbsp;
										  <label class="" for="Chk02"><span></span></label>
										</td>
										<td>8000</td>
										<td>????????????</td>
										<td>8260/???????????????</td>
										<td>-</td>
										<td>2530/????????????</td>
										<td></td>
									</tr>
									<tr class="borderR">
										<td><input type="checkbox" name="inp_chk" id="Chk03"
											class="" />&nbsp;<label class="" for="Chk03"><span></span></label>
										</td>
										<td>8001</td>
										<td>????????????</td>
										<td>8260/???????????????</td>
										<td>1350/??????????????????</td>
										<td>2530/????????????</td>
										<td>3/?????????(????????????)</td>
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
					<a href="#n" id="" class="close" onclick="dal_Box_detail()"></a>
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
							<td><input type="text" id="txtSummaryCode" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th rowspan="4"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> ??????????????????</th>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="">?????????</th>
							<td><input type="text" id="txtSummaryNameKr" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>??????</th>
							<td><input type="text" id="txtSummaryNameEn" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>?????????</th>
							<td><input type="text" id="txtSummaryNameJp" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>?????????</th>
							<td><input type="text" id="txtSummaryNameCn" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th rowspan="2">??????</th>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="">????????????</th>
							<td><input type="text" class="txt_reset" id="txtDrAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtDrAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnConfigSummaryDrAcctPopup">??????</button>
									<button class="reload_btn" title="?????????"></button>
								</div></td>
						</tr>
						<tr>
							<th>??????</th>
							<td><input type="text" class="txt_reset" id="txtErpAuthName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtErpAuthCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnConfigSummaryErpAuthPopup">??????</button>
									<button class="reload_btn" title="?????????"></button>
								</div></td>
						</tr>
						<tr>
							<th>?????????</th>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="">????????????</th>
							<td><input type="text" class="txt_reset" id="txtVatAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtVatAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnConfigSummaryVatAcctPopup">??????</button>
									<button class="reload_btn" title="?????????"></button>
								</div></td>
						</tr>
						<tr>
							<th>??????</th>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> ????????????</th>
							<td><input type="text" class="txt_reset" id="txtCrAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtCrAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnConfigSummaryCrAcctPopup">??????</button>
									<button class="reload_btn" title="?????????"></button>
								</div></td>
						</tr>
						<tr>
							<th colspan="2">????????????</th>
							<td><input type="text" id="txtSummaryOrderNum" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th colspan="2">????????????</th>
							<td><input type="radio" name="useRadio" id="useN" value="N" class="" checked="" />&nbsp;<label for="useN">?????????</label> <input type="radio" name="useRadio" id="useY" value="Y" class="ml10" />&nbsp;<label for="useY">??????</label></td>
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