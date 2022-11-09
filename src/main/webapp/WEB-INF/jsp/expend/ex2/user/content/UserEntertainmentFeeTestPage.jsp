<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>


<div class='sub_contents'>
	<input type="button" value="테스트 ㄱㄱ" id="btnTest" />
</div>

<script>
	$(document).ready(function() {

		$('#btnTest').click(function() {
			// alert('zz?');
			window.open("/exp/expend/ex/user/userEntertainmentFee.do?feeSeq=&callback=callBackFunction");

		});
	});
	
	function callBackFunction(param){
		console.log(param);
	}
</script>