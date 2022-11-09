<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
	/* document ready */
	$ ( document ).ready ( function ( ) {
		fnInit ( );
	} );

	/* fnInit */
	function fnInit ( ) {
		fnInitPos ( );
		fnInitFile ( );
	}

	/* fnInitPos >> 팝업창 크기 및 위치 조정 */
	function fnInitPos ( ) {
		return;
	}

	/* fnInitFile >> 첨부파일 정보 로드 */
	function fnInitFile ( ) {
		/* id 받아서, 첨부파일 정보 조회하고, 목록 반환해서, 그리서 호출. */
		$ ( '#compExpendUpload' ).attr ( 'src', '/gw/ajaxFileUploadProcView.do?uploadMode=D&pathSeq=1400&groupSeq=' + '${ViewBag.groupSeq}' );

		/* 변수정의 */
		var param = {};
		param.expendSeq = '${ViewBag.expendSeq}';
		param.listSeq = '${ViewBag.listSeq}';

		/* 파일정보 조회 및 반영 */
		$.ajax ( {
			type: 'post',
			url: '<c:url value="/ex/expend/master/ExUserInitExpend.do"/>',
			datatype: 'json',
			async: false,
			data: param,
			success: function ( data ) {
				var pfileIdList = [ ];

				$.each ( data.aaData, function ( idx, item ) {
					/* 변수정의 */
					var fileObj = new Object ( );
					/* 첨부파일 정보 */
					fileObj.fileId = item.fileId; /* 파일아이디 */
					fileObj.fileNm = item.fileName; /* 파일이름(원파일명, 확장자 포함) */
					fileObj.fileSize = item.fileSize; /* 파일크기(가공없이) */
					fileObj.fileThumUrl = '/gw/cmm/file/fileDownloadProc.do?fileId=' + item.fileId + '&fileSn=' + item.fileSn;
					fileObj.fileUrl = '/gw/cmm/file/fileDownloadProc.do?fileId=' + item.fileId + '&fileSn=' + item.fileSn;
					/* 파일목록 추가 */
					pfileIdList.push ( fileObj );
				} );

				$ ( '#compExpendUpload' ) [ 0 ].contentWindow.fnDownLoadFileListBinding ( pfileIdList );
			}
		} );
	}
</script>

<iframe id="compExpendUpload" name="compExpendUpload" width="100%"></iframe>