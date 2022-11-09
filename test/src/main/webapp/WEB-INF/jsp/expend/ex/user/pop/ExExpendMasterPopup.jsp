<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="currentTime" class="java.util.Date" />
<%@page import="main.web.BizboxAMessage"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/jquery.dataTables.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.select.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.scroller.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.rowReorder.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/datatables/dataTables.fixedHeader.min.js'></script> --%>
<%-- <script type="text/javascript" src='${pageContext.request.contextPath}/js/neos/NeosUtil.js'></script> --%>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/CommonEX.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/ExCodePop.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/ExExpend.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/ExExpendCode.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/jquery.ex.date.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/jquery.ex.event.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/jquery.ex.format.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/jquery.ex.list.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/jquery.ex.pop.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/jquery.ex.valid.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/expend/jQuery.exp.expend.focus.js'></script>
<script type="text/javascript"
	src='${pageContext.request.contextPath}/js/ex/ExOption.js'></script>
<script
	src='${pageContext.request.contextPath}/js/ex/underscore.js'></script>
<!-- 공통팝업 호출 -->
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />
<jsp:include page="../../../../common/userCardPop.jsp" flush="false" />
<!-- /* 프로그레스 레이어 팝업 참조 */ -->
<jsp:include page="../../../../common/layer/ProgressLayerPop.jsp"
	flush="false" />


