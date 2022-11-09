<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<!DOCTYPE html PUBLIC "-//W3C//Dth XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dth/xhtml1-transitional.dth">

<!--  js 파일 모음 -->
<script type="text/javascript"
	src='<c:url value="/js/jquery-1.9.1.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/Scripts/common.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/kendoui/jquery.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/jquery-ui-1.10.4.js"></c:url>'></script>
	
<script type="text/javascript"
	src='<c:url value="/js/kendoui/kendo.all.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/ez/jquery.maskedinput.js"></c:url>'></script>

<!-- UC TABLE JS -->
<script type="text/javascript" src='<c:url value="/js/ez/jquery.ucdevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/jquery.uckeydevtable.1.0.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/ezVariable.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/ezCodePop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/ezDisplay.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ez/ezSave.js"></c:url>'></script>	
<!-- jquery Mask  -->
<script type="text/javascript" src='<c:url value="/js/ez/jquery.mask.js"></c:url>'></script>


<!--  css 파일 모음 -->
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.common.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.dataviz.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.mobile.all.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/kendoui/kendo.silver.min.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/common.css"></c:url>'>
<link rel="stylesheet" type="text/css"
	href='<c:url value="/css/reKendo.css"></c:url>'>

<script type="text/javascript">
	var approKey = '${approKey}' || 0;
	var docSeq = '${doc_seq}' || 0;
	var masterSeq = '${master_seq}' || 0;
	var formSeq = '${form_seq}' || 0;
	/* 거래처 구분 값 */
	
    var eaInfo = {};
	var topTableRowCount = 0;
	var midTableRowCount = -1;
	var botTableRowCount = -1;
	
	/* SSL 적용관련 */
	if (!window.location.origin) {
    		window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
  	}
    var origin = document.location.origin;
	
	$(document).ready(function() {							      
			/* 거래일 */
			$("#date_time").kendoDatePicker({
		    	format: "yyyy-MM-dd"
		    });
			
			/* 테이블 생성 */
			$.devTable.create(RESOL_JSON, 'resolveContent', 'Y', '2', '161', 'N','Y','Y');
			$.devTable.create(DETAIL_JSON, 'detailContent', 'N', '1', '45', 'Y','N','Y');
			$.devTable.create(ITEMDETAIL_JSON, 'itemDetailContent', 'N', '2', '161', 'Y','N','Y');
			
			/* 그룹지정 */
			groupClassId = 'resolveContent';
			txtHelpMsgElementId = 'txtHelpMsg';
			fnSetTableRelation();
			fnRegUCTableKeyEvent();
			/* 추가버튼 */
			$("#btnAddResolRow").click(
					function() {
						topTableRowCount = Number(topTableRowCount) + 1;
						$.devTable.addrow('resolveContent', RESOL_JSON, '2', 'resolveContent_TRDATA',topTableRowCount,'Y');
						fnRegUCTableKeyEvent();
			});
					
			/* 삭제버튼 */
			$("#btnDeleteResolRow").click(function(){
				$("input[name=resolveContentChk]:checked").each(function() {
					var chkTR = $(this).parent().parent();
						console.log(chkTR.index());
						var gClass = chkTR.attr('class');
						
						
						$.each($("#itemDetailContent_TRDATA_FIX").find('tr'), function(){
							if($(this).attr('class').indexOf(gClass) != -1){
								$(this).remove();											
							}
						});
						
						$.each($("#itemDetailContent_TRDATA").find('tr'), function(){
							if($(this).attr('class').indexOf(gClass) != -1){
	
								$(this).remove();							
							}
						});
						
						$.each($("#detailContent_TRDATA").find('tr'), function(){
							if($(this).attr('class').indexOf(gClass) != -1){
								$(this).remove();
								return false;
							}
						});
						
						
						$.each($("#resolveContent_TRDATA_FIX").find('tr'), function(){
							if($(this).attr('class').indexOf(gClass) != -1){
								$(this).remove();
								return false;
							}
						});
						
						$.each($("#resolveContent_TRDATA").find('tr'), function(){
							if($(this).attr('class').indexOf(gClass) != -1){
								$(this).remove();
								return false;
							}
						});
					
					//저장 데이터 삭제
					var lv1DelIdx;
					$.each(ezDataLevel1List,function(index,item){
						if(item.key.indexOf(gClass) != -1){
							lv1DelIdx = index;
							return false;
						}
					});
					
					var lv2DelIdx;
					$.each(ezDataLevel1List,function(index,item){
						if(item.key.indexOf(gClass) != -1){
							lv2DelIdx = index;
							return false;
						}
					});
					
					
					var ezParamIdx;
					$.each(ezparamList,function(index,item){
						if(item.key.indexOf(gClass) != -1){
							ezParamIdx = index;
							return false;
						}
					});
					ezDataLevel1List.splice(lv1DelIdx,1);
					ezDataLevel2List.splice(lv2DelIdx,1);
					ezparamList.splice(ezParamIdx,1);
				});
			});
			
			/* 삭제버튼 */			
			$("#btnDeleteItemDetail").click(function(){
				$("input[name=itemDetailContentChk]:checked").each(function() {
					var chkTR = $(this).parent().parent();								
					$("#itemDetailContent_TRDATA").find('tr').eq(chkTR.index()).remove();
					$("#itemDetailContent_TRDATA_FIX").find('tr').eq(chkTR.index()).remove();										
				});
			});
			/* 상신버튼 */
			$("#btnAppProcess").click(function(){
				fnMakeGwVariable();
				fnMainEzbaroSaveProcess();
			});

			/* 마스크 넣기 */
			$('.maskDate').mask('0000/Z0/R0',{
					placeholder : "____/__/__",
					clearIfNotMatch: true,
					translation:{
						'Z':{
							pattern : /[0-1]/, optional : true
						},
						'R':{
							pattern : /[0-3]/, optional : true
						}
					}
			});
			
			$('.maskDatetime').mask('0000/Z0/R0 A0:B0',{
				placeholder : "____/__/__ __:__",
				clearIfNotMatch: true,
				translation:{
					'Z':{
						pattern : /[0-1]/, optional : true
					},
					'R':{
						pattern : /[0-3]/, optional : true
					},
					'A':{
						pattern : /[0-2]/, optional : true
					},
					'B':{
						pattern : /[0-5]/, optional : true
					}
				}			
			});
			
			$('.maskTime').mask('A0:B0',{
				placeholder : "__:__",
				clearIfNotMatch: true,
				translation:{
					'A':{
						pattern : /[0-2]/, optional : true
					},
					'B':{
						pattern : /[0-5]/, optional : true
					}
				}				
			});
			
			$('.maskMoney').mask('0,000,000,000,000,000', { reverse: true });
			$('.maskNumber').mask('0#');

			
			//GOLOBAL KEYEVENT BIND (ESC)
			$(window).on('keydown', function(e) {
				switch(e.keyCode)
				{
					/* ESC EVENT */
					case  27:
						fnPopClose();
						fnTaxPopClose();
						$('input.focus').click().focus();
					break;
				}
			});
			
			/* 결의내용 저장 */
			$("#resolNote").change(function(){
				fnSetResolNoteTxt();
			});
			
			/* 전자결재 정보 저장 */
			fnGetEAInfo();
			
			/* 결의내역 수정 */
			if(masterSeq != 0 && docSeq != 0){
				var params = {};
				params.formSeq = formSeq;
				params.approKey = approKey;
				params.docSeq = docSeq;
				params.masterSeq = masterSeq;
				/*  이지바로 데이터 불러오기 */
				fnLoadPreEzData(params);
				
			}else{ /* 新이지바로 작성 */
				/* 이지바로 로딩.....♡ */
				fnSetLoading();	
			}
		});
	
		function fnSetResolNoteTxt(){
			var inputText = $("#resolNote").val();
			/* 글이 존재한다면 */
			if(inputText.length > 0){
				var hdnResoData = $("#hdnResolNoteInfo").val();
				var dataList = [];
				
				if(hdnResoData != ""){
					dataList= JSON.parse(hdnResoData);
				}	
				/* 초기화 */
				if(dataList.length == 0 ){
					dataList = [];
				}
				
				var incount = false;
				$.each(dataList, function(index,item){
					if(item.key == groupClass){
						item.value = inputText;
						incount =true;
						return false;
					}
				});
				
				/* 존재하지 않는다면 저장한다. */
				if(incount == false){
					var newData = {};
					newData.key = groupClass;
					newData.value = inputText;
					dataList.push(newData);
				}
				
				$("#hdnResolNoteInfo").val( JSON.stringify(dataList) );							
			}
		}
	
		/* 전자결재 양식정보 저장 */
		function fnGetEAInfo(){
			eaInfo.formSeq = '${form_seq}' || 0;
			if('${process_id}' == 'EziCUBE'){
				eaInfo.erpType = 'ERPiCUBE';
			}else if('${process_id}' == 'EzERPiU'){
				eaInfo.erpType = 'ERPiU';
			}
			eaInfo.eaType = '${ea_type}'|| '';
			eaInfo.processId = '${process_id}'|| 0;
		}
				
