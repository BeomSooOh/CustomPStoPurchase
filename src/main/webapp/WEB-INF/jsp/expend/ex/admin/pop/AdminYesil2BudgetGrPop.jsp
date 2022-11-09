<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
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
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.checkboxes.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/jquery.maskMoney.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExAmtCommon.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.format.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.list.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.pop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/jquery.ex.valid.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>

<!-- javascript -->
<script>
	/* AdminYesil2BudgetGrPop var */
	
	/* document.ready */
	$(document).ready(function() {
		
		log('+ [AdminYesil2BudgetGrPop] (document).ready');
		$('#text_input').focus();
		
		fnAdminYesil2BudgetGrPopInit();
		fnAdminYesil2BudgetGrPopEventInit();
		
		/* 페이지 준비완료, 최초 조회 시작 */
		$('#btnSearch').click();
		log('+ [AdminYesil2BudgetGrPop] (document).ready');
	});
	
	/* 초기화 */
	function fnAdminYesil2BudgetGrPopInit() {
		log('+ [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopInit');
		fnAdminYesil2BudgetGrPopLayout();
		fnAdminYesil2BudgetGrPopDatepicker();
		fnAdminYesil2BudgetGrPopInitInput();
		fnAdminYesil2BudgetGrPopInitButton();
		log('- [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopInit');
		return;
	}0
	
	/* 초기화 - Layout */
	function fnAdminYesil2BudgetGrPopLayout() {
		log('+ [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopLayout');
		$('button').kendoButton(); /* 켄도버튼정의 */
		fnAdminYesil2BudgetGrCommonCode('acctLevelSel', '${ViewBag.params.acctLevelList}');
		log('- [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopLayout');
		return;
	}
	
	/* 초기화 - Datepicker */
	function fnAdminYesil2BudgetGrPopDatepicker() {
		log('+ [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopDatepicker');
		log('- [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopDatepicker');
		return;
	}
	
	/* 초기화 - Event */
	function fnAdminYesil2BudgetGrPopEventInit() {
		log('+ [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopEventInit');
		$("#text_input, #endDate").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		log('- [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopEventInit');
		return;
	}
	
	/* 초기화 - Input */
	function fnAdminYesil2BudgetGrPopInitInput() {
		log('+ [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopInitInput');
		
		log('- [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopInitInput');
		return;
	}
	/* 초기화 - Button */
	function fnAdminYesil2BudgetGrPopInitButton(defaultInfo) {
		log('+ [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopInitButton');
        
        /* 검색버튼 이벤트 설정 */
		$('#btnSearch').click(function (){
			fnGetMaingridData();
		});
		
		/* 확인버튼 이벤트 설정 */
		$('#btnAccept').click(function (){
			var data;
			if($('#hid_dataTrunk').val() == ''){
				data = {};
			}else{
				data = JSON.parse($('#hid_dataTrunk').val());
			}
			var param = { obj : data };
			
			window.close();
			
			// 콜백 함수 호출
			window.opener.fnBudgetGrCallback(param);
		});
		
        /* 취소버튼 이벤트 설정 */
		$('#btnClose').click(function (){
			window.close();
		});
		log('- [AdminYesil2BudgetGrPop] fnAdminYesil2BudgetGrPopInitButton');
		return;
	}
	
	function fnAdminYesil2BudgetGrCommonCode(elemID, data){
		var id = '' + elemID;
		id = id[0] == '#' ? id : '#' + id;
		
		var jsonData =  JSON.parse(data);
		var dataSource = new Array();
		$(jsonData).each(function(index, value){
			dataSource.push( { 'text' : value.NM_SYSDEF, 'value' : value.CD_SYSDEF } );
		});
		
		$(id).kendoComboBox({
			"dataTextField" : "text",
            "dataValueField" : "value",
			"dataSource" : dataSource,
			"index" : 0
		});
	}
	
	/* [ 사이즈 변경 ] 페이지 리폼
	-----------------------------------------------*/
	function fnResizeForm() {
		var strWidth = $('.pop_wrap').outerWidth() + (window.outerWidth - window.innerWidth);
		var strHeight = $('.pop_wrap').outerHeight() + (window.outerHeight - window.innerHeight);
		
		$('.pop_wrap').css("overflow","auto");
		
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		
		
		if(isFirefox){
			
		}if(isIE){

		}if(isEdge){
			strWidth = 640;
			strHeight = 530;
		}if(isChrome){
			
		}
		
		try{
			var childWindow = window.parent;
			childWindow.resizeTo(strWidth, strHeight);	
		}catch(exception){
			console.log('window resizing cat not run dev mode.');
		}
	}
	
	function fnGetMaingridData(){
		var comboBox = $('#acctLevelSel').data("kendoComboBox");
		var level = comboBox.value();
		
		var param = {
			grLevel : level ,
			searchStr : ($('#text_input').val() || '')
		};
		
		// 정보 조회 후 메인 그리드 출력
	    $.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/expend/admin/ExAdminYesil2BudgetGrInfo.do" />',
	        datatype : 'json',
	        async : true,
	        data : param,
	        success : function( data ) {	  
	        	fnSetMainList(data);
	        	fnResizeForm();
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}
	
	/* 메인리스트 설정
	--------------------------------------------*/
	function fnSetMainList(data){
		var aoColumn = "";
		// 파라메터 data의 가공 필요.
		aoColumn = [ {
               "sTitle" : "<%=BizboxAMessage.getMessage("TX000019015","예산단위그룹코드")%>",
               "mDataProp" : "CD_BUDGETGR",
               "bVisible" : true,
               "bSortable" : true,
               "sWidth" : ""
           	}, {
               "sTitle" : "<%=BizboxAMessage.getMessage("TX000018982","예산단위그룹명")%>",
               "mDataProp" : "NM_BUDGETGR",
               "bVisible" : true,
               "bSortable" : true,
               "sWidth" : "",
	        }, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019016","상위예산단위그룹")%>",
	            "mDataProp" : "H_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	}, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019017","차상위예산단위그룹")%>",
	            "mDataProp" : "HH_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	},{
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019018","차차상위예산단위그룹")%>",
	            "mDataProp" : "HHH_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	} ];
		// 그리드 그리기 호출
		fnSetGridView('tbl_yesil2Pop', data.result.aaData, aoColumn);
	}
	
	/*	[뷰]	그리드 데이터 셋팅
	--------------------------------------------*/
	function fnSetGridView( elemID, data, aoColumn, columDefs){
		columDefs = (columDefs || {});
		$.each(data, function(idx, item){
			data[idx] = $.extend({CD_BUDGETGR: '', NM_BUDGETGR: '', H_NM_BGACCT: '', HH_NM_BGACCT: '', HHH_NM_BGACCT: '' }, item);
		});
		
		var id = '' + elemID;
		id = id[0] == '#' ? id : '#' + id;
		if(data && data.length == 1 && $('#text_input').val() != ''){
			$('#hid_dataTrunk').val(JSON.stringify(data[0]));
			$('#btnAccept').click();
		}
        var oTable = $(id).dataTable({
            /* "fixedHeader" : true, */
            "select" : true,
            "pageLength" : 7,
            "sScrollY" : "260px",
            "bAutoWidth" : false,
            "destroy" : true,
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
                 $(nRow).on('click', (function() {
                 	$('#hid_dataTrunk').val(JSON.stringify(aData))
                 }));
                 $(nRow).on('dblclick', (function() {
                     $('#hid_dataTrunk').val(JSON.stringify(aData));
                     $('#btnAccept').click();
                 }));
            },
            "aoColumns" : aoColumn,
            "columnDefs" : columDefs
        });
        
	}
</script>

<input type="hidden" value="" id="hid_dataTrunk"/>

<div class="pop_wrap" style="width:640px;">
	<div class="pop_head">
		<h1><%=BizboxAMessage.getMessage("TX000018985","예산단위그룹")%></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con div_form">
	<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000001289","검색")%></dt>
				<dd><input id="text_input" name="text_input" type="text" style="width:120px;"/></dd>
				<dt><%=BizboxAMessage.getMessage("TX000019019","그룹레벨")%></dt>
				<dd>
					<input class="mr25" id="acctLevelSel" style="width:120px;" class="kendoComboBox" />
				</dd>
				<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" /></dd>
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta2 mt14">
			<table id = "tbl_yesil2Pop">
				<colgroup>
					<col width="110"/>
					<col width="110"/>
					<col width="110"/>
					<col width="110"/>
					<col width="140"/>
				</colgroup>
			</table>		
			</div>
	</div>

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnAccept" value="<%=BizboxAMessage.getMessage("TX000000078","확인")%>" />
			<input type="button" id="btnClose" class="gray_btn" value="<%=BizboxAMessage.getMessage("TX000002947","취소")%>" />
		</div>
	</div><!-- //pop_foot -->
</div><!--// pop_wrap -->

