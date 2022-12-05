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
    <title>계약체결(변경) 등록</title>

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
	
		var outProcessCode = "Conclu02";
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
		
		attachFormList.push(tempObj);
		</c:forEach>
		
		$(document).ready(function() {
			
			amountInputSet();
			
			<c:if test="${contractDetailInfo.contract_term == '02'}">
			$("[name=contractTerm_02]").show();
			</c:if>			
			
			//기존설정항목 세팅
			setDynamicPuddInfoTableBefore("amtInfoListBefore1", "dataBase", "${contractDetailInfo.contract_amt_info}");
			setDynamicPuddInfoTableBefore("amtInfoListBefore2", "dataBase", "${contractDetailInfo.contract_amt_info}");
			
			
			//기존설정항목 세팅
			<c:if test="${viewType == 'U'}">
			setDynamicPuddInfo("change_item_info", "checkbox", "${contractDetailInfo.change_item_info}");
			setDynamicPuddInfoTable("amtInfoList", "amtInfoAddBase", "${contractDetailInfo.contract_amt_info_after}");
			</c:if>			
			
			/*
			amountInputSet();
			
			//기존설정항목 세팅
			
			
			amountKoreanSet();
			
			setDynamicSetInfoUl("hopeCompanyList", "${contractDetailInfo.hope_company_info}");
			setDynamicSetInfoFile("hopeAttachList", "${contractDetailInfo.hope_attach_info}");
			*/
			
		});
		
		
	
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
				
				$(targetTr).find("[amounttype=stdAmt]").val((Math.floor(amtInt*0.9)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(targetTr).find("[amounttype=taxAmt]").val((Math.floor(amtInt*0.1)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
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
			insertDataObject.seq = "${change_seq}"
			insertDataObject.outProcessCode = "Conclusion02";
			
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
				
				//미설정항목 초기화 및 기존값 세팅
				
				//과업내용 
				if($('[name=changeItem][value=01]:checked').length == 0){
					insertDataObject.work_info_before = "";
					insertDataObject.work_info_after = "";
				}else{
					insertDataObject.work_info_before = "${contractDetailInfo.c_work_info}";
				}
				
				//계약기간
				if($('[name=changeItem][value=02]:checked').length == 0){
					insertDataObject.contract_end_dt_before = "";
					insertDataObject.contract_end_dt_after = "";
				}else{
					insertDataObject.contract_end_dt_before = "${contractDetailInfo.c_contract_end_dt}";
				}
				
				//계약금액 
				if($('[name=changeItem][value=03]:checked').length == 0){
					insertDataObject.contract_amt_info_before = "";
					insertDataObject.contract_amt_info_after = "";
				}else{
					insertDataObject.contract_amt_info_before = "${contractDetailInfo.contract_amt_info}";
				}
				
				//기타
				if($('[name=changeItem][value=etc]:checked').length == 0){
					insertDataObject.change_etc = "";
					insertDataObject.change_reason = "";
				}
				
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
			insertDataObject.outProcessCode = "Conclusion02";
			insertDataObject.viewType = "${viewType}";
			insertDataObject.seq = "${seq}";
			insertDataObject.change_seq = "${change_seq}";
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/ConclusionChangeSaveProc.do" />',
	    		datatype:"json",
	            data: insertDataObject ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						if(type == 1){
							openerRefreshList();				
							msgAlert("success", "임시저장이 완료되었습니다.", "self.close()");							
						}else{
							openWindow2("${pageContext.request.contextPath}/purchase/ApprCreate.do?outProcessCode="+outProcessCode+"&seq=${seq}&change_seq=" + result.resultData.seq,  "ApprCreatePop", 1000, 729, 1, 1) ;
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
				$("[objKey='c_write_comp_seq']").val(data.returnObj[0].compSeq);
				$("[objKey='c_write_dept_seq']").val(data.returnObj[0].deptSeq);
				$("[objKey='c_write_emp_seq']").val(data.returnObj[0].empSeq);
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
						
						if(key == 1){
							$(cloneData).find("[name=viewKorean]").text( viewKorean(valInfo[key].replace(/,/g, '')) );
						}						
						
					});				
					
					$(cloneData).show().attr("name", "addData");
					$('[name="'+tableName+'"]').append(cloneData);				
					
				});	
				
			}
		}		
		
		function setDynamicPuddInfoTableBefore(tableName, baseName, value){
			
			if(value != ""){
				
				$("[name="+tableName+"] [name=addData]").remove();
				
				$.each(value.split("▦▦"), function( key, val ) {
					
					var valInfo =  val.split("▦");
					
					var cloneData = $("[name="+tableName+"] [name=" + baseName+"]").clone();
					
					$.each($(cloneData).find("[name=tableVal]"), function( key, tableVal ) {
						
						if(key == 0){
							$(tableVal).val(valInfo[key]);	
						}else{
							$(tableVal).text(valInfo[key]);
						}
						
						if(key == 1){
							$(cloneData).find("[name=viewKorean]").text( viewKorean(valInfo[key].replace(/,/g, '')) );
						}
						
					});				
					
					$(cloneData).show().attr("name", "addData");
					$('[name="'+tableName+'"]').append(cloneData);				
					
				});	
				
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
					parent.msgSnackbar("error", "동일한 이름의 첨부파일이 존재합니다.");
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
		

		function fnCommonCode_trName_callback(param) {
			/* iCUBE example - tr : {"erpCompSeq":"7070","tel":"02 _518_0012","trFg":"1","trName":"전문건설공제조합2","ceoName":"이건영","addr":"충남 공주시 신관동 ","bankName":"국민","trRegNumber":"6028505389","bankNumber":"32165431321","useYN":"1","atTrName":"전문건설공제조합2","trSeq":"000003","trFgName":"일반","depositor":"ㅇ러날","giroSeq":"040","code":"tr","dummy":"{}"} */
			
			if(param != null){
				$("[objKey=partner_code]").val( param.trSeq || "" );
				$("[objKey=partner_name]").val( param.trName || "" );
				$("[objKey=partner_bizno]").text( param.trRegNumber || "" );
				$("[objKey=partner_owner]").text( param.ceoName || "" );
				$("[objKey=partner_addr]").text( param.addr || "" );
			}
			
		}
		
		/* ## 공통코드 - 거래처 ## */
		function fnCommonCode_trName(code, param) {
			/* [ parameter ] */
			/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
			code = (code || '');
			/*   - param : 현재 작성중인 내역의 모든 정보 */
			param = (param || {});

			//param.trOpt = optionSet.gw[3][16].setValue
			//param.trOpt2 = (optionSet.gw[3][22]||{'setValue':'1'}).setValue ;

			param.callback = 'fnCommonCode_trName_callback';
			/* 검색어 예외처리 ( 이유 : ERPiU 기준에 따라 처리 ) */
			param.searchStr = "";

			fnCommonCodePop(code, param, param.callback);

			/* [ return ] */
			return;
		}		
		
		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;"> <!-- 팝업창사이즈 가로 : 1000px -->
	<div class="pop_sign_head posi_re">
		<h1>계약변경 등록</h1>
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
	
	
		<!-- 기본정보 -->
		<div class="btn_div mt0">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">기본정보</p>
			</div>
		</div>
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="160"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>계약명</th>
					<td>${contractDetailInfo.c_title} (계약번호 : ${contractDetailInfo.contract_no})</td>
				</tr>
				<tr>
					<th>계약기간</th>
					<td>계약체결일  ~  ${contractDetailInfo.c_contract_end_dt}</td>
				</tr>
				<tr>
					<th>계약내용</th>
					<td>${contractDetailInfo.c_work_info}</td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 계약금액</th>
					<td>
						<div class="com_ta4">
							<table name="amtInfoListBefore1">
								<colgroup>
									<col name="contractTerm_02" style="display:none;" width="130"/>
									<col width=""/>
									<col width=""/>
									<col width=""/>
								</colgroup>
								<tr>
									<th name="contractTerm_02" style="display:none;" class="ac">연도</th>
									<th class="ac">계약금액</th>
									<th class="ac">추정가격</th>
									<th class="ac">부가가치세</th>
								</tr>
								<tr name="dataBase" style="display:none;">
									<td name="contractTerm_02" style="display:none;">
										<select name="tableVal" ${disabled} style="width: 90%;" disabled >
											<c:forEach var="items" items="${contractYearCode}">
												<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>											
										</select>
									</td>
									<td  class="le"><span name="tableVal"></span> 원 <span name="viewKorean"></span></td>
									<td class="ri"><span name="tableVal"></span> 원</td>
									<td class="ri"><span name="tableVal"></span> 원</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>


		<!-- 변경사항 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">변경사항</p>
			</div>
		</div>
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="160"/>
					<col width="338"/>
					<col width="160"/>
					<col width="338"/>
				</colgroup>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 변경사항</th>
					<td colspan="3" objKey="change_item_info" objCheckFor="checkVal('checkbox', 'changeItem', ' 변경사항', 'true', '|etc|')">
					
						<c:forEach var="items" items="${changeItemCode}">
							<c:choose>
								<c:when test="${items.CODE == 'etc'}">
									<input ${disabled} type="checkbox" onclick="fnChangeEtc(this)" name="changeItem" value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
									<input ${disabled} type="text" name="changeItem_${items.CODE}" pudd-style="width:300px;" class="puddSetup" value="" style="display:none;" />
								</c:when>
								<c:otherwise>
									<input ${disabled} type="checkbox" onclick="fnChangeEtc(this)" name="changeItem" value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
								</c:otherwise>
							</c:choose>						
						</c:forEach>					
					</td>
				</tr>
				
				<tr name="changeItem_01" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦01▦') < 0 ) }">style="display:none;"</c:if>>
					<th>과업변경 (전)</th>
					<td colspan="3">${contractDetailInfo.c_work_info}</td>
				</tr>
				
				<tr name="changeItem_01" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦01▦') < 0 ) }">style="display:none;"</c:if>>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 과업변경 (후)</th>
					<td colspan="3"><input objKey="work_info_after" objCheckFor="checkVal('text', this, '과업변경', '$(\'[name=changeItem][value=01]:checked\').length > 0', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="${contractDetailInfo.work_info_after}" /></td>
				</tr>
				<tr name="changeItem_02" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦02▦') < 0 ) }">style="display:none;"</c:if>>
					<th>기간변경 (전)</th>
					<td>계약체결일 ~ ${contractDetailInfo.c_contract_end_dt}</td>
					<th>기간변경 (후)</th>
					<td objKey="contract_end_dt_after" objCheckFor="checkVal('date', 'contractEndDtAfter', '계약기간', '$(\'[name=changeItem][value=02]:checked\').length > 0', '')">계약체결일  ~ <input type="text" name="contractEndDtAfter" value="${contractDetailInfo.contract_end_dt_after}" class="puddSetup" pudd-type="datepicker"/></td>
				</tr>				
				<tr name="changeItem_03" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦03▦') < 0 ) }">style="display:none;"</c:if>>
					<th>금액변경 (전)</th>
					<td colspan="3">
						<div class="com_ta4">
							<table name="amtInfoListBefore2">
								<colgroup>
									<col name="contractTerm_02" style="display:none;" width="130"/>
									<col width=""/>
									<col width=""/>
									<col width=""/>
								</colgroup>
								<tr>
									<th name="contractTerm_02" style="display:none;" class="ac">연도</th>
									<th class="ac">계약금액</th>
									<th class="ac">추정가격</th>
									<th class="ac">부가가치세</th>
								</tr>
								<tr name="dataBase" style="display:none;">
									<td name="contractTerm_02" style="display:none;">
										<select name="tableVal" ${disabled} style="width: 90%;" disabled >
											<c:forEach var="items" items="${contractYearCode}">
												<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>											
										</select>
									</td>
									<td  class="le"><span name="tableVal"></span> 원 <span name="viewKorean"></span></td>
									<td class="ri"><span name="tableVal"></span> 원</td>
									<td class="ri"><span name="tableVal"></span> 원</td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr name="changeItem_03" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦03▦') < 0 ) }">style="display:none;"</c:if>>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 금액변경</th>
					<td colspan="3">

						
						<div class="com_ta4">
							<table name="amtInfoList" objKey="contract_amt_info_after" objCheckFor="checkVal('table', 'amtInfoList', '계약금액', '$(\'[name=changeItem][value=03]:checked\').length > 0', 'notnull')">
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
									<th class="ac">계약금액</th>
									<th class="ac">추정가격</th>
									<th class="ac">부가가치세</th>
								</tr>
								<tr name="amtInfoAddBase" style="display:none;">
									<td name="contractTerm_02" style="display:none;">
										<input type="button" onclick="fnSectorDel(this, 'amtInfoList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td name="contractTerm_02" style="display:none;">
										<select name="tableVal" ${disabled} style="width: 90%;">
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
										<select name="tableVal" ${disabled} style="width: 90%;">
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
				<tr name="changeItem_etc" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦etc▦') < 0 ) }">style="display:none;"</c:if>>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 기타변경</th>
					<td colspan="3"><input objKey="change_etc" objCheckFor="checkVal('text', this, '기타변경', '$(\'[name=changeItem][value=etc]:checked\').length > 0', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="${contractDetailInfo.change_etc}" /></td>
				</tr>
				<tr name="changeItem_etc" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦etc▦') < 0 ) }">style="display:none;"</c:if>>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 변경사유</th>
					<td colspan="3"><input objKey="change_reason" objCheckFor="checkVal('text', this, '변경사유', '$(\'[name=changeItem][value=etc]:checked\').length > 0', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="${contractDetailInfo.change_reason}" /></td>
				</tr>
				

			</table>
		</div>	
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->

<div id="exArea"></div>

</body>
</html>