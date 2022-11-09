<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>


<script>



	/*	[공통] 품의/결의 데이터 저장 정보 조회
	----------------------------------------- */
	function cmFnc_CommonSaveData(){
		return {
			tripDocSeq : (!!optionSet.tripConsDoc)?optionSet.tripConsDoc.tripConsDocSeq:optionSet.tripResDoc.tripResDocSeq
			, userInfo : JSON.stringify( cmFnc_getUserInfo() )
			, tripInfo : JSON.stringify( fnGetTripInfo() )
			, triperInfo : JSON.stringify((fnGetTriperInfo()))
			, expenseInfo : JSON.stringify((fnGetExpenseInfo()))
		}
	}

	/*	[공통] 작성 경비 내역 정보 조회
	----------------------------------------- */
	function fnGetExpenseInfo(){
		var expense_data = [];
		
		$('.hiddenExpenseJson').each(function(item, idx){
			var aData = JSON.parse( unescape( $(this).val() ) );
			var class1Amt = ($(this).parent().parent().find('.amtClass1Amt').val() || '0').replace(/,/gi, '');
			var class2Amt = ($(this).parent().parent().find('.amtClass2Amt').val() || '0').replace(/,/gi, '');
			var class3Amt = ($(this).parent().parent().find('.amtClass3Amt').val() || '0').replace(/,/gi, '');
			var class4Amt = ($(this).parent().parent().find('.amtClass4Amt').val() || '0').replace(/,/gi, '');
			var class5Amt = ($(this).parent().parent().find('.amtClass5Amt').val() || '0').replace(/,/gi, '');
			var class6Amt = ($(this).parent().parent().find('.amtClass6Amt').val() || '0').replace(/,/gi, '');
			
			aData.amtClass1Amt = class1Amt;
			aData.amtClass2Amt = class2Amt;
			aData.amtClass3Amt = class3Amt;
			aData.amtClass4Amt = class4Amt;
			aData.amtClass5Amt = class5Amt;
			aData.amtClass6Amt = class6Amt;
			aData.compSeq = optionSet.loginVo.compSeq;
			
			expense_data.push(aData); 
		});
		return {expenseData : JSON.stringify(expense_data) };
	}
	
	/*	[공통] 작성 사용자 정보 조회
	----------------------------------------- */
	function cmFnc_getUserInfo(){
		return {
			empSeq : optionSet.loginVo.empSeq
			, empName : optionSet.loginVo.name
			, deptSeq : optionSet.loginVo.deptSeq
			, deptName : optionSet.loginVo.orgnztNm
			, groupSeq : optionSet.loginVo.groupSeq
			, compSeq : optionSet.loginVo.compSeq
			, compName : optionSet.loginVo.organNm
			, erpEmpSeq :  optionSet.erpEmpInfo.erpEmpSeq
			, erpDeptSeq : optionSet.erpEmpInfo.erpDeptSeq
			, erpDivSeq : optionSet.erpEmpInfo.erpDivSeq
			, erpCompSeq : optionSet.erpEmpInfo.erpCompSeq
			, langCode : optionSet.loginVo.langCode
			, groupSeq	: optionSet.loginVo.groupSeq
		}
	}
	
	/*	[공통] 출장자 정보 조회
	-------------------------------------------------- */
	function fnGetTriperInfo(){
		var org_data = $('#select_org_info').val();
		return {orgData : unescape(org_data)};
	}
	
	
	
	/*	[교통] 교통 수단 멀티 셀렉트 데이터 선택
	-------------------------------------------------- */
	function fnGetTransportSelectedDataKey(){
		var selectedTransport = '';
		$(Pudd('#sel_transport').getPuddObject().node).find('option').each(function (){
			if( '' + $(this).attr('multiselected') == 'true' ){
				selectedTransport += ',' + $(this).val();
			}
		});
		if(selectedTransport){
			selectedTransport = selectedTransport.substring(1);
		}
		return selectedTransport;
	}
	

	/*	[교통] 교통 수단 멀티 셀렉트 데이터 선택
	-------------------------------------------------- */
	function fnGetTransportSelectedDataText(){
		var selectedTransport = '';
		$(Pudd('#sel_transport').getPuddObject().node).find('option').each(function (){
			if( '' + $(this).attr('multiselected') == 'true' ){
				selectedTransport += ',' + $(this).text();
			}
		});
		if(selectedTransport){
			selectedTransport = selectedTransport.substring(1);
		}
		return selectedTransport;
	}
	
	/*	[공통] 출장 정보 조회
	-------------------------------------------------- */
	function fnGetTripInfo(){
		var docmesticCode = $('input:radio[name=selDomesticRadi]:checked').val() || '1';
		
		var tripFromDate = Pudd('#txt_tripFromDate').getPuddObject().val();
		var tripFromTime = Pudd('#txt_tripFromTime').getPuddObject().text()
		tripFromTime = ( tripFromTime || '00:00' );
		
		var tripToDate = Pudd('#txt_tripToDate').getPuddObject().val();
		var tripToTime = Pudd('#txt_tripToTime').getPuddObject().text();
		tripToTime = ( tripToTime || '00:00' );
		
		var calendarSeq = Pudd('#sel_calendar').getPuddObject().val();
		var calendarName =  Pudd('#sel_calendar').getPuddObject().text();
		
		var locationCode = Pudd('#sel_location').getPuddObject().val();
		var locationName = Pudd('#sel_location').getPuddObject().text();
		var locationNote = Pudd('#txt_locationNote').getPuddObject().val();
		
		var tripTransportCode = fnGetTransportSelectedDataKey();
		var tripTransportName = fnGetTransportSelectedDataText();
		
		var purpose = Pudd('#txt_purpose').getPuddObject().val();
		
		var payRequestCode = $('input:radio[name=selPayRequestRadi]:checked').val() || '1';
		
		var orgDataInfo = escape($('#select_org_info').val());
		
		return {
			domesticCode : docmesticCode
			, domesticName : docmesticCode == '0' ? '국내' : '해외'
			, tripFromDate : tripFromDate + ' ' + tripFromTime
			, tripFromTime : tripFromTime
			, tripToDate : tripToDate + ' ' + tripToTime
			, tripToTime : tripToTime
			, calendarSeq : calendarSeq
			, calendarName : calendarName
			, locationCode : locationCode
			, locationName : locationName
			, locationNote : locationNote
			, tripTransportCode : tripTransportCode
			, tripTransportName : tripTransportName
			, purpose : purpose
			, payRequestCode : payRequestCode
			, payRequestName : payRequestCode == '0' ? '대상' : '비대상'
			, orgDataInfo : orgDataInfo
		}
	}
	
	
 	/*	[공통] 날짜 포멧 변경
	----------------------------------------- */
	function fnGetDateFormat(value){
 		var returnVal = '';
 		value = value || '';
 		value = value.replace('-', '');
 		returnVal = value.substring(0, 4) + '-' + value.substring(4, 6) + '-' + value.substring(6, 8); 
 		return returnVal;
 	}
	
	/*	[공통] 날짜 포멧 변경2
	----------------------------------------- */
	function getFormatDateForDateObj(date){
		var year = date.getFullYear();                                 //yyyy
		var month = (1 + date.getMonth());                     //M
		month = month >= 10 ? month : '0' + month;     // month 두자리로 저장
		var day = date.getDate();                                        //d
		day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장
		return  year + '-' + month + '-' + day;
	}
 	
	/*	[공통] 금액 포멧 변경
	----------------------------------------- */
	function fnGetCurrencyFormat(value){
        value = '' + Number( value || '0');
        var sourceValue = value.split('.');
        var resultValue = '0';
        
        if (sourceValue.length > 0) {
            sourceValue[0] = (sourceValue[0] || '0').toString().replace(/[^0-9\-]/g, '');
            resultValue = sourceValue[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        if (sourceValue.length > 1) {
            sourceValue[1] = (sourceValue[0] || '').toString().replace(/[^0-9\-]/g, '');
            if (sourceValue[1].length > 0) {
                resultValue = [resultValue, (sourceValue[1] || '')].join('.');
            }
        }
        return resultValue;
 	}
	
	/*	[공통] 현황 페이지 파라미터 조회
	----------------------------------------- */
	function fnGetReportPageParam(){
		var param = {};
		
		/* 상세 검색 기능 사용여부 */
		if($('#divSearchDetail').is(":visible")){
			param.docNo = $('#txt_docNo').val();
			param.location = $('#txt_location').val();
			param.triper = $('#txt_triper').val();
			param.deptName = $('#txt_deptName').val();
			param.aprUserName = $('#txt_aprUserName').val();
			param.domesticCode = $('#sel_domesticCode').val();
			param.payRequest = $('#sel_payRequest').val();
			param.fromDate = $('#txt_fromDate').val();
			param.toDate = $('#txt_toDate').val();
			
			/* 엑셀 정보 조회 */
			$('#excel_docNo').val($('#txt_docNo').val());
			$('#excel_location').val($('#txt_location').val());
			$('#excel_triper').val($('#txt_triper').val());
			$('#excel_deptName').val($('#txt_deptName').val());
			$('#excel_aprUserName').val($('#txt_aprUserName').val());
			$('#excel_domesticCode').val($('#sel_domesticCode').val());
			$('#excel_payRequest').val($('#sel_payRequest').val());
			$('#excel_docStatus').val($('#sel_docStatus').val());
			$('#excel_formFromDate').val($('#txt_fromDate').val());
			$('#excel_formToDate').val($('#txt_toDate').val());
			
		}else{
			/* 엑셀 조회 정보 초기화 */
			$('#excel_docNo').val();
			$('#excel_location').val();
			$('#excel_triper').val();
			$('#excel_deptName').val();
			$('#excel_aprUserName').val();
			$('#excel_domesticCode').val();
			$('#excel_payRequest').val();
			$('#excel_docStatus').val();
			$('#excel_formFromDate').val();
			$('#excel_formToDate').val();
		}
		param.searchStr = $('#txt_searchStr').val();
		param.approvalFromDate = $('#txt_approvalFromDate').val();
		param.approvalToDate = $('#txt_approvalToDate').val();
		param.docStatus = $('#sel_docStatus').val();
		

		$('#excel_formDocTitle').val($('#txt_searchStr').val());
		$('#excel_approvalFromDate').val($('#txt_approvalFromDate').val());
		$('#excel_approvalToDate').val($('#txt_approvalToDate').val());
		return param;
	}
	
	/*	[공용] 결재 상태 적용
	---------------------------------------- */
    function fnGetDocStatusLabel(value) {
		/** 비영리 전자결재 상태 코드 **/ 
	    if(value == '000'){
	    	return '기안대기';
	    }else if(value == '001'){
	    	return '임시보관';
	    }else if(value == '002'){
	    	return '결재중';
	    }else if(value == '003'){
	    	return '협조중';
	    }else if(value == '004'){
	    	return '결재보류';
	    }else if(value == '005'){
	    	return '문서회수';
	    }else if(value == '006'){
	    	return '다중부서접수중';
	    }else if(value == '007'){
	    	return '기안반려';
	    }else if(value == '008'){
	    	return '결재완료';
	    }else if(value == '009'){
	    	return '발송요구';
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
	    	return '삭제';
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
</script>



<form id="excelDownload" name="excel" method="post">
	<input type="hidden" name="approvalFromDate" value="" id="excel_approvalFromDate" />
    <input type="hidden" name="approvalToDate" value="" id="excel_approvalToDate" />

    <input type="hidden" name="fromDate" value="" id="excel_formFromDate" />
    <input type="hidden" name="toDate" value="" id="excel_formToDate" />
    <input type="hidden" name="searchStr" value="" id="excel_formDocTitle" />

    <input type="hidden" name="docNo" value="" id="excel_docNo" />
    <input type="hidden" name="location" value="" id="excel_location" />
    <input type="hidden" name="triper" value="" id="excel_triper" />

    <input type="hidden" name="deptName" value="" id="excel_deptName" />
    <input type="hidden" name="aprUserName" value="" id="excel_aprUserName" />

    <input type="hidden" name="domesticCode" value="" id="excel_domesticCode" />
    <input type="hidden" name="payRequest" value="" id="excel_payRequest" />
    <input type="hidden" name="docStatus" value="" id="excel_docStatus" />

    <input type="hidden" name="excelHeader" value="" id="excelHeader" />
    <input type="hidden" name="fileName" value="" id="fileName">
    <input type="hidden" name="tripExcelCode" value="" id="tripExcelCode">
</form>