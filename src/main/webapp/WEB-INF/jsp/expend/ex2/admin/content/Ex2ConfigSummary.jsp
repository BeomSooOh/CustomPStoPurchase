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

	/* 최초 이벤트 정의 */
	function fnInit ( ) {
		/* 사용여부 */
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

	/* 버튼 이벤트 정의 */
	function fnInitEvent ( ) {
		/* 검색 */
		$ ( "#btnSearch" ).click ( function ( ) {
			fnSubLayerInfoReset();
			dal_Box_detail();
			fnSummaryListInfo ( );
		} );

		/* 삭제 */
		$ ( "#btnDel" ).click ( function ( ) {
			fnSummaryDelete ( );
		} );

		/* 추가 */
		$ ( "#btnAdd" ).click ( function ( ) {
			var $DALBD = $(".dal_Box_detail");
			$DALBD.removeClass("animated05s fadeOutRight").addClass("animated05s fadeInRight").show();
			
			fnSubLayerInfoReset ( );
		} );

		/* 저장 */
		$ ( "#btnSave" ).click ( function ( ) {
			fnSummarySave ( );
		} );

		/* 테이블 리스트 클릭 이벤트 */
		$("#summaryTableList").on("click", "tr", function(){
			onSelect(this);
		});

		/* 선택 버튼 */
		/* 부가세 계정과목, 차변 계정과목, 대변 계정과목, 차변 증빙 */
		$ ( "#btnConfigSummaryVatAcctPopup, #btnConfigSummaryDrAcctPopup, #btnConfigSummaryCrAcctPopup, #btnConfigSummaryErpAuthPopup" ).on ( "click", function ( ) {
			var type = this.id.toString ( ).replace ( 'btnConfigSummary', '' ).replace ( 'Popup', '' );
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
    	$('#txtDrAcctName, #txtVatAcctName, #txtCrAcctName, #txtErpAuthName').bind('keydown', function( event ) {
    		/* 엔터입력 이벤트 적용 */
	        if (event.which == 13 || event.which == 113) {
	        	var type = this.id.toString ( ).replace ( 'txt', '' ).replace ( 'Name', '' );
	        	fnCommonCodePop(type, true);
	        }
	    });
        
        /* 이벤트 정의 - 엔터입력시 포커스 이동 jQuery.exp.expend.focus.js 참조 */
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
	
	/* 표준적요 조회 */
	var summaryJsonData = new Map();
	var baseData = '';
	function fnSummaryListInfo ( ) {
		/* 변수정의 */
        var param = {};
        param.compSeq = '${empInfo.compSeq}';
        searchCompSeq = '${empInfo.compSeq}'; /* 팝업 호출시 사용 */
        param.codeType = 'SUMMARY'
//      param.summary_div = $('#selSummaryType').val(); // 현재는 A로 고정, 추후 매출결의 개발시 사용
        param.summaryDiv = 'A';
        param.searchStr = $('#txtSearchStr').val();
		param.useYN = $("#selUseYN").val();

        /* 표준적요 데이터 호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/ex2/admin/summary/setAdminSummaryListSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	baseData = data.result.aaData
            	
            	/* 표준적요 데이터가 존재하지 않을 때 */
            	if(data.result.aaData.length == 0) {
            		 /* 테이블 데이터 바인딩 */
            		fnSummaryListBind('');
            	} else {
            		/* 수정 시 사용 */
            		for(var i=0; i<data.result.aaData.length; i++) {
            			summaryJsonData.put(i, data.result.aaData[i])
            		}
            		
            		/* 테이블 데이터 바인딩 */
                    fnSummaryListBind(data.result.aaData);
            	}
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
		return;
	}
	
	/* 테이블 바인딩 */
	function fnSummaryListBind ( data ) {
		//console.log(JSON.stringify(data));   
		var tag = '';
		var length = data.length;
		
		if(data != '') {
			for(var i=0; i<length; i++) {
				var useText = '';
				
				if(data[i].useYN == "Y" || data[i].useYN == "") {
					useText = "사용";
				} else {
					useText = "미사용";
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
			tag += '  <td colspan="6" class="nocon">표준적요 목록이 없습니다.</td>';
			tag += '</tr>';	
		}
		
		$("#summaryTableList").html(tag);
		
		return;
	}	

	/* 테이블 리스트 클릭 이벤트 */
	function onSelect(data) {
		var summaryCode = $(data).attr("id");
		
		$("#summaryTableList tr").removeClass("on");
		
		$(data).addClass("on");
		
		/* 상세 표준적요 정보 조회 */
		fnSummaryDetailInfo(summaryCode);
	}
	
	/* 상세 표준적요 정보 조회 */
	function fnSummaryDetailInfo(code) {
		/* 변수정의 */
		var summaryCode = code;
		
		/* 슬라이드 팝업 */
		var $DALBD = $(".dal_Box_detail");
		$DALBD.removeClass("animated05s fadeOutRight").addClass("animated05s fadeInRight").show();
		
		/* summaryCode 데이터 확인 */
		if(summaryCode == null || summaryCode == "undefined" || summaryCode == "") {
			console.log("표준적요 코드를 확인해주세요.");
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

	/* 상세설정 초기화 */
	function fnSubLayerInfoReset ( ) {
		/* 초기화 */
		$ ( '#txtSummaryCode' ).val ( '' ); /* 적요코드 초기화 */
		$ ( '#txtSummaryNameKr' ).val ( '' ); /* 적요명 한글 초기화 */
		$ ( '#txtSummaryNameEn' ).val ( '' ); /* 적요명 영어 초기화 */
		$ ( '#txtSummaryNameJp' ).val ( '' ); /* 적요명 일본어 초기화 */
		$ ( '#txtSummaryNameCn' ).val ( '' ); /* 적요명 중국어 초기화 */
		$ ( '#txtDrAcctCode' ).val ( '' ); /* 차변계정과목 초기화 */
		$ ( '#txtDrAcctName' ).val ( '' ); /* 차변계정과목 초기화 */
		$ ( '#txtCrAcctCode' ).val ( '' ); /* 대변계정과목 초기화 */
		$ ( '#txtCrAcctName' ).val ( '' ); /* 대변계정과목 초기화 */
		$ ( '#txtVatAcctCode' ).val ( '' ); /* 부가세계정과목 초기화 */
		$ ( '#txtVatAcctName' ).val ( '' ); /* 부가세계정과목 초기화 */
		$ ( '#txtErpAuthCode' ).val ( '' ); /* 차변 증빙 초기화 */
		$ ( '#txtErpAuthName' ).val ( '' ); /* 차변 증빙 초기화 */

		/* 비활성화 해제 */
		$ ( '#txtSummaryCode' ).removeAttr ( 'disabled' ); /* 적요코드 */
		$('#txtSummaryOrderNum').val(''); /* 정렬순서 초기화 */
		
		return;
	}
	
	/* 표준적요 저장 */
	function fnSummarySave ( ) {
		/* 입력 필수 코드 자동조회 */
		if(fnCheckNecessaryCode() == false){
			return;
		}
		
		/* 변수정의 */
		var param = {};
		var paramCheck = false;
		var url = '';

		param.compSeq = '${empInfo.compSeq}';
		param.summaryCode = $ ( '#txtSummaryCode' ).val ( );
		param.summaryName = $ ( '#txtSummaryNameKr' ).val ( );
		param.summaryNameEn = $ ( '#txtSummaryNameEn' ).val ( );
		param.summaryNameCn = $ ( '#txtSummaryNameCn' ).val ( );
		param.summaryNameJp = $ ( '#txtSummaryNameJp' ).val ( );
//      param.summary_div = $('#selSummaryTypeInput').val();// 현재는 A로 고정, 추후 매출결의 개발시 사용
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

		/* 필수값 체크 */
		paramCheck = fnSaveParamCheck ( param );
		
		var attr = $('#txtSummaryCode').attr('disabled');
		
		/* 저장/수정 구분 */
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
	                /* 조회버튼 클릭 */
	                $ ( "#btnSearch" ).click ( );
	                alert("<%=BizboxAMessage.getMessage("TX000002073", "저장되었습니다.")%>");
	            },
	            error : function( data ) {
	                console.log("! [EX] ERROR - " + JSON.stringify(data));
	            }
			});
		} else {
			console.log("필수값 체크");
			return;
		}

		return;
	}	
	
	/* 표준적요 삭제 */
	function fnSummaryDelete ( ) {
		
		if(!confirm("<%=BizboxAMessage.getMessage("","선택된 표준적요 목록을 삭제하시겠습니까?")%>")){
    		return;
    	}
		
		 var param = {};
		 param.compSeq = '${empInfo.compSeq}';
		 //param.summaryCode = $("#txtSummaryCode").val();
		 param.summaryDiv = 'A';
		 
		 /* 삭제코드 만들기 */
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
			 alert("<%=BizboxAMessage.getMessage("","삭제할 표준적요를 선택해주세요")%>");
		 }
		 
		 $.ajax({
			type : 'post',
            url : '<c:url value="/expend/ex2/admin/summary/setAdminSummaryDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	console.log(JSON.stringify(data));
            	/* ERP 전송여부 삭제 확인 */
            	if(parseInt(data.result.aData.erpSendNCount) > 0) {
            		alert("<%=BizboxAMessage.getMessage("","ERP 미전송 결의서에서 사용 중인 표준적요는 삭제할 수 없습니다.\\n[지출결의  확인] 메뉴에서 전송완료 후 삭제해주세요.")%>");
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

	/* 차변 계정과목 선택 */
	function fnSummaryDrAcctPopup ( param ) {
		$ ( '#txtDrAcctCode' ).val ( param.obj.acctCode || '' );
		$ ( '#txtDrAcctName' ).val ( param.obj.acctName || '' );
		//focus_fnSetNextFocus ( );
		return;
	}

	/* 차변 증빙 선택 */
	function fnSummaryErpAuthPopup ( param ) {
		$ ( '#txtErpAuthCode' ).val ( param.obj.acctCode || '' );
		$ ( '#txtErpAuthName' ).val ( param.obj.acctName || '' );
		//focus_fnSetNextFocus ( );
		return;
	}

	/* 부가세 계정과목 선택 */
	function fnSummaryVatAcctPopup ( param ) {
		$ ( '#txtVatAcctCode' ).val ( param.obj.acctCode || '' );
		$ ( '#txtVatAcctName' ).val ( param.obj.acctName || '' );
		//focus_fnSetNextFocus ( );
		return;
	}

	/* 대변 계정과목 선택 */
	function fnSummaryCrAcctPopup ( param ) {
		$ ( '#txtCrAcctCode' ).val ( param.obj.acctCode || '' );
		$ ( '#txtCrAcctName' ).val ( param.obj.acctName || '' );
		//focus_fnSetNextFocus ( );
		return;
	}

	/* 공통코드 조회 팝업  */
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

	/* 저장 필수값 체크 */
	function fnSaveParamCheck ( data ) {
		var base = JSON.stringify(baseData);
		
		if ( data.summaryCode == "" || data.summaryCode == null || data.summaryCode == "undefined") {
			alert("<%=BizboxAMessage.getMessage("TX000018754", "적요코드를 입력하여 주십시오")%>");
			return false;
		}
		if ( data.summaryName == "" || data.summaryName == null || data.summaryName == "undefined") {
			alert("<%=BizboxAMessage.getMessage("TX000018755", "적요명칭을 입력하여 주십시오")%>");
			return false;
		}
		if ( data.drAcctCode == "" || data.drAcctCode == null || data.drAcctCode == "undefined") {
			alert("<%=BizboxAMessage.getMessage("TX000003521", "차변계정과목을 입력하여 주십시오")%>");
			return false;
		}
		if ( data.crAcctCode == "" || data.crAcctCode == null || data.crAcctCode == "undefined") {
			alert("<%=BizboxAMessage.getMessage("TX000003522", "대변계정과목을 입력하여 주십시오")%>");
			return false;
		}
		if( (!$('#txtSummaryCode:disabled').length) &&  base.indexOf('"summaryCode":"'+data.summaryCode+'"') > -1){
    		alert("<%=BizboxAMessage.getMessage("TX000003523","입력하신 적요코드가 이미 등록되어있습니다. 적요코드를 다시 입력하여 주십시오")%>");
    		return false;
    	}

		return true;
	}
	
	/* 테이블 스크롤 동기화 */
	function dalBoxScroll() {
		var leftTableContentsLeft = $(".dal_BoxIn .leftContents").scrollLeft();
    	$(".dal_BoxIn .leftHeader").scrollLeft(leftTableContentsLeft);
	};
	
	/* 상세현황 닫기 공통 */
	function dal_Box_detail(){
		var $DALBD = $(".dal_Box_detail");
			$DALBD.removeClass("animated05s fadeInRight").addClass("animated05s fadeOutRight");
			$(".posi_left table td").parent().removeClass('on');
			setTimeout(function(){$DALBD.hide();},500);
	};

	/* ## ---------------------------------------------------------------------------------------------------------- ##*/
	/* ## 김상겸 작업영역 ##*/

	/* ## ---------------------------------------------------------------------------------------------------------- ##*/
</script>

<div class="modal" style="display: none;"></div>

<div class="sub_contents_wrap">
	<!-- iframe wrap -->
	<div class="iframe_wrap">
		<!-- 컨트롤박스 -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_keyWord}</dt>
				<dd>
					<pudd:input setAttribute="{ 'style':{'width':'186px'} }"></pudd:input>
					<!-- <input type="text" id="txtSearchStr" style="width: 186px;" /> -->
				</dd>

				<dt>사용여부</dt>
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
					<p class="tit_p m0 mt5">표준적요 목록</p>
				</div>
				<div class="right_div">
					<div class="controll_btn p0">
						<button id="btnDel"><%=BizboxAMessage.getMessage( "TX000000424", "삭제" )%></button>
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
										<th colspan="2">표준적요</th>
										<th colspan="3">분개설정정보(코드/명칭)</th>
										<th rowspan="2">ERP증빙</th>
										<th rowspan="2">사용<br />여부
									</tr>
									<tr class="borderR">
										<th>코드</th>
										<th>명칭</th>
										<th>차변-계정과목</th>
										<th>부과세-계정과목</th>
										<th>대변-계정과목</th>
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
										<td colspan="6" class="nocon">표준적요 목록이 없습니다.</td>
									</tr>
									<tr class="borderR">
										<td>
										  <input type="checkbox" name="inp_chk" id="Chk02" class="" />&nbsp;
										  <label class="" for="Chk02"><span></span></label>
										</td>
										<td>8000</td>
										<td>도서구매</td>
										<td>8260/도서인쇄비</td>
										<td>-</td>
										<td>2530/미지급금</td>
										<td></td>
									</tr>
									<tr class="borderR">
										<td><input type="checkbox" name="inp_chk" id="Chk03"
											class="" />&nbsp;<label class="" for="Chk03"><span></span></label>
										</td>
										<td>8001</td>
										<td>명함제작</td>
										<td>8260/도서인쇄비</td>
										<td>1350/부가세대급금</td>
										<td>2530/미지급금</td>
										<td>3/영수증(일반경비)</td>
									</tr>
 -->
								</tbody>
							</table>
						</div>
					</div>

					<!-- 오른쪽 default -->
					<div class="posi_right disInfoBox borderB" style="left: 60%; height: 400px;">
						<div class="text01">표준적요 상세 설정</div>
						<div class="text02">
							<ul>
								<li>- 표준적요 신규 추가는 상단[추가] 버튼을 클릭해 주세요.</li>
								<li>- 왼쪽 표준적요 목록에서 내역 클릭 시 상세 설정 확인이 가능합니다.</li>
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
							<th colspan="2"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> 표준적요코드</th>
							<td><input type="text" id="txtSummaryCode" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th rowspan="4"><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> 표준적요명칭</th>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="">한국어</th>
							<td><input type="text" id="txtSummaryNameKr" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>영어</th>
							<td><input type="text" id="txtSummaryNameEn" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>일본어</th>
							<td><input type="text" id="txtSummaryNameJp" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th>중국어</th>
							<td><input type="text" id="txtSummaryNameCn" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th rowspan="2">차변</th>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="">계정과목</th>
							<td><input type="text" class="txt_reset" id="txtDrAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtDrAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnConfigSummaryDrAcctPopup">선택</button>
									<button class="reload_btn" title="초기화"></button>
								</div></td>
						</tr>
						<tr>
							<th>증빙</th>
							<td><input type="text" class="txt_reset" id="txtErpAuthName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtErpAuthCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnConfigSummaryErpAuthPopup">선택</button>
									<button class="reload_btn" title="초기화"></button>
								</div></td>
						</tr>
						<tr>
							<th>부과세</th>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="">계정과목</th>
							<td><input type="text" class="txt_reset" id="txtVatAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtVatAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnConfigSummaryVatAcctPopup">선택</button>
									<button class="reload_btn" title="초기화"></button>
								</div></td>
						</tr>
						<tr>
							<th>대변</th>
							<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""> 계정과목</th>
							<td><input type="text" class="txt_reset" id="txtCrAcctName" style="width: 59%;" /> <input type="hidden" class="txt_reset" id="txtCrAcctCode" style="width: 59%;" />
								<div class="controll_btn p0">
									<button id="btnConfigSummaryCrAcctPopup">선택</button>
									<button class="reload_btn" title="초기화"></button>
								</div></td>
						</tr>
						<tr>
							<th colspan="2">정렬순서</th>
							<td><input type="text" id="txtSummaryOrderNum" style="width: 99%;" /></td>
						</tr>
						<tr>
							<th colspan="2">사용여부</th>
							<td><input type="radio" name="useRadio" id="useN" value="N" class="" checked="" />&nbsp;<label for="useN">미사용</label> <input type="radio" name="useRadio" id="useY" value="Y" class="ml10" />&nbsp;<label for="useY">사용</label></td>
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