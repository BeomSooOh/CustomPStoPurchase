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

	$(document).ready(function(){
		BindKendoClassGrid();
	});
		
	// kendo grid 변경 부분 
	function BindKendoClassGrid(){
		
		var titleNm = "";
		
		if( $("#authorTypeCode").val() == "003")
			titleNm = "직책";
		else 
			titleNm = "직급";
		var jsondata = $.parseJSON('${jsonSelectList}');
		
		var grid = $("#list_class").kendoGrid({
            dataSource: {
                data: jsondata,
            },
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
				    template: "<input type=\"checkbox\"  class=\"check_class_row\" value=#=CODE_ID#  #if(CHECK_YN == 'Y'){# checked=checked #}else{# '' #}# >"  },
	            { field: "CODE_ID", title: "권한코드", hidden:true  },
	            { field: "CODE_NM", title: titleNm, width: "" },
	            //{ title: "롤정보", width: "5%", template: "#= roleInfo(AUTHORTYPE,AUTHORCODE) #"  }
	        ]
 
	    }).data("kendoGrid");
		
		grid.table.on("click", ".check_class_row" , selectRow);
	} // grid end										
	
	var checkedIds = {};
	
	//on click of the checkbox:
	function selectRow() {
		var checked = this.checked,
			row = $(this).closest("tr"),
			grid = $("#list_class").data("kendoGrid"),
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
	
			    var checked = $row.find('.check_class_row').attr('checked');
			    if (($row.find(".check_class_row").attr('disabled') == 'disabled')) {
			    	$row.find(".check_class_row").removeAttr('checked');
			    }
			    else {									       
			    	$row.find(".check_class_row").attr('checked', 'checked');
			    }            
		    
		    }); // each end 	
	    }
	    else {                   
	     	$(".k-grid-content tbody tr").each(function () {	
			    var $row = $(this);
			    $row.find(".check_class_row").removeAttr('checked');                    	
		     }); 
	    }							                 
	}							    
	// kendo grid 추가 부분 end 
	
	function saveAuthor() {
		
		var chkArray = [];
		
		var check = $("#list_class :checkbox[checked=checked]");		
		var checkedLen = check.length;
		
		if(checkedLen==0){
			alert("직책/직급를 선택 해 주세요");	
			return;
		}
		
		check.each(function() {
			chkArray.push($(this).val());
		});
		
		var authorCode = $("#authorCode").val();
		var authorTypeCode = $("#authorTypeCode").val();
		var selected;
		selected = chkArray.join(',') + ",";		

		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/system/insertClassAuth.do" />',
			datatype:"json",
			data:{"authorCode":authorCode, "authClass":selected, "authorTypeCode":authorTypeCode},
			success:function(data){
				var result = data.result;
				
				if(result == "insert"){		
					//기관을 저장 하였습니다.
					alert('<spring:message code="userAuthor.regist.success.msg" />');
					//grp_tree();
				}else{
					//sql 에러가 발생했습니다! error code: {0}, error msg: {1}
					alert('<spring:message code="fail.common.sql" />');
					//grp_tree();
				}																		 
			}
		});			
	}	

</script>

	
<form>							

<input type="hidden" id="authorCode" name="authorCode" value="<%=request.getParameter("authorCode")%>">
<input type="hidden" id="authorTypeCode" name="authorTypeCode" value="<%=request.getParameter("authorTypeCode")%>">

	<div class="content_right" style="width: 400px">	
		<div style="width:400px; float:left; margin:0; overflow:auto;">
			<table id="list_class" ></table>
		</div>
		
		<div id="div_btn" ></div>
			<script type="text/javascript">
			var msg = ["저장"];
			
			var fn = ["saveAuthor()"];
			var div_btn = "div_btn";
			NeosUtil.makeButonType02(msg, fn, div_btn);																																	
			</script> 		
	</div>
								
</form>
