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
    <script type="text/javascript" src="<c:url value='/js/neos/NeosUtil.js' />"></script>
    
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/UserOptionMap.jsp" flush="false" />	
	<jsp:include page="/WEB-INF/jsp/expend/np/user/include/NpUserResPop.jsp" flush="false" />	
	
	<script type="text/javascript">
	
	var resDocSeq = "";
	var resSeq = "";
	var budgetSeq = "";
	
	var parameter = {};
	
	var eaBaseInfo = ${eaBaseInfo};
	
	$(document).ready(function() {
		
		BindGrid();

	});		
	
	//결재선보기 
	function openPopApprovalLinePudd(e){
		var diKeyCode = e.C_DIKEYCODE ;
		var param = "diKeyCode="+diKeyCode;

		return '<span class="ico-blank" onClick="neosPopup(\'POP_APPLINE\', \''+param+'\');"></span>';
	} 
	
	function ncCom_Empty(argStr){
		if (!argStr) return true;
		if (argStr.length == 0) return true;
		if(typeof(argStr) == "undefined")  return true ;
		if(argStr == "undefined")  return true ;	
		if(argStr == "null") return true ;
		
		for (var i = 0; i<argStr.length; i++) {
	 		if ( (" " == argStr.charAt(i)) || ("　" == argStr.charAt(i)) )  {	}
			else return false;
		}
		return true;
	}	
	
	function TextOverFlowApp(e){
		
		var C_RIDELETEOPT = "";
		if(!ncCom_Empty(e.C_RIDELETEOPT)){
			C_RIDELETEOPT = e.C_RIDELETEOPT;
		}
		
		var c_dititle = e.C_DITITLE.replace(/</gi, "&lt;").replace(/>/gi, "&gt;"); 
			
		var title = "<span onClick='titleOnClickApp(\"" + e.C_DIKEYCODE +"\", \"" + e.C_MISEQNUM +"\", \"" + e.C_DISEQNUM +"\" , \"" + e.C_RIDELETEOPT +"\", \"" + e.C_TIFORMGB +"\", \"" + e.C_DISTATUS +"\")' style='cursor:pointer; ' >";
		if(e.AUDITCOUNT > 0){
			  title += "<img src='/ea/Images/ico/ico_gamsa.png' title='"+ NeosUtil.getMessage("TX000020865","감사문서") +"'/> ";
		}
		if(e.C_DISECRETGRADE == "009"){
			  title += "<img src='"+_g_contextPath_ +"/Images/ico/ico_security.png' title='"+ NeosUtil.getMessage("TX000008484","보안문서") +"'/> ";
		}
		if(e.C_DIDOCGRADE == "002"){
			  title += "<img src='"+_g_contextPath_ +"/Images/ico/ico_emergency.png' title='"+ NeosUtil.getMessage("TX000009230","긴급문서") +"'/> ";
		}
		
		if(e.SUBAPPROV == "Y"){
			  title += "<img src='"+_g_contextPath_ +"/Images/ico/ico_proxy.png' title='"+ NeosUtil.getMessage("TX000002949","대결") +"'/> ";
		}
		if(e.DOCCOUNT > 1){
			  title += "<img src='"+_g_contextPath_ +"/Images/ico/ico_draft.png' title='"+ NeosUtil.getMessage("TX000021117","일괄기안") +"'/> ";
		}
		
	    if(C_RIDELETEOPT == "d"){
	    	title += "<a href=\"javascript:;\" class=\"text_red\">" + c_dititle +"</a>";
	    }else{
	    	title += "<a href=\"javascript:;\">" + c_dititle +"</a>";
	    }
		
		title +="</span>";
		
		return  title ;
	}	
	
	
	function titleOnClickApp(c_dikeyCode, c_miseqnum, c_diseqnum, c_rideleteopt, c_tifogmgb, c_distatus){
		
		if(c_rideleteopt =='d'){
			fnPuddDiaLog("warning", NeosUtil.getMessage("TX000009232","삭제된 문서는 열수 없습니다"));
			return;
		}
		var obj = {
				diSeqNum  : c_diseqnum,
				miSeqNum  : c_miseqnum,
				diKeyCode : c_dikeyCode,
				tiFormGb  : c_tifogmgb,
				diStatus  : c_distatus,
				socketList : 'Y'
			};
		var param = NeosUtil.makeParam(obj);
		neosPopup("POP_DOCVIEW", param);
	}	
	
	
	function gridDataRowPudd(gridObj, contentTable){
		
		// grid 에 dataSource 전달되지 않은 경우는 skip
		if( ! gridObj.optObject.dataSource ) return;

		var totalCount = gridObj.optObject.dataSource.totalCount;
		if( 0 == totalCount ) {
			puddGridNoData(gridObj);
			return;				
		}
		var rowLength = contentTable.rows.length;
		if( rowLength <= 0 ) return;
		for( var i=0; i<rowLength; i++ ) {
			 
			var trObj = Pudd.getInstance( contentTable.rows[ i ] );
			if( "d" == trObj.rowData.C_RIDELETEOPT ) {
				trObj.addClass("text_redline");
			}
		}
	}	
	
	function BindGrid(){
		
		var dataSource = new Pudd.Data.DataSource({
				serverPaging: true
			,	pageSize: 10
			,	request : {
				    url : '<c:url value="/purchase/SelectConclusionPaymentList.do" />'
				,	type : 'post'
				,	dataType : "json"
				,   parameterMapping : function( data ) {
					
					data.seq = "${seq}";
					data.fromDate = $("#searchFromDate").val(); ;
					data.toDate = $("#searchToDate").val();
					
					return data;
				}
			}	    
			,   result : {
				data : function(response){
					return response.list;
				},
				totalCount : function(response){
					return response.totalCount;	
				},
				error : function(response){
					alert("error");
				}	
			}
				    
		});
		
		Pudd("#grid").puddGrid({
			
			dataSource : dataSource
				//,	scrollable : true
			,	pageSize : 10
			,	pageable : {
				    buttonCount : 10
				,	pageList : [ 10, 20, 30, 50, 100 ]   
		        ,   pageInfo : true
			   	}
			,	resizable : true
			,	ellipsis : false
	        ,   sortable : false
			,	columns : [
				 	    {  field : "C_RIDOCFULLNUM",	title : "문서번호",	width : 130}
				 	,   {  field : "P_PAYTYPE",	title : "지급구분",	width : 90}
				 	,	{  field : "P_PAYCNT",	title : "지급차수",	width : 90}
					,	{  field : "C_DITITLE"
						,	title : "결의제목" 
						,   width : 400
						,	content : {	
							   template : TextOverFlowApp
							,  attributes : { style : "text-align:left;padding-left:5px;" }
						    }				
					    }
					,   {  field : "C_DIWRITEDAY",	title : "기안일자",	width : 90}
					,   {  field : "P_RESAMT",	title : "결의금액",	width : 130
						   , content : {
								template : function( rowData ) {
									
									if(rowData.C_DISTATUS == "007"){
										return 	'<text style="color:red;text-decoration: line-through;">' + rowData.P_RESAMT + '</text>';
									}else{
										return 	rowData.P_RESAMT;
									}
								}
							}
					
						}
					,   {  field : "P_REMAINAMT",	title : "잔여금액",	width : 130}
					,   {  field : "DOCSTSNAME",	title : "결재상태",	width : 120}
					,	{  field : "C_DIKEYCODE"
						,	title : "결재선보기"
						,	width : 80
						,	content : {	
							   template : openPopApprovalLinePudd
						    }				
					    }
				
				]
				
			,	loadCallback : function( headerTable, contentTable, footerTable, gridObj) {
				 
				//gridDataRowPudd(gridObj, contentTable);
			}
			,	noDataMessage : {
				message : "대금지급 요청건이 존재하지 않습니다."
			}
			,	progressBar : {
			   	 
					progressType : "loading"
				,	attributes : { style:"width:70px; height:70px;" }
				,	strokeColor : "#84c9ff"	// progress 색상
				,	strokeWidth : "3px"	// progress 두께
				,	percentText : "loading"	// loading 표시 문자열 설정 - progressType loading 인 경우만
				,	percentTextColor : "#84c9ff"
				,	percentTextSize : "12px"
				,	backgroundLayerAttributes : { style : "background-color:#fff;filter:alpha(opacity=0);opacity:0;width:100%;height:100%;position:fixed;top:0px; left:0px;" }
			}		
		});
		$(".grid-header input[type=checkbox]").parent().parent().html("선택");
	}   	
	
	var conclusionPaymentAmt = {};
	var conclusionTradeInfo = {};	
	var conclusionbudgetList = [];
	var conclusionRemainAmt = 0;
	
	function fnPaymentCreate(){
		
		//결의 잔여금액 조회
		var reqParam = {};
		
		reqParam.seq = "${seq}";
		
		$.ajax({
			type : 'post',
			url : '<c:url value="/purchase/ConclutionPaymentResInfo.do" />',
			datatype : 'json',
			data : reqParam,
			async : true,
			success : function(result) {
				
				if(result.resultData.conclusionPaymentAmt != null 
						&& result.resultData.conclusionTradeInfo != null 
						&& result.resultData.conclusionbudgetList != null 
						&& result.resultData.conclusionbudgetList.length > 0){
					
					conclusionPaymentAmt = result.resultData.conclusionPaymentAmt;
					
					console.log("contract_amt > " + conclusionPaymentAmt.contract_amt);
					console.log("res_amt_total > " + conclusionPaymentAmt.res_amt_total);
					
					if(conclusionPaymentAmt.res_amt_total < conclusionPaymentAmt.contract_amt){
						
						conclusionTradeInfo = result.resultData.conclusionTradeInfo;
						conclusionbudgetList = result.resultData.conclusionbudgetList;
						
						//결의 잔여 금액
						conclusionRemainAmt = conclusionPaymentAmt.contract_amt - conclusionPaymentAmt.res_amt_total;
						
						fnResDocInsert();
						
					}else{
						msgSnackbar("error", "지급요청할 잔여금액이 없습니다.");
					}
					
				}else{
					msgSnackbar("error", "대금지급 기초데이터가 없습니다.");
				}
				
			},
			error : function(result) {
				msgSnackbar("error", "데이터 요청에 실패했습니다.");
			}
		});
			
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
		parameter.outProcessInterfaceId = "CONCLUSION";
		parameter.outProcessInterfaceMId = "${seq}";
		parameter.outProcessInterfaceDId = "";

		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/ex/np/user/res/ResDocInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resNote(결의문서 적요), erpCompSeq(ERP 회사 코드), erpDivSeq(ERP 회계단위 코드), erpDivName(ERP 회계단위 명칭), erpDeptSeq(ERP 부서 코드), erpEmpSeq(ERP 사원 코드), erpGisu(ERP 기수), erpExpendYear(ERP 회계 연도), compSeq(GW 회사 코드), compName(GW 회사 명칭), deptSeq(GW 부서 코드), deptName(GW 부서 명칭), empSeq(GW 사용자 코드), empName(GW 사용자 명칭) */
			data : Option.Common.GetSaveParam(parameter),
			success : function(result) {
				/* 결의 정보 저장 */
				var aData = Option.Common.GetResult(result, 'aData');
				optionSet.resDocInfo = aData;

				if (aData) {
					resDocSeq = aData.resDocSeq;
					
					$.each(conclusionbudgetList, function( idx, conclusionbudgetInfo ) {
						fnResInsert(idx);
					});						
					
				} else {
					resDocSeq = '';
					msgSnackbar("error", "결의서 연동데이터(ResDoc) 생성 실패");
				}
			},
			error : function(result) {
				msgSnackbar("error", "결의서 연동데이터(ResHead) 생성 실패");
			}
		});
		return;
	}	
	
	function fnResInsert(idx) {

		parameter.resDocSeq = resDocSeq; /* [*]결의문서 키 */
		parameter.docuFgCode = '1'; /* [*]결의구분코드 */
		parameter.docuFgName = '지출결의서'; /* [*]결의구분명칭 */

		parameter.erpPcSeq = ''; /* ERP PC코드 */
		parameter.erpPcName = ''; /* ERP PC명칭 */
		parameter.resNote = ''; /* [*]결의서적요(결의내역) */
		parameter.resDate = '${toDate}'; /* [*]결의일자(발의일자) */
		parameter.expendDate = '${toDate}'; /* [*]결의일자(발의일자) */
		
		parameter.btrSeq = ''; /* [*]입출금계좌코드 */
		parameter.btrName = ''; /* [*]입출금계좌명칭 */
		parameter.btrNb = ''; /* [*]입출금계좌 */
		
		parameter.erpDivSeq = ''; /* ERP 회계단위코드 */
		parameter.erpDivName = ''; /* ERP 회계단위명칭 */
		parameter.erpMgtSeq = conclusionbudgetList[idx].pjt_seq; /* [*]부서/프로젝트 코드 */
		parameter.erpMgtName = conclusionbudgetList[idx].pjt_name; /* [*]부서/프로젝트 명칭 */
		parameter.bottomSeq = conclusionbudgetList[idx].bottom_seq; /* [*]하위사업코드 */
		parameter.bottomName = conclusionbudgetList[idx].bottom_name; /* [*]하위사업명칭 */		

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

		$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/ex/np/user/res/ResHeadInsert.do',
			datatype : 'json',
			async : false,
			/*   - data : resDocSeq, resDate, erpMgtSeq, erpMgtName, docuFgCode, docuFgName, resNote, erpCompSeq, erpCompName, erpPcSeq, erpPcName, erpEmpSeq, erpEmpName, erpDivSeq, erpDivName, erpDeptSeq, erpDeptName, erpGisu, erpGisuFromDate, erpGisuToDate, erpYear, btrSeq, bottomSeq, btrNb, btrName, bottomName, empSeq */
			data : Option.Common.GetSaveParam(parameter),
			success : function(result) {

				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					resSeq = (aData.resSeq || '').toString();
					fnBudgetInsert(idx);
				} else if(resultCode == 'GISU_CLOSE'){
					resSeq = '';
					msgSnackbar("error", "기수 마감되어 결의서를 입력할 수 없습니다.");
				} else {
					resSeq = '';
					msgSnackbar("error", "결의서 연동데이터(ResHead) 생성 실패");
				}
			},
			error : function(result) {
				msgSnackbar("error", "결의서 연동데이터(ResHead) 생성 실패");
			}
		});

		return;
	}
	
	function fnBudgetInsert(idx) {

		parameter.resDocSeq = resDocSeq; /* [*]결의문서 키 */
		parameter.resSeq = resSeq; /* [*]결의서 키 */
		
		parameter.erpBqSeq = ''; /* [*]ERP 연동 품의서 키 */
		parameter.erpBkSeq = ''; /* [*]ERP 연동 품의 예산 키 */
		parameter.erpBizplanSeq = ''; /* [*]ERP 사업계획 코드 */
		parameter.erpBizplanName = ''; /* [*]ERP 사업계획 명칭 */		
		
		parameter.erpDivSeq = ''; /* ERP 회계단위 코드 */
		parameter.erpDivName = ''; /* ERP 회계단위 명칭 */			
		parameter.erpBudgetDivSeq = conclusionbudgetList[idx].erp_budget_div_seq;
		parameter.erpBudgetDivName = conclusionbudgetList[idx].erp_budget_div_name;		
		
		parameter.erpBudgetSeq = conclusionbudgetList[idx].erp_budget_seq; /* [*]ERP 예산과목 코드 (예산단위 코드) */
		parameter.erpBudgetName = conclusionbudgetList[idx].erp_budget_name; /* [*]ERP 예산과목 명칭 (예산단위 명칭) */
		
		//parameter.erpFiacctName = '도서인쇄비'; /* [*]ERP 회계계정 코드 */
		//parameter.erpFiacctSeq = '82600'; /* [*]ERP 회계계정 명칭 */
		
		parameter.erpBgt1Name = conclusionbudgetList[idx].erp_bgt1_name; /* [*]관 명칭 */
		parameter.erpBgt1Seq = conclusionbudgetList[idx].erp_bgt1_seq; /* [*]관 코드 */
		parameter.erpBgt2Name = conclusionbudgetList[idx].erp_bgt2_name; /* [*]항 명칭 */
		parameter.erpBgt2Seq = conclusionbudgetList[idx].erp_bgt2_seq; /* [*]항 코드 */
		parameter.erpBgt3Name = conclusionbudgetList[idx].erp_bgt3_name; /* [*]목 명칭 */
		parameter.erpBgt3Seq = conclusionbudgetList[idx].erp_bgt3_seq; /* [*]목 코드 */
		parameter.erpBgt4Name = conclusionbudgetList[idx].erp_bgt4_name; /* [*]세 명칭 */
		parameter.erpBgt4Seq = conclusionbudgetList[idx].erp_bgt4_seq; /* [*]세 코드 */
		
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

		//예산잔액 조회
		$.ajax({
			type : 'post',
			url : '<c:url value="/ex/np/user/res/resBudgetInfoSelect.do" />',
			datatype : 'json',
			async : false,
			data : parameter,
			success : function(result) {
				var data = result.result.aData;
				conclusionbudgetList[idx].balanceAmt = Math.floor(data.balanceAmt/10)*10;
			},
			/*   - error :  */
			error : function(result) {
				msgSnackbar("error", "예산정보 조회 중 오류 발생");
				return;
			}
		});			

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
			success : function(result) {
				var aData = Option.Common.GetResult(result, 'aData');
				var resultCode = Option.Common.GetResultCode(result);

				if (resultCode === 'SUCCESS') {
					/* 예산정보 갱신 ( 금회집행 ) */
					budgetSeq = (aData.budgetSeq || '').toString();
					fnTradeInsert(idx);

				} else if (resultCode === 'EXCEED') {
					msgSnackbar("error", "${CL.ex_exceedMesage}");
				} else {
					msgSnackbar("error", "결의서 연동데이터(ResBudget) 생성 실패");
				}
			},
			error : function(result) {
				msgSnackbar("error", "결의서 연동데이터(ResBudget) 생성 실패");
			}
		});
		return;
	}
	
	function fnTradeInsert(idx) {

		parameter.budgetSeq = budgetSeq; /* [*]예산 키 */
		
		parameter.erpIsuDt = ''; /* G20 연동 키 */
		parameter.erpIsuSq = ''; /* G20 연동 키 */
		parameter.erpInSq = ''; /* G20 연동 키 */
		parameter.erpBqSq = ''; /* G20 연동 키 */
		parameter.itemName = ''; /* [*]물품명 */
		parameter.itemCnt = ''; /* [*]수량 */
		
		parameter.divSeq = parameter.erpDivSeq;
		parameter.divName = parameter.erpDivName;		

		parameter.trSeq = conclusionTradeInfo.tr_seq; /* [*]거래처 코드 */
		parameter.trName = conclusionTradeInfo.tr_name; /* [*]거래처 명칭 */
		parameter.ceoName = conclusionTradeInfo.ceo_name; /* [*]대표자 명칭 */
		
		if(conclusionRemainAmt <= conclusionbudgetList[idx].balanceAmt){
			parameter.tradeAmt = conclusionRemainAmt; /* [*]금액 */
			parameter.tradeStdAmt = parameter.tradeAmt*0.9; /* [*]공급가액 */
			parameter.tradeVatAmt = parameter.tradeAmt*0.1; /* [*]부가세 */
			
			conclusionRemainAmt = 0;
		}else{
			parameter.tradeAmt = conclusionbudgetList[idx].balanceAmt; /* [*]금액 */
			parameter.tradeStdAmt = parameter.tradeAmt*0.9; /* [*]공급가액 */
			parameter.tradeVatAmt = parameter.tradeAmt*0.1; /* [*]부가세 */
			
			conclusionRemainAmt -= conclusionbudgetList[idx].balanceAmt;
		}
		
		parameter.jiroSeq = ''; /* 미사용? */
		parameter.jiroName = ''; /* 미사용? */
		parameter.baNb = conclusionTradeInfo.ba_nb; /* [*]계좌 번호 */
		parameter.btrSeq = conclusionTradeInfo.btr_seq; /* [*]금융기관 코드 */
		parameter.btrName = conclusionTradeInfo.btr_name; /* [*]금융기관 명 */
		parameter.depositor = conclusionTradeInfo.depositor; /* [*]예금주 */
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
					
					if(conclusionbudgetList.length-2 < idx){
						fnPaymentExpendCreatePop();	
					}
					
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
		
	function fnPaymentExpendCreatePop(){
		openWindow2("${pageContext.request.contextPath}/expend/np/user/NpUserCRDocPop.do?formSeq=${formSeq}&docId=&approKey=EXNPRESI_NP_" + resDocSeq,  "ConclusionExpendCreatePop", 1200, 800, 1, 1) ;
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
								<input id="searchFromDate" type="text" value="${fromDate}" class="puddSetup" pudd-type="datepicker"/> ~
								<input id="searchToDate" type="text" value="${toDate}" class="puddSetup" pudd-type="datepicker"/>
							</dd>							
							<dd><input onclick="BindGrid();" type="button" class="puddSetup submit" id="searchButton" value="검색" /></dd>
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
								</div>
							</div>
						</div>
						
						<div class="dal_Box">
							<div class="dal_BoxIn posi_re">
								<div id="grid"></div>
							</div>
						</div>
						
					</div><!-- //sub_contents_wrap -->
		
	</div><!-- //pop_con -->
</div><!-- //pop_wrap -->

</body>
</html>