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
	    var pw = 1000;
	    var ph = 725;
	    var windowX = (screen.width - (pw))/2;
	    var windowY = (screen.height - (ph + marginY))/2 - 20;
	    window.resizeTo(pw, ph);
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
	
	/*	[그리드 출력] 그리드 출력 리스트 필터링
	-------------------------------------------------------------------- */
	function fnFilterdList(aaData){
		var filterdList = [];
		
		var txtSearchType = $("#selTxtSearchType").val();
		var searchStr = $("#txtSearchStr").val();
		var sendYn = $("#selSearchSendYN").val();
		var useYn = $("#selSearchSendYN").val();
		if(useYn == 'UN'){
			sendYn = useYn = 'N';
		}
		else if(useYn == 'N' || useYn == 'Y'){
			useYn = 'Y';
		}
		else {
			useYn = '';
		}
		
		
		for(var i = 0; i < aaData.length; i++){
			var item = aaData[i];
			
			switch(txtSearchType){
				case '0':{
					if((item.receiveName||'').indexOf(searchStr)==-1
					&&(item.partnerName||'').indexOf(searchStr)==-1
					&&(item.cardName||'').indexOf(searchStr)==-1
					&&(item.cardNum||'').indexOf(searchStr)==-1){
						continue;
					}
					break;
				}
				case '1':{
					if((item.receiveName||'').indexOf(searchStr)==-1){
						continue;
					}
					break;
				}
				case '2':{
					if((item.partnerName||'').indexOf(searchStr)==-1){
						continue;
					}
					break;
				}
				case '3':{
					if((item.cardName||'').indexOf(searchStr)==-1){
						continue;
					}
					break;
				}
				case '4':{
					if((item.cardNum||'').indexOf(searchStr)==-1){
						continue;
					}
					break;
				}
			}
			
			/* 결의상태 체크 */
			if( (item.sendYn || 'N') .indexOf(sendYn) == -1){
				continue;
			}
			
			/* 사용여부 체크 */
			if( (item.useYn || 'Y') .indexOf(useYn) == -1){
				continue;
			}
			
			
			filterdList.push(item);
		}
		console.log('function fnFilterdList(aaData) RESULT : ');
		return filterdList;
	}
	
	/* 카드 이관 내역 조회 */
	function fnTransferHistorySelect(){
		var param = {};
		/* 조회 검색조건 */
		param.dateSearchType = $("#selDateSearchType").val();
		param.searchFromDate = $("#txtFromDate").val().toString().replace(/-/g, '');
		param.searchToDate = $("#txtToDate").val().toString().replace(/-/g, '');
		

		if($("#selSearchSendYN").val() == 'UN') {
			/* 미사용 건 조회 */
			param.searchSendYN = "";
			param.searchUseYN = "N";
		} else if ($("#selSearchSendYN").val() == 'N'){
			/* 미결의 건 조회 */
			param.searchSendYN = 'N';
			param.searchUseYN = 'Y';
		} else if ($("#selSearchSendYN").val() == 'Y') {
			/* 결의 건 조회 */
			param.searchSendYN = 'Y';
			param.searchUseYN = 'Y';
		} else {
			/* 전체 필터 조회 */
			param.searchSendYN = '';
			param.searchUseYN = '';
		}
		
		if(!param){
			return;
		}
		/* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/np/admin/NPAdminCardTransHistoryList.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	$("#all_chk").prop("checked",false);
        		fnAllChk('tblUserETaxReport');
            	if(data.result.resultCode == 'SUCCESS'){
            		/* ExCommonReport.js 포함 */
            		gridDataList = fnFilterdList(data.result.aaData);
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
		colGroup += '<col width="140" />';
		colGroup += '<col width="80" />';
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
				var cardNum = data[i].cardNum.length==16?data[i].cardNum.substring(0,4) + '-' + data[i].cardNum.substring(4,8) + '-' + data[i].cardNum.substring(8,12) + '-' +data[i].cardNum.substring(12,16):data[i].cardNum;
				if(data[i].sendYn == 'Y'){
					disabledYN = ' disabled="disabled"';
				}else {
					disabledYN = '';
				}
				if(data[i].receiveType == '1'){
					transfer = '<img src="../../../Images/ico/received_arr.png" alt="" />' + data[i].transferName;
					disabledYN = 'disabled="disabled"';
				}else if(data[i].receiveType == '0'){
					transfer = '<img src="../../../Images/ico/send_arr.png" alt="" />' + data[i].transferName;
				}
				
				$(tr).append('<td><input type="checkbox" id="chk_'+data[i].syncId+'"' + disabledYN +' />' + '</td>');
				$(tr).append('<td class="ce">' + data[i].transDate + '</td>');
				$(tr).append('<td class="ce">' + data[i].receiveName + '</td>');
				$(tr).append('<td class="ce">' + transfer  + '</td>');	
				$(tr).append('<td class="ce">' + data[i].authDate + '</td>');
				$(tr).append('<td class="le">' + data[i].partnerName + '</td>');
				$(tr).append('<td class="ce">' + (data[i].cardName || '')  + '</td>');
				$(tr).append('<td class="ce">' + cardNum+ '</td>');
				$(tr).append('<td class="ri">' + data[i].reqAmt.toString().replace( /\B(?=(\d{3})+(?!\d))/g, ',') + '</td>');
				
				/* 미사용 처리 */
				if((data[i].useYn || 'Y') == 'N'){
					$(tr).append('<td class="ce" style="color: red;">${CL.ex_notUse}</td>');
				} else {				
					/* 미결의 처리 */
					if(data[i].sendYn == 'Y'){
						$(tr).append('<td class="ce" style="color: blue;">${CL.ex_res}</td>');	
					}else{
						$(tr).append('<td class="ce">${CL.ex_noRes}</td>');
					}
				}
				$(tr).data('data', data[i]);
				
				$("#tblTransfer").append(tr);
				
				if(++showDataLength == $("#selViewLength").val()){
					break;
				}
			}
		}
	}
	
	/* 세금계산서 이관 내역 조회 */
	function fnTransferCancel(){
		var chkCardTransItems = [];
		$.each($("input:checkbox:checked").not('#all_chk'),function(idx, chk){
			var chkCard = $(chk).parent().parent().data('data');
			chkCard.interfaceType = 'card';
			chkCardTransItems.push(chkCard);
		});
		
		for(var i = 0 ; i < chkCardTransItems.length ; i ++){
			var param = {};
			param.interfaceType = chkCardTransItems[i].interfaceType;
			param.syncId = chkCardTransItems[i].syncId;
			
			if(!param){
				return;
			}
			
			$.ajax({
	            type : 'post',
	            url : '<c:url value="/ex/user/report/ExUserInterfaceTransferCancel.do" />',
	            datatype : 'json',
	            async : false,
	            data : param,
	            error : function( data ) {
	                console.log("! [EX] ERROR - " + JSON.stringify(data));
	            }
	        });
		}
		
		if(chkCardTransItems.length > 0){
			alert("이관취소가 완료되었습니다.");
		}
		
    	$("#btnSearch").click();
    	
    	if(opener.$('#btnSearch')) {
    		opener.$('#btnSearch').click();
    	}
	}
