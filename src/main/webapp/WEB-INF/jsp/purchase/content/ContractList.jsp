<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

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


	$(document).ready(function() {
		
		BindGrid();

	});//---documentready
	
	function BindGrid(){
		
		var dataSource = new Pudd.Data.DataSource({
				serverPaging: true
			,	pageSize: 10
			,	request : {
				    url : '<c:url value="/purchase/${authLevel}/SelectContractList.do" />'
				,	type : 'post'
				,	dataType : "json"
				,   parameterMapping : function( data ) {
					
					data.fromDate = $("#searchFromDate").val(); ;
					data.toDate = $("#searchToDate").val();
					
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
			}
		
		,	noDataMessage : {
			message : "대금지급 요청건이 존재하지 않습니다."
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
							var html = '<input type="text" pudd-style="width:100%;" class="puddSetup ac" value="' + rowData.seq + '" />';
							return html;
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
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
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
						field : "partner_name"
					,	title : "계약대상자"
					,	width : 100
				}					
			,	{
						field : "partner_bizno"
					,	title : "사업자등록번호"
					,	width : 100
				}
			,	{
						field : "partner_owner"
					,	title : "대표자명"
					,	width : 100							
				}
			,	{
						field : "data13"
					,	title : "희망기업여부"
					,	width : 100
				}						
				]
			}
			,	{
				title : "발주정보"
			,	columns : [
				{
						field : "contract_type_name"
					,	title : "입찰/수의"
					,	width : 100
				}					
			,	{
						field : "data15"
					,	title : "발주금액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "data16"
					,	title : "경쟁방식"
					,	width : 100							
				}
			,	{
						field : "data17"
					,	title : "낙찰자결정방법"
					,	width : 100
				}	
			,	{
						field : "data18"
					,	title : "담당자"
					,	width : 100
			}
			,	{
						field : "data19"
					,	title : "담당부서"
					,	width : 120
			}					
				]
			}
			,	{
				title : "입찰정보"
			,	columns : [
				{
						field : "data20"
					,	title : "사전규격공개기간"
					,	width : 290
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~ <input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}
				}					
			,	{
						field : "data21"
					,	title : "본 공고기간"
					,	width : 290
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~ <input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}
				}
			,	{
						field : "data22"
					,	title : "재 공고기간"
					,	width : 290			
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~ <input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}				
				}
			,	{
						field : "data23"
					,	title : "공고기간 확정"
					,	width : 100
				}	
			,	{
						field : "data24"
					,	title : "투찰자수"
					,	width : 100
					,	content : {		
						template : function() {
							var html = '<input type="text" pudd-style="width:50px;" class="puddSetup ar" value="" /> 건';
							return html;
						}
					}
			}
			,	{
						field : "data25"
					,	title : "제안서평가일"
					,	width : 120
			}					
				]
			}
			,	{
				title : "변경계약정보"
			,	columns : [
				{
						field : "data26"
					,	title : "변경계약일"
					,	width : 150
					,	content : {		
						template : function() {
							var html = '<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>';
							return html;
						}
					}
				}					
			,	{
						field : "data27"
					,	title : "과업내용변경"
					,	width : 100
				}
			,	{
						field : "data28"
					,	title : "경계약기간변경"
					,	width : 100							
				}	
			,	{
						field : "data29"
					,	title : "계약금액변경"
					,	width : 100							
				}	
			,	{
						field : "data30"
					,	title : "기타변경"
					,	width : 100							
				}			
				]
			}
			,	{
				title : "대금지급정보"
			,	columns : [
				{
						field : "data31"
					,	title : "선금액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : "data32"
					,	title : "기성금합산"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "data33"
					,	title : "준공금"
					,	width : 100	
					,	content : {
							attributes : { class : "ri" }
					}						
				}	
			,	{
						field : "data34"
					,	title : "잔액"
					,	width : 100
					,	content : {
							attributes : { class : "ri" }
					}
				}					
			,	{
						field : "data35"
					,	title : "준공율"
					,	width : 100
				}			
				]
			}
			,	{
				title : "자료"
			,	columns : [
				{
						field : "data36"
					,	title : "계약서"
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function() {
							var html = '<div><span class="text_ho"><em class="fl ellipsis pl5 text_ho" style="max-width:200px;" ><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" alt="" style="vertical-align: middle;" class="mtImg"/> STOB221014STOB221014STOB221014-008</em>.zip</span> <input type="button" class="puddSetup ml5" value="추가" /></div>';
							return html;
						}
					}
				}					
			,	{
						field : "data37"
					,	title : "계약제출서류"
					,	width : 100
					,	width : 300
					,	content : {
						attributes : { class : "le" },
						template : function() {
							var html = '<div><span class="text_ho"><em class="fl ellipsis pl5 text_ho" style="max-width:200px;" ><img src="${pageContext.request.contextPath}/customStyle/Images/ico/ico_clip02.png" alt="" style="vertical-align: middle;" class="mtImg"/> STOB221014STOB221014STOB221014-008</em>.zip</span> <input type="button" class="puddSetup ml5" value="추가" /></div>';
							return html;
						}
					}
				}			
				]
			}
		]
	});	
		
		
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
			<input type="text" id="searchFromDate" value="" class="puddSetup" pudd-type="datepicker"/> ~
			<input type="text" id="searchToDate" value="" class="puddSetup" pudd-type="datepicker"/>
		</dd>
		<dt class="ar" style="width:40px;">계약명</dt>
		<dd><input type="text" pudd-style="width:120px;" class="puddSetup" placeHolder="공고명 입력" value="" /></dd>
		<dt class="ar" style="width:40px;">부서명</dt>
		<dd><input type="text" pudd-style="width:120px;" class="puddSetup" placeHolder="부서명 입력" value="" /></dd>
		<dt class="ar" style="width:40px;">사원명</dt>
		<dd><input type="text" pudd-style="width:90px;" class="puddSetup" placeHolder="사원명 입력" value="" /></dd>
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
				<input type="button" onclick="fnCallBtn('ing');" class="puddSetup" value="저장" />
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
	
</div><!-- //sub_contents_wrap -->