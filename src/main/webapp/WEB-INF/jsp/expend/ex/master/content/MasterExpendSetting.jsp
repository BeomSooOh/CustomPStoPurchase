<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>

<script>
	/* 변수정의 */
	var ifSystem = '${ViewBag.ifSystem}';
	var searchCompSeq = '';
	var mainOptionData = null;
	// 지출결의 옵션 정보 저장
	var expendOption = [];

	/* 문서로드 */
	$(document).ready(function() {
		fnConfigExpendSettingInit();
		fnConfigExpendSettingInitEvent();
	});

	/* 초기화 */
	function fnConfigExpendSettingInit() {
		fnConfigExpendSettingInitLayout();
		fnConfigExpendSettingInitDatepicker();
		fnConfigExpendSettingInitInput();
		return;
	}

	/* 초기화 - Layout */
	function fnConfigExpendSettingInitLayout() {
		$('button').kendoButton(); /* 켄도버튼정의 */

		$('button').kendoButton(); /* 켄도버튼정의 */
		// 탭 메뉴 초기화
		var onSelect = function(event) {
			tblIndex = Number((event.contentElement.id)
					.replace('tabStrip-', ''));
			tabStrip.unbind("select", onSelect);
		};
		var tabStrip = $("#tabStrip").kendoTabStrip({
			select : onSelect,
			animation : {
				open : {
					effects : ""
				}
			}
		});

		return;
	}

	/* 초기화 - Datepicker */
	function fnConfigExpendSettingInitDatepicker() {
		return;
	}

	/* 초기화 - Input */
	function fnConfigExpendSettingInitInput() {
		fnGetACompanyInfo();

		// 저장버튼 이벤트 등록
		$('#btnSave').click(function(){
			fnSaveOption();
		});
		
		return;
	}

	/* 이벤트 초기화 */
	function fnConfigExpendSettingInitEvent() {
		$(document).on("change","input[type='radio']", function () {
			var setValue = this.value.split('|')[0];
			var setName = this.value.split('|')[1];
			var optionGbn = 0;
			if(detailData.optionGbn == '001'){optionGbn = 0;}
			else if(detailData.optionGbn == '002'){optionGbn = 1;}
			else if(detailData.optionGbn == '003'){optionGbn = 2;}
			//var optData = expendOption[optionGbn][detailData.optionCode]; 
			expendOption[optionGbn][detailData.optionCode].setValue = setValue;
			expendOption[optionGbn][detailData.optionCode].setName = setName;
			//expendOption[optionGbn][detailData.optionCode] = JSON.stringify(optData);
		 });
		$(document).on("change","input[type='text']", function () {
			var optionGbn = 0;
			if(detailData.optionGbn == '001'){optionGbn = 0;}
			else if(detailData.optionGbn == '002'){optionGbn = 1;}
			else if(detailData.optionGbn == '003'){optionGbn = 2;}
			//var optData = expendOption[optionGbn][detailData.optionCode]; 
			expendOption[optionGbn][(detailData.optionCode || 0)].setValue = this.value;
			expendOption[optionGbn][(detailData.optionCode || 0)].setName = this.value;
		});
		return;
	}

	/* 리스트의 데이터 가져오기 함수 */
	function fnGetValueForSelectList(elemId) {
		return $('#' + elemId).val();
	}

	/* 회사 리스트 호출, 리스트 초기화 */
	function fnGetACompanyInfo() {
		var tblParam = {};
		tblParam.sSearch = "";

		url = '<c:url value="/ex/master/config/GetCompanyList.do" />';
		$.ajax({
			type : 'post',
			url : url,
			datatype : 'json',
			data : tblParam,
			async : false,
			success : function(result) {
				setComboBox($("#selCompany"), result.aaData, function(event) {
					fnGetAFormInfo(fnGetValueForSelectList('selCompany'));
				});
				fnGetAFormInfo(fnGetValueForSelectList('selCompany'));
			},
			error : function(result) {
				alert("<%=BizboxAMessage.getMessage("TX000009616","데이터 불러오기 도중 작업을 실패하였습니다")%>");
			}
		});
	}

	// 양식코드 호출
	function fnGetAFormInfo(compSeq) {
		var tblParam = {};
		tblParam.comp_seq = compSeq;
		url = '<c:url value="/ex/master/config/GetFormList.do" />';
		$.ajax({
			type : 'post',
			url : url,
			datatype : 'json',
			data : tblParam,
			async : false,
			success : function(result) {
				setComboBox($("#selForm"), result.aaData, function(event) {
					fnGetAOptionInfo();
				});
				fnGetAOptionInfo();
			},
			error : function(result) {
				alert("<%=BizboxAMessage.getMessage("TX000009616","데이터 불러오기 도중 작업을 실패하였습니다")%>");
			}
		});
	}

	/* 화면 메인 옵션 정보 조회 시작 */
	function fnGetAOptionInfo() {
		var tblParam = {};
		tblParam.comp_seq = (fnGetValueForSelectList('selCompany') || '');
		tblParam.sFormSeq = (fnGetValueForSelectList('selForm') || '');
		url = '<c:url value="/ex/master/config/ExpendOptionListSelect.do" />';
		
		$.ajax({
			type : 'post',
			url : url,
			datatype : 'json',
			data : tblParam,
			async : false,
			success : function(result) {
// 				console.log(result);
				
				// 조회된 정보 포멧 변경
				mainOptionData = fnGetOptionTableData(result);

				// 그리드 데이터 바인딩
				fnSetGridForTab(mainOptionData);
			},
			error : function(result) {
				alert("<%=BizboxAMessage.getMessage("TX000009616","데이터 불러오기 도중 작업을 실패하였습니다")%>");
			}
		});
	}

	/* 옵션데이터 테이블 포멧에 맞는 데이터 가공. */
	function fnGetOptionTableData(data) {
		var returnData = {};
		var layoutOption = {};
		var dateOption = {};
		var functionOption = {};
		for (var i = 0; i < data.optionItemsSet.length; i++) {
			var item = data.optionItemsSet[i];
			returnData[item.optionGbn] = (returnData[item.optionGbn] ? returnData[item.optionGbn]
					: {});
	
			var tab = returnData[item.optionGbn];
			tab[item.optionCode] = (tab[item.optionCode] ? tab[item.optionCode]
					: {});
			tab[item.optionCode].optionGbn = item.optionGbn;
			tab[item.optionCode].optionCode = item.optionCode;
			tab[item.optionCode].commonCode = item.commonCode;
			tab[item.optionCode].useSw = item.useSw;
			tab[item.optionCode].baseValue = item.baseValue;
			tab[item.optionCode].baseEmpValue = item.baseEmpValue;
			tab[item.optionCode].baseName = item.baseName;
			tab[item.optionCode].setValue = item.setValue;
			tab[item.optionCode].setEmpValue = item.setEmpValue;
			tab[item.optionCode].setName = item.setName;
			tab[item.optionCode].orderNum = item.orderNum;
			tab[item.optionCode].useYn = item.useYn;
			tab[item.optionCode].optionSelectType = item.optionSelectType;
			tab[item.optionCode].optionProcessType = item.optionProcessType;
			tab[item.optionCode].optionName = item.optionName;
			tab[item.optionCode].name = item.name;
			if(item.optionGbn == '001' && !layoutOption[item.optionCode]){layoutOption[item.optionCode] = tab[item.optionCode];}
			else if(item.optionGbn == '002' && !dateOption[item.optionCode]){dateOption[item.optionCode] = tab[item.optionCode];}
			else if(item.optionGbn == '003' && !functionOption[item.optionCode]){functionOption[item.optionCode] = tab[item.optionCode];}
			tab[item.optionCode].detailCode = (tab[item.optionCode].detailCode ? tab[item.optionCode].detailCode
					: []);
			tab[item.optionCode].detailCode.push({
				'detailCode' : item.detailCode,
				'detailName' : item.detailName
			});
		}
		expendOption[0] = layoutOption;
		expendOption[1] = dateOption;
		expendOption[2] = functionOption;
		
		return returnData;
	}

	/* 각 탭에 맞는 그리드 정보 호출 */
	function fnSetGridForTab(data) {
		if (!data) {
			// consolse.log('조회된 데이터가 없습니다.');
			return;
		}

		// 화면설정 탭 그리드 데이터 바인딩
		fnSetGridData('tblLayout', data['001']);

		// 날짜설정 탭 그리드 데이터 바인딩
		fnSetGridData('tblDate', data['002']);

		// 기능설정 탭 그리드 데이터 바인딩
		fnSetGridData('tblFunc', data['003']);
	}

	/* 메인 그리드 데이터 바인딩 */
	var mainGrid;
	function fnSetGridData(id, data) {
		id = (id[0] != '#') ? '#' + id : id;

		// Convert object to list.
		var dataArr = $.map(data, function(value, index) {
			return [ value ];
		});

		mainGrid = $(id).kendoGrid({
			columns : [ {
				title : "<%=BizboxAMessage.getMessage("TX000007441","속성정보")%>",
				width : 7,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: left;"
				},
				field : 'optionName'
			}, {
				title : "<%=BizboxAMessage.getMessage("TX000006239","설정정보")%>",
				width : 3,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: left;"
				},
				template : function(data) {
					return data.setName || data.baseName;
				}
			} ],
			dataSource : dataArr,
			height : 402,
			selectable : "single",
			groupable : false,
			columnMenu : false,
			editable : false,
			sortable : true,
			pageable : false,
			navigatable : true,
			change : function(arg) {
				var gview = $(id).data("kendoGrid");
				var selectedItem = gview.dataItem(gview.select());

				// 선택값에 따른 서브 그리드 데이터 바인딩
				fnSetSubGridData(id, selectedItem);
			}
		});
		
		/* 기본 깡통모양 표기 - 데이터 없음 */ 
		subGrid = $(id+'Sub').kendoGrid({
			columns : [ {
				title : "<%=BizboxAMessage.getMessage("TX000000217","설정값")%>",
				width : 1,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: left;"
				},
				field : 'detailName'
			} ],
			dataSource : [],
			height : 402,
			selectable : "single",
			groupable : false,
			columnMenu : false,
			editable : false,
			sortable : true,
			pageable : false,
			navigatable : true,
			change : function(arg) {
			}
		});
	}

	/* 서브 그리드 데이터 바인딩 */
	var subGrid = null;
	var detailData = {};
	function fnSetSubGridData(id, data) {
		detailData = data;
// 		console.log(JSON.stringify(data));
		
		id = id + 'Sub';
		subGrid = $(id).kendoGrid({
			columns : [ {
				title : "<%=BizboxAMessage.getMessage("TX000000217","설정값")%>",
				width : 1,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: left;"
				},
				template : function(item) {
					
// 					if(data.setValue === item.detailCode){
					if(data.optionGbn == '001'){optionGbn = 0;}
					else if(data.optionGbn == '002'){optionGbn = 1;}
					else if(data.optionGbn == '003'){optionGbn = 2;}
					if(!data.commonCode){
						return '<input type="text" name="inp_txt" id="inp_txt'+item.detailCode+' style="width:170px;" value="'+expendOption[optionGbn][data.optionCode].setValue+'"/>';
					}else{
						if(expendOption[optionGbn][data.optionCode].setValue === item.detailCode){
							
							return '<input type="radio" name="inp_radi" id="inp_radi'+item.detailCode+'" class="k-radio" checked="checked" value="'+item.detailCode+'|'+item.detailName+'"/> <label class="k-radio-label radioSel" for="inp_radi'+item.detailCode+'">'+item.detailName+'</label>';
						}
						return '<input type="radio" name="inp_radi" id="inp_radi'+item.detailCode+'" class="k-radio" value="'+item.detailCode+'|'+item.detailName+'"/> <label class="k-radio-label radioSel" for="inp_radi'+item.detailCode+'">'+item.detailName+'</label>';
					}
				}
			} ],
			dataSource : data.detailCode,
			height : 402,
			selectable : "single",
			groupable : false,
			columnMenu : false,
			editable : false,
			sortable : true,
			pageable : false,
			navigatable : true,
			change : function(arg) {
			}
		});
	}
	
	/* 저장 이벤트 설정 */
	function fnSaveOption(){
		/*
		if(!$('.k-radio:visible:checked').length){
			alert("<%=BizboxAMessage.getMessage("TX000016490","저장 정보를 선택하세요")%>");
			return;
		}*/
		
		var data = detailData;
		var idx = 0; 
		
		$('.k-radio:visible').each(function (i){
			if($(this).prop('checked')) idx = i;
		});
					
		var param = {}; 
		var disOpt = new Array(expendOption.length);
		var dateOpt = new Array(expendOption.length);
		var funOpt = new Array(expendOption.length);
		var i = 0 ;
		$.each(expendOption[0],function(idx,data){
			disOpt[i++] = data;
		});
		i = 0;
		$.each(expendOption[1],function(idx,data){
			dateOpt[i++] = data;
		});
		i = 0;
		$.each(expendOption[2],function(idx,data){
			funOpt[i++] = data;
		});
		param.disOpt = JSON.stringify(disOpt);
		param.dateOpt = JSON.stringify(dateOpt);
		param.funOpt = JSON.stringify(funOpt);
		param.compSeq = fnGetValueForSelectList('selCompany');
		param.formSeq = fnGetValueForSelectList('selForm');
		console.log(param);
		
		$.ajax({
			async: false,
			type: "post",
			url: '<c:url value="/ex/master/config/ExpendOptionUpdate.do" />',
			datatype: "json",
			data: param,
			success: function (result) {
				// 결과 메시지 
				alert("<%=BizboxAMessage.getMessage("TX000001983","저장이 완료되었습니다.")%>");
			},
			error: function (err) {
			}
		});
		fnGetAOptionInfo(); 
	}
