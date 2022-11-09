<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="tiles"   uri="http://tiles.apache.org/tags-tiles" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!--수정 배포된 Js파일 캐시 방지  -->
<% Date date = new Date();
   SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMddHHmm");
   String strDate = simpleDate.format(date);   
%>
<c:set var="date" value="<%=strDate%>" />
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko" style="overflow-y:hidden">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>${title}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<!--Kendo ui css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.common.min.css' />">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.dataviz.min.css' />">
    
    <!-- Theme -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/kendoui/kendo.silver.min.css' />" />

	<!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css' />"> 
	
	<!--Kendo UI customize css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/reKendo.css' />">
    
    <!--jstree css-->
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/jsTree/style.min.css' />" />
    
    <link rel="shortcut icon" href="<c:url value='/favicon.ico' />" />
	
    <script type="text/javascript" src="<c:url value='/js/kendoui/jquery.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jquery.form.js'/>"></script>
    
    <script type="text/javascript" src="<c:url value='/js/neos/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/neos/common.kendo.js' />"></script>
    <%-- <script type="text/javascript" src="<c:url value='/js/neos/resize_iframe.js' />"></script> --%>
    <script type="text/javascript" src="<c:url value='/js/neos/neos_common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
    <script type="text/javascript" src="<c:url value='/js/neos/NeosCodeUtil.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.core.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/kendo.all.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/kendoui/cultures/kendo.culture.ko-KR.min.js'/>"></script>
	
    <!--js-->
    <script type="text/javascript" src="<c:url value='/js/Scripts/common.js' />"></script>

    <script type="text/javascript" src="<c:url value='/js/neos/systemx/systemx.menu.js?version=${date}' />"></script>
    <script type="text/javascript" src="<c:url value='/js/neos/systemx/systemx.main.js' />"></script>
    
     <!-- top js -->
    <script type="text/javascript" src="<c:url value='/js/Scripts/jquery.alsEN-1.0.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/js/Scripts/jquery.bxslider.min.js' />"></script>
	<!--jstree js-->
	<script type="text/javascript" src="<c:url value='/js/jsTree/jstree.min.js' />"></script>
    
	<script type="text/javascript">
	$(document).ready(function() {
		// iframe
		var no = '${params.no}';
		var name = '${params.name}';
		var lnbName = '${params.lnbName}';
		var url = '${params.url}';
		var urlGubun = '${params.urlGubun}';
		var mainForward = '${params.mainForward}';
		var gnbMenuNo = '${params.gnbMenuNo}';
		var lnbMenuNo = '${params.lnbMenuNo}';
		var portletType = '${params.portletType}';
		var userSe = '${userSe}';
		$("#userSe").val(userSe);
		
		// GNB 버튼 클릭
		if (mainForward == null || mainForward == '') {
			menu.clickTopBtn(no, name, url, urlGubun);
		} 
		// 메인 iframe 에서 페이지 이동을 누른경우
		else {
			menu.forwardFromMain(portletType, gnbMenuNo, lnbMenuNo, url, urlGubun, name , lnbName , mainForward );
		}
				
	});
	
	//contents iframe 영역에서 메뉴이동을 할경우 
	function menuMove(forwardType, type, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name) {
		menu.move(forwardType, type, gnbMenuNo, lnbMenuNo, url, urlGubun, seq, name);
	}
	
	// 조직도 팝업
	function orgChartPop() {
		var url = "<c:url value='/cmm/systemx/orgChartAllEmpInfo.do'/>";

		openWindow2(url,  "pop", 900, 606, 0) ;
	}
	</script>
     
</head>


<body class="">
	<!-- Header -->
	<div class="header_wrap"> 
		<jsp:include page="/topGnb.do" /> 
	</div> 
	 
	<!-- contents -->
	<div class="contents_wrap">
		<div id="horizontal">
			<div class="side_wrap ea"> 
				<h2 class="sub_nav_title"></h2> 
				<div class="nav_div">
					<div id="sub_nav_jstree" style="border-width:0">
					</div>
				</div>	
			</div>
			<div class="sub_wrap">
				<div class="sub_contents">
						<!-- iframe 영역 -->  
						<iframe name="_content" id="_content" class="" frameborder="0" scrolling="yes" width="100%" height="100%"></iframe>
				</div> 
			</div>  
		</div> <!--//# horizontal -->
			

	  	<div class="footer">
			<span class="copy">
				<c:if test="${!empty txtMap.display_text}">
					${txtMap.display_text}
				</c:if>
				<c:if test="${empty txtMap.display_text}">
					Copyright Duzon Bizon. All right reserved.
				</c:if>
			</span>
			<ul class="sub_etc">
				<c:if test="${!empty loginVO.eaType}">
				<li><a href="javascript:main.fnEaFormPop('${loginVO.eaType}');"><span class="t1">&nbsp;</span>기안작성</a></li>
				<li>|</li>
				</c:if>				<li><a href="javascript:;" onclick="orgChartPop();"><span class="t2">&nbsp;</span>조직도</a></li>
				<li>|</li>
				<!-- <li><a href="javascript:;"><span class="t3">&nbsp;</span>메신져</a></li> -->
				<li><a href="/PC/messenger/BizboxA_PC_Ver2.zip"><span class="t3">&nbsp;</span>메신져</a></li>
				<li>|</li>
				<li><a href="javascript:;"><span class="t4">&nbsp;</span>업무도우미</a></li>
				<li>|</li>
				<li><a href="javascript:appdown_open();"><span class="t5">&nbsp;</span>앱다운로드</a></li>
			</ul>
			<div class="pop_appdown" style="display:none;">
				<div class="appdown_in">
					<a href="javascript:appdown_clo();" class="clo"><img src="/gw/Images/ico/ico_timeline_close.png" alt="닫기"/></a>
					<p class="txt">QR코드를 스캔하시면 비즈박스모바일을 다운받을 수 있는 스토어로 이동합니다.</p>
					<p class="pic"><img src="/gw/Images/temp/bizboxA_App_QR.png" alt="" width="100" height="100"/></p>
					<p class="tit">IOS / Android</p>
				</div>
			</div>
			<c:if test="${!empty imgMap.file_id}">
				<img src="<c:url value='/cmm/file/fileDownloadProc.do?fileId=${imgMap.file_id}&fileSn=0' />" alt="" />
			</c:if>
		</div>
		
	</div> 
	
	<form id="form" name="form" action="bizbox.do" method="post">  
		<input type="hidden" id="no" name="no" value="" />
		<input type="hidden" id="name" name="name" value="" /> 
		<input type="hidden" id="lnbName" name="lnbName" value="" /> 
		<input type="hidden" id="url" name="url" value="" />
		<input type="hidden" id="urlGubun" name="urlGubun" value="" />
		<input type="hidden" id="mainForward" name="mainForward" value="" />
		<input type="hidden" id="gnbMenuNo" name="gnbMenuNo" value="" />
		<input type="hidden" id="lnbMenuNo" name="lnbMenuNo" value="" />
		<input type="hidden" id="seq" name="seq" value="" />
		<input type="hidden" id="portletType" name="portletType" value="" />
		<input type="hidden" id="userSe"  value="" />
	</form> 
	
	<script>
	
		function init(){}
		
		_g_contextPath_ = "${pageContext.request.contextPath}";
	</script>
	<div id="formWindow"></div>	
</body>
</html>
