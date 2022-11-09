<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import="main.web.BizboxAMessage"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<!-- javascript - src -->
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.log.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.ajax.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.date.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.event.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.datatables.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCommonReport.js"></c:url>'></script>
<script src='${pageContext.request.contextPath}/js/ex/underscore.js'></script>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/np/jquery.ucgridtable.1.0.js'></script>
<link rel="stylesheet" type="text/css" href='${pageContext.request.contextPath}/css/pudd.css'></link>
<script type="text/javascript" src='${pageContext.request.contextPath}/js/pudd/pudd-1.1.192.min.js'></script>
<!-- javascript -->
<script>

	/* ## 변수정의 ## */
	/* ====================================================================================================================================================== */
	var SearchKeyCode = [ '13', '113' ];
	var SearchDateFormat = [ 'issDateFrom', 'issDateTo', 'partnerRegNo' ]; /* "-" 제거 처리 */

	/* ## 공통함수 정의 ## */
	/* ====================================================================================================================================================== */
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
				var parameters = {};

				if (Common.iCUBE()) {
					parameters = {
						/* 작성일자 From */
						issDateFrom : ($('#txtFromDate').val() || ''),
						/* 작성일자 To */
						issDateTo : ($('#txtToDate').val() || ''),
						/* 공급자 */
						partnerName : ($('#txtPartnerName').val() || ''),
						/* 결의상태 */
						eTaxStat : ($('#selSendType').val() || ''),
						/* 사업자등록번호 */
						partnerRegNo : ($('#txtPartnerNo').val() || ''),
						/* 승인번호 */
						eTaxIssNo : ($('#txtIssNo').val() || ''),
						/* 결의상태 */
						approvalEmpName : ($('#txtUserName').val() || '')
					}
				} else if (Common.ERPiU()) {
					parameters = {
						/* 작성일자 From */
						issDateFrom : ($('#txtFromDate').val() || ''),
						/* 작성일자 To */
						issDateTo : ($('#txtToDate').val() || ''),
						/* 공급자 */
						partnerName : ($('#txtPartnerName').val() || ''),
						/* 결의상태 */
						eTaxStat : ($('#selSendType').val() || ''),
						/* 사업자등록번호 */
						partnerRegNo : ($('#txtPartnerNo').val() || ''),
						/* 승인번호 */
						eTaxIssNo : ($('#txtIssNo').val() || ''),
						/* 결의상태 */
						approvalEmpName : ($('#txtUserName').val() || '')
					}
				}

				return Common.Param._GetSearchFormat(parameters);
			},
			_GetSearchFormat : function(parameters) {
				$.each(Object.keys(parameters), function(idx, key) {
					if (SearchDateFormat.indexOf(key) > -1) {
						/* "-" 제거 처리 */
						parameters[key] = parameters[key].toString().replace(/-/g, '');
					}
				});

				return parameters;
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
			}
		},
		Focus : {
			SetIssDateFrom : function() {
				$('#txtFromDate').focus().select();
			},
			SetIssDateTo : function() {
				$('#txtToDate').focus().select();
			},
			SetPartnerName : function() {
				$('#txtPartnerName').focus().select();
			},
			SetETaxStat : function() {
				$('#selSendType').focus().select();
			},
			SetPartnerRegNo : function() {
				$('#txtPartnerNo').focus().select();
			},
			SetETaxIssNo : function() {
				$('#txtIssNo').focus().select();
			},
			SetApprovalEmpName : function() {
				$('#txtUserName').focus().select();
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
			RegNo : function(value) {
				value = (value || '');
				value = value.toString().replace(/-/g, '').split(' ').join('');
				value = value.replace(/([0-9]{3})([0-9]{2})([0-9]{5})/, '$1-$2-$3');

				return value;
			}
		},
		Util : {
			CheckboxStat : function() {
				var checkboxCount = $("input[name=chkETax]:checkbox").length
				var checkboxCheckedCount = $("input[name=chkETax]:checkbox:checked").length;

				if (checkboxCount === checkboxCheckedCount) {
					$('#all_chk').prop('checked', true);
				} else {
					$('#all_chk').prop('checked', false);
				}
			}
		}
	};

	/* ## document ready ## */
	/* ====================================================================================================================================================== */
	$(document).ready(function() {
		fnInit();
		fnEventInit();
		Common.Focus.SetPartnerName();

		$('#btnSearch').click();
		return;
	});

	/* ## init ## */
	/* ====================================================================================================================================================== */
	function fnInit() {
		/* Datepicker */
		//fnSetDatepicker("#txtFromDate, #txtToDate", "yy-mm-dd");
		$('#txtFromDate').val(Common.Date.GetBeforeMonth());
		$('#txtToDate').val(Common.Date.GetToday());
		return;
	}

	/* ## event init ## */
	/* ====================================================================================================================================================== */
	function fnEventInit() {
		/* 작성일자 From */
		/* 작성일자 To */
		/* 공급자 */
		$('#txtPartnerName').keydown(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (SearchKeyCode.indexOf(keyCode.toString()) > -1) {
				var confirmMsg = '검색하시겠습니까?';
				if (confirm(confirmMsg)) {
					$('#btnSearch').click();
				}
			}

			return;
		});
		/* 결의상태 */
		/* 사업자등록번호 */
		$('#txtPartnerNo').keyup(function() {
			var value = ($(this).val() || '');
			value = value.toString().replace(/[^0123456789-]/g, '');
			$(this).val(value);
			return;
		});
		$('#txtPartnerNo').keydown(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (SearchKeyCode.indexOf(keyCode.toString()) > -1) {
				var confirmMsg = '검색하시겠습니까?';
				if (confirm(confirmMsg)) {
					$('#btnSearch').click();
				}
			}

			return;
		});
		/* 승인번호 */
		$('#txtIssNo').keydown(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (SearchKeyCode.indexOf(keyCode.toString()) > -1) {
				var confirmMsg = '검색하시겠습니까?';
				if (confirm(confirmMsg)) {
					$('#btnSearch').click();
				}
			}

			return;
		});
		/* 결의서 */
		$('#txtUserName').keydown(function() {
			var keyCode = event.keyCode ? event.keyCode : event.which;
			if (SearchKeyCode.indexOf(keyCode.toString()) > -1) {
				var confirmMsg = '검색하시겠습니까?';
				if (confirm(confirmMsg)) {
					$('#btnSearch').click();
				}
			}

			return;
		});
		/* 검색 */
		$('#btnSearch').click(function() {
			fnETaxSearch();
			return;
		});
		/* 계산서 이관 */
		$('#btnTransfer').click(function() {
			fnETaxTrans();
			return;
		});
		/* 계산서 이관관리 */
		$('#btnManageTransfer').click(function() {
			fnETaxTransHistory();
			return;
		});
		/* 미사용 */
		$('#btnUnUse').click(function() {
			fnETaxUnUse();
			return;
		});
		/* 미사용 해제 */
		$('#btnUse').click(function() {
			fnETaxUse();
			return;
		});
		/* 엑셀 다운로드 */
		$('#btnExcel').click(function() {
			fnETaxExcel();
			return;
		});
		return;
	}

	/* ## etax search ## */
	/* ====================================================================================================================================================== */
	function fnETaxSearch() {
		var ajaxParam = {};
		ajaxParam = Common.Param.GetSearchParam();

		$.ajax({
			type : 'post',
			url : "<c:url value='/expend/np/user/NpGetETaxList.do' />",
			datatype : 'json',
			async : true,
			data : ajaxParam,
			ajaxParam : ajaxParam,
			success : function(result) {
				/* aData example : {"approState":"","vatAmtCon":"22,000","trRegNb":"1231231231","docSeq":"200000000000959","adocuYn":"0","itemDc":"통관수수료","docuInfo":"","trName":"용당세관","isuDt":"20170102","reqAmtCon":"22,000","adocuFg":"미발행","trChargeEMail":"select@qwer.co.kr","docuNo":"","issDt":"20180525","dummary1":"신고번호(1159012200407U),HAWB(PSK0120014)","dummary2":"청구","taxTy":"4","eMailDc":"","vatAat":2200,"issYn":"","issNo":"2017010141000009c0003o09","issYMD":"20170102","reqAmt":24200,"eTaxTy":"1","stdAmtCon":"22,000","useYn":"N","createEmpName":"최상배","sendYn":"Y","stdAmt":22000,"trSubNb":"","trSeq":"","gwInsertDt":-2209021200000,"bizSeq":"1000"} */
				var aaData = Common.Result.GetAaData(result);
				var resultCode = Common.Result.GetCode(result);
				var resultMessage = Common.Result.GetMessage(result);

// 				if (aaData.length > 0) {
// 					fnInitTable2(aaData);
// 				} else {
// 					fnEmptyInitTable();
// 				}
				fnInitTable2(aaData);
				
				Common.Util.CheckboxStat();
			}
		});
	}

	/* ## etax trans ## */
	/* ====================================================================================================================================================== */
	function fnETaxTrans() {
		var chkSels = $("input[name=chkETax]:checkbox:checked").map(function(idx) {
			return $(this).data('value');
		}).get();

		if (chkSels.length > 0) {
			var eTaxTransList = [];

			$.each(chkSels, function(idx, item) {
				eTaxTransList.push(item);
			});

			if (eTaxTransList.length > 0) {

				var confirmMsg = '이관이 완료되면 받는 사람의 사용자화면에서 정보가 조회됩니다. \n계속 진행하시겠습니다?';
				if (confirm(confirmMsg)) {
					/* 공통팝업 오픈 */
					var url = "/gw/systemx/orgChart.do";
					var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");

					frmPop2.target = "cmmOrgPop";
					frmPop2.method = "post";
					frmPop2.action = url;
					frmPop2.submit();
					frmPop2.target = "";
					pop.focus();
				}
			} else {
				alert('${CL.ex_PleaseSelectAnItem}');
			}
		} else {
			alert('${CL.ex_PleaseSelectAnItem}');
		}

		return;
	}

	function fnETaxTransCallback(param) {
		var receiveEmp = {};
		var receiveParam = {};

		if (param.returnObj.length > 0) {
			receiveEmp = param.returnObj[0];
			receiveParam.receiveEmpSeq = receiveEmp.empSeq;
			receiveParam.receiveEmpName = receiveEmp.empName;
			receiveParam.receiveEmpSuperKey = receiveEmp.superKey;

			if (Common.GetEmpInfo().empSeq === receiveParam.receiveEmpSeq) {
				setTimeout(function() {
					alert('계산서는 자신에게 이관할 수 없습니다.');
				}, 1000);
				return;
			} else {
				var chkSels = $("input[name=chkETax]:checkbox:checked").map(function(idx) {
					return $(this).data('value');
				}).get();

				if (chkSels.length > 0) {
					var eTaxTransList = [];
					$.each(chkSels, function(idx, item) {
						eTaxTransList.push(item);
					});

					var ajaxParam = {};
					ajaxParam = receiveParam;
					ajaxParam.eTaxTransList = JSON.stringify(eTaxTransList);

					$.ajax({
						type : 'post',
						url : "<c:url value='/expend/np/user/NpSetETaxTrans.do' />",
						datatype : 'json',
						async : true,
						data : ajaxParam,
						ajaxParam : ajaxParam,
						success : function(result) {
							/* aData example : {"approState":"","vatAmtCon":"22,000","trRegNb":"1231231231","docSeq":"200000000000959","adocuYn":"0","itemDc":"통관수수료","docuInfo":"","trName":"용당세관","isuDt":"20170102","reqAmtCon":"22,000","adocuFg":"미발행","trChargeEMail":"select@qwer.co.kr","docuNo":"","issDt":"20180525","dummary1":"신고번호(1159012200407U),HAWB(PSK0120014)","dummary2":"청구","taxTy":"4","eMailDc":"","vatAat":2200,"issYn":"","issNo":"2017010141000009c0003o09","issYMD":"20170102","reqAmt":24200,"eTaxTy":"1","stdAmtCon":"22,000","useYn":"N","createEmpName":"최상배","sendYn":"Y","stdAmt":22000,"trSubNb":"","trSeq":"","gwInsertDt":-2209021200000,"bizSeq":"1000"} */
							var aaData = Common.Result.GetAaData(result);
							var resultCode = Common.Result.GetCode(result);
							var resultMessage = Common.Result.GetMessage(result);

							console.log(resultCode);
							console.log(resultMessage);
							$('#btnSearch').click();
						}
					});
				}
			}
		}

		return;
	}

	function fnETaxTransHistory() {
		/* 팝업 호출 준비 */
		var url = "<c:url value='/expend/np/user/UserETaxTransHistoryPop.do'/>";
		var height = 480;

		var isFirefox = typeof InstallTrigger !== 'undefined';
		var isIE = /*@cc_on!@*/false || !!document.documentMode;
		var isEdge = !isIE && !!window.StyleMedia;
		var isChrome = !!window.chrome && !!window.chrome.webstore;
		if (isFirefox) {
			height += 4;
		}
		if (isIE) {
			height += 0;
		}
		if (isEdge) {
			height -= 26;
		}
		if (isChrome) {
			height -= 6;
		}

		window.open('', "eTaxTransPop", "width=" + 900 + ", height=" + height + ", left=" + 150 + ", top=" + 150);
		ETaxTrans.target = "eTaxTransPop";
		ETaxTrans.method = "post";
		ETaxTrans.action = url;
		ETaxTrans.submit();
		ETaxTrans.target = "";

		return;
	}

	/* ## etax use, unuse ## */
	/* ====================================================================================================================================================== */
	function fnETaxUnUse() {
		var chkSels = $("input[name=chkETax]:checkbox:checked").map(function(idx) {
			return $(this).data('value');
		}).get();

		if (chkSels.length > 0) {
			var ajaxParam = {};
			ajaxParam.eTaxNotUseList = JSON.stringify(chkSels);

			$.ajax({
				type : 'post',
				url : "<c:url value='/expend/np/user/NpSetETaxUseUpdateN.do' />",
				datatype : 'json',
				async : true,
				data : ajaxParam,
				ajaxParam : ajaxParam,
				success : function(result) {
					/* aData example : {"approState":"","vatAmtCon":"22,000","trRegNb":"1231231231","docSeq":"200000000000959","adocuYn":"0","itemDc":"통관수수료","docuInfo":"","trName":"용당세관","isuDt":"20170102","reqAmtCon":"22,000","adocuFg":"미발행","trChargeEMail":"select@qwer.co.kr","docuNo":"","issDt":"20180525","dummary1":"신고번호(1159012200407U),HAWB(PSK0120014)","dummary2":"청구","taxTy":"4","eMailDc":"","vatAat":2200,"issYn":"","issNo":"2017010141000009c0003o09","issYMD":"20170102","reqAmt":24200,"eTaxTy":"1","stdAmtCon":"22,000","useYn":"N","createEmpName":"최상배","sendYn":"Y","stdAmt":22000,"trSubNb":"","trSeq":"","gwInsertDt":-2209021200000,"bizSeq":"1000"} */
					var resultCode = Common.Result.GetCode(result);
					var resultMessage = Common.Result.GetMessage(result);

					if (resultCode === 'SUCCESS') {
						$('#btnSearch').click();
						alert('미사용 처리되었습다.');
					} else {
						alert(resultMessage);
					}
				}
			});
		} else {
			alert('${CL.ex_PleaseSelectAnItem}');
		}

		return;
	}

	function fnETaxUse() {
		var chkSels = $("input[name=chkETax]:checkbox:checked").map(function(idx) {
			return $(this).data('value');
		}).get();

		if (chkSels.length > 0) {
			var ajaxParam = {};
			ajaxParam.eTaxUseList = JSON.stringify(chkSels);

			$.ajax({
				type : 'post',
				url : "<c:url value='/expend/np/user/NpSetETaxUseUpdateY.do' />",
				datatype : 'json',
				async : true,
				data : ajaxParam,
				ajaxParam : ajaxParam,
				success : function(result) {
					/* aData example : {"approState":"","vatAmtCon":"22,000","trRegNb":"1231231231","docSeq":"200000000000959","adocuYn":"0","itemDc":"통관수수료","docuInfo":"","trName":"용당세관","isuDt":"20170102","reqAmtCon":"22,000","adocuFg":"미발행","trChargeEMail":"select@qwer.co.kr","docuNo":"","issDt":"20180525","dummary1":"신고번호(1159012200407U),HAWB(PSK0120014)","dummary2":"청구","taxTy":"4","eMailDc":"","vatAat":2200,"issYn":"","issNo":"2017010141000009c0003o09","issYMD":"20170102","reqAmt":24200,"eTaxTy":"1","stdAmtCon":"22,000","useYn":"N","createEmpName":"최상배","sendYn":"Y","stdAmt":22000,"trSubNb":"","trSeq":"","gwInsertDt":-2209021200000,"bizSeq":"1000"} */
					var resultCode = Common.Result.GetCode(result);
					var resultMessage = Common.Result.GetMessage(result);

					if (resultCode === 'SUCCESS') {
						$('#btnSearch').click();
						alert('${CL.ex_usedUnprocessedTurnOff}');
					} else {
						alert(resultMessage);
					}
				}
			});
		} else {
			alert('${CL.ex_PleaseSelectAnItem}');
		}

		return;
	}

	/*	[그리드 출력] 그리드 출력 리스트 필터링
	-------------------------------------------------------------------- */
	function fnFilterdList(aaData){
		var filterdList = [];
		
		/* '' : 전체, '1' : 미결의, '2' : 미사용, '3' : 결의 */
		var approYN = ($('#selSendType').val() || '') == '3' ? 'Y' : 'N';
		var useYN = ($('#selSendType').val() || '') == '2' ? 'N' : 'Y';
		if( ($('#selSendType').val() || '') == '' ) {
			approYN = useYN = '' ;
		}
		var trName = ( $('#txtPartnerName').val() || '');
		var trRegNb = '';
		var issNo = '';
		var approEmpName = ( $('#txtUserName').val() || '');
		if($('#txtUserName:visible').length){
			trRegNb = ( $('#txtPartnerNo').val() || '').replace(/-/g, '');
			issNo = ( $('#txtIssNo').val() || '');
		}
		
		for(var i = 0; i < aaData.length; i++){
			var item = aaData[i];
			
			/* 공급자 체크 */
			if( (item.trName || '') .indexOf(trName) == -1){
				continue;
			}
			
			/* 결의상태 체크 */
			if( (item.approYN || 'N') .indexOf(approYN) == -1){
				continue;
			}
			
			/* 미사용 여부 체크 */
			if( (item.useYN || 'Y') .indexOf(useYN) == -1){
				continue;
			}
			
			/* 사업자 등록 번호 체크 */
			if( (item.trRegNb || '') .indexOf(trRegNb) == -1){
				continue;
			}
			/* 승인번호 체크 */
			if( (item.issNo || '') .indexOf(issNo)  == -1){
				continue;
			}
			/* 결의자 체크 */
			if( (item.approEmpName || '') .indexOf(approEmpName) == -1){
				continue;
			}
			
			filterdList.push(item);
		}
		console.log('function fnFilterdList(aaData) RESULT : ');
		return filterdList;
	}
	
	/* ## table render2 ## */
	/* ====================================================================================================================================================== */
	function fnInitTable2(aaData) {
		console.log('**************************** 품의서 반환 리스트 출력2 ****************************');
		aaData = fnFilterdList(aaData); 
		
		$('#eTaxTotalCount').html(aaData.length.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
		var pageSize = $('#divGridArea_selectMenu option:selected').val();
		$("#divGridArea").html("");
		$('.gt_paging').remove();
		$("#divGridArea").GridTable({
			'tTablename' : 'gridConsReturn',
			'nTableType' : 1,
			'nHeight' : 600,
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
				renderValue : "<input type=\"checkbox\" id=\"all_chk\" name=\"all_chk\" onclick=\"fnAllChk('tblUserETaxReport');\">",
				colgroup : '5'
			}, {
				no : '1',
				renderValue : "작성일자",
				colgroup : '20', 
				class : 'orderBy', 
				value : 'issDt'
			}, {
				no : '2',
				renderValue : '공급자',
				colgroup : '40', 
				class : 'orderBy', 
				value : 'trName'
			}, {
				no : '3',
				renderValue : '사업자등록번호',
				colgroup : '15', 
				class : 'orderBy', 
				value : 'trRegNb'
			}, {
				no : '4',
				renderValue : '승인번호',
				colgroup : '25', 
				class : 'orderBy', 
				value : 'issNo'
			}, {
				no : '5',
				renderValue : '금액',
				colgroup : '15', 
				class : 'orderBy', 
				value : 'reqAmt'
			}, {
				no : '6',
				renderValue : '공급가액',
				colgroup : '15', 
				class : 'orderBy', 
				value : 'stdAmt'
			}, {
				no : '7',
				renderValue : '부가세',
				colgroup : '15', 
				class : 'orderBy', 
				value : 'vatAmt'
			}, {
				no : '8',
				renderValue : '결의상태',
				colgroup : '15', 
				class : 'orderBy', 
				value : 'approYN'
			} ],
			"aoDataRender" : [ { // [*] 실제 데이터 표기 방법에 대하여 지정합니다.
				no : '0',
				render : function(idx, item) {
					var isDisabled = (item.receiveYN || item.transferYN || item.sendYN || 'N') == 'Y' ? 'disabled' : '';
					if( (item.approYN || 'N' ) == 'Y'){
						isDisabled = 'disabled';
					}
					
					return '<input type="checkbox" name="chkETax" onclick="Common.Util.CheckboxStat();"' + isDisabled + ' />';
				}
			}, {
				no : '1',
				render : function(idx, item) {
					
					return Common.Format.Date(item.issDt);
				}
			}, {
				no : '2',
				render : function(idx, item) {
					if( ( item.receiveYN || 'N') === 'Y'){
						return '<img src="../../../Images/ico/received_arr.png" alt="" /> ' + item.trName;
					} else if( ( item.transferYN || 'N') === 'Y'){
						return '<img src="../../../Images/ico/send_arr.png" alt="" /> ' + item.trName;
					}
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
					return Common.Format.Amt(item.reqAmt);
				},
				class : 'ri colorIf'
			}, {
				no : '6',
				render : function(idx, item) {
					return Common.Format.Amt(item.stdAmt);
				},
				class : 'ri colorIf'
			}, {
				no : '7',
				render : function(idx, item) {
					return Common.Format.Amt(item.vatAmt);
				},
				class : 'ri colorIf'
			}, {
				no : '8',
				render : function(idx, item) {
					/* 미사용 : (R)미사용(홍길동) */
					/* 미상신 : 미결의 */
					/* 상신 : 결의(홍길동) */
					if (item.useYN === 'N') {
						return '<span  style="color: red">미사용</span>&nbsp;(' + (item.notUseEmpName || '-') + ')';
					} else {
						if (item.approYN === 'Y') {
							return '결의 (' + (item.approEmpName || '-') + ')';
						} else {
							return '미결의';
						}
					}
				}
			} ],
			'fnGetDetailInfo' : function() {
				console.log('get detail info');
			},
			'fnTableDraw' : function() {
				$('#all_chk').click(function (){
					$('.chk_row:enabled').prop('checked', $(this).prop('checked'));
				});
				
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
			} else if(_orderType == 'stdAmt'){
				if( a.stdAmt < b.stdAmt ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			} else if(_orderType == 'vatAmt'){
				if( a.vatAmt < b.vatAmt ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			} else if(_orderType == 'approYN'){
				var aStatus = '' + a.approYN + a.useYn;
				var bStatus = '' + b.approYN + b.useYn;
				if( aStatus < bStatus ){
					return _orderBy;
				}else {
					return _orderBy * -1;
				}
			}
			
			// 이름이 같을 경우
			return 0;
		});
		
		fnInitTable2(aaData);
		
		$('.com_ta2 table th').css('background', '#f9f9f9');
		if(_orderBy == -1){
			$('.com_ta2 table th[value='+ orderType +']').css('background', '#FFE5E5');
			$th
		}else{
			$('.com_ta2 table th[value='+ orderType +']').css('background', '#E5F4FF');
		}
	}
	
	/* ## table render ## */
	/* ====================================================================================================================================================== */
	function fnInitTable(aaData) {
		aaData = (aaData || []);
		var $table = $('#tblUserETaxReport');
		$table.empty();
		$table.append('<colgroup>' + $('.com_ta2 table colgroup').html() + '</colgroup>');

		$.each(aaData, function(idx, item) {
			var tr = document.createElement('tr');
			var color = ' style="color: red"';

			$(tr).data('eTax', item);

			$(tr).append('<td>' + '<input type="checkbox" name="chkETax" onclick="Common.Util.CheckboxStat();" />' + '</td>');
			$(tr).append('<td>' + Common.Format.Date(item.issDt) + '</td>');
			$(tr).append('<td class="le">' + item.trName + '</td>');
			$(tr).append('<td>' + Common.Format.RegNo(item.trRegNb) + '</td>');
			$(tr).append('<td>' + item.issNo + '</td>');
			$(tr).append('<td class="ri"' + ((Number(item.reqAmt || '0') < 0) ? color : '') + '>' + Common.Format.Amt(item.reqAmtCon) + '</td>');
			$(tr).append('<td class="ri"' + ((Number(item.reqAmt || '0') < 0) ? color : '') + '>' + Common.Format.Amt(item.stdAmtCon) + '</td>');
			$(tr).append('<td class="ri"' + ((Number(item.reqAmt || '0') < 0) ? color : '') + '>' + Common.Format.Amt(item.vatAmtCon) + '</td>');

			/* 미사용 : (R)미사용(홍길동) */
			/* 미상신 : 미결의 */
			/* 상신 : 결의(홍길동) */
			if (item.useYn === 'N') {
				$(tr).append('<td>' + '<span  style="color: red">미사용</span>&nbsp;(' + (item.notUseEmpName || '-') + ')' + '</td>');
			} else {
				if (item.sendYn === 'Y') {
					$(tr).append('<td>' + '결의&nbsp;(' + (item.createEmpName || '-') + ')' + '</td>');
				} else {
					$(tr).append('<td>' + '미결의' + '</td>');
				}
			}

			$(tr).css('cursor', 'pointer');
			$(tr).find('input[type=checkbox]').data('value', item);

			$(tr).click(function() {
				$table.find('.on').removeClass('on');
				$(this).addClass('on');
			});

			$table.append(tr);
		});

		$('#eTaxTotalCount').html(aaData.length);

		return;
	}

	function fnEmptyInitTable() {
		if($('#tblUserETaxReport').length < 1){
			var emptyTable = '';
			emptyTable += '<table id="tblUserETaxReport">';
			$('#divGridArea').append(emptyTable);
		}
		
		var $table = $('#tblUserETaxReport');
		$table.empty();
		$table.append('<colgroup><col width="5"><col width="20"><col width="40"><col width="15"><col width="25"><col width="15"><col width="15"><col width="15"><col width="15"></colgroup>');
		$table.append('<tr><th><input type="checkbox"></th><th>작성일자</th><th>공급자</th><th>사업자등록번호</th><th>승인번호</th><th>금액</th><th>공급가액</th><th>부가세</th><th>결의상태</th></tr>');
		$table.append('<tr><td colspan="9">${CL.ex_dataDoNotExists}</td></tr>');
		$('#eTaxTotalCount').html('0');

		return;
	}

	/* ## excel ## */
	/* ====================================================================================================================================================== */

	function fnETaxExcel() {
		if($('#eTaxTotalCount').html() == '0' ){
			alert('데이터가 없습니다.');
			return;
		}
		/* 변수정의 */
		var ajaxParam = {};
		ajaxParam = Common.Param.GetSearchParam();
		ajaxParam.excelHeader = JSON.stringify({
			issDate : '작성일자',
			trName : '공급자',
			trRegNb : '사업자등록번호',
			issNo : '승인번호',
			reqAmt : '금액',
			stdAmt : '공급가액',
			vatAmt : '부가세',
			useYn : '사용(Y)/미사용(N)',
			sendYn : '결의(Y)/미결의(N)'
		});

		/* form 정의 */
		$("#excelHeader").val(ajaxParam.excelHeader);
		$("#issDateFrom").val(ajaxParam.issDateFrom);
		$("#issDateTo").val(ajaxParam.issDateTo);
		$("#partnerName").val(ajaxParam.partnerName);
		$("#eTaxStat").val(ajaxParam.eTaxStat);
		$("#partnerRegNo").val(ajaxParam.partnerRegNo);
		$("#eTaxIssNo").val(ajaxParam.eTaxIssNo);
		$("#approvalEmpName").val(ajaxParam.approvalEmpName);

		/* submit */
		var url = "<c:url value='/expend/np/user/NpGetETaxListExcel.do' />";
		excelDownload.method = "post";
		excelDownload.action = url;
		excelDownload.submit();
		excelDownload.target = "";
	}
</script>

<!-- hidden -->
<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="excelHeader" value="" id="excelHeader" /> <input type="hidden" name="issDateFrom" value="" id="issDateFrom" /> <input type="hidden" name="issDateTo" value="" id="issDateTo" /> <input type="hidden" name="partnerName" value="" id="partnerName" /> <input type="hidden" name="eTaxStat" value="" id="eTaxStat" /> <input type="hidden" name="partnerRegNo" value="" id="partnerRegNo" /> <input type="hidden" name="eTaxIssNo" value="" id="eTaxIssNo" value" /> <input type="hidden" name="approvalEmpName" value="" id="approvalEmpName" />
</form>
<!-- 이관 관련 데이터 -->
<input type="hidden" id="hidSelectedETaxInfo" value=""> <!-- body -->
	<div class="sub_contents_wrap">
		<!-- 컨트롤박스 -->
		<div class="top_box">
			<dl>
				<dt>${CL.ex_writeDate}  <!-- 작성일자 --></dt>
				<dd>
					<div class="dal_div">
						<input type="text" autocomplete="off" id="txtFromDate" value="" class="w113 enter puddSetup" pudd-type="datepicker" />
					</div>
					~
					<div class="dal_div">
						<input type="text" autocomplete="off" id="txtToDate" value="" class="w113 enter puddSetup" pudd-type="datepicker" />
					</div>
				</dd>
				<dt>${CL.ex_supplyer}  <!--공급자--></dt>
				<dd>
					<input type="text" autocomplete="off" id="txtPartnerName" style="width: 186px;" placeholder="${CL.ex_supplyer} ${CL.ex_Please}" /><!--공급자-->
				</dd>
				<dt>${CL.ex_resCondition}  <!--결의상태--></dt>
				<dd>
					<select id="selSendType" class="selectmenu" style="width: 100px;">
						<option value="" selected="selected">${CL.ex_all}  <!--전체--></option>
						<option value="1">${CL.ex_noRes}  <!--미결의--></option>
						<option value="2">${CL.ex_noUser}  <!--미사용--></option>
						<option value="3">${CL.ex_res}  <!--결의--></option>
					</select>
				</dd>
				<dd>
					<input type="button" id="btnSearch" value="${CL.ex_search}" /> <!--검색-->
				</dd>
			</dl>
			<span class="btn_Detail">${CL.ex_detailSearch}  <!--상세검색--> <img id="all_menu_btn" src='../../../Images/ico/ico_btn_arr_down01.png' /></span>
		</div>
		<!-- 상세검색박스 -->
		<div class="SearchDetail">
			<dl>
				<dt>${CL.ex_corporateRegiNum}  <!--사업자등록번호--></dt>
				<dd>
					<input type="text" autocomplete="off" id="txtPartnerNo" style="width: 150px;" placeholder="${CL.ex_corporateRegiNum} ${CL.ex_Please}" /> <!--사업자등록번호-->
				</dd>
				<dt style="width: 70px;">${CL.ex_confirmationNumber}  <!--승인번호--></dt>
				<dd>
					<input type="text" autocomplete="off" id="txtIssNo" style="width: 150px;" placeholder="${CL.ex_confirmationNumber} ${CL.ex_Please}" /><!--승인번호-->
				</dd>
				<dt style="width: 70px;">${CL.ex_resPerson}  <!--결의자--></dt>
				<dd>
					<input type="text" autocomplete="off" id="txtUserName" style="width: 150px;" placeholder="${CL.ex_resPerson} ${CL.ex_Please}" /><!--결의자-->
				</dd>
			</dl>
		</div>

		<!-- 버튼 -->
		<div class="btn_div cl">
			<div class="left_div fwb mt5">
				${CL.ex_yeCount} <span id="eTaxTotalCount">0</span> ${CL.ex_gun}
			</div>
			<div class="right_div">
				<div class="controll_btn p0">
					<button id="btnTransfer">${CL.ex_calcTrans}  <!--계산서이관--></button>
					<button id="btnManageTransfer">${CL.ex_transManage}  <!--이관관리--></button>
					<button id="btnUnUse">${CL.ex_noUser}  <!--미사용--></button>
					<button id="btnUse">${CL.ex_noUserClear}  <!--미사용해제--></button>
					<button id="btnExcel">${CL.ex_excelDown}  <!--엑셀다운로드--></button>
				</div>
			</div>
		</div>
		<div class="com_ta2">
			<div id="divGridArea"></div>
		</div>
	</div> <!-- //sub_contents_wrap --> <!-- 공통팝업 위한 기능옵션 전달 폼 -->
	<form id="frmPop2" name="frmPop2">
		<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="<c:url value='/systemx/orgChart.do' />" /> <input type="hidden" id="devMode_forCmPop" name="devMode" width="500" value="dev" /> <input type="hidden" name="devModeUrl" width="500" value="http://local.duzonnext.com:8080" /> <input type="hidden" id="langCode_forCmPop" name="langCode" width="500" /> <input type="hidden" id="groupSeq_forCmPop" name="groupSeq" width="500" /> <input type="hidden" id="compSeq_forCmPop" name="compSeq" width="500" /> <input type="hidden" id="deptSeq_forCmPop" name="deptSeq" width="500" /> <input type="hidden" id="empSeq_forCmPop" name="empSeq" width="500" /> <input type="hidden" id="compFilter_forCmPop" name="compFilter" width="500" /> <input type="hidden" name="selectMode" width="500" value="u" /> <input type="hidden" name="selectItem" width="500" value="s" /> <input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" /> <input type="hidden"
			name="callback" width="500" value="fnETaxTransCallback" /> <input type="hidden" name="callbackUrl" width="500" value="<c:url value='/html/common/callback/cmmOrgPopCallback.jsp' />" />
	</form>

	<form id="ETaxTrans" name="ETaxTrans" method="post"></form>