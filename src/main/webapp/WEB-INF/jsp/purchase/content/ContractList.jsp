<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/jszip-3.1.5.min.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/FileSaver-1.2.2_1.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/jexcel-1.0.5.js' />"></script> 
    
<script>

	var targetSeq = "";
	var uploadPer = 0;
	
	$(document).ready(function() {
		
		popUpResize();
		
		BindGrid();
		
		document.getElementById('file_upload').addEventListener('change', handleFileSelect, false);

	});//---documentready
	
	function popUpResize(){
		
		if(!parent.getTopMenu){
			window.resizeTo(1200, 650);
		}
		
	}	
	
	var changeInfoList = [];
	
	function fnSaveColInfo(){
		
		if(changeInfoList.length > 0){
			confirmAlert(350, 100, 'question', '?????????????????????????', '??????', 'fnSaveProc()', '??????', '');	
		}else{
			msgSnackbar("warning", "????????? ????????? ????????????.");
		}
		
	}
	
	
	function fnSaveProc(){
		
		var insertDataObject = {};
		insertDataObject.change_info_list = JSON.stringify(changeInfoList);
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/ContractAdminChangeProc.do" />',
    		datatype:"json",
            data: insertDataObject ,
			async : false,
			success : function(result) {
				
				if(result.resultCode == "success"){
					
					msgSnackbar("success", "???????????? ????????? ????????? ?????????????????????.");
					BindGrid();
					changeInfoList = [];
					
				}else{
					
					msgSnackbar("error", "????????? ??????????????????.");
					
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "????????? ??????????????????.");
			}
		});		
		
	}
	
	function fnSetChangeInfo(seq, calName, oriVal, newVal){
		
		var targetObj = changeInfoList.find(obj => obj.seq === seq);
		
		if(oriVal != newVal && targetObj == null){
			var changeInfo = {};
			changeInfo.seq = seq;
			changeInfoList.push(changeInfo)
		}
		
		if(oriVal != newVal){
			changeInfoList.find(obj => obj.seq === seq)[calName] = newVal;
		}else if(targetObj){
			delete changeInfoList.find(obj => obj.seq === seq)[calName];
		}
		
		if(changeInfoList.find(obj => obj.seq === seq)){
			
			if(Object.keys(changeInfoList.find(obj => obj.seq === seq)).length == 1){
				changeInfoList.some(function(item, index) {
			    	(changeInfoList[index]["seq"] == seq) ? !!(changeInfoList.splice(index, 1)) : false;
			    });
			}
		}
		
		if(changeInfoList.length > 0){
			$("#adminSaveBtn").show();	
		}else{
			$("#adminSaveBtn").hide();
		}
		
	}
	
	function BindGrid(){
		
		var dataSource = new Pudd.Data.DataSource({
				serverPaging: true
			,	editable : true
			,	pageSize: 10
			,	request : {
				    url : '<c:url value="/purchase/${authLevel}/SelectContractList.do" />'
				,	type : 'post'
				,	dataType : "json"
				,   parameterMapping : function( data ) {
					
					data.searchFromDate = $("#searchFromDate").val(); ;
					data.searchToDate = $("#searchToDate").val();
					data.contractTitle = $("#contractTitle").val();
					data.writeDeptName = $("#writeDeptName").val();
					
					<c:if test="${authLevel!='user'}">
					data.writeEmpName = $("#writeEmpName").val();
					</c:if>
					<c:if test="${authLevel=='user'}">
					data.writeEmpName = "";
					</c:if>					
					
					return data;
				}
			}	    
			,   result : {
				data : function(response){
					return response.list;
				},
				totalCount : function(response){
					return response.totalCount;	
				},
				error : function(response){
					alert("error");
				}	
			}
				    
		});
		
		Pudd("#grid1").puddGrid({
			dataSource : dataSource
		,	scrollable : true
		, 	pageSize : 10	// grid??? ???????????? ?????? grid > pageable > pageList ????????? ?????? ??????????????? ???
		,	serverPaging : true		
		,	pageable : {
				buttonCount : 10 
			,	pageList : [ 10, 20, 30, 40, 50 ]
			,	pageInfo : true
			}
		
		,	noDataMessage : {
			message : "????????? ???????????? ????????????."
		}		
		,	progressBar : {
		   	 
				progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }
			,	strokeColor : "#84c9ff"	// progress ??????
			,	strokeWidth : "3px"	// progress ??????
			,	percentText : "loading"	// loading ?????? ????????? ?????? - progressType loading ??? ?????????
			,	percentTextColor : "#84c9ff"
			,	percentTextSize : "12px"
			,	backgroundLayerAttributes : { style : "background-color:#fff;filter:alpha(opacity=0);opacity:0;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
		}	
		,	loadCallback : function( headerTable, contentTable, footerTable, gridObj) {
			
				gridObj.on( "gridRowClick", function( e ) {
					 
					var evntVal = e.detail;
				 
					if( ! evntVal ) return;
					if( ! evntVal.trObj ) return;
				 
					var rowData = evntVal.trObj.rowData;
					fnSetBtn(rowData);
				 
				});				
		}		
		
		,	columns : [
				{
				title : "????????????"
			,	columns : [
				{
						field : "seq"
					,	title : "??????"
					,	width : 70
					,	content : {
							attributes : { class : "ci" }
					}
				}					
			,	{
						field : "manage_no"
					,	title : "????????????"
					,	width : 130
					/*
					,	content : {
						// param : row??? ???????????? Data, td Node ??????, tr Node ??????, grid ??????
						clickCallback : function( rowData, tdNode, trNode, gridObj ) {
							fnContractStatePop("contractView", rowData.seq);
						}
					}
					*/
				}
			,	{
						field : "contract_no"
					,	title : "????????????"
					,	width : 120
					,	content : {		
						template : function(rowData) {
							
							<c:choose><c:when test="${authLevel=='admin'}">
							return '<input onkeyup="fnSetChangeInfo(\''+rowData.seq+'\', \'contract_no\', \''+rowData.contract_no+'\', this.value)" type="text" pudd-style="width:100%;" class="puddSetup ac" value="' + rowData.contract_no + '" />';
							</c:when><c:otherwise>
							return rowData.contract_no;
							</c:otherwise></c:choose>
							
						}
					}				
					
				}
			,	{
						field : "target_type_name"
					,	title : "???????????????"
					,	width : 120
				}	
			,	{
					field : "contract_type_text"
				,	title : "??????/??????"
				,	width : 100
				}				
			,	{
						field : "title"
					,	title : "?????????"
					,	width : 250
					,	content : {
							attributes : { class : "le ellipsis" }
					}
					,	tooltip : { 
						alwaysShow : false		// ????????? ????????? ???????????? tooltip ????????? ????????? ??????, ????????? false
					,	showAtClientX : false	// toolTip ???????????? ????????? mouse ???????????? X ?????? ?????? ??????, ????????? false ( toolTip ???????????? ?????? )
					}
				}				
			,	{
						field : "contract_amt"
					,	title : "????????????"
					,	width : 130
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "contract_start_dt"
					,	title : "???????????????"
					,	width : 150	
					,	content : {		
						template : function(rowData) {
							
							<c:choose><c:when test="${authLevel=='admin'}">
							return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'contract_start_dt\', \''+rowData.contract_start_dt+'\', this.value)" type="text" value="' + rowData.contract_start_dt + '" class="puddSetup" pudd-type="datepicker"/>';
							</c:when><c:otherwise>
							return rowData.contract_start_dt;
							</c:otherwise></c:choose>
							
						}
					}					
				}
			,	{
						field : "contract_end_dt"
					,	title : "???????????????"
					,	width : 100							
				}
				]
			}
			,	{
				title : "??????????????? ??????"
			,	columns : [
				{
						field : "tr_name"
					,	title : "???????????????"
					,	width : 100
				}					
			,	{
						field : "tr_reg_number"
					,	title : "?????????????????????"
					,	width : 100
				}
			,	{
						field : "ceo_name"
					,	title : "????????????"
					,	width : 100							
				}
			,	{
						field : "hope_company_info"
					,	title : "??????????????????"
					,	width : 100
				}						
				]
			}
			,	{
				title : "????????????"
			,	columns : [
				{
						field : "amt"
					,	title : "????????????"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "compete_type_text"
					,	title : "????????????"
					,	width : 100							
				}
			,	{
						field : "decision_type_text"
					,	title : "?????????????????????"
					,	width : 100
					,   ellipsis : true
					,	tooltip : { 
						alwaysShow : false		// ????????? ????????? ???????????? tooltip ????????? ????????? ??????, ????????? false
					,	showAtClientX : false	// toolTip ???????????? ????????? mouse ???????????? X ?????? ?????? ??????, ????????? false ( toolTip ???????????? ?????? )
					}						
				}	
			,	{
						field : "emp_name"
					,	title : "?????????"
					,	width : 100
			}
			,	{
						field : "dept_name"
					,	title : "???????????????"
					,	width : 120
			}
			,	{
				field : ""
			,	title : "?????????"
			,	width : 120
			,	content : {
				template : function(rowData) {
						const arr = (rowData.public_info||"").split("???");
						const arr1 = [];
						const public_info = [];
						
						for(var i=1; i<arr.length; i+=3){
							const arr1 = arr[i].split("(");
							for(var j=0; j<arr1.length; j+=2){
/* 								if (i % 2 == 0) { */
									public_info.push(arr1[j]); 
								  /* } */
							}
								}
						return public_info;
				}
			}
			}
				]
			}
			,	{
				title : "????????????"
			,	columns : [
				{
						field : ""
					,	title : "????????????????????????"
					,	width : 150
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'pre_notice_end_dt\', \''+rowData.pre_notice_end_dt+'\', this.value)" type="text" value="' + rowData.pre_notice_end_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.pre_notice_end_dt;
								</c:otherwise></c:choose>								
								
							}else{
								return "";
							}

						}
					}
				}					
			,	{
						field : ""
					,	title : "??? ????????????"
					,	width : 290
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'notice_start_dt\', \''+rowData.notice_start_dt+'\', this.value)" type="text" value="' + rowData.notice_start_dt + '" class="puddSetup" pudd-type="datepicker"/> ~ <input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'notice_end_dt\', \''+rowData.notice_end_dt+'\', this.value)" type="text" value="' + rowData.notice_end_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.notice_start_dt != "" && rowData.notice_end_dt != "" ? (rowData.notice_start_dt + " ~ " + rowData.notice_end_dt) : "";
								</c:otherwise></c:choose>								
								
							}else{
								return "";
							}							

						}
					}
				}
			,	{
						field : ""
					,	title : "??? ????????????"
					,	width : 290			
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'re_notice_start_dt\', \''+rowData.re_notice_start_dt+'\', this.value)" type="text" value="' + rowData.re_notice_start_dt + '" class="puddSetup" pudd-type="datepicker"/> ~ <input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'re_notice_end_dt\', \''+rowData.re_notice_end_dt+'\', this.value)" type="text" value="' + rowData.re_notice_end_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.re_notice_start_dt != "" && rowData.re_notice_end_dt != "" ? (rowData.re_notice_start_dt + " ~ " + rowData.re_notice_end_dt) : "";
								</c:otherwise></c:choose>									

							}else{
								return "";
							}
							
						}
					}				
				}
			,	{
						field : ""
					,	title : "???????????? ??????"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								if(rowData.notice_start_dt != "" && rowData.notice_end_dt != ""){
									return "??????";									
								}else{
									return "";
								}
								
							}else{
								return "";
							}
							
						}
					}					
				}	
			,	{
						field : "bidder_cnt"
					,	title : "????????????"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onkeyup="fnSetChangeInfo(\''+rowData.seq+'\', \'bidder_cnt\', \''+rowData.bidder_cnt+'\', this.value)" type="number" style="width:50px;" class="puddSetup ac" maxlength="2" value="' + rowData.bidder_cnt + '" /> ???';
								</c:when><c:otherwise>
								return rowData.bidder_cnt + (rowData.bidder_cnt != " ???" ? "" : ""); 
								</c:otherwise></c:choose>								
								
							}else{
								return "";
							}							
							
						}
					}
			}
			,	{
						field : "meet_dt"
					,	title : "??????????????????"
					,	width : 180
			}					
				]
			}
			,	{
				title : "??????????????????"
			,	columns : [
				{
						field : ""
					,	title : "???????????????"
					,	width : 150
					,	content : {		
						template : function(rowData) {
							
							if(rowData.doc_sts_change == "90"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'contract_change_dt\', \''+rowData.contract_change_dt+'\', this.value)" type="text" value="' + rowData.contract_change_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.contract_change_dt; 
								</c:otherwise></c:choose>								
								
							}else if(rowData.doc_sts_change != "" && rowData.doc_sts_change != "10"){
								return rowData.contract_change_dt;
							}else{
								return "";
							}
							
						}
					}
				}					
			,	{
						field : "work_info_after"
					,	title : "??????????????????"
					,	width : 100
				}
			,	{
						field : "contract_end_dt_after"
					,	title : "??????????????????"
					,	width : 100							
				}	
			,	{
						field : ""
					,	title : "??????????????????"
					,	width : 100		
					
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_amt_after != "" && rowData.contract_amt_after != "0"){
								return rowData.contract_amt_after + " ???";
							}else{
								return "";
							}
							
						}
					}					
					
				}	
			,	{
						field : "change_etc"
					,	title : "????????????"
					,	width : 100							
				}			
				]
			}
			,	{
				title : "??????????????????"
			,	columns : [
				{
						field : "pay_amt_a"
					,	title : "?????????"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : "pay_amt_b"
					,	title : "???????????????"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "pay_amt_c"
					,	title : "?????????"
					,	width : 100	
					,	content : {
							attributes : { class : "ri" }
					}						
				}	
			,	{
						field : "remain_amt"
					,	title : "??????"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : ""
					,	title : "?????????"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.remain_amt != ""){
								
								var amt = parseInt(rowData.contract_amt.replace(/,/g, ''));
								var remain_amt = parseInt(rowData.remain_amt.replace(/,/g, ''));
								
								return ((amt-remain_amt)/amt*100).toFixed(1) + " %";
								
							}else{
								return "";
							}
							
						}
					}						
				}			
				]
			}
			,	{
				title : "??????"
			,	columns : [
				{
						field : ""
					,	title : "?????????"
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function(rowData) {
							
							if(rowData.contract_attach_info != ""){
								var attachInfo =  rowData.contract_attach_info.split("???");
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="'+attachInfo[2]+'" class="fl ellipsis pl5 text_ho" style="max-width:<c:if test="${authLevel=='admin'}">230</c:if><c:if test="${authLevel!='admin'}">288</c:if>px;" ><img name="uploadFileIco" src="${pageContext.request.contextPath}' + fncGetFileClassImg(attachInfo[1]) + '" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName">' + attachInfo[0] + attachInfo[1] + '<span></em></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="????????????" onclick="fnSearchFile(\''+rowData.seq+'\', \'contract_attach_info\', this)" /></c:if></div>';	
							}else{
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="" class="fl ellipsis pl5 text_ho" style="max-width:<c:if test="${authLevel=='admin'}">230</c:if><c:if test="${authLevel!='admin'}">288</c:if>px; display:none;" ><img name="uploadFileIco" src="" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName"><span></em></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="????????????" onclick="fnSearchFile(\''+rowData.seq+'\', \'contract_attach_info\', this)" /></c:if></div>';
							}
							
						}
					}
				}					
			,	{
						field : ""
					,	title : "??????????????????"
					,	width : 100
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function(rowData) {
							
							if(rowData.submit_attach_info != ""){
								var attachInfo =  rowData.submit_attach_info.split("???");
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="'+attachInfo[2]+'" class="fl ellipsis pl5 text_ho" style="max-width:<c:if test="${authLevel=='admin'}">230</c:if><c:if test="${authLevel!='admin'}">288</c:if>px;" ><img name="uploadFileIco" src="${pageContext.request.contextPath}' + fncGetFileClassImg(attachInfo[1]) + '" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName">'+attachInfo[0]+attachInfo[1]+'<span></em></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="????????????" onclick="fnSearchFile(\''+rowData.seq+'\', \'submit_attach_info\', this)" /></c:if></div>';	
							}else{
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="" class="fl ellipsis pl5 text_ho" style="max-width:<c:if test="${authLevel=='admin'}">230</c:if><c:if test="${authLevel!='admin'}">288</c:if>px; display:none;" ><img name="uploadFileIco" src="" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName"><span></em></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="????????????" onclick="fnSearchFile(\''+rowData.seq+'\', \'submit_attach_info\', this)" /></c:if></div>';
							}							
							
						}
					}
				}			
				]
			}
		]
	});	
		
		
	} 	
	
	var attachTargetSeq;
	var attachTargetColName;
	var attachTargetObj;
	
	function fnSearchFile(seq, colName, el){
		attachTargetSeq = seq;
		attachTargetColName = colName;
		attachTargetObj = $(el).closest("td");
		
		$("#file_upload").click();
	}
	
	function handleFileSelect(evt) {
		
	    evt.stopPropagation();
	    evt.preventDefault();
	    
	    var f = evt.target.files[0];
	
	    var fileEx = "";
	    var lastDot = f.name.lastIndexOf('.');
	    
	    if(lastDot > 0){
	    	
	    	f.uid = '<fmt:formatDate value="${currentTime}" type="date" pattern="yyyyMMdd"/>' + getUUID();
	    	f.fileName = f.name.substr(0, lastDot);
	    	f.fileExt = f.name.substr(lastDot);
		
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
	               	
	                $(attachTargetObj).find('em').attr("fileid", f.uid).show();
	                $(attachTargetObj).find('[name="uploadFileName"]').text(f.fileName + f.fileExt);
	                $(attachTargetObj).find('[name="uploadFileIco"]').attr("src", "${pageContext.request.contextPath}" + fncGetFileClassImg(f.fileExt));
	                
	                fnSetChangeInfo(attachTargetSeq, attachTargetColName, "", f.fileName + "???" + f.fileExt + "???" + f.uid);
					
	               },
	               error: errorHandler = function () {
	
	                   if (abort) {
	                       alert('???????????? ?????????????????????.');
	                   } else {
	                       alert('???????????? ????????? ????????? ?????????????????????. ?????? ???????????? ????????????');
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
		 
		,	strokeColor : "#00bcd4"	// progress ??????
		,	strokeWidth : "3px"	// progress ??????
		 
		,	textAttributes : { style : "" }		// text ?????? ?????? ??????
		 
		,	percentText : ""
		,	percentTextColor : "#444"
		,	percentTextSize : "24px"
		,	backgroundLayerAttributes : { style : "background-color:#000;filter:alpha(opacity=20);opacity:0.2;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
		,	modal : true// ????????? false - progressType : linear, circular ??? ????????? ??????
		 
			// 200 millisecond ?????? callback ?????????
		,	progressCallback : function( progressBarObj ) {
				return uploadPer;
			}
		});		    	
		
	}		    
  
	function fnRemoveProgress() {
		uploadPer = 100;
	}	
	
	function fnDownload(e){
		this.location.href = "${pageContext.request.contextPath}/fileDownloadProc.do?fileId=" + $(e).attr("fileid");
	}	
	
	function fnSetBtn(rowData){
		
		if(targetSeq == rowData.seq){
			return;
		}
		
		var reqParam = {};
		reqParam.seq = rowData.seq;
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/ContractInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : true,
			success : function(result) {
				
				console.log("seq > " + result.resultData.seq);
				console.log("contract_type > " + result.resultData.contract_type);
				console.log("doc_sts > " + result.resultData.doc_sts);
				console.log("approkey_plan > " + result.resultData.approkey_plan);
				console.log("approkey_meet > " + result.resultData.approkey_meet);
				console.log("approkey_result > " + result.resultData.approkey_result);
				console.log("approkey_conclusion > " + result.resultData.approkey_conclusion);
				console.log("approkey_change > " + result.resultData.approkey_change);
				console.log("doc_sts_change > " + result.resultData.doc_sts_change);
				console.log("change_seq > " + result.resultData.change_seq);
				console.log("change_seq_temp > " + result.resultData.change_seq_temp);
				
				var planState = "";
				var meetState = "";		
				var resultState = "";
				var conclusionState = "";
				var changeState = "";
				var paymentState = "";
				
				if(result.resultData.contract_type == "01"){
					
					//??????
					planState = "V";
					
					if(result.resultData.approkey_conclusion != ""){
						
						meetState = "V";		
						resultState = "V";
						conclusionState = "V";				
						
						if(result.resultData.doc_sts == "90"){
							
							paymentState = "C";
							
							if(result.resultData.doc_sts_change == "10" || result.resultData.doc_sts_change == "20"){
								changeState = "V";					
							}else{
								changeState = "C";
							}
							
						}				
						
					}else if(result.resultData.approkey_result != ""){
						
						meetState = "V";		
						resultState = "V";	
						
						if(result.resultData.doc_sts == "90"){
							conclusionState = "C";	
						}
						
					}else if(result.resultData.approkey_meet != ""){
						
						meetState = "V";
						
						if(result.resultData.doc_sts == "90"){
							resultState = "C";	
						}				
						
					}else if(result.resultData.approkey_plan != ""){
						
						if(result.resultData.doc_sts == "90"){
							meetState = "C";	
						}
						
					}else{
						planState = "C";
					}
					
				}else{
					
					//??????
					conclusionState = "V";
					
					if(result.resultData.doc_sts == "90"){
						
						if(result.resultData.doc_sts_change == "" || result.resultData.doc_sts_change == "90"){
							paymentState = "C";
							changeState = "C";
						}else{
							//???????????? ??????
							changeState = "V";
						}
					}else if(result.resultData.doc_sts == "" || result.resultData.doc_sts == "10"){
						conclusionState = "C";
					}
					
				}
				
				var btnList = [];
				
				if(planState != ""){
					
					var btnStyle = planState == "C" ? "submit" : "cancel";
					var btnName = planState == "C" ? "???????????? ??????" : "???????????? ??????";					
				
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control ?????? ?????? ?????? ??????
						,	controlAttributes : { id : "", class : btnStyle }// control ?????? ?????? ?????? ??????
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnCallBtn('contractView', result.resultData.seq);
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
						
					btnList.push(btnInfo);			
					
				}		
				
				if(meetState != ""){
					
					var btnStyle = meetState == "C" ? "submit" : "cancel";
					var btnName = meetState == "C" ? "???????????????????????? ??????" : "???????????????????????? ?????? ??????";
				
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control ?????? ?????? ?????? ??????
						,	controlAttributes : { id : "", class : btnStyle }// control ?????? ?????? ?????? ??????
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnContractStatePop('btnMeet');
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
						
					btnList.push(btnInfo);			
					
				}
				
				if(resultState != ""){
					
					var btnStyle = resultState == "C" ? "submit" : "cancel";
					var btnName = resultState == "C" ? "???????????????????????????" : "???????????????????????????";
				
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control ?????? ?????? ?????? ??????
						,	controlAttributes : { id : "", class : btnStyle }// control ?????? ?????? ?????? ??????
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnContractStatePop('btnResult');
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
						
					btnList.push(btnInfo);			
					
				}			

				if(conclusionState != ""){
					
					var btnStyle = conclusionState == "C" ? "submit" : "cancel";
					var btnName = conclusionState == "C" ? "??????????????????" : "??????????????????";
					
					var btnInfo = {
						attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control ?????? ?????? ?????? ??????
					,	controlAttributes : { id : "", class : btnStyle }// control ?????? ?????? ?????? ??????
					,	value : btnName
					,	clickCallback : function( puddActionBar ) {
						
							fnCallBtn("btnConclusion", result.resultData.seq);
							
							$('.iframe_wrap').attr('onclick','').unbind('click');
							puddActionBar.showActionBar( false );
							targetSeq = "";
							
						}
					}

					btnList.push(btnInfo);			
					
				}
				
				if(changeState != ""){
					
					var btnStyle = changeState == "C" ? "submit" : "cancel";
					var btnName = changeState == "C" ? "??????????????????" : "??????????????????";
					
					var btnInfo = {
						attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control ?????? ?????? ?????? ??????
					,	controlAttributes : { id : "", class : btnStyle }// control ?????? ?????? ?????? ??????
					,	value : btnName
					,	clickCallback : function( puddActionBar ) {
							fnContractStatePop('btnConclusionChange');
							
							$('.iframe_wrap').attr('onclick','').unbind('click');
							puddActionBar.showActionBar( false );
							targetSeq = "";
						}
					}

					btnList.push(btnInfo);			
					
				}		
				
				
				if(paymentState != ""){
					
					var btnStyle = "submit";
					var btnName = "????????????";
					
					var btnInfo = {
						attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control ?????? ?????? ?????? ??????
					,	controlAttributes : { id : "", class : btnStyle }// control ?????? ?????? ?????? ??????
					,	value : btnName
					,	clickCallback : function( puddActionBar ) {
							fnContractStatePop('btnConclusionPayment');
							
							$('.iframe_wrap').attr('onclick','').unbind('click');
							puddActionBar.showActionBar( false );
							targetSeq = "";
						}
					}
					btnList.push(btnInfo);			
				}	
				
				//????????????
				var btnCancel = {
					attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control ?????? ?????? ?????? ??????
				,	controlAttributes : { class : "cancel", style : "background: #000000;color:#fff;border-color: #484848;" }// control ?????? ?????? ?????? ??????
				,	value : "??????"
				,	clickCallback : function( puddActionBar ) {
						puddActionBar.showActionBar( false );
						targetSeq = "";
					}
				}
				btnList.push(btnCancel);				
				
				
				puddActionBar_ = Pudd.puddActionBar({
					 
					height	: 100
				,	message : {
							type : "html"		// text, html
						,	content : '<span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #ffffff;">[ ' + (result.resultData.c_title ? result.resultData.c_title : result.resultData.title) + ' ]</span></br><span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #c2c2c2;">???????????? ????????? ????????? ?????????</span>'				
					}
				
				,	buttons : btnList	
				
				});
				
				targetSeq = result.resultData.seq;

				$(".iframe_wrap").on("click", function(e){
					
					if($("#grid1").find(e.target).length == 0){
						puddActionBar_.showActionBar( false );
						targetSeq = "";
						$('.iframe_wrap').attr('onclick','').unbind('click');
					}
					
				});
				
			},
			error : function(result) {
				msgSnackbar("error", "????????? ????????? ??????????????????.");
			}
		});			
	}
	
	var puddActionBar_;
	
	function fnCallBtn(callId, seq, sub_seq){
		
		if(callId == "newContract"){
			//?????????????????? ??????
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractCreatePop.do",  "ContractCreatePop", 1200, 900, 1, 1) ;
			
		}else if(callId == "contractView"){
			//?????????????????? ??????
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractCreatePop.do?seq=" + seq,  "ContractViewPop", 1200, 900, 1, 1) ;
			
		}else if(callId == "newConclusion"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionCreatePop.do",  "ConclusionCreatePop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnConclusion"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionCreatePop.do?seq=" + (seq != null ? seq : targetSeq),  "ConclusionViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "newConclusionChange"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionChangePop.do?seq=" + (seq != null ? seq : targetSeq),  "ConclusionChangeCreatePop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnConclusionChange"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionChangePop.do?seq=" + (seq != null ? seq : targetSeq) + "&change_seq=" + sub_seq,  "ConclusionChangeViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnConclusionPayment"){
			
			if('${resFormSeq}' != ''){
				openWindow2("${pageContext.request.contextPath}/purchase/pop/ConclusionPaymentPop.do?formSeq=${resFormSeq}&seq=" + (seq != null ? seq : targetSeq),  "ConclusionPaymentViewPop", 1350, 800, 1, 1) ;	
			}else{
				msgSnackbar("warning", "???????????? ???????????? ???????????? ?????????");
			}
			
		}else if(callId == "btnMeet"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractMeetPop.do?seq=" + targetSeq,  "ContractMeetViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnResult"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractResultPop.do?seq=" + targetSeq,  "ContractResultViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnSave"){
			
			fnSaveColInfo();
			
		}else if(callId == "btnSelect"){
			
			puddActionBar_ = Pudd.puddActionBar({
				 
				height	: 100
			,	message : {
		 
						type : "text"		// text, html
					,	content : "???????????? ????????? ????????? ?????????"
					//	type : "html"		// text, html
					//,	content : '<span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #ffffff;">??????????????? ?????????????????????????</span>'
				}
			,	buttons : [
						{
								attributes : { style : "margin-top:4px;width:auto;" }// control ?????? ?????? ?????? ??????
							,	controlAttributes : { id : "", class : "submit" }// control ?????? ?????? ?????? ??????
							,	value : "???????????????????????? ??????"
							,	clickCallback : function( puddActionBar ) {
									fnCallBtn("contractView", seq);
									
									$('.iframe_wrap').attr('onclick','').unbind('click');
									puddActionBar.showActionBar( false );
								}
						}
					,	{
								attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control ?????? ?????? ?????? ??????
							,	controlAttributes : { id : "", class : "submit" }// control ?????? ?????? ?????? ??????
							,	value : "???????????? ??????"
							,	clickCallback : function( puddActionBar ) {
									fnCallBtn("btnConclusion", seq);
									
									$('.iframe_wrap').attr('onclick','').unbind('click');
									puddActionBar.showActionBar( false );
								}
						}
				]
		});			
			
			setTimeout(function() {
				$(".iframe_wrap").on("click", function(e){puddActionBar_.showActionBar( false );$('.iframe_wrap').attr('onclick','').unbind('click');});
			}, 200);				
			
			
		}else {
			msgSnackbar("warning", "??????????????????.");
		}
		
	}
	
	function fnContractStatePop(btnType, seq){
		
		if(seq == null && targetSeq == ""){
			
			if(btnType == "btnConclusion"){
				fnCallBtn("newConclusion");	
			}else{
				msgSnackbar("warning", "???????????? ???????????? ????????? ?????????.");
			}
			
			return;
		}
		
		var reqParam = {};
		
		if(seq){
			reqParam.seq = seq;
		}else{
			reqParam.seq = targetSeq;	
		}
		
		var resultState = false;
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/ContractInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : false,
			success : function(result) {
				
				console.log("seq > " + result.resultData.seq);
				console.log("contract_type > " + result.resultData.contract_type);
				console.log("doc_sts > " + result.resultData.doc_sts);
				console.log("approkey_plan > " + result.resultData.approkey_plan);
				console.log("approkey_meet > " + result.resultData.approkey_meet);
				console.log("approkey_result > " + result.resultData.approkey_result);
				console.log("approkey_conclusion > " + result.resultData.approkey_conclusion);
				console.log("approkey_change > " + result.resultData.approkey_change);
				console.log("doc_sts_change > " + result.resultData.doc_sts_change);
				console.log("change_seq > " + result.resultData.change_seq);
				console.log("change_seq_temp > " + result.resultData.change_seq_temp);
				
				if(btnType == "btnConclusionPayment"){
					
					if(result.resultData.doc_sts_change == "20"){
						//???????????? ?????? ?????????
						msgSnackbar("warning", "???????????? ?????????????????? ?????? ???????????? ????????? ???????????????.");
						return;							
					}else{
						resultState = true;
					}
					
				}else if(btnType == "btnConclusionChange"){
					
					if(result.resultData.change_seq_temp != ""){
						fnCallBtn("btnConclusionChange", result.resultData.seq, result.resultData.change_seq_temp);
						return;							
					}else if(result.resultData.doc_sts_change == "10"){
						fnCallBtn("btnConclusionChange", result.resultData.seq, result.resultData.change_seq);
						return;							
					}else if(result.resultData.approkey_conclusion != "" && result.resultData.doc_sts == "90") {
						resultState = true;
						btnType = "newConclusionChange";
					}
					
				}else if(btnType == "contractView"){
					
					resultState = true;
					
					if(result.resultData.contract_type == "02"){
						btnType = "btnConclusion";
					}else if(result.resultData.c_title != null && result.resultData.c_title != ""){
						btnType = "btnSelect";
					}
					
				}else if(btnType == "btnConclusion"){
					
					if(result.resultData.approkey_conclusion != "" || (result.resultData.approkey_result != "" && result.resultData.doc_sts == "90")){
						resultState = true;
					}
					
				}else if(result.resultData.approkey_result != ""){
					
					if(btnType == "btnMeet" || btnType == "btnResult"){
						resultState = true;
					}
					
				}else if(result.resultData.approkey_meet != ""){
					
					if(btnType == "btnMeet" || (btnType == "btnResult" && result.resultData.doc_sts == "90")){
						resultState = true;
					}
					
				}else if(result.resultData.approkey_plan != ""){
					
					if(btnType == "btnMeet" && result.resultData.doc_sts == "90"){
						resultState = true;
					}
					
				}
				
				if(resultState){
					
					fnCallBtn(btnType, seq);
					
				}else{
					msgSnackbar("warning", "?????? ????????? ?????? ????????? ???????????? ???????????????.");
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "????????? ????????? ??????????????????.");
			}
		});		
	}
	
	
    function excelDown() {
        
    	Pudd( "#circularProgressBar" ).puddProgressBar({
     
    		progressType : "circular"
    	,	attributes : { style:"width:150px; height:150px;" }
    	,	strokeColor : "#00bcd4"	// progress ??????
    	,	strokeWidth : "3px"	// progress ??????
    	,	percentText : ""
    	,	percentTextColor : "#fff"
    	,	percentTextSize : "24px"
    	,	modal : true
    	,	extraText : {
    			text : ""
    		,	attributes : { style : "" }
    		}
    	,	progressStartCallback : function( progressBarObj ) {
     
    			excelDownloadProcess( "????????????.xlsx", progressBarObj );
    		}
    	});
    }	
	
    function excelDownloadProcess( fileName, progressBarObj ) {
        
    	var dataSourceList = new Pudd.Data.DataSource({
     
    		pageSize : 999999
    	,	serverPaging : true
     
    	,	request : {
     
    			url : '<c:url value="/purchase/${authLevel}/SelectContractList.do" />'
    		,	type : 'post'
    		,	dataType : "json"
     
    		,	parameterMapping : function( data ) {
     
	    			data.searchFromDate = $("#searchFromDate").val();
	    			data.searchToDate = $("#searchToDate").val();
	    			data.contractTitle = $("#contractTitle").val();
	    			data.writeDeptName = $("#writeDeptName").val();
	    			<c:if test="${authLevel!='user'}">
	    			data.writeEmpName = $("#writeEmpName").val();
	    			</c:if>
	    			<c:if test="${authLevel=='user'}">
	    			data.writeEmpName = "";
	    			</c:if>	
	 				return data ;
    			}
    		}
     
    	,	result : {
     
    			data : function( response ) {
     
    				return response.list;
    			}
     
    		,	totalCount : function( response ) {
     
    				return response.totalCount;
    			}
     
    		,	error : function( response ) {
     
    				//alert( "error - Pudd.Data.DataSource.read, status code - " + response.status );
    			}
    		}
    	});
     
    	progressBarObj.updateProgressBar( 10 );// 10%
     
    	setTimeout( function() {
     
    		dataSourceList.read( false, function(){
     
    			if( true === dataSourceList.responseResult ) {// success
     
    				progressBarObj.updateProgressBar( 40 );// 40%
     
    				// json data ??????
    				var dataPage = dataSourceList.dataPage;
    				var dataLen = dataPage.length;
     
    				// excel?????? ???????????? ??????
    				generateExcelDownload( dataPage, fileName, function() {// saveCallback
     
    					progressBarObj.updateProgressBar( 100 );// 100%
    					progressBarObj.clearIntervalSet();// progressBar ??????
     
    				}, function( rowIdx ){// stepCallback
     
    					if( dataLen ) {
     
    						var percent = ( ( rowIdx * 100 / dataLen ) / 2 ) + 40;
    						percent = parseInt( percent );
     
    						progressBarObj.updateProgressBar( percent );
    					}
    				});
     
    			} else {// error
     
    				progressBarObj.clearIntervalSet();// progressBar ??????
    			}
    		});
    	}, 10);
    }    
    
    
    function generateExcelDownload( dataPage, fileName, saveCallback, stepCallback ) {
        
    	var excel = new JExcel("?????? ?????? 11 #333333");
    	excel.set( { sheet : 0, value : "Sheet1" } );
     	
		var totalCount = dataPage.length;
		
    	// ?????? ?????? ?????? ??????
    	var periodStyle = excel.addStyle({
    		font: "?????? ?????? 11 #333333 B"
    	})
    	var period = "????????????: " + $("#searchFromDate").val() + "~" + $("#searchToDate").val() + " / ??? " + totalCount + "???"; 
    	excel.set(0, 0, 0, period, periodStyle);
    	
    	var formatHeader = excel.addStyle ({
    		border: "thin,thin,thin,thin #000000",
    		fill: "#dedede",
    		font: "?????? ?????? 11 #333333 B",// U : underline, B : bold, I : Italic
    		align : "C C",
    	});
		    	
    	var headerRow = 3;
    	var headerCol = 37;
    	
    	for(var i=1; i < headerRow; i++) {
    		for(var j=0; j < headerCol; j++) {
    			excel.set(0, j, i, null, formatHeader);
    		}
    	}
    	
    	excel.set(0, 0, 1, "????????????");
    	excel.mergeCell(0, 0, 1, 9, 1);
    	excel.set(0, 0, 2, "??????");
    	excel.set(0, 1, 2, "????????????");
    	excel.set(0, 2, 2, "????????????");
    	excel.set(0, 3, 2, "???????????????");
    	excel.set(0, 4, 2, "??????/??????");    	
    	excel.set(0, 5, 2, "?????????");
    	excel.set(0, 6, 2, "????????????");
    	excel.set(0, 7, 2, "???????????????");
    	excel.set(0, 8, 2, "???????????????");
    	excel.set(0, 9, 2, "????????????");
    	
    	excel.set(0, 10, 1, "?????????????????????");
    	excel.mergeCell(0, 10, 1, 13, 1);
    	excel.set(0, 10, 2, "???????????????");
    	excel.set(0, 11, 2, "?????????????????????");
    	excel.set(0, 12, 2, "????????????");
    	excel.set(0, 13, 2, "??????????????????");
    	
    	excel.set(0, 14, 1, "????????????");
    	excel.mergeCell(0, 14, 1, 18, 1);
    	excel.set(0, 14, 2, "????????????");
    	excel.set(0, 15, 2, "????????????");
    	excel.set(0, 16, 2, "?????????????????????");    	
    	excel.set(0, 17, 2, "?????????");    	
    	excel.set(0, 18, 2, "???????????????");   
    	
    	excel.set(0, 19, 1, "????????????");
    	excel.mergeCell(0, 19, 1, 24, 1);
    	excel.set(0, 19, 2, "????????????????????????");
    	excel.set(0, 20, 2, "??? ????????????");
    	excel.set(0, 21, 2, "??? ????????????");
    	excel.set(0, 22, 2, "???????????? ??????");    	
    	excel.set(0, 23, 2, "????????????");    	
    	excel.set(0, 24, 2, "??????????????????");     
    	
    	excel.set(0, 25, 1, "??????????????????");
    	excel.mergeCell(0, 25, 1, 29, 1);
    	excel.set(0, 25, 2, "???????????????");
    	excel.set(0, 26, 2, "??????????????????");
    	excel.set(0, 27, 2, "??????????????????");
    	excel.set(0, 28, 2, "??????????????????");    	
    	excel.set(0, 29, 2, "????????????");    	
    	
    	excel.set(0, 30, 1, "??????????????????");
    	excel.mergeCell(0, 30, 1, 34, 1);
    	excel.set(0, 30, 2, "?????????");
    	excel.set(0, 31, 2, "???????????????");
    	excel.set(0, 32, 2, "?????????");
    	excel.set(0, 33, 2, "??????");    	
    	excel.set(0, 34, 2, "?????????");    	
    	
    	excel.set(0, 35, 1, "??????");
    	excel.mergeCell(0, 35, 1, 36, 1);
    	excel.set(0, 35, 2, "?????????");
    	excel.set(0, 36, 2, "??????????????????");
    	
    	// sheet??????, column, value(width)
    	for( var i = 0; i < 37; i++ ) {
    		excel.setColumnWidth( 0, i, 20 );
    	}    	
    	
    	excel.setColumnWidth( 0, 5, 50 );
    	excel.setColumnWidth( 0, 9, 50 );
    	
    	excel.setColumnWidth( 0, 13, 25 );
    	excel.setColumnWidth( 0, 20, 25 );
    	excel.setColumnWidth( 0, 21, 25 );
    	excel.setColumnWidth( 0, 24, 25 );
    	
    	var formatCell = excel.addStyle ({
    		align : "C"
    	});
    	
    	// header row ???????????? ??????
    	for( var i = 0; i < totalCount; i++ ) {
    		var rowNo = i + 3;
    		excel.set( 0, 0, rowNo, dataPage[ i ][ "seq" ], formatCell );
    		excel.set( 0, 1, rowNo, dataPage[ i ][ "manage_no" ], formatCell );
    		excel.set( 0, 2, rowNo, dataPage[ i ][ "contract_no" ], formatCell );
    		excel.set( 0, 3, rowNo, dataPage[ i ][ "target_type_name" ], formatCell );
    		excel.set( 0, 4, rowNo, dataPage[ i ][ "contract_type_text" ], formatCell );
    		excel.set( 0, 5, rowNo, dataPage[ i ][ "title" ], formatCell );
    		excel.set( 0, 6, rowNo, dataPage[ i ][ "contract_amt" ], formatCell );
    		excel.set( 0, 7, rowNo, dataPage[ i ][ "contract_start_dt" ], formatCell );
    		excel.set( 0, 8, rowNo, dataPage[ i ][ "contract_end_dt" ], formatCell );
    		excel.set( 0, 9, rowNo, dataPage[ i ][ "base_law_name" ], formatCell );
    		excel.set( 0, 10, rowNo, dataPage[ i ][ "tr_name" ], formatCell );
    		excel.set( 0, 11, rowNo, dataPage[ i ][ "tr_reg_number" ], formatCell );
    		excel.set( 0, 12, rowNo, dataPage[ i ][ "ceo_name" ], formatCell );
    		excel.set( 0, 13, rowNo, dataPage[ i ][ "hope_company_info" ], formatCell );
    		excel.set( 0, 14, rowNo, dataPage[ i ][ "amt" ], formatCell );
    		excel.set( 0, 15, rowNo, dataPage[ i ][ "compete_type_text" ], formatCell );
    		excel.set( 0, 16, rowNo, dataPage[ i ][ "decision_type_text" ], formatCell );
    		excel.set( 0, 17, rowNo, dataPage[ i ][ "emp_name" ], formatCell );
    		excel.set( 0, 18, rowNo, dataPage[ i ][ "dept_name" ], formatCell );
    		excel.set( 0, 19, rowNo, dataPage[ i ][ "pre_notice_end_dt" ], formatCell );
    		excel.set( 0, 20, rowNo, dataPage[ i ][ "notice_start_dt" ] != "" && dataPage[ i ][ "notice_end_dt" ] != "" ? (dataPage[ i ][ "notice_start_dt" ] + "~" + dataPage[ i ][ "notice_end_dt" ]) : "", formatCell );
    		excel.set( 0, 21, rowNo, dataPage[ i ][ "re_notice_start_dt" ] != "" && dataPage[ i ][ "re_notice_end_dt" ] != "" ? (dataPage[ i ][ "re_notice_start_dt" ] + "~" + dataPage[ i ][ "re_notice_end_dt" ]) : "", formatCell );
    		excel.set( 0, 22, rowNo, dataPage[ i ][ "notice_start_dt" ] != "" && dataPage[ i ][ "notice_end_dt" ] != "" ? "??????" : "", formatCell );
    		excel.set( 0, 23, rowNo, dataPage[ i ][ "bidder_cnt" ], formatCell );
    		excel.set( 0, 24, rowNo, dataPage[ i ][ "meet_dt" ], formatCell );
    		excel.set( 0, 25, rowNo, dataPage[ i ][ "contract_change_dt" ], formatCell );
    		excel.set( 0, 26, rowNo, dataPage[ i ][ "work_info_after" ], formatCell );
    		excel.set( 0, 27, rowNo, dataPage[ i ][ "contract_end_dt_after" ], formatCell );
    		excel.set( 0, 28, rowNo, dataPage[ i ][ "contract_amt_after" ] != "" && dataPage[ i ][ "contract_amt_after" ] != "0" ? dataPage[ i ][ "contract_amt_after" ] : "", formatCell );
    		excel.set( 0, 29, rowNo, dataPage[ i ][ "change_etc" ], formatCell );
    		excel.set( 0, 30, rowNo, dataPage[ i ][ "pay_amt_a" ], formatCell );
    		excel.set( 0, 31, rowNo, dataPage[ i ][ "pay_amt_b" ], formatCell );
    		excel.set( 0, 32, rowNo, dataPage[ i ][ "pay_amt_c" ], formatCell );
    		excel.set( 0, 33, rowNo, dataPage[ i ][ "remain_amt" ], formatCell );
    		
			if(dataPage[ i ][ "remain_amt" ] != ""){
				var amt = parseInt(dataPage[ i ][ "contract_amt" ].replace(/,/g, ''));
				var remain_amt = parseInt(dataPage[ i ][ "remain_amt" ].replace(/,/g, ''));
				excel.set( 0, 34, rowNo, ((amt-remain_amt)/amt*100).toFixed(1) + " %", formatCell );
				
			}   		
			
			if(dataPage[ i ][ "contract_attach_info" ] != ""){
				excel.set( 0, 35, rowNo, "??????", formatCell );	
			}
			
			if(dataPage[ i ][ "submit_attach_info" ] != ""){
				excel.set( 0, 36, rowNo, "??????", formatCell );
			}			
    		
    	}
     
    	excel.generate( fileName, saveCallback, stepCallback );
    }    
	
