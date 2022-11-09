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

<!-- 공통 정보영역 -->
<jsp:include page="../include/AdminOptionMap.jsp" flush="false" />

<body>
	<div class="pop_con">

		<!-- 예산 테이블 -->
		<div class="com_ta4">
			<table>
				<thead>
					<tr>
						<th>예산년월</th>
						<th>예산계정코드</th>
						<th>예산계정명</th>
						<th>미전송결의 합계</th>
						<th>전송결의 합계</th>
					</tr>
				</thead>
				<tbody id="tbl_totalGrid">
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td class="ri"></td>
						<td class="ri"></td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- 탭 -->
		<div class="tab_nor">
			<a href="#n" class="pre"></a>
			<ul>
				<li class="on"><a href="javascript:tab_nor_Fn(1);"><span
						class="txt">${CL.ex_notTransRes}  <!--미전송 결의--></span></a></li>
				<li><a href="javascript:tab_nor_Fn(2)"><span class="txt">
							${CL.ex_transRes}  <!--전송 결의--></span></a></li>
			</ul>
			<a href="#n" class="nex"></a>
			
		</div>

		<!-- 검색 -->
		<div class="top_box mt14">
			<dl>
				<dt>${CL.ex_keyWord}  <!--검색어--></dt>
				<dd>
					<input type="text" autocomplete="off" style="width: 400px;" class="puddSetup enter"
						id="txt_serchStr" />
				</dd>
				<dt>${CL.ex_appCondition}  <!--결재상태--></dt>
				<dd>
					<select id="sel_docStatus" class="selectmenu" style="width: 100px;">
						<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
						<option value="'001'">${CL.ex_temporarySave}  <!--임시저장--></option>
						<option value="'002'">${CL.ex_onGoing}  <!--진행중--></option>
						<option value="'008', '009'">${CL.ex_completion}  <!--완료--></option>
					</select>
				</dd>
				<dd>
					<input type="button" class="puddSetup submit" value="${CL.ex_search}" id="btn_serchData" /><!--검색-->
				</dd>
			</dl>
		</div>

		<div class="tab_area">
			<!-- 미전송결의 -->
			<div class="tab1">
				<div class="btn_div cl">
					<div class="left_div fwb mt7">
						${CL.ex_yeCount} <span id="txt_nonSendItemCnt"></span> ${CL.ex_gun}
					</div>					
					<div class="controll_btn p0">
					<div class="right_div mt7">${CL.ex_notTransResAmt}  <!--미전송 결의 금액--> <span id="txt_nonSendResAmt"></span>원
<%-- 					<button id="" class="k-button btnExcelDown">${CL.ex_excelDown}  <!--엑셀다운로드--></button>	 --%>
					</div>
					</div>
				</div>
				

				<div class="com_ta2 sc_head">
					<table>
						<colgroup>
							<col width="100" />
							<col width="90" />
							<col width="150" />
							<col width="80" />
							<col width="" />
							<col width="100" />
							<col width="85" />
						</colgroup>
						<thead>
							<tr>
								<th>${CL.ex_docNm}  <!--문서번호--></th>
								<th>${CL.ex_draftDate}  <!--기안일자--></th>
								<th>${CL.ex_draftDept}  <!--기안부서--></th>
								<th>${CL.ex_drafter}  <!--기안자--></th>
								<th>${CL.ex_docTitle}  <!--문서제목--></th>
								<th>${CL.ex_amtOfResolution}  <!--결의금액--></th>
								<th>${CL.ex_appCondition}  <!--결재상태--></th>
							</tr>
						</thead>
					</table>
				</div>

				<div class="com_ta2 ova_sc2 cursor_p bg_lightgray"
					style="height: 369px;">
					<table>
						<colgroup>
							<col width="100" />
							<col width="90" />
							<col width="150" />
							<col width="80" />
							<col width="" />
							<col width="100" />
							<col width="85" />
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
						${CL.ex_yeCount} <span id="txt_sendItemCnt"></span> ${CL.ex_gun}
					</div>					
					<div class="controll_btn p0">
						<div class="right_div mt7">${CL.ex_transResAmt}  <!--전송 결의 금액--> <span id="txt_sendResAmt"></span>원
