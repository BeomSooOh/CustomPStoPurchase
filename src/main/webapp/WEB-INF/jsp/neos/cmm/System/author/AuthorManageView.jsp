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
 * @title 권한 관리 화면
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 6. 29.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2012. 6. 29.  박기환        최초 생성
 *
 */
%>

<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/plugins/jquery.alphanumeric.js'/>"></script>

<script>

	var formList = {};

	/*검색 클릭*/
	formList.submit = function() {
		$("#searchKeyword").val($("#searchKeyword").val() );
		
	    var query = {
	 			page:1,
	 			//pageSize:10
		};
		dataSource.query(query);
	 };
	/*검색 클릭 (검색시 page number)*/
	formList.keeppaging = function() {
		$("#pageIndex").val();
		$("form").submit();
	};	
	
	
	function newAuthorInfo(){
	
		var table_input = $("#organ_table input");
		table_input.each(function(){
			$(this).val("");
		});
		
		var table_select = $("#organ_table select");
		table_select.each(function(){
			$(this).find("option:eq(0)").attr("selected", true);
		})
		
		$("#authorBaseYnChk").show();
		$("input:radio[name=authorBaseYn]:input[value=Y]").attr("checked", true);	
		$("input:radio[name=authorUseYn]:input[value=Y]").attr("checked", true);	
	}
	
	function delAuthorInfo(){
		
		var check = $("#list :checkbox[checked=checked]");
		var checkedLen = check.length;
		if(checkedLen==0){
			alert("삭제할 권한을 선택 해 주세요");	
			return;
		}else if(checkedLen>1){
			alert("한개만 선택 해 주세요");
			return;
		}else{
			//var isDel = confirm("<spring:message code='common.delete.msg' />");/*삭제하시겠습니까?*/
			var isDel = confirm("선택한 권한을 삭제하시겠습니까?\n삭제 시, 해당 권한 코드에 부여한 권한도 함께 삭제됩니다");/*삭제하시겠습니까?*/					
			if(!isDel) return false;
		}
		
		// kendo 처리용
		var grid = $('#list').data().kendoGrid;
		var selected = grid.table.find("tr").find("td:nth-child(1) input:checked").closest("tr");
		var authorCode = selected.find('td:eq(1)').first().text();
				
		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/system/deleteAuthorInfo.do" />',
			datatype:"json",
			data:{"authorCode":authorCode},
			success:function(data){	
				var result = data.result;

				alert('삭제되었습니다.');
				
				formList.submit();
			}
		});		
		
	}
	
	function authorInfoSubmit(){
	
		var data = get_input_data("author_info", "input", "text");		
		//data = update_input_data("author_info", "select", data);
		//data = update_input_data2("author_info","input", "radio", data);
		
		data["authorCode"] = $("#authorCode").val();
		data["authorNm"] = $("#authorNm").val();
		data["authorType"] = $("#authorType").val();
		data["authorDc"] = $("#authorDc").val();
		data["authorBaseYn"] = $(':radio[name="authorBaseYn"]:checked').val();
		data["authorUseYn"] = $(':radio[name="authorUseYn"]:checked').val();
		
		
		if($("#authorCode").val() != null && $("#authorCode").val() != ''){
			data["submitType"] = "update";

			var isUpdate = confirm("선택한 권한을 수정하시겠습니까?\n권한구분 수정 시, 해당 권한에 부여한 권한은 초기화 됩니다");					
			if(!isUpdate) return;
		
		}else{
			data["submitType"] = "insert";
		}
		
		if(authorValid(data)){
			$.ajax({
				type:"post",
				url:'<c:url value="/cmm/system/insertAuthorInfo.do" />',
				datatype:"json",
				data: data,
				success:function(data){
					
					var result = data.result;
					
					if(result=="update"){
						
						alert('수정되었습니다.');
					}else if(result=="insert"){		
						//등록하면 생성된 orgnztId를 삽입 해준다.
						$("#esntlId").val(data.esntlId);
						$("#id_chk_teg").hide();
						alert('저장되었습니다.');
					}else{
						//sql 에러가 발생했습니다! error code: {0}, error msg: {1}
						alert('<spring:message code="fail.common.sql" />');
					}																		 
				
					formList.submit();
					
				}
			});	
		
		}
	}
	
	function authorValid(data){
		//var nullchk = ["authorCode", "authorNm"];
		//var nullmsg = ["권한코드를 넣어주세요", "권한명 넣어주세요."];
		var nullchk = ["authorNm"];
		var nullmsg = ["권한명 넣어주세요."];
		
		
		for(var i=0;i<nullchk.length;i++){
			if($("#"+nullchk[i]).val()==null || $("#"+nullchk[i]).val().length==0){				
				alert(nullmsg[i]);
				return false;
			}
		}

		return true;
		
	}
	
	function openAuthorInfo(){
		$("#author_info").slideDown();
	}

	function closeAuthorInfo(){
		$("#author_info").slideUp();
	}
	
	function authorInfoView(authorCode){

		$.ajax({
			type:"post",
			url:'<c:url value="/cmm/system/selectAuthorInfo.do" />',
			datatype:"json",
			data:{"authorCode":authorCode},
			success:function(data){	
				var result = data.result;
				
				$.each(result, function(index, value){				
					if(value.length>0){
						$("#"+index).val(value);
					}
					
					if( index == 'authorBaseYn' || index == 'authorUseYn' ){
						if( value == null || value == "" ) 
							value = 'Y';
					
						$("input:radio[name="+index+"]:input[value="+value+"]").attr("checked", true);						
					}
					
					if( index == 'authorType' ){
						if( value == "001" )
							$("#authorBaseYnChk").show();
						else
							$("#authorBaseYnChk").hide();
					} 
				        	        
					
				});
				
				$("#authorType").data("kendoComboBox").value(result.authorType);


			}
		});
	
	}
	
	function roleInfoView(authorCode){
		alert(authorCode);
	}

	function chkAuthorType(){

		if($("#authorType").val() == "001") {
	        $("#authorBaseYnChk").show();	        
		}else {
			$("#authorBaseYnChk").hide();
		}
	}	

	
