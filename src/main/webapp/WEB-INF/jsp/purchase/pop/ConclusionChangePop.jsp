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
    <title>변경계약체결</title>

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
    <script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>  


	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/UserOptionMap.jsp" flush="false" />	
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/NpUserResPop.jsp" flush="false" /> 


	<script type="text/javascript">
	
	/* 예산관련 변수 시작 */
	var consDocSeq = "";
	var consSeq = "";
	var thisSeq = "${seq}";
	
	var eaBaseInfo = ${eaBaseInfo};
	var commonParam = {};
	var commonElement;		
	var saveData; 

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
	/* 예산관련 변수 끝 */
	
	
	
	
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
			
			<c:if test="${contractDetailInfo.contract_term == '02'}">
			$("[name=contractTerm_02]").show();
			</c:if>			
			
			//기존설정항목 세팅
			setDynamicPuddInfoTableBefore("amtInfoListBefore1", "dataBase", "${contractDetailInfo.contract_amt_info}");
			setDynamicPuddInfoTableBefore("amtInfoListBefore2", "dataBase", "${contractDetailInfo.contract_amt_info}");
			
			setCommonOption();
			setDynamicSetInfoBudget1();
			setDynamicSetInfoBudget();
			setDynamicSetInfoAmt();
			
			<c:if test="${viewType == 'U'}">
			setDynamicPuddInfo("change_item_info", "checkbox", "${contractDetailInfo.change_item_info}");
			setDynamicPuddInfoTable("amtInfoList", "amtInfoAddBase", "${contractDetailInfo.contract_amt_info_after}");
			</c:if>		
			
			amountInputSet();
			
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
		
 			$("#resultAmtListHtml tbody").empty();
 			$.each($("table[name='budgetList'] tr[name='addData']"), function(index, tr){			
 				var $clone = $("#resultAmtListHtml tfoot tr").clone();
 				var tr_amt = $(tr).find("input[name='amt']").val();
 				var t_amt = parseInt(tr_amt.replace(/,/g, ''));
 				var balance_amt = $(tr).find("input[name='txt_balance_amt']").val();
 				var t_balance_amt = parseInt(balance_amt.replace(/,/g, ''));
 				var txtbgtBalanceAmt1 = t_balance_amt - t_amt; 
 				$clone.find("td.bgtAmtnum").html("<span style='font-family:굴림;font-size:10px'>" + parseInt(index + 1) + "</span>");
 				$clone.find("td.bgtAmt1Name").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='pjt_name']").val() + "</span>");
 				$clone.find("td.bgtAmt2Name").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='erp_bgt2_name']").val() + "</span>");
 				$clone.find("td.bgtAmt3Name").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='erp_bgt3_name']").val() + "</span>");
 				$clone.find("td.txtbgtAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_open_amt']").val() + "</span>"); 
 				$clone.find("td.txtbgtOpenAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_cons_balance_amt']").val() + "</span>");
 				$clone.find("td.txtbgtConsBalanceAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_apply_amt']").val() + "</span>");
 				$clone.find("td.txtbgtApplyAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='amt']").val() + "</span>"); 
 				/* $clone.find("td.txtbgtApplyAmt").html("<span style='font-family:굴림;font-size:10px'>" + $(tr).find("input[name='txt_pay_amt']").val() + "</span>"); */
 				$clone.find("td.txtbgtBalanceAmt").html("<span style='font-family:굴림;font-size:10px'>" + fnGetCurrencyCode(txtbgtBalanceAmt1) + "</span>");
 				$("#resultAmtListHtml tbody").append($clone);
 			});
 			
		}
		
		
		function setDynamicSetInfoBudget1(targetName, value){
			
			<c:if test="${budgetList1.size() > 0 }">
			/* $("[name=budgetList] [name=addData]").remove(); */
			var cloneData;
			var cloneData1;
			var cloneData2;
			
			<c:forEach var="items" items="${budgetList1}" varStatus="status">
			
			cloneData = $('[name="ch_budgetList"] [name=ch_dataBase]').clone();
			cloneData1 = $('[name="ch_amtgetList"] [name=ch_amtBase1]').clone();
			cloneData2 = $('[name="ch_amtgetList"] [name=ch_amtBase2]').clone();
			
			$(cloneData).show().attr("name", "ch_addData");
			$(cloneData1).show().attr("name", "ch_addData");
			$(cloneData2).show().attr("name", "ch_addData");
			
			$(cloneData).find("[name=ch_erp_budget_div_name]").val("${items.erp_budget_div_name}");
			$(cloneData).find("[name=ch_pjt_name]").val("${items.pjt_name}");
			$(cloneData).find("[name=ch_bottom_name]").val("${items.bottom_name}");
			$(cloneData).find("[name=ch_erp_budget_name]").val("${items.erp_budget_name}");
			$(cloneData).find("[name=ch_amt]").val("${items.amt}");
			
			
			$(cloneData1).find("[name=ch_bgt1Name]").text("${items.erp_bgt1_name}");
			$(cloneData1).find("[name=ch_bgt2Name]").text("${items.erp_bgt2_name}");
			$(cloneData1).find("[name=ch_bgt3Name]").text("${items.erp_bgt3_name}");
			$(cloneData1).find("[name=ch_bgt4Name]").text("${items.erp_bgt4_name}");	
			
			
			$(cloneData2).find("[name=ch_txtOpenAmt]").text("${items.txt_open_amt}");
			$(cloneData2).find("[name=ch_txtConsBalanceAmt]").text("${items.txt_cons_balance_amt}");
			$(cloneData2).find("[name=ch_txtApplyAmt]").text("${items.txt_apply_amt}");
			$(cloneData2).find("[name=ch_txtBalanceAmt]").text("${items.txt_balance_amt}");
			
			$('[name="ch_amtgetList"]').append(cloneData1); 
		 	$('[name="ch_amtgetList"]').append(cloneData2);   
			$('[name="ch_budgetList"]').append(cloneData);
			 
			</c:forEach>			
			</c:if>
			
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
			$(cloneData).find("[name=pjt_at_tr_name]").val("${items.pjt_at_tr_name}");
			$(cloneData).find("[name=pjt_bank_number]").val("${items.pjt_bank_number}");
			
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
					$(commonElement).find("[name=pjt_at_tr_name]").val( param.atTrName || "" );
					$(commonElement).find("[name=pjt_bank_number]").val( param.bankNumber || "" );
					
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
					
					$(commonElement).find("[name=erp_budget_seq]").val( param.BGT_CD || "" );
					$(commonElement).find("[name=erp_budget_name]").val( param.BGT_NM || "" );
					
					if(param.erpBgt1Seq != ""){
						$(commonElement).find("[name=erp_bgt1_seq]").val( param.BGT01_CD );
						$(commonElement).find("[name=erp_bgt1_name]").val( param.BGT01_NM );	
					}else{
						$(commonElement).find("[name=erp_bgt1_seq]").val("");
						$(commonElement).find("[name=erp_bgt1_name]").val("");
					}
					
					if(param.erpBgt2Seq != ""){
						$(commonElement).find("[name=erp_bgt2_seq]").val( param.BGT02_CD );
						$(commonElement).find("[name=erp_bgt2_name]").val( param.BGT02_NM );	
					}else{
						$(commonElement).find("[name=erp_bgt1_seq]").val("");
						$(commonElement).find("[name=erp_bgt2_name]").val("");
					}
					
					if(param.erpBgt3Seq != ""){
						$(commonElement).find("[name=erp_bgt3_seq]").val( param.BGT03_CD );
						$(commonElement).find("[name=erp_bgt3_name]").val( param.BGT03_NM );	
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
						
						saveData = result.result.aData;
						$('#txtOpenAmt').text(fnGetCurrencyCode(saveData.openAmt));
						$('#txtConsBalanceAmt').text(fnGetCurrencyCode(saveData.consBalanceAmt));
						$('#txtApplyAmt').text(fnGetCurrencyCode(saveData.resApplyAmt));
						$('#txtBalanceAmt').text(fnGetCurrencyCode(saveData.balanceAmt));
						
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
		
		
		function fnSectorAdd1(tableName, maxCnt){
			
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
				
				
  				var changeAmtSpent = 0;
				var totalAmt = 0;
				var beforeAmt = 0;
				var beforeAmtSpent = "${contractDetailInfo.contract_amt_info}".split('▦');
				var budgetObjListSpent = new Array();
				budgetObjListSpent = insertDataObject.budgetObjList
				
 				if($("[name=amtInfoList] [name=addData] [amounttype=amt]").val() != "" && $("[name=amtInfoList] [name=addData] [amounttype=amt]").val() != "0"){
 					changeAmtSpent = parseInt($("[name=amtInfoList] [name=addData] [amounttype=amt]").val().replace(/,/g, ''));
				} 
				
				$.each($("[name=budgetList] [name=addData] [name=amt]"), function( idx, obj ) {
					if($(obj).val() != "" && $(obj).val() != "0"){
						totalAmt += parseInt($(obj).val().replace(/,/g, ''));
					}
				});	
					
				if (totalAmt > 0){
					beforeAmt = parseInt(beforeAmtSpent[1].replace(/,/g, '')); 
					if(totalAmt != beforeAmt){
						msgSnackbar("warning", "지출금액과 신청금액이 일치하지 않습니다.");
						return;
					} 
				}				
				
				for(var i = 0; i < budgetObjListSpent.length; i++){
					 var txt_pay_amt = parseInt((budgetObjListSpent[i].amt).replace(/,/g, ''));
					 var txt_balance_amt = parseInt((budgetObjListSpent[i].txt_balance_amt).replace(/,/g, ''));
					
					if (txt_pay_amt > txt_balance_amt){
						msgSnackbar("warning", "금액이 예산잔액을 초과합니다.");
						return;
					}
					
				}
				
				
				
				
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
					insertDataObject.contract_amt_after = "0";
					insertDataObject.contract_amt_kor_after = "";
				}else{
					insertDataObject.contract_amt_info_before = "${contractDetailInfo.contract_amt_info}";
					
					//계약총금액 조회
					insertDataObject.contract_amt_after = 0;
					
					$.each($("[name=amtInfoList] [name=addData] [amounttype=amt]"), function( key, objInfo ) {
						insertDataObject.contract_amt_after += parseInt($(objInfo).val().replace(/,/g, ''));
					});
					
					insertDataObject.contract_amt_kor_after = viewKorean(insertDataObject.contract_amt_after.toString());
					
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
			
			setDynamicSetInfoAmt();
			
			var budgetObjList = insertDataObject.budgetObjList;
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
			
			if(insertDataObject.budgetObjList.length < 1){
				
				insertDataObject.change_result_amt_info_html = "";
				
			} else {
				
				insertDataObject.change_result_amt_info_html = resultAmtListHtml;
				
			}
			
			
			
			
			
			
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
						
						openerRefreshList();
						
						if(type == 1){
										
							msgAlert("success", "임시저장이 완료되었습니다.", "self.close()");							
						}else{
							
							fnPaymentCreate();
							
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
							
/* 							if(conclusionRemainAmt > 0){
								msgSnackbar("error", "품의금액이 예산잔액을 초과합니다.");
							}else{
								openWindow2("${pageContext.request.contextPath}/purchase/ApprCreate.do?outProcessCode="+outProcessCode+"&seq=${seq}",  "ApprCreatePop", 1000, 729, 1, 1) ;
								self.close();								
							} */

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
		
		
		function fnCommonCode_trName1(code, e) {
			
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
		<h1>변경계약체결</h1>
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
					<input type="button" class="psh_btn" onclick="titleOnClickApp('${contractDetailInfo.appr_dikey_change}','','','','0','${contractDetailInfo.appr_status_change}')" value="품의서보기" /> 
					</c:if>
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
					<td>${contractDetailInfo.c_title} <c:if test="${contractDetailInfo.contract_no != ''}"> (계약번호 : ${contractDetailInfo.contract_no})</c:if></td>
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
					<td colspan="3"> 
					<textarea cols="170" rows="3" objKey="work_info_after" objCheckFor="checkVal('text', this, '과업변경', '$(\'[name=changeItem][value=01]:checked\').length > 0', '')" class="puddSetup" >${contractDetailInfo.work_info_after}</textarea>
					<%-- <input objKey="work_info_after" objCheckFor="checkVal('text', this, '과업변경', '$(\'[name=changeItem][value=01]:checked\').length > 0', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="${contractDetailInfo.work_info_after}" /> --%>
					</td>
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
				
				
				
				
			<tr name="changeItem_04" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦04▦') < 0 ) }">style="display:none;"</c:if>>
					<th>예산변경 (전)</th>
					<td colspan="3">	
			<!-- 예산정보 -->		
			<div class="com_ta4">
				<table name="ch_budgetList" objKey="ch_budgetObjList">
					<colgroup>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					<col width=""/>
					</colgroup>
				<tr>

					<th optionTarget="def_erp_budget_div_seq" class="ac">예산회계단위</th>
					<th class="ac">프로젝트</th>
					<th class="ac">하위사업</th>
					<th class="ac">예산과목</th>
					<th class="ac">금액</th>
				</tr>
				<tr name="ch_dataBase" style="display:none;">
					<td optionTarget="def_erp_budget_div_seq">
						<div class="posi_re">
							<input tbval="Y" name="ch_erp_budget_div_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />							
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="ch_pjt_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />													
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="ch_bottom_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" requiredNot="true" readonly />							
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="ch_erp_budget_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="ch_amt" type="text" pudd-style="width:calc( 90% );" class="puddSetup ar" value="" amountInput="Y" readonly/>							
						</div>
					</td>		
				</tr>						
			</table>
			
			<table name="ch_amtgetList">
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
				<tr name="ch_amtBase1" style="display:none;">
					<input id="ch_bgtSeq" type="hidden" value="" />
					<th>관</th>
					<td id="ch_bgt1Name" name="ch_bgt1Name"></td>
					<th>항</th>
					<td id="ch_bgt2Name" name="ch_bgt2Name"></td>
					<th>목</th>
					<td id="ch_bgt3Name" name="ch_bgt3Name"></td>
					<th>세</th>
					<td id="ch_bgt4Name" name="ch_bgt4Name"></td>
				</tr>				
				<tr name="ch_amtBase2" style="display:none;">
					<th>예산액</th>
					<td class="ri pr10" id="ch_txtOpenAmt" name="ch_txtOpenAmt"></td>
					<th>집행액</th>
					<td class="ri pr10" id="ch_txtConsBalanceAmt" name="ch_txtConsBalanceAmt"></td>
					<th>기품의액</th>
					<td class="ri pr10" id="ch_txtApplyAmt" name="ch_txtApplyAmt"></td>
					<th>예산잔액</th>
					<td class="ri pr10" id="ch_txtBalanceAmt" name="ch_txtBalanceAmt"></td>
				</tr>
			</table>	
		</div>				
		</td>
	</tr>
	
	
		<tr name="changeItem_04" <c:if test="${ viewType == 'I' || (viewType == 'U' && ('▦▦').concat(contractDetailInfo.change_item_info.concat('▦▦')).indexOf('▦▦04▦') < 0 ) }">style="display:none;"</c:if>>
					<th><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /> 예산변경 (후)</th>
					<td colspan="3">		
			<div class="com_ta4">
				<!-- <table name="budgetList" objKey="budgetObjList" objCheckFor="checkVal('obj', 'budgetList', '예산정보', 'mustAlert', '')"> -->
				<table name="budgetList" objKey="budgetObjList" objCheckFor="checkVal('obj', 'budgetList', '예산정보', '$(\'[name=changeItem][value=04]:checked\').length > 0','notnull')">
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
						<input type="button" onclick="fnSectorAdd1('budgetList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
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
							<a href="#n" onclick="fnCommonCode_trName1('div', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="pjt_seq" type="hidden" value="" />
							<input tbval="Y" name="pjt_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />
							<input tbval="Y" name="pjt_at_tr_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="pjt_bank_number" type="hidden" value="" requiredNot="true"/>															

							<c:if test="${disabledYn == 'N'}">
							<a href="#n" onclick="fnCommonCode_trName1('project', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="bottom_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="bottom_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" requiredNot="true" readonly />							
							
							<c:if test="${disabledYn == 'N'}">
							<a href="#n" onclick="fnCommonCode_trName1('bottom', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<!-- <input tbval="Y" name="amt" type="hidden" value="" requiredNot="true" /> -->
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
							<a href="#n" onclick="fnCommonCode_trName1('budgetlist', this)" class="btn_search" style="margin-left: -25px;"></a>
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
							<a href="#n" onclick="fnCommonCode_trName1('div', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="pjt_seq" type="hidden" value="" />
							<input tbval="Y" name="pjt_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" readonly />							
							<input tbval="Y" name="pjt_at_tr_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="pjt_bank_number" type="hidden" value="" requiredNot="true"/>	
														
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCode_trName1('project', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<input tbval="Y" name="bottom_seq" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="bottom_name" type="text" pudd-style="width:calc( 90% );" class="puddSetup pr30" value="" requiredNot="true" readonly />							
							
							<c:if test="${disabledYn == 'N'}"> 
							<a href="#n" onclick="fnCommonCode_trName1('bottom', this)" class="btn_search" style="margin-left: -25px;"></a>
							</c:if>
						</div>
					</td>
					<td>
						<div class="posi_re">
							<!-- <input tbval="Y" name="amt" type="hidden" value="0" requiredNot="true" /> -->
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
							<a href="#n" ${disabled} onclick="fnCommonCode_trName1('budgetlist', this)" class="btn_search" style="margin-left: -25px;"></a>
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
						<th>예산액</th>
						<td class="ri pr10" id="txtOpenAmt" name="txtOpenAmt"></td>
						<th>집행액</th>
						<td class="ri pr10" id="txtConsBalanceAmt" name="txtConsBalanceAmt"></td>
						<th>기품의액</th>
						<td class="ri pr10" id="txtApplyAmt" name="txtApplyAmt"></td>
						<th>예산잔액</th>
						<td class="ri pr10" id="txtBalanceAmt" name="txtBalanceAmt"></td>
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

</body>
</html>