</script>

<input type="hidden" id="hidSelectOption"></input>

<div class="sub_contents_wrap">

	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt><%=BizboxAMessage.getMessage("TX000000047","회사")%></dt>
			<dd>
				<div class="dod_search">
					<input id="selCompany" style="width: 200px;" class="kendoComboBox" />
				</div>
			</dd>
			<dt><%=BizboxAMessage.getMessage("TX000000177","양식")%></dt>
			<dd>
				<input id="selForm" style="width: 200px;" class="kendoComboBox" />
			</dd>
		</dl>
	</div>

	<div id="" class="controll_btn">
		<button id="btnSearch" class="k-button" style="display: none;"><%=BizboxAMessage.getMessage("TX000001289","검색")%></button>
		<button id="btnSave" class="k-button"><%=BizboxAMessage.getMessage("TX000001256","저장")%></button>
	</div>


	<div class="tab_page">
		<div class="tab_style" id="tabStrip" style="background-color: white;">
			<ul class="mb20" style="background-color: white; border-top: none;">
				<li class="k-state-active"><%=BizboxAMessage.getMessage("TX000007438","기능옵션")%></li>
				<li><%=BizboxAMessage.getMessage("TX000007439","일자옵션")%></li>
				<li><%=BizboxAMessage.getMessage("TX000009606","화면옵션")%></li>
			</ul>
			<div class="tab1">
				<table style="width: 100%;">
					<colgroup>
						<col style="width: 70%;" />
						<col style="" />
					</colgroup>
					<tr>
						<td>
							<div id="divFunc" class="com_ta4 bgtable3 ova_sc"
								style="height: 408px">
								<div id="tblFunc">
									<%-- <colgroup>
										<col width="70%" />
										<col width="" />
									</colgroup>
									<tr>
										<th>기능옵션 속성정보</th>
										<th>기능옵션 설정정보</th>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">미사용</td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">미사용</td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">미사용</td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">미사용</td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">미사용</td>
									</tr>
									<tr>
										<td class="le">
											<img src="<c:url value='/Images/ico/ico_option_bl.gif'/>" alt="" style="margin-top: -2px;" /> [지출결의] 지출결의 예산사용자 타인설정
										</td>
										<td class="le">미사용</td>
									</tr> --%>
								</div>
							</div>
						</td>
						<td class="pl20">
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblFuncSub">
									<!-- <tr>
										<th>기능옵션 설정값</th>
									</tr>
									<tr>
										<td class="le">
											<input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">사용</label>
										</td>
									</tr>
									<tr>
										<td class="le">
											<input type="radio" name="inp_radi" id="inp_radi1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="inp_radi1">미사용</label>
										</td>
									</tr> -->
								</div>
							</div>
						</td>
						<td></td>
					</tr>
				</table>

			</div>
			<!--// tab1 -->

			<div class="tab2">
				<table style="width: 100%;">
					<colgroup>
						<col style="width: 70%;" />
						<col style="" />
					</colgroup>
					<tr>
						<td>
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblDate">
								</div>
							</div>
						</td>
						<td class="pl20">
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblDateSub">
								</div>
							</div>
						</td>
						<td></td>
					</tr>
				</table>


			</div>
			<!--// tab2 -->


			<div class="tab3">
				<table style="width: 100%;">
					<colgroup>
						<col style="width: 70%;" />
						<col style="" />
					</colgroup>
					<tr>
						<td>
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblLayout">
								</div>
							</div>
						</td>
						<td class="pl20">
							<div class="com_ta4 bgtable3 ova_sc" style="height: 408px">
								<div id="tblLayoutSub">
								</div>
							</div>
						</td>
						<td></td>
					</tr>
				</table>


			</div>
			<!--// tab3 -->





		</div>
		<!--// tab_style -->
	</div>
	<!--// tab_page -->



</div>
<!-- //sub_contents_wrap -->