</script>

	
<form>							

<div class="top_box" style="position:relative" >
	<div class="top_box_in">	
        권한 검색 <input type="text" name="searchKeyword" id="searchKeyword" style="width:170px;color:#a5a5a5;" value="${searchKeyword}"  onkeyup="javascript:if(event.keyCode==13){formList.submit()}"/>  
        <button type='button' id="textButton" onclick="javascript:formList.submit();">검색</button>  
	</div>
	<span class="btn_Detail">상세 <img id="all_menu_btn" src='/gw/Images/ico/ico_btn_arr_down01.png'/></span>
	      
</div>
<div class="SearchDetail mb10">
      <p>
            <label style="width:200px; display:inline-block;">권한구분 
		    	<select id="searchAuthorType" name="searchAuthorType"  style="width:80px;">
	            	<option value="all">전체</option>
	            	<option value="001">사용자</option>
	                <option value="002">부서</option>
	                <option value="003">직책</option>
	                <option value="004">직급</option>
		        </select>
		    </label>                
            <label style="width:200px; display:inline-block;">기본부여여부 
		    	<select id="searchAuthorBaseYn" name="searchAuthorBaseYn"  style="width:80px;">
	            	<option value="all">전체</option>
	            	<option value="Y">예</option>
	                <option value="N">아니오</option>
		        </select>  
		    </label>    
            <label style="width:200px; display:inline-block;">사용여부 
		    	<select id="searchAuthorUseYn" name="searchAuthorUseYn"  style="width:80px;">
	            	<option value="all">전체</option>
	            	<option value="Y">사용</option>
	                <option value="N">미사용</option>
		        </select>
		    </label>    
            <label style="width:110px; display:inline-block;">
            <button type='button' id="textButton" onclick="javascript:formList.submit();">검색</button>           
            </label>            
      </p>

</div> 




<div id="div_btn"></div>
	<script type="text/javascript">
		var msg = ["추가", "삭제 "];
		
		var fn = ["newAuthorInfo()", "delAuthorInfo()"];
		var div_btn = "div_btn";
		NeosUtil.makeButonType02(msg, fn, div_btn);																																	
	</script>


<div class="demo-section" >
		<table id="list" ></table>
