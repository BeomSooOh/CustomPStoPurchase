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
	src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/pudd/pudd-1.1.79.min.js"></c:url>'></script>

<!--Excel다운로드를 위한 js-->
<script type="text/javascript"
	src='<c:url value="/js/t_excel/jszip-3.1.5.min.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/t_excel/FileSaver-1.2.2_1.js"></c:url>'></script>
<script type="text/javascript"
	src='<c:url value="/js/t_excel/jexcel-1.0.4.js"></c:url>'></script>

<!-- /* 프로그레스 레이어 팝업 참조 */ -->
<jsp:include page="../../../../common/layer/ProgressLayerPop.jsp"
	flush="false" />
<script type="text/javascript">
    /* 변수정의 */
    
    /* 데이터테이블 현재 페이지 저장 여부 */
    var isInitPage = false;

    /* 현황 리스트 저장 변수 */
	var listData = {};
	
    /*	[공통] 날짜 포멧 변경2
	----------------------------------------- */
	function getFormatDateForDateObj(date){
		var year = date.getFullYear();                                 //yyyy
		var month = (1 + date.getMonth());                     //M
		month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
		var day = date.getDate();                                        //d
		day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
		return  year + '-' + month + '-' + day;
	}
    
    
    /* 문서로드 */
    $(document).ready(function() {
        fnReportExpendAdmInit();
        fnReportExpendAdmEventInit();
        $('#btnReportExpendAdmSearch').click();
    });

    /* 초기화 */
    function fnReportExpendAdmInit() {
        fnReportExpendAdmInitTextbox();
        fnReportExpendAdmInitCombobox();
        fnReportExpendAdmInitDatepicker();
        return;
    }

    /* 초기화 - Textbox */
    function fnReportExpendAdmInitTextbox() {
    	$("#selShowCount").selectmenu({change: function(){
    		$('select[name=tblReportExpendAdmList_length]').val($('#selShowCount').val());
			$('select[name=tblReportExpendAdmList_length]').trigger('change');
		}});
        return;
    }

    /* 초기화 - Combobox */
    function fnReportExpendAdmInitCombobox() {
        <c:if test="${ViewBag.empInfo.userSe == 'MASTER'}">
        setComboBox($('#selCompany'), JSON.parse('${ViewBag.compListInfo}'), function() {
            $('#btnExpendSendSearch').click();
        });
        /* 기본값 지정 */
        var comboboxCompany = $("#selCompany").data("kendoComboBox");
        comboboxCompany.value('${ViewBag.empInfo.compSeq}');
        </c:if>

        var docStatusInfo = ('${ViewBag.commonCodeListDocStatus}' === '' ? [] : ${ViewBag.commonCodeListDocStatus});
        $("#selDocStatus").empty();
		$.each(docStatusInfo, function(idx, item) {
			$("#selDocStatus").append("<option value='" + item.commonCode + "'>" + item.commonName + "</option>");
		});
		
		$("#selDocStatus").selectmenu({change: function(){
			if($('#selDocStatus').val() == '10' || $('#selDocStatus').val() == ''){
            	$('#btnExpendDelete').hide();
            	$('#btnReportExpendAdmSearch').click();
            }else{
            	$('#btnExpendDelete').show();
            	$('#btnReportExpendAdmSearch').click();
            }
		}});
		
		if(docStatusInfo.length > 0){
			$("#selDocStatus").val(docStatusInfo[0].commonCode).selectmenu('refresh');
		}
        
        /* 기본값 지정 */
        $("#selDocStatus").val('${CL.ex_all}');
        $('#btnExpendDelete').hide();
        
//         setComboBox($('#selAppBiz'), JSON.parse('${bizList}'), function() {
//         });
        /* 기본값 지정 */
        
        var bizList = ('${bizList}' === '' ? [] : ${bizList});
        $("#selAppBiz").empty();
		$.each(bizList, function(idx, item) {
			$("#selAppBiz").append("<option value='" + item.commonCode + "'>" + item.commonName + "</option>");
		});
		
		$("#selAppBiz").selectmenu({change: function(){
		}});
		
		if(bizList.length > 0){
			$("#selAppBiz").val(bizList[0].commonCode).selectmenu('refresh');
		}
        
        return;
    }

    /* 초기화 - Datepicker */
    function fnReportExpendAdmInitDatepicker(monthGap) {
    	 
        $("#txtDocFromDate, #txtDocToDate, #txtFromDate, #txtToDate, #txtReqFromDate, #txtReqToDate").kendoDatePicker({
            culture : "ko-KR",
            format : "yyyy-MM-dd"
        });

        var datePicker = $("#txtDocFromDate, #txtDocToDate, #txtFromDate, #txtToDate, #txtReqFromDate, #txtReqToDate");
        datePicker.kendoMaskedTextBox({
            mask : '0000-00-00'
        });
        datePicker.closest(".k-datepicker").add(datePicker).removeClass('k-textbox');

        /* 오늘을 기준으로 from >> 동년, 동월, 01 */
        /* 오늘을 기준으로 to >> 동년, 동월, 동일 */
        /*  var dt = new Date();
        
        
        $('#txtDocFromDate').val([ dt.getFullYear(), ((Number(dt.getMonth()) + 1) < 10 ? [ '0', (Number(dt.getMonth()) + 1) ].join('') : (dt.getMonth() + 1)), '01' ].join('-'));
        $('#txtDocToDate').val([ dt.getFullYear(), ((Number(dt.getMonth()) + 1) < 10 ? [ '0', (Number(dt.getMonth()) + 1) ].join('') : (dt.getMonth() + 1)), ((dt.getDate() + '').length == 2 ? dt.getDate() : '0' + dt.getDate()) ].join('-'));
//         $('#txtFromDate').val([ dt.getFullYear(), ((Number(dt.getMonth()) + 1) < 10 ? [ '0', (Number(dt.getMonth()) + 1) ].join('') : (dt.getMonth() + 1)), '01' ].join('-'));
//         $('#txtToDate').val([ dt.getFullYear(), ((Number(dt.getMonth()) + 1) < 10 ? [ '0', (Number(dt.getMonth()) + 1) ].join('') : (dt.getMonth() + 1)), ((dt.getDate() + '').length == 2 ? dt.getDate() : '0' + dt.getDate()) ].join('-'));
 		*/		
 		
        return;
    }

    /* 이벤트 */
    function fnReportExpendAdmEventInit() {
        /* 검색 */
        $('#btnReportExpendAdmSearch').click(function() {
        	isInitPage = false;
            fnReportExpendAdmSearch();
        });
        
        /* 삭제 */
        $('#btnExpendDelete').click(function() {
        	fnExpendDelete();
        });
        
        /* 엔터 키 이벤트 */
        $("input").keydown(function (event) {
            if (event.keyCode === 13) {
            	$('#btnReportExpendAdmSearch').click();
            }
        });
        
        $("#btnExcelDown").click(function(){
			fnAdminReportExcelDown();
		});
        
        return;
    }

    /* 이벤트 - 검색 */
    function fnReportExpendAdmSearch() {
        var param = {};
        
        // 기안일자
        param.searchDocFromDate = $('#txtDocFromDate').val().toString().replace(/-/g, '');
        param.searchDocToDate = $('#txtDocToDate').val().toString().replace(/-/g, '');
        // 제목
        param.appDocTitle = $('#txtDocSubject').val();
        // 문서상태
        param.searchDocStatus = ($('#selDocStatus').val() == "전체" ? "" : $('#selDocStatus').val());
        // 회계일자
        param.searchFromDate = $('#txtFromDate').val().toString().replace(/-/g, '');
        param.searchToDate = $('#txtToDate').val().toString().replace(/-/g, '');
        if( param.searchFromDate == ''){
			param.searchFromDate = '19000101';
		}
		if( param.searchToDate == ''){
			param.searchToDate = '99991231';
		}
        // 지급요청일
        param.searchReqFromDate = $('#txtReqFromDate').val().toString().replace(/-/g, '');
        param.searchReqToDate = $('#txtReqToDate').val().toString().replace(/-/g, '');
        if( param.searchReqFromDate == ''){
			param.searchReqFromDate = '19000101';
		}
		if( param.searchReqToDate == ''){
			param.searchReqToDate = '99991231';
		}
        // 문서분류
        param.formName = $("#txtFormTitle").val();
        // 문서번호
        param.appDocNo = $('#txtDocNo').val();
        // 기안자
        param.appUserName = $('#txtWriter').val();
        // 사업장
        param.bizCd = ($("#selAppBiz").val()=="전체"?"":$("#selAppBiz").val());
        // 사용부서
        param.expendUseDeptName = $('#txtUseDept').val();
        // 사용자
        param.expendUseEmpName = $('#txtUserNm').val();
        // 자동전표번호
        param.expendErpAdocuNumber = $('#txtErpAdocuNumber').val();
		
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/report/ExReportExpendAdmListInfoSelect.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
                fnReportExpendAdmBind(data.aaData, data.ifSystem);
                listData = data.aaData;
                $("#valTotalCount").text(data.aaData.length);
            },
            error : function( data ) {
                console.log("! [EX][FNREPORTEXPENDADMSEARCH] ERROR - " + JSON.stringify(data));
            }
        });
    }

    /* 그리드 바인딩 - 지출결의 작성 내역 */
    function fnReportExpendAdmBind( source, ifSystem ) {
        var source = (source || {});
        $('#tblReportExpendAdmList').dataTable({
        	
//             "fixedHeader" : true,
            "select" : true,
            "lengthMenu" : [ [ 10, 20, 30, 40, 50 ], [ 10, 20, 30, 40, 50 ] ],
//             "displayStart": 0,
            "paging" : true,
            "bStateSave": isInitPage,
            /* "sScrollY" : '590px', */
            "bAutoWidth" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : source,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {

                }));
                $(nRow).on('dblclick', (function() {

                }));

                return nRow;
            },
            "columnDefs" : [ {
            	"targets" : 0,
                "data" : null,
                "render" : function( data ) {
                    if (data != null && data != "") {
                   		var chkVal = {};
                   		chkVal.expendSeq = data.expendSeq;
                    	return "<input type='checkbox' name='inp_expend_Chk' id='inp_expend_chk_" + data.expendSeq + "' value='" + JSON.stringify(chkVal) + "' class='k-checkbox' /><label class='k-checkbox-label bdChk' for='inp_expend_chk_" + data.expendSeq+ "'></label>";
                    } else {
                        return "";
                    }
                }
            }, {
            	"targets" : 1,
                "data" : null,
                "render" : function( data ) {
	            	return '<a href="javascript:;" title="" onClick="javascript: fnAppdocPop('
					+ "'"
					+ data.docSeq
					+ "', '"
					+ data.formSeq
					+ "'" + ')">'
					+ (data.docSts == 10?"임시보관문서["+data.appUserName+"]":data.appDocNo)
					+ '</a>';
                }
            }, {
                /* 금액 */
                "targets" : 9,
                "data" : null,
                "render" : function( data ) {
                    return data.expendAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                }
            }, {
                /* 전송여부 */
                "targets" : 10,
                "data" : null,
                "render" : function( data ) {
                    if (data.expendErpSendYn == '' || data.expendErpSendYn == 'N') {
                        return "미전송";
                    } else {
                    	return "전송";
                    }
                }
            }, {
                /* 전송자 */
                "targets" : 11,
                "data" : null,
                "render" : function( data ) {
                    if (data.expendErpSendName == '') {
                        return "-";
                    } else {
                        return data.expendErpSendName;
                    }
                }
            }, {
                /* 전표번호 */
                "targets" : 12,
                "data" : null,
                "render" : function( data ) {
                    if (ifSystem == 'ERPiU') {
                        if (data.expendErpiuAdocuId == '') {
                            return "-";
                        } else {
                            return data.expendErpiuAdocuId;
                        }
                    } else if (ifSystem == 'iCUBE') {
                        if (data.expendIcubeAdocuId == '') {
                            return '-';
                        } else {
                            return data.expendIcubeAdocuId + ' / ' + data.expendIcubeAdocuSeq;
                        }
                    }
                }
            } ],
            "aoColumns" : [{
            	"sTitle" : "<label class=''><input type='checkbox' id='inp_expend_Chk_Title' name='inp_expend_Chk' onclick='fnChk(this)'></label>",
	        	"bSearchable" : false,
	        	"bSortable" : false,
	        	"bVisible" : true,
	        	"sWidth" : "34",
	        	"sClass" : "center"
        	}, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000663", "문서번호")%>",
//                 "mDataProp" : "appDocNo",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "td_le"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000494", "기안일")%>",
                "mDataProp" : "appRepDate",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "100px"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000003457", "문서제목")%>",
                "mDataProp" : "appDocTitle",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "td_le"
            }, {
                "sTitle" : "${CL.ex_accountingDate}",
                "mDataProp" : "expendDate",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "100px"
            }, {
                "sTitle" : "${CL.ex_paymentDate}",
                "mDataProp" : "expendReqDate",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "100px"
            }, {
                "sTitle" : "${CL.ex_staffOfDrafting}",
                "mDataProp" : "appUserName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "80px"
            }, {
                "sTitle" : "${CL.ex_useDepartment}",
                "mDataProp" : "expendUseDeptName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "",
                "sClass" : "td_le"
            }, {
                "sTitle" : "${CL.ex_user}",
                "mDataProp" : "expendUseEmpName",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "80px"
            }, {
                "sTitle" : "${CL.ex_amount}",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "100px",
                "sClass" : "td_ri"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000001003", "전송여부")%>",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "80px"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000005750", "전송자")%>",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "80px"
            }, {
                "sTitle" : "<%=BizboxAMessage.getMessage("TX000000565", "전표번호")%>",
                "bVisible" : true,
                "bSortable" : true,
                "sWidth" : "150px"
            } ]
        });

        $('select[name=tblReportExpendAdmList_length]').val($('#selShowCount').val());
		$('select[name=tblReportExpendAdmList_length]').trigger('change');
        return;
    }
    
    function fnChk( obj ) {
        var name = obj.name;
        var objChked = $("input[name=inp_expend_Chk]:checkbox");
        fnAllCheckBoxChecked(obj, objChked);
    }
    
    function fnExpendDelete(){
    	if(confirm('정말 삭제하시겠습니까?')){
	    	var chkSels = $("input[name=inp_expend_Chk]:checkbox:checked").map(function() {
	    		if(this.value == "on"){
	    			return this.value;
	    		}else{
	    			return JSON.parse( (this.value || {}));	
	    		}
	            
	        }).get();
	        var deletectChkCount = chkSels.length;
	        
	        /* 전체 선택 체크박스 제거 */
	        if(chkSels.length > 0 && chkSels[0] === 'on'){
	        	deletectChkCount--;
	        	chkSels.splice(0,1);
	        }
	        
	        if(deletectChkCount <= 0 ){
	        	//alert("<%=BizboxAMessage.getMessage("TX000002223", "선택된 항목이 없습니다.　항목을 선택하여 주십시오")%>");
				alert("<%=BizboxAMessage.getMessage("TX000002519", "선택된 문서가 없습니다.")%>");
				return;
	        }
	        
	        /*서버 연산 진행중이면 리턴*/
			if(PLP_fnIsGetProgressing()){
				return;
			}
	        
	        /* 프로그래스바 추가 */
	        fnStartDeleteFunt(chkSels);
	        
// 	        /* 서버호출 */
// 	        $.ajax({
// 	            type : 'post',
// 	            url : '<c:url value="/ex/expend/admin/ExExpendDelete.do" />',
// 	            datatype : 'json',
// 	            async : false,
// 	            data : param,
// 	            success : function( data ) {
// 	            	isInitPage = true;
// 	            	fnReportExpendAdmSearch();
// 	            },
// 	            error : function( data ) {
// 	                console.log("! [EX][EXPENDINSERT] ERROR - " + JSON.stringify(data));
// 	            }
// 	        });
    	}
    }
    
    function fnStartDeleteFunt(checkedValue){
    	/* 프로그레스 다이얼로그 시작 */ 
		PLP_fnShowProgressDialog({
			title : "<%=BizboxAMessage.getMessage("", "지출결의 삭제")%>"		
				, progText : "<%=BizboxAMessage.getMessage("", "지출결의 삭제를 진행중입니다.")%>"	 
				, endText : "<%=BizboxAMessage.getMessage("", "삭제가 완료되었습니다.")%>"	
				, popupPageTitle : "<%=BizboxAMessage.getMessage("", "지출결의 삭제 실패사유")%>"	
				, popupColGbn : "<%=BizboxAMessage.getMessage("", "문서번호")%>"	
				, popupColDetail : "<%=BizboxAMessage.getMessage("TX000018764", "실패사유")%>"	
			}); 
		PLP_fnSetProgressValue(0, 0, checkedValue.length);
		/* 전표전송 재귀호출 */
		fnRecurForDelete(0, checkedValue);
    }
    
    function fnRecurForDelete(idx, arr){
    	if(idx >= arr.length){
			PLP_fnEndProgressDialog();
			isInitPage = true;
			fnReportExpendAdmSearch();
			return ;
		}
		var item = arr[idx++];
		var length = arr.length;
			$.ajax({
				type : 'post',
	            url : '<c:url value="/ex/expend/admin/ExExpendDelete.do" />',
	            datatype : 'json',
	            async : true,
	            data : {
					'expendSeq' : item.expendSeq
				},
	            success : function( data ) {
					if(data.result.resultCode == 'FAIL'){
						PLP_fnSetErrInfo({
							'colGbn' : item.appDocNo
							, 'colDetail' : data.result.resultName
						});
						PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);	
					}else{
						PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
					}
					value = ( (idx * 1.0 ) / ( length * 1.0 )) * 100;
					fnRecurForDelete(idx, arr);
				},
				error : function(e, status) { //error : function(xhr, status, error) {
					alert(status);
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
		var url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq
				+ "&form_id=" + formSeq + "&doc_auth=1";
		window.open(url, 'AppDoc',
				'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width='
						+ intWidth + ',height=' + intHeight + ',left='
						+ intLeft + ',top=' + intTop);
	}
    
	 /*	[서버 호출] 법인카드 사용내역 데이터 Excel 다운로드
 	--------------------------------------*/
	function fnAdminReportExcelDown(){
		
		if( !listData || listData.length == undefined || listData.length == 0){
			alert("데이터가 없습니다.");
			return false;
		}
		
		/* 회계일자 기본 세팅 */
		if( $("#txtFromDate").val() == ''){
			$("#searchFromDate").val('19000101');
		}
		if( $('#txtToDate').val() == ''){
			$("#searchToDate").val('99991231');
		}

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
							url : '<c:url value="/ex/admin/CommonNewExcelDown.do" />'
						,	type : 'post'
						,	dataType : "json"
						,	contentType : "application/json; charset=utf-8"
						,	jsonStringify : true
						,	parameterMapping : function( data ) {
						        // 기안일자
						        data.searchDocFromDate = $('#txtDocFromDate').val().toString().replace(/-/g, '');
						        data.searchDocToDate = $('#txtDocToDate').val().toString().replace(/-/g, '');
						        // 제목
						        data.appDocTitle = $('#txtDocSubject').val();
						        // 문서상태
						        data.searchDocStatus = ($('#selDocStatus').val() == "전체" ? "" : $('#selDocStatus').val());
						        // 회계일자
						        data.searchFromDate = $('#txtFromDate').val().toString().replace(/-/g, '');
						        data.searchToDate = $('#txtToDate').val().toString().replace(/-/g, '');
						        if( data.searchFromDate == ''){
						        	data.searchFromDate = '19000101';
								}
								if( data.searchToDate == ''){
									data.searchToDate = '99991231';
								}
						        // 지급요청일
						        data.searchReqFromDate = $('#txtReqFromDate').val().toString().replace(/-/g, '');
						        data.searchReqToDate = $('#txtReqToDate').val().toString().replace(/-/g, '');
						        if( data.searchReqFromDate == ''){
						        	data.searchReqFromDate = '19000101';
								}
								if( data.searchReqToDate == ''){
									data.searchReqToDate = '99991231';
								}
						        // 문서분류
						        data.formName = $("#txtFormTitle").val();
						        // 문서번호
						        data.appDocNo = $('#txtDocNo').val();
						        // 기안자
						        data.appUserName = $('#txtWriter').val();
						        // 사업장
						        data.bizCd = ($("#selAppBiz").val()=="전체"?"":$("#selAppBiz").val());
						        // 사용부서
						        data.expendUseDeptName = $('#txtUseDept').val();
						        // 사용자
						        data.expendUseEmpName = $('#txtUserNm').val();
						        // 자동전표번호
						        data.expendErpAdocuNumber = $('#txtErpAdocuNumber').val();
						        // 엑셀명칭
								data.fileName = '지출결의현황';		
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

	function downloadExcelProcess( dataPage, totalCount ) {

		var excel = new JExcel("맑은 고딕 11 #333333");
		excel.set( { sheet : 0, value : "지출결의확인Sheet" } );

		//헤더 컬럼 세팅
		var headers = [ "문서번호", "기안일", "문서제목", "회계일자", "지급요청일", "상신자", "사용부서", "사용자", "금액", "전송여부", "전송자", "전표번호" ];
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
			
			excel.set( 0, 0, i, dataPage[ idx ][ "appDocNo" ] );
			excel.set( 0, 1, i, dataPage[ idx ][ "appRepDate" ] );
			excel.set( 0, 2, i, dataPage[ idx ][ "appDocTitle" ] );
			excel.set( 0, 3, i, dataPage[ idx ][ "expendDate" ] );
			excel.set( 0, 4, i, dataPage[ idx ][ "expendReqDate" ] );
			excel.set( 0, 5, i, dataPage[ idx ][ "appUserName" ] );
			excel.set( 0, 6, i, dataPage[ idx ][ "expendUseDeptName" ] );
			excel.set( 0, 7, i, dataPage[ idx ][ "expendUseEmpName" ] );
			excel.set( 0, 8, i, dataPage[ idx ][ "expendAmt" ] );
			excel.set( 0, 9, i, dataPage[ idx ][ "expendErpSendYn" ] );
			excel.set( 0, 10, i, dataPage[ idx ][ "expendErpSendName" ] );
			excel.set( 0, 11, i, dataPage[ idx ][ "erpSendSeq" ] );
			
		}
		excel.generate( "지출결의현황.xlsx" );
		// END ---------------------------------------------------------------------------------------- excel 설정
	}
	
</script>

<!-- hidden -->
<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="searchDocFromDate" value=""
		id="searchDocFromDate" /> <input type="hidden" name=searchDocToDate
		value="" id="searchDocToDate" /> <input type="hidden"
		name="searchFromDate" value="" id="searchFromDate" /> <input
		type="hidden" name=searchToDate value="" id="searchToDate" /> <input
		type="hidden" name="appUserName" value="" id="appUserName" /> <input
		type="hidden" name="searchDocStatus" value="" id="searchDocStatus" />
	<input type="hidden" name="appDocNo" value="" id="appDocNo" /> <input
		type="hidden" name=appDocTitle value="" id="appDocTitle" /> <input
		type="hidden" name="expendUseDeptName" value="" id="expendUseDeptName" />
	<input type="hidden" name="expendUseEmpName" value=""
		id="expendUseEmpName" /> <input type="hidden" name="bizCd" value=""
		id="bizCd" /> <input type="hidden" name="formName" value=""
		id="formName" /> <input type="hidden" name="excelHeader" value=""
		id="excelHeader" /> <input type="hidden" name="fileName" value=""
		id="fileName">
</form>


<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<!-- 개발완료시 조건을 바꿔야됨(회사선택은  MASTER 권한)-->
			<c:if test="${ViewBag.empInfo.userSe == 'MASTER'}">
				<dt><%=BizboxAMessage.getMessage("TX000000047", "회사")%></dt>
				<dd>
					<div class="dod_search">
						<input type="text" id="selCompany" />
					</div>
				</dd>
			</c:if>
			<dt><%=BizboxAMessage.getMessage("TX000000938", "기안일자")%></dt>
			<dd>
			
				<div class="dal_div">
				<input id="txtDocFromDate" class="dpWid" />
				   <script type="text/javascript">
						var d = new Date()
						var monthOfYear = d.getMonth()
						d.setMonth(monthOfYear - 1)
						$("#txtDocFromDate").val(getFormatDateForDateObj(d)); 
					</script>
				</div>
				 ~ 
				 <div class="dal_div">
				 <input id="txtDocToDate" class="dpWid" />
					<script type="text/javascript"> 
						var d = new Date();
						$("#txtDocToDate").val(getFormatDateForDateObj(d));
					</script>
				</div>
			</dd>
			<dt><%=BizboxAMessage.getMessage("TX000000493", "제목")%></dt>
			<dd class="mr5">
				<input id="txtDocSubject" data-bind="value: appDocTitle" type="text"
					value="" style="width: 237px">
			</dd>
			<dt><%=BizboxAMessage.getMessage("TX000005832", "문서상태")%></dt>
			<dd>
				<select id="selDocStatus" style="width: 100px;" class="selectmenu">
				</select>
			</dd>

			<dd>
				<div class="controll_btn p0">
					<button id="btnReportExpendAdmSearch" class="btn_sc_add">${CL.ex_search}</button>
				</div>
			</dd>
		</dl>
		<span class="btn_Detail"><%=BizboxAMessage.getMessage("TX000005724", "상세검색")%> <img id="all_menu_btn"
			src='<c:url value="/Images/ico/ico_btn_arr_down01.png"/>' /></span>
	</div>

	<!-- 상세검색박스 -->
	<div class="SearchDetail">
		<dl>
			<dt style="width: 80px;"><%=BizboxAMessage.getMessage("TX000005174", "회계일자")%></dt>
			<dd class="mr5">
				<input id="txtFromDate" class="dpWid" /> ~ <input id="txtToDate"
					class="dpWid" />
			</dd>
			<dt style="width: 90px;">${CL.ex_paymentDate}</dt>
			<!-- 지급요청일 -->
			<dd class="mr5">
				<input id="txtReqFromDate" class="dpWid" /> ~ <input
					id="txtReqToDate" class="dpWid" />&nbsp;해당문서 대표 지급요청일 검색 (관리항목
				검색불가)
			</dd>
		</dl>
		<dl>
			<dt style="width: 80px;"><%=BizboxAMessage.getMessage("TX000000492", "문서분류")%></dt>
			<dd class="mr5">
				<input id="txtFormTitle" type="text" value="" style="width: 237px">
			</dd>
			<dt style="width: 90px;"><%=BizboxAMessage.getMessage("TX000000663", "문서번호")%></dt>
			<dd class="mr5">
				<input id="txtDocNo" data-bind="value: appDocNo" type="text"
					value="" style="width: 237px">
			</dd>
			<dt style="width: 90px;"><%=BizboxAMessage.getMessage("TX000000499", "기안자")%></dt>
			<dd>
				<input id="txtWriter" data-bind="value: appUserName" type="text"
					style="width: 120px;" />
			</dd>
		</dl>
		<dl>
			<dt style="width: 80px;"><%=BizboxAMessage.getMessage("TX000000811", "사업장")%></dt>
			<dd class="mr5">
				<select id="selAppBiz" class="selectmenu" style="width: 237px;">
				</select>
			</dd>
			<dt style="width: 90px;">${CL.ex_useDepartment}</dt>
			<dd class="mr5">
				<input id="txtUseDept" data-bind="value: expendUseDeptName"
					type="text" value="" style="width: 237px">
			</dd>
			<dt style="width: 90px;">${CL.ex_user}</dt>
			<dd class="mr5">
				<input id="txtUserNm" data-bind="value: expendUseEmpName"
					type="text" value="" style="width: 120px">
			</dd>
		</dl>
		<dl>
			<dt style="width: 80px;">${CL.ex_automaticSlipNumber}</dt>
			<dd class="mr5">
				<input type="text" id="txtErpAdocuNumber"
					data-bind="value: expendErpAdocuNumber" style="width: 237px;"
					class="puddSetup" value="" />
			</dd>
		</dl>
	</div>

	<div id="" class="controll_btn cl">
		<span class="fwb mt5" style="text-align:left;float:left">총 <span id="valTotalCount">0</span> 건</span>
		<button id="btnExcelDown" class="k-button">${CL.ex_excelDownload}</button><!-- 엑셀다운로드 -->
		<button id="btnExpendDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424", "삭제")%></button>
		<select class="selectmenu" id="selShowCount">
			<!-- 공통코드 처리 필요 -->
			<option value="10">10<%=BizboxAMessage.getMessage("TX000018780", "건 보기")%></option>
			<option value="20">20<%=BizboxAMessage.getMessage("TX000018780", "건 보기")%></option>
			<option value="30">30<%=BizboxAMessage.getMessage("TX000018780", "건 보기")%></option>
			<option value="40">40<%=BizboxAMessage.getMessage("TX000018780", "건 보기")%></option>
			<option value="50">50<%=BizboxAMessage.getMessage("TX000018780", "건 보기")%></option>
		</select>
	</div>

	<!-- 테이블 -->
	<div class="com_ta2 bg_lightgray">
		<table id="tblReportExpendAdmList">

		</table>
	</div>

	<div id="loadingProgressBar"></div>

</div>
<!-- //sub_contents_wrap -->


