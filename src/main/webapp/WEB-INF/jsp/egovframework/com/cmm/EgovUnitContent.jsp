<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${loginVO != null}">
		${loginVO.name }님 환영합니다. <a href="${pageContext.request.contextPath }/uat/uia/actionLogout.do">로그아웃</a>
	</c:if>
	<c:if test="${loginVO == null }">
		<jsp:forward page="/uat/uia/egovLoginUsr.do"/>
	</c:if>
	<p/><b>* 화면 설명 *</b><p/>
	왼쪽 메뉴는 메뉴과 관련된 컴포넌트(메뉴관리, 사이트맵 등)들의 영향을 받지 않습니다.<p/>
	각 컴포넌트들을 쉽게 찾아볼 수 있는 바로가기 링크페이지 입니다.<p/>

	<br /><b>* egovframework.com.cmm.web.EgovComIndexController.java 설명 *</b><p/>

	컴포넌트 설치 후 설치된 컴포넌트들을 IncludedInfo annotation을 통해 찾아낸 후<p/>
	화면에 표시할 정보를 처리하는 Controller 클래스<p/><br />
	개발시 메뉴 구조가 잡히기 전에 배포파일들에 포함된 공통 컴포넌트들의 목록성 화면에<p/>
	URL을 제공하여 개발자가 편하게 활용하도록 하기 위해 작성된 것임<p/>
	<b>실 운영 시에는 삭제해서 배포하는 것을 권장함</b><p />

	운영시에 본 컨트롤을 사용하여 메뉴를 구성하는 경우 성능 문제를 일으키거나<p/>
	사용자별 메뉴 구성에 오류를 발생할 수 있음<p />
</body>
</html>