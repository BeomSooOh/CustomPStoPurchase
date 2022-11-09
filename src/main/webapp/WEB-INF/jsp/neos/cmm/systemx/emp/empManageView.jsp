<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<script>
	$(document).ready(function() {
		shoutCutTitleChange('사원정보관리');
	});
	
	 function gridRead() {
		 var grid = $("#grid").data("kendoGrid");
			grid.dataSource.read();
			grid.refresh();
	 }
	 
	 function getChkEmp() {
		var grid = $("#grid").data("kendoGrid");
		var checkList = CommonKendo.getChecked(grid);
		if (checkList.length == 0) {
			alert("사원을 선택하세요.");
			return -1;
		}
		else if (checkList.length > 1) {
			alert("사원은 한명만 선택하세요.");
			return -1;
		} 
		else {
			/* if (type == "loginId") {
				return checkList[0].loginId;
			} else if(type == "empSeq") {
				return checkList[0].empSeq;
			}  */
			
			return checkList[0];
			  
		}
	 }
	 
	 function checkLoginId(id) {
		if (id != null && id != '' && id.length > 4) {		 
			 $.ajax({
	 			type:"post",
	 			url:"empLoginIdCheck.do",
	 			datatype:"text",
	 			data: {loginId:id},
	 			success:function(data){
	 				if(data.result == 0) {
	 					$("#info").css("color","blue");
	 					$("#info").html("사용가능한 아이디 입니다.");
	 				} else {
	 					$("#info").css("color","red");
	 					$("#info").html("이미 사용중인 아이디 입니다.");
	 				}
	 				
	 			},			
	 			error : function(e){	//error : function(xhr, status, error) {
	 				alert("error");	
	 			}
	 		});	 
		 } else {
			 $("#info").html("아이디는 5자 이상입니다.");
		 }
	 }
		
     function updateLoginId(id, empSeq) {
    	 $.ajax({
	 			type:"post",
	 			url:"empLoginIdSaveProc.do",
	 			datatype:"text",
	 			data: {loginId:id, empSeq:empSeq},
	 			success:function(data){
	 				alert(data.result);
	 				
	 			},			
	 			error : function(e){	//error : function(xhr, status, error) {
	 				alert("error");	
	 			}
	 		});	 
     }
    	 
     function selectRow(grid) {
    	 
    	 CommonKendo.setChecked($("#grid").data("kendoGrid"), this);	 
    }
     
     function empInfoPop(seq) {
    	 var url = "empInfoPop.do?empSeq="+seq;
    	 var pop = window.open(url, "empInfoPop", "width=800,height=800,scrollbars=yes");
    	 pop.focus();
     }
     
     
     function removeEmp(selectRow) {
    	 if (selectRow != null) {
    		 $.ajax({
 	 			type:"post",
 	 			url:"empRemoveDataCheck.do",
 	 			datatype:"json",
 	 			data: {empSeq : selectRow.empSeq, deptSeq : selectRow.deptSeq, compSeq : selectRow.compSeq, groupSeq : selectRow.groupSeq},
 	 			success:function(data){
 	 				if (data.result) {
 	 					var r = data.result;
 	 					if (r == '0') {
 	 						removeEmpInfo(selectRow);
 	 						
 	 					} else if (r == '1') {
 	 						alert("상신 또는 결재중인 문서가 존재합니다.");
 	 					} else if (r == '2') {
 	 						alert("부부서 정보가 존재합니다. 부부서 정보를 모두 삭제하세요.");
 	 					}
 	 					
 	 				}
 	 			},			
 	 			error : function(e){	//error : function(xhr, status, error) {
 	 				alert("error");	
 	 			}
 	 		});	
    		 
    		 
    	 } else {
    		 alert("선택된 사원이 없습니다.");
    	 }
    	 
     }
     
     function removeEmpInfo(selectRow) {
    	 $.ajax({
	 			type:"post",
	 			url:"empRemoveProc.do",
	 			datatype:"json",
	 			data: {empSeq : selectRow.empSeq, deptSeq : selectRow.deptSeq, compSeq : selectRow.compSeq, groupSeq : selectRow.groupSeq},
	 			success:function(data){
	 				
	 				if (data.result) {
	 					
	 					var r = data.result;
	 					if (r == '0') {
	 						alert("회원정보가 삭제되었습니다.");
	 					} else if (r == '1') {
	 						alert("사원정보가 없습니다.");
	 					} else if (r == '2') {
	 						alert("사원 multi 정보 업데이트 실패하였습니다.");
	 					} else if (r == '3') {
	 						alert("사원정보 업데이트 실패하였습니다.");
	 					} 
	 				}
	 			},			
	 			error : function(e){	//error : function(xhr, status, error) {
	 				alert("error");	
	 			}
	 		});	
     }
     
 
	 /* function chkAll(allChkName, chkName) {
	           
	      	 
			var chkDoc = document.getElementsByName(chkName);

	     	var allChkName = document.getElementsByName(allChkName);
	     	allCheckBox(chkDoc, allChkName[0].checked);
	  
	     		 
	     	if (allChkName[0].checked) { 
	   	    	$(".k-grid-content tbody tr").each(function () {
	   	    										var $row = $(this);
	   	    										var grid = $("#grid").data("kendoGrid");
	   	    										var dataItem = grid.dataItem($row);
	   	    										$row.addClass("k-state-selected");      
		  										}); // each end 	
	    	} else {                   
	     		$(".k-grid-content tbody tr").each(function () {	
			    									var $row = $(this);
			    									$row.removeClass('k-state-selected');                    	
		     									});//each end 
	    	}
	  	} */
