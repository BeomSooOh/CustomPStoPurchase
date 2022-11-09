<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>

<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>
<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />
<jsp:include page="../include/UserOptionMap.jsp" flush="false" />
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>

<script>
	var clickCount = 0;
	var timeOut = null;
	var cardData = new Array();
	var resultValue = {};
	
	
	/* 공통 함수 정의 */
	var Common = {
			GetIfSystem : function() {
				return '${ViewBag.ifUseSystem}';
			},
			iCUBE : function() {
				if (Common.GetIfSystem() === 'iCUBE') {
					return true;
				} else {
					return false;
				}
			},
			ERPiU : function() {
				if (Common.GetIfSystem() === 'ERPiU') {
					return true;
				} else {
					return false;
				}
			},
			GetEmpInfo : function() {
				return {
					erpEmpSeq : "${ViewBag.empInfo.erpEmpSeq}",
					langCode : "${ViewBag.empInfo.langCode}",
					erpCompSeq : "${ViewBag.empInfo.erpCompSeq}",
					groupSeq : "${ViewBag.empInfo.groupSeq}",
					empSeq : "${ViewBag.empInfo.empSeq}",
					compSeq : "${ViewBag.empInfo.compSeq}",
					userSe : "${ViewBag.empInfo.userSe}",
					deptSeq : "${ViewBag.empInfo.deptSeq}",
					bizSeq : "${ViewBag.empInfo.bizSeq}"
				}
			},
			Param : {
				GetSearchParam : function() {
					var paraemters = {};
					var searchCardInfo = '';
//	 				searchCardInfo = (JSON.parse($("#hidCardInfo").val() || '[]').map(function(value){
//	 					return ((value || '').toString().split('|').length > 2 ? value.toString().split('|')[2] : '');
//	 				}).join('|') || '');
//	 				searchCardInfo = (searchCardInfo !== '' ? '|' : '') + searchCardInfo + (searchCardInfo !== '' ? '|' : '');
					var cardList = JSON.parse( $("#hidCardInfo").val() || "[]" );
					for(var i = 0; i < cardList.length; i++){
						var item = cardList[i];
						searchCardInfo += ",'" + ( item.indexOf('|') > -1 ? item.split('|')[0] : "") + "'" ;
					}
					paraemters.cardAuthDateFrom = $("#txtFromDate").val().replace(/-/g, ''); /* 승인일자 시작일 */
					paraemters.cardAuthDateTo = $("#txtToDate").val().replace(/-/g, ''); /* 승인일자 종료일 */
					paraemters.searchCardInfo = searchCardInfo; /* 카드번호 */
					paraemters.searchPartnerNo = ($("#txtOwnerRegNo").val() || ''); /* 사업자등록번호 */
					paraemters.searchSendYn = ($("#selDocStatus").val() || ''); /* 결의상태 */
					paraemters.searchApprovalEmpName = ($("#txtEmpName").val() || ''); /* 결의자 */
					paraemters.searchPartnerName = ($("#txtMercName").val() || ''); /* 사용자 */
					paraemters.searchAuthNum = ($("#txtCardAuthNum").val() || ''); /* 승인번호 */
					paraemters.searchGeoraeStat = ($("#georaeStatus").val() || ''); /* 승인/취소 */
					paraemters.orderBy = 'ASC';

					return Common.Param._GetSearchFormat(paraemters);
				},
				_GetSearchFormat : function(paraemters) {
					$.each(Object.keys(paraemters), function(idx, key) {
						if (SearchDateFormat.indexOf(key) > -1) {
							/* "-" 제거 처리 */
							paraemters[key] = paraemters[key].toString().replace(/-/g, '');
						}
					});

					return paraemters;
				}
			},
			Result : {
				GetAData : function(param) {
					param = (param === null ? {} : param);

					if (param.result) {
						if (param.result.aData) {
							return param.result.aData;
						}
					}

					return {};
				},
				GetAaData : function(param) {
					param = (param === null ? [] : param);

					if (param.result) {
						if (param.result.aaData) {
							return param.result.aaData;
						}
					}

					return [];
				},
				GetCode : function(param) {
					param = (param === null ? {} : param);

					if (param.result) {
						if (param.result.resultCode) {
							return param.result.resultCode;
						}
					}

					return '';
				},
				GetMessage : function(param) {
					param = (param === null ? {} : param);

					if (param.result) {
						if (param.result.resultName) {
							return param.result.resultName;
						}
					}

					return '';
				}
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
				},
				SetDatepicker : function(id, format) {
					$(id).datepicker({
						closeText : '닫기',
						prevText : '이전달',
						nextText : '다음달',
						currentText : '오늘',
						monthNames : [ '1${CL.ex_month}', '2${CL.ex_month}', '3${CL.ex_month}', '4${CL.ex_month}', '5${CL.ex_month}', '6${CL.ex_month}', '7${CL.ex_month}', '8${CL.ex_month}', '9${CL.ex_month}', '10${CL.ex_month}', '11${CL.ex_month}', '12${CL.ex_month}' ],
						monthNamesShort : [ '1${CL.ex_month}', '2${CL.ex_month}', '3${CL.ex_month}', '4${CL.ex_month}', '5${CL.ex_month}', '6${CL.ex_month}', '7${CL.ex_month}', '8${CL.ex_month}', '9${CL.ex_month}', '10${CL.ex_month}', '11${CL.ex_month}', '12${CL.ex_month}' ],
						dayNames : [ '${CL.ex_sun}', '${CL.ex_mon}', '${CL.ex_tue}', '${CL.ex_wed}', '${CL.ex_thu}', '${CL.ex_fri}', '${CL.ex_sat}' ],
						dayNamesShort : [ '${CL.ex_sun}', '${CL.ex_mon}', '${CL.ex_tue}', '${CL.ex_wed}', '${CL.ex_thu}', '${CL.ex_fri}', '${CL.ex_sat}' ],
						dayNamesMin : [ '${CL.ex_sun}', '${CL.ex_mon}', '${CL.ex_tue}', '${CL.ex_wed}', '${CL.ex_thu}', '${CL.ex_fri}', '${CL.ex_sat}' ],
						weekHeader : 'Wk',
						firstDay : 0,
						isRTL : false,
						duration : 200,
						showAnim : 'show',
						showMonthAfterYear : true,
						dateFormat : format
					});
				}
			},
			Format : {
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
			},
			Util : {
				CheckboxStat : function() {
					var checkboxCount = $("input[name=chkCard]:checkbox").length
					var checkboxCheckedCount = $("input[name=chkCard]:checkbox:checked").length;

					if (checkboxCount === checkboxCheckedCount) {
						$('#chkAll').prop('checked', true);
					} else {
						$('#chkAll').prop('checked', false);
					}
				},
				CheckAll : function() {
					if ($("#chkAll").prop("checked")) {
						$("#tblCardReport input[type=checkbox]").not(":disabled").prop("checked", true);
					} else {
						$("#tblCardReport input[type=checkbox]").not(":disabled").prop("checked", false);
					}
				}
			}
	}
	
	
	$(document).ready(function(){
		Hsize();
        $(window).resize(function() { 
            Hsize();
        });
		fnInit();
		         
		$("#btnSearch").click();
	});
	
    function Hsize() {
        var PopyHei = $("html").height();
        var TitleyHei = $(".pop_head").height();
        var SearchHei = $(".top_box").height();
        $(".Hsize").height(PopyHei-TitleyHei-SearchHei-126);
     }
	/* 초기화 */
	function fnInit(){
		fnInitLayout();
		fnInitEvent();
		
	}
	
	/* 초기화 - 레이아웃 */
	function fnInitLayout(){
		fnSetDatepicker("#txtFromDate, #txtToDate","yy-mm-dd");
		var toD = new Date();
		if (toD.getMonth() == 0) {
			var fromD = new Date(toD.getFullYear() - 1, 11, toD.getDate());
		} else {
			var fromD = new Date(toD.getFullYear(), toD.getMonth() - 1,	toD.getDate());
		}
		var fM = ((fromD.getMonth() + 1) < 10 ? "0" + (fromD.getMonth() + 1) : (fromD.getMonth() + 1))
		var tM = ((toD.getMonth() + 1) < 10 ? "0" + (toD.getMonth() + 1) : (toD.getMonth() + 1))
		var fD = (fromD.getDate() < 10 ? "0" + fromD.getDate() : fromD.getDate())
		var tD = (toD.getDate() < 10 ? "0" + toD.getDate() : toD.getDate())
		$("#txtFromDate").val(fromD.getFullYear() +"-" + fM +"-"+fD);
		$("#txtToDate").val(toD.getFullYear() +"-" + tM +"-"+tD);
	}
	
	/* 초기화 - 이벤트 */
	function fnInitEvent(){
		/* 조회 버튼 */
		$("#btnSearch").on("click",function(){
			fnCardHistorySearch();
		});
		
		/* 반영 버튼 */
		$("#btnReflect").on("click",function(){
			fnCardHistoryReflect();
		});
		
		/* 확인 버튼 */
		$("#btnConfirm").on("click",function(){
			alert("확인");
		});
		
		/* 취소 버튼 */
		$("#btnCancel").on("click",function(){
			self.close();
		});
		
		$("#txtSearchStr").keydown(function(event){
			if(event.keyCode == '13'){
				$("#btnSearch").click();
			}
		});
		
		$("#txtFromDate, #txtToDate").keyup(function(e){
			if( ( 48 <= e.keyCode && e.keyCode <= 57 ) || (  96 <= e.keyCode && e.keyCode <= 105  ) ){
				var dataLength = $("#" + $(this).prop("id")).val().length;
				if( dataLength == 4 || dataLength == 7 ){
					$("#" + $(this).prop("id")).val($("#" + $(this).prop("id")).val() + "-");
				}	
			}else if( e.keyCode == 13){
				$("#btnSearch").click();
			}
		});
		
		$(".button_dal").on("click",function(){
			if( !$("#txt" + $(this).attr("id").replace("btn","") ).datepicker("widget").is(":visible") ){
				$("#txt" + $(this).attr("id").replace("btn","") ).datepicker("show");	
			}
		})
		
		/* 버튼 이벤트 - 카드정보 선택 버튼 */
		$("#btnCardInfo").on("click",function(){
			fnCardInfoPop();
		});
		
		$('#txtMercName, #txtOwnerRegNo').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#btnSearch').click();
            }
        });
	}
	
	/* 사용내역 조회 */
	function fnCardHistorySearch(){
		var param = {};
		param.searchType = $("#selSearchType").val();
		param.searchStr = $("#txtSearchStr").val();
		param.searchMercName = ($("#txtMercName").val() || '');
		param.searchOwnerRegNo = ($("#txtOwnerRegNo").val() || '');
		param.sendYN = $("#selSendYN").val();
		param.fromDate = $("#txtFromDate").val().replace(/-/g,'');
		param.toDate = $("#txtToDate").val().replace(/-/g,'');
		param.resDocSeq = ${ViewBag.resDocSeq};
		
		var cardInfo = ($("#hidCardInfo").val() || '');
		param.searchCardInfo = cardInfo.substr(0,cardInfo.length-1);
		
		param.notInSyncId = '';
		param.orderBy = 'ASC';
		param.cardAuthDateFrom = $("#txtFromDate").val().replace(/-/g,'');
		param.cardAuthDateTo = $("#txtToDate").val().replace(/-/g,'');

		param.txtCardInfo = ( $('#txtCardInfo').val() || '');
		param.hideCardInfo = ( $('#hidCardInfo').val() || '');
		param.txtMercName = ( $('#txtMercName').val() || '');
		param.txtOwnerRegNo = ( $('#txtOwnerRegNo').val() || '');		
	

		/* 공통코드 호출 */
		$.ajax({
	        type : 'post',
	        url : '<c:url value="/ex/np/user/res/CardUseHistorySelect.do" />',
	        datatype : 'json',
	        async : true,
	        data : param,
	        success : function( data ) {
	        	fnGridTable2(data.result.aaData);
	        },
	        error : function( data ) {
	            console.log('오류다!확인해봐!이상해~!!악!');
	        }
	    });
	}
	
	
	/*	[그리드 출력] 그리드 출력 리스트 필터링
	-------------------------------------------------------------------- */
	function fnFilterdList(aaData){
		var filterdList = [];
		var searchParam = {
			partnerName : ($("#txtMercName").val() || '')	
			, partnerNo : ($("#txtOwnerRegNo").val() || '')
			, sendYN : 'N'
			, useYn : 'N'
				/* 과세구분에 따른 데이터 노출 보정 (과세/면세 경우 해외 거래처 출력하지 않음.) */
			, isBudgetVatEtc : ( '${ViewBag.vatFgCode}' == '3' ) && ( '${ViewBag.trFgCode}' == '3' )
		};
	
		for(var i = 0; i < aaData.length; i++){
			var item = aaData[i];
			/* 사용처 체크 */
			if( (item.partnerName || '') .indexOf(searchParam.partnerName) == -1){
				continue;
			}
			
			/* 사업자번호 체크 */
			if( (item.partnerNo || '') .indexOf(searchParam.partnerNo) == -1){
				continue;
			}
			
			/* 결의상태 체크 */
			if( (item.sendYn || 'N') == 'Y'){
				continue;
			}
			
			/* 사용여부 체크 */
			if( (item.useYn || 'Y') == 'N'){
				continue;
			}
			
			/* 사용여부 체크 */
			if( (item.writingYn || 'N') == 'Y'){
				continue;
			}
			
			/* 승인시각 누락 필터링 */
			item.authTime = item.authTime || '000000';
			 
			/* 과세 구분 기타가 아닌 경우 해외 거래처 필터링. */
			if(!searchParam.isBudgetVatEtc && (!item.partnerNo.trim()) ){
				continue;
			} 
			 
			filterdList.push(item);
		}
		console.log('function fnFilterdList(aaData) RESULT : ');
		return filterdList;
	}
	
	/* 테이블 출력2 */
	function fnGridTable2(aaData){
		aaData = fnFilterdList(aaData);
		var pageSize = $('#divGridArea_selectMenu option:selected').val();
		$('#cardHistoryCnt').html(aaData.length || 0);
		$("#tblCardHistory").html("");
		$("#tblCardHistory").GridTable({
			'tTablename' : 'cardResultReturn',
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
				colgroup : '4'
			},  {
				no : '2',
				renderValue : '${CL.ex_dateAndTimeOfApproval}',
				colgroup : '15', 
				class : 'orderBy', 
				value : 'authDate' 
				
			}, {
				no : '3',
				renderValue : '${CL.ex_confirmationNumber}',
				colgroup : '9',
				class : 'orderBy', 
				value : 'authNum'
			}, {
				no : '4',
				renderValue : '${CL.ex_whereUsed}',
				colgroup : '34',
				class : 'orderBy', 
				value : 'partnerName'
			}, {
				no : '5',
				renderValue : '${CL.ex_businessNumber}',
				colgroup : '13',
				class : 'orderBy', 
				value : 'partnerNo'
			}, {
				no : '6',
				renderValue : '${CL.ex_theNameOfCard}',
				colgroup : '15',
				class : 'orderBy', 
				value : 'cardName'
			}, {
				no : '7',
				renderValue : '${CL.ex_cardNumber}',
				colgroup : '19',
				class : 'orderBy', 
				value : 'cardNum'
			}, {
	            no: '8'
		        , renderValue: '${CL.ex_amount}'
	            , colgroup: '13',
				class : 'orderBy', 
				value : 'reqAmt'
		    }],
			"aoDataRender" : [ { // [*] 실제 데이터 표기 방법에 대하여 지정합니다.
				no : '0',
				render : function(idx, item) {
					return '<input class="chk_targetData" type="checkbox" id="chk_'+item.syncId+'" value="'+item.syncId+'"/>';
				}
			}, {
				no : '2',
				render : function(idx, item) {
					return Common.Format.DateTime((item.authDate || '') + (item.authTime || ''));
				},
				class : 'cen'
			}, {
				no : '3',
				render : function(idx, item) {
					return '<a class="text_blue cardPop" style="text-decoration:underline;cursor:pointer;" title="법인카드 사용내역 상세 팝업보기">' + (item.authNum || '') + '</a>';
				},
				class : 'cen'
			}, {
				no : '4',
				render : function(idx, item) {
					return item.partnerName;
				},
				class : 'le'
			}, {
				no : '5',
				render : function(idx, item) {
					return Common.Format.RegNo(item.partnerNo);
				},
				class : 'cen'
			}, {
				no : '6',
				render : function(idx, item) {
					return (item.cardName || '') ;
				},
				class : 'cen'
			}, {
				no : '7',
				render : function(idx, item) {
					var cardNumTxt = item.cardNum.replaceAll('-', '');
					var firstCardNum = cardNumTxt.substr(0,4);
					var secCardNum = cardNumTxt.substr(4,4);
					var thirdCardNum = cardNumTxt.substr(8,4);
					var fourthCardNum = cardNumTxt.substr(12,4);
					var cardDispOption = '0';
					try{
						cardDispOption = optionSet.gw[1][1].setValue;
					}catch(e){
						cardDispOption = '0';
					}
					if(cardDispOption == '0'){
						secCardNum = '****';
						thirdCardNum = '****';
					}
					return firstCardNum + '-' + secCardNum + '-' + thirdCardNum + '-' + fourthCardNum;
				},
				class : ''
			}, {
                no: '8',
                render: function (idx, item) {
                	return '<span class="ri colorIf" data-toggle="tooltip" data-placement="top" title="총금액 : ' + Common.Format.Amt(item.reqAmt) + ' 공급가액 : ' + Common.Format.Amt(item.stdAmt) + ' 부가세 : ' + Common.Format.Amt(item.vatAmt) + '">' + Common.Format.Amt(item.reqAmt); + '</span>'
                }
				, class : 'ri' 
            }],
			'fnGetDetailInfo' : function() {
				console.log('get detail info');
			},
			'fnTableDraw' : function() {
				$('#all_chk').click(function (){
					$('.chk_row:enabled').prop('checked', $(this).prop('checked'));
				});
				
				$('.com_ta2.ova_sc2.bg_lightgray.Hsize').removeClass('ova_sc2');
				
				$('#all_chk').click(fnAllChk);
				
				$('.orderBy').click(function(){
					var orderType = $(this).attr('value');
					fnTableReOrder(aaData, orderType, $(this));
				});
			},
			'fnRowCallBack' : function(row, aData) {
				if ( ( (aData.reqAmt || 0) < 0) || ((aData.georaeStat||'') == 'Y')) {
					$(row).find('td').css('background', '#ffd5d5');
					$(row).find('.colorIf').css('color', 'red');
				}else{
					$(row).find('.colorIf').css('color', 'blue');
				}

				$(row).find('.cardPop').click(function(){
					var popup = window.open("../../../expend/np/user/UserCardDetailPop.do?syncId=" + aData.syncId, "" , "width=432, height=489 , scrollbars=yes");						
				});
				
				if ((aData.useYn || 'Y') == 'N') {
					$(row).find('td').css('background', '#f5f5f5');
					$(row).find('.colorIf2').css('color', 'red');
					$(row).find('.colorIf').css('color', 'gray');
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
				
				cardData[aData.syncId] = aData;
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
			if(_orderType == 'authDate'){
				var aDate = (a.authDate || '') + (a.authTime || '');
				var bDate = (b.authDate || '') + (b.authTime || '');
				
				if( aDate < bDate ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'authNum'){
				if( a.authNum < b.authNum ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'partnerName'){
				if( a.partnerName < b.partnerName ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'partnerNo'){
				if( a.partnerNo < b.partnerNo ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'cardName'){
				if( a.cardName < b.cardName ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}else if(_orderType == 'cardNum'){
				if( a.cardNum.replace(/-/gi, '') < b.cardNum.replace(/-/gi, '') ){
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
		
		fnGridTable2(aaData);
		
		$('.com_ta2 table th').css('background', '#f9f9f9');
		if(_orderBy == -1){
			$('.com_ta2 table th[value='+ orderType +']').css('background', '#FFE5E5');
			$th
		}else{
			$('.com_ta2 table th[value='+ orderType +']').css('background', '#E5F4FF');
		}
	}

	/* ## event init ## */
	/* ====================================================================================================================================================== */
	function fnEventInit() {

		/* 검색 */
		$('#btnSearch').click(function() {
			fnCardHistorySearch();
			return;
		});

		/* 카드내역이관 */
		$('#btnCardTrancefer').click(function() {
			fnCardTrans();
			return;
		});

		/* 이관관리 */
		$('#btnCardHistroy').click(function() {
			fnCardTransHistory();
			return;
		});

		/* 엑셀다운로드 */
		$('#btnExcelDown').click(function() {
			fnCardExcelDownload();
			return;
		});

		/* 카드선택 */
		$('#btnCardInfo').click(function() {
			fnCardInfoPop();
			return;
		});

		/* 사용처리 */
		$("#btnCardUseY").on("click", function() {
			fnCardUseYN('Y');
			return;
		});

		/* 미사용처리 */
		$("#btnCardUseN").on("click", function() {
			fnCardUseYN('N');
			return;
		});

		/* 엔터 / F2 검색 */
		$('#txtMercName, #txtCardAuthNum, #txtOwnerRegNo, #txtEmpName').keydown(function(e) {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (SearchKeyCode.indexOf(keyCode.toString()) > -1) {
				$('#btnSearch').click();
			}
		});

		/* 전자결재 정보 팝업 닫기 */
		$('#lp_btnClose').click(function(){
			$('.eaInfo').hide();
		});
		
		/* 카드 검색 정보 초기화 */
		$('#btnRefreshCardInfo').click(function (){
			$('#txtCardInfo').val('');
			$('#hidCardInfo').val('');
		});
		
		return;
	}
	
	
	/* ## search report ## */
	/* ====================================================================================================================================================== */
	
	/* 테이블 출력 */
	function fnGridTable(data){
		data = fnFilterdList(data);
		
		$('#cardHistoryCnt').html( (data.length || 0 ) );
		$("#tblCardHistory").empty();
		var colGroup = '<colgroup>';
		
		colGroup += '<col width="100"/>';
		colGroup += '<col width="115"/>';
		colGroup += '<col width=""/>';
		colGroup += '<col width=""/>';
		colGroup += '<col width=""/>';
		colGroup += '<col width="140"/>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width="100"/>';
		colGroup += '<col width="80"/>';
		colGroup += '</colgroup>';
		$("#tblCardHistory").append(colGroup);
		
		if(data.length == 0){
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="' + $("#tblCardHistory colgroup col").length + '">${CL.ex_dataDoNotExists}</td>')
			$("#tblCardHistory").append(tr);
		}else{
			$.each(data,function(idx, val){
				var tr = document.createElement('tr');
				$(tr).data('data', val);
				
				/* 2018. 07. 19. 김상겸. - 비영리 카드/세금계산서 프로세스 개선에 따른 승인취소건 반영 제한 해제 */
				// if(val.sendYN == 'Y' || (val.georaeStat || '') === '0'){
				// 	$(tr).append('<td><input type="checkbox" id="chk_'+val.syncId+'" value="'+val.syncId+'" disabled="disabled"/>' + '</td>')	
				// }else{
				// 	$(tr).append('<td><input type="checkbox" id="chk_'+val.syncId+'" value="'+val.syncId+'"/>' + '</td>')
				// }
				
				if(val.sendYN === 'Y'){
					$(tr).append('<td><input type="checkbox" id="chk_'+val.syncId+'" value="'+val.syncId+'" disabled="disabled"/>' + '</td>')
				} else {
					$(tr).append('<td><input type="checkbox" id="chk_'+val.syncId+'" value="'+val.syncId+'"/>' + '</td>');
				}
				
				var showDate = val.authDate.substr(0,4)+ "-"+val.authDate.substr(4,2)+ "-"+val.authDate.substr(6,2)+ " " +val.authTime.substr(0,2) +":"+val.authTime.substr(2,2);
				val.showDate = showDate; 
				$(tr).append('<td>' + showDate + '</td>');
				$(tr).append('<td>' + val.authNum + '</td>');
				$(tr).append('<td class="le">' + '<a class="text_blue cardPop" style="text-decoration:underline;cursor:pointer;" title="법인카드 사용내역 상세 팝업보기">' + (val.partnerName || '') + '</a>' + '</td>');
				$(tr).append('<td>' + val.partnerNo + '</td>');
				$(tr).append('<td>' + val.cardName + '</td>');
				var cardNumTxt = val.cardNum.replaceAll('-', '');
				var firstCardNum = cardNumTxt.substr(0,4);
				var secCardNum = cardNumTxt.substr(4,4);
				var thirdCardNum = cardNumTxt.substr(8,4);
				var fourthCardNum = cardNumTxt.substr(12,4);

				var cardDispOption = '0';
				try{
					cardDispOption = optionSet.gw[1][1].setValue;
				}catch(e){
					cardDispOption = '0';
				}
				
				if(cardDispOption == '0'){
					secCardNum = '****';
					thirdCardNum = '****';
				}
				
				cardNumTxt = firstCardNum + '-' + secCardNum + '-' + thirdCardNum + '-' + fourthCardNum;
				$(tr).append('<td>' + cardNumTxt + '</td>');
				
				// if((val.georaeStat || '') === '1')
				if(['N', '1'].indexOf(val.georaeStat) > -1)
				{
					/* 승인 내역 처리 */
					$(tr).append('<td class="ri">' + val.reqAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>');
					$(tr).append('<td class="ri">' + val.stdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>');
					$(tr).append('<td class="ri">' + val.vatAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '</td>');
				}
				else {
					/* 취소 내역 처리 */
					$(tr).append('<td class="ri" style="color:red;">' + (val.reqAmt.toString().indexOf('-') > -1 ? val.reqAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') : '-' + val.reqAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')) + '</td>');
					$(tr).append('<td class="ri" style="color:red;">' + (val.stdAmt.toString().indexOf('-') > -1 ? val.stdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') : '-' + val.stdAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')) + '</td>');
					$(tr).append('<td class="ri" style="color:red;">' + (val.vatAmt.toString().indexOf('-') > -1 ? val.vatAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') : '-' + val.vatAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')) + '</td>');
				}
				
				// 상배 : 상세팝업 보기 추가
				$(tr).find('.cardPop').click(function(){
					var popup = window.open("../../../expend/np/user/UserCardDetailPop.do?syncId=" + val.syncId, "" , "width=432, height=489 , scrollbars=yes");						
				});
				
				$("#tblCardHistory").append(tr);
				cardData[val.syncId] = val;
			});
			
			/* 테이블 - 테이블 행 클릭 */
			$("#tblCardHistory tbody tr").on("click",function(e){
				clickCount++;
				var clickElement = this;
				if(clickCount === 1){
					timeOut = setTimeout(function(){
						clickCount = 0;
						
					}, 200);
				}else{
					clickCount = 0;
					clearTimeout(timeOut);
				}
			});
		}	
	}
	
	/*	[공용] 결재 상태 적용
	---------------------------------------- */
	function fnGetDocStatusLabel(value){
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
		fnCardHistoryReflect();
	}
	
	/* 카드사용내역 반영 */
	function fnCardHistoryReflect(){
		var chkSels = new Array();
		$.each($(".chk_targetData:checked"),function(idx,val){
			if($(this).attr("value") == 'on'){
				return true;
			}
			chkSels.push($(this).attr("value")); 
		});
		
		if( chkSels.length == 0 ){
			alert("카드 내역을 선택 후 반영하여주시길 바랍니다.");
			return false;
		}
		
		$("#btnReflect").unbind("click");

		var returnData = new Array();
		
		for(var i = 0 ; i < chkSels.length ; i++){
			var tData = {
				trName: cardData[chkSels[i]].partnerName,
				cardNum: cardData[chkSels[i]].cardNum,
				trSeq: cardData[chkSels[i]].tradeNo,
				addr : cardData[chkSels[i]].addr,
                empSeq: '',
                empName: '',
                etcCode: '',
                etcName: '',
                bizIncomCode: '',
                bizIncomName: '',
                ceoName: cardData[chkSels[i]].tradeCEO||'',
                tradeAmt: (['Y', '0'].indexOf(cardData[chkSels[i]].georaeStat) > -1 ? '-' + cardData[chkSels[i]].reqAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',').replace('-','') : cardData[chkSels[i]].reqAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')),
                payAmt: 0,
                tradeStdAmt: (['Y', '0'].indexOf(cardData[chkSels[i]].georaeStat) > -1 ? '-' + (cardData[chkSels[i]].stdAmt + cardData[chkSels[i]].serAmount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',').replace('-','') : (cardData[chkSels[i]].stdAmt + cardData[chkSels[i]].serAmount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')),
                realPayAmt: 0,
                tradeVatAmt: (['Y', '0'].indexOf(cardData[chkSels[i]].georaeStat) > -1 ? '-' + cardData[chkSels[i]].vatAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',').replace('-','') : cardData[chkSels[i]].vatAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')),
                payTaxAmt: 0,
                btrName: '',
                btrSeq: '',
                baNb: '',
                depositor: '',
                tradeNote: '',
                regDate: cardData[chkSels[i]].authDate.substr(0,4)+"-"+cardData[chkSels[i]].authDate.substr(4,2)+"-"+cardData[chkSels[i]].authDate.substr(6,2),
                resDocSeq: ${ViewBag.resDocSeq},
                resSeq: ${ViewBag.resSeq},
                budgetSeq: ${ViewBag.budgetSeq},
                tradeSeq: 0,
                businessNb: cardData[chkSels[i]].partnerNo||'', 
                interfaceType: 'card',
                interfaceSeq: cardData[chkSels[i]].syncId,
                noTaxCode : resultValue.noTaxCode||'',
                noTaxName : resultValue.noTaxName||'',
                payTrName : cardData[chkSels[i]].payTrName||'',
                payTrSeq : cardData[chkSels[i]].payTrSeq||'',
                
                /* 2018. 06. 25. 결의서 전표처리 시 미지급금 거래처가 공백으로 처리되는 문제점 보완 */
                ctrSeq: (cardData[chkSels[i]].cardCode || ''),	/* iCUBE G20 CTR_CD */
                ctrName: (cardData[chkSels[i]].cardName || '')	/* iCUBE G20 CTR_NM */
			};
			
			if(${ViewBag.vatFgCode} == '4' && tData.noTaxCode=='' && tData.noTaxName == ''){
				alert('불공제 사유를 선택해주세요.');
				fnCommonCode('notax','','');
				return false;
			}
			returnData.push(tData);
		}
		
		/* 윈도우 팝업 콜백 */
		var callbackFunc = window.opener["${ViewBag.callbackName}"];
		if( typeof(callbackFunc) == "function" ){ 
			callbackFunc(returnData);
			self.close();
		}else{
			window.location.reload();
		}
	}
	
	/*	[전송 리스트] 체크박스 전체 체크
	--------------------------------------------*/
	function fnAllChk(){
		if($("#all_chk").prop("checked")) { 
			$("#tblCardHistory input[type=checkbox]").not(":disabled").prop("checked",true); 
		} else { 
			$("#tblCardHistory input[type=checkbox]").not(":disabled").prop("checked",false);
		}
 	}
	
	/* 데이트 피커 설정 - 공통 변환 예정*/
	function fnSetDatepicker(id, format){
		$(id).datepicker({
	  		closeText: '닫기',
	        prevText: '이전달',
	        nextText: '다음달',
	        currentText: '오늘',
	        monthNames : [ '1${CL.ex_month}', '2${CL.ex_month}', '3${CL.ex_month}', '4${CL.ex_month}', '5${CL.ex_month}', '6${CL.ex_month}', '7${CL.ex_month}', '8${CL.ex_month}', '9${CL.ex_month}', '10${CL.ex_month}', '11${CL.ex_month}', '12${CL.ex_month}' ],
			monthNamesShort : [ '1${CL.ex_month}', '2${CL.ex_month}', '3${CL.ex_month}', '4${CL.ex_month}', '5${CL.ex_month}', '6${CL.ex_month}', '7${CL.ex_month}', '8${CL.ex_month}', '9${CL.ex_month}', '10${CL.ex_month}', '11${CL.ex_month}', '12${CL.ex_month}' ],
			dayNames : [ '${CL.ex_sun}', '${CL.ex_mon}', '${CL.ex_tue}', '${CL.ex_wed}', '${CL.ex_thu}', '${CL.ex_fri}', '${CL.ex_sat}' ],
			dayNamesShort : [ '${CL.ex_sun}', '${CL.ex_mon}', '${CL.ex_tue}', '${CL.ex_wed}', '${CL.ex_thu}', '${CL.ex_fri}', '${CL.ex_sat}' ],
			dayNamesMin : [ '${CL.ex_sun}', '${CL.ex_mon}', '${CL.ex_tue}', '${CL.ex_wed}', '${CL.ex_thu}', '${CL.ex_fri}', '${CL.ex_sat}' ],
	        weekHeader: 'Wk',
	        firstDay: 0,
	        isRTL: false,
	        duration:200,
	        showAnim:'show',
	        showMonthAfterYear: true,
			dateFormat: format
		});
	}
	
	/* 카드정보 팝업 창 호출 */ 
	function fnCardInfoPop() {
		var code = 'card';
		var parameter = {};
		
		parameter.checkedCardInfo = ($("#hidCardInfo").val() || '');
		parameter.widthSize = "728";
		parameter.heightSize = "580";
		
		fnCallCommonCodePop ( {
			code: code,
			popupType: 2,
			param: JSON.stringify ( parameter ),
			callbackFunction: "fnCommonPopCallback"
		 } );	 
	}
	
	/* 카드정보 팝업 콜백 */
	function fnCommonPopCallback( param ) {
		var cardCodeHidden = '';
		var cardNameDisplay = ''; 
			
		for(var i=0; i<param.length; i++) {
			var cardCode = param[i].split("|")[0];
			var cardName = param[0].split("|")[1];
			
			cardCodeHidden += "'" + cardCode + "',";
		}
		
		if( (param.length-1) == 0 ) {
			cardNameDisplay = cardName;
		} else {
			cardNameDisplay = cardName + " 외 " + (param.length - 1);	
		}
		
		$("#txtCardInfo").val(cardNameDisplay);
		$("#hidCardInfo").val(cardCodeHidden);
	}
</script>



<div class="pop_wrap" style="width:958px;">
	<div class="pop_head">
		<h1>${CL.ex_cardUseHistory}  <!--카드사용내역--></h1>
<!-- 		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a> -->
	</div>	
	
	<div class="pop_con div_form">
		<!-- 검색영역 -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_dateApproval}  <!--승인일시--></dt>
				<dd>
					<div class="dal_div">
						<input id="txtFromDate" type="text" value="2017-02-01" class="w113"/>
						<a href="#n" id="btnFromDate" class="button_dal"></a>
					</div>
					~
					<div class="dal_div"> 
						<input id="txtToDate" type="text" value="2017-02-01" class="w113"/>
						<a href="#n" id="btnToDate" class="button_dal"></a>
					</div>
				</dd>
<!-- 				<dd> -->
<!-- 					<select class="selectmenu" id="selSearchType" style="width:90px;"> -->
<!-- 						<option value="" selected="selected">전체</option> -->
<!-- 						<option value="partner">사용처</option> -->
<!-- 						<option value="cardName">카드명</option> -->
<!-- 						<option value="cardNum">카드번호</option> -->
<!-- 					</select> -->
<!-- 					<input id="txtSearchStr" type="text" style="width:200px;" value=""/> -->
<!-- 				</dd> -->
				<dt>${CL.ex_cardInfo}  <!--카드정보--></dt>
				<dd>
					<input id="txtCardInfo" type="text" style="width:290px;" readonly/>
					<input id="hidCardInfo" type="hidden" value=""/>
					<input id="btnCardInfo" type="button" class="normal_btn" value="${CL.ex_select}"/>  <!--선택-->
				</dd>
				<dt style="display:none;">${CL.ex_reflectionWhether}  <!--반영여부--></dt>
				<dd style="display:none;">
					<select id="selSendYN" class="selectmenu" style="width:80px;">
						<option value="">${CL.ex_all}  <!--전체--></option>
						<option value="Y">${CL.ex_reflection}  <!--반영--></option>
						<option value="N" selected="selected">${CL.ex_noReflection}  <!--미반영--></option>
					</select>
				</dd>
				<dd><input type="button" id="btnSearch" value="${CL.ex_search}" /></dd>  <!--검색-->
			</dl>
			
			<span class="btn_Detail">${CL.ex_detailSearch}  <!--상세검색--><img id="all_menu_btn"
					  src='../../../Images/ico/ico_btn_arr_down01.png' />
			</span>
		</div>
		<div class="SearchDetail">
			<dl>
				<dt style="width:54px;">${CL.ex_useArea}  <!--사용처--></dt>
				<dd style="width:250px;">
					<input id="txtMercName" type="text" style="width:247px;"/>
				</dd>
				<dt style="width:75px;">${CL.ex_businessNumber}  <!--사업자번호--></dt>
				<dd style="width:250px;">
					<input id="txtOwnerRegNo" type="text" style="width:293px;"/>
				</dd>
			</dl>
			
		</div>
		<!-- 버튼 -->
		<div class="btn_div cl">
			<div class="left_div fwb mt5">
				${CL.ex_yeCount} <span class="" id="cardHistoryCnt">-</span> ${CL.ex_gun}
			</div>			
			
			
			<div class="right_div">							
				<div class="controll_btn p0">
					<button id="btnReflect">${CL.ex_reflection}  <!--반영--></button>
				</div>
			</div>
		</div>
		
		<div class="com_ta2 ova_sc2 bg_lightgray Hsize">
			<table id="tblCardHistory">
			</table>		
		</div>
	</div><!--// pop_con -->

</div><!--// pop_wrap -->
