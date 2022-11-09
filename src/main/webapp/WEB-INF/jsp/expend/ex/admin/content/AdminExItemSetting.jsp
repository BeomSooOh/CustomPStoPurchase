<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/jquery.tablednd.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>

<script>

	/* 변수정의 */
	/* -------------------------------------------- */
	var orgItems = {
		"selectN" : [],
		"selectY" : []
	};
	var items = {
		"selectN" : [],
		"selectY" : []
	};
	var erpTypeCode = '${ViewBag.erpTypeCode}';

	/* 문서로드 */
	/* -------------------------------------------- */
	$(document).ready(function() {
		fnInit();
		fnInitEvent();
		fnSearch();
		// fnReg();

	});

	/* 초기화 */
	/* -------------------------------------------- */
	//초기화
	function fnInit() {
		$('button').kendoButton(); /* 켄도버튼정의 */
		$("#tabstrip").kendoTabStrip({
			animation : {
				open : {
					effects : ""
				}
			}
		}); /* tabstrip */

		$('#flip-navigation li a').each(function() {
			$(this).click(function() {
				$('#flip-navigation li').removeClass('k-state-active');
				$(this).parent().addClass('k-state-active');
				var flipid = $(this).attr('id').substr(4);
				if (flipid == 0) { //전표
					// $("#hdnDataSelectGrid").val("");
					// $("#hdnDataAddGrid").val("");
					// $("#hdnAddItemList").val("");
					// $("#hdnSelectItemList").val("");
					// $("#divListPreview").css("display", "none");
					// $("#divSlipPreview").css("display", "none");
				} else if (flipid == 1) { //분개
					// $("#hdnDataSelectGrid").val("");
					// $("#hdnDataAddGrid").val("");
					// $("#hdnAddItemList").val("");
					// $("#hdnSelectItemList").val("");
					// $("#divListPreview").css("display", "none");
					// $("#divSlipPreview").css("display", "");
					// $("#divListPreview").css("display", "none");
					// $("#divSlipPreview").css("display", "none");
				} else { //잘못된 플립 선택(에러)
					// $("#hdnDataSelectGrid").val("");
					// $("#hdnDataAddGrid").val("");
					// $("#divListPreview").css("display", "none");
					// $("#divSlipPreview").css("display", "none");
				}
				
				fnSetGrid();
				// fnGetItemInfo();
				// fnMoveChkBox();
				return;
			});
		});

		var formInfo = ('${ViewBag.formInfo}' === '' ? [] : ${ViewBag.formInfo});
		$("#selForm").empty();
		$.each(formInfo, function(idx, item) {
			$("#selForm").append("<option value='" + item.formSeq + "'>" + item.formName + "</option>");
		});
		$("#selForm").selectmenu({change: function(){
			fnSearch();
		}});
		
		if(formInfo.length > 0){
			$("#selForm").val(formInfo[0].formSeq).selectmenu('refresh');
		}
		return;
	}

	/* 이벤트 */
	function fnInitEvent() {
		/* 초기화 */
		$('#btnReset').click(function() {
			fnReset();
		});
		/* 저장 */
		$('#btnSave').click(function() {
			fnSave();
		});
		/* 미리보기 */
		$('#btnPreview').click(function() {
			fnPreview();
		});
		/* 추가내역 이동 */
		$('#btnAddItem').click(function() {
			fnMove('ADD');
		});
		/* 추가내역 삭제 */
		$('#btnDeleteItem').click(function() {
			fnMove('');
		});
		/* 정렬순서 위로 */
		$('#btnItemUp').click(function() {
			fnSort('UP');
		});
		/* 정렬순서 아래로 */
		$('#btnItemDown').click(function() {
			fnSort('');
		});
		/* 페이징시 정렬 초기화 */
		$('#flip-navigation li a').click(function(){
			items.selectY = [];
			$.each(orgItems.selectY, function(idx, item) {
				items.selectY.push(item);
			});
			items.selectY = setOrder(items.selectY);

			items.selectN = [];
			$.each(orgItems.selectN, function(idx, item) {
				items.selectN.push(item);
			});
			items.selectN = setOrder(items.selectN, items.selectY.length);

			fnSetGrid();
		});
		return;
	}

	/* 기능 */
	/* -------------------------------------------- */
	/* 기능 - 조회 */
	function fnSearch() {
		var params = {};
		params.compSeq = '${ViewBag.empInfo.compSeq}' || '';
		params.formSeq = $("#selForm").val() || '0';
		params.itemGbn = 'CODEALL';

		$.ajax({
			type : 'post',
			url : '<c:url value="/ex/admin/ExAdminConfigItemListInfoSelect.do" />',
			datatype : 'json',
			async : false,
			data : params,
			success : function(data) {
				if ((data.result.resultCode || '') != 'FAIL') {
					var aaData = (data.result.aaData || {});
					items.selectY = [];
					items.selectN = [];
					orgItems.selectY= [];
					orgItems.selectN= [];
					$.each(aaData, function(idx, item) {
						if ((item.selectYN || 'N') == 'Y') {
							if(JSON.stringify(items.selectY).indexOf(JSON.stringify(item)) < 0) {
								items.selectY.push(item);
							}
							
							if(JSON.stringify(orgItems.selectY).indexOf(JSON.stringify(item)) < 0) {
								orgItems.selectY.push(item);
							}
						} else if ((item.selectYN || 'N') == 'N') {
							if (item.headCode){
								if(JSON.stringify(items.selectN).indexOf(JSON.stringify(item)) < 0) {
									items.selectN.push(item);
								}
								
								if(JSON.stringify(orgItems.selectN).indexOf(JSON.stringify(item)) < 0) {
									orgItems.selectN.push(item);
								}
							}
						}
					});

					fnSetGrid();
				} else {
					alert("<%=BizboxAMessage.getMessage("TX000018744","조회 중 오류가 발생되었습니다.　지속적으로 발생될 경우 관리자에게 문의해 주세요.")%>");
				}
			}
		});

		return;
	}

	/* 기능 - 초기화 */
	function fnReset() {
		if (!confirm("<%=BizboxAMessage.getMessage("TX000018745","처음 조회 시점으로 설정이 복원됩니다.　진행하시겠습니까?")%>")) {
			return;
		}

		items.selectY = [];
		$.each(orgItems.selectY, function(idx, item) {
			items.selectY.push(item);
		});
		items.selectY = setOrder(items.selectY);

		items.selectN = [];
		$.each(orgItems.selectN, function(idx, item) {
			items.selectN.push(item);
		});
		items.selectN = setOrder(items.selectN, items.selectY.length);

		fnSetGrid();
		return;
	}

	/* 기능 - 저장 */
	function fnSave() {
		
		var params = {};
		params.compSeq = ('${ViewBag.empInfo.compSeq}' || '');
		params.formSeq = $("#selForm").val() || '0';
		params.items = [];
		$.each(items.selectN, function(idx, item){ params.items.push(item); });
		$.each(items.selectY, function(idx, item){ params.items.push(item); });
		params.items = JSON.stringify(params.items);
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/ex/admin/ExAdminConfigItemListInfoInsert.do" />',
			datatype : 'json',
			data : params,
			async : true,
			success : function(data) {
				if ((data.result.resultCode || '') != 'FAIL') {
					fnSearch();
					alert("<%=BizboxAMessage.getMessage("TX000002073", "저장되었습니다.")%>");
				} else {
					alert('저장 중 오류가 발생되었습니다.　지속적으로 발생될 경우 관리자에게 문의해 주세요.')
					fnSetGrid();
				}
			},
			error : function(result) {
				alert("<%=BizboxAMessage.getMessage("TX000009616", "데이터 불러오기 도중 작업을 실패하였습니다")%>");
			}
		});
		return;
	}

	/* 기능 - 미리보기 */
	function fnPreview() {
		return;
	}

	/* 기능 - 추가내역으로 이동 */
	function fnMove(action) {
		action = (action || '');
		var source = ( action == 'ADD' ) ? items.selectN : items.selectY;
		var target = ( action == 'ADD' ) ? items.selectY : items.selectN;
		var empty = [];
		
		var chkSels = $("input[name=" + (action == 'ADD' ? "chkDeleteItem" : "chkAddItem") + "]:checkbox:visible").map(function() {
			return this.value + '_' + $(this).prop('checked');
		}).get();
		
		
		$.each( source , function(idx, item) {
			$.each(chkSels, function(chkIdx, chkItem) {
				var key = [];
				key.push(item.compSeq);
				key.push(item.formSeq);
				key.push(item.itemGbn);
				key.push(item.langpackCode);
				
				
				if (key.join('|') + '_true' == chkItem) {
					item.selectYN = (action == 'ADD' ? 'Y' : 'N');
					target.push(item);
				}else if(key.join('|') + '_false' == chkItem) {
					empty.push(item);
				}
			});
		});
		
		if(action == 'ADD'){
			items.selectN = empty;
		}else{
			items.selectY = empty;
		}
		items.selectY = setOrder(items.selectY);
		items.selectN = setOrder(items.selectN , items.selectY.length);
		
		var itemsSelectY = [];
		$.each(items.selectY, function(idx, item) {
			if(JSON.stringify(itemsSelectY).indexOf(JSON.stringify(item)) < 0) {
				itemsSelectY.push(item);
			}
		});
		
		items.selectY = itemsSelectY;
		
		var itemsSelectN = [];
		$.each(items.selectN, function(idx, item) {
			if(JSON.stringify(itemsSelectN).indexOf(JSON.stringify(item)) < 0) {
				itemsSelectN.push(item);
			}
		});
		
		items.selectN = itemsSelectN;
		
		fnSetGrid();
		$.each(chkSels, function(idx, item) {
			$('#' + (action == 'ADD' ? "chkAddItem_" : "chkDeleteItem_") + item.replace(/\|/g, '_')).prop('checked', 'checked');
		});
	}

	function fnSort(action) {
		action = (action || '');
		var chkSels = $("input[name=" + (action == 'ADD' ? "chkDeleteItem" : "chkAddItem") + "]:checkbox:checked").map(function(idx) {
			return this.value;
		}).get();
		var source = items.selectY;
		chkSels = (action == 'UP' ? chkSels : chkSels.reverse());
		var ingFlag = true;

		$.each(chkSels, function(chkIdx, chkItem) {
			var key = [];
			key.push(source[(action == 'UP' ? 1 : source.length - 1)].compSeq);
			key.push(source[(action == 'UP' ? 1 : source.length - 1)].formSeq);
			key.push(source[(action == 'UP' ? 1 : source.length - 1)].itemGbn);
			key.push(source[(action == 'UP' ? 1 : source.length - 1)].langpackCode);
			if (key.join('|') == chkItem) {
				ingFlag = false;
			}
		});

		if (ingFlag) {
			$.each(chkSels, function(chkIdx, chkItem) {
				$.each(source, function(idx, item) {
					
					var key = [];
					key.push(item.compSeq);
					key.push(item.formSeq);
					key.push(item.itemGbn);
					key.push(item.langpackCode);
					
					

					if (key.join('|') == chkItem) {
						if (idx != (action == 'UP' ? 0 : source.length - 1)) {
							source[(action == 'UP' ? idx - 1 : idx + 1)].orderNum = Number(item.orderNum);
							item.orderNum = (action == 'UP' ? Number(item.orderNum) - 1 : Number(item.orderNum) + 1);
						}
					}
				});

				source = setOrder(source);
			});

			items.selectY = setOrder(source);

			fnSetGrid();
			$.each(chkSels, function(idx, item) {
				$("#chkAddItem_" + item.replace(/\|/g, '_')).prop('checked', 'checked');
			});
		} else {
			if (action == 'UP') {
				alert("<%=BizboxAMessage.getMessage("TX000018748", "첫행은 이동할 수 없습니다.")%>");
			} else {
				alert("<%=BizboxAMessage.getMessage("TX000018750", "마지막행은 이동할 수 없습니다.")%>");
			}
		}
	}

	function distinctArr(source){
		var returnList = [];
		var length = source.length;
		for(var i=0; i <length ; i++){
			var item = source[i];
			var keyString = '"headCode":"'+item.headCode+'"';
			
			if(JSON.stringify(returnList).indexOf(keyString) == -1){
				returnList.push(item);
			}
		}
		return returnList;
	}
	
	function setOrder(source, addIdx) {
		addIdx = (addIdx || 0);
		var prop = 'orderNum';
		var asc = true;

		source = source.sort(function(a, b) {
			if (asc) {
				return (a[prop] > b[prop]) ? 1 : ((a[prop] < b[prop]) ? -1 : 0);
			} else {
				return (b[prop] > a[prop]) ? 1 : ((b[prop] < a[prop]) ? -1 : 0);
			}
		});

		$.each(source, function(idx, item) {
			if ((item.orderNum || '') != '') {
				item.orderNum = idx + addIdx;
			}
		});

		return source;
	}

	/* Layout */
	/* -------------------------------------------- */
	/* Layout - 그리드 설정 */
	function fnSetGrid() {
		var aaDataSelectN = [];
		$.each(items.selectN, function(idx, item){
			if(item.itemGbn == ($(".k-state-active a").attr("title")).toString()){
				aaDataSelectN.push(item);
			}
			if(item.itemGbn == 'ALL'){
				aaDataSelectN.push(item);
			}
		});
		var aaDataSelectY = [];
		$.each(items.selectY, function(idx, item){
			if(item.itemGbn == ($(".k-state-active a").attr("title")).toString()){
				aaDataSelectY.push(item);
			}
			if(item.itemGbn == 'ALL'){
				aaDataSelectY.push(item);
			}
		});
				
		fnSetGridSelectN(aaDataSelectN || {});
		fnSetGridSelectY(aaDataSelectY || {});
		return;
	}

	/* Layout - 그리드 설정 - 선택항목 */
	function fnSetGridSelectN(aaData) {
		aaData = aaData || {};
		
		$('#tblGridListSelectY').dataTable({
			select : true,
			paging : false,
			bAutoWidth : false,
			destroy : true,
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
					var target = $('#tblGridListSelectY tr:eq(' + (Number(iDisplayIndex) + 1) + ') td:eq(0)').find('input');
					var checked = $(target).is(':checked');
					if($(target).attr('disabled') != 'disabled') {
						$(target).prop('checked', !checked);
					}
					return;
				}));
			},
			columnDefs : [ {
				"targets" : 0,
				"data" : null,
				"render" : function(aData, data, type, meta, row) {
					var info = '';
					info += aData.compSeq;
					info += '|' + aData.formSeq;
					info += '|' + aData.itemGbn;
					info += '|' + aData.langpackCode;
					return '<input type="checkbox" name="chkDeleteItem" id="chkDeleteItem_' + info.replace(/\|/g, '_') + '" value="' + info + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="chkDeleteItem_' + info.replace(/\|/g, '_') + '"></label>';
				}
			} ],
			aoColumns : [ {
				"sTitle" : "<input type='checkbox' id='chkDeleteItem' name='chkDeleteItem' onclick='fnChk(this.id)' class='k-checkbox'/><label class='k-checkbox-label bdChk' for='chkDeleteItem'></label>",
				"bSearchable" : false,
				"bSortable" : false,
				"sWidth" : "5",
				"sClass" : "center"
			}, {
				"sTitle" : "${CL.ex_item}",
				"mData" : "langpackName",
				"bVisible" : true,
				"bSortable" : false,
				"sClass" : "le",
				"sWidth" : ""
			} ]
		});
	}
	/* Layout - 그리드 설정 - 추가내역 */
	function fnSetGridSelectY(aaData) {
		aaData = aaData || {};

		$('#tblGridListSelectN').dataTable({
			select : true,
			paging : false,
			bAutoWidth : false,
			destroy : true,
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
					var target = $('#tblGridListSelectN tr:eq(' + (Number(iDisplayIndex) + 1) + ') td:eq(0)').find('input');
					var checked = $(target).is(':checked');
					if($(target).attr('disabled') != 'disabled') {
						$(target).prop('checked', !checked);
					}
					return;
				}));
			},
			columnDefs : [ {
				"targets" : 0,
				"data" : null,
				"render" : function(aData, data, type, meta, row) {
					var info = '';
					info += aData.compSeq;
					info += '|' + aData.formSeq;
					info += '|' + aData.itemGbn;
					info += '|' + aData.langpackCode;
					return '<input type="checkbox" name="chkAddItem" id="chkAddItem_' + info.replace(/\|/g, '_') + '" value="' + info + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="chkAddItem_' + info.replace(/\|/g, '_') + '"></label>';
				},
			} ],
			aoColumns : [ {
				"sTitle" : "<input type='checkbox' id='chkAddItem' name='chkAddItem' onclick='fnChk(this.id)' class='k-checkbox'/><label class='k-checkbox-label bdChk' for='chkAddItem'></label>",
				"bSearchable" : false,
				"bSortable" : false,
				"sWidth" : "5",
				"sClass" : "center"
			}, {
				"sTitle" : "${CL.ex_item}",
				"mData" : "langpackName",
				"bVisible" : true,
				"bSortable" : false,
				"sClass" : "le",
				"sWidth" : ""
			} ]
		});

		$.each($('input[name=chkAddItem]'), function(idx, target) {
			if (idx == 1) {
				$(target).attr('disabled', 'disabled');
				return false;
			}
		});
	}
	
	function fnChk(tableType){
		var checked = $('#' + tableType).is(':checked');
		if(tableType === 'chkAddItem'){
			$("#tblGridListSelectN input[type=checkbox]").each(function() {
				if($(this).attr('disabled') != 'disabled') {
					$(this).prop('checked', checked);
				}
			});
		}else{
			$("#tblGridListSelectY input[type=checkbox]").each(function() {
				if($(this).attr('disabled') != 'disabled') {
					$(this).prop('checked', checked);
				}
			});
		}
	}
