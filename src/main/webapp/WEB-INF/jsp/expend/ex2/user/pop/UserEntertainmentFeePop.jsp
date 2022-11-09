<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>

<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Bizbox A</title>

<!--Kendo ui css-->
<link rel="stylesheet" type="text/css"
	href="../../../css/kendoui/kendo.common.min.css">
<link rel="stylesheet" type="text/css"
	href="../../../css/kendoui/kendo.dataviz.min.css">
<link rel="stylesheet" type="text/css"
	href="../../../css/kendoui/kendo.mobile.all.min.css">

<!-- Theme -->
<link rel="stylesheet" type="text/css"
	href="../../../css/kendoui/kendo.silver.min.css" />

<!--css-->
<link rel="stylesheet" type="text/css" href="../../../css/common.css">

<!--Kendo UI customize css-->
<link rel="stylesheet" type="text/css" href="../../../css/reKendo.css">

<!--js-->
<script type="text/javascript"
	src="../../../Scripts/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../../../Scripts/common.js"></script>

<!--Kendo ui js-->
<script type="text/javascript"
	src="../../../Scripts/kendoui/jquery.min.js"></script>
<script type="text/javascript"
	src="../../../Scripts/kendoui/kendo.all.min.js"></script>
</head>

<body>
	<div class="pop_wrap" style="width: 698px;">
		<div class="pop_head">
			<h1>접대비등록 (ERPiU)</h1>
			<a href="#n" class="clo"><img
				src="../Images/btn/btn_pop_clo01.png" alt="" /></a>
		</div>

		<div class="pop_con">
			<div class="com_ta">
				<table>
					<colgroup>
						<col width="120" />
						<col width="213" />
						<col width="120" />
						<col width="" />
					</colgroup>
					<tr>
						<th>발생일자</th>
						<td colspan="3"><input type="text" id="txtStartDate" /></td>
					</tr>
					<tr>
						<th>사용구분</th>
						<td><select class="selectmenu" style="width: 180px;"
							id="sel_useFg">
						</select></td>
						<th>증빙구분</th>
						<td><select class="selectmenu" style="width: 180px;"
							id="sel_authFg">
						</select></td>
					</tr>
					<tr>
						<th>신용카드</th>
						<td colspan="3"><input type="text" style="width: 123px;"
							class="fl mr5" id="txt_cardNum" /> <input type="hidden"
							id="txt_cardCode" />
							<div class="controll_btn p0 fl">
								<button id="btnCardSelect">선택</button>
							</div></td>
					</tr>
					<tr>
						<th>접대상대</th>
						<td colspan="3"><input type="text" style="width: 123px;"
							class="fl mr5" id="txt_partnerName" /> <input type="hidden"
							id="txt_partnerCode" />
							<div class="controll_btn p0 fl">
								<button id="btnPartnerSelect">선택</button>
							</div></td>
					</tr>
					<tr>
						<th>사업자번호</th>
						<td><input type="text" style="width: 95%" id="txt_partnerNum" disabled="disabled" />
						</td>
						<th>대표자</th>
						<td><input type="text" style="width: 95%" id="txt_ceoName" disabled="disabled"/></td>
					</tr>
					<tr>
						<th>주민번호</th>
						<td colspan="3"><input type="text" style="width: 34%" disabled="disabled"
							id="txt_resNum" /></td>
					</tr>
					<tr>
						<th>사용금액</th>
						<td><input type="text" style="width: 95%; text-align: right;" disabled="disabled"
							id="txt_maskAmt" /> <input type="hidden" style="width: 95%"
							id="txt_amt" /></td>
						<th>금액초과</th>
						<td><input type="checkbox" name="inp_chk" class="ml10"
							style="visibility: hidden;" id="chkRecept20"> <label
							class="" for="chkRecept20">경조사비 20만원 초과액</label></td>
					</tr>
					<tr>
						<th>물품대</th>
						<td><input type="text" style="width: 95%; text-align: right;"
							id="txt_maskMetirialAmt" /> <input type="hidden" style="width: 95%"
							id="txt_metirialAmt" /></td>
						<th>봉사료</th>
						<td><input type="text" style="width: 95%; text-align: right;"
							id="txt_maskServiceAmt" /> <input type="hidden"
							style="width: 95%" id="txt_serviceAmt" /></td>
					</tr>
					<tr>
						<th>접대내역</th>
						<td colspan="3"><input type="text" style="width: 98%"
							id="txt_entertainment" /></td>
					</tr>
					<tr>
						<th>비고</th>
						<td colspan="3"><input type="text" style="width: 98%"
							id="txt_note" /></td>
					</tr>
				</table>
			</div>
		</div>
		<!-- //pop_con -->

		<div class="pop_foot">
			<div class="btn_cen pt12">
				<input type="button" value="확인" id="btnCommit" /> <input
					type="button" class="gray_btn" value="취소" id="btnRollback" />
			</div>
		</div>
		<!-- //pop_foot -->
	</div>
	<!-- //pop_wrap -->
