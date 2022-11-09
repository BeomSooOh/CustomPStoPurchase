<!-- /**
 * 메뉴명:근태관리>출장여비관리>출장비단가관리>출장지검색팝업
 * jsp명:tripAreaPop.jsp  
 * 작성자:정동주
 * 생성일자:2017.06.19.
 * 수정일자:2017.06.19.
 * 비고: 출장여비관리 출장비단가관리 페이지
 */
 -->
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Cache-control" content="no-cache">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 
 
 	<!--css-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pudd.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/js/pudding/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/animate.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/re_pudd.css">

	<!--js-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudd/pudd-1.1.172.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudding/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pudding/common.js"></script>

</head>
<body>
	<div class="pop_wrap">
		<div class="pop_con">
			<div class="top_box">
				<input type="hidden" id="domesticDiv" name="domesticDiv" value="${domesticDiv}" />
				<input type="hidden" id="areaSeq" name="areaSeq" />
				<input type="hidden" id="areaname" name="areaname" />
				<dl>
					<dt>그룹명</dt>
					<dd><input type="text" autocomplete="off" name="searchWord" id="searchWord" value="" style="width:200px;"/></dd>
					<dd><input type="button" id="searchButton" value="검색" /></dd>
				</dl>
			</div>
		
			<div style="margin:10px 10px"></div>

			<div id="grid"></div>
		</div><!--// pop_con -->
		
		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" id="confirmButton" value="확인" />
				<input type="button" id="closeButton" class="gray_btn" value="취소" />
			</div>
		</div><!-- //pop_foot -->
	</div><!--// pop_wrap -->
</body>


<script type="text/javascript">
var selectedGroupPosition = {};

$(document).ready(function(){
	fnInitClickEvent();
	fnGridSetGroupPositionTable();
});

function fnInitClickEvent(){
	//검색이벤트
	$('#searchButton').click(function(){
		fnGridSetGroupPositionTable();
	});
	
	$("#searchWord").keydown(function (key) {		 
        if(key.keyCode == 13){//키가 13이면 실행 (엔터는 13)
        	fnGridSetGroupPositionTable();
        }
    });
	
	/* 취소 */
	$("#closeButton").click(function () {		 
		self.close();
    });
	
	/* 확인 */
	$("#confirmButton").click(function () {		 
		fnCallPopupCallback(selectedGroupPosition);
    });
	
	Pudd( "#grid" ).on( "gridRowClick", function( e ) {
		var evntVal = e.detail;
	 
		if( ! evntVal ) return;
		if( ! evntVal.trObj ) return;
	 
		// dataSource에서 전달된 row data
		selectedGroupPosition = evntVal.trObj.rowData;
	});
	
	// grid row dblclick
	Pudd( "#grid" ).on( "gridRowDblClick", function( e ) {
		var evntVal = e.detail;
		if( ! evntVal ) return;
		if( ! evntVal.trObj ) return;
		selectedGroupPosition = evntVal.trObj.rowData;

		fnCallPopupCallback(selectedGroupPosition);
	});
}

/* 콜백 호출 */
function fnCallPopupCallback( param ){
	var callbackFuncName = 'setPositionCallback';
	window.opener[callbackFuncName](param);
	self.close();
}


function fnGridSetGroupPositionTable(){
	
	//교통수단목록 조회 그리드 생성
	var LocationData = new Pudd.Data.DataSource({
		 request : {
				url : "<c:url value='/expend/trip/admin/option/AdminTripSettingPageSelect.do'/>"
			,	type : 'post'
			,	dataType : "json"
			,	parameterMapping : function( data ) {
					data.pageType = 'positionGroup';
					data.searchCode =  $("#searchWord").val();
					data.domesticCode = $("#domesticDiv").val();
					data.useYn = 'Y';
				}
		}, result : {
			data : function( response ) {
				return response.result.aaData;
			}, totalCount : function( response ) {
				return response.result.aaData.length;
			}, error : function( response ) {
				alert( "error - Pudd.Data.DataSource.read, status code - " + response.result.resultCode );
			}
		}
	});

	Pudd( "#grid" ).puddGrid({ 
		dataSource : LocationData 
	,	height : 300
	,	scrollable : true 
	,	resizable : true	
	,	columns : [ 
		{
			field : "NO"
		,	title : "no"
		,	width : 40
		}
	,	{
			field:"dutyGroupName"
		,	title:"그룹명"
		}
	,	{
			field:"note"
		,	title:"비고"
		,	width : 60
		,	widthUnit : "%"	
		}
	]
	,noDataMessage : {
		message : "데이터가 존재하지 않습니다."
	}
	});
}

</script>
</html>