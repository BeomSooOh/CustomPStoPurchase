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
	/* ## 장지훈 작업영역 ##*/
	var ifSystem = '${ifSystem}';
	
	$(document).ready(function(){
		$ ( document ).ready ( function ( ) {
			fnInit ( );
		} );
	});
	
	/* 최초 이벤트 정의 */
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
	
	/* 버튼 이벤트 정의 */
	function fnInitEvent() {
		/* 검색 */
		$ ( "#btnSearch" ).click ( function ( ) {
			fnSubLayerInfoReset();
			dal_Box_detail();
			fnAuthListInfo ( );
		} );
		
		/* 삭제 */
		$ ( "#btnDel" ).click ( function ( ) {
			fnAuthDelete ( );
		} );
		
		/* 추가 */
		$ ( "#btnAdd" ).click ( function ( ) {
			var $DALBD = $(".dal_Box_detail");
			$DALBD.removeClass("animated05s fadeOutRight").addClass("animated05s fadeInRight").show();
			
			fnSubLayerInfoReset ( );
		} );
		
		/* 저장 */
		$ ( "#btnSave" ).click ( function ( ) {
			fnAuthSave ( );
		} );
		
		/* 테이블 리스트 클릭 이벤트 */
		$("#authTableList").on("click", "tr", function(e){
			onSelect(this);
		});	
		
		/* 선택 버튼 */
		/* 부가세 구분, 대체계정 대변, 대체계정 부가세, 대체증빙 */
		$ ( "#btnAuthVatTypePopup, #btnAuthCrAcctPopup, #btnAuthVatAcctPopup, #btnAuthErpAuthPopup, #btnAuthVaPopup" ).on ( "click", function ( ) {
			var type = this.id.toString ( ).replace ( 'btnAuth', '' ).replace ( 'Popup', '' );
			fnCommonCodePop ( type, false );
			
		} );
		
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
        
        /* 엔터키를 이용한 검색 [공통 코드 팝업]*/
    	$('#txtVatTypeName, #txtCrAcctName, #txtVatAcctName, #txtErpAuthName').bind('keydown', function( event ) {
	        /* 엔터입력 이벤트 적용 */
	        if (event.which == 13 || event.which == 113) {
	        	var type = this.id.toString ( ).replace ( 'txt', '' ).replace ( 'Name', '' );
	        	fnCommonCodePop(type, true);
	        }
	    });
        
        /* 이벤트 정의 - 엔터입력시 포커스 이동 jQuery.exp.expend.focus.js 참조 */
        focus_fnSetFocusEvent(
       		[
       		 'txtAuthCode'
       		, 'txtAuthName'
       		, 'txtAuthVatAcctName'
       		, 'txtAuthVaName'
       		]
     	);
	}
	
	/* 증빙유형 데이터 호출 */
	var authJsonData = new Map();
	var baseData = '';
	function fnAuthListInfo() {
		/* 변수정의 */
        var param = {};
        param.compSeq = '${empInfo.compSeq}';
        searchCompSeq = '${empInfo.compSeq}'; /* 팝업 호출시 사용 */
//      param.summary_div = $('#selSummaryType').val(); // 현재는 A로 고정, 추후 매출결의 개발시 사용
        param.authDiv = 'A';
        param.searchStr = ($('#txtSearchStr').val() || '');
		param.useYN = $("#selUseYN").val();

		/* 표준적요 데이터 호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex2/admin/auth/setAdminAuthListSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	baseData = data.result.aaData
            	
            	/* 표준적요 데이터가 존재하지 않을 때 */
            	if(data.result.aaData.length == 0) {
            		/* 테이블 데이터 바인딩 */
                    fnAuthListBind('');
            	} else {
            		/* 수정 시 사용 */
            		for(var i=0; i<data.result.aaData.length; i++) {
            			authJsonData.put(i, data.result.aaData[i])
            		}
            		
            		/* 테이블 데이터 바인딩 */
            		fnAuthListBind(data.result.aaData);
            	}
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
		return;
	}
	
	/* 테이블 데이터 바인딩 */
	function fnAuthListBind(data) {
		var tag = '';
		var length = data.length;

		if (data != '') {
			for (var i = 0; i < length; i++) {
				var checkItems = '';
				var useText = '';
				
				if(data[i].noteRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "적요";
					} else {
						checkItems += "/적요";
					}
				}
				
				if(data[i].authRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "증빙일자";
					} else {
						checkItems += "/증빙일자";
					}
				}
				
				if(data[i].cardRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "법인카드";
					} else {
						checkItems += "/법인카드";
					}
				}
				
				if(data[i].partnerRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "거래처";
					} else {
						checkItems += "/거래처";
					}
				}
				
				if(data[i].projectRequiredYN == "Y") {
					if(checkItems == '') {
						checkItems = "프로젝트";
					} else {
						checkItems += "/프로젝트";
					}
				}
				
				if(data[i].useYN == "Y" || data[i].useYN == "") {
					useText = "사용";
				} else {
					useText = "미사용";
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
			tag += '  <td colspan="8" class="nocon">증빙유형 목록이 없습니다.</td>';
			tag += '</tr>';	
		}

		$("#authTableList").html(tag);

		return;
	}
	
	/* 테이블 리스트 클릭 이벤트 */
	function onSelect(data) {
		var authCode = $(data).attr("id");
		var varType = $(data).attr("type");
		$("#authTableList tr").removeClass("on");
		
		$(data).addClass("on");
		
		fnAuthDetailInfo(authCode, varType);
	}
	
	/* 상세 증빙유형 정보 조회 */
	function fnAuthDetailInfo(code, type) {
		/* 변수정의 */
		var authCode = code;
		var vatTypeCode = type;

		/* 슬라이드 팝업 */
		var $DALBD = $(".dal_Box_detail");
		$DALBD.removeClass("animated05s fadeOutRight").addClass(
				"animated05s fadeInRight").show();

		/* authCode 데이터 확인 */
		if (authCode == null || authCode == "undefined" || authCode == "") {
			console.log("표준적요 코드를 확인해주세요.");
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
			/* 적요 */
			if (authItems.noteRequiredYN == "Y") {
				$('#chkConfigAuthNoteReq').prop('checked', true);
			} else {
				$('#chkConfigAuthNoteReq').prop('checked', false);
			}

			/* 증빙일자 */
			if (authItems.authRequiredYN == "Y") {
				$('#chkConfigAuthAuthReq').prop('checked', true);
			} else {
				$('#chkConfigAuthAuthReq').prop('checked', false);
			}

			/* 법인카드 */
			if (authItems.cardRequiredYN == "Y") {
				$('#chkConfigAuthCardReq').prop('checked', true);
			} else {
				$('#chkConfigAuthCardReq').prop('checked', false);
			}

			/* 거래처 */
			if (authItems.partnerRequiredYN == "Y") {
				$('#chkConfigAuthPartnerReq').prop('checked', true);
			} else {
				$('#chkConfigAuthPartnerReq').prop('checked', false);
			}

			/* 프로젝트 */
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
	
	/* 상세설정 초기화 */
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

		/* 비활성화 해제 */
		$('#txtAuthCode').removeAttr('disabled');

		$('#chkConfigAuthNoteReq').prop('checked', false);
		$('#chkConfigAuthAuthReq').prop('checked', false);
		$('#chkConfigAuthCardReq').prop('checked', false);
		$('#chkConfigAuthPartnerReq').prop('checked', false);
		$('#chkConfigAuthProjectReq').prop('checked', false);
		$(".iCUBEVat").hide();
		return;
	}
	
	/* 증빙유형 저장 */
	function fnAuthSave ( ) {
		/* 입력 필수 코드 자동조회 */
// 		if(fnCheckNecessaryCode() == false){
// 			return;
// 		}
		
		/* 변수정의 */
		var param = {};
		var paramCheck = false;
		var url = '';

		param.compSeq = '${empInfo.compSeq}';
		param.authCode = $ ( '#txtAuthCode' ).val ( );	/* 증빙유형코드 */
		param.authName = $ ( '#txtAuthNameKr' ).val ( ); /* 증빙유형명칭(kr) */
		param.authNameEn = $ ( '#txtAuthNameEn' ).val ( ); /* 증빙유형명칭(en) */
		param.authNameCn = $ ( '#txtAuthNameCn' ).val ( ); /* 증빙유형명칭(cn) */
		param.authNameJp = $ ( '#txtAuthNameJp' ).val ( ); /* 증빙유형명칭(jp) */
//      param.auth_div = $('#selSummaryTypeInput').val();// 현재는 A로 고정, 추후 매출결의 개발시 사용
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

		param.cashType = $('#selConfigAuthCashType').val(); /* 현금영수증구분 */

        param.noTaxCode = $('#txtConfigAuthNotaxCode').val(); /* 불공제구분(ERPiU) 코드 */
        param.noTaxName = $('#txtConfigAuthNotaxName').val(); /* 불공제구분(ERPiU) 명칭 */
        param.vaTypeCode = $('#txtVaTypeCode').val();/* 사유구분(iCUBE) 코드 */
        param.vaTypeName = $('#txtVaTypeName').val();/* 사유구분(iCUBE) 명청 */
        param.vatTypeCode = $('#txtVatTypeCode').val();
        param.vatTypeName = $('#txtVatTypeName').val();
        
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
		
		/* 필수값 체크 */
		paramCheck = fnSaveParamCheck ( param );
		
 		var attr = $('#txtAuthCode').attr('disabled');
// 		/* 저장/수정 구분 */
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
	            	/* 조회버튼 클릭 */
	                $ ( "#btnSearch" ).click ( );
	                alert("<%=BizboxAMessage.getMessage("TX000002073", "저장되었습니다.")%>");
				},
				error : function(data) {
					console.log("! [EX] ERROR - " + JSON.stringify(data));
				}
			});
		}
		
		return;
	}	
	
	/* 저장 필수값 체크 */
	function fnSaveParamCheck ( data ) {
		var base = JSON.stringify(baseData);
		
		if(data.authCode == "" || data.authCode == null || data.authCode == "undefined"){
    		alert("<%=BizboxAMessage.getMessage("TX000018740","증빙유형코드를 확인하세요.")%>");
    		return false;
    	}if(data.authName == "" || data.authName == null || data.authName == "undefined"){
    		alert("<%=BizboxAMessage.getMessage("TX000018741","증빙유형명칭을 확인하세요.")%>");
    		return false;
    	}if((!$('#txtAuthCode:disabled').length) &&  base.indexOf('"autCode":"'+data.autCode+'"') > -1){
    		alert("<%=BizboxAMessage.getMessage("TX000018742","중복되는 적요코드입니다.")%>");
    		return false;
    	}
    	
    	if(ifSystem === 'iCUBE' && !data.vatAcctCode ){
    		alert("<%=BizboxAMessage.getMessage("TX000018743","부가세대체계정을 입력하여 주십시요")%>");
     		$('#btnAuthVatAcctPopUp').click();
     		return false;
     	}
   	
   	
    	if(ifSystem === 'iCUBE' && $(".iCUBEVat:visible").length && !data.vaTypeCode){
    		alert("<%=BizboxAMessage.getMessage("TX000007557","사유구분을 입력하여 주십시요.")%>");
    		$('#btnAuthVaPopUp').click();
    		return false;
    	}

//     	if(ifSystem === 'ERPiU' && $(".ERPiUVat:visible").length && !param.noTaxCode){
<%--     		alert("<%=BizboxAMessage.getMessage("TX000007553","불공제구분을 입력하여 주십시요.")%>"); --%>
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
//    	        		// 부가세 대체계정 필수 입력
//    	        		if($("#txtConfigAuthVatAcctCode").val() === ''){
<%--    	        			alert("<%=BizboxAMessage.getMessage("TX000018743","부가세대체계정을 입력하여 주십시요")%>"); --%>
//    	        			return false;
//    	        		}
//    					break;
//    			}
//    	    }

		return true;
	}
	
	/* 증빙유형 삭제 */
	function fnAuthDelete ( ) {
		if(!confirm("<%=BizboxAMessage.getMessage("","선택된 증빙유형 목록을 삭제하시겠습니까?")%>")){
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
			 alert("<%=BizboxAMessage.getMessage("","삭제할 증빙유형을 선택해주세요")%>");
		 }
		
		 $.ajax({
			type : 'post',
            url : '<c:url value="/expend/ex2/admin/auth/setAdminAuthDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	console.log(JSON.stringify(data));
            	/* ERP 전송여부 삭제 확인 */
            	if(parseInt(data.result.aData.erpSendNCount) > 0) {
            		alert("<%=BizboxAMessage.getMessage("","ERP 미전송 결의서에서 사용 중인 증빙유형은 삭제할 수 없습니다.\\n[지출결의  확인] 메뉴에서 전송완료 후 삭제해주세요.")%>");
            	} else {
            		
            	}
            	
            	/* 조회버튼 클릭 */
				$ ( "#btnSearch" ).click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
		});
		
		return;
	}
	
	/*	[필수 코드 체크] 필수코드 값 체크및 자동 조회
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
				alert( '차변 계정과목을 확인하세요.' );
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
				alert( '부과세 계정과목을 확인하세요.' );
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
				alert( '대변 계정과목을 확인하세요.' );
				return false;
			}
		}
		
		/* 텍스트만 있는거 발견 */
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
							alert('차변 계정과목을 확인하세요.');
						}else if(data.result.resultName == 'VAT'){
							alert('부가세 계정과목을 확인하세요.');
						}else if(data.result.resultName == 'CR'){
							alert('대변 계정과목을 확인하세요.');
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
	
	/* 공통코드 조회 팝업  */
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

    /* 불공제구분 */
    function fnConfigAuthNoTaxPopUp( param ) {
        $('#txtAuthNotaxCode').val(param.obj.noTaxCode);
        $('#txtAuthNotaxName').val(param.obj.noTaxName);
        focus_fnSetNextFocus();
        return;
    }
    
    /* 사유구분 */
    function fnAuthVaTypePopup( param ) {
        $('#txtAuthVaCode').val(param.obj.vaTypeCode);
        $('#txtAuthVaName').val(param.obj.vaTypeName);
        focus_fnSetNextFocus();
        return;
    }
	
	/* 대체계정 부가세 팝업 */
	function fnAuthVatAcctPopup(param) {
		$('#txtVatAcctCode').val(param.obj.acctCode || '');
		$('#txtVatAcctName').val(param.obj.acctName || '');
		focus_fnSetNextFocus();
		return;
	}

	/* 부가세구분 팝업 */
	function fnAuthVatTypePopup(param) {
		$('#txtVatTypeCode').val(param.obj.vatTypeCode || '');
		$('#txtVatTypeName').val(param.obj.vatTypeName || '');
		if(ifSystem === 'iCUBE'){
	        switch (param.obj.vatTypeCode) {
				case '23':
				case '24':
				case '26':
					// 불공 혹은 면세인경우 사유구분 입력란 활성화
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
	        		// 불공인 경우 불공제구분 입력란 활성화
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

	/* 대체계정 대변 팝업 */
	function fnAuthCrAcctPopup(param) {
		$('#txtCrAcctCode').val(param.obj.acctCode || '');
		$('#txtCrAcctName').val(param.obj.acctName || '');
		focus_fnSetNextFocus();
		return;
	}

	/* 대체증빙 팝업 */
	function fnAuthErpAuthPopup(param) {
		$('#txtErpAuthCode').val(param.obj.acctCode || '');
		$('#txtErpAuthName').val(param.obj.acctName || '');
		focus_fnSetNextFocus();
		return;
	}

	/* 테이블 스크롤 동기화 */
	function dalBoxScroll() {
		var leftTableContentsLeft = $(".dal_BoxIn .leftContents").scrollLeft();
		$(".dal_BoxIn .leftHeader").scrollLeft(leftTableContentsLeft);
	};

	/* 상세현황 닫기 공통 */
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
	/* ## 김상겸 작업영역 ##*/

	/* ## ---------------------------------------------------------------------------------------------------------- ##*/
</script>

<div class="modal" style="display: none;"></div>

<div class="sub_contents">
	<!-- iframe wrap -->
	<div class="iframe_wrap">
		<!-- 컨트롤박스 -->
		<div class="top_box">
			<dl>
				<dt>검색어</dt>
				<dd>
					<input type="text" id="txtSearchStr" style="width: 186px;" />
				</dd>
				<dt>사용여부</dt>
				<dd>
					<input id="selUseYN" class="kendoComboBox" />
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="검색" />
				</dd>
			</dl>
		</div>

		<div class="sub_contents_wrap posi_re">
			<div class="btn_div">
				<div class="left_div">
					<p class="tit_p m0 mt5">증빙유형 목록</p>
				</div>
				<div class="right_div">
					<div class="controll_btn p0">
						<button id="btnDel">삭제</button>
						<button id="btnAdd">추가</button>
					</div>
				</div>
			</div>

			<div class="dal_Box stExtract">
				<!-- 근태구분 -->
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
										<th colspan="2">증빙유형</th>
										<th rowspan="2">부가세구분<br />(세무구분)
										</th>
										
										<c:if test="${ifSystem == 'ERPiU' }">
										<th rowspan="2">불공제구분</th>
										</c:if>
										<c:if test="${ifSystem == 'iCUBE' }">
										<th rowspan="2">사유구분</th>
										</c:if>
										
										<th colspan="2">대체계정(코드/명칭)</th>
										<th rowspan="2">대체증빙</th>
										<th rowspan="2">필수<br />입력항목
										</th>
										<th rowspan="2">사용<br />여부
										</th>
									</tr>
									<tr class="borderR">
										<th>코드</th>
										<th>명칭</th>
										<th>대변</th>
										<th>부가세</th>
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
										<td colspan="8" class="nocon">증빙유형 목록이 없습니다.</td>
									</tr>
									<tr class="borderR">
										<td><input type="checkbox" name="inp_chk" id="Chk02" class="" />&nbsp;<label class="" for="Chk02"><span></span></label></td>
										<td class="cen">03</td>
										<td class="cen ellipsis">면세</td>
										<td class="cen ellipsis">면세(기타)</td>
										<td class="cen ellipsis"></td>
										<td class="cen ellipsis"></td>
										<td class="cen ellipsis">12/부가세부가세</td>
										<td class="cen ellipsis"></td>
										<td class="cen">사용</td>
									</tr> 
-->
								</tbody>
							</table>
						</div>
					</div>

					<!-- 오른쪽 default -->
					<div class="posi_right disInfoBox borderB" style="left: 60%; height: 400px;">
						<div class="text01">증빙유형 상세 설정</div>
						<div class="text02">
							<ul>
								<li>- 증빙유형 신규 추가는 상단[추가] 버튼을 클릭해 주세요.</li>
								<li>- 왼쪽 증빙유형 목록에서 내역 클릭 시 상세 설정 확인이 가능합니다.</li>
								<li><br /></li>
								<li>※ 증빙유형에 매핑 설정된 대체계정, 부가세 대체계정, 대체증빙은 표준적요에 설정된 값보다 우선순위로 디폴트 적용됩니다. 디폴트로 적용이 되더라도 작성자는 수정 후 작성이 가능합니다.</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<!-- 레이어 -->
			<div class="dal_Box_detail scroll_on boxHeight stExtract" style="left: 60%;">
				<div class="btn_div posi_re">
					<div class="left_div">
						<h5>상세설정</h5>
					</div>
					<div class="controll_btn p0 mr30">
						<button id="btnSave" type="button">저장</button>
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
							<th colspan="2"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> 증빙유형코드</th>
							<td><input type="text" class="txt_reset" id="txtAuthCode" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th rowspan="4"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> 증빙유형명칭</th>
							<th><img src="../../../Images/ico/ico_check01.png" alt=""> 한국어</th>
							<td><input type="text" id="txtAuthNameKr" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>영어</th>
							<td><input type="text" id="txtAuthNameEn" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>일본어</th>
							<td><input type="text" id="txtAuthNameJp" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>중국어</th>
							<td><input type="text" id="txtAuthNameCn" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th colspan="2">부가세구분(세무구분)</th>
							<td><input type="text" class="txt_reset" id="txtVatTypeName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtVatTypeCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnAuthVatTypePopup">선택</button>
									<button class="reload_btn" title="초기화"></button>
								</div></td>
						</tr>
						<tr>
							<th rowspan="2">대체계정</th>
							<th>대변</th>
							<td><input type="text" class="txt_reset" id="txtCrAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtCrAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnAuthCrAcctPopup">선택</button>
									<button class="reload_btn" title="초기화"></button>
								</div></td>
						</tr>
						<tr>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>"></img>부가세</th>
							<td><input type="text" class="txt_reset" id="txtVatAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtVatAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnAuthVatAcctPopup">선택</button>
									<button class="reload_btn" title="초기화"></button>
								</div></td>
						</tr>
						<tr>
							<th colspan="2">대체증빙</th>
							<td><input type="text" class="txt_reset" id="txtErpAuthName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtErpAuthCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnAuthErpAuthPopup">선택</button>
									<button class="reload_btn" title="초기화"></button>
								</div></td>
						</tr>
						<tr>
							<th colspan="2">필수입력항목</th>
							<td><input type="checkbox" name="op_chk" id="chkConfigAuthNoteReq" class="" />&nbsp;<label class="mb5" for="chkConfigAuthNoteReq"><span>적요</span></label> <br /> <input type="checkbox" name="op_chk" id="chkConfigAuthAuthReq" class="" />&nbsp;<label class="mb5" for="chkConfigAuthAuthReq"><span>증빙일자</span></label> <br /> <input type="checkbox" name="op_chk" id="chkConfigAuthCardReq" class="" />&nbsp;<label class="mb5" for="chkConfigAuthCardReq"><span>법인카드</span></label> <br /> <input type="checkbox" name="op_chk" id="chkConfigAuthPartnerReq" class="" />&nbsp;<label class="mb5" for="chkConfigAuthPartnerReq"><span>거래처</span></label> <br /> <input type="checkbox" name="op_chk" id="chkConfigAuthProjectReq" class="" />&nbsp;<label class="" for="chkConfigAuthProjectReq"><span>프로젝트</span></label></td>
						</tr>
						<tr>
							<th colspan="2">정렬순서</th>
							<td><input type="text" id="txtAuthOrderNum" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th colspan="2">사용여부</th>
							<td><input type="radio" name="useRadio" id="useN" value="N" class="" checked="" />&nbsp;<label for="useN">미사용</label> <input type="radio" name="useRadio" id="useY" value="Y" class="ml10" />&nbsp;<label for="useY">사용</label></td>
						</tr>
						<tr style="display: none;" class="ERPElement">
						<c:if test="${ifSystem == 'ERPiU' }">
							<th class="ERPiUVat" colspan="2"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" id='NoTax'/>
							${CL.ex_noType}(ERPiU)</th>
							<td class="ERPiUVat">
								<input id="txtAuthNotaxCode" type="hidden" style="width: 59%;" class="txt_reset" /> 
								<input id="txtAuthNotaxName" type="text" style="width: 59%;" class="txt_reset" />
								<div class="controll_btn p0">
									<button id="btnAuthNotaxPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
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
									<button id="btnAuthVaPopup"><%=BizboxAMessage.getMessage("TX000000265","선택")%></button>
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