/* =============================== UC DEV 테이블 연관 스크립트 =============================== */		
		/* 테이블 연관 관계 설정 */
		function fnSetTableRelation(){
			var topTable = "resolveContent";
			var midTable = "detailContent";
			var botTable = "itemDetailContent";
			var arrfocusKey = [];
			
			//포커스테이블에 저장
			focusJsonList[topTable] = RESOL_JSON;
			focusJsonList[midTable] = DETAIL_JSON;
			focusJsonList[botTable] = ITEMDETAIL_JSON;
			
			//첫 번째 테이블 테이블 연관정보 저장
			var topTblRelation = {};
			topTblRelation.key = topTable;
			//첫 번째 테이블 테이블 연관정보 배열
			var linkInfoTop = [];
			var linkInfoJsonTop = {};
			linkInfoJsonTop.myTableName = topTable;
			//연관 태이블명
			linkInfoJsonTop.linkTableName = midTable;
			//행 자동생성
			linkInfoJsonTop.autoCreateRow = 'Y';
			//테이블 타입
			linkInfoJsonTop.linkTableType = '1';
			//연관 테이블 명
			linkInfoJsonTop.linkParentElementId = midTable+"_TRDATA";
			//연관테이블 json 데이터
			linkInfoJsonTop.linkJsonData = DETAIL_JSON;
			//포커스 여부
			linkInfoJsonTop.focusYN = 'Y';
			//테이블카운드 변수 명
			linkInfoJsonTop.tableRowNumVariableName = 'midTableRowCount';
			//그룹 행 표현 여부
			linkInfoJsonTop.groupDisplayYN = 'Y';
			//저장
			linkInfoTop.push(linkInfoJsonTop);	
			topTblRelation.linkInfo = linkInfoTop;
			
			
			
			//두 번째 테이블 테이블 연관정보 저장
			var midTblRelation = {};
			midTblRelation.key = midTable;
			//두 번째 테이블 테이블 연관정보 배열
			var linkInfoMid = [];
			var linkInfoJsonMid = {};
			linkInfoJsonMid.myTableName = midTable;
			//연관 태이블명
			linkInfoJsonMid.linkTableName = botTable;
			//행 자동생성
			linkInfoJsonMid.autoCreateRow = 'Y';
			//테이블 타입
			linkInfoJsonMid.linkTableType = '2';
			//연관 테이블 명
			linkInfoJsonMid.linkParentElementId = botTable+"_TRDATA";
			//linkInfoJsonMid json 데이터
			linkInfoJsonMid.linkJsonData = ITEMDETAIL_JSON;
			//포커스 여부
			linkInfoJsonMid.focusYN = 'Y';
			//그룹 행 표현 여부
			linkInfoJsonMid.groupDisplayYN = 'Y';
			//테이블카운드 변수 명
			linkInfoJsonMid.tableRowNumVariableName = 'botTableRowCount';
			//저장
			linkInfoMid.push(linkInfoJsonMid);	
			midTblRelation.linkInfo = linkInfoMid;
			
			
			//세 번째 테이블 테이블 연관정보 저장
			var botTblRelation = {};
			botTblRelation.key = botTable;
			
			var linkInfoBot = [];
			var linkInfoJsonBot = {};
			
			linkInfoJsonBot.myTableName = botTable;			
			linkInfoJsonBot.linkTableName = botTable;
			//행 자동생성
			linkInfoJsonBot.autoCreateRow = 'Y';
			//테이블 타입
			linkInfoJsonBot.linkTableType = '2';
			//연관 테이블 명
			linkInfoJsonBot.linkParentElementId = botTable+"_TRDATA";
			//linkInfoJsonMid json 데이터
			linkInfoJsonBot.linkJsonData = ITEMDETAIL_JSON;
			//포커스 여부
			linkInfoJsonBot.focusYN = 'Y';
			//그룹 행 표현 여부
			linkInfoJsonBot.groupDisplayYN = 'Y';
			//테이블카운드 변수 명
			linkInfoJsonBot.tableRowNumVariableName = 'botTableRowCount';
			
			linkInfoBot.push(linkInfoJsonBot);	
			botTblRelation.linkInfo = linkInfoBot;
			
			arrfocusKey.push(topTblRelation);
		    arrfocusKey.push(midTblRelation);
		    arrfocusKey.push(botTblRelation);
			
		    //저장
		    focusJsonList.arrfocusKey = arrfocusKey; 
		    
		}
		
		//코드팝업 커스텀 : 일반
		function fnOpenLayerPopup(bindId, item) {
			/*백그라운드 포커스 주기*/
			document.body.focus();
			//setTimeout (function () {document.getElementById ( 'myInput'). focus ();}, 10);
			/*로직으로 실제데이터 가져오기*/
			console.log('bindID:'+ bindId);
			console.log(item);
			
			/*==========================*/
			/* 데이터 호출 로직
			/*========================== */
			//if(bindId)
			fnLoadRequestData(bindId, item);
			
			
			/*로직 완료 후 그리기*/
			$("#divCodeHelperPop").css('display', 'block');
	
			/* uctable 코드팝업 그리드 헤더 생성*/
			$.devTable.createCodeHelper(headjson, 'divCodePopLayer', '1', '160px', 'N');
			
			/* 데이터 바인드 */
			$.devTable.addrowCodeData(headjson, dataJson, '1', 'divCodePopLayer');
			
			/* 코드도움창 키이벤트 등록 */
			fnRegUCTableCodePopKeyEvent(event,'divCodePopLayer','hdnPopupData','hdnInputPopupInfo',headjson,'1');
			
			/* 현재 코드팝업 정보 파라메터 히든값에 저장하기 */
			item.bindId = bindId;
			item.searchText = $("#"+bindId).val();
			//사용자 입력 검색어
			$("#hdnInputPopupInfo").val(JSON.stringify(item));
			//현재 팝업 더에터 저장
			$("#hdnPopupData").val(JSON.stringify(dataJson));
			
			$(".UCSearch").val(item.searchText);
			fnPreCodePopSearch('hdnPopupData' ,item.searchText,'divCodePopLayer_TABLE',headjson,'1');
			
		}
		
		//코드팝업 커스텀 : 결의금액
		function fnOpenResolAmtLayerPopup(bindId, item){
			var codeParam = fnInspectCodeHelpParams();
			
			// 거래처 구분 : 기타 소득
			if(codeParam.partnergbn == 4){
				var paramAmt =$("#"+bindId).val().replace(/,/gi,"") || 0;
				/*백그라운드 포커스 주기*/
				document.body.focus();				
				
				/*로직 완료 후 그리기*/
				$("#divResolAmtCodeHelperPop").css('display', 'block');
				
				/* 금액 마스크 */
				$('#txtReqExpendAmt').mask('0,000,000,000,000,000', { reverse: true });
				$('#txtIncomeAmt').mask('0,000,000,000,000,000', { reverse: true });
				$('#txtIncomeTax').mask('0,000,000,000,000,000', { reverse: true });
				$('#txtJuminTax').mask('0,000,000,000,000,000', { reverse: true });
				
				
				/* 소득금액 초기값 정의 */
				$("#txtIncomeAmt").val(paramAmt);				
				$("#txtIncomeAmt").masked();
				/* 이벤트 정의 */
				$("#txtReqExpendAmt").change(function(){
					var calValue =  Number($("#txtIncomeAmt").val().replace(/,/gi,"")||0 ) - Number($("#txtReqExpendAmt").val().replace(/,/gi,"") || 0);
					$("#txtIncomeAmt").val( calValue );
					$("#txtIncomeAmt").masked();
					$("#txtIncomeAmt").css('color','red');
					$("#txtIncomeAmt").prop('readonly','true');
				});
				
				$("#btnCancelSubResolAmt").click(function(){
					fnResolPopClose();
				});
				
				$("#btnSaveSubResolAmt").click(function(){
					//값저장
					var lvData = {};
					lvData = fnInspectLevel1Data();
					
					var newData = {};
					if($("#txtIncomeGbnCode").val().length <= 0){
						alert('소득구분은 필수 입력 사항입니다.');
						return false;s
					}
					if($("#txtIncludeYM").val().length <=0){
						alert('귀속년월은 필수 입력 사항입니다.');
						return false;s
					}
					if($("#txtSubmitYear").val().length <=0){
						alert('신고귀속은 필수 입력 사항입니다.');
						return false;s
					}
					
					newData.ETCDUMMY1 = $("#txtIncomeGbnCode").val();
					newData.ETCRATE = $("#txtReqExpendRate").val() || 0;
					newData.NDEP_AM = $("#txtReqExpendAmt").val().replace(/,/gi,"") || 0;
					newData.INAD_AM = $("#txtIncomeAmt").val().replace(/,/gi,"") || 0;
					newData.INTX_AM = $("#txtIncomeTax").val().replace(/,/gi,"") || 0;
					newData.RSTX_AM = $("#txtJuminTax").val().replace(/,/gi,"") || 0;
					newData.ET_YN = '1';
					newData.ETCDATA_CD = 'G';
					newData.TAX_YN = '1';
					newData.ETCRVRS_YM = $("#txtIncludeYM").val();
					newData.ETCDUMMY2 = $("#txtSubmitYear").val();
					fnSetLevel1Data(lvData, newData);
					
					//결의금액
					
					var arrElement = $("#"+bindId).attr('id').split('_');
					
					
					var totalTax = 0;
					totalTax = Number($("#txtIncomeTax").val().replace(/,/gi,"") || 0) + Number($("#txtJuminTax").val().replace(/,/gi,"") || 0);
					$("#taxamt_" + arrElement[1] + "_30").val(totalTax);
					$("#taxamt_" + arrElement[1] + "_30").masked();
					
					var totalSupplyAmt = 0;
					totalSupplyAmt = Number($("#resolamt_" + arrElement[1] + "_29").val().replace(/,/gi,"")|| 0) - Number($("#taxamt_" + arrElement[1] + "_30").val().replace(/,/gi,"")||0);
					$("#supplyamt_" + arrElement[1] + "_31").val(totalSupplyAmt);
					$("#supplyamt_" + arrElement[1] + "_31").masked();
					fnResolPopClose();
					
				});
				
				/* 마스크 넣기 */
				$('#txtIncludeYM').mask('0000/ZR',{
						placeholder : "____/__",
						clearIfNotMatch: true,
						translation:{
							'Z':{
								pattern : /[0-1]/, optional : true
							},
							'R':{
								pattern : /[1-9]/, optional : true
							}
						}
				});
				
				/* 귀속년월 */
				$("#txtIncludeYM").blur(function(){
					var inputDate = $(this).val();
					if(inputDate == ''){
						return false;	
					}
					
					var arrDate = [];
					arrDate = inputDate.split('/');
					
					
					var bDateCheck = true;
				    var nYear = Number(arrDate[0]);
				    var nMonth = Number(arrDate[1]);

				    if (nYear < 1900 || nYear > 3000)
				    { // 사용가능 하지 않은 년도 체크
				        bDateCheck = false;
				    }

				    if (nMonth < 1 || nMonth > 12)
				    { // 사용가능 하지 않은 달 체크
				        bDateCheck = false;
				    }

				    if(bDateCheck == false) 
				    { 
				       //alert("날짜를 잘못 입력하였습니다. 다시 입력해주세요.");
				       $('#txtIncludeYM').val('');
				       return false;
				    }
				    else{
				    	if(arrDate[1].length == 1){
				    		nMonth = '0'+nMonth;
				    		 $('#txtIncludeYM').val(nYear+'/'+nMonth);
				        	 $('#txtIncludeYM').val();
				        	 
				        
				    	}
				    	//신고귀속
			        	 $('#txtSubmitYear').val(nYear);
				    }
				  
				});
				  
			    /* 소득세액 */
			    $("#txtIncomeTax").blur(function(){
			    	var taxValue = $(this).val().replace(/,/gi,"");				
			    	var juminTax = Number(taxValue)/10;
			    	//주민세액
			    	$("#txtJuminTax").val(juminTax);
			    	$("#txtJuminTax").masked();
			    	
			    });
			    
			    
			  		  
			    /* 엔터키 이벤트 정의 */
			    $('#txtReqExpendRate').on('keydown',function(e ){
			    	switch(e.keyCode){
			    		case 13:
			    			if($("#txtIncomeGbnCode").val() == 62){
					    		if($("#txtReqExpendRate").val().length <= 0){
					    			alert('소득세액 0%를 입력할 수 없습니다.');
					    			$("#txtReqExpendRate").focus();
					    			$("#txtReqExpendRate").click();
					    			return;
					    		}
					    	}
			    			$("#txtReqExpendAmt").focus();
			    			$("#txtReqExpendAmt").click();
			    			break;
			    	}
			    });
			    
			    /* 엔터키 이벤트 정의 */
			    $('#txtReqExpendAmt').on('keydown',function(e ){
			    	switch(e.keyCode){
			    		case 13:			    						    						    		
			    			$("#txtIncomeAmt").masked();
			    			$("#txtIncomeTax").focus();
			    			$("#txtIncomeTax").click();
			    			break;
			    	}
			    });
			    
			    /* 엔터키 이벤트 정의 */
			    $('#txtIncomeTax').on('keydown',function(e ){
			    	switch(e.keyCode){
			    		case 13:
			    			$("#txtJuminTax").focus();
			    			$("#txtJuminTax").click();
			    			break;
			    	}
			    });
			    
			    /* 엔터키 이벤트 정의 */
			    $('#txtJuminTax').on('keydown',function(e){
			    	switch(e.keyCode){
			    		case 13:
			    			$("#txtIncludeYM").focus();
			    			$("#txtIncludeYM").click();
			    			break;
			    	}
			    });
			    			
			    /* 엔터키 이벤트 정의 */
			    $('#txtIncludeYM').on('keydown',function(e){
			    	switch(e.keyCode){
			    		case 13:
			    			$("#txtSubmitYear").focus();
			    			$("#txtSubmitYear").click();
			    			break;
			    	}
			    });
			    
			}
			else{
				return false;
			}
		}
		
		//코드팝업 커스텀 : 전자세금계산서 
		function fnOpenLayerTaxPopup(bindId, item) {
			/*백그라운드 포커스 주기*/
			document.body.focus();								
			/*==========================*/
			/* 데이터 호출 로직
			/*========================== */
			fnLoadRequestData(bindId, item);
			
			
			/*로직 완료 후 그리기*/
			$("#divTaxCodeHelperPop").css('display', 'block');
		
			/* 자바스크립트 오늘 날짜 지정 */
			var d = new Date();
			var month = 0;
			var day = 0;
			if (d.getMonth() + 1 < 9) {
				month = '0' + Number(d.getMonth() + 1);
			} else {
				month = d.getMonth() + 1;
			}
		
			if (d.getDate() < 10) {
				day = '0' + d.getDate();
			} else {
				day = d.getDate();
			}
			var todayDate = d.getFullYear() + '-' + month + '-' + day;
		
			$('#txtTODT').mask('0000-00-00');
			$('#txtTODT').val(todayDate);
			$('#txtTODT').masked();
			
			
		
			d = new Date(d.getFullYear(),d.getMonth(),d.getDate());
			d.setDate(d.getDate() -7 );
			if (d.getMonth() + 1 < 9) {
				month = '0' + Number(d.getMonth() + 1);
			} else {
				month = d.getMonth() + 1;
			}
		
			if (d.getDate() < 10) {
				day = '0' + d.getDate();
			} else {
				day = d.getDate();
			}
			var fromDate = d.getFullYear() + '-' + month + '-' + day;
			
			$('#txtFRDT').mask('0000-00-00');
			$('#txtFRDT').val(fromDate);
			$('#txtFRDT').masked();
			
			
			    
			/* uctable 코드팝업 그리드 헤더 생성*/
			$.devTable.createCodeHelper(headjson, 'divTaxCodePopLayer', '2', '300px', 'N');
			
			/* 데이터 바인드 */
			$.devTable.addrowCodeData(headjson, dataJson, '2', 'divTaxCodePopLayer');
			
			/* 코드도움창 키이벤트 등록 */
			fnRegUCTableCodePopKeyEvent(event,'divTaxCodePopLayer','hdnPopupData','hdnInputPopupInfo',headjson,'1');
			
			
			//TABLE KEY EVET BIND(KEYDOWN)
			$('#divTaxCodeHelperPop').on('keydown',function(e ){
				switch(e.keyCode)
				{
					/* ESC EVENT */
					case  119:
						fnGetEtaxDtaAjax();
						break;	
					default :					
						break;
				}
			});	
			
			/* 현재 코드팝업 정보 파라메터 히든값에 저장하기 */
			item.bindId = bindId;
			$("#hdnInputPopupInfo").val(JSON.stringify(item));
			//현재 팝업 더에터 저장
			$("#hdnPopupData").val(JSON.stringify(dataJson));
			
			
			/* 포커스 키 이벤트 등록 */
			$("#selDTFG").focus();
			
			$('#divTaxCodeSelectZone').unbind();
			//TABLE KEY EVET BIND(KEYDOWN)
			$('#divTaxCodeSelectZone').on('keydown',function(e ){
				switch(e.keyCode)
				{
					/* ENTER EVENT */
					case 13:
						var focusNo = ['selDTFG','txtFRDT','txtTODT','selTAXTY','selTRCD','selETAXTY'];
						var nextId = '';
						var curId = document.activeElement.id
						for(var i =0; i < focusNo.length; i++){
							if(focusNo[i] == curId){
								if(i == focusNo.length-1){
									nextId = focusNo[0];
									break;
								}
								else{
									if(curId == 'selTRCD'){
										fnGetETaxPater();	
										break;
									}
									else{
										nextId = focusNo[i+1];
										break;
									}
								}
							}
						}
						
						$("#"+nextId).focus();
						break;
					/* LEFT ARROW EVENT */
					case 37 :					
						break;
					case 38:
						break;
					/* RIGHT ARROW EVENT */
					case 39:					
						break;
					/* DOWN ARROW EVENT */
					case 40:
						break;
					case  119:
						fnGetEtaxDtaAjax();
					default :
						break;
				}
			});	
			
		}
		
		//코드팝업 바인드 커스텀 함수
		function fnSetResolPopBind(ucTableBindId, rowData){
			fnSetBindingCode(ucTableBindId,rowData);
		}
		
		//선택 셀에 대한 커스텀 함수
		function fnSetSelectCell(headerJsonList, curElement){	
			var arrClass = $(curElement).parent().parent().attr('class').split(' ');
			var myGroupClass = arrClass[0];
			var myCheju = '';
			
			/* 본인 클래스의 체주유형을 찾는다. */
			$.each(ezDataLevel1List,function(index, item){
				if(item.key === myGroupClass){
					myCheju = item.cheju;
					return false;
				}
			});
			
			if( myCheju != undefined && myCheju.length > 0){
				fnSetDisplayTblHeader(myCheju);
			}
			
			var eleId = $(curElement).attr('id');
			
			var arrId = eleId.split('_');
			//거래처 구분
			if(arrId[0].indexOf('partnergbn') > -1){
				
			}
			else if(arrId[0].indexOf('resolamt') > -1){
				$(curElement).unbind('blur');
				$(curElement).unbind('focusin');
				$(curElement).focusin(function(){
					if($(curElement).val() == 0){
						$(curElement).val('');
					}	
				});
				$(curElement).blur(function(){
					if($(curElement).val() == ''){
						$(curElement).val(0);
					}
					var totalAmt = $(curElement).val().replace(/,/gi,"");
					var taxAmt = $('#taxamt'+'_'+arrId[1]+'_30').val().replace(/,/gi,"");
					if(taxAmt == ''){
						taxAmt = 0;
					}
					
					var supplyAmt = Number(totalAmt) - Number(taxAmt);
					$('#supplyamt'+'_'+arrId[1]+'_31').val(supplyAmt);
					var maskValue = $('#supplyamt'+'_'+arrId[1]+'_31').masked();
					$('#supplyamt'+'_'+arrId[1]+'_31').val(maskValue);
				});
				
			}
			else if(arrId[0].indexOf('supplyamt') == 0){
				$(curElement).attr('readonly','true');
			}
			else if(arrId[0].indexOf('taxamt') == 0){
				$(curElement).unbind('blur');
				$(curElement).unbind('focusin');
				$(curElement).focusin(function(){
					if($(curElement).val() == 0){
						$(curElement).val('');
					}	
				});
				$(curElement).blur(function(){
					if($(curElement).val() == ''){
						$(curElement).val(0);
					}
					var totalAmt = $('#resolamt'+'_'+arrId[1]+'_29').val().replace(/,/gi,"");
					
					if(totalAmt == ''){
						totalAmt = 0;
					}
				
					var supplyAmt = totalAmt - $(curElement).val().replace(/,/gi,"");				
					$('#supplyamt'+'_'+arrId[1]+'_31').val(supplyAmt);
					var maskValue = $('#supplyamt'+'_'+arrId[1]+'_31').masked();
					$('#supplyamt'+'_'+arrId[1]+'_31').val(maskValue);
					
				});
			}
			else if(arrId[0].indexOf('unitprice') > -1){
				$(curElement).unbind('blur');
				$(curElement).unbind('focusin');
				$(curElement).focusin(function(){
					if($(curElement).val() == 0){
						$(curElement).val('');
					}	
				});
				$(curElement).blur(function(){
					var amount = 0;
					var unitprice= 0;
					if($(curElement).val() == ''){
						unitprice = 0;
					}
					else{
						unitprice = $(curElement).val().replace(/,/gi,"");
					}
					if($('#amount'+'_'+arrId[1]+'_2').val()== ''){ 
						amount = 0;
					}
					else{
						amount = $('#amount'+'_'+arrId[1]+'_2').val().replace(/,/gi,"");
					}
					var totalAmt = unitprice * amount;
					$('#itemtotalamt'+'_'+arrId[1]+'_6').val(totalAmt);
					var maskValue = $('#itemtotalamt'+'_'+arrId[1]+'_6').masked();
					$('#itemtotalamt'+'_'+arrId[1]+'_6').val(maskValue);
				});
			}
			else if(arrId[0].indexOf('amount') == 0){
				$(curElement).unbind('blur');
				$(curElement).unbind('focusin');
				$(curElement).focusin(function(){
					if($(curElement).val() == 0){
						$(curElement).val('');
					}	
				});
				$(curElement).blur(function(){
					var amount = 0;
					var unitprice= 0;
					if($(curElement).val() == ''){
						amount = 0;
					}
					else{
						amount = $(curElement).val();
					}
					if($('#unitprice'+'_'+arrId[1]+'_3').val()== ''){
						unitprice = 0;
					}
					else{
						unitprice = $('#unitprice'+'_'+arrId[1]+'_3').val().replace(/,/gi,"");
					}
					var totalAmt = amount * unitprice;					
					$('#itemtotalamt'+'_'+arrId[1]+'_6').val(totalAmt);
					var maskValue = $('#itemtotalamt'+'_'+arrId[1]+'_6').masked();
					$('#itemtotalamt'+'_'+arrId[1]+'_6').val(maskValue);
					
				});
			}else if(arrId[0].indexOf('itemtotalamt') == 0){
				//console.log(arrId[0]);
				//$(curElement).attr('readonly','true');
			}else if(arrId[0].indexOf('resoldate') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#resoldate'+'_'+arrId[1]+'_0').val();
					var id = 'resoldate_'+arrId[1] +'_0';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('trdate') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#trdate'+'_'+arrId[1]+'_7').val();
					var id = 'trdate'+'_'+arrId[1] +'_7';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('ntisregdt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#ntisregdt'+'_'+arrId[1]+'_8').val();
					var id = 'ntisregdt'+'_'+arrId[1] +'_8';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('biztripstdt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#biztripstdt'+'_'+arrId[1]+'_13').val();
					var id = 'biztripstdt'+'_'+arrId[1] +'_13';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('biztripendt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#biztripendt'+'_'+arrId[1]+'_14').val();
					var id = 'biztripendt'+'_'+arrId[1] +'_14';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('overworkstdt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#overworkstdt'+'_'+arrId[1]+'_23').val();
					var id = 'overworkstdt'+'_'+arrId[1] +'_23';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('overworkendt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#overworkendt'+'_'+arrId[1]+'_24').val();
					var id = 'overworkendt'+'_'+arrId[1] +'_24';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('edustdt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#edustdt'+'_'+arrId[1]+'_31').val();
					var id = 'edustdt'+'_'+arrId[1] +'_31';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('eduendt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#eduendt'+'_'+arrId[1]+'_32').val();
					var id = 'eduendt'+'_'+arrId[1] +'_32';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('usestdt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#usestdt'+'_'+arrId[1]+'_36').val();
					var id = 'usestdt'+'_'+arrId[1] +'_36';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('useendt') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#useendt'+'_'+arrId[1]+'_37').val();
					var id = 'useendt'+'_'+arrId[1] +'_37';
					fnDateVaildation(value, id);
				});
			}else if(arrId[0].indexOf('biztripsttime') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#biztripsttime'+'_'+arrId[1]+'_15').val();
					var id = 'biztripsttime'+'_'+arrId[1] +'_15';
					fnTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('biztripentime') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#biztripentime'+'_'+arrId[1]+'_16').val();
					var id = 'biztripentime'+'_'+arrId[1] +'_16';
					fnTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('overworksttime') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#overworksttime'+'_'+arrId[1]+'_25').val();
					var id = 'overworksttime'+'_'+arrId[1] +'_25';
					fnTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('overworkentime') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#overworkentime'+'_'+arrId[1]+'_26').val();
					var id = 'overworkentime'+'_'+arrId[1] +'_26';
					fnTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('edusttime') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#edusttime'+'_'+arrId[1]+'_33').val();
					var id = 'edusttime'+'_'+arrId[1] +'_33';
					fnTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('eduentime') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#eduentime'+'_'+arrId[1]+'_34').val();
					var id = 'eduentime'+'_'+arrId[1] +'_34';
					fnTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('usesttime') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#usesttime'+'_'+arrId[1]+'_38').val();
					var id = 'usesttime'+'_'+arrId[1] +'_38';
					fnTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('usemethod') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#usemethod'+'_'+arrId[1]+'_39').val();
					var id = 'usemethod'+'_'+arrId[1] +'_39';
					fnTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('meetstd') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#meetstd'+'_'+arrId[1]+'_19').val();
					var id = 'meetstd'+'_'+arrId[1] +'_19';
					fnDateTimeVaildation(value, id);
				});
			}else if(arrId[0].indexOf('meetetd') == 0){
				$(curElement).unbind('blur');
				$(curElement).blur(function(){
					var value = $('#meetetd'+'_'+arrId[1]+'_20').val();
					var id = 'meetetd'+'_'+arrId[1] +'_20';
					fnDateTimeVaildation(value, id);
				});
			}

			
			
			/*  결의내용 반영 및 표현 */
			//$('#resolNote').val('');
			var hdnResolValue = $("#hdnResolNoteInfo").val();
			if(hdnResolValue != ''){
				var dataList = JSON.parse(hdnResolValue);
				var isMatch = 'N';
				$.each(dataList,function(index,item){
					if(item.key == myGroupClass){
						isMatch = 'Y';
						$('#resolNote').val(item.value);
						return false;
					}
				});
				if(isMatch == 'N'){
					$('#resolNote').val('');
				}
			}
				
		}
