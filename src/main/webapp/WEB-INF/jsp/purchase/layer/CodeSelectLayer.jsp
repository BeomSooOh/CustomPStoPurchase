<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    
    <!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/common.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/re_pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/animate.css' />">
	    
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/pudd/pudd-1.1.200.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>   
    
	<script type="text/javascript">
	
		var exData = [];
		var tempObj = {};
		var rowData;
		
		<c:forEach var="items" items="${codeList}">
		tempObj = {};
		tempObj.code = "${items.CODE}";
		tempObj.name = "${items.NAME}";
		tempObj.note = "${items.NOTE}";
		tempObj.link = "${items.LINK}";
		exData.push(tempObj);
		</c:forEach>	
		
		var selectedList = [];
		
		function fnDlgFrameFunc(){
			
			<c:if test="${params.multiYn == 'Y'}">
			parent.commonCodeTargetInfo = Pudd( "#grid" ).getPuddObject().getGridCheckedRowData( "gridCheckBox" );
			</c:if>
			<c:if test="${params.multiYn == 'N'}">
			parent.commonCodeTargetInfo = [];
			if(rowData != null){
				parent.commonCodeTargetInfo.push(rowData);
			}
			</c:if>			
			
		}
		
		function fnGetSelectedList(){
			
			<c:if test="${params.multiYn == 'Y'}">
			selectedList = Pudd( "#grid" ).getPuddObject().getGridCheckedRowData( "gridCheckBox" );
			</c:if>
			<c:if test="${params.multiYn == 'N'}">
			selectedList = [];
			if(rowData != null){
				selectedList.push(rowData);
			}
			</c:if>	
			
			return selectedList;
			
		}		
		
		$(document).ready(function() {
			
			var dataSource = new Pudd.Data.DataSource({
				 
				data : exData			// ?????? data??? ????????? ???????????? ?????? ????????? ???
			 
			//,	pageSize : 20			// grid??? ???????????? ?????? grid > pageable > pageList ????????? ?????? ??????????????? ???
			,	serverPaging : false
			});
			 
			Pudd( "#grid" ).puddGrid({
			 
				dataSource : dataSource
			 
			//,	scrollable : true
			,	height : 300
			/* 
			,	pageable : {
					buttonCount : 10
				,	pageList : [ 10, 20, 30, 40, 50 ]
				}
			*/ 
			,	resizable : false
			 
			,	columns : [
				
					<c:if test="${params.multiYn == 'Y'}">
					{
						field : "gridCheckBox"		// grid ?????? checkbox ????????? ?????? ????????? ??????
					,	width : 34
					
					,	editControl : {
							type : "checkbox"
						,	dataValueField : "code"		// value?????? datasource??? ???????????? ?????? ??????
						,	basicUse : true
			 
						,	header : {
			 
								initControl : function( controlObj ) {
									controlObj.attr( "name", "exCheckBoxHeader" );
								}
							}
						,	content : {
								initControl : function( controlObj, rowData ) {
			 
									// dataSource?????? ???????????? rowData??? ????????? seq ?????? ???????????? name ????????? ??????????????? ????????? ?????????????????? ?????? ?????? ???????????? ??????
									var nameStr = "exCheckBoxContent" + rowData.code;
									controlObj.attr( "name", nameStr );
								}
							}
						}
					},
					</c:if>	
					
					
					{
						field : "code"
					,	title : "??????"
					,	width : 100
					}
				,	{
						field : "name"
					,	title : "?????????"
					,	width : 100
					}
				]
			});		
			
			<c:if test="${params.multiYn == 'N'}">
			Pudd( "#grid" ).on( "gridRowClick", function( e ) {
				 
				// e.detail ???????????? customEvent param ?????????
				var evntVal = e.detail;
			 
				if( ! evntVal ) return;
				if( ! evntVal.trObj ) return;
			 
				// dataSource?????? ????????? row data
				rowData = evntVal.trObj.rowData;
			 
				// grid ????????? ????????? ????????????
			});	
			</c:if>
			
			
		});
		
		 
	
		
	
			
	</script>
</head>
<body>
<!-- ??????------------------------------------------------------->
	<div class="pop_wrap_dir" style="width:370px;">
        <div class="com_ta">
        	<div id="grid"></div>
		</div>
    </div><!-- //pop_wrap -->
<!--// ??????----------------------------------------------------- -->
</body>
</html>