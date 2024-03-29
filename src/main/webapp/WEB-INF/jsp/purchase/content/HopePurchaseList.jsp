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
	<script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/jszip-3.1.5.min.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/FileSaver-1.2.2_1.js' />"></script> 
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/excel/jexcel-1.0.5.js' />"></script> 
    
<script>

	var deptSeq = "${deptSeq}";
	var deptName = "${deptName}";
	var authLevel = "${authLevel}";
	var seq;
	var out_process_interface_m_id;

	
	var targetSeq = "";
	var uploadPer = 0;
	
	$(document).ready(function() {
		
		popUpResize();
		
		BindGrid();
		
	});//---documentready
	
	function titleOnClickApp(c_dikeyCode, c_miseqnum, c_diseqnum, c_rideleteopt, c_tifogmgb, c_distatus){
		
		if(c_rideleteopt =='d'){
			fnPuddDiaLog("warning", NeosUtil.getMessage("TX000009232","삭제된 문서는 열수 없습니다"));
			return;
		}
		var obj = {
				diSeqNum  : c_diseqnum,
				miSeqNum  : c_miseqnum,
				diKeyCode : c_dikeyCode,
				tiFormGb  : c_tifogmgb,
				diStatus  : c_distatus,
				socketList : 'Y'
			};
		var param = NeosUtil.makeParam(obj);
		neosPopup("POP_DOCVIEW", param);
	}	
	
	function popUpResize(){
		
		if(!parent.getTopMenu){
			window.resizeTo(1200, 650);
		}
		
	}	
	
	
	function BindGrid(){
		
		
/* 		if (authLevel == 'admin'){
			reqParam.deptSeq = $("#selectedDeptSeq").val();
		} else if (authLevel == 'dept'){
			reqParam.deptSeq = $("#selectLoginDept").val();
		} */
		
		var dataSource = new Pudd.Data.DataSource({
				serverPaging: true
			,	editable : true
			,	pageSize: 10
			,	request : {
				    url : '<c:url value="/purchase/${authLevel}/SelectHopePurchaseList.do" />'
				,	type : 'post'
				,	dataType : "json"
				,   parameterMapping : function( data ) {
					
					data.frDt = $("#txtFromDate").val().replace(/-/g, '');
					data.toDt = $("#txtToDate").val().replace(/-/g, '');
					
					data.docTitle = $("#txtDoctitle").val();
					data.docStatus = $("#selDocStatus").val();
					data.docNo = $("#txtDocNo").val();
					data.txtTrName = $("#txtTrName").val();
					
					// data.itemHopeCompany = $("#itemHopeCompany").val();
					
					//희망기업 선택 데이터
					var hopeCdList = new Array();
					$.each($("input[name='itemHopeCompany']:checked"), (index, item) => {
						hopeCdList.push($(item).val());
					});
			        var hopeCd = hopeCdList.join("|");
			        
			        data.itemHopeCompany = hopeCd;
			        
					
					<c:if test="${authLevel!='admin'}">
					data.deptName = "";
					</c:if>
					<c:if test="${authLevel=='admin'}">
					data.deptName = $("#deptName").val();
					</c:if>	
					
					<c:if test="${authLevel=='dept'}">
					data.deptSeq = $("#selectLoginDept").val();
					</c:if>		
					
					
					<c:if test="${authLevel!='user'}">
					data.empName = $("#txtEmpName").val();
					</c:if>
					<c:if test="${authLevel=='user'}">
					data.empName = "";
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
		,	scrollable : false
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

					fnSetBtn(evntVal.trObj.rowData);
				 
				});				
		}		
		
		,	columns : [
			
			 {  field : "c_tiname",	title : "양식명",	width : 150}
	 	    ,{  field : "docNo",	title : "문서번호",	width : 130
	 	    
	 	    }
			,	{  field : "docTitle"
				,	title : "제목" 
				,   width : 200
				   , content : {
						template : function( rowData ) {
							return "<a href=\"javascript:titleOnClickApp('" + rowData.docSeq + "');\">" + rowData.docTitle +"</a>";
						}
					}				
			    }
		 	   ,{  field : "deptName",	title : "기안부서",	width : 130}			
		 	   ,{  field : "empName",	title : "기안자",	width : 80}
			,   {  field : "",	title : "기안일자",	width : 90
				   , content : {
						template : function( rowData ) {
							return rowData.docDate.substring(0,4) + "-" + rowData.docDate.substring(4,6) + "-" + rowData.docDate.substring(6,8);
						}
					}				
			}
			,   {  field : "tradeAmt",	title : "금액",	width : 100
				   , content : {
					   attributes : { class : "ri" },
						template : function( rowData ) {
							
							if(rowData.docStatus == "007"){
								return 	'<text style="color:red;text-decoration: line-through;">' + (rowData.tradeAmt + "").replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '</text>';
							}else{
								return 	(rowData.tradeAmt + "").replace(/\B(?=(\d{3})+(?!\d))/g, ",");
							}
						}
					}
			
				}
			,   {  field : "tr_name",	title : "업체명",	width : 150}
			,   {  field : "businessNb",	title : "사업자번호",	width : 150}
			/* ,   {  field : "hope_company_info",	title : "희망기업",	width : 150} */
			,   {  field : "",	title : "희망기업",	width : 150
				   , content : {
						template : function( rowData ) {			
							if(rowData.hope_company_info != ""){
		
								var objInfo = [];
								var valArray = [];
								
								valArray = rowData.hope_company_info.split("▦▦");
									for (i=0; valArray.length > i; i++ ){
										var valInfo = [];
 										valInfo[i] =  valArray[i].split("▦"); 
										objInfo.push(valInfo[i][1]); 
									}
	
								return 	objInfo;							

							} else if (rowData.c_hope_company_info != ""){
								
								var objInfo = [];
								var valArray = [];
								
								valArray = rowData.c_hope_company_info.split("▦▦");
									for (i=0; valArray.length > i; i++ ){
										var valInfo = [];
 										valInfo[i] =  valArray[i].split("▦"); 
										objInfo.push(valInfo[i][1]); 
									}
	
								return 	objInfo;
								
							} else if (rowData.p_hope_company_info != "") {
								
								var objInfo = [];
								var valArray = [];
								
								valArray = rowData.p_hope_company_info.split("▦▦");
									for (i=0; valArray.length > i; i++ ){
										var valInfo = [];
 										valInfo[i] =  valArray[i].split("▦"); 
										objInfo.push(valInfo[i][1]); 
									}
	
								return 	objInfo;

							} else {
								return "";
							}
						}
					}
			
				}
			,   {  field : "",	title : "품의유형",	width : 100
				   , content : {
						template : function( rowData ) {
							
							if(rowData.hope_target_type != ""){
								if(rowData.hope_target_type == "01"){
									return 	"용역";
								} else if (rowData.hope_target_type == "04"){
									return 	"구매";	
								} else if (rowData.hope_target_type == "06") {
									return "공사";
								} else {
									return "";
								}
							}else if(rowData.c_target_type != ""){
								if(rowData.c_target_type == "01"){
									return 	"용역";
								} else if (rowData.c_target_type == "04"){
									return 	"구매";	
								} else if (rowData.c_target_type == "06") {
									return "공사";
								} else {
									return "";
								}
							}else if(rowData.out_process_interface_id == "PURCHASE"){
								return 	"구매";	
							}else {
								return "";
							}

						}
					}
			
				}
		]
	});	
		
		
	} 	
	
	function titleOnClickApp(c_dikeyCode, c_miseqnum, c_diseqnum, c_rideleteopt, c_tifogmgb, c_distatus){
		
		if(c_rideleteopt =='d'){
			fnPuddDiaLog("warning", NeosUtil.getMessage("TX000009232","삭제된 문서는 열수 없습니다"));
			return;
		}
		var obj = {
				diSeqNum  : c_diseqnum,
				miSeqNum  : c_miseqnum,
				diKeyCode : c_dikeyCode,
				tiFormGb  : c_tifogmgb,
				diStatus  : c_distatus,
				socketList : 'Y'
			};
		var param = NeosUtil.makeParam(obj);
		neosPopup("POP_DOCVIEW", param);
	}	
	
	
	function fnGetDocStatusLabel(value){
		/** 비영리 전자결재 상태 코드 **/ 
	    if(value == '000'){
	    	return '기안대기';
	    }else if(value == '001'){
	    	return '임시저장';
	    }else if(value == '002'){
	    	return '결재중';
	    }else if(value == '003'){
	    	return '협조중';
	    }else if(value == '004'){
	    	return '결재보류';
	    }else if(value == '005'){
	    	return '문서회수';
	    }else if(value == '006'){
	    	return '다중부서접수중';
	    }else if(value == '007'){
	    	return '기안반려';
	    }else if(value == '008'){
	    	return '결재완료';
	    }else if(value == '009'){
	    	return '발송요구';
	    }else if(value == '101'){
	    	return '감사중';
	    }else if(value == '102'){
	    	return '감사대기';
	    }else if(value == '108'){
	    	return '감사완료';
	    }else if(value == '998'){
	    	return '심사취소';
	    }else if(value == '999'){
	    	return '결재중';
	    }else if(value == 'd'){
	    	return '삭제';
	    }
	  
	}	
	
	
	//결재선보기 
	function openPopApprovalLinePudd(e){
		var param = "diKeyCode="+e.docSeq;
		return '<span class="ico-blank" onClick="neosPopup(\'POP_APPLINE\', \''+param+'\');"></span>';
	} 
	
	function fnDownload(e){
		this.location.href = "${pageContext.request.contextPath}/fileDownloadProc.do?fileId=" + $(e).attr("fileid");
	}	
	
	function fnSetBtn(rowData){
		
		var reqParam = {};
		reqParam.resDocSeq = rowData.resDocSeq;
		reqParam.tradeSeq = rowData.tradeSeq;
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/greenHopeInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : true,
			success : function(result) {
				
				var greenState = "C";
				var greenDelState = "";
				var hopeState = "C";
				var hopeDelState = "";
				
				if(result.resGreenInfo != null){
					greenState = "V";
					greenDelState = "V";
				}
				
				if(result.resHopeInfoList.length > 0){
					
					out_process_interface_id = result.resHopeInfoList[0].out_process_interface_id;
					seq = result.resHopeInfoList[0].out_process_interface_m_id;
					
					if(result.resHopeInfoList[0].hope_company_info != ""){
						hopeState = "V";
						hopeDelState = "V";
					} else if (result.resHopeInfoList[0].c_hope_company_info != ""){
						hopeState = "V";
						hopeDelState = "V";
					} else if (result.resHopeInfoList[0].p_hope_company_info != ""){
						hopeState = "V";
						hopeDelState = "V";
					}
					
				}else{
					hopeState = "";
				}				
				
				var btnList = [];
							
			
				if(hopeState != ""){
					var btnStyle = hopeState == "C" ? "submit" : "cancel";
					var btnName = "희망구매실적연계";					
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnCallBtn('purhopeState', rowData.resDocSeq, rowData.tradeSeq);
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
					btnList.push(btnInfo);			
				}
				
				if(hopeDelState != ""){
					var btnStyle = hopeDelState == "C" ? "submit" : "cancel";
					var btnName = "희망구매실적삭제";					
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnCallBtn('hopeDelState', rowData.resDocSeq, rowData.tradeSeq);
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
					btnList.push(btnInfo);			
				}					
				
				
				//닫기버튼
				var btnCancel = {
					attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
				,	controlAttributes : { class : "cancel", style : "background: #000000;color:#fff;border-color: #484848;" }// control 자체 객체 속성 설정
				,	value : "닫기"
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
						,	content : '<span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #ffffff;">[ ' + rowData.docTitle + ' ]</span></br><span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #c2c2c2;">상세조회 항목을 선택해 주세요</span>'				
					}
				
				,	buttons : btnList	
				
				});
				
				$(".iframe_wrap").on("click", function(e){
					
					if($("#grid1").find(e.target).length == 0){
						puddActionBar_.showActionBar( false );
						targetSeq = "";
						$('.iframe_wrap').attr('onclick','').unbind('click');
					}
					
				});
				
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});			
	}
	
	var puddActionBar_;
	
	var dialogEl;
	
	function fnCallBtn(callId, resDocSeq, tradeSeq){

		if(callId == "greenDelState" || callId == "hopeDelState"){
			confirmAlert(350, 100, 'question', '삭제하시겠습니까?', '삭제', 'fnDeleteProc("'+callId+'", "'+resDocSeq+'", "'+tradeSeq+'")', '취소', '');
		}else {

			// puddDialog 함수
			dialogEl = Pudd.puddDialog({
				width : callId == "greenState" ? 500 : 800
			,	height : callId == "greenState" ? 150 : 200
			 
			,	modal : true			// 기본값 true
			,	draggable : false		// 기본값 true
			,	resize : false			// 기본값 false
			 
			,	header : {
		 		title : callId == "greenState" ? "녹색제품 실적연계" : "희망구매 실적연계"
			,	closeButton : true	// 기본값 true
			,	closeCallback : function( puddDlg ) {
					// close 버튼은 내부에서 showDialog( false ) 실행함 - 즉, 닫기 처리는 내부에서 진행됨
					// 추가적인 작업 내용이 있는 경우 이곳에서 처리
				}
			}
			 
			,	body : {
					iframe : true
				,	url : "${pageContext.request.contextPath}/purchase/layer/"+callId+"SetLayer.do?resDocSeq=" + resDocSeq + "&tradeSeq=" + tradeSeq
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
								iframeTag.contentWindow.saveProc();
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
		
	}
	
	function fnDeleteProc(callId, resDocSeq, tradeSeq){
		
		var reqParam = {};
		reqParam.res_doc_seq = resDocSeq;
		reqParam.trade_seq = tradeSeq;
		reqParam.seq = seq;
		reqParam.out_process_interface_id = out_process_interface_id;
		
		$.ajax({
			type : 'post',
			url : "/CustomPStoPurchase/purchase/" + (callId == "greenDelState" ? "deleteGreenInfo.do" : "deleteHopeInfo.do"),
			datatype : 'json',
			data : reqParam,
			async : true,
			success : function(result) {
				msgSnackbar("success", "삭제완료");
				BindGrid();
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});			
		
		
	}
	
	
    function excelDown() {
        
    	Pudd( "#circularProgressBar" ).puddProgressBar({
     
    		progressType : "circular"
    	,	attributes : { style:"width:150px; height:150px;" }
    	,	strokeColor : "#00bcd4"	// progress 색상
    	,	strokeWidth : "3px"	// progress 두께
    	,	percentText : ""
    	,	percentTextColor : "#fff"
    	,	percentTextSize : "24px"
    	,	modal : true
    	,	extraText : {
    			text : ""
    		,	attributes : { style : "" }
    		}
    	,	progressStartCallback : function( progressBarObj ) {
     
    			excelDownloadProcess( "결의현황.xlsx", progressBarObj );
    		}
    	});
    }	
	
    function excelDownloadProcess( fileName, progressBarObj ) {
        
    	var dataSourceList = new Pudd.Data.DataSource({
     
    		pageSize : 999999
    	,	serverPaging : true
     
    	,	request : {
     
    			url : '<c:url value="/purchase/${authLevel}/SelectHopePurchaseList.do" />'
    		,	type : 'post'
    		,	dataType : "json"
     
    		,	parameterMapping : function( data ) {
    			
					data.frDt = $("#txtFromDate").val().replace(/-/g, '');
					data.toDt = $("#txtToDate").val().replace(/-/g, '');
					
					data.docTitle = $("#txtDoctitle").val();
					data.docStatus = $("#selDocStatus").val();
					data.docNo = $("#txtDocNo").val();
					data.txtTrName = $("#txtTrName").val();
					
					data.itemGreenClass = $("#itemGreenClass").val();
					data.itemGreenCertType = $("#itemGreenCertType").val();
					
					// data.itemHopeCompany = $("#itemHopeCompany").val();		
					
					//희망기업 선택 데이터
					var hopeCdList = new Array();
					$.each($("input[name='itemHopeCompany']:checked"), (index, item) => {
						hopeCdList.push($(item).val());
					});
			        var hopeCd = hopeCdList.join("|");
			        
			        data.itemHopeCompany = hopeCd;
					
					<c:if test="${authLevel!='admin'}">
					data.deptName = "";
					</c:if>
					<c:if test="${authLevel=='admin'}">
					data.deptName = $("#deptName").val();
					</c:if>							
					
					<c:if test="${authLevel!='user'}">
					data.empName = $("#txtEmpName").val();
					</c:if>
					<c:if test="${authLevel=='user'}">
					data.empName = "";
					</c:if>	
					
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
     
    				// json data 저장
    				var dataPage = dataSourceList.dataPage;
    				var dataLen = dataPage.length;
     
    				// excel파일 다운로드 처리
    				generateExcelDownload( dataPage, fileName, function() {// saveCallback
     
    					progressBarObj.updateProgressBar( 100 );// 100%
    					progressBarObj.clearIntervalSet();// progressBar 종료
     
    				}, function( rowIdx ){// stepCallback
     
    					if( dataLen ) {
     
    						var percent = ( ( rowIdx * 100 / dataLen ) / 2 ) + 40;
    						percent = parseInt( percent );
     
    						progressBarObj.updateProgressBar( percent );
    					}
    				});
     
    			} else {// error
     
    				progressBarObj.clearIntervalSet();// progressBar 종료
    			}
    		});
    	}, 10);
    }    
    
    
    function generateExcelDownload( dataPage, fileName, saveCallback, stepCallback ) {
        
    	var excel = new JExcel("맑은 고딕 11 #333333");
    	excel.set( { sheet : 0, value : "Sheet1" } );
     	
		var totalCount = dataPage.length;
		
    	// 엑셀 상단 기간 세팅
    	var periodStyle = excel.addStyle({
    		font: "맑은 고딕 11 #333333 B"
    	})
    	var period = "기안일자: " + $("#txtFromDate").val() + "~" + $("#txtToDate").val() + " / 총 " + totalCount + "건"; 
    	excel.set(0, 0, 0, period, periodStyle);
    	
    	var formatHeader = excel.addStyle ({
    		border: "thin,thin,thin,thin #000000",
    		fill: "#dedede",
    		font: "맑은 고딕 11 #333333 B",// U : underline, B : bold, I : Italic
    		align : "C C",
    	});
		    	
    	var headerRow = 2;
    	var headerCol = 11;
    	
    	for(var i=1; i < headerRow; i++) {
    		for(var j=0; j < headerCol; j++) {
    			excel.set(0, j, i, null, formatHeader);
    		}
    	}
    	excel.set(0, 0, 1, "양식명");
    	excel.set(0, 1, 1, "문서번호");
    	excel.set(0, 2, 1, "제목");
    	excel.set(0, 3, 1, "기안부서");
    	excel.set(0, 4, 1, "기안자");
    	excel.set(0, 5, 1, "기안일자");
    	excel.set(0, 6, 1, "금액");
    	excel.set(0, 7, 1, "업체명");
    	excel.set(0, 8, 1, "사업자번호");
    	excel.set(0, 9, 1, "희망기업");
    	excel.set(0, 10, 1, "품의유형");
    	
    	// sheet번호, column, value(width)
    	for( var i = 0; i < 11; i++ ) {
    		excel.setColumnWidth( 0, i, 20 );
    	}    	
		
    	excel.setColumnWidth( 0, 2, 50 );	
    	excel.setColumnWidth( 0, 8, 50 );
    	excel.setColumnWidth( 0, 9, 50 );
    	
    	/*
    	
    	excel.setColumnWidth( 0, 9, 50 );
    	excel.setColumnWidth( 0, 13, 25 );
    	excel.setColumnWidth( 0, 20, 25 );
    	excel.setColumnWidth( 0, 21, 25 );
    	excel.setColumnWidth( 0, 24, 25 );
    	*/
    	
    	var formatCell = excel.addStyle ({
    		align : "C"
    	});
    	
    	var formatCellR = excel.addStyle ({
    		align : "R"
    	});    	
    	
    	// header row 이후부터 출력
    	for( var i = 0; i < totalCount; i++ ) {
    		var rowNo = i + 2;
    		excel.set( 0, 0, rowNo, dataPage[ i ][ "c_tiname" ], formatCell );
    		excel.set( 0, 1, rowNo, dataPage[ i ][ "docNo" ], formatCell );
    		excel.set( 0, 2, rowNo, dataPage[ i ][ "docTitle" ], formatCell );
    		excel.set( 0, 3, rowNo, dataPage[ i ][ "deptName" ], formatCell );
    		excel.set( 0, 4, rowNo, dataPage[ i ][ "empName" ], formatCell );
    		excel.set( 0, 5, rowNo, dataPage[ i ][ "docDate" ].substring(0,4) + "-" + dataPage[ i ][ "docDate" ].substring(4,6) + "-" + dataPage[ i ][ "docDate" ].substring(6,8), formatCell );
    		excel.set( 0, 6, rowNo, (dataPage[ i ][ "tradeAmt" ] + "").replace(/\B(?=(\d{3})+(?!\d))/g, ","), formatCellR );
    		excel.set( 0, 7, rowNo, dataPage[ i ][ "tr_name" ], formatCell );
    		excel.set( 0, 8, rowNo, dataPage[ i ][ "businessNb" ], formatCell );
    		
    		
    		if (dataPage[ i ][ "hope_company_info" ] != "" || dataPage[ i ][ "c_hope_company_info" ] != "" ||  dataPage[ i ][ "p_target_type" ] != "") {
    		
    		if (dataPage[ i ][ "hope_company_info" ] != "") {
    			
    			var objInfo = [];
				var valArray = [];
    			
				valArray =  dataPage[ i ][ "hope_company_info" ].split("▦▦");
				for (var k=0; valArray.length > k; k++ ){
					var valInfo = [];
						valInfo[k] =  valArray[k].split("▦"); 
					objInfo.push(valInfo[k][1]); 
				}
    			excel.set( 0, 9, rowNo, objInfo , formatCell );
    			
    		} else if (dataPage[ i ][ "c_hope_company_info" ] != "") {
    			
    			var objInfo = [];
				var valArray = [];
    			
				valArray =  dataPage[ i ][ "c_hope_company_info" ].split("▦▦");
				for (var k=0; valArray.length > k; k++ ){
					var valInfo = [];
						valInfo[k] =  valArray[k].split("▦"); 
					objInfo.push(valInfo[k][1]); 
				}
    			excel.set( 0, 9, rowNo, objInfo , formatCell );
    			
    		}  else if (dataPage[ i ][ "p_hope_company_info" ] != "") {
    			
    			var objInfo = [];
				var valArray = [];
    			
				valArray =  dataPage[ i ][ "p_hope_company_info" ].split("▦▦");
				for (var k=0; valArray.length > k; k++ ){
					var valInfo = [];
						valInfo[k] =  valArray[k].split("▦"); 
					objInfo.push(valInfo[k][1]); 
				}
    			excel.set( 0, 9, rowNo, objInfo , formatCell );
    		} else {
    			excel.set( 0, 9, rowNo, "" , formatCell );
    		}
    	}
    		
/*     		if (dataPage[ i ][ "c_target_type" ] != "" || dataPage[ i ][ "out_process_interface_id" ] == "PURCHASE") {
    			if (dataPage[ i ][ "c_target_type" ] == "01"){
    				excel.set( 0, 10, rowNo, "용역", formatCell );
    			} else if (dataPage[ i ][ "c_target_type" ] == "04" || dataPage[ i ][ "out_process_interface_id" ] == "PURCHASE") {
    				excel.set( 0, 10, rowNo, "구매", formatCell );
    			} else if (dataPage[ i ][ "c_target_type" ] == "06"){
    				excel.set( 0, 10, rowNo, "공사", formatCell );
    			} else {
    				excel.set( 0, 10, rowNo, "", formatCell );
    			}
    				
    		} */
    		
    		if (dataPage[ i ][ "hope_target_type" ] != "") {
    			if (dataPage[ i ][ "hope_target_type" ] == "01"){
    				excel.set( 0, 10, rowNo, "용역", formatCell );
    			} else if (dataPage[ i ][ "hope_target_type" ] == "04") {
    				excel.set( 0, 10, rowNo, "구매", formatCell );
    			} else if (dataPage[ i ][ "hope_target_type" ] == "06"){
    				excel.set( 0, 10, rowNo, "공사", formatCell );
    			} else {
    				excel.set( 0, 10, rowNo, "", formatCell );
    			}
    		}else if(dataPage[ i ][ "c_target_type" ] != "") {
    			if (dataPage[ i ][ "c_target_type" ] == "01"){
    				excel.set( 0, 10, rowNo, "용역", formatCell );
    			} else if (dataPage[ i ][ "c_target_type" ] == "04") {
    				excel.set( 0, 10, rowNo, "구매", formatCell );
    			} else if (dataPage[ i ][ "c_target_type" ] == "06"){
    				excel.set( 0, 10, rowNo, "공사", formatCell );
    			} else {
    				excel.set( 0, 10, rowNo, "", formatCell );
    			}
    			
    		}else if(dataPage[ i ][ "out_process_interface_id" ] == "PURCHASE") {
    			excel.set( 0, 10, rowNo, "구매", formatCell );
    		}else {
    			excel.set( 0, 10, rowNo, "", formatCell );
    		}
    		
    		
    	}
     
    	excel.generate( fileName, saveCallback, stepCallback );
    }    
	
    
    
	function selectOrgchart(){
		
 		 var pop = window.open("", "cmmOrgPop", "width=799,height=769,scrollbars=no");
			$("#callback").val("callbackSel");
			frmPop.target = "cmmOrgPop";
			frmPop.method = "post";
			frmPop.action = "/gw/systemx/orgChart.do";
			frmPop.submit();
			pop.focus(); 
	}	
  
	function callbackSel(reqParam){
		
		if(reqParam.returnObj.length > 0){
			$("#selectedDeptSeq").val(reqParam.returnObj[0].deptSeq);
			$("#deptName").val(reqParam.returnObj[0].deptName); 

		}else{
			$("#selectedItems").val("");
			$("#selectedDeptSeq").val("");
			$("#deptName").val("");
		}
		
		BindGrid();

	 }	
    
	/** 희망기업 전체 선택/해제 **/
	function hopeCompanyAll(e){
		if($(e).is(":checked")){
			$("#itemHopeCompanyAll").closest("dd").find("input[type='checkbox']").each((index, item) => {
				Pudd(item).getPuddObject().setChecked(true)
			});
		}else{
			$("#itemHopeCompanyAll").closest("dd").find("input[type='checkbox']").each((index, item) => {
				Pudd(item).getPuddObject().setChecked(false)
			});
		}
		
	};
	
    
</script>




<!-- 상세검색 -->
<div class="top_box">
	<dl>
		<dt class="ar">기안일자</dt>
		<dd>
			<input type="text" id="txtFromDate" value="${fromDate}" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" id="txtToDate" value="${toDate}" class="puddSetup" pudd-type="datepicker"/>
		</dd>
		
		<dt class="ar">제목</dt>
		<dd><input type="text" id="txtDoctitle" pudd-style="width:120px;" class="puddSetup" placeHolder="제목 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
		
 		<dt class="ar">결재상태</dt>
		<dd>
			<select type="select" id="selDocStatus" onchange="BindGrid();" class="puddSetup" pudd-style="width:100%;">
				<option value="" selected="selected">전체</option>
				<option value="'001', '10'">임시저장</option>
				<option value="'002', '003', '005', '006', '20', '30', '40', '50', '60', '70', '80'">진행중</option>
				<option value="'008', '009', '90' ">결재완료</option>
				<option value="'007', '100', '110'">기안반려</option>				
			</select>		
		</dd> 
		
		<dt class="ar">문서번호</dt>
		<dd><input type="text" id="txtDocNo" pudd-style="width:120px;" class="puddSetup" placeHolder="문서번호 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
		
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" onclick="BindGrid();" /></dd>
	</dl>
	
	<dl class="next2">

		<dt class="ar" style="width:40px;">업체명</dt>
		<dd><input type="text" id="txtTrName" pudd-style="width:100px;" class="puddSetup" placeHolder="업체명 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
	
	
		<c:if test="${authLevel=='admin'}">
		<dt class="ar" style="width:70px;">사용부서</dt>
		<dd><input readonly type="text" id="deptName" pudd-style="width:120px;" class="puddSetup"  value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="선택" onclick="selectOrgchart();" /></dd>
		</c:if>
		<c:if test="${authLevel=='dept'}">
		<dt class="ar" style="width:70px;">사용부서</dt>
			<dd>
			<select type="select" id="selectLoginDept" name="selectLoginDept" onchange="BindGrid()"> 
				<option value="">전체</option>
				<option value="${deptSeq}" >${deptName}</option>
			</select>
			<dd>
		</c:if>	
	
	
		<!-- <dt class="ar">사용부서</dt>
		<dd><input type="text" id="txtDeptName" pudd-style="width:70px;" class="puddSetup" placeHolder="부서명 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd> -->
		
		<c:if test="${authLevel!='user'}">
		<dt class="ar">사용자</dt>
		<dd><input type="text" id="txtEmpName" pudd-style="width:100px;" class="puddSetup" placeHolder="사원명 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
		</c:if>
				
		
		<dt class="ar">희망기업여부</dt>
		<dd style="margin-top : 19px;">
<%-- 			<select id="itemHopeCompany" onchange="BindGrid();" style="text-align: center;">
 				<option value="">전체</option>
				<c:forEach var="items" items="${hopeCompany}">
				<option value="${items.CODE}">${items.NAME}</option>
				</c:forEach> 
			</select> --%>
			<!-- <input type="checkbox" onclick="hopeCompanyAll(this);" id="itemHopeCompanyAll" name="itemHopeCompanyAll" value="" class="puddSetup" pudd-label="전체" /> -->	 	
			<c:forEach var="items" items="${hopeCompany}">
			<input type="checkbox"  name="itemHopeCompany" value="${items.CODE}" class="puddSetup" pudd-label="${items.NAME}"/>
			</c:forEach>
		</dd>		
	</dl>	

</div>

<div class="sub_contents_wrap posi_re">
	<div class="btn_div">
		<div class="left_div" style="padding-top: 10px;">
			<span class="fl mr20">※ 희망기업 정보조회</span>
			<div class="fl">
				<span class="pr10"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="15px" height="15px"><a href="#n" onclick="window.open('https://www.coop.go.kr','mgjCode','width=1050, height=670, scrollbars=yes');"> 협동조합</a></span>
				<span class="pr10"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="15px" height="15px"><a href="#n" onclick="window.open('https://www.smpp.go.kr','mgjCode','width=1050, height=670, scrollbars=yes');"> 중소기업중앙회</a></span>
				<span class="pr10"><img src="<c:url value='/customStyle/Images/ico/ico_naraLink.png' />" alt="" width="15px" height="15px"><a href="#n" onclick="window.open('https://www.socialenterprise.or.kr','mgjCode','width=1050, height=670, scrollbars=yes');"> 사회적기업진흥원</a></span>
			</div>
		</div>
		<div class="right_div">
			<div id="" class="controll_btn p0">
				<input type="button" onclick="excelDown();" class="puddSetup" value="엑셀다운로드" />
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
	<input type="hidden" id="selectedDeptSeq" value="" />
	<form id="frmPop" name="frmPop"> 
		<input type="hidden" name="selectedItems" id="selectedItems" value="" />
		<input type="hidden" name="popUrlStr" id="txt_popup_url" value="/gw/systemx/orgChart.do" />
		<input type="hidden" name="selectMode" id="selectMode" value="d" />
		<input type="hidden" name="selectItem" value="s" />
		<input type="hidden" name="callback" id="callback" value="" />
		<input type="hidden" name="compSeq" value="" />
		<input type="hidden" name="callbackUrl" value="/gw/html/common/callback/cmmOrgPopCallback.jsp"/>
		<input type="hidden" name="empUniqYn" value="N" />
		<input type="hidden" name="empUniqGroup" value="ALL" />
	</form>
	<div id="jugglingProgressBar"></div>
	<div id="loadingProgressBar"></div>
	<div id="circularProgressBar"></div>	
</div><!-- //sub_contents_wrap -->