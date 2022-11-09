<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/ExOption.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/jquery.maskMoney.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/CommonEX.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.format.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/jquery.inputmask.js'></script>

<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<!-- 환종 정보 -->
<input id="hidExchangeUnitInfo" type="hidden" />

<div class="pop_wrap" style="height: 99%;">
	<div class="pop_head">
		<h1>${CL.ex_foreignCurrencyInput} <!--외화입력--></h1>
	</div>
	
	<div class="pop_con">
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="30%" />
					<col width="70%" />
				</colgroup>
				<tr>
					<th>${CL.ex_exchangeUnit}</th> <!--환종-->
					<td>
						<input id="txtExchangeUnitDisp" type="text" style="width: 79%" autocomplete="off" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnExchangeUnitInfoHelpPop">${CL.ex_select}</button>
						</div>
					</td>
				</tr>
				<tr>
					<th>${CL.ex_exchangeRate}</th> <!--환율-->
					<td>
						<input id="txtExchangeRate" type="text" style="width: 100%" />
					</td>
				</tr>
				<tr>
					<th>${CL.ex_foreignCurrencyAmount}</th> <!--외화금액-->
					<td>
						<input id="txtForeignCurrencyAmount" type="text" style="width: 100%" />
					</td>
				</tr>
				<tr>
					<th>${CL.ex_amount}</th> <!--금액-->
					<td>
						<input id="txtResultAmount" type="text" style="width: 100%" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="btnConfirm" value="${CL.ex_check}" /> <!--확인-->
			<input type="button" id="btnCancel" class="gray_btn" value="${CL.ex_cancel}" onclick="window.close();" /> <!--취소-->
		</div>
	</div>
</div>

