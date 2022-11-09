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

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<script src='${pageContext.request.contextPath}/js/ex/underscore.js'></script>
	
<script>
	var fiEaType = "${fiEaType}";
	
	$(document).ready(function(){
		fnInitPopupSize();
		fnInit();
		$("#btnSearch").click();
	});
	
	function fnInitPopupSize(){
		var marginY = 0;
	    // 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
	    if (navigator.userAgent.indexOf("MSIE 6") > 0){        // IE 6.x
	    	marginY = 45;
    	}
	    else if(navigator.userAgent.indexOf("MSIE 7") > 0){    // IE 7.x
	    	marginY = 75;
	    }
	    else if(navigator.userAgent.indexOf("Firefox") > 0){	// FF
	    	marginY = 50;
	    }
	    else if(navigator.userAgent.indexOf("Opera") > 0){     // Opera
	    	marginY = 30;
	    }
	    else if(navigator.userAgent.indexOf("Netscape") > 0){  // Netscape
	    	marginY = -2;
	    }

	    // 센터 정렬
	    var windowX = (screen.width - (1010))/2;
	    var windowY = (screen.height - (698 + marginY))/2 - 20;
	    window.resizeTo(1000, 710);
	    window.moveTo(windowX,windowY);
	}
	
	/* 초기화 */
	function fnInit(){
		fnInitInput();
		fnInitButton();
		fnInitKeyEvent();
	}
	
	/* input 설정 */
	function fnInitInput(){
		fnSetDatepicker("#txtFromDate, #txtToDate","yy-mm-dd");
		var toD = new Date();
		if (toD.getMonth() == 0) {
			var fromD = new Date(toD.getFullYear() - 1, 11, toD.getDate());
		} else {
			var fromD = new Date(toD.getFullYear(), toD.getMonth() - 1,	toD.getDate());
		}
		var fMonth = (fromD.getMonth() + 1);
		var tMonth = (toD.getMonth() + 1);
		var fDay = fromD.getDate();
		var tDay = toD.getDate();
		if(fMonth < 10){
			fMonth = "0" + fMonth;
		}
		if(tMonth < 10){
			tMonth = "0" + tMonth;
		}
		if(fDay < 10){
			fDay = "0" + fDay;
		}
		if(tDay < 10){
			tDay = "0" + tDay;
		}
		$("#txtFromDate").val(fromD.getFullYear() +"-" + fMonth +"-"+fDay);
		$("#txtToDate").val(toD.getFullYear() +"-" + tMonth +"-"+tDay);
	}
	
	/* 버튼 이벤트 설정 */
	function fnInitButton(){
		$("#btnSearch").on("click", function(){
			fnTransferHistorySelect();
		});
		
		$("#btnTransferCancel").on("click", function(){
			fnTransferCancel();
		});
		
		$("#btnClose").on("click", function(){
			self.close();
		});
	}
	
	/* 키 이벤트 설정 */
	function fnInitKeyEvent(){
		$("input[type=text]").keydown(function(){
            if (event.keyCode === 13) {
                $('#btnSearch').click();
            }
		});
		
		$("#txtFromDate, #txtToDate").keyup(function(e){
			if( ( 48 <= e.keyCode && e.keyCode <= 57 ) || (  96 <= e.keyCode && e.keyCode <= 105  ) ){
				var dataLength = $("#" + $(this).prop("id")).val().length;
				if( dataLength == 4 || dataLength == 7 ){
					$("#" + $(this).prop("id")).val($("#" + $(this).prop("id")).val() + "-");
				}	
			}else if( e.keyCode == 13){
				$("#btnSearch").click();
			}
		});
	}
	
	/* 세금계산서 이관 내역 조회 */
	function fnTransferHistorySelect(){
		var param = {};
		/* 조회 검색조건 */
		param.dateSearchType = $("#selDateSearchType").val();
		param.searchFromDate = $("#txtFromDate").val().toString().replace(/-/g, '');
		param.searchToDate = $("#txtToDate").val().toString().replace(/-/g, '');
		param.txtSearchType = $("#selTxtSearchType").val();
		param.searchStr = $("#txtSearchStr").val();
		param.searchSendYN = $("#selSearchSendYN").val();
		param.fiEaType = fiEaType;
		
		if(!param){
			return;
		}
		/* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/report/ExUserInterfaceTransferHistory.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	$("#all_chk").prop("checked",false);
        		fnAllChk('tblUserETaxReport');
            	if(data.result.resultCode == 'SUCCESS'){
            		/* ExCommonReport.js 포함 */
            		gridDataList = data.result.aaData;
            		fnSetDefaultTable();
            	}else{
            		alert(data.result.resultName);
            		fnSetGrid([]);
            	}
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
	}
	
	/* 계산서 리스트 바인딩 */
	function fnSetGrid(data){
		$("#tblTransfer").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="34" />';
		colGroup += '<col width="100" />';
		colGroup += '<col width="60" />';
		colGroup += '<col width="80" />';
		colGroup += '<col width="100" />';
		colGroup += '<col width="170" />';
		colGroup += '<col width="100" />';
		colGroup += '<col width="120" />';
		colGroup += '<col width="100" />';
		colGroup += '<col width="" />';
		colGroup += '</colgroup>';
		
		$("#tblTransfer").append(colGroup);
		if(pageLength == 0){
			$("#valTotalCount").text(0);
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="' + $("#tblTransfer colgroup col").length + '">${CL.ex_dataDoNotExists}</td>')
			$("#tblTransfer").append(tr);
		}else{
			var showDataLength = 0 ;
			$("#valTotalCount").text(gridDataLength);
			
			for(var i = ((currentPage * $("#selViewLength").val()) - $("#selViewLength").val()) ; i < data.length ; i ++){
				var tr = document.createElement("tr");
				var disabledYN = '';
				var transfer = '';
				
				if(data[i].sendYN == 'Y'){
					disabledYN = 'disabled="disabled"';
				}
				if(data[i].transferType == 'R'){
					transfer = '<img src="../../../Images/ico/received_arr.png" alt="" />받음';
					disabledYN = 'disabled="disabled"';
				}else if(data[i].transferType == 'T'){
					transfer = '<img src="../../../Images/ico/send_arr.png" alt="" />보냄';
				}
				
				$(tr).append('<td><input type="checkbox" id="chk_'+data[i].issNo+'_'+data[i].issDt+'_'+data[i].receiveSeq+'_'+data[i].partnerNo+'_'+data[i].sendYN+'" value="'+data[i].issNo+'_'+data[i].issDt+'_'+data[i].receiveSeq+'_'+data[i].partnerNo+'_'+data[i].sendYN+'" '+disabledYN+'/>' + '</td>');
				$(tr).append('<td class="ce">' + data[i].transferDate + '</td>');
				$(tr).append('<td class="ce">' + data[i].targerName + '</td>');
				$(tr).append('<td class="ce">' + transfer + '</td>');	
				$(tr).append('<td class="ce">' + data[i].issDt + '</td>');
				$(tr).append('<td class="le">' + data[i].partnerName + '</td>');
				$(tr).append('<td class="ce">' + data[i].partnerNo  + '</td>');
				$(tr).append('<td class="ce">' + data[i].issNo+ '</td>');
				$(tr).append('<td class="ri">' + data[i].amt.toString().replace( /\B(?=(\d{3})+(?!\d))/g, ',') + '</td>');
				if(data[i].sendYN == 'Y'){
					$(tr).append('<td class="ce">${CL.ex_requestApproval}('+data[i].userName+')</td>');	
				}else{
					$(tr).append('<td class="ce">${CL.ex_notSubmitted}</td>');
				}
				
				
				$("#tblTransfer").append(tr);
				
				if(++showDataLength == $("#selViewLength").val()){
					break;
				}
			}
		}
	}
	
	/* 세금계산서 이관 내역 조회 */
	function fnTransferCancel(){
		
		
		var selectedItems = '';
		var chkData = new Array();
		var isAllChk = false;
		$.each($("input:checkbox:checked"),function(idx,val){
			if($(this).attr("value") == 'on'){
				isAllChk = true;
				return true;
			}
			for(var i = (Number(currentPage) - 1) * Number($("#selViewLength").val()) ; i < gridDataList.length ; i++){
				if(gridDataList[i].issNo == $(this).attr("value").split('_')[0] && gridDataList[i].receiveSeq == $(this).attr("value").split('_')[2]){
					chkData.push(gridDataList[i]);
					break;
				}
			}
			
		});
		if(chkData.length == 0){
			alert("${CL.ex_thereIsNoSelectedItem}");
			return false;
		}
		
		if(!confirm("${CL.ex_transferCancelConfirm}\n${CL.ex_doYouWantToContinue}")){
			return false;
		}
		
		for(var i = 0 ; i < chkData.length ; i ++){
			var param = {};
			/* 조회 검색조건 */
			param.issNo = chkData[i].issNo;
			param.transferSeq = chkData[i].transferSeq;
			param.receiveSeq = chkData[i].receiveSeq;
			param.interfaceType = 'etax';
			if(!param){
				return;
			}
			/* 서버호출 */
	        $.ajax({
	            type : 'post',
	            url : '<c:url value="/ex/user/report/ExUserInterfaceTransferCancel.do" />',
	            datatype : 'json',
	            async : false,
	            data : param,
	            success : function( data ) {
	            	/* 이관 취소에 따른 부모창 리스트 리드  */
	            	opener.fnUserETaxListSearch();
	            	$("#btnSearch").click();
	            },
	            error : function( data ) {
	                console.log("! [EX] ERROR - " + JSON.stringify(data));
	            }
	        });
		}
		alert("${CL.ex_processcomplete}");
	}
