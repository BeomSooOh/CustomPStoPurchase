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
			
			// puddDialog ??????
			Pudd.puddDialog({
			 
				width : 430
			,	height : 400
			 
			,	modal : true			// ????????? true
			,	draggable : true		// ????????? true
			,	resize : false			// ????????? false
			 
			,	header : {
					title : itemNm
				,	align : "center"	// left, center, right
				,	minimizeButton : false	// ????????? false
				,	maximizeButton : false	// ????????? false
				,	closeButton : true	// ????????? true
				,	closeCallback : function( puddDlg ) {
			 
						// close ????????? ???????????? showDialog( false ) ????????? - ???, ?????? ????????? ???????????? ?????????
						// ???????????? ?????? ????????? ?????? ?????? ???????????? ??????
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
						msgSnackbar("error", "????????? ??????????????? ?????? ??????");
					}	
				}
					    
			});
			
			Pudd("#grid").puddGrid({
				dataSource : dataSource
			,	scrollable : false
			, 	pageSize : 10	// grid??? ???????????? ?????? grid > pageable > pageList ????????? ?????? ??????????????? ???
			,	serverPaging : true	
			//,	ellipsis : true
			,	pageable : {
					buttonCount : 10 
				,	pageList : [ 10, 20, 30, 40, 50 ]
				,	pageInfo : true
				}
			
			,	noDataMessage : {
				message : "????????? ???????????? ????????????."
			}		
			,	progressBar : {
			   	 
					progressType : "loading"
				,	attributes : { style:"width:70px; height:70px;" }
				,	strokeColor : "#84c9ff"	// progress ??????
				,	strokeWidth : "3px"	// progress ??????
				,	percentText : "loading"	// loading ?????? ????????? ?????? - progressType loading ??? ?????????
				,	percentTextColor : "#84c9ff"
				,	percentTextSize : "12px"
				,	backgroundLayerAttributes : { style : "background-color:#fff;filter:alpha(opacity=0);opacity:0;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
			}	
			
			,	columns : [
				
					<c:if test="${params.multiYn == 'Y'}">
					{
						field : "gridCheckBox"		// grid ?????? checkbox ????????? ?????? ????????? ??????
					,	width : 34
					,	editControl : {
							type : "checkbox"
						,	basicUse : true
						}
					},	
					</c:if>	
					{
						field : "prdctImgUrl"
					,	title : "?????????"
					,	width : 50
					,	content : {
						template : function( rowData ) {
							return "<img onclick='viewImgPop(\""+rowData.prdctImgUrl+"\", \""+rowData.prdctClsfcNoNm+"\");' style='max-width:40px;' src=" + rowData.prdctImgUrl + " />";
						}
					}					
					},					
					
					{
						field : "cntrctCorpNm"
					,	title : "?????????"
					,	width : 50
					},
					{
						field : "entrprsDivNm"
					,	title : "????????????"
					,	width : 90
					},
					{
						field : "cntrctMthdNm"
					,	title : "????????????"
					,	width : 70
					},	
					{
						field : "cntrctPrceAmt"
					,	title : "??????????????????"
					,	width : 50
					,	content : {
							template : function( rowData ) {
								return rowData.cntrctPrceAmt.replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " ???";
							}
						}					
					},
					{
						field : "prdctUnit"
					,	title : "??????"
					,	width : 50
					},	
					{
						field : "prdctSplyRgnNm"
					,	title : "???????????????"
					,	width : 50
					},
					{
						field : "prdctMakrNm"
					,	title : "????????????"
					,	width : 50
					},
					{
						field : "prdctLrgclsfcCd"
					,	title : "????????????"
					,	width : 50
					},
					{
						field : "prdctMidclsfcCd"
					,	title : "???????????????"
					,	width : 50
					},
					{
						field : "prdctClsfcNoNm"
					,	title : "??????"
					,	width : 50
					},
					{
						field : "dtilPrdctClsfcNoNm"
					,	title : "????????????"
					,	width : 50
					},
					{
						field : "prdctClsfcNo"
					,	title : "????????????"
					,	width : 50
					},
					{
						field : "prdctIdntNo"
					,	title : "????????????"
					,	width : 50
					},
					{
						field : "prodctCertList"
					,	title : "??????????????????"
					,	width : 50
					,	tooltip : {
							alwaysShow : false		// ????????? ????????? ???????????? tooltip ????????? ????????? ??????, ????????? false
						,	showAtClientX : false	// toolTip ???????????? ????????? mouse ???????????? X ?????? ?????? ??????, ????????? false ( toolTip ???????????? ?????? )
						,	attributes : { style : "" }
						}					
					},
					{
						field : "rgstDt"
					,	title : "????????????"
					,	width : 55
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
				 
				// e.detail ???????????? customEvent param ?????????
				var evntVal = e.detail;
			 
				if( ! evntVal ) return;
				if( ! evntVal.trObj ) return;
			 
				// dataSource?????? ????????? row data
				rowData = evntVal.trObj.rowData;
			 
				// grid ????????? ????????? ????????????
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
<!-- ??????------------------------------------------------------->
	<div class="pop_wrap_dir">
		
	
		<!-- ???????????? -->
           <div class="top_box">
			<dl>
				<dt class="ar" style="width:60px;">????????????</dt>
				<dd>
					<input type="text" id="inqryBgnDate" value="${params.inqryBgnDate}" class="puddSetup" pudd-type="datepicker"/> ~
					<input type="text" id="inqryEndDate" value="${params.inqryEndDate}" class="puddSetup" pudd-type="datepicker"/>
				</dd>
			</dl>
			<dl class="next2">
				<dt class="ar" style="width:60px;">???????????????</dt>
				<dd><input input id="prdctIdntNoNm" type="text" pudd-style="width:100%;" class="puddSetup" placeHolder="?????????????????? ??????" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
				<dt class="ar" style="width:60px;">??????</dt>
				<dd><input id="prdctClsfcNoNm" type="text" pudd-style="width:100%;" class="puddSetup" placeHolder="?????? ??????" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
				<dt class="ar" style="width:60px;">????????????</dt>
				<dd><input input id="dtilPrdctClsfcNoNm" type="text" pudd-style="width:100%;" class="puddSetup" placeHolder="?????????????????? ??????" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
				<dd><input onclick="BindGrid();" type="button" class="puddSetup submit" id="searchButton" value="??????" /></dd>
			</dl>
		</div>
	
        <div class="com_ta">
        	<div id="grid"></div>
		</div>
    </div><!-- //pop_wrap -->
<!--// ??????----------------------------------------------------- -->
</body>
</html>