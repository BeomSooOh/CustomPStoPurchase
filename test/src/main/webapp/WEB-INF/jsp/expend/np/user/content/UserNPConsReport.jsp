<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>


<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>
<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />
<script>
	function getFormatDate(date){
		var year = date.getFullYear();                                 //yyyy
		var month = (1 + date.getMonth());                     //M
		month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
		var day = date.getDate();                                        //d
		day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
		return  year + '-' + month + '-' + day;
	}
</script>
<div class="sub_contents_wrap">
	<!-- 컨트롤박스 -->
	<div class="top_box">
		<dl>
			<dt>${CL.ex_draftDate}  <!--기안일자--></dt>
			<dd>
				<div class="dal_div">
					<input type="text" autocomplete="off" value="" id="txtFromDate" class="w113 puddSetup" pudd-type="datepicker" />
					<script type="text/javascript">
						var d = new Date()
						var monthOfYear = d.getMonth()
						d.setMonth(monthOfYear - 1)
						$("#txtFromDate").val(getFormatDate(d));
					</script>
				</div>
				~
				<div class="dal_div"> 
					<input type="text" autocomplete="off" value="" id="txtToDate" class="w113 puddSetup" pudd-type="datepicker" />
					<script type="text/javascript">
						var d = new Date();
						$("#txtToDate").val(getFormatDate(d));
					</script>
				</div>
			</dd>
			<dt>${CL.ex_title}  <!--제목--></dt>
			<dd><input type="text" autocomplete="off" class="enter" id="txtDoctitle" style="width:186px;" /></dd>
			<dt>${CL.ex_appCondition}  <!--결재상태--></dt>
			<dd>
				<select id="selDocStatus" class="selectmenu" style="width:100px;">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="001">${CL.ex_temporarySave}  <!--임시저장--></option>
					<option value="002">${CL.ex_onGoing}  <!--진행중--></option>
					<option value="003">${CL.ex_coopering}  <!--협조중--></option>
					<option value="005">${CL.ex_docReturn}  <!--문서회수--></option>
					<option value="006">${CL.ex_multiDeptReceipting}  <!--다중부서접수중--></option>
					<option value="009">${CL.ex_sendDemand}  <!--발송요구--></option>
					<option value="008">${CL.ex_appComplete}  <!--결재완료--></option>
					<option value="007">${CL.ex_draftCancel}  <!--기안반려--></option>
				</select>
			</dd>
			<dd><input type="button" id="btnSearch" value="${CL.ex_search}" /></dd>  <!--검색-->
		</dl>
		<span class="btn_Detail">${CL.ex_detailSearch}  <!--상세검색--> <img id="all_menu_btn" src="../../../Images/ico/ico_btn_arr_down01.png"/></span>
	</div>

	<!-- 상세검색박스 -->
	<div class="SearchDetail mb10">
		<dl>	
			<dt>${CL.ex_docNm}  <!--문서번호--></dt>
			<dd><input type="text" autocomplete="off"  class="enter"  id="txtDocNo" style="width:150px;" /></dd>
<%-- 			<dt style="width:70px;">${CL.ex_accountingUnit}</dt> --%>
<!-- 			<dd><input type="text" autocomplete="off"  class="enter"  id="txtErpDivSeq" style="width:150px;" /></dd> -->
		</dl>
	</div>			
                      
    <!-- 버튼 -->
    <div class="btn_div cl">
    	<div class="left_div fwb mt5">
			${CL.ex_yeCount} <span class="" id="consReportCnt">-</span> ${CL.ex_gun}
    	</div>
		<div class="right_div">							
			<div class="controll_btn p0">
				<button id="btnExcelDown" class="k-button">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
			</div>
		</div>
	</div>
	<div class="com_ta2">
		<div id="divGridArea"> 
		</div>
	</div>
</div><!-- //sub_contents_wrap -->


