<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="currentTime" class="java.util.Date" />
<script type="text/javascript" src="/exp/js/np/ex-ui-1.0.1.js"></script>
<script type="text/javascript" src="/exp/js/ex/jquery.ex.format.js"></script>

<jsp:include page="../include/UserOptionMap.jsp" flush="false" />
<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<script>
    /*
	 * 품의/결의서 공통 옵션및 정보
	 * optionSet
	 * optionSet.conVo : 그룹웨어 커넥션VO
	 * optionSet.loginVo : 그룹웨어 로그인VO
	 * optionSet.gw : 그룹웨어 환경설정 정보 [optionSet.gw[item.option_gbn][item.option_code] 형태로 사용.]
	 * optionSet.erp : ERP 환경설정 정보
	 * optionSet.erpEmpInfo : 사용자 ERP 정보
	 * optionSet.formInfo : 결재 양식 정보
	 */

    var devMode = 'debug';
    function log(obj) {
        if (devMode === 'debug') {
            console.log(obj)
        }
    };

    /* 전역 변수 */
     
    var consDocSeq = '',  	/* 품의서  문서 단위 시퀀스 */
        consSeq = '', 		/* 품의서 항목 시퀀스 */
        budgetSeq = '', 	/* 예산내역 시퀀스 */
        tradeSeq = '', 		/* 거래처정보 시퀀스 */
        rowConsData = '', 	/* 현재 품의정보 row 데이터 */
        rowBudgetData = '', /* 현재 예산내역 row 데이터 */
        rowTradeData = '',	/* 현재 거래처정보 row 데이터 */
        callbackTableFocusX, /* 콜백 함수에서 테이블 정보 저장 */
        callbackTableFocusY, /* 콜백 함수에서 테이블 정보 저장 */
        erpTypeCode,		 /* ERP 구분 */
        commonConsTableRowInfo = {
            table: { /* 테이블 기본정보 */ },
            newData: { /* 입력 후 데이터 */ },
            orgnData: { /* 입력 전 데이터 */ }
        },
        commonBudgetTableRowInfo = {
           table: { /* 테이블 기본정보 */ },
           newData: { /* 입력 후 데이터 */ },
           orgnData: { /* 입력 전 데이터 */ }
        },
        commonTradeTableRowInfo = {
           table: { /* 테이블 기본정보 */ },
           newData: { /* 입력 후 데이터 */ },
           orgnData: { /* 입력 전 데이터 */ }
        },
        docuFgList = [{ 'docuFgCode': '1', 'docuFgName': '${CL.ex_expendCons}'/* 지출품의서 */ }, { 'docuFgCode': '2', 'docuFgName': '${CL.ex_purchaseCons}' /* 구매품의서 */ }, { 'docuFgCode': '3', 'docuFgName': '${CL.ex_serviceCons}' /* 용역품의서 */ }], /* 품의구분 */
        title = { docuFgName: '품의구분', docuFgCode: '품의구분코드', expendDate: '품의일자', consNote: '품의내역', consAmt: '금액', consSeq: '품의서 Seq', erpBudgetName: '예산단위', erpBudgetSeq: '예산단위코드', erpBizplanName: '사업계획', erpBizplanSeq: '사업계획코드', erpBgacctName: '예산계정', erpBgacctSeq: '예산계정코드', erpFiacctName: '회계계정', erpFiacctSeq: '회계계정코드', budgetNote: '적요', budgetAmt: '금액', trName: '거래처명', trSeq: '거래처코드', ceoName: '대표자명', tradeAmt: '금액', btrName: '금융커래처', btrSeq: '금융거래처 코드', baNb: '계좌번호', tradeNote: '적요', consDocSeq: '품의문서Seq', budgetSeq: '예산Seq', tradeSeq: '거래처 Seq', itemName: '물풀명', itemCnt: '갯수', tradeUnitAmt: '개당 가격', consDate: '품의일자', projectName: '프로젝트', projectSeq: '프로젝트코드', causeDate: '원인행위일', inspectDate: '계약일', signDate: '검수일', causeEmpName: '원인행위자', causeEmpSeq: '원인행위자코드', spec: '명세서', erpBudgetNameG20: '예산과목', erpBudgetSeqG20: '예산과목코드', setFgName: '결재수단', setFgCode: '결재수단코드', vatFgName: '과세구분', vatFgCode: '과세구분코드', trFgName: '채주유형', trFgCode: '채주유형코드', erpDivName: '회계단위', erpDivSeq: '회계단위코드', consNoteG20: '적요', budgetNoteG20: '비고', btrNumber: '입출금계좌', erpBgt1Name: '관 이름', erpBgt1Seq: '관 코드', erpBgt2Name: '항 이름', erpBgt2Seq: '항 코드', erpBgt3Name: '목 이름', erpBgt3Seq: '목 코드', erpBgt4Name: '세 이름', erpBgt4Seq: '새 코드', erpOpenAmt: '예산금액', erpApplyAmt: '집행금액', erpLeftAmt: '예산잔액' },
        yes = 'Y', no = 'N', YES = 'Y', NO = 'N',
        align = { center: 'center', left: 'left', right: 'right' },
        type = { combo: 'combo', text: 'text' },
        keyCode = { '13': 'enter' },
        widthZero = '0%',
        idxZero = 0,
        success = 'SUCCESS', SUCCESS = 'SUCCESS', EXCEED = 'EXCEED', exceed = 'EXCEED',
        exceedFlag = false,
        tbl = { cons: '#consTable', budget: '#budgetTable', trade: '#tradeTable' },
        classes = { row: '.row-budget-', cons: 'uniq-cons-', trade: '.row-trade-' }
    	confferFlag = false;
    
    /* SSL 적용관련 */
    if (!window.location.origin) {
         window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
    }
    var origin = document.location.origin;

    /******************************* IU 테이블 정의 ************************************/
    /* 품의정보 테이블 컬럼 */
    var consTableColumn = [
         {
            title: title.docuFgName, /* 제목 */
            display: YES, /* 표현 여부 (표현 : Y / 미표현 : N) */
            displayKey: '', /* 나타낼 문저열 조합의 정보, 구분자는 "▥" 를 사용 */
            colKey: 'docuFgName', /* json 연동 키 */
            width: '20%', /* 너비 */
            reqYN: YES, /* 필수 입력 여부 */
            align: align.center, /* 정렬 */
            type: type.combo, /* 입력 포맷 (text, combo, datepicker) */
            comboData: { code: 'docuFgCode', name: 'docuFgName', list: docuFgList }, /* 콤보박스 목록 */
            disabled: '',
            classes: '',
            mask: '',
            editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ }}
        }
        , { title: title.docuFgCode, display: NO, colKey: 'docuFgCode', width: widthZero, reqYN: YES, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.consDate, display: YES, colKey: 'consDate', width: '20%', reqYN: YES, align: align.center, type: 'datepicker' }
        , {
            title: title.consNote, display: YES, colKey: 'consNote', width: '40%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } },
            keyDownBefore: function (obj) {
                if (obj.keyCode == '13') {
                	fnSaveOrUpdateCons(obj, "enter");
                }
            }
        }
        , { title: title.consAmt, display: YES, colKey: 'consAmt', width: '20%', reqYN: NO, align: align.center, type: type.text, disabled: 'disabled' }
        , { title: title.consDocSeq, display: NO, colKey: 'consDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.consSeq, display: NO, colKey: 'consSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, disabled: 'disabled' }
    ];

    /* 예산내역 테이블 컬럼 */
    var budgetTableColumn = [
        { title: title.erpBudgetName, display: YES, colKey: 'erpBudgetName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) {
        			fnCommonPop('budget', obj);
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('budget', obj); return true; } }
        , { title: title.erpBudgetSeq, display: NO, colKey: 'erpBudgetSeq', width: '12%', reqYN: YES, align: align.center, type: type.text }
        , { title: title.erpBizplanName, display: YES, colKey: 'erpBizplanName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('bizplan', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('bizplan', obj); return true; } }
        , { title: title.erpBizplanSeq, display: NO, colKey: 'erpBizplanSeq', width: widthZero, reqYN: YES, align: align.center, type: type.text }
        , { title: title.erpBgacctName, display: YES, colKey: 'erpBgacctName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('bgacct', obj);
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('bgacct', obj); return true; } }
        , { title: title.erpBgacctSeq, display: NO, colKey: 'erpBgacctSeq', width: widthZero, reqYN: YES, align: align.center, type: type.text }
        , { title: title.erpFiacctName, display: YES, colKey: 'erpFiacctName', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('fiacct', obj);
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('fiacct', obj); return true; } }
        , { title: title.erpFiacctSeq, display: NO, colKey: 'erpFiacctSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.budgetNote, display: YES, colKey: 'budgetNote', width: '', reqYN: NO, align: align.center, type: type.text,
        	keyDownBefore: function (obj) {
        		/* 옵션 변경으로 인한 수정 - 신재호 */
        		if(fnGetGwOptions(1, 1, '0') === '1') {
            		rowBudgetData = obj;
                    if (obj.keyCode == '13') {
                        if (obj.data.budgetSeq == "") { fnSaveBudget(obj, keyCode[obj.keyCode.toString()]); }
                        else { fnUpdateBudget(obj, keyCode[obj.keyCode.toString()]); }
                    }	
            	}
            }
        }
        , {
        	/* 옵션 변경으로 인한 수정 - 신재호 */
            title: title.budgetAmt, display: YES, colKey: 'budgetAmt', width: '15%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? YES : NO, align: align.center, type: type.text,
            keyDownBefore: function (obj) {
                if (obj.keyCode == '13') {
					fnSaveOrUpdateBudget(obj, 'enter');
                }
            },
            keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#budgetTable .inpTextBox').val($('#budgetTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
   				return true;
   			}
        }
        , { title: title.consDocSeq, display: NO, colKey: 'consDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.consSeq, display: NO, colKey: 'consSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.budgetSeq, display: NO, colKey: 'budgetSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt1Name, display: NO, colKey: 'erpBgt1Name', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt1Seq, display: NO, colKey: 'erpBgt1Seq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt2Name, display: NO, colKey: 'erpBgt2Name', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt2Seq, display: NO, colKey: 'erpBgt2Seq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt3Name, display: NO, colKey: 'erpBgt3Name', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt3Seq, display: NO, colKey: 'erpBgt3Seq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt4Name, display: NO, colKey: 'erpBgt4Name', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt4Seq, display: NO, colKey: 'erpBgt4Seq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpOpenAmt, display: NO, colKey: 'erpOpenAmt', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpApplyAmt, display: NO, colKey: 'erpApplyAmt', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpLeftAmt, display: NO, colKey: 'erpLeftAmt', width: widthZero, reqYN: NO, align: align.center, type: type.text }
    ];

    /* 거래처 테이블 컬럼 */
    var tradeTableColumn = [
        { title: title.trName, display: YES, colKey: 'trName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('Tr', obj);
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('Tr', obj); return true; } }
        , { title: title.trSeq, display: NO, colKey: 'trSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.ceoName, display: YES, colKey: 'ceoName', width: '12%', reqYN: NO, align: align.center, type: type.tex, keyDownBefore: function (obj) { return true; } }
        , { title: title.itemName, display: YES, colKey: 'itemName', width: '12%', reqYN: YES, align: align.center, type: type.tex, keyDownBefore: function (obj) { return true; } }
        , { title: title.itemCnt, display: YES, colKey: 'itemCnt', width: '12%', reqYN: YES, align: align.center, type: type.tex, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeUnitAmt, display: YES, colKey: 'tradeUnitAmt', width: '12%', reqYN: YES, align: align.center, type: type.tex, keyDownBefore: function (obj) { return true; },
            keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
   				return true;
   			} }
        , { title: title.btrName, display: YES, colKey: 'btrName', width: '12%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.btrSeq, display: NO, colKey: 'btrSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.baNb, display: YES, colKey: 'baNb', width: '12%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , {
            title: title.tradeNote, display: YES, colKey: 'tradeNote', width: '13%', reqYN: NO, align: align.center, type: type.text
        	, keyDownBefore: function (obj) { 
                if (obj.keyCode == '13') {
                	fnSaveOrUpdateTrade(obj, 'enter');
                }
        	} 
        }
        , { title: title.consDocSeq, display: NO, colKey: 'consDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.consSeq, display: NO, colKey: 'consSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.budgetSeq, display: NO, colKey: 'budgetSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeSeq, display: NO, colKey: 'tradeSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
    ];
    /******************************* IU 테이블 정의 - END ************************************/
    
    
    /******************************* G20 테이블 정의 ************************************/
    /* 품의정보 테이블 컬럼 */
    var consTableColumnG20 = [
         {
            title: title.docuFgName, /* 제목 */
            display: YES, /* 표현 여부 (표현 : Y / 미표현 : N) */
            displayKey: '', /* 나타낼 문저열 조합의 정보, 구분자는 "▥" 를 사용 */
            colKey: 'docuFgName', /* json 연동 키 */
            width: '20%', /* 너비 */
            reqYN: YES, /* 필수 입력 여부 */
            align: align.center, /* 정렬 */
            type: type.combo, /* 입력 포맷 (text, combo, datepicker) */
            comboData: { code: 'docuFgCode', name: 'docuFgName', list: docuFgList }, /* 콤보박스 목록 */
            disabled: '',
            classes: '',
            mask: '',
            editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ }}
        }
        , { title: title.docuFgCode, display: NO, colKey: 'docuFgCode', width: widthZero, reqYN: YES, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.consDate, display: YES, colKey: 'consDate', width: '20%', reqYN: YES, align: align.center, type: 'datepicker' }
        , { title: title.projectName, display: YES, colKey: 'projectName', width: '20%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('project', obj);
       			} 
       		}, tooltip: '[F2] 프로젝트 도움창', dblClickEvent: function(obj){ fnCommonPop('project', obj); return true; } }
        , { title: title.projectSeq, display: NO, colKey: 'projectSeq', width: '20%', reqYN: YES, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , {
            title: title.consNoteG20, display: YES, colKey: 'consNoteG20', width: '40%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } },
            keyDownBefore: function (obj) {
                if (obj.keyCode == '13') {
                	fnSaveOrUpdateCons(obj, "enter");
                }
            }
        }
        , { title: title.btrNumber, display: (fnGetGwOptions(1, 1, '0') === '1' && optionSet.erp['4']['05'].USE_YN == '1') ? YES : NO, colKey: 'btrNumber', width: '40%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.consAmt, display: YES, colKey: 'consAmt', width: '20%', reqYN: NO, align: align.center, type: type.text, disabled: 'disabled' }
        , { title: title.causeDate, display: (fnGetGwOptions(1, 1, '0') === '1' && optionSet.erp['4']['05'].USE_YN == '1') ? YES : NO, colKey: 'causeDate', width: '20%', reqYN: NO, align: align.center, type: 'datepicker',  keyDownBefore: function (obj) { return true; } }
        , { title: title.inspectDate, display: (fnGetGwOptions(1, 1, '0') === '1' && optionSet.erp['4']['05'].USE_YN == '1') ? YES : NO, colKey: 'inspectDate', width: '20%', reqYN: NO, align: align.center, type: 'datapicker',  keyDownBefore: function (obj) { return true; } }
        , { title: title.signDate, display: (fnGetGwOptions(1, 1, '0') === '1' && optionSet.erp['4']['05'].USE_YN == '1') ? YES : NO, colKey: 'signDate', width: '20%', reqYN: NO, align: align.center, type: 'datapicker',  keyDownBefore: function (obj) { return true; } }
        , { title: title.causeEmpName, display: (fnGetGwOptions(1, 1, '0') === '1' && optionSet.erp['4']['05'].USE_YN == '1') ? YES : NO, colKey: 'causeEmpName', width: '20%', reqYN: NO, align: align.center, type: type.text,  keyDownBefore: function (obj) { return true; } }
        , { title: title.causeEmpSeq, display: NO, colKey: 'causeEmpSeq', width: '20%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, align: align.center, type: type.text,  keyDownBefore: function (obj) { return true; } }
        , { title: title.spec, display: (fnGetGwOptions(1, 1, '0') === '1' && optionSet.erp['4']['05'].USE_YN == '1') ? YES : NO, colKey: 'spec', width: '20%', reqYN: NO, align: align.center, type: type.text,  keyDownBefore: function (obj) { return true; } }
        , { title: title.consDocSeq, display: NO, colKey: 'consDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.consSeq, display: NO, colKey: 'consSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, disabled: 'disabled' }
    ];

    /* 예산내역 테이블 컬럼 */
    var budgetTableColumnG20 = [
        { title: title.erpBudgetNameG20, display: YES, colKey: 'erpBudgetNameG20', width: '30%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('budgetlist', obj);
       			}
       		}, tooltip: '[F2] 예산과목 도움창', dblClickEvent: function(obj){ fnCommonPop('budgetlist', obj); return true; } }
        , { title: title.erpBudgetSeqG20, display: NO, colKey: 'erpBudgetSeqG20', width: '0%', reqYN: NO, align: align.center, type: type.text }
        , { title: title.setFgName, display: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, colKey: 'setFgName', width: '12%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
       		keyDownBefore: function (obj) { 
       			if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
       				fnCommonPop('budget', obj); 
    			} 
     		}, dblClickEvent: function(obj){ fnCommonPop('budget', obj); return true; } }
        , { title: title.setFgCode, display: NO, colKey: 'setFgCode', width: '12%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { if(obj.keyCode == "113") { fnCommonPop('budget', obj); } }, dblClickEvent: function(obj){ fnCommonPop('budget', obj); return true; } }
        , { title: title.vatFgName, display: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, colKey: 'vatFgName', width: '12%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
       		keyDownBefore: function (obj) { 
       			if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
       				fnCommonPop('budget', obj); 
      			} 
      		}, dblClickEvent: function(obj){ fnCommonPop('budget', obj); return true; } }
        , { title: title.vatFgCode, display: NO, colKey: 'vatFgCode', width: '12%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { if(obj.keyCode == "113") { fnCommonPop('budget', obj); } }, dblClickEvent: function(obj){ fnCommonPop('budget', obj); return true; } }
        , { title: title.trFgName, display: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, colKey: 'trFgName', width: '12%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
       		keyDownBefore: function (obj) { 
       			if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
       				fnCommonPop('budget', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('budget', obj); return true; } }
        , { title: title.trFgCode, display: NO, colKey: 'trFgCode', width: '12%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? NO : YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { if(obj.keyCode == "113") { fnCommonPop('budget', obj); } }, dblClickEvent: function(obj){ fnCommonPop('budget', obj); return true; } }
        , { title: title.erpDivName, display: YES, colKey: 'erpDivName', width: '20%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('div', obj); 
       			} 
       		}, tooltip: '[F2] 회계단위 도움창', dblClickEvent: function(obj){ fnCommonPop('div', obj); return true; } }  
        , { title: title.erpDivSeq, display: NO, colKey: 'erpDivSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , {
        	/* 옵션 변경으로 인한 수정 - 신재호 */
            title: title.budgetAmt, display: YES, colKey: 'budgetAmt', width: '15%', reqYN: fnGetGwOptions(1, 1, '0') === '0' ? YES : NO, align: align.center, type: type.text,
            keyDownBefore: function (obj) {
//                 if (obj.keyCode == '13') {
// 					fnSaveOrUpdateBudget(obj, 'enter');
//                 }
				return true;
            },
            keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#budgetTable .inpTextBox').val($('#budgetTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
   				return true;
   			}
        }
        , {
            title: title.budgetNoteG20, display: YES, colKey: 'budgetNoteG20', width: '', reqYN: NO, align: align.center, type: type.text,
        	keyDownBefore: function (obj) {
        		/* 옵션 변경으로 인한 수정 - 신재호 */
        		if(fnGetGwOptions(1, 1, '0') === '1') {
            		rowBudgetData = obj;
                    if (obj.keyCode == '13') {
                        if (obj.data.budgetSeq == "") { fnSaveBudget(obj, keyCode[obj.keyCode.toString()]); }
                        else { fnUpdateBudget(obj, keyCode[obj.keyCode.toString()]); }
                    }	
            	} else {
                    if (obj.keyCode == '13') {
					    fnSaveOrUpdateBudget(obj, 'enter');
                    }
            	}
            }
        }
        , { title: title.consDocSeq, display: NO, colKey: 'consDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.consSeq, display: NO, colKey: 'consSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.budgetSeq, display: NO, colKey: 'budgetSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt1Name, display: NO, colKey: 'erpBgt1Name', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt1Seq, display: NO, colKey: 'erpBgt1Seq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt2Name, display: NO, colKey: 'erpBgt2Name', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt2Seq, display: NO, colKey: 'erpBgt2Seq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt3Name, display: NO, colKey: 'erpBgt3Name', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt3Seq, display: NO, colKey: 'erpBgt3Seq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt4Name, display: NO, colKey: 'erpBgt4Name', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpBgt4Seq, display: NO, colKey: 'erpBgt4Seq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpOpenAmt, display: NO, colKey: 'erpOpenAmt', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpApplyAmt, display: NO, colKey: 'erpApplyAmt', width: widthZero, reqYN: NO, align: align.center, type: type.text }
        , { title: title.erpLeftAmt, display: NO, colKey: 'erpLeftAmt', width: widthZero, reqYN: NO, align: align.center, type: type.text }
    ];

    /* 거래처 테이블 컬럼 */
    var tradeTableColumnG20 = [
        { title: title.trName, display: YES, colKey: 'trName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('Tr', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('Tr', obj); return true; } }
        , { title: title.trSeq, display: NO, colKey: 'trSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.ceoName, display: YES, colKey: 'ceoName', width: '12%', reqYN: NO, align: align.center, type: type.tex, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeAmt, display: YES, colKey: 'tradeAmt', width: '12%', reqYN: YES, align: align.center, type: type.tex, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeStdAmt, display: YES, colKey: 'tradeStdAmt', width: '12%', reqYN: YES, align: align.center, type: type.tex, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeVatAmt, display: YES, colKey: 'tradeVatAmt', width: '12%', reqYN: YES, align: align.center, type: type.tex, keyDownBefore: function (obj) { return true; },
            keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
   				return true;
   			} }
        , { title: title.btrName, display: YES, colKey: 'btrName', width: '12%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.btrSeq, display: NO, colKey: 'btrSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.baNb, display: YES, colKey: 'baNb', width: '12%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.depositor, display: YES, colKey: 'depositor', width: '12%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.card, display: YES, colKey: 'card', width: '12%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , {
            title: title.tradeNote, display: YES, colKey: 'tradeNote', width: '13%', reqYN: NO, align: align.center, type: type.text
        	, keyDownBefore: function (obj) { 
                if (obj.keyCode == '13') {
                	fnSaveOrUpdateTrade(obj, 'enter');
                }
        	} 
        }
        , { title: title.regDate, display: YES, colKey: 'regDate', width: '12%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.consDocSeq, display: NO, colKey: 'consDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.consSeq, display: NO, colKey: 'consSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.budgetSeq, display: NO, colKey: 'budgetSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeSeq, display: NO, colKey: 'tradeSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
    ];
    /******************************* G20 테이블 정의 - END ************************************/
    
    
    

    /*	[테이블] 함수
    ----------------------------------------- */
    var table = {
        addRow: function (target, data) { target.extable('setAddRow', data); return; }, /* 행추가 */
        focus: function (target, positionX, positionY) { target.extable('setFocus', positionX, positionY); return; }, /* 포커스 지정 */
        rmFocus: function (target) { target.extable('setRemoveEditor'); return; },
        rowData: function (target, positionY) { return target.extable('getRowData', positionY); }, /* 행 데이터 조회 */
        allData: function (target) { return target.extable('getAllData'); }, /* 테이블 데이터 조회 */
        selectRowData: function (target) { return target.extable('getSelectedRowData'); }, /* 선택된 행 데이터 조회 */
        removeRow: function (target, positionY) { target.extable('setRemoveRow', positionY); return; }, /* 행 삭제 */
        check: function (target, positionY) { return target.extable('getReqCheck', positionY); } /* 행 필수 입력 확인 */
    };

    var def = {
        cons: function (data) {
            var defaults = {
                docuFgName: "",	/* 품의구분 */
                docuFgCode: "", /* 품의구분 코드 */
                consDate: "",   /* 품의일자 */
                consNote: "",	/* 적요 */
                consAmt: 0,		/* 금액 */
                consDocSeq: 0,	/* 품의 문서 시퀀스 */
                btrNumber: "",  /* 입출금계좌 */
                projectName: "", 	  /* 프로젝트 */
                projectSeq: "",  /* 프로젝트 코드 */
                causeDate: "", 	  /* 원인행위일 */
                inspectDate: "",  /* 계약일 */
                signDate: "", 	  /* 검수일 */
                causeEmpName: "", /* 원인행위자이름 */
                causeEmpSeq: 0,  /* 원인행위자시퀀스 */
                spec: "" 		  /* 명세서 */
            };

            var result = $.extend(defaults, data);
            return result;
        },
        budget: function (data) {
            var defaults = {
                erpBudgetName: '',	/* 예산단위 */
                erpBudgetSeq: '',	/* 예산단위 코드 */
                erpBizplanName: '',	/* 사업계획 */
                erpBizplanSeq: '',	/* 사업계획 코드 */
                erpBgacctName:'',	/* 예산계정 */
                erpBgacctSeq:'',	/* 예산계정 코드 */
                erpBgacctName: '',	/* 예산계정 이름 */
                erpBgacctSeq: '',	/* 회계계정 */
                erpFiacctName: '',  /* 회계계정 이름 */
                erpFiacctSeq:'',	/* 회계계정 코드 */
                budgetNote: '',		/* 적요 */
                budgetAmt: 0,		/* 금액 */
                consDocSeq: 0,		/* 품의 문서 시퀀스 */
                consSeq: 0,			/* 품의정보 시퀀스 */
                erpBudgetNameG20: "",	/* 예산과목 */
      			erpBudgetSeqG20: "", 	/* 예산과목 코드 */
      			setFgName: "",			/* 결재수단 */
      			setFgCode: "",			/* 결재수단코드 */
      			vatFgName: "",			/* 과세구분 */
      			vatFgCode: "",			/* 과세구분코드 */
      			trFgName: "",			/* 채주유형 */
      			trFgCode: "",			/* 채주유형코드 */
      			erpDivName: "",		/* 회계단위 */
      			erpDivSeq: "",		/* 회계단위코드 */
      			expendDate: "" 		/* 품의일자 */
            };

            var result = $.extend(defaults, data);
            return result;
        },
        trade: function (data) {
            var defaults = {
                trName: '',			/* 거래처 */
                trSeq: '',			/* 거래처 코드 */
                ceoName: '',		/* 대표자명 */
                btrName: '',		/* 금융기관 */
                btrSeq: '',			/* 금융기관코드 */
               	baNb: '',			/* 계좌번호 */
                depositor: '',		/* 예금주 */
                itemName: '', 		/* 물품명 */
                itemCnt: 0,			/* 수량 */
                tradeUnitAmt: 0,	/* 개당 가격 */
                tradeNote: '',		/* 적요 */
                consDocSeq: 0,		/* 품의 문서 시퀀스 */
                consSeq: 0,			/* 품의정보 시퀀스 */
                budgetSeq: 0,		/* 예산내역 시퀀스 */
                tradeSeq: 0,		/* 거래처 시퀀스 */
                card: '', 			/* 카드거래처 */
                tradeAmt: 0,		/* 금액 */
            };

            var result = $.extend(defaults, data);
            return result;
        }
        
    }

    /*	[품의서] 공통 합수
    ----------------------------------------- */
    /* ajax 호출 정의 */
    /*ajax 호출 반환읜 항상 { "result" : {"result" : {} } } 로 반환*/
    function fnAjax(param) {
        defaults = { url: '', async: false, data: {} };
        var param = $.extend(defaults, param);
        if (typeof param.data === 'function') { param.data = param.data(); }
        //console.log("ajax 파람");
        //console.log(param.data);
        var result = JSON.parse($.ajax({
            type: 'post',
            url: '/exp' + (param.url || ''),
            datatype: 'json',
            async: param.async,
            data: param.data
        }).responseText).result;

        if (result.resultCode === SUCCESS) { return result; }
        else if(result.resultCode === EXCEED){ return result;}
        else { $.error(result.resultName); return null; }
    }

    /*	[품의서] 옵션 함수
    ----------------------------------------- */
    function fnGetGwOptions(optionDiv, optionsCode, defaults) { 
    	try{
    		return (optionSet.gw[optionDiv][optionsCode].setValue || (defaults || ''));
    	}catch(e){
    		return defaults;
    	}
   	}

    /*	[품의서] 문서 준비 document.ready
    ----------------------------------------- */
    $(document).ready(function () {
        log('모듈 공통옵션 조회 > value optionSet');
        log(optionSet);
    	
    	/* ERP iCUBE */
    	if(optionSet.conVo.erpTypeCode == "iCUBE") {
    		erpTypeCode = "iCUBE";
    	} else {	/* ERPiU */
    		erpTypeCode = "ERPiU";
    		$("#erpBudgetInfo").hide();
    		$("#erpEmpInfo").hide();
    	}
        
        /* [ERP 정보] erp 정보가져오기 */
        fnErpInfo();
        
        /* [ POP ] 품의서 페이지 리사이즈 */
        fnResizePage();
        
        /* [품의문서] 최초생성 */
        fnInitConsDocSeq();
        
        /* init */
        fnInit();
        
        /* initEvent */
        fnInitEvent();
    });
    
    var approvalBeforeFlag = false;
    function fnApprovalBefore() {
    	// 전자결제 정보 수정 시 제목표시
        if (optionSet.formInfo && optionSet.formInfo.formName) {
            $('#lbl_consTitle').contents().unbind().remove();
            $('#lbl_consTitle').html(optionSet.formInfo.formName || '');
        }
        
    	// 품의문서 정보 변수
    	var consHeadInfo = new Array();
    	var consBudgetInfo = new Array();
    	var consTradeInfo = new Array();
    	
    	// 품의문서 데이터
    	consHeadInfo = ${consHeadInfo};
    	consBudgetInfo = ${consBudgetInfo};
    	consTradeInfo = ${consTradeInfo};
		
		approvalBeforeFlag = true;	
		confferFlag = true;
		
		/* 기존 입력 초기화 */
		$(tbl.cons).contents().unbind().remove();
	    $(tbl.budget).contents().unbind().remove();
		
	    /* 품의정보 그려주기 */
		fnDrawConsInfo();

		/* 품의정보 데이터 */
		var firstConsSeq = 0;
		var consSeqArray = new Array();
		for(var i=0; i<consHeadInfo.length; i++) {
			var year = consHeadInfo[i].consDate.substring(0,4);
			var month = consHeadInfo[i].consDate.substring(4,6);
			var day = consHeadInfo[i].consDate.substring(6,8);
			var displayDate = year + "-" + month + "-" + day;
			consHeadInfo[i].consNoteG20 = consHeadInfo[i].consNote;
			consHeadInfo[i].consAmt = fnAddComma(consHeadInfo[i].consAmt);
			consHeadInfo[i].consDate = displayDate;
			consSeqArray.push(consHeadInfo[i].consSeq);
			consDocSeq = consHeadInfo[0].consDocSeq;
			firstConsSeq = consHeadInfo[0].consSeq;	
			
			$ ( tbl.cons ).extable ( 'setAddRow', consHeadInfo[i] );
		}
		table.focus($(tbl.cons), 0, 0);

		/* 예산정보 그려주기 */
		fnDrawBudgetInfo();
		
		/* 예산내역 데이터 */
		var budgetSeqArray = new Array();
		var erpBudgetSeq = {};
		for(var i=0; i<consBudgetInfo.length; i++) {
			consBudgetInfo[i].erpBudgetNameG20 = consBudgetInfo[i].erpBudgetName;
			consBudgetInfo[i].erpBudgetSeqG20 = consBudgetInfo[i].erpBudgetSeq;
			consBudgetInfo[i].budgetNoteG20 = consBudgetInfo[i].budgetNote;
			consBudgetInfo[i].budgetAmt = fnAddComma(consBudgetInfo[i].budgetAmt);
			budgetSeqArray.push(consBudgetInfo[i].consSeq);
			erpBudgetSeq.erpBudgetSeqG20 = consBudgetInfo[0].erpBudgetSeq;
			
			$ ( tbl.budget ).extable ( 'setAddRow', consBudgetInfo[i] );
		}
		
		table.focus($(tbl.budget), 0, 0);
		
		if(erpTypeCode == "iCUBE") {
			fnSelectBalanceBudget(erpBudgetSeq);	
		}
		
		$("[class*=row-cons-]").removeClass();
		$("[class*=row-budget-]").removeClass();
		
		/* 품의내역 테이블 class 선언 */
		for(var i=0; i<consSeqArray.length; i++) {
			$("#consTable > .rowHeight > table > tbody > tr:eq(" + i + ")").addClass("row-cons-" + consSeqArray[i]);	
		}
		
		/* 예산내역 테이블 calss 선언 */
		for(var i=0; i<budgetSeqArray.length; i++) {
			$("#budgetTable > .rowHeight > table > tbody > tr:eq(" + i + ")").addClass("cons_budgetRow row-budget-" + budgetSeqArray[i]);	
		}
		
		/* 결의정보에 따른 예산정보 숨김처리 */
 		$(".cons_budgetRow").hide();
		
 		$(".row-budget-" + firstConsSeq).show();
		
		return;
    }
    
    /* erp 정보가져오기 */
    function fnErpInfo() {
    	if(!optionSet.erpEmpInfo){
    		alert('ERP 사번 매핑을 확인해주세요.');
    		window.close();
    		return;
    	}
    	
    	var erpCompName = '';
    	var erpDeptName = '';
    	
    	if(erpTypeCode == 'iCUBE') {
    		erpCompName = optionSet.erpEmpInfo.erpCompName;	/* 회계단위 */
    		erpDeptName = optionSet.erpEmpInfo.erpDeptName;	/* 사용부서 */
    	} else {
    		erpCompName = optionSet.erpEmpInfo.erpPcName;	/* 회계단위 */
    		erpDeptName = optionSet.erpEmpInfo.erpCcName;	/* 사용부서 */ 
    	}
    	
    	var erpNum = optionSet.erpEmpInfo.erpEmpSeq;		/* erp사번 */
    	var erpName = optionSet.erpEmpInfo.erpEmpName;		/* 사용자 */
    	
    	$("#erpComp").html(erpCompName);
    	$("#erpDept").html(erpDeptName);
    	$("#erpNum").html(erpNum);
    	$("#erpName").html(erpName);
    }

    /* fnInit */
    /* formType 0일때 : 약식품의서, formType 1일때 : 정식품의서 */
    var formType = 0;
    function fnInit() {    	
    	formType = fnGetGwOptions(1, 1, '0');
        /* 양식 명칭 설정 진행 */
        var fnSetDisplayInfo = function () {
            if (optionSet.formInfo && optionSet.formInfo.formName) {
                $('#lbl_consTitle').contents().unbind().remove();
                $('#lbl_consTitle').html(optionSet.formInfo.formName || '');
            }
        };
        
        if("${approBefore}" == "Y") {
        	return;
        }

        /* [옵션분류] 옵션 분류 */
        /* 옵션 변경으로 인한 수정 - 신재호 */
        if (formType === '0') { $(".trade").hide(); /* 약식품의서 사용 */ }
        else { $(".trade").show(); fnDrawTradeInfo(); /* 정식품의서 사용 */ }
        
        /* [ TOP ] 품의서 정보 출력 지정 */
        fnSetDisplayInfo();
        
        /* [ 테이블 Lv1 ] 품의정보 테이블 그리기 */
        fnDrawConsInfo();
        
        /* [ 테이블 Lv2 ] 예산내역 테이블 그리기 */
        fnDrawBudgetInfo();

        return;
    }
    
    /* fnInitEvent */
    function fnInitEvent() {
        var docClear = function () {
            /* 모든 품의정보 삭제 */
            fnDeleteAllCons();
            
            /* 테이블 초기화 */
            $(tbl.cons).contents().unbind().remove();
            $(tbl.budget).contents().unbind().remove();
            $(tbl.trade).contents().unbind().remove();
        };

        $('#btnRefresh').click(function () {
        	if (confirm("기존 작성하였던 내용이 모두 사라집니다. 다시쓰기를 실행하시겠습니까??") == true){    //확인
        		docClear(); /* 페이지 초기화 기능 시작 */
                fnDrawConsInfo(); /* [ 테이블 Lv1 ] 품의정보 테이블 그리기 */
                fnDrawBudgetInfo(); /* [ 테이블 Lv2 ] 예산내역 테이블 그리기 */
                /* 옵션 변경으로 인한 수정 - 신재호 */
                if (formType === '0') { 
                	$(".trade").hide(); /* 약식품의서 사용 */ 
               	} else { 
               		$(".trade").show(); /* 정식품의서 사용 */ 
               		fnDrawTradeInfo();  
             	}
        	}else{   //취소
        	    return;
        	}
        });

        /* 결재 작성 버튼 */
        $('#btnApprovalOpen').click(function () { fnApprovalopen(); });

        /* 지난품의서 불러오기 */
        $('#btnConsLoad').click(function () {
        	fnPopConsLoad();
        });

		/* 품의정보 추가 */
		$ ( '#btnAddCons' ).click ( function ( ) {
			fnAddCons ( );
		} );
		/* 품의정보 삭제 */
		$ ( '#btnDelCons' ).click ( function ( ) {
			fnDeleteCons ( );
		} );
		/* 예산내역 추가 */
		$ ( '#btnAddBudget' ).click ( function ( ) {
			fnAddBudget ( );
		} );
		/* 예산내역 삭제 */
		$ ( '#btnDelBudget' ).click ( function ( ) {
			fnDelBudget ( );
		} );
		/* 거래처정보 추가 */
		$ ( '#btnAddTrade' ).click ( function ( ) {
			fnAddTrade ( );
		} );
		/* 거래처정보 삭제 */
		$ ( '#btnDelTrade' ).click ( function ( ) {
			fnDelTrade ( );
		} );
		return;
	}

    
	/* [품의문서] 최초생성
	----------------------------------------- */
	function fnInitConsDocSeq ( ) {
		var consDocInsertFlag = "${approBefore}";
		
		if(consDocInsertFlag == "N") {
			var result = fnAjax ( {
				url: '/ex/np/user/cons/ConsDocInsert.do',
				async: false,
				data: fnGetCommonAjaxParam()
			} );
			consDocSeq = ( result != null ? result.aData.consDocSeq : 0 );

			if ( !consDocSeq ) {
				$.error ( '품의서가 생성되지 않았습니다.' );
				alert ( '품의서 기초정보가 생성되지 않았습니다. 페이지를 새로고침(F5) 진행해 주세요.\r\n지속적으로 알림이 나타날 경우 관리자에게 문의해주세요.' );
			}
		} else {
			fnApprovalBefore();
		}
	}

	/*	[ 테이블 Lv1 ] 품의정보 테이블 그리기
	----------------------------------------- */
	function fnDrawConsInfo ( ) {
		$ ( tbl.cons ).extable ( {
			column: ((erpTypeCode == "iCUBE") ? consTableColumnG20 : consTableColumn),
			data: [ ],
			height: 135,
			clickBefore: function ( data ) {
				rowConsData = data;
				/* row 이동 확인 - row 이동 시 저장 및 수정 */
				if ( data.afterRowIndex != data.beforeRowIndex && table.check ( $ ( tbl.cons ) ).pass ) {
					fnSaveOrUpdateCons ( data, "click" );
					return true; /* 저장, 수정 구분 값 */
				} else if ( data.afterRowIndex != data.beforeRowIndex && !table.check ( $ ( tbl.cons ) ).pass ) {
					var focusFlag = rowConsData.data.docuFgName || rowConsData.data.docuFgCode;
					
					if ( focusFlag ) {
						fnParamCheck ( tbl.cons.replace ( '#', '' ) );
						return false;
					} else {
						return true;
					}
				} else {
					return true;
				}
			},
			clickAfter: function ( data ) {
				if(data.afterRowIndex != data.beforeRowIndex && (data.beforeRowIndex != -1)){
					/* 결의내역 클릭 시 저장된 예산내역 노출 */
					fnShowHideCons(data);
					fnInitBalanceAmt();
				} else if(data.beforeRowIndex == -1) {
					fnShowHideCons(data);
					fnInitBalanceAmt();
				}
				return true;
			},
			row: {
				classes: function ( ) {
					return 'cons_consRow ' + classes.cons + consSeq;
				}
			},
			tooltipFnc: function ( ) {
				var colInfo = $('#consTable').find('.colOn');
				var colIdx = $('#consTable').find('.colOn').index();
				
				if(colInfo.length > 0){
					$("#resHelp").text(this.column[colIdx].tooltip || '');
				} else {
					$("#resHelp").text("");
				}
			}
		} );

		if(!confferFlag || !approvalBeforeFlag) {
			table.addRow ( $ ( tbl.cons ), def.cons ( {
				consDocSeq: consDocSeq
			} ) );
			table.focus ( $ ( tbl.cons ), idxZero, idxZero );	
		}
	}

	/*	[ 테이블 Lv2 ] 예산내역 테이블 그리기
	----------------------------------------- */
	function fnDrawBudgetInfo ( ) {
		$ ( tbl.budget ).extable ( {
			column: ((erpTypeCode == "iCUBE") ? budgetTableColumnG20 : budgetTableColumn),
			data: [ ],
			height: 135,
			clickBefore: function ( data ) {
				console.log("clickBeforeBudget");
				rowBudgetData = data;
				/* 옵션 변경으로 인한 수정 - 신재호 */
				if (formType !== '0') {
					$('#budgetTable').extable('setRowDisable', 9, data.beforeRowIndex, 'disabled');
				}
				
				if ( data.afterRowIndex != data.beforeRowIndex && !data.data.budgetSeq ) {
					if ( table.check ( $ ( tbl.budget ) ).pass ) {
						fnSaveOrUpdateBudget ( data, 'click' );
						return true; /* 저장, 수정 구분 값 */
					} else if ( table.check ( $ ( tbl.cons ) ).pass ) {
						return true;
					}
				} else if ( data.afterRowIndex != data.beforeRowIndex ) {
					if ( table.check ( $ ( tbl.budget ) ).pass ) {
						if(approvalBeforeFlag) {
							return true;
						} else {
							fnSaveOrUpdateBudget ( data, 'click' );	
						}
						
						return true; /* 저장, 수정 구분 값 */
					}
					fnParamCheck ( tbl.budget.replace ( '#', '' ) );
					return false;
				} else {
					return true;
				}
				return true;
			},
			clickAfter: function ( data ) {
				console.log("clickAfter");
				console.log(data);
				/* 옵션 변경으로 인한 수정 - 신재호 */
				if (formType !== '0') { 
					if(data.afterRowIndex != data.beforeRowIndex && (data.beforeRowIndex != -1)){
						fnShowHideBudget(data);	
					} else if ((data.afterRowIndex == data.beforeRowIndex)) {
						fnShowHideBudget(data);
					}
				} else {
					if(erpTypeCode == 'iCUBE') {
						if(data.afterRowIndex != data.beforeRowIndex && (data.beforeRowIndex != -1)){
							if(data.data.erpBudgetSeqG20 != "") {
								var param = {};
								param.erpBudgetSeqG20 = data.data.erpBudgetSeqG20;
								param.erpBudgetNameG20 = data.data.erpBudgetNameG20;
								fnSelectBalanceBudget(param);
							} else {
								fnInitBalanceAmt();
							}	
						}
					}
				}
				return true;
			},
			row: {
				classes: function ( ) {
					return 'cons_budgetRow row-budget-' + table.selectRowData ( $ ( tbl.cons ) ).data.consSeq;
				}
			},
			tooltipFnc: function ( ) {
				var colInfo = $('#budgetTable').find('.colOn');
				var colIdx = $('#budgetTable').find('.colOn').index();
				
				if(colInfo.length > 0){
					$("#budgetHelp").text(this.column[colIdx].tooltip || '');
				} else {
					$("#budgetHelp").text("");
				}
			}
		} );
	}

	/*	[ 테이블 Lv3 ] 거래처 정보 테이블 그리기
	----------------------------------------- */
	function fnDrawTradeInfo ( ) {
		$ ( tbl.trade ).extable ( {
			column: ((erpTypeCode == "iCUBE") ? tradeTableColumnG20 : tradeTableColumn),
			data: [ ],
			height: 135,
			clickBefore: function ( data ) {
				rowTradeData = data;
				if ( data.afterRowIndex != data.beforeRowIndex && !data.tradeSeq ) {
					if ( table.check ( $ ( tbl.trade ) ).pass ) {
						fnSaveOrUpdateTrade ( data, 'click' );
						return true; /* 저장, 수정 구분 값 */
					}
				} else if ( data.afterRowIndex != data.beforeRowIndex ) {
					if ( table.check ( $ ( tbl.trade ) ).pass ) {
						fnSaveOrUpdateTrade ( data, 'click' );
						return true; /* 저장, 수정 구분 값 */
					}
					fnParamCheck ( tbl.trade.replace ( '#', '' ) );
					return false;
				} else {
					return true;
				}
			},
			clickAfter: function ( data ) {
				return true;
			},
			row: {
				classes: function ( ) {
					return 'cons_tradeRow row-trade-' + table.selectRowData ( $ ( tbl.budget ) ).data.budgetSeq;
				}
			}
		} );
	}

	/* [품의정보] 품의정보 추가
	----------------------------------------- */
	function fnAddCons ( ) {
		var consRowData = table.selectRowData ( $ ( tbl.cons ) ); // 현재 선택 되어 있는 품의정보 데이터 조회
		var consAllRow = table.allData($(tbl.cons));
		var consAddCheckFlag = false;
		
		/* 품의정보가 하나도 없을 경우 로우 생성 */
		if(consAllRow.length == 0) {
			fnAddDrawConsRow();
			return;
		}
		
		
		/* 품의정보 필수값 체크 */
		if ( table.check ( $ ( tbl.cons ) ).pass ) {
			/* 추가 버튼 클릭 시 저장 */
			var consRow = table.selectRowData ( $ ( tbl.cons ) );

			if ( consRow.data.consSeq == "" ) {
				fnSaveOrUpdateCons ( rowConsData, 'click' );
			}
			
			/* 예산내역 데이터 확인 */
			var budgetAllData = table.allData($(tbl.budget));
			
			if(budgetAllData.length != 0) {
				var budgetRowData = table.selectRowData($(tbl.budget));
				var budgetRowCheck = table.check($(tbl.budget));
				
				/* consSeq에 맞는 row수 있는지 확인 */
				for(var i=0; i<budgetAllData.length; i++) {
					if(budgetAllData[i].consSeq == consSeq && budgetAllData[i].budgetSeq != "") {
						consAddCheckFlag = true;
					}
				}
				
				if(consAddCheckFlag) {
					var lastConsIndex = table.allData($(tbl.cons)).length;
					
					if ( table.check ( $ ( tbl.cons ), lastConsIndex-1 ).pass ) {
						fnAddDrawConsRow();

						$ ( classes.row + table.rowData ( $ ( tbl.cons ), rowConsData.beforeRowIndex ).consSeq ).hide ( );	
					} else {
						fnParamCheck ( tbl.cons.replace ( '#', '' ) );
						return;
					}
				} else {
					if(budgetRowCheck.pass) {
						/* 예산내역 저장 */
						if(budgetRowData.data.budgetSeq == "") {
							fnSaveBudget ( rowBudgetData, 'enter' );
							fnAddDrawConsRow();

							$ ( classes.row + table.rowData ( $ ( tbl.cons ), rowConsData.beforeRowIndex ).consSeq ).hide ( );
						} else {
							fnAddDrawConsRow();
						}
					} else {
						fnParamCheck ( tbl.budget.replace ( '#', '' ) );
						return;
					}
				}
			} else {
				alert ( "예산내역을 입력하세요." );
				return;
			}
			
		} else {
			fnParamCheck ( tbl.cons.replace ( '#', '' ) );
			return;
		}
	}

	/* [예산내역] 예산내역 추가
	----------------------------------------- */
	function fnAddBudget ( ) {
		var consRowData = table.selectRowData ( $ ( tbl.cons ) ); // 현재 선택 되어 있는 품의정보 데이터 조회
		var budgetAddCheckFlag = false;
		
		/* 약식품의서 */
		var budgetAllData = table.allData ( $ ( tbl.budget ) );
		
		/* 현재 선택 된 품의정보 필수값 확인 */
		if( table.check($(tbl.cons), consRowData.data.rowIndex).pass) {
			var budgetRowData = table.selectRowData($(tbl.budget));
			
			
			/* 품의정보 row가 저장되지 않았을 경우 */
			if(consRowData.data.consSeq == "") {
				fnSaveOrUpdateCons ( rowConsData, 'click' );
			}
			
			/* 예산내역이 하나도 없을 경우 */
			if(budgetAllData.length == 0) {
				fnAddDrawBudgetRow();
			} else {
				/* 예산내역 필수값 확인 */
				if(table.check($(tbl.budget), budgetRowData.data.rowIndex).pass) {
					/* 예산내역 필수값이 저장되지 않았을 경우 */
					if(budgetRowData.data.budgetSeq == "") {
						fnSaveOrUpdateBudget ( rowBudgetData, 'click' );
					} else {
						fnAddDrawBudgetRow();
					}
				} else {
					var budgetCheckData = table.check ( $ ( tbl.budget ) );
					
					if(budgetCheckData.count == budgetCheckData.notInputCount) {
						var index = budgetRowData.rowIndex;
						
						table.removeRow($(tbl.budget), budgetRowData.rowIndex);
						
						fnAddDrawBudgetRow();
					} else {
						fnParamCheck ( tbl.budget.replace ( '#', '' ) );
						return false;
					}
				}
			}
		} else {
			fnParamCheck ( tbl.cons.replace ( '#', '' ) );
			return false;
		}
		
	}

	/* [거래처정보] 거래처 추가
	----------------------------------------- */
	function fnAddTrade ( ) {
		var budgetAllData = table.allData ( $ ( tbl.budget ) );
		var budgetRowData = '';
		if(budgetAllData.length > 0) {
			budgetRowData = table.selectRowData ( $ ( tbl.budget ) ); // 현재 선택 되어 있는 품의정보 데이터 조회	
		} else {
			alert("예산정보가 입력되지 않았습니다.");
			return;
		}
		
		var tradeAddCheckFlag = false;
		
		/* 현재 선택 된 예산내역 필수값 확인 */
		if( table.check($(tbl.budget), budgetRowData.data.rowIndex).pass) {
			var tradeRowData = table.selectRowData($(tbl.trade));
			
			/* 예산내역 row가 저장되지 않았을 경우 */
			if(budgetRowData.data.budgetSeq == "") {
				fnSaveBudget ( rowBudgetData, 'click' );
			}
			
			/* 거래처정보 필수값 확인 */
			if(table.check($(tbl.trade), tradeRowData.data.rowIndex).pass) {
				/* 예산내역 필수값이 저장되지 않았을 경우 */
				if(tradeRowData.data.tradeSeq == "") {
					fnTradeSave ( rowTradeData, 'click' );
				} else {
					fnParamCheck ( tbl.trade.replace ( '#', '' ) );
					return false;
				}
			} else {
				fnParamCheck ( tbl.trade.replace ( '#', '' ) );
				return false
			}
			
		} else {
			fnParamCheck ( tbl.budget.replace ( '#', '' ) );
			return false;
		}
	}

	/* [품의정보] 품의정보 삭제
	----------------------------------------- */
	function fnDeleteCons ( ) {
		/* 현재 선택 되어 있는 행 반환 */
		var selectRowData = table.selectRowData ( $ ( tbl.cons ) );

		if ( selectRowData.data.consSeq != "" ) {
			var result = fnAjax ( {
				url: '/ex/np/user/cons/ConsHeadDelete.do',
				async: false,
				data: {
					consDocSeq: selectRowData.data.consDocSeq,
					consSeq: selectRowData.data.consSeq
				}
			} );

			if ( result != null ) {
				table.removeRow ( $ ( tbl.cons ), selectRowData.rowIndex );
				
				/* 예산내역 remove */
				$(".row-budget-" + selectRowData.data.consSeq).remove();
				
				/* 거래처정보 remove */
				/* 옵션 변경으로 인한 수정 - 신재호 */
				if ( formType === '1' ) {
					var selectBudgetRow = table.selectRowData($(tbl.budget));
					$(".row-trade-" + selectBudgetRow.data.budgetSeq).remove();	
				}
			}
		}
	}
	
	/* [품의정보] 모든 품의정보 삭제
	----------------------------------------- */
	function fnDeleteAllCons ( ) {
		var allConsData = table.allData ( $ ( tbl.cons ) );

		for(var i=0; i<allConsData.length; i++) {
			var removeConsDocSeq = (allConsData[i].consDocSeq || '');
			var removeConsSeq = (allConsData[i].consSeq || '');
			
			var result = fnAjax ( {
				url: '/ex/np/user/cons/ConsHeadDelete.do',
				async: false,
				data: {
					consDocSeq: removeConsDocSeq,
					consSeq: removeConsSeq
				}
			} );
		}
		
		return;
	}

	/* [예산내역] 예산내역 삭제
	----------------------------------------- */
	function fnDelBudget ( ) {
		/* 현재 선택 되어 있는 행 반환 */
		var selectRowData = table.selectRowData ( $ ( tbl.budget ) );
		var consRowData = table.selectRowData ( $ ( tbl.cons ) );

		if ( selectRowData.data.budgetSeq != "" ) { // 예산 seq 생성 전
			var result = fnAjax ( {
				url: '/ex/np/user/cons/ConsBudgetDelete.do',
				async: false,
				data: {
					consDocSeq: selectRowData.data.consDocSeq,
					consSeq: selectRowData.data.consSeq,
					budgetSeq: selectRowData.data.budgetSeq
				}
			} );

			if ( result != null ) {
				var index = selectRowData.rowIndex;
				
				table.removeRow ( $ ( tbl.budget ), selectRowData.rowIndex );
				
				if(erpTypeCode == "iCUBE") {
					var param = {};
					
					if(index == 0) {
						$('#budgetTable').extable('setFocus', 11, 0);	
					} else {
						$('#budgetTable').extable('setFocus', 11, (index-1));
					}
					
					selectRowData = table.selectRowData ( $ ( tbl.budget ) );
					
					$ ( tbl.cons ).extable ( 'setRowData', {
						consAmt: fnAddComma(result.aData.amt)
					}, 5, consRowData.rowIndex );
					
					param.erpBudgetSeqG20 = selectRowData.data.erpBudgetSeqG20;
					fnSelectBalanceBudget(param);
					
				} else {
					$ ( tbl.cons ).extable ( 'setRowData', {
						consAmt: fnAddComma(result.aData.amt)
					}, 5, consRowData.rowIndex );
				}
			}
		} else {
			var index = selectRowData.rowIndex;
			
			table.removeRow ( $ ( tbl.budget ), selectRowData.rowIndex );
			
			if(erpTypeCode == "iCUBE") {
				$('#budgetTable').extable('setFocus', 11, (index-1));
				var param = {};
				
				selectRowData = table.selectRowData ( $ ( tbl.budget ) );
				
				param.erpBudgetSeqG20 = selectRowData.data.erpBudgetSeqG20;
				fnSelectBalanceBudget(param);
			}
		}
	}

	/* [거래처정보] 거래처 삭제
	----------------------------------------- */
	function fnDelTrade ( ) {
		/* 현재 선택 되어 있는 행 반환 */
		var selectRowData = table.selectRowData ( $ ( tbl.trade ) );

		if ( selectRowData.data.tradeSeq != "" ) { // 예산 seq 생성 전
			var result = fnAjax ( {
				url: '/ex/np/user/cons/ConsTradeDelete.do',
				async: false,
				data: {
					consDocSeq: selectRowData.data.consDocSeq,
					consSeq: selectRowData.data.consSeq,
					budgetSeq: selectRowData.data.budgetSeq,
					tradeSeq: selectRowData.data.tradeSeq
				}
			} );

			if ( result != null ) {
				table.removeRow ( $ ( tbl.trade ), selectRowData.rowIndex );
			}
		}
	}

	/* [품의정보] 품의정보 저장
		parameter : code(엔터저장,클릭저장 구분값)
	----------------------------------------- */
	function fnSaveCons ( data, code ) {
		/* input 포커스 삭제 */
		table.rmFocus ( $ ( tbl.cons ) );
		
		if(!approvalBeforeFlag) {
			consDocSeq = data.data.consDocSeq;
		}
		
		/* 품의정보 저장 */
		if ( table.check ( $ ( tbl.cons ) ).pass ) {
			var result = fnAjax ( {
				url: '/ex/np/user/cons/ConsHeadInsert.do',
				async: false,
				data: function ( ) {
					return $.extend ( fnGetCommonAjaxParam ( ), {
						consDocSeq: consDocSeq,
						docuFgCode: data.data.docuFgCode,
						docuFgName: data.data.docuFgName,
						consDate: data.data.consDate.replace(/\-/g, ''),
						consNote: erpTypeCode == 'iCUBE' ? data.data.consNoteG20 : data.data.consNote,
						projectName: data.data.projectName,
						projectSeq: data.data.projectSeq,
						causeDate: data.data.causeDate,
						inspectDate: data.data.inspectDate,
						signDate: data.data.signDate,
						causeEmpName: data.data.causeEmpName,
						causeEmpSeq: data.data.causeEmpSeq,
						spec: data.data.spec,
						erpDivSeq: optionSet.erpEmpInfo.erpDivSeq,
						erpDivName: optionSet.erpEmpInfo.erpDivName, 
						erpGisu: (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : ""), 
						gisu : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : ""),
						erpGisuFromDate: (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.fromDate : ""), 
						erpGisuToDate: (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.toDate : ""),
						erpMgtName: data.data.projectName,
						erpMgtSeq: data.data.projectSeq
					} );
				}
			} );

			if ( result != null ) {
				/* 품의정보 seq 생성 */
				consSeq = result.aData.consSeq;
				
				/* 테이블에 consSeq 저장 */
				switch ( code.toUpperCase ( ) ) {
					case 'CLICK':
						$ ( tbl.cons ).extable ( 'setRowData', {
							consSeq: result.aData.consSeq
						}, idxZero, data.beforeRowIndex );
						break;
					default:
						$ ( tbl.cons ).extable ( 'setRowData', {
							consSeq: result.aData.consSeq
						}, idxZero, data.rowIndex );
				}

				fnAddDrawBudgetRow();
			}
		} else {
			fnParamCheck ( tbl.cons.replace ( '#', '' ) );
		}
	}

	/* [예산내역] 예산내역 저장
		parameter : code(엔터저장,클릭저장 구분값)
	----------------------------------------- */
	function fnSaveBudget ( data, code ) {
		/* input 포커스 삭제 */
		table.rmFocus ( $ ( tbl.budget ) );
		var tmpConsDocSeq = 0; 
		var tmpConsSeq = 0;
		
		var consRowData = table.selectRowData($(tbl.cons));
		
		
		if(approvalBeforeFlag) {
			tmpConsDocSeq = consRowData.data.consDocSeq;
			tmpConsSeq = consRowData.data.consSeq;
		} else {
			tmpConsDocSeq = data.data.consDocSeq;
			tmpConsSeq = data.data.consSeq;
		}
		
		commonBudgetTableRowInfo.newData = data;
		if ( JSON.stringify ( commonBudgetTableRowInfo.newData ) == JSON.stringify ( commonBudgetTableRowInfo.orgnData ) ) { return; }
		
		var budgetTotalAmt = parseInt(data.data.budgetAmt.replace(/\,/g, ''));
		var budgetStdAmt = parseInt(budgetTotalAmt / 11.0 * 10.0);
		var budgetTaxAmt = budgetTotalAmt - budgetStdAmt;
		
		/* 예산내역 저장 */
		var result = fnAjax ( {
			url: '/ex/np/user/cons/ConsBudgetInsert.do',
			async: false,
			data: function ( ) {
				return $.extend ( fnGetCommonAjaxParam ( ), {
					consDocSeq : tmpConsDocSeq		 			// 품의 문서 키
					, consSeq : tmpConsSeq		 				// 품의서 키
					, budgetSeq : data.data.budgetSeq			// 품의 예산 키
					, budgetNote : (erpTypeCode == 'iCUBE' ? data.data.budgetNoteG20 : data.data.budgetNote) 		// 품의 예산 적요
					, budgetAmt : data.data.budgetAmt.replace(/\,/g, '') // 품의 예산 금액
					, erpBudgetSeq : erpTypeCode === 'iCUBE' ? data.data.erpBudgetSeqG20 : data.data.erpBudgetSeq 	// 예산단위 코드 지훈
					, erpBudgetName : erpTypeCode === 'iCUBE' ? data.data.erpBudgetNameG20 : data.data.erpBudgetName 	// 예산단위 이름
					, erpBizplanSeq : data.data.erpBizplanSeq 	// 사업계획 코드
					, erpBizplanName : data.data.erpBizplanName	// 사업계획 이름
					, erpBgacctSeq : data.data.erpBgacctSeq 	// 예산계정 코드
					, erpBgacctName : data.data.erpBgacctName 	// 예산계정 이름
					, erpFiacctSeq : data.data.erpFiacctSeq 	// 회계계정 코드
					, erpFiacctName : data.data.erpFiacctName 	// 회계계정 이름
					, expendDate : consRowData.data.consDate.replace(/\-/g, '')
					, budgetStdAmt : budgetStdAmt
					, budgetTaxAmt : budgetTaxAmt
					, setFgName : data.data.setFgName
					, setFgCode : data.data.setFgCode
					, vatFgName : data.data.vatFgName
					, vatFgCode : data.data.vatFgCode
					, trFgName : data.data.trFgName
					, trFgCode : data.data.trFgCode
					, erpDivName : data.data.erpDivName
					, erpDivSeq : data.data.erpDivSeq
					, projectName : consRowData.data.projectName
					, projectSeq : consRowData.data.projectSeq
					, erpMgtName : consRowData.data.projectName
					, erpMgtSeq : consRowData.data.projectSeq
					, erpGisu : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : "")
					, gisu : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : "")
					, erpBgt1Name : data.data.erpBgt1Name
					, erpBgt1Seq : data.data.erpBgt1Seq
					, erpBgt2Name : data.data.erpBgt2Name
					, erpBgt2Seq : data.data.erpBgt2Seq
					, erpBgt3Name : data.data.erpBgt3Name
					, erpBgt3Seq : data.data.erpBgt3Seq
					, erpBgt4Name : data.data.erpBgt4Name
					, erpBgt4Seq : data.data.erpBgt4Seq
					, erpOpenAmt : ($("#optionAmt").text().replace(/\,/g, '') || '0')
					, erpApplyAmt : ($("#applyAmt").text().replace(/\,/g, '') || '0')
					, erpLeftAmt : ($("#balanceAmt").text().replace(/\,/g, '') || '0')
				} );
			}
		} );

		if ( result != null ) {
			if ( result.resultCode == SUCCESS ) {
				log(result);
				var budgetAmt = result.aData.amt;
				budgetSeq = result.aData.budgetSeq;

				switch ( code.toUpperCase ( ) ) {
					case 'CLICK':
						console.log('click');
						$ ( tbl.budget ).extable ( 'setRowData', {
							consSeq: consSeq,
							consDocSeq: consDocSeq,
							budgetSeq: budgetSeq
						}, idxZero, data.beforeRowIndex );
						break;
					default:
						console.log('enter');
						$ ( tbl.budget ).extable ( 'setRowData', {
							consSeq: consSeq,
							consDocSeq: consDocSeq,
							budgetSeq: budgetSeq
						}, idxZero, data.rowIndex );
						break;
				}

				/* 품의정보 금액 추가 */
				var consAmtRow = table.selectRowData ( $ ( tbl.cons ) ).rowIndex;
				var budgetAmtRow = table.selectRowData ( $ ( tbl.budget ) ).rowIndex;
				$ ( tbl.cons ).extable ( 'setRowData', {
					consAmt: fnAddComma(budgetAmt)
				}, 5, consAmtRow );
				
				$ ( tbl.budget ).extable ( 'setRowData', {
					budgetAmt: fnAddComma(table.selectRowData ( $ ( tbl.budget ) ).data.budgetAmt)
				}, 10, budgetAmtRow );
				
				if(erpTypeCode == 'iCUBE') {
					fnInitBalanceAmt();
				}

				/* 옵션 변경으로 인한 수정 - 신재호 */
				if ( formType === '1' ) {
					//fnAddDrawTradeRow();
					var newRowNum = idxZero;
					newRowNum = $ ( "#tradeTable .cons_tradeRow" ).length;

					$ ( tbl.trade ).extable ( 'setAddRow', def.trade ( {
						consDocSeq: consDocSeq,
						consSeq: consSeq,
						budgetSeq: budgetSeq,
						tradeSeq: ''
					} ) );
					table.focus ( $ ( tbl.trade ), idxZero, newRowNum );
				} else {
					fnAddDrawBudgetRow();
				}
			} else if ( result.resultCode == EXCEED ) {
				var budgetAmt = result.aData.budgetAmt;
				var resultAmt = result.aData.resultAmt;
				exceed = true;

				alert ( "예산이 초과되었습니다.\n" + "남은 잔액 : " + fnAddComma ( budgetAmt ) + "원 / 적용 후 잔액 : " + fnAddComma ( resultAmt ) + "원" );
				return;
			}
		}
	}

	/* [거래처정보] 거래처정보 저장
		parameter : code(엔터저장,클릭저장 구분값)
	----------------------------------------- */
	function fnTradeSave ( data, code ) {
		table.rmFocus ( $ ( tbl.trade ) );
		
		var supAmt = 0;
		var vatAmt = 0;
		
		if(erpTypeCode == 'iCUBE') {
			
		} else {
			supAmt = parseInt((parseInt(data.data.tradeUnitAmt.toString().replace(/\,/g,'')) * parseInt(data.data.itemCnt)) / 11.0 * 10.0);
			vatAmt = (parseInt(data.data.tradeUnitAmt.toString().replace(/\,/g,'')) * parseInt(data.data.itemCnt)) - parseInt(supAmt);
		}
		
		
		var result = fnAjax ( {
			url: '/ex/np/user/cons/ConsTradeInsert.do',
			async: false,
			data: function ( ) {
				return $.extend ( fnGetCommonAjaxParam ( ), {
					consDocSeq: data.data.consDocSeq, //
					consSeq: data.data.consSeq, //
					budgetSeq: data.data.budgetSeq, // 예산단위 이름
					tradeSeq: data.data.tradeSeq,
					tradeNote: data.data.tradeNote, // 적요
					trName: data.data.trName,
					trSeq: data.data.trSeq,
					ceoName: data.data.ceoName, //
					itemName: data.data.itemName, //
					itemCnt: data.data.itemCnt, //
					tradeUnitAmt: data.data.tradeUnitAmt.toString().replace(/\,/g,''), //
					btrName: data.data.btrName, // 
					btrSeq: data.data.btrSeq,
					tradeStdAmt: parseInt(supAmt),
					tradeVatAmt: parseInt(vatAmt),
					baNb: data.data.baNb,
					depositor: data.data.depositor,
					tradeAmt: data.data.tradeAmt,
					card: data.data.card
				} );
			}
		} );

		if ( result != null ) {
			if ( result.resultCode == SUCCESS ) {
				console.log("거래처정보 저장");
				console.log(result);
				var tradeAmt = result.aData.tradeAmt;
				tradeSeq = result.aData.tradeSeq;

				switch ( code.toUpperCase ( ) ) {
					case 'CLICK':
						$ ( tbl.trade ).extable ( 'setRowData', {
							consSeq: consSeq,
							consDocSeq: consDocSeq,
							budgetSeq: budgetSeq,
							tradeSeq: tradeSeq
						}, idxZero, data.beforeRowIndex );
						break;
					default:
						$ ( tbl.trade ).extable ( 'setRowData', {
							consSeq: consSeq,
							consDocSeq: consDocSeq,
							budgetSeq: budgetSeq,
							tradeSeq: tradeSeq
						}, idxZero, data.rowIndex );
						break;
				}

				/* 품의정보 금액 추가 */
				var consAmtRow = table.selectRowData ( $ ( tbl.cons ) ).rowIndex;
				var budgetAmtRow = table.selectRowData ( $ ( tbl.budget ) ).rowIndex;
	            
				var amt = result.aData.amt;
				
				console.log("거래처 저장 후 금액정보");
				console.log(result);
				// TODO: 확인 필요 (데이터 넘어오는것)
				$(tbl.cons).extable('setRowData', { consAmt: fnAddComma(amt) }, 5, consAmtRow);
	            $(tbl.budget).extable('setRowData', { budgetAmt: fnAddComma(amt) }, 10, budgetAmtRow);

				var newRowNum = idxZero;
				newRowNum = $ ( "#tradeTable .cons_tradeRow" ).length;
				
				/* 거래처정보추가 */
				if ( code == "enter" ) {
					$ ( tbl.trade ).extable ( 'setAddRow', def.trade ( {
						consDocSeq: consDocSeq,
						consSeq: consSeq,
						budgetSeq: budgetSeq,
						tradeSeq: ''
					} ) );
					table.focus ( $ ( tbl.trade ), idxZero, newRowNum );
//					fnAddDrawTradeRow();
				}
			} else if ( result.resultCode == EXCEED ) {
				var budgetAmt = result.aData.budgetAmt;
				var resultAmt = result.aData.resultAmt;
				exceed = true;

				alert ( "예산이 초과되었습니다.\n" + "남은 잔액 : " + fnAddComma ( budgetAmt ) + "원 / 적용 후 잔액 : " + fnAddComma ( resultAmt ) + "원" );
				return;
			}
		}
	}
		
	/* [품의정보] 품의정보 변경
	----------------------------------------- */
	function fnUpdateCons ( data ) {
		commonConsTableRowInfo.newData = data.data;

		//if ( JSON.stringify ( commonConsTableRowInfo.newData ) == JSON.stringify ( commonConsTableRowInfo.orgnData ) ) { return; }
		console.log("품의정보 변경 파라미터");
		console.log(data);
		/* 예산 내역 이동 */
		table.rmFocus ( $ ( tbl.cons ) );

		var updateParamCheck = table.check ( $ ( tbl.cons ) ).pass;

		if ( updateParamCheck ) {
			var result = fnAjax ( {
				url: '/ex/np/user/cons/ConsHeadUpdate.do',
				async: false,
				data: function ( ) {
					return $.extend ( fnGetCommonAjaxParam ( ), {
						consDocSeq: data.data.consDocSeq,
						consSeq: data.data.consSeq,
						docuFgCode: data.data.docuFgCode,
						docuFgName: data.data.docuFgName,
						expendDate: data.data.consDate.replace(/\-/g, ''),
						consDate: data.data.consDate.replace(/\-/g, ''),
						consNote: data.data.consNote, 
						projectName: data.data.projectName,
						projectSeq: data.data.projectSeq,
						causeDate: data.data.causeDate,
						inspectDate: data.data.inspectDate,
						signDate: data.data.signDate,
						causeEmpName: data.data.causeEmpName,
						causeEmpSeq: data.data.causeEmpSeq,
						spec: data.data.spec,
						erpDivSeq: optionSet.erpEmpInfo.erpDivSeq,
						erpDivName: optionSet.erpEmpInfo.erpDivName, 
						erpGisu: (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : ""), 
						gisu : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : ""),
						erpGisuFromDate: (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.fromDate : ""), 
						erpGisuToDate: (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.toDate : ""),
						erpMgtName: data.data.projectName,
						erpMgtSeq: data.data.projectSeq
					} );
				}
			} );

			if ( result != null ) {
				if ( result.resultCode != SUCCESS ) {
					log ( result.resultName );
				}
			}
		} else {
			log ( '9' );
			var tableName = 'consTable';
			fnParamCheck ( tableName );
		}
	}

	/* [예산내역] 예산애역 변경
	----------------------------------------- */
	function fnUpdateBudget ( data, code ) {
		/* 예산 내역 이동 */
		table.rmFocus ( $ ( tbl.budget ) );

		/* 선택된 예산row 데이터 */
		var budgetRow = table.selectRowData( $ (tbl.budget) );
		var consRow = table.selectRowData( $ (tbl.cons) );
		/* 수정 시 포커스 조절 */
		var index = 0;
		
		commonBudgetTableRowInfo.newData = data.data;
		/* 포커스 위치 */
		index = $('.cons_budgetRow').eq(budgetRow.rowIndex).nextAll('.row-budget-' + data.data.consSeq).index();
		
		if(index == -1) {
			var newRowNum = idxZero;
			newRowNum = $ ( "#budgetTable .cons_budgetRow" ).length;
			
			if ( code == "enter" ) {
				fnAddDrawBudgetRow();
			}
		} else {
			var nextIndex = '';
			
			nextIndex = $(".cons_budgetRow").eq(budgetRow.rowIndex).nextAll('.row-budget-' + data.data.consSeq).index();
			table.focus ( $ ( tbl.budget ), idxZero, nextIndex );
		}
		
		var param = fnGetCommonAjaxParam ( );
		
		/* 품의서 GW정보  */
		param.consDocSeq = data.data.consDocSeq; 		// 품의 문서 키
		param.consSeq = data.data.consSeq; 				// 품의서 키
		param.budgetSeq = data.data.budgetSeq;			// 품의 예산 키
		param.budgetNote = data.data.budgetNote; 		// 품의 예산 적요
		param.budgetAmt = data.data.budgetAmt.replace(/\,/g, ''); // 품의 예산 금액
		
		param.erpBudgetSeq = data.data.erpBudgetSeq; 	// 예산단위 코드
		param.erpBudgetName = data.data.erpBudgetName; 	// 예산단위 이름
		
		param.erpBizPlanSeq = data.data.erpBizplanSeq; 	// 사업계획 코드
		param.erpBizPlanName = data.data.erpBizplanName;// 사업계획 이름
		
		param.erpBgacctSeq = data.data.erpBgacctSeq; 	// 예산계정 코드
		param.erpBgacctName = data.data.erpBgacctName; 	// 예산계정 이름
		
		param.erpFiacctSeq = data.data.erpFiacctSeq; 	// 회계계정 코드
		param.erpFiacctName = data.data.erpFiacctName; 	// 회계계정 이름
		
		param.erpBgt1Name = data.data.erpBgt1Name;
		param.erpBgt1Seq = data.data.erpBgt1Seq;
		param.erpBgt2Name = data.data.erpBgt2Name;
		param.erpBgt2Seq = data.data.erpBgt2Seq;
		param.erpBgt3Name = data.data.erpBgt3Name;
		param.erpBgt3Seq = data.data.erpBgt3Seq;
		param.erpBgt4Name = data.data.erpBgt4Name;
		param.erpBgt4Seq = data.data.erpBgt4Seq;
		param.erpOpenAmt = ($("#openAmt").text().replace(/\,/g, '') || '0');
		param.erpApplyAmt = ($("#applyAmt").text().replace(/\,/g, '') || '0');
		param.erpLeftAmt = ($("#balanceAmt").text().replace(/\,/g, '') || '0');
		
		if(erpTypeCode == "iCUBE") {
			var budgetTotalAmt = parseInt(data.data.budgetAmt.replace(/\,/g, ''));
			var budgetStdAmt = parseInt(budgetTotalAmt / 11.0 * 10.0);
			var budgetTaxAmt = budgetTotalAmt - budgetStdAmt;
			
			param.expendDate = consRow.data.consDate.replace(/\-/g, '');
			param.budgetStdAmt = budgetStdAmt;
			param.budgetTaxAmt = budgetTaxAmt;
			param.setFgName = data.data.setFgName;
			param.setFgCode = data.data.setFgCode;
			param.vatFgName = data.data.vatFgName;
			param.vatFgCode = data.data.vatFgCode;
			param.trFgName = data.data.trFgName;
			param.trFgCode = data.data.trFgCode;
			param.erpDivName = data.data.erpDivName;
			param.erpDivSeq = data.data.erpDivSeq;
			param.projectName = consRow.data.projectName;
			param.projectSeq = consRow.data.projectSeq;
			param.erpMgtName = consRow.data.projectName;
			param.erpMgtSeq = consRow.data.projectSeq;
			param.erpGisu = (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : "");
			param.gisu = (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : "");
			param.erpBudgetSeq = data.data.erpBudgetSeqG20; 	// 예산단위 코드
			param.erpBudgetName = data.data.erpBudgetNameG20; 	// 예산단위 이름
		}
		
		var updateParamCheck = table.check ( $ ( tbl.budget ), budgetRow.rowIndex ).pass;

		if ( updateParamCheck ) {
			var result = fnAjax ( {
				url: '/ex/np/user/cons/ConsBudgetUpdate.do',
				async: false,
				data: param
			} );

			if ( result != SUCCESS ) {
				log ( '예산정보 업데이트' );
				
				if ( result.resultCode == SUCCESS ) {
					/* 헤더 표기 예산 정보 업데이트 */
					var budgetAmt = result.aData.consAmt;
					$ ( tbl.cons ).extable ( 'setRowData', {
						consAmt: fnAddComma(budgetAmt)
					}, 5, table.selectRowData ( $ ( tbl.cons ) ).rowIndex );
				} else {
					log ( result.resultName );
				}
			}
		} else {
			log ( '10' );
			var tableName = 'budgetTable';
			fnParamCheck ( tableName );
		}

	}

	/* [거래처정보] 거래처정보 변경
	----------------------------------------- */
	function fnTradeUpdate ( data, code ) {
		/* 거래처정보 이동 */
		table.rmFocus ( $ ( tbl.trade ) );

		var param = fnGetCommonAjaxParam ( );

		if ( code == "click" ) {
			param.consDocSeq = data.consDocSeq; //
			param.consSeq = data.consSeq; //
			param.budgetSeq = data.budgetSeq; // 예산단위 이름
			param.tradeSeq = data.tradeSeq;
			param.tradeNote = data.tradeNote; // 적요
			param.trName = data.trName;
			param.trSeq = data.trSeq;
			param.ceoName = data.ceoName; // 
			param.itemName = data.itemName; //
			param.itemCnt = data.itemCnt; //
			param.tradeUnitAmt = data.tradeUnitAmt; //
			param.btrName = data.btrName; // 
			param.btrSeq = data.btrSeq;
			param.baNb = data.baNb;
		} else {
			param.consDocSeq = data.data.consDocSeq; //
			param.consSeq = data.data.consSeq; //
			param.budgetSeq = data.data.budgetSeq; // 예산단위 이름
			param.tradeSeq = data.data.tradeSeq;
			param.tradeNote = data.data.tradeNote; // 적요
			param.trName = data.data.trName;
			param.trSeq = data.data.trSeq;
			param.ceoName = data.data.ceoName; // 
			param.itemName = data.data.itemName; //
			param.itemCnt = data.data.itemCnt; //
			param.tradeUnitAmt = data.data.tradeUnitAmt; //
			//param.tradeAmt = data.data.tradeAmt; //
			param.btrName = data.data.btrName; // 
			param.btrSeq = data.data.btrSeq;
			param.baNb = data.data.baNb;
		}

		var updateParamCheck = table.check ( $ ( tbl.trade ) ).pass;

		var result = fnAjax ( {
			url: '/ex/np/user/cons/ConsTradeUpdate.do',
			async: false,
			data: param
		} );

		if ( result != null ) {
			log ( '거래처정보 업데이트' );
			/* 헤더 표기 예산 정보 업데이트 */
			var tradeAmt = result.aData.tradeAmt;
			$ ( tbl.trade ).extable ( 'setRowData', {
				tradeAmt: fnAddComma(tradeAmt)
			}, 5, table.selectRowData ( $ ( tbl.trade ) ).rowIndex );

			if ( result.resultCode == SUCCESS ) {
				var newRowNum = idxZero;
				newRowNum = $ ( "#tradeTable .cons_TradeRow" ).length;

				if ( code == "enter" ) {
					table.focus ( $ ( tbl.trade ), idxZero, newRowNum );
				}
			} else {
				$.error ( result.resultName );
			}
		}

		/*
		if (updateParamCheck) {
		    $.ajax({
		        type: 'post',
		        url: '<c:url value="/ex/np/user/cons/ConsTradeUpdate.do" />',
		        datatype: 'json',
		        async: false,
		        data: param,
		        success: function (result) {
		        	console.log('거래처정보 업데이트');
		        	var tradeAmt = result.result.aData.amt;
					$(tbl.trade).extable('setRowData', { amt: tradeAmt }, 5, table.selectRowData($(tbl.trade)).rowIndex);
		        	
		            if (result.resultCode == SUCCESS) {
		                var newRowNum = idxZero;
		                newRowNum = $("#tradeTable .cons_TradeRow").length;

		                if (code == "enter") {
		                    table.focus($(tbl.trade), idxZero, newRowNum);
		                }
		            } else {
		                log(result.resultName);
		            }
		        },
		        error: function (data) {
		            log('오류다!확인해봐!이상해~!!악!');
		        }
		    });
		} else {
		    var tableName = 'tradeTable';
		    fnParamCheck(tableName);
		}
		 */
	}

	/* [품의정보] 테이블 이동 시 수정,저장
		parameter : code(엔터저장,클릭저장 구분값)
	----------------------------------------- */
	function fnSaveOrUpdateCons ( data, code ) {
		/* 변경 데이터 확인 */
		commonConsTableRowInfo.table = 'consTable';
		commonConsTableRowInfo.newData = JSON.parse(JSON.stringify(data.beforeData));
		commonConsTableRowInfo.orgnData = JSON.parse(JSON.stringify(data.data));
		
		/* 변수 정의 */
		var beforeData = '';
		var afterData = '';
		var nowData = '';
		
		if(code == "click") {
			beforeData = table.rowData($(tbl.cons), data.beforeRowIndex);
			afterData = table.rowData($(tbl.cons), data.afterRowIndex);
			nowData = data.data;
		} else if(code == "enter") {
			beforeData = table.rowData($(tbl.cons), data.rowIndex);
			afterData = table.rowData($(tbl.cons), data.rowIndex);
			nowData = data.data;
		}
		
		if ( table.check ( $ ( tbl.cons ) ).pass ) {
			if(nowData.consSeq == "") {
				/* 품의정보 저장 */
				fnSaveCons(data, code);
			} else {
				/* 품의정보 수정 */
				fnUpdateCons(data, code);
			}
		} else {
			var tableName = 'consTable';
			fnParamCheck ( tableName );
			return;
		}
		
		$ ( ".cons_budgetRow" ).hide ( );
		$ ( classes.row + afterData.consSeq ).show ( );
	}

	/* [예산내역] 테이블 이동시 수정, 저장
	----------------------------------------- */
	function fnSaveOrUpdateBudget ( data, code ) {
		/* 변경 데이터 확인 */
		commonBudgetTableRowInfo.table = 'budgetTable';
		commonBudgetTableRowInfo.newData = JSON.parse(JSON.stringify(data.beforeData));
		commonBudgetTableRowInfo.orgnData = JSON.parse(JSON.stringify(data.data));
		
		/* 변수 정의 */
		var beforeData = '';
		var afterData = '';
		var nowData = '';
		
		if(code == "click") {
			beforeData = table.rowData($(tbl.budget), data.beforeRowIndex);
			afterData = table.rowData($(tbl.budget), data.afterRowIndex);
			nowData = data.data;
		} else if(code == "enter") {
			beforeData = table.rowData($(tbl.budget), data.rowIndex);
			afterData = table.rowData($(tbl.budget), data.rowIndex);
			nowData = data.data;
		}
		
		if ( table.check ( $ ( tbl.budget ) ).pass ) {
			if(nowData.budgetSeq == "") {
				/* 품의정보 저장 */
				fnSaveBudget(data, code);
			} else {
				/* 품의정보 수정 */
				fnUpdateBudget(data, code);
			}
		} else {
			var tableName = 'budgetTable';
			fnParamCheck ( tableName );
			return;
		}
		
		$ ( ".cons_tradeRow" ).hide ( );
		$ ( classes.trade + afterData.budgetSeq ).show ( );
	}

	/* [거래처정보] 테이블 이동시 수정, 저장
	----------------------------------------- */
	function fnSaveOrUpdateTrade ( data, code ) {
		/* 변경 데이터 확인 */
		commonTradeTableRowInfo.table = 'tradeTable';
		commonTradeTableRowInfo.newData = JSON.parse(JSON.stringify(data.beforeData));
		commonTradeTableRowInfo.orgnData = JSON.parse(JSON.stringify(data.data));
		
		/* 변수 정의 */
		var beforeData = '';
		var afterData = '';
		var nowData = '';
		
		if(code == "click") {
			beforeData = table.rowData($(tbl.trade), data.beforeRowIndex);
			afterData = table.rowData($(tbl.trade), data.afterRowIndex);
			nowData = data.data;
		} else if(code == "enter") {
			beforeData = table.rowData($(tbl.trade), data.rowIndex);
			afterData = table.rowData($(tbl.trade), data.rowIndex);
			nowData = data.data;
		}
		
		if ( table.check ( $ ( tbl.trade ) ).pass ) {
			if(nowData.tradeSeq == "") {
				/* 품의정보 저장 */
				fnTradeSave(data, code);
			} else {
				/* 품의정보 수정 */
				fnTradeUpdate(data, code);
			}
		} else {
			var tableName = 'tradeTable';
			fnParamCheck ( tableName );
			return;
		}
	}

	/* [ 필수항목 ] 필수항목 체크
	----------------------------------------- */
	function fnParamCheck ( tableName ) {
		var message = '';
		var param = table.check ( $ ( '#' + tableName ) );

		if ( !param.pass ) {
			for ( var i = idxZero; i < param.title.length; i++ ) {
				message += param.title [ i ] + ",";
			}

			alert ( message.slice ( idxZero, -1 ) + ' 값이 입력되지 않았습니다.' );

			return false;
		} else {
			return true;
		}
	}
	
	/*	[품의서] 클릭시 예산, 거래처 show, hide 
	----------------------------------------- */
	function fnShowHideCons(data) {
		var consRowData = table.rowData($(tbl.cons), data.afterRowIndex);
		log("컬럼 확인");
		log(consRowData);
		/* 옵션 변경으로 인한 수정 - 신재호 */
		if(formType === '0') {
			$(".cons_budgetRow").hide();
			$(".row-budget-" + consRowData.consSeq).show();
		} else {
			$(".cons_budgetRow").hide();
			$(".cons_tradeRow").hide();
			$(".row-budget-" + consRowData.consSeq).show();
		}
		
	}
	
	/*	[품의서] 예산 내역 클릭 시 거래처 정보 show, hide 
	----------------------------------------- */
	function fnShowHideBudget(data) {
		log("거래처 정보 show hide");
	}
	
	/*	[품의서] 품의정보 테이블 row 추가
	----------------------------------------- */
	function fnAddDrawConsRow() {
		var newRowIndex = 0;
		newRowIndex = $ ( "#consTable .cons_consRow" ).length;
		
		table.addRow ( $ ( tbl.cons ), def.cons ( {
			consDocSeq: consDocSeq
		} ) );
		table.focus ( $ ( tbl.cons ), 0, newRowIndex );
		
		setTimeout(function() { $("#consTable .inpTextBox").focus() }, 500);
	}
	
	
	/*	[품의서] 예산내역 테이블 row 추가 
	----------------------------------------- */
	function fnAddDrawBudgetRow() {
		var newRowIndex = 0;
		newRowIndex = $ ( "#budgetTable .cons_budgetRow" ).length;
		
		table.addRow ( $ ( tbl.budget ), def.budget ( {
			consDocSeq: consDocSeq,
			consSeq: consSeq,
			budgetSeq: ''
		} ) );
		
		table.focus ( $ ( tbl.budget ), 0, newRowIndex );
		
		setTimeout(function() { $("#budgetTable .inpTextBox").focus() }, 50);
		
		
	}
		
	/*	[품의서] 거래처 테이블 row 추가 
	----------------------------------------- */
