<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<form id="USER_cmmPop" name="frmPop" method="post">
	<input type="hidden" name="codeType" value="" id="CMM_HID_CODE_TYPE"/>
	<input type="hidden" name="callback" value="" id="CMM_HID_CALLBACK">
	<input type="hidden" name="searchStr" value="" id="CMM_HID_SEARCHSTR">
	<input type="hidden" name="erp_emp_seq" value="" id="CMM_HID_ERP_EMP_SEQ">
	<input type="hidden" name="erp_dept_seq" value="" id="CMM_HID_ERP_DEPT_SEQ">
	<input type="hidden" name="budget_code" value="" id="CMM_HID_BUDGET_CODE">
	<input type="hidden" name="bizplan_code" value="" id="CMM_HID_BIZPLAN_CODE">
	<input type="hidden" name="acct_code" value="" id="CMM_HID_ACCT_CODE">
	<input type="hidden" name="acct_type" value="" id="CMM_HID_ACCT_TYPE">
	<input type="hidden" name="vat_type" value="" id="CMM_HID_VAT_TYPE">
	<input type="hidden" name="reflectResultPop" value="" id="CMM_HID_REFLECTRESULTPOP">
	<input type="hidden" name="expendCardOption" value="" id="CMM_HID_EXPENDCARDOPTION">
	<input type="hidden" name="search_type" value="" id="CMM_HID_SEARCHTYPE">
	<input type="hidden" name="summryDisplayOption" value="" id="CMM_HID_SUMMRYDISPLAYOPTION">
	<input type="hidden" name="formSeq" value="" id="CMM_HID_FORMSEQ">
	<input type="hidden" name="codeSortType" value="" id="CMM_HID_CODESORTTYPE">
</form>	
<script>
	/*	공통코드 조회 팝업 로직 시작
	 -------------------------------------------*/
	function fnOpenCodePop(param) {

		/**
			파라미터 검증.
			검증 실패 -> 함수 리턴 ERROR_MSG(text) 
			검증 성공 -> 팝업 호출, 함수 리턴 0(number)
		 */
		var validationResult = CM_FNC_VALIDATOR(param);
		if (validationResult) {
			return validationResult;
		}

		/**
			팝업 파라미터 설정
			파라미터로 부터 전달되어온 값을 서버로 바이패스 준비           
	 	*/
		CM_FNC_SET_PARAM(param);
		
		/**
			팝업창 실제 호출
			팝업창의 내용은 파라미터를 통하여 팝업창 내에서 처리됩니다.
		 */
		CM_FNC_CALL_POPUP(param);

		return 0;
	}
	
	

	/*	로직검증 시작
	-------------------------------------------*/
	function CM_FNC_VALIDATOR(param) {
		try {
			if (typeof ($) !== 'function') {
				// 제이쿼리 객체 검증
				// throw 'Not found system object';
			} else if (!param) {
				// 파라미터 전달여부 확인
				throw 'Not found parameter object';
			} else if (!param.codeType) {
				// 필수 1. 코드 타입 검증
				throw 'Not found "codeType" field in parameter.';
			} else if (!param.callback) {
				// 필수 2. 콜백 함수 검증
				throw 'Not found "callback" field in parameter.';
			}
		} catch (exMsg) {
			console.log('[ * EXP ] 공통코드 함수호출 오류 : ' + exMsg);
			return exMsg;
		}
		return 0;
	}
	
	/*	파라미터 설정 
	-------------------------------------------*/
	function CM_FNC_SET_PARAM(param){
		$('#CMM_HID_CODE_TYPE').val(param.codeType || '');
		$('#CMM_HID_CALLBACK').val(param.callback || '');
		$('#CMM_HID_VALUE1').val(param.value1 || '');
		$('#CMM_HID_ERP_EMP_SEQ').val(param.erp_emp_seq || '');
		$('#CMM_HID_ERP_DEPT_SEQ').val(param.erp_dept_seq || '');
		$('#CMM_HID_BUDGET_CODE').val(param.budget_code || '');
		$('#CMM_HID_BIZPLAN_CODE').val(param.bizplan_code || '');
		$('#CMM_HID_ACCT_CODE').val(param.acct_code || '');
		$('#CMM_HID_ACCT_TYPE').val(param.acct_type || '');
		$('#CMM_HID_VAT_TYPE').val(param.vat_type || ''); /* 2019.01.16.김상겸. iCUBE 세무구분 */
		$('#CMM_HID_SEARCHSTR').val(param.searchStr || '');
		$('#CMM_HID_REFLECTRESULTPOP').val(param.reflectResultPop || '');
		$('#CMM_HID_EXPENDCARDOPTION').val((param.expendCardOption || false));
		$('#CMM_HID_SEARCHTYPE').val((param.search_type || ''));
		$('#CMM_HID_SUMMRYDISPLAYOPTION').val((param.summryDisplayOption || ''));
		$('#CMM_HID_FORMSEQ').val((param.formSeq || ''));
		$('#CMM_HID_CODESORTTYPE').val((param.codeSortType || ''));
	}
	
	

	/*	공통 코드 조회 팝업 호출
	 -------------------------------------------*/
	function CM_FNC_CALL_POPUP(param) {
		// 경로 고정.
		var popWidth = 475, popHeight = 510; //팝업 창 사이즈

		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winWidth = document.body.clientWidth; // 현재창의 너비
		var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
		var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표 

		var popX = winX + (winWidth - popWidth)/2;
		var popY = winY + (winHeight - popHeight)/2;

		var url = "<c:url value='/ex/expend/code/UserCmmCodePop.do'/>";
		var pop = window.open('', "UserCmmCodePop", "width=" + popWidth + ", height=" + popHeight + ", left=" + popX + ", top=" + popY);

		USER_cmmPop.target = "UserCmmCodePop";
		USER_cmmPop.method = "post";
		USER_cmmPop.action = url;
		USER_cmmPop.submit();
		USER_cmmPop.target = "";
		pop.focus();
	}
</script>

