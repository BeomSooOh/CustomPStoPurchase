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
	/* AdminYesil2DeptPop var */
	
	/* document.ready */
	$(document).ready(function() {
		
		log('+ [AdminYesil2DeptPop] (document).ready');
		$('#text_input').focus();
		
		fnAdminYesil2DeptPopInit();
		fnAdminYesil2DeptPopEventInit();
		
		/* ????????? ????????????, ?????? ?????? ?????? */
		$('#btnSearch').click();
		log('+ [AdminYesil2DeptPop] (document).ready');
	});
	
	/* ????????? */
	function fnAdminYesil2DeptPopInit() {
		log('+ [AdminYesil2DeptPop] fnAdminYesil2DeptPopInit');
		fnAdminYesil2DeptPopLayout();
		fnAdminYesil2DeptPopDatepicker();
		fnAdminYesil2DeptPopInitInput();
		fnAdminYesil2DeptPopInitButton();
		log('- [AdminYesil2DeptPop] fnAdminYesil2DeptPopInit');
		return;
	}0
	
	/* ????????? - Layout */
	function fnAdminYesil2DeptPopLayout() {
		log('+ [AdminYesil2DeptPop] fnAdminYesil2DeptPopLayout');
		$('button').kendoButton(); /* ?????????????????? */
		log('- [AdminYesil2DeptPop] fnAdminYesil2DeptPopLayout');
		return;
	}
	
	/* ????????? - Datepicker */
	function fnAdminYesil2DeptPopDatepicker() {
		log('+ [AdminYesil2DeptPop] fnAdminYesil2DeptPopDatepicker');
		fnInitDatePicker();
		log('- [AdminYesil2DeptPop] fnAdminYesil2DeptPopDatepicker');
		return;
	}
	
	/* ????????? - Event */
	function fnAdminYesil2DeptPopEventInit() {
		log('+ [AdminYesil2DeptPop] fnAdminYesil2DeptPopEventInit');
		$("#text_input, #endDate").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		log('- [AdminYesil2DeptPop] fnAdminYesil2DeptPopEventInit');
		return;
	}
	
	/* ????????? - Input */
	function fnAdminYesil2DeptPopInitInput() {
		log('+ [AdminYesil2DeptPop] fnAdminYesil2DeptPopInitInput');
		
		log('- [AdminYesil2DeptPop] fnAdminYesil2DeptPopInitInput');
		return;
	}
	/* ????????? - Button */
	function fnAdminYesil2DeptPopInitButton(defaultInfo) {
		log('+ [AdminYesil2DeptPop] fnAdminYesil2DeptPopInitButton');
        
        /* ???????????? ????????? ?????? */
		$('#btnSearch').click(function (){
			fnGetMaingridData();
		});
		
		/* ???????????? ????????? ?????? */
		$('#btnAccept').click(function (event){
			var table = $('#tbl_yesil2Pop').DataTable();

	  		var rows_selected = table.column(0).checkboxes.selected();
			var param = new Array();
			// Iterate over all selected checkboxes
			$.each(rows_selected, function(index, rowId){
				var json = { 'text' : this.NM_DEPT , 'value' : this.CD_DEPT };
				param.push(json);
			});
			
			
			console.log(param);
			window.close();
			// ?????? ?????? ??????
			window.opener.fnDeptCallback(param);
		});
		
        /* ???????????? ????????? ?????? */
		$('#btnClose').click(function (){
			window.close();
		});
		log('- [AdminYesil2DeptPop] fnAdminYesil2DeptPopInitButton');
		return;
	}
	
	/*	[????????? ??????] Initialrize date picker with gap
	----------------------------------------*/
	function fnInitDatePicker() {
	    $(".datepicker").kendoDatePicker({
			format: "yyyy-MM-dd",
			culture : "ko-KR"
	    });
	    
	    $('#endDate').kendoMaskedTextBox({
	        mask : '0000-00-00'
	    });
	    
	    var dt = new Date();
        $('#endDate').val([ dt.getFullYear(), ((Number(dt.getMonth()) + 1) < 10 ? [ '0', (Number(dt.getMonth()) + 1) ].join('') : (dt.getMonth() + 1)), ((dt.getDate() + '').length == 2 ? dt.getDate() : '0' + dt.getDate()) ].join('-'));
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
			strWidth = 500;
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
		var param = {
			dateEnd : ($('#endDate').val().toString().replace(/-/g, '') || ''),
			detailSearchCode : ($('#text_input').val() || '')
		};
		
		param = $.extend({
			helpId: '',
			childMode: '',
			erpCompSeq: '',
			cdGroup: '',
			cdBizarea: '',
			cdPc: '',
			cdDept: '',
			cdCc: '',
			noEmp: '',
			idUser: '',
			cdPlant: '',
			cdCcgrp: '',
			idMenu: '',
			cdItem: '',
			cdItemgrp: '',
			cdPartner: '',
			cdPurgrp: '',
			cdPurorg: '',
			cdSalegrp: '',
			cdSaleorg: '',
			cdSl: '',
			cdWc: '',
			cdWh: '',
			fgModule: '',
			dateStart: '',
			dateEnd: '',
			moduleParent: '',
			userGrant: '',
			authBizarea: '',
			authDept: '',
			authPc: '',
			cdAcct: '',
			tpAclevel: '',
			tpAcstats: '',
			cdMng: '',
			cdMngd: '',
			cdField1: '',
			cdField2: '',
			cdField3: '',
			code1: '',
			code2: '',
			code3: '',
			code4: '',
			code5: '',
			detailSearchCode: ''
		}, param);
		
		// ?????? ?????? ??? ?????? ????????? ??????
	    $.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/expend/admin/ExAdminYesil2DeptInfo.do" />',
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
            "bVisible" : true,
            "bSortable" : true,
            "sWidth" : "" ,
           }, {
               "sTitle" : "<%=BizboxAMessage.getMessage("TX000000067","????????????")%>",
               "bVisible" : true,
               "bSortable" : true,
               "sWidth" : "",
               "sClass" : ""
           }, {
               "sTitle" : "<%=BizboxAMessage.getMessage("TX000000068","?????????")%>",
               "bVisible" : true,
               "bSortable" : true,
               "sWidth" : "",
        } ];
		
		var columDefs = [ {
			"targets" : 0,
			"data" : null,
			"checkboxes" : { 'selectRow' : true },
		},{
			"targets" : 1,
			"data" : null,
			"render"  : function(data) {
				return  data.CD_DEPT || '' ;
			}
		}, {
			"targets" : 2,
			"data" : null,
			"render" : function(data) {
				return  data.NM_DEPT || '' ;
			}
		} ]
		// ????????? ????????? ??????
		fnSetGridView('tbl_yesil2Pop', data.result.aaData, aoColumn, columDefs);
	}
	
	/*	[???]	????????? ????????? ??????
	--------------------------------------------*/
	function fnSetGridView( elemID, data, aoColumn, columDefs){
		columDefs = (columDefs || {});
		
		var id = '' + elemID;
		id = id[0] == '#' ? id : '#' + id;
		if(data && data.length == 1 && $('#text_input').val() != ''){
			var param = [{ 'text' : data[0].NM_DEPT , 'value' : data[0].CD_DEPT }];
			
			window.close();
			// ?????? ?????? ??????
			window.opener.fnDeptCallback(param);
		}
        var oTable = $(id).dataTable({
            /* "fixedHeader" : true, */
            "select" : {style : 'multi' },
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
                $(nRow).on('dblclick', (function() {
                    $('#btnAccept').click();
                }));
                
                $(nRow).find("td :eq(0)").empty();
                $(nRow).find("td :eq(0)").append('<input type="checkbox" class="dt-checkboxes k-checkbox" value="chk_'+iDisplayIndex+'">');
                $(nRow).find("td :eq(0)").append('<label for="chk_'+iDisplayIndex+'" class="k-checkbox-label"></label>');
            },
            "fnHeaderCallback": function( nHead, aData, iStart, iEnd, aiDisplay ){
            	$(nHead).find("th :eq(0)").empty();
            	$(nHead).find("th :eq(0)").append(' <input type="checkbox" class="k-checkbox" value="checkbox">');
            	$(nHead).find("th :eq(0)").append(' <label for="checkbox" class="k-checkbox-label"></label>');
            },
            "aoColumns" : aoColumn,
            "columnDefs" : columDefs
        });
	}
</script>

<div class="pop_wrap" style="width:500px;">
	<div class="pop_head">
		<h1><%=BizboxAMessage.getMessage("TX000000098","??????")%></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con div_form">
	<!-- ???????????? -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000008423","???????????????")%></dt>
				<dd><input id="endDate" value="" class="dpWid datepicker"/></dd>
				<dt><%=BizboxAMessage.getMessage("TX000001289","??????")%></dt>
				<dd><input class="mr5" id="text_input" name="text_input" type="text" style="width:100px;"/></dd>
				<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","??????")%>" /></dd>
			</dl>
		</div>

		<!-- ????????? -->
		<div class="com_ta2 mt14">
			<table id = "tbl_yesil2Pop">
				<colgroup>
					<col width="40"/>
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

</div><!--// pop_con -->

