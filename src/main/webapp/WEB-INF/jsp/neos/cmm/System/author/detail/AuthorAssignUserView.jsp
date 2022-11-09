<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
/**
 * 
 * @title 권한부여관리 화면
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 6. 29.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2015. 6. 04.  송준석        최초 생성
 *
 */
%>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/plugins/jquery.alphanumeric.js'/>"></script>

<script>

	var formList1 = {};

	/*검색 클릭*/
	formList1.submit = function() {
		//$("#searchKeyword").val($("#searchKeyword").val() );
		
	    var query = {
	 			page:1,
	 			//pageSize:10
		};
		dataSource.query(query);
	 };
	
	function delAuthorUserInfo(){

		var chkArray = [];
		var chkDeptArray = [];
			
		var check = $("#list_user :checkbox[checked=checked]");
		var checkedLen = check.length;

		if(checkedLen==0){
			alert("삭제할 사용자를 선택 해 주세요");	
			return;
		}else{
			//var isDel = confirm("<spring:message code='common.delete.msg' />");/*삭제하시겠습니까?*/
			var isDel = confirm("선택한 사용자의 권한을 삭제하시겠습니까?");/*삭제하시겠습니까?*/					
			if(!isDel) return false;
		}
		
		check.each(function() {
			var arrVal = $(this).val().split("/");
			chkArray.push(arrVal[0]);
			chkDeptArray.push(arrVal[1]);
		});

		var selectedUser;
		var selectedDept;		
		selectedUser = chkArray.join(',') + ",";
		selectedDept = chkDeptArray.join(',') + ",";
		
		//selected = chkArray.join('/') + ",";		

		var authorCode = $("#authorCode").val();
		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/system/deleteAuthorUserInfo.do" />',
			datatype:"json",
			data:{"authorCode":authorCode,"authorUser":selectedUser, "authorUserDept":selectedDept },
			success:function(data){	
				var result = data.result;

				alert('삭제되었습니다.');
				
				formList1.submit();
			}
		});		
		
	}

	function selfReload() {
		var query = {
	   	};
	   
		dataSource.query(query);
	}	

	function grpTreeInfo(){
		var authorCode = $("#authorCode").val();
		window.open('/gw/cmm/system/authorOrganView.do?authorCode='+authorCode, "selectOrganView", 'toolbar=no, scrollbar=no, width=580, height=600, resizable=no, status=no');
		//window.open('/gw/systemx/cmmOrgChartSelectPop.do?authorCode='+authorCode, "selectOrganView", 'toolbar=no, scrollbar=no, width=580, height=600, resizable=no, status=no');
		
		
	}
	
	

</script>

	
<form>							

