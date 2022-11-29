<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	    
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/pudd/pudd-1.1.200.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script>  
    <script type="text/javascript" src="<c:url value='/js/jquery.maskMoney.js' />"></script>  
	
	<script type="text/javascript">
	
		var outProcessCode = "Conclusion01";
		var disabledYn = "${disabledYn}";
		
		var insertDataObject = {};
		
		var attachFormList = [];
		var attachForm_Conclusion01 = [];
		var attachForm_Conclusion02 = [];
		var attachFileNew = [];
		var attachFileDel = [];		
		
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
		
		attachForm_Conclusion01.push(tempObj);
		</c:forEach>
		
		<c:forEach var="items" items="${attachForm_Conclusion02}">
		
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
		
		attachForm_Conclusion02.push(tempObj);
		</c:forEach>		
	
		$(document).ready(function() {
			
			amountInputSet();
			
			/*
			$('#amt, #stdAmt, #taxAmt').maskMoney({
				precision : 0,
				allowNegative: false
			});
			
			$('#amt').keyup(function() {
				var amtInt = $('#amt').val().replace(/,/g, '');
				
				$('#stdAmt').val((Math.floor(amtInt*0.9)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$('#taxAmt').val((Math.floor(amtInt*0.1)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				
				$('#amt_han').text(viewKorean($('#amt').val().replace(/,/g, '')));
				$('#stdAmt_han').text(viewKorean($('#stdAmt').val().replace(/,/g, '')));
				$('#taxAmt_han').text(viewKorean($('#taxAmt').val().replace(/,/g, '')));
				
			});			
			
			//기존설정항목 세팅
			<c:if test="${viewType == 'U'}">
			setDynamicPuddInfo("pay_type_info", "checkbox", "${contractDetailInfo.pay_type_info}");
			setDynamicPuddInfo("restrict_area_info", "checkbox", "${contractDetailInfo.restrict_area_info}");
			setDynamicPuddInfo("decision_type_info", "radio", "${contractDetailInfo.decision_type_info}");
			setDynamicPuddInfoTable("restrictSectorList", "setorAddBase", "${contractDetailInfo.restrict_sector_info}");
			setDynamicPuddInfoTable("nomineeList", "nomineeAddBase", "${contractDetailInfo.nominee_info}");
			</c:if>
			
			$('#amt_han').text(viewKorean($('#amt').val().replace(/,/g, '')));
			$('#stdAmt_han').text(viewKorean($('#stdAmt').val().replace(/,/g, '')));
			$('#taxAmt_han').text(viewKorean($('#taxAmt').val().replace(/,/g, '')));	
			
			*/
			
		});
		
		function amountInputSet(){
			
			$('[amountInput=Y]').maskMoney({
				precision : 0,
				allowNegative: false
			});
			
			$('[amountType=amt]').keyup(function() {
				
				var amtInt = $(this).val().replace(/,/g, '');
				var targetTr = $(this).closest("tr[name=addData]");
				
				$(targetTr).find("[amounttype=stdAmt]").val((Math.floor(amtInt*0.9)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(targetTr).find("[amounttype=taxAmt]").val((Math.floor(amtInt*0.1)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(targetTr).find("[name=viewKorean]").text(viewKorean(amtInt));
				
			});						
			
			
		}		
		
		function attachLayerPop(){
			
			if(attachFormList.length == 0){
				msgAlert("error", "첨부파일 양식코드가 존재하지 않습니다.", "");
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
			insertDataObject.outProcessCode = outProcessCode;
			insertDataObject.seq = "${seq}"
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/attachSaveProc.do" />',
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
		
		function fnSectorAdd(tableName, baseName, maxCnt){
			
			var aaDataCnt = $('[name="'+tableName+'"] [name=addData]').length + 1;
			
			if(maxCnt != null && aaDataCnt > maxCnt){
				msgSnackbar("warning", "등록 가능한 개수를 초과했습니다.");
				return;
			}			
			
			var cloneData = $('[name="'+baseName+'"]').clone();
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
			insertDataObject.outProcessCode = outProcessCode;
			insertDataObject.viewType = "${viewType}"
			insertDataObject.seq = "${seq}"
			
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
							openWindow2("${pageContext.request.contextPath}/purchase/ApprCreate.do?outProcessCode="+outProcessCode+"&seq=" + result.resultData.seq,  "ApprCreatePop", 1000, 729, 1, 1) ;
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
			if(opener != null && typeof opener.fnGetListBind != "undefined"){
				opener.fnGetListBind();
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
		
		function selectOrgchart(){
			
			 $("#selectedItems").val($("#createSuperKey").val());	 
			 
			 var pop = window.open("", "cmmOrgPop", "width=799,height=769,scrollbars=no");
				$("#callback").val("callbackSel");
				frmPop.target = "cmmOrgPop";
				frmPop.method = "post";
				frmPop.action = "/gw/systemx/orgChart.do";
				frmPop.submit();
				pop.focus();
		 }	
		
		function callbackSel(data){	 

			if(data.returnObj.length > 0){
				
				$("#createDeptName").val(data.returnObj[0].deptName);
				$("#createEmpName").val(data.returnObj[0].empName);
				$("[objKey='write_comp_seq']").val(data.returnObj[0].compSeq);
				$("[objKey='write_dept_seq']").val(data.returnObj[0].deptSeq);
				$("[objKey='write_emp_seq']").val(data.returnObj[0].empSeq);
				$("#createSuperKey").val(data.returnObj[0].superKey);
				
			}else{
				
				msgSnackbar("error", "작성자 선택은 필수입니다.");
				
			}

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
		
		function setDynamicPuddInfoTable(tableName, baseName, value){
			
			if(value != ""){
				
				$("[name="+tableName+"] [name=addData]").remove();
				
				$.each(value.split("▦▦"), function( key, val ) {
					
					var valInfo =  val.split("▦");
					
					var cloneData = $('[name="'+baseName+'"]').clone();
					
					$.each($(cloneData).find("[name=tableVal]"), function( key, tableVal ) {
						
						$(tableVal).val(valInfo[key]);
						
					});				
					
					$(cloneData).show().attr("name", "addData");
					$('[name="'+tableName+'"]').append(cloneData);				
					
				});	
				
			}
		}		
		

		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;"> <!-- 팝업창사이즈 가로 : 1000px -->
	<div class="pop_sign_head posi_re">
		<h1>계약입찰 발주계획 등록</h1>
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
				<dt>작성부서/작성자</dt>
				<dd><input id="createDeptName" type="text" disabled pudd-style="width:200px;" class="puddSetup" value="${createDeptName}" placeholder="작성부서" /></dd>
				<dd><input id="createEmpName" type="text" disabled pudd-style="width:100px;" class="puddSetup" value="${createEmpName}" placeholder="작성자" /></dd>
				<input objKey="write_comp_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${write_comp_seq}" />
				<input objKey="write_dept_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${write_dept_seq}" />
				<input objKey="write_emp_seq" objCheckFor="checkVal('text', this, '작성자', 'selectOrgchart()', '')" type="hidden" value="${write_emp_seq}" />
				<input id="createSuperKey" type="hidden" value="${createSuperKey}" />
				<c:if test="${disabledYn == 'N'}">
				<dd><input onclick="selectOrgchart()" type="button" value="선택" /></dd>
				</c:if>				
				<dt>작성일자</dt>
				<dd objKey="write_dt" objCheckFor="checkVal('date', 'writeDt', '작성일자', 'selectDate(this)', '')" ><input ${disabled} name="writeDt" type="text" value="${write_dt}" class="puddSetup" pudd-type="datepicker"/></dd>
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
					<th>예산종류</th>
					<td objKey="budget_type" objCheckFor="checkVal('radio', 'budgetType', '예산종류', '', '')" >
						<c:forEach var="items" items="${budgetTypeCode}" varStatus="status">
						<input ${disabled} type="radio" name="budgetType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" <c:if test="${ (viewType == 'I' && status.index == 0) || (viewType == 'U' && items.CODE == contractDetailInfo.budget_type)   }">checked</c:if> />
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>목적물종류</th>
					<td objKey="target_type" objCheckFor="checkVal('radio', 'targetType', '목적물종류', '', '')" >
						<c:forEach var="items" items="${targetTypeCode}" varStatus="status">
						<input ${disabled} type="radio" name="targetType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}"  <c:if test="${ (viewType == 'I' && status.index == 0) || (viewType == 'U' && items.CODE == contractDetailInfo.target_type)   }">checked</c:if> />
						</c:forEach>						
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
					<td colspan="3"><input ${disabled} objKey="title" objCheckFor="checkVal('text', this, '공고명', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="<c:if test="${ viewType == 'U' }">${contractDetailInfo.title}</c:if>" /></td>
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약기간(1)</th>
					<td objKey="contract_end_dt" objCheckFor="checkVal('date', 'contractEndDt', '계약기간(1)', 'selectDate(this)', '')" >계약체결일 ~ <input ${disabled} name="contractEndDt" type="text" value="<c:if test="${ viewType == 'U' }">${contractDetailInfo.contract_end_dt}</c:if>" class="puddSetup" pudd-type="datepicker"/></td>
					
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약기간(2)</th>
					<td objKey="contract_term" objCheckFor="checkVal('radio', 'targetType', '계약기간(2)', '', '')" >
						<c:forEach var="items" items="${contractTermCode}" varStatus="status">
						<input ${disabled} type="radio" onclick="fnChangeEtc(this, 'amtInfoList')" name="contractTerm" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}"  <c:if test="${ (viewType == 'I' && status.index == 0) || (viewType == 'U' && items.CODE == contractDetailInfo.contract_term)   }">checked</c:if> />
						</c:forEach>						
					</td>					
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약내용</th>
					<td colspan="3"><input ${disabled} objKey="work_info" objCheckFor="checkVal('text', this, '계약내용', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="<c:if test="${ viewType == 'U' }">${contractDetailInfo.work_info}</c:if>" /></td>
				</tr>				
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 계약금액</th>
					<td colspan="3">
						<!-- 그리드 -->
						<div class="com_ta4">
							<table name="amtInfoList" objKey="amt_info" objCheckFor="checkVal('table', 'amtInfoList', '계약금액', 'true', 'notnull')">
								<colgroup>
									<col name="contractTerm_02" style="display:none;" width="50"/>
									<col name="contractTerm_02" style="display:none;" width="130"/>
									<col width=""/>
									<col width=""/>
									<col width=""/>
								</colgroup>
								<tr>
									<th name="contractTerm_02" style="display:none;" class="ac">
										<input type="button" onclick="fnSectorAdd('amtInfoList', 'amtInfoAddBase')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									<th name="contractTerm_02" style="display:none;" class="ac">연도</th>
									<th class="ac">기초금액</th>
									<th class="ac">추정가격</th>
									<th class="ac">부가가치세</th>
								</tr>
								<tr name="amtInfoAddBase" style="display:none;">
									<td name="contractTerm_02" style="display:none;">
										<input type="button" onclick="fnSectorDel(this, 'amtInfoList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td name="contractTerm_02" style="display:none;">
										<select name="tableVal" ${disabled} name="tableVal" style="width: 90%;">
											<c:forEach var="items" items="${contractYearCode}">
												<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>											
										</select>
									</td>
									<td class="le"><input amountType="amt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원 <span name="viewKorean" ></span></td>
									<td class="ri"><input amountType="stdAmt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원</td>
									<td class="ri"><input amountType="taxAmt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원</td>
								</tr>								
								<tr name="addData">
									<td name="contractTerm_02" style="display:none;">
										<input type="button" onclick="fnSectorDel(this, 'amtInfoList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td name="contractTerm_02" style="display:none;">
										<select name="tableVal" ${disabled} name="tableVal" style="width: 90%;">
											<c:forEach var="items" items="${contractYearCode}">
												<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>											
										</select>
									</td>
									<td class="le"><input amountType="amt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원 <span name="viewKorean" ></span></td>
									<td class="ri"><input amountType="stdAmt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원</td>
									<td class="ri"><input amountType="taxAmt" amountInput="Y" name="tableVal" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" maxlength="15" /> 원</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 계약방법</th>
					<td colspan="3">
					
						<select ${disabled} objKey="contract_type" objCheckFor="checkVal('select', this, '계약방법', 'mustAlert', '')" class="puddSetup" pudd-style="width:auto;min-width:100px;">
							<c:forEach var="items" items="${contractTypeCode}">
								<option value="${items.CODE}" <c:if test="${ viewType == 'U' && items.CODE == contractDetailInfo.contract_type }">selected</c:if> >${items.NAME}</option>
							</c:forEach>							
						</select>
						<span class="ml10">(관리번호 : STOB221014-001)</span>
					</td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 계약법령</th>
					<td colspan="3">
					
						<select ${disabled} objKey="base_law" objCheckFor="checkVal('select', this, '계약법령', 'mustAlert', '')" class="puddSetup" pudd-style="width:auto;min-width:150px;">
							<c:forEach var="items" items="${baseLawCode}">
								<option value="${items.CODE}" <c:if test="${ viewType == 'U' && items.CODE == contractDetailInfo.base_law }">selected</c:if> >${items.NAME}</option>
							</c:forEach>							
						</select>					
					
					</td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 수의계약사유</th>
					<td colspan="3">
					
						<select ${disabled} objKey="private_reason" objCheckFor="checkVal('select', this, '수의계약사유', 'mustAlert', '')" class="puddSetup" pudd-style="width:auto;min-width:150px;">
							<c:forEach var="items" items="${privateReasonCode}">
								<option value="${items.CODE}" <c:if test="${ viewType == 'U' && items.CODE == contractDetailInfo.private_reason }">selected</c:if> >${items.NAME}</option>
							</c:forEach>							
						</select>		
						
					</td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 희망기업여부</th>
					<td>
						<div class="multi_sel" style="width:calc( 100% - 58px);">
							<ul class="multibox" style="width:100%;">							
								<li>지란지교소프트<a href="#n" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a></li>	
								<li>삼성SDS<a href="#n" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a></li>	
							</ul>								
						</div>
						<div class="controll_btn p0 pt4">	
							<button id="" onclick="">추가</button>
						</div>
					</td>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 희망확인서</th>
					<td class="file_add">	
						<ul class="file_list_box fl">
							<li>
								<img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" class="fl" id="" alt="">
								<a href="javascript:;" class="fl ellipsis pl5" style="max-width:160px;" id="">업체요구사항업체요구사항 정의서업체요구사항업체요구사항정의서업체요구사항업체요구사항 정의서</a>
								<span>.jpg</span>
								<a href="javascript:;" id="" title="파일삭제"><img src="${pageContext.request.contextPath}/customStyle/Images/btn/close_btn01.png" id="" alt=""></a>
							</li>
						</ul>
						<span class="fr mt2"><input type="button" class="puddSetup" value="파일찾기" /></span>
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
			<table>
				<colgroup>
					<col width="200"/>
					<col width="120"/>
					<col width="80"/>
					<col width=""/>
					<col width="100"/>
					<col width="110"/>
					<col width="150"/>
				</colgroup>
				<tr>
					<th class="cen">사업자명</th>
					<th class="cen">사업자등록번호</th>
					<th class="cen">대표자</th>
					<th class="cen">사업장주소</th>
					<th class="cen">담당자(PM) 성명</th>
					<th class="cen">담당자(PM) 연락처</th>
					<th class="cen">담당자(PM) 전자우편</th>
				</tr>
				<tr>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% );" class="puddSetup pr30" value="지란지교소프트" readonly />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
					<td class="cen">766-40-00071</td>
					<td class="cen">홍길동</td>
					<td>경기도 수원시 영통구 삼성로 129(매탄동)</td>
					<td><input type="text" pudd-style="width:100%;" class="puddSetup ac" value="" /></td>
					<td><input type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
					<td><input type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
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
			<table>
				<colgroup>
					<col width="50"/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="ac">
						<input type="button" id="" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
					</th>
					<th class="ac">예산회계단위</th>
					<th class="ac">프로젝트</th>
					<th class="ac">하위사업</th>
					<th class="ac">예산과목</th>
				</tr>
				<tr>
					<td>
						<input type="button" id="" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<a href="#n" class="btn_search" style="margin-left: -25px;"></a>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<!-- 테이블 -->
		<div class="com_ta6 mt10">
			<table>
				<colgroup>
					<col width="100"/>
					<col width="150"/>
					<col width="100"/>
					<col width="150"/>
					<col width="100"/>
					<col width="150"/>
					<col width="100"/>
					<col width="150"/>
				</colgroup>
				<tr>
					<th>관</th>
					<td>운영비(210)</td>
					<th>항</th>
					<td>일반수용비(01)</td>
					<th>목</th>
					<td></td>
					<th>세</th>
					<td></td>
				</tr>				
				<tr>
					<th>예산액</th>
					<td class="ri pr10">1,000,000</td>
					<th>집행액</th>
					<td class="ri pr10">1,000,000</td>
					<th>품의액</th>
					<td class="ri pr10">1,000,000</td>
					<th>예산잔액</th>
					<td class="ri pr10">1,000,000</td>
				</tr>
			</table>
		</div>			
		
		
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->

<form id="frmPop" name="frmPop"> 
		<input type="hidden" name="selectedItems" id="selectedItems" value="" />
		<input type="hidden" name="popUrlStr" id="txt_popup_url" value="/gw/systemx/orgChart.do" />
		<input type="hidden" name="selectMode" id="selectMode" value="u" />
		<input type="hidden" name="selectItem" value="s" />
		<input type="hidden" name="callback" id="callback" value="" />
		<input type="hidden" name="compSeq" value="" />
		<input type="hidden" name="callbackUrl" value="/gw/html/common/callback/cmmOrgPopCallback.jsp"/>
		<input type="hidden" name="empUniqYn" value="N" />
		<input type="hidden" name="empUniqGroup" value="" />
</form>

</body>
</html>