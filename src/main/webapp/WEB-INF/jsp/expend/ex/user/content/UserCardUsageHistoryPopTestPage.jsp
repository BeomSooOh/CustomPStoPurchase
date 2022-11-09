<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>



<input type="button" onclick="javascript:btnClick();" value="카드 팝업 호출"/>
<br>

<jsp:include page="../../../../common/userCardPop.jsp" flush="false" />
<script>

/*	[document] 공통코드 선택업 테스트 페이지 준비
 -------------------------------------------------- */
$(document).ready(function(){
	
});

function btnClick(){
	var resultCode = fnOpenCardPop({
		callback : 'callbackFunc'
	});
	
	if(parseInt(resultCode) != 0){
		alert(resultCode);
	}
}

function callback(result){
	alert(JSON.stringify(result));
}

</script>