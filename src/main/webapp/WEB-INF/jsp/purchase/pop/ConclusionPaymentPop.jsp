<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<jsp:useBean id="currentTime" class="java.util.Date" />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>대금지급</title>

    <!--css-->
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/common.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/re_pudd.css' />">
	<link rel="stylesheet" type="text/css" href="<c:url value='/customStyle/css/animate.css' />">
	    
    <!--js-->
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/pudd/pudd-1.1.200.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/jquery-1.9.1.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:url value='/customStyle/Scripts/jqueryui/jquery-ui.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/common.js' />"></script>
    <script type="text/javascript" src="<c:url value='/customStyle/Scripts/customUtil.js' />"></script>  
    <script type="text/javascript" src="<c:url value='/js/jquery.maskMoney.js' />"></script>  
    
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/UserOptionMap.jsp" flush="false" />	
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/NpUserResPop.jsp" flush="false" />	
	
	<script type="text/javascript">
	
	var resDocSeq = "";
	var resSeq = "";
	var budgetSeq = "";
	
	var parameter = {};
	
	var eaBaseInfo = ${eaBaseInfo};
	
	$(document).ready(function() {
		
		fnGetListBind();
		
		$(window).resize(function () {
			gridHeightChange( 380 );// 개발시 맞게 사이즈조정해주어야함
	
		});		

	});//---documentready끝		
		
	
	function fnPaymentCreate(){
		
		fnResDocInsert();
		
	}
	
	function fnPaymentExpendCreatePop(){
		
		openWindow2("${pageContext.request.contextPath}/expend/np/user/NpUserCRDocPop.do?formSeq=${formSeq}&docId=&approKey=EXNPRESI_NP_" + resDocSeq,  "ConclusionExpendCreatePop", 1200, 800, 1, 1) ;
		
	}	
	
	function fnPaymentComplete(){
		
	}		
	
	
	function fnResDocInsert() {
		/* [ parameter ] */
		parameter = {};

		parameter.resNote = ''; /* 결의문서 적요 */
		parameter.erpCompSeq = ''; /* ERP 회사 코드 */
		parameter.erpDivSeq = ''; /* ERP 사업장 명칭 */
		parameter.erpDivName = ''; /* ERP 사업장 명칭 */
		parameter.erpDeptSeq = ''; /* ERP 부서 코드 */
		parameter.erpEmpSeq = ''; /* ERP 사원 코드 */
		parameter.erpGisu = ''; /* ERP 기수 */
		parameter.erpExpendYear = ''; /* ERP 회계 연도 */
		parameter.compSeq = ''; /* GW 회사 코드 */
		parameter.compName = ''; /* GW 회사 명칭 */
		parameter.deptSeq = ''; /* GW 부서 코드 */
		parameter.deptName = ''; /* GW 부서 명칭 */
		parameter.empSeq = ''; /* GW 사용자 코드 */
		parameter.empName = ''; /* GW 사용자 명칭 */
		parameter.formSeq = eaBaseInfo[0].formSeq; /* 전자결재 양식 코드 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		/* 외부연동 ( 전용개발 또는 내부 개발 항목 - 근태 등 ) */
		parameter.outProcessInterfaceId = '${outProcessInterfaceId}';
		parameter.outProcessInterfaceMId = '${outProcessInterfaceMId}';
		parameter.outProcessInterfaceDId = '${outProcessInterfaceDId}';

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/ex/np/user/res/ResDocInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {

				/* 결의 정보 저장 */
				var aData = Option.Common.GetResult(result, 'aData');
				optionSet.resDocInfo = aData;

				if (aData) {
					resDocSeq = aData.resDocSeq;
					fnResInsert();
				} else {
					resDocSeq = '';
					msgSnackbar("error", "결의서 연동데이터(ResDoc) 생성 실패");
				}
			},
			/*   - error :  */
			error : function(result) {
				msgSnackbar("error", "결의서 연동데이터(ResHead) 생성 실패");
			}
		});

		/* [ return ] */
		return;
	}	
	
	function fnResInsert() {

		parameter.resDocSeq = resDocSeq; /* [*]결의문서 키 */
		parameter.docuFgCode = '1'; /* [*]결의구분코드 */
		parameter.docuFgName = '지출결의서'; /* [*]결의구분명칭 */

		parameter.erpPcSeq = ''; /* ERP PC코드 */
		parameter.erpPcName = ''; /* ERP PC명칭 */
		parameter.resNote = ''; /* [*]결의서적요(결의내역) */
		parameter.resDate = '2022-12-12'; /* [*]결의일자(발의일자) */
		parameter.expendDate = '2022-12-13'; /* [*]결의일자(발의일자) */
		
		parameter.btrSeq = ''; /* [*]입출금계좌코드 */
		parameter.btrName = ''; /* [*]입출금계좌명칭 */
		parameter.btrNb = ''; /* [*]입출금계좌 */

		parameter.erpDivSeq = ''; /* ERP 회계단위코드 */
		parameter.erpDivName = ''; /* ERP 회계단위명칭 */
		parameter.erpMgtSeq = '8203'; /* [*]부서/프로젝트 코드 */
		parameter.erpMgtName = '하위사업용'; /* [*]부서/프로젝트 명칭 */
		parameter.bottomSeq = ''; /* [*]하위사업코드 */
		parameter.bottomName = ''; /* [*]하위사업명칭 */		

		parameter.erpEmpSeq = ''; /* ERP 사원코드 */
		parameter.erpEmpName = ''; /* ERP 사원명 */
		parameter.erpDeptSeq = ''; /* GW 부서코드 */
		parameter.erpDeptName = ''; /* GW 부서명칭 */
		parameter.erpCompSeq = ''; /* ERP 회사코드 */
		parameter.erpCompName = ''; /* ERP 회사명칭 */		
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		
		parameter.empSeq = ''; /* GW 사용자코드 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		
		parameter.erpGisu = ''; /* ERP 기수 */
		parameter.erpGisuFromDate = ''; /* ERP 기수시작일 */
		parameter.erpGisuToDate = ''; /* ERP 기수종료일 */		
		parameter.erpYear = ''; /* ERP 회계연도 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/ex/np/user/res/ResHeadInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resDate, erpMgtSeq, erpMgtName, docuFgCode, docuFgName, resNote, erpCompSeq, erpCompName, erpPcSeq, erpPcName, erpEmpSeq, erpEmpName, erpDivSeq, erpDivName, erpDeptSeq, erpDeptName, erpGisu, erpGisuFromDate, erpGisuToDate, erpYear, btrSeq, bottomSeq, btrNb, btrName, bottomName, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					resSeq = (aData.resSeq || '').toString();
					fnBudgetInsert();
				} else if(resultCode == 'GISU_CLOSE'){
					resSeq = '';
					msgSnackbar("error", "기수 마감되어 결의서를 입력할 수 없습니다.");
				} else {
					resSeq = '';
					msgSnackbar("error", "결의서 연동데이터(ResHead) 생성 실패");
				}
			},
			/*   - error :  */
			error : function(result) {
				msgSnackbar("error", "결의서 연동데이터(ResHead) 생성 실패");
			}
		});

		/* [ return ] */
		return;
	}
	
	function fnBudgetInsert() {

		parameter.resDocSeq = resDocSeq; /* [*]결의문서 키 */
		parameter.resSeq = resSeq; /* [*]결의서 키 */
		
		parameter.erpBqSeq = ''; /* [*]ERP 연동 품의서 키 */
		parameter.erpBkSeq = ''; /* [*]ERP 연동 품의 예산 키 */
		parameter.erpBizplanSeq = ''; /* [*]ERP 사업계획 코드 */
		parameter.erpBizplanName = ''; /* [*]ERP 사업계획 명칭 */		
		
		parameter.erpDivSeq = ''; /* ERP 회계단위 코드 */
		parameter.erpDivName = ''; /* ERP 회계단위 명칭 */			
		parameter.erpBudgetDivSeq = '1000';
		parameter.erpBudgetDivName = '비영리TEST';		
		
		parameter.erpBudgetSeq = '10000082'; /* [*]ERP 예산과목 코드 (예산단위 코드) */
		parameter.erpBudgetName = '수용비'; /* [*]ERP 예산과목 명칭 (예산단위 명칭) */
		
		parameter.erpFiacctName = '도서인쇄비'; /* [*]ERP 회계계정 코드 */
		parameter.erpFiacctSeq = '82600'; /* [*]ERP 회계계정 명칭 */
		
		parameter.erpBgt1Name = '사업비'; /* [*]관 명칭 */
		parameter.erpBgt1Seq = '10000000'; /* [*]관 코드 */
		parameter.erpBgt2Name = '사업예산과 복식부기 회계교육'; /* [*]항 명칭 */
		parameter.erpBgt2Seq = '10000080'; /* [*]항 코드 */
		parameter.erpBgt3Name = '수용비'; /* [*]목 명칭 */
		parameter.erpBgt3Seq = '10000082'; /* [*]목 코드 */
		parameter.erpBgt4Name = ''; /* [*]세 명칭 */
		parameter.erpBgt4Seq = ''; /* [*]세 코드 */
		
		parameter.erpOpenAmt = '0'; /* [*]ERP 예산 편성 금액 */
		parameter.erpApplyAmt = '0'; /* [*]ERP 집행액 */
		parameter.erpLeftAmt = '0'; /* [*]ERP 잔액 */
		
		parameter.budgetStdAmt = '0'; /* [*]공급가액 */
		parameter.budgetTaxAmt = '0'; /* [*]부가세 */
		parameter.budgetAmt = '0'; /* [*]총금액 */
		
		parameter.erpBgacctSeq = ''; /* [*]예산 계정 코드 */
		parameter.erpBgacctName = ''; /* [*]예산 계정 명칭 */
		
		parameter.setFgCode = '4'; /* [*]결제수단 코드 */
		parameter.setFgName = '신용카드'; /* [*]결제수단 명칭 */
		parameter.vatFgCode = '1'; /* [*]과세구분 코드 */
		parameter.vatFgName = '과세'; /* [*]과세구분 명칭 */
		parameter.trFgCode = '1'; /* [*]채주유형 코드 */
		parameter.trFgName = '거래처등록'; /* [*]재추유형 명칭 */
		
		parameter.ctlFgCode = ''; /* [*]미사용? */
		parameter.ctlFgName = ''; /* [*]미사용? */
		parameter.budgetNote = ''; /* [*]예산 적요 */
		

		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpEmpInfo()))); /* ERP 사용자 정보 저장 */
		
		parameter.empSeq = ''; /* GW 사용자코드 */
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetGwEmpInfo()))); /* GW 사용자 정보 저장 */
		
		parameter = JSON.parse(JSON.stringify($.extend(parameter, Option.Common.GetErpGisuInfo()))); /* ERP 기수 정보 저장 */

		parameter.erpGisuDate = '';
		parameter.expendDate = '';

		/* 부가세 통제 여부 체크 */
		if (optionSet.erpEmpInfo.vatControl == '1' || (budgetData.trFgCode=='4' || budgetData.trFgCode=='8' || budgetData.trFgCode=='9')){
			parameter.ctlFgCode = '1';
			parameter.ctlFgName = 'I_IN_TAX_Y';
		}else {
			parameter.ctlFgCode = '0';
			parameter.ctlFgName = 'I_IN_TAX_N';
		}

		/* [DB] INT 형 파라미터 데이터 보정 */
		parameter = fnBudgetDataCurrection(parameter);


		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/ex/np/user/res/ResBudgetInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resSeq, erpBqSeq, erpBkSeq, erpBudgetSeq, erpBudgetName, erpBizplanSeq, erpBizplanName, erpBgt1Name, erpBgt1Seq, erpBgt2Name, erpBgt2Seq, erpBgt3Name, erpBgt3Seq, erpBgt4Name, erpBgt4Seq, erpOpenAmt, erpApplyAmt, erpLeftAmt, budgetStdAmt, budgetTaxAmt, budgetAmt, erpBgacctSeq, erpBgacctName, setFgCode, setFgName, vatFgCode, vatFgName, trFgCode, trFgName, ctlFgCode, ctlFgName, budgetNote, erpDivSeq, erpDivName, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			/*   - success :  */
			success : function(result) {

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 예산정보 갱신 ( 금회집행 ) */
					//$('#lbBudgetAmt').html(Option.Common.GetNumeric(aData.tryAmt || '0'));
					budgetSeq = (aData.budgetSeq || '').toString();
					
					fnTradeInsert();
					

				} else if (resultCode === 'EXCEED') {
					msgSnackbar("error", "${CL.ex_exceedMesage}");
				} else {
					msgSnackbar("error", "결의서 연동데이터(ResBudget) 생성 실패");
				}
			},
			/*   - error :  */
			error : function(result) {
				msgSnackbar("error", "결의서 연동데이터(ResBudget) 생성 실패");
			}
		});

		/* [ return ] */
		return;
	}
	
	
	
	
	
	function fnTradeInsert() {

		parameter.budgetSeq = budgetSeq; /* [*]예산 키 */
		
		parameter.erpIsuDt = ''; /* G20 연동 키 */
		parameter.erpIsuSq = ''; /* G20 연동 키 */
		parameter.erpInSq = ''; /* G20 연동 키 */
		parameter.erpBqSq = ''; /* G20 연동 키 */
		parameter.itemName = ''; /* [*]물품명 */
		parameter.itemCnt = ''; /* [*]수량 */
		
		parameter.divSeq = parameter.erpDivSeq;
		parameter.divName = parameter.erpDivName;		

		parameter.trSeq = '10-4949'; /* [*]거래처 코드 */
		parameter.trName = '검수테스트'; /* [*]거래처 명칭 */
		
		parameter.ceoName = '대표자명'; /* [*]대표자 명칭 */
		
		parameter.tradeAmt = '1000000'; /* [*]금액 */
		parameter.tradeStdAmt = '909090'; /* [*]공급가액 */
		parameter.tradeVatAmt = '90910'; /* [*]부가세 */
		
		parameter.jiroSeq = ''; /* 미사용? */
		parameter.jiroName = ''; /* 미사용? */
		parameter.baNb = ''; /* [*]계좌 번호 */
		parameter.btrSeq = ''; /* [*]금융기관 코드 */
		parameter.btrName = ''; /* [*]금융기관 명 */
		parameter.depositor = ''; /* [*]예금주 */
		parameter.tradeNote = ''; /* [*]채주 비고 */
		
		parameter.ctrSeq = ''; /* 법인카드 - 카드거래처 */
		parameter.ctrName = ''; /* 법인카드 - 카드거래처 */
		
		parameter.regDate = ''; /* [*]신고 기준일 */
		parameter.interfaceType = ''; /* 미사용? */
		parameter.interfaceSeq = ''; /* 미사용? */

		/* 회계단위 통제 */
		parameter.noTaxCode = '';
		parameter.noTaxName = '';
		if(!parameter.etcBelongDate) { parameter.etcBelongDate = ''; }
		if(!parameter.etcBelongYearmonth) { parameter.etcBelongYearmonth = ''; }

		parameter.tradeNote = parameter.tradeNote.replaceAll('\\','');
		if((parameter.interfaceType||'')=='etax'){
			parameter.trSeq = '';
		}

		/* int파라미터 데이터 보정 진행 */
		parameter = fnTradeDataCurrection(parameter);
		parameter.baNb = parameter.baNb.replace("'","");
		/* [ ajax ] */
		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/ex/np/user/res/ResTradeInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resSeq, budgetSeq, erpIsuDt, erpIsuSq, erpInSq, erpBqSq, itemNm, itemCnt, empNm, trSeq, trName, ceoName, tradeAmt, tradeStdAmt, tradeVatAmt, jiroSeq, jiroName, baNb, btrSeq, btrName, depositor, tradeNote, ctrSeq, ctrName, regDate, interfaceType, interfaceSeq, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			extendParam : {
				resSeq : parameter.resSeq,
				budgetSeq : parameter.budgetSeq,
				tradeAmt : parameter.tradeAmt,
				tradeStdAmt : parameter.tradeStdAmt,
				tradeVatAmt : parameter.tradeVatAmt
			},
			/*   - success :  */
			success : function(result) {

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					fnPaymentExpendCreatePop();
				} else if (resultCode === 'EXCEED') {
					msgSnackbar("error", "${CL.ex_exceedMesage}");
				} else {
					msgSnackbar("error", "결의서 연동데이터(ResTrade) 생성 실패");
				}
			},
			/*   - error :  */
			error : function(result) {
				msgSnackbar("error", "결의서 연동데이터(ResTrade) 생성 실패");
			}
		});

		/* [ return ] */
		return;
	}	
	
	
	
	
	
	
	
	
	function fnTradeDataCurrection(parameter){
		parameter.etcRequiredAmt = parameter.etcRequiredAmt || '0';
		parameter.etcIncomeAmt = parameter.etcIncomeAmt || '0';
		parameter.etcIncomeVatAmt = parameter.etcIncomeVatAmt || '0';
		parameter.etcResidentVatAmt = parameter.etcResidentVatAmt || '0';
		parameter.etcEmploymentAmt = parameter.etcEmploymentAmt || '0';
		parameter.etcEmploymentInsuranceAmt = parameter.etcEmploymentInsuranceAmt || '0';
		parameter.etcSchoolAmt = parameter.etcSchoolAmt || '0';
		parameter.salaryAmt = parameter.salaryAmt || '0';
		parameter.salaryStdAmt = parameter.salaryStdAmt || '0';
		parameter.salaryIncomeVatAmt = parameter.salaryIncomeVatAmt || '0';
		parameter.salaryResidentVatAmt = parameter.salaryResidentVatAmt || '0';
		parameter.salaryEtcAmt = parameter.salaryEtcAmt || '0';
		parameter.erpInSq = parameter.erpInSq || '0';
		parameter.erpBqSq = parameter.erpBqSq || '0';
		parameter.tradeAmt = parameter.tradeAmt || '0';
		parameter.tradeStdAmt = parameter.tradeStdAmt || '0';
		parameter.tradeVatAmt = parameter.tradeVatAmt || '0';

		return parameter;
	}	
	
	
	
	
	
	
	
	function fnBudgetDataCurrection(parameter){
		parameter.budgetNote = parameter.budgetNote.replaceAll('\\','');
		parameter.erpBqSeq = parameter.erpBqSeq || '0';
		parameter.erpBkSeq = parameter.erpBkSeq || '0';
		parameter.budget_std_amt = parameter.budget_std_amt || '0';
		parameter.budgetStdAmt = parameter.budgetStdAmt || '0';
		parameter.budgetVatAmt = parameter.budgetVatAmt || '0';
		parameter.budget_tax_amt = parameter.budget_tax_amt || '0';
		parameter.budgetTaxAmt = parameter.budgetTaxAmt || '0';
		parameter.budgetAmt = parameter.budgetAmt || '0';
		parameter.amt = parameter.amt || '0';
		parameter.itemAmt = parameter.itemAmt || '0';
		parameter.confferDocSeq = parameter.confferDocSeq || undefined;
		return parameter;
	}	
		
	function gridHeightChange( minusVal ) {
		var puddGrid = Pudd( "#grid1" ).getPuddObject();
		var cHeight = document.body.clientHeight;

		var newGridHeight = cHeight - minusVal;
		if( newGridHeight > 100 ) {// 최소높이
			puddGrid.gridHeight( newGridHeight );
		}
	}		
	
	function fnGetListBind(){

		var reqParam = {};
		
		reqParam.stat = "";
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/SelectConclusionPaymentList.do" />',
			datatype : 'json',
			data : reqParam,
			async : false,
			success : function(result) {
				gridRender(result.resultList);
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});
		
		gridHeightChange( 380 );// 개발시 맞게 사이즈조정해주어야함
		
	}		
	
	function gridRender(listData){
		
		var dataSource = new Pudd.Data.DataSource({
			data : listData	// 직접 data를 배열로 설정하는 옵션 작업할 것
		,	pageSize : 1000	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
		,	serverPaging : false
		});

		Pudd("#grid1").puddGrid({
			dataSource : dataSource
		,	scrollable : true
		, 	pageSize : 10	// grid와 연동되는 경우 grid > pageable > pageList 배열값 중의 하나이여야 함
		,	serverPaging : true			
		,	pageable : {
				buttonCount : 10 
			,	pageList : [ 10, 20, 30, 40, 50 ]
			}
		,	columns : [
				{
						field : "doc_no"
					,	title : "문서번호"
					,	width : 130
					,	content : {
							attributes : { class : "text_line text_ho" }
					}
				}
				,	{
						field : "pay_type"
					,	title : "지급구분"
					,	width : 100							
				}
				,	{
						field : "pay_num"
					,	title : "지급차수"
					,	width : 90							
				}
				,	{
						field : "doc_title"
					,	title : "결의제목"
					,	width : 300
					,	content : {
							attributes : { class : "le ellipsis" }
					}
				}
				,	{
						field : "write_dt"
					,	title : "기안일자"
					,	width : 100
				}
			,	{
						field : "amt"
					,	title : "결의금액"
					,	width : 120
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "remain_amt"
					,	title : "잔여금액"
					,	width : 120
					,	content : {
							attributes : { class : "ri" }
					}
				}
			,	{
						field : "doc_sts"
					,	title : "결재상태"
					,	width : 100
				}
			]
		});			
		
	}			
	

		
	</script>
