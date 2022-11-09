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


<iframe id="voovoUpload" name="voovoUpload" width="100%" height="100%"></iframe>

<script>
	var pfileIdList = [];
	
	$(document).ready(function(){
		
		var groupSeq = '${groupSeq}';
		var expendSeq = '${expendSeq}';
		var listSeq = '${listSeq}';
		var fileInfos = ${fileInfos};
		
		/* pathSeq 추가 필요 - GW 옵션 개발 필요 */
		$("#voovoUpload").attr("src", "/gw/ajaxFileUploadProcView.do?uploadMode=D&pathSeq=1400&groupSeq=" + groupSeq);

		for(var i = 0 ; i < fileInfos.length ; i++){
			var item = fileInfos[i];
			var fileObj = new Object();
			fileObj.fileId  = item.fileSeq;
			fileObj.fileNm  = item.orignlFileName + "." +item.fileExtSn;
			fileObj.fileSize  = item.fileSize;
			fileObj.fileThumUrl  = "/gw/cmm/file/fileDownloadProc.do?fileId=" + item.fileSeq + "&fileSn=" + item.fileSn;
			fileObj.fileUrl  = "/gw/cmm/file/fileDownloadProc.do?fileId=" + item.fileSeq + "&fileSn=" + item.fileSn;		    
			pfileIdList.push(fileObj);
		}

		fniframeLoadEvent();
		fnResizeForm();
	});
	
	
	//로드시까지 반복 호출
	function fniframeLoadEvent(){
		var iframe = document.getElementById('voovoUpload');
	    var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
		
	    if (  iframeDoc.readyState  == 'complete' && $("#voovoUpload")[0].contentWindow.fnAttFileListBinding != null) {
	    	$("#voovoUpload")[0].contentWindow.fnDownLoadFileListBinding(pfileIdList);
	    	//tmpAttchBindList = '';
	    	//console.log(1);
	    	$("#voovoUpload").attr("style", "width: 100%;");
	    	
	     	return;
	    } 
	    else
	    {
	    	window.setTimeout('fniframeLoadEvent()', 100);
	    	//console.log(2);
	    }
	}
	
	/* [ 사이즈 변경 ] 페이지 리폼
	-----------------------------------------------*/
	function fnResizeForm() {
				
		try{
			var childWindow = window.parent;
			childWindow.resizeTo(500, 243);	
		}catch(exception){
			console.log('window resizing cat not run dev mode.');
		}
		
	}
</script>