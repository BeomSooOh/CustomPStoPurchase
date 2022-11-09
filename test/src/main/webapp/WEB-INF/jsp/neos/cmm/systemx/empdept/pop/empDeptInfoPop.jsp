<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<script>
$(document).ready(function() {
															//codeID, name, selectedValue ,  style, fncEvent, firstName, firstValue 
	$("#jobCodeList").html(NeosCodeUtil.getChildCodeSelectFirstName('COM503', 'jobCode', '${infoMap.jobCode}', "", "", "",""));
															
	$("#statusCodeList").html(NeosCodeUtil.getChildCodeSelectFirstName('COM504', 'statusCode', '${infoMap.statusCode}', "", "", "",""));
	  
}); 

function callbackOrgChart(item) {
	var compSeq = '${compSeq}';
	
	if (gbnOrg == 'd') {
		var deptSeq = item.seq;
		
		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/systemx/deptInfoData.do" />',
			data:{compSeq:compSeq, gbnOrg:item.gbnOrg, deptSeq:seq},
			datatype:"json",			
			success:function(data){								
				
				if (data.deptMap) {
					var seq = data.deptMap.deptSeq;
					var name = data.deptMap.deptName;
					var tel = data.deptMap.telNum;
					var zipCode = data.deptMap.zipCode;
					var addr = data.deptMap.addr;
					var detailAddr = data.deptMap.detailAddr;
					
					$("#deptSeqNew").val(seq);
					$("#deptName").val(name);
					$("#telNum").val(tel);
					$("#zipCode").val(zipCode);
					$("#addr").val(addr);
					$("#detailAddr").val(detailAddr);
				}
			}
		});
	}
}

</script> 
	
