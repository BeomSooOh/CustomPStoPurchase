<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<!-- javascript - src -->
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<script src='${pageContext.request.contextPath}/js/ex/underscore.js?varsion=<fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyyMMddHH"/>'></script>
<!-- javascript -->
<script>
	/* UserCardReport var */
	var ifUseSystem = '${ifUseSystem}';
	var empInfo = {
        erpEmpSeq : "${ViewBag.empInfo.erpEmpSeq}",
        langCode : "${ViewBag.empInfo.langCode}",
        erpCompSeq : "${ViewBag.empInfo.erpCompSeq}",
        groupSeq : "${ViewBag.empInfo.groupSeq}",
        empSeq : "${ViewBag.empInfo.empSeq}",
        compSeq : "${ViewBag.empInfo.compSeq}",
        userSe : "${ViewBag.empInfo.userSe}",
        deptSeq : "${ViewBag.empInfo.deptSeq}",
        bizSeq : "${ViewBag.empInfo.bizSeq}"
    };
	/* document.ready */
	$(document).ready(function() {
		fnInit();
		fnUserETaxListSearch();
	});
	
	function fnInit(){
		fnInitDatepicker();
		fnInitButton();
		fnInitKeyEvent();
		fnInitCommonOrgPop();
	}
	
	function fnInitDatepicker(){
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
		$("#txtToDate").val(toD.getFullYear() +"-" + tMonth +"-"+tDay);	}
	
	function fnInitButton(){
		$("#btnSearch").click(function(){
			fnUserETaxListSearch();
		});
		
		$("#btnUnUse").click(function(){
			fnAdminSetETaxUseYN("Y");
		});
		
		$("#btnUse").click(function(){
			fnAdminSetETaxUseYN("N");
		});
		
		$("#btnExcel").click(function(){
			fnAdminReportExcelDown();
		});
		
		$("#btnTransfer").click(function(){
			fnUserTransfer();
		});
		
		$("#btnManageTransfer").click(function(){
			fnUserManageTransfer();
		});
	}
	
	function fnInitKeyEvent(){
		$("input[type=text]").keydown(function(event){
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
	
	function fnInitCommonOrgPop(){
		$('#devMode_forCmPop').val(empInfo.groupSeq);
        $('#langCode_forCmPop').val(empInfo.langCode);
        $('#groupSeq_forCmPop').val(empInfo.groupSeq);
        $('#compSeq_forCmPop').val(empInfo.compSeq);
        $('#deptSeq_forCmPop').val(empInfo.deptSeq);
        $('#empSeq_forCmPop').val(empInfo.empSeq);
        
        $('#compFilter_forCmPop').val("${ViewBag.empInfo.compSeq}");
        $('#selectedItems_forCmPop').val("");
	}
	
	/* ????????????????????? ?????? ?????? */
	function fnUserETaxListSearch() {
		var param = {};
		param.searchFromDt = $("#txtFromDate").val().toString().replace(/-/g, '');
		param.searchToDt = $("#txtToDate").val().toString().replace(/-/g, '');
		param.issNo = $("#txtIssNo").val();
		param.partnerName = $("#txtPartnerName").val();
		param.partnerNo = $("#txtPartnerNo").val().toString().replace(/-/g, '');
		param.docuSt = $("#selSendType").val();
		param.emailDc = $("#txtEmailAddress").val();
		
		if(!param){
			return;
		}
		/* ???????????? */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/report/ExTaxReportList.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	if(data.result.resultCode == 'SUCCESS'){
            		$("#all_chk").prop("checked",false);
            		fnAllChk('tblUserETaxReport');
            		fnSetEtaxData(_.groupBy(_.sortBy(data.result.aaData,"issDt"),"issNo"));
            		/* ExCommonReport.js ?????? */
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
	
	/* ????????? ????????? ?????? */
	function fnSetEtaxData(data){
		gridDataList = [];
		var rowNum = 1;
		$.each(data,function(idx, val){
			/* ???????????? ???????????? ???????????? ?????? ?????? */
			if(val[0].trregNb === undefined){
				return true;
			}
			
			/* ????????? ?????? ?????? ??????(iCUBE?????? ?????? ??? ?????? ????????? ????????? ????????? ????????? ?????? ??????) */
			if( $("#txtUserName").val() != '' ){
				if( val.length > 1 ){ 
					if( val[1].empName.indexOf( $("#txtUserName").val( ) ) == -1 ){
						return true;
					}
				}else{
					if(val[0].adocuYN == '1'){
						if( 'ERP ?????? ???'.indexOf( $("#txtUserName").val( ) ) == -1 ){
							return true;
						}
					}else{
						return true;
					}
				}
			}
			
			/* ???????????? ???????????? */
			/* adocuYN ( 0 : ?????????, 1 : ?????? ) */
			var tEtaxData = {};
			switch( $("#selSendType").val() ){
				case "2" : /* ?????? */
					if( val.length > 1 && val[1].sendYN == 'Y' && val[1].ifMId != 'D' ){
						tEtaxData.ifMId = (val[1].ifMId || '');
						tEtaxData.empName = ( val[1].empName || '');
						tEtaxData.sendType = '??????';
					}else if( val.length == 1 && val[0].adocuYN == '1' ){  
						tEtaxData.ifMId = '';
						tEtaxData.empName = 'ERP ?????? ???';
						tEtaxData.sendType = '??????';
					}else if (val[0].adocuYN == '1' && val[1].sendYN == 'N'){
						tEtaxData.ifMId = '';
						tEtaxData.empName = 'ERP ?????? ???';
						tEtaxData.sendType = '??????';
					}
					else{ return true; }
					break;
				case "1" : /* ????????? */
					if( ( val.length == 1 && val[0].adocuYN == '0' ) || ( val.length > 1 && val[1].sendYN == 'N' && val[0].adocuYN == '0' && val[1].ifMId != 'D'  ) ){
						tEtaxData.sendType = '?????????';
						tEtaxData.empName='';
					}else{
						return true;
					}
					break;
				case "D" : /* ????????? */
					if( val.length == 1 || val[1].ifMId != 'D'){ return true; }
					else{
						tEtaxData.sendType = '?????????';
						tEtaxData.empName='';
					}
					break;
				default :
					if( val.length > 1 ){
						if(val[1].ifMId == 'D'){
							tEtaxData.ifMId = ''
							tEtaxData.sendType = '?????????';
							tEtaxData.empName='';	
						}else if(val[1].sendYN == 'Y'){
							tEtaxData.ifMId = (val[1].ifMId || '');
							tEtaxData.empName = (val[1].empName || '');
							tEtaxData.sendType = '??????';
						}else if (val[0].adocuYN == '1' && val[1].sendYN == 'N'){
							tEtaxData.ifMId = '';
							tEtaxData.empName = 'ERP ?????? ???';
							tEtaxData.sendType = '??????';
						}else{
							tEtaxData.ifMId = ''
							tEtaxData.sendType = '?????????';
							tEtaxData.empName='';
						}
					}else if( val.length == 1 && val[0].adocuYN == '1' ){
						tEtaxData.ifMId = '';
						tEtaxData.empName = 'ERP ?????? ???';
						tEtaxData.sendType = '??????';
					}else{
						tEtaxData.ifMId = ''
						tEtaxData.sendType = '?????????';
						tEtaxData.empName='';
					}
					break;
			}
			
			tEtaxData.rowNum = rowNum++;
			tEtaxData.issNo = val[0].issNo; //???????????? 
			tEtaxData.issDt = val[0].issDt.toString().replace( /^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3'); //????????????
			tEtaxData.divNm = val[0].divNm; // ?????????
			tEtaxData.trNm = val[0].trNm; // ????????????
			tEtaxData.trregNb = val[0].trregNb.toString().replace( /^(\d{3})(\d{2})(\d{5})$/, '$1-$2-$3'); //???????????????
			tEtaxData.trchargeEmail = val[0].trchargeEmail; //??????????????? ?????????
			tEtaxData.sumAm = val[0].sumAm.toString().replace( /\B(?=(\d{3})+(?!\d))/g, ','); //????????????
			tEtaxData.supAm = val[0].supAm.toString().replace( /\B(?=(\d{3})+(?!\d))/g, ','); //????????????
			tEtaxData.vatAm = val[0].vatAm.toString().replace( /\B(?=(\d{3})+(?!\d))/g, ','); //??????
			if(val.length > 1){
				tEtaxData.transferType = val[1].transferType;
				tEtaxData.transferSeq = val[1].transferSeq;	//?????? ??? ?????? ??????
				tEtaxData.transferName = val[1].transferName; //?????? ??? ?????? ??????	
				tEtaxData.receiveSeq = val[1].receiveSeq; //?????? ?????? ?????? ??????	
				tEtaxData.receiveName = val[1].receiveName;	//?????? ?????? ?????? ??????
			}else{
				tEtaxData.transferType = '';	
				tEtaxData.transferSeq = '';	
				tEtaxData.transferName = ''; 
				tEtaxData.receiveSeq = ''; 
				tEtaxData.receiveName = ''; 
			}
			tEtaxData.dummy1 = val[0].dummy1; //??????
			
			gridDataList.push(tEtaxData);
		});
	}
	
	/* ????????? ????????? ????????? */
	function fnSetGrid(data){
		$("#tblUserETaxReport").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="34"/>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width="190"/>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width="150"/>';
		colGroup += '<col width="160"/>';
		colGroup += '<col width="80"/>';
		colGroup += '<col width="80"/>';
		colGroup += '<col width="80"/>';
		colGroup += '<col width="80"/>';
		colGroup += '<col width="80"/>';
		colGroup += '<col width="290"/>';
		colGroup += '</colgroup>';
		$("#tblUserETaxReport").append(colGroup);
		if(pageLength == 0){
			$("#valTotalCount").text(0);
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="' + $("#tblUserETaxReport colgroup col").length + '">???????????? ????????????. iCUBE [??????????????????????????????????????????]???????????? [???????????????????????????]??? ??????????????? ????????????.</td>')
			$("#tblUserETaxReport").append(tr);
		}else{
			var showDataLength = 0 ;
			$("#valTotalCount").text(gridDataLength);
			
			$.each(data,function(idx, val){
				if( (( currentPage - 1) * $("#selViewLength").val()) < val.rowNum && val.rowNum <= (currentPage * $("#selViewLength").val())){
					var tr = document.createElement("tr");
					var disabledYN = '';
					var transfer = '';
					if(val.sendType =='??????'){
						disabledYN = 'disabled="disabled"';
					}
					if(val.transferType == 'R'){
						transfer += '[' + val.transferName;
						transfer += '<img src="../../../Images/ico/received_arr.png" alt="" />';
						transfer += val.receiveName + ']';
						disabledYN = 'disabled="disabled"';
					}else if(val.transferType == 'T'){
						transfer += '[' + val.receiveName;
						transfer += '<img src="../../../Images/ico/send_arr.png" alt="" />';
						transfer += val.transferName + ']';
						disabledYN = 'disabled="disabled"';
					}
					
					$(tr).append('<td><input type="checkbox" id="chk_'+val.issNo+'_'+val.issDt+'_'+val.trregNb+'_'+val.sendType+'" value="'+val.issNo+'_'+val.issDt+'_'+val.trregNb+'_'+val.sendType+'" '+disabledYN+'/>' + '</td>');
					$(tr).append('<td class="ce">' + val.issDt + '</td>');
					$(tr).append('<td class="ce">' + val.divNm + '</td>'); /* ????????? */
					$(tr).append('<td class="le">' + transfer + val.trNm + '</td>');
					$(tr).append('<td class="ce">' + val.trregNb + '</td>');
					$(tr).append('<td class="ce">' + '<a class="text_blue etaxPop" style="text-decoration:underline;cursor:pointer;" title="???????????? ?????? ????????? ?????? ????????????">' + val.issNo + '</a>' + '</td>');
					$(tr).append('<td class="ce">' + val.trchargeEmail  + '</td>');
					$(tr).append('<td class="ri">' + val.sumAm+ '</td>');
					$(tr).append('<td class="ri">' + val.supAm+ '</td>');
					$(tr).append('<td class="ri">' + val.vatAm+ '</td>');
					if(val.sendType == '?????????'){
						$(tr).append('<td class="ce text_red">' + val.sendType + '</td>');	
					}else{
						$(tr).append('<td class="ce">' + val.sendType + '</td>');
					}
					
					$(tr).append('<td class="ce">' + val.empName + '</td>');	
					$(tr).append('<td class="le">' + val.dummy1 + '</td>');	
					$(tr).find('.etaxPop').click(function(){
						var popup = window.open("../../../expend/np/user/UserETaxDetailPop.do?syncId=" + val.issNo, "", "width=900, height=520 , scrollbars=yes");
					});
					
					$("#tblUserETaxReport").append(tr);
					
					if(++showDataLength == $("#selViewLength").val()){
						return false;
					}
				}
			});
		}
	}
	
	 /* ?????? ???????????? */
	function fnAdminReportExcelDown() {
		if( !gridDataList || gridDataList.length == undefined || gridDataList.length == 0){
			alert("???????????? ????????????.");
			return false;
		}
    	/* ????????????  */
		$("#fileName").val( "?????????????????????" );
		/* Excel ?????? ?????? */
		var excelHeader = {};
		excelHeader.issDt = '????????????';
		excelHeader.divNm =  '${CL.ex_workplace}'; /* ????????? */
		excelHeader.trNm =  '?????????';
		excelHeader.trregNb =  '?????????????????????';
		excelHeader.issNo =  '????????????';
		excelHeader.trchargeEmail =  '????????????';
		excelHeader.sumAm =  '??????';
		excelHeader.supAm =  '????????????';
		excelHeader.vatAm =  '?????????';
		excelHeader.sendType =  '????????????';
		excelHeader.empName =  '?????????';
		excelHeader.dummy1 =  '??????';
		$("#excelHeader").val( JSON.stringify(excelHeader) );
		$("#tableData").val( JSON.stringify(gridDataList) );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
	 
	/* ??????????????? ?????? ??????/????????? ?????? */
	function fnAdminSetETaxUseYN(ynType){
		/* ynType ( Y : ?????????, N : ??????) */
		var chkSels = new Array();
		var isSuccess = true;
		$.each($("input:checkbox:checked"),function(idx,val){
			if($(this).attr("value") == 'on'){
				return true;
			}
			chkSels.push($(this).attr("value")); 
		});
		
		if(chkSels.length == 0){
			alert("????????? ????????? ??????????????????.");
		}
		/* ynType ( Y : ?????????, N : ??????) */
		for(var i = 0 ; i <chkSels.length ; i++){
			if( (ynType == 'Y' && chkSels[i].split('_')[3] == '?????????') || (ynType == 'N' && chkSels[i].split('_')[3] != '?????????')){
				continue;
			}
			var param = {};
			param.issNo = chkSels[i].split('_')[0];
			param.issDt = chkSels[i].split('_')[1].replace(/-/g,'');
			param.partnerNo = chkSels[i].split('_')[2].replace(/-/g,'');
			/*param.sendYN = ynType; ?????? ???????????? ?????? ???????????? ?????????????????? ??? */
			/* ????????? ?????????????????? ??????,  send_yn ?????? Y??? ?????? ?????????, ????????? ??? ???????????? send_yn = 'N'????????? ???????????? */
			param.sendYN = 'N';
			param.ifMId = (ynType == 'Y'?'D':'');
			/* ???????????? */
			$.ajax({
				type : 'post',
				url : '<c:url value="/ex/admin/report/ExAdminETaxSetUseYN.do" />',
				datatype : 'json',
				async : false,
				data : param,
				success : function( data ) {
					if(data.result.resultCode != 'SUCCESS'){
						isSuccess = false;
					}
				},
				error : function( data ) {
					console.log("! [EX] ERROR - " + JSON.stringify(data));
				}
			});
		}
		if(isSuccess){
			if(useYN== 'Y'){
				alert("????????? ?????????????????????.");	
			}else{
				alert("????????? ????????? ?????????????????????.");
			}	
		}
		
		$("#btnSearch").click();
	}

	/* ??????????????? ?????? */
	function fnUserTransfer(){
		var selectedItems = '';
		var chkData = new Array();
		var isAllChk = false;
		$.each($("input:checkbox:checked"),function(idx,val){
			if($(this).attr("value") == 'on'){
				isAllChk = true;
				return true;
			}
			for(var i = (Number(currentPage) - 1) * Number($("#selViewLength").val()) ; i < gridDataList.length ; i++){
				if(gridDataList[i].issNo == $(this).attr("value").split('_')[0]){
					chkData.push(gridDataList[i]);
					break;
				}
			}
			
		});
		if(chkData.length == 0 ){
			alert("?????? ??? ????????? ??????????????????");
			return false;
		}
		
		$("#hidSelectedETaxInfo").val(JSON.stringify(chkData));
		selectedItems = empInfo.groupSeq + "|" + empInfo.compSeq + "|" + empInfo.deptSeq + "|" + empInfo.empSeq + "|u";
// 		$('#selectedItems_forCmPop').val(selectedItems);
		var url = "<c:url value='/html/common/cmmOrgPop.jsp'/>";
		var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");
		
		frmPop2.target = "cmmOrgPop";
		frmPop2.method = "post";
		frmPop2.action = url;
		frmPop2.submit();
		frmPop2.target = "";
		pop.focus();
		return;
	}
	/* ??????????????? ?????? ?????? ?????? */
	function fnUserManageTransfer(){
		var url = "<c:url value='/ex/admin/report/ExAdminETaxTransferHistoryPop.do'/>";

		url += '?fiEaType=eap';
    	var popupWidth = 999;
	    var popupHeight = 698;
	    
	    var windowX = (screen.width - popupWidth)/2;
	    var windowY = (screen.height - popupHeight - 30)/2;
	    
		var win = window.open(url,"??????????????? ????????????","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);
		
        if(win== null || win.screenLeft == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018810","???????????? ???????????? ????????? ????????? ?????????")%>");
        }
	}
	
	
    /* ???????????? - ???????????? ?????? ?????? */
    function fnCallbackOrgPop( params ) {
    	var returnObj = params.returnObj;
        var length = returnObj.length;
        var showSelectedNames = '';
        var selectedItems = '';
        for (var i = 0; i < length; i++) {
            var item = returnObj[i];
            selectedItems += ',' + item.superKey;
        }
        selectedItems = selectedItems.substring(1);

        /* ?????? ????????? insert */
//         $('#selectedItems_forCmPop').val(selectedItems);
        
       	var param = {};
		param.targetData = $("#hidSelectedETaxInfo").val();
		param.receiveInfo = JSON.stringify(returnObj);
		param.interfaceType = 'etax';
		/* ???????????? */
		$.ajax({
			type : 'post',
			url : '<c:url value="/ex/user/report/ExUserInterfaceTransfer.do" />',
			datatype : 'json',
			async : true,
			data : param,
			success : function( data ) {
				if(data.result.resultCode == 'SUCCESS'){
					alert("????????? ?????????????????????.");
					$("#btnSearch").click();
				}else{
					alert(data.result.resultName);
				}
			},
			error : function( data ) {
				console.log("! [EX] ERROR - " + JSON.stringify(data));
			}
		});
        return;
    }
</script>

<!-- hidden -->
<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="excelHeader" value="" id="excelHeader"/>
	<input type="hidden" name="fileName" value="" id="fileName">
	<input type="hidden" name="tableData" value="" id="tableData">
</form>
<!-- ?????? ?????? ????????? -->
<input type="hidden" id="hidSelectedETaxInfo" value="">
<!-- body -->
<div class="sub_contents_wrap">
	<!-- ??????????????? -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_writeDate} <!--????????????--></dt>
			<dd>
				<div class="dal_div">
					<input type="text" id="txtFromDate" value="" class="w113 enter" />
					<a href="#n" id="btnFromDate" class="button_dal"></a>
				</div>
				~
				<div class="dal_div"> 
					<input type="text" id="txtToDate" value="" class="w113 enter" />
					<a href="#n" id="btnToDate" class="button_dal"></a>
				</div>
			</dd>
			<dt>${CL.ex_supplyer} <!--?????????--></dt>
				<dd>
					<input type="text" id="txtPartnerName" style="width:186px;" />
				</dd>
			<dt>${CL.ex_resCondition} <!--????????????--></dt>
			<dd>
				<select id="selSendType" class="selectmenu" style="width:100px;">
					<option value="0" selected="selected">${CL.ex_all} <!--??????--></option>
					<option value="2">${CL.ex_res} <!--??????--></option>
					<option value="1">${CL.ex_noRes} <!--?????????--></option>
					<option value="D">${CL.ex_noUser} <!--?????????--></option>
				</select>
			</dd>
			<dd>
				<input type="button" id="btnSearch" value="${CL.ex_search}" /> <!--??????-->
			</dd>
		</dl>
		<span class="btn_Detail">${CL.ex_detailSearch} <!--????????????--> <img id="all_menu_btn" src='../../../Images/ico/ico_btn_arr_down01.png' /></span>
	</div>
	<!-- ?????????????????? -->
	<div class="SearchDetail">
		<dl>	
			<dt>${CL.ex_corporateRegiNum} <!--?????????????????????--></dt>
			<dd><input type="text" id="txtPartnerNo" style="width:150px;" /></dd>
			<dt style="width:70px;">${CL.ex_confirmationNumber} <!--????????????--></dt>
			<dd><input type="text" id="txtIssNo" style="width:150px;" /></dd>
			<dt style="width:70px;">${CL.ex_MailAddress} <!--????????????--></dt>
			<dd><input type="text" id="txtEmailAddress" style="width:150px;" /></dd>
			<dt style="width:70px;">${CL.ex_resPerson} <!--?????????--></dt>
			<dd><input type="text" id="txtUserName" style="width:150px;" /></dd>									
		</dl>
	</div>
	
	<!-- ?????? -->
	<div class="btn_div cl">
		<div class="left_div fwb mt5">
		??? <span id="valTotalCount">0</span> ???
		</div>
		<div class="right_div">							
			<div class="controll_btn p0">
				<button id="btnTransfer">${CL.ex_calcTrans} <!--???????????????--></button>
				<button id="btnManageTransfer">${CL.ex_transManage} <!--????????????--></button>
				<button id="btnUnUse">${CL.ex_noUser} <!--?????????--></button>
				<button id="btnUse">${CL.ex_noUserClear} <!--???????????????--></button>
				<button id="btnExcel">${CL.ex_excelDown} <!--??????????????????--></button>
			</div>
		</div>
	</div>
	
	<div style="overflow: auto;">
		<div class="com_ta2">
			<table>
				<colgroup>
					<col width="34"/>
					<col width="100"/>
					<col width="100"/>
					<col width="190"/>
					<col width="100"/>
					<col width="150"/>
					<col width="160"/>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
					<col width="290"/>
				</colgroup>
				<tr>
					<th><input type="checkbox" id="all_chk" name="all_chk" onclick="fnAllChk('tblUserETaxReport');"></th>
					<th>${CL.ex_writeDate} <!--????????????--></th>
					<th>${CL.ex_workplace} <!--?????????--></th>
					<th>${CL.ex_supplyer} <!--?????????--></th>
					<th>${CL.ex_corporateRegiNum} <!--?????????????????????--></th>
					<th>${CL.ex_confirmationNumber} <!--????????????--></th>
					<th>${CL.ex_MailAddress} <!--????????????--></th>
					<th>${CL.ex_amount} <!--??????--></th>
					<th>${CL.ex_purPrice} <!--????????????--></th>
					<th>${CL.ex_vat} <!--?????????--></th>
					<th>${CL.ex_resCondition} <!--????????????--></th>
					<th>${CL.ex_resPerson} <!--?????????--></th>
					<th>${CL.ex_note2} <!--??????--></th>
				</tr>
			</table>
		</div>
		<!-- ????????? -->
		<div class="com_ta2">
			<table id="tblUserETaxReport">
			</table>
		</div>
	</div>
	
	<div class="gt_paging mt30">
		<div class="paging mt30">
			<span class="pre"><a href="javascript:fnMovePage(currentPage-1)">${CL.ex_before} <!--??????--></a></span>
			<ol id="paging">
			</ol>
			<span class="nex"><a href="javascript:fnMovePage(currentPage+1)">${CL.ex_after} <!--??????--></a></span>
		</div>
		
		<div id="" class="gt_count">
			<select class="selectmenu up" style="width:75px;" id="selViewLength"><!-- ???????????? ?????? ?????? -->
				<option value="10">${CL.ex_10view} <!--10??? ??????--></option>
				<option value="20">${CL.ex_20view} <!--20??? ??????--></option>
				<option value="30">${CL.ex_30view} <!--30??? ??????--></option>
				<option value="40">${CL.ex_40view} <!--40??? ??????--></option>
				<option value="50">${CL.ex_50view} <!--50??? ??????--></option>
			</select>
		</div>
	</div>
</div>

<!-- //sub_contents_wrap -->

<!-- ???????????? ?????? ???????????? ?????? ??? -->
<form id="frmPop2" name="frmPop2">
	<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="<c:url value='/systemx/orgChart.do' />" /> 
	<input type="hidden" id="devMode_forCmPop" name="devMode" width="500" value="dev" /> 
	<input type="hidden" name="devModeUrl" width="500" value="http://local.duzonnext.com:8080" /> 
	<input type="hidden" id="langCode_forCmPop" name="langCode" width="500" /> 
	<input type="hidden" id="groupSeq_forCmPop" name="groupSeq" width="500" /> 
	<input type="hidden" id="compSeq_forCmPop" name="compSeq" width="500" /> 
	<input type="hidden" id="deptSeq_forCmPop" name="deptSeq" width="500" /> 
	<input type="hidden" id="empSeq_forCmPop" name="empSeq" width="500" /> 
	<input type="hidden" id="compFilter_forCmPop" name="compFilter" width="500" /> 
	<input type="hidden" name="selectMode" width="500" value="u" /> 
	<input type="hidden" name="selectItem" width="500" value="m" /> 
	<input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" /> 
	<input type="hidden" name="callback" width="500" value="fnCallbackOrgPop"/> 
	<input type="hidden" name="callbackUrl" width="500" value="<c:url value='/html/common/callback/cmmOrgPopCallback.jsp' />" />
</form>