<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="cloud.CloudConnetInfo"%>
<%@ page import="bizbox.orgchart.util.JedisClient"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="/tags/np_taglib" prefix="nptag"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
   String langCode = (session.getAttribute("langCode") == null ? "KR" : (String)session.getAttribute("langCode")).toUpperCase();
   //팝업타이틀 명을 해당 고객사의 그룹웨어 명으로 변경 
   String groupSeq = (session.getAttribute("loginGroupSeq") == null ? "" : (String)session.getAttribute("loginGroupSeq"));
   JedisClient jedis = CloudConnetInfo.getJedisClient();
   String gwTitle = jedis.getOptionValue(groupSeq, "0", "CM", "gwTitle");
   if(gwTitle.equals("")){
	  gwTitle = "Bizbox Alpha";  
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-control" content="no-cache">
	<title><%=gwTitle%></title>
</head>
<body>
	<jsp:useBean id="currentTime" class="java.util.Date" />
	<script>console.log('<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMddHH"/>');</script>

	<!--  kendo ui CSS  -->
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/kendoui/kendo.common.min.css'></link>
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/kendoui/kendo.default.min.css'></link>
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/kendoui/kendo.dataviz.min.css'></link>
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/kendoui/kendo.dataviz.default.min.css'></link>
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/kendoui/kendo.silver.min.css'></link>
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/js/jqueryui/jquery-ui.css'></link>
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/common.css'></link>
	<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/reKendo.css'></link>
	
	<!--  jquery ui CSS  -->

	<!--  kendo JS  -->
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/kendoui/jquery.min.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/kendoui/kendo.all.min.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/kendoui/kendo.core.min.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/kendoui/cultures/kendo.culture.ko-KR.min.js'></script>

	<!--  jquery JS  -->
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/jqueryui/jquery-ui.min.js'></script>
	
	<!--  datatables JS  -->
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/jquery.dataTables.min.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.select.min.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.scroller.min.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.fixedHeader.min.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.rowReorder.min.js'></script>

	<script type="text/javascript" src='${pageContext.request.contextPath}/js/neos/common.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/neos/common.kendo.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/neos/NeosUtil.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/neos/NeosCodeUtil.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/Scripts/common.js'></script>
	<script type="text/javascript" src='${pageContext.request.contextPath}/js/Controls.js'></script>
	
	<!-- 푸딩 -->
    <script type="text/javascript" src='<c:url value="/js/pudd/pudd-1.1.179.min.js"></c:url>'></script>
    
    <!-- 푸딩 css -->
	<link rel="stylesheet" type="text/css" href='<c:url value="/css/pudd.css"></c:url>'/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/re_pudd.css' />">
	
	<script type="text/javascript">
		/* tiles : popup_tiles.jsp */
  		var langCode = "<%=langCode%>";
		_g_contextPath_ = "${pageContext.request.contextPath}";
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

	<div id="viewLoading" style="position: absolute; top: 0px; left: 0px; z-index: 9999; text-align: center; display: none;">
		<iframe id="ifLoading" src="about:blank" frameborder="0" width="100%" height="100%" scrolling="no"></iframe>
		<div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; z-index: 9999; text-align: center;">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 100%;">
				<tr>
					<td style="height: 100%;"><img src='${pageContext.request.contextPath}/css/kendoui/Default/loading-image.gif' /></td>
				</tr>
			</table>
		</div>
	</div>
	<tiles:insertAttribute name="body" />
</body>
</html>