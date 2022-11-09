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

<!-- javascript - src -->
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExOption.js?ver=20190729"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>

<!-- javascript -->
<script>
	/* AdminYesilReport var */
	if(window.console == undefined){console = {log:function(){}}} /* IE console.log 에러 방지 */
	
	/* document.ready */
	$(document).ready(function() {
		<c:if test="${ViewBag.params.groupSeq == 'dev'}"> /* 개발버전인 경우 */
		debug = true;
		/* $('#btnDebugViewVar').show(); */
		/* setClick($('#btnDebugViewVar'), showLog); */
		</c:if>
		
		log('+ [AdminYesiReport] (document).ready');
		fnAdminYesilReportInit();
		fnAdminYesilReportEventInit();
		
		fnSetYesilGrid();
		fnSetYesilGridSelect_Row();
		log('+ [AdminYesiReport] (document).ready');
	});
	
	/* 초기화 */
	function fnAdminYesilReportInit() {
		log('+ [AdminYesilReport] fnAdminYesilReportInit');
		fnAdminYesilReportLayout();
		fnAdminYesilReportDatepicker();
		fnAdminYesilReportInitInput();
		fnAdminYesilReportInitButton();
		log('- [AdminYesilReport] fnAdminYesilReportInit');
		return;
	}
	
	/* 초기화 - Layout */
	function fnAdminYesilReportLayout() {
		log('+ [AdminYesilReport] fnAdminYesilReportLayout');
		$('button').kendoButton(); /* 켄도버튼정의 */
		fnAdminYesilComboBox(); /* 켄도콤보박스 정의 */
		log('- [AdminYesilReport] fnAdminYesilReportLayout');
		return;
	}
	
	/* 초기화 - Datepicker */
	function fnAdminYesilReportDatepicker() {
		log('+ [AdminYesilReport] fnAdminYesilReportDatepicker');
		fnInitDatePicker();
		log('- [AdminYesilReport] fnAdminYesilReportDatepicker');
		return;
	}
	
	/* 초기화 - Event */
	function fnAdminYesilReportEventInit() {
		log('+ [AdminYesilReport] fnAdminYesilReportEventInit');
		fnAdminYesilEventKey(); /* 키보드 이벤트 정의 */
		
		$('#from_date').data("kendoDatePicker").bind( "change", function(){
			var maxYear = $('#from_date').val();
			maxYear = maxYear.toString().split('-')[0];
			var datePicker = $('#to_date').data("kendoDatePicker");
			datePicker.min(new Date(maxYear, 0));
			datePicker.max(new Date(maxYear, 11));
			datePicker.value(new Date(maxYear, 11));
			datePicker.trigger("change");

	    });
		
		log('- [AdminYesilReport] fnAdminYesilReportEventInit');
		return;
	}
	
	/* 초기화 - Input */
	function fnAdminYesilReportInitInput() {
		log('+ [AdminYesilReport] fnAdminYesilReportInitInput');
		
		log('- [AdminYesilReport] fnAdminYesilReportInitInput');
		return;
	}
	/* 초기화 - Button */
	function fnAdminYesilReportInitButton() {
		log('+ [AdminYesilReport] fnAdminYesilReportInitButton');
        $('#btnPop').click(function() {
        	$('#input_text').val("");
        	fnYesilPopup();
        });
        $('#searchButton').click(function(){
        	$('.dataTables_scrollFoot').remove();
        	var table = $('#yesilDetailView').DataTable();
        	table.clear().draw();
        	fnAdminYesilSearch();
        });
        
        $('#btnExcelDown').click(function(){
        	excelDown();
        })
        
		log('- [AdminYesilReport] fnAdminYesilReportInitButton');
		return;
	}
	
	/*	[데이트 피커] Initialrize date picker with gap
	----------------------------------------*/
	function fnInitDatePicker() {
		Date.prototype.FromDate = function(){
			var yyyy = this.getFullYear().toString();
			var mm = 01;
			return yyyy + '-' + mm
		}
		Date.prototype.ToDate = function(){
			var yyyy = this.getFullYear().toString();
			var mm = 12;
			return yyyy + '-' + mm
		}
		var date = new Date();
		$('#from_date').val(date.FromDate());
		$('#to_date').val(date.ToDate());
		
	    $(".datepicker").kendoDatePicker({
	    	start: "year",
			depth: "year",
			format: "yyyy-MM",
			culture : "ko-KR"
	    });
	    
	    $('#from_date').kendoMaskedTextBox({
            mask : '0000-00'
        });
	    
	    $('#to_date').kendoMaskedTextBox({
            mask : '0000-00'
        });
	    
	    var maxYear = $('#from_date').val().split('-')[0]; 
	    $('#to_date').data("kendoDatePicker").min( new Date(maxYear , 0 ));
	    $('#to_date').data("kendoDatePicker").max( new Date(maxYear , 11 ));
	    
	}
	
	/* 키보드 이벤트 정의 */
    function fnAdminYesilEventKey(){
        $("#input_text").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                fnYesilPopup();
            }else{
            	$('#hid_searchCode').val("");
            }
        });
        
        $("#from_date,#to_date").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;

                $('#searchButton').click();
            }
        });
    }
	
	function fnAdminYesilComboBox(){
		var budgetFG = '${ViewBag.params.budgetFG}';
		var data = [];
		var val = "";
		if(budgetFG == 'D'){
			data = [ 
			         {text : "<%=BizboxAMessage.getMessage("TX000005516","부서별")%>" , value : "0"},
			         {text : "<%=BizboxAMessage.getMessage("TX000018991","부문별")%>" , value : "2"}
				   ];
			val = "0";	
		}else if(budgetFG == 'P'){
			data = [ 
			         {text : "<%=BizboxAMessage.getMessage("TX000018990","프로젝트별")%>", value : "1"} 
			       ];
			val = "1";
		}
		$("#article_sel").kendoComboBox({
			dataTextField: "text",
            dataValueField: "value",
			dataSource : data,
	        value : val,
	        change : function(){
	        	$('#input_text').val("");
	        	$('#hid_searchCode').val("");
	        }
	    });
	}
	
	/*	[팝업] 부서, 프로젝트, 부문 팝업 호출
 	--------------------------------------*/
 	function fnYesilPopup(){
 		var popWidth = 475, popHeight = 530; //팝업 창 사이즈
		
 		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winWidth = document.body.clientWidth; // 현재창의 너비
		var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표 
		
		var popX = winX + (screen.width - popWidth) / 2;
		var popY = winY + (screen.height - popHeight) / 2;
		
		var comboBox = $('#article_sel').data("kendoComboBox");
		var budgetFlag = comboBox.value();
		var url = "";
		var fromDt = ($('#from_date').val().toString().replace(/-/g, '') + '01' || '');
		var toDt = ($('#to_date').val().toString().replace(/-/g, '') + '01' || '');
		var param = 'budgetFlag=' + budgetFlag + '&fromDt=' + fromDt + '&toDt=' + toDt + '&searchStr=' + $('#input_text').val();

		url = "<c:url value='/ex/expend/admin/ExAdminYesilPop.do?"+param+"'/>";
		
		var pop = window.open(url, "AdminYesilPop", "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY);
	}
	
 	/*	[팝업] 지출결의현황 popup
 	--------------------------------------*/
	function fnYesilDetailPopup(data){
		var popWidth = 1100, popHeight = 650; //팝업 창 사이즈

		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winWidth = document.body.clientWidth; // 현재창의 너비
		var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표 
		
		var popX = winX + (screen.width - popWidth) / 2;
		var popY = winY + (screen.height - popHeight) / 2;
		
		var budgetNm = $('#input_text').val();
		var budgetCd = $('#hid_searchCode').val();
		var budgetYm = $('#from_date').val().split('-')[0];
		var acctNm = "";
		var acctCd = "";
		
		$('#yesilView tbody tr').each(function(){
			if($(this).hasClass('selected')){
				acctCd = $(this).find('td :eq(0)').text();
				acctNm = $(this).find('td :eq(1)').text();
			}
		});
		var budYmType = "";
		if(data.DATA_FG == 'Q'){
			budYmType = data.BUD_YM.substring(5, data.BUD_YM.length);
		}else if(data.DATA_FG == 'H'){
			budYmType = data.BUD_YM.substring(5, data.BUD_YM.length);
		}else if(data.DATA_FG == 'M'){
			budYmType = data.BUD_YM.toString().substring(4,6) + "<%=BizboxAMessage.getMessage("TX000000436","월")%>";
		}
		var dataFg = data.DATA_FG;
		
		var param = "budgetNm="+encodeURI(encodeURIComponent(budgetNm))+"&budgetCd="+encodeURI(encodeURIComponent(budgetCd))+"&budgetYm="+encodeURI(encodeURIComponent(budgetYm))+"&acctNm="+encodeURI(encodeURIComponent(acctNm))+"&acctCd="+encodeURI(encodeURIComponent(acctCd))+"&budYmType="+encodeURI(encodeURIComponent(budYmType))+"&dataFg="+encodeURI(encodeURIComponent(dataFg));
		// var param = "budgetNm="+encodeURI(encodeURIComponent(budgetNm))+"&budgetCd="+budgetCd+"&budgetYm="+budgetYm+"&acctNm="+encodeURI(encodeURIComponent(acctNm))+"&acctCd="+acctCd+"&budYmType="+budYmType+"&dataFg="+dataFg;

		url = "<c:url value='/ex/expend/admin/ExAdminYesilDetailPop.do?"+param+"'/>";
		
		var pop = window.open(url, "AdminYesilPop", "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY);
	}
	
 	/*	[뷰-검색] 예실대비현황 조회 - 유효성 검사
 	--------------------------------------*/
	function fnAdminYesilValidation(){
   		
		if( $('#hid_searchCode').val() == null || $('#hid_searchCode').val() == '' ){
			alert("관리항목을 선택해주세요.");
			var table = $('#yesilView').DataTable();
        	table.clear().draw();
        	var detail_table = $('#yesilDetailView').DataTable();
        	detail_table.clear().draw();
			return false;
		}
		return true;
	}
	
 	/*	[뷰-검색] 예실대비현황 조회 - 서버 호출
 	--------------------------------------*/
	function fnAdminYesilSearch(){
		if( fnAdminYesilValidation() ){
			var comboBox = $('#article_sel').data("kendoComboBox");
			var budgetFlag = comboBox.value();
			
	 		var param = {
	 			'fromDt' : ($('#from_date').val().toString().replace(/-/g, '') || ''),
	 			'toDt' : ($('#to_date').val().toString().replace(/-/g, '') || ''),
	 			'budgetFlag' : budgetFlag,
	 			'searchCode' : $('#hid_searchCode').val() + '|'
	 		};
			
			/* 서버호출 */
	        $.ajax({
	            type : 'post',
	            url : '<c:url value="/ex/expend/admin/ExAdminYesilInfoSelect.do" />',
	            datatype : 'json',
	            async : true,
	            data : param,
	            success : function( data ) {
	            	fnSetYesilGrid(data.result.aaData);
	            },
	            error : function( data ) {
	                console.log("! [EX] ERROR - " + JSON.stringify(data));
	            }
	        });
		}
	}
 	
	/*	[뷰-그리드] 예산코드 과목명 출력
 	--------------------------------------*/
	function fnSetYesilGrid(data){
		$('#yesilView').DataTable({
			"aaSorting": [],
            "select" : true,
            "paging" : false,
            "fixedHeader" : {
                header: true
            },
            "sScrollY": $(window).height() * 0.6,
            "sScrollX": "98%",
            "bAutoWidth" : false,
            "destroy" : true,
            "bSort" : true,
            "paging" : false, 
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638","데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
            	if(aData.FLAG == '1'){
            		$(nRow).find('td').eq(1).addClass("le");
            		$(nRow).addClass("titcol");
            	}else{
            		$(nRow).find('td').eq(1).addClass("ri");
            	}
            	$('.dataTables_empty').text("<%=BizboxAMessage.getMessage("TX000018993","예산코드를 선택해주세요.")%>");
            	$(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                	fnAdminYesilEventSelect_Row(aData);
                }));
            },
            columnDefs : [ {
    			"targets" : 0,
    			"data" : null,
    			"render"  : function(data) {
    				return  data.ACCT_CD || '' ;
    			}
    		}, {
    			"targets" : 1,
    			"data" : null,
    			"render" : function(data) {
    				return  data.ACCT_NM || '' ;
    			}
    		} ],
            aoColumns : [ {
            		"sTitle" : "<%=BizboxAMessage.getMessage("TX000004243","예산코드")%>",
        			"bVisible" : true,
        			"bSortable" : true,
        			"sWidth" : ""
        		}, {
        			"sTitle" : "<%=BizboxAMessage.getMessage("TX000003629","예산과목명")%>",
        			"bVisible" : true,
        			"bSortable" : true,
        			"sWidth" : "",
        			"sClass" : ""
        		} ]
        });
		
		$(".dataTables_scrollHeadInner , .dataTables_scrollHeadInner table").css("width", "");
	}
	
	
	var excelFormData = [];
	/*	[뷰-검색] 예실대비현황 Row 선택 - 서버 호출
 	--------------------------------------*/
	function fnAdminYesilEventSelect_Row(data){
		var comboBox = $('#article_sel').data("kendoComboBox");
		var budgetFlag = comboBox.value();
		$("#hid_bgacctNM").val(data.ACCT_NM);
		$("#hid_bgacctCode").val(data.ACCT_CD);
 		var param = {
 			'fromDt' : ($('#from_date').val().toString().replace(/-/g, '') || ''),
 			'toDt' : ($('#to_date').val().toString().replace(/-/g, '') || ''),
 			'budgetFlag' : budgetFlag,
 			'searchCode' : $('#hid_searchCode').val() + '|',
 			'ACCT_CD' : data.ACCT_CD || ''
 		};
		
 		Array.prototype.insert = function ( index, item ) {
 		    this.splice( index, 0, item );
 		};
 		
		/* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/admin/ExAdminYesilDetailSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	
            	var refactObj = data.subResult.params.resultData;
            	var firstHalf = data.subResult.params.resultData[3].amt + data.subResult.params.resultData[7].amt;
            	var secondHalf = data.subResult.params.resultData[11].amt + data.subResult.params.resultData[15].amt;
            	var obj = data.result.aaData;            	
            	
            	refactObj[16].budget_ym = '합계'
            	
				if((param.fromDt).substring(4,6)/6 -1 >= 0){
					//refactObj.push({'budget_ym':'하반기' ,'amt':secondHalf});
					refactObj.insert(16,{'budget_ym': (param.fromDt).substring(0,4)+' 하반기' ,'amt':secondHalf});
            	}else if((param.fromDt).substring(4,6)/6  -1 <= 0 && (param.toDt).substring(4,6)/6 < 0){
            		//refactObj.push({'budget_ym':'상반기' ,'amt':firstHalf});
            		refactObj.insert(8,{'budget_ym': (param.fromDt).substring(0,4) +' 상반기' ,'amt':firstHalf});
            	}else{
            		refactObj.insert(8,{'budget_ym': (param.fromDt).substring(0,4) +' 상반기' ,'amt':firstHalf});
            		refactObj.insert(16,{'budget_ym': (param.fromDt).substring(0,4) +' 하반기' ,'amt':secondHalf});
            	}

            	$.each(obj,function(idx,row){

            		$.each(refactObj,function(ix,rw){
            			if(refactObj[ix].budget_ym == obj[idx].BUD_YM){
            				obj[idx].noExpend = refactObj[ix].amt;
            				obj[idx].RESULT_AM = obj[idx].BUDGET_AM -  obj[idx].ACCT_AM -  obj[idx].PLAN_AM -  obj[idx].noExpend;
            			}
            		})
            	})
            	
            	excelFormData = obj;     
            	fnSetYesilGridSelect_Row(obj);
            	
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
	}
	
 	
 	/*	[뷰-그리드] 행 선택 그리드 출력
 	--------------------------------------*/
 	
 	
	function fnSetYesilGridSelect_Row(data){
 		$('.dataTables_scrollFoot table tfoot').remove();
		$('#yesilDetailView').append("<tfoot><tr><td></td><td class='ri'></td><td class='ri'></td><td class='ri'></td><td class='ri'></td><td class='ri'></td><td class='ri'></td><td class='ri'></td></tr></tfoot>");
		$('#yesilDetailView').DataTable({
			"aaSorting": [],
            "select" : true,
            "paging" : false,
            "fixedHeader" : {
                header : true
            },
            "sScrollY": $(window).height() * 0.6,
            "sScrollX": "98%",
            "bAutoWidth" : false,
            "destroy" : true,
            "bSort" : true,
            "paging" : false, 
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
            	
            	if(aData.DATA_FG == 'Q'){
            		$(nRow).addClass("halfcol");
            	}else if(aData.DATA_FG == 'H'){
            		$(nRow).addClass("quartercol");
            	}else if(aData.DATA_FG == 'Y'){
            		$(nRow).hide();
            	}
            	
            	$(nRow).on('click', (function() {
            		fnYesilDetailPopup(aData);
                }));
            },
            "footerCallback": function ( row, data, start, end, display ) {
            	var api = this.api();
            	
            	if(data.length == 0){
            		$(row).hide();
            	}else{
            		$(row).show();
	            	$(data).each(function(index, data){
	            		if(data.DATA_FG == 'Y'){
	            			$(api.column(0).footer()).html(data.BUD_YM);
	            			$(api.column(1).footer()).html(data.PROP_AM.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	            			$(api.column(2).footer()).html(data.FORM_AM.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	            			$(api.column(3).footer()).html(data.BUDGET_AM.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	            			$(api.column(4).footer()).html(data.noExpend.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	            			$(api.column(5).footer()).html(data.PLAN_AM.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	            			$(api.column(6).footer()).html(data.ACCT_AM.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	            			var RESULT_AM = data.BUDGET_AM - data.ACCT_AM - data.PLAN_AM - data.noExpend;
	            			$(api.column(7).footer()).html(RESULT_AM.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
	            			
	            			$('.dataTables_scrollFootInner table tfoot tr').addClass("totalcol");
	            		}
	            	});
            	}
            },
            columnDefs : [ {
    			"targets" : 0,
    			"data" : null,
    			"render"  : function(data) {
    				if( data.DATA_FG == 'M' ){
    					return data.BUD_YM.toString().substring(0,4) + "/" + data.BUD_YM.toString().substring(4,6) || '' ;
    				}else{
    					return  data.BUD_YM || '' ;
    				}
    			}
    		}, {
    			"targets" : 1,
    			"data" : null,
    			"render" : function(data) {
    				return  data.PROP_AM.toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ',');
    			}
    		}, {
    			"targets" : 2,
    			"data" : null,
    			"render" : function(data) {
    				return  data.FORM_AM.toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ',');
    			}
    		}, {
    			"targets" : 3,
    			"data" : null,
    			"render" : function(data) {
    				return  data.BUDGET_AM.toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ',');
    			}
    		}, {
    			"targets" : 4,
    			"data" : null,
    			"render" : function(data) {
    				return  data.noExpend.toString().replace(
    						/\B(?=(\d{3})+(?!\d))/g, ',');
    			}
    		},{
    			"targets" : 5,
    			"data" : null,
    			"render" : function(data) {
    				return  data.PLAN_AM.toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ',');
    			}
    		},{
    			"targets" : 6,
    			"data" : null,
    			"render" : function(data) {
    				return  data.ACCT_AM.toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ',');
    			}
    		}, {
    			"targets" : 7,
    			"data" : null,
    			"render" : function(data) {
    				return  data.RESULT_AM.toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ',');
    			}
    		} ],
            aoColumns : [ {
	        		"sTitle" : "<%=BizboxAMessage.getMessage("TX000000214","구분")%>",
	    			"bVisible" : true,
	    			"bSortable" : true,
	    			"sWidth" : ""
	    		}, {
	    			"sTitle" : "<%=BizboxAMessage.getMessage("TX000018994","신청예산")%>",
	    			"bVisible" : true,
	    			"bSortable" : true,
	    			"sWidth" : "",
	    			"sClass" : ""
	    		}, {
	    			"sTitle" : "<%=BizboxAMessage.getMessage("TX000009448","편성예산")%>",
	    			"bVisible" : true,
	    			"bSortable" : true,
	    			"sWidth" : "",
	    			"sClass" : ""
	    		}, {
	    			"sTitle" : "<%=BizboxAMessage.getMessage("TX000009447","실행예산")%>",
	    			"bVisible" : true,
	    			"bSortable" : true,
	    			"sWidth" : "",
	    			"sClass" : ""
	    		}, {
	    			"sTitle" : "미전송금액",
	    			"bVisible" : true,
	    			"bSortable" : true,
	    			"sWidth" : "",
	    			"sClass" : ""
	    		},{
	    			"sTitle" : "<%=BizboxAMessage.getMessage("TX000009446","집행예정")%>",
	    			"bVisible" : true,
	    			"bSortable" : true,
	    			"sWidth" : "",
	    			"sClass" : ""
	    		}, {
	    			"sTitle" : "<%=BizboxAMessage.getMessage("TX000018998","집행완료")%>",
	    			"bVisible" : true,
	    			"bSortable" : true,
	    			"sWidth" : "",
	    			"sClass" : ""
	    		}, {
	    			"sTitle" : "<%=BizboxAMessage.getMessage("TX000002959","예실대비")%>",
	    			"bVisible" : true,
	    			"bSortable" : true,
	    			"sWidth" : "",
	    			"sClass" : ""
	    		} ]
        });
		
		$('.dataTables_scrollFoot table tfoot tr').click(function() {
    		alert("<%=BizboxAMessage.getMessage("TX000018999","합계는 지원하지 않습니다.")%>");
        });
		
		$(".dataTables_scrollHeadInner , .dataTables_scrollHeadInner table").css("width", "");
		$(".dataTables_scrollFootInner , .dataTables_scrollFootInner table").css("width", "");
	}
	
	/*	[팝업] callback function
 	--------------------------------------*/
	function fnPopCallback(param){
		var budgetFlag = param.budgetFlag;
		if(budgetFlag == '0'){
			$('#hid_searchCode').val(param.obj.DEPT_CD);
			$('#input_text').val(param.obj.DEPT_NM);
		}else if(budgetFlag == '1'){
			$('#hid_searchCode').val(param.obj.NO_PROJECT);
			$('#input_text').val(param.obj.NM_PROJECT);
		}else if(budgetFlag == '2'){
			$('#hid_searchCode').val(param.obj.SECT_CD);
			$('#input_text').val(param.obj.SECT_NM);
		}
	}
	
	function excelDown(){
		if(excelFormData[0] == null ){
			alert("데이터가 없습니다.");
			return;
		}
		
		var subHeader = {};
		subHeader.budget_code = '항목코드';
		subHeader.budget_name= '관리항목';
		subHeader.bgacct_code = '예산코드';
		subHeader.bgacct_name = '예산과목명';
		
		var subTable = {};
		subTable.budget_code = $('#hid_searchCode').val()
		subTable.budget_name = $('#input_text').val();
		subTable.bgacct_name = $('#hid_bgacctNM').val();
		subTable.bgacct_code = $('#hid_bgacctCode').val();
		
		/* 계정코드 및 관리항목테이블 */
		$("#subHeader").val(JSON.stringify(subHeader) );
		$("#subTable").val(JSON.stringify(subTable) );
		
		$("#fileName").val( "예실대비현황(iCUBE)" );
		
		/* Excel 헤더 정의 */
		var excelHeader = {};
		excelHeader.BUD_YM = "구분";
		excelHeader.PROP_AM = "신청예산";
		excelHeader.FORM_AM = "편성예산";
		excelHeader.BUDGET_AM = "실행예산";
		excelHeader.noExpend = "미전송금액";
		excelHeader.PLAN_AM = "집행예정";
		excelHeader.ACCT_AM = "집행완료";
		excelHeader.RESULT_AM = "예실대비";
		
		/* 엑셀 헤더 지정 */
		$("#excelHeader").val( JSON.stringify(excelHeader) );
		
		/* 엑셀 데이터 지정 */
		$("#tableData").val( JSON.stringify(excelFormData) );
		
		var url = "<c:url value='/ex/admin/YesilExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
	
</script>

<!-- body -->
<!-- hidden -->
<input type="hidden" value="" id="hid_searchCode"/>
<input type="hidden" value="" id="hid_bgacctNM"/>
<input type="hidden" value="" id="hid_bgacctCode"/>

<!-- iframe wrap -->
<div class="iframe_wrap">
	<div class="sub_contents_wrap">
		<!-- 컨트롤박스 -->
		<div class="top_box">
			<dl>
				<dt><%=BizboxAMessage.getMessage("TX000000229","조회일자")%></dt>
				<dd>
					<input id="from_date" value="" class="dpWid datepicker"/>
					~
					<input id="to_date" value="" class="dpWid datepicker"/>		
				</dd>
				<dt><%=BizboxAMessage.getMessage("TX000002703","관리항목")%></dt>
				<dd>
					<input id="article_sel" style="width:100px;" class="kendoComboBox" />
					<input id="input_text" type="text" value="" style="width:130px;">
					<input id="btnPop" type="button" class="normal_btn mr5" value="<%=BizboxAMessage.getMessage("TX000000265","선택")%>">					
				</dd>
				<dd><input type="button" id="searchButton" value="<%=BizboxAMessage.getMessage("TX000001289","검색")%>" /></dd>
				<dd><input type="button" id="btnExcelDown" value="<%=BizboxAMessage.getMessage("TX000009553","엑셀다운로드")%>" /></dd>
			</dl>
		</div>

		<div class="controll_btn">
		</div>
		<div>
			<table>
				<colgroup>
					<col width="20%" />
					<col />
				</colgroup>
				<tr>
					<td class="twinbox_td" valign="top">
						<div class="com_ta2 bg_lightgray ova_sc viewDiv">
							<table id="yesilView"">
								<colgroup>
									<col width="90"/>
									<col width=""/>
								</colgroup>
							</table>
						</div>
					</td>

					<td class="twinbox_td pl20" valign="top">
						<div class="com_ta2 bg_lightgray ova_sc viewDiv">
							<table id="yesilDetailView">
								<colgroup>
									<col  width="9%"/>
									<col  width="13%"/>	
									<col  width="13%"/>	
									<col  width="13%"/>	
									<col  width="13%"/>	
									<col  width="13%"/>
									<col  width="13%"/>
									<col  width="13%"/>	
								</colgroup>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<form id="excelDownload" name="excel" method="post">
   		<input type="hidden" name="subHeader" value="" id="subHeader" />
   		<input type="hidden" name="subTable" value="" id="subTable" />
   		<input type="hidden" name="tableData" value="" id="tableData">
    	<input type="hidden" name="excelHeader" value="" id="excelHeader" />
    	<input type="hidden" name="fileName" value="" id="fileName">
	</form>
</div>