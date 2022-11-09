<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript"
	src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<link rel="stylesheet" type="text/css"
	href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/pudd/pudd-1.0.4.min.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>

<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />


<!--Excel다운로드를 위한 js-->
<script type="text/javascript"
	src='<c:url value="/js/t_excel/jszip-3.1.5.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/t_excel/FileSaver-1.2.2_1.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/t_excel/jexcel-1.0.4.js"></c:url>'></script>

<script type="text/javascript"
	src='<c:url value="/js/pudd/pudd-1.1.79.min.js"></c:url>'></script>


<body>
	<div class="pop_con">

		<!-- 예산 테이블 -->
		<div class="com_ta4">
			<table>
				<thead>
					<tr>
						<th>${CL.ex_budgetYear}<!-- 예산년도 --></th>
						<th>${CL.ex_budgetAccountCode}<!-- 예산계정코드 --></th>
						<th>${CL.ex_accNm}<!-- 예산계정명 --></th>
						<th>${CL.ex_noSendExpendAmt}<!-- 미전송결의 합계 --></th>
						<th>${CL.ex_SendExpendAmt}<!-- 전송결의 합계 --></th>
						<!-- <th>잔여금액 합계</th> -->
					</tr>
				</thead>
				<tbody id="tbl_totalGrid">
					<tr>
						<td>${params.yyBudget}</td>
						<td>${params.acctCd}</td>
						<td id="gAcctNm">${params.acctNm}</td>
						<%-- <td id="gAmExp" class="ri">${params.amExp}</td> --%>
						<td id="gAmExp" class="ri"></td>
						<td id="sAmExp" class="ri"></td>
						<%-- <td id="" class="ri">${params.amLeave}</td> --%>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="mt10"></div>
		
		<!-- 탭 -->
		<div class="tab_nor">
			<a href="#n" class="pre"></a>
			<ul>
				<li class="on"><a href="javascript:tab_nor_Fn(1);">
				<span class="txt">${CL.ex_notTransRes} <!--미전송 결의--></span></a></li>
				
				<li ><a href="javascript:tab_nor_Fn(2)">
				<span class="txt"> ${CL.ex_transRes} <!--전송 결의--></span></a></li>
			</ul>
			<a href="#n" class="nex"></a>

		</div>

		<!-- 검색 -->
		<div class="top_box mt14">
			<dl>
				<dt>${CL.ex_keyWord}
					<!--검색어-->
				</dt>
				<dd>
					<select id="docSerch"class="selectmenu" style="width: 100px;">
						<option value="0">${CL.ex_all}</option>
						<option value="1">${CL.ex_docNm}</option>
						<option value="2">${CL.ex_docTitle}</option>
					</select>
					<input type="text" style="width: 400px;" class="puddSetup enter" id="txt_serchStr" />
				</dd>
				<dt>${CL.ex_appCondition}
					<!--결재상태-->
				</dt> 
				<dd>
					<select id="sel_docStatus" class="selectmenu" style="width: 100px;">
						<option value="" selected="selected">${CL.ex_all}<!--전체--></option>
						<option value="10">${CL.ex_temporarySave}  <!--임시저장--></option>
						<option value="20">${CL.ex_requestApproval}<!-- 상신 --></option>
						<option value="30">${CL.ex_Progress}<!-- 진행 --></option>
						<option value="40">${CL.ex_outTermination}<!-- 발신종결 --></option>
						<option value="50">${CL.ex_recePtion}<!-- 수신상신 --></option>
						<option value="60">${CL.ex_recePtionProgress}<!-- 수신진행 --></option>
						<option value="70">${CL.ex_rejecTion}<!-- 수신반려 --></option>
						<option value="80">${CL.ex_acknowledGment}</option>
						<option value="90">${CL.ex_closing}<!-- 종결 --></option>
						<option value="110">${CL.ex_hold}<!-- 보류 --></option>
					</select>
				</dd>
				<dd>
					<input type="button" class="puddSetup submit"
						value="${CL.ex_search}" id="btn_serchData" />
					<!--검색-->
				</dd>
			</dl>
		</div>

		<div class="tab_area">
			<!-- 미전송결의 -->
			<div class="tab1">
				<div class="btn_div cl">
					<div class="left_div fwb mt7">
						${CL.ex_yeCount}<!-- 총 --> <span id="txt_nonSendItemCnt"></span> ${CL.ex_yeCase}<!-- 건 -->
					</div>
					<div class="controll_btn p0">
						<div class="right_div mt7">${CL.ex_notTransResAmt}
							<!--미전송 결의 금액 ${params.amExp} -->
							<span id="txt_nonSendResAmt"></span>원
							<button id="" class="k-button btnExcelDown">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
						</div>
					</div>
				</div>


				<div class="com_ta2">
					<table>
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<thead>
							<tr>
								<th>${CL.ex_docNm}<!--문서번호--></th>
								<th>${CL.ex_docTitle}<!--문서제목--></th>
								<th>${CL.ex_draftDate}<!--기안일자--></th>
								<th>${CL.ex_draftDept}<!--기안부서--></th>
								<th>${CL.ex_drafter}<!--기안자--></th>
								<th>${CL.ex_appCondition}<!--결재상태--></th>
								<th>${CL.ex_amtOfResolution}<!--결의금액--></th>
							</tr>
						</thead>
					</table>
				</div>

				<div class="com_ta2 ova_sc cursor_p bg_lightgray" style="height: 344px;">
					<table>
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<tbody id="tbl_nonSendContents">
						</tbody>
					</table>
				</div>
			</div>

			<!-- 전송결의 -->
			<div class="tab2" style="display: none;">
				<div class="btn_div cl">
					<div class="left_div fwb mt7">
						${CL.ex_yeCount}<!-- 총 --> <span id="txt_sendItemCnt"></span> ${CL.ex_yeCase}<!-- 건 -->
					</div>
					<div class="controll_btn p0">
						<div class="right_div mt7">${CL.ex_transResAmt}
							<!--전송 결의 금액-->
							<span id="txt_sendResAmt"></span>원
							<button id="" class="k-button btnExcelDown">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
						</div>
					</div>
				</div>
				<div class="com_ta2">
					<table>
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
						</colgroup>
						<thead>
							<tr>
								<th>${CL.ex_docNm}<!--문서번호--></th>
								<th>${CL.ex_docTitle}<!--문서제목--></th>
								<th>${CL.ex_draftDate}<!--기안일자--></th>
								<th>${CL.ex_draftDept}<!--기안부서--></th>
								<th>${CL.ex_drafter}<!--기안자--></th>
								<th>${CL.ex_appCondition}<!--결재상태--></th>
								<th>${CL.ex_amtOfResolution}<!--결의금액--></th>
							</tr>
						</thead>
					</table>
				</div>

				<div class="com_ta2 ova_sc cursor_p bg_lightgray" style="height: 344px;">
					<table>
						<colgroup>
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" />
							<col width="" /> 
							<col width="" />
							<col width="" />
						</colgroup>
						<tbody id="tbl_sendContents">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
		<div id="loadingProgressBar"></div>
	
