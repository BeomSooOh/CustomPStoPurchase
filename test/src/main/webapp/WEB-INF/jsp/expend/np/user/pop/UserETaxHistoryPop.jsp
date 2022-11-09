<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<script src='${pageContext.request.contextPath}/js/ex/underscore.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />
<jsp:include page="../include/UserOptionMap.jsp" flush="false" />

<script>
	var resultValue = {};
	var langCode = '${ViewBag.empInfo.langCode}'||'kr';
	/* ## common ## */
	/* ====================================================================================================================================================== */
	var Common = {
		ERPiU : function() {
			if ('${ERPType}' === 'ERPiU') {
				return true;
			} else {
				return false;
			}
		},
		iCUBE : function() {
			if ('${ERPType}' === 'iCUBE') {
				return true;
			} else {
				return false;
			}
		},
		GetResult : function(result, type) {
			if (typeof result !== 'undefined' && result) {
				if (typeof result.result !== 'undefined' && result.result) {
					if (typeof result.result[type] !== 'undefined' && result.result[type]) {
						/* [ return ] */
						return result.result[type];
					}
				}
			}

			return null;
		},
		CheckboxAllCheck : function() {
			if ($("input:checkbox").not('#all_chk').length === $("input:checkbox:checked").not('#all_chk').length) {
				$('#all_chk').prop('checked', true);
			} else {
				$('#all_chk').prop('checked', false);
			}
		},
		SearchUrl : function() {
			return '<c:url value="/ex/np/user/res/ETaxUseHistorySelect.do" />';
		},
		SearchParam : function() {
			var param = {
				resDocSeq: '${ViewBag.resDocSeq}', /* 결의서 시퀀스 */
				issDateFrom: $('#txtFromDate').val().replace(/-/g, ''), /* 작성일자 From */
				issDateTo: $('#txtToDate').val().replace(/-/g, ''), /* 작성일자 To */
				searchStrTypeCode: $('#selSearchStrTypeCode').val(), /* 검색어 구분 코드 */
				searchStr: $('#txtSearchStr').val(), /* 검색어 */
				eTaxStat: $('#selETaxStatusCode').val(), /* 세금계산서 상태 */
				useEtaxOpt: ${ViewBag.useEtaxOpt}, /* 세금계산서 조회옵션 상태 */
				erpDivSeq : ${ViewBag.erpDivSeq}, /* 세금계산서 조회옵션 상태 */
				approvalEmpName : ''
			};

			return param;
		},
		Date : {
			GetBeforeDate : function(calcDate) {
				var Today = new Date();
				Today.setDate((Today.getDate() - Number((calcDate || 0))));
				return [ Today.getFullYear(), (Today.getMonth() + 1) < 10 ? '0' + (Today.getMonth() + 1) : (Today.getMonth() + 1), (Today.getDate() < 10 ? '0' + Today.getDate() : Today.getDate()) ].join('-');
			},
			GetBeforeMonth : function() {
				var Today = new Date();
				Today.setMonth((Today.getMonth() - 1));
				return [ Today.getFullYear(), (Today.getMonth() + 1) < 10 ? '0' + (Today.getMonth() + 1) : (Today.getMonth() + 1), (Today.getDate() < 10 ? '0' + Today.getDate() : Today.getDate()) ].join('-');
			},
			GetToday : function() {
				var Today = new Date();
				return [ Today.getFullYear(), (Today.getMonth() + 1) < 10 ? '0' + (Today.getMonth() + 1) : (Today.getMonth() + 1), (Today.getDate() < 10 ? '0' + Today.getDate() : Today.getDate()) ].join('-');
			}
		}, Format : {
			Amt : function(value) {
				value = (value || '0');
				value = value.toString().replace(/,/g, '').split(' ').join('');
				value = value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

				return value;
			},
			Date : function(value) {
				value = (value || '');
				value = value.toString().replace(/-/g, '').split(' ').join('');
				value = value.replace(/([0-9]{4})([0-9]{2})([0-9]{2})/, '$1-$2-$3');

				return value;
			},
			DateTime : function(value) {
				value = (value || '');
				value = (value.length > 12 ? value.substring(0, 12) : value);
				value = value.toString().replace(/-/g, '').split(' ').join('');
				value = value.replace(/([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})/, '$1-$2-$3 $4:$5');

				return value;
			},
			RegNo : function(value) {
				value = (value || '');
				value = value.toString().replace(/-/g, '').split(' ').join('');
				value = value.replace(/([0-9]{3})([0-9]{2})([0-9]{5})/, '$1-$2-$3');

				return value;
			},
			CardNum : function(value) {
				value = (value || '');
				value = value.toString().replace(/-/g, '').split(' ').join('');
				value = value.replace(/([0-9]{4})([0-9]{4})([0-9]{3,4})([0-9]{4})/, '$1-****-****-$4');

				return value;
			}
		}
	};

	/* ## ready ## */
	/* ====================================================================================================================================================== */
	$(document).ready(function() {
		fnInit();
		fnEventInit();
		$('#btnSearch').click();
	});

	/* ## init ## */
	/* ====================================================================================================================================================== */
	function fnInit() {
		fnInitPopSize();
		/* 작성일자 From ~ To */
		fnSetDatepicker("#txtFromDate, #txtToDate", "yy-mm-dd");
		$('#txtFromDate').val(Common.Date.GetBeforeMonth());
		$('#txtToDate').val(Common.Date.GetToday());

		/* 검색조건 */

		/* 반영여부 */
		return;
	}

	/* #. fninit - fnInitPopSize */
	function fnInitPopSize() {
		var thisX = parseInt(document.body.scrollWidth);
		var thisY = parseInt(document.body.scrollHeight);
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 50;

		if (maxThisX > 976) {
			maxThisX = 976;
		}

		if (maxThisY > 617) {
			maxThisY = 617;
		}

		var marginY = 0;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
		if (navigator.userAgent.indexOf("MSIE 6") > 0)
			marginY = 45; // IE 6.x
		else if (navigator.userAgent.indexOf("MSIE 7") > 0)
			marginY = 75; // IE 7.x
		else if (navigator.userAgent.indexOf("Firefox") > 0)
			marginY = 50; // FF
		else if (navigator.userAgent.indexOf("Opera") > 0)
			marginY = 30; // Opera
		else if (navigator.userAgent.indexOf("Netscape") > 0)
			marginY = -2; // Netscape

		if (thisX > maxThisX) {
			window.document.body.scroll = "yes";
			thisX = maxThisX;
		}
		if (thisY > maxThisY - marginY) {
			window.document.body.scroll = "yes";
			thisX += 19;
			thisY = maxThisY - marginY;
		}

		// 센터 정렬
		var windowX = (screen.width - (maxThisX + 10)) / 2;
		var windowY = (screen.height - (maxThisY)) / 2 - 20;
		window.moveTo(windowY, windowX);
		window.resizeTo(maxThisX, maxThisY);

		return;
	}

	/* ## event init ## */
	/* ====================================================================================================================================================== */
	function fnEventInit() {
		/* 작성일자 시작일 */
		$('#btnFromDate').click(function() {
			$('#txtFromDate').click();
		});

		/* 작성일자 종료일 */
		$('#btnToDate').click(function() {
			$('#txtToDate').click();
		});

		/* 검색 */
		$('#btnSearch').click(function() {
			fnSearchETaxList();
			$('#txtSearchStr').focus().select();
			return;
		});

		/* 검색어 입력 */
		$('#txtSearchStr').keydown(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#btnSearch').click();
			}
			return;
		});

		/* 반영 */
		$('#btnReflect').click(function() {
			fnETaxCallback();
			return;
		});
		return;
	}

	/* ## etax search ## */
	/* ====================================================================================================================================================== */
	function fnSearchETaxList() {
		var param = {};
		param = Common.SearchParam();
		$('#tblETax').empty();

		$.ajax({
			type : 'post',
			url : Common.SearchUrl(),
			datatype : 'json',
			async : true,
			data : param,
			success : function(result) {
				/* iCUBE example : { divCd: '사업장', taxTy: '구분 ( 0 : 전체, 1 : 매출 , 2 : 매입, 3 : 면세매출, 4 : 면세매입 )', etaxTy: '분류', issDt: '작성일자', isuDt: '발급일자', issYmd: '전송일자', trCd: '코드', trNm: '거래처명', trregNb: '사업자번호', supAm: '공급가액', vatAm: '세액', sumAm: '합계금액', adocuYN: '전표여부 ( 0 : 미발행, 1 : 발행 )', adocuFg: '전표구분 ( 공란, 전표발행, 결의서발행, GW상신 )', dummy2: '구분', issNo: '승인번호', itemDc: '품목명', trsubNb: '종사업장', dummy1: '비고', emailDc: '공급자 이메일', trchargeEmail: '공급받는자 이메일', gwInsertDt: '결재 상신일', approState: '전자결재상태', docuNo: '상신문서번호', issYN: '전표상태', docuInfo: '결의정보' } */

				var aaData = Common.GetResult(result, 'aaData');
				/* aaData = (_.groupBy(_.sortBy(aaData, "issDt"), "issNo")); */
				aaData = _.sortBy(aaData, "issDt");
				aaData = (aaData === null ? [] : aaData.reverse());

				fnSetETaxGrid2(aaData);
			},
			error : function(data) {
				console.log('오류다!확인해봐!이상해~!!악!');
			}
		});

		$('#all_chk').prop('checked', false);

		return;
	}

	/*	[FILTER] 출력 리스트 필터링
	---------------------------------------------------- */
	function fnSetEtaxListFilter(aaData){
		var result = [];
		var isBudgetVatEtc = ( '${ViewBag.vatFgCode}' == '3' ) && ( '${ViewBag.trFgCode}' == '3' );
		
		for(var i=0; i < aaData.length; i++){
			var item = aaData[i];
			
			/* 과세 구분 기타가 아닌 경우 해외 거래처 필터링. */
			if(!isBudgetVatEtc){
				if(!item.trRegNb.trim()){
					continue;
				}
			}
			
			/* 상신여부 확인, 1차 필터링 */
			if( (item.approYN || 'N') == 'Y'){
				continue;
			}
			
			/* 사용여부 확인, 2차 필터링 */
			if( (item.useYN || 'Y') == 'N'){
				continue;
			}
			
			/* 이미 작성 된 내용 필터링 */
			if( (item.writingYN || 'N') == 'Y'){
				continue;
			}
			
			/* 검색어 필터링 */
			var filterType = $('#selSearchStrTypeCode').val();
			var filterText = $('#txtSearchStr').val().replace(/-/gi, '').replaceAll(' ', '');
			if( !!filterText ){
				if( !filterType ){
					/* 전체 검색어 기준 */
					if( item.trName.replace(/-/gi, '').replaceAll(' ', '').indexOf(filterText) > -1 ){
						result.push(item);
						continue;
					} else if( item.trRegNb.replace(/-/gi, '').replaceAll(' ', '').indexOf(filterText) > -1 ){
						result.push(item);
						continue;
					} else if( item.issNo.replace(/-/gi, '').replaceAll(' ', '').indexOf(filterText) > -1 ){
						result.push(item);
						continue;
					}
					continue;
				}else{
					if( filterType == 'partnerName' ){
						/* 공급자 */					
						if( item.trName.replace(/-/gi, '').replaceAll(' ', '').indexOf(filterText) > -1 ){
							result.push(item);
						}
						continue;
					}else if( filterType == 'partnerNo' ){
						/* 등록번호 */
						if( item.trRegNb.replace(/-/gi, '').replaceAll(' ', '').indexOf(filterText) > -1 ){
							result.push(item);
						}
						continue;
					}else if( filterType == 'issNo' ){
						/* 승인번호 */
						if( item.issNo.replace(/-/gi, '').replaceAll(' ', '').indexOf(filterText) > -1 ){
							result.push(item);
						}
						continue;
					}
				}
			}
			result.push(item);
		}
		return result;
	}
	
	/* ## etax grid2 ## */
	/* ====================================================================================================================================================== */
	function fnSetETaxGrid2(aaData) {

		aaData = fnSetEtaxListFilter(aaData);
		var pageSize = $('#divGridArea_selectMenu option:selected').val();
		/* 2018. 06. 25. 결의서 전표처리 시 미지급금 거래처가 공백으로 처리되는 문제점 보완 */
		$.each(aaData, function(idx, item) {
			aaData[idx].ctrSeq = item.trSeq;
			aaData[idx].ctrName = item.trName;
		});
		
		/* 세금계산서 데이터 카운트 출력 */
		$('#pETaxCount').html('${CL.ex_yeCount} ' + aaData.length + '${CL.ex_gun}');
		
		/* 세금 계산서 테이블 초기화 */
		$('#tblETax').html('');
		$("#tblETax").GridTable({
			'tTablename' : 'etaxHistoryList',
			'nTableType' : 1,
			'nHeight' : 300,
			'module' : 'expReport',
			'bNoHover' : true,
			'oNoData' : { // 데이터가 존재하지 않는 경우 
				'tText' : '${CL.ex_NotExistData}' // 출력 텍스트 설정
			},
			"data" : aaData,
			'oPage' : { // 사용자 페이징 정보
				'nItemSize' : pageSize||15 // 페이지별 아이템 갯수(기본 값. 10)
				,
				'anPageSelector' : [ 15, 35, 50, 100 ]
			// 아이템 갯수 선택 셀렉트 구성
			},
			"aoHeaderInfo" : [ { // [*] 테이블 헤더 정보입니다.
				no : '0' // 컬럼 시퀀스입니다.
				,
				renderValue : '<input type="checkbox" id="all_chk" name="all_chk">',
				colgroup : '5'
			}, {
				no : '1',
				renderValue : "${CL.ex_writeDate}",
				colgroup : '18', 
				class : 'orderBy', 
				value : 'issDt' 
			}, {
				no : '2',
				renderValue : '${CL.ex_supplier}',
				colgroup : '40', 
				class : 'orderBy', 
				value : 'trName' 
			}, {
				no : '3',
				renderValue : '${CL.ex_corporateRegistrationNumber}',
				colgroup : '15', 
				class : 'orderBy', 
				value : 'trRegNb' 
			}, {
				no : '4',
				renderValue : '${CL.ex_confirmationNumber}',
				colgroup : '22', 
				class : 'orderBy', 
				value : 'issNo' 
			}, {
				no : '5',
				renderValue : '${CL.ex_amount}',
				colgroup : '15', 
				class : 'orderBy', 
				value : 'reqAmt' 
			}],
			"aoDataRender" : [ { // [*] 실제 데이터 표기 방법에 대하여 지정합니다.
				no : '0',
				render : function(idx, item) {
					var data = escape( JSON.stringify(item) );
					return '<input type="checkbox" class="chk_row" name="chkETax" onclick="" data="' + data + '"/>';
				}
			}, {
				no : '1',
				render : function(idx, item) {
					return Common.Format.Date(item.issDt);
				}
			}, {
				no : '2',
				render : function(idx, item) {
					return item.trName;
				},
				class : 'le'
			}, {
				no : '3',
				render : function(idx, item) {
					return Common.Format.RegNo(item.trRegNb);
				}
			}, {
				no : '4',
				render : function(idx, item) {
					return '<a class="text_blue etaxPop" style="text-decoration:underline;cursor:pointer;" title="매입전자 세금 계산서 상세 팝업보기">' + item.issNo + '</a>';
				},
			}, {
				no : '5',
				render : function(idx, item) {
					return '<span class="ri colorIf" data-toggle="tooltip" data-placement="top" title="총금액 : ' 
					+ Common.Format.Amt(item.reqAmt) 
					+ ' 공급가액 : ' + Common.Format.Amt(item.stdAmt) 
					+ ' 부가세 : ' + Common.Format.Amt(item.vatAmt) + '">' + Common.Format.Amt(item.reqAmt); + '</span>'
				},
				class : 'ri colorIf'
			}],
			'fnGetDetailInfo' : function() {
				console.log('get detail info');
			},
			'fnTableDraw' : function() {
				$('#all_chk').click(function (){
					$('.chk_row').prop('checked', $(this).prop('checked'));
				});
				
				$('.com_ta2.ova_sc2.bg_lightgray.Hsize').removeClass('ova_sc2');
				
				$('.orderBy').click(function(){
					var orderType = $(this).attr('value');
					fnTableReOrder(aaData, orderType, $(this));
				});
			},
			'fnRowCallBack' : function(row, aData) {
				if ((aData.reqAmt || 0) < 0) {
					$(row).find('.colorIf').addClass('color');
				}

				$(row).css('cursor', 'pointer');
				$(row).find('input[type=checkbox]').data('value', aData);
				$(row).click(function() {
					// $table.find('.on').removeClass('on');
					$(this).siblings().removeClass('on');
					$(this).addClass('on');

				});

				$(row).find('.etaxPop').click(function() {
					var popup = window.open("../../../expend/np/user/UserETaxDetailPop.do?syncId=" + aData.issNo, "", "width=900, height=520 , scrollbars=yes");
				});
			}
		});
	}

	
	var _orderBy = 1;
	var _orderType = '';
	function fnTableReOrder(aaData, orderType, $th){
		/* th배경색 변경 */
		if(_orderType != orderType){
			_orderBy = 1;
			_orderType = orderType;
		}else{
			_orderBy *= -1;
		}
		
		aaData.sort(function(a, b) {
			if(_orderType == 'issDt'){
				if( a.issDt < b.issDt ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'trName'){
				if( a.trName < b.trName ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'trRegNb'){
				if( a.trRegNb < b.trRegNb ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'issNo'){
				if( a.issNo < b.issNo ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'reqAmt'){
				if( a.reqAmt < b.reqAmt ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}
			// 이름이 같을 경우
			return 0;
		});
		
		fnSetETaxGrid2(aaData);
		
		$('.com_ta2 table th').css('background', '#f9f9f9');
		if(_orderBy == -1){
			$('.com_ta2 table th[value='+ orderType +']').css('background', '#FFE5E5');
			$th
		}else{
			$('.com_ta2 table th[value='+ orderType +']').css('background', '#E5F4FF');
		}
	}
	
	/* ## etax callback ## */
	/* ====================================================================================================================================================== */
	function fnETaxCallback() {

		var result = [];

		$.each($("input:checkbox:checked").not('#all_chk'), function(idx, chk) {
			if ( JSON.parse( unescape( $(this).attr('data') ) ) ) {
				var tradeETax = JSON.parse( unescape( $(this).attr('data') ) );
				tradeETax.resDocSeq = '${ViewBag.resDocSeq}';
				tradeETax.resSeq = '${ViewBag.resSeq}';
				tradeETax.budgetSeq = '${ViewBag.budgetSeq}';

				/* 거래처 ( trName / trSeq ) */
				tradeETax.ctrSeq = (tradeETax.trSeq || '').toString();
				tradeETax.ctrName = (tradeETax.trName || '').toString();
				/* 대표자명 ( ceoName ) */
				/* 금액 ( tradeAmt ) */
				tradeETax.tradeAmt = (tradeETax.reqAmt || '0').toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				/* 공급가액 ( tradeStdAmt ) */
				tradeETax.tradeStdAmt = (tradeETax.stdAmt || '0').toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				/* 부가세 ( tradeVatAmt ) */
				tradeETax.tradeVatAmt = (tradeETax.vatAmt || '0').toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				/* 금융기관 ( btrName / btrSeq ) */
				tradeETax.btrName = (tradeETax.btrName || '');
				tradeETax.btrSeq = (tradeETax.btrSeq || '');
				/* 계좌번호 ( baNb ) */
				tradeETax.baNb = (tradeETax.baNb || '');
				/* 예금주 ( depositor ) */
				tradeETax.depositor = (tradeETax.depositor || '');
				/* 비고 ( tradeNote ) */
				/* 신고기준일 ( regDate ) */
				tradeETax.regDate = (tradeETax.issDt || '').toString().replace(/-/g, '').replace(/([0-9]{4})-?([0-9]{2})-?([0-9]{2})/, '$1-$2-$3');
				/* 외부연동 구분 값 ( interfaceType ) */
				tradeETax.interfaceType = 'etax';
				tradeETax.tradeNote = (tradeETax.dummary1 || tradeETax.dcRmk || '');
				
				tradeETax.noTaxCode = resultValue.noTaxCode||'';
				tradeETax.noTaxName = resultValue.noTaxName||'';
				result.push(tradeETax);
			}
		});
		
		for(var i = 0; i<result.length;i++){
			if(${ViewBag.vatFgCode} == '4' && result[i].noTaxCode=='' && result[i].noTaxName == ''){
				alert('불공제 사유를 선택해주세요.');
				fnCommonCode('notax','','');
				return false;
			}
		}
		
		$('#btnReflect').unbind('click');
		
		if (opener.window['fnOtherInterfaceCallback']) {
			opener.window['fnOtherInterfaceCallback'](result);
			self.close();
		} else {
			console.error('opener fnOtherInterfaceCallback is not exists..');
			alert('세금계산서 반영중 오류가 발생되었습니다.');
		}

		return;
	}
	
	function fnCommonCode(code, keyName, searchStr, resData, budgetData, tradeData) {
		/* [ parameter ] */
		/*   - code : 공통코드 구분 코드 ( column 사용 권장 ) */
		code = (code || '');
		/*   - keyName : 사용자 입력 키이름 ( F2 와 Enter 의 동작 이벤트가 다르므로 별도 처리 ) */
		keyName = (keyName || '');
		/*   - searchStr : 사용자 입력 검색어 ( Enter 입력시에만 사용 ) */
		searchStr = (searchStr || '');
		/*   - resData : 현재 수정 진행중인 결의정보 행의 정보 */
		resData = (resData || {});
		/*   - budgetData : 현재 수정 진행중이 예산내역 행의 정보 */
		budgetData = (budgetData || {});
		/*   - tradeData : 현재 수정 진행중인 결제내역 행의 정보 */
		tradeData = (tradeData || {});

		/* 파라미터 정의 */
		var param = {};
		
		param.searchStr = (keyName === 'Enter' ? searchStr : '');
		
		/* 공통코드 함수 호출 */
		if (window['fnCommonCode_' + code] && typeof window['fnCommonCode_' + code] === 'function') {
			/* 공통코드 기본 설정 */

			/* 공통코드 전용 함수 수행 */
			window['fnCommonCode_' + code](code, param);
		} else {
			console.log('정의되지 않은 공통코드입니다. ( ' + code + ' / fnCommonCode_' + code + ' )');
		}
	}
	
	/* ## 공통코드 - 팝업호출 ## */
	function fnCommonCodePop(code, obj, callback, data) {
		/* [ parameter ] */
		/*   - obj : 전송할 파라미터 */
		obj = (obj || {});
		/*   - callback : 코백 호출할 함수 명 */
		callback = (callback || '');
		/*   - data : 더미 */
		data = (data || {});

		/* 팝업 호출 */
		obj.widthSize = 780;
		obj.heightSize = 582;

		fnCallCommonCodePop({
			code : code,
			popupType : 2,
			param : JSON.stringify(obj),
			callbackFunction : callback,
			dummy : JSON.stringify(data)
		});
	}
	
	/* ## 공통코드 - 불공제 사유 ## */
	function fnCommonCode_notax(code, param) {
		param = (param || {});
		param.callback = 'fnCommonCode_notax_callback';
		fnCommonCodePop(code, param, param.callback);
		return;
	}
	
	function fnCommonCode_notax_callback(param){
		
		resultValue.noTaxCode = (param.stMutualSeq || '');
		resultValue.noTaxName = (param.stMutualName || '');
		/* [ return ] */
		fnETaxCallback();
	}
</script>

<div class="pop_wrap" style="width: 958px;">
	<div class="pop_head">
		<h1>${CL.ex_electronicInvoice}  <!--매입전자세금계산서--></h1>
		<a href="#n" class="clo"> <img src="../../../Images/btn/btn_pop_clo01.png" alt="" />
		</a>
	</div>
	<div class="pop_con div_form">
		<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_writeDate}  <!--작성일자--></dt>
				<dd>
					<div class="dal_div">
						<input type="text" autocomplete="off" class="w113" id="txtFromDate" /><a id="btnFromDate" href="#n" class="button_dal"></a>
					</div>
					~
					<div class="dal_div">
						<input type="text" autocomplete="off" class="w113" id="txtToDate" /><a id="btnToDate" href="#n" class="button_dal"></a>
					</div>
				</dd>
				<dd>
					<select id="selSearchStrTypeCode" class="selectmenu" style="width: 115px;">
						<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
						<option value="partnerName">${CL.ex_supplyer}  <!--공급자--></option>
						<option value="partnerNo">${CL.ex_corporateRegiNum}  <!--사업자등록번호--></option>
						<option value="issNo">${CL.ex_confirmationNumber}  <!--승인번호--></option>
					</select> <input id="txtSearchStr" type="text" style="width: 400px;" value="" />
				</dd>
				<dt style="display:none;">${CL.ex_reflectionWhether}  <!--반영여부--></dt>
				<dd style="display:none;">
					<select id="selETaxStatusCode" class="selectmenu" style="width: 80px;">
						<option value="">${CL.ex_all}  <!--전체--></option>
						<option value="Y">${CL.ex_res}  <!--결의--></option>
						<option value="Y" selected="selected">${CL.ex_noRes}  <!--미결의--></option>
						<option value="N">${CL.ex_noUser}  <!--미사용--></option>
					</select>
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="${CL.ex_search}"  /><!--검색-->
				</dd>
			</dl>
		</div>
		<!-- 버튼 -->
		<div class="btn_div cl">
			<div class="left_div">
				<p class="fl mt5 mb0 fwb" id="pETaxCount">총 10건</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
					<button id="btnReflect">${CL.ex_reflection}  <!--반영--></button>
				</div>
			</div>
		</div>
		<div class="com_ta2 ova_sc2 bg_lightgray Hsize" style="height: 338px;">
			<table class="brtn" id="tblETax">
			</table>
		</div>
	</div>
</div>
<!--// pop_wrap -->
