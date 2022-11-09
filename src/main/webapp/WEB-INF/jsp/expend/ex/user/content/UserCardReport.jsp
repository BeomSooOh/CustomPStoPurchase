<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!-- javascript - src -->
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>

<!--Excel다운로드를 위한 js-->
<script type="text/javascript" src='<c:url value="/js/t_excel/jszip-3.1.5.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/t_excel/FileSaver-1.2.2_1.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/t_excel/jexcel-1.0.4.js"></c:url>'></script>

<!-- 나의 카드 사용 현황 -->

<!-- javascript -->
<script>
	/* UserCardReport var */
	/* 현황 리스트 저장 변수 */
	var listData = {};
	
	/* document.ready */
	$(document).ready(function() {
		<c:if test="${ViewBag.empInfo.groupSeq == 'dev'}"> /* 개발버전인 경우 */
		debug = true;
		/* $('#btnDebugViewVar').show(); */
		/* setClick($('#btnDebugViewVar'), showLog); */
		</c:if>

		log('+ [UserCardReport] (document).ready');
		fnUserCardReportInit();
		fnUserCardReportEventInit();
		$('#btnSearch').click();
		log('- [UserCardReport] (document).ready');
	});

	/* fnUserCardReportInit */
	function fnUserCardReportInit() {
		log('+ [UserCardReport] fnUserCardReportInit');
		fnUserCardReportInitLayout();
		fnUserCardReportInitDatepicker();
		fnUserCardReportInitInput();
		fnUserCardReportInitButton();
		log('- [UserCardReport] fnUserCardReportInit');
	}
	/* fnUserCardReportInit - Layout */
	function fnUserCardReportInitLayout() {
		log('+ [UserCardReport] fnUserCardReportInitLayout');
		log('- [UserCardReport] fnUserCardReportInitLayout');
	}
	/* fnUserCardReportInit - Datepicker */
	function fnUserCardReportInitDatepicker() {
		log('+ [UserCardReport] fnUserCardReportInitDatepicker');
		/* class="datepicker" datepicker 정의 */
		setDatePicker($('.datepicker'));
		$('#txtReqDate').val(''); /* 지급요청일자는 기본값이 아니므로, 사용자 선택 사항 */
		fnInitDatePicker(1);
		log('- [UserCardReport] fnUserCardReportInitDatepicker');
	}
	
	/*	[데이트 피커] Initialrize date picker with gap
	----------------------------------------*/
	function fnInitDatePicker(monthGap) {

		// Object Date add prototype
		Date.prototype.ProcDate = function () {
			var yyyy = this.getFullYear().toString();
			var mm = (this.getMonth() + 1).toString(); //
			var dd = this.getDate().toString();
			return yyyy + '-' + (mm[1] ? mm : "0" + mm[0]) + '-'
					+ (dd[1] ? dd : "0" + dd[0]);
		};
		var toD = new Date();
		$('#txtReqDate').val(toD.ProcDate());
		
		if (toD.getMonth() == 0) {
			var fromD = new Date(toD.getFullYear() - 1, 11, toD.getDate());
		} else {
			var fromD = new Date(toD.getFullYear(), toD.getMonth() - monthGap,
					toD.getDate());
		}
		$('#txtFromDate').val(fromD.ProcDate());
	}
	
	/* fnUserCardReportInit - Input */
	function fnUserCardReportInitInput() {
		log('+ [UserCardReport] fnUserCardReportInitInput');
		$("#selShowCount").selectmenu({change: function(){
			$('select[name=tblUserCardReport_length]').val($('#selShowCount').val());
			$('select[name=tblUserCardReport_length]').trigger('change');
		}});
		log('- [UserCardReport] fnUserCardReportInitInput');
	}
	/* fnUserCardReportInit - Button */
	function fnUserCardReportInitButton() {
		log('+ [UserCardReport] fnUserCardReportInitButton');
		$("#btnExcelDown").click(function(){
			fnAdminCardReportExcelDown();
		});
		log('- [UserCardReport] fnUserCardReportInitButton');
	}

	/* fnUserCardReportEventInit */
	function fnUserCardReportEventInit() {
		log('+ [UserCardReport] fnUserCardReportEventInit');
		fnUserCardReportEventInitButton();
		fnUserCardReportEventInitInput();
		log('- [UserCardReport] fnUserCardReportEventInit');
	}
	/* fnUserCardReportEventInit - Button */
	function fnUserCardReportEventInitButton() {
		log('+ [UserCardReport] fnUserCardReportEventInitButton');
		setClick($(eventTarget.search), function() {
			fnUserCardReportSearch();
		});
		log('- [UserCardReport] fnUserCardReportEventInitButton');
	}
	/* fnUserCardReportEventInit - Input */
	function fnUserCardReportEventInitInput() {
		log('+ [UserCardReport] fnUserCardReportEventInitInput');
		fnSetEventKeydown();
		log('- [UserCardReport] fnUserCardReportEventInitInput');
	}
	
	/* fnSetEventKeydown - elements keydown event */
	function fnSetEventKeydown(){
		$('.enter').keydown(function(){
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#btnSearch').click();
            }
		});
	}
	
	
	function fnGetParam(){
		var param = {
				fromDate : ($('#txtFromDate').val().toString().replace(/-/g, '') || ''), /* 승인일자 */
				toDate : ($('#txtToDate').val().toString().replace(/-/g, '') || ''), /* 승인일자 */
				cardNum : ($('#txtCardNum').val().toString().replace(/-/g, '') || ''), /* 문서번호 */
				mercName : ($('#txtMercName').val().toString().replace(/-/g, '') || ''), /* 거래처명 */
				cardName : ($('#txtCardName').val().toString().replace(/-/g, '') || ''), /* 카드명 */
				compSeq : "${ViewBag.compSeq}",
				empSeq : "${ViewBag.empSeq}",
				docSts: $('#selDocSts').val()
			};
		
		if(param.fromDate){
			// 일자 검증 처리 필요.
		}if(param.toDate){
			// 일자 검증 처리 필요.
		}
		return param;
	}
	
	/* 카드 사용내역 조회 / 서버 호출 */
	function fnUserCardReportSearch() {
		var param = fnGetParam();
		if(!param){
			return;
		}
		
		/*
		  # 푸딩 UI sortable 기능 적용방법 by Kwon Oh Gwang on 2019-01-23
		  1)serverPaging을 true로 설정한다.
		    - true로 설정해야 헤더(제목) 클릭시 [조회url]을 호출할 수 있다.
		    - true로 설정 시 UI에서 페이징 처리가 안되므로 서버에서 페이징 처리를 해야한다.
		  2)sortable을 true로 설정한다.
		    - 헤더(제목) 클릭으로 인한 url 호출 시 sortField(컬럼), sortType(정렬방법)이 함께 파라미터로 전달된다.
		    - sortField는 columns의 field에 지정한 값이 저장된다.
		    - 쿼리 조회시 sortField, sortType로 재정렬해서 값을 반환한다. ex) ORDER BY ${sortField} ${sortType}
		*/
		
		//TODO : Oracle 테스트 서버가 없어 오라클 쿼리는 추후 수정해야함. by Kwon Oh Gwang on 2019-01-24
		var gridDataSource = new Pudd.Data.DataSource({
			pageSize : 10
		  , serverPaging : true //true 설정되어야 sortable 기능을 사용할 수 있음
		  , request : {
			  url : '<c:url value="/expend/ex/user/ExUserCardReportListInfoSelect.do" />'
			, type : 'post'
			, dataType : "json"
			, parameterMapping : function( data ) {
				data.fromDate = param.fromDate; /* 승인일자 */
				data.toDate = param.toDate; /* 승인일자 */
				data.cardNum = param.cardNum; /* 문서번호 */
				data.mercName = param.mercName; /* 거래처명 */
				data.cardName = param.cardName; /* 카드명 */
				data.compSeq = param.compSeq;
				data.empSeq = param.empSeq;
				data.docSts = param.docSts;
			  }
			}
		  ,	result : {
			  data : function( response ) {
			  	return response.result.aData.list;
			  }
		    , totalCount : function( response ) {
		    	$("#valTotalCount").text(response.result.aData.totalCount);
		    	return response.result.aData.totalCount;
			}
			, error : function( response ) {
				console.log("! [EX] ERROR - " + JSON.stringify(response));
			  }
			}
		});
		
		fnSetCardSetGrid(gridDataSource);
    	listData = gridDataSource.read();
	}
	
	/*	[뷰-그리드] 법인카드 사용내역 출력
 	--------------------------------------*/
	function fnSetCardSetGrid(gridDataSource){
		Pudd("#tblUserCardReport").puddGrid({
			dataSource : gridDataSource //그리드에 표시할 데이터
		  ,	scrollable : false //그리드 오른쪽 스크롤 여부
		  ,	sortable : true //그리드 상단 제목 클릭 시 정렬여부
		  ,	pageable : { //그리드 하단 페이징 여부
				buttonCount : 10
			,	pageList : [ 10, 20, 30, 40, 50 ]
			}
		  ,	resizable : true //그리드 상단 제목 리사이즈 여부
		  ,	ellipsis : false //그리드 내 데이터 말줄임 사용여부
		  ,	columns : [
				{
					field : "authDate"
				  ,	title : "${CL.ex_dateOfApproval}"
				  ,	width : 100
				  , content : {
					  template : function(rowData) {
						  var date = rowData.authDate || '';
						  var time = rowData.authTime || '';

						  return date.toString().replace(/^(\d{4})(\d{2})(\d{2})$/, '$1-$2-$3')
							   + ' '
							   + time.toString().replace(/^(\d{2})(\d{2})(\d{2})$/, '$1:$2:$3');
					  }
				  }
				}
			  ,	{
					field : "mercName"
				  ,	title : "${CL.ex_whereUsed}"
				  ,	width : 100
				  , content : {
					  template : function(rowData){

						var mercName = rowData.mercName || '';
						var mercSaupNo = rowData.mercSaupNo || '';

						if(!(mercSaupNo == '')){
							mercSaupNo = mercSaupNo.toString().replace(/^(\d{3})(\d{2})(\d{5})$/, '$1-$2-$3');
							return mercName + '<br />[' + mercSaupNo + ']';
						} else {
							return mercName;
						}
					  }
				  }
				}
			  ,	{ 
					field : "cardName"
				,	title : "${CL.ex_theNameOfCard}"
				,	width : 100
				}
			  ,	{
					field : "cardNum"
				  ,	title : "${CL.ex_creditCardNumber}"
				  ,	width : 100
				  , content : {
					  template : function(rowData) {
						  var cardNum = rowData.cardNum || '-';
						  return cardNum.toString().replace(/\B(?=(\d{4})+(?!\d))/g, '-');
					  }
				  }
				}
			  ,	{
					field : "requestAmount"
				  ,	title : "${CL.ex_totalAmount}"
				  ,	width : 100
				  , content : {
					  template : function(rowData) {
						  // 승인 / 취소 구분
						  var signCorrection = (rowData.georaeStat == '1' || rowData.georaeStat == 'N') ? 1
									         : (parseInt(rowData.requestAmount) < 1 ? 1
											 : -1);
						  var signClass = (rowData.georaeStat == '1' || rowData.georaeStat == 'N') ? ''
									    : 'text_red';
						  
						  var subSignCorrection = 1;
							
							if (signCorrection < 0 && parseInt(rowData.vatMdAmount) < 0){
								subSignCorrection = -1;
							}

						  // 금액 처리 준비
					      var requestAmount = rowData.requestAmount || '0';
					      var vatMdAmount = rowData.vatMdAmount || '0';
					      var amtMdAmount = rowData.amtMdAmount || '0';

						  // 승인/취소에 따른 부호 보정
						  requestAmount = parseInt(requestAmount) * signCorrection;
						  vatMdAmount = parseInt(vatMdAmount) * signCorrection * subSignCorrection;
						  amtMdAmount = parseInt(amtMdAmount) * signCorrection * subSignCorrection;

						  // 데이터 포멧 정규화
						  requestAmount = requestAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						  vatMdAmount = vatMdAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
						  amtMdAmount = amtMdAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');

						  return '<strong><span class="'+signClass+'">'
								+ requestAmount
								+ '</span></strong><br>'
								+ '<span class="'+signClass+'">'
								+ vatMdAmount
								+ '</span><br>'
								+ '<span class="'+signClass+'">'
								+ amtMdAmount
								+ '</span><br>';
					  },	
				      attributes : { style : "text-align:right;padding-right:5px;" }
				  }
				}
			  ,	{
					field : "serAmount"
				  ,	title : "${CL.ex_serviceAmount}"
				  ,	width : 100
				  , content : {
					  template : function(rowData) {
						  return rowData.serAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
					  },	
				      attributes : { style : "text-align:right;padding-right:5px;" }
				  }
				}
			  ,	{
					field : "authNum"
				  ,	title : "${CL.ex_confirmationNumber}"
				  ,	width : 100
				}
			  ,	{
					field : "docNo"
				  ,	title : "${CL.ex_documentNumber}"
				  ,	width : 100
				  , content : {
					  template : function(rowData) {
						  if(rowData.docDocSts == '10'){
							  return (rowData.docNo + '['+rowData.docUserNm+']') || '-';	
						  }else{
							  return rowData.docNo || '-';
						  }
					  }
				  }
				}
			  ,	{
					field : "expendRowId"
				  ,	title : "${CL.ex_automaticSlipNumber}"
				  ,	width : 100
				  , content : {
					  template : function(rowData) {
						  if( (rowData.inDt + rowData.inSq ).toString() == '0'){
							  return rowData.expendRowId || '';	
						  }else{
							  return rowData.expendRowId || ( rowData.inDt + rowData.inSq) ;
						  }
					  }
				  }
				}
			  ,	{
					field : "approvedAndCancel"
				  ,	title : "<%=BizboxAMessage.getMessage("TX000000798","승인/취소 구분")%>"
				  ,	width : 100
				  , sortable : false	
				  , content : {
					  template : function(rowData) {
						  if (rowData.georaeStat == '1' || rowData.georaeStat == 'N') {
							  return '<span class="">'+"${CL.ex_approved}"+'</span>';
						  } else {
							  return '<span class="text_red">'+"${CL.ex_cancel}"+'</span>';
						  }
					  }
				  }
				}
			]
		  ,	progressBar : {
				progressType : "loading"
			  ,	attributes : { style:"width:70px; height:70px;" }
			  ,	strokeColor : "#84c9ff"	// progress 색상
			  ,	strokeWidth : "3px"	// progress 두께
			  ,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
			  ,	percentTextColor : "#84c9ff"
			  ,	percentTextSize : "12px"
		 
			  	// 배경 layer 설정 - progressType loading 인 경우만
			  ,	backgroundLayerAttributes : { style : "background-color:#fff;filter:alpha(opacity=0);opacity:0;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
			}
		  ,	noDataMessage : {
				message : "데이터가 없습니다."
			}
		});
		
		var puddGrid = Pudd("#tblUserCardReport").getPuddObject();
		
		if('${ViewBag.g20YN}' != 'N'){
			puddGrid.hideColumn("docNo");
			puddGrid.hideColumn("expendRowId");
			puddGrid.hideColumn("approvedAndCancel");
		}
		
		Pudd("#tblUserCardReport").on( "gridRowDblClick", function(e) {
			var evntVal = e.detail;
			 
			if( ! evntVal ) return;
			if( ! evntVal.trObj ) return;
		 
			// dataSource에서 전달된 row data
			var rowData = evntVal.trObj.rowData;
			
			if (rowData.docNo) {
				fnAppdocPop(rowData);
			}
		});
	}
	
	/* function - fnAppdocPop */
	function fnAppdocPop(aData) {
		var docSeq, formSeq;
		docSeq = aData.docId;
		formSeq = aData.formFormSeq;
		
		var intWidth = '900';
		var intHeight = screen.height - 100;
		var agt = navigator.userAgent.toLowerCase();

		if (agt.indexOf("safari") != -1) {
			intHeight = intHeight - 70;
		}

		var intLeft = screen.width / 2 - intWidth / 2;
		var intTop = screen.height / 2 - intHeight / 2 - 40;

		if (agt.indexOf("safari") != -1) {
			intTop = intTop - 30;
		}

		var url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq + "&form_id=" + formSeq ;
		window.open(url, 'AppDoc', 'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
	}  	
	
	
	/*	[서버 호출] 법인카드 사용내역 데이터 Excel 다운로드
 	--------------------------------------*/
	function fnAdminCardReportExcelDown(){
		
		if( !listData || listData.length == undefined || listData.length == 0){
			alert('${CL.ex_dataDoNotExists}');
			return false;
		}
		
		var puddGrid = Pudd("#tblUserCardReport").getPuddObject();
		
		/* 새로운 ProgressBar 추가 - 2018.08.31 .yw */
		Pudd( "#loadingProgressBar" ).puddProgressBar({

				progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }

			,	strokeColor : "#84c9ff"	// progress 색상
			,	strokeWidth : "3px"	// progress 두께

			,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
			,	percentTextColor : "#84c9ff"
			,	percentTextSize : "12px"

			// 내부적으로 timeout 으로 아래 함수를 호출함. 시간은 100 milliseconds
			,	progressStartCallback : function( progressBarObj ) {

					// dataSource를 통한 data 연동
					var sourceData = new Pudd.Data.DataSource({

						pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
					,	serverPaging : true
					,	request : {
							url : '/exp/ex/user/CommonNewExcelDown.do'
						,	type : 'post'
						,	dataType : "json"
						,	contentType : "application/json; charset=utf-8"
						,	jsonStringify : true
						,	parameterMapping : function( data ) {
								
								data.fromDate = ($('#txtFromDate').val().replace(/-/gi,'') || '');
								data.toDate = ($('#txtToDate').val().replace(/-/gi,'') || ''); /* 승인일자 */
								data.cardNum = ($('#txtCardNum').val().replace(/-/gi,'') || '');
								data.mercName = ($('#txtMercName').val() || ''); /* 사용처  */
								data.cardName = ($('#txtCardName').val().replace(/-/gi,'') || '');
							    data.docSts = $('#selDocSts').val();
								data.fileName = '카드사용현황';		
								data.pageTotalSize = puddGrid.optObject.dataSource.totalCount;//나의 카드 사용현황 총 갯수			
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
								alert( "error - Pudd.Data.DataSource.read, status code - " + response.status );
							}
						}
					});

					//data read Start
					sourceData.read();

					var totalCount = sourceData.totalCount;
					var dataPage = sourceData.dataPage;
					
					if( totalCount ) {
						
						downloadExcelProcess( dataPage, totalCount );
						
						// loading progressBar 종료처리
						progressBarObj.clearIntervalSet();
						
					}else {
						// loading progressBar 종료처리
						progressBarObj.clearIntervalSet();
						alert("${CL.ex_dataDoNotExists}");
						
					}
					
				}
			});	

	}

	function downloadExcelProcess( dataPage, totalCount ) {

		var excel = new JExcel("맑은 고딕 11 #333333");
		excel.set( { sheet : 0, value : "지출결의확인Sheet" } );

		//헤더 컬럼 세팅
		var headers = [ "${CL.ex_dateOfApproval}"
			, "${CL.ex_dateAndTimeOfApproval}"
			, "${CL.ex_vendorName}"
			, "${CL.ex_corporateRegistrationNumber}"
			, "${CL.ex_theNameOfCard}"
			, "${CL.ex_creditCardNumber}"
			, "${CL.ex_amount}"
			, "${CL.ex_serviceAmount}"
			, "${CL.ex_purchasePrice}"
			, "${CL.ex_vat}"
			, "${CL.ex_confirmationNumber}"
			, "${CL.ex_documentNumber}"
			, "${CL.ex_theNumberOfBill}"
			, "${CL.ex_cancelAuthorization}"
			, "결의상태"];		
		
		var formatHeader = excel.addStyle({
			border: "thin,thin,thin,thin #000000",
			font: "맑은 고딕 11 #333333 B",// U : underline, B : bold, I : Italic
			fill: "#dedede",
			align : "C"
		});

		for( var i=0; i<headers.length; i++ ) {
			excel.set( 0, i, 0, headers[i], formatHeader );// sheet번호, column, row, value, style
			// excel.set( 0, i, undefined, "15" ); // sheet번호, column, row, value(width)
			excel.setColumnWidth( 0, i, "15" ); // sheet번호, column, value(width)
		}
		//엑셀 순번 컬럼 사이즈 작게
		excel.set( 0, 0, undefined, "8" ); // sheet번호, column, row, value(width)
		for( var i=1; i<=totalCount; i++ ) {

			var idx = i-1;
			
			var resolution = '결의';
			if (dataPage[ idx ][ "authYn" ] =="N"){
				resolution = '미결의'
			}
			
			excel.set( 0, 0, i, dataPage[ idx ][ "excelAuthDate" ] );
			excel.set( 0, 1, i, dataPage[ idx ][ "excelAuthTime" ] );
			excel.set( 0, 2, i, dataPage[ idx ][ "mercName" ] );
			excel.set( 0, 3, i, dataPage[ idx ][ "mercSaupNo" ] );
			excel.set( 0, 4, i, dataPage[ idx ][ "cardName" ] );
			excel.set( 0, 5, i, dataPage[ idx ][ "cardNum" ] );
			excel.set( 0, 6, i, dataPage[ idx ][ "excelRequestAmount" ] );
			excel.set( 0, 7, i, dataPage[ idx ][ "excelSerAmount" ] );
			excel.set( 0, 8, i, dataPage[ idx ][ "excelAmtMdAmount" ] );
			excel.set( 0, 9, i, dataPage[ idx ][ "excelVatMdAmount" ] );
			excel.set( 0, 10, i, dataPage[ idx ][ "authNum" ] );
			excel.set( 0, 11, i, dataPage[ idx ][ "docNo" ] );
			excel.set( 0, 12, i, dataPage[ idx ][ "expendDocNm" ] );
			excel.set( 0, 13, i, dataPage[ idx ][ "georaeStatName" ] );
			excel.set( 0, 14, i, resolution );
		}
		excel.generate( "카드사용현황.xlsx" );
		// END ---------------------------------------------------------------------------------------- excel 설정
	}
</script>

<!-- hidden -->
<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="fromDate" value="" id="fromDate"/>
	<input type="hidden" name=toDate value="" id="toDate"/>
	<input type="hidden" name="searchCardNum" value="" id="searchCardNum"/>
	<input type="hidden" name="mercName" value="" id="mercName"/>
	<input type="hidden" name="docSts" value="" id="docSts"/>
	<input type="hidden" name="excelHeader" value="" id="excelHeader"/>
	<input type="hidden" name="fileName" value="" id="fileName">
</form>
<!-- body -->
<!-- iframe wrap -->
<div class="iframe_wrap">
	<div class="sub_contents_wrap">
		<!-- 컨트롤박스 -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_dateOfApproval}</dt>
				<dd>
					<input id="txtFromDate" value="" class="dpWid datepicker enter" />
					~ <input id="txtToDate" value="" class="dpWid datepicker enter" />
				</dd>
				<dt>${CL.ex_resCondition}</dt>
				<dd>
					<SELECT id="selDocSts" class="selectmenu" style="width: 60px;">
						<OPTION VALUE="">${CL.ex_all}</OPTION>	
						<OPTION VALUE="1">${CL.ex_res}</OPTION>
						<OPTION VALUE="0">${CL.ex_noRes}</OPTION>
					</SELECT>
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="${CL.ex_search}" />
				</dd>
			</dl>
			<span class="btn_Detail">${CL.ex_advancedSearch} <img id="all_menu_btn"
				src='../../../Images/ico/ico_btn_arr_down01.png' /></span>
		</div>
		<!-- 상세검색박스 -->
		<div class="SearchDetail">
			<dl>
				<dt style="width: 60px;">${CL.ex_creditCardNumber}</dt>
				<dd class="mr5">
					<input id="txtCardNum" type="text" value="" style="width: 300px"
						class="enter">
				</dd>
				<dt style="width: 60px;">${CL.ex_theNameOfCard}</dt>
				<dd class="mr5">
					<input id="txtCardName" type="text" value="" style="width: 300px"
						class="enter">
				</dd>
				<dt style="width: 60px;">${CL.ex_whereUsed}</dt>
				<dd class="mr5">
					<input id="txtMercName" type="text" value="" style="width: 300px"
						class="enter">
				</dd>
			</dl>
		</div>
		<!-- <div id="" class="controll_btn cl"><button id="" class="k-button">상신</button></div> -->
		<div id="" class="controll_btn cl">
			<span class="fwb mt5" style="text-align:left;float:left">총 <span id="valTotalCount">0</span> 건</span>
			<button id="btnExcelDown">${CL.ex_excelDownload}</button>
		</div>
		<!-- 그리드 -->
		<div id="tblUserCardReport"></div>
	</div>
	<!-- //sub_contents_wrap -->
	<div id="loadingProgressBar"></div>
</div>
<!-- iframe wrap -->