<script>
	// 올림구분 값(ERPiU)
	var ERPiURoundingType = "";
	// 환종코드
	var hidExchangeUnitCode = "";
	// 환종명
	var hidExchangeUnitName = "";
	
	$(document).ready(function() {
		// 이벤트 초기화
		fnInitEvent();
		
		if(opener.ifSystem == "ERPiU"){
			// ERPiU 올림구분 값 조회
			fnSelectRoundingType();
		}else if(opener.ifSystem == "iCUBE"){
			// iCUBE 소수점 자릿수 조회
			fnSelectPointLength();
		}
	});
	
	// 이벤트 초기화
	function fnInitEvent(){
		// 환종팝업 엔터
		$("#txtExchangeUnitDisp").keydown(function(event){
			if(event.keyCode == '13'){
				var txtType = $(this).attr('id').replace('txt','').replace('Disp','');
				fnOpenCommonCodePop('Y', txtType);
			}
		});
		
		// 환종팝업 버튼클릭
		$("#btnExchangeUnitInfoHelpPop").click(function(){
			var btnType = "ExchangeUnit"; // 환종구분값
			fnOpenCommonCodePop('N', btnType);
		});
		
		// 환종팝업 엔터
		$("#txtExchangeRate, #txtForeignCurrencyAmount, #txtResultAmount").keydown(function(event){
			if(event.keyCode == '13'){
				var txtType = $(this).attr('id');
				fnSetFocus(txtType);
			}
		});
		
		// 환율입력(ERPiU일 경우 소수점 4자리)
		$("#txtExchangeRate").inputmask({
			alias: 'decimal', 
	        allowMinus: false,  
	        digits: 4,
	        rightAlign: false,
	        groupSeparator: ".",
	        autoGroup: true,    
	        digitsOptional: false
		});
		
		// 외화금액 입력(ERPiU일 경우 소수점 4자리)
		$("#txtForeignCurrencyAmount").inputmask({
			alias: 'decimal', 
	        allowMinus: opener.isNegativeAmt,  
	        digits: 4,
	        rightAlign: false,
	        groupSeparator: ".",
	        autoGroup: true,    
	        digitsOptional: false
		});
		
		$("#txtExchangeRate, #txtForeignCurrencyAmount").focus(function(){
			this.select();
		});
		
		// 금액 입력
		$("#txtResultAmount").maskMoney({
			precision : 0,
			allowNegative: opener.isNegativeAmt
		}).keydown(function(e){
			if(e.keyCode == 13){ // 엔터키 입력시
				$("#btnConfirm").click();
			}
		});
		
		// 금액 자동계산
		$("#txtExchangeRate, #txtForeignCurrencyAmount").change(function(){
			var resultAmt = fnCalculateAmt();
			
			$("#txtResultAmount").val(resultAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		});
		
		$("#btnConfirm").click(function(){
			// 외화정보 반영
			var foreignCurrencyInfo = {};
			foreignCurrencyInfo.exchangeUnitCode = hidExchangeUnitCode;
			foreignCurrencyInfo.exchangeUnitName = hidExchangeUnitName;
			foreignCurrencyInfo.exchangeRate = $("#txtExchangeRate").val();
			foreignCurrencyInfo.foreignCurrencyAmount = $("#txtForeignCurrencyAmount").val();
			foreignCurrencyInfo.foreignAcctYN = "Y";
			
			if("${ViewBag.type}" == "list"){
				$(opener.document).find("#hidExpendListForeignCurrencyInfo").val(JSON.stringify(foreignCurrencyInfo));
			}else if("${ViewBag.type}" == "slip"){
				$(opener.document).find("#hidExpendSlipForeignCurrencyInfo").val(JSON.stringify(foreignCurrencyInfo));
			}
			
			// 입력한 외화정보 저장
			opener.foreignCurrencyInfo = foreignCurrencyInfo;
			
			// 금액값 반영
		    var resultAmt = $("#txtResultAmount").val();
			window.opener["${ViewBag.callback}"](resultAmt);
			window.close();
		});
	}
	
	// 공통코드 조회
	function fnOpenCommonCodePop(input, codeType){
		// 엔터 이벤트로 호출하는 경우
		if(input === 'Y'){
			fnOpenCodePop({
				codeType : codeType,
				callback : 'fnForeignCurrencyCallback',
				searchStr : $("#txt" + codeType + "Disp").val(),
				erp_emp_seq : '',
				erp_dept_seq : '',
				budget_code : '',
				bizplan_code : '***',
				acct_code : '',
				vat_type : '',
				reflectResultPop : opener.reflectResultPop,
				expendCardOption : '',
				summryDisplayOption : '',
				formSeq : ''
			});
		}else{ // 찾기 버튼으로 호출하는 경우
			fnOpenCodePop({
				codeType : codeType,
				callback : 'fnForeignCurrencyCallback',
				searchStr : '',
				erp_emp_seq : '',
				erp_dept_seq : '',
				budget_code : '',
				bizplan_code : '***',
				acct_code : '',
				vat_type : '',
				reflectResultPop : opener.reflectResultPop,
				expendCardOption : '',
				summryDisplayOption : '',
				formSeq : ''
			});
		}
	}
	
	// 공통코드 콜백함수
	function fnForeignCurrencyCallback(param){
		var type = param.type;
        var target;
		var nowId;
        switch (type) {
	        case expendType.exchangeunit:
            	nowId = 'txtExchangeUnitDisp';
                target = $([ "#txtExchangeUnitDisp", "#hidExchangeUnitInfo" ].join(', '));
                break;
        }

        fnSetExpendDispValue(target, param.obj, type); /* 데이터 바인딩 */
        
        if(type == "exchangeunit"){
        	if(opener.ifSystem == "ERPiU"){
	        	//환율정보 조회
	        	fnSelectExchangeRateInfo();
        	}
        	
        	// 환종코드
        	hidExchangeUnitCode = param.obj.exchangeUnitCode;
        	// 환종명
        	hidExchangeUnitName = param.obj.exchangeUnitName;
        }
        
        fnSetFocus(nowId); /* 포커스 처리 */
	}
	
	// 포커스 이동처리
	function fnSetFocus(nowId) {
        var target = [ 'txtExchangeUnitDisp', 'txtExchangeRate', 'txtForeignCurrencyAmount', 'txtResultAmount' ];
        
		for(var i = 0 ; i < target.length ; i++){
			if(nowId == ''){
				$('#txtExchangeUnitDisp').focus();
			}else if(target[i] == nowId && i < target.length){
				$('#' + target[(i+1)]).focus();
			}
		}
        return;
    }
	
	// 환율정보 조회
	function fnSelectExchangeRateInfo(){
		var param = {};
		if("${ViewBag.type}" == "list"){
			param.authDate = $(opener.document).find("#txtListAuthDate").val().replace(/-/g, '');
		}else{
			param.authDate = $(opener.document).find("#txtSlipAuthDate").val().replace(/-/g, '');
		}
		
		if($("#hidExchangeUnitInfo").val().trim() != ""){
			var exchangeUnitInfo = JSON.parse($("#hidExchangeUnitInfo").val());
			param.exchangeUnitCode = exchangeUnitInfo.exchangeUnitCode;
		}else{
			param.exchangeUnitCode = "";
		}
		
		$.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/user/expend/foreigncurrency/ExchangeRateInfoSelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : param,
	        success : function( data ) {	
	        	var resultExchangeRate = data.aData.resultExchangeRate;
	        	
	        	if(resultExchangeRate != "" || resultExchangeRate != null){
	        		resultExchangeRate = resultExchangeRate.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		        	$("#txtExchangeRate").val(resultExchangeRate);
	        	}
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}
	
	// 금액 자동계산
	function fnCalculateAmt(){
		var exchangeRate = $("#txtExchangeRate").val().replace(/,/g, '');
		var foreignCurrencyAmount = $("#txtForeignCurrencyAmount").val().replace(/,/g, '');
		
		var roundingType = "000"; // 올림구분 값
		var resultAmt; // 계산결과 값
		
		if(opener.ifSystem == "ERPiU"){
			// 올림구분 조회
			roundingType = ERPiURoundingType;
		}
		
		if( exchangeRate !='' && foreignCurrencyAmount !=''){
			
			if((roundingType == "000") || (roundingType == "003")){ // 000: 기본(버림), 003: 버림
				resultAmt = Math.floor(parseFloat(exchangeRate * foreignCurrencyAmount).toFixed(4));
			}else if(roundingType == "001"){ // 반올림
				resultAmt = Math.round(parseFloat(exchangeRate * foreignCurrencyAmount).toFixed(4));
			}else if(roundingType == "002"){ // 올림
				resultAmt = Math.ceil(parseFloat(exchangeRate * foreignCurrencyAmount).toFixed(4));
			}
		}
		
		return resultAmt ||'';
	}
	
	// 올림구분 조회
	function fnSelectRoundingType(){
		$.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/user/expend/foreigncurrency/RoundingTypeInfoSelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : "",
	        success : function( data ) {	
	        	ERPiURoundingType = data.aData.resultRoundingType;
	        	
    			// 수정 시 외화정보 반영
    			fnSetForeignCurrencyInfo(opener.foreignCurrencyInfo);
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}
	
	// iCUBE 환율, 외화금액 소수점 자릿수 조회(iCUBE 시스템 환경설정)
	function fnSelectPointLength(){
		$.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/user/expend/foreigncurrency/PointLengthInfoSelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : "",
	        success : function( data ) {	
	    		// 환율 소수점 자릿수
	    		$("#txtExchangeRate").inputmask({
	    			alias: 'decimal', 
	    	        allowMinus: false,  
	    	        digits: parseInt(data.aData.exchangeRateLength),
	    	        rightAlign: false,
	    	        groupSeparator: ".",
	    	        autoGroup: true,    
	    	        digitsOptional: false
	    		});
	    		
	    		// 외화금액 소수점 자릿수
	    		$("#txtForeignCurrencyAmount").inputmask({
	    			alias: 'decimal', 
	    	        allowMinus: opener.isNegativeAmt,  
	    	        digits: parseInt(data.aData.foreignCurrencyAmountLength),
	    	        rightAlign: false,
	    	        groupSeparator: ".",
	    	        autoGroup: true,    
	    	        digitsOptional: false
	    		});
	    		
    			// 수정 시 외화정보 반영
    			fnSetForeignCurrencyInfo(opener.foreignCurrencyInfo);
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}
	
	// 수정 시 외화정보 반영
	function fnSetForeignCurrencyInfo(data){
		
		if(jQuery.isEmptyObject(data)){
			return;
		}
		
		// 환종
        var target = $([ "#txtExchangeUnitDisp", "#hidExchangeUnitInfo" ].join(', '));
    	fnSetExpendDispValue(target, data, "exchangeunit"); 
    	
    	// 환종코드
    	hidExchangeUnitCode = data.exchangeUnitCode;
    	// 환종명
    	hidExchangeUnitName = data.exchangeUnitName;
    	
    	// 환율
    	$("#txtExchangeRate").val(data.exchangeRate == '0.000000' ? '' : data.exchangeRate);
    	
    	// 외화금액
    	$("#txtForeignCurrencyAmount").val(data.foreignCurrencyAmount == '0.0000' ? '' : data.foreignCurrencyAmount);
    	
    	// 금액
    	var resultAmt = fnCalculateAmt();
		$("#txtResultAmount").val(resultAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	}
	
</script>
