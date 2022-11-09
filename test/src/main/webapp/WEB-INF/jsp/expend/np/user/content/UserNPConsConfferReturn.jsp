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
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>

<jsp:include page="../include/UserOptionMap.jsp" flush="false" />
<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>
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
				<div class="dal_div" style="z-index:2;">
					<input type="text" autocomplete="off" value="" id="txtFromDate" class="w113 puddSetup" pudd-type="datepicker"  />
					<script type="text/javascript">
					  var d = new Date()
					  var monthOfYear = d.getMonth()
					  d.setMonth(monthOfYear - 1)
					  $("#txtFromDate").val(getFormatDate(d));
					</script>
				</div>
				~
				<div class="dal_div" style="z-index:2;"> 
					<input type="text" autocomplete="off" value="" id="txtToDate" class="w113 puddSetup" pudd-type="datepicker" />
					<script type="text/javascript">
						var d = new Date();
						$("#txtToDate").val(getFormatDate(d));
					</script>
				</div>
			</dd>
			<dt>${CL.ex_title}  <!--제목--></dt>
			<dd><input type="text" autocomplete="off" class="enter" id="txtDocTitle" style="width:186px;" /></dd>
			<dt>${CL.ex_refferCheck}  <!--반환여부--></dt>
			<dd>
				<select class="selectmenu" id="selReturnYN" style="width:100px;">
					<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
					<option value="Y">${CL.ex_yes}  <!--예--></option>
					<option value="N">${CL.ex_no}  <!--아니요--></option>
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
			<dd><input type="text" autocomplete="off" class="enter" id="txtDocNo" style="width:150px;" /></dd>
<!-- 			<dt style="width:70px;">회계단위</dt> -->
<!-- 			<dd><input type="text" autocomplete="off" id="" style="width:150px;" /></dd> -->
			<dt style="width:70px;">${CL.ex_restitutor}  <!--반환자--></dt>
			<dd><input type="text" autocomplete="off" class="enter" id="txtReturnEmpName" style="width:150px;" /></dd>									
		</dl>
	</div>			
                      
	<!-- 버튼 -->
	<div class="btn_div cl">
		<div class="left_div fwb mt5">
			${CL.ex_yeCount} <span class="" id="consReportCnt">-</span> ${CL.ex_gun}
		</div>
		<div class="right_div">							
			<div class="controll_btn p0">
				<input type="checkbox" name="chkBalance" id="chkBalance"/>&nbsp;<label for="chkBalance" class="mr10">${CL.ex_exsistBgtSearch}  <!--잔여금액 있는 건만 조회--></label>
				<button id="btnExcelDown" class="k-button">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
				<button id="btnReturn">${CL.ex_return2}  <!--반환--></button>
				<button id="btnCancel">${CL.ex_cancelReturn}  <!--반환취소--></button>
<!-- 				<button id="">엑셀다운로드</button> -->
			</div>
		</div>
	</div>

	<!-- 테이블 -->
	<div class="com_ta2">
		<div id="divGridArea"> 
		</div>
