<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<div class="sub_contents_wrap">
	<input type="button" class="btn_search" value="CMS연동 1회 강제 실행"
		id="btn_batchCall" />
	<div id="grid"></div>
</div>

<script type="text/javascript">
	/*	Elements Ready
	---------------------------------------*/
	$(document).ready(function() {

		// call server 
		fnGetCMSLogData();

		// set btn event 
		$('#btn_batchCall').click(function() {
			if (confirm('Do you want to enable this function')) {
				fnSyncNow();
			}
		});
	});

	/*	[ajax] get cms log data from server.
	---------------------------------------*/
	function fnGetCMSLogData() {
		$.ajax({
			async : true,
			type : "post",
			url : '<c:url value="/devmanager/langpack/FuncDMCmsMainList.do" />',
			datatype : "json",
			data : {},
			success : function(result) {
				fnSetViewLog(result);
			},
			error : function(err) {
			}
		});
	}

	/*	[grid] set kendo grid with data
	---------------------------------------*/
	function fnSetViewLog(data) {

		$("#grid").kendoGrid({
			columns : [ {
				title : 'batch_seq',
				width : 2,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: center;"
				},
				field : 'batchSeq'
			}, {
				title : 'comp_seq',
				width : 2,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: center;"
				},
				field : 'compSeq'
			}, {
				title : 'comp_name',
				width : 3,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: center;"
				},
				field : 'compName'
			}, {
				title : 'module_type',
				width : 2,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: center;"
				},
				field : 'moduleType'
			}, {
				title : 'log_type',
				width : 2,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: center;"
				},
				field : 'logType'
			}, {
				title : 'message',
				width : 10,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: left;"
				},
				field : 'message'
			}, {
				title : 'create_date',
				width : 3,
				headerAttributes : {
					style : "text-align: center;"
				},
				attributes : {
					style : "text-align: center;"
				},
				field : 'createDate'
			} ],
			dataSource : data.returnObj,
			selectable : "single",
			groupable : false,
			columnMenu : false,
			editable : false,
			sortable : true,
			pageable : false,
			navigatable : true,
			change : function(arg) {
			}

		});
	}

	/*	[ajax] CMS module interworking immediately
	---------------------------------------*/
	function fnSyncNow() {
		$.ajax({
			async : true,
			type : "post",
			url : '<c:url value="/common/batch/cms/CommonSetCmsSyncNow.do" />',
			datatype : "json",
			data : {},
			success : function(result) {
				if (result.result.resultCode) {
					fnGetCMSLogData();
				} else {
					alert(result.result.resultName);
				}
			},
			error : function(err) {
				alert(err);
			}
		});
	}
</script>