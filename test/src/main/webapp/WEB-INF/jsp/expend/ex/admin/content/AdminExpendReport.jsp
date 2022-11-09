<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- javascript - src -->
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>

<!-- javascript -->
<script>
	/* UserExpendReport var */

	/* document.ready */
	$(document).ready(function() {
		<c:if test="${ViewBag.empInfo.groupSeq == 'dev'}"> /* 개발버전인 경우 */
		debug = true;
		/* $('#btnDebugViewVar').show(); */
		/* setClick($('#btnDebugViewVar'), showLog); */
		</c:if>

		log('+ [UserExpendReport] (document).ready');
		fnUserExpendReportInit();
		fnUserExpendReportEventInit();
		$('#btnSearch').click();
		
		alert('서비스 준비중입니다.');
		log('- [UserExpendReport] (document).ready');
	});

	/* fnUserExpendReportInit */
	function fnUserExpendReportInit() {
		log('+ [UserExpendReport] fnUserExpendReportInit');
		fnUserExpendReportInitLayout();
		fnUserExpendReportInitDatepicker();
		fnUserExpendReportInitInput();
		fnUserExpendReportInitButton();
		log('- [UserExpendReport] fnUserExpendReportInit');
	}
	/* fnUserExpendReportInit - Layout */
	function fnUserExpendReportInitLayout() {
		log('+ [UserExpendReport] fnUserExpendReportInitLayout');
		log('- [UserExpendReport] fnUserExpendReportInitLayout');
	}
	/* fnUserExpendReportInit - Datepicker */
	function fnUserExpendReportInitDatepicker() {
		log('+ [UserExpendReport] fnUserExpendReportInitDatepicker');
		/* class="datepicker" datepicker 정의 */
		setDatePicker($('.datepicker'));
		$('#txtReqDate').val(''); /* 지급요청일자는 기본값이 아니므로, 사용자 선택 사항 */
		$('#txtFromDate').val('2016-01-01');
		log('- [UserExpendReport] fnUserExpendReportInitDatepicker');
	}
	/* fnUserExpendReportInit - Input */
	function fnUserExpendReportInitInput() {
		log('+ [UserExpendReport] fnUserExpendReportInitInput');
		log('- [UserExpendReport] fnUserExpendReportInitInput');
	}
	/* fnUserExpendReportInit - Button */
	function fnUserExpendReportInitButton() {
		log('+ [UserExpendReport] fnUserExpendReportInitButton');
		log('- [UserExpendReport] fnUserExpendReportInitButton');
	}

	/* fnUserExpendReportEventInit */
	function fnUserExpendReportEventInit() {
		log('+ [UserExpendReport] fnUserExpendReportEventInit');
		fnUserExpendReportEventInitButton();
		fnUserExpendReportEventInitInput();
		log('- [UserExpendReport] fnUserExpendReportEventInit');
	}
	/* fnUserExpendReportEventInit - Button */
	function fnUserExpendReportEventInitButton() {
		log('+ [UserExpendReport] fnUserExpendReportEventInitButton');
		setClick($(eventTarget.search), function() {
			fnUserExpendReportSearch();
		});
		log('- [UserExpendReport] fnUserExpendReportEventInitButton');
	}
	/* fnUserExpendReportEventInit - Input */
	function fnUserExpendReportEventInitInput() {
		log('+ [UserExpendReport] fnUserExpendReportEventInitInput');
		log('- [UserExpendReport] fnUserExpendReportEventInitInput');
	}

	/* function */
	/* function -fnUserExpendReportSearch */
	function fnUserExpendReportSearch() {
		var result = ajax({
			url : "/ex/report/ExReportExpendAdmListInfoSelect.do",
			async : false,
			parameter : {
				fromDate : ($('#txtFromDate').val().toString().replace(/-/g, '') || ''), /* 결의(회계)일자 */
				toDate : ($('#txtToDate').val().toString().replace(/-/g, '') || ''), /* 결의(회계)일자 */
				reqDate : ($('#txtReqDate').val().toString().replace(/-/g, '') || ''), /* 지급요청일 */
				docNo : ($('#txtDocNo').val().toString().replace(/-/g, '') || ''), /* 문서번호 */
				docTitle : ($('#txtDocTitle').val().toString().replace(/-/g, '') || '')
			}
		});

		var columnDefs = [ {
			"targets" : 0,
			"data" : null,
			"render" : function(data) {
				return "<input type='checkbox' name='inp_chk' id='inp_chk1' class='k-checkbox'><label class='k-checkbox-label bdChk' for='inp_chk1'></label>";
			}
		}, {
			"targets" : 1,
			"data" : null,
			"render" : function(data) {
				return '<a href="javascript:;" onClick="javascript: fnAppdocPop(' + "'" + data.docSeq + "', '" + data.formSeq + "'" + ')">[' + data.docNo + ']</a>';
			}
		}, {
			"targets" : 3,
			"data" : null,
			"render" : function(data) {
				return data.expendDate.toString().replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3');
			}
		}, {
			"targets" : 4,
			"data" : null,
			"render" : function(data) {
				return data.expendReqDate.toString().replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3');
			}
		}, {
			"targets" : 5,
			"data" : null,
			"render" : function(data) {
				return '-';
			}
		}, {
			"targets" : 6,
			"data" : null,
			"render" : function(data) {
				var result = '';
				if (data.docSts == '90') {
					result += '종결';
				} else if (data.docSts == '100') {
					result += '반려';
				} else if (data.docSts == '10') {
					result += '보관';
				} else {
					result += '진행';
				}
				return result;
			}
		}, {
			"targets" : 7,
			"data" : null,
			"render" : function(data) {
				return '<a href="javascript:;" onClick="javascript: fnPrintPop(' + "'" + data.expendSeq + "'" + ')">[인쇄]</a>';
			}
		}, {
			"targets" : 8,
			"data" : null,
			"render" : function(data) {
				if (data.reqYN == '') {
					return '-';
				} else {
					return '-';
				}
			}
		} ];
		var columns = [ {
			"sTitle" : "<input type='checkbox' name='checkAll' class='check2' onClick='javascript:fnCheckAll();' title='전체선택' id='checkAll' />",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : "40px"
		}, {
			"sTitle" : "문서번호",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		}, {
			"sTitle" : "제목",
			"mData" : "docTitle",
			"bVisible" : true,
			"bSortable" : false,
			"sClass" : "le",
			"sWidth" : ""
		}, {
			"sTitle" : "기안일자",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		}, {
			"sTitle" : "지급요청일",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		}, {
			"sTitle" : "결의금액",
			"bVisible" : true,
			"bSortable" : false,
			"sClass" : "ri",
			"sWidth" : ""
		}, {
			"sTitle" : "상태",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		}, {
			"sTitle" : "증빙서식",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		}, {
			"sTitle" : "지급처리",
			"bVisible" : true,
			"bSortable" : false,
			"sWidth" : ""
		} ];

		setTableCust($('#tblExpendUserReport'), columnDefs, columns, result.aaData, '20');
	}

	/* function - fnPrintPop */
	function fnPrintPop(expendSeq) {
		alert('서비스 준비중입니다.');
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

		var url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq + "&form_id=" + formSeq + "&doc_auth=1";
		window.open(url, 'AppDoc', 'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
	}
</script>

<!-- hidden -->

<!-- body -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_resExDate} <!--결의(회계)일자--></dt>
			<dd>
				<input id="txtFromDate" value="" class="dpWid datepicker" /> ~ <input
					id="txtToDate" value="" class="dpWid datepicker" />
			</dd>
			<dt>${CL.ex_paymentDate} <!--지급요청일--></dt>
			<dd>
				<input id="txtReqDate" value="" class="dpWid datepicker" />
			</dd>
			<dd>
				<input type="button" id="btnSearch" value="${CL.ex_search} " /><!--검색-->
			</dd>
		</dl>
		<span class="btn_Detail">${CL.ex_detailSearch} <!--상세검색--> <img id="all_menu_btn"
			src='../../../Images/ico/ico_btn_arr_down01.png' /></span>
	</div>
	<!-- 상세검색박스 -->
	<div class="SearchDetail">
		<dl>
			<dt style="width: 60px;">${CL.ex_docNm} <!--문서번호--></dt>
			<dd class="mr5">
				<input id="txtDocNo" type="text" value="" style="width: 300px">
			</dd>
			<dt style="width: 60px;">${CL.ex_title} <!--제목--></dt>
			<dd class="mr5">
				<input id="txtDocTitle" type="text" value="" style="width: 300px">
			</dd>
		</dl>
	</div>
	

	<!-- 테이블 -->
	<div class="com_ta2">
		<table id="tblExpendUserReport">
			<colgroup>
				<col width="40" />
				<col width="15%" />
				<col width="25%" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
				<col width="" />
			</colgroup>
		</table>
	</div>
</div>
<!-- //sub_contents_wrap -->
