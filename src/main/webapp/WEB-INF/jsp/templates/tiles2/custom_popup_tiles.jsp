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
					<td style="height: 100%;"><img src='${pageContext.request.contextPath}/customStyle/css/kendoui/Default/loading-image.gif' /></td>
				</tr>
			</table>
		</div>
	</div>
	<tiles:insertAttribute name="body" />
</body>
</html>