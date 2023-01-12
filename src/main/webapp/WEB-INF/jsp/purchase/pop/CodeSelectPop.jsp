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
	
	
	$(document).ready(function() {
		
		$("#headerName").text(opener.commonCodeSelectInfo.codeName);
		BindCodeGrid();
		
	});		
	
	function apply(){
		
		var selectedList = [];
		
		<c:if test="${multiYn == 'Y'}">
		selectedList = Pudd( "#grid" ).getPuddObject().getGridCheckedRowData( "gridCheckBox" );
		</c:if>
		<c:if test="${multiYn == 'N'}">
		
		if(rowData != null){
			selectedList.push(rowData);
		}
		</c:if>

		opener.commonCodeSelectCallback(opener.commonCodeSelectInfo.appendType, opener.commonCodeSelectInfo.targetEl, selectedList);
		this.close();
		
	}
	
	function BindCodeGrid(){
		
		var dataSource = new Pudd.Data.DataSource({
				serverPaging: true
			,	editable : true
			,	pageSize: 10
			,	request : {
				    url : '<c:url value="/purchase/admin/SelectCodeList.do" />'
				,	type : 'post'
				,	dataType : "json"
				,   parameterMapping : function( data ) {
					data.GROUP = "${group}";
					data.SEARCH = $("#searchText").val();
					return data;
				}
			}	    
			,   result : {
				data : function(response){
					return response.list;
				},
				totalCount : function(response){
					return response.totalCount;	
				},
				error : function(response){
					alert("error");
				}	
			}
				    
		});
		
		var colArray = [];
		
		if("${multiYn}" == "Y"){
			colArray.push({
				field : "gridCheckBox"		// grid 내포 checkbox 사용할 경우 고유값 전달
					,	width : 20
					,	editControl : {
							type : "checkbox"
						,	basicUse : true
						}
					,	attributes : { class : "display:none;" }
			});
		}
		
		colArray.push({ field : "CODE",	title : "코드",	width : 50 });			
		colArray.push({ field : "NAME",	title : "코드명",	width : 90 });
		
		Pudd("#grid").puddGrid({
			dataSource : dataSource
		,	scrollable : false
		, 	pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
		,	serverPaging : true	
		
		,	pageable : {
				buttonCount : 10 
			}
		
		,	noDataMessage : {
			message : "검색된 데이터가 없습니다."
		}		
		,	progressBar : {
		   	 
				progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }
			,	strokeColor : "#84c9ff"	// progress 색상
			,	strokeWidth : "3px"	// progress 두께
			,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
			,	percentTextColor : "#84c9ff"
			,	percentTextSize : "12px"
			,	backgroundLayerAttributes : { style : "background-color:#fff;filter:alpha(opacity=0);opacity:0;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
		}	
		
		,	columns : colArray
		
		,	loadCallback : function( headerTable, contentTable, footerTable, gridObj ) {
			
		
	
			}			
		});	
		
		<c:if test="${multiYn == 'N'}">
		Pudd( "#grid" ).on( "gridRowClick", function( e ) {
			 
			var evntVal = e.detail;
		 
			if( ! evntVal ) return;
			if( ! evntVal.trObj ) return;
		 
			rowData = evntVal.trObj.rowData;
			
		});	
		</c:if>		

	}
		
	
			
	</script>
</head>
<body>
<!-- 팝업------------------------------------------------------->

<div class="pop_wrap" style="min-width:370px;">
	<div class="pop_sign_head posi_re">
		<h1 id="headerName"></h1>
	</div>
	
	<div class="top_box">
		<dl>
			<dt class="ar" style="width:90px;">코드 / 코드명</dt>
			<dd><input type="text" id="searchText" pudd-style="width:150px;" class="puddSetup" placeHolder="코드/코드명 검색" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindCodeGrid(); }"/></dd>
			<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" onclick="BindCodeGrid();" /></dd>
		</dl>
	</div>	
	
    <div class="com_ta">
	   	<div id="grid"></div>
	</div>
	
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input onclick="apply();" type="button" value="확인" />
		</div>
	</div><!-- //pop_foot -->	
	
</div>


<!--// 팝업----------------------------------------------------- -->
</body>
</html>