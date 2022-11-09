/* 지출결의 헤더컬럼 모음(display show) */
var dA1 = ['resoldate','partnergbn','partner','partnernm','bank','bankaccount','accholder','recip','taxapprno','supperson','supbizno','bigo','resolamt','taxamt','supplyamt'];
var dA2 = ['resoldate','partnergbn','partner','partnernm','entrant','bank','bankaccount','accholder','bigo','resolamt','taxamt','supplyamt'];
var dA3 = ['resoldate','partnergbn','partner','partnernm','bank','bankaccount','accholder','recip','taxapprno','supperson','supbizno','bigo','resolamt','taxamt','supplyamt'];
var dA4 = ['resoldate','partnergbn','partner','partnernm','bank','bankaccount','accholder','taxapprno','supperson','supbizno','bigo','consiorg','bizno','resolamt','taxamt','supplyamt'];
var dA5 = ['resoldate','partnergbn','partner','partnernm','entrant','bank','bankaccount','accholder','bigo','resolamt','taxamt','supplyamt'];
var dA6 = ['resoldate','partnergbn','partner','partnernm','belong','nm','bank','bankaccount','accholder','recip','bigo','resolamt','taxamt','supplyamt'];
var dA7 = ['resoldate','partnergbn','partner','partnernm','bank','bankaccount','accholder','recip','consiorg','resolamt','taxamt','supplyamt'];
var dA8 = ['resoldate','partnergbn','partner','partnernm','bank','bankaccount','accholder','meetstd','meetetd','meetplace','bigo','resolamt','taxamt','supplyamt'];
var dA9 = ['resoldate','partnergbn','partner','partnernm','bank','bankaccount','accholder','recip','bigo','resolamt','taxamt','supplyamt'];
var dA10 = ['resoldate','partnergbn','partner','partnernm','researcher','posi','belong','bank','bankaccount','accholder','rate','recipdate','recip','paybaseamt','bigo','resolamt','taxamt','supplyamt'];
var dA11 = ['resoldate','partnergbn','partner','partnernm','researcher','belong','bank','bankaccount','accholder','rate','recipdate','recip','bigo','resolamt','taxamt','supplyamt','realamt','lawamt'];

var dB1 = ['resoldate','partnergbn','partner','cardnum','aprovNum','serialNum','trdate','posi','recip','paybaseamt','taxapprno','supperson','supbizno','bigo','resolamt','taxamt','supplyamt'];
var dB2 = ['resoldate','partnergbn','partner','cardnum','aprovNum','serialNum','trdate','posi','entrant','paybaseamt','bigo','resolamt','taxamt','supplyamt'];
var dB3 = ['resoldate','partnergbn','partner','cardnum','aprovNum','serialNum','trdate','posi','recip','paybaseamt','taxapprno','supperson','supbizno','bigo','resolamt','taxamt','supplyamt'];
var dB4 = ['resoldate','partnergbn','partner','cardnum','aprovNum','serialNum','trdate','posi','recip','paybaseamt','taxapprno','supperson','supbizno','bigo','consiorg','bizno','resolamt','taxamt','supplyamt'];
var dB5 = ['resoldate','partnergbn','partner','cardnum','aprovNum','serialNum','trdate','posi','entrant','recip','paybaseamt','bigo','resolamt','taxamt','supplyamt'];
var dB6 = ['resoldate','partnergbn','partner','cardnum','aprovNum','serialNum','trdate','posi','recip','paybaseamt','bigo','resolamt','taxamt','supplyamt'];
var dB7 = ['resoldate','partnergbn','partner','cardnum','aprovNum','serialNum','trdate','posi','belong','nm','recip','paybaseamt','bigo','resolamt','taxamt','supplyamt'];
var dB8 = ['resoldate','partnergbn','partner','cardnum','aprovNum','serialNum','trdate','posi','paybaseamt','meetstd','meetetd','meetplace','bigo','resolamt','taxamt','supplyamt'];

