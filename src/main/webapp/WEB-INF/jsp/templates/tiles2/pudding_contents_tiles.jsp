<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="/tags/np_taglib" prefix="nptag"%>
<%String langCode = (session.getAttribute("langCode") == null ? "KR" : (String) session.getAttribute("langCode")).toUpperCase();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="Cache-control" content="no-cache">
<title>${title}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="/gw/js/manual.js"></script>
</head>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1200px">
	
	<!--Kendo ui css-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.common.min.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.min.css' />">

	<!-- Theme -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.silver.min.css' />" />

	<!--css-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/js/jqueryui/jquery-ui.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/animate.css' />">
	
	<!--Kendo UI customize css-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/reKendo.css' />">
	
	<!-- jquery 1.9.1 -->
	<script type="text/javascript" src='<c:url value="/js/jquery-1.9.1.min.js"></c:url>'></script>
	
	<script type="text/javascript" src="<c:url value='/js/kendoui/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>

	<script type="text/javascript" src="<c:url value='/js/neos/common.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/neos/common.kendo.js' />"></script>

	<script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/neos/NeosCodeUtil.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/jszip.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.all.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/jszip.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/cultures/kendo.culture.ko-KR.min.js'/>"></script>

	<!-- 메인 js -->
	<script type="text/javascript" src="<c:url value='/js/Scripts/jquery.alsEN-1.0.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/Scripts/jquery.bxslider.min.js' />"></script>

	<!--js-->
	<script type="text/javascript" src="<c:url value='/js/Scripts/common.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/Controls.js' />"></script>
	
	<!-- 푸딩 -->
    <script type="text/javascript" src='<c:url value="/js/pudd/pudd-1.1.179.min.js"></c:url>'></script>
    
    <!-- 푸딩 css -->
	<link rel="stylesheet" type="text/css" href='<c:url value="/css/pudd.css"></c:url>'/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/re_pudd.css' />">

	<script>
		var langCode = "<%=langCode%>";
		function init ( ) {
		}

		_g_contextPath_ = "${pageContext.request.contextPath}";

		$ ( document ).ready ( function ( ) {
			$ ( "#menuHistory li:last-child" ).addClass ( "on" );

		} );
	</script>
	
	<!-- 컨텐츠타이틀영역 -->
	<div class="sub_title_wrap">
		<div class="location_info">
			<ul id="menuHistory"></ul>
		</div>
		<div class="title_div">
			<h4></h4>
		</div>
		<div class="btn_manual" onclick="onlineManualPop();">${CL.ex_help}</div>
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
				// 2016.05.18 장지훈 추가 (하드코딩) 마스터 메인 페이지에서 네비게이션 가져오기
				if ( leftList.length == "0" && topMenu.name == "전자결재" ) {
					hstHtml += '<li><a href="#n">결재옵션관리&nbsp;</a></li>';
					hstHtml += '<li><a href="#n">전자결재옵션설정&nbsp;</a></li>';
					$ ( ".title_div" ).html ( '<h4>전자결재옵션설정&nbsp;</h4>' );
				} else {
					$ ( ".title_div" ).html ( '<h4>' + topMenu.name + '&nbsp;</h4>' );
				}

			}

			$ ( "#menuHistory" ).html ( hstHtml );

		} catch ( exception ) {
		}
	</script>
	<tiles:insertAttribute name="body" />
</div>

</html>