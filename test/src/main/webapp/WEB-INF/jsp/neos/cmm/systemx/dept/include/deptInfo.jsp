<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<script>
	function saveDeptInfo() {
		var formData = $("#basicForm").serialize();
		$.ajax({
			type:"post",
			url:"deptInfoSaveProc.do",
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

	function openPopEmpSort() {
		var url = "<c:url value='/cmm/systemx/deptCompSortPop.do'/>";             
        var popup = window.open(url+"?compSeq=${deptMap.compSeq}", "compEmpSortPop", 'toolbar=no, scrollbar=no, width=260, height=150, resizable=no, status=no');
        popup.focus();
	}
</script>
	<div class="demo-section2 k-header">
		<p style="text-align:right"><button id="sortBtn" class="k-button deptBtn">사용자정렬</button></p>
			<form id="basicForm" name="basicForm">
				<input type="hidden" id="deptSeq" name="deptSeq" value="${deptMap.deptSeq}" />
				<input type="hidden" id="groupSeq" name="groupSeq" value="${deptMap.groupSeq}" />
				<input type="hidden" id="bizSeq" name="bizSeq" value="${deptMap.bizSeq}" />
				<input type="hidden" id="compSeq" name="compSeq" value="${deptMap.compSeq}" />
				<input type="hidden" id="parentDeptSeq" name="parentDeptSeq" value="${deptMap.parentDeptSeq}" />
			
                <h4>조직도정보 </h4>
                <ul id="fieldlist">
                     <li>
                        <label for="parentDeptSeq">상위부서</label>
                         ${deptMap.parentDeptName}
                    </li> 
                    <li>
                        <label for="teamYn">부서유형</label>
                        <select id="teamYn" name="teamYn">
                        	<option value="N">부서</option>
                        	<option value="Y" <c:if test="${deptMap.teamYn == 'Y'}">selected</c:if> >팀</option>
                        </select>
                        <input type="checkbox" value="Y" id="virDeptYn" name="virDeptYn" value="${deptMap.virDeptYn}" /> 가상팀
                    </li>
                    <li>
                        <label for="deptSeq">부서코드</label>
                        <input id="deptSeq" name="deptSeq" value="${deptMap.deptSeq}" />
                    </li>
                    <li>
                        <label for="deptName">부서명</label>
                        <input id="deptName" name="deptName" value="${deptMap.deptName}" />
                    </li>
                    <li>
                        <label for="susinYn">수신여부</label>
                        <input type="radio" id="susinYn" name="susinYn" value="Y" checked />수신 <input type="radio" id="susinYn" value="N" <c:if test="${deptMap.susinYn == 'N'}">checked</c:if> />미수신
                    </li>  
                    <li>
                        <label for="zipCode">회사주소</label>
                    	<input id="zipCode" name="zipCode" value="${deptMap.zipCode}" /> <button id="findZip" class="saveBtn">찾기</button>
                        <p><input id="addr" name="addr" value="${deptMap.addr}" /></p>
                        <p><input id="detailAddr" name="detailAddr" value="${deptMap.detailAddr}" /></p>
                    </li> 
                    <li>
                        <label for="useYn">사용여부</label>
                        <input type="radio" id="useYn" name="useYn" value="Y" checked />사용 <input type="radio" id="useYn" value="N" <c:if test="${deptMap.useYn == 'N'}">checked</c:if> />미사용
                    </li>
                    
                    <li>
                        <label for="nativeLangCode">주 사용언어</label>
                        <select id="nativeLangCode" name="nativeLangCode">
                        	<c:forEach items="${langList}" var="list" varStatus="c">
                        		<option value="${list.detailCode}" <c:if test="${deptMap.nativeLangCode == list.detailCode}">selected</c:if> >${list.detailName}</option>
                        	</c:forEach>
                        </select>
                    </li>
                </ul>
                
                <h4>부서인감정보</h4>
                <ul id="fieldlist">
                	<div id="sidebar">
	                <div id="profile" class="widget">
	                    <h3>부서직인</h3>
	                    <div>
	                    	<div>
	                    		<img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_DEPT_STAMP1.path}&fileName=${imgMap.IMG_DEPT_STAMP1.imgFileName}' />" width="71" height="71" />
				                <div class="demo-section k-header">
				                    <input name="IMG_DEPT_STAMP1" class="file_stemp" type="file" />
				                    <input id="IMG_DEPT_STAMP1" type="hidden" value="${imgMap.IMG_DEPT_STAMP1.imgSeq}" />
				                </div>
				            </div>
	                    </div>
	                    
	                    <h3>부서발신명의</h3>
	                    <div>
	                        <img src="<c:url value='/cmm/systemx/orgGetImage.do?path=${imgMap.IMG_DEPT_STAMP2.path}&fileName=${imgMap.IMG_DEPT_STAMP2.imgFileName}' />" width="71" height="71" />
	                        <div class="demo-section k-header">
				                    <input name="IMG_DEPT_STAMP2" class="file_stemp" type="file" />
				                    <input id="IMG_DEPT_STAMP2" type="hidden" value="${imgMap.IMG_DEPT_STAMP2.imgSeq}" />
				            </div>
				            <div>
				            	<input name="senderName" value="${deptMap.senderName}" />
				            </div>
	                    </div>
                	</div>
                </ul>
                </form>
                
                <p style="text-align:center">
	              	<button id="saveDeptInfoBtn" class="k-button deptBtn">저장</button>
	            </p>
                
            </div>

            <script>
                $(document).ready(function() {
                        $(".file_stemp").kendoUpload({
                            async: {
                                saveUrl: '<c:url value="/cmm/systemx/orgUploadImage.do" />',
                                removeUrl: '<c:url value="/cmm/systemx/compRemoveImage.do" />',
                                autoUpload: true
                            },
                            multiple: false,
                            upload:function(e) {
								var inputName =  $(e.sender).attr("name");
								var img_seq = $('#'+inputName).val();
								var dept_seq = '${deptMap.deptSeq}';
                            	e.sender.options.async.saveUrl = '<c:url value="/cmm/systemx/orgUploadImage.do" />'+"?imgSeq=" + img_seq+"&orgSeq="+dept_seq;
                            }

                        });

                        $("#zipCode").kendoMaskedTextBox({
                            mask: "000-000"
                        });
                        

                        function onClick(e) {
                        	var id = $(e.event.target).attr("id");
                        	if (id == 'saveDeptInfoBtn') {
                        		saveDeptInfo();
                        	} else if (id == 'sortBtn') {
                        		openPopEmpSort();
                        	} 
                        }
                        
                        $(".deptBtn").kendoButton({
                    	    click: onClick
                    	}); 

                });
                
            </script>

            <style>
                .demo-section2 {
                    width: 500px;
                } 

                #fieldlist
                {
                    margin:0;
                    padding:0;
                } 

                #fieldlist li
                {
                    list-style:none;
                    padding:10px 0;
                }

                #fieldlist label {
                    display: inline-block; 
                    width: 150px;
                    margin-right: 5px;
                    text-align: right;
                }
                
                #sortPop
		        {
		            min-height:500px;
		        }
		
		        #undo {
		            text-align: center;
		            position: absolute;
		            white-space: nowrap;
		            padding: 1em;
		            cursor: pointer;
		        }
		        .armchair {
		        	float: left;
		        	margin: 30px 30px 120px 30px;
		        	text-align: center;
		        }
		        .armchair img {
		            display: block;
		            margin-bottom: 10px;
		        }
            </style>
        </div>

            
            
</div>
