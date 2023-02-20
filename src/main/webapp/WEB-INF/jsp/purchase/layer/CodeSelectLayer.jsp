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
				 
				data : exData			// 직접 data를 배열로 설정하는 옵션 작업할 것
			 
			//,	pageSize : 20			// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
			,	serverPaging : false
			});
			 
			Pudd( "#grid" ).puddGrid({
			 
				dataSource : dataSource
			 
			//,	scrollable : true
			,	height : 300
 
			,	pageable : {
					buttonCount : 10
				,	pageList : [ 10, 20, 30, 40, 50 ]
				}

			,	resizable : false
			 
			,	columns : [
				
					<c:if test="${params.multiYn == 'Y'}">
					{
						field : "gridCheckBox"		// grid 내포 checkbox 사용할 경우 고유값 전달
					,	width : 34
					
					,	editControl : {
							type : "checkbox"
						,	dataValueField : "code"		// value값을 datasource와 매핑하는 경우 설정
						,	basicUse : true
			 
						,	header : {
			 
								initControl : function( controlObj ) {
									controlObj.attr( "name", "exCheckBoxHeader" );
								}
							}
						,	content : {
								initControl : function( controlObj, rowData ) {
			 
									// dataSource에서 전달하는 rowData의 필드에 seq 등을 사용하여 name 고유값 할당하거나 그리드 호출영역에서 임의 변수 사용하여 할당
									var nameStr = "exCheckBoxContent" + rowData.code;
									controlObj.attr( "name", nameStr );
								}
							}
						}
					},
					</c:if>	
					
					
					{
						field : "code"
					,	title : "코드"
					,	width : 100
					}
				,	{
						field : "name"
					,	title : "코드명"
					,	width : 100
					}
				]
			});		
			
			<c:if test="${params.multiYn == 'N'}">
			Pudd( "#grid" ).on( "gridRowClick", function( e ) {
				 
				// e.detail 항목으로 customEvent param 전달됨
				var evntVal = e.detail;
			 
				if( ! evntVal ) return;
				if( ! evntVal.trObj ) return;
			 
				// dataSource에서 전달된 row data
				rowData = evntVal.trObj.rowData;
			 
				// grid 이벤트 관련된 처리부분
			});	
			</c:if>
			
			
		});
		
		 
	
		
	
			
	</script>
</head>
<body>
<!-- 팝업------------------------------------------------------->
	<div class="pop_wrap_dir" style="width:370px;">
        <div class="com_ta">
        	<div id="grid"></div>
		</div>
    </div><!-- //pop_wrap -->
<!--// 팝업----------------------------------------------------- -->
</body>
</html>