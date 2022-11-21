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
    <title>제안서 평가결과 등록</title>

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
	
		var outProcessCode = "Contract03";
		var disabledYn = "${disabledYn}";
		
		var insertDataObject = {};
		var attachFormList = [];
		var attachFileNew = [];
		var attachFileDel = [];		
		
		var tempArray = [];
		var tempObj = {};
		var tempStr = "";
		
		
		
		<c:forEach var="items" items="${formAttachList}">
		
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
		
		
		function setScoreTableInit(value){
			
			<c:forEach var="items" items="${contractDetailInfo.nominee_info.split('▦▦') }" varStatus="status">
			
			$("[itemTarget=target_${status.index+1}]").attr("biz_no","${items.split('▦')[1]}");
			$("[itemTarget=target_${status.index+1}]").text("${items.split('▦')[0]}");
			$("[itemTarget=target_${status.index+1}]").attr("use_yn","Y");
			$("[itemTarget=target_${status.index+1}]").attr("targetKey","${status.index+1}");
			
			</c:forEach>			
			
			
			/*
			$.each(value.split("▦▦"), function( key, val ) {
				
				if(key < 5){
					
					var targetInfo = val.split("▦");
					
					var seq = key+1;
					$("[itemTarget=target_"+seq+"]").attr("biz_no",targetInfo[0]);
					$("[itemTarget=target_"+seq+"]").text(targetInfo[1]);
					$("[itemTarget=target_"+seq+"]").attr("use_yn","Y");
					
				}
				
			});
			*/
			
			$.each($("[name=compTr] th[use_yn=N]"), function( key, val ) {
				
				var itemNo = $(val).attr("itemNo");
				$("[itemNo="+itemNo+"]").remove();
				
			});			
			
		}
		
		
	
		$(document).ready(function() {
			
			$("#amt").text("₩ ${contractDetailInfo.amt} " + viewKorean("${contractDetailInfo.amt}".replace(/,/g, '')) + " / 부가세 포함");
			
			setDynamicPuddInfoTable("resultScoreList", "scoreInfoAddBase", "10▦제안서평가위원▦20▦▦20▦발주부서▦60▦▦30▦발주부▦20");
			
			setScoreTableInit("111111▦지란지교소프트▦▦222222222222▦삼성SDI");
			
			
			
			
			
			
			
			
			
			
			
			
						
			
			
			
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
			*/
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
			
		}
		
		function fnSectorAdd(tableName, baseName){
			
			var cloneData = $('[name="'+baseName+'"]').clone();
			$(cloneData).show().attr("name", "addData");
			
			if(tableName == ""){
				$('[name="'+baseName+'"]').before(cloneData);
			}else{
				$('[name="'+tableName+'"]').append(cloneData);	
			}
			
		}
		
		function fnSectorDel(e){
			
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
				url : '<c:url value="/purchase/ResultSaveProc.do" />',
	    		datatype:"json",
	            data: insertDataObject ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						if(type == 1){
							openerRefreshList();				
							msgAlert("success", "임시저장이 완료되었습니다.", "self.close()");							
						}else{
							openWindow2("${pageContext.request.contextPath}/purchase/ApprCreate.do?outProcessCode="+outProcessCode+"&seq=${seq}",  "ApprCreatePop", 1000, 729, 1, 1) ;
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
					$('[name="'+baseName+'"]').before(cloneData);
					
				});	
				
			}
		}		
		
		function fnChangeTarget(e){
			
			if(e.checked){
				$("[itemNo="+$(e).attr("targetkey")+"]").show();
			}else{
				$("[itemNo="+$(e).attr("targetkey")+"]").hide();
			}
			
		}
		
		
		/*
		var resultTargetList = [];
		
		var resultTarget = {};
		resultTarget.seq = "1";
		resultTarget.name = "지란지교소프트";
		resultTarget.business_no = "11111111111";
		resultTargetList.push(resultTarget);
		
		resultTarget = {};
		resultTarget.seq = "2";
		resultTarget.name = "삼성 SDS";
		resultTarget.business_no = "22222222222";
		resultTargetList.push(resultTarget);
		
		resultTarget = {};
		resultTarget.seq = "3";
		resultTarget.name = "LG CNS";
		resultTarget.business_no = "11111111111";
		resultTargetList.push(resultTarget);
		
		var resultTypeList = [];
		
		var resultType = {};
		resultType.itemCode = "10";
		resultType.judge = "제안서 평가위원";
		resultType.scoreRate = "20";
		resultTypeList.push(resultType);
		
		resultType = {};
		resultType.itemCode = "20";
		resultType.judge = "발주부서";
		resultType.scoreRate = "60";
		resultTypeList.push(resultType);
		
		resultType = {};
		resultType.itemCode = "10";
		resultType.judge = "발주부서";
		resultType.scoreRate = "20";
		resultTypeList.push(resultType);		
		*/
		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;"> <!-- 팝업창사이즈 가로 : 1000px -->
	<div class="pop_sign_head posi_re">
		<h1>제안서 평가결과 등록</h1>
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


	<div class="pop_con" style="overflow: auto;">
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="160"/>
					<col width=""/>
					<col width="160"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>공고명</th>
					<td>${contractDetailInfo.title}</td>
					<th>계약기간</th>
					<td>계약체결일 ~ ${contractDetailInfo.contract_end_dt}</td>
				</tr>
				<tr>
					<th>과업내용</th>
					<td colspan="3">${contractDetailInfo.work_info}</td>
				</tr>
				<tr>
					<th>기초금액</th>
					<td id="amt" colspan="3"></td>
				</tr>
				<tr>
					<th>경쟁방식</th>
					<td>${contractDetailInfo.compete_type_text}</td>
					<th>낙찰자 결정방법</th>
					<td>${contractDetailInfo.decision_type_info_text}</td>
				</tr>
			</table>
		</div>
			
		<!-- 평가회의 개요 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">평가회의 개요</p>
			</div>
		</div>
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="130"/>
					<col width="369"/>
					<col width="130"/>
					<col width="369"/>
				</colgroup>
				<tr>
					<th>평가회의 일시</th>
					<td>${contractDetailInfo.meet_dt}</td>
					<th>평가회의 장소</th>
					<td>${contractDetailInfo.meet_place}</td>
				</tr>
				<tr>
					<th>평가방법</th>
					<td colspan="3">업체별 PT ${contractDetailInfo.meet_method_pt}분, 질의응답 ${contractDetailInfo.meet_method_qa}분.</td>
				</tr>				
				<tr>
					<th>평가위원</th>
					<td colspan="3">
						<!-- 그리드 -->
						<div class="com_ta4">
							<table name="resultJudgesList" objKey="result_judges_info" objCheckFor="checkVal('table', 'resultJudgesList', '평가위원', 'true')">
								<colgroup>
									<col width="50"/>
									<col width="180"/>
									<col width="120"/>
									<col width="130"/>
									<col width=""/>
								</colgroup>
								<tr>
									<th class="ac">
										<input type="button" onclick="fnSectorAdd('resultJudgesList', 'resultJudgesAddBase')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									<th class="ac">소속</th>
									<th class="ac">성명</th>
									<th class="ac">직위</th>
									<th class="ac">비고</th>
								</tr>
								<tr name="resultJudgesAddBase" style="display:none;">
									<td>
										<input type="button" onclick="fnSectorDel(this)" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" requiredNot="false" must type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
								</tr>								
								<tr name="addData">
									<td>
										<input type="button" id="" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" requiredNot="true" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				
				<tr>
					<th>평가대상</th>
					<td colspan="3">
					
					<c:forEach var="items" items="${contractDetailInfo.nominee_info.split('▦▦') }" varStatus="status">
					<input type="checkbox" targetKey="${status.index+1}" onclick="fnChangeTarget(this)" value="${items.split('▦')[1]}" class="puddSetup" pudd-label="${items.split('▦')[0]}" checked />
					</c:forEach>
					
					</td>
				</tr>				
				
				<tr>
					<th>제안서 평가결과</th>
					<td colspan="3">
						<!-- 그리드 -->
						<div class="com_ta4">
							<table name="resultScoreList" objKey="result_score_info" objCheckFor="checkVal('table', 'resultScoreList', '제안서 평가결과', 'true')">
								<colgroup>
									<col width="50"/>
									<col width=""/>
									<col width=""/>
									<col width=""/>
									<col itemNo="1" width=""/>
									<col itemNo="2" width=""/>
									<col itemNo="3" width=""/>
									<col itemNo="4" width=""/>
									<col itemNo="5" width=""/>
								</colgroup>
								<tr>
									<th class="ac" rowspan="2">
										<input type="button" onclick="fnSectorAdd('', 'scoreInfoAddBase')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									<th class="ac" rowspan="2" colspan="2">구분</th>
									<th class="ac" rowspan="2">배점</th>
									<th class="ac" colspan="5">업체명</th>
								</tr>
								<tr name="compTr">
									<th itemNo="1" itemTarget="target_1" use_yn = "N" class="ac">-</th>
									<th itemNo="2" itemTarget="target_2" use_yn = "N" class="ac">-</th>
									<th itemNo="3" itemTarget="target_3" use_yn = "N" class="ac">-</th>
									<th itemNo="4" itemTarget="target_4" use_yn = "N" class="ac">-</th>
									<th itemNo="5" itemTarget="target_5" use_yn = "N" class="ac">-</th>
								</tr>

								<tr name="scoreInfoAddBase" style="display:none;">
									<td>
										<input type="button" onclick="fnSectorDel(this)" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									<td>
										<select name="tableVal" style="width: auto;">
												<option value="10">정량적평가(20)</option>
												<option value="20">정성적평가(60)</option>
												<option value="30">가격평가(20)</option>
										</select>									
									</td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ar" value="" /></td>
									
									<td itemNo="1"><input itemScore="1" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ar" value="" /></td>
									<td itemNo="2"><input itemScore="2" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ar" value="" /></td>
									<td itemNo="3"><input itemScore="3" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ar" value="" /></td>
									<td itemNo="4"><input itemScore="4" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ar" value="" /></td>
									<td itemNo="5"><input itemScore="5" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ar" value="" /></td>
								</tr>
								
								<tr name="totalTr">
									<td colspan="3">합계</td>
									<td class="ri">0</td>
									
									<td itemNo="1" itemTotal="1" class="ri"></td>
									<td itemNo="2" itemTotal="2" class="ri"></td>
									<td itemNo="3" itemTotal="3" class="ri"></td>
									<td itemNo="4" itemTotal="4" class="ri"></td>
									<td itemNo="5" itemTotal="5" class="ri"></td>
								</tr>
								<tr name="rankTr">
									<td colspan="3">우선협상순위</td>
									<td class="ri"></td>
									
									<td itemNo="1" itemRank="1" class="ri"></td>
									<td itemNo="2" itemRank="2" class="ri"></td>
									<td itemNo="3" itemRank="3" class="ri"></td>
									<td itemNo="4" itemRank="4" class="ri"></td>
									<td itemNo="5" itemRank="5" class="ri"></td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<th>낙찰가격</th>
					<td colspan="3">
						<input type="text" pudd-style="width:150px;" class="puddSetup ar" value="135,300,000" /> 원 
						<span>(금일억삼천오백삼십만원)</span>
					</td>
				</tr>
			</table>
		</div>			
			
		
		
		
	</div>




</div><!-- //pop_wrap -->

</body>
</html>