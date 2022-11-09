<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>


<form id="USER_cmmPop" name="frmPop" method="post">
	<input type="hidden" name="formSeq" id="paramFormId" value="1"/>
	<input type="hidden" name="mode" id="paramMode" value="1"/>
</form>	

품의 결의 코드 테스트 페이지
<br>
양식 아이디 : <input type="text" autocomplete="off" id="txtFormId" value=""/><br>
비영리 결재 테스트 <br>
&nbsp;&nbsp;&nbsp; 품의서 : 29<br>
&nbsp;&nbsp;&nbsp; 결의서 : 30<br>
<br>
영리 결재 테스트<br>
&nbsp;&nbsp;&nbsp; 품의서 : 10202<br>
&nbsp;&nbsp;&nbsp; 결의서 : 10201<br>
<br>
 <input type="button" value="품의/결의 테스트" id="btnTestStart"/>

<script>
	$('#btnTestStart').click(function(){
		var formId = $('#txtFormId').val();
		var mode = $('#txtMode').val();
		$('#paramFormId').val(formId);
		$('#paramMode').val(mode);
		
		var url = "<c:url value='/expend/np/user/NpUserCRDocPop.do'/>";
		window.open('', "UserCmmCodePop", "width=" + 900 + ", height=" + 900 + ", left=" + 150 + ", top=" + 150);
		
		USER_cmmPop.target = "UserCmmCodePop";
		USER_cmmPop.method = "post";
		USER_cmmPop.action = url;
		USER_cmmPop.submit();
		USER_cmmPop.target = "";
		pop.focus();
	});
</script>