</script>
</head>
<div class="sub_contents_wrap">

	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_form} <!--양식--></dt>
			<dd>
				<select id="selForm" class="selectmenu" style="width: 200px;">
				</select>
			</dd>
		</dl>
	</div>

	<div id="" class="controll_btn">
		<button id="btnReset" class="k-button"><%=BizboxAMessage.getMessage( "TX000002960", "초기화" )%></button>
		<button id="btnSave" class="k-button">${CL.ex_save}</button><%-- ${CL.ex_save} <!--저장--> --%>
	</div>

	<div class="tab_page">
		<div class="tab_style" id="tabstrip">
			<ul id="flip-navigation" class="mb20">
				<li class="k-state-active" title='EX2002001'><a href="javascript:;" id="tab-0" title="EX2002001"><%=BizboxAMessage.getMessage( "TX000007461", "전표정보" )%></a></li>
				<li title='EX2002002'><a href="javascript:;" id="tab-1" title="EX2002002">${CL.ex_journalInformation}</a></li><!-- 분개정보 -->
			</ul>
		</div>
		<div class="tab1">

			<div class="fl" style="width: 47%;">
				<div class="btn_div mt0">
					<div class="left_div">
						<h5><%=BizboxAMessage.getMessage( "TX000009569", "선택항목" )%></h5>
					</div>
				</div>
				<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
					<table id='tblGridListSelectY'>
						<colgroup>
							<col width="50" />
							<col width="" />
						</colgroup>
					</table>
				</div>
			</div>

			<div class="fl t_trans_tool" style="width: 6%; height: 490px;">
				<ul>
					<li><a id="btnAddItem" href="javascript:;"><img src="<c:url value='/Images/btn/btn_arr01.png'/>" alt=""></a></li>
					<li><a id="btnDeleteItem" href="javascript:;"><img src="<c:url value='/Images/btn/btn_arr02.png'/>" alt=""></a></li>
				</ul>
			</div>

			<div class="fr" style="width: 47%;">
				<!-- 컨트롤버튼영역 -->
				<div class="btn_div mt0">
					<div class="left_div">
						<h5><%=BizboxAMessage.getMessage( "TX000009568", "추가내역" )%></h5>
					</div>
					<div class="updo_div fl mr20">
						<a id="btnItemUp" href="javascript:;" class="up"><img src="<c:url value='/Images/ico/ico_order_up01.png'/>" alt="" /></a> <a id="btnItemDown" href="javascript:;" class="down"><img src="<c:url value='/Images/ico/ico_order_down01.png'/>" alt="" /></a>
					</div>
					<div class="controll_btn fr p0">
						<button id="btnPreview" class="k-button"" style="display:none;"><%=BizboxAMessage.getMessage( "TX000003080", "미리보기" )%></button>
					</div>
				</div>

				<div class="com_ta4 bgtable3 ova_sc sel_ta1" style="height: 408px">
					<table id="tblGridListSelectN">
						<colgroup>
							<col width="50" />
							<col width="" />
						</colgroup>
					</table>
				</div>


			</div>


			<div id="divListPreview" style="display: none; width: 99%; margin-left: 0px;">
				<div class="cl mt10">
					<p style="margin-bottom: 8px;"><%=BizboxAMessage.getMessage( "TX000007461", "전표정보" )%></p>
				</div>
				<div class="com_ta4" style="width: 100%; background: #f5f5f5;">
					<table border="0" id="DataTableListInfoGrid" cellpadding="0" cellspacing="0" class="display" width="100%">
					</table>
				</div>
			</div>
			<div id="divSlipPreview" style="display: none; width: 99%; margin-left: 0px;">
				<div class="cl mt10">
					<pstyle="margin-bottom: 8px;"> ${CL.ex_journalInformation}<!-- 분개정보 -->
					</p>
				</div>
				<div class="com_ta4" style="width: 100%; background: #f5f5f5;">
					<table border="0" id="DataTableSlipInfoGrid" cellpadding="0" cellspacing="0" class="display" width="100%"></table>
				</div>
			</div>
		</div>
		<!--// tab_style -->
	</div>
</div>
<input type="hidden" id="hdnAddItemList" />
<input type="hidden" id="hdnSelectItemList" />
<input type="hidden" id="hdnCheckItemList" />