</script>
<div class="pop_wrap_dir" style="width: 1000px;">
	<div class="pop_head">
		<h1>${CL.ex_electronicInvoice}<!--세금계산서--> ${CL.ex_transManage} <!--이관관리--></h1>
<!-- 		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a> -->
	</div>

	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dd class="ml20">
					<select class="selectmenu" id="selDateSearchType" style="width: 100px;">
						<option value="0" selected="selected">${CL.ex_theDateOfTransfer}</option>
						<option value="1">${CL.ex_dateOfUse}</option>
					</select>
				</dd>
				<dd>
					<div class="dal_div">
						<input type="text" id="txtFromDate" value="" class="w113" /> 
						<a href="#n" id="btnFromDate" class="button_dal"></a>
					</div>
					~
					<div class="dal_div">
						<input type="text" id="txtToDate" value="" class="w113" /> 
						<a href="#n" id="btnToDate" class="button_dal"></a>
					</div>
				</dd>
				<dd class="ml20">
					<select class="selectmenu" id="selTxtSearchType" style="width: 100px;">
						<option value="0" selected="selected">${CL.ex_all}</option>
						<option value="1">${CL.ex_objectPerson}</option>
						<option value="2">${CL.ex_supplier}</option>
						<option value="3">${CL.ex_registrationNumber}</option>
						<option value="4">${CL.ex_confirmationNumber}</option>
					</select>
				</dd>
				<dd>
					<input type="text" id="txtSearchStr" style="width: 186px;" />
				</dd>
				<dt>구분</dt>
				<dd>
					<select class="selectmenu" id="selSearchSendYN" style="width: 100px;">
						<option value="N" selected="selected">${CL.ex_notSubmitted}</option>
						<option value="Y">${CL.ex_requestApproval}</option>
						<option value="">${CL.ex_all}</option>
					</select>
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="검색" />
				</dd>
			</dl>
		</div>

		<div class="btn_div cl">
			<div class="left_div fwb mt5">
				총 <span id="valTotalCount">0</span> 건
			</div>
			<div class="right_div">

				<div class="controll_btn p0">
					<button id="btnTransferCancel">${CL.ex_transCancel}</button> <!--이관취소-->
				</div>
			</div>
		</div>

		<div class="com_ta2 sc_head">
			<table>
				<colgroup>
					<col width="34" />
					<col width="100" />
					<col width="60" />
					<col width="80" />
					<col width="100" />
					<col width="170" />
					<col width="100" />
					<col width="120" />
					<col width="100" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_chk" name="all_chk" onclick="fnAllChk('tblTransfer');"></th>
						<th>${CL.ex_theDateOfTransfer}</th>
						<th>${CL.ex_objectPerson}</th>
						<th>${CL.ex_category}</th>
						<th>${CL.ex_requestApproval}</th>
						<th>${CL.ex_supplier}</th>
						<th>${CL.ex_corporateRegistrationNumber}</th>
						<th>${CL.ex_confirmationNumber}</th>
						<th>${CL.ex_amount}</th>
						<th>${CL.ex_processStatus}</th>
					</tr>
				</thead>
			</table>
		</div>

		<div class="com_ta2 ova_sc2 cursor_p bg_lightgray" style="height: 330px;">
			<table id="tblTransfer">
				<colgroup>
					<col width="34" />
					<col width="100" />
					<col width="60" />
					<col width="80" />
					<col width="100" />
					<col width="170" />
					<col width="100" />
					<col width="120" />
					<col width="100" />
					<col width="" />
				</colgroup>
				<tbody>
				</tbody>
			</table>
		</div>

		<div class="gt_paging">
			<div class="paging">
				<span class="pre"><a href="javascript:fnMovePage(currentPage-1)">${CL.ex_privious}</a></span>
				<ol id="paging">
				</ol>
				<span class="nex"><a href="javascript:fnMovePage(currentPage+1)">${CL.ex_next}</a></span>
			</div>
			
			<div id="" class="gt_count">
				<select class="selectmenu up" style="width:100px;" id="selViewLength"><!-- 공통코드 처리 필요 -->
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
				</select>
			</div>
		</div>
		<!--// gt_paging -->
	</div>
	<!--// pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
<!-- 			<input type="button" value="저장" />  -->
			<input type="button" id="btnClose" class="gray_btn" value="${CL.ex_popClose}" />
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!--// pop_wrap -->