</head>

<body>
<div class="pop_wrap" style="min-width:998px;">
	<div class="pop_sign_head posi_re">
		<h1>대금지급</h1>
	</div>

	<div class="pop_con" style="overflow: auto; min-height: 460px;">
	
					<!-- 상세검색 -->
            		<div class="top_box">
						<dl>
							<dt class="ar" style="width:60px;">기안일자</dt>
							<dd>
								<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/> ~
								<input type="text" value="2018-03-30" class="puddSetup" pudd-type="datepicker"/>
							</dd>							
							<dd><input onclick="fnGetListBind();" type="button" class="puddSetup submit" id="searchButton" value="검색" /></dd>
						</dl>
					</div>
					

					<div class="sub_contents_wrap posi_re">
						<!-- 연차생성 -->
						<div class="btn_div">
							<div class="left_div">							
								<h5>계약명 : ${contractDetailInfo.c_title}</h5>								
							</div>
							<div class="right_div">
								<div id="" class="controll_btn p0">
									<input onclick="fnPaymentCreate();" type="button" class="puddSetup" value="대금지급" />
									<input onclick="fnPaymentComplete();" type="button" class="puddSetup" value="대금지급완료" />
								</div>
							</div>
						</div>
						
						<div class="dal_Box">
							<div class="dal_BoxIn posi_re">
								<div id="grid1"></div>
							</div>
						</div>
						
					</div><!-- //sub_contents_wrap -->
	
	
	
		
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->
</body>
</html>