/* =============================== UC DEV 테이블 연관 스크립트 =============================== */


/* =============================== 이지바로 스크립트 =============================== */

function fnPopClose(){
	$("#divCodeHelperPop").css('display', 'none');
	$("#divCodePopLayer").empty();
	$("#hdnPopupData").val('');
	$("#hdnInputPopupInfo").val('');
	$("#txtCodeSearch").val('');
}

function fnSubPopClose(){
	$("#divTaxSubCodeHelperPop").css('display', 'none');
	$("#divTaxSubCodePopLayer").empty();
	$("#hdnPopupData").val('');
	$("#txtSubCodeSearch").val('');	
}

function fnResolPopClose(){
	$("#divResolAmtCodeHelperPop").css('display', 'none');
	$("#txtIncomeGbnCode").val('');
	$("#txtReqExpendRate").val('');
	$("#txtReqExpendAmt").val('');
	$("#txtIncomeAmt").val('');
	$("#txtIncomeTax").val('');
	$("#txtJuminTax").val('');
	$("#txtIncludeYM").val('');
	$("#txtSubmitYear").val('');
	
	$("#divResolAmtSubCodeHelperPop").css('display', 'none');
	
	$("#searchResolAmtSubButton").val('');
	$("#divResolAmtSubCodePopLayer").empty();	
}

