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
				resDocSeq: '${ViewBag.resDocSeq}', /* ????????? ????????? */
				issDateFrom: $('#txtFromDate').val().replace(/-/g, ''), /* ???????????? From */
				issDateTo: $('#txtToDate').val().replace(/-/g, ''), /* ???????????? To */
				searchStrTypeCode: $('#selSearchStrTypeCode').val(), /* ????????? ?????? ?????? */
				searchStr: $('#txtSearchStr').val(), /* ????????? */
				eTaxStat: $('#selETaxStatusCode').val(), /* ??????????????? ?????? */
				useEtaxOpt: ${ViewBag.useEtaxOpt}, /* ??????????????? ???????????? ?????? */
				erpDivSeq : '${ViewBag.erpDivSeq}', /* ??????????????? ???????????? ?????? */
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
		/* ???????????? From ~ To */
		fnSetDatepicker("#txtFromDate, #txtToDate", "yy-mm-dd");
		$('#txtFromDate').val(Common.Date.GetBeforeMonth());
		$('#txtToDate').val(Common.Date.GetToday());

		/* ???????????? */

		/* ???????????? */
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
		// ??????????????? ?????? ??????. (?????? ??? ????????? ????????? ????????????.)
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

		// ?????? ??????
		var windowX = (screen.width - (maxThisX + 10)) / 2;
		var windowY = (screen.height - (maxThisY)) / 2 - 20;
		window.moveTo(windowY, windowX);
		window.resizeTo(maxThisX, maxThisY);

		return;
	}

	/* ## event init ## */
	/* ====================================================================================================================================================== */
	function fnEventInit() {
		/* ???????????? ????????? */
		$('#btnFromDate').click(function() {
			$('#txtFromDate').click();
		});

		/* ???????????? ????????? */
		$('#btnToDate').click(function() {
			$('#txtToDate').click();
		});

		/* ?????? */
		$('#btnSearch').click(function() {
			fnSearchETaxList();
			$('#txtSearchStr').focus().select();
			return;
		});

		/* ????????? ?????? */
		$('#txtSearchStr').keydown(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (keyCode.toString() === '13') {
				$('#btnSearch').click();
			}
			return;
		});

		/* ?????? */
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
				/* iCUBE example : { divCd: '?????????', taxTy: '?????? ( 0 : ??????, 1 : ?????? , 2 : ??????, 3 : ????????????, 4 : ???????????? )', etaxTy: '??????', issDt: '????????????', isuDt: '????????????', issYmd: '????????????', trCd: '??????', trNm: '????????????', trregNb: '???????????????', supAm: '????????????', vatAm: '??????', sumAm: '????????????', adocuYN: '???????????? ( 0 : ?????????, 1 : ?????? )', adocuFg: '???????????? ( ??????, ????????????, ???????????????, GW?????? )', dummy2: '??????', issNo: '????????????', itemDc: '?????????', trsubNb: '????????????', dummy1: '??????', emailDc: '????????? ?????????', trchargeEmail: '??????????????? ?????????', gwInsertDt: '?????? ?????????', approState: '??????????????????', docuNo: '??????????????????', issYN: '????????????', docuInfo: '????????????' } */

				var aaData = Common.GetResult(result, 'aaData');
				/* aaData = (_.groupBy(_.sortBy(aaData, "issDt"), "issNo")); */
				aaData = _.sortBy(aaData, "issDt");
				aaData = (aaData === null ? [] : aaData.reverse());

				fnSetETaxGrid2(aaData);
			},
			error : function(data) {
				console.log('?????????!????????????!?????????~!!???!');
			}
		});

		$('#all_chk').prop('checked', false);

		return;
	}

	/*	[FILTER] ?????? ????????? ?????????
	---------------------------------------------------- */
	function fnSetEtaxListFilter(aaData){
		var result = [];
		var isBudgetVatEtc = ( '${ViewBag.vatFgCode}' == '3' ) && ( '${ViewBag.trFgCode}' == '3' );
		
		for(var i=0; i < aaData.length; i++){
			var item = aaData[i];
			
			/* ?????? ?????? ????????? ?????? ?????? ?????? ????????? ?????????. */
			if(!isBudgetVatEtc){
				if(!item.trRegNb.trim()){
					continue;
				}
			}
			
			/* ???????????? ??????, 1??? ????????? */
			if( (item.approYN || 'N') == 'Y'){
				continue;
			}
			
			/* ???????????? ??????, 2??? ????????? */
			if( (item.useYN || 'Y') == 'N'){
				continue;
			}
			
			/* ?????? ?????? ??? ?????? ????????? */
			if( (item.writingYN || 'N') == 'Y'){
				continue;
			}
			
			/* ????????? ????????? */
			var filterType = $('#selSearchStrTypeCode').val();
			var filterText = $('#txtSearchStr').val().replace(/-/gi, '').replaceAll(' ', '');
			if( !!filterText ){
				if( !filterType ){
					/* ?????? ????????? ?????? */
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
						/* ????????? */					
						if( item.trName.replace(/-/gi, '').replaceAll(' ', '').indexOf(filterText) > -1 ){
							result.push(item);
						}
						continue;
					}else if( filterType == 'partnerNo' ){
						/* ???????????? */
						if( item.trRegNb.replace(/-/gi, '').replaceAll(' ', '').indexOf(filterText) > -1 ){
							result.push(item);
						}
						continue;
					}else if( filterType == 'issNo' ){
						/* ???????????? */
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
		/* 2018. 06. 25. ????????? ???????????? ??? ???????????? ???????????? ???????????? ???????????? ????????? ?????? */
		$.each(aaData, function(idx, item) {
			aaData[idx].ctrSeq = item.trSeq;
			aaData[idx].ctrName = item.trName;
		});
		
		/* ??????????????? ????????? ????????? ?????? */
		$('#pETaxCount').html('${CL.ex_yeCount} ' + aaData.length + '${CL.ex_gun}');
		
		/* ?????? ????????? ????????? ????????? */
		$('#tblETax').html('');
		$("#tblETax").GridTable({
			'tTablename' : 'etaxHistoryList',
			'nTableType' : 1,
			'nHeight' : 300,
			'module' : 'expReport',
			'bNoHover' : true,
			'oNoData' : { // ???????????? ???????????? ?????? ?????? 
				'tText' : '${CL.ex_NotExistData}' // ?????? ????????? ??????
			},
			"data" : aaData,
			'oPage' : { // ????????? ????????? ??????
				'nItemSize' : pageSize||15 // ???????????? ????????? ??????(?????? ???. 10)
				,
				'anPageSelector' : [ 15, 35, 50, 100 ]
			// ????????? ?????? ?????? ????????? ??????
			},
			"aoHeaderInfo" : [ { // [*] ????????? ?????? ???????????????.
				no : '0' // ?????? ??????????????????.
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
			"aoDataRender" : [ { // [*] ?????? ????????? ?????? ????????? ????????? ???????????????.
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
					return '<a class="text_blue etaxPop" style="text-decoration:underline;cursor:pointer;" title="???????????? ?????? ????????? ?????? ????????????">' + item.issNo + '</a>';
				},
			}, {
				no : '5',
				render : function(idx, item) {
					return '<span class="ri colorIf" data-toggle="tooltip" data-placement="top" title="????????? : ' 
					+ Common.Format.Amt(item.reqAmt) 
					+ ' ???????????? : ' + Common.Format.Amt(item.stdAmt) 
					+ ' ????????? : ' + Common.Format.Amt(item.vatAmt) + '">' + Common.Format.Amt(item.reqAmt); + '</span>'
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
		/* th????????? ?????? */
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
			// ????????? ?????? ??????
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

				/* ????????? ( trName / trSeq ) */
				tradeETax.ctrSeq = (tradeETax.trSeq || '').toString();
				tradeETax.ctrName = (tradeETax.trName || '').toString();
				/* ???????????? ( ceoName ) */
				/* ?????? ( tradeAmt ) */
				tradeETax.tradeAmt = (tradeETax.reqAmt || '0').toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				/* ???????????? ( tradeStdAmt ) */
				tradeETax.tradeStdAmt = (tradeETax.stdAmt || '0').toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				/* ????????? ( tradeVatAmt ) */
				tradeETax.tradeVatAmt = (tradeETax.vatAmt || '0').toString().replace(/,/g, '').replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				/* ???????????? ( btrName / btrSeq ) */
				tradeETax.btrName = (tradeETax.btrName || '');
				tradeETax.btrSeq = (tradeETax.btrSeq || '');
				/* ???????????? ( baNb ) */
				tradeETax.baNb = (tradeETax.baNb || '');
				/* ????????? ( depositor ) */
				tradeETax.depositor = (tradeETax.depositor || '');
				/* ?????? ( tradeNote ) */
				/* ??????????????? ( regDate ) */
				tradeETax.regDate = (tradeETax.issDt || '').toString().replace(/-/g, '').replace(/([0-9]{4})-?([0-9]{2})-?([0-9]{2})/, '$1-$2-$3');
				/* ???????????? ?????? ??? ( interfaceType ) */
				tradeETax.interfaceType = 'etax';
				tradeETax.tradeNote = (tradeETax.dummary1 || tradeETax.dcRmk || '');
				
				tradeETax.noTaxCode = resultValue.noTaxCode||'';
				tradeETax.noTaxName = resultValue.noTaxName||'';
				result.push(tradeETax);
			}
		});
		
		for(var i = 0; i<result.length;i++){
			if(${ViewBag.vatFgCode} == '4' && result[i].noTaxCode=='' && result[i].noTaxName == ''){
				alert('????????? ????????? ??????????????????.');
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
			alert('??????????????? ????????? ????????? ?????????????????????.');
		}

		return;
	}
	
	function fnCommonCode(code, keyName, searchStr, resData, budgetData, tradeData) {
		/* [ parameter ] */
		/*   - code : ???????????? ?????? ?????? ( column ?????? ?????? ) */
		code = (code || '');
		/*   - keyName : ????????? ?????? ????????? ( F2 ??? Enter ??? ?????? ???????????? ???????????? ?????? ?????? ) */
		keyName = (keyName || '');
		/*   - searchStr : ????????? ?????? ????????? ( Enter ??????????????? ?????? ) */
		searchStr = (searchStr || '');
		/*   - resData : ?????? ?????? ???????????? ???????????? ?????? ?????? */
		resData = (resData || {});
		/*   - budgetData : ?????? ?????? ???????????? ???????????? ?????? ?????? */
		budgetData = (budgetData || {});
		/*   - tradeData : ?????? ?????? ???????????? ???????????? ?????? ?????? */
		tradeData = (tradeData || {});

		/* ???????????? ?????? */
		var param = {};
		
		param.searchStr = (keyName === 'Enter' ? searchStr : '');
		
		/* ???????????? ?????? ?????? */
		if (window['fnCommonCode_' + code] && typeof window['fnCommonCode_' + code] === 'function') {
			/* ???????????? ?????? ?????? */

			/* ???????????? ?????? ?????? ?????? */
			window['fnCommonCode_' + code](code, param);
		} else {
			console.log('???????????? ?????? ?????????????????????. ( ' + code + ' / fnCommonCode_' + code + ' )');
		}
	}
	
	/* ## ???????????? - ???????????? ## */
	function fnCommonCodePop(code, obj, callback, data) {
		/* [ parameter ] */
		/*   - obj : ????????? ???????????? */
		obj = (obj || {});
		/*   - callback : ?????? ????????? ?????? ??? */
		callback = (callback || '');
		/*   - data : ?????? */
		data = (data || {});

		/* ?????? ?????? */
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
	
	/* ## ???????????? - ????????? ?????? ## */
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
		<h1>${CL.ex_electronicInvoice}  <!--???????????????????????????--></h1>
		<a href="#n" class="clo"> <img src="../../../Images/btn/btn_pop_clo01.png" alt="" />
		</a>
	</div>
	<div class="pop_con div_form">
		<!-- ???????????? -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_writeDate}  <!--????????????--></dt>
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
						<option value="" selected="selected">${CL.ex_all}  <!--??????--></option>
						<option value="partnerName">${CL.ex_supplyer}  <!--?????????--></option>
						<option value="partnerNo">${CL.ex_corporateRegiNum}  <!--?????????????????????--></option>
						<option value="issNo">${CL.ex_confirmationNumber}  <!--????????????--></option>
					</select> <input id="txtSearchStr" type="text" style="width: 400px;" value="" />
				</dd>
				<dt style="display:none;">${CL.ex_reflectionWhether}  <!--????????????--></dt>
				<dd style="display:none;">
					<select id="selETaxStatusCode" class="selectmenu" style="width: 80px;">
						<option value="">${CL.ex_all}  <!--??????--></option>
						<option value="Y">${CL.ex_res}  <!--??????--></option>
						<option value="Y" selected="selected">${CL.ex_noRes}  <!--?????????--></option>
						<option value="N">${CL.ex_noUser}  <!--?????????--></option>
					</select>
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="${CL.ex_search}"  /><!--??????-->
				</dd>
			</dl>
		</div>
		<!-- ?????? -->
		<div class="btn_div cl">
			<div class="left_div">
				<p class="fl mt5 mb0 fwb" id="pETaxCount">??? 10???</p>
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
					<button id="btnReflect">${CL.ex_reflection}  <!--??????--></button>
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