<%-- 							<button id="" class="k-button btnExcelDown">${CL.ex_excelDown}  <!--엑셀다운로드--></button>	 --%>
						</div>
					</div>
				</div>
				<div class="com_ta2 sc_head">
					<table>
						<colgroup>
							<col width="100" />
							<col width="90" />
							<col width="150" />
							<col width="80" />
							<col width="" />
							<col width="100" />
							<col width="85" />
						</colgroup>
						<thead>
							<tr>
								<th>${CL.ex_docNm}  <!--문서번호--></th>
								<th>${CL.ex_draftDate}  <!--기안일자--></th>
								<th>${CL.ex_draftDept}  <!--기안부서--></th>
								<th>${CL.ex_drafter}  <!--기안자--></th>
								<th>${CL.ex_docTitle}  <!--문서제목--></th>
								<th>${CL.ex_amtOfResolution}  <!--결의금액--></th>
								<th>${CL.ex_transfer}  <!--전송자--></th>
							</tr>
						</thead>
					</table>
				</div>

				<div class="com_ta2 ova_sc2 cursor_p bg_lightgray"
					style="height: 369px;">
					<table>
						<colgroup>
							<col width="100" />
							<col width="90" />
							<col width="150" />
							<col width="80" />
							<col width="" />
							<col width="100" />
							<col width="85" />
						</colgroup>
						<tbody id="tbl_sendContents">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>





<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="fileName" value="" id="fileName" />
	<input type="hidden" name="excelHeader" value="" id="excelHeader" /> 
	
	<input type="hidden" name="fDate" value="" id="formfrDate" />
	<input type="hidden" name="toDate" value="" id="formtoDate" />
	<input type="hidden" name="erpGisu" value="" id="formerpGisu" />
	<input type="hidden" name="erpBudgetSeq" value="" id="formerpBudgetSeq" />
	<input type="hidden" name="erpBottomSeq" value="" id="formerpBottomSeq" />
	<input type="hidden" name="erpMgtSeq" value="" id="formerpMgtSeq" />	
	<input type="hidden" name="docStatus" value="" id="formdocStatus" />
	<input type="hidden" name="serchStr" value="" id="formserchStr" />
	<input type="hidden" name="balanceYN" value="" id="formbalanceYN" />
</form>

</html>


