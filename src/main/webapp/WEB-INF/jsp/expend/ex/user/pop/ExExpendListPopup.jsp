<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/jquery.dataTables.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.select.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.scroller.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.rowReorder.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.fixedHeader.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/neos/NeosUtil.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/CommonEx.js'></script> --%>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/jquery.maskMoney.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/ExAmtCommon.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/ExExpend.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.date.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.event.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.format.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.list.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.pop.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/jquery.ex.valid.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/expend/jQuery.exp.expend.focus.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/ex/ExOption.js'></script>

<script>
	// alert('${ViewBag.empInfo.groupSeq}');

	/* 변수정의 */
	var ifSystem = '${ViewBag.ifSystem}';
	var inputFlag = true;
	/* 지출결의 파일 임시 변수 선언*/
	var tmpAttchBindList = '';
	/* 종결문서 수정인 경우 기존 항목의 금액 정보 저장 */
	var basicListAmt = '0';
	/* 켄도데이트피커 트리거 한번 호출하는 변수 */
	var isFirstChange = true;
	/* 접대비 seq */
	var feeSeq = 0;
	var codeHelperLngpack = '<%=BizboxAMessage.getMessage("TX000016475","코드도움")%>';

	/* 지출결의 - 사용자 */
	var expendListUseEmp = new kendo.data.ObservableObject(ExCodeOrg);
	/* 지출결의 - 항목 */
	var expendList = new kendo.data.ObservableObject(ExExpendList);
	expendList.set('expendSeq', expend.get('expendSeq'));
	expendList.bind("change", function(e) {
		if (e.field == 'amt') { /* 공급대가 */
			this.set('amt', (this.get('amt')).toString().replace(/,/g, '')
					.replace('.00', ''));
			$('#txtListAmt').val(
					this.get('amt').toString().replace(/\B(?=(\d{3})+(?!\d))/g,
							","));
		}
		if (e.field == 'taxAmt') { /* 부가세액 */
			this.set('taxAmt', (this.get('taxAmt')).toString().replace(/,/g,
					'').replace('.00', ''));
			$('#txtListTaxAmt').val(
					this.get('taxAmt').toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ","));
		}
		if (e.field == 'subTaxAmt') { /* 세액 */
			this.set('subTaxAmt', (this.get('subTaxAmt')).toString()
					.replace(/,/g, '').replace('.00', ''));
			$('#txtListSubTaxAmt').val(
					this.get('subTaxAmt').toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ","));
		}
		if (e.field == 'stdAmt') { /* 공급가액 */
			this.set('stdAmt', (this.get('stdAmt')).toString().replace(/,/g,
					'').replace('.00', ''));
			$('#txtListStdAmt').val(
					this.get('stdAmt').toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ","));
		}
		if (e.field == 'subStdAmt') { /* 과세표준액 */
			this.set('subStdAmt', (this.get('subStdAmt')).toString()
					.replace(/,/g, '').replace('.00', ''));
			$('#txtListSubStdAmt').val(
					this.get('subStdAmt').toString().replace(
							/\B(?=(\d{3})+(?!\d))/g, ","));
		}
		/* 증빙일자 */
		if (this.get('authDate') != '') {
			var auth_date = this.get('authDate').toString().replace(/-/g, '');
			$('#txtListAuthDate').val(
					[ auth_date.substring(0, 4), auth_date.substring(4, 6),
							auth_date.substring(6, 8) ].join('-'));
		}
		/* 적요 */
		if (this.get('note') != '') {
			var note = this.get('note').toString();
			$('#txtListNote').val(note);
		}

		/* 확장입력1 */
		if (this.get('extendStr1') != '') {
			var extendStr1 = this.get('extendStr1').toString();
			$('#txtListExtendStr1').val(extendStr1);
		}
		/* 확장입력2 */
		if (this.get('extendStr2') != '') {
			var extendStr2 = this.get('extendStr2').toString();
			$('#txtListExtendStr2').val(extendStr2);
		}
	});

	/* 지출결의 - 표준적요 */
	var expendListSummary = new kendo.data.ObservableObject(ExCodeSummary);
	expendListSummary.bind("change", function(e) {
		if (e.field == 'summaryCode') { /* 표준적요 코드 화면 표현 */
			$('#txtListSummaryCode').val(this.get('summaryCode'));
		}
		if (e.field == 'drAcctName') { /* 차변 계정과목 화면 표현 */
			$('#txtListDrAcctName').val(this.get('drAcctName'));
		}
		if (e.field == 'summaryName') { /* 표준적요 명칭 화면 표현 */
			$('#txtListSummaryName').val(this.get('summaryName'));
		}
		if (this.get('summaryCode') != '' && this.get('drAcctName') != ''
				&& this.get('drAcctCode') != ''
				&& this.get('drAcctName') != ''
				&& this.get('crAcctCode') != ''
				&& this.get('crAcctName') != '') { /* 적요 기본문구 적용 */
			if ($('#txtListNote').val() == '') {
				//$('#txtListNote').val('[' + this.get('summary_code') + '] ' + this.get('dr_acct_name') + ' ( [' + this.get('dr_acct_code') + '] ' + this.get('dr_acct_name') + ' / [' + this.get('cr_acct_code') + '] ' + this.get('cr_acct_name') + ' )');
				//expendList.set('note', $('#txtListNote').val());
			}
		}
	});

	/* 지출결의 - 증빙유형 */
	var expendListAuth = new kendo.data.ObservableObject(ExCodeAuth);
	expendListAuth.bind("change", function(e) {
		/* 증빙유형 코드 화면 표현 */
		if (e.field == 'authCode') {
			$('#txtListAuthCode').val(this.get('authCode'));
		}
		/* 증빙유형 명칭 화면 표현 */
		if (e.field == 'authName') {
			$('#txtListAuthName').val(this.get('authName'));
		}
		/* 적요 필수입력 처리 */
		if (e.field == 'noteRequiredYN') {
			if (this.get('noteRequiredYN') == 'Y') {
				$('#expendListReqNote').show();
			} else {
				$('#expendListReqNote').hide();
			}
		}
		/* 증빙일자 필수입력 처리 */
		if (e.field == 'authRequiredYN') {
			if (this.get('authRequiredYN') == 'Y') {
				$('#expendListReqAuthDate').show();
			} else {
				$('#expendListReqAuthDate').hide();
			}
		}
		/* 프로젝트 필수입력 처리 */
		if (e.field == 'projectRequiredYN') {
			if (this.get('projectRequiredYN') == 'Y') {
				$('#expendListReqProject').show();
			} else {
				$('#expendListReqProject').hide();
			}
		}
		/* 거래처 필수입력 처리 */
		if (e.field == 'partnerRequiredYN') {
			if (this.get('partnerRequiredYN') == 'Y') {
				$('#expendListReqPartner').show();
			} else {
				$('#expendListReqPartner').hide();
			}
		}
		/* 카드 필수입력 처리 */
		if (e.field == 'cardRequiredYN') {
			if (this.get('cardRequiredYN') == 'Y') {
				$('#expendListReqCard').show();
			} else {
				$('#expendListReqCard').hide();
			}
		}
		return;
	});

	/* 지출결의 - 프로젝트 */
	var expendListProject = new kendo.data.ObservableObject(ExCodeProject);
	expendListProject.bind("change", function(e) {
		/* 프로젝트 코드 반영 */
		$('#txtListProjectCode').val(this.get('projectCode'));
		/* 프로젝트 명칭 반영 */
		$('#txtListProjectName').val(this.get('projectName'));
	});

	/* 지출결의 - 거래처 */
	var expendListPartner = new kendo.data.ObservableObject(ExCodePartner);
	expendListPartner.bind("change", function(e) {
		/* 프로젝트 코드 반영 */
		$('#txtListPartnerCode').val(this.get('partnerCode'));
		/* 프로젝트 명칭 반영 */
		$('#txtListPartnerName').val(this.get('partnerName'));
	});

	/* 지출결의 - 카드 */
	var expendListCard = new kendo.data.ObservableObject(ExCodeCard);
	expendListCard.bind("change",function(e) {
		$('#txtListCardName').val(this.get('cardName'));
		if (!isDisplayFullNumber) {
			$('#txtListCardCode').val(this.get('cardNum').replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/,"$1-****-****-$4"));
		} else {
			$('#txtListCardCode').val(this.get('cardNum'));
		}
	});

	/* 지출결의 - 예산 */
	var expendListBudget = new kendo.data.ObservableObject(ExCodeBudget);
	expendListBudget.bind("change", function(e) {
		$('#txtListBudgetCode').val(this.get('budgetCode'));
		$('#txtListBudgetName').val(this.get('budgetName'));
		$('#txtListBizplanCode').val(this.get('bizplanCode'));
		$('#txtListBizplanName').val(this.get('bizplanName'));
		$('#txtListBgAcctCode').val(this.get('bgacctCode'));
		$('#txtListBgAcctName').val(this.get('bgacctName'));

		var inputChk = '';
		var actSum = Math.floor(Number(this.get('budgetActsum') || '0'));
		var jSum = Math.floor(Number(this.get('budgetJsum') || '0'));

		if (this.get('budgetCode') == '') {
			inputChk += '["<%=BizboxAMessage.getMessage("TX000009523","예산단위 미입력")%>"]';
		}

		if (this.get('bizplanCode') == '') {
			inputChk += '["<%=BizboxAMessage.getMessage("TX000009522","사업계획 미입력")%>"]';
		}

		if (this.get('bgacctCode') == '') {
			inputChk += '["<%=BizboxAMessage.getMessage("TX000009521","예산계정 미입력")%>"]';
		}
	});

	var expendListPopAttribute = {
		"type" : "",
		"title" : "<%=BizboxAMessage.getMessage("TX000016475","코드도움")%>",
		"width" : "650",
		"height" : "689",
		"opener" : "3",
		"parentId" : "layerExpendList",
		"childerenId" : "layerCommonCode",
		"callback" : "",
		"compSeq" : (empInfo.compSeq || '0'),
		"formSeq" : (formInfo.formSeq || '0'),
		"searchStr" : "",
		"empInfo" : "#hidExpendListEmpInfo",
		"budgetIfno" : "#hidExpendListERPiUBudgetInfo"
	};

	/* 외화계정인지 체크 */
	var isForeignCurrency = false;
	/* 외화정보 담는 변수(항목정보 수정 시 사용) */
	var foreignCurrencyInfo = {}

	/* 문서로드 */
	$(document).ready(function() {
		$(window).resize(function() {
		    pop_position();
		  });
		/* 예산년월 맵핑 */
		expendListBudget.set('budgetYm', $('#txtExpendDate').val().toString().replace(/-/g, '').substring(0, 6));
		fnExpendListInit();
		fnExpendListEventInit();
		if ('${listVo.listSeq}' != ''
				&& '${listVo.listSeq}' != '0') {
// 			fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater(${ViewBag.list}) || '{}')),expendList);
// 			fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.summary}') || '{}')),expendListSummary);
// 			fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.auth}') || '{}')),expendListAuth);
// 			fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.project}') || '{}')),expendListProject);
// 			fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.partner}') || '{}')),expendListPartner);
// 			fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.card}') || '{}')),expendListCard);
// 			fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.budget}') || '{}')),expendListBudget);
// 			fnCopyToBOservalbe(JSON.parse((fnConvertSpecialCharater('${ViewBag.emp}') || '{}')),expendListUseEmp);
			<c:if test = "${ViewBag.list ne '' && ViewBag.list ne null}">
				fnCopyToBOservalbe(${ViewBag.list},expendList);
			</c:if>
			<c:if test = "${ViewBag.summary ne '' && ViewBag.summary ne null}">
				fnCopyToBOservalbe(${ViewBag.summary},expendListSummary);
			</c:if>
			<c:if test = "${ViewBag.auth ne '' && ViewBag.auth ne null}">
				fnCopyToBOservalbe(${ViewBag.auth},expendListAuth);
			</c:if>
			<c:if test = "${ViewBag.project ne '' && ViewBag.project ne null}">
				fnCopyToBOservalbe(${ViewBag.project},expendListProject);
			</c:if>
			<c:if test = "${ViewBag.partner ne '' && ViewBag.partner ne null}">
				fnCopyToBOservalbe(${ViewBag.partner},expendListPartner);
			</c:if>
			<c:if test = "${ViewBag.card ne '' && ViewBag.card ne null}">
				fnCopyToBOservalbe(${ViewBag.card},expendListCard);
			</c:if>
			<c:if test = "${ViewBag.budget ne '' && ViewBag.budget ne null}">
				fnCopyToBOservalbe(${ViewBag.budget},expendListBudget);
			</c:if>
			<c:if test = "${ViewBag.emp ne '' && ViewBag.emp ne null}">
				fnCopyToBOservalbe(${ViewBag.emp},expendListUseEmp);
			</c:if>

			feeSeq = expendList.feeSeq;

		 	/* 세금계산서일 경우 체크 취소 */
		  	/*if (expendList.interfaceType == 'etax'){
				$('#chkAutoCalculation').prop("checked", false);
				$('.k-checkbox-label').hide();
		  	}*/

		  	/* 자동계산체크 여부 표현 */
		  	if (expendList.autoCalcYn != 'Y') {
				$('#chkAutoCalculation').prop("checked", false);
		  	}

			//expendListAttach = JSON.parse("${ViewBag.attach}" || "[]");
			/* hidden에 조회값 저장 */
			$("#hidExpendListSummaryInfo").val(JSON.stringify(expendListSummary)); // 표준적요
			$("#hidExpendListAuthInfo").val(JSON.stringify(expendListAuth)); // 증빙유형
			$("#hidExpendListProjectInfo").val(JSON.stringify(expendListProject)); // 프로젝트
			$("#hidExpendListPartnerInfo").val(JSON.stringify(expendListPartner)); // 거래처
			$("#hidExpendListCardInfo").val(JSON.stringify(expendListCard)); // 카드
			$("#hidExpendListERPiUBudgetInfo").val(JSON.stringify(expendListBudget)); // 예산정보(예산단위)

			var expendListBizplan = {}
			expendListBizplan.bizplanCode = expendListBudget.bizplanCode;
			expendListBizplan.bizplanName = expendListBudget.bizplanName;
			$("#hidExpendListBizplanInfo").val(JSON.stringify(expendListBizplan)); // 사업계획

			var expendListBgAcct = {}
			expendListBgAcct.bgacctCode = expendListBudget.bgacctCode;
			expendListBgAcct.bgacctName = expendListBudget.bgacctName;
			expendListBgAcct.cdBgLevel = expendListBudget.cdBgLevel;
			expendListBgAcct.ynControl = expendListBudget.ynControl;
			expendListBgAcct.tpControl = expendListBudget.tpControl;
			
			$("#hidExpendListBgAcctInfo").val(JSON.stringify(expendListBgAcct)); // 예산계정

			foreignCurrencyInfo.exchangeUnitCode = expendList.exchangeUnitCode;
			foreignCurrencyInfo.exchangeUnitName = expendList.exchangeUnitName;
			foreignCurrencyInfo.exchangeRate = expendList.exchangeRate;
			foreignCurrencyInfo.foreignCurrencyAmount = expendList.foreignCurrencyAmount;
			foreignCurrencyInfo.foreignAcctYN = expendList.foreignAcctYN;

			if(expendList.foreignAcctYN == "Y"){ // 외화계정인 경우
				isForeignCurrency = true;
			}
			$("#hidExpendListForeignCurrencyInfo").val(JSON.stringify(foreignCurrencyInfo)); // 외화정보

			fnSetRequired("expendList", expendListAuth); /* 필수값 처리 */
			fnSetFocusPrimary(expendListAuth);
			/* 결재 진행중 수정 */

			/*  || ('${listVo.listSeq}' != '' && '${listVo.listSeq}' != '0') ?? 포함여부 확인 필요, 포함하는 경우 예산단위, 사업계획, 예산계정 변경시 처리 프로세스 구현 필요 */
			if( expend.get("expendStatCode") != ""){
				basicListAmt = expendList.stdAmt;
			}
		}else{
			$("#hidExpendListSummaryInfo").val(""); // 표준적요
			$("#hidExpendListAuthInfo").val(""); // 증빙유형
			$("#hidExpendListProjectInfo").val(""); // 프로젝트
			$("#hidExpendListPartnerInfo").val(""); // 거래처
			$("#hidExpendListCardInfo").val(""); // 카드
			$("#hidExpendListERPiUBudgetInfo").val(""); // 예산정보(예산단위)
			$("#hidExpendListBizplanInfo").val(""); // 사업계획
			$("#hidExpendListBgAcctInfo").val(""); // 예산계정
			$("#hidExpendListForeignCurrencyInfo").val(""); // 외화정보
			<c:if test = "${ViewBag.emp ne ''}">
				fnCopyToBOservalbe(${ViewBag.emp},expendListUseEmp);
			</c:if>
// 			fnCopyToBOservalbe(fnConvertSpecialCharater('${ViewBag.emp}'), expendListUseEmp);
			expendListUseEmp.set('seq', 0);
		}
		fnExpendListInfoBind();
		fnSetNote();
		$('#txtListSummaryName').focus();
		fnSetExOption(option, 'list');

		/* 항목 기본 정보 바인딩 */
      	fnDataSet();

		/* 첨부파일 바인딩*/
		fnLoadFileList(JSON.parse('${ViewBag.attach}' || '[]')); /* 첨부파일 바인딩*/
		/* 기존 첨부파일 정보 바인딩 */
		$("#hidExpendListAttachInfo").val( '${ViewBag.expendAttachList}' );
// 		$("#hidExpendListAttachInfo").val('');

		/* 2019.02.11.김상겸.현금영수증 승인번호 연동 점검 */
		if(ifSystem === 'iCUBE'){
			if((expendList.interfaceType || '') == '' && (expendListAuth.vatTypeCode || '') == '28') {
				$(".ExpendListReqNoCash").show();
				$("#txtListNoCash").val((expendListAuth.noCash || ''));
			} else {
				$(".ExpendListReqNoCash").hide();
				$("#txtListNoCash").val('');
			}
		}

		/*팝업 위치설정
		* 항목들이 많아지면 Layout 크기가 이미 정해진 상태에서 화면이 넘어가게 되면서
		* 스크롤이 안생기는 문제가 발생하여, 초기 레이아웃 설정 후에 포지션 지정한다.
		*/
		pop_position();

		fnSetListEmpDeptOptionSet();

		if(['fashion', 'dragons_test'].indexOf('${ViewBag.empInfo.groupSeq}') > -1) {
			$('tr.trListExtStr').show()
		} else {
			$('tr.trListExtStr').hide()
		}

		// 신규일 경우 금액 자동계산 옵션 값 확인
		if ('${listVo.listSeq}' == '' || '${listVo.listSeq}' == '0') {
			$.each(op_list.func_code, function(idx,tOption) {
				if(tOption.code == '003108') {
					if(tOption.value == 'N') {
						$('#chkAutoCalculation').prop("checked", false);
					}
				}
			});
		}

		return;
	});

    function fnSetListEmpDeptOptionSet() {
    	if(expendEmpChange) {
			$('#txtListEmpName').removeAttr('disabled');
			$('#btnListEmpSearch').show();
    	} else {
			$('#txtListEmpName').attr('disabled', 'disabled');
			$('#btnListEmpSearch').hide();
    	}

    	if(expendDeptChange) {
			$('#txtListDeptName').removeAttr('disabled');
			$('#btnListDeptSearch').show();
    	} else {
			$('#txtListDeptName').attr('disabled', 'disabled');
			$('#btnListDeptSearch').hide();
    	}

    	if(expendEmpDeptLink) {
			$('#txtListDeptName').attr('disabled', 'disabled');
			$('#btnListDeptSearch').hide();
    	}

    	return;
    }

    /* 계속작성 이벤트 구현 */
    function fnSetContinusSaveEvent(){
    	$('#btnListContinusSave').click(function(){
    		fnExpendListInfoInsert({'continusAction' : true}); /* 이어서 저장 */
    	});
    }

	function fnExpendListInfoBind(){
		if ('${listVo.listSeq}' != '' && '${listVo.listSeq}' != '0') {
			if(ifSystem === 'iCUBE'){
				/* 금액 필수값 표시 여부 설정 */
				switch (expendListAuth.vatTypeCode) {
					case '24':
						/* 부가세액 필수 X, 과세표준액, 세액 필수 */
						$("#expendListSubTaxAmt, #expendListSubStdAmt").show();
						$("#expendListReqTaxAmt").hide();
						break;
					case '22':
					case '23':
					case '41':
						/* 부가세액, 세액 필수 X, 과세표준액 필수 */
						$("#expendListSubStdAmt").show();
						$("#expendListReqTaxAmt, #expendListSubTaxAmt").hide();
						break;
					case '21':
					case '25':
					case '26':
					case '27':
					case '28':
					case '29': 
						/* 전부 다 필수 필수 */
						$("#expendListReqTaxAmt, #expendListSubTaxAmt, #expendListSubStdAmt").show();
						break;
					default:
						/* 전부 다 필수 필수 X*/
						$("#expendListReqTaxAmt, #expendListSubTaxAmt, #expendListSubStdAmt").hide();

						break;
				}

				/*
					23 : 면세매입
					24 : 매입불공제
					26 : 의제매입세액등
					위의 경우 사유구분을 입력하게 한다.
				*/
				switch (expendListAuth.vatTypeCode) {
					case '23':
					case '24':
					case '26':
						//부가세 구분
						type = 'vat';
						target = $('#txtListVatTypeCode, #txtListVatTypeName');
						fnSetExpendDispValue(target, expendListAuth, type);
						//사유 구분
						type = 'va'
						target = $('#txtListVatReasonCode, #txtListVatReasonName');
						fnSetExpendDispValue(target, expendListAuth, type);
						$('.ExpendVatReason').show();
						break;
					default:
						type = 'vat';
						target = $('#txtListVatTypeCode, #txtListVatTypeName');
						fnSetExpendDispValue(target, expendListAuth, type);
						$('.ExpendVatReason').hide();
						break;
				}

				/* 전자세금계산서 발행 여부 선택 표시 */
				switch (expendListAuth.vatTypeCode) {
				/*
					21 : 과세매입
					22 : 영세매입
					23 : 면세매입
					24 : 불공(세금계산서)
					25 : 수입
					위의 경우 전자세금계산서 발행여부 항목을 표시해준다
				*/
					case '21':
					case '22':
					case '23':
					case '24':
					case '25':
						$('.ExpendListTax').show();
						$("#divEtaxSendYN").hide();
						/* 전자세금계산서여부 체크 */
						if(expendListAuth.etaxYN == 'Y'){
							$("#etaxYN").prop("checked", true);
						}else{
							$("#etaxYN").prop("checked", false);
						}
						break;
					default:
						$('.ExpendListTax').hide();
						break;
				}

				/* iCUBE 승인번호 입력  - 2019. 02. 11. 김상겸 추가*/
				/* 28 : 현금영수증매입일 경우 팝업 오픈 카드내역/세금계산서내역 인 경우는 안뜸 */
				if(expendList.interfaceType == '' && expendListAuth.vatTypeCode == "28"){
					$(".ExpendListReqNoCash").show();
					$("#txtListNoCash").val(expendListAuth.noCash);
				}else{
					$(".ExpendListReqNoCash").hide();
					$("#txtListNoCash").val('');
				}
			}else if(ifSystem === 'ERPiU'){
				/* 금액 필수값 표시 여부 설정 */
				switch (expendListAuth.vatTypeCode) {
					case '22':
					case '50':
						/* 부가세액 필수 X, 과세표준액, 세액 필수 */
						$("#expendListSubTaxAmt, #expendListSubStdAmt").show();
						$("#expendListReqTaxAmt").hide();
						break;
					case '23':
					case '25':
					case '26':
					case '37':
					case '39':
					case '99':
						/* 부가세액, 세액 필수 X, 과세표준액 필수 */
						$("#expendListSubStdAmt").show();
						$("#expendListReqTaxAmt, #expendListSubTaxAmt").hide();
						break;
					case '21':
					case '24':
					case '31':
					case '38':
					case '43':
						/* 전부 다 필수 필수 */
						$("#expendListReqTaxAmt, #expendListSubTaxAmt, #expendListSubStdAmt").show();
						break;
					default:
						/* 전부 다 필수 필수 X */
						$("#expendListReqTaxAmt, #expendListSubTaxAmt, #expendListSubStdAmt").hide();
						break;
				}

				switch (expendListAuth.vatTypeCode) {
				/*
					22 : 불공(세금계산서)
					50 : 불공(신용카드)
					위의 경우 불공제 구분 값을 입력하게 한다.
				*/
					case '22':
					case '50':
						//부가세 구분
						type = 'vat';
						target = $('#txtListVatTypeCode, #txtListVatTypeName');
						fnSetExpendDispValue(target, expendListAuth, type);
						//불공제 구분
						type = 'notax'
						target = $('#txtListNoTaxCode, #txtListNoTaxName');
						fnSetExpendDispValue(target, expendListAuth, type);
						$('.ExpendListNoTax').show();
						break;
					default:
						type = 'vat';
						target = $('#txtListVatTypeCode, #txtListVatTypeName');
						fnSetExpendDispValue(target, expendListAuth, type);
						$('.ExpendListNoTax').hide();
						break;
				}

				/*
					21 : 과세(세금계산서)
					22 : 불공(세금계산서)
					23 : 영세(세금계산서)
					26 : 면세(계산서)
					27 : 의제(계산서 2/102)
					29 : 의제(계산서 3/103)
					32 : 의제(계산서 5/105)
					38 : 수입(세금계산서)
					40 : 의제(계산서 6/106)
					43 : 매입자발행세금계산서
					44 : 재활용(계산서 6/106)
					46 : 재활용(계산서 10/110)
					48 : 의제(계산서 8/108)
					51 : 의제(계산서 4/104)
					54 : 재활용(계산서 9/109)
					65 : 재활용(계산서 3/103)
					위의 경우 전자세금계산서 여부 및 11일 전송 여부를 표시한다.
				*/
				switch (expendListAuth.vatTypeCode) {
					case '21':
					case '22':
					case '23':
					case '26':
					case '27':
					case '29':
					case '32':
					case '38':
					case '40':
					case '43':
					case '44':
					case '46':
					case '48':
					case '51':
					case '54':
					case '65':
						$('.ExpendListTax').show();
						/* 전자세금계산서여부 체크 */
						if(expendListAuth.etaxYN == 'Y'){
							$("#etaxYN").prop("checked", true);
						}else{
							$("#etaxYN").prop("checked", false);
						}
						/* 전자세금11일내전송여부 체크 */
						if(expendListAuth.etaxSendYN == 'Y' ){
							$("#etaxSendYN").prop("checked", true);
						}else{
							$("#etaxSendYN").prop("checked", false);
						}
						break;
					default:
						$('.ExpendListTax').hide();
						break;
				}

				type = 'budget';
				target = $('#txtListBudgetCode, #txtListBudgetName');
				fnSetExpendDispValue(target, expendListBudget, type);

				type = 'bizplan';
				target = $('#txtListBizplanCode, #txtListBizplanName');
				fnSetExpendDispValue(target, expendListBudget, type);

				type = 'bgacct';
				target = $('#txtListBgAcctCode, #txtListBgAcctName');
				fnSetExpendDispValue(target, expendListBudget, type);

				if( '${ViewBag.isReceptYN}' == 'Y' && ('${ViewBag.empInfo.groupSeq}' == 'visang' || '${ViewBag.empInfo.groupSeq}' == 'demo' || '${ViewBag.empInfo.groupSeq}' == 'portal')){
					$("#btnListReceptSearch").parent().show();
				}else{
					$("#btnListReceptSearch").parent().hide();
				}

				/* ERPiU 승인번호 입력  - 2018. 05. 02. 신재호 추가*/
				/* 31 : 현금영수증 37 : 현금영수증(면세) 일 경우 팝업 오픈 카드내역/세금계산서내역 인 경우는 안뜸 */
				if(expendList.interfaceType == '' && (expendListAuth.vatTypeCode == "31" || expendListAuth.vatTypeCode =="37")){
					$(".ExpendListReqNoCash").show();
					$("#txtListNoCash").val(expendListAuth.noCash);
				}else{
					$(".ExpendListReqNoCash").hide();
					$("#txtListNoCash").val('');
				}
			}

			if(expendListAuth.vatTypeCode === ''){
				$('#expendListReqVatType').hide();
			}

			/* 카드사용내역인 경우 카드번호는 무조건 변경 불가, 거래처는 거래처 코드가 없는 경우에만 변경 가능 */
			if (expendList.interfaceType == 'card'){
				$('#txtListCardCode, #txtListCardName').attr('disabled', 'disabled');
				$('#btnListCardSearch').hide();
				/* 카드사용내역인 경우 전자세금계산서 여부가 표시되지 않는다.*/
				$('.ExpendListTax').hide();
			}
			/* 매입전자세금계산서인 경우 거래처는 거래처 코드가 없는 경우에만 변경 가능 */
	    	if (expendList.interfaceType == 'etax'){
				if(expendListPartner.partnerCode != ''){
					$('#txtListPartnerCode, #txtListPartnerName').attr('disabled', 'disabled');
					$('#btnListPartnerSearch').hide();
				}
			}


		}
		type = 'emp';
		target = $('#hidExpendListEmpInfo, #txtListEmpCode, #txtListEmpName, #txtListDeptCode, #txtListDeptName , #txtListCcCode, #txtListCcName');
		fnSetExpendDispValue(target, expendListUseEmp, type); /* 데이터 바인딩 */


	}

	/* 초기화 */
	function fnExpendListInit() {
		$('#txtListStdAmt, #txtListSubStdAmt, #txtListTaxAmt, #txtListSubTaxAmt, #txtListAmt').maskMoney({
			precision : 0,
			allowNegative: isNegativeAmt
		});
// 		$('#txtListStdAmt, #txtListSubStdAmt, #txtListTaxAmt, #txtListSubTaxAmt, #txtListAmt').change(function() {
		$('#txtListStdAmt, #txtListSubStdAmt, #txtListTaxAmt, #txtListSubTaxAmt, #txtListAmt').keyup(function() {
			if($("#chkAutoCalculation").is(":checked")){
				fnSetAmt((this.id).toString().replace('txtList', ''));
			}
			expendList.set('stdAmt', ($('#txtListStdAmt').val()).toString().replace(/,/g, ''));
			expendList.set('taxAmt', ($('#txtListTaxAmt').val()).toString().replace(/,/g, ''));
			expendList.set('amt', ($('#txtListAmt').val()).toString().replace(/,/g, ''));
			expendList.set('subStdAmt',($('#txtListSubStdAmt').val()).toString().replace(/,/g, ''));
			expendList.set('subTaxAmt',($('#txtListSubTaxAmt').val()).toString().replace(/,/g, ''));
		});
		fnExpendListInitLayout();
		fnExpendListInitDatepicker();
		fnExpendListInitInput();
		return;
	}

	/* 초기화 - layout */
	function fnExpendListInitLayout() {
		$('.ExpendListBizboxA, .ExpendListiCUBE, .ExpendListERPiU, .ExpendListBudget').hide();
		$('#expendListReqNote, #expendListReqAuthDate, #expendListReqProject, #expendListReqProject, #expendListReqPartner, #expendListReqCard, #expendListReqBudget, #expendListReqBizplan, #expendListReqBgAcct')
				.hide();
		/* 개발범위 제한으로, [표준적요, 적요, 증빙유형, 증빙일자, 프로젝트, 거래처, 카드, 금액] 만 노출 */
		$('.ExpendList' + '${ViewBag.ifSystem}' + '.ExpendListProject').show();
		$('.ExpendList' + '${ViewBag.ifSystem}' + '.ExpendListPartner').show();
		$('.ExpendList' + '${ViewBag.ifSystem}' + '.ExpendListCard').show();
		$('.ExpendVatType').hide();

		// 신재호 수정
		$('.ExpendListTax').hide();
		return;
	}

	/* 초기화 - datepicker */
	function fnExpendListInitDatepicker() {
		$("#txtListAuthDate").kendoDatePicker({
					culture : "ko-KR",
					format : "yyyy-MM-dd",
					change : function() {
						/* 날짜 형식 체크 (예를들어 4월 30일 까지 밖에 없는데 4월 31일 입력한 경우)
						   예산 사용인 경우 항목이 한 개 이상 존재하면서 년도와 월이 다른 경우는 변경 안됨.
						   예산 미사용인 경우 날짜 형식만 맞으면 상관없음.
						*/
						var authDate = (this._oldText).toString().replace(/-/g, '');
						var year = Number(authDate.substr(0,4));
						var month = Number(authDate.substr(4,2));
						var day = Number(authDate.substr(6,2));
						var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
						var maxDay = maxDaysInMonth[month-1];
						// 윤년 체크
						if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
							maxDay = 29;
						}
						if( day<=0 || day>maxDay || month <= 0 || month > 12){
							var tAuthDate = expendList.authDate;
					        if(tAuthDate.length == 8 ){
					        	tAuthDate = tAuthDate.substr(0,4) + '-' + tAuthDate.substr(4,2) + '-' + tAuthDate.substr(6,2);
					        }
							$('#txtListAuthDate').val(tAuthDate);
						}else{
							/* 증빙일자 마감일 확인 진행 */
							var isClosed = false;
							for( var i = 0 ; i < authDateList.length ; i++){
								var tDate = authDateList[i];
								// 마감 시작일과 종료일 사이에 선택한 회계일자가 있는 경우 입력 제한한다.
								if( tDate.closeFromDate <= authDate && authDate <= tDate.closeToDate ){
									isClosed = true;
									break;
								}
							}

							/* 날짜가 정상인 경우 입력한 회계일자로 설정 */
							if( !isClosed ){
								if(authDate.length == 8){
									focus_fnMoveFocus('txtListAuthDate', true);
								}
								expendList.set('authDate', authDate);
							}else{
								alert("등록된 증빙일자가 지출결의 작성 마감 기간에 포함되어 있어 선택이 제한됩니다.");
								var tAuthDate = expendList.authDate;
				    	        if(tAuthDate.length == 8 ){
				    	        	tAuthDate = tAuthDate.substr(0,4) + '-' + tAuthDate.substr(4,2) + '-' + tAuthDate.substr(6,2);
				    	        }
				    			$('#txtListAuthDate').val(tAuthDate);
							}
				 		}

					}
				});
		var datePicker = $("#txtListAuthDate");
		datePicker.kendoMaskedTextBox({
			mask : '0000-00-00'
		});
		datePicker.closest(".k-datepicker").add(datePicker).removeClass(
				'k-textbox');
	}

	/* 초기화 - input */
	function fnExpendListInitInput() {
		/* 사용자 */
		$('#hidExpendListEmpInfo').setJson(expendListUseEmp.toJSON());
		/* 적요 */
		$('#txtListNote').change(function() {
			expendList.set('note', $(this).val());
		});
		/* 공급가액 */
		$('#txtListStdAmt').change(function() {
			expendList.set('stdAmt', $(this).val().toString().replace(
					/,/g, ''));
			$("#amt").val($(this).val().toString().replace(/,/g, ''));
		});
		/* 부가세 */
		$('#txtListTaxAmt').change(function() {
			expendList.set('taxAmt', $(this).val().toString().replace(
					/,/g, ''));
		});
		/* 공급대가 */
		$('#txtListAmt').change(function() {
			expendList.set('amt', $(this).val().toString().replace(/,/g, ''));
		});
		/* 과세표준액 */
		$('#txtListSubStdAmt').change(function() {
			expendList.set('subStdAmt', $(this).val().toString()
					.replace(/,/g, ''));
		});
		/* 세액 */
		$('#txtListSubTaxAmt').change(function() {
			expendList.set('subTaxAmt', $(this).val().toString()
					.replace(/,/g, ''));
		});

		$('#txtListNoCash').keyup(function() {
			if($(this).val().length < 9){
				$(this).val($(this).val().replace(/[^0-9a-zA-Z]/g,""));
			}else{
				$(this).val($(this).val().toString().substring(0,9));
			}
		});
	}

	/* 이벤트 초기화 */
	function fnExpendListEventInit() {
		fnExpendListEventInitInput();
		fnExpendListEventInitButton();
		fnExpendListEventInitKey();
		fnExpendListEventInitFocus();
		fnBindFocusEvent();
		fnExpendListEventInitCheckBox();
		return;
	}

    /* 인풋 포커스 이벤트 바인드 */
    function fnBindFocusEvent(){
    	var datas = [{
	 		id : 'txtListSummaryName'
			, isPrimary : true
			, type : 'code'
			, keyId : 'txtListSummaryCode'
			, code : 'Summary'
   		}, {
   			id : 'txtListAuthName'
			, isPrimary : true
			, type : 'code'
			, keyId : 'txtListAuthCode'
			, code : 'Auth'
    	}, {
    		id : 'txtListNoCash'
    		, type : 'text'
   			, isPrimary : false
    	}, {
    	}, {
    		id : 'txtListNote'
    		, type : 'text'
   			, isPrimary : false
    	}, {
    		id : 'txtListVatReasonName'
    			, isPrimary : true
    			, type : 'code'
    			, keyId : 'txtListVatReasonCode'
    			, code : 'Va'
       	}, {
       		id : 'txtListNoTaxName'
    			, isPrimary : true
    			, type : 'code'
    			, keyId : 'txtListNoTaxCode'
    			, code : 'NoTax'
       	},{
    		id : 'txtListAuthDate'
    		, type : 'date'
   			, isPrimary : false
    	}, {
    		id : 'txtListProjectName'
    		, type : 'code'
    		, isPrimary : false
    		, keyId : 'txtListProjectCode'
       		, code : 'Project'
    	}, {
    		id : 'txtListCardName'
    		, type : 'code'
    		, keyId : 'txtListCardCode'
    		, code : 'Card'
    	}, {
    		id : 'txtListPartnerName'
    		, type : 'code'
    		, keyId : 'txtListPartnerCode'
    		, code : 'Partner'
    	}, {
    		id : 'txtListBudgetName'
    		, type : 'code'
    		, keyId : 'txtListBudgetCode'
    		, code : 'Budget'
    		, isPrimary : true
    	}, {
    		id : 'txtListBizplanName'
        		, type : 'code'
        		, keyId : 'txtListBizplanCode'
        		, code : 'Bizplan'
        		, isPrimary : true
        	}, {
    		id : 'txtListBgAcctName'
    		, type : 'code'
    		, keyId : 'txtListBgAcctCode'
    		, code : 'BgAcct'
    		, isPrimary : true
    	}, {
    		id : 'txtListAmt'
    		, type : 'text'
    	}];
    	focus_fnSetFocusAction(datas);
    }

	/* 이벤트 초기화 - 텍스트 */
	function fnExpendListEventInitInput() {

		/* [닫기] 항목 추가 팝업 esc 키 이벤트 */
		$(document).keydown(function(event){
			if(event.which == 27) {
				$('#btnListClose').click();
			}
		});

		/* keypress 이벤트 - 증빙일자 */
        $('#txtListAuthDate').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.keyCode == 13 || event.keyCode == 113) {
                if ($(this).val() == '____-__-__' || $(this).val() == '') {
                	$('#txtListAuthDate').next('.k-select').click();
                } else {
                	isFirstChange = true;
                	$('#txtListAuthDate').data("kendoDatePicker").trigger("change");
                	focus_fnMoveFocus('txtListAuthDate', false);
                }
            }
            return;
        }); /* 증빙일자 */

		/* keypress 이벤트 - 공급대가 */
		$('#txtListAmt').txtEnter(function() {
			/* 사용자 일반 입력 엔터키 입력의 경우 이벤트 */
			if( focusObj.getStartId() != 'txtListAmt'){
				return;
			}
			$('#txtListStdAmt').focus();
			$('#txtListAmt').focus();
			var confirmMsg = '';
			confirmMsg += "\r\n[${CL.orgn_ex_amountSupply}] : " + $('#txtListAmt').val();
			confirmMsg += "\r\n[${CL.orgn_ex_additionalTaxAmount}] : " + $('#txtListTaxAmt').val();
			confirmMsg += "\r\n[${CL.orgn_ex_purPrice}] : " + $('#txtListStdAmt').val();
			confirmMsg += '\r\n';
			confirmMsg += '\r\n"<%=BizboxAMessage.getMessage("TX000012190","저장하시겠습니까")%>"?';

			if (confirm(confirmMsg)) {
				$('#btnListSave').click();
			}
		}, '', function() {
			/* 사용자 shift입력의 경우 이벤트 */
			$('#txtListStdAmt').focus();
			$('#txtListAmt').focus();
			var confirmMsg = '';
			confirmMsg += "\r\n[${CL.orgn_ex_amountSupply}] : " + $('#txtListAmt').val();
			confirmMsg += "\r\n[${CL.orgn_ex_additionalTaxAmount}] : " + $('#txtListTaxAmt').val();
			confirmMsg += "\r\n[${CL.orgn_ex_purPrice}] : " + $('#txtListStdAmt').val();
			confirmMsg += '\r\n';
			confirmMsg += '\r\n"<%=BizboxAMessage.getMessage("TX000012190","저장하시겠습니까")%>"?';

			if (confirm(confirmMsg)) {
				fnExpendListInfoInsert({'continusAction' : true});
			}
		});

		/* 접대비 등록 팝업 오픈 */
        // $('#txtListReceptName').keydown(function(event){
        //     if (event.keyCode == 13 || event.keyCode == 113) {
        //     	fnOpenEntertainmentFeePop( );
        //     }
        // });

		// 외화입력 팝업 오픈
		$("#txtListAmt, #txtListTaxAmt, #txtListStdAmt, #txtListSubTaxAmt, #txtListSubStdAmt").click(function(){
			// 외화계정일 경우
			if(isForeignCurrency){
				// 금액 자동 계산일 경우 공급대가, 부가세액, 세액, 공급가액, 과세표준액 클릭 시 외화입력 팝업 오픈
				if($("#chkAutoCalculation").is(":checked")){
			 		fnExForeignCurrencyInputPopup();
				}
				// 금액 자동 계산 체크 해제 시 공급대가 클릭 시 외화입력 팝업 띄움
				else {
					// 공급대가 클릭 시 외화입력 팝업 오픈
					if($(this).attr('id') == "txtListAmt"){
						fnExForeignCurrencyInputPopup();
					}
				}
		 	}
		});

		$("#txtListNote").keyup(function(e){
			var NoteContent = $(this).val();
			if(NoteContent.length >= 100){
				alert('글자수 제한(100byte)을 초과하였습니다.');
				return  $(this).val(NoteContent.substring(0, 100));
			}
		})


	}
	/* 이벤트 초기화 - 버튼 */
	function fnExpendListEventInitButton() {
		/* 버튼 클릭 이벤트 */
		/* 예산체크 버튼 이벤트 */
		fnExpendiCUBEBudgetChk();
		fnExpendERPiUBudgetChk();
		/* ======================= 옵션 값에 따라 화면에 나타날 수 있는 항목집합 ======================= */
		$("#btnListEmpSearch, #btnListDeptSearch, #btnListPcSearch, #btnListCcSearch").click(function() {
			var btnType = $(this).attr('id').replace('btnList','').replace('Search','');

			if(btnType == 'Emp' && !expendEmpChange) {
				alert('사용자를 변경할 수 없습니다.');
	    		return;
			}
			if(btnType == 'Dept' && !expendDeptChange) {
				alert('사용부서를 변경할 수 없습니다.');
	    		return;
			}

			fnOpenCommonCodePop('N', btnType);
		});
		/* ======================= 옵션 값에 따라 화면에 나타날 수 있는 항목집합 ======================= */

		/* 버튼 클릭 이벤트 - 표준적요, 증빙유형, 프로젝트, 카드, 거래처, 예산단위, 사업계획, 예산계정 */
		$("#btnListSummarySearch, #btnListAuthSearch, #btnListProjectSearch, #btnListCardSearch, #btnListPartnerSearch"
				+ ", #btnListBudgetSearch, #btnListBizplanSearch, #btnListBgAcctSearch, #btnListVatSearch, #btnListVaSearch, #btnListNoTaxSearch").click(function() {
			var btnType = $(this).attr('id').replace('btnList','').replace('Search','');
			if(btnType === 'Vat'){
				btnType = 'VatType';
			}
			if(btnType === 'NoTax'){
				btnType = 'Notax';
			}
			fnOpenCommonCodePop('N', btnType);
		});

		/* 버튼 클릭 이벤트 - 저장 */
		$('#btnListSave').btnClick('fnExpendListInfoInsert');

		/* 버튼 클릭 이벤트 - 취소 */
		$('#btnListClose').btnClick('fnExCloseLayPop');

		/* 접대비 등록 팝업 오픈 */
		$("#btnListReceptSearch").on("click",function(){
			fnOpenEntertainmentFeePop( );
		});

		return;
	}

	function fnExpendListEventInitKey(){

		/* ======================= 옵션 값에 따라 화면에 나타날 수 있는 항목집합 ======================= */
		$("#txtListEmpName, #txtListCcName").keydown(function(event){
			if(event.which == '113'){
				var txtType = $(this).attr('id').replace('txtList','').replace('Name','');
				fnOpenCommonCodePop('Y', txtType);
			}else if( (event.keyCode == 8) || ( ( event.keyCode != 13 ) && (event.keyCode > 45 ) ) ){
            	/* 뷰모델 정보 변경 감지 */
            	var id = $(this).attr('id');

            	id = id.replace('Name', 'Code');
            	$('#' + id).val('');
            }
		});
		/* ======================= 옵션 값에 따라 화면에 나타날 수 있는 항목집합 ======================= */
		/* 엔터 이벤트 - 표준적요, 증빙유형, 프로젝트, 카드, 거래처, 예산단위, 사업계획, 예산계정 */
		$("#txtListSummaryName, #txtListAuthName, #txtListProjectName, #txtListCardName, #txtListPartnerName"
				+ ", #txtListBudgetName, #txtListBizplanName, #txtListBgAcctName, #txtListNoTaxName, #txtListVatReasonName, #txtListNoTaxName").keydown(function(event){
			if(event.which == '113'){
				var txtType = $(this).attr('id').replace('txtList','').replace('Name','');
				if(txtType === 'NoTax'){
					txtType = 'Notax';
				}
				fnOpenCommonCodePop('Y', txtType);
			}else if(  (event.keyCode == 8) || ( ( event.keyCode != 13 ) && (event.keyCode > 45 ) ) ){
            	/* 뷰모델 정보 변경 감지 */
            	var id = $(this).attr('id');
            	if(id == 'txtListSummaryName'){
            		$('#txtListDrAcctName').val('');

            		isForeignCurrency = false;
            		// maskMoney 다시 활성화
            		$('#txtListStdAmt, #txtListSubStdAmt, #txtListTaxAmt, #txtListSubTaxAmt, #txtListAmt').maskMoney({
            			precision : 0,
            			allowNegative: isNegativeAmt
            		});
            	}
            	/* ERPiU 00 거래처인 경우 거래처 명만 변경되야함. 2018. 03. 29 - 신재호 수정 */
            	if(!(ifSystem == 'ERPiU' && id == 'txtListPartnerName' && $("#txtListPartnerCode").val() == '00')){
            		id = id.replace('Name', 'Code');
                	$('#' + id).val('');
            	}
            }
		});
	}

	function fnExpendListEventInitFocus(){
		$("#txtListSummaryName, #txtListAuthName, #txtListProjectName, #txtListCardName, #txtListPartnerName"
				+ ", #txtListBudgetName, #txtListBizplanName, #txtListBgAcctName, #txtListNoTaxName, #txtListVatReasonName, #txtListNoTaxName").focusout(function(event){
			var txtType = $(this).attr('id').replace('txtList','').replace('Name','').toLowerCase();
			fnIsDeleteItem(txtType);
		});
	}

	/* 이벤트 초기화 - 체크박스 */
	function fnExpendListEventInitCheckBox() {
		// 금액 자동 계산 클릭 시
		$("#chkAutoCalculation").click(function() {
			// 외화계정일 경우
			if(isForeignCurrency){
				// 금액 자동 계산 체크 시 공급대가, 부가세액, 세액, 공급가액, 과세표준액 readOnly 적용
				if($(this).is(":checked")){
					$("#txtListAmt, #txtListTaxAmt, #txtListStdAmt, #txtListSubTaxAmt, #txtListSubStdAmt").prop('readonly', true);
				}
				// 금액 자동 계산 체크 해제 시 공급대가만 readOnly 적용
				else{
					$("#txtListAmt").prop('readonly', true);
					$("#txtListTaxAmt, #txtListStdAmt, #txtListSubTaxAmt, #txtListSubStdAmt").prop('readonly', false);
				}
			}
			// 외화계정일 아닐 경우 readOnly 해제
			else{
				$("#txtListAmt, #txtListTaxAmt, #txtListStdAmt, #txtListSubTaxAmt, #txtListSubStdAmt").prop('readonly', false);
			}
		});
	}

	/* 항목 추가 시 기본 데이터 매핑 및 옵션 설정 후 추가 작업 진행 */
    function fnDataSet(){
      	/* 프로젝트 문서단위 입력인 경우 문서에 있는 프로젝트 정보를 기본값으로 설정 */
      	if( expendProject.projectCode && expendProject.projectCode != '' && expendProject.projectCode != '0'
      			&& $(".ExpendProject").css("display") != 'none'){
      		expendListProject = expendProject;
      		$('#txtListProjectCode').val(expendListProject.projectCode);
      		$('#txtListProjectName').val(expendListProject.projectName);
      	}
      	/* 거래처 문서단위 입력인 경우 문서에 있는 거래처 정보를 기본값으로 설정 */
      	if( expendPartner.partnerCode && expendPartner.partnerCode != '' && expendPartner.partnerCode != '0'
      		&& $(".ExpendPartner").css("display") != 'none'){
      		expendListPartner = expendPartner;
      		$('#txtListPartnerCode').val(expendPartner.partnerCode);
      		$('#txtListPartnerName').val(expendPartner.partnerName);
      	}
      	/* 카드 문서단위 입력인 경우 문서에 있는 카드 정보를 기본값으로 설정 */
      	if( expendCard.cardCode && expendCard.cardCode != '' && expendCard.cardCode != '0' && $(".ExpendCard").css("display") != 'none'){
      		expendListCard = expendCard;
      		$('#txtListCardCode').val(expendListCard.cardCode);
      		$('#txtListCardName').val(expendListCard.cardName);
      	}
      	/* 옵션 적용 후 추가 설정 */
      	if(!isUseBudget){
			$("#btnListiCUBEBudgetChk").hide();
			$("#btnListERPiUBudgetChk").hide();
		}else{
			if( ifSystem === 'iCUBE' ){
				$("#txtListDrAcctName").css('width','20%')
				$("#txtListSummaryName").css('width','21%');
				$("#btnListiCUBEBudgetChk").show();
			}else if(ifSystem === 'ERPiU'){
				$("#txtListBgAcctName").css('width','42%');
				$("#btnListERPiUBudgetChk").show();
			}
		}
		if (expendList.interfaceType == 'card' && expendList.interfaceMId != '' && !updateCardAmt) {
			$('#txtListAmt, #txtListTaxAmt, #txtListSubTaxAmt, #txtListStdAmt, #txtListSubStdAmt').attr('disabled', 'disabled');
		}else if (expendList.interfaceType == 'etax' && expendList.interfaceMId != '' && !updateEtaxAmt) {
			$('#txtListAmt, #txtListTaxAmt, #txtListSubTaxAmt, #txtListStdAmt, #txtListSubStdAmt').attr('disabled', 'disabled');
		}
    }

	/* ERPiU - 예산 체크 진행 */
	function fnExpendERPiUBudgetChk(){
			
		$("#btnListERPiUBudgetChk").click(function() {

			if(expend.get("erpiuBudgetVer") != "" && (expendListBudget.ynControl || '') !== 'Y') {
				alert('예산통제 대상이 아닙니다.');
				return;
			}

<%-- 			// 예산단위
			var _budget_code = '';
			// 예산계정 코드
			var _bgacct_code = '';
			// 예산계정 명칭
			var _bgacct_name = '';
			// 사업게획 코드
			var _bizplan_code = '';
			// 차,대변 구분
			var _drcr_gbn = '';
			// 예산년월
			var _budget_ym = expend.expendDate;

			if ($("#txtListBgAcctName").val() !== '') {
				_bgacct_code = ($("#txtListBgAcctCode").val() || 0);
				_bgacct_name = ($("#txtListBgAcctName").val() || '');
				_budget_code = ($("#txtListBudgetCode").val() || '');
				_bizplan_code = ($("#txtListBizplanCode").val() || '');
				if (_bgacct_code === 0) {
					alert("<%=BizboxAMessage.getMessage("TX000018816","잘못된 계정과목입니다")%>");
					return;
				}
			} else {
				alert("<%=BizboxAMessage.getMessage("TX000018817","예산계정을 확인하여 선택하여주십시오")%>");
				return;
			}
			_budget_ym = expend.expendDate;
			_drcr_gbn = 'dr'; --%>

			// 예산관련 파라미터 정보
			// expendListBudget.budgetYm // 예산년월
			// expendListBudget.drcrGbn = 'dr' // 차대구분
			// expendListBudget.budgetCode // 예산단위코드
			// expendListBudget.budgetName // 예산단위명칭
			// expendListBudget.bizplanCode // 사업계획코드
			// expendListBudget.bizplanName // 사업계획명칭
			// expendListBudget.bgacctCode // 예산계정코드
			// expendListBudget.bgacctName // 예산계정명칭
			// expendListBudget.cdBgLevel // 통제계정코드
			// expendListBudget.ynControl // 예산통제여부
			// expendListBudget.tpControl // 에산통제구분

			// expendListBudget.amt = 0 // 금액

			// expendList.expendSeq // 지출결의시퀀스
			// expendList.listSeq // 지출결의항목시퀀스
			// basicListAmt // 지출결의이전금액

			if((expendListBudget.budgetCode || '') === '') {
				alert("<%=BizboxAMessage.getMessage("TX000018817","예산계정을 확인하여 선택하여주십시오")%>");
				return;
			}
			else if((expendListBudget.budgetCode || '') === '' || expendListBudget.budgetCode === '0') {
				alert("<%=BizboxAMessage.getMessage("TX000018816","잘못된 계정과목입니다")%>");
				return;
			}


			var bgParam = "?callback=&bgacct_code=" + expendListBudget.bgacctCode;
			bgParam += "&bgacct_name=" + escape(encodeURIComponent(expendListBudget.bgacctName));
			bgParam += "&budget_code=" + expendListBudget.budgetCode;
			bgParam += "&bizplan_code=" + expendListBudget.bizplanCode;
			bgParam += "&amt=0";
			bgParam += "&budget_ym=" + ($('#txtExpendDate').val().toString().replace(/-/g, '') || expendListBudget.budgetYm +'01' );
			bgParam += "&drcr_gbn=dr";
			bgParam += "&expendSeq=" + expendList.expendSeq;
			bgParam += "&listSeq=" + expendList.listSeq;
			bgParam += "&basicListAmt=" +  Number(basicListAmt || '0');
			bgParam += "&cd_bg_level=" + (expendListBudget.cdBgLevel || '');
			bgParam += "&yn_control=" + (expendListBudget.ynControl || '');
			bgParam += "&tp_control=" + (expendListBudget.tpControl || '');
			bgParam += "&isEdit=" + (listIsEdit || false);
         
			var popParam = {};
			popParam.title = "${CL.ex_budgetChk}";
			popParam.width = '';
			popParam.height = '';
			popParam.opener = '3';
			popParam.parentId = '';
			popParam.childId = '';
			popParam.getParam = bgParam;
			var url = "<c:url value='/ex/user/expend/ExBudgetCheckPopup.do'/>"+ popParam.getParam;

			var popupWidth = 500;
		    var popupHeight = 380;
		    var windowX = (screen.width - popupWidth)/2;
		    var windowY = (screen.height - popupHeight)/2;

			window.open(url,'예산확인',"width=500,height=280,left=" + windowX + ",top=" + windowY);
		});
	}

	/* iCUBE - 예산 체크 진행 */
	function fnExpendiCUBEBudgetChk(){
		$("#btnListiCUBEBudgetChk").click(function() {
			var _acct_code = '';
			var _acct_name = '';
			var _budget_code = '';
			var _drcr_gbn = '';
			var _budget_ym = expend.expendDate;

			if ($("#hidExpendListSummaryInfo").val() !== '') {
				var acctInfo = JSON.parse($("#hidExpendListSummaryInfo").val())

				_acct_code = (acctInfo.drAcctCode || 0);
				_acct_name = (acctInfo.drAcctName || '');
				if (_acct_code === 0) {
					alert("<%=BizboxAMessage.getMessage("TX000018816","잘못된 계정과목입니다")%>");
					return;
				}
			} else {
				alert("<%=BizboxAMessage.getMessage("TX000007236","표준적요를 입력해 주세요.")%>");
				return;
			}
			//준성 체크
			if (expendBudgetInfo.budgetType === "D") {
				_budget_code = expendListUseEmp.erpDeptSeq;
			} else if (expendBudgetInfo.budgetType === "P") {
				if(expendProject.projectCode && expendProject.projectCode != '' && expendProject.projectCode != '0'){
					if( expendProject.projectCode === '' ){
						alert("<%=BizboxAMessage.getMessage("TX000007086","프로젝트를 선택하여 주십시요.")%>");
						return false;
					}
					_budget_code = expendProject.projectCode;
				}else{
					if( expendListProject.projectCode === '' ){
						alert("<%=BizboxAMessage.getMessage("TX000007086","프로젝트를 선택하여 주십시요.")%>");
						return false;
					}
					_budget_code = expendListProject.projectCode;
				}

			} else {
				alert("<%=BizboxAMessage.getMessage("TX000018818","예산편성 타입이 잘못되었습니다")%>");
				return;
			}

			_budget_ym = expend.expendDate;
			_drcr_gbn = 'dr';

			/* var bgParam = "?callback=&acct_code='" + _acct_code
					+ "'&acct_name='" + escape(encodeURIComponent(_acct_name))
					+ "'&budget_code='" + _budget_code
					+ "'&amt='" + '0'
					+ "'&budget_ym='" + _budget_ym
					+ "'&drcr_gbn='" + _drcr_gbn
					+ "'&expendSeq='" + expendList.expendSeq
					+ "'&listSeq='" + expendList.listSeq
					+ "'&basicListAmt='" + Number(basicListAmt) + "'"; */

			var bgParam = "?callback=&acct_code=" + _acct_code
			bgParam += "&acct_name=" + escape(encodeURIComponent(_acct_name))
			bgParam += "&budget_code=" + _budget_code
			bgParam += "&amt=0"
			bgParam += "&budget_ym=" + _budget_ym
			bgParam += "&drcr_gbn=" + _drcr_gbn
			bgParam += "&expendSeq=" + expendList.expendSeq
			bgParam += "&listSeq=" + expendList.listSeq
			bgParam += "&basicListAmt=" + Number(basicListAmt || '0');
			bgParam += "&cd_bg_level=" + (expendListBudget.cdBgLevel || '');
			bgParam += "&yn_control=" + (expendListBudget.ynControl || '');
			bgParam += "&tp_control=" + (expendListBudget.tpControl || '');


			var popParam = {};
			popParam.title = "${CL.ex_budgetChk}";
			popParam.width = '';
			popParam.height = '';
			popParam.opener = '3';
			popParam.parentId = '';
			popParam.childId = '';
			popParam.getParam = bgParam;
			var url = "<c:url value='/ex/user/expend/ExBudgetCheckPopup.do'/>"+ popParam.getParam;

			var popupWidth = 500;
		    var popupHeight = 380;
		    var windowX = (screen.width - popupWidth)/2;
		    var windowY = (screen.height - popupHeight)/2;

			window.open(url,"${CL.ex_budgetChk}","width=500,height=280,left=" + windowX + ",top=" + windowY);
		});
	}

	function fnOpenCommonCodePop(input, codeType){
		if(codeType === 'Notax'){
			codeType = 'NoTax';
		}
		// 엔터 이벤트로 호출하는 경우
		if(input === 'Y'){
			fnOpenCodePop({
				codeType : codeType,
				callback : 'fnExpendListCallback',
				searchStr : $("#txtList" + codeType + "Name").val(),
				erp_emp_seq : (expendListUseEmp.erpEmpSeq || ''),
				erp_dept_seq : (expendEmpDeptLink ? expendListUseEmp.erpDeptSeq : ''),
				budget_code : ($("#txtListBudgetCode").val() || ''),
				bizplan_code : ($("#txtListBizplanCode").val() || '***'),
				acct_code : (JSON.parse($('#hidExpendListSummaryInfo').val() || '{}').drAcctCode || ''),
				vat_type : ($('#txtListVatTypeCode').val() || ''),
				reflectResultPop : reflectResultPop,
				expendCardOption : isDisplayFullNumber,
				summryDisplayOption : summryDisplayOption,
				formSeq : expend.formSeq,
				codeSortType : codeSortType
			});
		}else{ // 찾기 버튼으로 호출하는 경우
			fnOpenCodePop({
				codeType : codeType,
				callback : 'fnExpendListCallback',
				searchStr : '',
				erp_emp_seq : (expendListUseEmp.erpEmpSeq || ''),
				erp_dept_seq : (expendEmpDeptLink ? expendListUseEmp.erpDeptSeq : ''),
				budget_code : ($("#txtListBudgetCode").val() || ''),
				bizplan_code : ($("#txtListBizplanCode").val() || '***'),
				acct_code : (JSON.parse($('#hidExpendListSummaryInfo').val() || '{}').drAcctCode || ''),
				vat_type : ($('#txtListVatTypeCode').val() || ''),
				reflectResultPop : reflectResultPop,
				expendCardOption : isDisplayFullNumber,
				summryDisplayOption : summryDisplayOption,
				formSeq : expend.formSeq,
				codeSortType : codeSortType
			});
		}
	}

	function fnOpenEntertainmentFeePop( ){
		var url = "<c:url value='/expend/ex/user/userEntertainmentFee.do'/>";

    	var popupWidth = 700;
	    var popupHeight = 496;
	    var windowX = (screen.width - popupWidth)/2;
	    var windowY = (screen.height - popupHeight)/2;

	    url += "?feeSeq=" + (feeSeq || 0);
	    url += "&callback=" +"fnExpendListEntertainmentFee";

		var win = window.open(url,"접대비등록(ERPiU)","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);

        if(win== null || win.screenLeft == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018810","브라우져 팝업차단 설정을 확인해 주세요")%>");
        }
	}

	function fnExpendListEntertainmentFee(param){
		feeSeq = param.feeSeq;
		$('#hidExpendListReceptInfo').val(param);
	}

	/* 콜백 */
	/* 콜백 - 표준적요 */
	/* 콜백 - 증빙유형 */
	/* 콜백 - 프로젝트 */
	/* 콜백 - 카드 */
	/* 콜백 - 거래처 */
	function fnExpendListCallback(param) {
		var target;
		var type = param.type;
		var elemId = '';
		switch (type.toLowerCase()) {

		case expendType.emp://사용자
			elemId = 'txtListEmpName';

			expendListUseEmp.erpDeptSeq = param.obj.erpDeptSeq;

			target = $('#hidExpendListEmpInfo, #txtListEmpCode, #txtListEmpName, #txtListDeptCode, #txtListDeptName, #txtListCcCode, #txtListCcName');

			fnCopyToBOservalbe(param.obj, expendListUseEmp);
        	 // 사업장, 부서, 코스트센터, 회계단위
            if( expendListUseEmp.erpBizSeq === '0' || expendListUseEmp.erpBizSeq === '' ){
            	alert("<%=BizboxAMessage.getMessage("TX000018785","작성자의 사업장이 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
            }
            if( expendListUseEmp.erpDeptSeq === '0' || expendListUseEmp.erpDeptSeq === '' ){
            	alert("<%=BizboxAMessage.getMessage("TX000018788","작성자의 부서가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
            }
            if( ifSystem === 'ERPiU'){
            	if( expendListUseEmp.erpCcSeq === '0' || expendListUseEmp.erpCcSeq === '' ){
            		alert("<%=BizboxAMessage.getMessage("TX000018789","작성자의 코스트센터가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
                }
            	if( expendListUseEmp.erpPcSeq === '0' || expendListUseEmp.erpPcSeq === '' ){
            		alert("<%=BizboxAMessage.getMessage("TX000018790","작성자의 회계단위가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
                }
            }
			break;
		case expendType.dept: // 부서
			target = $('#txtListDeptCode, #txtListDeptName');
			fnCopyToBOservalbe(param.obj, expendListUseEmp);
			break;
		case expendType.pc://회계단위
			/* elemId = 'txtExpendPcName'; */
			/* target = $('#txtExpendPcCode, #txtExpendPcName'); */
			/* fnCopyToBOservalbe(param.obj, expendListUseEmp); */
			break;
		case expendType.cc://회계단위
			elemId = 'txtListCcName';
			target = $('#txtListCcCode, #txtListCcName');
			fnCopyToBOservalbe(param.obj, expendListUseEmp);
			break;
		case expendType.summary: /* 표준적요 */
			elemId = 'txtListSummaryName';
			target = $('#hidExpendListSummaryInfo, #txtListSummaryCode, #txtListDrAcctName, #txtListSummaryName');
			/* ERPiU에서 해당 계정과목이 접대비인지 아닌지 확인 진행 */
			if ('${ViewBag.ifSystem}' == 'ERPiU'){
				var ajaxParam = {};
				ajaxParam.acctCode = param.obj.drAcctCode;
				$.ajax({
					type : 'post',
					url : '<c:url value="/ex/expend/user/ChkAcctReceptYN.do" />',
		            datatype : 'json',
		            async : false,
		            data : ajaxParam,
					success: function(data){
						 if(data.result.resultCode == "SUCCESS"){
							 if( ('${ViewBag.empInfo.groupSeq}' == 'visang' || '${ViewBag.empInfo.groupSeq}' == 'demo' || '${ViewBag.empInfo.groupSeq}' == 'portal') && data.result && data.result.aaData && data.result.aaData.length > 0 && data.result.aaData[0].receptYN == 'Y' ){
								 $("#btnListReceptSearch").parent().show();
							 }else{
								 $("#btnListReceptSearch").parent().hide();
								 feeSeq = 0;
							 }
						 }else{
							$("#btnListReceptSearch").parent().hide();
							feeSeq = 0;
						 }
					},
					error : function(data){

					}
				});

				//표준적요 변경 시 예산정보 초기화(예산단위, 사업계획, 예산계정)_ERPiU만 적용
				if ('${ViewBag.isSummaryChangeReset}' == 'Y'){
					//예산단위
					expendListBudget.set("budgetCode", '');
					expendListBudget.set("budgetName", '');
					//사업계획
					expendListBudget.set("bizplanCode", '');
					expendListBudget.set("bizplanName", '');
					//예산계정
					expendListBudget.set("bgacctCode", '');
					expendListBudget.set("bgacctName", '');

					//특정경우 expendListBudget의 change 이벤트가 발생하지 않아 강제 초기화
					$('#txtListBudgetCode').val('');
					$('#txtListBudgetName').val('');
					$('#txtListBizplanCode').val('');
					$('#txtListBizplanName').val('');
					$('#txtListBgAcctCode').val('');
					$('#txtListBgAcctName').val('');
				}
			}else{
				$("#btnListReceptSearch").parent().hide();
				feeSeq = 0;
			}
			break;
		case expendType.auth: /* 증빙유형 */
			elemId = 'txtListAuthName';
			target = $('#hidExpendListAuthInfo, #txtListAuthCode, #txtListAuthName');
			break;
		case expendType.vat: /* 부가세 */
			elemId = 'txtListVatTypeName';
			target = $('#txtListVatTypeCode, #txtListVatTypeName');
			break;
		case expendType.va: /* 사유구분 */
			elemId = 'txtListVatReasonName';
			target = $('#txtListVatReasonCode, #txtListVatReasonName');
			break;
		case expendType.project: /* 프로젝트 */
			elemId = 'txtListProjectName';
			expendListProject.projectCode = param.obj.projectCode;
			expendListProject.projectName = param.obj.projectName;
			target = $('#hidExpendListProjectInfo, #txtListProjectCode, #txtListProjectName');
			break;
		case expendType.card: /* 카드 */
			elemId = 'txtListCardName';
			target = $('#hidExpendListCardInfo, #txtListCardCode, #txtListCardName');
			break;
		case expendType.partner: /* 거래처 */
			elemId = 'txtListPartnerName';
			target = $('#hidExpendListPartnerInfo, #txtListPartnerCode, #txtListPartnerName');
			break;
		case expendType.notax: /* 불공제구분 */
			elemId = 'txtListNoTaxName';
			target = $('#hidExpendListNoTaxInfo, #txtListNoTaxCode, #txtListNoTaxName');
			break;
		case expendType.budget: /* 예산단위 */
			elemId = 'txtListBudgetName';
			target = $('#hidExpendListERPiUBudgetInfo, #txtListBudgetCode, #txtListBudgetName');
			break;
		case expendType.bizplan: /* 사업계획 */
			elemId = 'txtListBizplanName';
			target = $('#hidExpendListBizplanInfo, #txtListBizplanCode, #txtListBizplanName');
			break;
		case expendType.bgacct: /* 예산계정 */
			elemId = 'txtListBgAcctName';
			target = $('#hidExpendListBgAcctInfo, #txtListBgAcctCode, #txtListBgAcctName');
			break;
		}

		fnSetExpendDispValue(target, param.obj, type); /* 데이터 바인딩 */
		if (type === 'auth')
		{
			/* iCUBE */
			if ('${ViewBag.ifSystem}' === 'iCUBE') {
				/* 아이큐브 사유구분 항목이 나타나는 증빙유형 23, 24, 26 */
				fnSetExpendDispValue($('#txtListVatTypeCode, #txtListVatTypeName'), param.obj, 'vat');

				/* 금액 필수값 표시 여부 설정 */
				switch (param.obj.vatTypeCode) {
					case '24':
						/* 부가세액 필수 X, 과세표준액, 세액 필수 */
						$("#expendListSubTaxAmt, #expendListSubStdAmt").show();
						$("#expendListReqTaxAmt").hide();
						break;
					case '22':
					case '23':
					case '41':
						/* 부가세액, 세액 필수 X, 과세표준액 필수 */
						$("#expendListSubStdAmt").show();
						$("#expendListReqTaxAmt, #expendListSubTaxAmt").hide();
						break;
					case '21':
					case '25':
					case '26':
					case '27':
					case '28':
					case '29':
						/* 전부 다 필수 필수 X*/
						$("#expendListReqTaxAmt, #expendListSubTaxAmt, #expendListSubStdAmt").show();
						break;
					default:
						/* 전부 다 필수 필수 X*/
						$("#expendListReqTaxAmt, #expendListSubTaxAmt, #expendListSubStdAmt").hide();
						break;
				}

				switch (param.obj.vatTypeCode) {
				/*
					22 : 불공(세금계산서)
					50 : 불공(신용카드)
					위의 경우 불공제 구분 값을 입력하게 한다.
				*/
					case '23':
					case '24':
					case '26':
						//부가세 구분
						type = 'vat'
						target = $('#txtListVatTypeCode, #txtListVatTypeName');
						fnSetExpendDispValue(target, param.obj, type);
						//사유 구분
						type = 'va'
						target = $('#txtListVatReasonCode, #txtListVatReasonName');
						fnSetExpendDispValue(target, param.obj, type);
						$('.ExpendVatReason').show();
						break;
					default:
						$('.ExpendVatReason').hide();
						var authInfo = $("#hidExpendListAuthInfo").val();
						authInfo.vatTypeCode = '';
						authInfo.vatTypeName = '';
						authInfo.vaTypeCode = '';
						authInfo.vaTypeName = '';
						$("#hidExpendListAuthInfo").val(authInfo);
						break;
				}

				/* 전자세금계산서 발행 여부 선택 표시 */
				switch (param.obj.vatTypeCode) {
				/*
					21 : 과세매입
					22 : 영세매입
					23 : 면세매입
					24 : 불공(세금계산서)
					25 : 수입
					위의 경우 전자세금계산서 발행여부 항목을 표시해준다
				*/
					case '21':
					case '22':
					case '23':
					case '24':
					case '25':
						if (expendList.interfaceType != 'card'){
							/* 카드사용내역인 경우 전자세금계산서 여부가 표시되지 않는다.*/
							$('.ExpendListTax').show();
						}else{
							$('.ExpendListTax').hide();
						}

						$("#divEtaxSendYN").hide();
						$("#etaxYN").prop("checked", true);
						break;
					default:
						$('.ExpendListTax').hide();
						break;
				}

				/* iCUBE 승인번호 입력  - 2019. 02. 11. 김상겸 추가*/
				/* 28 : 현금영수증매입일 경우 팝업 오픈 카드내역/세금계산서내역 인 경우는 안뜸 */
				if(expendList.interfaceType == '' && param.obj.vatTypeCode == "28"){
					$(".ExpendListReqNoCash").show();
					$("#txtListNoCash").val(expendListAuth.noCash);
				}else{
					$(".ExpendListReqNoCash").hide();
					$("#txtListNoCash").val('');
				}
			}else if('${ViewBag.ifSystem}' === 'ERPiU'){
				fnSetExpendDispValue($('#txtListVatTypeCode, #txtListVatTypeName'), param.obj, 'vat');
				/* 금액 필수값 표시 여부 설정 */
				switch (param.obj.vatTypeCode) {
					case '22':
					case '50':
						/* 부가세액 필수 X, 과세표준액, 세액 필수 */
						$("#expendListSubTaxAmt, #expendListSubStdAmt").show();
						$("#expendListReqTaxAmt").hide();
						break;
					case '23':
					case '25':
					case '26':
					case '37':
					case '39':
					case '99':
						/* 부가세액, 세액 필수 X, 과세표준액 필수 */
						$("#expendListSubStdAmt").show();
						$("#expendListReqTaxAmt, #expendListSubTaxAmt").hide();
						break;
					case '21':
					case '24':
					case '31':
					case '38':
					case '43':
						/* 전부 다 필수 필수 */
						$("#expendListReqTaxAmt, #expendListSubTaxAmt, #expendListSubStdAmt").show();
						break;
					default:
						/* 전부 다 필수 필수 X */
						$("#expendListReqTaxAmt, #expendListSubTaxAmt, #expendListSubStdAmt").hide();
						break;
				}

				/*
					22 : 불공(세금계산서)
					50 : 불공(신용카드)
					위의 경우 불공제 구분 값을 입력하게 한다.
				*/
				switch (param.obj.vatTypeCode) {
					case '22':
					case '50':
						//불공제구분
						type = 'notax'
						target = $('#txtListNoTaxCode, #txtListNoTaxName');
						fnSetExpendDispValue(target, param.obj, type);
						$('.ExpendListNoTax').show();
						break;
					default:
						$('.ExpendListNoTax').hide();
						var authInfo = $("#hidExpendListAuthInfo").val();
						authInfo.vatTypeCode = '';
						authInfo.vatTypeName = '';
						authInfo.noTaxCode = '';
						authInfo.noTaxName = '';
						$("#hidExpendListAuthInfo").val(authInfo);
						break;
				}
				/*
					21 : 과세(세금계산서)
					22 : 불공(세금계산서)
					23 : 영세(세금계산서)
					26 : 면세(계산서)
					27 : 의제(계산서 2/102)
					29 : 의제(계산서 3/103)
					32 : 의제(계산서 5/105)
					38 : 수입(세금계산서)
					40 : 의제(계산서 6/106)
					43 : 매입자발행세금계산서
					44 : 재활용(계산서 6/106)
					46 : 재활용(계산서 10/110)
					48 : 의제(계산서 8/108)
					51 : 의제(계산서 4/104)
					54 : 재활용(계산서 9/109)
					65 : 재활용(계산서 3/103)
					위의 경우 전자세금계산서 여부 및 11일 전송 여부를 표시한다.
				*/
				switch (param.obj.vatTypeCode) {
					case '21':
					case '22':
					case '23':
					case '26':
					case '27':
					case '29':
					case '32':
					case '38':
					case '40':
					case '43':
					case '44':
					case '46':
					case '48':
					case '51':
					case '54':
					case '65':
						if (expendList.interfaceType != 'card'){
							/* 카드사용내역인 경우 전자세금계산서 여부가 표시되지 않는다.*/
							$('.ExpendListTax').show();
						}else{
							$('.ExpendListTax').hide();
						}
						$("#etaxYN").prop("checked", true);
						$("#etaxSendYN").prop("checked", true);
						break;
					default:
						$('.ExpendListTax').hide();
						break;
				}
				/* ERPiU 승인번호 입력  - 2018. 05. 02. 신재호 추가*/
				/* 31 : 현금영수증 37 : 현금영수증(면세) 일 경우 팝업 오픈 카드내역/세금계산서내역 인 경우는 안뜸 */
				if(expendList.interfaceType == '' && (param.obj.vatTypeCode == "31" || param.obj.vatTypeCode =="37")){
					$(".ExpendListReqNoCash").show();
				}else{
					$(".ExpendListReqNoCash").hide();
					$("#txtListNoCash").val('');
				}
			}
			fnSetRequired('expendList', param.obj); /* 필수값 처리 */
			fnSetFocusPrimary(param.obj);
			if(param.obj.vatTypeCode === ''){
				$('#expendListReqVatType').hide();
			}else{
// 				$('#expendListReqVatType').show();
			}


			/* 증빙유형 금액 재 설정 */
			if($("#chkAutoCalculation").is(":checked")){
				fnSetAmt('Amt');
			}

			expendList.set('stdAmt', ($('#txtListStdAmt').val()).toString().replace(/,/g, ''));
			expendList.set('taxAmt', ($('#txtListTaxAmt').val()).toString().replace(/,/g, ''));
			expendList.set('amt', ($('#txtListAmt').val()).toString().replace(/,/g, ''));
			expendList.set('subStdAmt',($('#txtListSubStdAmt').val()).toString().replace(/,/g, ''));
			expendList.set('subTaxAmt',($('#txtListSubTaxAmt').val()).toString().replace(/,/g, ''));

			// 외화계정인지 확인
			fnCheckForeignCurrencyAcctCode();
		}
		else if(type === 'vat')
		{
			/* iCUBE */
			if ('${ViewBag.ifSystem}' === 'iCUBE')
			{
				switch (param.obj.vatTypeCode) {
				/*
					22 : 불공(세금계산서)
					50 : 불공(신용카드)
					위의 경우 불공제 구분 값을 입력하게 한다.
				*/
					case '23':
					case '24':
					case '26':
						//부가세 구분
						// 사유구분 추가로 인한 팝업사이즈 조정(size 28만큼 증가)
						$(".ExpendVatReason").show();
						$("#expendListReqVaType").show();
						var vatInfo = JSON.parse($("#hidExpendListAuthInfo").val());
						vatInfo.vatTypeCode = param.obj.vatTypeCode;
						vatInfo.vatTypeName = param.obj.vatTypeName;
						$("#hidExpendListAuthInfo").val(JSON.stringify(vatInfo));

						break;
					default:
						$('.ExpendVatReason').hide();
						$("#expendListReqVaType").hide();
						// 사유구분 제거로 인한 팝업사이즈 조정
						break;
				}
			}
			/* ERPiU */
			else if ('${ViewBag.ifSystem}' == 'ERPiU') {
				/* 불공인경우 처리 */
				switch (param.obj.vatTypeCode) {
				/*
					22 : 불공(세금계산서)
					50 : 불공(신용카드)
					위의 경우 불공제 구분 값을 입력하게 한다.
				*/
					case '22':
					case '50':
					//부가세 구분
					// 불공제구분 추가로 인한 팝업사이즈 조정(size 28만큼 증가)
					$(".ExpendListNoTax").show();
					$("#expendListReqNoTax").show();
					var vatInfo = JSON.parse($("#hidExpendListAuthInfo").val());
					vatInfo.noTaxCode = param.obj.noTaxCode;
					vatInfo.noTaxName = param.obj.noTaxName;
					$("#hidExpendListAuthInfo").val(JSON.stringify(vatInfo));
					break;
				default:
					// 불공제구분 추가로 인한 팝업사이즈 조정(size 28만큼 증가)
					$('.ExpendListNoTax').hide();
					$("#expendListReqNoTax").hide();
					break;
				}
			}
		}
		else if(type === 'va')
		{
			/* iCUBE */
			if ('${ViewBag.ifSystem}' === 'iCUBE')
			{
				var vaInfo = JSON.parse($("#hidExpendListAuthInfo").val());
				vaInfo.vaTypeCode = param.obj.vaTypeCode;
				vaInfo.vaTypeName = param.obj.vaTypeName;
				$("#hidExpendListAuthInfo").val(JSON.stringify(vaInfo));
			}
		}
		else if(type === 'notax')
		{
			/* iCUBE */
			if ('${ViewBag.ifSystem}' === 'ERPiU')
			{
				var noTax = JSON.parse($("#hidExpendListAuthInfo").val());
				noTax.noTaxCode = param.obj.noTaxCode;
				noTax.noTaxName = param.obj.noTaxName;
				$("#hidExpendListAuthInfo").val(JSON.stringify(noTax));
			}
		}
		else if (type == 'summary') {
			// 적요란 표준적요 자동입력 사용일 경우
			if(isAutoInputNoteInfo){
				$("#txtListNote").val(param.obj.summaryName);
				if (ifSystem == 'iCUBE' && isUseBudget) {
					$("#budget_code").val(expendListUseEmp.erpDeptSeq);
					$("#budget_ym").val(expend.expendDate.substr(0, 6));
					$("#acct_code").val(param.obj.drAcctCode);
					$("#drctr_gbn").val('dr');
					expendListBudget.set("bgacctCode",param.obj.drAcctCode);
					expendListBudget.set("bgacctName",param.obj.drAcctName);
					expendListBudget.set("budgetType",expendBudgetInfo.budget_type);
					if(expendBudgetInfo.erpType === 'iCUBE' && expendBudgetInfo.budgetType === 'D'){
						expendListBudget.set("budgetCode",expendListUseEmp.erpDeptSeq);
						expendListBudget.set("budgetName",expendListUseEmp.erpDeptName);
					}
				}
			}

			// 외화계정인지 확인
			fnCheckForeignCurrencyAcctCode();
		}
		else if (type == 'card') {
			if (!isDisplayFullNumber) {
				$("#txtListCardCode").val(param.obj.cardNum.replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/,"$1-****-****-$4"));
			}
		}
		else if(type == 'project'){
			if(expendBudgetInfo.erpType === 'iCUBE' && expendBudgetInfo.budgetType === 'P'){
				expendListBudget.set('budgetCode', expendListProject.projectCode);
				expendListBudget.set('budgetName', expendListProject.projectName);
			}
		}else if(type == 'budget'){
			expendListBudget.set("budgetCode", param.obj.budgetCode);
			expendListBudget.set("budgetName", param.obj.budgetName);
			if ('${ViewBag.ifSystem}' === 'ERPiU') {
				/* 2019-01-09 김상겸 : 예산단위 선택 시 사업계획 및 예산계정 초기화 ( ERPiU만 해당 ) */
				expendListBudget.set("bizplanCode", '');
				expendListBudget.set("bizplanName", '');
				expendListBudget.set("bgacctCode", '');
				expendListBudget.set("bgacctName", '');
			}
		}else if(type == 'bizplan'){
			expendListBudget.set("bizplanCode", param.obj.bizplanCode);
			expendListBudget.set("bizplanName", param.obj.bizplanName);
			if ('${ViewBag.ifSystem}' === 'ERPiU') {
				/* 2019-01-09 김상겸 : 사업계획 선택 시 예산계정 초기화 ( ERPiU만 해당 ) */
				expendListBudget.set("bgacctCode", '');
				expendListBudget.set("bgacctName", '');
			}
		}else if(type == 'bgacct'){
			expendListBudget.set("bgacctCode", param.obj.bgacctCode);
			expendListBudget.set("bgacctName", param.obj.bgacctName);
			// 2020. 02. 27. 김상겸, ERPiU 예산통제 기준 변경으로 분리 관리를 위하여 예상통제 버전 추가 기록 진행
			expendListBudget.set("cdBgLevel", param.obj.cdBgLevel);
			expendListBudget.set("ynControl", param.obj.ynControl);
			expendListBudget.set("tpControl", param.obj.tpControl);
		}

		// fnSetFocus();
		focus_fnMoveFocus(elemId, true);
		return;
	}

	/* focus.js 공용 변수 기본값 설정 */
	function fnSetFocusPrimary(obj){
		focus_fnSetprimary('txtListAuthDate', obj.authRequiredYN == 'Y');
		focus_fnSetprimary('txtListCardName', obj.cardRequiredYN == 'Y');
		focus_fnSetprimary('txtListNote', obj.noteRequiredYN == 'Y');
		focus_fnSetprimary('txtListNoCash', false);
		focus_fnSetprimary('txtListPartnerName', obj.partnerRequiredYN == 'Y');
		focus_fnSetprimary('txtListProjectName', obj.projectRequiredYN == 'Y');
	}

	/* 저장 전 예산금액 확인 */
	function fnExpendBudgetCheck(){
		var process = false;

		if(expendBudgetInfo.useYN ==='Y' && isUseBudget==true){
			var acctInfo = JSON.parse($("#hidExpendListSummaryInfo").val());
			var data = {};
			if(ifSystem === 'iCUBE'){
				data.acctCode = (acctInfo.drAcctCode || 0);
				if (expendBudgetInfo.budgetType === "D") {
					data.budgetCode = expendListUseEmp.erpDeptSeq;
				} else if (expendBudgetInfo.budgetType === "P") {
					if(expendProject.projectCode && expendProject.projectCode != '' && expendProject.projectCode != '0'){
						_budget_code = expendProject.projectCode;
					}else{
						if( expendListProject.projectCode === '' ){
							alert("<%=BizboxAMessage.getMessage("TX000007086","프로젝트를 선택하여 주십시요.")%>");
							return false;
						}
						_budget_code = expendListProject.projectCode;
					}
					data.budgetCode = _budget_code;
				} else {
					alert("<%=BizboxAMessage.getMessage("TX000018818","예산편성 타입이 잘못되었습니다")%>");
					return process;
				}
			}
			else if(ifSystem === 'ERPiU'){
				data.bgacctCode = (expendListBudget.get('bgacctCode') || 0);
				data.budgetCode = (expendListBudget.get('budgetCode') || 0 );
				data.bizplanCode = (expendListBudget.get('bizplanCode') || '***' );
				data.bgacctCode = (expendListBudget.get('bgacctCode') || 0 );
				/* 준성 - 상위 예산 통제레벨 수정 */
				data.cdBgLevel = (expendListBudget.get('cdBgLevel') || '' );
				data.ynControl = (expendListBudget.get('ynControl') || '' );
				data.tpControl = (expendListBudget.get('tpControl') || '' ); 
				data.isEdit = (listIsEdit|| false); 
			}
			data.amt = $('#txtListStdAmt').val().toString().replace(/,/g, '');
			data.budgetYm = expend.expendDate;
			data.drcrGbn = 'dr';
			data.expendSeq = expendList.get("expendSeq");
			data.listSeq = expendList.get("listSeq");
		 	var ajaxParam = {};
		        ajaxParam.url = '<c:url value="/ex/user/expend/ExBudgetAmtCheck2.do" />';
		        ajaxParam.async = false;
		        ajaxParam.data = data;
		        ajaxParam.callback = function fnGetBudgetAmt(resultData){
		        	var popupWidth = 500;
				    var popupHeight = 280;
					var windowX = (screen.width - popupWidth)/2;
				    var windowY = (screen.height - popupHeight)/2;
		        	if(resultData.ifSystem === 'iCUBE'){
		        		var acctInfo = JSON.parse($("#hidExpendListSummaryInfo").val());

		        		var acct_info = '('+acctInfo.drAcctCode+')'+acctInfo.drAcctName;
						if(resultData.aaData.budgetControlYN === 'Y'){
							//전체 사용 가능금액
							// 결재 종결문서인 경우 사용 가능 금액에 기존 금액을 더해준다.
							var act_sum = parseInt(resultData.aaData.budgetActsum) + Number(basicListAmt);
							//승인(결의)진행
							var jsum = parseInt(resultData.aaData.budgetJsum);
							//잔액
							var remain_amt = Number(act_sum) - (Number(jsum) + Number(data.amt));
							if(remain_amt < 0 ){
								//예산초과 팝업 띄우기
								var bgParam = "?callback=''&budget_actsum='"+ act_sum+"'&acct_code='"+acctInfo.drAcctCode +"'&acct_name='"+ escape(encodeURIComponent(acctInfo.drAcctName)) + "'&budget_jsum='"+ jsum+ "'&req_amt='"+ data.amt+ "'";
								var popParam = {};
								popParam.title = "<%=BizboxAMessage.getMessage("TX000007562","예산초과")%>";
								popParam.width = '';
								popParam.height = '';
								popParam.opener = '3';
								popParam.parentId = '';
								popParam.childId = '';
								popParam.getParam = bgParam;
								var url = "<c:url value='/ex/user/expend/ExBudgetOverPopup.do'/>"+ popParam.getParam;
								window.open(url,"<%=BizboxAMessage.getMessage("TX000007562","예산초과")%>","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);
								process = false;
							}
							else{
								process = true;
							}
						}
						else if(resultData.aaData.budgetControlYN === 'N'){
							process = true;
						}
						else if(resultData.aaData.budgetControlYN === 'B'){
							alert("<%=BizboxAMessage.getMessage("TX000018819","표준적요 차변계정에 대한 예산정보가 미편성 상태이므로 전표를 생성할 수 없습니다")%>");
							process = false;
						}
			    	}else if(resultData.ifSystem === 'ERPiU'){
			    		var acctInfo = expendListBudget;
		        		var acct_info = '('+expendListBudget.get("bgacctCode")+')'+expendListBudget.get("bgacctName");
						if(resultData.aaData.budgetControlYN === 'Y'){
							//전체 사용 가능금액
							// 결재 종결문서인 경우 사용 가능 금액에 기존 금액을 더해준다.
							var act_sum = parseInt(resultData.aaData.budgetActsum) + Number(basicListAmt);
							//승인(결의)진행
							var jsum = parseInt(resultData.aaData.budgetJsum);
							//잔액
							var remain_amt = Number(act_sum) - (Number(jsum) + Number(data.amt));
							if(remain_amt < 0 ){
								//예산초과 팝업 띄우기
								var bgParam = "?callback=''&budget_actsum='"+ act_sum+"'&bgacctCode='"+acctInfo.get("bgacctCode")
										+"'&bgacct_name='"+ escape(encodeURIComponent(acctInfo.get("bgacctName") ))
										+ "'&budget_jsum='"+ jsum+ "'&req_amt='"+ data.amt+ "'";
								var popParam = {};
								popParam.title = "<%=BizboxAMessage.getMessage("TX000007562","예산초과")%>";
								popParam.width = '';
								popParam.height = '';
								popParam.opener = '3';
								popParam.parentId = '';
								popParam.childId = '';
								popParam.getParam = bgParam;
								var url = "<c:url value='/ex/user/expend/ExBudgetOverPopup.do'/>"+ popParam.getParam;
								window.open(url,"<%=BizboxAMessage.getMessage("TX000007562","예산초과")%>","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);
								process = false;
							}
							else{
								process = true;
							}
						}
						else if(resultData.aaData.budgetControlYN === 'N'){
							process = true;
						}
			    	}
		        }
		        fnCallAjax(ajaxParam);
		}
		else{
			process = true;
		}
		return process;
	}

	/* 이벤트 초기화 - 버튼 - 저장 */
	function fnExpendListInfoInsert(param) {
		/* 연속 입력 여부 확인 */
		param = param || {};
		var continusInfo = param.continusAction || false;

		/* 필수값 체크 */
		if(!fnChekInputDate()){
			// fnSetFocus();
			return false;
		}
		//예산확인
		if (skipBudgetCheck != "1") {
			if (!fnExpendBudgetCheck()) {
				return false;
			}
		}


		var deleteFileInfo =[];
		/* 첨부파일 업로드 및 콜백 */
	    if($("#uploaderView")[0].contentWindow.hasOwnProperty('fnAttFileUpload')) //GW가 서버에 올라가 있지 않으면 패스.. 첨부 불가
		{
       		if(!$("#uploaderView")[0].contentWindow.fnAttFileUpload())
       		{
       			$("#uploaderView")[0].contentWindow.UploadCallback = "fnCallbackFileIdList()";
    	   		return;
      	 	}
       		var modify_file_list = {};
       		modify_file_list = $("#uploaderView")[0].contentWindow.fnAttFileList();
       		//삭제여부 확인
       		if(modify_file_list.deletefilelist.length > 0)
       		{
       			var del_file_name = new Array();
           		var del_file_key = new Array();

	       		del_file_name = modify_file_list.deletefilelist.split('|');
	       		del_file_key = modify_file_list.deletekeylist.split('|');

	       		for(var i = 0; i <del_file_name.length; i++){
	       			var delFile = {};
	       			delFile.file_name = del_file_name[i];
	       			delFile.file_seq = del_file_key[i];
	       			deleteFileInfo.push(delFile);
	       		}
       		}

		}

		param = ((typeof param == 'object' ? '' : param) || '');

		/* 변수정의 */
		var data = {};
		expendList.note = $("#txtListNote").val();
		expendList.autoCalcYn = $("#chkAutoCalculation").is(":checked") ? 'Y' : 'N';
		expendList.amt = ( $('#txtListAmt').val().replace(/,/g,'') || '0');
		expendList.stdAmt = ($('#txtListStdAmt').val().replace(/,/g,'')|| '0');
		expendList.taxAmt = ($('#txtListTaxAmt').val().replace(/,/g,'')|| '0');
		expendList.subStdAmt = ($('#txtListSubStdAmt').val().replace(/,/g,'')|| '0');
		expendList.subTaxAmt = ($('#txtListSubTaxAmt').val().replace(/,/g,'')|| '0');
		expendList.feeSeq = feeSeq;
		data.list = JSON.stringify(expendList.toJSON());
		data.summary = JSON.parse($('#hidExpendListSummaryInfo').val() || '{}');
		expendList.extendStr1 = ($('#txtListExtendStr1').val() || '');
		expendList.extendStr2 = ($('#txtListExtendStr2').val() || '');

		var authData = JSON.parse($('#hidExpendListAuthInfo').val());
		if( $('input:checkbox[id="etaxYN"]').is(":checked") ){ /* 전자세금계산서발행여부 체크 */
			authData.etaxYN = 'Y';
			authData.etaxSendYN = 'N';
		}else{
			authData.etaxYN = 'N';
			authData.etaxSendYN = 'N';
		}
		if(ifSystem == "ERPiU"){
			if( $('input:checkbox[id="etaxSendYN"]').is(":checked") ){ /* 전자세금계산서 11이내 전송여부 */
				authData.etaxSendYN = 'Y';

			}else{
				authData.etaxSendYN = 'N';
			}
		}
		authData.noCash = $("#txtListNoCash").val();

		data.auth = authData;

		/* 사용자 정보 */
		data.emp = JSON.stringify(expendListUseEmp);

		if($(".ExpendListProject").css("display") != 'none'){ // 프로젝트 항목 단위 입력
			data.project = JSON.parse($('#hidExpendListProjectInfo').val() || '{}');
		}else if($(".ExpendListProject").css("display") == 'none' && $(".ExpendProject").css("display") != 'none'){ // 프로젝트 문서 단위 입력
			data.project = JSON.stringify(expendListProject);
		}else{ // 프로젝트 분개 단위 입력
			data.project = JSON.parse($('#hidExpendListProjectInfo').val() || '{}');
		}

		if($(".ExpendListPartner").css("display") != 'none'){ // 거래처 항목 단위 입력
			data.partner = JSON.parse($('#hidExpendListPartnerInfo').val() || '{}');
			/* 코드도움창 없이 거래처 명칭만 입력하여 진행하는 경우 */
			if($("#txtListPartnerName").val( ) != '' && $("#txtListPartnerCode").val( ) === ""){
				expendListPartner.set("partnerName",$("#txtListPartnerName").val( ) );
				data.partner = expendListPartner;
			}
		}else if($(".ExpendListPartner").css("display") == 'none' && $(".ExpendPartner").css("display") != 'none'){ // 거래처 문서 단위 입력
			data.partner = JSON.stringify(expendListPartner);
		}else{ // 거래처 분개 단위 입력
			data.partner = JSON.parse($('#hidExpendListPartnerInfo').val() || '{}');
		}

		if($(".ExpendListCard").css("display") != 'none'){ // 카드 항목 단위 입력
			data.card = JSON.parse($('#hidExpendListCardInfo').val() || '{}');
		}else if($(".ExpendListCard").css("display") == 'none' && $(".ExpendCard").css("display") != 'none'){ // 카드 문서 단위 입력
			data.card = JSON.stringify(expendListCard);
		}else{ // 카드 분개 단위 입력
			data.card = JSON.parse($('#hidExpendListCardInfo').val() || '{}');
		}
		/* 항목 첨부파일 */
		data.attach = JSON.parse($('#hidExpendListAttachInfo').val() || '[]');

		/* 항목 첨부파일 삭제 */
		if(deleteFileInfo.length > 0 ){
 			data.delAttachList = deleteFileInfo;
		}

		if (ifSystem == "ERPiU") {
			if ($("#txtListBudgetName").val() != "") {
				var tBudget = JSON.parse(($("#hidExpendListERPiUBudgetInfo").val() || ''));
				expendListBudget.set('budgetCode', tBudget.budgetCode);
				expendListBudget.set('budgetName', tBudget.budgetName);
				expendListBudget.set('erpCompSeq', tBudget.erpCompSeq);
			}
			if ($("#txtListBizplanName").val() != "") {
				var tBizpln = JSON.parse( ( $("#hidExpendListBizplanInfo").val() || $("#hidExpendListERPiUBudgetInfo").val() ) );
				expendListBudget.set('bizplanCode', tBizpln.bizplanCode);
				expendListBudget.set('bizplanName', tBizpln.bizplanName);
			}
			if ($("#txtListBgAcctName").val() != "") {
				var tBgacct = JSON.parse( ( $("#hidExpendListBgAcctInfo").val() || $("#hidExpendListERPiUBudgetInfo").val() ) );
				expendListBudget.set('bgacctCode', tBgacct.bgacctCode);
				expendListBudget.set('bgacctName', tBgacct.bgacctName);
				/* 준성 - 상위 예산 통제레벨 수정 */
				expendListBudget.set('cdBgLevel', tBgacct.cdBgLevel);
				expendListBudget.set('ynControl', tBgacct.ynControl);
				expendListBudget.set('tpControl', tBgacct.tpControl);
			}
			expendListBudget.set('budgetYm', ( expendListBudget.budgetYm || '' ) );
			expendListBudget.set('budgetControlYN', 'Y');//
		}
		//iCUBE 사용자 다시 넣기
		else if (ifSystem === "iCUBE" && isUseBudget) {
			expendListBudget.set('erpEmpSeq',  expendListUseEmp.erpEmpSeq);
			expendListBudget.set('erpDeptSeq', expendListUseEmp.erpDeptSeq);
			expendListBudget.set('erpCompSeq', expendListUseEmp.erpCompSeq);
// 			expendListBudget.set('budYm', $("#budget_ym").val());//귀속년월 추가
			expendListBudget.set('budgetYm', ( expendListBudget.budgetYm || ( $("#budget_ym").val() || '') ) );
			expendListBudget.set('budgetJsum', '');//귀속년월 추가
			expendListBudget.set('budgetActsum', '');//귀속년월 추가
			expendListBudget.set('budgetControlYN', 'Y');//
			expendListBudget.set('budgetGbn',expendBudgetInfo.budgetType);
			expendListBudget.set('budgetType',expendBudgetInfo.erpType);

			expendListBudget.set('bgacctCode', data.summary.drAcctCode);
			expendListBudget.set('bgacctName', data.summary.drAcctName);

			if (expendBudgetInfo.budgetType === "D") {
				expendListBudget.set('budgetCode', expendListUseEmp.erpDeptSeq);
				expendListBudget.set('budgetName', expendListUseEmp.erpDeptName);
			} else if (expendBudgetInfo.budgetType === "P") {
				if(expendProject.projectCode && expendProject.projectCode != '' && expendProject.projectCode != '0'){
					expendListBudget.set('budgetCode', expendProject.projectCode);
					expendListBudget.set('budgetName', expendProject.projectName);
				}else{
					expendListBudget.set('budgetCode', expendListProject.projectCode);
					expendListBudget.set('budgetName', expendListProject.projectName);
				}
			} else {
				alert("<%=BizboxAMessage.getMessage("TX000018818","예산편성 타입이 잘못되었습니다")%>");
				return process;
			}
		}
		data.budget = JSON.stringify(expendListBudget.toJSON());
		// 예산 사용 여부 옵션
		data.isUseBudget = isUseBudget;
		// 외화정보
		data.foreignCurrency = JSON.parse(($("#hidExpendListForeignCurrencyInfo").val()||'{}'));

		/* 서버호출 */
		var ajaxParam = {};

		if( expend.get('expendStatCode') != ''){ /* 결재 진행중 수정 */
			if( expend.get('erpSendYN') === 'Y' ){
				alert("<%=BizboxAMessage.getMessage("TX000018812","삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
				return false;
			}
			else if( expend.get('expendStatCode') == '100' || expend.get('expendStatCode') == '999' ){
				alert("<%=BizboxAMessage.getMessage("TX000018812","삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
				return false;
			}
			else if( isUseBudget ){ // 예산 사용인 경우에는 별도의 프로세스로 진행
				if (expendList.get('listSeq') != 0) {
					data.isEdit = true;
					listIsEdit = true;
				}else{
					data.isEdit = false;
					listIsEdit = false;
				}
				data.formInfo = JSON.stringify(formInfo);
				ajaxParam.url = '<c:url value="/ex/user/expend/list/ListInfoMakeUpdateApproval.do" />';
			}else{ // 예산 미사용인 경우에는 기존 프로세스로 진행
				data.formInfo = formInfo;
				data.isUseBudget = isUseBudget;
				if (expendList.get('listSeq') != 0) {
					/* 지출결의 항목 수정 */
					data.isEdit = true;
					listIsEdit = true;
// 					ajaxParam.url = '<c:url value="/ex/user/expend/list/ListInfoMakeUpdate.do" />';
				} else {
					/* 지출결의 항목 신규 */
					data.isEdit = false;
					listIsEdit = false;
// 					ajaxParam.url = '<c:url value="/ex/user/expend/list/ListInfoMake.do" />';
				}
				ajaxParam.url = '<c:url value="/ex/user/expend/list/ListInfoMakeUpdateApproval.do" />';
			}
		}else{ /* 기본 수정 */
			if (expendList.get('listSeq') != 0) {
					/* 지출결의 항목 수정 */
					ajaxParam.url = '<c:url value="/ex/user/expend/list/ListInfoMakeUpdate.do" />';
			} else {
				/* 지출결의 항목 신규 */
				ajaxParam.url = '<c:url value="/ex/user/expend/list/ListInfoMake.do" />';
			}

		}

		data.extendStr1 = $('#txtListExtendStr1').val();
		data.extendStr2 = $('#txtListExtendStr2').val();

		/* 연속 입력 정보 확인 */
		ajaxParam.async = true;
		ajaxParam.data = fnConvertJavaParam(data);
		ajaxParam.callback = function(data) {
			data.continus = continusInfo;
			window['${listVo.callback}'](data);
		}
		$("#viewLoading").fadeIn(500);
		fnCallAjax(ajaxParam);
		return;
	}

	/* 콜백 - 포커스 이동 */
	function fnSetFocus() {
		if ($('#expendListReqSummary').css('display') != 'none'
				&& $('#txtListSummaryCode').val() == '') {
			$('#txtListSummaryName').focus();
		} else if ($('#expendListReqNote').css('display') != 'none'
				&& $('#txtListNote').val() == '') {
			$('#txtListNote').focus();
		} else if ($('#expendListReqAuth').css('display') != 'none'
				&& $('#txtListAuthCode').val() == '') {
			$('#txtListAuthName').focus();
		}
		else if ($('#expendListReqVatType').css('display') != 'none'
			&& $('#txtListVatTypeCode').val() == '' && $('.ExpendVatType').css('display') != 'none') {
			$('#txtListVatTypeName').focus();
		}
		else if ($('#expendListReqVaType').css('display') != 'none'
			&& $('#txtListVatReasonCode').val() == '' && $('.ExpendVatReason').css('display') != 'none') {
			$('#txtListVatReasonName').focus();
		}
		else if ($('#expendListReqAuthDate').css('display') != 'none'
				&& $('#txtListAuthDate').val() == '') {
			$('#txtListAuthDate').focus();
		} else if ($('#expendListReqProject').css('display') != 'none'
				&& $('#txtListProjectCode').val() == '') {
			$('#txtListProjectName').focus();
		} else if ($('#expendListReqCard').css('display') != 'none'
				&& $('#txtListCardCode').val() == '') {
			$('#txtListCardName').focus();
		} else if ($('#expendListReqPartner').css('display') != 'none'
				&& $('#txtListPartnerCode').val() == '') {
			$('#txtListPartnerName').focus();
		} else if ($(
				'.ExpendList' + '${ViewBag.ifSystem}' + '.ExpendListBudget')
				.css('display') != 'none'
				&& $('#expendListReqBudget').css('display') != 'none'
				&& $('#txtListBudgetCode').val() == '') {
			$('#txtListBudgetName').focus();
		} else if ($(
				'.ExpendList' + '${ViewBag.ifSystem}' + '.ExpendListBudget')
				.css('display') != 'none'
				&& $('#expendListReqBizplan').css('display') != 'none'
				&& $('#txtListBizplanCode').val() == '') {
			$('#txtListBizplanName').focus();
		} else if ($(
				'.ExpendList' + '${ViewBag.ifSystem}' + '.ExpendListBudget')
				.css('display') != 'none'
				&& $('#expendListReqBgAcct').css('display') != 'none'
				&& $('#txtListBgAcctCode').val() == '') {
			$('#txtListBgAcctName').focus();
		} else if ($('#expendListReqAmt').css('display') != 'none'
				&& $('#txtListAmt').val() == '0') {
			$('#txtListAmt').focus();
		} else {
			$('#txtListAmt').focus();
		}

		inputFlag = true;

		return;
	}
	/* 콜백 - 저장 */
	function fnSetExpendListInfo() {
		return;
	}
	/* 콜백 - 급액입력 */
	function fnSetAmt(type) {
		var inputAmt = 0;
		switch (type) {
		case 'StdAmt':
			inputAmt = ($('#txtListStdAmt').val()).toString().replace(/,/g, '');
			fnInputStdAmt(inputAmt, '2', JSON.parse($('#hidExpendListSummaryInfo').val() || '{}'), JSON.parse($('#hidExpendListAuthInfo').val() || '{}'));
			break;
		case 'SubStdAmt':
			inputAmt = ($('#txtListSubStdAmt').val()).toString().replace(/,/g,
					'');
			fnInputSubStdAmt(inputAmt, '2'
					, JSON.parse($('#hidExpendListSummaryInfo').val() || '{}')
					, JSON.parse($('#hidExpendListAuthInfo').val() || '{}'));
			expendListBudget.set('amt', inputAmt);
			break;
		case 'TaxAmt':
			inputAmt = ($('#txtListTaxAmt').val()).toString().replace(/,/g, '');
			fnInputTaxAmt(inputAmt, '2'
					, JSON.parse($('#hidExpendListSummaryInfo').val() || '{}')
					, JSON.parse($('#hidExpendListAuthInfo').val() || '{}'));
			break;
		case 'SubTaxAmt':
			inputAmt = ($('#txtListSubTaxAmt').val()).toString().replace(/,/g,'');
			fnInputSubTaxAmt(inputAmt, '2'
					, JSON.parse($('#hidExpendListSummaryInfo').val() || '{}')
					, JSON.parse($('#hidExpendListAuthInfo').val() || '{}'));
			break;
		case 'Amt':
			inputAmt = ($('#txtListAmt').val()).toString().replace(/,/g, '');
			fnInputAmt(inputAmt, '2'
					, JSON.parse($('#hidExpendListSummaryInfo').val() || '{}')
					, JSON.parse($('#hidExpendListAuthInfo').val() || '{}'));
			break;
		}
	}


	// 적요 설정(항목 신규 생성 시 기본적용 적요 있으면 반영)
	function fnSetNote() {
		if ($("#txtListNote").val() == "") {
			if ($("#txtExpendBaseNote").val() != "") {
				$("#txtListNote").val(parent.$("#txtExpendBaseNote").val());
			}
		}
	}

	function fnChekInputDate(){
		if($("#expendListReqSummary").css("display")!= 'none'){
			if($("#txtListSummaryCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018820","표준적요가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#expendListReqAuth").css("display")!= 'none'){
			if($("#txtListAuthCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018821","증빙유형이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#expendListReqNote").css("display")!= 'none'){
			if($("#txtListNote").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018822","적요가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#expendListReqVatType").css("display")!= 'none'){
			if($("#txtListVatTypeCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018823","부가세구분이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#expendListReqAuthDate").css("display")!= 'none'){
			if($("#txtListAuthDate").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018792","증빙일자가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if(ifSystem === 'iCUBE' && $("#expendListReqVaType").css("display")!= 'none' && $(".ExpendVatReason").css("display") != 'none'){
			if($("#txtListVatReasonCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018796","사유구분이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($(".ExpendListEmp").css("display")!= 'none'){
			if($("#txtListEmpCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018824","사용자 정보가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
			if($("#txtListDeptCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018825","부서 정보가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#expendListReqProject").css("display")!= 'none' && $(".ExpendListProject").css("display") != 'none'){
			if($("#txtListProjectCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018800","프로젝트가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#expendListReqCard").css("display")!= 'none' && $(".ExpendListCard").css("display") != 'none'){
			if($("#txtListCardCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018801","카드가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}
		if($("#expendListReqPartner").css("display")!= 'none' && $(".ExpendListPartner").css("display") != 'none'){
			if($("#txtListPartnerCode").val() === ''){
				alert("<%=BizboxAMessage.getMessage("TX000018802","거래처가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
				return false;
			}
		}

		/* 	금액 필수값 체크
			1. iCUBE인 경우 0원 입력이 가능. 단 부가세계정이 존재하지 않아야 한다.(ERPiU는 0원 입력 불가능)
			2. 공급대가 확인
			3. 부가세액 확인
			4. 공급가액 확인
			5. 세액 확인
			6. 과세표준액 확인
		*/
		if( JSON.parse( $("#hidExpendListAuthInfo").val() ).vatTypeCode != '' || JSON.parse( $("#hidExpendListAuthInfo").val() ).vatAcctCode != '' || JSON.parse($("#hidExpendListSummaryInfo").val()).vatAcctCode != '' ){
			if($("#expendListReqAmt").css("display")!= 'none'){
				if($("#txtListAmt").val() === '' || $("#txtListAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("TX000018826","공급대가가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendListReqTaxAmt").css("display")!= 'none'){

				if($("#txtListTaxAmt").val() === '' || $("#txtListTaxAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("TX000018827","부가세액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendListReqSubStdAmt").css("display")!= 'none'){
				if($("#txtListStdAmt").val() === '' || $("#txtListStdAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("TX000018828","공급가액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendListSubTaxAmt").css("display")!= 'none'){
				if($("#txtListSubTaxAmt").val() === '' || $("#txtListSubTaxAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("","세액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendListSubStdAmt").css("display")!= 'none'){
				if($("#txtListSubStdAmt").val() === '' || $("#txtListSubStdAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("","과세표준액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
		}

		if(ifSystem === 'ERPiU'){
			if($("#expendListReqAmt").css("display")!= 'none'){
				if($("#txtListAmt").val() === '' || $("#txtListAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("TX000018826","공급대가가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendListReqSubStdAmt").css("display")!= 'none'){
				if($("#txtListStdAmt").val() === '' || $("#txtListStdAmt").val() === '0'){
					alert("<%=BizboxAMessage.getMessage("TX000018828","공급가액이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			// if($(".ExpendListRecept").css("display") !='none'){
			// 	if($("#txtListReceptCode").val() === ''){
			// 		alert("<%=BizboxAMessage.getMessage("","접대비 정보가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
			// 	}
			// }


			if($("#expendListReqNoTax").css("display")!= 'none' && $(".ExpendListNoTax").css("display")!= 'none'){
				if($("#txtListNoTaxCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018797","불공제구분이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendListReqBudget").css("display")!= 'none' && $(".ExpendListReqBudget").css("display")!= 'none'){
				if($("#txtListBudgetCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018804","예산단위가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendListReqBizplan").css("display")!= 'none' && $(".ExpendListReqBizplan").css("display")!= 'none'){
				if($("#txtListBizplanCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018805","사업정보가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($("#expendListReqBgAcct").css("display")!= 'none' && $(".ExpendListReqBgAcct").css("display")!= 'none'){
				if($("#txtListBgAcctCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018806","예산계정이 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
			if($(".ExpendListEmp").css("display")!= 'none'){
				if($("#txtExpendPcCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018829","회계 정보가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
				if($("#txtListCcCode").val() === ''){
					alert("<%=BizboxAMessage.getMessage("TX000018830","코스트 센터 정보가 미입력 되었습니다. 확인후 저장하여 주세요.")%>");
					return false;
				}
			}
		}
		return true;
	}

	/* 공통사용 */
	/* 첨부파일 콜백 함수  */
	function fnCallbackFileIdList()
	{
	     var formData = new FormData();
         for (var x = 0; x < $("#uploaderView")[0].contentWindow.attachFile.length; x++)
         {
             formData.append("file" + x, $("#uploaderView")[0].contentWindow.attachFile[x]);
         }
	     formData.append("pathSeq", "1400"); //이미지 폴더
	     formData.append("relativePath", "list"); // 상대 경로
	     formData.append("empSeq", expendListUseEmp.empSeq);
	     formData.append("attFileCnt", $("#uploaderView")[0].contentWindow.attachFile.length); /* 신규 첨부파일 수 */

         $.ajax({  url : "/gw/cmm/file/fileUploadProc.do",
                   type: "post",
                   dataType: "json",
                   data: formData,
                   processData: false,
                   contentType: false,
                   async:false,
                   success: function(data)
                   {
                	   var fileInfo ={};
                	   fileInfo.file_seq =(data.fileId || '');
                	   fileInfo.type = 'list';
                	   fileInfo.expend_seq = expend.expend_seq;
       				   fileInfo.create_seq = empInfo.empSeq;
       				   fileInfo.modify_seq = empInfo.empSeq;
                	   if (expendList.get('list_seq') !== '')
                	   {
                	   	   fileInfo.list_seq = expendList.get('list_seq');
                	   }
                	   else
                	   {
                		   fileInfo.list_seq = '0';
                	   }
                	   fileInfo.slip_seq = '0';

                	   var  listAttachInfo = new Array();

                	   if( $("#hidExpendListAttachInfo").val() != '' ){
                		   listAttachInfo = JSON.parse($("#hidExpendListAttachInfo").val());
                	   }
                	   listAttachInfo.push(fileInfo);
                	   $("#hidExpendListAttachInfo").val(JSON.stringify(listAttachInfo));
                	   /* 항목 저장 */
                	   fnExpendListInfoInsert();
                   },
                   error: function (result)
                   {
		               alert("<%=BizboxAMessage.getMessage("TX000006510", "실패")%>");
		               return false;
          		   }
         });
	}


	/* 문서 수정시 첨부파일 바인딩 함수 */
	function fnLoadFileList(resultData){
		if(resultData.length > 0 )
		{
			var list = [];
	        $.each(resultData, function( idx, item ) {
	        	var data = {};
	        	data.fileId = item.file_seq;
	        	data.fileNm = item.file_name;
// 	        	data.fileThumUrl = item.file_thum;
	        	data.fileThumUrl = "/gw/cmm/file/fileDownloadProc.do?fileId=" + item.file_seq+'&fileSn='+item.file_sn;
	        	//url : /gw/cmm/file/fileDownloadProc.do? fileId=${infoMap.signFileId}&fileSn=0
	        	data.fileUrl = '/gw/cmm/file/fileDownloadProc.do?fileId='+ item.file_seq +'&fileSn='+item.file_sn;
	        	list.push(data);
	        });
	        tmpAttchBindList = list;
	        fniframeLoadEvent();
		}
	}

	//로드시까지 반복 호출
	function fniframeLoadEvent(){
		var iframe = document.getElementById('uploaderView');
	    var iframeDoc = iframe.contentDocument || iframe.contentWindow.document;

	    if (  iframeDoc.readyState  == 'complete' && $("#uploaderView")[0].contentWindow.fnAttFileListBinding != null) {
	    	$("#uploaderView")[0].contentWindow.fnAttFileListBinding(tmpAttchBindList);
	     	return;
	    }
	    else
	    {
	    	window.setTimeout('fniframeLoadEvent();', 100);
	    }
	}

	// 지출결의 정보 삭제 여부 판단 함수
	function fnIsDeleteItem(itemType){
		switch(itemType){
			case 'summary':
				if( $("#txtListSummaryName").val() == '' ){
					$("#txtListSummaryCode").val('');
					$("#txtListDrAcctName").val('');
					expendList.summarySeq = 0;
					expendListSummary = new kendo.data.ObservableObject(ExCodeSummary);
					$("#hidExpendListSummaryInfo").val('');
				}
				break;
			case 'auth':
				if( $("#txtListAuthName").val() == '' ){
					$("#txtListAuthCode").val('');
					expendList.authSeq = 0;
					expendListAuth = new kendo.data.ObservableObject(ExCodeAuth);
					$("#hidExpendListAuthInfo").val('');
					$("#txtListNoTaxName").val('');
					$("#txtListNoTaxCode").val('');
					$("#txtListVatReasonName").val('');
					$("#txtListVatReasonCode").val('');
					$(".ExpendListNoTax").hide();
					$(".ExpendVatReason").hide();
				}
				break;
			case 'notax':
				if( $("#txtListNoTaxName").val() == '' ){
					$("#txtListNoTaxCode").val('');
					var tempAuth = JSON.parse($("#hidExpendListAuthInfo").val());
					teampAuth.noTaxCode = '';
					teampAuth.noTaxName = '';
					$("#hidExpendListAuthInfo").val(JSON.stringify(tempAuth));
					expendListAuth.noTaxCode = '';
					expendListAuth.noTaxName = '';
				}
				break;
			case 'vatreason':
				if( $("#txtListVatReasonName").val() == '' ){
					$("#txtListVatReasonCode").val('');
					var tempAuth = JSON.parse($("#hidExpendListAuthInfo").val());
					teampAuth.vaTypeCode = '';
					teampAuth.vaTypeName = '';
					$("#hidExpendListAuthInfo").val(JSON.stringify(tempAuth));
					expendListAuth.vaTypeCode = '';
					expendListAuth.vaTypeName = '';
				}
				break;
			case 'project':
				if( $("#txtListProjectName").val() == '' ){
					$("#txtListProjectCode").val('');
					expendList.projectSeq = 0;
					expendListProject = new kendo.data.ObservableObject(ExCodeProject);
					$("#hidExpendListProjectInfo").val('');
				}
				break;
			case 'card' :
				if( $("#txtListCardName").val() == '' ){
					$("#txtListCardCode").val('');
					expendList.cardSeq = 0;
					expendListCard = new kendo.data.ObservableObject(ExCodeCard);
					$("#hidExpendListCardInfo").val('');
				}
				break;
			case 'partner':
				/* ERPiU의 00거래처는 사용자가 거래처 명 입력 가능 2018. 03. 29 - 신재호 */
				if(ifSystem == 'ERPiU' && $("#txtListPartnerCode").val() == '00'){
					var tPartner = JSON.parse($("#hidExpendListPartnerInfo").val());
					tPartner.partnerName = $("#txtListPartnerName").val();
					$("#hidExpendListPartnerInfo").val(JSON.stringify(tPartner));
				}else if( $("#txtListPartnerName").val() == '' ){
					$("#txtListPartnerCode").val('');
					expendList.partnerSeq = 0;
					expendListPartner = new kendo.data.ObservableObject(ExCodePartner);
					$("#hidExpendListPartnerInfo").val('');
				}
				break;
			case 'budget':
				if( $("#txtListBudgetName").val() == '' ){
					$("#txtListBudgetCode").val('');
					$("#txtListBizplanName").val('');
					$("#txtListBizplanCode").val('');
					$("#txtListBgAcctName").val('');
					$("#txtListBgAcctCode").val('');
					expendList.budgetSeq = 0;
					expendListBudget = new kendo.data.ObservableObject(ExCodeBudget);
					expendListBudget.set('budgetYm', $('#txtExpendDate').val().toString().replace(/-/g, '').substring(0, 6));
					$("#hidExpendListERPiUBudgetInfo").val('');
				}
				break;
			case 'bizplan':
				if( $("#txtListBizplanName").val() == '' ){
					$("#txtListBizplanCode").val('');
					var tempBudget = JSON.parse($("#hidExpendListERPiUBudgetInfo").val());
					tempBudget.bizplanCode = '';
					tempBudget.bizplanName = '';
					$("#hidExpendListERPiUBudgetInfo").val(JSON.stringify(tempBudget));
					expendListBudget.bizplanCode = '';
					expendListBudget.bizplanName = '';
				}
				break;
			case 'bgacct':
				if( $("#txtListBgAcctName").val() == '' ){
					$("#txtListBgAcctCode").val('');
					var tempBudget = JSON.parse($("#hidExpendListERPiUBudgetInfo").val());
					tempBudget.bgacctCode = '';
					tempBudget.bgacctName = '';
					$("#hidExpendListERPiUBudgetInfo").val(JSON.stringify(tempBudget));
					expendListBudget.bgacctCode = '';
					expendListBudget.bgacctName = '';
				}
				break;
			default :
				break;
		}
	}

	// 외화입력 팝업
	function fnExForeignCurrencyInputPopup(){
	    var getParam = "?callback=fnApplyResultAmountCallback&type=list";
		var popParam = {};
		popParam.title = "${CL.ex_foreignCurrencyInput}";
		popParam.width = '';
		popParam.height = '';
		popParam.opener = '3';
		popParam.parentId = '';
		popParam.childId = '';
		popParam.getParam = getParam;
		var url = "<c:url value='/ex/user/expend/ExForeignCurrencyInputPopup.do'/>"+ popParam.getParam;

		var popupWidth = 500;
	    var popupHeight = 275;
	    var windowX = (screen.width - popupWidth)/2;
	    var windowY = (screen.height - popupHeight)/2;

		window.open(url,'ExForeignCurrencyInputPopup',"width=" + popupWidth + ", height=" + popupHeight + ", left=" + windowX + ",top=" + windowY);
	}

	// 외화계정인지 확인
    function fnCheckForeignCurrencyAcctCode(){
    	var param = {};

    	// 표준적요
    	var summaryInfo = JSON.parse($("#hidExpendListSummaryInfo").val() || '{}');
    	// 증빙유형
    	var authInfo = JSON.parse($("#hidExpendListAuthInfo").val() || '{}');

    	param.drAcctCode = (summaryInfo.drAcctCode || ""); // 차변계정
    	// 대변계정의 경우 증빙유형설정의 대변대체계정 값이 있는 경우 대변대체계정값을 우선시 하여 조회한다.
    	param.crAcctCode = ((authInfo.crAcctCode || "") == "") ? (summaryInfo.crAcctCode || "") : (authInfo.crAcctCode || ""); // 대변계정

    	$.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/user/expend/foreigncurrency/CheckForeignCurrencyAcctCode.do" />',
	        datatype : 'json',
	        async : false,
	        data : param,
	        success : function( data ) {
	        	if(data.aData.resultAcctCount > 0){
	        		isForeignCurrency = true;

	        		$("#txtListAmt, #txtListTaxAmt, #txtListStdAmt, #txtListSubTaxAmt, #txtListSubStdAmt").maskMoney('destroy').prop('readonly', true);
				}else{
					isForeignCurrency = false;
					// maskMoney 다시 활성화
            		$('#txtListStdAmt, #txtListSubStdAmt, #txtListTaxAmt, #txtListSubTaxAmt, #txtListAmt').maskMoney({
            			precision : 0,
            			allowNegative: isNegativeAmt
            		});
				}
	        },
	        error : function( data ) {
	            console.log(' [ * EXP]] Error ! >>>> ' + JSON.stringify(data));
	        }
	    });
	}

    // 금액 값 항목금액에 반영
	function fnApplyResultAmountCallback(value){
		$("#txtListAmt").val(value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

		if($("#chkAutoCalculation").is(":checked")){
			fnSetAmt("Amt");
		}
		expendList.set('stdAmt', ($('#txtListStdAmt').val()).toString().replace(/,/g, ''));
		expendList.set('taxAmt', ($('#txtListTaxAmt').val()).toString().replace(/,/g, ''));
		expendList.set('amt', ($('#txtListAmt').val()).toString().replace(/,/g, ''));
		expendList.set('subStdAmt',($('#txtListSubStdAmt').val()).toString().replace(/,/g, ''));
		expendList.set('subTaxAmt',($('#txtListSubTaxAmt').val()).toString().replace(/,/g, ''));
	}

</script>
<!-- <div class="com_ta2 scroll_y_on bg_lightgray" style="height: 333px;"> -->
<!-- 사용자 정보 -->
<input id="hidExpendListEmpInfo" class="ExpendList" type="hidden" />
<!-- 표준적요 정보 -->
<input id="hidExpendListSummaryInfo" class="ExpendList" type="hidden" />
<!-- 증빙유형 정보 -->
<input id="hidExpendListAuthInfo" class="ExpendList" type="hidden" />
<!-- 프로젝트 정보 -->
<input id="hidExpendListProjectInfo" class="ExpendList" type="hidden" />
<!-- 카드 정보 -->
<input id="hidExpendListCardInfo" class="ExpendList" type="hidden" />
<!-- 거래처 정보 -->
<input id="hidExpendListPartnerInfo" class="ExpendList" type="hidden" />
<!-- 불공제 정보 -->
<input id="hidExpendListNoTaxInfo" class="ExpendList" type="hidden" />
<!-- 예산 정보 -->
<input id="hidExpendListERPiUBudgetInfo" class="ExpendList" type="hidden" />
<!-- 사업계획 정보 -->
<input id="hidExpendListBizplanInfo" class="ExpendList" type="hidden" />
<!-- 예산계정 정보 -->
<input id="hidExpendListBgAcctInfo" class="ExpendList" type="hidden" />
<!-- 첨부파일 정보 -->
<input id="hidExpendListAttachInfo" class="ExpendList" type="hidden" />
<!-- 접대비 정보 -->
<input id="hidExpendListReceptInfo" class="ExpendList" type="hidden" />
<!-- 외화 정보 -->
<input id="hidExpendListForeignCurrencyInfo" class="ExpendList" type="hidden" />

<div class="pop_wrap_dir pop_auto_hei pop_wrap_dir_expend" style="position:fixed;" id="layerExpendList">
	<div class="pop_con div_form scroll_y_on">

		<div class="com_ta">
			<table>
				<colgroup>
					<col width="25%" />
					<col width="" />
				</colgroup>
				<tr class="">
					<th><img id="expendListReqSummary" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_standardOutline}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListSummaryCode" type="text" style="width: 22%;" readonly="readonly" disabled="disabled"/>
						<input id="txtListDrAcctName" type="text" style="width: 22%;" readonly="readonly" disabled="disabled"/>
						<input id="txtListSummaryName" type="text" style="width: 36%;ime-mode:active" placeholder='<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]' />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListSummarySearch">${CL.ex_find}</button>
							<button class ="BudgetCheck" id="btnListiCUBEBudgetChk" style="display: none;" >${CL.ex_budgetChk}</button>
						</div>
					</td>
				</tr>
				<!-- <tr class="ExpendListRecept" style="display: none;"> -->
					<%-- <th><img id="expendListReqRecept" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" /> --%>
						<%-- ${CL.ex_recept} --%>
					<!-- </th> -->
					<!-- <td class="dod_search" colspan="3"> -->
						<!-- <input id="txtListReceptCode" type="text" style="width: 22%;" readonly="readonly" disabled="disabled"/> -->
						<!-- <input id="txtListReceptName" type="text" style="width: 60%;" placeholder="코드도움 [F2, Enter]"/> -->
						<!-- <div class="controll_btn" style="padding: 0px;"> -->
							<%-- <button id="btnListReceptSearch">${CL.ex_find}</button> --%>
						<!-- </div> -->
					<!-- </td> -->
				<!-- </tr> -->
				<tr class="">
					<th><img id="expendListReqAuth" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_evidenceType}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListAuthCode" readonly="readonly" type="text" style="width: 22%;"  disabled="disabled"/>
						<input id="txtListAuthName" type="text" style="width: 60%;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListAuthSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListReqNoCash ExpendListERPiU ExpendListiCUBE">
					<th>
<%-- 						<img id="expendListReqNoCash" src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""/>  --%>
						${CL.ex_moneyApplyNm} <!--현금승인번호-->
					</th>
					<td colspan="3">
						<input id="txtListNoCash" type="text" style="width: 83%;" placeholder="${CL.ex_Maximum}"/>
					</td>
				</tr>
				<tr class="ExpendListReqNote">
					<th>
						<img id="expendListReqNote" src="<c:url value='/Images/ico/ico_check01.png'/>" alt=""/>
						${CL.ex_note}
					</th>
					<td colspan="3">
						<input id="txtListNote" type="text" style="width: 83%;"/>
						<div class="controll_btn" style="padding: 0px; display:none;">
							<button id="btnListReceptSearch">접대비</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListERPiU ExpendListiCUBE ExpendVatType" style="display: none;">
					<th>
						<img id="expendListReqVatType" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" style="display: none;"/>
						${CL.ex_classificationTax}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListVatTypeCode" type="text" style="width: 22%;" readonly="readonly"  disabled="disabled"/>
						<input id="txtListVatTypeName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListVatSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListiCUBE ExpendVatReason">
					<th>
						<img id="expendListReqVaType" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_reasonType}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListVatReasonCode" type="text" style="width: 22%;" readonly="readonly"  disabled="disabled"/>
						<input id="txtListVatReasonName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]"/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListVaSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListTax">
					<c:choose>
						<c:when test="${ViewBag.ifSystem == 'ERPiU'}">
							<th>
								<%=BizboxAMessage.getMessage("","전자(세금)계산서")%>
							</th>
							<td colspan="3"><input type="checkbox" name="etaxYN" id="etaxYN" class="k-checkbox" />
							<label class="k-checkbox-label" for="etaxYN" style="margin: 0px;"><%=BizboxAMessage.getMessage("","전자(세금)계산서 여부")%></label>
							<span class="ml10" id="divEtaxSendYN">
								<input type="checkbox" name="etaxSendYN" id="etaxSendYN" class="k-checkbox" /> <label class="k-checkbox-label" for="etaxSendYN" id="lEtaxSendYN" style="margin: 0 0 0 10px;"><%=BizboxAMessage.getMessage("TX000007526","국세청 전송 11일 이내")%></label>
							</span>
							</td>
						</c:when>
						<c:when test="${ViewBag.ifSystem == 'iCUBE'}">
							<th>
								<%=BizboxAMessage.getMessage("TX000007529","전자세금계산서")%>
							</th>
							<td colspan="3"><input type="checkbox" name="etaxYN" id="etaxYN" class="k-checkbox" />
							<label class="k-checkbox-label" for="etaxYN" style="margin: 0px;"><%=BizboxAMessage.getMessage("TX000007540","전자세금계산서 여부")%></label>
							<span class="ml10" id="divEtaxSendYN">
								<input type="checkbox" name="etaxSendYN" id="etaxSendYN" class="k-checkbox" /> <label class="k-checkbox-label" for="etaxSendYN" id="lEtaxSendYN" style="margin: 0 0 0 10px;"><%=BizboxAMessage.getMessage("TX000007526","국세청 전송 11일 이내")%></label>
							</span>
							</td>
						</c:when>
					</c:choose>

				</tr>
				<tr class="ExpendListERPiU ExpendListNoTax">
					<th>
						<img id="expendListReqNoTax" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_noType}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListNoTaxCode" type="text" style="width: 22%;" readonly="readonly"  disabled="disabled"/>
						<input id="txtListNoTaxName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2]"/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListNoTaxSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListERPiU ExpendListErpAuth">
					<th>
						<!-- <img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />  -->
						${CL.ex_evidence}
					</th>
					<td class="dod_search" colspan="3">
						<input type="text" style="width: 22%;" />
						<input type="text" style="width: 60%;" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListErpAuthSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="">
					<th>
						<img id="expendListReqAuthDate" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_evidenceDate}
					</th>
					<td colspan="3">
						<input id="txtListAuthDate" value="" class="dpWid" placeholder="____-__-__"/>
					</td>
				</tr>
				<tr class="ExpendListBizboxA ExpendListiCUBE ExpendListERPiU ExpendListEmp" style="display: none;">
					<th>
						<!-- <img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />  -->
						${CL.ex_user}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListEmpCode" readonly="readonly" type="text" style="width: 22%;"  disabled="disabled"/>
						<input id="txtListEmpName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]""/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListEmpSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListBizboxA ExpendListiCUBE ExpendListERPiU ExpendListEmp" style="display: none;">
					<th>
						<!-- <img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />  -->
						${CL.ex_useDepartment}
					</th>
					<td colspan="3">
						<input id="txtListDeptCode" type="text" readonly="readonly" style="width: 22%;"  disabled="disabled"/>
						<input id="txtListDeptName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]""/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListDeptSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<%-- <tr class="ExpendListERPiU ExpendListEmp ExpendListCCPC" style="display: none;">
					<th>
						${CL.ex_accountingUnit}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListPcCode" readonly="readonly" type="text" style="width: 22%;"  disabled="disabled"/>
						<input id="txtListPcName" type="text" style="width: 60%;"  placeholder="코드도움 [F2]"/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListPcSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr> --%>
				<tr class="ExpendListERPiU ExpendListEmp ExpendListCCPC" style="display: none;">
					<th>
						<!-- <img src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />  -->
						${CL.ex_costCenter}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListCcCode" readonly="readonly" type="text" style="width: 22%;"  disabled="disabled"/>
						<input id="txtListCcName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]""/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListCcSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>

				<tr class="ExpendListERPiU ExpendListiCUBE ExpendListProject" style="display: none;">
					<th>
						<img id="expendListReqProject" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_project}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListProjectCode" type="text" style="width: 22%;" readonly="readonly"  disabled="disabled"/>
						<input id="txtListProjectName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]""/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListProjectSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListERPiU ExpendListiCUBE ExpendListCard" style="display: none;">
					<th>
						<img id="expendListReqCard" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_card}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListCardCode" readonly="readonly" type="text" style="width: 22%;"  disabled="disabled"/>
						<input id="txtListCardName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]""/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListCardSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListERPiU ExpendListiCUBE ExpendListPartner" style="display: none;">
					<th>
						<img id="expendListReqPartner" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_vendor}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListPartnerCode" type="text" style="width: 22%;" readonly="readonly"  disabled="disabled"/>
						<input id="txtListPartnerName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]""/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListPartnerSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListERPiU ExpendListBudget ExpendListReqBudget" style="display: none;">
					<th>
						<img id="expendListReqBudget" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_budgetUnit}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListBudgetCode" type="text" style="width: 22%;" readonly="readonly"  disabled="disabled"/>
						<input id="txtListBudgetName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]"/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListBudgetSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListERPiU ExpendListBudget ExpendListReqBizplan" style="display: none;">
					<th>
						<img id="expendListReqBizplan" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_businessPlan}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListBizplanCode" type="text" style="width: 22%;" readonly="readonly"  disabled="disabled"/>
						<input id="txtListBizplanName" type="text" style="width: 60%;"  placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]"/>
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListBizplanSearch">${CL.ex_find}</button>
						</div>
					</td>
				</tr>
				<tr class="ExpendListERPiU ExpendListBudget ExpendListReqBgAcct" style="display: none;">
					<th>
						<img id="expendListReqBgAcct" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_budgetAccount}
					</th>
					<td class="dod_search" colspan="3">
						<input id="txtListBgAcctCode" type="text" style="width: 22%;" readonly="readonly"  disabled="disabled"/>
						<input id="txtListBgAcctName" type="text" style="width: 60%;" placeholder="<%=BizboxAMessage.getMessage("TX000016475","코드도움")%> [F2, Enter]" />
						<div class="controll_btn" style="padding: 0px;">
							<button id="btnListBgAcctSearch">${CL.ex_find}</button>
							<button class ="ExpendListERPiU BudgetCheck" id="btnListERPiUBudgetChk" style="display: none;" >${CL.ex_budgetChk}</button>
						</div>
					</td>
				</tr>
				<tr class="">
					<th>
						<img id="expendListReqAmt" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_amountSupply}
					</th>
					<td colspan="3">
						<input id="txtListAmt" type="text" style="width: 29%;" value="0" maxlength="15" class="fl" />
						<div id="divBudgetInfo" class="fl fwb mt6 ml5"></div>
						<div style="margin-top: 5px; margin-left: 13px;vertical-align: middle;">
							<input id="chkAutoCalculation" type="checkbox" style="margin-right: 8px;" class="k-checkbox" checked="checked"/>
								<label class="k-checkbox-label" for="chkAutoCalculation" style="margin: 0 0 0 10px;">${CL.ex_BudgetAutoCal} <!--금액 자동 계산--></label>
						</div>
					</td>
				</tr>
				<tr class="">
					<th>
						<img id="expendListReqTaxAmt" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_additionalTaxAmount}
					</th>
					<td>
						<input id="txtListTaxAmt" type="text" style="width: 81%;" value="0" maxlength="15" />
					</td>
					<th id="thListSubTaxAmt" class=''>
						<img id="expendListSubTaxAmt" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_taxAmount}
					</th>
					<td id="tdListSubTaxAmt" class=''>
						<input id="txtListSubTaxAmt" type="text" style="width: 81%;" value="0" maxlength="15" />
					</td>
				</tr>
				<tr class="">
					<th>
						<img id="expendListReqSubStdAmt" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_purPrice}
					</th>
					<td>
						<input id="txtListStdAmt" type="text" style="width: 81%;" value="0" maxlength="15" />
					</td>
					<th id="thListSubStdAmt" class=''>
						<img id="expendListSubStdAmt" src="<c:url value='/Images/ico/ico_check01.png'/>" alt="" />
						${CL.ex_standardImposition}
					</th>
					<td id="tdListSubStdAmt" class=''>
						<input id="txtListSubStdAmt" type="text" style="width: 81%;" value="0" maxlength="15" />
					</td>
				</tr>
				<tr class="trListExtStr">
					<th>
						${CL.ex_extendStr1}
					</th>
					<td>
						<input id="txtListExtendStr1" type="text" style="width: 81%;" maxlength="64" />
					</td>
					<th>
						${CL.ex_extendStr2}
					</th>
					<td>
						<input id="txtListExtendStr2" type="text" style="width: 81%;" maxlength="64" />
					</td>
				</tr>
			</table>
		</div>
		<!-- 첨부파일 -->
		<iframe id="uploaderView" src="/gw/ajaxFileUploadProcView.do?uploadMode=U&pathSeq=1400" style="width: 100%; height: 181px;"></iframe>
	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">

			<button id="btnListSave">${CL.ex_save}</button>
   			<button id="btnListClose" class="gray_btn">${CL.ex_cancel}</button>
			<c:set var="EXP_iCUBE" value="EXP_iCUBE"/>
			<c:if test="${ViewBag.compSeq == EXP_iCUBE}">
<!-- 				<input id="btnListContinusSave" type="button" class="slipButton" value="다음 작성" title="shift + enter"/> -->
				<button id="btnListContinusSave" class="slipButton" title="shift + enter">${CL.ex_NextWrite} <!--다음작성--></button>
			</c:if>
		</div>
	</div>
	<!-- //pop_foot -->
</div>
<!--// pop_wrap -->