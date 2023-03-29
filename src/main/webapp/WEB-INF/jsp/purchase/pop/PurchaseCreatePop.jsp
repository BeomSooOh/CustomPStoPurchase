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
    <title>구매품의 등록</title>

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
	var thisSeq = "${seq}";
	
	var eaBaseInfo = ${eaBaseInfo};
	var commonParam = {};
	var commonElement;
	
	commonParam.callback = 'fnCommonCode_callback';
	commonParam.widthSize = 780;
	commonParam.heightSize = 582;
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
	
	var outProcessCode = "Purchase01";
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

		$('[amountInput=Y]').maskMoney({
			precision : 0,
			allowNegative: false
		});			
		
		setDynamicPublicInfo("${purchaseDetailInfo.public_info}");
		
		//옵션값 설정
		setCommonOption();
		
		
		//기존설정항목 세팅
		<c:if test="${viewType == 'U'}">
		setDynamicPuddInfo("pay_type_info", "checkbox", "${purchaseDetailInfo.pay_type_info}");
		setDynamicPuddInfo("purchase_method", "radio", "${purchaseDetailInfo.purchase_method}");
		setDynamicSetInfoBudget();
		setDynamicSetInfoTrade();
		setDynamicSetInfoItem();
		</c:if>
		
		datePickerInit();

		
	});
	 
	
 	function chageYnSelect(obj){
					
		 if ($(obj).val() == "Y"){
			 
			 $(obj).closest("tr").find("[name=item_non_green_reason]").attr("disabled","disabled");
			 var change_reason =  $(obj).closest("tr").find("[name=item_non_green_reason]");			 			 		 
			 change_reason.find("option:selected").prop("selected", false);
			 change_reason.find("option:first").prop("selected", "selected");
			 
			 $(obj).closest("tr").find("[name=item_green_cert_type_btn]").show(); 

		 } else {
			 
			 $(obj).closest("tr").find("[name=item_non_green_reason]").removeAttr("disabled");
			 
			 /* $(obj).closest("tr").find("[name=item_green_cert_type_btn]").hide();
			 $(obj).closest("tr").find("[name=item_green_cert_type]").find('li').empty(); 
 
			 
		  	 $(obj).closest("tr").find("[name=item_green_cert_type]").find("[name=xtest]").empty();
			 $(obj).closest("tr").find("[name=item_green_cert_type]").find("[name=addName]").empty(); */ 
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
	
	
	function setDynamicSetInfoItem(){
		
		<c:if test="${itemList.size() > 0 }">
		$("[name=itemList] tr[name=addData]").remove();
		
		var cloneData;
		<c:forEach var="items" items="${itemList}" varStatus="status">
		
		cloneData = $('[name="itemList"] tr[name=dataBase]').clone();
		$(cloneData).show().attr("name", "addData");
		$(cloneData).find("[name=item_tr_seq]").val("${items.item_tr_seq}");
		$(cloneData).find("[name=item_div_no]").val("${items.item_div_no}");
		$(cloneData).find("[name=item_idn_no]").val("${items.item_idn_no}");
		$(cloneData).find("[name=item_name]").val("${items.item_name}");
		$(cloneData).find("[name=item_amt]").val("${items.item_amt}");
		$(cloneData).find("[name=item_cnt]").val("${items.item_cnt}");
		$(cloneData).find("[name=item_total_amt_text]").text("${items.item_total_amt_text}");
		$(cloneData).find("[name=item_total_amt]").val("${items.item_total_amt}");
		$(cloneData).find("[name=item_sub_total_amt_text]").text("${items.item_sub_total_amt_text}");
		$(cloneData).find("[name=item_sub_total_amt]").val("${items.item_fee_total_amt}");		
		$(cloneData).find("[name=item_unit]").val("${items.item_unit}");
		$(cloneData).find("[name=item_pickup_location]").val("${items.item_pickup_location}");
		$(cloneData).find("[name=item_fee_amt]").val("${items.item_fee_amt}");
		$(cloneData).find("[name=item_inventory_cd]").val("${items.item_inventory_cd}");
		$(cloneData).find("[name=item_use_location]").val("${items.item_use_location}");
		$(cloneData).find("[name=item_foreign_type]").val("${items.item_foreign_type}");
		$(cloneData).find("[name=item_contry]").val("${items.item_contry}");
		$(cloneData).find("[name=item_acquisition_reason]").val("${items.item_acquisition_reason}");
		/* $(cloneData).find("[name=item_green_cert_type]").val("${items.item_green_cert_type}"); */
		$(cloneData).find("[name=item_non_green_reason]").val("${items.item_non_green_reason}");
		$(cloneData).find("[name=item_green_class]").val("${items.item_green_class}");
		$(cloneData).find("[name=item_green_cert_yn]").val("${items.item_green_cert_yn}");
		
		$(cloneData).find("[name=item_deadline]").val("${items.item_deadline}");
		
		
		
		if("${items.item_green_cert_type}" != ""){
			
			commonCodeTargetInfo = [];
			
			$.each("${items.item_green_cert_type}".split("▦▦"), function( key, val ) {
				var valInfo =  val.split("▦");
				var objInfo = {};
				objInfo.code = valInfo[0];
				objInfo.name = valInfo[1];
				commonCodeTargetInfo.push(objInfo);
				
			});	
			
			commonCodeCallback("ul", $(cloneData).find("[name=green_certifi_info_td]"), commonCodeTargetInfo);
		}
		
		
		
		$('[name="itemList"]').append(cloneData);
		
		chageYnSelect($(cloneData).find("[name=item_green_cert_yn]"));
		
		</c:forEach>			
		</c:if>			
		
	}		
	
	
	function setDynamicSetInfoTrade(){
		
		<c:if test="${tradeList.size() > 0 }">
		$("[name=tradeList] tr[name=addData]").remove();
		
		var cloneData;
		<c:forEach var="items" items="${tradeList}" varStatus="status">
		
		cloneData = $('[name="tradeList"] tr[name=dataBase]').clone();
		$(cloneData).show().attr("name", "addData");
		
		$(cloneData).find("[name=tr_seq]").val("${items.tr_seq}");
		$(cloneData).find("[name=tr_name]").val("${items.tr_name}");
		
		$(cloneData).find("[name=tr_reg_number]").text("${items.tr_reg_number}");
		$(cloneData).find("[name=ceo_name]").text("${items.ceo_name}");
		$(cloneData).find("[name=addr]").text("${items.addr}");
		
		$(cloneData).find("[name=at_tr_name]").val("${items.at_tr_name}");
		$(cloneData).find("[name=ba_nb]").val("${items.ba_nb}");
		$(cloneData).find("[name=btr_name]").val("${items.btr_name}");
		$(cloneData).find("[name=btr_seq]").val("${items.btr_seq}");
		$(cloneData).find("[name=depositor]").val("${items.depositor}");
		$(cloneData).find("[name=tr_fg]").val("${items.tr_fg}");
		$(cloneData).find("[name=tr_fg_name]").val("${items.tr_fg_name}");
		

		
		if("${items.hope_company_info}" != ""){
			
			commonCodeTargetInfo = [];
			
			$.each("${items.hope_company_info}".split("▦▦"), function( key, val ) {
				var valInfo =  val.split("▦");
				var objInfo = {};
				objInfo.code = valInfo[0];
				objInfo.name = valInfo[1];
				commonCodeTargetInfo.push(objInfo);
				
			});	
			
			commonCodeCallback("ul", $(cloneData).find("[name=hope_company_info_td]"), commonCodeTargetInfo);
		}
		
		if("${items.hope_attach_info}" != ""){
			
			$.each("${items.hope_attach_info}".split("▦▦"), function( key, val ) {
				
				var valInfo =  val.split("▦");
				
				var fileCloneData = $(cloneData).find("[name=hope_attach_info] [name=attachBase]").clone();
				$(fileCloneData).show().attr("name", "addFile");
				$(fileCloneData).find('[name="attachFileName"]').attr("fileid", valInfo[0]);
				$(fileCloneData).find('[name="attachFileName"]').text(valInfo[1]);
				$(fileCloneData).find('[name="attachExtName"]').text(valInfo[2]);	
				
				$(cloneData).find("[name=hope_attach_info]").append(fileCloneData);						
			});				
		}		
		
		
		$('[name="tradeList"]').append(cloneData);
		
		</c:forEach>			
		</c:if>			
		
		itemTradeReset();
		
	}	
	
	function setDynamicSetInfoBudget(){
		
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
		
		$('[name="budgetList"]').append(cloneData);
		
		if(${status.index} == 0){
			fnSetBudgetAmtInfo(cloneData);	
		}
		
		</c:forEach>			
		</c:if>			
		
	}		
	
	function setCommonOption(){
		
		$.datepicker.setDefaults({
			  dateFormat: 'yy-mm-dd',
			  prevText: '이전 달',
			  nextText: '다음 달',
			  monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			  monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			  dayNames: ['일', '월', '화', '수', '목', '금', '토'],
			  dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
			  dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			  showMonthAfterYear: true,
			  yearSuffix: '년'
		});		
		
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
	
	function datePickerInit(){
		$("[name=addData] [name=item_deadline]").datepicker();
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
	
	
	function fnSectorAdd(tableName, maxCnt){
		
		var aaDataCnt = $('[name="'+tableName+'"] tr[name=addData]').length + 1;
		
		if(maxCnt != null && aaDataCnt > maxCnt){
			msgSnackbar("warning", "등록 가능한 개수를 초과했습니다.");
			return;
		}			
		
		var cloneData = $('[name="'+tableName+'"] tr[name=dataBase]').clone();
		$(cloneData).show().attr("name", "addData");
		
		$('[name="'+tableName+'"]').append(cloneData);
		
		amountInputSet();
		
		if(tableName == "itemList"){
			datePickerInit();
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
	

	function openerRefreshList(){
		if(opener != null && typeof opener.BindGrid != "undefined"){
			opener.BindGrid();
		}	
	}
	
	function fnSectorDel(e, tableName){
		
		if(tableName != null && $('[name="'+tableName+'"] tr[name=addData]').length == 1){
			return;
		}
		
		$(e).closest("tr").remove();
		
		if(tableName == "tradeList"){
			itemTradeReset();	
		}
		
	}		
	
	function fnCommonCodeCustomPop(code, e) {
		
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
				
				$(commonElement).find("[name=tr_reg_number]").text( param.trRegNumber || "" );
				$(commonElement).find("[name=ceo_name]").text( param.ceoName || "" );
				$(commonElement).find("[name=addr]").text( param.addr || "" );
				
				$(commonElement).find("[name=at_tr_name]").val( param.atTrName || "" );
				$(commonElement).find("[name=ba_nb]").val( param.baNb || "" );
				$(commonElement).find("[name=btr_name]").val( param.btrName || "" );
				$(commonElement).find("[name=btr_seq]").val( param.btrSeq || "" );
				$(commonElement).find("[name=depositor]").val( param.depositor || "" );
				$(commonElement).find("[name=tr_fg]").val( param.trFg || "" );
				$(commonElement).find("[name=tr_fg_name]").val( param.trFgName || "" );
				
				itemTradeReset();	
			
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
			
			if(!calAmt && $(commonElement).find("[name=txt_open_amt]").val() != ""){
				$('#txtOpenAmt').text($(commonElement).find("[name=txt_open_amt]").val());
				$('#txtConsBalanceAmt').text($(commonElement).find("[name=txt_cons_balance_amt]").val());
				$('#txtApplyAmt').text($(commonElement).find("[name=txt_apply_amt]").val());
				$('#txtBalanceAmt').text($(commonElement).find("[name=txt_balance_amt]").val());
				return;
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
							
							var itemAmtTotal = 0;
							var totalAmt = 0;
							var remainAmt = 0;
							
							$.each($("[name=itemList] [name=addData] [name=item_total_amt]"), function( idx, obj ) {
								if($(obj).val() != "" && $(obj).val() != "0"){
									itemAmtTotal += parseInt($(obj).val().replace(/,/g, ''));
								}
							});								
							
							$.each($("[name=addData] [name=amt]"), function( idx, obj ) {
								if($(obj).val() != "" && $(obj).val() != "0"){
									totalAmt += parseInt($(obj).val().replace(/,/g, ''));
								}
							});								
							
							remainAmt = itemAmtTotal - totalAmt;
							
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
	
	
	function commonCodeSelectLayer(group, title, type, target, multiYn){

		Pudd.puddDialog({
		 
			width : type == "shopping" ? 1150 : 400
		,	height : type == "shopping" ? 400 : 500
		 
		,	modal : true			// 기본값 true
		,	draggable : false		// 기본값 true
		,	resize : false			// 기본값 false
		 
		,	header : {
	 		title : title
		,	closeButton : type == "shopping" ? true : false
		,	closeCallback : function( puddDlg ) {
				// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
				// 추가적인 작업 내용이 있는 경우 이곳에서 처리
			}
		}
		
		,	body : {
		 
				iframe : true
			,	url : "${pageContext.request.contextPath}/purchase/layer/" + (type == "shopping" ? "SelectShoppingListLayer" : "CodeSelectLayer") + ".do?inqryBgnDate=${fromDate}&inqryEndDate=${toDate}&multiYn=" + multiYn + "&group=" + group
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
						commonCodeCallback(type, target, iframeTag.contentWindow.fnGetSelectedList());
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
	
	function commonCodeCallback(type, target, selectedList){
		
		if(type == "ul"){
			$(target).find('[name=addData]').remove();
			$.each(selectedList, function( idx, addData ) {
				var cloneData = $(target).find('[name=dataBase]').clone();
				$(cloneData).show().attr("name", "addData");
				$(cloneData).attr("addCode", addData.code);
				$(cloneData).find("[name=addName]").text(addData.name);
				$(target).find('ul').append(cloneData);				
			});									
		}else if(type == "shopping"){
			
			/*
			prdctClsfcNo : 물품분류번호 item_div_no
			prdctIdntNo : 물품식별번호 item_idn_no
			prdctClsfcNoNm : 품명 item_name
			prdctUnit : 물품단위
			cntrctPrceAmt : 계약가격금액 item_amt
			dlvrTmlmtDaynum : 납품기한일수
			*/
			
			if(selectedList.length > 0){
				$(target).find("[name=item_div_no]").val(selectedList[0].prdctClsfcNo);
				$(target).find("[name=item_idn_no]").val(selectedList[0].prdctIdntNo);
				$(target).find("[name=item_name]").val(selectedList[0].prdctClsfcNoNm);
				$(target).find("[name=item_amt]").val(selectedList[0].cntrctPrceAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ","));
				$(target).find("[name=item_cnt]").val("1");
				
				$(target).find("[name=item_total_amt_text]").text(selectedList[0].cntrctPrceAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원");
				$(target).find("[name=item_sub_total_amt_text]").text(selectedList[0].cntrctPrceAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원");
				$(target).find("[name=item_total_amt]").val(selectedList[0].cntrctPrceAmt);
				$(target).find("[name=item_sub_total_amt]").val(selectedList[0].cntrctPrceAmt);
				
				$(target).find("[name=item_unit]").val(selectedList[0].prdctUnit);
			}
			
		}else if(type == "text"){

			if(selectedList.length > 0){
				$(target).find("[codetarget]").val(selectedList[0].name);
			}
			
		}
	}	
	
	function fnCalculateTotal(el){

		var item_amt = $(el).find("[name=item_amt]").val() == "" ? "0" : $(el).find("[name=item_amt]").val().replace(/,/g, '');
		var item_cnt = $(el).find("[name=item_cnt]").val() == "" ? "0" : $(el).find("[name=item_cnt]").val();
		var item_fee_amt = $(el).find("[name=item_fee_amt]").val() == "" ? "0" : $(el).find("[name=item_fee_amt]").val().replace(/,/g, '');
		
		$(el).find("[name=item_total_amt_text]").text(((parseInt(item_amt)*parseInt(item_cnt)) + parseInt(item_fee_amt)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원");
		$(el).find("[name=item_total_amt]").val((parseInt(item_amt)*parseInt(item_cnt)) + parseInt(item_fee_amt));
		
		$(el).find("[name=item_sub_total_amt_text]").text((parseInt(item_amt)*parseInt(item_cnt)).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원");
		$(el).find("[name=item_sub_total_amt]").val((parseInt(item_amt)*parseInt(item_cnt)));		
	}
	
	function fnSearchFile(e){
		targetElement = $(e).find('[name="hope_attach_info"]');
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
		
		//수정일 경우 즉시 업데이트
		<c:if test="${viewType == 'U'}">
		insertDataObject.attch_file_info = JSON.stringify(attachFormList);
		insertDataObject.outProcessCode = outProcessCode;
		insertDataObject.seq = thisSeq;
		
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
			insertDataObject.trade_list_info = JSON.stringify(insertDataObject.tradeObjList);
			insertDataObject.item_list_info = JSON.stringify(insertDataObject.itemObjList);
			insertDataObject.budget_list_info = JSON.stringify(insertDataObject.budgetObjList);
			
			//중복물품체크
			var checkFlag = false;
			var itemIdnNo = [];
			$.each($("[name=itemList] [name=addData] [name=item_idn_no]"), function( idx, obj ) {
				if(!itemIdnNo.includes($(obj).val())){
					itemIdnNo.push($(obj).val());
				}else{
					checkFlag = true;
				}
			});
			
			if(checkFlag){
				msgSnackbar("error", "동일물품 중복선택");
				return;
			}
			
			//신청금액 체크
			var itemAmtTotal = 0;
			var totalAmt = 0;
			var remainAmt = 0;
			
			$.each($("[name=itemList] [name=addData] [name=item_total_amt]"), function( idx, obj ) {
				if($(obj).val() != "" && $(obj).val() != "0"){
					itemAmtTotal += parseInt($(obj).val().replace(/,/g, ''));
				}
			});	
			
			$.each($("[name=addData] [name=amt]"), function( idx, obj ) {
				if($(obj).val() != "" && $(obj).val() != "0"){
					totalAmt += parseInt($(obj).val().replace(/,/g, ''));
				}
			});								
			
			if(itemAmtTotal != totalAmt){
				msgSnackbar("warning", "물품금액과 품의금액이 일치하지 않습니다.");
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
		insertDataObject.viewType = "${viewType}";
		insertDataObject.seq = thisSeq;
		
		var itemAmtTotal = 0;
		var itemFeeTotal = 0;
		
		$.each($("[name=itemList] [name=addData] [name=item_total_amt]"), function( idx, obj ) {
			if($(obj).val() != "" && $(obj).val() != "0"){
				itemAmtTotal += parseInt($(obj).val().replace(/,/g, ''));
			}
		});			
		
		insertDataObject.purchase_amt = itemAmtTotal;
		insertDataObject.purchase_amt_kor = viewKorean(itemAmtTotal.toString());
		
		$.each($("[name=itemList] [name=addData] [name=item_fee_amt]"), function( idx, obj ) {
			if($(obj).val() != "" && $(obj).val() != "0"){
				itemFeeTotal += parseInt($(obj).val().replace(/,/g, ''));
			}
		});					
		
		//품품정보 html
		$('[name=itemObjListHtml]').find("[displaynone]").removeAttr("displaynone");
		$('[name=itemObjListHtml]').find(":hidden").attr("displaynone", "Y");
		
		//Clone객체 select checked option 정보 누락 현상관련 temp Attr에 임시저장/활용
		$.each($('[name=itemList]').find("select"), function( idx, obj ) {
			$(obj).attr("htmlTempVal", $(obj).find("option:checked").text());
		});			
		
		var cloneData = $('[name=itemObjListHtml]').clone();
		
		$(cloneData).find("[name=itemList]").append("<tr><td bgcolor='#f1f1f1' colspan='4'>조달구매수수료/이용수수료(단가계약, 계약금액의 000%)</td><td colspan='2'>"+itemFeeTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+" 원</td></tr>");
		$(cloneData).find("[name=itemList]").append("<tr><td bgcolor='#f1f1f1' colspan='4'>총계 (VAT 포함 )</td><td colspan='2'>"+itemAmtTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+" 원</td></tr>");
		
		$(cloneData).find("[displaynone]").remove();
		$(cloneData).find("[removehtml=Y]").remove();
		$(cloneData).find("[name=dataBase]").remove();
		
		$(cloneData).find("[name=itemList]").attr("border", "1").attr("width", "100%").css("width", "100%");
		$(cloneData).find("th").attr("align", "center").attr("bgcolor", "#f1f1f1").attr("height", "25");
		$(cloneData).find("td").attr("align", "center").attr("height", "20");
		$(cloneData).find("[name]").removeAttr("name");
		$(cloneData).find("[objcheckfor]").removeAttr("objcheckfor");
		
		//개별 align 적용
		$.each($(cloneData).find("[htmlalign]"), function( idx, obj ) {
			$(obj).attr("align", $(obj).attr("htmlalign"));
		});		
		
		$.each($(cloneData).find("[colspanHtml]"), function( idx, obj ) {
			$(obj).attr("colspan", $(obj).attr("colspanHtml"));
		});
		
		//input 요소 텍스트화
		$.each($(cloneData).find("input"), function( idx, obj ) {
			$(obj).replaceWith($(obj).val());
		});	
		
		$.each($(cloneData).find("select"), function( idx, obj ) {
			$(obj).replaceWith($(obj).attr("htmlTempVal"));
		});
		
		insertDataObject.item_info_html = $(cloneData)[0].outerHTML;		
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/PurchaseSaveProc.do" />',
    		datatype:"json",
            data: insertDataObject ,
			async : true,
			success : function(result) {
				
				if(result.resultCode == "success"){
					
					thisSeq = result.resultData.seq;
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
	
	
	function fnNoticePop(formCode, noticeName){
		
		Pudd.puddDialog({
			width : 800
		,	height : 500
		,	modal : true			// 기본값 true
		,	draggable : false		// 기본값 true
		,	resize : false			// 기본값 false
		,	header : {
	 		title : noticeName
		,	closeButton : true	// 기본값 true
		}
		,	body : {
				iframe : true
			,	url : "${pageContext.request.contextPath}/purchase/layer/NoticePopLayer.do?formCode=" + formCode
			,	iframeAttribute : {
				id : "dlgFrame"
			}						
		}
		});			
	}
	
	
	function getPublicInfo(){
		
		var selectedItems = "";
		 
		$.each(Pudd( "#publicInfo" ).getPuddObject().getData(), function( key, val ) {
			selectedItems += (key == 0 ? "" : "▦▦") + val.value + "▦" + val.text;
		});		
		
		return selectedItems;
		 
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
			,	backspaceDelete : false
		 });

	}	
	
	var conclusionbudgetList = [];
	var conclusionRemainAmt = 0;			
	
	function fnPaymentCreate(){

		//기존 품의(임시)데이터 삭제
		parameter = {};
		parameter.out_process_interface_id = outProcessCode;
		parameter.out_process_interface_m_id = thisSeq;
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
					conclusionRemainAmt = insertDataObject.purchase_amt;
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
		parameter.outProcessInterfaceMId = thisSeq;
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
							openWindow2("${pageContext.request.contextPath}/purchase/ApprCreate.do?outProcessCode="+outProcessCode+"&seq=" + thisSeq,  "ApprCreatePop", 1000, 729, 1, 1) ;
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
	
	function itemTradeReset(){
		
		$("[name=itemList] [name=item_tr_seq] option").remove();
		
		$("[name=itemList] [name=item_tr_seq]").append("<option value=''>--</option>");
		
		$.each($("[name=tradeList] tr[name=addData]"), function( key, obj ) {
			
			if($(obj).find("[name=tr_seq]").val() != ""){
				$("[name=itemList] [name=item_tr_seq]").append("<option value='"+$(obj).find("[name=tr_seq]").val()+"'>"+$(obj).find("[name=tr_name]").val()+"</option>");
			}
			
		});			
		
	}
	
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;"> <!-- 팝업창사이즈 가로 : 1000px -->
	<div class="pop_sign_head posi_re">
		<h1>구매품의 등록</h1>
		<div class="psh_btnbox">
			<div class="psh_right">
				<div class="btn_cen mt8">
				
					<c:if test="${btnAdminEditYn == 'Y'}">
					<input type="button" class="psh_btn" onclick="fnCallBtn('save')" value="저장" />
					</c:if>
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
				<dd objKey="write_dt" objCheckFor="checkVal('date', 'writeDt', '작성일자', 'selectDate(this)', '')" ><input ${disabled} name="writeDt" type="text" value="${write_dt}" class="puddSetup" pudd-type="datepicker"/></dd>
				
				<input objKey="write_comp_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${write_comp_seq}" />
				<input objKey="write_dept_seq" objCheckFor="checkVal('text', this, '작성부서', '', '')" type="hidden" value="${write_dept_seq}" />
				<input objKey="write_emp_seq" objCheckFor="checkVal('text', this, '작성자', 'selectOrgchart()', '')" type="hidden" value="${write_emp_seq}" />
				
			</dl>
		</div>

		<!-- 테이블 -->
		<div class="com_ta mt10">
			<table>
				<colgroup>
					<col width="130"/>
					<col width="450"/>
					<col width="130"/>
					<col width="369"/>
					
				</colgroup>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 유형선택</th>
					<td objKey="purchase_type" objCheckFor="checkVal('radio', 'purchaseType', '유형선택', '', '')" >
						<input ${disabled} onclick="fnNoticePop('ManualPop00', '비품(정수관리대상)')" type="radio" name="purchaseType" class="puddSetup" pudd-label="비품(정수관리대상)" value="00" <c:if test="${ (viewType == 'I') || (viewType == 'U' && purchaseDetailInfo.purchase_type == '00') }">checked</c:if> />
						<input ${disabled} onclick="fnNoticePop('ManualPop01', '비품(정수관리비대상)')" type="radio" name="purchaseType" class="puddSetup" pudd-label="비품(정수관리비대상)" value="01" <c:if test="${ viewType == 'U' && purchaseDetailInfo.purchase_type == '01' }">checked</c:if> />
						<input ${disabled} onclick="fnNoticePop('ManualPop02', '소모품')" type="radio" name="purchaseType" class="puddSetup" pudd-label="소모품" value="02" <c:if test="${ viewType == 'U' && purchaseDetailInfo.purchase_type == '02' }">checked</c:if> />
						<input ${disabled} onclick="fnNoticePop('ManualPop03', '소프트웨어')" type="radio" name="purchaseType" class="puddSetup" pudd-label="소프트웨어" value="03" <c:if test="${ viewType == 'U' && purchaseDetailInfo.purchase_type == '03' }">checked</c:if> />
					</td>	
					<th>담당자</th>
					<td objKey="public_info" objCheckFor="getPublicInfo()" >
						<div id="publicInfo" style="min-width:200px;"></div>
						<c:if test="${disabledYn == 'N'}">
						<input onclick="selectOrgchart()" type="button" value="선택" />
						</c:if>	
					</td>					
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 문서제목</th>
					<td colspan="3"><input ${disabled} objKey="title" objCheckFor="checkVal('text', this, '문서제목', 'mustAlert', '')" type="text" pudd-style="width:100%;" class="puddSetup" value="<c:if test="${ viewType == 'U' }">${purchaseDetailInfo.title}</c:if>" /></td>
				</tr>
				<tr>
					<th><img src="<c:url value='/customStyle/Images/ico/ico_check01.png' />" alt="" /> 구매방법</th>
					<td objKey="purchase_method" objCheckFor="checkVal('radio', 'purchaseMethod', '구매방법', '', '|etc|')">
						<c:forEach var="items" items="${purchaseMethod}" varStatus="status">
							<c:choose>
								<c:when test="${items.CODE == 'etc'}">
									<input ${disabled} type="radio" onclick="fnChangeEtc(this)" name="purchaseMethod" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" />	
									<input ${disabled} type="text" name="purchaseMethod_${items.CODE}" pudd-style="width:150px;" class="puddSetup" value="" style="display:none;" />								
								</c:when>								
								<c:otherwise>
									<input ${disabled} type="radio" onclick="fnChangeEtc(this)" name="purchaseMethod" class="puddSetup" pudd-label="${items.NAME}" value="${items.CODE}" <c:if test="${status.index == 0}">checked</c:if> />
								</c:otherwise>
							</c:choose>
						</c:forEach>					
					</td>
					<th>결제방법</th>
					<td objKey="pay_type_info" objCheckFor="checkVal('checkbox', 'payType', '결제방법', 'mustAlert', '|etc|')" >
						<c:forEach var="items" items="${payTypeCode}">
							<c:choose>
								<c:when test="${items.CODE == 'etc'}">
									<input ${disabled} type="checkbox" onclick="fnChangeEtc(this)" name="payType"  value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
									<input ${disabled} type="text" style="display:none;" name="payType_${items.CODE}" pudd-style="width:150px;" class="puddSetup" value="" />
								</c:when>
								<c:otherwise>
									<input ${disabled} type="checkbox" name="payType"  value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}" />
								</c:otherwise>
							</c:choose>						
						</c:forEach>						
					</td>
				</tr>
				<tr>
					<th>공급업체</th>
					<td colspan="3">
					
						<div class="fr mt10 mb10">
							<span class="fl mr20">※ 희망기업 정보조회</span>
							<div class="fl">
								<span class="pr10"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="15px" height="15px"><a href="#n" onclick="window.open('https://www.coop.go.kr','mgjCode','width=1050, height=670, scrollbars=yes');"> 협동조합</a></span>
								<span class="pr10"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="15px" height="15px"><a href="#n" onclick="window.open('https://www.smpp.go.kr','mgjCode','width=1050, height=670, scrollbars=yes');"> 중소기업중앙회</a></span>
								<span class="pr10"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="15px" height="15px"><a href="#n" onclick="window.open('https://www.socialenterprise.or.kr','mgjCode','width=1050, height=670, scrollbars=yes');"> 사회적기업진흥원</a></span>
							</div>
						</div>					
					
						<div class="com_ta mt10">
							<table name="tradeList" objKey="tradeObjList" objCheckFor="checkVal('obj', 'tradeList', '공급업체', 'mustAlert', '')">
								<colgroup>
									<c:if test="${disabledYn == 'N'}"> 
									<col width="50"/>
									</c:if>				
									<col width="200"/>
									<col width="150"/>
									<col width="250"/>
									<col width=""/>
								</colgroup>
								<tr>
									<c:if test="${disabledYn == 'N'}"> 
									<th class="cen">
										<input type="button" onclick="fnSectorAdd('tradeList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
									</th>
									</c:if>				
									<th class="cen">사업자명</th>
									<th class="cen">사업자등록번호</th>
									<th class="cen">희망기업여부</th>
									<th class="cen">희망기업확인서</th>
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
											<input tbval="Y" name="tr_fg_name" type="hidden" value="" requiredNot="true" />
											<input tbval="Y" name="depositor" type="hidden" value="" requiredNot="true" />
										
											<input tbval="Y" name="tr_seq" type="hidden" value="" />
											<input tbval="Y" name="tr_name" type="text" pudd-style="width:calc( 100% );" class="puddSetup pr30" value="" readonly />
											
											<c:if test="${disabledYn == 'N'}"> 
											<a href="#n" onclick="fnCommonCodeCustomPop('tr', this)" class="btn_search" style="margin-left: -25px;"></a>
											</c:if>
										</div>
									</td>
									<td tbval="Y" name="tr_reg_number" requiredNot="true" class="cen"></td>
									<td name="hope_company_info_td">
										<div class="multi_sel" style="width:calc( 100% - 58px);">
											<ul tbval="Y" tbname="희망기업여부" tbType="ul" name="hope_company_info" class="multibox" style="width:100%;">							
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
											<button onclick="commonCodeSelectLayer('hopeCompany', '희망기업여부', 'ul', $(this).closest('td'), 'Y')">선택</button>
										</div>
										</c:if>
									</td>									
									<td class="file_add">	
										<ul tbval="Y" tbType="file" tbname="희망기업확인서" name="hope_attach_info" requiredNot="$(this).closest('tr').find('[name=hope_company_info] [addcode=00]').length > 0" class="file_list_box fl">
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
										<span class="fr mt2"><input onclick="fnSearchFile($(this).closest('tr'))" type="button" class="puddSetup" value="파일찾기" /></span>
										</c:if>
									</td>								
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
											<a href="#n" onclick="fnCommonCodeCustomPop('tr', this)" class="btn_search" style="margin-left: -25px;"></a>
											</c:if>
										</div>
									</td>
									<td tbval="Y" name="tr_reg_number" requiredNot="true" class="cen"></td>
									<td name="hope_company_info_td">
										<div class="multi_sel" style="width:calc( 100% - 58px);">
											<ul tbval="Y" tbType="ul" tbname="희망기업여부" name="hope_company_info" class="multibox" style="width:100%;">							
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
											<button onclick="commonCodeSelectLayer('hopeCompany', '희망기업여부', 'ul', $(this).closest('td'), 'Y')">선택</button>
										</div>
										</c:if>
									</td>									
									<td class="file_add">	
										<ul tbval="Y" tbType="file" tbname="희망기업확인서" name="hope_attach_info" requiredNot="$(this).closest('tr').find('[name=hope_company_info] [addcode=00]').length > 0" class="file_list_box fl">
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
										<span class="fr mt2"><input onclick="fnSearchFile($(this).closest('tr'))" type="button" class="puddSetup" value="파일찾기" /></span>
										</c:if>
									</td>	
								</tr>				
							</table>
						</div>						
					</td>
				</tr>
			</table>
		</div>


		<!-- 물품규격 -->
		<div class="btn_div mt25" style="margin-bottom: 5px;">
			<div class="left_div">	
				<p class="tit_p mt5 mb0">물품규격</p>
			</div>
			<div class="right_div">	
				<span class="pr10"><a href="#n" onclick="window.open('https://www.g2b.go.kr/pt/menu/selectSubFrame.do?menuId=000508&framesrc=/pt/menu/frameGonggong.do?url=https://www.g2b.go.kr:8073/cm/procmntfee/fwdDmgdPurchaseFeeDtl.do','mgjCode','width=1050, height=670, scrollbars=yes');" class="fr pt5 pb5 text_blue"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="16px" height="16px" /> 수수료계산(나라장터)</a></span>
			</div>
			<div class="right_div">	
				<span class="pr10"><a href="#n" onclick="window.open('https://www.g2b.go.kr/pt/menu/selectSubFrame.do?menuId=000508&framesrc=/pt/menu/frameGonggong.do?url=https://www.g2b.go.kr:8092/sm/ma/mn/SMMAMnF.do','mgjCode','width=1050, height=670, scrollbars=yes');" class="fr pt5 pb5 text_blue"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="16px" height="16px" /> 나라장터 종합쇼핑몰</a></span>
			</div>
			<div class="right_div">	
				<span class="pr10"><a href="#n" onclick="window.open('https://www.g2b.go.kr/pt/menu/selectSubFrame.do?menuId=000508&framesrc=/pt/menu/frameGonggong.do?url=https://www.g2b.go.kr:8321/index.jsp','mgjCode','width=1050, height=670, scrollbars=yes');" class="fr pt5 pb5 text_blue"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="16px" height="16px" /> 벤처나라</a></span>
			</div>	
			<div class="right_div">	
				<span class="pr10"><a href="#n" onclick="window.open('https://www.g2b.go.kr/pt/menu/selectSubFrame.do?menuId=000508&framesrc=/pt/menu/frameGonggong.do?url=https://www.g2b.go.kr:8914/portal/intro.do','mgjCode','width=1050, height=670, scrollbars=yes');" class="fr pt5 pb5 text_blue"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="16px" height="16px" /> 혁신장터</a></span>
			</div>
			<div class="right_div">	
				<span class="pr10"><a href="#n" onclick="window.open('https://www.g2b.go.kr/pt/menu/selectSubFrame.do?menuId=000508&framesrc=/pt/menu/frameGonggong.do?url=https://www.g2b.go.kr:8058/index.jsp','mgjCode','width=1050, height=670, scrollbars=yes');" class="fr pt5 pb5 text_blue"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="16px" height="16px" /> 디지털 서비스몰</a></span>
			</div>
			<div class="right_div">	
				<span class="pr10"><a href="#n" onclick="window.open('https://www.g2b.go.kr/pt/menu/selectSubFrame.do?menuId=000508&framesrc=/pt/menu/frameGonggong.do?url=https://www.g2b.go.kr:8092/nd/ma/mn/NDMAMnDtl.do','mgjCode','width=1050, height=670, scrollbars=yes');" class="fr pt5 pb5 text_blue"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="16px" height="16px" /> 국방사용물자쇼핑몰</a></span>
			</div>
			<div class="right_div">	
				<span class="pr10"><a href="#n" onclick="window.open('https://www.g2b.go.kr/pt/menu/selectSubFrame.do?menuId=000508&framesrc=/pt/menu/frameGonggong.do?url=https://www.g2b.go.kr:8056/mk/user/dminsttAgr.do','mgjCode','width=1050, height=670, scrollbars=yes');" class="fr pt5 pb5 text_blue"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="16px" height="16px" /> 이음장터</a></span>
			</div>	
		</div>
		
		<div class="com_ta4 ova_sc" name="itemObjListHtml">
			<table name="itemList" objKey="itemObjList" objCheckFor="checkVal('obj', 'itemList', '물품규격', 'mustAlert', '')" style="width:2760px;">
				<colgroup>
					<c:if test="${disabledYn == 'N'}"> 
					<col width="50" removehtml="Y"/>
					</c:if>
					<col width="200"/>
					<col width="200" removehtml="Y"/>
					<col width="250"/>
					<col width="300"/>
					<col width="200"/>
					<col width="150"/>
					<col width="200"/>
					<col width="150" removehtml="Y"/>
					<col width="300" removehtml="Y"/>
					<col width="200" removehtml="Y"/>
					<col width="200" removehtml="Y"/>
					<col width="200" removehtml="Y"/>
					<col width="200" removehtml="Y"/>
					<col width="130" removehtml="Y"/>
					<col width="130" removehtml="Y"/> 
					<col width="250" removehtml="Y"/>
					<col width="200" removehtml="Y"/>
					<col width="300" removehtml="Y"/>
					<col width="200" removehtml="Y"/>
					<col width="200" removehtml="Y"/>
				</colgroup>
				<tr>
					<c:if test="${disabledYn == 'N'}"> 
					<th class="ac" removehtml="Y">
						<input type="button" onclick="fnSectorAdd('itemList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_plus01.png') no-repeat center" value="" />
					</th>
					</c:if>
					<th class="ac">공급업체</th>
					<th class="ac" removehtml="Y">물품분류번호</th>
					<th class="ac">물품식별번호</th>
					<th class="ac">품명</th>
					<th class="ac">구매수량</th>
					<th class="ac">조달단가</th>
					<th class="ac">소계</th>
					<th class="ac" removehtml="Y">납품기한</th>
					<th class="ac" removehtml="Y">수령장소</th>					
					<th class="ac" removehtml="Y">취득수수료</th>
					<th class="ac" removehtml="Y">총계</th>
					<th class="ac" removehtml="Y">단위</th>
					<th class="ac" removehtml="Y">물품대장코드</th>
					<th class="ac" removehtml="Y">사용위치</th>
					<th class="ac" removehtml="Y">국내외구분</th>
					<th class="ac" removehtml="Y">국가코드</th>
					<th class="ac" removehtml="Y">취득사유코드</th>
					<th class="ac" removehtml="Y">녹색제품여부</th>
					<th class="ac" removehtml="Y">녹색제품인증구분</th> 
					<th class="ac" removehtml="Y">녹색제품미구매사유</th>
					<th class="ac" removehtml="Y">제품분류</th>
				</tr>
				<tr name="dataBase" style="display:none;">
					<c:if test="${disabledYn == 'N'}"> 
					<td removehtml="Y">
						<input type="button" onclick="fnSectorDel(this, 'itemList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					</c:if>
					<td><select ${disabled} tbval="Y" name="item_tr_seq" tbname="공급업체" style="min-width: 120px;"><option value=""></option></select></td>
					<td removehtml="Y"><input ${disabled} tbval="Y" name="item_div_no" tbname="물품분류번호" type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup" value="" /></td>
					<td>
						<div class="posi_re">
							<input tbval="Y" ${disabled} name="item_idn_no" tbname="물품식별번호" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<c:if test="${disabledYn == 'N'}"> 
							<a removehtml="Y" href="#n" class="btn_search" style="margin-left: -25px;" onclick="commonCodeSelectLayer('', '나라장터 종합쇼핑몰', 'shopping', $(this).closest('tr'), 'N')"></a>
							</c:if>	
						</div>
					</td>
					<td><input ${disabled} tbval="Y" name="item_name" tbname="품명" type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup" value="" /></td>
					<td><input ${disabled} tbval="Y" name="item_cnt" tbname="구매수량" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');fnCalculateTotal($(this).closest('tr'));" type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup ar" value="1" /></td>
					<td htmlalign="right"><input ${disabled} tbval="Y" name="item_amt" tbname="조달단가" onkeyup="fnCalculateTotal($(this).closest('tr'));" amountInput="Y" type="text" pudd-style="width:calc(90% - 10px);" class="puddSetup ar" value="0" /> <span removehtml="Y">원</span></td>
					<td htmlalign="right" tbval="Y" name="item_sub_total_amt_text" tbtype="innerText" class="ri">0 원</td>
					<input tbval="Y" name="item_sub_total_amt" amountInput="Y" type="hidden" value="0" requiredNot="true" />
					<td removehtml="Y"><input ${disabled} tbval="Y" placeholder="년-월-일" name="item_deadline" tbname="납품기한" value="" readonly style="text-align: center;height: 22px;border: ridge;width: 90px;" /></td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_pickup_location" tbname="사용위치" >
							<c:forEach var="items" items="${useLocationCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>	
						</select>
					</td>
					<td removehtml="Y"><input ${disabled} tbval="Y" name="item_fee_amt" tbname="취득수수료" amountInput="Y" onkeyup="fnCalculateTotal($(this).closest('tr'));" type="text" pudd-style="width:100px;" class="puddSetup ar" value="0" /> 원</td>
					<td removehtml="Y" htmlalign="right" tbval="Y" name="item_total_amt_text" tbtype="innerText" class="ri">0 원</td>
					<input tbval="Y" name="item_total_amt" amountInput="Y" type="hidden" value="0" requiredNot="true" />					
					<td class="le" removehtml="Y">
						<input tbval="Y" name="item_unit" tbname="단위" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" readonly codetarget />
						<c:if test="${disabledYn == 'N'}"> 
						<a href="#n" class="btn_search ml10" onclick="commonCodeSelectLayer('unit', '단위', 'text', $(this).closest('td'), 'N')"></a>
						</c:if>	
					</td>
					<td  removehtml="Y">
						<select ${disabled} tbval="Y" name="item_inventory_cd" tbname="물품대장코드" >
							<c:forEach var="items" items="${inventoryCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>								
						</select>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_use_location" tbname="사용위치" >
							<c:forEach var="items" items="${useLocationCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>	
						</select>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_foreign_type" >
							<c:forEach var="items" items="${foreignTypeCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>	
						</select>
					</td>
					<td class="le" removehtml="Y">
						<input tbval="Y" name="item_contry" tbname="국가코드" type="text" pudd-style="width:100px;" class="puddSetup ar" value="대한민국" readonly codetarget />
						<c:if test="${disabledYn == 'N'}">  
						<a href="#n" class="btn_search ml10" onclick="commonCodeSelectLayer('country', '국가코드', 'text', $(this).closest('td'), 'N')"></a>
						</c:if>	
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_acquisition_reason" tbname="취득사유코드" style="text-align: center;">
							<c:forEach var="items" items="${acquisitionReasonCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" type="select" id = "item_green_cert_yn" name="item_green_cert_yn" onchange="chageYnSelect(this)" tbname="녹색제품여부" requiredNot="true" style="text-align: center;"> 
						
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</td>
					<td removehtml="Y" name="green_certifi_info_td">
						<div class="multi_sel" style="width:calc( 100% - 58px);">
								<ul tbval="Y" tbname="녹색제품인증구분" tbType="ul" id="item_green_cert_type" name="item_green_cert_type" class="multibox" style="width:200px;" requiredNot="true">														
								<li name="dataBase" addCode="" style="display:none;">
									<span name="addName"></span>
										<c:if test="${disabledYn == 'N'}"> 
										<a href="#n" name="xtest" onclick="$(this).closest('li').remove();" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a>
										</c:if>
									</li>
								</ul>								
							</div>
							<c:if test="${disabledYn == 'N'}"> 
							<div class="controll_btn p0 pt4" id = "item_green_cert_type_btn" name="item_green_cert_type_btn">	
								<button onclick="commonCodeSelectLayer('greenCertType', '녹색제품인증구분', 'ul', $(this).closest('td'), 'Y')">선택</button>
							</div>
						</c:if>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_non_green_reason" tbname="녹색제품미구매사유" requiredNot="$(this).closest('tr').find('[name=item_green_cert_type]').val() != ''" style="text-align: center;" disabled>
							<c:forEach var="items" items="${nonGreenReasonCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_green_class" tbname="제품분류" style="text-align: center;">
							<c:forEach var="items" items="${greenClassCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select>
					</td>															
				</tr>
				<tr name="addData">
					<c:if test="${disabledYn == 'N'}"> 
					<td removehtml="Y">
						<input type="button" onclick="fnSectorDel(this, 'itemList')" class="puddSetup" style="width:20px;height:20px;background:url('${pageContext.request.contextPath}/customStyle/Images/btn/btn_minus01.png') no-repeat center" value="" />
					</td>
					</c:if>
					<td><select ${disabled} tbval="Y" name="item_tr_seq" tbname="공급업체" style="min-width: 120px;"><option value=""></option></select></td>
					<td removehtml="Y"><input ${disabled} tbval="Y" name="item_div_no" tbname="물품분류번호" type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup" value="" /></td>
					<td>
						<div class="posi_re">
							<input tbval="Y" ${disabled} name="item_idn_no" tbname="물품식별번호" type="text" pudd-style="width:calc( 100% - 10px);" class="puddSetup pr30" value="" />
							<c:if test="${disabledYn == 'N'}"> 
							<a removehtml="Y" href="#n" class="btn_search" style="margin-left: -25px;" onclick="commonCodeSelectLayer('', '나라장터 종합쇼핑몰', 'shopping', $(this).closest('tr'), 'N')"></a>
							</c:if>	
						</div>
					</td>
					<td><input ${disabled} tbval="Y" name="item_name" tbname="품명" type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup" value="" /></td>
					<td><input ${disabled} tbval="Y" name="item_cnt" tbname="구매수량" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');fnCalculateTotal($(this).closest('tr'));" type="text" pudd-style="width:calc(100% - 10px);" class="puddSetup ar" value="1" /></td>
					<td htmlalign="right"><input ${disabled} tbval="Y" name="item_amt" tbname="조달단가" onkeyup="fnCalculateTotal($(this).closest('tr'));" amountInput="Y" type="text" pudd-style="width:calc(90% - 10px);" class="puddSetup ar" value="0" /> <span removehtml="Y">원</span></td>
					<td htmlalign="right" tbval="Y" name="item_sub_total_amt_text" tbtype="innerText" class="ri">0 원</td>
					<input tbval="Y" name="item_sub_total_amt" amountInput="Y" type="hidden" value="0" requiredNot="true" />
					<td removehtml="Y"><input ${disabled} tbval="Y" placeholder="년-월-일" name="item_deadline" tbname="납품기한" value="" readonly style="text-align: center;height: 22px;border: ridge;width: 90px;" /></td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_pickup_location" tbname="사용위치" >
							<c:forEach var="items" items="${useLocationCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>	
						</select>
					</td>					
					<td removehtml="Y"><input ${disabled} tbval="Y" name="item_fee_amt" tbname="취득수수료" amountInput="Y" onkeyup="fnCalculateTotal($(this).closest('tr'));" type="text" pudd-style="width:100px;" class="puddSetup ar" value="0" /> 원</td>
					<td removehtml="Y" htmlalign="right" tbval="Y" name="item_total_amt_text" tbtype="innerText" class="ri">0 원</td>
					<input tbval="Y" name="item_total_amt" amountInput="Y" type="hidden" value="0" requiredNot="true" />						
					<td class="le" removehtml="Y">
						<input tbval="Y" name="item_unit" tbname="단위" type="text" pudd-style="width:100px;" class="puddSetup ar" value="" readonly codetarget />
						<c:if test="${disabledYn == 'N'}"> 
						<a href="#n" class="btn_search ml10" onclick="commonCodeSelectLayer('unit', '단위', 'text', $(this).closest('td'), 'N')"></a>
						</c:if>	
					</td>
					<td  removehtml="Y">
						<select ${disabled} tbval="Y" name="item_inventory_cd" tbname="물품대장코드" >
							<c:forEach var="items" items="${inventoryCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>								
						</select>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_use_location" tbname="사용위치" >
							<c:forEach var="items" items="${useLocationCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>	
						</select>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_foreign_type" >
							<c:forEach var="items" items="${foreignTypeCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>	
						</select>
					</td>
					<td class="le" removehtml="Y">
						<input tbval="Y" name="item_contry" tbname="국가코드" type="text" pudd-style="width:100px;" class="puddSetup ar" value="대한민국" readonly codetarget />
						<c:if test="${disabledYn == 'N'}">  
						<a href="#n" class="btn_search ml10" onclick="commonCodeSelectLayer('country', '국가코드', 'text', $(this).closest('td'), 'N')"></a>
						</c:if>	
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_acquisition_reason" tbname="취득사유코드" style="text-align: center;">
							<c:forEach var="items" items="${acquisitionReasonCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" type="select" id = "item_green_cert_yn" name="item_green_cert_yn" onchange="chageYnSelect(this)" tbname="녹색제품여부" requiredNot="true" style="text-align: center;">
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</td>
					
					<td name="green_certifi_info_td">
						<div class="multi_sel" style="width:calc( 100% - 58px);">
							<ul tbval="Y" tbname="녹색제품인증구분" tbType="ul" id="item_green_cert_type" name="item_green_cert_type" class="multibox" style="width:200px;" requiredNot="true">							
								<li name="dataBase" addCode="" style="display:none;">
									<span name="addName"></span>
										<c:if test="${disabledYn == 'N'}"> 
										<a href="#n" name="xtest" onclick="$(this).closest('li').remove();" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a>
										</c:if>
								</li>
							</ul>								
						</div>
						<c:if test="${disabledYn == 'N'}"> 
							<div class="controll_btn p0 pt4" id = "item_green_cert_type_btn" name="item_green_cert_type_btn">		
								<button onclick="commonCodeSelectLayer('greenCertType', '녹색제품인증구분', 'ul', $(this).closest('td'), 'Y')">선택</button>
							</div>
						</c:if>
					</td>
					
<%-- 					<td removehtml="Y">
							<select ${disabled} tbval="Y" name="item_green_cert_type" tbname="녹색제품인증구분" requiredNot="true" style="text-align: center;" >
							<c:forEach var="items" items="${greenCertTypeCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select> 
					</td> --%>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_non_green_reason" tbname="녹색제품미구매사유" requiredNot="$(this).closest('tr').find('[name=item_green_cert_type]').val() != ''" style="text-align: center;" disabled>
							<c:forEach var="items" items="${nonGreenReasonCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select>
					</td>
					<td removehtml="Y">
						<select ${disabled} tbval="Y" name="item_green_class" tbname="제품분류" style="text-align: center;">
							<c:forEach var="items" items="${greenClassCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>
						</select>
					</td>													
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
							<input tbval="Y" name="pjt_at_tr_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="pjt_bank_number" type="hidden" value="" requiredNot="true"/>																

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
							<input tbval="Y" name="pjt_at_tr_name" type="hidden" value="" requiredNot="true" />
							<input tbval="Y" name="pjt_bank_number" type="hidden" value="" requiredNot="true"/>															
							
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
			<table>
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