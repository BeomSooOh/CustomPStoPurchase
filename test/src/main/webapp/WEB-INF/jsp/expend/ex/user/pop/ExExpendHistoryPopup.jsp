<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="currentTime" class="java.util.Date" />
<%@page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:include page="../../../../common/layer/ProgressLayerPop.jsp" flush="false" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">

	<title>bizbox A</title> <!--css-->

	<!--js-->
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/CommonEX.js'></script>

<!-- 준성 --> 
<script type="text/javascript"src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>


<script type="text/javascript">
	var newExpendSeq = ${expendSeq};
	var isInsertSlipMode = ${isInsertSlipMode};
	var formSeq = "${formSeq}"; 
	
	$(document).ready(function() {
		fnInit();
		$('#btnHistorySearch').click();
	});
	
	/* 초기화 */
	function fnInit(){
		fnLayoutInit();
		fnUserExpendInitDatepicker(); 
		fnBtnInit();
		fnEventInit();	
	}
	/* 레이아웃 초기화 */
	function fnLayoutInit(){
		var docStatusInfo = ('${docStatCode}' === '' ? [] : ${docStatCode});
        $("#selExpendStatCode").empty();
		$.each(docStatusInfo, function(idx, item) {
			$("#selExpendStatCode").append("<option value='" + item.commonCode + "'>" + item.commonName + "</option>");
		});
		
		$("#selExpendStatCode").selectmenu({change: function(){
			$('#btnHistorySearch').click();
		}});
		
		if(docStatusInfo.length > 0){
			$("#selExpendStatCode").val(docStatusInfo[0].commonCode).selectmenu('refresh');
		}
	}
	
	/* fnUserCardReportInit - Datepicker */
	function fnUserExpendInitDatepicker() {

		/* class="datepicker" datepicker 정의 */
		setDatePicker($('.datepicker'));
		
		fnInitDatePicker(1);
	}
	
	/* 버튼 초기화 */
	function fnBtnInit(){
		$('#btnHistorySearch').click(function(){
			fnHistoryListSearch();
		});
		
		$('.BtnReflect').unbind().click(function(){
			// fnHistoryReflect(this);
			// 상배
			fnHistoryReflectV2(this);
		});
		
		$('#btnCancel').click(function(){
			window.close();
		});
		
	}
	
	
	/* 이벤트 초기화 */
	function fnEventInit(){
		  $('#txtDoc').keydown(function(event){
	            /* 엔터입력 이벤트 적용 */
	            if (event.which == 13) {
	            	$('#btnHistorySearch').click();
	            }
	        });
	}

	/*  
	function fnEventInit(){
		  $('#txtDocNo, #txtDocTitle').keydown(function(event){
	            if (event.which == 13) {
	            	$('#btnHistorySearch').click();
	            }
	        });
	} */

	
	/*	[데이트 피커] Initialrize date picker with gap
	----------------------------------------*/
	function fnInitDatePicker(monthGap) {

		// Object Date add prototype
		Date.prototype.ProcDate = function () {
			var yyyy = this.getFullYear().toString();
			var mm = (this.getMonth() + 1).toString(); //
			var dd = this.getDate().toString();
			return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-'
					+ (dd[1] ? dd : "0" + dd[0]);
		};
		var toD = new Date();
		$('#txtReqDate').val(toD.ProcDate());
		
		if (toD.getMonth() == 0) {
			var fromD = new Date(toD.getFullYear() - 1, 11, toD.getDate());
		} else {
			var fromD = new Date(toD.getFullYear(), toD.getMonth() - monthGap,
					toD.getDate());
		}
		$('#txtFromDate').val(fromD.ProcDate());
	}
	
	
	/* 검색 이벤트 - 준성(기안일자 추가) */
	function fnHistoryListSearch(){
		var param = {};
        param.expendStatCode = $('#selExpendStatCode').val();
		param.frDt = $('#txtFromDate').val();
		param.toDt = $('#txtToDate').val();
		param.docTitle = '';
		param.docNo = '';
		
		param.DocSelect = $('#DocSelect').val();
		if(param.DocSelect == 'txtDocTitle'){
			 param.docTitle = $('#txtDoc').val();
		}else if (param.DocSelect == 'txtDocNo'){
			param.docNo = $('#txtDoc').val();
		}
       
	
		/*	
		param.docNo = $('#txtDocNo').val();
        param.docTitle = $('#txtDocTitle').val();
 		param.frDt = $('#txtFromDate').val().replace(/-/gi,'');
		param.toDt = $('#txtToDate').val().replace(/-/gi,''); */
		     
        param.formSeq = formSeq;
        
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/user/ExExpendHistoryListSelect.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	fnHistoryListGrid(data.aaData);
            },
            error : function( data ) {
                console.log("! [EX][LISTGRID] ERROR - " + JSON.stringify(data));
            }
        });
	}
	/* List 표시 */
	function fnHistoryListGrid(data){
		$('#tblExpendHistory').dataTable({
            "select" : true,
            "paging" : true,
            "bAutoWidth" : false,
            "scrollX" : false,
            "scrollY" : '390px',
            "scrollCollapse" : true,
            "bPaginate" : false,
            "bSort" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : data,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");

                $(nRow).on('dblclick', (function() {
                	// fnHistoryReflect(aData.expendSeq);
                	// 상배
                	fnHistoryReflectV2(aData.expendSeq);
                }));
                return nRow;
            },
            "columnDefs" : [
				{
					"targets" : 4,
					"data" : null,
					"render" : function(data) {
						if(data.docSts == '110'){
							return "<%=BizboxAMessage.getMessage("TX000003206", "보류")%>";
						}else if(data.docSts == '100'){
							return "<%=BizboxAMessage.getMessage("TX000002954", "반려")%>";
						}else if(data.docSts == '90'){
							return "<%=BizboxAMessage.getMessage("TX000004824", "종결")%>";
						}else if(data.docSts == '30'){
							return "<%=BizboxAMessage.getMessage("TX000000475", "진행중")%>";

						}else if(data.docSts == '20'){
							return "<%=BizboxAMessage.getMessage("TX000003024", "상신")%>";
						}else if(data.docSts == '10'){
							return "<%=BizboxAMessage.getMessage("TX000002946", "임시저장")%>";
						}else{
							return "";
						}
					}
				} ,
				{
					"targets" : 5,
					"data" : null,
					"render" : function(data) {
						return "<div class='controll_btn cen p0'>"
						+ "<button class='BtnReflect' value='"+data.expendSeq+"' onClick='fnHistoryReflectV2("+data.expendSeq+")'><%=BizboxAMessage.getMessage("TX000000423", "반영")%></button></div>";
					}
				}
			],
            "aoColumns" : [
				{
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000000663", "문서번호")%>",
					"mData" : "docNo",
					"bVisible" : true,
					"bSortable" : false,
					"sWidth" : "110px"
				} ,
				{
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000003457", "문서제목")%>",
					"mData" : "docTitle",
					"bVisible" : true,
					"bSortable" : false,
					"sWidth" : "240px",
					"sClass" : "le"
				} ,
				{
					"sTitle" : "${CL.ex_vendor}",
					"mData" : "partnerName",
					"bVisible" : true,
					"bSortable" : false,
					"sWidth" : "100px",
					"sClass" : "le"
				} ,
				{
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000000938", "기안일자")%>",
					"mData" : "repDt",
					"bVisible" : true,
					"bSortable" : false,
					"sWidth" : "80px"
				} ,
				{
					"sTitle" : "<%=BizboxAMessage.getMessage("TX000005832", "문서상태")%>",
				"bVisible": true,
				"bSortable": false,
				"sWidth": "80px"
			}, {
				"sTitle": "",
				"bVisible": true,
				"bSortable": false,
				"sWidth": "58px"
			} ]
		} );
	}
	
	/* 지출결의 리스트 조회 v2 프로그레스 바 사용 */
	function fnHistoryReflectV2 (expendSeq){
		if ( confirm ( "작성중인 지출결의 정보가 삭제됩니다. 진행하시겠습니까?" ) ) {
			var param = {};
			param.expendSeq = expendSeq;
			param.newExpendSeq = newExpendSeq;
			param.isSlipMode = isInsertSlipMode;
			param.formSeq = formSeq;

			/* 서버호출 */
			$.ajax ( {
				type: 'post',
				url: '<c:url value="/ex/user/expend/list/ExExpendHistoryReflectV2List.do" />',
				datatype: 'json',
				async: true,
				data: param,
				success: function ( data ) {
					if(data.resultCode == 'SUCCESS'){
						fnCallReflectFunc(data.expendListVo, data.aaData.params);
					}else{
						if(data.aaData && data.aaData.resultName) {
							alert((data.aaData.resultName || '지출결의 가져오기에 실패하였습니다.'));
						} else {
							alert('지출결의 가져오기에 실패하였습니다.');
						}
					}
				},
				error: function ( data ) {
					console.log ( "! [EX][LISTGRID] ERROR - " + JSON.stringify ( data ) );
				}
			} );
		}
	}
	
	/* 지출결의 반영 v2 프로그레스 바 사용 */
	function fnCallReflectFunc(arr, param){
    	/* 프로그레스 다이얼로그 시작 */ 
		PLP_fnShowProgressDialog({
			title : "<%=BizboxAMessage.getMessage("","지출결의 가져오기")%>"		
				, progText : "<%=BizboxAMessage.getMessage("","결의서 항목을 복사중입니다.")%>"	 
				, endText : "<%=BizboxAMessage.getMessage("","복사가 완료되었습니다.")%>"	
				, popupPageTitle : "<%=BizboxAMessage.getMessage("","결의서 복사 실패사유")%>"	
				, popupColGbn : "<%=BizboxAMessage.getMessage("","항목")%>"	
				, popupColDetail : "<%=BizboxAMessage.getMessage("TX000018764","실패사유")%>"	
			}); 
		PLP_fnSetProgressValue(0, 0, arr.length);
		/* 전표전송 재귀호출 */
		fnRecurForReflectV2(0, arr, param);
		
	}
	
	/* 지출결의 반영 v2 프로그레스 바 사용 */
    function fnRecurForReflectV2(idx, arr, param, resultData, resultCode){
    	if(idx >= arr.length){
			PLP_fnEndProgressDialog();
			isInitPage = true;
			if(resultCode == 'SUCCESS')
			window.opener.fnExpendHistoryReflect_callback ( resultData );
			return ;
		}
		var item = arr[idx++];
		param.listVo = JSON.stringify( item );
		var length = arr.length;
		$.ajax({
			type : 'post',
            url : '<c:url value="/ex/user/expend/list/ExExpendHistoryReflectV2.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
				if( data.aaData.resultCode == 'FAIL'){
					PLP_fnSetErrInfo({
						'colGbn' : idx
						, 'colDetail' : data.aaData.resultName
					});
					PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);	
				}else{
					PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
				}
				value = ( (idx * 1.0 ) / ( length * 1.0 )) * 100;
				fnRecurForReflectV2(idx, arr, param, data, data.aaData.resultCode);
			},
			error : function(e, status) { //error : function(xhr, status, error) {
				alert(status);
			}
		});
    }
	

	/* 반영 이벤트 */
	function fnHistoryReflect ( expendSeq ) {
		if ( confirm ( "작성중인 지출결의 정보가 삭제됩니다. 진행하시겠습니까?" ) ) {
			var param = {};
			param.expendSeq = expendSeq;
			param.newExpendSeq = newExpendSeq;
			param.isSlipMode = isInsertSlipMode;
			param.formSeq = formSeq;

			/* 서버호출 */
			$.ajax ( {
				type: 'post',
				url: '<c:url value="/ex/user/expend/list/ExExpendHistoryReflect.do" />',
				datatype: 'json',
				async: true,
				data: param,
				success: function ( data ) {
					if ( data && data.aaData ) {
						if ( data.aaData.resultCode == 'SUCCESS' ) {
							window.opener.fnExpendHistoryReflect_callback ( data );
						} else {
							alert ( data.aaData.resultName );
						}
					}
				},
				error: function ( data ) {
					console.log ( "! [EX][LISTGRID] ERROR - " + JSON.stringify ( data ) );
				}
			} );
		}
	}
