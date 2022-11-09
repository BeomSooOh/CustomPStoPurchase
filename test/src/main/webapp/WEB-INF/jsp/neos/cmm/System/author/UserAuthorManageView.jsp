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
 * @title 사용자 권한 관리 화면
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 7. 5.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2012. 7. 5.  박기환        최초 생성
 *
 */
%>

<%@ include file="/WEB-INF/jsp/neos/include/IncludeJstree.jsp" %>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/plugins/jquery.alphanumeric.js'/>"></script>
<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/neos/layout.css' />" /> --%>
<script>
var formList = {};
/*
formList.pagingClick = function(pageNo){
	
	if(!pageNo){
		pageNo = 1;
	}
	var searchKeyword = $("#searchKeyword").val();
	var searchCondition = $("#searchCondition").val();
	
	var obj = {
				pageIndex : pageNo,
				searchCondition : searchCondition,
				searchKeyword : searchKeyword
				
			};
	
	var param = NeosUtil.makeParam(obj);
	document.location.replace("<c:url value='/cmm/system/userAuthorManageView.do?'/>" + param);

	
};
*/

/*검색 클릭*/
formList.submit = function() {
	$("#searchKeyword").val($("#searchKeyword").val() );
	$("#searchCondition").val($("#searchCondition").val() );
	
    var query = {
 			page:1,
 			pageSize:10
	};
	dataSource.query(query);
 };
/*검색 클릭 (검색시 page number)*/
formList.keeppaging = function() {
	$("#pageIndex").val();
	$("form").submit();
};	


	function systemReg1(uniqId,select_name, regYn){
		var result = systemReg(uniqId,select_name, regYn);
		
		
		if(result==1){
			//권한을 등록 하였습니다.
			alert('<spring:message code="userAuthor.regist.success.msg" />');			
			formList.submit();
			return;
		}
	}
	
	function systemReg(uniqId,select_name, regYn){									
		
		var authorCode = $("#"+select_name+" > option:selected").val();									
		var result = "";
		var orgnzt_id = $("#orgnztId").val();
		$.ajax({
			type:"post",
			async:false,
			url:'<c:url value="/cmm/system/insertUserAuthorSystem.do" />',
			datatype:"json",
			data:{"authorCode":authorCode, "uniqId":uniqId, "authorType":"001", "regYn":regYn, "orgnztId":orgnzt_id},
			success:function(data){	
				result = data.result;
				
				if(result=='update' || result=='insert'){
					result = 1;
				}
					 											
			}
		});
		return result;
		
	}

	function saveUserAuthor(){
		//var id = $("#list").jqGrid('getGridParam','selarrrow');

		// kendo 처리용
		var grid = $('#list').data().kendoGrid;
		var id = grid.table.find("tr").find("td:nth-child(1) input:checked").closest("tr");
		
		if(id.length<=0){
			//선택된 사용자가 없습니다.
			alert('<spring:message code="userAuthor.noselect.msg" />');			
			return;
		}else{		
			var select_count = id.length;
			var result_count = 0;
			for(var i=0;i<select_count;i++){
				/*
				var ret = jQuery("#list").jqGrid('getRowData',id[i]);
				
				var uniqId = ret.uniqId;
				var select_name = ret.userId+"_select";
				var regYn = ret.regYn;
				*/
				
            	var uniqId = grid.dataItem(id[i]).uniqId;
				var select_name = grid.dataItem(id[i]).userId+"_select";
				var regYn = grid.dataItem(id[i]).regYn;
				
				
				result_count += systemReg(uniqId,select_name, regYn);
			}	
			
			if(select_count==result_count){
				//  ~명의 사용자 권한을 등록 하였습니다.
				alert(result_count+'<spring:message code="userAuthor.many.regist.success.msg" />');				
				formList.submit();
				return;
			}else{
				//에러가 발생했습니다!
				alert('<spring:message code="fail.common.msg" />');				
			}
		}
	}

	function addAuthor(){
		var authorCode = $("#selectAuthorCode").val();
		var authorNm = $("#selectAuthorNm").val();
		
		if(authorCode.length==0){
			//권한을 선택 하세요.
			alert('<spring:message code="userAuthor.select.alert" />');			
			return;
		}
		
		var selectAuth = $("#selectAuthorList a[name=select"+authorCode+"]").length;
		
		if(selectAuth>0){
			//동일한 권한은 넣을 수 없습니다.
			alert('<spring:message code="userAuthor.not.put.same.right.msg" />');			
			return;
		}																													
		
		var tempHtml = '<a href="javascript:;" name="select'+authorCode+'" id="select'+authorCode+'">'
					  +'	<span>'
					  +'		<input type="hidden" name="authorCode" id="authorCode" value="'+authorCode+'">'
					  +'		<input type="checkbox" name="authorNm" id="authorNm" value="'+authorNm+'">'
					  +'&nbsp;&nbsp;'+authorNm
					  +'	</span>'
					  +'</a>';
					  
		$("#selectAuthorList").append(tempHtml);
	}
	
	function deleteAuthor(){
		var selectAuthor = $("#selectAuthorList a");
		
		for(var i=0;i<selectAuthor.length;i++){
			var authorCode = $(selectAuthor[i]).find("input:hidden").val();
			if($(selectAuthor[i]).find("input:checkbox").is(":checked")==true){
				$("#select"+authorCode).remove();
			}
		}
	}
	
	function openUserAuthor(){
		$("#content_view").slideDown();
	}

	function closeUserAuthor(){
		$("a[title=등록]").show();
		$("a[title=삭제]").show();
		$("#content_view").slideUp();
	}
	

	function userToauthorList(){
		openUserAuthor();
		
		var uniqId = $("#uniqId").val();
		var orgnzt_id = $("#orgnztId").val();
		$("#selectAuthorList a").remove();
		$.ajax({
			type:"post",
			async:false,
			url:'<c:url value="/cmm/system/selectUserToAuthorList.do" />',
			datatype:"json",
			data:{"uniqId":uniqId, "orgnztId":orgnzt_id},
			success:function(data){	
				var result = data.result;
				
				for(var i=0;i<result.length;i++){
					var tempHtml = '<a href="javascript:;" name="select'+result[i].authorCode+'" id="select'+result[i].authorCode+'">'
					  +'	<span>'
					  +'		<input type="hidden" name="authorCode" id="authorCode" value="'+result[i].authorCode+'">'
					  +'		<input type="checkbox" name="authorNm" id="authorNm" value="'+result[i].userNm+'">'
					  +'&nbsp;&nbsp;'+result[i].userNm
					  +'	</span>'
					  +'</a>';
					 
					$("#selectAuthorList").append(tempHtml);
				}
				
					 											
			}
		});
	}
	