var iC1 = ['item','standard','amount','unitprice','itemsupplyamt','itemtaxamt','itemtaxamt','itemtotalamt','itemgbn','ntisregdt','ntisregno'];
var iC2 = ['entrant','purposebiztrip','biztripstdt','biztripendt','biztripsttime','biztripentime','stplace','enplace','inoutgbn','peopleregno'];
var iC3 = ['item','standard','amount','unitprice','itemsupplyamt','itemtaxamt','itemtaxamt','itemtotalamt','itemgbn'];
var iC4 = ['item','standard','amount','unitprice','itemsupplyamt','itemtaxamt','itemtaxamt','itemtotalamt'];
var iC5 = ['item','standard','amount','unitprice','itemsupplyamt','itemtaxamt','itemtaxamt','itemtotalamt'];
var iC6 = ['entrant','purposebiztrip','biztripstdt','biztripendt','biztripsttime','biztripentime','stplace','enplace','inoutgbn','peopleregno'];
var iC7 = ['specialist','useplace','usestdt','useendt','usesttime','useentime','usemethod','amt'];       
var iC8 = ['peopleregno','educator','eduorgnm','edustdt','eduendt','edusttime','eduentime'];
var iC9 = ['belonggbn','peopleregno','belongbizno','entnm'];
var iC10 = ['peopleregno','overtimeworker','overworkstdt','overworkendt','overworksttime','overworkentime'];

//세목코드 모음
var EZSMCODE0001 = [ 'KR310100', 'KR410100', 'KR620100', 'KR072010','KR072030' ]; // 내부인건비
var EZSMCODE0002 = [ 'KR310200', 'KR410200', 'KR620200', 'KR072020' ]; // 외부인건비
var EZSMCODE0003 = [ 'KR510200', 'KR620300'];// 학생인건비
var EZSMCODE0004 = [ 'KR000201', 'KR000202', 'KR010201', 'KR010202', 'KR320100', 'KR420100', 'KR510300', 'KR620400', 'KR072040' ]; // 연구장비 재료비
var EZSMCODE0005 = [ 'KR000203', 'KR420200', 'KR510400', 'KR620500', 'KR072050' ];// 연구활동비
var EZSMCODE0006 = [ 'KR510500', 'KR620600', 'KR072060' ];// 연구과제 추진비
var EZSMCODE0007 = [ 'KR000204', 'KR010204', 'KR072070', 'KR320300', 'KR420300', 'KR510600', 'KR620700' ];// 연구수당
var EZSMCODE0008 = [ 'KR000300', 'KR010300', 'KR072080', 'KR330000', 'KR430000', 'KR510700', 'KR620800' ];// 위탁연구개발비


