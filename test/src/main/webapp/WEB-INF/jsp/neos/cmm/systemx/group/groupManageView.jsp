<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

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
                
                
            </style>


<form id="form" name="form" action="groupManageSaveProc.do" method="post">

	<div id="example">
		<div class="demo-section k-header">
			<h2>그룹정보관리</h2>
				<div>
		
	                <h4>그룹기본정보 </h4>
	                <ul id="fieldlist">
	                    <li>
	                        <label for="groupSeq">그룹코드</label>
	                        <input type="hidden" id="groupSeq" name="groupSeq"  value="${groupMap.groupSeq}" />${groupMap.groupSeq}
	                    </li>
	                    <li>
	                        <label for="setupVersion">그룹웨어 셋업 버전</label>
	                        ${groupMap.setupVersion}
	                    <li>
	                        <label for="groupName">그룹명</label>
	                        <input id="groupName" name="groupName" value="${groupMap.groupName}" />
	                    </li>
	               </ul>
	               
	               <h4>그룹업로드절대경로</h4>
	               <div id="tabstrip">
              		<ul>
	                  <li class="k-state-active" id="linux">
	                      리눅스
	                  </li>
	                  <li id="windows">
	                      윈도우
	                  </li>
	               	</ul>
	               </div>	
	               	<div id="grid"></div>
	               	
	               	
	               <h4>서버정보설정 - 알림 API </h4>
	               <ul id="fieldlist">
	                    <li>
	                        <label for="messengerUrl">메신저</label>
	                        <input id="messengerUrl" name="messengerUrl" value="${groupMap.messengerUrl}" /> 
	                    </li>
	                    <li>
	                        <label for="mailUrl">메일</label>
	                        <input id="mailUrl" name="mailUrl" value="${groupMap.mailUrl}" />
	                    </li>
	                     <li>
	                        <label for="smsUrl">SMS</label>
	                        <input id="smsUrl" name="smsUrl" value="${groupMap.smsUrl}" />
	                    </li>
	                    <li>
	                    	<!-- 변경 불가 정보 -->
	                        <label for="mobileUrl">모바일 PUSH</label> ${groupMap.mobileUrl}
	                    </li>
	               </ul>     
	               
	               
	               <h4>SMS연동정보</h4>
	               <ul id="fieldlist">    
	                    <li>
	                        <label for="smsUseYn">SMS연동정보</label>
	                        <c:if test="${not empty groupMap.sms_use_yn}">
	                        	<input id="smsUse_yn" name="smsUseYn" value="${groupMap.smsUseYn}" />
	                        </c:if>
	                        <c:if test="${empty groupMap.smsUseYn}">
	                        	미연동
	                        </c:if>
	                    </li>
	                    
	                </ul>
	                
	                <p style="text-align:center">
	               		<button id="saveBtn">저장</button>
	                </p>
	            </div>
		</div>
	</div>

</form>


<script>
	var osType = "linux";

	$(document).ready(function() {
           var dataSource = new kendo.data.DataSource({
                transport: {
                    read:  {
                        url: 'groupPathData.do',
                        dataType: "jsonp"
                    },
                    update: {
                        url: 'groupPathSaveProc.do',
                        dataType: "jsonp",
                        type:"POST"
                    },
                    parameterMap: function(options, operation) {
                        options.groupSeq = '1';
                        options.osType = osType;
                         
                        if (operation !== "read" && options.models) {
                            return {models: kendo.stringify(options.models)};
                        }
                        
                        return options;
                    }
                }, 
                batch: true,
                schema: {
                    model: {
                        id: "pathSeq",
                        fields: {
                        	pathName: { editable: false, nullable: true },
                        	absolPath: { editable: false, nullable: true },
                        	availCapac: { editable: true, nullable: true, type: "number", validation: { min: 0, required: true } },
                        	limitFileCount: { editable: true, nullable: true, type: "number", validation: { min: 0, required: true } }
                        }
                    }
                   
                }
            });

        $("#grid").kendoGrid({
            dataSource: dataSource,
            pageable: false,
            columns: [ 
                { field: "pathName", title: "경로명", width: "150px" },
                { field: "absolPath", title:"절대경로", width: "300px" },
                { field: "availCapac", title:"가용용량", width: "100px" },
                { field: "limitFileCount", title:"1회업로드파일", width: "120px" },
                { command: ["edit"], title: "&nbsp;", width: "80px" }],  
            editable: "inline",
            refresh:true
            /* ,
            selectable:"row",
            change: function(e) { 
            	var selectedDataItem = e != null ? e.sender.dataItem(e.sender.select()) : null;
              } */

        });
        
        $("#tabstrip").kendoTabStrip({
            animation:  {
                open: {
                    effects: "fadeIn"
                }
            },
            select : tabSelect
        });

	});
	 
	function tabSelect(e) {
		osType = $(e.item).attr('id');
		var grid = $("#grid").data("kendoGrid");
		grid.dataSource.read();
		grid.refresh();
		 
	}

	function onClick(e) { 
		var id = $(e.event.target).attr("id");
		
    	if (id == 'saveBtn') {
    		document.form.submit();
    	}
	}
 

	$("#saveBtn").kendoButton({
	    click: onClick
	});


</script>