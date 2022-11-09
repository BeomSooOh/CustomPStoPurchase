<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>

<!-- bizbox suite 지출결의 첨부파일 마이그레이션 : fn_ex_file_attach_view ==> fn_mig_file_attach_view 변경 -->
<!-- 이전 : fn_ex_file_attach_view('21622','1') -->
<!-- 변경 : fn_mig_file_attach_view('21622', '1') -->

<!--
// 기존 스크립트
// 지출결의용 첨부파일 뷰어
function fn_ex_file_attach_view(arg1, arg2) {

    var formNm = NeosUtil.getMessage('TX000006621', '첨부파일보기');
    dlg.OpenDialog("/Ex/EXDOC/AttchView?pExpendNo=" + arg1 + "&pLineNo=" + arg2, 750, 550, formNm);
    //PopUp(6, 600, 500, "EX_ATTACH_VIEW", "/Ex/EXDOC/ExDocAttchView?sExpendNo=" + arg1 + "&sLineNo=" + co_id);
}

// 본문에 포함할 신규 스크립트
function fn_mig_file_attach_view(expendSeq, listSeq) {
	var url = '/exp/common/SuiteMigFileDownload.do?expend_seq=' + expendSeq + '&list_seq=' + listSeq + '&slip_seq=0&group_seq=MIGGROUPSEQ';
	window.open(url);
	return;
}
-->

<!-- window.open(/exp/ApprovalAttachPop.do?expend_seq=726&list_seq=1&slip_seq=0&group_seq=TCFS') -->

<iframe id="voovoUpload" name="voovoUpload" width="100%" height="100%"></iframe>

<script>
	var pfileIdList = [];

	$(document).ready(function() {

		var type = 'SMIG'; // Bizbox Suite 지출결의 첨부파일 고정 파라미터
		var groupSeq = '${group_seq}';
		var expendSeq = '${expend_seq}';
		var listSeq = '${list_seq}';
		
		var fileInfos = ${fileInfos};

		$("#voovoUpload").attr("src", "/gw/ajaxFileUploadProcView.do?uploadMode=D&pathSeq=1400&groupSeq=" + groupSeq);

		for (var i = 0; i < fileInfos.length; i++) {
			var item = fileInfos[i];
			var fileObj = new Object();
			fileObj.fileId = item.fileSeq;
			fileObj.fileNm = item.orignlFileName + "." + item.fileExtSn;
			fileObj.fileSize = item.fileSize;
			fileObj.fileThumUrl = "/gw/cmm/file/fileDownloadProc.do?fileId=" + item.fileSeq + "&fileSn=" + item.fileSn;
			fileObj.fileUrl = "/gw/cmm/file/fileDownloadProc.do?fileId=" + item.fileSeq + "&fileSn=" + item.fileSn;
			pfileIdList.push(fileObj);
		}

		fniframeLoadEvent();
		fnResizeForm();
	});

	//로드시까지 반복 호출
	function fniframeLoadEvent() {
		var iframe = document.getElementById('voovoUpload');
		var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;

		if (iframeDoc.readyState == 'complete' && $("#voovoUpload")[0].contentWindow.fnAttFileListBinding != null) {
			$("#voovoUpload")[0].contentWindow.fnDownLoadFileListBinding(pfileIdList);
			//tmpAttchBindList = '';
			//console.log(1);
			$("#voovoUpload").attr("style", "width: 100%;");

			return;
		}
		else {
			window.setTimeout('fniframeLoadEvent()', 100);
			//console.log(2);
		}
	}

	/* [ 사이즈 변경 ] 페이지 리폼
	-----------------------------------------------*/
	function fnResizeForm() {

		try {
			var childWindow = window.parent;
			childWindow.resizeTo(500, 243);
		}
		catch (exception) {
			console.log('window resizing cat not run dev mode.');
		}

	}
</script>