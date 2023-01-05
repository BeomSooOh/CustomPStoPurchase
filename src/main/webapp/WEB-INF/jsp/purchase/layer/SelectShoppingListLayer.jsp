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
	
		var selectedList = [];
		var rowData;	
	
		$(document).ready(function() {
			
			BindGrid();
			
		});
		
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
		
		function viewImgPop(imgSrc, itemNm){
			
			// puddDialog 함수
			Pudd.puddDialog({
			 
				width : 430
			,	height : 400
			 
			,	modal : true			// 기본값 true
			,	draggable : true		// 기본값 true
			,	resize : false			// 기본값 false
			 
			,	header : {
					title : itemNm
				,	align : "center"	// left, center, right
				,	minimizeButton : false	// 기본값 false
				,	maximizeButton : false	// 기본값 false
				,	closeButton : true	// 기본값 true
				,	closeCallback : function( puddDlg ) {
			 
						// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
						// 추가적인 작업 내용이 있는 경우 이곳에서 처리
					}
				}
			 
			,	body : {
					iframe : false
				,	content : "<img style='max-width:400;' src=" + imgSrc + " />"
				}
			});			
			
		}
		
		function BindGrid(){
			
			var dataSource = new Pudd.Data.DataSource({
					serverPaging: true
				,	editable : true
				,	pageSize: 10
				,	timeout:600000
				,	request : {
					    url : '<c:url value="/interlock/SelectShoppingList.do" />'
					,	type : 'post'
					,	dataType : "json"
					,   parameterMapping : function( data ) {
						data.inqryDiv = "1";
						data.prdctClsfcNoNm = $("#prdctClsfcNoNm").val();
						data.dtilPrdctClsfcNoNm = $("#dtilPrdctClsfcNoNm").val();
						data.prdctIdntNoNm = $("#prdctIdntNoNm").val();
						data.inqryBgnDate = $("#inqryBgnDate").val();
						data.inqryEndDate = $("#inqryEndDate").val();
						return data;
					}
				}	    
				,   result : {
					data : function(response){
						return response.response.body.items;
					},
					totalCount : function(response){
						return response.response.body.totalCount;	
					},
					error : function(response){
						msgSnackbar("error", "조달청 공공데이터 조회 오류");
					}	
				}
					    
			});
			
			Pudd("#grid").puddGrid({
				dataSource : dataSource
			,	scrollable : false
			, 	pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
			,	serverPaging : true	
			
			,	pageable : {
					buttonCount : 10 
				,	pageList : [ 10, 20, 30, 40, 50 ]
				,	pageInfo : true
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
			
			,	columns : [
				
					<c:if test="${params.multiYn == 'Y'}">
					{
						field : "gridCheckBox"		// grid 내포 checkbox 사용할 경우 고유값 전달
					,	width : 34
					,	editControl : {
							type : "checkbox"
						,	basicUse : true
						}
					},	
					</c:if>	
					{
						field : "prdctImgUrl"
					,	title : "이미지"
					,	width : 50
					,	content : {
						template : function( rowData ) {
							return "<img onclick='viewImgPop(\""+rowData.prdctImgUrl+"\", \""+rowData.prdctClsfcNoNm+"\");' style='max-width:40px;' src=" + rowData.prdctImgUrl + " />";
						}
					}					
					},					
					
					{
						field : "cntrctCorpNm"
					,	title : "계약업체명"
					,	width : 50
					},
					{
						field : "entrprsDivNm"
					,	title : "기업구분명"
					,	width : 90
					},
					{
						field : "cntrctMthdNm"
					,	title : "계약방법명"
					,	width : 70
					},	
					{
						field : "cntrctPrceAmt"
					,	title : "계약가격금액"
					,	width : 50
					,	content : {
							template : function( rowData ) {
								return rowData.cntrctPrceAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원";
							}
						}					
					},
					{
						field : "prdctUnit"
					,	title : "물품단위"
					,	width : 50
					},	
					{
						field : "prdctSplyRgnNm"
					,	title : "물품공급지역명"
					,	width : 50
					},
					{
						field : "prdctMakrNm"
					,	title : "물품제조사명"
					,	width : 50
					},
					{
						field : "prdctLrgclsfcCd"
					,	title : "물품대분류명"
					,	width : 50
					},
					{
						field : "prdctMidclsfcCd"
					,	title : "물품중분류코드"
					,	width : 50
					},
					{
						field : "prdctClsfcNoNm"
					,	title : "품명"
					,	width : 50
					},
					{
						field : "dtilPrdctClsfcNoNm"
					,	title : "세부품명"
					,	width : 50
					},
					{
						field : "prdctClsfcNo"
					,	title : "물품분류번호"
					,	width : 50
					},
					{
						field : "prdctIdntNo"
					,	title : "물품식별번호"
					,	width : 50
					},
					{
						field : "prodctCertList"
					,	title : "제품인증목록"
					,	width : 50
					},
					{
						field : "rgstDt"
					,	title : "등록일시"
					,	width : "10px"
					,	content : {
							template : function( rowData ) {
								if(rowData.rgstDt.length == 8){
									return fnGetDateFormat(rowData.rgstDt);
								}else{
									return rowData.rgstDt;	
								}
							}
						}						
					
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
			
		}			
		 
	
	
		function fnGetDateFormat(text){
			text = ( text || '' ).replace(/[^0-9]/gi, '')
			if(text.length == 8 ){
				return text.substring(0,4) + '-' + text.substring(4,6) + '-' + text.substring(6,8);   
			}else if(text.length == 6 ){
				return text.substring(0,4) + '-' + text.substring(4,6);
			}else if(text.length == 4){
				return text;
			}else {
				return '';
			}
		}		
	
			
	</script>
</head>
<body>
<!-- 팝업------------------------------------------------------->
	<div class="pop_wrap_dir">
		
	
		<!-- 상세검색 -->
           <div class="top_box">
			<dl>
				<dt class="ar" style="width:60px;">등록일자</dt>
				<dd>
					<input type="text" id="inqryBgnDate" value="${params.inqryBgnDate}" class="puddSetup" pudd-type="datepicker"/> ~
					<input type="text" id="inqryEndDate" value="${params.inqryEndDate}" class="puddSetup" pudd-type="datepicker"/>
				</dd>
			</dl>
			<dl class="next2">
				<dt class="ar" style="width:60px;">물품규격명</dt>
				<dd><input input id="prdctIdntNoNm" type="text" pudd-style="width:100%;" class="puddSetup" placeHolder="물품분류번호 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
				<dt class="ar" style="width:60px;">품명</dt>
				<dd><input id="prdctClsfcNoNm" type="text" pudd-style="width:100%;" class="puddSetup" placeHolder="품명 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
				<dt class="ar" style="width:60px;">세부품명</dt>
				<dd><input input id="dtilPrdctClsfcNoNm" type="text" pudd-style="width:100%;" class="puddSetup" placeHolder="물품분류번호 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
				<dd><input onclick="BindGrid();" type="button" class="puddSetup submit" id="searchButton" value="검색" /></dd>
			</dl>
		</div>
	
        <div class="com_ta">
        	<div id="grid"></div>
		</div>
    </div><!-- //pop_wrap -->
<!--// 팝업----------------------------------------------------- -->
</body>
</html>