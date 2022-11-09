<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script>
	//조직도 callback 구현
	function callbackOrgChart(item) {
		var deptInfo = $('#deptInfo').html();
		
		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/systemx/deptInfo.do" />',
			data:{deptSeq:item.seq, gbnOrg:item.gbnOrg},
			datatype:"text",			
			success:function(data){								
				
				$('#deptInfo').html(data);
				
			}
		});
	}
	
	String.prototype.trim = function() {     return this.replace(/(^\s*)|(\s*$)/gi, ""); } 
	
</script>

<div id="orgChartList" style="float:left">
 	<jsp:include page='/systemx/orgChartList.do'>
 		<jsp:param value="${compSeq}" name="compSeq"/>
 	</jsp:include>
</div>
<div style="float:left">
	<div id="deptInfo">
		<jsp:include page='/systemx/deptInfo.do'></jsp:include>
	</div>
</div> 
 



                
  