</script>




<!-- ???????????? -->
<div class="top_box">
	<dl>
		<dt class="ar" style="width:60px;">????????????</dt>
		<dd>
			<input type="text" id="searchFromDate" value="${fromDate}" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" id="searchToDate" value="${toDate}" class="puddSetup" pudd-type="datepicker"/>
		</dd>
		<dt class="ar" style="width:40px;">?????????</dt>
		<dd><input type="text" id="contractTitle" pudd-style="width:120px;" class="puddSetup" placeHolder="????????? ??????" value="" /></dd>
		<dt class="ar" style="width:40px;">?????????</dt>
		<dd><input type="text" id="writeDeptName" pudd-style="width:120px;" class="puddSetup" placeHolder="????????? ??????" value="" /></dd>
		
		<c:if test="${authLevel!='user'}">
		<dt class="ar" style="width:40px;">?????????</dt>
		<dd><input type="text" id="writeEmpName" pudd-style="width:90px;" class="puddSetup" placeHolder="????????? ??????" value="" /></dd>
		</c:if>
		
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="??????" onclick="BindGrid();" /></dd>
		
	</dl>
</div>

<div class="sub_contents_wrap posi_re">
	<div class="btn_div">
		<div class="left_div">
			<div id="" class="controll_btn p0">
				<input type="button" onclick="fnCallBtn('newContract');" class="puddSetup" style="background:#03a9f4;color:#fff;" value="??????????????????" />
				<input type="button" onclick="fnCallBtn('newConclusion');" style="background:#03a9f4;color:#fff" class="puddSetup" value="1?????????????????????" />
			</div>
		</div>
		<div class="right_div">
			<div id="" class="controll_btn p0">
				<c:if test="${authLevel=='admin'}">
				<input id="adminSaveBtn" style="display:none;width:70px;background:rgb(0 0 0);color:#fff;" type="button" onclick="fnCallBtn('btnSave');" class="puddSetup" value="??????" />
				</c:if>
				<input type="button" onclick="excelDown();" class="puddSetup" value="??????????????????" />
			</div>
		</div>		
	</div>
	
	<div class="dal_Box_">
		<div class="dal_BoxIn_ posi_re">
			<div id="grid1"></div>
		</div>
	</div>
	<input style="display:none;" id="file_upload" type="file" />
	<div id="exArea"></div>
	<div id="jugglingProgressBar"></div>
	<div id="loadingProgressBar"></div>
	<div id="circularProgressBar"></div>	
</div><!-- //sub_contents_wrap -->