<script>
	
	/*	[ready] 사용자 - 품의 현황 준비
	---------------------------------------- */
	$(document).ready(function(){
		/* 문서 양식 초기화 */
		fnInitForm();
		
		/* 품의서 리스트 조회 */
		fnSelectConsList();
		
		/* 버튼 이벤트 설정 */
		fnSetBtnEvent();
	});
	
	
	/*	[버튼] 버튼 이벤트 설정
	---------------------------------------- */
	function fnSetBtnEvent(){
		// 검색 버튼 설정
		$('#btnSearch').click(function(){
			fnSelectConsList();
		});
		
		// 엔터 이벤트 적요
		$('.enter').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;

                $('#btnSearch').click();
            }
        });
		
		/* 엑셀 다운로드 이벤트 정의 */
        $("#btnExcelDown").click(function(){
			fnAdminReportExcelDown();
		});
	}
	
	 /*	[ 엑셀 ] 품의서 현황 엑셀 다운로드
	--------------------------------------*/
	function fnAdminReportExcelDown() {
		if(!CONS_LIST.length){
			alert("${CL.ex_dataDoNotExists}");
			return;
		}
		
		$("#fileName").val( "나의품의서현황" );
			
		/* Excel 헤더 정의 */
		var excelHeader = {};
		excelHeader.docNo = "문서번호";
		excelHeader.docTitle = "제목";
		excelHeader.docDate = "기안일자";
		excelHeader.consDocAmt = "품의금액";
		excelHeader.docStatus = "결재상태";
		
		/* 엑셀 헤더 지정 */
		$("#excelHeader").val( JSON.stringify(excelHeader) );
		
		for(var i = 0; i < CONS_LIST.length; i++){
			var item = CONS_LIST[i];
			item.docStatus = fnGetDocStatusLabel(item.docStatus);
		}
		/* 엑셀 데이터 지정 */
		$("#tableData").val( JSON.stringify(CONS_LIST) );
		
		var url = "<c:url value='/ex/user/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
	
	/*	[초기화] 문서 양식 초기화
	---------------------------------------- */
	function fnInitForm(){
		// 데이트 피커 설정
		//fnSetDatepicker("#txtFromDate, #txtToDate","yy-mm-dd");
		if('${ViewBag.empInfo.langCode}'=='en'){
			Pudd.Resource.Calendar.weekName = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];
			Pudd.Resource.Calendar.todayNameStr = "today";
		}
	};
	
	/* 데이트 피커 설정 - 공통 변환 예정*/
	function fnSetDatepicker(id, format){
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
	
	
	/*	[조회] 품의서 리스트 조회
	---------------------------------------- */
	var consListCnt = 0 ;
	var CONS_LIST = [];
	function fnSelectConsList(){
		var param = {
			frDt : $('#txtFromDate').val().replace(/-/g, '')
			, toDt : $('#txtToDate').val().replace(/-/g, '')
			, docTitle : $('#txtDoctitle').val( )
			, docStatus : $('#selDocStatus').val()
			, docNo : $('#txtDocNo').val()
			, erpDivSeq : $('#txtErpDivSeq').val()
			, includeConfferZero : 'Y'
		};
		
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/user/NpUserConsReportSelect.do' />",
			datatype : "json",
			success : function(result) {
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버 오류 발생');
					console.log(result.result.errorTrace);
				}else{
					// 테이블 생성 하여 출력
					consListCnt = result.result.aaData.length;
					CONS_LIST = result.result.aaData;
					fnSetConsGrid2();
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	
	
	/*	[품의 현황 리스트] 품의서 현황 고도화 리스트
	--------------------------------------------*/
	function fnSetConsGrid2(){
		console.log('**************************** 품의서 현황 리스트 출력2 ****************************');
		var aaData = CONS_LIST ;
		var pageSize = $('#divGridArea_selectMenu option:selected').val();
		$('#consReportCnt').html(aaData.length.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		$("#divGridArea").html("");
		$('.gt_paging').remove();
		$("#divGridArea").GridTable({
			'tTablename': 'gridConsReturn'
            , 'nTableType': 1 
            , 'nHeight': 600
            , 'module' : 'expReport'
            , 'bNoHover' : true      
            , 'oNoData': {                 // 데이터가 존재하지 않는 경우 
                'tText': '${CL.ex_NotExistData}' // 출력 텍스트 설정
            }
            , "data": aaData
	        , 'oPage': {                   // 사용자 페이징 정보
	            'nItemSize': pageSize||15               // 페이지별 아이템 갯수(기본 값. 10)
	            , 'anPageSelector' : [15, 35, 50, 100] // 아이템 갯수 선택 셀렉트 구성
	        }
	        , "aoHeaderInfo": [{                  // [*] 테이블 헤더 정보입니다.
	            no: '0'                        // 컬럼 시퀀스입니다.
	            , renderValue: '${CL.ex_docNm}'
	            , colgroup: '15'
	        }, {
	            no: '1'
	            , renderValue: "${CL.ex_title}"
	            , colgroup: '40'
	        }, {
	            no: '2'
	            , renderValue: '${CL.ex_draftDate}'
	            , colgroup: '10'
	        }, {
	            no: '3'
	            , renderValue: '${CL.ex_consMoney}'
	            , colgroup: '15'
	        }, {
	            no: '4'
	            , renderValue: '${CL.ex_appCondition}'
	            , colgroup: '10'
	        }, {
	            no: '5'
		        , renderValue: '${CL.ex_guljaesun}'
	            , colgroup: '10'
	        }]
            , "aoDataRender": [ {
                no: '0',
                render: function (idx, item) {                        	                     	
                	return '<a class="consDoc" style="cursor:pointer" title="품의문서보기">' + (item.docNo||'') + '</a>';
                } 
            }, {
                no: '1',
                render: function (idx, item) {   
                	if(item.saveYn == 'Y'){
                		return '<a class="favoriteDoc" style="cursor:pointer"><img src="/exp/Images/ico/ico_book01_on.png" id="' + item.consDocSeq + '" value = "' + item.saveYn +'"></a>' + ' ' + item.docTitle;	
                	}
                	else{
                		return '<a class="favoriteDoc" style="cursor:pointer"><img src="/exp/Images/ico/ico_book01.png" id="' + item.consDocSeq + '" value = "' + item.saveYn +'"></a>' + ' ' + item.docTitle;
                	}
                	return item.docTitle;
                } ,
                class: 'le'
            }, {
                no: '2',
                render: function (idx, item) {                        	                     	
                	return fnGetDateFormat(item.docDate);
                }
            }, {
                no: '3',
                render: function (idx, item) {                        	                     	
                	return fnGetCurrenyCode(item.consDocAmt, '0');
                } ,
                class: 'ri'
            }, {
                no: '4',
                render: function (idx, item) {                        	                     	
                	return fnGetDocStatusLabel(item.docStatus);
                }
            }, {
                no: '5',
                render: function (idx, item) {                        	                     	
                	return '<span class="ico-blank" onclick="openPopApprovalLine(' + item.docSeq + ')"></span>';
                } ,
                class: 'ri'
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
	        	/* 품의 문서 정보조회 */
        		$(row).find('.consDoc').click(function(){
        			fnAppdocPop(aData.docSeq, aData.formSeq);
        		});
	        	
	        	/* 해당 품의서 가져다쓴 결의서 조회 */
	        	$(row).find('.resList').click(function(){
	        		fnShowResDocList(aData.consDocSeq);
        		});
	        	
	        	/* 예산내역 리스트 조회 */
	        	$(row).find('.budgetList').click(function(){
	        		fnShowBudgetList(aData.consDocSeq);
        		});
	        	
	        	/* 즐겨찾기 추가 및 삭제 */
	        	$(row).find('.favoriteDoc').click(function(){
	        		fnInsertFavoriteDoc(aData);
        		});
	        }
		});	
	}
	
	
 	/*	[공통] 날짜 포멧 변경
	----------------------------------------- */
	function fnGetDateFormat(value){
 		var returnVal = '';
 		value = '' + (value || '');
 		value = value.replaceAll('-', '');
 		
 		returnVal = value.substring(0, 4) + '-' + value.substring(4, 6) + '-' + value.substring(6, 8); 
 		return returnVal;
 	}	
	
	/*	[공통] 통화 코드 적용
	----------------------------------------- */
	function fnGetCurrenyCode(value, defaultVal){
	    value = '' + value || '';
	    value = '' + value.split('.')[0];
	    value = value.replace(/[^0-9\-]/g, '') || (defaultVal != undefined ? defaultVal : '0');
	    var returnVal = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    return returnVal;
	}
	
	
	/*	[공용] ERP 전송여부 체크
	---------------------------------------- */
	function fnGetReturnCode(value, value2){
	    return value == 'Y' ? '반환' : ( value2 == 'Y' ? '부분반환' : '-'  );
	}
	
	/*	[ajax] 검색 된 리스트 테이블 생성
	---------------------------------------- */
	function fnSetConsGrid(aaData){
		$("#tblConsGrid").empty();
		var colGroup = ''; 
		colGroup += '<colgroup>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="200"/>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="70"/>';
		colGroup += '</colgroup>';
		$("#tblConsGrid").append(colGroup);
		
		
		
		var appendHTMLCode = '';
		
		if(aaData.length == 0){
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="' + $("#tblResList colgroup col").length + '">${CL.ex_dataDoNotExists}</td>')
			$("#tblConsGrid").append(tr);
		}else{
			$.each(aaData, function(idx, val){
				var tr = document.createElement('tr');
				$(tr).data('data', val);
				
				/* 문서번호 전자결재 팝업처리 (결의서) */
				var td = document.createElement('td');
				$(td).data('data', val);
				$(td).text( (val.docNo || '' ) );
				$(td).css('cursor', 'pointer');
				$(tr).append(td);
				
				/* 문서번호 전자결재 팝업처리 (결의서) */
				var td = document.createElement('td');
				$(td).data('data', val);
				$(td).text(val.docTitle);
				$(td).css('cursor', 'pointer');
				$(td).addClass('le');
				$(tr).append(td);
				
				$(tr).append('	<td class="">' + val.expendDate + '</td>');
				$(tr).append('	<td class="ri">' + fnGetCurrencyCode(val.consDocAmt) + '</td>');
				$(tr).append('	<td class="">' + fnGetDocStatusLabel(val.docStatus) + '</td>');
				$(tr).append('	<td class=""><span class="ico-blank" onclick="openPopApprovalLine(' + val.docSeq + ')"></span></td>');
				$("#tblConsGrid").append(tr);
			});
			fnTableClickEvent();
		}
	}
		
 	/*	[전송 리스트] 리스트 클릭 이벤트 추가
	--------------------------------------------*/
	function fnTableClickEvent(){
		$("#tblConsGrid tbody tr td").unbind().on("click",function(e){
			if($(this).data('data') !== undefined){
				if(!$(this).data('data').docSeq){
					// alert('참조된 품의서가 없습니다.');
				}else{
					fnAppdocPop($(this).data('data').docSeq, $(this).data('data').formSeq);
				}
			}
		});
 	}

	/*	[결의 리스트] 전자결재 문서 창
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
	
	/*	[공용] ERP 전송여부 체크
	---------------------------------------- */
	function fnGetSendCode(value){
	    return value == 'Y' ? '전송' : '미전송';
	}
	
	/*	[공용] 숫자에 콤마 찍어서 가져오기
	---------------------------------------- */
	function fnGetCurrencyCode(value, defaultVal){
	    value = '' + value || '';
	    value = '' + value.split('.')[0];
	    value = value.replace(/[^0-9\-]/g, '') || (defaultVal != undefined ? defaultVal : '0');
	    var returnVal = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	    return returnVal;
	}
	
	/*	[공용] 날짜 '-' 적용
	---------------------------------------- */
	function fnGetDateCode(value){
	    var returnVal = value || '';
		if(value.length == 8){
			returnVal = value.substring(0, 4) + '-' + value.substring(4, 6) + '-' + value.substring(6, 8); 
		}else if (value.length == 6){
			returnVal = value.substring(0, 4) + '-' + value.substring(5, 6);
		}
		return returnVal;
	}
	
	/*	[공용] 결재 상태 적용
	---------------------------------------- */
	function fnGetDocStatusLabel(value){
		/** 비영리 전자결재 상태 코드 **/ 
	    if(value == '000'){
	    	return '기안대기';
	    }else if(value == '001'){
	    	return '${CL.ex_temporarySave}';
	    }else if(value == '002'){
	    	return '${CL.ex_progressPayment}';
	    }else if(value == '003'){
	    	return '${CL.ex_coopering}';
	    }else if(value == '004'){
	    	return '결재보류';
	    }else if(value == '005'){
	    	return '${CL.ex_docReturn}';
	    }else if(value == '006'){
	    	return '${CL.ex_multiDeptReceipting}';
	    }else if(value == '007'){
	    	return '${CL.ex_draftCancel}';
	    }else if(value == '008'){
	    	return '${CL.ex_appComplete}';
	    }else if(value == '009'){
	    	return '${CL.ex_sendDemand}';
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
	    	return '${CL.ex_remove}';
	    }
	    /** 영리 전자결재 상태 코드 **/
	    else if(value == '10'){
	    	return '저장';
	    } else if(value == '100'){
	    	return '반려';
	    } else if(value == '110'){
	    	return '보류';
	    } else if(value == '20'){
	    	return '상신';
	    } else if(value == '30'){
	    	return '진행';
	    } else if(value == '40'){
	    	return '발신종결';
	    } else if(value == '50'){
	    	return '수신상신';
	    } else if(value == '60'){
	    	return '수신진행';
	    } else if(value == '70'){
	    	return '수신반려';
	    } else if(value == '80'){
	    	return '수신확인';
	    } else if(value == '90'){
	    	return '종결';
	    } 
	}
	
	
	/*	[전자결재] 문서 오픈 
	---------------------------------------- */
	function fnAprroDocOpen(docId) {
		var obj = {
			diSeqNum: '0000000001',
			miSeqNum: '0000000001',
			diKeyCode: docId
		};
		
		var param = NeosUtil.makeParam(obj);
		
		neosPopup("POP_DOCVIEW", param);
	} 
	
	function openPopApprovalLine(docId) {
		var param = "diKeyCode="+docId;
		neosPopup('POP_APPLINE', param);
	}
	
    function neosPopup(popType, param, popName) {
    	switch (popType) {
			case 'POP_APPLINE' : //결재라인 보기
				var uri = "/ea/edoc/eapproval/workflow/approvalLineViewPopup.do?" +param ;
				openWindow2(uri,  "popDocApprovalLine", 824, 320, 0) ;
				break;
			case 'POP_DOCVIEW' : // 결재문서 보기
				var uri = "/ea/edoc/eapproval/docCommonDraftView.do?"+ param;
				openWindow3(uri,  popName, '') ;
				break;
    	}
    } 


	function openWindow3(url,  windowName, strResize){
		var intWidth = "1000";
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
		if(strResize == undefined || strResize == '') {
			strResize = 'yes' ;
		}
		var pop = window.open(url, windowName, 'menubar=0,resizable='+strResize+',scrollbars=1,status=no,titlebar=0,toolbar=no,width=' + intWidth + ',height=' + intHeight + ',left=' + intLeft + ',top=' + intTop);
		try {pop.focus(); } catch(e){}
		return pop;
	}	
	
	function openWindow2(url,  windowName, width, height, strScroll, strResize ){

		var pop = "" ;
		windowX = Math.ceil( (window.screen.width  - width) / 2 );
		windowY = Math.ceil( (window.screen.height - height) / 2 );
		if(strResize == undefined || strResize == '') {
			strResize = 0 ;
		}
		pop = window.open(url, windowName, "width=" + width + ", height=" + height + ", top="+ windowY +", left="+ windowX +", scrollbars="+ strScroll+", resizable="+ strResize);
		try {pop.focus(); } catch(e){}
		return pop;
	}
	
	
	/* 즐겨찾기 추가 및 삭제 */
	function fnInsertFavoriteDoc(aData){
		var consDocSeq = aData.consDocSeq;
		var saveYn = $("#" + consDocSeq + "").attr("value")=='Y' ? 'N' : 'Y' ;
		var param = {
				    consDocSeq : aData.consDocSeq
				    , favoritesStatus : saveYn
				    , consDocNote : aData.docTitle
					};
		$.ajax({
		    type : 'post'
		    , url : '/exp/ex/np/user/cons/FavoritesUpdate.do'
		    , datatype : 'json'
		    , async : false
		    , data : param
		    , success : function(result) {
		    	Pudd.puddSnackBar({
			    		type	: 'success'		// success, error, warning, info
			    	,	message :  saveYn == 'Y' ? '즐겨찾기로 저장하였습니다.'  : '즐겨찾기에서 삭제하였습니다.'
			    	,	duration : 1000			// 1초 = 1000
		    	});
			    	if(saveYn=='Y'){
		    		$("#" + consDocSeq + "").attr("src","/exp/Images/ico/ico_book01_on.png");
		    		$("#" + consDocSeq + "").attr("value","Y");
		    	}
		    	else{
		    		$("#" + consDocSeq + "").attr("src","/exp/Images/ico/ico_book01.png");
		    		$("#" + consDocSeq + "").attr("value","N");
		    	} 
		    }
		    , error : function(result) {
		    	Pudd.puddSnackBar({
		    		type	: "error"		// success, error, warning, info
		    	,	message : "저장에 실패했습니다"
		    	,	duration : 1000			// 1초 = 1000
	    		});
		    }
		});
	}

</script>


<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="tableData" value="" id="tableData">
	<input type="hidden" name="excelHeader" value="" id="excelHeader"/>
	<input type="hidden" name="fileName" value="" id="fileName">
</form>
