.<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
	
		var insertDataObject = {};
		var attachFormList = [];
		var attachFileNew = [];
		var attachFileDel = [];		
		
		var tempArray = [];
		var tempObj = {};
		var tempStr = "";
		
		<c:forEach var="items" items="${attachForm_01}">
		
		tempObj = {};
		tempArray =  "${items.LINK}".split('▦');
		tempObj.code = "${items.CODE}";
		tempObj.formNm = "${items.NAME}";
		
		tempObj.mustYn = tempArray[0];
		tempObj.formFileNm = tempArray[1];
		tempObj.formFileId = tempArray[2];
		
		tempObj.fileId = "";
		tempObj.fileName = "";
		tempObj.fileExt = "";
		tempObj.newYn = "";
		
		attachFormList.push(tempObj);
		</c:forEach>				
	
		$(document).ready(function() {
			
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
			
		});
		
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
				,	url : "${pageContext.request.contextPath}/purchase/layer/AttachLayer.do"

			}
			 
				// dialog 하단을 사용할 경우 설정할 부분
			,	footer : {
			
					buttons : [
						{
							attributes : {}// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	value : "확인"
						,	clickCallback : function( puddDlg ) {
							
							temptemp = puddDlg;
								fnUpdateAttachInfo();
								puddDlg.showDialog( false );
								// 추가적인 작업 내용이 있는 경우 이곳에서 처리
								
							}
						}
					,	{
							attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
						,	value : "취소"
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
		}
		
		function fnChangeNotiType(e){
			if($(e).val() == "02" && $("[name='decisionType']:checked").val() != "03" && $("[name='decisionType'][value=03]").length > 0){
				Pudd("[name='decisionType'][value=03]").getPuddObject().setChecked(true);
				$("[name='decisionType_03']").show();
			}
		}
		
		function fnChangeEtc(e){
			
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
		}		
		
		function fnSectorAdd(tableName, baseName){
			
			var cloneData = $('[name="'+baseName+'"]').clone();
			$(cloneData).show().attr("name", "addData");
			
			$('[name="'+tableName+'"]').append(cloneData);
			
		}
		
		function fnSectorDel(e){
			
			$(e).closest("tr").remove();
			
		}		
		
		function fnValidationCheck(){
			insertDataObject = {};
			insertDataObject.attch_file_info = attachFormList;
			
			var validationCheck = true;
			
			$.each($("[objKey]"), function( key, objInfo ) {
				
				var objValue = eval($(objInfo).attr("objCheckFor"));
				
				if(objValue == "$failAlert$"){
					validationCheck = false;
					return false;
				}
				
				insertDataObject[$(objInfo).attr("objKey")] = objValue;
				
			});
			
			//원단위입력제한체크
			if(validationCheck && $("#amt").val().slice(-1) != "0"){
				msgSnackbar("error", "기초금액은 일원단위 입력이 불가합니다.");
				$("#amt").focus();
				validationCheck = false;
			}
			
			return validationCheck;
		}
		

		function fnSave(type){
			
			if(fnValidationCheck() == true){
				
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

			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/ContractSaveProc.do" />',
				datatype : 'json',
				data : insertDataObject,
				async : false,
				success : function(result) {
					msgAlert("success", "임시저장이 완료되었습니다.", "self.close()");
				},
				error : function(result) {
					msgSnackbar("error", "등록에 실패했습니다.");
				}
			});
			
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
				
				/*
				$("#createDeptName").val("");
				$("#createEmpName").val("");
				$("[objKey='write_comp_seq']").val("");
				$("[objKey='write_dept_seq']").val("");
				$("[objKey='write_emp_seq']").val("");
				$("#createSuperKey").val("");
				*/
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
					<input type="button" class="psh_btn" onclick="fnCallBtn('save')" value="임시저장" />
					<input type="button" class="psh_btn" onclick="fnCallBtn('attach')" value="첨부파일" />
					<input type="button" class="psh_btn" onclick="fnCallBtn('appr')" value="결재작성" />
				</div>
			</div>
		</div>
	</div>


	<div class="pop_con" style="overflow: auto; min-height: 460px;">
		<div class="top_box">
			<dl>
				<dt>작성부서/작성자</dt>
				<dd><input id="createDeptName" type="text" disabled pudd-style="width:200px;" class="puddSetup" value="${loginVo.orgnztNm}" placeholder="작성부서" /></dd>
				<dd><input id="createEmpName" type="text" disabled pudd-style="width:100px;" class="puddSetup" value="${loginVo.name}" placeholder="작성자" /></dd>
				<input objKey="write_comp_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${loginVo.organId}" />
				<input objKey="write_dept_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${loginVo.orgnztId}" />
				<input objKey="write_emp_seq" objCheckFor="checkVal('text', this, '작성자', 'selectOrgchart()', '')" type="hidden" value="${loginVo.uniqId}" />
				<input id="createSuperKey" type="hidden" value="${loginVo.groupSeq}|${loginVo.organId}|${loginVo.orgnztId}|${loginVo.uniqId}|u" />
				<dd><input onclick="selectOrgchart()" type="button" value="선택" /></dd>
				<dt>작성일자</dt>
				<dd objKey="write_dt" objCheckFor="checkVal('date', 'writeDt', '작성일자', 'selectDate(this)', '')" ><input name="writeDt" type="text" value="<fmt:formatDate value="${currentTime}" type="date" pattern="yyyy-MM-dd"/>" class="puddSetup" pudd-type="datepicker"/></dd>
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
					<th>공고종류</th>
					<td objKey="noti_type" objCheckFor="checkVal('radio', 'notiType', '공고종류', '', '')" >
						<c:forEach var="items" items="${notiTypeCode}" varStatus="status">
						<input type="radio" onclick="fnChangeNotiType(this)" name="notiType" fnChangeEtc name="notiType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" <c:if test="${status.index == 0}">checked</c:if> />
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>예산종류</th>
					<td objKey="budget_type" objCheckFor="checkVal('radio', 'budgetType', '예산종류', '', '')" >
						<c:forEach var="items" items="${budgetTypeCode}" varStatus="status">
						<input type="radio" name="budgetType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" <c:if test="${status.index == 0}">checked</c:if> />
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>목적물종류</th>
					<td objKey="target_type" objCheckFor="checkVal('radio', 'targetType', '목적물종류', '', '')" >
						<c:forEach var="items" items="${targetTypeCode}" varStatus="status">
						<input type="radio" name="targetType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" <c:if test="${status.index == 0}">checked</c:if> />
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
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 공고명</th>
					<td><input objKey="title" objCheckFor="checkVal('text', this, '공고명', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 계약기간</th>
					<td objKey="contract_end_dt" objCheckFor="checkVal('date', 'contractEndDt', '계약기간', 'selectDate(this)', '')" >계약체결일 ~ <input name="contractEndDt" type="text" value="" class="puddSetup" pudd-type="datepicker"/></td>
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 기초금액</th>
					<td>
						<input objKey="amt" objCheckFor="checkVal('text', this, '기초금액', 'mustAlert', 'parseToInt')" id="amt" type="text" pudd-style="width:110px;" class="puddSetup ar" value="" maxlength="15" /> 원 
						<span id="amt_han"></span>
					</td>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 추정가격</th>
					<td>
						<input objKey="std_amt" objCheckFor="checkVal('text', this, '추정가격', 'mustAlert', 'parseToInt')" id="stdAmt" type="text" pudd-style="width:110px;" class="puddSetup ar" value="" maxlength="15" /> 원 
						<span id="stdAmt_han"></span>
					</td>					
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 부가가치세</th>
					<td>
						<input objKey="tax_amt" objCheckFor="checkVal('text', this, '부가가치세', 'mustAlert', 'parseToInt')" id="taxAmt" type="text" pudd-style="width:110px;" class="puddSetup ar" value="" maxlength="15" /> 원 
						<span id="taxAmt_han"></span>
					</td>
					<th>근거법령</th>
					<td>
						<select objKey="base_law" objCheckFor="checkVal('select', this, '근거법령', 'mustAlert', '')" class="puddSetup" pudd-style="width:100%;">
							<c:forEach var="items" items="${baseLawCode}">
								<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>							
						</select>
					</td>					
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 결제방법</th>
					<td colspan="3" objKey="pay_type_info" objCheckFor="checkVal('checkbox', 'payType', '결제방법', 'mustAlert', '|etc|')" >
						<c:forEach var="items" items="${payTypeCode}">
							<c:choose>
								<c:when test="${items.CODE == 'etc'}">
									<input type="checkbox" onclick="fnChangeEtc(this)" name="payType"  value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
									<input type="text" style="display:none;" name="payType_${items.CODE}" pudd-style="width:300px;" class="puddSetup" value="" />
								</c:when>
								<c:otherwise>
									<input type="checkbox" name="payType"  value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
								</c:otherwise>
							</c:choose>						
						</c:forEach>						
											
					</td>					
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 과업내용</th>
					<td colspan="3"><input objKey="work_info" objCheckFor="checkVal('text', this, '과업내용', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="" /></td>
				</tr>				
			</table>
		</div>

		<!-- 입찰방식 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">입찰방식</p>
			</div>
		</div>
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="130"/>
					<col width=""/>
					<col width="130"/>
					<col width=""/>
					<col width="130"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>긴급여부</th>
					<td><input objKey="emergency_yn" objCheckFor="checkVal('checkbox', this, '긴급여부', 'checkYn', '')" name="emergencyYn" type="checkbox"  class="puddSetup" pudd-label="긴급입찰" /></td>
					<th>업종제한</th>
					<td objKey=restrict_sector_yn objCheckFor="checkVal('radio', 'restrictSectorYn', '업종제한', '', '')" >
						<input type="radio" onclick="fnChangeEtc(this)" name="restrictSectorYn" class="puddSetup" pudd-label="제한함" value="Y" />
						<input type="radio" onclick="fnChangeEtc(this)" name="restrictSectorYn" class="puddSetup" pudd-label="제한안함" value="N" checked />
					</td>
					<th>경쟁방식</th>
					<td>
						<select objKey=compete_type objCheckFor="checkVal('select', this, '경쟁방식', '', '')" type="select" name="competeType" onchange="fnChangeEtc(this)" class="puddSetup" pudd-style="width:150px;">
							
							<c:forEach var="items" items="${competeTypeCode}">
								<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>								
							
						</select>
					</td>
				</tr>
				<tr name="restrictSectorYn_Y" style="display:none;">
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 제한업종</th>
					<td colspan="5">		
						<a href="#n" onclick="window.open('https://www.g2b.go.kr:8070/um/co/industrialSrchPopup.do?whereAreYouFrom=portal','mgjCode','width=720, height=670, scrollbars=yes');" class="fr pt5 pb5 text_blue"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="16px" height="16px" /> 업종조회(나라장터)</a>				
						<!-- 테이블 -->
						<div class="com_ta4">
							<table name="restrictSectorList" objKey=restrict_sector_info objCheckFor="checkVal('table', 'restrictSectorList', '제한업종', '$(\'[objKey=restrict_sector_yn] input:checked\').val() == \'Y\'', '')" >
								<colgroup>
									<col width="34"/>
									<col width=""/>
									<col width=""/>
									<col width="40%"/>
								</colgroup>
								<tr>
									<th class="ac">
										<input type="button" onclick="fnSectorAdd('restrictSectorList', 'setorAddBase')" id="" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									<th class="ac">그룹</th>
									<th class="ac"><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 업종명</th>
									<th class="ac"><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 업종코드</th>
								</tr>
								<tr name="setorAddBase" style="display:none;">
									<td>
										<input type="button" onclick="fnSectorDel(this)" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td>
										<select name="tableVal" style="width: 90%;">
											<c:forEach var="items" items="${sectorGroupCode}">
												<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>											
										</select>
									</td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
								</tr>
								<tr name="addData">
									<td>
										<input type="button" onclick="fnSectorDel(this)" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td>
										<select name="tableVal" style="width: 90%;">
											<c:forEach var="items" items="${sectorGroupCode}">
												<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>											
										</select>
									</td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
								</tr>								
							</table>
						</div>
						
					</td>
				</tr>
				<tr name="competeType_01">
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 제한항목</th>
					<td colspan="5" objKey="restrict_area_info" objCheckFor="checkVal('checkbox', 'restrictArea', '제한항목', '$(\'[objkey=compete_type]\').val() == \'01\'', '|etc|')" >
						<c:forEach var="items" items="${restrictAreaCode}">
							<c:choose>
								<c:when test="${items.CODE == 'etc'}">
									<input type="checkbox" onclick="fnChangeEtc(this)" name="restrictArea" value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
									<input type="text" name="restrictArea_${items.CODE}" pudd-style="width:300px;" class="puddSetup" value="" style="display:none;" />
								</c:when>
								<c:otherwise>
									<input type="checkbox" name="restrictArea" value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
								</c:otherwise>
							</c:choose>						
						</c:forEach>							
					</td>
				</tr>
				<tr name="competeType_02" style="display: none;">
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 지명업체</th>
					<td colspan="5">						
						<!-- 테이블 -->
						<div class="com_ta4">
							<table name="nomineeList" objKey=nominee_info objCheckFor="checkVal('table', 'nomineeList', '지명업체', '$(\'[objkey=compete_type]\').val() == \'02\'', '')" >
								<colgroup>
									<col width="34"/>
									<col width=""/>
									<col width="150"/>
								</colgroup>
								<tr>
									<th class="ac">
										<input type="button" onclick="fnSectorAdd('nomineeList', 'nomineeAddBase')" id="" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									<th class="ac"><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 거래처명</th>
									<th class="ac"><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 사업자번호</th>
								</tr>
								<tr name="nomineeAddBase" style="display:none;">
									<td>
										<input type="button" onclick="fnSectorDel(this)" id="" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
								</tr>
								<tr name="addData">
									<td>
										<input type="button" onclick="fnSectorDel(this)" id="" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
								</tr>								
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<th>낙찰자결정방식</th>
					<td colspan="5" objKey="decision_type_info" objCheckFor="checkVal('radio', 'decisionType', '낙찰자결정방식', '', '|03|etc|')" >
						<c:forEach var="items" items="${decisionTypeCode}" varStatus="status">
							<c:choose>
								<c:when test="${items.CODE == '03'}">
									<input type="radio" onclick="fnChangeEtc(this)" name="decisionType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" />		
									<span class="pr10" name="decisionType_${items.CODE}" style="display:none;">
										<input type="text" name="decisionType_${items.CODE}" pudd-style="width:40px;" class="puddSetup ar" value="" /> %
									</span>									
								</c:when>
								<c:when test="${items.CODE == 'etc'}">
									<input type="radio" onclick="fnChangeEtc(this)" name="decisionType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" />	
									<input type="text" name="decisionType_${items.CODE}" id="decisionType_etc" pudd-style="width:300px;" class="puddSetup" value="" style="display:none;" />								
								</c:when>								
								<c:otherwise>
									<input type="radio" onclick="fnChangeEtc(this)" name="decisionType" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" <c:if test="${status.index == 0}">checked</c:if> />
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>계약체결형태(1)</th>
					<td>
						<select objKey="contract_form1" objCheckFor="checkVal('select', this, '계약체결형태(1)', '', '')" class="puddSetup" pudd-style="width:150px;">
							<c:forEach var="items" items="${contractForm1Code}">
								<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>							
						</select>
					</td>
					<th>계약체결형태(2)</th>
					<td>
						<select objKey="contract_form2" objCheckFor="checkVal('select', this, '계약체결형태(2)', '', '')" class="puddSetup" pudd-style="width:150px;">
							<c:forEach var="items" items="${contractForm2Code}">
								<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select>
					</td>
					<th>계약체결형태(3)</th>
					<td>
						<select objKey="contract_form3" objCheckFor="checkVal('select', this, '계약체결형태(3)', '', '')" class="puddSetup" pudd-style="width:150px;">
							<c:forEach var="items" items="${contractForm3Code}">
								<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select>
					</td>
				</tr>				
				<tr>
					<th>재입찰허용여부</th>
					<td objKey="rebid_yn" objCheckFor="checkVal('radio', 'rebidYn', '재입찰허용여부', '', '')" >
						<input type="radio" name="rebidYn" class="puddSetup" pudd-label="허용" value="Y" />	
						<input type="radio" name="rebidYn" class="puddSetup" pudd-label="불가" value="N" checked/>	
					</td>
					<th>E발주평가시스템</th>
					<td colspan="3" objKey="eorder_use_yn" objCheckFor="checkVal('radio', 'eorderUseYn', '재입찰허용여부', '', '')" >
						<input type="radio" name="eorderUseYn" class="puddSetup" pudd-label="이용" value="Y" />	
						<input type="radio" name="eorderUseYn" class="puddSetup" pudd-label="미이용" value="N" checked/>	
					</td>
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