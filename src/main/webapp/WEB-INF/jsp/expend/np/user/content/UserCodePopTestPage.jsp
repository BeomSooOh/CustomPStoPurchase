<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<br>
code<input type="text" autocomplete="off" id="txtParam" value="budget"/><br>
popupType<input type="text" autocomplete="off" id="txtParam2" value="2"/><br>
param<input type="text" autocomplete="off" id="txtParam3" value='{"searchStr":""}'/><br>
<input type="button" value="팝업 테스트" id="btnTest"/><br>
<br>바로 리턴 된 경우<br>
<div class="pop_sign_wrap" style="width: 650px;height: 450px;">
</div>

<script>

	$(document).ready(function(){
		$('#btnTest').click(function(){
			/*
				공통팝업 호출
				code : 호출하고자 하는 공통코드 구분 코드 입력(예 : Biz, Emp 등)
				popupType : 코드 조회 방식(1 : 코드 직접 호출, 2 : 일반 팝업 호출, 3 : 레이어 팝업 호출)
				param : 공통코드 호출 시 필요한 파라미터 입력(예 : {"name":"홍길동","searchStr":"검색어"})
				callbackFunction : 콜백함수 명칭 (예 : fnCallbackFunction)
			*/
// 			fnCallCommonCodePop({
// 				code : $("#txtParam").val(),
// 				popupType : $("#txtParam2").val(),
// 				param : $("#txtParam3").val(),
// 				callbackFunction : "fnCallbackFunction",
// 			});
			var param = {};
			param.searchStr = '';
			param.erpDivSeq = '1000';
			param.erpMgtSeq = '1000';
			param.erpBudgetSeq = '';
			param.erpGisuDate = '';
			var commonCodeData = [];
			commonCodeData = [{
                "CD_BUDGET": "test",
                "NM_BUDGET": "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트"
            },{
                "CD_BUDGET": "test2",
                "NM_BUDGET": "테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트테스트"
            }];
			fnCallCommonCodePop({
                code: $("#txtParam").val(),
                popupType: $("#txtParam2").val(),
                param: JSON.stringify(param),
                callbackFunction: "fnCallbackFunction",
                dummy: JSON.stringify({})
            });
		});
	});

	function fnCallbackFunction( param ){
		console.log(param);
	}
</script>