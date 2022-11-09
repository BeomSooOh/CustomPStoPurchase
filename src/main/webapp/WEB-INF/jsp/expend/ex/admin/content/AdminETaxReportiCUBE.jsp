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
	
	/* 전자세금계산서 정보 조회 */
	function fnUserETaxListSearch() {
		var param = {};
		param.searchFromDt = $("#txtFromDate").val().toString().replace(/-/g, '');
		param.searchToDt = $("#txtToDate").val().toString().replace(/-/g, '');
		param.issNo = $("#txtIssNo").val();
		param.partnerName = $("#txtPartnerName").val();
		param.partnerNo = $("#txtPartnerNo").val().toString().replace(/-/g, '');
		param.docuSt = $("#selSendType").val();
		param.emailDc = $("#txtEmailAddress").val();
		param.divNm = $("#txtDivNm").val();
		
		if(!param){
			return;
		}
		/* 서버호출 */
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
            		/* ExCommonReport.js 포함 */
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
	
	/* 계산서 데이터 세팅 */
	function fnSetEtaxData(data){
		gridDataList = [];
		var rowNum = 1;
		$.each(data,function(idx, val){
			/* 그룹웨어 데이터만 존재하는 경우 패스 */
			if(val[0].trregNb === undefined){
				return true;
			}
			
			/* 결의자 검색 조건 추가(iCUBE에서 전송 한 경우 확인이 안되기 때문에 여기서 처리 진행) */
			if( $("#txtUserName").val() != '' ){
				if( val.length > 1 ){ 
					if( val[1].empName.indexOf( $("#txtUserName").val( ) ) == -1 ){
						return true;
					}
				}else{
					if(val[0].adocuYN == '1'){
						if( 'ERP 처리 건'.indexOf( $("#txtUserName").val( ) ) == -1 ){
							return true;
						}
					}else{
						return true;
					}
				}
			}
			
			/* 전송여부 검색조건 */
			/* adocuYN ( 0 : 미발행, 1 : 발행 ) */
			var tEtaxData = {};
			switch( $("#selSendType").val() ){
				case "2" : /* 결의 */
					if( val.length > 1 && val[1].sendYN == 'Y' && val[1].ifMId != 'D' ){
						tEtaxData.ifMId = (val[1].ifMId || '');
						tEtaxData.empName = ( val[1].empName || '');
						tEtaxData.sendType = '결의';
					}else if( val.length == 1 && val[0].adocuYN == '1' ){  
						tEtaxData.ifMId = '';
						tEtaxData.empName = 'ERP 처리 건';
						tEtaxData.sendType = '결의';
					}else if (val[0].adocuYN == '1' && val[1].sendYN == 'N'){
						tEtaxData.ifMId = '';
						tEtaxData.empName = 'ERP 처리 건';
						tEtaxData.sendType = '결의';
					}
					else{ return true; }
					break;
				case "1" : /* 미결의 */
					if( ( val.length == 1 && val[0].adocuYN == '0' ) || ( val.length > 1 && val[1].sendYN == 'N' && val[0].adocuYN == '0' && val[1].ifMId != 'D'  ) ){
						tEtaxData.sendType = '미결의';
						tEtaxData.empName='';
					}else{
						return true;
					}
					break;
				case "D" : /* 미사용 */
					if( val.length == 1 || val[1].ifMId != 'D'){ return true; }
					else{
						tEtaxData.sendType = '미사용';
						tEtaxData.empName='';
					}
					break;
				default :
					if( val.length > 1 ){
						if(val[1].ifMId == 'D'){
							tEtaxData.ifMId = ''
							tEtaxData.sendType = '미사용';
							tEtaxData.empName='';	
						}else if(val[1].sendYN == 'Y'){
							tEtaxData.ifMId = (val[1].ifMId || '');
							tEtaxData.empName = (val[1].empName || '');
							tEtaxData.sendType = '결의';
						}else if (val[0].adocuYN == '1' && val[1].sendYN == 'N'){
							tEtaxData.ifMId = '';
							tEtaxData.empName = 'ERP 처리 건';
							tEtaxData.sendType = '결의';
						}else{
							tEtaxData.ifMId = ''
							tEtaxData.sendType = '미결의';
							tEtaxData.empName='';
						}
					}else if( val.length == 1 && val[0].adocuYN == '1' ){
						tEtaxData.ifMId = '';
						tEtaxData.empName = 'ERP 처리 건';
						tEtaxData.sendType = '결의';
					}else{
						tEtaxData.ifMId = ''
						tEtaxData.sendType = '미결의';
						tEtaxData.empName='';
					}
					break;
			}
			
			tEtaxData.rowNum = rowNum++;
			tEtaxData.issNo = val[0].issNo; //승인번호 
			tEtaxData.issDt = val[0].issDt.toString().replace( /^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3'); //작성일자
			tEtaxData.divNm = val[0].divNm; // 사업장
			tEtaxData.trNm = val[0].trNm; // 거래처명
			tEtaxData.trregNb = val[0].trregNb.toString().replace( /^(\d{3})(\d{2})(\d{5})$/, '$1-$2-$3'); //사업자번호
			tEtaxData.trchargeEmail = val[0].trchargeEmail; //공급받는자 이메일
			tEtaxData.sumAm = val[0].sumAm.toString().replace( /\B(?=(\d{3})+(?!\d))/g, ','); //합계금액
			tEtaxData.supAm = val[0].supAm.toString().replace( /\B(?=(\d{3})+(?!\d))/g, ','); //공급가액
			tEtaxData.vatAm = val[0].vatAm.toString().replace( /\B(?=(\d{3})+(?!\d))/g, ','); //세액
			if(val.length > 1){
				tEtaxData.transferType = val[1].transferType;
				tEtaxData.transferSeq = val[1].transferSeq;	//이관 한 사원 번호
				tEtaxData.transferName = val[1].transferName; //이관 한 사원 이름	
				tEtaxData.receiveSeq = val[1].receiveSeq; //이관 받은 사원 번호	
				tEtaxData.receiveName = val[1].receiveName;	//이관 받은 사원 이름
			}else{
				tEtaxData.transferType = '';	
				tEtaxData.transferSeq = '';	
				tEtaxData.transferName = ''; 
				tEtaxData.receiveSeq = ''; 
				tEtaxData.receiveName = ''; 
			}
			tEtaxData.dummy1 = val[0].dummy1; //비고
			
			gridDataList.push(tEtaxData);
		});
	}
	
	/* 계산서 리스트 바인딩 */
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
			$(tr).append('<td colspan="' + $("#tblUserETaxReport colgroup col").length + '">데이터가 없습니다. iCUBE [전자세금계산서검증및전표처리]메뉴에서 [국세청자료불러오기]를 확인하시기 바랍니다.</td>')
			$("#tblUserETaxReport").append(tr);
		}else{
			var showDataLength = 0 ;
			$("#valTotalCount").text(gridDataLength);
			
			$.each(data,function(idx, val){
				if( (( currentPage - 1) * $("#selViewLength").val()) < val.rowNum && val.rowNum <= (currentPage * $("#selViewLength").val())){
					var tr = document.createElement("tr");
					var disabledYN = '';
					var transfer = '';
					if(val.sendType =='결의'){
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
					$(tr).append('<td class="ce">' + val.divNm + '</td>'); /* 사업장 */
					$(tr).append('<td class="le">' + transfer + val.trNm + '</td>');
					$(tr).append('<td class="ce">' + val.trregNb + '</td>');
					$(tr).append('<td class="ce">' + '<a class="text_blue etaxPop" style="text-decoration:underline;cursor:pointer;" title="매입전자 세금 계산서 상세 팝업보기">' + val.issNo + '</a>' + '</td>');
					$(tr).append('<td class="ce">' + val.trchargeEmail  + '</td>');
					$(tr).append('<td class="ri">' + val.sumAm+ '</td>');
					$(tr).append('<td class="ri">' + val.supAm+ '</td>');
					$(tr).append('<td class="ri">' + val.vatAm+ '</td>');
					if(val.sendType == '미사용'){
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
	
	 /* 엑셀 다운로드 */
	function fnAdminReportExcelDown() {
		if( !gridDataList || gridDataList.length == undefined || gridDataList.length == 0){
			alert("데이터가 없습니다.");
			return false;
		}
    	/* 파라미터  */
		$("#fileName").val( "세금계산서현황" );
		/* Excel 헤더 정의 */
		var excelHeader = {};
		excelHeader.issDt = '작성일자';
		excelHeader.divNm =  '${CL.ex_workplace}'; /* 사업장 */
		excelHeader.trNm =  '공급자';
		excelHeader.trregNb =  '사업자등록번호';
		excelHeader.issNo =  '승인번호';
		excelHeader.trchargeEmail =  '메일주소';
		excelHeader.sumAm =  '금액';
		excelHeader.supAm =  '공급가액';
		excelHeader.vatAm =  '부가세';
		excelHeader.sendType =  '결의상태';
		excelHeader.empName =  '결의자';
		excelHeader.dummy1 =  '비고';
		$("#excelHeader").val( JSON.stringify(excelHeader) );
		$("#tableData").val( JSON.stringify(gridDataList) );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
	 
	/* 세금계산서 내역 사용/미사용 처리 */
	function fnAdminSetETaxUseYN(ynType){
		/* ynType ( Y : 미사용, N : 사용) */
		var chkSels = new Array();
		var isSuccess = true;
		$.each($("input:checkbox:checked"),function(idx,val){
			if($(this).attr("value") == 'on'){
				return true;
			}
			chkSels.push($(this).attr("value")); 
		});
		
		if(chkSels.length == 0){
			alert("변경할 항목을 선택해주세요.");
		}
		/* ynType ( Y : 미사용, N : 사용) */
		for(var i = 0 ; i <chkSels.length ; i++){
			if( (ynType == 'Y' && chkSels[i].split('_')[3] == '미사용') || (ynType == 'N' && chkSels[i].split('_')[3] != '미사용')){
				continue;
			}
			var param = {};
			param.issNo = chkSels[i].split('_')[0];
			param.issDt = chkSels[i].split('_')[1].replace(/-/g,'');
			param.partnerNo = chkSels[i].split('_')[2].replace(/-/g,'');
			/*param.sendYN = ynType; 상신 미상신시 제어 컬럼으로 수정되어서는 안 */
			/* 기존의 미사용건들에 대해,  send_yn 값이 Y로 값이 있기에, 미사용 및 미사용시 send_yn = 'N'값으로 하드코딩 */
			param.sendYN = 'N';
			param.ifMId = (ynType == 'Y'?'D':'');
			/* 서버호출 */
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
				alert("미사용 처리되었습니다.");	
			}else{
				alert("미사용 처리가 해제되었습니다.");
			}	
		}
		
		$("#btnSearch").click();
	}

	/* 세금계산서 이관 */
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
			alert("이관 할 항목을 선택해주세요");
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
	/* 세금계산서 이관 이력 팝업 */
	function fnUserManageTransfer(){
		var url = "<c:url value='/ex/admin/report/ExAdminETaxTransferHistoryPop.do'/>";

		url += '?fiEaType=eap';
    	var popupWidth = 999;
	    var popupHeight = 698;
	    
	    var windowX = (screen.width - popupWidth)/2;
	    var windowY = (screen.height - popupHeight - 30)/2;
	    
		var win = window.open(url,"세금계산서 이관관리","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);
		
        if(win== null || win.screenLeft == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018810","브라우져 팝업차단 설정을 확인해 주세요")%>");
        }
	}
	
	
    /* 공통사용 - 공통팝업 콜백 함수 */
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

        /* 이관 데이터 insert */
//         $('#selectedItems_forCmPop').val(selectedItems);
        
       	var param = {};
		param.targetData = $("#hidSelectedETaxInfo").val();
		param.receiveInfo = JSON.stringify(returnObj);
		param.interfaceType = 'etax';
		/* 서버호출 */
		$.ajax({
			type : 'post',
			url : '<c:url value="/ex/user/report/ExUserInterfaceTransfer.do" />',
			datatype : 'json',
			async : true,
			data : param,
			success : function( data ) {
				if(data.result.resultCode == 'SUCCESS'){
					alert("이관이 완료되었습니다.");
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
<!-- 이관 관련 데이터 -->
<input type="hidden" id="hidSelectedETaxInfo" value="">
<!-- body -->
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_writeDate} <!--작성일자--></dt>
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
			<dt>${CL.ex_supplyer} <!--공급자--></dt>
				<dd>
					<input type="text" id="txtPartnerName" style="width:186px;" />
				</dd>
			<dt>${CL.ex_resCondition} <!--결의상태--></dt>
			<dd>
				<select id="selSendType" class="selectmenu" style="width:100px;">
					<option value="0" selected="selected">${CL.ex_all} <!--전체--></option>
					<option value="2">${CL.ex_res} <!--결의--></option>
					<option value="1">${CL.ex_noRes} <!--미결의--></option>
					<option value="D">${CL.ex_noUser} <!--미사용--></option>
				</select>
			</dd>
			<dd>
				<input type="button" id="btnSearch" value="${CL.ex_search}" /> <!--검색-->
			</dd>
		</dl>
		<span class="btn_Detail">${CL.ex_detailSearch} <!--상세검색--> <img id="all_menu_btn" src='../../../Images/ico/ico_btn_arr_down01.png' /></span>
	</div>
	<!-- 상세검색박스 -->
	<div class="SearchDetail">
		<dl>
			<dt>${CL.ex_workplace} <!--사업장--></dt>
			<dd><input type="text" id="txtDivNm" style="width:150px;" /></dd>
			<dt style="width:120px;">${CL.ex_corporateRegiNum} <!--사업자등록번호--></dt>
			<dd><input type="text" id="txtPartnerNo" style="width:150px;" /></dd>
			<dt style="width:70px;">${CL.ex_confirmationNumber} <!--승인번호--></dt>
			<dd><input type="text" id="txtIssNo" style="width:150px;" /></dd>
			<dt style="width:70px;">${CL.ex_MailAddress} <!--메일주소--></dt>
			<dd><input type="text" id="txtEmailAddress" style="width:150px;" /></dd>
			<dt style="width:70px;">${CL.ex_resPerson} <!--결의자--></dt>
			<dd><input type="text" id="txtUserName" style="width:150px;" /></dd>									
		</dl>
	</div>
	
	<!-- 버튼 -->
	<div class="controll_btn cl">
		<span class="fwb mt5" style="text-align:left;float:left">총 <span id="valTotalCount">0</span> 건</span>
		<button id="btnTransfer">${CL.ex_calcTrans} <!--계산서이관--></button>
		<button id="btnManageTransfer">${CL.ex_transManage} <!--이관관리--></button>
		<button id="btnUnUse">${CL.ex_noUser} <!--미사용--></button>
		<button id="btnUse">${CL.ex_noUserClear} <!--미사용해제--></button>
		<button id="btnExcel">${CL.ex_excelDown} <!--엑셀다운로드--></button>
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
					<th>${CL.ex_writeDate} <!--작성일자--></th>
					<th>${CL.ex_workplace} <!--사업장--></th>
					<th>${CL.ex_supplyer} <!--공급자--></th>
					<th>${CL.ex_corporateRegiNum} <!--사업자등록번호--></th>
					<th>${CL.ex_confirmationNumber} <!--승인번호--></th>
					<th>${CL.ex_MailAddress} <!--메일주소--></th>
					<th>${CL.ex_amount} <!--금액--></th>
					<th>${CL.ex_purPrice} <!--공급가액--></th>
					<th>${CL.ex_vat} <!--부가세--></th>
					<th>${CL.ex_resCondition} <!--결의상태--></th>
					<th>${CL.ex_resPerson} <!--결의자--></th>
					<th>${CL.ex_note2} <!--비고--></th>
				</tr>
			</table>
		</div>
		<!-- 테이블 -->
		<div class="com_ta2">
			<table id="tblUserETaxReport">
			</table>
		</div>
	</div>
	
	<div class="gt_paging mt30">
		<div class="paging mt30">
			<span class="pre"><a href="javascript:fnMovePage(currentPage-1)">${CL.ex_before} <!--이전--></a></span>
			<ol id="paging">
			</ol>
			<span class="nex"><a href="javascript:fnMovePage(currentPage+1)">${CL.ex_after} <!--다음--></a></span>
		</div>
		
		<div id="" class="gt_count">
			<select class="selectmenu up" style="width:75px;" id="selViewLength"><!-- 공통코드 처리 필요 -->
				<option value="10">${CL.ex_10view} <!--10건 보기--></option>
				<option value="20">${CL.ex_20view} <!--20건 보기--></option>
				<option value="30">${CL.ex_30view} <!--30건 보기--></option>
				<option value="40">${CL.ex_40view} <!--40건 보기--></option>
				<option value="50">${CL.ex_50view} <!--50건 보기--></option>
			</select>
		</div>
	</div>
</div>

<!-- //sub_contents_wrap -->

<!-- 공통팝업 위한 기능옵션 전달 폼 -->
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