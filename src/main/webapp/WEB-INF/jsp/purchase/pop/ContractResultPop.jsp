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
    <script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>  
	
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
		
		
		$(document).ready(function() {
			
			//기존설정항목 세팅
			
			$("#amt").text("₩ ${contractDetailInfo.amt} " + viewKorean("${contractDetailInfo.amt}".replace(/,/g, '')) + " / 부가세 포함");
			
			<c:forEach var="items" items="${contractDetailInfo.nominee_info.split('▦▦') }" varStatus="status">
			$("[itemTarget=target_${status.index+1}]").attr("biz_no","${items.split('▦')[1]}");
			$("[itemTarget=target_${status.index+1}]").text("${items.split('▦')[0]}");
			$("[itemTarget=target_${status.index+1}]").attr("use_yn","Y");
			</c:forEach>			
			
			$.each($("[name=compTr] th[use_yn=N]"), function( key, val ) {
				
				var itemNo = $(val).attr("itemNo");
				$("[itemNo="+itemNo+"]").hide();
				
			});
			
			<c:choose>
			<c:when test="${contractDetailInfo.result_score_info != ''}">
			setDynamicPuddInfoTable("resultScoreList", "scoreInfoAddBase", "${contractDetailInfo.result_score_info}");
			</c:when>
			<c:otherwise>
			setDynamicPuddInfoTable("resultScoreList", "scoreInfoAddBase", "10▦제안서평가위원▦20▦▦20▦발주부서▦60▦▦30▦발주부서▦20");
			</c:otherwise>
			</c:choose>
			
			setDynamicPuddInfoTable("nomineeList", "nomineeAddBase", "${contractDetailInfo.nominee_info}");
			setDynamicPuddInfoTable("resultJudgesList", "resultJudgesAddBase", "${contractDetailInfo.result_judges_info}");
			setResultTargetInfo("${contractDetailInfo.result_target_info}");
			
			fnCalculateResultScore();
			
			init();
			
			$(".explain").mouseover(function(){
				var exId = $(this).attr("id");
				var list = JSON.parse('${purchaseExplainJson}');
				
				$(list).each(function(idx, item){
					if(item.CODE == exId){
						var exNote = (item.NOTE).replaceAll("<br>",'\r\n');
						console.log(exNote);
						$("#" + exId).attr("title",exNote);
					}
				});
			});
			
		});
		
		function init(){
			
			$('#resultAmt').maskMoney({
				precision : 0,
				allowNegative: false
			});
			
			$('#resultAmt').keyup(function() {
				var amtInt = $('#resultAmt').val().replace(/,/g, '');
				$('#resultAmt_han').text(viewKorean($('#resultAmt').val().replace(/,/g, '')));
			});	
			
			$('#resultAmt_han').text(viewKorean($('#resultAmt').val().replace(/,/g, '')));
			
			inputTypeSet();
		}		
		
		function fnChangeTarget(e){
			
			if(e.checked){
				$("[itemNo="+$(e).attr("targetkey")+"]").show();
				$("[itemTarget=target_"+$(e).attr("targetkey")+"]").attr("use_yn", "Y");
			}else{
				$("[itemNo="+$(e).attr("targetkey")+"]").hide();
				$("[itemTarget=target_"+$(e).attr("targetkey")+"]").attr("use_yn", "N");
			}
			
			fnCalculateResultScore();
		}	
		
		function setResultTargetInfo(value){
			
			if(value != ""){
				
				$.each(value.split("▦▦"), function( key, val ) {
					
					console.log(val);
					
					var valInfo =  val.split("▦");
					var itemNo = valInfo[0];
					var i=0;
					
		            for (var x = 3; x < valInfo.length-1; x++) {
		                $("[itemscore="+itemNo+"]")[i].value = valInfo[x];
		                i++;
		            }					
					
				});	
				
			}
			
		}
		
		function fnCalculateResultScore(){
			
			$("[colspanTarget=Y]").attr("colspan", $("[name=compTr] [use_yn=Y]").length);
			
			if($("[name=resultScoreList] tr[name=addData]").length > 0){
				
				var allPointRate = 0;
				
				$.each($("[name=resultScoreList] tr[name=addData]"), function( idx, obj ) {
					
					var rate = $(obj).find("[itemType=rate]").val();
					
					rate = rate == "" ? 0 : parseFloat(rate);
					
					allPointRate += rate;
					
					
				});
				
				  if (Number.isInteger(allPointRate)) {
					  allPointRate; // 정수인 경우 그대로 반환
					  } else {
						  allPointRate = allPointRate.toFixed(4); // 소수인 경우 4자리 이하로 자름
				  }
				
				
				$("[itemType = sumrate]").text(allPointRate);
				
				$.each($("[name=compTr] th[use_yn=Y]"), function( key, val ) {
					
					var itemNo = $(val).attr("itemNo");
					var totalScore = parseFloat("0.00");
					
					$.each($("[itemscore="+itemNo+"]"), function( idx, thisScore ) {
						
						var thisValue = parseFloat($(thisScore).val() == "" ? 0 : $(thisScore).val());
						
						totalScore = totalScore + thisValue;
						
					});	
					
					  if (Number.isInteger(totalScore)) {
						  totalScore; // 정수인 경우 그대로 반환
						  } else {
							  totalScore = totalScore.toFixed(4); // 소수인 경우 4자리 이하로 자름
					  }
					
					
					$("[itemTotal="+itemNo+"]").text(totalScore);
					
				});	
				
				$.each($("[name=compTr] th[use_yn=Y]"), function( key, val ) {
					
					var itemNo = $(val).attr("itemNo");
					var thisTotal = parseFloat($("[itemtotal="+itemNo+"]").text() == "" ? "0" : $("[itemtotal="+itemNo+"]").text());
					var rankNum = 1;
					
					$.each($("[name=compTr] th[use_yn=Y]"), function( idx, thisScore ) {
						
						var itemNo2 = $(thisScore).attr("itemNo");
						
						if(itemNo != itemNo2){
							if(thisTotal < parseFloat($("[itemtotal="+itemNo2+"]").text() == "" ? "0" : $("[itemtotal="+itemNo2+"]").text())){
								rankNum++;
							}
						}
						
					});
					
					$("[itemrank="+itemNo+"]").text(rankNum);
					
				});					
				
			}
			
		}
		
		
		function getResultTargetInfo(){
			
			var returnStr = "";
			
			$.each($("[name=compTr] th[use_yn=Y]"), function( key, val ) {
				
				var itemNo = $(val).attr("itemNo");
				
				var targetInfo = itemNo + "▦" + $("[itemrank="+itemNo+"]").text() + "▦" + $("[itemtotal="+itemNo+"]").text();
				
				$.each($("[itemscore="+itemNo+"]"), function( idx, thisScore ) {
					
					targetInfo += "▦" + ($(thisScore).val() == "" ? "0" : $(thisScore).val());
					
				});				
				
				returnStr += (returnStr == "" ? "" : "▦▦") + targetInfo;
				
			});		
			
			return returnStr;
		}
		
		
		function inputTypeSet(){
			
			$("[inputDecimal=Y]").off('blur').on('blur',function(e){

			    var value = $(this).val();
			    var regExp = /^\.|\.$/;
			    if(regExp.test(this.value)){
			        $(this).val(value.replace('.',''));
			    }

			});

			// 소수점 둘째자리까지의 실수만 입력 허용 -> 20230414 소수점 넷째자리까지로 수정 윤의진
			$("[inputDecimal=Y]").off('input').on('input',function(e){

			    var value = $(this).val();
			    var regExp = /^\d*.?\d{0,4}$/;
			    if(!regExp.test(this.value)){
			        $(this).val(value.substring(0,value.length-1));
			    }

			});

			// 숫자와 .(마침표)만 입력 허용
			$("[inputDecimal=Y]").off('keypress').on('keypress',function(e){

			    e = e || window.event;
			    var charCode = e.which || e.keyCode;
			    // var charStr = String.fromCharCode(charCode);
			    if (!((charCode >= 48 && charCode <= 57) || charCode === 46)){
			        return false;
			    }

			});		
			
			$("[inputDecimal=Y]").on('keyup',function(e){
			    fnCalculateResultScore();
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
			
		}
		
		function fnSectorAdd(tableName, baseName, maxCnt){
			
			var aaDataCnt = $('[name="'+tableName+'"] [name=addData]').length + 1;
			
			if(maxCnt != null && aaDataCnt > maxCnt){
				msgSnackbar("warning", "등록 가능한 개수를 초과했습니다.");
				return;
			}
			
			var cloneData = $('[name="'+baseName+'"]').clone();
			$(cloneData).show().attr("name", "addData").attr("rowcnt", aaDataCnt);
			
			$('[name="'+baseName+'"]').before(cloneData);
			
			if(tableName == "resultScoreList"){
				inputTypeSet();	
			}else if(tableName == "nomineeList"){
				
				$("[itemNo="+aaDataCnt+"]").show();
				$("[itemTarget=target_"+aaDataCnt+"]").attr("use_yn", "Y");				
				fnCalculateResultScore();
			}
			
		}
		
		function fnSectorDel(e, tableName){
			
			if(tableName != null && $('[name="'+tableName+'"] [name=addData]').length == 1){
				return;
			}
			
			$(e).closest("tr").remove();
			
			if(tableName == "nomineeList"){
				
				var itemNo = 0;
				
				$.each($('[name="'+tableName+'"] [name=addData]'), function( idx, obj ) {
					
					itemNo = idx+1;
					
					$(obj).attr("rowcnt",itemNo);
					
					$("[itemTarget=target_"+itemNo+"]").text($(obj).find("[name=tableVal]").val())
					
				});
				
	            for (var x = 10; x > itemNo; x--) {
					$("[itemNo="+x+"]").hide();
					$("[itemTarget=target_"+x+"]").attr("use_yn", "N");
	            }				
				
			}
			
			fnCalculateResultScore();
			
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
				insertDataObject.result_target_info = getResultTargetInfo();
				
				
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
			
			//제안서평과위원정보 html
			var resultJudgesInfoHtml = "";
			
			$('[name=resultJudgesListHtml]').find("[displaynone]").removeAttr("displaynone");
			$('[name=resultJudgesListHtml]').find(":hidden").attr("displaynone", "Y");
			
			var cloneData = $('[name=resultJudgesListHtml]').clone();
			$(cloneData).find("[displaynone]").remove();
			$(cloneData).find("[removehtml=Y]").remove();
			$(cloneData).find("[name=resultJudgesAddBase]").remove();
			$(cloneData).find("[name=resultJudgesList]").attr("border", "1");
			$(cloneData).find("[name=resultJudgesList]").attr("width", "100%");
			$(cloneData).find("[name]").removeAttr("name");
			$(cloneData).find("th").attr("align", "center").attr("bgcolor", "#f1f1f1").attr("height", "25");
			$(cloneData).find("td").attr("align", "center").attr("height", "20");
			
			//input 요소 텍스트화
			$.each($(cloneData).find("input"), function( idx, obj ) {
				$(obj).replaceWith($(obj).val());
			});
			
			resultJudgesInfoHtml = $(cloneData)[0].outerHTML;
			insertDataObject.result_judges_info_html = resultJudgesInfoHtml;
			
			//제안서평과결과정보 html
			var resultScoreInfoHtml = "";
			
			$('[name=resultScoreListHtml]').find("[displaynone]").removeAttr("displaynone");
			$('[name=resultScoreListHtml]').find(":hidden").attr("displaynone", "Y");
			
			var cloneData = $('[name=resultScoreListHtml]').clone();
			$(cloneData).find("[displaynone]").remove();
			$(cloneData).find("[removehtml=Y]").remove();
			$(cloneData).find("[name=scoreInfoAddBase]").remove();
			$(cloneData).find("[name=resultScoreList]").attr("border", "1");
			$(cloneData).find("[name=resultScoreList]").attr("width", "100%");
			$(cloneData).find("[name]").removeAttr("name");
			$(cloneData).find("th").attr("align", "center").attr("bgcolor", "#f1f1f1").attr("height", "25");
			$(cloneData).find("td").attr("align", "center").attr("height", "20");
			
			$.each($(cloneData).find("[colspanHtml]"), function( idx, obj ) {
				$(obj).attr("colspan", $(obj).attr("colspanHtml"));
			});
			
			//input 요소 텍스트화
			$.each($(cloneData).find("input"), function( idx, obj ) {
				$(obj).replaceWith($(obj).val());
			});	
			
			//Clone객체 select checked option 정보 누락 현상관련 temp변수에 임시저장/활용
			var selectTextTemp = [];
			$.each($('[name=resultScoreList]').find("select"), function( idx, obj ) {
				selectTextTemp.push($(obj).find("option:checked").text());
			});	
			
			$.each($(cloneData).find("select"), function( idx, obj ) {
				$(obj).replaceWith(selectTextTemp[idx]);
			});
			
			resultScoreInfoHtml = $(cloneData)[0].outerHTML;
			insertDataObject.result_score_info_html = resultScoreInfoHtml;
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/ResultSaveProc.do" />',
	    		datatype:"json",
	            data: insertDataObject ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						openerRefreshList();
						
						if(type == 1){
										
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
			if(opener != null && typeof opener.BindGrid != "undefined"){
				/* opener.BindGrid(); */
				opener.gridReload();
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
					
					$(cloneData).show().attr("name", "addData").attr("rowcnt", key+1);
					$('[name="'+baseName+'"]').before(cloneData);
					
				});	
				
			}
		}		
		
		function fnNomineeNameSync(e){
			
			var itemNo = $(e).closest("tr").attr("rowcnt");
			
			$("[itemTarget=target_"+itemNo+"]").text(e.value);
			
		}
		
		
		/*품의서 보기*/
		function titleOnClickApp(c_dikeyCode, c_miseqnum, c_diseqnum, c_rideleteopt, c_tifogmgb, c_distatus) {
			
 			if(c_dikeyCode ==''){
				fnPuddDiaLog("warning", NeosUtil.getMessage("TX000009232","문서가 존재하지 않습니다"));
				return;
			}
			
			var obj = {
					diSeqNum  : c_diseqnum,
					miSeqNum  : c_miseqnum,
					diKeyCode : c_dikeyCode,
					tiFormGb  : c_tifogmgb,
					diStatus  : c_distatus,
					isApp  : 'Y',
					mod  : 'V',
					userSe  : 'MASTER',
					multiViewYN  : 'N',
					MANAGE_VIEW  : 'Y',
					RIGHT_VIEW  : 'Y',
					socketList : 'Y'
				};
			var param = NeosUtil.makeParam(obj);
			neosPopup("POP_DOCVIEW", param);  

			
		}
		
		
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
					<c:if test="${btnApprYn == 'Y'}">
					<input type="button" class="psh_btn" onclick="fnCallBtn('attach')" value="첨부파일" />
					</c:if>
					<c:if test="${btnApprYn == 'N'}">
					<input type="button" class="psh_btn" onclick="titleOnClickApp('${contractDetailInfo.appr_dikey_result}','','','','0','${contractDetailInfo.appr_status_result}')" value="품의서보기" /> 
					</c:if>
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
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 평가위원</th>
					<td colspan="3">
						<!-- 그리드 -->
						<div name="resultJudgesListHtml" class="com_ta4">
							<table name="resultJudgesList" objKey="result_judges_info" objCheckFor="checkVal('table', 'resultJudgesList', '평가위원', 'true')">
								<colgroup>
									<c:if test="${disabledYn == 'N'}">
									<col removeHtml="Y" width="50"/>
									</c:if>
									<col width="180"/>
									<col width="120"/>
									<col width="130"/>
									<col width=""/>
								</colgroup>
								<tr>
									<c:if test="${disabledYn == 'N'}">
									<th removeHtml="Y" class="ac">
										<input type="button" onclick="fnSectorAdd('resultJudgesList', 'resultJudgesAddBase')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									</c:if>
									<th class="ac">소속</th>
									<th class="ac">성명</th>
									<th class="ac">직위</th>
									<th class="ac">비고
									<img class="explain" id="12" title="" src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_manual.png" alt="" />
									</th>
								</tr>
								<tr name="addData">
									<c:if test="${disabledYn == 'N'}">
									<td removeHtml="Y">
										<input type="button" onclick="fnSectorDel(this, 'resultJudgesList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>
									<td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input ${disabled} name="tableVal" requiredNot="true" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
								</tr>								
								<tr name="resultJudgesAddBase" style="display:none;">
									<c:if test="${disabledYn == 'N'}">
									<td removeHtml="Y">
										<input type="button" onclick="fnSectorDel(this, 'resultJudgesList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>
									<td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input ${disabled} name="tableVal" requiredNot="true" must type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
								</tr>								
							</table>
						</div>
					</td>
				</tr>
				
				<c:if test="${contractDetailInfo.compete_type == '02'}">
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 평가대상(지명경쟁)</th>
					<td colspan="3">
					
					<c:forEach var="items" items="${contractDetailInfo.nominee_info.split('▦▦') }" varStatus="status">
					<input type="checkbox" targetKey="${status.index+1}" onclick="fnChangeTarget(this)" value="${items.split('▦')[1]}" class="puddSetup" pudd-label="${items.split('▦')[0]}" checked />
					</c:forEach>
					
					</td>
				</tr>
				</c:if>
				
				<c:if test="${contractDetailInfo.compete_type != '02'}">
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 평가대상</th>
					<td colspan="5">						
						<!-- 테이블 -->
						<div class="com_ta4">
							<table name="nomineeList" objKey=nominee_info objCheckFor="checkVal('table', 'nomineeList', '평가대상', 'true', 'notnull')" >
								<colgroup>
									<c:if test="${disabledYn == 'N'}">
									<col width="34"/>
									</c:if>
<%-- 									<col width=""/>
									<col width="150"/> --%>
								</colgroup>
								<tr>
									<c:if test="${disabledYn == 'N'}">
									<th class="ac">
										<input type="button" onclick="fnSectorAdd('nomineeList', 'nomineeAddBase', 10)" id="" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									</c:if>
									<th class="ac"><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 업체명</th>
									<%-- <th class="ac"><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 사업자번호</th> --%>
								</tr>
								<tr name="addData" rowcnt="1">
									<c:if test="${disabledYn == 'N'}">
									<td>
										<input type="button" onclick="fnSectorDel(this, 'nomineeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>
									<td><input ${disabled} onkeyup="fnNomineeNameSync(this);" name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
									<%-- <td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td> --%>
									<input ${disabled} name="tableVal" type="hidden" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" />
								</tr>	
								<tr name="nomineeAddBase" style="display:none;">
									<c:if test="${disabledYn == 'N'}">
									<td>
										<input type="button" onclick="fnSectorDel(this, 'nomineeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>
									<td><input ${disabled} onkeyup="fnNomineeNameSync(this);" name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td>
									<%-- <td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" /></td> --%>
									<input ${disabled} name="tableVal" type="hidden" pudd-style="width:calc( 100% - 20px);" class="puddSetup" value="" />
								</tr>															
							</table>
						</div>
					</td>
				</tr>
				</c:if>
				
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 제안서 평가결과
						<img class="explain" id="13" title="" src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_manual.png" alt="" />
					</th>
					<td colspan="3">
						<!-- 그리드 -->
						<div name="resultScoreListHtml" class="com_ta4">
							<table name="resultScoreList" objKey="result_score_info" objCheckFor="checkVal('table', 'resultScoreList', '제안서 평가결과', 'true', 'notnull')">
								<colgroup>
									<c:if test="${disabledYn == 'N'}">
									<col removeHtml="Y" width="50"/>
									</c:if>
									<col width="150"/>
									<col width=""/>
									<col width=""/>
									<col itemNo="1" width=""/>
									<col itemNo="2" width=""/>
									<col itemNo="3" width=""/>
									<col itemNo="4" width=""/>
									<col itemNo="5" width=""/>
									<col itemNo="6" width=""/>
									<col itemNo="7" width=""/>
									<col itemNo="8" width=""/>
									<col itemNo="9" width=""/>
									<col itemNo="10" width=""/>
								</colgroup>
								<tr>
									<c:if test="${disabledYn == 'N'}">
									<th removeHtml="Y" class="ac" rowspan="2">
										<input type="button" onclick="fnSectorAdd('resultScoreList', 'scoreInfoAddBase')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									</c:if>
									<th class="ac" rowspan="2" colspan="2">구분</th>
									<th class="ac" rowspan="2">배점</th>
									<th class="ac" colspan="5" colspanTarget="Y">업체명</th>
								</tr>
								<tr name="compTr">
									<th itemNo="1" itemTarget="target_1" use_yn = "N" class="ac">-</th>
									<th itemNo="2" itemTarget="target_2" use_yn = "N" class="ac">-</th>
									<th itemNo="3" itemTarget="target_3" use_yn = "N" class="ac">-</th>
									<th itemNo="4" itemTarget="target_4" use_yn = "N" class="ac">-</th>
									<th itemNo="5" itemTarget="target_5" use_yn = "N" class="ac">-</th>
									<th itemNo="6" itemTarget="target_6" use_yn = "N" class="ac">-</th>
									<th itemNo="7" itemTarget="target_7" use_yn = "N" class="ac">-</th>
									<th itemNo="8" itemTarget="target_8" use_yn = "N" class="ac">-</th>
									<th itemNo="9" itemTarget="target_9" use_yn = "N" class="ac">-</th>
									<th itemNo="10" itemTarget="target_10" use_yn = "N" class="ac">-</th>
									
								</tr>

								<tr name="scoreInfoAddBase" style="display:none;">
									<c:if test="${disabledYn == 'N'}">
									<td removeHtml="Y">
										<input type="button" onclick="fnSectorDel(this)" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
									</td>
									</c:if>
									<td>
										<select ${disabled} name="tableVal" style="width: 90;">
											<c:forEach var="items" items="${scoreTypeCode}">
											<option value="${items.CODE}">${items.NAME}</option>
											</c:forEach>
										</select>									
									</td>
									<td><input ${disabled} name="tableVal" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup" value="" /></td>
									<td><input ${disabled} name="tableVal" itemType = "rate" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									
									<td itemNo="1"><input ${disabled} itemScore="1" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="2"><input ${disabled} itemScore="2" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="3"><input ${disabled} itemScore="3" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="4"><input ${disabled} itemScore="4" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="5"><input ${disabled} itemScore="5" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="6"><input ${disabled} itemScore="6" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="7"><input ${disabled} itemScore="7" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="8"><input ${disabled} itemScore="8" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="9"><input ${disabled} itemScore="9" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
									<td itemNo="10"><input ${disabled} itemScore="10" inputDecimal="Y" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup ac" value="" /></td>
								</tr>
								
								<tr name="totalTr">
									<td colspanHtml="2" colspan="<c:if test="${disabledYn == 'N'}">3</c:if><c:if test="${disabledYn == 'Y'}">2</c:if>">합계</td>
									<td itemType = "sumrate" class="cen">0</td>
									
									<td itemNo="1" itemTotal="1" class="cen"></td>
									<td itemNo="2" itemTotal="2" class="cen"></td>
									<td itemNo="3" itemTotal="3" class="cen"></td>
									<td itemNo="4" itemTotal="4" class="cen"></td>
									<td itemNo="5" itemTotal="5" class="cen"></td>
									<td itemNo="6" itemTotal="6" class="cen"></td>
									<td itemNo="7" itemTotal="7" class="cen"></td>
									<td itemNo="8" itemTotal="8" class="cen"></td>
									<td itemNo="9" itemTotal="9" class="cen"></td>
									<td itemNo="10" itemTotal="10" class="cen"></td>
								</tr>
								<tr name="rankTr">
									<td colspanHtml="2" colspan="<c:if test="${disabledYn == 'N'}">3</c:if><c:if test="${disabledYn == 'Y'}">2</c:if>">우선협상순위</td>
									<td class="cen"></td>
									
									<td itemNo="1" itemRank="1" class="cen"></td>
									<td itemNo="2" itemRank="2" class="cen"></td>
									<td itemNo="3" itemRank="3" class="cen"></td>
									<td itemNo="4" itemRank="4" class="cen"></td>
									<td itemNo="5" itemRank="5" class="cen"></td>
									<td itemNo="6" itemRank="6" class="cen"></td>
									<td itemNo="7" itemRank="7" class="cen"></td>
									<td itemNo="8" itemRank="8" class="cen"></td>
									<td itemNo="9" itemRank="9" class="cen"></td>
									<td itemNo="10" itemRank="10" class="cen"></td>
								</tr>
							</table>
						</div>
					</td>
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" />낙찰가격(투찰가격)
						<img class="explain" id="14" title="" src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_manual.png" alt="" />
					</th>
					<td colspan="3">
						<input ${disabled} objKey="result_amt" objCheckFor="checkVal('text', this, '낙찰가격', 'mustAlert', 'parseToInt')" id="resultAmt" type="text" pudd-style="width:150px;" class="puddSetup ar" value="${contractDetailInfo.result_amt}" maxlength="15"/> 원 
						<span id="resultAmt_han"></span>
						/ VAT 포함		
					</td>
				</tr>
			</table>
		</div>			
	</div>
</div><!-- //pop_wrap -->

</body>
</html>