</script>
 
<div>
	<div>
		<label for="searchKeyword">사원검색</label>
        <span class="k-textbox k-space-right" style="width:200px;" >
        	<input type="text" id="searchKeyword" name="searchKeyword" />
            <a href="#" class="k-icon k-i-search" onclick="gridRead();">&nbsp;</a>
        </span>
	</div>
	
	<div>
		<span class="k-textbox" style="width:150px;" >
			<lable for="positionCode">직급</lable>
			<select id="positionCode" name="positionCode">
			 	<option value="">전체</option>
			 	<c:forEach items="${positionList}" var="list">
			 		<option value="${list.dpSeq}">${list.dpName}</option>
			 	</c:forEach>
			</select>
		</span>
		<span class="k-textbox k-space-right" style="width:150px;" >
			<lable for="dutyCode">직책</lable>
			<select id="dutyCode" name="dutyCode">
				<option value="">전체</option>
				<c:forEach items="${dutyList}" var="list">
			 		<option value="${list.dpSeq}">${list.dpName}</option>
			 	</c:forEach>
			</select>
		</span>
		
		<label for="deptName">부서명</label>
        <span class="k-textbox k-space-right" style="width:150;" >
        	<input type="text" id="deptName" name="deptName" />
            <a href="#" class="k-icon k-i-search" onclick="gridRead();">&nbsp;</a>
        </span>
        
        <p></p>
        
        <span class="k-textbox k-space-right" style="width:150px;" >
			<lable for="workStatus">재직여부</lable>
			<select id="workStatus" name="workStatus">
				<option value="">전체</option>
			</select>
		</span>
		<span class="k-textbox k-space-right" style="width:150px;" >
			<lable for="useYn">사용여부</lable>
			<select id="useYn" name="useYn">
				<option value="">전체</option>
			</select>
		</span>
		<span class="k-textbox k-space-right" style="width:150px;" >
			<lable for="workTeam">근무조</lable>
			<select id="workTeam" name="workTeam">
				<option value="">전체</option>
			</select>
		</span>
	 	<button id="primaryTextButton" class="k-primary">검색</button>
	</div> 

	<div style="text-align:right">
		<button id="changeId" class="k-primary">로그인ID변경</button>
		<button id="addEmp" class="k-primary">입사처리</button>
		<button id="retireEmp" class="k-primary">퇴사처리</button>
		<button id="batchAddEmp" class="k-primary">일괄등록</button>
		<button id="changeWorkTeam" class="k-primary">근무조지정</button>
		<button id="removeEmp" class="k-primary">삭제</button>
	</div> 
	  
</div>
<div> 
	<div id="grid" ></div>
</div>

<!-- 로그인ID변경 팝업 -->
<div id="window">
                <p>기존아이디 <span id="preLoginId"></span></p>
 
                <p>변경아이디 <input type="text" id="changeLoginId" name="changeLoginId" onkeyup="checkLoginId(this.value);" /></p>
				<input type="hidden" id="loginIdEmpSeq" />
				
				<p id="info" style="text-align:center"></p>
				<p style="text-align:center;">
                <button id="changeIdOk" class="k-primary">확인</button>
                <button id="changeIdClose" class="k-primary">취소</button>
                </p>
            </div>




