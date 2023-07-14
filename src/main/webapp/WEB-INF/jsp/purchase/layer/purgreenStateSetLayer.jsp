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
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js?ver=20230111' />"></script>
    
	<script type="text/javascript">
	
		var insertDataObject = {};
		
		$(document).ready(function() {
			
			 setDynamicSetInfoTrade();  
			
		});		
		
		
		
		function commonCodeSelectCallback(type, target, selectedList){
			
			if(type == "ul"){
				$(target).find('[name=addData]').remove();
				$.each(selectedList, function( idx, addData ) {
					var cloneData = $(target).find('[name=dataBase]').clone();
					$(cloneData).show().attr("name", "addData");
					$(cloneData).attr("addCode", addData.CODE);
					$(cloneData).find("[name=addName]").text(addData.NAME);
					$(target).find('ul').append(cloneData);				
				});									
			}else if(type == "text"){

				if(selectedList.length > 0){
					$(target).find("[codetarget]").val(selectedList[0].NAME);
				}
			}			
			
		}
	
		
		
		function setDynamicSetInfoTrade(){
			
			<c:if test="${greenStateSetInfo.size() > 0 }">
			
			var cloneData;
			<c:forEach var="items" items="${greenStateSetInfo}" varStatus="status">
			
			cloneData = $('[name="attachFileListTable"] tr[name=dataBase]').clone();
			$(cloneData).show().attr("name", "addData");
			  
			

			$(cloneData).find("[name=item_green_class]").val("${items.item_green_class}");
			
			
	
				$(cloneData).find("[name=tr_seq]").text("${items.tr_seq}");
				$(cloneData).find("[name=tr_name]").text("${items.tr_name}");
				
				if("${items.out_process_interface_m_id}" == "" || "${items.out_process_interface_m_id}" == null){
					$(cloneData).find("[name=out_process_interface_m_id]").text("1");
					$(cloneData).find("[name=out_process_interface_id]").text("1");
				} else {
					$(cloneData).find("[name=out_process_interface_m_id]").text("${items.out_process_interface_m_id}");
					$(cloneData).find("[name=out_process_interface_id]").text("${items.out_process_interface_id}");	
				}
				
				

	
			
			if("${items.item_green_cert_type}" == "" && "${items.p_item_green_cert_type}" != ""){
				
				commonCodeTargetInfo = [];
				
				$.each("${items.p_item_green_cert_type}".split("▦▦"), function( key, val ) {
					var valInfo =  val.split("▦");
					var objInfo = {};
					objInfo.code = valInfo[0];
					objInfo.name = valInfo[1];
					commonCodeTargetInfo.push(objInfo);
					
				});	 
				
				commonCodeCallback("ul", $(cloneData).find("[name=green_certifi_info_td]"), commonCodeTargetInfo);
				
				
			}  else if("${items.item_green_cert_type}" != ""){
				
				commonCodeTargetInfo = [];
				
				$.each("${items.item_green_cert_type}".split("▦▦"), function( key, val ) {
					var valInfo =  val.split("▦");
					var objInfo = {};
					objInfo.code = valInfo[0];
					objInfo.name = valInfo[1];
					commonCodeTargetInfo.push(objInfo);
					
				});	 
				
				commonCodeCallback("ul", $(cloneData).find("[name=green_certifi_info_td]"), commonCodeTargetInfo);
				
			} else if ("${items.p_item_green_cert_type}" == "") {
				$(cloneData).find("[name=item_green_cert_type]").val("");
			} else {
				$(cloneData).find("[name=item_green_cert_type]").val("");
			}
			
			
			
			if("${items.item_green_class}" == "" ){
				$(cloneData).find("[name=item_green_class]").val("${items.p_item_green_class}");	
			} else {
				$(cloneData).find("[name=item_green_class]").val("${items.item_green_class}");
			}
		
			
			$('[name="attachFileListTable"]').append(cloneData);
			
			
			</c:forEach>			
			</c:if>	
			
			
		}	
		
		function commonCodeSelectLayer(group, title, type, target, multiYn){

			Pudd.puddDialog({
			 
				width : 400
			,	height : 500
			 
			,	modal : true			// 기본값 true
			,	draggable : false		// 기본값 true
			,	resize : false			// 기본값 false
			 
			,	header : {
		 		title : title
			,	closeButton : false	// 기본값 true
			,	closeCallback : function( puddDlg ) {
				}
			}
			
			,	body : {
			 
					iframe : true
				,	url : "${pageContext.request.contextPath}/purchase/layer/CodeSelectLayer.do?multiYn=" + multiYn + "&group=" + group
				,	iframeAttribute : {
					id : "dlgFrame"
				}						

			}
			 
			,	footer : {
			
					buttons : [
						
						{
							attributes : {}// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnConfirm", class : "submit" }// control 자체 객체 속성 설정
						,	value : "확인"
						,	clickCallback : function( puddDlg ) {
							var iframeTag = document.getElementById( "dlgFrame" );
							commonCodeCallback(type, target, iframeTag.contentWindow.fnGetSelectedList());
							puddDlg.showDialog( false );
							}
						}
					]
				}
			});			
			
		}			

		function commonCodeCallback(type, target, selectedList){
			
			if(type == "ul"){	
				$(target).find('[name=addData]').remove();
				$.each(selectedList, function( idx, addData ) {
					var cloneData = $(target).find('[name=dataBase]').clone();
					$(cloneData).show().attr("name", "addData");
					$(cloneData).attr("addCode", addData.code);
					$(cloneData).find("[name=addName]").text(addData.name);
					$(target).find('ul').append(cloneData);				
				});									
			}else if(type == "text"){

				if(selectedList.length > 0){
					$(target).find("[codetarget]").val(selectedList[0].name);
				}
				
			}
		}	    
		
		function fnValidationCheck(){
			insertDataObject = {};
			
			var validationCheck = true;
			
			$.each($("[objKey]"), function( key, objInfo ) {
				
				var objValue = eval($(objInfo).attr("objCheckFor"));
				
				if(objValue == "$failAlert$"){
					validationCheck = false;
					return false;
				}
				
				insertDataObject[$(objInfo).attr("objKey")] = objValue;
				
			});
			
			return validationCheck;
		}
		

		function saveProc(){
			
			if(fnValidationCheck() == true){
			
			insertDataObject.res_doc_seq = "${params.resDocSeq}";
			
			
			insertDataObject.res_green_info_list = JSON.stringify(insertDataObject.greenObjList); 
			
				
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
	}
	</script>
</head>
<body>
<!-- 팝업----------------------------------------------------- -->

	<div class="pop_wrap_dir" style="width:100%;">
        <div class="com_ta">
			<!-- <table name="attachFileListTable" objKey="greenObjList" objCheckFor="checkVal('obj', 'tradeList', '공급업체', 'mustAlert', '')"> -->
			<table name="attachFileListTable" objKey="greenObjList" objCheckFor="checkVal('obj', 'attachFileListTable', '녹색제품 인증구분', 'mustAlert', '')">
				<colgroup>
					<col width="150"/>
					<col width="100"/>
					<col width="250"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="cen">업체명</th>
					<th class="cen">거래처코드</th>
					<th class="cen">녹색제품 인증구분</th>
					<th class="cen">녹색제품 분류</th>
				</tr>
				<tr name="dataBase" style="display:none;">
				<td name="tr_name" class="cen"></td>
				<td tbval="Y" tbtype="innerText" name="tr_seq" class="cen"></td>
				<td name="green_certifi_info_td">
						<div class="multi_sel" style="width:calc( 100% - 58px);">
							<ul tbval="Y" tbname="녹색제품인증구분" tbType="ul" id="item_green_cert_type" name="item_green_cert_type" class="multibox" style="width:100%;">							
								<li name="dataBase" addCode="" style="display:none;">
									<span name="addName"></span>
									<a href="#n" onclick="$(this).closest('li').remove();" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a>
								</li>
							</ul>								
						</div>
						<div class="controll_btn p0 pt4">	
							<button id="" onclick="commonCodeSelectPop('greenCertType', '녹색제품인증구분', 'ul', $(this).closest('td'), 'Y')">선택</button>
						</div>
					</td>	
					<td>
						<select tbval="Y" tbname="제품분류" id="item_green_class" name="item_green_class"  style="width:100%;">
							<c:forEach var="items" items="${greenClassCode}">
							<option value="${items.CODE}">${items.NAME}</option>
							</c:forEach>						
						</select>					
					</td>
				<td tbval="Y" tbtype="innerText" name="out_process_interface_m_id" class="cen" style="display:none;"></td>
				<td tbval="Y" tbtype="innerText" name="out_process_interface_id" class="cen"  style="display:none;"></td>					
				</tr>
			</table>
		</div>
    </div><!-- //pop_wrap -->
<!--// 팝업----------------------------------------------------- -->
</body>
</html>