<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
 * @title 화면 레이아웃의 컨텐츠 부분 
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 4. 26.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2012. 4. 26.  박기환        최초 생성
 *
 */
%>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=9" />
	<link rel="stylesheet" type="text/css" href="<c:url value='"css/neos/layout.css'/>" />
	<script type="text/javascript" src="<c:url value='js/egovframework/com/cmm/jquery/jquery-1.7.2.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/neos/common.js'/>"></script>
	<!--[if IE 6]>
	<script src="<c:url value='/js/neos/DD_belatedPNG_0.0.8a-min.js'/>"></script>
	<script>
	DD_belatedPNG.fix('.fix');
	DD_belatedPNG.fix('.fix2');
	</script>
	<![endif]--> 
</head>
<body>


		<div id="m_con">
			<div id="content">
				<!--mail list S-->
				<jsp:include page="<c:url value='/NeosShortCut.do'/>"/>
				<!--mail list E//-->
				
				<div class="cont_area">
					<div class="cont_scroll">
						<div class="cont_scroll_inner">
		
						
						<!-- 컨텐츠 시작 -->
					
					
						<c:if test="${loginVO != null}">
							${loginVO.name }님 환영합니다. <a href="<c:url value='/uat/uia/actionLogout.do'/>">로그아웃</a>
						</c:if>
						<c:if test="${loginVO == null }">
							<jsp:forward page="<c:url value='/uat/uia/egovLoginUsr.do'/>"/>
						</c:if>
						
						
						
						
						</div>
					</div>
				</div>
				
			</div>
		</div>
	
		
	
	</body>
</html>