<div id="example">
	<form id="basicForm" name="basicForm" action="empDeptInfoSaveProc.do" method="post">
        <div class="demo-section k-header">
        	<div id="tickets">
				<input id="groupSeq" name="groupSeq" value="${infoMap.groupSeq}" type="hidden" />
				<input id="compSeq" name="compSeq" value="${infoMap.compSeq}" type="hidden" />
				<input id="bizSeq" name="bizSeq" value="${infoMap.bizSeq}" type="hidden" />
				<input id="empSeq" name="empSeq" value="${infoMap.empSeq}" type="hidden" />
				<input id="empSeq" name="deptSeq" value="${infoMap.deptSeq}" type="hidden" />
				 
				<div class="fLeft" style="width:30%">
					<h3>겸직부서 선택</h3>
		            <jsp:include page='/systemx/orgChartList.do'>
		            	 <jsp:param name="compSeq" value='<%=request.getParameter("compSeq")%>' /> 
		            </jsp:include> 
				</div>   
				  
				<div class="fLeft" style="width:60%;padding-left:30px">				 
	                <h4>기본정보 </h4>   
	                <ul id="fieldlist">  
	                    <li> 
	                        <label for="positionCode">직급</label>
	                        <select id="positionCode" name="positionCode">
							 	<option value="">선택</option>
							 	<c:forEach items="${positionList}" var="list">
							 		<option value="${list.dpSeq}" <c:if test="${list.dpSeq == infoMap.deptPositionCode}">selected</c:if> >${list.dpName}</option>
							 	</c:forEach>
							</select>
	                    </li>
	                    <li> 
	                        <label for="dutyCode">직책</label>
	                        <select id="dutyCode" name="dutyCode">
								<option value="">선택</option>
								<c:forEach items="${dutyList}" var="list">
							 		<option value="${list.dpSeq}" <c:if test="${list.dpSeq == infoMap.deptDutyCode}">selected</c:if> >${list.dpName}</option>
							 	</c:forEach>
							</select>
	                    </li>
	                    <li>  
	                        <label for="deptSeqNew">겸직부서</label>
	                        <input id="deptName" value="${infoMap.deptName}" />
	                        <input id="deptSeqNew" name="deptSeqNew" type="hidden" value="${infoMap.deptSeq}" />
	                    </li>
	                    <li> 
	                        <label for="telNum">전화번호(회사)</label>
	                        <input id="telNum" name="telNum" value="${infoMap.telNum}" />
	                    </li>
	                    <li>
	                        <label for="zipCode">회사주소</label>
	                    	<input id="zipCode" name="zipCode" value="${infoMap.deptZipCode}" /> <button id="findZip" class="saveBtn">찾기</button>
	                        <p><input id="addr" name="addr" value="${infoMap.deptAddr}" /></p>
	                        <p><input id="detailAddr" name="detailAddr" value="${infoMap.deptDetailAddr}" /></p>
	                    </li> 
	                    
	                <h4>그룹웨어 설정정보</h4>
	                <ul id="fieldlist">
	                    <li> 
	                        <label for="orgchartDisplayYn">조직도표시여부</label>
	                        <input type="radio" id="orgchartDisplayYn" name="orgchartDisplayYn" value="Y" checked />사용 <input type="radio" name="orgchartDisplayYn" value="N" <c:if test="${infoMap.orgchartDisplayYn == 'N'}">checked</c:if> />미사용
	                        
	                    </li> 
	                    <li> 
	                        <label for="messengerDisplayYn">메신저표시여부</label>
	                        <input type="radio" id="messengerDisplayYn" name="messengerDisplayYn" value="Y" checked />사용 <input type="radio" name="messengerDisplayYn" value="N" <c:if test="${infoMap.messengerDisplayYn == 'N'}">checked</c:if> />미사용
	                    </li>
	                </ul>
		        <div> 
		            <button class="k-button k-primary saveBtn" type="button">저장</button> <button class="k-button k-primary cancelBtn" type="button">취소</button>
			    </div> 
                </div>
            </div>
        </div>
    </form>
            <script>
	            $(document).ready(function() {
	            	
	            	$(".cancelBtn").kendoButton({
		       			 click: function(e) {
		       				
		       				window.close();
		       			 }
		       		 }); 
	            	
	            	$(".saveBtn").kendoButton({
		       			 click: function(e) {
		       				var empSeq = $("#empSeq").val();
		       				if (empSeq != null && empSeq != '') {
								document.basicForm.submit();	       					
		       				} else {
		       					$("#deptSeq_1", opener.document).val($("#deptSeqNew").val());
		       					$("#positionCode", opener.document).val($("#positionCode").val());
		       					$("#dutyCode", opener.document).val($("#dutyCode").val());
		       					$("#deptName_1", opener.document).val($("#deptName").val());
		       					$("#telNum", opener.document).val($("#telNum").val());
		       					$("#deptZipCode", opener.document).val($("#zipCode").val());
		       					$("#deptAddr", opener.document).val($("#addr").val());
		       					$("#deptDetailAddr", opener.document).val($("#detailAddr").val());
		       					
		       					var orgchartDisplayYn = $("input[name=orgchartDisplayYn]:checked").val();
		       					$("input[name=orgchartDisplayYn][value=" + orgchartDisplayYn + "]", opener.document).attr("checked", true);
		       					
		       					var orgchartDisplayYn = $("input[name=messengerDisplayYn]:checked").val();
		       					$("input[name=messengerDisplayYn][value=" + orgchartDisplayYn + "]", opener.document).attr("checked", true);
		       						       					
			       				window.close();
		       				}
		       				 
		       			 }
		       		 }); 
	            	
	            	var validator = $("#basicForm").kendoValidator().data("kendoValidator");
	            	
	            	 $("basicForm").submit(function(event) {
	                        event.preventDefault();
	                        if (validator.validate()) {
	                            status.text("Hooray! Your tickets has been booked!")
	                                .removeClass("invalid")
	                                .addClass("valid");
	                        } else {
	                            status.text("Oops! There is invalid data in the form.")
	                                .removeClass("valid")
	                                .addClass("invalid");
	                        }
	                    });
	            });
	            
            </script>
			
			<style>
                #fieldlist {
                    margin: 0;
                    padding: 0;
                }

                #fieldlist li {
                    list-style: none;
                    padding-bottom: .7em;
                    text-align: left;
                }

                #fieldlist label {
                    display: block;
                    padding-bottom: .3em;
                    font-weight: bold;
                    text-transform: uppercase;
                    font-size: 12px;
                    color: #444;
                }

                #fieldlist li.status {
                    text-align: center;
                }

                #fieldlist li .k-widget:not(.k-tooltip),
                #fieldlist li .k-textbox {
                    margin: 0 5px 5px 0;
                }

                .confirm {
                    padding-top: 1em;
                }

                .valid {
                    color: green;
                }

                .invalid {
                    color: red;
                }

                #fieldlist li input[type="checkbox"] {
                    margin: 0 5px 0 0;
                }

                span.k-widget.k-tooltip-validation {
                    display; inline-block;
                    width: 160px;
                    text-align: left;
                    border: 0;
                    padding: 0;
                    margin: 0;
                    background: none;
                    box-shadow: none;
                    color: red;
                }

                .k-tooltip-validation .k-warning {
                    display: none;
                }

                 .fLeft {  
                	float:left; 
                }
            </style>

</div>
            
            
            
       
