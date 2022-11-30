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
    <title>제안서 평가회의 등록</title>

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
	
		var outProcessCode = "Contract02";
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
		
	
		$(document).ready(function() {
			
			$('#meetAmtSpent').maskMoney({
				precision : 0,
				allowNegative: false
			});			
			
			$("#amt").text("₩ ${contractDetailInfo.amt} " + viewKorean("${contractDetailInfo.amt}".replace(/,/g, '')) + " / 부가세 포함");
			
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
			insertDataObject.meet_dt = $("[name=meetDt]").parent().find("input")[1].value + " " + insertDataObject.meet_start_hh +  ":" + insertDataObject.meet_start_mm + "~" + insertDataObject.meet_end_hh + ":" + insertDataObject.meet_end_mm;
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/MeetSaveProc.do" />',
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
					$('[name="'+tableName+'"]').append(cloneData);				
					
				});	
				
			}
		}		
		

		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;"> <!-- 팝업창사이즈 가로 : 1000px -->
	<div class="pop_sign_head posi_re">
		<h1>제안서 평가회의 등록</h1>
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
		
		<!-- 가회의 개요 -->
		<div class="btn_div mt25">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">평가회의 개요</p>
			</div>
		</div>
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="160"/>
					<col width=""/>
					<col width="160"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 평가회의 일시 </th>
					<td colspan="3" objKey="meet_dt" objCheckFor="checkVal('date', 'meetDt', '평가회의 일시', 'selectDate(this)', '')" >
						<input ${disabled} name="meetDt" type="text" value="${contractDetailInfo.meet_dt}" class="puddSetup" pudd-type="datepicker"/>
						<select ${disabled} objKey="meet_start_hh" objCheckFor="checkVal('select', this, '', '', '')" class="selectmenu" style="width:60px">
							<c:forEach var="items" items="${timeCodeList}">
							<option ${disabled} value="${items}" <c:if test="${ items == contractDetailInfo.meet_start_hh }">selected</c:if> >${items}</option>
							</c:forEach>							
						</select>
						<select ${disabled} objKey="meet_start_mm" objCheckFor="checkVal('select', this, '', '', '')" class="selectmenu" style="width:60px">
							<c:forEach var="items" items="${minCodeList}">
							<option value="${items}" <c:if test="${ items == contractDetailInfo.meet_start_mm }">selected</c:if> >${items}</option>
							</c:forEach>
						</select>
						~
						<select ${disabled} objKey="meet_end_hh" objCheckFor="checkVal('select', this, '', '', '')" class="selectmenu" style="width:60px">
							<c:forEach var="items" items="${timeCodeList}">
							<option value="${items}" <c:if test="${ items == contractDetailInfo.meet_end_hh }">selected</c:if> >${items}</option>
							</c:forEach>
						</select>
						<select ${disabled} objKey="meet_end_mm" objCheckFor="checkVal('select', this, '', '', '')" class="selectmenu" style="width:60px">
							<c:forEach var="items" items="${minCodeList}">
							<option value="${items}" <c:if test="${ items == contractDetailInfo.meet_end_mm }">selected</c:if> >${items}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 평가회의 장소</th>
					<td colspan="3"><input ${disabled} objKey="meet_place" objCheckFor="checkVal('text', this, '평가회의 장소', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="${contractDetailInfo.meet_place}" /></td>
				</tr>
				<tr>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 평가방법</th>
					<td>
						업체별 PT <input ${disabled} objKey="meet_method_pt" objCheckFor="checkVal('text', this, '평가방법', 'mustAlert', '')" type="text" pudd-style="width:40px;" class="puddSetup ar" value="${contractDetailInfo.meet_method_pt}" /> <span class="pl5">분</span>.
						질의응답 <input ${disabled} objKey="meet_method_qa" objCheckFor="checkVal('text', this, '평가방법', 'mustAlert', '')" type="text" pudd-style="width:40px;" class="puddSetup ar ml5 mr5" value="${contractDetailInfo.meet_method_qa}" /> <span class="pl5">분</span>.
					</td>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 지출금액</th>
					<td><input ${disabled} objKey="meet_amt_spent" objCheckFor="checkVal('text', this, '지출금액', 'mustAlert', 'parseToInt')" id="meetAmtSpent" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup ar" value="${contractDetailInfo.meet_amt_spent}" maxlength="15" /> 원</td>
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
		
		
		
	</div>




</div><!-- //pop_wrap -->

</body>
</html>