</script>
<form>

<div class="searchArea clearfx" id="" >
        <span class="bulit">조회 조건
                <select name="searchCondition" id="searchCondition" title="조회조건선택">
                								<option value="1">사용자 명</option>
                                                <option value="3">사용자권한</option>                                                
                                                <option value="2">사용자 ID</option>
                                                <option value="4">부서명</option>                          
                </select>
         </span>
         <input type="text" name="searchKeyword" id="searchKeyword" style="width:200px;" value="${searchKeyword}"  onkeyup="javascript:if(event.keyCode==13){formList.submit(); return false;}"/>
        <a href="javascript:formList.submit();" ><img src="<c:url value='/images/btn/btn_search.gif' />" alt="검색"  width="55" height="26"/></a>
</div>
								<div id="content_view" style="display:none;">
									<div id="userAuthorManageView" >														
										
										<div class="contents">	
											<div class="cnt_left">				
												<div id="userinfo" style="width:260px; height:20px; border-top:1px solid #7e7e7e; border:1px solid #ababab; background-color:#f5f5f5; padding:10px 0 0 13px;"></div>					
												<div class="cl_tree_con" id="author_tree"></div>
											</div>
																					
											<p class="btnAdd">
											    <a href="#" onclick="javascript:addAuthor();"><img src="../../images/popup/btn_add.gif" alt="추가" /></a>
											    <a href="#" onclick="javascript:deleteAuthor();"><img src="../../images/popup/btn_del.gif" alt="삭제" /></a> 
											</p>
											
											<div class="cnt_right">											
												<div class="cr_div" id="selectAuthorList" >																																	
												</div>
											</div>
										</div>
										

									</div>
                                   <p class="tC mT15" id="saveButton">
                                        <a href="javascript:;" onclick="userAuthorSubmit()" class="darkBtn"><span>저장</span></a> 
                                        <a href="javascript:;" onclick="closeUserAuthor()" class="grayBtn"><span>취소</span></a>
                                   </p>									
								</div>	
													
								<input type="hidden" id="selectAuthorCode" name="authorCode" value="">
								<input type="hidden" id="selectAuthorNm" name="authorNm" value="">
							
								<script>
								$(function(){
									$.ajax({
										type:"post",
										url:'<c:url value="/cmm/system/selectUserAuthorTreeList.do" />',										
										datatype:"json",			
										success:function(data){								
											
											$("#author_tree").jstree({
												"json_data":data,
												"themes":{
														  "theme":"default"
														 },					
												"plugins":["themes", "json_data", "ui", "crrm", "types", "search"]
											}).bind("select_node.jstree", function(event, data){
												
										        $("#selectAuthorCode").val(data.rslt.obj.attr("id"));
										        $("#selectAuthorNm").val(data.rslt.obj.attr("nm"));
										        
											}).bind("dblclick.select_node", function(event, data) {
												addAuthor();
											});;
											
										}
									});
									
								//  Short Title Set								
								
									shoutCutTitleChange('<spring:message code="userAuthor.menu.title" />'/*권한 관리*/);
									
									$("#searchCondition").kendoDropDownList();									
										
								});
									function userAuthorSubmit(){
										var selectAuthor = $("#selectAuthorList a");
										var selectStr = $("#uniqId").val();
										selectStr += "###"+$("#orgnztId").val();
										
										var tempAuthor = "";
										//결재처리자 권한 여부
										var edocApp = false;
										
										//현재 선택된 권한 중에 결재처리자 권한(A006)이 있는지 판단...										
										for(var i=0;i<selectAuthor.length;i++){					
											tempAuthor = $(selectAuthor[i]).find("input[name=authorCode]").val();
											
											if(tempAuthor=="A006"){
												edocApp = true;
											}
										}
										
										if(!edocApp){
											//결재처리자는 필수 선택입니다.
											alert('<spring:message code="userAuthor.edoc.not.select.alert" />');
											return;
										}
										
										for(var i=0;i<selectAuthor.length;i++){																															
											selectStr += "###"+$(selectAuthor[i]).find("input[name=authorCode]").val();											
										}
																	
										$.ajax({
											type:"post",
											data:{"userAuthorList":selectStr},
											url:'<c:url value="/cmm/system/insertUserAuthor.do" />',										
											datatype:"json",			
											success:function(data){		
												var result = data.result;
												
												if(result=="insert"){
													//	권한이 등록 되었습니다.
													alert('<spring:message code="userAuthor.regist.success.msg" />');
																										
												}
												if(result=="delete"){
													//	권한이 삭제 되었습니다.
													alert('<spring:message code="userAuthor.delete.success.msg" />');																																							
												}
												formList.submit();
											}
										});   
									}
								</script>

								<div id="div_btn"></div>
										<script type="text/javascript">
											var msg = ["등록", "삭제"];
											
											var fn = ["saveUserAuthor()", "delUserAuthorInfo()"];
											var div_btn = "div_btn";
											NeosUtil.makeButonType02(msg, fn, div_btn);																																	
										</script>

								<div class="board_table mT5" style="" id="board_table">
									<table id="list" ></table>
								</div>
								
								<script>
								$(function(){
									//BindjqGrid();
									BindKendoGrid();
									
							         var query = {
							        		    pageSize: 10,
							         			page:1
							        		  };
							         dataSource.query(query);																	
									
									//조회 조건 유지
									$("#searchCondition > option[value=${searchCondition}]").attr("selected", "true");
									
								});						
															
								function BindjqGrid(){
									var jsondata = $.parseJSON('${jsonSelectList}');
									var obj = {};
									obj.option = {  
											data: jsondata, 
											datatype: 'local', 
											//colNames:['사용자ID', '사용자명', '부서명', '시스템권한', '시스템 등록여부', 'uniqId', 'orgnztId'], 
											colNames:['사용자ID', '사용자명', '부서명', '시스템권한' , 'uniqId', 'orgnztId'],
											colModel:[
												{name:'userId', index:'userId', align:'center'},
												{name:'userNm', index:'userNm',  align:'center'},
												{name:'orgnztNm', index:'orgnztNm',  align:'center'},
												{name:'authorCode', index:'authorCode',  align:'center' , formatter:authorList},
												//{name:'authorCode', index:'authorCode',  align:'center', formatter:authorList},
												//{name:'regYn', index:'regYn',  align:'center'},
												{name:"uniqId", index:'uniqId', hidden:true},
												{name:"orgnztId", index:'orgnztId', hidden:true}
											], 
											multiselect:true,											
											//데이터가 존재하지 않습니다.
											emptyrecords:'<spring:message code="info.nodata.msg2" />' ,
											loadComplete  : function(){
												$.jqGrid = {};
												//$.jqGrid.data = {"0":"20px", "1":"12%", "2":"15%","3":"37%","4":"12%","5":"12%","6":"12%"};
												$.jqGrid.data = {"0":"25px", "1":"22%", "2":"22%", "3":"22%","4":"33%"};
												$.jqGrid.min = jqGridUtil.minWidth();
												jqGridUtil.resizeJqGrid("board_table");
												jqGridUtil.tableRowClickStyle("list");
												jqGridUtil.setEmptyData(obj, "board_table");
											},
											onSelectRow: function(rowid, iRow, iCol, e){ //row 클릭시 event										
												var data = $("#list").getRowData(rowid); 
												var authorCode = data.authorCode;
												var userId  = data.userId;
												var userNm = data.userNm;
												
												$("#orgnztId").val(data.orgnztId);												
												$("#userinfo").text(userNm+"("+userId+")  권한정보 ");
												$("#uniqId").val(data.uniqId);
												
												$("a[title=등록]").hide();
												$("a[title=삭제]").hide();
												userToauthorList();												
											    
												
											}
										};
									//공통으로 적용할 옵션 가져오기
									obj = jqGridUtil.jqGridCommonOption(obj);
									$("#list").jqGrid(obj.option);
									 
								}																							
								
								function authorList(cellvalue, options, rowObject){
									var select_name = rowObject.userId+"_select"; 
									var tempHtml = '<div class="selectTd"><span style="float:center; padding-left:15px;">'
												 + '<select name="'+select_name+'" id="'+select_name+'" style="width:150px;">';
									
									var authuserList = rowObject.authorCode.split(",");
									//alert(authuserList[0]);
									//alert(authuserList.length);
									for(var i=0;i<authuserList.length;i++){
											tempHtml += '<option value="'+authuserList[i]+'">'+authuserList[i]+'</option>';
									}
										
									tempHtml += '</select>';
									tempHtml += '</span>';
									tempHtml += '<span style="padding-top:5px; float:center; padding-left:8px;"><span class="table_btn_reg">';
									
									tempHtml += '</span></span></div>';
									
									return tempHtml;
																										
								}

								
								function AuthorList( userId, authorCode ){
									var select_name = userId +"_select"; 
									var tempHtml = '<div class="selectTd"><span style="float:center; padding-left:15px;">'
												 + '<select name="'+select_name+'" id="'+select_name+'" style="width:150px;">';
									
									if(authorCode !=null){			 
										var authuserList = authorCode.split("_");
	
										for(var i=0;i<authuserList.length;i++){
												tempHtml += '<option value="'+authuserList[i]+'">'+authuserList[i]+'</option>';
										}
									}
									tempHtml += '</select>';
									tempHtml += '</span>';
									tempHtml += '<span style="padding-top:5px; float:center; padding-left:8px;"><span class="table_btn_reg">';
									tempHtml += '</span></span></div>';

									return tempHtml;
								}								

								 var dataSource = new kendo.data.DataSource({
							    	  serverPaging: true,
							    	  pageSize: 10,
							    	  filter: {
							    	    field: '1',
							    	    operator: 'neq',
							    	    value: '1'
							    	  },
							    	  transport: {
							    	    read: {
							    	      type: 'post',
							    	      dataType: 'json',
							    	      url: '<c:url value="/cmm/system/userAuthorManageView2.do"/>'
							    	    },
							    	    parameterMap: function(data, operation) {									
											var searchKeyword = $("#searchKeyword").val();
											var searchCondition = $("#searchCondition").val();
											data.searchKeyword = searchKeyword ;
											data.searchCondition = searchCondition ;
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

									$("#list").kendoGrid({
					                    dataSource: dataSource,
					                    //height: 400,
					                    scrollable: true,
					                    sortable: true,
					                    filterable: false,
					                    selectable: 'row',
							        	pageable: {
							        	    refresh: false,
							        	    pageSizes: true
								        },
								        autoBind: true,
					                    columns: [
											{ field: "chkAll", title: "<input type='checkbox' id='checkAll' onchange='SelectAll();'/>", width: "30px", filterable: false, sortable: false, 
											    template: "<input type=\"checkbox\"  class=\"check_row\" />"  },
					                        { field: "USERID", title: "사용자ID",  width: "25%" },
					                        { field: "USERNM", title: "사용자명", width: "25%" },
					                        { field: "ORGNZTNM", title: "부서명",  width: "25%" },
					                        { field: "AUTHORCODE", title: "시스템권한",  width: "25%", template: "#= AuthorList(USERID, AUTHORCODE) #" },
					                        { field: "UNIQID", title: "uniqId", hidden:true },
					                        { field: "ORGNZTID", title: "orgnztId", hidden:true }
					                    ],
					                    // row 클릭 이벤트
					                    change: function (arg) {
					                        var selected = $.map(this.select(), function(item) {					                        	
					                        	var userId = $(item).find('td:eq(1)').first().text();
					                        	var userNm = $(item).find('td:eq(2)').first().text();
					                        	var authorCode = $(item).find('td:eq(4)').first().text();					                        	

												$("#orgnztId").val($(item).find('td:eq(6)').first().text());												
												$("#userinfo").text(userNm+"("+userId+")  권한정보 ");
												$("#uniqId").val($(item).find('td:eq(5)').first().text());
												
												$("a[title=등록]").hide();
												$("a[title=삭제]").hide();
												userToauthorList();						                        						                        	
					                        });
					                    } 				                    
					                    
					                });
								} // grid end										
																						
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
							
							<input type="hidden" name="uniqId" id="uniqId" value="">
							<input type="hidden" name="orgnztId" id="orgnztId" value="">							
							
</form>
