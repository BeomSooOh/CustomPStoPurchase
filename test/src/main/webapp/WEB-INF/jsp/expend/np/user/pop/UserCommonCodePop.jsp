<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<!-- <script type="text/javascript" -->
<%-- 	src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script> --%>
<script type="text/javascript"
	src='<c:url value="/js/ex/ExExpend.js"></c:url>'></script>


<div class="pop_wrap" style="background-color: white;">
	<input type="hidden" id="hidSelectVal">
	<c:if test="${ViewBag.code == 'budget'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBudgetBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'cardnum'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpCardNumBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'bizplan'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBizplanBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'bgacct'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBgacctBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'bgacct2'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBgacct2Body.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'fiacct'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpFiacctBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'tr' || ViewBag.code == 'btrtr'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpTrBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'tretc'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpTrEtcBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'trbus'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpTrBusBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'emp'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpEmpBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'bank'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBankBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'div'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpDivBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'biz'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBizBody.jsp"
			flush="false" />
	</c:if>
	
	<c:if test="${ViewBag.code == 'project'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpProjectBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'project2'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpProject2Body.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'erphpmeticlist'}">
		<!-- ??????????????? -->
		<jsp:include
			page="../include/${ViewBag.ERPType}/NpErpHpmeticListBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'budgetlist'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBudgetListBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'income'}">
		<!-- ???????????? -->
		<jsp:include page="../include/${ViewBag.ERPType}/NpIncomeBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'erphincomeiclist'}">
		<!-- ??????????????? -->
		<jsp:include
			page="../include/${ViewBag.ERPType}/NpErphincomeiclistBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'dept'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpDeptBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'dept2'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpDept2Body.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'dept2'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpDept2Body.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'bottom'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBottomBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'bottom2'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBottom2Body.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'card'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpCardBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'ctr'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpCtrBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'btr'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpBtrBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'taxinput'}">
		<jsp:include page="../include/${ViewBag.ERPType}/NpTaxInputBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'notax'}">
		<!-- ????????? ?????? -->
		<jsp:include page="../include/${ViewBag.ERPType}/NpNoTaxInputBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'incomegbn'}">
		<!-- ????????????(ERPiU) -->
		<jsp:include page="../include/${ViewBag.ERPType}/NpIncomeGbnInputBody.jsp"
			flush="false" />
	</c:if>
	<c:if test="${ViewBag.code == 'banb'}">
		<!-- ????????????(ERPiU) -->
		<jsp:include page="../include/${ViewBag.ERPType}/NpBaNbBody.jsp"
			flush="false" />
	</c:if>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnReflect" value="${CL.ex_check} " />  <!--??????-->
			<input type="button" id="btnCancel" class="gray_btn" value="${CL.ex_cancel}" /> <!--??????-->
		</div>
	</div>
	<!-- //pop_foot -->
</div>