function fnTaxPopClose(){
	//종속 거래처 팝업 초기화
	fnSubPopClose();
	$("#divTaxCodeHelperPop").css('display', 'none');
	$("#divTaxCodePopLayer").empty();
	$("#hdnInputPopupInfo").val('');
	$("#hdnPopupData").val('');
	$("#selTRCD option:eq(0)").remove();
}

/* ajax 코드 호출 */
function fnGetAjaxCode(type){
	var resultData = [];
	var params =  {};
	
	//전자세금계산서 코드 팝업 파라메터
	if(type == 'taxapprno'){ 
		var hdnInit = JSON.parse($("#hdnInitInfo").val());
		params.LANGKIND = 'KOR';
		params.CO_CD = hdnInit.CO_CD;
		params.DT_FG = $("#selDTFG").val();
		params.FR_DT = $("#txtFRDT").val().replace(/\-/gi,"");
		params.TO_DT = $("#txtTODT").val().replace(/\-/gi,"");
		params.TAX_TY = $("#selTAXTY").val();
		params.ETAX_TY = $("#selETAXTY").val();
		params.TR_CD = $("#selTRCD").val() + '|';
	}
	//일반코드 팝업 파라메터
	else{
		params = fnInspectCodeHelpParams();
	}
	
	params.type = type;
	var codeParam = fnInspectCodeHelpParams();
	params.partnergbn = codeParam.partnergbn;
		
	$.ajax({
		async : false,
		type : "post",
		data : params,
		url : '<c:url value="/expend/ez/user/code/EzCodeHelpInfo.do" />',
		datatype : "json",
		success : function(result) {
			if(result.aaData != undefined ){
				resultData= result.aaData;
			}
		},
		error : function(err) {
			console.log(err);
		}
	});
	return resultData;
}


function fnSetLoading(){
	fnLoadAcUnitInfo();
	fnLoadDeptUserInfo();
	fnSetWriteDate();
	fnRegCommonCodeEvnt();
	/* 코드팝업 날짜 기본 셋팅 */
	var codeParams = fnInspectCodeHelpParams();
	var initData = {};
	initData.P_STD_DT = $("#txtWriteDate").val().replace(/-/gi,"");
	fnSetCodeHelpParams(codeParams,initData);
}

