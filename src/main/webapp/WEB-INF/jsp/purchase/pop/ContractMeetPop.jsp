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
    <title>제안서 평가위원회 개최</title>

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
	
	<jsp:include page="/WEB-INF/jsp/common/cmmJunctionCodePop.jsp" flush="false" />		
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/UserOptionMap.jsp" flush="false" />	
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/NpUserResPop.jsp" flush="false" />		
	
	<script type="text/javascript">
	
		/* 예산관련 변수 시작 */
		var consDocSeq = "";
		var consSeq = "";
		
		var eaBaseInfo = ${eaBaseInfo};
		var commonParam = {};
		var commonElement;
		
		commonParam.callback = 'fnCommonCode_callback';
		commonParam.widthSize = "628";
		commonParam.heightSize = "546";
		commonParam.erpGisu = optionSet.erpGisu.gisu; /* ERP 기수 */
		commonParam.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
		commonParam.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
		commonParam.gisu = optionSet.erpGisu.gisu; /* ERP 기수 */
		commonParam.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
		commonParam.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
		
		commonParam.erpDivSeq = optionSet.erpEmpInfo.erpDivSeq;
		commonParam.erpDivName = optionSet.erpEmpInfo.erpDivName;
		
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
			$(cloneData).find("[name=txt_pay_amt]").val("${items.amt}");
			$(cloneData).find("[name=txt_balance_amt]").val("${items.txt_balance_amt}");
			
			
			$('[name="budgetList"]').append(cloneData);
			
			if(${status.index} == 0){
				fnSetBudgetAmtInfo(cloneData);	
			}
			
			</c:forEach>			
			</c:if>			
			
		}	
		
		
		var callbackResult;

		function fnCommonCode_callback(param) {
			
			callbackResult = param;
			
			if(param != null){
				
				//거래처 
				if(param.code == "tr"){
					$("[objKey=tr_seq]").val( param.trSeq || "" );
					$("[objKey=tr_name]").val( param.trName || "" );
					$("[objKey=tr_reg_number]").text( param.trRegNumber || "" );
					$("[objKey=ceo_name]").text( param.ceoName || "" );
					$("[objKey=addr]").text( param.addr || "" );
					
					$("[objKey=at_tr_name]").val( param.atTrName || "" );
					$("[objKey=ba_nb]").val( param.baNb || "" );
					$("[objKey=btr_name]").val( param.btrName || "" );
					$("[objKey=btr_seq]").val( param.btrSeq || "" );
					$("[objKey=depositor]").val( param.depositor || "" );
					$("[objKey=tr_fg]").val( param.trFg || "" );
					$("[objKey=tr_fg_name]").val( param.trFgName || "" );
				
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
					fnSetBudgetAmtInfo(null, true);
					
				}			
				
			}
			
		}
		
		
		/*	[예산조회] 예산잔액 가조회
		------------------------------------------- */
		function fnSetBudgetAmtInfo(e, calAmt){
			
			if(e != null){
				if(commonElement == e){
					return;
				}else{
					commonElement = e;	
				}
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

						var data = result.result.aData;
						$('#txtOpenAmt').text(fnGetCurrencyCode(data.openAmt));
						$('#txtConsBalanceAmt').text(fnGetCurrencyCode(data.consBalanceAmt));
						$('#txtApplyAmt').text(fnGetCurrencyCode(data.resApplyAmt));
						$('#txtBalanceAmt').text(fnGetCurrencyCode(data.balanceAmt));
						
						
						$(commonElement).find("[name=txt_open_amt]").val(fnGetCurrencyCode(data.openAmt));
						$(commonElement).find("[name=txt_cons_balance_amt]").val(fnGetCurrencyCode(data.consBalanceAmt));
						$(commonElement).find("[name=txt_apply_amt]").val(fnGetCurrencyCode(data.resApplyAmt));
						$(commonElement).find("[name=txt_balance_amt]").val(fnGetCurrencyCode(data.balanceAmt));
						
						
						if(calAmt){
							//금액 초기화
							$(commonElement).find("[name=amt]").val("0");
							
							if(data.balanceAmt > 0){
								
								var meetAmtSpent = 0;
								var totalAmt = 0;
								var remainAmt = 0;
								
								if($("#meetAmtSpent").val() != "" && $("#meetAmtSpent").val() != "0"){
									meetAmtSpent = parseInt($("#meetAmtSpent").val().replace(/,/g, ''));
								}
								
								$.each($("[name=addData] [name=amt]"), function( idx, obj ) {
									if($(obj).val() != "" && $(obj).val() != "0"){
										totalAmt += parseInt($(obj).val().replace(/,/g, ''));
									}
								});								
								
								remainAmt = meetAmtSpent - totalAmt;
								
								if(remainAmt > 0){
									
									if(remainAmt > data.balanceAmt){
										$(commonElement).find("[name=amt]").val(data.balanceAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
									}else{
										$(commonElement).find("[name=amt]").val(remainAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
									}
								}
							}
					
						}

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
		
		
		function fnCommonCodeCustomPop(code, e) {
			
			if(e != null){
				commonElement = $(e).closest("tr");
				
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

			/* 팝업 호출 */
			commonParam.widthSize = 780;
			commonParam.heightSize = 582;

			fnCallCommonCodePop({
				code : code,
				popupType : 2,
				param : JSON.stringify(commonParam),
				callbackFunction : commonParam.callback,
				dummy : JSON.stringify({})
			});			
			
			/* [ return ] */
			return;
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
			
			$('[amountInput=Y]').maskMoney({
				precision : 0,
				allowNegative: false
			});	
		}		
		
		function fnSectorDel(e, tableName){
			
			if(tableName != null && $('[name="'+tableName+'"] [name=addData]').length == 1){
				return;
			}
			
			$(e).closest("tr").remove();
			
		}		
		
		
		/* 예산관련 변수 끝 */
	
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
			
			$('#meetAmtSpent, [amountInput=Y]').maskMoney({
				precision : 0,
				allowNegative: false
			});			
			
			$("#amt").text("₩ ${contractDetailInfo.amt} " + viewKorean("${contractDetailInfo.amt}".replace(/,/g, '')) + " / 부가세 포함");
			
			//옵션값 설정
			setCommonOption();
			
			setDynamicSetInfoBudget();
			setDynamicSetInfoAmt();
			
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
				insertDataObject.budget_list_info = JSON.stringify(insertDataObject.budgetObjList);
				
				//신청금액 체크
				var meetAmtSpent = 0;
				var totalAmt = 0;
				var remainAmt = 0;
				
				if($("#meetAmtSpent").val() != "" && $("#meetAmtSpent").val() != "0"){
					meetAmtSpent = parseInt($("#meetAmtSpent").val().replace(/,/g, ''));
				}
				
				$.each($("[name=addData] [name=amt]"), function( idx, obj ) {
					if($(obj).val() != "" && $(obj).val() != "0"){
						totalAmt += parseInt($(obj).val().replace(/,/g, ''));
					}
				});								
				
				if(meetAmtSpent != totalAmt){
					msgSnackbar("warning", "지출금액과 신청금액이 일치하지 않습니다.");
					return;
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
			insertDataObject.outProcessCode = outProcessCode;
			insertDataObject.viewType = "${viewType}"
			insertDataObject.seq = "${seq}"
			insertDataObject.meet_dt = $("[name=meetDt]").parent().find("input")[1].value + " " + insertDataObject.meet_start_hh +  ":" + insertDataObject.meet_start_mm + "~" + insertDataObject.meet_end_hh + ":" + insertDataObject.meet_end_mm;
			
			
			//contract html 
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
			insertDataObject.result_c_amt_info_html = resultAmtListHtml;
			
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/MeetSaveProc.do" />',
	    		datatype:"json",
	            data: insertDataObject ,
				async : true,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						openerRefreshList();	
						
						if(type == 1){
										
							msgAlert("success", "임시저장이 완료되었습니다.", "self.close()");							
						}else{
							
							fnPaymentCreate();

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
		
		var conclusionbudgetList = [];
		var conclusionRemainAmt = 0;			
		
		function fnPaymentCreate(){

			//기존 품의(임시)데이터 삭제
			parameter = {};
			parameter.out_process_interface_id = outProcessCode;
			parameter.out_process_interface_m_id = "${seq}";
			parameter.out_process_interface_d_id = "DUPLICATE_TEMP";			
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/DelConsTemp.do" />',
	    		datatype:"json",
	            data: parameter ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "SUCCESS"){
						conclusionbudgetList = insertDataObject.budgetObjList;
						conclusionRemainAmt = parseInt(insertDataObject.meet_amt_spent);
						fnConsDocInsert();
					}else{
						msgSnackbar("error", "품의데이터 초기화 오류");	
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "품의데이터 초기화 오류");
				}
			});			
				
		}		
		
		
		function fnConsDocInsert() {
			/* [ parameter ] */
			parameter = {};

			parameter.resNote = ''; /* 결의문서 적요 */
			parameter.erpCompSeq = ''; /* ERP 회사 코드 */
			parameter.erpDivSeq = ''; /* ERP 사업장 명칭 */
			parameter.erpDivName = ''; /* ERP 사업장 명칭 */
			parameter.erpDeptSeq = ''; /* ERP 부서 코드 */
			parameter.erpEmpSeq = ''; /* ERP 사원 코드 */
			parameter.erpGisu = ''; /* ERP 기수 */
			parameter.erpExpendYear = ''; /* ERP 회계 연도 */
			parameter.compSeq = ''; /* GW 회사 코드 */
			parameter.compName = ''; /* GW 회사 명칭 */
			parameter.deptSeq = ''; /* GW 부서 코드 */
			parameter.deptName = ''; /* GW 부서 명칭 */
			parameter.empSeq = ''; /* GW 사용자 코드 */
			parameter.empName = ''; /* GW 사용자 명칭 */
			parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
			parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
			parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

			/* 외부연동 ( 전용개발 또는 내부 개발 항목 - 근태 등 ) */
			parameter.outProcessInterfaceId = outProcessCode;
			parameter.outProcessInterfaceMId = "${seq}";
			parameter.outProcessInterfaceDId = "DUPLICATE_TEMP";
			
			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/ex/np/user/cons/ConsDocInsert.do',
				datatype : 'json',
				async : false,
				/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
				data : Option.Common.GetSaveParam(parameter),
				success : function(result) {
					/* 결의 정보 저장 */
					var aData = Option.Common.GetResult(result, 'aData');
					optionSet.consDocInfo = aData;
					
					if (aData) {
						
						consDocSeq = aData.consDocSeq;
						
						$.each(conclusionbudgetList, function( idx, conclusionbudgetInfo ) {
							fnConsInsert(idx);
						});
						
					} else {
						resDocSeq = '';
						msgSnackbar("error", "품의서 연동데이터(ConsDoc) 생성 실패");
					}
				},
				error : function(result) {
					msgSnackbar("error", "품의서 연동데이터(ConsHead) 생성 실패");
				}
			});
			return;
		}			
		
		
		function fnConsInsert(idx) {
			
			parameter.consDocSeq = consDocSeq; /* [*]품의문서 키 */
			parameter.docuFgCode = '1'; /* [*]결의구분코드 */
			parameter.docuFgName = '지출품의서'; /* [*]결의구분명칭 */

			parameter.btrSeq = ''; /* [*]입출금계좌코드 */
			parameter.btrName = ''; /* [*]입출금계좌명칭 */
			parameter.btrNb = ''; /* [*]입출금계좌 */
			
			parameter.erpDivSeq = ''; /* ERP 회계단위코드 */
			parameter.erpDivName = ''; /* ERP 회계단위명칭 */
			parameter.erpMgtSeq = conclusionbudgetList[idx].pjt_seq; /* [*]부서/프로젝트 코드 */
			parameter.erpMgtName = conclusionbudgetList[idx].pjt_name; /* [*]부서/프로젝트 명칭 */
			parameter.bottomSeq = conclusionbudgetList[idx].bottom_seq; /* [*]하위사업코드 */
			parameter.bottomName = conclusionbudgetList[idx].bottom_name; /* [*]하위사업명칭 */
			parameter.consDate = '${toDate}';
			parameter.causeDate = '';
			parameter.inspectDate = '';
			parameter.signDate = '';
			parameter.pjtToDate = '';
			parameter.pjtFromDate = '';
			
			parameter.erpGisu = '';
			parameter.gisu = (Option.Common.iCUBE() ? optionSet.erpGisu.gisu : '0');
			parameter.erpGisuFromDate = (Option.Common.iCUBE() ? optionSet.erpGisu.fromDate : '');
			parameter.erpGisuToDate = (Option.Common.iCUBE() ? optionSet.erpGisu.toDate : '');
			parameter.erpYear = ((parameter.consDate || '').length >= 4 ? parameter.consDate.substring(0, 4) : '')

			parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
			parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
			parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/ex/np/user/cons/ConsHeadInsert.do',
				datatype : 'json',
				async : false,
				data : Option.Common.GetSaveParam(parameter),
				success : function(result) {

					var aData = Option.Common.GetResult(result, 'aData');
					var resultCode = Option.Common.GetResultCode(result);

					if (resultCode === 'SUCCESS') {
						consSeq = aData.consSeq;
						
						fnBudgetInsert(idx);
						
					}  else if(resultCode == 'GISU_CLOSE'){
						msgSnackbar("error", "기수 마감되어 품의서를 입력할 수 없습니다.");
					} else {
						msgSnackbar("error", "품의서 연동데이터(ConsHead) 생성 실패");
					}
				},
				error : function(result) {
					msgSnackbar("error", "품의서 연동데이터(ConsHead) 생성 실패");
				}
			});

			return;
		}		
		
		
		
		function fnBudgetInsert(idx) {

			parameter.consDocSeq = consDocSeq; /* [*]품의문서 키 */
			parameter.consSeq = consSeq; /* [*]품의문서 키 */

			
			parameter.erpBudgetDivSeq = conclusionbudgetList[idx].erp_budget_div_seq;
			parameter.erpBudgetDivName = conclusionbudgetList[idx].erp_budget_div_name;		
			
			parameter.erpBudgetSeq = conclusionbudgetList[idx].erp_budget_seq; /* [*]ERP 예산과목 코드 (예산단위 코드) */
			parameter.erpBudgetName = conclusionbudgetList[idx].erp_budget_name; /* [*]ERP 예산과목 명칭 (예산단위 명칭) */
			
			parameter.erpMgtSeq = conclusionbudgetList[idx].pjt_seq; /* [*]부서/프로젝트 코드 */
			parameter.erpMgtName = conclusionbudgetList[idx].pjt_name; /* [*]부서/프로젝트 명칭 */
			parameter.bottomSeq = conclusionbudgetList[idx].bottom_seq; /* [*]하위사업코드 */
			parameter.bottomName = conclusionbudgetList[idx].bottom_name; /* [*]하위사업명칭 */		
			
			parameter.erpBgt1Name = conclusionbudgetList[idx].erp_bgt1_name; /* [*]관 명칭 */
			parameter.erpBgt1Seq = conclusionbudgetList[idx].erp_bgt1_seq; /* [*]관 코드 */
			parameter.erpBgt2Name = conclusionbudgetList[idx].erp_bgt2_name; /* [*]항 명칭 */
			parameter.erpBgt2Seq = conclusionbudgetList[idx].erp_bgt2_seq; /* [*]항 코드 */
			parameter.erpBgt3Name = conclusionbudgetList[idx].erp_bgt3_name; /* [*]목 명칭 */
			parameter.erpBgt3Seq = conclusionbudgetList[idx].erp_bgt3_seq; /* [*]목 코드 */
			parameter.erpBgt4Name = conclusionbudgetList[idx].erp_bgt4_name; /* [*]세 명칭 */
			parameter.erpBgt4Seq = conclusionbudgetList[idx].erp_bgt4_seq; /* [*]세 코드 */
			
			parameter.erpOpenAmt = '0'; /* [*]ERP 예산 편성 금액 */
			parameter.erpApplyAmt = '0'; /* [*]ERP 집행액 */
			parameter.erpLeftAmt = '0'; /* [*]ERP 잔액 */
			parameter.budgetAmt = '0'; /* [*]총금액 */
			
			parameter.expendDate = parameter.consDate.replace(/-/g, '');

			/* 부가세 통제 여부 체크 */
			if (optionSet.erpEmpInfo.vatControl == '1'){
				parameter.ctlFgCode = '1';
				parameter.ctlFgName = 'I_IN_TAX_Y';
			}else {
				parameter.ctlFgCode = '0';
				parameter.ctlFgName = 'I_IN_TAX_N';
			}
			
			//예산잔액 조회
			$.ajax({
				type : 'post',
				url : '<c:url value="/ex/np/user/res/resBudgetInfoSelect.do" />',
				datatype : 'json',
				async : false,
				data : parameter,
				success : function(result) {
					var data = result.result.aData;
					
					conclusionbudgetList[idx].balanceAmt = Math.floor(data.balanceAmt/10)*10;
					conclusionbudgetList[idx].erpOpenAmt = data.openAmt;
					conclusionbudgetList[idx].erpApplyAmt = data.applyAmt;
					conclusionbudgetList[idx].erpLeftAmt = data.erpLeftAmt;
					
					var reqAmt = parseInt(conclusionbudgetList[idx].amt.replace(/,/g, ''));
					
					if(reqAmt <= conclusionbudgetList[idx].balanceAmt){
						parameter.budgetAmt = reqAmt; /* [*]금액 */
						conclusionRemainAmt -= reqAmt;
					}else{
						parameter.budgetAmt = conclusionbudgetList[idx].balanceAmt; /* [*]금액 */
						
						conclusionRemainAmt -= conclusionbudgetList[idx].balanceAmt;
					}					
					
					parameter.erpOpenAmt = conclusionbudgetList[idx].erpOpenAmt;
					parameter.erpApplyAmt = conclusionbudgetList[idx].erpApplyAmt;
					parameter.erpLeftAmt = conclusionbudgetList[idx].erpLeftAmt;
				},
				/*   - error :  */
				error : function(result) {
					msgSnackbar("error", "예산정보 조회 중 오류 발생");
					return;
				}
			});				

			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/ex/np/user/cons/ConsBudgetInsert.do',
				datatype : 'json',
				async : false,
				data : Option.Common.GetSaveParam(parameter),
				extendParam : {
					consSeq : parameter.consSeq,
					budgetSeq : parameter.budgetSeq,
					budgetAmt : parameter.budgetAmt
				},

				success : function(result) {

					var aData = Option.Common.GetResult(result, 'aData');
					var resultCode = Option.Common.GetResultCode(result);

					if (resultCode === 'SUCCESS') {
						
						if(conclusionbudgetList.length-2 < idx){
							
							if(conclusionRemainAmt > 0){
								msgSnackbar("error", "품의금액이 예산잔액을 초과합니다.");
							}else{
								openWindow2("${pageContext.request.contextPath}/purchase/ApprCreate.do?outProcessCode="+outProcessCode+"&seq=${seq}",  "ApprCreatePop", 1000, 729, 1, 1) ;
								self.close();								
							}

						}
						
					} else if (resultCode === 'EXCEED') {
						msgSnackbar("error", "${CL.ex_exceedMesage}");
					} else {
						msgSnackbar("error", "품의서 연동데이터(ConsBudget) 생성 실패");
					}
				},
				error : function(result) {
					msgSnackbar("error", "품의서 연동데이터(ConsBudget) 생성 실패");
				}
			});

			return;
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
		<h1>제안서 평가위원회 개최</h1>
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
					<td colspan="3"><input ${disabled} onkeyup="chkChar(this)" objKey="meet_place" objCheckFor="checkVal('text', this, '평가회의 장소', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="${contractDetailInfo.meet_place}" /></td>
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
							<a href="#n" onclick="fnCommonCodeCustomPop('div', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="pjt_seq" type="hidden" value="" />
							<input tbval="Y" name="pjt_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />							

							<c:if test="${disabledYn == 'N'}">
							<a href="#n" onclick="fnCommonCodeCustomPop('project', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="bottom_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="bottom_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" requiredNot="true" readonly />							
							
							<c:if test="${disabledYn == 'N'}">
							<a href="#n" onclick="fnCommonCodeCustomPop('bottom', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
						
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
							
							<!-- <input tbval="Y" name="amt" type="hidden" value="" requiredNot="true" /> -->
							<input tbval="Y" name="txt_open_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_cons_balance_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_apply_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_pay_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_balance_amt" type="hidden" value="" requiredNot="true" />
							

							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCodeCustomPop('budgetlist', this)" class="btn_search" style="margin-left: -25px;"></a>
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
							<a href="#n" onclick="fnCommonCodeCustomPop('div', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="pjt_seq" type="hidden" value="" />
							<input tbval="Y" name="pjt_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />							
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCodeCustomPop('project', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="bottom_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="bottom_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" requiredNot="true" readonly />							
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCodeCustomPop('bottom', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
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
							<input tbval="Y" name="txt_pay_amt" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="txt_balance_amt" type="hidden" value="" requiredNot="true" />
							
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" ${disabled} onclick="fnCommonCodeCustomPop('budgetlist', this)" class="btn_search" style="margin-left: -25px;"></a>
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
			<table  name="amtgetList">
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
					<td id="bgt1Name" objCheckFor="checkVal('text()', this, '관', '', '')"></td>
					<th>항</th>
					<td id="bgt2Name" objCheckFor="checkVal('text()', this, '항', '', '')"></td>
					<th>목</th>
					<td id="bgt3Name" objCheckFor="checkVal('text()', this, '목', '', '')"></td>
					<th>세</th>
					<td id="bgt4Name" objCheckFor="checkVal('text()', this, '세', '', '')"></td>
				</tr>				
				<tr>
					<th>예산액</th>
					<td class="ri pr10" id="txtOpenAmt"></td>
					<th>집행액</th>
					<td class="ri pr10" id="txtConsBalanceAmt"></td>
					<th>품의액</th>
					<td class="ri pr10" id="txtApplyAmt"></td>
					<th>예산잔액</th>
					<td class="ri pr10" id="txtBalanceAmt"></td>
				</tr>
			</table>
		</div>				
		
		<!-- 그리드 테이블 -->
		<!-- <div class="com_ta6 mt10"> -->
		<div id="resultAmtListHtmlre" name="resultAmtListHtmlre" class="com_ta6 mt10" style="display:none;">
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
		
	</div>




</div><!-- //pop_wrap -->

</body>
</html>