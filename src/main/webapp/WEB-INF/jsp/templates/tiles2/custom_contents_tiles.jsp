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
		$ ( "#viewLoading" ).hide ( );
		$ ( document ).bind ( "ajaxStart", function ( ) {
			if ( $ ( "#viewLoading" ).css ( "display" ) != "block" ) {
				$ ( "#viewLoading" ).css ( "width", "100%" );
				$ ( "#viewLoading" ).css ( "height", "100%" );
				$ ( "#viewLoading" ).fadeIn ( 100 );
			}
		} ).bind ( "ajaxStop", function ( ) {
			$ ( "#viewLoading" ).fadeOut ( 200 );
		} );
	</script>

	<div id="viewLoading" style="position: absolute; top: 0px; left: 0px; z-index: 9999; text-align: center; background: #ffffff; filter: alpha(opacity = 50); opacity: 0.5; display: none;">
		<iframe id="ifLoading" src="about:blank" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
		<div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 9999; text-align: center;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%;">
				<tr>
					<td style="height: 100%;"><img src='${pageContext.request.contextPath}/customStyle/css/kendoui/Default/loading-image.gif' /></td>
				</tr>
			</table>
		</div>
	</div>

	<tiles:insertAttribute name="body" />

</div><!-- iframe wrap -->
	

