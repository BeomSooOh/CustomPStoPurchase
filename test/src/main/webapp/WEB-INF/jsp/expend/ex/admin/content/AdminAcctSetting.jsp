<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>

<script>

	/* 변수정의 */
	/* -------------------------------------------- */
	var erpTypeCode = '${ViewBag.erpTypeCode}';
	var lang = {};
	lang.TX000007261 = "<%=BizboxAMessage.getMessage("TX000007261", "삭제된 내용은 복구할 수 없습니다. 삭제를 진행하시겠습니까?")%>";
	lang.TX000009638 = "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>";
	lang.TX000002850 = "<%=BizboxAMessage.getMessage("TX000002850", "예")%>";
	lang.TX000006217 = "<%=BizboxAMessage.getMessage("TX000006217", "아니오")%>";
	lang.TX000000180 = "<%=BizboxAMessage.getMessage("TX000000180", "사용")%>";
	lang.TX000001243 = "<%=BizboxAMessage.getMessage("TX000018611", "미사용")%>";
	lang.TX000007098 = "<%=BizboxAMessage.getMessage("TX000007098", "계정과목 코드")%>";
	lang.TX000000400 = "<%=BizboxAMessage.getMessage("TX000018770", "계정과목명칭")%>";
	lang.TX000009617 = "<%=BizboxAMessage.getMessage("TX000018763", "부가세 계정과목 여부")%>";
	lang.TX000000028 = "${CL.ex_inUseYN}"; // 사용 여부
	

	/* 문서로드 */
	/* -------------------------------------------- */
	$(document).ready(function() {
		fnInit();
		fnInitEvent();
		fnSearch();
		return;
	});

	/* 초기화 */
	/* -------------------------------------------- */
	/* 초기화 */
	function fnInit() {
		$('button').kendoButton(); /* 켄도버튼정의 */
		exComboBox($('#selUsed'), JSON.parse('${ViewBag.ex00001}'), '');/* 사용 여부 */
		exComboBox($('#selVat'), JSON.parse('${ViewBag.ex00004}'), '');/* 부가세 계정과목 여부 */
		return;
	}

	/* 이벤트 초기화 */
	function fnInitEvent() {
		/* 버튼 이벤트 정의 */
		fnInitEventButton();
		return;
	}

	/* 이벤트 초기화 - Button */
	function fnInitEventButton() {
		if ('${ViewBag.erpTypeCode}' == 'BizboxA') {
			/* 조회 */
			$('#btnSearch').click(function() {
				fnSearch();
			});

			/* 신규 */
			$('#btnNew').click(function() {
				fnNew();
			});
			/* 저장 */
			$('#btnSave').click(function() {
				fnSave();
			});
			/* 삭제 */
			$('#btnDelete').click(function() {
				console.log('click');
				fnDelete();
			});
		} else {
			/* 조회 */
			$('#btnSearch').click(function() {
				alert('${ViewBag.erpTypeCode}' + "<%=BizboxAMessage.getMessage("TX000018752"," 사용의 경우에는 사용할 수 없는 기능입니다.")%>");
				return;
			});
			/* 신규 */
			$('#btnNew').click(function() {
				alert('${ViewBag.erpTypeCode}' + "<%=BizboxAMessage.getMessage("TX000018752"," 사용의 경우에는 사용할 수 없는 기능입니다.")%>");
				return;
			});
			/* 저장 */
			$('#btnSave').click(function() {
				alert('${ViewBag.erpTypeCode}' + "<%=BizboxAMessage.getMessage("TX000018752"," 사용의 경우에는 사용할 수 없는 기능입니다.")%>");
				return;
			});
			/* 삭제 */
			$('#btnDelete').click(function() {
				alert('${ViewBag.erpTypeCode}' + "<%=BizboxAMessage.getMessage("TX000018752"," 사용의 경우에는 사용할 수 없는 기능입니다.")%>");
				return;
			});
		}
	}

	/* 기능 */
	/* -------------------------------------------- */
	/* 기능 - 조회 */
	function fnSearch() {
		if ('${ViewBag.erpTypeCode}' == 'BizboxA') {
			/* parameter : compSeq, useYN, searchStr */
			var params = {};
			params.compSeq = '${ViewBag.empInfo.compSeq}' || '';
			params.searchStr = '' || '';

			$.ajax({
				type : 'post',
				url : '<c:url value="/ex/admin/ExAdminConfigAcctListInfoSelect.do" />',
				datatype : 'json',
				async : false,
				data : params,
				success : function(data) {
					if ((data.result.resultCode || '') != 'FAIL') {
						var aaData = (data.result.aaData || {});
						fnSetGrid(aaData);
					} else {
						alert("<%=BizboxAMessage.getMessage("TX000018753","조회 중 오류가 발생되었습니다.　지속적으로 발생될 경우 관리자에게 문의해 주세요.")%>");
					}

					$('#txtAcctCode').focus();
				}
			});
		} else {
			alert('${ViewBag.erpTypeCode}' + "<%=BizboxAMessage.getMessage("TX000018752"," 사용의 경우에는 사용할 수 없는 기능입니다.")%>");
		}
		return;
	}
	
	/* 기능 - 신규 */
	function fnNew() {
		/* 계정과목 코드 >> 변경 불가 */
		$('#txtAcctCode').val('');
		$('#txtAcctCode').removeAttr('disabled');
		/* 계정과목 명칭 */
		$('#txtAcctName').val('');
		/* 부가세 계정과목 여부 >> 변경 불가 */
		var vatCombobox = $("#selVat").data("kendoComboBox");
		vatCombobox.enable();
		vatCombobox.value('N');
		/* 사용 여부 */
		var usedCombobox = $("#selUsed").data("kendoComboBox");
		usedCombobox.value('Y');
		$('#txtAcctCode').focus();
		return;
	}
	
	/* 기능 - 저장 */
	function fnSave() {
		if ('${ViewBag.erpTypeCode}' == 'BizboxA') {
			if ($('#txtAcctCode').val() == '') {
				alert("<%=BizboxAMessage.getMessage("TX000018756","계정과목 코드는 필수 입력값 입니다.")%>");
				$('#txtAcctCode').focus();
				return;
			}
			if ($('#txtAcctName').val() == '') {
				alert("<%=BizboxAMessage.getMessage("TX000018757","계정과목 명칭은 필수 입력값 입니다.")%>");
				$('#txtAcctCode').focus();
				return;
			}

			var params = {};
			params.compSeq = '${ViewBag.empInfo.compSeq}' || '';
			params.acctCode = $('#txtAcctCode').val() || '';
			params.acctName = $('#txtAcctName').val() || '';
			var vatCombobox = $("#selVat").data("kendoComboBox");
			params.vatYN = vatCombobox.value() || 'Y';
			var usedCombobox = $("#selUsed").data("kendoComboBox");
			params.useYN = usedCombobox.value() || 'N';

			$.ajax({
				type : 'post',
				url : '<c:url value="/ex/admin/ExAdminConfigAcctInfoInsert.do" />',
				datatype : 'json',
				async : false,
				data : params,
				success : function(data) {
					if ((data.result.resultCode || '') != 'FAIL') {
						fnSearch();
						fnNew();
					} else {
						alert("<%=BizboxAMessage.getMessage("TX000018758","저장 중 오류가 발생되었습니다.　지속적으로 발생될 경우 관리자에게 문의해 주세요.")%>");
					}
				}
			});
		} else {
			alert('${ViewBag.erpTypeCode}' + "<%=BizboxAMessage.getMessage("TX000018752"," 사용의 경우에는 사용할 수 없는 기능입니다.")%>");
		}
		return;
	}
	
	/* 기능 - 삭제 */
	function fnDelete() {
		console.log();

		if ('${ViewBag.erpTypeCode}' == 'BizboxA') {
			if ($('#txtAcctCode').val() == '') {
				alert("<%=BizboxAMessage.getMessage("TX000018759","삭제를 진행할 계정과목이 선택되지 않았습니다.")%>");
				$('#txtAcctCode').focus();
				return;
			}

			if (!confirm("<%=BizboxAMessage.getMessage("TX000018761","삭제시 기존 작성된 문서가 영향을 받을 수 있습니다.　삭제를 진행하시겠습니까?")%>")) {
				return;
			}

			var params = {};
			params.compSeq = '${ViewBag.empInfo.compSeq}' || '';
			params.acctCode = $('#txtAcctCode').val() || '';

			$.ajax({
				type : 'post',
				url : '<c:url value="/ex/admin/ExAdminConfigAcctInfoDelete.do" />',
				datatype : 'json',
				async : false,
				data : params,
				success : function(data) {
					if ((data.result.resultCode || '') != 'FAIL') {
						fnSearch();
						fnNew();
					} else {
						alert("<%=BizboxAMessage.getMessage("TX000018762","삭제 중 오류가 발생되었습니다.　지속적으로 발생될 경우 관리자에게 문의해 주세요.")%>");
					}
				}
			});
		} else {
			alert('${ViewBag.erpTypeCode}' + "<%=BizboxAMessage.getMessage("TX000018752"," 사용의 경우에는 사용할 수 없는 기능입니다.")%>");
		}
		return;
	}

	/* Layout */
	/* -------------------------------------------- */
	/* Layout - 그리드 설정 */
	function fnSetGrid(aaData) {
		aaData = aaData || {};

		$('#tblGridList').dataTable({
			select : true,
			bAutoWidth : false,
			destroy : true,
			lengthMenu : [ [ 10, 15, 20, -1 ], [ 10, 15, 20, "All" ] ],
			language : {
				lengthMenu : "보기 _MENU_",
				zeroRecords : "데이터가 없습니다.",
				info : "_PAGE_ / _PAGES_",
				infoEmpty : "데이터가 없습니다.",
				infoFiltered : "(전체 _MAX_ 중.)"
			},
			data : aaData,
			fnRowCallback : function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
				$(nRow).css("cursor", "pointer");
				$(nRow).on('click', (function() {
					fnSetInput(aData);
					return;
				}));
			},
			columnDefs : [],
			aoColumns : [ {
				"sTitle" : "계정과목 코드",
				"mData" : "acctCode",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : ""
			}, {
				"sTitle" : "계정과목 명칭",
				"mData" : "acctName",
				"bVisible" : true,
				"bSortable" : true,
				"sClass" : "le",
				"sWidth" : ""
			}, {
				"sTitle" : "부가세 계정과목 여부",
				"mData" : "vatYN",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : ""
			}, {
				"sTitle" : "사용 여부",
				"mData" : "useYN",
				"bVisible" : true,
				"bSortable" : true,
				"sWidth" : ""
			} ]
		});
	}

	/* Layout - 입력 설정 */
	function fnSetInput(aData) {
		/* 계정과목 코드 >> 변경 불가 */
		$('#txtAcctCode').val(aData.acctCode || '');
		$('#txtAcctCode').attr('disabled', 'disabled');
		/* 계정과목 명칭 */
		$('#txtAcctName').val(aData.acctName || '');
		/* 부가세 계정과목 여부 >> 변경 불가 */
		var vatCombobox = $("#selVat").data("kendoComboBox");
		vatCombobox.enable(false);
		vatCombobox.value(aData.vatYN || '');
		/* 사용 여부 */
		var usedCombobox = $("#selUsed").data("kendoComboBox");
		usedCombobox.value(aData.useYN || '');
	}
