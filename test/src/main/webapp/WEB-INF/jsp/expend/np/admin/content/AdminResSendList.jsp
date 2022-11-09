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

<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>

<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>
<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>

<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>

<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<jsp:include page="../../user/include/UserOptionMap.jsp" flush="false" />
<!-- /* 프로그레스 레이어 팝업 참조 */ -->
<jsp:include page="../../../../common/layer/ProgressLayerPop.jsp" flush="false" />
<script>
	var clickCount = 0;
	var timeOut;
	$(document).ready(function(){
		/* 페이지 초기화 */
		fnInit();
		/* 전송 리스트 조회 */
		fnGetResSendList();
	});

	function fnInit(){
		/* 레이아웃 정의 */
		fnInitLayout();

		/* 이벤트 정의 */
		fnInitEvent();

		/* 공통코드 팝업 정의 */
		fnSetCodePop();
	}

	function fnInitLayout(){
		
		if('${ViewBag.empInfo.langCode}'=='en'){
			Pudd.Resource.Calendar.weekName = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];
			Pudd.Resource.Calendar.todayNameStr = "today";
		}
		var toD = new Date();
		if (toD.getMonth() == 0) {
			var fromD = new Date(toD.getFullYear() - 1, 11, toD.getDate());
		} else {
			var fromD = new Date(toD.getFullYear(), toD.getMonth() - 1,	toD.getDate());
		}
		var fMonth = (fromD.getMonth() + 1);
		var tMonth = (toD.getMonth() + 1);
		var fDay = fromD.getDate();
		var tDay = toD.getDate();
		if(fMonth < 10){
			fMonth = "0" + fMonth;
		}
		if(tMonth < 10){
			tMonth = "0" + tMonth;
		}
		if(fDay < 10){
			fDay = "0" + fDay;
		}
		if(tDay < 10){
			tDay = "0" + tDay;
		}
		
		$("#txtFromDate").val(fromD.getFullYear() +"-" + fMonth +"-"+fDay);
		$("#txtToDate").val(toD.getFullYear() +"-" + tMonth +"-"+tDay);
		
		
		//fnSetDatepicker("#txtFromDate, #txtToDate","yy-mm-dd");
		//fnSetDatepicker("#txtExpFromDate, #txtToDate","yy-mm-dd");
		//fnSetDatepicker("#txtExpToDate, #txtToDate","yy-mm-dd");
	}

	function fnInitEvent(){
		/* 결의서 삭제 이벤트 */
		$('#btnResdelete').click(function(){
			if(!$('.chkSel:checked').length){
				alert('결의서를 선택하여 주세요.');
				return;
			}else{
				var chkSels = new Array();
				$(".chkSel:checked").each(function (){
					chkSels.push( JSON.parse($(this).closest('tr').attr('item')));	
				});
				
				var resDocSeqs = '';
				var docSeqs = '';
				var tripResDocSeqs = '';
				for(var i = 0; i < chkSels.length ; i++ ){
					var item = chkSels[i]; 
					
					if(item.erpSendYN == "Y"){
						alert('선택한 결의서 중에서 전송 결의서가 있습니다.');
						return;
					}else{
						resDocSeqs += ", '" + item.resDocSeq + "'" ;
						docSeqs += ", '" + item.docSeq + "'" ;
						if((item.tripResDocSeq||'')!=''){
							tripResDocSeqs +=  ", '" + item.tripResDocSeq + "'" ;
						}
					}
				}
				resDocSeqs = '(' + resDocSeqs.substr(1) + ')';
				docSeqs = '(' + docSeqs.substr(1) + ')';				
				tripResDocSeqs = '(' + tripResDocSeqs.substr(1) + ')';
				console.log('resDocSeqs : ' + resDocSeqs);
				console.log('docSeqs : ' + docSeqs);
				console.log('tripResDocSeqs : ' + tripResDocSeqs);
				
				
				if(confirm(  chkSels.length + '건의 결의서를 삭제하겠습니까?\n삭제된 결의서는 복구가 불가능 합니다.')){
					$.ajax({
			            type : 'post',
			            url : '<c:url value="/expend/np/admin/report/NpAdminResDelete.do" />',
			            datatype : 'json',
			            async : false,
			            data : {
			            	resDocSeqs : resDocSeqs
			            	, docSeqs : docSeqs
			            	, tripResDocSeqs : tripResDocSeqs
			            },
			            success : function( data ) {
							if(data.result.resultCode == 'SUCCESS'){
								alert('결의서 삭제가 완료되었습니다.');
								$('#btnSearch').click();
							}
			            },
			            error : function( data ) {
			            	alert('결의서 삭제도중 오류가 발생하였습니다.');
			            }
			        });
				}
			}
		});
		
		/* 전송 이벤트 테스트 */
		$('#btnSend').click(function (){
			if(!$('.chkSel:checked').length){
				alert('결의서를 선택하여 주세요.');
				return;
			}else{
				var chkSels = new Array();
				$(".chkSel:checked").each(function (){
					chkSels.push( JSON.parse($(this).closest('tr').attr('item')));	
				});
			}

			/* 결의서 전송 로직 시작 */
			fnSendResRecur(chkSels);
		});
		/* 전송 취소 이벤트 테스트 */
		$('#btnSendCancel').click(function (){
			if(!$('.chkSel:checked').length){
				alert('결의서를 선택하여 주세요.');
				return;
			}else{
				var chkSels = new Array();
				$(".chkSel:checked").each(function (){
					chkSels.push( JSON.parse($(this).closest('tr').attr('item')));	
				});
			}

			/* 결의서 전송 취소 로직 시작 */
			fnCancelResRecur(chkSels);
		});

		/* 리스트 조회 */
		$('#btnSearch').click(function (){
			fnGetResSendList();
		});

		/* 검색영역 엔터 이벤트 */
		$('.enter').keydown(function(event){
			if(event.keyCode == 13){
				$('#btnSearch').click();
			}
		});

		$(".button_dal").on("click",function(){
			if( !$("#txt" + $(this).attr("id").replace("btn","") ).datepicker("widget").is(":visible") ){
				$("#txt" + $(this).attr("id").replace("btn","") ).datepicker("show");
			}
		})

		/* 엑셀 다운로드 이벤트 정의 */
        $("#btnExcelDown").click(function(){
			fnAdminReportExcelDown();
		});
	}

	/*	[ 전송 ] 전송 재귀 관리
	--------------------------------------*/
	function fnSendResRecur(chkSels){
        /*서버 연산 진행중이면 리턴*/
		if(PLP_fnIsGetProgressing()){
			alert('결의서 전송이 진행중입니다.');
			return;
		}
        
    	/* 프로그레스 다이얼로그 시작 */ 
		PLP_fnShowProgressDialog({
			title : '결의서 전송'		
				, progText : '결의서 전송을 진행중입니다.'	 
				, endText : '전송이 완료되었습니다.'	
				, popupPageTitle : '결의서 전송 실패사유'	
				, popupColGbn : '문서번호'	
				, popupColDetail : '실패사유'	
		});
    	/* 프로그레스 진행상황 초기화 */
		PLP_fnSetProgressValue(0, 0, chkSels.length);
    	
		/* 결의서 전송 재귀호출 */
		setTimeout(fnRecurForSend, 50, 0, chkSels);
	}
	
	/*	[ 전송 ] 결의서 전송 재귀호출
	--------------------------------------*/
	function fnRecurForSend(idx, arr){
		/* 전송 완료 */
		if(idx >= arr.length){
			PLP_fnEndProgressDialog();
			$('#btnSearch').click();
			return;
		}
		/* 결의서 전송 */
		var item = arr[idx++];
		var length = arr.length;
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/np/admin/report/NpAdminSendRes.do" />',
            datatype : 'json',
            async : false,
            data : {
            	resDocSeq : item.resDocSeq
            },
            success : function( data ) {
				if(data.result.resultCode == 'FAIL'){
					PLP_fnSetErrInfo({
						'colGbn' : item.docNo
						, 'colDetail' : data.result.resultName
					});
					PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);	
				}else{
					PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
				}
				value = ( (idx * 1.0 ) / ( length * 1.0 )) * 100;
				setTimeout(fnRecurForSend, 300, idx, arr);
            },
            error : function( data ) {
            	PLP_fnSetErrInfo({
					'colGbn' : item.docNo
					, 'colDetail' : '[!] 서버 호출 에러 발생'
				});
				PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);
                console.log("! [EX][FNREPORTEXPENDADMSEARCH] ERROR - " + JSON.stringify(data));
                fnRecurForSend(idx, arr);
            }
        });
	}
	
	/*	[ 전송취소 ] 전송취소 재귀 관리
	--------------------------------------*/
	function fnCancelResRecur(chkSels){
		/*서버 연산 진행중이면 리턴*/
		if(PLP_fnIsGetProgressing()){
			alert('결의서 전송 취소가 진행중입니다.');
			return;
		}
    	/* 프로그레스 다이얼로그 시작 */ 
		PLP_fnShowProgressDialog({
			title : '결의서 전송 취소'		
				, progText : '결의서 전송 취소를 진행중입니다.'	 
				, endText : '전송 취소가 완료되었습니다.'	
				, popupPageTitle : '결의서 전송 취소 실패사유'	
				, popupColGbn : '문서번호'	
				, popupColDetail : '실패사유'	
		});
		/* 프로그레스 진행상황 초기화 */
		PLP_fnSetProgressValue(0, 0, chkSels.length);
		
		/* 결의서 전송 취소 재귀호출 */
		setTimeout(fnRecurForCancel, 50, 0, chkSels);
	}
	
	/*	[ 전송취소 ] 결의서 전송취소 재귀호출 TODO
	--------------------------------------*/
	function fnRecurForCancel(idx, arr){
		/* 전송 완료 */
		if(idx >= arr.length){
			PLP_fnEndProgressDialog();
			$('#btnSearch').click();
			return;
		}
		/* 결의서 전송 */
		var item = arr[idx++];
		var length = arr.length;
        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/np/admin/report/NpAdminSendCancelRes.do" />',
            datatype : 'json',
            async : false,
            data : {
            	resDocSeq : item.resDocSeq
            },
            success : function( data ) {
				if(data.result.resultCode == 'FAIL'){
					PLP_fnSetErrInfo({
						'colGbn' : item.docNo
						, 'colDetail' : data.result.resultName
					});
					PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);	
				}else{
					PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
				}
				value = ( (idx * 1.0 ) / ( length * 1.0 )) * 100;
				setTimeout(fnRecurForCancel, 300, idx, arr);
            },
            error : function( data ) {
            	PLP_fnSetErrInfo({
					'colGbn' : item.docNo
					, 'colDetail' : '[!] 서버 호출 에러 발생'
				});
				PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);
                console.log("! [EX][FNREPORTEXPENDADMSEARCH] ERROR - " + JSON.stringify(data));
                fnRecurForSend(idx, arr);
            }
        });
	}	
	
	 /*	[ 엑셀 ] 지출결의서 전송리스트 엑셀 다운로드
 	--------------------------------------*/
	function fnAdminReportExcelDown() {
		if(!sendListCnt){
			alert("${CL.ex_dataDoNotExists}");
			return;
		}

		$("#fileName").val( "지출결의전송" );

		/* Excel 헤더 정의 */
		var excelHeader = {};
		excelHeader.docNo = "문서번호";
		excelHeader.docTitle = "제목";
		excelHeader.repDate = "기안일";
		excelHeader.erpDivName = "회계단위";
		excelHeader.deptName = "사용부서";
		excelHeader.empName = "사용자";
		excelHeader.amt = "금액";
		excelHeader.erpSendYN = "전송여부";

		$("#excelHeader").val( JSON.stringify(excelHeader) );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}

	/*	[전송] 조회 파라미터 생성
	--------------------------------------------*/
	function fnGetSendListParams(){
		var param = {};

		param.fromDate = $("#txtFromDate").val().replace(/-/g,'');
		$('#formFromDate').val($("#txtFromDate").val().replace(/-/g,''));
        param.toDate = $("#txtToDate").val().replace(/-/g,'');
		$('#formToDate').val($("#txtToDate").val().replace(/-/g,''));
        param.docTitle = $("#txtDocTitle").val();
        $('#formDocTitle').val($("#txtDocTitle").val());
        param.erpSendYN = $("#selErpSendYN").val();
        $('#formErpSend').val($("#selErpSendYN").val());

        param.docNo = $("#txtDocNo").val();
        $('#formDocNo').val($("#txtDocNo").val());
        param.erpDeptName = $("#txtDeptName").val();
        $('#formErpDeptName').val($("#txtDeptName").val());
        param.erpEmpName = $("#txtWriterName").val();
        $('#formErpEmpName').val($("#txtWriterName").val());

        param.docuFg = $("#txtDocuFg").val();
        $('#formDocuFg').val($("#txtDocuFg").val());
        // param.expendToDate = $("#txtExpFromDate").val().replace(/-/g,'');
        // $('#formExpendToDate').val($("#txtExpFromDate").val().replace(/-/g,''));
        // param.expendFromDate = $("#txtExpToDate").val().replace(/-/g,'');
        // $('#formExpendFromDate').val($("#txtExpToDate").val().replace(/-/g,''));
        param.erpMgtSeq = $("#hidMgtSeq").val();
        $('#formErpMgtSeq').val($("#hidMgtSeq").val());

        param.resNote = $("#txtNote").val();
        $('#formResNote').val($("#txtNote").val());
        param.erpAbgtName = $("#txtAbgtName").val();
        $('#formErpAbgtName').val($("#txtAbgtName").val());
        param.erpDivSeq = $("#hidDivSeq").val();
        $('#formErpDivSeq').val($("#hidDivSeq").val());

        param.senderName = $("#txtSendName").val();
        $('formSenderName').val($("#txtSendName").val());

		return param;
	}

	/*	[전송 리스트] 결의서 전송 리스트 조회
	--------------------------------------------*/
	function fnGetResSendList(){
        var param = fnGetSendListParams();
        

        console.log(param);

        $.ajax({
            type : 'post',
            url : '<c:url value="/expend/np/admin/report/NpAdminSendListSelect.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	fnSetGridSendList2(data.result.aaData);
            	$('#chkAll').prop('checked', false);
            },
            error : function( data ) {
                console.log("! [EX][FNREPORTEXPENDADMSEARCH] ERROR - " + JSON.stringify(data));
            }
        });
	}

	
	var sendListCnt = 0 ;
	/*	[전송 리스트] 결의서 전송 리스트 출력 2.0
	--------------------------------------------*/
	function fnSetGridSendList2(aaData){
		console.log('**************************** 지출결의 전송 리스트 출력2 ****************************');
		sendListCnt = aaData.length;
		
		$('#txt_reportCnt').html(aaData.length.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		
		/* 테이블 생성시작 */
		$("#divGridArea").html("");
		$('.gt_paging').remove();
		
		$("#divGridArea").GridTable({
			'tTablename': 'gridResSend'
            , 'nTableType': 1 
            , 'nHeight': 600
            , 'module' : 'expReport'
            , 'bNoHover' : true      
            , 'oNoData': {                 // 데이터가 존재하지 않는 경우 
                'tText': '${CL.ex_NotExistData}' // 출력 텍스트 설정
            }
            , "data": aaData
	        , 'oPage': {                   // 사용자 페이징 정보
	            'nItemSize': 15               // 페이지별 아이템 갯수(기본 값. 10)
	            , 'anPageSelector' : [15, 35, 50, 100] // 아이템 갯수 선택 셀렉트 구성
	        }
	        , "aoHeaderInfo": [{                  // [*] 테이블 헤더 정보입니다.
	            no: '0'                        // 컬럼 시퀀스입니다.
	            , renderValue: '<input type="checkbox" id="chkAll" name="chkAll" onclick="fnAllChk();">'
	            , colgroup: '5'
	        }, {
	            no: '1'
	            , renderValue: "${CL.ex_docNm}"
	            , colgroup: '20'
	        }, {
	            no: '2'
	            , renderValue: "${CL.ex_title}"
	            , colgroup: '40'
	        }, {
	            no: '3'
	            , renderValue: '${CL.ex_draftDate}'
	            , colgroup: '18'
	        }, {
	            no: '4'
	            , renderValue: '${CL.ex_accountingUnit}'
	            , colgroup: '25'
	        }, {
	            no: '5'
		        , renderValue: '${CL.ex_useDepartment}'
	            , colgroup: '17'
	        }, {
	            no: '6'
		        , renderValue: '${CL.ex_user}'
	            , colgroup: '12'
	        }, {
	            no: '7'
		        , renderValue: '${CL.ex_amount}'
	            , colgroup: '20'
	        }, {
	            no: '8'
		        , renderValue: '${CL.ex_sending}'
	            , colgroup: '12'
	        }]
            , "aoDataRender": [{          // [*] 실제 데이터 표기 방법에 대하여 지정합니다.
                no: '0',      
                render: function (idx, item) {                        	                     	
                	return '<input type="checkbox" class="chkSel" id="chk_'+item.resDocSeq+'" value="'+item.resDocSeq+'"/>';
                }
            }, {
                no: '1',
                render: function (idx, item) {      
                	if(item.eaType == 'EAP'){
                		return '<a class="resDocEAP" style="cursor:pointer" title="결의문서보기">' + item.docNo + '</a>';
                	}
                	return '<a class="resDoc" style="cursor:pointer" title="결의문서보기">' + item.docNo + '</a>';
                } ,
                class: 'le'
            }, {
                no: '2',
                render: function (idx, item) {   
    				if((item.confferDocSeq || '') !== ''){
    					if(item.eaType == 'EAP'){
    						return item.docTitle + ' <a class="confferDocEAP" style="cursor:pointer" title="참조품의보기"><img src="../../../Images/ico/ico_file_drop.png"></a>';
                    	}	
    					return item.docTitle + ' <a class="confferDoc" style="cursor:pointer" title="참조품의보기"><img src="../../../Images/ico/ico_file_drop.png"></a>';
    				}
                	return item.docTitle;
                } ,
                class: 'le'
            }, {
                no: '3',
                render: function (idx, item) {                        	                     	
                	return item.repDate;
                }
            }, {
                no: '4',
                render: function (idx, item) {                        	                     	
                	return ( item.erpPcName || item.erpDivName);
                }
            }, {
                no: '5',
                render: function (idx, item) {                        	                     	
                	return item.erpDeptName;
                }
            }, {
                no: '6',
                render: function (idx, item) {                        	                     	
                	return item.empName;
                }
            }, {
                no: '7',
                render: function (idx, item) {                        	                     	
                	return item.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                } ,
                class: 'ri'
            }, {
                no: '8',
                render: function (idx, item) {       
                	if(item.erpSendYN == 'Y'){
                		return '${CL.ex_trans}';
                	}else{
                		return '${CL.ex_notTrans}';
                	}
                }
            }]
	        , 'fnGetDetailInfo' : function(){
	        	console.log ('get detail info'); 
	        }
	        , 'fnTableDraw' : function(){
	        	/* 페이지 리사이즈 */
	        	$('.rightContents').height(572);
	        	
	        	$('#chkAll').click(function (){
	        		if($("#chkAll").prop("checked")) {
		    			$(".chkSel").prop("checked",true);
		    		} else {
		    			$(".chkSel").prop("checked",false);
		    		}	
	        	});
	        }
	        , 'fnRowCallBack' : function(row, aData){
	        	/* 참조품의 결의서인 경우 */
	        	if(aData.confferDocSeq){
	        		$(row).find('.confferDoc').click(function(){
	        			fnAppdocPop(aData.confferDocSeq, aData.confferFormSeq);
	        		});
	        	}
	        	
	        	$(row).find('.resDoc').click(function(){
        			fnAppdocPop(aData.docSeq, aData.formSeq);
        		});
	        	
	        	/*------------------------------*/
	        	
	        	/* 참조품의 결의서인 경우 */
	        	if(aData.confferDocSeq){
	        		$(row).find('.confferDocEAP').click(function(){
	        			fnAppdocPopEAP(aData.confferDocSeq, aData.confferFormSeq);
	        		});
	        	}
	        	
	        	$(row).find('.resDocEAP').click(function(){
        			fnAppdocPopEAP(aData.docSeq, aData.formSeq);
        		});
	        }
		});	
	}
	
	/*	[전송 리스트] 결의서 전송 리스트 출력
	--------------------------------------------*/
 	function fnSetGridSendList(aaData){
 		console.log('**************************** 지출결의 전송 리스트 출력 ****************************');
 		sendListCnt = aaData.length;

		$("#tblResList").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="34"/>';
		colGroup += '<col width="15%"/>';
		colGroup += '<col width="20%"/>';
		colGroup += '<col width="10%"/>';
		colGroup += '<col width="15%"/>';
		colGroup += '<col width="10%"/>';
		colGroup += '<col width="10%"/>';
		colGroup += '<col width="10%"/>';
		colGroup += '<col width="10%"/>';
		colGroup += '</colgroup>';
		$("#tblResList").append(colGroup);

		if(aaData.length == 0){
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="' + $("#tblResList colgroup col").length + '">${CL.ex_dataDoNotExists}</td>')
			$("#tblResList").append(tr);
		}else{
			$.each(aaData,function(idx, val){
				var tr = document.createElement('tr');
				$(tr).data('data', val);
				$(tr).append('<td><input type="checkbox" class="chkSel" id="chk_'+val.resDocSeq+'" value="'+val.resDocSeq+'"/>' + '</td>')

				/* 문서번호 전자결재 팝업처리 (결의서) */
				var td = document.createElement('td');
				$(td).data('data', val);
				$(td).text(val.docNo);
				$(td).css('cursor', 'pointer');
				$(tr).append(td);
				// $(tr).append('<td>' + val.docNo + '</td>');

				/* 제목 전자결재 팝업처리 (참조 품의서) */
				var td = document.createElement('td');
				var confferVal = JSON.parse(JSON.stringify(val));
				confferVal.docSeq = confferVal.confferDocSeq;
				confferVal.formSeq = confferVal.confferFormSeq;
				$(td).data('data', confferVal);
				if((confferVal.confferDocSeq || '') !== ''){
					$(td).text(confferVal.docTitle + ' [참조품의보기]');
					$(td).css('cursor', 'pointer');
				} else {
					$(td).text(confferVal.docTitle);
				}
				$(td).addClass('le');
				$(tr).append(td);

				// $(tr).append('<td class="le">' + val.docTitle + '</td>');
				$(tr).append('<td>' + val.repDate + '</td>');
				$(tr).append('<td>' + ( val.erpPcName || val.erpDivName) + '</td>');
				$(tr).append('<td>' + val.erpDeptName + '</td>');
				$(tr).append('<td>' + val.erpEmpName + '</td>');
				$(tr).append('<td class="ri">' + val.amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>');
				if( val.erpSendYN === 'Y'){
					$(tr).append('<td>${CL.ex_trans}</td>');
				}else{
					$(tr).append('<td>${CL.ex_notTrans}</td>');
				}

				$("#tblResList").append(tr);
			});
			fnTableClickEvent();
		}
 	}

 	/*	[전송 리스트] 리스트 클릭 이벤트 추가
	--------------------------------------------*/
	function fnTableClickEvent(){
		$("#tblResList tbody tr td").unbind().on("click",function(e){
			if($(this).data('data') !== undefined){
				if(!$(this).data('data').docSeq){
					// alert('참조된 품의서가 없습니다.');
				}else{
					fnAppdocPop($(this).data('data').docSeq, $(this).data('data').formSeq);
				}
			}
		});
 	}

 	/*	[전송 리스트] 체크박스 전체 체크
	--------------------------------------------*/
	function fnAllChk(){
		if($("#chkAll").prop("checked")) {
			$("#tblResList input[type=checkbox]").prop("checked",true);
		} else {
			$("#tblResList input[type=checkbox]").prop("checked",false);
		}
 	}

	/* 데이트 피커 설정 - 공통 변환 예정*/
	function fnSetDatepicker(id, format){
		$(id).datepicker({
	  		closeText: '닫기',
	        prevText: '이전달',
	        nextText: '다음달',
	        currentText: '오늘',
	        monthNames: ['1월','2월','3월','4월','5월','6월',
	        '7월','8월','9월','10월','11월','12월'],
	        monthNamesShort: ['1월','2월','3월','4월','5월','6월',
	        '7월','8월','9월','10월','11월','12월'],
	        dayNames: ['일','월','화','수','목','금','토'],
	        dayNamesShort: ['일','월','화','수','목','금','토'],
	        dayNamesMin: ['일','월','화','수','목','금','토'],
	        weekHeader: 'Wk',
	        firstDay: 0,
	        isRTL: false,
	        duration:200,
	        showAnim:'show',
	        showMonthAfterYear: true,
			dateFormat: format
		});
	}

	
	/*	[영리] 전자결재 문서 창
	--------------------------------------------*/
	function fnAppdocPopEAP(docSeq, formSeq) {
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

		var url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq + "&form_id=" + formSeq + "&doc_auth=1";
		window.open(url, 'AppDoc', 'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
	}
	
	/*	[비영리] 전자결재 문서 창
	--------------------------------------------*/
	function fnAppdocPop(docSeq, formSeq) {
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
		var url = "";
		var eaType = "${loginVo.eaType}";
		var popName = "";
		if( eaType == "eap"){
			popName = "AppDoc";
			url = "/eap/ea/docpop/EAAppDocViewPop.do?doc_id=" + docSeq + "&form_id=" + formSeq + "&doc_auth=1";
		}else{
			var param = "diKeyCode=" + docSeq + "&mode=reading";
			popName = "popDocApprovalEdit";
			param= "multiViewYN=N&"+param;
			url = "/ea/edoc/eapproval/docCommonDraftView.do?"+ param;
		}
		window.open(url, popName,'menubar=0,resizable=0,scrollbars=1,status=no,titlebar=0,toolbar=no,width='
						+ intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
	}


	/* [공통] 검색 필터 공통팝업 등록
	----------------------------------------- */
	function fnSetCodePop(){

		$('#btnSelMgt').click(function(){
			fnCallCommonCodePop ( {
				code: 'project',
				popupType: 2,
				param: JSON.stringify ( {} ),
				callbackFunction: "fnCommonPopCallback",
				dummy: 'project'
			} );
		});

		$('#btnSelAbgt').click(function(){
			fnCallCommonCodePop ( {
				code: 'budgetlist',
				popupType: 2,
				param: JSON.stringify ( {} ),
				callbackFunction: "fnCommonPopCallback",
				dummy: 'budget'
			} );
		});

		$('#btnSelPc').click(function(){			
			fnCallCommonCodePop ( {
				code: 'div',
				popupType: 2,
				param: JSON.stringify ( {
					widthSize : "487"
					, heightSize : "580"
				} ),
				callbackFunction: "fnCommonPopCallback",
				dummy: 'pc'
			} );
		});
	}

	/* [공통] 공통코드 팝업 - 콜백
	----------------------------------------- */
	function fnCommonPopCallback(param){
		if(param.code == 'project'){
			$('#txtMgtName').val(param.erpMgtName);
			$('#hidMgtSeq').val(param.erpMgtSeq);
		}else if(param.code == 'budgetlist'){
			$('#txtAbgtName').val(param.erpMgtName);
			$('#hidAbgtSeq').val(param.erpMgtSeq);
		}else if(param.code == 'div'){
			$('#txtErpDivName').val(param.divName);
			$('#hidDivSeq').val(param.divSeq);
		}
	}

	/* [공통] 공통코드 팝업
	----------------------------------------- */
	function fnCommonPop ( code, data ) {
		var enterFlag = true;
		/* 코드도움 f2 누를경우 */
		var parameter = {};
		var commonCodeData = [ ];
		/* 기본 파라미터 정의 */
		parameter.searchStr = $.fn.extable.options [ data.tblId ].rightContentTable.find ( 'input' ).val ( )
		parameter.erpDeptSeq = optionSet.erpEmpInfo.erpDeptSeq;
		parameter.erpBizSeq = optionSet.erpEmpInfo.erpBizSeq;
		parameter.erpPcSeq = optionSet.erpEmpInfo.erpPcSeq;

		callbackTableFocusX = data.colIndex;
		callbackTableFocusY = data.rowIndex;
		var rowData = table.rowData ( $ ( '#' + data.tblId ), data.rowIndex );
		var selResData = table.selectRowData ( $ ( tbl.res ) );
		if ( optionSet.conVo.erpTypeCode == "ERPiU" ) {
			switch ( code.toLowerCase() ) {
				case "budget":
					parameter.widthSize = "628";
					parameter.heightSize = "546";
					break;
				case "bizplan":
					/* 사업계획 파라미터 정의 */
					/*
						useYNCondition : 사용유무 검색조건(A:전체, Y:사용, N:미사용)
						isConnectedBudget : 연결사업계획 조건( Y:연결사업계획 , '':전체)
					 */
					parameter.erpBudgetSeq = rowData.erpBudgetSeq;
					parameter.widthSize = "728";
					parameter.heightSize = "580";
					break;
				case "bgacct":
					/* 예산계정 파라미터 정의 */
					/*
						bgacctType : 결의구분 ( A:전체, '':결의구분 )
						isConnectedBizplan : 연결계정 ( Y:연결계정, '':전체)
					 */
					// 						parameter.bgtYear = '2017';
					parameter.erpBudgetSeq = rowData.erpBudgetSeq;
					parameter.erpBizplanSeq = rowData.erpBizplanSeq;
					parameter.widthSize = "728";
					parameter.heightSize = "580";
					break;
				case "fiacct":
					/* 회계계정 파라미터 정의 */
					parameter.erpBgacctSeq = rowData.erpBgacctSeq;
					parameter.widthSize = "628";
					parameter.heightSize = "580";
					break;
				case "bank":
					/* 회계계정 파라미터 정의 */
					parameter.btrName = rowData.btrName;
					parameter.btrSeq = rowData.btrSeq;
					parameter.widthSize = "528";
					parameter.heightSize = "546";
					break;
				case "tretc":
					parameter.trName = rowData.etcName;
					parameter.resDate = rowResData.data.resDate.replace(/\-/g,'');
					parameter.widthSize = "595";
					parameter.heightSize = "546";
					break;
				case "trbus":
					parameter.trName = rowData.bizIncomName;
					parameter.resDate = rowResData.data.resDate.replace(/\-/g,'');
					parameter.widthSize = "595";
					parameter.heightSize = "580";
					break;
				case "emp":
					parameter.widthSize = "438";
					parameter.heightSize = "580";
					break;
				case "tr":
					parameter.widthSize = "828";
					parameter.heightSize = "580";
					break;
				default:
					break;
			}
		} else if ( optionSet.conVo.erpTypeCode == "iCUBE" ) {
			switch ( code.toLowerCase() ) {
				case "div":
					parameter.widthSize = "248";
					parameter.heightSize = "360";
					/* 프로젝트 파라미터 정의 */
				break;
				case "project":
					parameter.widthSize = "549";
					parameter.heightSize = "580";
					/* 프로젝트 파라미터 정의 */
					break;
				case "tr":
					parameter.widthSize = "699";
					parameter.heightSize = "580";
					/* 거래처 파라미터 정의 */
					/* 1: 일반거래처, 2: 금융거래처*/
					parameter.trType = ""
					break;
				case "btrtr":
					/* 입출금계좌 파라미터 정의 */
					/* 1: 일반거래처, 2: 금융거래처*/
					parameter.trType = "2"
					parameter.widthSize = "699";
					parameter.heightSize = "580";
					break;
				case "budgetlist":
					if(data.data.erpBudgetSeqG20 != "") {
						enterFlag = false;
					}
					/* 예산과목 파라미터 정의 */
					parameter.erpGisu = optionSet.erpGisu.gisu;		/* ERP 기수 */
					parameter.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
					parameter.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
					parameter.gisu = optionSet.erpGisu.gisu;		/* ERP 기수 */
					parameter.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
					parameter.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
					parameter.erpDivSeq =	optionSet.erpEmpInfo.erpDivSeq + "|"; /* 회계통제단위 구분값 '|' */
					parameter.projectSeq = selResData.data.projectSeq; /* 예산통제단위 구분값 '|' */
					parameter.erpMgtSeq = selResData.data.projectSeq + "|";
					parameter.opt01 = '2'; /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */
					parameter.opt02 = '1'; /* 1: 모두표시, 2: 사용기한결과분 숨김 */
					parameter.opt03 = '';
					parameter.widthSize = '780';
					parameter.heightSize = '580';
					break;
				case "div":
					parameter.widthSize = "487";
					parameter.heightSize = "580";
					/* 회계단위 파라미터 정의 */
					break;
				case "emp":
					parameter.subUseYN = "";
					parameter.baseDate = "";
					parameter.widthSize = "549";
					parameter.heightSize = "580";
					//parameter.erpDivSeq = optionSet.erpEmpInfo.erpDivSeq;
					//parameter.erpDeptSeq = optionSet.erpEmpInfo.erpDeptSeq;
				case "bank":
					/* 회계계정 파라미터 정의 */
					parameter.btrName = rowData.btrName;
					parameter.btrSeq = rowData.btrSeq;
					parameter.widthSize = "549";
					parameter.heightSize = "580";
					break;
				case "income":
					parameter.widthSize = "549";
					parameter.heightSize = "580";
					parameter.residence = rowData.incomeGubun;
					break;
				case "erphpmeticlist" :
					parameter.widthSize = "549";
					parameter.heightSize = "580";
					break;
				case "erphincomeiclist" :
					parameter.widthSize = "549";
					parameter.heightSize = "580";
					break;
				default:
					break;
	    	}
		}

		/*
			공통팝업 호출
			code : 호출하고자 하는 공통코드 구분 코드 입력(예 : Biz, Emp 등)
			popupType : 코드 조회 방식(1 : 코드 직접 호출, 2 : 일반 팝업 호출, 3 : 레이어 팝업 호출)
			param : 공통코드 호출 시 필요한 파라미터 입력(예 : {"name":"홍길동","searchStr":"검색어"})
			callbackFunction : 콜백함수 명칭 (예 : fnCallbackFunction)
			dummy : 콜백 시 다시 받을 변수 저장(예: {"focusX":"1","focusY":"1"})

		 */
		fnCallCommonCodePop ( {
			code: code,
			popupType: 2,
			param: JSON.stringify ( parameter ),
			callbackFunction: "fnCommonPopCallback",
			dummy: JSON.stringify ( data )
		} );
	}

</script>



<form id="excelDownload" name="excel" method="post">
    <input type="hidden" name="fromDate" value="" id="formFromDate" />
    <input type="hidden" name="toDate" value="" id="formToDate" />
    <input type="hidden" name="docTitle" value="" id="formDocTitle" />
    <input type="hidden" name="erpSend" value="" id="formErpSend" />

    <input type="hidden" name="docNo" value="" id="formDocNo" />
    <input type="hidden" name="erpDeptName" value="" id="formErpDeptName" />
    <input type="hidden" name="erpEmpName" value="" id="formErpEmpName" />

    <input type="hidden" name="docuFg" value="" id="formDocuFg" />
    <input type="hidden" name="expendToDate" value="" id="formExpendToDate" />
    <input type="hidden" name="expendFromDate" value="" id="formExpendFromDate" />
    <input type="hidden" name="erpMgtSeq" value="" id="formErpMgtSeq" />

    <input type="hidden" name="resNote" value="" id="formResNote" />
    <input type="hidden" name="erpAbgtName" value="" id="formErpAbgtName" />
    <input type="hidden" name="erpDivSeq" value="" id="formErpDivSeq" />

    <input type="hidden" name="senderName" value="" id="formSenderName" />

    <input type="hidden" name="excelHeader" value="" id="excelHeader" />
    <input type="hidden" name="fileName" value="" id="fileName">
</form>

<!-- body -->
<div class="sub_contents_wrap">
    <!-- 컨트롤박스 -->
    <div class="top_box">
        <dl>
            <dt><%=BizboxAMessage.getMessage("TX000000938","기안일자")%></dt>
            <dd>
                <div class="dal_div">
                    <input type="text" autocomplete="off" id="txtFromDate" class="w113 enter puddSetup" pudd-type="datepicker"/>
                    
                </div>
                ~
                <div class="dal_div">
                    <input type="text" autocomplete="off" id="txtToDate" class="w113 enter puddSetup" pudd-type="datepicker"/>
                    
                </div>
            </dd>
            <dt><%=BizboxAMessage.getMessage("TX000000493","제목")%></dt>
            <dd>
                <input id="txtDocTitle" class="enter" type="text" value="" style="width: 200px">
            </dd>
            <dt>${CL.ex_transCheck}  <!--전송여부--></dt>
            <dd>
                <select id="selErpSendYN" class="selectmenu enter">
                    <option value="">${CL.ex_all}  <!--전체--></option>
                    <option value="Y">${CL.ex_trans}  <!--전송--></option>
                    <option value="N">${CL.ex_notTrans}  <!--미전송--></option>
                </select>
            </dd>
            <dd>
                <input type="button" id="btnSearch" value="${CL.ex_search}" /><!--검색-->
            </dd>
        </dl>
        <span class="btn_Detail">
            <%=BizboxAMessage.getMessage("TX000005724","상세검색")%><img id="all_menu_btn"
                                                                     src='<c:url value="/Images/ico/ico_btn_arr_down01.png"/>' />
        </span>
    </div>
    <!-- 상세검색박스 -->
    <div class="SearchDetail">
        <dl>
            <dt style="width:70px;">${CL.ex_docNm}  <!--문서번호--></dt>
            <dd class="mr5" style="width:250px;">
                <input id="txtDocNo" class="enter" type="text" value="" style="width: 229px">
            </dd>

            <dt style="width:70px;">${CL.ex_draftDept}  <!--기안부서--></dt>
            <dd class="mr5" style="width:250px;">
                <input id="txtDeptName" class="enter" type="text" value="" style="width: 229px">
            </dd>

            <dt style="width:70px;">${CL.ex_drafter}  <!--기안자--></dt>
            <dd class="mr5" style="width:250px;">
                <input id="txtWriterName" class="enter" type="text" value="" style="width: 229px">
            </dd>
        </dl>

        <dl>
        	<div id="erpDivArea">
	        	<dt style="width:70px;">${CL.ex_accountingUnit}  <!--회계단위--></dt>
	            <dd class="mr5" style="width:250px;">
	                <input id="txtErpDivName" type="text" class="enter" value="" style="width: 176px">
	                <hidden id="hidDivSeq" type="text" value="" style="width: 150px">
	                    <input type="button" id="btnSelPc" value="${CL.ex_select}" style="width: 50px" /><!--선택-->
	            </dd>
        	</div>
            
            <dt style="width:70px;">${CL.ex_transfer}  <!--전송자--></dt>
            <dd class="mr5" style="width:250px;">
                <input id="txtSendName" type="text" class="enter" value="" style="width: 229px">
            </dd>
        </dl>
    </div>
    <div id="" class="btn_div cl">
    	<div class="left_div fwb mt5"> 
			${CL.ex_yeCount} <span id="txt_reportCnt"> - </span> ${CL.ex_gun}
		</div>
    
        <div class="right_div">
            <div class="controll_btn p0">
                <button id="btnExcelDown" class="k-button">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
                <button type="button" id="btnSend"><%=BizboxAMessage.getMessage("TX000002999","전송")%></button>
                <button type="button" id="btnSendCancel"><%=BizboxAMessage.getMessage("TX000003157","전송취소")%></button>
                <button type="button" id="btnResdelete">${CL.ex_resDel}  <!--결의서삭제--></button>
            </div>
        </div>
        <!-- <select class="selectmenu" id="selViewLength">공통코드 처리 필요 -->
        <!-- <option value="10">10<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option> -->
        <!-- <option value="20">20<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option> -->
        <!-- <option value="30">30<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option> -->
        <!-- <option value="40">40<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option> -->
        <!-- <option value="50">50<%=BizboxAMessage.getMessage("TX000018780","건 보기")%></option> -->
        <!-- 		</select> -->
    </div>

    <div class="com_ta2">
    
    	<div id="divGridArea"> 
		</div>
    
<!--         <table id="tblResListHead"> -->
<%--             <colgroup> --%>
<%--                 <col width="34" /> --%>
<%--                 <col width="15%" /> --%>
<%--                 <col width="20%" /> --%>
<%--                 <col width="10%" /> --%>
<%--                 <col width="15%" /> --%>
<%--                 <col width="10%" /> --%>
<%--                 <col width="10%" /> --%>
<%--                 <col width="10%" /> --%>
<%--                 <col width="10%" /> --%>
<%--             </colgroup> --%>
<!--             <tr> -->
<!--                 <th><input type="checkbox" id="chkAll" name="chkAll" onclick="fnAllChk();"></th> -->
<!--                 <th>문서번호</th> -->
<!--                 <th>제목</th> -->
<!--                 <th>기안일자</th> -->
<!--                 <th>회계단위</th> -->
<!--                 <th>사용부서</th> -->
<!--                 <th>사용자</th> -->
<!--                 <th>금액</th> -->
<!--                 <th>전송여부</th> -->
<!--             </tr> -->
<!--         </table> -->
        <table id="tblResList"></table>
    </div>
</div>