<script>
	var callbackFuncName = '${ViewBag.callbackFunction}';
	var tableData;
	var clickCount = 0;
	var timeOut = null;
	
	<c:if test="${empty ViewBag.param}">
	var viewBagParam = {};
	</c:if>
	<c:if test="${not empty ViewBag.param}">
	var viewBagParam = ${ViewBag.param};
	</c:if>
 	
	var thisWidth, thisHeight = 0;
	var popMWidth, popMHeight = 0;
	var staticMaxCount = 100;
	var maxCount = Number(staticMaxCount.toString());
	var oldData = [];
	
	$(document).ready(function(){
		/* ????????? ?????? */
		$("#txtSearchStr").val(viewBagParam.param.searchStr);
		
		var fnInitPopupLayout = window['fnInitPopupLayout'];
    	/* ?????? ??? ???????????? ?????? */
		if( typeof(fnInitPopupLayout) == "function" ){
			fnInitPopupLayout();
    	}else{
    		alert("???????????? ???????????? ??????????????????");
    		$("#btnCancel").click();
    	}
    	
    	/* ?????? ???????????? */
    	fnPopupResize();
    	if( viewBagParam.popupType == '2' ){
    		$("#imgClose").hide();	
    	}
    	
		fnInitEvent();
		tableData = [];
		<c:if test = "${ViewBag.data ne '' && ViewBag.data ne null}">
			tableData =${ViewBag.data};
		</c:if>
// 		tableData = JSON.parse('${ViewBag.data}');
		
		$('#viewLoading').show();
		
		setTimeout(function(){
			fnSearchCommonCode();
			$('#viewLoading').hide();
		}, 50);
	});
	
	/* ?????? ????????????  */
	function fnPopupResize(){
		var thisX = parseInt(thisWidth);
	    var thisY = parseInt(thisHeight);
	    var subX = popMWidth;
	    var subY = popMHeight;
	    
		
		/* ?????? ????????? ?????? ?????? ????????? ?????? */
	    if(viewBagParam.popupType == "2"){
		    var marginY = 0;
		    // ??????????????? ?????? ??????. (?????? ??? ????????? ????????? ????????????.)
		    if (navigator.userAgent.indexOf("MSIE 6") > 0){        // IE 6.x
		    	marginY = 45;
	    	}
		    else if(navigator.userAgent.indexOf("MSIE 7") > 0){    // IE 7.x
		    	marginY = 75;
		    }
		    else if(navigator.userAgent.indexOf("Firefox") > 0){	// FF
		    	marginY = 50;
		    }
		    else if(navigator.userAgent.indexOf("Opera") > 0){     // Opera
		    	marginY = 30;
		    }
		    else if(navigator.userAgent.indexOf("Netscape") > 0){  // Netscape
		    	marginY = -2;
		    }
	
		    // ?????? ??????
		    var windowX = (screen.width - (thisX+10))/2;
		    var windowY = (screen.height - (thisY + marginY))/2 - 20;
		    console.log((thisX+subX) + "/" + (thisY+subY));
		    console.log((thisX) + "/" + (thisY));
		    //window.resizeTo(thisX + subX, thisY + subY);
		    //window.moveTo(windowX,windowY);
	    }else if(viewBagParam.popupType =="3"){	
			$('.pop_wrap').css("width",(thisX + "px"));
			$('.pop_wrap').css("height",(thisY +"px"));
		}
	}
	
	/* ?????? ???????????? ????????? ?????? */
	var checkDataArray = new Array();
	function fnInitEvent(){
		$("#txtSearchStr").focus();
		
		/* ?????? - ?????? */
		$("#btnReflect").on("click",function(){
			var returnData = '';
			
			if(viewBagParam.code == "card") {
				if($("input[type=checkbox]:checked")) {
					checkDataArray = $('input:checkbox[name="cardCheckBox"]:checked').map(function(){return this.value;}).get();	
					
					if(checkDataArray.length > 0) {
						returnData = checkDataArray;	
					} else {
						alert("????????? ??????????????????");
						return;
					}
				}
			} else if( viewBagParam.code == "bgacct2" ){
				if($("input[type=checkbox]:checked")) {
					checkDataArray = $('.chkBgacctCode:checked').map(function(){return this.value;}).get();	
					if(checkDataArray.length > 0) {
						returnData = checkDataArray;	
					} else {
						alert("??????????????? ??????????????????.");
						return;
					}
				}
			} else if ( viewBagParam.code == "project2" ){
				if($("input[type=checkbox]:checked")) {
					checkDataArray = $('.chkData:checked').map(function(){return this.value;}).get();	
					if(checkDataArray.length > 0) {
						returnData = checkDataArray;	
					} else {
						alert("??????????????? ??????????????????.");
						return;
					}
				}
			} else if( viewBagParam.code == "bottom2" ){
				if($("input[type=checkbox]:checked")) {
					checkDataArray = $('.chkData:checked').map(function(){return this.value;}).get();	
					if(checkDataArray.length > 0) {
						returnData = checkDataArray;	
					} else {
						alert("??????????????? ??????????????????.");
						return;
					}
				}
			} else if( viewBagParam.code == "dept2" ){
				if($("input[type=checkbox]:checked")) {
					checkDataArray = $('.chkData:checked').map(function(){return this.value;}).get();	
					if(checkDataArray.length > 0) {
						returnData = checkDataArray;	
					} else {
						alert("????????? ??????????????????.");
						return;
					}
				}
			}else {
				returnData = JSON.parse($("#hidSelectVal").val());
			}
			
			returnData = fnSetCommonReturnData( returnData );
			fnCallPopupCallback(returnData);
		});
		/* ?????? - ?????? */
		$("#btnCancel").on("click",function(){
			fnClosePopup();
		});
		
		/* ?????? - ?????? */
		$("#btnSearch").on("click",function(){
			tableData = [];
			fnSearchCommonCode();
			
			if($('#txtSearchStr').length > 0){
				$('#txtSearchStr').focus().select();
			}
		});
		
		/* ????????? - ????????? ?????? ????????? */
		$("#txtSearchStr").keydown(function(event){
			if (event.keyCode == 13){
				$("#btnSearch").click();	
			}
		});
		
		/* ????????? - ????????? ?????? ????????? */
		$(this).keydown(function(event){
			if (event.keyCode == 27){
				fnClosePopup();
			}			
		});
		
		/* ?????? - ?????? ?????? ?????? */
		$(".button_dal").on("click",function(){
			if( !$("#txt" + $(this).attr("id").replace("btn","") ).datepicker("widget").is(":visible") ){
				$("#txt" + $(this).attr("id").replace("btn","") ).datepicker("show");	
			}
		});
	}
	
	/* ????????? ?????? ?????? - ?????? ?????? ??????*/
	function fnSetDatepicker(id, format){
		$(id).datepicker({
	  		closeText: '??????',
	        prevText: '?????????',
	        nextText: '?????????',
	        currentText: '??????',
	        monthNames: ['1???','2???','3???','4???','5???','6???',
	        '7???','8???','9???','10???','11???','12???'],
	        monthNamesShort: ['1???','2???','3???','4???','5???','6???',
	        '7???','8???','9???','10???','11???','12???'],
	        dayNames: ['???','???','???','???','???','???','???'],
	        dayNamesShort: ['???','???','???','???','???','???','???'],
	        dayNamesMin: ['???','???','???','???','???','???','???'],
	        weekHeader: 'Wk',
	        firstDay: 0,
	        isRTL: false,
	        duration:200,
	        showAnim:'show',
	        showMonthAfterYear: true,
			dateFormat: format
		});
	}
	
	function fnGetCommonCodeParam(){
		<c:if test="${empty ViewBag.param}">
		var param = {};
		</c:if>
		<c:if test="${not empty ViewBag.param}">
		var param = ${ViewBag.param};
		</c:if>
		
		return param; 
	} 
	
	/* ???????????? ?????? */
	function fnSearchCommonCode (){
		<c:if test="${empty ViewBag.param}">
		var param = {};
		</c:if>
		<c:if test="${not empty ViewBag.param}">
		var param = ${ViewBag.param};
		</c:if>
		/* ????????? ??? ?????? ??? ???????????? ??????  */
		param.param = fnSetPageParam( param.param );
		
		if(viewBagParam.code == 'ctr'){
			param.param.useYn = (cardCheckYN?0:1);
		}
		
		if(tableData != 'undefined' && tableData.length > 0){
			if(tableData.length == 1){
        		var returnData = tableData[0];
        		
        		if(viewBagParam.code == 'bgacct2'){
        			returnData = [escape( JSON.stringify(returnData) )];
        		}else if(viewBagParam.code == 'NpBottom2'){
        			returnData = [escape( JSON.stringify(returnData) )];
        		}else if(viewBagParam.code == 'NpDept2'){
        			returnData = [escape( JSON.stringify(returnData) )];
        		}else if(viewBagParam.code == 'NpProject2'){
        			returnData = [escape( JSON.stringify(returnData) )];
        		} 
        		
            	returnData = fnSetCommonReturnData( returnData );
            	fnCallPopupCallback(returnData);
        	}else{
	        	if(typeof fnGridCommonCodeTable === 'function'){
	        		fnGridCommonCodeTable( tableData );
	        	}else{
	        		alert("???????????? ????????? ??????");
	        	}
        	}
		}else{
			<c:if test="${ViewBag.code == 'income'}">
			param.param.residence = param.param.residence || 'G'; 
        	</c:if>
			<c:if test="${ViewBag.code == 'ctr'}">
			/* ?????? ????????? ?????? ?????? ???????????? ??? ?????? */
			param.param.trName = $('#txtSearchStr').val();
			</c:if>
			param.param = JSON.stringify(param.param);
			/* ???????????? ?????? */
			$.ajax({
		        type : 'post',
		        url : '<c:url value="/expend/np/user/code/ExCodeInfoSelect.do" />',
		        datatype : 'json',
		        async : true,
		        data : param,
		        success : function( data ) {
		        	
		        	<c:if test="${ViewBag.code == 'budgetlist'}">
		        	/* ????????? / ?????? ???????????? ?????? ?????? */
		        	if((data.result.aaData.length == 1) && viewBagParam.param.selectedBudgetSeqs){
		        		var item = data.result.aaData[0];
		        		if( viewBagParam.param.selectedBudgetSeqs.indexOf('|' + (item.erpBudgetSeq || item.BGT_CD) + '|') > -1 ){
		        			data.result.aaData = [];
		        		}
		        	}
		        	</c:if>
		        	
		        	
		        	if(data.result.aaData != 'undefined' && data.result.aaData.length == 1 && !( (data.result.aaData[0].DATA_CD == "BI") || (data.result.aaData[0].DATA_CD == "G") ) ){
		        		var returnData = data.result.aaData[0];
		        		
		        		<c:if test="${ViewBag.code == 'emp'}">
		        		/* ??????????????? ?????? */
		        		returnData.causeEmpSeq = (returnData.erpEmpSeq || '');
		        		returnData.causeEmpName = (returnData.korName || '');
		        		</c:if>
		        		
		        		<c:if test="${ViewBag.code == 'project'}">
		        		/* ???????????? ?????? */
		        		returnData.erpMgtSeq = (returnData.pjtSeq || '');
		        		returnData.erpMgtStatus = (returnData.pjtStatus || '');
		    			returnData.erpMgtName = (returnData.pjtName || '');
		    			</c:if>
		    			
		        		<c:if test="${ViewBag.code == 'project2'}">
		        		/* ???????????? ?????? */
		        		returnData.erpMgtSeq = (returnData.pjtSeq || '');
		        		returnData.erpMgtStatus = (returnData.pjtStatus || '');
		    			returnData.erpMgtName = (returnData.pjtName || '');
		    			</c:if>
		    			
		    			
		    			<c:if test="${ViewBag.code == 'budgetlist'}">
		    			/* ???????????? ?????? */
		    			returnData.erpBudgetSeq = (returnData.BGT_CD || '');
		    			returnData.erpBudgetName = (returnData.BGT_NM || '');
		    			
		    			returnData.erpBgt1Seq = (returnData.BGT01_CD || '');
		    			returnData.erpBgt2Seq = (returnData.BGT02_CD || '');
		    			returnData.erpBgt3Seq = (returnData.BGT03_CD || '');
		    			returnData.erpBgt4Seq = (returnData.BGT04_CD || '');
		    			
		    			returnData.erpBgt1Name = (returnData.BGT01_NM || '');
		    			returnData.erpBgt2Name = (returnData.BGT02_NM || '');
		    			returnData.erpBgt3Name = (returnData.BGT03_NM || '');
		    			returnData.erpBgt4Name = (returnData.BGT04_NM || '');
		    			</c:if>
		    			
		    			<c:if test="${ViewBag.code == 'div'}">
		    			/* ???????????? ?????? */
		    			returnData.erpDivSeq = (returnData.divSeq || '');
		    			returnData.erpDivName = (returnData.divName || '');
		    			</c:if>
		        		returnData = fnSetCommonReturnData( returnData );
		        		
		        		if(viewBagParam.code == 'bgacct2'){
		        			returnData = [escape( JSON.stringify(returnData) )];
		        		}else if(viewBagParam.code == 'NpBottom2'){
		        			returnData = [escape( JSON.stringify(returnData) )];
		        		}else if(viewBagParam.code == 'NpDept2'){
		        			returnData = [escape( JSON.stringify(returnData) )];
		        		}else if(viewBagParam.code == 'NpProject2'){
		        			returnData = [escape( JSON.stringify(returnData) )];
		        		} 
		        		
		        		fnCallPopupCallback(returnData);
		        	}else{
			        	if(typeof fnGridCommonCodeTable === 'function'){
			        		fnGridCommonCodeTable( data.result.aaData );
			        	}else{
			        		alert("???????????? ????????? ??????");
			        	}
		        	}
		        },
		        error : function( data ) {
		            console.log('?????????!????????????!?????????~!!???!');
		        }
		    });
		}
	}
	
	/* ????????? ?????? */
	function fnInitTableEvent ( ){
		/* ????????? - ????????? ??? ?????? */
		$("#tblCommonCode tbody tr").on("click",function(e){
			clickCount++;
			var clickElement = this;
			if(clickCount === 1){
				timeOut = setTimeout(function(){
					clickCount = 0;
					fnSetClickEvent(clickElement);
				}, 200);
			}else{
				clickCount = 0;
				clearTimeout(timeOut);
				fnSetDblClickEvent(clickElement);
			}
		});
		
		/* ????????? - ????????? ??? ?????? ?????? */
		$("#tblCommonCode").delegate("tr","dblclick",function(e){
			e.preventDefault();
		});
	}
	
	/* ??? ?????? ????????? ?????? */
	function fnSetClickEvent (elem){
		$("#hidSelectVal").val(JSON.stringify($(elem).data('data')));
	}
	
	/* ??? ?????? ?????? ????????? ?????? */
	function fnSetDblClickEvent (elem){
		var returnData = $(elem).data('data');
		if(viewBagParam.code == 'bgacct2'){
			returnData = fnSetCommonReturnData( [escape(JSON.stringify(returnData))] );
		}
		else{
			returnData = fnSetCommonReturnData( returnData );
		}
		fnCallPopupCallback(returnData);
	}
	
	/* ?????? ?????? ??? ?????? ?????? ??? ?????? */
	function fnSetCommonReturnData( returnData ){
		returnData.code = viewBagParam.code;
    	returnData.dummy = JSON.stringify(viewBagParam.dummy);
    	return returnData;
	}
	
	/* ?????? ?????? */
	function fnCallPopupCallback( param ){
    	/* ????????? ?????? ?????? */
		if( typeof(window[callbackFuncName]) == "function" ){
			window[callbackFuncName](param);
    		fnCloseLayerPop();
    	}else{
    		/* [CUST_001] ????????????????????? ?????? ???????????? ?????? */
    		if(viewBagParam.code == 'bizplan' && window.opener.optionSet.customOption && window.opener.optionSet.customOption['CUST_001']){
    			if(typeof window.opener.custfnCheckDivCdInclue != "function"){
    				alert('?????????????????? ?????? ?????? ?????? [CUST_001]');
    				return;
    			}
    			
    			if(window.opener.custfnCheckDivCdInclue(param.CD_BIZPLAN) == 'N'){
    				alert('??????????????? ?????? ??????????????? ????????????.\n????????? ????????? ???????????????.');
    				return;
    			}
    		}
    		
    		/* ????????? ?????? ?????? */
    		if( typeof(window.opener[callbackFuncName]) == "function" ){ 
    			window.opener[callbackFuncName](param);
    			self.close();
    		}else{
    			window.location.reload();
    		}
    	}
	}
	
	/* ?????? ????????? */
	function fnClosePopup(){
		if(viewBagParam.popupType =="2"){
			self.close();	
		}else if(viewBagParam.popupType =="3"){	
			fnCloseLayerPop();
		}
	}
</script>