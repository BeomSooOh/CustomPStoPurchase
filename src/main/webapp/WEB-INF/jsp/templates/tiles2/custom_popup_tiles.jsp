<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="/tags/np_taglib" prefix="nptag"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-control" content="no-cache">
</head>
<body>
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	
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
	
</body>
</html>