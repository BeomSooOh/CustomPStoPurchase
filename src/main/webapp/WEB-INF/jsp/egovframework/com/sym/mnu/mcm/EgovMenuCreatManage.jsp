<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovMenuCreatManage.jsp
  * @Description : 메뉴생성관리 조회 화면
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.10    이용          최초 생성
  *
  *  @author 공통서비스 개발팀 이용
  *  @since 2009.03.10
  *  @version 1.0
  *  @see
  *
  */
     
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" >
<title><spring:message code="system.menu.manage.title" /></title>
<style type="text/css">
	h1 {font-size:12px;}
	caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>

<script  language="javascript1.2" type="text/javaScript">
<!--
$(function(){
	$("#shoutCutTitle").html('<spring:message code="system.menu.manage.title" />');
	$(window).resize(function(){		
		jqGridUtil.resizeJqGrid("board_table");
	});	
});

/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuCreatManageSelect(){
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
	document.menuCreatManageForm.pageIndex.value = pageNo;
	document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
   	document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuCreatManageList() {
	document.menuCreatManageForm.pageIndex.value = 1;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/*검색 클릭*/
function submit() {
	$("#searchKeyword").val($("#searchKeyword").val() );
	
    var query = {
 			page:1,
 			pageSize:10
	};
	dataSource.query(query);
 };
/*검색 클릭 (검색시 page number)*/
function keeppaging() {
	$("#pageIndex").val();
	$("form").submit();
};


<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
</script>
</head>
<body>
<!--    EDWARD       -->
<form name="menuCreatManageForm" action ="<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>" method="post">
<input name="checkedMenuNoForDel" type="hidden" />
<input name="authorCode"          type="hidden" />
<input type="hidden" name="req_menuNo">

<div class="searchArea clearfx" id="" >
        <span class="bulit"><spring:message code="system.menu.manage.menuId" /> <input type="text" name="searchKeyword" id="searchKeyword" style="width:200px;" value=""  onkeyup="javascript:if(event.keyCode==13){selectMenuCreatManageList(); return false;}"/></span>
        <a href="javascript:selectMenuCreatManageList();" ><img src="<c:url value='/images/btn/btn_search.gif' />" alt="검색"  width="55" height="26"/></a>
</div>

		<div class="board_table mT20" style="" id="board_table">
			<table id="list" ></table>
			<!-- table id="jsonData" ></table -->
			
		</div>

		<script type="text/javascript">
			$(function(){
				//BindjqGrid();
				BindKendoGrid();

		         var query = {
		        		    pageSize: 10,
		         			page:1
		        		  };
		         dataSource.query(query);
				
			});	
			
			/*
			function BindjqGrid(){
				var jsondata = $.parseJSON('${list_menumanage}');
				//$("#jsonData").html( '${list_menumanage}');
				var obj = {};
				obj.option = {  
					data: jsondata, 
					datatype: 'local', 
					colNames:[
			          	'<spring:message code="system.menu.manage.rule.code" />',
			          	'<spring:message code="system.menu.manage.rule.name" />',
			          	'<spring:message code="system.menu.manage.rule.desc" />',
			          	'<spring:message code="system.menu.manage.existYN" />',
			          	'<spring:message code="system.menu.manage.create.menu" />'
					 ], 
					colModel:[ 
					{name:'authorCode', index:'authorCode', align:'center' }, 
					{name:'authorNm', index:'authorNm',  align:'center'},  //, formatter : jqGridUtil.TextOverFlow
					{name:'authorDc', index:'authorDc', align:'left', formatter : textStyle },										
					{name:'chkYeoBu', index:'chkYeoBu',  align:'center', formatter : fn_menuYn},	  //  0 = N  , Y 
					{name:'authorCode', index:'authorCode',  align:'center', formatter : fn_createMenu}
					], 
						//multiselect:true,
						emptyrecords:"<spring:message code='common.nodata.msg' />" ,  // 데이터가 존재하지 않습니다.
						loadComplete  : function(){
							jqGridUtil.tableRowStyle("list");
							jqGridUtil.setEmptyData(obj, "board_table");
							$.jqGrid = {};
							$.jqGrid.data = {"0":"150px", "1":"250px","2":"","3":"150px","4":"150px"};
							$.jqGrid.min = jqGridUtil.minWidth();
							jqGridUtil.resizeJqGrid("board_table");
						}
						
					//,height:"700px"
				};
				//공통으로 적용할 옵션 가져오기
				obj = jqGridUtil.jqGridCommonOption(obj);
				//alert('obj : '+obj);
				//alert('option : '+obj.option);
				$("#list").jqGrid(obj.option);
			}
			*/

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
		    	      url: '<c:url value="/sym/mnu/mcm/EgovMenuCreatManageSelect2.do"/>'
		    	    },
		    	    parameterMap: function(data, operation) {									
						var searchKeyword = $("#searchKeyword").val();
						data.searchKeyword = searchKeyword ;
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
				var jsondata = $.parseJSON('${list_menumanage}');				
				
				$("#board_table").kendoGrid({
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
                        { field: "authorCode", title: "권한코드",  width: "130px" },
                        { field: "authorNm", title: "권한명", width: "130px" },
                        { field: "authorDc", title: "권한 설명",  width: "130px" },
                        { field: "chkYeoBu", title: "메뉴생성여부",  width: "130px", template: "#= fn_menuYn(chkYeoBu) #" },
                        { field: "authorCode", title: "메뉴생성", width: "50px", template: "#= fn_createMenu(authorCode) #" }                        
                    ]
                });
			} // grid end			
			
			function textStyle(cellvalue, options, rowObject){
				if(cellvalue ==null){
					cellvalue = "";
				}
				return  '<DIV style="TEXT-OVERFLOW: ellipsis; OVERFLOW: hidden; cursor:pointer" ><NOBR>'+cellvalue+'</NOBR> </DIV>';
			};
				
			function fn_createMenu(cellvalue, options, rowObject){
				var menu_make_btn = "<c:url value='/images/neos/popup/icon_arrow.gif'/>";
				//return "<div class='btn_center'><a href='javascript:;' onclick='selectMenuCreat(\""+cellvalue+"\")' class='defaultBtn'><spring:message code='system.menu.manage.create.menu'/> <img src='"+menu_make_btn+"' class='fix' /></a></div>";
				return "<a href='javascript:;' onclick='selectMenuCreat(\""+cellvalue+"\")' class='defaultBtn'><span><spring:message code='system.menu.manage.create.menu'/></span></a>";
			}

			function fn_menuYn(cellvalue, options, rowObject){
				if(cellvalue==0)	return "N";
				else				return "Y";									
			}

			function selectMenuCreat(authorCode) {
				document.menuCreatManageForm.authorCode.value = authorCode;
			   	document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>";
			   	document.menuCreatManageForm.submit();
			}
		</script>


</form>
</body>
</html>