<script>
	/*	스크립트 준비
	-------------------------------------- */
	$(document).ready(function() {
		/* 돔 객체 초기화 */
		fnSetElementIntit();

		/* 메인정보 서버 호출 */
		fnGetResListInfo();
		
	});

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
	--------------------------------------*/
	function fnAdminReportExcelDown() {
		if(!yesilListCnt){
			alert("${CL.ex_dataDoNotExists}");
			return;
		}

		$("#fileName").val( "예실대비현황 결집행실적" );

		/* Excel 헤더 정의 */
	
		var excelHeader = {};
		excelHeader.docNo= "문서번호";
		excelHeader.expendDate= "기안일자";
		excelHeader.deptName= "기안부서";
		excelHeader.empName= "기안자";
		excelHeader.docTitle= "문서제목";
		excelHeader.budgetAmt= "결의금액";
		excelHeader.sendEmpName= "전송자";
		
		$("#excelHeader").val( JSON.stringify(excelHeader) );
		var url = "<c:url value='/ex/admin/CommonExcelDown.do'/>";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
	 


	/*	[검색] 예산 품의서 리스트 정보 조회
	-------------------------------------- */
	function fnGetResListInfo() {
		
		var param = {};
		param.fromDate = '${fromDate}'.replace(/-/g, '') + '01';
		param.toDate = '${toDate}'.replace(/-/g, '') + '31';
		param.erpBudgetSeq = '${ViewBag.erpBudgetSeq}';
		param.erpBizplanSeq = '${ViewBag.erpBizplanSeq}';
		param.erpBgacctSeq = '${ViewBag.erpBgacctSeq}';
		param.docStatus = $("#sel_docStatus").val() || '';
		param.serchStr = $('#txt_serchStr').val();
		param.balanceYN = $('#chkBalanceYn').prop('checked') ? 'Y' : 'N';
		
		/* 서버 호출 */
		fnResDataInfoCall(param);
	}
	


	/*	[초기화] 품의서 정보 호출
	-------------------------------------- */
	function fnResDataInfoCall(param) {
		$.ajax({
			async : true,
			type : "post",
			data : param,
			url : "<c:url value='/expend/np/admin/report/NpAdminYesilResInfoSet.do' />",
			datatype : "json",
			success : function(result) {
				if (result.result.resultCode != 'SUCCESS') {
					alert('서버 오류 발생');
					console.log(result.result.errorTrace);
				} else {
					console.log('################# 예실대비/결의 내역 데이터 출력 ################');
					console.log(result);

					/* 상단 요약 테이블 출력 */
					fnSetTotalTable(result.result.aData);

					/* 본문 테이블 출력 */
					fnSetMainTable(result.result.aaData);
				}
			},
			error : function(err) {
				console.log(err);
			}
		});
	}

	/*	[테이블] 상단 품의 내역 합계 페이지 출력
	-------------------------------------- */
	function fnSetTotalTable(item) {
		var fromDate = '${ViewBag.fromDate}';
		fromDate = fromDate.length == 6 ? fromDate.substring(0,4) + '-' + fromDate.substring(4,6) : fromDate;
		var toDate = '${ViewBag.toDate}';
		toDate = toDate.length == 6 ? toDate.substring(0,4) + '-' + toDate.substring(4,6) : toDate;
		
		$('#tbl_totalGrid').empty();
		var tr = '<tr>';
		tr += '	<td>' + fromDate + ' ~ ' + toDate + '</td>';
		tr += '	<td> ${ViewBag.erpBgacctSeq} </td>';
		tr += '	<td> ${ViewBag.erpBgacctName} </td>';
		tr += '	<td class="ri"> ' + fnShowAmt(item.nonSendResAmt) + ' </td>';
		tr += '	<td class="ri"> ' + fnShowAmt(item.sendResAmt) + ' </td>';
		tr += '</tr>';
		$('#tbl_totalGrid').append(tr);
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
	
	
	
	
	/*	[테이블] 본문 품의 내역 리스트 조회
	-------------------------------------- */
	
	var yesilListCnt = 0;
	function fnSetMainTable(param) {		
		$('#tbl_nonSendContents').empty();
		$('#tbl_sendContents').empty();
		yesilListCnt = param.length;
		var nonSendItemCnt = 0;
		var sendItemCnt = 0;
		var nonSendResAmt = 0;
		var sendResAmt = 0;
		
		for (var i = 0; i < param.length; i++) {
			var item = param[i];
			if(item.erpSendYN == 'Y'){
				/* 전송 결의서의 경우 */
				var tr = document.createElement('tr');
                $(tr).append('	<td>' + fnShowText(item.docNo) + '</td>');
                if(item.expendDate.length == 8){
    				item.expendDate = item.expendDate.substring(0,4) + '-' + item.expendDate.substring(4,6) + '-' + item.expendDate.substring(6,8);
    			}
				$(tr).append('	<td>' + fnShowText(item.expendDate) + '</td>');
				$(tr).append('	<td>' + fnShowText(item.deptName) + '</td>');
				$(tr).append('	<td>' + fnShowText(item.empName) + '</td>');
				$(tr).append('	<td>' + fnShowText(item.docTitle) + '</td>');
				$(tr).append('	<td class="ri">' + fnShowAmt(item.budgetAmt) + '</td>');
				$(tr).append('	<td>' + fnShowText( ( item.sendEmpName || '-' ) ) + '</td>');
				$(tr).attr('value', escape(JSON.stringify(item)));
				$(tr).click(function(){
					var _item = JSON.parse(unescape( $(this).attr('value') ) );
					fnAppdocPop(_item.docSeq, _item.formSeq);
				});	
				sendResAmt += item.budgetAmt;
				sendItemCnt++;
				$('#tbl_sendContents').append(tr);
			}else{
				/* 미전송 결의서의 경우 */
				var tr = document.createElement('tr');;
				$(tr).append('	<td>' + fnShowText(item.docNo) + '</td>');
				if(item.expendDate.length == 8){
					item.expendDate = item.expendDate.substring(0,4) + '-' + item.expendDate.substring(4,6) + '-' + item.expendDate.substring(6,8);
				}
				$(tr).append('	<td>' + fnShowText(item.expendDate) + '</td>');
				$(tr).append('	<td>' + fnShowText(item.deptName) + '</td>');
				$(tr).append('	<td>' + fnShowText(item.empName) + '</td>');
				$(tr).append('	<td>' + fnShowText(item.docTitle) + '</td>');
				$(tr).append('	<td class="ri">' + fnShowAmt(item.budgetAmt) + '</td>');
				$(tr).append('	<td>' + fnGetDocStatusLabel(item.docStatus) + '</td>');
				$(tr).attr('value', escape(JSON.stringify(item)));
				$(tr).click(function(){
					var _item = JSON.parse(unescape( $(this).attr('value') ) );
					fnAppdocPop(_item.docSeq, _item.formSeq);
				});	
				nonSendResAmt += item.budgetAmt;
				nonSendItemCnt++;
				$('#tbl_nonSendContents').append(tr);
			}
		}
		
		$('#txt_sendResAmt').html(fnShowAmt(sendResAmt));
		$('#txt_nonSendResAmt').html(fnShowAmt(nonSendResAmt));
		
		/* 미전송 결의서 데이터 없는 경우 */
		if(nonSendItemCnt == 0){
			$('#tbl_nonSendContents').append('<tr> <td colspan="7"> ${CL.ex_dataDoNotExists} </td> </tr>');
		}
		if(sendItemCnt == 0){
			$('#tbl_sendContents').append('<tr> <td colspan="7"> ${CL.ex_dataDoNotExists} </td> </tr>');
		}
		
		$('#txt_nonSendItemCnt').html(nonSendItemCnt);
		$('#txt_sendItemCnt').html(sendItemCnt);
	}

	/*	[공용] 결재 상태 적용
	---------------------------------------- */
	function fnGetDocStatusLabel(value) {
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