//화면분기 체주유형 구하기 : 리턴값 존재(타입구분)
function fnGetDisplayTblHeader(pEXECMTD,pBMCODE,pEXECDIV) {
	
	if(pEXECMTD === ''  || pBMCODE === '' || pEXECDIV === ''){
		return '';
	}
	
	var EXECMETHOD = pEXECMTD; // 집행방법
	var DETAILS = pBMCODE; // 세목
	var USE = pEXECDIV; // 사용용도
	var Gubun = 0;

	if (EXECMETHOD == 'CC' || EXECMETHOD == 'CS' || EXECMETHOD == 'GR' || EXECMETHOD == 'PC' || EXECMETHOD == 'TH' || EXECMETHOD == 'TR') {
		Gubun = 1;
	} else if (EXECMETHOD == 'CD') {
		Gubun = 2;
	}
	
	if (EZSMCODE0004.indexOf(DETAILS) != -1) {// 연구장비.재료비
		if (USE == "ML101")// 기기 장비와부수기자재구입비
		{
			if (Gubun == 1) {
				return 'A1_C1';
			} else if (Gubun == 2) {
				return 'B1_C1';
			} else {
				return '';
			}
		} else if (USE == "ML102")// 시약 및 재료구입비
		{
			if (Gubun == 1) {
				return 'A3_C3';
			} else if (Gubun == 2) {
				return 'B3_C3';
			} else {
				return '';
			}
		} else if (USE == "ML103")// 시제품.시작품.시험설비 제작경비
		{
			if (Gubun == 1) {
				return 'A3_C4';
			} else if (Gubun == 2) {
				return 'B3_C4';
			} else {
				return '';
			}
		}
	} else if (EZSMCODE0005.indexOf(DETAILS) != -1)// 연구활동비
	{
		if (USE == "AT101") // 국외출장여비
		{
			if (Gubun == 1) {
				return 'A5_C6';
			} else if (Gubun == 2) {
				return 'B5_C6';
			} else {
				return '';
			}
		} else if (USE == "AT102")// 시험분석료
		{
			if (Gubun == 1) {
				return 'A3_C4';
			} else if (Gubun == 2) {
				return 'B3_C4';
			} else {
				return '';
			}
		} else if (USE == "AT103")// 인쇄,복사,인화,슬라이드제작경비
		{
			if (Gubun == 1) {
				return 'A3_C4';
			} else if (Gubun == 2) {
				return 'B3_C4';
			} else {
				return '';
			}
		} else if (USE == "AT104")// 공공요금,제세공과금 및 수수료
		{
			if (Gubun == 1) {
				return 'A9';
			} else if (Gubun == 2) {
				return 'B6';
			} else {
				return '';
			}
		} else if (USE == "AT105")// 전무가활용비, 원고료, 통역료
		{
			if (Gubun == 1) {
				return 'A6_C7';
			} else if (Gubun == 2) {
				return 'B6_C7';
			} else {
				return '';
			}
		} else if (USE == "AT106")// 논문게재료 및 논문심사비
		{
			if (Gubun == 1) {
				return 'A9';
			} else if (Gubun == 2) {
				return 'B6';
			} else {
				return '';
			}
		} else if (USE == "AT107")// 교육훈련비(학회, 세미나 참석 포함)
		{
			if (Gubun == 1) {
				return 'A7_C8';
			} else if (Gubun == 2) {
				return 'B7_C8';
			} else {
				return '';
			}
		} else if (USE == "AT108")// 문헌구입비
		{
			if (Gubun == 1) {
				return 'A3_C4';
			} else if (Gubun == 2) {
				return 'B3_C4';
			} else {
				return '';
			}
		}

	} else if (EZSMCODE0006.indexOf(DETAILS) != -1)// 연구과제추진비
	{
		if (USE == "PH101") // 국내 출장여비
		{
			if (Gubun == 1) {
				return 'A2_C2';
			} else if (Gubun == 2) {
				return 'B2_C2';
			} else {
				return '';
			}
		} else if (USE == "PH102")// 사무용품비
		{
			if (Gubun == 1) {
				return 'A3_C3';
			} else if (Gubun == 2) {
				return 'B3_C3';
			} else {
				return '';
			}
		} else if (USE == "PH103")// 회의비
		{
			if (Gubun == 1) {
				return 'A8_C9';
			} else if (Gubun == 2) {
				return 'B8_C9';
			} else {
				return '';
			}
		} else if (USE == "PH104")// 야근 및 특근식대
		{
			if (Gubun == 1) {
				return 'A9_C10';
			} else if (Gubun == 2) {
				return 'B6_C10';
			} else {
				return '';
			}
		} else if (USE == "PH105")// 연구환경유지비
		{ 
			if (Gubun == 1) {
				return 'A3_C3';
			} else if (Gubun == 2) {
				return 'B3_C3';
			} else {
				return '';
			}
		}
	} 
	else if (EZSMCODE0008.indexOf(DETAILS) != -1)// 위탁연구개발비
	{
		if (USE == "CN101") {
			if (Gubun == 1) {
				return 'A4_C5';
			} else if (Gubun == 2) {
				return 'B4_C5';
			} else {
				return '';
			}
		}
	} 
	else if (EZSMCODE0001.indexOf(DETAILS) != -1)// 내부인건비
	{
		if (USE == "LP101" || USE == 'PE201') { 
			if (Gubun == 1) {
				return 'A10';
			} else if (Gubun == 2) {
				return '';
			} else {
				return '';
			}
		}
	} 
	else if (EZSMCODE0002.indexOf(DETAILS) != -1)// 외부인건비
	{
		if (USE == "OP101") { 
			if (Gubun == 1) {
				return 'A10';
			} else if (Gubun == 2) {
				return '';
			} else {
				return '';
			}
		}
	} 
//	else if (EZSMCODE0002.indexOf(DETAILS) != -1)// 학생인건비
//	{
//		if (USE == "PE201") { 
//			if (Gubun == 1) {
//				return 'A10';
//			} else if (Gubun == 2) {
//				return '';
//			} else {
//				return '';
//			}
//		}
//	} 
	else if (EZSMCODE0007.indexOf(DETAILS) != -1)// 연구수당
	{
		if (USE == "AL101") { 
			if (Gubun == 1) {
				return 'A11';
			} else if (Gubun == 2) {
				return '';
			} else {
				return '';
			}
		}
	} 
	else {
		return '';
	}
}

