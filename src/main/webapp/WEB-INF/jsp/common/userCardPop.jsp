<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<form id="USER_cardPop" name="frmPop" method="post">
	<input type="hidden" name="value1" value="" id="CMM_HID_VALUE1">
	<input type="hidden" name="callback" value="" id="CMM_HID_CALLBACK">
</form>	

<script>
	
	/*	카드 사용내역 조회 팝업 로직 시작
	-------------------------------------------*/
	function fnOpenCardPop(param) {
	
		/**
			파라미터 검증.
			검증 실패 -> 함수 리턴 ERROR_MSG(text) 
			검증 성공 -> 팝업 호출, 함수 리턴 0(number)
		 */
		var validationResult = CM_FNC_VALIDATOR_CARD(param);
		if (validationResult) {
			return validationResult;
		}
	
		/**
			팝업 파라미터 설정
			파라미터로 부터 전달되어온 값을 서버로 바이패스 준비           
		*/
		CM_FNC_SET_PARAM_CARD(param);
		
		/**
			팝업창 실제 호출
			팝업창의 내용은 파라미터를 통하여 팝업창 내에서 처리됩니다.
		 */
		CM_FNC_CALL_POPUP_CARD(param);
	
		return 0;
	}
	
	/*	로직검증 시작
	-------------------------------------------*/
	function CM_FNC_VALIDATOR_CARD(param) {
		try {
			if (typeof ($) !== 'function') {
				// 제이쿼리 객체 검증
				// throw 'Not found system object';
			} 
		} catch (exMsg) {
			console.log('[ * EXP ] 공통코드 함수호출 오류 : ' + exMsg);
			return exMsg;
		}
		return 0;
	}
	
	/*	파라미터 설정 
	-------------------------------------------*/
	function CM_FNC_SET_PARAM_CARD(param){
		$('#CMM_HID_VALUE1').val('');
		$('#CMM_HID_CALLBACK').val(param.callback);
	}
	
	/*	공통 코드 조회 팝업 호출
	-------------------------------------------*/
	function CM_FNC_CALL_POPUP_CARD(param) {
		// 경로 고정.
		var url = "<c:url value='/ex/card/UserCardUsageHistoryPop.do'/>";
		var pop = window.open("", "UserCardUsageHistoryPop",
				"width=700,height=578,scrollbars=no");
	
		USER_cardPop.target = "UserCardUsageHistoryPop";
		USER_cardPop.method = "post";
		USER_cardPop.action = url;
		USER_cardPop.submit();
		USER_cardPop.target = "";
		pop.focus();
	}

</script>