</script>

<div class="sub_contents_wrap">

	<!-- 컨트롤박스 -->
	<div id="" class="controll_btn">
		<button id="btnSearch" class="k-button"><%=BizboxAMessage.getMessage( "TX000000899", "조회" )%></button>
		<button id="btnNew" class="k-button"><%=BizboxAMessage.getMessage( "TX000003101", "신규" )%></button>
		<button id="btnSave" class="k-button">${CL.ex_save}</button><!-- 저장 -->
		<button id="btnDelete" class="k-button"><%=BizboxAMessage.getMessage( "TX000000424", "삭제" )%></button>
	</div>

	<div id="divConfigAcctList" class="com_ta2">
		<table id="tblGridList"></table>
	</div>

	<div class="com_ta mt20">
		<table>
			<colgroup>
				<col width="160" />
				<col width="" />
				<col width="160" />
				<col width="" />
				<col width="160" />
				<col width="" />
				<col width="160" />
				<col width="" />
			</colgroup>
			<tr>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage( "TX000007098", "계정과목코드" )%></th>
				<td><input type="text" style="width: 90%" id="txtAcctCode" /></td>
				<th><img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> <%=BizboxAMessage.getMessage( "TX000018770", "계정과목명칭" )%></th>
				<td><input type="text" style="width: 90%" id="txtAcctName" /></td>
				<th><%=BizboxAMessage.getMessage( "TX000018763", "부가세 계정과목 여부" )%></th>
				<td><input id="selVat" style="width: 90%" /></td>
				<th>${CL.ex_inUseYN}</th><!-- 사용여부 -->
				<td><input id="selUsed" style="width: 90%" /></td>
			</tr>
		</table>

	</div>
</div>
<!-- //sub_contents_wrap -->