<script>
    /* 변수정의 */
    /* 변수정의 - 공톤팝업 호출 사용 */
    /* 변수정의 - 지출결의 작성시 필요 기본 데이터 */
    /* 변수정의 - 지출결의 작성시 필요 기본 데이터 - 옵션 */
    /* 지출결의 옵션 */
    var option; 
    /* 변수정의 - 지출결의 작성시 필요 기본 데이터 - 그리드 */
    var gridList; /* 항목 그리드 */
    var gridSlip; /* 분개 그리드 */
    var gridMng; /* 관리항목 그리드 */
    /* 변수정의 - 지출결의 작성시 필요 기본 데이터 - 시스템연동정보 */
    var ifSystem; /* 팝업 사용 */
    var ifBudget; /* 팝업 사용 */
    /* 사용자 정보 */
    var empInfo;
    /* 양식정보 */
    var formSeq = 0;
    
    var formInfo;
    /* 변수정의 - 지출결의 */
    /* http://docs.telerik.com/kendo-ui/api/javascript/data/observableobject */
    var expend;
    var expendWriter;
    var expendUseEmp;
    var expendPartner;
    var expendProject;
    var expendCard;
    var expendBudget;
    /* 변수정의 - 지출결의 작성 상태 */
    // var modFlag = false;
    /* 변수정의 - 항목 아이디 */
    var listSeq = 0;
    /* 변수정의 - 분개 아이디 */
    var slipSeq = 0;
    /* 변수정의 - 관리항목 아이디 */
    var mngSeq = 0;
    /* 변수정의 - 클릭이벤트 */
    var clickCount = 0, singleClickTimer;
    /* 변수정의 - 테이블 헤드정보 */
    var ListHead = {};
    /* 변수정의 - 테이블 헤드형식 정보 */
    var ListHeadDefs = {};
    /* 변수정의 - 예산 사용 여부 정보 */
    var isUseBudget = true;
    /* 변수정의 - 결의내역 최대 입력 건수 설정 */
    var maxListLength = 0;
    /* 변수정의 - 검색결과가 1건인 경우 지동 입력 설정 */
    var reflectResultPop = true;
    /* 변수정의 - 법인카드 번호 표시 옵션 */
    var isDisplayFullNumber = true;
    /* 변수정의 - 카드사용내역 연동시 금액 편집 설정 옵션 */
    var updateCardAmt = false;
    /* 변수정의 - 관리항목 필수입력 확인 설정 */
    var chkMngInfo = true;
    /* 변수정의 - 관리항목 누락된 전표 seq */
    var expendListErrorSeq = {};
    /* 변수정의 - 관리항목 누락된 분개 seq */
    var expendSlipErrorSeq = {};
    /* 변수정의 - 관리항목 누락된 관리항목 seq */
    var expendMngErrorSeq = {};
    /* 변수정의 - 예산정보 */
    var expendBudgetInfo = {};
	/* 항목 개수 */
	var listCount = 0;
	/* 회계일자 */
	var datepicker = {};
	/* 지급요청일자 */
	var expendReqDate = {};
	/* 분개단위 입력 여부 */
	var isInsertSlipMode = false;
	
	/* 준성 관리 항목 수정 여부*/
	var hideMngWrite = true;
	
	/* 사용자 */
	var expendEmpChange = false;
	/* 사용부서 */
	var expendDeptChange = false;
	/* 사용부서 > 사용자 귀속 여부 */
	var expendEmpDeptLink = false;
	/* 사용자 - 사용부서 연동 변경 여부 */
	var expendEmpDeptLinkChange = true;
	
	/* 준성 - 상위 예산 레벨 통제로 인한 값 표시 */
	var listIsEdit = false;
	
	var slipIsEdit = false; 
	
	/* 테이블 그리드 */
	var expendListTable = {};
	var expendSlipTable = {};
	var expendMngTable = {};
	/* 팝업 사이즈 관리 */
	var enumSize = {
		commonWidth : 670
		, commonShortHeight : 697
		, commonHeight : 815
		, referenceHeight : 670
		, referenceWidth : 880
	};
	
	/* 부모창 정보 저장 */
	var popParam;
	/* 지출결의 가져오기 팝업창 저장 */
	var historyPop;
	
	/* 버튼설정 정보 필드 */
	var btnInfo;
	
	/* 공통팝업 표준적요 명칭 표시 설정 */
	var summryDisplayOption = 'N';
	
	/* 전자결재 사용 시스템 */
	var eapType;
	
	/* 예산 미연동시 마이너스 지출결의 작성 설정 여부 */
	var isNegativeAmt = false;
	
	/* 선택한 분개의 거래처 정보 저장 변수(ERPiU C15 거래처계좌번호 관리항목 조회시 필요) */
	var slipPartnerCodeInfo = {};
	
	/* 팝업 중복 오픈 방지. */
	var isPopupOpen = false;
	
	/* 오류 체크시 예산 체크 여부 */
	var isBudgetCheck = true;
	
	/* 증빙일자 마감일 */
	var authDateList;
	/* 회계일자 마감일 */
	var expendDateList;
	/* 작성일자 마감일 */
	var createDateList;
	/* 변수정의 - 적요란 표준적요 자동 입력 설정 */
	var isAutoInputNoteInfo = true;
	
	/* 소수점 들어가는 관리항목 Array */
	var arrDotNum = ['B25', 'B26'];
	/* focus 이동 */
	var mode = 0;
	
	/* 관리 항목 세금계산서 확인 */
	var mngInterFaceType;
	
	/*다국어 코드도움 추가  */
	var codeHelperLngpack = '<%=BizboxAMessage.getMessage("TX000016475","코드도움")%>';
	
	/* SSL 적용관련 */
	if (!window.location.origin) {
		window.location.origin = window.location.protocol + "//" + window.location.hostname + (window.location.port ? ':' + window.location.port : '');
  	}
    var originSSL = document.location.origin;
    var origin = document.location.origin.toString().replace('https', 'http');
    
    $(document).ready(function() {
    	    	
    	authDateList = JSON.parse('${ViewBag.authDateList}');
    	expendDateList = JSON.parse('${ViewBag.expendDateList}');
    	createDateList = JSON.parse('${ViewBag.createDateList}');

    	/* 지출결의 작성일 마감 처리*/
    	if( createDateList && createDateList.length > 0 ){
    		var nowDate = new Date();
    		var isClosed = false; 
    		for( var i = 0; i < createDateList.length ; i++ ){
    			var tCloseFromDate = createDateList[i].closeFromDate;
    			var tCloseToDate = createDateList[i].closeToDate;
    			
    			var createFromDate = new Date(tCloseFromDate.substr(0,4), (tCloseFromDate.substr(4,2) - 1), tCloseFromDate.substr(6,2), 00, 00);
    			var createToDate = new Date(tCloseToDate.substr(0,4), (tCloseToDate.substr(4,2) - 1), tCloseToDate.substr(6,2), 23, 59);
        		if( createFromDate.getTime() <= nowDate.getTime() && createToDate.getTime() >= nowDate.getTime()){
        			isClosed = true;
        			break;
        		}
    		}
    		if(isClosed){
    			alert("해당 양식은 관리자가 작성 제한한 상태입니다. 관리자에게 문의 해주세요.");
    			self.close();
    			return false;	
    		}
    	}
    	
    	/* 결재 특이사항 처리 ( approvalInfo_box ) */
    	var tempForm = ${formInfo};
    	var approvalInfo = tempForm.form_alert.split('<br />').join('\r\n');
//     	var approvalInfo = '${formInfo.form_alert}'.split('<br />').join('\r\n');
    	if(approvalInfo === ''){
    		$('#approvalInfo_box').hide();
    	} else {
    		$('#approvalInfo_box').show();
    		$('#formAlert dd').contents().unbind().remove();
    		$('#formAlert').append('<dd>' + approvalInfo.split('\r\n').join('<br />') + '</dd>');
    		
    		$('.signline_info_tit').click(function(){
    			if($(this).hasClass('on')){
    				$(this).removeClass('on');
    			} else {
    				$(this).addClass('on');
    			}
    		});
    		
    		$('.signline_info_tit').addClass('on');
    	}
    	
    	// 결재 특이사항 접힘/펼침 처리
    	fnSetEA230();
    	
    	popParam = window.opener;
    	popupAutoResize();
    	formSeq = ('${ViewBag.formSeq}' || 0);

        fnExpendInit();
        
        datepicker = $("#txtExpendDate").data("kendoDatePicker");
        expendReqDate = $("#txtExpendReqDate").data("kendoDatePicker");
        
        /* 회계일자 마감 설정 */
        fnExpendCloseDateSetting();
        
        /* [+] #. PIMS : M20170705001 >> 종결문서 수정모드에서 접근시 옵션에 따른 회계일자 및 지급요청일자가 강제 변경되어, 지출결의 정보 조회 로직 이전 옵션 반영으로 동작 순서 변경 - 2017-07-05 */
        fnSetExOption(option,'master');
        /* [-] #. PIMS : M20170705001 >> 종결문서 수정모드에서 접근시 옵션에 따른 회계일자 및 지급요청일자가 강제 변경되어, 지출결의 정보 조회 로직 이전 옵션 반영으로 동작 순서 변경 - 2017-07-05 */
        /* 지출결의 생성 */
        if (expend.get('expendSeq') === '0' || expend.get('expendSeq') === '') {
            fnExpendInsert();
            expend.set('json_str', expend.toJSON());
            /* 작성자 생성 */
            expendWriter.set('compSeq', empInfo.compSeq);
            expendWriter.set('empSeq', empInfo.empSeq);
            expendWriter.set('erpCompSeq', empInfo.erpCompSeq);
            expendWriter.set('erpEmpSeq', empInfo.erpEmpSeq);
            expendWriter.set('bizSeq', empInfo.bizSeq);
            fnExpendEmpInsert('writer');
            if( !fnIsWriteEmpInfoOmission() ){
            	window.close();
            	return false;
            }
            /* 사용자 생성 */
            expendUseEmp.set('compSeq', empInfo.compSeq);
            expendUseEmp.set('empSeq', empInfo.empSeq);
            expendUseEmp.set('erpCompSeq', empInfo.erpCompSeq);
            expendUseEmp.set('erpEmpSeq', empInfo.erpEmpSeq);
            expendUseEmp.set('bizSeq', empInfo.bizSeq);
            
            fnExpendEmpInsert('use');
            fnIsEmpInfoOmission();
        }else if(expend.get('expendSeq') !== '0'){
        	// 지출결의 정보 조회
        	fnExpendSelect();
        	fnIsEmpInfoOmission();
        	fnSetExpendErrorInfo();
        	fnSetGridList();
        }
        fnExpendEventInit();
        
        if(isUseBudget){
			isNegativeAmt = false;
		}
        if( isInsertSlipMode ){
        	fnSetGridSlip();
        }
        
        /* 버튼설정값에 따른 반영 동작 시작 */
        fnInitButtonSetting();
        /* 결재 중 수정 진입시 결재상신 버튼 미노출 처리*/
    	if( expend.expendStatCode == '10'){
    		$('#btnDocSaveView').show( );
    	}else {
        	$('#btnDocSaveView').hide( );
        }
        /* 지출결의 전송메뉴 진립시 전송버튼 노출 */
        if('${ViewBag.adminReport}' == 'Y'){
        	$('#btnSendExpend').show();
        	$('#btnSendExpend').click(fnSendExpend);
        }
        
        fnSetEmpDeptOptionSet();
        return;
    });
    
    function fnSetEA230(){
		$.ajax({
			type : "post",
			async : false,
			url : '<c:url value="/form/interloca/FormOptionInfoSelect_ea230.do" />',
			datatype : "json",
			data : {},
			success : function(result) {
				console.log(result);
				
				if(result.result.optionValue) {
					if((result.result.optionValue || '1') == '1') {
						$('div.signline_info_tit').addClass('on');
					} else {
						$('div.signline_info_tit').removeClass('on');
					}
				} else {
					$('div.signline_info_tit').addClass('on'); // 기본값 표시 ( 기존 동일 )
				}
			},
			error : function(e, status) { //error : function(xhr, status, error) {
				console.log(e);
			}
		});
    }
    
    function fnSetEmpDeptOptionSet() {
    	if(expendEmpChange) {
    		$('#txtExpendEmpCode').removeAttr('disabled');
			$('#txtExpendEmpName').removeAttr('disabled');
			$('#btnExpendEmpSearch').show();
    	} else {
    		$('#txtExpendEmpCode').attr('disabled', 'disabled');
			$('#txtExpendEmpName').attr('disabled', 'disabled');
			$('#btnExpendEmpSearch').hide();
    	}
    	
    	if(expendDeptChange) {
    		$('#txtExpendDeptCode').removeAttr('disabled');
			$('#txtExpendDeptName').removeAttr('disabled');
			$('#btnExpendDeptSearch').show();
    	} else {
    		$('#txtExpendDeptCode').attr('disabled', 'disabled');
			$('#txtExpendDeptName').attr('disabled', 'disabled');
			$('#btnExpendDeptSearch').hide();
    	}
    	
    	if(expendEmpDeptLink) {
    		$('#txtExpendDeptCode').attr('disabled', 'disabled');
			$('#txtExpendDeptName').attr('disabled', 'disabled');
			$('#btnExpendDeptSearch').hide();
    	}
    	
    	return;
    }
    
    /* 결의서 전송 [관리자-> 지출결의확인-> 문서 팝업-> 전송] 상배*/
    function fnSendExpend(){
		var advExpendDt =  expend.expendDate;
		var expendSeq = expend.get('expendSeq');
		$.ajax({
			type : "post",
			async : false,
			url : '<c:url value="/expend/ex/admin/ExAdminExpendManagerReportSend.do"></c:url>',
			datatype : "json",
			data : {
				'param' : 'test',
				'expendSeq' : expendSeq,
				'advExpendDt' :  advExpendDt
			},
			success : function(result) {
				if(result.result.resultCode == 'FAIL'){
					alert(result.result.resultName);
				}else{
					alert('지출결의서를 전송하였습니다.');
					$('#btnSendExpend').hide();					
					opener.fnAdminExpendManagerReportSearch();
					
					self.close();
				}				
			},
			error : function(e, status) { //error : function(xhr, status, error) {
				alert(status);
			}
		});
    }
    
	function popupAutoResize() {
	    var thisX = parseInt(document.body.scrollWidth);
	    var thisY = parseInt(document.body.scrollHeight);	    
	    var maxThisX = screen.width - 50;
	    var maxThisY = screen.height - 50;
	    
	    if(maxThisX > 1000) {
	    	maxThisX = 1000;
	    }
	    var marginY = 0;
	    // 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
	    if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45;        // IE 6.x
	    else if(navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75;    // IE 7.x
	    else if(navigator.userAgent.indexOf("Firefox") > 0) marginY = 50;   // FF
	    else if(navigator.userAgent.indexOf("Opera") > 0) marginY = 30;     // Opera
	    else if(navigator.userAgent.indexOf("Netscape") > 0) marginY = -2;  // Netscape

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
	    var windowX = (screen.width - (maxThisX+10))/2;
	    var windowY = (screen.height - (maxThisY))/2 - 20;
	    window.moveTo(windowX,windowY);
	    window.resizeTo(maxThisX, maxThisY);
	}
    
    /* 초기화 */
    function fnExpendInit() {
    	fnExpendInitVariable();
        fnExpendInitLayout();
        fnExpendInitDatepicker();
        fnExpendInitInput();
        return;
    }
	
    /*	[버튼 설정] 버튼설정 메인 함수
	---------------------------------------------------- */
    function fnInitButtonSetting(){
    	/* 버튼설정 정보 객체 생성 */
    	btnInfo = BtnInfo(); 
    	btnInfo.setBtns(${ViewBag.btnInfo});
    	printButton();
    }
	/*	[버튼 설정] 버튼정보 객체 정의
	---------------------------------------------------- */
	function BtnInfo(){
		var btns;
		var length;
		return {
			setBtns : function (data){
				btns = data;
				length = data.length;
			}
			, getBtns : function (){
				return btns;
			}
			, getBtn : function(code){
				for(var i = 0; i < length; i++ ){
					if( btns[i].defaultCode == code){
						return btns[i];
					}
				}
				return null;
			}
		};
	}
	/*	[버튼 설정] View 버튼 동적 생성.
	---------------------------------------------------- */
	function printButton(){
		var btns = btnInfo.getBtns();
		var length = btns.length;
// 		if(length) console.log('button setting initialization..');
		for(var i = 0 ; i < length ; i++){
			var item = btns[i];
			if( (item.defaultElemId == 'btnGetExpendList' || item.defaultElemId == 'btnExpendApproval') && expend.expendStatCode != ''){
				continue;
			}
			var buttonName = item['nm' + '${ViewBag.langKind}'.toUpperCase()] || item.nmBasic;
			var width = item.btnSize;
			if(item.defaultYN == 'Y'){
				console.log(item.extURL);
				/* 기본버튼 생성 */
				var functionName = item.callURL;
				var action = item.defaultYN == 'Y' ? 'javascript:fnButtonAction(\''+functionName+'\', \'' + (item.extURL || '') + '\')' : item.callURL;
				var btnTag = '<button style="width:'+ width +'px;" onClick="'+action+'" id="'+( item.defaultElemId || '' )+'" class="'+ ( item.defaultElemClass || '') +'" value="'+buttonName+'">'+buttonName+'</button>  ';
				$('.btnPosition' + item.position).append(btnTag);
			}else {
				/* 커스텀 버튼 생성 */
				console.log(item.extURL);
				var functionName = 'fnCustom_customAction';
				var action = 'javascript:fnButtonAction(\''+functionName+'\', \'' + (item.extURL || '') + '\')';
				var btnTag = '<button style="width:'+ width +'px;" onClick="'+action+'" id="'+ ( item.defaultElemId || '' ) +'" class="'+ ( item.defaultElemClass || '') +'" value="'+buttonName+'">'+buttonName+'</button>  ';
				$('.btnPosition' + item.position).append(btnTag);
			}
		}
	}
	/*	[버튼 설정] 버튼 이벤트와 트리거 연결
	---------------------------------------------------- */
	function fnButtonAction(func, url){
// 		console.log('Call action to ' + func + ' typeof -> ' + typeof window[func]);
// 		console.log(typeof window[func]);
		if(typeof window[func] === 'function'){
			window[func](url);
		}
	}
	
	/* 커스텀 버튼 예시 */
	function fnCustom_customAction(param){
		// TODO : 커스텀 버튼 예시 
	}
	
	/* [버튼 설정 / 이벤트] 지출결의 가져오기 */
    function fnDefault_inportApproval(){
    	if(isPopupOpen){
	    	return false;
	    }
		var url = "<c:url value='/ex/expend/user/ExpendHistoryPop.do'/>";

    	var popupWidth = 860;
	    var popupHeight = 650;
	    var windowX = (screen.width - popupWidth)/2;
	    var windowY = (screen.height - popupHeight)/2;
	    
	    url += '?expendSeq=' + expend.get('expendSeq');
	    url += '&isInsertSlipMode=' + isInsertSlipMode;
	    url += '&formSeq=' + formInfo.formSeq;
		var win = window.open(url,"${CL.ex_budgetChk}","width="+popupWidth+",height="+popupHeight+",left=" + windowX + ",top=" + windowY);
		
        if(win== null || win.screenLeft == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018810", "브라우져 팝업차단 설정을 확인해 주세요")%>");
        }
        historyPop = win;
    }

    /* [버튼 설정 / 이벤트] 결재상신 */
    function fnDefault_submitApproval() {
 	   	
    	var saveBudgetCheck = isBudgetCheck;
    	isBudgetCheck = true;
    	fnSetExpendErrorInfo();
    	fnSetGridList();
    	
    	if(listSeq != 0){
    		fnSetGridSlip();
    	}
    	
    	isBudgetCheck = saveBudgetCheck; 
    	if(listCount == 0){
    		alert("<%=BizboxAMessage.getMessage("TX000018807", "항목을 생성 후 진행하여 주십시오.")%>");
    		return false;
    	}else if(fnChkErrorRows()){
    		alert("잘못된 지출정보가 존재합니다.\n검증결과로 표시된 붉은색 테두리에 마우스 커서를 갖다대면\n상세정보를 확인하실 수 있습니다.");
    		return false;
    	} 
        var param = {};
        param.processId  = formInfo.formDTp;
        param.approKey  = formInfo.formDTp +'_EX_' + expend.expendSeq;
        param.interlockName  = "이전단계";
		// 20180910 soyoung, interlockName 이전단계 영문/일문/중문 추가
		param.interlockNameEn = "previous step";
		param.interlockNameJp = "以前段階";
		param.interlockNameCn = "以前阶段";
		param.docSeq = '${param.docId}';
        param.formSeq = formInfo.formSeq;
        param.header  = '';
        param.content = '';
        param.footer = '';
        param.expendSeq = expend.expendSeq;
        param.eapCallDomain = originSSL;
      
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/interlock/ExDocMake.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	
            	if(data.result == undefined || data.result == null || data.result.resultCode == undefined || data.result.resultCode != 'SUCCESS'){
            		alert("<%=BizboxAMessage.getMessage("TX000018809", "전자결재 문서 생성 중 오류가 발생하였습니다.")%>");
            		return;
            	}
            	
            	if(data.result.compSeq != data.result.header.compSeq){
            		alert("지출결의서 회사 정보와 로그인 회사정보가 틀립니다. 확인 부탁드립니다.");
            		return;
            	}
            	
                if (data.result.docSeq != '0' && data.result.eaType != '' 
                	 && data.result.formSeq != '0' && data.result.approKey != ''){
	                    popupAutoResize();
                    /* location.href : [기능 : 새로운 페이지로 이동된다] [형태 : 속성] [주소 히스토리 : 기록된다] [사용예 : location.href='url'] */
                    /* location.replace : [기능 : 기존페이지를 새로운 페이지로 변경시킨다] [형태 : 메서드] [주소 히스토리 : 기록되지 않는다] [사용예 : location.replace('url')] */
                    /* 지출결의 특성상 뒤로가기를 이용하여 이전페이지로 돌아오면 안되기 때문에 replace 를 사용한다. */
                    var url = '/'+ data.result.eaType +'/ea/eadocpop/EAAppDocPop.do' + '?form_id=' + data.result.formSeq + '&doc_id=' + data.result.docSeq + '&approkey=' + data.result.approKey;
//                     location.replace(url);

					var thisX = parseInt(document.body.scrollWidth);
					var thisY = parseInt(document.body.scrollHeight);	    
					var maxThisX = screen.width - 50;
					var maxThisY = screen.height - 50;
					
					if(maxThisX > 1000) {
						maxThisX = 1000;
					}
					var marginY = 0;
					// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
					if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45;        // IE 6.x
					else if(navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75;    // IE 7.x
					else if(navigator.userAgent.indexOf("Firefox") > 0) marginY = 50;   // FF
					else if(navigator.userAgent.indexOf("Opera") > 0) marginY = 30;     // Opera
					else if(navigator.userAgent.indexOf("Netscape") > 0) marginY = -2;  // Netscape
					
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
					var windowX = (screen.width - (maxThisX+10))/2;
					var windowY = (screen.height - (maxThisY))/2 - 20;

                    var win = window.open(url,'',"scrollbars=yes,resizable=yes,width="+maxThisX+",height="+(maxThisY - 50)+",top="+windowY+",left="+windowX);
                    if(win== null || win.screenLeft == 0){
                    	if(navigator.userAgent.toLowerCase().toString().indexOf('swing') > -1) {
                    		self.close();
                    	} else {
                    		alert("<%=BizboxAMessage.getMessage("TX000018810", "브라우져 팝업차단 설정을 확인해 주세요")%>");
                    	}
                    }else {
                    	self.close();
                    }
                }
                else{
                	alert("<%=BizboxAMessage.getMessage("TX000018809", "전자결재 문서 생성 중 오류가 발생하였습니다.")%>");
                	return;
                }
            },
            error : function( data ) {
                console.log("! [EX][EXPENDINSERT] ERROR - " + JSON.stringify(data));
                
                // SSL 적용과 관련하여, 실제 서버에서 호출될 경우 SSL 이 적용되지 않은 처리 보완
                // 내부 네트웍망 사용으로 인해 도메인으로 접근이 불가한 경우에 대한 예외처리
                if(originSSL != origin) {
                	originSSL = origin;
	                fnDefault_submitApproval();
            	} else {
                	alert("<%=BizboxAMessage.getMessage("TX000018809", "전자결재 문서 생성 중 오류가 발생하였습니다.")%>");
            	}
            }
        });
        return;
    }
    
    function fnViewSaveDoc(){
    	 /* location.href : [기능 : 새로운 페이지로 이동된다] [형태 : 속성] [주소 히스토리 : 기록된다] [사용예 : location.href='url'] */
        /* location.replace : [기능 : 기존페이지를 새로운 페이지로 변경시킨다] [형태 : 메서드] [주소 히스토리 : 기록되지 않는다] [사용예 : location.replace('url')] */
        /* 지출결의 특성상 뒤로가기를 이용하여 이전페이지로 돌아오면 안되기 때문에 replace 를 사용한다. */
        var saveBudgetCheck = isBudgetCheck;
    	isBudgetCheck = true;
    	fnSetExpendErrorInfo();
    	fnSetGridList();
    	
    	isBudgetCheck = saveBudgetCheck;
    	if(fnChkErrorRows()){
    		alert("잘못된 지출정보가 존재합니다.\n검증결과로 표시된 붉은색 테두리에 마우스 커서를 갖다대면\n상세정보를 확인하실 수 있습니다.");
    		return false;
    	} 
        var url = '/'+ eapType +'/ea/eadocpop/EAAppDocPop.do' + '?form_id=' + expend.formSeq + '&doc_id=' + expend.docSeq;
//         location.replace(url);

		var thisX = parseInt(document.body.scrollWidth);
		var thisY = parseInt(document.body.scrollHeight);	    
		var maxThisX = screen.width - 50;
		var maxThisY = screen.height - 50;
		
		if(maxThisX > 1000) {
			maxThisX = 1000;
		}
		var marginY = 0;
		// 브라우저별 높이 조절. (표준 창 하에서 조절해 주십시오.)
		if (navigator.userAgent.indexOf("MSIE 6") > 0) marginY = 45;        // IE 6.x
		else if(navigator.userAgent.indexOf("MSIE 7") > 0) marginY = 75;    // IE 7.x
		else if(navigator.userAgent.indexOf("Firefox") > 0) marginY = 50;   // FF
		else if(navigator.userAgent.indexOf("Opera") > 0) marginY = 30;     // Opera
		else if(navigator.userAgent.indexOf("Netscape") > 0) marginY = -2;  // Netscape
		
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
		var windowX = (screen.width - (maxThisX+10))/2;
		var windowY = (screen.height - (maxThisY))/2 - 20;

        var win = window.open(url,'',"scrollbars=yes,resizable=yes,width="+maxThisX+",height="+(maxThisY - 50)+",top="+windowY+",left="+windowX);
        if(win== null || win.screenLeft == 0){
        	if(navigator.userAgent.toLowerCase().toString().indexOf('swing') > -1) {
        		self.close();
        	} else {
        		alert("<%=BizboxAMessage.getMessage("TX000018810", "브라우져 팝업차단 설정을 확인해 주세요")%>");
        	}
        }else {
        	self.close();
        }
    }
    
    /* [버튼 설정 / 이벤트] 항목추가 */
    function fnDefault_listAdd( type ) {
    	mode = 0;
		if(!fnIsEmpInfoOmission()){
			return;
		}
		if(isPopupOpen){
	    	return false;
	    }
    	if(listCount < maxListLength){ // 결의내역 최대입력 건수 설정
            var param = {};
            var getParam = '?callback=fnExpend_Callback_ListAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq');
            getParam = getParam + '&listSeq=0';
            param.title = "${CL.ex_listAdd}";
            param.width = enumSize.commonWidth;
            if (ifBudget != '' && ifSystem == 'ERPiU' ) {
                param.height = enumSize.commonHeight;
            } else {
                param.height = enumSize.commonShortHeight;
            }
            param.opener = '2'
            param.parentId = '';
            param.childrenId = '';
            param.getParam = getParam;

            var url = '<c:url value="/ex/expend/list/ExExpendListPopup.do" />' + param.getParam;
            fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);
			
            isPopupOpen = true;
    	}else {
    		alert("<%=BizboxAMessage.getMessage("TX000016473", "항목을 추가 할 수 없습니다. (사유 : 결의내역 최대 입력 건수 초과.) ")%>"+ "\n" + 
    				"<%=BizboxAMessage.getMessage("TX000016481", "지출결의 설정에서 설정 할 수 있습니다.")%>"
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016496", "설정된 최대 개수")%>" + " : "+ maxListLength); 
    	}
    }
	
    /* [버튼 설정 / 이벤트] 항목복사 */
    function fnDefault_listCopy2() {
    	mode = 0;
    	if(isPopupOpen){
	    	return false;
	    }
        var chkSels = $("input[name=inp_ListChk]:checkbox:checked").map(function() {
            return this.value;
        }).get();
        var copyChkCount = chkSels.length;
        
        if(!chkSels || chkSels.length == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000002223", "선택된 항목이 없습니다.　항목을 선택하여 주십시오")%>");
        	return false;
        }else if( expend.get('expendStatCode') == '999' || expend.get('expendStatCode') == '100' || expend.get('erpSendYN') == 'Y'){
        	alert("<%=BizboxAMessage.getMessage("TX000018812", "삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
        	return false;
        }else if(chkSels.length > 0 && chkSels[0] === 'on'){
        	copyChkCount = chkSels.length - 1; // 체크된 개수 확인(전체 체크도 카운트에 포함되어있다.)
        }

		if((listCount + copyChkCount) <= maxListLength){ // 결의내역 최대입력 건수 설정
	        /* 변수정의 */
	        var param = {};
	        var array = [];
	        $.each(chkSels, function( idx, item ) {
	            if (item.toString().split('|').length == 2) {
	                var list = {};
	                $.extend(list, ExExpendList);
	                list.expendSeq = item.toString().split('|')[0];
	                list.listSeq = item.toString().split('|')[1];
	                array.push(list);
	            }
	        });
	        param.listListVo = array;
	        param.listListVo = JSON.stringify(param.listListVo);
	        param.formInfo = JSON.stringify(formInfo);
	        /* 서버호출 */
	        $.ajax({
	            type : 'post',
	            url : '<c:url value="/ex/user/expend/list/ListInfoCopy.do" />',
	            datatype : 'json',
	            async : false,
	            data : param,
	            success : function( data ) {
	            	/* 예산 초과시 복사 안되니까 안내메세지 표시 */
	            	if( data && data.aaData && data.aaData.code == 'FAIL'&& data.aaData.map ){
	            		var budgetOverMsg = data.aaData.message + "\n"; 
	            		budgetOverMsg = budgetOverMsg + data.aaData.map.budgetName +"["+ data.aaData.map.budgetCode +"], ";
	            		if( data.aaData.map.bizplanCode != '' && data.aaData.map.bizplanCode != '***' ){
	            			budgetOverMsg = budgetOverMsg + data.aaData.map.bizplanName +"["+ data.aaData.map.bizplanCode +"], ";	
	            		}
	            		budgetOverMsg = budgetOverMsg + data.aaData.map.bgacctName +"["+ data.aaData.map.bgacctCode +"]";
	            		alert(budgetOverMsg);
	            	}
	            	/* 지출결의 확인에서 수정이 된 경우 지출결의 확인 리스트 갱신 */
	            	if( ( popParam != undefined ) && typeof(popParam.EMR_fnReDrawViewInfo) == 'function'){
	            		popParam.EMR_fnReDrawViewInfo();	
	            	}

                    
	            	fnSetExpendErrorInfo();
	                fnSetGridList();
              		             
	            },
	            error : function( data ) {
	                console.log("! [EX][EXPENDINSERT] ERROR - " + JSON.stringify(data));
	            }
	        });
	        return;
		}else {
			alert("<%=BizboxAMessage.getMessage("TX000016473", "항목을 추가 할 수 없습니다. (사유 : 결의내역 최대 입력 건수 초과.) ")%>"+ "\n" + 
    				"<%=BizboxAMessage.getMessage("TX000016481", "지출결의 설정에서 설정 할 수 있습니다.")%>"
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016498", "선택한 개수")%>" + " : "+ copyChkCount
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016496", "설정된 최대 개수")%>" + " : "+ maxListLength); 
    	}
    }
    
    /* [버튼 설정 / 이벤트] 항목삭제 */
    function fnDefault_listDelete() {
    	mode = 1;
    	if(isPopupOpen){
	    	return false;
	    }
    	fnExpendListDelete();
        if(listCount == 0){
        	datepicker.min(new Date(1900, 0, 01));
        	datepicker.max(new Date(2099, 11, 31));

            $('#txtExpendDate').removeAttr('title');
   
        }
    }
    
    /* [버튼 설정 / 이벤트] 항목수정 */
    function fnDefault_listModify( type ) {
		
    	/* 준성 - 상위 예산 레벨 통제로 인한 값 표시 */
    	if( ifSystem === 'ERPiU'){
    		listIsEdit = true;
    	}
    	
    	mode = 1;
    	if(isPopupOpen){
	    	return false;
	    }
    	var param = {};
        var getParam = '?callback=fnExpend_Callback_ListAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq');
        getParam = getParam + '&listSeq=' + listSeq;
        param.title = "${CL.ex_listAdd}";
        param.width = enumSize.commonWidth;
        if (ifBudget != '' && ifSystem == 'ERPiU') {
            param.height = enumSize.commonHeight;
        } else {
            param.height = enumSize.commonShortHeight;
        }
        param.opener = '2'
        param.parentId = '';
        param.childrenId = '';
        param.getParam = getParam;

        var url = '<c:url value="/ex/expend/list/ExExpendListPopup.do" />' + param.getParam;
        fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);

        isPopupOpen = true;
    }
    
    /* [버튼 설정 / 이벤트] 항목 - 매입전자세금계산서 */
    function fnDefault_electronicInvoice() {
    	if(isPopupOpen){
	    	return false;
	    }
    	if(!fnIsEmpInfoOmission()){
			return;
		}    	
        var param = {};
        var getParam = '?callback=fnExpend_Callback_ETaxAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq');
        param.title = "${CL.ex_electronicInvoice}";
        param.width = 880;
        param.height = 670;
        param.opener = '2'
        param.parentId = '';
        param.childrenId = '';
        param.getParam = getParam;

        var url = '<c:url value="/expend/ex/user/etax/ExExpendETaxPopup.do" />' + param.getParam;
        fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);
        isPopupOpen = true;
    }
    
    /* [버튼 설정 / 이벤트] 항목 - 카드사용내역 */    
    function fnDefault_cardUseHistory(url) {		
    	if(isPopupOpen){
	    	return false;
	    }
		if(!fnIsEmpInfoOmission()){
			return;
		}
    	var param = {};
		var getParam = '?callback=fnExpend_Callback_CardAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq') + '&isSearchWithCancel=N';
		param.title = "${CL.ex_cardUseHistory}"; 
		param.width = enumSize.referenceWidth;
		param.height = enumSize.referenceheight;
	    param.height = 808;
		param.opener = '2'
		param.parentId = '';
		param.childrenId = '';
		param.getParam = getParam;
		
		var url = ((url || '') != '' ? url : '<c:url value="/ex/card/UserCardUsageHistoryPop.do" />') + param.getParam;
		fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);
		isPopupOpen = true;
    }
    
    /* [버튼 설정 / 이벤트] 항목 - 카드사용내역 취소분 포함 */    
    function fnDefault_cardUseHistoryWithCancel() {		
    	if(isPopupOpen){
	    	return false;
	    }
		if(!fnIsEmpInfoOmission()){
			return;
		}
    	var param = {};
		var getParam = '?callback=fnExpend_Callback_CardAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq') + '&isSearchWithCancel=Y';
		param.title = "${CL.ex_cardUseHistory}"; 
		param.width = enumSize.referenceWidth;
		param.height = enumSize.referenceheight;
	    param.height = 808;
		param.opener = '2'
		param.parentId = '';
		param.childrenId = '';
		param.getParam = getParam;
		
		var url = '<c:url value="/ex/card/UserCardUsageHistoryPop.do" />' + param.getParam;
		fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);
		isPopupOpen = true;
    }
    
    /* [버튼 설정 / 이벤트] 분개 - 분개추가 */    
    function fnDefault_additionJournalizing( type ) {
    	if(isPopupOpen){
	    	return false;
	    }
    	if(!fnIsEmpInfoOmission()){
			return;
		}    	
        var param = {
                getParam : null,
                title : null,
                width : null,
                height : null,
                opener : "2",
                parentId : null,
                childrenId : null
            };
        
        if ($('.ExpendList').css('display') != 'none' && (listSeq == '' || listSeq == '0')) {
            alert("<%=BizboxAMessage.getMessage("TX000009511", "항목이 선택되지 않았습니다")%>");
            return;
        }
        var getParam = '?callback=fnExpend_Callback_SlipAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq') + '&listSeq=' + listSeq;
        getParam = getParam + '&slipSeq=0';
        param.title = "${CL.ex_additionJournalizing}";
        param.width = enumSize.commonWidth;
        param.height = 670;
        param.opener = '2'
        param.parentId = '';
        param.childrenId = '';
        param.getParam = getParam;

        var url = '<c:url value="/ex/expend/slip/ExExpendSlipPopup.do" />' + param.getParam;
        fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);
        isPopupOpen = true;
    }
    
    /* [버튼 설정 / 이벤트] 분개 - 분개복사 */   
    function fnDefault_copyJournalizing() {
    	if(isPopupOpen){
	    	return false;
	    }
    	var selectListSeq = listSeq;
    	fnExpendSlipCopy2();
    	listSeq = selectListSeq;
    }
    /* [버튼 설정 / 이벤트] 분개 - 분개삭제 */
    function fnDefault_deleteJournalizing() {
    	if(isPopupOpen){
	    	return false;
	    }
    	var selectListSeq = listSeq;
        fnExpendSlipDelete();
        listSeq = selectListSeq;
    }
    /* [버튼 설정 / 이벤트] 분개 - 분개수정 */
    function fnDefault_modifyJournalizing( type ) {
    	/* 준성 - 상위 예산통제 수정 */
    	if( ifSystem === 'ERPiU'){
    		slipIsEdit = true;
    	}
    	
    	if(isPopupOpen){
	    	return false;
	    }
    	if (listSeq == '' || listSeq == '0') {
            alert("<%=BizboxAMessage.getMessage("TX000009511", "항목이 선택되지 않았습니다")%>");
            return;
        }
        if (slipSeq == '' || slipSeq == '0') {
            alert("<%=BizboxAMessage.getMessage("TX000009510", "분개가 선택되지 않았습니다")%>");
            return;
        }

        var getParam = '?callback=fnExpend_Callback_SlipAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq') + '&listSeq=' + listSeq;
        getParam = getParam + '&slipSeq=' + slipSeq;
        var param = {};
        param.title = "${CL.ex_additionJournalizing}";
        param.width = enumSize.commonWidth;
        param.height = 718;
        param.opener = '2'
        param.parentId = '';
        param.childrenId = '';
        param.getParam = getParam;

        var url = '<c:url value="/ex/expend/slip/ExExpendSlipPopup.do" />' + param.getParam;
        fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);
        isPopupOpen = true;
    }
    
    /* [버튼 설정 / 이벤트] 분개 - 매입전자세금계산서 */
    function fnDefault_electronicInvoiceSlip() {
    	if(isPopupOpen){
	    	return false;
	    }
    	var param = {};
        var getParam = '?callback=fnExpend_Callback_ETaxAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq');
        param.title = "${CL.ex_electronicInvoice}";
        param.width = 880;
        // if (ifBudget != '') {
        //    param.height = 808;
        // } else {
            param.height = 670;
        // }
        param.opener = '2'
        param.parentId = '';
        param.childrenId = '';
        param.getParam = getParam;

        var url = '<c:url value="/expend/ex/user/etax/ExExpendETaxPopup.do" />' + param.getParam;
        fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);
        isPopupOpen = true;
    }
    
    /* [버튼 설정 / 이벤트] 분개 - 카드사용내역 */
    function fnDefault_cardUseHistorySlip() {			
    	if(isPopupOpen){
	    	return false;
	    }
    	var param = {};
		var getParam = '?callback=fnExpend_Callback_CardAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq');
		param.title = "${CL.ex_cardUseHistory}"; 
		param.width = enumSize.referenceWidth;
		param.height = enumSize.referenceheight;
	    param.height = 808;
		param.opener = '2'
		param.parentId = '';
		param.childrenId = '';
		param.getParam = getParam;
		
		var url = '<c:url value="/ex/card/UserCardUsageHistoryPop.do" />' + param.getParam;
		fnExLayerPopOpen(url, '', param.title, param.width, '', param.opener, param.parentId, param.childrenId);
		isPopupOpen = true;
    }
    /* [버튼 설정 / 이벤트] 관리항목 - 수정 */
    function fnDefault_modifyMng() {
    	if(isPopupOpen){
	    	return false;
	    }
    	if (listSeq == '' || listSeq == '0') {
            alert("<%=BizboxAMessage.getMessage("TX000009511", "항목이 선택되지 않았습니다")%>");
            return;
        }
        if (slipSeq == '' || slipSeq == '0') {
            alert("<%=BizboxAMessage.getMessage("TX000009510", "분개가 선택되지 않았습니다")%>");
            return;
        }
        if (mngSeq == '' || mngSeq == '0') {
            alert("<%=BizboxAMessage.getMessage("TX000009509", "관리항목이 선택되지 않았습니다")%>");
            return;
        }

        var getParam = '?callback=fnExpend_Callback_MngMod&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq') + '&listSeq=' + listSeq + '&slipSeq=' + slipSeq;
        getParam = getParam + '&mngSeq=' + mngSeq;
        var param = {};
        param.title = "<%=BizboxAMessage.getMessage("TX000009508", "관리항목 수정")%>";
        param.width = enumSize.commonWidth;
        param.height = 689;
        param.opener = '2'
        param.parentId = '';
        param.childrenId = '';
        param.getParam = getParam;

        var url = '<c:url value="/ex/expend/mng/ExExpendMngPopup.do" />' + param.getParam;
        fnExLayerPopOpen(url, '', param.title, param.width, param.height, param.opener, param.parentId, param.childrenId);
        isPopupOpen = true;
    }
    
    /* [-] 버튼 이벤트 바인드 */
    function fnIsWriteEmpInfoOmission(){
    	if( expendWriter.erpEmpSeq === '0' || expendWriter.erpEmpSeq === '' ){
    		alert("작성자의 ERP사번이 설정되지 않았습니다. ERP 사번을 설정 후 진행하여 주십시오.");
    		return false;
    	}
       	// 사업장, 부서, 코스트센터, 회계단위
		if( expendWriter.erpBizSeq === '0' || expendWriter.erpBizSeq === '' ){
			alert("<%=BizboxAMessage.getMessage("TX000018785", "작성자의 사업장이 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
			return false;
		}
		if( expendWriter.erpDeptSeq === '0' || expendWriter.erpDeptSeq === '' ){
			alert("<%=BizboxAMessage.getMessage("TX000018788", "작성자의 부서가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
			return false;
		}
		if( ifSystem === 'ERPiU'){
			if( expendWriter.erpCcSeq === '0' || expendWriter.erpCcSeq === '' ){
				alert("<%=BizboxAMessage.getMessage("TX000018789", "작성자의 코스트센터가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
				return false;
			}
			if( expendWriter.erpPcSeq === '0' || expendWriter.erpPcSeq === '' ){
				alert("<%=BizboxAMessage.getMessage("TX000018790", "작성자의 회계단위가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
				return false;
			}
		}
		return true;
       }
    
    function fnIsEmpInfoOmission(){
     // 사업장, 부서, 코스트센터, 회계단위 
        if( expendUseEmp.erpBizSeq === '0' || expendUseEmp.erpBizSeq === '' ){
         alert("<%=BizboxAMessage.getMessage("TX000018785", "작성자의 사업장이 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
         return false;
        }
        if( expendUseEmp.erpDeptSeq === '0' || expendUseEmp.erpDeptSeq === '' ){
         alert("<%=BizboxAMessage.getMessage("TX000018788", "작성자의 부서가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
         return false;
        }
        if( ifSystem === 'ERPiU'){
         if( expendUseEmp.erpCcSeq === '0' || expendUseEmp.erpCcSeq === '' ){
             alert("<%=BizboxAMessage.getMessage("TX000018789", "작성자의 코스트센터가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
             return false;
            }
         if( expendUseEmp.erpPcSeq === '0' || expendUseEmp.erpPcSeq === '' ){
             alert("<%=BizboxAMessage.getMessage("TX000018790", "작성자의 회계단위가 누락되었습니다. 확인 후 진행하여 주십시오.")%>");
             return false;
            }
        }
        return true;
    }
    
    /* 초기화 - 변수 */
    function fnExpendInitVariable(){
    	/* 서버 호출 */
    	var param = {'formSeq' : formSeq};  
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/master/ExUserInitExpend.do"/>',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
//             	console.log(data);
            	eapType = data.eaType;
            	if(data.aaData !== null){
            		
            		$("#formNameTitle").html((data.aaData.formInfo.formName || "<%=BizboxAMessage.getMessage("TX000003029", "지출결의서")%>"));
	            	gridList = JSON.parse(data.aaData.jsonParam.gridList); /* 항목 그리드 */
	                gridSlip = JSON.parse(data.aaData.jsonParam.gridSlip); /* 분개 그리드 */
	                gridMng = JSON.parse(data.aaData.jsonParam.gridMng); /* 관리항목 그리드 */
	                /* 변수정의 - 지출결의 작성시 필요 기본 데이터 - 시스템연동정보 */
	                ifSystem = data.aaData.ifSystem; /* 팝업 사용 */
	                ifBudget = data.aaData.ifBudget; /* 팝업 사용 */
	                
	                /* 사용자 정보 */
	                empInfo = JSON.parse(data.aaData.jsonParam.empInfo);
	                /* 양식정보 */
	                formInfo = JSON.parse(data.aaData.jsonParam.formInfo);
	                /* 옵션정보 */
	                option = JSON.parse(data.aaData.jsonParam.optionListInfo); /* 지출결의 옵션 */
	                /* 예산정보 */
	                if(data.aaData.ifSystem === 'iCUBE'){
	                	expendBudgetInfo.erpType = 'iCUBE';
	                	if(data.aaData.iCubeBudgetType === 'NOTUSE'){
	                		//예산 정보 없음
	                		expendBudgetInfo.useYN = 'N';	    
	                		expendBudgetInfo.budgetType ='';
	                	}
	                	else{
	                		//예산정보 생성
	                		expendBudgetInfo.useYN = 'Y';	           
	                		expendBudgetInfo.budgetType = data.aaData.iCubeBudgetType;
	                	}
	                }else if( data.aaData.ifSystem === 'ERPiU'){
	                	expendBudgetInfo.useYN = 'Y';
	                	expendBudgetInfo.erpType = 'ERPiU';
	                }
	                /* 변수정의 - 지출결의 */	              	   
	                expend = new kendo.data.ObservableObject(ExExpend);	            
	                expendWriter = new kendo.data.ObservableObject(ExCodeOrg);  
	                expendUseEmp = new kendo.data.ObservableObject(ExCodeOrg);  
	                expendPartner = new kendo.data.ObservableObject(ExCodePartner); 
	                expendProject = new kendo.data.ObservableObject(ExCodeProject);  
	                expendCard =new kendo.data.ObservableObject(ExCodeCard); 
	                
	                // 지출결의 이전단계 로직
	                expend.set('expendSeq', '${ViewBag.expendSeq}');
	                expend.set('expendStatCode', '${ViewBag.expendStatCode}');
	                expend.set('erpSendYN', '${ViewBag.erpSendYN}');
	                
            	}
            	else
           		{
            		alert("<%=BizboxAMessage.getMessage("TX000018799", "지출결의 작성 초기화에 실패하였습니다")%>");
            		return false;
           		}
            },
            error : function( data ) {
                console.log("! [EX][LOAD_INIT_VALIABLE]] ERROR - " + JSON.stringify(data));
            }
        });
    	
    }
    
    /* 초기화 - layout */
    function fnExpendInitLayout() {
    	/* "[예산연동] 예산연동 사용여부 설정 ( 기본 : 미사용 )" */
    	var caseCnt = 0;
        $.each(option, function( idx, item ) {
        	if( !( item.option_code == '003301' && item.option_value == 'Y' ) ){
        		caseCnt ++ ;
        	}else{
        		console.log('The budget used form . set budget option USE.');
        	}
        });
        
        if(option.length == caseCnt){
        	ifBudget = '';
        }

        $('.ExpendBizboxA').hide();
        $('.ExpendiCUBE').hide();
        $('.ExpendERPiU').hide();
        /* 개발범위 제한으로, 사용자만 노출 */
        $('.Expend' + '${ViewBag.ifSystem}' + '.ExpendEmp').show();
        /* 결재 중 수정 진입시 결재상신 버튼 미노출 처리*/
    	if( expend.expendStatCode == '10'){
    		$('#btnDocSaveView').show( );
    		$('#btnExpendApproval').hide( );
        	$('#btnGetExpendList').hide( );
    	}else if( expend.expendStatCode == '20' || expend.expendStatCode == '90' ){
        	$('#btnExpendApproval').hide( );
        	$('#btnGetExpendList').hide( );
        	$('#btnDocSaveView').hide( );
        }
        //헤더 정보 조회
        fnSetGridHead("List");
        fnSetGridHead("Slip");
        fnSetGridList();
        fnSetGridSlip();
        fnSetGridMngBind();
        return;
    }
    /* 초기화 - datepicker */
    function fnExpendInitDatepicker() {
        $('#txtExpendDate').setKendoDatePicker(function() {
        	var textExpendDate = $("#txtExpendDate").val().toString().replace(/-/g, '')
        	if(textExpendDate.indexOf("_") == -1 ){
        		/* 날짜 형식 체크 (예를들어 4월 30일 까지 밖에 없는데 4월 31일 입력한 경우)
        		   예산 사용인 경우 항목이 한 개 이상 존재하면서 년도와 월이 다른 경우는 변경 안됨.
        		   예산 미사용인 경우 날짜 형식만 맞으면 상관없음. 
        		*/
        		var year = Number(textExpendDate.substr(0,4));
        		var month = Number(textExpendDate.substr(4,2));
        		var day = Number(textExpendDate.substr(6,2));
        		var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
                var maxDay = maxDaysInMonth[month-1];
                // 윤년 체크
                if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
                    maxDay = 29;
                }
                 
        		if( day<=0 || day>maxDay || month <= 0 || month > 12
        				||( ( textExpendDate.substr(0,4) != expend.expendDate.substr(0,4) || textExpendDate.substr(4,2) != expend.expendDate.substr(4,2) ) && isUseBudget && listCount > 0) ){
        			/* 이상한 날짜인 경우 기존 지출결의 회계일자로 설정 */
        			var tExpendDate = expend.expendDate;
           			if(tExpendDate.length == 8 ){
           				tExpendDate = tExpendDate.substr(0,4) + '-' + tExpendDate.substr(4,2) + '-' + tExpendDate.substr(6,2);
           			}
    				datepicker.value(tExpendDate);
    				$('#txtExpendDate').val(tExpendDate);
        		}else{
        			/* 회계일자 마감일 확인 진행 */
        			var isClosed = false;
					for( var i = 0 ; i < expendDateList.length ; i++){
						var tDate = expendDateList[i];
						// 마감 시작일과 종료일 사이에 선택한 회계일자가 있는 경우 입력 제한한다.
						if( tDate.closeFromDate <= textExpendDate && textExpendDate <= tDate.closeToDate ){
							isClosed = true;
							break;
						}
					}
        			
        			/* 날짜가 정상인 경우 입력한 회계일자로 설정 */
        			if( !isClosed ){
        				expend.set('expendDate', textExpendDate);
        			}else{
        				alert("등록된 회계일자가 지출결의 작성 마감 기간에 포함되어 있어 선택이 제한됩니다.");
        				var tExpendDate = expend.expendDate;
               			if(tExpendDate.length == 8 ){
               				tExpendDate = tExpendDate.substr(0,4) + '-' + tExpendDate.substr(4,2) + '-' + tExpendDate.substr(6,2);
               			}
        				datepicker.value(tExpendDate);
        				$('#txtExpendDate').val(tExpendDate);
        			}
        				
        		}
       		}else{
       			var tExpendDate = expend.expendDate;
       			if(tExpendDate.length == 8 ){
       				tExpendDate = tExpendDate.substr(0,4) + '-' + tExpendDate.substr(4,2) + '-' + tExpendDate.substr(6,2);
       			}
				datepicker.value(tExpendDate);
				$('#txtExpendDate').val(tExpendDate);
       		}
        });
        $('#txtExpendReqDate').setKendoDatePicker(function() {
        	var textExpendReqDate = $("#txtExpendReqDate").val().toString().replace(/-/g, '')
//         	if($("#txtExpendReqDate").val().toString().replace(/-/g, '').indexOf("_") == -1){
       		if(textExpendReqDate.indexOf("_") == -1 ){
	       		/* 날짜 형식 체크 (예를들어 4월 30일 까지 밖에 없는데 4월 31일 입력한 경우)
	     		   예산 사용인 경우 항목이 한 개 이상 존재하면서 년도와 월이 다른 경우는 변경 안됨.
	     		   예산 미사용인 경우 날짜 형식만 맞으면 상관없음. 
	     		*/
				var year = Number(textExpendReqDate.substr(0,4));
				var month = Number(textExpendReqDate.substr(4,2));
				var day = Number(textExpendReqDate.substr(6,2));
				var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
				var maxDay = maxDaysInMonth[month-1];
				// 윤년 체크
				if( month==2 && ( year%4==0 && year%100!=0 || year%400==0 ) ) {
					maxDay = 29;
				}
				
				if( day<=0 || day>maxDay || month <= 0 || month > 12){
					/* 이상한 날짜인 경우 기존 지출결의 지급요청일자로 설정 */
					var tExpendReqDate = expend.expendReqDate;
	       	        if(tExpendReqDate.length == 8 ){
	       	        	tExpendReqDate = tExpendReqDate.substr(0,4) + '-' + tExpendReqDate.substr(4,2) + '-' + tExpendReqDate.substr(6,2);
	       	        }
	       			expendReqDate.value(tExpendReqDate);
	       			$('#txtExpendReqDate').val(tExpendReqDate);
				}else{
					/* 날짜가 정상인 경우 입력한 지급요청일자로 설정 */
					expend.set('expendReqDate', $("#txtExpendReqDate").val().toString().replace(/-/g, ''));	
	        	}
       		}else{
       	        var tExpendReqDate = expend.expendReqDate;
       	        if(tExpendReqDate.length == 8 ){
       	        	tExpendReqDate = tExpendReqDate.substr(0,4) + '-' + tExpendReqDate.substr(4,2) + '-' + tExpendReqDate.substr(6,2);
       	        }
       			expendReqDate.value(tExpendReqDate);
       			$('#txtExpendReqDate').val(tExpendReqDate);
        	}
        });
        $('#txtExpendDate, #txtExpendReqDate').setKendoDatePickerMask();

        var date = new Date(); /* 회계일자와 지급요청일 정보가 없을경우, 오늘 입력 */
        $('#txtExpendDate').val('${ViewBag.expendDate}' || fnFormatDate('yyyy-MM-dd', date));
        $('#txtExpendReqDate').val('${ViewBag.expendReqDate}' || fnFormatDate('yyyy-MM-dd', date));
        expend.set('expendDate', '${ViewBag.expendDate}' || fnFormatDate('yyyy-MM-dd', date));
        expend.set('expendReqDate', '${ViewBag.expendReqDate}' || fnFormatDate('yyyy-MM-dd', date));
        
        return;
    }
    /* 초기화 - input */
    function fnExpendInitInput() {
        return;
    }

    /* 이벤트초기화 */
    function fnExpendEventInit() {
        fnExpendEventInitButton();
        return;
    }

    /* 이번트초기화 - 버튼 */
    function fnExpendEventInitButton() {
        /* 변수정의 */
        // var methodName = fnGetName().name;
        var param = {
            getParam : null,
            title : null,
            width : null,
            height : null,
            opener : "2",
            parentId : null,
            childrenId : null
        };
                
        /* 항목정보 : 카드사용내역, 항목추가, 항목복사, 항목 삭제 */
        /* 항목추가 */
        $('#btnExpendListAdd').click(function( type ) {
        	if(listCount < maxListLength){ // 결의내역 최대입력 건수 설정
	            var param = {};
	            var getParam = '?callback=fnExpend_Callback_ListAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq');
	            getParam = getParam + '&listSeq=0';
	            param.title = "${CL.ex_listAdd}";
	            param.width = enumSize.commonWidth;
	            if (ifBudget != '' && ifSystem == 'ERPiU' ) {
	                param.height = enumSize.commonHeight;
	            } else {
	                param.height = enumSize.commonShortHeight;
	            }
	            param.opener = '2'
	            param.parentId = '';
	            param.childrenId = '';
	            param.getParam = getParam;
	
	            var url = '<c:url value="/ex/expend/list/ExExpendListPopup.do" />' + param.getParam;
	            fnExLayerPopOpen(url, '', param.title, param.width, param.height, param.opener, param.parentId, param.childrenId);
        	}else {
        		alert("<%=BizboxAMessage.getMessage("TX000016473", "항목을 추가 할 수 없습니다. (사유 : 결의내역 최대 입력 건수 초과.) ")%>"+ "\n" + 
        				"<%=BizboxAMessage.getMessage("TX000016481", "지출결의 설정에서 설정 할 수 있습니다.")%>"
        				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016496", "설정된 최대 개수")%>" + " : "+ maxListLength); 
        	}
        });
        /* 항목수정 */
        $('#btnExpendListMod').click(function( type ) {
            var param = {};
            var getParam = '?callback=fnExpend_Callback_ListAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq');
            getParam = getParam + '&listSeq=' + listSeq;
            param.title = "${CL.ex_listAdd}";
            param.width = enumSize.commonWidth;
            if (ifBudget != '' && ifSystem == 'ERPiU') {
                param.height = enumSize.commonHeight;
            } else {
                param.height = enumSize.commonShortHeight;
            }
            param.opener = '2'
            param.parentId = '';
            param.childrenId = '';
            param.getParam = getParam;

            var url = '<c:url value="/ex/expend/list/ExExpendListPopup.do" />' + param.getParam;
            fnExLayerPopOpen(url, '', param.title, param.width, param.height, param.opener, param.parentId, param.childrenId);
        });

        /* 항목삭제 */
        /* 버튼설정 피해자 */
        $('#btnExpendListDelete').click(function() {
            fnExpendListDelete();
            if(listCount == 0){
//             	datepicker.enable();
            	// 회계일자 초기화
            	datepicker.min(new Date(1900, 0, 01));
            	datepicker.max(new Date(2099, 11, 31));
        
            	$('#txtExpendDate').removeAttr('title');
            }
        });
        
        /* 분개수정 */
        $('#btnExpendSlipMod').click(function( type ) {
            if (listSeq == '' || listSeq == '0') {
                alert("<%=BizboxAMessage.getMessage("TX000009511", "항목이 선택되지 않았습니다")%>");
                return;
            }
            if (slipSeq == '' || slipSeq == '0') {
                alert("<%=BizboxAMessage.getMessage("TX000009510", "분개가 선택되지 않았습니다")%>");
                return;
            }

            var getParam = '?callback=fnExpend_Callback_SlipAdd&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq') + '&listSeq=' + listSeq;
            getParam = getParam + '&slipSeq=' + slipSeq;
            param.title = "${CL.ex_additionJournalizing}";
            param.width = enumSize.commonWidth;
            param.height = 718;
            param.opener = '2'
            param.parentId = '';
            param.childrenId = '';
            param.getParam = getParam;

            var url = '<c:url value="/ex/expend/slip/ExExpendSlipPopup.do" />' + param.getParam;
            fnExLayerPopOpen(url, '', param.title, param.width, param.height, param.opener, param.parentId, param.childrenId);
        });
        
        /* 관리항목 수정 */
        $('#btnExpendMngMod').click(function() {
            if (listSeq == '' || listSeq == '0') {
                alert("<%=BizboxAMessage.getMessage("TX000009511", "항목이 선택되지 않았습니다")%>");
                return;
            }
            if (slipSeq == '' || slipSeq == '0') {
                alert("<%=BizboxAMessage.getMessage("TX000009510", "분개가 선택되지 않았습니다")%>");
                return;
            }
            if (mngSeq == '' || mngSeq == '0') {
                alert("<%=BizboxAMessage.getMessage("TX000009509", "관리항목이 선택되지 않았습니다")%>");
                return;
            }

            var getParam = '?callback=fnExpend_Callback_MngMod&compSeq=' + empInfo.compSeq + '&formSeq=' + formInfo.formSeq + '&expendSeq=' + expend.get('expendSeq') + '&listSeq=' + listSeq + '&slipSeq=' + slipSeq;
            getParam = getParam + '&mngSeq=' + mngSeq;
            param.title = "<%=BizboxAMessage.getMessage("TX000009508", "관리항목 수정")%>";
            param.width = enumSize.commonWidth;
            param.height = 689;
            param.opener = '2'
            param.parentId = '';
            param.childrenId = '';
            param.getParam = getParam;

            var url = '<c:url value="/ex/expend/mng/ExExpendMngPopup.do" />' + param.getParam;
            fnExLayerPopOpen(url, '', param.title, param.width, param.height, param.opener, param.parentId, param.childrenId);
        });
        /* 공통코드 : 사용자, 회계단위, 코스트센터, 예산단위, 사업계획, 예산계정, 프로젝트, 거래처, 카드 */
        $('#btnExpendEmpSearch, #btnExpendDeptSearch, #btnExpendPcSearch, #btnExpendCcSearch, #btnExpendBudgetSearch, #btnExpendBizplanSearch, #btnExpendBgAcctSearch, #btnExpendProjectSearch, #btnExpendPartnerSearch, #btnExpendCardSearch').click(function() {
            switch (this.id.toString().replace('btn', '')) {
                case "ExpendEmpSearch": /* 사용자 */
                    fnExpendMasterEmpPop();
                    break;
                case "ExpendDeptSearch": /* 사용부서 */
                    fnExpendMasterDeptPop();
                    break;
                case "ExpendPcSearch": /* 회계단위 */
                	fnExpendMasterPcPop();
                    break;
                case "ExpendCcSearch": /* 코스트센터 */
                    fnExpendMasterCcPop();
                    break;
                case "ExpendBudgetSearch": /* 예산단위 */
                    fnExpendMasterBudgetPop();
                    break;
                case "ExpendBizplanSearch": /* 사업계획 */
                    fnExpendMasterBizPlanPop();
                    break;
                case "ExpendBgAcctSearch": /* 예산계정 */
                    fnExpendMasterBgAcctPop();
                    break;
                case "ExpendProjectSearch": /* 프로젝트 */
                    fnExpendMasterProjectPop();
                    break;
                case "ExpendPartnerSearch": /* 거래처 */
                    fnExpendMasterPartnerPop();
                    break;
                case "ExpendCardSearch": /* 카드 */
                    fnExpendMasterCardPop();
                    break;
            }
        });

        $('#txtExpendDate').keydown(function(event){
        	/* 엔터입력 이벤트 적용 */
            if (event.which == 13 || event.which == 113) {
            	datepicker.trigger("change");
            }
        });
        $('#txtExpendReqDate').keydown(function(event){
        	/* 엔터입력 이벤트 적용 */
            if (event.which == 13 || event.which == 113) {
            	expendReqDate.trigger("change");
            }
        });
        
        $('#txtExpendEmpName').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.which == 113) {
            	fnExpendMasterEmpPop('Y');
            }
        });
        
        $('#txtExpendDeptName').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.which == 113) {
            	fnExpendMasterDeptPop('Y');
            }
        });
        
        $('#txtExpendProjectName').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.which == 113) {
            	fnExpendMasterProjectPop('Y');
            }
        });
        $('#txtExpendPartnerName').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.which == 113) {
            	fnExpendMasterPartnerPop('Y');
            }
        });
        
        $('#txtExpendPartnerName').focusout(function(event){
        	/* ERPiU의 00거래처는 사용자가 거래처 명 입력 가능 2018. 03. 29 - 신재호 */
			if(ifSystem == 'ERPiU' && expendPartner.get('partnerCode') == '00'){
				expendPartner.set('partnerName', $('#txtExpendPartnerName').val());
			}
        });
        
        $('#txtExpendCardName').keydown(function(event){
            /* 엔터입력 이벤트 적용 */
            if (event.which == 113) {
            	fnExpendMasterCardPop('Y');
            }
        });
        return;
    }

    /* 이벤트 - 버튼 - 사용자 */
    function fnExpendMasterEmpPop( input ) {
    	
    	if(!expendEmpChange) {
    		alert('사용자를 변경할 수 없습니다.');
    		return;
    	}
    	
		input = (input || '');
		var search_str = '';
		if (input == 'Y') {
			search_str = $('#txtExpendEmpName').val();
		} else {
			search_str = '';
		}
		
		// 파라미터 추가 필
		var Popresult = fnOpenCodePop({
			codeType : 'Emp'
			, callback : 'fnExpend_Callback_Emp'
			, searchStr : search_str
			, erp_dept_seq : (expendEmpDeptLink ? expendUseEmp.get("erpDeptSeq") : '')
			, reflectResultPop : reflectResultPop
		});
		
		return;
    }
    
    /* 이벤트 - 버튼 - 사용부서 */
   	function fnExpendMasterDeptPop(input){
    	
    	if(!expendDeptChange) {
    		alert('사용부서를 변경할 수 없습니다.');
    		return;
    	}
    	
		input = (input || '');
		var search_str = '';
		if (input == 'Y') {
			search_str = $('#txtExpendDeptName').val();
		} else {
			search_str = '';
		}
		
		// 신규 팝
		var Popresult = fnOpenCodePop({
			codeType : 'Dept'
			, callback : 'fnExpend_Callback_Dept'
			, searchStr : search_str
			, reflectResultPop : reflectResultPop
		});
    	
    	return;
    }
    
    /* 이벤트 - 버튼 - 회계단위 */
    function fnExpendMasterPcPop( input ) {
    	input = (input || '');
    	var search_str = '';
    	if (input == 'Y') {
    		search_str = $('#txtExpendPcName').val();
    	} else {
    		search_str = '';
    	}
    	
    	var Popresult = fnOpenCodePop({
    		codeType : 'Pc'
    		, callback : 'fnExpend_Callback_PC'
    		, searchStr : search_str
    		, reflectResultPop : reflectResultPop
    	});
    }
    /* 이벤트 - 버튼 - 코스트센터 */
    function fnExpendMasterCcPop( input ) {
    	input = (input || '');
    	var search_str = '';
    	if (input == 'Y') {
    		search_str = $('#txtExpendCcName').val();
    	} else {
    		search_str = '';
    	}
    	
    	var Popresult = fnOpenCodePop({
    		codeType : 'Cc'
    		, callback : 'fnExpend_Callback_CC'
    		, searchStr : search_str
    		, reflectResultPop : reflectResultPop
    	});
    }
    /* 이벤트 - 버튼 - 예산단위 */
    function fnExpendMasterBudgetPop(input){
    	input = (input || '');
    	var search_str = '';
    	if (input == 'Y') {
    		search_str = $('#txtExpendBudgetName').val();
    	} else {
    		search_str = '';
    	}
    	
    	var Popresult = fnOpenCodePop({
    		codeType : 'Budget'
    		, callback : 'fnExpend_Callback_Budget'
    		, searchStr : search_str
    		, reflectResultPop : reflectResultPop
    	});
    }
    
    /* 이벤트 - 버튼 - 사업계획 */
    function fnExpendMasterBizPlanPop(input){ 
    	input = (input || '');
    	var search_str = '';
    	if (input == 'Y') {
    		search_str = $('#txtExpendBizplanName').val();
    	} else {
    		search_str = '';
    	}
    	
    	var Popresult = fnOpenCodePop({
    		codeType : 'Bizplan'
    		, callback : 'fnExpend_Callback_Bizplan'
    		, searchStr : search_str
    		, reflectResultPop : reflectResultPop
    	});
    }
    
    /* 이벤트 - 버튼 - 예산계정 */
    function fnExpendMasterBgAcctPop(input){ 
    	input = (input || '');
    	var search_str = '';
    	if (input == 'Y') {
    		search_str = $('#txtExpendBgAcctName').val();
    	} else {
    		search_str = '';
    	}
    	
    	var Popresult = fnOpenCodePop({
    		codeType : 'BgAcct'
    		, callback : 'fnExpend_Callback_BgAcct'
    		, acct_code : ''
    		, searchStr : search_str
    		, reflectResultPop : reflectResultPop
    	});
    }
    
    /* 이벤트 - 버튼 - 프로젝트 */
    function fnExpendMasterProjectPop( input ) {
    	input = (input || '');
    	var search_str = '';
    	if (input == 'Y') {
    		search_str = $('#txtExpendProjectName').val();
    	} else {
    		search_str = '';
    	}
    	
    	var Popresult = fnOpenCodePop({
   			codeType : 'Project',
   			callback : 'fnExpend_Callback_Project',
   			searchStr : search_str,
   			reflectResultPop : reflectResultPop
   		});
    }
    
    /* 이벤트 - 버튼 - 카드 */
    function fnExpendMasterCardPop( input ) {
    	input = (input || '');
    	var search_str = '';
    	if (input == 'Y') {
    		search_str = $('#txtExpendCardName').val();
    	} else {
    		search_str = '';
    	}

    	/* 버튼 클릭 이벤트 - 카드 */
   		var Popresult = fnOpenCodePop({
   			codeType : 'Card',
   			callback : 'fnExpend_Callback_Card',
   			searchStr : search_str,
   			reflectResultPop : reflectResultPop,
   			expendCardOption : isDisplayFullNumber
   		});
    }
    
    /* 이벤트 - 버튼 - 거래처 */
    function fnExpendMasterPartnerPop( input ) {
    	input = (input || '');
    	var search_str = '';
    	if (input == 'Y') {
    		search_str = $('#txtExpendPartnerName').val();
    	} else {
    		search_str = '';
    	}

    	/* 버튼 클릭 이벤트 - 거래처 */
   		var Popresult = fnOpenCodePop({
   			codeType : 'Partner',
   			callback : 'fnExpend_Callback_Partner',
   			searchStr : search_str,
   			reflectResultPop : reflectResultPop
   		});
    }

    /* 이벤트 - 지출결의 항목 삭제 */
    function fnExpendListDelete() {
        var chkSels = $("input[name=inp_ListChk]:checkbox:checked").map(function() {
            return this.value;
        }).get();
        var deletectChkCount = chkSels.length;
        
        if(!chkSels || chkSels.length == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000002223", "선택된 항목이 없습니다.　항목을 선택하여 주십시오")%>");
        	return false;
        }else if( expend.get('expendStatCode') == '999' || expend.get('expendStatCode') == '100' || expend.get('erpSendYN') == 'Y'){
        	alert("<%=BizboxAMessage.getMessage("TX000018812", "삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
        	return false;
        }else if(chkSels.length > 0 && chkSels[0] === 'on'){
        	deletectChkCount--;
        }
        
        
        if (!confirm("<%=BizboxAMessage.getMessage("TX000016503", "삭제된 내역은 복구할 수 없습니다.")%>" + "\r\n" + "<%=BizboxAMessage.getMessage("", "계속 진행하시겠습니까?")%>")) { return; }
        
        
        /* 변수정의 */
        var param = {};
        var array = [];
        $.each(chkSels, function( idx, item ) {
            if (item.toString().split('|').length == 2) {
                var list = {};
                $.extend(list, ExExpendList);
                list.expendSeq = item.toString().split('|')[0];
                list.listSeq = item.toString().split('|')[1];
                array.push(list);
            }
        });
        param.listListVo = array;
        param.listListVo = JSON.stringify(param.listListVo);
        param.formInfo = JSON.stringify(formInfo);
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/list/ListInfoDelete.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	/* 지출결의 확인에서 수정이 된 경우 지출결의 확인 리스트 갱신 */
            	if( ( popParam != undefined ) && typeof(popParam.EMR_fnReDrawViewInfo) == 'function'){
            		popParam.EMR_fnReDrawViewInfo();	
            	}
            	listCount = listCount - deletectChkCount;
            	fnSetExpendErrorInfo();
                fnSetGridList();
                
            },
            error : function( data ) {
                console.log("! [EX][EXPENDINSERT] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }


    /* 이벤트 - 지출결의 항목 분개 삭제 */
    function fnExpendSlipDelete() {
        var chkSels = $("input[name=inp_SlipChk]:checkbox:checked").map(function() {
            return this.value;
        }).get();
        
        if(!chkSels || chkSels.length == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018814", "선택된 분개정보가 없습니다. 분개를 선택 후 진행하여 주십시오")%>");
        	return false;
        }else if( expend.get('expendStatCode') == '999' || expend.get('expendStatCode') == '100' || expend.get('erpSendYN') == 'Y'){
        	alert("<%=BizboxAMessage.getMessage("TX000018812", "삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
        	return false;
        }
        
        if (!confirm("<%=BizboxAMessage.getMessage("TX000016503", "삭제된 내역은 복구할 수 없습니다.")%>" + "\r\n" + "<%=BizboxAMessage.getMessage("", "계속 진행하시곘습니까?")%>")) { return; }

        /* 변수정의 */
        var param = {};
        var array = [];
        $.each(chkSels, function( idx, item ) {
            if (item.toString().split('|').length == 3) {
                var slip = {};
                $.extend(slip, ExExpendSlip);
                slip.expendSeq = item.toString().split('|')[0];
                slip.listSeq = item.toString().split('|')[1];
                slip.slipSeq = item.toString().split('|')[2];
                array.push(slip);
            }
        });
        param.slipListVo = array;
        param.slipListVo = JSON.stringify(param.slipListVo);
        param.formInfo = JSON.stringify(formInfo);
        param.isSlipMode = isInsertSlipMode; 
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/slip/SlipListInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	fnSetExpendErrorInfo();
            	fnSetGridList();
            	fnSetGridSlip();
            },
            error : function( data ) {
                console.log("! [EX][EXPENDINSERT] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 이벤트 - 지출결의 분개 복사 */
    function fnExpendSlipCopy() {
        var chkSels = $("input[name=inp_SlipChk]:checkbox:checked").map(function() {
            return this.value;
        }).get();
        
        if(!chkSels || chkSels.length == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018814", "선택된 분개정보가 없습니다. 분개를 선택 후 진행하여 주십시오")%>");
        	return false;
        }else if( expend.get('expendStatCode') == '999' || expend.get('expendStatCode') == '100' || expend.get('erpSendYN') == 'Y'){
        	alert("<%=BizboxAMessage.getMessage("TX000018812", "삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
        	return false;
        }

        /* 변수정의 */
        var param = {};
        var array = [];
        $.each(chkSels, function( idx, item ) {
            if (item.toString().split('|').length == 3) {
                var slip = {};
                $.extend(slip, ExExpendSlip);
                slip.expendSeq = item.toString().split('|')[0];
                slip.listSeq = item.toString().split('|')[1];
                slip.slipSeq = item.toString().split('|')[2];
                array.push(slip);
            }
        });
        param.slipListVo = array;
        param.slipListVo = JSON.stringify(param.slipListVo);
        param.formInfo = JSON.stringify(formInfo);
        param.isSlipMode = isInsertSlipMode;
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/slip/SlipInfoCopy.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	/* 예산 초과시 복사 안되니까 안내메세지 표시 */
            	if( data && data.aaData && data.aaData.code == 'FAIL'&& data.aaData.map ){
            		var budgetOverMsg = data.aaData.message + "\n"; 
            		budgetOverMsg = budgetOverMsg + data.aaData.map.budgetName +"["+ data.aaData.map.budgetCode +"], ";
            		if( data.aaData.map.bizplanCode != '' && data.aaData.map.bizplanCode != '***' ){
            			budgetOverMsg = budgetOverMsg + data.aaData.map.bizplanName +"["+ data.aaData.map.bizplanCode +"], ";	
            		}
            		budgetOverMsg = budgetOverMsg + data.aaData.map.bgacctName +"["+ data.aaData.map.bgacctCode +"]";
            		alert(budgetOverMsg);
            	}
            	fnSetExpendErrorInfo();
            	fnSetGridList();
                fnSetGridSlip();
            },
            error : function( data ) {
                console.log("! [EX][EXPENDINSERT] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    
    
    /* 이벤트 정의 호출 - 항목 복사 */
    function fnDefault_listCopy( param ) {
    	if(isPopupOpen){
	    	return false;
	    }
        var chkSels = $("input[name=inp_ListChk]:checkbox:checked").map(function() {
            return this.value;
        }).get();
        var copyChkCount = chkSels.length;
        
        if(!chkSels || chkSels.length == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000002223", "선택된 항목이 없습니다.　항목을 선택하여 주십시오")%>");
        	return false;
        }else if( expend.get('expendStatCode') == '999' || expend.get('expendStatCode') == '100' || expend.get('erpSendYN') == 'Y'){
        	alert("<%=BizboxAMessage.getMessage("TX000018812", "삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
        	return false;
        }else if(chkSels.length > 0 && chkSels[0] === 'on'){
        	copyChkCount = chkSels.length - 1; // 체크된 개수 확인(전체 체크도 카운트에 포함되어있다.)
        }

		if((listCount + copyChkCount) <= maxListLength){ // 결의내역 최대입력 건수 설정
	        /* 변수정의 */
	        var param = {};
	        var array = [];
	        var callbackFunc = ['fnSetExpendErrorInfo','fnSetGridList','fnSetGridSlip'];
	        $.each(chkSels, function( idx, item ) {
	            if (item.toString().split('|').length == 2) {
	                var list = {};
	                $.extend(list, ExExpendList);
	                list.expendSeq = item.toString().split('|')[0];
	                list.listSeq = item.toString().split('|')[1];
	                array.push(list);
	            }
	        });
	        param.listVo = JSON.stringify(array[0]);
	        param.formInfo = JSON.stringify(formInfo);
	        
	        PLP_fnInitPop();
	        PLP_fnShowProgressDialog({
				title : '항목 내역 복사'	
					, progText : '항목 내역 복사가 진행중입니다.'
					, endText : '항목 내역 복사가 완료되었습니다.'
					, popupPageTitle : '항목 내역 복사 실패사유'
					, popupColGbn : '예산정보'
					, popupColDetail : '실패사유'
			});
	        PLP_fnSetProgressValue(0, 0, array.length);
	        $('#PLP_divMainProgPop > .pop_head:not(:contains("복사"))').remove()
	        $("#PLP_divMainProgPop").css("z-index",104);
	        fnRecurExpendCopy(0, param, array, '<c:url value="/ex/user/expend/list/ListInfoCopy2.do" />', callbackFunc);
	        return;
		}else {
			alert("<%=BizboxAMessage.getMessage("TX000016473", "항목을 추가 할 수 없습니다. (사유 : 결의내역 최대 입력 건수 초과.) ")%>"+ "\n" + 
    				"<%=BizboxAMessage.getMessage("TX000016481", "지출결의 설정에서 설정 할 수 있습니다.")%>"
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016498", "선택한 개수")%>" + " : "+ copyChkCount
    				+ "\n " + "<%=BizboxAMessage.getMessage("TX000016496", "설정된 최대 개수")%>" + " : "+ maxListLength); 
    	}
    }
    /* 지출결의 확인에서 수정이 된 경우 지출결의 확인 리스트 갱신 */
    function fnRefreshGrid (){
    	if( ( popParam != undefined ) && typeof(popParam.EMR_fnReDrawViewInfo) == 'function'){
    		popParam.EMR_fnReDrawViewInfo();	
    	}
    }
    
    
    /* 이벤트 정의 호출 - 반영 */
    function fnExpendSlipCopy2( param ) {
    	var data = {};
    	
    	var chkSels = $("input[name=inp_SlipChk]:checkbox:checked").map(function() {
            return this.value;
        }).get();
        
        if(!chkSels || chkSels.length == 0){
        	alert("<%=BizboxAMessage.getMessage("TX000018814", "선택된 분개정보가 없습니다. 분개를 선택 후 진행하여 주십시오")%>");
        	return false;
        }else if( expend.get('expendStatCode') == '999' || expend.get('expendStatCode') == '100' || expend.get('erpSendYN') == 'Y'){
        	alert("<%=BizboxAMessage.getMessage("TX000018812", "삭제/반려/ERP 전송한 전표는 수정이 불가능합니다")%>");
        	return false;
        }

        /* 변수정의 */
        var param = {};
        var array = [];
        var callbackFunc = ['fnSetExpendErrorInfo','fnSetGridList','fnSetGridSlip'];
        $.each(chkSels, function( idx, item ) {
            if (item.toString().split('|').length == 3) {
                var slip = {};
                $.extend(slip, ExExpendSlip);
                slip.expendSeq = item.toString().split('|')[0];
                slip.listSeq = item.toString().split('|')[1];
                slip.slipSeq = item.toString().split('|')[2];
                array.push(slip);
            }
        });
        data.slipVo = JSON.stringify(array[0]);
        data.formInfo = JSON.stringify(formInfo);
        data.isSlipMode = isInsertSlipMode;
        
//         $('#PLP_divMainProgPop > .pop_head:contains("${CL.ex_listAdd}")').remove();
//         $('#PLP_divMainProgPop > .pop_head:contains("${CL.ex_additionJournalizing}")').remove();
//         $('#PLP_divMainProgPop > .pop_head:contains("${CL.ex_cardUseHistory}")').remove();
//         $('#PLP_divMainProgPop > .pop_head:contains("${CL.ex_electronicInvoice}")').remove();
        PLP_fnShowProgressDialog({
			title : '분개 내역 복사'	
				, progText : '분개 내역 복사가 진행중입니다.'
				, endText : '분개 내역 복사가 완료되었습니다.'
				, popupPageTitle : '분개 내역 복사 실패사유'
				, popupColGbn : '예산정보'
				, popupColDetail : '실패사유'
		});
        $('#PLP_divMainProgPop > .pop_head:not(:contains("복사"))').remove()
        $("#PLP_divMainProgPop").css("z-index",104);
        PLP_fnSetProgressValue(0, 0, array.length);
        fnRecurExpendCopy(0, data, array, '<c:url value="/ex/user/expend/slip/SlipInfoCopy2.do" />', callbackFunc);
        
        return;
    }

    /* 프로그레스 재귀 구성 */ 
    function fnRecurExpendCopy(idx, data, orgnTarget, url, callBackFunc){
    	var length = orgnTarget.length;
		if(idx >= length){
			// 프로그레스 일정 종료
			PLP_fnEndProgressDialog();
			// callback 실행
			setTimeout(function(){
				for(var i = 0 ; i < callBackFunc.length ; i++){
					var item = callBackFunc[i];
					window[item]();
				}
			},450);
			
			/* 선택 내역 정상 반영인 경우 자동 창 닫기 */
			if( plp_errInfo.length == 0 ){
				$('#PLP_btnConfirm').hide();
				setTimeout(function(){
					$('#PLP_btnPopClose').click();
				}, 400);
			}
			return ;
		}
		data.target = [orgnTarget[idx++]];
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : fnConvertJavaParam(data),
            success : function( result ) {
            	$("#viewLoading").hide( );
            	if (result.aaData.code == 'SUCCESS') {
    				PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, false);
    				fnRecurExpendCopy(idx, data, orgnTarget, url, callBackFunc);
    			} else {
//     				var tempKey = JSON.parse(data.target)[0].key;
					if( result.aaData.map.returnBudget ){
						for( var i = 0 ; i < result.aaData.map.returnBudget.length ; i++ ){
							var colGbn = result.aaData.map.returnBudget[i].map.budgetName + "[" + result.aaData.map.returnBudget[i].map.budgetCode + "]<br>";
							if( result.aaData.map.returnBudget[i].map.bizplanCode != '' && result.aaData.map.returnBudget[i].map.bizplanCode != '***' ){
								colGbn = colGbn + result.aaData.map.returnBudget[i].map.budgetName + "[" + result.aaData.map.returnBudget[i].map.budgetCode + "]<br>";	
							}
							colGbn = colGbn + result.aaData.map.returnBudget[i].map.bgacctName + "[" + result.aaData.map.returnBudget[i].map.bgacctCode + "]";
							PLP_fnSetErrInfo({
		    					'colGbn' : colGbn
		    					, 'colDetail' : result.aaData.map.returnBudget[i].message
		    				});
						}
						
					}else{
						PLP_fnSetErrInfo({
	    					'colGbn' : '-'
	    					, 'colDetail' : result.aaData.message
	    				});
					}

    				
    				PLP_fnSetProgressValue(( (idx * 1.0 ) / ( length * 1.0 )) * 100, idx, length, true);
    				fnRecurExpendCopy(idx, data, orgnTarget, url, callBackFunc);
    			}
            },
            error : function( data ) {
                alert(NeosUtil.getMessage("TX000008120", "오류가 발생하였습니다"));
            }
        });
    }
    
   
    /* 지출결의 */
    /* 지출결의 - 지출결의 생성 */
    function fnExpendInsert() {
        var param = {};
        $.extend(param, expend.toJSON());

        param.compSeq = empInfo.compSeq;
        param.formSeq = formInfo.formSeq;
        param.expendDate = (param.expendDate).toString().replace(/-/g, '');
        param.expendReqDate = (param.expendReqDate).toString().replace(/-/g, '');

        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/master/ExUserExpendInfoInsert.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	listSeq = data.listSeq;
                /* 반환값 적용 */
                fnCopyToBOservalbe(data.aaData, expend);
                /* EXPEND 변경시 UPDATE 실행 */
                if (Object.keys(expend._events).indexOf('change') < 0) {
                    expend.bind('change', function( e ) {
                        fnExpendUpdate();
                    });
                }
            },
            error : function( data ) {
                console.log("! [EX][EXPENDINSERT] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 지출결의 - 지출결의 수정 */
    function fnExpendUpdate() {
    	
        var param = {}
        $.extend(param, expend.toJSON());
        
        param.compSeq = empInfo.compSeq;
        param.expendDate = (param.expendDate).toString().replace(/-/g, ''); 
        param.expendReqDate = (param.expendReqDate).toString().replace(/-/g, '');
        param.jsonStr = '';
        param.jsonStr = JSON.stringify(param);
        param.formInfo = JSON.stringify(formInfo);
        param.eapCallDomain = originSSL;

        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/master/ExUserExpendInfoUpdate.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
                if (Object.keys(expend._events).indexOf('change') < 0) {
                    expend.bind('change', function( e ) {
                        fnExpendUpdate();
                    });
                }
            },
            error : function( data ) {
                console.log("! [EX][EXPENDUPDATE] ERROR - " + JSON.stringify(data));
                
				// SSL 적용과 관련하여, 실제 서버에서 호출될 경우 SSL 이 적용되지 않은 처리 보완
				// 내부 네트웍망 사용으로 인해 도메인으로 접근이 불가한 경우에 대한 예외처리
				if(originSSL != origin) {
					originSSL = origin;
					fnExpendUpdate();
				} else {
					alert("<%=BizboxAMessage.getMessage("TX000018809", "전자결재 문서 생성 중 오류가 발생하였습니다.")%>");
	           	}
            }
        });
        
        return;
    }
    /* 지출결의 - 지출결의 조회 */
    function fnExpendSelect() {
        var param = {}
        $.extend(param, expend.toJSON());
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/master/ExUserExpendInfoSelect.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	// 사용자, 예산, 프로젝트, 거래처 정보 등을 Map으로 받아서 각 정보에 저장한다.
            	if(data.aaData){
            		fnCopyToBOservalbe(data.aaData.expendWriter, expendWriter);
            		fnCopyToBOservalbe(data.aaData.expendUseEmp, expendUseEmp);
            		fnCopyToBOservalbe(data.aaData.expend, expend);
            		fnCopyToBOservalbe(data.aaData.card, expendCard);
            		fnCopyToBOservalbe(data.aaData.project, expendProject);
            		fnCopyToBOservalbe(data.aaData.partner, expendPartner);
            		fnExpendEmpReload('');
            		fnExpendEtcReload();
            		
            		fnExpendDateSetting(true);
	                if (Object.keys(expend._events).indexOf('change') < 0) {
	                    expend.bind('change', function( e ) {
	                        fnExpendUpdate();
	                    });
	                }
	                
	                /* [+] #. PIMS : M20170705001 >> 종결문서 수정모드에서 접근시 옵션에 따른 회계일자 및 지급요청일자가 강제 변경되어, 조회된 정보와 표현된 정보가 다를 경우 조회된 정보로 다시적용 - 2017-07-05 */
                    if(data.aaData.expend.expendDate.toString() != ($('#txtExpendDate').val().toString().replace(/-/g, '') || '')){
	                	/* 기존 저장된 값과 신규 반영된 값의 결과가 다를 경우 */
	                	if((data.aaData.expend.expendDate || '') != ''){
	                		$('#txtExpendDate').val(data.aaData.expend.expendDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
	                	}
	                }
	                if(data.aaData.expend.expendReqDate.toString() != ($('#txtExpendReqDate').val().toString().replace(/-/g, '') || '')){
	                	/* 기존 저장된 값과 신규 반영된 값의 결과가 다를 경우 */
	                	if((data.aaData.expend.expendReqDate || '') != ''){
	                		$('#txtExpendReqDate').val(data.aaData.expend.expendReqDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3'));
	                	}
	                }
	                /* [-] #. PIMS : M20170705001 >> 종결문서 수정모드에서 접근시 옵션에 따른 회계일자 및 지급요청일자가 강제 변경되어, 조회된 정보와 표현된 정보가 다를 경우 조회된 정보로 다시적용 - 2017-07-05 */
            	}
            },
            error : function( data ) {
                console.log("! [EX][EXPENDUPDATE] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 지출결의 - 지출결의 항목 추가 콜백 */
    function fnExpend_Callback_ListAdd(data) {
    	isPopupOpen = false;
    	/* 지출결의 확인에서 수정이 된 경우 지출결의 확인 리스트 갱신 */
    	if( ( popParam != undefined ) && typeof(popParam.EMR_fnReDrawViewInfo) == 'function'){
    		popParam.EMR_fnReDrawViewInfo();	
    	}
    	
    	// 사용자 변경시에는 seq값이 0이므로 항목 생성 후 생선된 seq값 저장 ( slipSeq에 empSeq 값 저장되어있음 )
    	if(data && expendUseEmp.seq === '0'){
    		expendUseEmp.set('seq', data.aaData.slipSeq);
    	}
    	fnExCloseLayPop();
        /* 분개단위 입력에서 콜백인 경우 */
        if( isInsertSlipMode ){
        	listSeq = 1;
        	fnSetExpendErrorInfo();
            fnSetGridList();
            fnSetGridSlip();
        }else{
        	fnSetExpendErrorInfo();
            fnSetGridList();
        }
        // 항목 추가시 회계일자 변경되게 수정
        fnExpendDateSetting(true);
        
        if( data != undefined && data.continus != undefined && data.continus ){
         	$('#btnExpendListAdd').click();
         }
    }
    /* 지출결의 - 지출결의 카드 내역 콜백 */
    function fnExpend_Callback_CardAdd(data) {
    	isPopupOpen = false;
    	/* 지출결의 확인에서 수정이 된 경우 지출결의 확인 리스트 갱신 */
    	if( ( popParam != undefined ) && typeof(popParam.EMR_fnReDrawViewInfo) == 'function'){
    		popParam.EMR_fnReDrawViewInfo();	
    	}
    	
    	// 사용자 변경시에는 seq값이 0이므로 항목 생성 후 생선된 seq값 저장 ( slipSeq에 empSeq 값 저장되어있음 )
    	if(data && expendUseEmp.seq === '0'){
    		expendUseEmp.set('seq', data.aaData.slipSeq);
    	}
//     	fnExCloseLayPop();
        /* 분개단위 입력에서 콜백인 경우 */
        if( isInsertSlipMode ){
        	listSeq = 1;
        	fnSetExpendErrorInfo();
            fnSetGridList();
            fnSetGridSlip();
        }else{
        	fnSetExpendErrorInfo();
            fnSetGridList();
        }
        // 항목 추가시 회계일자 변경되게 수정
        fnExpendDateSetting(true);
        
        if( data != undefined && data.continus != undefined && data.continus ){
         	$('#btnExpendListAdd').click();
         }
    }
    /* 지출결의 - 지출결의 매입세금계산서 콜백 */
    function fnExpend_Callback_ETaxAdd(data) {
    	isPopupOpen = false;
    	/* 지출결의 확인에서 수정이 된 경우 지출결의 확인 리스트 갱신 */
    	if( ( popParam != undefined ) && typeof(popParam.EMR_fnReDrawViewInfo) == 'function'){
    		popParam.EMR_fnReDrawViewInfo();	
    	}
    	
    	// 사용자 변경시에는 seq값이 0이므로 항목 생성 후 생선된 seq값 저장 ( slipSeq에 empSeq 값 저장되어있음 )
    	if(data && expendUseEmp.seq === '0'){
    		expendUseEmp.set('seq', data.aaData.slipSeq);
    	}
//     	fnExCloseLayPop();
        /* 분개단위 입력에서 콜백인 경우 */
        if( isInsertSlipMode ){
        	listSeq = 1;
        	fnSetExpendErrorInfo();
            fnSetGridList();
            fnSetGridSlip();
        }else{
        	fnSetExpendErrorInfo();
            fnSetGridList();
        }
        
     	// 항목 추가시 회계일자 변경되게 수정
        fnExpendDateSetting(true);
    }
    
    /* 지출결의 - 지출결의 항목 분개 추가 콜백 */
    function fnExpend_Callback_SlipAdd(param) {
    	isPopupOpen = false;
    	/* 지출결의 확인에서 수정이 된 경우 지출결의 확인 리스트 갱신 */
    	if( ( popParam != undefined ) && typeof(popParam.EMR_fnReDrawViewInfo) == 'function'){
    		popParam.EMR_fnReDrawViewInfo();	
    	}
    	if(param && param.continus){
    		/* 연속입력 사용[안분상신] */
    		fnViewInitForContinus();
    	}else{
    		/* 연속입력 미사용 */
    		fnExCloseLayPop();
    	}
    	
        fnSetGridList();
		// 에러 체크
        fnSetExpendErrorInfo();
	    // 에러 표시 제거
        fnReDisplayErrorSlipRows();
        fnSetGridSlip();
        var listSeqData = [{"list_seq" : listSeq, "slip_seq" : slipSeq}];
        // 에러 표시
        fnDisplayListErrorRows(listSeqData);
    }
    
    /* 지출결의 - 지출결의 항목 분개 관리항목 수정 콜백 */
    function fnExpend_Callback_MngMod(param) {
    	isPopupOpen = false;
    	/* 지출결의 확인에서 수정이 된 경우 지출결의 확인 리스트 갱신 */
    	if( ( popParam != undefined ) && typeof(popParam.EMR_fnReDrawViewInfo) == 'function'){
    		popParam.EMR_fnReDrawViewInfo();	
    	}
    	fnExCloseLayPop();
        // 에러 체크
    	fnSetExpendErrorInfo();
    	// 에러 표시 제거
    	fnReDisplayErrorMngRows();
        fnReDisplayErrorSlipRows();
        fnSetGridMng();
        var listSeqData = [{"list_seq" : listSeq, "slip_seq" : slipSeq}];
        fnDisplayListErrorRows(listSeqData);
        fnDisplaySlipErrorRows(listSeqData);
        
        if( ifSystem == 'ERPiU' && param && param != 'undefined' && param.mngCode == 'A06'){
        	slipPartnerCodeInfo.partnerCd = param.ctdCode;
            slipPartnerCodeInfo.partnerNm = param.ctdName;
        }
    }
    /* 코드 */
    /* 코드 - 작성자 || 사용자 - 생성 */
    function fnExpendEmpInsert( flag ) {
        /* 지출결의 생성을 위한, 최소한의 프로세스만 진행한다. */
        /* 변수정의 */
        var param = {};
        if (flag == 'writer') {
            $.extend(param, expendWriter.toJSON());
        } else if (flag == 'use') {
            $.extend(param, expendUseEmp.toJSON());
        }

        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/master/ExpendEmpInfoInsert.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
                if (flag == 'writer') {
                    fnCopyToBOservalbe(data.aaData, expendWriter);
                } else if (flag == 'use') {
                    fnCopyToBOservalbe(data.aaData, expendUseEmp);
                }

                fnExpendEmpUpdate(flag);
            },
            error : function( data ) {
                console.log("! [EX][EMPINSERT] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 코드 - 작성자 || 사용자 - 수정 */
    function fnExpendEmpUpdate( flag ) {
        /* 지출결의 생성을 위한, 최소한의 프로세스만 진행한다. */
        /* 변수정의 */
        var param = {};
        if (flag == 'writer') {
            $.extend(param, expendWriter.toJSON());
        } else if (flag == 'use') {
            $.extend(param, expendUseEmp.toJSON());
        }

        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/master/ExpendEmpInfoUpdate.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
                if (flag == 'writer') {
                    expend.set('writeSeq', expendWriter.get('seq'));
                    fnExpendEmpReload(flag);
                } else if (flag == 'use') {
                	if( data.aaData.map.seq ){
                		expendUseEmp.set('seq',data.aaData.map.seq);
                	}
                    expend.set('empSeq', expendUseEmp.get('seq'));
                    fnExpendEmpReload(flag);
                }
            },
            error : function( data ) {
                console.log("! [EX][EMPUPDATE] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
  
    function fnExpendProjectInsert_Update(){
    	
    	var param = {};
    	$.extend(param, expendProject.toJSON());
        
    	/* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/master/fnExpendProjectInsert_Update.do" />',
            datatype : 'json',
            async : false,
            data : param,
            error : function( data ) {
                console.log("! [EX][EMPUPDATE] ERROR - " + JSON.stringify(data));
            }
        });
    	return;
    }
    
    function fnExpendPartnerInsert_Update(){
    	
    	var param = {};
    	$.extend(param, expendPartner.toJSON());
        
    	/* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/master/fnExpendPartnerInsert_Update.do" />',
            datatype : 'json',
            async : false,
            data : param,
            error : function( data ) {
                console.log("! [EX][EMPUPDATE] ERROR - " + JSON.stringify(data));
            }
        });
    	return;
    }
    
    function fnExpendCardInsert_Update(){
    	
    	var param = {};
    	$.extend(param, expendCard.toJSON());
        
    	/* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/master/fnExpendCardInsert_Update.do" />',
            datatype : 'json',
            async : false,
            data : param,
            error : function( data ) {
                console.log("! [EX][EMPUPDATE] ERROR - " + JSON.stringify(data));
            }
        });
    	return;
    }
    
    /* 코드 - 작성자 || 사용자 - 화면갱신 */
    function fnExpendEmpReload( flag ) {
        if (flag == 'writer') { return; }
        var source = expendUseEmp.toJSON();
        if ('${ViewBag.ifSystem}' == 'BizboxA') {
            /* 사용자 */
            $('#txtExpendEmpCode').val(source.empSeq);
            $('#txtExpendEmpName').val(source.empName);
            /* 사용부서 */
            $('#txtExpendDeptCode').val(source.deptSeq);
            $('#txtExpendDeptName').val(source.deptName);
        } else {
            /* 사용자 */
            $('#txtExpendEmpCode').val(source.erpEmpSeq);
            $('#txtExpendEmpName').val(source.erpEmpName);
            /* 사용부서 */
            $('#txtExpendDeptCode').val(source.erpDeptSeq);
            $('#txtExpendDeptName').val(source.erpDeptName);
            /* 회계단위 */
            $('#txtExpendPcCode').val(source.erpPcSeq);
            $('#txtExpendPcName').val(source.erpPcName);
            /* 코스트센터 */
            $('#txtExpendCcCode').val(source.erpCcSeq);
            $('#txtExpendCcName').val(source.erpCcName);
        }
        return;
    }
    /* 코드 - 카드,거래처, 프로젝트 - 화면갱신 */
    function fnExpendEtcReload() {

    	var card = expendCard.toJSON();
        var project = expendProject.toJSON();
        var partner = expendPartner.toJSON();
        
        if ('${ViewBag.ifSystem}' == 'BizboxA') {
        	return;
        } else {
        	/* 프로젝트  */
            $('#txtExpendProjectCode').val(project.projectCode);
            $('#txtExpendProjectName').val(project.projectName);
            /* 거래처  */
            $('#txtExpendPartnerCode').val(partner.partnerCode);
            $('#txtExpendPartnerName').val(partner.partnerName);
            /* 카드  */
            $('#txtExpendCardCode').val(card.cardCode);
            $('#txtExpendCardName').val(card.cardName);
        }
        return;
    }
    
    /* 코드 - 작성자 || 사용자 - 콜백 */
    function fnExpend_Callback_Emp(param ) {
    	expendUseEmp.set('erpBizName', param.obj.erpBizName);
    	expendUseEmp.set('erpBizSeq', param.obj.erpBizSeq);
        expendUseEmp.set('empSeq', param.obj.erpEmpSeq);
        expendUseEmp.set('empName', param.obj.erpEmpName);
        expendUseEmp.set('deptSeq', param.obj.erpDeptSeq);
        expendUseEmp.set('deptName', param.obj.erpDeptName);
        expendUseEmp.set('erpEmpSeq', param.obj.erpEmpSeq);
        expendUseEmp.set('erpEmpName', param.obj.erpEmpName);
        
        if(expendEmpDeptLinkChange) {
        	/* 사용자 변경 시 부서 변경 여부인 경우만 변경 */
	        expendUseEmp.set('erpDeptSeq', param.obj.erpDeptSeq);
	        expendUseEmp.set('erpDeptName', param.obj.erpDeptName);
        }
        
        expendUseEmp.set('erpPcSeq', param.obj.erpPcSeq);
        expendUseEmp.set('erpPcName', param.obj.erpPcName);
        expendUseEmp.set('erpCcSeq', param.obj.erpCcSeq);
        expendUseEmp.set('erpCcName', param.obj.erpCcName);
        expendUseEmp.set('depositName', param.obj.depositName);
        expendUseEmp.set('depositCd', param.obj.depositCd);
        expendUseEmp.set('depositName2', param.obj.depositName2);
        expendUseEmp.set('depositCd2', param.obj.depositCd2);
        expendUseEmp.set('seq', 0);
        fnExpendEmpUpdate('use');
        return;
    }
    
    /* 코드 - 부서 || 부서 - 콜백 */
   	function fnExpend_Callback_Dept(param) {
        expendUseEmp.set('erpDeptSeq', param.obj.erpDeptSeq);
        expendUseEmp.set('erpDeptName', param.obj.erpDeptName);
        
        fnExpendEmpUpdate('use');
        
        return;
    }
    
    /* 코드 - 작성자 || 회계단위 - 콜백 */
    function fnExpend_Callback_PC( param ) {
        expendUseEmp.set('erpPcSeq', param.obj.erpPcSeq);
        expendUseEmp.set('erpPcName', param.obj.erpPcName);
        fnExpendEmpUpdate('use');
        return;
    }
    
    /* 코드 - 작성자 || 코스트센터 - 콜백 */
    function fnExpend_Callback_CC( param ) {
        expendUseEmp.set('erpCcSeq', param.obj.erpCcSeq);
        expendUseEmp.set('erpCcName', param.obj.erpCcName);
        fnExpendEmpUpdate('use');
        return;
    }
    
    /* 코드 - 프로젝트 - 콜백 */
    function fnExpend_Callback_Project( param ) {
    	expendProject.set('projectCode', param.obj.projectCode);
    	expendProject.set('projectName', param.obj.projectName);
    	expendProject.set('compSeq', empInfo.compSeq);
    	expendProject.set('createSeq', empInfo.empSeq);
    	expendProject.set('modifySeq', empInfo.empSeq);
    	expendProject.set('expendSeq', expend.get('expendSeq'));
    	
    	fnExpendProjectInsert_Update();
    	
    	$("#txtExpendProjectCode").val(param.obj.projectCode);
    	$("#txtExpendProjectName").val(param.obj.projectName);
        return;
    }
    
    /* 코드 - 거래처 - 콜백 */
    function fnExpend_Callback_Partner( param ) {
    	expendPartner.set('partnerCode', param.obj.partnerCode);
    	expendPartner.set('partnerName', param.obj.partnerName);
    	expendPartner.set('partnerNo', param.obj.partnerNo);
    	expendPartner.set('partnerFg', param.obj.partnerFg);
    	expendPartner.set('ceoName', param.obj.ceoName);
    	expendPartner.set('jobGbn', param.obj.jobGbn);
    	expendPartner.set('clsJobGbn', param.obj.clsJobGbn);
    	expendPartner.set('depositNo', param.obj.depositNo);
    	expendPartner.set('bank_code', param.obj.bank_code);
    	expendPartner.set('partnerEmpCode', param.obj.partnerEmpCode);
    	expendPartner.set('partnerHpEmpNo', param.obj.partnerHpEmpNo);
    	expendPartner.set('depositName', param.obj.depositName);
    	expendPartner.set('depositConvert', param.obj.depositConvert);
    	expendPartner.set('depositCd', param.obj.depositCd);
    	
    	expendPartner.set('createSeq', empInfo.empSeq);
    	expendPartner.set('modifySeq', empInfo.empSeq);
    	expendPartner.set('expendSeq', expend.get('expendSeq'));
    	
    	fnExpendPartnerInsert_Update();
    	
    	$("#txtExpendPartnerCode").val(param.obj.partnerCode);
    	$("#txtExpendPartnerName").val(param.obj.partnerName);
        return;
    }
    
    /* 코드 - 카드 - 콜백 */
    function fnExpend_Callback_Card( param ) {
    	expendCard.set('cardCode', param.obj.cardCode);
    	expendCard.set('cardName', param.obj.cardName);
    	expendCard.set('cardNum', param.obj.cardNum);
    	expendCard.set('partnerCode', param.obj.partnerCode);
    	expendCard.set('partnerName', param.obj.partnerName);
    	expendCard.set('createSeq', empInfo.empSeq);
    	expendCard.set('modifySeq', empInfo.empSeq);
    	expendCard.set('expendSeq', expend.get('expendSeq'));
    	
    	fnExpendCardInsert_Update();
    	
    	$("#txtExpendCardCode").val(param.obj.cardNum);
    	$("#txtExpendCardName").val(param.obj.cardName);
        return;
    }
    
    /* 코드 - 예산단위 - 콜백 */
    function fnExpend_Callback_Budget( param ) { 
    	expendBudget.set('budgetCode', param.obj.budgetCode);
    	expendBudget.set('budgetName', param.obj.budgetName);
    	$("#txtExpendBudgetCode").val(param.obj.budgetCode);
    	$("#txtExpendBudgetName").val(param.obj.budgetName);
        return;
    }
    /* 코드 - 사업계획 - 콜백 */
    function fnExpend_Callback_Bizplan( param ) { 
    	expendBudget.set('bizplanCode', param.obj.bizplanCode);
    	expendBudget.set('bizplanName', param.obj.bizplanName);
    	$("#txtExpendBizplanCode").val(param.obj.bizplanCode);
    	$("#txtExpendBizplanName").val(param.obj.bizplanName);
        return;
    }
    
    /* 코드 - 예산계정 - 콜백 */
    function fnExpend_Callback_BgAcct( param ) { 
    	expendBudget.set('bgacctCode', param.obj.bgacctCode);
    	expendBudget.set('bgacctName', param.obj.bgacctName);
    	$("#txtExpendBgAcctCode").val(param.obj.bgacctCode);
    	$("#txtExpendBgAcctName").val(param.obj.bgacctName);
        return;
    }
    

    /* 그리드 바인딩 */
    /* 그리드 바인딩 - 헤더 정보 조회 */
    function fnSetGridHead(headGbn){
    	var param = {};
        $.extend(param, ExExpendList);
        param.compSeq = empInfo.compSeq;
        param.formSeq = formInfo.formSeq;
        if(headGbn == "List"){
        	param.itemGbn = "EX2002001";
        } else if(headGbn == "Slip"){
        	param.itemGbn = "EX2002002";
        } else{
        	param.itemGbn = "EX2002003";	
        }
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/master/config/ExpendGridHeadInfoS.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
            	fnSetGridHeadInfo(headGbn, data.aaData);
            }
        });
    }
    /* 그리드 바인딩 - 헤더 정보 설정*/
    function fnSetGridHeadInfo(headGb, headInfo) {
    	if(headInfo && headInfo.length > 0){
	        var oListArr = [];
	        var temp = {};
	        var oListDefsArr = [];
			var tempDefs = {};
	        // 체크박스 기본 적용
	        temp = { 
	        	"sTitle" : "<label class=''><input type='checkbox' id='inp_" + headGb + "Chk' name='inp_" + headGb + "Chk' onclick='fnChk(this)'></label>",
	        	"bSearchable" : false,
	        	"bSortable" : false,
	        	"bVisible" : true,
	        	"sWidth" : "34",
	        	"sClass" : "center"
	        };
	
	        oListArr.push(temp);
	        tempDefs = {
                "targets" : 0,
                "data" : null,
                "render" : function( data ) {
                    if (data != null && data != "") {
                    	if(headGb == "List"){
                    		return '<input type="checkbox" name="inp_ListChk" id="inp_ListChk' + data.expend_seq + '|' + data.list_seq + '" value="' + data.expend_seq + '|' + data.list_seq + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="inp_ListChk' + data.expend_seq + '|' + data.list_seq + '"></label>';	
                    	}else{
                    		return '<input type="checkbox" name="inp_SlipChk" id="inp_SlipChk' + data.expend_seq + '|' + data.list_seq + '|' + data.slip_seq + '" value="' + data.expend_seq + '|' + data.list_seq + '|' + data.slip_seq + '" class="k-checkbox" /><label class="k-checkbox-label bdChk" for="inp_SlipChk' + data.expend_seq + '|' + data.list_seq + '|' + data.slip_seq + '"></label>';
                    	}
                        
                    } else {
                        return "";
                    }
                }
            };
	        oListDefsArr.push(tempDefs);
	        
	        temp = {};
	        
	        tempDefs = {};
	
	        $.each(headInfo, function (index, item) {
	        	if(index > 0){
		            temp = { 
		            		"sTitle": item.langpack_name, 
		            		"mData": item.head_code, 
		            		"bVisible": true, 
		            		"sWidth": "", 
		            		"sClass": item.display_align + " date",
		            		};
		            oListArr.push(temp);
		            temp = {};
		            
		            if(item.head_code.indexOf('date') != -1){
		            	tempDefs = {
	            			 "targets" : index,
	                         "data" : null,
	                         "render" : function( data ) {
	                             if (data != null && data != "") {
	                                //return data.substr(0,4)+"-"+data.substr(4,2)+"-"+data.substr(6,2);
	                                return fnFormatStringToDate('yyyy-MM-dd', data);
	                            	
	                             }else{
	                            	 return '';
	                             }
	                         }
		            	};
		            	oListDefsArr.push(tempDefs);
		            	tempDefs = {};
		            }else if(item.head_code.indexOf('amt') != -1){
		            	tempDefs = {
		            			 "targets" : index,
		                         "data" : null,
		                         "render" : function( data ) {
		                             if (parseInt(data) != 'NAN') {
		                            	 return Number(data).toLocaleString('en');
		                             }else{
		                            	 return 0;
		                             }
		                         }
			            	};
		            	oListDefsArr.push(tempDefs);
		            	tempDefs = {};
		            }else if(item.head_code.indexOf('drcr_gbn') != -1){
		            	tempDefs = {
		            			 "targets" : index,
		                         "data" : null,
		                         "render" : function( data ) {
		                        	 if(data){
		         	                    if (data == 'dr') {
		         	                        return "<%=BizboxAMessage.getMessage("TX000000346", "차변")%>";
		         	                    } else if (data == 'vat') {
		         	                        return "<%=BizboxAMessage.getMessage("TX000000346", "차변")%>";
		         	                    } else if (data == 'cr') {
		         	                        return "<%=BizboxAMessage.getMessage("TX000000347", "대변")%>";
		         	                    } else {
		         	                        return '-';
		         	                    }
		                         	}
		                         }
			            	};
		            	oListDefsArr.push(tempDefs);
		            	tempDefs = {};
		            }
		        }
	        });
	
	        ListHead[headGb] = oListArr;
	        ListHeadDefs[headGb] = oListDefsArr;
    	}
    }
    
    /* 그리드 바인딩 - 지출결의 항목 */
    function fnSetGridList() {
        var param = {};
        $.extend(param, ExExpendList);
        param.compSeq = empInfo.compSeq;
        param.expendSeq = expend.expendSeq;
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/list/ListGridInfoSelect.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
                fnSetGridListBind(data.aaData);
                fnSetGridListAmtBind(data.aaData);
                fnSetGridSlipBind();
                fnSetGridSlipAmtBind();
                fnSetGridMngBind();
                if (data.aaData.length > 0) {
                	// 지출결의 최개 입력 개수 제한 옵션
                	listCount = data.aaData.length;
                    fnDisplayListErrorRows(data.aaData);
                    for( i = 0 ; i < data.aaData.length ; i++){
                        var tempData = data.aaData[i];                        
                    }
                    	if(mode == 0){
                        	$(window).scrollTop($('#divExpendList').find('tbody tr:last').focus().offset().top); 
                    	}else if(mode == 1) {
                    		mode = 0;                    	
                    		return true;
                    	}
                    	
				} else {
                    listSeq = 0;
                }
            },
            error : function( data ) {
                console.log("! [EX][LISTGRID] ERROR - " + JSON.stringify(data));
            }
        });
    }
    
    /* 그리드 바인딩 - 지출결의 항목 - 테이블 바인딩 */
    function fnSetGridListBind( source ) {
        source = (source || {});
        $('#divExpendList').empty();
        $('#divExpendList').append('<table id="tblExpendList"></table>');

        expendListTable = $('#tblExpendList').dataTable({
            "select" : true,
            "paging" : false,
            "bSort" : false,
            "bAutoWidth" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : source,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                    clickCount++;
                    listSeq = aData.list_seq;
                    /* 클릭과, 더블블릭을 별도 인식하기 위해서, 시간차를 두었음. 별도 인식 이유는 ajax 호출로 인하여 로딩이 표현되므로 더블클릭 이벤트가 발생되지 않는 문제점이 있음. */
                    if (clickCount === 1) {
                        singleClickTimer = setTimeout(function() {
                            clickCount = 0;
                            fnSetGridSlip();
                        }, 400);
                    } else if (clickCount === 2) {
                        clearTimeout(singleClickTimer);
                        clickCount = 0;
                    }
                }));
                $(nRow).on('dblclick', (function() {
                    listSeq = aData.list_seq;
                    fnDefault_listModify();
                    // $('#btnExpendListMod').click();
                }));

                $(nRow).attr("id", aData.expend_seq + "_" + aData.list_seq + "_" + "0_0");

                return nRow;
            },
            "columnDefs" : ListHeadDefs["List"],
            "aoColumns" : ListHead["List"]
        });
        console.log(ListHeadDefs["List"])
        console.log(ListHead["List"])
        console.log(source);
        
    }
    /* 그리드 바인딩 - 지출결의 항목 - 금액 바인딩 */
    function fnSetGridListAmtBind( source ) {
        source = (source || {});

        var std_amt = 0;
        var sub_std_amt = 0;
        var tax_amt = 0;
        var sub_tax_amt = 0;
        var amt = 0;

        $.each(source, function( idx, item ) {
            std_amt = std_amt + item.std_amt;
            sub_std_amt = sub_std_amt + item.sub_std_amt;

            tax_amt = tax_amt + item.tax_amt;
            sub_tax_amt = sub_tax_amt + item.sub_tax_amt;

            amt = amt + item.amt;
        });

        std_amt = std_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        sub_std_amt = sub_std_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        tax_amt = tax_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        sub_tax_amt = sub_tax_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        amt = amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

        $('#lbListStdAmt').html(std_amt + ' (' + sub_std_amt + ')');
        $('#lbListTaxAmt').html(tax_amt + ' (' + sub_tax_amt + ')');
        $('#lbListAmt').html(amt);
    }
    /* 그리드 바인딩 - 지출결의 항목 - 분개 */
    function fnSetGridSlip() {
        var param = {};
        $.extend(param, ExExpendSlip);
        param.compSeq = empInfo.compSeq;
        param.expendSeq = expend.expendSeq;
        
        param.listSeq = listSeq;
        /* 분개단위 입력에서 이전단계 로직 */
        if( expend.expendStatCode != '999' && expend.expendStatCode != '100' && isInsertSlipMode ){
			param.listSeq = 1;
			listSeq = 1;
        }
        
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/user/expend/slip/SlipGridInfoSelect.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
                fnSetGridSlipBind(data.aaData);
                fnSetGridSlipAmtBind(data.aaData);
                fnSetGridMngBind();
                if (data.aaData.length > 0) {
                    slipSeq = data.aaData[0].slipSeq;
					fnDisplayListErrorRows(data.aaData);
                   	fnDisplaySlipErrorRows(data.aaData);
                } else {
                    slipSeq = 0;
                }
            },
            error : function( data ) {
                console.log("! [EX][LISTGRID] ERROR - " + JSON.stringify(data));
            }
        });
    }
    /* 그리드 바인딩 - 지출결의 항목 - 분개 - 테이블 바인딩 */
    function fnSetGridSlipBind( source ) {
        source = (source || {});
  
        expendSlipTable = $('#tblExpendSlip').dataTable({
            "select" : true,
            "paging" : false,
            "bAutoWidth" : false,
            "bPaginate" : false,
            "bSort" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : source,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                    clickCount++;
                    slipSeq = aData.slip_seq;
                    mngInterFaceType = aData.interface_type;
                    if( ifSystem == 'ERPiU'){
                    	slipPartnerCodeInfo.partnerCd = aData.partner_code;
                        slipPartnerCodeInfo.partnerNm = aData.partner_name;
                        if(aData.mng_code1 == 'A06'){
                        	slipPartnerCodeInfo.partnerCd = aData.ctd_code1;
                            slipPartnerCodeInfo.partnerNm = aData.ctd_name1;
                        }else if(aData.mng_code2 == 'A06'){
                        	slipPartnerCodeInfo.partnerCd = aData.ctd_code2;
                            slipPartnerCodeInfo.partnerNm = aData.ctd_name2;
                        }else if(aData.mng_code3 == 'A06'){
                        	slipPartnerCodeInfo.partnerCd = aData.ctd_code3;
                            slipPartnerCodeInfo.partnerNm = aData.ctd_name3;
                        }else if(aData.mng_code4 == 'A06'){
                        	slipPartnerCodeInfo.partnerCd = aData.ctd_code4;
                            slipPartnerCodeInfo.partnerNm = aData.ctd_name4;
                        }else if(aData.mng_code5 == 'A06'){
                        	slipPartnerCodeInfo.partnerCd = aData.ctd_code5;
                            slipPartnerCodeInfo.partnerNm = aData.ctd_name5;
                        }else if(aData.mng_code6 == 'A06'){
                        	slipPartnerCodeInfo.partnerCd = aData.ctd_code6;
                            slipPartnerCodeInfo.partnerNm = aData.ctd_name6;
                        }else if(aData.mng_code7 == 'A06'){
                        	slipPartnerCodeInfo.partnerCd = aData.ctd_code7;
                            slipPartnerCodeInfo.partnerNm = aData.ctd_name7;
                        }else if(aData.mng_code8 == 'A06'){
                        	slipPartnerCodeInfo.partnerCd = aData.ctd_code8;
                            slipPartnerCodeInfo.partnerNm = aData.ctd_name8;
                        }
                    }
                    
                    /* 클릭과, 더블블릭을 별도 인식하기 위해서, 시간차를 두었음. 별도 인식 이유는 ajax 호출로 인하여 로딩이 표현되므로 더블클릭 이벤트가 발생되지 않는 문제점이 있음. */
                    if (clickCount === 1) {
                        singleClickTimer = setTimeout(function() {
                            clickCount = 0;
                            fnSetGridMng();
                        }, 400);
                    } else if (clickCount === 2) {
                        clearTimeout(singleClickTimer);
                        clickCount = 0;
                    }
                }));

                $(nRow).on('dblclick', (function() {
                    slipSeq = aData.slip_seq;
                    fnDefault_modifyJournalizing();
                    // $('#btnExpendSlipMod').click();
                }));

                $(nRow).attr("id", aData.expend_seq + "_" + aData.list_seq + "_" + aData.slip_seq + "_0");

                return nRow;
            },
            "columnDefs" : ListHeadDefs["Slip"],
            "aoColumns" : ListHead["Slip"]
        });
    }
    /* 그리드 바인딩 - 지출결의 항목 - 분개 - 금액 바인딩 */
    function fnSetGridSlipAmtBind( source ) {
        source = (source || {});

        var dr_amt = 0;
        var cr_amt = 0;

        $.each(source, function( idx, item ) {
            if (item.drcr_gbn == 'dr') {
                dr_amt = dr_amt + item.amt;
            } else if (item.drcr_gbn == 'vat') {
                dr_amt = dr_amt + item.amt;
            } else if (item.drcr_gbn == 'cr') {
                cr_amt = cr_amt + item.amt;
            }
        });

        dr_amt = dr_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        cr_amt = cr_amt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

        $('#lbSlipDrAmt').html(dr_amt);
        $('#lbSlipCrAmt').html(cr_amt);
    }
    /* 그리드 바인딩 - 지출결의 항목 - 분개 - 관리항목 */
    function fnSetGridMng() {
        var param = {};
        $.extend(param, ExExpendMng);
        param.compSeq = empInfo.compSeq;
        param.expendSeq = expend.expendSeq;
        param.listSeq = listSeq;
        param.slipSeq = slipSeq;
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/expend/mng/ExMngGridInfoSelect.do" />',
            datatype : 'json',
            async : false,
            data : param,
            success : function( data ) {
                fnSetGridMngBind(data.aaData);
                if(data && data.aaData && chkMngInfo){
                	fnDisplayMngErrorRows(data.aaData);
                }
            },
            error : function( data ) {
                console.log("! [EX][LISTGRID] ERROR - " + JSON.stringify(data));
            }
        });
    }
    /* 그리드 바인딩 - 지출결의 항목 - 분개 - 관리항목 - 테이블 바인딩 */
    function fnSetGridMngBind( source ) {
    	source = (source || {});
        expendMngTable = $('#tblExpendMng').dataTable({
            "select" : true,
            "paging" : false,
            "bAutoWidth" : false,
            "bSort" : false,
            "destroy" : true,
            "language" : {
                "lengthMenu" : "보기 _MENU_",
                "zeroRecords" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "info" : "_PAGE_ / _PAGES_",
                "infoEmpty" : "<%=BizboxAMessage.getMessage("TX000009638", "데이터가 없습니다")%>",
                "infoFiltered" : "(전체 _MAX_ 중.)"
            },
            "data" : source,
            "fnRowCallback" : function( nRow, aData, iDisplayIndex, iDisplayIndexFull ) {
                $(nRow).css("cursor", "pointer");
                $(nRow).on('click', (function() {
                    mngSeq = aData.mng_seq;
                }));

                $(nRow).on('dblclick', (function() {
                    mngSeq = aData.mng_seq;
                    
                    if(!hideMngWrite){
                    	return false;
                    }
                    
                    if( ifSystem == "iCUBE" && ( aData.mng_code == 'C1' || aData.mng_code == 'D4') ){
                    	return false;
                    }
                    if( ifSystem == "iCUBE" && aData.mng_code == 'D5' && mngInterFaceType == 'etax'){
                    	return false;
                    }
                    fnDefault_modifyMng();
                    // $('#btnExpendMngMod').click();
                }));

                $(nRow).attr("id", aData.expend_seq + "_" + aData.list_seq + "_" + aData.slip_seq + "_" + aData.mng_seq);

                return nRow;
            },
            "columnDefs" : [ {
                "targets" : 2,
                "data" : null,
                "render" : function( data ) {
                    if (data.ctd_code != '') {
                    	if(ifSystem == "ERPiU" && data.mng_code =="A08" && !isDisplayFullNumber){
                    		return data.ctd_code.replace(/([0-9]{4})-?([0-9]{3,4})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-****-****-$4");
                    	}else{
                        	return data.ctd_code;
                    	}
                    } else {
                        return '-';
                    }
                }
            }, {
                "targets" : 3,
                "data" : null,
                "render" : function( data ) {
                    
                	if(ifSystem == "iCUBE"){
                		if(data.mng_code =="F1" || data.mng_code =="F2" || data.mng_code =="F3"
                				|| data.mng_code =="G1" || data.mng_code =="G2" || data.mng_code =="G3"){
                			if(data.ctd_name != ''){
                				return [ data.ctd_name.substring(0, 4), data.ctd_name.substring(4, 6), data.ctd_name.substring(6, 8) ].join('-');	
                			}else{
                				return data.ctd_name;
                			}
                		}else{
                			return data.ctd_name;
                		}
                	}else{
                		if (data.ctd_name != '') {
                			switch (data.mng_form_code) {
                                case "0": /* ( ERPiU : 일반 / iCUBE : ) */
                                    return data.ctd_name;
                                    break;
                                case "1": /* ( ERPiU : 날짜 / iCUBE : ) */
                                    return [ data.ctd_name.substring(0, 4), data.ctd_name.substring(4, 6), data.ctd_name.substring(6, 8) ].join('-');
                                    break;
                                case "2": /* ( ERPiU : 금액 / iCUBE : ) */
                                	if((arrDotNum.indexOf(data.mng_code) > -1) && data.ctd_name.indexOf('.') > -1){
                                    	return data.ctd_name.split('.')[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '.' + data.ctd_name.split('.')[1];
                                    }else{
                                    	return data.ctd_name.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    }
                                    break;
                                case "3": /* ( ERPiU : 수량 / iCUBE : ) */
                                    return data.ctd_name.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                                    break;
                                case "4": /* ( ERPiU : 율(%) / iCUBE : ) */
                                if((arrDotNum.indexOf(data.mng_code) > -1) && data.ctd_name.indexOf('.') > -1){
                                	return data.ctd_name.split('.')[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + '.' + data.ctd_name.split('.')[1];
                                }else{
                                	return data.ctd_name.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
                                }
                                
                                    break;
                                default:
                                    return data.ctd_name;
                                    break;
                            }
                        } else {
                            return '-';
                        }
                	}
                }
            } ],
            "aoColumns" : [ {
                sTitle : "${CL.ex_controlProvision} ${CL.ex_code}",
                mData : "mng_code",
                bVisible : true,
                bSortable : false,
                sWidth : ""
            }, {
                sTitle : "${CL.ex_controlProvision} ${CL.ex_name}",
                mData : "mng_name",
                bVisible : true,
                bSortable : false,
                sWidth : "",
                sClass : "td_le"
            }, {
                sTitle : "${CL.ex_code}",
                bVisible : true,
                bSortable : false,
                sWidth : "",
            }, {
                sTitle : "${CL.ex_name}",
                bVisible : true,
                bSortable : false,
                sWidth : "",
                sClass : "td_le"
            } ]
        });
    }

    function fnChk( obj ) {
        var name = obj.name;
        var objChked = $("input[name=" + name + "]:checkbox");
        fnAllCheckBoxChecked(obj, objChked);
    }
    
    function fnSetExpendErrorInfo(){
    	var param = {};
        param.compSeq = empInfo.compSeq;
        param.expendSeq = expend.expendSeq;
        param.formSeq = formSeq;
        param.isBudgetCheck = isBudgetCheck;
        
        if(expend.expendSeq != 0){
	        /* 서버호출 */
	        $.ajax({
	            type : 'post',
	            url : '<c:url value="/ex/expend/master/ExUserErrorInfoSelect.do" />',
	            datatype : 'json',
	            async : false,
	            data : param,
	            success : function( data ) {
	            	if(data && data.aaData){
	            		fnSetErrorRows(data.aaData);
	            	}
	            },
	            error : function( data ) {
	                console.log("! [EX][LISTGRID] ERROR - " + JSON.stringify(data));
	            }
	        });
        }
    }
    
    function fnSetErrorRows(data){
    	var tempArray = new Array();
		$.each(data, function( idx, item ) {
			if(item.validateStat === "false"){
				tempArray.push(item);
			}
			
		});
		expendListErrorSeq = {};
		expendSlipErrorSeq = {};
		expendMngErrorSeq = {};
		expendListErrorSeq = _.groupBy(tempArray, function(d){return "error_" + d.listSeq});
		expendSlipErrorSeq = _.groupBy(tempArray, function(d){return "error_" + d.listSeq + '_' + d.slipSeq});
		expendMngErrorSeq = _.groupBy(tempArray, function(d){return "error_" + d.listSeq + '_' + d.slipSeq + '_' + d.mngSeq});
    }
    
    
    
    function fnDisplayListErrorRows(data){
    	$.each(data, function( idx, item){
    		if(typeof expendListErrorSeq['error_' + item.list_seq] != 'undefined'){
    			$("#" + expend.expendSeq + "_" + item.list_seq + "_0_0").addClass('expendErrorRow');
    			$("#" + expend.expendSeq + "_" + item.list_seq + "_0_0").attr('title',expendListErrorSeq['error_' + item.list_seq][0].error);
    			
    		}
    	});
    }
    function fnDisplaySlipErrorRows(data){
    	$.each(data, function( idx, item){
    		if(typeof expendSlipErrorSeq['error_' + item.list_seq + '_' + item.slip_seq] != 'undefined'){
    			$("#" + expend.expendSeq + "_" + item.list_seq + "_" + item.slip_seq + "_0").addClass('expendErrorRow');
    			$("#" + expend.expendSeq + "_" + item.list_seq + "_" + item.slip_seq + "_0").attr('title',expendSlipErrorSeq['error_' + item.list_seq + '_' + item.slip_seq][0].error);
    		}
    	});
    }
    function fnDisplayMngErrorRows(data){
    	$.each(data, function( idx, item){
    		if(typeof expendMngErrorSeq['error_' + item.list_seq + '_' + item.slip_seq + '_' + item.mng_seq] != 'undefined'){
    			$("#" + expend.expendSeq + "_" + item.list_seq + "_" + item.slip_seq + "_" + item.mng_seq).addClass('expendErrorRow');
    			$("#" + expend.expendSeq + "_" + item.list_seq + "_" + item.slip_seq + "_" + item.mng_seq).attr('title',expendMngErrorSeq['error_' + item.list_seq + '_' + item.slip_seq + '_' + item.mng_seq][0].error);
    		}
    	});
    }
    /* 분개 정보에서 에러가 없는 경우 해당 항목 정보의 에러 표시 제거 */
    function fnReDisplayErrorSlipRows(){
        var tableData = expendSlipTable.fnGetData();
        var emptyError = true;
   		$.each(tableData, function(idx, item){
//            	if($("#" + item.DT_RowId).hasClass('expendErrorRow') === true){
			if(typeof expendMngErrorSeq['error_' + item.DT_RowId] != 'undefined'){
           		emptyError = false;
           		return false;
           	}
       	});
		if(emptyError){
			$("#" + expend.expendSeq + "_" + listSeq + "_0_0").removeClass("expendErrorRow");
			$("#" + expend.expendSeq + "_" + listSeq + "_0_0").removeAttr("title");
		}
    }
    /* 관리항목 정보에서 에러가 없는 경우 해당 분개 정보의 에러 표시 제거 */
    function fnReDisplayErrorMngRows(){
        var tableData = expendMngTable.fnGetData();
        var emptyError = true;
        $.each(tableData, function(idx, item){
//         	if($("#" + expend.expendSeq + "_" + item.list_seq + "_" + item.slip_seq+ "_" + item.mng_seq).hasClass('expendErrorRow') === true){
			if(typeof expendMngErrorSeq['error_' + item.list_seq + '_' + item.slip_seq + '_' + item.mng_seq] != 'undefined'){
        		emptyError = false;
        		return false;
        	}
       	});
		if(emptyError){
			$("#" + expend.expendSeq + "_" + listSeq + "_" + slipSeq+ "_0").removeClass("expendErrorRow");
			$("#" + expend.expendSeq + "_" + listSeq + "_" + slipSeq+ "_0").removeAttr("title");
		}
    }
    
    /* 상신 전 관리항목 누락 or 예산 초과 항목 있는경우 상신 못하게  */
    function fnChkErrorRows(){
    	/* 에러 유무 확인 */
    	if($(".ExpendList").css('display') != 'none'){
    		var listTable = expendListTable.fnGetData();
            var chkError = false;
       		$.each(listTable, function(idx, item){
       			if($("#" + expend.expendSeq + "_" + item.list_seq + "_0_0").hasClass('expendErrorRow') === true){
       				chkError = true;
            		return false;
            	}
           	});
       		if(chkError){
       			return true;
       		}
        	return false;	
    	}else{
    		var slipTable = expendSlipTable.fnGetData();
            var chkError = false;
       		$.each(slipTable, function(idx, item){
       			if($("#" + expend.expendSeq + "_" + item.list_seq + "_" + item.slip_seq + "_0").hasClass('expendErrorRow') === true){
       				chkError = true;
            		return false;
            	}
           	});
       		if(chkError){
       			return true;
       		}
        	return false;    		
    	}
    }
    
    /*	[금액 정보] 사용자 입력의 총 금액정보 리턴 
    ---------------------------------------------- */
    function fnGetMasterAMTInfo(basicAmt){
		var stdAmt = parseInt($('#lbListStdAmt').text().toString().replace(/,/g,'')|| '0');
		var taxAmt = parseInt($('#lbListTaxAmt').text().toString().replace(/,/g,'')|| '0');
		var amt = parseInt($('#lbListAmt').text().toString().replace(/,/g,'')|| '0');
		var drAmt = parseInt($('#lbSlipDrAmt').text().toString().replace(/,/g,'') || '0');
		var crAmt = parseInt($('#lbSlipCrAmt').text().toString().replace(/,/g,'')|| '0');
		var basicAmt = parseInt(basicAmt.toString().replace(/,/g,'')|| '0');
// 		drAmt = drAmt - basicAmt;
// 		crAmt = crAmt - basicAmt;
		return {
			getStdAmt : function(){return stdAmt;}
			, getTaxAmt : function(){return taxAmt;}
			, getAmt : function(){return amt;}
			, getDrAmt : function(){return drAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")  ;}
			, getCrAmt : function(){return crAmt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")  ;}
			, addDrAmt : function(value){
				drAmt = parseInt(drAmt) + parseInt(value) - parseInt(basicAmt);
			}
			, addCrAmt : function(value){
				crAmt = parseInt(crAmt) + parseInt(value) - parseInt(basicAmt);
			}
			, getDrCrDifference : function (){
				return Math.abs ( parseInt(drAmt) - parseInt(crAmt) ).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
			}
			, getDrCrDifferenceCopy : function (){
				var difference = Math.abs ( parseInt(drAmt) - parseInt(crAmt) );
				difference = difference.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")
				return	( parseInt(drAmt) > parseInt(crAmt) ?
						'차변이 대변보다 ' + difference + ' 많습니다. ' : 
						( 
							parseInt(drAmt) == parseInt(crAmt)  ? 
							'차대변 금액 같음' :
							'대변이 차변보다 ' + difference + ' 많습니다. ' 
						) ) + '\n다음 입력 값으로 저장하시겠습니까?';
			}
			, getDrCrMoreItem : function (isUpper){
				if(isUpper){
					return	parseInt(drAmt) > parseInt(crAmt) ? 'DR' : ( parseInt(drAmt) == parseInt(crAmt)  ? '' : 'CR' );	
				}
				return	parseInt(drAmt) > parseInt(crAmt) ? 'dr' : ( parseInt(drAmt) == parseInt(crAmt)  ? '' : 'cr' );
			}
    	}
    }
    
    function fnExpendHistoryReflect_callback( param ){
    	isPopupOpen = false;
    	if(!isInsertSlipMode){
    		fnSetGridList();
    	}else{
    		fnSetGridList();
    		fnSetGridSlip();
    	}

    	fnSetExpendErrorInfo();
    	
        historyPop.close();
        fnExpendDateSetting(true);
    }
    
    function fnExpendDateSetting(isExpendHistoryIn){
    	/* 기존 지출결의의 회계일자로 설정 */
        var tExpendDate = expend.expendDate;
    	if(tExpendDate.length == 8 ){
    		tExpendDate = tExpendDate.substr(0,4) + '-' + tExpendDate.substr(4,2) + '-' + tExpendDate.substr(6,2);
    	}
		if(isExpendHistoryIn){
			datepicker.value(tExpendDate);
			$('#txtExpendDate').val(tExpendDate);
		}
		/* 기존 지출결의의 지급요청일로 설정 */
        var tExpendReqDate = expend.expendReqDate;
        if(tExpendReqDate.length == 8 ){
        	tExpendReqDate = tExpendReqDate.substr(0,4) + '-' + tExpendReqDate.substr(4,2) + '-' + tExpendReqDate.substr(6,2);
        }
        
		expendReqDate.value(tExpendReqDate);
    	
//     	 datepicker.enable();
		if(isUseBudget){
			// 현재 회계 일자의 마지막 날
			var currentDate = new Date(expend.expendDate.substr(0,4), expend.expendDate.substr(4,2), "");
			// 회계 일자 1일부터 말일 까지 선택 가능 하도록 설정
// 			datepicker.min(new Date(currentDate.getFullYear(), currentDate.getMonth(), 1));
// 			datepicker.max(currentDate);
			$('#txtExpendDate').attr('title',"<%=BizboxAMessage.getMessage("TX000018815", "항목 존재시 회계일자는 변경이 불가능합니다.")%>");
		}
    }
    
    /* 지출결의 월마감 설정 */
    function fnExpendCloseDateSetting(){
    	/* 회계일자 마감 설정 */
//     	if( expendCloseDate != ''){
//     		var expendCloseFromDate = new Date(expendCloseDate.substr(0,4),(expendCloseDate.substr(4,2) - 1),expendCloseDate.substr(6,2));
//         	datepicker.min(new Date(expendCloseFromDate.getFullYear(), expendCloseFromDate.getMonth(), expendCloseFromDate.getDate()));
//     	}
//     	var expendCloseToDate = new Date("2017","09","10");
//     	datepicker.max(new Date(expendCloseToDate.getFullYear(), expendCloseToDate.getMonth(), expendCloseToDate.getDate()));
    }
    
    function fnExLayerPopOpen(url, param, title, width, height, opener, parentId, childrenId){
    	$("html, body").scrollTop(0);
    	$.ajax({
    		type:"post",
    		url: url,
    		datatype:"json",
    		data: param, 
    		success:function(data){
            	var $parent;		//modal과 레이어가 들어갈 div 
    			var $children;		//레이어 div
    			
            	if (opener == "1") {
            		// 1.컨텐츠영역에서 레이어팝업 띄울 경우
            		$parent = $(".sub_contents_wrap");
            		
    				$parent.append('<div id="modal" class="modal"></div>');
            	} else if (opener == "2") {
            		// 2.윈도우팝업에서 레이어팝업 띄울 경우
            		$("body").css("overflow", "hidden");
            		
            		if ($(".pop_wrap").size() > 0) {
            			$parent = $(".pop_wrap");
    	        	}
    	        	if ($(".pop_sign_wrap").size() > 0) {
    	        		$parent = $(".pop_sign_wrap");
    	        	}    		        	

    	        	$parent.append('<div id="modal" class="modal" style="z-index:101;"></div>');    		        
            	} else if (opener == "4"){
            		//iframe에서 팝업
            		$parent = $('.pop_sign_wrap', parent.document);
            		var modalHeight = $parent.height();
            		
            		$parent.append('<div id="modal" class="modal" style="height:'+modalHeight+'px;"></div>');
            	} else {
            		// 3.레이어팝업에서 레이어팝업 띄울 경우
            		$parent = $("#" + parentId);
            		
            		$parent.append('<div id="modal_' + childrenId + '" class="modal"></div>');
            	}  
    			if(childrenId){
    				$parent.after(data);
    			}else $parent.append(data);
    			
    			if (opener == "1" || opener == "2") {
    				$children = $(".pop_wrap_dir_expend");
    				childrenId = ""; 
    			}else if (opener == "4") {
    				$children = $parent.find("#"+parentId);
    				childrenId = ""; 
    			}else {
        			$children = $("#" + childrenId);
    			}
    	
    			if (width != "") {
    				$children.css("width", width);
    			}
    			if (height != "") {
    				$children.css("height", height);
    			}
    			$children.css("border", "1px solid #adadad");
    			$children.css("z-index", "102");
    			
    			var header = '<div class="pop_head">';
    			header += '<h1>' + title + '</h1>';
//     			header += '<a href="javascript:layerPopClose(\'' + childrenId + '\');" class="clo" style="display:block;"><img src="/eap/Images/btn/btn_pop_clo02.png" alt="" /></a>';
    			header += '<a href="javascript:fnExCloseLayPop();" class="clo" style="display:block;"><img src="/eap/Images/btn/btn_pop_clo02.png" alt="" /></a>';
    			header += '</div>';
    			    			
    			$children.prepend(header);
    			
    			var popWid = $children.outerWidth();
    			var popHei = $children.outerHeight();

    			$children.css("top","50%").css("left","50%").css("marginLeft",-popWid/2).css("marginTop",-popHei/2);
    			
    			$(window).resize(function(){
    				
    				$children.css("top","50%").css("left","50%").css("marginLeft",-popWid/2).css("marginTop",-popHei/2);
    				
    				
    			});

    		},
    		error : function(data){
    			//alert(data.exMsg);
    		}
    	 }); 
    }
    
    
    function fnExCloseLayPop(){
//     	$(".pop_wrap_dir:not(#PLP_divMainProgPop)").remove();
    	$(".pop_wrap_dir_expend").remove();
		$("#modal").remove();
		$("body").css("overflow", "auto");
		isPopupOpen = false;
		//실패사유 보기 클릭이벤트 버블링 때문에 추가
		$('#PLP_btnShowPop').unbind();
    }
    
    /* drag and drop 이벤트 취소 > 참조 : https://webisfree.com/2016-05-03/%ED%8C%8C%EC%9D%BC-%EB%93%9C%EB%9E%98%EA%B7%B8%ED%95%98%EC%97%AC-%EB%93%9C%EB%9E%8D%EC%8B%9C-%EC%9D%B4%EB%B2%A4%ED%8A%B8-%EB%AC%B4%EC%8B%9C-preventdefault */
    window.addEventListener("dragover",function(e){
		e = e || event;
		e.preventDefault();
   	},false);
    
    window.addEventListener("drop",function(e){
		e = e || event;
		e.preventDefault();
   	},false);
</script>

<style type="text/css">
.expendErrorRow {
	border: 2px dashed red;
}
</style>

<input type="hidden" id="hidListSeq" value="1"></input>
<input type="hidden" id="hidSlipSeq"></input>
<input type="hidden" id="hidMngSeq"></input>


<!-- 팝업 호출 정보 -->
<form id="budget_chk" name="formChk" method="post">
	<input type="hidden" name="budget_code" value="" id="budget_code" /> <input
		type="hidden" name="amt" value="" id="amt"> <input
		type="hidden" name="budget_ym" value="" id="budget_ym"> <input
		type="hidden" name="acct_code" value="" id="acct_code"> <input
		type="hidden" name="drctr_gbn" value="" id="drctr_gbn">
</form>

<div class="pop_sign_wrap">
	<div class="pop_sign_head">
		<h1 id="formNameTitle"></h1>

		<div class="signline_info_box" id="approvalInfo_box"
			style="display: block; margin-top: -25px; top: 10px!imoprtant;">
			<div class="signline_info_tit">
				<h6>${CL.ex_expendFormSpecialInfo} <!--결재양식 특이사항--></h6>
			</div>
			<div class="signline_info_con" id="mustinfo">
				<dl>
					<dt id="formAlert">
						<dd></dd>
					</dt>
				</dl>
			</div>
		</div>

		<div class="psh_btnbox">
			<div class="psh_right">
				<div class="btn_cen mt8 btnPosition10">
					<button style="width: 104px; display: none;" id="btnSendExpend"
						class="psh_btn" value="">전송</button>
				</div>
			</div>
		</div>
	</div>

	 <div class="pop_sign_con fixed-hei " fixed-hei="44" style="padding-top: 42px;"> 
		<div class="pop_con">
			<div class="com_ta">
				<table>
					<colgroup>
						<col width="15%" />
						<col width="35%" />
						<col width="15%" />
						<col width="35%" />
					</colgroup>
					<tr>
						<th>${CL.ex_accountingDate}</th>
						<td><input id="txtExpendDate" class="dpWid" /></td>
						<th>${CL.ex_paymentDate}</th>
						<td><input id="txtExpendReqDate" class="dpWid" /></td>
					</tr>
					<tr class="ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendEmp">
						<th class="ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendEmp"
							style="display: none;">${CL.ex_user}</th>
						<td
							class="dod_search ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendEmp"
							style="display: none;"><input type="text"
							style="ime-mode: active; width: 60px;" id="txtExpendEmpCode" />
							<input type="text" style="width: 125px; ime-mode: active"
							id="txtExpendEmpName" /> <a id="btnExpendEmpSearch"
							class="btn_sear" href="#"> </a></td>
						<th class="ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendEmp"
							style="display: none;">${CL.ex_useDepartment}</th>
						<td class="dod_search ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendEmp"
							style="display: none;"><input type="text"
							style="width: 60px; ime-mode: active" id="txtExpendDeptCode"
							readonly="readonly" disabled="disabled" /> <input type="text"
							style="width: 125px; ime-mode: active" id="txtExpendDeptName" /><a id="btnExpendDeptSearch"
							class="btn_sear" href="#"> </a></td>
					</tr>
					<tr class="ExpendERPiU ExpendCCPC ExpendPC">
						<th class="ExpendERPiU ExpendEmp ExpendPC" style="display: none;">
							${CL.ex_accountingUnit}</th>
						<td class="dod_search ExpendERPiU ExpendEmp ExpendPC"
							style="display: none;"><input type="text"
							style="ime-mode: active; width: 60px;" id="txtExpendPcCode"
							readonly="readonly" /> <input type="text"
							style="ime-mode: active; width: 125px;" id="txtExpendPcName" />
							<a id="btnExpendPcSearch" class="btn_sear" href="#"></a></td>
						<th class="ExpendERPiU ExpendEmp" style="display: none;">
							${CL.ex_costCenter}</th>
						<td class="dod_search ExpendERPiU ExpendEmp"
							style="display: none;"><input type="text"
							style="ime-mode: active; width: 60px;" id="txtExpendCcCode"
							readonly="readonly" /> <input type="text"
							style="ime-mode: active; width: 125px;" id="txtExpendCcName" />
							<a id="btnExpendCcSearch" class="btn_sear" href="#"></a></td>
					</tr>
					<tr>
						<th class="ExpendBizboxA ExpendERPiU ExpendBudget"
							style="display: none;">${CL.ex_budgetUnit}</th>
						<td class="dod_search ExpendBizboxA ExpendERPiU ExpendBudget"
							style="display: none;"><input type="text"
							style="ime-mode: active; width: 60px;" id="txtExpendBudgetCode"
							readonly="readonly" /> <input type="text"
							style="ime-mode: active; width: 125px;" id="txtExpendBudgetName" />
							<a id="btnExpendBudgetSearch" class="btn_sear" href="#"></a></td>
						<th class="ExpendERPiU ExpendBudget" style="display: none;">
							${CL.ex_businessPlan}</th>
						<td class="dod_search ExpendERPiU ExpendBudget"
							style="display: none;"><input type="text"
							style="ime-mode: active; width: 60px;" id="txtExpendBizplanCode"
							readonly="readonly" /> <input type="text"
							style="ime-mode: active; width: 125px;" id="txtExpendBizplanName" />
							<a id="btnExpendBizplanSearch" class="btn_sear" href="#"></a></td>
					</tr>
					<tr>
						<th class="ExpendBizboxA ExpendERPiU ExpendBudget"
							style="display: none;">${CL.ex_budgetAccount}</th>
						<td class="dod_search ExpendBizboxA ExpendERPiU ExpendBudget">
							<input type="text" style="ime-mode: active; width: 60px;"
							id="txtExpendBgAcctCode" readonly="readonly" /> <input
							type="text" style="ime-mode: active; width: 125px;"
							id="txtExpendBgAcctName" /> <a id="btnExpendBgAcctSearch"
							class="btn_sear" href="#"></a>
						</td>
						<th class="ExpendBizboxA ExpendiCUBE ExpendERPiU"
							style="display: none;"></th>
						<td class="dod_search ExpendBizboxA ExpendiCUBE ExpendERPiU"></td>
					</tr>
					<tr>
						<th class="ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendProject"
							style="display: none;">${CL.ex_project}</th>
						<td
							class="dod_search ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendProject"
							style="display: none;"><input type="text"
							style="ime-mode: active; width: 60px;" id="txtExpendProjectCode"
							readonly="readonly" /> <input type="text"
							style="ime-mode: active; width: 125px;" id="txtExpendProjectName" />
							<a id="btnExpendProjectSearch" class="btn_sear" href="#"></a></td>
						<th class="ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendPartner"
							style="display: none;">${CL.ex_vendor}</th>
						<td
							class="dod_search ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendPartner"
							style="display: none;"><input type="text"
							style="ime-mode: active; width: 60px;" id="txtExpendPartnerCode"
							readonly="readonly" /> <input type="text"
							style="ime-mode: active; width: 125px;" id="txtExpendPartnerName" />
							<a id="btnExpendPartnerSearch" class="btn_sear" href="#"></a></td>
					</tr>
					<tr>
						<th class="ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendCard"
							style="display: none;">${CL.ex_card}</th>
						<td
							class="dod_search ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendCard"
							style="display: none;"><input type="text"
							style="ime-mode: active; width: 60px;" id="txtExpendCardCode"
							readonly="readonly" /> <input type="text"
							style="ime-mode: active; width: 125px;" id="txtExpendCardName" />
							<a id="btnExpendCardSearch" class="btn_sear" href="#"></a></td>
						<th class="ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendBaseNote"
							style="display: none;">${CL.ex_basicNote}</th>
						<td class="ExpendBizboxA ExpendiCUBE ExpendERPiU ExpendBaseNote"
							colspan="3" style="display: none;"><input
							style="width: 88%; ime-mode: active;" type="text"
							id="txtExpendBaseNote" /></td>
					</tr>
				</table>
			</div>
			<!--  항목정보  -->
			<div class="clear ExpendList">
				<div class="btn_div btn_float" style="z-index:2;"> 
					<div class="left_div">
						<p class="tit_p m0 mt5">${CL.ex_listInfomation}</p>
					</div>
					<div class="right_div">
						<div class="controll_btn p0 btnPosition20"></div>
					</div>
				</div>
				<div class="btn_float_bg"></div>
				<div id="divExpendList" class="com_ta2">
					<table id="tblExpendList">
					</table>
				</div>
				<div class="com_ta_sum">
					<dl>
						<dt>${CL.ex_purPriceTotal}:</dt>
						<dd id="lbListStdAmt">0 (0)</dd>
						<dt>${CL.ex_taxTotal}:</dt>
						<dd id="lbListTaxAmt">0 (0)</dd>
						<dt>${CL.ex_amountSupplyTotal}:</dt>
						<dd id="lbListAmt">0</dd>
					</dl>
				</div>
			</div>
			<!--  분개정보  -->
			<div class="clear mt10 ExpendSlip">
				<div class="btn_div mt14 mb5">
					<div class="left_div">
						<p class="tit_p m0 mt5">${CL.ex_journalInformation}</p>
					</div>
					<div class="right_div">
						<div class="controll_btn p0 btnPosition30"></div>
					</div>
				</div>
				<div class="com_ta2 mt10">
					<table id="tblExpendSlip">
					</table>
				</div>
				<div class="com_ta_sum">
					<dl>
						<dt>${CL.ex_debitTotal}:</dt>
						<dd id="lbSlipDrAmt">0</dd>
						<dt>${CL.ex_creditTotal}:</dt>
						<dd id="lbSlipCrAmt">0</dd>
					</dl>
				</div>
			</div>
			<!--  관리항목  -->
			<div class="clear mt10 ExpendMng">
				<div class="btn_div mt14 mb5">
					<div class="left_div">
						<p class="tit_p m0 mt5">${CL.ex_controlProvision}</p>
					</div>
					<div class="right_div">
						<div class="controll_btn p0 btnPosition40">
							<button id="btnExpendMngMod" style="display: none;"><%=BizboxAMessage.getMessage("TX000009508", "관리항목 수정")%></button>
						</div>
					</div>
				</div>
				<div class="com_ta2 mt10">
					<table id="tblExpendMng">
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //pop_wrap -->