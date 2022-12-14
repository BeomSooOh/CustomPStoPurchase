<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<script type="text/javascript" src="<c:url value='/js/kendoui/jquery.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/js/Scripts/jquery.alsEN-1.0.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/Scripts/jquery.bxslider.min.js' />"></script>


<script type="text/javascript">
$(document).ready(function(){
  	// 배너슬라이드
	  $('.bxslider').bxSlider({
		auto: true,       // 자동 실행 여부
		autoHover: true,  // 마우스 오버시 정지
		mode: 'fade',// 가로 방향 수평 슬라이드 (horizontal(좌우), vertical(상하)', 'fade(제자리)') 
		pager:true,        // 하단 이미지 보기 버튼 
		controls:false,      // 좌,우 컨트롤 버튼 숨기기/보이기
		autoControls:false,  //  슬라이드 시작/멈춤 
		randomStart : false,
		slideSelector:true,
		infiniteLoop:true,
		oneToOneTouch:true,
		autoControlsSelector :true,
		infiniteLoop:true,
		speed: 500        // 이동 속도를 설정		  
	  });
});
</script> 
 </head>
<div class="Mbanner">
	<ul class="bxslider">
		<li><a href="http://www.duzon.com/product/erp/erp02_icube_01" target="_blank"><img src="<c:url value='/Images/temp/Mbanner_R_01.png' />" alt="" /></a></li>
		<li><a href="http://www.duzon.com/product/mobile/mobile03_gw_01" target="_blank"><img src="<c:url value='/Images/temp/Mbanner_R_02.png' />" alt="" /></a></li>
		<li><a href="http://www.duzon.com/product/finance/finance01_bill36524_01" target="_blank"><img src="<c:url value='/Images/temp/Mbanner_R_03.png' />" alt="" /></a></li>
		<li><a href="http://www.duzon.com/product/security/security01_edm_01" target="_blank"><img src="<c:url value='/Images/temp/Mbanner_R_04.png' />" alt="" /></a></li>	 
	</ul>
<div>