//체주 유형에 따른 화면 분기 수행
function fnSetDisplayTblHeader(cheju){
	if(cheju == undefined){
		return false;
	}
		
	var arrCheju = cheju.split('_');
	var dCheju = '';
	var iCheju = '';
	
	switch(arrCheju[0]|| ''){
		case 'A1':
			dCheju = dA1;
			break;
		case 'A2':
			dCheju = dA2;
			break;
		case 'A3':
			dCheju = dA3;
			break;
		case 'A4':
			dCheju = dA4;
			break;
		case 'A5':
			dCheju = dA5;
			break;
		case 'A6':
			dCheju = dA6;
			break;
		case 'A7':
			dCheju = dA7;
			break;
		case 'A8':
			dCheju = dA8;
			break;
		case 'A9':
			dCheju = dA9;
			break;
		case 'A10':
			dCheju = dA10;
			break;
		case 'A11':
			dCheju = dA11;
			break;
		case 'B1':
			dCheju = dB1;
			break;
		case 'B2':
			dCheju = dB2;
			break;
		case 'B3':
			dCheju = dB3;
			break;
		case 'B4':
			dCheju = dB4;
			break;
		case 'B5':
			dCheju = dB5;
			break;
		case 'B6':
			dCheju = dB6;
			break;
		case 'B7':
			dCheju = dB7;
			break;
		case 'B8':
			dCheju = dB8;
			break;
	}
	
	switch(arrCheju[1] || ''){
		case 'C1':
			iCheju = iC1;
			break;
		case 'C2':
			iCheju = iC2;
			break;
		case 'C3':
			iCheju = iC3;
			break;
		case 'C4':
			iCheju = iC4;
			break;
		case 'C5':
			iCheju = iC5;
			break;
		case 'C6':
			iCheju = iC6;
			break;
		case 'C7':
			iCheju = iC7;
			break;
		case 'C8':
			iCheju = iC8;
			break;
		case 'C9':
			iCheju = iC9;
			break;
		case 'C10':
			iCheju = iC10;
			break;
	
	}
	
	if(dCheju.length > 0){
		/* 걸러내기 */
		//$.each(DETAIL_JSON, function(index, item){
		$.each(focusJsonList['detailContent'], function(index, item){
			if(dCheju.indexOf(item.id) == -1){
				var groupTH = $("#detailContent_TH").find('TH');
				var singleTH = $(groupTH).filter(":contains('"+item.titleName+"')");
				$(singleTH).css('display','none');
				item.displayClass = 'loseSight';				
				item.tail = 'N';
			}
			else{
				if(dCheju[Number(dCheju.length-1)] == item.id && iCheju.length > 0){
					item.tail = 'Y';
				}else{
					item.tail = 'N';
				}
				var groupTH = $("#detailContent_TH").find('TH');
				var singleTH = $(groupTH).filter(":contains('"+item.titleName+"')");
				$(singleTH).css('display','');
				item.displayClass = '';
			}
		});
	}
	if(iCheju.length > 0){
		$.each(focusJsonList['itemDetailContent'], function(index, item){
			if(iCheju.indexOf(item.id) == -1){
				//$("#detailContent_TH").find("TH:contains('"+ item.titleName+"')").parent().css('display','none');
				var groupTH = $("#itemDetailContent_RIGHT_TH").find('TH');
				var singleTH = $(groupTH).filter(":contains('"+item.titleName+"')");
				$(singleTH).css('display','none');
				item.displayClass = 'loseSight';
				item.tail = 'N';
			}
			else{
				//$("#detailContent_TH").find("TH:contains('"+ item.titleName+"')").parent().css('display','');
				if(iCheju[Number(iCheju.length-1)] == item.id){
					item.tail = 'Y';
				}else{
					item.tail = 'N';
				}
				var groupTH = $("#itemDetailContent_RIGHT_TH").find('TH');
				var singleTH = $(groupTH).filter(":contains('"+item.titleName+"')");
				$(singleTH).css('display','');
				item.displayClass = '';
			}
		});
	}
}
