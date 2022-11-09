<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:useBean id="currentTime" class="java.util.Date" />

<script>
	// 품의서 재기안
	// ERPType : ${ERPType}
	// ViewBag : ${ViewBag}
	// ConsGisu : ${ConsGisu}
	// EmpInfo : ${EmpInfo}

	// 기수정보 : ${ConsGisu.erpGisu}기 (${ConsGisu.erpGisuFromDate} ~ ${ConsGisu.erpGisuToDate})
	// 발의일자 : ${ConsGisu.expendDate}
	
	// 파라미터 : ${param}
	// 양식정보 : ${OriFormInfo}
	
	var gConsDoc;
	var gConsHead;
	var gConsBudget;
	var gConsItemSpec;
	var gStat = true;
	var gStatMsg = '';

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
		window.resizeTo(618, 460);
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
			$('.com_ta table tr:first td:first').html(Util.Format.GisuDisp('${ConsGisu.erpGisu}', '${ConsGisu.erpGisuFromDate}', '${ConsGisu.erpGisuToDate}'));
		}

		// 품의일자
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
			minDate : Util.Format.Date('${ConsGisu.erpGisuFromDate}'.replace(/-/g, ''), '-'),
			maxDate : Util.Format.Date('${ConsGisu.erpGisuToDate}'.replace(/-/g, ''), '-')
		});
		$('#txtExpendDate').val(Util.Format.Date('${ConsGisu.expendDate}'.replace(/-/g, ''), '-'));

		return;
	}

	// event init
	function fnEventInit() {

		// 품의일자
		$('#txtExpendDate').next('a:first').click(function() {
			$('#txtExpendDate').datepicker('show');
		});

		// ${CL.ex_check}
		$('#btnConfirm').click(function() {
			fnConsReUse();
			return;
		});

		// 취소
		$('#btnCancel').click(function() {
			fnCancel();
			return;
		});
		return;
	}

	// confirm
	function fnSetConsReUseStatus(result){
		if(result){
			if(result.result){
				if(result.result.resultCode){
					if(result.result.resultCode == 'SUCCESS') {
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
	
	function fnConsReUse() {
		var ConsReUseParam = {};
		ConsReUseParam.consDocSeq = '${ViewBag.consDocSeq}';

		$.ajax({
			async : true,
			type : "post",
			data : ConsReUseParam,
			url : "<c:url value='/expend/np/user/ConsReUseInfo.do' />",
			datatype : "json",
			success : function(result) {
				fnSetConsReUseStatus(result);
				var aData = (result.result.aData || {});

				gConsDoc = aData.consDoc;
				gConsDoc.outProcessInterfaceId = '';
				gConsDoc.outProcessInterfaceMId = '';
				gConsDoc.outProcessInterfaceDId = '';
				gConsDoc.erpBudgetDivSeq = gConsDoc.erpDivSeq;

				gConsHead = aData.consHead;

				gConsBudget = aData.consBudget;
				
				gConsItemSpec = aData.consItem;

				fnConsDocMake(ConsReUseParam);
				
				fnConsReUsePop();
			},
			error : function(err) {
				alert("데이터 조회 중 오류가 발생하였습니다.");
				console.log(err);
			}
		});
		
		return;
	}

	function fnConsDocMake(ConsReUseParam) {
		var consDocMakeParma = {};
		consDocMakeParma.consdocNote = gConsDoc.consdocNote;
		consDocMakeParma.erpCompSeq = gConsDoc.erpCompSeq;
		consDocMakeParma.erpDeptSeq = gConsDoc.erpDeptSeq;
		consDocMakeParma.erpEmpSeq = gConsDoc.erpEmpSeq;
		consDocMakeParma.erpGisu = gConsDoc.erpGisu;
		consDocMakeParma.erpExpendYear = gConsDoc.erpExpendYear;
		consDocMakeParma.compSeq = gConsDoc.compSeq;
		consDocMakeParma.compName = gConsDoc.compName;
		consDocMakeParma.deptSeq = gConsDoc.deptSeq;
		consDocMakeParma.deptName = gConsDoc.deptName;
		consDocMakeParma.empSeq = gConsDoc.empSeq;
		consDocMakeParma.empName = gConsDoc.empName;
		consDocMakeParma.empSeq = gConsDoc.empSeq;
		consDocMakeParma.erpDivSeq = gConsDoc.erpDivSeq;
		consDocMakeParma.erpDivName = gConsDoc.erpDivName;
		consDocMakeParma.outProcessInterfaceId = gConsDoc.outProcessInterfaceId;
		consDocMakeParma.outProcessInterfaceMId = gConsDoc.outProcessInterfaceMId;
		consDocMakeParma.outProcessInterfaceDId = gConsDoc.outProcessInterfaceDId;

		$.ajax({
			type : 'post',
			url : "<c:url value='/ex/np/user/cons/ConsDocInsert.do' />",
			datatype : 'json',
			async : false,
			data : consDocMakeParma,
			success : function(result) {
				fnSetConsReUseStatus(result);
				var consDocSeq = result.result.aData.consDocSeq;
				gConsDoc.consDocSeq = consDocSeq;

				$.each(gConsHead, function(idx, item) {
					item.consDocSeq = consDocSeq;
				});

				$.each(gConsBudget, function(idx, item) {
					item.consDocSeq = consDocSeq;
				});
				
				fnConsHeadMake(ConsReUseParam);
			},
			error : function(result) {
				console.error(result);
			}
		});
		
		return;
	}

	function fnConsHeadMake(ConsReUseParam) {
		var oldConsSeq = '';
		
		var consHeadMake = function(param){
			
			param.consDate = ($('#txtExpendDate').val() || '').toString().replace(/-/g, '');
			param = $.extend($.extend(ConsReUseParam, gConsDoc), param);
			
			$.ajax({
				type : 'post',
				url : "<c:url value='/ex/np/user/cons/ConsHeadInsert.do' />",
				datatype : 'json',
				async : false,
				data : param,
				mgtSeq: param.mgtSeq,
				success : function(result) {
					fnSetConsReUseStatus(result);
					var consSeq = result.result.aData.consSeq;

					$.each(gConsItemSpec, function(idx, item) {
						if(item.consSeq === oldConsSeq){
							item.consSeq = consSeq;
						}
					});

					$.each(gConsBudget, function(idx, item) {
						if(item.consSeq === oldConsSeq){
							item.consSeq = consSeq;
						}
					});
					
					$.each(gConsHead, function(idx, item) {
						if(item.consSeq === oldConsSeq){
							item.consSeq = consSeq;
						}
					});

					fnConsBudgetMake(consSeq, ConsReUseParam, gConsDoc, param);
					fnConsItemSpecMake(consSeq, gConsItemSpec, gConsDoc);
				},
				error : function(result) {
					console.error(result);
				}
			});
		}
		
		for(var i=0; i<gConsHead.length; i++){
			var consHead = gConsHead[i];
			oldConsSeq = consHead.consSeq;
			consHead.erpMgtSeq = consHead.mgtSeq;
			consHead.erpMgtName = consHead.mgtName;
			
			consHeadMake(consHead);
		}
		
		return;
	}
	
	// function fnConsBudgetMake(consSeq, mgtSeq){
	function fnConsBudgetMake(consSeq, ConsReUseParam, gConsDoc, consHeadMakeParam){
		var oldBudgetSeq = '';
		
		var consBudgetMake = function(consBudgetMakeParam){
			
			consBudgetMakeParam = $.extend($.extend($.extend($.extend(ConsReUseParam, gConsDoc), consHeadMakeParam), consHeadMakeParam), consBudgetMakeParam);
			
			consBudgetMakeParam = fnBudgetDataCurrection(consBudgetMakeParam);
			
			$.ajax({
				type : 'post',
				url : "<c:url value='/ex/np/user/cons/ConsBudgetInsert.do' />",
				datatype : 'json',
				async : false,
				data : consBudgetMakeParam,
				success : function(result) {
					fnSetConsReUseStatus(result);
					var budgetSeq = result.result.aData.budgetSeq;
					
					$.each(gConsBudget, function(idx, item) {
						if(item.budgetSeq === oldBudgetSeq){
							item.budgetSeq = budgetSeq;
						}
					});
					
				},
				error : function(result) {
					console.error(result);
				}
			});
		}
		
		for(var i=0; i<gConsBudget.length; i++){
			if(consSeq == gConsBudget[i].consSeq){
				var consBudget = gConsBudget[i];
				oldBudgetSeq = consBudget.budgetSeq;
				consBudget.expendDate = $('#txtExpendDate').val().toString().replace(/-/g, '');
				consBudget.gisu = '${ConsGisu.erpGisu}';
				consBudget.erpMgtSeq = consHeadMakeParam.mgtSeq;
				
				consBudgetMake(consBudget);
			}
		}
		
		return;
	}
	
	function fnConsItemSpecMake(consSeq, gConsItemSpec, gConsDoc){

		var consItemSpec = [];

		var consItemSpecMake = function(consItemSpec) {
			var consItemSpecMakeParam = $.extend({"budgetSeq":0}, {"consSeq":consSeq}, gConsDoc);
			consItemSpecMakeParam.innerData = JSON.stringify(consItemSpec);

			$.ajax({
				type: 'post',
				url: "<c:url value='/ex/np/user/cons/ConsItemSpecInsert.do' />",
				datatype: 'json',
				async: false,
				data: consItemSpecMakeParam,
				success: function (result) {
					fnSetConsReUseStatus(result);
				},
				error: function (result) {
					console.error(result);
				}
			});
		}

		for(var i=0; i<gConsItemSpec.length; i++){
			if(consSeq == gConsItemSpec[i].consSeq){
				gConsItemSpec[i].consDocSeq = gConsDoc.consDocSeq;
				consItemSpec.push(gConsItemSpec[i]);
			}
		}
		consItemSpecMake(consItemSpec);

		return;
	}
	
	function fnConsReUsePop(){
		if(gStat){
			// console.log('consDocSeq : ' + gConsDoc.consDocSeq);
			
			// $.each(gConsHead, function(idx, item){
			// 	console.log('consDocSeq : ' + item.consDocSeq + ' / consSeq : ' + item.consSeq);
			// });
			
			// $.each(gConsBudget, function(idx, item){
			// 	console.log('consDocSeq : ' + item.consDocSeq + ' / consSeq : ' + item.consSeq + ' / budgetSeq : ' + item.budgetSeq);
			// });
			
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
			url += '&newConsDocSeq=' + gConsDoc.consDocSeq;
			location.replace(url);
		} else {
			/* 생성 데이터 삭제 처리 */
			alert(gStatMsg);
			return;
		}
	}

	// cancel
	function fnCancel() {
		self.close();
	}
	
	/*	[데이터 보정]	DB자료형 int 대응, 기본 값 처리
	-------------------------------------------- */
	function fnBudgetDataCurrection(parameter){
		parameter.erpBqSeq = parameter.erpBqSeq || '0';
		parameter.erpBkSeq = parameter.erpBkSeq || '0';
		parameter.erpResAmt = parameter.erp_res_amt || '0';
		parameter.budgetStdAmt = parameter.budget_std_amt || '0';
		parameter.budgetTaxAmt = parameter.budget_tax_amt || '0';
		
		return parameter;
	}
</script>

<div class="pop_wrap" style="width: 600px; height: 391px">
	<div class="pop_head">
		<h1>${CL.ex_consDateModify}  <!--품의일자 변경--></h1>
		<a href="#n" class="clo"><img src="../../../Images/btn/btn_pop_clo01.png" alt="" /></a>
	</div>

	<div class="pop_con">
		<p class="lh18 mb10">※ ${CL.ex_consDateModifyComment}  <!--품의일자 ${CL.ex_check} 후 진행해주시기 바랍니다.--></p>

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
					<th>${CL.ex_consDate}  <!--품의일자--></th>
					<td>
						<div class="dal_div">
							<input type="text" autocomplete="off" id="txtExpendDate" class="w113" readonly /> <a href="#n" class="button_dal"></a>
						</div>
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