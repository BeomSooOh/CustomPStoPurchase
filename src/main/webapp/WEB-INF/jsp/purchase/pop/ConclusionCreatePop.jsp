<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>계약체결 등록</title>

    <!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/common.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/re_pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/animate.css' />">
	
	<jsp:include page="/WEB-INF/jsp/common/cmmJunctionCodePop.jsp" flush="false" />	
	
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/pudd/pudd-1.1.200.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script>  
    <script type="text/javascript" src="<c:url value='/js/jquery.maskMoney.js' />"></script>  

	<script type="text/javascript">
	
		var commonParam = {};
		var commonElement;
		var saveData; 
		var optionSet = {};
		
		 
		
		var ERP_GISU = ${erpGisu}
		optionSet.erpGisu = ERP_GISU[0];	
		commonParam.callback = 'fnCommonCode_callback';
		commonParam.widthSize = "628";
		commonParam.heightSize = "546";
		commonParam.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
		commonParam.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
		commonParam.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
		commonParam.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
		commonParam.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
		commonParam.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
		
		commonParam.erpGisuDate = commonParam.frDate.replaceAll('-','');
		
		commonParam.opt01 =  '2'; /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */
		commonParam.opt02 = '1'; /* 1: 모두표시, 2: 사용기한결과분 숨김 */
		commonParam.opt03 = '2'; /* 1: 예산그룹 전체, 2: 예산그룹 숨김 */
		commonParam.grFg = '2'; /* 1 : 수입, 2 : 지출 */		
		
		commonParam.resDocSeq =  "-1";
		commonParam.consDocSeq =  "-1";
		commonParam.confferDocSeq =  "-1";
		commonParam.confferSeq =  "-1";
		commonParam.confferBudgetSeq = "-1";
		commonParam.consSeq = "-1";
		commonParam.resSeq = "-1";
		commonParam.selectedBudgetSeqs = "";

		var outProcessCode = "Conclu01-${contractType}";
		var disabledYn = "${disabledYn}";

		var insertDataObject = {};
		var attachFormList = [];
		var attachFileNew = [];
		var attachFileDel = [];		
		var commonCodeTargetInfo = [];
		var targetElement;
		
		var tempArray = [];
		var tempObj = {};
		var tempStr = "";
		
		<c:forEach var="items" items="${attachForm_Conclusion01}">
		
		tempObj = {};
		tempArray =  "${items.LINK}".split('▦');
		tempObj.code = "${items.CODE}";
		tempObj.formNm = "${items.NAME}";
		
		tempObj.mustYn = tempArray[0];
		tempObj.formFileNm = tempArray[1];
		tempObj.formFileId = tempArray[2];
		
		tempObj.fileId = "${items.file_id}";
		tempObj.fileName = "${items.file_name}";
		tempObj.fileExt = "${items.file_ext}";
		tempObj.newYn = "${items.new_yn}";
		
		attachFormList.push(tempObj);
		</c:forEach>
		
		$(document).ready(function() {

			$('#txtOpenAmt1').text(fnGetCurrencyCode("${contractDetailInfo.open_amt}"));
			$('#txtConsBalanceAmt1').text(fnGetCurrencyCode("${contractDetailInfo.consbalance_amt}"));
			$('#txtApplyAmt1').text(fnGetCurrencyCode("${contractDetailInfo.resApply_amt}"));
			$('#txtBalanceAmt1').text(fnGetCurrencyCode("${contractDetailInfo.balance_amt}"));
			
			
			//기존설정항목 세팅
			setDynamicPuddInfoTable("amtInfoList", "${contractDetailInfo.contract_amt_info}");
			setDynamicSetInfoUl("hopeCompanyList", "${contractDetailInfo.hope_company_info}");
			setDynamicSetInfoFile("hopeAttachList", "${contractDetailInfo.hope_attach_info}");
			setDynamicSetInfoBudget();
			setDynamicSetInfoTrade();
			setDynamicSetInfoAmt(); 
			
			amountInputSet();
			amountKoreanSet();		
			
			//담당자 선택항목 세팅
			setDynamicPublicInfo("${contractDetailInfo.public_info}");		
			
			
			//옵션값 설정
			setCommonOption();
			
		});
		
		
		function setCommonOption(){
			
			<c:forEach var="items" items="${option}" varStatus="status">
			
			console.log("option ${items.CODE} > ${items.NOTE}");
			
			if("${items.CODE}" == "def_erp_budget_div_seq"){
				$("[name=erp_budget_div_seq]").val("${items.NOTE}");
				
				$("[optionTarget=def_erp_budget_div_seq]").hide();
				
			}else if("${items.CODE}" == "def_erp_budget_div_name"){
				$("[name=erp_budget_div_name]").val("${items.NOTE}");
			}			
			
			</c:forEach>				
			
			
		}
		
		// 예산정보html
		function setDynamicSetInfoAmt(){
			
		/* 	<c:if test="${budgetList.size() > 0 }">	
			var cloneData;
			var i = 1;
			<c:forEach var="items" items="${budgetList}" varStatus="status">
			
			cloneData = $('#resultAmtListHtml tr:first').clone();
			$("#bgtAmtnum").text("i");
			$("#bgtAmt1Name").text("${items.erp_bgt1_name}");
			$("#bgtAmt2Name").text("${items.erp_bgt2_name}");
			$("#bgtAmt3Name").text("${items.erp_bgt3_name}");
			$("#txtbgtAmt").text("${items.amt}");
			
			$("#txtbgtOpenAmt").text("${items.txt_open_amt}");
			$("#txtbgtConsBalanceAmt").text("${items.txt_cons_balance_amt}");
			$("#txtbgtApplyAmt").text("${items.txt_apply_amt}");
			$("#txtbgtBalanceAmt").text("${items.txt_balance_amt}");
			
		
			
			$('#resultAmtListHtml').append(cloneData);
			
			
			</c:forEach>		
			</c:if>			
 */			
 			$("#resultAmtListHtml tbody").empty();
 			$.each($("table[name='budgetList'] tr[name='addData']"), function(index, tr){
 				var $clone = $("#resultAmtListHtml tfoot tr").clone();
 				$clone.find("td.bgtAmtnum").html("<span style='font-family:굴림;font-size:10px'>" + parseInt(index + 1) + "</span>");
 				$clone.find("td.bgtAmt1Name").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='pjt_name']").val() + "</span>");
 				$clone.find("td.bgtAmt2Name").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='erp_bgt2_name']").val() + "</span>");
 				$clone.find("td.bgtAmt3Name").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='erp_bgt3_name']").val() + "</span>");
 				$clone.find("td.txtbgtAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_open_amt']").val() + "</span>"); 
 				$clone.find("td.txtbgtOpenAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_cons_balance_amt']").val() + "</span>");
 				$clone.find("td.txtbgtConsBalanceAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_apply_amt']").val() + "</span>");
 				$clone.find("td.txtbgtApplyAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_pay_amt']").val() + "</span>");
 				$clone.find("td.txtbgtBalanceAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_balance_amt']").val() + "</span>");
 				$("#resultAmtListHtml tbody").append($clone);
 			});
 			
		}
		
		
		
		function setDynamicSetInfoBudget(targetName, value){
			
			<c:if test="${budgetList.size() > 0 }">
			$("[name=budgetList] [name=addData]").remove();
			var cloneData;
		
			<c:forEach var="items" items="${budgetList}" varStatus="status">
			
			cloneData = $('[name="budgetList"] [name=dataBase]').clone();
			$(cloneData).show().attr("name", "addData");
			
			
			$(cloneData).find("[name=erp_budget_seq]").val("${items.erp_budget_seq}");
			$(cloneData).find("[name=erp_budget_name]").val("${items.erp_budget_name}");
			$(cloneData).find("[name=erp_budget_div_seq]").val("${items.erp_budget_div_seq}");
			$(cloneData).find("[name=erp_budget_div_name]").val("${items.erp_budget_div_name}");
			
			$(cloneData).find("[name=erp_bgt1_seq]").val("${items.erp_bgt1_seq}");
			$(cloneData).find("[name=erp_bgt2_seq]").val("${items.erp_bgt2_seq}");
			$(cloneData).find("[name=erp_bgt3_seq]").val("${items.erp_bgt3_seq}");
			$(cloneData).find("[name=erp_bgt4_seq]").val("${items.erp_bgt4_seq}");	
			
			$(cloneData).find("[name=erp_bgt1_name]").val("${items.erp_bgt1_name}");
			$(cloneData).find("[name=erp_bgt2_name]").val("${items.erp_bgt2_name}");
			$(cloneData).find("[name=erp_bgt3_name]").val("${items.erp_bgt3_name}");
			$(cloneData).find("[name=erp_bgt4_name]").val("${items.erp_bgt4_name}");	
			
			$(cloneData).find("[name=pjt_seq]").val("${items.pjt_seq}");
			$(cloneData).find("[name=pjt_name]").val("${items.pjt_name}");
			$(cloneData).find("[name=bottom_seq]").val("${items.bottom_seq}");
			$(cloneData).find("[name=bottom_name]").val("${items.bottom_name}");
			$(cloneData).find("[name=amt]").val("${items.amt}");
			
			
			$(cloneData).find("[name=txt_open_amt]").val("${items.txt_open_amt}");
			$(cloneData).find("[name=txt_cons_balance_amt]").val("${items.txt_cons_balance_amt}");
			$(cloneData).find("[name=txt_apply_amt]").val("${items.txt_apply_amt}");
			$(cloneData).find("[name=txt_balance_amt]").val("${items.txt_balance_amt}");
			$(cloneData).find("[name=txt_pay_amt]").val("${items.amt}");
			
			
			/* $(cloneData1).find("[name=amt1]").val("${items.amt}"); */
			
			$('[name="budgetList"]').append(cloneData);
			
			if(${status.index} == 0){
				fnSetBudgetAmtInfo(cloneData);	
			}
			
			</c:forEach>			
			</c:if>			
			
		}
		
		
		function setDynamicSetInfoTrade(targetName, value){
			
			<c:if test="${tradeList.size() > 0 }">
			$("[name=tradeList] [name=addData]").remove();
			var cloneData;
			
			<c:forEach var="items" items="${tradeList}" varStatus="status">
			
			cloneData = $('[name="tradeList"] [name=dataBase]').clone();
			$(cloneData).show().attr("name", "addData");
			
			$(cloneData).find("[name=tr_seq]").val("${items.tr_seq}");
			$(cloneData).find("[name=tr_name]").val("${items.tr_name}");
			
/* 			$(cloneData).find("[name=tr_reg_number]").text("${items.tr_reg_number}");
			$(cloneData).find("[name=ceo_name]").text("${items.ceo_name}");*/
			$(cloneData).find("[name=addr]").text("${items.addr}"); 
			
			$(cloneData).find("[name=tr_reg_number]").val("${items.tr_reg_number}");
			$(cloneData).find("[name=ceo_name]").val("${items.ceo_name}");
			$(cloneData).find("[name=addr]").val("${items.addr}"); 
			
			
			$(cloneData).find("[name=at_tr_name]").val("${items.at_tr_name}");
			$(cloneData).find("[name=ba_nb]").val("${items.ba_nb}");
			$(cloneData).find("[name=btr_name]").val("${items.btr_name}");
			$(cloneData).find("[name=btr_seq]").val("${items.btr_seq}");
			$(cloneData).find("[name=depositor]").val("${items.depositor}");
			$(cloneData).find("[name=tr_fg]").val("${items.tr_fg}");
			$(cloneData).find("[name=tr_fg_name]").val("${items.tr_fg_name}");
			
			$(cloneData).find("[name=pm_email]").val("${items.pm_email}");
			$(cloneData).find("[name=pm_hp]").val("${items.pm_hp}");
			$(cloneData).find("[name=pm_name]").val("${items.pm_name}");
			
			
			
			$('[name="tradeList"]').append(cloneData);
			
			</c:forEach>			
			</c:if>			
		
		}
		
		
	
		function setDynamicSetInfoFile(targetName, value){
			
			if(value != ""){
				
				targetElement =  $("[name="+targetName+"]");
				
				$.each(value.split("▦▦"), function( key, val ) {
					
					var valInfo =  val.split("▦");
					
					var cloneData = $(targetElement).find('[name="attachBase"]').clone();
					$(cloneData).show().attr("name", "addFile");
					$(cloneData).find('[name="attachFileName"]').attr("fileid", valInfo[0]);
					$(cloneData).find('[name="attachFileName"]').text(valInfo[1]);
					$(cloneData).find('[name="attachExtName"]').text(valInfo[2]);	
					
					$(targetElement).append(cloneData);						
					
				});	
				
			}				
		}
		
		
		
		function setDynamicSetInfoUl(targetName, value){
			
			if(value != ""){
				
				$.each(value.split("▦▦"), function( key, val ) {
					
					var valInfo =  val.split("▦");
					
					var objInfo = {};
					
					objInfo.code = valInfo[0];
					objInfo.name = valInfo[1];
					
					commonCodeTargetInfo.push(objInfo);
					
				});	
				
				commonCodeCallback("ul", targetName);
				
			}			
			
		}
		
		
		
		function amountInputSet(){
			
			$('[amountInput=Y]').maskMoney({
				precision : 0,
				allowNegative: false
			});
			
			$('[amountType=amt]').keyup(function() {
				
				var amtInt = $(this).val().replace(/,/g, '');
				var targetTr = $(this).closest("tr[name=addData]");
				
				$(targetTr).find("[amounttype=stdAmt]").val((Math.floor(amtInt*10/11)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(targetTr).find("[amounttype=taxAmt]").val((Math.ceil(amtInt/11)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(targetTr).find("[name=viewKorean]").text(viewKorean(amtInt));
				
			});						
			
			
		}	
		
		function amountKoreanSet(){
			
			$.each($('[amountType=amt]'), function( idx, addData ) {
				
				var amtInt = $(addData).val().replace(/,/g, '');
				var targetTr = $(addData).closest("tr[name=addData]");
				$(targetTr).find("[name=viewKorean]").text(viewKorean(amtInt));				
				
			});	
			
		}			
		
		function attachLayerPop(){
			
			if(attachFormList.length == 0){
				msgAlert("error", "첨부파일 양식코드가 존재하지 않습니다.", "");
				return;
			}
			
			var layerHeight = 86+(30*attachFormList.length);
			
			// puddDialog 함수
			Pudd.puddDialog({
			 
				width : 800
			,	height : layerHeight
			 
			,	modal : true			// 기본값 true
			,	draggable : false		// 기본값 true
			,	resize : false			// 기본값 false
			 
			,	header : {
		 		title : "첨부파일"
			,	closeButton : true	// 기본값 true
			,	closeCallback : function( puddDlg ) {
					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}
			 
			,	body : {
			 
					iframe : true
				,	url : "${pageContext.request.contextPath}/purchase/layer/AttachLayer.do?disabledYn=${disabledYn}"

			}
			 
				// dialog 하단을 사용할 경우 설정할 부분
			,	footer : {
			
					buttons : [
						
						<c:if test="${disabledYn == 'N'}">
						{
							attributes : {}// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	value : <c:if test="${viewType == 'I'}">"확인"</c:if><c:if test="${viewType != 'I'}">"저장"</c:if>
						,	clickCallback : function( puddDlg ) {
							
							temptemp = puddDlg;
								fnUpdateAttachInfo();
								puddDlg.showDialog( false );
								// 추가적인 작업 내용이 있는 경우 이곳에서 처리
								
							}
						},
						</c:if>
						
						{
							attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
						,	value : <c:if test="${disabledYn == 'Y'}">"닫기"</c:if><c:if test="${disabledYn == 'N'}">"취소"</c:if>
						,	clickCallback : function( puddDlg ) {
								puddDlg.showDialog( false );
								attachFileNew = [];
								attachFileDel = [];	
							}
						}
					]
				}
			});			
			
		}	
		
		function commonCodeCallback(type, targetName){
			
			if(type == "ul"){
				
				$('[name="'+targetName+'"] [name=addData]').remove();
				
				$.each(commonCodeTargetInfo, function( idx, addData ) {
					
					var cloneData = $('[name="'+targetName+'"] [name=dataBase]').clone();
					$(cloneData).show().attr("name", "addData");
					
					$(cloneData).attr("addCode", addData.code);
					$(cloneData).find("[name=addName]").text(addData.name);
					
					$('[name="'+targetName+'"]').append(cloneData);				
					
				});									
				
			}
			
		}
		
		/*
		function commonCodeTargetSet(type, targetName){
			
			if(type == "ul"){
				
				$.each($(targetName).find("addData"), function( idx, addData ) {
					
					var addDataInfo = {};
					
					addDataInfo.code = $(addData).attr("addCode");
					addDataInfo.name = $(addData).find("[name=addName]").text();
					
				});					
				
			}
		}
		*/

		function commonCodeSelectLayer(group, title, type, targetName, multiYn){
			
			commonCodeTargetInfo = [];
			
			/*
			if(appendYn == "Y"){
				commonCodeTargetSet(type, targetName);	
			}
			*/
			
			// puddDialog 함수
			Pudd.puddDialog({
			 
				width : 400
			,	height : 500
			 
			,	modal : true			// 기본값 true
			,	draggable : false		// 기본값 true
			,	resize : false			// 기본값 false
			 
			,	header : {
		 		title : title
			,	closeButton : true	// 기본값 true
			,	closeCallback : function( puddDlg ) {
					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}
			 
			,	body : {
			 
					iframe : true
				,	url : "${pageContext.request.contextPath}/purchase/layer/CodeSelectLayer.do?multiYn=" + multiYn + "&group=" + group
				,	iframeAttribute : {
					id : "dlgFrame"
				}						

			}
			 
				// dialog 하단을 사용할 경우 설정할 부분
			,	footer : {
			
					buttons : [
						
						{
							attributes : {}// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	value : <c:if test="${viewType == 'I'}">"확인"</c:if><c:if test="${viewType != 'I'}">"저장"</c:if>
						,	clickCallback : function( puddDlg ) {
							
							var iframeTag = document.getElementById( "dlgFrame" );
							iframeTag.contentWindow.fnDlgFrameFunc();							
							commonCodeCallback(type, targetName);
							puddDlg.showDialog( false );
								
							}
						},
						
						{
							attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
						,	value : <c:if test="${disabledYn == 'Y'}">"닫기"</c:if><c:if test="${disabledYn == 'N'}">"취소"</c:if>
						,	clickCallback : function( puddDlg ) {
								puddDlg.showDialog( false );
								attachFileNew = [];
								attachFileDel = [];	
							}
						}
					]
				}
			});			
			
		}			
		
		
		function fnUpdateAttachInfo(){
			$.each(attachFileDel, function( key1, attchDelInfo ) {
				$.each(attachFormList, function( key2, attchFormInfo ) {
					if(attchDelInfo == attchFormInfo.fileId){
						attchFormInfo.fileId = "";
						attchFormInfo.fileName = "";
						attchFormInfo.fileExt = "";
					}
				});	
			});				
			
			$.each(attachFileNew, function( key1, attchNewInfo ) {
				$.each(attachFormList, function( key2, attchFormInfo ) {
					if(attchNewInfo.attachformcode == attchFormInfo.code){
						attchFormInfo.fileId = attchNewInfo.uid;
						attchFormInfo.fileName = attchNewInfo.fileName;
						attchFormInfo.fileExt = attchNewInfo.fileExt;
					}
				});	
			});
			
			attachFileNew = [];
			attachFileDel = [];	
			
			//수정일 경우 즉시 업데이트
			<c:if test="${viewType == 'U'}">
			insertDataObject.attch_file_info = JSON.stringify(attachFormList);
			insertDataObject.seq = "${seq}"
			
			<c:if test="${contractType == '01'}">
			insertDataObject.outProcessCode = "Conclusion01-1";
			</c:if>
			<c:if test="${contractType == '02'}">
			insertDataObject.outProcessCode = "Conclusion01-2";
			</c:if>
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/attachSaveProc.do" />',
	    		datatype:"json",
	            data: insertDataObject ,
				async : false,
				success : function(result) {
					
					if(result.resultCode != "success"){
						msgSnackbar("error", "첨부파일 실패");
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "등록에 실패했습니다.");
				}
			});			
			
			</c:if>
			
		}
		
		function fnChangeNotiType(e){
			if($(e).val() == "02" && $("[name='decisionType']:checked").val() != "03" && $("[name='decisionType'][value=03]").length > 0){
				Pudd("[name='decisionType'][value=03]").getPuddObject().setChecked(true);
				$("[name='decisionType_03']").show();
			}
		}
		
		function fnChangeEtc(e, tableName){
			
			if($(e).attr('type') == "radio" || $(e).attr('type') == "select"){
				$('[name^="' + $(e).attr('name') + '_"]').hide();
			}
			
			if($(e).attr('type') == "select"){
				$('[name="' + $(e).attr('name') + "_" + $(e).val() + '"]').show();
			}else{
				
				if(e.checked){
					$('[name="' + $(e).attr('name') + "_" + $(e).val() + '"]').show();	
				}else{
					$('[name="' + $(e).attr('name') + "_" + $(e).val() + '"]').hide();
				}
			}
			
			if(tableName == "amtInfoList" && ($(e).val() == "01" || $(e).val() == "03")){
				
				if($('[name="'+tableName+'"] [name=addData]').length > 1){
					
					$.each($('[name="'+tableName+'"] [name=addData]'), function( key, objInfo ) {
						
						if(key != 0){
							$(objInfo).hide();
						}
						
					});					

				}
			}else{
				$('[name="'+tableName+'"] [name=addData]').show();
			}
		}		
		
		function fnSectorAdd(tableName, maxCnt){
			
			var aaDataCnt = $('[name="'+tableName+'"] [name=addData]').length + 1;
			
			if(maxCnt != null && aaDataCnt > maxCnt){
				msgSnackbar("warning", "등록 가능한 개수를 초과했습니다.");
				return;
			}			
			
			var cloneData = $('[name="'+tableName+'"] [name=dataBase]').clone();
			$(cloneData).show().attr("name", "addData");
			
			$('[name="'+tableName+'"]').append(cloneData);
			
			amountInputSet();
			
		}
		
		function fnSectorDel(e, tableName){
			
			if(tableName != null && $('[name="'+tableName+'"] [name=addData]').length == 1){
				return;
			}
			
			$(e).closest("tr").remove();
			
		}		
		
		function fnValidationCheck(){
			insertDataObject = {};
			
			var validationCheck = true;
			
			$.each($("[objKey]"), function( key, objInfo ) {
				
				var objValue = eval($(objInfo).attr("objCheckFor"));
				
				if(objValue == "$failAlert$"){
					validationCheck = false;
					return false;
				}
				
				insertDataObject[$(objInfo).attr("objKey")] = objValue;
				
			});
			
			/*
			//원단위입력제한체크
			if(validationCheck && $("#amt").val().slice(-1) != "0"){
				msgSnackbar("error", "기초금액은 일원단위 입력이 불가합니다.");
				$("#amt").focus();
				validationCheck = false;
			}
			*/
			
			return validationCheck;
		}
		

		function fnSave(type){
			
			if(fnValidationCheck() == true){

				insertDataObject.attch_file_info = JSON.stringify(attachFormList);
				insertDataObject.budget_list_info = JSON.stringify(insertDataObject.budgetObjList);
				insertDataObject.trade_list_info = JSON.stringify(insertDataObject.tradeObjList);
				
				//계약총금액 조회
				insertDataObject.contract_amt = 0;
				
				$.each($("[name=amtInfoList] [name=addData] [amounttype=amt]"), function( key, objInfo ) {
					insertDataObject.contract_amt += parseInt($(objInfo).val().replace(/,/g, ''));
				});
				
				insertDataObject.contract_amt_kor = viewKorean(insertDataObject.contract_amt.toString());
				
				if(type == 0){
					confirmAlert(350, 100, 'question', '저장하시겠습니까?', '저장', 'fnSaveProc(1)', '취소', '');	
				}else if(type == 1){
					
					var attachValidationcheck = true;
					
					$.each(attachFormList, function( key, objInfo ) {
						
						if(objInfo.mustYn == "Y" && objInfo.fileId == ""){
							attachValidationcheck = false;
							msgSnackbar("error", "필수 첨부파일을 업로드해 주세요.");
							fnCallBtn('attach');
							return false;
						}
						
					});	
					
					if(attachValidationcheck){
						confirmAlert(350, 100, 'question', '결재작성 하시겠습니까?', '확인', 'fnSaveProc(2)', '취소', '');	
					}
						
				}
									
			}			
		}
		
		function fnSaveProc(type){
			

			insertDataObject.reqType = type;
			
			
			
			var resultAmtListHtml = "";
			$('[name=resultAmtListHtmlre] tfoot').remove();
			$('[name=resultAmtListHtmlre]').find("[displaynone]").removeAttr("displaynone");
			/* $('[name=resultAmtListHtmlre]').find(":hidden").attr("displaynone", "Y"); */
			
			var cloneData = $('[name=resultAmtListHtmlre]').clone();
			
			
			//input 요소 텍스트화
			$.each($(cloneData).find("input"), function( idx, obj ) {
				$(obj).replaceWith($(obj).val());
			});
			
			resultAmtListHtml = $(cloneData)[0].outerHTML;
			insertDataObject.result_amt_info_html = resultAmtListHtml;
			
			
			
 			/* insertDataObject.open_amt = fnGetCurrencyCode(saveData.openAmt); */
 			insertDataObject.open_amt = saveData.openAmt;
 			insertDataObject.consbalance_amt = saveData.consBalanceAmt;
 			insertDataObject.resApply_amt = saveData.resApplyAmt;
 			insertDataObject.balance_amt = saveData.balanceAmt;
			
			<c:if test="${contractType == '01'}">
			insertDataObject.outProcessCode = "Conclusion01-1";
			insertDataObject.viewType = "U";
			</c:if>
			<c:if test="${contractType == '02'}">
			insertDataObject.outProcessCode = "Conclusion01-2";
			insertDataObject.viewType = "${viewType}";
			</c:if>			
			
			insertDataObject.seq = "${seq}";
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/ConclusionSaveProc.do" />',
	    		datatype:"json",
	            data: insertDataObject ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						if(type == 1){
							openerRefreshList();				
							msgAlert("success", "임시저장이 완료되었습니다.", "self.close()");							
						}else{
							openWindow2("${pageContext.request.contextPath}/purchase/ApprCreate.do?useYn=Y&outProcessCode="+outProcessCode+"&seq=" + result.resultData.seq,  "ApprCreatePop", 1000, 729, 1, 1) ;
							self.close();
						}
						
					}else{
						msgSnackbar("error", "등록에 실패했습니다.");	
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "등록에 실패했습니다.");
				}
			});
			
		}
		
		function openerRefreshList(){
			if(opener != null && typeof opener.BindGrid != "undefined"){
				opener.BindGrid();
			}	
		}
		
		function fnClose(){
			
			self.close();
			
		}			
		
		function fnCallBtn(callId){
			
			if(callId == "attach"){
				attachLayerPop();
			}else if(callId == "save"){
				fnSave(0);
			}else if(callId == "appr"){
				fnSave(1);
			}
			
		}	
		

		
		function setDynamicPublicInfo(public_info){
			
			var public_list = [];
			
			$.each(public_info.split("▦▦"), function( key, val ) {
				var valInfo =  val.split("▦");
				if(valInfo.length > 1){
					var valueObj = {};
					valueObj.value = valInfo[0];
					valueObj.text = valInfo[1];
					public_list.push(valueObj);
				}
			});		 
			
			renderPublicInfo(public_list);			
			
		}
		
		
		
		function selectOrgchart(){
			
			var selectedItems = "";
			 
			
			$.each(Pudd( "#publicInfo" ).getPuddObject().getData(), function( key, val ) {
				selectedItems += (key == 0 ? "" : ",") + val.value;
			});				 
			 
			 $("#selectedItems").val(selectedItems);
			 
			 var pop = window.open("", "cmmOrgPop", "width=799,height=769,scrollbars=no");
				$("#callback").val("callbackSel");
				frmPop.target = "cmmOrgPop";
				frmPop.method = "post";
				frmPop.action = "/gw/systemx/orgChart.do";
				frmPop.submit();
				pop.focus();
		}	
	
		function getPublicInfo(){
			
			var selectedItems = "";
			 
			$.each(Pudd( "#publicInfo" ).getPuddObject().getData(), function( key, val ) {
				selectedItems += (key == 0 ? "" : "▦▦") + val.value + "▦" + val.text;
			});		
			
			return selectedItems;
			 
		}			
		
		function callbackSel(data){
			
			jsonData = data.returnObj;	
			 
			var orgData = [];
			 
			for(var i=0;i<jsonData.length; i++){
				var data = {};
				data.value = jsonData[i].superKey;
				data.text = jsonData[i].orgName;
				
				orgData.push(data);
			}
			 
			renderPublicInfo(orgData);	

		 }
		
		function renderPublicInfo(publicList){
			
		 	 var dataSourcePublicList = new Pudd.Data.DataSource({
			 		data : publicList
				 });
			   
			 Pudd( "#publicInfo" ).puddSelectiveInput({
					// 수정모드인 경우 dataSource 전달, 신규는 해당없음
					dataSource : dataSourcePublicList
				,	dataValueField : "value"
				,	dataTextField : "text"
		 
				,	writeMode : false // 기본 입력 모드
				,	disabled : false
				,	editButton : false
				,	deleteButton : true
		 
				// 입력박스에서 내용이 없는 상태에서 backspace 입력하는 경우 이전 항목 삭제처리
				,	backspaceDelete : false
			 });
			 
			 /*
			 Pudd( "#publicInfo" ).on( "selectiveInputItemClick", function( e ) {
				 
					// e.detail 항목으로 customEvent param 전달됨
					// e.detail.spanObj - click 객체
					var evntVal = e.detail;
				 
					if( ! evntVal ) return;
					if( ! evntVal.spanObj ) return;
				 
					var valStr = "|" + evntVal.spanObj.inputObj.val() + "|";
					if(valStr.indexOf("|u|") > -1){
						var empSeq = valStr.split("|")[4];
						openEmpProfileInfoPop('','',empSeq);
					}
			 });
			 */
		}		
		
		
		
		
		
		function setDynamicPuddInfo(objKey, type, value){
			
			if(value != ""){
				
				var valueObj = {};
				
				$.each(value.split("▦▦"), function( key, val ) {
					
					var valInfo =  val.split("▦");
					
					if(valInfo.length > 1){
						valueObj[valInfo[0]] = valInfo[1];
					}else{
						valueObj[valInfo[0]] = "";
					}
					
				});			
				
				$.each($("[objkey="+objKey+"] input[type="+type+"]"), function( key, selectedObj ) {
					
					var vvalue = $(selectedObj).attr("value");
					
					if(valueObj[vvalue] != null){
						
						Pudd( selectedObj ).getPuddObject().setChecked( true );
						
						if(valueObj[vvalue] != ""){
							
							$("[objkey="+objKey+"] [name="+$(selectedObj).attr("name")+"_"+vvalue+"]").val(valueObj[vvalue]).show();
							
						}
					}
					
				});					
				
			}
			
		}
		
		function setDynamicPuddInfoTable(tableName, value){
			
			if(value != ""){
				
				$("[name="+tableName+"] [name=addData]").remove();
				
				$.each(value.split("▦▦"), function( key, val ) {
					
					var valInfo =  val.split("▦");
					
					var cloneData = $("[name="+tableName+"] [name=dataBase]").clone();
					
					$.each($(cloneData).find("[name=tableVal]"), function( key, tableVal ) {
						$(tableVal).val(valInfo[key]);
					});				
					
					$(cloneData).show().attr("name", "addData");
					$('[name="'+tableName+'"]').append(cloneData);				
					
				});	
				
				<c:if test="${ contractDetailInfo.contract_term == '02' }">
				$('[name=amtInfoList] [name=contractTerm_02]').show();
				</c:if>
				
			}
		}	
		
		

		function fnSearchFile(e){
			targetElement = $("[name=hopeAttachList]");
			document.getElementById('file_upload').addEventListener('change', handleFileSelect, false);
			$("#file_upload").click();
		}
		
	    function handleFileSelect(evt) {
	    	
	        evt.stopPropagation();
	        evt.preventDefault();
	        
	        var f = evt.target.files[0];

            var fileEx = "";
            var lastDot = f.name.lastIndexOf('.');
            
            if(lastDot > 0){
            	f.uid = '<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMdd"/>' + getUUID();
            	f.fileName = f.name.substr(0, lastDot);
            	f.fileExt = f.name.substr(lastDot);
            	
            	//동일파일명 체크
            	var sameExists = false; 
            	
				$.each($(targetElement).find("[name=addFile]"), function( key, uploadFileInfo ) {
					
					if(f.fileName == $(uploadFileInfo).find('[name="attachFileName"]').text() &&
							f.fileExt == $(uploadFileInfo).find('[name="attachExtName"]').text()){
						sameExists = true;
					}
	                
				});	   
				
				if(sameExists){
					msgSnackbar("error", "동일한 이름의 첨부파일이 존재합니다.");
				}else{
    	            var abort = false;
    	            var formData = new FormData();
    	           	var nfcFileNames = btoa(unescape(encodeURIComponent(f.name)));
    	            
   	                formData.append("file0", f);
   	             	formData.append("fileId", f.uid);
    	            formData.append("nfcFileNames", nfcFileNames);
    	    	    
    	            fnSetProgress();

    	            var AJAX = $.ajax({
    	                url: '<c:url value="/ajaxFileUploadProc.do" />',
    	                type: 'POST',
    		        	timeout:600000,
    	                xhr: function () {
    	                    myXhr = $.ajaxSettings.xhr();

    	                    if (myXhr.upload) {
    	                        myXhr.upload.addEventListener('progress', progressHandlingFunction, false);
    	                        myXhr.abort;
    	                    }
    	                    return myXhr;
    	                },
    	                success: completeHandler = function (data) {
    	                	
    	                    fnRemoveProgress();
    	                    
    	        			var cloneData = $(targetElement).find('[name="attachBase"]').clone();
    	        			$(cloneData).show().attr("name", "addFile");
    	        			$(cloneData).find('[name="attachFileName"]').attr("fileid", f.uid);
    	        			$(cloneData).find('[name="attachFileName"]').text(f.fileName);
    	        			$(cloneData).find('[name="attachExtName"]').text(f.fileExt);	
    	        			
    	        			$(targetElement).append(cloneData);
    						
    	                },
    	                error: errorHandler = function () {

    	                    if (abort) {
    	                        alert('업로드를 취소하였습니다.');
    	                    } else {
    	                        alert('첨부파일 처리중 장애가 발생되었습니다. 다시 시도하여 주십시오');
    	                    }

    	                    //UPLOAD_COMPLITE = false;
    	                    fnRemoveProgress();
    	                },
    	                data: formData,
    	                cache: false,
    	                contentType: false,
    	                processData: false
    	            });						
				}
            	
            }
	        
	      	$('#file_upload').val("");
	        
	    }
	    
	    function progressHandlingFunction(e) {
	        if (e.lengthComputable) {
	        	
	        	uploadPer = parseInt((e.loaded / e.total) * 100);
	        }
	    }			    
		
	    function fnSetProgress() {
	    	
	    	uploadPer = 0;

	    	Pudd( "#exArea" ).puddProgressBar({
	    		 
	    		progressType : "circular"
	    	,	attributes : { style:"width:70px; height:70px;" }
	    	 
	    	,	strokeColor : "#00bcd4"	// progress 색상
	    	,	strokeWidth : "3px"	// progress 두께
	    	 
	    	,	textAttributes : { style : "" }		// text 객체 속성 설정
	    	 
	    	,	percentText : ""
	    	,	percentTextColor : "#444"
	    	,	percentTextSize : "24px"
	    	,	backgroundLayerAttributes : { style : "background-color:#000;filter:alpha(opacity=20);opacity:0.2;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
	    	,	modal : true// 기본값 false - progressType : linear, circular 인 경우만 해당
	    	 
	    		// 200 millisecond 마다 callback 호출됨
	    	,	progressCallback : function( progressBarObj ) {
	    			return uploadPer;
	    		}
	    	});		    	
	    	
	    }		    
	    
	    function fnRemoveProgress() {
	    	uploadPer = 100;
	    }		
		
		function fnDownload(e){
			this.location.href = "${pageContext.request.contextPath}/fileDownloadProc.do?fileId=" + $(e).attr("fileid");
		}	
		
		function fnDelFile(e){
			targetElement = $(e).closest("li").remove();
		}		
		
		
		var callbackResult;

		function fnCommonCode_callback(param) {
			
			callbackResult = param;
			
			if(param != null){
				
				//거래처 
				if(param.code == "tr"){
					
					if($("[name=tr_seq][value="+param.trSeq+"]").length > 0){
						msgSnackbar("error", "이미 선택된 거래처입니다.");
						return;
					}					
					
					$(commonElement).find("[name=tr_seq]").val( param.trSeq || "" );
					$(commonElement).find("[name=tr_name]").val( param.trName || "" );
					
/* 					$(commonElement).find("[name=tr_reg_number]").text( param.trRegNumber || "" );
					$(commonElement).find("[name=ceo_name]").text( param.ceoName || "" );*/
					$(commonElement).find("[name=addr]").text( param.addr || "" ); 
					
					$(commonElement).find("[name=tr_reg_number]").val( param.trRegNumber || "" );
					$(commonElement).find("[name=ceo_name]").val( param.ceoName || "" );
					$(commonElement).find("[name=addr]").val( param.addr || "" );
					
					
					$(commonElement).find("[name=at_tr_name]").val( param.atTrName || "" );
					$(commonElement).find("[name=ba_nb]").val( param.baNb || "" );
					$(commonElement).find("[name=btr_name]").val( param.btrName || "" );
					$(commonElement).find("[name=btr_seq]").val( param.btrSeq || "" );
					$(commonElement).find("[name=depositor]").val( param.depositor || "" );
					$(commonElement).find("[name=tr_fg]").val( param.trFg || "" );
					$(commonElement).find("[name=tr_fg_name]").val( param.trFgName || "" );
					
				
				//회계단위	
				}else if(param.code == "div"){
					$(commonElement).find("[name=erp_budget_div_seq]").val( param.divSeq || "" );
					$(commonElement).find("[name=erp_budget_div_name]").val( param.divName || "" );
				
				//프로젝트	
				}else if(param.code == "project"){
					$(commonElement).find("[name=pjt_seq]").val( param.pjtSeq || "" );
					$(commonElement).find("[name=pjt_name]").val( param.pjtName || "" );
					
				//하위사업	
				}else if(param.code == "bottom"){
					$(commonElement).find("[name=bottom_seq]").val( param.bottomSeq || "" );
					$(commonElement).find("[name=bottom_name]").val( param.bottomName || "" );
				
				//예산과목
				}else if(param.code == "budgetlist"){
					
					if($("[name=bgt_seq][value="+param.erpBudgetSeq+"]").length > 0){
						msgSnackbar("error", "이미 선택된 예산과목입니다.");
						return;
					}
					
					$(commonElement).find("[name=erp_budget_seq]").val( param.erpBudgetSeq || "" );
					$(commonElement).find("[name=erp_budget_name]").val( param.erpBudgetName || "" );
					
					if(param.erpBgt1Seq != ""){
						$(commonElement).find("[name=erp_bgt1_seq]").val( param.erpBgt1Seq );
						$(commonElement).find("[name=erp_bgt1_name]").val( param.erpBgt1Name );	
					}else{
						$(commonElement).find("[name=erp_bgt1_seq]").val("");
						$(commonElement).find("[name=erp_bgt1_name]").val("");
					}
					
					if(param.erpBgt2Seq != ""){
						$(commonElement).find("[name=erp_bgt2_seq]").val( param.erpBgt2Seq );
						$(commonElement).find("[name=erp_bgt2_name]").val( param.erpBgt2Name );	
					}else{
						$(commonElement).find("[name=erp_bgt1_seq]").val("");
						$(commonElement).find("[name=erp_bgt2_name]").val("");
					}
					
					if(param.erpBgt3Seq != ""){
						$(commonElement).find("[name=erp_bgt3_seq]").val( param.erpBgt3Seq );
						$(commonElement).find("[name=erp_bgt3_name]").val( param.erpBgt3Name );	
					}else{
						$(commonElement).find("[name=erp_bgt3_seq]").val("");
						$(commonElement).find("[name=erp_bgt3_name]").val("");
					}
					
					if(param.erpBgt4Seq != ""){
						$(commonElement).find("[name=erp_bgt4_seq]").val( param.erpBgt4Seq );
						$(commonElement).find("[name=erp_bgt4_name]").val( param.erpBgt4Name );	
					}else{
						$(commonElement).find("[name=erp_bgt4_seq]").val("");
						$(commonElement).find("[name=erp_bgt4_name]").val("");
					}					
				
					//예산금액 조회
					fnSetBudgetAmtInfo();
					
				}			
				
			}
			
		}
		
		
		/*	[예산조회] 예산잔액 가조회
		------------------------------------------- */
		function fnSetBudgetAmtInfo(e){
			
			if(e != null){
				commonElement = e;
			}
			
			$('#bgtSeq').val("");
			$('#bgt1Name').text("");
			$('#bgt2Name').text("");
			$('#bgt3Name').text("");
			$('#bgt4Name').text("");
			
			$('#txtOpenAmt').text("");
			$('#txtConsBalanceAmt').text("");
			$('#txtApplyAmt').text("");
			$('#txtBalanceAmt').text("");			
			
			if($(commonElement).find("[name=erp_budget_seq]").val() != ""){

				commonParam.erpBudgetSeq = $(commonElement).find("[name=erp_budget_seq]").val();
				if($('#bgtSeq').val() == commonParam.erpBudgetSeq){
					return;
				}

				commonParam.erpBudgetDivSeq = $(commonElement).find("[name=erp_budget_div_seq]").val();
				commonParam.erpMgtSeq = $(commonElement).find("[name=pjt_seq]").val();
				commonParam.bottomSeq = $(commonElement).find("[name=bottom_seq]").val();
				
				$('#bgtSeq').val(commonParam.erpBudgetSeq);
				
				if($(commonElement).find("[name=erp_bgt1_seq]").val() != ""){
					$('#bgt1Name').text($(commonElement).find("[name=erp_bgt1_name]").val() + " (" + $(commonElement).find("[name=erp_bgt1_seq]").val() + ")");
					
				}
				
				if($(commonElement).find("[name=erp_bgt2_seq]").val() != ""){
					$('#bgt2Name').text($(commonElement).find("[name=erp_bgt2_name]").val() + " (" + $(commonElement).find("[name=erp_bgt2_seq]").val() + ")");
					
				}
				
				if($(commonElement).find("[name=erp_bgt3_seq]").val() != ""){
					$('#bgt3Name').text($(commonElement).find("[name=erp_bgt3_name]").val() + " (" + $(commonElement).find("[name=erp_bgt3_seq]").val() + ")");
					
				}
				
				if($(commonElement).find("[name=erp_bgt4_seq]").val() != ""){
					$('#bgt4Name').text($(commonElement).find("[name=erp_bgt4_name]").val() + " (" + $(commonElement).find("[name=erp_bgt4_seq]").val() + ")");	
				}
				
				$.ajax({
					type : 'post',
					url : '<c:url value="/ex/np/user/res/resBudgetInfoSelect.do" />',
					datatype : 'json',
					async : true,
					data : commonParam,
					success : function(result) {

/* 						var data = result.result.aData;
						$('#txtOpenAmt').text(fnGetCurrencyCode(data.openAmt));
						$('#txtConsBalanceAmt').text(fnGetCurrencyCode(data.consBalanceAmt));
						$('#txtApplyAmt').text(fnGetCurrencyCode(data.resApplyAmt));
						$('#txtBalanceAmt').text(fnGetCurrencyCode(data.balanceAmt)); */
						
						
						saveData = result.result.aData;
						$('#txtOpenAmt').text(fnGetCurrencyCode(saveData.openAmt));
						$('#txtConsBalanceAmt').text(fnGetCurrencyCode(saveData.consBalanceAmt));
						$('#txtApplyAmt').text(fnGetCurrencyCode(saveData.resApplyAmt));
						$('#txtBalanceAmt').text(fnGetCurrencyCode(saveData.balanceAmt));
						
						
/*  						$('#bgtOpen').text(fnGetCurrencyCode(saveData.openAmt));
						$('#bgtConsBalance').text(fnGetCurrencyCode(saveData.consBalanceAmt));
						$('#bgtApply').text(fnGetCurrencyCode(saveData.resApplyAmt));
						$('#bgtBalance').text(fnGetCurrencyCode(saveData.balanceAmt));  */
						
						$(commonElement).find("[name=txt_open_amt]").val(fnGetCurrencyCode(saveData.openAmt));
						$(commonElement).find("[name=txt_cons_balance_amt]").val(fnGetCurrencyCode(saveData.consBalanceAmt));
						$(commonElement).find("[name=txt_apply_amt]").val(fnGetCurrencyCode(saveData.resApplyAmt));
						$(commonElement).find("[name=txt_balance_amt]").val(fnGetCurrencyCode(saveData.balanceAmt));

					},
					/*   - error :  */
					error : function(result) {
						
						msgSnackbar("error", "예산정보 조회 중 오류 발생");
						
					}
				});				
				
			}
		}
		
		/*	[공용] 숫자에 콤마 찍어서 가져오기
		---------------------------------------- */
		function fnGetCurrencyCode(value){
		    value = '' + value || '';
		    value = '' + value.split('.')[0];
		    value = value.replace(/[^0-9\-]/g, '') || '0';
		    var returnVal = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		    return returnVal;
		}		
		
		
		function fnCommonCode_trName(code, e) {
			
			if(e != null){
				commonElement = $(e).closest("tr");
				
				if(code != "tr"){
					if(code == "budgetlist"){
						commonParam.erpDivSeq = $(commonElement).find("[name=erp_budget_div_seq]").val() + "|"; /* 회계통제단위 구분값 '|' */
						commonParam.erpMgtSeq = $(commonElement).find("[name=pjt_seq]").val() + "|"; /* 예산통제단위 구분값 '|' */
					}else{
						commonParam.erpDivSeq = $(commonElement).find("[name=erp_budget_div_seq]").val(); /* 회계통제단위 구분값 '|' */
						commonParam.erpMgtSeq = $(commonElement).find("[name=pjt_seq]").val(); /* 예산통제단위 구분값 '|' */
					}
					commonParam.bottomSeq = $(commonElement).find("[name=bottom_seq]").val(); /* 하위사업 구분값 '|' */
					commonParam.erpBudgetDivSeq = commonParam.erpDivSeq.replace('|', '');
				}

			}

			fnCommonCodePop(code, commonParam, commonParam.callback);

			/* [ return ] */
			return;
		}
		
		/* ## 공통코드 - 팝업호출 ## */
		function fnCommonCodePop(code, obj, callback, data) {
			/* [ parameter ] */
			/*   - obj : 전송할 파라미터 */
			obj = (obj || {});
			/*   - callback : 코백 호출할 함수 명 */
			callback = (callback || '');
			/*   - data : 더미 */
			data = (data || {});

			/* 팝업 호출 */
			obj.widthSize = 780;
			obj.heightSize = 582;

			fnCallCommonCodePop({
				code : code,
				popupType : 2,
				param : JSON.stringify(obj),
				callbackFunction : callback,
				dummy : JSON.stringify(data)
			});
		}			
		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;"> <!-- 팝업창사이즈 가로 : 1000px -->
	<div class="pop_sign_head posi_re">
		<h1>계약체결 등록</h1>
		<div class="psh_btnbox">
			<div class="psh_right">
				<div class="btn_cen mt8">
					<c:if test="${btnSaveYn == 'Y'}">
					<input type="button" class="psh_btn" onclick="fnCallBtn('save')" value="임시저장" />
					</c:if>
					<input type="button" class="psh_btn" onclick="fnCallBtn('attach')" value="첨부파일" />
					<c:if test="${btnApprYn == 'Y'}">
					<input type="button" class="psh_btn" onclick="fnCallBtn('appr')" value="결재작성" />
					</c:if>					
				</div>
			</div>
		</div>
	</div>


	<div class="pop_con" style="overflow: auto; min-height: 460px;">
		<div class="top_box">
			<dl>
				<dt>작성일자</dt>
				<dd objKey="c_write_dt" objCheckFor="checkVal('date', 'writeDt', '작성일자', 'selectDate(this)', '')" ><input ${disabled} name="writeDt" type="text" value="${c_write_dt}" class="puddSetup" pudd-type="datepicker"/></dd>
				
				<input objKey="c_write_comp_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${c_write_comp_seq}" />
				<input objKey="c_write_dept_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${c_write_dept_seq}" />
				<input objKey="c_write_emp_seq" objCheckFor="checkVal('text', this, '작성자', 'selectOrgchart()', '')" type="hidden" value="${c_write_emp_seq}" />
				
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="130"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>계약방법</th>
					<td>
						<select readonly disabled objKey="contract_type" objCheckFor="checkVal('select', this, '계약방법', 'mustAlert', '')" style="width:auto;min-width:100px;">
							<c:forEach var="items" items="${contractTypeCode}">
								<option value="${items.CODE}" <c:if test="${ contractType == items.CODE }">selected</c:if> >${items.NAME}</option>
							</c:forEach>
						</select>
						
						<c:if test="${ contractDetailInfo.manage_no != null && contractDetailInfo.manage_no != '' }">
						<span class="ml10">(관리번호 : ${contractDetailInfo.manage_no})</span>
						</c:if>
					</td>
				</tr>				
				<tr>
					<th>예산종류</th>
					<td objKey="c_budget_type" objCheckFor="checkVal('radio', 'budgetType', '예산종류', '', '')" >
						<c:forEach var="items" items="${budgetTypeCode}" varStatus="status">
						<input ${disabled} type="radio" name="budgetType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" <c:if test="${ (viewType == 'I' && status.index == 0) || (viewType == 'U' && items.CODE == contractDetailInfo.c_budget_type)   }">checked</c:if> />
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>목적물종류</th>
					<td objKey="c_target_type" objCheckFor="checkVal('radio', 'targetType', '목적물종류', '', '')" >
						<c:forEach var="items" items="${targetTypeCode}" varStatus="status">
						<input ${disabled} type="radio" name="targetType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}"  <c:if test="${ (viewType == 'I' && status.index == 0) || (viewType == 'U' && items.CODE == contractDetailInfo.c_target_type)   }">checked</c:if> />
						</c:forEach>						
					</td>
				</tr>
				<tr>
					<th>담당자</th>
					<td objKey="public_info" objCheckFor="getPublicInfo()" >
						<div id="publicInfo" style="min-width:200px;"></div>
						<c:if test="${disabledYn == 'N'}">
						<input onclick="selectOrgchart()" type="button" value="선택" />
						</c:if>	
					</td>
				</tr>				
			</table>
		</div>
		
		<!-- 기본사항 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">기본사항</p>
			</div>
		</div>
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="130"/>
					<col width=""/>
					<col width="130"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약명</th>
					<td colspan="3"><input ${disabled} onkeyup="chkChar(this)" objKey="c_title" objCheckFor="checkVal('text', this, '계약명', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="${contractDetailInfo.c_title}" /></td>
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약기간(1)</th>
					<td objKey="c_contract_end_dt" objCheckFor="checkVal('date', 'contractEndDt', '계약기간(1)', 'selectDate(this)', '')" >계약체결일 ~ <input ${disabled} name="contractEndDt" type="text" value="${contractDetailInfo.c_contract_end_dt}" class="puddSetup" pudd-type="datepicker"/></td>
					
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약기간(2)</th>
					<td objKey="contract_term" objCheckFor="checkVal('radio', 'contractTerm', '계약기간(2)', '', '')" >
						<c:forEach var="items" items="${contractTermCode}" varStatus="status">
						<input ${disabled} type="radio" onclick="fnChangeEtc(this, 'amtInfoList')" name="contractTerm" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}"  <c:if test="${ (viewType == 'I' && status.index == 0) || (viewType == 'U' && items.CODE == contractDetailInfo.contract_term)   }">checked</c:if> />
						</c:forEach>						
					</td>					
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약체결형태(1)</th>
					<td>
						<select ${disabled} objKey="c_contract_form1" objCheckFor="checkVal('select', this, '계약체결형태(1)', '', '')" class="puddSetup" pudd-style="width:150px;">
							<c:forEach var="items" items="${contractForm1Code}">
								<option value="${items.CODE}" <c:if test="${ items.CODE == contractDetailInfo.c_contract_form1 }">selected</c:if>>${items.NAME}</option>
							</c:forEach>							
						</select>
					</td>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약체결형태(2)</th>
					<td>
						<select ${disabled} objKey="c_contract_form2" objCheckFor="checkVal('select', this, '계약체결형태(2)', '', '')" class="puddSetup" pudd-style="width:150px;">
							<c:forEach var="items" items="${contractForm2Code}">
								<option value="${items.CODE}" <c:if test="${ items.CODE == contractDetailInfo.c_contract_form2 }">selected</c:if>>${items.NAME}</option>
							</c:forEach>
						</select>
					</td>
				</tr>				
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약내용</th>
					<td colspan="3">
					<textarea cols="170" rows="3" ${disabled} objKey="c_work_info" objCheckFor="checkVal('text', this, '계약내용', 'mustAlert', '')" class="puddSetup" >${contractDetailInfo.c_work_info}</textarea>
					<%-- <input ${disabled} objKey="c_work_info" objCheckFor="checkVal('text', this, '계약내용', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="${contractDetailInfo.c_work_info}" /> --%>
					</td>
				</tr>				
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 계약금액</th>
					<td colspan="3">
						<!-- 그리드 -->
						<div class="com_ta4">
							<table name="amtInfoList" objKey="contract_amt_info" objCheckFor="checkVal('table', 'amtInfoList', '계약금액', 'true', 'notnull')">
								<colgroup>
									<c:if test="${disabledYn == 'N'}"> 
									<col name="contractTerm_02" style="display:none;" width="50"/>
									</c:if>
									<col name="contractTerm_02" style="display:none;" width="130"/>
									<col width=""/>
									<col width=""/>
									<col width=""/>
								</colgroup>
								<tr>
									<c:if test="${disabledYn == 'N'}"> 
									<th name="contractTerm_02" style="display:none;" class="ac">
										<input type="button" onclick="fnSectorAdd('amtInfoList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									</c:if>
									<th name="contractTerm_02" style="display:none;" class="ac">연도</th>
									<th class="ac">기초금액</th>
									<th class="ac">추정가격</th>
									<th class="ac">부가가치세</th>
								</tr>
								<tr name="dataBase" style="display:none;">
									<c:if test="${disabledYn == 'N'}"> 
									<td name="contractTerm_02" style="display:none;">
										<input type="button" onclick="fnSectorDel(this, 'amtInfoList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>
									<td name="contractTerm_02" style="display:none;">
										<select ${disabled} name="tableVal" ${disabled} name="tableVal" style="width: 90%;">
											<c:forEach var="items" items="${contractYearCode}">
												<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>											
										</select>
									</td>
									<td class="le"><input ${disabled} amountType="amt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원 <span name="viewKorean" ></span></td>
									<td class="ri"><input ${disabled} amountType="stdAmt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원</td>
									<td class="ri"><input ${disabled} amountType="taxAmt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원</td>
								</tr>								
								<tr name="addData">
									<c:if test="${disabledYn == 'N'}"> 
									<td name="contractTerm_02" style="display:none;">
										<input type="button" onclick="fnSectorDel(this, 'amtInfoList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>
									<td name="contractTerm_02" style="display:none;">
										<select ${disabled} name="tableVal" ${disabled} name="tableVal" style="width: 90%;">
											<c:forEach var="items" items="${contractYearCode}">
												<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>											
										</select>
									</td>
									<td class="le"><input ${disabled} amountType="amt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원 <span name="viewKorean" ></span></td>
									<td class="ri"><input ${disabled} amountType="stdAmt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원</td>
									<td class="ri"><input ${disabled} amountType="taxAmt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 공동계약방법</th>
					<td colspan="3" objKey="joint_contract_method" objCheckFor="checkVal('radio', 'jointContractMethod', '공동계약방법', '', '')" >
						<c:forEach var="items" items="${jointContractMethod}" varStatus="status">
						<input ${disabled} type="radio" name="jointContractMethod" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}"  <c:if test="${ (viewType == 'I' && status.index == 0) || (viewType == 'U' && items.CODE == contractDetailInfo.joint_contract_method)   }">checked</c:if> />
						</c:forEach>						
					</td>						
				</tr>				
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 계약법령</th>
					<td colspan="3">
						<select ${disabled} type="select" name="contractLaw" onchange="Pudd( '[objkey=private_reason]' ).getPuddObject().setSelectedIndex($(this).val());fnChangeEtc(this);fnChangeEtc($('[name=privateReason]'));" objKey="contract_law" objCheckFor="checkVal('select', this, '계약법령', 'mustAlert', '|etc|')" class="puddSetup" pudd-style="width:auto;min-width:150px;">
							<c:forEach var="items" items="${contractLawCode}">
								<option value="${items.CODE}" <c:if test="${ viewType == 'U' && (items.CODE == contractDetailInfo.contract_law || (items.CODE == 'etc' && contractDetailInfo.contract_law.indexOf('etc▦') > -1))}">selected</c:if> >${items.NAME}</option>
							</c:forEach>							
						</select>					
						<input name="contractLaw_etc" style="<c:if test="${ viewType == 'I' || (viewType == 'U' && contractDetailInfo.contract_law.indexOf('etc▦') == -1 ) }">display:none;</c:if>width:100%;" type="text" value="<c:if test="${ viewType == 'U' && contractDetailInfo.contract_law.indexOf('etc▦') > -1 }">${(contractDetailInfo.contract_law).substring(4)}</c:if>" />
					</td>
				</tr>
				<tr <c:if test="${contractType == '01'}">style="display:none;"</c:if>>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 수의계약사유</th>
					<td colspan="3">
						<select ${disabled} type="select" name="privateReason" onchange="fnChangeEtc(this);" objKey="private_reason" objCheckFor="checkVal('select', this, '수의계약사유', 'mustAlert', '|etc|')" class="puddSetup" pudd-style="width:auto;min-width:150px;">
							<c:forEach var="items" items="${privateReasonCode}">
								<option value="${items.CODE}" <c:if test="${ viewType == 'U' && (items.CODE == contractDetailInfo.private_reason || (items.CODE == 'etc' && contractDetailInfo.private_reason.indexOf('etc▦') > -1))}">selected</c:if> >${items.NAME}</option>
							</c:forEach>							
						</select>		
						<input name="privateReason_etc" style="<c:if test="${ viewType == 'I' || (viewType == 'U' && contractDetailInfo.private_reason.indexOf('etc▦') == -1 ) }">display:none;</c:if>width:100%;" type="text" value="<c:if test="${ viewType == 'U' && contractDetailInfo.private_reason.indexOf('etc▦') > -1 }">${(contractDetailInfo.private_reason).substring(4)}</c:if>" />
					</td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 희망기업여부</th>
					<td>
						<div class="multi_sel" style="width:calc( 100% - 58px);">
							<ul name="hopeCompanyList" objKey="hope_company_info" objCheckFor="checkVal('ul', 'hopeCompanyList', '희망기업여부', 'mustAlert', '')" class="multibox" style="width:100%;">							
								<li name="dataBase" addCode="" style="display:none;">
									<span name="addName"></span>
									<c:if test="${disabledYn == 'N'}"> 
									<a href="#n" onclick="$(this).closest('li').remove();" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a>
									</c:if>
								</li>
							</ul>								
						</div>
						
						<c:if test="${disabledYn == 'N'}"> 
						<div class="controll_btn p0 pt4">	
							<button id="" onclick="commonCodeSelectLayer('hopeCompany', '희망기업여부', 'ul', 'hopeCompanyList', 'Y')">선택</button>
						</div>
						</c:if>
					</td>
					<th><%-- <img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> --%> 희망기업확인서</th>
					<td class="file_add">	
						<ul objKey="hope_attach_info" objCheckFor="checkVal('file', 'hopeAttachList', '희망기업확인서', 'mustAlert', '')" class="file_list_box fl" name="hopeAttachList">
							<li name="attachBase" style="display:none;">
								<img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" class="fl" alt="">
								<a href="javascript:;" name="attachFileName" onClick="fnDownload(this)" class="fl ellipsis pl5" style="max-width: 250px;"></a>
								<span name="attachExtName"></span>
								<c:if test="${disabledYn == 'N'}"> 
								<a href="javascript:;" onclick="fnDelFile(this)" title="파일삭제"><img src="${pageContext.request.contextPath}/customStyle/Images/btn/close_btn01.png" alt=""></a>
								</c:if>
							</li>
						</ul>
						<c:if test="${disabledYn == 'N'}">
						<span class="fr mt2"><input onclick="fnSearchFile(this)" type="button" class="puddSetup" value="파일찾기" /></span>
						</c:if>
					</td>
				</tr>
			</table>
		</div>

		
		<!-- 계약대상 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">계약대상</p>
			</div>
		</div>
				
		<div class="com_ta mt10">
			<table name="tradeList" objKey="tradeObjList" objCheckFor="checkVal('obj', 'tradeList', '계약대상', 'mustAlert', '')">
				<colgroup>
					<c:if test="${disabledYn == 'N'}"> 
					<col width="50"/>
					</c:if>				
					<col width="200"/>
					<col width="120"/>
					<col width="80"/>
					<col width=""/>
					<col width="100"/>
					<col width="150"/>
					<col width="150"/>
				</colgroup>
				<tr>
					<c:if test="${disabledYn == 'N'}"> 
					<th class="cen">
						<input type="button" onclick="fnSectorAdd('tradeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
					</th>
					</c:if>				
					<th class="cen">사업자명</th>
					<th class="cen">사업자등록번호</th>
					<th class="cen">대표자</th>
					<th class="cen">사업장주소</th>
					<th class="cen">담당자(PM) 성명</th>
					<th class="cen">담당자(PM) 연락처</th>
					<th class="cen">담당자(PM) 전자우편</th>
				</tr>
				<tr name="dataBase" style="display:none;">
					<c:if test="${disabledYn == 'N'}"> 
					<td>
						<input type="button" onclick="fnSectorDel(this, 'tradeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					</c:if>				
					<td>
						<div class="posi_re">
							<input tbval="Y" name="at_tr_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="ba_nb" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="btr_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="btr_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="tr_fg" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="tr_fg" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="tr_fg_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="depositor" type="hidden" value="" requiredNot="true" />
						
							<input tbval="Y" name="tr_seq" type="hidden" value="" />
							<input tbval="Y" name="tr_name" type="text" pudd-style="width:calc( 100% );" class="puddSetup pr30" value="" readonly />
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCode_trName('tr', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
<!-- 					<td tbval="Y" name="tr_reg_number"  requiredNot="true" class="cen" ></td>
					<td tbval="Y" name="ceo_name" requiredNot="true" class="cen" ></td>
					<td tbval="Y" name="addr"  requiredNot="true" ></td> -->  
					
					<td><input  tbval="Y" name="tr_reg_number" type="text" style="border: none; pudd-style="width:100%;" class="cen" value="" requiredNot="true" readonly/></td>
					<td><input  tbval="Y" name="ceo_name" type="text" style="border: none; pudd-style="width:100%;" class="cen" value="" requiredNot="true" readonly/></td>
					<td tbval="Y" name="addr"  requiredNot="true"><input  tbval="Y" name="addr" type="hidden" style="border: none; pudd-style="width:100%;" value="" requiredNot="true" readonly/></td> 
					
					<td><input  tbval="Y" name="pm_name" type="text" pudd-style="width:100%;" class="puddSetup ac" value="" requiredNot="true" /></td>
					<td><input  tbval="Y" name="pm_hp" type="text" pudd-style="width:100%;" class="puddSetup" value="" requiredNot="true" /></td>
					<td><input  tbval="Y" name="pm_email" type="text" pudd-style="width:100%;" class="puddSetup" value="" requiredNot="true" /></td>
				</tr>
				<tr name="addData">
					<c:if test="${disabledYn == 'N'}"> 
					<td>
						<input type="button" onclick="fnSectorDel(this, 'tradeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					</c:if>				
					<td>
						<div class="posi_re">
							<input tbval="Y" name="at_tr_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="ba_nb" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="btr_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="btr_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="tr_fg" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="tr_fg_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="depositor" type="hidden" value="" requiredNot="true" />
						
							<input tbval="Y" name="tr_seq" type="hidden" value="" />
							<input tbval="Y" name="tr_name" type="text" pudd-style="width:calc( 100% );" class="puddSetup pr30" value="" readonly />
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCode_trName('tr', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<!-- <td tbval="Y" name="tr_reg_number"  requiredNot="true" class="cen" ></td>
					<td tbval="Y" name="ceo_name" requiredNot="true" class="cen" ></td>
					<td tbval="Y" name="addr"  requiredNot="true" ></td> -->
					
					<td><input  tbval="Y" name="tr_reg_number" type="text" style="border: none; pudd-style="width:100%;" class="cen" value="" requiredNot="true" readonly/></td>
					<td><input  tbval="Y" name="ceo_name" type="text" style="border: none; pudd-style="width:100%;" class="cen" value="" requiredNot="true" readonly/></td>
					
					<td tbval="Y" name="addr"  requiredNot="true" ><input  tbval="Y" name="addr" type="hidden" style="border: none; pudd-style="width:100%;" value="" requiredNot="true" readonly/></td>
					
					<td><input  tbval="Y" name="pm_name" type="text" pudd-style="width:100%;" class="puddSetup ac" value="" requiredNot="true" /></td>
					<td><input  tbval="Y" name="pm_hp" type="text" pudd-style="width:100%;" class="puddSetup" value="" requiredNot="true" /></td>
					<td><input  tbval="Y" name="pm_email" type="text" pudd-style="width:100%;" class="puddSetup" value="" requiredNot="true" /></td>
				</tr>
			</table>
		</div>


		<!-- 예산정보 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">예산정보</p>
			</div>
		</div>
		
		<div class="com_ta4">
			<table name="budgetList" objKey="budgetObjList" objCheckFor="checkVal('obj', 'budgetList', '예산정보', 'mustAlert', '')">
				<colgroup>
					<c:if test="${disabledYn == 'N'}"> 
					<col width="50"/>
					</c:if>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
				</colgroup>
				<tr>
					<c:if test="${disabledYn == 'N'}"> 
					<th class="ac">
						<input type="button" onclick="fnSectorAdd('budgetList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
					</th>
					</c:if>
					<th optionTarget="def_erp_budget_div_seq" class="ac">예산회계단위</th>
					<th class="ac">프로젝트</th>
					<th class="ac">하위사업</th>
					<th class="ac">예산과목</th>
					<th class="ac">금액</th>
				</tr>
				<tr name="dataBase" onclick="fnSetBudgetAmtInfo(this);" style="display:none;">
					<c:if test="${disabledYn == 'N'}"> 
					<td>
						<input type="button" onclick="fnSectorDel(this, 'budgetList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					</c:if>
					<td optionTarget="def_erp_budget_div_seq">
						<div class="posi_re">
							<input tbval="Y" name="erp_budget_div_seq" type="hidden" value="" />
							<input tbval="Y" name="erp_budget_div_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />							
							
							<c:if test="${disabledYn == 'N'}">
							<a href="#n" onclick="fnCommonCode_trName('div', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="pjt_seq" type="hidden" value="" />
							<input tbval="Y" name="pjt_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />							

							<c:if test="${disabledYn == 'N'}">
							<a href="#n" onclick="fnCommonCode_trName('project', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="bottom_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="bottom_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" requiredNot="true" readonly />							
							
							<c:if test="${disabledYn == 'N'}">
							<a href="#n" onclick="fnCommonCode_trName('bottom', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="amt" type="hidden" value="0" requiredNot="true" />
							<input tbval="Y" name="erp_bgt1_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt2_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt3_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt4_seq" type="hidden" value="" requiredNot="true" />
													
							<input tbval="Y" name="erp_bgt1_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt2_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt3_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt4_name" type="hidden" value="" requiredNot="true" />
						
							<input tbval="Y" name="erp_budget_seq" type="hidden" value="" />
							<input tbval="Y" name="erp_budget_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />
							
							<input tbval="Y" name="txt_open_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_cons_balance_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_apply_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_balance_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_pay_amt" type="hidden" value="" requiredNot="true" />
							

							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCode_trName('budgetlist', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="amt" type="text" pudd-style="width:calc( 90% );" class="puddSetup ar" value="" amountInput="Y" />							
						</div>
					</td>	
				</tr>
				
				<tr name="addData" onclick="fnSetBudgetAmtInfo(this);">
					<c:if test="${disabledYn == 'N'}"> 
					<td>
						<input type="button" onclick="fnSectorDel(this, 'budgetList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					</c:if>
					<td optionTarget="def_erp_budget_div_seq">
						<div class="posi_re">
							<input tbval="Y" name="erp_budget_div_seq" type="hidden" value="" />
							<input tbval="Y" name="erp_budget_div_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />							
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCode_trName('div', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="pjt_seq" type="hidden" value="" />
							<input tbval="Y" name="pjt_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />							
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCode_trName('project', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="bottom_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="bottom_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" requiredNot="true" readonly />							
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCode_trName('bottom', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="amt" type="hidden" value="0" requiredNot="true" />
							<input tbval="Y" name="erp_bgt1_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt2_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt3_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt4_seq" type="hidden" value="" requiredNot="true" />
													
							<input tbval="Y" name="erp_bgt1_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt2_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt3_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="erp_bgt4_name" type="hidden" value="" requiredNot="true" />
						
							<input tbval="Y" name="erp_budget_seq" type="hidden" value="" />
							<input tbval="Y" name="erp_budget_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />
							
							
							<input tbval="Y" name="txt_open_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_cons_balance_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_apply_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_balance_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_pay_amt" type="hidden" value="" requiredNot="true" />
							
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" ${disabled} onclick="fnCommonCode_trName('budgetlist', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input ${disabled} tbval="Y" name="amt" type="text" pudd-style="width:calc( 90% );" class="puddSetup ar" value="" amountInput="Y" />							
						</div>
					</td>	
				</tr>				
				
			</table>
		</div>

		<!-- 테이블 -->
		<div class="com_ta6 mt10">
			<table name="amtgetList">
				<colgroup>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
				</colgroup>
				<tr>
					<input id="bgtSeq" type="hidden" value="" />
					<th>관</th>
					<td id="bgt1Name" name="bgt1Name" objCheckFor="checkVal('text()', this, '관', '', '')"></td>
					<th>항</th>
					<td id="bgt2Name" name="bgt2Name" objCheckFor="checkVal('text()', this, '항', '', '')"></td>
					<th>목</th>
					<td id="bgt3Name" name="bgt3Name" objCheckFor="checkVal('text()', this, '목', '', '')"></td>
					<th>세</th>
					<td id="bgt4Name" name="bgt4Name" objCheckFor="checkVal('text()', this, '세', '', '')"></td>
				</tr>				
				<tr>
		 			<%-- <c:if test="${btnSaveYn == 'Y'}">  --%>
					<th>예산액</th>
					<td class="ri pr10" id="txtOpenAmt" name="txtOpenAmt"></td>
					<th>집행액</th>
					<td class="ri pr10" id="txtConsBalanceAmt" name="txtConsBalanceAmt"></td>
					<th>품의액</th>
					<td class="ri pr10" id="txtApplyAmt" name="txtApplyAmt"></td>
					<th>예산잔액</th>
					<td class="ri pr10" id="txtBalanceAmt" name="txtBalanceAmt"></td>
					<%-- </c:if> --%>
					
	<%-- 				<c:if test="${btnSaveYn == 'N'}">
					<th>예산액</th>
					<td class="ri pr10" id="txtOpenAmt1"></td>
					<th>집행액</th>
					<td class="ri pr10" id="txtConsBalanceAmt1"></td>
					<th>품의액</th>
					<td class="ri pr10" id="txtApplyAmt1"></td>
					<th>예산잔액</th>
					<td class="ri pr10" id="txtBalanceAmt1"></td>
					</c:if>  --%>
				</tr>
			</table>
		</div>			
		<!-- 그리드 테이블 -->
		<!-- <div class="com_ta6 mt10"> -->
		<div id="resultAmtListHtmlre" name="resultAmtListHtmlre" class="com_ta6 mt10" style="display:none;">
		<!-- <div id="resultAmtListHtmlre" name="resultAmtListHtmlre" class="com_ta6 mt10" > -->
			<table id="resultAmtListHtml" name="resultAmtListHtml" border="1" width="100%" >
				<colgroup>
					<col width=""/>	
					<col width=""/>			
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
				</colgroup>
				<thead>
				<tr>			
					<th align="center" bgcolor="#f1f1f1" height="25" width="40"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">구분</span></th>	
					<th align="center" bgcolor="#f1f1f1" height="25"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">사업명</span></th>
					<th align="center" bgcolor="#f1f1f1" height="25"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">항</span></th>
					<th align="center" bgcolor="#f1f1f1" height="25"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">목</span></th>
					<th align="center" bgcolor="#f1f1f1" height="25"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">예산액</span></th>
					<th align="center" bgcolor="#f1f1f1" height="25"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">기 집행액</span></th>
					<th align="center" bgcolor="#f1f1f1" height="25"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">기 품의액</span></th>
					<th align="center" bgcolor="#f1f1f1" height="25"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">금회 품의액</span></th>
					<th align="center" bgcolor="#f1f1f1" height="25"><span style="font-family:굴림;font-size:8pt;color:rgb(0, 0, 0);">예산잔액</span></th>
				</tr>	
				</thead>
				<tbody>
				<tr name="amtDatabase">			
					<!-- <td><input   value="" />구분</td> -->
					<td align="center" height="20" class="bgtAmtnum"></td>
					<td align="center" height="20" class="bgtAmt1Name" ></td>
					<td align="center" height="20" class="bgtAmt2Name" ></td>
					<td align="center" height="20" class="bgtAmt3Name" ></td>
					<td align="center" height="20" class="txtbgtAmt"></td>
					<td align="center" height="20" class="txtbgtOpenAmt"></td>
					<td align="center" height="20" class="txtbgtConsBalanceAmt"></td>
					<td align="center" height="20" class="txtbgtApplyAmt"></td>
					<td align="center" height="20" class="txtbgtBalanceAmt"></td>
				</tr>
				</tbody>	
				<tfoot style="display:none">
				<tr name="amtDatabase">			
					<!-- <td><input   value="" />구분</td> -->
					<td align="center" height="20" class="bgtAmtnum"></td>
					<td align="center" height="20" class="bgtAmt1Name" ></td>
					<td align="center" height="20" class="bgtAmt2Name" ></td>
					<td align="center" height="20" class="bgtAmt3Name" ></td>
					<td align="center" height="20" class="txtbgtAmt"></td>
					<td align="center" height="20" class="txtbgtOpenAmt"></td>
					<td align="center" height="20" class="txtbgtConsBalanceAmt"></td>
					<td align="center" height="20" class="txtbgtApplyAmt"></td>
					<td align="center" height="20" class="txtbgtBalanceAmt"></td>
				</tr>
				</tfoot>
			</table>
		</div>
		
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->

<div id="exArea"></div>
<form id="frmPop" name="frmPop"> 
		<input type="hidden" name="selectedItems" id="selectedItems" value="" />
		<input type="hidden" name="popUrlStr" id="txt_popup_url" value="/gw/systemx/orgChart.do" />
		<input type="hidden" name="selectMode" id="selectMode" value="u" />
		<input type="hidden" name="selectItem" value="m" />
		<input type="hidden" name="callback" id="callback" value="" />
		<input type="hidden" name="compSeq" value="" />
		<input type="hidden" name="callbackUrl" value="/gw/html/common/callback/cmmOrgPopCallback.jsp"/>
		<input type="hidden" name="empUniqYn" value="Y" />
		<input type="hidden" name="empUniqGroup" value="ALL" />
</form>
<input style="display:none;" id="file_upload" type="file" />
</body>
</html>