</div>
<div class="fLeft" >

	<input type="hidden" name="newFlag" id="newFlag" value="false">
                               	
		<table cellpadding="0" cellspacing="0" width="100%" id="organ_table" name="organ_table">
			<tr style= "display:none;">
			<td><span class="f_red">*</span> 권한코드</td><td><input type="text"  name="authorCode" id="authorCode"  style="width:150px;"/></td>
			</tr>                               		
			<tr>
			<td><span class="f_red">*</span> 권한명</td><td><input type="text"  name="authorNm" id="authorNm"  style="width:150px;"/></td>
			</tr>
			<tr>
			<td><span class="f_red">*</span> 권한구분</td>
			<td>
		       <select id="authorType" name="authorType"  style="width:80px;" onChange="chkAuthorType();">
	               <option value="001">사용자</option>
	               <option value="002">부서</option>
	               <option value="003">직책</option>
	               <option value="004">직급</option>
		       </select>                                          						            
			</td>
		    </tr>
		    <tr id = "authorBaseYnChk" style= "display:;">
	        <td><span class="f_red">*</span> 기본부여여부</td>
	        <td>
			예 <input type="radio"  value="Y" name="authorBaseYn" id="authorBaseYn1" checked/>       
	                   아니오 <input type="radio"  value="N" name="authorBaseYn" id="authorBaseYn2" />  						            
	        </td>
	        </tr>
	        <tr>
	        <td><span class="f_red">*</span> 사용여부</td>
	        <td>
			사용 <input type="radio"  value="Y" name="authorUseYn" id="authorUseYn1" checked/>       
	                   미사용 <input type="radio"  value="N" name="authorUseYn" id="authorUseYn2" />  						            
	        </td>
	        </tr>
	        <tr>
	        <td>설명</td><td><input type="text"  name="authorDc" id="authorDc"  style="width:200px;"/></td>
			</tr>
		</table>

		<button type='button' id="textButton" onclick="javascript:authorInfoSubmit();">저장</button>

</div>



								
								<script>
								$(function(){
									BindKendoGrid();
							         var query = {
							        		    //pageSize: 10,
							         			page:1
							        		  };
							         dataSource.query(query);

																																				
								//  Short Title Set									
									shoutCutTitleChange('<spring:message code="author.menu.title" />'/*권한 관리*/);
								
									$("#authorType").kendoComboBox();
									
									// 상세검색 
									$("#searchAuthorType").kendoComboBox();
									$("#searchAuthorBaseYn").kendoComboBox();
									$("#searchAuthorUseYn").kendoComboBox();

									$("button").kendoButton(); 
									
								});
								
								//검색창 사이즈
								formList.resizeTopSearch = function(){
									var win_w1 = $(window).width();
									var min = jqGridUtil.minWidth();
							    	 if(win_w1 && parseInt(win_w1)< parseInt(min)){
							    		 return false;
							    	 }
							    	 var leftWidth = NeosUtil.getLeftMenuWidth();
							    	 var width = win_w1 - leftWidth - 14;
							    	 $(".top_search#searchCriteria").css("width", width);
								};																
																	

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
							    	      url: '<c:url value="/cmm/system/authorManageView2.do"/>'
							    	    },
							    	    parameterMap: function(data, operation) {									
							    	    	data.searchKeyword = $("#searchKeyword").val();
							    	    	data.searchAuthorType = $("#searchAuthorType").val();
							    	    	data.searchAuthorBaseYn = $("#searchAuthorBaseYn").val();
							    	    	data.searchAuthorUseYn = $("#searchAuthorUseYn").val();

											return data ;
							    	    }
							    	  },
							    	  schema: {
							    	    data: function(response) {
							    	      return response.list;
							    	    },
							    	    total: function(response) {
							    	   	  
							    	      return response.totalCount;
							    	    }
							    	  }
							    	});									
								
								
								// kendo grid 변경 부분 
								function BindKendoGrid(){
									
									var grid = $("#list").kendoGrid({
					                    dataSource: dataSource,
					                    height: 400,
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
											{ field: "chkAll", title: "<input type='checkbox' id='checkAll' onchange='SelectAll();'/>", width: "30px", filterable: false, sortable: false, 
											    template: "<input type=\"checkbox\"  class=\"check_row\" />"  },
					                        { field: "AUTHORCODE", title: "권한코드", hidden:true  },
					                        { field: "AUTHORNM", title: "권한명", width: "" },
					                        { field: "AUTHORTYPE", title: "권한구분",  width: "25%" },
					                        { field: "AUTHORBASEYN", title: "기본부여여부",  width: "20%" },
					                        { field: "AUTHORUSEYN", title: "사용여부", width: "15%" },
					                        //{ title: "롤정보", width: "5%", template: "#= roleInfo(AUTHORTYPE,AUTHORCODE) #"  }
					                    ],
					                    // row 클릭 이벤트
					                    change: function (arg) {
					                        var selected = $.map(this.select(), function(item) {					                        	
					                        	var authorCode = $(item).find('td:eq(1)').first().text();
					                        	
					                        	$(item).find(".check_row").attr('checked', 'checked');
					                        	
					                        	authorInfoView(authorCode);					                            
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
								
            <style>
                .demo-section {
                    display: inline-block;
                    vertical-align: top;
                    width: 350px;
                    height:100%;
                    text-align: left;
                    margin: 0 2em;
                    float:left;
                }
                
                .fLeft {
                	float:left;
                }
            </style>								
</form>