<!-- 		<table id="tblConsListHead"> -->
<%-- 			<colgroup> --%>
<%-- 				<col width="34"/> --%>
<%-- 				<col width="100"/> --%>
<%-- 				<col width="200"/> --%>
<%-- 				<col width="100"/> --%>
<%-- 				<col width="100"/> --%>
<%-- 				<col width="100"/> --%>
<%-- 				<col width="100"/> --%>
<%-- 				<col width="80"/> --%>
<%-- 				<col width="80"/> --%>
<%-- 			</colgroup>          --%>
<!-- 			<tr> -->
<!-- 				<th> -->
<!-- 					<input type="checkbox" name="all_chk" id="all_chk"/> -->
<!-- 					<label for="all_chk"></label> -->
<!-- 				</th> -->
<!-- 				<th>문서번호</th> -->
<!-- 				<th>제목</th> -->
<!-- 				<th>기안일자</th> -->
<!-- 				<th>품의금액</th> -->
<!-- 				<th>지출금액</th> -->
<!-- 				<th>잔여금액</th> -->
<!-- 				<th>반환구분</th> -->
<!-- 				<th>예산내역</th> -->
<!-- 			</tr> -->
<!-- 		</table>  -->
<!-- 		<table id="tblConsGrid"> -->
<!-- 		</table> -->
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
		
		/* popup창 위치 조정 */
		pop_position();
	});
	
	
	/*	[버튼] 버튼 이벤트 설정
	---------------------------------------- */
	function fnSetBtnEvent(){
		/* 잔여금액 필터 체크박스 선택 */
		$('#chkBalance').click(function (){
			fnSetConsGrid2();
		});
		
		/* 체크박스 이벤트 설정 */
		$('#all_chk').click(function(){
			var checked = $(this).prop('checked');
			$('.selData').prop('checked', checked);
		});
		
		/* 반환 */
		$('#btnReturn').click(function (){
			fnSetConfferStatus(true);
		});
		
		/* 반환 취소 */
		$('#btnCancel').click(function (){
			fnSetConfferStatus(false);
		});
		
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
		
		
		$('#btnCloseConsBudgetListPop').click(function (){
			$('.consBudgetListPop').hide();			
		});
		
		$('#btnCloseResPop').click(function(){
			$('.resListPop').hide();
		});
		
		/* 엑셀 다운로드 이벤트 정의 */
        $("#btnExcelDown").click(function(){
			fnAdminReportExcelDown();
		});
		
        /* 엑셀 다운로드 이벤트 정의 */
        $("#btnExcelDetailDown").click(function(){
        	fnAdminDetailReportExcelDown();
		});
		
		
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
	
	
	/*	[반환 / 취소] 품의서 반환/취소 메소드
	* 	actionFlag = [true, false]
	---------------------------------------- */
	function fnSetConfferStatus( actionFlag ){
		var consDocSeqs = '';
		$('.selData:checked').each(function( idx, item ){
			var key = JSON.parse($(item).attr('value')) ;
			consDocSeqs += ", '" + key + "'";
		});
		if(!consDocSeqs){
			alert('${CL.ex_selectDocument}');
			return;
		}
		var param = {
			confferReturn :  actionFlag ? 'Y' : 'N' 
			, consDocSeqs : consDocSeqs.substring(1)
			, actionType : 'doc'
		}
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/user/NpUserConsConfferStatusUpdate.do' />",
			datatype : "json",
			success : function(result) {
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버 오류 발생');
					console.log(result.result.errorTrace);
				}else{
					$('#all_chk').prop('checked', false);
					fnSelectConsList();
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	
	/*	[반환 / 취소] 품의예산 반환/취소 메소드
	* 	actionFlag = [true, false]
	---------------------------------------- */
	function fnSetConfferBudgetStatus( actionFlag, budgetSeq ){
		var param = {
			confferReturn :  actionFlag  
			, consBudgetSeq : budgetSeq
			, actionType : 'budget'
		}
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url :"<c:url value='/expend/np/user/NpUnseConsConfferBudgetStatusUpdate.do' />",
			datatype : "json",
			success : function(result) {
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버 오류 발생');
					console.log(result.result.errorTrace);
				}else{
					fnShowBudgetList(selConsDocSeq);
					$('#btnSearch').click();
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	
	 /*	[ 엑셀 ] 지출결의서 전송리스트 엑셀 다운로드
 	--------------------------------------*/
	function fnAdminReportExcelDown() {
		if(!consListCnt){
			alert("${CL.ex_dataDoNotExists}");
			return;
		}
		
		$("#fileName").val( "품의서반환" );
			
		/* Excel 헤더 정의 */
		var excelHeader = {};
		excelHeader.docNo = "문서번호";
		excelHeader.docTitle = "제목";
		excelHeader.docDate = "기안일자";
		excelHeader.consDocAmt = "품의금액";
		excelHeader.resDocAmt = "지출금액";
		excelHeader.balanceAmt = "잔여금액";
		excelHeader.confferReturnStatus = "반환구분";
		$("#excelHeader").val( JSON.stringify(excelHeader) );
		
		$("#tableData").val( JSON.stringify(CONS_LIST) );
		
		var url = "<c:url value='/ex/user/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
	 
	 /*	[ 엑셀 ] 반환메뉴 참조된 지출결의서 엑셀 다운로드
 	--------------------------------------*/
	function fnAdminDetailReportExcelDown() {
		if(!detailListCnt){
			alert("${CL.ex_dataDoNotExists}");
			return;
		}
		
		$("#fileName2").val( "품의서상세현황" );
			
		/* Excel 헤더 정의 */
		var excelHeader = {};
		if('${erpInfo.erpTypeCode}' == 'iCUBE'){
			excelHeader.docuFgName = "품의구분";
			excelHeader.consDate = "품의일자";
			excelHeader.mgtName = "프로젝트";
			excelHeader.erpBudgetName = "예산과목";
			excelHeader.erpDivName = "회계단위";
			excelHeader.budgetAmt = "품의금액";
			excelHeader.resBudgetAmt = "지출금액";
			excelHeader.balanceAmt = "잔여금액";
			excelHeader.confferBudgetReturnYN = "반환여부";
		}
		else{
			excelHeader.docuFgName = "품의구분";
			excelHeader.consDate = "품의일자";
			excelHeader.erpBudgetName = "예산단위";
			excelHeader.erpBizplanName = "사업계획";
			excelHeader.erpBgacctName = "예산계정";
			excelHeader.erpPcName = "회계단위";
			excelHeader.budgetAmt = "품의금액";
			excelHeader.resBudgetAmt = "지출금액";
			excelHeader.balanceAmt = "잔여금액";
			excelHeader.confferBudgetReturnYN = "반환여부";
		}
		$('#consDocSeq').val(selConsDocSeq);
		
		$("#excelHeader2").val( JSON.stringify(excelHeader) );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDetailDownload.method = "post";
		excelDetailDownload.action = url;
		excelDetailDownload.submit();
		excelDetailDownload.target = "";
	}
	
	
	/*	[조회] 품의서 리스트 파라미터 반환
	---------------------------------------- */
	function fnGetConslistParam(){
		var result = {};
		
		result.frDt = $('#txtFromDate').val().replace(/-/g, '');
		result.toDt = $('#txtToDate').val().replace(/-/g, '');
		result.docTitle = $('#txtDocTitle').val();
		result.confferReturnYN = $('#selReturnYN').val();
		result.docNo = $('#txtDocNo').val();
		result.returnEmpName = $('#txtReturnEmpName').val();
		
		$('#formFrDt').val($('#txtFromDate').val().replace(/-/g, ''));
		$('#formToDt').val($('#txtToDate').val().replace(/-/g, ''));
		$('#formDocTitle').val($('#txtDocTitle').val());
		$('#formConfferReturnYN').val($('#selReturnYN').val());
		$('#formDocNo').val($('#txtDocNo').val());
		$('#formReturnEmpName').val($('#txtReturnEmpName').val());
		
		return result;
		
	}
	
	/*	[조회] 품의서 리스트 조회
	---------------------------------------- */
	var consListCnt = 0 ;
	function fnSelectConsList(){
		var param = {
			frDt : $('#txtFromDate').val().replace(/-/g, '')
			, toDt : $('#txtToDate').val().replace(/-/g, '')
			, docTitle : $('#txtDocTitle').val()
			, confferReturnYN : $('#selReturnYN').val()
			, docNo : $('#txtDocNo').val()
			, returnEmpName : $('#txtReturnEmpName').val()
			, docStatus : "'008', '009'"
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
	
	/*	[품의 반환 리스트] 품의서 반환리스트 출력 고도화 버전
	--------------------------------------------*/
	function fnSetConsGrid2(){
		console.log('**************************** 품의서 반환 리스트 출력2 ****************************');
		var aaData = [] ; ;
		var useBalanceFilter = $('#chkBalance').prop('checked');
		
		if(useBalanceFilter){
			for(var i = 0 ; i < CONS_LIST.length; i++){
				var item = CONS_LIST[i];
				if( item.balanceAmt != 0 ){
					aaData.push(item);
				}
			}
		}else{
			aaData = CONS_LIST;
		}
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
	            , renderValue: '<input type="checkbox" id="chkAll" name="chkAll" onclick="fnAllChk();">'
	            , colgroup: '5'
	        }, {
	            no: '1'
	            , renderValue: "${CL.ex_docNm}"
	            , colgroup: '20'
	        }, {
	            no: '2'
	            , renderValue: '${CL.ex_title}'
	            , colgroup: '40'
	        }, {
	            no: '3'
	            , renderValue: '${CL.ex_draftDate}'
	            , colgroup: '20'
	        }, {
	            no: '4'
	            , renderValue: '${CL.ex_consMoney}'
	            , colgroup: '20'
	        }, {
	            no: '5'
		        , renderValue: '${CL.ex_expenseMoney}'
	            , colgroup: '20'
	        }, {
	            no: '6'
		        , renderValue: '${CL.ex_remainBal}'
	            , colgroup: '20'
	        }, {
	            no: '7'
		        , renderValue: '${CL.ex_refferDivision}'
	            , colgroup: '11'
	        }, {
	            no: '8'
		        , renderValue: '${CL.ex_detailBudget}'
	            , colgroup: '11'
	        }]
            , "aoDataRender": [{          // [*] 실제 데이터 표기 방법에 대하여 지정합니다.
                no: '0',      
                render: function (idx, item) {                        	                     	
                	return '<input type="checkbox" class="chkSel selData" id="chk_'+item.consDocSeq+'" value="'+item.consDocSeq+'"/>';
                }
            }, {
                no: '1',
                render: function (idx, item) {                        	                     	
                	return '<a class="consDoc" style="cursor:pointer" title="품의문서보기">' + item.docNo + '</a>';
                } ,
                class: 'le'
            }, {
                no: '2',
                render: function (idx, item) {   
                	return item.docTitle;
                } ,
                class: 'le'
            }, {
                no: '3',
                render: function (idx, item) {                        	                     	
                	return fnGetDateFormat(item.docDate);
                }
            }, {
                no: '4',
                render: function (idx, item) {                        	                     	
                	return fnGetCurrenyCode(item.consDocAmt, '0');
                } ,
                class: 'ri'
            }, {
                no: '5',
                render: function (idx, item) {                        	                     	
                	return '<a class="text_blue resList" style="text-decoration:underline;cursor:pointer;" title="참조결의 리스트 조회">' + fnGetCurrenyCode(item.resDocAmt) + '</a>';
                } ,
                class: 'ri'
            }, {
                no: '6',
                render: function (idx, item) {                        	                     	
                	return fnGetCurrenyCode(item.balanceAmt, '0');
                } ,
                class: 'ri'
            }, {
                no: '7',
                render: function (idx, item) {                        	                     	
                	return fnGetReturnCode(item.confferReturnYN, item.confferBudgetReturnYN,item.confferBudgetAllReturnYN);
                }
            }, {
                no: '8',
                render: function (idx, item) {       
                	return '<a class="text_blue budgetList" style="text-decoration:underline;cursor:pointer;" title="품의서 예산내역 조회">${CL.ex_view2}</a>';
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
	        }
		});	
	}
	

	/*	[반환 리스트] 전자결재 문서 창
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
	
	
	
	var CONS_LIST = [];
	/*	[전송 리스트] 결의서 전송 리스트 출력
	--------------------------------------------*/
 	function fnSetConsGrid(){
 		console.log('**************************** 품의서 반환 리스트 출력 ****************************');
		var aaData = CONS_LIST;
		var useBalanceFilter = $('#chkBalance').prop('checked');
 		
		$("#tblConsGrid").empty();

		var colGroup = ''; 
		colGroup += '<colgroup>';
		colGroup += '	<col width="34"/>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="200"/>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="100"/>';
		colGroup += '	<col width="80"/>';
		colGroup += '	<col width="80"/>';
		colGroup += '</colgroup>';
		$("#tblConsGrid").append(colGroup);

		
		if(aaData.length == 0){
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="9">${CL.ex_dataDoNotExists}</td>')
			$("#tblConsGrid").append(tr); 
		}else{
			$.each(aaData,function(idx, val){
				if( useBalanceFilter && ( val.balanceAmt == 0 ) ){
					return;
				}
				
				var tr = document.createElement('tr');
				$(tr).data('data', val);
				$(tr).append('<td><input type="checkbox" class="selData" id="chk_'+val.consDocSeq+'" value="'+val.consDocSeq+'"/>' + '</td>')
				
				/* 문서번호 전자결재 팝업처리 (품의서) */
				var td = document.createElement('td');
				val.colGbn = 'consDocPop';
				var data = JSON.parse(JSON.stringify(val));
				$(td).data('data', data);
				$(td).text(val.docNo);
				$(tr).append(td);
				
				var tdDocTitle = document.createElement('td');
				var tdData = JSON.parse(JSON.stringify(val));
				$(tdDocTitle).data('data', tdData);
				$(tdDocTitle).text(val.docTitle);
				$(tr).append(tdDocTitle);
				
				$(tr).append( '	<td>'+ fnGetDateFormat(val.docDate) + '</td>' );
				$(tr).append( '	<td>'+ fnGetCurrenyCode(val.consDocAmt, '0') + '</td>');
				
				/* 지출금액 결의리스트 (참조 결의서) */
				var td = document.createElement('td');
				val.colGbn = 'resDocPop';
				var data2 = JSON.parse(JSON.stringify(val));
				$(td).html('<a class="text_blue" style="text-decoration:underline">' + fnGetCurrenyCode(val.resDocAmt, '0') + '</a>');
				$(td).data('data', data2);
				$(tr).append(td);
				
				$(tr).append( '	<td>'+ fnGetCurrenyCode(val.balanceAmt, '0') + '</td>');
				$(tr).append( '	<td>'+ fnGetReturnCode(val.confferReturnYN, val.confferBudgetReturnYN,val.confferBudgetAllReturnYN||'N') + '</td>');
				
				/* 예산내역 출력 팝업 */
				var td = document.createElement('td');
				val.colGbn = 'budgetList';
				var data3 = JSON.parse(JSON.stringify(val));
				$(td).data('data', data3);
				$(td).text('보기');
				$(tr).append(td);
				
				$("#tblConsGrid").append(tr);
			});
			fnTableClickEvent();
		}
 	}
	
 	/*	[공통] 날짜 포멧 변경
	----------------------------------------- */
	function fnGetDateFormat(value){
 		var returnVal = '';
 		value = value || '';
 		value = value.replaceAll('-','');
 		
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
	
 	/*	[테이블] 테이블 클릭이벤트 지정
	---------------------------------------- */
	function fnTableClickEvent(){
		$("#tblConsGrid tbody tr td").unbind().on("click",function(e){
			if($(this).data('data') !== undefined){
				console.log($(this).data('data'))
				
				if($(this).data('data').colGbn == 'resDocPop'){
					/* 참조한 결의서 리스트 조회 */
					fnShowResDocList($(this).data('data').consDocSeq);
				}else if($(this).data('data').colGbn == 'consDocPop'){
					/* 품의서 전자결재 팝업 */
					fnAppdocPop($(this).data('data').docSeq, $(this).data('data').formSeq);
				}else if($(this).data('data').colGbn == 'budgetList'){
					/* 예산내역 리스트 조회 */
					fnShowBudgetList($(this).data('data').consDocSeq);
				}
			}
		});
 		
	}
	
	/*	[공용] ERP 전송여부 체크
	---------------------------------------- */
	function fnGetReturnCode(value, value2, value3){
		return value == 'Y' ? '${CL.ex_return2}' : ( value2 == 'Y' ? (value3 == 'Y' ? '${CL.ex_return2}' : '${CL.ex_partialReturn}' ) : '-'  );
	}

	/*	[공용] 반환 여부 텍스트 가져오기
	---------------------------------------- */
	function fnGetReturnElem( item ){
		if(item.confferBudgetReturnYN == 'Y'){
			return '${CL.ex_yes} (' + item.confferBudgetReturnEmpName + ') <input type="button" value="${CL.ex_cancel}" onClick="javascript:fnSetConfferBudgetStatus( \'N\', ' + item.budgetSeq + ' )"/>';
		}else{		
			if(item.balanceAmt == 0){
				return '${CL.ex_completion}';
			}else{
				return '${CL.ex_no2} <input type="button" value="${CL.ex_return2}" onClick="javascript:fnSetConfferBudgetStatus( \'Y\', ' + item.budgetSeq + ' )"/>';
			}
		}
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
	
	/*	[팝업] 결의서 목록 팝업
	---------------------------------------- */	
	function fnShowResDocList(consDocSeq){
		var param = {
				consDocSeq : consDocSeq
			};
			
			$.ajax({
				async : true,
				type : "post",
				data : param,
				url : "<c:url value='/expend/np/user/NpUserConsConfferResList.do' />",
				datatype : "json",
				success : function(result) {
					if(result.result.resultCode != 'SUCCESS'){
						alert('서버 오류 발생');
						console.log(result.result.errorTrace);
					}else{
						fnDrawConfferResTable(result.result.aaData);
						fnTableClickEvent();
						/* 결의서 목록 출력  */
						$('.resListPop').show();
					}
				},
				error : function(err) {
					console.log(err);
				}
			});
	}

	/*	[팝업 참조 결의서 테이블 그리기
	---------------------------------------- */	
	function fnDrawConfferResTable(aaData){

		$('#lblConfferResDocCnt').html(aaData.length);
		
		$("#confferResTbl").empty();
		$.each(aaData,function(idx, val){
			var tr = document.createElement('tr');
			$(tr).data('data', val);
			$(tr).click(function(){
				fnAppdocPop(val.docSeq, val.formSeq);
			});

			/* 문서번호 전자결재 팝업처리 (결의서) */
			var td = document.createElement('td');
			val.colGbn = 'consDocPop';
			var data = JSON.parse(JSON.stringify(val));
			$(td).data('data', data);
			$(td).text( ( val.docNo || '-') );
			$(tr).append(td);
			
			/* 제목 전자결재 팝업처리 (참조 품의서) */
			var td = document.createElement('td');
			val.colGbn = 'resDocPop';
			var data2 = JSON.parse(JSON.stringify(val));
			$(td).data('data', data2);
			$(td).text(val.docTitle);
			$(tr).append(td);
			$(tr).append( '	<td>'+ fnGetDateFormat(val.docDate) + '</td>' );
			$(tr).append( '	<td>'+ val.deptName + '</td>');
			$(tr).append( '	<td>'+ val.empName + '</td>');
			$(tr).append( '	<td>'+ val.erpDivName + '</td>');
			$(tr).append( '	<td>'+ fnGetDocStatusLabel(val.docStatus)  + '</td>');
			$(tr).append( '	<td>'+ fnGetCurrenyCode(val.resDocAmt, '0') + '</td>');
			$(tr).append( '	<td>'+ val.erpSendYN + '</td>');
			$("#confferResTbl").append(tr);
		});
	}
	
	/*	[팝업] 예산과목 목록 팝업
	---------------------------------------- */	
	var selConsDocSeq = '';
	var detailListCnt = 0;

	function fnShowBudgetList(consDocSeq){
		selConsDocSeq = consDocSeq;
		var param = {
			consDocSeq : consDocSeq
		};
		
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/user/NpUserConsBudgetList.do' />",
			datatype : "json",
			success : function(result) {
				if(result.result.resultCode != 'SUCCESS'){
					alert('서버 오류 발생');
					console.log(result.result.errorTrace);
				}else{
					detailListCnt = result.result.aaData.length;
					$('#lblConsBudgetCnt').val(detailListCnt);
					fnDraowConsBudgetIlstTable(result);
					/* 결의서 목록 출력  */
					$('.consBudgetListPop').show();
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}
	
	/*	[팝업] 예산과목 리스트 그리기
	---------------------------------------- */	
	function fnDraowConsBudgetIlstTable(data){
		var headData = data.result.aData;
		var listData = data.result.aaData;
		$('#lblConsBudgetCnt').text(listData.length);
		
		// fnGetCurrencyCode, fnGetDateCode
		
		if(headData){
			/* 헤더 테이블 데이터 생성 */
			var headTr = '';
			headTr += '<tr>';
			headTr += '	<td><a class="textcss">' + headData.docNo + '</a></td>';
			headTr += '	<td class="le">' +headData.docTitle+ '</td>';
			headTr += '	<td>' + fnGetDateCode(headData.expendDate) + '</td>';
			headTr += '	<td>' + headData.deptName + '</td>';
			headTr += '	<td>' + headData.empName + '</td>';
			headTr += '	<td class="ri">' + fnGetCurrencyCode(headData.consDocAmt) + '</td>';
			headTr += '	<td class="ri">' + fnGetCurrencyCode(headData.resDocAmt) + '</td>';
			headTr += '	<td class="ri">' + fnGetCurrencyCode(headData.balanceAmt) + '</td>';
			headTr += '	<td>' + fnGetReturnCode(headData.confferReturnYN, headData.confferBudgetReturnYN,headData.confferBudgetAllReturnYN||'N') + '</td>';
			headTr += '</tr>';
			
			$('#tblBudgetListHeadData').empty().append(headTr);
		}
		
		if('${erpInfo.erpTypeCode}' == 'iCUBE'){
			/* iCUBE 의 경우 iCUBE기준 예산 출력 */
			if(listData){
				$('.onlyU').hide();
				$('.onlyCube').show();
				$('#tblBudgetListData').empty();
				for(var i =0; i < listData.length; i++){
					var item = listData[i];
					var listTr = '';
					
					listTr += '<tr>';
					listTr += '	<td>' +item.docuFgName+ '</td>';
					listTr += '	<td>' + fnGetDateCode(item.consDate) + '</td>';
					listTr += '	<td class="onlyCube">' + item.mgtName + '</td>';
					listTr += '	<td>' + item.erpBudgetName + '</td>';
					listTr += '	<td>' + (item.erpDivName || item.erpPcName) + '</td>';
					listTr += '	<td class="ri">' + fnGetCurrencyCode(item.budgetAmt) + '</td>';
					listTr += '	<td class="ri">' + fnGetCurrencyCode(item.resBudgetAmt) + '</td>';
					listTr += '	<td class="ri">' + fnGetCurrencyCode(item.balanceAmt) + '</td>';
					if(headData.confferReturnYN == 'Y'){
						listTr += '<td>${CL.ex_yes}(' + headData.confferReturnEmpName + ')</td>';
					}else{
						listTr += '	<td>'+ fnGetReturnElem( item ) +'</td>';
					}
					listTr += '</tr>';
					
					$('#tblBudgetListData').append(listTr);
				}
			}
		}else{
			$('.onlyU').show();
			$('.onlyCube').hide();
			$('#tblBudgetListData').empty();
			for(var i =0; i < listData.length; i++){
				var item = listData[i];
				var listTr = '';
				
				listTr += '<tr>';
				listTr += '	<td class="le">' +item.docuFgName+ '</td>';
				listTr += '	<td>' + fnGetDateCode(item.consDate) + '</td>';
				listTr += '	<td>' + item.erpBudgetName + '</td>';
				listTr += '	<td>' + item.erpBizplanName + '</td>';
				listTr += '	<td>' + item.erpBgacctName + '</td>';
				listTr += '	<td>' + (item.erpDivName || item.erpPcName) + '</td>';
				listTr += '	<td class="ri">' + fnGetCurrencyCode(item.budgetAmt) + '</td>';
				listTr += '	<td class="ri">' + fnGetCurrencyCode(item.resBudgetAmt) + '</td>';
				listTr += '	<td class="ri">' + fnGetCurrencyCode(item.balanceAmt) + '</td>';
				if(headData.confferReturnYN == 'Y'){
					listTr += '<td>${CL.ex_yes}(' + headData.confferReturnEmpName + ')</td>';
				}else{
					listTr += '	<td>'+ fnGetReturnElem( item ) +'</td>';
				}
				listTr += '</tr>';
				
				$('#tblBudgetListData').append(listTr);
			}
		}
	}
	
	
</script>





<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="frDt" value="" id="formFrDt"/>
	<input type="hidden" name="toDt" value="" id="formToDt"/>
	<input type="hidden" name="docTitle" value="" id="formDocTitle"/>
	<input type="hidden" name="confferReturnYN" value="" id="formConfferReturnYN"/>
	<input type="hidden" name="docNo" value="" id="formDocNo"/>
	<input type="hidden" name="returnEmpName" value="" id="formReturnEmpName"/>
	<input type="hidden" name="excelHeader" value="" id="excelHeader"/>
	<input type="hidden" name="fileName" value="" id="fileName">
	<input type="hidden" name="tableData" value="" id="tableData">
</form>


<form id="excelDetailDownload" name="excel" method="post">
	<input type="hidden" name="excelHeader" value="" id="excelHeader2"/>
	<input type="hidden" name="fileName" value="" id="fileName2">
	<input type="hidden" name="consDocSeq" value="" id="consDocSeq"> 
</form>


<div id="resListPop" class="pop_wrap_dir resListPop" style="width: 1000px; top: 50%; left: 50%; margin-left: -500px; margin-top: -262px; display:none;">
	<div class="pop_head">
		<h1>품의참조 결의내역</h1>
		<a href="#n" class="clo" id="btnCloseResPop"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
	</div>			
		
	<div class="pop_con">
		<div class="btn_div cl">
<div class="left_div fwb mt5">${CL.ex_yeCount} <span id="lblConfferResDocCnt">0</span> ${CL.ex_gun}</div>
		</div>
		
		<div class="com_ta2 sc_head">
			<table>
				<colgroup>				
					<col width="100" />
					<col width="" />
					<col width="80" />
                       <col width="100" />
                       <col width="70" />
                       <col width="" />
					<col width="80" />
                       <col width="90" />
                       <col width="80" />
				</colgroup>
				<thead>
					<tr>
						<th>${CL.ex_documentNumber}</th>
						<th>${CL.ex_title}</th>
						<th>${CL.ex_draftDate}</th>
                           <th>${CL.ex_draftDept}</th>
						<th>${CL.ex_drafter}</th>
                           <th>${CL.ex_accountingUnit}</th>
                           <th>${CL.ex_appCondition}</th>
                           <th>${CL.ex_expenseMoney}</th>
                           <th>${CL.ex_sending}</th>
					</tr>
				</thead>
			</table>
		</div>
		
		<div class="com_ta2 ova_sc2 cursor_p bg_lightgray" style="height:369px;">
			<table>
				<colgroup>				
					<col width="100" />
					<col width="" />
					<col width="80" />
                       <col width="100" />
                       <col width="70" />
                       <col width="" />
					<col width="80" />
                       <col width="90" />
                       <col width="80" />
				</colgroup>
				<tbody id="confferResTbl">
					<tr>
						<td><a class="textcss">회계-16859</a></td>
						<td class="le">2018년 1월 회계팀 결의서</td>
						<td>2017-12-20</td>
                           <td>uc개발2팀</td>
						<td>홍길동</td>
                           <td>더존비즈온</td>
                           <td>임시저장</td>
                           <td class="ri">1,000,000,000</td>
                           <td>아니오</td>
					</tr>
				</tbody>
			</table>								
		</div>

	</div><!--// pop_con -->		
</div><!--// pop_wrap -->
<div class="modal resListPop" style="display:none;"></div>



<div id="consBudgetListPop" class="pop_wrap_dir consBudgetListPop" style="width: 1000px; top: 50%; left: 50%; margin-left: -500px; margin-top: -262px; display:none;">
	<div class="pop_head">
		<h1>${CL.ex_detailBudgetDetail} <!--예산내역 상세--></h1>
		<a href="#n" class="clo" id="btnCloseConsBudgetListPop"><img src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
	</div>

	<div class="pop_con">
		<div class="com_ta2 sc_head">
			<table>
				<colgroup>
					<col width="100" />
					<col width="" />
					<col width="100" />
					<col width="100" />
					<col width="100" />
					<col width="100" />
					<col width="80" />
					<col width="80" />
					<col width="80" />
				</colgroup>
				<thead>
					<tr>
						<th>${CL.ex_docNm} <!--문서번호--></th>
						<th>${CL.ex_title} <!--제목--></th>
						<th>${CL.ex_draftDate} <!--기안일자--></th>
						<th>${CL.ex_draftDept} <!--기안부서--></th>
						<th>${CL.ex_drafter} <!--기안자--></th>
						<th>${CL.ex_consMoney} <!--품의금액--></th>
						<th>${CL.ex_expenseMoney} <!--지출금액--></th>
						<th>${CL.ex_remainBal} <!--잔여금액--></th>
						<th>${CL.ex_refferDivision} <!--반환구분--></th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="com_ta2 ova_sc2 cursor_p bg_lightgray" style="height:37px;">
			<table>
				<colgroup>
					<col width="100" />
					<col width="" />
					<col width="100" />
					<col width="100" />
					<col width="100" />
					<col width="100" />
					<col width="80" />
					<col width="80" />
					<col width="80" />
				</colgroup>
				<tbody id="tblBudgetListHeadData">
				</tbody>
			</table>
		</div>

		<div class="btn_div cl">
			<div class="left_div fwb mt5">${CL.ex_yeCount} <span id="lblConsBudgetCnt">0</span> ${CL.ex_gun}</div>
			<span class="controll_btn p0" style="float:right;"><button id="btnExcelDetailDown" class="k-button">${CL.ex_excelDown}  <!--엑셀다운로드--></button></span>
		</div>

		<div class="com_ta2 sc_head">
			<table>
				<colgroup>
					<col width="100" />
					<col width="80" />
					<col class="onlyCube" width="120" />
					<col class="onlyCube" width="100" />
					<col class="onlyU" width="100" />
					<col class="onlyU" width="100" />
					<col class="onlyU" width="100" />
					<col width="100" />
					<col width="80" />
					<col width="80" />
					<col width="80" />
					<col width="130" />
				</colgroup>
				<thead>
					<tr>
						<th>${CL.ex_confDivide} <!--품의구분--></th>
						<th>${CL.ex_consDate} <!--품의일자--></th>
						<th class="onlyCube">${CL.ex_project} <!--프로젝트--></th>
						<th class="onlyCube">${CL.ex_budgetSub} <!--예산과목--></th>
						<th class="onlyU">${CL.ex_budgetUnit} <!--예산단위--></th>
						<th class="onlyU">${CL.ex_businessPlan} <!--사업계획--></th>
						<th class="onlyU">${CL.ex_budgetAccount} <!--예산계정--></th>
						<th>${CL.ex_accountingUnit} <!--회계단위--></th>
						<th>${CL.ex_consMoney} <!--품의금액--></th>
						<th>${CL.ex_expenseMoney} <!--지출금액--></th>
						<th>${CL.ex_remainBal} <!--잔여금액--></th>
						<th>${CL.ex_refferCheck} <!--반환여부--></th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="com_ta2 ova_sc2 cursor_p bg_lightgray" style="height:369px;">
			<table>
				<colgroup>
					<col width="100" />
					<col width="80" />
					<col class="onlyCube" width="120" />
					<col class="onlyCube" width="100" />
					<col class="onlyU" width="100" />
					<col class="onlyU" width="100" />
					<col class="onlyU" width="100" />
					<col width="100" />
					<col width="80" />
					<col width="80" />
					<col width="80" />
					<col width="130" />
				</colgroup>
				<tbody id="tblBudgetListData">
				</tbody>
			</table>
		</div>
	</div><!--// pop_con -->
</div><!--// pop_wrap -->
<div class="modal consBudgetListPop" style="display:none;"></div>

