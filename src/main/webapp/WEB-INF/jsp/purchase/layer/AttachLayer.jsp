<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    
    <!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/common.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/re_pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/animate.css' />">
	    
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/pudd/pudd-1.1.200.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>   
    
	<script type="text/javascript">
			/*팝업 위치설정*/
			$(document).ready(function() {
				pop_position();
				$(window).resize(function() { 
					pop_position();
				});
				
				$(".file_input_button").on("click",function(){
					$(this).next().click();
				});
			});
	</script>
</head>
<body>
<!-- 팝업----------------------------------------------------- -->
	<div class="pop_wrap_dir" style="width:770px;">
        <div class="com_ta">
			<table>
				<colgroup>
					<col width="370"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="al pl10">
						<span>1. 일상감사요청서</span>
						<span class="fr ea_title_tooltip" onClick=""><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td class="file_add">	
						<ul class="file_list_box fl">
							<li>
								<img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" class="fl" id="" alt="">
								<a href="javascript:;" class="fl ellipsis pl5" style="max-width:235px;" id="">업체요구사항업체요구사항 정의서업체요구사항업체요구사항정의서업체요구사항업체요구사항 정의서</a>
								<span>.jpg</span>
								<a href="javascript:;" id="" title="파일삭제"><img src="${pageContext.request.contextPath}/customStyle/Images/btn/close_btn01.png" id="" alt=""></a>
							</li>
						</ul>
						<span class="fr"><input type="button" class="puddSetup" value="파일찾기" /></span>
					</td>
				</tr>
				<tr>
					<th class="al pl10">
						<span>2. 사전규격공개 <img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /></span>
						<span class="fr ea_title_tooltip" onClick=""><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td class="file_add">	
						<ul class="file_list_box fl">
							<li>
								<img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" class="fl" id="" alt="">
								<a href="javascript:;" class="fl ellipsis pl5" style="max-width:235px;" id="">업체요구사항 정의서</a>
								<span>.jpg</span>
								<a href="javascript:;" id="" title="파일삭제"><img src="${pageContext.request.contextPath}/customStyle/Images/btn/close_btn01.png" id="" alt=""></a>
							</li>
						</ul>
						<span class="fr"><input type="button" class="puddSetup" value="파일찾기" /></span>
					</td>
				</tr>
				<tr>
					<th class="al pl10">
						<span>3. 입찰공고문 <img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /></span>
						<span class="fr ea_title_tooltip" onClick=""><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td></td>
				</tr>
				<tr>
					<th class="al pl10">
						<span>4. 제안요청서 <img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /></span>
						<span class="fr ea_title_tooltip" onClick=""><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td></td>
				</tr>
				<tr>
					<th class="al pl10">
						<span>5. 과업내용서</span>
						<span class="fr ea_title_tooltip" onClick=""><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td></td>
				</tr>
				<tr>
					<th class="al pl10">
						<span>6. 부당계약특수조건 발주부서 체크리스트 <img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /></span>
						<span class="fr ea_title_tooltip" onClick=""><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td></td>
				</tr>
				<tr>
					<th class="al pl10">
						<span>7. 산출내역서 <img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" /></span>
						<span class="fr ea_title_tooltip" onClick=""><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td></td>
				</tr>
				<tr>
					<th class="al pl10">
						<span>8. 청렴계약이행서약서</span>
						<span class="fr ea_title_tooltip" onClick=""><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td></td>
				</tr>
			</table>
		</div>

		<div class="mt10">※ <img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" />는 반드시 업로드 하셔야 합니다.</div>
          
  
    </div><!-- //pop_wrap -->
<!--// 팝업----------------------------------------------------- -->
</body>
</html>