</script>
<div class="pop_wrap">
	<div class="pop_sign_head posi_re">
		<h1>${CL.ex_cardUseList_transManage}  <!--카드사용내역 이관관리--></h1>
<!-- 		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a> -->
	</div>

	<div class="pop_con">
		<div class="top_box">
			<dl>
				<dd class="ml20">
					<select class="selectmenu" id="selDateSearchType" style="width: 100px;">
						<option value="0" selected="selected">${CL.ex_transDate}  <!--이관일자--></option>
						<option value="1">${CL.ex_dateOfApproval}  <!--사용일자--></option>
					</select>
				</dd>
				<dd>
					<div class="dal_div">
						<input type="text" autocomplete="off" id="txtFromDate" value="" class="w113" /> 
						<a href="#n" id="btnFromDate" class="button_dal"></a>
					</div>
					~
					<div class="dal_div">
						<input type="text" autocomplete="off" id="txtToDate" value="" class="w113" /> 
						<a href="#n" id="btnToDate" class="button_dal"></a>
					</div>
				</dd>
				<dd class="ml20">
					<select class="selectmenu" id="selTxtSearchType" style="width: 100px;">
						<option value="0" selected="selected">${CL.ex_all}  <!--전체--></option>
						<option value="1">${CL.ex_recipient}  <!--대상자--></option>
						<option value="2">${CL.ex_useArea}  <!--사용처--></option>
						<option value="3">${CL.ex_cardNm}  <!--카드명--></option>
						<option value="4">${CL.ex_cardNumber}  <!--카드번호--></option>
					</select>
				</dd>
				<dd>
					<input type="text" autocomplete="off" id="txtSearchStr" style="width: 186px;" />
				</dd>
				<dt>${CL.ex_category}  <!--구분--></dt>
				<dd>
					<select class="selectmenu" id="selSearchSendYN" style="width: 100px;">
						<option value="">${CL.ex_all}  <!--전체--></option>
						<option value="Y">${CL.ex_res}  <!--결의--></option>
						<option value="N">${CL.ex_noRes}  <!--미결의--></option>
					</select>
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="${CL.ex_search}" />  <!--검색-->
				</dd>
			</dl>
		</div>

		<div class="btn_div cl">
			<div class="left_div fwb mt5">
				${CL.ex_yeCount} <span id="valTotalCount">0</span> ${CL.ex_gun}
			</div>
			<div class="right_div">

				<div class="controll_btn p0">
					<button id="btnTransferCancel">${CL.ex_transCancel}  <!--이관취소--></button>
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
					<col width="140" />
					<col width="80" />
					<col width="" />
				</colgroup>
				<thead>
					<tr>
						<th><input type="checkbox" id="all_chk" name="all_chk" onclick="fnAllChk('tblTransfer');"></th>
						<th>${CL.ex_transDate}  <!--이관일자--></th>
						<th>${CL.ex_recipient}  <!--대상자--></th>
						<th>${CL.ex_division}  <!--구분--></th>
						<th>${CL.ex_approvalDate}  <!--승인일자--></th>
						<th>${CL.ex_useArea}  <!--사용처--></th>
						<th>${CL.ex_cardNm}  <!--카드명--></th>
						<th>${CL.ex_cardNumber}  <!--카드번호--></th>
						<th>${CL.ex_amount}  <!--금액--></th>
						<th>${CL.ex_resCondition}  <!--결의상태--></th>
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
				<span class="pre"><a href="javascript:fnMovePage(currentPage-1)">${CL.ex_before}  <!--이전--></a></span>
				<ol id="paging">
				</ol>
				<span class="nex"><a href="javascript:fnMovePage(currentPage+1)">${CL.ex_after}  <!--다음--></a></span>
			</div>
			
			<div id="" class="gt_count">
				<select class="selectmenu up" style="width:100px;" id="selViewLength"><!-- 공통코드 처리 필요 -->
					<option value="10">${CL.ex_10view}  <!--10건 보기--></option>
					<option value="20">${CL.ex_20view}  <!--20건 보기--></option>
					<option value="30">${CL.ex_30view}  <!--30건 보기--></option>
					<option value="40">${CL.ex_40view}  <!--40건 보기--></option>
					<option value="50">${CL.ex_50view}  <!--50건 보기--></option>
				</select>
			</div>
		</div>
		<!--// gt_paging -->
	</div>
	<!--// pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
<!-- 			<input type="button" value="저장" />  -->
			<input type="button" id="btnClose" class="gray_btn" value="${CL.ex_cancel}" />  <!--취소-->
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!--// pop_wrap -->
