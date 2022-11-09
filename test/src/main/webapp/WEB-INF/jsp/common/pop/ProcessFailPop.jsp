<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>bizbox A</title>

	<!--css-->
    <link rel="stylesheet" type="text/css" href="../../../css/common.css">
	    
    <!--js-->
    <script type="text/javascript" src="../../../Scripts/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../../../Scripts/common.js"></script>
        
	<script type="text/javascript">
		$(document).ready(function() {	

			//기본버튼
			$(".controll_btn button").kendoButton();
			$("#type_sel").kendoComboBox({
		        dataSource : {
					data : ["전체","종결"]
		        },
		        value:"전체"
		    });
			
	        var data = ${colData};
	        
// 	        console.log(data);
	        for(var i = 0 ; i < data.length ; i++ ){
				var item = data[i];
	        	var tr = "";
				tr += "<tr>"
				tr += "	<td>"+ (item.colGbn || '알림') +"</td>"
				tr += "	<td class=\"le\">" + item.colDetail + "</td>"
				tr += "</tr>"
				
				$('#mainTblBody').append(tr);
	        }
	        
	        $('#btnConfirm').click(function(){
	        	window.close();
	        	parent.focus();
	        });
	        
	        reSize();
		}); 
		
		function reSize(){
			var strWidth = $('.pop_wrap').outerWidth() + (window.outerWidth - window.innerWidth);
			var strHeight = $('.pop_wrap').outerHeight() + (window.outerHeight - window.innerHeight);
			
			$('.pop_wrap').css("overflow","auto");
			
			var isFirefox = typeof InstallTrigger !== 'undefined';
			var isIE = false || !!document.documentMode;
			var isEdge = !isIE && !!window.StyleMedia;
			var isChrome = !!window.chrome && !!window.chrome.webstore;
			
			if(isFirefox){
				
			}if(isIE){

			}if(isEdge){
				strWidth = 380;
				strHeight = 447;
			}if(isChrome){
				strHeight += 10;
			}
			
			try{
				var childWindow = window.parent;
				childWindow.resizeTo(strWidth, strHeight);	
			}catch(exception){
				console.log('window resizing cat not run dev mode.');
			}
		}
	</script>

</head>

<body>
<div class="pop_wrap">
	<div class="pop_head">
		<h1>${pageTitle}</h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>	
	
	<div class="pop_con">
		<div class="com_ta2">
			<table>
				<colgroup>
					<col width="170"/>
					<col width=""/>
				</colgroup>
				<thead>
					<tr>
						<th>${colGbn}</th>
						<th>${colDetail}</th>
					</tr>
				</thead>
			</table>		
		</div>

		<div class="com_ta2 scroll_y_on bg_lightgray" style="height:259px;">
		<table class="brtn">
			<colgroup>
				<col width="170"/>
				<col width=""/>
			</colgroup>
			<tbody id="mainTblBody">
			</tbody>
		</table>		
	</div>


	</div><!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" value="확인" id="btnConfirm"/>
		</div>
	</div><!-- //pop_foot -->

</div><!--// pop_wrap -->
</body>
</html>