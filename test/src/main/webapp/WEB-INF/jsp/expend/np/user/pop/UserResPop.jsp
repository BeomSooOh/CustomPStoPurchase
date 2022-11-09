<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<jsp:useBean id="currentTime" class="java.util.Date" />
<script type="text/javascript" src="/exp/js/np/ex-ui-1.0.1.js"></script>
<script type="text/javascript" src="/exp/js/ex/jquery.ex.format.js"></script>

<jsp:include page="../include/UserOptionMap.jsp" flush="false" />
<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<script>
	/*팝업 위치설정*/
	$(document).ready(function() {
		pop_position();
		$(window).resize(function() { 
				pop_position();
		});
	});
	var devMode = 'debug';
	function log(obj) {
	    if (devMode === 'debug') {
	        console.log(obj)
	    }
	};
	/* 테스트 전역 변수 */
	var resDocSeq = '',  	 /* 품의서  문서 단위 시퀀스 */
	    resSeq = '', 		 /* 품의서 항목 시퀀스 */
	    budgetSeq = '', 	 /* 예산내역 시퀀스 */
	    tradeSeq = '', 		 /* 예산내역 시퀀스 */
	    rowResData = '', 	 /* 현재 결의행의 모든 데이터 */
	    rowBudgetData = '',	 /* 현재 예산내역행의 모든 데이터 */
	    rowTradeData = '',	 /* 현재 거래내역의 모든 데이터 */
	    callbackTableFocusX, /* 콜백 함수에서 테이블 정보 저장 */
	    callbackTableFocusY, /* 콜백 함수에서 테이블 정보 저장 */
	    erpTypecode,		 /* ERP 구분 */
	    commonResTableRowInfo = {			/* 결의정보 중복체크 변수 */
	        table: { /* 테이블 기본정보 */ },
	        newData: { /* 입력 후 데이터 */ },
	        orgnData: { /* 입력 전 데이터 */ }
	    },
	    commonBudgetTableRowInfo = {		/* 예산내역 중복체크 변수 */
	       table: { /* 테이블 기본정보 */ },
	       newData: { /* 입력 후 데이터 */ },
	       orgnData: { /* 입력 전 데이터 */ }
	    },
	    commonTradeTableRowInfo = {			/* 거래내역 중복체크 변수 */
	       table: { /* 테이블 기본정보 */ },
	       newData: { /* 입력 후 데이터 */ },
	       orgnData: { /* 입력 전 데이터 */ }
	    },
	    docuFgList =  [	{ 'docuFgCode': '1', 'docuFgName': '${CL.ex_expendRes}' }		// 지출결의서
					    , { 'docuFgCode': '2', 'docuFgName': '${CL.ex_corpRes}' }		// 공사집행지출결의서
					    , { 'docuFgCode': '3', 'docuFgName': '${CL.ex_serviceRes}' }		// 용역과지출결의서
					    , { 'docuFgCode': '4', 'docuFgName': '${CL.ex_buyRes}' }		// 구입과지출결의서
					    , { 'docuFgCode': '5', 'docuFgName': '${CL.ex_incomeRes}' }		// 수입결의서
					    , { 'docuFgCode': '6', 'docuFgName': '${CL.ex_fellowRes}' }		// 여입결의서
					    , { 'docuFgCode': '7', 'docuFgName': '${CL.ex_returnRes}' }		// 반납결의서
					    , { 'docuFgCode': '8', 'docuFgName': '${CL.ex_tripRes}' }	// 여비지출결의서
					    , { 'docuFgCode': '9', 'docuFgName': '${CL.ex_salaryRes}' }	// 봉급지출결의서
	    ]
		,	
	    setFgList = [	{ 'setFgCode': '1', 'setFgName': '${CL.ex_deposit}' }	// 예금
					    , { 'setFgCode': '2', 'setFgName': '${CL.ex_cash}' }	// 현금
					    , { 'setFgCode': '3', 'setFgName': '${CL.ex_debt}' }	// 외상
					    , { 'setFgCode': '4', 'setFgName': '${CL.ex_card}' }	// 카드
	    ], 	
	    vatFgList = [	{ 'vatFgCode': '1', 'vatFgName': '${CL.ex_tax}' }		// 과세
	    				, { 'vatFgCode': '2', 'vatFgName': '${CL.ex_taxFree}' }	// 면세
	    				, { 'vatFgCode': '3', 'vatFgName': '${CL.ex_etc}' }		// 기타
 		], 	
	    trFgList = optionSet.conVo.erpTypeCode == 'ERPiU'						/* 과세구분 */
	    	? [	{ 'trFgCode': '1', 'trFgName': '${CL.ex_vendor}' }			// 거래처
	    		, { 'trFgCode': '2', 'trFgName': '${CL.ex_empAdd}' }		// 사원등록
	    		, { 'trFgCode': '3', 'trFgName': '${CL.ex_vendorName}' }	// 거래처명
	    		, { 'trFgCode': '4', 'trFgName': '${CL.ex_etcEarner}' }		// 기타소득자
	    		, { 'trFgCode': '5', 'trFgName': '급여' }		// 급여
	    		, { 'trFgCode': '6', 'trFgName': '사업소득자' }	// 사업소득자
	    	] 	/* 채주유형  ERPiU */
	    	: [	{ 'trFgCode': '1', 'trFgName': '거래처' }		// 거래처
		    	, { 'trFgCode': '2', 'trFgName': '사원등록' }	// 사원등록
		    	, { 'trFgCode': '3', 'trFgName': '거래처명' }	// 거래처명
		    	, { 'trFgCode': '4', 'trFgName': '기타소득자' }	// 기타소득자
		    	, { 'trFgCode': '5', 'trFgName': '기금' }		// 기금
		    	, { 'trFgCode': '6', 'trFgName': '운영비' }	// 운영비
		    	, { 'trFgCode': '7', 'trFgName': '결연자' }	// 결연자
		    	, { 'trFgCode': '8', 'trFgName': '급여' }		// 급여
		    	, { 'trFgCode': '9', 'trFgName': '사업소득자' }	// 사업소득자
	    	], 	/* 채주유형  iCUBEG20 */
	    title = { docuFgName: '결의구분', docuFgCode: '결의구분코드', resDate: '결의일자', resNote: '결의내역', resAmt: '금액', resSeq: '품의서 Seq', erpBudgetName: '예산단위', setFgName:'결재수단', setFgCode:'결재수단코드', trFgName:'채주유형', trFgCode:'채주유형코드', vatFgName:'과세구분',vatFgCode:'과세구분코드', erpBudgetSeq: '예산과목코드', erpBudgetName: '예산과목',  erpBizplanName: '사업계획', erpBizplanSeq: '사업계획코드', erpBgacctName: '예산계정', erpBgacctSeqCd: '예산계정코드', fiacct: '회계계정', fiacctCode: '회계계정코드', budgetNote: '적요', budgetAmt: '금액', trName: '거래처명', trSeq: '거래처코드', ceoName: '대표자명', btrName: '금융기관', btrSeq: '금융거래처 코드', baNb: '계좌번호', tradeNote: '비고', resDocSeq: '품의문서Seq', budgetSeq: '예산Seq', tradeSeq: '거래처 Seq', itemName: '물풀명', itemCnt: '갯수', unitAmt: '개당 가격', erpDivSeq: '예산사업장코드', erpDivName:'예산사업장이름', setFgName:'결재수단', vatFgName:'과세구분', trFgName:'채주유형', empSeq: '사원코드', empName: '사원명', etcCode: '기타사업자코드', etcName: '기타소득자', bizIncomCode: '사업소득자코드', bizIncomName: '사업소득자', tradeAmt: '금액', payAmt: '지급총액', tradeStdAmt: '공급가액', realPayAmt: '실수령액', tradeVatAmt: '부가세', payTaxAmt: '원천징수액', depositor: '예금주', regDate: '신고기준일', budgetBalanceAmt: "예산잔액", erpBgacctSeq: "예산계정코드", erpBgacctName: "예산계정", btrNumber: '입출금계좌', erpDivName: '회계단위', erpDivSeq: '회계단위코드', card: '카드거래처', resDateG20: '발의일자', projectName: '프로젝트', projectSeq: '프로젝트 코드', causeDate: '원인행위일', inspectDate: '계약일', signDate: '검수일', causeEmpName: '원인행위자', causeEmpSeq: '원인행위자코드', spec: '명세서', budgetNoteG20: '비고', etcGubun: '소득구분', erpBgt1Name: '관 이름', erpBgt1Seq: '관 코드', erpBgt2Name: '항 이름', erpBgt2Seq: '항 코드', erpBgt3Name: '목 이름', erpBgt3Seq: '목 코드', erpBgt4Name: '세 이름', erpBgt4Seq: '새 코드', erpOpenAmt: '예산금액', erpApplyAmt: '집행금액', erpLeftAmt: '예산잔액'},
	    yes = 'Y', no = 'N', YES = 'Y', NO = 'N',
	    align = { center: 'center', left: 'left', right: 'right' },
	    type = { combo: 'combo', text: 'text' },
	    widthZero = '0%',
	    idxZero = 0,
	    success = 'SUCCESS', SUCCESS = 'SUCCESS', EXCEED = 'EXCEED', exceed = 'EXCEED',
	    exceedFlag = false,
	    tbl = { res: '#resTable', budget: '#budgetTable', trade: '#tradeTable' },
	    classes = { res: '.row-res-', budget: '.row-budget', trade: '.row-trade-' },
	    tradeYN = 'Y', empYN = 'N', bizYN = 'N', etcYN = 'N', amtYN = 'N', tradeAmtYN = 'Y',
	    confferFlag = false,
	    budgetCheckFlag = false,
	    approvalBeforeFlag = false,
	    confferInfo = null;
	     
   	    /* SSL 적용관련 */
   	    if (!window.location.origin) {
   	        window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
   	    }
   	    var origin = document.location.origin;
	    	    
        /* 결의서 항목 옵션 가져오기 */
        var realDocuFgList = new Array();
        var realSetFgList = new Array();
        var realVatFgList = new Array();
        var realTrFgList = new Array();
        
        realDocuFgList = docuFgList;
		realSetFgList = setFgList;
		realVatFgList = vatFgList;
		realTrFgList = trFgList;
	
    /******************************* IU 테이블 정의 ************************************/
	/* 결의정보 테이블 컬럼 */
	var resTableColumn = [
         {
            title: title.docuFgName, /* 제목 */
            display: YES, /* 표현 여부 (표현 : Y / 미표현 : N) */
            displayKey: '', /* 나타낼 문저열 조합의 정보, 구분자는 "▥" 를 사용 */
            colKey: 'docuFgName', /* json 연동 키 */
            width: '20%', /* 너비 */
            reqYN: YES, /* 필수 입력 여부 */
            align: align.center, /* 정렬 */
            type: type.combo, /* 입력 포맷 (text, combo, datepicker) */
            comboData: { code: 'docuFgCode', name: 'docuFgName', list: realDocuFgList }, /* 콤보박스 목록 */
            disabled: '',	/* 테이블 disable처리 */
            classes: '',
            mask: '',
            editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ }}
        }
         , { title: title.docuFgCode, display: NO, colKey: 'docuFgCode', width: widthZero, reqYN: YES, align: align.center, type: type.text }
         , { title: title.resDate, display: YES, colKey: 'resDate', width: '20%', reqYN: YES, align: align.center, type: 'datepicker' }
         , { title: title.resNote, display: YES, colKey: 'resNote', width: '40%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { if (obj.keyCode == '13') {/* 결의정보 저장,수정 체크 */fnSaveOrUpdateRes(obj, "enter"); } } }
         , { title: title.resAmt, display: YES, colKey: 'resAmt', width: '20%', reqYN: NO, align: align.center, type: type.text, disabled: 'disabled' }
         , { title: title.resDocSeq, display: NO, colKey: 'resDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
         , { title: title.resSeq, display: NO, colKey: 'resSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
    ];
	
	/* 예산내역 테이블 컬럼 */
	var budgetTableColumn = [
        { title: title.erpBudgetName, display: YES, colKey: 'erpBudgetName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('budget', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('budget', obj); return true; } }
        , { title: title.erpBudgetSeq, display: NO, colKey: 'erpBudgetSeq', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.erpBizplanName, display: YES, colKey: 'erpBizplanName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('bizplan', obj); 
      			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('bizplan', obj); return true; } }
        , { title: title.erpBizplanSeq, display: NO, colKey: 'erpBizplanSeq', width: widthZero, reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.erpBgacctName, display: YES, colKey: 'erpBgacctName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('bgacct', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('bgacct', obj); return true; } }
        , { title: title.erpBgacctSeq, display: NO, colKey: 'erpBgacctSeq', width: widthZero, reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.setFgName, display: YES, colKey: 'setFgName', width: '12%', reqYN: YES, align: align.center, type: type.combo, comboData: { code: 'setFgCode', name: 'setFgName', list: realSetFgList }, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }}
        , { title: title.setFgCode, display: NO, colKey: 'setFgCode', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; }}
        , { title: title.vatFgName, display: YES, colKey: 'vatFgName', width: '12%', reqYN: YES, align: align.center, type: type.combo, comboData: { code: 'vatFgCode', name: 'vatFgName', list: realVatFgList }, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }}
        , { title: title.vatFgCode, display: NO, colKey: 'vatFgCode', width: widthZero, reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.trFgName, display: YES, colKey: 'trFgName', width: '12%', reqYN: YES, align: align.center, type: type.combo, comboData: { code: 'trFgCode', name: 'trFgName', list: realTrFgList }, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } } }
        , { title: title.trFgCode, display: NO, colKey: 'trFgCode', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.budgetNote, display: YES, colKey: 'budgetNote', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if (obj.keyCode == '13') {
                	fnSaveOrUpdateBudget(obj, "enter");
                }
       		} 
        }
        , { title: title.budgetAmt, display: YES, colKey: 'budgetAmt', width: '15%', reqYN: NO, align: align.center, type: type.text, disabled:"disabled", editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; }}
        , { title: title.budgetBalanceAmt, display: NO, colKey: 'budgetBalanceAmt', width: '15%', reqYN: NO, align: align.center, type: type.text, disabled:"disabled", editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; }}
        , { title: title.resDocSeq, display: NO, colKey: 'resDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.resSeq, display: NO, colKey: 'resSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.budgetSeq, display: NO, colKey: 'budgetSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
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
	
	/* 거래처정보 테이블 컬럼 */
	var tradeTableColumn = [
        { title: title.trName, display: YES, colKey: 'trName', width: '12%', reqYN: tradeYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('Tr', obj); 
       			}
      		}, dblClickEvent: function(obj){ fnCommonPop('Tr', obj); return true; } }
        , { title: title.trSeq, display: NO, colKey: 'trSeq', width: widthZero, reqYN: tradeYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.empSeq, display: NO, colKey: 'empSeq', width: widthZero, reqYN: empYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { if(obj.keyCode == "113") { fnCommonPop('Emp', obj); } }, dblClickEvent: function(obj){ fnCommonPop('Emp', obj); return true; } }
        , { title: title.empName, display: NO, colKey: 'empName', width: '12%', reqYN: empYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('Emp', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('Emp', obj); return true; } }
        , { title: title.etcCode, display: NO, colKey: 'etcCode', width: widthZero, reqYN: etcYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.etcName, display: NO, colKey: 'etcName', width: '12%', reqYN: etcYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('TrEtc', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('TrEtc', obj); return true; } }
        , { title: title.bizIncomCode, display: NO, colKey: 'bizIncomCode', width: widthZero, reqYN: bizYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.bizIncomName, display: NO, colKey: 'bizIncomName', width: '12%', reqYN: bizYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('TrBus', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('TrBus', obj); return true; } }
        , { title: title.ceoName, display: YES, colKey: 'ceoName', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeAmt, display: YES, colKey: 'tradeAmt', width: '12%', reqYN: tradeAmtYN, align: align.center, type: type.text, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "13") {
        			fnCalAmt(obj);
        		}
        		return true; 
       		} , keyUpAfter: function (obj) { 
       			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
       				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
        		}
       			return true;
       		} 
        }
        , { title: title.payAmt, display: NO, colKey: 'payAmt', width: '12%', reqYN: amtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; }, 
	        keyDownBefore: function (obj) { 
	    		if(obj.keyCode == "13") {
	    			fnCalAmt(obj);
	    		}
	    		return true; 
	   		} , keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
	   			return true;
	   		}         
        }
        , { title: title.tradeStdAmt, display: YES, colKey: 'tradeStdAmt', width: '12%', reqYN: tradeAmtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; },
	        keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
   			return true;
   			} 
        }
        , { title: title.realPayAmt, display: NO, colKey: 'realPayAmt', width: '12%', reqYN: amtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeVatAmt, display: YES, colKey: 'tradeVatAmt', width: '12%', reqYN: tradeAmtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; },
        	keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
   			return true;
   			}
        }
        , { title: title.payTaxAmt, display: NO, colKey: 'payTaxAmt', width: '12%', reqYN: amtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.btrName, display: YES, colKey: 'btrName', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { if(obj.keyCode == "113") { fnCommonPop('Bank', obj); } }, dblClickEvent: function(obj){ fnCommonPop('Bank', obj); return true; } }
        , { title: title.btrSeq, display: NO, colKey: 'btrSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.baNb, display: YES, colKey: 'baNb', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.depositor, display: YES, colKey: 'depositor', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeNote, display: YES, colKey: 'tradeNote', width: '13%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.regDate, display: YES, colKey: 'regDate', width: '13%', reqYN: NO, align: align.center, type: 'datepicker', 
        	keyDownBefore: function (obj) {
        		if (obj.keyCode == '13') {
                	fnSaveOrUpdateTrade(obj, "enter");
                }
       		}
        }
        , { title: title.resDocSeq, display: NO, colKey: 'resDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.resSeq, display: NO, colKey: 'resSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.budgetSeq, display: NO, colKey: 'budgetSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeSeq, display: NO, colKey: 'tradeSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeSeq, display: NO, colKey: 'interfaceType', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeSeq, display: NO, colKey: 'interfaceSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.resDate, display: NO, colKey: 'resDate', width: '20%', reqYN: NO, align: align.center, type: type.text }
    ];
	/******************************* IU 테이블 정의 - END ************************************/
	
	/******************************* G20 테이블 정의 ************************************/
	/* 결의정보 테이블 컬럼 */
	var resTableColumnG20 = [
         {
            title: title.docuFgName, /* 제목 */
            display: YES, /* 표현 여부 (표현 : Y / 미표현 : N) */
            displayKey: '', /* 나타낼 문저열 조합의 정보, 구분자는 "▥" 를 사용 */
            colKey: 'docuFgName', /* json 연동 키 */
            width: '20%', /* 너비 */
            reqYN: YES, /* 필수 입력 여부 */
            align: align.center, /* 정렬 */
            type: type.combo, /* 입력 포맷 (text, combo, datepicker) */
            comboData: { code: 'docuFgCode', name: 'docuFgName', list: realDocuFgList }, /* 콤보박스 목록 */
            disabled: '',	/* 테이블 disable처리 */
            classes: '',
            mask: '',
            editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ }}
        }
         , { title: title.docuFgCode, display: NO, colKey: 'docuFgCode', width: widthZero, reqYN: YES, align: align.center, type: type.text }
         , { title: title.resDateG20, display: YES, colKey: 'resDateG20', width: '20%', reqYN: YES, align: align.center, type: 'datepicker' }
         , { title: title.projectName, display: YES, colKey: 'projectName', width: '40%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	 keyDownBefore: function (obj) { 
        		 if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			 fnCommonPop('project', obj); 
       			 } 
       		 }, tooltip: '[F2] 프로젝트 도움창', dblClickEvent: function(obj){ fnCommonPop('project', obj); return true; } } 
         , { title: title.projectSeq, display: NO, colKey: 'projectSeq', width: '40%', reqYN: YES, align: align.center, type: type.text, keyDownBefore: function (obj) { if (obj.keyCode == '13') {/* 결의정보 저장,수정 체크 */fnSaveOrUpdateRes(obj, "enter"); } } }
         , { title: title.resNote, display: YES, colKey: 'resNote', width: '40%', reqYN: NO, align: align.center, type: type.text, keyDownBefore: function (obj) { return true; } }
         , { title: title.btrNumber, display: YES, colKey: 'btrNumber', width: '40%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	 keyDownBefore: function (obj) {
        		 if (obj.keyCode == '13') {
        			 fnSaveOrUpdateRes(obj, "enter")
        		 } else if(obj.keyCode == "113") {
        			 fnCommonPop('btrtr', obj); 
        		 }
       		 } , tooltip: '[F2] 입출금계좌 도움창', dblClickEvent: function(obj){ fnCommonPop('btrtr', obj); return true; } }
         , { title: title.resAmt, display: YES, colKey: 'resAmt', width: '20%', reqYN: NO, align: align.center, type: type.text, disabled: 'disabled' }
         , { title: title.causeDate, display: optionSet.conVo.erpTypeCode == "iCUBE" ? ((optionSet.erp['4']['05'].USE_YN == '0') ? NO : YES) : NO, colKey: 'causeDate', width: '20%', reqYN: NO, align: align.center, type: 'datepicker',  keyDownBefore: function (obj) { return true; } }
         , { title: title.inspectDate, display: optionSet.conVo.erpTypeCode == "iCUBE" ? ((optionSet.erp['4']['05'].USE_YN == '0') ? NO : YES) : NO, colKey: 'inspectDate', width: '20%', reqYN: NO, align: align.center, type: 'datepicker',  keyDownBefore: function (obj) { return true; } }
         , { title: title.signDate, display: optionSet.conVo.erpTypeCode == "iCUBE" ? ((optionSet.erp['4']['05'].USE_YN == '0') ? NO : YES) : NO, colKey: 'signDate', width: '20%', reqYN: NO, align: align.center, type: 'datepicker',  keyDownBefore: function (obj) { return true; } }
         , { title: title.causeEmpName, display: optionSet.conVo.erpTypeCode == "iCUBE" ? ((optionSet.erp['4']['05'].USE_YN == '0') ? NO : YES) : NO, colKey: 'causeEmpName', width: '20%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        		 keyDownBefore: function (obj) { 
        			 if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        				 fnCommonPop('Emp', obj); 
       				 } 
       			 }, tooltip: '[F2] 사원 도움창', dblClickEvent: function(obj){ fnCommonPop('Emp', obj); return true; } }
         , { title: title.causeEmpSeq, display: NO, colKey: 'causeEmpSeq', width: '20%', reqYN: NO, align: align.center, type: type.text,  keyDownBefore: function (obj) { return true; } }
         , { title: title.spec, display: optionSet.conVo.erpTypeCode == "iCUBE" ? ((optionSet.erp['4']['05'].USE_YN == '0') ? NO : YES) : NO, colKey: 'spec', width: '20%', reqYN: NO, align: align.center, type: type.text,  keyDownBefore: function (obj) { if (obj.keyCode == '13') {/* 결의정보 저장,수정 체크 */fnSaveOrUpdateRes(obj, "enter"); } } }
         , { title: title.resDocSeq, display: NO, colKey: 'resDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
         , { title: title.resSeq, display: NO, colKey: 'resSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
         , { title: title.btrSeq, display: NO, colKey: 'btrSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text }
         , { title: title.btrName, display: NO, colKey: 'btrName', width: widthZero, reqYN: NO, align: align.center, type: type.text }
    ];
	
	/* 예산내역 테이블 컬럼 */
	var budgetTableColumnG20 = [
        { title: title.erpBudgetName, display: YES, colKey: 'erpBudgetName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('budgetlist', obj); 
       			} 
       		}, tooltip: '[F2] 예산과목 도움창', dblClickEvent: function(obj){ fnCommonPop('budgetlist', obj); return true; } }
        , { title: title.erpBudgetSeq, display: NO, colKey: 'erpBudgetSeq', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.setFgName, display: YES, colKey: 'setFgName', width: '12%', reqYN: YES, align: align.center, type: type.combo, comboData: { code: 'setFgCode', name: 'setFgName', list: realSetFgList }, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }}
        , { title: title.setFgCode, display: NO, colKey: 'setFgCode', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; }}
        , { title: title.vatFgName, display: YES, colKey: 'vatFgName', width: '12%', reqYN: YES, align: align.center, type: type.combo, comboData: { code: 'vatFgCode', name: 'vatFgName', list: realVatFgList }, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }}
        , { title: title.vatFgCode, display: NO, colKey: 'vatFgCode', width: widthZero, reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.trFgName, display: YES, colKey: 'trFgName', width: '12%', reqYN: YES, align: align.center, type: type.combo, comboData: { code: 'trFgCode', name: 'trFgName', list: realTrFgList }, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } } }
        , { title: title.trFgCode, display: NO, colKey: 'trFgCode', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.erpDivName, display: YES, colKey: 'erpDivName', width: '12%', reqYN: YES, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('div', obj); 
       			} 
       		}, tooltip: '[F2] 회계단위 도움창', dblClickEvent: function(obj){ fnCommonPop('div', obj); return true; } }  
        , { title: title.erpDivSeq, display: NO, colKey: 'erpDivSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.budgetNoteG20, display: YES, colKey: 'budgetNoteG20', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if (obj.keyCode == '13') {
                	fnSaveOrUpdateBudget(obj, "enter");
                }
       		} 
        }
        , { title: title.budgetAmt, display: YES, colKey: 'budgetAmt', width: '15%', reqYN: NO, align: align.center, type: type.text, disabled:"disabled", editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; }}
        , { title: title.budgetBalanceAmt, display: NO, colKey: 'budgetBalanceAmt', width: '15%', reqYN: NO, align: align.center, type: type.text, disabled:"disabled", editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; }}
        , { title: title.resDocSeq, display: NO, colKey: 'resDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.resSeq, display: NO, colKey: 'resSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.budgetSeq, display: NO, colKey: 'budgetSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
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
	
	/* 거래처정보 테이블 컬럼 */
	var tradeTableColumnG20 = [
        { title: title.trName, display: YES, colKey: 'trName', width: '12%', reqYN: tradeYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('Tr', obj); 
       			} 
       		}, tooltip: '[F2] 거래처 도움창', dblClickEvent: function(obj){ fnCommonPop('Tr', obj); return true; } }
        , { title: title.trSeq, display: NO, colKey: 'trSeq', width: widthZero, reqYN: tradeYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.empSeq, display: NO, colKey: 'empSeq', width: widthZero, reqYN: empYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { if(obj.keyCode == "113") { fnCommonPop('Emp', obj); } }, tooltip: '[F2] 사원 도움창', dblClickEvent: function(obj){ fnCommonPop('Emp', obj); return true; } }
        , { title: title.empName, display: NO, colKey: 'empName', width: '12%', reqYN: empYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('Emp', obj); 
       			} 
       		}, dblClickEvent: function(obj){ fnCommonPop('Emp', obj); return true; } }
        , { title: title.etcCode, display: NO, colKey: 'etcCode', width: widthZero, reqYN: etcYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.etcName, display: NO, colKey: 'etcName', width: '12%', reqYN: etcYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('erphpmeticlist', obj); 
       			} 
       		}, tooltip: '[F2] 기타소득자 도움창', dblClickEvent: function(obj){ fnCommonPop('erphpmeticlist', obj); return true; } }
        , { title: title.bizIncomCode, display: NO, colKey: 'bizIncomCode', width: widthZero, reqYN: bizYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.bizIncomName, display: NO, colKey: 'bizIncomName', width: '12%', reqYN: bizYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113") { 
        			fnCommonPop('erphincomeiclist', obj); 
       			} 
       		}, tooltip: '[F2] 사업소득자 도움창', dblClickEvent: function(obj){ fnCommonPop('erphincomeiclist', obj); return true; } }
        , { title: title.ceoName, display: YES, colKey: 'ceoName', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeAmt, display: YES, colKey: 'tradeAmt', width: '12%', reqYN: tradeAmtYN, align: align.center, type: type.text, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "13") {
        			fnCalAmt(obj);
        		}
        		return true; 
       		} , keyUpAfter: function (obj) { 
       			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
       				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
        		}
       			return true;
       		} 
        }
        , { title: title.payAmt, display: NO, colKey: 'payAmt', width: '12%', reqYN: amtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; }, 
	        keyDownBefore: function (obj) { 
	    		if(obj.keyCode == "13") {
	    			fnCalAmt(obj);
	    		}
	    		return true; 
	   		} , keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
	   			return true;
	   		}         
        }
        , { title: title.tradeStdAmt, display: YES, colKey: 'tradeStdAmt', width: '12%', reqYN: tradeAmtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "13") {
	    			fnCalAmt(obj);
	    		}
        		return true; 
       		},
	        keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
   			return true;
   			} 
        }
        , { title: title.realPayAmt, display: NO, colKey: 'realPayAmt', width: '12%', reqYN: amtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeVatAmt, display: YES, colKey: 'tradeVatAmt', width: '12%', reqYN: tradeAmtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "13") {
	    			fnCalAmt(obj);
	    		}
        		return true; 
       		},
        	keyUpAfter: function (obj) { 
	   			if( ( 48 <= obj.keyCode && obj.keyCode <= 57 ) || (  96 <= obj.keyCode && obj.keyCode <= 105  ) ){
	   				$('#tradeTable .inpTextBox').val($('#tradeTable .inpTextBox').val().toString().replace(/\,/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));	
	    		}
   			return true;
   			}
        }
        , { title: title.payTaxAmt, display: NO, colKey: 'payTaxAmt', width: '12%', reqYN: amtYN, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.btrName, display: YES, colKey: 'btrName', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, 
        	keyDownBefore: function (obj) { 
        		if(obj.keyCode == "113" /*|| obj.keyCode == "13"*/) { 
        			fnCommonPop('Bank', obj); 
       			} 
       		}, tooltip: '[F2] 금융기관 도움창', dblClickEvent: function(obj){ fnCommonPop('Bank', obj); return true; } }
        , { title: title.btrSeq, display: NO, colKey: 'btrSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.baNb, display: YES, colKey: 'baNb', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.depositor, display: YES, colKey: 'depositor', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.card, display: NO, colKey: 'card', width: '12%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeNote, display: YES, colKey: 'tradeNote', width: '13%', reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.regDate, display: YES, colKey: 'regDate', width: '13%', reqYN: NO, align: align.center, type: 'datepicker', 
        	keyDownBefore: function (obj) {
        		if (obj.keyCode == '13') {
                	fnSaveOrUpdateTrade(obj, "enter");
                }
       		}
        }
        , { title: title.resDocSeq, display: NO, colKey: 'resDocSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.resSeq, display: NO, colKey: 'resSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.budgetSeq, display: NO, colKey: 'budgetSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeSeq, display: NO, colKey: 'tradeSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeSeq, display: NO, colKey: 'interfaceType', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.tradeSeq, display: NO, colKey: 'interfaceSeq', width: widthZero, reqYN: NO, align: align.center, type: type.text, editor: { open: function (obj) { /* code pop or layer pop */ }, close: function (obj) { /* code pop or layer pop callback */ } }, keyDownBefore: function (obj) { return true; } }
        , { title: title.resDate, display: NO, colKey: 'resDate', width: '20%', reqYN: NO, align: align.center, type: type.text }
        , { title: title.etcGubun, display: NO, colKey: 'etcGubun', width: '20%', reqYN: NO, align: align.center, type: type.text }
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
        check: function (target, positionY) { return target.extable('getReqCheck', positionY); },  /* 행 필수 입력 확인 */
    };

    var def = {
        res: function (data) {
            var defaults = {
                docuFgName: "",			/* 결의구분 */
                docuFgCode: "",		/* 결의구분 코드 */
                resDate: "",		/* 결의날짜 */
                resDateG20: "",		/* 발의날짜 */
                resNote: "",			/* 적요 */
                resAmt: "",			/* 금액 */
                resDocSeq: 0,		/* 결의문서시퀀스 */
                resSeq:0,			/* 결의내역 시퀀스 */
                btrNumber: "",  /* 입출금계좌 */
                projectName: "", 	  /* 프로젝트 */
                projectSeq: "",  /* 프로젝트코드 */
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
                erpBizplanSeq: '',	/* 사업계획코드*/
                erpBgacctName: '',	/* 예산계정 */
                erpBgacctSeq: '',	/* 예산계정코드 */
                setFgName: '',		/* 결재수단 */
                setFgCode: '',		/* 결재수단코드 */
                vatFgName: '',		/* 과세구분 */
                vatFgCode: '',		/* 과세구분코드 */
                trFgName: '',		/* 채주유형 */
                trFgCode: '',		/* 채주유형 코드 */
                budgetNote: '',		/* 적요 */
                budgetAmt: 0,		/* 금액 */
                budgetAmg:0,		/* 잔여예산금액 */
                resDocSeq: 0,		/* 결의문서 시퀀스 */
                resSeq: 0,			/* 결의내역 시퀀스 */
                budgetSeq: 0,		/* 예산내역 시퀀스 */
                erpDivName: "",		/* 회계단위 */
      			erpDivSeq: "",		/* 회계단위코드 */
            };

            var result = $.extend(defaults, data);
            return result;
        },
        trade: function (data) {
            var defaults = {
                trName: '',			/* 거래처 */
                trSeq: '',		/* 거래처코드 */
                empSeq: '',			/* 사원시퀀스 */
                empName: '',		/* 사원명 */
                etcCode: '',		/* 기타사업자코드 */
                etcName: '',		/* 기타사업자 */
                bizIncomCode: '',	/* 사업소득자코드*/
                bizIncomName: '',	/* 사업소득자 */
                ceoName: '',		/* 대표자명 */
                tradeAmt: 0,		/* 금액 */
                payAmt: 0,			/* 지급총액 */
                tradeStdAmt: 0,			/* 공급가액 */
                realPayAmt: 0,		/* 실수령액 */
                tradeVatAmt: 0,			/* 부가세 */
                payTaxAmt: 0,		/* 원천징수액 */	
                btrName: '',			/* 금융기관 */
                btrSeq: '',		/* 금융기관코드 */
                baNb: '',	/* 계좌번호 */
                depositor: '',		/* 예금자명 */
                tradeNote: '',		/* 비고 */	
                regDate: '',		/* 신고기준일 */
                resDocSeq: 0,		/* 결의문서시퀀스 */
                resSeq: 0,			/* 결의내역 시퀀스 */
                budgetSeq: 0,		/* 예산내역 시퀀스 */
                tradeSeq: 0,		/* 거래처 시퀀스 */
                card:'',			/* 카드거래처 */
                interfaceType: 0,	/* 외부시스템 구분값 */
                interfaceSeq: 0			/* 외부시스템 키 값 */
            };

            var result = $.extend(defaults, data);
            return result;
        }
    }
    
	/*	[결의서] 문서 준비 document.ready
	----------------------------------------- */
	$(document).ready(function(){
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
		
		/* 페이지 리사이즈 */
		fnResizePage();
		
		/* [결의문서] 최초생성 */
        fnInitResDocSeq();

		/* 결의서 항목 옵션 가져오기 */
		//fnGetResItemOption();
		
		/* init */
        fnInit();
		
		/* 초기화 진행 */
		fnInitEvent();
		
		$("#etcGubun").hide();
		$("#modalDib").hide();
	});
    
    function fnApprovalBefore() {
    	var resHeadInfo = new Array();
    	var resBudgetInfo = new Array();
    	var resTradeInfo = new Array();
    	approvalBeforeFlag = true;	
    	confferFlag = true;	
    	
    	resHeadInfo = ${resHeadInfo} || '';
    	resBudgetInfo = ${resBudgetInfo} || '';
    	resTradeInfo = ${resTradeInfo} || '';
		
		
		/* 기존 입력 초기화 */
		$(tbl.res).contents().unbind().remove();
	    $(tbl.budget).contents().unbind().remove();
	    $(tbl.trade).contents().unbind().remove();

		fnDrawResInfo();
		fnDrawBudgetInfo();
		fnDrawTradeInfo();
		
		/* 결의정보 데이터 */
		var firstResSeq = 0;
		var resSeqArray = new Array();
		for(var i=0; i<resHeadInfo.length; i++) {
			var year = resHeadInfo[i].resDate.substring(0,4);
			var month = resHeadInfo[i].resDate.substring(4,6);
			var day = resHeadInfo[i].resDate.substring(6,8);
			var displayDate = year + "-" + month + "-" + day;
			resHeadInfo[i].resDateG20 = displayDate; 
			resHeadInfo[i].resDate = displayDate;
			resHeadInfo[i].consAmt = fnAddComma(resHeadInfo[i].consAmt);
			resSeqArray.push(resHeadInfo[i].resSeq);
			firstResSeq = resHeadInfo[0].resSeq;
			resDocSeq = resHeadInfo[0].resDocSeq;
			$ ( tbl.res ).extable ( 'setAddRow', resHeadInfo[i] );
		}
		
		table.focus($(tbl.res), 0, 0);
		
		fnDrawBudgetInfo();
		
		/* 예산정보 데이터 */
		var firstBudgetSeq = 0;
		var erpBudgetSeq = {};
		var budgetSeqArray = new Array();
		for(var i=0; i<resBudgetInfo.length; i++) {
			resBudgetInfo[i].budgetAmt = fnAddComma(resBudgetInfo[i].budgetAmt);
			budgetSeqArray.push(resBudgetInfo[i].resSeq);
			erpBudgetSeq.erpBudgetSeq = resBudgetInfo[0].erpBudgetSeq;
			firstBudgetSeq = resBudgetInfo[0].budgetSeq;
			
			$ ( tbl.budget ).extable ( 'setAddRow', resBudgetInfo[i] );
		}
			
		$("[class*=row-res-]").removeClass();
		$("[class*=row-budget-]").removeClass();
		
		/* 결의정보 테이블 class 선언 */
		for(var i=0; i<resSeqArray.length; i++) {
			$("#resTable > .rowHeight > table > tbody > tr:eq(" + i + ")").addClass("row-res-" + resSeqArray[i]);	
		}
		
		/* 예산내역 테이블 calss 선언 */
		for(var i=0; i<budgetSeqArray.length; i++) {
			$("#budgetTable > .rowHeight > table > tbody > tr:eq(" + i + ")").addClass("res_budgetRow row-budget-" + budgetSeqArray[i]);	
		}
		
		/* 결의정보에 따른 예산정보 숨김처리 */
		$(".res_budgetRow").hide();
		
		if(erpTypeCode == "iCUBE") {
			$('#budgetTable').extable('setDisplayChange', ["Y","N","Y","N","Y","N","Y","N","Y","N","Y","Y","N","N","N","N"]);	
		} else {
			$('#budgetTable').extable('setDisplayChange', ["Y","N","Y","N","Y","N","Y","N","Y","N","Y","N","Y","Y","N","N"]);
		}
		
		$(".row-budget-" + firstResSeq).show();
 	
		if(erpTypeCode == "iCUBE") {
			table.focus($(tbl.budget), 10, 0);
		} else {
			table.focus($(tbl.budget), 12, 0);
		}
		
 		
		/* 거래처정보 데이터 */
		var firstTradeSeq = 0;
		var tradeSeqArray = new Array();
		for(var i=0; i<resTradeInfo.length; i++) {
			resTradeInfo[i].tradeAmt = fnAddComma(resTradeInfo[i].tradeAmt);
			tradeSeqArray.push(resTradeInfo[i].budgetSeq);
			firstTradeSeq = resTradeInfo[0].budgetSeq;
			
			$ ( tbl.trade ).extable ( 'setAddRow', resTradeInfo[i] );
		}
		
		table.focus($(tbl.trade), 0, 0);
		$("[class*=row-trade-]").removeClass();
		
		for(var i=0; i<tradeSeqArray.length; i++) {
			$("#tradeTable > .rowHeight > table > tbody > tr:eq(" + i + ")").addClass("res_tradeRow row-trade-"+tradeSeqArray[i]);	
		}
		
		/* 결의정보에 따른 예산정보 숨김처리 */
		$(".res_tradeRow").hide();
		
		$(".row-trade-" + firstTradeSeq).show();
		
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
    
    /* 결의 구분 옵션 */
    function fnGetResItemOption() {
    	var docuFgOptionValue = '';
    	
    	/* 결의구분 항목 옵션 가져오기 */
    	docuFgOptionValue = fnGetGwOptions('2', '2', '0');
    	
    	if(docuFgOptionValue != "0") {
			var docuFgArray = docuFgOptionValue.split("|");
			
			for(var i=0; i<docuFgArray.length; i++) {
				realDocuFgList.push( docuFgList[docuFgArray[i]-1] );
			}
    	} else {
    		realDocuFgList = docuFgList;
    	}
    }
	
	 /* fnInit */
    function fnInit() {
    	if("${approBefore}" == "Y") {
    		return;
    	}
    	
    	/* [ 테이블 Lv1 ] 결의정보 테이블 그리기 */
        fnDrawResInfo();
        
        /* [ 테이블 Lv2 ] 예산내역 테이블 그리기 */
        fnDrawBudgetInfo();
        
        /* [ 테이블 Lv3 ] 거래처 정보 테이블 그리기 */
        fnDrawTradeInfo();
        return;
    }
    
	/*	[ POP ] 결의서 페이지 리사이즈
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
	
	/* [결의문서] 최초생성
	----------------------------------------- */
	function fnInitResDocSeq ( ) {
		var consDocInsertFlag = "${approBefore}";
		
		if(consDocInsertFlag == "N") {
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResDocInsert.do',
				async: false,
				data: fnGetCommonAjaxParam ( )
			} );
			resDocSeq = ( result != null ? result.aData.resDocSeq : 0 ).toString();

			if ( !resDocSeq ) {
				$.error ( '결의서가 생성되지 않았습니다.' );
				alert ( '결의서 기초정보가 생성되지 않았습니다. 페이지를 새로고침(F5) 진행해 주세요.\r\n지속적으로 알림이 나타날 경우 관리자에게 문의해주세요.' );
			}
		} else {
			fnApprovalBefore();
		}
		
	}
	
	/*	[결의서] 초기화 진행 
	----------------------------------------- */
	function fnInitEvent(){
		var docClear = function () {
            /* 변수 초기화 */
            /* 테이블 초기화 */
            $(tbl.res).contents().unbind().remove();
            $(tbl.budget).contents().unbind().remove();
            $(tbl.trade).contents().unbind().remove();
        };
		/* 1. 전자결재 상신 진행 */
		$('#btnApprovalOpen').click(function(){
			fnApprovalopen();
		});
		
		/* 2. 참조품의 가져오기 진행 */
		$('#btnRefferCons').click(function(){
			fnPopConsList();			
		});
		
		/* 3. 다시쓰기 진행 */
		$('#btnRefresh').click(function(){
			if (confirm("기존 작성하였던 내용이 모두 사라집니다. 다시쓰기를 실행하시겠습니까??") == true){    //확인
				fnRefresh();	
			} else {
				return;
			}
			
		});
		
		/* 품의정보 추가 */
		$ ( '#btnAddRes' ).click ( function ( ) {
			fnAddRes ( );
		} );
		
		/* 품의정보 삭제 */
		$ ( '#btnDelRes' ).click ( function ( ) {
			fnDeleteRes ( );
		} );
		
		/* 예산내역 추가 */
		$ ( '#btnAddBudget' ).click ( function ( ) {
			fnAddBudget ( );
		} );
		
		/* 예산내역 삭제 */
		$ ( '#btnDelBudget' ).click ( function ( ) {
			fnDeleteBudget ( );
		} );
		
		/* 거래처정보 추가 */
		$ ( '#btnAddTrade' ).click ( function ( ) {
			fnAddTrade ( );
		} );
		
		/* 카드내역가져요기 */
		$ ( '#btnAddCardHistory' ).click ( function ( ) {
			fnAddCardHistory ( );
		} );
		
		/* 세금계산서가져요기 */
		$ ( '#btnAddETaxHistory' ).click ( function ( ) {
			fnAddETaxHistory ( );
		} );
		
		/* 거래처정보 삭제 */
		$ ( '#btnDelTrade' ).click ( function ( ) {
			fnDeleteTrade ( );
		} );
		
		$ ( '#okButton' ).click ( function ( ) {
			fnEtcCalAmt();
		} );
		
		$ ( '#cancelButton' ).click ( function ( ) {
			$ ( '#etcGubun' ).hide ( );
			$ ( '#modalDiv' ).hide ( );
		} );
		
		/* 소득구분 선택 */
		$ ( '#incomeGubun' ).click ( function ( ) {
			fnSelectIncomePop();
		} );
		
		$( '#btnResLoad' ).click ( function ( ) { 
			fnPopConsLoad();
		} );
	}
	
	/*	[초기화] 그리드및 그리드 변수 초기화 
	----------------------------------------- */
	function fnRefresh(){
		/* 모든 결의정보 삭제 */
        fnDeleteAllRes();
		
		/* 테이블 초기화 */
		$(tbl.res).contents().unbind().remove();
        $(tbl.budget).contents().unbind().remove();
        $(tbl.trade).contents().unbind().remove();
        
        fnInit();
	}
	
	/*	[참조품의 가져오기] 참조품의 가져오기 팝업 호출 
	----------------------------------------- */
	function fnPopConsList(){
		/* 팝업 호출 준비 */
		var url = "<c:url value='/expend/np/user/UserConfferPop.do'/>";
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
		
		window.open('', "UserConfferPop", "width=" + 900 + ", height=" + height + ", left=" + 150 + ", top=" + 150);
		USER_confferPop.target = "UserConfferPop";
		USER_confferPop.method = "post";
		USER_confferPop.action = url;
		USER_confferPop.submit();
		USER_confferPop.target = "";
	}
    
	
    /*	[ CALLBACK ] 참조 품의 가져오기 콜백
	----------------------------------------- */
	function fnCallbackConffer(data){
		confferInfo = data;
		var result = fnAjax({
		     url: '/ex/np/user/res/ResConfferInfoUpdate.do',
		     async: false,
		     data: {
		         'consDocSeq'  : confferInfo.consDocSeq
		         , 'resDocSeq' : resDocSeq
		     }
		 });
		if( !(!result) || ( result.resultCode == 'SUCCESS' ) ){
			/* 참조 품의 반영데이터 그리기 */
			fnDrawConffer(result.aData);
		}else{
			/* 오류 발생 */
			alert(result.resultName);
		}
	}
	
    /*	[ 테이블 Lv1 ] 결의정보 테이블 그리기
	----------------------------------------- */
    function fnDrawResInfo ( ) {
    	$ ( tbl.res ).extable ( {
			column: ((erpTypeCode == "iCUBE") ? resTableColumnG20 : resTableColumn),
			data: [ ],
			height: 135,
			clickBefore: function ( data ) {
				log("결의정보 clickBefore 데이터");
				log(data);
				rowResData = data;
				
				if(data.afterRowIndex != data.beforeRowIndex && table.check ( $ ( tbl.res ) ).pass) {
					fnSaveOrUpdateRes ( data, "click" );
					return true;
				} else if ( data.afterRowIndex != data.beforeRowIndex && !table.check ( $ ( tbl.res ) ).pass ) {
					var focusFlag = rowResData.data.docuFgName || rowResData.data.docuFgCode;
					
					if ( focusFlag ) {
						fnParamCheck ( tbl.res.replace ( '#', '' ) );
						return false;
					} else {
						return true;
					}
				} else {
					return true;
				}
			},
			clickAfter: function ( data ) {
// 				if(approvalBeforeFlag) {
// 					$(".res_tradeRow").hide();
// 				}
				if(data.afterRowIndex != data.beforeRowIndex && (data.beforeRowIndex != -1)){
					/* 결의내역 클릭 시 저장된 예산내역 노출 */
					fnShowHideRes(data);	
					$(".res_tradeRow").hide();
				}
				return true;
			},
			row: {
				classes: function ( ) {
					return 'res_resRow ' + classes.res + resSeq;
				}
			},
			tooltipFnc: function ( ) {
				var colInfo = $('#resTable').find('.colOn');
				var colIdx = $('#resTable').find('.colOn').index();
				
				if(colInfo.length > 0){
					$("#resHelp").text(this.column[colIdx].tooltip || '');
				} else {
					$("#resHelp").text("");
				}
			}
//			TODO: blur이벤트 확인필요
// 			,
// 			blurEvent: function(data) {
// 				console.log('blurEvent-res');
// 				console.log(data);
// 				//fnBlurCheck(data);
// 			}
		} );

    	if(!confferFlag || !approvalBeforeFlag) {
    		table.addRow ( $ ( tbl.res ), def.res ( {
    			resDocSeq: resDocSeq
    		} ) );
    		table.focus ( $ ( tbl.res ), idxZero, idxZero );
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
				log("예산내역 clickBefore 데이터");
				log(data);
				/*
				 *	drop down list 선택 이벤트 등록 영역
				 *	1. 결제 수단에 따른 카드 분기 처리
				 *	2. 과세구분에 따른 채주 유형 입력 처리
				 *	3. 채주유형에 따른 입력 필드 분기 처리
				 */
				if(erpTypeCode == 'iCUBE') {
					if(data.beforeColIndex == 2) { /* 결재수단 */
						if(data.data.setFgCode == '4') {		/* 결재수단 카드일 경우 */
							$("#btnAddCardHistory").show();
							$('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","N", "Y", "Y", "Y", "Y"]);
						} else {
							$("#btnAddCardHistory").hide();
							$('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","N", "Y", "N", "Y", "Y"]);
						}
					} else if(data.beforeColIndex == 4) { /* 과세구분 */
						if( data.data.vatFgCode == '1' ||  data.data.vatFgCode == '2'){
							/* 채주유형 거래처 고정 */  
							$('#budgetTable').extable('setRowData', { trFgName:'거래처' }, 6, data.beforeRowIndex);
							$('#budgetTable').extable('setRowData', { trFgCode:'1' }, 7, data.beforeRowIndex);
							
							/* 채주유형 disable 처리 */
							$('#budgetTable').extable('setRowDisable', 6, data.beforeRowIndex, 'disabled');
							$('#budgetTable').extable('setRowDisable', 7, data.beforeRowIndex, 'disabled');
							
							if(data.data.vatFgCode == '2') {
								$('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","N","N","Y","N","N", "Y", "Y", "Y", "Y"]);
							}
						} else {
							// TODO: 채주유형 기타일 경우 확인 필요
							$('#budgetTable').extable('setRowDisable', 6, data.beforeRowIndex, '');
							$('#budgetTable').extable('setRowDisable', 7, data.beforeRowIndex, '');
						}
					}
				} else {
					if(data.beforeColIndex == 6){	/* 결재수단 */
						if(data.data.setFgCode == '4') {		/* 결재수단 카드일 경우 */
							$("#btnAddCardHistory").show();
						} else {
							$("#btnAddCardHistory").hide();
						}
					} else if(data.beforeColIndex == 8){	/* 과세구분 */
						if( data.data.vatFgCode == '1' ||  data.data.vatFgCode == '2'){
							/* 채주유형 거래처 고정 */  
							$('#budgetTable').extable('setRowData', { trFgName:'거래처' }, 10, data.beforeRowIndex);
							$('#budgetTable').extable('setRowData', { trFgCode:'1' }, 11, data.beforeRowIndex);
							
							/* 채주유형 disable 처리 */
							$('#budgetTable').extable('setRowDisable', 10, data.beforeRowIndex, 'disabled');
							$('#budgetTable').extable('setRowDisable', 11, data.beforeRowIndex, 'disabled');
							
						} else {
							// TODO: 채주유형 기타일 경우 확인 필요
							$('#budgetTable').extable('setRowDisable', 10, data.beforeRowIndex, '');
							$('#budgetTable').extable('setRowDisable', 11, data.beforeRowIndex, '');
						}
						
					} else if(data.beforeColIndex == 10){	/* 채주유형 */
						/* 채주유형에 따른 거래처 테이블 변경 */
						fnChangeTradeColumn(data);
					}
				}

				/*
				 *	키다운 입력 이벤트 수행
				 */
				rowBudgetData = data;
				if ( data.afterRowIndex != data.beforeRowIndex && !data.data.budgetSeq ) {
					if ( table.check ( $ ( tbl.budget ) ).pass ) {
						fnSaveOrUpdateBudget ( data, 'click' );
						return true; /* 저장, 수정 구분 값 */
					} else if ( table.check ( $ ( tbl.res ) ).pass ) {
						return true;
					} else {
						return false;
					}
				} else if ( data.afterRowIndex != data.beforeRowIndex ) {
					if ( table.check ( $ ( tbl.budget ) ).pass ) {
						/* 저장, 수정 구분 값 */
						fnSaveOrUpdateBudget ( data, 'click' );
						return true; 
					}
					fnParamCheck ( tbl.budget.replace ( '#', '' ) );
					return false;
				} else {
					return true;
				}
				return true;
			},
			clickAfter: function ( data ) {
				console.log("clickAfter - 예산내역");
				//console.log(data);
				if(confferFlag == true) {
					//table.rmfocus( $ ( tbl.budget ) );
					$(".row-trade-" + data.beforeData.budgetSeq).hide();
					$(".row-trade-" + data.data.budgetSeq).show();
					return true;
				} else {
					if(data.afterRowIndex != data.beforeRowIndex && (data.beforeRowIndex != -1)){
						fnShowHideBudget(data);	
					} else if ((data.afterRowIndex == data.beforeRowIndex)) {
						fnShowHideBudget(data);
					}
				}
				
				return true;
			},
			row: {
				classes: function ( ) {
					return 'res_budgetRow row-res-' + table.selectRowData ( $ ( tbl.res ) ).data.resSeq + ' row-budget-' + table.selectRowData ( $ ( tbl.res ) ).data.resSeq;
					//return 'res_budgetRow row-budget-' + table.selectRowData ( $ ( tbl.res ) ).data.resSeq;
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
//			TODO: blur 이벤트 확인필요
// 			,
// 			blurEvent: function(data) {
// 				console.log('blurEvent-budget');
// 				console.log(data);
// 				//fnBlurCheck(data);
// 			}
		} );
    }
    
    /*	[ 테이블 Lv3 ] 거래처 정보 테이블 그리기
	----------------------------------------- */
    function fnDrawTradeInfo ( ) {
    	$("#btnAddCardHistory").hide();
    	
    	$ ( tbl.trade ).extable ( {
			column: ((erpTypeCode == "iCUBE") ? tradeTableColumnG20 : tradeTableColumn),
			data: [ ],
			height: 135,
			clickBefore: function ( data ) {
				log("거래처정보 clickBefore 데이터");
				log(data);
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
				return true;
			},
			clickAfter: function ( data ) {
				return true;
			},
			row: {
				classes: function ( ) {
					return 'res_tradeRow row-res-' + table.selectRowData ( $ ( tbl.budget ) ).data.resSeq + ' row-trade-' + table.selectRowData ( $ ( tbl.budget ) ).data.budgetSeq;
				}
			},
			tooltipFnc: function ( ) {
				var colInfo = $('#tradeTable').find('.colOn');
				var colIdx = $('#tradeTable').find('.colOn').index();
				
				if(colInfo.length > 0){
					$("#tradeHelp").text(this.column[colIdx].tooltip || '');
				} else {
					$("#tradeHelp").text("");
				}
			}
//			TODO: blur 이벤트 확인필요
// 			,
// 			blurEvent: function(data) {
// 				console.log('blurEvent-trade');
// 				console.log(data);
// 				//fnBlurCheck(data);
// 			}
		} );
    }
    
    /*	[ 결의정보 ] 저장
	----------------------------------------- */
    function fnSaveRes(data, code) {
    	/* input 포커스 삭제 */
		table.rmFocus ( $ ( tbl.res ) );
    	
		if(!approvalBeforeFlag) {
			resDocSeq = data.data.resDocSeq;
		}
    	
    	/* 결의정보 저장 */
		if ( table.check ( $ ( tbl.res ) ).pass ) {
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResHeadInsert.do',
				async: false,
				data: function ( ) {
					return $.extend ( fnGetCommonAjaxParam ( ), {
						resDocSeq: resDocSeq,					/* 결의문서 시퀀스 */
						docuFgCode: data.data.docuFgCode,					/* 결의구분 코드 */
						docuFgName: data.data.docuFgName,					/* 결의구분 코드 */
						resDate: erpTypeCode == 'iCUBE' ? data.data.resDateG20.replace(/\-/g,'') : data.data.resDate.replace(/\-/g,''),	/* 결의일자 */
						resNote: data.data.resNote,							/* 적요 */
						projectName: data.data.projectName,							/* 프로젝트 */
						projectSeq: data.data.projectSeq,					/* 프로젝트코드 */
						btrNumber: data.data.btrNumber,						/* 입출금계좌 */
						causeDate: data.data.causeDate.replace(/\-/g,''),						/* 원인행위일 */
						inspectDate: data.data.inspectDate.replace(/\-/g,''),					/* 계약일 */
						signDate: data.data.signDate.replace(/\-/g,''),						/* 검수일 */
						causeEmpName: data.data.causeEmpName,				/* 원인행위자 */
						causeEmpSeq: data.data.causeEmpSeq,					/* 원인행위자 시퀀스 */
						spec: data.data.spec,								/* 명세서 */
						erpMgtName : data.data.projectName,
						erpMgtSeq : data.data.projectSeq,
						erpGisu : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : ""),
						gisu : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : ""),
						erpGisuFromDate : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.fromDate : ""),
						erpGisuToDate : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.toDate : ""),
						erpDivSeq : optionSet.erpEmpInfo.erpDivSeq,
						erpDivName : optionSet.erpEmpInfo.erpDivName
					} );
				}
			} );

			if ( result != null ) {
				/* 품의정보 seq 생성 */
				resSeq = result.aData.resSeq;
				
				/* 테이블에 resSeq 저장 */
				if ( code == "click" ) {
					$ ( tbl.res ).extable ( 'setRowData', {
						resSeq: result.aData.resSeq
					}, idxZero, data.beforeRowIndex );
				} else {
					$ ( tbl.res ).extable ( 'setRowData', {
						resSeq: result.aData.resSeq
					}, idxZero, data.rowIndex );
				}
				
				/* 예산내역 추가 (포커스 이동) */
				fnAddDrawBudgetRow();
			}
		} else {
			fnParamCheck ( tbl.res.replace ( '#', '' ) );
		}
    }
    
    
    /*	[ 예산내역 ] 저장
	----------------------------------------- */
    function fnSaveBudget(data, code) {
    	log("예산내역 저장");
    	/* input 포커스 삭제 */
		table.rmFocus ( $ ( tbl.budget ) );
		var resRow = table.selectRowData($(tbl.res));
    	
		/* 예산내역 저장 */
		var result = fnAjax ( {
			url: '/ex/np/user/res/ResBudgetInsert.do',
			async: false,
			data: function ( ) {
				return $.extend ( fnGetCommonAjaxParam ( ), {
					resDocSeq: data.data.resDocSeq, 		/* 결의문서 시퀀스 */
					resSeq: data.data.resSeq, 				/* 결의내역 시퀀스 */	
					erpBudgetSeq: data.data.erpBudgetSeq, 	/* 예산단위 코드 */
					erpBudgetName: data.data.erpBudgetName, /* 예산단위 */
					erpBizplanName: data.data.erpBizplanName, 		/* 사업계획 */
					erpBizplanSeq: data.data.erpBizplanSeq, /* 사업계획 코드 */
					erpBgacctName: data.data.erpBgacctName,	/* 예산계정 */
					erpBgacctSeq: data.data.erpBgacctSeq,   /* 예산계정 코드 */
					budgetNote: data.data.budgetNote, 					/* 적요 */
					budgetAmt: (data.data.budgetAmt || 0), 				/* 금액 */
					setFgCode : data.data.setFgCode,			/* 결재수단 */
					setFgName : data.data.setFgName,			/* 결재수단 */
					vatFgCode : data.data.vatFgCode,			/* 과세구분 */
					vatFgName : data.data.vatFgName,			/* 과세구분 */
					trFgCode : data.data.trFgCode,				/* 채주유형 */
					trFgName : data.data.trFgName,				/* 채주유형 */
					resDate : (erpTypeCode == 'iCUBE' ? resRow.data.resDateG20.replace(/\-/g, '') : resRow.data.resDate.replace(/\-/g, '')),
					expendDate : (erpTypeCode == 'iCUBE' ? resRow.data.resDateG20.replace(/\-/g, '') : resRow.data.resDate.replace(/\-/g, '')),
					erpDivName : data.data.erpDivName,
					erpDivSeq : data.data.erpDivSeq,
					projectName : resRow.data.projectName,
					projectSeq : resRow.data.projectSeq,
					erpMgtName : resRow.data.projectName,
					erpMgtSeq : resRow.data.projectSeq,
					erpGisu : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : ""),
					gisu : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.gisu : ""),
					erpGisuFromDate : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.fromDate : ""),
					erpGisuToDate : (erpTypeCode == 'iCUBE' ? optionSet.erpGisu.toDate : ""),
					erpGisuDate: (erpTypeCode == 'iCUBE' ? resRow.data.resDateG20.replace(/\-/g, '') : resRow.data.resDate.replace(/\-/g, '')),
					erpBgt1Name : data.data.erpBgt1Name,
					erpBgt1Seq : data.data.erpBgt1Seq,
					erpBgt2Name : data.data.erpBgt2Name,
					erpBgt2Seq : data.data.erpBgt2Seq,
					erpBgt3Name : data.data.erpBgt3Name,
					erpBgt3Seq : data.data.erpBgt3Seq,
					erpBgt4Name : data.data.erpBgt4Name,
					erpBgt4Seq : data.data.erpBgt4Seq,
					erpOpenAmt : ($("#optionAmt").text().replace(/\,/g, '') || '0'),
					erpApplyAmt : ($("#applyAmt").text().replace(/\,/g, '') || '0'),
					erpLeftAmt : ($("#balanceAmt").text().replace(/\,/g, '') || '0')
				} );
			}
		} );

		if ( result != null ) {
			if ( result.resultCode == SUCCESS ) {
				var budgetAmt = result.aData.budgetAmt;
				budgetSeq = result.aData.budgetSeq;

				switch ( code.toUpperCase ( ) ) {
					case 'CLICK':
						$ ( tbl.budget ).extable ( 'setRowData', {
							resSeq: resSeq,
							resDocSeq: resSeq,
							budgetSeq: budgetSeq
						}, idxZero, data.beforeRowIndex );
						break;
					default:
						$ ( tbl.budget ).extable ( 'setRowData', {
							resSeq: resSeq,
							resDocSeq: resDocSeq,
							budgetSeq: budgetSeq
						}, idxZero, data.rowIndex );
						break;
				}
				
				var newRowNum = idxZero;
				newRowNum = $ ( "#tradeTable .res_tradeRow" ).length;
				
				/* 채주유형에 따른 거래처테이블 추가 */
				var selectBudgetRow = table.selectRowData($(tbl.budget));
				var index = 0;
				
				fnAddDrawTradeRow(selectBudgetRow.data.trFgCode, selectBudgetRow.data.vatFgCode);
			} else if(result.resultCode == EXCEED) {
				alert("예산이 초과되었습니다.");
				return;
			} else {
				console.log(result.resultName)
			}
		}
    }
    
    
    /*	[ 거래처 정보 ] 저장
	----------------------------------------- */
    function fnSaveTrade(data, code) {
		//table.rmFocus ( $ ( tbl.trade ) );
		var tmpResDocSeq = 0; 
		var tmpResSeq = 0;
		var selectBudgetRow = table.selectRowData($(tbl.budget));
		var resRow = table.selectRowData($(tbl.res));
		var param = fnGetCommonAjaxParam ( );
		var index = 0;
		
		if(approvalBeforeFlag) {
			tmpResDocSeq = resRow.data.resDocSeq;
			tmpResSeq = resRow.data.ressSeq;
		} else {
			tmpResDocSeq = data.data.resDocSeq;
			tmpResSeq = data.data.resSeq;
		}
		
		
		
		/* 채주유형에 따른 데이터 저장 */
		if(selectBudgetRow.data.trFgCode == "1" || selectBudgetRow.data.trFgCode == "3") {
			param.tradeAmt = data.data.tradeAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.tradeStdAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.tradeVatAmt.replace(/\,/g,'');
			index = 0;
		} else if(selectBudgetRow.data.trFgCode == "2") {
			param.tradeAmt = data.data.tradeAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.tradeStdAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.tradeVatAmt.replace(/\,/g,'');
			index = 3;
		} else if(selectBudgetRow.data.trFgCode == "4") {
			param.tradeAmt = data.data.payAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.realPayAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.payTaxAmt.replace(/\,/g,'');
			index = 5;
		} else if(selectBudgetRow.data.trFgCode == "5") {
			param.tradeAmt = data.data.payAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.realPayAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.payTaxAmt.replace(/\,/g,'');
			index = 3;
		} else if(selectBudgetRow.data.trFgCode == "6") {
			param.tradeAmt = data.data.payAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.realPayAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.payTaxAmt.replace(/\,/g,'');
			index = 7;
		} 
		
		param.trName = data.data.trName;
		param.trSeq = data.data.trSeq;
		param.empSeq = data.data.empSeq;
		param.empName = data.data.empName;
		param.etcCode = data.data.etcCode;
		param.etcName = data.data.etcName;
		param.bizIncomCode = data.data.bizIncomCode;
		param.bizIncomName = data.data.bizIncomName;
		param.ceoName = data.data.ceoName;
		param.btrName = data.data.btrName;
		param.btrSeq = data.data.btrSeq;
		param.baNb = data.data.baNb;
		param.depositor = data.data.depositor;
		param.tradeNote = data.data.tradeNote; // 
		param.regDate = data.data.regDate.replace(/\-/g,'');
		param.resDocSeq = tmpResDocSeq; //
		param.resSeq = tmpResSeq; //
		param.budgetSeq = data.data.budgetSeq; // 예산단위 이름
		param.tradeSeq = data.data.tradeSeq;
		param.interfaceType = data.data.interfaceType;
		param.interfaceSeq = data.data.interfaceSeq;
		param.resDate = (erpTypeCode == 'iCUBE' ? resRow.data.resDateG20.replace(/\-/g, '') : resRow.data.resDate.replace(/\-/g, ''));
		param.card = data.data.card;
		param.erpBudgetSeq = selectBudgetRow.data.erpBudgetSeq;

		
		
		var result = fnAjax ( {
			url: '/ex/np/user/res/ResTradeInsert.do',
			async: false,
			data: param
		} );

		if ( result != null ) {
			if ( result.resultCode == SUCCESS ) {
				var tradeAmt = result.aData.tradeAmt;
				tradeSeq = result.aData.tradeSeq;
				
				switch ( code.toUpperCase ( ) ) {
					case 'CLICK':
						$ ( tbl.trade ).extable ( 'setRowData', {
							resSeq: resSeq,
							resDocSeq: resDocSeq,
							budgetSeq: budgetSeq,
							tradeSeq: tradeSeq,
							regDate: data.data.regDate
						}, idxZero, data.beforeRowIndex );
						break;
					default:
						$ ( tbl.trade ).extable ( 'setRowData', {
							resSeq: resSeq,
							resDocSeq: resDocSeq,
							budgetSeq: budgetSeq,
							tradeSeq: tradeSeq,
							regDate: data.data.regDate
						}, idxZero, data.rowIndex );
						break;
				}

				if(confferFlag) {
					var resAmtRow = table.selectRowData ( $ ( tbl.res ) ).rowIndex;
					var budgetAmtRow = table.selectRowData ( $ ( tbl.budget ) ).rowIndex;
		            var budgetAmt = result.aData.budgetAmt;
					var amt = result.aData.amt;
					var consBalance = result.aData.consBalance;
					
					if(erpTypeCode == "iCUBE") {
						$(tbl.res).extable('setRowData', { amt: fnAddComma(amt) }, 5, resAmtRow);
			            $(tbl.budget).extable('setRowData', { amt: fnAddComma(budgetAmt) }, 14, budgetAmtRow);
			            $(tbl.budget).extable('setRowData', { budgetAmt: fnAddComma(consBalance) }, 15, budgetAmtRow);
			            
						if(consBalance < 0) {
							budgetCheckFlag = true;
							alert("예산잔액이 초과되었습니다.");
							return;
						} else {
							var newRowNum = idxZero;
							newRowNum = $ ( "#tradeTable .res_tradeRow" ).length;
							
							$ ( tbl.trade ).extable ( 'setAddRow', def.trade ( {
								resDocSeq: resDocSeq,
								resSeq: resSeq,
								budgetSeq: budgetSeq,
								tradeSeq: ''
							} ) );
							table.focus ( $ ( tbl.trade ), index, newRowNum );
						}
					} else {
						$(tbl.res).extable('setRowData', { amt: fnAddComma(amt) }, 5, resAmtRow);
			            $(tbl.budget).extable('setRowData', { amt: fnAddComma(budgetAmt) }, 14, budgetAmtRow);
			            //$(tbl.budget).extable('setRowData', { budgetAmt: fnAddComma(consBalance) }, 15, budgetAmtRow);
			            
						if(consBalance < 0) {
							budgetCheckFlag = true;
							alert("예산잔액이 초과되었습니다.");
							return;
						}
						
						/* 거래처정보추가 */
						var newRowNum = idxZero;
						newRowNum = $ ( "#tradeTable .res_tradeRow" ).length;
						
						$ ( tbl.trade ).extable ( 'setAddRow', def.trade ( {
							resDocSeq: resDocSeq,
							resSeq: resSeq,
							budgetSeq: budgetSeq,
							tradeSeq: ''
						} ) );
						table.focus ( $ ( tbl.trade ), index, newRowNum );
					}
					
					
				} else {
					/* 품의정보 금액 추가 */
					var resAmtRow = table.selectRowData ( $ ( tbl.res ) ).rowIndex;
					var budgetAmtRow = table.selectRowData ( $ ( tbl.budget ) ).rowIndex;
		            var budgetAmt = result.aData.budgetAmt;
					var amt = result.aData.amt;
					console.log(result);
		            console.log("품의정보 금액 : " + budgetAmt + "/" + amt);
					$(tbl.res).extable('setRowData', { resAmt: fnAddComma(amt) }, 5, resAmtRow);
		            $(tbl.budget).extable('setRowData', { budgetAmt: fnAddComma(budgetAmt) }, 14, budgetAmtRow);
		            
		            /* 과세유형,채주구분 disabled처리 */
		            if(erpTypeCode == 'iCUBE') {
		            	$('#budgetTable').extable('setRowDisable', 4, budgetAmtRow, 'disabled');
			            $('#budgetTable').extable('setRowDisable', 6, budgetAmtRow, 'disabled');
			            $("#tryAmt").text(fnAddComma(result.aData.tryAmt));
		            } else {
		            	$('#budgetTable').extable('setRowDisable', 8, budgetAmtRow, 'disabled');
			            $('#budgetTable').extable('setRowDisable', 10, budgetAmtRow, 'disabled');	
		            }
		            
		            /* 거래처정보추가 */
		            fnAddDrawTradeRow();
				}
				
			} else {
				console.log(result.resultName);
			}
		}
    }
    
    
    /*	[ 결의정보 ] 수정
	----------------------------------------- */
    function fnUpdateRes(data) {
		/* 데이터 변경이 없을 때 */
// 		if ( JSON.stringify ( commonResTableRowInfo.newData ) == JSON.stringify ( commonResTableRowInfo.orgnData ) ) { 
// 			return;
// 		}
		
		/* 예산 내역 이동 */
		table.rmFocus ( $ ( tbl.res ) );

		var updateParamCheck = table.check ( $ ( tbl.res ) ).pass;

		if ( updateParamCheck ) {
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResHeadUpdate.do',
				async: false,
				data: function ( ) {
					return $.extend ( fnGetCommonAjaxParam ( ), {
						resDocSeq: data.data.resDocSeq,
						resSeq: data.data.resSeq,
						docuFgCode: data.data.docuFgCode,
						docuFgName: data.data.docuFgName,
						resDate: (erpTypeCode == 'iCUBE' ? data.data.resDateG20.replace(/\-/g,'') : data.data.resDate.replace(/\-/g,'')),
						resNote: data.data.resNote,
						projectName: (erpTypeCode == 'iCUBE' ? data.data.projectName : ''),
						projectSeq: (erpTypeCode == 'iCUBE' ? data.data.projectSeq : ''),
						erpMgtName: (erpTypeCode == 'iCUBE' ? data.data.projectName : ''),
						erpMgtSeq: (erpTypeCode == 'iCUBE' ? data.data.projectSeq : ''),
						btrNumber: (erpTypeCode == 'iCUBE' ? data.data.btrNumber : ''),
						resAmt: data.data.resAmt,
						causeDate: (erpTypeCode == 'iCUBE' ? data.data.causeDate.replace(/\-/g,'') : ''),
						inspectDate: (erpTypeCode == 'iCUBE' ? data.data.inspectDate.replace(/\-/g,'') : ''),
						signDate: (erpTypeCode == 'iCUBE' ? data.data.signDate.replace(/\-/g,'') : ''),
						causeEmpName: (erpTypeCode == 'iCUBE' ? data.data.causeEmpName : ''),
						causeEmpSeq: (erpTypeCode == 'iCUBE' ? data.data.causeEmpSeq : ''),
						spec: (erpTypeCode == 'iCUBE' ? data.data.spec : ''),
						btrSeq: (erpTypeCode == 'iCUBE' ? data.data.btrSeq : ''),
						btrName: (erpTypeCode == 'iCUBE' ? data.data.btrName : '')
					} );
				}
			} );

			if ( result != null ) {
				if ( result.resultCode != SUCCESS ) {
					log ( result.resultName );
				} else {
					if(confferFlag) {
						var resRowData = table.selectRowData($(tbl.res));
						
						var index = $('.row-budget-' + resRowData.data.resSeq).index();
						
						table.focus ( $ ( tbl.budget ), idxZero, index );	
					}
				}
			}
		} else {
			var tableName = 'resTable';
			fnParamCheck ( tableName );
		}
    }
    
    /*	[ 예산내역 ] 수정
	----------------------------------------- */
	function fnUpdateBudget(data) {
    	log("예산내역 수정");
		/* 예산 내역 이동 */
		table.rmFocus ( $ ( tbl.budget ) );

		commonBudgetTableRowInfo.newData = data.data;
		
		/* 선택된 예산row 데이터 */
		var budgetRow = table.selectRowData( $ (tbl.budget) );
		var resRow = table.selectRowData( $ (tbl.res) );
		resSeq = resRow.data.resSeq;
		budgetSeq = budgetRow.data.budgetSeq;
		/* 수정 시 포커스 조절 */
		var index = 0;
		
		/* 포커스 위치 */
		index = $('.res_budgetRow').eq(budgetRow.rowIndex).nextAll('.row-budget-' + data.data.resSeq).index();
		
		if(index == -1 && !confferFlag) {
			//fnAddDrawBudgetRow();
		} else {
			var nextIndex = '';
			var newRowNum = idxZero;
			newRowNum = $ ( "#budgetTable .res_budgetRow" ).length;
			nextIndex = $(".res_budgetRow").eq(budgetRow.rowIndex).nextAll('.row-budget-' + data.data.resSeq).index();
			
			if(newRowNum < nextIndex) {
				if(confferFlag && !approvalBeforeFlag) {
					var index = 0;
					
					if(budgetRow.data.trFgCode == "1" || budgetRow.data.trFgCode == "3") {
						index = 0;
					} else if(budgetRow.data.trFgCode == "2" || budgetRow.data.trFgCode == "5") {
						index = 3;
					} else if(budgetRow.data.trFgCode == "4") {
						index = 5;
					} else if(budgetRow.data.trFgCode == "6") {
						index = 7;
					} 
					
					var tradeAllDataLength = table.allData($(tbl.trade)).length;
					
					if(tradeAllDataLength == 0) {
						fnAddDrawTradeRow(budgetRow.data.trFgCode, budgetRow.data.vatFgCode);
					} else {
						if(table.check($(tbl.trade)).pass) {
							fnAddDrawTradeRow(budgetRow.data.trFgCode, budgetRow.data.vatFgCode);
						} else {
							var tableName = 'resTable';
							fnParamCheck ( tableName );
							return;
						}
					}
				}else {
					fnAddDrawBudgetRow();
				}
				
			} else {
				if(confferFlag && !approvalBeforeFlag) {
					var index = 0;
					
					if(budgetRow.data.trFgCode == "1" || budgetRow.data.trFgCode == "3") {
						index = 0;
					} else if(budgetRow.data.trFgCode == "2" || budgetRow.data.trFgCode == "5") {
						index = 3;
					} else if(budgetRow.data.trFgCode == "4") {
						index = 5;
					} else if(budgetRow.data.trFgCode == "6") {
						index = 7;
					} 
					
					var tradeAllDataLength = table.allData($(tbl.trade)).length;
					if(tradeAllDataLength == 0) {
						fnAddDrawTradeRow(budgetRow.data.trFgCode, budgetRow.data.vatFgCode);
					} else {
						var tradeDataCheck = table.check ( $ ( tbl.trade ) );
						
						if(tradeDataCheck.count == tradeDataCheck.notInputCount) {
							if(tradeAllDataLength > 0) {
								var tradeRowData = table.selectRowData( $ (tbl.trade) );
								var index = tradeRowData.rowIndex;
								
								table.removeRow($(tbl.trade), index);	
								
								fnAddDrawTradeRow(budgetRow.data.trFgCode, budgetRow.data.vatFgCode);
							}
						}
					}
				} else {
					//table.focus ( $ ( tbl.budget ), idxZero, nextIndex );	
				}
					
			}
		}
		
		var param = fnGetCommonAjaxParam ( );
		
		param.resDocSeq = data.data.resDocSeq; //
		param.resSeq = data.data.resSeq; //
		param.budgetSeq = data.data.budgetSeq; // 예산단위 이름
		param.erpBudgetName = data.data.erpBudgetName; // 예산단위 이름
		param.erpBudgetSeq = data.erpBudgetSeq; // 예산단위 코드
		param.erpBizplanName = data.data.erpBizplanName; // 사업계획
		param.erpBizplanSeq = data.data.erpBizplanSeq; // 사업계획 코드
		param.bgt = data.data.bgt; // 예산계정
		param.div = data.data.div; // 회계계정
		param.budgetNote = (erpTypeCode == 'iCUBE' ? data.data.budgetNoteG20 : data.data.budgetNote); // 적요
		param.budgetAmt = data.data.budgetAmt; // 금액
		param.setFgCode = data.data.setFgCode;
		param.setFgName = data.data.setFgName;
		param.vatFgCode = data.data.vatFgCode;
		param.vatFgName = data.data.vatFgName;
		param.trFgCode = data.data.trFgCode;
		param.trFgName = data.data.trFgName;
		param.resDate = (erpTypeCode == 'iCUBE' ? resRow.data.resDateG20.replace(/\-/g, '') : resRow.data.resDate.replace(/\-/g, ''));
		param.erpBgt1Name = data.data.erpBgt1Name;
		param.erpBgt1Seq = data.data.erpBgt1Seq;
		param.erpBgt2Name = data.data.erpBgt2Name;
		param.erpBgt2Seq = data.data.erpBgt2Seq;
		param.erpBgt3Name = data.data.erpBgt3Name;
		param.erpBgt3Seq = data.data.erpBgt3Seq;
		param.erpBgt4Name = data.data.erpBgt4Name;
		param.erpBgt4Seq = data.data.erpBgt4Seq;
		param.erpOpenAmt = ($("#optionAmt").text().replace(/\,/g, '') || '0');
		param.erpApplyAmt = ($("#applyAmt").text().replace(/\,/g, '') || '0');
		param.erpLeftAmt = ($("#balanceAmt").text().replace(/\,/g, '') || '0');
		
		if(erpTypeCode == "iCUBE") {
			param.erpDivName = data.data.erpDivName;
			param.erpDivSeq = data.data.erpDivSeq;
			param.budgetBalanceAmt = data.data.budgetBalanceAmt;
		}
       
		/* 
	    	예산금액 보전이 필요한 경우 (뒤로가기 등.)
	    	서버에 금액 정보 null 전송시 금액 정보 업데이트 하지 않음.
	    */
	    if( ( parameter.erpBudgetSeq != '') && ( parameter.erpOpenAmt == '' ) ){
	        parameter.erpOpenAmt = null;
	        parameter.erpApplyAmt = null;
	        parameter.erpLeftAmt = null;
	    }
		
		var updateParamCheck = table.check ( $ ( tbl.budget ), budgetRow.rowIndex ).pass;

		if ( updateParamCheck ) {
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResBudgetUpdate.do',
				async: false,
				data: param
			} );

			if ( result != SUCCESS ) {
				
				if ( result.resultCode == SUCCESS ) {
					/* 헤더 표기 예산 정보 업데이트 */
					var budgetAmt = result.aData.amt;
					$ ( tbl.res ).extable ( 'setRowData', {
						resAmt: fnAddComma(budgetAmt)
					}, 5, table.selectRowData ( $ ( tbl.res ) ).rowIndex );
				} else {
					log ( result.resultName );
				}
			}
		} else {
			var tableName = 'budgetTable';
			fnParamCheck ( tableName );
		}
    }
    
	/*	[ 거래처 정보 ] 수정
	----------------------------------------- */
	function fnUpdateTrade(data) {
		/* 거래처정보 이동 */
		table.rmFocus ( $ ( tbl.trade ) );
		var resRow = table.selectRowData($(tbl.res));

// 		if ( JSON.stringify ( commonTradeTableRowInfo.newData ) == JSON.stringify ( commonTradeTableRowInfo.orgnData ) ) { 
// 			return;
// 		}
		
		if(approvalBeforeFlag) {
			data = table.selectRowData($(tbl.trade));
		}

		
		var selectBudgetRow = table.selectRowData($(tbl.budget));
		
		var param = fnGetCommonAjaxParam ( );
		
		/* 채주유형에 따른 데이터 저장 */
		if(selectBudgetRow.data.trFgCode == "1" || selectBudgetRow.data.trFgCode == "3") {
			param.tradeAmt = data.data.tradeAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.tradeStdAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.tradeVatAmt.replace(/\,/g,'');
			index = 0;
		} else if(selectBudgetRow.data.trFgCode == "2") {
			param.tradeAmt = data.data.tradeAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.tradeStdAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.tradeVatAmt.replace(/\,/g,'');
			index = 3;
		} else if(selectBudgetRow.data.trFgCode == "4") {
			param.tradeAmt = data.data.payAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.realPayAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.payTaxAmt.replace(/\,/g,'');
			index = 5;
		} else if(selectBudgetRow.data.trFgCode == "5") {
			param.tradeAmt = data.data.payAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.realPayAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.payTaxAmt.replace(/\,/g,'');
			index = 3;
		} else if(selectBudgetRow.data.trFgCode == "6") {
			param.tradeAmt = data.data.payAmt.replace(/\,/g,'');
			param.tradeStdAmt = data.data.realPayAmt.replace(/\,/g,'');
			param.tradeVatAmt = data.data.payTaxAmt.replace(/\,/g,'');
			index = 7;
		} 

		param.trName = data.data.trName;
		param.trSeq = data.data.trSeq;
		param.empSeq = data.data.empSeq;
		param.empName = data.data.empName;
		param.etcCode = data.data.etcCode;
		param.etcName = data.data.etcName;
		param.bizIncomCode = data.data.bizIncomCode;
		param.bizIncomName = data.data.bizIncomName;
		param.ceoName = data.data.ceoName;
		param.btrName = data.data.btrName;
		param.btrSeq = data.data.btrFgCode;
		param.baNb = data.data.baNb;
		param.depositor = data.data.depositor;
		param.tradeNote = data.data.tradeNote; // 
		param.regDate = data.data.regDate.replace(/\-/g,'');
		param.resDocSeq = data.data.resDocSeq; //
		param.resSeq = data.data.resSeq; //
		param.budgetSeq = data.data.budgetSeq; // 예산단위 이름
		param.tradeSeq = data.data.tradeSeq;
		param.resDate = resRow.data.resDate.replace(/\-/g, '');
		
		var updateParamCheck = table.check ( $ ( tbl.trade ) ).pass;

		var result = fnAjax ( {
			url: '/ex/np/user/res/ResTradeUpdate.do',
			async: false,
			data: param
		} );

		if ( result != null ) {
			console.log("거래 내역 수정");
			console.log(result);

			if ( result.resultCode == SUCCESS ) {
				var newRowNum = idxZero;
				newRowNum = $ ( "#tradeTable .res_tradeRow" ).length;
				
				table.focus ( $ ( tbl.trade ), idxZero, (newRowNum-1) );
				
				$(tbl.res).extable('setRowData', { resAmt: fnAddComma(result.aData.amt) }, 7, resRow.rowIndex);
            	$(tbl.budget).extable('setRowData', { budgetAmt: fnAddComma(result.aData.budgetAmt) }, 11, selectBudgetRow.rowIndex);
				
            	$("#tryAmt").text(result.aData.tryAmt);
			} else {
				$.error ( result.resultName );
			}
		}
	}
	
	/*	[ 결의정보 ] 삭제
	----------------------------------------- */
	function fnDeleteRes() {
		/* 현재 선택 되어 있는 행 반환 */
		var selectRowData = table.selectRowData ( $ ( tbl.res ) );
		if(selectRowData.rowIndex < 0){
			console.log('삭제할 결의서 정보가 없습니다.');
			return;
		}
		
		if ( selectRowData.data.resSeq != "" ) {
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResHeadDelete.do',
				async: false,
				data: {
					resDocSeq: selectRowData.data.resDocSeq,
					resSeq: selectRowData.data.resSeq
				}
			} );

			if ( result != null ) {
				table.removeRow ( $ ( tbl.res ), selectRowData.rowIndex );
				
				/* 예산내역 remove */
				$(".row-res-" + selectRowData.data.resSeq).remove();
				
				/* 거래처정보 remove */
				$(classes.res + resSeq).remove();
			}
		} else {
			table.removeRow ( $ ( tbl.res ), selectRowData.rowIndex );
		}
	}
	
	/*	[ 결의정보 ] 모든 결의정보 삭제
	----------------------------------------- */
	function fnDeleteAllRes() {
		var allResData = table.allData ( $ ( tbl.res) );
		
		for(var i=0; i<allResData.length; i++) {
			var removeResDocSeq = (allResData[i].resDocSeq || '');
			var removeResSeq = (allResData[i].resSeq || '');
			
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResHeadDelete.do',
				async: false,
				data: {
					resDocSeq: removeResDocSeq,
					resSeq: removeResSeq
				}
			} );
		}
	}
	
	/*	[ 예산내역 ] 삭제
	----------------------------------------- */
	function fnDeleteBudget() {
		/* 현재 선택 되어 있는 행 반환 */
		var selectRowData = table.selectRowData ( $ ( tbl.budget ) );
		if(selectRowData.rowIndex < 0){
			console.log('삭제할 예산 내역이 없습니다.');
			return;
		}
		
		if ( selectRowData.data.budgetSeq != "" ) { // 예산 seq 생성 전
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResBudgetDelete.do',
				async: false,
				data: {
					resDocSeq: selectRowData.data.resDocSeq,
					resSeq: selectRowData.data.resSeq,
					budgetSeq: selectRowData.data.budgetSeq
				}
			} );

			if ( result != null ) {
				
				table.removeRow ( $ ( tbl.budget ), selectRowData.rowIndex );
				
				/* 거래처정보 remove */
				$(classes.trade + selectRowData.data.budgetSeq).remove();
				var budgetRowData = table.selectRowData ( $ ( tbl.budget ) );
				/* 해당 예산내역에 묶여 있는 거래처 순서 찾기 */
				if(budgetRowData.rowIndex == -1) {
					$('#budgetTable').extable('setFocus', 0, 0);
				} else {
					$('#budgetTable').extable('setFocus', 0, (budgetRowData.rowIndex - 1) );	
				}
				
			}
		} else {
			table.removeRow ( $ ( tbl.budget ), selectRowData.rowIndex );
			
			$('#budgetTable').extable('setFocus', 0, (selectRowData.rowIndex - 1) );
		}
	}
	
	/*	[ 거래처 정보 ] 삭제
	----------------------------------------- */
	function fnDeleteTrade() {
		/* 현재 선택 되어 있는 행 반환 */
		var selectRowData = table.selectRowData ( $ ( tbl.trade ) );
		if(selectRowData.rowIndex < 0){
			console.log('삭제할 거래처 정보가 없습니다.');
			return;
		}
		
		if ( selectRowData.data.tradeSeq != "" ) { // 예산 seq 생성 전
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResTradeDelete.do',
				async: false,
				data: {
					resDocSeq: selectRowData.data.resDocSeq,
					resSeq: selectRowData.data.resSeq,
					budgetSeq: selectRowData.data.budgetSeq,
					tradeSeq: selectRowData.data.tradeSeq
				}
			} );

			if ( result != null ) {
				table.removeRow ( $ ( tbl.trade ), selectRowData.rowIndex );
				
				var budgetSeq = selectRowData.data.budgetSeq;
				var tradeLength = $(".row-trade-" + budgetSeq).length;
				var budgetRow = table.selectRowData ( $ ( tbl.budget ) );
					
				if(erpTypeCode == "iCUBE") {
					if(tradeLength == 0) {
						$('#budgetTable').extable('setRowDisable', 4, budgetRow.rowIndex, '');
			            $('#budgetTable').extable('setRowDisable', 6, budgetRow.rowIndex, '');
					}
				} else {
					if(tradeLength == 0) {
						$('#budgetTable').extable('setRowDisable', 8, budgetRow.rowIndex, '');
			            $('#budgetTable').extable('setRowDisable', 10, budgetRow.rowIndex, '');
					}	
				}
				
				/* 해당 예산내역에 묶여 있는 거래처 순서 찾기 */
				if(budgetRow.rowIndex == 0 || budgetRow.rowIndex == -1) {
					$('#tradeTable').extable('setFocus', 0, 0 );
				} else {
					$('#tradeTable').extable('setFocus', 0, (budgetRow.rowIndex - 1) );	
				}
				
				
			}
		} else {
			var index = selectRowData.rowIndex;
			
			table.removeRow($(tbl.trade), selectRowData.rowIndex);
			if(erpTypeCode == "iCUBE") {
				$('#tradeTable').extable('setFocus', 28, (index-1));	
			}
			// $('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
		}
	}
	
	/*	[ 결의정보 ] 추가(버튼)
	----------------------------------------- */
	function fnAddRes() {
		var resRowData = table.selectRowData ( $ ( tbl.res ) ); // 현재 선택 되어 있는 품의정보 데이터 조회
		var resAddCheckFlag = false;
		
		/* 품의정보 필수값 체크 */
		if ( table.check ( $ ( tbl.res ) ).pass ) {
			/* 추가 버튼 클릭 시 저장 */
			var resRow = table.selectRowData ( $ ( tbl.res ) );

			if ( resRow.data.resSeq == "" ) {
				fnSaveOrUpdateRes(rowResData, 'click');
			}
			
			/* 예산내역 데이터 확인 */
			var budgetAllData = table.allData($(tbl.budget));
			
			if(budgetAllData.length != 0) {
				var budgetRowData = table.selectRowData($(tbl.budget));
				var budgetRowCheck = table.check($(tbl.budget));
				
				/* resSeq에 맞는 row수 있는지 확인 */
				for(var i=0; i<budgetAllData.length; i++) {
					if(budgetAllData[i].resSeq == resSeq && budgetAllData[i].budgetSeq != "") {
						resAddCheckFlag = true;
					}
				}
				
				if(resAddCheckFlag) {
					var lastResIndex = table.allData($(tbl.res)).length;
					
					if ( table.check ( $ ( tbl.res ), lastResIndex-1 ).pass ) {
						if(table.check($(tbl.trade)).pass) {
							var tradeSelectRow = table.selectRowData($(tbl.trade));
							
							if(tradeSelectRow.data.tradeSeq == "") {
								fnSaveOrUpdateTrade( rowTradeData, 'click' );
								
								fnAddDrawResRow();
 								$ ( classes.row + table.rowData ( $ ( tbl.res ), rowResData.beforeRowIndex ).resSeq ).hide ( );
							} else {
								fnAddDrawResRow();
								$ ( classes.row + table.rowData ( $ ( tbl.res ), rowResData.beforeRowIndex ).resSeq ).hide ( );
							}
						} else {
							
							var tradeAllData = table.allData($(tbl.trade));
							
							if(tradeAllData.length > 0 ) {
								var tradeSelectRow = table.selectRowData($(tbl.trade));
								var tradeCheck = table.check($(tbl.trade));
								var tradeLength = $("#tradeTable .row-res-" + budgetRowData.data.resSeq).length;
								
								/* 결의내역에 해당되는 거래처정보 확인 */
								if(tradeLength == 1 && (tradeCheck.key.length == 5)) {
									fnParamCheck ( tbl.trade.replace ( '#', '' ) );
									return;	
								} else {
									if(table.check($(tbl.trade)).pass) {
										if(tradeSelectRow.data.tradeSeq == "") {
											fnSaveOrUpdateTrade( rowTradeData, 'click' );
											
											fnAddDrawResRow();
											$ ( classes.row + table.rowData ( $ ( tbl.res ), rowResData.beforeRowIndex ).resSeq ).hide ( );
										} else {
											fnAddDrawResRow();
											$ ( classes.row + table.rowData ( $ ( tbl.res ), rowResData.beforeRowIndex ).resSeq ).hide ( );
										}	
									} else {
										if(tradeCheck.key.length == 5) {
											fnAddDrawResRow();
											$ ( classes.row + table.rowData ( $ ( tbl.res ), rowResData.beforeRowIndex ).resSeq ).hide ( );
										} else {
											fnParamCheck ( tbl.trade.replace ( '#', '' ) );
											return;	
										}
											
									}
								}
							} else {
								fnParamCheck ( tbl.trade.replace ( '#', '' ) );
								return;	
							}
						}
					} else {
						fnParamCheck ( tbl.res.replace ( '#', '' ) );
						return;
					}
				} else {
					if(budgetRowCheck.pass) {
						/* 예산내역 저장 */
						if(budgetRowData.data.budgetSeq == "") {
							fnSaveOrUpdateBudget( rowBudgetData, 'click' );
						} else {
							if(confferFlag) {
								fnAddDrawResRow();
								$ ( classes.row + table.rowData ( $ ( tbl.res ), rowResData.beforeRowIndex ).resSeq ).hide ( );
							}
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
			fnParamCheck ( tbl.res.replace ( '#', '' ) );
			return;
		}
	}
	
	/*	[ 예산내역 ] 추가(버튼)
	----------------------------------------- */
	function fnAddBudget() {
		var tableRowAllData = table.allData ( $ ( tbl.budget ) );
		var resRowData = table.selectRowData ( $ ( tbl.res ) ); // 현재 선택 되어 있는 품의정보 데이터 조회
		var budgetAddCheckFlag = false;
		
		if(resRowData.data.resSeq == "") {
			fnParamCheck ( tbl.res.replace ( '#', '' ) );
			return;
		} else {
			if(tableRowAllData.length == 0) {
				fnAddDrawBudgetRow();
			} else {
				if ( table.check ( $ ( tbl.budget ) ).pass ) {
					/* 현재 예산 데이터 */
					var budgetRowData = table.selectRowData ($(tbl.budget));
					
					/* 거래처 값 확인 */
					var tradeRowCount = $(".row-trade-" + budgetRowData.data.budgetSeq).length;
					
					if(tradeRowCount == 0) {
						alert("거래처정보를 입력하세요");
						
						fnAddDrawTradeRow(budgetRowData.data.trFgCode, budgetRowData.data.vatFgCode);
			    		
						return;
					} else {
						var tradeDataCheck = table.check ( $ ( tbl.trade ) );
						var tradeRowData = table.selectRowData($(tbl.trade));
						
						if(tradeDataCheck.count == tradeDataCheck.notInputCount) {
							var index = tradeRowData.rowIndex;
							
							table.removeRow($(tbl.trade), tradeRowData.rowIndex);
							
							fnAddDrawTradeRow(budgetRowData.data.trFgCode, budgetRowData.data.vatFgCode);
						} else {
							/* 거래처 정보 저장 */
							
							
							if(tradeRowData.data.tradeSeq == "" && table.check ( $ ( tbl.trade ) ).pass) {
								
								fnSaveOrUpdateTrade( rowTradeData, 'click' );
								fnAddDrawBudgetRow();
								
								return;
								
							} else {
								if ( table.check ( $ ( tbl.trade ) ).pass ) {
									fnAddDrawBudgetRow();
								} else {
									fnParamCheck ( tbl.trade.replace ( '#', '' ) );
									return;
								}
							}
						}
					}
					
				} else {
					fnParamCheck ( tbl.budget.replace ( '#', '' ) );
					return;
				}
			}
		}
		
		if(tableRowAllData.length == 0) {
			fnAddDrawBudgetRow();
		} else {
			/* 예산내역 필수값 체크 */
			if ( table.check ( $ ( tbl.budget ) ).pass ) {
				/* 추가 버튼 클릭 시 저장 */
				var budgetRow = table.selectRowData ( $ ( tbl.budget ) );

				if ( budgetRow.data.budgetSeq == "" ) {
					fnSaveOrUpdateBudget ( rowBudgetData, 'click' );
				}
				
				/* 예산내역 데이터 확인 */
				var tradeAllData = table.allData($(tbl.trade));
				
				if(tradeAllData.length != 0) {
					var tradeRowData = table.selectRowData($(tbl.trade));
					var tradeRowCheck = table.check($(tbl.trade));
					
					/* budgetSeq에 맞는 row수 있는지 확인 */
					for(var i=0; i<tradeAllData.length; i++) {
						if(tradeAllData[i].budgetSeq == budgetSeq && tradeAllData[i].tradeSeq != "") {
							budgetAddCheckFlag = true;
						}
					}
					
					if(budgetAddCheckFlag) {
						//alert('bbbbb');
						var lastBudgetIndex = table.allData($(tbl.budget)).length;
						
						if ( table.check ( $ ( tbl.budget ), lastBudgetIndex-1 ).pass ) {
							var tradeAllData = table.allData($(tbl.trade));
							fnAddDrawBudgetRow();

							$ ( classes.trade + table.rowData ( $ ( tbl.budget ), rowBudgetData.beforeRowIndex ).budgetSeq ).hide ( );	
						} else {
							fnParamCheck ( tbl.budget.replace ( '#', '' ) );
							return;
						}
					} else {
						if(tradeRowCheck.pass) {
							/* 거래처내역 저장 */
							if(tradeRowData.data.tradeSeq == "") {
								fnSaveOrUpdateTrade ( rowTradeData, 'click' );
								
								var tradeAllData = table.allData($(tbl.trade));
								fnAddDrawBudgetRow()

								$ ( classes.trade + table.rowData ( $ ( tbl.budget ), rowBudgetData.beforeRowIndex ).budgetSeq ).hide ( );
							}
						} else {
							
							fnParamCheck ( tbl.trade.replace ( '#', '' ) );
							return;
						}
					}
				} else {
					alert ( "거래처 정보를 입력하세요." );
					return;
				}
			} else {
				fnParamCheck ( tbl.budget.replace ( '#', '' ) );
				return;
			}
		}
		
	}
	
	/*	[ 거래처 정보 ] 추가(버튼)
	----------------------------------------- */
	function fnAddTrade() {
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
			
			if(confferFlag && !approvalBeforeFlag) {
				var tradeLength = $('.row-trade-'+budgetRowData.data.budgetSeq).length;
				var tradeAllLength = table.allData($(tbl.trade)).length;
				
				var index = 0;
				
				if(tradeAllLength == 0) {
					fnAddDrawTradeRow(budgetRowData.data.trFgCode, budgetRowData.data.vatFgCode);
				} else {
					var tradeDataCheck = table.check ( $ ( tbl.trade ) );
					
					if(tradeDataCheck.count == tradeDataCheck.notInputCount) {
						var index = tradeRowData.rowIndex;
						
						table.removeRow($(tbl.trade), tradeRowData.rowIndex);
						
						fnAddDrawTradeRow(budgetRowData.data.trFgCode, budgetRowData.data.vatFgCode);
					} else {
						fnParamCheck ( tbl.trade.replace ( '#', '' ) );
						return false;
					}
				}
				return;
			} else {
				
			}
			
			
			/* 예산내역 row가 저장되지 않았을 경우 */
			if(budgetRowData.data.budgetSeq == "") {
				fnSaveOrUpdateBudget ( rowBudgetData, 'click' );
			}
			
			var tradeAllData = table.allData ( $ ( tbl.trade ) );
			
			if(tradeAllData.length == 0) {
				fnAddDrawTradeRow(budgetRowData.data.trFgCode, budgetRowData.data.vatFgCode);
			} else {
				var tradeDataCheck = table.check ( $ ( tbl.trade ) );
				
				if(tradeDataCheck.count == tradeDataCheck.notInputCount) {
					var index = tradeRowData.rowIndex;
					
					table.removeRow($(tbl.trade), tradeRowData.rowIndex);
					
					fnAddDrawTradeRow(budgetRowData.data.trFgCode, budgetRowData.data.vatFgCode);
				} else {
	 				/* 거래처정보 필수값 확인 */
	 				if(table.check($(tbl.trade)).pass) {	
	 					/* 예산내역 필수값이 저장되지 않았을 경우 */
	 					if(tradeRowData.data.tradeSeq == "") {
	 						fnSaveOrUpdateTrade ( rowTradeData, 'click' );				
	 					} else {
	 						fnAddDrawTradeRow(budgetRowData.data.trFgCode, budgetRowData.data.vatFgCode);
	// 						fnParamCheck ( tbl.trade.replace ( '#', '' ) );
	// 						return false;
	 					}
	 				} else {
	 					fnParamCheck ( tbl.trade.replace ( '#', '' ) );
	 					return false;
	 				}
				}
				
// 				/* 거래처정보 필수값 확인 */
// 				if(table.check($(tbl.trade)).pass) {	
// 					/* 예산내역 필수값이 저장되지 않았을 경우 */
// 					if(tradeRowData.data.tradeSeq == "") {
// 						fnSaveOrUpdateTrade ( rowTradeData, 'click' );				
// 					} else {
// 						fnAddDrawTradeRow(budgetRowData.data.trFgCode, budgetRowData.data.vatFgCode);
// // 						fnParamCheck ( tbl.trade.replace ( '#', '' ) );
// // 						return false;
// 					}
// 				} else {
// 					fnParamCheck ( tbl.trade.replace ( '#', '' ) );
// 					return false;
// 				}
			}
			
			
			
		} else {
			fnParamCheck ( tbl.budget.replace ( '#', '' ) );
			return false;
		}
	}
		
	/* [결의정보] 행 row 그려주기(공통) 
	----------------------------------------- */
	function fnAddDrawResRow() {
		var newRowIndex = 0;
		newRowIndex = $ ( "#resTable .res_resRow" ).length;
		
		table.addRow ( $ ( tbl.res ), def.res ( {
			resDocSeq: resDocSeq
		} ) );
		
		//table.focus ( $ ( tbl.res ), idxZero, resRowData.rowIndex + 1 );
		table.focus ( $ ( tbl.res ), idxZero, newRowIndex );
		
		setTimeout(function() { $("#resTable .inpTextBox").focus() }, 500);
	}	
		
	/* [예산내역] 행 row 그려주기(공통) 
	----------------------------------------- */
	function fnAddDrawBudgetRow() {
		var newRowIndex = 0;
		newRowIndex = $ ( "#budgetTable .res_budgetRow" ).length;
		
		table.addRow ( $ ( tbl.budget ), def.budget ( {
			resDocSeq: resDocSeq,
			resSeq:resSeq,
			budgetSeq: ''
		} ) );
	
		//table.focus ( $ ( tbl.budget ), idxZero, rowBudgetData.beforeRowIndex + 1 );
		table.focus ( $ ( tbl.budget ), idxZero, newRowIndex );
		
		setTimeout(function() { $("#budgetTable .inpTextBox").focus() }, 500);
		
		
	}

	
	/* [거래처정보] 행 row 그려주기(공통) 
	----------------------------------------- */
	function fnAddDrawTradeRow(colIndex, vatFgCode) {	
		var index = 0;
		var newRowIndex = 0;
		newRowIndex = $ ( "#tradeTable .res_tradeRow" ).length;
		
		if(colIndex == "1" || colIndex == "3") {
			index = 0;
		} else if(colIndex == "2" || colIndex == "5") {
			index = 3;
		} else if(colIndex == "4") {
			index = 5;
		} else if(colIndex == "6") {
			index = 7;
		} 
		
		
		
		if(vatFgCode == "3") {
			table.addRow ( $ ( tbl.trade ), def.trade ( {
				resDocSeq: resDocSeq,
				resSeq: resSeq,
				budgetSeq: budgetSeq,
				tradeSeq: ''
			} ) );
			if(erpTypeCode == 'iCUBE') {
				$('#tradeTable').extable('setRowDisable', 9, newRowIndex, 'disabled');
				$('#tradeTable').extable('setRowData', { tradeVatAmt: 0 }, 13, (newRowIndex-1));	
			}
		} else {
			table.addRow ( $ ( tbl.trade ), def.trade ( {
				resDocSeq: resDocSeq,
				resSeq: resSeq,
				budgetSeq: budgetSeq,
				tradeSeq: ''
			} ) );
			$('#tradeTable').extable('setRowDisable', 9, newRowIndex, '');
			
		}
		
		table.focus ( $ ( tbl.trade ), index, newRowIndex );
		
		
		
		setTimeout(function() { $("#tradeTable .inpTextBox").focus() }, 500);
		
		
	}
	
	/*	[ 결의정보 ] 저장 or 수정 판단
	----------------------------------------- */
	function fnSaveOrUpdateRes(data, code) {
		/* 변경 데이터 확인 */
		commonResTableRowInfo.table = 'resTable';
		commonResTableRowInfo.newData = JSON.parse(JSON.stringify(data.data));
		commonResTableRowInfo.orgnData = JSON.parse(JSON.stringify(data.beforeData));
		
		/* 변수 정의 */
		var beforeData = '';
		var afterData = '';
		var nowData = '';
		
		if(code == "click") {
			beforeData = table.rowData($(tbl.res), data.beforeRowIndex);
			afterData = table.rowData($(tbl.res), data.afterRowIndex);
			nowData = data.data;
		} else if(code == "enter") {
			beforeData = table.rowData($(tbl.res), data.rowIndex);
			afterData = table.rowData($(tbl.res), data.rowIndex);
			nowData = data.data;
		}

		if ( table.check ( $ ( tbl.res ) ).pass ) {
			if(nowData.resSeq == "") {
				/* 품의정보 저장 */
				fnSaveRes(data, code);
			} else {
				/* 품의정보 수정 */
				fnUpdateRes(data, code);
			}
		} else {
			var tableName = 'resTable';
			fnParamCheck ( tableName );
			return;
		}
		
		
 		$ ( classes.budget + "-" + afterData.resSeq ).show ( );
	}
	
	/*	[ 예산내역 ] 저장 or 수정 판단
	----------------------------------------- */
	function fnSaveOrUpdateBudget(data, code) {
		/* 변경 데이터 확인 */
		commonBudgetTableRowInfo.table = 'budgetTable';
		commonBudgetTableRowInfo.newData = JSON.parse(JSON.stringify(data.data));
		commonBudgetTableRowInfo.orgnData = JSON.parse(JSON.stringify(data.beforeData));
		
		/* 변수 정의 */
		var beforeData = '';
		var afterData = '';
		var nowData = '';
		
		if(code == "click") {
			beforeData = table.rowData($(tbl.budget), data.beforeRowIndex);
			afterData = table.rowData($(tbl.budget), data.afterRowIndex);
			nowData = table.rowData($(tbl.budget), data.afterRowIndex);
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
		
 		$ ( ".res_tradeRow" ).hide ( );
 		$ ( classes.trade + nowData.budgetSeq ).show ( );
	}
	
	/*	[ 거래처 정보 ] 저장 or 수정 판단
	----------------------------------------- */
	function fnSaveOrUpdateTrade(data, code) {
		/* 변경 데이터 확인 */
		commonTradeTableRowInfo.table = 'tradeTable';
		commonTradeTableRowInfo.newData = JSON.parse(JSON.stringify(data.data));
		commonTradeTableRowInfo.orgnData = JSON.parse(JSON.stringify(data.beforeData));
		
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
				fnSaveTrade(data, code);
			} else {
				/* 품의정보 수정 */
				fnUpdateTrade(data, code);
			}
		} else {
			var tableName = 'tradeTable';
			fnParamCheck ( tableName );
			return;
		}	
	}
    
    /*	[참조품의] 참조품의 그리기
    	각  Info데이터 구조는 [{}, {}]을 따름.
    	data.resDocInfo	: 결의 문서 정보 		key : resDocSeq
    	data.resHeadInfo : 결의서 테이블 정보	key : resDocSeq, resSeq
    	data.BudgetInfo : 결의서 예산 정보		key : resDocSeq, resSeq, resBudgetSeq
    	data.tradeInfo : 결의서 거래처 정보		key : resDocSeq, resSeq, resBudgetSeq, trSeqs
	----------------------------------------- */
	function fnDrawConffer(data) {
	   	confferFlag = true;	
		var resDocInfo = data.resDocInfo;
		var resHeadInfo = data.resHeadInfo;
		var budgetInfo = data.budgetInfo;
		var tradeInfo = data.tradeInfo;
		
		/* 기존 입력 초기화 */
		$(tbl.res).contents().unbind().remove();
	    $(tbl.budget).contents().unbind().remove();
	    $(tbl.trade).contents().unbind().remove();

		/* 결의추가, 예산추가 버튼 삭제 */
		$("#btnAddRes").hide();
		$("#btnAddBudget").hide();
		
		fnDrawResInfo();
		fnDrawBudgetInfo();
		fnDrawTradeInfo();
		
		/* 결의정보 데이터 */
		var firstResSeq = 0;
		var resSeqArray = new Array();
		for(var i=0; i<resHeadInfo.length; i++) {
			var year = resHeadInfo[i].resDate.substring(0,4);
			var month = resHeadInfo[i].resDate.substring(4,6);
			var day = resHeadInfo[i].resDate.substring(6,8);
			var displayDate = year + "-" + month + "-" + day;
			resHeadInfo[i].resAmt = fnAddComma(0);
			resSeqArray.push(resHeadInfo[i].resSeq);
			firstResSeq = resHeadInfo[0].resSeq;	
			
			$ ( tbl.res ).extable ( 'setAddRow', resHeadInfo[i] );
		}
		
		table.focus($(tbl.res), 0, 0);
		
		fnDrawBudgetInfo();
		
		/* 예산내역 데이터 */
		var firstBudgetSeq = 0;
		var budgetSeqArray = new Array();
		var erpBudgetSeq = {};
		for(var i=0; i<budgetInfo.length; i++) {
			budgetInfo[i].budgetAmt = fnAddComma(0);
			budgetSeqArray.push(budgetInfo[i].resSeq);
			erpBudgetSeq.erpBudgetSeq = budgetInfo[0].erpBudgetSeq;
			firstBudgetSeq = budgetInfo[0].budgetSeq;
			
			$ ( tbl.budget ).extable ( 'setAddRow', budgetInfo[i] );
		}
		

		
		
		$("[class*=row-res-]").removeClass();
		$("[class*=row-budget-]").removeClass();
		
		for(var i=0; i<resSeqArray.length; i++) {
			$("#resTable > .rowHeight > table > tbody > tr:eq(" + i + ")").addClass("row-res-" + resSeqArray[i]);	
		}
		
		for(var i=0; i<budgetSeqArray.length; i++) {
			$("#budgetTable > .rowHeight > table > tbody > tr:eq(" + i + ")").addClass("res_budgetRow row-budget-" + budgetSeqArray[i]);	
		}
		
		/* 결의정보에 따른 예산정보 숨김처리 */
		$(".res_budgetRow").hide();
		
		$(".row-budget-" + firstResSeq).show();
		
		//$('#budgetTable').extable('setDisplayChange', ["Y","N","Y","N","Y","N","Y","N","Y","N","Y","Y","N","N","N","N"]);
		
 		//table.focus($(tbl.budget), 0, 0);
 	
		if(erpTypeCode == "iCUBE") {
			fnSelectBalanceBudget(erpBudgetSeq);	
		}
	}
	
    /*	[ 결의정보 ] 클릭 시 show & hide
	----------------------------------------- */
	function fnShowHideRes(data) {
		var resRowData = table.rowData($(tbl.res), data.afterRowIndex);
		
		$(".res_budgetRow").hide();
		$(".res_tradeRow").hide();
		$(".row-budget-" + resRowData.resSeq).show();
		
		var index = $('.res_budgetRow').eq(0).nextAll('.row-budget-' + resRowData.resSeq).index();
		table.rmFocus ( $ ( tbl.budget ) );
		table.focus($(tbl.budget), 0, 0);
	}
    
	/*	[ 예산내역 ] 클릭 시 show & hide
	----------------------------------------- */
	function fnShowHideBudget(data) {
		console.log("클릭시 show & hide");
		console.log(data);
		var budgetRowData = table.rowData($(tbl.budget), data.afterRowIndex);
		 /* 결재수단에 따른 필수체크 플래그 */
		 var setFgCodeFlag = "N";
		 
		 if(budgetRowData.setFgCode == "1") {
			 setFgCodeFlag = "Y";
		 } else {
			 setFgCodeFlag = "N";
		 }
		
		if(erpTypeCode == 'iCUBE') {
			if(budgetRowData.setFgCode == "4") {
				setFgCodeFlag = "Y";
			} else {
				setFgCodeFlag = "N";
			}
			
			if(budgetRowData.trFgCode == "1") {
				if(budgetRowData.vatFgCode == "1") {
					$('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]); 
					 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N"]);
				} else if(budgetRowData.vatFgCode == "2") {
					$('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","N","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]); 
					 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N","N"]);
				} else {
					$('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]); 
					 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N","N"]);
				}
			 } else if(budgetRowData.trFgCode == "2") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","Y","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]);
				  $('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "3") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]);
				  $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "4") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","N","N","Y","N","N","N","N","Y","N","Y","N","Y","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]);
				  $('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","Y","Y","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "5") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]); 
				  $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "6") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]); 
				  $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "7") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]); 
				  $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "8") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","Y","N","N","N","N","N","N","Y","N","Y","N","Y","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]); 
				  $('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "9") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","N","N","N","N","Y","N","N","Y","N","Y","N","N","Y","N","Y","Y",setFgCodeFlag,"Y","Y","N","N","N"]); 
				  $('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","N","N","Y","Y","N","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N","N"]);
			 }
		} else {
			if(budgetRowData.trFgCode == "1") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]); 
				 //$('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "2") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","Y","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 //$('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","Y","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "3") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 //$('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "4") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","N","N","Y","N","N","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 //$('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","Y","Y","N","N","N","N","Y","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","Y","Y","N","N","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "5") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","Y","N","N","N","N","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 //$('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","N","Y","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(budgetRowData.trFgCode == "6") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 //$('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","N","N","Y","Y","N","N","Y","N","Y","N","Y","N","N","N","N","N","N","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","N","N","Y","Y","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 }
		} 
		var param = {};
		param.erpBudgetSeq = budgetRowData.erpBudgetSeq;
		
		if(erpTypeCode == "iCUBE") {
			fnSelectBalanceBudget(param);	
		}
				
		
		$(".res_tradeRow").hide();
		$(".row-trade-" + budgetRowData.budgetSeq).show();
	}
	
	/*	[ 거래처정보 ] 채주유형에 따라 거래처 정보 테이블 변경
	----------------------------------------- */
	function fnChangeTradeColumn(data) {
		/*
		 * 채주유형에 코드값 정의(trFgCode)
		 * 1: 거래처, 2: 사원등록, 3: 거래처명, 4: 기타소득자, 5: 급여, 6: 사업소득자
		 */
		 
		 /* 결재수단에 따른 필수체크 플래그 */
		 var setFgCodeFlag = "N";
		 
		 if(data.data.setFgCode == "1") {
			 setFgCodeFlag = "Y";
		 } else {
			 setFgCodeFlag = "N";
		 }
		 
		 if(erpTypeCode == 'iCUBE') {
			 if(data.data.trFgCode == "1") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]); 
				 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "2") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","Y","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "3") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "4") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","N","N","Y","N","N","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","Y","Y","N","N","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "5") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","Y","N","N","N","N","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "6") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","N","N","Y","Y","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 }
		 } else {
			 if(data.data.trFgCode == "1") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]); 
				 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "2") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","Y","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "3") {
				 $('#tradeTable').extable('setDisplayChange', ["Y","N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["Y","Y","N","N","N","N","N","N","N","Y","N","Y","N","Y","N",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "4") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","N","N","Y","N","N","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","Y","Y","N","N","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "5") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","Y","N","N","N","N","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","Y","Y","N","N","N","N","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 } else if(data.data.trFgCode == "6") {
				 $('#tradeTable').extable('setDisplayChange', ["N","N","N","N","N","N","N","Y","Y","N","Y","N","Y","N","Y","Y","N","Y","Y","Y","Y","N","N","N","N"]);
				 $('#tradeTable').extable('setDisplayReqYN', ["N","N","N","N","N","N","Y","Y","N","N","Y","N","Y","N","Y",setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,setFgCodeFlag,"N","N","N","N","N","N"]);
			 }
		 }
		 
	}
	
	/*	[ 거래처정보 ] 금액 자동 계산
	----------------------------------------- */
	var etcIncomeData = '';
	function fnCalAmt(data) {
		var budgetTotalAmt = 0;
		var budgetStdAmt = 0;
		var budgetVatAmt = 0;
		var payAmt = 0;
		var realPayAmt = 0;
		var payTaxAmt = 0;
		var selectBudgetRow = table.selectRowData($(tbl.budget));
		var selectTradeRow = '';
		var trFgCode = selectBudgetRow.data.trFgCode;
		var vatFgCode = selectBudgetRow.data.vatFgCode;
		
		if(erpTypeCode == "iCUBE") {
			if(trFgCode == "1" || trFgCode == "3" || trFgCode == "2") {
				selectTradeRow = table.selectRowData($(tbl.trade));
				budgetTotalAmt = parseInt(data.data.tradeAmt.toString().replace(/\,/g,''));
				budgetStdAmt = parseInt(budgetTotalAmt / 11.0 * 10.0);
				budgetVatAmt = budgetTotalAmt - budgetStdAmt;
				
				$('#tradeTable').extable('setRowData', { tradeAmt: fnAddComma(budgetTotalAmt) }, 9, selectTradeRow.rowIndex);
				
				if(vatFgCode == "2") {
					$('#tradeTable').extable('setRowData', { tradeVatAmt: "0" }, 13, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setRowData', { tradeStdAmt: fnAddComma(budgetTotalAmt) }, 11, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
				} else if(vatFgCode == "1") {
					$('#tradeTable').extable('setRowData', { tradeVatAmt: fnAddComma(budgetVatAmt) }, 13, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setRowData', { tradeStdAmt: fnAddComma(budgetStdAmt) }, 11, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
				} else {
					if(selectBudgetRow.data.vatFgCode == "3") {
						budgetStdAmt = parseInt((data.data.tradeStdAmt || 0).toString().replace(/\,/g,''));
						budgetVatAmt = parseInt((data.data.tradeVatAmt || 0).toString().replace(/\,/g,''));
						budgetTotalAmt = budgetStdAmt + budgetVatAmt;
						$('#tradeTable').extable('setRowData', { tradeAmt: fnAddComma(budgetTotalAmt) }, 7, selectTradeRow.rowIndex);
						
					} else {
						$('#tradeTable').extable('setRowData', { tradeVatAmt: fnAddComma(budgetVatAmt) }, 13, selectTradeRow.rowIndex);
						$('#tradeTable').extable('setRowData', { tradeStdAmt: fnAddComma(budgetStdAmt) }, 11, selectTradeRow.rowIndex);
						$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
					}
				}
			} else if(trFgCode == "4") {
				$("#etcGubun").show();
				$("#modalDiv").show();
				etcIncomeData = data;
			} else if(trFgCode == "5") {
				selectTradeRow = table.selectRowData($(tbl.trade));
				payAmt = parseInt(data.data.payAmt.toString().replace(/\,/g,''));
				realPayAmt = parseInt(payAmt / 11.0 * 10.0);
				payTaxAmt = payAmt - realPayAmt;
				
				$('#tradeTable').extable('setRowData', { payAmt: fnAddComma(payAmt) }, 10, selectTradeRow.rowIndex);
				$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(realPayAmt) }, 12, selectTradeRow.rowIndex);
				$('#tradeTable').extable('setRowData', { payTaxAmt: fnAddComma(payTaxAmt) }, 14, selectTradeRow.rowIndex);
				
				$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
			} else if(trFgCode == "6") {
				var incomAmt = 0;	// 소득세
				var liveAmt = 0;	// 주민세	
				
				selectTradeRow = table.selectRowData($(tbl.trade));
				payAmt = parseInt(data.data.payAmt.toString().replace(/\,/g,''));
				incomAmt = parseInt(payAmt * 0.03);
				liveAmt = parseInt(incomAmt / 10);
				
				realPayAmt = payAmt - incomAmt - liveAmt;
				payTaxAmt = payAmt - realPayAmt;
				
				if(payAmt <= 33333 ) {
					$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(payAmt) }, 12, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setRowData', { payTaxAmt: '0' }, 14, selectTradeRow.rowIndex);
				} else {
					$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(realPayAmt) }, 12, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setRowData', { payTaxAmt: fnAddComma(payTaxAmt) }, 14, selectTradeRow.rowIndex);
				}
				
				$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
			} else if(trFgCode == "9") {	// 사업소득자 계산

				
				selectTradeRow = table.selectRowData($(tbl.trade));
				var intxAm = (parseInt(data.data.payAmt.toString().replace(/\,/g,''), 10) * 0.03);
				payAmt = data.data.payAmt.toString().replace(/\,/g,'');	// 지급총액
				
				if(intxAm < 1000) {
					$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(payAmt) }, 12, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setRowData', { payTaxAmt: '0' }, 14, selectTradeRow.rowIndex);
				} else {
					// 원천 징수액 (payTaxAmt) : 총금액 * 0.033 - 원단위 절삭 payAmt
					// 실수령액 (realPayAmt)    : 지급총액 - 원천 징수액
					// 지급 총액         : 사용자 입력 money					
					
					intxAm = parseInt(parseInt(intxAm)/10) * 10 ;
					var rstxAM = parseInt(parseInt(intxAm,10) * 0.1);
					payTaxAmt =intxAm + rstxAM;
					payTaxAmt = parseInt(payTaxAmt / 10) * 10;
					realPayAmt = parseInt(payAmt,10) - payTaxAmt;
					
					$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(realPayAmt) }, 12, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setRowData', { payTaxAmt: fnAddComma(payTaxAmt) }, 14, selectTradeRow.rowIndex);
				}
				
				$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
			}
		} else {
			if(trFgCode == "1" || trFgCode == "3" || trFgCode == "2") {
				selectTradeRow = table.selectRowData($(tbl.trade));
				budgetTotalAmt = parseInt(data.data.tradeAmt.toString().replace(/\,/g,''));
				budgetStdAmt = parseInt(budgetTotalAmt / 11.0 * 10.0);
				budgetVatAmt = budgetTotalAmt - budgetStdAmt;
				
				$('#tradeTable').extable('setRowData', { tradeAmt: fnAddComma(budgetTotalAmt) }, 9, selectTradeRow.rowIndex);
				$('#tradeTable').extable('setRowData', { tradeStdAmt: fnAddComma(budgetStdAmt) }, 11, selectTradeRow.rowIndex);
				$('#tradeTable').extable('setRowData', { tradeVatAmt: fnAddComma(budgetVatAmt) }, 13, selectTradeRow.rowIndex);
				
				$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
			} else if(trFgCode == "4") {
				$("#etcGubun").show();
				$("#modalDiv").show();
			} else if(trFgCode == "5") {
				selectTradeRow = table.selectRowData($(tbl.trade));
				payAmt = parseInt(data.data.payAmt.toString().replace(/\,/g,''));
				realPayAmt = parseInt(payAmt / 11.0 * 10.0);
				payTaxAmt = payAmt - realPayAmt;
				
				$('#tradeTable').extable('setRowData', { payAmt: fnAddComma(payAmt) }, 10, selectTradeRow.rowIndex);
				$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(realPayAmt) }, 12, selectTradeRow.rowIndex);
				$('#tradeTable').extable('setRowData', { payTaxAmt: fnAddComma(payTaxAmt) }, 14, selectTradeRow.rowIndex);
				
				$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
			} else if(trFgCode == "6") {
				var incomAmt = 0;	// 소득세
				var liveAmt = 0;	// 주민세	
				
				selectTradeRow = table.selectRowData($(tbl.trade));
				payAmt = parseInt(data.data.payAmt.toString().replace(/\,/g,''));
				incomAmt = parseInt(payAmt * 0.03);
				liveAmt = parseInt(incomAmt / 10);
				
				realPayAmt = payAmt - incomAmt - liveAmt;
				payTaxAmt = payAmt - realPayAmt;
				
				if(payAmt <= 33333 ) {
					$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(payAmt) }, 12, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setRowData', { payTaxAmt: '0' }, 14, selectTradeRow.rowIndex);
				} else {
					$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(realPayAmt) }, 12, selectTradeRow.rowIndex);
					$('#tradeTable').extable('setRowData', { payTaxAmt: fnAddComma(payTaxAmt) }, 14, selectTradeRow.rowIndex);
				}
				
				$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
			}
		}		
	}
	
	function fnEtcCalAmt() {
		$ ( '#etcGubun' ).hide ( );
		$ ( '#modalDiv' ).hide ( );

// 		var selectTradeRow = table.selectRowData($(tbl.trade));
// 		payAmt = parseInt(selectTradeRow.data.payAmt.toString().replace(/\,/g,''));
// 		realPayAmt = parseInt(payAmt / 11.0 * 10.0);
// 		payTaxAmt = payAmt - realPayAmt;
		
// 		$('#tradeTable').extable('setRowData', { payAmt: fnAddComma(payAmt) }, 10, selectTradeRow.rowIndex);
// 		$('#tradeTable').extable('setRowData', { realPayAmt: fnAddComma(realPayAmt) }, 12, selectTradeRow.rowIndex);
// 		$('#tradeTable').extable('setRowData', { payTaxAmt: fnAddComma(payTaxAmt) }, 14, selectTradeRow.rowIndex);
		
// 		$('#tradeTable').extable('setFocus', 15, selectTradeRow.rowIndex);
	}
	
	/*	[ 기타소득자 ] 소득구분 선택값
	----------------------------------------- */
	function fnSelectIncomePop() {
		etcIncomeData.keyCode = '113';
		console.log(etcIncomeData);
		fnCommonPop('income' , etcIncomeData);
	}
	
	/*	[결의서] 지난 결의서 가져오기 
	----------------------------------------- */
	function fnPopResLoad() {
		/* 팝업 호출 준비 */
		var url = "<c:url value='/expend/np/user/UserResLoadPop.do'/>";
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
		
		window.open('', "UserResLoadPop", "width=" + 900 + ", height=" + height + ", left=" + 150 + ", top=" + 150);
		USER_resLoadPop.target = "UserResLoadPop";
		USER_resLoadPop.method = "post";
		USER_resLoadPop.action = url;
		USER_resLoadPop.submit();
		USER_resLoadPop.target = "";
	}
	
	function fnCallbackResLoad(data) {
		console.log(data);
		var result = fnAjax ( {
			url: '/expend/np/user/NPUserResLoadList.do',
			async: false,
			data: function ( ) {
				return $.extend ( fnGetCommonAjaxParam ( ), {
					beforeConsDocSeq:data.consDocSeq,
					consDocSeq:consDocSeq
				} );
			}
		} );
		
		if( result != null || result == undefined ) {
			console.log("지난 품의서 ajax 결과");
			console.log(result);
			
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

				confferConsData = new Array();
				confferBudgetData = new Array();
//				confferTradeData = new Array();
				
				confferFlag = true;	
				
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
	
	/* 결의 내역 포커스  */
	function fnSetFocusRes() {
		
	}
	
	/* 예산내역 포커스 */
	function fnSetFocusBudget() {
		
	}
	
	/* 거래처내역 포커스 */
	function fnSetFocusTrade() {
		
	}
	
	
	/****************************************************************************************
								아래는 공통함수 영역 입니다.
	****************************************************************************************/
    /*	[품의서] 공통 합수
    ----------------------------------------- */
    /* ajax 호출 정의 */
    /*ajax 호출 반환읜 항상 { "result" : {"result" : {} } } 로 반환*/
    function fnAjax(param) {
        defaults = { url: '', async: false, data: {} };
        var param = $.extend(defaults, param);
        if (typeof param.data === 'function') { param.data = param.data(); }
        console.log("ajax 파람");
        console.log(param.data);
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
	
	/* [공통] 공통코드 팝업 콜백
	----------------------------------------- */
	function fnCommonPopCallback ( param ) {
		/* 선택 행 정보 저장(rowIndex 등) */
		var dummy = JSON.parse ( param.dummy );
		/* 선택된 테이블 데이터 저장 변수(budget, bizplan 등) */
		var rowData = table.rowData ( $ ( '#' + dummy.tblId ), dummy.rowIndex );
		console.log(param);
		if ( optionSet.conVo.erpTypeCode == "ERPiU" ) {
			switch ( param.code.toLowerCase() ) {
				case "budget":
					/* 예산단위 콜백 */
					rowData.erpBudgetName = param.NM_BUDGET
					rowData.erpBudgetSeq = param.CD_BUDGET
					break;
				case "bizplan":
					/* 사업계획 콜백 */
					rowData.erpBizplanName = param.NM_BIZPLAN
					rowData.erpBizplanSeq = param.CD_BIZPLAN
					break;
				case "bgacct":
					/* 예산계정 콜백 */
					rowData.erpBgacctName = param.NM_BGACCT
					rowData.erpBgacctSeq = param.CD_BGACCT
					break;
				case "fiacct":
					/* 회계계정 콜백 */
					rowData.fiacct = param.NM_ACCT
					rowData.fiacctCode = param.CD_ACCT
					break;
				case "tr":
					/* 거래처 콜백 */
					rowData.trName = param.LN_PARTNER;
					rowData.trSeq = param.CD_PARTNER;
					rowData.btrSeq = param.CD_BANK;
					
					if( param.NM_CEO !== undefined){
						rowData.ceoName = param.NM_CEO;
					}
					if( param.NM_BANK !== undefined){
						rowData.btrName = param.NM_BANK;
					}
					if( param.NM_DEPOSIT !== undefined){
						rowData.btrSeq = param.CD_BANK;
					}
					if( param.NO_DEPOSIT !== undefined){
						rowData.baNb = param.NO_DEPOSIT;
					}
					if( param.NM_DEPOSIT !== undefined){
						rowData.depositor = param.NM_DEPOSIT;
					}
					break;
				case "emp":
					rowData.empSeq = param.NO_EMP;
					rowData.empName = param.NM_KOR;
					break;
				case "bank":
					rowData.btrName = param.NM_SYSDEF;
					rowData.btrSeq = param.CD_SYSDEF;
					break;
				case "tretc":
					/* 기타소득자 콜백 */
					rowData.etcName = param.PER_NM;
					rowData.etcCode = param.PER_CD;
					
					if( param.NM_CEO !== undefined){
						rowData.ceoName = param.NM_CEO;
					}
					if( param.BANK_NM !== undefined){
						rowData.btrName = param.BANK_NM;
					}
					if( param.BANK_CD !== undefined){
						rowData.btrSeq = param.BANK_CD;
					}
					if( param.ACCT_NO !== undefined){
						rowData.baNb = param.ACCT_NO;
					}
					if( param.ACCT_NM !== undefined){
						rowData.depositor = param.ACCT_NM;
					}
					
					break;
				case "trbus":
					/* 사업소득자 콜백 */
					rowData.bizIncomName = param.PER_NM;
					rowData.bizIncomCode = param.PER_CD;
					
					if( param.NM_CEO !== undefined){
						rowData.ceoName = param.NM_CEO;
					}
					if( param.BANK_NM !== undefined){
						rowData.btrName = param.BANK_NM;
					}
					if( param.BANK_CD !== undefined){
						rowData.btrSeq = param.BANK_CD;
					}
					if( param.ACCT_NO !== undefined){
						rowData.baNb = param.ACCT_NO;
					}
					if( param.ACCT_NM !== undefined){
						rowData.depositor = param.ACCT_NM;
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
// 					rowData.baNb = (param.bankNumber || '');
// 					rowData.btrSeq = (param.trSeq || '');
// 					rowData.btrName = (param.atTrName || '');
						break;
				case "tr":
					rowData.trName = (param.trName || '');
					rowData.trSeq = (param.trSeq || '');
					rowData.ceoName = (param.ceoName || '');
					rowData.depositor = (param.depositor || '');
					rowData.btrName = (param.bankName || '');
					rowData.btrSeq = (param.giroSeq || '');
					rowData.baNb = (param.bankNumber || '');
					/* 거래처 콜백 */
// 					rowData.btrNumber = ( param.bankNumber || '' );
					break;
				case "budgetlist":
					/* 예산과목 콜백 */
					rowData.erpBudgetName = ( param.BGT_NM || '' );
					rowData.erpBudgetSeq = ( param.BGT_CD || '' );
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
				case "btrtr":
					/* 거래처 콜백 */
					rowData.btrNumber = ( param.bankNumber || '' );
					break;
				case "bank":
					/* 회계계정 파라미터 정의 */
					//alert(JSON.stringify(param));
					rowData.btrName = (param.BANK_NM || '');
					rowData.btrSeq = (param.BANK_CD || '');
					break;
				case "erphpmeticlist":
					/* 회계계정 파라미터 정의 */
					rowData.etcCode = (param.ACCT_NO || '');
					rowData.etcName = (param.ACCT_NM || '');
					rowData.etcGubun = (param.DATA_CD || '');
					break;
				case "income":
					var displayIncome = "";
					var CTD_CD = param.CTD_CD;
					var etcPercent = optionSet.erpAbsdocu.ndepRate * 100;
					
					displayIncome = "[ " + param.CTD_CD + " ] " + param.CTD_NMK;
					
					$("#etcPercent").attr("disabled", "disabled");
					
					if(param.CTD_CD > "70") {
						$("#etcPercent").val(etcPercent);
					} else if(CTD_CD == "62") {
						if( (!$('#etcPercent').val()) ){
							$("#etcPercent").removeAttr("disabled"); //.removeClass("input_gray");
							$("#etcPercent").val( ( etcPercent || '80' ) );
						}
					} else {
						etcPercent = "";
					}
					
					var percent = etcPercent;
					percent = percent.valueOf().toString();
					percent = parseInt(percent, 10) || 0;
					
					var UNIT_AM = rowData.payAmt.replace ( ',', '' );
					
					UNIT_AM = UNIT_AM.valueOf().toString();
					UNIT_AM = parseInt(UNIT_AM, 10) || 0;
					
					var NDEP_AM = "";
					if(percent > 0){
						NDEP_AM = percent / 100 * UNIT_AM;
						NDEP_AM = Math.floor(NDEP_AM);
					}

					var INAD_AM = UNIT_AM - NDEP_AM;
					
					// 상배 절삭
					$("#ndepAmt").val(NDEP_AM.toString()); /*필요경비금액*/
					$("#inadAmt").val(INAD_AM.toString()); /*필요경비금액*/
					
					
					var INTX_AM = "";
					var RSTX_AM = "";
					
					if(INAD_AM > optionSet.erpAbsdocu.mtaxAmt){
						if(!(CTD_CD == "68" || CTD_CD == "61" || CTD_CD == "")){
							if(CTD_CD == "40" || CTD_CD == "41"){
								INTX_AM = Math.round(INAD_AM * optionSet.erpAbsdocu.staRate * 0.1);
								RSTX_AM = Math.floor((INTX_AM * optionSet.erpAbsdocu.jtaRate)/10)*10;
							}else{
								INTX_AM = Math.floor((INAD_AM * optionSet.erpAbsdocu.staRate)/10)*10;
								RSTX_AM = Math.floor((INTX_AM * optionSet.erpAbsdocu.jtaRate)/10)*10;
							}
						}
					}

					$("#intxAmt").val(INTX_AM.toString()); /*필요경비금액*/
					$("#rstxAmt").val(RSTX_AM.toString()); /*필요경비금액*/
					
					$("#incomeInfo").val(displayIncome);
					break;
				case "erphincomeiclist":
					rowData.bizIncomCode = (param.PER_CD || '');
					rowData.bizIncomName = (param.PER_NM || '');
					rowData.btrName = (param.BANK_NM || '');
					rowData.btrSeq = (param.BANK_CD || '');
					rowData.depositor = (param.ACCT_NM || ''); 
					rowData.baNb = (param.ACCT_NO || ''); 
					break;
				case "emp":
					if(dummy.tblId == "resTable") {
						rowData.causeEmpSeq = (param.erpEmpSeq || '');
						rowData.causeEmpName = (param.korName || '');
					} else if(dummy.tblId == "tradeTable") {
						rowData.empSeq = (param.erpEmpSeq || '');
						rowData.empName = (param.korName || '');
					} 
					
					break;
				default:
					break;  
 			}
		}
	
		$ ( '#' + dummy.tblId ).extable ( 'setRowData', rowData, dummy.colIndex, dummy.rowIndex );
	}
	
	/*	[예산잔액 조회] 예산잔액 조회
	----------------------------------------- */
	function fnSelectBalanceBudget(budgetParam) {
		var selResData = table.selectRowData ( $ ( tbl.res ) );
		var selBudgetData = table.selectRowData ( $ ( tbl.budget ) );
		
		console.log("추후에 erpButtomSeq 추가 필요");
		var result = fnAjax ( {
			url: '/ex/np/user/cons/budgetInfoSelect.do',
			async: false,
			data: {
				erpDivSeq: optionSet.erpEmpInfo.erpDivSeq,
				erpMgtSeq: selResData.data.projectSeq,
				erpCompSeq: optionSet.erpEmpInfo.erpCompSeq,
				erpBudgetSeq: budgetParam.erpBudgetSeq,
				gisu: optionSet.erpGisu.gisu,
				erpButtomSeq: '',	
				erpGisuDate: selResData.data.resDateG20,
				resDocSeq: selResData.data.resDocSeq
			}
		} );

		if ( result != null || result == undefined ) {
			console.log(result);
			$("#openAmt").text(fnAddComma(result.aData.openAmt));
			$("#applyAmt").text(fnAddComma(result.aData.applyAmt));
			$("#tryAmt").text(fnAddComma(result.aData.tryAmt));
			$("#balanceAmt").text(fnAddComma(result.aData.balanceAmt));
			return;
			/* 예산 테이블에 정보 저장 */
			$ ( tbl.budget ).extable ( 'setRowData', {
				erpOpenAmt : (result.aData.openAmt  || '0'),
				erpApplyAmt : (result.aData.applyAmt || '0'),
				erpLeftAmt : (result.aData.balanceAmt || '0')
			}, idxZero, selBudgetData.rowIndex );
		}else{
			alert ( "예산잔액 조회중에 오류가 발생했습니다." );
			return;
		}
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
	
	/* [버튼] 결재작성 이벤트
	----------------------------------------- */
	function fnApprovalopen ( ) {
		/* 결의서 필수체크 확인 로직 */
		var paramCheck = false;
		
		var resRowData = table.selectRowData ( $ ( tbl.res ) );
		var budgetRowData = table.selectRowData ( $ ( tbl.budget ) );
		var tradeRowData = table.selectRowData ( $ ( tbl.trade ) );
		
		if(resDocSeq == "") {
			resDocSeq = resRowData.data.resDocSeq;
		}
		
		/* 결의정보 내역 확인 */
		if(resRowData.data != null) {
			if(!table.check ( $ ( tbl.res ) ).pass) {
				var resDataCheck = table.check ( $ ( tbl.res ) );
				
				if(resDataCheck.count == resDataCheck.notInputCount) {
					var index = resRowData.rowIndex;
					
					table.removeRow($(tbl.budget), budgetRowData.rowIndex);
					
					if(erpTypeCode == "iCUBE") {
						$('#resTable').extable('setFocus', 7, (index-1));	
					} else {
						$('#resTable').extable('setFocus', 4, (index-1));
					}
				} else {
					fnParamCheck ( tbl.res.replace ( '#', '' ) );
					return;
				}
			} else {
				if(resRowData.data.resSeq == "") {
					fnSaveOrUpdateRes(rowTradeData, 'enter');
				}
			}
		} else {
			alert("결의정보내역을 확인해주세요");
			return;
		}
		
		/* 예산정보 내역 확인 */
		if(budgetRowData.data != null) {
			if(!table.check ( $ ( tbl.budget ) ).pass) {
				var budgetDataCheck = table.check ( $ ( tbl.budget ) );
				
				if(budgetDataCheck.count == budgetDataCheck.notInputCount) {
					var index = budgetRowData.rowIndex;
					
					table.removeRow($(tbl.budget), budgetRowData.rowIndex);
					
					if(erpTypeCode == "iCUBE") {
						$('#budgetTable').extable('setFocus', 11, (index-1));	
					} else {
						$('#budgetTable').extable('setFocus', 13, (index-1));
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
		
		/* 거래처정보 내역 확인 */
		if(tradeRowData.data != null) {
			if(!table.check ( $ ( tbl.trade ) ).pass) {
				var tradeDataCheck = table.check ( $ ( tbl.trade ) );
				
				if(tradeDataCheck.count == tradeDataCheck.notInputCount) {
					var index = tradeRowData.rowIndex;
					
					table.removeRow($(tbl.trade), tradeRowData.rowIndex);
					
					if(erpTypeCode == "iCUBE") {
						$('#tradeTable').extable('setFocus', 22, (index-1));	
					} else {
						$('#tradeTable').extable('setFocus', 21, (index-1));
					}
				} else {
					fnParamCheck ( tbl.trade.replace ( '#', '' ) );
					return;
				}
			} else {
				if(tradeRowData.data.tradeSeq == "") {
					fnSaveOrUpdateTrade(rowTradeData, 'enter');
				}
			}
		} else {
			alert("거래처정보내역을 확인해주세요");
			return;
		}
		
		var result = fnAjax ( {
			url: '/ex/np/user/cons/interlock/ExDocMake.do',
			async: false,
			data: {
				processId: optionSet.formInfo.formDTp,
				approKey: optionSet.formInfo.formDTp + '_NP_' + resDocSeq,
				resDocSeq: resDocSeq,
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
				eapCallDomaim: ( origin || '' )
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
	
	/* [카드내역] 카드내역 가져오기 이벤트
	----------------------------------------- */
	function fnAddCardHistory(){
		var budgetRowData = table.selectRowData ( $ ( tbl.budget ) ); // 현재 선택 되어 있는 품의정보 데이터 조회
		if( budgetRowData.data !== undefined){
			var winHeight = document.body.clientHeight; // 현재창의 높이
			var winWidth = document.body.clientWidth; // 현재창의 너비
			var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
			var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표 
	
			var popX = winX + (winWidth - 908)/2;
			var popY = winY + (winHeight - 500)/2;
			
			var url = '<c:url value="/expend/np/user/CardUseHistoryPop.do" />';
			url += '?resDocSeq=' + budgetRowData.data.resDocSeq;
			url += '&resSeq=' + budgetRowData.data.resSeq;
			url += '&budgetSeq=' + budgetRowData.data.budgetSeq;
			url += '&callbackName=fnAddInterfaceHistoryCallback';
			var pop = window.open(url, "카드 사용내역", "width=960, height=550, left=" + popX + ", top=" + popY);
		}else{
			alert("예산내역 추가 후 사용하십시오.");
		}
	}
	
	/* [카드내역] 카드내역 가져오기 콜백 이벤트
	----------------------------------------- */
	function fnAddInterfaceHistoryCallback(data){
		console.log("카드내역 data : " + data);
		var budgetRowData = table.selectRowData ( $ ( tbl.budget ) ); // 현재 선택 되어 있는 품의정보 데이터 조회
		for(var i = 0 ; i < data.length; i++){
			var index = 0;
			
			var insertParam ={};
			
			if(budgetRowData.data.trFgCode == "1" || budgetRowData.data.trFgCode == "3") {
				index = 0;
			} else if(budgetRowData.data.trFgCode == "2" || budgetRowData.data.trFgCode == "5") {
				index = 3;
			} else if(budgetRowData.data.trFgCode == "4") {
				index = 5;
			} else if(budgetRowData.data.trFgCode == "6") {
				index = 7;
			} 
// 			table.addRow ( $ ( tbl.trade ), data[i] );
			$ ( tbl.trade ).extable ( 'setAddRow', data[i] );
			var tradeLength = table.allData( $('#tradeTable')).length;
			table.focus ( $ ( tbl.trade ), index, tradeLength - 1 );
			
			
			insertParam.trName = data[i].trName;
			insertParam.trSeq = data[i].trSeq;
			insertParam.empSeq = data[i].empSeq;
			insertParam.empName = data[i].empName;
			insertParam.etcCode = data[i].etcCode;
			insertParam.etcName = data[i].etcName;
			insertParam.bizIncomCode = data[i].bizIncomCode;
			insertParam.bizIncomName = data[i].bizIncomName;
			insertParam.ceoName = data[i].ceoName;
			insertParam.btrName = data[i].btrName;
			insertParam.btrSeq = data[i].btrSeq;
			insertParam.baNb = data[i].baNb;
			insertParam.depositor = data[i].depositor;
			insertParam.tradeNote = data[i].tradeNote; // 
			insertParam.regDate = data[i].regDate.replace(/\-/g,'');
			insertParam.resDocSeq = data[i].resDocSeq; //
			insertParam.resSeq = data[i].resSeq; //
			insertParam.budgetSeq = data[i].budgetSeq; // 예산단위 이름
			insertParam.tradeSeq = data[i].tradeSeq;
			insertParam.interfaceType = data[i].interfaceType;
			insertParam.interfaceSeq = data[i].interfaceSeq;

			insertParam.tradeAmt = data[i].tradeAmt.replace(/\,/g,'');
			insertParam.tradeStdAmt = data[i].tradeStdAmt.replace(/\,/g,'');
			insertParam.tradeVatAmt = data[i].tradeVatAmt.replace(/\,/g,'');
			var result = fnAjax ( {
				url: '/ex/np/user/res/ResTradeInsert.do',
				async: false,
				data: insertParam
			} );

			if ( result != null ) {
				if ( result.resultCode == SUCCESS ) {
					var tradeAmt = result.aData.tradeAmt;
					tradeSeq = result.aData.tradeSeq;
					$ ( tbl.trade ).extable ( 'setRowData', {
						resSeq: resSeq,
						resDocSeq: resDocSeq,
						budgetSeq: budgetSeq,
						tradeSeq: tradeSeq
					}, idxZero, ( tradeLength - 1 ) );

					/* 품의정보 금액 추가 */
					var resAmtRow = table.selectRowData ( $ ( tbl.res ) ).rowIndex;
					var budgetAmtRow = table.selectRowData ( $ ( tbl.budget ) ).rowIndex;
		            var budgetAmt = result.aData.budgetAmt;
					var amt = result.aData.tradeAmt;
		            
					$(tbl.res).extable('setRowData', { resAmt: fnAddComma(amt) }, 5, resAmtRow);
		            $(tbl.budget).extable('setRowData', { budgetAmt: fnAddComma(budgetAmt) }, 14, budgetAmtRow);
					
		            /* 과세유형,채주구분 disabled처리 */
		            $('#budgetTable').extable('setRowDisable', 8, budgetAmtRow, 'disabled');
		            $('#budgetTable').extable('setRowDisable', 10, budgetAmtRow, 'disabled');
		            
				} else {
					console.log(result.resultName);
				}
			}
		}
	}
	
	/* [세금계산서] 세금계산서 가져오기 이벤트
	----------------------------------------- */
	function fnAddETaxHistory(){
		var budgetRowData = table.selectRowData ( $ ( tbl.budget ) ); // 현재 선택 되어 있는 품의정보 데이터 조회
		if( budgetRowData.data !== undefined){
			var winHeight = document.body.clientHeight; // 현재창의 높이
			var winWidth = document.body.clientWidth; // 현재창의 너비
			var winX = window.screenX || window.screenLeft || 0;// 현재창의 x좌표
			var winY = window.screenY || window.screenTop || 0; // 현재창의 y좌표 
	
			var popX = winX + (winWidth - 908)/2;
			var popY = winY + (winHeight - 500)/2;
			
			var url = '<c:url value="/expend/np/user/ETaxUseHistoryPop.do" />';
			url += '?resDocSeq=' + budgetRowData.data.resDocSeq;
			url += '&resSeq=' + budgetRowData.data.resSeq;
			url += '&budgetSeq=' + budgetRowData.data.budgetSeq;
			url += '&callbackName=fnAddInterfaceHistoryCallback';
			var pop = window.open(url, "세금계산서 내역", "width=960, height=550, left=" + popX + ", top=" + popY);
		}else{
			alert("예산내역 추가 후 사용하십시오.");
		}
	}
	
    /*	[결의서] 옵션 함수
    ----------------------------------------- */
    function fnGetGwOptions(optionDiv, optionsCode, defaults) { 
    	try{
    		return (optionSet.gw[optionDiv][optionsCode].setValue || (defaults || ''));
    	}catch(e){
    		return defaults;
    	} 
   	}
    
    /*	[결의서] 예산 정보 초기화
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
		<h1 id="lbl_consTitle">${CL.ex_resDocWrite}  <!--결의서작성--> </h1>
		<div class="psh_btnbox">
			<!-- 양식팝업 오른쪽 버튼그룹 -->
			<div class="psh_right">
				<div class="btn_cen mt8">
				<!--  	<input id="btnRefferCons" type="button" class="psh_btn" value="참조품의" /> -->
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
				<p class="tit_p fl mt5 mb0">${CL.ex_resInfo}  <!--결의정보--> <span class="text_red fwn ml10"  id="resHelp"></span> </p>	
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
<!-- 					<button id="btnResLoad">결의서 불러오기</button>  -->
					<button id="btnRefferCons">${CL.ex_consDocReffer}<!--품의서참조--></button>
					<button id="btnRefresh">${CL.ex_reWrite}  <!--다시쓰기--></button>
					<button id="btnAddRes">${CL.ex_add}  <!--추가--></button>
					<button id="btnDelRes">${CL.ex_remove}  <!--삭제--></button>
				</div>
			</div>
		</div>
		<div id="resTable">
		</div><!--//table1 -->
		
		<div style="height:20px;"></div>
		
		<div class="btn_div mt0">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">${CL.ex_detailBudget}  <!--예산내역--> <span class="text_red fwn ml10"  id="budgetHelp"></span> </p>	
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnAddBudget">${CL.ex_add}  <!--추가--></button>
					<button id="btnDelBudget">${CL.ex_remove}  <!--삭제--></button>
				</div>
			</div>
		</div>
		
		<div id="budgetTable">
		</div><!--//table2 -->

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

		<div class="trade" style="height:20px;"></div>
		
		<div class="btn_div mt0 trade" style="">
			<div class="left_div">
				<p class="tit_p fl mt5 mb0">${CL.ex_venderInfo}  <!--거래처정보-->  <span class="text_red fwn ml10" id="tradeHelp"></span></p>	
			</div>
			<div class="right_div">
				<div class="controll_btn p0 fr ml10">
					<button id="btnAddCardHistory">${CL.ex_cardListTrans2}  <!--카드내역 가져오기--></button>
				<!--  	<button id="btnAddETaxHistory">세금계산서가져오기</button>  -->
					<button id="btnAddTrade">${CL.ex_add}  <!--추가--></button>
					<button id="btnDelTrade">${CL.ex_remove}  <!--삭제--></button>
				</div>
			</div>
		</div>
			
		<div class="trade" id="tradeTable" style="">
		</div>
		
	</div><!-- //pop_con -->

</div>

<div class="pop_wrap_dir" style="width:498px;" id="etcGubun" style="display:none;"> 
	<div class="pop_con">	
		<div class="com_ta">
			<table>
				<colgroup>
					<col width="15%"/>
					<col width="22%"/>
					<col width="63%"/>
				</colgroup>
				
				<tr>
					<th colspan="2">${CL.ex_classifyIncome}  <!--소득구분--></th>
					<td><input type="text" autocomplete="off" id="incomeInfo" style="width:95%" value=""/></td>
					<td><input type="button" id="incomeGubun" value="${CL.ex_select}"/></td>  <!--선택-->
				</tr>
				<tr>
					<th colspan="2">${CL.ex_necessaryExpensesLate}  <!--필요경비율--></th>
					<td><input type="text" autocomplete="off" id="etcPercent" style="width:30%" value="" disabled="disabled"/>&nbsp;%</td>
				</tr>
				<tr>
					<th colspan="2">${CL.ex_necessaryExpensesAmt}  <!--필요경비금액--></th>
					<td><input type="text" autocomplete="off" id="ndepAmt" style="width:85%" value=""/>&nbsp;${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th colspan="2">${CL.ex_incomeAmt}  <!--소득금액--></th>
					<td><input type="text" autocomplete="off" id="inadAmt" style="width:85%" value="" disabled="disabled"/>&nbsp;${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th colspan="2">${CL.ex_incomeTaxAmt}  <!--소득세액--></th>
					<td><input type="text" autocomplete="off" id="intxAmt" style="width:85%" value=""/>&nbsp;${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th colspan="2">${CL.ex_residentTaxAmt}  <!--주민세액--></th>
					<td><input type="text" autocomplete="off" id="rstxAmt" style="width:85%" value=""/>&nbsp;${CL.ex_won}  <!--원--></td>
				</tr>
				<tr>
					<th colspan="2">${CL.ex_reversionDate}  <!--귀속년월--></th>
					<td>
						<input type="text" autocomplete="off" id="etcrvrsYMYYYYY" style="width:30%" value=""/>&nbsp;년
						<input type="text" autocomplete="off" id="etcrvrsYMMMM" style="width:15%" value=""/>&nbsp;${CL.ex_month}  <!--월-->
					</td>
				</tr>
				
			</table>
		</div>
	</div><!-- //pop_con -->

	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" id="okButton" value="${CL.ex_check}" />  <!--확인-->
			<input type="button" id="cancelButton" class="gray_btn" value="${CL.ex_cancel}" />  <!--취소-->
		</div>
	</div><!-- //pop_foot -->
</div><!-- //pop_wrap -->
<div class="modal" id="modalDiv" style="display:none;"></div>

<form id="USER_resLoadPop" name="frmPop" method="post">
</form>	

<form id="USER_confferPop" name="frmPop" method="post">
</form>	