</script>

<div class="pop_wrap" style="height: 658px">
	<div class="pop_head">
		<h1>${CL.ex_pullExpendRes} <!--지출결의 가져오기--></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>

	<div class="pop_con div_form"> 
		<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_draftDate}</dt>
				<dd>
				<input id="txtFromDate" value="" class="dpWid datepicker" /> ~ <input id="txtToDate" value="" class="dpWid datepicker" />
				</dd>
				
		
				<dd>
				<select id="DocSelect" class ="selectmenu" style="width:120px;">
				<option  value="txtDocTitle"><%=BizboxAMessage.getMessage( "TX000003457", "문서제목" )%></option>
				<option  value="txtDocNo"><%=BizboxAMessage.getMessage( "TX000000663", "문서번호" )%></option>
				</select>
				<input id="txtDoc" type="text" style="width: 160px;ime-mode:active" value="" />
				</dd>
				<dt style="margin-right: 3px; margin-left: 3px;"><%=BizboxAMessage.getMessage( "TX000005832", "문서상태" )%></dt>
				<dd>
					<select class="selectmenu" style="width: 60px;" id="selExpendStatCode">
					</select> 
				</dd>

				<dd>
					<div class="controll_btn p0">
						<button id="btnHistorySearch" class="btn_sc_add">${CL.ex_search}</button>
					</div>
				</dd>
			</dl>
			
		</div>
		<div style="margin-top:10px;">
			<span>※ 이미 결의한 카드나 세금계산서 건은 반영되지 않습니다.</span>
		</div>
		<!-- 테이블 -->
		<div class="com_ta2 mt14">
			<table id="tblExpendHistory">
			</table>
		</div>

	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<button id="btnCancel" class="gray_btn">${CL.ex_cancel}</button>
		</div>
	</div>
	<!-- //pop_foot -->

</div>
<!--// pop_wrap -->
