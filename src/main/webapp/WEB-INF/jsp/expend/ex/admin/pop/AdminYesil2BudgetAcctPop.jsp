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
	/* AdminYesil2BudgetAcctPop var */
	
	/* document.ready */
	$(document).ready(function() {
		log('+ [AdminYesil2BudgetAcctPop] (document).ready');
		var defaultInfo = { 
			cdDeptPipe : '${cdDeptPipe}',
			cdBudgetPipe : '${cdBudgetPipe}',
			cdBizplanPipe : '${cdBizplanPipe}',
			tpAclevel : '${tpAclevel}'
		};
		$('#text_input').focus();
		
		fnAdminYesil2BudgetAcctPopInit(defaultInfo);
		fnAdminYesil2BudgetAcctPopEventInit();
		
		/* 페이지 준비완료, 최초 조회 시작 */
		fnGetMaingridData(defaultInfo);
		log('+ [AdminYesil2BudgetAcctPop] (document).ready');
	});
	
	/* 초기화 */
	function fnAdminYesil2BudgetAcctPopInit(defaultInfo) {
		log('+ [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopInit');
		fnAdminYesil2BudgetAcctPopLayout();
		fnAdminYesil2BudgetAcctPopDatepicker();
		fnAdminYesil2BudgetAcctPopInitInput();
		fnAdminYesil2BudgetAcctPopInitButton(defaultInfo);
		log('- [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopInit');
		return;
	}0
	
	/* 초기화 - Layout */
	function fnAdminYesil2BudgetAcctPopLayout() {
		log('+ [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopLayout');
		$('button').kendoButton(); /* 켄도버튼정의 */
		log('- [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopLayout');
		return;
	}
	
	/* 초기화 - Datepicker */
	function fnAdminYesil2BudgetAcctPopDatepicker() {
		log('+ [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopDatepicker');
		fnInitDatePicker();
		log('- [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopDatepicker');
		return;
	}
	
	/* 초기화 - Event */
	function fnAdminYesil2BudgetAcctPopEventInit() {
		log('+ [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopEventInit');
		$("#text_input, #endDate").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		log('- [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopEventInit');
		return;
	}
	
	/* 초기화 - Input */
	function fnAdminYesil2BudgetAcctPopInitInput() {
		log('+ [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopInitInput');
		
		log('- [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopInitInput');
		return;
	}
	/* 초기화 - Button */
	function fnAdminYesil2BudgetAcctPopInitButton(defaultInfo) {
		log('+ [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopInitButton');
        
        /* 검색버튼 이벤트 설정 */
		$('#btnSearch').click(function (){
			fnGetMaingridData(defaultInfo);
		});
		
		/* 확인버튼 이벤트 설정 */
		$('#btnAccept').click(function (){
			var table = $('#tbl_yesil2Pop').DataTable();

	  		var rows_selected = table.column(0).checkboxes.selected();
			var param = new Array();
			// Iterate over all selected checkboxes
			$.each(rows_selected, function(index, rowId){
				var json = { 'text' : this.NM_BGACCT , 'value' : this.CD_BGACCT };
				param.push(json);
			});
			window.close();
			
			// 콜백 함수 호출
			window.opener.fnBudgetAcctCallback(param);
		});
		
        /* 취소버튼 이벤트 설정 */
		$('#btnClose').click(function (){
			window.close();
		});
		log('- [AdminYesil2BudgetAcctPop] fnAdminYesil2BudgetAcctPopInitButton');
		return;
	}
	
	/*	[데이트 피커] Initialrize date picker with gap
	----------------------------------------*/
	function fnInitDatePicker() {
		Date.prototype.EndDate = function(){
			var yyyy = this.getFullYear().toString();
			return yyyy
		}
		var date = new Date();
		$('#endDate').val(date.EndDate());
		
	    $(".datepicker").kendoDatePicker({
	    	start: "year",
			depth: "year",
			format: "yyyy",
			culture : "ko-KR"
	    });
	    
	    $('#endDate').kendoMaskedTextBox({
	        mask : '0000'
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
			strWidth = 740;
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
		var param = {
			dateEnd : ($('#endDate').val() || ''),
			cdDeptPipe : defaultInfo.cdDeptPipe || '',
			cdBudgetPipe : defaultInfo.cdBudgetPipe || '',
			cdBizplanPipe : defaultInfo.cdBizplanPipe || '',
			search : ($('#text_input').val() || ''),
			tpAclevel : defaultInfo.tpAclevel || '' 
		};
		
		// 정보 조회 후 메인 그리드 출력
	    $.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/expend/admin/ExAdminYesil2BudgetAcctInfo.do" />',
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
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : ""
            }, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000007568","예산계정코드")%>",
	            "mDataProp" : "CD_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : ""
        	}, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000007535","예산계정명")%>",
	            "mDataProp" : "NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	        }, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019010","상위계정명")%>",
	            "mDataProp" : "H_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	}, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019011","차상위계정명")%>",
	            "mDataProp" : "HH_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	},{
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019012","차차상위계정명")%>",
	            "mDataProp" : "HHH_NM_BGACCT",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	     	} ];
		
		var columDefs = [ {
			"targets" : 0,
			"data" : null,
			"checkboxes" : { 'selectRow' : true}
		} ]
		// 그리드 그리기 호출
		fnSetGridView('tbl_yesil2Pop', data.result.aaData, aoColumn, columDefs);
	}
	
	/*	[뷰]	그리드 데이터 셋팅
	--------------------------------------------*/
	function fnSetGridView( elemID, data, aoColumn, columDefs ){
		columDefs = (columDefs || {});
		
		var id = '' + elemID;
		id = id[0] == '#' ? id : '#' + id;
		if(data && data.length == 1 && $('#text_input').val() != ''){
			var param = [{ 'text' : data[0].NM_BGACCT , 'value' : data[0].CD_BGACCT }];
			
			window.close();
			// 콜백 함수 호출
			window.opener.fnBudgetAcctCallback(param);
		}
        var oTable = $(id).dataTable({
            /* "fixedHeader" : true, */
            "select" : {style : 'multi' },
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

<div class="pop_wrap" style="width:740px;">
	<div class="pop_head">
		<h1><%=BizboxAMessage.getMessage("TX000019013","예산계정(예산단위연결)")%></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con div_form">
	<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000003649","예산연도")%></dt>
				<dd><input id="endDate" value="" class="dpWid datepicker"/></dd>
				<dt><%=BizboxAMessage.getMessage("TX000000399","검색어")%></dt>
				<dd><input class="mr5" id="text_input" name="text_input" type="text" style="width:120px;"/></dd>
				<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" /></dd>
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta2 mt14">
			<table id = "tbl_yesil2Pop">
				<colgroup>
					<col width="40"/>
					<col width="110"/>
					<col width="110"/>
					<col width="110"/>
					<col width="110"/>
					<col width="110"/>
				</colgroup>
			</table>		
			</div>
		</div><!--// pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnAccept" value="<%=BizboxAMessage.getMessage("TX000000078","확인")%>" />
			<input type="button" id="btnClose" class="gray_btn" value="<%=BizboxAMessage.getMessage("TX000002947","취소")%>" />
		</div>
	</div><!-- //pop_foot -->
</div><!--// pop_wrap -->
