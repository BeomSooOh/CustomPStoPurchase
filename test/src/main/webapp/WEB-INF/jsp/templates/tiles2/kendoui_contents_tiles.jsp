<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%String langCode = (session.getAttribute("langCode") == null ? "KR" : (String)session.getAttribute("langCode")).toUpperCase();%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko" style="overflow-y:hidden">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-control" content="no-cache">
<title>${title }</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	/* tiles : contents_tiles.jsp */
	_g_contextPath_ = "${pageContext.request.contextPath}";
</script>
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<c:url value='/js/neos/common.js' />"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/neos/resize_iframe.js' />"></script> --%>
<script type="text/javascript" src="<c:url value='/js/neos/neos_common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/NeosCodeUtil.js' />"></script>
<%--  ======================================================================================= --%>


<%--  ======================================================================================= --%>

<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/reKendo.css' />" />

<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.common.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.mobile.all.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.silver.min.css' />" />

<script type="text/javascript" src="<c:url value='/js/kendoui/jquery.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.all.min.js' />"></script>

<script type="text/javascript">
	var langCode = "<%=langCode%>";
	$("#viewLoading").hide();
	$(function() {
		loading();
		var src = NeosUtil.getCalcImg();
		$("img[src*='" + src + "']").addClass("fix");
		//$("#contents", parent.document).css("padding-right", "25px");

	});
	// edward contents loading Bar
	function loading() {

		$("#loading").css("display", "none");
		$("#noes_contents").css("display", "");

		$("#loading").fadeOut();
		$("#noes_contents").fadeIn();
	}
</script>
<%--  ======================================================================================= --%>
<script type="text/javascript" src="<c:url value='/js/ui.js'/>"></script>

</head>
<body>
	<div id="loading" style="position: fixed; top: 50%; left: 50%; margin-top: -5px; margin-left: -8px;">
		<img src="<c:url value='/Images/ajax-loader.gif' />" />
	</div>
	<div id="viewLoading" style="position: absolute; top: 0px; left: 0px; z-index: 9999; text-align: center; background: #ffffff; filter: alpha(opacity = 50); opacity: 0.5; display: none;">
		<iframe id="ifLoading" src="about:blank" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
		<div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 9999; text-align: center;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%;">
				<tr>
					<td style="height: 100%;"><img src="<c:url value='/Images/ajax-loader.gif' />"></td>
				</tr>
			</table>
		</div>
	</div>
	<div id="viewOverActivex" style="position: absolute; top: 0px; left: 0px; z-index: 9999; text-align: center; background: #ffffff; filter: alpha(opacity = 50); opacity: 0.5; display: none;">
		<iframe id="viewLoadingPage" src="about:blank" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
		<div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 888; text-align: center;"></div>
	</div>
	<!-- 
	<div id="conHead">
		<h2 id="shoutCutTitle"></h2>
	</div>
 -->
	<div id="contents">
		<div id="subContentsArea">
			<!-- 하단여백문제로 div 추가 -->
			<!-- BODY Start -->
			<tiles:insertAttribute name="body" />
			<!-- BODY End -->
		</div>
	</div>
</body>



<script>
	/*
	 var  isCallHeight = false ;
	 var objInterval ;

	 function callChngHeight() {
	 try {
	 if (isCallHeight == false )  {
	 parent.conHeight();
	 clearInterval(objInterval);
	 }
	 isCallHeight = true ;
	 } catch(ignore) {}
	 }
	 objInterval = setInterval("callChngHeight()", 10) ;
	 */
	function init() {
		/*
		 var cont_pad_height = $("body").height();
		 var ifrm_height = $(window).height();

		 if(ifrm_height-cont_pad_height<0){
		 $("contents", parent.document).css("overflow-y", "yes");
		 }
		 */
	}
</script>

</body>
</html>