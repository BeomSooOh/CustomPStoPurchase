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
		
		$(document).ready(function() {
			
			//기존설정항목 세팅
			setDynamicSetInfoTrade();
			
		});			

		function saveProc(){
			
			insertDataObject.res_hope_info_list = JSON.stringify(insertDataObject.tradeObjList);
			
				
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/saveHopeInfo.do" />',
				datatype : 'json',
				data : insertDataObject,
				async : true,
				success : function(result) {
					window.parent.dialogEl.showDialog( false );		
				},
				error : function(result) {
					msgSnackbar("error", "데이터 요청에 실패했습니다.");
				}
			});	
			
		}
		
		
		
		function setDynamicSetInfoTrade(){
			
			<c:if test="${hopeStateSetInfoList.size() > 0 }">
			
			var cloneData;
			<c:forEach var="items" items="${hopeStateSetInfoList}" varStatus="status">
			
			cloneData = $('[name="tradeList"] tr[name=dataBase]').clone();
			$(cloneData).show().attr("name", "addData");
			
			$(cloneData).find("[name=tr_seq]").text("${items.tr_seq}");
			$(cloneData).find("[name=tr_name]").text("${items.tr_name}");
			
			$(cloneData).find("[name=tr_reg_number]").text("${items.tr_reg_number}");
			
			if("${items.hope_company_info}" != ""){
				
				commonCodeTargetInfo = [];
				
				$.each("${items.hope_company_info}".split("▦▦"), function( key, val ) {
					var valInfo =  val.split("▦");
					var objInfo = {};
					objInfo.code = valInfo[0];
					objInfo.name = valInfo[1];
					commonCodeTargetInfo.push(objInfo);
					
				});	
				
				commonCodeCallback("ul", $(cloneData).find("[name=hope_company_info_td]"), commonCodeTargetInfo);
			}
			
			if("${items.hope_attach_info}" != ""){
				
				$.each("${items.hope_attach_info}".split("▦▦"), function( key, val ) {
					
					var valInfo =  val.split("▦");
					
					var fileCloneData = $(cloneData).find("[name=hope_attach_info] [name=attachBase]").clone();
					$(fileCloneData).show().attr("name", "addFile");
					$(fileCloneData).find('[name="attachFileName"]').attr("fileid", valInfo[0]);
					$(fileCloneData).find('[name="attachFileName"]').text(valInfo[1]);
					$(fileCloneData).find('[name="attachExtName"]').text(valInfo[2]);	
					
					$(cloneData).find("[name=hope_attach_info]").append(fileCloneData);						
				});				
			}		
			
			$('[name="tradeList"]').append(cloneData);
			
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
					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}
			
			,	body : {
			 
					iframe : true
				,	url : "${pageContext.request.contextPath}/purchase/layer/CodeSelectLayer.do?multiYn=" + multiYn + "&group=" + group
				,	iframeAttribute : {
					id : "dlgFrame"
				}						

			}
			 
				// dialog 하단을 사용할 경우 설정할 부분
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
		
			
	</script>
</head>
<body>
<!-- 팝업----------------------------------------------------- -->
	<div class="pop_wrap_dir" style="width:100%;">
		<div class="com_ta mt10">
			<table name="tradeList" objKey="tradeObjList" objCheckFor="checkVal('obj', 'tradeList', '공급업체', 'mustAlert', '')">
				<colgroup>
					<col width="200"/>
					<col width="150"/>
					<col width="250"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th class="cen">사업자명</th>
					<th class="cen">거래처코드</th>
					<th class="cen">희망기업여부</th>
					<th class="cen">희망기업확인서</th>
				</tr>
				<tr name="dataBase" style="display:none;">
					<td name="tr_name" class="cen"></td>
					<td tbval="Y" tbtype="innerText" name="tr_seq" class="cen"></td>
					<td name="hope_company_info_td">
						<div class="multi_sel" style="width:calc( 100% - 58px);">
							<ul tbval="Y" tbType="ul" name="hope_company_info" class="multibox" style="width:100%;">							
								<li name="dataBase" addCode="" style="display:none;">
									<span name="addName"></span>
									<c:if test="${disabledYn == 'N'}"> 
									<a href="#n" onclick="$(this).closest('li').remove();" class="close_btn"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/sc_multibox_close.png" /></a>
									</c:if>
								</li>
							</ul>								
						</div>
						<div class="controll_btn p0 pt4">	
							<button id="" onclick="commonCodeSelectLayer('hopeCompany', '희망기업여부', 'ul', $(this).closest('td'), 'Y')">선택</button>
						</div>
					</td>									
					<td class="file_add">	
						<ul tbval="Y" tbType="file" name="hope_attach_info" requiredNot="$(this).closest('tr').find('[name=hope_company_info] [addcode=00]').length > 0" class="file_list_box fl">
							<li name="attachBase" style="display:none;">
								<img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" class="fl" alt="">
								<a href="javascript:;" name="attachFileName" onClick="fnDownload(this)" class="fl ellipsis pl5" style="max-width: 250px;"></a>
								<span name="attachExtName"></span>
								<c:if test="${disabledYn == 'N'}"> 
								<a href="javascript:;" onclick="fnDelFile(this)" title="파일삭제"><img src="${pageContext.request.contextPath}/customStyle/Images/btn/close_btn01.png" alt=""></a>
								</c:if>
							</li>
						</ul>
						<span class="fr mt2"><input onclick="fnSearchFile($(this).closest('tr'))" type="button" class="puddSetup" value="파일찾기" /></span>
					</td>								
				</tr>				
			</table>
		</div>	
    </div><!-- //pop_wrap -->
<!--// 팝업----------------------------------------------------- -->
</body>
</html>