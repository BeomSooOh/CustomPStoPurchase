<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
/**
 *
 * @title
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 4. 23.
 * @version
 * @dscription
 *
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용
 * -----------  -------  --------------------------------
 * 2012. 4. 23.  박기환        최초 생성
 *
 */
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko" style="overflow-y:hidden">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/jquery-1.7.2.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery/plugins/ui/jquery-ui-1.8.22.custom.js'/>"></script>
	<%@ include file="/WEB-INF/jsp/neos/include/IncludeJstree.jsp" %>
	<%@ page import="egovframework.com.cmm.service.EgovProperties" %>
	<script src="<c:url value='/js/ui.js' />" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/css.css' />" />
	<!-- 보건복지인력개발원의 레이아웃 적용을 위한 css 적용 -->
	<%-- <link rel="stylesheet" type="text/css" href="<c:url value='/css/kohi_index.css' />" />	 --%>
    <%
        String company = EgovProperties.getProperty("Globals.company");
       if(company.equals("kohi")){
     %>
        <link rel="stylesheet" type="text/css" href="<c:url value='/css/kohi_index.css' />" /> 
     <%
        }
       %>
</head>
<script type="text/javascript">
$(function(){
	var mobileInfo = new Array('Android', 'iPhone', 'iPod', 'iPad','BlackBerry', 'Windows CE', 'SAMSUNG', 'LG', 'MOT', 'SonyEricsson');
	for (var info in mobileInfo){
    	if (navigator.userAgent.match(mobileInfo[info]) != null){
        	//$("#wrapper").attr("style","min-width:1300px;");
        	//$("#contentsArea").attr("style","min-width:1300px;");
        	break;
    	}
	}
});

</script>
<body>
<div id="wrapper" style="min-width:1024px;">
	<%--<jsp:include page="/NeosTop.do"/> --%>
	<jsp:include page="/BizboxXTop.do"/>
	<div id="contentsArea" class="clearfx" style="min-width:1024px;">
		<jsp:include page="/NeosLeft.do" />
		<div id="articleArea">
			<iframe name="_content" id="_content" frameborder="0" scrolling="yes" width="100%" height="100%" class="contentsFrame"></iframe>	
		</div>
	</div>
	<jsp:include page="/NeosBottom.do"/>
</div>
<script>
	conHeight();
</script>
</body>
</html>
