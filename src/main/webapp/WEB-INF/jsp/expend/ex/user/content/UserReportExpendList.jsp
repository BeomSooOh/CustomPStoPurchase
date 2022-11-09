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
<%-- <%@ include file="/WEB-INF/jsp/ea/include/includeCmmOrgPop.jsp"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1,0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<!--jquery UI css-->
<script type="text/javascript"
	src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<script type="text/javascript"
	src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>

<!-- 나의 지출결의 현황 -->

<script type="text/javascript">
    /* 변수정의 */
    /* 현황 리스트 저장 변수 */
	var listData = {};
    var searchParam = new kendo.data.ObservableObject(ExReportSend);
    
    searchParam.bind('change', function( e ) {
        console.log(this.toJSON());

        if (e.field == 'searchFromDate') {
            this.set('searchFromDate', this.get('searchFromDate').toString().replace(/-/g, ''))
        }
        if (e.field == 'searchToDate') {
            this.set('searchToDate', this.get('searchToDate').replace(/-/g, ''))
        }
    });

    /* 문서로드 */
    $(document).ready(function() {
		
    	// 푸딩 init
    	Pudd.initControl();
    	
        fnReportExpendEmpInit();
        fnReportExpendEmpEventInit();
        kendo.bind(document.body, searchParam);
        $('#btnReportExpendEmpSearch').click();
        
        // 데이트피커 예외처리 (회계일자, 지급요청일)
        var dpRemoveReadonly = function($input) {
        	$input.next('input[type=text]:first').removeAttr('readonly');
        }
        
        dpRemoveReadonly($('#txtFromDate'));
        dpRemoveReadonly($('#txtToDate'));
        dpRemoveReadonly($('#txtReqFromDate'));
        dpRemoveReadonly($('#txtReqToDate'));
    });

    /* 초기화 */
    function fnReportExpendEmpInit() {
        $('#btnApprovalExpend').hide();
        fnReportExpendEmpInitTextbox();
        fnReportExpendEmpInitCombobox();
        fnReportExpendEmpInitDatepicker();
        return;
    }

    /* 초기화 - Textbox */
    function fnReportExpendEmpInitTextbox() {
    	
	    /* 엔터 검색 */
        $('[type=text]').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                fnReportExpendEmpSearch();
            }
        });
        $('#txtWriter').focus();
        return;
    }
    
    /* 초기화 - Combobox */
    function fnReportExpendEmpInitCombobox() {
        searchParam.set('compSeq', '${ViewBag.compSeq}');

        var docSts = ('${ViewBag.commonCodeListDocStatus}' === '' ? [] : ${ViewBag.commonCodeListDocStatus});
        
        // 문서상태 
        var selDocStsCombobox = Pudd( "#selDocStatus" ).getPuddObject();
        $.each(docSts, function(idx, item){
        	selDocStsCombobox.addOption( item.commonCode, item.commonName );
        });
        
        selDocStsCombobox.on("change", function(e){
        	searchParam.set('searchDocStatus', selDocStsCombobox.val());
            fnReportExpendEmpSearch();
        });
        
		if(docSts.length > 0){
			selDocStsCombobox.setSelectedIndex(0);
		}
        searchParam.set('searchDocStatus', '');
        
        
		//사업장 
        var bizList = ('${bizList}' === '' ? [] : ${bizList});
		var selAppBizCombobox = Pudd("#selAppBiz").getPuddObject();
        $.each(bizList, function(idx, item){
        	selAppBizCombobox.addOption( item.commonCode, item.commonName );
        });
        
		if(bizList.length > 0){
			selAppBizCombobox.setSelectedIndex(0);
		}
        
        return;
    }

    /* 초기화 - Datepicker */
    function fnReportExpendEmpInitDatepicker() {
        
        /* 오늘을 기준으로 from >> 동년, 동월, 01 */
        /* 오늘을 기준으로 to >> 동년, 동월, 동일 */
        var dt = new Date();
        
        fnInitDatePicker(1);

        /* 엔터 검색 */
        $("#txtDocFromDate, #txtDocToDate, #txtFromDate, #txtToDate, #txtReqFromDate, #txtReqToDate").keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                fnReportExpendEmpSearch();
            }
        });
        return;
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
		var docToDate = Pudd( "#txtDocToDate" ).getPuddObject();
		docToDate.setDate(toD.ProcDate());
		
		if (toD.getMonth() == 0) {
			var fromD = new Date(toD.getFullYear() - 1, 11, toD.getDate());
		} else {
			var fromD = new Date(toD.getFullYear(), toD.getMonth() - monthGap,
					toD.getDate());
		}
		
		var docFromDate = Pudd( "#txtDocFromDate" ).getPuddObject();
		docFromDate.setDate(fromD.ProcDate());
	}
    
    /* 이벤트 */
    function fnReportExpendEmpEventInit() {
        /* 검색 */
        $('#btnReportExpendEmpSearch').click(function() {
            fnReportExpendEmpSearch();
        });
        $("#btnExcelDown").click(function(){
			fnAdminReportExcelDown();
		});
        return;
    }

    /* 이벤트 - 검색 */
    function fnReportExpendEmpSearch() {
    	
    	// dataSource를 통한 data 연동
    	var dataSource = new Pudd.Data.DataSource({
    			pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
    		,	serverPaging : true
    		,	request : {
    				url : '<c:url value="/expend/ex/user/ExUserExpendReportListInfoSelect.do" />'
    			,	type : 'post'
    			,	dataType : "json"
    			,	contentType : "application/json; charset=utf-8"
    			,	jsonStringify : true
    			,	parameterMapping : function( data ) {
    	 			
    				$.extend(data, searchParam.toJSON());
    			  				
    		        if(data.emp_seq == ""){
    		        	data.emp_seq = '${ViewBag.emp_seq}';
    		        }
    		        data.searchDocFromDate = $('#txtDocFromDate').val().toString().replace(/-/g, '');
    		        data.searchDocToDate = $('#txtDocToDate').val().toString().replace(/-/g, '');
    		        
    		        // 회계일자 검색 시작일
    		        $('#txtFromDate').val($('#txtFromDate').next('input[type=text]:first').val().substring(0, 10));
    		        data.searchFromDate = $('#txtFromDate').val().toString().replace(/-/g, '');
    		        data.searchFromDate = (data.searchFromDate == '' ? '19000101' : data.searchFromDate);
    		        
					// 회계일자 검색 종료일
					$('#txtToDate').val($('#txtToDate').next('input[type=text]:first').val().substring(0, 10));
    		        data.searchToDate = $('#txtToDate').val().toString().replace(/-/g, '');
    		        data.searchToDate = (data.searchToDate == '' ? '99991231' : data.searchToDate);
    				
    		        // 2019. 07. 17. 김상겸. < 지급요청일 검색 조건 추가 >
    		        // 지급요청일자 검색 시작일
    		        $('#txtReqFromDate').val($('#txtReqFromDate').next('input[type=text]:first').val().substring(0, 10));
    		        data.searchReqFromDate = $('#txtReqFromDate').val().toString().replace(/-/g, '');
    		        data.searchReqFromDate = (data.searchReqFromDate == '' ? '19000101' : data.searchReqFromDate);
    		        
    		        // 지급요청일자 검색 종료일
    		        $('#txtReqToDate').val($('#txtReqToDate').next('input[type=text]:first').val().substring(0, 10));
    		        data.searchReqToDate = $('#txtReqToDate').val().toString().replace(/-/g, '');
    		        data.searchReqToDate = (data.searchReqToDate == '' ? '99991231' : data.searchReqToDate);
    				
    				data.appDocNo = $('#txtDocNo').val();
    				data.appUserName = $('#txtWriter').val();
    				data.appDocTitle = $('#txtDocSubject').val();
    				data.expendUseDeptName = $('#txtUseDept').val();
    				data.expendUseEmpName = $('#txtUserNm').val();
    		        data.bizCd = ($("#selAppBiz").val() == "전체" ? "":$("#selAppBiz").val());
    		        data.formName = $("#txtFormTitle").val();
    		        
    		        // 자동전표번호
    		        data.expendErpAdocuNumber = $('#txtErpAdocuNumber').val();
    				
    		        data.startPosition = ( data.page - 1 ) * data.pageSize;
    		        data.endPosition = data.page * data.pageSize; // 오라클 용 parameter
    		        
    		        // 2019. 07. 17. 신규 추가 파라미터
    		        //  - searchReqFromDate, searchReqToDate, expendErpAdocuNumber
    				}
    			}
    		,	result : {
    				data : function( response ) {
    					listData = response.aaData;
    	                $("#valTotalCount").text(response.aaData.length);
    					return response.aaData;
    				}
    			,	totalCount : function( response ) {
    					return response.totalCount.totalCount;
    				}
    			,	error : function( response ) {
    					alert( "error - Pudd.Data.DataSource.read, status code - " + response.status );
    				}
    			}
    	});
    	 
    	Pudd( "#tblReportExpendEmpList" ).puddGrid({
    			dataSource : dataSource
    		,	scrollable : false
    		//,	height : 500
    		//,	autoScroll : false	// scrollable 값이 true 이고 height 값이 설정된 경우 pager 사용하지 않는 경우 autoScroll - true 설정 권장, 아니면 false 기본값 권장
    		,	sortable : true
    		//,	sortPageSame : true		// 기본값 true : 페이지 번호 변경없음, false : sorting 컬럼 클릭시 1페이지로 이동
    		,	pageable : {
    				buttonCount : 10
    			,	pageList : [ 10, 20, 30, 40, 50 ]
    			}
    		,	resizable : true	// 기본값 false
    			// 말줄임 사용여부
    		,	ellipsis : false
    			// row click시 hover용 style 적용여부
    		//,	hoverClick : false	// 기본값 true
    			// grid container 객체 - 최상위 객체 attribute 설정이 필요한 경우
    		//,	attributes : { style : "padding-left:100px;", class : "skin01 skin01_02" }
    		,	noDataMessage : {
    				message : "${CL.ex_dataDoNotExists}"
    			}
    		,	columns : [
    				{
    					field : "appDocNo"	
    				,	title : "${CL.ex_documentNumber}" // 문서번호
    				//,	width : 135
    				//,	widthUnit : "%"	// 기본값 : "px"
    				,	content : {
    						template : function( rowData ) {
    		    				if(rowData.appDocNo != ''){
    		    					return '<a href="javascript:;" onClick="javascript: fnAppdocPop(' + "'" + rowData.docSeq + "', '" + rowData.formSeq + "'" + ')">' + rowData.appDocNo + '</a>';
    		    				}else{
    		    					return '<a href="javascript:;" onClick="javascript: fnAppdocPop(' + "'" + rowData.docSeq + "', '" + rowData.formSeq + "'" + ')"> ${CL.ex_drafts}[' + rowData.appUserName + ']</a>';
    		    				}
    						}
    					}
    				}
    			,	{
    					field : "appRepDate"
    				,	title : "${CL.ex_date}" // 기안일
    				,	width : 100
    				}
    			,	{
						field : "appDocTitle"
					,	title : "${CL.ex_documentTitle}" // 문서제목
					//,	width : 160
					//,	widthUnit : "%"				// 기본값 : "px"
					}
    			,	{
						field : "expendDate"
					,	title : "${CL.ex_accountingDate}" // 회계일자
					,	width : 100
					//,	widthUnit : "%"				// 기본값 : "px"
					}
    			,	{
						field : "expendReqDate"
					,	title : "${CL.ex_dateOfRequest}" // 요청일자
					,	width : 100
					//,	widthUnit : "%"				// 기본값 : "px"
					}
    			,	{
						field : "appUserName"
					,	title : "${CL.ex_reporter}" // 상신자
					,	width : 80
					//,	widthUnit : "%"				// 기본값 : "px"
					}
    			,	{
						field : "expendUseDeptName"
					,	title : "${CL.ex_department}" // 사용부서
					,	width : 160
					//,	widthUnit : "%"				// 기본값 : "px"
					}
    			,	{
						field : "expendUseEmpName"
					,	title : "${CL.ex_user}" // 사용자
					//,	width : 160
					//,	widthUnit : "%"				// 기본값 : "px"
					}
    			,	{
						field : "expendAmt"
    				,	title : "${CL.ex_amount}" // 금액
					,	width : 100
					//,	widthUnit : "%"				// 기본값 : "px"
					,	content : {
    						template : function( rowData ) {
    							return rowData.expendAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    						}
    					}
					}
    			,	{
						field : "expendErpSendYN"
					,	title : "${CL.ex_sending}" // 전송여부
					,	width : 160
					//,	widthUnit : "%"				// 기본값 : "px"
					,	content : {
    						template : function( rowData ) {
    							if (rowData.expendErpSendYN == '' || rowData.expendErpSendYn == 'N') {
    			                    return "미전송";
   			                    } else {
   			                        return "전송";
   			                    }
    						}
    					}
    				}
    			,	{
						field : "expendErpSendName"
					,	title : "${CL.ex_sender}" // 전송자
					,	width : 80
					//,	widthUnit : "%"				// 기본값 : "px"
					,	content : {
    						template : function( rowData ) {
    							if (rowData.expendErpSendName == '') {
    		                        return "-";
    		                    } else {
    		                        return rowData.expendErpSendName;
    		                    }
    						}
    					}
					}
    			,	{
						field : "erpAdocuNumber"
					,	title : "${CL.ex_automaticSlipNumber}" // 자동전표번호
					,	width : 150
					//,	widthUnit : "%"				// 기본값 : "px"
					,	content : {
    						template : function( rowData ) {
   							 if ('${ifSystem}' == 'ERPiU') {
   			                        if (rowData.expendErpiuAdocuId == '') {
   			                            return "-";
   			                        } else {
   			                            return rowData.expendErpiuAdocuId;
   			                        }
   			                    } else if ('${ifSystem}' == 'iCUBE') {
   			                        if (rowData.expendIcubeAdocuId == '') {
   			                            return '-';
   			                        } else {
   			                            return rowData.expendIcubeAdocuId + ' / ' + rowData.expendIcubeAdocuSeq;
   			                        }
   			                    }
    						}
    					}
					}
    			]
    		, progressBar : {
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
    	});
    }
    
	/* function - fnAppdocPop */
	function fnAppdocPop(docSeq, formSeq) {
		var intWidth = '1000';
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
	
	/*	[서버 호출] 데이터 Excel 다운로드
 	--------------------------------------*/
	function fnAdminReportExcelDown() {
		var param = {};
		
		/* 파라미터  */
		param.fileName = "사용자지출결의현황";
		$("#fileName").val( param.fileName );
		param.listData = JSON.stringify(listData);
		$("#listData").val( param.listData );
		/* Excel 헤더 정의 */
		var excelHeader = {};
		excelHeader.cardCode = "cardCode";
		excelHeader.cardCode = "cardCode";
		excelHeader.cardNum = "cardNum";
		excelHeader.cardName = "cardName";
		excelHeader.authDate = "authDate";
		excelHeader.authTime = "authTime";
		excelHeader.mercName = "mercName";
		excelHeader.mercSaupNo = "mercSaupNo";
		excelHeader.vatStat = "vatStat";
		excelHeader.requestAmount = "requestAmount";
		excelHeader.serAmount = "serAmount";
		excelHeader.amtMdAmount = "amtMdAmount";
		excelHeader.vatMdAmount = "vatMdAmount";
		excelHeader.docNo = "docNo";
		excelHeader.docUserNm = "docUserNm";
		excelHeader.docDocSts = "docSts";
		excelHeader.formFormName = "formName";
		
		param.excelHeader = JSON.stringify(excelHeader);
		$("#excelHeader").val( param.excelHeader );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
</script>

<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="frDt" value="" id="frDt" /> <input
		type="hidden" name=toDt value="" id="toDt" /> <input type="hidden"
		name="docSts" value="" id="docSts" /> <input type="hidden"
		name="excelHeader" value="" id="excelHeader" /> <input type="hidden"
		name="fileName" value="" id="fileName">
</form>

<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_date}</dt>
			<!-- 기안일 -->
			<dd>
				<input type="text" id="txtDocFromDate" class="puddSetup"
					pudd-type="datepicker" value="" /> ~ <input type="text"
					id="txtDocToDate" class="puddSetup" pudd-type="datepicker" value="" />
				<!--  <input id="txtDocFromDate" class="dpWid enter" /> ~ <input id="txtDocToDate" class="dpWid enter" /> -->
			</dd>
			<dt style="width: 90px;">${CL.ex_documentTitle}</dt>
			<!-- 문서제목 -->
			<dd class="mr5">
				<input type="text" id="txtDocSubject" data-bind="value: appDocTitle"
					style="width: 200px;" class="puddSetup" value="" />
			</dd>
			<dt>${CL.ex_documentStatus}</dt>
			<!-- 문서상태 -->
			<dd>
				<select id="selDocStatus" class="puddSetup"
					pudd-style="width:100px;">
				</select>
			</dd>
			<dd>
				<input type="button" id="btnReportExpendEmpSearch" class="puddSetup"
					value="${CL.ex_search}" />
			</dd>
		</dl>
		<span class="btn_Detail">${CL.ex_advancedSearch} <!-- 검색 --> <img
			id="all_menu_btn"
			src='<c:url value="/Images/ico/ico_btn_arr_down01.png"/>' /></span>
	</div>

	<!-- 상세검색박스 -->
	<div class="SearchDetail">
		<dl>
			<dt style="width: 60px;">${CL.ex_accountingDate}</dt>
			<!-- 회계일자 -->
			<dd>
				<input type="text" id="txtFromDate" class="puddSetup"
					pudd-type="datepicker" value="" /> ~ <input type="text"
					id="txtToDate" class="puddSetup" pudd-type="datepicker" value="" />
			</dd>
			<dt style="width: 95px;">${CL.ex_paymentDate}</dt>
			<!-- 지급요청일 -->
			<dd>
				<input type="text" id="txtReqFromDate" class="puddSetup"
					pudd-type="datepicker" value="" /> ~ <input type="text"
					id="txtReqToDate" class="puddSetup" pudd-type="datepicker" value="" />&nbsp;해당문서
				대표 지급요청일 검색 (관리항목 검색불가)
			</dd>
		</dl>
		<dl>
			<dt style="width: 60px;">${CL.ex_documentType}</dt>
			<!-- 문서분류 -->
			<dd class="mr5">
				<input type="text" id="txtFormTitle" style="width: 200px;"
					class="puddSetup" value="" />
			</dd>
			<dt style="width: 162px;">${CL.ex_documentNumber}</dt>
			<!-- 문서번호 -->
			<dd class="mr5">
				<input type="text" id="txtDocNo" data-bind="value: appDocNo"
					style="width: 200px;" class="puddSetup" value="" />
			</dd>
			<dt style="width: 160px;">${CL.ex_workplace}</dt>
			<!-- 사업장 -->
			<dd class="mr5">
				<select id="selAppBiz" class="puddSetup" pudd-style="width:244px;">
				</select>
			</dd>
		</dl>
		<dl>
			<dt style="width: 60px;">${CL.ex_department}</dt>
			<!-- 부서 -->
			<dd class="mr5">
				<input type="text" id="txtUseDept"
					data-bind="value: expendUseDeptName" style="width: 200px;"
					class="puddSetup" value="" />
			</dd>
			<dt style="width: 162px;">${CL.ex_user}</dt>
			<!-- 사용자 -->
			<dd class="mr5">
				<input type="text" id="txtUserNm"
					data-bind="value: expendUseEmpName" style="width: 200px;"
					class="puddSetup" value="" />
			</dd>
			<dt style="width: 160px;">${CL.ex_automaticSlipNumber}</dt>
			<!-- 자동전표번호 -->
			<dd class="mr5">
				<input type="text" id="txtErpAdocuNumber"
					data-bind="value: expendErpAdocuNumber" style="width: 200px;"
					class="puddSetup" value="" />
			</dd>
		</dl>
		<dl>

		</dl>
	</div>

	<span class="fwb mt10" style="text-align:left;float:left">총 <span id="valTotalCount">0</span> 건</span>
	
	<div id="" class="controll_btn cl">
		<button id="btnApprovalExpend" class="k-button">${CL.ex_requestApproval}</button>
		<button id="btnExcelDown" class="btn_sc_add" style="display: none;">${CL.ex_excel}</button>
	</div>

	<!-- 테이블 -->
	<div id="tblReportExpendEmpList"></div>

</div>
<!-- //sub_contents_wrap -->


