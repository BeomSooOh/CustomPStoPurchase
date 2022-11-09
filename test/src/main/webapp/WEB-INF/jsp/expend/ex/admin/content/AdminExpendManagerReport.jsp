<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/pudd/pudd-1.1.79.min.js"></c:url>'></script>
<!-- javascript -->

<!--Excel다운로드를 위한 js-->
<script type="text/javascript" src='<c:url value="/js/t_excel/jszip-3.1.5.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/t_excel/FileSaver-1.2.2_1.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/t_excel/jexcel-1.0.4.js"></c:url>'></script>

<!-- /* 프로그레스 레이어 팝업 참조 */ -->
<jsp:include page="../../../../common/layer/ProgressLayerPop.jsp" flush="false" />
<script>
	/* AdminExpendManagerReport var */
    var authPageYN = '${AuthPageYN}' || 'N';
    /* 데이터테이블 현재 페이지 저장 여부 */
    var isInitPage = false;
    /* 현황 리스트 저장 변수 */
	var listData = {};
    
	/* document.ready */
	$(document).ready(function() {
		<c:if test="${ViewBag.empInfo.groupSeq == 'dev'}"> /* 개발버전인 경우 */
		debug = true;
		/* $('#btnDebugViewVar').show(); */
		/* setClick($('#btnDebugViewVar'), showLog); */
		</c:if>

		log('+ [AdminExpendManagerReport] (document).ready');
		fnAdminExpendManagerReportInit();
		fnAdminExpendManagerReportEventInit();
		$('#btnReportExpendAdmSearch').click(); 
		
		
// 		<c:if test="${erpType == 'ERPiU'}"> /* ERPiU인 경우 */
// 			$("#noteInfo").text("적요가 100글자가 넘으면 자동으로 줄여서 나갑니다.");
// 		</c:if>
// 		<c:if test="${erpType == 'iCUBE'}"> /* ERPiU인 경우 */
// 			$("#noteInfo").text("* 적요(80글자), 문서제목+문서번호(100글자)가 넘으면 자동으로 줄여서 나갑니다.");
// 		</c:if>
		log('- [AdminExpendManagerReport] (document).ready');
	});
	
	function xl_fc(th) { 
		//툴팁 생성
		$(".down_lay").show();
	}

	function clo_fc() {
		//툴팁 생성
		$(".down_lay").hide();
	}
	
	/* fnAdminExpendManagerReportInit */
	function fnAdminExpendManagerReportInit() {
		log('+ [AdminExpendManagerReport] fnAdminExpendManagerReportInit');
		fnAdminExpendManagerReportInitLayout();
		fnAdminExpendManagerReportInitDatepicker();
		fnAdminExpendManagerReportInitInput();
		fnAdminExpendManagerReportInitButton();
		log('- [AdminExpendManagerReport] fnAdminExpendManagerReportInit');
	}
	/* fnAdminExpendManagerReportInit - Layout */
	function fnAdminExpendManagerReportInitLayout() {
		log('+ [AdminExpendManagerReport] fnAdminExpendManagerReportInitLayout');
		$('#btnClearDt').click(function(){
			$('#dtExpendDt').val('');
		});
		log('- [AdminExpendManagerReport] fnAdminExpendManagerReportInitLayout');
	}
	/* fnAdminExpendManagerReportInit - Datepicker */
	function fnAdminExpendManagerReportInitDatepicker() {
		log('+ [AdminExpendManagerReport] fnAdminExpendManagerReportInitDatepicker');
		/* class="datepicker" datepicker 정의 */
		setDatePicker($('.datepicker'));/* 결의(회계)일자 *//* 지급요청일 */
		$('#txtReqDate').val(''); /* 지급요청일자는 기본값이 아니므로, 사용자 선택 사항 */
		fnInitDatePicker(1);
		log('- [AdminExpendManagerReport] fnAdminExpendManagerReportInitDatepicker');
	}

	/*	[데이트 피커] Initialrize date picker with gap
	----------------------------------------*/
	function fnInitDatePicker(monthGap) {

		// Object Date add prototype
		Date.prototype.ProcDate = function() {
			var yyyy = this.getFullYear().toString();
			var mm = (this.getMonth() + 1).toString(); //
			var dd = this.getDate().toString();
			return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-'
					+ (dd[1] ? dd : "0" + dd[0]);
		};
		var toD = new Date();
// 		$('#txtReqDate').val(toD.ProcDate());

		if (toD.getMonth() == 0) {
			var fromD = new Date(toD.getFullYear() - 1, 11, toD.getDate());
		} else {
			var fromD = new Date(toD.getFullYear(), toD.getMonth() - monthGap,
					toD.getDate());
		}
		$('#txtFromDate').val(fromD.ProcDate());
		$('#txtExpFromDate').val('');
		$('#txtExpToDate').val('');
		$('#dtExpendDt').val('');
	}

	/* fnAdminExpendManagerReportInit - Input */
	function fnAdminExpendManagerReportInitInput() {
		log('+ [AdminExpendManagerReport] fnAdminExpendManagerReportInitInput');
		log('- [AdminExpendManagerReport] fnAdminExpendManagerReportInitInput');
		
        /* 기본값 지정 */
        var bizList = ('${bizList}' === '' ? [] : ${bizList});
        $("#selAppBiz").empty();
		$.each(bizList, function(idx, item) {
			$("#selAppBiz").append("<option value='" + item.commonCode + "'>" + item.commonName + "</option>");
		});
		
		$("#selAppBiz").selectmenu({change: function(){
		}});
		
		if(bizList.length > 0){
			$("#selAppBiz").val(bizList[0].commonCode).selectmenu('refresh');
		}
        
		$("#selViewLength").selectmenu({change: function(){
			$('select[name=tblReportExpendAdmList_length]').val($('#selViewLength').val());
			$('select[name=tblReportExpendAdmList_length]').trigger('change');
		}});
	}
	/* fnAdminExpendManagerReportInit - Button */
	function fnAdminExpendManagerReportInitButton() {
		log('+ [AdminExpendManagerReport] fnAdminExpendManagerReportInitButton');
		$('#btnReturnErpAdocu').click(function() {
			fnAdminExpendManagerReportSendCancel();
		});
		$('#btnSendErpAdocu').click(function() {
			fnAdminExpendManagerReportSend();
		});
		
		$("#btnCloseSetting").click(function(){
			var url = "<c:url value='/ex/expend/admin/AdminCloseDatePop.do'/>";

	    	var popupWidth = 455;
		    var popupHeight = 377;
		    var windowX = (screen.width - popupWidth)/2;
		    var windowY = (screen.height - popupHeight)/2;
		    
			var win = window.open(url,"마감설정","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY +"");
			
	        if(win== null || win.screenLeft == 0){
	        	alert("<%=BizboxAMessage.getMessage("TX000018810","브라우져 팝업차단 설정을 확인해 주세요")%>");
	        }
		});
		log('- [AdminExpendManagerReport] fnAdminExpendManagerReportInitButton');
	}

	/* fnAdminExpendManagerReportEventInit */
	function fnAdminExpendManagerReportEventInit() {
		log('+ [AdminExpendManagerReport] fnAdminExpendManagerReportEventInit');
		fnAdminExpendManagerReportEventInitButton();
		fnAdminExpendManagerReportEventInitInput();
		log('- [AdminExpendManagerReport] fnAdminExpendManagerReportEventInit');
	}
	/* fnAdminExpendManagerReportEventInit - Button */
	function fnAdminExpendManagerReportEventInitButton() {
		log('+ [AdminExpendManagerReport] fnAdminExpendManagerReportEventInitButton');
		setClick($(eventTarget.search), function() {
			isInitPage = false;
			fnAdminExpendManagerReportSearch();
		});

		log('- [AdminExpendManagerReport] fnAdminExpendManagerReportEventInitButton');
	}
	/* fnAdminExpendManagerReportEventInit - Input */
	function fnAdminExpendManagerReportEventInitInput() {
		log('+ [AdminExpendManagerReport] fnAdminExpendManagerReportEventInitInput');
		/* 엔터 키 이벤트 */
        $("#txtFromDate, #txtToDate, #txtExpFromDate, #txtExpToDate, #txtReqDate, #txtAdocuNo, #txtAppUserName, #txtDocNo, #txtDocTitle, #txtAppBiz, #txtUseDept, #txtUseEmp, #txtFormTitle").keydown(function (event) {
            if (event.keyCode === 13) {
            	$('#btnReportExpendAdmSearch').click();
            }
        });
		log('- [AdminExpendManagerReport] fnAdminExpendManagerReportEventInitInput');
	}

	function getCheckedData() {
		var chkSels = $("input[name=inp_chk]:checkbox:checked").map(
				function(idx) {
					return JSON.parse(this.value);
				}).get();

		return chkSels;
	}

	/* ERP 전송 */
	function fnAdminExpendManagerReportSend() {
		
		isInitPage = true;
		
		/*서버 연산 진행중이면 리턴*/
		if(PLP_fnIsGetProgressing()){
			return;
		}
					
		/* 사용자 아이템 선택 확인 */
		var checkedValue = getCheckedData();
		var length = checkedValue.length; 
		if (!length) {
			alert("<%=BizboxAMessage.getMessage("TX000002159","선택된 문서가 없습니다.")%>");
			return;
		}

		if( ($('#dtExpendDt').val() != '') && confirm('사용자가 변경한 회계일자로 전송됩니다. \n(예산연동 문서 제외)')){
			fnStartSendRecurFunc(0, checkedValue, true, checkedValue);
		}else if(($('#dtExpendDt').val() != '') && confirm('기존 회계일자로 전송합니다.')){
			fnStartSendRecurFunc(0, checkedValue, false, checkedValue);
		}else if(($('#dtExpendDt').val() == '')){
			fnStartSendRecurFunc(0, checkedValue, false, checkedValue);
		}
	}

	function fnStartSendRecurFunc(idx, arr, userDate, checkedValue){
		/* 프로그레스 다이얼로그 시작 */ 
		PLP_fnShowProgressDialog({
			title : "<%=BizboxAMessage.getMessage("TX000018765","ERP 전표전송")%>"		
				, progText : "<%=BizboxAMessage.getMessage("TX000018766","전표전송을 진행중입니다.")%>"	 
				, endText : "<%=BizboxAMessage.getMessage("TX000018767","전표전송이 완료되었습니다.")%>"	
				, popupPageTitle : "<%=BizboxAMessage.getMessage("TX000018768","ERP 전표전송 실패사유")%>"	
				, popupColGbn : "<%=BizboxAMessage.getMessage("TX000000663","문서번호")%>"	
				, popupColDetail : "<%=BizboxAMessage.getMessage("TX000018764","실패사유")%>"	
			}); 
		PLP_fnSetProgressValue(0, 0, checkedValue.length);
		/* 전표전송 재귀호출 */
		fnReportSendRecurence(0, checkedValue, userDate);

		$('#list_send_cancle').show();
	}
	
	/* UI 접근을위한 재귀함수 구성 / 전표 전송 */	
	function fnReportSendRecurence(idx, arr, userDate){
		isInitPage = true;
	
		if(idx >= arr.length){
			PLP_fnEndProgressDialog();
			fnAdminExpendManagerReportSearch();
			return ;
		}
		var item = arr[idx++];
		var length = arr.length;
		var docNo = item.appDocNo;
		if (item.expendErpSendYn == 'Y') {
			// 이미 전송된 문서 예외 처리	
			PLP_fnSetErrInfo({
				'colGbn' : docNo
				, 'colDetail' : "<%=BizboxAMessage.getMessage("TX000018769","이미 전송된 문서입니다.")%>"
			});		
			PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);
			fnReportSendRecurence(idx, arr, userDate);
		}else{
			var advExpendDt = ( userDate == true ) ? $('#dtExpendDt').val().replace(/-/gi, '') :  item.expendDate.replace(/-/gi, '');  
			$.ajax({
				type : "post",
				async : true,
				url : '<c:url value="/expend/ex/admin/ExAdminExpendManagerReportSend.do"></c:url>',
				datatype : "json",
				data : {
					'param' : 'test',
					'expendSeq' : item.expendSeq,
					'advExpendDt' :  advExpendDt// 예산 미사용의 경우 이값 사용
				},
				success : function(result) {
					if(result.result.resultCode == 'FAIL'){
						PLP_fnSetErrInfo({
							'colGbn' : docNo
							, 'colDetail' : result.result.resultName
						});
						PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);	
					}else{
						PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
					}
					value = ( (idx * 1.0 ) / ( length * 1.0 )) * 100;
					fnReportSendRecurence(idx, arr, userDate);
				},
				error : function(e, status) { //error : function(xhr, status, error) {
					alert(status);
				}
			});
		}	
	}
	
		
	/* ERP 전송 취소 */
	function fnAdminExpendManagerReportSendCancel() {
		isInitPage = true;
		
		/*서버 연산 진행중이면 리턴*/
		if(PLP_fnIsGetProgressing()){
			return;
		}
					
		/* 사용자 아이템 선택 확인 */
		var checkedValue = getCheckedData();
		var length = checkedValue.length; 
		if (!length) {
			alert("<%=BizboxAMessage.getMessage("TX000002159","선택된 문서가 없습니다.")%>");
			return;
		}

		/* 프로그레스 다이얼로그 시작 */ 
		PLP_fnShowProgressDialog({ 
			title : "<%=BizboxAMessage.getMessage("TX000018771","ERP 전표전송취소")%>"		
				, progText : "<%=BizboxAMessage.getMessage("TX000018772","전표전송취소를 진행중입니다.")%>" 	
				, endText : "<%=BizboxAMessage.getMessage("TX000018773","전표전송취소가 완료되었습니다.")%>"	
				, popupPageTitle : "<%=BizboxAMessage.getMessage("TX000018774","ERP 전표전송취소 실패사유")%>"	
				, popupColGbn : "<%=BizboxAMessage.getMessage("TX000000663","문서번호")%>"
				, popupColDetail : "<%=BizboxAMessage.getMessage("TX000018775","실패사유")%>"	
			}); 
		PLP_fnSetProgressValue(0, 0, checkedValue.length);
		fnReportCancelRecurence(0, checkedValue);
		$('#list_send_cancle').show();
	}

	/* UI 접근을위한 재귀함수 구성 / 전표 전송 취소 */	
	function fnReportCancelRecurence(idx, arr){
		isInitPage = true;
	
		if(idx >= arr.length){
			PLP_fnEndProgressDialog();
			fnAdminExpendManagerReportSearch();
			return ;
		}
		var item = arr[idx++];
		var length = arr.length;
		var docNo = item.appDocNo;
		if (item.expendErpSendYn != 'Y') {
			// 전송되지 않은 문서 예외 처리
			PLP_fnSetErrInfo({
				'colGbn' : docNo
				, 'colDetail' : "<%=BizboxAMessage.getMessage("TX000018776","전송되지않은 문서입니다.")%>"
			});
			PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);
			fnReportCancelRecurence(idx, arr);
		}else{
			$.ajax({
				type : "post",
				async : true,
				url : '<c:url value="/expend/ex/admin/ExReportExpendSendListInfoSendCancel.do"></c:url>',
				datatype : "json",
				data : {
					'expendSeq' : item.expendSeq,
					'inDt' : item.expendIcubeAdocuId,
					'inSq' : item.expendIcubeAdocuSeq,
					'cdCompany' : item.cdCompany, 
					'rowId' : item.expendErpiuAdocuId	
				},
				success : function(result) {
					if(result.result.resultCode == 'FAIL'){
						PLP_fnSetErrInfo({
							'colGbn' : docNo
							, 'colDetail' : result.result.resultName
						});
						PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);	
					}else{
						PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
					}
					
					value = ( (idx * 1.0 ) / ( length * 1.0 )) * 100;
					fnReportCancelRecurence(idx, arr);
				},
				error : function(e, status) { //error : function(xhr, status, error) {
					alert(status);
				}
			});
		}	
	}
		
	/* function -fnAdminExpendManagerReportSearch */
	var rowIdx = 0;
	function fnAdminExpendManagerReportSearch() {
		var expFDate = $('#txtExpFromDate').val().toString().replace(/-/g, '');
		var expTDate = $('#txtExpToDate').val().toString().replace(/-/g, '');
		if( expFDate == ''){ 
			expFDate = '19000101';
		}
		if( expTDate == ''){ 
			expTDate = '99991231'
		}
		
		var result = ajax({
			url : "/expend/ex/admin/ExAdminExpendCheckReportListInfoSelect.do",
			async : false,
			parameter : {
				searchFromDate : ($('#txtFromDate').val().toString().replace(/-/g, '') || ''),/* 결의일자 */
				searchToDate : ($('#txtToDate').val().toString().replace(/-/g, '') || ''),/* 결의일자 */
				searchExpFromDate : expFDate,/* 회계일자 */
				searchExpToDate : expTDate,/* 회계일자 */
				reqDate : ($('#txtReqDate').val().toString().replace(/-/g, '') || ''),/* 지급요청일 */
				adocuNo : ($('#txtAdocuNo').val().toString() || ''),/* 자동전표번호 */
				appUserName : ($('#txtAppUserName').val().toString() || ''),/* 작성자 */
				docNo : ($('#txtDocNo').val().toString() || ''),/* 문서번호 */
				docTitle : ($('#txtDocTitle').val().toString() || ''),/* 문서제목 */
				erpSendYN : $("#selErpSendYN").val(),
				authPageYN : authPageYN /* 사용자 양식권한 페이지인지 아닌지 여부 Y/N */,
				bizCd : ($("#selAppBiz").val()=="전체"?"":$("#selAppBiz").val()),
				formName: ($("#txtFormTitle").val() || ''),
				useDept : ($("#txtUseDept").val() || ''),
				useEmp : ($("#txtUseEmp").val() || '')
				
			}
		});
		
		rowIdx = -1;
		/* docSeq, formSeq, formName, formMode, expendSeq, docNo, docTitle, userName, expendDate, expendReqDate, useEmpName, useDeptName, drAmt, vatAmt, subStdAmt, subTaxAmt, crAmt, erpSendYN, expendErpSendName ,erpSendDate */
		/* 문서번호 / 문서제목 / 기안자 / 결의(회계)일자 / 지급요청일 / 사용자 / 사용부서 / 공급가액(과세표준액) / 부가세액(세액) / 공급대가 / 전송여부 */
		var columnDefs = [
				{
					"targets" : 0,
					"data" : null,
					"render" : function(data) {
						var chkObj = $.extend(true, {}, data);
						chkObj.appDocTitle = '';
						// chkObj.appDocNo = '';
						return "<input type='checkbox' name='inp_chk' id='inp_chk"
								+ (++rowIdx)
								+ "' class='k-checkbox tableChkBox' value='"
								+ (JSON.stringify(chkObj)).replace(/\'/g,"&#39;").replace(/\"/g,"&quot;")
								+ "'><label class='k-checkbox-label bdChk' for='inp_chk"
								+ (rowIdx) + "'></label>";
					}
				},
				{
					"targets" : 1,
					"data" : null,
					"render" : function(data) {
						return '<a href="javascript:;" title="'+ data.formName +'" onClick="javascript: fnAppdocPop('
								+ "'"
								+ data.docSeq
								+ "', '"
								+ data.formSeq
								+ "'" + ')">' + data.appDocNo + '</a>';
					}
				},
				{
					"targets" : 2,
					"data" : null,
					"render" : function(data) {
						if(data.expendErpSendYn == 'Y'){
							return data.appDocTitle;
						}else{
							return '<a href="javascript:;" onClick="javascript: fnExpendPop('
							+ "'"
							+ data.formSeq
							+ "', '"
							+ data.formDTp
							+ "', '"
							+ data.docSeq
							+ "', '"
							+ data.expendSeq
							+ "', '"
							+ data.formName
							+ "'" + ')">' + data.appDocTitle + '</a>';
						}
					}
				},
				{
					"targets" : 4,
					"data" : null,
					"render" : function(data) {
						if(data.expendDate == undefined || data.expendDate.toString() == '' || data.expendDate.toString() == '_______'){
							return '';
						}else{
							return data.expendDate.toString().replace(
									/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3');	
						}
						
					}
				},
				{
					"targets" : 5,
					"data" : null,
					"render" : function(data) {
						if(data.expendReqDate == undefined || data.expendReqDate.toString() == '' || data.expendReqDate.toString() == '_______'){
							return '';
						}else{
							return data.expendReqDate.toString().replace(
									/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3');
						}
						
					}
				},
				{
					"targets" : 6,
					"data" : null,
					"render" : function(data) {
						if(data.authDate == undefined || data.authDate.toString() == '' || data.authDate.toString() == '_______'){
							return '';
						}else{
							return data.authDate.toString().replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3');
						}
					}
				},
				{
					"targets" : 9,
					"data" : null,
					"render" : function(data) {
						return data.drAmt.toString().replace(
								/\B(?=(\d{3})+(?!\d))/g, ',');
					}
				},
				{
					"targets" : 10,
					"data" : null,
					"render" : function(data) {
						return data.vatAmt.toString().replace(
								/\B(?=(\d{3})+(?!\d))/g, ',');
					}
				},
				{
					"targets" : 11,
					"data" : null,
					"render" : function(data) {
						return data.crAmt.toString().replace(
								/\B(?=(\d{3})+(?!\d))/g, ',');
					}
				},
				{
					"targets" : 12,
					"data" : null,
					"render" : function(data) {
						if (data.expendErpSendYn == 'Y') {
							return '성공' + '('+ data.expendErpSendName +')';
						} else if(data.expendErpSendYn == 'I'){
							return '실패';
						} else {
							return '미전송';
						}
					}
				},
				{
					"targets" : 13,
					"data" : null,
					"render" : function(data) {
						//iU의 경우 IU - ID표현 // iCUBE의 경우 큐브 아이디 표현
						var autoId = data.expendErpiuAdocuId || ((data.expendIcubeAdocuId || '') + (data.expendIcubeAdocuSeq == '0' ? '' : data.expendIcubeAdocuSeq));
						if(autoId == 'null'){
							// oracle 'null' 문자열 반환 시 예외처리
							autoId = '';
						}
						return autoId;
					}
				} ];
		var columns = [
				{
					"sTitle" : "<input type='checkbox' id='chkSel' name='checkAll' class='check2 k-checkbox' onClick='javascript:fnCheckBoxAllCheck();' title='전체선택' id='checkAll' /><label class='k-checkbox-label' for='chkSel'></label>",
					"bVisible" : true,
					"bSortable" : false,
					"sWidth" : "40px"
				}, {
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000000663","문서번호")%>",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000003457","문서제목")%>",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000000499","기안자")%>",
					"mData" : "appUserName",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "${CL.ex_accountingDate}",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "${CL.ex_paymentDate}",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "${CL.ex_evidenceDate}",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "${CL.ex_user}",
					"mData" : "expendUseEmpName",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "${CL.ex_useDepartment}",
					"mData" : "expendUseDeptName",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "${CL.ex_purPrice}",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "${CL.ex_additionalTaxAmount}",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "${CL.ex_amountSupply}",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000001003","전송여부")%>",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				}, {
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000018779","자동전표번호")%>",
					"bVisible" : true,
					"bSortable" : true,
					"sWidth" : ""
				} ];
		
		$('#tblReportExpendAdmList').dataTable({
			select : true,
			bAutoWidth : false,
			destroy : true,
			lengthMenu : [ [ 10, 20, 30, 40, 50 ], [ 10, 20, 30, 40, 50 ] ],
			language : getTableDef('language'),
			data : result.aaData,
			columnDefs : columnDefs || [],
			aoColumns : columns || '',
			bStateSave: isInitPage,
			bSort : true,
			paging : true,
			"order": [[ 1, "desc" ]]
		});
		
		$("#valTotalCount").text(result.aaData.length);
		$('select[name=tblReportExpendAdmList_length]').val($('#selViewLength').val());
		$('select[name=tblReportExpendAdmList_length]').trigger('change');
		listData = result.aaData;
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

	/* function - fnPrintPop */
	function fnPrintPop(expendSeq) {
		alert("<%=BizboxAMessage.getMessage("TX000009615","서비스 준비중입니다")%>");
	}

	/* function - fnAppdocPop */
	function fnAppdocPop(docSeq, formSeq) {
		var intWidth = '1000';
		var intHeight = screen.height - 100;
		var agt = navigator.userAgent.toLowerCase();

		if (agt.indexOf("safari") != -1) {
			intHeight = intHeight - 70;
		}

		var intLeft = screen.width / 2 - intWidth / 2;
		var intTop = screen.height / 2 - intHeight / 2 - 40;

		if (agt.indexOf("safari") != -1) {
			intTop = intTop - 30;
		}
		var url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq
				+ "&form_id=" + formSeq + "&doc_auth=1";
		window.open(url, 'AppDoc',
				'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width='
						+ intWidth + ',height=' + intHeight + ',left='
						+ intLeft + ',top=' + intTop);
	}
	
	/* function - fnAppdocPop */
	function fnExpendPop(formSeq, formTp, docSeq, expendSeq, formName) {
		var intWidth = '900';
		var intHeight = screen.height - 100;
		var agt = navigator.userAgent.toLowerCase();

		if (agt.indexOf("safari") != -1) {
			intHeight = intHeight - 70;
		}

		var intLeft = screen.width / 2 - intWidth / 2;
		var intTop = screen.height / 2 - intHeight / 2 - 40;

		if (agt.indexOf("safari") != -1) {
			intTop = intTop - 30;
		}
		var url = "/exp/ExpendPop.do?form_id=" + formSeq + "&form_tp=" + formTp + "&doc_width=900&doc_id=" + docSeq + "&expendSeq=" + expendSeq + "&adminReport=Y"
		window.open(url, formName,
				'menubar=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width='
						+ intWidth + ',height=' + intHeight + ',left='
						+ intLeft + ',top=' + intTop);
	}
	
	/*	[화면 재구성] 화면 출력 정보 재구성
 	----------------------------------------------*/
	function EMR_fnReDrawViewInfo(param){
		$('#btnReportExpendAdmSearch').click();
	}

	 /*	[서버 호출] 법인카드 사용내역 데이터 Excel 다운로드
 	--------------------------------------*/
	function fnAdminReportExcelDown(excelType) {
		 
		 if($("#viewLoading").css("display") != "block"){
		   	   $("#viewLoading").css("width", "100%");
		       $("#viewLoading").css("height", "100%");
		       $("#viewLoading").fadeIn(100);    		
		   }
		 
		 // excelType 정의 ( A : 기본정보 , B : 상세정보 )
		if( !listData || listData.length == undefined || listData.length == 0){
			 alert("데이터가 없습니다.");
			 return false;
		 }
		var expFDate = $('#txtExpFromDate').val().toString().replace(/-/g, '');
		var expTDate = $('#txtExpToDate').val().toString().replace(/-/g, '');
		if( expFDate == ''){ 
			expFDate = '19000101';
		}
		if( expTDate == ''){ 
			expTDate = '99991231'
		}
		
		/* 파라미터  */
		var param = {};
		$("#searchFromDate").val(($('#txtFromDate').val().toString().replace(/-/g, '') || ''));
		$("#searchToDate").val(($('#txtToDate').val().toString().replace(/-/g, '') || ''));/* 결의일자 */
		$("#searchExpFromDate").val(expFDate);
		$("#searchExpToDate").val(expTDate);/* 회계일자 */
		$("#reqDate").val(($('#txtReqDate').val().toString().replace(/-/g, '') || ''));/* 지급요청일 */
		$("#adocuNo").val(($('#txtAdocuNo').val().toString() || ''));/* 자동전표번호 */
		$("#appUserName").val(($('#txtAppUserName').val().toString() || ''));/* 작성자 */
		$("#docNo").val(($('#txtDocNo').val().toString() || ''));/* 문서번호 */
		$("#docTitle").val(($('#txtDocTitle').val().toString() || ''));/* 문서제목 */
		$("#erpSendYN").val($("#selErpSendYN").val());
		$("#authPageYN").val(authPageYN); /* 사용자 양식권한 페이지인지 아닌지 여부 Y/N */
		$("#bizCd").val(($("#selAppBiz").val()=="전체"?"":$("#selAppBiz").val()));
		$("#formName").val(($("#txtFormTitle").val() || ''));
		$("#useDept").val(($("#txtUseDept").val() || ''));
		$("#useEmp").val(($("#txtUseEmp").val() || ''));
	    $('#excelType').val(excelType || 'A');
		
		$("#fileName").val( "지출결의확인" );
		
		/* Excel 헤더 정의 */
		var excelHeader = {};
		if((excelType || 'A') == 'A') {
			
			excelHeader.appDocNo = "문서번호";
			excelHeader.appDocTitle = "문서제목";
			excelHeader.appUserName = "기안자";
			excelHeader.expendDate = "회계일자";
			excelHeader.expendReqDate = "지급요청일";
			excelHeader.authDate = "증빙일자";
			excelHeader.expendUseEmpName = "사용자";
			excelHeader.expendUseDeptName = "사용부서";
			excelHeader.drAmt = "공급가액";
			excelHeader.vatAmt = "부가세액";
			excelHeader.crAmt = "공급대가";
			excelHeader.expendErpSendYn = "전송여부";
			excelHeader.erpSendSeq = "자동전표번호";
			
		}

		$("#excelHeader").val( JSON.stringify(excelHeader) );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
		
		$("#viewLoading").fadeOut(200);

	}

	function downloadExcelProcess( excelType, dataPage, totalCount ) {

		var excel = new JExcel("맑은 고딕 11 #333333");
		excel.set( { sheet : 0, value : "지출결의확인Sheet" } );

		//헤더 컬럼 세팅
		var headers;
		if((excelType || 'A') == 'A') {
			
			headers = [ "문서번호", "문서제목", "기안자", "회계일자", "지급요청일", "사용자", "사용부서", "공급가액", "부가세액", "공급대가", "전송여부", "자동전표번호" ];
			
		}
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
		
		if((excelType || 'A') == 'A') {

			for( var i=1; i<=totalCount; i++ ) {

				var idx = i-1;
				
				excel.set( 0, 0, i, dataPage[ idx ][ "appDocNo" ] );
				excel.set( 0, 1, i, dataPage[ idx ][ "appDocTitle" ] );
				excel.set( 0, 2, i, dataPage[ idx ][ "appUserName" ] );
				excel.set( 0, 3, i, dataPage[ idx ][ "expendDate" ] );
				excel.set( 0, 4, i, dataPage[ idx ][ "expendReqDate" ] );
				excel.set( 0, 5, i, dataPage[ idx ][ "expendUseEmpName" ] );
				excel.set( 0, 6, i, dataPage[ idx ][ "expendUseDeptName" ] );
				excel.set( 0, 7, i, dataPage[ idx ][ "drAmt" ] );
				excel.set( 0, 8, i, dataPage[ idx ][ "vatAmt" ] );
				excel.set( 0, 9, i, dataPage[ idx ][ "crAmt" ] );
				excel.set( 0, 10, i, dataPage[ idx ][ "expendErpSendYn" ] );
				excel.set( 0, 11, i, dataPage[ idx ][ "erpSendSeq" ] );
			}
			
		}

		excel.generate( "지출결의확인.xlsx" );
		// END ---------------------------------------------------------------------------------------- excel 설정
	}
	 
</script>

<!-- hidden -->
<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="searchFromDate" value="" id="searchFromDate"/>
	<input type="hidden" name="searchToDate" value="" id="searchToDate"/>
	<input type="hidden" name="searchExpFromDate" value="" id="searchExpFromDate"/>
	<input type="hidden" name="searchExpToDate" value="" id="searchExpToDate"/>
	<input type="hidden" name="reqDate" value="" id="reqDate"/>
	<input type="hidden" name="adocuNo" value="" id="adocuNo"/>
	<input type="hidden" name="appUserName" value="" id="appUserName"/>
	<input type="hidden" name="docNo" value="" id="docNo"/>
	<input type="hidden" name="docTitle" value="" id="docTitle"/>
	<input type="hidden" name="erpSendYN" value="" id="erpSendYN"/>
	<input type="hidden" name="authPageYN" value="" id="authPageYN"/>
	<input type="hidden" name="bizCd" value="" id="bizCd"/>
	<input type="hidden" name="formName" value="" id="formName"/>
	<input type="hidden" name="excelHeader" value="" id="excelHeader"/>
	<input type="hidden" name="fileName" value="" id="fileName">
	<input type="hidden" name="useDept" value="" id="useDept">
	<input type="hidden" name="useEmp" value="" id="useEmp">
	<input type="hidden" name="excelType" value="" id="excelType"/>
</form>
<!-- body -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<!-- 개발완료시 조건을 바꿔야됨(회사선택은  MASTER 권한)-->
			<c:if test="${ViewBag.empInfo.userSe == 'MASTER'}">
				<dt><%=BizboxAMessage.getMessage("TX000000047","회사")%></dt>
				<dd>
					<div class="dod_search">
						<input type="text" id="selCompany" />
					</div>
				</dd>
			</c:if>
			<dt><%=BizboxAMessage.getMessage("TX000000938","기안일자")%></dt>
			<dd>
				<input id="txtFromDate" class="dpWid datepicker" /> ~ <input
					id="txtToDate" class="dpWid datepicker" />
			</dd>
			<dt>${CL.ex_paymentDate}</dt>
			<dd>
				<input id="txtReqDate" value="" class="dpWid datepicker" />
			</dd>
			<dt>${CL.ex_transCheck} <!--전송여부--></dt>
			<dd>
				<select id="selErpSendYN" class="selectmenu">
					<option value="A">${CL.ex_all} <!--전체--></option>
					<option value="Y">${CL.ex_trans} <!--전송--></option>
					<option value="N">${CL.ex_notTrans} <!--미전송--></option>
				</select>
			</dd>
			<dd>
				<div class="controll_btn p0">
					 <button id="btnReportExpendAdmSearch" class="btn_sc_add">${CL.ex_search}</button>
				</div>
			</dd>			
		</dl>
		<span class="btn_Detail"><%=BizboxAMessage.getMessage("TX000005724","상세검색")%><img id="all_menu_btn"
			src='<c:url value="/Images/ico/ico_btn_arr_down01.png"/>' /></span>
	</div>
	<!-- 상세검색박스 -->
	<div class="SearchDetail">
		<dl>
			<dt style="width: 90px;"><%=BizboxAMessage.getMessage("TX000005174","회계일자")%></dt>
			<dd>
				<input id="txtExpFromDate" class="dpWid datepicker" /> ~ <input
					id="txtExpToDate" class="dpWid datepicker mr5" />
			</dd>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000000663","문서번호")%></dt>
			<dd class="mr5">
				<input id="txtDocNo" type="text" value="" style="width: 300px">
			</dd>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000001289","제목")%></dt>
			<dd class="mr5">
				<input id="txtDocTitle" type="text" value="" style="width: 300px">
			</dd>
		</dl>
		<dl>
			<dt style="width: 90px;"><%=BizboxAMessage.getMessage("TX000000811","사업장")%></dt>
			<dd class="mr5">
				<select id="selAppBiz" class="selectmenu" style="width: 222px;">
				</select>
			</dd>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000000537","사용부서")%></dt>
			<dd class="mr5">
				<input id="txtUseDept" type="text" value="" style="width: 300px">
			</dd>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000017846","사용자")%></dt>
			<dd class="mr5">
				<input id="txtUseEmp" type="text" value="" style="width: 300px">
			</dd>
		</dl>
		<dl>
			<dt style="width: 90px;"><%=BizboxAMessage.getMessage("TX000000499","기안자")%></dt>
			<dd class="mr5">
				<input id="txtAppUserName" type="text" value="" style="width: 211px">
			</dd>
			<dt style="width: 90px;"><%=BizboxAMessage.getMessage("TX000018779","자동전표번호")%></dt>
			<dd class="mr5">
				<input id="txtAdocuNo" type="text" value="" style="width: 300px">
			</dd>
			<dt style="width: 60px;"><%=BizboxAMessage.getMessage("TX000000492","문서분류")%></dt>
			<dd class="mr5">
				<input id="txtFormTitle" type="text" value="" style="width: 300px">
			</dd>
		</dl>
	</div>

	
	<div class="btn_div mt0" style="overflow:visible;">
		<div class="left_div">
			<span class="fwb mt14" style="text-align:left;float:left">총 <span id="valTotalCount">0</span> 건</span>
		</div>
		<div class="right_div posi_re pt10 pb10">
			<span id="noteInfo"></span> 
			<%-- <span>${CL.ex_accountingDate}</span>  --%>
			<span> ${CL.ex_accountingDate} <!--회계일자--> ${CL.ex_allChange}<!-- 일괄변경 --></span> 
			<input id="dtExpendDt" value="" class="dpWid datepicker" />
			<input type="button"  id="btnClearDt" class="puddSetup" style="background: #fff url(/exp/Images/btn/mail_btn_reload.png) no-repeat center;"data-role="button" role="button" aria-disabled="false" tabindex="0" title="${CL.ex_reset}"/>
			<input type="button" class="puddSetup" id="btnReturnErpAdocu" value="<%=BizboxAMessage.getMessage("TX000003157","전송취소")%>" >
			<input type="button" class="puddSetup" id="btnSendErpAdocu" value="<%=BizboxAMessage.getMessage("TX000002999","전송")%>" >
			<input type="button" class="puddSetup" id="btnCloseSetting" value="마감설정" >
			<input type="button" class="puddSetup" id="btnExcelDown" onclick="fnAdminReportExcelDown('A')" value="${CL.ex_excelDown}" />
			<!-- <input type="button" class="puddSetup" onclick="xl_fc(this)" value="${CL.ex_excelDown}" />
			<div class="down_lay" style="display:none;top:33px;right:75px;position:absolute;">
				<div class="down_lay_in">
				<a href="#n" onclick="clo_fc();" class="clo"></a>
					<div class="down_lay_con">
							<ul style="text-align:left;">
								<li><a href="#n" id="btnExcelDown" onclick="fnAdminReportExcelDown('A')">기본정보 다운로드</a></li>
								<li><a href="#n" id="btnExcelDown2" onclick="fnAdminReportExcelDown('B')">상세정보 다운로드(분개)</a></li>
							</ul>
					</div>
					<div class="semo"></div>
				</div>
			</div> -->		
				
			<select class="selectmenu" id="selViewLength"><!-- 공통코드 처리 필요 -->
				<option value="10">10<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
				<option value="20">20<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
				<option value="30">30<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
				<option value="40">40<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
				<option value="50">50<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option>
			</select>
		</div>
	</div>
	
	<!-- 테이블 -->
	<div class="com_ta2 bg_lightgray">
		<table id="tblReportExpendAdmList">
			<colgroup>
				<col width="40" /> 
				<col width="" />
				<col width="" />
				<col width="70" />
				<col width="100" />
				<col width="100" />
				<col width="100" />
				<col width="70" />
				<col width="" />
				<col width="120" />
				<col width="120" />
				<col width="120" />
				<col width="" />
				<col width="100" />
			</colgroup>
		</table>
	</div>
	<div id="loadingProgressBar"></div>
	
	
<div id="viewLoading" style="position: absolute; top: 0px; left: 0px; z-index: 9999; text-align: center; background: #ffffff; filter: alpha(opacity = 50); opacity: 0.5; display: none;">
		<iframe id="ifLoading" src="about:blank" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
		<div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 9999; text-align: center;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%;">
				<tr>
					<td style="height: 100%;">
						<img src='${pageContext.request.contextPath}/css/kendoui/Default/loading-image.gif' />
					</td>
				</tr>
			</table>
		</div>
	</div>
	

</div>