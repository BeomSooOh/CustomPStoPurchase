<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>계약입찰 발주계획 등록</title>

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
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script>  
    <script type="text/javascript" src="<c:url value='/js/jquery.maskMoney.js' />"></script>  
	
	<script type="text/javascript">

		$(document).ready(function() {
			
		});
		
		function fnChangeForm(e){
			
			if($("#formCode").val() == ""){
				$("#editorView")[0].contentWindow.fnEditorHtmlLoad("");
				return;
			}
			
			var reqParam = {};
			reqParam.group = "contentsForm";
			reqParam.code = $("#formCode").val();
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/SelectFormInfo.do" />',
				datatype : 'json',
				data : reqParam,
				async : false,
				success : function(result) {

					$("#editorView")[0].contentWindow.fnEditorHtmlLoad(result.resultData.FORM_HTML);					
					
				},
				error : function(result) {
					msgSnackbar("error", "데이터 요청에 실패했습니다.");
				}
			});			
			
			
			
			
		}
		
		function fnCallBtn(){
			
			if($("#formCode").val() == ""){
				return;
			}
			
			var reqParam = {};
			reqParam.GROUP = "contentsForm";
			reqParam.CODE = $("#formCode").val();
			reqParam.FORM_HTML = $("#editorView")[0].contentWindow.fnEditorContents();
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/SaveFormInfo.do" />',
				datatype : 'json',
				data : reqParam,
				async : false,
				success : function(result) {

					msgSnackbar("success", "저장완료");
					
				},
				error : function(result) {
					msgSnackbar("error", "데이터 요청에 실패했습니다.");
				}
			});				
			
		}		
		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:650px;">
	<div class="pop_sign_head posi_re">


			<select id = "formCode" onchange="fnChangeForm(this)">
				<option value="">--</option>
				<option value="Contract01">구매계약모듈(계약입찰발주계획)</option>
				<option value="Contract02">구매계약모듈(평가회의등록)</option>
				<option value="Contract03">구매계약모듈(평가결과등록)</option>
				<option value="ManualPop01">비품/소모품안내문구관리</option>
			</select>



		<div class="psh_btnbox">
			<div class="psh_right">
				<div class="btn_cen mt8">
					<input type="button" class="psh_btn" onclick="fnCallBtn('save')" value="저장" />
				</div>
			</div>
		</div>
	</div>

	<div class="pop_con" style="overflow: auto; min-height: 460px;">
		<iframe id="editorView" src="/gw/editorView.do" style="min-width:100%;height: 500px;"></iframe>
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->


</body>
</html>