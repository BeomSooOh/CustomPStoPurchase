<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>


ERP API 호출 테스트 페이지  <br>
<br>
<br>
API 호출 코드(API 키) :  <input type="text" autocomplete="off" id="txtAPIType" value="test"/><br>
API parameter(JSON) : <input type="text" autocomplete="off" id="txtParam" value="{}"/><br>
<input id="btnTestStart" type="button" value="API호출"/>


<div id="div_APIData">
</div>

<script>

$(document).ready(function(){
	$('#btnTestStart').click(function(){
		var param = {
				'param' : $('#txtParam').val()	
				, 'code' : $('#txtAPIType').val()	
			};
		    $.ajax({
		        type : 'post',
		        url : '<c:url value="/expend/np/user/code/ExCodeInfoSelect.do" />',
		        datatype : 'json',
		        async : true,
		        data : param,
		        success : function( data ) {	  
		        	$('#div_APIData').html(JSON.stringify(data));
		        },
		        error : function( data ) {
		            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
		        }
		    });
	});
});

</script>