<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

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

<script>

	var targetSeq = "";
	var uploadPer = 0;
	
	$(document).ready(function() {
		
		BindGrid();
		
		document.getElementById('file_upload').addEventListener('change', handleFileSelect, false);

	});//---documentready
	
	var changeInfoList = [];
	
	function fnSaveColInfo(){
		
		if(changeInfoList.length > 0){
			confirmAlert(350, 100, 'question', '저장하시겠습니까?', '저장', 'fnSaveProc()', '취소', '');	
		}else{
			msgSnackbar("warning", "수정한 항목이 없습니다.");
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
			async : true,
			success : function(result) {
				
				if(result.resultCode == "success"){
					
					msgSnackbar("success", "요청하신 변경건 처리가 완료되었습니다.");
					BindGrid();
					changeInfoList = [];
					
				}else{
					
					msgSnackbar("error", "등록에 실패했습니다.");
					
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "등록에 실패했습니다.");
			}
		});		
		
	}
	
	function fnSetChangeInfo(seq, calName, oriVal, newVal){
		
		console.log("seq > " + seq);
		console.log("calName > " + calName);
		console.log("oriVal > " + oriVal);
		console.log("newVal > " + newVal);		
		
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
		, 	pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
		,	serverPaging : true		
		,	pageable : {
				buttonCount : 10 
			,	pageList : [ 10, 20, 30, 40, 50 ]
			,	pageInfo : true
			}
		
		,	noDataMessage : {
			message : "검색된 데이터가 없습니다."
		}		
		,	progressBar : {
		   	 
				progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }
			,	strokeColor : "#84c9ff"	// progress 색상
			,	strokeWidth : "3px"	// progress 두께
			,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
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
				title : "기본정보"
			,	columns : [
				{
						field : "seq"
					,	title : "연변"
					,	width : 70
					,	content : {
							attributes : { class : "ci" }
					}
				}					
			,	{
						field : "manage_no"
					,	title : "관리번호"
					,	width : 130
					
					,	content : {
						// param : row에 해당되는 Data, td Node 객체, tr Node 객체, grid 객체
						clickCallback : function( rowData, tdNode, trNode, gridObj ) {
							fnContractStatePop("contractView", rowData.seq);
						}
					}
					
				}
			,	{
						field : "contract_no"
					,	title : "계약번호"
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
					,	title : "계약목적물"
					,	width : 120
				}					
			,	{
						field : "title"
					,	title : "계약명"
					,	width : 250
					,	content : {
							attributes : { class : "le ellipsis" }
					}
					,	tooltip : { 
						alwaysShow : false		// 말줄임 여부와 관계없이 tooltip 보여줄 것인지 설정, 기본값 false
					,	showAtClientX : false	// toolTip 보여주는 위치가 mouse 움직이는 X 좌표 기준 여부, 기본값 false ( toolTip 부모객체 기준 )
					}
				}				
			,	{
						field : "amt"
					,	title : "계약금액"
					,	width : 130
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "contract_start_dt"
					,	title : "계약시작일"
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
					,	title : "계약종료일"
					,	width : 100							
				}
			,	{
						field : "base_law_name"
					,	title : "근거법령"
					,	width : 150
					, ellipsis : true
					,	tooltip : { 
						alwaysShow : false		// 말줄임 여부와 관계없이 tooltip 보여줄 것인지 설정, 기본값 false
					,	showAtClientX : false	// toolTip 보여주는 위치가 mouse 움직이는 X 좌표 기준 여부, 기본값 false ( toolTip 부모객체 기준 )
					}					
				}						
				]
			}
			,	{
				title : "계약대상자 정보"
			,	columns : [
				{
						field : "tr_name"
					,	title : "계약대상자"
					,	width : 100
				}					
			,	{
						field : "tr_reg_number"
					,	title : "사업자등록번호"
					,	width : 100
				}
			,	{
						field : "ceo_name"
					,	title : "대표자명"
					,	width : 100							
				}
			,	{
						field : "hope_company_info"
					,	title : "희망기업여부"
					,	width : 100
				}						
				]
			}
			,	{
				title : "발주정보"
			,	columns : [
				{
						field : "contract_type_text"
					,	title : "입찰/수의"
					,	width : 100
				}					
			,	{
						field : "amt"
					,	title : "발주금액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "compete_type_text"
					,	title : "경쟁방식"
					,	width : 100							
				}
			,	{
						field : "decision_type_text"
					,	title : "낙찰자결정방법"
					,	width : 100
				}	
			,	{
						field : "emp_name"
					,	title : "담당자"
					,	width : 100
			}
			,	{
						field : "dept_name"
					,	title : "담당부서"
					,	width : 120
			}					
				]
			}
			,	{
				title : "입찰정보"
			,	columns : [
				{
						field : ""
					,	title : "사전규격공개기간"
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
					,	title : "본 공고기간"
					,	width : 290
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'notice_start_dt\', \''+rowData.notice_start_dt+'\', this.value)" type="text" value="' + rowData.notice_start_dt + '" class="puddSetup" pudd-type="datepicker"/> ~ <input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'notice_end_dt\', \''+rowData.notice_end_dt+'\', this.value)" type="text" value="' + rowData.notice_end_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.notice_start_dt + " ~ " + rowData.notice_end_dt;
								</c:otherwise></c:choose>								
								
							}else{
								return "";
							}							

						}
					}
				}
			,	{
						field : ""
					,	title : "재 공고기간"
					,	width : 290			
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'re_notice_start_dt\', \''+rowData.re_notice_start_dt+'\', this.value)" type="text" value="' + rowData.re_notice_start_dt + '" class="puddSetup" pudd-type="datepicker"/> ~ <input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'re_notice_end_dt\', \''+rowData.re_notice_end_dt+'\', this.value)" type="text" value="' + rowData.re_notice_end_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.re_notice_start_dt + " ~ " + rowData.re_notice_end_dt;
								</c:otherwise></c:choose>									

							}else{
								return "";
							}
							
						}
					}				
				}
			,	{
						field : ""
					,	title : "공고기간 확정"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								if(rowData.notice_start_dt != "" && rowData.notice_end_dt != ""){
									return "확정";									
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
					,	title : "투찰자수"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_type == "01"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onkeyup="fnSetChangeInfo(\''+rowData.seq+'\', \'bidder_cnt\', \''+rowData.bidder_cnt+'\', this.value)" type="number" style="width:50px;" class="puddSetup ac" maxlength="2" value="' + rowData.bidder_cnt + '" /> 건';
								</c:when><c:otherwise>
								return rowData.bidder_cnt + (rowData.bidder_cnt != " 건" ? "" : ""); 
								</c:otherwise></c:choose>								
								
							}else{
								return "";
							}							
							
						}
					}
			}
			,	{
						field : "meet_dt"
					,	title : "제안서평가일"
					,	width : 180
			}					
				]
			}
			,	{
				title : "변경계약정보"
			,	columns : [
				{
						field : ""
					,	title : "변경계약일"
					,	width : 150
					,	content : {		
						template : function(rowData) {
							
							if(rowData.change_doc_sts == "90"){
								
								<c:choose><c:when test="${authLevel=='admin'}">
								return '<input onchange="fnSetChangeInfo(\''+rowData.seq+'\', \'contract_change_dt\', \''+rowData.contract_change_dt+'\', this.value)" type="text" value="' + rowData.contract_change_dt + '" class="puddSetup" pudd-type="datepicker"/>';
								</c:when><c:otherwise>
								return rowData.contract_change_dt; 
								</c:otherwise></c:choose>								
								
							}else if(rowData.change_doc_sts != "" && rowData.change_doc_sts != "10"){
								return rowData.contract_change_dt;
							}else{
								return "";
							}
							
						}
					}
				}					
			,	{
						field : "work_info_after"
					,	title : "과업내용변경"
					,	width : 100
				}
			,	{
						field : "contract_end_dt_after"
					,	title : "계약기간변경"
					,	width : 100							
				}	
			,	{
						field : ""
					,	title : "계약금액변경"
					,	width : 100		
					
					,	content : {		
						template : function(rowData) {
							
							if(rowData.contract_amt_after != "" && rowData.contract_amt_after != "0"){
								return rowData.contract_amt_after + " 원";
							}else{
								return "";
							}
							
						}
					}					
					
				}	
			,	{
						field : "change_etc"
					,	title : "기타변경"
					,	width : 100							
				}			
				]
			}
			,	{
				title : "대금지급정보"
			,	columns : [
				{
						field : "pay_amt_a"
					,	title : "선금액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : "pay_amt_b"
					,	title : "기성금합산"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "pay_amt_c"
					,	title : "준공금"
					,	width : 100	
					,	content : {
							attributes : { class : "ri" }
					}						
				}	
			,	{
						field : "remain_amt"
					,	title : "잔액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : ""
					,	title : "준공율"
					,	width : 100
					,	content : {		
						template : function(rowData) {
							
							if(rowData.remain_amt != ""){
								
								var amt = parseInt(rowData.amt.replace(/,/g, ''));
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
				title : "자료"
			,	columns : [
				{
						field : ""
					,	title : "계약서"
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function(rowData) {
							
							if(rowData.contract_attach_info != ""){
								var attachInfo =  rowData.contract_attach_info.split("▦");
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="'+attachInfo[2]+'" class="fl ellipsis pl5 text_ho" style="max-width:200px;" ><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName">'+attachInfo[0]+'<span></em><span name="uploadFileExt">'+attachInfo[1]+'</span></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.seq+'\', \'contract_attach_info\', this)" /></c:if></div>';	
							}else{
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="" class="fl ellipsis pl5 text_ho" style="max-width:200px; display:none;" ><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName"><span></em><span name="uploadFileExt"></span></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.seq+'\', \'contract_attach_info\', this)" /></c:if></div>';
							}
							
						}
					}
				}					
			,	{
						field : ""
					,	title : "계약제출서류"
					,	width : 100
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function(rowData) {
							
							if(rowData.submit_attach_info != ""){
								var attachInfo =  rowData.submit_attach_info.split("▦");
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="'+attachInfo[2]+'" class="fl ellipsis pl5 text_ho" style="max-width:200px;" ><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName">'+attachInfo[0]+'<span></em><span name="uploadFileExt">'+attachInfo[1]+'</span></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.seq+'\', \'submit_attach_info\', this)" /></c:if></div>';	
							}else{
								return '<div style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="" class="fl ellipsis pl5 text_ho" style="max-width:200px; display:none;" ><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName"><span></em><span name="uploadFileExt"></span></span> <c:if test="${authLevel=='admin'}"><input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.seq+'\', \'submit_attach_info\', this)" /></c:if></div>';
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
	
	function getUUID() {
		  return 'xxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
		    var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 3 | 8);
		    return v.toString(16);
		  });
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
	                $(attachTargetObj).find('[name="uploadFileName"]').text(f.fileName);
	                $(attachTargetObj).find('[name="uploadFileExt"]').text(f.fileExt);
	                
	                fnSetChangeInfo(attachTargetSeq, attachTargetColName, "", f.fileName + "▦" + f.fileExt + "▦" + f.uid);
					
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
	
	function fnDownload(e){
		this.location.href = "${pageContext.request.contextPath}/fileDownloadProc.do?fileId=" + $(e).attr("fileid");
	}	
	
	function fnSetBtn(rowData){
		
		targetSeq = rowData.seq;
		
		console.log("seq > " + rowData.seq);
		console.log("doc_sts > " + rowData.doc_sts);
		console.log("approkey_plan > " + rowData.approkey_plan);
		console.log("approkey_meet > " + rowData.approkey_meet);
		console.log("approkey_result > " + rowData.approkey_result);
		
	}
	
	var puddActionBar_;
	
	function fnCallBtn(callId, seq, sub_seq){
		
		if(callId == "newContract"){
			//입찰발주계획 신규
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractCreatePop.do",  "ContractCreatePop", 1200, 800, 1, 1) ;
			
		}else if(callId == "contractView"){
			//입찰발주계획 조회
			openWindow2("${pageContext.request.contextPath}/purchase/pop/ContractCreatePop.do?seq=" + seq,  "ContractViewPop", 1200, 800, 1, 1) ;
			
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
				msgSnackbar("warning", "대금지급 지출결의 양식코드 미설정");
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
					,	content : "상세조회 항목을 선택해 주세요"
					//	type : "html"		// text, html
					//,	content : '<span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #ffffff;">결재문서를 상신하시겠습니까?</span>'
				}
			,	buttons : [
						{
								attributes : { style : "margin-top:4px;width:auto;" }// control 부모 객체 속성 설정
							,	controlAttributes : { id : "", class : "submit" }// control 자체 객체 속성 설정
							,	value : "계약입찰발주계획 상세"
							,	clickCallback : function( puddActionBar ) {
									fnCallBtn("contractView", seq);
									
									$('.iframe_wrap').attr('onclick','').unbind('click');
									puddActionBar.showActionBar( false );
								}
						}
					,	{
								attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
							,	controlAttributes : { id : "", class : "submit" }// control 자체 객체 속성 설정
							,	value : "계약체결 상세"
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
			msgSnackbar("warning", "개발중입니다.");
		}
		
	}
	
	function fnContractStatePop(btnType, seq){
		
		if(seq == null && targetSeq == ""){
			
			if(btnType == "btnConclusion"){
				fnCallBtn("newConclusion");	
			}else{
				msgSnackbar("warning", "등록하실 계약건을 선택해 주세요.");
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
				console.log("change_seq > " + result.resultData.change_seq);
				
				if(btnType == "btnConclusionPayment"){
					
					if(result.resultData.change_seq != ""){
						msgSnackbar("warning", "진행중인 변경계약건이 있어 대금지급 신청이 불가합니다.");
						return;	
					}else if(result.resultData.approkey_conclusion != "" && result.resultData.doc_sts == "90"){
						resultState = true;
					}
					
				}else if(btnType == "btnConclusionChange"){
					
					if(result.resultData.change_seq != ""){
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
					}else if(result.resultData.c_title != null){
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
					msgSnackbar("warning", "이전 단계의 기안 신청이 완료되지 않았습니다.");
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});		
		

		
	}
	
	
	
</script>




<!-- 상세검색 -->
<div class="top_box">
	<dl>
		<dt class="ar" style="width:60px;">계약기간</dt>
		<dd>
			<input type="text" id="searchFromDate" value="${fromDate}" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" id="searchToDate" value="${toDate}" class="puddSetup" pudd-type="datepicker"/>
		</dd>
		<dt class="ar" style="width:40px;">계약명</dt>
		<dd><input type="text" id="contractTitle" pudd-style="width:120px;" class="puddSetup" placeHolder="공고명 입력" value="" /></dd>
		<dt class="ar" style="width:40px;">부서명</dt>
		<dd><input type="text" id="writeDeptName" pudd-style="width:120px;" class="puddSetup" placeHolder="부서명 입력" value="" /></dd>
		
		<c:if test="${authLevel!='user'}">
		<dt class="ar" style="width:40px;">사원명</dt>
		<dd><input type="text" id="writeEmpName" pudd-style="width:90px;" class="puddSetup" placeHolder="사원명 입력" value="" /></dd>
		</c:if>
		
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" onclick="BindGrid();" /></dd>
		
	</dl>
</div>

<div class="sub_contents_wrap posi_re">
	<!-- 연차생성 -->
	<div class="btn_div">
		<div class="right_div">
			<div id="" class="controll_btn p0">
				<input type="button" onclick="fnCallBtn('newContract');" class="puddSetup" style="background:#03a9f4;color:#fff" value="계약입찰발주계획" />
				<input type="button" id="btnMeet" onclick="fnContractStatePop('btnMeet');" class="puddSetup" value="제안서 평가회의" />
				<input type="button" id="btnResult" onclick="fnContractStatePop('btnResult');" class="puddSetup" value="제안서 평가결과" />
				<c:if test="${authLevel=='admin'}">
				<input type="button" onclick="fnCallBtn('btnSave');" class="puddSetup" value="저장" />
				</c:if>
				<input type="button" onclick="fnContractStatePop('btnConclusion');" style="background:#03a9f4;color:#fff" class="puddSetup" value="계약체결" />
				<input type="button" onclick="fnContractStatePop('btnConclusionChange');" class="puddSetup" value="변경계약" />
				<input type="button" onclick="fnContractStatePop('btnConclusionPayment');" class="puddSetup" value="대금지급" />
				<input type="button" onclick="fnCallBtn('ing');" class="puddSetup" value="엑셀다운로드" />
			</div>
		</div>
	</div>
	
	<div class="dal_Box">
		<div class="dal_BoxIn posi_re">
			<div id="grid1"></div>
		</div>
	</div>
	<input style="display:none;" id="file_upload" type="file" />
	<div id="exArea"></div>
</div><!-- //sub_contents_wrap -->