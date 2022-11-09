<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

법인카드 뭐시기 팝업 ㄱㄱ
<input type="text" autocomplete="off" id="cardTmpSeq" value="" width="200px;" height="100px;"/>
<input type="button" id="btnTest" value="가즈아" width="200px;" height="100px;"/>


<script>



	$(document).ready(function(){
			
		$('#btnTest').click(function(){
			var popup = window.open("../../../expend/np/user/UserCardDetailPop.do?syncId=" + $('#cardTmpSeq').val(), "" , "width=432, height=489 , scrollbars=yes");
		});	
	});

</script>