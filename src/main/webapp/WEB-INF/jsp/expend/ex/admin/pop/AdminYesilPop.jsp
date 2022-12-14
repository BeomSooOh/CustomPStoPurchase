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
<script type="text/javascript" src='<c:url value="/js/jquery.maskMoney.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExAmtCommon.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEx.js"></c:url>'></script>
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
	/* AdminYesilPop var */
	
	/* document.ready */
	$(document).ready(function() {
		
		log('+ [AdminYesilPop] (document).ready');
		$('#text_input').focus();
		var defaultInfo = {
			budgetFlag : '${budgetFlag}',
			fromDt : '${fromDt}',
			toDt : '${toDt}',
			searchStr : '${searchStr}'
		}
		
		fnAdminYesilPopInit(defaultInfo);
		fnAdminYesilPopEventInit();
		
		$("#text_input").val('${searchStr}');
		/* ????????? ????????????, ?????? ?????? ?????? */
		fnGetMaingridData(defaultInfo);
		log('+ [AdminYesilPop] (document).ready');
	});
	
	/* ????????? */
	function fnAdminYesilPopInit(defaultInfo) {
		log('+ [AdminYesilPop] fnAdminYesilPopInit');
		fnAdminYesilPopLayout();
		fnAdminYesilPopDatepicker();
		fnAdminYesilPopInitInput();
		fnAdminYesilPopInitButton(defaultInfo);
		log('- [AdminYesilPop] fnAdminYesilPopInit');
		return;
	}
	
	/* ????????? - Layout */
	function fnAdminYesilPopLayout() {
		log('+ [AdminYesilPop] fnAdminYesilPopLayout');
		$('button').kendoButton(); /* ?????????????????? */
		log('- [AdminYesilPop] fnAdminYesilPopLayout');
		return;
	}
	
	/* ????????? - Datepicker */
	function fnAdminYesilPopDatepicker() {
		log('+ [AdminYesilPop] fnAdminYesilPopDatepicker');
		log('- [AdminYesilPop] fnAdminYesilPopDatepicker');
		return;
	}
	
	/* ????????? - Event */
	function fnAdminYesilPopEventInit() {
		log('+ [AdminYesilPop] fnAdminYesilPopEventInit');
		$("#text_input").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		log('- [AdminYesilPop] fnAdminYesilPopEventInit');
		return;
	}
	
	/* ????????? - Input */
	function fnAdminYesilPopInitInput() {
		log('+ [AdminYesilPop] fnAdminYesilPopInitInput');
		
		log('- [AdminYesilPop] fnAdminYesilPopInitInput');
		return;
	}
	/* ????????? - Button */
	function fnAdminYesilPopInitButton(defaultInfo) {
		log('+ [AdminYesilPop] fnAdminYesilPopInitButton');
        
        /* ???????????? ????????? ?????? */
		$('#btnSearch').click(function (){
			fnGetMaingridData(defaultInfo);
		});
		
		/* ???????????? ????????? ?????? */
		$('#btnAccept').click(function (){
			if($('#hid_dataTrunk').val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000019021","????????? ????????? ????????????.")%>");
				return false;
			}
			var data = JSON.parse($('#hid_dataTrunk').val());
			var param = { obj : data , budgetFlag : '${budgetFlag}'};
			
			window.close();
			
			// ?????? ?????? ??????
			window.opener.fnPopCallback(param);
		});
		
        /* ???????????? ????????? ?????? */
		$('#btnClose').click(function (){
			window.close();
		});
		log('- [AdminYesilPop] fnAdminYesilPopInitButton');
		return;
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
		strWidth = 475;
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
	
	function fnGetMaingridData(defaultInfo){
		var param = {};
		param.budgetFlag = defaultInfo.budgetFlag;
		param.fromDt = defaultInfo.fromDt;
		param.toDt = defaultInfo.toDt;
		param.search_str = $('#text_input').val() || '';
		
		// ?????? ?????? ??? ?????? ????????? ??????
	    $.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/expend/admin/ExAdminYesilPopInfoSelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : param,
	        success : function( data ) {	  
	        	fnSetMainList(defaultInfo, data);
	        	fnResizeForm();
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}
	
	/* ??????????????? ??????
	--------------------------------------------*/
	function fnSetMainList(defaultInfo, data){
		var aoColumn = "";
		var budgetFlag = defaultInfo.budgetFlag;
		// ???????????? data??? ?????? ??????.
		if( budgetFlag == "0"){
			aoColumn = [ {
	                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000045","??????")%>",
	                "mDataProp" : "DEPT_CD",
	                "bVisible" : true,
	                "bSortable" : true,
	                "sWidth" : ""
	            }, {
	                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000098","??????")%>",
	                "mDataProp" : "DEPT_NM",
	                "bVisible" : true,
	                "bSortable" : true,
	                "sWidth" : "",
	          } ];
		}else if(budgetFlag == "1"){
			aoColumn = [ {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000045","??????")%>",
                "mDataProp" : "NO_PROJECT",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000519","????????????")%>",
                "mDataProp" : "NM_PROJECT",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
          } ];
		}else if(budgetFlag == "2"){
			aoColumn = [ {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000045","??????")%>",
                "mDataProp" : "SECT_CD",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : ""
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000019020","??????")%>",
                "mDataProp" : "SECT_NM",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
          } ];
		}
		// ????????? ????????? ??????
		fnSetGridView(defaultInfo, 'tbl_yesilPop', data.result.aaData, aoColumn);
	}
	
	/*	[???]	????????? ????????? ??????
	--------------------------------------------*/
	function fnSetGridView(defaultInfo, elemID, data, aoColumn, columDefs){
		columDefs = (columDefs || {});
		
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

<div class="pop_wrap" style="width: 475px;">
	<div class="pop_head">
		<c:if test="${budgetFlag eq 0}">
			<h1><%=BizboxAMessage.getMessage("TX000005516","?????????")%></h1>
		</c:if>
		<c:if test="${budgetFlag eq 1}">
			<h1><%=BizboxAMessage.getMessage("TX000018990","???????????????")%></h1>
		</c:if>
		<c:if test="${budgetFlag eq 2}">
			<h1><%=BizboxAMessage.getMessage("TX000018991","?????????")%></h1>
		</c:if>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con div_form">
	<!-- ???????????? -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000000399","?????????")%></dt>
				<dd><input id="text_input" name="text_input" type="text" style="width:200px;" value="${searchStr}"/></dd>
				<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","??????")%>" /></dd>
			</dl>
		</div>

		<!-- ????????? -->
		<div class="com_ta2 mt14">
			<table id = "tbl_yesilPop">
				<colgroup>
					<col width="130"/>
					<col width=""/>
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

