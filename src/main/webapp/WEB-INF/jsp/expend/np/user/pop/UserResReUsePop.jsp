<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="currentTime" class="java.util.Date" />
<jsp:include page="../include/UserOptionMap.jsp" flush="false" />
<jsp:include page="../../../../common/cmmJunctionCodePop.jsp" flush="false" />

<script>
	// 결의서 재기안
	// ERPType : ${ERPType}
	// ViewBag : ${ViewBag}
	// ResGisu : ${ResGisu}
	// EmpInfo : ${EmpInfo}

	// 기수정보 : ${ResGisu.erpGisu}기 (${ResGisu.erpGisuFromDate} ~ ${ResGisu.erpGisuToDate})
	// 발의일자 : ${ResGisu.expendDate}

	// 파라미터 : ${param}
	// 양식정보 : ${OriFormInfo}

	var gResDoc;
	var gResHead;
	var gResBudget;
	var gResTrade;
	var gResItemSpec;
	var gStat = true;
	var gStatMsg = '';
	var gReUseInterfaceChk = false;
	var gRemoveTradeCount = 0;

	var Util = {
		Format : {
			Date : function(value, spliter) {
				value = (value || '');
				spliter = (spliter || '-');
				var year = '', month = '', date = '';

				if (value.length === 8) {
					year = value.substr(0, 4);
					month = value.substr(4, 2);
					date = value.substr(6, 2);

					value = [ year, month, date ].join(spliter);
				} else {
					value = '';
				}

				return value;
			},
			GisuDisp : function(gisu, fromDate, toDate) {
				gisu = (gisu || '0');
				fromDate = ((fromDate || '').toString().replace(/-/g, ''));
				toDate = ((toDate || '').toString().replace(/-/g, ''));

				return [ gisu, '기 (', Util.Format.Date(fromDate, '.'), ' ~ ', Util.Format.Date(toDate, '.'), ')' ].join('');
			}
		}
	};

	// document ready
	$(document).ready(function() {
		//window.resizeTo(618, 460);
		window.resizeTo(622, 461);
		fnInit();
		fnEventInit();
	});

	// init
	function fnInit() {
		setTimeout(function(){ 
			// FOOTER
			$('.pop_foot').css('position', '');
			$('.pop_foot').css('bottom', '1px');
	 	}, 50);
		
		// 기수정보
		if('${ERPType}' == 'ERPiU'){
			$('.com_ta table tr:first').hide();
		} else {
			$('.com_ta table tr:first td:first').html(Util.Format.GisuDisp('${ResGisu.erpGisu}', '${ResGisu.erpGisuFromDate}', '${ResGisu.erpGisuToDate}'));
		}
		
		

		// 발의일자
		$('#txtExpendDate').datepicker({
			closeText : '닫기',
			prevText : '이전달',
			nextText : '다음달',
			currentText : '오늘',
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			weekHeader : 'Wk',
			firstDay : 0,
			isRTL : false,
			duration : 200,
			showAnim : 'show',
			showMonthAfterYear : true,
			dateFormat : 'yy-mm-dd',
			minDate : Util.Format.Date('${ResGisu.erpGisuFromDate}'.replace(/-/g, ''), '-'),
			maxDate : Util.Format.Date('${ResGisu.erpGisuToDate}'.replace(/-/g, ''), '-')
		});
		$('#txtExpendDate').val(Util.Format.Date('${ResGisu.expendDate}'.replace(/-/g, ''), '-'));
 
		return;
	}

	// event init
	function fnEventInit() {

		// 발의일자
		$('#txtExpendDate').next('a:first').click(function() {
			$('#txtExpendDate').datepicker('show');
		});

		// ${CL.ex_check}
		$('#btnConfirm').click(function() {
			fnResReUse();
			return;
		});

		// 취소
		$('#btnCancel').click(function() {
			self.close();
			return;
		});
		return;
	}

	// confirm
	function fnSetResReUseStatus(result) {
		if (result) {
			if (result.result) {
				if (result.result.resultCode) {
					if (result.result.resultCode == 'SUCCESS') {
						return;
					} else if (result.result.resultCode == 'EXCEED') {
						gStatMsg = '예산잔액이 초과되었습니다.';
					} else {
						gStatMsg = result.result.resultName.toString();
					}
				}
			}
		}

		gStat = false;
		gStatMsg = (gStatMsg == '' ? '재기안 데이터 생성 과정에서 오류가 발생되었습니다.' : (gStatMsg || ''));
		return;
	}

	function fnResReUse() {
		var ResReUseParam = {};
		ResReUseParam.resDocSeq = '${ViewBag.resDocSeq}';

		$.ajax({
			async : false,
			type : "post",
			data : ResReUseParam,
			url : "<c:url value='/expend/np/user/ResReUseInfo.do' />",
			datatype : "json",
			success : function(result) {
				fnSetResReUseStatus(result);
				var aData = (result.result.aData || {});

				gResDoc = aData.resDoc;
				gResDoc.erpBudgetDivSeq = gResDoc.erpDivSeq;
				gResDoc.outProcessInterfaceId = null;
				gResDoc.outProcessInterfaceMId = null;
				gResDoc.outProcessInterfaceDId = null;
				gResDoc.docStatus = null;

				gResItemSpec = aData.resItem;

				gResHead = aData.resHead;
				$.each(gResHead, function(idx, item){
					if($('#confferN').is(':checked')){
						item.confferDocSeq = null;
						item.confferSeq = null;
					}
				});
				gResBudget = aData.resBudget;
				$.each(gResBudget, function(idx, item){
					if($('#confferN').is(':checked')){
						item.confferDocSeq = null;
						item.confferSeq = null;
						item.confferBudgetSeq = null;
					}
				});
				
				gResTrade = [];
				$.each(aData.resTrade, function(idx, item){
					if((item.interfaceType == 'etax' && ( item.sendYn == '' || item.sendYn == 'N' ))
						|| (item.interfaceType == 'card' && (item.cardSendYn == '' || item.cardSendYn == 'N'))
						|| (item.interfaceType||'') == ''){
						gResTrade.push(item);
					} else if(item.interfaceType == 'etax' || item.interfaceType == 'card'){
						gRemoveTradeCount++;
					}
				});

				if(gResTrade.length > 0) {
					fnResDocMake(ResReUseParam);
					fnResReUsePop();
					
					if(gRemoveTradeCount > 0) {
						alert('결제내역 중 일부가 타 결의서에 사용되어 제외처리 되었습니다. 결제내역을 ${CL.ex_check}하시기 바랍니다.');
					}
				} else {
						alert('결제내역이 모두 사용되어 재기안 할 수 없습니다.');
				}
			},
			error : function(err) {
				alert("데이터 조회 중 오류가 발생하였습니다.");
				console.log(err);
			}
		});

		return;
	}
	
	function fnResDocMake(ResReUseParam) {
		var resDocMakeParma = {};
		resDocMakeParma.resdocNote = gResDoc.resdocNote;
		resDocMakeParma.erpCompSeq = gResDoc.erpCompSeq;
		resDocMakeParma.erpDeptSeq = gResDoc.erpDeptSeq;
		resDocMakeParma.erpEmpSeq = gResDoc.erpEmpSeq;
		resDocMakeParma.erpGisu = gResDoc.erpGisu;
		resDocMakeParma.erpExpendYear = gResDoc.erpExpendYear;
		resDocMakeParma.compSeq = gResDoc.compSeq;
		resDocMakeParma.compName = gResDoc.compName;
		resDocMakeParma.deptSeq = gResDoc.deptSeq;
		resDocMakeParma.deptName = gResDoc.deptName;
		resDocMakeParma.empSeq = gResDoc.empSeq;
		resDocMakeParma.empName = gResDoc.empName;
		resDocMakeParma.empSeq = gResDoc.empSeq;
		resDocMakeParma.erpDivSeq = gResDoc.erpDivSeq;
		resDocMakeParma.erpDivName = gResDoc.erpDivName;
		resDocMakeParma.outProcessInterfaceId = gResDoc.outProcessInterfaceId;
		resDocMakeParma.outProcessInterfaceMId = gResDoc.outProcessInterfaceMId;
		resDocMakeParma.outProcessInterfaceDId = gResDoc.outProcessInterfaceDId;
		resDocMakeParma.confferDocSeq = gResDoc.confferDocSeq;
		resDocMakeParma.formSeq = gResDoc.formSeq;
		
		resDocMakeParma = $.extend(ResReUseParam, resDocMakeParma);
		
		$.ajax({
			type : 'post',
			url : "<c:url value='/ex/np/user/res/ResDocInsert.do' />",
			datatype : 'json',
			async : false,
			data : resDocMakeParma,
			resDocMakeParma: resDocMakeParma,
			success : function(result) {
				fnSetResReUseStatus(result);
				
				var resDocSeq = result.result.aData.resDocSeq;
				gResDoc.resDocSeq = resDocSeq;

				$.each(gResHead, function(idx, item) {
					item.resDocSeq = resDocSeq;
					item.erpMgtSeq = item.mgtSeq;
					item.erpMgtName = item.mgtName;
				});

				$.each(gResBudget, function(idx, item) {
					item.resDocSeq = resDocSeq;
				});
				
				$.each(gResTrade, function(idx, item) {
					item.resDocSeq = resDocSeq;
				});

				fnResHeadMake(ResReUseParam);
			},
			error : function(result) {
				console.error(result);
			}
		});
		
		return;
	}
	
	function fnResHeadMake(ResReUseParam) {
		var oldResSeq = '';
		
		var resHeadMake = function(resHeadMakeParam){
			resHeadMakeParam.resDate = ($('#txtExpendDate').val() || '').toString().replace(/-/g, '');
			resHeadMakeParam.expendDate = ($('#txtExpendDate').val() || '').toString().replace(/-/g, '');
			resHeadMakeParam = $.extend($.extend(ResReUseParam, gResDoc), resHeadMakeParam);
			
			var reUseTradeCount = 0;
			$.each(gResTrade, function(idx, item){
				if(item.resSeq == resHeadMakeParam.resSeq){
					reUseTradeCount++;
				}
			});
			
			if(reUseTradeCount < 1) {
				gReUseInterfaceChk = true;
				return;
			}
			
			$.ajax({
				type : 'post',
				url : "<c:url value='/ex/np/user/res/ResHeadInsert.do' />",
				datatype : 'json',
				async : false,
				data : resHeadMakeParam,
				// erpDivSeq: param.erpDivSeq,
				// erpBudgetSeq: param.erpBudgetSeq,
				success : function(result) {
					fnSetResReUseStatus(result);
					var resSeq = result.result.aData.resSeq;

					$.each(gResBudget, function(idx, item) {
						if(item.resSeq === oldResSeq){
							item.resSeq = resSeq;
						}
					});
					
					$.each(gResTrade, function(idx, item) {
						if(item.resSeq === oldResSeq){
							item.resSeq = resSeq;
						}
					});

					$.each(gResHead, function(idx, item) {
						if(item.resSeq === oldResSeq){
							item.resSeq = resSeq;
						}
					});

					$.each(gResItemSpec, function(idx, item) {
						if(item.resSeq === oldResSeq){
							item.resSeq = resSeq;
						}
					});
					if('${ERPType}' == 'iCUBE') {
						/*iCUBE일 경우 물품명세가 결의정보에 위치하므로 budgetSeq가 필요없음 */
						fnResItemSpecMakeForiCUBE(resSeq, gResItemSpec, gResDoc);
					}
					fnResBudgetMake(resSeq, ResReUseParam, gResDoc, resHeadMakeParam);
				},
				error : function(result) {
					console.error(result);
				}
			});
		}
		
		for(var i=0; i<gResHead.length; i++){
			var resHead = gResHead[i];
			oldResSeq = resHead.resSeq;
			resHeadMake(resHead);
		}
		
		return;
	}

	function fnResBudgetMake(resSeq, ResReUseParam, gResDoc, resHeadMakeParam){
		var oldBudgetSeq = '';
		
		var resBudgetMake = function(resBudgetMakeParam){
			
			resBudgetMakeParam = $.extend($.extend($.extend($.extend(ResReUseParam, gResDoc), resHeadMakeParam), resHeadMakeParam), resBudgetMakeParam);
			
			/* Nullable 데이터 보정 */
			resBudgetMakeParam.erpResAmt = resBudgetMakeParam.erpResAmt || '0';
			resBudgetMakeParam.erpBkSeq = resBudgetMakeParam.erpBkSeq || '0';
			resBudgetMakeParam.erpBqSeq = resBudgetMakeParam.erpBqSeq || '0';
			
			if( (resBudgetMakeParam.confferDocSeq||'') == ''){
				resBudgetMakeParam.confferDocSeq = undefined;
				resBudgetMakeParam.confferSeq = undefined;
				resBudgetMakeParam.confferBudgetSeq = undefined;
			} 
			
			var budgetInfoInsert = function(){
				$.ajax({
					type : 'post',
					url : "<c:url value='/ex/np/user/res/ResBudgetInsert.do' />",
					datatype : 'json',
					async : false,
					data : resBudgetMakeParam,
					// erpDivSeq: erpDivSeq,
					// erpBudgetSeq: erpBudgetSeq,
					resBudgetMakeParam: resBudgetMakeParam,
					success : function(result) {
						fnSetResReUseStatus(result);
						var budgetSeq = result.result.aData.budgetSeq;
						
						$.each(gResTrade, function(idx, item) {
							if(item.budgetSeq === oldBudgetSeq){
								item.budgetSeq = budgetSeq;
							}
						});
						
						var aData = result.result.aData;
						$.each(gResBudget, function(idx, item) {
							if(item.budgetSeq === oldBudgetSeq){
								item.budgetSeq = budgetSeq;
								
								item.amt = aData.amt;
								item.budgetAmt = aData.budgetAmt;
								item.consBalance = aData.conBalance;
								item.stdAmt = aData.stdAmt;
								item.taxAmt = aData.taxAmt;
								item.tryAmt = aData.tryAmt;
							}
						});

						$.each(gResItemSpec, function(idx, item) {
							if(item.budgetSeq === oldBudgetSeq){
								item.budgetSeq = budgetSeq;
							}
						});
						if('${ERPType}' == 'ERPiU') {
							/*iu일 경우 물품명세가 예산내역에 위치하므로 budgetSeq가 필요 */
							fnResItemSpecMakeForiU(budgetSeq, resSeq, gResItemSpec, gResDoc);
						}
						fnResTradeMake(budgetSeq, resSeq, ResReUseParam, gResDoc, resHeadMakeParam, this.resBudgetMakeParam, result.result.aData.budgetAmt);
					},
					error : function(result) {
						console.error(result);
					}
				});
			};
			
			var budgetInfoSelect = function(){
				$.ajax({
					type : 'post',
					url : "<c:url value='/ex/np/user/res/resBudgetInfoSelect.do' />",
					datatype : 'json',
					async : false,
					data : resBudgetMakeParam,
					success : function(result) {
						var aData = (result.result.aData || {});
						var resultCode = (result.result.resultCode || '');
						if (resultCode === 'SUCCESS') {
							var erpOpenAmt = 0
								, erpApplyAmt = 0
								, budgetTableResAmt = 0
								, gwBalanceAmt = 0
								, resApplyAmt = 0
								, consBalanceAmt = 0
								, erpLeftAmt = 0
								, budgetTableConsAmt = 0
								, budgetAmt = 0;
							
							erpOpenAmt = Number((aData.openAmt || '').toString().replace(/,/g, ''));
							erpApplyAmt = Number((aData.applyAmt || '').toString().replace(/,/g, ''));
							budgetTableResAmt = Number((aData.budgetTableResAmt || '').toString().replace(/,/g, ''));
							gwBalanceAmt = Number((aData.balanceAmt || '').toString().replace(/,/g, ''));
							resApplyAmt = Number((aData.resApplyAmt || '').toString().replace(/,/g, ''));
							consBalanceAmt = Number((aData.consBalanceAmt || '').toString().replace(/,/g, ''));
							erpLeftAmt = Number((aData.erpLeftAmt || '').toString().replace(/,/g, ''));
							budgetTableConsAmt = Number((aData.budgetTableConsAmt || '').toString().replace(/,/g, ''));
							budgetAmt = Number((aData.tryAmt || '').toString().replace(/,/g, ''));
							
							aData.erpOpenAmt = erpOpenAmt;
							/* 금회집행 */
							aData.budgetAmt = budgetAmt;
							/* 예산잔액 / 품의잔액 */
							aData.gwBalanceAmt = gwBalanceAmt;

							/* 예산정보 반영 */
							delete aData['budgetAmt'];
							resBudgetMakeParam = $.extend(resBudgetMakeParam, aData);
							
							budgetInfoInsert();
						} else {
							alert('예산 조회 중 알 수 없는 오류가 발생되었습니다.');
						}
					},
					/*   - error :  */
					error : function(result) {
						console.error(result);
					}
				});
			};
			
			/* 참조품의 포함인 경우 */
			if($('#confferY').is(':checked')){
				if((resBudgetMakeParam.confferBudgetSeq || '') != '' && (resBudgetMakeParam.confferDocSeq || '') != '') {
					budgetInfoSelect();
				} else {
					budgetInfoInsert();
				}
			} else {
				budgetInfoInsert();
			}
		}
		
		for(var i=0; i<gResBudget.length; i++){
			if(resSeq == gResBudget[i].resSeq){
				var resBudget = gResBudget[i];
				oldBudgetSeq = resBudget.budgetSeq;
				resBudget.expendDate = $('#txtExpendDate').val().toString().replace(/-/g, '');
				resBudget.erpGisuDate = $('#txtExpendDate').val().toString().replace(/-/g, '');
				resBudget.gisu = '${ResGisu.erpGisu}';
				resBudget.erpMgtSeq = resHeadMakeParam.erpMgtSeq;
				resBudgetMake(resBudget);
			}
		}
		
		return;
	}
	
	/*	[데이터 보정]	DB자료형 int 대응, 기본 값 처리
	-------------------------------------------- */
	function fnDataCurrection(parameter){
		parameter.etcRequiredAmt = parameter.etcRequiredAmt || '0'; 
		parameter.etcIncomeAmt = parameter.etcIncomeAmt || '0';
		parameter.etcIncomeVatAmt = parameter.etcIncomeVatAmt || '0';
		parameter.etcResidentVatAmt = parameter.etcResidentVatAmt || '0';
		parameter.etcSchoolAmt = parameter.etcSchoolAmt || '0';
		parameter.erpInSq = parameter.erpInSq || '0';
		parameter.erpBqSq = parameter.erpBqSq || '0';
		parameter.tradeAmt = parameter.tradeAmt || '0';
		parameter.tradeStdAmt = parameter.tradeStdAmt || '0';
		parameter.tradeVatAmt = parameter.tradeVatAmt || '0';
		parameter.budgetNote = parameter.budgetNote.replaceAll('\\','');
		parameter.erpBqSeq = parameter.erpBqSeq || '0';
		parameter.erpBkSeq = parameter.erpBkSeq || '0';
		parameter.budget_std_amt = parameter.budget_std_amt || '0';
		return parameter;
	}

	/*iCUBE 물품명세*/
	function fnResItemSpecMakeForiCUBE(resSeq, gResItemSpec, gResDoc){

		var resItemSpec = [];

		var resItemSpecMake = function(resItemSpec) {
			var resItemSpecMakeParam = $.extend({"budgetSeq":0},{"resSeq":resSeq}, gResDoc);
			resItemSpecMakeParam.innerData = JSON.stringify(resItemSpec);

			$.ajax({
				type: 'post',
				url: "<c:url value='/ex/np/user/res/ResItemSpecInsert.do' />",
				datatype: 'json',
				async: false,
				data: resItemSpecMakeParam,
				success: function (result) {
					fnSetResReUseStatus(result);
				},
				error: function (result) {
					console.error(result);
				}
			});
		}

		for(var i=0; i<gResItemSpec.length; i++) {
			if (resSeq == gResItemSpec[i].resSeq) {
				gResItemSpec[i].resDocSeq = gResDoc.resDocSeq;
				resItemSpec.push(gResItemSpec[i]);
			}
		}
		resItemSpecMake(resItemSpec);

		return;
	}

	/*iU 물품명세*/
	function fnResItemSpecMakeForiU(budgetSeq, resSeq, gResItemSpec, gResDoc){

		var resItemSpec = [];

		var resItemSpecMake = function(resItemSpec) {
			var resItemSpecMakeParam = $.extend({"budgetSeq":budgetSeq},{"resSeq":resSeq}, gResDoc);
			resItemSpecMakeParam.innerData = JSON.stringify(resItemSpec);

			$.ajax({
				type: 'post',
				url: "<c:url value='/ex/np/user/res/ResItemSpecInsert.do' />",
				datatype: 'json',
				async: false,
				data: resItemSpecMakeParam,
				success: function (result) {
					fnSetResReUseStatus(result);
				},
				error: function (result) {
					console.error(result);
				}
			});
		}

		for(var i=0; i<gResItemSpec.length; i++) {
			if (budgetSeq == gResItemSpec[i].budgetSeq) {
				gResItemSpec[i].resDocSeq = gResDoc.resDocSeq;
				resItemSpec.push(gResItemSpec[i]);
			}
		}
		resItemSpecMake(resItemSpec);

		return;
	}

	function fnResTradeMake(budgetSeq, resSeq, ResReUseParam, gResDoc, resHeadMakeParam, resBudgetMakeParam, budgetAmt) {
		var oldTradeSeq = '';
		
		var resTradeMake = function(resTradeMakeParam) {
			
			resTradeMakeParam = $.extend($.extend($.extend($.extend($.extend(ResReUseParam, gResDoc), resHeadMakeParam), resHeadMakeParam), resBudgetMakeParam), resTradeMakeParam);
			resTradeMakeParam = fnDataCurrection(resTradeMakeParam);
			$.ajax({
				type : 'post',
				url : "<c:url value='/ex/np/user/res/ResTradeInsert.do' />",
				datatype : 'json',
				async : false,
				data : resTradeMakeParam,
				success : function(result) {
					console.log(result.result);
					
					fnSetResReUseStatus(result);
					var tradeSeq = result.result.aData.tradeSeq;
					
					$.each(gResTrade, function(idx, item) {
						if(item.tradeSeq === oldTradeSeq){
							item.tradeSeq = tradeSeq;
						}
					});
				},
				error : function(result) {
					console.error(result);
				}
			})
		}
		
		var amt = 0;
		
		for(var i=0; i<gResTrade.length; i++){
			if(budgetSeq == gResTrade[i].budgetSeq){
				var resTrade = gResTrade[i];
				
				oldTradeSeq = resTrade.tradeSeq;
				
				amt = Number(amt) + Number(resTrade.tradeAmt);
				resTrade.amt = amt;
				
				resTrade.expendDate = $('#txtExpendDate').val().toString().replace(/-/g, '');
				resTrade.erpGisuDate = $('#txtExpendDate').val().toString().replace(/-/g, '');
				resTrade.gisu = '${ResGisu.erpGisu}';
				resTrade.budgetAmt = budgetAmt;
				resTrade.acctNo = resTrade.btrNb;
				resTrade.dpstName = resTrade.erpEmpName;
				resTrade.divSeq = resTrade.erpDivSeq;
				resTrade.divName = resTrade.erpDivName;
				resTradeMake(resTrade);
			}
		}
	}
	
	function fnResReUsePop(){
		if(gStat){
			/* 작성 팝업 전환 */
			var url = "<c:url value='/ExpendPop.do' />";
			url += '?form_id=' + '${OriFormInfo.form_id}';
			url += '&form_tp=' + '${ViewBag.formDTp}';
			url += '&processId=' + '${ViewBag.formDTp}';
			url += '&doc_width=' + '${OriFormInfo.doc_width}';
			url += '&eaType=' + '${OriFormInfo.eaType}';
			url += '&form_gb=' + '${OriFormInfo.form_gb}';
			url += '&oriDocId=' + '${OriFormInfo.oriDocId}';
			url += '&oriApproKey=' + '${OriFormInfo.oriApproKey}';
			url += '&copyAttachFile=' + '${OriFormInfo.copyAttachFile}';
			url += '&copyApprovalLine=' + '${OriFormInfo.copyApprovalLine}';
			url += '&initTitle=' + '${OriFormInfo.initTitle}';
			url += '&newResDocSeq=' + gResDoc.resDocSeq;
			location.replace(url);
		} else {
			/* 생성 데이터 삭제 처리 */
			alert(gStatMsg);
			return;
		}
	}