function fnRegCommonCodeEvnt(){
	/* 공통코드 설정 */
	$("#btnCodePop").click(
			function() {
				var url = "<c:url value='/expend/ez/user/EzCommonCodePop.do'/>";

		    	var popupWidth = 848;
			    var popupHeight = 614;
			    var windowX = (screen.width - popupWidth)/2;
			    var windowY = (screen.height - popupHeight)/2;
			    
			    var basicInfo = JSON.parse($("#hdnInitInfo").val());			    			
				    url += '?CO_CD=' + basicInfo.CO_CD;
				    url += '&LANGKIND=' + 'KOR';
				    url += '&EMP_SEQ=' + basicInfo.EMP_CD;
				var win = window.open(url,"공통코드 설정","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);
				
		        if(win== null || win.screenLeft == 0){
		        	alert("<%=BizboxAMessage.getMessage("TX000018810","브라우져 팝업차단 설정을 확인해 주세요")%>");
		        }			
	});
}

/* 이지바로 전자결재 연동 */
function fnSetAppdoc(params){
	 $.ajax({
         type : 'post',
         url : '<c:url value="/expend/ez/user/EzbaroCallAppdoc.do" />',
         datatype : 'json',
         async : true,
         data : params,
         success : function( data ) {
         	
         	if(data.result == undefined || data.result == null){
         		alert('전자결재 문서 생성 중 오류가 발생하였습니다.');
         		return;
         	}
         	if(eaInfo.eaType == 'eap'){
	             if (data.result.docSeq != '0' && data.result.eaType != '' 
	             	 && data.result.formSeq != '0' && data.result.approKey != ''){
	                 popupAutoResize();
	                 /* location.href : [기능 : 새로운 페이지로 이동된다] [형태 : 속성] [주소 히스토리 : 기록된다] [사용예 : location.href='url'] */
	                 /* location.replace : [기능 : 기존페이지를 새로운 페이지로 변경시킨다] [형태 : 메서드] [주소 히스토리 : 기록되지 않는다] [사용예 : location.replace('url')] */
	                 /* 지출결의 특성상 뒤로가기를 이용하여 이전페이지로 돌아오면 안되기 때문에 replace 를 사용한다. */
	                 //var url = '/'+ data.result.eaType +'/ea/eadocpop/EAAppDocPop.do' + '?form_id=' + data.result.formSeq + '&doc_id=' + data.result.docSeq + '&approkey=' + data.result.approKey;		                 
	                 var url = '/'+ data.result.eaType +'/ea/interface/eadocpop.do?form_id='+data.result.formSeq+'&processId='+eaInfo.processId+'&approKey='+data.result.approKey+'&docId='+data.result.docSeq;
	                 location.replace(url);
	             }
	             else{
	             	alert("전자 결재문서 생성 중 오류가 발생하였습니다.");
	             	return;
	             }
         	}else if(eaInfo.eaType == 'ea'){
         		
         	}
         	
         },
         error : function( data ) {
             console.log("! [EZ BARO CALL APPDOC ERROR - " + JSON.stringify(data));
             alert("전자결재 문서 생성 중 오류가 발생하였습니다.");
         }
     });		
}


/* 결재문서 팝업 사이즈 지정 */
function popupAutoResize() {
    var thisX = parseInt(document.body.scrollWidth);
    var thisY = parseInt(document.body.scrollHeight);	    
    var maxThisX = screen.width - 50;
    var maxThisY = screen.height - 50;
    
    if(maxThisX > 1000) {
    	maxThisX = 1000;
    }
    var marginY = 0;
    // 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
    if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45;        // IE 6.x
    else if(navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75;    // IE 7.x
    else if(navigator.userAgent.indexOf("Firefox") > 0) marginY = 50;   // FF
    else if(navigator.userAgent.indexOf("Opera") > 0) marginY = 30;     // Opera
    else if(navigator.userAgent.indexOf("Netscape") > 0) marginY = -2;  // Netscape

    if (thisX > maxThisX) {
        window.document.body.scroll = "yes";
        thisX = maxThisX;
    }
    if (thisY > maxThisY - marginY) {
        window.document.body.scroll = "yes";
        thisX += 19;
        thisY = maxThisY - marginY;
    }
    
    // 센터 정렬
    var windowX = (screen.width - (maxThisX+10))/2;
    var windowY = (screen.height - (maxThisY))/2 - 20;
    window.moveTo(windowX,windowY);
    window.resizeTo(maxThisX, maxThisY);
}

/* 이지바로 전송 시작 */
function fnSaveResolErpData(params){	
	var task_sq = 0;
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroHReqInsert.do" />',
		datatype : "json",
		success : function(result) {
			task_sq = result.task_sq;
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return task_sq;
}


/* 이지바로 품의상세 전송 시작 */
function fnSaveItemDetailErpData(params){	
	var regseq = 0;
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroHReqDetailInsert.do" />',
		datatype : "json",
		success : function(result) {
			regseq = result.regseq;
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return regseq;
}

/* 이지바로 마스터 정보 생성 */
function fnCreateEzbaroMasterInfo(){
	var seq = 0;
	var params = {};
	
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroMasterInfoInsert.do" />',
		datatype : "json",
		success : function(result) {
			seq = result.master_seq;
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return seq;
}


/* 이지바로 erp 정보 마스터 정보 삽입 */
function fnInsertErpEzbaroMaster(params){
	var erp_master_seq = 0;
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroErpMasterInsert.do" />',
		datatype : "json",
		success : function(result) {
			erp_master_seq = result.erp_master_seq;
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return erp_master_seq;
}



/* 이지바로 erp 정보 슬레이브 정보 삽입 */
function fnInsertErpEzbaroSlave(params){
	var isSuccess = false;
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroErpSlaveInsert.do" />',
		datatype : "json",
		success : function(result){
			if(result.erp_slave_seq != '' || result.erp_slave_seq != undefined ){
				isSuccess = true;
			}
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return isSuccess;
}

/* 이지바로 파라메터 정보 삽입 */
function fnInsertGwEzbaroParams(params){
	var isSuccess = false;
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroGwParamsInsert.do" />',
		datatype : "json",
		success : function(result){
			if(result.param_seq != '' || result.param_seq != undefined ){
				isSuccess = true;
			}
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return isSuccess;
}

/* 이지바로 GW 마스터 정보 삽입 */
function fnInsertGwEzbaroMaster(params){
	var gw_master_seq = 0;
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroGwMasterInsert.do" />',
		datatype : "json",
		success : function(result) {
			gw_master_seq = result.gw_master_seq;
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return gw_master_seq;
}

/* 이지바로 GW 슬레이브 정보 삽입 */
function fnInsertGwEzbaroSlave(params){
	var isSuccess = false;
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroGwSlaveInsert.do" />',
		datatype : "json",
		success : function(result) {
			if(result.gw_slave_seq != '' || result.gw_slave_seq != undefined ){
				isSuccess = true;
			}
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return isSuccess;
}


// 회계단위 불러오기
function fnLoadAcUnitInfo(){
	$.ajax({
		async : false,
		type : "post",
		url : '<c:url value="/expend/ez/user/EzUnitInfo.do" />',
		datatype : "json",
		success : function(result) {
			console.log(result);
			$("#txtAcctUnit").val(result.DIV_NM); 
			$("#txtAcctUnit").attr("readonly",true);
			
			var init = {};
			init.CO_CD = result.CO_CD;
			init.DIV_CD = result.DIV_CD;
			init.DIV_NM = result.DIV_NM;
			$("#hdnInitInfo").val(JSON.stringify(init));
			console.log($("#hdnInitInfo").val());
		},
		error : function(err) {
			console.log(err);
		}
	});
}

// 사용자/부서정보 불러오기
function fnLoadDeptUserInfo(){
	$.ajax({
		async : false,
		type : "post",
		url : '<c:url value="/expend/ez/user/EzDeptUserInfo.do" />',
		datatype : "json",
		success : function(result) {
			console.log(result);
			var deptUser = result.DEPT_NM +'/' +result.EMP_NM;
			$("#txtDeptUser").val(deptUser); 
			$("#txtDeptUser").attr("readonly",true);
			
			var init = JSON.parse($("#hdnInitInfo").val());
			init.DEPT_CD = result.DEPT_CD;
			init.DEPT_NM = result.DEPT_NM;
			init.EMP_CD = result.EMP_CD;
			init.EMP_NM = result.EMP_NM;
			$("#hdnInitInfo").val(JSON.stringify(init));
			console.log($("#hdnInitInfo").val());
		},
		error : function(err) {
			console.log(err);
		}
	});
}

/* 전자세금계산서 품목상세 리스트 불러오기 */
function fnLoadETAXList(params){
	$.ajax({
		async : false,
		type : "post",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroGetETaxListInfo.do" />',
		datatype : "json",
		success : function(resultList) {
			//로우를 추가할 함수가 필요하다..
			fnCallbackETaxList(resultList);
		},
		error : function(err) {
			console.log(err);
		}
	});
}

/* 이지바로 기존 작성한 데이터 불러오기*/
function fnLoadPreEzData(params){
	$.ajax({
		async : false,
		type : "post",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroLoadPreData.do" />',
		datatype : "json",
		success : function(resultList) {
			alert(JSON.stringify(resultList));
			console.log(resultList);
		},
		error : function(err) {
			console.log(err);
		}
	});
}

/* 이지바로 지급은행 단일 정보불러오기*/
function fnGetAjaxBankInfo(params){
	var retData ={};
	
	$.ajax({
		async : false,
		type : "post",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroBankInfo.do" />',
		datatype : "json",
		success : function(result) {
			retData = result.result;
		},
		error : function(err) {
			console.log(err);
		}
	});
	
	return retData;
}

/* 이지바로 지급은행 단일 정보불러오기*/
function fnGetAjaxEmpBankInfo(params){
	var retData ={};
	
	$.ajax({
		async : false,
		type : "post",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroEmpBankInfo.do" />',
		datatype : "json",
		success : function(result) {
			retData = result.result;
		},
		error : function(err) {
			console.log(err);
		}
	});
	
	return retData;
}

/* 이지바로 사용자 계좌정보 불러오기*/
function fnGetAjaxEmpAcctInfo(params){
	var retData ={};
	
	$.ajax({
		async : false,
		type : "post",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroEmpAcctInfoSelect.do" />',
		datatype : "json",
		success : function(result) {
			retData = result.result;
		},
		error : function(err) {
			console.log(err);
		}
	});
	
	return retData;
}




//작성일자 표시
function fnSetWriteDate() {
	var d = new Date();
	var month = 0;
	var day = 0;
	if (d.getMonth() + 1 < 9) {
		month = '0' + Number(d.getMonth() + 1);
	} else {
		month = d.getMonth() + 1;
	}

	if (d.getDate() < 10) {
		day = '0' + d.getDate();
	} else {
		day = d.getDate();
	}
	var todayDate = d.getFullYear() + '-' + month + '-' + day;

	$("#txtWriteDate").val(todayDate);

	//작성일
	$("#txtWriteDate").kendoDatePicker({
		format : "yyyy-MM-dd"
	});
}

/* 전자 세금 계산서 매입 거래처 데이터 불러오기 */
function fnGetETaxPater(){
	
	var item ={};
	item.id = "partner";
	var bindId = '';
		
	/*==========================*/
	/* 데이터 호출 로직
	/*========================== */
	fnLoadRequestData(bindId, item);
		
	/*로직 완료 후 그리기*/
	$("#divTaxSubCodeHelperPop").css('display', 'block');

	/* uctable 코드팝업 그리드 헤더 생성*/
	$.devTable.createCodeHelper(headjson, 'divTaxSubCodePopLayer', '1', '350px', 'N');
	
	/* 데이터 바인드 */
	$.devTable.addrowCodeData(headjson, dataJson, '1', 'divTaxSubCodePopLayer');
	
	/* 코드도움창 키이벤트 등록 */
	fnLayerSubCodePopKeyEvent(event,'divTaxSubCodePopLayer','hdnPopupData','',headjson,'1');

	//현재 팝업 더에터 저장
	$("#hdnPopupData").val(JSON.stringify(dataJson));
	
	

}

/* 사용자 입력 코드팝업 도움창 */
function fnPreCodePopSearch(jsonDataId, searchStr, tableName, headJson, codeTableType){
	if(searchStr.length > 0){
		var data = $("#"+jsonDataId).val();
		var jsonArr = JSON.parse(data);
		var resultJsonArr = [];
		for(var i=0; i < jsonArr.length; i++){
			$.each(jsonArr[i], function(key,value){
				if(value.indexOf(searchStr) !== -1){
					resultJsonArr.push(jsonArr[i]);
				} 
			});
		}
		console.log(resultJsonArr);
		$("#"+tableName).empty();
		tableName= tableName.replace('_TABLE','');
		$.devTable.addrowCodeData(headJson, resultJsonArr, codeTableType ,tableName)
		
	}
	else{
		var data = $("#"+jsonDataId).val();
		var jsonArr = JSON.parse(data);
		$("#"+tableName).empty();
		console.log(jsonArr);
		tableName= tableName.replace('_TABLE','');
		$.devTable.addrowCodeData(headJson, jsonArr, codeTableType ,tableName)
	}
}



/* 팝업 내 레이어 팝업 띄우기 */
function fnLayerSubCodePopKeyEvent (e, pLocationId, pCodePopDataId, pInputPopDataId, pHeadJsonData, pCodeTableType){
    //코드도움 테이블 명 저장
    var locationId = pLocationId + "_TABLE";
    
    //히든 코드 도움창 json 정보
    var jsonDataId = pCodePopDataId;
       
    //코드그리드헤더 정보
    var headJson = pHeadJsonData;
    
    //코드테이블 타입정보
    var codeTableType = pCodeTableType;
    
    //KEY EVENT DELETE
	$('.subSearch').unbind();
	//$('.onSel').unbind();
	$('#'+locationId).unbind();
	
	
	//선택한 데이터에 대한  더블클릭 이벤트
	$('#divTaxSubCodePopLayer_TABLE').dblclick(function(){
		fnSubSelectRow();
	});
	
	//검색버튼
	$("#searchSubButton").click(function(){
		fnSearchStr(jsonDataId, $(".subSearch").val(),locationId, headJson, codeTableType);
	});
	
	 $('.subSearch').unbind();
	//INPUT KEY EVET BIND(KEYDOWN)
	 $('.subSearch').on('keydown',function(e ){
		switch(e.keyCode)
		{
			/* ENTER EVENT */
			case 13:
				fnSearchStr(jsonDataId, $(".subSearch").val(),locationId, headJson, codeTableType);
				$("#" + locationId).find('TR').eq(0).click().focus();
				return false;
				break;
			/* LEFT ARROW EVENT */
			case 37 :
				break;
			/* UP ARROW EVENT */
			case 38:
				$("#" + locationId).find('.onSel').prev().click().focus();
				return false;
				break;
			/* RIGHT ARROW EVENT */
			case 39:
				
				break;
			/* DOWN ARROW EVENT */
			case 40:
				$("#" + locationId).find('.onSel').next().click().focus();
				return false;
				break;
				
			default :
				$('.UCSearch').focus();
				break;
		
		}
		
	});	
	
	 $("#" + locationId).unbind();
	 $("#" + locationId).on('keydown',function(e){
		 	switch(e.keyCode)
			{
				/* ENTER EVENT */
				case 13:
					fnSubSelectRow();
					return false;
					break;
				/* LEFT ARROW EVENT */
				case 37 :
					break;
				/* UP ARROW EVENT */
				case 38:
					$("#" + locationId).find('.onSel').prev().click().focus();
					return false;
					break;
				/* RIGHT ARROW EVENT */
				case 39:
					
					break;
				/* DOWN ARROW EVENT */
				case 40:
					$("#" + locationId).find('.onSel').next().click().focus();
					return false;
					break;
				case 27:
					//팝업닫기
					//레이어팝업 정보 초기화
					$("#divTaxSubCodeHelperPop").css('display', 'none');
					$("#"+pLocationId).empty();
					$("#txtCodeSearch").val('');
					
					//KEY EVENT DELETE
					$('.subSearch').unbind();
					$('.onSel').unbind();
					$('#'+locationId).unbind();		
					$("#selTRCD").focus();
					break;
				default :
					$('.subSearch').focus();
					break;
			}
		});
	
	
	//Search json Data on hidden json value
	function fnSearchStr(jsonDataId, searchStr, tableName, headJson, codeTableType){
		if(searchStr.length > 0){
			var data = $("#"+jsonDataId).val();
			var jsonArr = JSON.parse(data);
			var resultJsonArr = [];
			for(var i=0; i < jsonArr.length; i++){
				$.each(jsonArr[i], function(key,value){
					if(value.indexOf(searchStr) !== -1){
						resultJsonArr.push(jsonArr[i]);
					} 
				});
			}
			console.log(resultJsonArr);
			$("#"+tableName).empty();
			tableName= tableName.replace('_TABLE','');
			$.devTable.addrowCodeData(headJson, resultJsonArr, codeTableType ,tableName)
			
		}
		else{
			var data = $("#"+jsonDataId).val();
			var jsonArr = JSON.parse(data);
			$("#"+tableName).empty();
			console.log(jsonArr);
			tableName= tableName.replace('_TABLE','');
			$.devTable.addrowCodeData(headJson, jsonArr, codeTableType ,tableName)
		}
	}
	//임
	function fnSubSelectRow(){
		
		var eleSelect = $("#"+locationId).find('.onSel');
		var rowData = $(eleSelect).prop('data');
		var popInfo;
		
		$("#selTRCD option:eq(0)").remove();
		$("#selTRCD").append("<option value='"+rowData.TR_CD +"'>"+rowData.TR_CD +'  '+ rowData.ATTR_NM +"</option>");
		//팝업닫기
		//레이어팝업 정보 초기화
		$("#hdnPopupData").val('');
		
		
		$("#divTaxSubCodeHelperPop").css('display', 'none');
		$("#"+pLocationId).empty();
		$("#txtCodeSearch").val('');
		
		//KEY EVENT DELETE
		$('.subSearch').unbind();
		$('.onSel').unbind();
		$('#'+locationId).unbind();		
		$("#selETAXTY").focus();		
	}
	
}

/* 전자세금계산서 데이터 조회 */
function fnGetEtaxDtaAjax(){
					
	var item = {};
	item.id = 'taxapprno';
	var bindId = '';
	
	$("#divTaxCodePopLayer_TRDATA_FIX").empty();
	$("#divTaxCodePopLayer_TRDATA").empty();
	
	/*==========================*/
	/* 데이터 호출 로직
	/*========================== */
	fnLoadRequestData(bindId, item);
	/*로직 완료 후 그리기*/
	$("#divTaxCodeHelperPop").css('display', '');
	/* 데이터 바인드 */
	$.devTable.addrowCodeData(headjson, dataJson, '2', 'divTaxCodePopLayer');
	
	//현재 팝업 더에터 저장
	$("#hdnPopupData").val(JSON.stringify(dataJson));
	
}

/* 전자세금계산서 리스트 콜백 함수 */
function fnCallbackETaxList(resultList){
	/* 데이터 바인드*/
	if(resultList.result.length > 0){
		$.each(resultList.result,function(index,item){
			botTableRowCount = Number(botTableRowCount) + 1;
			$.devTable.addrow('itemDetailContent', ITEMDETAIL_JSON, '2', 'itemDetailContent_TRDATA' ,botTableRowCount);
			fnRegUCTableKeyEvent();
			$("#item_"+botTableRowCount+"_0").val(item.ITEMNAME);
			$("#itemsupplyamt_"+botTableRowCount+"_4").val(item.SUPCOST);
			$("#itemtaxamt_"+botTableRowCount+"_5").val(item.EXTTAX);
			$("#itemtotalamt_"+botTableRowCount+"_6").val(item.TOTPURCHAMT);
		});
	}
}

/* 날짜 유효성 검사 */
function fnDateVaildation(inputValue, bindEleid){
	var inputDate = $('#'+bindEleid).val();
	if(inputDate == ''){
		return false;	
	}
	
	var arrDate = [];
	arrDate = inputDate.split('/');
	
	
	var bDateCheck = true;
    var nYear = Number(arrDate[0]);
    var nMonth = Number(arrDate[1]);
    var nDay = Number(arrDate[2]);

    if (nYear < 1900 || nYear > 3000)
    { // 사용가능 하지 않은 년도 체크
        bDateCheck = false;
    }

    if (nMonth < 1 || nMonth > 12)
    { // 사용가능 하지 않은 달 체크
        bDateCheck = false;
    }

    // 해당달의 마지막 일자 구하기
    var nMaxDay = new Date(new Date(nYear, nMonth, 1) - 86400000).getDate();
    if (nDay < 1 || nDay > nMaxDay)
    { // 사용가능 하지 않은 날자 체크
        bDateCheck = false;
    }

    if(bDateCheck == false) 
    { 
       //alert("날짜를 잘못 입력하였습니다. 다시 입력해주세요.");
       $('#'+bindEleid).val('');
       return false;
    }
    else{
    	if(arrDate[1].length == 1){
    		nMonth = '0'+nMonth;
    		 $('#'+bindEleid).val(nYear+'/'+nMonth+'/'+nDay);
        	 $('#'+bindEleid).masked();
    	}
    	if(arrDate[2].length == 1){
    		nDay = '0'+nDay;
    		 $('#'+bindEleid).val(nYear+'/'+nMonth+'/'+nDay);
        	 $('#'+bindEleid).masked();
    	}
    	
    }

}

/* 시분 유효성 검사 */
function fnTimeVaildation(inputValue, bindEleid){
	var inputDate = $('#'+bindEleid).val();
	if(inputDate == ''){
		return false;	
	}
	var arrTime = [];
	arrTime = inputDate.split(':');
	
	var bTimeCheck = true;
    var hour = arrTime[0];
    var min = arrTime[1];
   
    if(hour.length == 1){
    	hour = '0' + hour;
    }
    else{
    	if(hour.charAt(0) == 2){
    		if(hour.charAt(1) != 0 && hour.charAt(1) != 1 && hour.charAt(1) != 2 && hour.charAt(1) != 3 && hour.charAt(1) != 4){
    			bTimeCheck = false;
    		}
    	}
    }
    
    if(min.length == 1){
    	min = '0' + min;
    }
    else{
    	if(Number(min) > 59){
    		bTimeCheck = false;
    	}
    }
    
    if(bTimeCheck == false) 
    { 
       //alert("시간을 잘못 입력하였습니다. 다시 입력해주세요.");
       $('#'+bindEleid).val('');
       return false;
    }
    else{
    	$('#'+bindEleid).val( hour + ":" + min );
    	$('#'+bindEleid).masked();
    }
    
   
}

/* 월일 시분 유효성 검사 */
function fnDateTimeVaildation(inputValue,bindEleId){
	var inputValue = $('#'+bindEleId).val();
	if(inputValue == ''){
		return false;	
	}
	
	var bCheck = true;
	var arrInfo = [];
	arrInfo = inputValue.split(' ');
	
	/* 날짜 유효성 시작 */
	var arrDate = [];
	arrDate = arrInfo[0].split('/');
    var nYear = Number(arrDate[0]);
    var nMonth = Number(arrDate[1]);
    var nDay = Number(arrDate[2]);

    if (nYear < 1900 || nYear > 3000)
    { // 사용가능 하지 않은 년도 체크
    	bCheck = false;
    }
    else{
    	if(arrDate[1].length == 1){
    		arrDate[1] = "0"+ arrDate[1];
    	}
    }

    if (nMonth < 1 || nMonth > 12)
    { // 사용가능 하지 않은 달 체크
    	bCheck = false;
    }else{
    	if(arrDate[2].length == 1){
    		arrDate[2] = "0"+ arrDate[2];
    	}
    }

    // 해당달의 마지막 일자 구하기
    var nMaxDay = new Date(new Date(nYear, nMonth, 1) - 86400000).getDate();
    if (nDay < 1 || nDay > nMaxDay)
    { // 사용가능 하지 않은 날자 체크
    	bCheck = false;
    }
	
	/* 시간 유효성 시작 */
	var arrTime = [];
	arrTime = arrInfo[1].split(':');
	var bTimeCheck = true;
    var hour = arrTime[0];
    var min = arrTime[1];
   
    if(hour.length == 1){
    	arrTime[0] = '0' + arrTime[0];
    }
    else{
    	if(hour.charAt(0) == 2){
    		if(hour.charAt(1) != 0 && hour.charAt(1) != 1 && hour.charAt(1) != 2 && hour.charAt(1) != 3 && hour.charAt(1) != 4){
    			bCheck = false;
    		}
    	}
    }
    
    if(min.length == 1){
    	arrTime[1] = '0' + arrTime[1];
    }
    else{
    	if(Number(min) > 59){
    		bCheck = false;
    	}
    }
    
    
    if(bCheck == false) 
    {        
       $('#'+bindEleid).val('');
       return false;
    }
    else{
    	$('#'+bindEleId).val( arrDate[0] + "/" + arrDate[1] + "/" + arrDate[2] + " " + arrTime[0]+ ":" + arrTime[1]);
    	$('#'+bindEleId).masked();
    }
	
	
	
}

/* 원천징수액 소득구분 팝업 */
function fnOpenIncomeGbnPop(){
	var resultList = [];
	
	fnSetGridHeaderIncomeGbn();
	
	resultList = fnGetIncomeGbnPop();
	
	fnMakeIncomeGbnCodeJson(resultList);	
	
	/*로직 완료 후 그리기*/
	$("#divResolAmtSubCodeHelperPop").css('display', 'block');

	/* uctable 코드팝업 그리드 헤더 생성*/
	$.devTable.createCodeHelper(headjson, 'divResolAmtSubCodePopLayer', '1', '350px', 'N');
	
	/* 데이터 바인드 */
	$.devTable.addrowCodeData(headjson, dataJson, '1', 'divResolAmtSubCodePopLayer');
	
	/* 코드도움창 키이벤트 등록 */
	fnLayerSubResolAmtCodePopKeyEvent(event,'divResolAmtSubCodePopLayer','hdnPopupData','',headjson,'1');

	//현재 팝업 더에터 저장
	$("#hdnPopupData").val(JSON.stringify(dataJson));
}


/* 팝업 내 레이어 팝업 띄우기 */
function fnLayerSubResolAmtCodePopKeyEvent (e, pLocationId, pCodePopDataId, pInputPopDataId, pHeadJsonData, pCodeTableType){

    //코드도움 테이블 명 저장
    var locationId = pLocationId + "_TABLE";
    
    //히든 코드 도움창 json 정보
    var jsonDataId = pCodePopDataId;
       
    //코드그리드헤더 정보
    var headJson = pHeadJsonData;
    
    //코드테이블 타입정보
    var codeTableType = pCodeTableType;
    
    //KEY EVENT DELETE
	$('.subResolAmtSearch').unbind();
	//$('.onSel').unbind();
	$('#'+locationId).unbind();
	
	
	//선택한 데이터에 대한  더블클릭 이벤트
	$('#divResolAmtSubCodePopLayer_TABLE').dblclick(function(){
		fnSubSelectRow();
	});
	
	//검색버튼
	$("#searchResolAmtSubButton").click(function(){
		fnSearchStr(jsonDataId, $(".subResolAmtSearch").val(),locationId, headJson, codeTableType);
	});
	
	 $('.subResolAmtSearch').unbind();
	//INPUT KEY EVET BIND(KEYDOWN)
	 $('.subResolAmtSearch').on('keydown',function(e ){
		switch(e.keyCode)
		{
			/* ENTER EVENT */
			case 13:
				fnSearchStr(jsonDataId, $(".subResolAmtSearch").val(),locationId, headJson, codeTableType);
				$("#" + locationId).find('TR').eq(0).click().focus();
				return false;
				break;
			/* LEFT ARROW EVENT */
			case 37 :
				break;
			/* UP ARROW EVENT */
			case 38:
				$("#" + locationId).find('.onSel').prev().click().focus();
				return false;
				break;
			/* RIGHT ARROW EVENT */
			case 39:
				
				break;
			/* DOWN ARROW EVENT */
			case 40:
				$("#" + locationId).find('.onSel').next().click().focus();
				return false;
				break;
				
			default :
				$('.subResolAmtSearch').focus();
				break;
		
		}
		
	});	
	
	 $("#" + locationId).unbind();
	 $("#" + locationId).on('keydown',function(e){
		 	switch(e.keyCode)
			{
				/* ENTER EVENT */
				case 13:
					fnSubSelectRow();
					return false;
					break;
				/* LEFT ARROW EVENT */
				case 37 :
					break;
				/* UP ARROW EVENT */
				case 38:
					$("#" + locationId).find('.onSel').prev().click().focus();
					return false;
					break;
				/* RIGHT ARROW EVENT */
				case 39:
					
					break;
				/* DOWN ARROW EVENT */
				case 40:
					$("#" + locationId).find('.onSel').next().click().focus();
					return false;
					break;
				case 27:
					//팝업닫기
					//레이어팝업 정보 초기화
					$("#divResolAmtSubCodeHelperPop").css('display', 'none');
					$("#"+pLocationId).empty();
					$("#txtResolAmtCodeSearch").val('');
					
					//KEY EVENT DELETE
					$('.subResolAmtSearch').unbind();
					$('.onSel').unbind();
					$('#'+locationId).unbind();		
					//$("#selTRCD").focus();
					break;
				default :
					$('.subResolAmtSearch').focus();
					break;
			}
		});
		
	
	//Search json Data on hidden json value
	function fnSearchStr(jsonDataId, searchStr, tableName, headJson, codeTableType){
		if(searchStr.length > 0){
			var data = $("#"+jsonDataId).val();
			var jsonArr = JSON.parse(data);
			var resultJsonArr = [];
			for(var i=0; i < jsonArr.length; i++){
				$.each(jsonArr[i], function(key,value){
					if(value.indexOf(searchStr) !== -1){
						resultJsonArr.push(jsonArr[i]);
					} 
				});
			}
			console.log(resultJsonArr);
			$("#"+tableName).empty();
			tableName= tableName.replace('_TABLE','');
			$.devTable.addrowCodeData(headJson, resultJsonArr, codeTableType ,tableName)
			
		}
		else{
			var data = $("#"+jsonDataId).val();
			var jsonArr = JSON.parse(data);
			$("#"+tableName).empty();
			console.log(jsonArr);
			tableName= tableName.replace('_TABLE','');
			$.devTable.addrowCodeData(headJson, jsonArr, codeTableType ,tableName)
		}
	}
	
	function fnSubSelectRow(){
		
		var eleSelect = $("#"+locationId).find('.onSel');
		var rowData = $(eleSelect).prop('data');
		var popInfo;
		
		//코드 밑 텍스트 매핑
		$("#txtIncomeGbnValue").val(rowData.CTD_NM);
		$("#txtIncomeGbnCode").val(rowData.CTD_CD);
		
		//필요경비율 입력
		if(rowData.CTD_CD == 62){
			$("#txtReqExpendRate").val('');
			$("#txtReqExpendRate").removeAttr('disabled');
			$("#txtReqExpendRate").removeAttr('readonly');
		}
		else if(rowData.CTD_CD == 71 || rowData.CTD_CD == 73 || rowData.CTD_CD == 74 || rowData.CTD_CD == 75 || rowData.CTD_CD == 76){
			$("#txtReqExpendRate").val('80');
			$("#txtReqExpendRate").prop('disabled','true');
			$("#txtReqExpendRate").prop('readonly','true');
		}
		else{
			$("#txtReqExpendRate").val('');
			$("#txtReqExpendRate").prop('disabled','true');
			$("#txtReqExpendRate").prop('readonly','true');
		}
		
		$("#txtReqExpendRate").focus();
		$("#txtReqExpendRate").click();
		
		//팝업닫기
		//레이어팝업 정보 초기화
		$("#divResolAmtSubCodeHelperPop").css('display', 'none');
		$("#"+pLocationId).empty();
		$("#txtResolAmtCodeSearch").val('');
		
		//KEY EVENT DELETE
		$('.subResolAmtSearch').unbind();
		$('.onSel').unbind();
		$('#'+locationId).unbind();		
			
	}
	
}

/* 원천징수액 소득구분 ajax */
function fnGetIncomeGbnPop(){
	var resultList = [];
	var params = {};
	var hdnInit = JSON.parse($("#hdnInitInfo").val());
	params.LANGKIND = 'KOR';
	params.CO_CD = hdnInit.CO_CD;
		
	$.ajax({
		async : false,
		type : "post",
		datatype : "json",
		data : params,
		url : '<c:url value="/expend/ez/user/EzbaroIncomeGbnSelect.do" />',
		datatype : "json",
		success : function(retValue) {
			resultList = retValue.result;
		},
		error : function(err) {
			console.log(err);
		}
	});	
	return resultList;
}


	/* =============================== 이지바로 스크립트 =============================== */
</script>



</head>
<!--  이지바로 로드시 사용자 정보 -->
<input type="hidden" id="hdnInitInfo" />
<!--  팝업 데이터 -->
<input type="hidden" id="hdnPopupData" />
<!--  팝업을 띄운 input 정보 -->
<input type="hidden" id="hdnInputPopupInfo" />
<!--  결의내용 그룹클래스 모음 정보 -->
<input type="hidden" id="hdnResolNoteInfo"/>

	<div class="pop_wrap brbn">
		<div class="pop_sign_head posi_re">
			<h1>Ezbaro 결의정보등록</h1>
			<div class="psh_btnbox">

				<div class="psh_right">
					<div class="btn_cen mt8">
						<input type="button" id="btnAppProcess" class="psh_btn" value="상신" />
						<input type="button" id="btnCodePop" class="psh_btn" value="공통코드 설정" />
					</div>
				</div>
			</div>
		</div>
		<div class="pop_con posi_re pb50">
			<div class="top_box ovh">
				<dl style="min-width: 980px;">
					<dt>회계단위</dt>
					<dd style="width: 25%;">
						<input type="text" id="txtAcctUnit" style="width: 90%;" /> 
					</dd>
					<dt>결의부서 / 작성자</dt>
					<dd style="width: 25%;">
						<input type="text" id="txtDeptUser" style="width: 90%;" />
					</dd>
					<dt>작성일</dt>
					<dd>
						<input id="txtWriteDate" value="" class="dpWid" />
					</dd>
				</dl>
			</div>
			<!-- 결의내역 ------------------------------------------------------------------------------------------------------------------------->
			<div class="clear">
				<p class="tit_p mt20 fl">결의내역</p>

				<div class="controll_btn pt15 fr">
					<button id="btnAddResolRow" tabindex="-1">추가</button>
					<button id="btnDeleteResolRow">삭제</button>
				</div>
			</div>

			<div id="resolveContent"></div>


			<!-- 상세내역 ------------------------------------------------------------------------------------------------------------------------->
			<div class="clear">
				<p class="tit_p mt20 fl">상세내역</p>
			</div>

			<div id="detailContent"></div>

			<!-- 결의내용 ------------------------------------------------------------------------------------------------------------------------->
			<p class="tit_p mt20">결의내용</p>
			<div>
				<textarea id='resolNote' name="" rows="8" class=".resolNote"
					style="padding: 5px; width: 98.8%; overflow: auto;"></textarea>
			</div>



			<!-- 품목상세 ------------------------------------------------------------------------------------------------------------------------->
			<div class="clear">
				<p class="tit_p mt20 fl">품목상세</p>

				<div class="controll_btn pt15 fr">
					<button id="btnDeleteItemDetail">삭제</button>
				</div>
			</div>

			<div id="itemDetailContent"></div>

		</div>
		<!--// pop_con -->

	</div>
	<!--// pop_wrap -->
	<!-- 입력팁 -->
	<div class="toolTipBox">
		<span id="txtHelpMsg">입력도우미</span>
	</div>


	<!-- 코드도움팝업 -->
	<div id="divCodeHelperPop" class='divTopPopup' style="display: none">
		<div class="modal posi_fix" style="z-index: 101"></div>

		<div class="pop_wrap_dir posi_ab"
			style="width: 516px; height: 528px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 102">
			<div class="pop_head">
				<h1>코드도움</h1>
				<a href="javascript:fnPopClose()" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
			</div>

			<div class="pop_con">
				<div class="top_box">
					<dl>
						<dt>검색</dt>
						<dd class="mr0" style="width: 85%;">
							<input type="text" id="txtCodeSearch" class="UCSearch"
								style="width: 85%; text-indent: 4px;" /> <input type="button"
								id="searchButton" value="검색" />
						</dd>
					</dl>
				</div>
				<div id='divCodePopLayer'></div>

			</div>
		</div>
	</div>
	
	
	<!-- 전자세금 계산서 코드도움팝업 -->
	<div id="divTaxCodeHelperPop" class='divTopPopup' style="display: none">
		<div class="modal posi_fix" style="z-index: 101"></div>

		<div class="pop_wrap_dir posi_ab" style="width:800px;height:607px;top:50%;left:50%;margin:-303px 0 0 -400px;z-index:102">
			<div class="pop_head">
				<h1>전자세금계산서 자료조회</h1>
				<a href="javascript:fnTaxPopClose()" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
			</div>

			  <div class="pop_con">
                <div id="divTaxCodeSelectZone" class="top_box">
                    <dl>
                        <dl>
                            <dd class="ml20" style="width:150px;">
                                <select id="selDTFG" class="selectmenu" style="width:148px;">
									<option value="1" selected="selected">작성일자</option>
									<option value="2">발행일자</option>
								</select>
                            </dd>
                            <dd>
                                <div class="dal_div">
                                    <input type="text" id="txtFRDT" value="2015-02-01" class="w113" />
                                    
                                </div>
                                ~
                                <div class="dal_div">
                                    <input type="text" id="txtTODT" value="2017-02-01" class="w113" />
                                </div>
                            </dd>
                            <dt class="ar" style="width: 94px;">세무구분</dt>
                            <dd style="width:150px;">
                                <select id="selTAXTY" class="selectmenu" style="width:148px;">
									<option value="2" selected="selected">과세</option>
									<option value="4">면세</option>
								</select>
                            </dd>
                            
                        </dl>

                        <dl class="next2">
                            <dt class="ar" style="width:145px;">매입거래처</dt>
                            <dd style="width:250px;">
                                <select id="selTRCD" class="selectmenu" style="width:222px;">
								</select>
                                <a href="#" class="fl btn_search" onClick="fnGetETaxPater()" ></a>
                            </dd>
                            <dt>세금계산서분류</dt>
                            <dd style="width:150px;">
                                <select id="selETAXTY" class="selectmenu" style="width:148px;">
									<option value="" selected="selected">전체</option>
									<option value="1">일반</option>
									<option value="2">수정</option>
								</select>
                            </dd>
                        </dl>
                    </dl>
                </div>
				<div id='divTaxCodePopLayer'></div>
				
				 <!-- 안내문구 -->
                <p class="text_blue f11 mt20">* <span id="">조회한 전자세금계산서가 없는 경우, ERP에서 자료수집을 실행해 주세요.</span></p>

			</div>
			
			<div class="pop_foot">
                <div class="btn_cen pt12">
                    <!--<input type="button" value="자료수집" />-->
                    <input type="button" onClick="fnGetEtaxDtaAjax()" value="조회(F8)" />
                </div>
            </div><!-- //pop_foot -->
            
		</div>
		
		<!-- 코드도움팝업 -->
		<div id="divTaxSubCodeHelperPop" class='divTopPopup' style="display: none">
			<div class="modal posi_fix" style="z-index: 103"></div>
	
			<div class="pop_wrap_dir posi_ab"
				style="width: 516px; height: 528px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 104">
				<div class="pop_head">
					<h1>코드도움</h1>
					<a href="javascript:fnResolPopClose()" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
				</div>
	
				<div class="pop_con">
					<div class="top_box">
						<dl>
							<dt>검색</dt>
							<dd class="mr0" style="width: 85%;">
								<input type="text" id="txtSubCodeSearch" class="subSearch"
									style="width: 85%; text-indent: 4px;" /> <input type="button"
									id="searchSubButton" value="검색" />
							</dd>
						</dl>
					</div>
					<div id='divTaxSubCodePopLayer'></div>
	
				</div>
			</div>
		</div>		
	</div>
	
	<!-- 원천징수액입력 -->
	<div id="divResolAmtCodeHelperPop" class ='divTopPopup' style="display:none">
		<!-- modal -->
		<div class="modal posi_fix" style="z-index:101"></div>

		<div class="pop_wrap_dir posi_ab" style="width:396px;height:425px;top:50%;left:50%;margin:-212px 0 0 -188px;z-index:102">
			<div class="pop_head">
				<h1>원천징수액 입력</h1>
				<a href="javascript:fnResolPopClose()" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
			</div>

			<div class="pop_con">
				<!-- 테이블 -->
				<div class="com_ta">
                    <table>
                        <colgroup>
                            <col width="120"/>
                            <col width=""/>
                        </colgroup>

                        <tr>
                            <th>소득구분</th>
                            <td class="le">                         
                                <input class="input_search fl" id="txtIncomeGbnCode" type="text" value="" style="width:42px;" readonly=""/>
					            <a href="javascript:fnOpenIncomeGbnPop()" class="btn_search fl"></a>
                                <input type="text" class="td_inp fl" style="margin-left: 28px;" id= "txtIncomeGbnValue" value="" readonly="">
                            </td>
                        </tr>
                        <tr>
                            <th>필요경비율</th>
                            <td class="le">
                                <input type="text" id="txtReqExpendRate" class="td_inp" style="width:36px;" value="">&nbsp;%
                            </td>
                        </tr>
                        <tr>
                            <th>필요경비금액</th>
                            <td class="le">
                                <input type="text" id="txtReqExpendAmt" class="td_inp ar pr5" style="width:175px;" value="">&nbsp;원
                            </td>
                        </tr>
                        <tr>
                            <th>소득금액</th>
                            <td class="le">
                                <input type="text" id="txtIncomeAmt" class="td_inp ar pr5" style="width:175px;" value="" readonly="">&nbsp;원
                            </td>
                        </tr>
                        <tr>
                            <th>소득세액</th>
                            <td class="le">
                                <input type="text" id="txtIncomeTax" class="td_inp ar pr5" style="width:175px;" value="">&nbsp;원
                            </td>
                        </tr>
                        <tr>
                            <th>주민세액</th>
                            <td class="le">
                                <input type="text" id="txtJuminTax" class="td_inp ar pr5" style="width:175px;" value="">&nbsp;원
                            </td>
                        </tr>
                        <tr>
                            <th>귀속년월</th>
                            <td class="le">
                                <input type="text" id="txtIncludeYM" class="td_inp" style="width:60px;" value="">
                            </td>
                        </tr>
                        <tr>
                            <th>신고귀속</th>
                            <td class="le">
                                <input type="text" id="txtSubmitYear" class="td_inp" style="width:42px;" value="" readonly="">
                            </td>
                        </tr>
                    </table>
				</div>
			</div><!--// pop_con -->

            <div class="pop_foot">
                <div class="btn_cen pt12">
                    <input type="button" id="btnSaveSubResolAmt" value="저장" />
                    <input type="button" id="btnCancelSubResolAmt"class="gray_btn" value="취소" />
                </div>
            </div><!-- //pop_foot -->
		</div><!--// pop_wrap -->
		
		
		<!-- 코드도움팝업 -->
		<div id="divResolAmtSubCodeHelperPop" class='divTopPopup' style="display: none">
		
			<div class="modal posi_fix" style="z-index: 103"></div>
	
			<div class="pop_wrap_dir posi_ab"
				style="width: 516px; height: 528px; top: 50%; left: 50%; margin: -264px 0 0 -258px; z-index: 104">
				<div class="pop_head">
					<h1>코드도움</h1>
					<a href="javascript:fnSubPopClose()" class="clo"><img src="../../../Images/btn/btn_pop_clo02.png" alt=""></a>
				</div>
	
				<div class="pop_con">
					<div class="top_box">
						<dl>
							<dt>검색</dt>
							<dd class="mr0" style="width: 85%;">
								<input type="text" id="txtResolAmtCodeSearch" class="subResolAmtSearch"
									style="width: 85%; text-indent: 4px;" /> <input type="button"
									id="searchResolAmtSubButton" value="검색" />
							</dd>
						</dl>
					</div>
					<div id='divResolAmtSubCodePopLayer'></div>
	
				</div>
			</div>
		</div>
		
	</div><!--// 코드도움팝업 -->

</html>