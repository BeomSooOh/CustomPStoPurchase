<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
	
	<script type="text/javascript">
	$(document).ready(function() {		
		//출근퇴근
		$(".tab_content").hide();
		$(".tab_content:first").show();

		$("ul.tabs li").click(function () {
			$("ul.tabs li").css("color", "#89b5d6");
			$(this).addClass("active").css("color", "#fff");
			$(".tab_content").hide();
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).show();
		});
		
	}); 
	</script>	

<div class="userinfo ptl">
	<!-- 접속자 정보 -->
	<div class="user">
		<div class="user_pic">
			<div class="bg_pic"></div>
			<span class="img_pic">
				<img class="userImg" src="<c:url value='/cmm/file/fileDownloadProc.do?fileId=${picFileId}&fileSn=0' />" onerror="this.src='Images/temp/pic_Noimg.png'" alt="" />
				<!-- <img src="../../../Images/bg/pic_Noimg.png" alt="" /> 프로필이미지가 없을경우 입니다.-->
			</span>				
		</div>

		<div class="mb10 name">${loginVO.name} ${loginVO.classNm}</div>
		<div class="Scon_ts">${positionInfo.pathName}</div>
		</div>
	</div>
	
	<!-- 출근/퇴근 -->
	<div class="worktime">
		<div id="container">
			<ul class="tabs">
				<li class="active" rel="tab1">출근</li>
				<li rel="tab2">퇴근</li>
			</ul>
			<div class="tab_container">
				<div id="tab1" class="tab_content"><em>출근</em> 2015.03.31 화요일 08:31:09</div>
				<div id="tab2" class="tab_content"><em>퇴근</em> 2015.03.31 화요일 08:31:09</div>
			</div>
		</div>
	</div>

</div>