</script>

<div class="pop_wrap" style="width: 600px; height: 391px;">
	<div class="pop_head">
		<h1>${CL.ex_motionDateModify}  <!--발의일자 변경--></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>

	<div class="pop_con">
		<p class="lh18 mb10">※ ${CL.ex_motionDateComment}  <!--발의일자 변경 후 진행해주시기 바랍니다.--></p>

		<div class="com_ta">
			<table>
				<colgroup>
					<col width="130" />
					<col width="" />
				</colgroup>
				<tr>
					<th>${CL.ex_gisuInfo}  <!--기수정보--></th>
					<td>5기 (2017.01.01 ~ 2017.12.31)</td>
				</tr>
				<tr>
					<th>${CL.ex_motionDate}  <!--발의일자--></th>
					<td>
						<div class="dal_div">
							<input type="text" autocomplete="off" id="txtExpendDate" class="w113" readonly /> <a href="#n" class="button_dal"></a>
						</div>
					</td>
				</tr>
				<tr>
					<th>${CL.ex_confferConsDoc}  <!--참조품의서--></th>
					<td>
						<!-- <input type="radio" name="rdoGroup" value="" class="puddSetup" pudd-label="포함" checked /> -->
						<!-- <input type="radio" name="rdoGroup" value="" class="puddSetup" pudd-label="제외" /> -->
						<input name="rdoGroup" id="confferY" style="visibility: hidden;" type="radio" checked="">
						<label for="confferY">${CL.ex_inclusion}  <!--포함--></label>
						<input name="rdoGroup" class="ml10" id="confferN" style="visibility: hidden;" type="radio">
						<label for="confferN">${CL.ex_except}  <!--제외--></label>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!--// pop_con -->
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input id="btnConfirm" type="button" value="${CL.ex_check}" /> <input id="btnCancel" type="button" class="gray_btn" value="${CL.ex_cancel}" /><!--취소-->
		</div>
	</div>
	<!-- //pop_foot -->

</div>
<!--// pop_wrap -->
