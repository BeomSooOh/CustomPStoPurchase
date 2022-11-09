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
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>

<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<body>
	<div class="pop_head">
		<h1>${CL.ex_erpResHis}  <!--ERP 결의 현황--></h1>
		<a href="#n" class="clo"><img
			src="../../../Images/btn/btn_pop_clo02.png" alt="" /></a>
	</div>

	<div class="pop_con">

		<!-- 예산 테이블 -->
		<div class="com_ta4">
			<table>
				<thead>
					<tr>
						<th>${CL.ex_gisu}  <!--기수--></th>
						<th>${CL.ex_accountingUnit}  <!--회계단위--></th>
						<th>${CL.ex_bgtSubCode}  <!--예산과목코드--></th>
						<th>${CL.ex_budgetSub}  <!--예산과목--></th>
						<th id="erpResGbnNm">${CL.ex_erpResBgtSum}  <!--ERP 결의금액 합계--></th>
					</tr>
				</thead>
				<tbody id="tbl_totalGrid">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td class="ri"></td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 검색 -->
		<div class="top_box mt14">
			<dl>
				<dt>${CL.ex_resDate}  <!--결의일자--></dt>
				<dd>
					<input type="text" autocomplete="off" value="${fromDate}" id="txtGisuFromDate"
						class="puddSetup" pudd-type="" disabled="true" /> ~ <input
						type="text" value="${toDate}" id="txtGisuToDate" value=""
						class="puddSetup" pudd-type="" disabled="true" />
				</dd>
				<dt>${CL.ex_keyWord}  <!--검색어--></dt>
				<dd>
					<input type="text" autocomplete="off" style="width: 200px;" class="puddSetup enter"
						id="txt_serchStr" />
				</dd>
				<dd>
					<input type="button" class="puddSetup submit" value="${CL.ex_search}" id="btn_serchData" />  <!--검색-->
				</dd>
			</dl>
		</div>

		<!-- 현황테이블 -->
		<div class="btn_div cl">
			<div class="left_div fwb mt7">
				${CL.ex_yeCount} <span id="txt_consCnt"></span> ${CL.ex_gun}
			</div>
		
		<div class="right_div mt7">
		<div class="controll_btn p0">
					<button id="btnExcelDown" class="k-button">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
				</div>
		</div>
</div>
		<div class="com_ta2 sc_head">
			<table>
				<colgroup>
					<col width="120" />
					<col width="140" />
					<col width="250" />
					<col width="130" />
					<col width="" />
					<col width="100" />
				</colgroup>
				<thead>
					<tr>
						<th id="criteria">${CL.ex_resDateAndSeq}  <!--결의일자/순번--></th>
						<th>${CL.ex_project}<!--프로젝트-->/${CL.ex_department}<!--부서--></th>
						<th>${CL.ex_note}  <!--적요--></th>
						<th>${CL.ex_elecAppDocNum}  <!--전자결재 문서번호--></th>
						<th>${CL.ex_elecAppTitle}  <!--전자결재 제목--></th>
						<th>${CL.ex_money}  <!--금 액--></th>
					</tr>
				</thead>
			</table>
		</div>

		<div class="com_ta2 ova_sc2 cursor_p bg_lightgray"
			style="height: 369px;">
			<table>
				<colgroup>
					<col width="120" />
					<col width="140" />
					<col width="250" />
					<col width="130" />
					<col width="" />
					<col width="100" />
				</colgroup>
				<tbody id="tbl_contentsGrid">

				</tbody>
			</table>
		</div>
	</div>
</body>



<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="fileName" value="" id="fileName" />
	<input type="hidden" name="excelHeader" value="" id="excelHeader" />
	<input type="hidden" name="fromDate" value="" id="formfrDate" />
	<input type="hidden" name="toDate" value="" id="formtoDate" />
	<input type="hidden" name="erpBudgetSeq" value="" id="formerpBudgetSeq" />
	<input type="hidden" name="erpMgtSeq" value="" id="formerpMgtSeq" />
	<input type="hidden" name="erpBottomSeq" value="" id="formerpBottomSeq" />
	<input type="hidden" name="erpCompSeq" value="" id="formerpCompSeq" />	
	<input type="hidden" name="erpDivSeq" value="" id="formerpDivSeq" />
	<input type="hidden" name="erpEmpSeq" value="" id="formerpEmpSeq" />
	<input type="hidden" name="erpResGbn" value="${ViewBag.erpResGbn}" id="erpResGbn" />
