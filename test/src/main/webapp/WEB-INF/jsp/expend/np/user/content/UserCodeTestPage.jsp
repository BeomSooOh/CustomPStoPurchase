<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>


ERP 코드 테스트 페이지 

양식 코드 결과 확인<br>
코드 타입<input type="text" autocomplete="off" id="txtCodeType" value="test"/><br>
<input type="button" value="코드 테스트" id="btnTestStart"/><br>
<br>
양식 코드 데이터 결과<br>
<div id="div_codeData">
</div>

<script>

$(document).ready(function(){
	$('#btnTestStart').click(function(){
		var param = {
				'searchStr' : ''	
				, 'code' : $('#txtCodeType').val()	
			};
		    $.ajax({
		        type : 'post',
		        url : '<c:url value="/expend/np/user/code/ExCodeInfoSelect.do" />',
		        datatype : 'json',
		        async : true,
		        data : param,
		        success : function( data ) {	  
		        	$('#div_codeData').html(JSON.stringify(data));
		        },
		        error : function( data ) {
		            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
		        }
		    });
	});
});

</script>