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
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>프로세스별 첨부파일 양식관리</title>

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
    <script type="text/javascript" src="<c:url value='/js/jquery.maskMoney.js' />"></script>  
	
	<script type="text/javascript">
	
		var changeInfoList = [];	
		var insertCodeInfo = {};	
		var selGroup;		

		$(document).ready(function() {
			BindGroupGrid();
			document.getElementById('file_upload').addEventListener('change', handleFileSelect, false);
		});
			
		function BindGroupGrid(){
			
			var dataSource = new Pudd.Data.DataSource({
					serverPaging: true
				,	editable : true
				,	pageSize: 10
				,	request : {
					    url : '<c:url value="/purchase/admin/SelectCodeGroupList.do" />'
					,	type : 'post'
					,	dataType : "json"
					,   parameterMapping : function( data ) {
						data.TYPE = "attachForm";
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
				,	pageInfo : false
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
						
						selGroup = rowData.GROUP;
						changeInfoList = [];
						$("#adminSaveBtn").hide();
						BindCodeGrid();
					 
					});				
			}		
			
			,	columns : [
					{
						field : "NAME"
					,	title : "프로세스명"
					,	width : 110
					,	content : {
							attributes : { class : "ci" }
						}
					},	
					{
						field : "NOTE"
					,	title : "비고"
					,	width : 50
					,	content : {
							attributes : { class : "ci" }
						}
					}					
					
				]
			});	
		} 	
		

		
		function BindCodeGrid(){
			
			changeInfoList = [];
			$("#adminSaveBtn").hide();
			$("#codeEditBtn").show();
			
			var dataSource = new Pudd.Data.DataSource({
					serverPaging: true
				,	editable : true
				,	pageSize: 10
				,	request : {
					    url : '<c:url value="/purchase/admin/SelectCodeList.do" />'
					,	type : 'post'
					,	dataType : "json"
					,   parameterMapping : function( data ) {
						
						data.GROUP = selGroup;
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
			
			Pudd("#grid2").puddGrid({
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
			
			,	columns : [
					{
						field : "gridCheckBox"		// grid 내포 checkbox 사용할 경우 고유값 전달
					,	width : 34
					,	editControl : {
							type : "checkbox"
						,	basicUse : true
						}
					},				
					{
						field : "CODE"
					,	title : "양식코드"
					,	width : 50
					},
					{
						field : "NAME"
					,	title : "양식명"
					,	width : 90
					,	content : {
							template : function( rowData ) {
								return '<input onkeyup="fnSetChangeInfo(\''+rowData.CODE+'\', \'NAME\', \''+rowData.NAME+'\', this.value)" class="puddSetup ac" type="text" value="' + rowData.NAME + '" pudd-style="height:100%;width:100%;"/>';
							}
						}
					},
					{
						field : ""
					,	title : "양식파일"
					,	width : 200
					,	content : {
							template : function( rowData ) {
								
								var attachInfo =  rowData.LINK.split("▦");
								
								if(attachInfo.length > 1 && attachInfo[1] != ""){
									
									var fileExt = "";
								    var lastDot = attachInfo[1].lastIndexOf('.');
								    
								    if(lastDot > 0){
								    	fileExt = attachInfo[1].substr(lastDot);
								    }
									
									return '<div link_attach="'+rowData.CODE+'" style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="'+attachInfo[2]+'" class="fl ellipsis pl5 text_ho" style="max-width:180px;" ><img name="uploadFileIco" src="${pageContext.request.contextPath}' + fncGetFileClassImg(fileExt) + '" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName">' + attachInfo[1] + '<span></em></span> <input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.CODE+'\', \'LINK\', this)" /></div>';
								}else{
									return '<div link_attach="'+rowData.CODE+'" style="text-align: right;"><span class="text_ho"><em onclick="fnDownload(this)" fileid="" class="fl ellipsis pl5 text_ho" style="max-width:180px; display:none;" ><img name="uploadFileIco" src="" alt="" style="vertical-align: middle;" class="mtImg"/> <span name="uploadFileName"><span></em></span> <input type="button" class="puddSetup ml5" value="파일찾기" onclick="fnSearchFile(\''+rowData.CODE+'\', \'LINK\', this)" /></div>';
								}
							}
						}
					},					
					{
						field : "USE_YN"
					,	title : "필수여부"
					,	width : 50
					,	content : {
							template : function( rowData ) {
								
								var requiredYn = "N";
								var attachInfo =  rowData.LINK.split("▦");
								
								if(attachInfo[0] == "Y"){
									requiredYn = "Y";
								}
								
								return '<select link_required="'+rowData.CODE+'" style="width:50px;text-align:center;" onchange="fnSetChangeInfo(\''+rowData.CODE+'\', \'LINK\', \''+rowData.LINK+'\')"><option value="Y"' + (requiredYn == "Y" ? ' selected ' : '') + '>Y</option><option value="N"' + (requiredYn != "Y" ? ' selected ' : '') + '>N</option></select>';
							}
						}
					},		
					{
						field : "ORDER_NUM"
					,	title : "정렬"
					,	width : 50
					,	content : {
							template : function( rowData ) {
								return '<input onkeyup="fnSetChangeInfo(\''+rowData.CODE+'\', \'ORDER_NUM\', \''+rowData.ORDER_NUM.toString() +'\', this.value)" class="puddSetup ac" type="text" value="' + rowData.ORDER_NUM.toString() + '" pudd-style="height:100%;width:100%;" onKeyup="this.value=this.value.replace(/[^0-9]/g,\'\');" />';
							}
						}
					},
					{
						field : "USE_YN"
					,	title : "사용여부"
					,	width : 50
					,	content : {
							template : function( rowData ) {
								return '<select style="width:50px;text-align:center;" onchange="fnSetChangeInfo(\''+rowData.CODE+'\', \'USE_YN\', \''+rowData.USE_YN+'\', this.value)"><option value="Y"' + (rowData.USE_YN == "Y" ? ' selected ' : '') + '>Y</option><option value="N"' + (rowData.USE_YN == "N" ? ' selected ' : '') + '>N</option></select>';
							}
						}
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
		                
		                fnSetChangeInfo(attachTargetSeq, "LINK", "");
						
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
		
		
		
		function insertLayerPop(){

			// puddDialog 함수
			Pudd.puddDialog({
			 
				width : 300
			,	height : 195
			 
			,	modal : true			// 기본값 true
			,	draggable : false		// 기본값 true
			,	resize : false			// 기본값 false
			 
			,	header : {
		 		title : "코드추가"
			,	closeButton : true	// 기본값 true
			,	closeCallback : function( puddDlg ) {
					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}
			 
			,	body : {
			 
					iframe : true
				,	url : "${pageContext.request.contextPath}/purchase/layer/CodeFormInsertLayer.do"
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
						,	value : "저장"
						,	clickCallback : function( puddDlg ) {
							
								var iframeTag = document.getElementById( "dlgFrame" );
								insertCodeInfo = iframeTag.contentWindow.GetInsertCodeInfo();
								insertCodeInfo.GROUP = selGroup;
								
								if(insertCodeInfo.CODE == ""){
									msgSnackbar("warning", "코드를 입력해 주세요.");
								}else if(insertCodeInfo.NAME == ""){
									msgSnackbar("warning", "코드명을 입력해 주세요.");
								}else{
									
									//중복코드 체크
									$.ajax({
										type : 'post',
										url : '<c:url value="/purchase/admin/fnCheckCodeValidation.do" />',
							    		datatype:"json",
							            data: insertCodeInfo ,
										async : false,
										success : function(result) {
											
											if(result.resultCode == "success"){
												
												puddDlg.showDialog( false );
												confirmAlert(350, 100, 'question', '저장하시겠습니까?', '저장', 'fnInsertProc()', '취소', '');													
												
											}else{
												msgSnackbar("error", "이미 등록된 코드입니다.");
											}
											
										},
										error : function(result) {
											msgSnackbar("error", "삭제 실패했습니다.");
										}
									});										
								}
							}
						},
						{
							attributes : { style : "margin-left:5px;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "btnCancel" }// control 자체 객체 속성 설정
						,	value : "취소"
						,	clickCallback : function( puddDlg ) {
								puddDlg.showDialog( false );
							}
						}
					]
				}
			});			
			
		}		
		
		function fnInsertProc(){
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/admin/insertCommonCodeProc.do" />',
	    		datatype:"json",
	            data: insertCodeInfo ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						msgSnackbar("success", "요청하신 삭제건 처리가 완료되었습니다.");
						BindCodeGrid();
						
					}else{
						msgSnackbar("error", "삭제 실패했습니다.");
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "삭제 실패했습니다.");
				}
			});		
			
		}		
		
				
		function checkNumber(event) {
			  if(event.key >= 0 && event.key <= 9) {
			    return true;
			  }
			  
			  return false;
		}

		
		function fnSetChangeInfo(CODE, calName, oriVal, newVal){
			
			if(calName == "LINK"){
				newVal = $("[link_required='"+CODE+"']").val() 
				+ "▦" + $("[link_attach='"+CODE+"']").find("[name=uploadFileName]").text() 
				+ "▦" + $("[link_attach='"+CODE+"'] em").attr("fileid");
			}
			
			var targetObj = changeInfoList.find(obj => obj.CODE === CODE);
			
			if(oriVal != newVal && targetObj == null){
				var changeInfo = {};
				changeInfo.CODE = CODE;
				changeInfoList.push(changeInfo)
			}
			
			if(oriVal != newVal){
				changeInfoList.find(obj => obj.CODE === CODE)[calName] = newVal;
			}else if(targetObj){
				delete changeInfoList.find(obj => obj.CODE === CODE)[calName];
			}
			
			if(changeInfoList.find(obj => obj.CODE === CODE)){
				
				if(Object.keys(changeInfoList.find(obj => obj.CODE === CODE)).length == 1){
					changeInfoList.some(function(item, index) {
				    	(changeInfoList[index]["CODE"] == CODE) ? !!(changeInfoList.splice(index, 1)) : false;
				    });
				}
			}
			
			if(changeInfoList.length > 0){
				$("#adminSaveBtn").show();	
			}else{
				$("#adminSaveBtn").hide();
			}
			
		}		
		
		function fnSaveColInfo(){
			
			if(changeInfoList.length > 0){
				confirmAlert(350, 100, 'question', '저장하시겠습니까?', '저장', 'fnSaveProc()', '취소', '');	
			}else{
				msgSnackbar("warning", "수정한 항목이 없습니다.");
			}
			
		}		
		
		function fnSaveProc(){
			
			var insertDataObject = {};
			insertDataObject.GROUP = selGroup;
			insertDataObject.change_info_list = JSON.stringify(changeInfoList);
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/admin/updateCommonCodeProc.do" />',
	    		datatype:"json",
	            data: insertDataObject ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						msgSnackbar("success", "요청하신 변경건 처리가 완료되었습니다.");
						BindCodeGrid();
						
					}else{
						
						msgSnackbar("error", "등록에 실패했습니다.");
						
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "등록에 실패했습니다.");
				}
			});		
			
		}		
		
		var delParam = {};
		
		function fnDel(){
			
			var dataCheckedRow = Pudd( "#grid2" ).getPuddObject().getGridCheckedRowData( "gridCheckBox" );
			
		    if(dataCheckedRow && dataCheckedRow.length == 0) {
		    	msgSnackbar("error", "삭제할 코드를 선택해 주세요.");
				return;
			}
			
		    var selectedList = [];
		    
		    $.each(dataCheckedRow, function (i, t) {
		    	
		    	var selectedInfo = {};
				selectedInfo.GROUP = selGroup;
				selectedInfo.CODE = t.CODE;
				selectedList.push(selectedInfo);
		    	
		    });
		    
			delParam = {};
			delParam.GROUP = selGroup;
			delParam.change_info_list = JSON.stringify(selectedList);		
			
			confirmAlert(350, 100, 'question', '삭제하시겠습니까?', '삭제', 'fnDelProc()', '취소', '');			

		}		
		
		function fnDelProc(){
			
			$.ajax({
				type : 'post',
				url : '<c:url value="/purchase/admin/deleteCommonCodeProc.do" />',
	    		datatype:"json",
	            data: delParam ,
				async : false,
				success : function(result) {
					
					if(result.resultCode == "success"){
						
						msgSnackbar("success", "요청하신 삭제건 처리가 완료되었습니다.");
						BindCodeGrid();
						
					}else{
						
						msgSnackbar("error", "삭제 실패했습니다.");
						
					}
					
				},
				error : function(result) {
					msgSnackbar("error", "삭제 실패했습니다.");
				}
			});		
			
		}
		
	</script>
</head>

<body>


	<div class="sub_contents_wrap">
		<div class="twinbox">
			<table style="min-width:800px;min-height:450px;"> 
				<colgroup>
					<col width="300px;"/>
					<col width="700px;"/>
				</colgroup>
				<tr>
					<td class="twinbox_td">
						<div class="btn_div mt0">
							<div class="left_div">							
								<h5>프로세스별 첨부파일 양식관리</h5>
							</div>
						</div>
	
						<div id="grid1"></div>			
					</td>
	
					<td class="twinbox_td">
						<div class="btn_div mt0">
							<div class="right_div">
								<div style="display:none;" id="codeEditBtn" class="controll_btn p0">
									<input onclick="insertLayerPop();" type="button" class="puddSetup" value="추가" />
									<input onclick="fnDel();" type="button" class="puddSetup" value="삭제" />
									<input onclick="fnSaveColInfo();" id="adminSaveBtn" style="background:#03a9f4;color:#fff;display:none;" type="button" class="puddSetup" value="저장" />
								</div>
							</div>
						</div>
	
						<div id="grid2"></div>	
					</td>
				</tr>
			</table>
		</div>
			
			
	</div><!-- //sub_contents_wrap -->
	<input style="display:none;" id="file_upload" type="file" />
</body>
</html>