// 	function fnAddDrawTradeRow() {
// 		var newRowIndex = 0;
// 		newRowIndex = $ ( "#tradeTable .cons_tradeRow" ).length;

// 		$ ( tbl.trade ).extable ( 'setAddRow', def.trade ( {
// 			consDocSeq: consDocSeq,
// 			consSeq: consSeq,
// 			budgetSeq: budgetSeq,
// 			tradeSeq: ''
// 		} ) );
		
// 		table.focus ( $ ( tbl.trade ), idxZero, newRowIndex );
// 	}	
	
	/*	[품의서] 지난 품의서 가져오기 
	----------------------------------------- */
	function fnPopConsLoad() {
		/* 팝업 호출 준비 */
		var url = "<c:url value='/expend/np/user/UserConsLoadPop.do'/>";
		var height = 450;
		
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = /*@cc_on!@*/false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		if ( isFirefox ) {
			height += 4;
		}
		if ( isIE ) {
			height += 0;
		}
		if ( isEdge ) {
			height -= 26;
		}
		if ( isChrome ) {
			height -= 6;
		}
		
		window.open('', "UserRefferConsPop", "width=" + 900 + ", height=" + height + ", left=" + 150 + ", top=" + 150);
		USER_refferConsPop.target = "UserRefferConsPop";
		USER_refferConsPop.method = "post";
		USER_refferConsPop.action = url;
		USER_refferConsPop.submit();
		USER_refferConsPop.target = "";
	}
	
	function fnCallbackRefferCons(data) {
		console.log(data);
		var result = fnAjax ( {
			url: '/expend/np/user/NPUserConsLoadList.do',
			async: false,
			data: function ( ) {
				return $.extend ( fnGetCommonAjaxParam ( ), {
					beforeConsDocSeq:data.consDocSeq,
					consDocSeq:consDocSeq
				} );
			}
		} );
		
		if( result != null || result == undefined ) {
			if(formType != "1") {
		        if (optionSet.formInfo && optionSet.formInfo.formName) {
		            $('#lbl_consTitle').contents().unbind().remove();
		            $('#lbl_consTitle').html(optionSet.formInfo.formName || '');
		        }
		        
		    	var consHeadInfo = new Array();
		    	var consBudgetInfo = new Array();
		    	var consTradeInfo = new Array();
		    	
		    	consHeadInfo = result.aData.consHeadInfo;
		    	consBudgetInfo = result.aData.budgetInfo;
		    	consTradeInfo = result.aData.tradeInfo;
				
				confferFlag = true;	
				approvalBeforeFlag = true;
				
				/* 기존 입력 초기화 */
				$(tbl.cons).contents().unbind().remove();
			    $(tbl.budget).contents().unbind().remove();
			    $(tbl.trade).contents().unbind().remove();

				
				fnDrawConsInfo();
				fnDrawBudgetInfo();
		 //		fnDrawTradeInfo();
				
				/* 결의정보 데이터 */
				var firstConsSeq = 0;
				for(var i=0; i<consHeadInfo.length; i++) {
					consHeadInfo[i].consNoteG20 = consBudgetInfo[i].consNote;
					$ ( tbl.cons ).extable ( 'setAddRow', consHeadInfo[i] );
					firstConsSeq = consHeadInfo[i].consSeq;	
				}
				table.focus($(tbl.cons), 0, 0);
				
				
				/* 예산내역 데이터 */
				var consArray = new Array();
				var erpBudgetSeq = {};
				for(var i=0; i<consBudgetInfo.length; i++) {
					consBudgetInfo[i].erpBudgetNameG20 = consBudgetInfo[i].erpBudgetName;
					consBudgetInfo[i].erpBudgetSeqG20 = consBudgetInfo[i].erpBudgetSeq;
					consBudgetInfo[i].budgetNoteG20 = consBudgetInfo[i].budgetNote;
					$ ( tbl.budget ).extable ( 'setAddRow', consBudgetInfo[i] );
					consArray.push(consBudgetInfo[i].consSeq);
					erpBudgetSeq.erpBudgetSeqG20 = consBudgetInfo[0].erpBudgetSeq;
				}
				
//				fnSelectBalanceBudget(erpBudgetSeq);
				
				$("[class*=row-cons-]").removeClass();
				$("[class*=row-budget-]").removeClass();
				
				for(var i=0; i<consArray.length; i++) {
					$("#consTable > .rowHeight > table > tbody > tr:eq(" + i + ")").addClass("row-" + i + " cons_budgetRow row-cons-" + consArray[i] + " cons-budget-"+consArray[i]);	
				}
				
				/* 결의정보에 따른 예산정보 숨김처리 */
				$(".cons_budgetRow").hide();
				
				$(".row-cons-" + firstConsSeq).show();
				
				$('#budgetTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N","N"]);

		 		table.focus($(tbl.budget), 0, 0);
			}
		}
			
	}
	
	/****************************************************************************************
										아래는 공통함수 영역 입니다.
	****************************************************************************************/	
	
	/*	[ POP ] 품의서 페이지 리사이즈
	----------------------------------------- */
	function fnResizePage ( ) {
		var optionHeight = eval ( optionSet.formInfo.formHeight );
		var optionWidth = eval ( optionSet.formInfo.formWidth );
		if ( !optionHeight ) {
			optionHeight = screen.height - 200;
		}
		if ( !optionWidth ) {
			optionWidth = screen.width - 400;
		}
		$ ( '.pop_wrap' ).css ( "overflow", "auto" );
		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = /*@cc_on!@*/false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		var divHeight = optionHeight;

		if ( isFirefox ) {
			divHeight -= 79;
		}
		if ( isIE ) {
			divHeight -= 70;
		}
		if ( isEdge ) {
			divHeight -= 70;
		}
		if ( isChrome ) {
			divHeight -= 67;
		}

		try {
			$ ( '.pop_wrap' ).height ( divHeight );
			window.resizeTo ( optionWidth, optionHeight );
		} catch ( exception ) {
			log ( '   [ERROR] fail to page resize.' );
		}

		try {
			var moveLeft = ( screen.width - optionWidth ) / 2;
			var moveTop = ( screen.height - optionHeight ) / 2;
			window.moveTo ( moveLeft, moveTop );
		} catch ( exception ) {
		}
		
		$(window).resize(function (e,d){
			$('.pop_wrap').height($(window).height() - 2);
		});
	}

	/*	[공용] 공용 파라미터 생성
	----------------------------------------- */
	function fnGetCommonAjaxParam ( ) {
		var returnObj = {};
		if ( optionSet.conVo.erpTypeCode == 'ERPiU' ) {
			var item = optionSet.erpEmpInfo;
			returnObj.erpBizName = (item.erpBizName || '');
			returnObj.erpBizSeq = (item.erpBizSeq || '');
			returnObj.erpCcName = (item.erpCcName || '');
			returnObj.erpCcSeq = (item.erpCcSeq || '');
			returnObj.erpCompName = (item.erpCompName || '');
			returnObj.erpCompSeq = (item.erpCompSeq || '');
			returnObj.erpDeptName = (item.erpDeptName || '');
			returnObj.erpDeptSeq = (item.erpDeptSeq || '');
			returnObj.erpEmpName = (item.erpEmpName || '');
			returnObj.erpEmpSeq = (item.erpEmpSeq || '');
			returnObj.erpPcName = (item.erpPcName || '');
			returnObj.erpPcSeq = (item.erpPcSeq || '');
			returnObj.erpDivName = (item.erpPcName || '');
			returnObj.erpDivSeq = (item.erpPcSeq || '');
			returnObj.erpGisu = '';
			returnObj.erpExpendYear = '';
		} else if ( optionSet.conVo.erpTypeCode == 'iCUBE' ) {
			var item = optionSet.erpEmpInfo;
			returnObj.erpCompName = (item.erpCompName || '');
			returnObj.erpCompSeq = (item.erpCompSeq || '');
			returnObj.erpDeptName = (item.erpDeptName || '');
			returnObj.erpDeptSeq = (item.erpDeptSeq || '');
			returnObj.erpEmpName = (item.erpEmpName || '');
			returnObj.erpEmpSeq = (item.erpEmpSeq || '');
			returnObj.erpDivName = (item.erpDivName || '');
			returnObj.erpDivSeq = (item.erpDivSeq || '');
			returnObj.erpGisu = optionSet.erpGisu.gisu;
			returnObj.erpExpendYear = optionSet.erpGisu.fromDate.substring(0,4);
		} else {
			log ( ' !! fnGetCommonAjaxParam : ERP 코드를 확인할 수 없습니다.' );
		}
		return JSON.parse ( JSON.stringify ( returnObj ) );
	}

	/* [공통] 공통코드 팝업
		----------------------------------------- */
	function fnCommonPop ( code, data ) {
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
		var selConsData = table.selectRowData ( $ ( tbl.cons ) );
		if ( optionSet.conVo.erpTypeCode == "ERPiU" ) {
			switch ( code.toLowerCase() ) {
				case "budget":
					/* 예산단위 파라미터 정의 */
					commonCodeData = [ {
						"CD_BUDGET": "test",
						"NM_BUDGET": "테스트"
					} ]
					break;
				case "bizplan":
					/* 사업계획 파라미터 정의 */
					/*
						useYNCondition : 사용유무 검색조건(A:전체, Y:사용, N:미사용)
						isConnectedBudget : 연결사업계획 조건( Y:연결사업계획 , '':전체)
					 */
					parameter.erpBudgetSeq = rowData.erpBudgetSeq;
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
					break;
				case "fiacct":
					/* 회계계정 파라미터 정의 */
					parameter.erpBgacctSeq = rowData.erpBgacctSeq;
					break;
				default:
					break;
			}
		} else if ( optionSet.conVo.erpTypeCode == "iCUBE" ) {
			switch ( code.toLowerCase() ) {
				case "project":
					/* 프로젝트 파라미터 정의 */
// 					if(data.data.projectSeq != "") {
// 						enterFlag = false;
// 					}
					parameter.projectName = rowData.projectName;
					parameter.projectSeq = rowData.projectSeq;
					break;
				case "tr":
// 					if(data.data.trSeq != "") {
// 						enterFlag = false;
// 					}
					/* 입출금계좌 파라미터 정의 */
					/* 1: 일반거래처, 2: 금융거래처*/
					parameter.trType = "2"
					break;
				case "budgetlist":
// 					if(data.data.erpBudgetSeqG20 != "") {
// 						enterFlag = false;
// 					}
					/* 예산과목 파라미터 정의 */
					parameter.erpGisu = optionSet.erpGisu.gisu;		/* ERP 기수 */
					parameter.erpGisuFromDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
					parameter.erpGisuToDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
					parameter.gisu = optionSet.erpGisu.gisu;		/* ERP 기수 */
					parameter.frDate = optionSet.erpGisu.fromDate; /* 기수 시작일 */
					parameter.toDate = optionSet.erpGisu.toDate; /* 기수 종료일 */
					parameter.erpDivSeq =	optionSet.erpEmpInfo.erpDivSeq + "|"; /* 회계통제단위 구분값 '|' */                        
					parameter.projectSeq = selConsData.data.projectSeq; /* 예산통제단위 구분값 '|' */
					parameter.erpMgtSeq = selConsData.data.projectSeq + "|";
					parameter.opt01 = '2'; /* 1: 모든 예산과목, 2: 당기편성, 3: 프로젝트 기간 예산 */    
					parameter.opt02 = '1'; /* 1: 모두표시, 2: 사용기한결과분 숨김 */                
					parameter.opt03 = '';
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

	/* [공통] 공통코드 팝업 콜백
	----------------------------------------- */
	function fnCommonPopCallback ( param ) {
		/* 선택 행 정보 저장(rowIndex 등) */
		var dummy = JSON.parse ( param.dummy );
		console.log("공통코드 팝업 콜백");
		console.log(dummy);
		/* 선택된 테이블 데이터 저장 변수(budget, bizplan 등) */
		var rowData = table.rowData ( $ ( '#' + dummy.tblId ), dummy.rowIndex );
		if ( optionSet.conVo.erpTypeCode == "ERPiU" ) {
			switch ( param.code.toLowerCase() ) {
				case "budget":
					/* 예산단위 콜백 */
					console.log('상배 예산 단위 콜백');
					console.log(param);
					rowData.erpBudgetName = param.NM_BUDGET;
					rowData.erpBudgetSeq = param.CD_BUDGET;
					break;
				case "bizplan":
					/* 사업계획 콜백 */
					console.log('상배 사업 계획 콜백');
					console.log(param);
					rowData.erpBizplanName = param.NM_BIZPLAN;
					rowData.erpBizplanSeq = param.CD_BIZPLAN;
					break;
				case "bgacct":
					/* 예산계정 콜백 */
					console.log('상배 예산 계정 콜백');
					console.log(param);
					rowData.erpBgacctName = param.NM_BGACCT;
					rowData.erpBgacctSeq = param.CD_BGACCT;
					break;
				case "fiacct":
					/* 회계계정 콜백 */
					rowData.erpFiacctName = param.NM_ACCT;
					rowData.erpFiacctSeq = param.CD_ACCT;
					break;
				case "tr":
					/* 거래처 콜백 */
					rowData.trName = param.LN_PARTNER;
					rowData.trSeq = param.CD_PARTNER;
					
					
					if( param.NM_CEO !== undefined){
						rowData.ceoName = param.NM_CEO;
					}
					if( param.NM_BANK !== undefined){
						rowData.btrName = param.NM_BANK;
					}
					if( param.NO_DEPOSIT !== undefined){
						rowData.baNb = param.NO_DEPOSIT;
					}
					if( param.NM_DEPOSIT !== undefined){
						rowData.depositor = param.NM_DEPOSIT;
					}
					if( param.CD_BANK !== undefined) {
						rowData.btrSeq = param.CD_BANK;
					}
					break;
				default:
					break;
			}
		} else if ( optionSet.conVo.erpTypeCode == "iCUBE" ) {
			switch ( param.code.toLowerCase() ) {
				case "project":
					/* 프로젝트 콜백 */
					rowData.projectName = param.pjtName;
					rowData.projectSeq = param.pjtSeq;
					break;
				case "tr":
					/* 입출금계좌 콜백 */
					rowData.btrNumber = ( param.bankNumber || '' );
					break;
				case "budgetlist":
					/* 예산과목 콜백 */
					
					rowData.erpBudgetNameG20 = param.BGT_NM;
					rowData.erpBudgetSeqG20 = ( param.BGT_CD || '' );
					rowData.erpBgt1Name = (param.BGT01_NM || '');
					rowData.erpBgt1Seq = (param.BGT01_CD || '');
					rowData.erpBgt2Name = (param.BGT02_NM || '');
					rowData.erpBgt2Seq = (param.BGT02_CD || '');
					rowData.erpBgt3Name = (param.BGT03_NM || '');
					rowData.erpBgt3Seq = (param.BGT03_CD || '');
					rowData.erpBgt4Name = (param.BGT04_NM || '');
					rowData.erpBgt4Seq = (param.BGT04_CD || '');
					
					fnSelectBalanceBudget(rowData);
					break;
				case "div":
					rowData.erpDivSeq = (param.divSeq || '');
					rowData.erpDivName = (param.divName || '');
					break;
				default:
					break;
			}
		}

		$ ( '#' + dummy.tblId ).extable ( 'setRowData', rowData, 0, dummy.rowIndex );
	}
	
	/*	[예산잔액 조회] 예산잔액 조회
	----------------------------------------- */
	function fnSelectBalanceBudget(budgetParam) {
		var selConsData = table.selectRowData ( $ ( tbl.cons ) );
		var selBudgetData = table.selectRowData ( $ ( tbl.budget ) );

		var result = fnAjax ( {
			url: '/ex/np/user/cons/budgetInfoSelect.do',
			async: false,
			data: {
				erpDivSeq: optionSet.erpEmpInfo.erpDivSeq,
				erpMgtSeq: selConsData.data.projectSeq,
				erpCompSeq: optionSet.erpEmpInfo.erpCompSeq,
				erpBudgetSeq: budgetParam.erpBudgetSeqG20,
				erpBudgetName: budgetParam.erpBudgetNameG20,
				gisu: optionSet.erpGisu.gisu,
				erpButtomSeq: '',
				erpGisuDate: selConsData.data.consDate,
				consDocSeq: selConsData.data.consDocSeq
			}
		} );

		if ( result != null || result == undefined ) {
			console.log("예산잔액 결과");
			console.log(result);
			$("#openAmt").text(fnAddComma(result.aData.openAmt));
			$("#applyAmt").text(fnAddComma(result.aData.applyAmt));
			$("#tryAmt").text(fnAddComma(result.aData.tryAmt));
			$("#balanceAmt").text(fnAddComma(result.aData.balanceAmt));
			return;
		}else{
			alert ( "예산잔액 조회중에 오류가 발생했습니다." );
			return;
		}
	}

	/* [버튼] 결재작성 이벤트
	----------------------------------------- */
	function fnApprovalopen ( ) {
		var consRowData = table.selectRowData ( $ ( tbl.cons ) );
		var budgetRowData = table.selectRowData ( $ ( tbl.budget ) );
		
		if(formType != "0") {
			var tradeRowData = table.selectRowData ( $ ( tbl.trade ) );	
		}
		
		if(consDocSeq == "") {
			consDocSeq = consRowData.data.consDocSeq;
		}
		
		
		/* 결의정보 내역 확인 */
		if(consRowData.data != null) {
			var consDataCheck = table.check ( $ ( tbl.cons ) );
			
			if(!table.check ( $ ( tbl.cons ) ).pass) {
				if(consDataCheck.count == consDataCheck.notInputCount) {
					var index = consRowData.rowIndex;
					
					table.removeRow($(tbl.cons), consRowData.rowIndex);
					
					if(erpTypeCode == "iCUBE") {
						$('#consTable').extable('setFocus', 11, (index-1));	
					} else {
						$('#consTable').extable('setFocus', 3, (index-1));
					}
				} else {
					fnParamCheck ( tbl.cons.replace ( '#', '' ) );
					return;	
				}
				
			} else {
				if(consRowData.data.consSeq == "") {
					fnSaveOrUpdateCons(rowConsData, 'enter');
				}
			}
		} else {
			alert("결의정보내역을 확인해주세요");
			return;
		}
		
		/* 예산정보 내역 확인 */
		if(budgetRowData.data != null) {
			var budgetDataCheck = table.check ( $ ( tbl.budget ) );
			
			if(!table.check ( $ ( tbl.budget ) ).pass) {
				if(budgetDataCheck.count == budgetDataCheck.notInputCount) {
					var index = budgetRowData.rowIndex;
					
					table.removeRow($(tbl.budget), budgetRowData.rowIndex);
					
					if(erpTypeCode == "iCUBE") {
						$('#budgetTable').extable('setFocus', 10, (index-1));	
					} else {
						$('#budgetTable').extable('setFocus', 8, (index-1));
					}
				} else {
					fnParamCheck ( tbl.budget.replace ( '#', '' ) );
					return;	
				}
				
			} else {
				if(budgetRowData.data.budgetSeq == "") {
					fnSaveOrUpdateBudget(rowBudgetData, 'enter');	
				}
			}
		} else {
			alert("예산정보내역을 확인해주세요");
			return;
		}
		
		if (formType != '0') {
			/* 거래처정보 내역 확인 */
			if(tradeRowData.data != null) {
				if(!table.check ( $ ( tbl.trade ) ).pass) {
					fnParamCheck ( tbl.trade.replace ( '#', '' ) );
					return;
				} else {
					fnSaveOrUpdateTrade(rowTradeData, 'enter');
				}
			} else {
				alert("거래처정보내역을 확인해주세요");
				return;
			}
		}
		
		var result = fnAjax ( {
			url: '/ex/np/user/cons/interlock/ExDocMake.do',
			async: false,
			data: {
				processId: optionSet.formInfo.formDTp,
				approKey: optionSet.formInfo.formDTp + '_NP_' + consDocSeq,
				consDocSeq: consDocSeq,
				interlockName: '정보수정',
				// 20180910 soyoung, interlockName 정보수정 영문/일문/중문 추가
				interlockNameEn: 'Edit information',
				interlockNameJp: '情報修正',
				interlockNameCn: '信息修改',
				docSeq: '',
				formSeq: optionSet.formInfo.formSeq,
				header: '',
				content: '',
				footer: '',
				eapCallDomain: ( origin || '' )
			}
		} );

		if ( result != null || result == undefined ) {
			fnDocPopOpen ( result );
		}else{
			alert ( "전자결재 문서 생성 중 오류가 발생하였습니다." );
			return;
		}
	}

	/* [결재작성] 결재 작성창 오픈 이벤트
	----------------------------------------- */
	function fnDocPopOpen ( data ) {
		var url = '/' + data.eaType + '/ea/interface/eadocpop.do';
		if ( data.eaType == "eap" ) {
			if ( data.docSeq != '0' && data.eaType != '' && data.formSeq != '0' && data.approKey != '' ) {
				url = url + '?form_id=' + optionSet.formInfo.formSeq;
				url = url + '&docId=' + data.docSeq;
				url = url + '&approKey=' + data.approKey;
				url = url + '&processId=' + optionSet.formInfo.formDTp;
			} else {
				alert ( "전자결재 문서 생성 중 오류가 발생하였습니다." );
				return;
			}
		} else if ( data.eaType == "ea" ) {
			url = url + '?form_id=' + optionSet.formInfo.formSeq;
			url = url + '&docId=' + '';
			url = url + '&approKey=' + data.approKey;
			url = url + '&processId=' + optionSet.formInfo.formDTp;

		} else {
			alert ( "전자결재 문서 생성 중 오류가 발생하였습니다." );
			return;
		}
		var thisX = parseInt ( document.body.scrollWidth );
		var thisY = parseInt ( document.body.scrollHeight );
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 50;

		if ( maxThisX > 1000 ) {
			maxThisX = 1000;
		}
		var marginY = idxZero;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
		if ( navigator.userAgent.indexOf ( "MSIE 6" ) > idxZero ) marginY = 45; // IE 6.x
		else if ( navigator.userAgent.indexOf ( "MSIE 7" ) > idxZero ) marginY = 75; // IE 7.x
		else if ( navigator.userAgent.indexOf ( "Firefox" ) > idxZero ) marginY = 50; // FF
		else if ( navigator.userAgent.indexOf ( "Opera" ) > idxZero ) marginY = 30; // Opera
		else if ( navigator.userAgent.indexOf ( "Netscape" ) > idxZero ) marginY = -2; // Netscape

		if ( thisX > maxThisX ) {
			window.document.body.scroll = "yes";
			thisX = maxThisX;
		}
		if ( thisY > maxThisY - marginY ) {
			window.document.body.scroll = "yes";
			thisX += 19;
			thisY = maxThisY - marginY;
		}

		// 센터 정렬
		var windowX = ( screen.width - ( maxThisX + 10 ) ) / 2;
		var windowY = ( screen.height - ( maxThisY ) ) / 2 - 20;
		/* location.href : [기능 : 새로운 페이지로 이동된다] [형태 : 속성] [주소 히스토리 : 기록된다] [사용예 : location.href='url'] */
		/* location.replace : [기능 : 기존페이지를 새로운 페이지로 변경시킨다] [형태 : 메서드] [주소 히스토리 : 기록되지 않는다] [사용예 : location.replace('url')] */
		/* 지출결의 특성상 뒤로가기를 이용하여 이전페이지로 돌아오면 안되기 때문에 replace 를 사용한다. */
		var win = window.open ( url, '', "scrollbars=yes,resizable=yes,width=" + maxThisX + ",height=" + ( maxThisY - 50 ) + ",top=" + windowY + ",left=" + windowX );
		if ( win == null || win.screenLeft == idxZero ) {
			alert ( "브라우져 팝업차단 설정을 확인해 주세요" );
		} else {
			self.close ( );
		}

	}
	
	/*	[품의서] 예산 정보 초기화
    ----------------------------------------- */
	function fnInitBalanceAmt() {
		$("#openAmt").text("0");
		$("#applyAmt").text("0");
		$("#tryAmt").text("0");
		$("#balanceAmt").text("0");
	}
</script>

<div class="pop_wrap">
	<div class="pop_sign_head posi_re">
		<h1 id="lbl_consTitle"></h1>
		<div class="psh_btnbox">
			
			<!-- 양식팝업 오른쪽 버튼그룹 -->
			<div class="psh_right">
				<div class="btn_cen mt8">
					<input id="btnApprovalOpen" type="button" class="psh_btn" value="결재작성" />
				</div>
			</div>
		</div>
	</div>	

	<div class="pop_con">
		<div class="top_box gray_box" id="erpEmpInfo">
			<dl>
				<dt class="fwn">${CL.ex_accountingUnit}  <!--회계단위--> :</dt>
				<dd class="mt20 fwb" style="margin-right:100px;" id="erpComp"></dd>
				<dt class="fwn">${CL.ex_useDepartment}  <!--사용부서--> :</dt>
				<dd class="mt20 fwb" style="margin-right:100px;" id="erpDept"></dd>
				<dt class="fwn">${CL.ex_empSeq}  <!--사번--> :</dt>
				<dd class="mt20 fwb" style="margin-right:100px;" id="erpNum"></dd>
				<dt class="fwn">${CL.ex_user}  <!--사용자--> :</dt>
				<dd class="mt20 fwb" id="erpName"></dd>
			</dl>
		</div>
	
		<div class="btn_div mt20">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">${ CL.ex_consInfo } <!--품의서정보--> <span class="text_red fwn ml10" id="resHelp"></span> </p>	
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnConsLoad" style="display:none;" >${CL.ex_consPull}  <!--품의서 불러오기--></button>
					<button id="btnRefresh">${CL.ex_reWrite}  <!--다시쓰기--></button>
					<button id="btnAddCons">${CL.ex_add}  <!--추가--></button>
					<button id="btnDelCons">${CL.ex_remove}  <!--삭제--></button>
				</div>
			</div>
		</div>
			
		<div id="consTable"></div><!--//table1 -->

		<div style="height:20px;"></div>
		<div class="btn_div mt0">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">${ CL.ex_budgetInfo } <!--예산내역--> <span class="text_red fwn ml10" id="budgetHelp"></span></p>	
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnAddBudget">${CL.ex_add}  <!--추가--></button>
					<button id="btnDelBudget">${CL.ex_remove}  <!--삭제--></button>
				</div>
			</div>
		</div>
		
		<div id="budgetTable">
		</div>
		
		<div class="trade" style="height:20px;"></div>
		<div class="btn_div mt0 trade" style="display:none;">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">${CL.ex_tradeInfo }  <!--거래처 정보--> <span class="text_red fwn ml10"></span> </p>	
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnAddTrade">${CL.ex_add}  <!--추가--></button>
					<button id="btnDelTrade">${CL.ex_remove}  <!--삭제--></button>
				</div>
			</div>
		</div>
			
		<div class="trade" id="tradeTable" style="display:none;">
		</div>
		
		<div class="com_ta mt20" id="erpBudgetInfo">
			<table>
				<colgroup>
					<col width="120">
					<col width="18%">
					<col width="120">
					<col width="18%">
					<col width="120">
					<col width="18%">
					<col width="120">
					<col width="18%">
				</colgroup>
				<tr>
					<th>${CL.ex_budgetAmt}  <!--예산금액--></th>
					<td class="ri pr5" id="openAmt">0</td>
					<th>${CL.ex_budgetExcutionAmt}  <!--집행금액--></th>
					<td class="ri pr5" id="applyAmt">0</td>
					<th>${CL.ex_thisTimeExecution}  <!--금회집행--></th>
					<td class="ri pr5" id="tryAmt">0</td>
					<th>${CL.ex_budgetBalance}  <!--예산잔액--></th>
					<td class="ri pr5" id="balanceAmt">0</td>
				</tr>
			</table>
		</div>
									
	</div><!-- //pop_con -->
	

</div><!-- //pop_wrap -->

<form id="USER_refferConsPop" name="frmPop" method="post">
</form>	 