<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="/tags/np_taglib" prefix="nptag"%>
<%String langCode = (session.getAttribute("langCode") == null ? "KR" : (String) session.getAttribute("langCode")).toUpperCase();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
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
	<script>
	var langCode = "<%=langCode%>";
		function init ( ) {
		}

		_g_contextPath_ = "${pageContext.request.contextPath}";

		$ ( document ).ready ( function ( ) {
			$ ( "#menuHistory li:last-child" ).addClass ( "on" );

		} );
	</script>
</head>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:980px;">

	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="location_info">
			<ul id="menuHistory"></ul>
		</div>
		<div class="title_div">
			<h4></h4>
		</div>
	</div>		
	
	<script>
		try {

			var topMenu = parent.getTopMenu ( );

			var hstHtml = '<li><a href="#n"><img src="'+_g_contextPath_+'/Images/ico/ico_home01.png" alt="홈">&nbsp;</a></li>';
			hstHtml += '<li><a href="#n">' + topMenu.name + '&nbsp;</a></li>';

			var leftList = parent.getLeftMenuList ( );

			if ( leftList != null && leftList.length > 0 ) {
				for ( var i = leftList.length - 1; i >= 0; i-- ) {
					hstHtml += '<li><a href="#n">' + leftList [ i ].name + '&nbsp;</a></li>';
				}

				$ ( ".title_div" ).html ( '<h4>' + leftList [ 0 ].name + '&nbsp;</h4>' );
			} else {
				$ ( ".title_div" ).html ( '<h4>' + topMenu.name + '&nbsp;</h4>' );
			}

			$ ( "#menuHistory" ).html ( hstHtml );

		} catch ( exception ) {
		}
	</script>			

	<script type="text/javascript">
	
	$(document).ready(function() {
		
		// 예제로 임의로 구성함
		var customContentsTilesPercent = 0;
		
		$ ( document ).bind ( "ajaxStart", function ( ) {
			
			customContentsTilesPercent = 0;
						
			Pudd( "#customContentsTiles" ).puddProgressBar({
				 
				progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }
			 
			,	strokeColor : "#84c9ff"	// progress 색상
			,	strokeWidth : "3px"	// progress 두께
			 
			,	textAttributes : { style : "" }		// text 객체 속성 설정
			 
			,	percentText : "loading"	// loading 표시 문자열 설정 - progressType : loading, juggling 인 경우만 해당
			,	percentTextColor : "#84c9ff"
			,	percentTextSize : "12px"
			,	backgroundLayerAttributes : { style : "background-color:#000;filter:alpha(opacity=20);opacity:0.05;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
			 
				// 200 millisecond 마다 callback 호출됨
			,	progressCallback : function( progressBarObj ) {

				return customContentsTilesPercent;
				
				}
			});			
						

		} ).bind ( "ajaxStop", function ( ) {
			
			customContentsTilesPercent = 100;
						
		} );		
		
		
	});
	</script>

	<tiles:insertAttribute name="body" />
	<div id="customContentsTiles"></div>
</div><!-- iframe wrap -->
	