</body>



<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="fileName" value="" id="fileName" /> 
	<input type="hidden" name="excelHeader" value="" id="excelHeader" /> 
	<input type="hidden" name="docSts" value="" id="docSts" />
	<input type="hidden" name="docNo" value="" id="docNo" /> 
	<input type="hidden" name="budgetDate" value="" id="budgetDate" /> 
	<input type="hidden" name="acctCd" value="" id="acctCd" /> 
	<input type="hidden" name="budgetCd" value="" id="budgetCd" /> 
	<input type="hidden" name="bizplanCd" value="" id="bizplanCd" /> 
</form>



</html>


<script>

	var gAcctNm = decodeURI('${params.acctNm}');
	//var gAmExp = '${params.amExp}';
	var gAmLeave = '${params.amLeave}';
	
	/*	스크립트 준비
	-------------------------------------- */
	/* ${params} */
	$(document).ready(function() {
		
		$('#gAcctNm').text(gAcctNm);
		$('#gAmLeave').text(fnGetCurrencyCode(gAmLeave));
		
		/* 돔 객체 초기화 */
		fnSetElementIntit();

		/* 메인정보 서버 호출 */
		fnGetResListInfo();
		
	});
	
	/*	[GRID] 금액 통화코드 생성
	--------------------------------------------------*/
	function fnGetCurrencyCode(value){
		value = (value || '0');
		value = value.toString().replace(/,/g, '').split(' ').join('');
		value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return value;
	}

	/*	[초기화] 돔객체 초기화
	-------------------------------------- */
	function fnSetElementIntit() {

		/* 엑셀 다운로드 */
		$('.btnExcelDown').click(function() {
			fnAdminReportExcelDown();
		});
		
		/* 예산 정보 조회 */
		$('#btn_serchData').click(function() {
			fnGetResListInfo();
		});

		// 엔터 검색
		$('.enter').keydown(function(event) {
			if (event.keyCode === 13) {
				event.returnValue = false;
				event.cancelBubble = true;
				fnGetResListInfo();
			}
		});
	}
	
	 /*	[ 엑셀 ] 예실대비현황
	--------------------------------------
	function fnAdminReportExcelDown() {
		if(!yesilListCnt){
			alert("데이터가 없습니다.");
			return;
		}
		var param = {};	
		
		var budgetDate = new Date('${params.erpGisuFromDate}');
		var budgetDateList = [];
		var sendYn = "";
			
		for(var i = 0; i < 12; i ++) {
				budgetDateList.push([budgetDate.getFullYear(), budgetDate.getMonth() + 1 < 10 ? '0' + (budgetDate.getMonth() + 1) : budgetDate.getMonth() + 1].join(''));
				budgetDate.setMonth(budgetDate.getMonth() + 1)
			}
			
		budgetDateList = "'" + budgetDateList.join("', '") + "'"

	
		var excelHeader = {};
		excelHeader.docNo= "문서번호";
		excelHeader.docTitle= "문서제목";
		excelHeader.repDt = "기안일자";
		excelHeader.deptName= "기안부서";		
		excelHeader.empName= "기안자";		
		excelHeader.amt= "결의금액"; 

		$("#excelHeader").val( JSON.stringify(excelHeader) );
		var url = "<c:url value='/ex/admin/CommonNewExcelDown.do'/>";
		excelDownload.type = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}*/
	 
	 
	 function fnAdminReportExcelDown(){
		/* if(!yesilListCnt){
			alert("데이터가 없습니다.");
			return;			
		} */
		
		var budgetDate = new Date('${params.erpGisuFromDate}');
		var budgetDateList = [];
		var sendYn = "";
			
		for(var i = 0; i < 12; i ++) {
				budgetDateList.push([budgetDate.getFullYear(), budgetDate.getMonth() + 1 < 10 ? '0' + (budgetDate.getMonth() + 1) : budgetDate.getMonth() + 1].join(''));
				budgetDate.setMonth(budgetDate.getMonth() + 1)
			}
			
		budgetDateList = "'" + budgetDateList.join("', '") + "'"
		
		Pudd( "#loadingProgressBar" ).puddProgressBar({
			progressType : "loading"
			,	attributes : { style:"width:70px; height:70px;" }
			,	strokeColor : "#84c9ff"	// progress 색상
			,	strokeWidth : "3px"	// progress 두께
			,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
			,	percentTextColor : "#84c9ff"
			,	percentTextSize : "12px"
			
				,	progressStartCallback : function( progressBarObj ) {

					// dataSource를 통한 data 연동
					var sourceData = new Pudd.Data.DataSource({

						request : {
							url : '<c:url value="/ex/admin/CommonNewExcelDown.do" />'
						,	type : 'post'
						,	dataType : "json"
						,	contentType : "application/json; charset=utf-8"
						,	jsonStringify : true
						,	parameterMapping : function( data ) {
							
							data.docSts = ($("#sel_docStatus").val() || ''); 
							if( $('#docSerch').val() == '1'){
								data.docNo = ($('#txt_serchStr').val().toString() || '');
							}else if( $('#docSerch').val() == '2'){
								data.docTitle = ($('#txt_serchStr').val().toString() || '');
							}
							data.docNo = ($('#txt_serchStr').val().toString() || '');
							data.budgetDate = budgetDateList;
							data.acctCd = '${params.acctCd}';
							data.budgetCd = '${params.budgetCd}'; 
							data.bizplanCd = '${params.bizplanCd}';
							data.fromDt = '${params.erpGisuFromDate}'
							data.toDt = '${params.erpGisuToDate}'
						    // 엑셀명칭
							data.fileName = '예실대비현황 지출결의서';		
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
						alert("<%=BizboxAMessage.getMessage("TX000009638", "서비스 데이터가 없습니다.")%>");
					}
					
				}
			});	

	}
	 
	 
	 function downloadExcelProcess( dataPage, totalCount ){
			var excel = new JExcel("맑은 고딕 11 #333333");
			excel.set( { sheet : 0, value : "예실대비현황 지출결의서Sheet" } );
			

			//헤더 컬럼 세팅
			var headers = [ "${CL.ex_docNm}", "${CL.ex_docTitle}", "${CL.ex_draftDate}", "${CL.ex_draftDept}", "${CL.ex_drafter}", "${CL.ex_sending}", "${CL.ex_amtOfResolution}" ];
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
				
				excel.set( 0, 0, i, dataPage[ idx ][ "docNo" ] );
				excel.set( 0, 1, i, dataPage[ idx ][ "docTitle" ] );
				excel.set( 0, 2, i, dataPage[ idx ][ "repDt" ] );
				excel.set( 0, 3, i, dataPage[ idx ][ "deptName" ] );
				excel.set( 0, 4, i, dataPage[ idx ][ "empName" ] );
				excel.set( 0, 5, i, dataPage[ idx ][ "erpSendYnName" ] );
				excel.set( 0, 6, i, dataPage[ idx ][ "amt" ] );
				
				
			}
			excel.generate( "예실대비현황 지출결의서.xlsx" );
			
			
	 }
	 
	 
	 
	 
	/* [ 사이즈 변경 ] 페이지 리폼
	-----------------------------------------------*/
	function fnResizeForm() {
		var strWidth = $('.pop_con').outerWidth() + (window.outerWidth - window.innerWidth);
		var strHeight = $('.pop_con').outerHeight() + (window.outerHeight - window.innerHeight);
		
		$('.pop_con').css("overflow","auto");
		
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		
		if(isFirefox){
			
		}if(isIE){

		}if(isEdge){
			strWidth = 1100;
			strHeight = 650;
		}if(isChrome){
		}
		
		try{
			var childWindow = window.parent;
			childWindow.resizeTo(strWidth, strHeight);	
		}catch(exception){
			console.log('window resizing cat not run dev mode.');
		}
	}

	 //탭
	 function tab_nor_Fn(num){
		$(".tab"+num).show();
		$(".tab"+num).siblings().hide();
			
		var inx = num - 1;
		
		$(".tab_nor li").eq(inx).addClass("on");
		$(".tab_nor li").eq(inx).siblings().removeClass("on");
		
		if(num != undefined){
			fnGetResListInfo(num);
		}
	 }
	 
	 /* 파라미터 조회  */
	 function fnSetParamData(num){
		var param = {};
/* 		var budgetDate = new Date('${params.erpGisuFromDate}');
		var budgetDateList = []; */
		var sendYn = "";
			
/* 		for(var i = 0; i < 12; i ++) {
				budgetDateList.push([budgetDate.getFullYear(), budgetDate.getMonth() + 1 < 10 ? '0' + (budgetDate.getMonth() + 1) : budgetDate.getMonth() + 1].join(''));
				budgetDate.setMonth(budgetDate.getMonth() + 1)
			}
			
		budgetDateList = "'" + budgetDateList.join("', '") + "'" */
		param.docSts = ($("#sel_docStatus").val() || '');
		if( $('#docSerch').val() == '1'){
			param.docNo = ($('#txt_serchStr').val().toString() || '');
		}else if( $('#docSerch').val() == '2'){
			param.docTitle = ($('#txt_serchStr').val().toString() || '');
		}
		//param.sendYn = $('div.tab_nor').find('li.on').attr('value');
		if(num == 1){
			sendYn = "N";
		}else if(num == 2){
			sendYn = "Y";
		}
		param.sendYn = sendYn;
		/* param.budgetDate = budgetDateList; */
		param.fromDt = '${params.erpGisuFromDate}'
		param.toDt = '${params.erpGisuToDate}'
		param.acctCd = '${params.acctCd}'
		param.budgetCd = '${params.budgetCd}'
		param.bizplanCd = '${params.bizplanCd}'
		
		
		return param;
	 }
	 
	
	/*	[검색]메인 리스트 정보 조회
	-------------------------------------- */
	function fnGetResListInfo(num) {

		var param = fnSetParamData(num);


		$.ajax({
			async : false,
			type : "post",
			data : param,
			url : "<c:url value='/ex/expend/admin/ExYesilExpendDetailInfo.do' />",
			datatype : "json",
			success : function(data) {
				var aaData = [];
				
				if(data && data.result && data.result.params && data.result.params.resultData) {
					aaData = data.result.params.resultData;
				}
				fnSetMainTable(aaData);
				fnResizeForm();
			},
			error : function(err) {
				console.log(err);
			}
		});
		
	}

	
	/*	[테이블] 본문 내역 리스트 조회
	-------------------------------------- */
	var yesilListCnt = 0;
	function fnSetMainTable(aaData) {
		
		var id = "";
		var NoAmExp = 0;
		var SendAmExp = 0;
		var nonSendItemCnt = 0;
		var sendItemCnt = 0;
		
		
		$(".tab_nor ul li").each(function(){
			if( $(this).hasClass('on') == true){
				id = $(this).attr('id');
			}
		});
		
		aaData = aaData || [];
		yesilListCnt = aaData.length;
		
		$('#tbl_nonSendContents').empty();
		$('#tbl_sendContents').empty();
		
		if(yesilListCnt > 0) {
			for(var i=0; i < aaData.length; i++) {
				var item = aaData[i];

				if(item.expendErpSendYn == 'N'){
					
					$('#tbl_nonSendContents').append(fnGetTdCode(item));
					NoAmExp +=  Number(item.amt);
					
					
					nonSendItemCnt++;
					
				}else {
					
					$('#tbl_sendContents').append(fnGetTdCode(item));
					SendAmExp +=  Number(item.amt);
					
					sendItemCnt++;
					
				}
			}	
			$('#gAmExp').text(fnShowAmt(NoAmExp)) || '0';
			$('#sAmExp').text(fnShowAmt(SendAmExp)) || '0';
			
			$('#txt_nonSendResAmt').text(fnGetCurrencyCode(NoAmExp)) || '0';
			$('#txt_sendResAmt').text(fnGetCurrencyCode(SendAmExp)) || '0';
		} 
		
		if ( nonSendItemCnt == 0) {
			$('#tbl_nonSendContents').append('<tr><td colspan="7">데이터가 없습니다.</td></tr>');
		} 
		if ( sendItemCnt == 0) {
			$('#tbl_sendContents').append('<tr><td colspan="7">데이터가 없습니다.</td></tr>');
		}

		
		$('#txt_nonSendItemCnt').html(nonSendItemCnt);
		$('#txt_sendItemCnt').html(sendItemCnt);
	}
	
	/*	[메인 - GRID] HTML CODE 생성
	--------------------------------------------------*/
	function fnGetTdCode(item){
		
		var tr = document.createElement('tr');
		$(tr).data('item', item);
		
		var td1 = document.createElement('td');
		$(td1).attr('height', '28px');
		$(td1).text(item.docNo);
		$(tr).append(td1);
		
		var td2 = document.createElement('td');
		$(td2).attr('height', '28px');
		$(td2).text(item.docTitle);
		$(tr).append(td2);
		
		var td3 = document.createElement('td');
		$(td3).attr('height', '28px');
		$(td3).text(item.repDt);
		$(tr).append(td3);
		
		var td4 = document.createElement('td');
		$(td4).attr('height', '28px');
		$(td4).text(item.deptName);
		$(tr).append(td4);
		
		var td5 = document.createElement('td');
		$(td5).attr('height', '28px');
		$(td5).text(item.empName);
		$(tr).append(td5);
		
		var td6 = document.createElement('td');
		$(td6).attr('height', '28px');
		$(td6).text(item.docSts);
		$(tr).append(td6);
		
		var td7 = document.createElement('td');
		$(td7).attr('height', '28px');
		$(td7).text(fnGetCurrencyCode(item.amt));
		$(td7).addClass("ri");
		$(tr).append(td7);
		
		return tr;

	}
	
	/*	[공통] 노출 금액 데이터 공통 처리 함수
	-------------------------------------- */
	function fnShowAmt(value) {
		var defaultVal = 0;
		value = '' + value || '';
		value = '' + value.split('.')[0];
		value = value.replace(/[^0-9\-]/g, '')
				|| (defaultVal != undefined ? defaultVal : '0');
		var returnVal = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return returnVal;
	}
	
	
	
</script>