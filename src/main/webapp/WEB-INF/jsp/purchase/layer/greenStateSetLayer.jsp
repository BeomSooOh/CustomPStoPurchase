<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script>
    
	<script type="text/javascript">
	
		var insertDataObject = {};

		function saveProc(){
			
			insertDataObject.res_doc_seq = "${params.resDocSeq}";
			insertDataObject.item_green_cert_type = $("#item_green_cert_type").val();
			insertDataObject.item_green_class = $("#item_green_class").val();
			
			if(insertDataObject.item_green_cert_type != "" && insertDataObject.item_green_class == ""){
				msgSnackbar("error", "필수항목 (녹색제품 분류) 을 입력해 주세요.")
			}
				
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/saveGreenInfo.do" />',
				datatype : 'json',
				data : insertDataObject,
				async : true,
				success : function(result) {
					window.parent.msgSnackbar("success", "저장완료");
					window.parent.dialogEl.showDialog( false );		
				},
				error : function(result) {
					msgSnackbar("error", "데이터 요청에 실패했습니다.");
				}
			});	
			
		}		
			
	</script>
</head>
<body>
<!-- 팝업----------------------------------------------------- -->
	<div class="pop_wrap_dir" style="width:100%;">
        <div class="com_ta">
			<table name="attachFileListTable">
				<colgroup>
					<col width="200"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="ac pl10">녹색제품 인증구분</th>
					<td>
						<select type="select" id="item_green_cert_type" class="puddSetup" pudd-style="width:100%;">
							<c:forEach var="items" items="${greenCertTypeCode}">
								<c:if test="${ items.CODE != '' }">
								<option value="${items.CODE}" <c:if test="${ items.CODE == greenStateSetInfo.item_green_cert_type }">selected</c:if> >${items.NAME}</option>
								</c:if>
							</c:forEach>							
						</select>					
					</td>
				</tr>
				<tr>
					<th class="ac pl10">녹색제품 분류</th>
					<td>
						<select type="select" id="item_green_class" class="puddSetup" pudd-style="width:100%;">
							<c:forEach var="items" items="${greenClassCode}">
								<c:if test="${ items.CODE != '' }">
								<option value="${items.CODE}" <c:if test="${ items.CODE == greenStateSetInfo.item_green_class }">selected</c:if> >${items.NAME}</option>
								</c:if>
							</c:forEach>							
						</select>					
					</td>					
				</tr>
			</table>
		</div>
    </div><!-- //pop_wrap -->
<!--// 팝업----------------------------------------------------- -->
</body>
</html>