<script>
	$(document).ready(function() {
	    var dataSource = new kendo.data.DataSource({
	    	serverPaging: true,
	  		pageSize: 10,
	         transport: { 
	             read:  {
	                 url: 'empListData.do',
	                 dataType: "json",
	                 type: 'post'
	             },
	             parameterMap: function(options, operation) {
	                 options.groupSeq = '1';
	                 options.mainDeptYn = 'Y';
	                 options.nameAndLoginId = $("#searchKeyword").val();
	                 options.positionCode = $("#positionCode").val();
	                 options.dutyCode = $("#dutyCode").val();
	                 options.deptName = $("#deptName").val();
	                 options.workStatus = $("#workStatus").val();
	                 options.useYn = $("#useYn").val();
	                 options.workTeam = $("#workTeam").val();
	                    
	                 if (operation !== "read" && options.models) {
	                     return {models: kendo.stringify(options.models)};
	                 }
	                 
	                 return options;
	             }
	         }, 
	         schema:{
	 			data: function(response) {
	 	  	      return response.list;
	 	  	    },
	 	  	    total: function(response) {
	 	  	      return response.totalCount;
	 	  	    }
	 	  	  }
	     });
	
		 $("#grid").kendoGrid({
		     dataSource: dataSource,
		     sortable: false ,
   	  		selectable: true,
   	  		navigatable: true,
   	  		pageable: {
					refresh: false,
   	    		pageSizes: true
   	  		},
   	  		scrollable: true,
   	  		columnMenu: false,
   	  		autoBind: true,
		     columns: [
						{ field: "empSeq", title: "사번", hidden: true },
		                { field: "chkbox", title: "선택" , align:"center" , width: "40px", filterable: false, sortable: false, template: "<input type=\"checkbox\" name =\"chkEmp\"  class=\"checkbox\" value = \"#=empSeq#\"/>"  },
		                { field: "deptName", title: "부서", align:"center", width: "130px" },
		                { field: "deptPositionCodeName", title: "직급" }, 
		                { field: "deptDutyCodeName", title: "직책", width: "130px" }, 
		                { field: "empName", title: "사원명", width: "90px"},  
		                { field: "loginId", title: "ID", width: "130px" },   
		                { field: "workStatus", title: "재직여부", width: "130px" }, 
		                { field: "useYn", title: "사용여부", width: "130px" }
		                
		                //, 
//		                { field:  title = "결재선보기", width:"90px", template: "<img src=\"<c:url value='/images/btn/btn_view.gif' />\" title=\"보기\" class='fix' />"   }, 
		                //{ field: "C_DIKEYCODE", title: "결재상태", hidden: true }
	           		]
		     /* ,
		     selectable:"row",
		     change: function(e) { 
		     	var selectedDataItem = e != null ? e.sender.dataItem(e.sender.select()) : null;
		       } */
		
		 });
		  
		 $("#grid").data("kendoGrid").table.on("click", ".checkbox" , selectRow);
		 
		 $("#grid").on("dblclick", "tr.k-state-selected", function (e) {
			 var selectedItem = $("#grid").data("kendoGrid").dataItem(this);
			 empInfoPop(selectedItem.empSeq);
		 });
		
		 
		 $("#primaryTextButton").kendoButton({
			 click: function(e) {
				 gridRead();
			 }
		 });
		 
		 var window = $("#window");
		 
		 $("#changeId").kendoButton({
			 click: function(e) {
				 var empInfoRowData = getChkEmp();
				 if (empInfoRowData != null) {
				 	$("#preLoginId").html(empInfoRowData.loginId);
				 	$("#loginIdEmpSeq").val(empInfoRowData.empSeq);
				 	
				 	$("#changeLoginId").val("");
				 	$("#info").css("color","");
				 	$("#info").html("");
				 	
				 	window.data("kendoWindow").open();
				 }
			 }
		 });
		 $("#addEmp").kendoButton({
			 click: function(e) {		 
				 empInfoPop();
			 } 
		 });
		 $("#retireEmp").kendoButton({
			 click: function(e) {
				 alert("개발예정입니다.");
			 }
		 });
		 $("#batchAddEmp").kendoButton({
			 click: function(e) {
				alert("개발예정입니다.");
			 }
		 });
		 $("#changeWorkTeam").kendoButton({
			 click: function(e) {
				 alert("개발예정입니다.");
			 }
		 }); 
		 $("#removeEmp").kendoButton({
			 click: function(e) {
				var isConfirm = confirm("선택된 사용자 정보를 삭제하시겠습니까?");
				if (isConfirm) {
					
					var selectRow = getChkEmp();
				
					removeEmp(selectRow);			
					
				}
			 }
		 });
		 
		 
		 window.kendoWindow({
			 width: "300px",
             title: "로그인 ID 변경",
             visible: false,
             actions: [
                 "Close"
             ]
         });
		 
		 $("#changeIdOk").kendoButton({
			 click: function(e) {
				var loginId = $("#changeLoginId").val();
				var empSeq = $("#loginIdEmpSeq").val();
			 
				 updateLoginId(loginId, empSeq);
				 
				 gridRead();
				 
				 window.data("kendoWindow").close();

			 }
		 });
		 
		 $("#changeIdClose").kendoButton({
			 click: function(e) {
				 window.data("kendoWindow").close();
			 }
		 });

	});
</script>
 
 



                
  