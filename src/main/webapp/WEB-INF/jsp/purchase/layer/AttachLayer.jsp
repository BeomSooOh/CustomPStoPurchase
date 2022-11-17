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
	
			var UploadCallback = "";
			var targetElement;
			var uploadPer = 0;
	
			/*팝업 위치설정*/
			$(document).ready(function() {
				
				parent.attachFileNew = [];
				parent.attachFileDel = [];				
				
				document.getElementById('file_upload').addEventListener('change', handleFileSelect, false);
				
				$.each(parent.attachFormList, function( key, attchFormInfo ) {

					var cloneData = $('[name="fileInfoBase"]').clone();
					$(cloneData).show().removeAttr("name");
					$(cloneData).attr("attachFormCode",attchFormInfo.code);
					
					$(cloneData).find('[name="formName"]').text((key+1) + ". " + attchFormInfo.formNm);
					
					if(attchFormInfo.mustYn == "Y"){
						$(cloneData).find('[name="mustImg"]').show();	
					}
					
					if(attchFormInfo.formFileId != ""){
						$(cloneData).find('[name="formFile"]').show();	
						
						$(cloneData).find('[name="formFile"]').attr("fileid", attchFormInfo.formFileId);
						$(cloneData).find('[name="formFile"]').attr("title", attchFormInfo.formFileNm);
					}						
					
					if(attchFormInfo.fileId != ""){
						$(cloneData).find('[name="uploadFile"]').show();
						
						$(cloneData).find('[name="uploadFileName"]').attr("fileid", attchFormInfo.fileId);
						$(cloneData).find('[name="uploadFileName"]').text(attchFormInfo.fileName);
						$(cloneData).find('[name="uploadFileExt"]').text(attchFormInfo.fileExt);
					}					
					
					$('[name="attachFileListTable"]').append(cloneData);					
					
				});				
				
			});
			
			function getUUID() {
				  return 'xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
				    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 3 | 8);
				    return v.toString(16);
				  });
			}
			
			function removeByKey(array, key, value){
			    array.some(function(item, index) {
			    	(array[index][key] == value) ? !!(array.splice(index, 1)) : false;
			    });
			}			
			
		    function handleFileSelect(evt) {
		    	
		        evt.stopPropagation();
		        evt.preventDefault();
		        
		        var f = evt.target.files[0];

                var fileEx = "";
                var lastDot = f.name.lastIndexOf('.');
                
                if(lastDot > 0){
                	f.attachformcode = $(targetElement).attr("attachformcode");
                	f.uid = '<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMdd"/>' + getUUID();
                	f.fileName = f.name.substr(0, lastDot);
                	f.fileExt = f.name.substr(lastDot);
                	
                	//동일파일명 체크
                	var sameExists = false; 
                	
					$.each($("[name=uploadFile]"), function( key, uploadFileInfo ) {
						
						if(f.fileName == $(uploadFileInfo).find('[name="uploadFileName"]').text() &&
								f.fileExt == $(uploadFileInfo).find('[name="uploadFileExt"]').text()){
							sameExists = true;
						}
		                
					});	   
					
					if(sameExists){
						parent.msgSnackbar("error", "동일한 이름의 첨부파일이 존재합니다.");
					}else{
	    	            var abort = false;
	    	            var formData = new FormData();
	    	           	var nfcFileNames = btoa(unescape(encodeURIComponent(f.name)));
	    	            
	   	                formData.append("file0", f);
	   	             	formData.append("fileId", f.uid);
	    	            formData.append("nfcFileNames", nfcFileNames);
	    	    	    
	    	            fnSetProgress();

	    	            var AJAX = $.ajax({
	    	                url: '<c:url value="/ajaxFileUploadProc.do" />',
	    	                type: 'POST',
	    		        	timeout:600000,
	    	                xhr: function () {
	    	                    myXhr = $.ajaxSettings.xhr();

	    	                    if (myXhr.upload) {
	    	                        myXhr.upload.addEventListener('progress', progressHandlingFunction, false);
	    	                        myXhr.abort;
	    	                    }
	    	                    return myXhr;
	    	                },
	    	                success: completeHandler = function (data) {
	    	                	
	    	                    fnRemoveProgress();
	    	                	
	    		                $(targetElement).find('[name="uploadFile"]').show();
	    		                $(targetElement).find('[name="uploadFileName"]').attr("fileid", f.uid);
	    		                $(targetElement).find('[name="uploadFileName"]').text(f.fileName);
	    		                $(targetElement).find('[name="uploadFileExt"]').text(f.fileExt);		                	
	    	                	
	    		                removeByKey(parent.attachFileNew, "attachformcode", f.attachformcode);
	    		                parent.attachFileNew.push(f);
	    						
	    	                },
	    	                error: errorHandler = function () {

	    	                    if (abort) {
	    	                        alert('업로드를 취소하였습니다.');
	    	                    } else {
	    	                        alert('첨부파일 처리중 장애가 발생되었습니다. 다시 시도하여 주십시오');
	    	                    }

	    	                    //UPLOAD_COMPLITE = false;
	    	                    fnRemoveProgress();
	    	                },
	    	                data: formData,
	    	                cache: false,
	    	                contentType: false,
	    	                processData: false
	    	            });						
					}
                	
                }
		        
		      	$('#file_upload').val("");
		        
		    }
		    
		    function progressHandlingFunction(e) {
		        if (e.lengthComputable) {
		        	
		        	uploadPer = parseInt((e.loaded / e.total) * 100);
		        }
		    }			    
			
		    		    
		    
		    function fnSetProgress() {
		    	
		    	uploadPer = 0;

		    	Pudd( "#exArea" ).puddProgressBar({
		    		 
		    		progressType : "circular"
		    	,	attributes : { style:"width:70px; height:70px;" }
		    	 
		    	,	strokeColor : "#00bcd4"	// progress 색상
		    	,	strokeWidth : "3px"	// progress 두께
		    	 
		    	,	textAttributes : { style : "" }		// text 객체 속성 설정
		    	 
		    	,	percentText : ""
		    	,	percentTextColor : "#444"
		    	,	percentTextSize : "24px"
		    	,	backgroundLayerAttributes : { style : "background-color:#000;filter:alpha(opacity=20);opacity:0.2;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
		    	,	modal : true// 기본값 false - progressType : linear, circular 인 경우만 해당
		    	 
		    		// 200 millisecond 마다 callback 호출됨
		    	,	progressCallback : function( progressBarObj ) {
		    			return uploadPer;
		    		}
		    	});		    	
		    	
		    }		    
		    
		    function fnRemoveProgress() {
		    	uploadPer = 100;
		    }			    
		    
			function fnSearchFile(e){
				targetElement = $(e).closest("tr");
				$("#file_upload").click();
			}
			
			function fnDelFile(e){
				targetElement = $(e).closest("tr");
				
				$(targetElement).find('[name="uploadFile"]').hide();
				var fileid = $(targetElement).find('[name="uploadFileName"]').attr("fileid");
				parent.attachFileDel.push(fileid);
                removeByKey(parent.attachFileNew, "uid", fileid);
                $(targetElement).find('[name="uploadFileName"]').text("");
                $(targetElement).find('[name="uploadFileExt"]').text("");
			}
			
			function fnDownload(e){
				this.location.href = "${pageContext.request.contextPath}/fileDownloadProc.do?fileId=" + $(e).attr("fileid");
			}	
			
	</script>
</head>
<body>
<!-- 팝업----------------------------------------------------- -->
	<div class="pop_wrap_dir" style="width:770px;">
        <div class="com_ta">
			<table name="attachFileListTable">
				<colgroup>
					<col width="370"/>
					<col width=""/>
				</colgroup>
				<tr name="fileInfoBase" style="display:none;">
					<th class="al pl10">
						<span name="formName">1. 일상감사요청서</span><img style="display:none; padding-left: 5px;" name="mustImg" src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" />
						<span name="formFile" style="display:none;" class="fr ea_title_tooltip" onClick="fnDownload(this)"><img src="${pageContext.request.contextPath}/customStyle/Images/ico/btn_download01.png" /></span>
					</th>
					<td class="file_add">	
						<ul name="uploadFile" style="display:none;" class="file_list_box fl">
							<li>
								<img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" class="fl" alt="">
								<a name="uploadFileName" onClick="fnDownload(this)" href="javascript:;" class="fl ellipsis pl5" style="max-width:235px;" ></a>
								<span name="uploadFileExt"></span>
								<a href="javascript:;" onclick="fnDelFile(this)" title="파일삭제"><img src="${pageContext.request.contextPath}/customStyle/Images/btn/close_btn01.png" alt=""></a>
							</li>
						</ul>
						<span class="fr"><input onclick="fnSearchFile(this)" type="button" class="puddSetup" value="파일찾기" /></span>
					</td>
				</tr>
			</table>
		</div>

		<div class="mt10">※ <img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_check01.png" alt="" />는 반드시 업로드 하셔야 합니다.</div>
		
        <input style="display:none;" id="file_upload" type="file" />
  		<div id="exArea"></div>
    </div><!-- //pop_wrap -->
<!--// 팝업----------------------------------------------------- -->
</body>
</html>