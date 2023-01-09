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
		
		var dataSource = new Pudd.Data.DataSource({
				serverPaging: true
			,	editable : true
			,	pageSize: 10
			,	request : {
				    url : '<c:url value="/purchase/${authLevel}/SelectResolutionList.do" />'
				,	type : 'post'
				,	dataType : "json"
				,   parameterMapping : function( data ) {
					
					data.searchFromDate = $("#searchFromDate").val(); ;
					data.searchToDate = $("#searchToDate").val();
					
					data.title = $("#title").val();
					data.docSts = $("#docSts").val();
					data.docNo = $("#docNo").val();
					data.trName = $("#trName").val();
					
					<c:if test="${authLevel!='admin'}">
					data.writeDeptName = "";
					</c:if>
					<c:if test="${authLevel=='admin'}">
					data.writeDeptName = $("#writeDeptName").val();
					</c:if>							
					
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
	 	    {  field : "C_RIDOCFULLNUM",	title : "문서번호",	width : 130}
			,	{  field : "C_DITITLE"
				,	title : "결의제목" 
				,   width : 200
				,	content : {	
					   template : TextOverFlowApp
					,  attributes : { style : "text-align:left;padding-left:5px;" }
				    }				
			    }
			,   {  field : "C_DIWRITEDAY",	title : "기안일자",	width : 90}
			,   {  field : "P_RESAMT",	title : "결의금액",	width : 130
				   , content : {
						template : function( rowData ) {
							
							if(rowData.C_DISTATUS == "007"){
								return 	'<text style="color:red;text-decoration: line-through;">' + rowData.P_RESAMT + '</text>';
							}else{
								return 	rowData.P_RESAMT;
							}
						}
					}
			
				}
			,   {  field : "",	title : "업체명",	width : 130}
			,   {  field : "DOCSTSNAME",	title : "결재상태",	width : 120}
			
			,   {  field : "",	title : "전송여부",	width : 120}
			,   {  field : "",	title : "전송자",	width : 120}
			
			,	{  field : "C_DIKEYCODE"
				,	title : "결재선보기"
				,	width : 80
				,	content : {	
					   template : openPopApprovalLinePudd
				    }				
			    }
		
		]
	});	
		
		
	} 	
	
	
	//결재선보기 
	function openPopApprovalLinePudd(e){
		var diKeyCode = e.C_DIKEYCODE ;
		var param = "diKeyCode="+diKeyCode;

		return '<span class="ico-blank" onClick="neosPopup(\'POP_APPLINE\', \''+param+'\');"></span>';
	} 
	
	function TextOverFlowApp(e){
		
		var C_RIDELETEOPT = "";
		if(!ncCom_Empty(e.C_RIDELETEOPT)){
			C_RIDELETEOPT = e.C_RIDELETEOPT;
		}
		
		var c_dititle = e.C_DITITLE.replace(/</gi, "&lt;").replace(/>/gi, "&gt;"); 
			
		var title = "<span onClick='titleOnClickApp(\"" + e.C_DIKEYCODE +"\", \"" + e.C_MISEQNUM +"\", \"" + e.C_DISEQNUM +"\" , \"" + e.C_RIDELETEOPT +"\", \"" + e.C_TIFORMGB +"\", \"" + e.C_DISTATUS +"\")' style='cursor:pointer; ' >";
		if(e.AUDITCOUNT > 0){
			  title += "<img src='/ea/Images/ico/ico_gamsa.png' title='"+ NeosUtil.getMessage("TX000020865","감사문서") +"'/> ";
		}
		if(e.C_DISECRETGRADE == "009"){
			  title += "<img src='"+_g_contextPath_ +"/Images/ico/ico_security.png' title='"+ NeosUtil.getMessage("TX000008484","보안문서") +"'/> ";
		}
		if(e.C_DIDOCGRADE == "002"){
			  title += "<img src='"+_g_contextPath_ +"/Images/ico/ico_emergency.png' title='"+ NeosUtil.getMessage("TX000009230","긴급문서") +"'/> ";
		}
		
		if(e.SUBAPPROV == "Y"){
			  title += "<img src='"+_g_contextPath_ +"/Images/ico/ico_proxy.png' title='"+ NeosUtil.getMessage("TX000002949","대결") +"'/> ";
		}
		if(e.DOCCOUNT > 1){
			  title += "<img src='"+_g_contextPath_ +"/Images/ico/ico_draft.png' title='"+ NeosUtil.getMessage("TX000021117","일괄기안") +"'/> ";
		}
		
	    if(C_RIDELETEOPT == "d"){
	    	title += "<a href=\"javascript:;\" class=\"text_red\">" + c_dititle +"</a>";
	    }else{
	    	title += "<a href=\"javascript:;\">" + c_dititle +"</a>";
	    }
		
		title +="</span>";
		
		return  title ;
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
			url : '<c:url value="/purchase/PurchaseInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : true,
			success : function(result) {
				
				console.log("seq > " + result.resultData.seq);
				console.log("doc_sts > " + result.resultData.doc_sts);
				console.log("approkey_purchase > " + result.resultData.approkey_purchase);
				console.log("approkey_check > " + result.resultData.approkey_check);
				
				var purchaseState = "";
				var checkState = "";		
				var paymentState = "";
			
				//입찰
				purchaseState = "V";
				
				if(result.resultData.approkey_check != ""){
					
					checkState = "V";		
					
					if(result.resultData.doc_sts == "90"){
						
						paymentState = "C";
						
					}
					
				}else if(result.resultData.approkey_purchase != ""){
					
					if(result.resultData.doc_sts == "90"){
						checkState = "C";	
					}
					
				}else{
					purchaseState = "C";
				}
					
				
				var btnList = [];
				
				if(purchaseState != ""){
					
					var btnStyle = purchaseState == "C" ? "submit" : "cancel";
					var btnName = purchaseState == "C" ? "구매품의신청" : "구매품의조회";					
				
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnCallBtn('purchaseView', result.resultData.seq);
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
						
					btnList.push(btnInfo);			
					
				}		
				
				if(checkState != ""){
					
					var btnStyle = checkState == "C" ? "submit" : "cancel";
					var btnName = checkState == "C" ? "물품검수" : "물품검수";
				
					var btnInfo = {
							attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
						,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
						,	value : btnName
						,	clickCallback : function( puddActionBar ) {
								fnPurchaseStatePop('btnCheck');
								
								$('.iframe_wrap').attr('onclick','').unbind('click');
								puddActionBar.showActionBar( false );
								targetSeq = "";
							}
					};
						
					btnList.push(btnInfo);			
					
				}
				
				if(paymentState != ""){
					
					var btnStyle = "submit";
					var btnName = "대금지급";
					
					var btnInfo = {
						attributes : { style : "margin-top:4px;margin-left:10px;width:auto;" }// control 부모 객체 속성 설정
					,	controlAttributes : { id : "", class : btnStyle }// control 자체 객체 속성 설정
					,	value : btnName
					,	clickCallback : function( puddActionBar ) {
							fnPurchaseStatePop('btnPayment');
							
							$('.iframe_wrap').attr('onclick','').unbind('click');
							puddActionBar.showActionBar( false );
							targetSeq = "";
						}
					}
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
						,	content : '<span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #ffffff;">[ ' + (result.resultData.c_title ? result.resultData.c_title : result.resultData.title) + ' ]</span></br><span style="display: inline-block;padding: 10px 0 0 20px;font-size: 14px;color: #c2c2c2;">상세조회 항목을 선택해 주세요</span>'				
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
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});			
	}
	
	var puddActionBar_;
	
	function fnCallBtn(callId, seq, sub_seq){
		
		if(callId == "newPurchase"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/PurchaseCreatePop.do",  "PurchaseCreatePop", 1200, 800, 1, 1) ;
			
		}else if(callId == "purchaseView"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/PurchaseCreatePop.do?seq=" + seq,  "purchaseViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnCheck"){
			
			openWindow2("${pageContext.request.contextPath}/purchase/pop/PurchaseCheckPop.do?seq=" + (seq != null ? seq : targetSeq),  "PurchaseCheckViewPop", 1200, 800, 1, 1) ;
			
		}else if(callId == "btnPayment"){
			
			if('${resFormSeq}' != ''){
				openWindow2("${pageContext.request.contextPath}/purchase/pop/PurchasePaymentPop.do?formSeq=${resFormSeq}&seq=" + (seq != null ? seq : targetSeq),  "PurchasePaymentViewPop", 1350, 800, 1, 1) ;	
			}else{
				msgSnackbar("warning", "대금지급 지출결의 양식코드 미설정");
			}
			
		}else {
			msgSnackbar("warning", "개발중입니다.");
		}
		
	}
	
	function fnPurchaseStatePop(btnType, seq){
		
		var reqParam = {};
		
		if(seq){
			reqParam.seq = seq;
		}else{
			reqParam.seq = targetSeq;	
		}
		
		var resultState = false;
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/PurchaseInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : false,
			success : function(result) {
				
				console.log("seq > " + result.resultData.seq);
				console.log("doc_sts > " + result.resultData.doc_sts);
				console.log("approkey_purchase > " + result.resultData.approkey_purchase);
				console.log("approkey_check > " + result.resultData.approkey_check);
				
				if(result.resultData.approkey_check != ""){
					
					if(btnType == "btnCheck" || (btnType == "btnPayment" && result.resultData.doc_sts == "90")){
						resultState = true;
					}					
					
				}else if(result.resultData.approkey_purchase != ""){
					
					if(btnType == "btnCheck" && result.resultData.doc_sts == "90"){
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
     
    			excelDownloadProcess( "구매현황.xlsx", progressBarObj );
    		}
    	});
    }	
	
    function excelDownloadProcess( fileName, progressBarObj ) {
        
    	var dataSourceList = new Pudd.Data.DataSource({
     
    		pageSize : 999999
    	,	serverPaging : true
     
    	,	request : {
     
    			url : '<c:url value="/purchase/${authLevel}/SelectPurchaseList.do" />'
    		,	type : 'post'
    		,	dataType : "json"
     
    		,	parameterMapping : function( data ) {
    			
					data.searchFromDate = $("#searchFromDate").val(); ;
					data.searchToDate = $("#searchToDate").val();
					data.itemName = $("#itemName").val();
					data.itemUseLocation = $("#itemUseLocation").val();
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
    	var period = "취득일자: " + $("#searchFromDate").val() + "~" + $("#searchToDate").val() + " / 총 " + totalCount + "건"; 
    	excel.set(0, 0, 0, period, periodStyle);
    	
    	var formatHeader = excel.addStyle ({
    		border: "thin,thin,thin,thin #000000",
    		fill: "#dedede",
    		font: "맑은 고딕 11 #333333 B",// U : underline, B : bold, I : Italic
    		align : "C C",
    	});
		    	
    	var headerRow = 2;
    	var headerCol = 25;
    	
    	for(var i=1; i < headerRow; i++) {
    		for(var j=0; j < headerCol; j++) {
    			excel.set(0, j, i, null, formatHeader);
    		}
    	}
    	
    	excel.set(0, 0, 1, "연번");
    	excel.set(0, 1, 1, "구매번호");
    	excel.set(0, 2, 1, "물품식별번호");
    	excel.set(0, 3, 1, "물품분류번호");
    	excel.set(0, 4, 1, "품명");    	
    	excel.set(0, 5, 1, "취득단가");
    	excel.set(0, 6, 1, "취득수량");
    	excel.set(0, 7, 1, "금액");
    	excel.set(0, 8, 1, "취득수수료");
    	excel.set(0, 9, 1, "단위코드");
    	excel.set(0, 10, 1, "운영부서");
    	excel.set(0, 11, 1, "운영부서코드");
    	excel.set(0, 12, 1, "물품대장코드");
    	excel.set(0, 13, 1, "물품담당자");
    	excel.set(0, 14, 1, "물품사용위치");
    	excel.set(0, 15, 1, "국내외구분");
    	excel.set(0, 16, 1, "국가코드");    	
    	excel.set(0, 17, 1, "취득사유코드");    	
    	excel.set(0, 18, 1, "품의명");   
    	excel.set(0, 19, 1, "품의결재상태");
    	excel.set(0, 20, 1, "물품검수여부");
    	excel.set(0, 21, 1, "대금지급회차");
    	excel.set(0, 22, 1, "대금지급금액");    	
    	excel.set(0, 23, 1, "대금지급완료여부");    	
    	excel.set(0, 24, 1, "붙임문서");     
    	
    	// sheet번호, column, value(width)
    	for( var i = 0; i < 25; i++ ) {
    		excel.setColumnWidth( 0, i, 20 );
    	}    	
		
    	/*
    	excel.setColumnWidth( 0, 5, 50 );
    	excel.setColumnWidth( 0, 9, 50 );
    	excel.setColumnWidth( 0, 13, 25 );
    	excel.setColumnWidth( 0, 20, 25 );
    	excel.setColumnWidth( 0, 21, 25 );
    	excel.setColumnWidth( 0, 24, 25 );
    	*/
    	
    	var formatCell = excel.addStyle ({
    		align : "C"
    	});
    	
    	// header row 이후부터 출력
    	for( var i = 0; i < totalCount; i++ ) {
    		var rowNo = i + 2;
    		excel.set( 0, 0, rowNo, dataPage[ i ][ "seq" ], formatCell );
    		excel.set( 0, 1, rowNo, dataPage[ i ][ "manage_no" ], formatCell );
    		excel.set( 0, 2, rowNo, dataPage[ i ][ "item_idn_no" ], formatCell );
    		excel.set( 0, 3, rowNo, dataPage[ i ][ "item_div_no" ], formatCell );
    		excel.set( 0, 4, rowNo, dataPage[ i ][ "item_name" ], formatCell );
    		excel.set( 0, 5, rowNo, dataPage[ i ][ "item_amt" ], formatCell );
    		excel.set( 0, 6, rowNo, dataPage[ i ][ "item_cnt" ], formatCell );
    		excel.set( 0, 7, rowNo, dataPage[ i ][ "item_total_amt" ], formatCell );
    		excel.set( 0, 8, rowNo, dataPage[ i ][ "item_fee_amt" ], formatCell );
    		excel.set( 0, 9, rowNo, dataPage[ i ][ "item_unit" ], formatCell );
    		excel.set( 0, 10, rowNo, dataPage[ i ][ "write_dept_name" ], formatCell );
    		excel.set( 0, 11, rowNo, dataPage[ i ][ "operation_dept_code" ], formatCell );
    		excel.set( 0, 12, rowNo, dataPage[ i ][ "item_inventory_cd" ], formatCell );
    		excel.set( 0, 13, rowNo, dataPage[ i ][ "write_emp_name" ], formatCell );
    		excel.set( 0, 14, rowNo, dataPage[ i ][ "item_use_location" ], formatCell );
    		excel.set( 0, 15, rowNo, dataPage[ i ][ "item_foreign_type" ], formatCell );
    		excel.set( 0, 16, rowNo, dataPage[ i ][ "item_contry" ], formatCell );
    		excel.set( 0, 17, rowNo, dataPage[ i ][ "item_acquisition_reason" ], formatCell );
    		excel.set( 0, 18, rowNo, dataPage[ i ][ "title" ], formatCell );
    		excel.set( 0, 19, rowNo, dataPage[ i ][ "DOCSTSNAME" ], formatCell );
    		
			if(dataPage[ i ][ "approkey_check" ] != ""){
				
				if(dataPage[ i ][ "doc_sts" ] == "90"){
					excel.set( 0, 20, rowNo, "검수완료", formatCell );
				}else if(rdataPage[ i ][ "doc_sts" ] == "20"){
					excel.set( 0, 20, rowNo, "검수진행중", formatCell );
				}
					
			}    		
    		
    		excel.set( 0, 21, rowNo, dataPage[ i ][ "pay_cnt" ], formatCell );
    		
			if(dataPage[ i ][ "total_pay_amt" ] != "0"){
				excel.set( 0, 22, rowNo, dataPage[ i ][ "total_pay_amt" ] + " 원", formatCell );				
			}    		
    		
			
			if(!(parseInt(dataPage[ i ][ "purchase_amt" ].replace(/,/g, '')) > parseInt(dataPage[ i ][ "total_pay_amt" ].replace(/,/g, '')))){
				excel.set( 0, 23, rowNo, "완료", formatCell );
			}		
			
			if(dataPage[ i ][ "purchase_attach_info" ] != ""){
				excel.set( 0, 24, rowNo, "등록", formatCell );
			}				
    		
    	}
     
    	excel.generate( fileName, saveCallback, stepCallback );
    }    
	
</script>




<!-- 상세검색 -->
<div class="top_box">

	<dl>
		<dt class="ar">기안일자</dt>
		<dd>
			<input type="text" id="searchFromDate" value="${fromDate}" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" id="searchToDate" value="${toDate}" class="puddSetup" pudd-type="datepicker"/>
		</dd>
		
		<dt class="ar" style="width:40px;">제목</dt>
		<dd><input type="text" id=title" pudd-style="width:120px;" class="puddSetup" placeHolder="제목 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
		
		<dt class="ar" style="width:60px;">결재상태</dt>
		<dd>
			<select type="select" id=docSts" onchange="BindGrid();" class="puddSetup" pudd-style="width:100%;">
				<option value="">전체</option>
				<c:forEach var="items" items="${docStsCode}">
					<option value="${items.CODE}">${items.NAME}</option>
				</c:forEach>							
			</select>		
		</dd>
		
		<dt class="ar" style="width:60px;">문서번호</dt>
		<dd><input type="text" id=docNo" pudd-style="width:120px;" class="puddSetup" placeHolder="문서번호 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>

		
		<dd><input type="button" class="puddSetup submit" id="searchButton" value="검색" onclick="BindGrid();" /></dd>
	</dl>
	
	<dl class="next2">
	
		<dt class="ar" style="width:40px;">업체명</dt>
		<dd><input type="text" id="trName" pudd-style="width:130px;" class="puddSetup" placeHolder="업체명 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
	
		<dt class="ar" style="width:60px;">부서명</dt>
		<dd><input type="text" id="writeDeptName" pudd-style="width:120px;" class="puddSetup" placeHolder="부서명 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
		
		<c:if test="${authLevel!='user'}">
		<dt class="ar" style="width:60px;">사원명</dt>
		<dd><input type="text" id="writeEmpName" pudd-style="width:90px;" class="puddSetup" placeHolder="사원명 입력" value="" onKeyDown="javascript:if (event.keyCode == 13) { BindGrid(); }" /></dd>
		</c:if>
	
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
	<div id="jugglingProgressBar"></div>
	<div id="loadingProgressBar"></div>
	<div id="circularProgressBar"></div>	
</div><!-- //sub_contents_wrap -->