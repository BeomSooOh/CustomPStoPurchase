<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%
/**
 * 
 * @title 
 * @author 공공사업부 포털개발팀 박기환
 * @since 2012. 6. 7.
 * @version 
 * @dscription 
 * 
 *
 * << 개정이력(Modification Information) >>
 *  수정일                수정자        수정내용  
 * -----------  -------  --------------------------------
 * 2012. 6. 7.  박기환        최초 생성
 *
 */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>파일 업로드</title>
	<%@ include  file="/WEB-INF/jsp/neos/include/Common_popup.jsp" %>
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
	
	<script>
	
	//alert(imgDiv+":"+imgFile+":"+fileType);
	$(document).ready(function(){
		//makeFileAttachment();
		
		  $("#egovComFileUploader").change(function() {
			  file_upload();
		    });
	});
	
	function makeFileAttachment(){
		
/* 		 var maxFileNum = document.board.posblAtchFileNumber.value;
	     if(maxFileNum==null || maxFileNum==""){
	    	 maxFileNum = 3;
	     } */
		 var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), 1 );
		 multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
		
	}
	
	function file_upload(){
		
		if($("#egovComFileUploader").val().length>0){		
			document.board.action = "<c:url value='/cmm/file/insertFileUpload.do'/>";
			document.board.submit();
		}else{
			alert("파일을 선택하세요.");
		}
	}
	
	
	function commit_image(){
		
		//alert($(opener.document).find("#"+imgDiv).val());
		//alert($(opener.document).find("#signId").val());
		if($("#atchFileId").val().length>0){
		
			$(opener.document).find("#"+imgDiv).val($("#atchFileId").val());
			$(opener.document).find("#"+imgFile).val($("#orignlFileNm").val());
			
			eval("opener."+commitMethod+"();");
			//opener.pic_commit();
			window.close();
			
		}else{
			
			alert("선택한 이미지가 없습니다.");
			return;
			
		}
	}
	</script>
</head>

<body>
	<input type="hidden" id=atchFileId value="<c:out value='${fileVo.atchFileId}'/>">
	<input type="hidden" id=fileStreCours value="<c:out value='${fileVo.fileStreCours}'/>">
	<input type="hidden" id=orignlFileNm value="<c:out value='${fileVo.orignlFileNm}'/>">

  <div class="popupWarp" >
    <div class="popHead clearfx">
        <h1>이미지 업로드</h1>
        <a href="javascript:window.close();" class="close"><img src="<c:url value='/images/popup/btn_close.gif'/>" width="60" height="27" alt="닫기" /></a>
    </div>
    <div class="popContents clearfx">
			<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
			<input type="hidden" name="fileType" id="fileType" value="">
			<input type="hidden" name="imgDiv" id="imgDiv" value="">
			<input type="hidden" name="imgFile" id="imgFile" value="">
			<input type="hidden" name="commitMethod" id="commitMethod" value="">
            <div class="searchArea clearfx">
                <input name="file_1" id="egovComFileUploader" type="file" title="파일선택" style="width:260px;"/>
                 <!-- <a id="reg_teg" href="javascript:file_upload();" title="업로드" class="defaultBtn"> <span style="padding:0; padding-right:5px;"><strong>업로드</strong></span></a> -->
            </div>
			</form:form>
                <div class="mT20"id="img_view" style="width:100%; height:240px; overflow:auto; border:1px solid #dddddd;" align="center">
                    <c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
                        <c:param name="atchFileId" value="${fileVo.atchFileId}" />
                        <c:param name="imgWidth" value="290" />
                        <c:param name="imgHeight" value="240" />
                    </c:import>
                </div>
    </div>
    <p class="tC T10 brT">
        <a href="javascript:commit_image();" class="btn28"><span><img src="<c:url value='/images/popup/btn_select.gif'/>" alt="" /> 반영</span></a> 
        <a href="javascript:window.close();" class="btn28"><span><img src="<c:url value='/images/popup/btn_cancel.gif'/>" alt="취소" /> 취소</span></a>
    </p>
  </div>	
</body>
<script>
var imgDiv = "${fileUploadVO.imgDiv}";
var imgFile = "${fileUploadVO.imgFile}";
var fileType = "${fileUploadVO.uploadType}";
var commitMethod = "${fileUploadVO.commitMethod}";

$("#imgDiv").val(imgDiv);
$("#imgFile").val(imgFile);
$("#fileType").val(fileType);
$("#commitMethod").val(commitMethod);

</script>
</html>