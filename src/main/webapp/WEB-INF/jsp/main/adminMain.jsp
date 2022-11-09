<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

<div id="reldiv2">
   <br /><span class="bold">EXP 관리자 메인</span>
</div>
<style>
	span.bold { font-weight: bold;font-size:40px }
	#reldiv2 {
	   z-index: 99;
	   width:94%;
	   height: 100px;  
	   position: absolute;
	   top: 400px;   
	   border: 1px dashed #669966;
	   background-color: #ccffcc;
	   margin: 0px 50px 0px 50px;
	   text-align: center; 
	     
	}
</style> 

<div class="main_wrap">
		
		<!-- 1단 -->
		<div class="con_left">			
			<!-- 접속자 정보 -->
			<iframe id="iframeUserInfo" name="" class="mb8" src="" frameborder="0" scrolling="no" width="228" height="224" ></iframe>
			<!-- 공지사항 -->
			<iframe id="" name="" class="mb8" src="" frameborder="0" scrolling="no" width="228" height="224" ></iframe>	
			<!-- 설문조사 -->
			<iframe id="" name="" src="" frameborder="0" scrolling="no" width="228" height="224" ></iframe>				
		</div>
		
		<!-- 중앙 -->
		<div class="con_center mb8">						
			<!-- 중앙배너 -->
			<div class="cc_banner mb8 ptl">
				<iframe id="" name="" src="" frameborder="0" scrolling="no" width="700" height="340" ></iframe>
			</div>

			<div class="cc_cen mb8">
				<!-- 좌측배너 -->
				<iframe id="" name="" src="" frameborder="0" scrolling="no" width="346" height="166" ></iframe>	
				<!-- 우측배너 -->
				<iframe id="" name="" src="" class="ml4" frameborder="0" scrolling="no" width="346" height="166" ></iframe>
			</div>
			
			<div class="cc_bot">				
				<!-- 2단 -->
				<iframe id="" name="" src="" frameborder="0" scrolling="no" width="346" height="166"></iframe>					
				<!-- 3단 -->
				<iframe id="" name="" src="" class="ml4" frameborder="0" scrolling="no" width="346" height="166" ></iframe>	
			</div>
		</div>


		<!-- 4단 -->
		<div class="con_right">
			<!-- 일정 -->
			<iframe id="" name="" src="" class="mb8" frameborder="0" scrolling="no" width="228" height="456" ></iframe>			
			<!-- 노트 -->
			<iframe id="" name="" src="" frameborder="0" scrolling="no" width="228" height="224" ></iframe>
		</div>

	</div>
	
	<!-- quick link -->
	<div class="main_quick">
		<iframe id="" name="" src="" frameborder="0" scrolling="no" width="100%" height="108"></iframe>	
	</div>
	
	<script type="text/javascript">
	  $(window).load(function() {
		  var iframes = $("iframe");
		  var page = ["notice", "poll", "main_banner", "Mbanner_L", "Mbanner_R", "M_approval", "M_defer", "M_calendar", "note", "quick"];
		  for(var i = 0; i < iframes.length; i++) {
			  var iframe = iframes[i];
			  if (i == 0) { 
				  $(iframe).attr("src","userInfo.do");
			  } else { 
				  $(iframe).attr("src","mainTempPage.do?page="+page[i-1]);
			  }
		  } 
	  }); 
	  
	</script>
