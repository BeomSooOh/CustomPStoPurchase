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
	/* UserYesil2BizPlanPop var */
	
	/* document.ready */
	$(document).ready(function() {
		
		log('+ [UserYesil2BizPlanPop] (document).ready');
		$('#text_input').focus();
		
		fnUserYesil2BizPlanPopInit();
		fnUserYesil2BizPlanPopEventInit();
		
		/* 페이지 준비완료, 최초 조회 시작 */
		$('#btnSearch').click();
		log('+ [UserYesil2BizPlanPop] (document).ready');
	});
	
	/* 초기화 */
	function fnUserYesil2BizPlanPopInit() {
		log('+ [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopInit');
		fnUserYesil2BizPlanPopLayout();
		fnUserYesil2BizPlanPopDatepicker();
		fnUserYesil2BizPlanPopInitInput();
		fnUserYesil2BizPlanPopInitButton();
		log('- [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopInit');
		return;
	}0
	
	/* 초기화 - Layout */
	function fnUserYesil2BizPlanPopLayout() {
		log('+ [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopLayout');
		$('button').kendoButton(); /* 켄도버튼정의 */
		log('- [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopLayout');
		return;
	}
	
	/* 초기화 - Datepicker */
	function fnUserYesil2BizPlanPopDatepicker() {
		log('+ [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopDatepicker');
		fnInitDatePicker();
		log('- [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopDatepicker');
		return;
	}
	
	/* 초기화 - Event */
	function fnUserYesil2BizPlanPopEventInit() {
		log('+ [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopEventInit');
		$("#text_input, #endDate").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		
		$(".k-radio").click(function(){
			$('#btnSearch').click();
		});
		log('- [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopEventInit');
		return;
	}
	
	/* 초기화 - Input */
	function fnUserYesil2BizPlanPopInitInput() {
		log('+ [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopInitInput');
		
		log('- [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopInitInput');
		return;
	}
	/* 초기화 - Button */
	function fnUserYesil2BizPlanPopInitButton(defaultInfo) {
		log('+ [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopInitButton');
        
        /* 검색버튼 이벤트 설정 */
		$('#btnSearch').click(function (){
			fnGetMaingridData();
		});
		
		/* 확인버튼 이벤트 설정 */
		$('#btnAccept').click(function (){
			var table = $('#tbl_yesil2Pop').DataTable();

	  		var rows_selected = table.column(0).checkboxes.selected();
			var param = new Array();
			// Iterate over all selected checkboxes
			$.each(rows_selected, function(index, rowId){
				var json = { 'text' : this.NM_BIZPLAN , 'value' : this.CD_BIZPLAN };
				param.push(json);
			});
			
			// 콜백 함수 호출
			window.opener.fnBizPlanCallback(param);
			window.close();
		});
		
        /* 취소버튼 이벤트 설정 */
		$('#btnClose').click(function (){
			window.close();
		});
		log('- [UserYesil2BizPlanPop] fnUserYesil2BizPlanPopInitButton');
		return;
	}
	
	/*	[데이트 피커] Initialrize date picker with gap
	----------------------------------------*/
	function fnInitDatePicker() {
		Date.prototype.EndDate = function(){
			var yyyy = this.getFullYear().toString();
			var mm = this.getMonth()+1;
			return yyyy + '-' + mm
		}
		var date = new Date();
		$('#endDate').val(date.EndDate());
		
	    $(".datepicker").kendoDatePicker({
	    	start: "year",
			depth: "year",
			format: "yyyy-MM",
			culture : "ko-KR"
	    });
	    
	    $('#endDate').kendoMaskedTextBox({
	        mask : '0000-00'
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
		
		// 정보 조회 후 메인 그리드 출력
	    $.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/expend/user/ExUserYesil2BizPlanInfo.do" />',
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
	
	function fnSetParam(data){
		var rData = new Array();
		
		$(".k-radio").each(function(){
    		if(this.checked == true){
    			var value = this.value;
    			if(value == "1"){
    				$(data).each(function(index, element){
    					if( element.YN_USE == 'Y'){
    						rData.push(element);
    					}
    				});
    			}else if(value == "2"){
    				$(data).each(function(index, element){
    					if( element.YN_USE == 'N'){
    						rData.push(element);
    					}
    				});
    			}else if(value == '3'){
    				rData = data;
    			}
    		}
    	});
		
		return rData;
	}
	
	/* 메인리스트 설정
	--------------------------------------------*/
	function fnSetMainList(data){
		var rData = fnSetParam(data.result.aaData);
		
		var aoColumn = "";
		aoColumn = [ {
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : ""
            }, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000007565","사업계획코드")%>",
	            "mDataProp" : "CD_BIZPLAN",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : ""
        	}, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000018983","사업계획명")%>",
	            "mDataProp" : "NM_BIZPLAN",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	            "defaultContent" : ""
	        }, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019006","상위사업계획명")%>",
	            "mDataProp" : "NM_BIZPLAN1",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	            "defaultContent" : ""
	     	}, {
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019007","차상위사업계획명")%>",
	            "mDataProp" : "NM_BIZPLAN2",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	            "defaultContent" : ""
	     	},{
	            "sTitle" : "<%=BizboxAMessage.getMessage("TX000019008","차차상위사업계획명")%>",
	            "mDataProp" : "NM_BIZPLAN3",
	            "bVisible" : true,
	            "bSortable" : true,
	            "sWidth" : "",
	            "defaultContent" : ""
	     	} ];
		
		var columDefs = [ {
			"targets" : 0,
			"data" : null,
			"checkboxes" : { 'selectRow' : true}
		} ]
		// 그리드 그리기 호출
		fnSetGridView('tbl_yesil2Pop', rData, aoColumn, columDefs);
	}
	
	/*	[뷰]	그리드 데이터 셋팅
	--------------------------------------------*/
	function fnSetGridView( elemID, data, aoColumn, columDefs){
		columDefs = (columDefs || {});
		
		var id = '' + elemID;
		id = id[0] == '#' ? id : '#' + id;
		if(data && data.length == 1 && $('#text_input').val() != ''){
			var param = [{ 'text' : data[0].NM_BIZPLAN , 'value' : data[0].CD_BIZPLAN }];
			
			window.close();
			// 콜백 함수 호출
			window.opener.fnBizPlanCallback(param);
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

<div class="pop_wrap" style="width: 740px;">
	<div class="pop_head">
		<h1><%=BizboxAMessage.getMessage("TX000018986","사업계획")%></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con div_form">
	<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000019009","종료년월")%></dt>
				<dd><input id="endDate" value="" class="dpWid datepicker"/></dd>
				<dt><%=BizboxAMessage.getMessage("TX000000028","사용여부")%></dt>
				<dd>
					<input type="radio" name="val_radi" id="val_radi1" value="1" class="k-radio" checked="checked" /> <label class="k-radio-label radioSel" for="val_radi1"><%=BizboxAMessage.getMessage("TX000000180", "사용")%></label>
					<input type="radio" name="val_radi" id="val_radi2" value="2" class="k-radio" /> <label class="k-radio-label radioSel" for="val_radi2"><%=BizboxAMessage.getMessage("TX000018611", "미사용")%></label>
					<input type="radio" name="val_radi" id="val_radi3" value="3" class="k-radio"/> <label class="k-radio-label radioSel" for="val_radi3"><%=BizboxAMessage.getMessage("TX000000862", "전체")%></label>
				</dd>
				<dt>검색</dt>
				<dd><input class="mr5" id="text_input" name="text_input" type="text" style="width:120px;"/></dd>
				<dd><input type="button" id="btnSearch" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" /></dd>
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta2 mt14">
			<table id = "tbl_yesil2Pop">
				<colgroup>
					<col width="40"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="120"/>
					<col width="130"/>
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
