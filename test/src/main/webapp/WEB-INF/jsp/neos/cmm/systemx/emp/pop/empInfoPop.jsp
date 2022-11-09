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
	
	 $("#jobCode").kendoDropDownList();
     $("#statusCode").kendoDropDownList();
	   
}); 

function empDeptInfoPop(compSeq, deptSeq, empSeq) {
	 var url = "empDeptInfoPop.do?compSeq=" + compSeq + "&deptSeq="+deptSeq + "&empSeq="+empSeq;
	 var pop = window.open(url, "empDeptInfoPop", "width=800,height=800,scrollbars=yes");
	 pop.focus();
}

function removeEmpDept(compSeq, deptSeq, empSeq) {
	 $.ajax({
			type:"post",
			url:"empDeptRemoveProc.do",
			datatype:"text",
			data: {compSeq:compSeq, deptSeq:deptSeq, empSeq:empSeq},
			success:function(data){
				var result = data.result;
				
				alert(data.msg);
				
				if (result == true) {
					
				} else {
					
				}
			},			
			error : function(e){	//error : function(xhr, status, error) {
				alert("error");	
			}
		});	  
}

</script> 
	
<div id="example">
	<form id="basicForm" name="basicForm" action="empInfoSaveProc.do" method="post">
        <div class="demo-section k-header">
        <div id="tickets">
				 <input id="groupSeq" name="groupSeq" value="${infoMap.groupSeq}" type="hidden" />
				 <input id="compSeq" name="compSeq" value="${infoMap.compSeq}" type="hidden" />
				 <input id="empSeq" name="empSeq" value="${infoMap.empSeq}" type="hidden" />
				 
				<div class="fLeft" style="width:30%">
					 <h3>사진등록</h3>
		            <div>
		            	<div>
		            		<img id="img_picFileIdNew" src="<c:url value='/cmm/systemx/attachGetImage.do?fileId=${infoMap.picFileId}&fileSn=0' />" width="150" height="150" />
					        <div class="demo-section k-header">
					            <input name="picFileIdNew" class="file_upload" type="file" />
					            <input id="picFileIdNew" name="picFileId" type="hidden" value="${infoMap.picFileId}" />
					        </div>
					    </div>
		            </div>
		            
		            <h3>서명등록</h3>  
		            <div>
		            	<div>
		            		<img id="img_signFileIdNew" src="<c:url value='/cmm/systemx/attachGetImage.do?fileId=${infoMap.signFileId}&fileSn=0' />" width="150" height="150" />
					        <div class="demo-section k-header">
					            <input name="signFileIdNew" class="file_upload" type="file" /> 
					            <input id="signFileIdNew" name="signFileId" type="hidden" value="${infoMap.signFileId}" />
					        </div>
					    </div>
		            </div>
				</div>
				<div class="fLeft" style="width:60%;padding-left:30px">				 
	                <h4>회사기본정보 </h4>  
	                <ul id="fieldlist">  
	                    <li>
	                        <label for="compSeq">회사선택</label> ${infoMap.compName}
	                    </li> 
	                    <li>
	                        <label for="useYn">사용여부</label>
	                        <input type="radio" id="useYn" name="useYn" value="Y" checked />사용 <input type="radio" id="useYn" value="N" <c:if test="${infoMap.useYn == 'N'}">checked</c:if> />미사용
	                    </li>  
	                        <label for="loginId">아이디</label>
	                        <input class="k-textbox" id="loginId" name="loginId" value="${infoMap.loginId}" />
	                    </li> 
	                    <li>
	                        <label for="emailAddr">메일아이디</label>
	                        <input class="k-textbox" id="emailAddr" name="emailAddr" value="${infoMap.emailAddr}" />
	                    </li>
	                    <li>
	                        <label for="empName">이름</label>
	                        <input class="k-textbox" id="empName" name="empName" value="${infoMap.empName}" />
	                    </li>
	                    <li>
	                        <label for="loginPasswdNew">비밀번호</label>
	                        <input class="k-textbox" id="loginPasswdNew" name="loginPasswdNew" value="" /> 
	                        <input type="hidden" name="loginPasswd" value="${infoMap.loginPasswd}" /> 
	                    </li>
	                    <li>
	                        <label for="payPasswdNew">급여 비밀번호</label>
	                        <input class="k-textbox" id="payPasswdNew" name="payPasswdNew" value="" /> 
	                        <input type="hidden" name="payPasswd" value="${infoMap.payPasswd}" /> 
	                    </li>
	                    <li>
	                        <label for="apprPasswdNew">결재 비밀번호</label>
	                        <input class="k-textbox" id="apprPasswdNew" name="apprPasswdNew" value="" />
	                         <input type="hidden" name="apprPasswd" value="${infoMap.apprPasswd}" /> 
	                    </li>
	                    <li>
	                        <label for="genderCode">성별</label>
	                        <input type="radio" id="genderCode" name="genderCode" value="F" checked />여자 <input type="radio" name="genderCode" value="M" <c:if test="${infoMap.genderCode == ''}">checked</c:if> />남자
	                    </li>
	                    
	                     <li>
	                        <label for="mainWork">담당업무</label>
	                        <input class="k-textbox" id="mainWork" name="mainWork" value="${infoMap.mainWork}" />
	                    </li>
	                    
	                    <%-- <li>  
	                        <label for="deptSeq">부서</label>
	                        <input id="deptName" value="${infoMap.deptName}" />
	                        <input id="deptSeq" name="deptSeq" type="hidden" value="${infoMap.deptSeq}" />
	                        <button id="findDept" class="k-primary">찾기</button>
	                    </li> --%> 
	                    <li> 
	                        <label for="">겸직부서</label>
	                        <ul>
	                        	<c:set var="dLng" value="${fn:length(empInfoList)}" />
		                        <c:forEach items="${empInfoList}" var="list" varStatus="c">	
									<li> 
										(겸직부서${c.count})
				                        <input class="k-textbox" id="deptName_${c.count}" value="${list.deptName}" style="width:150px" />
				                        <input id="deptSeq_${c.count}" name="deptSeq" type="hidden" value="${list.deptSeq}" />
				                        <button class="k-primary deptInfoBtn" value="${list.deptSeq}" type="button">정보확인</button>
				                        <button class="k-primary removeDeptBtn" type="button">삭제</button>
			                        </li>
		                        </c:forEach> 
		                        	<li> 
		                        		(겸직부서${dLng+1})
				                        <input class="k-textbox" id="deptName_${dLng+1}" value="" style="width:150px" />
				                        <input id="deptSeq_${dLng+1}" name="deptSeq" type="hidden" value="" />
				                        <button class="k-primary findDeptBtn" type="button">찾기</button>
			                        </li>
	                        </ul>
	                    </li>
	                    
	                    <li> 
	                        <label for="positionCode">직급</label>
	                        <select id="positionCode" name="positionCode">
							 	<option value="">선택</option>
							 	<c:forEach items="${positionList}" var="list">
							 		<option value="${list.dpSeq}" <c:if test="${list.dpSeq == infoMap.positionCode}">selected</c:if> >${list.dpName}</option>
							 	</c:forEach>
							</select>
	                    </li>
	                    <li> 
	                        <label for="dutyCode">직책</label>
	                        <select id="dutyCode" name="dutyCode">
								<option value="">선택</option>
								<c:forEach items="${dutyList}" var="list">
							 		<option value="${list.dpSeq}" <c:if test="${list.dpSeq == infoMap.dutyCode}">selected</c:if> >${list.dpName}</option>
							 	</c:forEach>
							</select>
	                    </li>
	                    
	                    <li> 
	                        <label for="mobileTelNum">휴대전화</label>
	                        <input class="k-textbox" id="mobileTelNum" name="mobileTelNum" value="${infoMap.mobileTelNum}" />
	                    </li>
	                    <li> 
	                        <label for="faxNum">팩스번호</label>
	                        <input class="k-textbox" id="faxNum" name="faxNum" value="${infoMap.faxNum}" />
	                    </li>
	                    <li> 
	                        <label for="homeTelNum">전화번호(집)</label>
	                        <input class="k-textbox" id="homeTelNum" name="homeTelNum" value="${infoMap.homeTelNum}" />
	                    </li>
	                    <li> 
	                        <label for="telNum">전화번호(회사)</label>
	                        <input class="k-textbox" id="telNum" name="telNum" value="${infoMap.telNum}" />
	                    </li>
	                    <li>
	                        <label for="zipCode">집주소</label>
	                    	<input class="k-textbox" id="zipCode" name="zipCode" value="${infoMap.zipCode}" /> <button id="findZip" class="saveBtn">찾기</button>
	                        <p><input class="k-textbox" id="addr" name="addr" value="${infoMap.addr}" /></p>
	                        <p><input class="k-textbox" id="detailAddr" name="detailAddr" value="${infoMap.detailAddr}" /></p>
	                    </li> 
	                    
	                    <li>
	                        <label for="deptZipCode">회사주소</label>
	                    	<input class="k-textbox" id="deptZipCode" name="deptZipCode" value="${infoMap.deptZipCode}" /> <button id="findZip" class="saveBtn">찾기</button>
	                        <p><input class="k-textbox" id="deptAddr" name="deptAddr" value="${infoMap.deptAddr}" /></p>
	                        <p><input class="k-textbox" id="deptDetailAddr" name="deptDetailAddr" value="${infoMap.deptDetailAddr}" /></p>
	                    </li> 
	                    
	                    <li>
	                        <label for="weddingDay">결혼기념일</label>
	                        <select id="weddingYn" name="weddingYn">
							 	<option value="N">미혼</option>
							 	<option value="Y" <c:if test="${'Y' == infoMap.weddingYn}">selected</c:if> >기혼</option>
							</select>
	                        <input class="k-textbox" id="weddingDay" name="weddingDay" value="${infoMap.weddingDay}" />
	                    </li>
	                    <li>
	                        <label for="bday">생년월일</label>
	                        <select id="lunarYn" name="lunarYn">
							 	<option value="Y" >양력</option>
							 	<option value="N" <c:if test="${'N' == infoMap.lunarYn}">selected</c:if>  >음력</option>
							</select>
	                        <input class="k-textbox" id="bday" name="bday" value="${infoMap.bday}" />
	                    </li>
	                </ul>
	                
	                <h4>권한정보</h4>
	                <div id="authGrid">
	                
	                </div>
	                
	                <h4>근무정보</h4>
	                <ul id="fieldlist">
	                	<li>
	                        <label for="">근태적용여부</label> 
	                        <input type="radio" id="" name="" value="Y" checked />적용 <input type="radio" id="" value="N" <c:if test="${infoMap.useYn == 'N'}">checked</c:if> />미적용
	                    </li>
	                    <li>
	                        <label for="">재직여부</label>
	                        <input type="radio" name="workStatus" value="999" checked> 재직
	                        <input type="radio" name="workStatus" value="001" <c:if test="${infoMap.workStatus == '001'}">checked</c:if> > 퇴직
	                        <input type="radio" name="workStatus" value="004" <c:if test="${infoMap.workStatus == '004'}">checked</c:if> > 휴직
	                    </li>
	                    
	                    <li> 
	                        <label for="jobCode">직무유형</label>
	                        <div id="jobCodeList"></div>
	                        <%-- <input id="jobCode" name="jobCode" value="${infoMap.jobCode}" /> --%>
	                    </li>
	                    <li> 
	                        <label for="statusCode">고용형태</label>
	                        <div id="statusCodeList"></div>
	                        <%-- <input id="statusCode" name="statusCode" value="${infoMap.statusCode}" /> --%>
	                    </li>
	                    <li> 
	                        <label for="joinDay">입사일</label>
	                        <input id="joinDay" name="joinDay" value="${infoMap.joinDay}" />
	                    </li>
	                    <li> 
	                        <label for="resignDay">퇴사일</label>
	                        <input id="resignDay" name="resignDay" value="${infoMap.resignDay}" />
	                    </li>
	                    <!-- <li> 
	                        <label for="">근무조</label>
	                        <input id="" name="" value="" />
	                    </li> -->
	                    <!-- <li> 
	                        <label for="">연차설정</label>
	                        <input id="" name="" value="" />
	                    </li> -->
	                  </ul>
	                  
	                <h4>그룹웨어 설정정보</h4>
	                <ul id="fieldlist">
	                	
	                  
	                    <li> 
	                        <label for="erpEmpNum">ERP 사번</label>
	                        <input class="k-textbox" id="erpEmpNum" name="erpEmpNum" value="${infoMap.erpEmpNum}" />찾기
	                    </li>
	                    
	                    <li> 
	                        <label for="nativeLangCode">주사용언어</label>
	                        <select id="nativeLangCode" name="nativeLangCode">
							 	<option value="">선택</option>
							 	<c:forEach items="${langList}" var="list">
							 		<option value="${list.detailCode}" <c:if test="${list.detailCode == infoMap.nativeLangCode}">selected</c:if> >${list.detailName}</option>
							 	</c:forEach>
							</select>  
	                    </li>
	                    <li> 
	                        <label for="mobileUseYn">모바일사용여부</label>
	                        <input type="radio" id="mobileUseYn" name="mobileUseYn" value="Y" checked />사용 <input type="radio" name="mobileUseYn" value="N" <c:if test="${infoMap.mobileUseYn == 'N'}">checked</c:if> />미사용
	                    </li>
	                    <li> 
	                        <label for="messengerUseYn">메신저사용여부</label>
	                        <input type="radio" id="messengerUseYn" name="messengerUseYn" value="Y" checked />사용 <input type="radio" name="messengerUseYn" value="N" <c:if test="${infoMap.messengerUseYn == 'N'}">checked</c:if> />미사용
	                         
	                    </li>
	                    <li> 
	                        <label for="orgchartDisplayYn">조직도표시여부</label>
	                        <input type="radio" id="orgchartDisplayYn" name="orgchartDisplayYn" value="Y" checked />사용 <input type="radio" name="orgchartDisplayYn" value="N" <c:if test="${infoMap.orgchartDisplayYn == 'N'}">checked</c:if> />미사용
	                        
	                    </li> 
	                    <li> 
	                        <label for="messengerDisplayYn">메신저표시여부</label>
	                        <input type="radio" id="messengerDisplayYn" name="messengerDisplayYn" value="Y" checked />사용 <input type="radio" name="messengerDisplayYn" value="N" <c:if test="${infoMap.messengerDisplayYn == 'N'}">checked</c:if> />미사용
	                        
	                    </li>
	                </ul>
                </div>
            </div>
            </div>
            <div style="width:100%;text-align:center"> 
                <li class="confirm">
                        <button class="k-button k-primary" type="submit">Submit</button>
                </li>
	         </div> 
                </form>
            <script>
	            $(document).ready(function() {
	            	$(".findDeptBtn").kendoButton({
		       			 click: function(e) {
		       				var compSeq = $("#compSeq").val();
		       				var empSeq = $("#empSeq").val(); 
		       				empDeptInfoPop(compSeq,'',empSeq);
		       			 }
		       		 });
	            	$(".deptInfoBtn").kendoButton({
		       			 click: function(e) {
		       				var compSeq = $("#compSeq").val();
		       				var empSeq = $("#empSeq").val();
		       				var deptSeq = e.event.target.value;
		       				empDeptInfoPop(compSeq, deptSeq, empSeq);
		       			 }
		       		 });
	            	
	            	$(".removeDeptBtn").kendoButton({
		       			 click: function(e) {
		       				var compSeq = $("#compSeq").val();
		       				var empSeq = $("#empSeq").val();
		       				var deptSeq = e.event.target.value;
		       				var con = confirm("겸직정보를 삭제하시겠습니까?");
		       				if (con) {
		       					removeEmpDept(compSeq, deptSeq, empSeq);
		       				}
		       			 }
		       		 });
	            	
	            	var validator = $("#basicForm").kendoValidator().data("kendoValidator");
	            	
	            	$(".file_upload").kendoUpload({
                        async: {
                            saveUrl: '<c:url value="/cmm/systemx/insertFileUpload.do" />',
                            removeUrl: '<c:url value="/cmm/systemx/compRemoveImage.do" />',
                            autoUpload: true
                        },
                        multiple: false,
                        upload:function(e) {
							var inputName =  $(e.sender).attr("name");
							var fileType = "";
							if (inputName.indexOf("pic") != -1) {
								fileType = "photo";
							} else if (inputName.indexOf("sign") != -1) {
								fileType = "sign";
							}
							
                        	e.sender.options.async.saveUrl = '<c:url value="/cmm/systemx/insertFileUpload.do" />'+"?fileType="+fileType;
                        },
                        success: onSuccess

                    });
	            	
	            	function onSuccess(e) {
						if (e.operation == "upload") {
							var fileId = e.response.fileId;
							var name = e.sender.name;
							$("#"+name).val(fileId);
							
							$("#img_"+name).attr("src",'<c:url value="/cmm/systemx/attachGetImage.do" />?fileId='+fileId+"&fileSn=0");
							
						}
	            	}
	            	
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

	            	  
	            	 $("#bday").kendoDatePicker({format: "yyyy-MM-dd"});
	            	 $("#weddingDay").kendoDatePicker({format: "yyyy-MM-dd"});
	            	 $("#joinDay").kendoDatePicker({format: "yyyy-MM-dd"});
	            	 $("#resignDay").kendoDatePicker({format: "yyyy-MM-dd"});
	
	            });
	            
	            
	       var dataSource = new kendo.data.DataSource({
	            	data : ${authList},
	                batch: true,
	                schema: {
	                    model: {
	                        id: "authorCode",
	                        fields: {
	                        	authorNm: { editable: false, nullable: true },
	                        	codeType: { editable: false, nullable: true },
	                        	authorBaseYn: { editable: false, nullable: true, type: "number", validation: { min: 0, required: true } }
	                        }
	                    }
	                   
	                }
	        });

	        $("#authGrid").kendoGrid({
	            dataSource: dataSource,
	            pageable: false,
	            columns: [  
	                { field: "authorNm", title: "권한명", width: "180px" },
	                { field: "codeTypeName", title:"권한구분", width: "120px"},
	                { field: "authorBaseYn", title:"기본부여여부", width: "120px", template: "#= authorBaseYn ? '예' : '-' #"  }], 
	            refresh:true
	        });
	        
	        $("#dutyCode").kendoDropDownList();
	        $("#positionCode").kendoDropDownList();
	        $("#weddingYn").kendoDropDownList();
	        $("#lunarYn").kendoDropDownList();
	        $("#nativeLangCode").kendoDropDownList();
	        
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
            
            
            
       
