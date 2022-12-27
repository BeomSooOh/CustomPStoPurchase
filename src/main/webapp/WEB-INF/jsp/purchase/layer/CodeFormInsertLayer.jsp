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
    
	<script type="text/javascript">

	function GetInsertCodeInfo(){
		var insertCodeInfo = {};
		insertCodeInfo.CODE = $("[name=CODE]").val();
		insertCodeInfo.NAME = $("[name=NAME]").val();
		insertCodeInfo.NOTE = $("[name=NOTE]").val();
		insertCodeInfo.ORDER_NUM = $("[name=ORDER_NUM]").val();
		insertCodeInfo.USE_YN = $("[name=USE_YN]").val();
		insertCodeInfo.LINK = $("[name=REQIRED_YN]").val() + "▦▦";
		
		return insertCodeInfo;
	}
			
	</script>
</head>
<body>
<!-- 팝업----------------------------------------------------- -->
	<div class="pop_wrap_dir" style="width:100%;">
        <div class="com_ta">
			<table name="attachFileListTable">
				<colgroup>
					<col width="100"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="ac pl10">양식코드</th>
					<td><input name="CODE" type="text" pudd-style="width:100%;" class="puddSetup" /></td>
				</tr>
				<tr>
					<th class="ac pl10">양식명</th>
					<td><input name="NAME" type="text" pudd-style="width:100%;" class="puddSetup" /></td>
				</tr>
				<tr>
					<th class="ac pl10">필수여부</th>
					<td><select name="REQIRED_YN" style="width:50px;text-align:center;">
							<option value="N">N</option>
							<option value="Y">Y</option>
						</select>
					</td>
				</tr>				
				<tr>
					<th class="ac pl10">정렬</th>
					<td><input name="ORDER_NUM" type="text" pudd-style="width:100%;" class="puddSetup" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" /></td>
				</tr>
				<tr>
					<th class="ac pl10">사용여부</th>
					<td><select name="USE_YN" style="width:50px;text-align:center;">
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
    </div><!-- //pop_wrap -->
<!--// 팝업----------------------------------------------------- -->
</body>
</html>