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

<script>

	var formList = {};

	/*검색 클릭*/
	formList.submit = function() {
		$("#searchKeyword").val($("#searchKeyword").val() );
		$("#authorChgType").val($("#authorChgType").val() );
		$("#authorChgUseYn").val($("#authorChgUseYn").val() );
			
		
		var form = $("form").first();
		if(form){
		    var query = {
		 			page:1,
		 			//pageSize:10
			};
			dataSource.query(query);
		}		
	 };

	
	function chkAuthorType(){

		formList.submit();
	}	

	function chkAuthorUseYn(){

		if($("#authorType").val() == "001") {
	        $("#authorBaseYnChk").show();	        
		}else {
			$("#authorBaseYnChk").hide();
		}
	}	

    function assignInfo( authorCode, authorType ){
    	var typeChk = $("#viewType").val();
    	
	    var url = "";
	    
	    if( typeChk == "codeType"){

		    if(authorType == "001") url = "/gw/cmm/system/authorAssignUserView.do";
		    else if(authorType == "002") url = "/gw/cmm/system/authorAssignGrpView.do";
		    else if(authorType == "003" || authorType == "004") url = "/gw/cmm/system/authorAssignClassView.do";
		    else url ="";	    	
	    	
	    }else if( typeChk == "menuType"){
	    	url = "/gw/cmm/system/authorAssignMenuView.do";
	    }
	    
	    $.ajax({
	        type:"post",
	        url:url,
	        data:{"authorCode":authorCode,"authorTypeCode":authorType},
	        datatype:"html",            
	        success:function(data){
	            $("#divList").html(data);
	        }
	    });		
		
		
    }    
    
    
</script>

	
<form>							
<input type="hidden" id="viewType" name="viewType" value="<%=request.getParameter("viewType")%>">

	<div id="treeview-left">
		<div>■ 권한 선택</div>
		<ul id="fieldlist">
			<li>
	 			권한검색 <input type="text" name="searchKeyword" id="searchKeyword" style="width:170px;color:#a5a5a5;" value="${searchKeyword}" onkeyup="javascript:if(event.keyCode==13){formList.submit(); return false;}" />  
	        	<button type='button' id="textButton" onclick="javascript:formList.submit();">검색</button>
			</li>
			<li>
				<span class="bulit">권한구분 
	 			<select id="authorChgType" name="authorChgType"  style="width:120px;" onChange="javascript:formList.submit();">
					<option value="all">전체</option>
					<option value="001">사용자</option>
					<option value="002">부서</option>
					<option value="003">직책</option>
					<option value="004">직급</option>
				</select> 
				</span>
				<span class="bulit">사용여부 
	 			<select id="authorChgUseYn" name="authorChgUseYn"  style="width:120px;" onChange="javascript:formList.submit();">
					<option value="all">전체</option>
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>
				</span>
			</li> 			
			<li>
				<div style="width:400px; float:left; margin:0; overflow:auto;">
					<table id="list" ></table>
				</div>
			</li>
		</ul>
	</div>
	
	<div id="treeview-left" >
	<input type="hidden" name="newFlag" id="newFlag" value="false">
	
		<div>■ 권한 부여</div>                               	             	
		<div id="divList"></div>                               	             	
	
	</div>

     							
								<script>

								
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
							    	      url: '<c:url value="/cmm/system/authorAssignManageView2.do"/>'
							    	    },
							    	    parameterMap: function(data, operation) {									
											var searchKeyword = $("#searchKeyword").val();
											var authorChgType = $("#authorChgType").val();
											var authorChgUseYn = $("#authorChgUseYn").val();
											
											data.searchKeyword = searchKeyword ;
											data.authorChgType = authorChgType ;
											data.authorChgUseYn = authorChgUseYn ;
											return data ;
							    	    }
							    	  },
							    	  schema: {
							    	    data: function(response) {
							    	      return response.list;
							    	    },
							    	    //total: function(response) {
							    	   	  
							    	    //  return response.totalCount;
							    	    //}
							    	  }
							    	});									
								
								
								
								$(function(){
									BindKendoGrid();
							         var query = {
							        		    //pageSize: 10,
							         			page:1
							        		  };
							         dataSource.query(query);

									
									$("#authorChgType").kendoComboBox();
									$("#authorChgUseYn").kendoComboBox();
									$("button").kendoButton();	
								});
								
								
								// kendo grid 변경 부분 
								function BindKendoGrid(){
									
									var grid = $("#list").kendoGrid({
					                    dataSource: dataSource,
					                    height: 500,
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
											//{ field: "chkAll", title: "<input type='checkbox' id='checkAll' onchange='SelectAll();'/>", width: "30px", filterable: false, sortable: false, 
											{ field: "", title: "", width: "30px", filterable: false, sortable: false,
											    template: "<input type=\"checkbox\"  class=\"check_row\" />"  },
					                        { field: "AUTHORCODE", title: "권한코드", hidden:true  },
					                        { field: "AUTHORNM", title: "권한명", width: "" },
					                        { field: "AUTHORTYPECODE", title: "권한구분코드", hidden:true  },
					                        { field: "AUTHORTYPE", title: "권한구분",  width: "25%" },
					                        { field: "AUTHORBASEYN", title: "기본부여여부",  width: "20%" },
					                        { field: "AUTHORUSEYN", title: "사용여부", width: "15%" },
					                        //{ title: "롤정보", width: "5%", template: "#= roleInfo(AUTHORTYPE,AUTHORCODE) #"  }
					                    ],
					                    // row 클릭 이벤트
					                    change: function (arg) {
					                        var selected = $.map(this.select(), function(item) {					                        	
					                        	var authorCode = $(item).find('td:eq(1)').first().text();
					                        	var authorType = $(item).find('td:eq(3)').first().text();
					                        	
					                        	$(item).find(".check_row").attr('checked', 'checked');
					                        	
					                        	assignInfo( authorCode, authorType );				                            
					                        });
					                    } 
					                    
					                }).data("kendoGrid");
									
									grid.table.on("click", ".check_row" , selectRow);
								} // grid end										
								
								var checkedIds = {};

								//on click of the checkbox:
								function selectRow() {
									var checked = this.checked,
										row = $(this).closest("tr"),
										grid = $("#list").data("kendoGrid"),
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
																
								
								
							    function SelectAll() 
							    {
								    if ($("#checkAll").attr('checked')) { $(".k-grid-content tbody tr").each(function () {
										    var values = [];
										    var $row = $(this);
	
										    var checked = $row.find('.check_row').attr('checked');
										    if (($row.find(".check_row").attr('disabled') == 'disabled')) {
										    	$row.find(".check_row").removeAttr('checked');
										    }
										    else {									       
										    	$row.find(".check_row").attr('checked', 'checked');
										    }            
									    
									    }); // each end 	
								    }
								    else {                   
								     	$(".k-grid-content tbody tr").each(function () {	
										    var $row = $(this);
										    $row.find(".check_row").removeAttr('checked');                    	
									     }); 
								    }							                 
							    }							    
								// kendo grid 추가 부분 end 
															
								</script>
								
</form>
