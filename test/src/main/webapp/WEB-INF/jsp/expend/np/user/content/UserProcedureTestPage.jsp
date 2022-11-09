<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>


프로시저 호출 가즈아~! 
<input type="button" id="btnTest" value="가즈아" width="200px;" height="100px;"/>
<script>

$(document).ready(function(){
	
	$('#btnTest').click(function(){
		var param = {
				'procType' : 'GISU_LIST'	
				, 'erpCompSeq' : '7070'
				, 'gisu' : '4'
		};
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/user/code/ExProcDataSelect.do' />",
			datatype : "json",
			success : function(result) {
				console.log(result);
			},
			error : function(err) {
				console.log(err);
			}
		});
	});
});

</script>