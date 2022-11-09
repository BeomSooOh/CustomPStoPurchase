<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<!-- javascript - src -->
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExOption.js?ver=20190729"></c:url>'></script>

<script type="text/css" src='<c:url value="/css/pudd.css"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/pudd/pudd-1.1.192.min.js"></c:url>'></script>

<!--Excel다운로드를 위한 js-->
<script type="text/javascript" src='<c:url value="/js/t_excel/jszip-3.1.5.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/t_excel/FileSaver-1.2.2_1.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/t_excel/jexcel-1.0.4.js"></c:url>'></script>

<!-- javascript -->
<script>
	/* UserCardReport var */
	var listData = {};
	

	/* document.ready */
	$(document).ready(function() {
		<c:if test="${ViewBag.empInfo.groupSeq == 'dev'}"> /* 개발버전인 경우 */
		debug = true;
		/* $('#btnDebugViewVar').show(); */
		/* setClick($('#btnDebugViewVar'), showLog); */
		</c:if>

		log('+ [UserCardReport] (document).ready');
		fnUserCardReportInit();
		fnUserCardReportEventInit();
		$('#btnSearch').click();
        
		log('- [UserCardReport] (document).ready');
	});

	/* fnUserCardReportInit */
	function fnUserCardReportInit() {
		log('+ [UserCardReport] fnUserCardReportInit');
		fnUserCardReportInitLayout();
		fnUserCardReportInitDatepicker();
		fnUserCardReportInitInput();
		fnUserCardReportInitButton();
		log('- [UserCardReport] fnUserCardReportInit');
	}
	/* fnUserCardReportInit - Layout */
	function fnUserCardReportInitLayout() {
		log('+ [UserCardReport] fnUserCardReportInitLayout');
		log('- [UserCardReport] fnUserCardReportInitLayout');
	}
	/* fnUserCardReportInit - Datepicker */
	function fnUserCardReportInitDatepicker() {
		log('+ [UserCardReport] fnUserCardReportInitDatepicker');
		/* class="datepicker" datepicker 정의 */
		setDatePicker($('.datepicker'));
		
		fnInitDatePicker(1);
			
		log('- [UserCardReport] fnUserCardReportInitDatepicker');
	}
	
	/* fnUserCardReportInit - Input */
	function fnUserCardReportInitInput() {
		log('+ [UserCardReport] fnUserCardReportInitInput');
		
		$("#selViewLength").selectmenu({change: function(){
			$('select[name=tblUserCardReportView_length]').val($('#selViewLength').val());
			$('select[name=tblUserCardReportView_length]').trigger('change');
		}});
		
		log('- [UserCardReport] fnUserCardReportInitInput');
	}
	/* fnUserCardReportInit - Button */
	function fnUserCardReportInitButton() {
		
		var cmsData = '${cmsDate}'
		
		var y = cmsData.substring(0,4);
		var	m = cmsData.substring(5,7);
		var	d = cmsData.substring(8,10);
		var h = cmsData.substring(11,13);
		var mi = cmsData.substring(14,16);
		var h2 = h%12
		
		if (h == 12){
			h2 = 12
		}
		
		var amPm = '오전';
		
		if(h>=12){
			amPm = '오후'
		}
		
		//준성 수정 
		
		if(${buildType}){
			
			$("#btnExcelDown").before(
				'<span id="cardTime">${CL.ex_recentlyCmsTime} : <span id="cardBatchTime">00:00:00</span></span>&nbsp&nbsp;'+					
				"<button id='btnCardPeriodSync' class='k-button'>카드내역연동</button>&nbsp;"+
				"<button id='cmsSync'class='k-button'>카드내역연동</button>&nbsp;"
			)
		}
		//성일 수정 ([1.4.143]1차 클라우드 에서 동기화시간 표시 개선)
		else{
			$("#btnExcelDown").before(
					'<span id="cardTime">${CL.ex_recentlyCmsTime} : <span id="cardBatchTime">00:00:00</span></span>&nbsp&nbsp;')
		}
		
		log('+ [UserCardReport] fnUserCardReportInitButton');
		log('- [UserCardReport] fnUserCardReportInitButton');
	}
		

	/* fnUserCardReportEventInit */
	function fnUserCardReportEventInit() {
		log('+ [UserCardReport] fnUserCardReportEventInit');
		fnUserCardReportEventInitButton();
		fnUserCardReportEventInitInput();
		log('- [UserCardReport] fnUserCardReportEventInit');
	}
	/* fnUserCardReportEventInit - Button */
	function fnUserCardReportEventInitButton() {
		log('+ [UserCardReport] fnUserCardReportEventInitButton');
		setClick($(eventTarget.search), function() {
			fnUserCardReportSearch();
		});
		$("#btnExcelDown").click(function(){
			fnAdminCardReportExcelDown();
		});
		// 미사용 처리 
		$("#btnUnUse").click(function(){
			fnAdminSetCardUseYN("Y");
		});
		// 미사용 해제 
		$("#btnUse").click(function(){
			fnAdminSetCardUseYN("N");
		});
		
		$("#btnCardPeriodSync").click(function(){
			fnCardPeriodSync();
		});
		
		$("#cmsSync").click(function(){
			fnSyncNow();
		});
		
		
		log('- [UserCardReport] fnUserCardReportEventInitButton');
	}
	/* fnUserCardReportEventInit - Input */
	function fnUserCardReportEventInitInput() {
		log('+ [UserCardReport] fnUserCardReportEventInitInput');	

		$("input").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#btnSearch').click();
            }
        });
		
		log('- [UserCardReport] fnUserCardReportEventInitInput');
	}

	/*	[데이트 피커] Initialrize date picker with gap
	----------------------------------------*/
	function fnInitDatePicker(monthGap) {

		// Object Date add prototype
		Date.prototype.ProcDate = function () {
			var yyyy = this.getFullYear().toString();
			var mm = (this.getMonth() + 1).toString(); //
			var dd = this.getDate().toString();
			return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-'
					+ (dd[1] ? dd : "0" + dd[0]);
		};
		var toD = new Date();
		$('#txtReqDate').val(toD.ProcDate());
		
		if (toD.getMonth() == 0) {
			var fromD = new Date(toD.getFullYear() - 1, 11, toD.getDate());
		} else {
			var fromD = new Date(toD.getFullYear(), toD.getMonth() - monthGap,
					toD.getDate());
		}
		$('#txtFromDate').val(fromD.ProcDate());
	}
	
	/*	[파라미터] ajax 호출 파라미터 정보 조합
 	--------------------------------------*/
	function fnGetAjaxCallParams(){
		var param = {};
		param.fromDate = $('#txtFromDate').val().replace(/-/gi,'');
		param.toDate = $('#txtToDate').val().replace(/-/gi,'');
		param.compSeq = '${ViewBag.empInfo.compSeq}';
		//param.docSts = $('#selDocSts').val();
		//param.useYN = $('#selUseYN').val(); //Y:사용, N:미사용
		switch ($('#selDocSts').val()) {
			case "" : // 전체
				param.docSts = "";
				param.useYN = "";
				break;
			case "1" : // 결의
				param.docSts = "1";
				param.useYN = "Y";
				break;
			case "0" : // 미결의
				param.docSts = "0";
				param.useYN = "Y";
				break;
			case "D" : // 미사용
				param.docSts = "";
				param.useYN = "N";
				break;
		}

		
		// 상세 검색 활성화
		if($('.SearchDetail:visible').length){
			param.cardNum = $('#txtCardNum').val().replace(/-/gi,'');
			param.mercName = $('#txtMercName').val();
			param.cardName = $('#txtCardName').val();
		}
		return param;
	}
	
	function fnValidateParam(param){
		if(param.fromDate.length != 8){
			return "<%=BizboxAMessage.getMessage("TX000018784","승인일자를 확인하세요.")%>";
		}else if(param.toDate.length != 8){
			return "<%=BizboxAMessage.getMessage("TX000018784","승인일자를 확인하세요.")%>";
		}
		
		return 0;
	}
	
	/*	[서버 호출] 법인카드 사용내역 데이터 서버 호출
 	--------------------------------------*/
	function fnUserCardReportSearch() {
		var param = fnGetAjaxCallParams();
		var validateResult = fnValidateParam(param);
		if(validateResult){
			alert(validateResult);
			return;
		}
		/* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/card/cardReportList.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	fnSetCardSetGrid(data.result.aaData);
            	$("#valTotalCount").text(data.result.aaData.length);
            	if( data && data.result && data.result.aaData && data.result.aaData.length > 0 ){
            		listData = data.result.aaData;	
            	}
            	fnCardBatchTimeSearch();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
		
		// setTableCust($('#tblUserCardReport'), columnDefs, columns, result.aaData, '20');
	}
	
	/*	[뷰-그리드] 법인카드 사용내역 출력
 	--------------------------------------*/
	function fnSetCardSetGrid(data){
		
        var aoColumns = [ {
			"sTitle" : "<input type='checkbox' id='chkSel' name='checkAll' class='check2 k-checkbox' onClick='javascript:fnCheckBoxAllCheck();' title='전체선택' id='checkAll' /><label class='k-checkbox-label' for='chkSel'></label>",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : "40px"
		}, {
			"sTitle" : "${CL.ex_dateApproval}",
			"bVisible" : true,
			"bSortable" : true,
			"sWidth" : "150px"
		}, {
			"sTitle" : "<%=BizboxAMessage.getMessage("TX000018786","사용처")%>",
			"bVisible" : true,
			"bSortable" : true,
			"sClass" : "",
			"sWidth" : ""
		}, {
			"sTitle" : "${CL.ex_card}",
			"bVisible" : true,
			"bSortable" : true,
			"sClass" : "",
			"sWidth" : ""
		}, {
			"sTitle" : "${CL.ex_amount}",
			"bVisible" : true,
			"bSortable" : true,
			"sClass" : "",
			"sWidth" : ""
		}, {
			"sTitle" : "<%=BizboxAMessage.getMessage("TX000018787","서비스 금액")%>",
			"bVisible" : true,
			"bSortable" : true,
			"sClass" : "",
			"sWidth" : "100px"
		}, {
			"sTitle" : "${CL.ex_confirmationNumber}",
			"mData" : "authNum",
			"bVisible" : true,
			"bSortable" : true,
			"sWidth" : "100px"
		}];
		var columnDefs = [ 
		{
			"targets" : 0,
			"data" : null,
			"render" : function(data) {
				var chkDisabled = '';
				/* 카드 내역 사용 한 경우에는 사용/미사용 처리 못하도록 */
				if(data.isDeleteYN == 'U'){
					chkDisabled = 'disabled'
				}
				return "<input type='checkbox' name='inp_chk' "+chkDisabled+" id='inp_chk_"+data.syncId+"_"+data.isDeleteYN+"' class='k-checkbox tableChkBox' value='"+data.syncId+"_"+data.isDeleteYN+"'>"
						+ "<label class='k-checkbox-label bdChk' for='inp_chk_"+data.syncId+"_"+data.isDeleteYN+"'></label>";
			}
		},{
			"targets" : 1,
			"data" : null,
			"render" : function(data) {
				
				
				var date = data.authDate || '';
				var time = data.authTime || ''; 
				
				return date.toString().replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3') 
				+ ' ' 
				+ time.toString().replace(/^(\d{2})(\d{2})(\d{2})$/, '$1:$2:$3');
			}
		}, {
			"targets" : 2,
			"data" : null,
			"render" : function(data) {
				var mercName = data.mercName || '';
				var mercSaupNo = data.mercSaupNo || '';
				
				if(!(mercSaupNo == '')){
					mercSaupNo = mercSaupNo.toString().replace(/^(\d{3})(\d{2})(\d{5})$/, '$1-$2-$3');
					return mercName + '<br />[' + mercSaupNo + ']';
				} else {
					return mercName;
				}
			}
		}, {
			"targets" : 3,
			"data" : null,
			"render" : function(data) {
				var cardName = data.cardName || '';
				var cardNum = data.cardNum || '-';
				
				return cardName + '<br />[' + cardNum.toString().replace(/\B(?=(\d{4})+(?!\d))/g, '-') + ']';
			}
		}, {
			"targets" : 4,
			"data" : null,
			"render" : function(data) {
				// 승인 / 취소 구분
				var signCorrection = (data.georaeStat == '1' || data.georaeStat == 'N') ? 1 : ( parseInt(data.requestAmount) < 1 ? 1 : -1 );
				var signClass = (data.georaeStat == '1' || data.georaeStat == 'N') ? '' : 'text_red';
				var subSignCorrection = 1;
				
				if (signCorrection < 0 && parseInt(data.vatMdAmount) < 0){
					subSignCorrection = -1;
				}
				
				// 금액 처리 준비
				var requestAmount = data.requestAmount || '0';
				var vatMdAmount = data.vatMdAmount || '0';
				var amtMdAmount = data.amtMdAmount || '0';
				
				// 승인/취소에 따른 부호 보정
				requestAmount = parseInt(requestAmount) * signCorrection;
				vatMdAmount = parseInt(vatMdAmount) * signCorrection * subSignCorrection;
				amtMdAmount = parseInt(amtMdAmount) * signCorrection * subSignCorrection;
				
				// 데이터 포멧 정규화
				requestAmount = requestAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				vatMdAmount = vatMdAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				amtMdAmount = amtMdAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				
				return '<strong><span class="'+signClass+'">'+ requestAmount +'</span></strong><br>'
					+ '<span class="'+signClass+'">' + vatMdAmount + '</span><br>'
					+ '<span class="'+signClass+'">' + amtMdAmount + '</span><br>';
			}
		}, {
			"targets" : 5,
			"data" : null,
			"render" : function(data) {
				return data.serAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
		}];
		
		if('${ViewBag.g20YN}' == 'N'){
			aoColumns.push({
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000000663","문서번호")%>",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : ""
			});
			aoColumns.push({
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000018779","자동전표번호")%>",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : ""
			});
			aoColumns.push({
				"sTitle" : "<%=BizboxAMessage.getMessage("TX000018791","승인/취소 구분")%>",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "100px"
			});
			aoColumns.push({
				"sTitle" : "${CL.ex_resCondition}",/*결의상태*/
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : "100px"
			});
			columnDefs.push({
				"targets" : 7,
				"data" : null,
				"render" : function(data) {
					if(data.docDocSts == '10'){
						return (data.docNo + '['+data.docUserNm+']') || '-';	
					}else{
						return data.docNo || '-';
					}
				}
			});
			columnDefs.push({
				"targets" : 8,
				"data" : null,
				"render" : function(data) {
					if( (data.inDt + data.inSq ).toString() == '0'){
						return data.expendRowId || '';	
					}else{
						return data.expendRowId || ( data.inDt + data.inSq) ;
					}
					
				}
			});
			columnDefs.push({
				"targets" : 9,
				"data" : null,
				"render" : function(data) {
					if (data.georaeStat == '1' || data.georaeStat == 'N') {
						return '<span class=""><%=BizboxAMessage.getMessage("TX000000798","승인")%></span>';
					} else {
						return '<span class="text_red"><%=BizboxAMessage.getMessage("TX000002947","취소")%></span>';
					}
				}
			});
			columnDefs.push({
				"targets" : 10,
				"data" : null,
				"render" : function(data) {
					if(data.isDeleteYN == 'U'){
						return "결의";
					}else if(data.isDeleteYN == 'Y'){
						return '<span class="text_red">미사용</span>';
					}else{
						return "미결의";
					}
				}
			});
			/* 콜 그룹 설정 */
// 			$('#tblUserCardReportView>colgroup').append('<col width="" /><col width="" /><col width="100" />');
		}
		
		if($.fn.DataTable.isDataTable('#tblUserCardReportView') == true) {
			var table = $('#tblUserCardReportView').DataTable();
			table.clear().draw();
		}
		
		$('#tblUserCardReportView').DataTable({
			"bSort" : false,
            "select" : true,
            "paging" : false,
            "bAutoWidth" : false,
            "bSort" : true,
            "destroy" : true,
            "paging" : true, 
            "lengthMenu" : [ [ 10, 20, 30, 40, 50 ], [ 10, 20, 30, 40, 50 ] ],
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
                $(nRow).on('dblclick', (function() {
                	if(aData.docNo){
                		fnAppDoc(aData);	
                	}
                }));
            },
            columnDefs : columnDefs,
    		aoColumns : aoColumns
        });
		
		$('select[name=tblUserCardReportView_length]').val($('#selViewLength').val());
		$('select[name=tblUserCardReportView_length]').trigger('change');
	}
	
	/*	[전자결재] 전자결재 팝업 호출
 	--------------------------------------*/
    function fnAppDoc(data){
		// 팝업창 너비, 높이 조정
		var intWidth = 900;
		var intHeight = screen.height - 100;

		// 사파리 사용자 처리
		var agt = navigator.userAgent.toLowerCase();
		if (agt.indexOf("safari") != -1) {
			intHeight -= 70;
		}

		//팝업창 마진 설정
		var intLeft = screen.width / 2 - intWidth / 2;
		var intTop = screen.height / 2 - intHeight / 2 - 40;

		// 사파리 사용자 처리
		if (agt.indexOf("safari") != -1) {
			intTop = intTop - 30;
		}

		var url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id="+data.docId+"&form_id=" + data.formFormSeq + "&doc_auth=1";
        window.open(url, 'AppDocReturn', 'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
    }
	
    /* 카드 내역 사용/미사용 처리 */
	function fnAdminSetCardUseYN(ynType){
		/* ynType ( Y : 미사용, N : 사용) */
		var chkSels = new Array();
		var isSuccess = true;
		$.each($("input:checkbox:checked"),function(idx,val){
			if($(this).attr("value") == 'on' || $(this).attr("id") == 'chkSel'){
				return true;
			}
			chkSels.push($(this).attr("value")); 
		});
		
		if(chkSels.length == 0){
			alert("변경할 항목을 선택해주세요.");
		}
		/* ynType ( Y : 미사용, N : 사용) */
		for(var i = 0 ; i <chkSels.length ; i++){
			if( (ynType == 'Y' && chkSels[i].split('_')[1] == 'Y') || (ynType == 'N' && chkSels[i].split('_')[1] != 'Y')){
				continue;
			}
			var param = {};
			param.syncId = chkSels[i].split('_')[0];
			param.sendYN = ynType;
			param.ifMId = (ynType == 'Y'?'D':'');
			/* 서버호출 */
			$.ajax({
				type : 'post',
				url : '<c:url value="/ex/admin/report/ExAdminCardSetUseYN.do" />',
				datatype : 'json',
				async : false,
				data : param,
				success : function( data ) {
					if(data.result.resultCode != 'SUCCESS'){
						isSuccess = false;
					}
				},
				error : function( data ) {
					console.log("! [EX] ERROR - " + JSON.stringify(data));
				}
			});
		}
		if(isSuccess){
			if(ynType== 'Y'){
				alert("미사용 처리되었습니다.");	
			}else{
				alert("미사용 처리가 해제되었습니다.");
			}	
		}
		
		$("#btnSearch").click();
	}
    
	/* 체크박스 전체 선택 이벤트 */
	function fnCheckBoxAllCheck() {
		if ($("#chkSel").prop("checked")) {
			$("input[type=checkbox]").filter(".tableChkBox").not(":disabled")
					.prop("checked", true);
		} else {
			$("input[type=checkbox]").filter(".tableChkBox").not(":disabled")
					.prop("checked", false);
		}
	}
	
    /*	[서버 호출] 법인카드 사용내역 데이터 Excel 다운로드
 	--------------------------------------*/    
	function fnAdminCardReportExcelDown(){
		
		if( !listData || listData.length == undefined || listData.length == 0){
			alert("데이터가 없습니다.");
			return false;
		}

		/* 새로운 ProgressBar 추가 - 2018.08.31 .yw */
		Pudd( "#loadingProgressBar" ).puddProgressBar({

				progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }

			,	strokeColor : "#84c9ff"	// progress 색상
			,	strokeWidth : "3px"	// progress 두께

			,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
			,	percentTextColor : "#84c9ff"
			,	percentTextSize : "12px"

			// 내부적으로 timeout 으로 아래 함수를 호출함. 시간은 100 milliseconds
			,	progressStartCallback : function( progressBarObj ) {

					// dataSource를 통한 data 연동
					var sourceData = new Pudd.Data.DataSource({

						pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
					,	serverPaging : true
					,	request : {
							url : '/exp/ex/admin/CommonNewExcelDown.do'
						,	type : 'post'
						,	dataType : "json"
						,	contentType : "application/json; charset=utf-8"
						,	jsonStringify : true
						,	parameterMapping : function( data ) {
								
								data.frDt = ($('#txtFromDate').val().replace(/-/gi,'') || '');
								data.toDt = ($('#txtToDate').val().replace(/-/gi,'') || ''); /* 승인일자  */
								data.cardNum = ($('#txtCardNum').val().replace(/-/gi,'') || '');
								data.mercName = ($('#txtMercName').val() || ''); 
								data.cardName = ($('#txtCardName').val() || '');
							    //data.docSts = $('#selDocSts').val();
 							    //data.useYN = $('#selUseYN').val();
								switch ($('#selDocSts').val()) {
									case "" : // 전체
										data.docSts = "";
										data.useYN = "";
										break;
									case "1" : // 결의
										data.docSts = "1";
										data.useYN = "Y";
										break;
									case "0" : // 미결의
										data.docSts = "0";
										data.useYN = "Y";
										break;
									case "D" : // 미사용
										data.docSts = "";
										data.useYN = "N";
										break;
								}
								data.fileName = "카드사용현황";
								
							}
						}
					,	result : {
							data : function( response ) {
								return response.list;
							}
						,	totalCount : function( response ) {
								return response.totalCount;
							}
						,	error : function( response ) {
								alert( "error - Pudd.Data.DataSource.read, status code - " + response.status );
							}
						}
					
					});

					//data read Start
					sourceData.read();

					var totalCount = sourceData.totalCount;
					var dataPage = sourceData.dataPage;
					
					if( totalCount ) {
						
						downloadExcelProcess( dataPage, totalCount );
						
						// loading progressBar 종료처리
						progressBarObj.clearIntervalSet();
						
					}else {
						// loading progressBar 종료처리
						progressBarObj.clearIntervalSet();
						alert("<%=BizboxAMessage.getMessage("TX000009638","서비스 데이터가 없습니다.")%>");
						
					}
					
				}
			});	

	}

	function downloadExcelProcess( dataPage, totalCount ) {

		var excel = new JExcel("맑은 고딕 11 #333333");
		excel.set( { sheet : 0, value : "지출결의확인Sheet" } );

		//헤더 컬럼 세팅
		var headers = [ '<%=BizboxAMessage.getMessage("TX000005457","승인일자")%>', '<%=BizboxAMessage.getMessage("TX000007536","승인시간")%>'
			, '<%=BizboxAMessage.getMessage("TX000000313","거래처")%>'
			, '<%=BizboxAMessage.getMessage("TX000010591","사업자등록번호")%>', '<%=BizboxAMessage.getMessage("TX000004699","카드번호")%>'
			, '<%=BizboxAMessage.getMessage("TX000000527","카드명")%>', "<%=BizboxAMessage.getMessage("TX000005709","금액")%>"
			, '<%=BizboxAMessage.getMessage("TX000009550","서비스금액")%>', '<%=BizboxAMessage.getMessage("TX000018453","공급가액")%>'
			, '<%=BizboxAMessage.getMessage("TX000009474","부가세액")%>', '<%=BizboxAMessage.getMessage("TX000005311","승인번호")%>'
			, '<%=BizboxAMessage.getMessage("TX000018128","문서번호")%>', '<%=BizboxAMessage.getMessage("TX000000565","전표번호")%>'
			, '승인취소여부',"결의상태" ];
		var formatHeader = excel.addStyle({
			border: "thin,thin,thin,thin #000000",
			font: "맑은 고딕 11 #333333 B",// U : underline, B : bold, I : Italic
			fill: "#dedede",
			align : "C"
		});

		for( var i=0; i<headers.length; i++ ) {
			excel.set( 0, i, 0, headers[i], formatHeader );// sheet번호, column, row, value, style
			// excel.set( 0, i, undefined, "15" ); // sheet번호, column, row, value(width)
			excel.setColumnWidth( 0, i, "15" ); // sheet번호, column, value(width)
		}
		//엑셀 순번 컬럼 사이즈 작게
		excel.set( 0, 0, undefined, "8" ); // sheet번호, column, row, value(width)
		for( var i=1; i<=totalCount; i++ ) {

			var idx = i-1;
			
			var resolution = "";
			
			if(dataPage[ idx ][ "authYn" ] == 'U'){
				resolution = "결의";
			}else if(dataPage[ idx ][ "authYn" ] == 'Y'){
				resolution = "미사용";
			}else{
				resolution = "미결의";
			}
			
			excel.set( 0, 0, i, dataPage[ idx ][ "excelAuthDate" ] );
			excel.set( 0, 1, i, dataPage[ idx ][ "excelAuthTime" ] );
			excel.set( 0, 2, i, dataPage[ idx ][ "mercName" ] );
			excel.set( 0, 3, i, dataPage[ idx ][ "mercSaupNo" ] );
			excel.set( 0, 4, i, dataPage[ idx ][ "cardNum" ] );
			excel.set( 0, 5, i, dataPage[ idx ][ "cardName" ] );
			excel.set( 0, 6, i, dataPage[ idx ][ "requestAmount" ] );
			excel.set( 0, 7, i, dataPage[ idx ][ "serAmount" ] );
			excel.set( 0, 8, i, dataPage[ idx ][ "amtMdAmount" ] );
			excel.set( 0, 9, i, dataPage[ idx ][ "vatMdAmount" ] );
			excel.set( 0, 10, i, dataPage[ idx ][ "authNum" ] );
			excel.set( 0, 11, i, dataPage[ idx ][ "docNo" ] );
			excel.set( 0, 12, i, dataPage[ idx ][ "expendDocNm" ] );
			excel.set( 0, 13, i, dataPage[ idx ][ "georaeStatName" ] );
			excel.set( 0, 14, i, resolution );
			
		}
		excel.generate( "카드사용현황.xlsx" );
		// END ---------------------------------------------------------------------------------------- excel 설정
	}
	
	function fnSyncNow() {
		
		Pudd( "#loadingProgressBar" ).puddProgressBar({
			progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }

			,	strokeColor : "#84c9ff"	// progress 색상
			,	strokeWidth : "5px"	// progress 두께

			,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
			,	percentTextColor : "#84c9ff"
			,	percentTextSize : "15px"
			,	backgroundLayerAttributes : { style : "background-color:#000;filter:alpha(opacity=20);opacity:0.2;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
			,	progressStartCallback : function( progressBarObj ) {
				$.ajax({
		 			async : true,
		 			type : "post",
		 			url : '<c:url value="/common/batch/cms/CommonSetCmsSyncNow.do" />',
		 			datatype : "json",
		 			data : {},
		 			timeout : 240000,
		 			success : function(result) {
		 				$("#btnSearch").click();
		 			},
		 			error : function(err) {
		 				if(err.status == '504' || err.statusText == "timeout"){
		 					alert('동기화 시간이 오래 소요됩니다.\n서버에서 동기화가 진행되고 있으니 잠시 후 확인해주세요.');
		 				}else{
		 					alert('CMS동기화 중 오류가 발생했습니다. 다시 시도해주시기 바랍니다.\n계속 발생하는 경우 고객센터로 문의해 주세요.');
		 				}
		 			}
		 		});
				progressBarObj.clearIntervalSet();
			}
		});
		
 			
	}
	
	/* 카드 기간 연동  부분 */
	
	
	function fnCardBatchTimeSearch() {
		var data = {};
		/* 카드 내역 조회 */
		$.ajax({
			type : 'post',
			url : '<c:url value="/expend/np/admin/NpAdminCardCmsBatchTime.do" />',
			datatype : 'json',
			async : true,
			data : data,
			success : function(result) {
				if(result.result.resultCode != 'FAIL'){
					$('#cardBatchTime').html(result.result.aData.modify_date);
					$('#btnCardPeriodSync').show();
					$('#cardBatchTime').show();
					$('#cardTime').show();
					$('#cmsSync').hide();
					
					if(result.result.aData.custom_yn=='Y'){
						$('#btnCardPeriodSync').hide();
						$('#cardBatchTime').show();
						$('#cardTime').show();
						$('#cmsSync').show();
					}
				}
				else{
					$('#btnCardPeriodSync').hide();
					$('#cardBatchTime').hide();
					$('#cardTime').hide();
					$('#cmsSync').hide();
				}
			},
			error : function(data) {
				console.log("! [EX] ERROR - " + JSON.stringify(data));
			}
		});
	}
	
	function GetBeforeMonth(){
		var Today = new Date();
		Today.setMonth((Today.getMonth() - 1));
		return [ Today.getFullYear(), (Today.getMonth() + 1) < 10 ? '0' + (Today.getMonth() + 1) : (Today.getMonth() + 1), (Today.getDate() < 10 ? '0' + Today.getDate() : Today.getDate()) ].join('-');
	}
	
	function GetToday(){
		var Today = new Date();
		return [ Today.getFullYear(), (Today.getMonth() + 1) < 10 ? '0' + (Today.getMonth() + 1) : (Today.getMonth() + 1), (Today.getDate() < 10 ? '0' + Today.getDate() : Today.getDate()) ].join('-');
	}
	
	
	function fnCardPeriodSync(){
		
		var puddDialog = Pudd.puddDialog({		 
			width : 440	// 기본값 300
		,   height: 100
		
		,	header : { 
				title : "카드내역연동"
			,	align : "left"	// left, center, right
		 	,	closeButton : true	// 기본값 true
		}
		,	body : {
				content : document.getElementById("cls_con")
			,	contentCallback : function( contentDiv ) {		 
			// cloneNode 전달방식임에 따라 id 설정은 사용 X, class명 설정으로 객체 참조할 것			
			}
		}
	,	footer : {		 
			buttons : [
						{				
							controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	clickCallback: function( puddDlg ) {
								cardWarning();
								puddDlg.showDialog( false );
							}
						,	value : "확인"
						}
						, {
							attributes : { class : "ml5" }// control 부모 객체 속성 설정
							, controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
							, value : "취소"
							, clickCallback : function (puddDlg){
								puddDlg.showDialog( false );
							}
						}
				      ]
			}		
		});
		
		/* 카드연동기간 한달 설정 */
		var calendarObj =  Pudd("#periodSyncCal").getPuddObject();
		if(!calendarObj) return;
		
		calendarObj.setDate(GetBeforeMonth(),GetToday());
	}
	
	function cardWarning(){
		
		var periodSelectedDate = Pudd( "#periodSyncCal" ).getPuddObject().getDate();
		if( ! periodSelectedDate || ( periodSelectedDate.startDate > periodSelectedDate.endDate ) ){
			Pudd.puddDialog({
				width : 400
				,	message : {
							type : "warning"
						,	content : "날짜를 올바른 형식으로 선택하여 주시기 바랍니다."
					}
				});
			return;
		}
		
		/* 서버호출 */
		$.ajax({
			type : 'post',
			url : '<c:url value="/common/batch/cms/CommonSetCmsSyncPeriod.do" />',
			datatype : 'json',
			async : true,
			data : {
				cmsPeriodSync : 'Y'
				, issDtFrom : periodSelectedDate.startDate.replaceAll('-','') 
				, issDtTo : periodSelectedDate.endDate.replaceAll('-','')
			},
			success : function(data) {
				if (data.result.resultCode == 'SUCCESS') {
					Pudd.puddDialog({
						width : 400
						,	message : {
									type : "success"
								,	content : "CMS 배치가 완료 되었습니다."
							}
			
					});
				}
				else{
					Pudd.puddDialog({
						width : 400
						,	message : {
									type : "warning"
								,	content : "현재 카드내역연동이 이미 실행되고 있습니다. 잠시 후 다시 실행해주시기 바랍니다."
							}
						});	
				}
				
			},
			error : function(err) {
				if(err.status == '504' || err.statusText == "timeout"){
					Pudd.puddDialog({
						width : 400
						,	message : {
									type : "error"
								,	content : "동기화 시간이 오래 소요됩니다.\n서버에서 동기화가 진행되고 있으니 잠시 후 확인해주세요."
							}
					});
				}else {
 					Pudd.puddDialog({
						width : 400
						,	message : {
									type : "error"
								,	content : "동기화 중 이상이 발생하였습니다."
							}
						});
				}
			}
		});

		
	}
	
	

</script>

<!-- hidden -->
<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="frDt" value="" id="frDt"/>
	<input type="hidden" name=toDt value="" id="toDt"/>
	<input type="hidden" name="cardNum" value="" id="cardNum"/>
	<input type="hidden" name="mercName" value="" id="mercName"/>
	<input type="hidden" name="docSts" value="" id="docSts"/>
	<input type="hidden" name="excelHeader" value="" id="excelHeader"/>
	<input type="hidden" name="fileName" value="" id="fileName">
</form>
<!-- body -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt><%=BizboxAMessage.getMessage("TX000005457","승인일자")%></dt>
			<dd>
				<input id="txtFromDate" value="" class="dpWid datepicker" /> ~ <input id="txtToDate" value="" class="dpWid datepicker" />
			</dd>
			<dt>${CL.ex_resCondition} <!--결의상태--></dt>
			<dd>
				<SELECT id="selDocSts" class="selectmenu" style="width: 60px;">
					<OPTION VALUE="">${CL.ex_all} <!--전체--></OPTION>	
					<OPTION VALUE="1">${CL.ex_res} <!--결의--></OPTION>
					<OPTION VALUE="0">${CL.ex_noRes} <!--미결의--></OPTION>
					<OPTION VALUE="D">${CL.ex_noUser} <!--미사용--></OPTION>
				</SELECT>
			</dd>
<%-- <!-- 보류 세금계산서현황과 카드사용현황의 기준 통일 필요. by Kwon Oh Gwang on 2019-08-21 -->
 			<dt>${CL.ex_inUseYN} <!--사용여부--></dt> 
 			<dd> 
 				<SELECT id="selUseYN" class="selectmenu" style="width: 60px;"> 
 					<OPTION VALUE="">${CL.ex_all} <!--전체--></OPTION>	 
 					<OPTION VALUE="Y">${CL.ex_use} <!--사용--></OPTION> 
 					<OPTION VALUE="N">${CL.ex_notUse} <!--미사용--></OPTION> 
				</SELECT> 
 			</dd>  --%>
			<dd>
				<div class="controll_btn p0">
					 <button id="btnSearch" class="btn_sc_add">${CL.ex_search}</button>
				</div>
			</dd>				
			
		</dl>
		<span class="btn_Detail"><%=BizboxAMessage.getMessage("TX000005724","상세검색")%> <img id="all_menu_btn"
				  src='../../../Images/ico/ico_btn_arr_down01.png' />
		</span>
	</div>
	<!-- 상세검색박스 -->
	<div class="SearchDetail">
		<dl>
			<dt style="width: 60px;">${CL.ex_cardNumber}</dt>
			<dd class="mr5">
				<input id="txtCardNum" type="text" value="" style="width: 300px">
			</dd>
			<dt style="width: 60px;">${CL.ex_theNameOfCard}</dt>
			<dd class="mr5">
				<input id="txtCardName" type="text" value="" style="width: 300px">
			</dd>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000018786","사용처")%></dt>
			<dd class="mr5">
				<input id="txtMercName" type="text" value="" style="width: 300px">
			</dd>
		</dl>
	</div>
	<!-- <div id="" class="controll_btn cl"><button id="" class="k-button">상신</button></div> -->
	<div id="button_area" class="controll_btn cl">
		<span class="fwb mt5" style="text-align:left;float:left">총 <span id="valTotalCount">0</span> 건</span>
		<button id="btnExcelDown" class="k-button">${CL.ex_excelDown} <!--엑셀다운로드--></button>
		<button id="btnUnUse">${CL.ex_noUser} <!--미사용--></button>
		<button id="btnUse">${CL.ex_noUserClear} <!--미사용해제--></button>
		<select id="selViewLength" class="selectmenu"><!-- 공통코드 처리 필요 -->
			<option value="10">10<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			<option value="20">20<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			<option value="30">30<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			<option value="40">40<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			<option value="50">50<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
		</select>
	</div>
	<!-- 테이블 -->
	<div class="com_ta2">
		<table id="tblUserCardReportView">
			<colgroup>
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="100" />
				<col width="100" />
				<col width="" />
			</colgroup>
		</table>
	</div>
	
	<div id="loadingProgressBar"></div>
	<div id="ProgressBar"></div>
	
	<!-- 카드내역연동-->
	<div id="cls_con" style="display: none;">
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="120"/>
					<col/>
				</colgroup>
				<tr>
					<th>승인일자</th>
					<td>
						<input id="periodSyncCal" type="text" class="puddSetup" pudd-style="width:400px;" pudd-type="datepicker" pudd-type-display="period" pudd-period-type="double" pudd-start-date="" pudd-end-date="" />					
					</td>
				</tr>
			</table>
		</div>
	
		<p class="txt mt20 f11"> * 연동 후에도 ERP 데이터를 가져오지 못할 경우 고객센터 (1544 9625) 로 <br>&nbsp;&nbsp;문의해주시기 바랍니다</p>
	</div>
	
	
	
</div>
<!-- //sub_contents_wrap -->

