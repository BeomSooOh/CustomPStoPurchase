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
	/* UserYesil2BudgetGrPop var */
	
	/* document.ready */
	$(document).ready(function() {
		
		log('+ [UserYesil2BudgetGrPop] (document).ready');
		$('#text_input').focus();
		
		fnUserYesil2BudgetGrPopInit();
		fnUserYesil2BudgetGrPopEventInit();
		
		/* ????????? ????????????, ?????? ?????? ?????? */
		$('#btnSearch').click();
		log('+ [UserYesil2BudgetGrPop] (document).ready');
	});
	
	/* ????????? */
	function fnUserYesil2BudgetGrPopInit() {
		log('+ [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopInit');
		fnUserYesil2BudgetGrPopLayout();
		fnUserYesil2BudgetGrPopDatepicker();
		fnUserYesil2BudgetGrPopInitInput();
		fnUserYesil2BudgetGrPopInitButton();
		log('- [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopInit');
		return;
	}0
	
	/* ????????? - Layout */
	function fnUserYesil2BudgetGrPopLayout() {
		log('+ [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopLayout');
		$('button').kendoButton(); /* ?????????????????? */
		fnUserYesil2BudgetGrCommonCode('acctLevelSel', '${ViewBag.params.acctLevelList}');
		log('- [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopLayout');
		return;
	}
	
	/* ????????? - Datepicker */
	function fnUserYesil2BudgetGrPopDatepicker() {
		log('+ [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopDatepicker');
		log('- [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopDatepicker');
		return;
	}
	
	/* ????????? - Event */
	function fnUserYesil2BudgetGrPopEventInit() {
		log('+ [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopEventInit');
		$("#text_input, #endDate").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		log('- [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopEventInit');
		return;
	}
	
	/* ????????? - Input */
	function fnUserYesil2BudgetGrPopInitInput() {
		log('+ [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopInitInput');
		
		log('- [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopInitInput');
		return;
	}
	/* ????????? - Button */
	function fnUserYesil2BudgetGrPopInitButton(defaultInfo) {
		log('+ [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopInitButton');
        
        /* ???????????? ????????? ?????? */
		$('#btnSearch').click(function (){
			fnGetMaingridData();
		});
		
		/* ???????????? ????????? ?????? */
		$('#btnAccept').click(function (){
			var data;
			if($('#hid_dataTrunk').val() == ''){
				data = {};
			}else{
				data = JSON.parse($('#hid_dataTrunk').val());
			}
			var param = { obj : data };
			
			window.close();
			
			// ?????? ?????? ??????
			window.opener.fnBudgetGrCallback(param);
		});
		
        /* ???????????? ????????? ?????? */
		$('#btnClose').click(function (){
			window.close();
		});
		log('- [UserYesil2BudgetGrPop] fnUserYesil2BudgetGrPopInitButton');
		return;
	}
	
	function fnUserYesil2BudgetGrCommonCode(elemID, data){
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
	
	/* [ ????????? ?????? ] ????????? ??????
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
		
		// ?????? ?????? ??? ?????? ????????? ??????
	    $.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/expend/user/ExUserYesil2BudgetGrInfo.do" />',
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
	
	/* ??????????????? ??????
	--------------------------------------------*/
	function fnSetMainList(data){
		var aoColumn = "";
		// ???????????? data??? ?????? ??????.
		aoColumn = [ {
               "sTitle" : "<%=BizboxAMessage.getMessage("TX000019015","????????????????????????")%>",
               "mDataProp" : "CD_BUDGETGR",
               "bVisible" : true,
               "bSortable" : true,
               "sWidth" : ""
           	}, {
               "sTitle" : "<%=BizboxAMessage.getMessage("TX000018982","?????????????????????")%>",
               "mDataProp" : "NM_BUDGETGR",
               "bVisible" : true,
               "bSortable" : true,
               "sWidth" : "",
	        }, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019016","????????????????????????")%>",
	            "mDataProp" : "H_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	}, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019017","???????????????????????????")%>",
	            "mDataProp" : "HH_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	},{
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019018","??????????????????????????????")%>",
	            "mDataProp" : "HHH_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	} ];
		// ????????? ????????? ??????
		fnSetGridView('tbl_yesil2Pop', data.result.aaData, aoColumn);
	}
	
	/*	[???]	????????? ????????? ??????
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
                "lengthMenu" : "?????? _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","???????????? ????????????")%>",
                "infoFiltered" : "(?????? _MAX_ ???.)"
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
		<h1><%=BizboxAMessage.getMessage("TX000018985","??????????????????")%></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con div_form">
	<!-- ???????????? -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000001289","??????")%></dt>
				<dd><input id="text_input" name="text_input" type="text" style="width:120px;"/></dd>
				<dt><%=BizboxAMessage.getMessage("TX000019019","????????????")%></dt>
				<dd>
					<input class="mr25" id="acctLevelSel" style="width:120px;" class="kendoComboBox" />
				</dd>
				<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","??????")%>" /></dd>
			</dl>
		</div>

		<!-- ????????? -->
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
			<input type="button" id="btnAccept" value="<%=BizboxAMessage.getMessage("TX000000078","??????")%>" />
			<input type="button" id="btnClose" class="gray_btn" value="<%=BizboxAMessage.getMessage("TX000002947","??????")%>" />
		</div>
	</div><!-- //pop_foot -->
</div><!--// pop_wrap -->
