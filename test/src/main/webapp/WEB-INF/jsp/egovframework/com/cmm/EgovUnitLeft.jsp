<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>eGovFrame 공통 컴포넌트</title>
<link href="<c:url value='/css/egovframework/com/com.css' />" rel="stylesheet" type="text/css">
</head>

<body>
<c:set var="isUserSet" value="false"/>
<c:set var="isAdminSet" value="false"/>
<c:set var="isMasterSet" value="false"/>

<c:set var="isExSet" value="false"/>

<c:set var="isUserExOptionSet" value="false"/>
<c:set var="isAdminExOptionSet" value="false"/>
<c:set var="isMasterExOptionSet" value="false"/>

<c:set var="isUserYesilSet" value="false"/>
<c:set var="isAdminYesilSet" value="false"/>

<c:set var="isUserNpReport" value="false"/>

<c:set var="isUserNpStat" value="false"/>
<c:set var="isAdminNpStat" value="false"/>
<c:set var="isAdminNpReport" value="false"/>
<c:set var="isAdminNpYesil" value="false"/>

<c:set var="isUserTripTestPage" value="false"/>
<c:set var="isUserTripSetting" value="false"/>
<c:set var="isUserTripReport" value="false"/>
<c:set var="isAdminTripReport" value="false"/>

<c:set var="isCmmModule" value="false"/>
<c:set var="isInterlock" value="false"/>
<c:set var="isDevMng" value="false"/>
<c:set var="isBuildMng" value="false"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<c:if test="${isMasterExOptionSet == 'false' && result.gid == 90}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>사용자 지출결의(90)</h1>
				</td>
			</tr>
			<c:set var="isMasterExOptionSet" value="true"/>
		</c:if>
		<c:if test="${isUserSet == 'false' && result.gid == 100}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>사용자 설정(100)</h1>
				</td>
			</tr>
			<c:set var="isUserSet" value="true"/>
		</c:if>
		<c:if test="${isAdminSet == 'false' && result.gid == 110}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>관리자 설정(110)</h1>
				</td>
			</tr>
			<c:set var="isAdminSet" value="true"/>
		</c:if>
		<c:if test="${isMasterSet == 'false' && result.gid == 120}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>마스터 설정(120) / 미사용</h1>
				</td>
			</tr>
			<c:set var="isMasterSet" value="true"/>
		</c:if>
		<c:if test="${isExSet == 'false' && result.gid == 130}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>지출결의 작성(130)</h1>
				</td>
			</tr>
			<c:set var="isExSet" value="true"/>
		</c:if>		
		<c:if test="${isUserExOptionSet == 'false' && result.gid == 140}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>사용자 지출결의 현황(140)</h1>
				</td>
			</tr>
			<c:set var="isUserExOptionSet" value="true"/>
		</c:if>		
		<c:if test="${isAdminExOptionSet == 'false' && result.gid == 150}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>관리자 지출결의 현황(150)</h1>
				</td>
			</tr>
			<c:set var="isAdminExOptionSet" value="true"/>
		</c:if>		
		<c:if test="${isMasterExOptionSet == 'false' && result.gid == 160}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>마스터 지출결의 현황(160) / 미사용</h1>
				</td>
			</tr>
			<c:set var="isMasterExOptionSet" value="true"/>
		</c:if>				
		<c:if test="${isUserYesilSet == 'false' && result.gid == 170}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>사용자 예실대비 현황(170)</h1>
				</td>
			</tr>
			<c:set var="isUserYesilSet" value="true"/>
		</c:if>	
		<c:if test="${isAdminYesilSet == 'false' && result.gid == 180}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>관리자 예실대비 현황(180)</h1>
				</td>
			</tr>
			<c:set var="isAdminYesilSet" value="true"/>
		</c:if>	
		<c:if test="${isUserNpStat == 'false' && result.gid == 310}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[NP 통합] 회계 개발자 테스트 메뉴 (310)</h1>
				</td>
			</tr>
			<c:set var="isUserNpStat" value="true"/>
		</c:if>
		<c:if test="${isUserNpReport == 'false' && result.gid == 400}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[NP 사용자] 비영리 회계 사용자 현황 (400)</h1>
				</td>
			</tr>
			<c:set var="isUserNpReport" value="true"/>
		</c:if>
		<c:if test="${isAdminNpStat == 'false' && result.gid == 410}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[NP 관리자] 비영리 회계 관리자 설정 (410)</h1>
				</td>
			</tr>
			<c:set var="isAdminNpStat" value="true"/>
		</c:if>
		<c:if test="${isAdminNpReport == 'false' && result.gid == 411}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[NP 관리자] 비영리 회계 관리자 현황 (411)</h1>
				</td>
			</tr>
			<c:set var="isAdminNpReport" value="true"/>
		</c:if>
		
		<c:if test="${isAdminNpYesil == 'false' && result.gid == 412}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[NP 관리자] 비영리 예실대비현황 (412)</h1>
				</td>
			</tr>
			<c:set var="isAdminNpYesil" value="true"/>
		</c:if>
		
		<c:if test="${isUserTripTestPage == 'false' && result.gid == 500}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[출장복명] 사용자 테스트 메뉴 (500)</h1>
				</td>
			</tr>
			<c:set var="isUserTripTestPage" value="true"/>
		</c:if>
		
		<c:if test="${isUserTripSetting == 'false' && result.gid == 510}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[출장복명] 관리자 설정 메뉴 (510)</h1>
				</td>
			</tr>
			<c:set var="isUserTripSetting" value="true"/>
		</c:if>
		
		<c:if test="${isUserTripReport == 'false' && result.gid == 520}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[출장복명] 사용자 출장 현황 메뉴 (520)</h1>
				</td>
			</tr>
			<c:set var="isUserTripReport" value="true"/>
		</c:if>
		
		<c:if test="${isAdminTripReport == 'false' && result.gid == 530}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>[출장복명] 관리자 출장 현황 메뉴 (520)</h1>
				</td>
			</tr>
			<c:set var="isAdminTripReport" value="true"/>
		</c:if>
		
		<c:if test="${isCmmModule == 'false' && result.gid == 910}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>공통사용 모듈(910)</h1>
				</td>
			</tr>
			<c:set var="isCmmModule" value="true"/>
		</c:if>
		<c:if test="${isInterlock == 'false' && result.gid == 920}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>외부 연동(920)</h1>
				</td>
			</tr>
			<c:set var="isInterlock" value="true"/>
		</c:if>
		<c:if test="${isBuildMng == 'false' && result.gid == 980}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>구축 지원(980)</h1>
				</td>
			</tr>
			<c:set var="isBuildMng" value="true"/>
		</c:if>
		<c:if test="${isDevMng == 'false' && result.gid == 990}">
			<tr height = "16">
			    <td align="left" width="100%">
			    	<br><h1>개발 지원(990)</h1>
				</td>
			</tr>
			<c:set var="isDevMng" value="true"/>
		</c:if>

		<tr height = "16">
		    <td align="left" valign="center" width="100%">
		    	<a href="${pageContext.request.contextPath}<c:out value="${result.listUrl}"/>" target="_content" class="link"> <c:out value="${result.order}"/>. <c:out value="${result.name}"/></a>
			</td>
		</tr>
	</c:forEach>
</table>
</body>
</html>