</body>

<script>
	var FI_T000024 = JSON.parse('${FI_T000024}' || []);
	var FI_T000025 = JSON.parse('${FI_T000025}' || []);
	var feeSeq =  '${ViewBag.feeSeq}';
	var callbackFunc = '${ViewBag.callback}';
	
	
	/*	[ 문서 ] 문서 준비
	-------------------------------------------------------- */
	$(document).ready(function() {
		/* 문서 초기화 */
		fnSetPopInit();

		/* 버튼 이벤트 초기화 */
		fnInitBtnEvent();

		/* 키다운 이벤트 설정 */
		fnInitKeyEvent();
		
		/* 수정모드의 경우 기존 정보 조회 */
		if(feeSeq){
			fnLoadEntertainmentData({'feeSeq' : feeSeq});
		}
	});

	/*	[ 조회 ] 문서 정보 조회
	-------------------------------------------------------- */	
	function fnLoadEntertainmentData(searchObj){

		$.ajax({
			async : true,
			type : "post",
			data : searchObj,
			url : "<c:url value='/ex2/expend/user/ExUserSelectEntertainmentFee.do'/>",
			datatype : "json",
			success : function(result) {
				if(result.result.aData && (result.result.resultCode != 'FAIL')){
					var item =  result.result.aData;
					$('#txtStartDate').val(item.startDate);
					$("#sel_useFg").val(item.useFgName).selectmenu('refresh');
					$("#sel_authFg").val(item.authFgName).selectmenu('refresh');
					
					$('#txt_cardNum').val(item.cardNum);
					$('#txt_cardCode').val(item.cardCode);
					$('#txt_partnerName').val(item.partnerName);
					$('#txt_partnerCode').val(item.partnerCode);
					$('#txt_partnerNum').val(item.partnerNum);
					$('#txt_ceoName').val(item.ceoName);
					$('#txt_resNum').val(item.resNum);
					
					$('#txt_amt').val(item.amt);
					$('#txt_metirialAmt').val(item.metirialAmt);
					$('#txt_serviceAmt').val(item.serviceAmt);
					
					$('#txt_maskAmt').val(fnSetCurrencyCode(item.amt));
					$('#txt_maskMetirialAmt').val(fnSetCurrencyCode(item.metirialAmt));
					$('#txt_maskServiceAmt').val(fnSetCurrencyCode(item.serviceAmt));
					
					$('#txt_entertainment').val(item.entertainment); 
					$('#txt_note').val(item.note);
					$('#chkRecept20').prop('checked', item.amtOverYn == 'Y');
					feedSeq = item.feeSeq;
				}
			},
			error : function(err) {
			}
		});
	}
	
	/*	[ 문서 ] 문서 초기화
	-------------------------------------------------------- */
	function fnSetPopInit() {

		/* 데이트 피커 초기화 */
		$("#txtStartDate").kendoDatePicker({
			format : "yyyy-MM-dd"
		}).val(
				function() {
					var today = new Date();
					var y = today.getFullYear();
					var m = ((today.getMonth() + 1) < 10 ? '0'
							+ (today.getMonth() + 1) : (today.getMonth() + 1));
					var d = (today.getDate() < 10 ? '0' + today.getDate() : today.getDate());
					return [ y, m, d ].join('-');
				});

		/* 사용구분 초기화 */
		$('#sel_useFg').unbind().empty();
		$.each(FI_T000024, function(idx, item) {
			console.log(item);
			$('#sel_useFg').append(
					'<option value="' + item.detailCode + '">'
							+ item.detailCodeName + '</option>');
		});

		/* 증빙구분 초기화 */
		$('#sel_authFg').unbind().empty();
		$.each(FI_T000025, function(idx, item) {
			$('#sel_authFg').append(
					'<option value="' + item.detailCode + '">'
							+ item.detailCodeName + '</option>');
		});
		return;
	}

	/*	[ 키 ] 키다운 이벤트 설정
	-------------------------------------------------------- */
	function fnInitKeyEvent() {
// 		$('#txt_maskAmt').on("keyup change", function() {
// 			$('#txt_amt').val(fnSetDecimalCode(this.value));
// 			this.value = fnSetCurrencyCode($('#txt_amt').val());
// 		});
		$('#txt_maskMetirialAmt').on("keyup change", function() {
			$('#txt_metirialAmt').val(fnSetDecimalCode(this.value));
			this.value = fnSetCurrencyCode($('#txt_metirialAmt').val());
			var metrialAmt = parseInt(($('#txt_metirialAmt').val() || 0)); 
			var servAmt = parseInt(($('#txt_serviceAmt').val() || 0));
			$('#txt_amt').val(fnSetDecimalCode(metrialAmt + servAmt));
			$('#txt_maskAmt').val(fnSetCurrencyCode($('#txt_amt').val()));
		});
		$('#txt_maskServiceAmt').on("keyup change", function() {
			$('#txt_serviceAmt').val(fnSetDecimalCode(this.value));
			this.value = fnSetCurrencyCode($('#txt_serviceAmt').val());
			var metrialAmt = parseInt(($('#txt_metirialAmt').val() || 0)); 
			var servAmt = parseInt(($('#txt_serviceAmt').val() || 0));
			$('#txt_amt').val(fnSetDecimalCode(metrialAmt + servAmt));
			$('#txt_maskAmt').val(fnSetCurrencyCode($('#txt_amt').val()));
		});
	}

	/*	[ 통화코드 ] 통화코드 마스크 적용
	-------------------------------------------------------- */
	function fnSetCurrencyCode(string) {
		return (''+string).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	/*	[ 통화코드 ] 통화코드 마스크 해제
	-------------------------------------------------------- */
	function fnSetDecimalCode(string) {
		return (''+string).replace(/\D/g, '');
	}

	/*	[ 버튼 ] 버튼 이벤트 설정
	-------------------------------------------------------- */
	function fnInitBtnEvent() {

		/* [확인] 버튼 클릭 이벤트 */
		$('#btnCommit').unbind('click').click(function() {
			// TODO : 필수값 입력 여부 확인 로직 필요함.
			fnSaveEntertainment(fnGetSaveObj());
		});
		/* [취소] 버튼 클릭 이벤트 */
		$('#btnRollback').unbind('click').click(function() {
			window.close();
		});
		/* [신용카드] 버튼 클릭 이벤트 */
		$('#btnCardSelect').click(function() {
			var resultCode = fnOpenCodePop({
				codeType : 'Card',
				callback : 'fnCmmCodeCallback'
			});

			if (parseInt(resultCode) != 0) {
				alert('카드정보 조회 도중 오류가 발생하였습니다.');
				console.log(resultCode);
			}
		});
		/* [접대상대] 버튼 클릭 이벤트 */
		$('#btnPartnerSelect').click(function() {
			var resultCode = fnOpenCodePop({
				codeType : 'Partner',
				callback : 'fnCmmCodeCallback'
			});

			if (parseInt(resultCode) != 0) {
				alert('거래처정보 조회 도중 오류가 발생하였습니다.');
				console.log(resultCode);
			}
		});
	}
	
	/*	[ 저장 ] 접대비등록 정보 저장
	-------------------------------------------------------- */
	function fnSaveEntertainment(saveObj){
		if( feeSeq && feeSeq != "0"){
			$.ajax({
				async : true,
				type : "post",
				data : saveObj,
				url : "<c:url value='/ex2/expend/user/ExUserUpdateEntertainmentFee.do'/>",
				datatype : "json",
				success : function(result) {
					if(result.result.resultCode != 'FAIL'){
						if( typeof(opener[callbackFunc]) == 'function'){
							opener[callbackFunc](saveObj);
							window.close();
						}else{
							alert('콜백 함수를 찾을 수 없습니다.');
						}
					}
				},
				error : function(err) {
				}
			});
		}else {
			$.ajax({
				async : true,
				type : "post",
				data : saveObj,
				url : "<c:url value='/ex2/expend/user/ExUserInsertEntertainmentFee.do'/>",
				datatype : "json",
				success : function(result) {
					if(result.result.resultCode != 'FAIL'){
						feeSeq = result.result.resultCode;
						saveObj.feeSeq = feeSeq;
						if( typeof(opener[callbackFunc]) == 'function'){
							opener[callbackFunc](saveObj);
							window.close();
						}else{
							alert('콜백 함수를 찾을 수 없습니다.');
						}
					}
				},
				error : function(err) {
				}
			});
		}
	}
	
		
	/*	[ 콜백 ] 공통 코드 콜백 함수
	-------------------------------------------------------- */
	function fnCmmCodeCallback(param) {
		if (param.type == 'card') {
			
			$('#txt_cardNum').val(param.obj.displayCardNum || '');
			$('#txt_cardCode').val(param.obj.cardCode || '');
		} else if (param.type == 'partner') {
			$('#txt_partnerName').val(param.obj.partnerName || '');
			$('#txt_partnerCode').val(param.obj.partnerCode || '');
			$('#txt_partnerNum').val(param.obj.partnerNo || '');
			$('#txt_ceoName').val(param.obj.ceoName || '');
			$('#txt_resNum').val(param.obj.resNo || '');
		}
	}

	/*	[ 저장 ] 리턴 객체 생성
	-------------------------------------------------------- */
	function fnGetSaveObj() {
		var returnObj = {
			'feeSeq' : feeSeq,
			'startDate' : fnSetDecimalCode($('#txtStartDate').val() || '00000000'),
			'useFgCode' : $("#sel_useFg option:selected").val() || '',
			'useFgName' : $("#sel_useFg option:selected").text() || '',
			'authFgCode' : $("#sel_authFg option:selected").val() || '',
			'authFgName' : $("#sel_authFg option:selected").text() || '',			
			'cardNum' : $('#txt_cardNum').val() || '',
			'cardCode' : $('#txt_cardCode').val() || '',
			'partnerName' : $('#txt_partnerName').val() || '',
			'partnerCode' : $('#txt_partnerCode').val() || '',
			'partnerNum' : $('#txt_partnerNum').val() || '',
			'ceoName' : $('#txt_ceoName').val() || '',
			'resNum' : $('#txt_resNum').val() || '',
			'amt' : $('#txt_amt').val() || '0',
			'metirialAmt' : $('#txt_metirialAmt').val() || '0',
			'serviceAmt' : $('#txt_serviceAmt').val() || '0',
			'entertainment' : $('#txt_entertainment').val() || '',
			'note' : $('#txt_note').val() || '',
			'amtOverYn' : $('#chkRecept20').prop('checked') ? 'Y' : 'N'
		};
		return returnObj;
	}
</script>







