<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib uri="/tags/np_taglib" prefix="nptag"%>
<%String langCode = (session.getAttribute("langCode") == null ? "KR" : (String)session.getAttribute("langCode")).toUpperCase();%>

<html style="min-width: 860px">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-control" content="no-cache">
<!-- <base target="_self">  <base target="_parent">  -->

<!--Kendo ui css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.common.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.default.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.default.min.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.mobile.all.min.css' />" />

<!-- Theme -->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.silver.min.css' />" />

<!--css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css'/>" />

<!--Kendo UI customize css-->
<link rel="stylesheet" type="text/css" href="<c:url value='/css/reKendo.css'/>" />

<script type="text/javascript" src="<c:url value='/js/kendoui/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/neos/common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/common.kendo.js' />"></script>
<%-- <script type="text/javascript" src="<c:url value='/js/neos/resize_iframe.js' />"></script> --%>
<script type="text/javascript" src="<c:url value='/js/neos/neos_common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/neos/NeosCodeUtil.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.core.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.all.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/kendoui/cultures/kendo.culture.ko-KR.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Scripts/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/neos/lump.NeosCodeUtil.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/plugins/multifile/jquery.MultiFile.js' />"></script>
<script type="text/javascript">
	var langCode = "<%=langCode%>";
	$("#viewLoading").hide();
	$(function() {
		pop_loading();
	});
	// edward contents loading Bar
	function pop_loading() {
		$("#pop_loading").css("visibility", "hidden");
		$("#pop_contents").css("visibility", "visible");
		$("#pop_loading").fadeOut();
		$("#pop_contents").fadeIn();
	}
</script>
</head>
<body>
	<div id="pop_loading" style="position: fixed; top: 50%; left: 50%; margin-top: -5px; margin-left: -8px;">
		<img src="<c:url value='/Images/ajax-loader.gif' />" />
	</div>
	<div id="viewLoading" style="position: absolute; top: 0px; left: 0px; z-index: 9999; text-align: center; background: #ffffff; filter: alpha(opacity = 60); opacity: alpha*0.6; display: none;">
		<iframe id="ifLoading" src="about:blank" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
		<div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 9999; text-align: center;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%;">
				<tr>
					<td style="height: 100%;"><img src="<c:url value='/Images/ajax-loader.gif' />"></td>
				</tr>
			</table>
		</div>
	</div>
	<div id="pop_contents" style="visibility: hidden;">
		<tiles:insertAttribute name="body" />
	</div>
</body>
<script type="text/javascript">
	/* tiles : approvalDoc.jsp */
	_g_contextPath_ = "${pageContext.request.contextPath}";
</script>
</html>