<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="main.web.BizboxAMessage"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%-- <%@ include file="/WEB-INF/jsp/ea/include/includeCmmOrgPop.jsp"%> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--jquery UI css-->
<script type="text/javascript" src='<c:url value="/js/jqueryui/jquery-ui.min.js"></c:url>'></script>

<script type="text/javascript" src='<c:url value="/js/jquery.mask.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/CommonEX.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/neos/NeosUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/ex/ExCodePop.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/jquery.dataTables.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.select.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.scroller.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.rowReorder.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/datatables/dataTables.fixedHeader.min.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.layout.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.code.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/jQuery.exp.expend.focus.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/expend/ex/ex.comboBox.js"></c:url>'></script>
<jsp:include page="../../../../common/cmmCodePop.jsp" flush="false" />

<!-- 관리자 > 회계 > 지출결의 설정 > 카드 설정 -->

<script>
    /* 변수정의 */
    var ifSystem = '${ViewBag.erpTypeCode}';
    var baseUrl = '<c:url value="/" />'; /* 팝업 호출시 사용 */
    var searchCompSeq = ''; /* 팝업 호출시 사용 */
    var empInfo = {
        erpEmpSeq : "${ViewBag.empInfo.erpEmpSeq}",
        langCode : "${ViewBag.empInfo.langCode}",
        erpCompSeq : "${ViewBag.empInfo.erpCompSeq}",
        groupSeq : "${ViewBag.empInfo.groupSeq}",
        empSeq : "${ViewBag.empInfo.empSeq}",
        compSeq : "${ViewBag.empInfo.compSeq}",
        userSe : "${ViewBag.empInfo.userSe}",
        deptSeq : "${ViewBag.empInfo.deptSeq}",
        bizSeq : "${ViewBag.empInfo.bizSeq}"
    };
    var clickCount =0;

    /* 문서로드 */
    $(document).ready(function() {
        fnConfigCardInit();
        fnConfigCardInitEvent();
        $('#btnConfigCardSearch').click();
        if(ifSystem != 'ERPiU'){
        	$('.ERPiU').hide();	
        }
    });
    
    /* 초기화 */
    function fnConfigCardInit() {
    	
        $('#devMode_forCmPop').val(empInfo.groupSeq);
        $('#langCode_forCmPop').val(empInfo.langCode);
        $('#groupSeq_forCmPop').val(empInfo.groupSeq);
        $('#compSeq_forCmPop').val(empInfo.compSeq);
        $('#deptSeq_forCmPop').val(empInfo.deptSeq);
        $('#empSeq_forCmPop').val(empInfo.empSeq);
        
        $('#compFilter_forCmPop').val("${ViewBag.empInfo.compSeq}");
        $('#selectedItems_forCmPop').val("");
        $('button').kendoButton(); /* 켄도버튼정의 */
        
        setComboBox($("#selUsed"), JSON.parse('${ViewBag.commonCodeListYesOrNo}' || '{"common_name" : "", "common_code" : ""}'));
        
    	
        /* 기본값 지정 */
        var selUseYN = '${selUseYN}' === '' ? [] : ${selUseYN};
        selUseYN.push({commonName:"전체",commonCode:"",order_num:0});
        setComboBox($("#selUseYN"), selUseYN);
        var combobox = $("#selUseYN").data("kendoComboBox");
        combobox.value('Y');
        combobox.trigger("change"); /* 사용여부 */
// 		});
		
		
        /* 연동 모듈에 따른 아이템 출력 선택 */
    	if(ifSystem == 'BizboxA'){
    		// 자체예산의 경우 
    		$('#txtCardName').removeAttr('disabled');
    		$('#txtCardNum').removeAttr('disabled');
    		$("#selUsed").kendoComboBox({ enabled : true });
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerName').attr('disabled', 'disabled');
			
            /* ERP에서 가져오기 기능 지우기 */
            $('#btnConfigCardFromErp').hide();
    	}
    	else if(ifSystem == 'iCUBE'){
    		// iCUEBE의 경우. 
    		$('#txtCardName').attr('disabled', 'disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : false });
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerName').attr('disabled', 'disabled');
            
            /* ERP에서 가져오기 기능 출력 */
            $('#btnConfigCardFromErp').show();
    	} else if(ifSystem == 'ERPiU'){
    		// ERPiU의 경우. 
    		$('#txtCardName').attr('disabled', 'disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : false });
            $('#txtPartnerCode').removeAttr('disabled');
            $('#txtPartnerName').removeAttr('disabled');
            
            /* ERP에서 가져오기 기능 출력 */
            $('#btnConfigCardFromErp').show();
    	}else{
    		// 기타 시스템의 경우
    	}
        
        // 최초 접근 포커스 위치 조정 
        $('#txtSearchStr').focus();
        return;
    }

    /* 이벤트 초기화 */
    function fnConfigCardInitEvent() {
        /* 변수정의 */
        var param = {};
        /* 이벤트 정의 */
        /* 이벤트 정의 - ERP가져오기 */
        $('#btnConfigCardFromErp').click(function() {
            fnConfigCardFromErp();
            return;
        });
        
        /* 이벤트 정의 - 조회 엔터입력*/
        $('#txtSearchStr').keydown(function (event) {
            if (event.keyCode === 13) {
                event.returnValue = false;
                event.cancelBubble = true;
                $('#btnConfigCardSearch').click();
            }
        });
        
        /* 이벤트 정의 - 조회 */
        $('#btnConfigCardSearch').click(function() {
            fnConfigCardSearch();
            return;
        });
        /* 이벤트 정의 - 신규 */
        $('#btnConfigCardNew').click(function() {
            fnConfigCardNew();
            $('#txtCardName').focus();
            return;
        });
        /* 이벤트 정의 - 저장 */
        $('#btnConfigCardSave').click(function() {
            fnConfigCardSave();
            return;
        });
        /* 이벤트 정의 - 삭제 */
        $('#btnConfigCardDelete').click(function() {
            fnConfigCardDelete();
            return;
        });
        /* 이벤트 정의 - 공개범위 */
        $('#btnOrgChart').click(function() {

            var url = "<c:url value='/html/common/cmmOrgPop.jsp'/>";
            var pop = window.open("", "cmmOrgPop", "width=760,height=780,scrollbars=no,screenX=150,screenY=150");

            frmPop2.target = "cmmOrgPop";
            frmPop2.method = "post";
            frmPop2.action = url;
            frmPop2.submit();
            frmPop2.target = "";
            pop.focus();
            return;
        });
        /* 이벤트 정의 - 금융거래처 */
        $('#btnPartnerPop').click(function() {
            fnConfigCardPartnerPop();
            return;
        });
        /* 이벤트 정의 - 공개범위 초기화 */
        $('#btnPublicReload').click(function(event){
        	fnCardPublicReload();
        })
        
        /* 이벤트 정의 - 금융거래처 초기화 */
        $('#btnPartnerReload').click(function(event){
        	fnCardPartnerReload();
        })
        
        /* 공개범위 포커스 트리거 등록 - 공개범위 선택 조직도 팝업 */
        //20180823 soyoung 기존 포커스일경우 팝업닫기 후 다시 팝업이 활성화되는 문제가 있어 클릭이벤트로 변경
        $('#txtCardPublic').click(function(){
	        	if(!$('#txtCardPublic').val()){
	        		$('#btnOrgChart').click();	
	        	}
        });
        
        /* 이벤트 정의 - 엔터입력시 포커스 이동 jQuery.exp.expend.focus.js 참조 */
        focus_fnSetFocusEvent(
       		['txtCardName', 'txtCardNum', 'txtCardPublic']
       		, fnConfigCardSave
     	);
        return;
    }

    /* 버튼클릭 이벤트 - 공개범위 초기화 */
    function fnCardPublicReload(param){
        $('#selectedItems_forCmPop').val('');
        $('#hidCardPublic').val('');
        $('#txtCardPublic').val('');
    }
    
    /* 버튼클릭 이벤트 - 금융거래처 초기화 */
    function fnCardPartnerReload(){
     	$('#txtPartnerCode').val('');
    	$('#txtPartnerName').val('');
    }
    
    
    /* 버튼클릭 이벤트 - 조회 */
    var autoSync = false;
    function fnConfigCardSearch( param ) {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        searchCompSeq = "${ViewBag.empInfo.compSeq}"; /* 팝업 호출시 사용 */
        param.searchStr = '';
        param.codeType = "CARD";
        param.searchType = 'IN';
        param.textFilter = $('#txtSearchStr').val() || '';
        param.useYN = $("#selUseYN").val();
        param.selPublic = 'A';
        param.eaType = 'eap';
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoSelect.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
            	if(!data.result.aaData.length && !autoSync && ifSystem != 'BizboxA'){
            		// 데이터 없는 경우 자동 연동 진행
           			$('#btnConfigCardFromErp').click();
            	}else{
	                if (typeof data.result.aaData != 'undefined') {
	                    /* 테이블 데이터 바인딩 */
// 	                    fnConfigCardSetTable(data.result.aaData);
	                    fnSetGrid(data.result.aaData);
	                } else {
	                    /* 테이블 데이터 바인딩 */
// 	                    fnConfigCardSetTable('');
	                    fnSetGrid('');
	                }
	                /* 신규 버튼 클릭이벤트 발생 */
	                $('#btnConfigCardNew').click();
	                
	                /* 조회의 경우 포커스 고정 */
	                if($('#txtSearchStr').val()){
	                	$('#txtSearchStr').focus();
	                	isSearchFlag = false;
	                }
            	}
            	
            	autoSync = true;
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
	
	
    /* 계산서 리스트 바인딩 */
	function fnSetGrid(data){
		$("#tblConfigCardList").empty();
		var colGroup = '<colgroup>';
		colGroup += '<col width="140"/>';
		colGroup += '<col width="150"/>';
		colGroup += '<col width="20%"/>';
		colGroup += '<col width="20%"/>';
		colGroup += '<col width="*"/>';
		colGroup += '</colgroup>';
		
		$("#tblConfigCardList").append(colGroup);
		if(data == null || data == undefined || data.length == 0){
			var tr = document.createElement('tr');
			$(tr).append('<td colspan="' + $("#tblConfigCardList colgroup col").length + '">데이터가 없습니다.</td>')
			$("#tblConfigCardList").append(tr);
		}else{
			$.each(data,function(idx, val){
				var tr = document.createElement('tr');
				$(tr).data('data', val);
				var cardNum = val.cardNum.replace(/-/gi,'') || '';
            	cardNum = cardNum.toString().replace(/\B(?=(\d{4})+(?!\d))/g, "-")
				$(tr).append('<td class="ce">' + cardNum + '</td>');
            	$(tr).append('<td class="le">' + val.cardName + '</td>');
            	if ((val.partnerCode || '') != '' && (val.partnerName || '') != '') {
                    $(tr).append('<td class="le">[' + (val.partnerCode || '') + '] ' + (val.partnerName || '') + '</td>');
                } else {
                	$(tr).append('<td class="le"></td>');
                }
				var useLabel = "";
				if (val.useYN == "0" || val.useYN == "N") {
					useLabel = "<%=BizboxAMessage.getMessage("TX000001243","미사용")%>";
				} else {
					useLabel = "<%=BizboxAMessage.getMessage("TX000000180","사용")%>";
				}
				$(tr).append('<td class="ce">'+useLabel+'</td>');
				var data = '' + (val.cardPublicJson || '"returnObj":[]');
				if( data.indexOf('"returnObj":[]') > -1  ){
					$(tr).append('<td class="ce"><span class="text_red">미설정</span></td>');	
				}else{
					$(tr).append('<td class="ce">설정</td>');
				}
				$("#tblConfigCardList").append(tr);
			});
			
			$("#tblConfigCardList tr").on("click",function(e){
				clickCount++;
				var clickElement = this;
				if(clickCount === 1){
					timeOut = setTimeout(function(){
						clickCount = 0;
						fnConfigCardSelectRow($(clickElement).data().data);
					}, 200);
				}
			});
		}
		
		if (ifSystem != 'BizboxA') {
            $('#btnConfigCardNew').hide(); /* ERP연동인 경우, 카드 신규 생성 기능 제외 - ERP 기준 카드만 바라봐야 하기 때문 */
            $('#btnConfigCardDelete').hide(); /* ERP연동인 경우, 카드 삭제 기능 제외 - ERP 기준 카드만 바라봐야 하기 때문 */
            $('#btnConfigCardFromErp').show(); /* ERP연동인 경우, ERP가져오기기능 활성 - ERP 기준 카드만 바라봐야 하기 때문 */
        } else {
            $('#btnConfigCardNew').show(); /* ERP 연동이 아닌경우, 카드 직접 관리 */
            $('#btnConfigCardDelete').show(); /* ERP 연동이 아닌경우, 카드 직접 관리 */
            $('#btnConfigCardFromErp').hide(); /* ERP 연동이 아닌경우, 데이터 조회 불가 */
        }
	}

    /* 행클릭 이벤트 */
    function fnConfigCardSelectRow( data ) {
        if (data.cardPublicJson != undefined && data.cardPublicJson != '') {
            fnCallbackSel(JSON.parse(data.cardPublicJson)); /* 공개범위 */
        } else {
            $('#selectedItems_forCmPop').val('');
            $('#hidCardPublic').val('');
            $('#txtCardPublic').val('');
        }

        // $('#').val(data.card_code); /* 카드코드 */
        $('#txtCardCode').val(data.cardCode); /* 카드코드 */
        $('#txtCardName').val(data.cardName); /* 카드명칭 */
        var cardNum = data.cardNum.replace(/-/gi,'') || '';
    	cardNum = cardNum.toString().replace(/\B(?=(\d{4})+(?!\d))/g, "-")
    	$('#txtCardNum').val(cardNum); /* 카드번호 */
        $('#txtPartnerCode').val(data.partnerCode); /* 금융거래처 */
        $('#txtPartnerName').val(data.partnerName); /* 금융거래처 */
        var combobox = $("#selUsed").data("kendoComboBox");
        combobox.value(data.useYn);
        combobox.trigger("change"); /* 사용여부 */
        
    	if(ifSystem == 'BizboxA'){
    		// 자체예산의 경우 
    		$('#txtCardName').removeAttr('disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : true });
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerName').attr('disabled', 'disabled');
    	}
    	else if(ifSystem == 'iCUBE'){
    		// iCUEBE의 경우. 
    		$('#txtCardName').attr('disabled', 'disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : false });
    		$('#txtPartnerCode').attr('disabled', 'disabled');
            $('#txtPartnerName').attr('disabled', 'disabled');
    	} else if(ifSystem == 'ERPiU'){
    		// ERPiU의 경우. 
    		$('#txtCardName').attr('disabled', 'disabled');
    		$('#txtCardNum').attr('disabled', 'disabled');
    		$("#selUsed").kendoComboBox({ enabled : false });
            $('#txtPartnerCode').removeAttr('disabled');
            $('#txtPartnerName').removeAttr('disabled');
    	}else{
    		// 기타 시스템의 경우
    	}
        
        return;
    }

    /* 버튼클릭 이벤트 - 엑셀다운로드 */
    function fnConfigCardInitEventButton_ConfigCardExcelDownload( param ) {
        alert("<%=BizboxAMessage.getMessage("TX000009615", "서비스 준비중입니다")%>" + '...');
        return;
    }

    /* 버튼클릭 이벤트 - ERP에서가져오기 */
    function fnConfigCardFromErp( param ) {
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000018747", "ERP와 카드정보 연동을 진행할까요?")%>")){
    		return;
    	}
    	
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = $('#selCompany').val();
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoFromErpCopy.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                /* 조회 버튼 클릭이벤트 발생 */
                $('#btnConfigCardSearch').click();
                alert("<%=BizboxAMessage.getMessage("TX000018749", "성공적으로 동기화하였습니다.")%>");
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 버튼클릭 이벤트 - 신규 */
    function fnConfigCardNew( param ) {

    	if(ifSystem == 'BizboxA'){
    		$('#txtCardName').removeAttr('disabled');
            $('#txtCardNum').removeAttr('disabled');
    	} else if(ifSystem == 'iCUBE'){
    	} else if(ifSystem == 'ERPiU'){
    	} else{
    		// 기타 시스템의 경우
    	}

        // 데이터 초기화 진행
        $('#selectedItems_forCmPop').val('');
        $('#hidCardPublic').val('');
        $('#txtCardPublic').val('');
        $('#txtCardCode').val('');
        $('#txtCardName').val('');
        $('#txtCardNum').val('');
        $('#txtPartnerCode').val('');
        $('#txtPartnerName').val('');
        $('#txtCardPublic').val('');
        
        var combobox = $("#selUsed").data("kendoComboBox");
        combobox.value('Y');
        combobox.trigger("change"); /* 사용여부 */
        return;
    }
    /* 버튼클릭 이벤트 - 저장 */
    function fnConfigCardSave( param ) {
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        param.cardCode = $('#txtCardCode').val();
        if (param.cardCode == '') {
            param.cardCode = ($('#txtCardNum').val()).toString().replace(/-/g, '');
        }
        param.cardNum = $('#txtCardNum').val();
        param.cardName = $('#txtCardName').val();
        param.partnerCode = $('#txtPartnerCode').val();
        param.partnerName = $('#txtPartnerName').val();
        param.useYn = $('#selUsed').val();
        param.searchStr = '';
        param.cardPublicJson = ($('#hidCardPublic').val() || '');

        /* 파라미터 검증 부분 */
        if(!param.cardName){
        	$('#txtCardName').focus();
        	alert("<%=BizboxAMessage.getMessage("TX000009613", "카드명을 입력하세요")%>");
        	return;
        }
        if(!param.cardNum){
        	alert("<%=BizboxAMessage.getMessage("TX000018751", "카드번호를 입력하세요")%>");
        	console.log('open org pop');
        	$('#txtCardNum').focus();
        	return;
        }
//         if(param.cardPublicJson.indexOf('"returnObj":[]') > -1 ){
<%--         	alert("<%=BizboxAMessage.getMessage("TX000009611","공개범위를 입력하세요")%>"); --%>
//         	$('#btnOrgChart').click();
//         	return;
//         }
        
        var public_json_str = JSON.parse(($('#hidCardPublic').val() || '{}'));
        var temp = [];

//         if( !public_json_str.returnObj){
<%--         	alert("<%=BizboxAMessage.getMessage("TX000009611","공개범위를 입력하세요")%>"); --%>
//         	$('#btnOrgChart').click();
//         	return ;
//         }
        
		if( public_json_str.returnObj){
	        $.each(public_json_str.returnObj, function( idx, item ) {
	            var cardPublic = {};
	            $.extend(cardPublic, ExCodeCardPublic);
	            cardPublic.compSeq = item.compSeq;
	            cardPublic.cardNum = $('#txtCardNum').val();
	            cardPublic.orgDiv = item.empDeptFlag;
	
	            if (item.empDeptFlag == 'c') {
	                cardPublic.orgId = item.compSeq;
	            } else if (item.empDeptFlag == 'd') {
	                cardPublic.orgId = item.deptSeq;
	            } else if (item.empDeptFlag == 'u') {
	                cardPublic.orgId = item.empSeq;
	            }
	            temp.push(cardPublic);
	        });
		}
        param.cardPublic = JSON.stringify(temp);
        
        /* URL 정의 */
        var url = '';
        var attr = $('#txtCardNum').attr('disabled');
        if (typeof attr !== typeof undefined && attr !== false) {
            url = '<c:url value="/ex/admin/config/CardInfoUpdate.do" />';
        } else {
            url = '<c:url value="/ex/admin/config/CardInfoInsert.do" />';
        }
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : url,
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                // console.log("! [EX] SUCCESS - " + JSON.stringify(data));
                /* 조회 버튼 클릭이벤트 발생 */
                $('#btnConfigCardSearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }
    /* 버튼클릭 이벤트 - 삭제 */
    function fnConfigCardDelete( param ) {
    	if(!confirm("<%=BizboxAMessage.getMessage("TX000015635", "정말 삭제하시겠습니까 ?")%>")){
    		return;
    	}
    	
        /* 변수정의 */
        var param = {};
        $.extend(param, ExCodeCard);
        param.compSeq = "${ViewBag.empInfo.compSeq}";
        param.cardNum = $('#txtCardNum').val();
        /* 서버호출 */
        $.ajax({
            type : 'post',
            url : '<c:url value="/ex/admin/config/CardInfoDelete.do" />',
            datatype : 'json',
            async : true,
            data : param,
            success : function( data ) {
                // console.log("! [EX] SUCCESS - " + JSON.stringify(data));
                /* 조회 버튼 클릭이벤트 발생 */
                $('#btnConfigCardSearch').click();
            },
            error : function( data ) {
                console.log("! [EX] ERROR - " + JSON.stringify(data));
            }
        });
        return;
    }

    /* 버튼클릭 이벤트 - 금융거래처 */
    function fnConfigCardPartnerPop( param ) {
        param = (param || '');
        if( param == ''){ // 공통 코드 팝업 호출
        	var Popresult = fnOpenCodePop({
        		codeType : 'Partner'
        		, callback : 'fnConfigCardPartnerPop'
        		, searchStr : ''
        		, acct_type : ''
        		, search_type : '002'
        		/* ERPiU  "" ( 공백 > 전체 ) / 001 ( 주요 ) / 002 ( 금융 ) / 003 ( 개인 ) / 004 ( 신용 ) / 005 ( 기타 ) */
       			/* iCUBE "" ( 공백 > 전체 ) / 1.일반 / 2.수출 / 3.주민 / 4.기타 / 5.금융기관 / 6.정기예금 / 7.정기적금 / 8.카드사 / 9.신용카드 */
        	});	
        }else{ // 리턴 후 데이터 바인딩
        	$('#txtPartnerCode').val(param.obj.partnerCode);
        	$('#txtPartnerName').val(param.obj.partnerName);
        }
        
        return;
    }

    /* 공통사용 */
    /* 공통사용 - 팝업호출 파라미터 */
    function fnMakePopParam( getParam ) {
        var param = {};
        param.url = '';
        param.title = '';
        param.width = 650;
        param.height = 689;
        param.opener = '1';
        param.parentId = '';
        param.childerenId = '';
        param.getParam = getParam;
        return param;
    }

    /* 공통사용 */
    /* 공통사용 - 공통팝업 콜백 함수 */
    function fnCallbackSel( params ) {
        var returnObj = params.returnObj;
        var length = returnObj.length;
        var showSelectedNames = '';
        var selectedItems = '';

        for (var i = 0; i < length; i++) {
            var item = returnObj[i];
            selectedItems += ',' + item.superKey;
            showSelectedNames += '/' + (item.empName || item.deptName || item.compName);
        }

        selectedItems = selectedItems.substring(1);
        showSelectedNames = showSelectedNames.substring(1);

        // 선택된 아이템 변경
        $('#selectedItems_forCmPop').val(selectedItems);
        // 리턴 객체 저장.
        $('#hidCardPublic').val(JSON.stringify(params));
        // 표기용 선택된 아이템 		
        $('#txtCardPublic').val(showSelectedNames);

        return;
    }
    
  //각 테이블 스크롤 동기화
    function table1Scroll() {
//     	$(".table3 .leftContents").scrollTop($(".table3 .rightContents").scrollTop());
    	$(".table3 .rightHeader").scrollLeft($(".table3 .rightContents").scrollLeft());
    }

</script>

<div id="grid"></div>

<div class="sub_contents_wrap">
	<div class="top_box">
		<dl>
			<dt>${CL.ex_keyWord}</dt>

			<dd>
				<div class="controll_btn p0">
					<input id="txtSearchStr" type="text" style="width: 200px;" />
					<button id="btnConfigCardSearch" class="btn_sc_add">${CL.ex_search}</button>
				</div>
			</dd>
			<dt>${CL.ex_inUseYN}
				<!--사용여부-->
			</dt>
			<dd>
				<input id="selUseYN" style="width: 100px" />
			</dd>
		</dl>
	</div>

	<input type="hidden" id="hidComCD" />
	<!-- 컨트롤박스 -->

	<input type="button" id="searchButton" value="${CL.ex_search}"
		style="display: none;" />


	<div id="" class="controll_btn">
		<button id="btnConfigCardExcelDownload" class="k-button"
			style="display: none;"><%=BizboxAMessage.getMessage("TX000002977", "엑셀")%></button>
		<button id="btnConfigCardFromErp" class="k-button"><%=BizboxAMessage.getMessage("TX000003085", "ERP에서가져오기")%></button>
		<button id="btnConfigCardNew" class="k-button"><%=BizboxAMessage.getMessage("TX000003101", "신규")%></button>
		<button id="btnConfigCardSave" class="k-button">${CL.ex_save}</button>
		<button id="btnConfigCardDelete" class="k-button"><%=BizboxAMessage.getMessage("TX000000424", "삭제")%></button>
	</div>



	<div class="twinbox">
		<table>
			<colgroup>
				<col style="width: 50%;">
					<col width="" />
			</colgroup>
			<tr>
				<td class="twinbox_td">
					<div class="scbg table3 posi_re">
						<span class="scy_head1"></span>
						<div id="" class="com_ta2 ovh rightHeader mr15">
							<table>
								<colgroup>
									<col width="140" />
									<col width="150" />
									<col width="20%" />
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tr>
									<th>${CL.ex_cardNumber}<!--카드번호--></th>
									<th>${CL.ex_cardNm}<!--카드명--></th>
									<th>${CL.ex_financeClient}<!--금융거래처--></th>
									<th>${CL.ex_inUseYN}<!--사용여부--></th>
									<th><span style ='word-break:keep-all;'>${CL.ex_rangeSetCondition}</span> <!--공개범위 설정여부--></th>
								</tr>
							</table>
						</div>
						<div id=""
							class="com_ta2 ova_sc2 bg_lightgray flex_ta rightContents"
							style="height: 500px;" onscroll="table1Scroll()">
							<table id="tblConfigCardList">
							</table>
						</div>
					</div>
				</td>
				<td class="twinbox_td">
					<div class="com_ta">
						<table>
							<colgroup>
								<col width="140" />
								<col width="" />
							</colgroup>
							<tr>
								<th><img
									src="<c:url value='/Images/ico/ico_check01.png' />" alt="" />
									<%=BizboxAMessage.getMessage("TX000000527", "카드명")%></th>
								<td><input id="txtCardName" type="text" style="width: 90%" />
								</td>
							</tr>
							<tr>
								<th><img
									src="<c:url value='/Images/ico/ico_check01.png' />" alt="" />
									${CL.ex_cardNumber}</th>
								<td><input id="txtCardCode" type="hidden" /> <input
									id="txtCardNum" type="text" style="width: 90%" class='card_cep' />
								</td>
							</tr>
							<th>
								<!-- <img src="<c:url value='/Images/ico/ico_check01.png' />" alt="" />-->
								${CL.ex_openTo}
							</th>
							<td><input id="hidCardPublic" type="hidden"
								style="width: 19%" /> <input type="text" id="txtCardPublic"
								style="width: 46%" />
								<div class="controll_btn p0">
									<button id="btnOrgChart"><%=BizboxAMessage.getMessage("TX000000265", "선택")%></button>
									<button id="btnPublicReload" class="reload_btn"></button>
								</div></td>
							</tr>
							<tr>
								<th>${CL.ex_inUseYN}</th>
								<td><input id="selUsed" style="width: 100px" /></td>

							</tr>

							<tr>

								<th class='ERPiU'>${CL.ex_financeClient}</th>
								<td class='ERPiU' colspan="3"><input id="txtPartnerCode"
									type="text" style="width: 25%" readonly="readonly" /> <input
									id="txtPartnerName" type="text" style="width: 45%" />
									<div class="controll_btn p0">
										<button id="btnPartnerPop"><%=BizboxAMessage.getMessage("TX000000265", "선택")%></button>
										<button id="btnPartnerReload" class="reload_btn"></button>
									</div></td>
							</tr>
						</table>
					</div>
				</td>
		</table>
	</div>
</div>
<div id="dialog"></div>
<!-- //sub_contents_wrap -->

<!-- 공통팝업 위한 기능옵션 전달 폼 -->

<form id="frmPop2" name="frmPop2">
	<input type="hidden" name="popUrlStr" id="txt_popup_url" width="800" value="<c:url value='/systemx/orgChart.do' />" /> 
	<input type="hidden" id="devMode_forCmPop" name="devMode" width="500" value="dev" /> 
	<input type="hidden" name="devModeUrl" width="500" value="http://local.duzonnext.com:8080" /> 
	<input type="hidden" id="langCode_forCmPop" name="langCode" width="500" /> 
	<input type="hidden" id="groupSeq_forCmPop" name="groupSeq" width="500" /> 
	<input type="hidden" id="compSeq_forCmPop" name="compSeq" width="500" /> 
	<input type="hidden" id="deptSeq_forCmPop" name="deptSeq" width="500" /> 
	<input type="hidden" id="empSeq_forCmPop" name="empSeq" width="500" /> 
	<input type="hidden" id="compFilter_forCmPop" name="compFilter" width="500" /> 
	<input type="hidden" name="selectMode" width="500" value="ud" /> 
	<input type="hidden" name="selectItem" width="500" value="m" /> 
	<input type="hidden" id="selectedItems_forCmPop" name="selectedItems" width="500" /> 
	<input type="hidden" name="callback" width="500" value="fnCallbackSel"/> 
	<input type="hidden" name="callbackUrl" width="500" value="<c:url value='/html/common/callback/cmmOrgPopCallback.jsp' />" />
</form>