<input type="hidden" id="authorCode" name="authorCode" value="<%=request.getParameter("authorCode")%>">
<input type="hidden" id="viewType" name="viewType" value="">
<input type="hidden" name="newFlag" id="newFlag" value="false">

	<div id="div_btn"></div>
		<script type="text/javascript">
		var msg = ["조직도", "삭제 "];
		
		var fn = ["grpTreeInfo()", "delAuthorUserInfo()"];
		var div_btn = "div_btn";
		NeosUtil.makeButonType02(msg, fn, div_btn);																																	
		</script>
	

	<div class="content_right" style="width: 400px">
		<div class="search_right mT7">
 			사용자검색 <input type="text" name="searchUserKeyword" id="searchUserKeyword" style="width:170px;color:#a5a5a5;" value="${searchUserKeyword}"  />  
        	<button type='button' id="textButton" onclick="javascript:formList1.submit();">검색</button>
		</div>
		<div class="search_right mT7">
			<span class="bulit">부서 
 			<select id="userDept" name="userDept"  style="width:70px;" onChange="javascript:formList1.submit();">
				<option value="all">전체</option>
				<option value="001">사용자</option>
				<option value="002">부서</option>
				<option value="003">직책</option>
				<option value="004">직급</option>
			</select> 
			</span>
			<span class="bulit">직책 
 			<select id="userPos" name="userPos"  style="width:70px;" onChange="javascript:formList1.submit();">
				<option value="all">전체</option>
				<option value="Y">사용</option>
				<option value="N">미사용</option>
			</select>
			</span>
			<span class="bulit">직급 
 			<select id="userClass" name="userClass"  style="width:70px;" onChange="javascript:formList1.submit();">
				<option value="all">전체</option>
				<option value="Y">사용</option>
				<option value="N">미사용</option>
			</select>
			</span>			 			
		</div>		
		<div style="width:400px; float:left; margin:0; overflow:auto;">
			<table id="list_user" ></table>
		</div>
	</div>

							
								<script>
								$(function(){
									BindKendoUserGrid();
							        var query = {
							        		page:1
							        };
							        dataSource.query(query);
								
									$("#userDept").kendoComboBox();
									$("#userPos").kendoComboBox();
									$("#userClass").kendoComboBox();									
									
						            $("#searchUserKeyword").bind({
						                keyup : function(event){
						                    if(event.keyCode==13){
						                    	formList1.submit();
						                    }
						                }
						            });
						            
						            $("button").kendoButton();	
								});
								
								 var dataSource = new kendo.data.DataSource({
							    	  serverPaging: true,
							    	  //pageSize: 10,
							    	  filter: {
							    	    field: '1',
							    	    operator: 'neq',
							    	    value: '1'
							    	  },
							    	  transport: {
							    	    read: {
							    	      type: 'post',
							    	      dataType: 'json',
							    	      url: '<c:url value="/cmm/system/authorAssignUserView2.do"/>'
							    	    },
							    	    parameterMap: function(data, operation) {									
											var searchUserKeyword = $("#searchUserKeyword").val();
											var userDept = $("#userDept").val();
											var userPos = $("#userPos").val();
											var userClass = $("#userClass").val();
											var authorCode = $("#authorCode").val();
											
											data.searchUserKeyword = searchUserKeyword ;
											data.userDept = userDept ;
											data.userPos = userPos ;
											data.userClass = userClass ;
											data.authorCode = authorCode ;
											return data ;
							    	    }
							    	  },
							    	  schema: {
							    	    data: function(response) {
							    	      return response.listUser;
							    	    },
							    	    //total: function(response) {
							    	   	  
							    	    //  return response.totalCount;
							    	    //}
							    	  }
							    	});									
								
								
								// kendo grid 변경 부분 
								function BindKendoUserGrid(){
									
									var grid = $("#list_user").kendoGrid({
					                    dataSource: dataSource,
					                    //height: 400,
					                    scrollable: true,
					                    sortable: true,
					                    filterable: false,
					                    selectable: 'row',
							        	//pageable: {
							        	//    refresh: false,
							        	//    pageSizes: true
								        //},
								        autoBind: true,
					                    columns: [
											{ field: "chkAll", title: "<input type='checkbox' id='checkUserAll' onchange='SelectUserAll();'/>", width: "10%", filterable: false, sortable: false, 
											    template: "<input type=\"checkbox\"  class=\"check_user_row\" value=#=EMP_SEQ#/#=DEPT_SEQ# >"  },
					                        { field: "AUTHORCODE", title: "권한코드", hidden:true  },
					                        { field: "EMP_SEQ", title: "사용자코드", hidden:true  },
					                        { field: "EMP_NAME", title: "사용자명(id)", width: "" },
					                        { field: "DEPT_NAME", title: "부서", width: "30%" },
					                        { field: "DUTY_NM", title: "부서", hidden:true },
					                        { field: "POSITION_NM", title: "직책/직급",  width: "30%"},
					                        //{ title: "롤정보", width: "5%", template: "#= roleInfo(AUTHORTYPE,AUTHORCODE) #"  }
					                    ]
					                    
					                }).data("kendoGrid");
									
									grid.table.on("click", ".check_user_row" , selectRow);
								} // grid end										
								
								var checkedIds = {};

								//on click of the checkbox:
								function selectRow() {
									var checked = this.checked,
										row = $(this).closest("tr"),
										grid = $("#list_user").data("kendoGrid"),
										dataItem = grid.dataItem(row);

									checkedIds[dataItem.id] = checked;
									if (checked) {
										//-select the row
										row.addClass("k-state-selected");
									} else {
										//-remove selection
										row.removeClass("k-state-selected");
									}
								}
								
								
							    function SelectUserAll() 
							    {
								    if ($("#checkUserAll").attr('checked')) { $(".k-grid-content tbody tr").each(function () {
										    var values = [];
										    var $row = $(this);
										    var checked = $row.find('.check_user_row').attr('checked');
										    if (($row.find(".check_user_row").attr('disabled') == 'disabled')) {
										    	$row.find(".check_user_row").removeAttr('checked');
										    }
										    else {									       
										    	$row.find(".check_user_row").attr('checked', 'checked');
										    }            
									    
									    }); // each end 	
								    }
								    else {                   
								     	$(".k-grid-content tbody tr").each(function () {	
										    var $row = $(this);
										    $row.find(".check_user_row").removeAttr('checked');                    	
									     }); 
								    }							                 
							    }							    
								// kendo grid 추가 부분 end 
								
								
								</script>
								
								
</form>