</form>
</html>


<script>

	var erpTotalCriteria = '${ViewBag.erpResGbn}';

	/*	스크립트 준비
	-------------------------------------- */
	$(document).ready(function() {
		/* 돔 객체 초기화 */
		fnSetElementIntit();

		/* 메인정보 서버 호출 */
		fnGetConsListInfo();
		
		if($('#erpResGbn').val()=='1'){
			$('#erpResGbnNm').html('ERP 승인금액 합계');
		}
	});

	/*	[초기화] 돔객체 초기화
	-------------------------------------- */
	function fnSetElementIntit() {
		/* 엑셀 다운로드 */
		$('#btnExcelDown').click(function() {
			fnAdminReportExcelDown();
		});

		/* 예산 정보 조회 */
		$('#btn_serchData').click(function() {
			fnSetFilterdGrid();
		});

		// 엔터 검색
		$('.enter').keydown(function(event) {
			if (event.keyCode === 13) {
				event.returnValue = false;
				event.cancelBubble = true;
				fnSetFilterdGrid();
			}
		});
	}

	function fnSetFilterdGrid(){
		var textFilter = $('#txt_serchStr').val();
		var aaData = [];
		for(var i = 0; i < erpResAaData.length; i++){
			var item = erpResAaData[i];
			if(item.erpKey.replace('-', '').indexOf( textFilter.replace('-', '').replace('/', '').replace(' ', '' ) ) > -1 ){
				aaData.push(item);
			}else if( item.note.indexOf(textFilter) > -1 ){
				aaData.push(item);
			}else if( ( item.docTitle || '') .indexOf(textFilter) > -1 ){
				aaData.push(item);
			}else if( ( item.docNo || '').indexOf(textFilter) > -1 ){
				aaData.push(item);
			}
		}
		fnSetMainTable(aaData);
	}
	
	 /*	[ 엑셀 ] 예실대비현황
	--------------------------------------*/
	function fnAdminReportExcelDown() {
		if(!yesilListCnt){
			alert("${CL.ex_dataDoNotExists}");
			return;
		}

		$("#fileName").val( "예실대비현황 ERP결의행실적" );

		/* Excel 헤더 정의 */
	
		var excelHeader = {};
		
		excelHeader.erpKey= "결의일자/순번";
		excelHeader.note= "적요";
		excelHeader.docNo="전자결재 문서번호";
		excelHeader.docTitle= "전자결재 제목";
		excelHeader.amt= "금액";
		
		$("#excelHeader").val( JSON.stringify(excelHeader) );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
	

	 


	 

	
	/*	[검색] 예산 품의서 리스트 정보 조회
	-------------------------------------- */
	function fnGetConsListInfo() {
		
		
		/* 액셀 다운로드 파라미터 세팅 */
		$('#formfrDate').val('${fromDate}'.replace(/-/g, ''));
		$('#formtoDate').val('${toDate}'.replace(/-/g, ''));
		$('#formerpBudgetSeq').val('${ViewBag.erpBudgetSeq}');
		$('#formerpMgtSeq').val('${ViewBag.erpMgtSeq}' + '|');
		$('#formerpBottomSeq').val('${ViewBag.erpBottomSeq}' + '|');
		$('#formerpCompSeq').val('${ViewBag.erpCompSeq}');
		$('#formerpDivSeq').val('${ViewBag.erpDivSeq}');
		$('#formerpEmpSeq').val('${ViewBag.erpEmpSeq}');
		
		
		var param = {};
		param.fromDate = '${fromDate}'.replace(/-/g, '');
		param.toDate = '${toDate}'.replace(/-/g, '');
		param.erpBudgetSeq = '${ViewBag.erpBudgetSeq}';
		param.erpMgtSeq = '${ViewBag.erpMgtSeq}' + '|';
		param.erpBottomSeq = '${ViewBag.erpBottomSeq}' + '|';
		param.erpCompSeq = '${ViewBag.erpCompSeq}';
		param.erpDivSeq = '${ViewBag.erpDivSeq}';
		param.erpEmpSeq = '${ViewBag.erpEmpSeq}';
		param.erpResGbn = '${ViewBag.erpResGbn}';
		/* 서버 호출 */
		fnConsDataInfoCall(param);
	}
	
	

	/*	[초기화] 품의서 정보 호출
	-------------------------------------- */
	var erpResAaData = [];
	function fnConsDataInfoCall(param) {
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/admin/report/NpAdminYesilERPResInfoSet.do' />",
			datatype : "json",
			success : function(result) {
				if (result.result.resultCode != 'SUCCESS') {
					alert('서버 오류 발생' + result);		
	
					console.log(result.result.errorTrace);
				} else {
					erpResAaData = result.result.aaData;
					fnSetMainTable(result.result.aaData);
				}
			},
			error : function(err) {
				console.log(err);
				

			}
		});
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
		var eaType = "${eaType}";
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
	

	/*	[테이블] 본문 품의 내역 리스트 조회
	-------------------------------------- */
	var yesilListCnt = 0;
	function fnSetMainTable(param) {
		console.log(param);
		yesilListCnt = param.length;
		/* 상단 통계 테이블 출력 */
		$('#tbl_totalGrid').empty();
		var tr = document.createElement('tr');
		if(param.length > 0){
			var totalEmpAmt = 0.0;
			for(var i = 0; i < param.length; i++){
				totalEmpAmt = totalEmpAmt + Number( param[i].amt );
			}
			
			var item = param[0];
			$(tr).append('	<td> ${ViewBag.erpGisu} </td>'); // 기수
			$(tr).append('	<td> ${ViewBag.erpDivName} </td>');
			$(tr).append('	<td>' + fnShowText( item.erpBudgetSeq ) + '</td>');
			$(tr).append('	<td>' + fnShowText( item.erpBudgetName ) + '</td>');
			$(tr).append('	<td  class="ri">' + fnShowAmt(totalEmpAmt) + '</td>');

		}else{
			$(tr).append('<td colspan="5">${CL.ex_dataDoNotExists}</td>');
		}
		$('#tbl_totalGrid').append(tr);
		
		
		/* 하단 메인 테이블 출력 */
		$('#tbl_contentsGrid').empty();
		$('#txt_consCnt').html(param.length);

		for (var i = 0; i < param.length; i++) {
			var item = param[i];
			
			if(erpTotalCriteria == 1){
				$('#criteria').text('승인일자/순번');
				var erpKeyDispDt = item.erpKeyDispDt.substr(0,4) + '-' + item.erpKeyDispDt.substr(4,2)  + '-' + (item.erpKeyDispDt.substr(6).replace('-', ' / '));
			}else{
				var erpKeyDispDt = item.erpKey.substr(0,4) + '-' + item.erpKey.substr(4,2)  + '-' + (item.erpKey.substr(6).replace('-', ' / '));
			}
			
			var tr = document.createElement('tr');
			$(tr).append('	<td>' + fnShowText( erpKeyDispDt ) + '</td>');
			$(tr).append('	<td>' + fnShowText(item.erpMgtName) + '</td>');
			$(tr).append('	<td>' + fnShowText(item.note) + '</td>');
			$(tr).append('	<td>' + fnShowText(item.docNo || 'G20 생성 결의서') + '</td>');
			$(tr).append('	<td>' + fnShowText( item.docTitle ) + '</td>');
			$(tr).append('	<td  class="ri">' + fnShowAmt(item.amt) + '</td>');
			$('#tbl_contentsGrid').append(tr);
			
			$(tr).attr('value', escape(JSON.stringify(item)));
			$(tr).click(function(){
				var _item = JSON.parse(unescape( $(this).attr('value') ) );
				if(!_item.docSeq){
					return;
				}
				fnAppdocPop(_item.docSeq, _item.formSeq);
			});	
		}
		if(param.length == 0){
			$('#tbl_contentsGrid').append('<tr> <td colspan="5"> ${CL.ex_dataDoNotExists} </td> </tr>');
		}
	}

	/*	[공통] 노출 텍스트 데이터 공통 처리 함수 
	-------------------------------------- */
	function fnShowText(value) {
		if (!value) {
			return '';
		}
		return value;
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





