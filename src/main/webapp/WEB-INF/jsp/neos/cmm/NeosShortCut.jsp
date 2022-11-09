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
 * @title 화면 레이아웃의 바로가기 부분
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 4. 24.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2012. 4. 24.  박기환        최초 생성
 *
 */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<title></title>
</head>

<body>
				<div class="mail_area">
					<div class="mail_top">
						<h2>${menuName}</h2>
						<ul>
							<li><a href="#" class="mn07" title="시스템설정">시스템설정</a></li>
							<li><a href="#" class="mn06" title="검색">검색</a></li>
							<li><a href="#" class="mn01" title="메일">메일</a></li>							
							<li><a href="#" class="mn03" title="프린트">프린트</a></li>
							<li><a href="#" class="mn02" title="쪽지">쪽지</a></li>
							<li><a href="#" class="mn04" title="엑셀다운">엑셀다운</a></li>
							<li><a href="#" class="mn05" title="도움말">도움말</a></li>
						</ul>
					</div>							
				</div>
</body>
</html>
