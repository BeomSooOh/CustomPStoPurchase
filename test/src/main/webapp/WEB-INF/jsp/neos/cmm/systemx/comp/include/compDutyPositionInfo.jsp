<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<script>
function compDpSave() {
	var formData = $("#basicForm").serialize();
	$.ajax({
		type:"post",
		url:"compDutyPositionSaveProc.do",
		datatype:"text",
		data: formData,
		success:function(data){
			alert(data.result);
		},			
		error : function(e){	//error : function(xhr, status, error) {
			alert("error");	
		}
	});	
}
	
</script>




	<div class="demo-section2 k-header">
			<div>
				<form id="basicForm" name="basicForm">
					<input id="compSeq" name="compSeq" value="${compDpMap.compSeq}" type="hidden" />
					<input id="dpType" name="dpType" value="${compDpMap.dpType}" type="hidden" />
                <ul id="fieldlist">
                    <li>
                        <label for="dpSeq">직급코드</label>
                        <input id="dpSeq" name="dpSeq" value="${compDpMap.dpSeq}" type="hidden" /> ${compDpMap.dpSeq}
                    </li> 
                     <li>
                        <label for="dpName">직급명</label>
                        <input id="dpName" name="dpName" value="${compDpMap.dpName}" />
                    </li>
                    <li>
                        <label for="useYn">사용여부</label>
                        <input type="radio" name="useYn" value="Y" checked />사용 <input type="radio" name="useYn" value="N" <c:if test="${compDpMap.useYn == 'N'}">checked</c:if> />미사용
                    </li>  
                    <li>
                        <label for="compName">적용범위</label>
                        ${compMap.compName}
                    </li>
                    <li>
                        <label for="descText">설명</label>
                        <input id="descText" name="descText" value="${compDpMap.descText}" />
                    </li>
                    <li>
                        <label for="commentText">비고</label>
                        <input id="commentText" name="commentText" value="${compDpMap.commentText}" /> 
                    </li>
                </ul>
                
                </form>
                <p style="text-align:center">
	              		<button type="button" id="saveBtn" class="saveBtn" onclick="compDpSave()">저장</button>
	            </p>
                
            </div>
        </div>

